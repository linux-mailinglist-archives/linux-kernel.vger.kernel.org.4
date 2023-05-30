Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002777155ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjE3G7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjE3G7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:59:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3BDB2;
        Mon, 29 May 2023 23:59:42 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E2DFF66058F8;
        Tue, 30 May 2023 07:59:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685429981;
        bh=LEEyS50uUZjJKNoFijv9Ne6IwUdkHPUoQgYBkOeP+Oo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fYUCe55szRdKFc+b170KtqwiMen1htHtk3aCD8aGXquRO59YyZVi/xHjj8Cd6K9Pa
         32yuLQ49dHqKWYn6s7ZNRozZc4pU8JE5d/SYBeap1XAn7mb0Naau3ZL7tEkQ7NVCFZ
         xPthGisDY0IAm/lq4eC8AiMfjmGwGJTcK1wmDwsp9z3n3hhfi3Ad3/nOuaTtMV46pw
         4XhCcnWQjhgae7kAXWpbRp0F/ZLx/ubKmrLPKG6h7ZrR4Syi+a8+qg3as6NLemqsZK
         dediYofmekeICFhUKz5+47wT2yEe9abuGhKamTLiLek/7H7ja2K54ludz3+iHSy8fv
         T1wBrVp7B2ZiA==
Message-ID: <d50e3c7e-0900-7cb5-f6cc-ddc1f474ff33@collabora.com>
Date:   Tue, 30 May 2023 08:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 4/5] arm64: dts: mediatek: mt8192: Add thermal nodes
 and thermal zones
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
References: <20230529164605.3552619-1-bero@baylibre.com>
 <20230529164605.3552619-5-bero@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230529164605.3552619-5-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/05/23 18:46, Bernhard Rosenkränzer ha scritto:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add thermal nodes and thermal zones for the mt8192.
> The mt8192 SoC has several hotspots around the CPUs.
> Specify the targeted temperature threshold to apply the mitigation
> and define the associated cooling devices.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> [bero@baylibre.com: cosmetic changes]
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 454 +++++++++++++++++++++++
>   1 file changed, 454 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 5c30caf740265..330c5bb4ebc85 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -14,6 +14,8 @@
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/power/mt8192-power.h>
>   #include <dt-bindings/reset/mt8192-resets.h>
> +#include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
>   
>   / {
>   	compatible = "mediatek,mt8192";
> @@ -71,6 +73,7 @@ cpu0: cpu@0 {
>   			d-cache-sets = <128>;
>   			next-level-cache = <&l2_0>;
>   			capacity-dmips-mhz = <530>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu1: cpu@100 {
> @@ -88,6 +91,7 @@ cpu1: cpu@100 {
>   			d-cache-sets = <128>;
>   			next-level-cache = <&l2_0>;
>   			capacity-dmips-mhz = <530>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu2: cpu@200 {
> @@ -105,6 +109,7 @@ cpu2: cpu@200 {
>   			d-cache-sets = <128>;
>   			next-level-cache = <&l2_0>;
>   			capacity-dmips-mhz = <530>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu3: cpu@300 {
> @@ -122,6 +127,7 @@ cpu3: cpu@300 {
>   			d-cache-sets = <128>;
>   			next-level-cache = <&l2_0>;
>   			capacity-dmips-mhz = <530>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu4: cpu@400 {
> @@ -139,6 +145,7 @@ cpu4: cpu@400 {
>   			d-cache-sets = <256>;
>   			next-level-cache = <&l2_1>;
>   			capacity-dmips-mhz = <1024>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu5: cpu@500 {
> @@ -156,6 +163,7 @@ cpu5: cpu@500 {
>   			d-cache-sets = <256>;
>   			next-level-cache = <&l2_1>;
>   			capacity-dmips-mhz = <1024>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu6: cpu@600 {
> @@ -173,6 +181,7 @@ cpu6: cpu@600 {
>   			d-cache-sets = <256>;
>   			next-level-cache = <&l2_1>;
>   			capacity-dmips-mhz = <1024>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu7: cpu@700 {
> @@ -190,6 +199,7 @@ cpu7: cpu@700 {
>   			d-cache-sets = <256>;
>   			next-level-cache = <&l2_1>;
>   			capacity-dmips-mhz = <1024>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu-map {
> @@ -771,6 +781,17 @@ spi0: spi@1100a000 {
>   			status = "disabled";
>   		};
>   
> +		lvts_ap: thermal-sensor@1100b000 {
> +			compatible = "mediatek,mt8192-lvts-ap";
> +			reg = <0 0x1100b000 0 0x1000>;

reg = <0 0x1100b000 0 0xc00>;

...as 0xc00 should be more than sufficient. This is important for later
when we'll get SVS support up (which is in the LVTS-AP iospace range).

Regards,
Angelo


