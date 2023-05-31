Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0469C7184A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjEaOUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbjEaOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:19:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7891BF
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:18:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3a9ad31dbso7063333e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685542725; x=1688134725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgpyzmnbNHAseyCM+s0XsB0KjofBbxw68PBCInlqrLM=;
        b=DFr7UXRlc6yXh90+zCA+Jj1Yz/bSk70wHg+X/lA8QnCBFTzy7b0c/H/xIsRu2qzdT5
         y+tYbNiTRp9sojjbDybOGgsrvqVKn0YCJYcwHHjJocjHzE1bPjHbqQC/CI9EVHXhkKKL
         L6jpBB2p/JRhVFJX8PoEQIg8ATkzch/hKUsja5omZVNfvnP5jKyQ2fwnyBCQXF+rzvOt
         qHNIglojzigq58kiCv9HvsmuaZkf2jSeThx0hMEte54JcQw8lKPI6XG+BCYbUBudPUTo
         GayK9LMWT+3kL7gkYSWJOxSH/3jUEoVHHKUjS2fGfKpFd5pCfYB7rtKpYmL0hVEU3GgZ
         AevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542725; x=1688134725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgpyzmnbNHAseyCM+s0XsB0KjofBbxw68PBCInlqrLM=;
        b=Oqp+sKXjEiVt1OD1KSxVRS4heiPxksaT3wYDJ5E6en/XU9k7MADyojVF55fsMjdsXB
         B7CLy17+pTdhZx/ULTZMyoHFE4vsqrmcABWTl/14ncaeOTcBC3ecFakToRYGPLww7WV4
         7XIfL/ALl0eJM3xSTFZdjdc5JLZZSKdSXltpT2uRZPaJyRPP79jC+RgHWXTMvfVabgch
         RB7kdrgpy/gLd8eQ0cFELTIZhszNZwpT3AbNUmJUJEJR7/Hp2Ch9LaONJokaiesn1c3y
         pLr8QzDIhquNpQgRlCvi/J+NB5CGiOlJcUYV47DLeqJODXOmHw7EOPtprDJgcoBPpw5A
         iNkg==
X-Gm-Message-State: AC+VfDw9AoPgcKqZwmhDJxevCdl/g62WX+ZeQ+Z2713tGGBlbKy5GTvc
        LkDiNFwJXPvwkiyfzI5ic+yOy1MLyeB6m8EyBcc=
X-Google-Smtp-Source: ACHHUZ6/5u1aIeEPR87Cph6/LuYqwzkXH6Ggsh21iSthCsoK8ecfPiKMDhYwuo0sJqTdGafvLc34yA==
X-Received: by 2002:a5d:526e:0:b0:309:50e7:7c3 with SMTP id l14-20020a5d526e000000b0030950e707c3mr4408962wrc.63.1685542170038;
        Wed, 31 May 2023 07:09:30 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id d15-20020a056000114f00b0030af72bca98sm4800839wrx.103.2023.05.31.07.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:09:29 -0700 (PDT)
Date:   Wed, 31 May 2023 16:09:28 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 04/10] drivers: perf: Rename riscv pmu driver
Message-ID: <20230531-49ed4c2054db0abbacd03632@orel>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-5-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512085321.13259-5-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 10:53:15AM +0200, Alexandre Ghiti wrote:
> In addition to being more pretty, it will be useful in upcoming commits
> to distinguish those pmu drivers from the other pmu drivers.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_legacy.c | 2 +-
>  drivers/perf/riscv_pmu_sbi.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
> index 0d8c9d8849ee..ffe09d857366 100644
> --- a/drivers/perf/riscv_pmu_legacy.c
> +++ b/drivers/perf/riscv_pmu_legacy.c
> @@ -95,7 +95,7 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>  	pmu->ctr_clear_idx = NULL;
>  	pmu->ctr_read = pmu_legacy_read_ctr;
>  
> -	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
> +	perf_pmu_register(&pmu->pmu, RISCV_PMU_LEGACY_PDEV_NAME, PERF_TYPE_RAW);
>  }
>  
>  static int pmu_legacy_device_probe(struct platform_device *pdev)
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 70cb50fd41c2..3b0ee2148054 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -897,7 +897,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_unregister;
>  
> -	ret = perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
> +	ret = perf_pmu_register(&pmu->pmu, RISCV_PMU_PDEV_NAME, PERF_TYPE_RAW);

Should we include "sbi" in this name?

>  	if (ret)
>  		goto out_unregister;
>  
> -- 
> 2.37.2
> 

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
