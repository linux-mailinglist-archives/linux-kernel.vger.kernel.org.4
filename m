Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E345F1BBE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 12:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJAKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJAKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 06:13:05 -0400
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA437125799
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 03:12:49 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id eZUEopc9AFv0OeZUEoriVV; Sat, 01 Oct 2022 12:12:47 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 01 Oct 2022 12:12:47 +0200
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        David Rheinsberg <david.rheinsberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] HID: Drop empty comment
Date:   Sat,  1 Oct 2022 12:12:17 +0200
Message-Id: <3c0b838584112f8dde00967fd510e01be9186499.1664619057.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2874c5fd2842 ("treewide: Replace GPLv2 boilerplate/reference with
SPDX - rule 152") and commit 1a59d1b8e05e ("treewide: Replace GPLv2
boilerplate/reference with SPDX - rule 156") have left some empty comment
blocks.

Remove them to save a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
All files I've checked were related to 2874c5fd2842 or 1a59d1b8e05e, but
I've not checked all.
---
 drivers/hid/hid-a4tech.c          | 3 ---
 drivers/hid/hid-accutouch.c       | 3 ---
 drivers/hid/hid-apple.c           | 3 ---
 drivers/hid/hid-asus.c            | 3 ---
 drivers/hid/hid-axff.c            | 3 ---
 drivers/hid/hid-belkin.c          | 3 ---
 drivers/hid/hid-betopff.c         | 4 ----
 drivers/hid/hid-cherry.c          | 3 ---
 drivers/hid/hid-chicony.c         | 3 ---
 drivers/hid/hid-core.c            | 3 ---
 drivers/hid/hid-corsair.c         | 3 ---
 drivers/hid/hid-cypress.c         | 3 ---
 drivers/hid/hid-dr.c              | 3 ---
 drivers/hid/hid-elecom.c          | 3 ---
 drivers/hid/hid-emsff.c           | 4 ----
 drivers/hid/hid-ezkey.c           | 3 ---
 drivers/hid/hid-gaff.c            | 3 ---
 drivers/hid/hid-gembird.c         | 3 ---
 drivers/hid/hid-generic.c         | 3 ---
 drivers/hid/hid-glorious.c        | 3 ---
 drivers/hid/hid-gyration.c        | 3 ---
 drivers/hid/hid-holtek-kbd.c      | 3 ---
 drivers/hid/hid-holtek-mouse.c    | 3 ---
 drivers/hid/hid-holtekff.c        | 3 ---
 drivers/hid/hid-icade.c           | 3 ---
 drivers/hid/hid-ids.h             | 3 ---
 drivers/hid/hid-jabra.c           | 3 ---
 drivers/hid/hid-kensington.c      | 3 ---
 drivers/hid/hid-keytouch.c        | 3 ---
 drivers/hid/hid-kye.c             | 3 ---
 drivers/hid/hid-lcpower.c         | 3 ---
 drivers/hid/hid-lenovo.c          | 3 ---
 drivers/hid/hid-lg.c              | 3 ---
 drivers/hid/hid-lg2ff.c           | 4 ----
 drivers/hid/hid-lg3ff.c           | 4 ----
 drivers/hid/hid-lg4ff.c           | 4 ----
 drivers/hid/hid-magicmouse.c      | 3 ---
 drivers/hid/hid-mf.c              | 3 ---
 drivers/hid/hid-microsoft.c       | 3 ---
 drivers/hid/hid-monterey.c        | 3 ---
 drivers/hid/hid-multitouch.c      | 3 ---
 drivers/hid/hid-nti.c             | 3 ---
 drivers/hid/hid-ntrig.c           | 3 ---
 drivers/hid/hid-ortek.c           | 3 ---
 drivers/hid/hid-penmount.c        | 3 ---
 drivers/hid/hid-petalynx.c        | 3 ---
 drivers/hid/hid-pl.c              | 3 ---
 drivers/hid/hid-plantronics.c     | 3 ---
 drivers/hid/hid-prodikeys.c       | 3 ---
 drivers/hid/hid-quirks.c          | 3 ---
 drivers/hid/hid-retrode.c         | 3 ---
 drivers/hid/hid-roccat-arvo.c     | 3 ---
 drivers/hid/hid-roccat-arvo.h     | 3 ---
 drivers/hid/hid-roccat-common.c   | 3 ---
 drivers/hid/hid-roccat-common.h   | 3 ---
 drivers/hid/hid-roccat-isku.c     | 3 ---
 drivers/hid/hid-roccat-isku.h     | 3 ---
 drivers/hid/hid-roccat-kone.c     | 3 ---
 drivers/hid/hid-roccat-kone.h     | 3 ---
 drivers/hid/hid-roccat-koneplus.c | 3 ---
 drivers/hid/hid-roccat-koneplus.h | 3 ---
 drivers/hid/hid-roccat-konepure.c | 3 ---
 drivers/hid/hid-roccat-kovaplus.c | 3 ---
 drivers/hid/hid-roccat-kovaplus.h | 3 ---
 drivers/hid/hid-roccat-lua.c      | 3 ---
 drivers/hid/hid-roccat-lua.h      | 3 ---
 drivers/hid/hid-roccat-pyra.c     | 3 ---
 drivers/hid/hid-roccat-pyra.h     | 3 ---
 drivers/hid/hid-roccat-ryos.c     | 3 ---
 drivers/hid/hid-roccat-savu.c     | 3 ---
 drivers/hid/hid-roccat-savu.h     | 3 ---
 drivers/hid/hid-roccat.c          | 3 ---
 drivers/hid/hid-saitek.c          | 3 ---
 drivers/hid/hid-samsung.c         | 3 ---
 drivers/hid/hid-sjoy.c            | 3 ---
 drivers/hid/hid-sony.c            | 3 ---
 drivers/hid/hid-speedlink.c       | 3 ---
 drivers/hid/hid-steelseries.c     | 3 ---
 drivers/hid/hid-sunplus.c         | 3 ---
 drivers/hid/hid-tivo.c            | 3 ---
 drivers/hid/hid-tmff.c            | 3 ---
 drivers/hid/hid-topseed.c         | 3 ---
 drivers/hid/hid-twinhan.c         | 3 ---
 drivers/hid/hid-waltop.c          | 3 ---
 drivers/hid/hid-wiimote-core.c    | 3 ---
 drivers/hid/hid-wiimote-debug.c   | 3 ---
 drivers/hid/hid-wiimote-modules.c | 3 ---
 drivers/hid/hid-wiimote.h         | 3 ---
 drivers/hid/hid-xinmo.c           | 3 ---
 drivers/hid/hid-zpff.c            | 4 ----
 drivers/hid/hid-zydacron.c        | 3 ---
 drivers/hid/uhid.c                | 3 ---
 drivers/hid/usbhid/hid-core.c     | 3 ---
 drivers/hid/usbhid/hid-pidff.c    | 3 ---
 drivers/hid/usbhid/usbhid.h       | 3 ---
 95 files changed, 291 deletions(-)

diff --git a/drivers/hid/hid-a4tech.c b/drivers/hid/hid-a4tech.c
index 2cbc32dda7f7..8023d9fe47f5 100644
--- a/drivers/hid/hid-a4tech.c
+++ b/drivers/hid/hid-a4tech.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2008 Jiri Slaby
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/input.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-accutouch.c b/drivers/hid/hid-accutouch.c
index bb6c997e9efd..13a812dacc64 100644
--- a/drivers/hid/hid-accutouch.c
+++ b/drivers/hid/hid-accutouch.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2014 Christian Gmeiner <christian.gmeiner <at> gmail.com>
  */
 
-/*
- */
-
 #include <linux/hid.h>
 #include <linux/module.h>
 #include "hid-ids.h"
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 6970797cdc56..2bf2171057a1 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -10,9 +10,6 @@
  *  Copyright (c) 2019 Paul Pawlowski <paul@mrarm.io>
  */
 
-/*
- */
-
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/device.h>
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index b59c3dafa6a4..f44d2ed9619f 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -20,9 +20,6 @@
  *  Copyright (c) 2016 Frederik Wenigwieser <frederik.wenigwieser@gmail.com>
  */
 
-/*
- */
-
 #include <linux/dmi.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-axff.c b/drivers/hid/hid-axff.c
index fbe4e16ab029..e4f6634dd192 100644
--- a/drivers/hid/hid-axff.c
+++ b/drivers/hid/hid-axff.c
@@ -12,9 +12,6 @@
  * Copyright (c) 2010 Sergei Kolzun <x0r@dv-life.ru>
  */
 
-/*
- */
-
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-belkin.c b/drivers/hid/hid-belkin.c
index fc0b3bb383cc..bc69a6bf30f7 100644
--- a/drivers/hid/hid-belkin.c
+++ b/drivers/hid/hid-belkin.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2008 Jiri Slaby
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-betopff.c b/drivers/hid/hid-betopff.c
index 467d789f9bc2..6df465ad7caf 100644
--- a/drivers/hid/hid-betopff.c
+++ b/drivers/hid/hid-betopff.c
@@ -19,10 +19,6 @@
  *  Copyright (c) 2014 Huang Bo <huangbobupt@163.com>
  */
 
-/*
- */
-
-
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-cherry.c b/drivers/hid/hid-cherry.c
index 6a71187b5cf6..8fdcd8d66901 100644
--- a/drivers/hid/hid-cherry.c
+++ b/drivers/hid/hid-cherry.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2008 Jiri Slaby
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-chicony.c b/drivers/hid/hid-chicony.c
index f04d2aa23efe..a5ef2864ba68 100644
--- a/drivers/hid/hid-chicony.c
+++ b/drivers/hid/hid-chicony.c
@@ -10,9 +10,6 @@
  *  Copyright (c) 2008 Jiri Slaby
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/input.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9c1d31f63f85..9fe6263feaa2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -8,9 +8,6 @@
  *  Copyright (c) 2006-2012 Jiri Kosina
  */
 
-/*
- */
-
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 8c895c820b67..95c7d5f8c8b9 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -13,9 +13,6 @@
  * Copyright (c) 2017 Aaron Bottegal
  */
 
-/*
- */
-
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/usb.h>
diff --git a/drivers/hid/hid-cypress.c b/drivers/hid/hid-cypress.c
index b88f889b3932..b17c880588c8 100644
--- a/drivers/hid/hid-cypress.c
+++ b/drivers/hid/hid-cypress.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2008 Jiri Slaby
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/input.h>
diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
index 947f19f8685f..b31688bbc9f5 100644
--- a/drivers/hid/hid-dr.c
+++ b/drivers/hid/hid-dr.c
@@ -12,9 +12,6 @@
  * Copyright (c) 2009 Richard Walmsley <richwalm@gmail.com>
  */
 
-/*
- */
-
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index e59e9911fc37..e9f0d151b9ce 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -14,9 +14,6 @@
  *  Copyright (c) 2020 YOSHIOKA Takuma <lo48576@hard-wi.red>
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-emsff.c b/drivers/hid/hid-emsff.c
index c34f2e5a049f..ecfe9b38f236 100644
--- a/drivers/hid/hid-emsff.c
+++ b/drivers/hid/hid-emsff.c
@@ -5,10 +5,6 @@
  *  Copyright (c) 2010 Ignaz Forster <ignaz.forster@gmx.de>
  */
 
-/*
- */
-
-
 #include <linux/hid.h>
 #include <linux/input.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-ezkey.c b/drivers/hid/hid-ezkey.c
index d14f91d78c96..a57043320f2f 100644
--- a/drivers/hid/hid-ezkey.c
+++ b/drivers/hid/hid-ezkey.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2008 Jiri Slaby
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/input.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-gaff.c b/drivers/hid/hid-gaff.c
index ecbd3995a4eb..52781177ca4f 100644
--- a/drivers/hid/hid-gaff.c
+++ b/drivers/hid/hid-gaff.c
@@ -11,9 +11,6 @@
  *  Copyright (c) 2008 Lukasz Lubojanski <lukasz@lubojanski.info>
  */
 
-/*
- */
-
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-gembird.c b/drivers/hid/hid-gembird.c
index c42593fe7116..c2b174f391bb 100644
--- a/drivers/hid/hid-gembird.c
+++ b/drivers/hid/hid-gembird.c
@@ -6,9 +6,6 @@
  *  Copyright (c) 2015 Benjamin Tissoires
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index f9db991d3c5a..65122d9dfc0e 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -10,9 +10,6 @@
  *  Copyright (c) 2012 Henrik Rydberg
  */
 
-/*
- */
-
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
diff --git a/drivers/hid/hid-glorious.c b/drivers/hid/hid-glorious.c
index 558eb08c19ef..5c8b0eec68e9 100644
--- a/drivers/hid/hid-glorious.c
+++ b/drivers/hid/hid-glorious.c
@@ -6,9 +6,6 @@
  *  Copyright (c) 2020 Samuel Čavoj <sammko@sammserver.com>
  */
 
-/*
- */
-
 #include <linux/hid.h>
 #include <linux/module.h>
 
diff --git a/drivers/hid/hid-gyration.c b/drivers/hid/hid-gyration.c
index b99a611479b3..54be1a029a76 100644
--- a/drivers/hid/hid-gyration.c
+++ b/drivers/hid/hid-gyration.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2006-2008 Jiri Kosina
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/input.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-holtek-kbd.c b/drivers/hid/hid-holtek-kbd.c
index 403506b9697e..174fb9e73adb 100644
--- a/drivers/hid/hid-holtek-kbd.c
+++ b/drivers/hid/hid-holtek-kbd.c
@@ -2,9 +2,6 @@
 /*
  * HID driver for Holtek keyboard
  * Copyright (c) 2012 Tom Harwood
-*/
-
-/*
  */
 
 #include <linux/device.h>
diff --git a/drivers/hid/hid-holtek-mouse.c b/drivers/hid/hid-holtek-mouse.c
index 7c907939bfae..c487e6f94e85 100644
--- a/drivers/hid/hid-holtek-mouse.c
+++ b/drivers/hid/hid-holtek-mouse.c
@@ -4,9 +4,6 @@
  * Copyright (c) 2013 Christian Ohm
  * Heavily inspired by various other HID drivers that adjust the report
  * descriptor.
-*/
-
-/*
  */
 
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-holtekff.c b/drivers/hid/hid-holtekff.c
index 8619b80c834c..d48a7e61c5df 100644
--- a/drivers/hid/hid-holtekff.c
+++ b/drivers/hid/hid-holtekff.c
@@ -8,9 +8,6 @@
  *  Copyright (c) 2011 Anssi Hannula <anssi.hannula@iki.fi>
  */
 
-/*
- */
-
 #include <linux/hid.h>
 #include <linux/input.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-icade.c b/drivers/hid/hid-icade.c
index f3716cfaca1f..57473ca138ee 100644
--- a/drivers/hid/hid-icade.c
+++ b/drivers/hid/hid-icade.c
@@ -6,9 +6,6 @@
  *  Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com>
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index da86565f04d4..bbd11c733d39 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -8,9 +8,6 @@
  *  Copyright (c) 2006-2007 Jiri Kosina
  */
 
-/*
- */
-
 #ifndef HID_IDS_H_FILE
 #define HID_IDS_H_FILE
 
diff --git a/drivers/hid/hid-jabra.c b/drivers/hid/hid-jabra.c
index 41dc30fe2d16..d5ee4accf1bd 100644
--- a/drivers/hid/hid-jabra.c
+++ b/drivers/hid/hid-jabra.c
@@ -5,9 +5,6 @@
  *  Copyright (c) 2017 Niels Skou Olsen <nolsen@jabra.com>
  */
 
-/*
- */
-
 #include <linux/hid.h>
 #include <linux/module.h>
 
diff --git a/drivers/hid/hid-kensington.c b/drivers/hid/hid-kensington.c
index b31f7f431a3f..794cca711830 100644
--- a/drivers/hid/hid-kensington.c
+++ b/drivers/hid/hid-kensington.c
@@ -5,9 +5,6 @@
  *  Copyright (c) 2009 Jiri Kosina
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/input.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-keytouch.c b/drivers/hid/hid-keytouch.c
index 73bf8642dfe3..c840e590bff7 100644
--- a/drivers/hid/hid-keytouch.c
+++ b/drivers/hid/hid-keytouch.c
@@ -5,9 +5,6 @@
  *  Copyright (c) 2011 Jiri Kosina
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index da903138eee4..d635daee85ff 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -7,9 +7,6 @@
  *  Copyright (c) 2012 Nikolai Kondrashov
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-lcpower.c b/drivers/hid/hid-lcpower.c
index 8acd3ee5ada5..b0b4371b3a18 100644
--- a/drivers/hid/hid-lcpower.c
+++ b/drivers/hid/hid-lcpower.c
@@ -6,9 +6,6 @@
  *  based on hid-topseed module
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 9dabd6323234..959fd5cdea53 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -21,9 +21,6 @@
  *  Copyright (c) 2018 Peter Ganzhorn <peter.ganzhorn@gmail.com>
  */
 
-/*
- */
-
 #include <linux/module.h>
 #include <linux/sysfs.h>
 #include <linux/device.h>
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index fb3f7258009c..8b4b88b269eb 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -10,9 +10,6 @@
  *  Copyright (c) 2010 Hendrik Iben
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-lg2ff.c b/drivers/hid/hid-lg2ff.c
index 73d07e35f12a..99656d401473 100644
--- a/drivers/hid/hid-lg2ff.c
+++ b/drivers/hid/hid-lg2ff.c
@@ -5,10 +5,6 @@
  *  Copyright (c) 2008 Anssi Hannula <anssi.hannula@gmail.com>
  */
 
-/*
- */
-
-
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-lg3ff.c b/drivers/hid/hid-lg3ff.c
index b7e1949f3cf7..363ab3505d3c 100644
--- a/drivers/hid/hid-lg3ff.c
+++ b/drivers/hid/hid-lg3ff.c
@@ -5,10 +5,6 @@
  *  Copyright (c) 2009 Gary Stein <LordCnidarian@gmail.com>
  */
 
-/*
- */
-
-
 #include <linux/input.h>
 #include <linux/hid.h>
 
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 5e6a0cef2a06..6012cef809d5 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -8,10 +8,6 @@
  *  Copyright (c) 2010 Simon Wood <simon@mungewell.org>
  */
 
-/*
- */
-
-
 #include <linux/input.h>
 #include <linux/usb.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 664a624a363d..a79a59ac0fad 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -6,9 +6,6 @@
  *   Copyright (c) 2010 Chase Douglas <chase.douglas@canonical.com>
  */
 
-/*
- */
-
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/device.h>
diff --git a/drivers/hid/hid-mf.c b/drivers/hid/hid-mf.c
index 92d7ecd41a78..976c0d6779fe 100644
--- a/drivers/hid/hid-mf.c
+++ b/drivers/hid/hid-mf.c
@@ -17,9 +17,6 @@
  * Copyright (c) 2016-2017 Marcel Hasler <mahasler@gmail.com>
  */
 
-/*
- */
-
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 071fd093a5f4..8a3a2c4bc30a 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2008 Jiri Slaby
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/input.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-monterey.c b/drivers/hid/hid-monterey.c
index c63f9f1e61b8..12a07ab19d87 100644
--- a/drivers/hid/hid-monterey.c
+++ b/drivers/hid/hid-monterey.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2008 Jiri Slaby
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 91a4d3fc30e0..913e03466d2d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -20,9 +20,6 @@
  *  Copyright (c) 2010      Canonical, Ltd.
  */
 
-/*
- */
-
 /*
  * This driver is regularly tested thanks to the test suite in hid-tools[1].
  * Please run these regression tests before patching this module so that
diff --git a/drivers/hid/hid-nti.c b/drivers/hid/hid-nti.c
index 1952e9ca5f45..2d4e8e02455f 100644
--- a/drivers/hid/hid-nti.c
+++ b/drivers/hid/hid-nti.c
@@ -13,9 +13,6 @@
  *  Copyright (c) 2008 Jiri Slaby <jirislaby@gmail.com>
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/input.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index b5d26f03fe6b..ee982730a0b8 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -6,9 +6,6 @@
  *  Copyright (c) 2009-2010 Stephane Chatty
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/usb.h>
diff --git a/drivers/hid/hid-ortek.c b/drivers/hid/hid-ortek.c
index 9a4770d79c64..951232389a1c 100644
--- a/drivers/hid/hid-ortek.c
+++ b/drivers/hid/hid-ortek.c
@@ -13,9 +13,6 @@
  *  Copyright (c) 2011 Jiri Kosina
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
index b9edc8e758fd..040b286e94b0 100644
--- a/drivers/hid/hid-penmount.c
+++ b/drivers/hid/hid-penmount.c
@@ -8,9 +8,6 @@
  *    PenMount Touch Solutions <penmount <at> seed.net.tw>
  */
 
-/*
- */
-
 #include <linux/module.h>
 #include <linux/hid.h>
 #include "hid-ids.h"
diff --git a/drivers/hid/hid-petalynx.c b/drivers/hid/hid-petalynx.c
index ea0af9f7ad90..7644e53d5ab6 100644
--- a/drivers/hid/hid-petalynx.c
+++ b/drivers/hid/hid-petalynx.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2008 Jiri Slaby
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
index 93fb07ec3180..e128b2f4dbe6 100644
--- a/drivers/hid/hid-pl.c
+++ b/drivers/hid/hid-pl.c
@@ -20,9 +20,6 @@
  *  Copyright (c) 2007, 2009 Anssi Hannula <anssi.hannula@gmail.com>
  */
 
-/*
- */
-
 
 /* #define DEBUG */
 
diff --git a/drivers/hid/hid-plantronics.c b/drivers/hid/hid-plantronics.c
index e81b7cec2d12..1c94017f0bae 100644
--- a/drivers/hid/hid-plantronics.c
+++ b/drivers/hid/hid-plantronics.c
@@ -6,9 +6,6 @@
  *  Copyright (c) 2015-2018 Terry Junge <terry.junge@plantronics.com>
  */
 
-/*
- */
-
 #include "hid-ids.h"
 
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index e4e9471d0f1e..b3f05ff0e067 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -9,9 +9,6 @@
  *  Sustain Duration available via sysfs.
  */
 
-/*
- */
-
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/device.h>
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 70f602c64fd1..9c293c83ffbe 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2007 Paul Walmsley
  */
 
-/*
- */
-
 #include <linux/hid.h>
 #include <linux/export.h>
 #include <linux/slab.h>
diff --git a/drivers/hid/hid-retrode.c b/drivers/hid/hid-retrode.c
index 6a08e25aa296..ad07f0081948 100644
--- a/drivers/hid/hid-retrode.c
+++ b/drivers/hid/hid-retrode.c
@@ -5,9 +5,6 @@
  *  Copyright (c) 2017 Bastien Nocera <hadess@hadess.net>
  */
 
-/*
- */
-
 #include <linux/input.h>
 #include <linux/slab.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-roccat-arvo.c b/drivers/hid/hid-roccat-arvo.c
index d94ee0539421..ab543f991443 100644
--- a/drivers/hid/hid-roccat-arvo.c
+++ b/drivers/hid/hid-roccat-arvo.c
@@ -5,9 +5,6 @@
  * Copyright (c) 2011 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 /*
  * Roccat Arvo is a gamer keyboard with 5 macro keys that can be configured in
  * 5 profiles.
diff --git a/drivers/hid/hid-roccat-arvo.h b/drivers/hid/hid-roccat-arvo.h
index 052562fa9027..975940b8e9c1 100644
--- a/drivers/hid/hid-roccat-arvo.h
+++ b/drivers/hid/hid-roccat-arvo.h
@@ -6,9 +6,6 @@
  * Copyright (c) 2011 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 #include <linux/types.h>
 
 struct arvo_mode_key { /* 2 bytes */
diff --git a/drivers/hid/hid-roccat-common.c b/drivers/hid/hid-roccat-common.c
index 4465ef95d32a..0a3fe8014bcd 100644
--- a/drivers/hid/hid-roccat-common.c
+++ b/drivers/hid/hid-roccat-common.c
@@ -5,9 +5,6 @@
  * Copyright (c) 2011 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 #include <linux/hid.h>
 #include <linux/slab.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-roccat-common.h b/drivers/hid/hid-roccat-common.h
index 839ddfd931f0..c23c66ebd50a 100644
--- a/drivers/hid/hid-roccat-common.h
+++ b/drivers/hid/hid-roccat-common.h
@@ -6,9 +6,6 @@
  * Copyright (c) 2011 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 #include <linux/usb.h>
 #include <linux/types.h>
 
diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index e95d59cd8d07..1100a8d7683c 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -5,9 +5,6 @@
  * Copyright (c) 2011 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 /*
  * Roccat Isku is a gamer keyboard with macro keys that can be configured in
  * 5 profiles.
diff --git a/drivers/hid/hid-roccat-isku.h b/drivers/hid/hid-roccat-isku.h
index 0779d72e4e2f..12635c39253b 100644
--- a/drivers/hid/hid-roccat-isku.h
+++ b/drivers/hid/hid-roccat-isku.h
@@ -6,9 +6,6 @@
  * Copyright (c) 2011 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 #include <linux/types.h>
 
 enum {
diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 76da04801ca9..bf8cda6c44f9 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -5,9 +5,6 @@
  * Copyright (c) 2010 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 /*
  * Roccat Kone is a gamer mouse which consists of a mouse part and a keyboard
  * part. The keyboard part enables the mouse to execute stored macros with mixed
diff --git a/drivers/hid/hid-roccat-kone.h b/drivers/hid/hid-roccat-kone.h
index 65c800e3addc..1458be494000 100644
--- a/drivers/hid/hid-roccat-kone.h
+++ b/drivers/hid/hid-roccat-kone.h
@@ -6,9 +6,6 @@
  * Copyright (c) 2010 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 #include <linux/types.h>
 
 struct kone_keystroke {
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 1896c69ea512..ea87b21f0f61 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -5,9 +5,6 @@
  * Copyright (c) 2010 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 /*
  * Roccat Kone[+] is an updated/improved version of the Kone with more memory
  * and functionality and without the non-standard behaviours the Kone had.
diff --git a/drivers/hid/hid-roccat-koneplus.h b/drivers/hid/hid-roccat-koneplus.h
index 8ce7bb7df7f1..2f8d14c447fe 100644
--- a/drivers/hid/hid-roccat-koneplus.h
+++ b/drivers/hid/hid-roccat-koneplus.h
@@ -6,9 +6,6 @@
  * Copyright (c) 2010 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 #include <linux/types.h>
 
 enum {
diff --git a/drivers/hid/hid-roccat-konepure.c b/drivers/hid/hid-roccat-konepure.c
index cf8eeb33a125..bb0944ec89ab 100644
--- a/drivers/hid/hid-roccat-konepure.c
+++ b/drivers/hid/hid-roccat-konepure.c
@@ -5,9 +5,6 @@
  * Copyright (c) 2012 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 /*
  * Roccat KonePure is a smaller version of KoneXTD with less buttons and lights.
  */
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 6fb9b9563769..5b794be3ad50 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -5,9 +5,6 @@
  * Copyright (c) 2011 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 /*
  * Roccat Kova[+] is a bigger version of the Pyra with two more side buttons.
  */
diff --git a/drivers/hid/hid-roccat-kovaplus.h b/drivers/hid/hid-roccat-kovaplus.h
index 5eccae69e668..302bf641b0f5 100644
--- a/drivers/hid/hid-roccat-kovaplus.h
+++ b/drivers/hid/hid-roccat-kovaplus.h
@@ -6,9 +6,6 @@
  * Copyright (c) 2010 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 #include <linux/types.h>
 
 enum {
diff --git a/drivers/hid/hid-roccat-lua.c b/drivers/hid/hid-roccat-lua.c
index d5ddf0d68346..b369d737d484 100644
--- a/drivers/hid/hid-roccat-lua.c
+++ b/drivers/hid/hid-roccat-lua.c
@@ -5,9 +5,6 @@
  * Copyright (c) 2012 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 /*
  * Roccat Lua is a gamer mouse which cpi, button and light settings can be
  * configured.
diff --git a/drivers/hid/hid-roccat-lua.h b/drivers/hid/hid-roccat-lua.h
index 1495e535e86a..b493ee57c29a 100644
--- a/drivers/hid/hid-roccat-lua.h
+++ b/drivers/hid/hid-roccat-lua.h
@@ -6,9 +6,6 @@
  * Copyright (c) 2012 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 #include <linux/types.h>
 
 enum {
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 4fcc8e7d276f..07985b0dc21f 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -5,9 +5,6 @@
  * Copyright (c) 2010 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 /*
  * Roccat Pyra is a mobile gamer mouse which comes in wired and wireless
  * variant. Wireless variant is not tested.
diff --git a/drivers/hid/hid-roccat-pyra.h b/drivers/hid/hid-roccat-pyra.h
index 7fc61006e8b0..dd2f17f4413d 100644
--- a/drivers/hid/hid-roccat-pyra.h
+++ b/drivers/hid/hid-roccat-pyra.h
@@ -6,9 +6,6 @@
  * Copyright (c) 2010 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 #include <linux/types.h>
 
 enum {
diff --git a/drivers/hid/hid-roccat-ryos.c b/drivers/hid/hid-roccat-ryos.c
index 5bf1971a2b14..fb8dc9077d80 100644
--- a/drivers/hid/hid-roccat-ryos.c
+++ b/drivers/hid/hid-roccat-ryos.c
@@ -5,9 +5,6 @@
  * Copyright (c) 2013 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/input.h>
diff --git a/drivers/hid/hid-roccat-savu.c b/drivers/hid/hid-roccat-savu.c
index a784bb4ee651..e1a4ca09917a 100644
--- a/drivers/hid/hid-roccat-savu.c
+++ b/drivers/hid/hid-roccat-savu.c
@@ -5,9 +5,6 @@
  * Copyright (c) 2012 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 /* Roccat Savu is a gamer mouse with macro keys that can be configured in
  * 5 profiles.
  */
diff --git a/drivers/hid/hid-roccat-savu.h b/drivers/hid/hid-roccat-savu.h
index c83423dc56fe..663ecae7d69c 100644
--- a/drivers/hid/hid-roccat-savu.h
+++ b/drivers/hid/hid-roccat-savu.h
@@ -6,9 +6,6 @@
  * Copyright (c) 2012 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 #include <linux/types.h>
 
 struct savu_mouse_report_special {
diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 6da80e442fdd..cede4b9fed3c 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -5,9 +5,6 @@
  * Copyright (c) 2010 Stefan Achatz <erazor_de@users.sourceforge.net>
  */
 
-/*
- */
-
 /*
  * Module roccat is a char device used to report special events of roccat
  * hardware to userland. These events include requests for on-screen-display of
diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
index c7bf14c01960..1ba337e1d561 100644
--- a/drivers/hid/hid-saitek.c
+++ b/drivers/hid/hid-saitek.c
@@ -14,9 +14,6 @@
  *  missing release event is generated immediately.
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index cf5992e97094..0702bd7c08fc 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -19,9 +19,6 @@
  *	deviate from the USB HUT 1.12 standard.
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/usb.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-sjoy.c b/drivers/hid/hid-sjoy.c
index 49971be7c3ff..d24027ca9bb5 100644
--- a/drivers/hid/hid-sjoy.c
+++ b/drivers/hid/hid-sjoy.c
@@ -9,9 +9,6 @@
  *   Copyright (c) 2008 Lukasz Lubojanski <lukasz@lubojanski.info>
  */
 
-/*
- */
-
 /* #define DEBUG */
 
 #include <linux/input.h>
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 03691cdcfb8e..80fa26a7e69a 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -16,9 +16,6 @@
  *  Copyright (c) 2021 Daniel Nguyen <daniel.nguyen.1@ens.etsmtl.ca>
  */
 
-/*
- */
-
 /*
  * NOTE: in order for the Sony PS3 BD Remote Control to be found by
  * a Bluetooth host, the key combination Start+Enter has to be kept pressed
diff --git a/drivers/hid/hid-speedlink.c b/drivers/hid/hid-speedlink.c
index 9e75f1aae0ca..5d3d95affec0 100644
--- a/drivers/hid/hid-speedlink.c
+++ b/drivers/hid/hid-speedlink.c
@@ -7,9 +7,6 @@
  *  Copyright (c) 2011, 2013 Stefan Kriwanek <dev@stefankriwanek.de>
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 37353c41cba7..31a1457a017f 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -5,9 +5,6 @@
  *  Copyright (c) 2013 Simon Wood
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-sunplus.c b/drivers/hid/hid-sunplus.c
index aa2855c2ed4e..ebfe50dd7eec 100644
--- a/drivers/hid/hid-sunplus.c
+++ b/drivers/hid/hid-sunplus.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2008 Jiri Slaby
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-tivo.c b/drivers/hid/hid-tivo.c
index 68eb08b63945..9e480b25791d 100644
--- a/drivers/hid/hid-tivo.c
+++ b/drivers/hid/hid-tivo.c
@@ -6,9 +6,6 @@
  *  based on the hid-topseed driver, which is in turn, based on hid-cherry...
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
index 4040cd98dafe..fbe0facca1a2 100644
--- a/drivers/hid/hid-tmff.c
+++ b/drivers/hid/hid-tmff.c
@@ -12,9 +12,6 @@
  *  Copyright (c) 2002 Johann Deneux
  */
 
-/*
- */
-
 #include <linux/hid.h>
 #include <linux/input.h>
 #include <linux/slab.h>
diff --git a/drivers/hid/hid-topseed.c b/drivers/hid/hid-topseed.c
index 2125327b8de1..cbf3845b41ba 100644
--- a/drivers/hid/hid-topseed.c
+++ b/drivers/hid/hid-topseed.c
@@ -12,9 +12,6 @@
  *  Kees Bakker 2010.
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-twinhan.c b/drivers/hid/hid-twinhan.c
index 14af794146c0..04de48df6c41 100644
--- a/drivers/hid/hid-twinhan.c
+++ b/drivers/hid/hid-twinhan.c
@@ -7,9 +7,6 @@
  * Copyright (c) 2009 Bruno Prémont <bonbons@linux-vserver.org>
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/input.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-waltop.c b/drivers/hid/hid-waltop.c
index bc355b1a5b30..5581b846dd1a 100644
--- a/drivers/hid/hid-waltop.c
+++ b/drivers/hid/hid-waltop.c
@@ -5,9 +5,6 @@
  *  Copyright (c) 2010 Nikolai Kondrashov
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 4399d6c6afef..ccf357b788a1 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -4,9 +4,6 @@
  * Copyright (c) 2011-2013 David Herrmann <dh.herrmann@gmail.com>
  */
 
-/*
- */
-
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index a99dcca2e099..c4324cdbf21e 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -4,9 +4,6 @@
  * Copyright (c) 2011-2013 David Herrmann <dh.herrmann@gmail.com>
  */
 
-/*
- */
-
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 213c58bf2495..ecc43b43ea90 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -4,9 +4,6 @@
  * Copyright (c) 2011-2013 David Herrmann <dh.herrmann@gmail.com>
  */
 
-/*
- */
-
 /*
  * Wiimote Modules
  * Nintendo devices provide different peripherals and many new devices lack
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index ad4ff837f43e..e48e7fddce0e 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -7,9 +7,6 @@
  * Copyright (c) 2011-2013 David Herrmann <dh.herrmann@gmail.com>
  */
 
-/*
- */
-
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/hid.h>
diff --git a/drivers/hid/hid-xinmo.c b/drivers/hid/hid-xinmo.c
index 5c2860a9d8c9..f1f7ebc437b7 100644
--- a/drivers/hid/hid-xinmo.c
+++ b/drivers/hid/hid-xinmo.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2013 Olivier Scherler
  */
 
-/*
- */
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/hid-zpff.c b/drivers/hid/hid-zpff.c
index 3abaca045869..7b4c2d9f0382 100644
--- a/drivers/hid/hid-zpff.c
+++ b/drivers/hid/hid-zpff.c
@@ -5,10 +5,6 @@
  *  Copyright (c) 2005, 2006 Anssi Hannula <anssi.hannula@gmail.com>
  */
 
-/*
- */
-
-
 #include <linux/hid.h>
 #include <linux/input.h>
 #include <linux/slab.h>
diff --git a/drivers/hid/hid-zydacron.c b/drivers/hid/hid-zydacron.c
index 0d003caee113..3191b9fbb85a 100644
--- a/drivers/hid/hid-zydacron.c
+++ b/drivers/hid/hid-zydacron.c
@@ -5,9 +5,6 @@
 *  Copyright (c) 2010 Don Prince <dhprince.devel@yahoo.co.uk>
 */
 
-/*
-*/
-
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 2a918aeb0af1..1be4d5b29b52 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -4,9 +4,6 @@
  * Copyright (c) 2012 David Herrmann
  */
 
-/*
- */
-
 #include <linux/atomic.h>
 #include <linux/compat.h>
 #include <linux/cred.h>
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index be4c731aaa65..269ab64aca88 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -9,9 +9,6 @@
  *  Copyright (c) 2006-2010 Jiri Kosina
  */
 
-/*
- */
-
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/init.h>
diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 3b4ee21cd811..3d2e633f5584 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -5,9 +5,6 @@
  *  Copyright (c) 2005, 2006 Anssi Hannula <anssi.hannula@gmail.com>
  */
 
-/*
- */
-
 /* #define DEBUG */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 75fe85d3d27a..e6a01d5b6008 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -8,9 +8,6 @@
  *  Copyright (c) 2006 Jiri Kosina
  */
 
-/*
- */
-
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/list.h>
-- 
2.34.1

