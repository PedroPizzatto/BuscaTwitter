<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AcessoTwitter.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Busca Twitter</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:table runat="server" ID="tabela">
                <asp:TableRow>
                    <asp:TableCell><h1><b>Busca no Twitter</b></h1></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="Label2" runat="server" Text="Últimas palavras buscadas:" ></asp:Label>
                        <asp:Label ID="lstBusca" runat="server" ></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Button ID="btnLimpar" runat="server" Text="Limpar histórico de buscas" OnClick="btnLimpar_Click" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:table>
            <asp:table runat="server">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="Label1" runat="server" Text="Digite uma palavra para buscar no Twitter:"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtPalavra" runat="server"></asp:TextBox>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="Label3" runat="server" Text="Ex: #neymar"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="btnPesquisar" runat="server" Text="Pesquisar" OnClick="btnPesquisar_Click" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:table>
        </div>
        <br />
        <div>
            <asp:ListView ID="ListView1" runat="server">
                <LayoutTemplate> 
                    <table id="Table1" runat="server" class="TableCSS"> 
                        <tr id="Tr1" runat="server" class="TableHeader"> 
                            <td id="Td1" runat="server"><b>Imagem</b></td> 
                            <td id="Td2" runat="server"><b>Nome</b></td> 
                            <td id="Td3" runat="server"><b>Últimos 5 Tweets</b></td> 
                        </tr> 
                        <tr id="ItemPlaceholder" runat="server"> 
                        </tr> 
                    </table> 
                </LayoutTemplate>
                <ItemTemplate>
                  <tr>
                   <td><asp:Image runat="server" ID="img" ImageUrl='<%#Eval("User.ProfileImageURL") %>' ></asp:Image></td>
                   <td><asp:Label runat="server" ID="lblName"><%#Eval("User.ScreenNameResponse")%></asp:Label></td>
                   <td><asp:Label runat="server" ID="lblDesc"><%#Eval("Text") %></asp:Label></td>
                  </tr>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </form>
</body>
</html>
