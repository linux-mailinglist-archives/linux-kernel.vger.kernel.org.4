Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67476E799C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjDSMWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjDSMW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:22:27 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D69E173B;
        Wed, 19 Apr 2023 05:22:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n17so12541377pln.8;
        Wed, 19 Apr 2023 05:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681906943; x=1684498943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cvi/8BFVMUmJHt4WjuHDaXoszJBRcvvbnSWyynNb4dw=;
        b=M3A9a6WtOWXdYHHcfybW8ymSEnpEjD5R0HfAB1fZbrJ4eb18z3BbaIQkiZch+E3XFN
         gtImBttegWoB8LCoLFNJDhiiSl267YU1V1Nsc33I4Y18p03z0gGfjf/VdKUhfjZcBXD5
         aq+woQSFxs2Vu2JdQq610eO1TMJ0DviQoiqjfPoAGc/JAkBZ7fiCJzgpbt/FhH5BE7Zm
         0vjqLsxUHKPd4lYUtp5GXOSKExiXmujz3dv9bAp68j4aoXlww1GZg/PJ3faT06bwcuTO
         4QQaNsK1vvXfQuNxUKLhbD5rkeXzfHeIk527XpKrudr38a8q5hrfpyRQWEWtLb0bfx1u
         1w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681906943; x=1684498943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cvi/8BFVMUmJHt4WjuHDaXoszJBRcvvbnSWyynNb4dw=;
        b=dEL2psCi52nerBPpJYJmIxPgx4rE5Yxnrg5tG/AJ3kCpo6QcLIvlAl4Qh1n/O4ovt9
         yKThd1Cx0Ae/te8Bnkd4XqAe3E/DkA6tEhs7tC3tuNhjN48zvS/ajx87dI/H4aNVPfyA
         Jtdg9UzInBsY4/ZbO/e6OBQ7P2FkVNZRM1spev9goItJg0WXf5zblHh/jog3ftH+wgvm
         NltPyCTgp/TbHPKgd+aGZjpBc9mFMtfa1cl1u14B91ZPj35pYmJsXF8DSw4fkW4fydAx
         6RSeuCPzrxkwHtN65SWU9lb67PIoNCNEHu/9+CpW8u/f9CdHgr8I7L2+EQU1D0x7MEmp
         H51Q==
X-Gm-Message-State: AAQBX9c4EgsfXqzZqB08brvB89AOzmR2lw54/nYnoldFZW3jJHFme5yB
        wtszhiHzQYdlkzoG+nEz+zs=
X-Google-Smtp-Source: AKy350YunIiQ3rSxoOx6P/gwromJ6KqxNFKy+BHVTeuXJi6xVHlbz9D1gBHrAJqbGAdA5qNa2rmVAg==
X-Received: by 2002:a05:6a20:3d1a:b0:ee:7694:f069 with SMTP id y26-20020a056a203d1a00b000ee7694f069mr3643470pzi.41.1681906942789;
        Wed, 19 Apr 2023 05:22:22 -0700 (PDT)
Received: from hackyzh-virtual-machine.localdomain ([112.64.53.154])
        by smtp.gmail.com with ESMTPSA id ft2-20020a17090b0f8200b002471f34d5ddsm1279106pjb.55.2023.04.19.05.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 05:22:22 -0700 (PDT)
From:   hackyzh002 <hackyzh002@gmail.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, hackyzh002 <hackyzh002@gmail.com>
Subject: [PATCH V3 1/2] drm/radeon: Fix integer overflow in radeon_cs_parser_init
Date:   Wed, 19 Apr 2023 20:20:58 +0800
Message-Id: <20230419122058.3420-1-hackyzh002@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of size is unsigned, if size is 0x40000000, there will be an
integer overflow, size will be zero after size *= sizeof(uint32_t),
will cause uninitialized memory to be referenced later

Signed-off-by: hackyzh002 <hackyzh002@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index 46a27ebf4..a6700d727 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -270,7 +270,8 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p, void *data)
 {
 	struct drm_radeon_cs *cs = data;
 	uint64_t *chunk_array_ptr;
-	unsigned size, i;
+	u64 size;
+	unsigned i;
 	u32 ring = RADEON_CS_RING_GFX;
 	s32 priority = 0;
 
-- 
2.34.1

