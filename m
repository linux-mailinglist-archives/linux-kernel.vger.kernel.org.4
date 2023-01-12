Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74436666C86
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbjALIgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbjALIfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:35:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B94153DBCC;
        Thu, 12 Jan 2023 00:34:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F638FEC;
        Thu, 12 Jan 2023 00:35:38 -0800 (PST)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DB823F71A;
        Thu, 12 Jan 2023 00:34:54 -0800 (PST)
Message-ID: <0fc92ab1-144a-47dd-e5c4-a165a82d385d@arm.com>
Date:   Thu, 12 Jan 2023 09:34:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2 10/23] arm64: dts: Update cache properties for lg
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Chanho Min <chanho.min@lge.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-11-pierre.gondois@arm.com>
Content-Language: en-US
In-Reply-To: <20221107155825.1644604-11-pierre.gondois@arm.com>
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
>   arch/arm64/boot/dts/lg/lg1312.dtsi | 1 +
>   arch/arm64/boot/dts/lg/lg1313.dtsi | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
> index 78ae73d0cf36..25ed9aeee2dc 100644
> --- a/arch/arm64/boot/dts/lg/lg1312.dtsi
> +++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
> @@ -48,6 +48,7 @@ cpu3: cpu@3 {
>   		};
>   		L2_0: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
> index 2173316573be..db82fd4cc759 100644
> --- a/arch/arm64/boot/dts/lg/lg1313.dtsi
> +++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
> @@ -48,6 +48,7 @@ cpu3: cpu@3 {
>   		};
>   		L2_0: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
