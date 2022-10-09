Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5F5F9393
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 01:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiJIXji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 19:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiJIXjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 19:39:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DEB54664;
        Sun,  9 Oct 2022 16:11:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j7so14685761wrr.3;
        Sun, 09 Oct 2022 16:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U1bkhRQ7/jPIkaHRJ7girtIbPjIJaxx203KJgdRDChc=;
        b=JNtxh0hYDoXW9ou4JWj/vFYaQ2ZTm9aGvty4VGskjC2HVJj8/C9P1J5Pl8FS3Jbbi+
         P2OmQ5SmPmLK7d0En3WUqJuURHJWEDxVYxVVrWn1CjM2wTYLgADMXJBwTvW1dIqScf8r
         FqT6JZl/lgomWNY8z8y0ew9PLiXhBkmu7BBCDiOczXsYX33wJDIN/1nJ4A3y1suRlNfQ
         d39WW+AoKKlqePLbHrbnCD2myYmdkpo+CB2nGWXSw+3plnfHkA9EezQMXp8qVc8G7k2p
         Yp7BU2Vr5jD+xbMfFGFdgHT94Po/LtX0pXvKjAyuho4Fj4sjydwFoheM/vqNpXpzQY9d
         X5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1bkhRQ7/jPIkaHRJ7girtIbPjIJaxx203KJgdRDChc=;
        b=INHFutOK9EkZS/AKgF3UFMTSegoAHmfAHSCJ8/kwUtFQLvY2gYeCE6IcXJ6kWy3nS4
         q++97EncOaegpwUB7dcQxMqO0ontdJdm6WO1tdbwzO14cDrw4x+CA9JGhWi+CektqgR0
         fhvYTd1GFbyJwZMwFTGgeRG5cmMX4W2dE2vlR9c99XtKOEjIaYDYnnLbuEGVof9R1PRi
         XFocVE4kTJB5pslbzyEwtqY9y5yN3gJnj0/7bFGeDoWbjZ6kGHV+v3zWqA3n54WreD8E
         dqMlfp75o121IPMgLa1DBORMC9pijRPmo+sUjv6AldWMBwJ72SUaVM6lxKL39F+91bvG
         JLNQ==
X-Gm-Message-State: ACrzQf0QZ5enfDYECrl1BThzZRhc/M2YaYzM84EJ9FWjvFwXIeBPtpE5
        sfN0VgFF6/SqbqnAhr/act4qm8+NDK4AAQ==
X-Google-Smtp-Source: AMsMyM49TiJ/0uOIBJj61lS8T0GjTx7ud6k+Iik8Bw+tOdmOVw8Ap/0Z5Ncfo3GxnmvvLAEcwRG69g==
X-Received: by 2002:a5d:5744:0:b0:22d:9b90:a8fe with SMTP id q4-20020a5d5744000000b0022d9b90a8femr9619872wrw.144.1665357032502;
        Sun, 09 Oct 2022 16:10:32 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e4:5cde:80ab:dfd4])
        by smtp.gmail.com with ESMTPSA id w9-20020a1cf609000000b003b332a7b898sm8458981wmc.45.2022.10.09.16.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 16:10:31 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] clk: renesas: r9a07g044: Drop WDT2 clock and reset entry
Date:   Mon, 10 Oct 2022 00:10:13 +0100
Message-Id: <20221009231013.14791-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
used from CA55 CPU would result in an unexpected behaviour. Hence drop
WDT2 clock and reset entries.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note, this patch applies on top of [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221005111855.553436-1-biju.das.jz@bp.renesas.com/
---
 drivers/clk/renesas/r9a07g044-cpg.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 12b1a83625cb..f5550fccb029 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -182,7 +182,7 @@ static const struct {
 };
 
 static const struct {
-	struct rzg2l_mod_clk common[77];
+	struct rzg2l_mod_clk common[75];
 #ifdef CONFIG_CLK_R9A07G054
 	struct rzg2l_mod_clk drp[0];
 #endif
@@ -224,10 +224,6 @@ static const struct {
 					0x548, 2),
 		DEF_MOD("wdt1_clk",	R9A07G044_WDT1_CLK, R9A07G044_OSCCLK,
 					0x548, 3),
-		DEF_MOD("wdt2_pclk",	R9A07G044_WDT2_PCLK, R9A07G044_CLK_P0,
-					0x548, 4),
-		DEF_MOD("wdt2_clk",	R9A07G044_WDT2_CLK, R9A07G044_OSCCLK,
-					0x548, 5),
 		DEF_MOD("spi_clk2",	R9A07G044_SPI_CLK2, R9A07G044_CLK_SPI1,
 					0x550, 0),
 		DEF_MOD("spi_clk",	R9A07G044_SPI_CLK, R9A07G044_CLK_SPI0,
@@ -366,7 +362,6 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_POEG_D_RST, 0x844, 3),
 	DEF_RST(R9A07G044_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A07G044_WDT1_PRESETN, 0x848, 1),
-	DEF_RST(R9A07G044_WDT2_PRESETN, 0x848, 2),
 	DEF_RST(R9A07G044_SPI_RST, 0x850, 0),
 	DEF_RST(R9A07G044_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A07G044_SDHI1_IXRST, 0x854, 1),
-- 
2.25.1

