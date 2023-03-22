Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE006C5227
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjCVRR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCVRRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:17:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2774366D39;
        Wed, 22 Mar 2023 10:16:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o11so19924385ple.1;
        Wed, 22 Mar 2023 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1yrkQdQ3+rHj7HsA6aFbOnS34klVtYP6UuejOzccco=;
        b=FdEEsUfa3PpP/5KX+nodVmJ/QDYTpkGk6vjFgTQcEWYlttjVuXrZOrtxUzVmwNt2GF
         Ir2FdFN+BcYh1XaSxJP0z2qvD0SuNiQHTcTmQdm5PnaYUAmsO0YCYfDqpGNRQwksQuR1
         77Tu/+Oj5kUzS5Ox0smxHgVpK1Jds3TgxcY2oPI0smqdKopAF+ndU2XQ96pahTeSd8TU
         1EftFOKJLk5Y830v0F5IUTeZHVFj3tr5omNCs2bnWkgXYnnjM7OTAqz9N2t8iyjksvvw
         TTw9Gv+7XPvLAFJThflRTqaKZuJgc53tH9GG6u96L3bfIzbu1pVf+o3jlJc243juRYIR
         qetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1yrkQdQ3+rHj7HsA6aFbOnS34klVtYP6UuejOzccco=;
        b=ZdlxJHzuYSuwSSAwelyhCLUmbam9KcqGpDJe6MeG2T/aQpOQq8WWbe1xulfqE5T5Rs
         o3DOslrwPnolUxqo7Fr3lmaFTNgcYEg+fdV1XpjXm2dTSxUfYG8kFDx1PEBo4j3vsn2P
         GPD1gTkDcFQQZguOmmTp+NMcAksQmxkaCCmM+nyfteS6lr8KtMp8+E2EAyI1BtgXOpgK
         j1xJLB+zmaBwxgiBN329k+/f5VSbHxBhDA7zG0TnHZsCCfttzniixjc9Xv9hcx4oGdp5
         nKWg1f1mkDf9m0WddzgUbU72gNZG3EN+gH5r0Wp7eVomW4fG+TO6p9wEwduCy+csF8vR
         fviQ==
X-Gm-Message-State: AO0yUKX/4axMI0TVcAlrNBlLp1Dd88RDlkVCP68osTHckjwGigsvtNzQ
        KNItsF4n6jbxrwg0k0jV9Rk=
X-Google-Smtp-Source: AK7set+lu45jd1DtvFuWe2CYnFxa9HE3DUcqRoqsFsNOGGngMHbaXLMxO5r/GOaBx9wUKbAkbO2gMw==
X-Received: by 2002:a05:6a20:bb1a:b0:d4:b24b:4459 with SMTP id fc26-20020a056a20bb1a00b000d4b24b4459mr344759pzb.13.1679505390190;
        Wed, 22 Mar 2023 10:16:30 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id b1-20020a6567c1000000b005023496e339sm10097353pgs.63.2023.03.22.10.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:16:29 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm8250-xiaomi-elish-csot: Add Xiaomi Mi Pad 5 Pro CSOT variant
Date:   Thu, 23 Mar 2023 01:15:55 +0800
Message-Id: <20230322171555.2154-4-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322171555.2154-1-lujianhua000@gmail.com>
References: <20230322171555.2154-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Xiaomi Mi Pad 5 Pro CSOT variant. The CSOT variant
uses China Star Optoelectronics Technology (CSOT) panel.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
No changes in v2

 arch/arm64/boot/dts/qcom/Makefile              |  1 +
 .../boot/dts/qcom/sm8250-xiaomi-elish-csot.dts | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 808f46947661..b755b198cfb7 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -184,6 +184,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-boe.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-csot.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
new file mode 100644
index 000000000000..a4d5341495cf
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023 Jianhua Lu <lujianhua000@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "sm8250-xiaomi-elish-common.dtsi"
+
+/ {
+	model = "Xiaomi Mi Pad 5 Pro (CSOT)";
+	compatible = "xiaomi,elish", "qcom,sm8250";
+};
+
+&display_panel {
+	compatible = "xiaomi,elish-csot-nt36523";
+	status = "okay";
+};
-- 
2.39.2

