Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B196E7240
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjDSEYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDSEYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:24:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D920A1705;
        Tue, 18 Apr 2023 21:24:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-51f597c97c5so1115044a12.0;
        Tue, 18 Apr 2023 21:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681878276; x=1684470276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRDCjTOkWMGElxrmUMljuv7R6aYKvTg/GiQ2WWUQLjA=;
        b=P5QTikUGscbdQb7TFjUgKjgzxn/e9+eeyH2qxNQSgYuuAoEj9snd9v+RzKmYKdaFYB
         Z/F/DpJQo7e8vEFO5QQAdNK5pRF0eVSc2Z3LToHwQitYaPnV9WaYhsT+3QPwbYhyhWOo
         LLd698154Ty28I+Z3s6QzAars6oTGXtMF7Mwz23ALjlPE+FLwQNJQD57d2bRIjRKQo5K
         /eSJRxR5Num3TxuE6t60Tjk67JJ/vq5KGCBAlfuitq8wGNFR2BDk07PJ23mAZyYwBO0C
         /IzcPoTQ+SQ5jhA4iU8jpMFsg82p0U9KavFJC2lv3+aIkursUeNhKZ+71h5Piq67P6Qi
         338g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681878276; x=1684470276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRDCjTOkWMGElxrmUMljuv7R6aYKvTg/GiQ2WWUQLjA=;
        b=Zz6o4KDTj0zFNfNWeyt9mQ5gWEhQGJo7bYDJag5Se9Nh8LjgNJN3vYHHxKHfVLENC0
         zPGxKkOU0q4Od30NTlai8FpnHd+IHuvjvBC+mx9xRlhIZejp3U8oQx9mojZLkrN71PPf
         zZoEPjA8Whw1UW8LsVNV1O7t/WyATe6QtANGHiJtCU2gb6CLzSXBJogX+LsqWXoUzd3x
         OYfs1Eccw0EMiXYfW5M/6L3UWSk+B6dqSdCPVesPHq6HK49ML7eETmWyxGU9Q1V9uKrZ
         2vKdwDnBojkSjm7UaHo4bkAyxydRqQ0TE8YaZo4p+D2ehodKmub6HWDWPqSyTIRliqoP
         fJMA==
X-Gm-Message-State: AAQBX9d7w0XB2A4H+N3ljnDojGC1TXuLCJ78OxJrFgwwapMu6QWa+Y/8
        644PkQ/5PLxTUUNlbp466aU=
X-Google-Smtp-Source: AKy350afI02Fa3Acq0DNx6nJUWrX6aI7RY4q/vg2eOyv/5uPkMM5pF1SRDx4yrymqaBjzv9oWxjrTg==
X-Received: by 2002:a17:90a:fe8c:b0:246:f73c:3aba with SMTP id co12-20020a17090afe8c00b00246f73c3abamr1522019pjb.39.1681878276254;
        Tue, 18 Apr 2023 21:24:36 -0700 (PDT)
Received: from hackyzh-virtual-machine.localdomain ([58.34.53.146])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a088800b0024779068491sm380205pjc.26.2023.04.18.21.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 21:24:35 -0700 (PDT)
From:   hackyzh002 <hackyzh002@gmail.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, hackyzh002 <hackyzh002@gmail.com>
Subject: [PATCH 1/2] drm/radeon: Fix integer overflow in radeon_cs_parser_init
Date:   Wed, 19 Apr 2023 12:24:07 +0800
Message-Id: <20230419042407.69001-1-hackyzh002@gmail.com>
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
 drivers/gpu/drm/radeon/radeon_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index 46a27ebf4..472c29050 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -270,7 +270,7 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p, void *data)
 {
 	struct drm_radeon_cs *cs = data;
 	uint64_t *chunk_array_ptr;
-	unsigned size, i;
+	u64 size, i;
 	u32 ring = RADEON_CS_RING_GFX;
 	s32 priority = 0;
 
@@ -347,7 +347,7 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p, void *data)
 				continue;
 		}
 
-		p->chunks[i].kdata = kvmalloc_array(size, sizeof(uint32_t), GFP_KERNEL);
+		p->chunks[i].kdata = kvcalloc(size, sizeof(uint32_t), GFP_KERNEL);
 		size *= sizeof(uint32_t);
 		if (p->chunks[i].kdata == NULL) {
 			return -ENOMEM;
-- 
2.34.1

