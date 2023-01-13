Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0D668A11
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjAMDZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjAMDZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:25:40 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0970413D01
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:25:38 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y1so22186065plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yWM9xiWj0MDQWf+13yvBO0xsCa3YE6cBbf88bv0xKGo=;
        b=mmBXkG/LSqvEPp/oud0jjzcfAcQK9A1EVzIN+KuMHROkzbXneuRSvT4e+2RNZB5fmA
         pQhGOD9FhjoVtQzP3KGi206ANhdJB/HTBUWZouaXaHqpzgBR0WnZAE7sAL97U5/guxa3
         GWuEGpXdjVdbIsUK4QMH+d/oGpil7EfgQ97v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWM9xiWj0MDQWf+13yvBO0xsCa3YE6cBbf88bv0xKGo=;
        b=NLIlM3ZP4i6i787d6QCz+Tyx6IF7er0OZWIGEOskMZwqi8KJirojlLC3ZZzq9OhXaY
         mKJ3gKfgFbtuYINk7esJAEhxKWXOrtxOMd3o8aL+X5xy5HO9Uc4RJ1FjUAtKl59BoNAj
         f8JxKTmuPQc/nOwtVdheQOraIcrx99VanOQtD90KVcwn4Fpq/8c3u7RIuYnehtlT4sZs
         9fF0A3vf2o+Rn0GmnzGPz4lSOLD2qax2ik4QEcO2pmCytylUl0ND3Ga87ySwFhYmfnxX
         eUwAqAjslC6WCEymoHJVW9eJR9J49mW+/QzX/3HsqL/vjmRQab1iOFU14+zZcIKDQNwv
         lwow==
X-Gm-Message-State: AFqh2kqxsiUlcbRAt5cf17PGXQIlbGKtW0F3/JTB5Jlq3cJqRVh93puk
        HxDrw1yganRN6QKVoYeNl5zRMA==
X-Google-Smtp-Source: AMrXdXteN4EQNWVjUzcqIIa8750bkO0vLIuJOV4mCsxDWyWFHhvIj+daEShB5XYfiDU/YgV0SUnvSQ==
X-Received: by 2002:a17:90a:5903:b0:229:11ab:4ea8 with SMTP id k3-20020a17090a590300b0022911ab4ea8mr3097656pji.36.1673580337564;
        Thu, 12 Jan 2023 19:25:37 -0800 (PST)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090a684700b002260c751b00sm1870588pjm.23.2023.01.12.19.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 19:25:36 -0800 (PST)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v1] arm64: dts: qcom: sc7280: add display port audio
Date:   Fri, 13 Jan 2023 03:25:10 +0000
Message-Id: <20230113032510.749804-1-judyhsiao@chromium.org>
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

