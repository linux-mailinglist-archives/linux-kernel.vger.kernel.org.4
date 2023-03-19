Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129FE6C04B5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCSUNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCSUNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:13:34 -0400
Received: from out-9.mta0.migadu.com (out-9.mta0.migadu.com [91.218.175.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678E11ADEF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:13:29 -0700 (PDT)
Date:   Sun, 19 Mar 2023 21:13:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1679256807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fgsBwcro5107gronfcMaX+jKKEq+takEuwMD5ulYJ18=;
        b=g9uTKUcCPwLgCEmggQlCn9qy0Vz6Q5f/cIFC+UclVOv5kPURUQpcdjpsgD49klcW5cNz6a
        CiuOZCbtRn5plt4YY3f6iK7/fjFH6Ord0Z9ipw7f6L0z9LN7ZkDNAswBr0HD/veVPFaey0
        VCMY5hg8cRxZPMwGCSrQiNWs7mEo1/A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, virag.david003@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Valentine Iourine <iourine@iourine.msk.su>
Subject: Re: [PATCH v5 2/2] ARM: dts: exynos: add mmc aliases
Message-ID: <ZBds5NFv1Lr8k0jk@L14.lan>
References: <20230316211558.8526-1-henrik@grimler.se>
 <20230316211558.8526-3-henrik@grimler.se>
 <216262b8-fe48-6696-17a4-eaa82e776db7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216262b8-fe48-6696-17a4-eaa82e776db7@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Mar 17, 2023 at 01:28:02PM +0100, Krzysztof Kozlowski wrote:
> On 16/03/2023 22:15, Henrik Grimler wrote:
> > Add aliases for eMMC, SD card and WiFi where applicable, so that
> > assigned mmc indeces are always the same.
> > 
> > Co-developed-by: Anton Bambura <jenneron@protonmail.com>
> > Signed-off-by: Anton Bambura <jenneron@protonmail.com>
> > [ Tested on exynos5800-peach-pi ]
> > Tested-by: Valentine Iourine <iourine@iourine.msk.su>
> > Signed-off-by: Henrik Grimler <henrik@grimler.se>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> 
> 
> 
> >  	chosen {
> > diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
> > index bba85011ecc9..7051e2c4b391 100644
> > --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> > +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> > @@ -25,6 +25,12 @@ memory@40000000 {
> >  		reg = <0x40000000 0x40000000>;
> >  	};
> >  
> > +	aliases {
> > +		mmc0 = &sdhci_0;
> > +		mmc2 = &sdhci_2;
> > +		mmc3 = &sdhci_3;
> 
> Here...
> 
> > +	};
> > +
> >  	chosen {
> >  		stdout-path = "serial2:115200n8";
> >  	};
> > diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
> > index 1103e7f92b57..1970c31410e5 100644
> > --- a/arch/arm/boot/dts/exynos4210-origen.dts
> > +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> > @@ -30,6 +30,11 @@ memory@40000000 {
> >  		       0x70000000 0x10000000>;
> >  	};
> >  
> > +	aliases {
> > +		mmc0 = &sdhci_0;
> 
> here ....
> 
> > +		mmc2 = &sdhci_2;
> > +	};
> > +
> >  	chosen {
> >  		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
> >  		stdout-path = "serial2:115200n8";
> > diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
> > index 181c99eca675..cb74af41e17c 100644
> > --- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
> > +++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
> > @@ -25,6 +25,10 @@ memory@40000000 {
> >  		reg = <0x40000000 0x80000000>;
> >  	};
> >  
> > +	aliases {
> > +		mmc2 = &sdhci_2;
> > +	};
> > +
> >  	chosen {
> >  		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
> >  		stdout-path = "serial1:115200n8";
> > diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
> > index b8e9dd23fc51..b6b0c116016c 100644
> > --- a/arch/arm/boot/dts/exynos4210-trats.dts
> > +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> > @@ -26,6 +26,12 @@ memory@40000000 {
> >  			0x70000000 0x10000000>;
> >  	};
> >  
> > +	aliases {
> > +		mmc0 = &sdhci_0;
> > +		mmc2 = &sdhci_2;
> > +		mmc3 = &sdhci_3;
> > +	};
> > +
> >  	chosen {
> >  		bootargs = "root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
> >  		stdout-path = "serial2:115200n8";
> > diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > index 140abfb38e1d..f42cfcbcdcfa 100644
> > --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > @@ -24,6 +24,12 @@ memory@40000000 {
> >  			0x50000000 0x10000000>;
> >  	};
> >  
> > +	aliases {
> > +		mmc0 = &sdhci_0;
> > +		mmc2 = &sdhci_2;
> 
> 
> Why this is 2? Aliases are continues and match the board. For example
> Universal calls this mmc1 and the next mmc2, not 3.

Not sure I follow, Universal calls sdhci_2 mmc1 in schematics? (I have tried searching for
schematics but cannot really find anything about this board)

> I bet it is the same on Trats and all other boards.

Sure, I can change to mmc0, mmc1 for all 4210 devices.

> > +		mmc3 = &sdhci_3;
> > +	};
> > +
> >  	chosen {
> >  		bootargs = "root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
> >  		stdout-path = "serial2:115200n8";
> > diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> > index 6260da187e92..0e5419c0eaff 100644
> > --- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
> > +++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
> > @@ -20,6 +20,10 @@ / {
> >  	model = "TOPEET iTop 4412 Elite board based on Exynos4412";
> >  	compatible = "topeet,itop4412-elite", "samsung,exynos4412", "samsung,exynos4";
> >  
> > +	aliases {
> > +		mmc2 = &sdhci_2;
> 
> mmc1

Ok, will change.

> > +	};
> > +
> >  	chosen {
> >  		bootargs = "root=/dev/mmcblk0p2 rw rootfstype=ext4 rootdelay=1 rootwait";
> >  		stdout-path = "serial2:115200n8";
> > diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> > index ca8d42b2ce3b..7bc6968af9c3 100644
> > --- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> > @@ -23,6 +23,10 @@ memory@40000000 {
> >  		reg = <0x40000000 0x40000000>;
> >  	};
> >  
> > +	aliases {
> > +		mmc0 = &mshc_0;
> > +	};
> > +
> >  	firmware@203f000 {
> >  		compatible = "samsung,secure-firmware";
> >  		reg = <0x0203f000 0x1000>;
> > diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
> > index 82aed59cba7c..e6b949c1a00f 100644
> > --- a/arch/arm/boot/dts/exynos4412-midas.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
> > @@ -25,6 +25,9 @@ / {
> >  	aliases {
> >  		i2c11 = &i2c_max77693;
> >  		i2c12 = &i2c_max77693_fuel;
> > +		mmc0 = &mshc_0;
> > +		mmc2 = &sdhci_2;
> > +		mmc3 = &sdhci_3;
> 
> This is actually correct.
> 
> >  	};
> >  
> >  	chosen {
> > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > index 25e082fda955..45ef7b7ba7e0 100644
> > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > @@ -13,6 +13,11 @@
> >  #include "exynos-mfc-reserved-memory.dtsi"
> >  
> >  / {
> > +	aliases {
> > +		mmc0 = &mshc_0;
> > +		mmc2 = &sdhci_2;
> 
> This is also correct.
> 
> > +	};
> 
> For all other cases, where schematics are missing, just make them linear.

Alright, will do in next version, thanks for the feedback!

> Krzysztof

Best regards,
Henrik Grimler
