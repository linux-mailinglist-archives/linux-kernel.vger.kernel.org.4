Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F95B3081
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiIIHih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiIIHhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED8612A324
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3D7561EED
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69C4C43160;
        Fri,  9 Sep 2022 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708894;
        bh=EBt7UgSghKjU0MjW/yi1iqfwnhUuumqiRNK1oK1Mhu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJ165+GXx180sU6O/tAmqV1j2afwyCLK576k9hhrzaEW/sL7FBEiaALdKGN1f5r4m
         YWV7NZ0uwXAkG7Rp/KU0bij8+ayuy7Zr34xn/lNoOWu89X5YxpEcVcCFLdqaUerBts
         bM1tddvHNpufkOpup8BvTQFGeKAaisa2PRg5jOduaAkE12zcjvFrQv/r217fEJ9UGQ
         8DvmxcOSN0CiYHbHza7o/2W13xqpvx7lkDhOvpTgiPqaLMVSdJSmxA4L/0JLvvOkJb
         AGCKeV+/WM3LdFCIUidhj/2GC4RcBuRW6XF3P8HRDc3mqUQFeUGrcuTyBez12m9KST
         DRg+vCr361FDQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXG-007FGt-NL;
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
Subject: [PATCH v3 20/37] drm/i915: dvo_ch7xxx.c: use SPDX header
Date:   Fri,  9 Sep 2022 09:34:27 +0200
Message-Id: <a0931ff4061eb54fc2e0ad754e16cc7c2a6170aa.1662708705.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662708705.git.mchehab@kernel.org>
References: <cover.1662708705.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This file is licensed with MIT license. Change its license text
to use SPDX.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/display/dvo_ch7xxx.c | 33 +++++------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/dvo_ch7xxx.c b/drivers/gpu/drm/i915/display/dvo_ch7xxx.c
index 1c1fe1f29675..b4d94a565fdb 100644
--- a/drivers/gpu/drm/i915/display/dvo_ch7xxx.c
+++ b/drivers/gpu/drm/i915/display/dvo_ch7xxx.c
@@ -1,30 +1,9 @@
-/**************************************************************************
-
-Copyright © 2006 Dave Airlie
-
-All Rights Reserved.
-
-Permission is hereby granted, free of charge, to any person obtaining a
-copy of this software and associated documentation files (the
-"Software"), to deal in the Software without restriction, including
-without limitation the rights to use, copy, modify, merge, publish,
-distribute, sub license, and/or sell copies of the Software, and to
-permit persons to whom the Software is furnished to do so, subject to
-the following conditions:
-
-The above copyright notice and this permission notice (including the
-next paragraph) shall be included in all copies or substantial portions
-of the Software.
-
-THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
-IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
-ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-
-**************************************************************************/
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2006 Dave Airlie
+ *
+ * All Rights Reserved.
+ */
 
 #include "intel_display_types.h"
 #include "intel_dvo_dev.h"
-- 
2.37.3

