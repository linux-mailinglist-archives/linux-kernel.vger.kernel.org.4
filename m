Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C466D29FA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjCaV2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjCaV2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:28:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925C223FD4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:28:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h8so94868969ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680298104; x=1682890104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRCbMUje3cpH1xwjxBasK79dtrxHrD4T1n+xlf4Bj5I=;
        b=AxlBnyKadKVXmu+QpVSZZZEYhaX7SSoipSLThw6HsUfjqAcYlzbcn7+qDJccZSIy+U
         pvTl2SSUF96wMQxL59VO408vvKscOORjJjYL7oSmbrEmnMOvr1axMJrU0PT09pakdYRV
         X4yUNIHJ1jDgZiUL8iWNkr2geIquyG9pAqjNMzoYonv6EYg3hId/djkk7AAjyR4l/bEV
         2Alh3b7yiBeZbxheNSckQuBd+1ye+EDdxqPK2uJqusC2lUjS0825KZMxyCBQ+bB88elZ
         0t7yxncOIDL6iBGuKlYQ/VSRJKauffS37WweRq5YBMnZAcR/08oTnK2J8OORyvO+ZohH
         8E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680298104; x=1682890104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRCbMUje3cpH1xwjxBasK79dtrxHrD4T1n+xlf4Bj5I=;
        b=KrSyz4pu2644ATZqc60QJHb7Fxn0PgyAMS/PSrbqmvYHps95tSwaAkVQUKl2aWYPVH
         tLZqs63aLyhqlnmNTMdUj2hH4ypNBGwlH22uc4IzaGWJ9avnRwfVFiEwxLiLmaFzL2k8
         dRDa0MWLUzPfLBOT1lZPU5vAoeGDSfZoCplnqwFRE87p8HMLQnoipFll+hTU4n45y1Cr
         uW34HBTe9+i7zR9tWC6ie7ulBlvjKX3DX1j0LdEgKpNx/RSBiveuHRwWg+N6y1CkzE+d
         tbChj4nERC00wjg+G5sjQtfVI9FjU5Ohe4g5NDqg7tBCvgO9Sx8mNmWz0rncR4DlkWji
         gdkA==
X-Gm-Message-State: AAQBX9cvk+jSKkPwWODuRpt/GvcPtNv0VYvupD1BBFZaGXGADKw7vkU3
        C3As8WAh/RHIBhqEG5B6Pf0=
X-Google-Smtp-Source: AKy350aowEQ04TzOniwFMcPRznhogZogpjU3hgXHKDccY6WyxcnTrUApAROULvLijFNT6nNrMWK1FQ==
X-Received: by 2002:a17:906:101c:b0:929:b101:937d with SMTP id 28-20020a170906101c00b00929b101937dmr5559316ejm.1.1680298103964;
        Fri, 31 Mar 2023 14:28:23 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id v7-20020a170906564700b009447277c26fsm1372726ejr.72.2023.03.31.14.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:28:23 -0700 (PDT)
Date:   Fri, 31 Mar 2023 23:28:21 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: rtl8192e: Remove case customer_id =
 RT_CID_819x_CAMEO, ..
Message-ID: <72d9c0325ecabc007234ac5d4dba27556168d8a9.1680297150.git.philipp.g.hortmann@gmail.com>
References: <cover.1680297150.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680297150.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

customer_id is initialize to zero. Changing customer_id to
RT_CID_819x_CAMEO, RT_CID_819x_RUNTOP, RT_CID_Nettronix or RT_CID_PRONET
would not change the program execution as there is no equation for
RT_CID_819x_CAMEO, RT_CID_819x_RUNTOP, RT_CID_Nettronix or RT_CID_PRONET.
Remove useless code lines to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 12 ------------
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h  |  4 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  4 ----
 3 files changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index cbe66b4a6ad9..df8de35cbe0e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -435,12 +435,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	case EEPROM_CID_DEFAULT:
 		priv->customer_id = RT_CID_DEFAULT;
 		break;
-	case EEPROM_CID_CAMEO:
-		priv->customer_id = RT_CID_819x_CAMEO;
-		break;
-	case  EEPROM_CID_RUNTOP:
-		priv->customer_id = RT_CID_819x_RUNTOP;
-		break;
 	case EEPROM_CID_NetCore:
 		priv->customer_id = RT_CID_819X_NETCORE;
 		break;
@@ -451,12 +445,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		else
 			priv->chnl_plan = 0x0;
 		break;
-	case EEPROM_CID_Nettronix:
-		priv->customer_id = RT_CID_Nettronix;
-		break;
-	case EEPROM_CID_Pronet:
-		priv->customer_id = RT_CID_PRONET;
-		break;
 
 	case EEPROM_CID_WHQL:
 		break;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 706d024bcfd1..4ee78b7a558e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -31,12 +31,8 @@ enum baseband_config {
 #define EEPROM_TxPwIndex_OFDM_24G	0x3A
 
 #define EEPROM_CID_DEFAULT			0x0
-#define EEPROM_CID_CAMEO				0x1
-#define EEPROM_CID_RUNTOP				0x2
 #define EEPROM_CID_TOSHIBA				0x4
 #define EEPROM_CID_NetCore				0x5
-#define EEPROM_CID_Nettronix			0x6
-#define EEPROM_CID_Pronet				0x7
 #define EEPROM_CID_WHQL					0xFE
 enum _RTL8192PCI_HW {
 	MAC0			= 0x000,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 91d634f5d3e7..2b2d8af4cf6e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -129,12 +129,8 @@ enum dcmg_txcmd_op {
 
 enum rt_customer_id {
 	RT_CID_DEFAULT	  = 0,
-	RT_CID_819x_CAMEO       = 6,
-	RT_CID_819x_RUNTOP      = 7,
 	RT_CID_TOSHIBA	  = 9,
 	RT_CID_819X_NETCORE     = 10,
-	RT_CID_Nettronix	= 11,
-	RT_CID_PRONET	   = 13,
 };
 
 enum reset_type {
-- 
2.40.0

