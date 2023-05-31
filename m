Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B327185E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjEaPPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjEaPPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:15:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7543E12B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:15:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso6348164a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685546117; x=1688138117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Quu36W4GU+XEkXfM2HLo4LwzHXTkvm/qQekr1pKlqU=;
        b=EnWJipeL/xECJsUZckQ/PI6Okm3OpnYm9/YkkMYAuk3P/bqTNKXslUDr063//zOFjl
         7TkGPY+c6rxT3riSnJs4dfkOFL1JSr1F6ZLSTgB7cUj2q5n6iaqdFBB5WEQ18g1JM8fT
         sSP/S8CJTMifcyxkncqI3ldVYQeaWYDnCWE4radlJZ5OgOQLjx+ghH6gq7+hRlKGxNkE
         5X5njE0EAv8nCBA/rFRIIY1tJzsZ8mjg94Ol9mHnzBz7qIxr9Lm7FrsPq8XpyN+/lwuf
         GWGe55ylkteuaAwtQSdTAM/DMBC2D/9iiPeB8h9J/2b9D1fY6CDz4mMTd5DxWFLLB+/2
         fi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685546117; x=1688138117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Quu36W4GU+XEkXfM2HLo4LwzHXTkvm/qQekr1pKlqU=;
        b=CUg+gKVgPUtwEl5gDDHj1JIZ0MlZ7rulQJMzc0JnsipfDKQp9owO+SuX++gTPA4l0V
         qhGzpyJ4Lu8b9YF75zTQWCUSYDZcjRELW4C9xNcxRPsnDFDpmvykqKg/K79SewXcoW1D
         PcxOn368Tbis7nSqnWUFiFnFj0PdjZCr8ZpF0/Wt7eztEDWCtqB/NpRNCk0okfzZ3C9r
         jhjOc/6qMYHTxR6CCAqMoyldyzRabQ3kWhTdIhDVBXOWk8l+kXqqIdqyTVawTRTBj7FO
         fmAc1nkBsC+/DbECoRkGMky4584KB6R98Vd6TX44BhgqXTb0WPoex/GF0GoHusKwr6n9
         1+YQ==
X-Gm-Message-State: AC+VfDxJGgm/Rx0am6bRqR+nMcQ/IOVqH9PZB4aqJoH5I4O6ZjD//RY0
        VxjccldBugBHe9yb8vmCeeJtyg==
X-Google-Smtp-Source: ACHHUZ7j1l2WBgPDSQlv6cY9A1PO/csyIXY9okDefpzXWxmOVxxkXtn2tz+NimX7Si0YQM2HYlSmzw==
X-Received: by 2002:a17:907:1c91:b0:96f:5cb3:df66 with SMTP id nb17-20020a1709071c9100b0096f5cb3df66mr6316144ejc.18.1685546116914;
        Wed, 31 May 2023 08:15:16 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id t11-20020a170906a10b00b009663115c8f8sm9236782ejy.152.2023.05.31.08.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:15:16 -0700 (PDT)
Date:   Wed, 31 May 2023 17:15:15 +0200
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
Subject: Re: [PATCH v2 10/10] perf: tests: Adapt mmap-basic.c for riscv
Message-ID: <20230531-31bd9ddeaca8cb338f81ed14@orel>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-11-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512085321.13259-11-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 10:53:21AM +0200, Alexandre Ghiti wrote:
> riscv now supports mmaping hardware counters to userspace so adapt the test
> to run on this architecture.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  tools/perf/tests/mmap-basic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index e68ca6229756..f5075ca774f8 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -284,7 +284,7 @@ static struct test_case tests__basic_mmap[] = {
>  			 "permissions"),
>  	TEST_CASE_REASON("User space counter reading of instructions",
>  			 mmap_user_read_instr,
> -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || __riscv_xlen == 64
>  			 "permissions"
>  #else
>  			 "unsupported"
> @@ -292,7 +292,7 @@ static struct test_case tests__basic_mmap[] = {
>  		),
>  	TEST_CASE_REASON("User space counter reading of cycles",
>  			 mmap_user_read_cycles,
> -#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || __riscv_xlen == 64
>  			 "permissions"
>  #else
>  			 "unsupported"
> -- 
> 2.37.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
