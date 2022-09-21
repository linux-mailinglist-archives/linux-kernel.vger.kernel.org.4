Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB7A5BF525
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiIUEHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIUEHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:07:53 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36BF7B7AC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:07:51 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 28L3ktid031000;
        Wed, 21 Sep 2022 11:46:55 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Sep
 2022 12:07:44 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
        <john.stultz@linaro.org>, <kong.kongxinwei@hisilicon.com>,
        <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <javierm@redhat.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/hisilicon/kirin: Fix typo in kirin_drm_drv.c
Date:   Wed, 21 Sep 2022 12:08:01 +0800
Message-ID: <20220921040801.13537-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 28L3ktid031000
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'config_max_height' should be used for 'max_height'.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 2af51df6dca7..b23ad03157e1 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -165,7 +165,7 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;
 	dev->mode_config.max_width = driver_data->config_max_width;
-	dev->mode_config.max_height = driver_data->config_max_width;
+	dev->mode_config.max_height = driver_data->config_max_height;
 	dev->mode_config.funcs = driver_data->mode_config_funcs;
 
 	/* display controller init */
-- 
2.25.1

