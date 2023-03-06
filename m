Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9915C6ABB09
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCFKJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCFKJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:09:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFC7222F1;
        Mon,  6 Mar 2023 02:09:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B85C60DCB;
        Mon,  6 Mar 2023 10:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14371C43445;
        Mon,  6 Mar 2023 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678097359;
        bh=b151yW+qXdaWwZr+uJKZCMaPRLko8VNYQPQR6bpEA/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkpNJJsthW0e/lsNOja6kI178cQAVWSxRPwJbe7ITZtDKyFNkVC0OwHWMoVq1Wi0/
         6BhvtipTNV0HHiROwWY7E6EaLKiedZoxV5zlzzNs+mTHAFkuVN893iP1O1K3GJyQi3
         VlDEVI45ff/2yTwyIrpuD1Tfri98WoFyyXeAOX3BuAIEnjdNndeb3RomSmR4iN+H0h
         DZqR399MX86QV7gYtONI5PdqJPsG/oNlxMkNCPfW/rjAy8xuXXsjhptPYN9LBxpLwj
         8U8gU8Q3afvyLi+8J8FOETfZGBBNWhLBbdqD43+0DIIfW9sexuM+hjmIafGEedRj7D
         n9PhgmHrzhLIg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZ7n5-0007R0-Q4; Mon, 06 Mar 2023 11:09:59 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 10/10] drm/msm: move include directive
Date:   Mon,  6 Mar 2023 11:07:22 +0100
Message-Id: <20230306100722.28485-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306100722.28485-1-johan+linaro@kernel.org>
References: <20230306100722.28485-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the include of of_address.h to the top of the file where it
belongs.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ade17947d1e5..42ae7575622b 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -8,6 +8,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/fault-inject.h>
 #include <linux/kthread.h>
+#include <linux/of_address.h>
 #include <linux/sched/mm.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/sched/types.h>
@@ -272,8 +273,6 @@ static int msm_drm_uninit(struct device *dev)
 	return 0;
 }
 
-#include <linux/of_address.h>
-
 struct msm_gem_address_space *msm_kms_init_aspace(struct drm_device *dev)
 {
 	struct msm_gem_address_space *aspace;
-- 
2.39.2

