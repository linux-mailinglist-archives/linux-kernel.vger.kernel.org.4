Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F706095F9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiJWUGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiJWUGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:06:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B447F7173D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:05:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j12so6869264plj.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNelz6psOVZvSdJm4dYtPRIHqRerfX2/bz4SfbnUV0M=;
        b=Xp2i7pQ6YdRkMmb3NqArPS7+CKXjjGodgOQz04VliMqLh9z/B410y1zU9naf8/fjO1
         SQE4f0B+axTeHDrqzq0RmmMErWjyeYUFY8CpJIeNTKrsb9F03drqDdGQIiqPeCGIq729
         3Qj6S8XYjCwm9Ikt/9Gr11/ptRIXi+bUZ9McPsLFVqSTsaiIf16zrUJ6qvLLMTnyJcTJ
         yfxuOsm8K7Bim0Ona9cf8dDcseInkv3LvgCUoJBwYEgpBI2ioTkClb9E93xsSbWDDx+M
         2LVjwZYDkYgjwkQw9ohHfvvHonCeVNQE3ywqkMVlVTnvQByBqxqSAq0poTlcm1QJc3Ub
         +mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNelz6psOVZvSdJm4dYtPRIHqRerfX2/bz4SfbnUV0M=;
        b=obfnjCNwZLmvWo0aIlLlLkO5dOAzEPpa4Zl3j/nk+SN29ap4xaddKVUR8H2/oCnkOh
         FkxwHdQzE8CwkM0ItF3UfbBl0BN8byhVTKzF0poQEuYCuTaYd0xQ/ff+Imp0Dw5z2hk8
         uzC63rLhUvF1Ac5+Uvr1eX/xYX3qabJ2571GsM81gn/mbtG7bXwGvxuP4Mi2L7aKe8RE
         cqBn9zdwfUv0TlrBrCjJjMRPl/0mITLm2jCQrbSOTLzsRkCUGGNGp55ReKVpN8MTlBhy
         YDk4rLMhf3bfmSOIKzBoHNO6L9IalKlMShU+4UzSlNGcjiq1Ef4zfV8CmdX/7tktknyX
         FTPQ==
X-Gm-Message-State: ACrzQf2Cui5yKtHTnPr6jUKM5Zxj8LVEwhgAQLV9BVoZK/aJ2iuxa0ba
        qX0efBsFBmST9BpxHyFnBzc=
X-Google-Smtp-Source: AMsMyM4oIJdUSzUpG7D8ydxO97fEzgQ+9pqqYZ054cRX2SoOmQidSkCoAJiel+mlXFzZhaixTTylTg==
X-Received: by 2002:a17:90b:3b45:b0:20c:2eae:e70 with SMTP id ot5-20020a17090b3b4500b0020c2eae0e70mr34726662pjb.240.1666555554776;
        Sun, 23 Oct 2022 13:05:54 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id e13-20020aa798cd000000b0056bc0578c7dsm1130649pfm.110.2022.10.23.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 13:05:54 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: remove unnecessary variable in rtw_recv
Date:   Mon, 24 Oct 2022 05:05:30 +0900
Message-Id: <20221023200532.259276-3-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221023200532.259276-1-tegongkang@gmail.com>
References: <20221023200532.259276-1-tegongkang@gmail.com>
MIME-Version: 1.0
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

Return _SUCCESS directly instead of storing it in a variable.
This can prevent cocci warning as follows:

  Unneeded variable: "ret". Return "_SUCCESS" on line 1516

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index bb5c3b3888e0..9e98aea09583 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1415,7 +1415,6 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 
 	struct recv_priv *precvpriv = &padapter->recvpriv;
 	struct __queue *pfree_recv_queue = &precvpriv->free_recv_queue;
-	int	ret = _SUCCESS;
 
 	nr_subframes = 0;
 
@@ -1513,7 +1512,7 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 	prframe->len = 0;
 	rtw_free_recvframe(prframe, pfree_recv_queue);/* free this recv_frame */
 
-	return ret;
+	return _SUCCESS;
 }
 
 static bool check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_num)
-- 
2.34.1

