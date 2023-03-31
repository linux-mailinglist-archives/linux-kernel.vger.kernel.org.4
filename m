Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2AA6D29F8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjCaV2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjCaV2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:28:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DF923FFA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:28:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-502507c7da4so244476a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680298098; x=1682890098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J25hLV3FiWX9nakLLPh8ft08O4hV9weZdaVT2vmny5g=;
        b=M3UB/OqFTUVzhx17Xvw+Y45bmYCpDuSluFqye4oH8pAVZzKlEdjAHdUodVOgQxKG1Z
         fXIpFv3hUsL7BcFFyQlrXQ/uFaUaCGNwF9wp9Ndjnxr2WAECurfze/BRn2p4KUivDLaY
         FakYt5rWdUSI54y3drY5DJ5b+WK3Q2wWGE+rQ0B41O/hHr55BsNtTr01VqR3YzlIpeUo
         9S9fVJ3AIQnh/+5Ek46Ex6VuXchhQCpktWQ/GclR2Z+vCRjQx6U1iUXKyjD9jkOTlTF7
         wxF8cbKsK43jGztMOlta5w96inDZnTjSca13SDOStO6d33C5ZypkarU7ssaEj+GLj/66
         ZaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680298098; x=1682890098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J25hLV3FiWX9nakLLPh8ft08O4hV9weZdaVT2vmny5g=;
        b=bFFA3rwDPfXkeWSh9U1rEwlIn70NB/R+9X67XK5EbCqyH5CLabqcbqyiWEAYxuwCR1
         KJix5LAX6EKLag87Zo+D0YXiKpbqyLh00jHBTFJ9JEXYuT4MDaBPtwEqY5xUoRhHRErP
         9AqYMTEtyAiPE4HRxfF4w1P8a7zkYD0XfXZig7jNi5Z+++rySvTjqt5A2e6g0iwpkkH3
         4MW1vjDARkDqmbG8TGIEN9YMdKkaKY/vpY++uir6vfwpr3B+G8kpMe7HCh1POngEzdXG
         WybcXuHB9ta/+gnDZFpNQPSEgAyFSUpPFZt+/V1oi9zIFGKhwP4HAUuh+hMViRTG+gSn
         WU7w==
X-Gm-Message-State: AAQBX9dnOiC7jfSiCgezPI8o4FtCv4LSmC+RAx/Ubdg1I8vEtp0gZRXU
        pukUPCz5peJJ90FZZfBI6Z5J+atHaAA=
X-Google-Smtp-Source: AKy350ZqWv1X0AQqpyjUZfzWoHYufJ7efeHzue1dd2mTvDgT+3o2eQB50GJ4LhKE06e659A/4h25wg==
X-Received: by 2002:a05:6402:524e:b0:500:3fd0:25a8 with SMTP id t14-20020a056402524e00b005003fd025a8mr7158816edd.0.1680298098261;
        Fri, 31 Mar 2023 14:28:18 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906394800b008cafeec917dsm1378502eje.101.2023.03.31.14.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:28:17 -0700 (PDT)
Date:   Fri, 31 Mar 2023 23:28:15 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: rtl8192e: Remove case customer_id = RT_CID_DLINK
Message-ID: <4786e89c7a394f0e7f4d17c35cda147b11162268.1680297150.git.philipp.g.hortmann@gmail.com>
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

customer_id is initialize to zero. Changing customer_id to RT_CID_DLINK
would not change the program execution as there is no equation for
RT_CID_DLINK. Remove useless code lines to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 6 ------
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h  | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 1 -
 3 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 1da14e737aa4..cbe66b4a6ad9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -431,9 +431,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	else
 		priv->chnl_plan = priv->reg_chnl_plan;
 
-	if (priv->eeprom_vid == 0x1186 &&  priv->eeprom_did == 0x3304)
-		priv->customer_id =  RT_CID_DLINK;
-
 	switch (priv->eeprom_customer_id) {
 	case EEPROM_CID_DEFAULT:
 		priv->customer_id = RT_CID_DEFAULT;
@@ -460,9 +457,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 	case EEPROM_CID_Pronet:
 		priv->customer_id = RT_CID_PRONET;
 		break;
-	case EEPROM_CID_DLINK:
-		priv->customer_id = RT_CID_DLINK;
-		break;
 
 	case EEPROM_CID_WHQL:
 		break;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 99640c4779f7..706d024bcfd1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -37,7 +37,6 @@ enum baseband_config {
 #define EEPROM_CID_NetCore				0x5
 #define EEPROM_CID_Nettronix			0x6
 #define EEPROM_CID_Pronet				0x7
-#define EEPROM_CID_DLINK				0x8
 #define EEPROM_CID_WHQL					0xFE
 enum _RTL8192PCI_HW {
 	MAC0			= 0x000,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 1e99eb833405..91d634f5d3e7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -134,7 +134,6 @@ enum rt_customer_id {
 	RT_CID_TOSHIBA	  = 9,
 	RT_CID_819X_NETCORE     = 10,
 	RT_CID_Nettronix	= 11,
-	RT_CID_DLINK	    = 12,
 	RT_CID_PRONET	   = 13,
 };
 
-- 
2.40.0

