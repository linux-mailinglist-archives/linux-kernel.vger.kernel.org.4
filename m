Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E341A6C5351
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjCVSJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCVSJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:09:32 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76FD64AAF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:09:23 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h7so10345352ila.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679508563;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=plxbgMDX93fMUAGEgDUYOIVmtx+5Rm3a0wI5NQLcJgs=;
        b=g/hVkXIYrF/poGLcM758+V4y4249o9ejrRovuOpFrLrAB32PMszu6CHzDgG0v2ZK0i
         La8uNVSgMbE8MX4ahyGE4zfACKsPpQZCo6W8ZYxLMwug5uhig97HrFgGb8bVgyX4tHrB
         tK3tHDBGwGXixqwqVycZ94wpu7JWjmaCxOt1a9wPrz3bQaJ4nX4PaQu4zj5ewBcCwUCT
         du6hAgQAGoWvmVC6a6eeRZiYSGiqBq3EXvbrnCG6QeUPcmebpw/1PHQsTSE4CB/TdCyE
         SygTJFhmtBJwaoddxfsVLAgPJh4fIDyn4mAZAL8eTPN6I+aK7dsX0UxML8HDJtptsPMl
         B/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679508563;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plxbgMDX93fMUAGEgDUYOIVmtx+5Rm3a0wI5NQLcJgs=;
        b=y2eVo2SXG9z8CcaDDleOExrDplGcFozY+yN5uetdIo0oHzkcPCHlDbCf6SiDc+kINO
         BJOyyF+xBSj1REpurlrMvRIyomCz5rTMhL6tHQdoju6BipB4MFqjkU7ZiTT0+HsSZH8u
         43empdL/ehqk9oFkQpttNOrN7bwb3UkwR0wwL+VTCyszAQBYAj2ENXpIutzcAB6ZdhLx
         yvad4dlnITo4F4JOFI9XvUE4lIwpnJXviY1RrjQE+Af8lZ6aFfW+NyHxF589nplTmPsI
         HCraunoCZgmZAnJg+zc4I1GT0EZfPQ1EHigkGBz7ZL4hNUf76Vzgx1nTiKe3OboulfO0
         aLDA==
X-Gm-Message-State: AO0yUKXRbQ5a7TGTv+EpOiapsABdYEvFK37W/UjzXL0DqC6E0IaTwb1t
        Ue/tvC0AAsLmW2XXM9rWMX0=
X-Google-Smtp-Source: AK7set+G8Ov0Pd6BKPbsh6xm7iAzTz1GUGkrsWL7M5Vv8+JH/C5jA5EC/B8j1xjAg3kkE5ucsmgXxw==
X-Received: by 2002:a92:d78b:0:b0:323:2468:ba20 with SMTP id d11-20020a92d78b000000b003232468ba20mr4686658iln.10.1679508562770;
        Wed, 22 Mar 2023 11:09:22 -0700 (PDT)
Received: from ArchLinux ([125.122.223.69])
        by smtp.gmail.com with ESMTPSA id a17-20020a056e0208b100b00315785bfabfsm4452398ilt.47.2023.03.22.11.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 11:09:22 -0700 (PDT)
References: <20230303161906.831686-1-schspa@gmail.com> <87bkl9jt3a.ffs@tglx>
 <m2ttycd8kx.fsf@gmail.com> <87sfdw8yru.ffs@tglx>
User-agent: mu4e 1.7.5; emacs 28.2
From:   Schspa Shi <schspa@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     longman@redhat.com, swboyd@chromium.org, linux@roeck-us.net,
        wuchi.zero@gmail.com, linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] debugobject: fix concurrency issues with
 is_static_object
Date:   Thu, 23 Mar 2023 01:55:34 +0800
In-reply-to: <87sfdw8yru.ffs@tglx>
Message-ID: <m2r0tgmze9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, Mar 22 2023 at 23:40, Schspa Shi wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>>> +	} else {
>>>> +		/*
>>>> +		 * The debug object is inited, and we should check this again
>>>> +		 */
>>>> +		if (obj->is_static) {
>>>> +			raw_spin_unlock_irqrestore(&db->lock, flags);
>>>> +			return;
>>>
>>> This is broken. If the object is static and already hashed and in active
>>> state then this returns and fails to detect the re-initialization of an
>>> active object.
>>>
>>
>> Yes, it's right, this can be fixed by pass a skip_ifstatic parameters
>> from debug_object_activate. then re-initialization of an active object
>> can be detected.
>
>>>> -static __initdata struct self_test obj = { .static_init = 0 };
>>>> +static struct self_test obj __initdata = { .static_init = 0 };
>>>> +static struct self_test sobj __initdata = { .static_init = 1 };
>>>
>>> ...
>>>
>>>> -	obj.static_init = 1;
>>>
>>> Plus the s/obj/sobj/ which should be equivalent, unless I'm missing
>>> something here.
>>>
>>
>> We have saved the is_static state when it is used at the first time, so
>> the is_static_object function won't be called in this environment.
>
> There is zero requirement for saving that state.
>
>>>  lib/debugobjects.c |  127 +++++++++++++++++++++++++++--------------------------
>>>  1 file changed, 67 insertions(+), 60 deletions(-)
>>>
>>> --- a/lib/debugobjects.c
>>> +++ b/lib/debugobjects.c
>>> @@ -216,10 +216,6 @@ static struct debug_obj *__alloc_object(
>>>  	return obj;
>>>  }
>>>  
>>> -/*
>>> - * Allocate a new object. If the pool is empty, switch off the debugger.
>>> - * Must be called with interrupts disabled.
>>> - */
>>>  static struct debug_obj *
>>>  alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
>>>  {
>>> @@ -273,7 +269,7 @@ alloc_object(void *addr, struct debug_bu
>>>  	if (obj) {
>>>  		obj->object = addr;
>>>  		obj->descr  = descr;
>>> -		obj->state  = ODEBUG_STATE_NONE;
>>> +		obj->state  = ODEBUG_STATE_INIT;
>>
>> This actually droped the ODEBUG_STATE_NONE state. If we active a
>> uninitialized object, there will be no error report.
>
> Indeed.
>
>> This should be
>>
>> if (descr->is_static_object && descr->is_static_object(addr))
>> 	obj->state  = ODEBUG_STATE_INIT;
>> else
>> 	obj->state  = ODEBUG_STATE_NONE;
>
> Kinda.
>
>> But this can't resolve the initial state requirement from the
>> is_static_object() call.
>
> Which requirement? The is_static_object() call takes the address of the
> actual object and has nothing to do with the tracking object at all.
>

This is for the fellowing test case, actually we calls
debug_object_free() from a static object in our selftest, if we don't
report any thing when call debug_object_free from a static object, we
there is no such issues.

	obj.static_init = 1;
	debug_object_activate(&obj, &descr_type_test);
	if (check_results(&obj, ODEBUG_STATE_ACTIVE, fixups, warnings))
		goto out;
	debug_object_init(&obj, &descr_type_test);
	if (check_results(&obj, ODEBUG_STATE_INIT, ++fixups, ++warnings))
		goto out;


    /*
     * We need to remove the debug_object_free here, because it's not
     * a legal operation.
     */
-	debug_object_free(&obj, &descr_type_test);
-	if (check_results(&obj, ODEBUG_STATE_NONE, fixups, warnings))
-		goto out;

#if 0
    /*
     * for the static debugobject, it's initial value will be changed
     * once used.
     */
	obj.static_init = 2;
	debug_object_activate(&obj, &descr_type_test);
	if (check_results(&obj, ODEBUG_STATE_ACTIVE, fixups, warnings))
		goto out;

    /* This test will fail */
#endif

>> I think we can report an error when calling debug_object_free() from a
>> static object. If don't do so, there is no way to determine it's a
>> static object.
>
> The memory allocator will tell you loudly when you try to free a static
> object. So no point in having another check.
>
>> When its initialization state changes, the is_static_object() call
>> will return the wrong value.
>
> That call is only relevant on the first invocation when there is no
> tracking object yet. So what's the problem you are trying to solve?
>
>> Please see the fellowing test case:
>>
>> 	obj.static_init = 1;
>
> This is pointless, really. Once the object is tracked it does not matter
> at all whether it was statically or dynamically allocated.
>
>>
>> I test this patch, with my above change, and it seems to work well, but
>> we still need to add extra flags to store its static state. And
>> debug_object_free() should report an error for the static object.
>
> No, we don't.
>

OK, we don't need to store the state if don't take care the
debug_object_free() call on static object at all. If so, we should
delete the debug_object_free() call on static object at
debug_objects_selftest().

>> I think we should introduce lookup_object_or_alloc and is_static at the
>> same time.
>
> What for?
>

To report an error when someone calls debug_object_free on a static
object.

> Thanks,
>
>         tglx


-- 
BRs
Schspa Shi
