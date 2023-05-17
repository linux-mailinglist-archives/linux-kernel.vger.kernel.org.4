Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C847064EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjEQKLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEQKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:11:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AA45246;
        Wed, 17 May 2023 03:11:19 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 921136603232;
        Wed, 17 May 2023 11:11:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684318278;
        bh=QzbbpvgwCOlFi2txMshE0/SGr4XkdMo8sJlsfVtnC7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=IqBJ176JSPvTw9BdvcRTtfNllFPKkZOf6NvqqcwADAfYh6Z7N9xC4HTJxOJkpptpu
         sKMDb1oodnpdP215c+pRUhzNEjZ8OIr8K9e6+byDVQF/HG1p0cmQTJPM7gtYuCAP6g
         CAo/fIUHVQGWsmEG6uMZbRS4jHxAbAv/k4fi6N2Li3jl+SsI9n/K6S4RBJvYVRBq9p
         jqfRTEEW86x1K8CCNiUKFThTLZyG31HRigQDoAy9UhpdwmPMg0M4DbQVsvqJKfMxO9
         3zs+qALTo8EqnbLTrkgux8yhf3DpI+u81jhjXr22wymtXiFxEr8Wag2+mk9+zS3dSV
         fS2lBRd7hW9TQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH] arm64: mediatek: Propagate chassis-type where possible
Date:   Wed, 17 May 2023 12:11:08 +0200
Message-Id: <20230517101108.205654-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chassis-type string identifies the form-factor of the system:
add this property to all device trees of devices for which the form
factor is known.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

I had to ignore some devicetrees as I wasn't sure about the correct
chassis-type of some devices; this raises an issue that we shall solve
when reviewing new DTs, as we shall tell developers to add this
property so that we don't lose track of "what was what".

Even though this property is technically "Optional, Recommended", I
think it's useful to have it as this may (or may not) be actively used
in the future (think about "handset" form factor and thermal envelope).

Cheers!

 arch/arm64/boot/dts/mediatek/mt2712-evb.dts                      | 1 +
 arch/arm64/boot/dts/mediatek/mt6755-evb.dts                      | 1 +
 arch/arm64/boot/dts/mediatek/mt6779-evb.dts                      | 1 +
 arch/arm64/boot/dts/mediatek/mt6795-evb.dts                      | 1 +
 arch/arm64/boot/dts/mediatek/mt6797-evb.dts                      | 1 +
 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts                  | 1 +
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts         | 1 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts                     | 1 +
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts         | 1 +
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts                     | 1 +
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts                     | 1 +
 arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dts                  | 1 +
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts            | 1 +
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts                 | 1 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dts                      | 1 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts                      | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts                      | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts     | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts       | 1 +
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts     | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dts       | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts             | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dts       | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dts      | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dts      | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts         | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts       | 1 +
 arch/arm64/boot/dts/mediatek/mt8186-evb.dts                      | 1 +
 28 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index d31a194124c9..fffdb7bbf889 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -11,6 +11,7 @@
 
 / {
 	model = "MediaTek MT2712 evaluation board";
+	chassis-type = "embedded";
 	compatible = "mediatek,mt2712-evb", "mediatek,mt2712";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt6755-evb.dts b/arch/arm64/boot/dts/mediatek/mt6755-evb.dts
index e079b7932ba3..00b14f85c6a1 100644
--- a/arch/arm64/boot/dts/mediatek/mt6755-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6755-evb.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "MediaTek MT6755 EVB";
+	chassis-type = "embedded";
 	compatible = "mediatek,mt6755-evb", "mediatek,mt6755";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt6779-evb.dts b/arch/arm64/boot/dts/mediatek/mt6779-evb.dts
index 164f5cbb3821..56b1bf06e26b 100644
--- a/arch/arm64/boot/dts/mediatek/mt6779-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6779-evb.dts
@@ -10,6 +10,7 @@
 
 / {
 	model = "MediaTek MT6779 EVB";
+	chassis-type = "embedded";
 	compatible = "mediatek,mt6779-evb", "mediatek,mt6779";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt6795-evb.dts b/arch/arm64/boot/dts/mediatek/mt6795-evb.dts
index 1ed2f81edeff..e0d4d7a63139 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6795-evb.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "MediaTek MT6795 Evaluation Board";
+	chassis-type = "embedded";
 	compatible = "mediatek,mt6795-evb", "mediatek,mt6795";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt6797-evb.dts b/arch/arm64/boot/dts/mediatek/mt6797-evb.dts
index 2327e752d164..c927932afa0d 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6797-evb.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "MediaTek MT6797 Evaluation Board";
+	chassis-type = "embedded";
 	compatible = "mediatek,mt6797-evb", "mediatek,mt6797";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
index eff9e8dbd076..9534cf3a09d0 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
@@ -12,6 +12,7 @@
 
 / {
 	model = "Mediatek X20 Development Board";
+	chassis-type = "embedded";
 	compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index af3fe61e4093..4848164e8e59 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -15,6 +15,7 @@
 
 / {
 	model = "Bananapi BPI-R64";
+	chassis-type = "embedded";
 	compatible = "bananapi,bpi-r64", "mediatek,mt7622";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index b74e774c6eba..dad8e683aac5 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -15,6 +15,7 @@
 
 / {
 	model = "MediaTek MT7622 RFB1 board";
+	chassis-type = "embedded";
 	compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index 33bd6febc160..7128f779c165 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -16,6 +16,7 @@
 
 / {
 	model = "Bananapi BPI-R3";
+	chassis-type = "embedded";
 	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index 4f18b4a9a8c8..3ef371ca254e 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -11,6 +11,7 @@
 
 / {
 	model = "MediaTek MT7986a RFB";
+	chassis-type = "embedded";
 	compatible = "mediatek,mt7986a-rfb", "mediatek,mt7986a";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index 188ce82ae56c..dde190442e38 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "MediaTek MT7986b RFB";
+	chassis-type = "embedded";
 	compatible = "mediatek,mt7986b-rfb", "mediatek,mt7986b";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dts
index 774a2f3fb4b2..ebf1a358f42a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dts
@@ -11,6 +11,7 @@
 
 / {
 	model = "Pumpkin MT8167";
+	chassis-type = "embedded";
 	compatible = "mediatek,mt8167-pumpkin", "mediatek,mt8167";
 
 	memory@40000000 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
index 28433b94f7c7..256f245ac01d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
@@ -8,6 +8,7 @@
 
 / {
 	model = "Google Hanawl";
+	chassis-type = "laptop";
 	compatible = "google,hana-rev7", "mediatek,mt8173";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
index c234296755e1..fcf0cb76a87c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
@@ -8,6 +8,7 @@
 
 / {
 	model = "Google Hana";
+	chassis-type = "laptop";
 	compatible = "google,hana-rev6", "google,hana-rev5",
 		     "google,hana-rev4", "google,hana-rev3",
 		     "google,hana", "mediatek,mt8173";
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dts b/arch/arm64/boot/dts/mediatek/mt8173-elm.dts
index e9e4ac0b74b2..2390d04204e8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dts
@@ -8,6 +8,7 @@
 
 / {
 	model = "Google Elm";
+	chassis-type = "laptop";
 	compatible = "google,elm-rev8", "google,elm-rev7", "google,elm-rev6",
 		     "google,elm-rev5", "google,elm-rev4", "google,elm-rev3",
 		     "google,elm", "mediatek,mt8173";
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 755df5694234..5122963d8743 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -10,6 +10,7 @@
 
 / {
 	model = "MediaTek MT8173 evaluation board";
+	chassis-type = "embedded";
 	compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 3e3f4b1b00f0..d8bd51807683 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -11,6 +11,7 @@
 
 / {
 	model = "MediaTek MT8183 evaluation board";
+	chassis-type = "embedded";
 	compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
index 1a2ec0787d3c..19c1e2bee494 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "Google burnet board";
+	chassis-type = "convertible";
 	compatible = "google,burnet", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
index 0eca3ff8672a..552bfc726999 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "Google damu board";
+	chassis-type = "convertible";
 	compatible = "google,damu", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
index bc2c57f0a827..8ac6bf5b17f9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "Google juniper sku16 board";
+	chassis-type = "convertible";
 	compatible = "google,juniper-sku16", "google,juniper", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dts
index 3a724e6f915c..fcce8ea1232e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "MediaTek kakadu board sku22";
+	chassis-type = "tablet";
 	compatible = "google,kakadu-rev3-sku22", "google,kakadu-rev2-sku22",
 		     "google,kakadu", "mediatek,mt8183";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts
index 89a139a0ee44..ebfabba72507 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dts
@@ -9,6 +9,7 @@
 
 / {
 	model = "MediaTek kakadu board";
+	chassis-type = "tablet";
 	compatible = "google,kakadu-rev3", "google,kakadu-rev2",
 			"google,kakadu", "mediatek,mt8183";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dts
index e3dd75bdaea4..7213cdcca612 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dts
@@ -12,6 +12,7 @@
 
 / {
 	model = "MediaTek kodama sku16 board";
+	chassis-type = "tablet";
 	compatible = "google,kodama-sku16", "google,kodama", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dts
index d81935ae07bc..bbf0cd1aa66d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dts
@@ -12,6 +12,7 @@
 
 / {
 	model = "MediaTek kodama sku272 board";
+	chassis-type = "tablet";
 	compatible = "google,kodama-sku272", "google,kodama", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dts
index f4082fbe0517..a429ffeac3bd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dts
@@ -12,6 +12,7 @@
 
 / {
 	model = "MediaTek kodama sku288 board";
+	chassis-type = "tablet";
 	compatible = "google,kodama-sku288", "google,kodama", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts
index fb5ee91b6fe0..4ac75806fa94 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts
@@ -14,6 +14,7 @@
 
 / {
 	model = "MediaTek krane sku0 board";
+	chassis-type = "tablet";
 	compatible = "google,krane-sku0", "google,krane", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
index 721d16f9c3b4..095279e55d50 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dts
@@ -14,6 +14,7 @@
 
 / {
 	model = "MediaTek krane sku176 board";
+	chassis-type = "tablet";
 	compatible = "google,krane-sku176", "google,krane", "mediatek,mt8183";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-evb.dts b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
index ed74a3617c13..2667a7424200 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
@@ -7,6 +7,7 @@
 
 / {
 	model = "MediaTek MT8186 evaluation board";
+	chassis-type = "embedded";
 	compatible = "mediatek,mt8186-evb", "mediatek,mt8186";
 
 	aliases {
-- 
2.40.1

