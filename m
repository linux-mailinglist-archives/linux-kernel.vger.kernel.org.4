Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E741C619B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiKDPLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiKDPLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:11:48 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C9C1DA71
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=esUmRi0N+eMqKm
        IhV1wcq1P9T65++DGCkr9c6bq5b2s=; b=TCX6jU8tXeb6AaRgaDV5TvA9GivnP9
        ApVzRcGATVe+pB56KwlNdN/G+z7yRCeDRHftQDFdJGTW1PGsmfACCgiKYiHfRjp+
        15Qkn4eQhHn/lDRuXJ8jc5Mx91sadncMFUKqtwjt3aDfQVWtNL8DRINDsvH89+JY
        h0FQB5MhaxjE8=
Received: (qmail 3148185 invoked from network); 4 Nov 2022 16:11:43 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Nov 2022 16:11:43 +0100
X-UD-Smtp-Session: l3s3148p1@q6vVfabsbjhZD+8G
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clk: renesas: r8a779g0: Add CMT clocks
Date:   Fri,  4 Nov 2022 16:11:33 +0100
Message-Id: <20221104151135.4706-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221104151135.4706-1-wsa+renesas@sang-engineering.com>
References: <20221104151135.4706-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index 7f0b4f75ff4d..1da48c81d3dd 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -193,6 +193,10 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("tmu4",		717,	R8A779G0_CLK_SASYNCPERD2),
 	DEF_MOD("tpu0",		718,	R8A779G0_CLK_SASYNCPERD4),
 	DEF_MOD("wdt1:wdt0",	907,	R8A779G0_CLK_R),
+	DEF_MOD("cmt0",		910,	R8A779G0_CLK_R),
+	DEF_MOD("cmt1",		911,	R8A779G0_CLK_R),
+	DEF_MOD("cmt2",		912,	R8A779G0_CLK_R),
+	DEF_MOD("cmt3",		913,	R8A779G0_CLK_R),
 	DEF_MOD("pfc0",		915,	R8A779G0_CLK_CL16M),
 	DEF_MOD("pfc1",		916,	R8A779G0_CLK_CL16M),
 	DEF_MOD("pfc2",		917,	R8A779G0_CLK_CL16M),
-- 
2.35.1

