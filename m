Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B4A6D6B70
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbjDDSUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjDDSUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:20:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A944B5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:20:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d22so20215895pgw.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680632448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a8QsXaZPHEAsPoW0flCc0TOSQrLjDGzZjDEO/EvIfsw=;
        b=mpiCxWKuWoSzlX40nQKfKAaOH87Uuf9nu3eXg7EdGg557PNonvadIn6JVXiN/uM9Wy
         phW/msttEsKDnZh1vVFo1bN9XZtZKEUa4wk/18xxEDCarICge5UwlYnQAxJzm03rXFSI
         DJBprbDLPojSOI3lW4sui5GKgMuD72aL4oaagoTPk8faAqerVaiDZ6mu538E2hh9oqF7
         0oK8ht9mRNdYe4sIkdaSTzl6G8Fs9E31epNQi3UPNlN8wJObdPa2hsumipAUSGbg3eKo
         jvrjjdXwkTaMmkoq5VnpbS/FL/eFSGqJVfftsC93axZyll8/J5G4pPsWk+JEQJidr9Ym
         fv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8QsXaZPHEAsPoW0flCc0TOSQrLjDGzZjDEO/EvIfsw=;
        b=GhjwlfFQ+ss8m7u9rfDus//h4VsdwAUh2LdXI8PEBISfZd7FwquOdLfN2gYenq3PVy
         GvOFgRZDZlceONcldY/Cgy+Pl/CioCkOOinwhrhghqvtDAWeWQpD71QHsLaq0rdQYzHI
         /99f021xbUf4DLMDurKcbiocfEJLmZhQmYajU0Ss6dasmPUBI3qc33xTBpSgJSJ2M9Q7
         LGF/AlcdlqOwzwdF3PASX43VmNkl52DOfRDMMHxkguQI1lc8OVs0N3tPXJ/LG4zc15/J
         j+iPIqmfszpN1tpID1zCfxF2FHimoXgTDd0cfQeTL4vExvQPwISv1nB2gcKukSd7Ja5t
         xZJg==
X-Gm-Message-State: AAQBX9dliJkHzP9CY4Xcd+v9PkRWX28XfayHW0XdHJ9c0ekP3EStJD29
        dGZPAf6G2p/XJV1gNoiNL8l/Vg==
X-Google-Smtp-Source: AKy350ZueCB8uPytSB434Qm4r5EaO+Vwyt0FglDeSJ0S0BeLW50LyieSkwwAgxgd1F0EJCZ+ZvbMfw==
X-Received: by 2002:a62:1d41:0:b0:62a:4503:53b8 with SMTP id d62-20020a621d41000000b0062a450353b8mr3341665pfd.1.1680632447664;
        Tue, 04 Apr 2023 11:20:47 -0700 (PDT)
Received: from localhost.localdomain ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062dcf5c01f9sm9018524pfw.36.2023.04.04.11.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:20:47 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH V4 00/23] Add basic ACPI support for RISC-V
Date:   Tue,  4 Apr 2023 23:50:14 +0530
Message-Id: <20230404182037.863533-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables the basic ACPI infrastructure for RISC-V.
Supporting external interrupt controllers is in progress and hence it is
tested using poll based HVC SBI console and RAM disk.

The first patch in this series is one of the patch from Jisheng's
series [1] which is not merged yet. This patch is required to support
ACPI since efi_init() which gets called before sbi_init() can enable
static branches and hits a panic.

Patch 2 and 3 are ACPICA patches which are merged now into acpica
but not yet pulled into the linux sources. They exist in this patch set
as reference. This series can be merged only after those ACPICA patches
are pulled into linux.

Below are two ECRs approved by ASWG.
RINTC - https://drive.google.com/file/d/1R6k4MshhN3WTT-hwqAquu5nX6xSEqK2l/view
RHCT - https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6123DCZKR-tia/view


Based-on: 20230328035223.1480939-1-apatel@ventanamicro.com
(https://lore.kernel.org/lkml/20230328035223.1480939-1-apatel@ventanamicro.com/)

[1] https://lore.kernel.org/all/20220821140918.3613-1-jszhang@kernel.org/

Changes since V3:
	1) Added two more driver patches to workaround allmodconfig build failure.
	2) Separated removal of riscv_of_processor_hartid() to a different patch.
	3) Addressed Conor's feedback.
	4) Rebased to v6.3-rc5 and added latest tags

Changes since V2:
	1) Dropped ACPI_PROCESSOR patch.
	2) Added new patch to print debug info of RISC-V INTC in MADT
	3) Addressed other comments from Drew.
	4) Rebased and updated tags

Changes since V1:
	1) Dropped PCI changes and instead added dummy interfaces just to enable
	   building ACPI core when CONFIG_PCI is enabled. Actual PCI changes will
	   be added in future along with external interrupt controller support
	   in ACPI.
	2) Squashed couple of patches so that new code added gets built in each
	   commit.
	3) Fixed the missing wake_cpu code in timer refactor patch as pointed by
	   Conor
	4) Fixed an issue with SMP disabled.
	5) Addressed other comments from Conor.
	6) Updated documentation patch as per feedback from Sanjaya.
	7) Fixed W=1 and checkpatch --strict issues.
	8) Added ACK/RB tags

These changes are available at
https://github.com/vlsunil/linux/commits/acpi_b1_us_review_ipi17_V4

Testing:
1) Build latest Qemu 

2) Build EDK2 as per instructions in
https://github.com/vlsunil/riscv-uefi-edk2-docs/wiki/RISC-V-Qemu-Virt-support

3) Build Linux after enabling SBI HVC and SBI earlycon
CONFIG_RISCV_SBI_V01=y
CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
CONFIG_HVC_RISCV_SBI=y

4) Build buildroot.

Run with below command.
qemu-system-riscv64   -nographic \
-drive file=Build/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=pflash,format=raw,unit=1 \
-machine virt -smp 16 -m 2G \
-kernel arch/riscv/boot/Image \
-initrd buildroot/output/images/rootfs.cpio \
-append "root=/dev/ram ro console=hvc0 earlycon=sbi"


Jisheng Zhang (1):
  riscv: move sbi_init() earlier before jump_label_init()

Sunil V L (22):
  ACPICA: MADT: Add RISC-V INTC interrupt controller
  ACPICA: Add structure definitions for RISC-V RHCT
  ACPI: tables: Print RINTC information when MADT is parsed
  ACPI: OSL: Make should_use_kmap() 0 for RISC-V
  RISC-V: Add support to build the ACPI core
  ACPI: processor_core: RISC-V: Enable mapping processor to the hartid
  RISC-V: ACPI: Cache and retrieve the RINTC structure
  drivers/acpi: RISC-V: Add RHCT related code
  RISC-V: smpboot: Create wrapper smp_setup()
  RISC-V: smpboot: Add ACPI support in smp_setup()
  RISC-V: cpufeature: Avoid calling riscv_of_processor_hartid()
  RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()
  RISC-V: cpu: Enable cpuinfo for ACPI systems
  irqchip/riscv-intc: Add ACPI support
  clocksource/timer-riscv: Refactor riscv_timer_init_dt()
  clocksource/timer-riscv: Add ACPI support
  RISC-V: time.c: Add ACPI support for time_init()
  RISC-V: Add ACPI initialization in setup_arch()
  RISC-V: Enable ACPI in defconfig
  MAINTAINERS: Add entry for drivers/acpi/riscv
  platform/surface: Disable for RISC-V
  crypto: hisilicon/qm: Workaround to enable build with RISC-V clang

 .../admin-guide/kernel-parameters.txt         |   8 +-
 MAINTAINERS                                   |   8 +
 arch/riscv/Kconfig                            |   5 +
 arch/riscv/configs/defconfig                  |   1 +
 arch/riscv/include/asm/acenv.h                |  11 +
 arch/riscv/include/asm/acpi.h                 |  77 +++++
 arch/riscv/include/asm/cpu.h                  |   8 +
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/acpi.c                      | 266 ++++++++++++++++++
 arch/riscv/kernel/cpu.c                       |  30 +-
 arch/riscv/kernel/cpufeature.c                |  44 ++-
 arch/riscv/kernel/setup.c                     |  27 +-
 arch/riscv/kernel/smpboot.c                   |  77 ++++-
 arch/riscv/kernel/time.c                      |  25 +-
 drivers/acpi/Makefile                         |   2 +
 drivers/acpi/osl.c                            |   2 +-
 drivers/acpi/processor_core.c                 |  29 ++
 drivers/acpi/riscv/Makefile                   |   2 +
 drivers/acpi/riscv/rhct.c                     |  83 ++++++
 drivers/acpi/tables.c                         |  10 +
 drivers/clocksource/timer-riscv.c             |  92 +++---
 drivers/crypto/hisilicon/qm.c                 |  13 +-
 drivers/irqchip/irq-riscv-intc.c              |  74 ++++-
 drivers/platform/surface/aggregator/Kconfig   |   2 +-
 include/acpi/actbl2.h                         |  69 ++++-
 25 files changed, 867 insertions(+), 100 deletions(-)
 create mode 100644 arch/riscv/include/asm/acenv.h
 create mode 100644 arch/riscv/include/asm/acpi.h
 create mode 100644 arch/riscv/include/asm/cpu.h
 create mode 100644 arch/riscv/kernel/acpi.c
 create mode 100644 drivers/acpi/riscv/Makefile
 create mode 100644 drivers/acpi/riscv/rhct.c

-- 
2.34.1

