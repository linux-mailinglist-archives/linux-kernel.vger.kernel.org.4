Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96274663C96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjAJJRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjAJJRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:17:40 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F355DC37;
        Tue, 10 Jan 2023 01:17:38 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A74sUW030151;
        Tue, 10 Jan 2023 10:17:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=RBTTPdr7XMYkFxdupnjJacZTskuCtQaU/XM4tkVrI6s=;
 b=7quJX8teoZ7LxxA/Kw4+EMBVSpeb+bbyFyLsnaShehqbp4qksEM1MTzH9LJ/i+lDSJpT
 3rqs4MGG/FsutRo8v4FF9/E0AxdjDkyau2uS8BI9RJ8/5p5F9NaciXHfCGf2Qooj1bOp
 wUm1moCQN4tT4lxa1ErAbLyus69akPMUWBMsIa9K+FYd/g/FDhtEaav3MR1MlgMyrebZ
 h3oUFRQ+ciJEkc1qR7XQcB23HZARE0ODCq+bPVxLW8F1QMQlGBcGr5N8mJbk2aKIKb/c
 hs5OcKFltoyetz8Q5g1pkl0T3iYRFSE1CTbaQEPXjq3fllggBAc8zgo+cWciOWecvx88 WQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mxy1qqhvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 10:17:22 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8D85910002A;
        Tue, 10 Jan 2023 10:17:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 85F9F20A8CB;
        Tue, 10 Jan 2023 10:17:21 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 10 Jan
 2023 10:17:21 +0100
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
Subject: [PATCH v2 0/3] ARM: dts: stm32: add timers support on stm32mp13
Date:   Tue, 10 Jan 2023 10:17:09 +0100
Message-ID: <20230110091713.444395-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_02,2023-01-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32 TIM and LPTIM support to STM32MP13 SoCs family.
Add also support of timers available on DK board RPI expansion connector.
These timers are configured in the DK board device tree, but let in
disabled state by default.

Changes in v2:
- rebase serie

Olivier Moysan (3):
  ARM: dts: stm32: add timers support on stm32mp131
  ARM: dts: stm32: add timer pins muxing for stm32mp135f-dk
  ARM: dts: stm32: add timers support on stm32mp135f-dk

 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi |  60 +++
 arch/arm/boot/dts/stm32mp131.dtsi        | 557 +++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp135f-dk.dts     |  58 +++
 3 files changed, 675 insertions(+)

-- 
2.25.1

