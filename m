Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BF16789F4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjAWVuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjAWVtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:49:49 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1589132E70;
        Mon, 23 Jan 2023 13:49:48 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30NLnaOn013775;
        Mon, 23 Jan 2023 15:49:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674510576;
        bh=VX0fiDPdkdEt8JM+E/JYrWjriyedsy3Qf99hORXpZl4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Le4FZlXsk+1OeCgOeLtDz8Olvt6dpNmafuYJ247D2X/C5Cb2LCYUjxkoIPsvBjD14
         U3VppBgdcFZPHZM4urxNVPMYawxV6CV6TKjXudQw9qiWDpwiadpe2Ka5Bs7lnEUfXC
         vNy/U4csb3nCtnsTVpXJz81BAiVToryYG5tkE7BI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30NLna4q012005
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jan 2023 15:49:36 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 23
 Jan 2023 15:49:35 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 23 Jan 2023 15:49:35 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30NLnPZr065237;
        Mon, 23 Jan 2023 15:49:34 -0600
From:   Andrew Davis <afd@ti.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v5 7/9] ARM: dts: nspire: Use MATRIX_KEY macro for linux,keymap
Date:   Mon, 23 Jan 2023 15:49:22 -0600
Message-ID: <20230123214924.27476-8-afd@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230123214924.27476-1-afd@ti.com>
References: <20230123214924.27476-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks better and allows us to see the row and column numbers
more easily. Switch to this macro here.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/nspire-clp.dts | 90 ++++++++++++++++++++++++--------
 arch/arm/boot/dts/nspire-cx.dts  | 90 ++++++++++++++++++++++++--------
 arch/arm/boot/dts/nspire-tp.dts  | 90 ++++++++++++++++++++++++--------
 3 files changed, 204 insertions(+), 66 deletions(-)

diff --git a/arch/arm/boot/dts/nspire-clp.dts b/arch/arm/boot/dts/nspire-clp.dts
index f52f38c61588..916ede0c2499 100644
--- a/arch/arm/boot/dts/nspire-clp.dts
+++ b/arch/arm/boot/dts/nspire-clp.dts
@@ -6,32 +6,78 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
+
 /include/ "nspire-classic.dtsi"
 
 &keypad {
 	linux,keymap = <
-	0x0000001c 	0x0001001c 	0x00020039
-	0x0004002c 	0x00050034 	0x00060015
-	0x0007000b 	0x0008002d 	0x01000033
-	0x0101004e 	0x01020011 	0x01030004
-	0x0104002f 	0x01050003 	0x01060016
-	0x01070002 	0x01080014 	0x02000062
-	0x0201000c 	0x0202001f 	0x02030007
-	0x02040013 	0x02050006 	0x02060010
-	0x02070005 	0x02080019 	0x03000027
-	0x03010037 	0x03020018 	0x0303000a
-	0x03040031 	0x03050009 	0x03060032
-	0x03070008 	0x03080026 	0x04000028
-	0x04010035 	0x04020025 	0x04040024
-	0x04060017 	0x04080023 	0x05000028
-	0x05020022 	0x0503001b 	0x05040021
-	0x0505001a 	0x05060012 	0x0507006f
-	0x05080020 	0x0509002a 	0x0601001c
-	0x0602002e 	0x06030068 	0x06040030
-	0x0605006d 	0x0606001e 	0x06070001
-	0x0608002b 	0x0609000f 	0x07000067
-	0x0702006a 	0x0704006c 	0x07060069
-	0x0707000e 	0x0708001d 	0x070a000d
+		MATRIX_KEY(0,  0, 0x1c)
+		MATRIX_KEY(0,  1, 0x1c)
+		MATRIX_KEY(0,  2, 0x39)
+		MATRIX_KEY(0,  4, 0x2c)
+		MATRIX_KEY(0,  5, 0x34)
+		MATRIX_KEY(0,  6, 0x15)
+		MATRIX_KEY(0,  7, 0x0b)
+		MATRIX_KEY(0,  8, 0x2d)
+		MATRIX_KEY(1,  0, 0x33)
+		MATRIX_KEY(1,  1, 0x4e)
+		MATRIX_KEY(1,  2, 0x11)
+		MATRIX_KEY(1,  3, 0x04)
+		MATRIX_KEY(1,  4, 0x2f)
+		MATRIX_KEY(1,  5, 0x03)
+		MATRIX_KEY(1,  6, 0x16)
+		MATRIX_KEY(1,  7, 0x02)
+		MATRIX_KEY(1,  8, 0x14)
+		MATRIX_KEY(2,  0, 0x62)
+		MATRIX_KEY(2,  1, 0x0c)
+		MATRIX_KEY(2,  2, 0x1f)
+		MATRIX_KEY(2,  3, 0x07)
+		MATRIX_KEY(2,  4, 0x13)
+		MATRIX_KEY(2,  5, 0x06)
+		MATRIX_KEY(2,  6, 0x10)
+		MATRIX_KEY(2,  7, 0x05)
+		MATRIX_KEY(2,  8, 0x19)
+		MATRIX_KEY(3,  0, 0x27)
+		MATRIX_KEY(3,  1, 0x37)
+		MATRIX_KEY(3,  2, 0x18)
+		MATRIX_KEY(3,  3, 0x0a)
+		MATRIX_KEY(3,  4, 0x31)
+		MATRIX_KEY(3,  5, 0x09)
+		MATRIX_KEY(3,  6, 0x32)
+		MATRIX_KEY(3,  7, 0x08)
+		MATRIX_KEY(3,  8, 0x26)
+		MATRIX_KEY(4,  0, 0x28)
+		MATRIX_KEY(4,  1, 0x35)
+		MATRIX_KEY(4,  2, 0x25)
+		MATRIX_KEY(4,  4, 0x24)
+		MATRIX_KEY(4,  6, 0x17)
+		MATRIX_KEY(4,  8, 0x23)
+		MATRIX_KEY(5,  0, 0x28)
+		MATRIX_KEY(5,  2, 0x22)
+		MATRIX_KEY(5,  3, 0x1b)
+		MATRIX_KEY(5,  4, 0x21)
+		MATRIX_KEY(5,  5, 0x1a)
+		MATRIX_KEY(5,  6, 0x12)
+		MATRIX_KEY(5,  7, 0x6f)
+		MATRIX_KEY(5,  8, 0x20)
+		MATRIX_KEY(5,  9, 0x2a)
+		MATRIX_KEY(6,  1, 0x1c)
+		MATRIX_KEY(6,  2, 0x2e)
+		MATRIX_KEY(6,  3, 0x68)
+		MATRIX_KEY(6,  4, 0x30)
+		MATRIX_KEY(6,  5, 0x6d)
+		MATRIX_KEY(6,  6, 0x1e)
+		MATRIX_KEY(6,  7, 0x01)
+		MATRIX_KEY(6,  8, 0x2b)
+		MATRIX_KEY(6,  9, 0x0f)
+		MATRIX_KEY(7,  0, 0x67)
+		MATRIX_KEY(7,  2, 0x6a)
+		MATRIX_KEY(7,  4, 0x6c)
+		MATRIX_KEY(7,  6, 0x69)
+		MATRIX_KEY(7,  7, 0x0e)
+		MATRIX_KEY(7,  8, 0x1d)
+		MATRIX_KEY(7, 10, 0x0d)
 	>;
 };
 
diff --git a/arch/arm/boot/dts/nspire-cx.dts b/arch/arm/boot/dts/nspire-cx.dts
index 837dbdd9af55..96c48fc52203 100644
--- a/arch/arm/boot/dts/nspire-cx.dts
+++ b/arch/arm/boot/dts/nspire-cx.dts
@@ -6,6 +6,8 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
+
 /include/ "nspire.dtsi"
 
 &lcd {
@@ -45,28 +47,72 @@ &ahb_clk {
 
 &keypad {
 	linux,keymap = <
-	0x0000001c 	0x0001001c 	0x00040039
-	0x0005002c 	0x00060015 	0x0007000b
-	0x0008000f 	0x0100002d 	0x01010011
-	0x0102002f 	0x01030004 	0x01040016
-	0x01050014 	0x0106001f 	0x01070002
-	0x010a006a 	0x02000013 	0x02010010
-	0x02020019 	0x02030007 	0x02040018
-	0x02050031 	0x02060032 	0x02070005
-	0x02080028 	0x0209006c 	0x03000026
-	0x03010025 	0x03020024 	0x0303000a
-	0x03040017 	0x03050023 	0x03060022
-	0x03070008 	0x03080035 	0x03090069
-	0x04000021 	0x04010012 	0x04020020
-	0x0404002e 	0x04050030 	0x0406001e
-	0x0407000d 	0x04080037 	0x04090067
-	0x05010038 	0x0502000c 	0x0503001b
-	0x05040034 	0x0505001a 	0x05060006
-	0x05080027 	0x0509000e 	0x050a006f
-	0x0600002b 	0x0602004e 	0x06030068
-	0x06040003 	0x0605006d 	0x06060009
-	0x06070001 	0x0609000f 	0x0708002a
-	0x0709001d 	0x070a0033 	>;
+		MATRIX_KEY(0,  0, 0x1c)
+		MATRIX_KEY(0,  1, 0x1c)
+		MATRIX_KEY(0,  4, 0x39)
+		MATRIX_KEY(0,  5, 0x2c)
+		MATRIX_KEY(0,  6, 0x15)
+		MATRIX_KEY(0,  7, 0x0b)
+		MATRIX_KEY(0,  8, 0x0f)
+		MATRIX_KEY(1,  0, 0x2d)
+		MATRIX_KEY(1,  1, 0x11)
+		MATRIX_KEY(1,  2, 0x2f)
+		MATRIX_KEY(1,  3, 0x04)
+		MATRIX_KEY(1,  4, 0x16)
+		MATRIX_KEY(1,  5, 0x14)
+		MATRIX_KEY(1,  6, 0x1f)
+		MATRIX_KEY(1,  7, 0x02)
+		MATRIX_KEY(1, 10, 0x6a)
+		MATRIX_KEY(2,  0, 0x13)
+		MATRIX_KEY(2,  1, 0x10)
+		MATRIX_KEY(2,  2, 0x19)
+		MATRIX_KEY(2,  3, 0x07)
+		MATRIX_KEY(2,  4, 0x18)
+		MATRIX_KEY(2,  5, 0x31)
+		MATRIX_KEY(2,  6, 0x32)
+		MATRIX_KEY(2,  7, 0x05)
+		MATRIX_KEY(2,  8, 0x28)
+		MATRIX_KEY(2,  9, 0x6c)
+		MATRIX_KEY(3,  0, 0x26)
+		MATRIX_KEY(3,  1, 0x25)
+		MATRIX_KEY(3,  2, 0x24)
+		MATRIX_KEY(3,  3, 0x0a)
+		MATRIX_KEY(3,  4, 0x17)
+		MATRIX_KEY(3,  5, 0x23)
+		MATRIX_KEY(3,  6, 0x22)
+		MATRIX_KEY(3,  7, 0x08)
+		MATRIX_KEY(3,  8, 0x35)
+		MATRIX_KEY(3,  9, 0x69)
+		MATRIX_KEY(4,  0, 0x21)
+		MATRIX_KEY(4,  1, 0x12)
+		MATRIX_KEY(4,  2, 0x20)
+		MATRIX_KEY(4,  4, 0x2e)
+		MATRIX_KEY(4,  5, 0x30)
+		MATRIX_KEY(4,  6, 0x1e)
+		MATRIX_KEY(4,  7, 0x0d)
+		MATRIX_KEY(4,  8, 0x37)
+		MATRIX_KEY(4,  9, 0x67)
+		MATRIX_KEY(5,  1, 0x38)
+		MATRIX_KEY(5,  2, 0x0c)
+		MATRIX_KEY(5,  3, 0x1b)
+		MATRIX_KEY(5,  4, 0x34)
+		MATRIX_KEY(5,  5, 0x1a)
+		MATRIX_KEY(5,  6, 0x06)
+		MATRIX_KEY(5,  8, 0x27)
+		MATRIX_KEY(5,  9, 0x0e)
+		MATRIX_KEY(5, 10, 0x6f)
+		MATRIX_KEY(6,  0, 0x2b)
+		MATRIX_KEY(6,  2, 0x4e)
+		MATRIX_KEY(6,  3, 0x68)
+		MATRIX_KEY(6,  4, 0x03)
+		MATRIX_KEY(6,  5, 0x6d)
+		MATRIX_KEY(6,  6, 0x09)
+		MATRIX_KEY(6,  7, 0x01)
+		MATRIX_KEY(6,  9, 0x0f)
+		MATRIX_KEY(7,  8, 0x2a)
+		MATRIX_KEY(7,  9, 0x1d)
+		MATRIX_KEY(7, 10, 0x33)
+	>;
 };
 
 &vbus_reg {
diff --git a/arch/arm/boot/dts/nspire-tp.dts b/arch/arm/boot/dts/nspire-tp.dts
index f7d0faacd4cc..235cd4264da7 100644
--- a/arch/arm/boot/dts/nspire-tp.dts
+++ b/arch/arm/boot/dts/nspire-tp.dts
@@ -6,32 +6,78 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
+
 /include/ "nspire-classic.dtsi"
 
 &keypad {
 	linux,keymap = <
-	0x0000001c 	0x0001001c 	0x00040039
-	0x0005002c 	0x00060015 	0x0007000b
-	0x0008000f 	0x0100002d 	0x01010011
-	0x0102002f 	0x01030004 	0x01040016
-	0x01050014 	0x0106001f 	0x01070002
-	0x010a006a 	0x02000013 	0x02010010
-	0x02020019 	0x02030007 	0x02040018
-	0x02050031 	0x02060032 	0x02070005
-	0x02080028 	0x0209006c 	0x03000026
-	0x03010025 	0x03020024 	0x0303000a
-	0x03040017 	0x03050023 	0x03060022
-	0x03070008 	0x03080035 	0x03090069
-	0x04000021 	0x04010012 	0x04020020
-	0x0404002e 	0x04050030 	0x0406001e
-	0x0407000d 	0x04080037 	0x04090067
-	0x05010038 	0x0502000c 	0x0503001b
-	0x05040034 	0x0505001a 	0x05060006
-	0x05080027 	0x0509000e 	0x050a006f
-	0x0600002b 	0x0602004e 	0x06030068
-	0x06040003 	0x0605006d 	0x06060009
-	0x06070001 	0x0609000f 	0x0708002a
-	0x0709001d 	0x070a0033 	>;
+		MATRIX_KEY(0,  0, 0x1c)
+		MATRIX_KEY(0,  1, 0x1c)
+		MATRIX_KEY(0,  4, 0x39)
+		MATRIX_KEY(0,  5, 0x2c)
+		MATRIX_KEY(0,  6, 0x15)
+		MATRIX_KEY(0,  7, 0x0b)
+		MATRIX_KEY(0,  8, 0x0f)
+		MATRIX_KEY(1,  0, 0x2d)
+		MATRIX_KEY(1,  1, 0x11)
+		MATRIX_KEY(1,  2, 0x2f)
+		MATRIX_KEY(1,  3, 0x04)
+		MATRIX_KEY(1,  4, 0x16)
+		MATRIX_KEY(1,  5, 0x14)
+		MATRIX_KEY(1,  6, 0x1f)
+		MATRIX_KEY(1,  7, 0x02)
+		MATRIX_KEY(1, 10, 0x6a)
+		MATRIX_KEY(2,  0, 0x13)
+		MATRIX_KEY(2,  1, 0x10)
+		MATRIX_KEY(2,  2, 0x19)
+		MATRIX_KEY(2,  3, 0x07)
+		MATRIX_KEY(2,  4, 0x18)
+		MATRIX_KEY(2,  5, 0x31)
+		MATRIX_KEY(2,  6, 0x32)
+		MATRIX_KEY(2,  7, 0x05)
+		MATRIX_KEY(2,  8, 0x28)
+		MATRIX_KEY(2,  9, 0x6c)
+		MATRIX_KEY(3,  0, 0x26)
+		MATRIX_KEY(3,  1, 0x25)
+		MATRIX_KEY(3,  2, 0x24)
+		MATRIX_KEY(3,  3, 0x0a)
+		MATRIX_KEY(3,  4, 0x17)
+		MATRIX_KEY(3,  5, 0x23)
+		MATRIX_KEY(3,  6, 0x22)
+		MATRIX_KEY(3,  7, 0x08)
+		MATRIX_KEY(3,  8, 0x35)
+		MATRIX_KEY(3,  9, 0x69)
+		MATRIX_KEY(4,  0, 0x21)
+		MATRIX_KEY(4,  1, 0x12)
+		MATRIX_KEY(4,  2, 0x20)
+		MATRIX_KEY(4,  4, 0x2e)
+		MATRIX_KEY(4,  5, 0x30)
+		MATRIX_KEY(4,  6, 0x1e)
+		MATRIX_KEY(4,  7, 0x0d)
+		MATRIX_KEY(4,  8, 0x37)
+		MATRIX_KEY(4,  9, 0x67)
+		MATRIX_KEY(5,  1, 0x38)
+		MATRIX_KEY(5,  2, 0x0c)
+		MATRIX_KEY(5,  3, 0x1b)
+		MATRIX_KEY(5,  4, 0x34)
+		MATRIX_KEY(5,  5, 0x1a)
+		MATRIX_KEY(5,  6, 0x06)
+		MATRIX_KEY(5,  8, 0x27)
+		MATRIX_KEY(5,  9, 0x0e)
+		MATRIX_KEY(5, 10, 0x6f)
+		MATRIX_KEY(6,  0, 0x2b)
+		MATRIX_KEY(6,  2, 0x4e)
+		MATRIX_KEY(6,  3, 0x68)
+		MATRIX_KEY(6,  4, 0x03)
+		MATRIX_KEY(6,  5, 0x6d)
+		MATRIX_KEY(6,  6, 0x09)
+		MATRIX_KEY(6,  7, 0x01)
+		MATRIX_KEY(6,  9, 0x0f)
+		MATRIX_KEY(7,  8, 0x2a)
+		MATRIX_KEY(7,  9, 0x1d)
+		MATRIX_KEY(7, 10, 0x33)
+	>;
 };
 
 / {
-- 
2.38.1

