Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E7374DAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjGJQIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGJQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:08:31 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76ECC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:08:29 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40371070eb7so398831cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689005308; x=1691597308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCZ478BjRJ70dGPiyazKHs2AHwhWpPHvIJs192KkWtA=;
        b=raiwsZg/csJTCrSWgdBtnd9ljQyiwBv9lV8BD6vdvUmrIz14MewJmemne/YcRSjxbQ
         pZ7wYvDSB2QJECcClLFUE3RWyzO70AqfIXdN54acUD9e4VCf7E96xJ/q5k9bjJuoE+tD
         JZakBTUj4gklq22OZnalVTtBFhnREB4OGxMMw0/P0B8XzioIPEtt/t1xZ/v8L8px72w+
         p4IOjS2dSrLhywDqFRPqIhfRTEljzI6Dj+mWCIGdyqDRtMLWzzheC3hJ+I4v/HYdzd9u
         JLT/+Eo+wjXAAusil+Q9GA6rF6UA5d3PjaY1qMdAIpbInGaZAuuI1/6ABHPeTSm3nQ5Z
         G6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689005308; x=1691597308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCZ478BjRJ70dGPiyazKHs2AHwhWpPHvIJs192KkWtA=;
        b=a08AmEm+F0NcpcTXyDZ8R1iVI4aonXVWgFKJY4qh7OnWrD8fIbHFQ812DI35Vtj0Yz
         euVUgEYHSEil3LtShrLyC6cV7hfUxaBz0WL0GGnfAcQMvMO/pb0PxCybJdBAsMuEukiV
         s04iGRXM9atpCb9g9kHv/dYLQxtJFESK8Ub2IQQ5xEgCx5TV9iIUypvxraZ/ypfWADcR
         Iup/QFxETBGZNe5SoX0QFi+OYqMIwRBbPIwNee/SHHNE+NmqrYsVe6WCRxqDWnHyGSU3
         bs21iKRwUCeEZ2gfx3zajNMN676hJSZcz0Uz39oyxq/waENeWTKYqKJFPGvbjCj/fGRp
         lfAw==
X-Gm-Message-State: ABy/qLYCvGrfJif+YzoLO7SUKHKdhNZVT6WjKobQ8ljZDaOWcEIrllP8
        zBh3nCmFSZ1yYQ8GraZ8oSqquxtGclhB+QnhYXuDPA==
X-Google-Smtp-Source: APBJJlFy1h+xduL4V4mkm/cNZocGgxpL/alpQAW35hY7UfCdCZZXX0KwLjWG4NbXvtKvDxjK6aTHSCnAsTEFRr1B05Y=
X-Received: by 2002:ac8:5850:0:b0:3f8:5b2:aef5 with SMTP id
 h16-20020ac85850000000b003f805b2aef5mr285849qth.29.1689005308540; Mon, 10 Jul
 2023 09:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230710122138.1450930-1-james.clark@arm.com> <20230710122138.1450930-4-james.clark@arm.com>
In-Reply-To: <20230710122138.1450930-4-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jul 2023 09:08:17 -0700
Message-ID: <CAP-5=fVqHi8M+xCL3ORiabfbaoMSugS=AkPDdhgs5TPUypzqHA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm_pmu: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS
 capability
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 5:22=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> Since commit bd2756811766 ("perf: Rewrite core context handling") the
> relationship between perf_event_context and PMUs has changed so that
> the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
> silenced no longer exists.
>
> Remove the capability and associated comment to avoid confusion that it
> actually influences any perf core behavior. This change should be a
> no-op.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  drivers/perf/arm_pmu.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index d8844a9461a2..297906df6628 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -872,15 +872,12 @@ struct arm_pmu *armpmu_alloc(void)
>                 .attr_groups    =3D pmu->attr_groups,
>                 /*
>                  * This is a CPU PMU potentially in a heterogeneous
> -                * configuration (e.g. big.LITTLE). This is not an uncore=
 PMU,
> -                * and we have taken ctx sharing into account (e.g. with =
our
> -                * pmu::filter callback and pmu::event_init group validat=
ion).
> -                *
> +                * configuration (e.g. big.LITTLE) so
>                  * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open the =
legacy
>                  * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
>                  * specific PMU.
>                  */
> -               .capabilities   =3D PERF_PMU_CAP_HETEROGENEOUS_CPUS | PER=
F_PMU_CAP_EXTENDED_REGS |
> +               .capabilities   =3D PERF_PMU_CAP_EXTENDED_REGS |
>                                   PERF_PMU_CAP_EXTENDED_HW_TYPE,
>         };
>
> --
> 2.34.1
>
