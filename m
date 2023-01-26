Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DE267D434
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjAZSbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjAZSa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:30:59 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98D09029;
        Thu, 26 Jan 2023 10:30:56 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id h10so1138821ilq.6;
        Thu, 26 Jan 2023 10:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BtZAD+XajG4Ff3lpRNxc5VU6XMKBXj9jHvhDyP5qqKs=;
        b=KPsDp1ZwjFTTJ9gseCa1sE6zHCopqeOf/Sg/pl/lSTGYaq7YbyYzCXFfjgqTaFoz2y
         /78jOoWSVY8fpqVWeng2kRq1uHlIVfjJo7BnEpJ7D7749rrhv/gM4JQ7e5gNp5OOTSdH
         efknyTybs2voRsrloxjG8Gs+qgrtOdoGgrjDdP6ayo/IQLrbKCIJAKXfbJCARC22Cwpl
         N9UuoCUe7mDjrqiLucD+/LF55z+jxisMJ4WSqcBWYYm9fVDz+u3PZVxldCN9GJol1BvT
         zq2K+sIX0tzzWEKLiZXjq6Xt41mwrgMDI5LT6r7+On7DMs2nuTaFTyLzRfXxAztNrTA6
         FuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BtZAD+XajG4Ff3lpRNxc5VU6XMKBXj9jHvhDyP5qqKs=;
        b=Q7HautlicMRnXFrqA5hxrpjMP6GGtb19j8DP6tSQhAK6m4ymOCIYEpbans2LxQ8xVs
         r43kBhX6y0AmBy7PSWXHzJHOSfEnWhO/RPRHirTyRqYsdR/lcKqc+WnUuRQKV39xKr2v
         1Sdhm/MoVr5WQGC/X0IU619kKGG8UX15pq8V2roiJ9izn7R2hq+s7tHv7vi984IUfj7B
         3eX7QuabzB3I9qZbZB4jdM1HTxKY2UAJV4UhrV+lJjHuKYY90gmewp+xVCA6Xjdu8cE6
         ccFwGuefCxDMHDbzNan/tSjfY4HSIC4ir037i4KowkAuvfQ1JxIILw6VupXHD5OHuPcs
         voNQ==
X-Gm-Message-State: AFqh2kowD5I67IwNFYkCH+dRWAWQIxZjOqKAwcWobNCTU81xvk6tYULp
        /wkGc02DrQYggg29PzM7XoHLx9xFVdGG5D6y8dtnzBlMaOw=
X-Google-Smtp-Source: AMrXdXs7ZAjEie6unF52csPKnYMHWPA0TToP3oo+e6ede7qZNmS9Jv0sLRReSaXYHZxccnUNnT9ZZeW+MZ0E6f7JTY8=
X-Received: by 2002:a92:6a05:0:b0:30d:ba97:90e2 with SMTP id
 f5-20020a926a05000000b0030dba9790e2mr4343477ilc.38.1674757856075; Thu, 26 Jan
 2023 10:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20230125025126.787431-1-gregory.price@memverge.com>
 <20230125025126.787431-2-gregory.price@memverge.com> <20230126003008.GA31684@redhat.com>
 <CANaxB-xn0wW5xA_CT7bA5=jig+td__EDKPBWSpZdfgMgVOezCg@mail.gmail.com>
 <20230126150725.GB4069@redhat.com> <CANaxB-woave9F479O75P9PC+nFO3DVmbeFA1rXf2c=bhRmWoiQ@mail.gmail.com>
 <Y9K92SQnrXhd0qjC@memverge.com>
In-Reply-To: <Y9K92SQnrXhd0qjC@memverge.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 26 Jan 2023 10:30:44 -0800
Message-ID: <CANaxB-yL8-4DWMb4h9bBXSZBJ=RrPQuJw76mz0CFkX-3f4Pq_w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 9:52 AM Gregory Price
<gregory.price@memverge.com> wrote:
>
> On Thu, Jan 26, 2023 at 09:45:39AM -0800, Andrei Vagin wrote:
> > On Thu, Jan 26, 2023 at 7:07 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > On 01/25, Andrei Vagin wrote:
> > > >
> > > > On Wed, Jan 25, 2023 at 4:30 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > >
> > > > > On 01/24, Gregory Price wrote:
> > > > > >
> > > > > > Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
> > > > > > modify Syscall User Dispatch to suspend interception when enabled.
> > > > > >
> > > > > > This is modeled after the SUSPEND_SECCOMP feature, which suspends
> > > > > > SECCOMP interposition.  Without doing this, software like CRIU will
> > > > > > inject system calls into a process and be intercepted by Syscall
> > > > > > User Dispatch, either causing a crash (due to blocked signals) or
> > > > > > the delivery of those signals to a ptracer (not the intended behavior).
> > > > >
> > > > > Cough... Gregory, I am sorry ;)
> > > > >
> > > > > but can't we drop this patch to ?
> > > > >
> > > > > CRIU needs to do PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG and check
> > > > > config->mode anyway as we discussed.
> > > > >
> > > > > Then it can simply set *config->selector = SYSCALL_DISPATCH_FILTER_ALLOW
> > > > > with the same effect, no?
> > > >
> > > > Oleg,
> > > >
> > > > PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH is automatically cleared when
> > > > a tracer detaches. It is critical when tracers detach due to unexpected
> > > > reasons
> > >
> > > IIUC, PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH is needed to run the injected
> > > code, and this also needs to change the state of the traced process. If
> > > the tracer (CRIU) dies while the tracee runs this code, I guess the tracee
> > > will have other problems?
> >
> > Our injected code can reheal itself if something goes wrong. The hack
> > here is that we inject
> > the code with a signal frame and it calls rt_segreturn to resume the process.
> >
> > We want to have this functionality for most cases. I don't expect that
> > the syscall user dispatch
> > is used by many applications, so I don't strongly insist on
> > PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH. In addition, if we know a user dispatch
> > memory region, it can be enough to inject our code out of this region
> > without disabling SUD.
> >
> > Thanks,
> > Andrei
>
> The region is exclusive, so syscalls *outside* [offset, offset+len]
> produce a dispatch. That means you would have to inject into that region.

You are right. I missed that. So it depends how large a region is and
whether it has enough
free space to inject our code.

Out of curiosity, do you know any real app that use SUD? I think it
was implemented for wine,
but they haven't started using it yet.

Thanks,
Andrei
