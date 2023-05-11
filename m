Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FE96FED19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbjEKHoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbjEKHon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:44:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B9159F4
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:44:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f315735514so272957905e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683791080; x=1686383080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y7qAtEMxa98mvEq/S2OukRFlZVR9DoGyplQJNjwBgK0=;
        b=R7T1iEjwHEdDoKl7KR+Ybdp7bLhR+D8GLS3jghPvQNi+HgmDCIXWHLlhgmfkvduPel
         M6kDgCRzlUOXQvgLlzJR1wqmCzM7gj+TOztB77TMQidnwbJ0HgDpY8hqZesROdFmOA0O
         1CmhF5zzEiFDxKn7jUbMTXoS3Im6Aviw50gHH1ZZQ4DHmzWZWjfdcxfuA+LIo1emAx3D
         JhMF0W0wU8QBIdFq+uvEwj8AjgYWMEgzd6foHvKW2cvCc19bP3JGrRBPLjFluvHYDRRI
         lhGgL9fdRQX7JjtxMbiUaLwlt+C9EAHIrTlxtobZowdcAWsivQ1/QTdAj6ci8a/Usadu
         3EIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683791080; x=1686383080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7qAtEMxa98mvEq/S2OukRFlZVR9DoGyplQJNjwBgK0=;
        b=BbfHAN/lBqD7yXSB/U50WckINPqSJzEbQ8enAsSiLTvYQJ5PDG/dLZWtMm/07qa3sc
         Sk7khU1LR6fRvxqj6sIvA7d9m1dgf+Jg/DiCQpOAjgxcla9+s+n9IJ7n+S+v7z7cgmR4
         fGkyxp1I8+qZVcoXvjKJqXUpCpUGX/+5kuxPw/O01riKR37i5hDdDLltLVJPLgwZl6VX
         p4gKCjurPVnUjCUyEjXvHACNt6IylpgqV3J/Gg2oOMCQT+zLayLPv+icvmZ2pH51vt1I
         qsv5SuVE/p5pmFQFjEXifEALv3Uqk4lZ5oVzbsxOcS55zpqVr2e2tFQiL9prYUbJFNht
         SdNA==
X-Gm-Message-State: AC+VfDyBPHwRdkcsuGIfkxC4iw+i0LbgO6dZMoUWWl3hRmMr/5vQUsfk
        +/yEEBekrmiux6i7HpateW2pUAzq+Ptwg88ZXR0=
X-Google-Smtp-Source: ACHHUZ6MvbTf3fJCVEA3AWYjhFzyvctocpaef1a+OBd91Ok80ccq383ThuXnoe+ie6dwnbGlU1m45Q==
X-Received: by 2002:a7b:cb93:0:b0:3f4:2374:3511 with SMTP id m19-20020a7bcb93000000b003f423743511mr10333379wmi.10.1683791080630;
        Thu, 11 May 2023 00:44:40 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003f07ef4e3e0sm10730643wmo.0.2023.05.11.00.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 00:44:40 -0700 (PDT)
Date:   Thu, 11 May 2023 09:44:39 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     zhangfei <zhang_fei_0403@163.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor.dooley@microchip.com,
        zhangfei@nj.iscas.ac.cn
Subject: Re: [PATCH v2 0/2] RISC-V: Optimize memset for data sizes less than
 16 bytes
Message-ID: <20230511-75718c538818fb3e1d924f9a@orel>
References: <20230511012604.3222-1-zhang_fei_0403@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511012604.3222-1-zhang_fei_0403@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 09:26:04AM +0800, zhangfei wrote:
> From: zhangfei <zhangfei@nj.iscas.ac.cn>
> 
> At present, the implementation of the memset function uses byte by byte storage 
> when processing tail data or when the initial data size is less than 16 bytes. 
> This approach is not efficient. Therefore, I filled head and tail with minimal 
> branching. Each conditional ensures that all the subsequently used offsets are 
> well-defined and in the dest region. Although this approach may result in 
> redundant storage, compared to byte by byte storage, it allows storage instructions 
> to be executed in parallel, reduces the number of jumps, and ultimately achieves 
> performance improvement.
> 
> I used the code linked below for performance testing and commented on the memset 
> that calls the arm architecture in the code to ensure it runs properly on the 
> risc-v platform.
> 
> [1] https://github.com/ARM-software/optimized-routines/blob/master/string/bench/memset.c#L53
> 
> The testing platform selected RISC-V SiFive U74.The test data is as follows:
> 
> Before optimization
> ---------------------
> Random memset (bytes/ns):
>            memset_call 32K:0.45 64K:0.35 128K:0.30 256K:0.28 512K:0.27 1024K:0.25 avg 0.30
> 
> Medium memset (bytes/ns):
>            memset_call 8B:0.18 16B:0.48 32B:0.91 64B:1.63 128B:2.71 256B:4.40 512B:5.67
> Large memset (bytes/ns):
>            memset_call 1K:6.62 2K:7.02 4K:7.46 8K:7.70 16K:7.82 32K:7.63 64K:1.40
> 
> After optimization
> ---------------------
> Random memset bytes/ns):
>            memset_call 32K:0.46 64K:0.35 128K:0.30 256K:0.28 512K:0.27 1024K:0.25 avg 0.31
> Medium memset (bytes/ns )
>            memset_call 8B:0.27 16B:0.48 32B:0.91 64B:1.64 128B:2.71 256B:4.40 512B:5.67
> Large memset (bytes/ns):
>            memset_call 1K:6.62 2K:7.02 4K:7.47 8K:7.71 16K:7.83 32K:7.63 64K:1.40
> 
> From the results, it can be seen that memset has significantly improved its performance with 
> a data volume of around 8B, from 0.18 bytes/ns to 0.27 bytes/ns.
> 
> The previous work was as follows:
> 1. "[PATCH] riscv: Optimize memset"
>    6d1cbe2e.3c31d.187eb14d990.Coremail.zhangfei@nj.iscas.ac.cn

Cover letters should have a changelog, in this case a couple phrases
stating what's different in v2 vs. v1.

Thanks,
drew

> 
> Thanks,
> Fei Zhang
> 
> Andrew Jones (1):
>   RISC-V: lib: Improve memset assembler formatting
> 
>  arch/riscv/lib/memset.S | 143 ++++++++++++++++++++--------------------
>  1 file changed, 72 insertions(+), 71 deletions(-)
> 
> zhangfei (1):
>   RISC-V: lib: Optimize memset performance
> 
>  arch/riscv/lib/memset.S | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
