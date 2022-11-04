Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF086197CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiKDNZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiKDNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:24:53 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD492EF2D;
        Fri,  4 Nov 2022 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1667568258; bh=VpeM8QHNgIDViZAVdCgdIsI8ValCbkXsYMsD6mNoyqk=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=KYqX6YxKYOlY+VBrpDvLOGbdWCsyk78pz1iAYeB9ugxIw9/PYlI1R2kIFReDyoGqT
         uouI9/AaslWlW/54wyJo1Q3sYfgABQRWFlbAsrZAIqCE7kqGiaBHwWATG1iEA+P4ZO
         woPRT9l880tdIrTZxXMCstzn4jtMt+BvSbiQLDKI=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Fri,  4 Nov 2022 14:24:18 +0100 (CET)
X-EA-Auth: vZ1oDn2afiJgqWUk+guD7nKtwcloj0jSwho/kvrC7C0/Zk1iLTdGs+yGJnwz7tnNkWdjw1srmj2cDigqAq0Pl+enY85kCS/wD7Iq3fepqIQ=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v2 1/3] arm64: dts: qcom: msm8916-alcatel-idol347: Add GPIOs -state suffix
Date:   Fri,  4 Nov 2022 14:23:58 +0100
Message-Id: <20221104132400.1763218-2-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221104132400.1763218-1-vincent.knecht@mailoo.org>
References: <20221104132400.1763218-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add -state suffix to GPIOs states node names as required by dt-bindings.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index 3dc9619fde6e..668f8ff53229 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -260,7 +260,7 @@ l18 {
 };
 
 &msmgpio {
-	accel_int_default: accel-int-default {
+	accel_int_default: accel-int-default-state {
 		pins = "gpio31";
 		function = "gpio";
 
@@ -268,7 +268,7 @@ accel_int_default: accel-int-default {
 		bias-disable;
 	};
 
-	gpio_keys_default: gpio-keys-default {
+	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107";
 		function = "gpio";
 
@@ -276,7 +276,7 @@ gpio_keys_default: gpio-keys-default {
 		bias-pull-up;
 	};
 
-	gyro_int_default: gyro-int-default {
+	gyro_int_default: gyro-int-default-state {
 		pins = "gpio97", "gpio98";
 		function = "gpio";
 
@@ -284,7 +284,7 @@ gyro_int_default: gyro-int-default {
 		bias-disable;
 	};
 
-	mag_reset_default: mag-reset-default {
+	mag_reset_default: mag-reset-default-state {
 		pins = "gpio8";
 		function = "gpio";
 
@@ -292,7 +292,7 @@ mag_reset_default: mag-reset-default {
 		bias-disable;
 	};
 
-	proximity_int_default: proximity-int-default {
+	proximity_int_default: proximity-int-default-state {
 		pins = "gpio12";
 		function = "gpio";
 
@@ -300,7 +300,7 @@ proximity_int_default: proximity-int-default {
 		bias-pull-up;
 	};
 
-	ts_int_reset_default: ts-int-reset-default {
+	ts_int_reset_default: ts-int-reset-default-state {
 		pins = "gpio13", "gpio100";
 		function = "gpio";
 
@@ -308,7 +308,7 @@ ts_int_reset_default: ts-int-reset-default {
 		bias-disable;
 	};
 
-	usb_id_default: usb-id-default {
+	usb_id_default: usb-id-default-state {
 		pins = "gpio69";
 		function = "gpio";
 
-- 
2.38.1



