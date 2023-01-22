Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63367718F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjAVSeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVSeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:34:19 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD421BEA
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 10:34:17 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 856401BF205;
        Sun, 22 Jan 2023 18:34:15 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Diederik de Haas <didi.debian@cknow.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pcmcia: sa1100_generic: Fix full name of the GPL
Date:   Sun, 22 Jan 2023 19:33:53 +0100
Message-Id: <20230122183354.56042-1-didi.debian@cknow.org>
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
 drivers/pcmcia/sa1100_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index c2b6e828c2c6..25b247b8c2b4 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
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

