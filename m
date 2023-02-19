Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0507869C2AA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjBSVRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjBSVQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:16:57 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0F5196B0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ek25so4564907edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gD2rpGXNjlPg34upTQh8s57+lHo2lH56WRqivcs5WEk=;
        b=boERJx4wS/f5Wk73N/ZrWa6GVJSzGagQ8WkeKshregS60glZLVU8KHw+IVMiiIG2Lp
         Hl/Ubca2fSkELXHLdUSsyFdRyOkFTW2+WqkupbxRdfIqC+avxnnSYh6/tsb6fdcr7Upd
         iUpAX5vpO2vrfGyZ5O0soTFojFk7Xzv4IR5fAv/cG2syPk+ZAspCq6G2eIORzDPSaBCk
         1g84Zs2MSXyEDsJDw/oDKsWVEiUeJeL5v7Rd124VFWjJ0VChJR/OJTfGzQwiXDf0/ERk
         yFZYahcSjuINbPPPbJIfc05P5zEQC4J21LR8YBkr1xpKUviJG2FZX/0l38EZ1Rp4fUje
         D5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gD2rpGXNjlPg34upTQh8s57+lHo2lH56WRqivcs5WEk=;
        b=XsHAV8UOBP1ZUrHoBIu0zixc3+NX0Ah0v4BXZnZKTMKpRz/jEODzf2IbiTCZb8ZZwX
         1PqS2wvUmU5/1o8LHqTpyer8dCGf70eP/IzrAlVJ1fBSNhVvTHpPyn9gkclMprty5Tcn
         tkOE1JOq3E5Hc9SwETvJvX5BZfPWsm1BgQ6qsr+YE0AaUZ4PAkHvdtzrZElxRHCHFvTD
         EkrsP9+uWFD0hzGzMI8SkP4U21f+G9uwGN/5fayRS53TDwUquZLdDYGXCjG/DJv9ZFVj
         23l2HGAImKFLVbij+pwVkgwHAeIFX2WXE9XDiW/KeKJuAbHMQ7LxHMlZeJf37DithCj5
         fGDQ==
X-Gm-Message-State: AO0yUKVegPHlvD++AW7oWLMTMwj3XEIkja7LbKmUPWO2h+Ld17uo0h+c
        cdgA/1aJy28M4tOt/VzVsWo=
X-Google-Smtp-Source: AK7set+y6/1t7Li4qphzhVY4MrRXOUqT5fHsV0mX8jB659aG8eOZzHRKZuW8cw2tKA5LiEKDDGvgMA==
X-Received: by 2002:a17:906:19c:b0:88d:5f84:2756 with SMTP id 28-20020a170906019c00b0088d5f842756mr7492894ejb.0.1676841390964;
        Sun, 19 Feb 2023 13:16:30 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id a36-20020a509ea7000000b004a7e9ec2087sm5223332edf.76.2023.02.19.13.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:16:30 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:16:28 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] staging: rtl8192e: Remove entry .update_ratr_t.. from
 struct rtl819x_ops
Message-ID: <b9557fd44fde0261acd867124aae4d318587a497.1676840647.git.philipp.g.hortmann@gmail.com>
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

Remove entry .update_ratr_table and replace it with function name
rtl92e_update_ratr_table. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 0b5b2ae27f9e..1e307789ee93 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -806,7 +806,7 @@ void rtl92e_link_change(struct net_device *dev)
 
 	if (ieee->state == RTLLIB_LINKED) {
 		_rtl92e_net_update(dev);
-		priv->ops->update_ratr_table(dev);
+		rtl92e_update_ratr_table(dev);
 		if ((ieee->pairwise_key_type == KEY_TYPE_WEP40) ||
 		    (ieee->pairwise_key_type == KEY_TYPE_WEP104))
 			rtl92e_enable_hw_security_config(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 566513338089..c7561e486359 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -29,7 +29,6 @@ static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
 	.link_change			= rtl92e_link_change,
 	.rx_command_packet_handler = NULL,
-	.update_ratr_table		= rtl92e_update_ratr_table,
 	.irq_enable			= rtl92e_enable_irq,
 	.irq_disable			= rtl92e_disable_irq,
 	.irq_clear			= rtl92e_clear_irq,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 083bba3dc51b..10ff4f9ec760 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -210,7 +210,6 @@ struct rtl819x_ops {
 	bool (*rx_command_packet_handler)(struct net_device *dev,
 					  struct sk_buff *skb,
 					  struct rx_desc *pdesc);
-	void (*update_ratr_table)(struct net_device *dev);
 	void (*irq_enable)(struct net_device *dev);
 	void (*irq_disable)(struct net_device *dev);
 	void (*irq_clear)(struct net_device *dev);
-- 
2.39.2

