Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133496F3ED4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjEBILl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjEBILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:11:32 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6F3E58;
        Tue,  2 May 2023 01:11:31 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3428BI5o002134;
        Tue, 2 May 2023 03:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683015078;
        bh=Z3KcxrDHdMIHoFhHo1GxLMoptVTCt6fGvV4/z7Hj1FM=;
        h=From:To:CC:Subject:Date;
        b=v2QHyneXYGGQFpNj31hI9d0+rj/rO+yliGFZID8EyyUfP3XMeaAY/LBYGutyG916R
         yXBUVaZlQwNCg85QOVkfdtJCVdJboqY1ee7aHWY8vOUFygCIXoWnR1rkvGyrG8nfkv
         Z/MiCfhKiOkuesGcih2n9tkfXHtkLMVZe1lHsdiE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3428BIbi071743
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 May 2023 03:11:18 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 May 2023 03:11:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 May 2023 03:11:18 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3428BHZN069149;
        Tue, 2 May 2023 03:11:18 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <b-kapoor@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH v2 0/2] arm64: dts: ti: k3-j784s4: Add support for ADC nodes
Date:   Tue, 2 May 2023 13:41:15 +0530
Message-ID: <20230502081117.21431-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

J784S4 has two instances of 8 channel ADCs in MCU domain. Add support
for both ADC nodes in dtsi file. Add pinmux information for both
instances of ADC in board dts file.

Link to v1 -> https://lore.kernel.org/all/0f553758-c2cc-ce70-47e0-99e08c2d94a1@ti.com/

Changelog v1->v2 :
- Modified indentation according to Vignesh's Comments

Bhavya Kapoor (2):
  arm64: dts: ti: k3-j784s4-mcu-wakeup: Add support for ADC nodes
  arm64: dts: ti: k3-j784s4-evm: Add pinmux information for ADC

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 44 +++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 40 +++++++++++++++++
 2 files changed, 84 insertions(+)

-- 
2.34.1

