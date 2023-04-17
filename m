Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3DC6E417B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjDQHm0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 03:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjDQHmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:42:20 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFED1AD;
        Mon, 17 Apr 2023 00:41:45 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DE41324E2A9;
        Mon, 17 Apr 2023 15:41:16 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Apr
 2023 15:41:16 +0800
Received: from ubuntu.localdomain (183.27.97.249) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Apr
 2023 15:41:16 +0800
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
Subject: [PATCH v1 0/2] A fix for StarFive JH7110 clock drivers
Date:   Mon, 17 Apr 2023 15:41:13 +0800
Message-ID: <20230417074115.30786-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stephen,

This series fix some issues of StarFive JH7110 sys and aon clock drivers.

The first patch fix two issues [1] [2] reported by kernel test robot.

The second patch is an addition to patch [3]. It removes the redundant
dev_set_drvdata().

[1] https://lore.kernel.org/oe-kbuild-all/202304140256.aIlJMfbA-lkp@intel.com/
[2] https://lore.kernel.org/oe-kbuild-all/202304140706.aOBNhUj2-lkp@intel.com/
[3] https://lore.kernel.org/all/20230413205528.4044216-1-sboyd@kernel.org/

Hal Feng (2):
  clk: starfive: Fix RESET_STARFIVE_JH7110 can't be selected in a
    specified case
  clk: starfive: Delete the redundant dev_set_drvdata() in JH7110 clock
    drivers

 drivers/clk/starfive/Kconfig                   | 5 +----
 drivers/clk/starfive/clk-starfive-jh7110-aon.c | 2 --
 drivers/clk/starfive/clk-starfive-jh7110-sys.c | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

-- 
2.38.1

