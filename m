Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF46C9424
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjCZMSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCZMSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:18:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C66A77
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:18:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e18so5924595wra.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679833113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+ndiX5rXJ02XC2sW9a3uAWMCd1mtaGH5vgN2+hWRpM=;
        b=EoqmL4czwnpypXkaiLwq1mubxGdDsD3UtFSRq0VlXSagUdJuJiwG092u9P+gv4TGg+
         qh/RrA2Jd/4+hj8CUVxUKoLlpsH5zVuy2kbiL/EmrC4/we1sWh4/qXLSxXvKh7UfhsNt
         yuMfrKtJEwM6Fhk/AxPWNbZraNYj0XSH31CDf8CfjlBSZcmOpZZRUvoEhuHmCOgB3L1o
         fGr9yQmc8bv+GffjKeZgwjTpGsVuLGeBrN1IjFS+k/oC4iG67t1SEZS2TomU02cV+yNA
         ZYulGTtVllI0PZuNWSDHsR57qqRIxki4v5OsVgcN8C+H68zskt6tLCyvieT87NZQlaHB
         V97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679833113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+ndiX5rXJ02XC2sW9a3uAWMCd1mtaGH5vgN2+hWRpM=;
        b=nQGvr3I6qoPQUDbIGbX4wBMjFLgTnbFucd9UGZVfnb12z0L0NM3WA6jUfheootQbjN
         DnZG0lmZ375FE7cAlS31nFMTIa9qurhDzimdptBhzxpT0qSTL++KQNsiKsAHKn/XarHP
         NFExy40Ef3vzRsnHdeA4h5Z+z2zW3DjN0L1tJkhGcHb7WYkM4ckRgCdkkd4IHbCKrTsq
         LE81kkkxk0hywaeIMTxD+2KGHd5Yw6zFZcFPyMInR60dZlXtzAL8g6js3SqNaJXbWvYV
         aEqoIMuN7mOmCqy1O9X4mDcO51JEmTrv/nVTJCZdtv0kLc5ZuFkP/20XOIAF6+h2h2wE
         Y40g==
X-Gm-Message-State: AAQBX9fq9mLEbY888tal6bxSIpy1JM8itc4kKRpD+vt/dDPDfnNzPuQp
        NbQNBSqhsJZqBIwhCZJQJSo=
X-Google-Smtp-Source: AKy350YMjAbzJOfnKXGFcAGBqbNrDrgu3ap6fRspTjdB8n/uIzLaKge/KVY+6pCNjHZH1wfH4l0R1w==
X-Received: by 2002:a5d:460d:0:b0:2c5:5a65:79a0 with SMTP id t13-20020a5d460d000000b002c55a6579a0mr7660558wrq.53.1679833113210;
        Sun, 26 Mar 2023 05:18:33 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id d10-20020adfe88a000000b002c70e60abd4sm22740265wrm.2.2023.03.26.05.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 05:18:32 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] staging: rtl8192u: remove change history from comments
Date:   Sun, 26 Mar 2023 17:18:25 +0500
Message-Id: <95fff39231ebb2bb683c2a8f252a93f4845fffb1.1679831899.git.kamrankhadijadj@gmail.com>
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

