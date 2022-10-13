Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCE5FE481
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJMVus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJMVtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:45 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484EE36BC7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p14so3147052pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=wseFX2xvL4KPdBggbIiWm5eR1PGhf7fGAiufwZVrGPE=;
        b=RPyk93n1QGBYXEGXygI8Neiz6lgfKwRWo/7wovUbwlQCd1TkF/8VkgeWZJyx+TJTdl
         xefVCLZ7UTo3HrWvDJte4uSIyhOuQ2tSQ84C150LDbnRMfTT65AsEsY0IGHdVQA53q6P
         ayQtRdx4yIIpCK23CBiMqjdCNx4mVd33NtXuipfuF+bzIjP011xQnoN+NWqzYFM9i25E
         vElfjcIaPvygYL8NzLiSWBWZSWVbn/Y1NIk6uqwXn251ZVJEnv3YbkSWCFXCxRNE3z+Y
         C6mGilpNFn2b8pKmZvTRdmbSeIwwBaRddm3xE8HdACJWecDYo+c6nZ/PqN4LqFwJ8RFR
         D9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wseFX2xvL4KPdBggbIiWm5eR1PGhf7fGAiufwZVrGPE=;
        b=E2DOCSuA3ESha7KwduaNbUuRjyEp4tcfDHRBY2k4B1onxH9fkqBwTNBTL6pO1TC6gJ
         4WdaaU1FuD6a4pTgZwO0rLhlb5Q9PaD3t/uc7hbo5un1EoWmx8KS3fDR424pP72AejJf
         /tRGg9vuXfbc+eALfvGtcd8iLMDc93CQBQe50ivXlbei2seB6Ip/zECRVNyWcJcQ6GcG
         tt2xC4Njyp14O0HAS8eQO3sgFl+9zx0WGyXoalAYisa+ngAuF07ylNUgnJwXcH4mNuXD
         BKRVK1XYRQyJNEZso8fP69dywMi0bTg9PgVNeJ+sYdKBbqErmrTApa6F6XXtM46JjBNU
         3w/w==
X-Gm-Message-State: ACrzQf3DGW2wmKaNfVJ5gidh6GIQnd8qSbnaAatDlyTWUdqh/RZOATbA
        v+zfbb3YQ3kWyzLzsTp81XDvNpsjm45pCu1i
X-Google-Smtp-Source: AMsMyM4A4krgh5X46YbQvqj8mqnOZtPA0dIlLQHVzb0amy0HHCnSiVo3EuU5B4uhdmecVJNJyThmRA==
X-Received: by 2002:a63:4750:0:b0:43c:dac:9e4b with SMTP id w16-20020a634750000000b0043c0dac9e4bmr1726794pgk.300.1665697759268;
        Thu, 13 Oct 2022 14:49:19 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id iz12-20020a170902ef8c00b0018003571809sm290313plb.224.2022.10.13.14.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:18 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for broadcom
Date:   Thu, 13 Oct 2022 14:46:39 -0700
Message-Id: <20221013214639.31074-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     william.zhang@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, f.fainelli@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        rjui@broadcom.com, sbranden@broadcom.com, rafal@milecki.pl,
        linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f552f839dd32..3699b2256dc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
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
 
-- 
2.38.0

