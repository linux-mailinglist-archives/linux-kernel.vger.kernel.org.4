Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7C609D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiJXItp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJXItl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:49:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459F113DC4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:49:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h14so7617050pjv.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blmSZ/5kJFI3zeITciWHkokHSMBiiI5BLOjMr13YsbM=;
        b=iD20G/+v1fWUxk/brs0rDpv3A0OKoznryR8gJpQ2Ct1RWo4GGVYbhyXumEsi0qtzsD
         bu0avEXUYwBBOq078+q+NKFflJCxd3fIRQE141D+nojSgq6MMDUIPOpJGd8ndQmdkE+j
         sliQXQZnyHyaTM6NPFDG18Yk+qdkkL8wQiVzPv6kJywbOUYcl53N9MLEorH0zUcmClsc
         LktkWjzILnbKoVh7fjwQzv1zG8W/gOlymJ/awVLz6SvHkKt8Dk1TXNDm0J1I4sF4o5l2
         68PCrolAVXSJqK9JuVHgJXxowqctXmXE4voyT0nIm1Z0ca+WcIQZyZQw77L4y4IY1DNI
         gRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blmSZ/5kJFI3zeITciWHkokHSMBiiI5BLOjMr13YsbM=;
        b=yVteaHSiKHGfgixvEpFybYxWHd+EsbxLtIhKrBOQRWzaRW6gB445LGScsB3IDgHWTH
         s7niF9q1wpSVqpMNStNU6Ac2w3Fz4E+GsIkYvMuCwClJg47Rxt+xFprVTIwgNfGcUrE6
         l1r1CY5/mQD1wAn+zzzaGtFcsocFzzRad/GXmjJrfEpuUliY8bCfUpCrFv8m4ESPv2qb
         IJGETfCUTh415+/N0Bo+1fF/zzl9xUqkj1S4z+iv+viqE+65n6OLJKg80V6uplkBJtOo
         l935lb1+KFZdhIIEYEt9kRYBO7thT5gNvyxQGJUVRX2zuQ92Arj1oihNTt7MRJx4njlV
         wAFA==
X-Gm-Message-State: ACrzQf0HZGJ8u+/1DrzEAUMA9/5nHBLIWY4Wb0wTE2zl13+B6kX50shJ
        nwuRpcxhGSC0h9WBDcxBTD0=
X-Google-Smtp-Source: AMsMyM5aYq4JVmyu990he+dAyalPgz9Z6iKvjICG1HRHf+BjVQ5Rczv+OanEopUJ0OpP5ta9aAHkkg==
X-Received: by 2002:a17:90b:3e8a:b0:20d:4632:e487 with SMTP id rj10-20020a17090b3e8a00b0020d4632e487mr37883228pjb.78.1666601377670;
        Mon, 24 Oct 2022 01:49:37 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id r2-20020a63a542000000b00434e1d3b2ecsm17245124pgu.79.2022.10.24.01.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 01:49:37 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v2 2/4] staging: r8188eu: make amsdu_to_msdu void function
Date:   Mon, 24 Oct 2022 17:49:23 +0900
Message-Id: <20221024084925.262289-3-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024084925.262289-1-tegongkang@gmail.com>
References: <20221024084925.262289-1-tegongkang@gmail.com>
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

This commit makes amsdu_to_msdu into void function in order to
prevent cocci warning as follows:

  Unneeded variable: "ret". Return "_SUCCESS" on line 1516

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
Changes since v1:
  * made function amsdu_to_msdu void

 drivers/staging/r8188eu/core/rtw_recv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index bb5c3b3888e0..a0d7cf08f933 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1404,7 +1404,7 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_fr
 	return prtnframe;
 }
 
-static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
+static void amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 {
 	int	a_len, padding_len;
 	u16	eth_type, nSubframe_Length;
@@ -1415,7 +1415,6 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 
 	struct recv_priv *precvpriv = &padapter->recvpriv;
 	struct __queue *pfree_recv_queue = &precvpriv->free_recv_queue;
-	int	ret = _SUCCESS;
 
 	nr_subframes = 0;
 
@@ -1512,8 +1511,6 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 
 	prframe->len = 0;
 	rtw_free_recvframe(prframe, pfree_recv_queue);/* free this recv_frame */
-
-	return ret;
 }
 
 static bool check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_num)
-- 
2.34.1

