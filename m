Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF2F653C55
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiLVGyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiLVGx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:53:58 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82721E17
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 22:53:54 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 36so728567pgp.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 22:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=4OmAIpeAO0xKj+FCFGJcB+X3l8zhr+fr8wmlOyK7Icg=;
        b=SkDi8PDbqV/SWCY5CCkEmyACOd5NC4qGoaZIWCYQpBr8J6hyeom895l5vc3JcOIBOW
         7L21516kgVWz437lEr2oaCDdPJwdapES/Wadh9/KXDBgFABfes5xDdf3Kr9tmRXSWK4F
         dCFgfDieM2j5qQn1CRU4gzOm1fR4LHk7xpZvRvotudbqB+0UNpO9EVlP7iHFQCm6oIVA
         dOphurflq33AaUQrmlzU5P5q8K2JemBbfoW2qxVvaAWZOX7R1itoEi8tKyERwcvKOOAj
         f5pBGXyw/6+3ex3ZopdEntbk+WaKvj7gAVhTUNl9n2gjMMfysljEEihDRpXiiLXfLIXA
         mT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OmAIpeAO0xKj+FCFGJcB+X3l8zhr+fr8wmlOyK7Icg=;
        b=6ywUMK+LibroBt00Nylx8sA+qbECuTilnozW7pZXu4PsDWUWWyJS9T+gkxeRXn7blE
         juIPgBf0oFTcAXo/ekvfW0Bx+lTHWK801BftEUpsHZ2lHH3vmIdenDmDN22co9lsIb7K
         2wh2/eGd+szWr3BIwCpiljm4x5Nj9XDd1UJ9aUb3JwgdkOum5xMUuRJ2eafFGgdKQWRJ
         iTPMg9lD+j1r1BNBOD+on/02fU9xi1yYxj3uohp7y5+qpk6hXlX+pxPslIQz31P9mxs1
         6vbeQN5adqX0YYsOz3tCOgnE+2VZcZtzUfPD0CZ0mZBGbFS9FRwOITSsfARBMT5O9Wu0
         a39A==
X-Gm-Message-State: AFqh2kqRKVOnMTXrjEVttj8YVsvuX7cJzZS8y7agJYLm+4inDdpQINnx
        G57k2mJfBzisZPm+zlUMyZ18CVq6D34=
X-Google-Smtp-Source: AMrXdXsLTeZ4rlXIAWKN8fZ2MJPxeNcekPuZcH8yjbjrySkC/sojMOCAp0STxJ49GwzvzKU8xgPfUw==
X-Received: by 2002:a62:150b:0:b0:577:509d:df80 with SMTP id 11-20020a62150b000000b00577509ddf80mr4900665pfv.24.1671692034460;
        Wed, 21 Dec 2022 22:53:54 -0800 (PST)
Received: from MBP (ec2-18-117-95-84.us-east-2.compute.amazonaws.com. [18.117.95.84])
        by smtp.gmail.com with ESMTPSA id y5-20020a623205000000b00575448ab0e9sm11658893pfy.123.2022.12.21.22.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 22:53:53 -0800 (PST)
References: <20221115140233.21981-1-schspa@gmail.com>
 <m2zgc2vzwx.fsf@gmail.com> <Y5a3rAm21mCf2xrG@bombadil.infradead.org>
 <m2bko8c0yh.fsf@gmail.com> <m2pmcoag55.fsf@gmail.com>
 <Y5kE2eAa8EZUxx5b@bombadil.infradead.org>
 <Y5oqxh2jnarlEKNG@bombadil.infradead.org> <m2o7s55gan.fsf@gmail.com>
 <m2ili43s2v.fsf@gmail.com> <Y6P2MUcTGU9LIrDg@bombadil.infradead.org>
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
Date:   Thu, 22 Dec 2022 14:50:21 +0800
In-reply-to: <Y6P2MUcTGU9LIrDg@bombadil.infradead.org>
Message-ID: <m235983p58.fsf@gmail.com>
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


Luis Chamberlain <mcgrof@kernel.org> writes:

> On Thu, Dec 22, 2022 at 01:45:46PM +0800, Schspa Shi wrote:
>> 
>> Schspa Shi <schspa@gmail.com> writes:
>> 
>> > Luis Chamberlain <mcgrof@kernel.org> writes:
>> >
>> >> Peter, Ingo, Steven would like you're review.
>> >>
>> >> On Tue, Dec 13, 2022 at 03:03:53PM -0800, Luis Chamberlain wrote:
>> >>> On Mon, Dec 12, 2022 at 09:38:31PM +0800, Schspa Shi wrote:
>> >>> > I'd like to upload a V2 patch with the new solution if you prefer the
>> >>> > following way.
>> >>> > 
>> >>> > diff --git a/kernel/umh.c b/kernel/umh.c
>> >>> > index 850631518665..8023f11fcfc0 100644
>> >>> > --- a/kernel/umh.c
>> >>> > +++ b/kernel/umh.c
>> >>> > @@ -452,6 +452,11 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>> >>> >                 /* umh_complete() will see NULL and free sub_info */
>> >>> >                 if (xchg(&sub_info->complete, NULL))
>> >>> >                         goto unlock;
>> >>> > +               /*
>> >>> > +                * kthreadd (or new kernel thread) will call complete()
>> >>> > +                * shortly.
>> >>> > +                */
>> >>> > +               wait_for_completion(&done);
>> >>> >         }
>> >>> 
>> >>> Yes much better. Did you verify it fixes the splat found by the bots?
>> >>
>> >> Wait, I'm not sure yet why this would fix it... I first started thinking
>> >> that this may be a good example of a Coccinelle SmPL rule, something like:
>> >>
>> >> 	DECLARE_COMPLETION_ONSTACK(done);
>> >> 	foo *foo;
>> >> 	...
>> >> 	foo->completion = &done;
>> >> 	...
>> >> 	queue_work(system_unbound_wq, &foo->work);
>> >> 	....
>> >> 	ret = wait_for_completion_state(&done, state);
>> >> 	...
>> >> 	if (!ret)
>> >> 		S
>> >> 	...
>> >> 	+wait_for_completion(&done);
>> >>
>> >> But that is pretty complex, and while it may be useful to know how many
>> >> patterns we have like this, it begs the question if generalizing this
>> >> inside the callers is best for -ERESTARTSYS condition is best. What
>> >> do folks think?
>> >>
>> >> The rationale here is that if you queue stuff and give access to the
>> >> completion variable but its on-stack obviously you can end up with the
>> >> queued stuff complete() on a on-stack variable. The issue seems to
>> >> be that wait_for_completion_state() for -ERESTARTSYS still means
>> >> that the already scheduled queue'd work is *about* to run and
>> >> the process with the completion on-stack completed. So we race with
>> >> the end of the routine and the completion on-stack.
>> >>
>> >> It makes me wonder if wait_for_completion() above really is doing
>> >> something more, if it is just helping with timing and is still error
>> >> prone.
>> >>
>> >> The queued work will try the the completion as follows:
>> >>
>> >> static void umh_complete(struct subprocess_info *sub_info)
>> >> {
>> >> 	struct completion *comp = xchg(&sub_info->complete, NULL);              
>> >> 	/*
>> >> 	 * See call_usermodehelper_exec(). If xchg() returns NULL
>> >> 	 * we own sub_info, the UMH_KILLABLE caller has gone away
>> >> 	 * or the caller used UMH_NO_WAIT.
>> >> 	 */
>> >> 	if (comp)
>> >> 		complete(comp);
>> >> 	else
>> >> 		call_usermodehelper_freeinfo(sub_info);
>> >> }
>> >>
>> >> So the race is getting -ERESTARTSYS on the process with completion
>> >> on-stack and the above running complete(comp). Why would sprinkling
>> >> wait_for_completion(&done) *after* wait_for_completion_state(&done, state)
>> >> fix this UAF?
>> >
>> > The wait_for_completion(&done) is added when xchg(&sub_info->complete,
>> > NULL) return NULL. When it returns NULL, it means the umh_complete was
>> > using the completion variable at the same time and will call complete
>> > in a very short time.
>> >
>> Hi Luis:
>> 
>> Is there any further progress on this problem? Does the above
>> explanation answer your doubts?
>
> I think it would be useful to proove your work for you to either
> hunt with SmPL coccinelle a similar flaw / how rampant this issue
> is and then also try to create the same UAF there and prove how
> your changes fixes it.
>

OK, but it will take some time.

>   Luis


-- 
BRs
Schspa Shi
