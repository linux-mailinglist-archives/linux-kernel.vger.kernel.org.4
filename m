Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18F172B8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjFLHfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjFLHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:34:56 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213B4170B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:32:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6549df4321aso4168809b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686554909; x=1689146909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ihg0r6NNHpPPCqrWno7mABOyOIjyqCDVNKZnVfGiSQ=;
        b=Qk3VyjI3CKicegm6uDWXnbLj7tZZ2bls/tOCAo6NQf+gi+UzVnrvQxssIqLKJ/2P91
         VLTX7VeYnHwtG3mQTI0GlAxFucOh7hiX1KnoJk8AInXaSFuNtZOWgsLTZq2S02SrzX9J
         1nCNNpGPxoGqA77nLj/T2OVXxJqdYMfCvE49AkrBYqt1bePJlzE1e45ESFB7RBfNgQ4n
         QN8Qp+QtWHytAx2ac9NFHLJejOVbZ0ZHt172jYle3oKrBRzvpZQzvg/PKjRPaOpqSEQd
         SjeMpa2dPjl3hcLJUaKbpo+S9vGutDUqczGlijx52lci2Yt3ZDc73Q1j4AYUseXZh6q0
         s4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686554909; x=1689146909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ihg0r6NNHpPPCqrWno7mABOyOIjyqCDVNKZnVfGiSQ=;
        b=S8SHBJPRyBXwV0l6JDc4ChznrEx0DkyjldaCs8pOtnfgrg2++e2OR/XmPZqUGp2Ft3
         5ddcRbw5JfzP6+K00fdKNP0O4l5hnX9yfmmLridrMnaWoNYXbYISf87cIRKxO/YjiAoa
         TMqjjT/9YxBRHPMZvRuIrIINverrb+GTrL5lZbEYJWb9J0gSP3g7tki/DbxeQ8oCRAiv
         3zO/yq1w9UBIeK8Suyw98zHita+KRRA8U99HCMdNcd1rm6sM5D0JILYXu4z5hwYBDe/2
         wWOW3aA37TSyCx9BQ+cd1ap6StEzjxQiJGSpvxuuwfXPx++PbvTbzwabmRSfLPi2MW9p
         fATg==
X-Gm-Message-State: AC+VfDx8wSmRBPDULFaQXTvH1BGPGUoTj8dR+UIrP4Xp48lCOFqkK4Nf
        KREiaU5JHygCi3/+8Vs5F7ldAUa3DZ7teEI6
X-Google-Smtp-Source: ACHHUZ71vbS0qgIXbggQlEJuurlbRK+GucpYkExMpQiKS8W/K1u6hB/A2PvbMNWq0so+/lFroUw79Q==
X-Received: by 2002:a05:6a00:2195:b0:654:100f:c003 with SMTP id h21-20020a056a00219500b00654100fc003mr10429585pfi.6.1686554482409;
        Mon, 12 Jun 2023 00:21:22 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.112])
        by smtp.gmail.com with ESMTPSA id z3-20020aa785c3000000b0064fe9862ec2sm6272580pfn.116.2023.06.12.00.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 00:21:21 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     jaharkes@cs.cmu.edu
Cc:     coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
        Tuo Li <islituo@gmail.com>, BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] coda: fix possible data race around sb->s_fs_info access
Date:   Mon, 12 Jun 2023 15:21:01 +0800
Message-Id: <20230612072101.2923400-1-islituo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct field s_fs_info is often protected by the lock vc_mutex when is 
accessed. Here is an example in coda_put_super():

  mutex_lock(&vcp->vc_mutex);
  vcp->vc_sb = NULL;
  sb->s_fs_info = NULL;
  mutex_unlock(&vcp->vc_mutex);

However, sb->s_fs_info is accessed after the lock vc->vc_mutex is unlocked 
in coda_fill_super()

  vc->vc_sb = sb;
  mutex_unlock(&vc->vc_mutex);

  sb->s_fs_info = vc;

And thus can cause a data race when another thread access sb->s_fs_info 
concurrently.

To fix this possible data race, the instruction to unlock vc->vc_mutex is 
moved in front of the access to sb->s_fs_info.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 fs/coda/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index d661e6cf17ac..743030ec5ef6 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -179,9 +179,9 @@ static int coda_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	vc->vc_sb = sb;
+	sb->s_fs_info = vc;
 	mutex_unlock(&vc->vc_mutex);
 
-	sb->s_fs_info = vc;
 	sb->s_flags |= SB_NOATIME;
 	sb->s_blocksize = 4096;	/* XXXXX  what do we put here?? */
 	sb->s_blocksize_bits = 12;
-- 
2.34.1

