Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1367F723FD9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjFFKmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbjFFKmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:42:04 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386A210E4;
        Tue,  6 Jun 2023 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=klQyBW+EVKyIsuT8ceA9jlZizSQdtGWXnKsVgnySEDY=; b=1wRvIU8G2nMubJPt48iYnhphbU
        oLCH8nh/13RTGHFFwP7K6gwZaqtDKdgmLWdPv/74wb3h9ol5FOyxlQg1ccufhr2/W3sqfuUy3AMGy
        v7nJ9MzUaHsJKBjp2cbtx9InKPFdsK2xykpcJd3/RZIdzPg2e5INlWndR0cZsCHM2IBXCShrXQT/U
        NYc7dsi/EMLIa/VOIFm3K0RR0BIjtGMYjjzEhDU4Kkg0BeGsde6DLUk3hAZ7gnMWjySiqajqdwVbL
        9Sl+Mz8IhzhJN12Ts6fS+M1zbLXcWzA3rKqoPStfJ4ipkipgkzZte4KxhR4QTz+788oaG/2s+J6vc
        oj6TGoTg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57734)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q6U6u-0005VC-6o; Tue, 06 Jun 2023 11:40:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q6U6r-00074o-Pr; Tue, 06 Jun 2023 11:40:17 +0100
Date:   Tue, 6 Jun 2023 11:40:17 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 1/2] net: stmmac: Add PCS_LYNX as a dependency
 for the whole driver
Message-ID: <ZH8NEW3bDwAoACfg@shell.armlinux.org.uk>
References: <20230606064914.134945-1-maxime.chevallier@bootlin.com>
 <20230606064914.134945-2-maxime.chevallier@bootlin.com>
 <889297a0-88c3-90df-7752-efa00184859@linux-m68k.org>
 <ZH78uGBfeHjI4Cdn@shell.armlinux.org.uk>
 <20230606121311.3cc5aa78@pc-7.home>
 <ZH8JxF+TNuX0C1vC@shell.armlinux.org.uk>
 <ZH8LxGIvHd+B1eNm@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH8LxGIvHd+B1eNm@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 11:34:44AM +0100, Russell King (Oracle) wrote:
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index fa07b0d50b46..1801f8cc8413 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -940,9 +940,6 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
> >  	if (priv->hw->xpcs)
> >  		return &priv->hw->xpcs->pcs;
> >  
> > -	if (priv->hw->lynx_pcs)
> > -		return priv->hw->lynx_pcs;
> > -
> 
> This hunk is completely wrong... but I guess you spotted that anyway.

Replacement...

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index e399fccbafe5..239c7e9ed41d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -494,6 +494,17 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void socfpga_dwmac_remove(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct phylink_pcs *pcs = priv->hw->lynx_pcs;
+
+	stmmac_pltfr_remove(pdev);
+
+	lynx_pcs_destroy(pcs);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int socfpga_dwmac_resume(struct device *dev)
 {
@@ -565,7 +576,7 @@ MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);
 
 static struct platform_driver socfpga_dwmac_driver = {
 	.probe  = socfpga_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = socfpga_dwmac_remove,
 	.driver = {
 		.name           = "socfpga-dwmac",
 		.pm		= &socfpga_dwmac_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index c784a6731f08..3db1cb0fd160 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -665,9 +665,6 @@ int stmmac_mdio_unregister(struct net_device *ndev)
 	if (priv->hw->xpcs)
 		xpcs_destroy(priv->hw->xpcs);
 
-	if (priv->hw->lynx_pcs)
-		lynx_pcs_destroy(priv->hw->lynx_pcs);
-
 	mdiobus_unregister(priv->mii);
 	priv->mii->priv = NULL;
 	mdiobus_free(priv->mii);

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
