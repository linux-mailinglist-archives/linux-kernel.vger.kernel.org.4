Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621A0611BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJ1U4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJ1U4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:56:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D4B241B06;
        Fri, 28 Oct 2022 13:56:05 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2A4DC660293F;
        Fri, 28 Oct 2022 21:56:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666990564;
        bh=N8cgOi4X/bGXGpJD1NivnBMWo59PYqBzjXyEcn5g/c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uz2gH1d5rmELMS/Cg98cAiOnfzWrfm5ZTh5bTWtLXZs9ilO5PTxCUudUwAnTebvYI
         0hBv2FVkqhdFqHPMvJPLzNW11qU/6rkuO8xjiEu9QgUW5NaWg6oCH9dycm6vb4WkEH
         MkOiZj7rxyGa21PYU4VqaMkbN15EdkbVx72ATKkvy8kvpcFA+1IZ0P2pZVnCh8luhH
         wur8lMjO8lh1t3Iv5rLSchm61qFS2fC2X4Yow3/p80NROqi1a/fCgEQda/vbU2Ru7M
         hYPbN5Uazx9qqpSO7IyXF3jg137UjjnJ6Btij0r5v5xuWpFb7ebvbHKRtPjxmbDjQW
         hAVChXCXP7tWA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] arm64: dts: qcom: sc7180-trogdor: Remove VBAT supply from rt5682s
Date:   Fri, 28 Oct 2022 16:55:40 -0400
Message-Id: <20221028205540.3197304-9-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028205540.3197304-1-nfraprado@collabora.com>
References: <20221028205540.3197304-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These devicetrees override a rt5682 node to use the rt5682s compatible,
however, unlike rt5682, rt5682s doesn't have a VBAT supply. Remove the
inexistent supply in the rt5682s nodes.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi          | 1 +
 .../dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts     | 1 +
 .../dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
index 74f0e07ea5cf..e0fb83a9a0b1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
@@ -11,6 +11,7 @@
 
 &alc5682 {
 	compatible = "realtek,rt5682s";
+	/delete-property/ VBAT-supply;
 	realtek,dmic1-clk-pin = <2>;
 	realtek,dmic-clk-rate-hz = <2048000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
index aa605885c371..6225ab8329c3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
@@ -19,6 +19,7 @@ / {
 
 &alc5682 {
 	compatible = "realtek,rt5682s";
+	/delete-property/ VBAT-supply;
 	realtek,dmic1-clk-pin = <2>;
 	realtek,dmic-clk-rate-hz = <2048000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
index 7116c44c8d85..b40b068dad6a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
@@ -19,6 +19,7 @@ / {
 
 &alc5682 {
 	compatible = "realtek,rt5682s";
+	/delete-property/ VBAT-supply;
 	realtek,dmic1-clk-pin = <2>;
 	realtek,dmic-clk-rate-hz = <2048000>;
 };
-- 
2.38.1

