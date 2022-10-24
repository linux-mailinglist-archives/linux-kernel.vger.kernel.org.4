Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2423A609D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiJXIuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiJXIt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:49:56 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0F523167
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:49:45 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id p127so10133390oih.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dikvD5+bFGXRs81xXMLBNykCJfKHBwW8mLASTTcU7RI=;
        b=Eyb1XzP245evTp1QRz4N5vez7+pwTB8t0DRShOyMY8LQOTZrVNt36tLRMwwU3Vm1KJ
         mcEDAMNV3LTJzC3XHcK4KvzmLLg2Pem3T6vzJxdfK7b1Qu4mhtpHlh+c+lfDLO/GcpnU
         pJ6zUcoqq4Ed5pf7l3WrEXfbGurZHkcgMxXtfg1LPJ6SHp39C3erHSTEskXfxfn8lARA
         pyzPirhfCxKF3kplc2xAD4rgJoX8LpeMG1v+t15LegwG+q7Iau408lyfXqi0fswOzGpX
         565KECnxNzF1mp0fgngifBUWFltsFatVYHI6/Yhh+o24eVXl616jqcUyNRNWG0BBguO7
         QT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dikvD5+bFGXRs81xXMLBNykCJfKHBwW8mLASTTcU7RI=;
        b=KvLOYsB+mjamaBKcF1rC5eKIq1wk9eGUgHFItSLUObaSSfZAp0lkvzSP8eojks3d/V
         V+Sa0jzGuVJZxsATTF7EwYjID7mnRQrJVwBEjCK0hQtG68xZlfhbmxqWk7wFIdyjip8j
         T0jqTDAhfqJS9/zgpv2NsLt2hQAaTNpfwwqlWa34ktodXSU7lr7UC9h4UYZRAmDyf4De
         yLVn5pGY6YRnr22xSuKDbQqLbTpt1IwN8ibuipPyDFBl2iElAnHSI2KC08seL9MBMmPg
         zkyaB0g+XlWnqF8//CIcJBA6OAN9vvuE9TrLlATkw9gqscfDBm+AJLJTy05mtJIS53lj
         +MgA==
X-Gm-Message-State: ACrzQf1uOlsUcL+PVeuxRu/DGjfqbVPsT/UxaNbDq5Cq97pTEnhJs5dk
        50Xr8Hmdc4myfQrHIwZeKfM7sDHLxOXG1cuw
X-Google-Smtp-Source: AMsMyM4+1oC9yP2SuFdweGgP7rQZsd/xjzk/U2nzMAcrDmUkwtFQBY/825AEFbphUE6jPrYYkxOvyw==
X-Received: by 2002:a17:90b:4c52:b0:20d:7917:4cb3 with SMTP id np18-20020a17090b4c5200b0020d79174cb3mr73052031pjb.6.1666601374768;
        Mon, 24 Oct 2022 01:49:34 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id r2-20020a63a542000000b00434e1d3b2ecsm17245124pgu.79.2022.10.24.01.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 01:49:34 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v2 1/4] staging: r8188eu: remove unnecessary variable in ioctl_linux
Date:   Mon, 24 Oct 2022 17:49:22 +0900
Message-Id: <20221024084925.262289-2-tegongkang@gmail.com>
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

Returning value 0 directly instead of storing it in variable ret.
This commit can prevent cocci warning as follows:

  Unneeded variable: "ret". Return "0" on line 3030

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 2de2e1e32738..5e1ad7733127 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2979,8 +2979,6 @@ static int rtw_p2p_set(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
-
 	if (!memcmp(extra, "enable =", 7)) {
 		rtw_wext_p2p_enable(dev, info, wrqu, &extra[7]);
 	} else if (!memcmp(extra, "setDN =", 6)) {
@@ -3027,7 +3025,7 @@ static int rtw_p2p_set(struct net_device *dev,
 		rtw_p2p_set_persistent(dev, info, wrqu, &extra[11]);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get2(struct net_device *dev,
-- 
2.34.1

