Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC055B30AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiIIHkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiIIHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:38:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8FE11B02C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D623161EF7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D070EC43164;
        Fri,  9 Sep 2022 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708894;
        bh=yzIzGGHPTm6VJftl0OQmqcW1xRbYLj9NPH5I+kib2H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TlT4VDT9PtfPOMFs3TYk4gn7THT7edYxPaH21B5ec0E+Y3fGhD+lE+PWlaCYSRQL+
         aXiHqH9DI9FW30G1M58H8JkLITDEdF4w8qpVy8CTfJnvDre173tqDD54P+fXiTWk6R
         s3DtTxxxGISrcRiWfU4p44VOs0BoaKwMwQN/QkY73iV9J5TvEpjG1gDJSkHsUNK7dg
         5sQywv8ldkF/hEI3d3MyqnqZPqWPRwnnvTOUA+uekDN2q3C3EAueetS/0V3AUaNLh/
         g6/WnY6KVYY/PckXToHyWTO/nk6N06BvExsD+x3xhqLHM1SmFXFx0MmCApXun5SWuz
         POBl6vIZBdBEQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXG-007FH1-Qp;
        Fri, 09 Sep 2022 09:34:46 +0200
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
Subject: [PATCH v3 22/37] drm/i915: i915_vma_resource.c: fix some kernel-doc markups
Date:   Fri,  9 Sep 2022 09:34:29 +0200
Message-Id: <90bc7948a2366b7abc7945d7fd74d48c0df18bf4.1662708705.git.mchehab@kernel.org>
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

Building docs currently produces two warnings:

    Documentation/foo/i915:71: ./drivers/gpu/drm/i915/i915_vma_resource.c:286: WARNING: Inline strong start-string without end-string.
    Documentation/foo/i915:71: ./drivers/gpu/drm/i915/i915_vma_resource.c:370: WARNING: Inline strong start-string without end-string.

That's because @foo evaluates into **foo**, and placing anything
after it without spaces cause Sphinx to warn and do the wrong
thing.. So, replace them by a different Sphinx-compatible tag.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/i915_vma_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_vma_resource.c b/drivers/gpu/drm/i915/i915_vma_resource.c
index de1342dbfa12..e758e0530175 100644
--- a/drivers/gpu/drm/i915/i915_vma_resource.c
+++ b/drivers/gpu/drm/i915/i915_vma_resource.c
@@ -290,7 +290,7 @@ i915_vma_resource_color_adjust_range(struct i915_address_space *vm,
  *
  * The function needs to be called with the vm lock held.
  *
- * Return: Zero on success, -ERESTARTSYS if interrupted and @intr==true
+ * Return: Zero on success, -ERESTARTSYS if interrupted and ``intr==true``
  */
 int i915_vma_resource_bind_dep_sync(struct i915_address_space *vm,
 				    u64 offset,
@@ -374,7 +374,7 @@ void i915_vma_resource_bind_dep_sync_all(struct i915_address_space *vm)
  * this means that during heavy memory pressure, we will sync in this
  * function.
  *
- * Return: Zero on success, -ERESTARTSYS if interrupted and @intr==true
+ * Return: Zero on success, -ERESTARTSYS if interrupted and ``intr==true``
  */
 int i915_vma_resource_bind_dep_await(struct i915_address_space *vm,
 				     struct i915_sw_fence *sw_fence,
-- 
2.37.3

