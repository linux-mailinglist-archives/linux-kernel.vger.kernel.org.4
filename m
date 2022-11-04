Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7292618F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 05:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKDEKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 00:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKDEKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 00:10:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1384A21E1B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 21:10:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so7137817pji.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 21:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fi8KcnFgLbFZn4EmtIrVW3sFxfc7iM4ws8KRz12zBS4=;
        b=l16k8LJt9UMqD+W/3FB6PKWbn0gqNL76Ueik7fMpM+9CpMMKDd6LN2D/gnMt/cXWmi
         LtKA4bpEtTWF+qX7Fh91GatmXqQnBErF/wTEqhjnGralWWQ8phIwMETnbTUPCp5naZeG
         9GLVGt9ArlkZaHHe1f22GtX2prKrjo6DAyhkq41KGg2TFJUcp8tyhL7j4ir3hDjH7zT5
         9g8vSO7y1gjVF9XIdCkYo7NMuIQV/OLqtETihNbsBSNb1Nx9/7i5RsVIhcCYnHiYwwtK
         SyNtKckjo33Qi8R3Gjse/YEr6iZc1zZF9eOxHnnRVKFoMwCVpYBehnIcmroPu5ug16ql
         CECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fi8KcnFgLbFZn4EmtIrVW3sFxfc7iM4ws8KRz12zBS4=;
        b=CzxVQaQKw07LDjUDA1UAOSJ+dqX5h7OpywiG3EW4ktu6l79mg6HG7mAQZntC8bHL3X
         EmoxXlfg4irJvdHRfilvCR8E7p5ld3k5wsM4sGajIqMHkXG2LdYNJCc28zctToS0fnI6
         OTvUoX5Lyb/Jym+lv6BkWAf32wqLevmGLOFbpGoMRDkWZGLgGrJDkQttpLIWFoq2x27Y
         YMx8jAb5FTsFsIX6lE5VVRw9WDVZyyjsrV9olfv3gOHoCi9+y7TcFVknwA7sTZvCjGvL
         LXJRqaoES5cFwNluBiMXaUQkRH5JWZudpTlSyKQpw5nrSnAks4TS7F6C7kwZkXdSEbcr
         6lRQ==
X-Gm-Message-State: ACrzQf3F8Jp15yIFBvOvONI7XaHunezGkD9SKopc+l+etzZI0PRqqOFr
        W4PvlSHnOacdD98v0q6ObGoXjg==
X-Google-Smtp-Source: AMsMyM4Ya+CXIjZNB6gKQeMTnbbAArqDDLdxjQ1rMBze3JIfgZTXPhlFM2cIAxEifnm0xw7LqleDfQ==
X-Received: by 2002:a17:902:e888:b0:186:a6be:1106 with SMTP id w8-20020a170902e88800b00186a6be1106mr33073935plg.150.1667535031546;
        Thu, 03 Nov 2022 21:10:31 -0700 (PDT)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id z11-20020a1709027e8b00b001869f2120absm1382409pla.294.2022.11.03.21.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 21:10:30 -0700 (PDT)
Message-ID: <e6d97b24-caa6-f945-0379-7eeeb12f1fb2@rivosinc.com>
Date:   Thu, 3 Nov 2022 21:10:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v12 05/17] riscv: Add has_vector/riscv_vsize to save
 vector features.
Content-Language: en-US
To:     Chris Stillson <stillson@rivosinc.com>
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Oleg Nesterov <oleg@redhat.com>, Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Dao Lu <daolu@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-5-stillson@rivosinc.com>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <20220921214439.1491510-5-stillson@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 14:43, Chris Stillson wrote:
> From: Greentime Hu <greentime.hu@sifive.com>
> 
> This patch is used to detect vector support status of CPU and use
> riscv_vsize to save the size of all the vector registers. It assumes
> all harts has the same capabilities in SMP system.

Patch title is horrible. The meat of patch is vector state save/restore, 
but no users of it yet. And then there are random unrelated snippets 
thrown in same patch.

> 
> [guoren@linux.alibaba.com: add has_vector checking]
> Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>   arch/riscv/include/asm/vector.h | 14 +++++
>   arch/riscv/kernel/cpufeature.c  | 19 +++++++
>   arch/riscv/kernel/riscv_ksyms.c |  6 +++
>   arch/riscv/kernel/vector.S      | 93 +++++++++++++++++++++++++++++++++
>   4 files changed, 132 insertions(+)
>   create mode 100644 arch/riscv/include/asm/vector.h
>   create mode 100644 arch/riscv/kernel/vector.S
> 
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
> new file mode 100644
> index 000000000000..16304b0c6a6f
> --- /dev/null
> +++ b/arch/riscv/include/asm/vector.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2020 SiFive
> + */
> +
> +#ifndef __ASM_RISCV_VECTOR_H
> +#define __ASM_RISCV_VECTOR_H
> +
> +#include <linux/types.h>
> +
> +void rvv_enable(void);
> +void rvv_disable(void);
> +
> +#endif /* ! __ASM_RISCV_VECTOR_H */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 8d4448c2d4f4..0487ab19b234 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -30,6 +30,14 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>   
>   __ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
>   EXPORT_SYMBOL(riscv_isa_ext_keys);
> +#ifdef CONFIG_FPU
> +__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
> +#endif

This needs to be broken out to a FPU patch which actually uses 
cpu_hwcap_fpu.

> +#ifdef CONFIG_VECTOR
> +#include <asm/vector.h>
> +__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_vector);
> +unsigned long riscv_vsize __read_mostly;
> +#endif

I would have moved all the detection code to patch 2/17 - including the 
static branch definition and enable below (except for vlen stuff)

>   
>   /**
>    * riscv_isa_extension_base() - Get base extension word
> @@ -249,6 +257,16 @@ void __init riscv_fill_hwcap(void)
>   		if (j >= 0)
>   			static_branch_enable(&riscv_isa_ext_keys[j]);
>   	}
> +
> +#ifdef CONFIG_VECTOR
> +	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> +		static_branch_enable(&cpu_hwcap_vector);
> +		/* There are 32 vector registers with vlenb length. */
> +		rvv_enable();
> +		riscv_vsize = csr_read(CSR_VLENB) * 32;
> +		rvv_disable();
> +	}
> +#endif


>   }
>   
>   #ifdef CONFIG_RISCV_ALTERNATIVE
> @@ -328,3 +346,4 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>   	}
>   }
>   #endif
> +}
> diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
> index 5ab1c7e1a6ed..3489d2a20ca3 100644
> --- a/arch/riscv/kernel/riscv_ksyms.c
> +++ b/arch/riscv/kernel/riscv_ksyms.c
> @@ -15,3 +15,9 @@ EXPORT_SYMBOL(memmove);
>   EXPORT_SYMBOL(__memset);
>   EXPORT_SYMBOL(__memcpy);
>   EXPORT_SYMBOL(__memmove);
> +
> +#ifdef CONFIG_VECTOR
> +#include <asm/vector.h>
> +EXPORT_SYMBOL(rvv_enable);
> +EXPORT_SYMBOL(rvv_disable);
> +#endif
> diff --git a/arch/riscv/kernel/vector.S b/arch/riscv/kernel/vector.S
> new file mode 100644
> index 000000000000..9f7dc70c4443
> --- /dev/null
> +++ b/arch/riscv/kernel/vector.S
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2012 Regents of the University of California
> + * Copyright (C) 2017 SiFive
> + * Copyright (C) 2019 Alibaba Group Holding Limited
> + *
> + *   This program is free software; you can redistribute it and/or
> + *   modify it under the terms of the GNU General Public License
> + *   as published by the Free Software Foundation, version 2.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + */
> +
> +#include <linux/linkage.h>
> +
> +#include <asm/asm.h>
> +#include <asm/csr.h>
> +#include <asm/asm-offsets.h>
> +
> +#define vstatep  a0
> +#define datap    a1
> +#define x_vstart t0
> +#define x_vtype  t1
> +#define x_vl     t2
> +#define x_vcsr   t3
> +#define incr     t4
> +#define status   t5
> +

A few words here as to when is this save/restore done.
Best to do this in the patch which actually uses this code.

> +ENTRY(__vstate_save)
> +	li      status, SR_VS
> +	csrs    CSR_STATUS, status
> +
> +	csrr    x_vstart, CSR_VSTART
> +	csrr    x_vtype, CSR_VTYPE
> +	csrr    x_vl, CSR_VL
> +	csrr    x_vcsr, CSR_VCSR
> +	vsetvli incr, x0, e8, m8, ta, ma
> +	vse8.v   v0, (datap)
> +	add     datap, datap, incr
> +	vse8.v   v8, (datap)
> +	add     datap, datap, incr
> +	vse8.v   v16, (datap)
> +	add     datap, datap, incr
> +	vse8.v   v24, (datap)
> +
> +	REG_S   x_vstart, RISCV_V_STATE_VSTART(vstatep)
> +	REG_S   x_vtype, RISCV_V_STATE_VTYPE(vstatep)
> +	REG_S   x_vl, RISCV_V_STATE_VL(vstatep)
> +	REG_S   x_vcsr, RISCV_V_STATE_VCSR(vstatep)
> +
> +	csrc	CSR_STATUS, status
> +	ret
> +ENDPROC(__vstate_save)
> +
> +ENTRY(__vstate_restore)
> +	li      status, SR_VS
> +	csrs    CSR_STATUS, status
> +
> +	vsetvli incr, x0, e8, m8, ta, ma
> +	vle8.v   v0, (datap)
> +	add     datap, datap, incr
> +	vle8.v   v8, (datap)
> +	add     datap, datap, incr
> +	vle8.v   v16, (datap)
> +	add     datap, datap, incr
> +	vle8.v   v24, (datap)
> +
> +	REG_L   x_vstart, RISCV_V_STATE_VSTART(vstatep)
> +	REG_L   x_vtype, RISCV_V_STATE_VTYPE(vstatep)
> +	REG_L   x_vl, RISCV_V_STATE_VL(vstatep)
> +	REG_L   x_vcsr, RISCV_V_STATE_VCSR(vstatep)
> +	vsetvl  x0, x_vl, x_vtype
> +	csrw    CSR_VSTART, x_vstart
> +	csrw    CSR_VCSR, x_vcsr
> +
> +	csrc	CSR_STATUS, status
> +	ret
> +ENDPROC(__vstate_restore)
> +
> +ENTRY(rvv_enable)
> +	li      status, SR_VS
> +	csrs    CSR_STATUS, status
> +	ret
> +ENDPROC(rvv_enable)
> +
> +ENTRY(rvv_disable)
> +	li      status, SR_VS
> +	csrc	CSR_STATUS, status
> +	ret
> +ENDPROC(rvv_disable)

