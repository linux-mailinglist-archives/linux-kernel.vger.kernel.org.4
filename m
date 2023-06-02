Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E059672059F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbjFBPLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbjFBPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:11:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CB010F2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:11:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b021cddb74so11093425ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1685718665; x=1688310665;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fg/hT1sAjEd8rIup2CN/upwAvrKBrR2pDnfw7PopqQs=;
        b=hzC+VK1jGbXhgWkUL0OeOG1AJqJbOX3K5gyj68YKEVb25v+GV//e4fuQzpeld+sA8O
         2WdHnDWRmeXmx6geUq25Vqxa42Hwlwqdf2d3i39t0QDaQut+gvISpWJtIZYz6ATNTV4J
         1QgEA/SczaV3YNFw9abTToLwu9ommsI9VhXE9xT7mkCTEttc+N0EQxPZMpDLxdvRsYj/
         vigM1fvZ6FnHiCjG/KwbRAMRDaIrv/Z/FRrNAxXbI5k0K/HQDFft3bQe5wCk1Fv5vZNL
         qf3LvjUpS8LXDQb0jauHzcz/lrdIold+VYUYF2cO5H6ly0TtjlRd8yC6CMLl3XKwdH1F
         m3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685718665; x=1688310665;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg/hT1sAjEd8rIup2CN/upwAvrKBrR2pDnfw7PopqQs=;
        b=DdtHhvG3igKFpFgXUFiF+h/9OvupKZLGFdMbYcyP0Dn5D/7YceTeL3vJpq9OBWrO+/
         0p5IXRW+efJn85T/gngAhGsTTu0wZJoYPTPmJ1kD5w0rSvnR03kOec+kdwqILx+iUo7D
         NbtP7HkuFDdzTPRQsyu8ppxiRzXui9/6Fht/cfOpfMtAXav+0Gi/iBZWyzW7E/4/RLWp
         sBeD6aTjH6xdkOH9FJb6XYXbG859ECnuDS46BIVHgcm/RI+lB3xbcYULG5rThfoCHCF4
         tjfxfi/joJXDps0fbXFiNLls4BSvfKi8D61JaBhH+ZpYUorRwUOOz3sac/wXDiGW6XUu
         JydA==
X-Gm-Message-State: AC+VfDwTxbHREcMkyjTlg3mcrgTdZgENU69uTAeOUIODXzEi10/+id2A
        WLWRbsw/8o/Kq4VEBhVSbK4eXQ==
X-Google-Smtp-Source: ACHHUZ4iv27hx94ZjANRzx1oNWxLXW5Ls2Q/boifCy7lcHk8Olifk19LX70BLLdSoojjPpYWMlRiwQ==
X-Received: by 2002:a17:902:cec9:b0:1a9:8d57:6d6c with SMTP id d9-20020a170902cec900b001a98d576d6cmr254164plg.24.1685718665293;
        Fri, 02 Jun 2023 08:11:05 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b001b03cda6389sm1520434pln.10.2023.06.02.08.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:11:04 -0700 (PDT)
Date:   Fri, 02 Jun 2023 08:11:04 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Jun 2023 08:10:51 PDT (-0700)
Subject:     Re: (subset) [PATCH V6 00/21] Add basic ACPI support for RISC-V
In-Reply-To: <168571787727.17224.6663458864222960682.b4-ty@rivosinc.com>
CC:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, rafael@kernel.org, lenb@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        qianweili@huawei.com, wangzhou1@hisilicon.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>, luzmaximilian@gmail.com,
        hdegoede@redhat.com, markgross@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunilvl@ventanamicro.com, Bjorn Topel <bjorn@rivosinc.com>,
        Conor Dooley <conor@kernel.org>
Message-ID: <mhng-4fad860f-b5ff-4dc1-968e-219be1983acd@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2023 07:57:57 PDT (-0700), Palmer Dabbelt wrote:
>
> On Mon, 15 May 2023 11:19:07 +0530, Sunil V L wrote:
>> This patch series enables the basic ACPI infrastructure for RISC-V.
>> Supporting external interrupt controllers is in progress and hence it is
>> tested using poll based HVC SBI console and RAM disk.
>>
>> The first patch in this series is one of the patch from Jisheng's
>> series [1] which is not merged yet. This patch is required to support
>> ACPI since efi_init() which gets called before sbi_init() can enable
>> static branches and hits a panic.
>>
>> [...]
>
> Applied, thanks!
>
> [01/21] riscv: move sbi_init() earlier before jump_label_init()
>         https://git.kernel.org/palmer/c/24fc18087f42
> [02/21] platform/surface: Disable for RISC-V
>         https://git.kernel.org/palmer/c/7f2e20459b28
> [03/21] crypto: hisilicon/qm: Fix to enable build with RISC-V clang
>         https://git.kernel.org/palmer/c/fbb995a7b27c
> [04/21] ACPI: tables: Print RINTC information when MADT is parsed
>         https://git.kernel.org/palmer/c/4d02d88d2b92
> [05/21] ACPI: OSL: Make should_use_kmap() 0 for RISC-V
>         https://git.kernel.org/palmer/c/214c236223b8
> [06/21] RISC-V: Add support to build the ACPI core
>         https://git.kernel.org/palmer/c/a91a9ffbd3a5
> [07/21] ACPI: processor_core: RISC-V: Enable mapping processor to the hartid
>         https://git.kernel.org/palmer/c/8b7809e28952
> [08/21] RISC-V: Add ACPI initialization in setup_arch()
>         https://git.kernel.org/palmer/c/724f4c0df766
> [09/21] RISC-V: ACPI: Cache and retrieve the RINTC structure
>         https://git.kernel.org/palmer/c/f99561199470
> [10/21] drivers/acpi: RISC-V: Add RHCT related code
>         https://git.kernel.org/palmer/c/e6b9d8eddb17
> [11/21] RISC-V: smpboot: Create wrapper setup_smp()
>         https://git.kernel.org/palmer/c/61946127ab49
> [12/21] RISC-V: smpboot: Add ACPI support in setup_smp()
>         https://git.kernel.org/palmer/c/ce92546cd637
> [13/21] RISC-V: only iterate over possible CPUs in ISA string parser
>         https://git.kernel.org/palmer/c/914d6f44fc50
> [14/21] RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()
>         https://git.kernel.org/palmer/c/396c018332a1
> [15/21] RISC-V: cpu: Enable cpuinfo for ACPI systems
>         https://git.kernel.org/palmer/c/0b144c818989
> [16/21] irqchip/riscv-intc: Add ACPI support
>         https://git.kernel.org/palmer/c/7023b9d83f03
> [17/21] clocksource/timer-riscv: Refactor riscv_timer_init_dt()
>         https://git.kernel.org/palmer/c/cd12d206685a
> [18/21] clocksource/timer-riscv: Add ACPI support
>         https://git.kernel.org/palmer/c/21f4f92410dc
> [19/21] RISC-V: time.c: Add ACPI support for time_init()
>         https://git.kernel.org/palmer/c/714aa1d1c8ca
> [20/21] RISC-V: Enable ACPI in defconfig
>         https://git.kernel.org/palmer/c/0b8e15ca0082

I applied the MAINTAINERS entry too, it just had a conflict and it looks 
like my attempt at juggling it didn't play nice with the thanks message.  
Everything's on top of rc1 because that's what my for-next is based on.

I also don't yet have any testing for the ACPI stuff, but hopefully I'll 
get around to adding some.  We should probably add it to the patchwwork 
CI as well.

>
> Best regards,
