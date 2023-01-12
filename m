Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9E666F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjALK1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjALK0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:26:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA8B21B9;
        Thu, 12 Jan 2023 02:23:13 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DFAE56602DAB;
        Thu, 12 Jan 2023 10:23:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673518991;
        bh=hS2H0a3ptc3YuE9h2MNVIG6ow1PNq2RWuA8fASP77XU=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=hGczgOjzan6yiGBXczrM/B3CCIqpx3KGdXAuB8JIyMpRqarWgcvV71D4A6CPHwVlK
         ggAtrwoGpoD8JZwidFTPZsr8Ip8TW+N3KlxXT9TcK/R+CpbhVOXIykxI8a9n7WvhOk
         mTgW144dsIExqYHBnUr9u8ZWKji3sIk4oLry/1cMpdyBYMCeven7cWDYPflgunik+C
         muzE49oSDuOLK5ufxAcWsgg7pt4t4asSvxC6sgMVJAakE5S1iCa69QJ0NSLoxMP36D
         xp7e24G/b66O7n975XIOrXlkHZbAel6ygRjGX03wVawjrGPhTbFP6vyRGI3G8XpqA/
         TjtjKvZvbQS+g==
Message-ID: <c8cb5ae1-10f1-8065-d6ac-dc5a24827462@collabora.com>
Date:   Thu, 12 Jan 2023 11:23:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] USB: gadget: Add ID numbers to configfs-gadget driver
 names
To:     Chanh Nguyen <chanh@amperemail.onmicrosoft.com>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Li <frank.li@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Vacura <w36195@motorola.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Vijayavardhan Vennapusa <vvreddy@codeaurora.org>,
        Rondreis <linhaoguo86@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Open Source Submission <patches@amperecomputing.com>
References: <20230111065105.29205-1-chanh@os.amperecomputing.com>
 <4e98a5ee-96a1-eb98-8529-68f36c3cb7fa@collabora.com>
 <f9e653ce-52bb-cb89-8845-2a718e76b718@amperemail.onmicrosoft.com>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <f9e653ce-52bb-cb89-8845-2a718e76b718@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

W dniu 12.01.2023 o 09:33, Chanh Nguyen pisze:
> 
> 
> On 11/01/2023 16:46, Andrzej Pietrasiewicz wrote:
>> Hello,
>>
>> W dniu 11.01.2023 o 07:51, Chanh Nguyen pisze:
>>> It is unable to use configfs to attach more than one gadget. When
>>> attaching the second gadget, it always fails and the kernel message
>>> prints out:
>>>
>>> Error: Driver 'configfs-gadget' is already registered, aborting...
>>> UDC core: g1: driver registration failed: -16
>>>
>>> This commit fixes the problem by using the gadget name as a suffix
>>> to each configfs_gadget's driver name, thus making the names
>>> distinct.
>>>
>>> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
>>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>>>
>>> ---
>>> Changes in v3:
>>>    - Use the gadget name as a unique suffix instead     [Andrzej]
>>>    - Remove the driver.name allocation by template        [Chanh]
>>>    - Update commit message                                [Chanh]
>>>
>>> Changes in v2:
>>>    - Replace scnprintf() by kasprintf() to simplify the code [CJ]
>>>    - Move the clean up code from gadgets_drop() to
>>>      gadget_info_attr_release()                        [Frank Li]
>>>    - Correct the resource free up in gadges_make()   [Alan Stern]
>>>    - Remove the unnecessary variable in gadgets_make()    [Chanh]
>>>    - Fixes minor grammar issue in commit message          [Chanh]
>>> ---
>>>   drivers/usb/gadget/configfs.c | 12 ++++++++++--
>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
>>> index 96121d1c8df4..0853536cbf2e 100644
>>> --- a/drivers/usb/gadget/configfs.c
>>> +++ b/drivers/usb/gadget/configfs.c
>>> @@ -393,6 +393,7 @@ static void gadget_info_attr_release(struct config_item 
>>> *item)
>>>       WARN_ON(!list_empty(&gi->string_list));
>>>       WARN_ON(!list_empty(&gi->available_func));
>>>       kfree(gi->composite.gadget_driver.function);
>>> +    kfree(gi->composite.gadget_driver.driver.name);
>>>       kfree(gi);
>>>   }
>>> @@ -1572,7 +1573,6 @@ static const struct usb_gadget_driver 
>>> configfs_driver_template = {
>>>       .max_speed    = USB_SPEED_SUPER_PLUS,
>>>       .driver = {
>>>           .owner          = THIS_MODULE,
>>> -        .name        = "configfs-gadget",
>>>       },
>>>       .match_existing_only = 1,
>>>   };
>>> @@ -1623,13 +1623,21 @@ static struct config_group *gadgets_make(
>>>       gi->composite.gadget_driver = configfs_driver_template;
>>> +    gi->composite.gadget_driver.driver.name = kasprintf(GFP_KERNEL,
>>> +                                "configfs-gadget.%s", name);
>>
>> This line is 88 chars long, which means you're taking advantage of checkpatch
>> allowing 100 columns nowadays. That's absolutely fine. If you collapse the above
>> two lines into one, the combined length is exactly 100 chars, so you might
>> just as well use a single line. In any case (collapsed or not) you can add my
>>
>> Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
>>
> 
> Thanks Andrzej for the review.
> 
> Just found out the commit title is not totally correct.
> It should be "usb: gadget: Append name as suffix to configfs-gadget driver names".
> 

Heh, good catch :D

"Append gadget name to configfs-gadget driver names?"

I'm not a native speaker, but to me "to append" is the opposite of "to prepend",
isn't it? So IMO "to append" already contains the notion of "adding at the end",
which is the same thing as a suffix. I also suggest it is better to qualify the
"name", it is not just any name, it is specifically a gadget name. If you only
insert the word "gadget" and don't remove "as suffix" then the title becomes
lengthy, hence my suggestion as above.

> I wonder if these issues could be fixed when get merged or should I resend a v4 
> with that two lines collapsed and with the title adjust?

If it is only about making the title better reflect patch contents and
whitespace changes I'd say it is ok to send a v4 with Reviewed-by and Tested-by
already added. Not making the maintainer think why there's no ID numbers is
a good thing. But then Greg's automaton might get confused if it sees a v4
without v1, 2 and 3 preceding it. I'm not sure how it reacts if you reply-to v3
with corrected title, either. On the flip side, if you send a new patch (without
any v number) in a new thread, you also make the maintainer think why the patch
already contains R-b and T-b, so...

Regards,

Andrzej

> 
> Thanks a lot,
> - Chanh
> 
>>> +    if (!gi->composite.gadget_driver.driver.name)
>>> +        goto err;
>>> +
>>>       gi->composite.gadget_driver.function = kstrdup(name, GFP_KERNEL);
>>>       gi->composite.name = gi->composite.gadget_driver.function;
>>>       if (!gi->composite.gadget_driver.function)
>>> -        goto err;
>>> +        goto out_free_driver_name;
>>>       return &gi->group;
>>> +
>>> +out_free_driver_name:
>>> +    kfree(gi->composite.gadget_driver.driver.name);
>>>   err:
>>>       kfree(gi);
>>>       return ERR_PTR(-ENOMEM);
>>

