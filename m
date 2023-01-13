Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46ED66893D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjAMBms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbjAMBmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:42:45 -0500
X-Greylist: delayed 1799 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Jan 2023 17:42:42 PST
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D569E389D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 17:42:42 -0800 (PST)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 13 Jan 2023 10:12:41 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO ?10.178.36.63?) (10.178.36.63)
        by 156.147.1.125 with ESMTP; 13 Jan 2023 10:12:41 +0900
X-Original-SENDERIP: 10.178.36.63
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
Subject: Re: Re: [PATCH v2 10/23] arm64: dts: Update cache properties for lg
To:     Pierre Gondois <pierre.gondois@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Lee Gunho <gunho.lee@lge.com>
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-11-pierre.gondois@arm.com>
 <0fc92ab1-144a-47dd-e5c4-a165a82d385d@arm.com>
Message-ID: <1e36270f-237e-7069-ffe7-3086216b9d6b@lge.com>
Date:   Fri, 13 Jan 2023 10:12:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0fc92ab1-144a-47dd-e5c4-a165a82d385d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23. 1. 12. 오후 5:34에 Pierre Gondois 이(가) 쓴 글:
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

Acked-by: Chanho Min <chanho.min@lge.com>
>> ---
>>   arch/arm64/boot/dts/lg/lg1312.dtsi | 1 +
>>   arch/arm64/boot/dts/lg/lg1313.dtsi | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi 
>> b/arch/arm64/boot/dts/lg/lg1312.dtsi
>> index 78ae73d0cf36..25ed9aeee2dc 100644
>> --- a/arch/arm64/boot/dts/lg/lg1312.dtsi
>> +++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
>> @@ -48,6 +48,7 @@ cpu3: cpu@3 {
>>           };
>>           L2_0: l2-cache0 {
>>               compatible = "cache";
>> +            cache-level = <2>;
>>           };
>>       };
>> diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi 
>> b/arch/arm64/boot/dts/lg/lg1313.dtsi
>> index 2173316573be..db82fd4cc759 100644
>> --- a/arch/arm64/boot/dts/lg/lg1313.dtsi
>> +++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
>> @@ -48,6 +48,7 @@ cpu3: cpu@3 {
>>           };
>>           L2_0: l2-cache0 {Re: Re: [PATCH v2 10/23] arm64: dts: Update cache properties for lg
>>               compatible = "cache";
>> +            cache-leveRe: Re: [PATCH v2 10/23] arm64: dts: Update cache properties for lgl = <2>;
>>           };
>>       };
