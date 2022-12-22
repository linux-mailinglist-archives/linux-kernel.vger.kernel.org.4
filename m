Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BF46540B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbiLVMIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiLVMHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:07:54 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CC230576
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:58:56 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n4so1830629plp.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=uqAGZ9Jl1ugDkGODMUauM9R6lPCE9WVjpJqEw8MulTg=;
        b=jNNWhzkoPcDSs01qx7It+I0JOsx5wDPFmcjZBmdo1M0JKCEJeQ6oVhrj0zzrqSyiLS
         ghWgCqam/fMQGQtJCNvCXVEdNRPPM8OW8Utc/jwJiwRHUqYIc7zLyAoDnUvQGqHnW8vQ
         dWHAkH/6mu+xVRoiMl+zLmyRqnNTOZ/2+d69BtZSgIZUzLarOP3BjWfbD+C5nuG+fm8r
         MdWM0tAiDR0kpLG/OcbG7aYlrJB6uDLgX49SCpONKvpLZVrftVTJrfeNhFrYamnM1Xly
         yK8Hs7pJilLwpbpTU8bIBrUDoJf10qq+twVyXNcTT4iWoeQEx6Vyzw+43mgQCLDGd+Fe
         vyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqAGZ9Jl1ugDkGODMUauM9R6lPCE9WVjpJqEw8MulTg=;
        b=nYbpXx7YrDgumiUJB5HQQBLGQluqBZ8Eg7K1gg/hbLCYTpr4cqKOHzGnaPSPOfjZNP
         PGXGXM7kqYRiOWeJ0gEJGp7esF9587dv67ZjvjWCTAaX9AgvbTlg0OLfhhMTI2N6PH0B
         OcQ2P5Lb/bNdtwdmBCyOCPCoaCwtx1onzfZDIzU0m/ldL6O0wCsxpBNvVbtk394ew/lt
         0UzWJCLO1tpTxK5Fo781wl0q54FOrTKBEMc9lrHCbx500B5U+0rtnvN+PxuhGffoStwO
         pmOZn11c9MzGf+MtILTJ5Uxe+mxWxeusqexXZ/2Z9hh1MytSmrL83CyhylXMoNLxjmJf
         ci2A==
X-Gm-Message-State: AFqh2kr7bFRQvSkY42s4Go2wtp4+9x0N7hGRKWJWPAM174+a9z93wK4b
        isWmjda5WlQ0ky4OKCWnN12hvxb5kcg=
X-Google-Smtp-Source: AMrXdXuIpK52XdG8oAdtePBmQvM/7yRhIW3K9yeWMMu9f7OjFCAZyqKWPZ/RGI+2DX4fiBg+enoitQ==
X-Received: by 2002:a17:902:f7c3:b0:18f:5bc0:5892 with SMTP id h3-20020a170902f7c300b0018f5bc05892mr5222407plw.0.1671710317543;
        Thu, 22 Dec 2022 03:58:37 -0800 (PST)
Received: from MBP ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902e38200b00186b0ac12c5sm357965ple.172.2022.12.22.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 03:58:37 -0800 (PST)
References: <20221115140233.21981-1-schspa@gmail.com>
 <m2zgc2vzwx.fsf@gmail.com> <Y5a3rAm21mCf2xrG@bombadil.infradead.org>
 <m2bko8c0yh.fsf@gmail.com> <m2pmcoag55.fsf@gmail.com>
 <Y5kE2eAa8EZUxx5b@bombadil.infradead.org>
 <Y5oqxh2jnarlEKNG@bombadil.infradead.org> <m2o7s55gan.fsf@gmail.com>
 <m2ili43s2v.fsf@gmail.com> <Y6P2MUcTGU9LIrDg@bombadil.infradead.org>
 <m235983p58.fsf@gmail.com>
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
Date:   Thu, 22 Dec 2022 19:56:26 +0800
In-reply-to: <m235983p58.fsf@gmail.com>
Message-ID: <m2bknv3b1a.fsf@gmail.com>
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
>> On Thu, Dec 22, 2022 at 01:45:46PM +0800, Schspa Shi wrote:
>>> 
>>> Schspa Shi <schspa@gmail.com> writes:
>>> 
>>> > Luis Chamberlain <mcgrof@kernel.org> writes:
>>> >
>>> >> Peter, Ingo, Steven would like you're review.
>>> >>
>>> >> On Tue, Dec 13, 2022 at 03:03:53PM -0800, Luis Chamberlain wrote:
>>> >>> On Mon, Dec 12, 2022 at 09:38:31PM +0800, Schspa Shi wrote:
>>> >>> > I'd like to upload a V2 patch with the new solution if you prefer the
>>> >>> > following way.
>>> >>> > 
>>> >>> > diff --git a/kernel/umh.c b/kernel/umh.c
>>> >>> > index 850631518665..8023f11fcfc0 100644
>>> >>> > --- a/kernel/umh.c
>>> >>> > +++ b/kernel/umh.c
>>> >>> > @@ -452,6 +452,11 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>>> >>> >                 /* umh_complete() will see NULL and free sub_info */
>>> >>> >                 if (xchg(&sub_info->complete, NULL))
>>> >>> >                         goto unlock;
>>> >>> > +               /*
>>> >>> > +                * kthreadd (or new kernel thread) will call complete()
>>> >>> > +                * shortly.
>>> >>> > +                */
>>> >>> > +               wait_for_completion(&done);
>>> >>> >         }
>>> >>> 
>>> >>> Yes much better. Did you verify it fixes the splat found by the bots?
>>> >>
>>> >> Wait, I'm not sure yet why this would fix it... I first started thinking
>>> >> that this may be a good example of a Coccinelle SmPL rule, something like:
>>> >>
>>> >> 	DECLARE_COMPLETION_ONSTACK(done);
>>> >> 	foo *foo;
>>> >> 	...
>>> >> 	foo->completion = &done;
>>> >> 	...
>>> >> 	queue_work(system_unbound_wq, &foo->work);
>>> >> 	....
>>> >> 	ret = wait_for_completion_state(&done, state);
>>> >> 	...
>>> >> 	if (!ret)
>>> >> 		S
>>> >> 	...
>>> >> 	+wait_for_completion(&done);
>>> >>
>>> >> But that is pretty complex, and while it may be useful to know how many
>>> >> patterns we have like this, it begs the question if generalizing this
>>> >> inside the callers is best for -ERESTARTSYS condition is best. What
>>> >> do folks think?
>>> >>
>>> >> The rationale here is that if you queue stuff and give access to the
>>> >> completion variable but its on-stack obviously you can end up with the
>>> >> queued stuff complete() on a on-stack variable. The issue seems to
>>> >> be that wait_for_completion_state() for -ERESTARTSYS still means
>>> >> that the already scheduled queue'd work is *about* to run and
>>> >> the process with the completion on-stack completed. So we race with
>>> >> the end of the routine and the completion on-stack.
>>> >>
>>> >> It makes me wonder if wait_for_completion() above really is doing
>>> >> something more, if it is just helping with timing and is still error
>>> >> prone.
>>> >>
>>> >> The queued work will try the the completion as follows:
>>> >>
>>> >> static void umh_complete(struct subprocess_info *sub_info)
>>> >> {
>>> >> 	struct completion *comp = xchg(&sub_info->complete, NULL);              
>>> >> 	/*
>>> >> 	 * See call_usermodehelper_exec(). If xchg() returns NULL
>>> >> 	 * we own sub_info, the UMH_KILLABLE caller has gone away
>>> >> 	 * or the caller used UMH_NO_WAIT.
>>> >> 	 */
>>> >> 	if (comp)
>>> >> 		complete(comp);
>>> >> 	else
>>> >> 		call_usermodehelper_freeinfo(sub_info);
>>> >> }
>>> >>
>>> >> So the race is getting -ERESTARTSYS on the process with completion
>>> >> on-stack and the above running complete(comp). Why would sprinkling
>>> >> wait_for_completion(&done) *after* wait_for_completion_state(&done, state)
>>> >> fix this UAF?
>>> >
>>> > The wait_for_completion(&done) is added when xchg(&sub_info->complete,
>>> > NULL) return NULL. When it returns NULL, it means the umh_complete was
>>> > using the completion variable at the same time and will call complete
>>> > in a very short time.
>>> >
>>> Hi Luis:
>>> 
>>> Is there any further progress on this problem? Does the above
>>> explanation answer your doubts?
>>
>> I think it would be useful to proove your work for you to either
>> hunt with SmPL coccinelle a similar flaw / how rampant this issue
>> is and then also try to create the same UAF there and prove how
>> your changes fixes it.
>>
>
> OK, but it will take some time.

Hi Luis:

I have made a kernel module to prove this fix. Please check this at:
Link: https://github.com/schspa/code_snippet/tree/master/kernel_module/completion

There is both bad & ok test case in the README.org.

>
>>   Luis


-- 
BRs
Schspa Shi
