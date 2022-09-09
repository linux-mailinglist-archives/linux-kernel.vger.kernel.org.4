Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC9B5B3088
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiIIHh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiIIHgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE6F2FFED;
        Fri,  9 Sep 2022 00:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 723DB61F16;
        Fri,  9 Sep 2022 07:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F47C4FF07;
        Fri,  9 Sep 2022 07:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708895;
        bh=hQa2qB2CeTyw3GAgYwyhVj1XTZmgIzZSunChiyTazuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+phLD5baNAwxItQcI1si4W3MWaifXIx3QrVpzQO1eXR8RIJjaf2ss7uWaV0HGNwJ
         fAwWRHAYqx726AcPnwCMLKn84RKM3XRPRcDr+AbDcLskCuEy7KqKHDh/R2JfYhg+D3
         iKKBEL0aFUdzMs7XF3LJFL4A+k05MusdODNW6jIVoUiHkFxZ3irzCJkYG60JJfCrcj
         NfX9Sf32DaASb+DUqGndSVmUdPJXeuPs0MZEm1mc4apXN0VkBHFXgOSqSn8v8Oe8kw
         IXntVwQxwy6Zy7kMccovBKxcJaHvFLtAhzAEdWCFpGpVmGoEsU4ofe+znF7tdhKAJ2
         GLIWH3wRnks5w==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXH-007FHP-76;
        Fri, 09 Sep 2022 09:34:47 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 28/37] docs: gpu: i915.rst: GuC: add more kernel-doc markups
Date:   Fri,  9 Sep 2022 09:34:35 +0200
Message-Id: <1b5cf28c08c5b9f5786ace0bb77de1f6558f6639.1662708705.git.mchehab@kernel.org>
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

There are several documented GuC kAPI that aren't currently part
of the docs. Add them, as this allows identifying issues with
badly-formatted tags.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index b668f36fb0a3..7f2daa1b4a8b 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -593,6 +593,28 @@ GuC
 
 .. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc.h
 
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/abi/guc_actions_slpc_abi.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_ct.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_uc.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
+
 GuC Firmware Layout
 ~~~~~~~~~~~~~~~~~~~
 
-- 
2.37.3

