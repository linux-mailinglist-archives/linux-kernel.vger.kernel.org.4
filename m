Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2BF665777
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbjAKJaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbjAKJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:28:51 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC00F6C;
        Wed, 11 Jan 2023 01:28:39 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gh17so35334253ejb.6;
        Wed, 11 Jan 2023 01:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q9UoVeKgkeFVzPvHD0dkZIpE4N/tOVpWZSUXvYIFc/s=;
        b=HPZK19vWI+PAdy33Iy5Md7Oj3eBfCv/n2jId6Zr8VKw226AcNWP1tqASnnSbAzDVyB
         BhGYUvmhjVQ+u7JGHkeUhzf2O0Cbr3u+OYUP3MybSXdbM1uPlZivKPl0UQ5zPJn//jXa
         pKp3koxTp6Brfz6Sd5P7I+Xj5R95TERPci1S5YhjAtetqYG0XYCHJ86LbfjNO1qPDZqe
         rhTBMOfbX/SLnbVu7+o0LegLA5cXujqmEHlXQiTdbQJ+0OmAKPWuP+ARvcxBrYBF91U5
         qaAByz348VIcEvmWPIj7GmGdOSwir4oB6sGuUe6zbIDzexukeqfPCRcPRY2t7QiRIyu8
         ZXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9UoVeKgkeFVzPvHD0dkZIpE4N/tOVpWZSUXvYIFc/s=;
        b=nxNEVNghood7bAgAI7bNtTE39m+SJAt8F6xJ9H1cwf/jO8KpfR7zFuhpK+GI131fsM
         VEaTVvipHN672bFvrfyyaNKOstOn6srM0Habae/V1zrHAhiuoKZAdCNKq+AfovlDzEum
         t9abEfOEgVXGcKd74w8VM1xXlCTzn4fu9yaaHskoErMjufHEbuB+tSmRnc1CmoNsje+5
         l1Ab1dQERoRRbSp0dLiSWgUhpNNK8UBemGokN373iYz6tUnmTamYdvxnHlZBvrmYmJMg
         Jd9Ofryrue+vmigsB+caAIthLsYrF5z+cows81b30IdlzoqQov06fm9g1/yaP2l3BrKr
         fHzg==
X-Gm-Message-State: AFqh2krXpYY35krjcsUoS+KNKIPQE9yEo80Iv4FVnQWeQCn40+EyGxN0
        aSUI+T5LUDA+bhU+JVMtXMw=
X-Google-Smtp-Source: AMrXdXvzHGN2MWaT85mUB9TcFSkyw/RZSplM9ihky1oRtyhCVILSOQb9x6B29W17WX9oZq4qKEecdw==
X-Received: by 2002:a17:907:6d98:b0:7c1:12b0:7d5d with SMTP id sb24-20020a1709076d9800b007c112b07d5dmr79912279ejc.4.1673429317850;
        Wed, 11 Jan 2023 01:28:37 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a47e:7f3e:6b25:bafb])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906308e00b0084d3acda5fasm4473970ejv.189.2023.01.11.01.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:28:37 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] MAINTAINERS: update file entries after arm multi-platform rework and mach-pxa removal
Date:   Wed, 11 Jan 2023 10:28:27 +0100
Message-Id: <20230111092828.958-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230111092828.958-1-lukas.bulwahn@gmail.com>
References: <20230111092828.958-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the work of Arnd's arm multi-platform support, various files in arch/arm
are moved and after the arm mach-pxa removal, only a few files remain to be
not aligned with entries in MAINTAINERS.

These file movements still require adjustments in MAINTAINERS:

  Files in arch/arm/mach-ep93xx/include/mach/ are made local:

    arch/arm/{mach-ep93xx/include/mach/uncompress.h => boot/compressed/misc-ep93xx.h}
    arch/arm/mach-ep93xx/{include/mach => }/ep93xx-regs.h
    arch/arm/mach-ep93xx/{include/mach => }/mach/irqs.h

  Files in arch/arm/mach-vexpress/ are moved to mach-versatile.

Correct the remaining references accordingly after these refactorings.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0cd07e968ae..e400f564b0f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2071,8 +2071,8 @@ M:	Hartley Sweeten <hsweeten@visionengravers.com>
 M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	arch/arm/boot/compressed/misc-ep93xx.h
 F:	arch/arm/mach-ep93xx/
-F:	arch/arm/mach-ep93xx/include/mach/
 
 ARM/CLKDEV SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
@@ -2977,7 +2977,7 @@ S:	Maintained
 F:	*/*/*/vexpress*
 F:	*/*/vexpress*
 F:	arch/arm/boot/dts/vexpress*
-F:	arch/arm/mach-vexpress/
+F:	arch/arm/mach-versatile/
 F:	arch/arm64/boot/dts/arm/
 F:	drivers/clk/versatile/clk-vexpress-osc.c
 F:	drivers/clocksource/timer-versatile.c
-- 
2.17.1

