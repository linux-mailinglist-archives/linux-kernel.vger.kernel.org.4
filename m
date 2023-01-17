Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB78670DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjAQXir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjAQXiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:38:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5B1392BA;
        Tue, 17 Jan 2023 14:44:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h16so32162732wrz.12;
        Tue, 17 Jan 2023 14:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSOKhvqsjRLHMedgakHEOkcG54qmkySqSuJu+13pLAY=;
        b=DwN4EBIPJr3N28JnsH5aawIVOacElZIsyiKnVUreSdXlfZqYAITHtcOe3QjfZ+/Q+5
         QwO426vHgVAYCPIIwS3TiY7enMDEQ67CNMaWz+WyZEoqFHh38Ual+okBkrBiGETU61Rg
         m11bkhOo6Xf9ohoFpxmrRvj2tXq2yCZFPABlJ8iEvSJZ0Z3eUsy8zv5Xi8VnzZVF/SBA
         3qCo+0vwX8dfOXFcAl/dTuSDH8QcWUNf02gAtfz8sjaQOKMA/qHxY6NjGV+SiueyvoBw
         VcxteEjLeXwvsW9q4GXtMpr894QdhzdVoFUlaxTrVAgr/CjjWM+EBVJAM9Ener/cfu9u
         IXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSOKhvqsjRLHMedgakHEOkcG54qmkySqSuJu+13pLAY=;
        b=7dQYfLuu3UGHoMTLOGMOxPfJLYSaGxZCgu+R3Ond3+N/xNkxyAItvYRlz8N4QdZd03
         +hnh6KzJC4xZpGCSvJJ2L2G2+XpDDDipxL20IdwhHtNF5E8rzyj5iLZSeKYYvthiR6bE
         hsdViIGZTNtcNKhrpU6M/V+Tf2NDQw9jkUG8//dQRy4tiVorMBr+NlEYZolJQw+DLxCo
         QUDHJ2Upc2P4hl8n+SubIpXueMnW3zh5p6/MJNGtppJStj1ZyhSyL61Mn9LX02ZS1kIT
         tvUkg2Slkk5xRQEyXtkeKt+8eis771G2VgxyNjJHYqEldppBehHwVD47RN2TGtzL8sLk
         9Ggg==
X-Gm-Message-State: AFqh2kp0TWLRvjPKjaeLdJA15MC4UFwpOd5nRkR2owEP/vrzx6xlQZGJ
        dcLMxcByLm6z8t3H1N4jw5Tiij/hQyM=
X-Google-Smtp-Source: AMrXdXsesnZC0DKLfx9arDON2N17eAuLeCMPEpCvaDZrtC/Ji8EKv8DgI2e7BFGJI6YvIgbeQ/BrqQ==
X-Received: by 2002:a05:6000:4006:b0:2bd:f4af:48fb with SMTP id cy6-20020a056000400600b002bdf4af48fbmr4514014wrb.44.1673995475905;
        Tue, 17 Jan 2023 14:44:35 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id bt19-20020a056000081300b002bdc3f5945dsm17518032wrb.89.2023.01.17.14.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:44:35 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] ARM: dts: qcom: ipq8064: move reg-less nodes outside soc node
Date:   Tue, 17 Jan 2023 23:44:17 +0100
Message-Id: <20230117224417.7530-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move node that doesn't have a reg outside the soc node as it should only
contain reg nodes.
No changes intended.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index ae018a7dc6fd..52d77e105957 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -326,26 +326,26 @@ scm {
 		};
 	};
 
+	stmmac_axi_setup: stmmac-axi-config {
+		snps,wr_osr_lmt = <7>;
+		snps,rd_osr_lmt = <7>;
+		snps,blen = <16 0 0 0 0 0 0>;
+	};
+
+	vsdcc_fixed: vsdcc-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "SDCC Power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 		compatible = "simple-bus";
 
-		stmmac_axi_setup: stmmac-axi-config {
-			snps,wr_osr_lmt = <7>;
-			snps,rd_osr_lmt = <7>;
-			snps,blen = <16 0 0 0 0 0 0>;
-		};
-
-		vsdcc_fixed: vsdcc-regulator {
-			compatible = "regulator-fixed";
-			regulator-name = "SDCC Power";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
 		rpm: rpm@108000 {
 			compatible = "qcom,rpm-ipq8064";
 			reg = <0x00108000 0x1000>;
-- 
2.38.1

