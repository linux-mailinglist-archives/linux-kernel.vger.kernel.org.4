Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98146D3E47
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjDCHmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjDCHm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:42:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F95C143
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:42:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i9so28266862wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680507746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsljtCJiazE5NkGm88Tojg7L6Z8lihqck8h8eoHTGEg=;
        b=ERYeu1hbMOABzJJIf6abhps9hFWp8DcXj2oDxzp/+9rTEOPxfhbQIkNedDGIqLvYVV
         X9EhMi9RWzcaYrOj38qxaTk2u2uhRdfiIT1V6NKXbvRc6UPvDQEsRqkazeNpb2Hs6UYX
         Gk5vYKoCUPqzs8DHgM4nV0HhtQ2FkIoIG2qQfEVNPmA8llVQPymDbMMFHPFhZGmf8enp
         wRNDpAy7bBi1jjtKp5ZGlGkBpN+T0tv0qZPuCKxXSt4MhiYYGNtOTBqfqtcBB4C5iJYG
         jSetrrI681iFXZiJhAwXAmR3wo2jD7HqpJ32bALf0z0k3OsW90iNMkBXqrKROktYBaMw
         PGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680507746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsljtCJiazE5NkGm88Tojg7L6Z8lihqck8h8eoHTGEg=;
        b=qnS8LOjSTaJj9j4HGa/r15JuxAYBpRM4vqzYS3aHN04PbZysVG7XZgo57V+D4BT59q
         0aWAdvz0ggMZeRO0Ykr20KGEJSm7MBP4KxDxqklTr/UApkynM22+2MLNtEioSJfoR3wj
         yaflE0ezNNr/j5/tTNyqAdvZQQmh/mK/0dTU9DCLI5GGE1u1antvF/yGJ5zl2aiwobWS
         iMRnq+ttQinJH3/8fCj4gU+5zqhxJ1vXE3BHMOMv2cuUgfjakd0OaJycV9mBIYsEPDR0
         CTLx/m8D57ultERx1TDrQ+YhENR4byEvLDkGgBZw09DrqIh/hEUiZTXujAVeWcDUzZyZ
         U4NQ==
X-Gm-Message-State: AAQBX9dApn/5a9YHTp44FZQtGWAxauBuhpD4zbxPab7ItmbmfDd+MhV8
        h+/QnxFd9ySuVUEFPt/OG0Hqrg==
X-Google-Smtp-Source: AKy350Z6e6J7uSkW2Hv2dRYhOElAG4NTAcR0nwGJ0pugXPyWTFpVuEPcRywE7wwpOPRnYtIXtriOjA==
X-Received: by 2002:a5d:55c7:0:b0:2d2:ab47:3ef4 with SMTP id i7-20020a5d55c7000000b002d2ab473ef4mr28234897wrw.70.1680507746014;
        Mon, 03 Apr 2023 00:42:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q14-20020adff94e000000b002e62384d17dsm8180482wrr.21.2023.04.03.00.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 00:42:25 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 03 Apr 2023 09:42:20 +0200
Subject: [PATCH RFC v2 3/4] ARM: configs: remove oxnas_v6_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230331-topic-oxnas-upstream-remove-v2-3-e51078376f08@linaro.org>
References: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-oxnas@groups.io,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Golle <daniel@makrotopia.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of maintainance and stall of development for a few years now,
and since no new features will ever be added upstream, remove support
for OX820 specific defconfig.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/configs/oxnas_v6_defconfig | 92 -------------------------------------
 1 file changed, 92 deletions(-)

diff --git a/arch/arm/configs/oxnas_v6_defconfig b/arch/arm/configs/oxnas_v6_defconfig
deleted file mode 100644
index 70a67b3fc91b..000000000000
--- a/arch/arm/configs/oxnas_v6_defconfig
+++ /dev/null
@@ -1,92 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_NO_HZ_IDLE=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_EMBEDDED=y
-CONFIG_PERF_EVENTS=y
-CONFIG_STRICT_KERNEL_RWX=y
-CONFIG_STRICT_MODULE_RWX=y
-CONFIG_ARCH_MULTI_V6=y
-CONFIG_ARCH_OXNAS=y
-CONFIG_MACH_OX820=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=16
-CONFIG_ARCH_FORCE_MAX_ORDER=12
-CONFIG_SECCOMP=y
-CONFIG_ARM_APPENDED_DTB=y
-CONFIG_ARM_ATAG_DTB_COMPAT=y
-CONFIG_KEXEC=y
-CONFIG_EFI=y
-CONFIG_CPU_IDLE=y
-CONFIG_ARM_CPUIDLE=y
-CONFIG_VFP=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_CMDLINE_PARTITION=y
-CONFIG_CMA=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-CONFIG_IPV6_ROUTER_PREF=y
-CONFIG_IPV6_OPTIMISTIC_DAD=y
-CONFIG_INET6_AH=m
-CONFIG_INET6_ESP=m
-CONFIG_INET6_IPCOMP=m
-CONFIG_IPV6_MIP6=m
-CONFIG_IPV6_TUNNEL=m
-CONFIG_IPV6_MULTIPLE_TABLES=y
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_MTD_NAND_OXNAS=y
-CONFIG_MTD_UBI=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=65536
-CONFIG_NETDEVICES=y
-CONFIG_STMMAC_ETH=y
-CONFIG_REALTEK_PHY=y
-CONFIG_INPUT_EVDEV=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_GPIO_GENERIC_PLATFORM=y
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_CLASS_FLASH=m
-CONFIG_LEDS_GPIO=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_ONESHOT=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-CONFIG_LEDS_TRIGGER_CPU=y
-CONFIG_LEDS_TRIGGER_GPIO=y
-CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
-CONFIG_ARM_TIMER_SP804=y
-CONFIG_EXT4_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_UBIFS_FS=y
-CONFIG_PSTORE=y
-CONFIG_PSTORE_CONSOLE=y
-CONFIG_PSTORE_PMSG=y
-CONFIG_PSTORE_RAM=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_UTF8=y
-CONFIG_DMA_CMA=y
-CONFIG_CMA_SIZE_MBYTES=64
-CONFIG_PRINTK_TIME=y
-CONFIG_MAGIC_SYSRQ=y

-- 
2.34.1

