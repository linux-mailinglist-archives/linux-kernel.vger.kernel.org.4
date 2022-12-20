Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92B5651F91
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiLTLTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiLTLTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:19:51 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6A45F9B;
        Tue, 20 Dec 2022 03:19:50 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BKBJbt0048830;
        Tue, 20 Dec 2022 05:19:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671535177;
        bh=jEGXTNEkgEJDAQg4D1e1XQUrvQwR9bOKhG+iF6Bxcfk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Ims0169tydbccpvKS0rLJyObQQwfiWxAqCZFbsl5eZT6y9y9ROlP7Ijvx9BrWnf4R
         Fy74d1OTqmJ6EhVyyxBJd7QeKR9TsHWpbq2Ib4i/gAepzZD3WaJ6xpFoGP7w5GCPce
         Nt7QGxTrxZxnlaiakHPTid4NyrtqTdOV+LzazQgE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BKBJbHU036031
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Dec 2022 05:19:37 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 20
 Dec 2022 05:19:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 20 Dec 2022 05:19:37 -0600
Received: from [10.250.232.115] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BKBJWTh130880;
        Tue, 20 Dec 2022 05:19:33 -0600
Message-ID: <b22b6349-9cec-2e86-294a-249f24de2345@ti.com>
Date:   Tue, 20 Dec 2022 16:49:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62-main: Update OTAP and ITAP
 delay select
Content-Language: en-US
To:     Sjoerd Simons <sjoerd@collabora.com>, Nishanth Menon <nm@ti.com>
CC:     <martyn.welch@collabora.com>, Nitin Yadav <n-yadav@ti.com>,
        "Aswath Govindraju" <a-govindraju@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Tero Kristo" <kristo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221216143624.23708-1-sjoerd@collabora.com>
 <20221216143624.23708-2-sjoerd@collabora.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20221216143624.23708-2-sjoerd@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/12/22 8:06 pm, Sjoerd Simons wrote:
> From: Nitin Yadav <n-yadav@ti.com>
> 
> UHS Class U1 sd-card are not getting detected due to incorrect
> OTAP/ITAP delay select values in linux. Update OTAP and ITAP
> delay select values for various speed modes. For sdhci0, update
> OTAP delay values for ddr52 & HS200 and add ITAP delay for legacy
> & mmc-hs. For sdhci1 & sdhci2, update OTAP & ITAP delay select
> recommended as in RIOT for various speed modes.
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> [cherry-pick from vendor BSP]
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
> 
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 46 ++++++++++++------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 03660476364f..28c250a8d1ec 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -391,8 +391,10 @@ sdhci0: mmc@fa10000 {
>  		ti,clkbuf-sel = <0x7>;
>  		ti,otap-del-sel-legacy = <0x0>;
>  		ti,otap-del-sel-mmc-hs = <0x0>;
> -		ti,otap-del-sel-ddr52 = <0x9>;
> -		ti,otap-del-sel-hs200 = <0x6>;
> +		ti,otap-del-sel-ddr52 = <0x5>;
> +		ti,otap-del-sel-hs200 = <0x5>;
> +		ti,itap-del-sel-legacy = <0xa>;

This is pretty useless without corresponding driver changes 
to pick up ti,itap-del-sel-legacy as well

https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/drivers/mmc/host/sdhci_am654.c?h=ti-linux-5.10.y&id=93d22fc56007ee13e589debf0d32c8b1d5fdc6d8
https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/drivers/mmc/host/sdhci_am654.c?h=ti-linux-5.10.y&id=9c878c3dc642f7f1f3ab6ca7f812cd43fe7ed7d8

Could you list that cards affected and fixed by this change?

Regards
Vignesh

[...]
