Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999B16D93AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbjDFKGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbjDFKG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:06:26 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20872D44;
        Thu,  6 Apr 2023 03:05:43 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3369josj079803;
        Thu, 6 Apr 2023 04:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680774350;
        bh=t/3ZUQarijZAKO8+8ZuwWq+2OTot5xhmxiGIBn1cxqI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=pLbmpBrGL+wlLRDDzljR38CK8N/xPRwKSrzPTo31dni/5NJ7wm4oTKj1HkX0Ba9Ok
         SPtgzMZ/72EM1NFQZtweHtYkqSSiyle+TIBF9BzS04qYo2pWdI/1S2S8xORqxvtlLD
         Z1L/HwqggMsiORamNUkeJ/OlgzzYWRx7C5sCwlaw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3369jode007315
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Apr 2023 04:45:50 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 6
 Apr 2023 04:45:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 6 Apr 2023 04:45:49 -0500
Received: from [172.24.145.182] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3369jl0g018625;
        Thu, 6 Apr 2023 04:45:47 -0500
Message-ID: <ccc179f9-1279-9b3a-04ef-0107ad0592d0@ti.com>
Date:   Thu, 6 Apr 2023 15:15:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-main: Enable support for SDR104
 speed mode
To:     Bhavya Kapoor <b-kapoor@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <d-dhyani@ti.com>
References: <20230404091245.336732-1-b-kapoor@ti.com>
Content-Language: en-US
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230404091245.336732-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/23 14:42, Bhavya Kapoor wrote:
> Remove sdhci-caps-mask to enable support for SDR104 speed mode for
> SD card in J721S2 SoC.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---

Your commit message doesn't explain why?
Why was this disabled initalially and why is it okay to enable this now?

If disabling SDR104 was a bug, please add Fixes:

>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 8915132efcc1..95c6151ed10c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -400,8 +400,6 @@ main_sdhci1: mmc@4fb0000 {
>  		ti,clkbuf-sel = <0x7>;
>  		ti,trm-icp = <0x8>;
>  		dma-coherent;
> -		/* Masking support for SDR104 capability */
> -		sdhci-caps-mask = <0x00000003 0x00000000>;
>  	};
>  
>  	main_navss: bus@30000000 {

-- 
Regards
Vignesh
