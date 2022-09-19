Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204875BCD46
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiISNbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiISNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:31:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDED918B3A;
        Mon, 19 Sep 2022 06:31:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id cc5so37703276wrb.6;
        Mon, 19 Sep 2022 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=SAfLaukKzdYoppXg6+h+210V4MuhmuuMaBfvLSo0+vA=;
        b=ntxP3m4ih3VsXQsX+TXpNHHsDx+EAiVv9bAutYlmE4zna94tUGo/6DApb8jLlQt16P
         488ZgQV2DASNustwFGgW2cXVIfs/C3OJK78y8jnHXI+GyfzLXt5QWyavNrxQdpH0oqM5
         lIE+/UCkH+TQkSgEsqigystXoKy+7xOroQlEAbJPmDyhwvQDbc4iIfGAk7Rctb3krdEx
         tijQgu9/IH//1zqBGl59P90pRVN/gQZC2Z+1bDBhdeW6pz74FBQ36Or9wg+T27+j44GF
         xUmsDfeX41YokIsbF5n3fUCmHjBP1QNJaaWJqX3QYaDRjS9buabK+3KIGG1hU4/72eSG
         yD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SAfLaukKzdYoppXg6+h+210V4MuhmuuMaBfvLSo0+vA=;
        b=TeAFVDPz5oO3BLYEjmHUm/2SGSb54nlcCGiMrcUr1uMeVaLCOPQH72mleZWJ8A841q
         SoQzTPFyJWBCRUzwyZBGMX9HKxPJ+AyGHTKIZCHcEnllSQbFcVpSe580vEcR5rUKK0Xr
         Wf/D1rg5wys1nIJZCpq7RhB5/Me2ZZfY5QLotoNtj4exRMTKZ2L60vi5wQ6mUSALVqPe
         sOdEQnE1HL08i/oYHJNsg1R30qgL13CBLU3pvf8QdDDfY4JlVsVIxaR7mUBP8Zw25Yk4
         8Yyhsir9q07UlICCCrgk/tUQc7VA0KKMp1JfA/FVPmcAmlR8zUpumDFv2ZJPDBCUB+7X
         zPEQ==
X-Gm-Message-State: ACrzQf1xjB+0ZuTm6xVAJSr8mqf0AMzP4ga184rgfBDn3QVjeN5xc7cu
        LptwBaTxlLjoDRMvdhfcK8Y=
X-Google-Smtp-Source: AMsMyM5Q2MYdkA3o3TQielZvm1nTz23Rcl2RWHVmJuptzSE6NbEB+MEBtbqsjEG41ObjtxYD1yfqKQ==
X-Received: by 2002:a05:6000:1866:b0:228:e373:ad68 with SMTP id d6-20020a056000186600b00228e373ad68mr10448162wri.605.1663594295430;
        Mon, 19 Sep 2022 06:31:35 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:453:ec29:bd55:6b15])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003a62052053csm17981163wmg.18.2022.09.19.06.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:31:34 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical list
Date:   Mon, 19 Sep 2022 14:31:22 +0100
Message-Id: <20220919133122.167794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add the WDT2 clocks to r9a07g044_crit_mod_clks[] list as WDT CH2 is
specifically to check the operation of Cortex-M33 CPU on the
RZ/{G2L, G2LC, V2L} SoCs and we dont want to turn off the clocks of
WDT2 if it isn't enabled by Cortex-A55.

This patch is in preparation to disable WDT CH2 from the RZ/G2L
(alike SoCs) DTS/I by default.

Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 02a4fc41bb6e..cf9b1bd73792 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -412,6 +412,8 @@ static const unsigned int r9a07g044_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A07G044_GIC600_GICCLK,
 	MOD_CLK_BASE + R9A07G044_IA55_CLK,
 	MOD_CLK_BASE + R9A07G044_DMAC_ACLK,
+	MOD_CLK_BASE + R9A07G044_WDT2_PCLK,
+	MOD_CLK_BASE + R9A07G044_WDT2_CLK,
 };
 
 #ifdef CONFIG_CLK_R9A07G044
-- 
2.25.1

