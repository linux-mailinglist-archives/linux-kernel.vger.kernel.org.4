Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331AD69E92A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBUUxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjBUUxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:53:41 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E62C199DF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:53:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id da10so23604592edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QH2bynTgQgeQB02d89xxZQh/5I1bMrM/o69ZGqMcG9Y=;
        b=ARLaoChs6okn7XQH0Cx08m4cWNbfUO0hMJm4hk52dPz9ozhk3vQwOtqXRJnADc5MHa
         Nrvu4jVfEuZhVcbEv+A+XwvqlOnPie4vzVzMsqEEC3LqrgfN4bUHiJOVzxURVp0g0pbL
         VrjuxQeueJ+1wWtmfq+3a9W2gTBaGM4dn95wEZw7DvCBqJ/0jxTPOimaMewXGES0aGhg
         MrXzwcyiesCq5UJLJVJRk7qNAf3BhKrCk4ACKshI9tot15cEpHrgWGDZKqU/PdwY+3eA
         hVCW/DpLQzBKJ2zFaCeOOY7R88Fpn28aIe2x5zVSODq6w0EcJ710vIPlB9ZCMOZhEMVT
         E9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QH2bynTgQgeQB02d89xxZQh/5I1bMrM/o69ZGqMcG9Y=;
        b=P/KKjrkcFSIyVsQtmp1VSLOuXygoEMTNgxitM3Xs3YSCI/u4tRYs0sIW8kRQwBwFyZ
         T0ksXyWGUwU8k6Y8qnvHDjWgpGBYJKRk1MTOfoUAOY2zeOsAVOIx3z/iLSvr2yhb6ubp
         dKWuv5Nw+XMu8xVQpDRmuXEi5Ow5iLUCzDKT5g1hNM5Nkh52VT1lw3Mei17re46kqe7R
         6uxCeo77lC2KWeUtAV0wjLlRPhbMBfGHluKt+KUMRB//59/w9u9VxRps4oH3TL9zKaTE
         eqhdOBIkjuK66HO4no+cwiOxbPb/UUIyV0yH41DOy59+ldEwkwy57DQ3ge1URE79wLwG
         OQog==
X-Gm-Message-State: AO0yUKUExEoQAkBo7UsYIXhsTyYEyusToX9ud90DohWpLRqijpNfgh2n
        CojpcAEXEeB6wNa/6whjmn3lfP3F/a4=
X-Google-Smtp-Source: AK7set96Ft9OwYk2icD9ZpnTPhzuAOaiVgN8OYIOovTD11HUbb3NyYJhWbRYJQ/qHSiKUFa/dwq0+Q==
X-Received: by 2002:a17:906:7394:b0:8b1:2614:dea6 with SMTP id f20-20020a170906739400b008b12614dea6mr13277593ejl.1.1677012806902;
        Tue, 21 Feb 2023 12:53:26 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id p12-20020a1709060dcc00b008c1f68ba0e2sm4692813eji.85.2023.02.21.12.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:53:26 -0800 (PST)
Date:   Tue, 21 Feb 2023 21:53:24 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] staging: rtl8192e: Remove dead code from struct
 rtl819x_ops
Message-ID: <93427f1b2ad5841451d7e8cc8a621d7eff8cd916.1677010997.git.philipp.g.hortmann@gmail.com>
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

Remove entry .rx_command_packet_handler, .irq_clear and
.init_before_adapter_start as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 15eab612b08f..0c1eb75f37f6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -28,8 +28,6 @@ static char *ifname = "wlan%d";
 static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
 	.link_change			= rtl92e_link_change,
-	.rx_command_packet_handler = NULL,
-	.irq_clear			= rtl92e_clear_irq,
 };
 
 static struct pci_device_id rtl8192_pci_id_tbl[] = {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 43e1c651e6d2..e572915c1fd2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -205,12 +205,7 @@ struct rtl8192_tx_ring {
 
 struct rtl819x_ops {
 	enum nic_t nic_type;
-	void (*init_before_adapter_start)(struct net_device *dev);
 	void (*link_change)(struct net_device *dev);
-	bool (*rx_command_packet_handler)(struct net_device *dev,
-					  struct sk_buff *skb,
-					  struct rx_desc *pdesc);
-	void (*irq_clear)(struct net_device *dev);
 };
 
 struct r8192_priv {
-- 
2.39.2

