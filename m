Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD996084FD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJVGOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJVGOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:14:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729152B733A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:14:05 -0700 (PDT)
X-QQ-mid: bizesmtp69t1666419215t8higm51
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:13:33 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: +bXiSo2NuBddP4A69LU3WpK2yss/SD4kLWRfIaKg+B3eczPuTS+cndE8He8iu
        OyeU5eFwv4pt243eCRXRaH+F8QwOc0Qd8fAijYEqA1bLCrnzyyfDshaM4A2mYAfmkwEJzhV
        aAoGdC/kL3D5E99bswwtFnd1dLX5z8VsjEH7qDv59y+nmmS+C8QrohfIQWNdK8i73eXR0fA
        wwOEB31xLbqbIlaAToBwcu5WB2DnVeJ4Ws+iszmr/06VZNKwYaVIymVyYFx1c67OPd/FeTN
        AQ6d5DeuCdDtVrlZ1OzR1Txm+fkDUUGO8bglYMMBnYpKTfb/W8SNi+VhZP7m9Fh841j22fA
        Dx/zHnfHmJFHhh0E2tCc2h6cHCzqwiYb3n5HB5/uNteezJZq44=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drm/i915: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:13:27 +0800
Message-Id: <20221022061327.65275-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index b4f69364f9a1..7b29ef36941a 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -2785,7 +2785,7 @@ int intel_gvt_init_gtt(struct intel_gvt *gvt)
  * intel_gvt_clean_gtt - clean up mm components of a GVT device
  * @gvt: GVT device
  *
- * This function is called at the driver unloading stage, to clean up the
+ * This function is called at the driver unloading stage, to clean up
  * the mm components of a GVT device.
  *
  */
-- 
2.36.1

