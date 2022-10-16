Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437C2600271
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJPRa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJPRaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:30:17 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AEA12408D;
        Sun, 16 Oct 2022 10:30:17 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net [86.14.22.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 1A3D01402C8;
        Sun, 16 Oct 2022 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1665941416; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLIoAuk5Ni3RxK9d6sJqHBNqJqsK4ckapijd/uqW65Q=;
        b=i8Ilo4hwcW4IvTuYvbiwaJs+IWdrZvzWjjiuMzCfZbLHGiZd+GHB6TU78gyTKaQbRq0S7B
        1bonmIoYKPNvqiHWPBLTJ9d4J2ltbA1GxmZLy9vGDERkYBPRJvo6BwlBZrj/AGygusz+mz
        K4ju3uF805qTcGMQ82UJ166a9NtHC34=
From:   Caleb Connolly <kc@postmarketos.org>
To:     caleb@connolly.tech
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sdm845-*: fix uart6 aliases
Date:   Sun, 16 Oct 2022 18:29:43 +0100
Message-Id: <20221016172944.1892206-4-kc@postmarketos.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221016172944.1892206-1-kc@postmarketos.org>
References: <20221016172944.1892206-1-kc@postmarketos.org>
Reply-To: Caleb Connolly <caleb@connolly.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Caleb Connolly <caleb@connolly.tech>

Some devices have been using hsuart0 as an alias for the bluetooth UART,
rename this to serial1

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi           | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts           | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index 923d5d681daa..a8ae6de51af4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -16,7 +16,7 @@
 / {
 	aliases {
 		bluetooth0 = &bluetooth;
-		hsuart0 = &uart6;
+		serial1 = &uart6;
 		serial0 = &uart9;
 		wifi0 = &wifi;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index f87b1e2025b6..215dd8098a44 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -22,7 +22,7 @@ / {
 
 	aliases {
 		serial0 = &uart9;
-		hsuart0 = &uart6;
+		serial1 = &uart6;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 02ec0fa4e5f0..5d99908d4628 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -19,7 +19,7 @@
 / {
 	aliases {
 		serial0 = &uart9;
-		hsuart0 = &uart6;
+		serial1 = &uart6;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 5dde27b7daf2..1646db2328d4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -35,7 +35,7 @@ / {
 	qcom,msm-id = <321 0x20001>;
 
 	aliases {
-		hsuart0 = &uart6;
+		serial1 = &uart6;
 	};
 
 	gpio-keys {
-- 
2.38.0

