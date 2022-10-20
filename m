Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC31660553F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJTBzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJTBzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:55:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0411F148F53;
        Wed, 19 Oct 2022 18:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2WkjNmweiW5UWvFDyTIcZUK41JmBY3NIJ3WWOjzemz4=; b=yix4Du8TvUlpQtqptrK+MKkL3z
        /ET3kalM77hPT3l6cx/BkcbjUVKBkwSwplYfuXRgJ9WOQ6FButJSZbMP+5V6MB7P/Ryg33i28lEP4
        +oCjfTdMsXUhKarpfrdoliN5qeym6d0ygAMgpVWD6rrk7WtUK8uswQdkzG04mNwtpurpG6fQe1udT
        Se2/1kfXz3Ct3emBhO80iKRfrL3NWFgHpGq/yT87KnL7F8fKCvNQcwAE5Tj/80CMuIx+YlrvGhBk6
        nDfyBbT0d/YKYDny9orz7JkmlFfc0/jiau2GCVzD8xoelbrh/CKvDdtYIGtb3NGidbIAhp4OGjk4b
        pIUiSmOA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olKlu-009Dnn-Qc; Thu, 20 Oct 2022 01:54:58 +0000
Message-ID: <d5a7c385-4155-af0c-ed51-865f274fa030@infradead.org>
Date:   Wed, 19 Oct 2022 18:54:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] of: fix repeated words in comments
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221019130200.60460-1-yuanjilin@cdjrlc.com>
 <9fb4c010-b465-e908-6868-d9e493a9688f@infradead.org>
 <Y1Cm2Hvf7W7NxVzk@mit.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y1Cm2Hvf7W7NxVzk@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/22 18:39, Theodore Ts'o wrote:
> On Wed, Oct 19, 2022 at 11:53:54AM -0700, Randy Dunlap wrote:
>>
>> On 10/19/22 06:02, Jilin Yuan wrote:
>>> Delete the redundant word 'of'.
>>>
>>> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
>>> ---
>>>  drivers/of/device.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>>> index 8cefe5a7d04e..16c7e5a2a868 100644
>>> --- a/drivers/of/device.c
>>> +++ b/drivers/of/device.c
>>> @@ -19,7 +19,7 @@
>>>  
>>>  /**
>>>   * of_match_device - Tell if a struct device matches an of_device_id list
>>> - * @matches: array of of device match structures to search in
>>> + * @matches: array of device match structures to search in
>>
>> Hi,
>> Rob has already explained this at least 2 times.
>>
>> The second "of" is "open firmware".
>> I would write it
>>               array of OF device match structures to search in
>> :)
> 
> Actually, I'd probably do something like
> 
>     	     array of Open Firmware (OF) device match structures...

Sure, that's good.

> This is the first place in that file (at least in a comment) where OF
> gets used, and I've always been a big fan of using the fully expanded
> acronym before using the acronym form.  Remember, PCMCIA stands for
> People Can't Memorize Computer Industry Acronyms.  :-)
> 
> (Actually, it's Personal Computer Memory Chip Industry Association,

                                           Card International Association :)

> but most people don't know that, because using acronyms without
> defining them first makes you feel like you're an "insider".  :-)


-- 
~Randy
