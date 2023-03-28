Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543416CC6BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjC1PkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjC1Pjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:39:51 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D2BF778;
        Tue, 28 Mar 2023 08:38:25 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SEFZfT005918;
        Tue, 28 Mar 2023 17:37:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=7FikNAgVQUDv7CDM0c6ACVV1+rjHVWpaEeehVcGfFZU=;
 b=08e+AyRM5KBwiHBi5930iRvuArBIehmoBzFIxovfEUUFNEwqmOTViog8+akV3QzHb0lb
 wlY6uWIOm2f63SmMuBLgHrvMvUdjCblaHmSKb97Gl60C6Me3XxSexLNHFPGlfktM1XE8
 BuvXHCAPzfibtGOl1QPbHplsqKQ7cLjqrqMTntYO0EBhl9fMAIGS1yRbH1ikCch8ANrs
 PXrQknQK0VXxPBd/+VjTQQFMLM4EgeKdSiGtDcGRUMjEGqqC/+57pw+sZWwOU0hrGyjr
 4EMftF/Ri5ByqwnY1GEvn8UCp07t/1tDqLnqNYXq4ECewju2BJzVd0oV9FgHPO9Yt3Oc Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pk5xkjtk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 17:37:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 39A1310002A;
        Tue, 28 Mar 2023 17:37:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 33CD82171C4;
        Tue, 28 Mar 2023 17:37:36 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 17:37:35 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] ARM: dts: stm32: stm32mp15 various fixes and add stm32mp13 usart nodes
Date:   Tue, 28 Mar 2023 17:37:17 +0200
Message-ID: <20230328153723.498672-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On stm32mp15 device trees:
  - Fix pins of USART2 of stm32mp15 dk* boards
  - Remove duplicates serial aliases

On stm32mp13 device trees:
  - Add USART nodes in stm32mp131.dtsi
  - Add USART nodes in stm32mp135f-dk.dts
  
Changes in v2:
  - Drop patch about SCMI clock of USART1.

Valentin Caron (6):
  ARM: dts: stm32: fix slew-rate of USART2 on stm32mp15xx-dkx
  ARM: dts: stm32: clean uart aliases on stm32mp15xx-dkx boards
  ARM: dts: stm32: clean uart aliases on stm32mp15xx-exx boards
  ARM: dts: stm32: add uart nodes on stm32mp13
  ARM: dts: stm32: add pins for usart2/1/4/8 in stm32mp13-pinctrl
  ARM: dts: stm32: add uart nodes and uart aliases on stm32mp135f-dk

 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi | 129 +++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp131.dtsi        |  97 ++++++++++++++++-
 arch/arm/boot/dts/stm32mp135f-dk.dts     |  42 +++++++-
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi |   4 +-
 arch/arm/boot/dts/stm32mp157a-dk1.dts    |   3 -
 arch/arm/boot/dts/stm32mp157c-dk2.dts    |   3 -
 arch/arm/boot/dts/stm32mp157c-ed1.dts    |   8 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts    |   9 +-
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi   |   6 ++
 9 files changed, 282 insertions(+), 19 deletions(-)

-- 
2.25.1

