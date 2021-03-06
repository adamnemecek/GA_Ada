
package body GA_Base_Types is

   function "*" (I1, I2 : NI_T) return float is
   begin
      return 0.0;
   end "*";

   --  -------------------------------------------------------------------------

   function "*" (I : NI_T; O : NO_T) return float is
   begin
--        return -I.Inf * O.Origin;
      return -1.0;
   end "*";

   --  -------------------------------------------------------------------------

   function "*" (O : NO_T; I : NI_T) return float is
   begin
--        return -I.Inf * O.Origin;
      return -1.0;
   end "*";

   --  -------------------------------------------------------------------------

   function "*" (O1, O2 : NO_T) return float is
   begin
      return 0.0;
   end "*";

   --  -------------------------------------------------------------------------

   function NI return float is
   begin
      return 1.0;
   end NI;

   --  ------------------------------------------------------------------------

   function NI (N : NI_T) return float is
   begin
      return N.Inf;
   end NI;

   --  ------------------------------------------------------------------------

   function NO return float is
   begin
      return 1.0;
   end NO;

   --  ------------------------------------------------------------------------

   function NO (N : NO_T) return float is
   begin
      return N.Origin;
   end NO;

   --  ------------------------------------------------------------------------

   procedure Set_NI  (N : out NI_T; Inf : float) is
   begin
      N.Inf := Inf;
   end Set_NI;

   --  -------------------------------------------------------------------------

   procedure Set_NO  (N : out NO_T; Origin : float) is
   begin
      N.Origin := Origin;
   end Set_NO;

   --  -------------------------------------------------------------------------

end GA_Base_Types;
