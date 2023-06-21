Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39E2737B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFUGd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFUGdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:33:55 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20A41A3;
        Tue, 20 Jun 2023 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ETuoPNFbYDBI7fybUMHgGYzgRtPKhUhC6h+ea+XxCXA=; b=Obo+NsKVt9QB5IN7gO9vx2vQKj
        ntSLMDayhOUexrk4XcNn0IvdDj2xDDNYcEOuvJTO6gRXi8P7TesIGOHD+7quSpWRm6i2kioORHYu+
        otTfmmDsHlZFH2Uz1eJIBMepwjG+NPW3LfyIgTNQcKQkou4a+FeB8yGKymQdR2vcTfaFmYE3kD+MR
        t/3/8RGnIjSPOAWRWP24g8h60TzNPBzVstno+4J35ZUFJvyTDThq6kLwQqj+OhK9OHI7mCMvzid5o
        b8/UVOLBVs7mVQDN1aR6fTftRqEbx/POkcuL0p4vVpqnlm+rsslVpM1sT3F+4CgGYhRGBeX2Itl6Z
        FOAXWlpw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qBrPb-000Md5-TH; Wed, 21 Jun 2023 08:33:51 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qBrPb-0008i1-AG; Wed, 21 Jun 2023 08:33:51 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     a.fatoum@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, dantuguf14105@gmail.com,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] ARM: dts: stm32: Add alternate pinmux for can pins
Date:   Wed, 21 Jun 2023 08:33:33 +0200
Message-Id: <20230621063339.1361073-3-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230621063339.1361073-1-sean@geanix.com>
References: <20230621063339.1361073-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26945/Tue Jun 20 09:30:24 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another mux option for can pins, this is used on Octavo OSD32MP1-RED board.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 422db6dd466c..537908a20efb 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1144,6 +1144,26 @@ pins {
 		};
 	};
 
+	m_can1_pins_d: m-can1-3 {
+		pins1 {
+			pinmux = <STM32_PINMUX('D', 1, AF9)>; /* CAN1_TX */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 0, AF9)>; /* CAN1_RX */
+			bias-disable;
+		};
+	};
+
+	m_can1_sleep_pins_d: m_can1-sleep-3 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 1, ANALOG)>, /* CAN1_TX */
+				 <STM32_PINMUX('D', 0, ANALOG)>; /* CAN1_RX */
+		};
+	};
+
 	m_can2_pins_a: m-can2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
-- 
2.40.0

