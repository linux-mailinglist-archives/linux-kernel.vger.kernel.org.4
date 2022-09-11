Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB1C5B4F96
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 17:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIKPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 11:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIKPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 11:13:34 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040FC2F00B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 08:13:30 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id XOeGollkiLFqbXOeGofXYY; Sun, 11 Sep 2022 17:13:28 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Sep 2022 17:13:28 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH] headers: Remove some left-over license text in include/uapi/linux/v4l2-*
Date:   Sun, 11 Sep 2022 17:13:14 +0200
Message-Id: <5cd6b31b4db9d2348f99181b204856672c6ae942.1662909187.git.christophe.jaillet@wanadoo.fr>
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

Remove some left-over from commit e2be04c7f995 ("License cleanup: add SPDX
license identifier to uapi header files with a license")

When the SPDX-License-Identifier tag has been added, the corresponding
license text has not been removed.

Remove it now.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/uapi/linux/v4l2-common.h     | 39 ----------------------------
 include/uapi/linux/v4l2-controls.h   | 38 ---------------------------
 include/uapi/linux/v4l2-dv-timings.h |  9 -------
 include/uapi/linux/v4l2-mediabus.h   |  4 ---
 include/uapi/linux/v4l2-subdev.h     | 13 ----------
 5 files changed, 103 deletions(-)

diff --git a/include/uapi/linux/v4l2-common.h b/include/uapi/linux/v4l2-common.h
index 7d21c1634b4d..5a23a15d78ac 100644
--- a/include/uapi/linux/v4l2-common.h
+++ b/include/uapi/linux/v4l2-common.h
@@ -10,45 +10,6 @@
  *
  * Copyright (C) 2012 Nokia Corporation
  * Contact: Sakari Ailus <sakari.ailus@iki.fi>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  Alternatively you can redistribute this file under the terms of the
- *  BSD license as stated below:
- *
- *  Redistribution and use in source and binary forms, with or without
- *  modification, are permitted provided that the following conditions
- *  are met:
- *  1. Redistributions of source code must retain the above copyright
- *     notice, this list of conditions and the following disclaimer.
- *  2. Redistributions in binary form must reproduce the above copyright
- *     notice, this list of conditions and the following disclaimer in
- *     the documentation and/or other materials provided with the
- *     distribution.
- *  3. The names of its contributors may not be used to endorse or promote
- *     products derived from this software without specific prior written
- *     permission.
- *
- *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
- *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
  */
 
 #ifndef __V4L2_COMMON__
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index b5e7d082b8ad..dabfb9f86bcd 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -4,44 +4,6 @@
  *
  *  Copyright (C) 1999-2012 the contributors
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  Alternatively you can redistribute this file under the terms of the
- *  BSD license as stated below:
- *
- *  Redistribution and use in source and binary forms, with or without
- *  modification, are permitted provided that the following conditions
- *  are met:
- *  1. Redistributions of source code must retain the above copyright
- *     notice, this list of conditions and the following disclaimer.
- *  2. Redistributions in binary form must reproduce the above copyright
- *     notice, this list of conditions and the following disclaimer in
- *     the documentation and/or other materials provided with the
- *     distribution.
- *  3. The names of its contributors may not be used to endorse or promote
- *     products derived from this software without specific prior written
- *     permission.
- *
- *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
- *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
  *  The contents of this header was split off from videodev2.h. All control
  *  definitions should be added to this header, which is included by
  *  videodev2.h.
diff --git a/include/uapi/linux/v4l2-dv-timings.h b/include/uapi/linux/v4l2-dv-timings.h
index b52b67c62562..ef0128c7369c 100644
--- a/include/uapi/linux/v4l2-dv-timings.h
+++ b/include/uapi/linux/v4l2-dv-timings.h
@@ -3,15 +3,6 @@
  * V4L2 DV timings header.
  *
  * Copyright (C) 2012-2016  Hans Verkuil <hans.verkuil@cisco.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #ifndef _V4L2_DV_TIMINGS_H
diff --git a/include/uapi/linux/v4l2-mediabus.h b/include/uapi/linux/v4l2-mediabus.h
index 903e67b16711..6b07b73473b5 100644
--- a/include/uapi/linux/v4l2-mediabus.h
+++ b/include/uapi/linux/v4l2-mediabus.h
@@ -3,10 +3,6 @@
  * Media Bus API header
  *
  * Copyright (C) 2009, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __LINUX_V4L2_MEDIABUS_H
diff --git a/include/uapi/linux/v4l2-subdev.h b/include/uapi/linux/v4l2-subdev.h
index 658106f5b5dc..ecce4c79f5c5 100644
--- a/include/uapi/linux/v4l2-subdev.h
+++ b/include/uapi/linux/v4l2-subdev.h
@@ -6,19 +6,6 @@
  *
  * Contacts: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
  *	     Sakari Ailus <sakari.ailus@iki.fi>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #ifndef __LINUX_V4L2_SUBDEV_H
-- 
2.34.1

