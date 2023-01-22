Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0E677215
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjAVTjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjAVTjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:39:06 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6871CF60
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:39:01 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 019ED20005;
        Sun, 22 Jan 2023 19:38:59 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Diederik de Haas <didi.debian@cknow.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] synclink: Fix full name of the GPL
Date:   Sun, 22 Jan 2023 20:38:43 +0100
Message-Id: <20230122193844.60696-1-didi.debian@cknow.org>
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
 include/linux/synclink.h      | 2 +-
 include/uapi/linux/synclink.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/synclink.h b/include/linux/synclink.h
index f1405b1c71ba..e69e740cbecb 100644
--- a/include/linux/synclink.h
+++ b/include/linux/synclink.h
@@ -6,7 +6,7 @@
  * Copyright (C) 1998-2000 by Microgate Corporation
  *
  * Redistribution of this file is permitted under
- * the terms of the GNU Public License (GPL)
+ * the terms of the GNU General Public License (GPL)
  */
 #ifndef _SYNCLINK_H_
 #define _SYNCLINK_H_
diff --git a/include/uapi/linux/synclink.h b/include/uapi/linux/synclink.h
index 62f32d4e1021..a1a1c3355b72 100644
--- a/include/uapi/linux/synclink.h
+++ b/include/uapi/linux/synclink.h
@@ -7,7 +7,7 @@
  * Copyright (C) 1998-2000 by Microgate Corporation
  *
  * Redistribution of this file is permitted under
- * the terms of the GNU Public License (GPL)
+ * the terms of the GNU General Public License (GPL)
  */
 
 #ifndef _UAPI_SYNCLINK_H_
-- 
2.39.0

