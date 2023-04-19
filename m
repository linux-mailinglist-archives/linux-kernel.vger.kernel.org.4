Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B86B6E7204
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjDSEA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjDSEAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:00:23 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC34ABD;
        Tue, 18 Apr 2023 21:00:22 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33J40E13107323;
        Tue, 18 Apr 2023 23:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681876814;
        bh=D7N9oEiMeH0cs8Jb4a+GvCOLQmW6tz03TJAssHRZGHk=;
        h=From:To:CC:Subject:Date;
        b=jzgueHFP5iq32t3Nry3vFnh5E6B0DXnXlIllxoy3ulMvleCAFM2a7Cc8egF2hJ5lr
         CaHcxy1Nup+1QdCaV+G8rJ01Wc4dgAd5ELx+YwD41Pi+QaZBrJt9HVoo4Oeov5Lmdu
         q8u8KyOByeYv2LTHcZh15A0r2fR+8BbTQj58PPSs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33J40EtC113377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Apr 2023 23:00:14 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 18
 Apr 2023 23:00:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 18 Apr 2023 23:00:13 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33J4098U025277;
        Tue, 18 Apr 2023 23:00:10 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <bb@ti.com>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v3 0/2] arm64: dts: ti: k3-j7200-common-proc-board fixes
Date:   Wed, 19 Apr 2023 09:30:05 +0530
Message-ID: <20230419040007.3022780-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes the pin mux configuration and enable
wkup_i2c0 at board level.

Note to self: in u-boot i2c pin mux is set in R5 board file.
which will moved to som file, Fix that too when syncing kernel
and uboot DTS files.

Changes since v2:
https://lore.kernel.org/all/20230418050514.2392717-1-u-kumar1@ti.com/
Pin Mux (Patch 1/1):
- No Change

wkup_i2c:
- Added pin mux
- Added speed

Changes since v1:
https://lore.kernel.org/all/20230414181434.2046049-1-u-kumar1@ti.com/
Pin mux:
- Fixed commit message and author

wkup_i2c:
- Removed Fixes tag in commit message
- Moved wkup_i2c in som instead of common board
- Added eeprom as child device


Keerthy (1):
  arm64: dts: ti: k3-j7200: Fix  physical address of pin

Udit Kumar (1):
  arm64: dts: ti: k3-j7200-som: Enable I2C

 .../dts/ti/k3-j7200-common-proc-board.dts     | 28 +++++++++----------
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 21 ++++++++++++++
 2 files changed, 35 insertions(+), 14 deletions(-)

-- 
2.34.1

