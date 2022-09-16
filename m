Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A805BB47C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIPWsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIPWr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:47:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7056BC12C;
        Fri, 16 Sep 2022 15:47:56 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id j10so14247410qtv.4;
        Fri, 16 Sep 2022 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4UN6rVo6TRkPRLDAd9Nj/BMhSxTHqQ7tDhHpRCi4e6w=;
        b=R3b6yokPpwEbkE6buJQoqA+ykdxp5kd504uIprQmighOuHu8Ft0U54AdwakbUL1s55
         LkTthninLiXDGOrB8C2OFziiJlNfFXtdOGP+GMVgYHgSpRBv0Mtm2jBxExhUN3TmCVaz
         Ll+R8dmOQZniHYFXUPKv5kv7mwbbIjGoj7E+k0rNRFvl+5JBw47WdidDwBszK+d0KH2a
         Znz48BAuSRYH104m6aEEA2m30ZJTGqPlMmNuUdRgGNfGz0dyEr40NNlV7HnsOpxV6yzc
         lkCQabk2qNeEoKNzFSQ7zHqgzMLHHVhZpTzU1T970fEEjty8MUSTe2F6dPdWMWxwC/QY
         YCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4UN6rVo6TRkPRLDAd9Nj/BMhSxTHqQ7tDhHpRCi4e6w=;
        b=oSUjGu83IlONISGQAa0B5DoFpJK/i/nnM5fUoJSI3SQytvrxgYCLJeZur6qfmtyoYP
         Q3YC9VeZ+0IPuYO7lxXiShvShe9uSVIVJgjeADnn2kjH5IngcGRyAm4xu/a/iNwO70HQ
         xi5d0j+sI7ZTbAMVxWmvyQ+blkGxWYVUpx8U+SDIfULPG9XCZd2T4Rc+A1HPlqpbUuLr
         UiFC6+xBvGbW6KgHu8hgcZ8N+dpKdcG28R0outIQlE+aCbsLtRqNDYdVSr+PBD1xbzcO
         o+yMlnbct9yetvAx4SpyBJ6yS7PonD6zsS+9SfFg06Gt8e+2pkNhsuaTTm9uU0waKQBp
         9k3w==
X-Gm-Message-State: ACrzQf3et5zP4seHskGIWdJJ3S6WXdNHGxAeCDgyZ9qvrq8qaBoNN1pR
        AEGrCyiWAEHLNfjHGkaSTN8=
X-Google-Smtp-Source: AMsMyM6KhDlX1ZpZNVs11zMlzVe9omt5iBMqONAOEGLf/8VrI3d9n6j0eY+XzTGisiCp3GRaxDqxnw==
X-Received: by 2002:ac8:5794:0:b0:35b:fd92:6fae with SMTP id v20-20020ac85794000000b0035bfd926faemr6283220qta.429.1663368475999;
        Fri, 16 Sep 2022 15:47:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:90c9:b1c1:5c9e:9030? ([2600:1700:2442:6db0:90c9:b1c1:5c9e:9030])
        by smtp.gmail.com with ESMTPSA id q8-20020a05620a0d8800b006ce407b996asm7376152qkl.69.2022.09.16.15.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 15:47:55 -0700 (PDT)
Message-ID: <00850627-7ada-3a02-158c-30f3b8334d51@gmail.com>
Date:   Fri, 16 Sep 2022 17:47:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] driver: of: overlay: demote message to warning
Content-Language: en-US
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907230709.271889-1-danielwa@cisco.com>
 <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
 <20220908003510.GE4320@zorba>
 <c0c66918-f55e-83e4-edea-b2d32fdb27a7@gmail.com>
 <3fcea82c-f5cf-f066-67b9-08669c44a9c6@gmail.com>
 <20220912170524.GX4320@zorba>
 <75e803f8-2b25-22c8-0831-e90d0c889da1@gmail.com>
 <20220913005153.GZ4320@zorba>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220913005153.GZ4320@zorba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 19:51, Daniel Walker wrote:
> On Mon, Sep 12, 2022 at 03:32:31PM -0500, Frank Rowand wrote:
>> On 9/12/22 12:05, Daniel Walker wrote:
>>> On Mon, Sep 12, 2022 at 01:45:40AM -0500, Frank Rowand wrote:
>>>> On 9/8/22 12:55, Frank Rowand wrote:
>>>>> On 9/7/22 19:35, Daniel Walker wrote:
>>>>>> On Wed, Sep 07, 2022 at 06:54:02PM -0500, Frank Rowand wrote:
>>>>>>> On 9/7/22 18:07, Daniel Walker wrote:
>>>>>>>> This warning message shows by default on the vast majority of overlays
>>>>>>>> applied. Despite the text identifying this as a warning it is marked
>>>>>>>> with the loglevel for error. At Cisco we filter the loglevels to only
>>>>>>>> show error messages. We end up seeing this message but it's not really
>>>>>>>> an error.
>>>>>>>>
>>>>>>>> For this reason it makes sense to demote the message to the warning
>>>>>>>> loglevel.
>>>>>>>>
>>>>>>>> Cc: xe-linux-external@cisco.com
>>>>>>>> Signed-off-by: Daniel Walker <danielwa@cisco.com>
>>>>>>>> ---
>>>>>>>>  drivers/of/overlay.c | 2 +-
>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>>>>>>>> index bd8ff4df723d..4ae276ed9a65 100644
>>>>>>>> --- a/drivers/of/overlay.c
>>>>>>>> +++ b/drivers/of/overlay.c
>>>>>>>> @@ -358,7 +358,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>>>>>>>  	}
>>>>>>>>  
>>>>>>>>  	if (!of_node_check_flag(target->np, OF_OVERLAY))
>>>>>>>> -		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>>>>>>>> +		pr_warn("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>>>>>>>>  		       target->np, new_prop->name);
>>>>>>>>  
>>>>>>>>  	if (ret) {
>>>>>>>
>>>>>>> NACK
>>>>>>>
>>>>>>> This is showing a real problem with the overlay.
>>>>>>
>>>>>> What's the real problem ?
>>>>>>
>>>>>> Daniel
>>>>>
>>>>> A memory leak when the overlay is removed.
>>>>>
>>>>> I'll send a patch to update the overlay file in Documumentation/devicetree/ to provide
>>>>> more information about this.  If you don't see a patch by tomorrow, feel free to
>>>>> ping me.
>>>>>
>>>>> -Frank
>>>>
>>>> The good news is that your question prodded me to start improving the in kernel documentation
>>>> of overlays.  The promised patch is a rough start at:
>>>>
>>>>    https://lore.kernel.org/all/20220912062615.3727029-1-frowand.list@gmail.com/
>>>>
>>>> The bad news is that what I wrote doesn't explain the memory leak in any more detail.
>>>> If an overlay adds a property to a node in the base device tree then the memory
>>>> allocated to do the add will not be freed when the overlay is removed.  Since it is
>>>> possible to add and remove overlays multiple times, the ensuing size of the memory
>>>> leak is potentially unbounded.
>>>
>>> Isn't this only a problem if you remove the overlay?
>>
>> Yes, but we don't know if the overlay will be removed.  And I will not accept a
>> change that suppresses the message if there is no expectation to remove the
>> overlay.
>  
> I haven't researched the whole overlay system but there was one removal function
> that I noted, I think in the link you provided above, called
> of_overlay_remove(). It appears to call free_overlay_changeset() which calls kfree().

free_overlay_changeset() frees data structures related to the changeset.  It does not
free memory allocated to the devicetree.  The memory allocated to the devicetree is
freed as a result of the decreasing reference counts on the devicetree data.

> 
> so your API seems to deal with freeing the memory. I would think the expectation is that
> people using the API would free the overlay thru your API.

Yes, the way to remove an overlay is of_overlay_remove() or of_overlay_remove_all().

> 
> The only in tree usage of your API (besides the unit test) was drm/rcar-du which
> had no ability to remove the overlay that I can see. That component of the driver was
> removed several months ago.

rcar was an early overlay use that was grandfathered in for a long time until
we were finally able to remove it.  It was not a model for how to use overlays.

> 
>>>
>>> if the dt fixup driver does have the ability to remove the overlay doesn't it
>>> have responsibility to free the memory? Or is it impossible to free the memory?
>>
>> It is difficult due to architectural issues.  Reference counting occurs at the node
>> level, and not at the property level.  So memory related to properties is freed
>> when the corresponding overlay node reference count leads to the node being freed.
> 
> How does of_overlay_remove() work then? It seems like it might not be possible
> to do overlay removal, but your code has removal functions. I also see this one
> of_overlay_remove_all() ..
> 
> It seems like your API supports removal. Is there an issue where your API is
> maybe not complete or maybe doesn't currentily work ?

The overlay implementation is definitely not complete.  For some details please see:

   https://elinux.org/Device_Tree_Reference#Overlays

and:

   https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts

If you have not read those two links recently, _please_ read them for a better
understanding of the state of overlay implementation!


> 
> Maybe you could add a flag or other indicator which would indicate the overlay will never be
> removed. Then your code could rely on this property to inform on if the author
> has consider the removal issues related to overlays.

No.  I guess I wasn't clear enough above, where I said:

   "And I will not accept a
    change that suppresses the message if there is no expectation to remove the
    overlay."

There are multiple reasons for this, but the most fundamental is that if a
new overlay is not removable, then any overlay already applied can not be
removed (because overlays must be removed in the reverse order that they
are applied).  It would be incredibly bad architecture to allow an overlay
to block another overlay from being removed.

-Frank

> 
> Daniel

