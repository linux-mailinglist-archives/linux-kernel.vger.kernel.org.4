Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3862F734
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242354AbiKROVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbiKROV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:21:27 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2F67104;
        Fri, 18 Nov 2022 06:21:25 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AICFIUb025123;
        Fri, 18 Nov 2022 15:21:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=bEGiUooBAWg10GL05T18knua8Hy/usMTNQ+41sucBRQ=;
 b=WqBhTGOHFfAzG/GsNxSprCdx3d9+p5zyyWB6jq3jvgzkiEZBACp4RETKOnQ2nOyVB5/S
 CbS1cbj1bGo4q+3AmYu4GZt04WI9PrQL5Agp5X7KnCz8tp06IxcWNx+vzYW3ek40Bfqw
 v0WQuw8DppMyQvI0AFipQqefMJSv2wjENG/Wq2Xp9ogFNp0ucm/QO6hrEprgxuO0V6Ni
 6MZPzx/4ik0D40+lB6NkzuG3FB+PsAeybiQeQlqpTfXfl0k4OoL+CfXetMvF5/YXZ7mP
 d4NVHJwnvTfy4q+6Z9F+0Y58gwLffaJGw1DkQvndxMDcSHFFCy8Fuz3X/mm8WyJDScmE rA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kx0my47rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:21:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 408E4100034;
        Fri, 18 Nov 2022 15:20:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B6AB231DE0;
        Fri, 18 Nov 2022 15:20:57 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Fri, 18 Nov
 2022 15:20:57 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] ARM: dts: add audio support on stm32mp131
Date:   Fri, 18 Nov 2022 15:20:02 +0100
Message-ID: <20221118142006.479138-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_02,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SAI, I2S, SPDIFRX and DFSDM audio peripherals support for the
STM32MP13 SoC family.

Olivier Moysan (4):
  ARM: dts: stm32: add i2s nodes on stm32mp131
  ARM: dts: stm32: add sai nodes on stm32mp131
  ARM: dts: stm32: add spdifrx node on stm32mp131
  ARM: dts: stm32: add dfsdm node on stm32mp131

 arch/arm/boot/dts/stm32mp131.dtsi | 149 ++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

-- 
2.25.1

