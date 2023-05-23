Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEFE70DC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbjEWMcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjEWMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:32:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5763109;
        Tue, 23 May 2023 05:31:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f60dfc5f93so3266745e9.2;
        Tue, 23 May 2023 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684845103; x=1687437103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+XmU9cW6dJqezkxpvVuKdHpfUq+glTTnVbU9jQUiIY=;
        b=BDsW8NKXWqnFAViuFEK3+DwmsJ3XA06LSPv9HjHVs5GKyo1yV/SucJ936S6bNsIhJh
         jTj4G9coN/rwe0OPxC1VlrWDIKgASIOfXqvRpTg6yP4NWUYkOGD9W4oeQpNYfYgutB4e
         nj3tjodWahVPM2ZwAtnq+Nww6bHEbAwBK3vg6OysQWDqMNoDtG37mh6vGzCaH5ZdCAnr
         UIra1foqagU/c/HW8F3S8UplRlbt91wPrgvKSbB6t5XKeTVtae9Yscrd+YXyb88dzuXe
         johacs49XetzbV6WqEcwrprsN9kXEFVP51o5EN967GFxi+EHmn1AulV9lc7dyc1Fv1XP
         InUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684845103; x=1687437103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+XmU9cW6dJqezkxpvVuKdHpfUq+glTTnVbU9jQUiIY=;
        b=DKxKoVk2sjtfOsCspoQlAq2E4YJFA8+2odOzEOwm0p6+j0WvEJHz4TNrLJVQwIgDOY
         1s3muN8U14jiNlkmRJ/Po43CzBpxjM++sBSghjZwHOumhI+4OOechi8zkRw09Ia01ovz
         Bey9SCIon+GIr9AXThhWvwAFuo4KI8DpjuCjKY78U2iJrA2XKeI7XkCwYysTBqYCIo74
         2DsmbeViaQcGVBJYOHnxVgZn9xQBun6D9C0D1j/0AP5+6YcgOWT1b5UT9kz3Jy3ueTcF
         fILFsiz9aGwsMNpEMQiZEjnlP6mRBNj0phAFE+DTYChsaBLKN9eLIsFdcxEG8d+3zFVn
         jbQA==
X-Gm-Message-State: AC+VfDytxBJoU1KillKFdc6nf625rm0S4St5Ya4/QmPXSYIW2PT+9a3x
        8p6Tt/8hgKoS2aucafvYSEZqXW7gMU4VsTFE6tZJeht8Dn0tGgsh
X-Google-Smtp-Source: ACHHUZ7eyHVelDYqGRcyV5GEaa5qgxyRZz2b4R38sbUlVVncJAHgy5N45wc0X6Zmj95p6Lf77UFhSQw+36FXBfxCi9M=
X-Received: by 2002:a05:600c:259:b0:3f4:f0c2:125 with SMTP id
 25-20020a05600c025900b003f4f0c20125mr9235031wmj.23.1684845102963; Tue, 23 May
 2023 05:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <1684837327-18203-1-git-send-email-yangtiezhu@loongson.cn> <1684837327-18203-2-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1684837327-18203-2-git-send-email-yangtiezhu@loongson.cn>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Tue, 23 May 2023 15:31:06 +0300
Message-ID: <CAJ1xhMUZoO66b=LNVnjBN1GbHvXdo2b2y+YeONC36Ok=Xn5XFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf arm64: Handle __NR3264_ prefixed syscall number
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hans-Peter Nilsson <hp@axis.com>, Leo Yan <leo.yan@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
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

On Tue, May 23, 2023 at 1:22=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> After commit 9854e7ad35fe ("perf arm64: Simplify mksyscalltbl"),
> in the generated syscall table file syscalls.c, there exist some
> __NR3264_ prefixed syscall numbers such as [__NR3264_ftruncate],
> it looks like not so good, just do some small filter operations
> to handle __NR3264_ prefixed syscall number as a digital number.
>
> Without this patch:
>
>   [__NR3264_ftruncate] =3D "ftruncate",
>
> With this patch:
>
>   [46] =3D "ftruncate",
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/pe=
rf/arch/arm64/entry/syscalls/mksyscalltbl
> index 22cdf91..59ab7939 100755
> --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> @@ -39,7 +39,8 @@ create_table()
>         echo "};"
>  }
>
> -$gcc -E -dM -x c -I $incpath/include/uapi $input \
> -       |sed -ne 's/^#define __NR_//p' \
> -       |sort -t' ' -k2 -n             \
> +$gcc -E -dM -x c -I $incpath/include/uapi $input               \
> +       |awk '{if ($2~"__NR" && $3 !~"__NR3264_") {print}}'     \
> +       |sed -ne 's/^#define __NR_//p;s/^#define __NR3264_//p'  \
> +       |sort -t' ' -k2 -n                                      \
>         |create_table
> --
> 2.1.0
>

As an aside, the awk + sed + sort parts of the command line may be
reduced to the following awk script, if desired:
awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
        sub("^#define __NR_", "")
        sub("^#define __NR3264_", "")
        print | "sort -k2 -n"
}'
