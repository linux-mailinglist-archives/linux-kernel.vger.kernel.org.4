Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0C85FDD3F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJMPdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJMPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:33:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A5C89CD9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:33:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso5266417pjf.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=4gMLP1hwUGTM4BxNpbRI8RLHyi89DtVUppRL6o0w0mU=;
        b=rb1bWN6SuK2yLlpbOWA8ztz7sWOsOY8o8iMENK6UctoZIaBIgnwGYRH2pfTFWFxdbm
         llfNMQqKdhcPxXbKZGQUwAq+UxMV4H8LUwhqg0lZg8Qxi5QP6yL8hHT3M1XQf+PTes8f
         DuG+EkYMnR+H2+xcc/wmV3qz8NBXx2mkaTJsUsp9gKWrcQlnyUUN8ZS9/pHxN0vJDGQC
         U/T0qgDueFe47uc6WdjYmcys9iNdSw1qrMpyYiQIG3e5ukWnSPu4OjUEmkgMIZPmeW9e
         leXtM5KYZTraSHVdeW6f52raAjIX+G9kEZELJdjTmQ+pNvT9SxqyBu1sNMrs9XWr0V3X
         kkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gMLP1hwUGTM4BxNpbRI8RLHyi89DtVUppRL6o0w0mU=;
        b=q8z8kdc221iV9nvNvfwBcHEK9PUE4EBac5IYNZUqTuqy12iWanFE1tM44erS/Fp21h
         NZxkPR1RAZR2AX/aqkbfngQMxFJFhOb+WBwzwvUjFOJ09ceiIP5m7Wdl7h3OiwQ2V9dU
         XREqmtPq80LePhNCPclYS3yoJRBE2mDEN/MEqnV+deWjhbgzzHvWTW801u/D955p9WhB
         bwEX374J4dWnqffy67jSU0fUYDx+WiEAGTwk4izz9Xt3loERHiHxpAw9KKDkSmiwbOLs
         hSP2bf6G3RN1xi7gePtVXl3gTQkQrgjOIugciQiJ0ulUOZuqR8Ecys94wJS6QtqCddqM
         2PPg==
X-Gm-Message-State: ACrzQf3f5HH21IZTLPcHBigcIjE1zz3dT/FM2FHDkdklz/s0LTSa2+mI
        yJx8n7wyWS+isx/xA53Z08e1ZEZw9KQ3GA==
X-Google-Smtp-Source: AMsMyM4k0YPB8PRDeoQuJyebLxUBuZBk6rykJxPdmDA9hYsylcigcZCH4p2b/RrPthwCV3Z8T5uVmw==
X-Received: by 2002:a17:90b:3d8:b0:20a:8e90:8e8c with SMTP id go24-20020a17090b03d800b0020a8e908e8cmr401318pjb.138.1665675214663;
        Thu, 13 Oct 2022 08:33:34 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id oj5-20020a17090b4d8500b001f262f6f717sm3588408pjb.3.2022.10.13.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:33:34 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: Move from git://github.com to https://github.com
Date:   Thu, 13 Oct 2022 08:32:58 -0700
Message-Id: <20221013153258.28228-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Github deprecated the git:// links about a year ago, but it looks like
there's still a handful of them in the MAINTAINERS file.  Conor pointed
this out about the RISC-V KVM tree, but I figured it'd be better to just
fix them all -- I've got a bunch of insteadOf so I didn't even notice
the deprecation, but new contributors probably don't and might get a bit
confused.

Reported-by: Conor Dooley <conor@kernel.org>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 MAINTAINERS | 76 ++++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..748f9aaffdf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -233,7 +233,7 @@ S:	Maintained
 W:	http://swik.net/v9fs
 Q:	http://patchwork.kernel.org/project/v9fs-devel/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
-T:	git git://github.com/martinetd/linux.git
+T:	git https://github.com/martinetd/linux.git
 F:	Documentation/filesystems/9p.rst
 F:	fs/9p/
 F:	include/net/9p/
@@ -2045,7 +2045,7 @@ M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/ulli-kroll/linux.git
+T:	git https://github.com/ulli-kroll/linux.git
 F:	Documentation/devicetree/bindings/arm/gemini.yaml
 F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.yaml
 F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
@@ -2158,7 +2158,7 @@ M:	Wei Xu <xuwei5@hisilicon.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 W:	http://www.hisilicon.com
-T:	git git://github.com/hisilicon/linux-hisi.git
+T:	git https://github.com/hisilicon/linux-hisi.git
 F:	arch/arm/boot/dts/hi3*
 F:	arch/arm/boot/dts/hip*
 F:	arch/arm/boot/dts/hisi*
@@ -2281,7 +2281,7 @@ ARM/LPC32XX SOC SUPPORT
 M:	Vladimir Zapolskiy <vz@mleia.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/vzapolskiy/linux-lpc32xx.git
+T:	git https://github.com/vzapolskiy/linux-lpc32xx.git
 F:	Documentation/devicetree/bindings/i2c/i2c-pnx.txt
 F:	arch/arm/boot/dts/lpc32*
 F:	arch/arm/mach-lpc32xx/
@@ -2397,7 +2397,7 @@ M:	Steen Hegelund <Steen.Hegelund@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
-T:	git git://github.com/microchip-ung/linux-upstream.git
+T:	git https://github.com/microchip-ung/linux-upstream.git
 F:	arch/arm64/boot/dts/microchip/
 F:	drivers/pinctrl/pinctrl-microchip-sgpio.c
 N:	sparx5
@@ -2430,7 +2430,7 @@ M:	Romain Perier <romain.perier@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://linux-chenxing.org/
-T:	git git://github.com/linux-chenxing/linux.git
+T:	git https://github.com/linux-chenxing/linux.git
 F:	Documentation/devicetree/bindings/arm/mstar/*
 F:	Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
 F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
@@ -3301,7 +3301,7 @@ ATHEROS 71XX/9XXX GPIO DRIVER
 M:	Alban Bedel <albeu@free.fr>
 S:	Maintained
 W:	https://github.com/AlbanBedel/linux
-T:	git git://github.com/AlbanBedel/linux
+T:	git https://github.com/AlbanBedel/linux
 F:	Documentation/devicetree/bindings/gpio/gpio-ath79.txt
 F:	drivers/gpio/gpio-ath79.c
 
@@ -3309,7 +3309,7 @@ ATHEROS 71XX/9XXX USB PHY DRIVER
 M:	Alban Bedel <albeu@free.fr>
 S:	Maintained
 W:	https://github.com/AlbanBedel/linux
-T:	git git://github.com/AlbanBedel/linux
+T:	git https://github.com/AlbanBedel/linux
 F:	Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
 F:	drivers/phy/qualcomm/phy-ath79-usb.c
 
@@ -3372,7 +3372,7 @@ F:	drivers/net/ethernet/cadence/
 ATMEL MAXTOUCH DRIVER
 M:	Nick Dyer <nick@shmanahar.org>
 S:	Maintained
-T:	git git://github.com/ndyer/linux.git
+T:	git https://github.com/ndyer/linux.git
 F:	Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
 
@@ -3951,7 +3951,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/broadcom/stblinux.git
+T:	git https://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
 F:	arch/arm64/boot/dts/broadcom/bcmbca/*
 N:	bcmbca
@@ -3976,7 +3976,7 @@ R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/broadcom/stblinux.git
+T:	git https://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	drivers/pci/controller/pcie-brcmstb.c
 F:	drivers/staging/vc04_services
@@ -3990,7 +3990,7 @@ M:	Ray Jui <rjui@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 S:	Maintained
-T:	git git://github.com/broadcom/mach-bcm
+T:	git https://github.com/broadcom/mach-bcm
 F:	arch/arm/mach-bcm/
 N:	bcm281*
 N:	bcm113*
@@ -4055,7 +4055,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/broadcom/stblinux.git
+T:	git https://github.com/broadcom/stblinux.git
 F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	arch/arm/boot/dts/bcm7*.dts*
 F:	arch/arm/include/asm/hardware/cache-b15-rac.h
@@ -4087,7 +4087,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-T:	git git://github.com/broadcom/stblinux.git
+T:	git https://github.com/broadcom/stblinux.git
 F:	arch/mips/bmips/*
 F:	arch/mips/boot/dts/brcm/bcm*.dts*
 F:	arch/mips/include/asm/mach-bmips/*
@@ -4226,7 +4226,7 @@ M:	Scott Branden <sbranden@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/broadcom/stblinux.git
+T:	git https://github.com/broadcom/stblinux.git
 F:	arch/arm64/boot/dts/broadcom/northstar2/*
 F:	arch/arm64/boot/dts/broadcom/stingray/*
 F:	drivers/clk/bcm/clk-ns*
@@ -4296,7 +4296,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-T:	git git://github.com/broadcom/stblinux.git
+T:	git https://github.com/broadcom/stblinux.git
 F:	drivers/soc/bcm/bcm63xx/bcm-pmb.c
 F:	include/dt-bindings/soc/bcm-pmb.h
 
@@ -4771,7 +4771,7 @@ R:	Jeff Layton <jlayton@kernel.org>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
-T:	git git://github.com/ceph/ceph-client.git
+T:	git https://github.com/ceph/ceph-client.git
 F:	include/linux/ceph/
 F:	include/linux/crush/
 F:	net/ceph/
@@ -4783,7 +4783,7 @@ R:	Jeff Layton <jlayton@kernel.org>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
-T:	git git://github.com/ceph/ceph-client.git
+T:	git https://github.com/ceph/ceph-client.git
 F:	Documentation/filesystems/ceph.rst
 F:	fs/ceph/
 
@@ -6865,7 +6865,7 @@ DRM DRIVERS FOR GMA500 (Poulsbo, Moorestown and derivative chipsets)
 M:	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
-T:	git git://github.com/patjak/drm-gma500
+T:	git https://github.com/patjak/drm-gma500
 F:	drivers/gpu/drm/gma500/
 
 DRM DRIVERS FOR HISILICON
@@ -7003,7 +7003,7 @@ DRM DRIVERS FOR VC4
 M:	Emma Anholt <emma@anholt.net>
 M:	Maxime Ripard <mripard@kernel.org>
 S:	Supported
-T:	git git://github.com/anholt/linux
+T:	git https://github.com/anholt/linux
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/brcm,bcm2835-*.yaml
 F:	drivers/gpu/drm/vc4/
@@ -10867,7 +10867,7 @@ M:	Dave Kleikamp <shaggy@kernel.org>
 L:	jfs-discussion@lists.sourceforge.net
 S:	Maintained
 W:	http://jfs.sourceforge.net/
-T:	git git://github.com/kleikamp/linux-shaggy.git
+T:	git https://github.com/kleikamp/linux-shaggy.git
 F:	Documentation/admin-guide/jfs.rst
 F:	fs/jfs/
 
@@ -11156,7 +11156,7 @@ L:	kvm@vger.kernel.org
 L:	kvm-riscv@lists.infradead.org
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
-T:	git git://github.com/kvm-riscv/linux.git
+T:	git https://github.com/kvm-riscv/linux.git
 F:	arch/riscv/include/asm/kvm*
 F:	arch/riscv/include/uapi/asm/kvm*
 F:	arch/riscv/kvm/
@@ -11972,7 +11972,7 @@ M:	Alexey Kodanev <alexey.kodanev@oracle.com>
 L:	ltp@lists.linux.it (subscribers-only)
 S:	Maintained
 W:	http://linux-test-project.github.io/
-T:	git git://github.com/linux-test-project/ltp.git
+T:	git https://github.com/linux-test-project/ltp.git
 
 LYNX 28G SERDES PHY DRIVER
 M:	Ioana Ciornei <ioana.ciornei@nxp.com>
@@ -14363,7 +14363,7 @@ L:	linux-nilfs@vger.kernel.org
 S:	Supported
 W:	https://nilfs.sourceforge.io/
 W:	https://nilfs.osdn.jp/
-T:	git git://github.com/konis/nilfs2.git
+T:	git https://github.com/konis/nilfs2.git
 F:	Documentation/filesystems/nilfs2.rst
 F:	fs/nilfs2/
 F:	include/trace/events/nilfs2.h
@@ -14465,7 +14465,7 @@ M:	Allen Hubbe <allenbh@gmail.com>
 L:	ntb@lists.linux.dev
 S:	Supported
 W:	https://github.com/jonmason/ntb/wiki
-T:	git git://github.com/jonmason/ntb.git
+T:	git https://github.com/jonmason/ntb.git
 F:	drivers/net/ntb_netdev.c
 F:	drivers/ntb/
 F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
@@ -15234,7 +15234,7 @@ M:	Stafford Horne <shorne@gmail.com>
 L:	openrisc@lists.librecores.org
 S:	Maintained
 W:	http://openrisc.io
-T:	git git://github.com/openrisc/linux.git
+T:	git https://github.com/openrisc/linux.git
 F:	Documentation/devicetree/bindings/openrisc/
 F:	Documentation/openrisc/
 F:	arch/openrisc/
@@ -16211,7 +16211,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 W:	https://01.org/pm-graph
 B:	https://bugzilla.kernel.org/buglist.cgi?component=pm-graph&product=Tools
-T:	git git://github.com/intel/pm-graph
+T:	git https://github.com/intel/pm-graph
 F:	tools/power/pm-graph
 
 PMBUS HARDWARE MONITORING DRIVERS
@@ -16585,8 +16585,8 @@ M:	Haojian Zhuang <haojian.zhuang@gmail.com>
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/hzhuang1/linux.git
-T:	git git://github.com/rjarzmik/linux.git
+T:	git https://github.com/hzhuang1/linux.git
+T:	git https://github.com/rjarzmik/linux.git
 F:	arch/arm/boot/dts/pxa*
 F:	arch/arm/mach-pxa/
 F:	drivers/dma/pxa*
@@ -17028,7 +17028,7 @@ R:	Dongsheng Yang <dongsheng.yang@easystack.cn>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
-T:	git git://github.com/ceph/ceph-client.git
+T:	git https://github.com/ceph/ceph-client.git
 F:	Documentation/ABI/testing/sysfs-bus-rbd
 F:	drivers/block/rbd.c
 F:	drivers/block/rbd_types.h
@@ -18548,7 +18548,7 @@ M:	Palmer Dabbelt <palmer@dabbelt.com>
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
-T:	git git://github.com/sifive/riscv-linux.git
+T:	git https://github.com/sifive/riscv-linux.git
 N:	sifive
 K:	[^@]sifive
 
@@ -18723,7 +18723,7 @@ M:	Casey Schaufler <casey@schaufler-ca.com>
 L:	linux-security-module@vger.kernel.org
 S:	Maintained
 W:	http://schaufler-ca.com
-T:	git git://github.com/cschaufler/smack-next
+T:	git https://github.com/cschaufler/smack-next
 F:	Documentation/admin-guide/LSM/Smack.rst
 F:	security/smack/
 
@@ -20069,7 +20069,7 @@ M:	Chris Zankel <chris@zankel.net>
 M:	Max Filippov <jcmvbkbc@gmail.com>
 L:	linux-xtensa@linux-xtensa.org
 S:	Maintained
-T:	git git://github.com/czankel/xtensa-linux.git
+T:	git https://github.com/czankel/xtensa-linux.git
 F:	arch/xtensa/
 F:	drivers/irqchip/irq-xtensa-*
 
@@ -20639,7 +20639,7 @@ M:	Hu Haowen <src.res@email.cn>
 L:	linux-doc-tw-discuss@lists.sourceforge.net (moderated for non-subscribers)
 S:	Maintained
 W:	https://github.com/srcres258/linux-doc
-T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
+T:	git https://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
 TTY LAYER
@@ -21047,7 +21047,7 @@ L:	linux-usb@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	https://github.com/petkan/pegasus
-T:	git git://github.com/petkan/pegasus.git
+T:	git https://github.com/petkan/pegasus.git
 F:	drivers/net/usb/pegasus.*
 
 USB PHY LAYER
@@ -21084,7 +21084,7 @@ L:	linux-usb@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	https://github.com/petkan/rtl8150
-T:	git git://github.com/petkan/rtl8150.git
+T:	git https://github.com/petkan/rtl8150.git
 F:	drivers/net/usb/rtl8150.c
 
 USB SERIAL SUBSYSTEM
@@ -21305,7 +21305,7 @@ M:	Alex Williamson <alex.williamson@redhat.com>
 R:	Cornelia Huck <cohuck@redhat.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
-T:	git git://github.com/awilliam/linux-vfio.git
+T:	git https://github.com/awilliam/linux-vfio.git
 F:	Documentation/driver-api/vfio.rst
 F:	drivers/vfio/
 F:	include/linux/vfio.h
@@ -22528,7 +22528,7 @@ ZSTD
 M:	Nick Terrell <terrelln@fb.com>
 S:	Maintained
 B:	https://github.com/facebook/zstd/issues
-T:	git git://github.com/terrelln/linux.git
+T:	git https://github.com/terrelln/linux.git
 F:	include/linux/zstd*
 F:	lib/zstd/
 F:	lib/decompress_unzstd.c
-- 
2.38.0

