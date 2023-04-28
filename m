Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3398C6F0F96
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344630AbjD1AbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344595AbjD1AbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:31:10 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFBF3A82
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:31:08 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3ef36d814a5so863031cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682641867; x=1685233867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dy6q1Uw/rxLS8q/AocKwbxiAauTqjXmfHidYdOpgsqM=;
        b=JXKU4b+U90dgO/Ta/QdlyHd/lzn3aMWg5xXfrolixS57yjrjZMN7DkftL2lWJ11pSh
         2qGk0aH1I99gxty1TLcyPbogXp86SemMWDwvFXmJkrSLov3OrClYOUSnAzmAqLV4LyeE
         ZrZXKP1bXJZYHg6akMr58OxR09ODB8em9pFFd1QUQn1uxASsWnekxW1ncz1q6w4bLvuD
         B/dcwNTLyQvJzEghALAi1Axiw2b8OdVkZf3/4EX9uI5Ek5P3ztLpLg0dq24Nfk6RD+9q
         clxjqY2CN+vUURKMdz7wBwHTAImHtDcUNlC+9qSYxdZ+zTAkF998NxNl3NU9Aq0oePbZ
         Uj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682641867; x=1685233867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dy6q1Uw/rxLS8q/AocKwbxiAauTqjXmfHidYdOpgsqM=;
        b=ksqrQsA/l2tDwTUAwJNmwLg0f+xOQQ9YS/FeFDOX3qUOrJY3fyEx8uXQBsLfXEmuul
         OLV+f2H2QFFB8OTd6TBo8Gs6YujvL7LT/ubpqo1mxnmjEdQN4k68ycCpUDmRrYddhk7h
         jM8kbrA91XGZmT8SgTbFxIajaeYcVY+jJgTE4e84AVVXbFLXGFUH/XLFwGusxCtimJhO
         ofwXZk25FaWP2kMh23r57o9AF6PIkHt68xNdxTbeXybiMhyBUMJR7t2xmQuTCC0tBxzs
         b3uyhxZnhJ5uOkG/KwsLzYBIT3NmdkFqde20grQ4un21qlSmttQV0++sYJAfK98eIzab
         9k9g==
X-Gm-Message-State: AC+VfDw4Ww3YiuOb2QGU2CRdWYBvGvhD/N2oCQYeUT1eL5iE29EUBSuy
        BXxwwd2Kbvpzud9sccrxiuZEBDliZGykd2fSXv9bK/g1NAXcaLCg3oph8Q==
X-Google-Smtp-Source: ACHHUZ6YUZq16ghUneoCyRK/P2KfDaW6PBgRcn1DMBDDClNjX9CSr3oydqzMpvQFL+dJJxuxbgd/YqNGO2XGW5nEWK8=
X-Received: by 2002:a05:622a:1447:b0:3ef:404a:b291 with SMTP id
 v7-20020a05622a144700b003ef404ab291mr65560qtx.7.1682641867235; Thu, 27 Apr
 2023 17:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230427230502.1526136-1-namhyung@kernel.org> <20230427230502.1526136-2-namhyung@kernel.org>
In-Reply-To: <20230427230502.1526136-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 17:30:56 -0700
Message-ID: <CAP-5=fWFu00PJVcfBPa_pq6cVN3UCsPr+yq303gdnKp8K_MecQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf list: Modify the warning message about scandirat(3)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
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

On Thu, Apr 27, 2023 at 4:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It should mention scandirat() instead of scandir().
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Fwiw, tracing_events__scandir_alphasort assumes scandir is present
unconditionally.

Thanks,
Ian

> ---
>  tools/perf/util/print-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-event=
s.c
> index 0a97912fd894..299973876550 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -131,7 +131,7 @@ void print_tracepoint_events(const struct print_callb=
acks *print_cb __maybe_unus
>         free(sys_namelist);
>  }
>  #else
> -       printf("\nWARNING: Your libc doesn't have the scandir function, p=
lease ask its maintainers to implement it.\n"
> +       printf("\nWARNING: Your libc doesn't have the scandirat function,=
 please ask its maintainers to implement it.\n"
>                "         As a rough fallback, please do 'ls %s' to see th=
e available tracepoint events.\n", events_path);
>  #endif
>         close(events_fd);
> --
> 2.40.1.495.gc816e09b53d-goog
>
