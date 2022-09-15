Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16E95BA352
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 01:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIOXhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 19:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIOXhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 19:37:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB7D205E8;
        Thu, 15 Sep 2022 16:37:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso13977208wma.1;
        Thu, 15 Sep 2022 16:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=K5NCqfH5kO+QIWj1tbTN1iik/81ljzjQLpFKlnIn4Oo=;
        b=E2A5GOgit4jt+/gB32V/wAzXG8XAOcAvLnjLBZNPseLX29A9YpuH3eaJbnnVWamd//
         /OSZx4GauB+vq6A/LrF3+PpFKAaVa2sEzFxhPjwXo5AtFAuCLqFaGzsC3Yh3U7/0l+hZ
         AmEJooNiSiMxh8kn61NVwuYTgTH1L569yO9U6wGDvfP6l05vWIJmwIKDlbNT0+I/wj/6
         cWeWMLPNmCmhv5TkRD7ccQ0bzDveSUnvBjRWCx1r8l2cxMyWUJbzFt4APXw5kCJs4jer
         p82CMTPTUxT+Cixz4Dp/5dFj/7LWSh4bg2RUyq1QGWt1MTYH3Eax/ioX33IPJuZAGKyZ
         /oIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=K5NCqfH5kO+QIWj1tbTN1iik/81ljzjQLpFKlnIn4Oo=;
        b=tzzFY023p8MRsxF+RzZcyOUfpBwOoijOJ5E9neQ/1vjQ0d6yLbXGy9+b9HgzkWAucH
         HHhexGvDF26FZGVYUbjYTJG/xrFuD/7OfJDut018XuVrrDtS0FJ7tjXC4vtQmq7ssN+z
         xsBuvuuktf6Mebzs95niIWwkRud2Wutiv4RAghgxRvHE5FFur/pl0aNMuP4o6WktDmkG
         GEcHYUPZOj0qyeE2R8W6ZkDk7tqKwQOqNlVDiyZ0R/5NmhzSXkuwEg/xS4nCTdyiGtva
         GPzDdKu/MMwGT4lBOHFODY2bq8Q5XJewGNeuRruSzhBsPjhgAYyuk6DY1UIvZtbi+Tif
         BymQ==
X-Gm-Message-State: ACrzQf0SVER7+zuZZM2xOoqCFnC+vGZ8vhsVoBR4v4Wcs5tWivSxsx+X
        VcgoIsbLxZVNmkKJEEoosic=
X-Google-Smtp-Source: AMsMyM4RgNa9TOqSko7E6tyC0YRtVGwN0EcQgvvImgDRN6okgfXCQy4Q9zKB9Mbang3FhOCNtvoMQQ==
X-Received: by 2002:a05:600c:3b1a:b0:3b4:858b:aef1 with SMTP id m26-20020a05600c3b1a00b003b4858baef1mr1372979wms.193.1663285023762;
        Thu, 15 Sep 2022 16:37:03 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d411:a48b:4035:3d98])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d4b48000000b0021f15514e7fsm4643637wrs.0.2022.09.15.16.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 16:37:02 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: Kconfig.platforms: renesas: Drop selecting SOC_BUS
Date:   Fri, 16 Sep 2022 00:36:40 +0100
Message-Id: <20220915233640.415305-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Don't automatically select the SOC_BUS config option as we already have
automatically selected it as part of the SOC_RENESAS config option [0]
as renesas-soc.c [1] uses the APIs provided by SOC_BUS config option.

[0] drivers/soc/renesas/Kconfig
[1] drivers/soc/renesas/renesas-soc.c

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d328ae1a3ff3..76580b932e44 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -254,7 +254,6 @@ config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
 	select GPIOLIB
 	select PINCTRL
-	select SOC_BUS
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
 
-- 
2.25.1

