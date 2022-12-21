Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB463652D33
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiLUHRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiLUHRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:17:43 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33BF10D7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:17:41 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so1298234pjr.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ipcTfQuvJXJtZzjg5HEFRy455uYCxwrL5LhsX06QbCs=;
        b=HjzgYbE302j8IJKIV8jpFotxChaSSuyWKlm08ccT2awBmPgN0agV+gDzFkBvyDCEEG
         avs3VtPA0gtH9xS/GzIVvSMymrPRZs6R22Z2n3EqI8TPRDqelIrjuwwaVYlMvv4s8L4R
         SCbU2WIzvxRCLuCB59Bjdi1acwb00KcPZlxes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipcTfQuvJXJtZzjg5HEFRy455uYCxwrL5LhsX06QbCs=;
        b=frpcZqICBCeHCSZw+a2EJO0jfbeAWljjgHvbyK0f6D8ucpvCLucE/ydEZ1C6NGAX5L
         Eiyhl8eOyRT3b75/G2FnHxB4UjBMrThNO2pHaDPeBHdcBNbe3E0iJzoHaZoYc1x3sjCM
         mlS7tSDhJcfem6pJS5jbz3HpqiEQxsXneA5P4ABhrKOygxesUdeloARmkt2kZZpjqIZ7
         sCKGi9EziuiBwGsOOjJkr4F0puPj3H1QF7ecoMQPXRhDsM7PRb8XQoXEgl7eYfnyxlSs
         yJodpMq06XMaPqa14/lfJBPcr2c0CPIwe2Wh0Iyc9+rL1AcCqUJT4bsyxWeZf3WPkz/u
         bmbw==
X-Gm-Message-State: AFqh2koSKSSMo1kgXL3iZSoq4f9HIh6/uySpszdvomtIJ6L5sm55dzwI
        sPopAbQVA1pDa0Raf8EC8xrVJw==
X-Google-Smtp-Source: AMrXdXsgGVsBTCFNfUcp1pMwbR8YFko6/N5owHwbPkj4GpYFcjLkKkivaUkKNL0p3JZXLKM1M9yXeQ==
X-Received: by 2002:a05:6a20:7b28:b0:ac:184:d297 with SMTP id s40-20020a056a207b2800b000ac0184d297mr1165642pzh.38.1671607061354;
        Tue, 20 Dec 2022 23:17:41 -0800 (PST)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id y33-20020a634b21000000b0048f10379b46sm2754243pga.68.2022.12.20.23.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 23:17:40 -0800 (PST)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sc7280: add display port audio
Date:   Wed, 21 Dec 2022 07:17:34 +0000
Message-Id: <20221221071734.2887901-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DisplayPort sound node and lpass_cpu node
in sc7280-herobrine-audio-rt5682.dtsi.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

--
---

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

