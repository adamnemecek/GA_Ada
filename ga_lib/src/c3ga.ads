
with GA_Base_Types;
with GA_Maths;

with E3GA;
with Multivector;
with Multivector_Type_Base;

package C3GA is

   type Vector_E3GA is private;

   subtype MV_Type is Multivector_Type_Base.MV_Typebase;

--     subtype Circle_Coords is E2GA.Coords_Continuous_Array (1 .. 10);
--     subtype Dual_Plane_Coords is E2GA.Coords_Continuous_Array (1 .. 4);
--     subtype Line_Coords is E2GA.Coords_Continuous_Array (1 .. 6);
--     subtype Sphere_Coords is E2GA.Coords_Continuous_Array (1 .. 5);

   --  user constants
   --	__ni_ct__ ni; declared in c3ga.cpp infinitiy
   --	__no_ct__ no; declared in c3ga.cpp origin

   type Circle is private;
   type Dual_Plane is private;
   type Line is private;
   type Point is private;  -- 5D conformal null vector
   type Scalar is private;
   type Sphere is private;
   type Vector is private;

--     type Normalized_Point is private;
   subtype Normalized_Point is Multivector.Multivector;

--     type Multivector (Grade_Use : GA_Maths.Grade_Usage) is record
--        Coordinates : GA_Maths.MV_Coordinate_Array := (others => 0.0);  --  m_c[32]
--     end record;

   --  Joinable grade definitions
   Grade_0 : constant integer := 1;
   Grade_1 : constant integer := 2;
   Grade_2 : constant integer := 4;
   Grade_3 : constant integer := 8;
   Grade_4 : constant integer := 16;
   Grade_5 : constant integer := 32;

   function C3GA_Point (V : Vector_E3GA) return Normalized_Point;
   function Coord (S : Scalar) return float;
--     function Init (MV : Multivector.Multivector; Epsilon : float:= 0.0) return MV_Type;

   function e1 return Multivector.Multivector;
   function e2 return Multivector.Multivector;
   function e3 return Multivector.Multivector;
   function ni return Multivector.Multivector;
   function no return Multivector.Multivector;

   function e1 (MV : Multivector.Multivector) return float;
   function e2 (MV : Multivector.Multivector) return float;
   function e3 (MV : Multivector.Multivector) return float;
   function e1_e2 (MV : Multivector.Multivector) return float;
   function e1_e3 (MV : Multivector.Multivector) return float;
   function e2_e3 (MV : Multivector.Multivector) return float;
   function e1_e2_e3 (MV : Multivector.Multivector) return float;

   function E1_E2_NI (C : Circle) return float;
   function E1_E2_E3 (C : Circle) return float;
   function E2_E3_NI (C : Circle) return float;
   function E3_E1_NI (C : Circle) return float;
   function Get_Coord_1 (V : Vector_E3GA) return float;
   function Get_Coord_2 (V : Vector_E3GA) return float;
   function Get_Coord_3 (V : Vector_E3GA) return float;
   function Get_Coords (V : Vector_E3GA) return GA_Maths.Array_3D;
--     function Get_Coords (NP : Normalized_Point) return Vector;
   function Get_Coords (NP : Normalized_Point)
                        return GA_Maths.Coords_Continuous_Array;
   function NO_E1_E2 (C : Circle) return float;
   function NO_E1_E3 (C : Circle) return float;
   function NO_E1_NI (C : Circle) return float;
   function NO_E2_E3 (C : Circle) return float;
   function NO_E2_NI (C : Circle) return float;
   function NO_E3_NI (C : Circle) return float;

   function E1b (DP : Dual_Plane) return float;
   function E2b (DP : Dual_Plane) return float;
   function E3b (DP : Dual_Plane) return float;
   function NIb (DP : Dual_Plane) return GA_Base_Types.NI_T;

   function E1_E2_NI (L : Line) return float;
   function E1_E3_NI (L : Line) return float;
   function E2_E3_NI (L : Line) return float;
   function E1_NO_NI (L : Line) return float;
   function E2_NO_NI (L : Line) return float;
   function E3_NO_NI (L : Line) return float;

   function NO_E1_E2_E3_NI (MV : Multivector.Multivector) return float;

   function E1b (NP : Normalized_Point) return float;
   function E2b (NP : Normalized_Point) return float;
   function E3b (NP : Normalized_Point) return float;
   function NIb (NP : Normalized_Point) return Float;
   function NOb (NP : Normalized_Point) return Float;

   function E1_E2_E3_NI (S : Sphere) return float;
   function E1_E2_NO_NI (S : Sphere) return float;
   function E1_E3_NO_NI (S : Sphere) return float;
   function E2_E3_NO_NI (S : Sphere) return float;
   function E1_E2_E3_NO (S : Sphere) return float;

--     function Norm_E (MV : Multivector.Multivector) return Scalar;
   function Norm_E2 (V : Vector_E3GA) return Float;

   procedure Set_Coords (P : out Point; Origin, C1, C2, C3, Inf : float);
   procedure Set_Coords (V : out Vector_E3GA; C1, C2, C3 : float);
   function Set_Coords (C1, C2, C3 : float) return Vector_E3GA;
--     procedure Set_Multivector (MV : out  Multivector.Multivector; NP : Normalized_Point);
--     procedure Set_Multivector (MV : out  Multivector.Multivector; N : GA_Base_Types.NO_T);
--     procedure Set_Multivector (MV : out  Multivector.Multivector; N : GA_Base_Types.NI_T);
   function Set_Normalized_Point (E1, E2, E3 : Float; Inf : float := 1.0)
                                  return Normalized_Point;
   function Set_Normalized_Point (Point : GA_Maths.Array_3D;
                                  Inf : float := 1.0)
                                  return Normalized_Point;
--     function Outer_Product (MV1, MV2 : Multivector.Multivector) return Multivector.Multivector;
   function Unit_R (L : Line) return Line;

   --  Underscore functions
--     function US_Normalized_Point (N : Normalized_Point) return Normalized_Point;
--     function US_Set_Normalized_Point (Point : Vector_E3GA) return Normalized_Point;
--     function US_Set_Normalized_Point (E1, E2, E3 : Float) return Normalized_Point;

private

   type Scalar is record
      Coordinates : GA_Maths.Scalar_Coords;  --  m_c[1]
   end record;

   --  Vector_E3GA corresponds to c3ga.vectorE3GA coordinate storage float m_c[3]
   type Vector_E3GA is record
      Coordinates : E3GA.Vector_Coords_3D := (0.0, 0.0, 0.0);   --  m_c[3]
   end record;

   type Circle is record   --  m_c[10]
      E1_E2_NI, E1_E2_E3, E2_E3_NI, E3_E1_NI, NO_E1_E2 : float := 0.0;
      NO_E1_E3, NO_E1_NI, NO_E2_E3, NO_E2_NI, NO_E3_NI : float := 0.0;
   end record;

   type Dual_Plane is record   --  m_c[4]
      E1, E2, E3 : float := 0.0;
      Inf        : GA_Base_Types.NI_T;
   end record;

   type Line is record   --  m_c[6]
      E1_E2_NI, E1_E3_NI, E2_E3_NI : float := 0.0;
      E1_NO_NI, E2_NO_NI, E3_NO_NI : float := 0.0;
   end record;

--     type Normalized_Point is record     --  m_c[4
--        --  Origin             : float := 1.0;      constant
--        E1, E2, E3 : float := 0.0;
--        Inf        : float := 0.0;
--     end record;

   type Point is record   --  m_c[5]
      Origin     : GA_Base_Types.NO_T;
      E1, E2, E3 : float := 0.0;
      Inf        : float := 0.0;
   end record;

   type Sphere is record   --  m_c[5]
      E1_E2_E3_NI, E1_E2_NO_NI, E1_E3_NO_NI : float := 0.0;
      E2_E3_NO_NI, E1_E2_E3_NO              : float := 0.0;
   end record;

   type Vector is new GA_Maths.Coords_Continuous_Array (1 .. 5);

end C3GA;
