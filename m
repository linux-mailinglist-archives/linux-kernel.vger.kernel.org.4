Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0516CA581
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjC0NW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjC0NW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:22:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE0926A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:22:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cn12so36194507edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679923373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3Hg3IRZJcKZEd+RKFgTwf70BPDyS0eSk5Lua/ThRTs=;
        b=a8MHnDZPBeryTpxj69Ku0ZIgR4F8C1eUbXgq43qEj3nm/+QKFfB1cbWusIyDlq9fso
         DsRyy7bxL0IIq7QtO9d4oGZFmne8zagLSW038ZOjcA4QReDUPHT7Ry1sYCdrYQ+7sM1l
         HUlq6eVAKB94+bu59WksTRygAxWbMTV24DxFQ5cUk7BzcFJ2SMiU8WLbGQ7Y0xrSCrFQ
         Dft31PkVsv7kxiAgcoMkYFEVGEu3bHUBZHulwO2xfFzzp4/f50PJr6cfPYWb9FQFjwPS
         04eguUoEkF1LmUh0p1QwY9AFO96mUYoomXcnStv5kyK3BUtD8PrXFoMkDQj+jyWSuRDN
         a8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679923373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3Hg3IRZJcKZEd+RKFgTwf70BPDyS0eSk5Lua/ThRTs=;
        b=BI4ojMbRoWPST6e6W9A3FeEzwUNEfj2HjF/ol1dXWRvia8zNf3hS2K7MBySUAXopDm
         Ag/8i02AbtMngd/LIbkKP5ABdLQaSZALY0E5RhA29mZSkquYp6YynL94Gkr5pME3qhel
         dLpovUTXnVMt+ISh1oRQyiAH6n5v9XSfAKyExsg5oDZcdXF0c9AxJUdDHwOTdY3pGxS8
         1RoK0hS6RDI6W7m5vhxslvyMCXvbAGrfk1YAlgnDiqjQ0EaVfic2HlzB+ErTVYN3Rnqj
         E8+qm6bMshi3u4y4YTX9+g94fKR67fEL/d0UyCKC3m2kEOB7OfXDDKb9LCMAJeLojMof
         wrHQ==
X-Gm-Message-State: AAQBX9eIcJyyImkJ5AJVJMZ8z8ZzmPTZCgQQgIFOnDpeFrez7YQxdD0T
        imyMuUqDial6X+8Jfm3jigrssg==
X-Google-Smtp-Source: AKy350YRV0n0E7DcfpzNQRrUb7Qfxz2jjIkfznLll4YgsqV+NzMGPMqWL6RPiy5zgm9t9SmibPweuA==
X-Received: by 2002:a17:907:75f2:b0:88a:1ea9:a5ea with SMTP id jz18-20020a17090775f200b0088a1ea9a5eamr11366800ejc.65.1679923372946;
        Mon, 27 Mar 2023 06:22:52 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id m2-20020a50d7c2000000b00501fc87352fsm7908381edj.13.2023.03.27.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:22:52 -0700 (PDT)
Date:   Mon, 27 Mar 2023 15:22:51 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <20230327132251.dejgmcpxjdrqzmvk@orel>
References: <20230323045604.536099-1-jeeheng.sia@starfivetech.com>
 <20230323045604.536099-5-jeeheng.sia@starfivetech.com>
 <20230327131025.6bawvoti65sth4rk@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327131025.6bawvoti65sth4rk@orel>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 03:10:25PM +0200, Andrew Jones wrote:
> On Thu, Mar 23, 2023 at 12:56:04PM +0800, Sia Jee Heng wrote:
> > Low level Arch functions were created to support hibernation.
> > swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> > cpu state onto the stack, then calling swsusp_save() to save the memory
> > image.
> > 
> > Arch specific hibernation header is implemented and is utilized by the
> > arch_hibernation_header_restore() and arch_hibernation_header_save()
> > functions. The arch specific hibernation header consists of satp, hartid,
> > and the cpu_resume address. The kernel built version is also need to be
> > saved into the hibernation image header to making sure only the same
> > kernel is restore when resume.
> > 
> > swsusp_arch_resume() creates a temporary page table that covering only
> > the linear map. It copies the restore code to a 'safe' page, then start
> > to restore the memory image. Once completed, it restores the original
> > kernel's page table. It then calls into __hibernate_cpu_resume()
> > to restore the CPU context. Finally, it follows the normal hibernation
> > path back to the hibernation core.
> > 
> > To enable hibernation/suspend to disk into RISCV, the below config
> > need to be enabled:
> > - CONFIG_ARCH_HIBERNATION_HEADER
> > - CONFIG_ARCH_HIBERNATION_POSSIBLE
> > 
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/Kconfig                 |   6 +
> >  arch/riscv/include/asm/assembler.h |  20 ++
> >  arch/riscv/include/asm/suspend.h   |  19 ++
> >  arch/riscv/kernel/Makefile         |   1 +
> >  arch/riscv/kernel/asm-offsets.c    |   5 +
> >  arch/riscv/kernel/hibernate-asm.S  |  77 ++++++
> >  arch/riscv/kernel/hibernate.c      | 427 +++++++++++++++++++++++++++++
> >  7 files changed, 555 insertions(+)
> >  create mode 100644 arch/riscv/kernel/hibernate-asm.S
> >  create mode 100644 arch/riscv/kernel/hibernate.c
> >
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Actually, I forgot to point out something. As hibernation depends on
suspend.c for save/restore_csrs, we need something like

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 73cca7f17f6f..f1d2289df660 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -54,7 +54,7 @@ config RISCV
        select CLINT_TIMER if !MMU
        select CLONE_BACKWARDS
        select COMMON_CLK
-       select CPU_PM if CPU_IDLE
+       select CPU_PM if CPU_IDLE || HIBERNATION
        select EDAC_SUPPORT
        select GENERIC_ARCH_TOPOLOGY
        select GENERIC_ATOMIC64 if !64BIT


Thanks,
drew
