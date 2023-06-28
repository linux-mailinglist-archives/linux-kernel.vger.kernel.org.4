Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5DD740B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjF1IY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:24:58 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55534 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjF1IU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:20:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35S8Kk9n120812;
        Wed, 28 Jun 2023 03:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687940446;
        bh=jl//wheQUX9KT7i1/Iv7eiB6CFe7ES3HsUsD8F3mOEQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=PT2WIQrJxoQLC8BXqq1YBoDDf8MUjOi/iuMEBXSDtIlfqqjZos/okhlbsx2BFn7V6
         If7e9uOP58QC2P7qWpQsliwAWeQoeW0uDAv3O1Z0fZzZELJrprbKMM/pmwhsLg6WAt
         xPfPn4TddVhaMgKKX3nEU50XBO5RlP5rjSbYjvTk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35S8Kk0Z058413
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Jun 2023 03:20:46 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Jun 2023 03:20:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Jun 2023 03:20:46 -0500
Received: from [172.24.217.204] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35S8KgHr116006;
        Wed, 28 Jun 2023 03:20:43 -0500
Message-ID: <7fe4adef-9be2-6dae-d53f-692f9775439c@ti.com>
Date:   Wed, 28 Jun 2023 13:50:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721s2-main: Enable support for
 SDR104 speed mode
To:     Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <u-kumar1@ti.com>
References: <20230412121415.860447-1-b-kapoor@ti.com>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230412121415.860447-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/2023 5:44 PM, Bhavya Kapoor wrote:
> According to TRM for J721S2, SDR104 speed mode is supported by the SoC
> but its capabilities were masked in device tree. Remove sdhci-caps-mask
> to enable support for SDR104 speed mode for SD card in J721S2 SoC.
>
> [+] Refer to : section 12.3.6.1.1 MMCSD Features, in J721S2 TRM
> - https://www.ti.com/lit/zip/spruj28
>
> Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
> Changelog v1->v2:
> 	- Modified Commit Message and Added Fixes tag
>
> Link to v1 : https://lore.kernel.org/all/20230404091245.336732-1-b-kapoor@ti.com/
>
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 8915132efcc1..95c6151ed10c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -400,8 +400,6 @@ main_sdhci1: mmc@4fb0000 {
>   		ti,clkbuf-sel = <0x7>;
>   		ti,trm-icp = <0x8>;
>   		dma-coherent;
> -		/* Masking support for SDR104 capability */
> -		sdhci-caps-mask = <0x00000003 0x00000000>;


Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>   	};
>   
>   	main_navss: bus@30000000 {
