Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8EB670BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjAQWqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjAQWne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:43:34 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F43F5D93D;
        Tue, 17 Jan 2023 14:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wIYWAmdqWjZbAmwLF7SivMb0k7ca08XLcKv5HclTrKA=; b=Fn2hN9fxVSVz4UpL3mvNLbpPFR
        RVfsVru2B5XNcWywsH2HyfGIgKftm3RRUubfJ08ZqVapsTZY+KDPFiec5BsC0luh4LfVH0FU8FhM3
        qJrgAfaJ19ayk1bG1AygCGT6POsHEPnohV2FY/7iXrIufqh0cl88eoiyPp98eGCBkgeV6ffcBkBEY
        NfDf5maDmPht8gLZ8p2Zd7oCUBkeEYvlQNuAAtixwr7rNTie470S8kNPSvx9M7r/tYLqA3bcZ76gR
        roEbO+OXLqlSG31yD+fs14Ohf45yV+Xfs0wEyswPCBXnKHuCvZcFNTTjSZ9bXnR0o9DKmguTIdGZh
        mRaIh35w==;
Received: from p200300ccff136d001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff13:6d00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pHuTA-0006T7-G1; Tue, 17 Jan 2023 23:30:16 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pHuT9-00AwoM-Qo; Tue, 17 Jan 2023 23:30:15 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] ARM: dts: omap: gta04: add BNO055 IMU chip
Date:   Tue, 17 Jan 2023 23:30:02 +0100
Message-Id: <20230117223002.2609301-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is finally a driver upstreamed, so add the
device.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
 use a generic node name

 arch/arm/boot/dts/omap3-gta04a5.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index 0b5bd7388877..1ecdc985fa05 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -75,6 +75,11 @@ OMAP3_CORE1_IOPAD(0x2138, PIN_INPUT | MUX_MODE4) /* gpin114 */
 		>;
 	};
 
+	bno050_pins: pinmux-bno050-pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2136, PIN_INPUT | MUX_MODE4) /* gpin113 */
+		>;
+	};
 };
 
 /*
@@ -136,4 +141,12 @@ bme280@76 {
 		vdda-supply = <&vio>;
 		vddd-supply = <&vio>;
 	};
+
+	imu@29 {
+		compatible = "bosch,bno055";
+		reg = <0x29>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bno050_pins>;
+		/* interrupt at &gpio4 17 */
+	};
 };
-- 
2.30.2

