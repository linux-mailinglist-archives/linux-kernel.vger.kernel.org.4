Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090006730F0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjASFFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjASFFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:05:01 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E9B366BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 20:59:32 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Ny7L75G5wz1DsP
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:25:19 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4Ny7Hw4p3bzBRK7X
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:23:24 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4Ny7Fx01Plz9tyJY
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:21:41 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Ny7B06HbQz8R040
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:18:16 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Ny77V0JPtz501RH;
        Thu, 19 Jan 2023 11:16:06 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 30J3FwLe065875;
        Thu, 19 Jan 2023 11:15:58 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 19 Jan 2023 11:15:59 +0800 (CST)
Date:   Thu, 19 Jan 2023 11:15:59 +0800 (CST)
X-Zmail-TransId: 2af963c8b5ef5f2f9319
X-Mailer: Zmail v1.0
Message-ID: <202301191115594503875@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <maarten.lankhorst@linux.intel.com>
Cc:     <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vYnJpZGdlOiBSZW1vdmUgY29tcGlsYXRpb24gZXJyb3I=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30J3FwLe065875
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 63C8B81E.001 by FangMail milter!
X-FangMail-Envelope: 1674098719/4Ny7L75G5wz1DsP/63C8B81E.001/10.35.20.121/[10.35.20.121]/mxde.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C8B81E.001/4Ny7L75G5wz1DsP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

drivers/gpu/drm/vc4/vc4_dsi.c :1822:13: error: 'struct drm_bridge' has
 no member named 'of_node'.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 include/drm/drm_bridge.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 42f86327b40a..1f84a8d491c7 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -715,10 +715,8 @@ struct drm_bridge {
 	struct drm_encoder *encoder;
 	/** @chain_node: used to form a bridge chain */
 	struct list_head chain_node;
-#ifdef CONFIG_OF
 	/** @of_node: device node pointer to the bridge */
 	struct device_node *of_node;
-#endif
 	/** @list: to keep track of all added bridges */
 	struct list_head list;
 	/**
-- 
2.25.1
