Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0513A600E03
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiJQLp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJQLp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:45:26 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79BB10FC2;
        Mon, 17 Oct 2022 04:45:24 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HB84lq024503;
        Mon, 17 Oct 2022 13:45:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=sJi3zYlsCoKwtFbhGwVnjUqovsaLgnxPrwJLLX6bmNk=;
 b=zI1dKaT4j5EnFMn6FKyZKGxmpS0TrKhmHZ1DFziF3Kv6AoAuBmbx/Wgg/DGWwFZPCfPp
 7dOCb6H3/dPgQuP+zp2aEeErcOuuntKc3zXp9h45WnDakSOodtKskGGBqIsSuEs8+Cz7
 rVNpReC3DcAeXpXnc8UhVWg5OXYd4hXuY4iUG0HsnCU6EmjWRlPhpYXblIzw8+RB8XeC
 iPN9apkEZ2XhsGDjZFkJnIFiJCm07VcauSnZU3betHOShUai+dJ2YGMVputTqPS3/3Xx
 aJVGBXMFuy4pf0ITBcuS5DxhQn8Wj6KzQrxMDol8Up4c37pRcvSdsWKmXJIbxE46q72j Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k7krjkykc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 13:45:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8528B100034;
        Mon, 17 Oct 2022 13:44:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3695D228A4C;
        Mon, 17 Oct 2022 13:44:58 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 13:44:55 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] ARM: dts: stm32mp13: fix compatible for BSEC
Date:   Mon, 17 Oct 2022 13:44:52 +0200
Message-ID: <20221017134437.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_09,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new compatible for stm32mp13 support.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---
This device tree modification depends on the binding modification
introduced by the patch:

dt-bindings: nvmem: add new stm32mp13 compatible for stm32-romem
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20221014172324.1.Ifc1812116ff63f5501f3edd155d3cf5c0ecc846c@changeid/

 arch/arm/boot/dts/stm32mp131.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index dd35a607073d..89a027f894f9 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -398,7 +398,7 @@ rtc: rtc@5c004000 {
 		};
 
 		bsec: efuse@5c005000 {
-			compatible = "st,stm32mp15-bsec";
+			compatible = "st,stm32mp13-bsec";
 			reg = <0x5c005000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.25.1

