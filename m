Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EFD712952
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbjEZPX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244086AbjEZPXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:23:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA14C1B3;
        Fri, 26 May 2023 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685114596; x=1716650596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=unOxtB7tBB2YNhdiIZJikYDHTwMKYxnHDpsFZ3ZCKKM=;
  b=btvwQ0r8+hZ3hy1Z2ykpj2kpX8Xn2/UiVtLbX033ZdEJ4LFLB3qjj0zO
   +raVoGqE6ntOF4pbZBxjqjwNjVX3Bxek8LgtJgcJhMOaJIyv5pS8rE1Lp
   K0THmz3p4QqMlmd9Krg+7wepWh9eb897BndNBtT8CILkEJFG35mvDhLxX
   CMdql2gyX4AG9o4XmNgaJLzQykE5s51CT1+Vj143Z9wTRmyEali3XC1hz
   cN/VFliHW2rz2Cd/HzXG8hmTgZvJ8KfSysNohgm11w+fKF4ays86fcqbh
   HPZZNxATjfAgb17SF/n8BttigJctKRwkYCO6HmPB682ULPoDIjlqA0Voh
   g==;
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="215649783"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2023 08:23:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 26 May 2023 08:22:41 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 26 May 2023 08:22:36 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <ramon.nordin.rodriguez@ferroamp.se>
CC:     <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
        "Parthiban Veerasooran" <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v4 0/6] microchip_t1s: Update on Microchip 10BASE-T1S PHY driver
Date:   Fri, 26 May 2023 20:53:42 +0530
Message-ID: <20230526152348.70781-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contain the below updates,
- Fixes on the Microchip LAN8670/1/2 10BASE-T1S PHYs support in the
  net/phy/microchip_t1s.c driver.
- Adds support for the Microchip LAN8650/1 Rev.B0 10BASE-T1S Internal
  PHYs in the net/phy/microchip_t1s.c driver.

Changes:
v2:
- Updated cover letter contents.
- Modified driver description is more generic as it is common for all the
  Microchip 10BASE-T1S PHYs.
- Replaced read-modify-write code with phy_modify_mmd function.
- Moved */ to the same line for the single line comments.
- Changed the type int to u16 for LAN865X Rev.B0 fixup registers
  declaration.
- Changed all the comments starting letter to upper case for the
  consistency.
- Removed return value check of phy_read_mmd and returned directly in the
  last line of the function lan865x_revb0_indirect_read.
- Used reverse christmas notation wherever is possible.
- Used FIELD_PREP instead of << in all the places.
- Used 4 byte representation for all the register addresses and values
  for consistency.
- Comment for indirect read is modified.
- Implemented "Reset Complete" status polling in config_init.
- Function lan865x_setup_cfgparam is split into multiple functions for
  readability.
- Reference to AN1760 document is added in the comment.
- Removed interrupt disabling code as it is not needed.
- Provided meaningful macros for the LAN865X Rev.B0 indirect read
  registers and control.
- Replaced 0x10 with BIT(4).
- Removed collision detection disable/enable code as it can be done with
  a separate patch later.

v3:
- Comment for phy_modify_mmd() is extended to indicate that the write is
  not required if the register already has the required value.
- Commit message is updated for the not supported hardware revisions
  0x0007C160 (Rev.A0) and 0x0007C161 (Rev.B0) since they are never
  released to production.
- Commit message is updated to indicate that the Reset Complete interrupt
  will be cleared when the STS2 register read is done.
- Corrected the typo in the offset calculation comment.
- Used reverse christmas notation for the local variable declarations.

v4:
- Reset complete block comment updated to describe the 5us sleep.
- read-modify-write block comment modified and added reference to AN1699.
- LAN8670/1/2 Rev.B1 and LAN8650/1 Rev.B0 details updated in Kconfig file.
- Removed return value check of lan865x_setup_cfgparam() and returned
  directly in the last line of the function lan865x_revb0_config_init.

Parthiban Veerasooran (6):
  net: phy: microchip_t1s: modify driver description to be more generic
  net: phy: microchip_t1s: replace read-modify-write code with
    phy_modify_mmd
  net: phy: microchip_t1s: update LAN867x PHY supported revision number
  net: phy: microchip_t1s: fix reset complete status handling
  net: phy: microchip_t1s: remove unnecessary interrupts disabling code
  net: phy: microchip_t1s: add support for Microchip LAN865x Rev.B0 PHYs

 drivers/net/phy/Kconfig         |   5 +-
 drivers/net/phy/microchip_t1s.c | 274 ++++++++++++++++++++++++++------
 2 files changed, 224 insertions(+), 55 deletions(-)

-- 
2.34.1

