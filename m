Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A2B67A55C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjAXWFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjAXWFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:05:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F4D5140D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:04:45 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so39169wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDxe4oIJJSUOqPRwp3G0IGOgJo50hIDpNvcK0HbcW+I=;
        b=WBkvXYXkvoKDXytnJfUU8oWA+parU/KCWf/I5sg/p3eClZPsxIvW7DeUIiwOvH4Fj3
         YlCE0XCIY1laBfVZPEPVSalqFcfhOSB+YDt14gYlwJ0M4e8zOjXdpdEhi6w9yJDn+CPo
         Er42ROETd++Gt9iprGqRzUYfy6e1IX+kVPp98lJz8C8iRn/bn7k7ZGIN1M/1hExJitRQ
         G9RhNts8dN939D3TP93LgjGPuZ0DTwjXh0CyW0KRsn2dNQK0pcovmQNqZ651WyL3X/OF
         /84Kv89aQwLEfWXz5zqHeVFjwEdPHnlyyTUkibhbbrLuSPPG5GOCx2Wnejt9PySD3ZLk
         yuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDxe4oIJJSUOqPRwp3G0IGOgJo50hIDpNvcK0HbcW+I=;
        b=n0jM+M1+gadKlndfPa8aARkMjlDoLlwvWOQdC/7GUGwoo/K7/f43ocpzNdk09mC7/D
         AgxVp4taZg5mUAGLRrYWWgvg2FtavCGNygxc0sK7sqOefZ1IqqQBRLTzim5Iw8zYz888
         8qEyP5byBTArcWezo5XCZ8TrJEx3uIFWDHYvWnGq5R1hHQDIEdfzN8R6s6nReDdle/hW
         mUR5nGImqQsifD1UfkJ+RGqRQIRig8QLW0SvBcFOF793rp6A1P04rSTL/MkBY4bY408G
         NZ2KmwPX/e8W4cUMfr5JKDRksXbls6RwkzwQ5LEqKdZCYXzXge3sV6EVrZ1dk5aQcH2J
         WAoA==
X-Gm-Message-State: AFqh2kp4m6oxeqVhQsczrR8EtfRhQ7IB/nE0WPiuqknZxuw6kkEl+HhT
        RLGnjIed2mEOnhi9I4XZaUGnUHhPots=
X-Google-Smtp-Source: AMrXdXvbJ+ZGoez6kgmrT3njEyJRbIcpsgf36SFSsjNMJoZqRUMrig2dz8kXsww2MkR8pm4anfOVlg==
X-Received: by 2002:a05:600c:1695:b0:3da:f452:a975 with SMTP id k21-20020a05600c169500b003daf452a975mr6480278wmn.1.1674597873237;
        Tue, 24 Jan 2023 14:04:33 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id j8-20020adff008000000b00297dcfdc90fsm2825015wro.24.2023.01.24.14.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:04:32 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:04:30 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] staging: rtl8192e: Remove unused variables txbeac..,
 txman.. and txcmdp..
Message-ID: <e18b8ce4a253f9ed24d30296a924ba13d13997bc.1674596722.git.philipp.g.hortmann@gmail.com>
References: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

txbeaconerr, txmanageokint and txcmdpktokint are initialized and increased
but never read. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 8 +-------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 3 ---
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 4cc90425fa4c..2c5edda74e73 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -2139,11 +2139,7 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		goto done;
 	}
 
-	if (inta & IMR_TBDER)
-		priv->stats.txbeaconerr++;
-
 	if (inta  & IMR_MGNTDOK) {
-		priv->stats.txmanageokint++;
 		_rtl92e_tx_isr(dev, MGNT_QUEUE);
 		spin_unlock_irqrestore(&priv->irq_th_lock, flags);
 		if (priv->rtllib->ack_tx_to_ieee) {
@@ -2155,10 +2151,8 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		spin_lock_irqsave(&priv->irq_th_lock, flags);
 	}
 
-	if (inta & IMR_COMDOK) {
-		priv->stats.txcmdpktokint++;
+	if (inta & IMR_COMDOK)
 		_rtl92e_tx_isr(dev, TXCMD_QUEUE);
-	}
 
 	if (inta & IMR_HIGHDOK)
 		_rtl92e_tx_isr(dev, HIGH_QUEUE);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index f8b2201ea288..c6a4ac6ce959 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -184,9 +184,6 @@ enum reset_type {
 
 struct rt_stats {
 	unsigned long received_rate_histogram[4][32];
-	unsigned long txbeaconerr;
-	unsigned long txmanageokint;
-	unsigned long txcmdpktokint;
 	unsigned long txbytesmulticast;
 	unsigned long txbytesbroadcast;
 	unsigned long txbytesunicast;
-- 
2.39.1

