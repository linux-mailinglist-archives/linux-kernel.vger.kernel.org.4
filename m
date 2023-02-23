Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4ED6A02F6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjBWGwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjBWGwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:52:01 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B9F4614E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:51:58 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k14-20020a05600c1c8e00b003e22107b7ccso2320151wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oGK8l3h5mbmCerxLjxKkoOYJJK4jmO+pFA71/6qBSk=;
        b=gZOsJetwwA096bJeZOCLUyT+WhDQQ+7XVqWgFcHzpjnkTk7h+88YGAH9HLSTwaAVd4
         ya+hTZLxYf7jT8hqjDKjkkp1my1GNG4ye7+m32krEdZlDiQnvYH96mnhB0jBZA+7OCpM
         kxdWvVpsPLOfpuBtdb4kbifqMcDeqRU1qfYvpZNwD2Sx8Jc9fqnek29iP1bCBeRyvXEP
         BBWncW685axavBDZbeookh8b6FsDRFYwYl6EhyWN/fxZpbyfwePSdV+IHKH/OFE3wuql
         Xk9xZqf5h0pwWlNfKmAAaZwfUq5+lNa77XHH2TRt/JFHyZTwsVqrj4QyQvCYCbMzbjHr
         oBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oGK8l3h5mbmCerxLjxKkoOYJJK4jmO+pFA71/6qBSk=;
        b=P4XHL027P3P0BuLhGwGL+Tf9DAvOv0fPAU8kc/0rdGEILPe6YUzXpUJth4Km/rtJrr
         xYkbP5iC/Y2E7wujghRXs121ouQUmU4ARQan4wwEvRbUfdYiMWHurFi6NCbl+3HwFTUP
         ilm2ueGwkhDq/R7fYbwCkZSdoP2/vfHUHt88FJPWOC5c+viSkYlfBWgEnp/GvAXYtq+e
         Q+O+CbrGinfxZBbrB9bl4YumEVlW+lxFD6oOaKLRwBXlaFcVq4PFH7VlkmENAl++tQJ6
         EDHiGs7IXtOrPY0Sjw0cTwYdbiEJyFCg6Xy105EHj3rLmW6SzF+3ispbT0/SyyKWnt4l
         7sTw==
X-Gm-Message-State: AO0yUKXvtb4c+tq+0u5l7zIWU9t5Te86s2TKi9mM3QTf1ZyfKCZmSMLc
        G4LyuE5acuvv/Ts6I6ClmlZF4g==
X-Google-Smtp-Source: AK7set9KKXCy1PA87S+/ow8hm3ufzjUPKmQkdOBKUkeyFbbVHOzwi3SZkSL9QiE22z6/B1fPW60iGg==
X-Received: by 2002:a05:600c:80f:b0:3de:1d31:1043 with SMTP id k15-20020a05600c080f00b003de1d311043mr7645731wmp.21.1677135116963;
        Wed, 22 Feb 2023 22:51:56 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003e7c89b3514sm7060640wmc.23.2023.02.22.22.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 22:51:56 -0800 (PST)
Date:   Thu, 23 Feb 2023 07:51:55 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com
Subject: Re: [PATCH v4 2/4] RISC-V: Factor out common code of
 __cpu_resume_enter()
Message-ID: <20230223065155.olemrm7cskwclzt7@orel>
References: <20230221023523.1498500-1-jeeheng.sia@starfivetech.com>
 <20230221023523.1498500-3-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221023523.1498500-3-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:35:21AM +0800, Sia Jee Heng wrote:
> The cpu_resume() function is very similar for the suspend to disk and
> suspend to ram cases. Factor out the common code into restore_csr macro
> and restore_reg macro.
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>  arch/riscv/include/asm/assembler.h | 62 ++++++++++++++++++++++++++++++
>  arch/riscv/kernel/suspend_entry.S  | 34 ++--------------
>  2 files changed, 65 insertions(+), 31 deletions(-)
>  create mode 100644 arch/riscv/include/asm/assembler.h
> 
> diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
> new file mode 100644
> index 000000000000..727a97735493
> --- /dev/null
> +++ b/arch/riscv/include/asm/assembler.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + *
> + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> + */
> +
> +#ifndef __ASSEMBLY__
> +#error "Only include this from assembly code"
> +#endif
> +
> +#ifndef __ASM_ASSEMBLER_H
> +#define __ASM_ASSEMBLER_H
> +
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/csr.h>
> +
> +/*
> + * restore_csr - restore hart's CSR value
> + */
> +	.macro restore_csr

Since there are more than one, 'restore_csrs' would be more appropriate
and s/CSR value/CSRs/

> +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
> +		csrw	CSR_EPC, t0
> +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
> +		csrw	CSR_STATUS, t0
> +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
> +		csrw	CSR_TVAL, t0
> +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
> +		csrw	CSR_CAUSE, t0
> +	.endm
> +
> +/*
> + * restore_reg - Restore registers (except A0 and T0-T6)
> + */
> +	.macro restore_reg

restore_regs

> +		REG_L	ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
> +		REG_L	sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
> +		REG_L	gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
> +		REG_L	tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
> +		REG_L	s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
> +		REG_L	s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
> +		REG_L	a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
> +		REG_L	a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
> +		REG_L	a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
> +		REG_L	a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
> +		REG_L	a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
> +		REG_L	a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
> +		REG_L	a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
> +		REG_L	s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
> +		REG_L	s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
> +		REG_L	s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
> +		REG_L	s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
> +		REG_L	s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
> +		REG_L	s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
> +		REG_L	s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
> +		REG_L	s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
> +		REG_L	s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
> +		REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> +	.endm
> +
> +#endif	/* __ASM_ASSEMBLER_H */
> diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspend_entry.S
> index aafcca58c19d..74a8fab8e0f6 100644
> --- a/arch/riscv/kernel/suspend_entry.S
> +++ b/arch/riscv/kernel/suspend_entry.S
> @@ -7,6 +7,7 @@
>  #include <linux/linkage.h>
>  #include <asm/asm.h>
>  #include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
>  #include <asm/csr.h>
>  #include <asm/xip_fixup.h>
>  
> @@ -83,39 +84,10 @@ ENTRY(__cpu_resume_enter)
>  	add	a0, a1, zero
>  
>  	/* Restore CSRs */
> -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
> -	csrw	CSR_EPC, t0
> -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
> -	csrw	CSR_STATUS, t0
> -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
> -	csrw	CSR_TVAL, t0
> -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
> -	csrw	CSR_CAUSE, t0
> +	restore_csr
>  
>  	/* Restore registers (except A0 and T0-T6) */
> -	REG_L	ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
> -	REG_L	sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
> -	REG_L	gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
> -	REG_L	tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
> -	REG_L	s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
> -	REG_L	s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
> -	REG_L	a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
> -	REG_L	a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
> -	REG_L	a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
> -	REG_L	a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
> -	REG_L	a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
> -	REG_L	a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
> -	REG_L	a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
> -	REG_L	s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
> -	REG_L	s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
> -	REG_L	s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
> -	REG_L	s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
> -	REG_L	s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
> -	REG_L	s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
> -	REG_L	s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
> -	REG_L	s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
> -	REG_L	s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
> -	REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> +	restore_reg
>  
>  	/* Return zero value */
>  	add	a0, zero, zero
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

