Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5E762B62D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiKPJPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbiKPJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:15:07 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1139E63C7;
        Wed, 16 Nov 2022 01:15:06 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AG9ETYl018221;
        Wed, 16 Nov 2022 03:14:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668590069;
        bh=2vGXON+Si2EYAR3ov7RM1ZPJ4M02dQQ7aoneZMo/r3A=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AkflDbEU6VtlZy1QWdz9hvPFNcMmWKQ1oionNJ4x2eAnpx7dgkO9JN54VxIUDQKfK
         8QZM33oyUS+gqqip4BDHMXhCO6y/AUoQSwvhkQFg9QLf3i9dV6cyofGuVeBx31GUZT
         bKneUJLTLJ0l8s76aSDOFFkRN9zp0UIuvvz0Xvl8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AG9ETn8107192
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Nov 2022 03:14:29 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 16
 Nov 2022 03:14:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 16 Nov 2022 03:14:29 -0600
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AG9EQcv055273;
        Wed, 16 Nov 2022 03:14:26 -0600
Message-ID: <12285f24-db9d-197b-84e5-e1e296607a04@ti.com>
Date:   Wed, 16 Nov 2022 14:44:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2: Fix the interrupt ranges
 property for main & wkup gpio intr
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220922072950.9157-1-j-keerthy@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20220922072950.9157-1-j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/22 12:59, Keerthy wrote:
> The parent's input irq number is wrongly subtracted with 32 instead of
> using the exact numbers in:
> 
> https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721s2/interrupt_cfg.html
> 
> The GPIO interrupts are not working because of that. The toggling works
> fine but interrupts are not firing. Fix the parent's input irq that
> specifies the base for parent irq.
> 
> Tested for MAIN_GPIO0_6 interrupt on the j721s2 EVM.
> 
> Fixes: b8545f9d3a542 ("arm64: dts: ti: Add initial support for J721S2 SoC")
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi       | 2 +-
>  arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 34e7d577ae13..c89f28235812 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -60,7 +60,7 @@
>  		#interrupt-cells = <1>;
>  		ti,sci = <&sms>;
>  		ti,sci-dev-id = <148>;
> -		ti,interrupt-ranges = <8 360 56>;
> +		ti,interrupt-ranges = <8 392 56>;
>  	};
>  
>  	main_pmx0: pinctrl@11c000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 4d1bfabd1313..f0644851602c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -65,7 +65,7 @@
>  		#interrupt-cells = <1>;
>  		ti,sci = <&sms>;
>  		ti,sci-dev-id = <125>;
> -		ti,interrupt-ranges = <16 928 16>;
> +		ti,interrupt-ranges = <16 960 16>;

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>

>  	};
>  
>  	mcu_conf: syscon@40f00000 {

-- 
Regards,
Vaishnav
