Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C715B577B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiILJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiILJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:52:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 112B7222A7;
        Mon, 12 Sep 2022 02:52:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34E91113E;
        Mon, 12 Sep 2022 02:52:40 -0700 (PDT)
Received: from [10.57.49.22] (unknown [10.57.49.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EC8C3F71A;
        Mon, 12 Sep 2022 02:52:31 -0700 (PDT)
Message-ID: <0e5567ee-41ba-2364-5e5a-2a6626c08ed1@arm.com>
Date:   Mon, 12 Sep 2022 10:52:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] coresight: docs: Fix a broken reference
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org
References: <c7f864854e9e03916017712017ff59132c51c338.1659251193.git.christophe.jaillet@wanadoo.fr>
 <20220822160202.GB1583519@p14s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220822160202.GB1583519@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: acme

On 22/08/2022 17:02, Mathieu Poirier wrote:
> On Sun, Jul 31, 2022 at 09:06:48AM +0200, Christophe JAILLET wrote:
>> Since the commit in Fixes: tag, "coresight-cpu-debug.txt" has been turned
>> into "arm,coresight-cpu-debug.yaml".
>>
>> Update the doc accordingly to avoid a 'make htmldocs' warning
>>
>> Fixes: 66d052047ca8 ("dt-bindings: arm: Convert CoreSight CPU debug to DT schema")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   Documentation/trace/coresight/coresight-cpu-debug.rst | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
> 
> Applied.

fyi, there is another patch fixing the same here.

https://lkml.kernel.org/r/20815dbff3d27f5d3e6876363f052d2a08ad2e72.1660829433.git.mchehab@kernel.org

We may have to decide which one goes in.

Cheers
Suzuki

> 
> Thanks,
> Mathieu
> 
>> diff --git a/Documentation/trace/coresight/coresight-cpu-debug.rst b/Documentation/trace/coresight/coresight-cpu-debug.rst
>> index 993dd294b81b..836b35532667 100644
>> --- a/Documentation/trace/coresight/coresight-cpu-debug.rst
>> +++ b/Documentation/trace/coresight/coresight-cpu-debug.rst
>> @@ -117,7 +117,8 @@ divide into below cases:
>>   Device Tree Bindings
>>   --------------------
>>   
>> -See Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt for details.
>> +See Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml for
>> +details.
>>   
>>   
>>   How to use the module
>> -- 
>> 2.34.1
>>

