Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E4669E928
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjBUUxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBUUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:53:30 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7502302B0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:53:16 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cy6so16889452edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677012793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5781ruJ9B83DIEjZUA3ADxzlHbWLbO7A7cvptYVnr8=;
        b=QtC9yT4Q/rx1NryfvbZbre7nYLVimqms/39fS4wORcJdWjcd4fNopCglE7t+tI1Scp
         w8WOvkiqH/nZzBvANym1TsIlOQ0lXJXOKaFkLfcBWY53O9uIOSYwSGBYaLq0KmggQ5g4
         6lCuDZKNwsaCyF2uQ3Y71jW+6G2cWhqpfJkhAQ5qMTst0G3WbkeywH2kFA6VGNH1DwhO
         kOfF5qEKmna+i8SPCBvb4um8K7yInNHorzVYrEIQ0VeCHUzS7Yz0a7C3inkXdDWJnwq7
         +/L8o/r4OKDDSZIVU9c7mAqiJI91c+bpNxw8pDPfw2/6XCt4yziGG7j8LqhOSz/Syyfe
         0FYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677012793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5781ruJ9B83DIEjZUA3ADxzlHbWLbO7A7cvptYVnr8=;
        b=HeDXh4MI7ubY2NCTfp3Wh5nVV4rxGrGgGEMQJJI5urrIPKWa1LZ3Fk4XQyTcFRWWoR
         y+1apdKa3NmzqSVJATl6flJeP4K4SfXjZ2+B/CcXGPbonzuNyrcnQzhH1TecSVsMADqS
         APvPFDmAD0nd/71csrbq4SW8hJIilU/SKbCtkN4JWF9RUklir1Ajl9A+Z0GeFkfWCsqa
         WgbdwLViVCfQAA65kk4VVRo1BjTUMAODXd9t93BU6SWtj2aeeScgT2D13NzlQssYXLRw
         KkMX7JqA4fS+mErB1Tj9eEu67sG9HafMZ+qIe3v85qI+tDTA6NfuJoWXEf52v8vckfG7
         H7DA==
X-Gm-Message-State: AO0yUKW0YCZ4lPISq5PclhVNGSLkG2fvdtXFh09Rjcoozzh/J8/BXtWR
        n9/tl8B9aL19lxDgLajCQ/g=
X-Google-Smtp-Source: AK7set/BNSY+AU9d37NebB89iCLAKsbGLrT7IWNfsWyikQk12tv01VyG70OnvSbZoySpQ/+YCvUsGw==
X-Received: by 2002:a17:906:51d8:b0:8ae:cd8e:3957 with SMTP id v24-20020a17090651d800b008aecd8e3957mr11185525ejk.4.1677012793343;
        Tue, 21 Feb 2023 12:53:13 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id n27-20020a17090673db00b008d173604d72sm3311391ejl.174.2023.02.21.12.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:53:12 -0800 (PST)
Date:   Tue, 21 Feb 2023 21:53:11 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] staging: rtl8192e: Remove entry .tx_check_stuc.. from
 struct rtl819x_ops
Message-ID: <f58cc7b39f4a6bce0606bdd90a706b35b87d8256.1677010997.git.philipp.g.hortmann@gmail.com>
References: <cover.1677010997.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677010997.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove entry .tx_check_stuck_handler and replace it with function name
rtl92e_is_tx_stuck. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 3323bdf564ee..410c03833b9f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -30,7 +30,6 @@ static const struct rtl819x_ops rtl819xp_ops = {
 	.link_change			= rtl92e_link_change,
 	.rx_command_packet_handler = NULL,
 	.irq_clear			= rtl92e_clear_irq,
-	.tx_check_stuck_handler	= rtl92e_is_tx_stuck,
 	.rx_check_stuck_handler	= rtl92e_is_rx_stuck,
 };
 
@@ -1055,7 +1054,7 @@ static enum reset_type _rtl92e_tx_check_stuck(struct net_device *dev)
 	spin_unlock_irqrestore(&priv->irq_th_lock, flags);
 
 	if (bCheckFwTxCnt) {
-		if (priv->ops->tx_check_stuck_handler(dev))
+		if (rtl92e_is_tx_stuck(dev))
 			return RESET_TYPE_SILENT;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index d3558bf6ce23..87be8aaa7822 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -211,7 +211,6 @@ struct rtl819x_ops {
 					  struct sk_buff *skb,
 					  struct rx_desc *pdesc);
 	void (*irq_clear)(struct net_device *dev);
-	bool (*tx_check_stuck_handler)(struct net_device *dev);
 	bool (*rx_check_stuck_handler)(struct net_device *dev);
 };
 
-- 
2.39.2

