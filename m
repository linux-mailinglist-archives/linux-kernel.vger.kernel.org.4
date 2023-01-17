Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777DF66D48B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjAQCuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbjAQCtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:49:49 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2CB3346C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:42:56 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so32103036plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ci0ShutkyKqbRS5y4WPW5+YhID9YQTVWD129Yl/CGkY=;
        b=QjjequB+bplNYxUEtGQzwSjo9+VvYNN/XhKvzZM0XlamFEbJs90Tth5t1TD3XAzRJz
         JIvQGcRMwo0hwiH373b81nt6gPyhXwCWqvWLp2DM1FxT/KdKXTIdLWTaU8ICEMu7xpQd
         5sceRvnB1/uFx94inIZAolVq0Pu95Ag3afa4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci0ShutkyKqbRS5y4WPW5+YhID9YQTVWD129Yl/CGkY=;
        b=8GptYfj1VVQ9K91gGW/3Oa0my321NH1uC2GHgSeMpGK3d2Ih+8dRJP2+oZhkEl9Q3Q
         2f6HFe6KnIb3C0CFG25vWV9QwYER1QkQgXv81irEmy26ZLvRG0pbaOB0NXCWD9ydkQfX
         zVGlCA1e5AIGk7KINCRbhT1GHuH+dKijZ08fC25pH33AHCrIB+n02ud6SEj2lrFTc92z
         yw81WcfIT+WVmzB0xqavcf5hdVcQXLkjbBOiz1ZERC57EEJOuMX8lw9L1dyvego+0DR7
         wqymChUxkLhrHq1MwAyGVUDX9Z3mFRMxyi4qRPAzlvWG6JbiCk+rPAgE2cQZVbxI+IZi
         duLQ==
X-Gm-Message-State: AFqh2kpWSklR75bvDYkudMnP8TdcvOwP5vF9xfcNddpRDCta3GjCn+RD
        s3oZk9kKNTmS9yE7/OCh+vSZxA==
X-Google-Smtp-Source: AMrXdXt9saMUMMymJC5GYhQSjizFrnpQID9HqmpQqPvwSrzjohq15SMwxJxf2Mno4CcOWYP9KWe9Dg==
X-Received: by 2002:a17:902:7b85:b0:193:3bf7:40e6 with SMTP id w5-20020a1709027b8500b001933bf740e6mr735478pll.53.1673923364863;
        Mon, 16 Jan 2023 18:42:44 -0800 (PST)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902784200b0017d97d13b18sm19958534pln.65.2023.01.16.18.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 18:42:44 -0800 (PST)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v3] arm64: dts: qcom: sc7280: add display port audio
Date:   Tue, 17 Jan 2023 02:42:36 +0000
Message-Id: <20230117024236.1442437-1-judyhsiao@chromium.org>
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

1. Add DisplayPort sound node and lpass_cpu node.

2. Adjust the dai-link order to make the order to
   be consistent with sc7280-herobrine-audio-rt5682-3mic.dtsi.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

---

Changes in v3:
- Add more detail in the commit message.

Changes in v2:
- Fix the commit message format.

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

