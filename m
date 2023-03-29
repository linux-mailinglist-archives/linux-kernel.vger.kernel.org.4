Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB26CD992
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjC2Mse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjC2Msc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:48:32 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74473D2;
        Wed, 29 Mar 2023 05:48:31 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TCmLGc126220;
        Wed, 29 Mar 2023 07:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680094101;
        bh=0XtNfurdTc3XNwRGOXx0UmDTXdzjap6YsuID7KhWXow=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iax35Y902Ng9WO3ijKnk2dy7KSLl983KD0x9U4XtXO4+dAZPSCUGgQdOA210Z8PFi
         qeTW+qlhgS6mG4B2iVlIka7xKi5mmAN1RyJkykd5HLCJrIPHkgVWaDI9ZymmVzfPnA
         NR2wqdpDdflERW7ntGRNkc/W8xxRLYejEugTNWFY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TCmLCo015862
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 07:48:21 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 07:48:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 07:48:21 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TCmLF9046902;
        Wed, 29 Mar 2023 07:48:21 -0500
Date:   Wed, 29 Mar 2023 07:48:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j721e-main: Switch MAIN R5F
 clusters to Split-mode
Message-ID: <20230329124821.snts4npowkwjow3d@fifteen>
References: <20230329063728.14126-1-a-nandan@ti.com>
 <20230329063728.14126-2-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230329063728.14126-2-a-nandan@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:07-20230329, Apurva Nandan wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> J721E SoCs have two R5F clusters in the MAIN domain, and both of these
> are configured for LockStep mode at the moment. Switch both of these R5F
> clusters to Split mode by default to maximize the number of R5F cores.
> The MCU R5F cluster continues to be in the preferred LockStep mode.
> 
> Note that this configuration is the default for remoteproc mode (kernel
> driver boots the R5F processors). These will be overridden for early-booted
> remoteprocs through the corresponding IPC-only support in the K3 R5F
> remoteproc driver.
> 

This looks like a firmware specific behavior, best done in overlay along
with any custom memory map controls you may have to do for that specific
firmware.

If this is indeed a fixes, the commit message needs to clearly indicate
why this is a fix and use the Fixes tag to propogate the fixes.

> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index c935622f0102..31dadbdc0d5a 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1722,7 +1722,7 @@ watchdog1: watchdog@2210000 {
>  
>  	main_r5fss0: r5fss@5c00000 {
>  		compatible = "ti,j721e-r5fss";
> -		ti,cluster-mode = <1>;
> +		ti,cluster-mode = <0>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
> @@ -1762,7 +1762,7 @@ main_r5fss0_core1: r5f@5d00000 {
>  
>  	main_r5fss1: r5fss@5e00000 {
>  		compatible = "ti,j721e-r5fss";
> -		ti,cluster-mode = <1>;
> +		ti,cluster-mode = <0>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
