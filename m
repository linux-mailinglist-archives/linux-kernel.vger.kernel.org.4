Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4768B401
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBFBpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBFBpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:45:45 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 036971ADC0;
        Sun,  5 Feb 2023 17:45:41 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(20362:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Mon, 06 Feb 2023 09:45:24 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 6 Feb
 2023 09:45:23 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Mon, 6 Feb 2023 09:45:23 +0800
From:   <cy_huang@richtek.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <cy_huang@richtek.com>, <allen_chiang@richtek.com>,
        <u0084500@gmail.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 0/3] Add Richtek RT9759 smart cap divider charger support
Date:   Mon, 6 Feb 2023 09:45:16 +0800
Message-ID: <1675647919-11151-1-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch set is to add Richtek RT9759 smart cap divider charger.

The RT9759 is a high efficiency and high charge current charger.
The efficiency is up to 97.8% when VBAT=4.2V, IBAT=2.5A, and the maximum
charge current is up to 8A. The device integrates smart cap divider topology
with a dual-phase charge pump core and 9 channel high speed ADCs to monitor
the charging process.

Since v4:
- Since it's 2023 now, change date from 2022 to 2023 for source code and ABI.

Since v3:
- Fix 0002 patch title typo (from 'rt9471' to 'rt9759')
- Remove unused R_VAC_OVP range.
- Refer to ABI document, use 'status' to control battery charging, not 'online'
- Refer to ABI document, use 'online' to indicate bus state

Since v2:
- Add Reviewed-by tag for dt-binding patch
- Change ABI document date from Oct 2022 to Nov 2022 and KernelVersion
  from 6.1 to 6.2

ChiYuan Huang (3):
  dt-bindings: power: supply: Add Richtek RT9759 smart cap divider
    charger
  power: supply: Add Richtek RT9759 smart cap divider charger
  Documentation: power: rt9759: Document exported sysfs entries

 Documentation/ABI/testing/sysfs-class-power-rt9759 |  37 ++
 .../bindings/power/supply/richtek,rt9759.yaml      |  61 ++
 drivers/power/supply/Kconfig                       |  15 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt9759.c                      | 613 +++++++++++++++++++++
 5 files changed, 727 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9759
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
 create mode 100644 drivers/power/supply/rt9759.c

-- 
2.7.4

