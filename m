Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562E36CD995
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjC2Mtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjC2Mtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:49:31 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275DF9B;
        Wed, 29 Mar 2023 05:49:30 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TCnNrj126336;
        Wed, 29 Mar 2023 07:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680094163;
        bh=wvMDtM6rp5H4rZPw4nrGnX954wd3xTTYWxJJx3Wqar0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=G4v1HGOylALc8eegjl1Dv2Zba0O5tCHaJy00rrgjeVfr0p21hlipgs62W0wFwo5W0
         ybs+HWmWTS3Gjvuda+DXSNiIuj5RxQ3c6YnUxbvbKCN5CtjP/cOtbI/OZr/RZr/snd
         L0Pthu+PfGtwKB0AULP+SLf6JW0n/fmvWXBRecKY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TCnNED034977
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 07:49:23 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 07:49:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 07:49:23 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TCnNDa008785;
        Wed, 29 Mar 2023 07:49:23 -0500
Date:   Wed, 29 Mar 2023 07:49:23 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Apurva Nandan <a-nandan@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j7200-main: Switch MAIN R5F
 cluster to Split-mode
Message-ID: <20230329124923.aoa3ufn4g34b2zjm@unvisited>
References: <20230329063728.14126-1-a-nandan@ti.com>
 <20230329063728.14126-3-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230329063728.14126-3-a-nandan@ti.com>
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
> J7200 SoCs has a R5F cluster in each of the MAIN and MCU domains, and both
> of these are configured for LockStep mode at the moment. Switch the MAIN
> R5F cluster to Split mode by default to maximize the number of R5F cores.
> The MCU R5F cluster continues to be in the preferred LockStep mode.
> 
> Note that this configuration is the default for remoteproc mode (kernel
> driver boots the R5F processors). These will be overridden for early-booted
> remoteprocs through the corresponding IPC-only support in the K3 R5F
> remoteproc driver.

Same comment as #1.

> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 138381f43ce4..573a7f949b1d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -797,7 +797,7 @@ watchdog1: watchdog@2210000 {
>  
>  	main_r5fss0: r5fss@5c00000 {
>  		compatible = "ti,j7200-r5fss";
> -		ti,cluster-mode = <1>;
> +		ti,cluster-mode = <0>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
