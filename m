Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6EA6475B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiLHSip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLHSim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:38:42 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D911584240
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:38:41 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id p6so756130iod.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/xRJHKG4NMzsfm+L55zOJgUriasPBTXRAvPlc39dV8=;
        b=RDMaYzI9+CHGgDxC/9KzdYmdhuMifeXLSA/5/9xHUEck68KrbhkswKh+mhRViJdpxK
         axz1EC/onSkbs1DLN9IqkX6vU+lx9GdHFdeNSmFjXJNoOJSd4bxbO2U7fC23VnRBKJCU
         AIB7xtevHY6ujkbUUNmnyWK2E5LYhNoKCMSAxZHPa43vJwZZB+QWz4He6pl75R1EmSZB
         N+VL4WkfALF+KeAnGoIbNFaVlLvleq/2nDUiDZWFD2EREc70WE+choT8lVMUnRRlyJ0R
         e76gtHhNLC4RpsxtG4oc8t3yuBdJwUqsNaaItfsIPTfTMvAG+SU+3mAk+qQXjbwfUVqW
         y1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/xRJHKG4NMzsfm+L55zOJgUriasPBTXRAvPlc39dV8=;
        b=VpiMCAPYb8Te9eZOWjZQecjmc/BUurDjhCgyl6wcVc2JRQ3/GaQ09uE3doTFGuziTi
         ZUDgmfugsRK4fqdLHqmftVbCK+XrQ9z5VJvBwGQ9AqGU2UIeR6CX7BIowvmGpEwSQxNf
         yFwVuy0XvtV9U3lC50J9l2CvxXcEgh6mwiT6lItEdszLn+C+MYo/uXAzzecZ04iKStNr
         1rwbuSdO+Rs9521PW5QXh02fqPoHhhqAeKm/DEjTAsmgaDuc4n3PHTzReaPRK9V6vKta
         VN8hovrU/f4+KJb6NRzrxkzrvFH9J1wA9hxcbykJnizlmSMSLuU+Eeeg1pBiZdYjW92W
         90mg==
X-Gm-Message-State: ANoB5pnmGL0cz37ryJV4Rxqko91ExZdUFXb8HjyR3CFBCoQaHNk1h56a
        uCXY8MwjbAOiguPs3hj++NzV2Xcn4sLCJ1Qn
X-Google-Smtp-Source: AA0mqf61illtL0dhR5UWIP1aOg0DfrQStcwqNBO0OxsnwZmssKcjojUuirB3yT2rAuBwoUL+/sntyg==
X-Received: by 2002:a6b:c402:0:b0:6e0:27a2:1768 with SMTP id y2-20020a6bc402000000b006e027a21768mr1813129ioa.18.1670524721128;
        Thu, 08 Dec 2022 10:38:41 -0800 (PST)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id m6-20020a0566022ac600b006de16e510b5sm9191180iov.53.2022.12.08.10.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 10:38:40 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org
Cc:     elder@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7280: enable IPA in sc7280-herobrine-lte-sku.dtsi
Date:   Thu,  8 Dec 2022 12:38:37 -0600
Message-Id: <20221208183837.505454-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
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

IPA is only needed on a platform if it includes a modem, and not all
SC7280 SoC variants do.  The file "sc7280-herobrine-lte-sku.dtsi" is
used to encapsulate definitions related to Chrome OS SC7280 devices
where a modem is present, and that's the proper place for the IPA
node to be enabled.

Currently IPA is enabled in "sc7280-idp.dtsi", which is included by
DTS files for Qualcomm reference platforms (all of which include the
modem).  That also includes "sc7280-herobrine-lte-sku.dtsi", so
enabling IPA there would make it unnecessary for "sc7280-idp.dtsi"
to enable it.

The only other place IPA is enabled is "sc7280-qcard.dtsi".
That file is included only by "sc7280-herobrine.dtsi", which
is (eventually) included only by these top-level DTS files:
  sc7280-herobrine-crd.dts
  sc7280-herobrine-herobrine-r1.dts
  sc7280-herobrine-evoker.dts
  sc7280-herobrine-evoker-lte.dts
  sc7280-herobrine-villager-r0.dts
  sc7280-herobrine-villager-r1.dts
  sc7280-herobrine-villager-r1-lte.dts
All of but two of these include "sc7280-herobrine-lte-sku.dtsi", and
for those cases, enabling IPA there means there is no need for it to
be enabled in "sc7280-qcard.dtsi".

The two remaining cases will no longer enable IPA as a result of
this change:
  sc7280-herobrine-evoker.dts
  sc7280-herobrine-villager-r1.dts
Both of these have "lte" counterparts, and are meant to represent
board variants that do *not* have a modem.

This is exactly the desired configuration.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 5 +++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi               | 5 -----
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi             | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
index ad66e5e9db4ed..956708397f035 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -34,3 +34,8 @@ &remoteproc_mpss {
 &rmtfs_mem {
 	reg = <0x0 0x9c900000 0x0 0x800000>;
 };
+
+&ipa {
+	status = "okay";
+	modem-init;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index f7efb9966afd1..0ddbe7f732bd9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -376,11 +376,6 @@ &gpi_dma1 {
 	status = "okay";
 };
 
-&ipa {
-	status = "okay";
-	modem-init;
-};
-
 &lpass_cpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index df49564ae6dc1..cd6ee84b36fd4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -336,11 +336,6 @@ vreg_bob: bob {
 
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
 
-&ipa {
-	status = "okay";
-	modem-init;
-};
-
 &lpass_va_macro {
 	vdd-micb-supply = <&vreg_bob>;
 };
-- 
2.34.1

