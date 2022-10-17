Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8A3601B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJQV4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJQV4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:56:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6BC3C16D;
        Mon, 17 Oct 2022 14:56:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b4so20633163wrs.1;
        Mon, 17 Oct 2022 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bls0sFpMHM96G1RM5fg41i/BvVUOqCU47KqAcUa9dcc=;
        b=ECZW/PtHmPPhkVHfY/7jTcXy6fpoZT9bkKVg4IWJ6CeC7iRr/Lb9rr3w1+1qj9Wb2b
         f87r+9s9E1mhdS3mlsEf5JsaJYyjmKt0UYuu/0GWxCxol2yif0IKwnPy8bOqW00K+huQ
         lRRW7Wnfp+UG5WHVDrdmnYZ8Wg9fO8Q1dAwv/+kdJTgKZWBrYTihsuYNmQvYre+3DOIy
         SVGWjRRgbvJ7kfUknB9yHTNETyOtMCZtd1lPtfooZnpn+887i3WdgoSeZHZpriSN+CYx
         bpqNN59WyWYdCucbpgGoy6gfLoxSfyavkkMmliJPNuuj4CoZWHH7lgEe1fBu+GH/Q+cm
         siKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bls0sFpMHM96G1RM5fg41i/BvVUOqCU47KqAcUa9dcc=;
        b=cXS9BLJ43srEC/BH2x+dTCr+HuL1WaPSBoWM7OK9OKe9+7rwvvp5jotLSspLbCb8Dg
         jUDGv55ZNbnLoCcNgJ1yBOTspRt6fgw70WWUbNtVM9hMWKdjInOvxdHma5qUuKV9sKma
         VdR2pHWymaRbEYUpHZaiCyVuhbeoRXJwH6ysZjhwxHWUz3DPsiZDBJWd6OfAdBxIMdrm
         IX7Jfaj+CdIU6JNPaPQWbp95yxFeoJpQNkFnr8HD2Rrbv6HTHRgbJ2VntwqyBvfA9/qZ
         eSBW4bXI5NBCdvC98tlj7ewBirOkVtuIwU/ePsg4kULjoFYoIsNU81WGeAChQpSG2CwF
         /r8w==
X-Gm-Message-State: ACrzQf3rKyrvz2zZPxKGtFc5htJ5znWf97KPyImu5BwomNsy+zfi7oq4
        XIeTHFch20pAm5vnO/TJR1Q=
X-Google-Smtp-Source: AMsMyM41tOCu+UuZ3B9X1THbfx5NNSWRkRxZ9rrx6c7KKw+tpCuM0Qbcxh0B2I48sdzKqlzwgoNALg==
X-Received: by 2002:adf:fbc7:0:b0:220:6004:18ca with SMTP id d7-20020adffbc7000000b00220600418camr7178363wrs.632.1666043797270;
        Mon, 17 Oct 2022 14:56:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b0022860e8ae7csm9203528wrv.77.2022.10.17.14.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 14:56:36 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] jfs: remove redundant assignments to ipaimap and ipaimap2
Date:   Mon, 17 Oct 2022 22:56:36 +0100
Message-Id: <20221017215636.863916-1-colin.i.king@gmail.com>
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

The pointers ipaimap and ipaimap2 are initialized with values that are
never read, they are re-assigned later when they are required. The
initializations are redundant and can be removed.

Cleans up two clang scan build warnings:
fs/jfs/jfs_umount.c:42:16: warning: Value stored to 'ipaimap' during
its initialization is never read [deadcode.DeadStores]

fs/jfs/jfs_umount.c:43:16: warning: Value stored to 'ipaimap2' during
its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/jfs/jfs_umount.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
index 3e8b13e6aa01..cc4d7e6e8a4b 100644
--- a/fs/jfs/jfs_umount.c
+++ b/fs/jfs/jfs_umount.c
@@ -39,8 +39,8 @@ int jfs_umount(struct super_block *sb)
 	struct jfs_sb_info *sbi = JFS_SBI(sb);
 	struct inode *ipbmap = sbi->ipbmap;
 	struct inode *ipimap = sbi->ipimap;
-	struct inode *ipaimap = sbi->ipaimap;
-	struct inode *ipaimap2 = sbi->ipaimap2;
+	struct inode *ipaimap;
+	struct inode *ipaimap2;
 	struct jfs_log *log;
 	int rc = 0;
 
-- 
2.37.3

