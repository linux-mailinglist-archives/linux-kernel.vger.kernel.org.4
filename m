Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA72674DABF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGJQIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjGJQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:08:03 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0DFB1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:08:02 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40371070eb7so398421cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689005281; x=1691597281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjKMlN7Hn/eUWbs2kPX1xd2yBg/zUqu1UnIgvGuGwT8=;
        b=IbOhZLPDDP4ChlJN7mEf2wdW3kbIT7JaGqTbUpcbpMhIdOqTeW7DqC6HCyVdxS6p3E
         NBWDKi01JdTf83cVhXOv2z5WT6ByNyjzEBJtaRWaP3Ld6SEYlbTCkfCCRueCrLdsROc0
         F3LQe/ey+43hD1wrWgZhClNBE0sSEzeUrsVZbxdY0RlBrZBZOxUTvwLu3lDULbfg2hLo
         Vv4PoO1HACU5sAtSnfSCnyNN5FL8x7XXDhuXT9xDegLi1po0VwCPIB16GTCcZvvSuCoY
         WMowBk13RLsadZkEX3JJPAbB3xSKyixUD2Y7dy+VbrfTUU7ln0YsE1or0a4AygL4JpR4
         mJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689005281; x=1691597281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjKMlN7Hn/eUWbs2kPX1xd2yBg/zUqu1UnIgvGuGwT8=;
        b=YIob3GIp9DgjtERjduxFH0Tg6vBLY9H5UH7CzEuLgdOW4Px/CcpjXXU+pGsl1hDyaZ
         fv0e3iuAtpo9LaSIS1U8DjRNMHismgkfBVqb9CPoQTZnqxUm/qVMq4zEfsJAHiFUK89H
         sQyBFJm+Ux1EvKBe7Hx4jvYRbWfQag2JEL+M1v+btXWjjdtoeF6PkxQHaqDSDSRIbq3g
         jjkk0YIRh20dDIY0aVGJcxwkDjN2OIefMNReMAhC3Ung3eCryYxKB3IH7zoB7v8SA/Rr
         Ks3D7lYIwyTasxkKl796LFlACxkw6a35fMQubWFmRPR2NW4b81887d5JYxQcFcxK78dY
         SdkQ==
X-Gm-Message-State: ABy/qLbbLNwog4F/j5/x9BCW6ZEXlDVXEYwmyeL6Ib12Y5bQ1zoR7LnK
        TlbV57dfw8/DcfxVAUQLTBQ6cWBPipzMBVfEdeODHg==
X-Google-Smtp-Source: APBJJlEPfdemhfM3kEi/lB1MUR6DL1XKjejvb67jS0nfqhwdVzvR8rr8wDSfM3IV+88zlch5i5raBv76nKqs8QJGFfc=
X-Received: by 2002:a05:622a:609:b0:3f5:2006:50f1 with SMTP id
 z9-20020a05622a060900b003f5200650f1mr369683qta.12.1689005281540; Mon, 10 Jul
 2023 09:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230710122138.1450930-1-james.clark@arm.com> <20230710122138.1450930-3-james.clark@arm.com>
In-Reply-To: <20230710122138.1450930-3-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jul 2023 09:07:50 -0700
Message-ID: <CAP-5=fU_pr98phNSrbaeoHoeDPrTPeC3S1c2Z-vOG-FBWn_F5Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf/x86: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS
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
> Remove the capability to avoid confusion that it actually influences
> any perf core behavior. This change should be a no-op.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 9d248703cbdd..2353aaf0b248 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2168,7 +2168,6 @@ static int __init init_hw_perf_events(void)
>                         hybrid_pmu->pmu =3D pmu;
>                         hybrid_pmu->pmu.type =3D -1;
>                         hybrid_pmu->pmu.attr_update =3D x86_pmu.attr_upda=
te;
> -                       hybrid_pmu->pmu.capabilities |=3D PERF_PMU_CAP_HE=
TEROGENEOUS_CPUS;
>                         hybrid_pmu->pmu.capabilities |=3D PERF_PMU_CAP_EX=
TENDED_HW_TYPE;
>
>                         err =3D perf_pmu_register(&hybrid_pmu->pmu, hybri=
d_pmu->name,
> --
> 2.34.1
>
