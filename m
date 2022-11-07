Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEDF61FCA7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiKGSDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiKGSCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:02:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23F03248FF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:59:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4F471FB;
        Mon,  7 Nov 2022 09:59:08 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B0C23F534;
        Mon,  7 Nov 2022 09:59:01 -0800 (PST)
Message-ID: <e5fe39f3-d000-5c07-a76c-044a3ac8dda5@arm.com>
Date:   Mon, 7 Nov 2022 18:58:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 06/23] arm64: dts: Update cache properties for broadcom
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-7-pierre.gondois@arm.com>
 <8ee17547-30ef-bc85-b163-f0d9efe70fcc@gmail.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <8ee17547-30ef-bc85-b163-f0d9efe70fcc@gmail.com>
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



On 11/7/22 18:31, Florian Fainelli wrote:
> (way too many recipients, gmail's SMTP server would not allow me to
> respond unless I moved most people to BCC now done).
> 
> On 11/7/22 07:56, Pierre Gondois wrote:
>> The DeviceTree Specification v0.3 specifies that the cache node
>> 'compatible' and 'cache-level' properties are 'required'. Cf.
>> s3.8 Multi-level and Shared Cache Nodes
>> The 'cache-unified' property should be present if one of the
>> properties for unified cache is present ('cache-size', ...).
>>
>> Update the Device Trees accordingly.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> Acked-by: William Zhang <william.zhang@broadcom.com>
> 
> This looks fine, but incomplete, you seem to have missed:
> 
> - adding 'cache-unified' to all of the cache nodes modified in this
> patch set that did not have one already
> 
> - bcm63148.dtsi, bcm63178.dtsi, bcm6756.dtsi, bcm6846.dtsi,
> bcm6855.dtsi, bcm6878.dtsi, bcm47622.dtsi
> 
> Thanks

I indeed forgot to update some platforms in the broadcom folder.
The other folders should be complete.

Regards,
Pierre
