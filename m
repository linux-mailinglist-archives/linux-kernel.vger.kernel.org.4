Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC7D71FA09
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjFBGZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjFBGZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:25:08 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5794FE7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=/Wt3FAz+QMdyWFgCq6hzT7xcxzyac+Un/+XRumxejUc=; b=sfkVhOfzP62qGMqGIMeruVTmIv
        poJapgW4vvSwGjLaobeJ6o3LPC9nf9BWZmEyLLGcendfpGIQ1gmjVklwUPEAQeOkvAdU2f6ruVPfe
        5FpEhwA+qJmkzSlLDE5HakUAtME5RG6QIXttWo39EEFund7GMBldSDbuisaQm71nhgZSZkpaBAWXe
        YNisiTPwjlzOq0uSpAESP4D3it/I8N9l+Hwudpgb8ZMV3O5mpYEclv2ofLVmeYTOca1qmcvnL2S9L
        18RzwU/w+7QmcgmP6sS0tOQFkbcglHbOqjf7KtaCk0FiZslU//RbK8zCE1r93tRyT6fz57CDoe59j
        xNR0b5lw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1q4yDg-000Ett-EG; Fri, 02 Jun 2023 08:25:04 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1q4yDg-000Nkl-6b; Fri, 02 Jun 2023 08:25:04 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     krzysztof.kozlowski@linaro.org, conor@kernel.org, lee@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v3 1/2] mfd: stpmic1: fixup main control register and bits naming
Date:   Fri,  2 Jun 2023 08:24:25 +0200
Message-Id: <20230602062426.3947116-1-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26925/Thu Jun  1 09:27:46 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup main control register and bits naming so the match the naming from
the datasheet.

https://www.st.com/resource/en/datasheet/stpmic1.pdf

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Lee Jones <lee@kernel.org>
---
Changes since v1:
 - None

Changes since v2:
 - None

 drivers/mfd/stpmic1.c       |  4 ++--
 include/linux/mfd/stpmic1.h | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index 8db1530d9bac..4c9b18d9dec8 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -19,7 +19,7 @@
 
 static const struct regmap_range stpmic1_readable_ranges[] = {
 	regmap_reg_range(TURN_ON_SR, VERSION_SR),
-	regmap_reg_range(SWOFF_PWRCTRL_CR, LDO6_STDBY_CR),
+	regmap_reg_range(MAIN_CR, LDO6_STDBY_CR),
 	regmap_reg_range(BST_SW_CR, BST_SW_CR),
 	regmap_reg_range(INT_PENDING_R1, INT_PENDING_R4),
 	regmap_reg_range(INT_CLEAR_R1, INT_CLEAR_R4),
@@ -30,7 +30,7 @@ static const struct regmap_range stpmic1_readable_ranges[] = {
 };
 
 static const struct regmap_range stpmic1_writeable_ranges[] = {
-	regmap_reg_range(SWOFF_PWRCTRL_CR, LDO6_STDBY_CR),
+	regmap_reg_range(MAIN_CR, LDO6_STDBY_CR),
 	regmap_reg_range(BST_SW_CR, BST_SW_CR),
 	regmap_reg_range(INT_CLEAR_R1, INT_CLEAR_R4),
 	regmap_reg_range(INT_SET_MASK_R1, INT_SET_MASK_R4),
diff --git a/include/linux/mfd/stpmic1.h b/include/linux/mfd/stpmic1.h
index fa3f99f7e9a1..dc00bac24f5a 100644
--- a/include/linux/mfd/stpmic1.h
+++ b/include/linux/mfd/stpmic1.h
@@ -15,7 +15,7 @@
 #define RREQ_STATE_SR		0x5
 #define VERSION_SR		0x6
 
-#define SWOFF_PWRCTRL_CR	0x10
+#define MAIN_CR			0x10
 #define PADS_PULL_CR		0x11
 #define BUCKS_PD_CR		0x12
 #define LDO14_PD_CR		0x13
@@ -148,14 +148,14 @@
 #define LDO_BYPASS_MASK			BIT(7)
 
 /* Main PMIC Control Register
- * SWOFF_PWRCTRL_CR
+ * MAIN_CR
  * Address : 0x10
  */
-#define ICC_EVENT_ENABLED		BIT(4)
+#define OCP_OFF_DBG			BIT(4)
 #define PWRCTRL_POLARITY_HIGH		BIT(3)
-#define PWRCTRL_PIN_VALID		BIT(2)
-#define RESTART_REQUEST_ENABLED		BIT(1)
-#define SOFTWARE_SWITCH_OFF_ENABLED	BIT(0)
+#define PWRCTRL_ENABLE			BIT(2)
+#define RESTART_REQUEST_ENABLE		BIT(1)
+#define SOFTWARE_SWITCH_OFF		BIT(0)
 
 /* Main PMIC PADS Control Register
  * PADS_PULL_CR
-- 
2.40.0

