Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6240D66A904
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 04:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjANDqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 22:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjANDqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 22:46:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27482719
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 19:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=EkNPuTmE0FlVUcmLXPqWTEEOqqQM0wB5qyAYLxd8E+8=; b=lEE9ZqnKSPAHmtX3SF2ARxmdUF
        73LUNVL01txL/T4zhkW2Rpa/4Lsm+Rna4jDrg+oddBKf2cs+WXdF/qJPYHPj68ZCrlEi+uvEfF11L
        c5my4x1Ye4kJvZQnF0QMVvBsvwDPiHFcR1JMmMq02gyp5QEc8FRzcIOX8SvWvgJCoNCEjKkFzbgcf
        haPA+UYPVistPFvlgFxkem38nmONlRoSZX0SpvQNB+QByIKnoKrnM9G7+44AFAWVQpbffUzxfMRNS
        q1DfqYd9I8AKAofkFWfsXWbDAJyKbtMkb5dmkSFyQBLPzjcw6z6vktYkgt8jIMJdS6RTcyeOftgTV
        eAFxSrsA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGXVH-005A7T-8g; Sat, 14 Jan 2023 03:46:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] pcmcia: synclink_cs: remove kernel-doc notation
Date:   Fri, 13 Jan 2023 19:46:46 -0800
Message-Id: <20230114034646.1535-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all kernel-doc "/**" markers; just use "/*" comments since
these are not in kernel-doc format.
This eliminates 11 kernel-doc warnings:

drivers/char/pcmcia/synclink_cs.c:487: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * line discipline callback wrappers
drivers/char/pcmcia/synclink_cs.c:3861: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
drivers/char/pcmcia/synclink_cs.c:3914: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * called by generic HDLC layer to send frame
drivers/char/pcmcia/synclink_cs.c:3959: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * called by network layer when interface enabled
drivers/char/pcmcia/synclink_cs.c:4022: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * called by network layer when interface is disabled
drivers/char/pcmcia/synclink_cs.c:4053: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * called by network layer to process IOCTL call to network device
drivers/char/pcmcia/synclink_cs.c:4156: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * called by network layer when transmit timeout is detected
drivers/char/pcmcia/synclink_cs.c:4179: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * called by device driver when transmit completes
drivers/char/pcmcia/synclink_cs.c:4191: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * called by device driver when frame received
drivers/char/pcmcia/synclink_cs.c:4231: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * called by device driver when adding device instance
drivers/char/pcmcia/synclink_cs.c:4279: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * called by device driver when removing device instance


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/pcmcia/synclink_cs.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff -- a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -483,7 +483,7 @@ static void* mgslpc_get_text_ptr(void)
 	return mgslpc_get_text_ptr;
 }
 
-/**
+/*
  * line discipline callback wrappers
  *
  * The wrappers maintain line discipline references
@@ -3857,7 +3857,7 @@ static void tx_timeout(struct timer_list
 
 #if SYNCLINK_GENERIC_HDLC
 
-/**
+/*
  * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
  * set encoding and frame check sequence (FCS) options
  *
@@ -3910,7 +3910,7 @@ static int hdlcdev_attach(struct net_dev
 	return 0;
 }
 
-/**
+/*
  * called by generic HDLC layer to send frame
  *
  * skb  socket buffer containing HDLC frame
@@ -3955,7 +3955,7 @@ static netdev_tx_t hdlcdev_xmit(struct s
 	return NETDEV_TX_OK;
 }
 
-/**
+/*
  * called by network layer when interface enabled
  * claim resources and initialize hardware
  *
@@ -4018,7 +4018,7 @@ static int hdlcdev_open(struct net_devic
 	return 0;
 }
 
-/**
+/*
  * called by network layer when interface is disabled
  * shutdown hardware and release resources
  *
@@ -4049,7 +4049,7 @@ static int hdlcdev_close(struct net_devi
 	return 0;
 }
 
-/**
+/*
  * called by network layer to process IOCTL call to network device
  *
  * dev  pointer to network device structure
@@ -4152,7 +4152,7 @@ static int hdlcdev_wan_ioctl(struct net_
 	}
 }
 
-/**
+/*
  * called by network layer when transmit timeout is detected
  *
  * dev  pointer to network device structure
@@ -4175,7 +4175,7 @@ static void hdlcdev_tx_timeout(struct ne
 	netif_wake_queue(dev);
 }
 
-/**
+/*
  * called by device driver when transmit completes
  * reenable network layer transmit if stopped
  *
@@ -4187,7 +4187,7 @@ static void hdlcdev_tx_done(MGSLPC_INFO
 		netif_wake_queue(info->netdev);
 }
 
-/**
+/*
  * called by device driver when frame received
  * pass frame to network layer
  *
@@ -4227,7 +4227,7 @@ static const struct net_device_ops hdlcd
 	.ndo_tx_timeout = hdlcdev_tx_timeout,
 };
 
-/**
+/*
  * called by device driver when adding device instance
  * do generic HDLC initialization
  *
@@ -4275,7 +4275,7 @@ static int hdlcdev_init(MGSLPC_INFO *inf
 	return 0;
 }
 
-/**
+/*
  * called by device driver when removing device instance
  * do generic HDLC cleanup
  *
