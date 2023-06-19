Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7EC735634
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjFSLwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFSLwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:52:04 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD5106;
        Mon, 19 Jun 2023 04:52:03 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JAiV1h017510;
        Mon, 19 Jun 2023 13:51:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Zg7+vsy6uVMMMttExr1UyrGtSbJa9wdNY7n7qAIFW80=;
 b=Y3vjtCZvipWojlyeUOi/8oyRNjCYndyhWz8jcIsd//587N3PnUuWfkd4gCWkRXEFgCjy
 5oS8rAeNThFTreyrqwDoHqYDEN9ZxgY/NXc8EseRF2XGQCjfIS8jaglg4PwJUfHQJ5sZ
 WoT8GYlcwvb0WnYiD0HlZBwUvDOAGxWHsil7Mfd5P0ZTJCIhq4UgSp7FJ7h0GRH9GrXx
 uk/day86G3lOSaHjNVabwxbgNTEOOQNrXJx1NnR4rEExVqJuQPFEN8uv3tZ1jG8PtkDR
 ZzmDiB6khRYNiq4V9cQA9koldPo8w2jOVMegH+ot3MBDWDCa974fhQTd4f60ZFlurkqY Kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rah6bt9kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 13:51:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1D90010002A;
        Mon, 19 Jun 2023 13:51:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1252E228A33;
        Mon, 19 Jun 2023 13:51:43 +0200 (CEST)
Received: from localhost (10.201.21.210) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 19 Jun
 2023 13:51:40 +0200
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH v2 1/6] dt-bindings: mmc: mmci: Add st,stm32mp25-sdmmc2 compatible
Date:   Mon, 19 Jun 2023 13:51:15 +0200
Message-ID: <20230619115120.64474-2-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619115120.64474-1-yann.gautier@foss.st.com>
References: <20230619115120.64474-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.210]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_08,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For STM32MP25, we'll need to distinguish how is managed the delay block.
This is done through a new comptible dedicated for this SoC, as the
delay block registers are located in SYSCFG peripheral.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
Changes in v2:
- update dt-bindings file (remove bootloader reference and use enum)

 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
index 1c96da04f0e53..2459a55ed540b 100644
--- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
+++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
@@ -53,10 +53,11 @@ properties:
         items:
           - const: arm,pl18x
           - const: arm,primecell
-      - description: Entry for STMicroelectronics variant of PL18x.
-          This dedicated compatible is used by bootloaders.
+      - description: Entries for STMicroelectronics variant of PL18x.
         items:
-          - const: st,stm32-sdmmc2
+          - enum:
+              - st,stm32-sdmmc2
+              - st,stm32mp25-sdmmc2
           - const: arm,pl18x
           - const: arm,primecell
 
-- 
2.25.1

