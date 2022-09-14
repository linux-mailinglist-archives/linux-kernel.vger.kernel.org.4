Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A2E5B8A76
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiINO1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiINO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:27:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7352E0DA;
        Wed, 14 Sep 2022 07:27:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dv25so35084368ejb.12;
        Wed, 14 Sep 2022 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aaOGHVVPf/iuUx0WzEqdb+jMiCVuFndRMtaL2hzurm0=;
        b=N+lXa7ZUVBz8xeKcv4IqaaZqudT/6AVP1hx9d1VIUlwoxQejUD/Jpqsev04Ln6Pay9
         YBZp3CL2W5t2ak09nrCmfelPs7spnxdPN8AZVbTM3panIdS8LRF1XKK8Xol/i8pyRxQz
         cc3bDr8gTn/ykIN76Nz4I/Pwnkpbi2ikR+R/WtzXozcJPAgjYgyIMgp3/GXX/Q/rI9P6
         pxpFSRrAwYgjsfUlcN7UrttqTGKKRM/Stp0u0wmtZEy+kEMRuTpwkoSXh3f5DRwClU40
         1RqXszQx2EkOeFBhleFCHxbgbOJ5IBRXs1q13kX6SxsswotsI1ClChTm6vZeYCivwV5k
         WiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aaOGHVVPf/iuUx0WzEqdb+jMiCVuFndRMtaL2hzurm0=;
        b=hVcvvXmyxsT6mBikuYkJUQ3kpyYr+mygpZg81gEVtoHDI2PP8UxkOt+TPO9TiDC8Mi
         0DnkZamXMZ5FaGiaW3AmoyboznykMiPxqkcD61LAzpu111u8ybb2co6TZTJXJfEAWgNM
         uX0tmMTtvA5TJ+RF9h2UMImXpzU0MTggh08iz3ENkOjL9jopYA6eW4d+UmRTI2uCEIvw
         nxiCz3y2k/0rAmOWacjR162hc7CeWadvFwi5q/5Ecji+nb69HuHU43KVDfG75bymqdCg
         sD1QDQZhRJMOZNRw23SyfrGGINBNTqjRRu+YF9mzUPzedn/jpbOL63AdTpW4jcXgEUoS
         aDlw==
X-Gm-Message-State: ACgBeo07iZJlA4LJrKo2aO2c1O4bumwncgAn9/Ct32qbvyHbYGPV0fPp
        81MIPWhJkNjt5ys+TaMVM6eq81qpib8=
X-Google-Smtp-Source: AA6agR4ivdgUPU+lsEK0xIVg75fo6CWuotho5p7bM6OZkVDoz/Rl6Lx8EK5hUgcl9bAkRGBRv8V9MA==
X-Received: by 2002:a17:907:74a:b0:77e:9455:b4e3 with SMTP id xc10-20020a170907074a00b0077e9455b4e3mr9492063ejb.471.1663165659025;
        Wed, 14 Sep 2022 07:27:39 -0700 (PDT)
Received: from felia.fritz.box (200116b826cf470059b9799edefde240.dip.versatel-1u1.de. [2001:16b8:26cf:4700:59b9:799e:defd:e240])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906329200b007708635be05sm7661502ejw.4.2022.09.14.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:27:38 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] ata: clean up how architectures enable PATA_PLATFORM and PATA_OF_PLATFORM
Date:   Wed, 14 Sep 2022 16:27:12 +0200
Message-Id: <20220914142713.29351-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two options for platform device PATA support:

  PATA_PLATFORM: Generic platform device PATA support
  PATA_OF_PLATFORM: OpenFirmware platform device PATA support

If an architecture allows the generic platform device PATA support, it
shall select HAVE_PATA_PLATFORM. Then, Generic platform device PATA support
is available and can be selected.

If an architecture has OpenFirmware support, which it indicates by
selecting OF, OpenFirmware platform device PATA support is available
and can be selected.
If OpenFirmware platform device PATA support is selected, then the
functionality (code files) from Generic platform device PATA support needs
to be integrated in the kernel build for the OpenFirmware platform device
PATA support to work. Select PATA_PLATFORM in PATA_OF_PLATFORM to make sure
the needed files are added in the build.

So, architectures with OpenFirmware support, do not need to additionally
select HAVE_PATA_PLATFORM. It is only needed by architecture that want the
non-OF pata-platform module.

Reflect this way of intended use of config symbols in the ata Kconfig and
adjust all architecture definitions.

This follows the suggestion from Arnd Bergmann (see Link).

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/all/4b33bffc-2b6d-46b4-9f1d-d18e55975a5a@www.fastmail.com/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-versatile/Kconfig | 1 -
 arch/arm64/Kconfig              | 1 -
 drivers/ata/Kconfig             | 6 +++---
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index 2ef226194c3a..b1519b4dc03a 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -256,7 +256,6 @@ menuconfig ARCH_VEXPRESS
 	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select HAVE_PATA_PLATFORM
 	select CLK_ICST
 	select NO_IOPORT_MAP
 	select PLAT_VERSATILE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 51f3f07c3efd..036bd67e662e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -194,7 +194,6 @@ config ARM64
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KVM
 	select HAVE_NMI
-	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1c9f4fb2595d..c93d97455744 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1102,8 +1102,7 @@ config PATA_PCMCIA
 	  If unsure, say N.
 
 config PATA_PLATFORM
-	tristate "Generic platform device PATA support"
-	depends on EXPERT || PPC || HAVE_PATA_PLATFORM
+	tristate "Generic platform device PATA support" if EXPERT || HAVE_PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.
@@ -1112,7 +1111,8 @@ config PATA_PLATFORM
 
 config PATA_OF_PLATFORM
 	tristate "OpenFirmware platform device PATA support"
-	depends on PATA_PLATFORM && OF
+	depends on OF
+	select PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems with OpenFirmware
-- 
2.17.1

