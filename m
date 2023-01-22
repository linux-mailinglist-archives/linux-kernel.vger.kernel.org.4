Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8D2677188
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjAVSbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAVSbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:31:34 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19820CC27
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 10:31:32 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id EA7F120004;
        Sun, 22 Jan 2023 18:31:30 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Diederik de Haas <didi.debian@cknow.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pcmcia:sa11xx_base: Fix full name of the GPL
Date:   Sun, 22 Jan 2023 19:31:17 +0100
Message-Id: <20230122183119.55801-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 drivers/pcmcia/sa11xx_base.c | 4 ++--
 drivers/pcmcia/sa11xx_base.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index 48140ac73ed6..514f3c2cb467 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -18,8 +18,8 @@
     Copyright (C) 1999 John G. Dorsey.  All Rights Reserved.
 
     Alternatively, the contents of this file may be used under the
-    terms of the GNU Public License version 2 (the "GPL"), in which
-    case the provisions of the GPL are applicable instead of the
+    terms of the GNU General Public License version 2 (the "GPL"), in
+    which case the provisions of the GPL are applicable instead of the
     above.  If you wish to allow the use of your version of this file
     only under the terms of the GPL and not to allow others to use
     your version of this file under the MPL, indicate your decision
diff --git a/drivers/pcmcia/sa11xx_base.h b/drivers/pcmcia/sa11xx_base.h
index 3d76d720f463..955f1fff2645 100644
--- a/drivers/pcmcia/sa11xx_base.h
+++ b/drivers/pcmcia/sa11xx_base.h
@@ -18,8 +18,8 @@
     Copyright (C) 1999 John G. Dorsey.  All Rights Reserved.
 
     Alternatively, the contents of this file may be used under the
-    terms of the GNU Public License version 2 (the "GPL"), in which
-    case the provisions of the GPL are applicable instead of the
+    terms of the GNU General Public License version 2 (the "GPL"), in
+    which case the provisions of the GPL are applicable instead of the
     above.  If you wish to allow the use of your version of this file
     only under the terms of the GPL and not to allow others to use
     your version of this file under the MPL, indicate your decision
-- 
2.39.0

