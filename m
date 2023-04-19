Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91B56E7509
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjDSI1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjDSI1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:27:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FAB1025A;
        Wed, 19 Apr 2023 01:27:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b5465fb99so2668292b3a.1;
        Wed, 19 Apr 2023 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681892852; x=1684484852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ6u9/CgweQ6jEZks/xNcF/T3qE4BW1KJoYmfltjmnY=;
        b=jDdzGmKUWx25EHLZZrgXq7aDt3wKPN6KbvpQblP4OzUqawFkruB9AZ0pTXtxj5uflb
         0Eg93b+jYxUjYMmYx/jMH4zSUgSvb3+F7scJZWp3r5jgRL+FYxXVDlT3UnX/DsD7JWyg
         2qfZvuXWGG4yxj7YwEr76JeXl8kZVrx7j2kLXxEZs4Ak6V9SYdtll2nEamGBQ2zh4sF5
         g/c4562wmL3t06jZ6GIixFAYw2GwQaEHdKqyq+QRcx+tpC6GAqm5xe9aetaBF9Fdrr5i
         sTEuBvnoZQr7Pm+C8xZTSVDKZS0eBfi7066zLUowoXXFsrwf36jV7pidMne/kJfXRRKB
         nmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681892852; x=1684484852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZ6u9/CgweQ6jEZks/xNcF/T3qE4BW1KJoYmfltjmnY=;
        b=O6pFu9XaPxFNKAZ1S5qUK8aAUp3P+p2FSHZxUXIdQf30Jz2e/kY9a8msbeQYEwK54X
         bRJjzdUnQD/o3+tbOGhN5xOPN31svmN6vwP84qBFJtp1cIzLZIa56DbSQvotz5e/UiAN
         UYMGmZzIEBZnkzaRNEDUi9ANEwl7Ojkmn9IBAjcKJ9h0YOCh2YSCaQ7Cgg5i3hrehjEH
         oyxx2Sc/ps9t6iaBIELg4kMxSlkml6LytqFlHbeITRbtLSStls851JxgLAcYQXA/ZtLC
         I16tI7kOeLeBZHeXOE4UyZttzqIgQbkqrIdL6LPE5rOm1+ytJ/9Zk2l0USyIKfZzp0Mi
         oclg==
X-Gm-Message-State: AAQBX9c89e8WS/5cFKqjXpEHOEeuVoaUmE5qI/1hF/oUaAi8jJ/Cs5KV
        TZYlTKseOm6KxPqb4NbX9jI=
X-Google-Smtp-Source: AKy350ag1YslGcDUesBAO6cVpS0tdiEfRtWuJuAlBJdYCw1S/UrhRm6CndcjR0xKt+ywr/rYXpxrtg==
X-Received: by 2002:a17:903:708:b0:1a6:a375:cb49 with SMTP id kk8-20020a170903070800b001a6a375cb49mr3818668plb.39.1681892851691;
        Wed, 19 Apr 2023 01:27:31 -0700 (PDT)
Received: from hackyzh-virtual-machine.localdomain ([58.34.53.146])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902b71300b001a6ebc39fd9sm4411339pls.309.2023.04.19.01.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:27:31 -0700 (PDT)
From:   hackyzh002 <hackyzh002@gmail.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, hackyzh002 <hackyzh002@gmail.com>
Subject: [PATCH V2 2/2] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
Date:   Wed, 19 Apr 2023 16:27:05 +0800
Message-Id: <20230419082705.4110-1-hackyzh002@gmail.com>
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

The type of size is unsigned int, if size is 0x40000000, there will
be an integer overflow, size will be zero after size *= sizeof(uint32_t),
will cause uninitialized memory to be referenced later.

Signed-off-by: hackyzh002 <hackyzh002@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 08eced097..c17b3af85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -192,7 +192,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	uint64_t *chunk_array_user;
 	uint64_t *chunk_array;
 	uint32_t uf_offset = 0;
-	unsigned int size;
+	size_t size;
 	int ret;
 	int i;
 
@@ -235,7 +235,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 		size = p->chunks[i].length_dw;
 		cdata = u64_to_user_ptr(user_chunk.chunk_data);
 
-		p->chunks[i].kdata = kvmalloc_array(size, sizeof(uint32_t),
+		p->chunks[i].kdata = kvcalloc(size, sizeof(uint32_t),
 						    GFP_KERNEL);
 		if (p->chunks[i].kdata == NULL) {
 			ret = -ENOMEM;
-- 
2.34.1

