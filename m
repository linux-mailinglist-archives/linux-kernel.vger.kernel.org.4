Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042796E7273
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDSEwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDSEwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:52:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7953AB2;
        Tue, 18 Apr 2023 21:52:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b5c830d5eso2338363b3a.2;
        Tue, 18 Apr 2023 21:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681879936; x=1684471936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek00L1cc21EOyKRafT/BGo0L28SeYIDeaJNfXSoDXCk=;
        b=d+4BWM18QNx9T8dgCdsk3UsYNuvnf21SDCQFyquG/W2sADMBujm+iIWajisCKuKoxG
         R1VSJCKr1sX5EaaIxiWJ9XO0RVuA33BMi4vOnetn4QAV09WkxRK8PCOkuIi6ItRXhGKh
         q8A6NjgJujvmHHhkGqmnks1KiR23uvckaBpED9UuP27afZdSTNWqqCnJyt02KL3MDhJ7
         v909j7ReBDq8PNdCrjoqk7IwZdirR07mN/VwA4lJsdBY6K6u3pjpZIdiKGC0536W6i7q
         pzXBMTKpacWNp/o5Nj4/aCBbCz6k8k/EhmtDUpnzDe3V4oiVzNUPB2OYLhCtphGf28uy
         9AGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681879936; x=1684471936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ek00L1cc21EOyKRafT/BGo0L28SeYIDeaJNfXSoDXCk=;
        b=IckX7A4em0OcBKhffMfLaUKTPRYSCYui2vtTseZFqVcK+QnOgJ2PDfYLy7LeRcZlT+
         sj/61b6Tn7yOuPxdieXFdt0HT2ymCBVj83Pf8swlYuAM/BHavSuZZ5/JVP6gEpQ/KzGB
         i4lI6v6fGpmtcOOdVrzvKQJ5XVr14XLg1I3wYdJnBjw4MvWaMdg5LGGzGPgCLKTVedUu
         1S1OxXF6wvGWV4XsXPkSbvkiqQZq7PSXJ5vxr5FjdyrDE64adJaozcXPH4SuMSCMB0l7
         u7ghQForDfzlOSMKAo5I1eqPFr9eVjDc1srwF26itvcsUuZ70iOSgVCnlainU4nSD60g
         tUpw==
X-Gm-Message-State: AAQBX9cFS8vo0Y7QhKWgUo0fPEdy+4j6f6a8TkztCDhefwVjKYr4bwvl
        ZuADFYK2YJDS4N/dTQDNdIU=
X-Google-Smtp-Source: AKy350aYkXkO5nxw+E17pu3EKWjttrdTBgY/iJvBuAu1+xFva4iSl0hDCqJM6NsevZ9568vkBqdsJg==
X-Received: by 2002:a17:902:8503:b0:19e:500b:517a with SMTP id bj3-20020a170902850300b0019e500b517amr3719378plb.69.1681879936118;
        Tue, 18 Apr 2023 21:52:16 -0700 (PDT)
Received: from hackyzh-virtual-machine.localdomain ([58.34.53.146])
        by smtp.gmail.com with ESMTPSA id ix9-20020a170902f80900b001a64dbfc5d7sm10433184plb.145.2023.04.18.21.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 21:52:15 -0700 (PDT)
From:   hackyzh002 <hackyzh002@gmail.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, hackyzh002 <hackyzh002@gmail.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
Date:   Wed, 19 Apr 2023 12:51:57 +0800
Message-Id: <20230419045157.69829-1-hackyzh002@gmail.com>
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
+	uint64_t int size;
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

