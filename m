Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03C8725BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbjFGKsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjFGKsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:48:08 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544FFAA;
        Wed,  7 Jun 2023 03:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=xA/WZLvijjFlvE45qCUeYVjUps02xc70J/Efe21HAXk=; b=HTcCDKcGZGiK1VyddVWVgfFT5A
        0zj4yoN1aO27dms6nz1tUKCOTRS/okXhjRRFD5aqXWzvG+qkUXX023hvWbUKYTCbXENRhYA6XyehT
        CDjeaAu9tUDS7OPZbOV63PAOew1umvfY742tsZFOkyIMe/1Y6tkvTxjGYCCFKVDqJ/VZGhn2iPhnG
        2eVmLmlI/0bFxNLvzK5HAdbd8JS8Y7gtIsa4MnhMJdwGfDmnwWrD9Kc5kaRObi/V3VMoALarrpQ+8
        mEyKnTmivvqZaDIKuqRhMXODO9WEwLSjPiKwixn+Sn5na224yELupdX6+r+pJX8mA+A/opcJ7yaHm
        Au4GaddA==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1q6qhp-0069NL-AJ; Wed, 07 Jun 2023 12:47:57 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Wed, 07 Jun 2023 12:47:44 +0200
Subject: [PATCH v5 1/6] thermal: qcom: tsens: Drop unused legacy structs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-msm8909-tsens-v5-1-5eb632235ba7@kernkonzept.com>
References: <20230508-msm8909-tsens-v5-0-5eb632235ba7@kernkonzept.com>
In-Reply-To: <20230508-msm8909-tsens-v5-0-5eb632235ba7@kernkonzept.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old single-cell parsing code was removed for MSM8939, MDM9607 and
MSM8976 but for some reason the structs defining the bit positions etc
were kept around (unused). Drop them now.

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 51d78b8b1beb ("thermal/drivers/tsens: Drop single-cell code for mdm9607")
Fixes: dfadb4599ab0 ("thermal/drivers/tsens: Drop single-cell code for msm8939")
Fixes: 3a908971f7cb ("thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/thermal/qcom/tsens-v0_1.c | 36 ------------------------------------
 drivers/thermal/qcom/tsens-v1.c   | 22 ----------------------
 2 files changed, 58 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index ad57ab94546b..a65f58264122 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -39,26 +39,6 @@ struct tsens_legacy_calibration_format tsens_8916_nvmem = {
 	},
 };
 
-struct tsens_legacy_calibration_format tsens_8939_nvmem = {
-	.base_len = 8,
-	.base_shift = 2,
-	.sp_len = 6,
-	.mode = { 12, 0 },
-	.invalid = { 12, 2 },
-	.base = { { 0, 0 }, { 1, 24 } },
-	.sp = {
-		{ { 12, 3 },  { 12, 9 } },
-		{ { 12, 15 }, { 12, 21 } },
-		{ { 12, 27 }, { 13, 1 } },
-		{ { 13, 7 },  { 13, 13 } },
-		{ { 13, 19 }, { 13, 25 } },
-		{ { 0, 8 },   { 0, 14 } },
-		{ { 0, 20 },  { 0, 26 } },
-		{ { 1, 0 },   { 1, 6 } },
-		{ { 1, 12 },  { 1, 18 } },
-	},
-};
-
 struct tsens_legacy_calibration_format tsens_8974_nvmem = {
 	.base_len = 8,
 	.base_shift = 2,
@@ -103,22 +83,6 @@ struct tsens_legacy_calibration_format tsens_8974_backup_nvmem = {
 	},
 };
 
-struct tsens_legacy_calibration_format tsens_9607_nvmem = {
-	.base_len = 8,
-	.base_shift = 2,
-	.sp_len = 6,
-	.mode = { 2, 20 },
-	.invalid = { 2, 22 },
-	.base = { { 0, 0 }, { 2, 12 } },
-	.sp = {
-		{ { 0, 8 },  { 0, 14 } },
-		{ { 0, 20 }, { 0, 26 } },
-		{ { 1, 0 },  { 1, 6 } },
-		{ { 1, 12 }, { 1, 18 } },
-		{ { 2, 0 },  { 2, 6 } },
-	},
-};
-
 static int calibrate_8916(struct tsens_priv *priv)
 {
 	u32 p1[5], p2[5];
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index b822a426066d..51322430f1fe 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -42,28 +42,6 @@ struct tsens_legacy_calibration_format tsens_qcs404_nvmem = {
 	},
 };
 
-struct tsens_legacy_calibration_format tsens_8976_nvmem = {
-	.base_len = 8,
-	.base_shift = 2,
-	.sp_len = 6,
-	.mode = { 4, 0 },
-	.invalid = { 4, 2 },
-	.base = { { 0, 0 }, { 2, 8 } },
-	.sp = {
-		{ { 0, 8 },  { 0, 14 } },
-		{ { 0, 20 }, { 0, 26 } },
-		{ { 1, 0 },  { 1, 6 } },
-		{ { 1, 12 }, { 1, 18 } },
-		{ { 2, 8 },  { 2, 14 } },
-		{ { 2, 20 }, { 2, 26 } },
-		{ { 3, 0 },  { 3, 6 } },
-		{ { 3, 12 }, { 3, 18 } },
-		{ { 4, 2 },  { 4, 9 } },
-		{ { 4, 14 }, { 4, 21 } },
-		{ { 4, 26 }, { 5, 1 } },
-	},
-};
-
 static int calibrate_v1(struct tsens_priv *priv)
 {
 	u32 p1[10], p2[10];

-- 
2.30.2

