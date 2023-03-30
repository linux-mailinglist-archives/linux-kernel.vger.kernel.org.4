Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14586D07D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjC3OP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjC3OPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:15:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A87DBA;
        Thu, 30 Mar 2023 07:15:49 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32UEFaHx069326;
        Thu, 30 Mar 2023 09:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680185736;
        bh=s8xqnYRS46Sx2gJGEo9byjHCVBxhtiV7LJjXz3AhOaA=;
        h=From:To:CC:Subject:Date;
        b=lwOacpEK3Kze9UwwNOjrjR74xEt9okmVxG6vWq7BTNPzz2UMd7E2b7cvmFlMD7mAq
         Nk2uKOcYlKpy5Og3ftTUU7lPtiA2yjIaZzjOT7xrBOAQ8aIED2M4vrJsQoBxbxqGrs
         iEwuzyuqJ56WBSVer0P6eOrGgv4A6iktwRPGsZi8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32UEFa4M121646
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 09:15:36 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 09:15:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 30 Mar 2023 09:15:36 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32UEFa6w013324;
        Thu, 30 Mar 2023 09:15:36 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add R5F and C71 DSP nodes for J784S4 SoC
Date:   Thu, 30 Mar 2023 09:15:34 -0500
Message-ID: <20230330141536.22480-1-hnagalla@ti.com>
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

The first patch adds R5F cluster nodes to the MAIN and MCU voltage 
domains of J784S4 SoC. The second patch adds the C71 DSP processor 
nodes to the MAIN voltage domain of J784S4 SoC.

Changes in V2:
- Removed default disable of R5F nodes in the SoC device tree.
- Consolidated R5F nodes into one patch.

V1: https://lore.kernel.org/all/20230329093627.30719-1-hnagalla@ti.com/

Hari Nagalla (2):
  arm64: dts: ti: k3-j784s4-main: Add R5F cluster nodes
  arm64: dts: ti: k3-j784s4-main: Add C71x DSP nodes

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 168 ++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  40 +++++
 2 files changed, 208 insertions(+)

-- 
2.17.1

