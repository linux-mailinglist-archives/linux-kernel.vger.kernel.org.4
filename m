Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69213613823
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiJaNd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJaNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:33:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1B64101D8;
        Mon, 31 Oct 2022 06:33:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A70881FB;
        Mon, 31 Oct 2022 06:33:59 -0700 (PDT)
Received: from [10.57.7.114] (unknown [10.57.7.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D2FB3F703;
        Mon, 31 Oct 2022 06:33:50 -0700 (PDT)
Message-ID: <3c54db0a-44fe-ee24-1833-7637e249ec79@arm.com>
Date:   Mon, 31 Oct 2022 14:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 02/20] arm64: dts: Update cache properties for amlogic
To:     neil.armstrong@linaro.org, linux-kernel@vger.kernel.org
Cc:     Rob.Herring@arm.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20221031091918.531607-1-pierre.gondois@arm.com>
 <fac3eae5-687e-9eb0-ddfb-c659d3816d81@linaro.org>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <fac3eae5-687e-9eb0-ddfb-c659d3816d81@linaro.org>
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

Hello Neil,

On 10/31/22 10:51, Neil Armstrong wrote:
> Hi,
> 
> On 31/10/2022 10:19, Pierre Gondois wrote:
>> The DeviceTree Specification v0.3 specifies that the cache node
>> 'compatible' and 'cache-level' properties are 'required'. Cf.
>> s3.8 Multi-level and Shared Cache Nodes
>>
>> The recently added init_of_cache_level() function checks
>> these properties. Add them if missing.
> 
> Is this tied to a bindings change ? Since I'm only in CC to the 02/20 patch,
> I don't have the context here.

It is not tied to a binding change, it is just to align the DTs to the
DeviceTree spec to potentially prepare for having a common DT parsing code.

To avoid cc-ing people to DTs they are not related, the get_maintainers.pl
script was run on each patch individually. The cover-letter is at:
https://lore.kernel.org/all/20221031091848.530938-1-pierre.gondois@arm.com/


> 
> Neil
> 
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>    arch/arm64/boot/dts/amlogic/meson-a1.dtsi   | 1 +
>>    arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 1 +
>>    arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1 +
>>    arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 1 +
>>    arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 1 +
>>    arch/arm64/boot/dts/amlogic/meson-sm1.dtsi  | 1 +
>>    6 files changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> index b4000cf65a9a..d2f7cb4e5375 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> @@ -36,6 +36,7 @@ cpu1: cpu@1 {
>>    
>>    		l2: l2-cache0 {
>>    			compatible = "cache";
>> +			cache-level = <2>;
>>    		};
>>    	};
>>    
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index 04f797b5a012..1648e67afbb6 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -105,6 +105,7 @@ cpu3: cpu@3 {
>>    
>>    		l2: l2-cache0 {
>>    			compatible = "cache";
>> +			cache-level = <2>;
>>    		};
>>    	};
>>    
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> index fb0ab27d1f64..af23d7968181 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> @@ -50,6 +50,7 @@ cpu3: cpu@3 {
>>    
>>    		l2: l2-cache0 {
>>    			compatible = "cache";
>> +			cache-level = <2>;
>>    		};
>>    	};
>>    
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
>> index ee8fcae9f9f0..9978e619accc 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
>> @@ -105,6 +105,7 @@ cpu103: cpu@103 {
>>    
>>    		l2: l2-cache0 {
>>    			compatible = "cache";
>> +			cache-level = <2>;
>>    		};
>>    	};
>>    };
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index 023a52005494..e3c12e0be99d 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -132,6 +132,7 @@ cpu3: cpu@3 {
>>    
>>    		l2: l2-cache0 {
>>    			compatible = "cache";
>> +			cache-level = <2>;
>>    		};
>>    	};
>>    
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> index 80737731af3f..d845eb19d93d 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>> @@ -88,6 +88,7 @@ cpu3: cpu@3 {
>>    
>>    		l2: l2-cache0 {
>>    			compatible = "cache";
>> +			cache-level = <2>;
>>    		};
>>    	};
>>    
> 
