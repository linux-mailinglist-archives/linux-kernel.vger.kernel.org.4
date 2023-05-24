Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7166B70F46A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjEXKlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEXKlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:41:05 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20B2139
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:41:01 -0700 (PDT)
X-UUID: 319a4933efcb48debdac32218feb0ddf-20230524
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:2b106396-7ad2-4e47-b070-7eac482c0e0b,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:2b106396-7ad2-4e47-b070-7eac482c0e0b,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:63ebe3c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230524184057H6SO669B,BulkQuantity:0,Recheck:0,SF:17|19|44|24|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 319a4933efcb48debdac32218feb0ddf-20230524
X-User: pengfuyuan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <pengfuyuan@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 763305722; Wed, 24 May 2023 18:40:54 +0800
From:   pengfuyuan <pengfuyuan@kylinos.cn>
To:     David Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pengfuyuan <pengfuyuan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] drm/i915/pxp:fix kernel-doc trivial warnings
Date:   Wed, 24 May 2023 18:40:52 +0800
Message-Id: <20230524104052.1488836-1-pengfuyuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test robot reports some make warnings.

Fix those warnings:
    drivers/gpu/drm/i915/pxp/intel_pxp_types.h:96: warning: Function parameter or member 'dev_link' not described in 'intel_pxp'

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
---
 drivers/gpu/drm/i915/pxp/intel_pxp_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_types.h b/drivers/gpu/drm/i915/pxp/intel_pxp_types.h
index 007de49e1ea4..41994a3294a0 100644
--- a/drivers/gpu/drm/i915/pxp/intel_pxp_types.h
+++ b/drivers/gpu/drm/i915/pxp/intel_pxp_types.h
@@ -33,7 +33,7 @@ struct intel_pxp {
 	 */
 	struct i915_pxp_component *pxp_component;
 
-	/* @dev_link: Enforce module relationship for power management ordering. */
+	/** @dev_link: Enforce module relationship for power management ordering. */
 	struct device_link *dev_link;
 	/**
 	 * @pxp_component_added: track if the pxp component has been added.
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
