Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14456EC368
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 03:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjDXB1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 21:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXB1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 21:27:11 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AD3610FD;
        Sun, 23 Apr 2023 18:27:09 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 24 Apr 2023 10:27:08 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 1B0CF2059050;
        Mon, 24 Apr 2023 10:27:08 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 24 Apr 2023 10:27:08 +0900
Received: from [10.212.159.183] (unknown [10.212.159.183])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id F3896E3BAE;
        Mon, 24 Apr 2023 10:27:06 +0900 (JST)
Message-ID: <f9a2c0d7-a78d-9368-f9bb-e8aba11e7d81@socionext.com>
Date:   Mon, 24 Apr 2023 10:27:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: dts: socionext: add missing cache properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230421223147.115156-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20230421223147.115156-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for your patch.
I'll take this when updating the devicetree for next.

Thank you,

On 2023/04/22 7:31, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified and cache-level properties to fix warnings like:
> 
>    uniphier-ld11-ref.dtb: l2-cache: 'cache-level' is a required property
>    uniphier-ld11-ref.dtb: l2-cache: 'cache-unified' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Please take the patch via sub-arch SoC tree.
> ---
>   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 ++
>   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 4 ++++
>   arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 ++
>   3 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> index 7bb36b071475..4680571c264d 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> @@ -52,6 +52,8 @@ cpu1: cpu@1 {
>   
>   		l2: l2-cache {
>   			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> index 4e2171630272..335093da6573 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> @@ -86,10 +86,14 @@ cpu3: cpu@101 {
>   
>   		a72_l2: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
>   		};
>   
>   		a53_l2: l2-cache1 {
>   			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> index 38ccfb46ea42..d6e3cc6fdb25 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> @@ -83,6 +83,8 @@ cpu3: cpu@3 {
>   
>   		l2: l2-cache {
>   			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
>   		};
>   	};
>   

---
Best Regards
Kunihiko Hayashi
