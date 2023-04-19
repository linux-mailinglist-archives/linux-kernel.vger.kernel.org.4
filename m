Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479CB6E799E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjDSMXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjDSMXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:23:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D51173B;
        Wed, 19 Apr 2023 05:23:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a6ebc66ca4so15305505ad.3;
        Wed, 19 Apr 2023 05:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681906991; x=1684498991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vuo1R6zgWP4V7fxSrNGqI53skR4NUxsCW4UKtSQFHoQ=;
        b=iHj2EFKwjqQG5zGuh91t/HLTjhn98+Tm/JgEUgdtKzQYUcMmigmjFwJZQ27nAG8Bnn
         RHiWrB3TM8X4DXmmFUxo4NXSXOgDWYjPdgXCG/SYRg/5s9pd4KEAOJnc20QtgnF8qg52
         AUf1b2vXcFFtExWm9wshnbebzGLoILPKk6KmWinlkzij5YLgVKCJ7g26LmkyIfbTFQqg
         FLt59XmV42XHJ8E+dQGIJaHimuxqMmRFmogeMWa+pdUIzr2GIVnbyyyvr0DFJqmTfMVp
         0L9i+faJHasd1uXPnVTW5t6+PMtY5Nt+W/N4+KxTV6QfESQ7rL+ImLHb+Q4igKn6JFDk
         v/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681906991; x=1684498991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuo1R6zgWP4V7fxSrNGqI53skR4NUxsCW4UKtSQFHoQ=;
        b=WBTotO6ilhFoPv7Pgkrv7LyjG1vddWCnA7O7MP2f5IXW0/S8np961SYxTC3bZbPJ6y
         ENBOtSkbQt7nzk6OlI2mzLnQHHFvQTFwGPFTZTG/CHgpsUldqo5yLi8t4QRXjfygqF/k
         pasuFJXng208wYZwyrgZ+RPbDsoLeWj/uA3nACfam2kSgpgkFOUoMKqOBQpucku+I46R
         X+V/4op//PG6D25WZSl4nZ+7mv6SBtuhT8KQfBsHlNFLbcZ64A/KMiHJnQKqQaKM11L3
         f0MfcuoBaxZBBJwFDBEAlUP7nL+nl+tSqNDqklKVjYhi3L98TaecRRGbSfxkcnQ2OvuD
         8vPQ==
X-Gm-Message-State: AAQBX9dQodrNQmJIDoLMNwyMnaoX+wJ+G8JAC8UTkRUdnHVoVT4362+8
        sfkFdUTKppJqTYw0OKyOh6I=
X-Google-Smtp-Source: AKy350ZOvvzEVtaSNhWFtkSL5aX841ukA5rD+bJ6S5wFb5ZiUTOGTwRiL0CFdwfo4kCozHg/35yMcw==
X-Received: by 2002:a17:902:c410:b0:1a1:f0ad:8657 with SMTP id k16-20020a170902c41000b001a1f0ad8657mr7207596plk.37.1681906990803;
        Wed, 19 Apr 2023 05:23:10 -0700 (PDT)
Received: from hackyzh-virtual-machine.localdomain ([112.64.53.154])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d34b00b0019c32968271sm9053670plk.11.2023.04.19.05.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 05:23:10 -0700 (PDT)
From:   hackyzh002 <hackyzh002@gmail.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, hackyzh002 <hackyzh002@gmail.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
Date:   Wed, 19 Apr 2023 20:22:33 +0800
Message-Id: <20230419122233.3440-1-hackyzh002@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 08eced097..89bcacc65 100644
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
 
-- 
2.34.1

