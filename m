Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAB26C2934
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCUEha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCUEh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:37:28 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9282A9B5;
        Mon, 20 Mar 2023 21:37:27 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32L4bIWd018873;
        Mon, 20 Mar 2023 23:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679373438;
        bh=SPVumwcpt0D9GYRf8gsF0VJBx5ewNMg3aoYWWLCt/f0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Aq74u0UPsKaBtXki9zr+munGRs/GGyrSLfziO2LNh6yxxOteHYaDZz5uW76y+k0lJ
         phD9OjsCZwgoY4hAnl8qgqUm6qaUe2sZ3Kv2sbFFxwO3DMy9a7g6ABuRB7a8u8QY0t
         EJ8pbxuq1iCWbKLkt0LbouTI3FiEwUAu+2wsoV+M=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32L4bIeC023858
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 23:37:18 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 23:37:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 23:37:18 -0500
Received: from [10.249.132.105] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32L4bDhB032111;
        Mon, 20 Mar 2023 23:37:14 -0500
Message-ID: <4a1f33bb-882a-ed49-9e0e-b463203e0ea9@ti.com>
Date:   Tue, 21 Mar 2023 10:07:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3 1/2] arm64: dts: ti: k3-am62-wakeup: Introduce RTC node
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>, <bb@ti.com>
References: <20230320165123.80561-1-nm@ti.com>
 <20230320165123.80561-2-nm@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230320165123.80561-2-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/03/23 22:21, Nishanth Menon wrote:
> Introduce digital RTC node in wakeup domain. Even though this has
> no specific battery backup supply, this on-chip RTC is used in
> cost-optimized board designs as a wakeup source.
>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since v2:
> - Just reviewed-by pickups
>
> V2: https://lore.kernel.org/all/20230315170706.1598977-2-nm@ti.com/
> V1: https://lore.kernel.org/all/20230311105850.21811-2-nm@ti.com/
>
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> index 38dced6b4fef..fec81546fbbd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -40,4 +40,14 @@ wkup_i2c0: i2c@2b200000 {
>  		clock-names = "fck";
>  		status = "disabled";
>  	};
> +
> +	wkup_rtc0: rtc@2b1f0000 {
> +		compatible = "ti,am62-rtc";
> +		reg = <0x00 0x2b1f0000 0x00 0x100>;
> +		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 117 6> , <&k3_clks 117 0>;
> +		clock-names = "vbus", "osc32k";
> +		power-domains = <&k3_pds 117 TI_SCI_PD_EXCLUSIVE>;
> +		wakeup-source;
> +	};
>  };

I was just wondering why some of the rtctests show failures on this platform:

https://gist.github.com/DhruvaG2000/5c6d8bb99b087308b916985d70f0c440

pass:5 fail:2

the test is compiled from tools/testing/selftests/rtc/rtctest.c for arm64 target

Is this expected?

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

