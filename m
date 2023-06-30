Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FDE743F66
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjF3QEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjF3QEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:04:12 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579843C06
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:04:11 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-401f4408955so266021cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688141050; x=1690733050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72aZQhoXa0Ea0UAlKIsGIZ+Gu11zrKiWVCMDasipILY=;
        b=Pf6lIriWxgTkJGWPPDZ2wR05EJ+WqqHCHIHLDQFM+hMo7jmbD13uhPF73BaApquSY0
         /u7JE4VJk/tZhlgi/x4c/lrVlF7y5jE1vq8fA1VMMHZu1pHnRVHJUyT36qEzIEEedwiH
         gyqF8bk9JxLcAU/RT/2lFotT/Vl5yKxll+Ifys4srfAeks6xWiZH0KzPzSrKPJ+cRpxb
         FOO4zwaB3LM27IB/pRm185jzh43+TodqYeWoUtvBZCQ2ZtoNEipY8kx6YC9UJVkp2RQs
         79i9io3k+pyZ9gFm6MGC/dHXaA3o63CFHb64W9ZdOLbbevxz57Wtj1Bl15vZAXw+B+ld
         vCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688141050; x=1690733050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72aZQhoXa0Ea0UAlKIsGIZ+Gu11zrKiWVCMDasipILY=;
        b=gk9fx6SMM3ZHfiZT0J13Yy8J9c17nKhyMu5TIo+2ex8oDjYpuTrRT0UU9EaxIyyWWr
         GNACMx8R4k775s3Kq1PqqhtfV0NAN/5CDRd5I7nsJGrRbCHvigXHShULc79abiSUj0z/
         qY5iKuY0i/NoDBI5gZtrUgWRkqJOUvD8TETr69rilyPpdJoijUmGIdgfa8rETxxEcPGz
         sdwwtmOwRoicI8vJE/92f/yto5a9+Hk0tLSBR5syFq6o0/FRSrpz6znKgzN14gxLHnIZ
         XV7wDB8y5qbx/ezs9frIENlK+L+pLeu+KqXzh9YEVFQ8+6V875B46xX+7nfmy8lUZl1k
         LQBw==
X-Gm-Message-State: AC+VfDyQCu7fQXlR0QkVGn4vlFf1CYWifrulMwro58g0uXmJJ2g5iiTm
        aNvhdwnU5rvcvgX/WvzhKgXytDH/MPb2HG1zTavGZQ==
X-Google-Smtp-Source: ACHHUZ77csaA2FJyIaaxmbTlQnC2Qg88NjTlVxNKtDv38LdjGU/QpfVG03pPSI/QsBH1SobPqZksNWcOqRhBEwEpA54=
X-Received: by 2002:a05:622a:9:b0:3f8:1db6:201c with SMTP id
 x9-20020a05622a000900b003f81db6201cmr697347qtw.13.1688141050301; Fri, 30 Jun
 2023 09:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230628200141.2739587-1-namhyung@kernel.org> <20230628200141.2739587-2-namhyung@kernel.org>
In-Reply-To: <20230628200141.2739587-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 09:03:59 -0700
Message-ID: <CAP-5=fWvmR0dXftqRpZC3cZXV84rHuW0iz2yzOZmCn5iR11Wyw@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf lock: Remove stale comments
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>
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

On Wed, Jun 28, 2023 at 1:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The comment was for symbol_conf.sort_by_name which was deleted already.
> Let's get rid of the stale comments as well.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-lock.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index da36ace66d68..187efb651436 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1773,7 +1773,6 @@ static int __cmd_report(bool display_info)
>                 return PTR_ERR(session);
>         }
>
> -       /* for lock function check */
>         symbol_conf.allow_aliases =3D true;
>         symbol__init(&session->header.env);
>
> @@ -1902,7 +1901,6 @@ static int __cmd_contention(int argc, const char **=
argv)
>         if (con.aggr_mode =3D=3D LOCK_AGGR_CALLER)
>                 con.save_callstack =3D true;
>
> -       /* for lock function check */
>         symbol_conf.allow_aliases =3D true;
>         symbol__init(&session->header.env);
>
> --
> 2.41.0.255.g8b1d071c50-goog
>
