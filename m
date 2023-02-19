Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E9C69C2AD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjBSVRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjBSVRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:17:17 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345EC19F3D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:54 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id eq27so2215893edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676841412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WI6z7LcNNkMYnP9QmQ96gaD5uwzVY4/0FvG8064MqWI=;
        b=Z5eDT4RqT+1DhLQXpGq8nFTzK5w9VmO+bORTFgxfaDXeOXyga1BLYyAwqPpUodd3PI
         ALKnFYB+PBQpqtI03FWhtIRS4TFlGkaRjxR+wMhFDgu62P1g3e2I2Orq4soysmTCjiBC
         a00SQh9ESv2aptqM16gNE5VLqWm6SCeC1qXZlYXwrIywbpJALr6c9qNdQ3QpQ/eRVfec
         lCm2KZpF0c5ui6Ne1CuDKGlZIgQQMJSHAtmPvP7ZY52Oimmg/P8/5mKxusiOb0IJ8k0o
         8uADwMPteC1zIxmA1he7N+4bZUSUcfXeVzRsK+Wy56yoxb6+DY4CdDdDt6zkebe2Ge90
         QygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676841412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI6z7LcNNkMYnP9QmQ96gaD5uwzVY4/0FvG8064MqWI=;
        b=k5469O8uyIUIuuJ4sdcTWh+KVJCEC5QVh1ml/9gYwlnYbmhDgVRq6jHGSzAytBpytm
         gGO2ess0e4XLA/pUEj+ulj73fWCk5GfFo+mFh9MjovD6WF7quJKlEYdZBWrbID8DxCwg
         B6en1FHJjzdbelNQrzOTQ7YJGri/Wx4OyFW/rWEmYz1W47nqCFijDbwAskvAWQ/p7SDQ
         /eHXbdukNdfAgMh7bLMdnAFtIBlJ2FMLKE1qv5dQrJwpTeacesTeHqMTGJpFEVg49FDc
         RF9ZIG8+5yySLxaoQaSfRAdgxZ+/GcpT/YIJM0jAC22atOblzS+R19wIGO3ij8WBHgGx
         SvRw==
X-Gm-Message-State: AO0yUKWjj4slc82d3ZFSM1s3y6w9NSuyOhTTSqTB3stTyaWTf+E56qqy
        65J2w8EQJ3UqWpxMVTCS/isXdvRGfGs=
X-Google-Smtp-Source: AK7set9Xu+E4JBsYAYnktR3m6B49t/pVeUNMWwTvE0t6Ac1b20ujg6D+KqVewKk/NoQLPAJtJ/uqrA==
X-Received: by 2002:a17:906:d4:b0:8bc:4c76:6f87 with SMTP id 20-20020a17090600d400b008bc4c766f87mr4698028eji.0.1676841412421;
        Sun, 19 Feb 2023 13:16:52 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id hb22-20020a170906b89600b008b14d3978adsm4811722ejb.189.2023.02.19.13.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:16:51 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:16:49 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] staging: rtl8192e: Remove entry .rx_enable from struct
 rtl819x_ops
Message-ID: <8fd6c4b18cff8662215e27d299205646ce720a3b.1676840647.git.philipp.g.hortmann@gmail.com>
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

Remove entry .rx_enable and replace it with function name
rtl92e_enable_rx. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 5 +----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 978088ab076c..aa0456931b09 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -30,7 +30,6 @@ static const struct rtl819x_ops rtl819xp_ops = {
 	.link_change			= rtl92e_link_change,
 	.rx_command_packet_handler = NULL,
 	.irq_clear			= rtl92e_clear_irq,
-	.rx_enable			= rtl92e_enable_rx,
 	.tx_enable			= rtl92e_enable_tx,
 	.interrupt_recognized		= rtl92e_ack_irq,
 	.tx_check_stuck_handler	= rtl92e_is_tx_stuck,
@@ -1400,9 +1399,7 @@ static void _rtl92e_watchdog_timer_cb(struct timer_list *t)
  ****************************************************************************/
 void rtl92e_rx_enable(struct net_device *dev)
 {
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	priv->ops->rx_enable(dev);
+	rtl92e_enable_rx(dev);
 }
 
 void rtl92e_tx_enable(struct net_device *dev)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index eb2b1e2ce4a6..71958c7a4cbf 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -211,7 +211,6 @@ struct rtl819x_ops {
 					  struct sk_buff *skb,
 					  struct rx_desc *pdesc);
 	void (*irq_clear)(struct net_device *dev);
-	void (*rx_enable)(struct net_device *dev);
 	void (*tx_enable)(struct net_device *dev);
 	void (*interrupt_recognized)(struct net_device *dev,
 				     u32 *p_inta, u32 *p_intb);
-- 
2.39.2

