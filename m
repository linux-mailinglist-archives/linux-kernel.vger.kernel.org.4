Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095FD6EF216
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbjDZKdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbjDZKdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:33:07 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2819D4C17;
        Wed, 26 Apr 2023 03:32:45 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33QAWQHR009811;
        Wed, 26 Apr 2023 05:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682505146;
        bh=7Z6/SCLPql2DuDI4vd2rYWj5VTpLh2+8H5h1OEbyHJw=;
        h=From:To:CC:Subject:Date;
        b=Q8SJ09o4r2v9LQmVZ0ZXtqj1R2CEs6d3MEJWgpb8vYOuAGtQ/bRxvUC1vQKcnMxq6
         R8Om0tjSKUt6J55qnoycxJaDHhkOVwSlriNv7lR01epzwOgH5+Q5MESIg089vjC960
         kiPz1X05dTZx+FdQP7yBt5nWRV6ZFGqA7Tx4tXCY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33QAWQaV079474
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 05:32:26 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Apr 2023 05:32:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 05:32:25 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33QAWLRS036567;
        Wed, 26 Apr 2023 05:32:22 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <m-chawdhry@ti.com>, <n-francis@ti.com>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 0/5] arm64: dts: ti: k3-j7200: Add properties and sync with uboot
Date:   Wed, 26 Apr 2023 16:02:14 +0530
Message-ID: <20230426103219.1565266-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In continuation of patch series posted by Nishanth
for sync of uboot device tree with kernel device tree for AM64 SOC.
https://lore.kernel.org/linux-arm-kernel/20230414073328.381336-1-nm@ti.com/

This series extend device tree sync/clean up for J7200 SOC.

This patch series build on top of
https://lore.kernel.org/all/20230419040007.3022780-1-u-kumar1@ti.com


Udit Kumar (5):
  arm64: dts: ti: k3-j7200: Add general purpose timers
  arm64: dts: ti: k3-j7200: Configure pinctrl for timer IO pads
  arm64: dts: ti: k3-j7200-common-proc-board: main_pmx0 clean up
  arm64: dts: ti: k3-j7200-common-proc-board: Add uart pin mux in
    wkup_pmx0
  arm64: dts: ti: k3-j7200: Add bootph-pre-ram for u-boot

 .../dts/ti/k3-j7200-common-proc-board.dts     |  37 ++-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 258 ++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 138 ++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |   3 +
 4 files changed, 432 insertions(+), 4 deletions(-)

-- 
2.34.1

