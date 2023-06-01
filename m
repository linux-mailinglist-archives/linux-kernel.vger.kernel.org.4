Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8804071939F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjFAGzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjFAGy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:54:56 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCCB134;
        Wed, 31 May 2023 23:54:50 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3516fRfn009049;
        Thu, 1 Jun 2023 08:53:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=8H8AEU7eqzWAvBjrD3F5quK0OnexjZy8CtWYJysXkfQ=;
 b=kvvJtq6O+ns505n1+MyUEyqPmRLUPe0/+YetQ8I8X5vaaXVagY+sZay/FqxJbCIMnJKE
 PibodwZoAYC/VeRB6kbH/GYeY7gfRfZdD0XJKhn8EUciutXYT+r1X6fdHwzBIHxpFEIZ
 y6rJ+ztamNVno3e7NkisbrE5NP7TtLKEVxWzwLQRZW+dtcsG/FoV9JNZ4RcOtLnnRqBs
 RMiB4ztk46LqfwQfw7xgurzplqqENNK9iPsDPwyrNUaJExC/nEx/EAHeeZuMBr13l3IU
 kbYnUMBpL7PWXzqZFv/hvLbrRUGWNnHx20NSZMUcUjggTOb2GNSMubKqJpzkdGjRJ0vc tQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qx95rc2kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 08:53:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 97E9D100038;
        Thu,  1 Jun 2023 08:52:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8FF9B20E1E2;
        Thu,  1 Jun 2023 08:52:25 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 1 Jun
 2023 08:52:25 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-media@vger.kernel.org>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: stm32: add required supplies of ov5640 in stm32mp157c-ev1
Date:   Thu, 1 Jun 2023 08:52:21 +0200
Message-ID: <20230601065222.2594700-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_04,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the following warnings by adding the required supplies (AVDD, DVDD)
for the ov5640 node.

arch/arm/boot/dts/stm32mp157c-ev1.dtb: camera@3c: 'AVDD-supply' is a required property
From schema: Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
arch/arm/boot/dts/stm32mp157c-ev1.dtb: camera@3c: 'DVDD-supply' is a required property
From schema: Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index ba8e9d9a42fa..f27d6dcb6651 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -185,7 +185,9 @@ ov5640: camera@3c {
 		reg = <0x3c>;
 		clocks = <&clk_ext_camera>;
 		clock-names = "xclk";
+		AVDD-supply = <&v2v8>;
 		DOVDD-supply = <&v2v8>;
+		DVDD-supply = <&v2v8>;
 		powerdown-gpios = <&stmfx_pinctrl 18 (GPIO_ACTIVE_HIGH | GPIO_PUSH_PULL)>;
 		reset-gpios = <&stmfx_pinctrl 19 (GPIO_ACTIVE_LOW | GPIO_PUSH_PULL)>;
 		rotation = <180>;
-- 
2.25.1

