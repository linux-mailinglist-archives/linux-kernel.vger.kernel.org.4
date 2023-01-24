Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6AE67A54F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjAXWD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjAXWDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:03:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539A810261
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:03:22 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t18so2457155wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bF+Lp+JDPbwdrmjIfQ0g/QFY3xJvOU79Nk3DY5MrQzU=;
        b=OF3bvE9BGHU4pLMINeGZ7j1sGTNaHyVnwnjqw71YdNbdZFDA9COuaWvpF0baR6bZWH
         MSinkl6soRMGeltRq/QiUkB1p6CgoVjP/eYhZP+JxR6xjX5in9XcNHDjM8ktAw7dkP3S
         sYNJfZ6dYTsAGWh745r4IirbHC/q3NzLRqESUzhkGyw7HGr0p5Tk1heHE2h8fSv/+J9B
         eD5DERpuYKTkj772BhDdt2TOQU0u4dTFkmg8LXMO1DN5P+yVJ1mQdkGoviAvFkZta9Eh
         +WLzkBQilCZDAD1CgjsME/FU1+Lq6o4VYa+Rzqp0B/tIcaa5zsVgjzHDY/HORQB+LpVv
         EquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF+Lp+JDPbwdrmjIfQ0g/QFY3xJvOU79Nk3DY5MrQzU=;
        b=7Db1fq8pUv/ez5+E3DX3bi3aeJHkV74TaGJ6KLk3tM8YaFERZ3srKijpEDHtdeXtii
         soE/UvzYsOJJQaKclwvi3T8UODEVhVDAlj4kdwpBEshE0WHS2mffT4r9HoHQ6MaKq+bB
         Fa5zPq8jJPOjlO5lEXw/Tc27MgE8OHJQqLA+wm9t+IthMc6M/oRU06uGdeRB2ClzrUBu
         P+BHOC4e/CO9/sCtQ9HzDKPmC1oVXjiB69fG2Rzn9B0ft+aBuo9NH8PrZcGcKTrpjXSt
         JiuUBWz83r0PP9fIBvRkRmIMxx+GIabueUvZiEXICi5pXMbPYbvUaXqzQbFu7jiCGA54
         8gEw==
X-Gm-Message-State: AFqh2kq3gD/hKwq6cmCXthmvIiTdzqX/6gy192WnqKB9EZhENHmMxxD9
        QqPUoNu9o20ji+fjj7Cbzcw=
X-Google-Smtp-Source: AMrXdXvyQMfkCITZC9ll6B+bJaFmOem9Tg1mquONTYUiukQ4s/Dzx/epQ/Robh8oVbamWhlZNmHRfA==
X-Received: by 2002:adf:a446:0:b0:2be:55ed:c065 with SMTP id e6-20020adfa446000000b002be55edc065mr2848791wra.7.1674597800811;
        Tue, 24 Jan 2023 14:03:20 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d4c4f000000b002bfad438811sm2167871wrt.74.2023.01.24.14.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:03:20 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:03:18 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] staging: rtl8192e: Remove unused variables
 rxdatacrcerr and rxmgmtcrcerr
Message-ID: <32c9183fa2f4edd24ae6f93d56b808eb1821832b.1674596722.git.philipp.g.hortmann@gmail.com>
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

