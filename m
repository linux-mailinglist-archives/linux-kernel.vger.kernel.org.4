Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74479720513
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbjFBPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbjFBPAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5851E56;
        Fri,  2 Jun 2023 08:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E16E650FE;
        Fri,  2 Jun 2023 15:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71A95C433A1;
        Fri,  2 Jun 2023 15:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685718025;
        bh=pa+sw7piReDEjInKXKqjGINHz86IV7DvHVj4nDWYvdg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bi1ioK3XvJ+q3Rle2fRqVnvW64r4HT8l9zsDWx2N6bHMb5QqsnpQCIOMcyY9Hw848
         Xqg2oqOYe6wkErfYpqyvP8jlZPPlmo0Wumcgle7dFw27lEz/gaQbCj2gaKCdGVzaFf
         uvJ0LWXz2QpSe9R+7XtwbPIRUxs5EI23BhpgxxrDiAAjqpaGhhGknFjehuO/54fMUE
         sd7S43jlfkmhLMf+L7AjrFZT70ek2YzNkN/kEZnOIsOyREwA0veeqVsD1k256/LjFB
         RUi29jySWu1mxRgDYpEgjof6CwLCXLIWY+mywg/AOpAjR1ItHueuzhqH8nbkHuvZFL
         65Hw2cciOpK4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 421D5C395E5;
        Fri,  2 Jun 2023 15:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V6 00/21] Add basic ACPI support for RISC-V
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168571802526.11683.10109882495660507850.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 15:00:25 +0000
References: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
In-Reply-To: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, qianweili@huawei.com, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, trix@redhat.com, rafael@kernel.org,
        maz@kernel.org, corbet@lwn.net, ndesaulniers@google.com,
        markgross@kernel.org, hdegoede@redhat.com, wangzhou1@hisilicon.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        herbert@gondor.apana.org.au, tglx@linutronix.de,
        luzmaximilian@gmail.com, davem@davemloft.net, nathan@kernel.org,
        lenb@kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 15 May 2023 11:19:07 +0530 you wrote:
> This patch series enables the basic ACPI infrastructure for RISC-V.
> Supporting external interrupt controllers is in progress and hence it is
> tested using poll based HVC SBI console and RAM disk.
> 
> The first patch in this series is one of the patch from Jisheng's
> series [1] which is not merged yet. This patch is required to support
> ACPI since efi_init() which gets called before sbi_init() can enable
> static branches and hits a panic.
> 
> [...]

Here is the summary with links:
  - [V6,01/21] riscv: move sbi_init() earlier before jump_label_init()
    https://git.kernel.org/riscv/c/24fc18087f42
  - [V6,02/21] platform/surface: Disable for RISC-V
    https://git.kernel.org/riscv/c/7f2e20459b28
  - [V6,03/21] crypto: hisilicon/qm: Fix to enable build with RISC-V clang
    https://git.kernel.org/riscv/c/fbb995a7b27c
  - [V6,04/21] ACPI: tables: Print RINTC information when MADT is parsed
    https://git.kernel.org/riscv/c/4d02d88d2b92
  - [V6,05/21] ACPI: OSL: Make should_use_kmap() 0 for RISC-V
    https://git.kernel.org/riscv/c/214c236223b8
  - [V6,06/21] RISC-V: Add support to build the ACPI core
    https://git.kernel.org/riscv/c/a91a9ffbd3a5
  - [V6,07/21] ACPI: processor_core: RISC-V: Enable mapping processor to the hartid
    https://git.kernel.org/riscv/c/8b7809e28952
  - [V6,08/21] RISC-V: Add ACPI initialization in setup_arch()
    https://git.kernel.org/riscv/c/724f4c0df766
  - [V6,09/21] RISC-V: ACPI: Cache and retrieve the RINTC structure
    https://git.kernel.org/riscv/c/f99561199470
  - [V6,10/21] drivers/acpi: RISC-V: Add RHCT related code
    https://git.kernel.org/riscv/c/e6b9d8eddb17
  - [V6,11/21] RISC-V: smpboot: Create wrapper setup_smp()
    https://git.kernel.org/riscv/c/61946127ab49
  - [V6,12/21] RISC-V: smpboot: Add ACPI support in setup_smp()
    https://git.kernel.org/riscv/c/ce92546cd637
  - [V6,13/21] RISC-V: only iterate over possible CPUs in ISA string parser
    https://git.kernel.org/riscv/c/914d6f44fc50
  - [V6,14/21] RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()
    https://git.kernel.org/riscv/c/396c018332a1
  - [V6,15/21] RISC-V: cpu: Enable cpuinfo for ACPI systems
    https://git.kernel.org/riscv/c/0b144c818989
  - [V6,16/21] irqchip/riscv-intc: Add ACPI support
    https://git.kernel.org/riscv/c/7023b9d83f03
  - [V6,17/21] clocksource/timer-riscv: Refactor riscv_timer_init_dt()
    https://git.kernel.org/riscv/c/cd12d206685a
  - [V6,18/21] clocksource/timer-riscv: Add ACPI support
    https://git.kernel.org/riscv/c/21f4f92410dc
  - [V6,19/21] RISC-V: time.c: Add ACPI support for time_init()
    https://git.kernel.org/riscv/c/714aa1d1c8ca
  - [V6,20/21] RISC-V: Enable ACPI in defconfig
    https://git.kernel.org/riscv/c/0b8e15ca0082
  - [V6,21/21] MAINTAINERS: Add entry for drivers/acpi/riscv
    https://git.kernel.org/riscv/c/cc9e654a7e81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


