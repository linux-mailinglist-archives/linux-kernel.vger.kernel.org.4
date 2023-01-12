Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ABF666FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbjALKbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbjALKaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:30:20 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 168245566A;
        Thu, 12 Jan 2023 02:27:14 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 12 Jan 2023 19:27:14 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id E94292059054;
        Thu, 12 Jan 2023 19:27:13 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 12 Jan 2023 19:27:13 +0900
Received: from [10.212.157.104] (unknown [10.212.157.104])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 50398179F;
        Thu, 12 Jan 2023 19:27:13 +0900 (JST)
Message-ID: <65428915-ab7a-3325-612d-5b99e97dc617@socionext.com>
Date:   Thu, 12 Jan 2023 19:27:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 20/23] arm64: dts: Update cache properties for
 socionext
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-21-pierre.gondois@arm.com>
 <29f24401-8e39-ea40-52f6-a03c428ca445@arm.com>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <29f24401-8e39-ea40-52f6-a03c428ca445@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 2023/01/12 17:33, Pierre Gondois wrote:
> (subset for cc list)
> Hello,
> Just a reminder in case the patch was forgotten,
> Regards,
> Pierre
> 
> On 11/7/22 16:57, Pierre Gondois wrote:
>> The DeviceTree Specification v0.3 specifies that the cache node
>> 'compatible' and 'cache-level' properties are 'required'. Cf.
>> s3.8 Multi-level and Shared Cache Nodes
>> The 'cache-unified' property should be present if one of the
>> properties for unified cache is present ('cache-size', ...).
>>
>> Update the Device Trees accordingly.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>    arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 1 +
>>    arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 ++
>>    arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 1 +
>>    3 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
>> b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
>> index 1c76b4375b2e..6e1e00939214 100644
>> --- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
>> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
>> @@ -52,6 +52,7 @@ cpu1: cpu@1 {
>>
>>    		l2: l2-cache {
>>    			compatible = "cache";
>> +			cache-level = <2>;
>>    		};
>>    	};
>>
>> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
>> b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
>> index 9308458f9611..db7d20a1a301 100644
>> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
>> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
>> @@ -86,10 +86,12 @@ cpu3: cpu@101 {
>>
>>    		a72_l2: l2-cache0 {
>>    			compatible = "cache";
>> +			cache-level = <2>;
>>    		};
>>
>>    		a53_l2: l2-cache1 {
>>    			compatible = "cache";
>> +			cache-level = <2>;
>>    		};
>>    	};
>>
>> diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
>> b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
>> index b0c29510a7da..9ce544c9ea0a 100644
>> --- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
>> +++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
>> @@ -83,6 +83,7 @@ cpu3: cpu@3 {
>>
>>    		l2: l2-cache {
>>    			compatible = "cache";
>> +			cache-level = <2>;
>>    		};
>>    	};
>>

Looks good to me. "cache-unified" will be added with other cache-related
(size etc.) properties if needed.

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

---
Best Regards
Kunihiko Hayashi
