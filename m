Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F1B607E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJUSKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJUSKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:10:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF88558DC;
        Fri, 21 Oct 2022 11:10:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b4so6287321wrs.1;
        Fri, 21 Oct 2022 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=de+kk2perbv4KysWHjrNxKnJA8xDIO/vAGvbM/ll1vI=;
        b=Y3zAXEqFcj+wHJiqU7QwFJbdFxqy8zcubpDSGTu9pVPQFf8twhnC8lqwEMMZSRxocG
         HZmZ+41kwbN/V6S1gv+KVsnBgtarfMsXf4GvG/lRy6IF+CQQ6m1BUpvEXYR9RyB43SsH
         RPTKbw1nfgDhFCd/pK3sNF9wI80sfqVj2VPwnb9rPq4vhzUnDVLE8biOBnnP0qx1Vdsa
         YIEqK63fNKJFBP/yHosMwGYHLmPEBZ2U1rUOURNIKqMV8RvT7tGxKYl9e1U1KonncNjU
         VZJtAl7E5k3e2ObsgN6MwNqy1uKPFs2NwPxhzXj75on+/F93k4w70k4eDE32osRJ0tY5
         m0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=de+kk2perbv4KysWHjrNxKnJA8xDIO/vAGvbM/ll1vI=;
        b=N2S35VPjxAnV/X/Cq2zT8Lj/uAMD3ZLIAmGUKqsjx8x04jvJOkpfcLtt8+HhjAD55M
         aKUo9oin/82JakN592O2g3TWgLctmkBql4YBoFI49wWYZWLMyxzuLPblkCkyUOx/tt0Y
         BgEuKjs72XCldSZIpC80S2x7Ekb7g7TnaEtw251Miq018zvh9QhAamxmmohXPPGyGO4o
         W9iQOFbroFLmOnGr2mxKAUmdQqdeg5fUDKGJcvd/pxMp6PMKsyVDBQyO1SK4zWf9NGWj
         MaTNxZdxPWj13NhE2/Ru1MVIuLCOrT3HgfazqYpw/QCr6+d7nVuH/WMIVEJ7prvFCaMO
         T2bQ==
X-Gm-Message-State: ACrzQf0e4XCMZQ0Y4OV8glScfDAvmMltD4DmvUkBSoJZ3Iy9hoJxPR/N
        lRBuzIkxKtazV2iYDBB2aseFih1aRY/0eABn
X-Google-Smtp-Source: AMsMyM5xiytkEAXxryRE6LfVZ8R06NNlNE/a/bRfWC5q8alyb/pabJRUfgXrO6xhyLXTZk3pQPewTQ==
X-Received: by 2002:a05:6000:1548:b0:22e:3469:b726 with SMTP id 8-20020a056000154800b0022e3469b726mr13087613wry.10.1666375792007;
        Fri, 21 Oct 2022 11:09:52 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m2-20020adfe0c2000000b0022e6178bd84sm20522348wri.8.2022.10.21.11.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 11:09:51 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: Remove variable xcnt
Date:   Fri, 21 Oct 2022 19:09:50 +0100
Message-Id: <20221021180950.29139-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable xcnt being incremented but it is never referenced,
it is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_xmit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index 84a22eba7ebf..4cb01f590673 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -601,7 +601,7 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 #ifdef CONFIG_R8712_TX_AGGR
 	struct xmit_frame *p2ndxmitframe = NULL;
 #else
-	int res = _SUCCESS, xcnt = 0;
+	int res = _SUCCESS;
 #endif
 
 	phwxmits = pxmitpriv->hwxmits;
@@ -673,7 +673,6 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 			dump_xframe(padapter, pxmitframe);
 		else
 			r8712_free_xmitframe_ex(pxmitpriv, pxmitframe);
-		xcnt++;
 #endif
 
 	} else { /* pxmitframe == NULL && p2ndxmitframe == NULL */
-- 
2.37.3

