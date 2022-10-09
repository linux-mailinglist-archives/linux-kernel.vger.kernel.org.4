Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C965F8B15
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJIMGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJIMGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9569E25293;
        Sun,  9 Oct 2022 05:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24FBC60AE9;
        Sun,  9 Oct 2022 12:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBA3C433C1;
        Sun,  9 Oct 2022 12:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665317202;
        bh=OJ3iw/to0qrxnfZc3CbrKex6sv4fPlEnIJPCTHljV80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJglaALSLJhVJu1YfdDaKj8hdifajbd9/4fZvoHUZe9bAfb0kFJhEXFHjLqx3brx2
         fC3M1v+2KI1bBCfTHAQWPAK/+/Bx0icixCcQ0HCB1ZkvECZtRLsf4EHyQQG310jkPM
         A2AnMHtBxhzZEAK3nl3AB+s4vhNHEdQkeJhXVF2UK5+cK2H6w/bpVLrmDiXQDXPsMP
         soS88aoU8rN8jLnReKpuaj99xD29L/90897iBvzHRSZsELRdD42+afxIQu5r8ArbaE
         hOuTbVR2cdEyHv8mNPF69uzp4kzonM81vRwf94aMU4XrEPYeCaVwLwlRO+erMdf7TL
         R6csujbpBUHYw==
Received: by pali.im (Postfix)
        id 0B17F7C1; Sun,  9 Oct 2022 14:06:40 +0200 (CEST)
Date:   Sun, 9 Oct 2022 14:06:39 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: Fix compatible strings for Armada
 3720 boards
Message-ID: <20221009120639.hds2nhdynwdzjizr@pali>
References: <20220713125644.3117-1-pali@kernel.org>
 <20220930233802.wjfzk3xkphm565uz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930233802.wjfzk3xkphm565uz@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING

On Saturday 01 October 2022 01:38:02 Pali Rohár wrote:
> Gregory: ping
> 
> On Wednesday 13 July 2022 14:56:44 Pali Rohár wrote:
> > All Armada 3720 boards have Armada 3720 processor which is of Armada 3700
> > family and do not have Armada 3710 processor. So none of them should have
> > compatible string for Armada 3710 processor.
> > 
> > Fix compatible string for all these boards by removing wrong processor
> > string "marvell,armada3710" and adding family string "marvell,armada3700"
> > as the last one. (Note that this is same way how are defined Armada 3710
> > DTS files).
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-3720-db.dts                  | 2 +-
> >  arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts    | 2 +-
> >  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts   | 2 +-
> >  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts | 2 +-
> >  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts      | 2 +-
> >  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts         | 2 +-
> >  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts          | 2 +-
> >  arch/arm64/boot/dts/marvell/armada-372x.dtsi                    | 2 +-
> >  8 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> > index bd4e61d5448e..0cfb38492021 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> > @@ -18,7 +18,7 @@
> >  
> >  / {
> >  	model = "Marvell Armada 3720 Development Board DB-88F3720-DDR3";
> > -	compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
> > +	compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3700";
> >  
> >  	chosen {
> >  		stdout-path = "serial0:115200n8";
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> > index 5c4d8f379704..6715a19c1483 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> > @@ -18,7 +18,7 @@
> >  / {
> >  	model = "Globalscale Marvell ESPRESSOBin Board (eMMC)";
> >  	compatible = "globalscale,espressobin-emmc", "globalscale,espressobin",
> > -		     "marvell,armada3720", "marvell,armada3710";
> > +		     "marvell,armada3720", "marvell,armada3700";
> >  };
> >  
> >  &sdhci0 {
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> > index 070725b81be5..447760b69850 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> > @@ -13,7 +13,7 @@
> >  / {
> >  	model = "Globalscale Marvell ESPRESSOBin Ultra Board";
> >  	compatible = "globalscale,espressobin-ultra", "marvell,armada3720",
> > -		     "marvell,armada3710";
> > +		     "marvell,armada3700";
> >  
> >  	aliases {
> >  		/* ethernet1 is WAN port */
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> > index 75401eab4d42..2a8aa3901a9f 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> > @@ -19,7 +19,7 @@
> >  	model = "Globalscale Marvell ESPRESSOBin Board V7 (eMMC)";
> >  	compatible = "globalscale,espressobin-v7-emmc", "globalscale,espressobin-v7",
> >  		     "globalscale,espressobin", "marvell,armada3720",
> > -		     "marvell,armada3710";
> > +		     "marvell,armada3700";
> >  
> >  	aliases {
> >  		/* ethernet1 is wan port */
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> > index 48a7f50fb427..b03af87611a9 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> > @@ -18,7 +18,7 @@
> >  / {
> >  	model = "Globalscale Marvell ESPRESSOBin Board V7";
> >  	compatible = "globalscale,espressobin-v7", "globalscale,espressobin",
> > -		     "marvell,armada3720", "marvell,armada3710";
> > +		     "marvell,armada3720", "marvell,armada3700";
> >  
> >  	aliases {
> >  		/* ethernet1 is wan port */
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> > index 1542d836c090..c5a834b33b77 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> > @@ -16,5 +16,5 @@
> >  
> >  / {
> >  	model = "Globalscale Marvell ESPRESSOBin Board";
> > -	compatible = "globalscale,espressobin", "marvell,armada3720", "marvell,armada3710";
> > +	compatible = "globalscale,espressobin", "marvell,armada3720", "marvell,armada3700";
> >  };
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > index caf9c8529fca..5840ed129309 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > @@ -14,7 +14,7 @@
> >  / {
> >  	model = "CZ.NIC Turris Mox Board";
> >  	compatible = "cznic,turris-mox", "marvell,armada3720",
> > -		     "marvell,armada3710";
> > +		     "marvell,armada3700";
> >  
> >  	aliases {
> >  		spi0 = &spi0;
> > diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > index 5ce55bdbb995..02ae1e153288 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > @@ -13,7 +13,7 @@
> >  
> >  / {
> >  	model = "Marvell Armada 3720 SoC";
> > -	compatible = "marvell,armada3720", "marvell,armada3710";
> > +	compatible = "marvell,armada3720", "marvell,armada3700";
> >  
> >  	cpus {
> >  		cpu1: cpu@1 {
> > -- 
> > 2.20.1
> > 
