Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E15A5B30A0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiIIHjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiIIHiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:38:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913569F74E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5477E61F0F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08182C4167A;
        Fri,  9 Sep 2022 07:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708895;
        bh=hzUkiXC8poEW7PSNZ3y+1t01Krzj3+KpWCjMfiGyzFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrTp5RRjPFsW8KobeSqOT3qCsDklniuWOO3RlcN6JfhP1GTxLqLH/OKoed8eTiw2R
         K2Q9jYA0ADLd0npLp+ph23TF5zPRaSzPqoGGXYN2r7fKrFGRwEN1pAA3UqU/8ggEOu
         SVRX+foBR3AmbluFMwkehtrAjLCmiUCPU6mEQd/QHT1YpDQJ+kaPZFo4lkcnlz4yHF
         luluW5YioSvX0k1uCw2jN+h3an+EQ6nqpWlEAZ0n1azlv7clkq0usC0cUmR1rg+fQ4
         6dMu7HJJ49MIYuYQhVgl7UBZ/Pawxqwb71D3DJXk7yUUUkDBjJNWq5qNc/JB6qfVeE
         44bHtOXqAKHHw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXH-007FHD-0n;
        Fri, 09 Sep 2022 09:34:47 +0200
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
Subject: [PATCH v3 25/37] drm/i915: i915_deps: use a shorter title markup
Date:   Fri,  9 Sep 2022 09:34:32 +0200
Message-Id: <5289f6f591addc53604d35872bcc32d5fadf0a69.1662708705.git.mchehab@kernel.org>
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

The DOC: tag waits for a one-line short title for the doc
section. Using multiple lines will produce a weird output.
So, add a shorter description for the title, while keeping
the current content below it.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/i915_deps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_deps.c b/drivers/gpu/drm/i915/i915_deps.c
index 297b8e4e42ee..df6af832e3f2 100644
--- a/drivers/gpu/drm/i915/i915_deps.c
+++ b/drivers/gpu/drm/i915/i915_deps.c
@@ -11,7 +11,9 @@
 #include "i915_deps.h"
 
 /**
- * DOC: Set of utilities to dynamically collect dependencies into a
+ * DOC: Utilities to collect dependencies for GT migration code
+ *
+ * Set of utilities to dynamically collect dependencies into a
  * structure which is fed into the GT migration code.
  *
  * Once we can do async unbinding, this is also needed to coalesce
-- 
2.37.3

