Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8008367FFB3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbjA2O7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjA2O72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:59:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F171E9C8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:59:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso386376wmp.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/gZ+8LIHmPXx4BBaPzt1UXYgMFGNlGYsRfi+PpxjVc=;
        b=HSnJAIfHtBRC2LW9lr7J0a38laFODYBoE+evGrrIE2YsLLwsO7iUSZA59yHYf444U4
         tmk6YyV+KBRx9IvpPPS05+RrIuF6WKvZhawwnkd5+OTww9eI8SAoYXy00PqO8QFfnZNG
         zHSkS8d0yvdgbQnAVGeVhP0M5wC3uCDkQP8CqSoiAvjRwcF/B0YmAakbaSaeCSS+6rmM
         B8oqZJnvvG8YioiOXp5hOQ+A01S/Vc4KWuqqoG9JsbP3U4pBBIWqUocwQj/btsKhF9Fv
         sNo5U9f9TLlWs3UZcS7VY4nrjbkIvilPcK1IlbGbvZCh0f3WCCfLZyVUbblsY5bhRJoK
         kr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/gZ+8LIHmPXx4BBaPzt1UXYgMFGNlGYsRfi+PpxjVc=;
        b=GV0Yw9YooihMZH/Db4BmcOV2tI9wh8GprG42GBCooa7yQvYjZ5XTjHbEjiMP/G/kqq
         v7oVt1yKB4SX16SNa4y014UdNyd3AC1lyPvIopgfCMi2bG6aJ/jQu4tm6WGNws+ejSZl
         qcuGhOHWdyLRPAUxmAlfYzpyxyct4ww9metCvHqOBF42/0t6mvPNNpQEoDLEswberNfi
         veGq0tWWFRJvzj7drZMo1E8dBhOeNUOP6Rvlf5mIUBbrINFrRhcigo7KC5jwe1n0MZFa
         7btsXvKz92LFXnrFSaJ/R+D4z0EfO88g/P5xQQhbd3I15OTgVQRHNCpIcURF+XvGedDg
         bo5A==
X-Gm-Message-State: AO0yUKWBkvlxwWG7GZ1O8xWhaoChixy9Ib1zrkQNBzvGMxU+Uoq0iHGU
        TOo4OhfuabCExegIJfFedFI=
X-Google-Smtp-Source: AK7set8U5Gn4k57RV4TvYBlDywpR7JcRw1jMdBt+bxBpAVtSOfX9W4ITgg1yjd+I1zsX6L4XD0nCyQ==
X-Received: by 2002:a05:600c:1f18:b0:3dc:53fc:c8b3 with SMTP id bd24-20020a05600c1f1800b003dc53fcc8b3mr558789wmb.3.1675004339836;
        Sun, 29 Jan 2023 06:58:59 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id n17-20020a1c7211000000b003dc3f07c876sm6974466wmc.46.2023.01.29.06.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:58:59 -0800 (PST)
Date:   Sun, 29 Jan 2023 15:58:57 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] staging: rtl8192e: Rename _RTL8192Pci_HW,
 MXDMA2_NoLimit and TPPoll
Message-ID: <1911a2bf4dfe6633e778d86d3aad1553cb629eb3.1675003608.git.philipp.g.hortmann@gmail.com>
References: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename enum _RTL8192Pci_HW to _RTL8192PCI_HW and variable MXDMA2_NoLimit
to MXDMA2_NO_LIMIT and TPPoll to TP_POLL to avoid CamelCase which is not
accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c    | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h     | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c      | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
index 8bf06f736ffb..374f61e931f5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
@@ -76,7 +76,7 @@ bool rtl92e_send_cmd_pkt(struct net_device *dev, u32 type, const void *data,
 
 	} while (frag_offset < len);
 
-	rtl92e_writeb(dev, TPPoll, TPPoll_CQ);
+	rtl92e_writeb(dev, TP_POLL, TPPoll_CQ);
 Failed:
 	return rt_status;
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 62f179f2f174..37d304a0f4c1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -629,8 +629,8 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	_rtl92e_hwconfig(dev);
 	rtl92e_writeb(dev, CMDR, CR_RE | CR_TE);
 
-	rtl92e_writeb(dev, PCIF, ((MXDMA2_NoLimit<<MXDMA2_RX_SHIFT) |
-				  (MXDMA2_NoLimit<<MXDMA2_TX_SHIFT)));
+	rtl92e_writeb(dev, PCIF, ((MXDMA2_NO_LIMIT << MXDMA2_RX_SHIFT) |
+				  (MXDMA2_NO_LIMIT << MXDMA2_TX_SHIFT)));
 	rtl92e_writel(dev, MAC0, ((u32 *)dev->dev_addr)[0]);
 	rtl92e_writew(dev, MAC4, ((u16 *)(dev->dev_addr + 4))[0]);
 	rtl92e_writel(dev, RCR, priv->receive_config);
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 3782db125300..1cb723f71f43 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -39,11 +39,11 @@ enum baseband_config {
 #define EEPROM_CID_Pronet				0x7
 #define EEPROM_CID_DLINK				0x8
 #define EEPROM_CID_WHQL					0xFE
-enum _RTL8192Pci_HW {
+enum _RTL8192PCI_HW {
 	MAC0			= 0x000,
 	MAC4			= 0x004,
 	PCIF			= 0x009,
-#define MXDMA2_NoLimit		0x7
+#define MXDMA2_NO_LIMIT		0x7
 
 #define	MXDMA2_RX_SHIFT		4
 #define	MXDMA2_TX_SHIFT		0
@@ -128,7 +128,7 @@ enum _RTL8192Pci_HW {
 #define	IMR_VODOK			BIT1
 #define	IMR_ROK				BIT0
 	ISR			= 0x0f8,
-	TPPoll			= 0x0fd,
+	TP_POLL			= 0x0fd,
 #define TPPoll_CQ		BIT5
 	PSR			= 0x0ff,
 	CPU_GEN			= 0x100,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 26cf4b5165f5..104b16cfa979 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1646,7 +1646,7 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
 	spin_unlock_irqrestore(&priv->irq_th_lock, flags);
 	netif_trans_update(dev);
 
-	rtl92e_writew(dev, TPPoll, 0x01 << tcb_desc->queue_index);
+	rtl92e_writew(dev, TP_POLL, 0x01 << tcb_desc->queue_index);
 	return 0;
 }
 
-- 
2.39.1

