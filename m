Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE7863B3DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiK1VEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiK1VEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:04:38 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7862FC18
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:04:31 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id v81so13019840oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3p6Xc2awnVHXaW8GbjDppIU7epKFr+L8bVkeNSCSj5A=;
        b=KkgARuVQ5Drz/MpWTLAgUaK/xzIwu2TSlICaiYVUTUx9VBuvrt1kHIqDEKm06Q9h52
         CgZZeFUDjx4dD+MvKfsmpr+plfOBrPsTXwoapMOuPnumz21i68R+EC9mA3gzao7j7H3W
         D8mdjIPQvhxQDVJpTJtTZ4HISn1MeQEbBmDGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3p6Xc2awnVHXaW8GbjDppIU7epKFr+L8bVkeNSCSj5A=;
        b=hD1xZ+bBpBcxbBRlfCfFp07+UN89veXJ6x1Iz5VNkG+HljxPXxVjX3zTV+pbW2AdI2
         9hyqIFQ/7MMtgDDQ5cJz2Usv0BJ9cbFbA2fuxTHHKoC3m2Up6LS9bzYrvUSGdeEvj2bu
         BWjcV/QAs+36PRPaMwrL456WcF/kPGJWaTbiaruK0MGF9RglpOsEkYFKEStH7KEyw1Cx
         5F5opJfY2/uivtzxVqbXXb+hYxRANQbTS7Ln+8TdrgKpq19zbBOHFaV4/ng4Y1Jw69Wn
         y+3JabCW99xtZ+S2MhwbUf3w1ME89njQ0LkrDvvFoamHFLwtJvXNRIYAhCoY8hWX7jAz
         7WMA==
X-Gm-Message-State: ANoB5plmCQSSGd+QG8DZZ7hfCyfTxTcTngSReIy2CQvVai+8O7poeEZH
        PWFSgLVPeTrgAhCbkFeEXp3VHwqc4bU8uIZVSCq5
X-Google-Smtp-Source: AA0mqf6+TtI7x5ueOyiSCG1Vj99YDCfroMM8WEeQkC/lPIQCBjwnxfvfqirvJGhdH3th8KIIqIvlRcvQ0sfSAVJu0G4=
X-Received: by 2002:a05:6808:51:b0:359:f091:104 with SMTP id
 v17-20020a056808005100b00359f0910104mr29346146oic.274.1669669470813; Mon, 28
 Nov 2022 13:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20221128161424.608889-1-apatel@ventanamicro.com> <20221128161424.608889-4-apatel@ventanamicro.com>
In-Reply-To: <20221128161424.608889-4-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 28 Nov 2022 13:04:20 -0800
Message-ID: <CAOnJCUJT_WcBk3bkB7BnA+xPSGoLH0W19ZAwUD2NhnfyApsL5g@mail.gmail.com>
Subject: Re: [PATCH 3/9] RISC-V: KVM: Remove redundant includes of asm/csr.h
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 8:14 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> We should include asm/csr.h only where required so let us remove
> redundant includes of this header.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_host.h | 1 -
>  arch/riscv/kvm/vcpu_sbi_base.c    | 1 -
>  arch/riscv/kvm/vcpu_sbi_hsm.c     | 1 -
>  arch/riscv/kvm/vcpu_sbi_replace.c | 1 -
>  arch/riscv/kvm/vcpu_sbi_v01.c     | 1 -
>  5 files changed, 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index dbbf43d52623..6502f9099965 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -13,7 +13,6 @@
>  #include <linux/kvm.h>
>  #include <linux/kvm_types.h>
>  #include <linux/spinlock.h>
> -#include <asm/csr.h>
>  #include <asm/hwcap.h>
>  #include <asm/kvm_vcpu_fp.h>
>  #include <asm/kvm_vcpu_insn.h>
> diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
> index 22b9126e2872..0c806f61c629 100644
> --- a/arch/riscv/kvm/vcpu_sbi_base.c
> +++ b/arch/riscv/kvm/vcpu_sbi_base.c
> @@ -10,7 +10,6 @@
>  #include <linux/err.h>
>  #include <linux/kvm_host.h>
>  #include <linux/version.h>
> -#include <asm/csr.h>
>  #include <asm/sbi.h>
>  #include <asm/kvm_vcpu_sbi.h>
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
> index 239dec0a628a..2e915cafd551 100644
> --- a/arch/riscv/kvm/vcpu_sbi_hsm.c
> +++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
> @@ -9,7 +9,6 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/kvm_host.h>
> -#include <asm/csr.h>
>  #include <asm/sbi.h>
>  #include <asm/kvm_vcpu_sbi.h>
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
> index 4c034d8a606a..03a0198389f0 100644
> --- a/arch/riscv/kvm/vcpu_sbi_replace.c
> +++ b/arch/riscv/kvm/vcpu_sbi_replace.c
> @@ -9,7 +9,6 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/kvm_host.h>
> -#include <asm/csr.h>
>  #include <asm/sbi.h>
>  #include <asm/kvm_vcpu_timer.h>
>  #include <asm/kvm_vcpu_sbi.h>
> diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c b/arch/riscv/kvm/vcpu_sbi_v01.c
> index 8a91a14e7139..489f225ee66d 100644
> --- a/arch/riscv/kvm/vcpu_sbi_v01.c
> +++ b/arch/riscv/kvm/vcpu_sbi_v01.c
> @@ -9,7 +9,6 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/kvm_host.h>
> -#include <asm/csr.h>
>  #include <asm/sbi.h>
>  #include <asm/kvm_vcpu_timer.h>
>  #include <asm/kvm_vcpu_sbi.h>
> --
> 2.34.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
