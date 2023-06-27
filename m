Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D918274018C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjF0QnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF0QnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:43:13 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC2697
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:43:12 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34292a63a13so2705ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687884192; x=1690476192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd+gLHYQ1AoomQaxFmG+4g614Pp8bCTvfSrZgBja4D0=;
        b=s3I0ZZUq41/3bkANZ5KYntfmHbG4p0O/HfbuiWMRtN51MfnHUKnfW4oXgNxzv6DFw0
         5N40mdH9YD0X3dJCGJi6NB2OrwOoU6MX4PfoTvQ+R2+0WTQpIZkVQBsayH4I/O78+uUd
         zg8nnBTLnnEt1e9PHxLzw1HJ1tEg8ANTPlHUNfP/YN5IXTqALw1cOB3NewqEGTnsAq9M
         Gg7cL97mgOZbTWpXxWXV0p/JntnXhTLui/6uOlMKnBfqdmJ/9b2GOt6Vb3Sj5/btWjV9
         qyjxaHoilYa9DzTyKw8wP2BqqPmABCrB8mUONyNB9rggS1/edGy6/zQYYqIcsE4wWYUM
         ly4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687884192; x=1690476192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd+gLHYQ1AoomQaxFmG+4g614Pp8bCTvfSrZgBja4D0=;
        b=Fv/q+XUrrNliPnPpDvtlixhZZ1i4XkUggNt/ZSogKhTaFR3Yhwq6ZaRDj+8HtDCyLH
         JAP6qqauAcEZ7E922IzQyOnrc5q+2lMzR8RlVfFMXgta1XpR9edWqG0UpubnOVZkID5S
         wnqkDgbK409DZyrEpuQcVCnwA+O40vt+vePc4CZb+ttBvEAltpLgoecJD14mHxQWvzbg
         Vt4plC0hi39PGfPO7hgZcgz4Nm0/0XtV+riCQJqIuTxjFktsetO+/ZlUafW0H5xum7MQ
         KvIPcyHgR3fDLjqK7g8Qnwe32y7pKcf+6hrE8Zt1CKvcV9StQUBud7bqZm44FTJP9yMI
         w23Q==
X-Gm-Message-State: AC+VfDzazI2pcglsyHaysmrF7arIZkgD60Gy2EhPY/USwaEXr9j35IdQ
        HZVIBrlFwyv+bxh1VyqhAADXIVObltGaH+vUQcVlAQ==
X-Google-Smtp-Source: ACHHUZ4zf4Hxtt1rbBisEBTD69na8j98wh/gboVZ/9Jzb7K+VyWXv0MjEDalCiq5CrPIk8DoXi/IHgVVOQPGaGsI6lc=
X-Received: by 2002:a05:6e02:218b:b0:33d:8608:7596 with SMTP id
 j11-20020a056e02218b00b0033d86087596mr698518ila.15.1687884192170; Tue, 27 Jun
 2023 09:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230626161059.324046-1-james.clark@arm.com> <20230626161059.324046-3-james.clark@arm.com>
 <ZJonE3ZZ2cBUq0U8@google.com>
In-Reply-To: <ZJonE3ZZ2cBUq0U8@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 27 Jun 2023 09:42:58 -0700
Message-ID: <CAP-5=fX+FDAkFoMhQY27_+fiRp_UDruP8qWTdjvqU5-uE0SdWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf report: Don't add to histogram when there is no
 thread found
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
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

On Mon, Jun 26, 2023 at 5:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Jun 26, 2023 at 05:10:58PM +0100, James Clark wrote:
> > thread__find_map() chooses to exit without assigning a thread to the
> > addr_location in some scenarios, for example when there are samples fro=
m
> > a guest and perf_guest =3D=3D false. This results in a segfault when ad=
ding
> > to the histogram because it uses unguarded accesses to the thread membe=
r
> > of the addr_location.
>
> Looking at the commit 0dd5041c9a0ea ("perf addr_location: Add
> init/exit/copy functions") that introduced the change, I'm not sure if
> it's the intend behavior.
>
> It might change maps and map, but not thread.  Then I think no reason
> to not set the al->thread at the beginning.
>
> How about this?  Ian?
> (I guess we can get rid of the duplicate 'al->map =3D NULL' part)

It seemed strange that we were failing to find a map (the function's
purpose) but then populating the address_location. The change below
brings back that somewhat odd behavior. I'm okay with reverting to the
old behavior, clearly there were users relying on it. We should
probably also copy maps and not just thread, as that was the previous
behavior.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> ---8<---
>
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 3860b0c74829..4cbb092e0684 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -581,15 +581,14 @@ struct map *thread__find_map(struct thread *thread,=
 u8 cpumode, u64 addr,
>         maps__zput(al->maps);
>         map__zput(al->map);
>         thread__zput(al->thread);
> +       al->thread =3D thread__get(thread);
>
>         al->addr =3D addr;
>         al->cpumode =3D cpumode;
>         al->filtered =3D 0;
>
> -       if (machine =3D=3D NULL) {
> -               al->map =3D NULL;
> +       if (machine =3D=3D NULL)
>                 return NULL;
> -       }
>
>         if (cpumode =3D=3D PERF_RECORD_MISC_KERNEL && perf_host) {
>                 al->level =3D 'k';
> @@ -605,7 +604,6 @@ struct map *thread__find_map(struct thread *thread, u=
8 cpumode, u64 addr,
>                 al->level =3D 'u';
>         } else {
>                 al->level =3D 'H';
> -               al->map =3D NULL;
>
>                 if ((cpumode =3D=3D PERF_RECORD_MISC_GUEST_USER ||
>                         cpumode =3D=3D PERF_RECORD_MISC_GUEST_KERNEL) &&
> @@ -619,7 +617,6 @@ struct map *thread__find_map(struct thread *thread, u=
8 cpumode, u64 addr,
>                 return NULL;
>         }
>         al->maps =3D maps__get(maps);
> -       al->thread =3D thread__get(thread);
>         al->map =3D map__get(maps__find(maps, al->addr));
>         if (al->map !=3D NULL) {
>                 /*
