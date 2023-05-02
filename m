Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C992A6F45D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjEBOOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjEBOOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:14:39 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDC011F;
        Tue,  2 May 2023 07:14:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 342EEHgH111954;
        Tue, 2 May 2023 09:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683036857;
        bh=kQduM7gFnZ2A48end6fAIovkcu/rtPNeBncSv6ady9A=;
        h=From:To:CC:Subject:Date;
        b=qewjUO6bkuth2cXXJkBHsv9EG7qadu+Pf8yHGATW+q87A1csIPxtJqPq1li9D/WSK
         /Hd/RM5rJyX4DDoslp5UlRXrPzk/bEwy7aClfUU4vKb19DUwmE6R4U9XKHLv3Y5/qt
         3L9EcJjb0Dbkeh2w66Z8J0fE1N7VSdWeGHa3gmus=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 342EEHuQ066371
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 May 2023 09:14:17 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 May 2023 09:14:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 May 2023 09:14:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 342EEGT7001016;
        Tue, 2 May 2023 09:14:16 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add R5F and C7x DSP nodes for AM62a SoC
Date:   Tue, 2 May 2023 09:14:14 -0500
Message-ID: <20230502141416.9924-1-hnagalla@ti.com>
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

This series adds the R5F processor nodes and C7x DSP node for
AM62a SoC.

The first patch adds the nodes to the SoC device tree and the second
patch reserves the memory for remote rpoc IPCs on AM62a-SK.

Hari Nagalla (2):
  arm64: dts: ti: k3-am62a: Add remote proc nodes
  arm64: dts: ti: k3-am62a7-sk: Enable remote proc nodes

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   | 11 ++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi    | 23 +++++++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 23 +++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts     | 69 +++++++++++++++++++++
 4 files changed, 126 insertions(+)

-- 
2.34.1

