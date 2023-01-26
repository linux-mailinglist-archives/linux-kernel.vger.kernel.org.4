Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1668067D4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjAZSyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjAZSyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:54:03 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6753817171;
        Thu, 26 Jan 2023 10:54:02 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id g16so1176142ilr.1;
        Thu, 26 Jan 2023 10:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HBEbKVDw11zt4F+SqG6UCCgSzhuLvRGk24lKfNho7DY=;
        b=gHRJTKOw35mXdNrWgexSwc3JdM0wQ7MQDsHwBoPR0d6pbEVdtWHtc4yE1b1ay8fZNE
         gJsTQTGOnh/H50HPuMyfNu2XyCaK3pnj2R6+xXJG1IsZM25/aadfUp2GxcdYkLusRRfP
         pKodeXzueIKLrbILmKOwcsV4hRZiLbSa/1iOUWgHL4M5BJF/dUm6LBTQhxTj3Ct1UmBX
         XCRhJK1THIpbFG7XO2R/x3PLzyL14GtDiC5NbkpPq5X+wcNey8GOkmMiysX/P5Ly5WXt
         9DcgYYVLLOlLdlQC+vbwCaUGKiZ3FxvQJI+4Kym/RiqvDTTnf9Zp8ui6KRu2/BubH1I8
         PM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBEbKVDw11zt4F+SqG6UCCgSzhuLvRGk24lKfNho7DY=;
        b=XJcX5q2uHoh+qAXk9Mmv0qzIctCWO4g2OyhAV5LFJv8q4qh2moGJQnK8+1qJAp+rMb
         p/Uvtmhy5kRAyGQqqhepNEaIoD1tmRRQ73elsm+6PdEqa5Z/QvA7shm+4/VPYddDX8uS
         2T1lOdOiBbKlgzDvJKiB3lqYChzsLp91Vm9GQMuQJHiXUZ4jQ3RgCwKtHtQl23qSi5MF
         w4sukxnJTQQjx/sKIN/v6+Re1PICqhDuhMLE40XtWseRNNTUWEdtbmtB4RT+In0cgu13
         oAOuggLb9/EdIYONm+/unLzbBe+DItBvuT9Bm+CkKeeiQGdFQ2pWkw7uBnrYnOA3L6Vb
         HCLA==
X-Gm-Message-State: AFqh2krRJ7TAw6ciyej0GndpRvpk91/ZUmPXDJH+pEvrFgCjFXaM7Z/A
        9pzLAlUT5pK9y5bEopzT7QnMe+yV+RKkS90tzjXu0Mt961utoA==
X-Google-Smtp-Source: AMrXdXsOHTa8S/oATosdbIDjVWGPJu+iROfMdQJa6/0K5t/uZV/S6fXtDeErE5WzoIKWIvQ4O3vkT6RR6LG01SZNBcg=
X-Received: by 2002:a92:6a05:0:b0:30d:ba97:90e2 with SMTP id
 f5-20020a926a05000000b0030dba9790e2mr4356315ilc.38.1674759241703; Thu, 26 Jan
 2023 10:54:01 -0800 (PST)
MIME-Version: 1.0
References: <20230125025126.787431-1-gregory.price@memverge.com>
 <20230125025126.787431-2-gregory.price@memverge.com> <20230126003008.GA31684@redhat.com>
 <CANaxB-xn0wW5xA_CT7bA5=jig+td__EDKPBWSpZdfgMgVOezCg@mail.gmail.com>
 <20230126150725.GB4069@redhat.com> <CANaxB-woave9F479O75P9PC+nFO3DVmbeFA1rXf2c=bhRmWoiQ@mail.gmail.com>
 <20230126183019.GD4069@redhat.com>
In-Reply-To: <20230126183019.GD4069@redhat.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 26 Jan 2023 10:53:49 -0800
Message-ID: <CANaxB-xO1fgMGRzk1Ovs2nNx0sU8wJcdpF4jGVv6nj2ErUVEAA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] ptrace,syscall_user_dispatch: Implement Syscall
 User Dispatch Suspension
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Mike Rapoport <rppt@kernel.org>
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

On Thu, Jan 26, 2023 at 10:30 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 01/26, Andrei Vagin wrote:
> >
> > On Thu, Jan 26, 2023 at 7:07 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > IIUC, PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH is needed to run the injected
> > > code, and this also needs to change the state of the traced process. If
> > > the tracer (CRIU) dies while the tracee runs this code, I guess the tracee
> > > will have other problems?
> >
> > Our injected code can reheal itself if something goes wrong. The hack
> > here is that we inject
> > the code with a signal frame and it calls rt_segreturn to resume the process.
>
> What will happen if CRIU dies and clears ->ptrace right before
> syscall_user_dispatch() checks PT_SUSPEND_SYSCALL_USER_DISPATCH ?
>
> How the tracee will react to SIGSYS with unexpected .si_syscall ?

I got it. PTRACE_O_SUSPEND_SUD doesn't help us here, because we rely
on sigreturn
that is called after ptrace_detach. Thanks.

>
> > I don't expect that
> > the syscall user dispatch
> > is used by many applications,
>
> Agreed, so the case when CRIU will need to do the additional
> PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG twice to disable and then re-enable
> syscall_user_dispatch is unlikely.
>
> > so I don't strongly insist on
> > PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH.
>
> I too won't argue too much. but so far I do not feel there is enough
> justification for this feature ...

Agree

>
> Oleg.
>
