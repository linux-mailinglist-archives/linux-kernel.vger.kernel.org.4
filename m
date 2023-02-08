Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4168E61A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBHCen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBHCem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:34:42 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D00B83C2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 18:34:40 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vb9eBbP_1675823672;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vb9eBbP_1675823672)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 10:34:38 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     hjc@rock-chips.com
Cc:     heiko@sntech.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/rockchip: dsi: Remove the unused function dsi_read()
Date:   Wed,  8 Feb 2023 10:34:29 +0800
Message-Id: <20230208023429.73696-1-jiapeng.chong@linux.alibaba.com>
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

The function dsi_read is defined in the dw-mipi-dsi-rockchip.c file, but
not called elsewhere, so remove this unused function.

drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c:362:19: warning: unused function 'dsi_read'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3984
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 7901c3babc8c..917e79951aac 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -359,11 +359,6 @@ static inline void dsi_write(struct dw_mipi_dsi_rockchip *dsi, u32 reg, u32 val)
 	writel(val, dsi->base + reg);
 }
 
-static inline u32 dsi_read(struct dw_mipi_dsi_rockchip *dsi, u32 reg)
-{
-	return readl(dsi->base + reg);
-}
-
 static void dw_mipi_dsi_phy_write(struct dw_mipi_dsi_rockchip *dsi,
 				  u8 test_code,
 				  u8 test_data)
-- 
2.20.1.7.g153144c

