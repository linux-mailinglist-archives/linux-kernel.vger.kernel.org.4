Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C266CFB70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjC3GUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjC3GUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:20:52 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2575FE5;
        Wed, 29 Mar 2023 23:20:48 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32U6KalT021983;
        Thu, 30 Mar 2023 01:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680157236;
        bh=H5Uk/wARPWsfe6DJM9bh6gUd8k3OEc+odUh/r1fOGRo=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=Fthu3oTLQbvnW/P/sNKfsMOSE9zDcoOYhBr9nkONB2RoQYsTI1w8Kp6enPP1Sbckm
         hcbhYDduMF5OG0tCfsB1sQKR9z0/H8R4AwFuX6o6Yeg+ov6pP/gzegiupG+5LKyf00
         s4WbFOj5WSao/OrfHlgN2qVz1wHX99P8Nq/cc+Ck=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32U6KZch102898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 01:20:36 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 01:20:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 30 Mar 2023 01:20:35 -0500
Received: from [172.24.145.83] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32U6KWp1055089;
        Thu, 30 Mar 2023 01:20:32 -0500
Message-ID: <f3be8f20-fe56-489e-440c-53ca66f00508@ti.com>
Date:   Thu, 30 Mar 2023 11:50:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Add eMMC mmc0 support
Content-Language: en-US
To:     Apurva Nandan <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230327083100.12587-1-a-nandan@ti.com>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20230327083100.12587-1-a-nandan@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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


On 27/03/23 14:01, Apurva Nandan wrote:
> Add support for eMMC card connected to main sdhci0 instance.
>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>

Reviewed-by: Bhavya Kapoor <b-kapoor@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index 7480f37e89e8..1622a01a4667 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -21,6 +21,7 @@ chosen {
>
>   	aliases {
>   		serial2 = &main_uart8;
> +		mmc0 = &main_sdhci0;
>   		mmc1 = &main_sdhci1;
>   		i2c0 = &main_i2c0;
>   	};
> @@ -225,6 +226,14 @@ exp2: gpio@22 {
>   	};
>   };
>
> +&main_sdhci0 {
> +	/* eMMC */
> +	status = "okay";
> +	non-removable;
> +	ti,driver-strength-ohm = <50>;
> +	disable-wp;
> +};
> +
>   &main_sdhci1 {
>   	/* SD card */
>   	status = "okay";
> --
> 2.34.1
Looks correct to me.
