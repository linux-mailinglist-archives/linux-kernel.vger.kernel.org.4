Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E4172F4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243131AbjFNG2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjFNG2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:28:34 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE92199
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:28:33 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgwV41r7jzBQgpL
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 14:28:28 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686724108; x=1689316109; bh=uzV5IRMvn+xjooRI4ST/VUkNmJE
        0mM4D/yBYv59E2J4=; b=OEMPUrdH+ElMTwD2vHZWY4u1D16Vyz9lew1NmE97VQT
        BPrKK3SeywTLBuWEFUijFPcs/5tFhE8gck3rt/3FbWXIXQ/inKkb8IdcaDDhTBJZ
        UVl5iTacfGd7dMGPjtRm5avZWcMIhUOa3k7VO9Y9ibjhn7irMo1sbShaQZS63Ii6
        vTWQ1TI5dPaua4b3JA/p4rHUDyPVzMFekEqu4t9thOtNrlii9i2xbNVf1B9Osl4y
        AkWdQLxH3lRXkbLYpciy+EEFp28oNYkYLuq8TSO0sIYGq5OkULtJH35F4dJkMSGe
        G6zkgkRxf5aWuIlCWyWF7FpsBEkTVU9sltgtlipk8FQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QKGgs4OV1NwW for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 14:28:28 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgwV36l4GzBQgpC;
        Wed, 14 Jun 2023 14:28:27 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 14:28:27 +0800
From:   xuanzhenggang001@208suo.com
To:     pkshih@realtek.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rtw89: Remove unneeded variable
In-Reply-To: <a4bd77fc102a60ebac4e036842015eac@208suo.com>
References: <20230610131734.21134-1-denghuilong@cdjrlc.com>
 <a4bd77fc102a60ebac4e036842015eac@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <bef94b1701cd3a9718dff8aff1f4e7f4@208suo.com>
X-Sender: xuanzhenggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/net/wireless/realtek/rtw89/pci.c:239:5-8: Unneeded variable: 
"cnt".

Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
---
  drivers/net/wireless/realtek/rtw89/pci.c | 5 ++---
  1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c 
b/drivers/net/wireless/realtek/rtw89/pci.c
index 9402f1a0caea..591b7b9a6eca 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -236,7 +236,6 @@ static u32 rtw89_pci_rxbd_deliver_skbs(struct 
rtw89_dev *rtwdev,
      struct sk_buff *skb;
      u32 rxinfo_size = sizeof(struct rtw89_pci_rxbd_info);
      u32 offset;
-    u32 cnt = 1;
      bool fs, ls;
      int ret;

@@ -297,7 +296,7 @@ static u32 rtw89_pci_rxbd_deliver_skbs(struct 
rtw89_dev *rtwdev,
          desc_info->ready = false;
      }

-    return cnt;
+    return 1;

  err_sync_device:
      rtw89_pci_sync_skb_for_device(rtwdev, skb);
@@ -308,7 +307,7 @@ static u32 rtw89_pci_rxbd_deliver_skbs(struct 
rtw89_dev *rtwdev,
      rx_ring->diliver_skb = NULL;
      desc_info->ready = false;

-    return cnt;
+    return 1;
  }

  static void rtw89_pci_rxbd_deliver(struct rtw89_dev *rtwdev,
