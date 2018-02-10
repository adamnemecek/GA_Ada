
with GA_Maths;
with Multivectors;
with Multivector_Type;

package GA_Utilities is
   use GA_Maths.Float_Array_Package;
    type Scale_Array is new GA_Maths.Float_Vector;

   function Factorize_Blade (MV : Multivectors.Multivector; Scale : out Scale_Array)
                             return Multivectors.Multivector_List;
   procedure Print_Matrix (Name : String; aMatrix : GA_Maths.GA_Matrix3);
   procedure Print_Matrix (Name : String; aMatrix : Real_Matrix);
   procedure Print_Multivector (Name : String; MV : Multivectors.Multivector);
--     procedure Print_Multivector_Info (Name : String; Info : E2GA.MV_Type);
   procedure Print_Multivector_Info (Name : String; Info : Multivector_Type.MV_Type_Record);

end GA_Utilities;
