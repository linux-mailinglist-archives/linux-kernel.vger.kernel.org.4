Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4A661FD7C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiKGSZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiKGSY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:24:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8F20E7;
        Mon,  7 Nov 2022 10:24:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 993FD1FB;
        Mon,  7 Nov 2022 10:25:03 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2BC83F534;
        Mon,  7 Nov 2022 10:24:55 -0800 (PST)
Message-ID: <bb36df3f-5aee-256a-4d64-eaeb9bff998e@arm.com>
Date:   Mon, 7 Nov 2022 19:24:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 07/23] arm64: dts: Update cache properties for exynos
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-8-pierre.gondois@arm.com>
 <84b57a5c-3b29-3e40-8375-8496baabdbc9@linaro.org>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <84b57a5c-3b29-3e40-8375-8496baabdbc9@linaro.org>
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



On 11/7/22 18:55, Krzysztof Kozlowski wrote:
> On 07/11/2022 16:57, Pierre Gondois wrote:
>> The DeviceTree Specification v0.3 specifies that the cache node
>> 'compatible' and 'cache-level' properties are 'required'. Cf.
>> s3.8 Multi-level and Shared Cache Nodes
>> The 'cache-unified' property should be present if one of the
>> properties for unified cache is present ('cache-size', ...).
>>
>> Update the Device Trees accordingly.
> 
> Why do you send it again? This was applied.
> 
> What is more - you have way too many recipients. Mail servers reject it.
> It's impossible even to reply to it...
> 
>>   			cache-sets = <2048>;
> 
> Best regards,
> Krzysztof
> 

Yes, this patch must be dropped.
Sorry for the trouble,

Regards,
Pierre
