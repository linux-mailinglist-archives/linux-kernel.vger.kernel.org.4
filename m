Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1AE634A39
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiKVWqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiKVWqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:46:17 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA15C902B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:46:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so26945396wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kX4/EANOvk92+tIojhRVqHRQq3FkLftzIvzrby6dVc=;
        b=O+zXr+8OCFBH3GxbvFTezKFVJ1vV6pp7rEsO9XTqBKuUBAcPD9j+YRjL0x8q2kLrwA
         4HW809wY/kZRcV0JxQYe4OCHg4xztFfFuVCJtvIN7fSrFs96wovcZj5fzvx/GjQ2ijgY
         yz25SMG9Rr8C7MzNvPAQpvG9r5xDBJrcXt0+AGjtgZzDbBVqtsirDHBNuZpa2fXSDrJb
         SEfDmDajMlZgkTumExqpDrCCtPu69E50ouWOy734MnDQ+u6D2Usvm6NAetu+mSDqmIH1
         VZkL/5Qjhr6wb0gHDxkz4ivqIT9iGO8uRzGHjiKYiDYaZXPqh2d7IGCl52OCEOt/tFQ6
         NAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kX4/EANOvk92+tIojhRVqHRQq3FkLftzIvzrby6dVc=;
        b=sJqOis0QBDihA2BAN+yxEeomdwmXkRpqTn7jHr1K0dbbcotMsjiXuHo908PRJvZkc8
         eG6TlR12bHlA5q13Xpyqd+JyA5KWGF5T8CWacfKxomUXLgMh2AZaa3wRqAvC3PWd8qrc
         Q2klLpjyUitX0C75GtonbvC/XEMHlT9NisfvjZ/ZgLLxbgxMto6N02AXyaH30eHpDnVh
         GjR1F91hbNDq2c/oNvHvsLBVEjcuB05aA7tfo0ePHGUn3WSfktEmQyIhyMoaHXYfNt4C
         2p/JaXaGARnK7FmcisuQTqqS7zOPXyVsj0je7hizsRvwsioHR2qj9cq1wP2ARKf50/Or
         UL/w==
X-Gm-Message-State: ANoB5pkhh7CzojV/FbB9XVYmhK27F99qHV6IJpPlcHU11p25gP5e7wBZ
        /OjRSsbnNQX3Jlfj4G+GkYE=
X-Google-Smtp-Source: AA0mqf6A/nblVO+geoFYaq9gruFl8YL+W6oIjovbTzlwhfG4ceSGhlTRUikeMKLrkKDwaG2NS3RzTw==
X-Received: by 2002:a5d:4533:0:b0:241:d13a:1d52 with SMTP id j19-20020a5d4533000000b00241d13a1d52mr8711702wra.270.1669157170445;
        Tue, 22 Nov 2022 14:46:10 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b003cfd0bd8c0asm133961wms.30.2022.11.22.14.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:46:10 -0800 (PST)
Date:   Tue, 22 Nov 2022 23:46:08 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: rtl8192e: Remove unused variable skb_aggQ
Message-ID: <3197be3cb412eea1c662a5bec1b1afda2cee675d.1669156825.git.philipp.g.hortmann@gmail.com>
References: <cover.1669156825.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1669156825.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb_aggQ is initialized, never used and purged. Remove resulting dead
code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 2 --
 drivers/staging/rtl8192e/rtllib.h              | 1 -
 3 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 80eba5d5ab37..f02e67f68e23 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1946,8 +1946,6 @@ void rtl92e_stop_adapter(struct net_device *dev, bool reset)
 
 	for (i = 0; i < MAX_QUEUE_SIZE; i++)
 		skb_queue_purge(&priv->rtllib->skb_waitQ[i]);
-	for (i = 0; i < MAX_QUEUE_SIZE; i++)
-		skb_queue_purge(&priv->rtllib->skb_aggQ[i]);
 
 	skb_queue_purge(&priv->skb_queue);
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index a8cbeb9545da..369a59a753fe 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -903,8 +903,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 
 	for (i = 0; i < MAX_QUEUE_SIZE; i++)
 		skb_queue_head_init(&priv->rtllib->skb_waitQ[i]);
-	for (i = 0; i < MAX_QUEUE_SIZE; i++)
-		skb_queue_head_init(&priv->rtllib->skb_aggQ[i]);
 }
 
 static void _rtl92e_init_priv_lock(struct r8192_priv *priv)
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7119c9c5e1fe..1152fbf43383 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1624,7 +1624,6 @@ struct rtllib_device {
 	int mgmt_queue_tail;
 	u8 AsocRetryCount;
 	struct sk_buff_head skb_waitQ[MAX_QUEUE_SIZE];
-	struct sk_buff_head  skb_aggQ[MAX_QUEUE_SIZE];
 
 	bool	bdynamic_txpower_enable;
 
-- 
2.37.3

