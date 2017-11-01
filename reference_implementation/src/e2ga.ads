
with Ada.Strings.Unbounded;

with GA_Maths;
with Multivector_Type_Base;

package E2GA is

   --  Vector_2D corresponds to e2ga.Vector_3D coordinate storage float m_c[2]
   type Vector_2D is private;

   --     type Coords3_Array is array (integer range <>) of Vector;
   type Coords_Continuous_Array is array (integer range <>) of float;
   subtype Bivector_Coords is Coords_Continuous_Array (1 .. 1);

   --  Joinable grade definitions
   type Grade is (Grade_0, Grade_1, Grade_2);

   --  Outermorphism types
   type OM_Type is (OMT_None, OMT_OM, OMT_Last);

   type Bit_Map is new integer range 0 .. 2 ** 30;
   type Bit_Map_Array is array (integer range <>) of Bit_Map;

   subtype MV_Type is Multivector_Type_Base.M_Type_Type; --  m_mvType

   type Coords_4 is record
      Coord_1 : float;
      Coord_2 : float;
      Coord_3 : float;
      Coord_4 : float;
   end record;

   type E2_Bit_Map is new integer range 0 .. 4;

   type E2_Type is record
      Coord_1 : float;
      Coord_2 : float;
   end record;

   --  Multivector types
   type G2_Type is (MVT_None, MVT_E1_T, MVT_E2_T, MVT_Scalar, MVT_Vector,
                    MVT_Bivector, MVT_Rotor, MVT_E1_CT, MVT_E2_CT,
                    MVT_I2_CT, MVT_I2I_CT, MVT_MV, MVT_Last);

   type Scalar is new float;

   type Rotor_Class is record
      M_C1 : float := 0.0;
      M_C2 : float := 0.0;
   end record;

   --  The outer product of P vectors is called a grade P multivector or a P-vector
   --  In E2, MV = u^v = det(u,v)e1^e2. This "bivector" is the only MV in E2.
   type Multivector (MV_Size : integer; Grade_Use : GA_Maths.Grade_Usage) is record
      Coordinates : Coords_Continuous_Array (1 .. MV_Size);   --  m_c[4]
   end record;

   subtype Scalar_MV is Multivector (1, 1);
   subtype Vector_MV is Multivector (2, 2);
   subtype Bivector_MV is Multivector (1, 4);
   subtype Rotor is Multivector (2, 5);

   function "+" (V1, V2 : Vector_2D) return Vector_2D;
   function "-" (V1, V2 : Vector_2D) return Vector_2D;
   function "*" (Weight : float; V : Vector_2D) return Vector_2D;
   function "*" (V1, V2 : Vector_2D) return Vector_2D;
   function "+" (MV1, MV2 : Multivector) return Multivector;

   function Bivector_String (BV : E2GA.Bivector_MV; Text : String := "") return String;
   function Construct_Vector (Coord : float) return Vector_MV;
   function Construct_Vector (Coord_1,  Coord_2 : float) return Vector_MV;
   function Dot_Product (V1, V2 : Vector_2D) return float;
   function Dot_Product (R1, R2 : Rotor) return float;
   function Dual (MV : Multivector) return Multivector;
   function e1 return Vector_2D;
   function e2 return Vector_2d;
   function Get_Coord_1 (V : Vector_2D) return float;
   function Get_Coord_2 (V : Vector_2D) return float;
   function Largest_Basis_Blade (Map : Bit_Map) return float;
   function Largest_Coordinate return float;
   function Magnitude (V : Vector_2D) return float;
   function Multivector_String (MV : Multivector; Text : String := "") return String;
   function Norm_E (MV : Multivector) return Scalar_MV;
   --     function Norm_E2 (BV : Bivector) return Scalar;
   --     function Norm_E2 (V2 : Vector) return Scalar;
   function Norm_E2 (MV : Multivector) return Scalar_MV;
   function Geometric_Product (MV1, MV2 : Multivector) return Multivector;
   function Grade_Use (MV : Multivector) return GA_Maths.Unsigned_Integer;
   function Init_MV_Type (MV : Multivector; Epsilon : float) return MV_Type;
   function Left_Contraction (V1, V2 : Vector_2D) return Scalar_MV;
   function Left_Contraction (V : Vector_MV; BV : Bivector_MV) return Vector_MV;
   function Outer_Product (V1, V2 : Vector_2D) return Bivector_MV;
   function Scalar_Product (V1, V2 : Vector_2D) return Scalar_MV;
   function Set_Bivector (V1, V2 : Vector_2D) return Bivector_MV;
   procedure Set_Coords (V : out Vector_2D; C1, C2 : float);
   function Set_Rotor (E1_E2 : float) return Rotor;
   function Unit_E (V : Vector_MV) return Vector_MV;
   function Set_Vector (V1 : Vector_2D) return Vector_MV;

private

   --  Vector_2D corresponds to e2ga.vector coordinate storage float m_c[2]
   type Vector_2D is array (1 .. 2) of float;

end E2GA;
