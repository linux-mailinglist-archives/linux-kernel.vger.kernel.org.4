Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A599A6E7C00
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjDSONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjDSON1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:13:27 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C295516DE4;
        Wed, 19 Apr 2023 07:12:38 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33JECPn5005232;
        Wed, 19 Apr 2023 09:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681913545;
        bh=7JMr6UAfOcI9OnbSghx8XaEHzCwn8lowWb622/8bltk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BQSvv3jKCtSwZf+k0TmUoAOPjrTuxmfuPuFdUdJcM8pp8AlBvMj5k7iS6javZBb6m
         exeMiBTry1Svpu9oxEcCgXRah0p8W8RZEp2hZeTNNPsLQsP5jCN3bqdvQ2fhWePiKM
         BYgWkVXcfTSt/BVc3MEBDLrkFdodt2YhVD5LcTTo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33JECPwO095449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 09:12:25 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 09:12:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 09:12:24 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33JECOrX021105;
        Wed, 19 Apr 2023 09:12:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH V2 4/5] arm64: dts: ti: k3-j7200-common-proc-board: Drop bootargs
Date:   Wed, 19 Apr 2023 09:12:21 -0500
Message-ID: <20230419141222.383567-5-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230419141222.383567-1-nm@ti.com>
References: <20230419141222.383567-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop bootargs from the dts. The console arguments are already covered in
stdout-path property and earlycon is a debug property that should be
enabled only when debug is desired and not as default.

Link: https://lore.kernel.org/linux-arm-kernel/81134eb9-2b7d-05bc-3035-a47f020861a8@linaro.org/
Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Similar discussions can be seen in https://lore.kernel.org/linux-devicetree/?q=Krzysztof+bootargs

Changes since v1:
- improved commit message
- picked up acks and reviews from Roger and Krzysztof

V1: https://lore.kernel.org/r/20230418165212.1456415-5-nm@ti.com

 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 0d39d6b8cc0c..5506341aae21 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -17,7 +17,6 @@ / {
 
 	chosen {
 		stdout-path = "serial2:115200n8";
-		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
 	};
 
 	evm_12v0: fixedregulator-evm12v0 {
-- 
2.40.0

