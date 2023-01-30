Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804566816B0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbjA3QnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjA3Qm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:42:58 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B296A5258
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:42:56 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id m13so311320plx.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TzKgtfEc0ohQa7f3DsZuEWAMUYB0HyYaM3dGsqVSfL8=;
        b=HfF7TWdIKute70ON2In56NdnVrAwUW1HhHyRXuzUXEUsNLFR1PNEFcvXZEAZ8M6/ry
         7WF4DUUYOWUuz3XwDWE3BRmiih+xzZlZNO6azT0o6jdn/dFA4uzV25ipKNUfnHd4hNG5
         7mY4ti4lRtb88MCHPP3y72nalaImLL86noQm7PQZ+0PoJ1hHdMuxUzay8vOAaFpiVCPV
         YePImVqfXqBXc7Ey3BVW3BEUZeAdGjlBFY7gDqQ5W5hnzaswX4y2F1HHl4vHUysHk8nG
         G61KlO9NugINKYbZIxnEM0JkCVNmDXuvHk+xcaEt3fLlxOEdIu376TU4JiOgxR7G4fjp
         rLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzKgtfEc0ohQa7f3DsZuEWAMUYB0HyYaM3dGsqVSfL8=;
        b=DnWoaF8SbXvXMzlXlPW9U7N8Hdtl44VH/QWiBeb4wNSqg/dsrhJmY1BI2IvVARyCAn
         WwhYxGFVfJcsc4KCPnxA9CUlfLmhRYIuBQxphJdZi//G6deJBez86BZDwM7ooG+2jrub
         aqINY0/lH3xnpCeO2e+p3q37LbDznLg1ttlLwDl5dWNKgrnYeJaGMUqTDR3ktKxLczrt
         QKk6kGxfgvhCFyL6evKeW2jINT3pwneKGvX2wbesvhh5Ai0yER6nVgF9e1lO0WseE+3f
         bV61jyMMk+FiGmYvUjIPxu3QjLMf/8aiSfHR6VyndPAr37JU/tcDCxp7/I++XRqommN2
         9wBQ==
X-Gm-Message-State: AFqh2kq4g54mJb6gA6CnZVSu31z1r/E7hmuGRzoV36HKzbXKAI6IFKy2
        7+7rFq1CeJZKfORrIDrYvzk=
X-Google-Smtp-Source: AMrXdXt0JMfIqIJ4CDg+8B2A/00c1B/OlOxBFtRrYz4PzFur1p+kF2G1V1RwdOObxHz3So+FXz56oA==
X-Received: by 2002:a05:6a20:c183:b0:9d:efd3:66df with SMTP id bg3-20020a056a20c18300b0009defd366dfmr55786541pzb.38.1675096976148;
        Mon, 30 Jan 2023 08:42:56 -0800 (PST)
Received: from localhost.localdomain ([112.212.226.173])
        by smtp.gmail.com with ESMTPSA id v25-20020a63b959000000b004b1b9e23790sm6991864pgo.92.2023.01.30.08.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:42:55 -0800 (PST)
From:   Jongwoo Han <jongwooo.han@gmail.com>
To:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        gregkh@linuxfoundation.org, jongwooo.han@gmail.com
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH V2] vc04_services: mmal-vchiq: fix typo in comment
Date:   Tue, 31 Jan 2023 01:42:50 +0900
Message-Id: <20230130164250.51877-1-jongwooo.han@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Correct typo from 'witin' to 'within' in comment.

Signed-off-by: Jongwoo Han <jongwooo.han@gmail.com>
---
PATCH -> PATCH: Add changelog text to commit
PATCH -> V2: Add description of changes from previous version
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 294b184d4..e318f3609 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -245,7 +245,7 @@ static void event_to_host_cb(struct vchiq_mmal_instance *instance,
 /* workqueue scheduled callback
  *
  * we do this because it is important we do not call any other vchiq
- * sync calls from witin the message delivery thread
+ * sync calls from within the message delivery thread
  */
 static void buffer_work_cb(struct work_struct *work)
 {
-- 
2.34.1

