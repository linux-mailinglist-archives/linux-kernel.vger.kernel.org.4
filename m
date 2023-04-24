Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184CF6ED374
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjDXRY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjDXRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:24:23 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAF549D0;
        Mon, 24 Apr 2023 10:24:21 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OHO9qJ035948;
        Mon, 24 Apr 2023 12:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682357049;
        bh=vrYfILk+8/33VxPwT4F9AJ+MJUhKGzAtHjT8mjTXeVI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=EFQszo9FX4kRocpff6xDv1JNaWG5a0sqwpm3E5QbbeSsnLFrseya4YLGreXZ80Klg
         Gd4W0yqr9SnDIEn4kbog9j3AdvJwL7/SHGbLEh4gK2hFr+OgIlK6MBsWeckvCqcgx7
         akaMTpvV0CIqjE3teN/3ieJpwsLcv41uuzdZ8LJs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OHO9kU016920
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 12:24:09 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 12:24:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 12:24:09 -0500
Received: from [10.250.35.77] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OHO8sk027965;
        Mon, 24 Apr 2023 12:24:08 -0500
Message-ID: <76da0b98-3274-b047-db11-ecabc117ae11@ti.com>
Date:   Mon, 24 Apr 2023 12:24:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/7] arm64: dts: ti: k3-am65: Switch to
 "ti,j721e-system-controller" compatible
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <20230424144949.244135-1-nm@ti.com>
 <20230424144949.244135-4-nm@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230424144949.244135-4-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 9:49 AM, Nishanth Menon wrote:
> Switch scm-conf to "ti,j721e-system-controller" compatible to be more
> specific.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 2 +-
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 227573773b26..40fa631f2f3d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -475,7 +475,7 @@ sdhci1: mmc@4fa0000 {
>   	};
>   
>   	scm_conf: scm-conf@100000 {
> -		compatible = "syscon", "simple-mfd";
> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
>   		reg = <0 0x00100000 0 0x1c000>;
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 5dfa31840e9c..566dc584d3f3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -7,7 +7,7 @@
>   
>   &cbass_mcu {
>   	mcu_conf: scm-conf@40f00000 {
> -		compatible = "syscon", "simple-mfd";
> +		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";

This node is not a "j721e-system-controller". Only the one in main could be
said to be one, but even it is different enough that this is not correct IMHO.
It almost seems like you are using "ti,j721e-system-controller" as a workaround
for the restriction on raw "syscon", "simple-mfd" nodes. And just replacing all
instance of those with something that avoids the warning.

What we should do here is turn both of these nodes into "simple-bus". The sub-nodes
themselves would describe what they are. This is the normal DT way vs having
all our device nodes pointing into one big "syscon" node with various offsets (which
makes it hard to see all users of a node and near impossible to work out the real
memory map in these "system-controller" nodes).

Worse, if the parent is a "syscon" then the whole memory region gets one big regmap
over it, and any child nodes that also build a regmap for their smaller sub-range
leads to having two regmaps pointing to the same memory area. This breaks some
assumptions around atomic access and reg caching.

Taking a quick look I see some of our sub-node drivers expecting the parent to
always be a syscon, others turn themselves into a syscon, and others still do the
normal "reg" mapping. What a mess..

To unwind this I'd suggest we do this:

  * Add support for these sub-node drivers to use the normal "reg" property by
    default if available, falling back to expecting the parent to be a syscon only
    for backwards compatibility.

  * Add "reg" properties to the sub-nodes.

  * Remove "syscon" from our system-controller nodes and instead use "simple-bus".
    Which more accurately describes what these regions are, and prevents issues like
    having a regmap over gaps (as these system-controller have gaps in between the
    sub device memory regions)

We would still have to add simple compatibles for the efuse and pcie mode/id regions,
but that is much more correct than hiding them in the device's node like done in patch
1/7 of this series.

Andrew

>   		reg = <0x0 0x40f00000 0x0 0x20000>;
>   		#address-cells = <1>;
>   		#size-cells = <1>;
