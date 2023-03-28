Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77376CBD4E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjC1LSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC1LSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:18:33 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FD81A7;
        Tue, 28 Mar 2023 04:18:32 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SBIOQJ108738;
        Tue, 28 Mar 2023 06:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680002304;
        bh=MvPxFEFK7DB7/DNR0iURafVCw8yeSMx8U1lAbgRmuIk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=hBy/3+JfxMMyMa7ivfv7bfqBwMmnqLhntbcRHvJETvfJWoD/VWanunb8mL7CKtIl2
         Ool2koj8XtbbOAeiTOVK8s9PIAwrVyMkVBsLWUhEw0rYHRCCv1zv86dW774oNmyIUU
         tM4geHPdIwlYmaHc0mCNs188NE3srSUuA8auYJs0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SBIObN049510
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 06:18:24 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 06:18:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 06:18:23 -0500
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SBIKNH008268;
        Tue, 28 Mar 2023 06:18:21 -0500
Message-ID: <5f08cb2f-d2de-8e4e-a9be-1ef3a5fd3a39@ti.com>
Date:   Tue, 28 Mar 2023 16:48:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V3 1/2] arm64: dts: ti: k3-j721s2-mcu-wakeup: Fix IO
 PADCONFIG size for wakeup domain
Content-Language: en-US
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>
References: <20230316114102.3602-1-sinthu.raja@ti.com>
 <20230316114102.3602-2-sinthu.raja@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230316114102.3602-2-sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinthu,

On 16/03/23 17:11, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> The size of wkup domain I/O PADCONFIG register set is incorrect for J721S2.
> Therefore, update the PADCONFIG total offset size to the correct value for
> J721S22 SoC.
> 
> Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
> 
> Changes in V3:
> - Added Fix tag
> 
> Changes in V2:
> - Update commit description.
> - Update the offset value to 0x194 because 0x190 is the last register of the
>   IO PADCONFIG register set.
> 

The existing PADCONFIG register region descriptions in the pinctrl nodes seems
to be incorrect for j721s2-main and j721s2-mcu-wakeup due to non-addressable
holes in the region which causes bus aborts when the registers are read and
causes system crash if we read something like,
/sys/kernel/debug/pinctrl/4301c000.pinctrl-pinctrl-single/pins

This is what I saw from inspection of the datasheet:

* WKUP_PADCONFIG13, WKUP_PADCONFIG25 missing in WKUP_PADCONFIG region
* MAIN_PADCONFIG 64-68 missing in MAIN_PADCONFIG region

I have verified that your patch does not introduce new issues, but since it is a
Fix patch, I will defer the decision to the maintainers on whether we should
split the nodes to avoid non-addressable regions and fix it completely here or
later do a fix for the split.

Thanks and Regards,
Vaishnav

>  arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 0af242aa9816..b10f1e8b98e6 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -50,7 +50,7 @@ mcu_ram: sram@41c00000 {
>  	wkup_pmx0: pinctrl@4301c000 {
>  		compatible = "pinctrl-single";
>  		/* Proxy 0 addressing */
> -		reg = <0x00 0x4301c000 0x00 0x178>;
> +		reg = <0x00 0x4301c000 0x00 0x194>;
>  		#pinctrl-cells = <1>;
>  		pinctrl-single,register-width = <32>;
>  		pinctrl-single,function-mask = <0xffffffff>;

-- 
Regards,
Vaishnav
