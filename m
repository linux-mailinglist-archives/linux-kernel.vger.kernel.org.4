Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813AD5BD47F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiISSHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiISSHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:07:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2673446220;
        Mon, 19 Sep 2022 11:06:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r133-20020a1c448b000000b003b494ffc00bso4676136wma.0;
        Mon, 19 Sep 2022 11:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/9YZmDceaOqNhVZNEFygZUGa2iV0nk+IK9yxr96vC24=;
        b=WiXfydCDHDmO8jOqYZ9Olzvxo+yQLc2OyxltyPIi07Gw30S89JewVeLdnUaOcsGFmR
         E2C+LvoU9Ikl3yNYzIwbDue6msAxo13XuZlfRyB6V5jdZyrohA9OwBfnMSk9CAqine2f
         JthWGj2KPRvP+GEbZxHGeHSgFIp2OBWTvMeE1qYpaFRqdYVT/b4W1yubpBq0moRUEbPb
         /SjXA2+XaF6Z4TKzdD8BYV+T572bjzSpd6gwx6IF3thwwhF4v+ErTXbzfoZD6pXZncNU
         vFTyMuvmfla+NbwQ8cg+cVBSS7w/g4WVxmAKZQiEKtWOJoASkH6zktn6UI6r5+UuAd5X
         oRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/9YZmDceaOqNhVZNEFygZUGa2iV0nk+IK9yxr96vC24=;
        b=ozDFHzy2xKfbt+VvTL+zodXBJ7b8/6N1M4jKcGXgIx/OXp+DtN4IVj1XJ6HgO3CpK3
         BdyvvB+aZmfHBiONecPv4JjU21qTMn4+81ow332BnrZkWiJoGBcHDnGW9eiY+26niNyD
         6ujI0hcmyOGXNEtA+btH3a5rR4Pd2YbsFc5KHaOk5RRgUfSZDtorNGLsAHrOb6dcXdHl
         1YJMd4pEloeN99tKpEfkEB/xZ7Qpu+FQTciZ6pocBzJE3gW+aC+iTbUJ08ipNbyiojli
         xmwVrtgf+SSdcmKF8R262Hg04wiIgC3UmrHWoa/zTOZf9py9JyERpZBANtudP/koG5YL
         8UsQ==
X-Gm-Message-State: ACgBeo2BlRt9zr0e2MFSY9DjdbW9AX2jxpdlFfglqTJahro4U0bgDGIN
        bfCP8/bvzx5K2FE/oRW9Tokf2CYdvq1nJQ==
X-Google-Smtp-Source: AA6agR5zFeliH9VDM/sv4Cse3ONu102wUti6h0jr5f0xZpwCgYV7tSUWz1FCbxZVLevXgoLWd/TpjQ==
X-Received: by 2002:a05:600c:a147:b0:3b4:86e7:4315 with SMTP id ib7-20020a05600ca14700b003b486e74315mr20465726wmb.156.1663610809427;
        Mon, 19 Sep 2022 11:06:49 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b003a2e92edeccsm15526356wms.46.2022.09.19.11.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:06:49 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] arm64: dts: qcom: sm4250: Add soc dtsi
Date:   Mon, 19 Sep 2022 21:06:17 +0300
Message-Id: <20220919180618.1840194-8-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919180618.1840194-1-iskren.chernev@gmail.com>
References: <20220919180618.1840194-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM4250 is a downclocked version of the SM6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm4250.dtsi | 38 ++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm4250.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm4250.dtsi b/arch/arm64/boot/dts/qcom/sm4250.dtsi
new file mode 100644
index 000000000000..c5add8f44fc0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm4250.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
+ */
+
+#include "sm6115.dtsi"
+
+&CPU0 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU1 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU2 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU3 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU4 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU5 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU6 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU7 {
+	compatible = "qcom,kryo240";
+};
-- 
2.37.3

