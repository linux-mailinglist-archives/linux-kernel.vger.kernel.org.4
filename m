Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476475B5061
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 19:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIKRuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 13:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiIKRtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 13:49:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5592D657A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 10:49:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y17so10207137ejo.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rCDfTaihwWGPyLt8tZ3jm0WZmNc1RGlvQMSSjc4hgUo=;
        b=qpJlzQn6K+/8LfhYgAc4/vRKGXyUtwqdpuziE0uvd6P06lMbq2dhSOVXUfV6ISTdsH
         JG8/qvuXbd7aPtmx7gOVAjEQ2/HI5Mg498WZPw8mHldC5ZropZ22fSYXCpjI+18PRVUm
         YsSfmGZCfotGhLh0BDRBUFSvzNgDOiJd0Cc1UnNb2bE4tzU1j3+FEL2AesExKxHZ/3+4
         cBCqkv1kaBdXicBmBP96gKmWoZfWa0y7doZv44qrmeUEbRqXEZ3bI9kNe2Txy5dFlCHu
         UsB8j3yDVOFsa9lK2HiCbvEFC/Vq1CfhfUj3VwyMNGmD5CABFOa1yU2OO/Ce55EaAJeg
         oezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rCDfTaihwWGPyLt8tZ3jm0WZmNc1RGlvQMSSjc4hgUo=;
        b=3lm+b6IspDokAN09HR8YI/GrVq2Bv75KIOQzVlBdYjmVyFzfpTPG8criXjNTCOY5Gb
         1khlKVUCW8IK7OUDghoE+gVzKD4KTL7B+Dhm7yQNBMBPIpE9HFcPK3XVbggHrtRRNp33
         eOLqD6q9YMvsn3bRO8/d6MqY5jSQo4BT7OrxFnf7HB3sXwpfVIl3vH4xrNsWQL7F0+aQ
         xxQJ8kkI3OggLLdZMqf4ei2ASoMS7d5TrhF7e2BU3tu+AHa008bmm34P+wObgoWC3Q/j
         sy6oNzbDu2K9FKadrsrRqnIPi3vDJEJG539dLntvw+6jz1sqrBtpVnqLhJPn+vb2ZfEF
         Waog==
X-Gm-Message-State: ACgBeo1GfG5pDWqKZxDhR996nsIuwJcKnkD5LzMF09eeL5h+7P3n1rxg
        6uAQMjkTr6KsRPF2C2SCgBo=
X-Google-Smtp-Source: AA6agR7i6L7hxgtaVU109E67anZrpImjNcUWC5gOwJgEmnCbvWoyi4vasc8TRw31FQ3A1d47VgUwyg==
X-Received: by 2002:a17:907:7290:b0:77a:27ef:18d3 with SMTP id dt16-20020a170907729000b0077a27ef18d3mr7808927ejc.42.1662918583675;
        Sun, 11 Sep 2022 10:49:43 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id u5-20020a1709063b8500b007336c3f05bdsm3265393ejf.178.2022.09.11.10.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 10:49:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: remove recv_osdep.h
Date:   Sun, 11 Sep 2022 19:49:33 +0200
Message-Id: <20220911174933.3784-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911174933.3784-1-straube.linux@gmail.com>
References: <20220911174933.3784-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions _rtw_init_recv_priv(), _rtw_free_recv_priv() and
rtw_recv_entry() are defined in rtw_recv.c. Move their prototypes from
recv_osdep.h to rtw_recv.h.

Move the last two remaining prototypes netdev_open() and netdev_close()
from recv_osdep.h to osdep_intf.h. That is a more appropriate place and
we can remove recv_osdep.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c      |  1 -
 drivers/staging/r8188eu/core/rtw_cmd.c         |  1 -
 drivers/staging/r8188eu/core/rtw_mlme.c        |  1 -
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    |  1 -
 drivers/staging/r8188eu/core/rtw_recv.c        |  1 -
 drivers/staging/r8188eu/core/rtw_sta_mgt.c     |  1 -
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c     |  1 -
 drivers/staging/r8188eu/hal/usb_ops_linux.c    |  1 -
 drivers/staging/r8188eu/include/osdep_intf.h   |  3 +++
 drivers/staging/r8188eu/include/recv_osdep.h   | 18 ------------------
 drivers/staging/r8188eu/include/rtw_recv.h     |  3 +++
 drivers/staging/r8188eu/os_dep/os_intfs.c      |  1 -
 drivers/staging/r8188eu/os_dep/osdep_service.c |  1 -
 drivers/staging/r8188eu/os_dep/usb_intf.c      |  1 -
 14 files changed, 6 insertions(+), 29 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/recv_osdep.h

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index bca20fe5c983..4c5f30792a46 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -12,7 +12,6 @@
 #include "../include/drv_types.h"
 #include "../include/rtw_br_ext.h"
 #include "../include/usb_osintf.h"
-#include "../include/recv_osdep.h"
 
 #ifndef csum_ipv6_magic
 #include "../include/net/ip6_checksum.h"
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ca1f2cc52470..8ef4a63cf911 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -5,7 +5,6 @@
 
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
-#include "../include/recv_osdep.h"
 #include "../include/rtw_br_ext.h"
 #include "../include/rtw_mlme_ext.h"
 #include "../include/rtl8188e_dm.h"
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index de722c199cce..5ca03d6cac32 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -5,7 +5,6 @@
 
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
-#include "../include/recv_osdep.h"
 #include "../include/hal_intf.h"
 #include "../include/sta_info.h"
 #include "../include/wifi.h"
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 73e07d489523..07905e2ae8e0 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -9,7 +9,6 @@
 #include "../include/wifi.h"
 #include "../include/rtw_mlme_ext.h"
 #include "../include/wlan_bssdef.h"
-#include "../include/recv_osdep.h"
 #include "../include/rtl8188e_xmit.h"
 #include "../include/rtl8188e_dm.h"
 
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 353c7468367a..7970e6495c7e 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -6,7 +6,6 @@
 #include <linux/ieee80211.h>
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
-#include "../include/recv_osdep.h"
 #include "../include/usb_ops.h"
 #include "../include/wifi.h"
 #include "../include/rtl8188e_recv.h"
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index b5dd28a10e5b..98eeb16cab6c 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -5,7 +5,6 @@
 
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
-#include "../include/recv_osdep.h"
 #include "../include/sta_info.h"
 
 static void _rtw_init_stainfo(struct sta_info *psta)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index a7ac9f62459f..8310d7f53982 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -5,7 +5,6 @@
 
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
-#include "../include/recv_osdep.h"
 #include "../include/rtw_ioctl_set.h"
 
 #include "../include/rtl8188e_hal.h"
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index f29bfa948ce7..7c72f5e04d9b 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -5,7 +5,6 @@
 #include "../include/drv_types.h"
 #include "../include/osdep_intf.h"
 #include "../include/usb_ops.h"
-#include "../include/recv_osdep.h"
 #include "../include/rtl8188e_hal.h"
 
 static int usb_read(struct intf_hdl *intf, u16 value, void *data, u8 size)
diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
index 0d7009269aab..36511c469546 100644
--- a/drivers/staging/r8188eu/include/osdep_intf.h
+++ b/drivers/staging/r8188eu/include/osdep_intf.h
@@ -39,6 +39,9 @@ The protection mechanism is through the pending queue.
 	u8 bio_timer_cancel;
 };
 
+int netdev_open(struct net_device *pnetdev);
+int netdev_close(struct net_device *pnetdev);
+
 u8 rtw_init_drv_sw(struct adapter *padapter);
 u8 rtw_free_drv_sw(struct adapter *padapter);
 u8 rtw_reset_drv_sw(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
deleted file mode 100644
index 437880629a25..000000000000
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __RECV_OSDEP_H_
-#define __RECV_OSDEP_H_
-
-#include "osdep_service.h"
-#include "drv_types.h"
-
-int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
-void _rtw_free_recv_priv(struct recv_priv *precvpriv);
-
-s32  rtw_recv_entry(struct recv_frame *precv_frame);
-
-int netdev_open(struct net_device *pnetdev);
-int netdev_close(struct net_device *pnetdev);
-
-#endif /*  */
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 66d240a7123d..7768b0c5988c 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -243,6 +243,9 @@ struct recv_frame {
 	struct recv_reorder_ctrl *preorder_ctrl;
 };
 
+int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
+void _rtw_free_recv_priv(struct recv_priv *precvpriv);
+s32 rtw_recv_entry(struct recv_frame *precv_frame);
 struct recv_frame *_rtw_alloc_recvframe(struct __queue *pfree_recv_queue);
 struct recv_frame *rtw_alloc_recvframe(struct __queue *pfree_recv_queue);
 int  rtw_free_recvframe(struct recv_frame *precvframe,
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 55bfca779b7d..6a45315d01a2 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -5,7 +5,6 @@
 
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
-#include "../include/recv_osdep.h"
 #include "../include/hal_intf.h"
 #include "../include/rtw_ioctl.h"
 #include "../include/usb_osintf.h"
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 875a41650896..88271f956b52 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -5,7 +5,6 @@
 
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
-#include "../include/recv_osdep.h"
 #include "../include/rtw_ioctl_set.h"
 
 /*
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index e24e06725c29..5fbfbcd95de2 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -4,7 +4,6 @@
 #include <linux/usb.h>
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
-#include "../include/recv_osdep.h"
 #include "../include/hal_intf.h"
 #include "../include/osdep_intf.h"
 #include "../include/usb_ops.h"
-- 
2.37.3

