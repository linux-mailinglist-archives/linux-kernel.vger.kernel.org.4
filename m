Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074986F48E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjEBRGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbjEBRGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:06:41 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5F81992
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=U5WSJVBUu1HRcd
        r3eLzWiIMXjKd22i5PtEbZP8Hd1f8=; b=m/gWdNev3TyoUNG3O2+PqkssOohWU7
        93eHcWbv3/Dim+J/KEOlLizHrCzOdzZo6yh1PobX8mWPeoMd6Egl+AJEyTleHQe7
        WXVNgk4rqAsfIZN3qr3todhkiPduKnJflTi3MRx2z5CJ4PPc6f/T41vmANi0DHRY
        3cei5ROZShpuM=
Received: (qmail 3809205 invoked from network); 2 May 2023 19:06:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 May 2023 19:06:30 +0200
X-UD-Smtp-Session: l3s3148p1@Ognm9bj6QOEujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: renesas: r8a779a0: Add PWM clock
Date:   Tue,  2 May 2023 19:06:17 +0200
Message-Id: <20230502170618.55967-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230502170618.55967-1-wsa+renesas@sang-engineering.com>
References: <20230502170618.55967-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/clk/renesas/r8a779a0-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a779a0-cpg-mssr.c b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
index fcc8279647a6..136a0d4e7ed6 100644
--- a/drivers/clk/renesas/r8a779a0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
@@ -170,6 +170,7 @@ static const struct mssr_mod_clk r8a779a0_mod_clks[] __initconst = {
 	DEF_MOD("msi3",		621,	R8A779A0_CLK_MSO),
 	DEF_MOD("msi4",		622,	R8A779A0_CLK_MSO),
 	DEF_MOD("msi5",		623,	R8A779A0_CLK_MSO),
+	DEF_MOD("pwm",		628,	R8A779A0_CLK_S1D8),
 	DEF_MOD("rpc-if",	629,	R8A779A0_CLK_RPCD2),
 	DEF_MOD("scif0",	702,	R8A779A0_CLK_S1D8),
 	DEF_MOD("scif1",	703,	R8A779A0_CLK_S1D8),
-- 
2.30.2

