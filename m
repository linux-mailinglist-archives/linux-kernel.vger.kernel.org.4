Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FAF6D1C14
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCaJ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCaJ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:26:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE92F46BF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50A32B82DA9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542D5C433EF;
        Fri, 31 Mar 2023 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680254774;
        bh=BZuFl1gyQcIjbh+e4xSTPO+6EhGn8De3xOHP8J/d3Fc=;
        h=From:To:Cc:Subject:Date:From;
        b=BUt7z8KBc88htq6nzXCij4i+umlI05jjqTSNOLW1ovqpSzj/4jOp6YTuPEWUY2CTK
         AvB1hZ5daCiPQHksD2upKi/7z63L/9KpVuHVWqD27RgUHDoyt6qV+V0m3kGk0ynwZO
         T9XgtLs523shDj9TFPWULnTxcrfUD1ucXzH45z3UR/tbtn+8HTc4lb+yWqQqUKneXh
         JT3qxfHVSPawvRIufJWigImjvqU+hhxBw6UzFn5vVb5HbUEU8trSJVURgP7wp4553K
         xbZJqpS5E4k/kqSucyJr3iNMnbTo6INxOheK2pqhsJSk3xN0e9ooEob2uO6uzKKOEZ
         WEZFIprcgmFBg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH (set 2) 00/19] Rid W=1 warnings from GPU
Date:   Fri, 31 Mar 2023 10:25:48 +0100
Message-Id: <20230331092607.700644-1-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (19):
  drm/i915/i915_scatterlist: Fix kerneldoc formatting issue - missing
    '@'
  drm/i915/intel_region_ttm: Provide missing description for 'offset'
    param
  drm/radeon/radeon_ttm: Remove unused variable 'rbo' from
    radeon_bo_move()
  drm/i915/display/intel_display_debugfs: Fix incorrect param naming for
    'intel_connector'
  drm/i915/gt/intel_engine_cs: Fix a couple of incorrectly named
    functions
  drm/i915/gt/intel_rps: Demote a kerneldoc abuse for
    ips_ping_for_i915_load()
  drm/i915/gem/i915_gem_create: Provide the function names for proper
    kerneldoc headers
  drm/i915/gem/i915_gem_domain: Provide function names to complete
    proper kerneldoc
  drm/i915/gem/i915_gem_ttm_pm: Provide a couple of missing descriptions
    for 'flags' and remove some superfluous ones
  drm/i915/gem/i915_gem_ttm: Demote half-filled kerneldoc
  drm/i915/gem/i915_gem_ttm_move: Provide a couple of missing
    descriptions for 'num_pages' and 'ctx'
  drm/i915/gem/i915_gem_wait: Provide function name to validate the
    kerneldoc header
  drm/i915/gem/i915_gem_object: Demote non-kerneldoc header with no
    param descriptions
  drm/i915/i915_gem: Provide function names to complete the expected
    kerneldoc format
  drm/i915/gt/uc/intel_guc_hwconfig: Demote a few non-conforming
    kerneldoc headers
  drm/i915/i915_vma: Provide one missing param and demote another
    non-kerneldoc header
  drm/i915/display/intel_display_power: Fix incorrectly documented
    function __intel_display_power_put_async()
  drm/amd/amdgpu/sdma_v6_0: Demote a bunch of half-completed function
    headers
  drm/i915/display/intel_wm: Fix a little doc-rot in
    intel_update_watermarks()

 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |  8 ++++----
 .../gpu/drm/i915/display/intel_display_debugfs.c   |  2 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |  2 +-
 drivers/gpu/drm/i915/display/intel_wm.c            |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_create.c         |  7 ++++---
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         | 14 +++++++++-----
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c            |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c       |  3 +++
 drivers/gpu/drm/i915/gem/i915_gem_ttm_pm.c         |  5 ++---
 drivers/gpu/drm/i915/gem/i915_gem_wait.c           |  2 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  6 +++---
 drivers/gpu/drm/i915/gt/intel_rps.c                |  2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c    |  6 +++---
 drivers/gpu/drm/i915/i915_gem.c                    |  8 ++++----
 drivers/gpu/drm/i915/i915_scatterlist.c            |  2 +-
 drivers/gpu/drm/i915/i915_vma.c                    |  3 ++-
 drivers/gpu/drm/i915/intel_region_ttm.c            |  1 +
 drivers/gpu/drm/radeon/radeon_ttm.c                |  2 --
 19 files changed, 43 insertions(+), 36 deletions(-)

--
2.40.0.348.gf938b09366-goog

