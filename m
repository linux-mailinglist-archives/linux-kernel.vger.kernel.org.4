Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211465B4E9F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiIKL5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIKL5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:57:09 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D842C13F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:57:08 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id XLaEowyOq9RnzXLaEofjBq; Sun, 11 Sep 2022 13:57:07 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Sep 2022 13:57:07 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] headers: Remove some left-over license text in include/uapi/linux/hsi/
Date:   Sun, 11 Sep 2022 13:56:59 +0200
Message-Id: <4919073b3dee8ca7612989659d31b12f9c5491ba.1662897400.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some left-over from commit e2be04c7f995 ("License cleanup: add SPDX
license identifier to uapi header files with a license")

When the SPDX-License-Identifier tag has been added, the corresponding
license text has not been removed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/uapi/linux/hsi/cs-protocol.h | 14 --------------
 include/uapi/linux/hsi/hsi_char.h    | 14 --------------
 2 files changed, 28 deletions(-)

diff --git a/include/uapi/linux/hsi/cs-protocol.h b/include/uapi/linux/hsi/cs-protocol.h
index c7f6e7672cb5..07c3bfb67463 100644
--- a/include/uapi/linux/hsi/cs-protocol.h
+++ b/include/uapi/linux/hsi/cs-protocol.h
@@ -6,20 +6,6 @@
  *
  * Contact: Kai Vehmanen <kai.vehmanen@nokia.com>
  * Original author: Peter Ujfalusi <peter.ujfalusi@nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
  */
 
 #ifndef _CS_PROTOCOL_H
diff --git a/include/uapi/linux/hsi/hsi_char.h b/include/uapi/linux/hsi/hsi_char.h
index 91623b0398b1..5ef72f0daf94 100644
--- a/include/uapi/linux/hsi/hsi_char.h
+++ b/include/uapi/linux/hsi/hsi_char.h
@@ -5,20 +5,6 @@
  * Copyright (C) 2010 Nokia Corporation. All rights reserved.
  *
  * Contact: Andras Domokos <andras.domokos at nokia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
  */
 
 #ifndef __HSI_CHAR_H
-- 
2.34.1

