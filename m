Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1F66F319B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjEANpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjEANp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:45:28 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C545CA2;
        Mon,  1 May 2023 06:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=c+vS2Pd2DvQfPZeVaKf+njPaaTs83J8Nmdu/A6o2QKY=; b=XJ8ZMRn7ien/NQfy6SB4RPOTUK
        WS68URGTvfIAYfbcdqXOIz43HDfDVId8zrGwy/IoSX0Oo4j1TfDq2Cs4arPoueGIHZL5zL46NPT3V
        lQT3WrSu7CTySxmDNMHSyOgE2aF9rwOCSFcwqU75UcPJNFPfIFJEgoaU0+InUpTOp3gA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:53580 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1ptTq7-0004aK-AX; Mon, 01 May 2023 09:45:15 -0400
Date:   Mon, 1 May 2023 09:45:14 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230501094514.38acbacc7f596226f04dc504@hugovil.com>
In-Reply-To: <88a7cf9e-89a5-7860-2219-337aee04e75e@linaro.org>
References: <20230427195639.2718734-1-hugo@hugovil.com>
        <88a7cf9e-89a5-7860-2219-337aee04e75e@linaro.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] imx8mn-var-som: dts: add SOM EEPROM
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 15:06:22 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 27/04/2023 21:56, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > 
> > The 4Kbit EEPROM located on the SOM contains hardware configuration
> > options, manufacturing infos and ethernet MAC address.
> 
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
> 
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
> > index 9052b0d4b5b4..3ed396f41e46 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
> > @@ -30,6 +30,10 @@ reg_eth_phy: regulator-eth-phy {
> >  		gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>;
> >  		enable-active-high;
> >  	};
> > +
> > +	aliases {
> 
> Keep nodes ordered.
> 
> > +		eeprom_som = &eeprom_som;
> 
> That's no valid alias. Which upstream kernel driver makes use of this?

Is "eeprom-som" ok?

No driver uses it for now..

Hugo.

> 
> > +	};
> >  };
> >  
> 
> Best regards,
> Krzysztof
> 
> 


-- 
Hugo Villeneuve
