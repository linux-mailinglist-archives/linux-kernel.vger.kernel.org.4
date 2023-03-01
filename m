Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1516A6818
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCAH0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCAH03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:26:29 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34560367D8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:25:55 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:54796.1458318350
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 8631C1002C5;
        Wed,  1 Mar 2023 15:25:07 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-698c9d7bb7-jn5ln with ESMTP id 48294dcf7aa94367ad8793e62cba7574 for maarten.lankhorst@linux.intel.com;
        Wed, 01 Mar 2023 15:25:54 CST
X-Transaction-ID: 48294dcf7aa94367ad8793e62cba7574
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   suijingfeng <15330273260@189.cn>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] MAINTAINERS: add maintainers for DRM LOONGSON driver
Date:   Wed,  1 Mar 2023 15:23:06 +0800
Message-Id: <20230301072306.572685-2-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301072306.572685-1-15330273260@189.cn>
References: <20230301072306.572685-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: suijingfeng <suijingfeng@loongson.cn>

 This patch add myself as maintainer to fix following warning when run
 ./scripts/checkpatch.pl

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
Signed-off-by: suijingfeng <15330273260@189.cn>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97d814a19475..bb1d84a9ec73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7022,6 +7022,13 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/lima/
 F:	include/uapi/drm/lima_drm.h
 
+DRM DRIVERS FOR LOONGSON LSDC
+M:	suijingfeng <suijingfeng@loongson.cn>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	drivers/gpu/drm/lsdc/
+
 DRM DRIVERS FOR MEDIATEK
 M:	Chun-Kuang Hu <chunkuang.hu@kernel.org>
 M:	Philipp Zabel <p.zabel@pengutronix.de>
-- 
2.25.1

