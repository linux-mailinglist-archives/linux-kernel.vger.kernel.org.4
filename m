Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B137666C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbjALIeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239669AbjALIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:33:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20E0D10065;
        Thu, 12 Jan 2023 00:33:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 040DBFEC;
        Thu, 12 Jan 2023 00:34:24 -0800 (PST)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 572C03F71A;
        Thu, 12 Jan 2023 00:33:40 -0800 (PST)
Message-ID: <35413b5c-0d83-0f37-9ea7-1217305c138b@arm.com>
Date:   Thu, 12 Jan 2023 09:33:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2 17/23] arm64: dts: Update cache properties for realtek
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org, devicetree@vger.kernel.org
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-18-pierre.gondois@arm.com>
Content-Language: en-US
In-Reply-To: <20221107155825.1644604-18-pierre.gondois@arm.com>
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
>   arch/arm64/boot/dts/realtek/rtd1293.dtsi | 1 +
>   arch/arm64/boot/dts/realtek/rtd1295.dtsi | 1 +
>   arch/arm64/boot/dts/realtek/rtd1296.dtsi | 1 +
>   arch/arm64/boot/dts/realtek/rtd1395.dtsi | 1 +
>   arch/arm64/boot/dts/realtek/rtd16xx.dtsi | 2 ++
>   5 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/realtek/rtd1293.dtsi b/arch/arm64/boot/dts/realtek/rtd1293.dtsi
> index 2d92b56ac94d..0696b99fc40d 100644
> --- a/arch/arm64/boot/dts/realtek/rtd1293.dtsi
> +++ b/arch/arm64/boot/dts/realtek/rtd1293.dtsi
> @@ -30,6 +30,7 @@ cpu1: cpu@1 {
>   
>   		l2: l2-cache {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
> index 1402abe80ea1..4ca322e420e6 100644
> --- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
> +++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
> @@ -44,6 +44,7 @@ cpu3: cpu@3 {
>   
>   		l2: l2-cache {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/realtek/rtd1296.dtsi b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
> index fb864a139c97..03fccd48f0c0 100644
> --- a/arch/arm64/boot/dts/realtek/rtd1296.dtsi
> +++ b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
> @@ -44,6 +44,7 @@ cpu3: cpu@3 {
>   
>   		l2: l2-cache {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/realtek/rtd1395.dtsi b/arch/arm64/boot/dts/realtek/rtd1395.dtsi
> index 05c9216a87ee..94c0a8cf4953 100644
> --- a/arch/arm64/boot/dts/realtek/rtd1395.dtsi
> +++ b/arch/arm64/boot/dts/realtek/rtd1395.dtsi
> @@ -44,6 +44,7 @@ cpu3: cpu@3 {
>   
>   		l2: l2-cache {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
> index afba5f04c8ec..2ee9ba1ecdc1 100644
> --- a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
> +++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
> @@ -87,12 +87,14 @@ cpu5: cpu@500 {
>   
>   		l2: l2-cache {
>   			compatible = "cache";
> +			cache-level = <2>;
>   			next-level-cache = <&l3>;
>   
>   		};
>   
>   		l3: l3-cache {
>   			compatible = "cache";
> +			cache-level = <3>;
>   		};
>   	};
>   
