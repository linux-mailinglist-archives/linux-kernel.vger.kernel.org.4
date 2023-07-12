Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6174FE94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjGLFDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGLFDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:03:12 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B7810E3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:03:11 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-401d1d967beso124731cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689138190; x=1691730190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWqgo9ch58QO6RaJ3RurqQJj+97McdmoLo9JFZJT7aE=;
        b=e0PfKiB+KtsxPEO9lO30LmAxZK2/I2tiNU2BdBFs52hLqXtLdAoXPUQW2Uv+7jYLiT
         csmCMXtu3jIaFKdoqknruNgAHhrj1s/LhSn1QP5IlYJr3ukes6tiKZ8fsv9lUPdfwhkI
         Wxi0sPzGlZwPXzl45oNMZ74zywz3HTbL++5HecdDauU+YcXXivoGBuwh9y6AIUEPUCAL
         JV+NVxNqUEkg5GxYPnlNUUfiTPwhJ06yCelp6bm6WE35LOz8J9Z+AIEAeBOm+ISOaSbP
         foq3JXT4oTL0GIdau+v4mDf+X5abps1gsM8Nim45cWT6ZtPLM/NYpQZvoWZtCUA95BMG
         lC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689138190; x=1691730190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWqgo9ch58QO6RaJ3RurqQJj+97McdmoLo9JFZJT7aE=;
        b=TaWP7cvXRUGJ0njkEpzIFfJtcVV5g+Hm1nbL0sFFfYxsbBerz+REK3WTaG+usWJwn2
         mUhK/DXosj1aj+TLYnp3+3j6eqywLgbEYX//dCwqyJ7bVLO78kvAPdOhuX/dTe8qICvg
         NWngjtYnIMRX3a30puK0vj9tYSrofCum8u93/NEUBCXrzW2QHqpNrhcc0UumwuT1SH1R
         3Feck0/J5NhNH+iNrQw573kIjNseTUb9mv1RTK9/Fi8dGzuRmSt4ka8jGIJIl1zNvv3L
         lqjmYwOuixLjK3BxfW+gFKiQcIP2UZzXXmQKbuN65SgJPA3/Gy7xis7RAASNyaTm0N+L
         RSDw==
X-Gm-Message-State: ABy/qLYaOl2njXs4wZ5iD1ilVX1hgAjrbAPkqoRgE49WS/st8wpCt7HR
        xExwH7Ae14cfBLkZAjgjar17eJZ3k5mB6BXFDZPwdUdqEOTaLjpNHKY=
X-Google-Smtp-Source: APBJJlF5X00VyyfFQORSYwFYdQOkrD5s6atbZB7qfu78cC/IMrJvp/ItF6bi0AoaB9my4Gh69EUR3dw9nMPx8YHCFcg=
X-Received: by 2002:a05:622a:1ba7:b0:403:c739:a5a3 with SMTP id
 bp39-20020a05622a1ba700b00403c739a5a3mr18296qtb.11.1689138190092; Tue, 11 Jul
 2023 22:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230706094635.1553-1-luhongfei@vivo.com>
In-Reply-To: <20230706094635.1553-1-luhongfei@vivo.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 11 Jul 2023 22:02:58 -0700
Message-ID: <CAP-5=fWs+19O-tHUVtxY79svL-oFjKDO-0-bF1Kdn2+VObxxaQ@mail.gmail.com>
Subject: Re: [PATCH] tools: perf: Two typos have been corrected
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 2:46=E2=80=AFAM Lu Hongfei <luhongfei@vivo.com> wrot=
e:
>
> When wrapping code, use ';' better than using ',' which is more
> in line with the coding habits of most engineers.
>
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-diff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index e8a1b16aa5f8..57d300d8e570 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1915,8 +1915,8 @@ static int data_init(int argc, const char **argv)
>                 struct perf_data *data =3D &d->data;
>
>                 data->path  =3D use_default ? defaults[i] : argv[i];
> -               data->mode  =3D PERF_DATA_MODE_READ,
> -               data->force =3D force,
> +               data->mode  =3D PERF_DATA_MODE_READ;
> +               data->force =3D force;
>
>                 d->idx  =3D i;
>         }
> --
> 2.39.0
>
