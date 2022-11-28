Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E13963B14D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiK1S3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiK1S3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:29:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E2B46659;
        Mon, 28 Nov 2022 10:21:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF94F6135C;
        Mon, 28 Nov 2022 18:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69C6C433C1;
        Mon, 28 Nov 2022 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669659690;
        bh=XZR+bdBLa31SFnDfyt292HJe7zyYgxSOd1IfBl/d01I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQL7EMcDFqxi1uexdKrstmMLT7M4SL7TS8XKdy9y/2epno+g8dP3K0dJtWJZCVprS
         PifbHIdLLvKPkjrzNGozPLXHM1dBloB3DTC+b+YaoFnsjfmO3n2PmSVUYBDOA+xfAT
         OKlylUBDc/X8mRYSIjoaJ5FmR+VgOyVdia5Ku1ttFsxgtnH92pUWFwcXKvkaqddUyU
         Tj02QQJBhdo1fZpFvaZ6K45LlARQ3tEfkTEScQWdGzfDnqWlI5fr37Z9rtrCL/EkTY
         RYmdl0BKwJtwKQa+y7P2prGAUtVjNHW8zjxmW6e6R0Q/+LOSSTGx6Mz2OYtBidPEpj
         bfei5gKwN8Mrg==
Received: by pali.im (Postfix)
        id 6354787A; Mon, 28 Nov 2022 19:21:27 +0100 (CET)
Date:   Mon, 28 Nov 2022 19:21:27 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: Fix compatible strings for Armada
 3720 boards
Message-ID: <20221128182127.jq6255cwa44lnmxv@pali>
References: <20220713125644.3117-1-pali@kernel.org>
 <20220930233802.wjfzk3xkphm565uz@pali>
 <20221009120639.hds2nhdynwdzjizr@pali>
 <20221101224457.vyraefpfyphvnv4p@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101224457.vyraefpfyphvnv4p@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Tuesday 01 November 2022 23:44:57 Pali Rohár wrote:
> PING?
> 
> On Sunday 09 October 2022 14:06:39 Pali Rohár wrote:
> > PING
> > 
> > On Saturday 01 October 2022 01:38:02 Pali Rohár wrote:
> > > Gregory: ping
> > > 
> > > On Wednesday 13 July 2022 14:56:44 Pali Rohár wrote:
> > > > All Armada 3720 boards have Armada 3720 processor which is of Armada 3700
> > > > family and do not have Armada 3710 processor. So none of them should have
> > > > compatible string for Armada 3710 processor.
> > > > 
> > > > Fix compatible string for all these boards by removing wrong processor
> > > > string "marvell,armada3710" and adding family string "marvell,armada3700"
> > > > as the last one. (Note that this is same way how are defined Armada 3710
> > > > DTS files).
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > ---
> > > >  arch/arm64/boot/dts/marvell/armada-3720-db.dts                  | 2 +-
> > > >  arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts    | 2 +-
> > > >  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts   | 2 +-
> > > >  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts | 2 +-
> > > >  arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts      | 2 +-
> > > >  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts         | 2 +-
> > > >  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts          | 2 +-
> > > >  arch/arm64/boot/dts/marvell/armada-372x.dtsi                    | 2 +-
> > > >  8 files changed, 8 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> > > > index bd4e61d5448e..0cfb38492021 100644
> > > > --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> > > > +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> > > > @@ -18,7 +18,7 @@
> > > >  
> > > >  / {
> > > >  	model = "Marvell Armada 3720 Development Board DB-88F3720-DDR3";
> > > > -	compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
> > > > +	compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3700";
> > > >  
> > > >  	chosen {
> > > >  		stdout-path = "serial0:115200n8";
> > > > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> > > > index 5c4d8f379704..6715a19c1483 100644
> > > > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> > > > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> > > > @@ -18,7 +18,7 @@
> > > >  / {
> > > >  	model = "Globalscale Marvell ESPRESSOBin Board (eMMC)";
> > > >  	compatible = "globalscale,espressobin-emmc", "globalscale,espressobin",
> > > > -		     "marvell,armada3720", "marvell,armada3710";
> > > > +		     "marvell,armada3720", "marvell,armada3700";
> > > >  };
> > > >  
> > > >  &sdhci0 {
> > > > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> > > > index 070725b81be5..447760b69850 100644
> > > > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> > > > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> > > > @@ -13,7 +13,7 @@
> > > >  / {
> > > >  	model = "Globalscale Marvell ESPRESSOBin Ultra Board";
> > > >  	compatible = "globalscale,espressobin-ultra", "marvell,armada3720",
> > > > -		     "marvell,armada3710";
> > > > +		     "marvell,armada3700";
> > > >  
> > > >  	aliases {
> > > >  		/* ethernet1 is WAN port */
> > > > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> > > > index 75401eab4d42..2a8aa3901a9f 100644
> > > > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> > > > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> > > > @@ -19,7 +19,7 @@
> > > >  	model = "Globalscale Marvell ESPRESSOBin Board V7 (eMMC)";
> > > >  	compatible = "globalscale,espressobin-v7-emmc", "globalscale,espressobin-v7",
> > > >  		     "globalscale,espressobin", "marvell,armada3720",
> > > > -		     "marvell,armada3710";
> > > > +		     "marvell,armada3700";
> > > >  
> > > >  	aliases {
> > > >  		/* ethernet1 is wan port */
> > > > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> > > > index 48a7f50fb427..b03af87611a9 100644
> > > > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> > > > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> > > > @@ -18,7 +18,7 @@
> > > >  / {
> > > >  	model = "Globalscale Marvell ESPRESSOBin Board V7";
> > > >  	compatible = "globalscale,espressobin-v7", "globalscale,espressobin",
> > > > -		     "marvell,armada3720", "marvell,armada3710";
> > > > +		     "marvell,armada3720", "marvell,armada3700";
> > > >  
> > > >  	aliases {
> > > >  		/* ethernet1 is wan port */
> > > > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> > > > index 1542d836c090..c5a834b33b77 100644
> > > > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> > > > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> > > > @@ -16,5 +16,5 @@
> > > >  
> > > >  / {
> > > >  	model = "Globalscale Marvell ESPRESSOBin Board";
> > > > -	compatible = "globalscale,espressobin", "marvell,armada3720", "marvell,armada3710";
> > > > +	compatible = "globalscale,espressobin", "marvell,armada3720", "marvell,armada3700";
> > > >  };
> > > > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > > > index caf9c8529fca..5840ed129309 100644
> > > > --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > > > +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > > > @@ -14,7 +14,7 @@
> > > >  / {
> > > >  	model = "CZ.NIC Turris Mox Board";
> > > >  	compatible = "cznic,turris-mox", "marvell,armada3720",
> > > > -		     "marvell,armada3710";
> > > > +		     "marvell,armada3700";
> > > >  
> > > >  	aliases {
> > > >  		spi0 = &spi0;
> > > > diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > > > index 5ce55bdbb995..02ae1e153288 100644
> > > > --- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > > > +++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > > > @@ -13,7 +13,7 @@
> > > >  
> > > >  / {
> > > >  	model = "Marvell Armada 3720 SoC";
> > > > -	compatible = "marvell,armada3720", "marvell,armada3710";
> > > > +	compatible = "marvell,armada3720", "marvell,armada3700";
> > > >  
> > > >  	cpus {
> > > >  		cpu1: cpu@1 {
> > > > -- 
> > > > 2.20.1
> > > > 
