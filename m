Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EB972D540
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbjFLXzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjFLXzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:55:17 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7531715
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:55:16 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f98276f89cso59181cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686614115; x=1689206115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TZTKvgWXslw1lwI6vHB1nhET0MRMTi1UfiLA9Au4ic=;
        b=exJ46dVQ/JmnaOG+CxMLsTt0wih9TMmhYpzoJoTFDrakBi+obl7ZQ817CMNuGL3XYp
         d6yqcPeUAVuStSWFoSHTROUuUQsTrf3XU07B25yd1nVgWfWY426G/3uu5D8OGkIVZvph
         6QqUDjluWaOLPsrLJvzub2+ldQJY07qqh7K4h8DC3CLF5Vj+/zAmXHJ5xfg1rFj4bUiK
         TD8WFEfy80/YOsiZRCr57F4nyapcWegWgZPqemc5Lj3228pEiuj6JNWW3lVGeEdi5AzB
         rNrqU4rm9MCscSGnl2xLz6pS+n0OcP9cut84CVhk7Z5D0Xt4eN5Qlug4XNgWtj9zDcUT
         uPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686614115; x=1689206115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TZTKvgWXslw1lwI6vHB1nhET0MRMTi1UfiLA9Au4ic=;
        b=S6fWFNkU7HU/QHWB55agI77Cg0QITwZ5dMsOFoQ+S4XNgJSs8rn7/5g0qZxybjVqQq
         v2+fugID9hZseT4br7IvOq8AF9kJSqcCQFfZlnpZt+L+E2KkiXTNEg1pMPQ3rPBqG37Q
         ZJbdUbJd95pBdz7bVzA8TjgOzY3pSboczAzTxkES0ufOmx0Jtc93Nf43FsLfigSL2wof
         3OSgWHJYney3T7gKlAQVRg59zbJnAVPJRt12D9DD6w2he29y40eCpamb7ryEnPxUU9Py
         d7VtHWpMVd94lGolpGnXJbFZSt9kaxVSgVK1sup/0q5C5VWjNvTHoR/xizeYuthVaKWM
         mOxQ==
X-Gm-Message-State: AC+VfDxgnwXowHPHIZPTqgiyhgwf5KyN+PY0Bp1TDTdyHbBFze9JtegH
        7/8H9LwPGxWgVA8KXqLmBg9ypbothpcbfC23+CkHZg==
X-Google-Smtp-Source: ACHHUZ4gtNf3oUkKVDoBwfN3WBAinn8qkE/cIS+GMBRsPsZvQS7qfBsTQsGKygeoHk4toeHSJCT62PXL6DZzf+OzBh4=
X-Received: by 2002:a05:622a:247:b0:3ef:4319:c6c5 with SMTP id
 c7-20020a05622a024700b003ef4319c6c5mr36692qtx.19.1686614115514; Mon, 12 Jun
 2023 16:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230612230026.3887586-1-namhyung@kernel.org>
In-Reply-To: <20230612230026.3887586-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 12 Jun 2023 16:55:03 -0700
Message-ID: <CAP-5=fUpXtoaiLkJW_f5Z1q+iW6ibvRKZb3xWR945g+30x-NNw@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Allow whitespace between insn operands
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 4:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The llvm-objdump adds a space between the operands while GNU objdump
> does not.  Allow a space to handle the both.
>
> In GNU objdump:
>
>   Disassembly of section .text:                                      here
>                                                                       |
>   ffffffff81000000 <_stext>:                                          v
>   ffffffff81000000:     48 8d 25 51 1f 40 01    lea    0x1401f51(%rip),%r=
sp
>   ffffffff81000007:     e8 d4 00 00 00          call   ffffffff810000e0 <=
verify_cpu>
>   ffffffff8100000c:     48 8d 3d ed ff ff ff    lea    -0x13(%rip),%rdi
>
> In llvm-objdump:
>
>   Disassembly of section .text:                                      here
>                                                                        |
>   ffffffff81000000 <startup_64>:                                       v
>   ffffffff81000000: 48 8d 25 51 1f 40 01        leaq    20979537(%rip), %=
rsp
>   ffffffff81000007: e8 d4 00 00 00              callq   0xffffffff810000e=
0 <verify_cpu>
>   ffffffff8100000c: 48 8d 3d ed ff ff ff        leaq    -19(%rip), %rdi
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 9171102dd3ad..3eab6c29eaa5 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -585,7 +585,7 @@ static int mov__parse(struct arch *arch, struct ins_o=
perands *ops, struct map_sy
>         if (ops->source.raw =3D=3D NULL)
>                 return -1;
>
> -       target =3D ++s;
> +       target =3D skip_spaces(++s);
>         comment =3D strchr(s, arch->objdump.comment_char);
>
>         if (comment !=3D NULL)
> --
> 2.41.0.162.gfafddb0af9-goog
>
