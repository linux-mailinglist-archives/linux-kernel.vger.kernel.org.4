Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A55616A2B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiKBRLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiKBRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:11:00 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D11A046;
        Wed,  2 Nov 2022 10:10:57 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 45B94100002;
        Wed,  2 Nov 2022 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667409056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8mWfxTqG3njBupNc7jr4TNdhtRp5mSbUkZFra7Ci3M=;
        b=cWRdwtePCUtnPM3jHxe+2JjJotQPFoUULC6YOmKwF4MtFlUfp6zmH81PXMkqgPJ89g45W4
        xBr1J3gIjLLMBEmHUgHZLDveWmnB648gzw9yR4K6OzjkmqwrE0pOqWzAOIq66v+GAo4y1Z
        31hV3Vn2z+yI+x7zE0d1qLWJ5mkPwYPygR4UbXhDKRqOck01PeiiQx70iAAuZ35P3+1LdY
        /KuOADv2rDWUG+YcbhHyXOVD8/edf5hh99m6feSmjSdZMSqwQCP8K/5+WoIFSzNFZiCojc
        mb/GSl/mPRAU83q7opk4OTv0IOsyPSjW+Xg98QfdIBM87B8kb1hqHkXIJmRKIA==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     viresh.kumar@linaro.org, Vipin Kumar <vipin.kumar@st.com>,
        Rajeev Kumar <rajeev-dlh.kumar@st.com>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Vijay Kumar Mishra <vijay.kumar@st.com>,
        Vipul Kumar Samar <vipulkumar.samar@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        thomas.petazzoni@bootlin.com, Viresh Kumar <vireshk@kernel.org>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Deepak Sikri <deepak.sikri@st.com>,
        Bhavna Yadav <bhavna.yadav@st.com>
Subject: [PATCH v2 5/6] arm: dts: spear600: Add ssp controller nodes
Date:   Wed,  2 Nov 2022 18:10:09 +0100
Message-Id: <20221102171012.49150-6-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102171012.49150-1-kory.maincent@bootlin.com>
References: <20221102171012.49150-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

The SPEAr600 has three Synchronous serial port to enables synchronous
serial communication with slave or master peripherals (SPI). Lets add these
nodes to be able to use them.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/spear600.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index 9d5a04a46b14..6b67c0ceaed9 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -207,6 +207,36 @@ adc: adc@d820b000 {
 				interrupts = <6>;
 				status = "disabled";
 			};
+
+			ssp1: spi@d0100000 {
+				compatible = "arm,pl022", "arm,primecell";
+				reg = <0xd0100000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupt-parent = <&vic0>;
+				interrupts = <26>;
+				status = "disabled";
+			};
+
+			ssp2: spi@d0180000 {
+				compatible = "arm,pl022", "arm,primecell";
+				reg = <0xd0180000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupt-parent = <&vic0>;
+				interrupts = <27>;
+				status = "disabled";
+			};
+
+			ssp3: spi@d8180000 {
+				compatible = "arm,pl022", "arm,primecell";
+				reg = <0xd8180000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupt-parent = <&vic1>;
+				interrupts = <5>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.25.1

