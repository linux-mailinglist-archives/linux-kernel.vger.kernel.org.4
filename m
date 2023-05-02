Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCFD6F4D79
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 01:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjEBXPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 19:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBXPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 19:15:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A06C26A9;
        Tue,  2 May 2023 16:15:44 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 342NFRNJ005676;
        Tue, 2 May 2023 18:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683069327;
        bh=rO3x08YYa6XbuAIULHSQ31VQY29fYqGzY1482CJ8rv8=;
        h=From:To:CC:Subject:Date;
        b=o5exQk9RRn6KLYJ2ZO1ehv5iIQmyduMRToO20o91GG2t89Gh8aL1uadVGqDuYSF0h
         SrSoUCMB+N0lrW+wXn1VWS9zO/Jd1AS0+Ojg6/ILFv1axDzpNRmbGHDHxk2fAmiwzh
         g9zumZK0HD45AGvgxt16iARz2DhdGFyLOdYzxNdI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 342NFRkp081509
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 May 2023 18:15:27 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 May 2023 18:15:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 May 2023 18:15:27 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 342NFRxQ073381;
        Tue, 2 May 2023 18:15:27 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] Add R5F and C71 DSP nodes for J784S4 SoC
Date:   Tue, 2 May 2023 18:15:24 -0500
Message-ID: <20230502231527.25879-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the R5F cluster and C71 DSP processor nodes for
J784S4 SoC.

The first patch adds R5F cluster nodes to the MAIN and MCU voltage
domains of J784S4 SoC. The second patch adds the C71 DSP processor
nodes to the MAIN voltage domain of J784S4 SoC and the third patch
reserves the IPC shared memory for Virtio/Vring buffers.

Changes in V3:
- Add memory reservations for remote proc IPC in board file.
V2: https://lore.kernel.org/all/20230330141536.22480-1-hnagalla@ti.com/ 

Changes in V2:
- Removed default disable of R5F nodes in the SoC device tree.
- Consolidated R5F nodes into one patch.
V1: https://lore.kernel.org/all/20230329093627.30719-1-hnagalla@ti.com/

Hari Nagalla (3):
  arm64: dts: ti: k3-j784s4-main: Add R5F cluster nodes
  arm64: dts: ti: k3-j784s4-main: Add C71x DSP nodes
  arm64: dts: ti: k3-j784s4-evm: Reserve memory for remote proc IPC

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 318 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 168 +++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  40 +++
 3 files changed, 526 insertions(+)

-- 
2.34.1

