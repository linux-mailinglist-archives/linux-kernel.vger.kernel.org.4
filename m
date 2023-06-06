Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B0D724316
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjFFMwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjFFMwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:52:03 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF771731;
        Tue,  6 Jun 2023 05:51:29 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686055851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPlrY3WjDY7pFW/27RY/fg0u0Ufgp/HpEKChnaNVaNo=;
        b=WtSRmpezbXnrGJhJIzu7g1Jf7sUfirjn2Sx/wTtuHm+1CFCn0L8nfIoZU1LeRZgY387uDi
        EfWWXvnWDucY3AsQaXso6txoCy/SNcy8eUwu73eUwE3o+pqdg9yC3DpKyisoAemNUVUoHS
        y834jecnDNCTIdmEDxCioxJZ4GgZG8gOy3SqCArK3YEaEqX/OYti1UI3RaeZ3c+hPyGbtL
        ZYrKf79UvScvA8tJ4zXXLg2g8uKvZO8Mnu9r/uJ4byT8lWHSIVvRZxbGBLWCivNPJtwFPM
        vszTHIETNYRH6txrFEQaln3FlAz9j39pJEZFG3i4LkhyQTcmZtYg7KXSlHl26g==
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6719DC0006;
        Tue,  6 Jun 2023 12:50:47 +0000 (UTC)
Date:   Tue, 6 Jun 2023 14:50:46 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Message-ID: <20230606145046.7181bfae@pc-7.home>
In-Reply-To: <ZH8N+GtRFcDV4eaI@shell.armlinux.org.uk>
References: <20230606064914.134945-1-maxime.chevallier@bootlin.com>
        <20230606064914.134945-2-maxime.chevallier@bootlin.com>
        <889297a0-88c3-90df-7752-efa00184859@linux-m68k.org>
        <ZH78uGBfeHjI4Cdn@shell.armlinux.org.uk>
        <20230606121311.3cc5aa78@pc-7.home>
        <ZH8JxF+TNuX0C1vC@shell.armlinux.org.uk>
        <CAMuHMdWnqmwT_rEe5G4e+yZYAeTQxjjE=Xqq7R6No9SAF16sdg@mail.gmail.com>
        <ZH8N+GtRFcDV4eaI@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 11:44:08 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Jun 06, 2023 at 12:35:23PM +0200, Geert Uytterhoeven wrote:
> > Hi Russell,
> >   
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index fa07b0d50b46..1801f8cc8413 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -940,9 +940,6 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
> > >         if (priv->hw->xpcs)
> > >                 return &priv->hw->xpcs->pcs;
> > >
> > > -       if (priv->hw->lynx_pcs)
> > > -               return priv->hw->lynx_pcs;
> > > -
> > >         return NULL;
> > >  }  
> > 
> > I think the above hunk is wrong, and should be replaced by a removal
> > of the call to lynx_pcs_destroy()?  
> 
> Indeed, and wrong file too. Thanks for spotting, I think we spotted
> the mistake at almost the same time. Replacement patch sent.
> 
> It'd be good to have the patch thoroughly reviewed to make sure I
> haven't missed anything else, bearing in mind that I don't know this
> driver inside out and don't have the hardware.

I will give it a try righ-away,

Thanks,

Maxime

> Thanks.
> 

