Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7806E69C2A8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjBSVQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjBSVQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:16:46 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D919F08
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:23 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x22so4874245edd.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676841381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UkQuOoYWrqHzF7sqnR/KeVzMvcxOpAsOg249BRbujhQ=;
        b=eTwBnBmDfQoWeS10EDjwky+rA+UGnxGDFOZhIcHFvWQTCIIKV30OlrzdZAlQHEQA5X
         O6Eg1OP0bujKVNOnRyZuikUHSLjI5kamQeJkX/urCLcSrEVaNG74uQmUAiBA0weYAawG
         yi+YZAxSDRMECPxz1NfT+jGU5dibsJQe0exstoIQ+vAuESkeXhp5ddtBZFIUYWOGzNgF
         qeGboymTNGlTo9HCjkAmimIlsxLZGBYF3lmTP2Io9ecqHN0Pifgm8I8po5yzmIW8rpzA
         AYbFi04H0k6kaGWbI+P9EmtbaBCXv4oTqTXOqxJfBkovr6QUDQ8n2nDxn24gMNQjbRYO
         5iAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676841381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkQuOoYWrqHzF7sqnR/KeVzMvcxOpAsOg249BRbujhQ=;
        b=O/2GY5YlZekxphVnd+Lx65nwjkwwJLJBUpIrtmksbfQ2ba+TqxCVam4+Z/gq+ATu8D
         ANPPyn6FnubJ9IJeWXKwvw8sBlzRKxVHSfD8rm1k2lc7mJlqIDLc5b5C7/pNR9RK2PA8
         /9EbPtrO4AnQL9h7Iy+7J3R0/oqWl65OUYIYsAKH5Ot9Yv8lU9IUjiDklG5znNF3b6NT
         gEb7n+2yVJnH7k1ymEHT0PSaqqyflV1gobXOCAaXoomuyvLWuAvAZRxijNiGEg4+7Dlw
         b6fHAvz33b940NklUdgUmt3kii6P7qON7g84DoqA+t05XhR79wFSTIbwhbyCWdu56aUE
         uuSw==
X-Gm-Message-State: AO0yUKW74WL9gbZlBaeo/ewX02rpVj6VY6XgmpVyDDKdXFx2DFDC7j3l
        kdBzR3IZjB7NmMI5Azs4x8U=
X-Google-Smtp-Source: AK7set9RxbcbXqVJEalEi/Dn8n3BHyB8HCN8IPRF8iKOMldXQfL00wr8VIAHqgNVB+0NzcqxvvdJGQ==
X-Received: by 2002:a17:906:291:b0:8b1:7ae9:7332 with SMTP id 17-20020a170906029100b008b17ae97332mr9167337ejf.6.1676841381725;
        Sun, 19 Feb 2023 13:16:21 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id x7-20020a170906804700b008b138641f37sm4820169ejw.24.2023.02.19.13.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:16:20 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:16:19 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] staging: rtl8192e: Remove entry .stop_adapter from
 struct rtl819x_ops
Message-ID: <87f874eae22027956b9f1140b8d460ed8b63a9f9.1676840647.git.philipp.g.hortmann@gmail.com>
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

Remove entry .stop_adapter and replace it with function name
rtl92e_stop_adapter. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 7 +++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index a4796330f86d..566513338089 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -29,7 +29,6 @@ static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
 	.link_change			= rtl92e_link_change,
 	.rx_command_packet_handler = NULL,
-	.stop_adapter			= rtl92e_stop_adapter,
 	.update_ratr_table		= rtl92e_update_ratr_table,
 	.irq_enable			= rtl92e_enable_irq,
 	.irq_disable			= rtl92e_disable_irq,
@@ -756,7 +755,7 @@ static int _rtl92e_sta_down(struct net_device *dev, bool shutdownrf)
 	}
 	priv->rf_change_in_progress = true;
 	spin_unlock_irqrestore(&priv->rf_ps_lock, flags);
-	priv->ops->stop_adapter(dev, false);
+	rtl92e_stop_adapter(dev, false);
 	spin_lock_irqsave(&priv->rf_ps_lock, flags);
 	priv->rf_change_in_progress = false;
 	spin_unlock_irqrestore(&priv->rf_ps_lock, flags);
@@ -2055,7 +2054,7 @@ void rtl92e_commit(struct net_device *dev)
 		return;
 	rtllib_softmac_stop_protocol(priv->rtllib, 0, true);
 	rtl92e_irq_disable(dev);
-	priv->ops->stop_adapter(dev, true);
+	rtl92e_stop_adapter(dev, true);
 	_rtl92e_up(dev, false);
 }
 
@@ -2401,7 +2400,7 @@ bool rtl92e_disable_nic(struct net_device *dev)
 	_rtl92e_cancel_deferred_work(priv);
 	rtl92e_irq_disable(dev);
 
-	priv->ops->stop_adapter(dev, false);
+	rtl92e_stop_adapter(dev, false);
 	return true;
 }
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index d83af5f8ce82..083bba3dc51b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -210,7 +210,6 @@ struct rtl819x_ops {
 	bool (*rx_command_packet_handler)(struct net_device *dev,
 					  struct sk_buff *skb,
 					  struct rx_desc *pdesc);
-	void (*stop_adapter)(struct net_device *dev, bool reset);
 	void (*update_ratr_table)(struct net_device *dev);
 	void (*irq_enable)(struct net_device *dev);
 	void (*irq_disable)(struct net_device *dev);
-- 
2.39.2

