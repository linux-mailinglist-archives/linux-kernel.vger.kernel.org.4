Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A143D64F964
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 15:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLQOb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 09:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLQObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:31:23 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A819210F3;
        Sat, 17 Dec 2022 06:31:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s7so4998581plk.5;
        Sat, 17 Dec 2022 06:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q+7z7G254vlB30dxaX0Fo49gLNLsS7YJkR6iYNb6Fv0=;
        b=jvKehRiQgyKNh+iZ6HY/I2oEgNq6qt40AhQ2jM/Y+rqzjAHIOXlTqvFfVR6mMnSKBe
         g+3jV0bE1trLAS5HzhOIn3fss/Gaq/oe8RqAx2gFE9Opvj3mueiQUpkXEZAajeDViw8g
         uJbOdK7pSMRmSM7O8VwSpdCfu3NiOcZSfhTEP2Lwt8GTGkixZcx+N0Jg8W8j6SLz82w3
         5+9RtPUTBfxRVfpzyN5GGh65zVcKYc436J9IQsYbcaRN2hfq4IvH+bfK/jI27jtegKpG
         XoqKkQ/NNZaiUdKLxybsDD/KSBIESlxpoErfdLKF9JDp7z7jV/usnSm21v/QNv8Q3APy
         35Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+7z7G254vlB30dxaX0Fo49gLNLsS7YJkR6iYNb6Fv0=;
        b=q0pSD/VwlY3U09gM+3UDZuM0k7T8KAy0iE4gP3TPEW1mcWVc8V4mt3dHLrt9k4770b
         0K3PzZDORCTXy+dUbV1DWsmjGeTnGj2Gvy8rBG/QPClNKPTkN+uRAEoOsRIkXYsoe5Pv
         2yAVySqzu8WlvbPPMICZH3v2s/xeq8HqH0Y3VoUNRcysgtLu3CPp+R6DFPIrW/YzQqyy
         eE4HKZO3Q3EEV79eBYsLpeX0GILE8CIsAmjE4eifgOI32aKCLFrsTDUgDA0/dJD3HhQ+
         sFVzvKdsg8l3RIB9bUBhYUuTEP85hHh13HKy8IlPhbZ/8iff6goBP8B24VY3I99m7/lS
         JWhg==
X-Gm-Message-State: ANoB5pktOou/Ft4Rl5Y2Jm9UhSv7u7s0MZPOVvsbatwVq2b9Tf7HNub2
        pk9t8Ype7WW9ci8XAEq4rJ9jkrKe95PhzQqB
X-Google-Smtp-Source: AA0mqf7WuudQT1xddyeqQk434g8azUldw7NaCX+6Q4guEXQQLo3/7D/ckgw31nmL76Sgsl3BamUJKg==
X-Received: by 2002:a17:90b:198e:b0:219:cb6d:7b0b with SMTP id mv14-20020a17090b198e00b00219cb6d7b0bmr36174776pjb.44.1671287482118;
        Sat, 17 Dec 2022 06:31:22 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id fy16-20020a17090b021000b00218b47be793sm2999708pjb.3.2022.12.17.06.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 06:31:21 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] media: mc: entity: Fix doc for media_graph_walk_init
Date:   Sat, 17 Dec 2022 18:31:13 +0400
Message-Id: <20221217143113.3219104-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no media_graph_walk_free(). media_graph_walk_cleanup() is used
to release the resources.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/media/mc/mc-entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index b8bcbc734eaf..de25de328fbe 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -295,7 +295,7 @@ static struct media_entity *stack_pop(struct media_graph *graph)
  *
  * Reserve resources for graph walk in media device's current
  * state. The memory must be released using
- * media_graph_walk_free().
+ * media_graph_walk_cleanup().
  *
  * Returns error on failure, zero on success.
  */
-- 
2.25.1

