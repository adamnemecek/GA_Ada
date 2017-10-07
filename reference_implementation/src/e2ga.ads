
with Ada.Strings.Unbounded;

with GA_Maths; use GA_Maths;

package E2GA is

   type Coords3_Array is array (integer range <>) of Vector;
   type Coords_Continuous_Array is array (integer range <>) of float;
   subtype Bivector_Coords is Coords_Continuous_Array (1 .. 1);

   type Bit_Map is new integer range 0 .. 2 ** 30;
   type Bit_Map_Array is array (integer range <>) of Bit_Map;

   type Bivector is record
      Grade_Usage : GA_Maths.Grade_Usage := 2; --  m_gu
      e1e2_Coord  : Bivector_Coords; -- Coordinate of e1^e2.
   end record;

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

   --  Joinable grade definitions
   Grade_0 : constant integer := 1;
   Grade_1 : constant integer := 2;
   Grade_2 : constant integer := 4;

   --  Outermorphism types
   type OM_Type is (OMT_None, OMT_OM, OMT_Last);

   type Rotor is record
      M_C1 : float := 0.0;
      M_C2 : float := 0.0;
   end record;

   type Trivector is record
      Grade_Usage     : GA_Maths.Grade_Usage; --  m_gu
      e1e2_Coord_1    : float; -- Coordinate of e1^e2.
      e2e3_Coord_2    : float; -- Coordinate of e2^e3.
      e1e2e3_Coord_3  : float; -- Coordinate of e1^e2^e3.
   end record;

   --  The outer product of P vectors is called a grade P multivector or a P-vector
   --  In E2, MV = u^v = det(u,v)e1^e2. This "bivector" is the only MV in E2.
   type Multivector (MV_Size : integer) is record
      Grade_Use   : GA_Maths.Grade_Usage; --  m_gu
      Coordinates : Coords_Continuous_Array (1 .. MV_Size);   --  m_c[4]
   end record;

   function Bivector_String (BV : E2GA.Bivector; Text : String := "") return String;
   function Construct_Vector (Coord : float) return GA_Maths.Vector_2D;
   function Construct_Vector (Coord_1,  Coord_2 : float) return GA_Maths.Vector_2D;
   function Dot_Product (R1, R2 : Rotor) return float;
   function Dual (MV : Multivector) return Multivector;
   function e1 return GA_Maths.Vector_2D;
   function e2 return GA_Maths.Vector_2D;
   function Largest_Basis_Blade (Map : Bit_Map) return float;
   function Largest_Coordinate return float;
   function Multivector_String (MV : Multivector; Text : String := "") return String;
   function Norm_E (MV : Multivector) return Scalar;
   function Norm_E2 (BV : Bivector) return Scalar;
   function Norm_E2 (V2 : GA_Maths.Vector_2D) return Scalar;
   function Norm_E2 (MV : Multivector) return Scalar;
   function Geometric_Product (MV1, MV2 : Multivector) return Multivector;
   function Grade_Use (MV : Multivector) return GA_Maths.Unsigned_Integer;
   function Left_Contraction (V1, V2 : Vector_2D) return Scalar;
   function Left_Contraction (V1, V2 : Vector) return Scalar;
   function Left_Contraction (V : Vector_2D; BV : Bivector) return Vector_2D;
   function Outer_Product (V1, V2 : Vector_2D) return Bivector;
   function Scalar_Product (V1, V2 : GA_Maths.Vector_2D) return Scalar;
   function Set_Bivector (V1, V2 : Vector_2D) return Bivector;
   function Set_Rotor (E1_E2 : float) return Rotor;
   function Unit_E (V : Vector_2D) return Vector_2D;

end E2GA;