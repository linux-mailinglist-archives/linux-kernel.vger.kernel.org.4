Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D796CD697
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjC2Jgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjC2Jgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:36:39 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA5035A1;
        Wed, 29 Mar 2023 02:36:35 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32T9aSFM042827;
        Wed, 29 Mar 2023 04:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680082588;
        bh=Aqq55wD7oQa01baydqMWGtE3GYWr/E+MHrvD1W787kI=;
        h=From:To:CC:Subject:Date;
        b=wU++aWjUSkhH9Es1gE3YMMMOrFZtm72RLe/FkxRMPGceHWr89oUhgm7pqQfBtZmNh
         fcku+yBx6Wjj2mQ1bVsrSN4c891Z3S0Xo6IJJ5FbBiWWe89Ao8ipvd7H3Yljcpq7B1
         8ElYfyCZ3W13oIvkG44h2FPIdLiD0cE1RiXKPM/I=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32T9aStO030720
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 04:36:28 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 04:36:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 04:36:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32T9aRos006487;
        Wed, 29 Mar 2023 04:36:27 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add R5F and C71 DSP nodes for J784S4 SoC
Date:   Wed, 29 Mar 2023 04:36:24 -0500
Message-ID: <20230329093627.30719-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the R5F cluster and C71 DSP processor nodes for
J784S4 SoC.

The first and second patches add R5F cluster nodes to the MAIN and
MCU voltage domains of J784S4 SoC. The third patch adds the C71 DSP
processor nodes to the MAIN voltage domain of J784S4 SoC.

Hari Nagalla (3):
  arm64: dts: ti: k3-j784s4-main: Add MAIN domain R5F cluster nodes
  arm64: dts: ti: k3-j784s4-mcu: Add MCU domain R5F cluster node
  arm64: dts: ti: k3-j784s4-main: Add C71x DSP nodes

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 180 ++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  42 ++++
 2 files changed, 222 insertions(+)

-- 
2.17.1

