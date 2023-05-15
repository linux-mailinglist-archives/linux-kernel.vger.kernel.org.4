Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5EC703D79
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244782AbjEOTOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243501AbjEOTNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:13:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C4515EDF;
        Mon, 15 May 2023 12:13:46 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FJDUrr089385;
        Mon, 15 May 2023 14:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684178010;
        bh=ZzKVlyCPHyTxRj4e2SffrTyR2DUIDFnjXsjccSjcXd8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Cz/n+54sulSrlXCz45tJqjJLnTe5l9kaPmCWhqrytQRBGPsw9TbmrQ0mVZxoG8Vj4
         ibWDpBt75+RpQW+e0CWYyfFBICkmb32MY5ACX/+gGPsABVTVKwo5gEYQBtwLpPNPW9
         nPGme5klz+sY7UJHF6Fz2HRN454ErBW1JuVQUefs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FJDUw6097259
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 14:13:30 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 14:13:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 14:13:30 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FJDSK6005699;
        Mon, 15 May 2023 14:13:29 -0500
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
Subject: [PATCH v7 2/9] ARM: dts: nspire: Fix cpu node to conform with DT binding
Date:   Mon, 15 May 2023 14:13:19 -0500
Message-ID: <20230515191326.608638-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515191326.608638-1-afd@ti.com>
References: <20230515191326.608638-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This node does not follow the DT binding schema, correct this.
Should result in no functional change.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/nspire.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index 48fbc9d533c3..cb7237051512 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -11,8 +11,13 @@ / {
 	interrupt-parent = <&intc>;
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu@0 {
 			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
-- 
2.39.2

