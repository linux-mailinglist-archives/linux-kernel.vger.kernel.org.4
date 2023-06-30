Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5FB743E91
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjF3PTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjF3PTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:19:03 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744DB3C1B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:19:02 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-401f4408955so251161cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688138341; x=1690730341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7y85+CsbEknGYolZq9ltwi/sLY28N+60rkHxxiN/96I=;
        b=aqlpp13fau6b/AMECgbtGX07mxMGSbx3NyWZWBzftVHNCu3uE+q78Vtq39Xt4+8IZx
         MY60D4oQIZPyEVwjOQPEVaJafMR80yvvUf6UiETAdxuBuqpUkqPHBkVDP3csWAj/nbri
         nwNxjXQl+VNWTqnkjebhwCJFPEQyWD0VTt6b1myZeq8g2FD1p4JjY+5Bt4tfS8XSRo6E
         ycBIFdW6u3BH5D3z/DXNEbhJ8zCDFr+0+SfmyS4xuIdmFLN6WB4v/GgrHsKkR2+S9KAi
         8LbeX1AT3eNYq1uyb1ix+EunI7NpPUUNaU5r5hr+QIKw52FHwnkuw0ELBgiqqAFvpIxg
         rWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138341; x=1690730341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7y85+CsbEknGYolZq9ltwi/sLY28N+60rkHxxiN/96I=;
        b=CCDt10yqkJFyooISBHbsGVAaAUwqs9ozfC86bt7qKcgG/z3g+6v7H3+g9QXzNGYjTo
         FZYp1aH5e1Atq2GBFe5OJ7UZ0ooKPsr44PqJyGAkF3ItyYM9KCoSVeYOJ5mZdXtRBZ4e
         82UBQgRmMqULpIpF/Wujae3MSAOxs2xut1Ggbzqtxhp+m0N9reJo4qgcDLetsXTJ3CeO
         8XQhub3K9m7f+IZZ7GaBESPdlBVYGiIIEHea1Bg9OGWFbnnLDJXPxRZvIj5E8QQGqzqG
         FmkTeuMtMrJtA/Hum06AMErAseUX/SZnBqGYt2CXEE/aX3ZtxvEDxQ5tch+W3wLdMJTw
         dJ1Q==
X-Gm-Message-State: AC+VfDw+MP/y7+JiTyyQm4G17I47TW7PsutFs3FXrtpUNX1Ua8Qy4Hf0
        RxoekHEKUfrGL72w6IP5MQIozJknXMrQPxzmLypFCQ==
X-Google-Smtp-Source: ACHHUZ7GoyWKFwgMIOb5nMpnMqBXPwzzWjgKhNo/zhlInr9v0vOCULYLICY2l91NepNXZAFa4macgqfs35shWJDihQ8=
X-Received: by 2002:a05:622a:110f:b0:3ef:302c:319e with SMTP id
 e15-20020a05622a110f00b003ef302c319emr832038qty.8.1688138340945; Fri, 30 Jun
 2023 08:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230630080029.15614-1-colin.i.king@gmail.com>
In-Reply-To: <20230630080029.15614-1-colin.i.king@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 08:18:49 -0700
Message-ID: <CAP-5=fUX_ktsmrrVGr9kwa3-C_4=yobTFgm5L+TpFNt8UZMZGg@mail.gmail.com>
Subject: Re: [PATCH][next] perf/benchmark: Fix spelling mistake "synchronious"
 -> "synchronous"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Jun 30, 2023 at 1:00=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in an option description. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/bench/sched-seccomp-notify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/bench/sched-seccomp-notify.c b/tools/perf/bench/s=
ched-seccomp-notify.c
> index eac4ef60090f..2e8205c61141 100644
> --- a/tools/perf/bench/sched-seccomp-notify.c
> +++ b/tools/perf/bench/sched-seccomp-notify.c
> @@ -33,7 +33,7 @@ static bool sync_mode;
>  static const struct option options[] =3D {
>         OPT_U64('l', "loop",    &loops,         "Specify number of loops"=
),
>         OPT_BOOLEAN('s', "sync-mode", &sync_mode,
> -                   "Enable the synchronious mode for seccomp notificatio=
ns"),
> +                   "Enable the synchronous mode for seccomp notification=
s"),
>         OPT_END()
>  };
>
> --
> 2.39.2
>
