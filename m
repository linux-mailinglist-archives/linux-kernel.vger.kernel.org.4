Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D1265A5BF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 17:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiLaQnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 11:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLaQnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 11:43:20 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C0B6584;
        Sat, 31 Dec 2022 08:43:16 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y25so35886168lfa.9;
        Sat, 31 Dec 2022 08:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3rkaK90EkPNFGjK3eO8YBzLCRfs4j3rNDEINUCKNOHA=;
        b=EAsYZtQsICraZr68ccUcaUK7GOx3hEfjQmLHIe3qtZfolYAgrM9zYC1U86DBdHZy9C
         FSvl1xdSp7VZQLeEOIy03r+9T6ytinPas/scV5Xf+kKtRDY4ryUCfJxdJEudG4Rg3BXB
         yOjlpaR3RJETf9VLwmQh+QvTSzmbSfgfiz7+8js7ZiADefpUTbS3yQh10erWtOxsSSWb
         B6n5UKpcrpUCtDb3rztoagyeADqnxBFN3ntHoJXNoqZ5ulfAegMMPP64dYzqrSHPZM6D
         wPBNn4D2NxpbLavYSAr8d6VpKiDR6PveV10SgD1WxDJPufI2cOEPJ4DtFrW9LQBADiaJ
         PH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rkaK90EkPNFGjK3eO8YBzLCRfs4j3rNDEINUCKNOHA=;
        b=M6eOsRanRFfwx2yi9mVDfML7qVRKDdEP6gbLVb3bR6aT89eLoR+gNq+gF7WdLYyBNC
         pTKqgfUELqy5zxDR+RFe+MeC+CvYknYfi1yhDW8Amn8F+w3GUCqjMD2uMaudleRGLJso
         ruIorfWUTB0gu2DVhaaijU18Fcu/w5lOu9xPa8Vs/gcCBkxsCKoZx3eRcIA3sknjh8Lp
         MclrNAH1nvqxsyAI29ut+Fma6TXVFQZbG/eDjRa504HRYVzDEi7MBbevzkQr4XdBN+iG
         xqw0rJn+0lQGD50BWSkm1ucgLyF8gc2eMuq7VYC7nA6+rDJZ/c83PJh80pcOD6bLmwO7
         2XHQ==
X-Gm-Message-State: AFqh2koPZaUDYVBXFNKeyIMG3xvTfJvcwnHiOeX4oHSzP7KF2wrSyZ0a
        mr6+GSnvLH1fhsbawT7lIUZRNIcDZ/ZUZQ==
X-Google-Smtp-Source: AMrXdXudcQ7FULwQ3SfMmzAwGHT7GMwamawECIbK9MWLXbgWWAjUSHMu1axh/6TE2QeQxCFuqp+niw==
X-Received: by 2002:a05:6512:1384:b0:4cb:190:b0bb with SMTP id p4-20020a056512138400b004cb0190b0bbmr7229925lfa.37.1672504994370;
        Sat, 31 Dec 2022 08:43:14 -0800 (PST)
Received: from localhost.localdomain (byx211.neoplus.adsl.tpnet.pl. [83.30.43.211])
        by smtp.gmail.com with ESMTPSA id z8-20020a056512376800b004b52aea5ff8sm3870367lft.30.2022.12.31.08.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:43:13 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: pinctrl-msm8976: Correct function names for wcss pins
Date:   Sat, 31 Dec 2022 17:42:50 +0100
Message-Id: <20221231164250.74550-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust names of function for wcss pins, also fix third gpio in bt group.

Fixes: bcd11493f0ab ("pinctrl: qcom: Add a pinctrl driver for MSM8976 and 8956")
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-msm8976.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8976.c b/drivers/pinctrl/qcom/pinctrl-msm8976.c
index ec43edf9b660..e11d84584719 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8976.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8976.c
@@ -733,7 +733,7 @@ static const char * const codec_int2_groups[] = {
 	"gpio74",
 };
 static const char * const wcss_bt_groups[] = {
-	"gpio39", "gpio47", "gpio88",
+	"gpio39", "gpio47", "gpio48",
 };
 static const char * const sdc3_groups[] = {
 	"gpio39", "gpio40", "gpio41",
@@ -958,9 +958,9 @@ static const struct msm_pingroup msm8976_groups[] = {
 	PINGROUP(37, NA, NA, NA, qdss_tracedata_b, NA, NA, NA, NA, NA),
 	PINGROUP(38, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b, NA),
 	PINGROUP(39, wcss_bt, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
-	PINGROUP(40, wcss_wlan, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
-	PINGROUP(41, wcss_wlan, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
-	PINGROUP(42, wcss_wlan, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(40, wcss_wlan2, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(41, wcss_wlan1, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(42, wcss_wlan0, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
 	PINGROUP(43, wcss_wlan, sdc3, NA, NA, qdss_tracedata_a, NA, NA, NA, NA),
 	PINGROUP(44, wcss_wlan, sdc3, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(45, wcss_fm, NA, qdss_tracectl_a, NA, NA, NA, NA, NA, NA),
-- 
2.25.1

