Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CDA648E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 11:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLJK0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 05:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLJK0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 05:26:14 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C02218A1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 02:26:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 1so10843306lfz.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 02:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VtLJNDu+OcXPIw8jTOxpwXv8sktDAvQVvTt3GUvBQb8=;
        b=EeqEI9z66oRr6x2wHZFZ5qBrARJNGjJFvItHPRCHkOfiqXE0UZYXGWWriTMY38G6KP
         zHs7RH35l8oT75tuRbtzMC+SkZeIqxDlgmym8qk5RsT6jZwl+zFrC4MJWT9GiZCq2eeK
         AaHqbaa4gJaVCtIu/e29DSGQ7h1PkkWW+rzAU92o8ftToCSjRI+bXkhC/a0mylhrR9u2
         8YUCPCKJm5PnyllM7CSi83wHb30JYY1OI43L4ITMQGSMLoLUYGKBzISt1y0xCTQI/Qas
         6f/RksuoffvznEehPhbNTd1GOjk5AtgRzh+mu1/phimoaFVOQqUQUBGKmDz75YjzycCi
         9IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtLJNDu+OcXPIw8jTOxpwXv8sktDAvQVvTt3GUvBQb8=;
        b=r+iOWT4phvwqarwS7+JfF+zia3EepCkkeGBsIkpqQpiWrXATRI+XPT+ZAWFnsxQEyA
         aaYuAX9XLwcray9K2RTf+YLQ0TOjSb1XtN28qejbnOGUaFMx1NZQ+EwdtQIsk26amjux
         9bNrzV0750h370hUR9/3xwdl2+g04JnNKDq7IkaDGTHBS2brZm9U/lFJHypr8gZ8TQ1l
         tWtSiSYYohC1QKq4uBx4FSvi1a9fn8cMl8CW0ZBtlyOZtIJkTr1tStHoqfKfOu3PtKVF
         83Wuy/bfYysj/weZDAbr7njWSHRW1yD02L8nE4iXyzoM5pEZf8yIX+53ypyMqL9Trvfp
         7ocA==
X-Gm-Message-State: ANoB5pk3XOZf8lTlY+nFCunFcBT1lMnwTKAC2iG4LHBx0j5ktg240nDF
        9O9wR7ledylfZWJdmJkOpRa5aiUvsTvmrAIK
X-Google-Smtp-Source: AA0mqf6J3YQDAOpPlFae5H80QTDe2s6nxrZKvhZ0wS6Uer1nbjq+KtLf05a0mU8r7EaH4aZkQINmOg==
X-Received: by 2002:a05:6512:23a9:b0:4a4:68b8:f4ef with SMTP id c41-20020a05651223a900b004a468b8f4efmr3521377lfv.53.1670667968588;
        Sat, 10 Dec 2022 02:26:08 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id n6-20020a05651203e600b004b58fadba35sm656049lfq.296.2022.12.10.02.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 02:26:08 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm6350: Fix up the ramoops node
Date:   Sat, 10 Dec 2022 11:25:59 +0100
Message-Id: <20221210102600.589028-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Fix up the ramoops node to make it match bindings and style:

- remove "removed-dma-pool"
- don't pad size to 8 hex digits
- change cc-size to ecc-size so that it's used
- increase ecc-size from to 16
- remove the zeroed ftrace-size

Fixes: 5f82b9cda61e ("arm64: dts: qcom: Add SM6350 device tree")
Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 567f4893c562..b8e03efc44a7 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -344,13 +344,12 @@ last_log_region: memory@ffbc0000 {
 		};
 
 		ramoops: ramoops@ffc00000 {
-			compatible = "removed-dma-pool", "ramoops";
-			reg = <0 0xffc00000 0 0x00100000>;
+			compatible = "ramoops";
+			reg = <0 0xffc00000 0 0x100000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			ftrace-size = <0x0>;
 			msg-size = <0x20000 0x20000>;
-			cc-size = <0x0>;
+			ecc-size = <16>;
 			no-map;
 		};
 
-- 
2.38.1

