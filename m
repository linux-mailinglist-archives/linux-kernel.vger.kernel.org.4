Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503BE6540AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiLVMF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiLVME7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:04:59 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D1E2CC98;
        Thu, 22 Dec 2022 03:57:01 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fy4so1716470pjb.0;
        Thu, 22 Dec 2022 03:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMORqLHaJNiKFpIU708RV2HeHLpSanu3/u3B3wpsHh4=;
        b=Ww3yzlXRTqHEfX8Cx1nfzdbTxcThOFZiKmyx1nHB2jRMe553cgt5oN0G+OH+yyLQQL
         nZ2pv1ubZBTYde02ycOWEApMkxWdsotrh3STOy1UrGguz/Et6KuyJtzvnhmWKA8DGZgR
         Zti01iAYu5StoPb/JHEFJw1kRU1/dsse8sjMxsnZlAAuqgKBOf7A05zCwxswFOqhFpqR
         euaFH8Ige5AtUMDzGKcm6kAyZNe/csTicmxMWZVealZ09PDWxZD+HBrRH6U3gOFj5yqc
         Jpk0ecTZ2Sx1iUtyNG3QJhmzhqE45oExF1vvCpzdis57qDNjHFZR4UTG04S8lNmfu465
         fmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMORqLHaJNiKFpIU708RV2HeHLpSanu3/u3B3wpsHh4=;
        b=KlbWt/KNT/CczCsc9hl566RAv0iPlOdJqi275NuVKqwgudBMP2DIOAaMk1pm7YHxOx
         r1vs3TmuGNt0IUONaasZgZ/USOeMPp9HEe9N5wN0XV51795iCvxYc2hn/tO46Mh9HUEZ
         8icVbBkRmRsoEUeq7zWk8mkmawqe7lNYhx82l5B2yH2G7UQHB8uXHLufiSqa2mWhNCtu
         CxyA7OhHcCg4Lz0M/q5kUnSyWYGtzUPBYhXlIs7lV3EYKJiF8YZXGgVRyWfO9PRKs+2b
         duyhu2s4QyjAShmlFAgKZKWbp1Jtrv+BWVcv5fmAzdiRerCO/fPsHlSTBNiMIiFJMsKV
         NZbA==
X-Gm-Message-State: AFqh2kr5IeOoYvUus+0EDQu4tYDzHzDqrYz9E81pk0lHOTE/TimTUJZy
        p4VrKzC1DacoorabZVpDLpPhHDRNIb0EryZy
X-Google-Smtp-Source: AMrXdXutogHqURsgfBye5j0pBDC9z0eykgBW24cmq1jxTm+DB3swrvOFRlaqRc4i1cOwfE07j+n3/g==
X-Received: by 2002:a17:902:b7ca:b0:192:4904:af98 with SMTP id v10-20020a170902b7ca00b001924904af98mr4690375plz.58.1671710206122;
        Thu, 22 Dec 2022 03:56:46 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id m11-20020a170902d18b00b00172951ddb12sm401694plb.42.2022.12.22.03.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 03:56:45 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] media: v4l2-ctrls: Fix doc for v4l2_ctrl_request_hdl_find
Date:   Thu, 22 Dec 2022 15:56:37 +0400
Message-Id: <20221222115638.768143-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should call v4l2_ctrl_request_hdl_put() instead of
v4l2_ctrl_request_put_hdl(). Fix the typo.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 include/media/v4l2-ctrls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index e59d9a234631..7788eeb3e2bb 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -1343,7 +1343,7 @@ void v4l2_ctrl_request_complete(struct media_request *req,
  * @parent: The parent control handler ('priv' in media_request_object_find())
  *
  * This function finds the control handler in the request. It may return
- * NULL if not found. When done, you must call v4l2_ctrl_request_put_hdl()
+ * NULL if not found. When done, you must call v4l2_ctrl_request_hdl_put()
  * with the returned handler pointer.
  *
  * If the request is not in state VALIDATING or QUEUED, then this function
-- 
2.25.1

