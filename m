Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5EB618F7B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 05:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKDEds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 00:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKDEdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 00:33:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F1CDF72
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 21:33:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b185so3500789pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 21:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wepWE4KrXFxsKEWcFpjgx18r9i0Jh/wR/FjXQiA0858=;
        b=hYEu2TPYISRsKFMbiVQKHzSMt++TeF1aJ4wjBVUR/BzI5IqiVryuv37QHSjFceFqhP
         UCswDcBHH5dIDVOSIiUI6q3UjV4KXld9UhnhRv0ww2GcLwpk72Eo2ft1qVykecA8glqv
         lHV+D0/dhNnl7U2N8yNO6dCt+Wu9meRmYerNtBtBtdR+DmpCFK7oZK84zxbQx/Izuw87
         6z+T6U2KpJtIRwio1+mOvnBycRVOKquHjvZkOpbQi2JJVqBhNCUsJTujneqkebqjIeGD
         +KscwOEiskz7yz2gVb6UzrkoUhe+RMzsBMuqdgs0oziOqyfr1bJ+j9M+mRVldepmjvzP
         18Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wepWE4KrXFxsKEWcFpjgx18r9i0Jh/wR/FjXQiA0858=;
        b=Vb5ywaL/RQ56hgH7hdNOH64p/46oNqa/RjCLwTShL4S9AvFaBOPhwNT1gYOvOJGXv3
         oK48agiID2pVGkJlHSIcVYtZMc3I01IbMusWI4G7sfQePSKwXueSB2IeaHXdJHWABxqg
         0RSq3orphahbRSy8lACGXD+o7R6IWAWzJhbfg5fxGAldqP7KgZ1UmPOA3qAL8A3uKptN
         xJHgegYmdj15ai+L+N5kgX5KcW6ihwjpcqcABQ3eZO0MBSGU9BSuqkaCzvpNZYgB0ISy
         0olrJcM5ggfWsmchMiVDzqygxc3NJjt8oKnB7lNZvFU6zNmwi5WFK63gLcPP/EXZXB8t
         LZwA==
X-Gm-Message-State: ACrzQf3s90bAV2pbPYcVtyv8pt2cBiMLUm7z6eOnby75fn9AV2tEJpxA
        wlgNgo7Z0hm+6PppUDVSraHsXA==
X-Google-Smtp-Source: AMsMyM5vRCcyhyFRrnmknUVlQ9x6+P0kY+j5utb1Rm9Wud+2LgOtZgzSOSakjK1mDK14SkuAEpYueg==
X-Received: by 2002:a05:6a00:d5f:b0:56e:9868:52b6 with SMTP id n31-20020a056a000d5f00b0056e986852b6mr185075pfv.4.1667536423171;
        Thu, 03 Nov 2022 21:33:43 -0700 (PDT)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b00176acd80f69sm1540295plg.102.2022.11.03.21.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 21:33:42 -0700 (PDT)
Message-ID: <3d8aa022-a73e-aa27-5219-12dcf9f20443@rivosinc.com>
Date:   Thu, 3 Nov 2022 21:33:39 -0700
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
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Dao Lu <daolu@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>, Guo Ren <guoren@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>, linux-mm@kvack.org
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

I'd move this patch v2/17 as part of detection etc.

> +#ifdef CONFIG_VECTOR
> +	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> +		static_branch_enable(&cpu_hwcap_vector);

Ditto.

> +		/* There are 32 vector registers with vlenb length. */
> +		rvv_enable();
> +		riscv_vsize = csr_read(CSR_VLENB) * 32;

Ditto.

> +		rvv_disable();

But guess these needs to be added first as well, see below.


> +#ifdef CONFIG_VECTOR
> +#include <asm/vector.h>
> +EXPORT_SYMBOL(rvv_enable);
> +EXPORT_SYMBOL(rvv_disable);

As suggested in prior review comment, we don't need to EXPORT these, for 
now at least.

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

SPDX hdr ...

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
Perhaps best to add this code in the patch which actually uses these.

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

This is rvv_enable code duplicated inline.

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

I'd suggest these be made asm macros, to avoid function call overhead 
and duplication as in save/restore above.
