Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D55B4D9E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiIKKr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiIKKr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:47:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43CC220EA
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:47:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so5131855wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=IpM8ImahcxQnr43GKJ1vwFn3rPGdh1kfMTIgO7Z6QqE=;
        b=C7GgBhmkM6QeO0YtIxxIYCFAS9mJXK+ZKLXG5Fuptua8URwAL5c024PS8Ej/EwrKAU
         zHDsP3DEo0Xkbkr3f2AvFIKWqjBvEzJsRDIgrNKr1nIWA1krj1zZAF/BZXR9TpL6S2go
         Tk5XugGqcodDKYoIOCxsF7bKF1/PcuJ7mH+DR3WNMxukOs1gB3Wq4pX88f6IECoyFkZD
         DxGy0xIU7vpFg1cJlCiVksBBsKKrRAWLXLjSXfquRVNVMihpDBdD03DM8FArvAtxdDAA
         j7Ls9Vo0PT7JGhM6sitqWSmZmFNXDZRaHdIotIlP2X5Xtu9o44Ir4ELbbgEUPLiwhNiq
         7c2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=IpM8ImahcxQnr43GKJ1vwFn3rPGdh1kfMTIgO7Z6QqE=;
        b=zUC6omajC5XTPhaMfEBeU6Y4mdJGwldij3pUDwO5WYQvwbza18pQDrheuIl2sjgI20
         EJr21eokS3vwg97cOrhBeDuGx1SWTRuXC7V0QiWOWcOOwVebUmnuLkZjUhGhF8KgKwsy
         u6uMsKxVc0QyeHt4z/m0O+rU4KvWVzD9VSsa+M02uVkIBg6FqFslZ9C6uj+4mUSrycNT
         yCcEATZ8uclJxstQatbyLzINccj9ZeiWCyeooq+5lnjIdJn9Yu1Zojgz5+R/XUGubzKX
         U96+ctRnXVwaUJ16SDdGx2LnV5+EBOSGSt/aLSn7ULL0e8l4ekM+L359tHod0Zr6LLEc
         0GXg==
X-Gm-Message-State: ACgBeo3Zh9GPzVXvO09fXi5ckH8RlniIhyJakqoFy/Z7+mT64KmbQUoJ
        GRretSk5Pl4X6176nrXalCxaSZaGGGA=
X-Google-Smtp-Source: AA6agR74Rprh1P1dW/+ozFcP79MAOARJjdumplSg2HpQoAXMmj5vmDfF6vo9RkCeRRRS8+HixDGjXw==
X-Received: by 2002:a05:600c:1d1e:b0:3a5:4f8d:743f with SMTP id l30-20020a05600c1d1e00b003a54f8d743fmr10486222wms.121.1662893244059;
        Sun, 11 Sep 2022 03:47:24 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c020b00b003b4868eb6bbsm113539wmi.23.2022.09.11.03.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 03:47:23 -0700 (PDT)
Date:   Sun, 11 Sep 2022 12:47:22 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] staging: vt6655: Rename function
 MACvSetCurrTx0DescAddrEx
Message-ID: <4337deed83e1443ebf93c5591e17f5c6dfe0cf55.1662890990.git.philipp.g.hortmann@gmail.com>
References: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function MACvSetCurrTx0DescAddrEx to vt6655_mac_set_curr_tx_0_...
to avoid CamelCase which is not accepted by checkpatch.pl. Remove
unnecessary declaration of function and make function static. Remove
unnecessary line break.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 5 ++---
 drivers/staging/vt6655/mac.h | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 0ff98468b2e0..2fbee8508f0e 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -595,8 +595,7 @@ void vt6655_mac_set_curr_rx_1_desc_addr(struct vnt_private *priv, u32 curr_desc_
  * Return Value: none
  *
  */
-void MACvSetCurrTx0DescAddrEx(struct vnt_private *priv,
-			      u32 curr_desc_addr)
+static void vt6655_mac_set_curr_tx_0_desc_addr_ex(struct vnt_private *priv, u32 curr_desc_addr)
 {
 	void __iomem *io_base = priv->port_offset;
 	unsigned short ww;
@@ -658,7 +657,7 @@ void vt6655_mac_set_curr_tx_desc_addr(int tx_type, struct vnt_private *priv, u32
 	if (tx_type == TYPE_AC0DMA)
 		MACvSetCurrAC0DescAddrEx(priv, curr_desc_addr);
 	else if (tx_type == TYPE_TXDMA0)
-		MACvSetCurrTx0DescAddrEx(priv, curr_desc_addr);
+		vt6655_mac_set_curr_tx_0_desc_addr_ex(priv, curr_desc_addr);
 }
 
 /*
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 0224f710d603..3fbb891ac57c 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -559,8 +559,6 @@ void MACvInitialize(struct vnt_private *priv);
 void vt6655_mac_set_curr_rx_0_desc_addr(struct vnt_private *priv, u32 curr_desc_addr);
 void vt6655_mac_set_curr_rx_1_desc_addr(struct vnt_private *priv, u32 curr_desc_addr);
 void vt6655_mac_set_curr_tx_desc_addr(int tx_type, struct vnt_private *priv, u32 curr_desc_addr);
-void MACvSetCurrTx0DescAddrEx(struct vnt_private *priv,
-			      u32 curr_desc_addr);
 void MACvSetCurrAC0DescAddrEx(struct vnt_private *priv,
 			      u32 curr_desc_addr);
 void MACvSetCurrSyncDescAddrEx(struct vnt_private *priv,
-- 
2.37.3

