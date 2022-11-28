Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BA763AE9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiK1RMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiK1RMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:12:37 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8863A2E2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:12:31 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q12so7033936pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmcuJx+hS1T9qhtpcJOi+eJWPy+gkUKUxaKu1vFLbxk=;
        b=p57cQwVbsFApF9FhaVnLhcJ/q9VykmeJ9HPdd5SrVTabfW5NB4k3L1wujTfh40lWvK
         tVkeY+MoDW7ALSl7oH6HIACe7ES7WqKDoiUFo23auAkW3W5uaEhbq97FFeJWXWKKhvDy
         Glx9zWBU9Y13E4hqTwA9PtQCVkgf4xYiRq1uAn/cPy1EWt1aiR9OBIAm1Kf/kRzoRsUZ
         hzFx3aHrbwEkfz5c8RfAbWWcIQNwAIeOXmvsZxQLud3/aKR9xQTcUTE36Okko0qZWV3c
         TnR2+DgzeojfuQYTWvGk1IvxzzZY7id4ODiaGvv6iFi4KNs5QZZpy0BgpbpZd3P43GCS
         FxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmcuJx+hS1T9qhtpcJOi+eJWPy+gkUKUxaKu1vFLbxk=;
        b=l5T291OHgcm6WDxjmsz9/5tgWbVLswJhElrCcyr9P8G5+LduphVCdNa3Hr1u6Qu+OD
         Mn2xOVzZO240jnnKyhjw1hjrzb32NMXGy9ja0SezAhY49bpODEW2BirZgyEthjHZCwCr
         i33d5HqII/gwooE2qIwPuWpZSVMtgTUA1PNIGtRyxTs8KRPL5etUOGo7fuGcPT5ZetDB
         Y4iIa9qalPfv4EPNowGT4cVSb6TiwAiS9p34/C2zZHuS+IZCpWRbkgltdbSkqS8kunJx
         o+WwarGL6SzfZSaitVP2pa+xfKB0ccDdRY23GWwwLLS4dycQvu4E/ydem8eFcLhAw8mg
         9E2A==
X-Gm-Message-State: ANoB5pkNeE3eUYf8JU//cSfnpm6L7rAKnsg9gk3ydF7uKADzKzleJdhS
        +ebomxLGe9D7m1ziag91ddjY8w==
X-Google-Smtp-Source: AA0mqf5IoIazwJNhz8ynIjK0P9b6sppO3BDUo6lpt+/yy/98in8iE50/s+AVMa79bTjhVLBBQMcC5g==
X-Received: by 2002:a63:ff0b:0:b0:477:362d:85d3 with SMTP id k11-20020a63ff0b000000b00477362d85d3mr28167728pgi.395.1669655550676;
        Mon, 28 Nov 2022 09:12:30 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1f3b:2d41:78ce:bf75:900:30f])
        by smtp.gmail.com with ESMTPSA id g16-20020aa796b0000000b005385e2e86eesm8564908pfk.18.2022.11.28.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:12:30 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, agross@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, me@iskren.info,
        konrad.dybcio@somainline.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sm6115: Add geni debug uart node for qup0
Date:   Mon, 28 Nov 2022 22:42:15 +0530
Message-Id: <20221128171215.1768745-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

qup0 on sm6115 / sm4250 has 6 SEs, with SE4 as debug uart.
Add the debug uart node in sm6115 dtsi file.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
- Based on linux-next.

 arch/arm64/boot/dts/qcom/sm6115.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 0340ed21be05..e4a2440ce544 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -649,6 +649,26 @@ ufs_mem_phy_lanes: phy@4807400 {
 			};
 		};
 
+		qupv3_id_0: geniqup@4ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x4ac0000 0x2000>;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			uart4: serial@4a90000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0x4a90000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+		};
+
 		usb_1: usb@4ef8800 {
 			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
 			reg = <0x04ef8800 0x400>;
-- 
2.38.1

