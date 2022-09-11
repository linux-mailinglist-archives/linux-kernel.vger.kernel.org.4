Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E125B4EA8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 14:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiIKMDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 08:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiIKMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 08:03:15 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432AC32EE5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 05:03:14 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id XLg7ovwaCu8plXLg7o0FVH; Sun, 11 Sep 2022 14:03:12 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Sep 2022 14:03:12 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: [PATCH] headers: Remove some left-over license text in include/uapi/linux/netfilter/
Date:   Sun, 11 Sep 2022 14:03:09 +0200
Message-Id: <e41c6fd2ed7d55b432129403d7a2bd443b759b33.1662897784.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the SPDX-License-Identifier tag has been added, the corresponding
license text has not been removed.

Remove it now.

Also, in xt_connmark.h, move the copyright text at the top of the file
which is a much more common pattern.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/uapi/linux/netfilter/ipset/ip_set.h |  4 ----
 include/uapi/linux/netfilter/xt_AUDIT.h     |  4 ----
 include/uapi/linux/netfilter/xt_connmark.h  | 13 ++++---------
 include/uapi/linux/netfilter/xt_osf.h       | 14 --------------
 4 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/include/uapi/linux/netfilter/ipset/ip_set.h b/include/uapi/linux/netfilter/ipset/ip_set.h
index 6397d75899bc..79e5d68b87af 100644
--- a/include/uapi/linux/netfilter/ipset/ip_set.h
+++ b/include/uapi/linux/netfilter/ipset/ip_set.h
@@ -3,10 +3,6 @@
  *                         Patrick Schaaf <bof@bof.de>
  *                         Martin Josefsson <gandalf@wlug.westbo.se>
  * Copyright (C) 2003-2011 Jozsef Kadlecsik <kadlec@netfilter.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #ifndef _UAPI_IP_SET_H
 #define _UAPI_IP_SET_H
diff --git a/include/uapi/linux/netfilter/xt_AUDIT.h b/include/uapi/linux/netfilter/xt_AUDIT.h
index 1b314e2f84ac..56a3f6092e0c 100644
--- a/include/uapi/linux/netfilter/xt_AUDIT.h
+++ b/include/uapi/linux/netfilter/xt_AUDIT.h
@@ -4,10 +4,6 @@
  *
  * (C) 2010-2011 Thomas Graf <tgraf@redhat.com>
  * (C) 2010-2011 Red Hat, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _XT_AUDIT_TARGET_H
diff --git a/include/uapi/linux/netfilter/xt_connmark.h b/include/uapi/linux/netfilter/xt_connmark.h
index f01c19b83a2b..41b578ccd03b 100644
--- a/include/uapi/linux/netfilter/xt_connmark.h
+++ b/include/uapi/linux/netfilter/xt_connmark.h
@@ -1,18 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/* Copyright (C) 2002,2004 MARA Systems AB <https://www.marasystems.com>
+ * by Henrik Nordstrom <hno@marasystems.com>
+ */
+
 #ifndef _XT_CONNMARK_H
 #define _XT_CONNMARK_H
 
 #include <linux/types.h>
 
-/* Copyright (C) 2002,2004 MARA Systems AB <https://www.marasystems.com>
- * by Henrik Nordstrom <hno@marasystems.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
 enum {
 	XT_CONNMARK_SET = 0,
 	XT_CONNMARK_SAVE,
diff --git a/include/uapi/linux/netfilter/xt_osf.h b/include/uapi/linux/netfilter/xt_osf.h
index 6e466236ca4b..f1f097896bdf 100644
--- a/include/uapi/linux/netfilter/xt_osf.h
+++ b/include/uapi/linux/netfilter/xt_osf.h
@@ -1,20 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
 /*
  * Copyright (c) 2003+ Evgeniy Polyakov <johnpol@2ka.mxt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _XT_OSF_H
-- 
2.34.1

