Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420066C6E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCWRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjCWRAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:00:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8A9C5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:00:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3ee75104d2cso56605e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679590809;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUol+gIMtQKOAhQw7QtvtbIC1bGcoAW2dXKwXzWBXXk=;
        b=VhgGPN+FX34nPVJ2xN7eJA3bE4E2emohZVQj1Kx9AUAwGR/CDotHCQ1aNhlH6NML5l
         z3V80shFdB3FJFo8AU1xtBqgnQJbRuXParGdRlle+LO3t67m0AFTjKpvbCqHHAD/RugC
         QnCpG2jEtNpFZ6DaUlPrI4pAVyC3oR90pF0uD1OWq6VDnaG2f7x3JzGhhNsP0iITpQR3
         XKn1berfUSIR19KymwD53IiGSIAUBtpbl3XKcrCrGe8YCLIPsUGF+/SDH8q2JxujhdgH
         FPJxgPqhk7zajBxu8zMd64nSBy7pOvxAfY2PA1obWvR27GgJIN0eBhoMA6z06PxAAp0J
         AXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679590809;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUol+gIMtQKOAhQw7QtvtbIC1bGcoAW2dXKwXzWBXXk=;
        b=NtX8524sD/vQZmjBkGqroBbBoE+y4t+znJjj59y3Co/AYDl59WcWrpKpgqFCgE1Iaj
         CGZhTCgdcie/dM5MOno4g6JbOiT+Axx6uiXHfzi0cE1VhXx7Er6tjHXJcDx0X1Cmzv0p
         6ukn+onmWyLVEexxiYuQJfYRSa7r3zpwooLLf5SzorgWjKGUQa4fyQTxMg6U8U2pjOF5
         DIV/3amiJvKMBO+d7UvWTF6770VvnoZv08PVic5D6qpbNhT7PLIpEBTSIBf86yz8Fdjp
         PQjWcQ1DgeDow7aFpp2WfJ9wSDvwE4O74Qeo/3x2xCl5XDcgMw+4ZZvChYoAUp7FhATS
         80WA==
X-Gm-Message-State: AO0yUKW8/8fBvi6FmegHfQtPfYP+y0QKXcsfrEHkNUCEgED5AqvS/1+L
        r8LVZHki1FCk4mXE5z7rF2e8PhBvJmHjNEVtzj0o1Q==
X-Google-Smtp-Source: AK7set+Y7Ldly5Y4VeSE1EqYooqWVCaAA1+Kc8LoxIex2/a5eMFbubGBgcd57S5UlfxTKfsR2KDvD9pGGNGDORDed+k=
X-Received: by 2002:a05:600c:5102:b0:3ed:353e:a8a7 with SMTP id
 o2-20020a05600c510200b003ed353ea8a7mr483322wms.2.1679590808808; Thu, 23 Mar
 2023 10:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230322223801.1451827-1-irogers@google.com>
In-Reply-To: <20230322223801.1451827-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Mar 2023 09:59:57 -0700
Message-ID: <CAP-5=fW_8FEsrvYxR8wXcGJR3WFfepmfrZFcaPsHwE+ugTB9Pg@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events: Sandybridge and version number minor updates
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 3:38=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Add BR_MISP_EXEC.INDIRECT to Sandybridge. Update version numbers based on=
:
> https://github.com/intel/perfmon/pull/62
> which didn't modify the generated perf json.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

I've spotted a mistake with this and will resend.

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/x86/mapfile.csv         | 14 +++++++-------
>  .../pmu-events/arch/x86/sandybridge/pipeline.json  |  8 ++++++++
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-=
events/arch/x86/mapfile.csv
> index 9abebe50ae0d..41d755d570e6 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -2,26 +2,26 @@ Family-model,Version,Filename,EventType
>  GenuineIntel-6-(97|9A|B7|BA|BF),v1.19,alderlake,core
>  GenuineIntel-6-BE,v1.19,alderlaken,core
>  GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
> -GenuineIntel-6-(3D|47),v26,broadwell,core
> -GenuineIntel-6-56,v7,broadwellde,core
> -GenuineIntel-6-4F,v19,broadwellx,core
> +GenuineIntel-6-(3D|47),v27,broadwell,core
> +GenuineIntel-6-56,v9,broadwellde,core
> +GenuineIntel-6-4F,v20,broadwellx,core
>  GenuineIntel-6-55-[56789ABCDEF],v1.17,cascadelakex,core
>  GenuineIntel-6-9[6C],v1.03,elkhartlake,core
>  GenuineIntel-6-5[CF],v13,goldmont,core
>  GenuineIntel-6-7A,v1.01,goldmontplus,core
>  GenuineIntel-6-A[DE],v1.01,graniterapids,core
> -GenuineIntel-6-(3C|45|46),v32,haswell,core
> -GenuineIntel-6-3F,v26,haswellx,core
> +GenuineIntel-6-(3C|45|46),v33,haswell,core
> +GenuineIntel-6-3F,v27,haswellx,core
>  GenuineIntel-6-(7D|7E|A7),v1.17,icelake,core
>  GenuineIntel-6-6[AC],v1.19,icelakex,core
>  GenuineIntel-6-3A,v23,ivybridge,core
>  GenuineIntel-6-3E,v22,ivytown,core
> -GenuineIntel-6-2D,v22,jaketown,core
> +GenuineIntel-6-2D,v23,jaketown,core
>  GenuineIntel-6-(57|85),v10,knightslanding,core
>  GenuineIntel-6-A[AC],v1.01,meteorlake,core
>  GenuineIntel-6-1[AEF],v3,nehalemep,core
>  GenuineIntel-6-2E,v3,nehalemex,core
> -GenuineIntel-6-2A,v18,sandybridge,core
> +GenuineIntel-6-2A,v19,sandybridge,core
>  GenuineIntel-6-(8F|CF),v1.11,sapphirerapids,core
>  GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
>  GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v55,skylake,core
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> index 54454e5e262c..ecaf94ccc9c7 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> @@ -210,6 +210,14 @@
>          "SampleAfterValue": "200003",
>          "UMask": "0xc4"
>      },
> +    {
> +        "BriefDescription": "Speculative mispredicted indirect branches"=
,
> +        "EventCode": "0x89",
> +        "EventName": "BR_MISP_EXEC.INDIRECT",
> +        "PublicDescription": "Counts speculatively miss-predicted indire=
ct branches at execution time. Counts for indirect near CALL or JMP instruc=
tions (RET excluded).",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xe4"
> +    },
>      {
>          "BriefDescription": "Not taken speculative and retired mispredic=
ted macro conditional branches.",
>          "EventCode": "0x89",
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
