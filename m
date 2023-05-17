Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E847069BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjEQNXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjEQNXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:23:13 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33811FFE;
        Wed, 17 May 2023 06:23:11 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HAE4FX019286;
        Wed, 17 May 2023 15:22:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=BZr8fDGfdp37BckovBTdF+2bEwCeqebT3IP9pKPZ1WM=;
 b=l64+D3Cr1PWnikE0y1Z2JLhDp/I6hhaAcFbCjdqRQfZ2rZYjpp2UYIWqOQAtoQIwyppE
 ZJshEe/hw8ENmf2R8NmfrzWc2oGoPiv/l5KazZDAgRra5oNKIGchSlVlyjN46SDftuC0
 266C+byeTplLlc0JT2GMEX+mQ/CHHLI0NJMM7+JfnxSmRnU5UJKTnhKVEx9vujmn32qU
 CyMa2eUZDMGkQrpbilZthHilLL3mI/AaCtAhmMoyxYPofB3Ee+VLklQrAYIO594BBlcl
 qPvbg3Ulce01ZweVMzWrs7EfplUbsXg3xCIA80/tPFAwy0hr8Xnlch7EXPS9TUlif9M6 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qmtefjqbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 15:22:47 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 16750100034;
        Wed, 17 May 2023 15:22:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0DE0E2309C4;
        Wed, 17 May 2023 15:22:47 +0200 (CEST)
Received: from localhost (10.129.178.187) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 17 May
 2023 15:22:46 +0200
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@dh-electronics.com>
Subject: [PATCH 0/3] STM32 warning cleanup
Date:   Wed, 17 May 2023 15:22:11 +0200
Message-ID: <20230517132214.254757-1-raphael.gallais-pou@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.187]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie aims to reduce the number of device-tree warnings of
following boards :

  - STM32F429-DISCO
  - STM32MP15*

Those warnings were appearing either during build or when checking
dt-bindings and concern mostly LTDC and DSI IPs and were due to the
following cases:

  - panel-dsi@0 nodes that needed
  - unnecessary #address-cells and #size-cells properties
  - residual 'reg' field on single endpoints

Raphael Gallais-Pou (3):
  ARM: dts: stm32: fix warnings on stm32f469-disco board
  dt-bindings: display: st,stm32-dsi: Remove unnecessary fields
  ARM: dts: stm32: fix several DT warnings on stm32mp15

 .../devicetree/bindings/display/st,stm32-dsi.yaml      |  2 --
 arch/arm/boot/dts/stm32f469-disco.dts                  |  4 ++--
 arch/arm/boot/dts/stm32mp151.dtsi                      |  5 -----
 arch/arm/boot/dts/stm32mp157.dtsi                      |  7 -------
 .../dts/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts    |  6 ++++--
 .../boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts   |  6 ++++--
 .../stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts  |  3 +--
 arch/arm/boot/dts/stm32mp157c-dk2.dts                  |  8 ++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts                  | 10 +++++++---
 arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts              |  3 +--
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi     |  6 +-----
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi                 |  3 +--
 12 files changed, 29 insertions(+), 34 deletions(-)

-- 
2.25.1

