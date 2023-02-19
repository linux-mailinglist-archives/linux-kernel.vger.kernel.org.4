Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E5E69C2A2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjBSVPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjBSVPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:15:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAD519F06
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:15:44 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ec23so4563618edb.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CNKm2ICS8NTcE9li8wqc3yPoX8R5OlDOV+QO9nDi+Rk=;
        b=T6l0u7h2r5bDEzKhCuMOX5vwH8APMxKVNNOiSC/e8tLHeKNSHx1VgVQueGNayOrp6R
         v5FBLKlOsx+jxt2IQJRc9Ke/iaH1NyYES+uT2D/jugsWPOZEZNDt88eHDtgUuWOUReup
         rQRj1x+Zi7tcrlLFIxtRA3GCc8tkEtQQUFmV+9kHZRPkOvq9i+ccHWKhaSQEY/dBG5xp
         PTA6pdh4tp9sxrZm5+WRsPQwTzqRiWLgKmQfnmnnJZfW8llj4Eume4G6IcL/uxf5jggw
         3YT4pW78YA9RdZbvzJKTqV3vRPVE+Ewc5uT+SKvEAoY3QqOLuZKA4L/jSuy/dY8pgTZO
         Dc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNKm2ICS8NTcE9li8wqc3yPoX8R5OlDOV+QO9nDi+Rk=;
        b=VC5pDk10F2afMEi87XFa2BWqk2LmjR7cMJYMEr0LPmlpe9FQ+Y5EKWGqiZ3+10uNtl
         sl8uR7gZtO6MVs/1067RMUTt95udWZQXRGI33JypgqGKCgn7O1zdIjxd+mDi0o05C7xh
         PFvyMw5ZGhOEw1w6vogamH5GlX6RM63p3KxC0y+O7y/LhQMS7uxQgGRFRVvE+vBuyRwI
         mX4ej1JV02iH9UtTjc3xUKFwXJFkfqAG+srd2vnxJLMMcp6wVTipxZ20njuLtwbIgfUc
         JXTd+5fcc+TRSRWxRsiL6/XoQnm8KGZOvvRTPY7stX5DiDUfWlj6oh5npdJZYBWIjz6/
         Iu0w==
X-Gm-Message-State: AO0yUKV5mZzZACtzT9wd6wxUoddrHLievvliEhR+meE7zI7EwW50e9G7
        94EwHSKRxxtBF06k7ZszYSQ=
X-Google-Smtp-Source: AK7set8Z+/HFpC2Eg8xMwXru6lOSDfRdE4Qu4CcLg4my6aCpDp/MQLk7NvVTZkSiCOreqSs4ImANDw==
X-Received: by 2002:a05:6402:d0e:b0:4ac:ce7d:a9c7 with SMTP id eb14-20020a0564020d0e00b004acce7da9c7mr1056616edb.4.1676841342625;
        Sun, 19 Feb 2023 13:15:42 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id o1-20020a50c281000000b004aef4f3bc26sm925604edf.87.2023.02.19.13.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:15:41 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:15:40 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] staging: rtl8192e: Remove entry .init_adapter_.. from
 struct rtl819x_ops
Message-ID: <cc6134e1cf43a8b74615f9eb4377988e3edd0bca.1676840647.git.philipp.g.hortmann@gmail.com>
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

Remove entry .init_adapter_variable and replace it with function name
rtl92e_init_variables. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 73f3d0973a5a..7b8683a9bdb1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -27,7 +27,6 @@ static char *ifname = "wlan%d";
 
 static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
-	.init_adapter_variable		= rtl92e_init_variables,
 	.initialize_adapter		= rtl92e_start_adapter,
 	.link_change			= rtl92e_link_change,
 	.tx_fill_descriptor		= rtl92e_fill_tx_desc,
@@ -974,7 +973,7 @@ static short _rtl92e_init(struct net_device *dev)
 	_rtl92e_init_priv_lock(priv);
 	_rtl92e_init_priv_task(dev);
 	rtl92e_get_eeprom_size(dev);
-	priv->ops->init_adapter_variable(dev);
+	rtl92e_init_variables(dev);
 	_rtl92e_get_channel_map(dev);
 
 	rtl92e_dm_init(dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 00e413a644d2..541b7aa366a5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -205,7 +205,6 @@ struct rtl8192_tx_ring {
 
 struct rtl819x_ops {
 	enum nic_t nic_type;
-	void (*init_adapter_variable)(struct net_device *dev);
 	void (*init_before_adapter_start)(struct net_device *dev);
 	bool (*initialize_adapter)(struct net_device *dev);
 	void (*link_change)(struct net_device *dev);
-- 
2.39.2

