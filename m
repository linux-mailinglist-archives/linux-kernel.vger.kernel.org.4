Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3568A6129AC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJ3JoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJ3Jnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:43:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D6D2CD;
        Sun, 30 Oct 2022 02:43:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v1so12075378wrt.11;
        Sun, 30 Oct 2022 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCaawyBqfgsSQQPLeFhjKLoWGWwW825SCxtEnDB/vgA=;
        b=oaNpZ8nlWiY81F5st1Bl7G7jOkW8+3HUZvg7v0RGUvU9S3c7WbmcDUN50bBZ7Qc9tl
         Vj2LYTmAD0EQwJhZJDmR5VtHRET/TGeRoBC5cx2aO1MIy9Tc045H13rfu48ED5xTsPUK
         x/IqjG0LtKv7Ud0sFhEdFvttUvjXp+0FIx+Uz4Pcj6CZjB2c7sDkoaq1yt3I0NFHOf6Q
         vYV7dqK1UEbNYZwL5TyYB2t5BMEIpowrMsr7NAR+K5mySz8gp5Db/lKK7uxFPWfSbwC6
         3raMZIJftSxyz3zHKjmUD7okJcUkFrGMPsEh2/ZxasXAFro3Oz6yWYPce1gua0E8/JXg
         20ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCaawyBqfgsSQQPLeFhjKLoWGWwW825SCxtEnDB/vgA=;
        b=xGDbURHj/u2Q88perZAvoEo1TMqyGnfHRc7V/z0SLx0feC2Mk3SHuIbZiG7t09/a8b
         FaOhwygOfCQ4HtUyjUm/2SD6UsiNdC/Qg7/yl5ycTrA/aal6ff0Gucc9tVN187y/ErUz
         rv0wjTRVfa+jlvcUCQqiyI3E6DOHbLns73yT0QUcclIRIUJ12CZ6Dw8IAVlPqHWW5BUG
         U+CO3UhOmtOVzyEdnXq99vOVjawLY8e7vFWaWXZrBA0VEEvRosaD4wKFgKF6HkLPa73P
         R3Fu/NL165ArnHZvpqrd6jZ06wczJa7ryYIdZDsAFmCisfXloUXuRSVepR59Yq6PmxGO
         /UGA==
X-Gm-Message-State: ACrzQf3NRc1xSbg6FGLELKc0FltaCa2UeF4AEUkoGnOFNgmZtHhcFhDW
        RW8xw7uwrChuuXUcVqa6bwg=
X-Google-Smtp-Source: AMsMyM7nFMLuRXxH4hXWqIrD8Udj2MnArxYn+zO2ypa3DJ//D97K7JHOkOFDzs+wW+JvcLHWIZ3maw==
X-Received: by 2002:adf:f84c:0:b0:236:6e52:504 with SMTP id d12-20020adff84c000000b002366e520504mr4355358wrq.564.1667123006668;
        Sun, 30 Oct 2022 02:43:26 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id ci8-20020a5d5d88000000b0023662245d3csm3716041wrb.95.2022.10.30.02.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 02:43:26 -0700 (PDT)
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
Subject: [PATCH v5 7/8] arm64: dts: qcom: sm4250: Add soc dtsi
Date:   Sun, 30 Oct 2022 11:42:57 +0200
Message-Id: <20221030094258.486428-8-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030094258.486428-1-iskren.chernev@gmail.com>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
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
2.38.1

