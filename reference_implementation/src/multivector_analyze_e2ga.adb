
with Ada.Text_IO; use Ada.Text_IO;

with E3GA;
with GA_Maths;
with Multivector_Type_Base;

package body Multivector_Analyze_E2GA is

   procedure Analyze (theAnalysis : in out MV_Analysis; MV : E2GA.Multivector;
                      Flags : Flag_Type := (Flag_Invalid, false);
                      Epsilon : float := Default_Epsilon) is
      use Multivector_Analyze;
      use Multivector_Type_Base;

      MV_X      : E2GA.Multivector := MV;
      MV_Info   : E2GA.MV_Type;
      Analysis  : MV_Analysis;
   begin
      Analysis.M_Flags.Valid := True;
      Analysis.Epsilon := Epsilon;
      Analysis.M_Type.Model_Kind := Multivector_Analyze.Vector_Space;

      if Flags.Dual then
         Put_Line ("Multivector_Analyze_E2GA.Analyze Is Dual.");
         Analysis.M_Flags.Dual := True;
         MV_X := E2GA.Dual (MV_X);
      end if;

      MV_Info:= E2GA.Init (MV_X, Epsilon);
      Analysis.M_MV_Type := MV_Info;
      Analysis.M_Type.Multivector_Kind := MV_Info.M_Type;
      --  Check for zero blade
      if Analysis.M_MV_Type.M_Zero then
         Put_Line ("Multivector_Analyze_E2GA.Analyze Zero_Blade.");
         Analysis.M_Type.Blade_Class := Zero_Blade;
         Analysis.M_Scalors (1) := 0.0;
      elsif Analysis.M_MV_Type.M_Type = Versor_Object then
         Put_Line ("Multivector_Analyze_E2GA.Analyze Versor_Object 2.");
         Analysis.M_Type.Blade_Subclass := Even_Versor_Subclass;
         Analysis.M_Vectors (1) := E3GA.e1;

         if MV_X.Coordinates (1) < 0.0 then
            Analysis.M_Vectors (2) := E3GA.e2;
         else
            declare
               use E3GA;
            begin
               Analysis.M_Vectors (2) := -E3GA.e2;
            end;
         end if;

         Analysis.M_Vectors (2) := E3GA.e1;
         Analysis.M_Scalors (1) := E2GA.Get_Coord (E2GA.Norm_E2 (MV_X));
         Analysis.M_Scalors (2) := 2.0 * GA_Maths.Float_Functions.Arctan
             (E2GA.Get_Coord (E2GA.Norm_E2 (MV_X)), MV_X.Coordinates (1));

      elsif Analysis.M_MV_Type.M_Type = Blade_Object then
         Put_Line ("Multivector_Analyze_E2GA.Analyze Blade_Object.");
         Analysis.M_Type.M_Grade := Analysis.M_MV_Type.M_Grade;
         Analysis.M_Scalors (1) := E2GA.Get_Coord (E2GA.Norm_E (MV_X));
         if Analysis.M_Type.MV_Subtype = Vector_Type then
            declare
               use E3GA;
               Xn  : E2GA.Vector;
            begin
               Xn := E2GA.Unit_E (MV_X);
               Analysis.M_Vectors (1) := E2GA.Get_Coord_1 (Xn) * E3GA.e1 +
                                         E2GA.Get_Coord_2 (Xn) * E3GA.e2 ;
            end;
         elsif Analysis.M_Type.MV_Subtype = Bivector_Type then
            Put_Line ("Multivector_Analyze_E2GA.Analyze Bivector_Type.");
            Analysis.M_Vectors (1) := E3GA.e1;
            declare
               use E3GA;
            begin
               if E2GA.Set_Bivector (MV_X).Coordinates (1) < 0.0 then
                  Analysis.M_Vectors (2) := -E3GA.e2;
               else
                  Analysis.M_Vectors (2) := E3GA.e2;
               end if;
            end;
         end if;
      else
         Put_Line ("Multivector_Analyze_E2GA.Analyze Multivector Type.");
      end if;
   end Analyze;

end Multivector_Analyze_E2GA;
