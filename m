Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAB05B4EB3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiIKMLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 08:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiIKMLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 08:11:07 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DFA303EB
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 05:11:05 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id XLnjox3GD9RnzXLnjofkL5; Sun, 11 Sep 2022 14:11:03 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Sep 2022 14:11:03 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH] headers: Remove some left-over license text in include/uapi/linux/dvb/
Date:   Sun, 11 Sep 2022 14:10:59 +0200
Message-Id: <84668f75659991dc2c2fa9728badfcf918485fc1.1662898254.git.christophe.jaillet@wanadoo.fr>
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
license identifier to uapi header files wi

When the SPDX-License-Identifier tag has been added, the corresponding
license text has not been removed.

Remove it now.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/uapi/linux/dvb/audio.h    | 15 ---------------
 include/uapi/linux/dvb/ca.h       | 15 ---------------
 include/uapi/linux/dvb/dmx.h      | 15 ---------------
 include/uapi/linux/dvb/frontend.h | 15 ---------------
 include/uapi/linux/dvb/net.h      | 15 ---------------
 include/uapi/linux/dvb/osd.h      | 15 ---------------
 include/uapi/linux/dvb/version.h  | 15 ---------------
 include/uapi/linux/dvb/video.h    | 15 ---------------
 8 files changed, 120 deletions(-)

diff --git a/include/uapi/linux/dvb/audio.h b/include/uapi/linux/dvb/audio.h
index 2f869da69171..77fb866890b4 100644
--- a/include/uapi/linux/dvb/audio.h
+++ b/include/uapi/linux/dvb/audio.h
@@ -7,21 +7,6 @@
  * Copyright (C) 2000 Ralph  Metzler <ralph@convergence.de>
  *                  & Marcus Metzler <marcus@convergence.de>
  *                    for convergence integrated media GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Lesser Public License
- * as published by the Free Software Foundation; either version 2.1
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
  */
 
 #ifndef _DVBAUDIO_H_
diff --git a/include/uapi/linux/dvb/ca.h b/include/uapi/linux/dvb/ca.h
index dffa59e95ebb..4244b187cc4d 100644
--- a/include/uapi/linux/dvb/ca.h
+++ b/include/uapi/linux/dvb/ca.h
@@ -5,21 +5,6 @@
  * Copyright (C) 2000 Ralph  Metzler <ralph@convergence.de>
  *                  & Marcus Metzler <marcus@convergence.de>
  *                    for convergence integrated media GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Lesser Public License
- * as published by the Free Software Foundation; either version 2.1
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
  */
 
 #ifndef _DVBCA_H_
diff --git a/include/uapi/linux/dvb/dmx.h b/include/uapi/linux/dvb/dmx.h
index b4112f0b6dd3..7b16375f94e2 100644
--- a/include/uapi/linux/dvb/dmx.h
+++ b/include/uapi/linux/dvb/dmx.h
@@ -5,21 +5,6 @@
  * Copyright (C) 2000 Marcus Metzler <marcus@convergence.de>
  *                  & Ralph  Metzler <ralph@convergence.de>
  *                    for convergence integrated media GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2.1
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
  */
 
 #ifndef _UAPI_DVBDMX_H_
diff --git a/include/uapi/linux/dvb/frontend.h b/include/uapi/linux/dvb/frontend.h
index 4f9b4551c534..2c5b9563804a 100644
--- a/include/uapi/linux/dvb/frontend.h
+++ b/include/uapi/linux/dvb/frontend.h
@@ -7,21 +7,6 @@
  *		    Holger Waechtler <holger@convergence.de>
  *		    Andre Draszik <ad@convergence.de>
  *		    for convergence integrated media GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2.1
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
  */
 
 #ifndef _DVBFRONTEND_H_
diff --git a/include/uapi/linux/dvb/net.h b/include/uapi/linux/dvb/net.h
index 0c550ef93f2c..7cbb47ac38ef 100644
--- a/include/uapi/linux/dvb/net.h
+++ b/include/uapi/linux/dvb/net.h
@@ -5,21 +5,6 @@
  * Copyright (C) 2000 Marcus Metzler <marcus@convergence.de>
  *                  & Ralph  Metzler <ralph@convergence.de>
  *                    for convergence integrated media GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2.1
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
  */
 
 #ifndef _DVBNET_H_
diff --git a/include/uapi/linux/dvb/osd.h b/include/uapi/linux/dvb/osd.h
index 858997c74043..6003b108ba45 100644
--- a/include/uapi/linux/dvb/osd.h
+++ b/include/uapi/linux/dvb/osd.h
@@ -7,21 +7,6 @@
  * Copyright (C) 2001 Ralph  Metzler <ralph@convergence.de>
  *                  & Marcus Metzler <marcus@convergence.de>
  *                    for convergence integrated media GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Lesser Public License
- * as published by the Free Software Foundation; either version 2.1
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
  */
 
 #ifndef _DVBOSD_H_
diff --git a/include/uapi/linux/dvb/version.h b/include/uapi/linux/dvb/version.h
index 2c5cffe6d2a0..1a8cd038aa0b 100644
--- a/include/uapi/linux/dvb/version.h
+++ b/include/uapi/linux/dvb/version.h
@@ -4,21 +4,6 @@
  *
  * Copyright (C) 2000 Holger Waechtler <holger@convergence.de>
  *                    for convergence integrated media GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2.1
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
  */
 
 #ifndef _DVBVERSION_H_
diff --git a/include/uapi/linux/dvb/video.h b/include/uapi/linux/dvb/video.h
index 179f1ec60af6..9910b73737e0 100644
--- a/include/uapi/linux/dvb/video.h
+++ b/include/uapi/linux/dvb/video.h
@@ -7,21 +7,6 @@
  * Copyright (C) 2000 Marcus Metzler <marcus@convergence.de>
  *                  & Ralph  Metzler <ralph@convergence.de>
  *                    for convergence integrated media GmbH
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2.1
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
  */
 
 #ifndef _UAPI_DVBVIDEO_H_
-- 
2.34.1

