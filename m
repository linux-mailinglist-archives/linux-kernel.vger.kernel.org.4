Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9DA70F7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjEXNk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjEXNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:40:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804D3B3;
        Wed, 24 May 2023 06:40:14 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OCgXXO015679;
        Wed, 24 May 2023 15:39:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=7VfyEEAa30A1jqe6julvnk2zzbBmOw5sbxPXbLc2amo=;
 b=diyWMK1Ah/qKQOCijwPMHzdUqVrX+QshNbb8cOoc8I3uhuw52iN4MCZj6lWmtIiJZIcw
 Wqh0/2hFts2aNtCv4Ue2yQEoGlp0wbrdFjVtJR9P7Dg3H7uQDUEZUFEitGbW2O+/SCST
 qNSNO4ZK4/uZeN6tLOdWq5uinHZow0BkrpnE/sqX29iaw6Ava3hfZoQtsA9VzACSTHs8
 B2Get2qRV/gFITNqDQH7mX0fN766B0m8NIE1KjkjNToD6nmR24EEVFW1EAglxGHpHNlH
 pnXUvuweb1Au6fI70uF5TNXwc3ZuHetgJx5UlchGmD8reBbuX1mmmkW5S7hjFhCCkeL3 CQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qrthk930h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 15:39:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6CD4C10002A;
        Wed, 24 May 2023 15:39:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8F1A3229A88;
        Wed, 24 May 2023 15:39:48 +0200 (CEST)
Received: from localhost (10.252.20.36) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 24 May
 2023 15:39:48 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@dh-electronics.com>
Subject: [PATCH 0/8] ARM: dts: stm32: add adc internal channels on stm32mp15
Date:   Wed, 24 May 2023 15:39:09 +0200
Message-ID: <20230524133918.1439516-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.20.36]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32 ADC2 internal channels VREFINT and VDDCORE to STM32MP15x SoCs.

Add support of vrefint channel by adding access to vrefint calibration
data in OTP.

The internal channels are defined in STM32MP15 SoC DT according to
generic channel bindings. The STM32 driver does not support a mixed use
of legacy and generic channels. When generic channels are defined,
legacy channel are ignored. This involves that the board device trees
using legacy bindings have to be changed to generic bindings.

Adopt generic iio bindings on all STM32 boards implementing the ADC.

This serie does not update stm32mp15xx-dhcom-som and
stm32mp15xx-dhcor-avenger96 DTs. These DTs have to be updated also, but
this change is already handled through the following patch:
https://lore.kernel.org/linux-arm-kernel/20230518020547.487670-1-marex@denx.de/T/

Olivier Moysan (8):
  ARM: dts: stm32: add adc internal channels to stm32mp15
  ARM: dts: stm32: add vrefint calibration on stm32mp15
  ARM: dts: stm32: add vrefint support to adc2 on stm32mp15
  ARM: dts: stm32: enable adc on stm32mp15xx-dkx boards
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    stm32mp157c-ed1
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    emstamp-argon
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    dhcor-drc
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    dhcor-testbench

 arch/arm/boot/dts/stm32mp151.dtsi             | 17 +++++++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts         | 16 ++++++++--
 .../boot/dts/stm32mp157c-emstamp-argon.dtsi   |  6 ++--
 .../dts/stm32mp15xx-dhcor-drc-compact.dtsi    | 28 +++++++++++++++---
 .../boot/dts/stm32mp15xx-dhcor-testbench.dtsi | 28 +++++++++++++++---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        | 29 +++++++++++++------
 6 files changed, 102 insertions(+), 22 deletions(-)

-- 
2.25.1

