Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED4E62921B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiKOHDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiKOHDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:03:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C721FCD5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:03:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19A24B816E1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BDBC433D6;
        Tue, 15 Nov 2022 07:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668495786;
        bh=N7r+y3JxX23ArCNVGs3jjxU9TZdBhjWy0dqAx+SiLaw=;
        h=From:To:Cc:Subject:Date:From;
        b=PCeRAESTH5guglErPEfJNUypWKhdo3sAgiPo18xBVO0YD/XhCAGsHoQG3M61Hul1s
         rT0ylYsUp1tL2vQO8D2LbJoN3AvCQQtyOC9+bMWqShNpGgxDG9vM+jq6MoykYj2A0E
         bjmm/FKOLXe4opnWIhaDreyTFaSltpgpKyYEWbmD3X/8ucAlkFMo9t6foCQfGerERe
         o11oeqvEgpVTA1A2R1T/+LJJfjD8sofBrxi+JOulIdwJHdtaWUCad6tjXGpB9kbtSy
         Ik76QFsUciZyttF4+VnncOIB1HYrKNz/+PkCUD8zw+0qmmUvEPcQqFWWQRpkHT1OUJ
         R7BZVkEI7YPPg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     jani.nikula@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/i915: remove circ_buf.h includes
Date:   Tue, 15 Nov 2022 08:03:02 +0100
Message-Id: <20221115070302.4064-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
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

The last user of macros from that include was removed in 2018 by the
commit below.

Fixes: 6cc42152b02b ("drm/i915: Remove support for legacy debugfs crc interface")
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---

Notes:
    [v2] fixed e-mail setup

 drivers/gpu/drm/i915/display/intel_pipe_crc.c | 1 -
 drivers/gpu/drm/i915/i915_irq.c               | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_pipe_crc.c b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
index 673454fbf784..e9774670e3f6 100644
--- a/drivers/gpu/drm/i915/display/intel_pipe_crc.c
+++ b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
@@ -24,7 +24,6 @@
  *
  */
 
-#include <linux/circ_buf.h>
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index b0180ea38de0..a815a45a6e6b 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -28,7 +28,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/circ_buf.h>
 #include <linux/slab.h>
 #include <linux/sysrq.h>
 
-- 
2.38.1

