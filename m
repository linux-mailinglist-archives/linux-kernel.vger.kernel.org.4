Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91B75B3084
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiIIHhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiIIHgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:36:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA83D021E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E3ED61EE1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512EFC43153;
        Fri,  9 Sep 2022 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708894;
        bh=zi8sWCWjHVPPumC67pt3VnnXclezbQDo0fx8bRzzovM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sz04HTxS8dwSC+YbXzxOQ+iIpKxhCeohwS1lt/uStyE3RRW2bO8rH4OSnauKQNBdx
         mGeGBR8PeEkRQQBS8Z+CJEY0ts+ojyaKvfB6oNOxKcbV8thb78nDbvN08fXeYVKOyD
         K8Gm+VJchFTYkJU/EW/8AHE2AllwUf84dJRaPTUlbuvYxjT1ccxy2S0SpOq+m+9w0H
         a2QNGQu2ErB2YaWto43XSjgxVDOduqM5OK/Q2nBCejZ8ako9u6Nlb61WpMW9usefXp
         V4ANauXNb/xeiNQFfcnuW5D473ZtrpjnLnI6B6AD6G+8o7WIflWk3HauyyH8Y34l2u
         PU3GaPwIXezuw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXG-007FGR-9O;
        Fri, 09 Sep 2022 09:34:46 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Juha-Pekka=20Heikkil=C3=A4?= 
        <juha-pekka.heikkila@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/37] drm/i915: intel_fb: fix a kernel-doc issue with Sphinx
Date:   Fri,  9 Sep 2022 09:34:20 +0200
Message-Id: <abfceecf956216985b8e107909ba2bf95fe9adaa.1662708705.git.mchehab@kernel.org>
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

We can't use %foo[<something>] as this produces a bad markup.
Use instead, the emphasis markup directly.

Fix this issue:
	Documentation/gpu/i915:136: ./drivers/gpu/drm/i915/display/intel_fb.c:280: WARNING: Inline strong start-string without end-string.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/display/intel_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
index eefa33c555ac..ba413e38033d 100644
--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -276,7 +276,7 @@ lookup_format_info(const struct drm_format_info formats[],
  * @cmd: FB add command structure
  *
  * Returns:
- * Returns the format information for @cmd->pixel_format specific to @cmd->modifier[0],
+ * Returns the format information for @cmd->pixel_format specific to ``cmd->modifier[0]``,
  * or %NULL if the modifier doesn't override the format.
  */
 const struct drm_format_info *
-- 
2.37.3

