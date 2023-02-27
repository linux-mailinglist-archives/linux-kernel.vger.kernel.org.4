Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0275B6A3DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjB0JMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0JM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:12:29 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7D32007E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:04:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7AB1A41A42;
        Mon, 27 Feb 2023 09:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677488684;
        bh=6xesS6Ljou66pP6PWhd2jHCz/oRFGXqhqdZJF8Pqu1Q=;
        h=From:Date:Subject:To:Cc;
        b=w0xGWlmEV7OPrLJlrOKrWGYFhD0k444BX2duDEDHbSEjUVYQ8XOreZfl64+/x8zQH
         e0SpnCTY8SBVUD6RjDQFzlzITqdmLrgOTi5R4PYHq27qS1qVzHF6POb0EGCpY+FEck
         /fvehgHqgXkBypCtRZPfCnKbAZFb+lYphz5w0Cr9/xQM+Fx1yUPwqF52hzbfASQ9Nz
         sM2lNUGp06NxG/Dkiz+8J1R9w/tL4E/gq10DxQdXjDd7d0U1xOM64HZOQWt1OhBoW1
         cTpQVi4VTNrrN2NStOb1EM40dppWWWda7zPmoQdlchezWWwuTrV/cMGOip10w5oCO8
         AV6GKmQA+HN4Q==
From:   Asahi Lina <lina@asahilina.net>
Date:   Mon, 27 Feb 2023 18:04:21 +0900
Subject: [PATCH] drm/shmem-helper: Revert accidental non-GPL export
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230227-shmem-export-fix-v1-1-8880b2c25e81@asahilina.net>
X-B4-Tracking: v=1; b=H4sIABRy/GMC/x2NQQqDMBBFryKz7kASlZZepXQR9dvMIlFmShHEu
 ze6fI//+DsZVGD0bHZS/MRkKRX8raExxfIBy1SZggutC+HOljIyY1sX/fIsGz/6eYJve+9dRzU
 booEHjWVMZ5ijlFOvirq+nl7v4/gDwpvuV3kAAAA=
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677488681; l=1150;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=6xesS6Ljou66pP6PWhd2jHCz/oRFGXqhqdZJF8Pqu1Q=;
 b=HkugH8SjAQj8+MQlqS+NqL2h3dR12a7j47b1UtiTRuIfvIf4NwxK1ZD3DSg5iscrgwpF+jHpt
 GEJerGjGAoMB/Bnjfige8yg8ZPnbbwJq+F7DHst6hYKtD7Ra+vhgPIC
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The referenced commit added a wrapper for drm_gem_shmem_get_pages_sgt(),
but in the process it accidentally changed the export type from GPL to
non-GPL. Switch it back to GPL.

Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Fixes: ddddedaa0db9 ("drm/shmem-helper: Fix locking for drm_gem_shmem_get_pages_sgt()")
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 7e5c6a8d0212..75185a960fc4 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -744,7 +744,7 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
 
 	return sgt;
 }
-EXPORT_SYMBOL(drm_gem_shmem_get_pages_sgt);
+EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages_sgt);
 
 /**
  * drm_gem_shmem_prime_import_sg_table - Produce a shmem GEM object from

---
base-commit: f3a2439f20d918930cc4ae8f76fe1c1afd26958f
change-id: 20230227-shmem-export-fix-85fde1351104

Thank you,
~~ Lina

