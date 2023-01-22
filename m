Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7F6771B8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjAVTLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjAVTLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:11:11 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7A41630D
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:11:08 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 89BFE60002;
        Sun, 22 Jan 2023 19:11:06 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] staging: wlan-ng: Fix full name of the GPL
Date:   Sun, 22 Jan 2023 20:10:47 +0100
Message-Id: <20230122191047.58769-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 drivers/staging/wlan-ng/hfa384x.h          | 4 ++--
 drivers/staging/wlan-ng/hfa384x_usb.c      | 4 ++--
 drivers/staging/wlan-ng/p80211conv.c       | 4 ++--
 drivers/staging/wlan-ng/p80211conv.h       | 4 ++--
 drivers/staging/wlan-ng/p80211hdr.h        | 4 ++--
 drivers/staging/wlan-ng/p80211ioctl.h      | 4 ++--
 drivers/staging/wlan-ng/p80211metadef.h    | 4 ++--
 drivers/staging/wlan-ng/p80211metastruct.h | 4 ++--
 drivers/staging/wlan-ng/p80211mgmt.h       | 4 ++--
 drivers/staging/wlan-ng/p80211msg.h        | 4 ++--
 drivers/staging/wlan-ng/p80211netdev.c     | 4 ++--
 drivers/staging/wlan-ng/p80211netdev.h     | 4 ++--
 drivers/staging/wlan-ng/p80211req.c        | 4 ++--
 drivers/staging/wlan-ng/p80211req.h        | 4 ++--
 drivers/staging/wlan-ng/p80211types.h      | 4 ++--
 drivers/staging/wlan-ng/p80211wep.c        | 4 ++--
 drivers/staging/wlan-ng/prism2fw.c         | 4 ++--
 drivers/staging/wlan-ng/prism2mgmt.c       | 4 ++--
 drivers/staging/wlan-ng/prism2mgmt.h       | 4 ++--
 drivers/staging/wlan-ng/prism2mib.c        | 4 ++--
 drivers/staging/wlan-ng/prism2sta.c        | 4 ++--
 21 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index 0611e37df6ac..2ccca000df6d 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index c7cd54171d99..464a124bcf40 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211conv.c b/drivers/staging/wlan-ng/p80211conv.c
index cd271b1da69f..ff6e88c573f4 100644
--- a/drivers/staging/wlan-ng/p80211conv.c
+++ b/drivers/staging/wlan-ng/p80211conv.c
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211conv.h b/drivers/staging/wlan-ng/p80211conv.h
index dfb762bce84d..54adbbcb51a9 100644
--- a/drivers/staging/wlan-ng/p80211conv.h
+++ b/drivers/staging/wlan-ng/p80211conv.h
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211hdr.h b/drivers/staging/wlan-ng/p80211hdr.h
index 93195a4c5b01..ecf00cab86a0 100644
--- a/drivers/staging/wlan-ng/p80211hdr.h
+++ b/drivers/staging/wlan-ng/p80211hdr.h
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211ioctl.h b/drivers/staging/wlan-ng/p80211ioctl.h
index b50ce11147dd..ea67ca7b77c6 100644
--- a/drivers/staging/wlan-ng/p80211ioctl.h
+++ b/drivers/staging/wlan-ng/p80211ioctl.h
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211metadef.h b/drivers/staging/wlan-ng/p80211metadef.h
index 1b91b64c12ed..3b659d31273b 100644
--- a/drivers/staging/wlan-ng/p80211metadef.h
+++ b/drivers/staging/wlan-ng/p80211metadef.h
@@ -17,8 +17,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211metastruct.h b/drivers/staging/wlan-ng/p80211metastruct.h
index 4adc64580185..d8e44a61f568 100644
--- a/drivers/staging/wlan-ng/p80211metastruct.h
+++ b/drivers/staging/wlan-ng/p80211metastruct.h
@@ -17,8 +17,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
index fc23fae5651b..3e891db768f0 100644
--- a/drivers/staging/wlan-ng/p80211mgmt.h
+++ b/drivers/staging/wlan-ng/p80211mgmt.h
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211msg.h b/drivers/staging/wlan-ng/p80211msg.h
index f68d8b7d5ad8..33ccf4079e8a 100644
--- a/drivers/staging/wlan-ng/p80211msg.h
+++ b/drivers/staging/wlan-ng/p80211msg.h
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index 6bef419e8ad0..e498c050a99e 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211netdev.h b/drivers/staging/wlan-ng/p80211netdev.h
index 1cee51a1075e..10836a00da13 100644
--- a/drivers/staging/wlan-ng/p80211netdev.h
+++ b/drivers/staging/wlan-ng/p80211netdev.h
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211req.c b/drivers/staging/wlan-ng/p80211req.c
index 809cf3d480e9..000c7e9c1534 100644
--- a/drivers/staging/wlan-ng/p80211req.c
+++ b/drivers/staging/wlan-ng/p80211req.c
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211req.h b/drivers/staging/wlan-ng/p80211req.h
index bc45cd5f91e4..318c3142a426 100644
--- a/drivers/staging/wlan-ng/p80211req.h
+++ b/drivers/staging/wlan-ng/p80211req.h
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211types.h b/drivers/staging/wlan-ng/p80211types.h
index b2ed96960413..968afd69d0d4 100644
--- a/drivers/staging/wlan-ng/p80211types.h
+++ b/drivers/staging/wlan-ng/p80211types.h
@@ -20,8 +20,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/p80211wep.c b/drivers/staging/wlan-ng/p80211wep.c
index 3ff7ee7011df..48762233b130 100644
--- a/drivers/staging/wlan-ng/p80211wep.c
+++ b/drivers/staging/wlan-ng/p80211wep.c
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
index 02a2191d5c4d..9f924734e627 100644
--- a/drivers/staging/wlan-ng/prism2fw.c
+++ b/drivers/staging/wlan-ng/prism2fw.c
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index 9030a8939a9b..b9bf3b0128bc 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/prism2mgmt.h b/drivers/staging/wlan-ng/prism2mgmt.h
index 7132cec2d7eb..21de6e1918ba 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.h
+++ b/drivers/staging/wlan-ng/prism2mgmt.h
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/prism2mib.c b/drivers/staging/wlan-ng/prism2mib.c
index fcf8313870af..34e5a632401a 100644
--- a/drivers/staging/wlan-ng/prism2mib.c
+++ b/drivers/staging/wlan-ng/prism2mib.c
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index daa7cc4e897c..033186b516f3 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -19,8 +19,8 @@
  *   rights and limitations under the License.
  *
  *   Alternatively, the contents of this file may be used under the
- *   terms of the GNU Public License version 2 (the "GPL"), in which
- *   case the provisions of the GPL are applicable instead of the
+ *   terms of the GNU General Public License version 2 (the "GPL"), in
+ *   which case the provisions of the GPL are applicable instead of the
  *   above.  If you wish to allow the use of your version of this file
  *   only under the terms of the GPL and not to allow others to use
  *   your version of this file under the MPL, indicate your decision
-- 
2.39.0

