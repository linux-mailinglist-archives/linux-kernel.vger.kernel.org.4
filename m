Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C00E6B7323
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCMJtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjCMJtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:49:49 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3D661AB;
        Mon, 13 Mar 2023 02:49:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32D9nQJp110077;
        Mon, 13 Mar 2023 04:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678700966;
        bh=5tIHLp8mna+dpOxvauCmGw9dgMnWj4HTyDR1d2zhhR4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=e8B55OML3EtDXIIl+h5Y52/upMe5o6Heo1tQCJF+aBtbLKGUn/t2XkDuhV6jLYWtw
         ZHsrQCjdtkcauiYS1f+0JnsoV7poaUSevxGF5JWuJGKgz5+14tqmM+1b22gM1b/SSy
         3don19VqM2CqE4ROH2bj5tm6q30/fhSyJOpZO8UM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32D9nQuA075729
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 04:49:26 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 04:49:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 04:49:25 -0500
Received: from [172.24.218.99] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32D9nIDL113095;
        Mon, 13 Mar 2023 04:49:19 -0500
Message-ID: <f28489b1-4ece-4f48-e2c0-9bd7755071d8@ti.com>
Date:   Mon, 13 Mar 2023 15:19:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel
 property
To:     Bhavya Kapoor <b-kapoor@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <a-govindraju@ti.com>, <kishon@ti.com>, <u-kumar1@ti.com>
References: <20230203073724.29529-1-b-kapoor@ti.com>
Content-Language: en-US
From:   Nitin Yadav <n-yadav@ti.com>
In-Reply-To: <20230203073724.29529-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/2023 1:07 PM, Bhavya Kapoor wrote:
> According to latest errata of J721e [1], (i2024) 'MMCSD: Peripherals
> Do Not Support HS400' which applies to MMCSD0 subsystem. Speed modes
> supported has been already updated in commit eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
> but it missed dropping 'ti,strobe-sel' property which is only required
> by HS400 speed mode.
> 
> Thus, drop 'ti,strobe-sel' property from kernel dtsi for J721e SoC.
> 
> [1] https://www.ti.com/lit/er/sprz455/sprz455.pdf
> 
> Fixes: eb8f6194e807 ("arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems")
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index c935622f0102..bfa296dce3a3 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1180,7 +1180,6 @@ main_sdhci0: mmc@4f80000 {
>  		ti,itap-del-sel-mmc-hs = <0xa>;
>  		ti,itap-del-sel-ddr52 = <0x3>;
>  		ti,trm-icp = <0x8>;
> -		ti,strobe-sel = <0x77>;
>  		dma-coherent;
>  	};
>
Reviewed-by: Nitin Yadav <n-yadav@ti.com>
  
