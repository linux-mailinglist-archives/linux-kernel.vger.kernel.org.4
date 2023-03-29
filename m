Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934336CD3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjC2HuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjC2Htc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:49:32 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8262A448D;
        Wed, 29 Mar 2023 00:49:30 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32T7nFdc118968;
        Wed, 29 Mar 2023 02:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680076155;
        bh=wKSDtopjrHjEd9gLbag8cmZlVFtkAT1owNQfFKFOIzg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LapYeVxIEwj5VugZ+8Xlm94LcAjK5dzSmUUcg2EQVI3LWuQAHSy5M7BXR52eIFUEi
         aGixdNuoGtlLsEv54cZGM8P7I8j+s3sBxXh2QWqv3u9I9c1qhM8QkF6q5Jbd7IuipP
         9cngmJANveo4a0S+OKAABNWK39VGf+rcCjOvQbLE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32T7nFRV079867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 02:49:15 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 02:49:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 02:49:14 -0500
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32T7nAld037259;
        Wed, 29 Mar 2023 02:49:11 -0500
Message-ID: <ba4c1323-b462-5f78-c3ea-229efef97e77@ti.com>
Date:   Wed, 29 Mar 2023 13:19:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j784s4-mcu-wakeup: Fix IO
 PADCONFIG size for wakeup domain
Content-Language: en-US
To:     <sabiya.d@mistralsolutions.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dasnavis Sabiya <sabiya.d@ti.com>,
        <u-kumar1@ti.com>
References: <20230316104743.482972-1-sabiya.d@ti.com>
 <20230316104743.482972-2-sabiya.d@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230316104743.482972-2-sabiya.d@ti.com>
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

Hi Sabiya,

On 16/03/23 16:17, sabiya.d@mistralsolutions.com wrote:
> From: Dasnavis Sabiya <sabiya.d@ti.com>
> 
> The size of IO PADCONFIG register set of the wakeup domain is incorrect for
> J784S4. Update the PADCONFIG offset size to the correct value for
> J784S4 SoC.
> 
> Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index 64bd3dee14aa..c0103513c64c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -50,7 +50,7 @@ mcu_ram: sram@41c00000 {
>  	wkup_pmx0: pinctrl@4301c000 {
>  		compatible = "pinctrl-single";
>  		/* Proxy 0 addressing */
> -		reg = <0x00 0x4301c000 0x00 0x178>;
> +		reg = <0x00 0x4301c000 0x00 0x194>;
>  		#pinctrl-cells = <1>;
>  		pinctrl-single,register-width = <32>;
>  		pinctrl-single,function-mask = <0xffffffff>;

Similar feedback as for the J721S2 PADCONFIG patch, see the discussion below,

https://lore.kernel.org/all/20230328114742.tnaa5hi3qm3rsgld@ecology/

As suggested by Nishanth, let us do a single fixup to avoid non-addressable
regions and fix the padconfig region size.

From datasheet I can see that the addresses corresponding to WKUP_PADCONFIG13,
WKUP_PADCONFIG25 are missing for J784S4.

-- 
Regards,
Vaishnav
