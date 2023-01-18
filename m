Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D593670FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjARBVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjARBVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:21:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9841135BC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:19:02 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso741788pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yM0/ZgSXnPriP0s8Td7ncf1X5xesw5ro9ypu77r/PK0=;
        b=BV117Kzh2UJo/RZBiMP4OXZU4kXp8mdi48JKZJMLPFMihgNhZzPzqYbkUzLWDXY6Lb
         vAf8PqLlTxrCEba2lMkeotanIM/+dubx70HNK40Jd1vYL16+29poPIqIo6w0Ih6RcmFC
         UzNMr/URPmE2+wiXJ+R2ECli2yQmt5dzyAjUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yM0/ZgSXnPriP0s8Td7ncf1X5xesw5ro9ypu77r/PK0=;
        b=U5PMGFVFJAVTPuUI6IJkALdlvOt9PZn5E0/mk9IL9hVM99pFHFD81JWbNOAgvcMF3m
         YuSAf3rQ6yga7Gj60AXz766BBNK9+cEHfFDvNp5fXJOzxhpd6ylRUePgPXo7udXdNAJR
         9qrnrf6DOymzOUPn4vBP5SZI2xIFObIrNvUt4GW17B1SM6XMaxRVr+ySsXRu4H/su00w
         nAdTloSXRFLElvrrT3JEbhx3XnJX79ZDdUz9364ghb8GxcoHXPksfwHL9slfTce4JCA0
         pSgWhDejAFSe2z/ZZto00OtYGd5P39y7iZyGII0YNGTONB8K/9hhQtroqZsFcP94px9E
         RSOQ==
X-Gm-Message-State: AFqh2ko16pLh0GEQb9WfM6HHU0aw3NLTt7slieBnoUF8V5NX3yVB3gH0
        yU3byscPFATisCJq5EVsDieM7w==
X-Google-Smtp-Source: AMrXdXvp8hy99LqbYoteOM90Am/eEo/HgHBQWWXXYRic5vTpFMq2hhBNwBimm+r/63GraZGxPXd1DA==
X-Received: by 2002:a05:6a20:b925:b0:9d:efbf:8156 with SMTP id fe37-20020a056a20b92500b0009defbf8156mr28765714pzb.31.1674004742127;
        Tue, 17 Jan 2023 17:19:02 -0800 (PST)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id b3-20020a63d803000000b00477bfac06b7sm18014600pgh.34.2023.01.17.17.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 17:19:01 -0800 (PST)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v4] arm64: dts: qcom: sc7280: add DP audio to herobrine rt5682 1-mic dtsi
Date:   Wed, 18 Jan 2023 01:18:53 +0000
Message-Id: <20230118011853.1614566-1-judyhsiao@chromium.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v4:
- Fix the subject.

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

