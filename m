Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F8765AF09
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjABJsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjABJrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:47:06 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A098277
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:47:01 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 1so40906531lfz.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVRIy4Z7io8ef7qUE0WXQIjTtlQgH4sWiqBK1MsuhVo=;
        b=wADF0x+/+xa7wdcbseOS5QOrfKBMURDPE+uAnRgc7ecFxYSUtxNYwdtJACOUKNMHzg
         UiKQAKsnixs8vPCMYHSznMlrzseGbdEn2+o15mGjA0fCptBTXcsVwHubejNCVtVrvy9x
         XNreQ2adSZOpVX+/L7a+s6yiunfOzBRRUTkbFpIVjjlo8ybmTAuWLy7KD+baKyOF63Gs
         ZImfuOBYICb3Aamebc1MR1Qpx67kt9XksEU4Vm7g6ZPNHQl1sgGPN95V9LC7qtzi166j
         FxpSpqS+7XfWE3ROi1JP19y73TYW2wb7elrNn1abT+BoQAU1/lA/jvKN7yS/s7VUzA5L
         PWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVRIy4Z7io8ef7qUE0WXQIjTtlQgH4sWiqBK1MsuhVo=;
        b=OaObJIH/0GsLueDVyUR5s3GT8eRyU1UPflswVXlKf9rH14HZb7e4hVfp7ZgXZIRyq+
         WQT5x2WCwffYDFpQKCJdHxmxW4fEj6f66eCHvw7bQhuX20mcDc2myVRDYI0Roy5Xs0uF
         eTMTrewl1kmetKfhfkfySLQq2c3dbwuxq3znQ6aS9ixBvuhTB98Qpe+AzIatO9asXewe
         dlV8sDliey0z+SYJ7J6ZReoFsrFMivBdbXQq56Qb/XoKCdF7oS5aa9qzNhXR50Xbxp+2
         l+oBRU4ri/FSi17tbHONZilDJd+ZZBeE48mEbGTi38bisQuo7ZxMYnVvs8Pob738VpiF
         2xyA==
X-Gm-Message-State: AFqh2kq+uJE+Ssb5QpDMaUWZ80/+O6ThQz0sP9SVfgrxRUH6Fq7K8Tgh
        S6mFd/ZBQCeKbGwLsJqMoPnFQQ==
X-Google-Smtp-Source: AMrXdXvEAsWw30mhLlqKnaKxCijkrYNpTW8jiZyCtOwzVhbtC2SNqjeo+tWFO+f5GheeY0IMcdUQOg==
X-Received: by 2002:a05:6512:340d:b0:4b5:69f1:61b1 with SMTP id i13-20020a056512340d00b004b569f161b1mr11597173lfr.42.1672652819783;
        Mon, 02 Jan 2023 01:46:59 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x11-20020a0565123f8b00b004b5adb59ed5sm4382143lfa.297.2023.01.02.01.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 01:46:59 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/17] arm64: dts: qcom: sm8350: Pad addresses to 8 hex digits
Date:   Mon,  2 Jan 2023 10:46:36 +0100
Message-Id: <20230102094642.74254-12-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230102094642.74254-1-konrad.dybcio@linaro.org>
References: <20230102094642.74254-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some addresses were 7-hex-digits long, or less. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 arch/arm64/boot/dts/qcom/sm8350.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 067613ca9c03..5f191ebbf724 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1598,9 +1598,9 @@ ipa: ipa@1e40000 {
 
 			iommus = <&apps_smmu 0x5c0 0x0>,
 				 <&apps_smmu 0x5c2 0x0>;
-			reg = <0 0x1e40000 0 0x8000>,
-			      <0 0x1e50000 0 0x4b20>,
-			      <0 0x1e04000 0 0x23000>;
+			reg = <0 0x01e40000 0 0x8000>,
+			      <0 0x01e50000 0 0x4b20>,
+			      <0 0x01e04000 0 0x23000>;
 			reg-names = "ipa-reg",
 				    "ipa-shared",
 				    "gsi";
@@ -1731,11 +1731,11 @@ sram@c3f0000 {
 
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg = <0x0 0xc440000 0x0 0x1100>,
-			      <0x0 0xc600000 0x0 0x2000000>,
-			      <0x0 0xe600000 0x0 0x100000>,
-			      <0x0 0xe700000 0x0 0xa0000>,
-			      <0x0 0xc40a000 0x0 0x26000>;
+			reg = <0x0 0x0c440000 0x0 0x1100>,
+			      <0x0 0x0c600000 0x0 0x2000000>,
+			      <0x0 0x0e600000 0x0 0x100000>,
+			      <0x0 0x0e700000 0x0 0xa0000>,
+			      <0x0 0x0c40a000 0x0 0x26000>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
 			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.39.0

