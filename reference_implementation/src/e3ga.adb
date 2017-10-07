
with Interfaces;

with E2GA;

package body E3GA is
    use GA_Maths;

    type Array_BM8 is array (E2GA.Bit_Map range 1 .. 8) of integer;

    MV_Space_Dim          : constant Integer := 3;
    MV_Metric_Euclidean   : constant Boolean := True; -- The space's metric is Euclidean
    --  MV_Grade_Size can be used to lookup the number of coordinates for
    --  a grade part of a general multivector
    MV_Grade_Size         : constant Array_I4 := (1, 3, 3, 1);
    --  MV_Size can be used to lookup the number of coordinates based on a grade usage bitmap
    MV_Size               : constant array (1 .. 16) of integer :=
                            (0, 1, 3, 4, 3, 4, 6, 7, 1, 2, 4, 5, 4, 5, 7, 8);
    MV_Basis_Vector_Names : constant array (1 .. 3) of string (1 .. 2) :=
                              ("e1", "e2", "e3");
    --  MV_Basis_Elements contains the order of basis elements in the general multivector
    MV_Basis_Elements : constant array (1 .. 8, 1 .. 4) of integer :=
                       ((-1, 0, 0, 0),
                        (0, -1, 0, 0),
                        (1, -1, 0, 0),
                        (2, -1, 0, 0),
                        (0, 1, -1, 0),
                        (1, 2, -1, 0),
                        (0, 2, -1, 0),
                        (0, 1, 2, -1));
    --  This array contains the 'sign' (even/odd permutation of the canonical order)
    --  of basis elements in the general multivector.
    --  This answers 'what is the permutation of the coordinate at index [x]'?
    MV_Basis_Element_Sign_By_Index : constant Array_F8 :=
                            (1.0, 1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0);
    --  This answers 'what is the permutation of the coordinate at bitmap [x]'?
    MV_Basis_Element_Sign_By_Bitmap : constant Array_F8 :=
                            (1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 1.0);
    --  This answers 'at what index is the basis element [x] (x = basis vector bitmap)'?
    MV_Basis_Element_Index_By_Bitmap : constant Array_BM8 :=
                            (0, 1, 2, 4, 3, 6, 5, 7);
    --  This answers 'at what index is the basis element [x] (x = basis vector bitmap)'?
    MV_Basis_Element_Bitmap_By_Index : constant Array_I8 :=
                             (0, 1, 2, 4, 3, 6, 5, 7);
    --  This answers 'at what is the grade of basis element bitmap [x]'?
    MV_Basis_Element_Grade_By_Bitmap : constant Array_BM8 :=
                            (0, 1, 1, 2, 1, 2, 2, 3);

    e1_basis : Array_3D := (1.0, 0.0, 0.0);
    e2_basis : Array_3D := (0.0, 1.0, 0.0);
    e3_basis : Array_3D := (0.0, 0.0, 1.0);

    --  ------------------------------------------------------------------------

    function "*" (Weight : float; BV : Bivector) return Bivector is
    begin
        return (BV.Grade_Use, Weight * BV.C1_e1e2, Weight * BV.C2_e2e3, Weight * BV.C3_e3e1);
    end "*";

    --  ------------------------------------------------------------------------

    function "*" (R1, R2 : Rotor) return Rotor is
    begin
        return (R1.C1_Scalar * R2.C1_Scalar, R1.C2_e1e2 * R2.C2_e1e2,
                R1.C3_e2e3 * R2.C3_e2e3, R1.C4_e3e1 * R2.C4_e3e1);
    end "*";

    --  ------------------------------------------------------------------------

    function "*" (R : Rotor; V : Vector) return Rotor is
    begin
        return (R.C1_Scalar, R.C2_e1e2 * Get_Coord_1 (V),
                R.C3_e2e3 * Get_Coord_2 (V), R.C4_e3e1 * Get_Coord_3 (V));
    end "*";

    --  ------------------------------------------------------------------------

    function "*" (V : Vector; R : Rotor) return Rotor is
    begin
        return (R.C1_Scalar, Get_Coord_1 (V) * R.C2_e1e2,
                Get_Coord_2 (V) * R.C3_e2e3, Get_Coord_3 (V) * R.C4_e3e1);
    end "*";

    --  ------------------------------------------------------------------------

    function "/" (R : Rotor; S : float) return Rotor is
    begin
        return (R.C1_Scalar / S,  R.C2_e1e2 / S, R.C3_e2e3 / S, R.C4_e3e1 / S);
    end "/";

    --  ------------------------------------------------------------------------

    function "+" (W : float; BV : Bivector) return Rotor is
    begin
        return (W, BV.C1_e1e2, BV.C2_e2e3, BV.C3_e3e1);
    end "+";

    --  ------------------------------------------------------------------------

    function "+" (W : float; R : Rotor) return Rotor is
    begin
        return (W + R.C1_Scalar, R.C2_e1e2, R.C3_e2e3, R.C4_e3e1);
    end "+";

    --  ------------------------------------------------------------------------

    function "-" (W : float; R : Rotor) return Rotor is
    begin
        return (W - R.C1_Scalar, R.C2_e1e2, R.C3_e2e3, R.C4_e3e1);
    end "-";

   --  ------------------------------------------------------------------------

   function Apply_Outermorphism (OM : Outermorphism; BV : Bivector) return Bivector is
      OM_Coords : Array_19F := Get_Outermorphism (OM);
   begin
      return (BV.Grade_Use,
              OM_Coords (11) * BV.C2_e2e3 + OM_Coords (12) * BV.C3_e3e1 + OM_Coords (10) * BV.C1_e1e2,
              OM_Coords (13) * BV.C1_e1e2 + OM_Coords (15) * BV.C3_e3e1 + OM_Coords (14) * BV.C2_e2e3,
              OM_Coords (16) * BV.C1_e1e2 + OM_Coords (17) * BV.C2_e2e3 + OM_Coords (18) * BV.C3_e3e1);
   end Apply_Outermorphism;

    --  ------------------------------------------------------------------------

   function Apply_Outermorphism (OM : Outermorphism; V : Vector) return Vector is
      VV        : Array_3D := GA_Maths.Get_Coords (V);
      OM_Coords : Array_19F := Get_Outermorphism (OM);
      Result    : Vector;
   begin
      Set_Coords (Result,
              OM_Coords (3) * VV (3) + OM_Coords (2) * VV (2)  + OM_Coords (1) * VV (1),
              OM_Coords (5) * VV (2) + OM_Coords (4) * VV (1) + OM_Coords (6) * VV (3),
              OM_Coords (8) * VV (2) + OM_Coords (7) * VV (1) + OM_Coords (9) * VV (3));
      return Result;
   end Apply_Outermorphism;

    --  ------------------------------------------------------------------------

    function BV_String (BV : Bivector; Text : String := "")
                        return Ada.Strings.Unbounded.Unbounded_String is
        use Interfaces;
        use Ada.Strings.Unbounded;
        num : GA_Maths.Fixed_4;
        theString : Unbounded_String :=
                      Ada.Strings.Unbounded.To_Unbounded_String (Text);
    begin
      --  Print coordinates
      for i in 1 .. 3 loop
         if (Unsigned_32 (BV.Grade_Use) and Shift_Left (1, i - 1)) /= 0 then
            case i is
                when 1 => num := GA_Maths.Fixed_4 (BV.C1_e1e2);
                        theString := theString & Fixed_4'Image (num)  & " e1^e2 ";
                when 2 => num := GA_Maths.Fixed_4 (BV.C2_e2e3);
                        theString := theString & Fixed_4'Image (num)  & " e2^e3 ";
                when 3 => num := GA_Maths.Fixed_4 (BV.C3_e3e1);
                        theString := theString & Fixed_4'Image (num)  & " e3^e1";
            end case;
         end if;
      end loop;
      return theString;
    end BV_String;

   --  -------------------------------------------------------------------------

    function Dot_Product (BV1, BV2 : BiVector) return float is
    begin
        return BV1.C1_e1e2 * BV2.C1_e1e2 + BV1.C2_e2e3 * BV2.C2_e2e3 +
          BV1.C3_e3e1 * BV2.C3_e3e1;
    end Dot_Product;

    --  ------------------------------------------------------------------------

    function Dot_Product (R1, R2 : Rotor) return float is
    begin
        return R1.C1_Scalar * R2.C1_Scalar + R1.C2_e1e2 * R2.C2_e1e2 +
          R1.C3_e2e3 * R2.C3_e2e3 + R1.C4_e3e1 * R2.C4_e3e1;
    end Dot_Product;

    --  ------------------------------------------------------------------------

    function e1 (V : GA_Maths.Vector_2D) return float is
    begin
        return Get_Coord_1 (V);
    end e1;

    --  ------------------------------------------------------------------------

    function e2 (V : GA_Maths.Vector_2D) return float is
    begin
        return Get_Coord_2 (V);
    end e2;

    --  ------------------------------------------------------------------------

    function e1 return Vector is
        V : Vector;
    begin
        Set_Coords (V, e1_basis (1), e1_basis (2), e1_basis (3));
        return V;
    end e1;

    --  ----------------------------------------------------------------------------

    function e2 return Vector is
        V : Vector;
    begin
        Set_Coords (V, e2_basis (1), e2_basis (2), e2_basis (3));
        return V;
    end e2;

    --  ------------------------------------------------------------------------

    function e3 return Vector is
        V : Vector;
    begin
        Set_Coords (V, e3_basis (1), e3_basis (2), e3_basis (3));
        return V;
    end e3;

    --  ------------------------------------------------------------------------

    function e1e2 (R : Rotor) return float is
    begin
        return R.C2_e1e2;
    end e1e2;

    --  ------------------------------------------------------------------------

    function e2e3 (R : Rotor) return float is
    begin
          return R.C3_e2e3;
    end e2e3;

    --  ------------------------------------------------------------------------

    function e3e1 (R : Rotor) return float is
    begin
          return R.C4_e3e1;
    end e3e1;

    --  ------------------------------------------------------------------------

    function R_Scalar (R : Rotor) return float is
    begin
          return R.C1_Scalar;
    end R_Scalar;

    --  ------------------------------------------------------------------------

    function Geometric_Product (V1, V2 : Vector) return Rotor is
        V1C : Array_3D := Get_Coords (V1);
        V2C : Array_3D := Get_Coords (V2);
    begin
        return (V1C (1) * V2C (1) + V1C (2) * V2C (2) + V1C (3) * V2C (3),
                -V1C (2) * V2C (1) + V1C (1) * V2C (2),
                V1C (2) * V2C (3) - V1C (2) * V2C (2),
                -V1C (1) * V2C (3) + V1C (3) * V2C (1));
    end Geometric_Product;

    --  ------------------------------------------------------------------------

    function Geometric_Product (BV : Bivector; R : Rotor) return Rotor is
    begin
        return (-BV.C2_e2e3 * R.C3_e2e3 - BV.C3_e3e1 * R.C4_e3e1 - BV.C1_e1e2 * R.C2_e1e2,
                BV.C1_e1e2 * R.C1_Scalar - BV.C2_e2e3 * R.C4_e3e1 + BV.C3_e3e1 * R.C3_e2e3,
                BV.C1_e1e2 * R.C4_e3e1 - BV.C3_e3e1 * R.C2_e1e2 + BV.C2_e2e3 * R.C1_Scalar,
                BV.C2_e2e3 * R.C2_e1e2 + BV.C3_e3e1 * R.C1_Scalar - BV.C1_e1e2 * R.C3_e2e3);
    end Geometric_Product;

    --  ------------------------------------------------------------------------

    function Geometric_Product (R : Rotor; BV : Bivector) return Rotor is
    begin
        return (-R.C3_e2e3 * BV.C2_e2e3 - R.C2_e1e2 * BV.C1_e1e2 - R.C4_e3e1 * BV.C3_e3e1,
                -R.C3_e2e3 * BV.C3_e3e1 + R.C1_Scalar * BV.C1_e1e2 + R.C4_e3e1 * BV.C2_e2e3,
                R.C1_Scalar * BV.C2_e2e3 -  R.C4_e3e1 * BV.C1_e1e2 + R.C2_e1e2 * BV.C3_e3e1,
                R.C1_Scalar * BV.C3_e3e1 + R.C3_e2e3 * BV.C1_e1e2 - R.C2_e1e2 * BV.C2_e2e3);
    end Geometric_Product;

    --  ------------------------------------------------------------------------

    function Geometric_Product (R : Rotor; V : Vector) return Syn_SMultivector is
        VC : Array_3D := Get_Coords (V);
    begin
        return (R.C2_e1e2 * VC (2) - R.C4_e3e1 * VC (3) + R.C1_Scalar * VC (1),
                -R.C2_e1e2 * VC (1) + R.C3_e2e3 * VC (3) + R.C1_Scalar * VC (2),
                R.C1_Scalar * VC (3) + R.C4_e3e1 * VC (1) - R.C3_e2e3 * VC (2),
                R.C2_e1e2 * VC (3) + R.C4_e3e1 * VC (2) + R.C3_e2e3 * VC (1));
    end Geometric_Product;

    --  ------------------------------------------------------------------------

   function Geometric_Product (R1, R2 : Rotor) return Rotor is
   begin
        return (-R1.C2_e1e2 * R2.C2_e1e2 - R1.C3_e2e3 * R2.C3_e2e3 - R1.C4_e3e1 * R2.C4_e3e1 + R1.C1_Scalar * R2.C1_Scalar,
                -R1.C3_e2e3 * R2.C4_e3e1 + R1.C2_e1e2 * R2.C1_Scalar + R1.C4_e3e1 * R2.C3_e2e3 + R1.C1_Scalar * R2.C2_e1e2,
                -R1.C4_e3e1 * R2.C2_e1e2 + R1.C1_Scalar * R2.C3_e2e3 - R1.C2_e1e2 * R2.C4_e3e1 + R1.C3_e2e3 * R2.C1_Scalar,
                -R1.C2_e1e2 * R2.C3_e2e3 + R1.C3_e2e3 * R2.C2_e1e2 + R1.C4_e3e1 * R2.C1_Scalar + R1.C1_Scalar * R2.C4_e3e1);
   end Geometric_Product;

    --  ------------------------------------------------------------------------

    function Geometric_Product (R : Rotor; MV : Syn_SMultivector) return Syn_SMultivector is
    begin
        return (-R.C4_e3e1 * MV.C3_e3 + R.C2_e1e2 * MV.C2_e2 + R.C1_Scalar * MV.C1_e1 - R.C3_e2e3 * MV.C4_e1e2e3,
                R.C3_e2e3 * MV.C3_e3 - R.C4_e3e1 * MV.C4_e1e2e3 + R.C1_Scalar * MV.C2_e2 - R.C2_e1e2 * MV.C1_e1,
                R.C4_e3e1 * MV.C1_e1 - R.C3_e2e3 * MV.C2_e2 - R.C2_e1e2 * MV.C4_e1e2e3 + R.C1_Scalar * MV.C3_e3,
                R.C3_e2e3 * MV.C1_e1 + R.C1_Scalar * MV.C3_e3 + R.C4_e3e1 * MV.C2_e2 + R.C2_e1e2 * MV.C3_e3);
    end Geometric_Product;

    --  ------------------------------------------------------------------------

    function Geometric_Product (V : Vector; MV : Syn_SMultivector) return Rotor is
        VC : Array_3D := Get_Coords (V);
    begin
        return (VC (1) * MV.C1_e1 + VC (2) * MV.C2_e2 + VC (3) * MV.C3_e3,
                VC (1) * MV.C2_e2 + VC (3) * MV.C4_e1e2e3 - VC (2) * MV.C1_e1,
                -VC (3) * MV.C2_e2 + VC (1) * MV.C4_e1e2e3 + VC (2) * MV.C3_e3,
                VC (2) * MV.C4_e1e2e3 + VC (3) * MV.C1_e1 - VC (1) * MV.C3_e3);
    end Geometric_Product;

    --  ------------------------------------------------------------------------

    function Geometric_Product (V : Vector; R : Rotor) return Syn_SMultivector is
        VC : Array_3D := Get_Coords (V);
    begin
        return (VC (3) * R.C4_e3e1 + VC (1) * R.C1_Scalar - VC (2) * R.C2_e1e2,
                -VC (3) * R.C3_e2e3 + VC (2) * R.C1_Scalar + VC (1) * R.C2_e1e2,
                VC (2) * R.C3_e2e3 - VC (1) * R.C4_e3e1 + VC (3) * R.C1_Scalar,
                VC (1) * R.C3_e2e3 + VC (3) * R.C2_e1e2 + VC (2) * R.C4_e3e1);
    end Geometric_Product;

    --  ------------------------------------------------------------------------

    function Get_Coords (BV : Bivector) return Array_3D is
    begin
        return (BV.C1_e1e2, BV.C2_e2e3, BV.C3_e3e1);
    end Get_Coords;

    --  ------------------------------------------------------------------------

   function Get_Coords (R : Rotor) return Array_4D is
   begin
        return (R.C1_Scalar, R.C2_e1e2, R.C3_e2e3, R.C4_e3e1);
   end Get_Coords;

    --  ------------------------------------------------------------------------

   function Get_Coords (SMV : Syn_SMultivector) return Array_4D is
   begin
        return (SMV.C1_e1, SMV.C2_e2, SMV.C3_e3, SMV.C4_e1e2e3);
   end Get_Coords;

    --  ------------------------------------------------------------------------

   function Get_Outermorphism (OM : Outermorphism) return Array_19F is
   begin
        return Array_19F (OM);
   end Get_Outermorphism;

    --  ------------------------------------------------------------------------

    function Grade_Use (BV : Bivector) return GA_Maths.Unsigned_Integer  is
    begin
        return BV.Grade_Use;
    end Grade_Use;

    --  ------------------------------------------------------------------------

    function Grade_Use (MV : Multivector) return GA_Maths.Unsigned_Integer  is
    begin
        return MV.Grade_Use;
    end Grade_Use;

    --  ------------------------------------------------------------------------

    function Inverse (aRotor : Rotor) return Rotor is
        Norm_Inv  : Scalar;
    begin
        Norm_Inv := 1.0 / Dot_Product (aRotor, aRotor);
        return  (Norm_Inv * aRotor.C1_Scalar, -Norm_Inv * aRotor.C2_e1e2,
                 -Norm_Inv * aRotor.C3_e2e3, -Norm_Inv * aRotor.C4_e3e1);
    end Inverse;

    --  ------------------------------------------------------------------------

    function Inverse (V : Vector) return Vector is
        Norm_Inv  : Scalar := 1.0 / Dot_Product (V, V);
        VC  : GA_Maths.Array_3D := Get_Coords (V);
        Result : Vector;
    begin
        Set_Coords (Result, Norm_Inv * VC (1), Norm_Inv * VC (2), Norm_Inv * VC (3));
        return Result;
    end Inverse;

    --  ------------------------------------------------------------------------

    function Left_Contraction (BV1, BV2 : Bivector) return Scalar is
    begin
        return -Dot_Product (BV1, BV2);
    end Left_Contraction;

    --  ------------------------------------------------------------------------

    function Left_Contraction (MV1, MV2 : Multivector) return Multivector is
        Value  : E2GA.Coords_Continuous_Array (1 .. 8) := (others => 0.0);
    begin
        if (MV2.Grade_Use and 1) /= 0 and then
          (MV1.Grade_Use and 1) /= 0 then
            Value (1) := MV1.Coordinates (1) * MV2.Coordinates (1);
        end if;

        if (MV2.Grade_Use and 2) /= 0 then
            if (MV1.Grade_Use and 1) /= 0 then
                Value (2) := MV1.Coordinates (1) * MV2.Coordinates (2);
                Value (3) := MV1.Coordinates (1) * MV2.Coordinates (3);
                Value (4) := MV1.Coordinates (1) * MV2.Coordinates (4);
            end if;
            if (MV1.Grade_Use and 2) /= 0 then
                Value (1) := Value (1) + MV1.Coordinates (2) * MV2.Coordinates (2) +
                  MV1.Coordinates (3) * MV2.Coordinates (3) +
                  MV1.Coordinates (4) * MV2.Coordinates (4);
            end if;
        end if;
        if (MV2.Grade_Use and 4) /= 0 then
            if (MV1.Grade_Use and 1) /= 0 then
                Value (5) := MV1.Coordinates (1) * MV2.Coordinates (5);
                Value (6) := MV1.Coordinates (1) * MV2.Coordinates (6);
                Value (7) := MV1.Coordinates (1) * MV2.Coordinates (7);
            end if;
            if (MV1.Grade_Use and 2) /= 0 then
                Value (2) := Value (2) - MV1.Coordinates (3) * MV2.Coordinates (5)
                  + MV1.Coordinates (4) * MV2.Coordinates (7);
                Value (3) := Value (3) - MV1.Coordinates (4) * MV2.Coordinates (6)
                  + MV1.Coordinates (2) * MV2.Coordinates (5);
            end if;
            if (MV1.Grade_Use and 4) /= 0 then
                Value (1) := Value (1) - MV1.Coordinates (5) * MV2.Coordinates (5)
                  - MV1.Coordinates (6) * MV2.Coordinates (6)
                  - MV1.Coordinates (7) * MV2.Coordinates (7);
            end if;
        end if;
        if (MV2.Grade_Use and 8) /= 0 then
            if (MV1.Grade_Use and 1) /= 0 then
                Value (8) := MV1.Coordinates (1) * MV2.Coordinates (8);
            end if;
            if (MV1.Grade_Use and 2) /= 0 then
                Value (5) := Value (5) + MV1.Coordinates (4) * MV2.Coordinates (8);
                Value (6) := Value (6) + MV1.Coordinates (2) * MV2.Coordinates (8);
                Value (7) := Value (7) + MV1.Coordinates (3) * MV2.Coordinates (8);
            end if;
            if (MV1.Grade_Use and 4) /= 0 then
                Value (1) := Value (1) - MV1.Coordinates (6) * MV2.Coordinates (8)
                  - MV1.Coordinates (7) * MV2.Coordinates (8)
                  - MV1.Coordinates (5) * MV2.Coordinates (8);
            end if;
        end if;
        if (MV1.Grade_Use and 8) /= 0 then
            Value (1) := Value (1) - MV1.Coordinates (8) * MV2.Coordinates (8);
        end if;
        return (8, MV1.Grade_Use, Value);
    end Left_Contraction;

    --  ------------------------------------------------------------------------

    function Left_Contraction (V : Vector; BV : Bivector) return Vector is
        BC  : GA_Maths.Array_3D := Get_Coords (BV);
        VC  : GA_Maths.Array_3D := Get_Coords (V);
        LC  : Vector;
    begin
        Set_Coords (LC, -VC (2) * BC (1) + VC (3) * BC (3),
                    VC (1) * BC (1) - VC (3) * BC (2),
                    -VC (1) * BC (3) + VC (2) * BC (2));
        Return LC;
    end Left_Contraction;

    --  ------------------------------------------------------------------------

    function Left_Contraction (V1 : Vector; V2 : Vector) return Scalar is
    begin
        Return Scalar (Dot_Product (V1, V2));
    end Left_Contraction;

    --  ------------------------------------------------------------------------

   function MV_String (MV : Multivector; Text : String := "") return
                       Ada.Strings.Unbounded.Unbounded_String is
      use Interfaces;
      use Ada.Strings.Unbounded;
      Std_Idx   : Integer := 0;
      Buffer    : Unbounded_String := To_Unbounded_String (Text);
      Float_Buf : Unbounded_String := To_Unbounded_String ("");
      Grade_Use : Unsigned_32 := Unsigned_32 (MV.Grade_Use);
      Coord      : float;
      ia         : integer := 1;
      bei        : integer;
      k          : integer := 1;
      Count      : integer := 0;
   begin
      --  Print all coordinates
      for i in 0 .. 3 loop
         if (Grade_Use and Shift_Left (1, i)) /= 0 then
            for j in 1 .. MV_Grade_Size (i + 1) loop
               Coord := MV_Basis_Element_Sign_By_Index (ia) * MV.Coordinates (k);
               --  goal: print [+|-]obj.m_c[k][* basisVector1 ^ ... ^ basisVectorN]
               Float_Buf := To_Unbounded_String (float'Image (Abs (Coord)));
               if Abs (Coord) /= 0.0 then
                  if Coord < 1.0 and Count = 0 then
                    Buffer := Buffer & " - ";
                  end if;
                  Buffer := Buffer & Float_Buf;

                  if ia /= 0 then
                     Buffer := Buffer & "*";
                     bei := 0;
                     while MV_Basis_Elements (ia, bei) >= 0 loop
                        if bei /= 0 then
                            Buffer := Buffer & "^";
                        end if;
                        Buffer := Buffer &
                             MV_Basis_Vector_Names (MV_Basis_Elements (ia, bei) + 1);
                        bei := bei + 1;
                     end loop;
                     Count := Count + 1;
                  end if;
                  k := k + 1;
                   ia := ia + 1;
               elsif ia < 8 - MV_Grade_Size (i) then
                  ia := ia + MV_Grade_Size (i);
               end if;
            end loop;
            if Count = 0 then
                Buffer := Buffer & "0";
            end if;
         end if;
      end loop;
      return Buffer;
   end MV_String;

   --  ------------------------------------------------------------------------

    function Norm_E2 (V : Vector) return Scalar is
        Coords : Array_3D := Get_Coords (V);
    begin
        return Scalar (Coords (1) * Coords (1) + Coords (2) * Coords (2) +
                  Coords (3) * Coords (3));
    end Norm_E2;

    --  ------------------------------------------------------------------------

    function Norm_E2 (BV : Bivector) return Scalar is
    begin
        return Scalar (BV.C1_e1e2 * BV.C1_e1e2 + BV.C2_e2e3 * BV.C2_e2e3 +
                       BV.C3_e3e1 * BV.C3_e3e1);
    end Norm_E2;

    --  ------------------------------------------------------------------------

    function Norm_E2 (MV : E2GA.Multivector) return Scalar is
        Value  : float := 0.0;
    begin
        if (MV.Grade_Use and 1) /= 0 then
            Value := MV.Coordinates (1) * MV.Coordinates (1);
        end if;
        if (MV.Grade_Use and 2) /= 0 then
            Value := Value + MV.Coordinates (2) * MV.Coordinates (2) +
              MV.Coordinates (3) * MV.Coordinates (3);
        end if;
        if (MV.Grade_Use and 4) /= 0 then
            Value := Value + MV.Coordinates (4) * MV.Coordinates (4) +
              MV.Coordinates (5) * MV.Coordinates (5) +
              MV.Coordinates (6) * MV.Coordinates (6);
        end if;
        if (MV.Grade_Use and 8) /= 0 then
            Value := Value + MV.Coordinates (9) * MV.Coordinates (9);
        end if;
        return Scalar (Value);
    end Norm_E2;

    --  ------------------------------------------------------------------------

    function Norm_E2 (R : Rotor) return Scalar is
    begin
        return Scalar (R.C2_e1e2 * R.C2_e1e2 + R.C3_e2e3 * R.C3_e2e3 +
                    R.C4_e3e1 * R.C4_e3e1);
    end Norm_E2;

    --  ------------------------------------------------------------------------

    function Norm_E2 (TV : Trivector) return Scalar is
    begin
        return Scalar (TV * TV);
    end Norm_E2;

    --  ------------------------------------------------------------------------

    function Norm_R (BV : Bivector) return Scalar is
        use GA_Maths.Float_Functions;
        DP     : Scalar := Dot_Product (BV, BV);
        Result : Scalar := 0.0;
    begin
        if DP /= 0.0 then
            if DP < 0.0 then
                Result := -Sqrt (-DP);
            else
                Result := Sqrt (DP);
            end if;
        end if;
        return Result;
    end Norm_R;

    --  ------------------------------------------------------------------------

    function Norm_R2 (BV : Bivector) return Scalar is
    begin
        return Dot_Product (BV, BV);
    end Norm_R2;

    --  ------------------------------------------------------------------------

    function Outer_Product (V1, V2 : Vector) return Bivector is
        use Float_Array_Package;
        use GA_Maths;
        VC1  : array_3D := Get_Coords (V1);
        VC2  : array_3D := Get_Coords (V2);
        Result : Bivector;
    begin
        Set_Bivector (Result, VC1 (1) * VC2 (2) - VC1 (2) * VC2 (1),
                              VC1 (2) * VC2 (3) - VC1 (3) * VC2 (2),
                              VC1 (3) * VC2 (1) - VC1 (1) * VC2 (3));
        return Result;
    end Outer_Product;

    --  ------------------------------------------------------------------------

    function Scalar_Product (V1, V2 : Vector) return Scalar is
    begin
        return  Scalar (Dot_Product (V1, V2));
    end Scalar_Product;

    --  ------------------------------------------------------------------------

    procedure Set_Bivector (BV : out Bivector; C1, C2, C3 : float) is
    begin
        BV.C1_e1e2 := C1;
        BV.C2_e2e3 := C2;
        BV.C3_e3e1 := C3;
    end Set_Bivector;

    --  ------------------------------------------------------------------------

    procedure Set_Rotor (X : out Rotor; BV : Bivector) is
    begin
        X := (1.0, BV.C1_e1e2, BV.C2_e2e3, BV.C3_e3e1);
    end Set_Rotor;

    --  ------------------------------------------------------------------------

    procedure Set_Rotor (X : out Rotor; C_Scalar : float; BV : Bivector) is
    begin
        X := (C_Scalar, BV.C1_e1e2, BV.C2_e2e3, BV.C3_e3e1);
    end Set_Rotor;

    --  ------------------------------------------------------------------------

    procedure Set_Rotor (X : out Rotor; MV : Multivector) is
    begin
        X := (MV.Coordinates (1),
              MV.Coordinates (2), MV.Coordinates (3), MV.Coordinates (4));
    end Set_Rotor;

    --  ------------------------------------------------------------------------

    procedure Set_Rotor (X : out Rotor; C_Scalar : float) is
    begin
        X := (C_Scalar, 0.0, 0.0, 0.0);
    end Set_Rotor;

    --  ------------------------------------------------------------------------

    procedure Set_Rotor (X : out Rotor; C_Scalar, C2, C3, C4 : float) is
    begin
        X := (C_Scalar, C2, C3, C4);
    end Set_Rotor;

   --  ------------------------------------------------------------------------

   function To_Vector (MV : Syn_SMultivector) return Vector is
        V : Vector;
   begin
        Set_Coords (V, MV.C1_e1, MV.C2_e2, MV.C3_e3);
        return V;
   end To_Vector;

    --  ------------------------------------------------------------------------
    --  Unit_e normalizes rotor R
    function Unit_e (R : Rotor) return Rotor is
        R2         : float;
        Scale      : float;
        Norm_Rotor : Rotor;
    begin
        R2 := R.C1_Scalar * R.C1_Scalar + R.C2_e1e2 * R.C2_e1e2 +
              R.C3_e2e3 * R.C3_e2e3 + R.C4_e3e1 * R.C4_e3e1;
        Scale := 1.0 / (Float_Functions.Sqrt (R2));

        Set_Rotor (Norm_Rotor, R.C1_Scalar * Scale, R.C2_e1e2 * Scale,
                   R.C3_e2e3 * Scale, R.C4_e3e1 * Scale);
        return Norm_Rotor;
    end Unit_E;

    --  ------------------------------------------------------------------------
    --  Unit_e normalizes vector X
    function Unit_e (X : Vector) return Vector is
        Scale      : float;
        New_Vector : Vector;
    begin
        Scale := Float_Functions.Sqrt (Dot_Product (X, X));
        Set_Coords (New_Vector, Get_Coord_1 (X) / Scale,
                    Get_Coord_2 (X) / Scale, Get_Coord_3 (X) / Scale);
        return New_Vector;
    end Unit_E;

    --  ------------------------------------------------------------------------

end E3GA;