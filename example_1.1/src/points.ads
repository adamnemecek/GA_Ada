
with C3GA;
with E3GA;
with Multivectors;

package Points is
   use C3GA;
   type Normalized_Points_Array is array (integer range <>) of Normalized_Point;
   Num_Points : constant Integer := 6;

   Point_Data : constant Normalized_Points_Array (1 .. Num_Points) :=
                    (Set_Normalized_Point (-0.356756, -0.881980, 0.0),
                     Set_Normalized_Point (-0.725786,  0.934177, -0.366154),
                     Set_Normalized_Point (2.612482, 1.495455, -2.704073),
                     Set_Normalized_Point (2.218644, 0.425753, -1.780935),
                     Set_Normalized_Point (0.865897, 0.629159, -1.438985),
                     Set_Normalized_Point (2.846445, -1.112365, -0.366769));

   Line_Point_Index   : Integer := 1;
   Circle_Point_Index : Integer := 3;
   Plane_Point_Index  : Integer := 6;

   n  : constant Multivectors.Vector := E3GA.e2;  --  n is a direction vector
   L1 : constant Normalized_Point := Point_Data (1);
   L2 : constant Normalized_Point := Point_Data (2);

   C1 : constant Normalized_Point := Point_Data (3);
   C2 : constant Normalized_Point := Point_Data (4);
   C3 : constant Normalized_Point := Point_Data (5);

   P1 : constant Normalized_Point := Point_Data (6);

end Points;
