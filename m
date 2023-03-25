Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186AB6C8DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjCYMNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjCYMN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:13:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0191B1422D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:13:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t15so4189238wrz.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679746405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul/BAwjN6kVOclIZnvLzH9MCidPTY/so8Fz3YYqE9pQ=;
        b=LP70QvdBjKIgCHf8mf9AJhUFPz8EuASPOyfqA6khc6kBDPK55XnDiMML6YTZbLPQot
         s10TJJ3KJ876QP2WUnUPEZIU2PSOYk9NVrN/c72yqhsrk4L9E9lLF5DjHG3Wmu6HezUt
         FEk5yY5w9to13YVmw70BEB1fSzynlALNIxhi9hI6Q7Z2AOcV1B1wxZF2619FlEufLHpV
         sGIrt3GMxZ83JbI8fxGqXPm+dbtVQREH6MVmWyJYsfxcrZ1d1iNx1L9HxlvviTWzDA9l
         DsWw7pYK9VkD1YSTfD7LHra2yTitmLfn52YhX75mTCG4pPcUAfFRtq5jUnU9OQgbEGFX
         uFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679746405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ul/BAwjN6kVOclIZnvLzH9MCidPTY/so8Fz3YYqE9pQ=;
        b=ywsC894WJt5+vUayJwL23Ik/NNYeM6OBqMmCo3356Car3Egebmz/l7g5sdtW1RQO09
         ReghWsSOm5wRWKvhorF6t+lr1l7l1tE8MHuYgiMTUdvZZdS9bcqj+PEhz2nnoCXfA6gY
         kq6e0SfIE99bQxyR4I8UASO+dn1zDpKIiFGOmvK8fb1bxfxHdH/7iCfHhErvhcr87a+X
         viPugAbrxJljOY/vg1vJ3TM//JdnBEAb5Q0OPoQ2pLH9kuGqPDVBM3UNpkw5FMn1D6gw
         /n5N0yycoozr2kCje/A5L9Uky5fHhsB+hKiy/BH3oJi4ImGH4G1+asi/qIYweE62slPs
         Fk5Q==
X-Gm-Message-State: AAQBX9dufsBvvXZkhK5VOUP/2ww/qPVSLCkc+hC/U2jV7pix4aYa082G
        V8yPqxASyP8/2NlONyJE0meKEOUjnNBpxg==
X-Google-Smtp-Source: AKy350ZGeEMPsmcr9t1MWGI2OgG/QSumMvuWwD4IfF/URVCUTSbodvMXt6aAJK/xwgthfbPR/6VylQ==
X-Received: by 2002:adf:e345:0:b0:2cf:e436:f722 with SMTP id n5-20020adfe345000000b002cfe436f722mr4160832wrj.64.1679746405299;
        Sat, 25 Mar 2023 05:13:25 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b002c70c99db74sm20504791wrr.86.2023.03.25.05.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 05:13:25 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: rtl8192u: remove change history from comments
Date:   Sat, 25 Mar 2023 17:13:17 +0500
Message-Id: <c4ec9246e2d103c15e451fe3d6ed42692c93d39f.1679744684.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679744684.git.kamrankhadijadj@gmail.com>
References: <cover.1679744684.git.kamrankhadijadj@gmail.com>
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

Developers use git to browse the file history so revision history is not
required in the comments.
Remove the change history information from the comments.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 36 ----------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index a88686be3523..885c5966342f 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -8,11 +8,6 @@
  * Abstract:
  *	HW dynamic mechanism.
  *
- * Major Change History:
- *	When		Who				What
- *	----------	--------------- -------------------------------
- *	2008-05-14	amy                     create version 0 porting from windows code.
- *
  *--
  */
 #include "r8192U.h"
@@ -276,10 +271,6 @@ void init_rate_adaptive(struct net_device *dev)
  *
  * Return:		NONE
  *
- * Revised History:
- *	When		Who		Remark
- *	05/26/08	amy	Create version 0 porting from windows code.
- *
  *---------------------------------------------------------------------------
  */
 static void dm_check_rate_adaptive(struct net_device *dev)
@@ -1594,10 +1585,6 @@ static void dm_bb_initialgain_backup(struct net_device *dev)
  *
  * Return:		NONE
  *
- * Revised History:
- *	When		Who		Remark
- *	05/15/2008	amy		Create Version 0 porting from windows code.
- *
  *---------------------------------------------------------------------------
  */
 static void dm_dig_init(struct net_device *dev)
@@ -1640,9 +1627,6 @@ static void dm_dig_init(struct net_device *dev)
  *
  * Return:		NONE
  *
- * Revised History:
- *	When		Who		Remark
- *	05/27/2008	amy		Create Version 0 porting from windows code.
  *---------------------------------------------------------------------------
  */
 static void dm_ctrl_initgain_byrssi(struct net_device *dev)
@@ -1857,10 +1841,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
  *
  * Return:		NONE
  *
- * Revised History:
- *	When		Who		Remark
- *	05/28/2008	amy		Create Version 0 porting from windows code.
- *
  *---------------------------------------------------------------------------
  */
 static void dm_ctrl_initgain_byrssi_highpwr(
@@ -2277,10 +2257,6 @@ static void dm_ctstoself(struct net_device *dev)
  *
  * Return:		NONE
  *
- * Revised History:
- *	When		Who		Remark
- *	05/28/2008	amy	Create Version 0 porting from windows code.
- *
  *---------------------------------------------------------------------------
  */
 static	void	dm_check_pbc_gpio(struct net_device *dev)
@@ -2312,10 +2288,6 @@ static	void	dm_check_pbc_gpio(struct net_device *dev)
  *
  * Return:		NONE
  *
- * Revised History:
- *	When		Who		Remark
- *	01/30/2008	MHC		Create Version 0.
- *
  *---------------------------------------------------------------------------
  */
 void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
@@ -2562,10 +2534,6 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
  *
  * Return:		NONE
  *
- * Revised History:
- *	When		Who		Remark
- *	05/28/2008	amy		Create Version 0 porting from windows code.
- *
  *---------------------------------------------------------------------------
  */
 static void dm_check_rx_path_selection(struct net_device *dev)
@@ -2882,10 +2850,6 @@ void dm_check_fsync(struct net_device *dev)
  *
  * Return:		NONE
  *
- * Revised History:
- *	When		Who		Remark
- *	03/06/2008	Jacken	Create Version 0.
- *
  *---------------------------------------------------------------------------
  */
 static void dm_init_dynamic_txpower(struct net_device *dev)
-- 
2.34.1

