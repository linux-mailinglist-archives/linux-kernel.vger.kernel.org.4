Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8FB6C4EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCVPET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCVPEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:04:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6BB51F8F;
        Wed, 22 Mar 2023 08:04:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a16so14425541pjs.4;
        Wed, 22 Mar 2023 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679497452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHU0HsyJm0uRZ/v35nRkY2WdI6p2u84hWJcGCxxZr6w=;
        b=aQAebmkyGJdZuOqhn4m/gthtL2uPGC89WiFlRU46UpV3Tbp/Y6H5xe+gyHVPoFlvsC
         CzRclM9jE0wxk/C9ZnptVtkxDHv5SGLzWSbtGdsUf0FAHr/+TB/J7BoRbnpKAIbPUosg
         hT10cAj1+72vktXWTW3St8j/bJBWtrD+R/dbszuBo0Itj2o8n0BSyGsRnSyVWU262axg
         Cnb6OS7B1M4px03DbwHIFLo+28O1kYKZePeu4znH+K8u31FntmQ6FUXTryvc2wcoW1NJ
         iyIIqR/4slsJZvEwcfGptLjtvN63zOjSemieNVmkM6slM8levMHKSifK55nHcLvjoy3C
         bTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679497452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHU0HsyJm0uRZ/v35nRkY2WdI6p2u84hWJcGCxxZr6w=;
        b=m4JK8RRPDi2epr4yp0WhVsoculC9GmgyTMrypuWKtgjf4XOlAUHJ7ui8Yt1B+4KWHa
         cywkPrg9TwYrRrmPOxQF73TiyoEVkqM587PGV/CJI/oTZSOEh8GofC45X0SPNuN4+R9b
         QeK/TnJ0Bnxjx2ykcH2zbWLKHnAi4efOTpEdWg/c5MHQCpfiYTm9s6k1We7M+975/RBx
         QParJvTJRNXp/icAOIUu6hoC3UXNOsyCZNiJzIjQj9h8Hm98MQfFzdbLKkIXjXOm+rDu
         r1XtsB9q9OvgLhV+C+V2HJeUimSUMX4OO9Kanc6YLFSWJRAPmoxdtSH3N2JeYWTEEaQH
         kBJA==
X-Gm-Message-State: AO0yUKWuclgQZgfDm+XOuNoID0V3gu1YTUqNyvl9gnvAC1nVUjqPbaix
        MFtMRRjgFkgC9OJXeD//6aj4PWkW/x8i9w==
X-Google-Smtp-Source: AK7set+o2YAjo+pfJBFxQ0IxHkNQ3m5fluTLlf/E0doKxtzfALOs5PyR0FKeDHxJtk5S4v5ePT6rYQ==
X-Received: by 2002:a17:902:d413:b0:1a1:a44f:70ed with SMTP id b19-20020a170902d41300b001a1a44f70edmr2369452ple.61.1679497451565;
        Wed, 22 Mar 2023 08:04:11 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id o7-20020a635d47000000b0050fb4181e8bsm2761238pgm.40.2023.03.22.08.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 08:04:11 -0700 (PDT)
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
Subject: [PATCH 4/4] arm64: dts: qcom: sm8250-xiaomi-elish-csot: Add Xiaomi Mi Pad 5 Pro CSOT variant
Date:   Wed, 22 Mar 2023 23:03:20 +0800
Message-Id: <20230322150320.31787-4-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322150320.31787-1-lujianhua000@gmail.com>
References: <20230322150320.31787-1-lujianhua000@gmail.com>
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

