Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CEE714EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjE2RFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjE2RFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:05:41 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EDAB7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:05:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f6a6e9d90dso304371cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685379939; x=1687971939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwoMfWi97obMRCWCH25odgr0RjnVbHr4fnSsN464Q64=;
        b=cyKzIaN5n4IEkAWYqYcz7ARQulcXV517rngzKO5u7FJbqGglnmsxa6uu0JpVvC5mv+
         HrBjREOjysA+0RaOYkpC/IvflK1p+OC4ovSrIoSOFhBwOZpoyLqwdNpwf4WQZvPT+E5K
         8QhHCvRhSLyw6950wYUzsNiqUiCvrd4zslDt3WbS5T7gbEpJlph9pteggyLDcdZf43I1
         kk+4QiwU2zyeM3PBrmCrD6bPxgaX//2rFPiSXXt+tLIhRVy3p4WmP4EGs/PqB/P78cFu
         pI/Hd4rc+JQxI4TDIsJLlpP4PKP2ZW8QzMy/DSXsYD0+dqUjVOM9CyywGwyXIrlFmZdE
         FAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685379939; x=1687971939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwoMfWi97obMRCWCH25odgr0RjnVbHr4fnSsN464Q64=;
        b=UsXgRJwO/D10CNvIcydk2DJh047rUJUYXzpFTOWHohiJwe8k2hNvjeetxfzYnOxka/
         XK2ipn2PQhND3/xK3pJeF4itF7VEeCX16Cp4III6il3+0wGsC5NGeh0B2KrUKNyuOmYn
         XdGAefxn6RBD2ifKzC8TiZ6437BnzIGPgome/ZRTAt/gY4mciYDi5PeRy8oEBiroldjQ
         d1vyVGMIrvlruK1Hsfrz8l/mTBtMTwihKCYb9dfqTuHP4edWsBcLXsZN/mPQndnW1137
         65LRVeRfx8fgqDi8w+rrmeErpu5U/BCwXqzoeNQ9oNnIDjJhV22n1xZYvy1TtUgWvWoC
         LbtA==
X-Gm-Message-State: AC+VfDxfLP68whzF/WLbzAwOOtyOwXj79frp2HcDTsmT4PedJ8jYydpH
        F3t1i5uAReyunSXkb/w4t5h+4zydATNrQUG29CioBA==
X-Google-Smtp-Source: ACHHUZ5KZq1BWV/GcKLg76iWYFUFlREK5iiRQxXX/nyiEq5TjEiRv6E8dspkBJQql+dC4FXCsM0xAVIfH0SxyW+V0rE=
X-Received: by 2002:ac8:4e8a:0:b0:3f3:9b0b:8750 with SMTP id
 10-20020ac84e8a000000b003f39b0b8750mr361294qtp.17.1685379938842; Mon, 29 May
 2023 10:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <1685326994-11987-1-git-send-email-yangtiezhu@loongson.cn> <1685326994-11987-2-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1685326994-11987-2-git-send-email-yangtiezhu@loongson.cn>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 May 2023 10:05:26 -0700
Message-ID: <CAP-5=fXkbBm52v9DC8jZm8Xr0uqKdvL7QfDmGN6j3=ZPRErLcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf arm64: Rename create_table_from_c() to create_sc_table()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
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

On Sun, May 28, 2023 at 7:23=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> After commit 9854e7ad35fe ("perf arm64: Simplify mksyscalltbl"),
> it has been removed the temporary C program and used shell to
> generate syscall table, so let us rename create_table_from_c()
> to create_sc_table() to avoid confusion.
>
> Suggested-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/pe=
rf/arch/arm64/entry/syscalls/mksyscalltbl
> index 22cdf91..e530587 100755
> --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> @@ -19,7 +19,7 @@ if ! test -r $input; then
>         exit 1
>  fi
>
> -create_table_from_c()
> +create_sc_table()
>  {
>         local sc nr last_sc
>
> @@ -35,7 +35,7 @@ create_table()
>  {
>         echo "#include \"$input\""
>         echo "static const char *syscalltbl_arm64[] =3D {"

I know this isn't changed here, but this would be better as:
echo "static const char *const syscalltbl_arm64[] =3D {"
as the array itself, not just the strings, should never be changing.

Thanks,
Ian

> -       create_table_from_c
> +       create_sc_table
>         echo "};"
>  }
>
> --
> 2.1.0
>
