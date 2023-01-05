Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A021B65EDE1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjAENxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjAENwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:52:24 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC92B4FCE2;
        Thu,  5 Jan 2023 05:49:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l26so26467233wme.5;
        Thu, 05 Jan 2023 05:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bqmue4IVqFatViI8XpQVyybV1lzfiwAS2jbePwd+9a0=;
        b=d6Z9iRjcQqcHJxfRtOCb0NLw3YON5YR5Y7kpkplc90SxlklMQHEpSNxYpOgJ+8YGME
         0gUjEY+r8xjfjs6gKn3hJsVqTMBbTQ3wFvUfckgjxgB2hMcYSZMiycL5oryXlbrXfUsO
         LCkUC8Lt24S5o3ZNiKcUMJakBskkmnsG3KFB8cgtpxwfwSao3IpeS/z+IpLVHn83Ksar
         GuB4PZNcY4VmG0uDmzhNbRTHjyTOgnzuiQiITGgHGMq1FG6FDxqG+Wq6h90j23y6NqFM
         RMmNk1MFErAJ3G2geJB2huP6r5H22Maf985KbjG03kOS20pBygfCgytVP+cOWOsCfowW
         lGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bqmue4IVqFatViI8XpQVyybV1lzfiwAS2jbePwd+9a0=;
        b=zMXCroCpxWGCdEkUP7Aj/XfAEiyYnQ5EluYxcP9q0oMLiKo/IjWXZeD33FB6Ky1/oZ
         9NtgJN4p+NNdp9tQSe/5FacnMbQgd3dn+N9moKSHb2FQE6DT5b6Ha/MDNHgMV6CRnWY1
         5g4zy5HG2ZTh59tvgjP7ribSG9qOhPTeCbTQzAWSnxAhUiZkr/iM+nGgAZYP9DK4k/FX
         6qvlFXCN+EExD9Vsc7sXf8Cu8fr420x/jOVOj+SK+s9uUKN8Eq4XnwdDGTvQe5//q1sp
         e3ZbUNmaXreaf4us7tEN2BDfH4HlswmUb0+LGewXxPinRjTgRKW+eiBYOwcHBZrC2FPG
         CLSg==
X-Gm-Message-State: AFqh2kpEj2i+3Vbcs1yqw1X9tzxdApk6eGk8gEXk+0FR7pawvBaPPItx
        rDtAZNWjhhLKVNET0glFz5s=
X-Google-Smtp-Source: AMrXdXsP4DIa6PHnxM36tV2+apGmG7hQVd1JiSkTX6Ref8f8wz06fM0wJeioPSIIJQP8mlYrNZg5dg==
X-Received: by 2002:a05:600c:295:b0:3d2:259f:9061 with SMTP id 21-20020a05600c029500b003d2259f9061mr44513701wmk.34.1672926566787;
        Thu, 05 Jan 2023 05:49:26 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z25-20020a1c4c19000000b003d1e1f421bfsm2478402wmf.10.2023.01.05.05.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:49:26 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jan Kara <jack@suse.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] udf: remove redundant variable netype
Date:   Thu,  5 Jan 2023 13:49:25 +0000
Message-Id: <20230105134925.45599-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
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

The variable netype is assigned a value that is never read, the assignment
is redundant the variable can be removed.

Cleans up clang scan-build warning:
fs/exfat/dir.c:1012:5: warning: Value stored to 'step' is never read

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/udf/truncate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 036ebd892b85..775edaba82ee 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -125,7 +125,7 @@ void udf_discard_prealloc(struct inode *inode)
 	struct kernel_lb_addr eloc;
 	uint32_t elen;
 	uint64_t lbcount = 0;
-	int8_t etype = -1, netype;
+	int8_t etype = -1;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	int bsize = 1 << inode->i_blkbits;
 
@@ -136,7 +136,7 @@ void udf_discard_prealloc(struct inode *inode)
 	epos.block = iinfo->i_location;
 
 	/* Find the last extent in the file */
-	while ((netype = udf_next_aext(inode, &epos, &eloc, &elen, 0)) != -1) {
+	while (udf_next_aext(inode, &epos, &eloc, &elen, 0) != -1) {
 		brelse(prev_epos.bh);
 		prev_epos = epos;
 		if (prev_epos.bh)
-- 
2.30.2

