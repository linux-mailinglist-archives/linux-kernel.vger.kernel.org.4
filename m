Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B527A69C76F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjBTJPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBTJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:14:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58041025D;
        Mon, 20 Feb 2023 01:14:38 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C43AA6600872;
        Mon, 20 Feb 2023 09:14:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676884477;
        bh=EZthGgfp/+GzM9VK96C3TuKsvQok/Nr1qQ/r1iqt4Ps=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ohxoNWbmDg0dEYVGXB/7uh5vTOSjvABwd1PRfGd1SUwp921yneFhCyAx8oo0QWwD5
         XNuEIX8aZIxyT/2hMgqnr1wRkkhuJW3tmubrAaOGrqpppswn+22JjtsEpaOqroe6ZA
         WwZsbAntltwwria907eYGVFY7P2dZF8ZXnWaCmkJFRs6sAfuHFM3z4L/ZivzJTr6Pv
         MMhlKnlkAZ7uJo60bx6qTm/02jdnQwfi3C70/y0Egl8yFtu6hsQ8yBiaIImwERrpus
         su3/ZryAlqRrBzQLo3atqyn9rJJwlqbk1Yh7isrC3ngccuTjMKq+xCeQWHahtDHT7u
         /zMXhrj0vsuJg==
Message-ID: <8df07281-e332-e25d-e0d7-035efbe3925b@collabora.com>
Date:   Mon, 20 Feb 2023 10:14:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] arm64: dts: mediatek: Add cpufreq nodes for MT8192
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
References: <20230220021915.9473-1-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220021915.9473-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/02/23 03:19, Allen-KH Cheng ha scritto:
> Add the cpufreq nodes for MT8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
> Fix a address warning on dtbs_check
> https://patchwork.kernel.org/project/linux-mediatek/patch/1609223471-24325-1-git-send-email-andrew-sh.cheng@mediatek.com/
> [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
> ---
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 424fc89cc6f7..181ec2db7a69 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -55,6 +55,7 @@ cpu0: cpu@0 {
>   			clock-frequency = <1701000000>;
>   			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
>   			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 1>;

There's a mistake here: this should be <&performance 0>;

>   			capacity-dmips-mhz = <530>;
>   		};
>   
> @@ -66,6 +67,7 @@ cpu1: cpu@100 {
>   			clock-frequency = <1701000000>;
>   			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
>   			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 1>;

Same here

>   			capacity-dmips-mhz = <530>;
>   		};
>   
> @@ -77,6 +79,7 @@ cpu2: cpu@200 {
>   			clock-frequency = <1701000000>;
>   			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
>   			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 1>;

and here

>   			capacity-dmips-mhz = <530>;
>   		};
>   
> @@ -88,6 +91,7 @@ cpu3: cpu@300 {
>   			clock-frequency = <1701000000>;
>   			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
>   			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 1>;

....and here.

Regards,
Angelo
