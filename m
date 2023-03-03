Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C26A960F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCCLYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjCCLYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:24:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F73F5D744;
        Fri,  3 Mar 2023 03:24:01 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6A62A6602FA9;
        Fri,  3 Mar 2023 11:23:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677842639;
        bh=LUrVv03ntRmaeynFxWkF0Aq+0D78B7f2QaRdCqFRvhk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jSAHtSW5Iqlv5VvIbGIv6Z7RfnLmv3y5WjWuOkns1KNiX2UAdBwHqGwSyAWagFWB4
         +CUVL5JgWWslgsszY92F/yC+KjCGEuJ1qhyeE0Cq2Wn1w5/7XgXJ09UrAxKXNbuZrk
         pdpxbBRQkiIXkWOuMM63fGMVR1cKZsbYqtpQPBFpCA8EidRWLwaiOF6dJUP2DEoYIk
         eVhn9UFNROI6XSq9/Mr6LCBG1s6F5VyJv1IVDepfxpBgwd9gjnQN4Y+U4ZWsKrvItM
         7uAmvwc2dyytyjg4A4K64rk/sGx5V8c0AC/6IZXmk5LIO3X/R6pScIXA+vEf8nLHqV
         Bd2Iz9y46+AkA==
Message-ID: <a1e5bc34-2feb-2832-73dd-25d3d64807f7@collabora.com>
Date:   Fri, 3 Mar 2023 12:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] arm64: dts: mediatek: Add cpufreq nodes for MT8192
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230303020014.23580-1-allen-kh.cheng@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230303020014.23580-1-allen-kh.cheng@mediatek.com>
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

Il 03/03/23 03:00, Allen-KH Cheng ha scritto:
> Add the cpufreq nodes for MT8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
> Change in v1:
>      Fix : this should be <&performance 0>

I didn't say that *all of them should be <&performance 0>.

It's 0 for the cortex-a55 CPUs and it's 1 for the A76 CPUs.

Please fix it.



>      [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
> ---
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 87b91c8feaf9..48a4fc88fde4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -70,6 +70,7 @@
>   			d-cache-line-size = <64>;
>   			d-cache-sets = <128>;
>   			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 0>;
>   			capacity-dmips-mhz = <530>;
>   		};
>   
> @@ -87,6 +88,7 @@
>   			d-cache-line-size = <64>;
>   			d-cache-sets = <128>;
>   			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 0>;
>   			capacity-dmips-mhz = <530>;
>   		};
>   
> @@ -104,6 +106,7 @@
>   			d-cache-line-size = <64>;
>   			d-cache-sets = <128>;
>   			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 0>;
>   			capacity-dmips-mhz = <530>;
>   		};
>   
> @@ -121,6 +124,7 @@
>   			d-cache-line-size = <64>;
>   			d-cache-sets = <128>;
>   			next-level-cache = <&l2_0>;
> +			performance-domains = <&performance 0>;
>   			capacity-dmips-mhz = <530>;
>   		};

It's 0 until there.

>   
> @@ -138,6 +142,7 @@
>   			d-cache-line-size = <64>;
>   			d-cache-sets = <256>;
>   			next-level-cache = <&l2_1>;
> +			performance-domains = <&performance 0>;

Here, and later (for cortex-a76), it's <&performance 1>.


Regards,
Angelo

