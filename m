Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4696723FF8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbjFFKq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjFFKqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:46:19 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BFF18E;
        Tue,  6 Jun 2023 03:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ioAQcLHmFe5lShDUAfyfXBw7PEQ13xYiSgOqhDs0xDo=; b=bk5CItPE2XxteW8CONPDrQoKne
        Njhw4e9GGxXqsJaMSzMU0RuGa/1oG3eKoMLeT1jYmUQ1iqQy4uEul+HXWDSWhoQIKMQlvj4fClfDW
        vHEXJifq3ecdxI38YesU/kxoJCCBteV0d1dCIG+j/sUF/QhMhEeL+YcXaBH3jRK5Zh5aCi9AuiKo1
        +//ZpfzNX0GT30XCVQhcRonJaKddPG9kgbdttsolWGkcgjBzC3lO9BQ2OZvjxzLIj7StI95tebPz4
        g8m8MquDOFiU1aQ29l7IIYZsjao+XxKXlbz9r0BhbnqMwMsDcAqi8XevXq8SGTHr7O+UZ3Qpi/QQF
        5e4K2lsg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48520)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q6UAd-0005Vy-Pi; Tue, 06 Jun 2023 11:44:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q6UAa-000751-Ly; Tue, 06 Jun 2023 11:44:08 +0100
Date:   Tue, 6 Jun 2023 11:44:08 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexis.lothore@bootlin.com,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <ZH8N+GtRFcDV4eaI@shell.armlinux.org.uk>
References: <20230606064914.134945-1-maxime.chevallier@bootlin.com>
 <20230606064914.134945-2-maxime.chevallier@bootlin.com>
 <889297a0-88c3-90df-7752-efa00184859@linux-m68k.org>
 <ZH78uGBfeHjI4Cdn@shell.armlinux.org.uk>
 <20230606121311.3cc5aa78@pc-7.home>
 <ZH8JxF+TNuX0C1vC@shell.armlinux.org.uk>
 <CAMuHMdWnqmwT_rEe5G4e+yZYAeTQxjjE=Xqq7R6No9SAF16sdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWnqmwT_rEe5G4e+yZYAeTQxjjE=Xqq7R6No9SAF16sdg@mail.gmail.com>
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

On Tue, Jun 06, 2023 at 12:35:23PM +0200, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index fa07b0d50b46..1801f8cc8413 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -940,9 +940,6 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
> >         if (priv->hw->xpcs)
> >                 return &priv->hw->xpcs->pcs;
> >
> > -       if (priv->hw->lynx_pcs)
> > -               return priv->hw->lynx_pcs;
> > -
> >         return NULL;
> >  }
> 
> I think the above hunk is wrong, and should be replaced by a removal
> of the call to lynx_pcs_destroy()?

Indeed, and wrong file too. Thanks for spotting, I think we spotted
the mistake at almost the same time. Replacement patch sent.

It'd be good to have the patch thoroughly reviewed to make sure I
haven't missed anything else, bearing in mind that I don't know this
driver inside out and don't have the hardware.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
