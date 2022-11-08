Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077FA620926
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiKHFxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiKHFx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:53:29 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70D5D69;
        Mon,  7 Nov 2022 21:53:25 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id 128so12696143vse.6;
        Mon, 07 Nov 2022 21:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JUUX7ZIq/U7gt7jiUmgSCgCgFz67sPw3x5Z6ID1kiVY=;
        b=OkZcW8REGmRrJ+5YTTvYN/pehvrsKGzEXVRfhMD6M7uSbdIpo02yjnokNyrT2dbEYo
         FGxXwUhMsgT6a+t0ycevgs1aYc+6uuzNFDTMUk5xabNZcUB3Io540QNryAwgGwFZbhFJ
         xnsKLXI6uUKeXbqghhb2Snc7VHp75up9nk2UFArdjBEHY5KO6Wfac6j74H4DeL51ol/Q
         HS8Av9AGsxwniXCTIDN6n+kIu2RVtD1db7LFiQzN941sCm+KU6OZTdT3RQJ8Ijkf0qn1
         YAssWrWAFyTlGQrfF1gjGX5SQi879n5AtPJrhJmhi9UyHk25RRjtJJQcD8erBN+KqagN
         A9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUUX7ZIq/U7gt7jiUmgSCgCgFz67sPw3x5Z6ID1kiVY=;
        b=M6H++1eUc8G26OeOXoBA6QCPxGOsCCAfE76LMud0KAhZXTR6k50p0O5huyf11TctUV
         SUpJOVxcHFYcm6/jWxfJ2INZIWu0sXsJso12KRykjz8HSCDeSnNIb3OK+9S5r6TsPYZI
         Ink/D03rJ7rVRkIuIk7d4qS1wVnlUkOeoZo3Pt3LWQWsS03FHQhTBgq8QvujI1GmJNSa
         967ogllkP6HxqsSdIPbjL1LuDSs45jdl33UMJJWrKozGZfmaBOyQv5XwEtNkIU0Py5TF
         u2m1DBbLb5porsUgFINclNe4FLUie9iG5hd+H+XqAcw/cj0m0ke0oSgyHXRhVIKT8pU9
         yCtg==
X-Gm-Message-State: ACrzQf08/G1tcmBysNikhHt3tObmit/MKh7D1Vj0tJATY4WzhDypGwxE
        JCYzh6WKTu31vvDMncbj0MDxkTZfmevsctrKo9A=
X-Google-Smtp-Source: AMsMyM5t70GS9K03UePSY0T0jKrxCZyrdnGYtcTca9TgW/nXEn9X+WTYf3paxBUpvOsdTR8+MqMNk11O+m9B040xjwI=
X-Received: by 2002:a67:e093:0:b0:3aa:4c52:1c06 with SMTP id
 f19-20020a67e093000000b003aa4c521c06mr26404376vsl.45.1667886804991; Mon, 07
 Nov 2022 21:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20220728020250.1699-1-iecedge@gmail.com> <20221107144931.GA20793@willie-the-truck>
 <Y2klCLj7F7fKsza+@FVFF77S0Q05N> <20221107153506.GA21157@willie-the-truck>
 <Y2ktAisfFAr0aU2V@FVFF77S0Q05N> <20221108141009.d39d1d02f07e8993c1f37349@kernel.org>
In-Reply-To: <20221108141009.d39d1d02f07e8993c1f37349@kernel.org>
From:   Jianlin Lv <iecedge@gmail.com>
Date:   Tue, 8 Nov 2022 13:53:13 +0800
Message-ID: <CAFA-uR_B2iRaNj7Da2tZOu7JHUhrm=wZASia7nOfP-xJipzfiQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/kprobes: Add support for KPROBES_ON_FTRACE
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        corbet@lwn.net, catalin.marinas@arm.com, rostedt@goodmis.org,
        mingo@redhat.com, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net, arnd@arndb.de,
        zhengzengkai@huawei.com, jianlv@ebay.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Tue, Nov 8, 2022 at 1:10 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Mon, 7 Nov 2022 16:06:26 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
>
> > On Mon, Nov 07, 2022 at 03:35:07PM +0000, Will Deacon wrote:
> > > On Mon, Nov 07, 2022 at 03:32:24PM +0000, Mark Rutland wrote:
> > > > On Mon, Nov 07, 2022 at 02:49:31PM +0000, Will Deacon wrote:
> > > > > [+Mark R]
> > > > >
> > > > > On Thu, Jul 28, 2022 at 02:02:50AM +0000, Jianlin Lv wrote:
> > > > > > This is the arm64 version of ftrace-based kprobes to avoid the overhead
> > > > > > with regular kprobes, by using the ftrace infrastructure.
> > > > > >
> > > > > > Signed-off-by: Jianlin Lv <iecedge@gmail.com>
> > > > > > ---
> > > > > >  .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
> > > > > >  arch/arm64/Kconfig                            |  1 +
> > > > > >  arch/arm64/kernel/probes/Makefile             |  1 +
> > > > > >  arch/arm64/kernel/probes/kprobes-ftrace.c     | 81 +++++++++++++++++++
> > > > > >  include/linux/kprobes.h                       |  2 +
> > > > > >  kernel/kprobes.c                              |  4 +-
> > > > > >  6 files changed, 88 insertions(+), 3 deletions(-)
> > > > > >  create mode 100644 arch/arm64/kernel/probes/kprobes-ftrace.c
> > > > >
> > > > > Sorry for the slow reply on this, but I think this deserved to be split
> > > > > into two patches: the first one reworking the core check_ftrace_location()
> > > > > logic to work properly with branch-and-link style architectures, and the
> > > > > second one adding support for arm64.
> > > >
> > > > I'd prefer we don't do this at all; there a bunch of issues with kprobes *not*
> > > > taking an exception, since we get a dodgy not-quite-real pt_regs, and to clean
> > > > up the existing issues the plan is:
> > > >
> > > > 1) Move ftrace over to ftrace_regs
> > > > 2) Implement fprobes using ftrace_regs
> > > > 3) Remove kretprobes
>
> Yes, that is what we agreed at the tracing summit.

Sorry to miss TS2022.
Are there documents that can be shared to document the conclusions
reached at the tracing summit?
This will be helpful to understand what changes may be coming to tracing.

>
> When we finished to move on the fprobe and fprobe-events, kretprobes
> (and kprobe-on-ftrace if CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS is not
> supported) are not needed from the user viewpoint.
> So we can mark the kretprobe API obsolete.
>
> > > >
> > > > ... and regular kprobes will need to take an exception (via BRK) to get a real
> > > > pt_regs, so that can't be optimized to use ftrace.
> > >
> > > OKey doke. Does that mean that other architectures will follow the same
> > > approach of taking an exception,
> >
> > I think once everyone has FPROBE, KPROBES_ON_FTRACE becomes redundant, and
> > could be removed (leaving kprobes to always follow a take-an-exception flow on
> > all architectures).
>
> Anyway I will give some window to transit to the fprobe with ftrace_regs.
>
> >
> > > or do they somehow work by magic?
> >
> > Some architectures don't need to take an exception to be able to create a full
> > pt_regs (e.g. x86's flags are accessible in a way arm64's PSTATE isn't), but
> > that needs to be generated / restored differently to exception entry/return,
> > and so even where it's possible it can be painful to maintain (and slower than
> > using ftrace_regs), so I suspect KPROBES_ON_FTRACE would be removed.
>
> I think KPROBES_ON_FTRACE support depends on CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS.
> When the all architecture removed it, I remove it. But it means that if function
> tracer is enabled, we can not put any kprobes on the entry of functions on x86
> because there is no space to put a software breakpoint at the function entry
> on x86.
>
> For the ftrace (tracefs) user, I will minimize the effect of this change, but
> the tools developers (including eBPF developer) this change may be critical.
>
> Thank you,
>
>
> >
> > So different constaints more than magic.
> >
> > Thanks,
> > Mark.
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
