Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899BF72462E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbjFFOdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjFFOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:33:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263B11735
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:33:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30e407daab5so2591678f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686061998; x=1688653998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=etnk6Bmfi+NsN3fMwvpGFNhakv5CYAq3q2C18ogo/QU=;
        b=r4mkCO7+F6PcaG6L5pBrXztZOCfvv1CoQeSFQeqwGopyq+CzI6qbgEWC9fduxPiiDh
         XtDOudYSaQOmT9xXbvpe5i2hAmAHMQs4lRIgF7PUe4jBfFxNVi2pSpYkKlRGMC9rFSxJ
         pJNj+4DrSg8ccP5n8R1teUhl3oAOJrlv/CWchMr3Ci7DzyCFvKTYsfp9/3dwz4mVfPXF
         GjZGe9iXmZWDii8Hk7qOo0dE4uC3SdnUvdpmAXQuKmbavca6BPxcvyZMjhAdRqb+KDJf
         lIQ3GWa+pfASHBYSLsxeZgq+e/FxNza4y3b088Upx0E/OnrlxgsJ8L0WlVovnl7HOVcs
         nJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061998; x=1688653998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etnk6Bmfi+NsN3fMwvpGFNhakv5CYAq3q2C18ogo/QU=;
        b=OaI+8pN5gOWqVOjbnmAXcBDynUzc3jE4rsf29Nvmx8ikVFuaO+3hIXG0C3UteL5pD4
         p1TOVX5FhS1fmkqtWwxD9D35HS2pZf4jZ32HOwPxS1z3ODXdexVQUpDvKfpVQEtfkspD
         d+G5K72Rca5ySL9efLuRf8TZk/ZVvEDsl7tVijwCGCVIlbG9C3d5Bl8zXwMwuChk7dIY
         VcVaJEL91l/y3Unk7z9o5Ui8+ed7CviHCsp9S8DcmaXmRfq1EYSjbVljYn6BbQCKgRTM
         QMjcUWUWXBFjqC4XF8BDTFGUkKN2l2M7oOn2MkPdcsEJecI6HStBGxdxHUJvWiRfCl2d
         ekAg==
X-Gm-Message-State: AC+VfDzDaaclwhTUswtA+z3JdJmmNIxIG5EZGuu6brbsNHzAw6khlopz
        3Csn7oCr8T6VrHGCG77wbI4=
X-Google-Smtp-Source: ACHHUZ5KiIY5KwxOSxBzH2UQUnhP4/a60rnf7iCrHG1wFajmhi2f/DobS0/OOkSxpTE7+N6FDx414A==
X-Received: by 2002:a5d:4bd0:0:b0:306:3945:65e9 with SMTP id l16-20020a5d4bd0000000b00306394565e9mr2211778wrt.3.1686061998296;
        Tue, 06 Jun 2023 07:33:18 -0700 (PDT)
Received: from odroidc2.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003f736e28cd6sm8902642wmc.4.2023.06.06.07.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:33:17 -0700 (PDT)
From:   Erico Nunes <nunes.erico@gmail.com>
To:     yuq825@gmail.com, dri-devel@lists.freedesktop.org,
        lima@lists.freedesktop.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, luben.tuikov@amd.com,
        christian.koenig@amd.com, linux-kernel@vger.kernel.org,
        Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH] drm/lima: fix sched context destroy
Date:   Tue,  6 Jun 2023 16:32:47 +0200
Message-Id: <20230606143247.433018-1-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm sched entity must be flushed before finishing, to account for
jobs potentially still in flight at that time.
Lima did not do this flush until now, so switch the destroy call to the
drm_sched_entity_destroy() wrapper which will take care of that.

This fixes a regression on lima which started since the rework in
commit 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
where some specific types of applications may hang indefinitely.

Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index ff003403fbbc..ffd91a5ee299 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -165,7 +165,7 @@ int lima_sched_context_init(struct lima_sched_pipe *pipe,
 void lima_sched_context_fini(struct lima_sched_pipe *pipe,
 			     struct lima_sched_context *context)
 {
-	drm_sched_entity_fini(&context->base);
+	drm_sched_entity_destroy(&context->base);
 }
 
 struct dma_fence *lima_sched_context_queue_task(struct lima_sched_task *task)
-- 
2.40.1

