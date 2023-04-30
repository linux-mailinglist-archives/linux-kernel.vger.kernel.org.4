Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DED46F2A52
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 20:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjD3SWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjD3SWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 14:22:12 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567FA2D54;
        Sun, 30 Apr 2023 11:22:04 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4CEA1CEC7A;
        Sun, 30 Apr 2023 18:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682878892; bh=FvMcse6MLsbVxRrJLcTSsgg2rGTfDB1+G4bqmgYng0g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=QzdUVnIMzqFjlITKUDtui4tr7rOVdAm0/LxRRS7T6mWAeMkTM2q41hQOVXIkQBlkG
         iM+FCyX6/PxmUftbS07lNkAbFW0cC49fNKrJ5t9CJPt3x7UyOFOjHP2+hYhzqS3u4d
         WMKNDCLCE3yRAoRLLtEmlxah6bSleFKONkE7vD4k=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 30 Apr 2023 20:20:55 +0200
Subject: [PATCH 3/5] Input: drv260x - remove unused .reg_defaults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230430-drv260x-improvements-v1-3-1fb28b4cc698@z3ntu.xyz>
References: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
In-Reply-To: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2291; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=FvMcse6MLsbVxRrJLcTSsgg2rGTfDB1+G4bqmgYng0g=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkTrGozXcO/sDeRLWK6UMDpNHnsBPS252acBqw+
 nkdYXgTM6CJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZE6xqAAKCRBy2EO4nU3X
 VmNeEADF84qF6eb0T7D21o0wIMKjLjMAlLI6jz5lemvrRO5uFx+Jt79NueiJ7F4DsCwT2O32QEH
 CGW5+7Ojl6DcCVbYa5JUveusxkYvIzGHzhAHkIZZqX1WC9EVmcEfhTs60YG7ITjJJp/PQUMAkWx
 68xFx64MRWZPpM6xEqRiU58fzNDrBifxcJ2flHgZNPs5DVL+WTE2GwgmhqjvarmGg0vWG1Y8WX6
 LEuo1k/w/fkckmfH+zbSuFsCEl2F9NeDSl9U6wDqe5f2Ju7Cz+OKe08ZdysLDF9UievUTAv9DCS
 +T/WudTv3LedVxWvsXO/9gT7BOk+lh3belqeresukkaDq6SmsiJHqQ2QzngyXdXdtXvTwpJ82Hl
 80TwWqltK2kbZBZL1BGzuvRCG/5lV7/1lg6xxIiiRGdi9AnwvAoiiR0yIgvuaEfiW63o42hBzVF
 jLNwpfaZe/Tu6tceY0PuCjsQKLlaXt7jcdL2z8ZhXa8q2V5bOX42UCCdADLCwu7hX5VrcbJS4Cw
 gS71en1xDrBIjt7rmlWIWuOaFFZAN4/ybX/ZquS8rAD8UpcxKO4bhd58w4fI/w+IZiN+FS188xd
 5gYJ00C81ni4t0V4GAtI8k3ZHV5bWBmiBPCHyps41yveNMSf9Fciya5+9W+OoMxthG5XR7VMEWO
 PxLxfUK8vaPJdQg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the driver has disabled regmap caching with REGCACHE_NONE, it's
warning us that we provide defaults that are not used. Remove them.

  [    0.561159] drv260x-haptics 0-005a: No cache used with register defaults set!

Fixes: 7132fe4f5687 ("Input: drv260x - add TI drv260x haptics driver")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/input/misc/drv260x.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 884d43eb4b61..a7e3120bdc13 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -193,44 +193,6 @@ struct drv260x_data {
 	int overdrive_voltage;
 };
 
-static const struct reg_default drv260x_reg_defs[] = {
-	{ DRV260X_STATUS, 0xe0 },
-	{ DRV260X_MODE, 0x40 },
-	{ DRV260X_RT_PB_IN, 0x00 },
-	{ DRV260X_LIB_SEL, 0x00 },
-	{ DRV260X_WV_SEQ_1, 0x01 },
-	{ DRV260X_WV_SEQ_2, 0x00 },
-	{ DRV260X_WV_SEQ_3, 0x00 },
-	{ DRV260X_WV_SEQ_4, 0x00 },
-	{ DRV260X_WV_SEQ_5, 0x00 },
-	{ DRV260X_WV_SEQ_6, 0x00 },
-	{ DRV260X_WV_SEQ_7, 0x00 },
-	{ DRV260X_WV_SEQ_8, 0x00 },
-	{ DRV260X_GO, 0x00 },
-	{ DRV260X_OVERDRIVE_OFF, 0x00 },
-	{ DRV260X_SUSTAIN_P_OFF, 0x00 },
-	{ DRV260X_SUSTAIN_N_OFF, 0x00 },
-	{ DRV260X_BRAKE_OFF, 0x00 },
-	{ DRV260X_A_TO_V_CTRL, 0x05 },
-	{ DRV260X_A_TO_V_MIN_INPUT, 0x19 },
-	{ DRV260X_A_TO_V_MAX_INPUT, 0xff },
-	{ DRV260X_A_TO_V_MIN_OUT, 0x19 },
-	{ DRV260X_A_TO_V_MAX_OUT, 0xff },
-	{ DRV260X_RATED_VOLT, 0x3e },
-	{ DRV260X_OD_CLAMP_VOLT, 0x8c },
-	{ DRV260X_CAL_COMP, 0x0c },
-	{ DRV260X_CAL_BACK_EMF, 0x6c },
-	{ DRV260X_FEEDBACK_CTRL, 0x36 },
-	{ DRV260X_CTRL1, 0x93 },
-	{ DRV260X_CTRL2, 0xfa },
-	{ DRV260X_CTRL3, 0xa0 },
-	{ DRV260X_CTRL4, 0x20 },
-	{ DRV260X_CTRL5, 0x80 },
-	{ DRV260X_LRA_LOOP_PERIOD, 0x33 },
-	{ DRV260X_VBAT_MON, 0x00 },
-	{ DRV260X_LRA_RES_PERIOD, 0x00 },
-};
-
 #define DRV260X_DEF_RATED_VOLT		0x90
 #define DRV260X_DEF_OD_CLAMP_VOLT	0x90
 
@@ -453,8 +415,6 @@ static const struct regmap_config drv260x_regmap_config = {
 	.val_bits = 8,
 
 	.max_register = DRV260X_MAX_REG,
-	.reg_defaults = drv260x_reg_defs,
-	.num_reg_defaults = ARRAY_SIZE(drv260x_reg_defs),
 	.cache_type = REGCACHE_NONE,
 };
 

-- 
2.40.1

