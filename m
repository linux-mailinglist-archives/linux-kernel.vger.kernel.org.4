Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E756084F7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJVGKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJVGKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:10:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A36B89AE1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:10:10 -0700 (PDT)
X-QQ-mid: bizesmtp70t1666418995tiwrdkyn
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:09:54 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: RFp2QSjOiS6QmiDDKxdiLq0s+hEAd0pCWAwZ4O1D3n3zy6HZs3k051foEqJqU
        ZKJUDf06RY7iKw+Hja4nWiQhuYQ76perll8ekk1ufhP0lpSBtQ5y/j4zgkW7tXCP4X/KnUs
        /xgumMAtKoGkj/qc7LcpT3nXjeHphIf2Z3RVROm3764Rv30tZDKCoOksu2Tkylr7JYKTEEe
        98+uuU4V3lX6TVrn08p374R+LulzL2QFmwED0CfhEMLtm+Z+dtQXge4Rr4uowWZ8v35tE2C
        Lj/RS/Yzfs3tgmqx/H1NP/ZaoEsz5EMZjyhkZ5r66AXMQMzv1TV3m8FSyiEYazEiZGQ+tz2
        8FEFa8WcBQQ/Sa4Mz2TAEeAXaHY28wDaotC1O0WmxjwdE/oJqg=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] i915/display: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:09:47 +0800
Message-Id: <20221022060947.61179-1-wangjianli@cdjrlc.com>
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
 drivers/gpu/drm/i915/display/intel_crt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_crt.c b/drivers/gpu/drm/i915/display/intel_crt.c
index 6a3893c8ff22..fead011c87b5 100644
--- a/drivers/gpu/drm/i915/display/intel_crt.c
+++ b/drivers/gpu/drm/i915/display/intel_crt.c
@@ -1102,7 +1102,7 @@ void intel_crt_init(struct drm_i915_private *dev_priv)
 	drm_connector_helper_add(connector, &intel_crt_connector_helper_funcs);
 
 	/*
-	 * TODO: find a proper way to discover whether we need to set the the
+	 * TODO: find a proper way to discover whether we need to set the
 	 * polarity and link reversal bits or not, instead of relying on the
 	 * BIOS.
 	 */
-- 
2.36.1

