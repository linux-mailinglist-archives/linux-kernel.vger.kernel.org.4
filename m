Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AEF6C5224
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCVRRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjCVRQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:16:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE2A66D3B;
        Wed, 22 Mar 2023 10:16:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j13so19137424pjd.1;
        Wed, 22 Mar 2023 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8/bCbySa6Y+JFGYtvp1Vp3ADJdTcdhTwLsnAC9TgiU=;
        b=It5mOVay9GTCXNVQ2m5nIdFleNObXvjEHT0+bg9UolMHNwQeh/pxPTboG/gCXhArIR
         xrOZOQes9jXubxtryfOpSHXMeBky+G5IbmGTpzgnIaF/THG/WSd7kyZnuo03aCSnDAw5
         QBv4DQ+xXx/pnPynGxXi48crA4MVHfVfm2niLbu2RHXbNfrC61dQT6zE42iPyfaMolLm
         P6tVSXL4d4wjxbQgTISTKowGytVGi8Z7d12riY+YsM5e6gjfi5gxobKqW5vXvHym/rU5
         YK6QpwjgfH7X1icZsOIWsmvLhe4H91r6dJlRwzq9FMA0OfqEwnyDI9jtblzbPyjDSmuj
         cx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8/bCbySa6Y+JFGYtvp1Vp3ADJdTcdhTwLsnAC9TgiU=;
        b=8Q7H6X+VQ7qov1ZitYLvnYjaVffTBLRqNKV2v+zVBP3pGV2ZzyGCJn/6Ws7sNysVFm
         HzCzdT/d+jhSTITzrETT10UeHzE6B59R4sdBNYcxHGinFg7kbQPwBajPlolKF4rNP5ja
         sQO0ZTuuA9R4COWSRBWgFqHvCyKdo3Ttl3JZDk1UG+qSUOSMo+D65DdH4cPiWcOUmIys
         PAklaMSdHiiq6mcaVvym43hMVpRpQXofydGhnRCa/Jn+aW+uMsBaPHOF4rdF483D4SpD
         69JAOAVK2c3hsY36S1xBRjPwKZf7SeeDkfefAcP+UYfPWe8wDZ1s/sTSwfmpJmtDmxGk
         o5Gw==
X-Gm-Message-State: AO0yUKXkCCbX53OSnJ2tn3cGXTjVRpD1wz2Q8EMlmWZG4yx6jji76lRA
        1xrYdBkAxaSmOinVkWIHNYVuS3zKlQMBCw==
X-Google-Smtp-Source: AK7set+3bEktTgqvQm+E4DjNEvKILeBPrbl8cAgaC2Pb/SKuM/UmQuURMwyGE4y3uz7gZMUwD30Zvw==
X-Received: by 2002:a05:6a20:8b07:b0:d9:e45d:95d6 with SMTP id l7-20020a056a208b0700b000d9e45d95d6mr244831pzh.35.1679505377247;
        Wed, 22 Mar 2023 10:16:17 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id b1-20020a6567c1000000b005023496e339sm10097353pgs.63.2023.03.22.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:16:16 -0700 (PDT)
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
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add Xiaomi Mi Pad 5 Pro BOE variant
Date:   Thu, 23 Mar 2023 01:15:54 +0800
Message-Id: <20230322171555.2154-3-lujianhua000@gmail.com>
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

Add support for the Xiaomi Mi Pad 5 Pro BOE variant. The BOE variant
uses BOE Technology panel.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
  - Get rid of sm8250-xiaomi-elish.dtb

 arch/arm64/boot/dts/qcom/Makefile              |  1 +
 .../boot/dts/qcom/sm8250-xiaomi-elish-boe.dts  | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 8d2b3c57a4a8..808f46947661 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -183,6 +183,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-boe.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
new file mode 100644
index 000000000000..8b2ae39950ff
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
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
+	model = "Xiaomi Mi Pad 5 Pro (BOE)";
+	compatible = "xiaomi,elish", "qcom,sm8250";
+};
+
+&display_panel {
+	compatible = "xiaomi,elish-boe-nt36523";
+	status = "okay";
+};
-- 
2.39.2

