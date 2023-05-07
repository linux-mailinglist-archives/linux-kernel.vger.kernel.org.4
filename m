Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAEE6F9B65
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjEGUN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjEGUMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:12:55 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B239EDE;
        Sun,  7 May 2023 13:12:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ac733b813fso42086901fa.1;
        Sun, 07 May 2023 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683490372; x=1686082372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u8P14mQesgF/yS3lyxCvRvfSHt2uYAAYsCYWXmPYYc=;
        b=MSGi+cYfomUIPfoyJijMI0SpN3TLmSe5LhNzWjotVvq5Bomi27gj9OaDX+hQ5gaKNq
         PDFHCs2Gs+CHEjZkys6Ml1HcEs1SU63F5YHPS/ya8iZ77M/34wdrhgFcrUA6BMsGFJQ5
         xgKn0geyABzuGBjAY85/vqf3ltcvfWoX1naS33VPsvrQo5i4zS50m3t7b+fyOru0QFlM
         qfgxl//f6FwRZ/5ywtYnkMGD8kwJqVCr/qEfBJaXtNntqwslFjb2MHyDSnBpoyIaSZ4T
         BrcN4Ty+shvPnDs80RQpPugxVTHbqdnjJb73Nlhz2HEhYcfK9VjeDRqSFos5YIajNQXH
         vZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683490372; x=1686082372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u8P14mQesgF/yS3lyxCvRvfSHt2uYAAYsCYWXmPYYc=;
        b=ewasgpbhRCIQDKPbLyc5c9oQUESVaJ6d+h4fDLI7PMDZZANlFtJHDi6Sh3Auz2xdT9
         KORFWESFD+TXT0h4c7UP1FaMbISGQFo7oJ4yzTSbOMIzRJLuO4+i5jRYooHEz10WKqgB
         G932XT+kwfUpRHrZklFYvwOEoLSLlW/14DTw+urbga1M/ylUGW5mXbIrp2fXOh81D8E0
         fuMztKYPybdS0i+tQSmdgW3ro+qE/N1ilnWSauEw6vxR0wFM+xvFf62GLkBp84o4b9zQ
         hzpFOMzTuh1nXvcnWX9NNW9WA+oaal2OslQtv/KIRCR8V6O7nXkxXIxsCGsvd5wG8czi
         8y6Q==
X-Gm-Message-State: AC+VfDy0DrUC4dJuMULCZ0ZMpICDG9TBKIDAqi6d7T+M8vN+RYkVSq+4
        dW9F2//AKQohVCwTxWqDPliUGLnAlNCIDw==
X-Google-Smtp-Source: ACHHUZ5v4FpjtvLYbOWiaQd6OYDc7MCvhD/ZSjkVMStTZQF1la/IT8BUj03tbvnYbHdBbI+N66XQ7A==
X-Received: by 2002:a2e:b010:0:b0:2a7:b1db:7f42 with SMTP id y16-20020a2eb010000000b002a7b1db7f42mr2011601ljk.49.1683490372123;
        Sun, 07 May 2023 13:12:52 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id m19-20020a2e9113000000b00293d7c95df1sm918031ljg.78.2023.05.07.13.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 13:12:51 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] ARM: dts: msm8226: Add qfprom node
Date:   Sun,  7 May 2023 23:12:22 +0300
Message-Id: <20230507201225.89694-5-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add missing QFPROM definition for MSM8226 SoC.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index c373081bc21b..c34b8f3139ae 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -505,6 +505,13 @@ restart@fc4ab000 {
 			reg = <0xfc4ab000 0x4>;
 		};
 
+		qfprom: qfprom@fc4bc000 {
+			compatible = "qcom,msm8226-qfprom", "qcom,qfprom";
+			reg = <0xfc4bc000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		spmi_bus: spmi@fc4cf000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg-names = "core", "intr", "cnfg";
-- 
2.34.1

