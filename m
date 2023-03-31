Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B486D1C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjCaJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjCaJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:26:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2088C1D902
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:26:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF93BB82DAF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514EEC433EF;
        Fri, 31 Mar 2023 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680254784;
        bh=TRYSMYkXks9q3GSP+rY54wBe6rlqoIbNXHmoR55KP+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfTjoBeSVRz6N27mcOkAv5LA/MVWqsH0d1zmQmcsuuwyb4YU9RGjd31eVeQB/YAfB
         +6FK9GNc2T3I4jj510Nx1R+EFu7iKO+HFBJd/Tcndv3C3ns+K2EhZbj8VEgAfiyDFr
         h7QzGIZHIBP7JDINi7BJlg5Ij4UMemIeOqkgH9SQLMUzYiBO/IHQPG6TxuffMIaywB
         8ziNYiQxweDizvG0jBB47zAgCrI1ROgNsgp7AYDcSMr9pwQ4b+H4wkCj9iS/KLbR4F
         7lEfCR3WYqlYR60BXPSZ7LxYt//kkFFoMyTTC4ZyYq4BPQrsOugK3OPicOHUykXjLN
         NIeywdUEbvJJw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 04/19] drm/i915/display/intel_display_debugfs: Fix incorrect param naming for 'intel_connector'
Date:   Fri, 31 Mar 2023 10:25:52 +0100
Message-Id: <20230331092607.700644-5-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331092607.700644-1-lee@kernel.org>
References: <20230331092607.700644-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/i915/display/intel_display_debugfs.c:1668: warning: Function parameter or member 'intel_connector' not described in 'intel_connector_debugfs_add'
 drivers/gpu/drm/i915/display/intel_display_debugfs.c:1668: warning: Excess function parameter 'connector' description in 'intel_connector_debugfs_add'

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index d5715ccc37f0e..195b6cb379ad1 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -1395,7 +1395,7 @@ DEFINE_SHOW_ATTRIBUTE(intel_crtc_pipe);
 
 /**
  * intel_connector_debugfs_add - add i915 specific connector debugfs files
- * @connector: pointer to a registered drm_connector
+ * @intel_connector: pointer to a registered drm_connector
  *
  * Cleanup will be done by drm_connector_unregister() through a call to
  * drm_debugfs_connector_remove().
-- 
2.40.0.348.gf938b09366-goog

