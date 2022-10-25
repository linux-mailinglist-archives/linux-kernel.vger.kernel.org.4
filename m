Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F4860D238
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiJYRGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiJYRGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:06:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB17FFAB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:06:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso7935495pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiKyw0R3gnXw2JRFe0MILoD1CNInLwVAP+DIRRMQdcA=;
        b=Z7vGHc/RsXVHwy7Ey6NTTNIp8n1OPafSnE3d8E5xjPk9UHoIDKbAzQsIH+L0HPB1CG
         JVeAZhvibSS2rM1cfyIkte/VDA0Gob21awPRJ4gh+fNCbopbdU8Rokphv889+p3+cdTi
         Q00weE1M/4V7W8SWmGb+uhxOzb4TLqsG7gmI+d89rgmlt7ypEN52LF02rqpg6pDOzUH8
         kqCg1VM2ReCt04f+NxeuyGtXS8cuH1Mjlk3KDRTNVEeYIaN1aYtxjewE+GbkuO8nW12u
         bxlC6GySaycF/qvT+8rrZTOcOxy46CAdUEhJwGdPlf2E0lkbqMyofZe0zKo2AoiybTrK
         2iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiKyw0R3gnXw2JRFe0MILoD1CNInLwVAP+DIRRMQdcA=;
        b=fyPzIE3bxx94bG6tbqJzg0T3znRigZRV7aj/RlvG7SoiZQma87EEwGqnb1mNOMXsx/
         qALlHtcSBzXpZEG0d7iy4CXCwF3+PxJ4nxI97Y5EN+xBmTBdfVu8SyBsCWhjWL4QU04K
         C4YUhDb6eNoebicUQ7IBbnHg/jSp/uBznD0+yMn3+omO/gf42bszCKBHvuHGkm2qZCjF
         HXPitcAQJsD1n4dzB5PmW62iTk5Uvhneynp1wVIAQJVu56xqM/GTbYvl4Cy8NArNnrni
         JGAzzq1vervo8iHRlrOF2CMHlqRtACXpCbX1AxzmGG4vTVnxHjsFvv8aDS3npHGpYTWx
         KWuw==
X-Gm-Message-State: ACrzQf3lcgR1n8Bbn9+qw8PPmOaCt4w14AESJQzOTOk9hk+cqs9aZNsM
        1FvYjw2PmeJATZTZJ2V56f8=
X-Google-Smtp-Source: AMsMyM5aYy3Gx70pUtb8pyS1Il1ZnepAErbJcZC9a68qBZjjd17/uP8DaRcoOum87j9I9/uwbQUgyg==
X-Received: by 2002:a17:90a:1b44:b0:213:1035:f913 with SMTP id q62-20020a17090a1b4400b002131035f913mr12926951pjq.133.1666717595494;
        Tue, 25 Oct 2022 10:06:35 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id a1-20020aa794a1000000b0056bcf0dd175sm1592373pfl.215.2022.10.25.10.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 10:06:35 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v3 2/4] staging: r8188eu: remove unnecessary vaiable in rtw_recv
Date:   Wed, 26 Oct 2022 02:06:19 +0900
Message-Id: <20221025170621.271903-3-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025170621.271903-1-tegongkang@gmail.com>
References: <20221025170621.271903-1-tegongkang@gmail.com>
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
v2 -> v3: rollback to v1 because v2 caused error by kernel test robot
v1 -> v2: made amsdu_to_msdu into void function

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

