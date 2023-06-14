Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E5972F9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbjFNJt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243461AbjFNJs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:48:58 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAF32127;
        Wed, 14 Jun 2023 02:48:29 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35E9lPfE108113;
        Wed, 14 Jun 2023 04:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686736045;
        bh=QRGK/l0B6hsumWBFXxBYbdnIT7AJCivqxdHFN1d+CMw=;
        h=From:Date:Subject:To:CC;
        b=dB0PIvecIRJVObzdNmjBxVvCKiv2bdX4guJSl4z1IKu5CgkbQWrCPaAEeftC6bs1p
         gCpYQSDAmSKMjHVbmIxSH0dp7/IBuJV5yjC9b5zZ5PoCLRagDahZIiRfZ67DX2weZS
         C8t+plbcq5x0gpHi2gVwzUHOkgjl20X/TznePps4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35E9lPqI017877
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Jun 2023 04:47:25 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Jun 2023 04:47:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Jun 2023 04:47:24 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35E9lOgS008848;
        Wed, 14 Jun 2023 04:47:24 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Date:   Wed, 14 Jun 2023 15:16:56 +0530
Subject: [PATCH v2] arm64: dts: ti: k3-am62-main: Remove power-domains from
 crypto node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230614-sa3ul-v2-1-3a832b82339c@ti.com>
X-B4-Tracking: v=1; b=H4sIAI+MiWQC/x2N0QrCMAwAf2XkeYWuLSL+iviQtNkW0CqJymDs3
 9ft8biDW8FYhQ1u3QrKfzF51wah7yDPWCd2UhpD8CH6y5CcYfw9XaZEZSBKxV+htYTGjhRrno/
 6hfZlPcRHeZTlHNwf27YDnWyJXnAAAAA=
To:     kamlesh <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686736043; l=1274;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=E/J6WsSEaN6BRpocHKGuz8QWaNU9pO7nxprAGwZE4bA=;
 b=cyXcaX8mN8CMapm5bqNXpQqoI4v6tJenKqnu6x3xAh6Ur0L0ePFia4K4TXk8GmQ2OY46P5vf5
 oh1EwH9CkuYCRt5r5tic3qVUb7mTc/dQ/T/i2zlqDXEjnIS9jTdgB6I
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only SYSFW has control of SA3UL power.
From SYSFW 08.04.00.002, for security reasons, device ID for power
management of SA3UL has been removed.

"power-domains" property in crypto node tries to access
the SA3UL, for which it gets NACK and hence, SA3UL driver doesn't
probe properly.

Fixes: 8af893654c02 ("arm64: dts: ti: k3-am62-main: Enable crypto accelerator")

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
v2 changes:
-make commit message clearer
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index b3e4857bbbe4..18a6e9ffaf58 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -174,7 +174,6 @@ k3_reset: reset-controller {
 	crypto: crypto@40900000 {
 		compatible = "ti,am62-sa3ul";
 		reg = <0x00 0x40900000 0x00 0x1200>;
-		power-domains = <&k3_pds 70 TI_SCI_PD_SHARED>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;

---
base-commit: 53ab6975c12d1ad86c599a8927e8c698b144d669
change-id: 20230614-sa3ul-cb4bd1bb4d08

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>

