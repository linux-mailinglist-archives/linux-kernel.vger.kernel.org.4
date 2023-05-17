Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87BF7061AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjEQHtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjEQHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:49:02 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C1448C;
        Wed, 17 May 2023 00:48:59 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H6bjDX015630;
        Wed, 17 May 2023 09:48:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=oJiZ1Hn2KqzacEW2f+UbkL8pEVhGPFTr6OTm6h5XTRA=;
 b=8U0FI1kNsXxQGW+dVvjSR4KVmLEztHYFb/Onhv+BMG+t80T3pwoXFHFa6De/xEMud2Yg
 y2kAMZ0Mc+WipYjbjp5At5aUZKVUm5Wymwb44QUOvH2uPkHbEEctHMUus13JGT6Q/T+7
 q3rF+p2M5+6G14WCdxA9y1wPWXqvr/msk7ZMY922E7UzNTXPh1gSsf+oQH4vOa4JuUyY
 hPilXa3yio6BQQO90OTGqHqWmPYYc+Q6vSLiEPLtcvVu1BZws138FKXwqwvO9zysLgTz
 y7hvaxw0ku+0waZEfzQ5Ybzzfywo1qakeLeeYGw9c30avarnWXkApHw0FQGi2lN036Op eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qm7tfe5sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 09:48:44 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C7FCB100034;
        Wed, 17 May 2023 09:48:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BFB972194F3;
        Wed, 17 May 2023 09:48:43 +0200 (CEST)
Received: from localhost (10.252.30.50) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 17 May
 2023 09:48:42 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v4 1/2] ARM: dts: stm32: Update Cortex-M4 reset declarations on stm32mp15
Date:   Wed, 17 May 2023 09:48:29 +0200
Message-ID: <20230517074830.569398-2-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517074830.569398-1-arnaud.pouliquen@foss.st.com>
References: <20230517074830.569398-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.30.50]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the introduction of the SCMI for the management
of the MCU hold boot in OP-TEE, management of the hold boot by SMC call
is deprecated.
- Clean the st,syscfg-tz  which allows to determine if the trust
zone is enable.
- Add reset-names properties to be able to differentiate the MCU reset and
  the MCU HOLD BOOT.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Deltas vs previous revision:
- update commit subject to specify the SoC series

---
 arch/arm/boot/dts/stm32mp151.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 664825418c32..a98ae58e2c1c 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1823,8 +1823,8 @@ m4_rproc: m4@10000000 {
 			      <0x30000000 0x40000>,
 			      <0x38000000 0x10000>;
 			resets = <&rcc MCU_R>;
+			reset-names = "mcu_rst";
 			st,syscfg-holdboot = <&rcc 0x10C 0x1>;
-			st,syscfg-tz = <&rcc 0x000 0x1>;
 			st,syscfg-pdds = <&pwr_mcu 0x0 0x1>;
 			st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
 			st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
-- 
2.25.1

