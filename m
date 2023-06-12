Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9682772D4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjFLX3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFLX3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:29:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85D910D8;
        Mon, 12 Jun 2023 16:29:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-97454836448so698579566b.2;
        Mon, 12 Jun 2023 16:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686612541; x=1689204541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AktFDP/xlZygPZaTMcgmBqpAfONlxsN5dIhMEUaHDro=;
        b=Y60hd3fc1dI2pFe+gNemL10GwUBmbzV3fpH7ElDRGKqOwAjwoHwA4bgTA8f4niOrpS
         dfedSu8T5XhQcIYrZzvVBjBcoQJdZAdUp2fXc6n5fm1E52JUAVOub5RtqfPnuj9AN4A+
         MIdxMK008qiPEuCRKZx4O3fpe0vOxK7GnZjlAT0H/lzd5A4+ATF8UYzGIWZIXjhQ10aB
         kr6BQQQEtEljV87PitPZk3qOXA4rsscyD7/T+Y7efK+iL4zgEjPL9aYFfOFmLtkl2W+V
         neJCD10cF6/PXchK8ut+1q1fsuNKS7Ybz5WyfqHwrUTolo1Pan4Fb+9XlxvDj07doNZ6
         76qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686612541; x=1689204541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AktFDP/xlZygPZaTMcgmBqpAfONlxsN5dIhMEUaHDro=;
        b=bwVsMzmtMwQc/gZV7yKMMuUqfdYRyOTX6mvKiuViMsjZnm5OOjaYw8jYUNP+yZmXlb
         VosT6KPXnBVxfEswcWvaAgJnLadNJrGeo88mYfadul+U0X7lcIP3LK6yIad50JllTvV5
         nzqU5mtVNT3iGKbuIvvmADsjjHHhk/+rrHlPOqgqD+0t/fiN/SRmrfy9R9QyqBuLolB9
         mPvOUGTzdPvo25atgRzw9aO7FD0KauOP3AfqeHNPy5IHS6aFjlgQtLOYHK7czblmy5m5
         sQOShJHfQ6J4bx9GRc3gr2ZzrQ58/5abbT6P/SC+rJ+NIWRNJK5WqEVmnSo65t/11B/r
         7jvQ==
X-Gm-Message-State: AC+VfDzH5oqU9VxjKXAPV4V/090qvixI7BFWdC/72IuNgbt2m1PTkL8J
        Q5QtPmmh3KG0l2MVIA/lMpk+97R33OFujBXMHZo=
X-Google-Smtp-Source: ACHHUZ6C11YIllhI5lDUP65jHzV4+/p/ORlsGBulKuG4Qyle6ax2RLp/a3Q2plP/lLtBHBbQpi/3YCocxHf9xmZxpjw=
X-Received: by 2002:a17:906:58d0:b0:96f:4927:7a96 with SMTP id
 e16-20020a17090658d000b0096f49277a96mr10369730ejs.70.1686612541253; Mon, 12
 Jun 2023 16:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230611130029.1202298-1-jolsa@kernel.org> <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
 <20230611225407.3e9b8ad2@gandalf.local.home> <20230611225754.01350a50@gandalf.local.home>
 <d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com> <20230612110222.50c254f3@gandalf.local.home>
 <ZId/UL/iujOdgel+@krava>
In-Reply-To: <ZId/UL/iujOdgel+@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Jun 2023 16:28:49 -0700
Message-ID: <CAEf4Bza+n3sTUuuseZA19PQG2GN6bLezu_gdUqU6mnHfPA77xg@mail.gmail.com>
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in available_filter_functions_addrs
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Yonghong Song <yhs@meta.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jackie Liu <liu.yun@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 1:25=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Jun 12, 2023 at 11:02:22AM -0400, Steven Rostedt wrote:
> > On Mon, 12 Jun 2023 07:49:53 -0700
> > Yonghong Song <yhs@meta.com> wrote:
> >
> > > I am actually interested in how available_filter_functions_addrs
> > > will be used. For example, bpf_program__attach_kprobe_multi_opts()
> > > can already take addresses from kallsyms. How to use
> > > available_filter_functions_addrs to facilitate kprobe_multi?
>
> the problem is that we need to do 2 passes:
>
>  - through available_filter_functions and find out if the function is tra=
ceable
>  - through /proc/kallsyms to get the address for traceable function
>
> having available_filter_functions symbols together with addresses allow
> us to skip the kallsyms step
>
> and we are ok with the address in available_filter_functions_addr not bei=
ng the
> function entry, because kprobe_multi uses fprobe and that handles both en=
try and
> patch-site address properly
>
> > > Do we need to change kernel APIs? It would be great at least we
> > > got a RFC patch to answer these questions.
> >
> > I agree, having that information would also be useful to me.
> >
> > Jiri? Andrii?
>
> so we have 2 interfaces how to create kprobe_multi link:
>
>   a) passing symbols to kernel
>
>      1) user gathers symbols and need to ensure that they are
>         trace-able -> pass through available_filter_functions file
>
>      2) kernel takes those symbols and translates them to addresses
>         through kallsyms api
>
>      3) addresses are passed to fprobe/ftrace through:
>
>          register_fprobe_ips
>          -> ftrace_set_filter_ips
>
>   b) passing addresses to kernel
>
>      1) user gathers symbols and needs to ensure that they are
>         trace-able -> pass through available_filter_functions file
>
>      2) user takes those symbols and translates them to addresses
>        through /proc/kallsyms
>
>      3) addresses are passed to the kernel and kernel calls:
>
>          register_fprobe_ips
>          -> ftrace_set_filter_ips
>
>
> The new available_filter_functions_addrs file helps us with option b),
> because we can make 'b 1' and 'b 2' in one step - while filtering traceab=
le
> functions, we get the address directly.
>
> I tested the new available_filter_functions_addrs changes with some hacke=
d
> selftest changes, you can check it in here [1].
>
> I assume Jackie Liu will send new version of her patchset [2] based on th=
is
> new available_filter_functions_addrs file.
>
> I think we should have these changes coming together and add some perf
> measurements from before and after to make the benefit apparent.
>

If Steven would be ok with it, can we land this change through the
bpf-next tree? Then we can have BPF selftest added in the same patch
set that parses a new file and uses bpf_program__attach_kprobe_multi()
to attach using explicit addresses.

This should make it clear to everyone how this is meant to be used and
will be a good test that everything works end-to-end.

> jirka
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit=
/?h=3Dbpf/avail_addrs&id=3Dfecaeeaf40bae034715ab2e9a46ca1dc16371e8e
> [2] https://lore.kernel.org/bpf/20230526155026.1419390-1-liu.yun@linux.de=
v/#r
