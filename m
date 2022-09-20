Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7295BE710
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiITN2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiITN1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:27:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233DE49B5B;
        Tue, 20 Sep 2022 06:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7B9DCE17D1;
        Tue, 20 Sep 2022 13:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AF0C4347C;
        Tue, 20 Sep 2022 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663680451;
        bh=1fcbXZeScQcLotv0gPiS1nNUsEdY9jyJFjsJdQHPPQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+FRQAnxkPyOxYuPptioo1CnZfLJ4GXyMQm14RjccLhABRTQZ/A1kp9/IfxmH1QIM
         HG2yNpVQwu8TxZwklm8QhHfhzEO0kSPlHsHCEa5fWQ20oO+Gnga7PCnkb1kWWPbPwK
         1UbDtg9j+k6ac0FRy2E6FZyQiOLzjLEfklchKHFEE3s1ydrQy4YhRkD2jXrGOpgOiw
         L/rHEZtYF71vffBn2KBUkCQLnypLGNzZNWF1eKiDe6xTZRKYVX9917hKJPFlszNmcZ
         iZVfNgqq7qIBxFC5oRyVZ/u7kgNFLhrPLKU2+2571HDR4sH42Z6OIh3VQC9IFG7orb
         tbgofw/Ivi1fA==
Received: by pali.im (Postfix)
        id E25DB2E12; Tue, 20 Sep 2022 15:27:29 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marcin Wojtas <mw@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] ARM: dts: turris-omnia: Define S/PDIF audio card
Date:   Tue, 20 Sep 2022 15:26:48 +0200
Message-Id: <20220920132648.2008-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220920132648.2008-1-pali@kernel.org>
References: <20220920132648.2008-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turris Omnia has GPIO51 exported on pin header U16, which works in S/PDIF
output mode. So define S/PDIF audio output card for this pin.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-385-turris-omnia.dts | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index d1e0db6e5730..fd0960157589 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -105,6 +105,33 @@
 		 */
 		status = "disabled";
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "SPDIF";
+		simple-audio-card,format = "i2s";
+
+		simple-audio-card,cpu {
+			sound-dai = <&audio_controller 1>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
+};
+
+&audio_controller {
+	/* Pin header U16, GPIO51 in SPDIFO mode */
+	pinctrl-0 = <&spdif_pins>;
+	pinctrl-names = "default";
+	spdif-mode;
+	status = "okay";
 };
 
 &bm {
-- 
2.20.1

