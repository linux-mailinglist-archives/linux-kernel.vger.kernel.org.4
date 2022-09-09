Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EEB5B3071
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiIIHgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiIIHfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA38A6C57
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CC5E61ED8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0070C43141;
        Fri,  9 Sep 2022 07:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708893;
        bh=2PT4bPREhrbF+AiByaJTTdJleitJm880geBkmK8/S7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2gljyZ6GsQGljtEgR2NW0M5K7f4uzuO36jv0DkaEjmLUs6KPkXKE6nvocv/yeCP2
         keZeb9G7o1ZAB+Vxzf0ScDL4reOJKyeoxXOJJrMhwEIwY2SEuvroqsbN/SgZbvHdJD
         0mVvgKpZxtfR+I75fakZ0umXZsKwuuaLKZF72UQMgcAQzgetx45vvmOp5Pcj/Ba7T1
         q5CP1sDTEUcbWcAdbatdhT5gly1gjtAGJ4MLu+7xI9Zlu83iVuw/Dmp69iOIAvvGZ8
         hiy0LXzUT5glFeLG4CP5S1dC4ixtFJ9OCAoeDnqMPOBzR38mfWk6vmKTzctpaHCaa+
         4u1MovExF851g==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXF-007FFz-RN;
        Fri, 09 Sep 2022 09:34:45 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/37] drm/i915: intel_wakeref.h: fix some kernel-doc markups
Date:   Fri,  9 Sep 2022 09:34:13 +0200
Message-Id: <47ab1115766067abbb168d082d875a00261c19e1.1662708705.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662708705.git.mchehab@kernel.org>
References: <cover.1662708705.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two documented functions don't match the kernel-doc comments,
as reported by kernel-doc:

	drivers/gpu/drm/i915/intel_wakeref.h:117: warning: expecting prototype for intel_wakeref_get_if_in_use(). Prototype was for intel_wakeref_get_if_active() instead
	drivers/gpu/drm/i915/intel_wakeref.h:149: warning: expecting prototype for intel_wakeref_put_flags(). Prototype was for __intel_wakeref_put() instead

Fix them.

Additionally, improve title for intel_wakeref_get_if_active().

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/intel_wakeref.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_wakeref.h b/drivers/gpu/drm/i915/intel_wakeref.h
index 4f4c2e15e736..63e539c9b1f3 100644
--- a/drivers/gpu/drm/i915/intel_wakeref.h
+++ b/drivers/gpu/drm/i915/intel_wakeref.h
@@ -104,7 +104,7 @@ __intel_wakeref_get(struct intel_wakeref *wf)
 }
 
 /**
- * intel_wakeref_get_if_in_use: Acquire the wakeref
+ * intel_wakeref_get_if_active: Acquire the wakeref if active
  * @wf: the wakeref
  *
  * Acquire a hold on the wakeref, but only if the wakeref is already
@@ -130,7 +130,7 @@ intel_wakeref_might_get(struct intel_wakeref *wf)
 }
 
 /**
- * intel_wakeref_put_flags: Release the wakeref
+ * __intel_wakeref_put: Release the wakeref
  * @wf: the wakeref
  * @flags: control flags
  *
-- 
2.37.3

