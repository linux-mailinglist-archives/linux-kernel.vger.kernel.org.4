Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A70609216
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJWJtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJWJtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:49:05 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E0358148
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666518543; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=I1xloFSZ18jc2PJn2boeaypvLilS6j8tqfekKDLMabQ=;
        b=r8ZlM8tmt0FZBA5TldfCn1kmsDwlF79qaiaAyY2rzpccPcSPZFUkNqj+bBpu+LM/vhrdct
        cCjdl9iUELiyDD+MtUv6Bm4tR5hM3RTz48nYgaeXKEX/2iALS52lfYC8EQRaL7ueHElg60
        /T0SICPfm3F4jsX1bIW0RWOwE/m/j+c=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 00/28] mfd: Remove #ifdef guards for PM functions
Date:   Sun, 23 Oct 2022 10:48:24 +0100
Message-Id: <20221023094852.8035-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Here's my V3 patchset that removes #ifdef guards around PM functions.

V2's patch [01/30] which introduced the new PM export macros have been
merged, so it's been dropped from this patchset.

That's pretty much the only change since V2. The other change is that
the patch to the 'intel_soc_pmic' driver was dropped since the driver
itself was dropped.

All the remaining 28 patches are untouched since V2.

Cheers,
-Paul

Paul Cercueil (28):
  mfd: 88pm80x: Remove #ifdef guards for PM related functions
  mfd: aat2870: Remove #ifdef guards for PM related functions
  mfd: adp5520: Remove #ifdef guards for PM related functions
  mfd: max8925-i2c: Remove #ifdef guards for PM related functions
  mfd: mt6397-irq: Remove #ifdef guards for PM related functions
  mfd: pcf50633: Remove #ifdef guards for PM related functions
  mfd: rc5t583-irq: Remove #ifdef guards for PM related functions
  mfd: stpmic1: Remove #ifdef guards for PM related functions
  mfd: ucb1x00: Remove #ifdef guards for PM related functions
  mfd: 88pm860x: Remove #ifdef guards for PM related functions
  mfd: mcp-sa11x0: Remove #ifdef guards for PM related functions
  mfd: sec: Remove #ifdef guards for PM related functions
  mfd: sm501: Remove #ifdef guards for PM related functions
  mfd: tc6387xb: Remove #ifdef guards for PM related functions
  mfd: tps6586x: Remove #ifdef guards for PM related functions
  mfd: wm8994: Remove #ifdef guards for PM related functions
  mfd: max77620: Remove #ifdef guards for PM related functions
  mfd: t7l66xb: Remove #ifdef guards for PM related functions
  mfd: arizona: Remove #ifdef guards for PM related functions
  mfd: max14577: Remove #ifdef guards for PM related functions
  mfd: max77686: Remove #ifdef guards for PM related functions
  mfd: motorola-cpcap: Remove #ifdef guards for PM related functions
  mfd: sprd-sc27xx: Remove #ifdef guards for PM related functions
  mfd: stmfx: Remove #ifdef guards for PM related functions
  mfd: stmpe: Remove #ifdef guards for PM related functions
  mfd: tc3589x: Remove #ifdef guards for PM related functions
  mfd: tc6393xb: Remove #ifdef guards for PM related functions
  mfd: intel-lpss: Remove #ifdef guards for PM related functions

 drivers/mfd/88pm800.c             |  2 +-
 drivers/mfd/88pm805.c             |  2 +-
 drivers/mfd/88pm80x.c             |  5 +----
 drivers/mfd/88pm860x-core.c       |  6 ++----
 drivers/mfd/aat2870-core.c        |  8 +++-----
 drivers/mfd/adp5520.c             |  6 ++----
 drivers/mfd/arizona-core.c        | 19 +++++++------------
 drivers/mfd/arizona-i2c.c         |  2 +-
 drivers/mfd/arizona-spi.c         |  2 +-
 drivers/mfd/intel-lpss-acpi.c     |  4 +---
 drivers/mfd/intel-lpss-pci.c      |  2 +-
 drivers/mfd/intel-lpss.c          | 15 +++++++++------
 drivers/mfd/intel-lpss.h          | 28 +---------------------------
 drivers/mfd/max14577.c            |  6 ++----
 drivers/mfd/max77620.c            |  9 +++------
 drivers/mfd/max77686.c            |  6 ++----
 drivers/mfd/max8925-i2c.c         |  7 +++----
 drivers/mfd/mcp-sa11x0.c          |  6 +-----
 drivers/mfd/motorola-cpcap.c      |  6 ++----
 drivers/mfd/mt6397-irq.c          |  6 +-----
 drivers/mfd/pcf50633-core.c       | 22 +---------------------
 drivers/mfd/pcf50633-irq.c        | 13 ++++++++-----
 drivers/mfd/rc5t583-irq.c         |  7 ++-----
 drivers/mfd/sec-core.c            |  7 +++----
 drivers/mfd/sm501.c               | 10 ++--------
 drivers/mfd/sprd-sc27xx-spi.c     |  7 +++----
 drivers/mfd/stmfx.c               |  6 ++----
 drivers/mfd/stmpe-i2c.c           |  4 +---
 drivers/mfd/stmpe-spi.c           |  4 +---
 drivers/mfd/stmpe.c               |  8 ++------
 drivers/mfd/stpmic1.c             |  6 ++----
 drivers/mfd/t7l66xb.c             |  9 ++-------
 drivers/mfd/tc3589x.c             |  7 +++----
 drivers/mfd/tc6387xb.c            |  9 ++-------
 drivers/mfd/tc6393xb.c            |  9 ++-------
 drivers/mfd/tps6586x.c            |  6 +-----
 drivers/mfd/ucb1x00-core.c        |  7 +++----
 drivers/mfd/wm8994-core.c         |  6 ++----
 include/linux/mfd/pcf50633/core.h |  6 ++----
 include/linux/mfd/stmfx.h         |  2 --
 40 files changed, 89 insertions(+), 213 deletions(-)

-- 
2.35.1

