Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0CD6BE377
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjCQIZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjCQIY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:24:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FE6DDF12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A8D2B824FC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3EEC433A0;
        Fri, 17 Mar 2023 08:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679041397;
        bh=fLtbhWgCsGsjs2LsMlU/YO3L1k01VNDjn64lqWtvZXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGVuQp1GOkBI9jvFetIsa9u3o1htjU2WAgXauzbmjb6UD4o4gDEi8FHkf/0SKUMJs
         oPik83Qk3lI6Hbrh8Z4oXmG33xJyLeCF5JYhuxrqE9NS8vAzntafM65E/Cs2iCce5L
         d/bC0nXKuqPcFFXhAkVt6SfjB2Gz+Q0v34UkqLiejTTqQMmsx6slTcoSc5Mb39zpkb
         J/YXKultGej0ddqO40xSNH5QBxLfKCetHnn3pfgnrt+NM+4lFcb3HnOkBZ6MZmy86/
         luRWVJLCal1S9CqH1MqwprMDyv3Rpa7jHpIriBcA0nfB3gcLAv9ns7TsxNG0rAPw+X
         y2nyphzHbUpDw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org
Subject: [PATCH 24/37] drm/nouveau/nvkm/engine/gr/gf100: Demote kerneldoc abuse
Date:   Fri, 17 Mar 2023 08:17:05 +0000
Message-Id: <20230317081718.2650744-25-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230317081718.2650744-1-lee@kernel.org>
References: <20230317081718.2650744-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:1044: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
index 5f20079c3660f..7d4c2264d3c05 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -1040,7 +1040,7 @@ gf100_gr_zbc_init(struct gf100_gr *gr)
 	}
 }
 
-/**
+/*
  * Wait until GR goes idle. GR is considered idle if it is disabled by the
  * MC (0x200) register, or GR is not busy and a context switch is not in
  * progress.
-- 
2.40.0.rc1.284.g88254d51c5-goog

