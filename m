Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9677311D7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbjFOIMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbjFOIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:12:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568252711
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:12:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b44200367bso8985111fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686816753; x=1689408753;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXHAHxT0fSFKwPz8USPdRUjyOKNtgSSj4cu2Ek48kiU=;
        b=FsXr00BzaUu6FoM8vbXU5zz6kDx18Gl1FZnk/y2K3UL0Ns6x8g4tHH0hhK8XjlnQ2G
         1IjWRyb4ugk0KhL9Vk3Yo+HFuxQxeIsid42oNzFh6Sa+WJZQKsWUoyna/MB977DRbfS5
         zb2x4L7w/uM4Gf1UK6DwBu1cjWHSMhvwZnshKeWdiRcdyvKlZPki0DBxFbnkZp8Vc5et
         Swgm8deIcJp+vtuknr/AR7bm34gdyEjTBMo27Cjc6SKlckTPBC5lPfprgYnMlnW0HwJO
         0IDxSYZUMf/boygaehaTpHoifhS8wYzkReMqmh6nFZZgPXTujJqdHTkyDjlppuJsk1dB
         wGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686816753; x=1689408753;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXHAHxT0fSFKwPz8USPdRUjyOKNtgSSj4cu2Ek48kiU=;
        b=UC/5hpad54mOdxfGyxzc5Mrce3ZWTEKBLeOpw68NOt8TW377v1rV9cjth9IZVWh9Xt
         NbfBlqPq0X7i8/yLYMPs1Fib2DzqBoUXmKyW0npBJDKOi7mgE1FckEWah56bugP8U+K4
         k40PJndmBP/wizj/nd5rHQcOuF2v1uzQ8GTFcixkAOIGrSmf090LCSymbx320ZKDEsTv
         Na3wj1P5UwltVzyZatNHKYQPNPU5zZdG1hg489lI1HOpLzgt38qygPIMfTtAMPo07iml
         MPmZs/P3h64JqtM44ddhQwBo2Z6I5AEgmYIDauZMgdO/l52isHqrD635RmnoADSUcwIb
         z+Dg==
X-Gm-Message-State: AC+VfDyAcaEI28b1jWkCOMskPQXeE9d9LYDDY6HexJpSnL81WcdZSyw4
        9rUtJN8odcVvGqrwLreoLCDUXaZ9i00XpBTh3bc=
X-Google-Smtp-Source: ACHHUZ7JViREJp0GaNcUM5T5EotUUtT5SqOTBmGhByu0POE2CgRtnw6zT8PSXaWmbQ5btWJS4KuQug==
X-Received: by 2002:a2e:98c7:0:b0:2b3:3791:da84 with SMTP id s7-20020a2e98c7000000b002b33791da84mr4624975ljj.18.1686816753585;
        Thu, 15 Jun 2023 01:12:33 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id n23-20020a2e86d7000000b002ac78893a9csm2967788ljj.72.2023.06.15.01.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 01:12:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 15 Jun 2023 10:12:32 +0200
Subject: [PATCH] arm64: dts: qcom: msm8996: Fix HDMI node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230615-topic-8996hdmi-v1-1-39584bfd68d2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO/HimQC/x2NywqDMBAAf0X23IWYYND+Sukhj7VZ0CiJiiD+u
 0uPMzDMBZUKU4V3c0GhgysvWaB9NRCSyz9CjsKglTbKth1uy8oB+2GwKc6MnVajV8ZHYwNI5F0
 l9MXlkCTL+zSJXAuNfP4vn+99P196FEF1AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686816752; l=1335;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=B0zAEhAOtxhBKwa6WdeY39jiC9OWe6ZFvix/v/r5+8g=;
 b=k6zheu77ykuYvYHutzF8ykADAoZ1HN7rlbDGznP0DYTtmlQG6mnnqeugNjELuA5dXJp4ZVfyt
 MMbRy6zr2pMCqVshRidNQOitZewId0z4YWPiu5Y8cGQFJgoxkzEYOE1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit messed up the node name and compatibles. Fix it.

Fixes: f43b6dc7d56e ("arm64: dts: qcom: msm8996: rename labels for HDMI nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0cb2d4f08c3a..40ac0a784a4a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1136,8 +1136,8 @@ mdss_dsi1_phy: phy@996400 {
 				status = "disabled";
 			};
 
-			mdss_hdmi: mdss_hdmi-tx@9a0000 {
-				compatible = "qcom,mdss_hdmi-tx-8996";
+			mdss_hdmi: hdmi-tx@9a0000 {
+				compatible = "qcom,hdmi-tx-8996";
 				reg =	<0x009a0000 0x50c>,
 					<0x00070000 0x6158>,
 					<0x009e0000 0xfff>;
@@ -1180,7 +1180,7 @@ mdss_hdmi_in: endpoint {
 
 			mdss_hdmi_phy: phy@9a0600 {
 				#phy-cells = <0>;
-				compatible = "qcom,mdss_hdmi-phy-8996";
+				compatible = "qcom,hdmi-phy-8996";
 				reg = <0x009a0600 0x1c4>,
 				      <0x009a0a00 0x124>,
 				      <0x009a0c00 0x124>,

---
base-commit: 925294c9aa184801cc0a451b69a18dd0fe7d847d
change-id: 20230615-topic-8996hdmi-520fb03bd36c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

