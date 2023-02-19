Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F264C69C2A3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBSVP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjBSVP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:15:58 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECA0196AB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:15:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id eg19so5691730edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676841349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SkbsuJIz6VwsIVSfK2JskzxbP3ShTN1QUSOlCSaSNH0=;
        b=XOtDzQAq3ERBqYgJBscibnLrqjW93b4cRvR2aRUdzauL+vCexicJb0FcjUWsii4kDu
         g13QeT1J1aZvoA74xIZpIHXCWedKRb6fujCCQOsdPKYxN8qYir1Lrj6/rnfAVQlb2Xor
         aXAryvA+8Ei16j8NaQwiPR2JbuUu/hzDw3AIJqUG32E5ZkZCcyKYSopHWShMjg7x+Ea9
         Gv/9j7Yclol1nDWtW0cZHC7yj/TzyKCLpL8djkDUTn+Odcugc2ZMQZODiYwYyFcwO4lD
         7Q07ECXJe66qkrfc21PMQBoKcWA9FGr9R1UYGj7B1LQIpy2G/omF9Fjal57VdrgqrEqH
         iMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676841349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkbsuJIz6VwsIVSfK2JskzxbP3ShTN1QUSOlCSaSNH0=;
        b=Jn4853byPgEqJmXIjgOnouCdvSq/roLfcONV3Mc1m66F5v8gkKPIsRh8kub+HnslPa
         i+S+WAzULugIoHg10nS4zv4sK57P0uX457Cij0E9JQGJoPTdAtNcRbYP7GPA5iy0YaHZ
         pt2S3s8d79eWCCzc4kebUhPSBVLTgcY4r8jtVVwrelRE2h+NtukmwZej14xTDhSlXWQp
         l7d2fhvBSfhjEueN+BrJCVxpKHa5DW8POAOr9aYRQYjTyfvNQeQycZ1v56wZV0K9dh8p
         sYWYv6kbfNTVGdIRFQYMgaLhc3cd32OlMa4Ih4pUpJHaQjlcxLNfbKtNQM11Z+rYj9y4
         OQxQ==
X-Gm-Message-State: AO0yUKVyfY/H3P1rYLBuDVjItlgalo+VUiuR3qmjRy+SJyZmcen4GjxW
        HY8Y9abdAJahqpz85QgQ4IqmcgqE7o0=
X-Google-Smtp-Source: AK7set8n1jHI8It8rj+KFupevoL6E0xhX6yGnLNLXW2Fw8kgna1z3qeRRsQmbWmCN4j0kO1h8CT8IQ==
X-Received: by 2002:a17:906:256:b0:882:bffc:f2d2 with SMTP id 22-20020a170906025600b00882bffcf2d2mr7958249ejl.2.1676841349029;
        Sun, 19 Feb 2023 13:15:49 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090657d500b007c11e5ac250sm4853849ejr.91.2023.02.19.13.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:15:47 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:15:46 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] staging: rtl8192e: Remove entry .initialize_ad.. from
 struct rtl819x_ops
Message-ID: <7457e18ea9f3b2415bf41fca8ac2b22349d2edd1.1676840647.git.philipp.g.hortmann@gmail.com>
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

Remove entry .initialize_adapter and replace it with function name
rtl92e_start_adapter. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 5 ++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 7b8683a9bdb1..3bebc1153572 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -27,7 +27,6 @@ static char *ifname = "wlan%d";
 
 static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
-	.initialize_adapter		= rtl92e_start_adapter,
 	.link_change			= rtl92e_link_change,
 	.tx_fill_descriptor		= rtl92e_fill_tx_desc,
 	.tx_fill_cmd_descriptor		= rtl92e_fill_tx_cmd_desc,
@@ -690,7 +689,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	priv->rtllib->ieee_up = 1;
 
 	priv->up_first_time = 0;
-	init_status = priv->ops->initialize_adapter(dev);
+	init_status = rtl92e_start_adapter(dev);
 	if (!init_status) {
 		netdev_err(dev, "%s(): Initialization failed!\n", __func__);
 		return -1;
@@ -2381,7 +2380,7 @@ bool rtl92e_enable_nic(struct net_device *dev)
 		return false;
 	}
 
-	init_status = priv->ops->initialize_adapter(dev);
+	init_status = rtl92e_start_adapter(dev);
 	if (!init_status) {
 		netdev_warn(dev, "%s(): Initialization failed!\n", __func__);
 		priv->bdisable_nic = false;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 541b7aa366a5..9edadc62faa9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -206,7 +206,6 @@ struct rtl8192_tx_ring {
 struct rtl819x_ops {
 	enum nic_t nic_type;
 	void (*init_before_adapter_start)(struct net_device *dev);
-	bool (*initialize_adapter)(struct net_device *dev);
 	void (*link_change)(struct net_device *dev);
 	void (*tx_fill_descriptor)(struct net_device *dev,
 				   struct tx_desc *tx_desc,
-- 
2.39.2

