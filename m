Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E614668C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbjAMGXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjAMGXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:23:02 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A4A69B32
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:22:38 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g23so6903408plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rh9+uqGdeUQ/uk0uBV7vpLnb1/bQZNWqul7yXMNfGn8=;
        b=FE1sUVNzVAS03UySQcPp/VF5cQb9NBEXqgalMqgL4a69J1iUYHsZ3akU0Yqh7h0EGP
         fZ+StJezbIgj2GP6Zlk2Gv0FNHHQDo6am0fxVGD062OTBzXJ+d0R71Cgkp99mmn6VdNt
         CUvVvKOsmQCQcTFK7EnTi9cfOfx0xnp8FLk9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rh9+uqGdeUQ/uk0uBV7vpLnb1/bQZNWqul7yXMNfGn8=;
        b=KbSf+Y5WYYZ1MjT7BANv/s1CewdvHqz2GAxscfW+p4WsLv93aFohjMA9M/f6nMPOc7
         yGGveZ//aVv+cp9WRyTXRCDEpJALAQ4s/e5q9O6Q22Y4yAgbPkry50vNRRE1RiiXLWbq
         Xwl3/aIhM/BvM7iLMgvRK02zKvnFELAPjVHeKqoNVfKInXt8evVNCCgPrQcxH6ujPEMS
         yffYXEncqpKN2qMxmgAJwNF0peio4fBtl49WOQIKk1Li9PfvtF5x1+Y35x8KnETYnD7v
         p/vVBC6tcbiw+O65RjaikW4pIO32wt9XtO1hSGHM1nb6oXaYPpQ+GdfUozZlIjVLepBh
         VGYA==
X-Gm-Message-State: AFqh2kqEDYrOr4nNDrXJE9Bn5OdRdcuDLX2U8pRDzsVxYrXZB3ay2oaJ
        tjA5Ebk9fsx8g1yqyOsASamCeQ==
X-Google-Smtp-Source: AMrXdXvOi3UGPKTD8KbwEvurdGPas7WtLGOQ/gQ8wYB+JIjfdTfv2yWNIVs+FiJxCZRyyTOXEWFiBQ==
X-Received: by 2002:a05:6a20:8e02:b0:ad:a09c:5734 with SMTP id y2-20020a056a208e0200b000ada09c5734mr14600534pzj.44.1673590957700;
        Thu, 12 Jan 2023 22:22:37 -0800 (PST)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001926bff074fsm13180746plg.276.2023.01.12.22.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 22:22:36 -0800 (PST)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v2] arm64: dts: qcom: sc7280: add display port audio
Date:   Fri, 13 Jan 2023 06:22:29 +0000
Message-Id: <20230113062229.774871-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DisplayPort sound node and lpass_cpu node
in sc7280-herobrine-audio-rt5682.dtsi.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

---
Changes Since v1:
    -- Fix the commit message.


(no changes since v1)

 .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
index af685bc35e10..69e7aa7b2f6c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
@@ -33,9 +33,22 @@ codec {
 		};
 
 		dai-link@1 {
-			link-name = "ALC5682";
+			link-name = "DisplayPort";
 			reg = <1>;
 
+			cpu {
+				sound-dai = <&lpass_cpu LPASS_DP_RX>;
+			};
+
+			codec {
+				sound-dai = <&mdss_dp>;
+			};
+		};
+
+		dai-link@2 {
+			link-name = "ALC5682";
+			reg = <2>;
+
 			cpu {
 				sound-dai = <&lpass_cpu MI2S_PRIMARY>;
 			};
@@ -92,6 +105,10 @@ dai-link@1 {
 		reg = <MI2S_SECONDARY>;
 		qcom,playback-sd-lines = <0>;
 	};
+
+	dai-link@5 {
+		reg = <LPASS_DP_RX>;
+	};
 };
 
 /* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
-- 
2.39.0.314.g84b9a713c41-goog

