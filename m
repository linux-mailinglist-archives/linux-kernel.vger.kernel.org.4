Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6D5725037
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbjFFWvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbjFFWva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:51:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C238C1726
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:51:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1b72dc2feso54040271fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 15:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1686091882; x=1688683882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al2xYZY6FuJQFCBLak3ruv1N1e9teyj7OXYSWGcgwcw=;
        b=IlZg3LPKMvnqdPS95MLiEtwIA9fkPdZLI+EHS9NT4CcYqHVUSrUQWKd6aQJe4yGWUl
         HjpSLRG9/plGyS7+pYr94ES4c0SGqs/U3FSrsZ7Nr3c3NIgi7Cp9yGNnUgO/wI3pUUoL
         hC7zQMJDcv5xuTdb2ajzR5ziWjC5YqaJw7rTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686091882; x=1688683882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Al2xYZY6FuJQFCBLak3ruv1N1e9teyj7OXYSWGcgwcw=;
        b=R0VlJkOL8ZwxkVssP8zUj9HoR7Q/rrfueAmB3X0VpSdc5OdlzQ+l4E4RCKpcIpIpsB
         ksMS6sVxkP5OVm5FWT28nm3vclPhOzJRDHDBF0x7uzr+4TZonH6l6yNw0LmTP3MMWTJm
         IS1zd2EW2jprEl6OfboRCE1tuVtOSplhNEid6RZNDNb+uiLl07n2OWrcq2aBuin/1adX
         YlH8Ddnfta9U7ILzytanNrprDRkBa6oPSrS4ifcgBFeYU6yA3xZWuug+NKoebIUClH/+
         aIXpCD2ckm12S4bynm0+riUkTy4UuuUkyMpkWaV3cIfXHLeymvRGpK6CDxtDy3fVGhyC
         rb+Q==
X-Gm-Message-State: AC+VfDwe/1bQixCfXhUf0dq29z6NezYjdFLyR0RVSOXA2nVQQhs3rFNO
        bQlY2ojpXyCfwgAYF6mqdogQb3boIdpibBjj7jZy
X-Google-Smtp-Source: ACHHUZ7muC261tDsIzo2VNiUIe7XqgqfmkAeGrI6jWPs9hugC3KM1trP+B7MVyMAtiPvnUMgrQTLz5pj82HRU4BjHWE=
X-Received: by 2002:a2e:a0cd:0:b0:2b1:e648:f355 with SMTP id
 f13-20020a2ea0cd000000b002b1e648f355mr1975523ljm.3.1686091881950; Tue, 06 Jun
 2023 15:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230517105135.1871868-1-apatel@ventanamicro.com> <20230517105135.1871868-3-apatel@ventanamicro.com>
In-Reply-To: <20230517105135.1871868-3-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 6 Jun 2023 15:51:10 -0700
Message-ID: <CAOnJCU+OS+6izzM0SEBjnzSEs=HNYkbX556vTw95gwB+SvHx_A@mail.gmail.com>
Subject: Re: [PATCH 02/10] RISC-V: KVM: Add IMSIC related defines
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 3:51=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> We add IMSIC related defines in a separate header so that different
> parts of KVM code can share it. Once AIA drivers are merged will
> have a common IMSIC header shared by both KVM and IRQCHIP driver.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_aia_imsic.h | 38 ++++++++++++++++++++++++++
>  arch/riscv/kvm/aia.c                   |  3 +-
>  2 files changed, 39 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/kvm_aia_imsic.h
>
> diff --git a/arch/riscv/include/asm/kvm_aia_imsic.h b/arch/riscv/include/=
asm/kvm_aia_imsic.h
> new file mode 100644
> index 000000000000..da5881d2bde0
> --- /dev/null
> +++ b/arch/riscv/include/asm/kvm_aia_imsic.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + * Copyright (C) 2022 Ventana Micro Systems Inc.
> + */
> +#ifndef __KVM_RISCV_AIA_IMSIC_H
> +#define __KVM_RISCV_AIA_IMSIC_H
> +
> +#include <linux/types.h>
> +#include <asm/csr.h>
> +
> +#define IMSIC_MMIO_PAGE_SHIFT          12
> +#define IMSIC_MMIO_PAGE_SZ             (1UL << IMSIC_MMIO_PAGE_SHIFT)
> +#define IMSIC_MMIO_PAGE_LE             0x00
> +#define IMSIC_MMIO_PAGE_BE             0x04
> +
> +#define IMSIC_MIN_ID                   63
> +#define IMSIC_MAX_ID                   2048
> +
> +#define IMSIC_EIDELIVERY               0x70
> +
> +#define IMSIC_EITHRESHOLD              0x72
> +
> +#define IMSIC_EIP0                     0x80
> +#define IMSIC_EIP63                    0xbf
> +#define IMSIC_EIPx_BITS                        32
> +
> +#define IMSIC_EIE0                     0xc0
> +#define IMSIC_EIE63                    0xff
> +#define IMSIC_EIEx_BITS                        32
> +
> +#define IMSIC_FIRST                    IMSIC_EIDELIVERY
> +#define IMSIC_LAST                     IMSIC_EIE63
> +
> +#define IMSIC_MMIO_SETIPNUM_LE         0x00
> +#define IMSIC_MMIO_SETIPNUM_BE         0x04
> +
> +#endif
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index 1cee75a8c883..c78c06d99e39 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -15,6 +15,7 @@
>  #include <linux/percpu.h>
>  #include <linux/spinlock.h>
>  #include <asm/hwcap.h>
> +#include <asm/kvm_aia_imsic.h>
>
>  struct aia_hgei_control {
>         raw_spinlock_t lock;
> @@ -364,8 +365,6 @@ static int aia_rmw_iprio(struct kvm_vcpu *vcpu, unsig=
ned int isel,
>         return KVM_INSN_CONTINUE_NEXT_SEPC;
>  }
>
> -#define IMSIC_FIRST    0x70
> -#define IMSIC_LAST     0xff
>  int kvm_riscv_vcpu_aia_rmw_ireg(struct kvm_vcpu *vcpu, unsigned int csr_=
num,
>                                 unsigned long *val, unsigned long new_val=
,
>                                 unsigned long wr_mask)
> --
> 2.34.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
