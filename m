Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239BA64F165
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiLPTH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLPTH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:07:27 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Dec 2022 11:07:25 PST
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58A2F24086;
        Fri, 16 Dec 2022 11:07:25 -0800 (PST)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id BA47140A06; Fri, 16 Dec 2022 18:03:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org BA47140A06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1671210228;
        bh=9DqqlWWZc0U7BIINrR5vZz1Zxbg1KcdqedMklEahsfQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Ozjnln9RyGHia3c3O03KaR1ZGoMj+pht+T4+spmVU5AYdB2EoSdZVTZ8lsSjm6A+t
         6anrlvT+iEdNp96ydTeu3AN9ou6oSiED0iJyNSoSD7ezqeWTaQbtJ7lWetKCfWGFIi
         kpXCfJszaDb8rM0knW0YofYjtfmMfCUF8jaLNoQE=
Date:   Fri, 16 Dec 2022 18:03:48 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Eddie James <eajames@linux.ibm.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Runyang Chen <runyang.chen@mediatek.com>,
        Thomas Kastner <thomas.kastner@advantech.com>
Subject: [GIT PULL REQUEST] watchdog - v6.2 release cycle.
Message-ID: <20221216170348.GA21326@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull following watchdog changes for the v5.19 release cycle.

This series contains:
* Add Advantech EC watchdog driver
* Add support for MT6795 Helio X10 watchdog and toprgu
* Add support for MT8188 watchdog device
* Remove #ifdef guards for PM related functions
* Other fixes and improvements

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.2-rc1

for you to fetch changes up to 9ec0b7e06835b857f892feb2fe6121db1393425d:

  watchdog: aspeed: Enable pre-timeout interrupt (2022-11-19 15:30:41 +0100)

----------------------------------------------------------------
linux-watchdog 6.2-rc1 tag

----------------------------------------------------------------
Allen-KH Cheng (1):
      dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT8173

AngeloGioacchino Del Regno (3):
      watchdog: mtk_wdt: Add support for MT6795 Helio X10 watchdog and toprgu
      dt-bindings: watchdog: mediatek: Convert mtk-wdt to json-schema
      dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT6795

Eddie James (1):
      watchdog: aspeed: Enable pre-timeout interrupt

Marcus Folkesson (1):
      watchdog: rn5t618: add support for read out bootstatus

Mika Westerberg (1):
      watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already running

Paul Cercueil (4):
      watchdog: at91rm9200: Remove #ifdef guards for PM related functions
      watchdog: twl4030: Remove #ifdef guards for PM related functions
      watchdog: omap: Remove #ifdef guards for PM related functions
      watchdog: kempld: Remove #ifdef guards for PM related functions

Runyang Chen (3):
      dt-bindings: watchdog: Add compatible for MediaTek MT8188
      dt-bindings: reset: mt8188: add toprgu reset-controller header file
      watchdog: mediatek: mt8188: add wdt support

Thomas Kastner (1):
      watchdog: Add Advantech EC watchdog driver

 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |  80 ++++++++
 .../devicetree/bindings/watchdog/mtk-wdt.txt       |  42 -----
 drivers/watchdog/Kconfig                           |   7 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/advantech_ec_wdt.c                | 205 +++++++++++++++++++++
 drivers/watchdog/aspeed_wdt.c                      | 104 +++++++++--
 drivers/watchdog/at91rm9200_wdt.c                  |  11 +-
 drivers/watchdog/db8500_wdt.c                      |   9 +-
 drivers/watchdog/iTCO_wdt.c                        |  21 ++-
 drivers/watchdog/kempld_wdt.c                      |  11 +-
 drivers/watchdog/mtk_wdt.c                         |  12 ++
 drivers/watchdog/omap_wdt.c                        |  11 +-
 drivers/watchdog/rn5t618_wdt.c                     |  12 ++
 drivers/watchdog/twl4030_wdt.c                     |   9 +-
 include/dt-bindings/reset/mt8188-resets.h          |  36 ++++
 include/linux/mfd/rn5t618.h                        |   9 +
 16 files changed, 474 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
 create mode 100644 drivers/watchdog/advantech_ec_wdt.c
 create mode 100644 include/dt-bindings/reset/mt8188-resets.h
----------------------------------------------------------------

Kind regards,
Wim.

