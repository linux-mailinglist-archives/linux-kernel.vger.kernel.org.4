Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565CF5E933F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 14:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiIYM6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 08:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIYM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 08:58:01 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59B22F007
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 05:57:58 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id cRCkoBFiunj75cRCkozkIF; Sun, 25 Sep 2022 14:57:56 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 Sep 2022 14:57:56 +0200
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH] headers: Remove some left-over license text in sound/firewire
Date:   Sun, 25 Sep 2022 14:57:51 +0200
Message-Id: <2bfe76c7eeb0f5205a1427e280bf8d9da0354a62.1664110649.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is alredy a SPDX-License-Identifier tag, so the corresponding license
text can be removed.

While at it, be more consistent and:
  - add a missing .c (ff-protocol-latter)
  - remove an empty line (motu-protocol-v1)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/firewire/dice/dice-harman.c            | 2 --
 sound/firewire/dice/dice-presonus.c          | 2 --
 sound/firewire/fireface/ff-protocol-former.c | 2 --
 sound/firewire/fireface/ff-protocol-latter.c | 4 +---
 sound/firewire/motu/motu-protocol-v1.c       | 3 ---
 5 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/firewire/dice/dice-harman.c b/sound/firewire/dice/dice-harman.c
index a8ca00c397e8..212ae77dfca2 100644
--- a/sound/firewire/dice/dice-harman.c
+++ b/sound/firewire/dice/dice-harman.c
@@ -2,8 +2,6 @@
 // dice-harman.c - a part of driver for DICE based devices
 //
 // Copyright (c) 2021 Takashi Sakamoto
-//
-// Licensed under the terms of the GNU General Public License, version 2.
 
 #include "dice.h"
 
diff --git a/sound/firewire/dice/dice-presonus.c b/sound/firewire/dice/dice-presonus.c
index 503f462a83f4..967cc3119a64 100644
--- a/sound/firewire/dice/dice-presonus.c
+++ b/sound/firewire/dice/dice-presonus.c
@@ -2,8 +2,6 @@
 // dice-presonus.c - a part of driver for DICE based devices
 //
 // Copyright (c) 2019 Takashi Sakamoto
-//
-// Licensed under the terms of the GNU General Public License, version 2.
 
 #include "dice.h"
 
diff --git a/sound/firewire/fireface/ff-protocol-former.c b/sound/firewire/fireface/ff-protocol-former.c
index bf44cad7985e..8900ffe517ed 100644
--- a/sound/firewire/fireface/ff-protocol-former.c
+++ b/sound/firewire/fireface/ff-protocol-former.c
@@ -2,8 +2,6 @@
 // ff-protocol-former.c - a part of driver for RME Fireface series
 //
 // Copyright (c) 2019 Takashi Sakamoto
-//
-// Licensed under the terms of the GNU General Public License, version 2.
 
 #include <linux/delay.h>
 
diff --git a/sound/firewire/fireface/ff-protocol-latter.c b/sound/firewire/fireface/ff-protocol-latter.c
index 7ddb7b97f02d..76c3eab36d4e 100644
--- a/sound/firewire/fireface/ff-protocol-latter.c
+++ b/sound/firewire/fireface/ff-protocol-latter.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-// ff-protocol-latter - a part of driver for RME Fireface series
+// ff-protocol-latter.c - a part of driver for RME Fireface series
 //
 // Copyright (c) 2019 Takashi Sakamoto
-//
-// Licensed under the terms of the GNU General Public License, version 2.
 
 #include <linux/delay.h>
 
diff --git a/sound/firewire/motu/motu-protocol-v1.c b/sound/firewire/motu/motu-protocol-v1.c
index f1d6a326dc07..e811629f167b 100644
--- a/sound/firewire/motu/motu-protocol-v1.c
+++ b/sound/firewire/motu/motu-protocol-v1.c
@@ -1,10 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
-
 // motu-protocol-v1.c - a part of driver for MOTU FireWire series
 //
 // Copyright (c) 2021 Takashi Sakamoto <o-takashi@sakamocchi.jp>
-//
-// Licensed under the terms of the GNU General Public License, version 2.
 
 #include "motu.h"
 
-- 
2.34.1

