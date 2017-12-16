
package body C3GA is

   function "*" (L : Line; S : Float) return Line is
   begin
      return (L.E1_E2_NI * S, L.E1_E3_NI * S, L.E2_E3_NI * S,
              L.E1_NO_NI * S, L.E2_NO_NI * S, L.E3_NO_NI * S);
   end  "*";

   --  -------------------------------------------------------------------------

   function "*" (S : Float; L : Line) return Line is
   begin
      return L * S;
   end  "*";

   --  -------------------------------------------------------------------------

   function E1_E2_NI (C : Circle) return float is
   begin
      return C.E1_E2_NI;
   end E1_E2_NI;

   --  -------------------------------------------------------------------------

   function E3_E1_NI (C : Circle) return float is
   begin
      return C.E3_E1_NI;
   end E3_E1_NI;

   --  -------------------------------------------------------------------------

   function E1_E2_E3 (C : Circle) return float is
   begin
      return C.E1_E2_E3;
   end E1_E2_E3;

   --  -------------------------------------------------------------------------

   function E2_E3_NI (C : Circle) return float is
   begin
      return C.E2_E3_NI;
   end E2_E3_NI;

   --  -------------------------------------------------------------------------

   function Get_Coord_1 (V : Vector_E3GA) return float is
   begin
      return V.Coordinates (1);
   end Get_Coord_1;

   --  ------------------------------------------------------------------------

   function Get_Coord_2 (V : Vector_E3GA) return float is
   begin
      return V.Coordinates (2);
   end Get_Coord_2;

   --  ------------------------------------------------------------------------

   function Get_Coord_3 (V : Vector_E3GA) return float is
   begin
      return V.Coordinates (3);
   end Get_Coord_3;

   --  ------------------------------------------------------------------------

   function Get_Coords (V : Vector_E3GA) return GA_Maths.Array_3D is
   begin
      return (V.Coordinates (1), V.Coordinates (2), V.Coordinates (3));
   end Get_Coords;

   --  ------------------------------------------------------------------------

   function NO_E1_E2 (C : Circle) return float is
   begin
      return C.NO_E1_E2;
   end NO_E1_E2;

   --  -------------------------------------------------------------------------

   function NO_E1_E3 (C : Circle) return float is
   begin
      return C.NO_E1_E3;
   end NO_E1_E3;

   --  -------------------------------------------------------------------------

   function NO_E1_NI (C : Circle) return float is
   begin
      return C.NO_E1_NI;
   end NO_E1_NI;

   --  -------------------------------------------------------------------------

   function NO_E2_E3 (C : Circle) return float is
   begin
      return C.NO_E2_E3;
   end NO_E2_E3;

   --  -------------------------------------------------------------------------

   function NO_E2_NI (C : Circle) return float is
   begin
      return C.NO_E2_NI;
   end NO_E2_NI;

   --  -------------------------------------------------------------------------

   function NO_E3_NI (C : Circle) return float is
   begin
      return C.NO_E3_NI;
   end NO_E3_NI;

   --  -------------------------------------------------------------------------

   function E1 (DP : Dual_Plane) return float is
   begin
      return DP.E1;
   end E1;

   --  -------------------------------------------------------------------------

   function E2 (DP : Dual_Plane) return float is
   begin
      return DP.E2;
   end E2;

   --  -------------------------------------------------------------------------

   function E3 (DP : Dual_Plane) return float is
   begin
      return DP.E3;
   end E3;

   --  -------------------------------------------------------------------------

   function NI (DP : Dual_Plane) return float is
   begin
      return DP.NI;
   end NI;

   --  -------------------------------------------------------------------------

   function E1_E2_NI (L : Line) return float is
   begin
      return L.E1_E2_NI;
   end E1_E2_NI;

   --  -------------------------------------------------------------------------

   function E1_E3_NI (L : Line) return float is
   begin
      return L.E1_E3_NI;
   end E1_E3_NI;

   --  -------------------------------------------------------------------------

   function E2_E3_NI (L : Line) return float is
   begin
      return L.E2_E3_NI;
   end E2_E3_NI;

   --  -------------------------------------------------------------------------

   function E1_NO_NI (L : Line) return float is
   begin
      return L.E1_NO_NI;
   end E1_NO_NI;

   --  -------------------------------------------------------------------------

   function E2_NO_NI (L : Line) return float is
   begin
      return L.E2_NO_NI;
   end E2_NO_NI;

   --  -------------------------------------------------------------------------

   function E3_NO_NI (L : Line) return float is
   begin
      return L.E3_NO_NI;
   end E3_NO_NI;

   --  -------------------------------------------------------------------------

   function E1 (NP : Normalized_Point) return float is
   begin
      return NP.E1;
   end E1;

   --  -------------------------------------------------------------------------

   function E2 (NP : Normalized_Point) return float is
   begin
      return NP.E2;
   end E2;

   --  -------------------------------------------------------------------------

   function E3 (NP : Normalized_Point) return float is
   begin
      return NP.E3;
   end E3;

   --  -------------------------------------------------------------------------

   function NI (NP : Normalized_Point) return float is
   begin
      return NP.NI;
   end NI;

   --  -------------------------------------------------------------------------

   function NO (NP : Normalized_Point) return float is
   begin
      return 1.0;
   end NO;

   --  -------------------------------------------------------------------------

   function E1_E2_E3_NI (S : Sphere) return float is
   begin
      return S.E1_E2_E3_NI;
   end E1_E2_E3_NI;

   --  -------------------------------------------------------------------------

   function E1_E2_NO_NI (S : Sphere) return float is
   begin
      return S.E1_E2_NO_NI;
   end E1_E2_NO_NI;

   --  -------------------------------------------------------------------------

   function E1_E3_NO_NI (S : Sphere) return float is
   begin
      return S.E1_E3_NO_NI;
   end E1_E3_NO_NI;

   --  -------------------------------------------------------------------------

   function E2_E3_NO_NI (S : Sphere) return float is
   begin
      return S.E2_E3_NO_NI;
   end E2_E3_NO_NI;

   --  -------------------------------------------------------------------------

   function E1_E2_E3_NO (S : Sphere) return float is
   begin
      return S.E1_E2_E3_NO;
   end E1_E2_E3_NO;

   --  -------------------------------------------------------------------------

   procedure Set_Coords (V : out Vector_E3GA; C1, C2, C3 : float) is
   begin
      V.Coordinates (1) := C1;
      V.Coordinates (2) := C2;
      V.Coordinates (3) := C3;
   end Set_Coords;

   --  -------------------------------------------------------------------------

   function Set_Normalized_Point (E1, E2, E3 : float; NI : float := GA_Maths.NI)
                               return Normalized_Point is
   begin
      return (E1, E2, E3, NI);
   end Set_Normalized_Point;

   --  -------------------------------------------------------------------------

   function Set_Normalized_Point (Point : GA_Maths.Array_3D;
                                  NI : float := GA_Maths.NI)
                               return Normalized_Point is
   begin
      return (Point (1), Point (2), Point (3), NI);
   end Set_Normalized_Point;

   --  -------------------------------------------------------------------------

   function Unit_R (L : Line) return Line is
      use GA_Maths.Float_Functions;
      R_Sq : constant float := -(L.E1_NO_NI * L.E1_NO_NI +
                                   L.E2_NO_NI * L.E2_NO_NI + L.E3_NO_NI * L.E3_NO_NI);
      Inv  : constant float := 1.0 / Sqrt (Abs (R_Sq));
   begin
      return L * Inv;
   end Unit_R;

   --  -------------------------------------------------------------------------

   function US_Normalized_Point (N : Normalized_Point) return Normalized_Point is
      thePoint : Normalized_Point := N;
   begin
      thePoint.NI := 0.0;
      return thePoint;
   end US_Normalized_Point;

   --  -------------------------------------------------------------------------

   function US_Set_Normalized_Point (E1, E2, E3 : Float) return Normalized_Point is
   begin
      return (E1, E2, E3, 0.0);
   end US_Set_Normalized_Point;

   --  -------------------------------------------------------------------------

   function US_Set_Normalized_Point (Point : GA_Maths.Array_3D) return Normalized_Point is
   begin
      return (Point (1), Point (2), Point (3), 0.0);
   end US_Set_Normalized_Point;

   --  -------------------------------------------------------------------------

end C3GA;
