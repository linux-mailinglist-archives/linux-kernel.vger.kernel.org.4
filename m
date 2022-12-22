Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DCD653BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 06:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbiLVFuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 00:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiLVFud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 00:50:33 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2279321277
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 21:50:31 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id n3so509904pfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 21:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0W1EDHfGKhIMpM3FK/lUGK/n+v/pNCBWVvhghPhBCM=;
        b=j+Z4QR4rIdr3mrWYo9YxHBfsPet8KKFavpOCrKvCfe9ZutZS68xCA2Wkf4+jRXcgoM
         BN+6hRhGqanbQ1Z3Ay6JYt9G1cFuonSYyRxDA8eLWDq29EyCVnfeq2iMh4pPAc81KrAx
         zb/fCB8AY5EIY15Ig+znFZJM8EER/CwdmwZSONb2mKY1HpSluSxBQkIDrTbf7vT4zgz5
         c2llKpfvLuBDbMwUc07horn9lEl81iEsqCy8Q/hIzfAhEdpzhpkq7TbFF7n14537V6gC
         BE/qQj3ezkp9i1zh6dd4wxi/+T6WXT2hmNlKm+HG0iXoRtaxPJbMWbTuR9nR973HY9es
         hhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0W1EDHfGKhIMpM3FK/lUGK/n+v/pNCBWVvhghPhBCM=;
        b=tBgM9FyTbchzh/XjO7HPTqJVe2ts3+MWzfc97R5xyBnNLNIGhH+/aT2TeNg2vZY7Cc
         KbZj4NYe+1Kh5EDbaOTaN0W/M22J7o9BW+KbdwP6Giik7J28ghwbgl26ii5Rh5yxOthM
         OjL3HuHEPs8NCgm+5xgB6j1aGOEv6ceLgmozxpQe+NVJ0wrIB2kpKM88o/aTjlARpH6j
         TvpwoFGhqJUYlZN9kb3/WD+uvkFIQtVbICOAge8uyJnVkvOniC6KY+NvNqTOyatenuK2
         I6sfTfgz4XwoAZ1MKUvyMT2DMhJexecKguLDeyy3L9WeR5givZacMZ04tefvrpkvHiAr
         rnDg==
X-Gm-Message-State: AFqh2kriw7ptPOvz2CaIb3vA7YP265Z7A2DGrhzJv35mUvcSvZsOB05g
        guK3IVwzdEJxQAHILb6ZsiY=
X-Google-Smtp-Source: AMrXdXuIBij7LsOfobbiRzl6Q6RRjkrhKVBEDvjDBrZ1Qd7PuRwq8ZmO23cWKu3bBp4FWk9Yr61IuQ==
X-Received: by 2002:aa7:9f07:0:b0:575:cce2:cd83 with SMTP id g7-20020aa79f07000000b00575cce2cd83mr4822252pfr.5.1671688230513;
        Wed, 21 Dec 2022 21:50:30 -0800 (PST)
Received: from MBP ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id i25-20020aa796f9000000b00572198393c2sm11648402pfq.194.2022.12.21.21.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 21:50:29 -0800 (PST)
References: <20221115140233.21981-1-schspa@gmail.com>
 <m2zgc2vzwx.fsf@gmail.com> <Y5a3rAm21mCf2xrG@bombadil.infradead.org>
 <m2bko8c0yh.fsf@gmail.com> <m2pmcoag55.fsf@gmail.com>
 <Y5kE2eAa8EZUxx5b@bombadil.infradead.org>
 <Y5oqxh2jnarlEKNG@bombadil.infradead.org> <m2o7s55gan.fsf@gmail.com>
User-agent: mu4e 1.8.10; emacs 29.0.60
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
Date:   Thu, 22 Dec 2022 13:45:46 +0800
In-reply-to: <m2o7s55gan.fsf@gmail.com>
Message-ID: <m2ili43s2v.fsf@gmail.com>
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
>> Peter, Ingo, Steven would like you're review.
>>
>> On Tue, Dec 13, 2022 at 03:03:53PM -0800, Luis Chamberlain wrote:
>>> On Mon, Dec 12, 2022 at 09:38:31PM +0800, Schspa Shi wrote:
>>> > I'd like to upload a V2 patch with the new solution if you prefer the
>>> > following way.
>>> > 
>>> > diff --git a/kernel/umh.c b/kernel/umh.c
>>> > index 850631518665..8023f11fcfc0 100644
>>> > --- a/kernel/umh.c
>>> > +++ b/kernel/umh.c
>>> > @@ -452,6 +452,11 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>>> >                 /* umh_complete() will see NULL and free sub_info */
>>> >                 if (xchg(&sub_info->complete, NULL))
>>> >                         goto unlock;
>>> > +               /*
>>> > +                * kthreadd (or new kernel thread) will call complete()
>>> > +                * shortly.
>>> > +                */
>>> > +               wait_for_completion(&done);
>>> >         }
>>> 
>>> Yes much better. Did you verify it fixes the splat found by the bots?
>>
>> Wait, I'm not sure yet why this would fix it... I first started thinking
>> that this may be a good example of a Coccinelle SmPL rule, something like:
>>
>> 	DECLARE_COMPLETION_ONSTACK(done);
>> 	foo *foo;
>> 	...
>> 	foo->completion = &done;
>> 	...
>> 	queue_work(system_unbound_wq, &foo->work);
>> 	....
>> 	ret = wait_for_completion_state(&done, state);
>> 	...
>> 	if (!ret)
>> 		S
>> 	...
>> 	+wait_for_completion(&done);
>>
>> But that is pretty complex, and while it may be useful to know how many
>> patterns we have like this, it begs the question if generalizing this
>> inside the callers is best for -ERESTARTSYS condition is best. What
>> do folks think?
>>
>> The rationale here is that if you queue stuff and give access to the
>> completion variable but its on-stack obviously you can end up with the
>> queued stuff complete() on a on-stack variable. The issue seems to
>> be that wait_for_completion_state() for -ERESTARTSYS still means
>> that the already scheduled queue'd work is *about* to run and
>> the process with the completion on-stack completed. So we race with
>> the end of the routine and the completion on-stack.
>>
>> It makes me wonder if wait_for_completion() above really is doing
>> something more, if it is just helping with timing and is still error
>> prone.
>>
>> The queued work will try the the completion as follows:
>>
>> static void umh_complete(struct subprocess_info *sub_info)
>> {
>> 	struct completion *comp = xchg(&sub_info->complete, NULL);              
>> 	/*
>> 	 * See call_usermodehelper_exec(). If xchg() returns NULL
>> 	 * we own sub_info, the UMH_KILLABLE caller has gone away
>> 	 * or the caller used UMH_NO_WAIT.
>> 	 */
>> 	if (comp)
>> 		complete(comp);
>> 	else
>> 		call_usermodehelper_freeinfo(sub_info);
>> }
>>
>> So the race is getting -ERESTARTSYS on the process with completion
>> on-stack and the above running complete(comp). Why would sprinkling
>> wait_for_completion(&done) *after* wait_for_completion_state(&done, state)
>> fix this UAF?
>
> The wait_for_completion(&done) is added when xchg(&sub_info->complete,
> NULL) return NULL. When it returns NULL, it means the umh_complete was
> using the completion variable at the same time and will call complete
> in a very short time.
>
Hi Luis:

Is there any further progress on this problem? Does the above
explanation answer your doubts?

> Add wait_for_completion *after* wait_for_completion_state will make the
> interruptible/timeout version API not working anymore.
>
>> 												    }   
>> diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
>> index d57a5c1c1cd9..aa7031faca04 100644
>> --- a/kernel/sched/completion.c
>> +++ b/kernel/sched/completion.c
>> @@ -205,8 +205,10 @@ int __sched wait_for_completion_interruptible(struct completion *x)
>>  {
>>  	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE);
>>  
>> -	if (t == -ERESTARTSYS)
>> +	if (t == -ERESTARTSYS) {
>> +		wait_for_completion(x);
>>  		return t;
>> +	}
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(wait_for_completion_interruptible);
>> @@ -243,8 +245,10 @@ int __sched wait_for_completion_killable(struct completion *x)
>>  {
>>  	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_KILLABLE);
>>  
>> -	if (t == -ERESTARTSYS)
>> +	if (t == -ERESTARTSYS) {
>> +		wait_for_completion(x);
>>  		return t;
>> +	}
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(wait_for_completion_killable);
>> @@ -253,8 +257,10 @@ int __sched wait_for_completion_state(struct completion *x, unsigned int state)
>>  {
>>  	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
>>  
>> -	if (t == -ERESTARTSYS)
>> +	if (t == -ERESTARTSYS) {
>> +		wait_for_completion(x);
>>  		return t;
>> +	}
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(wait_for_completion_state);
>
> If we want to make it a generic fix, syntactic sugar can be added to
> simplify usage for users.
>
> Consider the following patch.
>
> diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
> index d57a5c1c1cd9..67b7d02c0098 100644
> --- a/kernel/sched/completion.c
> +++ b/kernel/sched/completion.c
> @@ -341,3 +341,33 @@ bool completion_done(struct completion *x)
>         return true;
>  }
>  EXPORT_SYMBOL(completion_done);
> +
> +void complete_on_stack(struct completion **x)
> +{
> +       struct completion *comp = xchg(*x, NULL);
> +
> +       if (comp)
> +               complete(comp);
> +}
> +EXPORT_SYMBOL(complete_on_stack);
> +
> +int __sched wait_for_completion_state_on_stack(struct completion **x,
> +                                       unsigned int state)
> +{
> +       struct completion *comp = *x;
> +       int retval;
> +
> +       retval = wait_for_completion_state(comp, state);
> +       if (retval) {
> +               if (xchg(*x, NULL))
> +                       return retval;
> +
> +               /*
> +                * complete_on_stack will call complete shortly.
> +                */
> +               wait_for_completion(comp);
> +       }
> +
> +       return retval;
> +}
> +EXPORT_SYMBOL(wait_for_completion_state_on_stack);


-- 
BRs
Schspa Shi
