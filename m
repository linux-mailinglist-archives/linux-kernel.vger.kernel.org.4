Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3A71846E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjEaONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbjEaONP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:13:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE7B10CE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:10:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6e72a1464so43916085e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685542137; x=1688134137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UleDEf3AixBo9U/UXpWY/ydRnuyv0U623659h0izsxQ=;
        b=koil+svP7HdTb91zoSY+U+ZP8xZJE1eB+NXfryEFaeyXkJhVZJ5jnCn0NnY72fmXQD
         MKlF87Nwe77i8K5FKqJdcirMETphmNe4JWYRC7wUuPu10oPYYJJitM/5KQ6Njbu5rA8o
         wB+RQCrg7ThCLdsvibEzj3kWAP+tjJH1xFO2HwreCbwgq4oMojrAL96KkF91fDa9mjS8
         SmudzHwc6WtW1RNza3sq4mCNAjbpTFsRe87CXvY3S1YsO/LVyWF1NIT2lSuQTkkfW3hh
         zqtdt+SUlzVoVb1Kb/KjvJk3S/rbFuZZH7mVrRLp2uc/38QBtWwGYB55vWNtE/TpVEeH
         +42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542137; x=1688134137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UleDEf3AixBo9U/UXpWY/ydRnuyv0U623659h0izsxQ=;
        b=kaGpZIX6uNmG37SjZSKtWoA5sioEMkzt8rjCr8zxEf8M+M/c2ORB/GifyYbktb/u6X
         OWsO0W2UtmY9uuBhs5iS1TkkIkcijNRNsDyWelBokbsUMXdvyRLW664QWMX+FckYYA4V
         YLlm3/0ZYyQohiVLyCuIRr452FtnashtZS+w3Z/URwn0OFzMlNrA4vCMVn81YkS0dweG
         1l36/FS3X37M04VgzqDwx3w0GNWgl/J9uQ3woAODPpD/a0tvtKjrGWQHUfu2FgTI3ZtX
         YmCucXrrelpR2ysvh3umz7kOz1987FwtMWGQ5rjj/DzMtuW83yntosiCLxcrtR8b/jVb
         1Z5Q==
X-Gm-Message-State: AC+VfDwi7eqbvMjzatXcyxSZAHQ4aE4qM0NDKZfvr1YIZT6qI6Exekm+
        U+N6t2Ul+etc2EAalC6DPFQo0+s1h3q+LTbDkFg=
X-Google-Smtp-Source: ACHHUZ73Q8q9IJwMsX7edY6y2EM+CFjk3itDAZXOWz2NI9uE9E+/V3YrQjB4Rf2f+g7r1cETzEjw8g==
X-Received: by 2002:a17:907:1c14:b0:968:2bb1:f39d with SMTP id nc20-20020a1709071c1400b009682bb1f39dmr6314966ejc.36.1685541371576;
        Wed, 31 May 2023 06:56:11 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id va15-20020a17090711cf00b0094ee99eeb01sm9041514ejb.150.2023.05.31.06.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 06:56:10 -0700 (PDT)
Date:   Wed, 31 May 2023 15:56:10 +0200
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
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 02/10] include: riscv: Fix wrong include guard in
 riscv_pmu.h
Message-ID: <20230531-707d254be1238272fb2c182d@orel>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512085321.13259-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 10:53:13AM +0200, Alexandre Ghiti wrote:
> The current include guard prevents the inclusion of asm/perf_event.h
> which uses the same include guard: fix the one in riscv_pmu.h so that it
> matches the file name.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  include/linux/perf/riscv_pmu.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
> index 43fc892aa7d9..9f70d94942e0 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -6,8 +6,8 @@
>   *
>   */
>  
> -#ifndef _ASM_RISCV_PERF_EVENT_H
> -#define _ASM_RISCV_PERF_EVENT_H
> +#ifndef _RISCV_PMU_H
> +#define _RISCV_PMU_H
>  
>  #include <linux/perf_event.h>
>  #include <linux/ptrace.h>
> @@ -81,4 +81,4 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr);
>  
>  #endif /* CONFIG_RISCV_PMU */
>  
> -#endif /* _ASM_RISCV_PERF_EVENT_H */
> +#endif /* _RISCV_PMU_H */
> -- 
> 2.37.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
