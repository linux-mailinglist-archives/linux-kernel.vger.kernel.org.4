Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3704666C83
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbjALIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239709AbjALIfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:35:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7451511C0E;
        Thu, 12 Jan 2023 00:34:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4983FFEC;
        Thu, 12 Jan 2023 00:35:14 -0800 (PST)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 845673F71A;
        Thu, 12 Jan 2023 00:34:30 -0800 (PST)
Message-ID: <2a40c27a-fb0a-5c96-478f-0aaf4d348442@arm.com>
Date:   Thu, 12 Jan 2023 09:34:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2 02/23] arm64: dts: Update cache properties for amd
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-3-pierre.gondois@arm.com>
Content-Language: en-US
In-Reply-To: <20221107155825.1644604-3-pierre.gondois@arm.com>
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

On 11/7/22 16:56, Pierre Gondois wrote:
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
>   arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi
> index 93688a0b6820..9f2d983e082d 100644
> --- a/arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi
> +++ b/arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi
> @@ -163,38 +163,47 @@ CPU7: cpu@301 {
>   	};
>   
>   	L2_0: l2-cache0 {
> +		compatible = "cache";
>   		cache-size = <0x100000>;
>   		cache-line-size = <64>;
>   		cache-sets = <1024>;
>   		cache-unified;
> +		cache-level = <2>;
>   		next-level-cache = <&L3>;
>   	};
>   
>   	L2_1: l2-cache1 {
> +		compatible = "cache";
>   		cache-size = <0x100000>;
>   		cache-line-size = <64>;
>   		cache-sets = <1024>;
>   		cache-unified;
> +		cache-level = <2>;
>   		next-level-cache = <&L3>;
>   	};
>   
>   	L2_2: l2-cache2 {
> +		compatible = "cache";
>   		cache-size = <0x100000>;
>   		cache-line-size = <64>;
>   		cache-sets = <1024>;
>   		cache-unified;
> +		cache-level = <2>;
>   		next-level-cache = <&L3>;
>   	};
>   
>   	L2_3: l2-cache3 {
> +		compatible = "cache";
>   		cache-size = <0x100000>;
>   		cache-line-size = <64>;
>   		cache-sets = <1024>;
>   		cache-unified;
> +		cache-level = <2>;
>   		next-level-cache = <&L3>;
>   	};
>   
>   	L3: l3-cache {
> +		compatible = "cache";
>   		cache-level = <3>;
>   		cache-size = <0x800000>;
>   		cache-line-size = <64>;
