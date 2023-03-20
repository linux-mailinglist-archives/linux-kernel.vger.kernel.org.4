Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03016C1D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjCTRQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCTRQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:16:24 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B884EEA;
        Mon, 20 Mar 2023 10:12:20 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KGpOn1130418;
        Mon, 20 Mar 2023 11:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679331084;
        bh=W2tdW3KXBrm4OiA93yJZc+cS+R6pcHzVsV3g0g+QIRo=;
        h=From:To:CC:Subject:Date;
        b=c+QptlNCyNnrzD39j+CIQUEdLJPn9bEJ/4+jzj/CDsj42d8LKKF7SwHNDSz4ThA3I
         vELYbcwARS9tyWzu6mOng4zJTOZ/aVNS1b3rrkW4NMbEuuBOv9voJEjLhAIH4kNn8Y
         VoAA9Qiq5RWTYD/C6K26A8cjZSMZK5PvC1P7R60U=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KGpOSK018466
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 11:51:24 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 11:51:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 11:51:24 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KGpNQf057381;
        Mon, 20 Mar 2023 11:51:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>, <bb@ti.com>,
        <d-gole@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 0/2] arm64: dts: ti: k3-am62: Add watchdog and rtc nodes
Date:   Mon, 20 Mar 2023 11:51:21 -0500
Message-ID: <20230320165123.80561-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Couple of Misc patches

Changes since v2:
 - Picked up Reviewed-bys
 - wdt node rename to match with TRM

V2: https://lore.kernel.org/all/20230315170706.1598977-1-nm@ti.com/
V1: https://lore.kernel.org/all/20230311105850.21811-1-nm@ti.com/#t

Julien Panis (1):
  arm64: dts: ti: k3-am62: Add watchdog nodes

Nishanth Menon (1):
  arm64: dts: ti: k3-am62-wakeup: Introduce RTC node

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 45 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    | 11 ++++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 21 ++++++++++
 3 files changed, 77 insertions(+)

-- 
2.40.0

