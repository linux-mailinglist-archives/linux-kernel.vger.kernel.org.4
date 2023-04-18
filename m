Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCE96E6323
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjDRMiM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 08:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDRMiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:38:09 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A52513877;
        Tue, 18 Apr 2023 05:38:01 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1164D24E311;
        Tue, 18 Apr 2023 20:37:59 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Apr
 2023 20:37:59 +0800
Received: from ubuntu.localdomain (113.72.144.253) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Apr
 2023 20:37:58 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-clk@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <linux-mm@kvack.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Paul Gazzillo" <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/1] A fix for StarFive JH7110 clock drivers
Date:   Tue, 18 Apr 2023 20:37:55 +0800
Message-ID: <20230418123756.62495-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fix some issues of StarFive JH7110 sys and aon clock drivers.

The first patch fix two issues [1] [2] reported by kernel test robot.

The second patch is accepted in v1 so drop it in v2.

[1] https://lore.kernel.org/oe-kbuild-all/202304140256.aIlJMfbA-lkp@intel.com/
[2] https://lore.kernel.org/oe-kbuild-all/202304140706.aOBNhUj2-lkp@intel.com/

Changes since v1:
- Drop patch 2 since it is accepted.
- Change `select RESET_STARFIVE_JH7110 if ARCH_STARFIVE` to
  `select RESET_STARFIVE_JH7110 if RESET_CONTROLLER`.
- Change the commit message accordingly.

---
History:
v1: https://lore.kernel.org/all/20230417074115.30786-1-hal.feng@starfivetech.com/

Hal Feng (1):
  clk: starfive: Fix RESET_STARFIVE_JH7110 can't be selected in a
    specified case

 drivers/clk/starfive/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
2.38.1

