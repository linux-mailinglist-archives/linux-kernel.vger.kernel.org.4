Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B694970EE59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbjEXGpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjEXGpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:45:16 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABECE49;
        Tue, 23 May 2023 23:43:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6094cb26eso6925805e9.2;
        Tue, 23 May 2023 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684910633; x=1687502633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zk6upt+vsp22fV0++FGxdKmhDI8OOl/jL66VSuvL1JM=;
        b=AxTSMOstnaCEH6JLjXZ30ppxzYQ3gx4X0lJps4UcVJnw5vRPswnqJwfk8CYMqfRPr4
         opcE4dpKqAfWzoiv3xfPmIhzQTjpch5wscao9Y0sycTStG6q100U8ksj+Bin6F/4tvdr
         xqrdSrRwL5VtstDm64URGQmtDKj8PXNf/1Wp87mGYcH3hTfI/0gOnLwnHa0DpihSWB1e
         Lt3J9POr3MLWbh1QTVsnWpR2zh0zah1gCKpLYDF9UIHQgQ4RPDzdHAo8W4Icc9yhBkj9
         tzD39+/S9vIhYNyn2/sg8Tb8PrB+7Igl2KZALyOaoPHfpwzdQ/nSn49HEDiWfHqVvvzs
         0jVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910633; x=1687502633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zk6upt+vsp22fV0++FGxdKmhDI8OOl/jL66VSuvL1JM=;
        b=krd8Wry/CSQ5e640ToO+VffIEKee/DcXWaFt29QzssGboTSgcwJEHYS6Psjpxo9/Ly
         dYVy9QPUJuM2sR5GJhAFfxEz0uKMSN/AzY8m6jgoucebnss4qJhWi9pb1ORO25DSb3iR
         84oeApApP/djg2Xp7a1fTFme+fPYResh/Zj2FYnM2Oqpx+52NQ9MYw8RDI+9CvXrVlRQ
         1W8gwc2MwuU2TESlO1eRjmASnkFYuXoApITojyJUs84QrUyJknKJL/RufeBTB0aV/KtA
         yFOa79AfI3PBnkDyqCpXRyNoT+BD2XjpsLX2z5tRwkXdg51ZUHwzXIepLTlcHgnwebGh
         TCng==
X-Gm-Message-State: AC+VfDwyuGnEjoFv5V8PnaZMdK6txZTUUlSHXrUC6+2cOISvH45rgUtn
        C2GOdj29cxeR2TXrWSdsZWOxQqGW+7NDi7zP1/Ib9t3eFaLGo003
X-Google-Smtp-Source: ACHHUZ4QMq9vrYxYRJbuOvFf+VzJiwYOaYoO+O+HFuEtol5pJ+0yyOn0JHLMYZu524VVWgLx4kJjNJwyzL+wyIB+xCU=
X-Received: by 2002:a05:600c:3795:b0:3f4:2737:a016 with SMTP id
 o21-20020a05600c379500b003f42737a016mr12308388wmr.29.1684910632858; Tue, 23
 May 2023 23:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <1684837327-18203-1-git-send-email-yangtiezhu@loongson.cn>
 <1684837327-18203-2-git-send-email-yangtiezhu@loongson.cn>
 <CAJ1xhMUZoO66b=LNVnjBN1GbHvXdo2b2y+YeONC36Ok=Xn5XFg@mail.gmail.com> <49e98308-ab8d-5811-66a8-9e17f22bb8c4@loongson.cn>
In-Reply-To: <49e98308-ab8d-5811-66a8-9e17f22bb8c4@loongson.cn>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Wed, 24 May 2023 09:43:17 +0300
Message-ID: <CAJ1xhMV=WaYbdGpiRedLUGnYp8JLzcP81Ksw1k1610xeHCiGBA@mail.gmail.com>
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

On Wed, May 24, 2023 at 6:19=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
>
>
> On 05/23/2023 08:31 PM, Alexander Kapshuk wrote:
> > On Tue, May 23, 2023 at 1:22=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> >>
> >> After commit 9854e7ad35fe ("perf arm64: Simplify mksyscalltbl"),
> >> in the generated syscall table file syscalls.c, there exist some
> >> __NR3264_ prefixed syscall numbers such as [__NR3264_ftruncate],
> >> it looks like not so good, just do some small filter operations
> >> to handle __NR3264_ prefixed syscall number as a digital number.
> >>
> >> Without this patch:
> >>
> >>   [__NR3264_ftruncate] =3D "ftruncate",
> >>
> >> With this patch:
> >>
> >>   [46] =3D "ftruncate",
> >>
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >> ---
> >>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools=
/perf/arch/arm64/entry/syscalls/mksyscalltbl
> >> index 22cdf91..59ab7939 100755
> >> --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> >> +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> >> @@ -39,7 +39,8 @@ create_table()
> >>         echo "};"
> >>  }
> >>
> >> -$gcc -E -dM -x c -I $incpath/include/uapi $input \
> >> -       |sed -ne 's/^#define __NR_//p' \
> >> -       |sort -t' ' -k2 -n             \
> >> +$gcc -E -dM -x c -I $incpath/include/uapi $input               \
> >> +       |awk '{if ($2~"__NR" && $3 !~"__NR3264_") {print}}'     \
> >> +       |sed -ne 's/^#define __NR_//p;s/^#define __NR3264_//p'  \
> >> +       |sort -t' ' -k2 -n                                      \
> >>         |create_table
> >> --
> >> 2.1.0
> >>
> >
> > As an aside, the awk + sed + sort parts of the command line may be
> > reduced to the following awk script, if desired:
> > awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
> >         sub("^#define __NR_", "")
> >         sub("^#define __NR3264_", "")
> >         print | "sort -k2 -n"
> > }'
> >
>
> Hi Alexander,
>
> Thanks, it seems more simple and works well as expected.
> Let us wait for more review comments before respin.
>
> If no any objections, I will send v2 with the following
> changes based on the current patch in the next week.
>
> -$gcc -E -dM -x c -I $incpath/include/uapi $input               \
> -       |awk '{if ($2~"__NR" && $3 !~"__NR3264_") {print}}'     \
> -       |sed -ne 's/^#define __NR_//p;s/^#define __NR3264_//p'  \
> -       |sort -t' ' -k2 -n                                      \
> +$gcc -E -dM -x c -I $incpath/include/uapi $input \
> +       |awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
> +               sub("^#define __NR_", "")
> +               sub("^#define __NR3264_", "")
> +               print | "sort -k2 -n"}' \
>          |create_table
>
> Thanks,
> Tiezhu
>

Hi Tiezhu,

Thanks for your prompt feedback.
It was merely a suggestion entirely subject to your discretion.

If no other patterns are anticipated to be processed by the sub
routines, they may be combined into a single sub routine like so:
awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
        sub("^#define __NR(3264)?_", "")
        print | "sort -k2 -n"
}'
