Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD79A74D2CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjGJKF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjGJKEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:04:52 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E0D18C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:01:30 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qzzzp2ZF4zBHXhD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:01:26 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688983286; x=1691575287; bh=PyOOJASrvDlFlpTMrbZnhxWUxwu
        x8onceApx5EockGo=; b=erAgk2mFDIezBF+ARrjyQVU3ouCxKIfFIiChEU88QYf
        Kvx5taEKHPBLhYHe4bF6RfGlzavTrMiXHRV2RiBE67e1gRxTBu2YWS3Umwj5A6+0
        3JrTxDbF4rBwkZNeQA3cCGMFozfjG1X3i+Hdo46+1mkxF9ZiQsKvDh5L5T+JZPFy
        BX++ULdYv3YGFzrcG5YnCDX+dFQbX/+uf1DajfYYtCgydwjhCvbAB5ivAjzNgzVa
        3b3FfMFenBuEAaBc3b1Gj+tAyjWpVGmR0HxchPFcw7jjQarHYEnysqHmBXKJmywC
        EoNGK27XH3MRddWec17UCYlf5G8cKXRKIGqIsvbpEKQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rtmEQlkZnvAS for <linux-kernel@vger.kernel.org>;
        Mon, 10 Jul 2023 18:01:26 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qzzzp0lMvzBHXhC;
        Mon, 10 Jul 2023 18:01:26 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 10 Jul 2023 18:01:26 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/iccsense: do not use assignment in if condition
In-Reply-To: <20230710095957.77430-1-xujianghui@cdjrlc.com>
References: <20230710095957.77430-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7e2e8f69f6faf6a7bb8ecb65c8933f22@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl does not like assignment in if condition

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
index 8f0ccd3664eb..2428f3d6e477 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
@@ -322,7 +322,8 @@ int
  nvkm_iccsense_new_(struct nvkm_device *device, enum nvkm_subdev_type 
type, int inst,
             struct nvkm_iccsense **iccsense)
  {
-    if (!(*iccsense = kzalloc(sizeof(**iccsense), GFP_KERNEL)))
+    *iccsense = kzalloc(sizeof(**iccsense), GFP_KERNEL);
+    if (!*iccsense)
          return -ENOMEM;
      INIT_LIST_HEAD(&(*iccsense)->sensors);
      INIT_LIST_HEAD(&(*iccsense)->rails);
