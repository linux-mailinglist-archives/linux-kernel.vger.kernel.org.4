Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086936415F2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiLCKgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLCKgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:36:09 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E442F02F
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 02:36:08 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670063767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAo4keShZ18WFessSvhSTot4vT88z0d7rr9jhcq1OZw=;
        b=ij8nAfsVPxIscTKxwoTk7o9XGW+a6g+cTqcGR5IdokztBaDQ4hub0VvhmRlUaB8SzZrKj3
        4ePR/U21/shv/4di8McT/IgcDIbfosg4gC+o7+dXlKQiEaIi/YNer7zyidR/RC+Jb+khNh
        LEfKWm70U9RjV9ZWYn3Hrrahx1/Q7ow=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     tzimmermann@suse.de
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Danilo Krummrich <dakr@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [RESEND PATCH linux-next v2 08/10] drm: Add comments to Kconfig
Date:   Sat,  3 Dec 2022 18:22:59 +0800
Message-Id: <20221203102502.3185-9-cai.huoqing@linux.dev>
In-Reply-To: <20221203102502.3185-1-cai.huoqing@linux.dev>
References: <20221203102502.3185-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments to avoid removing DRM_LEGACY config menu,
because DRM_LEGACY menu could list other legacy drivers.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/gpu/drm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 96d73208995a..520633a1e706 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -391,7 +391,7 @@ menuconfig DRM_LEGACY
 	  Unless you have strong reasons to go rogue, say "N".
 
 if DRM_LEGACY
-
+# leave here to list legacy drivers
 endif # DRM_LEGACY
 
 config DRM_EXPORT_FOR_TESTS
-- 
2.25.1

