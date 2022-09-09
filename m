Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64C5B3078
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiIIHh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiIIHgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF35D5725
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85D5F61EE6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6B0C43152;
        Fri,  9 Sep 2022 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708894;
        bh=V9KyA9AdtH65sc81jKgwrbI3vWcp+kOGuvKUr/NRIJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPP0jNtpiBOm+iZLcauXcSqCwp8RiTYzqKat17WjXrQGxPsMprvNfdSw8nF6CLkif
         xuw5e5ZFRH82ZjpdbChpVmfs2nchrA0wlJS+Jc0awDokM/v3MRpqyP/6wYvpcDPUC7
         dkENVaoUnuzCHXnwbtpG1c5wfKNY7QUgsF/lA1G1HdwuJxQZUWIUYP7EBFJq5qYvkT
         xSFu4/qWN6KLJOjZqqX7pzBLFluWNmTLfPRBabER2hP+VLM42bYUcN9AB99QLPa4/I
         +UD7puG4VXEXZbE+57ABkCaM6lbzWwb478qGP3XcyK06rxX/zWZgwWOU2+FWmQwIi0
         gpBm7ppPiafEw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXG-007FGN-7l;
        Fri, 09 Sep 2022 09:34:46 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/37] drm/i915: intel_dp_link_training.c: fix kernel-doc markup
Date:   Fri,  9 Sep 2022 09:34:19 +0200
Message-Id: <9083eab5fec72053b378512888146cc15c5fbcad.1662708705.git.mchehab@kernel.org>
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

The return code table is not properly marked, causing warnings
and being badly parsed by Sphinx:

    Documentation/gpu/i915:130: ./drivers/gpu/drm/i915/display/intel_dp_link_training.c:183: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/gpu/i915:130: ./drivers/gpu/drm/i915/display/intel_dp_link_training.c:186: WARNING: Definition list ends without a blank line; unexpected unindent.

Use table markups to fix it.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/display/intel_dp_link_training.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index d213d8ad1ea5..27c3b9f39c8b 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -177,12 +177,14 @@ static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEI
  * transparent mode link training mode.
  *
  * Returns:
+ * ====  =====================================================================
  *   >0  if LTTPRs were detected and the non-transparent LT mode was set. The
  *       DPRX capabilities are read out.
  *    0  if no LTTPRs or more than 8 LTTPRs were detected or in case of a
  *       detection failure and the transparent LT mode was set. The DPRX
  *       capabilities are read out.
  *   <0  Reading out the DPRX capabilities failed.
+ * ====  =====================================================================
  */
 int intel_dp_init_lttpr_and_dprx_caps(struct intel_dp *intel_dp)
 {
-- 
2.37.3

