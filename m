Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6981C666C77
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbjALIdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239547AbjALIdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:33:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79F4F227;
        Thu, 12 Jan 2023 00:33:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EBA412FC;
        Thu, 12 Jan 2023 00:34:14 -0800 (PST)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CC0C3F71A;
        Thu, 12 Jan 2023 00:33:30 -0800 (PST)
Message-ID: <29f24401-8e39-ea40-52f6-a03c428ca445@arm.com>
Date:   Thu, 12 Jan 2023 09:33:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2 20/23] arm64: dts: Update cache properties for
 socionext
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-21-pierre.gondois@arm.com>
Content-Language: en-US
In-Reply-To: <20221107155825.1644604-21-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(subset for cc list)
Hello,
Just a reminder in case the patch was forgotten,
Regards,
Pierre

On 11/7/22 16:57, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> The 'cache-unified' property should be present if one of the
> properties for unified cache is present ('cache-size', ...).
> 
> Update the Device Trees accordingly.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>   arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 1 +
>   arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 ++
>   arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 1 +
>   3 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> index 1c76b4375b2e..6e1e00939214 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> @@ -52,6 +52,7 @@ cpu1: cpu@1 {
>   
>   		l2: l2-cache {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> index 9308458f9611..db7d20a1a301 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> @@ -86,10 +86,12 @@ cpu3: cpu@101 {
>   
>   		a72_l2: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   
>   		a53_l2: l2-cache1 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> index b0c29510a7da..9ce544c9ea0a 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
> @@ -83,6 +83,7 @@ cpu3: cpu@3 {
>   
>   		l2: l2-cache {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
