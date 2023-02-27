Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E966A3BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjB0IHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0IHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:07:42 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A4B1515F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:07:40 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id i5so4170364pla.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJSGu/qfXmePZHGIW6fcFPW2ne2Dxi7qJibeVZWzM+Q=;
        b=QNGQKjqgskthvc9hYlPhzydoFh1K9pgDgl2dh41qT5tbRbMMxjHn1D2MxBTQuj50bK
         3z0EHLS3S4bI1u2wOe6EBLVr3bBANgoD1VOqw5PtZ39+4ZSzy8XkYErBr7qJO/uWJmSm
         9mZVhFHJvNo4nhery5shj6UrSe4vH5wb98aoi8s8DDbCfwpQ6lN1bO+piDQ5M/Ew8MIM
         JtUt1/BOqqyvMsXZ4m75fQofhjOy+u5v/KiS6CUcDtZ/VSIvRyzsJWC5rN1zCGBErOyx
         cyqHbUKoavROyy5GB4z5T4HDF78yphOeOgD5xRpP2yCMw7lOsrMjGBXHM6BD4QkyJU+2
         F3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJSGu/qfXmePZHGIW6fcFPW2ne2Dxi7qJibeVZWzM+Q=;
        b=L2INechb8/WnqD0D7I+WqsJO2h+haUNvhTw99txW7ux6GVOfVb2gPaHF4EeE3zA8Nv
         bRfEJbmy6ae7IOmhccc6+22JiX/bNJ/hk0t2TNyVAxkUA2zuMoMUgdQuPXwnPaiWGQqW
         hDRkQi41Yr363HRaiFnc4JZTWcgfqHjJmYGGeKK3JGnJuCcn9WTodF3vKu+MlPZxXMk/
         Ur39ypos5mPH0Oh1ikt7sc8mGUCqB7VtbQbgm8sz2jsdh4JuycC36RgK8QOpKSmllhjX
         mRfypxP1Yqe6bszCtmWKUfTxZHS44qlgZ/xICG+x4kp4d01KhjYX2vlP5rdoxaMMgFqG
         Ixgw==
X-Gm-Message-State: AO0yUKUk4L1Mdn8lRKTCV+YiLh5EelOyNFuUF2RvB0r/pgTJOqb8B4lp
        3J+i1W5TNWFPLK2phdvzD5FsraqegMxi55PFgo8=
X-Google-Smtp-Source: AK7set8Tnv5QS89mQ4cHLKfP13uuw/lZ9G9LtRhzDeDPUkY7QOpPB+ji0DRWw/DYKFp6O7VBcDb2hQ==
X-Received: by 2002:a17:902:b597:b0:19c:ac96:1dce with SMTP id a23-20020a170902b59700b0019cac961dcemr13605200pls.48.1677485259851;
        Mon, 27 Feb 2023 00:07:39 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id z19-20020a170902ee1300b0019cc88bee09sm3951109plb.58.2023.02.27.00.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 00:07:39 -0800 (PST)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     longman@redhat.com
Cc:     lizefan.x@bytedance.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] cpuset: Remove unused cpuset_node_allowed
Date:   Mon, 27 Feb 2023 08:07:19 +0000
Message-Id: <20230227080719.20280-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 002f290627c2 ("cpuset: use static key better and convert to new API")
has used __cpuset_node_allowed instead of cpuset_node_allowed to check
whether we can allocate on a memory node. Now this function isn't used by
anyone, so we can remove it safely.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 include/linux/cpuset.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d58e0476ee8e..7fad5afe3bba 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -82,13 +82,6 @@ int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
 
 extern bool __cpuset_node_allowed(int node, gfp_t gfp_mask);
 
-static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
-{
-	if (cpusets_enabled())
-		return __cpuset_node_allowed(node, gfp_mask);
-	return true;
-}
-
 static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 {
 	return __cpuset_node_allowed(zone_to_nid(z), gfp_mask);
@@ -223,11 +216,6 @@ static inline int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
 	return 1;
 }
 
-static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
-{
-	return true;
-}
-
 static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
 {
 	return true;
-- 
2.25.1

