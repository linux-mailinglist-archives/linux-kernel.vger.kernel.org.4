Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2490C735ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjFSPK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjFSPKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:10:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA6FCF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:10:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-519608ddbf7so3694011a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687187406; x=1689779406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09Nls6tXLgOvm0ng8/7m8dRNZ/h0ThOPEUKr3YHTZzs=;
        b=pme+MsdXK1u77Qcjve1hUQzq86C1M6dYAPy1m3hfdiAtb72eyv2TOoLP6TWC9DPPSg
         me1SSIX9+gs9DZl/C0tp0aap+CN0oV07PPnIZNPnqcbjhzEkZqekyXN/me6HPs70P0z8
         hwDeeCACZLSSq0s1dErFwVZo6S5ESwUrlFxobMlVtoX8wPqdB4pQVHPCBHhWJ9KaPDSU
         fN1MxkXkZY6gMQvzxetHaBMvQY3SjmkQ0uulHc2Ht1J3f8sN67MuTaweNkXBM7GfB2AY
         pRFJKzNVAEzdL5akaO0o8yL49L/CV/+D6XJxH7+BFAy4Y4dYhXL+52aNZacdCfn9vR2o
         2opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187406; x=1689779406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09Nls6tXLgOvm0ng8/7m8dRNZ/h0ThOPEUKr3YHTZzs=;
        b=ZMlODmeC7C8zbVdoMTK9zb1NIJ2tjW4za0pyYHnZJnHqjladFl5L2OJEVAPtqKHXMS
         GT6RbKgN8kh9Ra8wDHJldx74DrMvC9sifM4vZG76KIrr60MB1DgSYCUYQRZAkR1qhzyT
         Z+zXPhL6eL4IjX084PkVr3d1HgnJVLNhAKAtS+VFMrbRD8fWuOOeZh4eZ8DOuUUnLczl
         lKipi75Nwq4kaHlLkk8EKpiy/gFBb+AGY2qeSail6eu3bNRdiyCzCgIFRFC/zxe8UlA8
         vq4v6ooJ8ZRLjeWfLtk+1JMi/DNQ/xougyiNNjjTL0v1I3YGItzfV6uX+P3c7u7N6GRg
         Dkpg==
X-Gm-Message-State: AC+VfDz7Q4qysn7790DLdakc/FZqXZbveEllUR/h0B47LgK40bY6g94W
        XT3ql36Sn4UxX0LPTFNKUhM=
X-Google-Smtp-Source: ACHHUZ69hXtQAYUmB8YoITV8a1MdHg2JXDtk41CV4kQ7vR5XjOQLePMVMM/AeZQdilYcUSqBH2RLVw==
X-Received: by 2002:aa7:d0c8:0:b0:51a:4a25:bfbd with SMTP id u8-20020aa7d0c8000000b0051a4a25bfbdmr3392543edo.36.1687187406486;
        Mon, 19 Jun 2023 08:10:06 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbd5.dynamic.kabel-deutschland.de. [95.90.187.213])
        by smtp.gmail.com with ESMTPSA id p6-20020a056402044600b0050488d1d376sm13297186edw.0.2023.06.19.08.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:10:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8192e: remove comparison to true
Date:   Mon, 19 Jun 2023 17:09:53 +0200
Message-ID: <20230619150953.22484-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619150953.22484-1-straube.linux@gmail.com>
References: <20230619150953.22484-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a comparison to true reported by checkpatch.

CHECK: Using comparison to true is error prone

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index b680757cfcf6..88975dc804c6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -391,7 +391,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 	rt_state = priv->rtllib->rf_power_state;
 	if (!priv->up)
 		return -ENETDOWN;
-	if (priv->rtllib->link_detect_info.bBusyTraffic == true)
+	if (priv->rtllib->link_detect_info.bBusyTraffic)
 		return -EAGAIN;
 
 	if (wrqu->data.flags & IW_SCAN_THIS_ESSID) {
-- 
2.41.0

