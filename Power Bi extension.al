pageextension 50202 PowerBiDoughnutExt extends "Help And Chart Wrapper"
{
    caption = 'Customer Sales Doughnut';
    layout
    {
        addlast(content)
        {
            usercontrol(Chart; "Microsoft.Dynamics.Nav.client.BusinessChart")
            {
                ApplicationArea = All;
                trigger AddInReady()
                var
                    Buffer: Record "Business Chart Buffer" temporary;
                    Customer: Record Customer;
                    i: Integer;
                begin
                    Buffer.Initialize();
                    Buffer.AddMeasure('Sales', 1, Buffer."Data Type"::Decimal, Buffer."Chart Type"::Doughnut);

                    Buffer.SetXAxis('Customer', Buffer."Data Type"::String);

                    if Customer.FindSet(false, false) then
                        repeat
                            Customer.CalcFields("Sales (LCY)");
                            if Customer."Sales (LCY)" <> 0 then begin
                                Buffer.AddColumn(Customer.Name);
                                Buffer.SetValueByIndex(0, i, Customer."Sales (LCY)");

                                i += 1;
                            end;
                        until Customer.Next() = 0;

                    Buffer.Update(CurrPage.Chart);
                end;

            }
        }

    }


}