Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA07627D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbiKNMRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiKNMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:17:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8F1EAE3;
        Mon, 14 Nov 2022 04:17:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38FF0B80DBF;
        Mon, 14 Nov 2022 12:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76D4C433C1;
        Mon, 14 Nov 2022 12:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668428221;
        bh=UH+GWkwtfms2AOzvG2j6b82aSdcxdwm3nMRBgLF6O14=;
        h=From:To:Cc:Subject:Date:From;
        b=d1PUskdkK8fQfRAqaWSguZqyt5ak+ENLkFQEh5ZoLq7cmDRLS8xmGFF6ytUPwgdBy
         LqE6iqeC5bPYUOKMAQV0IgesFXwVaPpvYNW9tMsAdEX+nRYuDAs3u9Fx4H+rH+SJxz
         EOp5Dj2tGDHj4cPaj3BJGf5zWMyQJ+HjfIH2VFbuXqRPaO8QogsWSz0fyZKjc1c4Bu
         7/pj4AuddXeSz01oiG4Ggl2a16RVHUxGOT/Lnt3ul55K7a6WXncOxL4vzwE/VDlVuO
         5ArUt/AdxOYHP4MWksraFb4Uo+rnRgAcW11N3XFvlIicZeFnFVnFqqrSz97kYjN7Y6
         SmdKUT4fydJPA==
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, frank-w@public-files.de
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v2] arm64: dts: mediatek: mt7986: Add SoC compatible
Date:   Mon, 14 Nov 2022 13:16:53 +0100
Message-Id: <20221114121653.14739-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Missing SoC compatible in the board file causes dt bindings check.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---
Changes since v1:
- Move SoC compatible to first line of the block
- Add SoC compatible to mt7986b


 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 2 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 1 +
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 2 +-
 arch/arm64/boot/dts/mediatek/mt7986b.dtsi    | 3 +++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index afe37b702eef9..0e3b603159477 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "MediaTek MT7986a RFB";
-	compatible = "mediatek,mt7986a-rfb";
+	compatible = "mediatek,mt7986a-rfb", "mediatek,mt7986a";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 72e0d9722e07a..3c52ec3f99a31 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/reset/mt7986-resets.h>
 
 / {
+	compatible = "mediatek,mt7986a";
 	interrupt-parent = <&gic>;
 	#address-cells = <2>;
 	#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index 3443013b5971e..d03e66a84c5d4 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "MediaTek MT7986b RFB";
-	compatible = "mediatek,mt7986b-rfb";
+	compatible = "mediatek,mt7986b-rfb", "mediatek,mt7986b";
 
 	aliases {
 		serial0 = &uart0;
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b.dtsi b/arch/arm64/boot/dts/mediatek/mt7986b.dtsi
index 23923b9f8944b..db5189664c29b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986b.dtsi
@@ -5,6 +5,9 @@
  */
 
 #include "mt7986a.dtsi"
+/ {
+	compatible = "mediatek,mt7986b";
+};
 
 &pio {
 	compatible = "mediatek,mt7986b-pinctrl";
-- 
2.38.1

