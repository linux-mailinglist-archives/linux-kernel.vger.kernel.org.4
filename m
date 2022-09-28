Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C015EDC85
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiI1MZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiI1MZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:25:28 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16B287FA7;
        Wed, 28 Sep 2022 05:25:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28SCPC8O003269;
        Wed, 28 Sep 2022 07:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664367912;
        bh=oYjHuETU5XH5zCHHTNsai6VWaNGxOoK7MLmZL5+c//8=;
        h=From:To:CC:Subject:Date;
        b=ehcltCMOBMrpaRGMug43LzdefA8DkbbujNFmOSaxtehsfr3/VhCi2Pw9VIkyOqC/c
         TaPBhL6WxcW+wvXBG/2gK2wZwWa81rpRbRztme07SfLVgu4ab+tT0BAbEJUOf1+NJ0
         ivT/QlJvT63LdUNuQKxskTye/jjlI/+UlxM0SsoU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28SCPCrJ020739
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Sep 2022 07:25:12 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 28
 Sep 2022 07:25:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 28 Sep 2022 07:25:12 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28SCPAGM018845;
        Wed, 28 Sep 2022 07:25:11 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <devicetree@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [PATCH] arm64: dts: ti: j721e-common-proc-board: Fix sound node-name
Date:   Wed, 28 Sep 2022 17:55:09 +0530
Message-ID: <20220928122509.143342-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If root-node has no reg property, the unit-address should not
be appended at the end of node-name. sound node has no 'reg'
property, so remove the unit-address.

Fixes: ed3aad5b8268 ('arm64: dts: ti: j721e-common-proc-board: Analog audio support')
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index b1691ac3442d..4da3fcdc28e5 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -96,7 +96,7 @@ vdd_sd_dv_alt: gpio-regulator-TLV71033 {
 			 <3300000 0x1>;
 	};
 
-	sound0: sound@0 {
+	sound0: sound-0 {
 		compatible = "ti,j721e-cpb-audio";
 		model = "j721e-cpb";
 
-- 
2.25.1

