Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D52735717
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjFSMnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjFSMm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:42:27 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ABA7F9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:42:22 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:49634.708654646
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id D8EE010299B;
        Mon, 19 Jun 2023 20:42:19 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xwndj with ESMTP id 3963c01ed2f142e5934dee2e8a8f5cd0 for l.stach@pengutronix.de;
        Mon, 19 Jun 2023 20:42:20 CST
X-Transaction-ID: 3963c01ed2f142e5934dee2e8a8f5cd0
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v10 11/11] drm/etnaviv: Replace of_platform.h with explicit includes
Date:   Mon, 19 Jun 2023 20:42:01 +0800
Message-Id: <20230619124201.2215558-12-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619124201.2215558-1-15330273260@189.cn>
References: <20230619124201.2215558-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

Etnaviv doesn't use anything from of_platform.h, but depends on
of.h, of_device.h, and platform_device.h which are all implicitly
included, but that is going to be removed soon.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index c9f502a89de6..ee47efff42a6 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -7,8 +7,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/dma-map-ops.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/uaccess.h>
 
 #include <drm/drm_debugfs.h>
-- 
2.25.1

