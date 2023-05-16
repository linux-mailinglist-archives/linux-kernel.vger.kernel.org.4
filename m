Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DAC7043CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 05:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjEPDDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 23:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEPDCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 23:02:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F63B6581;
        Mon, 15 May 2023 20:02:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso24679600a12.2;
        Mon, 15 May 2023 20:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684206159; x=1686798159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRflamDYeWG+dwnKCN6fDmXchdmQ0hXXUg/f9uPeMuY=;
        b=Qm/1ER7wHWb0P4lNl5uRyhGhPoafIXVefvVQ587Pbjiog1kXtVz6ACLNM06p+XOYSU
         smFyGvGg+cr6vN7ET8xBmyz31UGOcw5o/y6eRzo4Ll8mvQsT8t/jGmwLODRpHIV1IJau
         F1DNEkUsphDSLw4P0Eg/qW5rS3WO5n1V5QRybYRUK3RHhjj8E4DyrQNDAG1pjEiSoJmj
         kx1oypv1r2QHylMPFhgOT3N/kT0pyWVvhrZGwLFVE6b5PCXmgvxswpFQSp2Y6jpkiMjW
         EBEigNKekJJIOQVExsYyVn17jIlhMZuA6JVsTYRLPcUvc6WBw3kZbq8ZEEJnrRxRyWh4
         ZiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684206159; x=1686798159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRflamDYeWG+dwnKCN6fDmXchdmQ0hXXUg/f9uPeMuY=;
        b=MjB+TvKCBimTjpFGQo3DW9uqpa6lQnCCLpGi6YJwHxTyreNg/bV55JMBsPB/kJAI3s
         GP2MDZfS/GTLGlh5+uJPnMwIF5dcQjjg8loXyp0AqguXe4iimEzr+KR3u9AAxdko9a65
         XgiylvEKbxbHERRm8r7WDPKCAozmfI9t0NqkVsbKy3N7jNOxhUjPrxLuucOI+s3+8j4Q
         v+DjublUzJZsr4u48DaH3s96omzgZHf169f91R5ooBicX9hy7XBEsxJWnye20QFQpNGD
         c8dUTsCu02OTZ3wBxHyrBC8PWdxX1Hnq7lCQN04tcRV4lOSZRWyWhM/AHkWjc6X/uITP
         htwA==
X-Gm-Message-State: AC+VfDzJMD5PKhS2KKBQMypkOX9Qgwq9GeQBmZb2Y2noCCCGI7+J/3ru
        bQ4q55z5A5jjPO1T6PIJg1rQhQhiLbkLUm70q0k=
X-Google-Smtp-Source: ACHHUZ75Cz/kTErHMOdHx5ncgauHg0G5XNNw7JhIFLb64p+kn+SMbq9o34lKt9yzv+vv4f12h7zUegC5o5W9IyMxtH0=
X-Received: by 2002:a17:906:da86:b0:960:ddba:e5c3 with SMTP id
 xh6-20020a170906da8600b00960ddbae5c3mr28508381ejb.32.1684206159081; Mon, 15
 May 2023 20:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684120990.git.zegao@tencent.com> <6c428b9f74090b2780b67ca498c45aa5e8c38c44.1684120990.git.zegao@tencent.com>
 <20230515212546.7a467a1f@gandalf.local.home>
In-Reply-To: <20230515212546.7a467a1f@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Tue, 16 May 2023 11:02:27 +0800
Message-ID: <CAD8CoPC-q23cytkzdPwBVAXKBS-B-Dpya3dWroftvQD6iN414g@mail.gmail.com>
Subject: Re: [PATCH 2/4] fprobe: make fprobe_kprobe_handler recursion free
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, Ze Gao <zegao@tencent.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Tue, May 16, 2023 at 9:25=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 15 May 2023 11:26:39 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Current implementation calls kprobe related functions before doing
> > ftrace recursion check in fprobe_kprobe_handler, which opens door
> > to kernel crash due to stack recursion if preempt_count_{add, sub}
> > is traceable.
> >
> > Refactor the common part out of fprobe_kprobe_handler and fprobe_
> > handler and call ftrace recursion detection at the very beginning,
> > and also mark these functions notrace so that the whole fprobe_k-
> > probe_handler is free from recusion. And
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  kernel/trace/fprobe.c | 61 +++++++++++++++++++++++++++++++------------
> >  1 file changed, 45 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 9abb3905bc8e..ad9a36c87ad9 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -20,30 +20,22 @@ struct fprobe_rethook_node {
> >       char data[];
> >  };
> >
> > -static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > -                        struct ftrace_ops *ops, struct ftrace_regs *fr=
egs)
> > +static inline notrace void __fprobe_handler(unsigned long ip, unsigned=
 long
>
>
> FYI, if you look in kernel/trace/Makefile you'll see:
>
> ccflags-remove-$(CONFIG_FUNCTION_TRACER) +=3D $(CC_FLAGS_FTRACE)
>
> Which removes the flags to add tracing. So there's no reason to add
> "notrace" here, as all functions in this directory are by default "notrac=
e".

Thanks for your valuable info, which I missed before. I'll send v2 to
remove those
unnecessary notrace annotations, and use the same trick for rethook too.

BTW,  I think we can mark rethook routines decls notrace in
include/linux/rethook.h,
which helps to remind developers of other arch(s) this important info.
What do you think of it?

Regards,
Ze
