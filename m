Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5270069C2A7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjBSVQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjBSVQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:16:39 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE95D19F31
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:16 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id dk16so4408818edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676841374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVhtpko5aJjNQpaFyeGt6sBZfnruBHfevG3pGWCXzvQ=;
        b=E0+1lh9fgR63sYkEUG12n82xztyEF2mIUB2VCsYRfqSmQ9rwFhoLCgG2RuIRO/aKJu
         UomG4HMkNGZ7U9b+lItckEorsmT/JTswquBS7dYfyaBSDi7P4CO1zhP2x2jpaup9P8/N
         y8VXYF2gdn51GjPBhp4+ZHaSHFtS5X/5mJKktJzmnTtupOBg4+ihV+cqRtpoXQJYKj6F
         h+ZU6igApAyTbpgA9P2aSjV/MOdf+LyUASWpJbrLS5flN8kf2HggnIn/jcDDCTg1fSb0
         vKagVFl9Vy9KnIPr3qxfktxk7dAQEuC+FNBMFZJT9mJIJmHowFPoz7ItmKAzNX0hblQt
         +5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676841374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVhtpko5aJjNQpaFyeGt6sBZfnruBHfevG3pGWCXzvQ=;
        b=Xna74gSTXKsUxX4QpqW2xHTZHTaYHer305ugdrgBBnXY5K3vSC6N9++6Itentd7EIc
         ZQh5og17YFPwbZtT4iNGYqtqs3gZZP5L+gxa5AmjwxEJ/3ovUPK6qqwYpFtxu7b7V+F/
         YSAQ3wfUf0tLG3rDGYA7MA0NixUiezbIRdByy9ZtzIL7Jp93IvpzBm2g7ZN41g41cctv
         pYtTBkM0Dg48JUmF0+6zDJiIB0caausEE9kltsw76wCM2h++ZROP870s05Nzu9AM1/SD
         zwNSlk/fio+4v85TPKOLL/O25RtBqGgqInGAy0fSYStD0mE0TwsSjQSCAhqk/e2DZgTh
         cYrA==
X-Gm-Message-State: AO0yUKX5qteGzlSPnj+Itrapo7tkpI6KcJqtNwRzwTLLwH4HJI6ErxpQ
        I1BHE0gP9jwYoE+Y8GZdChBJothby+A=
X-Google-Smtp-Source: AK7set9aa4cdjXAUrKqVFERqPYCoYym/qY0qlYADCivYMNENUR7uanjzr60p1biiSsjLvVVe1bToYw==
X-Received: by 2002:a05:6402:34d5:b0:4ac:8e63:300a with SMTP id w21-20020a05640234d500b004ac8e63300amr1360747edc.3.1676841374662;
        Sun, 19 Feb 2023 13:16:14 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id g17-20020aa7c591000000b004acc1374849sm392354edq.82.2023.02.19.13.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:16:14 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:16:12 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] staging: rtl8192e: Remove entry .rx_query_stat.. from
 struct rtl819x_ops
Message-ID: <889c557f6e312645eb40173b7ffa210cabf10110.1676840647.git.philipp.g.hortmann@gmail.com>
References: <cover.1676840647.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676840647.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove entry .rx_query_status_descriptor and replace it with function
name rtl92e_get_rx_stats. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 4 +---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 4 ----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 372bb4810c31..a4796330f86d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -28,7 +28,6 @@ static char *ifname = "wlan%d";
 static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
 	.link_change			= rtl92e_link_change,
-	.rx_query_status_descriptor	= rtl92e_get_rx_stats,
 	.rx_command_packet_handler = NULL,
 	.stop_adapter			= rtl92e_stop_adapter,
 	.update_ratr_table		= rtl92e_update_ratr_table,
@@ -1885,8 +1884,7 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 
 		if (pdesc->OWN)
 			return;
-		if (!priv->ops->rx_query_status_descriptor(dev, &stats,
-		pdesc, skb))
+		if (!rtl92e_get_rx_stats(dev, &stats, pdesc, skb))
 			goto done;
 		new_skb = dev_alloc_skb(priv->rxbuffersize);
 		/* if allocation of new skb failed - drop current packet
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 5af14837df31..d83af5f8ce82 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -207,10 +207,6 @@ struct rtl819x_ops {
 	enum nic_t nic_type;
 	void (*init_before_adapter_start)(struct net_device *dev);
 	void (*link_change)(struct net_device *dev);
-	bool (*rx_query_status_descriptor)(struct net_device *dev,
-					   struct rtllib_rx_stats *stats,
-					   struct rx_desc *pdesc,
-					   struct sk_buff *skb);
 	bool (*rx_command_packet_handler)(struct net_device *dev,
 					  struct sk_buff *skb,
 					  struct rx_desc *pdesc);
-- 
2.39.2

