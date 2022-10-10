Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495855FA18F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJJQGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJJQFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:05:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B1A3F1F9;
        Mon, 10 Oct 2022 09:05:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso5102147wmq.0;
        Mon, 10 Oct 2022 09:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trjAJfDM4sD3QR3q36XW//tiTortfpGGfcFfCkbPdgk=;
        b=aZz+xTATYRAHv3sbUmqjEc1KaGm7WfaHyeXapK/g4wCD3QtUNfd9bcl3iM8o+QdMLN
         LbgjjXukeSLLSjUy6EZ4vERSm1q2OgrZzpzYHeyCwP9z7yeWjxRn2ksSNIoAeuMO938I
         PEjCVwzE6p9+mXMsraCC67fq7a9hxFX7dVekTIHeJwe5HFUuMMC4MMWsgWL10qCVs5/0
         Y4NP5YQXJ3IFkW9HeE7Vk5o2i9g6eJa3h3dXbB0qdYtj+yAtQ6pmzcr+u+Nk01tZevny
         0IPPeRQ/pU9pv9r6SwVvDNTSrXZJgpqM7NUCg9kwfF4aroLwYY6NOesYADUo+LF6/D9v
         Sglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trjAJfDM4sD3QR3q36XW//tiTortfpGGfcFfCkbPdgk=;
        b=MXIzLJO/2kt8rrLeqCocVhKSdLoCS96WPs/kBWglghYN20bQMWvbEzRwF3Gpc+1Ki+
         puc2smjeviT9ScB6Vf4err8cey4Tox2tem/ChDS+cg4wHnKqfXKf0IYcrXah48agNj5P
         zH/DcxTOiIJONYmhwOV9ldCoS0L6IZowZfKga1xsCSY4hGnnvnL3E9s2WvWn9w4AMOjW
         GFNl3zieJBcNMNfbREhTmiojROnGPB6yGmBwG32yUnJnhVh31POunXS/0aQAVgXkECYd
         7CtKu7ALN91XSXXfyOlm6IZcEPliam6da9dz1Gl6r24vWMS1BbWYKTbKIWPlOlkQRG3x
         0SUQ==
X-Gm-Message-State: ACrzQf2V0u+akjSvkrAKUtZO4A2XI2Zn1xYu4oCSWff1U5vWqjEKcB+k
        l5xufRLjPtWN91EXaLoKjEU=
X-Google-Smtp-Source: AMsMyM6XvYbi4nXgMHnKV+AQOlW/tSRHrTy24at+PH7IRvBE7XD0YvCJkGHH38Q5Fz4FTm8b5TE5HQ==
X-Received: by 2002:a05:600c:3848:b0:3c4:50b6:30cc with SMTP id s8-20020a05600c384800b003c450b630ccmr9300551wmr.28.1665417917731;
        Mon, 10 Oct 2022 09:05:17 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b0022add371ed2sm9044120wro.55.2022.10.10.09.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:05:17 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] xfs: remove redundant pointer lip
Date:   Mon, 10 Oct 2022 17:05:15 +0100
Message-Id: <20221010160515.3199641-1-colin.i.king@gmail.com>
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

The assignment to pointer lip is not really required, the pointer lip
is redundant and can be removed.

Cleans up clang-scan warning:
warning: Although the value stored to 'lip' is used in the enclosing
expression, the value is never actually read from 'lip'
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: Keep != NULL comparison for stylistic reasons, as suggested by
    Darrick J. Wong
---
 fs/xfs/xfs_trans_ail.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 16fbf2a1144c..87db72758d1f 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -730,11 +730,10 @@ void
 xfs_ail_push_all_sync(
 	struct xfs_ail  *ailp)
 {
-	struct xfs_log_item	*lip;
 	DEFINE_WAIT(wait);
 
 	spin_lock(&ailp->ail_lock);
-	while ((lip = xfs_ail_max(ailp)) != NULL) {
+	while (xfs_ail_max(ailp) != NULL) {
 		prepare_to_wait(&ailp->ail_empty, &wait, TASK_UNINTERRUPTIBLE);
 		wake_up_process(ailp->ail_task);
 		spin_unlock(&ailp->ail_lock);
-- 
2.37.3

