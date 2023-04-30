Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D966A6F2A51
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 20:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjD3SWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 14:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjD3SWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 14:22:11 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E141BD5;
        Sun, 30 Apr 2023 11:22:04 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id AEF0BCE0BF;
        Sun, 30 Apr 2023 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682878891; bh=Rcioak1SAMFJlnKdICBYsQ1IntIypnG/42IWMTd887s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=e3CBwVQ+vDjjcwctlyKeDI9LBCw7lFU4H1JR5XuSc4nQr+8N6DDegJy/LhYItvnCy
         DI/CQ83ebAZH7rDtIaTMPsTmNi0J7N6VRp1nIG91bf82uR+L929JGDKth5b7Qg4BPc
         Y6SiyXzXcNTORGcyZRxtl2rWCHwEw5xxJc47LM7M=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 30 Apr 2023 20:20:53 +0200
Subject: [PATCH 1/5] Input: drv260x - fix typo in register value define
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230430-drv260x-improvements-v1-1-1fb28b4cc698@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=Rcioak1SAMFJlnKdICBYsQ1IntIypnG/42IWMTd887s=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkTrGmVqx1JVXuZF03ok1L4liY6n8w5n0NzE5Pw
 g9IopH67DuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZE6xpgAKCRBy2EO4nU3X
 VhXnD/9Ct/pZCBcdZhfz5v4cc6oT7pG6n+Lj1gY2sk3DMXkI3B8g39hQh0fU+IyBvISljIrrFvN
 jK7c/8P4BnnEOMGqEddSoRqXBwykY7k1aLOKQTR1nhCaTI7yIFrWFQ8cc0ojYAWym+k5pelyQd1
 kAIGUysi6AM97LMOeS9PLJ+Ab1LvWTitLS1ipFTsi0qjVKrAu8MgFKCw09D/Sv6MPO/NESapDtJ
 8x4mc+RyiBABxqYg6sYp9OYI13UqaSklGy4M7l679b/GwZJtDRR4OzExupJIA3bQ2bjkQnq8/pk
 dJjmID/21HwecrXe6OKDtwaSFP+xj31gWq8tnb9CwShjz5n1RziVh/WceLAYWfuBKcNRuEjbODb
 /n8yC47Hi6LkrmK1d8dz34cpuB3BzsqEjXaJq3pXIcQhO54e7Re9uTZ5l+Wh/adywdhIfhfDTzA
 7j+b/aqASHj8Fb1CylnhQe0bj4ip0orjJNbs4sR21mLIUgLsgrBYXTMKmlfYfJn+EPGswzOTdUP
 TMZcH1YEVyhOxBXK3BPOSK66UNSXmG8o0IPxnQNvliVGnmncxW+b6dIH56hng8B84vAymPl9tRj
 1FH6vx4eRQqNc04f8A0T9zwOYdOR6GBomVrxmDITQ436SFMsKT1vxgoAG/ZEyw67YvZf1x+E+F9
 K35lw5u98rPQopg==
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

ANANLOG should be ANALOG. Fix the typo.

Fixes: 7132fe4f5687 ("Input: drv260x - add TI drv260x haptics driver")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/input/misc/drv260x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 8a9ebfc04a2d..e95c4e775b5d 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -149,7 +149,7 @@
 
 /* Control 3 Register */
 #define DRV260X_LRA_OPEN_LOOP		(1 << 0)
-#define DRV260X_ANANLOG_IN			(1 << 1)
+#define DRV260X_ANALOG_IN			(1 << 1)
 #define DRV260X_LRA_DRV_MODE		(1 << 2)
 #define DRV260X_RTP_UNSIGNED_DATA	(1 << 3)
 #define DRV260X_SUPPLY_COMP_DIS		(1 << 4)
@@ -322,7 +322,7 @@ static const struct reg_sequence drv260x_lra_init_regs[] = {
 		DRV260X_BEMF_GAIN_3 },
 	{ DRV260X_CTRL1, DRV260X_STARTUP_BOOST },
 	{ DRV260X_CTRL2, DRV260X_SAMP_TIME_250 },
-	{ DRV260X_CTRL3, DRV260X_NG_THRESH_2 | DRV260X_ANANLOG_IN },
+	{ DRV260X_CTRL3, DRV260X_NG_THRESH_2 | DRV260X_ANALOG_IN },
 	{ DRV260X_CTRL4, DRV260X_AUTOCAL_TIME_500MS },
 };
 

-- 
2.40.1

