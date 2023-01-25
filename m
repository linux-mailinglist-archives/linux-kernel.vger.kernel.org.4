Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E8167BC2F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbjAYUIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbjAYUIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:08:50 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54BA5D11F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:08:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so2134059wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bF+Lp+JDPbwdrmjIfQ0g/QFY3xJvOU79Nk3DY5MrQzU=;
        b=lZjNXxnG0NwYLfZGiRVHlHOqlnjaMPZ1JSID3VMPnHtvUjKMLeD8kgH7GkoAlRPX/d
         lZsrQftznCgl+6B9zFnjD0+R9mTZi5VWhbUqy+4Dn9yPmXaY6jyYgA05zUKIL4QREQK5
         860WaQ3CHo79PSRDa601F2pA1CnldWLfwjFHehb6YLT3RlbdoLrWrgFfXYGOaht7gepv
         INCRHLR1CmWe+DN+syp7s+t92FtOLxWMVgWyvQN3aeNBwzg5pTrvlQhgsWUr4Mnq5ALl
         Pjus4IqrryktYkJ6L4HFew8xH3VG4y/sS7B0imQPMEb4osTROToIXx1df3catPY43Fdy
         Wg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF+Lp+JDPbwdrmjIfQ0g/QFY3xJvOU79Nk3DY5MrQzU=;
        b=0ZCU4ps7CDjyUNain9SU2rew4DFE91VNZRxynAxv8LdtU23tDZKTdNl6b6zKk4gUNy
         StzqNr8QHamfWRlv/idz7jV98o8jl9DOSLZbSXRWOfTZOziyIZAGtSUTEziyRBRWIpT7
         yr5mhKozdO0FiZfsbWbHiQl6W6slbLJn1w3QHdaCXQMoA3FmI0bqIqQB8KFTp8biPWjQ
         wOWS6iT1YZEHVrGNpWTnB1y06sc4585ehBPfrFyl9fECxPsFW25zu0NYsUoa2VUDVTv/
         wDxaQfEyGMgLNLIta64IVwqt45JPCdjwjcXEy31Y0tMMXBzWSqICiVt0FkWHXDYPtY/z
         6Kig==
X-Gm-Message-State: AFqh2ko0tLlXmTbJ1OsquExs0W6O2GAz9rq1n5a+0YKqfYXKycPIq+1L
        O1x9qRuCrd7tj2zpxE4XBWk=
X-Google-Smtp-Source: AMrXdXuPLC9TNzoxh2qQMgwhJ2ZPBby8KQ2A7s3S3pJ34Cz3y7HlrsLZZ6qnvRp141wNiT4CSj68aQ==
X-Received: by 2002:a05:600c:3ba8:b0:3d9:8635:a901 with SMTP id n40-20020a05600c3ba800b003d98635a901mr8573813wms.3.1674677314209;
        Wed, 25 Jan 2023 12:08:34 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id bi5-20020a05600c3d8500b003db0bb81b6asm2751098wmb.1.2023.01.25.12.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:08:33 -0800 (PST)
Date:   Wed, 25 Jan 2023 21:08:31 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] staging: rtl8192e: Remove unused variables
 rxdatacrcerr and rxmgmtcrcerr
Message-ID: <32c9183fa2f4edd24ae6f93d56b808eb1821832b.1674675808.git.philipp.g.hortmann@gmail.com>
References: <cover.1674675808.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674675808.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rxdatacrcerr and rxmgmtcrcerr are initialized and increased but never
read. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 7 -------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 605146c840c7..e0d0f4faeca7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1926,13 +1926,6 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 				priv->rtllib->LedControlHandler(dev,
 							LED_CTL_RX);
 
-		if (stats.bCRC) {
-			if (type != RTLLIB_FTYPE_MGMT)
-				priv->stats.rxdatacrcerr++;
-			else
-				priv->stats.rxmgmtcrcerr++;
-		}
-
 		skb_len = skb->len;
 
 		if (!rtllib_rx(priv->rtllib, skb, &stats)) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 82cbc7f5536a..f91a6f7a4e0a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -183,8 +183,6 @@ enum reset_type {
 };
 
 struct rt_stats {
-	unsigned long rxdatacrcerr;
-	unsigned long rxmgmtcrcerr;
 	unsigned long rxcrcerrmin;
 	unsigned long rxcrcerrmid;
 	unsigned long rxcrcerrmax;
-- 
2.39.1

