Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3389268F0D2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjBHO3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjBHO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:29:05 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDE87692
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:29:00 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id d7so6417990qvz.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 06:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WE/gPMaBx/EpR5LKoE9r3aKinik7P+lmgz6oMIYx50w=;
        b=EOFxZlwAB1StI8zpJndrYVj7J0psxYy6yegyPIg3C2TulkuZGJm3VP14lay3pEE112
         V2Y8foL64OZMz3sW5kbvVrAXGZvu3op1WNS70VYOSURfuMNcSGNtCmjFX9rwcDk+mAsJ
         x49xaDCjBfZgcsTKG4P5z/xzm7p5cNhTyfscbCXaL/gPhEaHn90Q3Vjd0yJMbGZqWTzU
         SG/4xcDh8WVYfxBJutnljGxbV22nBKwhc0lX9cUOSakhTtljgbjP6sezHfJbHG+YHezo
         TkCAsZQZPHSI9hFpJIWipUA+SwyYLpVT+FBSFubUTfMCBahGNiFxMowfyuv60sGVL7QV
         ji9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WE/gPMaBx/EpR5LKoE9r3aKinik7P+lmgz6oMIYx50w=;
        b=shz7Fr1yb9JJMch0ahxdnsTPfLtowu7aHs1pnGSYNyP/UsKJZAHcgeUb8wt7lNRwtW
         kkxufo/Zf7e6R5+NcAlh8RIQYhC3Uq1YGPBaODL1jDK05n42hR83LmmxA4WED9cZvyMI
         f97aWqVqZ1UsUQxVTCzeP2YxE+2MWLama81vCGyq7FQMEnrpZYrDJ62W1+S+aYyfh3/I
         q3X/rFmQVHl8OI77O7XvzKD+vjy1LGvqlgmu46bukrMbL0GufMvAIGbuUaWcZOFJRZ1a
         218NZIRgRidoiogQBIk3SJqVH+cQ8BupRqV+DjLTCI2arhhlrTUzzpmaNkVf4CDEcoJz
         bJXw==
X-Gm-Message-State: AO0yUKUKZZCRcOdqmXd09yDjPpAmaSkI54zGNgHJf7YAtj0TkQC5BwQJ
        rQvgVBHWvNC91FUdYXv4z2mfBAjQ+b4=
X-Google-Smtp-Source: AK7set9kjct65w5o2q9gAXAEsn6yKOcJGveWGLTdVDRJXy4Qo289gjhNhlft6R4OLwmPx1rF0VjF2g==
X-Received: by 2002:ad4:5ba7:0:b0:568:9110:d359 with SMTP id 7-20020ad45ba7000000b005689110d359mr10123799qvq.1.1675866539320;
        Wed, 08 Feb 2023 06:28:59 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id dw27-20020a05620a601b00b00706c1f7a608sm11762098qkb.89.2023.02.08.06.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 06:28:58 -0800 (PST)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org
Subject: [PATCH] MAINTAINERS: update Allwinner sunXi SoC support entry
Date:   Wed,  8 Feb 2023 09:28:41 -0500
Message-Id: <20230208142841.19597-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.17.g4027e30c53
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the information in the "Allwinner sunXi SoC support" block:
- include more RISC-V information
- move the block to keep it in alphabetical order
- "L" before "T" (as reported by checkpatch.pl)

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 MAINTAINERS | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b8ad844bca77..ff39d34cb4ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1856,23 +1856,6 @@ M:	Emilio López <emilio@elopez.com.ar>
 S:	Maintained
 F:	drivers/clk/sunxi/
 
-ARM/Allwinner sunXi SoC support
-M:	Chen-Yu Tsai <wens@csie.org>
-M:	Jernej Skrabec <jernej.skrabec@gmail.com>
-M:	Samuel Holland <samuel@sholland.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
-L:	linux-sunxi@lists.linux.dev
-F:	arch/arm/mach-sunxi/
-F:	arch/arm64/boot/dts/allwinner/
-F:	drivers/clk/sunxi-ng/
-F:	drivers/pinctrl/sunxi/
-F:	drivers/soc/sunxi/
-N:	allwinner
-N:	sun[x456789]i
-N:	sun[25]0i
-
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Jerome Brunet <jbrunet@baylibre.com>
@@ -2620,6 +2603,25 @@ F:	arch/arm/boot/dts/rtd*
 F:	arch/arm/mach-realtek/
 F:	arch/arm64/boot/dts/realtek/
 
+ARM/RISC-V/Allwinner sunXi SoC support
+M:	Chen-Yu Tsai <wens@csie.org>
+M:	Jernej Skrabec <jernej.skrabec@gmail.com>
+M:	Samuel Holland <samuel@sholland.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-riscv@lists.infradead.org
+L:	linux-sunxi@lists.linux.dev
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
+F:	arch/arm/mach-sunxi/
+F:	arch/arm64/boot/dts/allwinner/
+F:	arch/riscv/boot/dts/allwinner/
+F:	drivers/clk/sunxi-ng/
+F:	drivers/pinctrl/sunxi/
+F:	drivers/soc/sunxi/
+N:	allwinner
+N:	sun[x456789]i
+N:	sun[25]0i
+
 ARM/RISC-V/RENESAS ARCHITECTURE
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
 M:	Magnus Damm <magnus.damm@gmail.com>
-- 
2.36.0.rc2.17.g4027e30c53

