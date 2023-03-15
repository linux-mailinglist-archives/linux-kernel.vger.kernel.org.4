Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3486BBEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjCOVQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjCOVQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:16:27 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA7ABA56A7;
        Wed, 15 Mar 2023 14:16:08 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:37096.426874733
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id B2C2E1001EF;
        Thu, 16 Mar 2023 05:16:03 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-698c9d7bb7-s8g24 with ESMTP id 48d1bd1e33e946908228dbde16dbb378 for maarten.lankhorst@linux.intel.com;
        Thu, 16 Mar 2023 05:16:07 CST
X-Transaction-ID: 48d1bd1e33e946908228dbde16dbb378
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        suijingfeng <suijingfeng@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH v7 1/2] MAINTAINERS: add maintainers for DRM LOONGSON driver
Date:   Thu, 16 Mar 2023 05:15:49 +0800
Message-Id: <20230315211550.2620818-2-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315211550.2620818-1-15330273260@189.cn>
References: <20230315211550.2620818-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index abf52201a630..dfacd58c2134 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6909,6 +6909,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/lima/
 F:	include/uapi/drm/lima_drm.h
 
+DRM DRIVERS FOR LOONGSON
+M:	suijingfeng <suijingfeng@loongson.cn>
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+W:	https://www.loongson.cn/
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	drivers/gpu/drm/loongson/
+
 DRM DRIVERS FOR MEDIATEK
 M:	Chun-Kuang Hu <chunkuang.hu@kernel.org>
 M:	Philipp Zabel <p.zabel@pengutronix.de>
-- 
2.25.1

