Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70FA6CAF23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjC0Ttd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjC0Tt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:49:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6AB170B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:49:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so7741629wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679946555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+ndiX5rXJ02XC2sW9a3uAWMCd1mtaGH5vgN2+hWRpM=;
        b=lUNofYe7Tgq1WR1WRbmtJUtFok3sGtUwKGREElZ4LpzBWRMH/Pj/fB7F9IV5PRSqgL
         WMKAHfmsN5N3kzwvYzWgP8CI3hWurW7tbeL90ggZmF5moLrDhwmUtPiDgp7pAPtktiya
         pooetdmRKwC3ZX+HpH1cJxqWjiJlHqAWCyDNmfb7MtC7hHMmu+QuQsJv0YLu/Ax6gd0b
         KZoDS17T8Wm82hodqADDbrJv+jVp5SeL30ZbCkcOp4LCNScJswtgtkqjY6/3Cv3gxVrL
         dT87qvq55x4f4v0qMVvjngTlEOwJFQ/gzfp+73p0Omhgm50eHgh+YTznp9lmONMGWzKv
         ATyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679946555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+ndiX5rXJ02XC2sW9a3uAWMCd1mtaGH5vgN2+hWRpM=;
        b=Y3ej4lW1lHjiZ0A4xNVmf3SV7rAfse5o3dhHSNdhQlrq4M647McbiT5hejuQjFUZ1E
         0YnKtD5DONHg2PLb3nBJJoSqT9aSDqq78HQiTrZBV14ElOj5UAeibDnNQrVwqFNiJ13c
         pkz6TRcb97niOf9GWFmj9hyigl+GVH283uCC8il37xB8ixvOM7t8l6cPi8qmKMLraSn9
         6No1rZqJ3DdMJgNPq6qWa4rNiDSGofq0SmfS0M2qlDObifERIRfyN5Vre6o0t42PYEOM
         yopwNSCPF/oBoCT9gFWhJGvXRZgkx2vI7vsEe0JKzc4nK7Thh8Uorx9RvzfzAlmgqSYq
         9Xyg==
X-Gm-Message-State: AO0yUKUyJQd0Tb7fa0I1y4sDBTjRF6aWrAHpPKhk7mrh7aVNVOJi8D63
        63yE1AfSesZCfCtgfFjgWVY=
X-Google-Smtp-Source: AK7set+tT4xHUiGnq6RSW28Uqrpa66lsGupdL7ofW1l7uQdAEe3MdFr/Wn45tTxEDyUolU6rWSZ8Qw==
X-Received: by 2002:a05:600c:28b:b0:3ed:5cf7:3080 with SMTP id 11-20020a05600c028b00b003ed5cf73080mr10030913wmk.5.1679946554791;
        Mon, 27 Mar 2023 12:49:14 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id c13-20020a05600c0acd00b003ee42696acesm14661366wmr.16.2023.03.27.12.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:49:14 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] staging: rtl8192u: remove change history from comments
Date:   Tue, 28 Mar 2023 00:49:06 +0500
Message-Id: <95fff39231ebb2bb683c2a8f252a93f4845fffb1.1679945728.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679945728.git.kamrankhadijadj@gmail.com>
References: <cover.1679945728.git.kamrankhadijadj@gmail.com>
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

Remove the change history information as it is not required in the
comments.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 45 ----------------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 6a33ca02c3dc..b1ebb776fc42 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -7,12 +7,6 @@ Module Name:
 
 Abstract:
 	HW dynamic mechanism.
-
-Major Change History:
-	When		Who				What
-	----------	--------------- -------------------------------
-	2008-05-14	amy                     create version 0 porting from windows code.
-
 --*/
 #include "r8192U.h"
 #include "r8192U_dm.h"
@@ -274,11 +268,6 @@ void init_rate_adaptive(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	05/26/08	amy	Create version 0 porting from windows code.
- *
  *---------------------------------------------------------------------------*/
 static void dm_check_rate_adaptive(struct net_device *dev)
 {
@@ -1589,11 +1578,6 @@ static void dm_bb_initialgain_backup(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	05/15/2008	amy		Create Version 0 porting from windows code.
- *
  *---------------------------------------------------------------------------*/
 static void dm_dig_init(struct net_device *dev)
 {
@@ -1634,10 +1618,6 @@ static void dm_dig_init(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	05/27/2008	amy		Create Version 0 porting from windows code.
  *---------------------------------------------------------------------------*/
 static void dm_ctrl_initgain_byrssi(struct net_device *dev)
 {
@@ -1850,11 +1830,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
  * Output:		NONE
  *
  * Return:		NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	05/28/2008	amy		Create Version 0 porting from windows code.
- *
  *---------------------------------------------------------------------------*/
 static void dm_ctrl_initgain_byrssi_highpwr(
 	struct net_device *dev)
@@ -2269,11 +2244,6 @@ static void dm_ctstoself(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	05/28/2008	amy	Create Version 0 porting from windows code.
- *
  *---------------------------------------------------------------------------*/
 static	void	dm_check_pbc_gpio(struct net_device *dev)
 {
@@ -2303,11 +2273,6 @@ static	void	dm_check_pbc_gpio(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	01/30/2008	MHC		Create Version 0.
- *
  *---------------------------------------------------------------------------*/
 void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
 {
@@ -2552,11 +2517,6 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	05/28/2008	amy		Create Version 0 porting from windows code.
- *
  *---------------------------------------------------------------------------*/
 static void dm_check_rx_path_selection(struct net_device *dev)
 {
@@ -2871,11 +2831,6 @@ void dm_check_fsync(struct net_device *dev)
  * Output:		NONE
  *
  * Return:		NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	03/06/2008	Jacken	Create Version 0.
- *
  *---------------------------------------------------------------------------
  */
 static void dm_init_dynamic_txpower(struct net_device *dev)
-- 
2.34.1

