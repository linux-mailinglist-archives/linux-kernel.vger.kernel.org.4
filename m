Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6FA6095FB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiJWUG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiJWUGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:06:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9DE71733
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:06:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s22-20020a17090a075600b002130d2ad62aso715604pje.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLIdpQp6TVzjpS8r5yHeQWkGEgLDOWAXXPd+wr6BFps=;
        b=W/zZcv3w/UDpaPdd/s8jBz2WkbIIeCIby8DcPlgihtqoFanbHmNb5C9SklB+vJ3ImT
         6bCBuTD7HnmvHz/Uy3ueZZOYPZ2xEXlXa6NTmtXoISttykHJJKbrl/3pIqsIpS9TPo7o
         WiCrPy613uZQtgr3+OgBmfx1n1IjPIslnIDHKMHREiWXsslm02lmKTe36WMQyJmi6p7D
         LdRrZEC+i9VnYwmbEM7HomFHI9SirmbEolrlLngZphlEF8I8rEddQtfVa96bwKLy6yRO
         gCnZXVqRYL/cgcudnEYN5+DtOtTH1k1x9aYY+bWk8VrqSiXV7IWpkpDTNszVGIf7Y+vq
         sFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLIdpQp6TVzjpS8r5yHeQWkGEgLDOWAXXPd+wr6BFps=;
        b=DhY4EDNCcl5k16tfu9y6achaclvKAzGYHssOnQqL9OJ8Gc2HziEgsfLKQWCWN+48AH
         oJ0gYexn2emN2Vva/MguBEhXC4LEBm6Ty7IRpeZSfUIUtje+gs93falq7gnkpHWomGa+
         7EVFL6UmjLviwjKS4Px2FDpa7X5yz1xQ7579QovOZxxjoAlm0Rb5yI7h+fUuD3sX4Mt3
         fMw/+5yZ/7uesKQRu9Ent3Eis2w3gaSLy41m0uNdetCnyn4ZGQnHQLsFjjyhqK8C4Hl7
         Fmq4PGJAv5V3xKLdeUByQEQNzd6XCtHT74sS2r9IVIokIieLL8s8l/N5QrXV0pFyImi4
         xqQQ==
X-Gm-Message-State: ACrzQf2QKvCtM9bnTDrs92cPiPSJMnCilNP2NRiUyQ49/FwMYcGimcMf
        7YpF99buUgGuKuja5tQNlchYqY+XyplfWTRw
X-Google-Smtp-Source: AMsMyM76z+ArrodjsY+vLZ+DlKBCAOY6y4xwBmftR2uiJlyzZscotR3jMfVyyrkzSRbKapgoB9B41A==
X-Received: by 2002:a17:902:ce86:b0:182:498f:afdb with SMTP id f6-20020a170902ce8600b00182498fafdbmr30602563plg.12.1666555564908;
        Sun, 23 Oct 2022 13:06:04 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id e13-20020aa798cd000000b0056bc0578c7dsm1130649pfm.110.2022.10.23.13.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 13:06:04 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: remove unnecessary variable in rtw_ap
Date:   Mon, 24 Oct 2022 05:05:32 +0900
Message-Id: <20221023200532.259276-5-tegongkang@gmail.com>
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

Return 0 directly instead of storing it in a variable.
This can prevent cocci warning as follows:

  Unneeded variable: "ret". Return "0" on line 1031

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 24eb8dce9bfe..9eaf345e6a00 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -1020,7 +1020,6 @@ u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
 int rtw_sta_flush(struct adapter *padapter)
 {
 	struct list_head *phead, *plist;
-	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -1028,7 +1027,7 @@ int rtw_sta_flush(struct adapter *padapter)
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
-		return ret;
+		return 0;
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	phead = &pstapriv->asoc_list;
@@ -1051,7 +1050,7 @@ int rtw_sta_flush(struct adapter *padapter)
 
 	associated_clients_update(padapter, true);
 
-	return ret;
+	return 0;
 }
 
 /* called > TSR LEVEL for USB or SDIO Interface*/
-- 
2.34.1

