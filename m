Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E280715184
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjE2WKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjE2WJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:09:59 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC34DDB;
        Mon, 29 May 2023 15:09:57 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34TM9gUK083729;
        Mon, 29 May 2023 17:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685398182;
        bh=svvTzkfEI7gGmz7YJmT6ZBme166auPqO6dDsNIkRfic=;
        h=From:To:CC:Subject:Date;
        b=CT6wvt4IEqchRO9t/3lcN2Odtlo1a0C9N4S5KPsAAVMLS8rnf0NoeoLSQZITPTshF
         zO82ClKzyJoB8bNZL55t9bRsxdv3gfL/jzqCDnZ/U1Th+rMEA1fRXWCalHM7AhZxvs
         /UZ3T2ny5K1hbw4pcRwoR1XB81i/dro5Cf3JHzp4=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34TM9gCi076454
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 May 2023 17:09:42 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 May 2023 17:09:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 May 2023 17:09:41 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34TM9fSd100084;
        Mon, 29 May 2023 17:09:41 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add R5F and C7x DSP nodes for J721S2 SoC.
Date:   Mon, 29 May 2023 17:09:38 -0500
Message-ID: <20230529220941.10801-1-hnagalla@ti.com>
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

This series adds the R5F processor nodes and C7x DSP nodes for 
J721S2 SoC.

The first two patches adds the remote proc nodes to the SoC device
tree and the third patch reserves the memory for remote proc IPCs
on J721S2 EVM board.

Hari Nagalla (3):
  arm64: dts: ti: k3-j721s2-main: Add R5F and C7x remote processsor
    nodes
  arm64: dts: ti: k3-j721s2-mcu: Add R5F cluster nodes
  arm64: dts : ti: k3-j721s2-som-p0: Add DDR carveout memory nodes for
    R5F and C71x DSPs

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 128 ++++++--
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  40 +++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 286 ++++++++++++++++++
 3 files changed, 430 insertions(+), 24 deletions(-)

-- 
2.34.1

