Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B225731240
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbjFOIeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244866AbjFOIeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:34:25 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800212940
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:34:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b448b24a66so2125171fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1686818062; x=1689410062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOUuXh6LkHViNleXIOakwtRWdQ9JIjITkUXKZrXdE44=;
        b=dsFsxX9NzLHxh8ziw/gPNEVf2K7Iiy/Q308RAWmRpFaYqIQJ1r5328jelF+drS0JS2
         +2hKkC13N/IuU48umjqUbsFQwa0tGqHeuulBLsC34FvZRp39kpROk+zItB1aZtjKli6H
         douxZUHkvyYCrvyNZqPjqVgd7R+ClO2B1t5FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818062; x=1689410062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOUuXh6LkHViNleXIOakwtRWdQ9JIjITkUXKZrXdE44=;
        b=jWkUsX+ga6qMflQIH52fwH5kq+RZAEb8Kz/GgEbeNeu0AfTercj1coEdgQU55Ywq+W
         ujaY24XQZlpf3BUvNjElf4tokisH+FaV7phaza6fyaKHx5xkMlNv5DUAHwvXzNRBd5VM
         VuALLk4yRmHXmJROZ7UWTiZZdLlAkHOA8vXlof7feb8DyVmYWmi7GWpdlv3kglqc/f+D
         88Gp48l1RbJrrvdQ2ijVJQ6fE0JK41ITtRdNy6FDjurwm1yZumU3zwX8KtVvL5STsLLK
         CAUQjnszOaoUqZnemKJGUCmlvCIxbYxoF92Zh4yqW16BGX5db2jy2ipaY0tbaxyw7W4F
         Wx0w==
X-Gm-Message-State: AC+VfDypLUv97MarEhzkpsUHyCo3+DxR4RoRUiMxeEAmz7jw0IbNie7T
        ZiTJavXid2oPrRHwr6HCtL/ySgF+wEGhTpdV066A
X-Google-Smtp-Source: ACHHUZ7Re7eG1GNlDD8M+Z7LAqeY4hwZD9akdA2bTvqq2esGdprdeu7d9Y69jONfiP1qhBujHcI2VjHNjyziGs1ljxE=
X-Received: by 2002:a2e:7c15:0:b0:2b1:d6bf:d8b2 with SMTP id
 x21-20020a2e7c15000000b002b1d6bfd8b2mr9598864ljc.22.1686818061744; Thu, 15
 Jun 2023 01:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-5-alexghiti@rivosinc.com> <20230531-49ed4c2054db0abbacd03632@orel>
 <6d9fefd9-472c-b8d3-d871-b81bfdbe4f6d@ghiti.fr>
In-Reply-To: <6d9fefd9-472c-b8d3-d871-b81bfdbe4f6d@ghiti.fr>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 15 Jun 2023 01:34:10 -0700
Message-ID: <CAOnJCUJhfzotL5ErjCKTfGjH2kw5W-e6VdwR37KZa-N_M9NDBQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] drivers: perf: Rename riscv pmu driver
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:25=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wr=
ote:
>
>
> On 31/05/2023 16:09, Andrew Jones wrote:
> > On Fri, May 12, 2023 at 10:53:15AM +0200, Alexandre Ghiti wrote:
> >> In addition to being more pretty, it will be useful in upcoming commit=
s
> >> to distinguish those pmu drivers from the other pmu drivers.
> >>
> >> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >> ---
> >>   drivers/perf/riscv_pmu_legacy.c | 2 +-
> >>   drivers/perf/riscv_pmu_sbi.c    | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_=
legacy.c
> >> index 0d8c9d8849ee..ffe09d857366 100644
> >> --- a/drivers/perf/riscv_pmu_legacy.c
> >> +++ b/drivers/perf/riscv_pmu_legacy.c
> >> @@ -95,7 +95,7 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
> >>      pmu->ctr_clear_idx =3D NULL;
> >>      pmu->ctr_read =3D pmu_legacy_read_ctr;
> >>
> >> -    perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
> >> +    perf_pmu_register(&pmu->pmu, RISCV_PMU_LEGACY_PDEV_NAME, PERF_TYP=
E_RAW);
> >>   }
> >>
> >>   static int pmu_legacy_device_probe(struct platform_device *pdev)
> >> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi=
.c
> >> index 70cb50fd41c2..3b0ee2148054 100644
> >> --- a/drivers/perf/riscv_pmu_sbi.c
> >> +++ b/drivers/perf/riscv_pmu_sbi.c
> >> @@ -897,7 +897,7 @@ static int pmu_sbi_device_probe(struct platform_de=
vice *pdev)
> >>      if (ret)
> >>              goto out_unregister;
> >>
> >> -    ret =3D perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
> >> +    ret =3D perf_pmu_register(&pmu->pmu, RISCV_PMU_PDEV_NAME, PERF_TY=
PE_RAW);
> > Should we include "sbi" in this name?
>
>
> I'd say that it is safe to do so and I understand your point, @Atish WDYT=
?
>

Actually, the argument in perf_pmu_register is about the pmu instance
name rather than the driver name.
Both legacy & SBI PMU drivers are just ways to access the "cpu" pmu instanc=
e.

In future we may have separate drivers for counter delegation
extensions that won't use the SBI PMU extension
at all for supported hardware. However, the PMU would still be cpu pmu.

There will be different SoC PMU drivers which will have different
names because it will represent SoC PMU instead of cpu pmu.

>
> >
> >>      if (ret)
> >>              goto out_unregister;
> >>
> >> --
> >> 2.37.2
> >>
> > Otherwise,
> >
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>



--=20
Regards,
Atish
