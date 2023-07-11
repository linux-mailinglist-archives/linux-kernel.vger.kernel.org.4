Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE8974E78B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjGKGuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGKGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:50:42 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02480133
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:50:38 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0Wj1420rzBJJhp
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:50:29 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689058229; x=1691650230; bh=Mhr/DZTGpGUgrvEGl9nknyLxK3w
        3uG2a7YByFHnQioU=; b=MAVoFW2fWXCntprxRj126wKf453QsUPUlibGjwOPx2L
        fM7bdiahF/7NuCFw02sR8hZL6TheimqNlMZJPOrGa8LMH38EA9BwgoyrkiVAVauH
        slx5fDUzaEJpuHimQT+JqtLs5lZjzFZn/FLLKslayuFLP1nTFUE/xd2sy6bXa7tt
        UDR77TG1bIjRl/SeM7LvEU9sTEjOO2VU82tt/9CR5+S47WTfkUfkkqArG753V7WV
        AxiZvaf6UU1z7Hu6n9qTu0o+cLLubLWO9qae1KQUC9Wm68DGd1MhQgEq1wnW+Kzy
        51j50jXd96hIk2TMYFHFHUJJ1MXJcPHGCkrybM1/5sg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DIhrvuEDiKXO for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 14:50:29 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0Wj11PRWzBHXkY;
        Tue, 11 Jul 2023 14:50:29 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 14:50:29 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: add missing spaces after ','
In-Reply-To: <20230711064830.80096-1-xujianghui@cdjrlc.com>
References: <20230711064830.80096-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <df6e832a7ff5ac85ee988e9c4e2e5aa2@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces to clear checkpatch errors.

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nouveau_svm.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c 
b/drivers/gpu/drm/nouveau/nouveau_svm.c
index a74ba8d84ba7..78ea3b541a5b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -75,8 +75,8 @@ struct nouveau_svm {
  #define FAULT_ACCESS_ATOMIC 2
  #define FAULT_ACCESS_PREFETCH 3

-#define SVM_DBG(s,f,a...) NV_DEBUG((s)->drm, "svm: "f"\n", ##a)
-#define SVM_ERR(s,f,a...) NV_WARN((s)->drm, "svm: "f"\n", ##a)
+#define SVM_DBG(s, f, a...) NV_DEBUG((s)->drm, "svm: "f"\n", ##a)
+#define SVM_ERR(s, f, a...) NV_WARN((s)->drm, "svm: "f"\n", ##a)

  struct nouveau_pfnmap_args {
      struct nvif_ioctl_v0 i;
@@ -101,9 +101,9 @@ nouveau_ivmm_find(struct nouveau_svm *svm, u64 inst)
      return NULL;
  }

-#define SVMM_DBG(s,f,a...)                                              
        \
+#define SVMM_DBG(s, f, a...)                                            
          \
      NV_DEBUG((s)->vmm->cli->drm, "svm-%p: "f"\n", (s), ##a)
-#define SVMM_ERR(s,f,a...)                                              
        \
+#define SVMM_ERR(s, f, a...)                                            
          \
      NV_WARN((s)->vmm->cli->drm, "svm-%p: "f"\n", (s), ##a)

  int
