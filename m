Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023D060C080
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJYBIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiJYBHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:07:47 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0446119034
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666614643; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=hzg40ZE5UcUNUD/mseP9iAHTDitqpX90Ky3TZw5wlclWgGQ7xOKLKdCFy0uDhHTU48bujHVRhyUSE/blOKr0Z6YOlV7vtG7CW4lqTnc7pUvNGGikXk2/Q2FFBzVCF7LVlramvIDo7w4hFJ3ePZjfAd2hwSGBk+IeJbS8yfWe6Gw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666614643; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=VaM1dZOJCoRSiaXa5ww7iLuX7pb/fYrY+ahwRZn31D8=; 
        b=YSiCGo+Uy8waY+IlOoXCI2NSfWCe0unKp0oB2jqyqsZYb+/2WGFurRU8+C8mej1Nrf5Aiy+gjI8PpdcjFVrG6I/06lEi+poK+Y09wm3gbv/b2wxMlqua4gff7+3me3dv8vS5f7+m4Zq4s4EQjOyNm+3vy3kAJTkkp6u5lAXCLgQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666614643;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=VaM1dZOJCoRSiaXa5ww7iLuX7pb/fYrY+ahwRZn31D8=;
        b=cPZ71K5ZtalAuN+GaCXOp2IwwdXleAa+oVDz4yqpTu2gky3Bx5nNnJwsNmrXKUIP
        JoMEOIt6A5jMOhr3qFUSBElp2dEYimD+kcm9qPp974VfMyJP9ElEuEPkcKwX5vckGwY
        b0DUccqGADqFj8HuiReBUAkotiWJ2e1TyVhrW9nA=
Received: from plymouth (103.47.132.14 [103.47.132.14]) by mx.zohomail.com
        with SMTPS id 1666614642004343.9699514179782; Mon, 24 Oct 2022 05:30:42 -0700 (PDT)
Date:   Mon, 24 Oct 2022 19:30:28 +0700
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Staging: rtl8192e: rtllib_tx: removed unnecessary blank
 line before a close brace
Message-ID: <234a3e8d21080ae2a1f75127a5c1a0ed131db924.1666612946.git.t4rmin@zohomail.com>
References: <cover.1666612946.git.t4rmin@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666612946.git.t4rmin@zohomail.com>
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed a blank line before a closing brace as it is not necessary
as per the Linux coding-style regulations. The issue was flagged by
the checkpatch script.

Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 4647efb0f868..101f44129145 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -954,7 +954,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 	netif_stop_queue(dev);
 	stats->tx_errors++;
 	return 1;
-
 }
 
 netdev_tx_t rtllib_xmit(struct sk_buff *skb, struct net_device *dev)
-- 
2.38.1

