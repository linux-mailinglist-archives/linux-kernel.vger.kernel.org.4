Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D359D6008FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJQIoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJQIoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:44:16 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDED2D1E1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:44:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VSLCgh6_1665996241;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VSLCgh6_1665996241)
          by smtp.aliyun-inc.com;
          Mon, 17 Oct 2022 16:44:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     hjc@rock-chips.com
Cc:     heiko@sntech.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/rockchip: dsi: Remove the unused function dsi_update_bits()
Date:   Mon, 17 Oct 2022 16:43:30 +0800
Message-Id: <20221017084330.94117-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dsi_update_bits() is defined in the dw-mipi-dsi-rockchip.c
file, but not called elsewhere, so delete this unused function.

drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c:367:20: warning: unused function 'dsi_update_bits'.

https://bugzilla.openanolis.cn/show_bug.cgi?id=2414
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index bf6948125b84..313231d886d2 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -364,12 +364,6 @@ static inline u32 dsi_read(struct dw_mipi_dsi_rockchip *dsi, u32 reg)
 	return readl(dsi->base + reg);
 }
 
-static inline void dsi_update_bits(struct dw_mipi_dsi_rockchip *dsi, u32 reg,
-				   u32 mask, u32 val)
-{
-	dsi_write(dsi, reg, (dsi_read(dsi, reg) & ~mask) | val);
-}
-
 static void dw_mipi_dsi_phy_write(struct dw_mipi_dsi_rockchip *dsi,
 				  u8 test_code,
 				  u8 test_data)
-- 
2.20.1.7.g153144c

