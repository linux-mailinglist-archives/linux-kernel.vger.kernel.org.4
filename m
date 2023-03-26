Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998B56C9425
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCZMSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjCZMSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:18:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F616EA0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:18:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r29so5905867wra.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679833116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSLEXHRsEJps7ELpV4Jn/+ui6caTrq4Ep39Ig5tNybM=;
        b=kfhTWTquCifZnXz3iJ/NzrWHfXblvsyycFdUGhAxm+ufn4tk6Rmt4GePje+f9cG/H1
         9lccw77w0yFqYlURaTgGHfIY1pWb69XopfkMXi9Tvocb+PLaKxRUcBNv8P0diPYb+0/b
         DSvKqVZU7g+YWcnIz5VPshyrHE7m8EIOvXh8pQSwFoMTMqDTLdiqmZ/MviW2qXBw8yPf
         ZQEWxyb9DEMar7OjBEEGcx2kzgGgquK/B2nfwI44MqqPvhiyw8ze7Zv2xFeOR1OrUpK1
         gamN7UVehTR+9Np4KX3FoiWc5slCLY0wFHIkJN1ADCT+XnwWKSVu95ub7PsBPSrHD/We
         DgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679833116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSLEXHRsEJps7ELpV4Jn/+ui6caTrq4Ep39Ig5tNybM=;
        b=Q4bOcvmbzne56rJsKVCsxaCRxDfGfk/SBmQoE1yfKHoyTw0hbacv5huAX/I3MnF8H9
         A1A1451xHLhxNqX9pCL0xZOflPahmLpGxEcK3pOixzmCDmfY4AN8+0x0lKwy3lgeSk5x
         mzjesi8WZTs1T7kmM3ghX5dwTdgXSwHPfQ6jrGZYCRUNo26KPpwmKYWkqj2LgEPUi3CC
         vzrFHz0uYD7mc+hn8txezSQZV1D6R1mcCCmxcFeHeqaVyE+89606uM/EaBKg7AbAAzce
         8bgqlxej9t8VP7LpnUJYFDyfsbQtqiGHU6QjTsHDEsx9+Yv/s+oIXprR1mZE+L8LTiuL
         K48A==
X-Gm-Message-State: AAQBX9ecpIRUdVYbt/IKpNMvCKN/Giuuzk7ESpCXChWbm2PP+K3Hh9Qg
        vcz8lg00bnJwTxxLags6WeouXH/6LluqlQ==
X-Google-Smtp-Source: AKy350aMzS04QInZCbc9pY2PgmiJwpj0rj0B90FuRZhiUX8X70KNZB8tRT9j47TU3fM7Zj6adtpuUA==
X-Received: by 2002:adf:e382:0:b0:2ce:a46f:bbc5 with SMTP id e2-20020adfe382000000b002cea46fbbc5mr6852010wrm.34.1679833116595;
        Sun, 26 Mar 2023 05:18:36 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id d10-20020adfe88a000000b002c70e60abd4sm22740265wrm.2.2023.03.26.05.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 05:18:36 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] staging: rtl8192u: reformat block comments
Date:   Sun, 26 Mar 2023 17:18:27 +0500
Message-Id: <d49d15e620aa9239f3d68df1a5f8b600de77b536.1679831899.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679831899.git.kamrankhadijadj@gmail.com>
References: <cover.1679831899.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel coding style for block comments uses a column of '*' on the
left side and  uses '*/' on a separate line.

Fix block comments by adding '*' on subsequent lines and moving '*/' at
the end of block comments on a separate line. These issues in block
comments are reported by checkpatch.pl script.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 38 +++++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index e5c0bece4bb4..99c38a4cf54c 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -1,13 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /*++
-Copyright-c Realtek Semiconductor Corp. All rights reserved.
-
-Module Name:
-	r8192U_dm.c
-
-Abstract:
-	HW dynamic mechanism.
---*/
+ *Copyright-c Realtek Semiconductor Corp. All rights reserved.
+ *
+ *Module Name:
+ *	r8192U_dm.c
+ *
+ *Abstract:
+ *	HW dynamic mechanism.
+ *--
+ */
 #include "r8192U.h"
 #include "r8192U_dm.h"
 #include "r8192U_hw.h"
@@ -243,7 +244,8 @@ void init_rate_adaptive(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void dm_check_rate_adaptive(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -1524,7 +1526,8 @@ static void dm_bb_initialgain_backup(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void dm_dig_init(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -1564,7 +1567,8 @@ static void dm_dig_init(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void dm_ctrl_initgain_byrssi(struct net_device *dev)
 {
 	if (!dm_digtable.dig_enable_flag)
@@ -1750,7 +1754,8 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
  * Output:		NONE
  *
  * Return:		NONE
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void dm_ctrl_initgain_byrssi_highpwr(
 	struct net_device *dev)
 {
@@ -2136,7 +2141,8 @@ static void dm_ctstoself(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static	void	dm_check_pbc_gpio(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -2165,7 +2171,8 @@ static	void	dm_check_pbc_gpio(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
@@ -2406,7 +2413,8 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void dm_check_rx_path_selection(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
-- 
2.34.1

