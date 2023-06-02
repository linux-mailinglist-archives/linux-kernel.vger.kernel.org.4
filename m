Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E732720B30
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbjFBVtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbjFBVtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:49:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786E41B5;
        Fri,  2 Jun 2023 14:49:45 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 352LndS3103173;
        Fri, 2 Jun 2023 16:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685742579;
        bh=8S6Iqe+Op3Uiritpg/PwnAgN4Wo32kgL/A2rpM+EmCg=;
        h=From:To:CC:Subject:Date;
        b=Z32x9dGnEfFInvQ7e+AeYO9k3oQzINqjtPdw45FP7OIEEn24sz6W2+coFx14X1cXG
         p7VKMUKiZczRULrEyUMsIoEvhXwa6mJCPnbNg1BevUafoKcUNJM5FAC63BT8Rxzgk0
         90kKheU7h86VBwF7ZlWNE6lfeoZ0FDDTHX3YSg/M=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 352LndAd112435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Jun 2023 16:49:39 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Jun 2023 16:49:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Jun 2023 16:49:38 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 352LncAp001297;
        Fri, 2 Jun 2023 16:49:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>,
        Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH 0/8] arm64: dts: ti: k3-j784s4/am69: Add uart, i2c, eeprom, misc
Date:   Fri, 2 Jun 2023 16:49:29 -0500
Message-ID: <20230602214937.2349545-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
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

Hi,

This series picks up from where [1] left off. After fixing the mux
regions, introduce the basic i2c, uarts, ethernet, and a few alias
fixups sprinkled along with it.

This series also takes over [2] and rebased on top of [1] and my series.

Test log: 

Dasnavis Sabiya (1):
  arm64: dts: ti: k3-am69-sk: Add pinmux for RPi Header

Nishanth Menon (7):
  arm64: dts: ti: k3-j784s4-evm: Fix main_i2c0 alias
  arm64: dts: ti: k3-j784s4-evm: Add mcu and wakeup uarts
  arm64: dts: ti: k3-j784s4-evm: Enable wakeup_i2c0 and eeprom
  arm64: dts: ti: k3-am69-sk: Fix main_i2c0 alias
  arm64: dts: ti: k3-am69-sk: Enable mcu network port
  arm64: dts: ti: k3-am69-sk: Add mcu and wakeup uarts
  arm64: dts: ti: k3-am69-sk: Enable wakeup_i2c0 and eeprom

 arch/arm64/boot/dts/ti/k3-am69-sk.dts    | 165 ++++++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts |  56 +++++++-
 2 files changed, 219 insertions(+), 2 deletions(-)

[1] https://lore.kernel.org/linux-arm-kernel/20230503083143.32369-1-t-konduru@ti.com/
[2] https://lore.kernel.org/linux-arm-kernel/20230316104743.482972-3-sabiya.d@ti.com/
-- 
2.40.0

