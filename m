Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA30F5B96C4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIOI6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiIOI6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:58:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987DA8C445
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:58:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v16so40511392ejr.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=m9yLILp4WwPiYPfrmomBBkZCXUlxugBoSzuRJ4gxLjc=;
        b=bnLWuZ4RadQfGDEQzXl4KWkIcHxQ7NO8ex7Xglu+gz+ke75ySUd7ILPp6rsqufvvoD
         Uscn+1yYI3hGELimcR9FosA7gnlgx+Na6EA93atQgI9GJvmIUKtmQeT3t2GvjFWEMp8t
         P5LeAx7VFM7H1bcTfCZpirpwr+dGmfeIgYxPc6DsHg6rW3Jiwh3WDye1sRbtJd0vOI3o
         J2+9e2g8wP7Qg7oaW9H4TBUCa4G4LClfF/j+y8p92WA45K6+NnZ88JNJrbt84efC/qDy
         xmrXcE7OzYwVfVsWFq5B703e9J1+5ka/SL3iAfvAVTRowp40G1/G7DbvzHQgkM7VQn5U
         opNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=m9yLILp4WwPiYPfrmomBBkZCXUlxugBoSzuRJ4gxLjc=;
        b=rUrE80R3yePHc7XLg0zld4oC5sBzC/g7OG60QscUhZ6/77Or8LhB58v076olfmj/d/
         +Djhta0D+D/WikDiW7mgtad77SesB78i9HMJ5RLJi4o0BkSl72CLPhnA+WNzGT7sGJum
         cCLDTq64xxu+SRPmpgyX/RPKjftxysw6uImRsiMKIO8/Mw7bNXfyw19HKddix/qSwBu8
         +jigzhxuvJ1ptGvxjLdQGZNLK87zvhMCO55HAazlN2gGLfx9s9T380bOv92fZ1ER4tL9
         dgyuRN355PsNTQaiBATTsTmjG5TOEO/9paQbnG5lDuwHg4ZSuPwRESSQg+BD3XC5Lxu/
         yHZw==
X-Gm-Message-State: ACgBeo3sxub8DPrKWseDoAn3i2zWlM/6OdNzUCKKpSOw4EGi0+G5x2YB
        YFeDFZe4prX6Iorx/3ykD+YulKQ7pOD5vA==
X-Google-Smtp-Source: AA6agR46Ww65XaZZFcTK2CTunJ9f1x2s/iBJHMNA6PT6/lJ8OHN+1eL8nYhSqDFY+FvDRa29fs8JsQ==
X-Received: by 2002:a17:906:2bc7:b0:72f:dc70:a3c6 with SMTP id n7-20020a1709062bc700b0072fdc70a3c6mr28903983ejg.645.1663232319205;
        Thu, 15 Sep 2022 01:58:39 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ov22-20020a170906fc1600b00770e405ad4esm8731235ejb.124.2022.09.15.01.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 01:58:38 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mfd: qcom-spmi-pmic: Add more PMIC SUBTYPE IDs
Date:   Thu, 15 Sep 2022 10:57:32 +0200
Message-Id: <20220915085733.20290-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more IDs that are found in the downstream msm-4.19 kernel under the
path include/linux/qpnp/qpnp-revid.h.

While we're at it, make sure all hex numbers are uppercase and
consistent in this file.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
* Convert existing lowercase hex numbers to uppercase

 include/soc/qcom/qcom-spmi-pmic.h | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
index 72398ff44719..f1c9f1676fb4 100644
--- a/include/soc/qcom/qcom-spmi-pmic.h
+++ b/include/soc/qcom/qcom-spmi-pmic.h
@@ -18,26 +18,40 @@
 #define PMI8962_SUBTYPE		0x07
 #define PMD9635_SUBTYPE		0x08
 #define PM8994_SUBTYPE		0x09
-#define PMI8994_SUBTYPE		0x0a
-#define PM8916_SUBTYPE		0x0b
-#define PM8004_SUBTYPE		0x0c
-#define PM8909_SUBTYPE		0x0d
-#define PM8028_SUBTYPE		0x0e
-#define PM8901_SUBTYPE		0x0f
+#define PMI8994_SUBTYPE		0x0A
+#define PM8916_SUBTYPE		0x0B
+#define PM8004_SUBTYPE		0x0C
+#define PM8909_SUBTYPE		0x0D
+#define PM8028_SUBTYPE		0x0E
+#define PM8901_SUBTYPE		0x0F
 #define PM8950_SUBTYPE		0x10
 #define PMI8950_SUBTYPE		0x11
+#define PMK8001_SUBTYPE		0x12
+#define PMI8996_SUBTYPE		0x13
 #define PM8998_SUBTYPE		0x14
 #define PMI8998_SUBTYPE		0x15
+#define SMB1381_SUBTYPE		0x17
 #define PM8005_SUBTYPE		0x18
 #define PM660L_SUBTYPE		0x1A
 #define PM660_SUBTYPE		0x1B
+#define SMB1355_SUBTYPE		0x1C
 #define PM8150_SUBTYPE		0x1E
-#define PM8150L_SUBTYPE		0x1f
+#define PM8150L_SUBTYPE		0x1F
 #define PM8150B_SUBTYPE		0x20
 #define PMK8002_SUBTYPE		0x21
+#define SMB1390_SUBTYPE		0x23
 #define PM8009_SUBTYPE		0x24
+#define PMI632_SUBTYPE		0x25
 #define PM8150C_SUBTYPE		0x26
+#define PM6150_SUBTYPE		0x28
 #define SMB2351_SUBTYPE		0x29
+#define PM8008_SUBTYPE		0x2C
+#define PM6125_SUBTYPE		0x2D
+#define PM7250B_SUBTYPE		0x2E
+#define PMK8350_SUBTYPE		0x2F
+#define PMR735B_SUBTYPE		0x34
+#define PM6350_SUBTYPE		0x36
+#define PM2250_SUBTYPE		0x37
 
 #define PMI8998_FAB_ID_SMIC	0x11
 #define PMI8998_FAB_ID_GF	0x30
-- 
2.37.3

