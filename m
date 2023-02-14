Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02EA69C63A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjBTICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBTICS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:02:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A3DDBEB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:02:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d1-20020a17090a3b0100b00229ca6a4636so585484pjc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=UqC7n3VH+n8GfMbsztpunswhFKvAkQPi/7k1PclfOTE=;
        b=fc/UjfJhSG9oflX54j0F99s3aWyHaJUP/jPPSafE1crbwW0jTibHzfJvjFpWm6D08R
         /upaC5fTSpTeAlqRfDeNSLYXtvP6EXeVxa3XzjRFSK8G6Dg2E/o/73l3C354eQdXg9IV
         gBeTpAtU/utQkX9eluoFIoKpXX3kIehZMkjabFXMdpY+WTpbfK/2owD1t2QrYumMkxDH
         hAlUGZhOIrL8lLupq4+9cn9mG5QxlPWBvoHqZhWpsxNcfipRO18So43iRsYibKT3MFcg
         j1ue8MQ7r793kEFijwqT1J2uHxW6TvXh7BCcyzd7qn5fqw61FhINMxO+z0m4dnzMx7j7
         zljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqC7n3VH+n8GfMbsztpunswhFKvAkQPi/7k1PclfOTE=;
        b=wUMDz6f3ylfOGsc3xtTPoPv9naqvcZ99NjbI2aduuWmIgbE/k/ZJIimtBaXWX/4U9u
         mttQ5r3mFfVfSpaBKHoEqKlX4y0oSH/bvkijnKJv+McSptA9XMSvJARbS/7FKdv6+s1w
         6lBimfpruNivlfSwv28qD8Ktpzo7f/rYebTNZVgSlIPDWbUPjkDQRmi1r87m5wtl64Fx
         rvAgfxb5+fe/BT1pqkbA+1M//KiLeFmSU3Y6h4V+ls4dFdZ6Pe2uFCeHDriWUZv4U06o
         C/Vw9/K3L5MzFNbBMHIkSEOkkzFMVA+wXb9WNozJhD7vAi9rnyVEGLazOSCDdkQxSUCc
         +XVQ==
X-Gm-Message-State: AO0yUKWyJ+q5qob9P1Lp7mN4nzezIiam7JT+gxwQHCTLOQ03bwFb9uU3
        Oe5nOuev26rRMM1YFAXxQUc=
X-Google-Smtp-Source: AK7set+v3dazeFTPJLLPjemVnzrKsWM1UX7VdZAwzwYQHC4W8Z68fyS9jmWS3+VrkOixVEzC/Bks9g==
X-Received: by 2002:a17:90b:4b0a:b0:233:d108:1c62 with SMTP id lx10-20020a17090b4b0a00b00233d1081c62mr382678pjb.32.1676880134883;
        Mon, 20 Feb 2023 00:02:14 -0800 (PST)
Received: from MBP ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id bf18-20020a17090b0b1200b002341c0ff245sm185738pjb.19.2023.02.20.00.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 00:02:14 -0800 (PST)
References: <20230127014137.4906-1-hdanton@sina.com>
 <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
 <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
 <Y9z76ZLe4On96xIN@hirez.programming.kicks-ass.net>
 <Y9z+SerR8mlZYo16@hirez.programming.kicks-ass.net>
 <6c47dbcf-2a17-6bb2-719b-841d851c603b@I-love.SAKURA.ne.jp>
 <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
 <caa13441-5f95-b7d6-dd5d-1cf49e709714@I-love.SAKURA.ne.jp>
 <Y+Eh9CFdTwwv+hot@bombadil.infradead.org>
 <Y+pWzult7UDgoilC@hirez.programming.kicks-ass.net>
User-agent: mu4e 1.8.10; emacs 29.0.60
From:   Schspa Shi <schspa@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Date:   Tue, 14 Feb 2023 10:31:58 +0800
In-reply-to: <Y+pWzult7UDgoilC@hirez.programming.kicks-ass.net>
Message-ID: <m21qmkahoj.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Feb 06, 2023 at 07:51:16AM -0800, Luis Chamberlain wrote:
>
>> I think this seems to be the same issue that Schspa Shi reported / provided a
>> fix sugggestion for [0]. This lead me to ask if:
>> 
>>   a) incorrect usage of completion on stack could be generic and;
>>   b) if we should instead have an API helper for that?
>> 
>> Although he already implemented a suggestion for b) to answer a) we need
>> some SmPL constructs yet to be written by Schspa. The reason I asked for
>> b) is that if this is a regular pattern it begs for a) as this sort of
>> issue could be prevalent in other places. So the status of Schspa's work
>> was that he was going to work on the SmPL grammar to check how frequent
>> this incorrect patern could be found.
>
> Do I read correctly, from you above alphabet-soup, that someone is
> working on some static analysis for on-stack completions or something?
>

Yes, I was trying to do this.

> If so, perhaps the simplest rule would to be ensure there is an
> unconditional uninterruptible wait-for-completion() before going out of
> scope.
>
> This latter can be spelled like wait_for_completion() or
> wait_for_completion_state(TASK_UNINTERRUPTIBLE). More specifically,
> TASK_INTERRUPTIBLE and TASK_WAKEKILL must not be set in the state mask
> for the wait to be uninterruptible.
>
> If it cannot be proven, raise a warning and audit or somesuch.

This is a good suggestion. I have written a SmPL patch to complete this
check, and now I need to rule out the situation that the driver has
added an additional lock to protect it.

And I have found a lot of bad usage, should we consider adding a new
helper API to simplify the fix this?

Such as:

+
+void complete_on_stack(struct completion **x)
+{
+       struct completion *comp = xchg(*x, NULL);
+
+       if (comp)
+               complete(comp);
+}
+EXPORT_SYMBOL(complete_on_stack);
+
+int __sched wait_for_completion_state_on_stack(struct completion **x,
+                                       unsigned int state)
+{
+       struct completion *comp = *x;
+       int retval;
+
+       retval = wait_for_completion_state(comp, state);
+       if (retval) {
+               if (xchg(*x, NULL))
+                       return retval;
+
+               /*
+                * complete_on_stack will call complete shortly.
+                */
+               wait_for_completion(comp);
+       }
+
+       return retval;
+}
+EXPORT_SYMBOL(wait_for_completion_state_on_stack);

Link: https://lore.kernel.org/all/20221115140233.21981-1-schspa@gmail.com/T/#mf6a41a7009bb47af1b15adf2b7b355e495f609c4

-- 
BRs
Schspa Shi
