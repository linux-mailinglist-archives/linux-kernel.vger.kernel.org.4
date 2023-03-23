Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7448C6C5BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCWBAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCWBAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:00:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE342D71;
        Wed, 22 Mar 2023 17:59:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u5so20861387plq.7;
        Wed, 22 Mar 2023 17:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679533197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJCBKf+gb9okOG0MhtZ0lPTIVY+22bildg0iy7cFNEE=;
        b=Q4THXcwhxMocmJOip3p1dt0QTt2PXBMh0IVbQThFqbE9Iw0ozD5A2+2Ui2F3BD4Rfz
         0zDdBXLGrSzbEPSCdOyyYpyRHLCbqVZxqj/79gbiHN9B5VjcjFFulE1+NeSp8YX+XMRD
         H8eQVTREe2XCj6I+a7uLB4QpqgjOEkJ6k91cEFCAgLCIORXMzQ6yyXaBGK3lPPNWou9n
         hJEtTjUdAj01KwL1Pmr81ECajWBblWXxD/3vmaj1sm2PNsyXOjCF399BCm68u7ztO89u
         Kggj73sEDmmA/xD5SSutMCmku1fEG1tRtMb7/1nlaZRqzRSXojZPz68ellvuM1+SNREr
         qc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679533197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJCBKf+gb9okOG0MhtZ0lPTIVY+22bildg0iy7cFNEE=;
        b=zUKYaGmE5R7EP51CGp7atRLCRICjF4fMAN6iawcPdLGcPNCHxBpeSXzOzVMg4+0fbm
         Gf3pLlNvMLmPP26WamUNYM6udxF34OzB+JHJ1rjrZFByTOFD+2nR9dWlBVjGQKBvdpru
         t+8QyPKCCl3PdhOSbArJR/3Kgt71TomDtf1pn/r2+lkOpRDhAPqXm/F0CkEuD6FX7i1s
         Dh4pV9E4WpVvdBn3DHAPgU1IwnThabj/N7T1Mj+D0wpkSLR85e8bBE7k+Qc9AmKMe6NA
         G1HCiaxdF4a1SZn0xmTL7SjMDbMaosLietq1/QUpgfJoSvAu3K7cc8UN56yPnaP3cX01
         dpMA==
X-Gm-Message-State: AO0yUKWlcVI1QzY4POX3DH0L9hxPs/knmLNa4rJTLisZ73jO2PxvC2iy
        4Z4ycqLiEfCFJsuBw9zBHOg=
X-Google-Smtp-Source: AK7set+kBEvznL2MDZDIVNOB37XhYsoHjF1884QOaStkW8xQZgbAKIpVxhNwirrqXPTPquOrzek/4A==
X-Received: by 2002:a05:6a20:1827:b0:dc:a214:6352 with SMTP id bk39-20020a056a20182700b000dca2146352mr489029pzb.10.1679533197525;
        Wed, 22 Mar 2023 17:59:57 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id s10-20020aa7828a000000b006288ca3cadfsm2114579pfm.35.2023.03.22.17.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 17:59:57 -0700 (PDT)
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
Subject: [PATCH v3 3/3] arm64: dts: qcom: sm8250-xiaomi-elish-csot: Add Xiaomi Mi Pad 5 Pro CSOT variant
Date:   Thu, 23 Mar 2023 08:59:25 +0800
Message-Id: <20230323005925.23179-3-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323005925.23179-1-lujianhua000@gmail.com>
References: <20230323005925.23179-1-lujianhua000@gmail.com>
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
uses China Star Optoelectronics Technology (CSOT) panel based on NT36523
display controller.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v3:
  - Pick up Konrad's R-b

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

