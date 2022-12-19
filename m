Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103B86507F5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 08:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiLSHIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 02:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLSHIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 02:08:32 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2B165F4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 23:08:29 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a16so11543941edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 23:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zbS20iW0dz/3uX5m3YMUqJaOhrJV7mMrpWN8/tQbOPU=;
        b=E6FPC5pNIspqoJzrbC1VGM4lW/lteSiHtyWdeqC1F2Af6xVDPQigplP4jsgrzOIBfo
         C86as3IqfHurkNomhuln7hzOHyZ6xNwWYZJ1h08B1wGmI7KpFDn97BPlYLhyrddiCHkv
         igaT7EYBdVr1eR5tdt239zDOvCmz/zOBN98IR5Egv/IobhDY224Ry24PJLT+Wweeu9ei
         hSmDZubnPLqfTFw3zCku+5cFj/syCTKwATWKWPTD07OrTzO22iElIXNuzxizp4GjrNrl
         RByOsmEARe+ujVicUBRcCwqwGHOV9o8OYk9dDljyQc7Y4r3avtfIlbVYRM0aEO/YwthE
         nctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbS20iW0dz/3uX5m3YMUqJaOhrJV7mMrpWN8/tQbOPU=;
        b=onhgKHfMa+LbXG8IWvG5vzx+8mmvYCbZ7BrvCXMP2PZiuEj9Ji+rZSBI4ieoQ97jHe
         gFGA40zRdFnS7HnSbxB8DMkDd9LQR1s9oLKVIcl7eXQ6xzk+ie6aRYhAY4nDd1QH/vCw
         OAODV4GxA8OduFKfKTcic2mrZ7/qrFigNvscE9s45w3tTu015u9cVqaUo9yoat3I+fgu
         XXhZwm28LeMYT4z3Zv0OMwi1tmHOC2pYuYsm9aP+vGdHDtpkN9MCg+N9gX4Qm8PzlFKy
         jsI/MhMzIiOcuBop3QouKebycaZrbtwVtxZaTMekevxUbAkjfiw/gGIevkySRBRY/Ueq
         6M3A==
X-Gm-Message-State: ANoB5pnVV/GdXtVC1jdD3SwOWATOBdJwfmFH1aqORAtfStN9zhoxnrHW
        6deddkXzyk3N2jt2CJ0zC9eCBf7V6vOadJb1iuM=
X-Google-Smtp-Source: AA0mqf5X4AHgiRNV3Q/dU7U+lJbHaXiamypNGTCPmXKiI5dskht4PvDGZyJj6SBHqKgpzqAraqqqVhom6+macBrhzoU=
X-Received: by 2002:a50:eb94:0:b0:46d:731c:2baf with SMTP id
 y20-20020a50eb94000000b0046d731c2bafmr8126174edr.280.1671433707478; Sun, 18
 Dec 2022 23:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20221215091346.33710-1-dolinux.peng@gmail.com> <20221218103907.61bdd5a2ef5c2d175f585931@kernel.org>
In-Reply-To: <20221218103907.61bdd5a2ef5c2d175f585931@kernel.org>
From:   Donglin Peng <dolinux.peng@gmail.com>
Date:   Mon, 19 Dec 2022 15:08:13 +0800
Message-ID: <CAErzpmvpbgOq7vxH307h1hH7=imGpvtwV78dHxFAyWHMjTvW=A@mail.gmail.com>
Subject: Re: [PATCH v4] tracing/probe: add a char type to show the character
 value of traced arguments
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, xiehuan09@gmail.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
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

On Sun, Dec 18, 2022 at 9:39 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Donglin,
>
> Thanks for updating you patch. And can you also send a test code update
> (tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc)?
>
Yes, no problem.
I will refer to kprobe_args_string.tc to add a new file named
kprobe_args_char.tc.
> Thank you,
>
> On Thu, 15 Dec 2022 01:13:46 -0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > There are scenes that we want to show the character value of traced
> > arguments other than a decimal or hexadecimal or string value for debug
> > convinience. Add a new type named 'char' to do it.
> >
> > For example:
> >
> > The to be traced function is 'void demo_func(char type, char *name);', we
> > can add a kprobe event as follows to show argument values as we want:
> >
> > echo 'p:myprobe demo_func $arg1:char +0($arg2):char[2]' > kprobe_events
> >
> > we will get the following trace log:
> >
> > ... 95.451350: myprobe: (demo_func+0x0/0x29) arg1=A arg2={b,p}
> >
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> > Changes in v4:
> >  - update the example in the commit log
> >
> > Changes in v3:
> >  - update readme_msg
> >
> > Changes in v2:
> >  - fix build warnings reported by kernel test robot
> >  - modify commit log
> > ---
> >  Documentation/trace/kprobetrace.rst | 3 ++-
> >  kernel/trace/trace.c                | 2 +-
> >  kernel/trace/trace_probe.c          | 2 ++
> >  kernel/trace/trace_probe.h          | 1 +
> >  4 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> > index 4274cc6a2f94..007972a3c5c4 100644
> > --- a/Documentation/trace/kprobetrace.rst
> > +++ b/Documentation/trace/kprobetrace.rst
> > @@ -58,7 +58,7 @@ Synopsis of kprobe_events
> >    NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
> >    FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> >                 (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> > -               (x8/x16/x32/x64), "string", "ustring" and bitfield
> > +               (x8/x16/x32/x64), "char", "string", "ustring" and bitfield
> >                 are supported.
> >
> >    (\*1) only for the probe on function entry (offs == 0).
> > @@ -80,6 +80,7 @@ E.g. 'x16[4]' means an array of x16 (2bytes hex) with 4 elements.
> >  Note that the array can be applied to memory type fetchargs, you can not
> >  apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
> >  wrong, but '+8($stack):x8[8]' is OK.)
> > +Char type can be used to show the character value of traced arguments.
> >  String type is a special type, which fetches a "null-terminated" string from
> >  kernel space. This means it will fail and store NULL if the string container
> >  has been paged out. "ustring" type is an alternative of string for user-space.
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 5cfc95a52bc3..a64e206f94e6 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -5615,7 +5615,7 @@ static const char readme_msg[] =
> >       "\t           $stack<index>, $stack, $retval, $comm,\n"
> >  #endif
> >       "\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
> > -     "\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
> > +     "\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
> >       "\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
> >       "\t           <type>\\[<array-size>\\]\n"
> >  #ifdef CONFIG_HIST_TRIGGERS
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 36dff277de46..a4abf7f6c295 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -50,6 +50,7 @@ DEFINE_BASIC_PRINT_TYPE_FUNC(x8,  u8,  "0x%x")
> >  DEFINE_BASIC_PRINT_TYPE_FUNC(x16, u16, "0x%x")
> >  DEFINE_BASIC_PRINT_TYPE_FUNC(x32, u32, "0x%x")
> >  DEFINE_BASIC_PRINT_TYPE_FUNC(x64, u64, "0x%Lx")
> > +DEFINE_BASIC_PRINT_TYPE_FUNC(char, u8, "%c")
> >
> >  int PRINT_TYPE_FUNC_NAME(symbol)(struct trace_seq *s, void *data, void *ent)
> >  {
> > @@ -93,6 +94,7 @@ static const struct fetch_type probe_fetch_types[] = {
> >       ASSIGN_FETCH_TYPE_ALIAS(x16, u16, u16, 0),
> >       ASSIGN_FETCH_TYPE_ALIAS(x32, u32, u32, 0),
> >       ASSIGN_FETCH_TYPE_ALIAS(x64, u64, u64, 0),
> > +     ASSIGN_FETCH_TYPE_ALIAS(char, u8, u8,  0),
> >       ASSIGN_FETCH_TYPE_ALIAS(symbol, ADDR_FETCH_TYPE, ADDR_FETCH_TYPE, 0),
> >
> >       ASSIGN_FETCH_TYPE_END
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index de38f1c03776..8c86aaa8b0c9 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -164,6 +164,7 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(x16);
> >  DECLARE_BASIC_PRINT_TYPE_FUNC(x32);
> >  DECLARE_BASIC_PRINT_TYPE_FUNC(x64);
> >
> > +DECLARE_BASIC_PRINT_TYPE_FUNC(char);
> >  DECLARE_BASIC_PRINT_TYPE_FUNC(string);
> >  DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
> >
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
