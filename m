Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3F164A1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiLLNrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiLLNq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:46:57 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E0210CD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:46:56 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j16so8931883qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=cJ9NU84AyBpwNvLFrjU87/BmZh36mcxF5lGPBeo1Qqo=;
        b=bWjGbjhf4h0GI7JCLZ1ckeejDx5cupyKwYhtiNyfmnNR/njvuPTu3c0xARoCruAOyq
         H1ZUX68s6YPZy1ykE9LwjleJXskqTp93AGH+PQa4K6Be/oHWsI1G9O/Go4oOOeAKC/83
         et2PMsHAjumlpYPI9VW8lbFR9w3g4mN1bY7JU0U0Vdm0lhXlcuk6sxRD3EfzbYP7IX6B
         5IdY91HBiz+fyee/ev2fn2ftZnpPAnukVg67lr/rU7UB3okmaPqRtH6Kf7c0OqTJPbJQ
         /DLW845zkxFCPv9wmSqpCYoA4wkYMFZDKGWnbHGHoA4v0vK89oQuLLaGKQm1sQPLqQZs
         7/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ9NU84AyBpwNvLFrjU87/BmZh36mcxF5lGPBeo1Qqo=;
        b=uii39muv/E4/xg4qBcSSk+4nFsm9JDWHZU9NP7Pf7V4dnlLQaWHwnnHr2K3Kb0jVea
         FalcwV14HO6DjE3ZN5ZpFYAoZ9wxLPujdXUW6soE5TcGTDkgxVOeCJIo+BubxqY2tH1F
         TTYfY2WobnUiAacHBEDAz+90p3xalUFCkItV0vgOqsbCV6X9EJp8gtEgCQn722STJSbO
         euA6jxfxshHmHOMPNN60Oa/x4o07tS5Tmvwb1p0/G5Ft++6IsvRhw0kc7WUybmhsJnRG
         OBYcUwFgZBn0GiyyBApFFZZOxXnY6y96DCHkZQnZBz9EC27HvzHS44ooTtOGzRz7hx+G
         Q2mw==
X-Gm-Message-State: ANoB5pnfrA1qU2nZr597y2VJcBmMt2m0Uv9KblPSlBhlem+jL3NZr5J+
        va76d7yR9cszC0zfQjnj6vQ=
X-Google-Smtp-Source: AA0mqf4Ef3l6l8EYiD0ypqo1Jwccdu8LIu7fefnogQnJmk1eLqyCiNJ83t5OcdL9kalU1vqRuqgrvg==
X-Received: by 2002:a05:622a:98c:b0:3a8:10c1:4ba with SMTP id bw12-20020a05622a098c00b003a810c104bamr10343465qtb.14.1670852815190;
        Mon, 12 Dec 2022 05:46:55 -0800 (PST)
Received: from MBP ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id s16-20020ac87590000000b003a6934255dasm5828625qtq.46.2022.12.12.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 05:46:54 -0800 (PST)
References: <20221115140233.21981-1-schspa@gmail.com>
 <m2zgc2vzwx.fsf@gmail.com> <Y5a3rAm21mCf2xrG@bombadil.infradead.org>
 <m2bko8c0yh.fsf@gmail.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Schspa Shi <schspa@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com,
        syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com,
        syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
Subject: Re: [PATCH] umh: fix UAF when the process is being killed
Date:   Mon, 12 Dec 2022 21:38:31 +0800
In-reply-to: <m2bko8c0yh.fsf@gmail.com>
Message-ID: <m2pmcoag55.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Schspa Shi <schspa@gmail.com> writes:

> Luis Chamberlain <mcgrof@kernel.org> writes:
>
>> On Mon, Dec 05, 2022 at 07:38:21PM +0800, Schspa Shi wrote:
>>> 
>>> Schspa Shi <schspa@gmail.com> writes:
>>> 
>>> > When the process is killed, wait_for_completion_state will return with
>>> > -ERESTARTSYS, and the completion variable in the stack will be freed.
>>
>> There is no free'ing here, it's just not availabel anymore, which is
>> different.
>>
>
> No, the whole thread stack will be freed when the process died. There
> will be some cases where it will be released. It will be more accurate
> to modify it to be unavailable.
>
>>> > If the user-mode thread is complete at the same time, there will be a UAF.
>>> >
>>> > Please refer to the following scenarios.
>>> >             T1                                  T2
>>> > ------------------------------------------------------------------
>>> > call_usermodehelper_exec
>>> >                                    call_usermodehelper_exec_async
>>> >                                    << do something >>
>>> >                                    umh_complete(sub_info);
>>> >                                    comp = xchg(&sub_info->complete, NULL);
>>> >                                    /* we got the completion */
>>> >                                    << context switch >>
>
> The sub_info->complete will be set to NULL.
>
>>> >
>>> >     << Being killed >>
>>> > 	retval = wait_for_completion_state(sub_info->complete, state);
>>> > 	if (!retval)
>>> > 		goto wait_done;
>>> >
>>> > 	if (wait & UMH_KILLABLE) {
>>> > 		/* umh_complete() will see NULL and free sub_info */
>>> > 		if (xchg(&sub_info->complete, NULL))
>>> > 			goto unlock;
>>> >         << we can't got the completion >>
>>
>> I'm sorry I don't understand what you tried to say here, we can't got?
>>
>
> In this scenario, the sub_info->complete will be NULL, at the
> call_usermodehelper_exec_async, and we will go to the unlock branch here.
>
>>> > 	}
>>> > 	....
>>> > unlock:
>>> > 	helper_unlock();
>>> > 	return retval;
>>> > }
>>> >
>>> > /**
>>> >  * the completion variable in stack is end of life cycle.
>>> >  * and maybe freed due to process is recycled.
>>> >  */
>>> >                                    --------UAF here----------
>>> >                                    if (comp)
>>> >                                        complete(comp);
>>> >
>>> > To fix it, we can put the completion variable in the subprocess_info
>>> > variable.
>>> >
>>> > Reported-by: syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com
>>> > Reported-by: syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com
>>> > Reported-by: syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
>>> >
>>> > Signed-off-by: Schspa Shi <schspa@gmail.com>
>>> > ---
>>> >  include/linux/umh.h | 1 +
>>> >  kernel/umh.c        | 6 +++---
>>> >  2 files changed, 4 insertions(+), 3 deletions(-)
>>> >
>>> > diff --git a/include/linux/umh.h b/include/linux/umh.h
>>> > index 5d1f6129b847..801f7efbc825 100644
>>> > --- a/include/linux/umh.h
>>> > +++ b/include/linux/umh.h
>>> > @@ -20,6 +20,7 @@ struct file;
>>> >  struct subprocess_info {
>>> >  	struct work_struct work;
>>> >  	struct completion *complete;
>>> > +	struct completion done;
>>> >  	const char *path;
>>> >  	char **argv;
>>> >  	char **envp;
>>> > diff --git a/kernel/umh.c b/kernel/umh.c
>>> > index 850631518665..3ed39956c777 100644
>>> > --- a/kernel/umh.c
>>> > +++ b/kernel/umh.c
>>> > @@ -380,6 +380,7 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
>>> >  	sub_info->cleanup = cleanup;
>>> >  	sub_info->init = init;
>>> >  	sub_info->data = data;
>>> > +	init_completion(&sub_info->done);
>>> >    out:
>>> >  	return sub_info;
>>> >  }
>>> > @@ -405,7 +406,6 @@ EXPORT_SYMBOL(call_usermodehelper_setup);
>>> >  int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>>> >  {
>>> >  	unsigned int state = TASK_UNINTERRUPTIBLE;
>>> > -	DECLARE_COMPLETION_ONSTACK(done);
>>> >  	int retval = 0;
>>> >  
>>> >  	if (!sub_info->path) {
>>> > @@ -431,7 +431,7 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>>> >  	 * This makes it possible to use umh_complete to free
>>> >  	 * the data structure in case of UMH_NO_WAIT.
>>> >  	 */
>>> > -	sub_info->complete = (wait == UMH_NO_WAIT) ? NULL : &done;
>>> > +	sub_info->complete = (wait == UMH_NO_WAIT) ? NULL : &sub_info->done;
>>> >  	sub_info->wait = wait;
>>> >  
>>> >  	queue_work(system_unbound_wq, &sub_info->work);
>>> > @@ -444,7 +444,7 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>>> >  	if (wait & UMH_FREEZABLE)
>>> >  		state |= TASK_FREEZABLE;
>>> >  
>>> > -	retval = wait_for_completion_state(&done, state);
>>> > +	retval = wait_for_completion_state(sub_info->complete, state);
>>> >  	if (!retval)
>>> >  		goto wait_done;
>>> 
>>> Hi Luis Chamberlain:
>>> 
>>> Could you help to review this patch? I'm not sure why we define the
>>> amount of completion here on the stack. But this UAF can be fixed by
>>> moving the completion variable to the heap.
>>
>> It would seem to me that if this is an issue other areas would have
>> similar races as well, so I was hard pressed about the approach / fix.
>>
>
> I think other modules will have similar bugs, but this is a limitation
> on the use of the DECLARE_COMPLETION_ONSTACK macro, and it has been
> specifically stated in the completion's documentation.
>
> There is the description from completion's documentation:
>
> Note that when using completion objects as local variables you must be
> acutely aware of the short life time of the function stack: the function
> must not return to a calling context until all activities (such as waiting
> threads) have ceased and the completion object is completely unused.
>
>> Wouldn't something like this be a bit more explicit about ensuring
>> we don't let the work item race beyond?
>>
>> diff --git a/kernel/umh.c b/kernel/umh.c
>> index 850631518665..55fc698115a7 100644
>> --- a/kernel/umh.c
>> +++ b/kernel/umh.c
>> @@ -447,6 +447,8 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>>  	retval = wait_for_completion_state(&done, state);
>>  	if (!retval)
>>  		goto wait_done;
>> +	else if (retval == -ERESTARTSYS)
>> +		cancel_work_sync(&sub_info->work);
>>
>
> I think this modification will make UMH_KILLABLE useless, we have to
> wait for this task to complete, even if it is killed.
>
>>  	if (wait & UMH_KILLABLE) {
>>  		/* umh_complete() will see NULL and free sub_info */

Hi Luis Chamberlain:

I checked the code from __kthread_create_on_node, and we can fix this
with the following change too.

I'd like to upload a V2 patch with the new solution if you prefer the
following way.

diff --git a/kernel/umh.c b/kernel/umh.c
index 850631518665..8023f11fcfc0 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -452,6 +452,11 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
                /* umh_complete() will see NULL and free sub_info */
                if (xchg(&sub_info->complete, NULL))
                        goto unlock;
+               /*
+                * kthreadd (or new kernel thread) will call complete()
+                * shortly.
+                */
+               wait_for_completion(&done);
        }

 wait_done:

-- 
BRs
Schspa Shi
