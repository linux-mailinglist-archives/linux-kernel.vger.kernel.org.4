Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C0A5B46CB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIJOdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiIJOc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:32:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902A652DD1;
        Sat, 10 Sep 2022 07:32:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h8so867958wrf.3;
        Sat, 10 Sep 2022 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2Bx1+OMeWpk5FA206JO5J9QwskVzDtPCBnBPUADH7eg=;
        b=ZBCkNKYldN5Irwk+FVwA4wAF9K+YNLo1QYQiHSXTwRWDciYu8PB/3JKTZza1jEHd6S
         DcMZyZbh58oZsSe2q4207IaSszxgLFH/ZdthdMaJaJ2zY/eQOC3mD+Tdbrs2kRlBkLqR
         WYAnI1vDub/mxqJozcaDH61UsMf/MwQ/FKJT7Pa5wJw6/iyx4RW8+T68BMWdrOX8fkZR
         8D0RJz1EXBLGSWUxE1fwSzBxkOfnquCpmr8Jrp6aQzcoeB1Ss8bAoxGyvwYk1RTxCKzv
         yLZLLR803S6wfy/1wwTjS3joXF9Huuhb3pez/r10kWhfwSRVJhWg10E5cIDXNpffKnYJ
         XoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2Bx1+OMeWpk5FA206JO5J9QwskVzDtPCBnBPUADH7eg=;
        b=26TP9hfATZ1I0CBiSq0zIg77RcxBZeNbvLZ7YBZ1wnK7UptS20ZtuSlYNZ2jQhVntB
         bFIf1mAuOboNdKJ5F99skMkBkQMeN8ELMMrQlwN35CG7FiTa0O9NtWVkLDopFP1d3NPe
         o53wRW28vODj5jv5wQACsr95X818EUdNZSHRc5iNOCwi0LwZWHhdAWQ3V6gZAlZgK/y6
         SMGTxP/yrKhDKeKxoiFJ2s4gazxpR/Z7cd8QR7+CIWGEiBSr/Dv/JjCt/Az2hdx9hyWv
         IZwFYVHfQVHVeKa2Y7v0S2hCVQ7+Sv/Bv6yOAJmSRC3ZWH1Ux1ydPbDCK2T7zuf49y6X
         qCYg==
X-Gm-Message-State: ACgBeo2JZsj/jYngLPeUHOuStL+EMmqmEPvna0JcdYiGkPwDAF9c6WSS
        0UQxLRWu5LMZX+yCGQn/IEo=
X-Google-Smtp-Source: AA6agR6+CfOvwRTzf8B9wENG7NwYWXxlvcEDNewiRVFrsCxW+AJ+q6ltjnZmie0BeOw5vm9i3kROHw==
X-Received: by 2002:a5d:5a89:0:b0:228:639b:642f with SMTP id bp9-20020a5d5a89000000b00228639b642fmr10492451wrb.503.1662820354796;
        Sat, 10 Sep 2022 07:32:34 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003a50924f1c0sm3715413wmi.18.2022.09.10.07.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 07:32:34 -0700 (PDT)
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
Subject: [PATCH v3 8/9] arm64: dts: qcom: sm4250: Add soc dtsi
Date:   Sat, 10 Sep 2022 17:32:12 +0300
Message-Id: <20220910143213.477261-9-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220910143213.477261-1-iskren.chernev@gmail.com>
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..8cadf813e55b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm4250.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
2.37.2

