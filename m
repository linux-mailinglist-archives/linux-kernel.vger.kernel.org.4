Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0736084F9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJVGMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJVGMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:12:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5A12B733A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:12:11 -0700 (PDT)
X-QQ-mid: bizesmtp72t1666419090t2pfz62r
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:11:28 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: +iNLrXnFj0k+EbC2myCFz75BvZWKEuI3WDsoOZH31qWz0vux+iFscYL/VtzGg
        6TJ0wSBAkDHTwxX6PR3ryd/4coCkgEUPCBp1EDvFJrvOCdtb6mzKQOW4G5hMGo4QYCKda9E
        pbSt+Br0px3u0ISxaCbeWF491ljJUieECaEXky/rtLDe80451R5PR2AJ0DVcRccJ4ND1etK
        gw4PxF77S3x/K6Xf+oMxuxeOY2ytZ0nfH/3yIhaEUG8MF19X01xuJ+lYdngeEKqatcEXGQW
        4oY69IfaD789mydiSl81oWPU2Hr3DMRHUIaNdcrOF9PGUva17IRetjysUy5GFq80gwvFJ/D
        adN44RZjkcmN2qqACFJ6++UvvVWRJaDbgt/RRJSGXK6f4HFV54=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drm/i915: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:11:22 +0800
Message-Id: <20221022061122.62990-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/i915/i915_request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 73d5195146b0..9caf99a13c61 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -1735,7 +1735,7 @@ __i915_request_add_to_timeline(struct i915_request *rq)
 }
 
 /*
- * NB: This function is not allowed to fail. Doing so would mean the the
+ * NB: This function is not allowed to fail. Doing so would mean the
  * request is not being tracked for completion but the work itself is
  * going to happen on the hardware. This would be a Bad Thing(tm).
  */
-- 
2.36.1

