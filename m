Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F0E63BFB8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiK2MHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiK2MGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:06:17 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C267C5E3ED
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:05:13 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id r18so12782915pgr.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARx8DGGG2NwsFzqPTbWSTy92epmGEhrwV9D25Nv/aKQ=;
        b=OZIonAJ76iD3afXMWfxXGJoGySAf7m1aUnJ9zofdYlJcEx+oUrx1IXN9Za+pdVAVY5
         o6S1I6dWBbUZqH+qbmjanvyEkyKa/B1uvmIfsjBlfTHLnWoK1BJIrh9kFNl1WyunISqC
         wpjilY7vRtAecRBsh7Enj19N4PxTkY6LVcAAJ1f+0f3ykToU5Niu0ow0bKqpNS5wqTVv
         9nqstZYCXpWc2YlXjKJA8EorsTes1HKi0P867BLLSHzm7rYy+J0bpx0Qg6tp8vfxaHZw
         sVl+9k2AoRU2BHFwiWk1JStNVm8ZsbDjFpVlcSUncSmLjewWVxG4aS1sdKa/FvDSyV1g
         rIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARx8DGGG2NwsFzqPTbWSTy92epmGEhrwV9D25Nv/aKQ=;
        b=5is/H6JRCQvcqvZNzWsyW8zLhRRORijXDFnLpX8rnvuBT0LlUcFBCL/4mGzATqcxdx
         KW15tXeQhE/3xNRENbLEhwAXcoAUI3aI2DJweR6Adzs6KW9GhuXyv+zYIPucTJ2FyiBB
         V3LG7Up6gRCsj9sT9Xz5s0vK3Ky4pwqhTgudvr1blQuljD2D482JmRE8gWi6MQN1MIt3
         qhTKMxz+Z87joIDB8jMTit62+1CE+sEcoEWX+yMMR9ojrZuDWB1Pt79nH0EhI5u5FCCa
         wAeVOlo7EgQ0Mfrzlj1dwuHCTtzgLk84qByfEwh0zfeGcaplkof3amSeIb4DgCvrjj+y
         J2aA==
X-Gm-Message-State: ANoB5pkbiYzyAT7PAV6xkmu+N1LDMDgt43DyA9Hq94pIGuQ5OkUX3cZ/
        9Abm9FQZJk+s+YzktGwvfbSRhItQUmIvVWwQKQA=
X-Google-Smtp-Source: AA0mqf4phHbt1c0jNw+uLhjgh/om2vq4LWvPE/lm+COFFgqYF6IvLc8TldoF1IjBa1Tg0x4agOWdVS6yKdwuE+izErs=
X-Received: by 2002:a65:694e:0:b0:474:6749:407d with SMTP id
 w14-20020a65694e000000b004746749407dmr30583002pgq.425.1669723509931; Tue, 29
 Nov 2022 04:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20221128154506.2691-1-suagrfillet@gmail.com>
In-Reply-To: <20221128154506.2691-1-suagrfillet@gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Tue, 29 Nov 2022 12:04:56 +0000
Message-ID: <CAAYs2=iYn8sLQB8oh+RzTKd2VKs8MXOLX6Mwpamx5gdVVN6mkA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv/ftrace: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
To:     guoren@kernel.org
Cc:     paul.walmsley@sifive.com, wangkefeng.wang@huawei.com,
        juerg.haefliger@canonical.com, anshuman.khandual@arm.com,
        alexandre.ghiti@canonical.com, conor.dooley@microchip.com,
        atishp@atishpatra.org, heiko@sntech.de, palmer@dabbelt.com,
        apatel@ventanamicro.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=80 15:45=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Song Shuai <suagrfillet@gmail.com>
>
> In RISC-V, -fpatchable-function-entry option is used to support
> dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
> PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
> don't have to be called to create the __mcount_loc section before
> the vmlinux linking.
>
> Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> Makefile not to run recordmcount.
>
> Link: https://lore.kernel.org/linux-riscv/CAAYs2=3Dj3Eak9vU6xbAw0zPuoh00r=
h8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
This patch has conflicts with the commit ("riscv: ftrace: Add
DYNAMIC_FTRACE_WITH_DIRECT_CALLS
support") and its next commit in this file.

How about reposting this patch based on the above commits and folding
it into the v5 version?

Here pastes the link for your convenience.
https://lore.kernel.org/linux-riscv/20221129033230.255947-7-guoren@kernel.o=
rg/T/#u

> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fa78595a6089..afc520a45ded 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -277,6 +277,7 @@ config ARCH_RV64I
>         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-=
fpatchable-function-entry=3D8)
>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> +       select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRA=
CE
>         select HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>         select SWIOTLB if MMU
> --
> 2.34.1
>


--
Thanks,
Song
