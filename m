Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB5A672B18
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjARWIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjARWIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:08:37 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE24465EEE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:08:34 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qx13so810736ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSZwz/ZTlMLiExcToVQuiT8oFan8UFZmwdNwvgwFSac=;
        b=RPs3G3yaRI38mu07PInL0zlQ4NpGuyeOd3fENbN9pdSeXncTIqPXNQHPKRy43JB/3F
         zfzkVqE0QVBsy8LjVOHmjjAqLmgoK+MDJli+sLeVBMD5q+noCwt/eJobexdY3Uv/VhIa
         cQHD0JA1Ge+yBrnhJsQla+FqEyUj7QEivoRy7eO6OKDvBpO5Xvve6Tu0V8Zts+Um0wFa
         gzFr5iM6+8IIWtDwn05AH5E1gKesFcaoud5gaefMVL1OXGhuoTFSEmaTlSFIxmjp6BKj
         YMuQWoJcYYD8/ju8uYn2z9j3P/6U2/M4GTXrLFowclwee6G+z4kf4mNp/pdAXKJFcvRl
         eG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSZwz/ZTlMLiExcToVQuiT8oFan8UFZmwdNwvgwFSac=;
        b=YaA921VTIMwUPLKGkMcelDsEVPevRsHLND89sEbBwVJ5lei6D2EANmnYsmjE2inm6j
         XrL1g3hug1kZhppnqggLGTERqyAv+0zwflhBTDemyEEwoHr/Co4+NZoJJzZAQtXc7Tu1
         HvFOU2zzBwCchQsQB8fDFmyMHqimRhymxKYxEDzB3gcltzIGkqMX5rSf3zxgkwMW6y/7
         N/FOg/N3ZW8OkUap+mTFWwVx1Muv+cPedcxYoUWBaGsFEWyen4XMO5XnzGyHyy1d/sP8
         O9uIq+Y18CLBeVK4l/P7rKGck6+zKbZJcDcnXlrqe1xgZQgP9qa857OKpGDJPVtfaXR+
         Loyw==
X-Gm-Message-State: AFqh2kpQe9HqDAx89VAeN8DAfo1xjnETCsVC301WIOc4I89nMVNygd7o
        IA7xU+c6bnMFmRacKSNMRrJJkdyDtbg=
X-Google-Smtp-Source: AMrXdXuoP9buq/9xeOZMQrDs8wmC3sV3DPSD3AnBMCB6t4asRU/ZI9mXB+wJrwJWBOLVCWsYuz3trg==
X-Received: by 2002:a17:906:95d2:b0:7c1:37:6d5e with SMTP id n18-20020a17090695d200b007c100376d5emr8257533ejy.2.1674079713014;
        Wed, 18 Jan 2023 14:08:33 -0800 (PST)
Received: from Semens-MBP.fritz.box (84-87-100-184.fixed.kpn.net. [84.87.100.184])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906308e00b0084d3acda5fasm13718704ejv.189.2023.01.18.14.08.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Jan 2023 14:08:32 -0800 (PST)
From:   Semen Zhydenko <semen.zhydenko@gmail.com>
To:     linux-kernel@vger.kernel.org, bagasdotme@gmail.com
Cc:     Semen Zhydenko <semen.zhydenko@gmail.com>
Subject: [PATCH] Fixed typo in comments
Date:   Wed, 18 Jan 2023 23:08:28 +0100
Message-Id: <20230118220828.85115-1-semen.zhydenko@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230116222254.74479-1-semen.zhydenko@gmail.com>
References: <20230116222254.74479-1-semen.zhydenko@gmail.com>
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

To change one typo in kernel/time/timer.c
Typo is "aquisition" proper spelling should be "acquisition".

Signed-off-by: Semen Zhydenko <semen.zhydenko@gmail.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..6430c00b05a9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1324,7 +1324,7 @@ static int __timer_delete(struct timer_list *timer, bool shutdown)
 	 * If @shutdown is set then the lock has to be taken whether the
 	 * timer is pending or not to protect against a concurrent rearm
 	 * which might hit between the lockless pending check and the lock
-	 * aquisition. By taking the lock it is ensured that such a newly
+	 * acquisition. By taking the lock it is ensured that such a newly
 	 * enqueued timer is dequeued and cannot end up with
 	 * timer->function == NULL in the expiry code.
 	 *
--
2.37.1 (Apple Git-137.1)
