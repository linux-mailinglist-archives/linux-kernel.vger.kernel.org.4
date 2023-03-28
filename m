Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8596CB4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjC1DjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjC1DjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:39:17 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4BA172E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:39:15 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id e11so11103147lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112; t=1679974754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+teYGhMbJ/qz9LQzLhsSWOaFjw154Q/LczJdwFN1UeE=;
        b=XocY01PzBpz+CXvNjXM0LutVNnAk/CZv2NrrC7j6q2IRdAtZgsB3HT7qtHlBLq5YZy
         UzTy1tgacmQYtAwFKyL0swlY0C94yOdeSKZiJJcNP/J23PuDxTc0SGo/BcyvfAyTe2OQ
         EIuaO4PPkjTy0GCvATDtdYNgJ4WuRqsJUH0xRTFgoO7a1N6jWllaCxakrwUOCIC3CKPY
         phpsqx+z47ZGUyJzlWAzlRLko0fD3ky4Ztw22VMS8btx1BQbObDvvyv7FeSkDHYctOaz
         ouHBfKTSmRmBBKwPxgUL3Dr6J14c0pD1WDirMZhGdbY1xbtuHv4nmBpCzWtxt5AEJooC
         FhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679974754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+teYGhMbJ/qz9LQzLhsSWOaFjw154Q/LczJdwFN1UeE=;
        b=vgzesb3gPm8uBTthkNUVFvXRTCgSwTV6QF3kIqtINZAqXbcaTHGN5IFWbE20QPwdDX
         uEevEwM0Sss/DK4MYKdM7dSXG86W8gAvhLaV9iRNOEl34JBvtJW7Z4XRzcpcXazyYe2n
         gHz16OTCs+6py3NX4I8052LG1AEN7FONntQybK2o+4/INQ3MRjRX0D0zhlkLKeLY3k4j
         csShxaMfFgxxs8fe6CRYrLN53ZRgAtvJHCXcVXZtcTkF21x5bb2EvxtQpi55IdZuzcod
         Ujql2KtvEPXZe3+rsYURXpNOtOdXRqmqcGetYgadMQfEARdjYM2+Z1dJSth5AGzeGgSA
         yLOQ==
X-Gm-Message-State: AAQBX9fZr1pr0ou+esmgurX4jLiZ2yAOs1vkcvRGw9A/WYwY7jc6RMu5
        o9Y9J6mE8HPtx9YabsB+nCwBvg==
X-Google-Smtp-Source: AKy350ZXmlguZVLGLGK8nHVPZeZlcJTzhlT/xD/9+u+W4Dc/kdvYAValjAG/AN1/BfQqHwd4pZb1UA==
X-Received: by 2002:a2e:868c:0:b0:298:9b8d:cc17 with SMTP id l12-20020a2e868c000000b002989b8dcc17mr4391050lji.9.1679974753652;
        Mon, 27 Mar 2023 20:39:13 -0700 (PDT)
Received: from cobook.lan ([85.193.119.48])
        by smtp.gmail.com with ESMTPSA id r10-20020a2eb60a000000b002945b851ea5sm4865094ljn.21.2023.03.27.20.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 20:39:13 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] clk: renesas: r8a77980: Add i2c5 clock
Date:   Tue, 28 Mar 2023 09:39:02 +0600
Message-Id: <20230328033902.830269-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSSR clock definition for i2c5 was missing. Add it.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/clk/renesas/r8a77980-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a77980-cpg-mssr.c b/drivers/clk/renesas/r8a77980-cpg-mssr.c
index 01ea09891b32..2f21a8725907 100644
--- a/drivers/clk/renesas/r8a77980-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77980-cpg-mssr.c
@@ -206,6 +206,7 @@ static const struct mssr_mod_clk r8a77980_mod_clks[] __initconst = {
 	DEF_MOD("gpio0",		 912,	R8A77980_CLK_CP),
 	DEF_MOD("can-fd",		 914,	R8A77980_CLK_S3D2),
 	DEF_MOD("rpc-if",		 917,	R8A77980_CLK_RPCD2),
+	DEF_MOD("i2c5",			 919,	R8A77980_CLK_S0D6),
 	DEF_MOD("i2c4",			 927,	R8A77980_CLK_S0D6),
 	DEF_MOD("i2c3",			 928,	R8A77980_CLK_S0D6),
 	DEF_MOD("i2c2",			 929,	R8A77980_CLK_S3D2),
-- 
2.30.2

