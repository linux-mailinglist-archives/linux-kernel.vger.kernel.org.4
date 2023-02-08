Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8A68E6DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBHD4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBHD4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:56:44 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40872EC58
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 19:56:43 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id a23so11828468pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 19:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gA/N6WjRUkdpSiAt5NvwWZJ+QdB8myl68ieEPOp24Nk=;
        b=N8W4ieqXIpq1Bxz6LZTNxYRv/8L0q7VMwfWdyePheec0D74XI5lftURogx16F44Gpl
         9vl0ozqhs8ykd0z58bDbGQDxP/e0lw3IzoomivU0BoFKTlcq9AcVIOPAwqCIuPaZEcDn
         QMXIZCkflh3EbQPuXvtMQZ38QKhclF1FYOg+ONKps91GWiVzrsZWopXgGHKgjUezbQAV
         928VlAIVvH0N3wdI8q24DMDtF5ZLPtOpCGmw8pSMuHVx9X+/8QJ1kvs8E/PMAEOG3P1c
         AMFPhc7nD9s2bZrm+GT6b0Mg4KVSFO4m6sJmF4QU89nLqiN7GGJqf+18BH6VmM/SbwW/
         KEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gA/N6WjRUkdpSiAt5NvwWZJ+QdB8myl68ieEPOp24Nk=;
        b=44iDQViSSsz7KuIDBMCWhO0azV1jG7LGzgoqk03aYA0ImMZWk97SC5xsMkVQYt+XbA
         HI7Z1pphpcOQJM2OSuDCkHGkDTqSZiKw976D+dfbU5pR0BcjpxfOZGF2CcpgRjOV5k9s
         psNhFiPIPS7JnpVMqOVoNl1cakCBLuCT8iOUzeBEMckgjhcbb7SDaWp+ZWkmM1Cc8+oG
         VVJT5KcQDbbJUhzunUC9ovPF0b+HaP3WqlcoUggkil/CpQXyFmXuzbim7zWQcpCppwht
         f3c+yGy2Mz+yqJN8VRDAtVi/jDympXdqWQqVpkLQwYxptd8uGBWHncg2mdDU2kT6p4Z4
         SH3g==
X-Gm-Message-State: AO0yUKXmJOb/uIuRCB7duf1aI25K2t4Uuoc9AAQLnhNmSt4+6XmujTbi
        +XWmIaH2sg5Hg9D4koOEya0INaajUneXd9c3
X-Google-Smtp-Source: AK7set/PS7+WlPge4In52ba/wtGCc375ynYUfoSI86XHy9MBfQzs/5+ZBG0Df3yIQbicNBIC2LrJiA==
X-Received: by 2002:a62:a118:0:b0:592:5e1d:8d03 with SMTP id b24-20020a62a118000000b005925e1d8d03mr4963370pff.2.1675828602723;
        Tue, 07 Feb 2023 19:56:42 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id a1-20020aa780c1000000b00592591d1634sm10214560pfn.97.2023.02.07.19.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 19:56:42 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH RESEND] debugfs: update comment of debugfs_rename()
Date:   Wed,  8 Feb 2023 11:56:34 +0800
Message-Id: <20230208035634.58095-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ff9fb72bc077 ("debugfs: return error values,
not NULL") changed return value of debugfs_rename() in
error cases from %NULL to %ERR_PTR(-ERROR), the comment
of debugfs_rename should also be updated so as not to
mislead readers.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
Resend as a separate patch.

 fs/debugfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 2e8e112b1993..58a35afb7c5d 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -802,8 +802,8 @@ EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
  * exist for rename to succeed.
  *
  * This function will return a pointer to old_dentry (which is updated to
- * reflect renaming) if it succeeds. If an error occurs, %NULL will be
- * returned.
+ * reflect renaming) if it succeeds. If an error occurs, %ERR_PTR(-ERROR)
+ * will be returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
-- 
2.20.1

