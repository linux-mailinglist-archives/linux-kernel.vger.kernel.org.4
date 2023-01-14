Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B251F66AC33
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 16:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjANPl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 10:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjANPlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 10:41:55 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185B4659F
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673710887; bh=CSbwjpVP0TI8uoR+G2gX1VxXrvkg+JX5kZeE9DaLjlM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=LRotYzEEcWl3PUnmzk5MucPEwXn17uNTyg+SB9MlgyvsRE3GEj5G9IRdjmZujra7x
         TbtmiQLrOQ/iEFV3UdceIa9PIeKf5SqUQSM7qbjNVz2aPd2V2pWy1chpxW7Pv4Sen1
         fSRUzHe5LLsanHJ/sYFAQr8iqlQTPlrKRduHLtXw=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 14 Jan 2023 16:41:27 +0100 (CET)
X-EA-Auth: kx0hu53F1vxsnkhWrm67IQdYuYSD3t5Tz/rdKLzii8sKxaPs1Rqg5heKbrkjIR4CdFckkbd9PpvMh2Od+C1SphO8kWje3Y1o
Date:   Sat, 14 Jan 2023 21:11:22 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] drm/mediatek: dp: Remove extra semicolon
Message-ID: <Y8LNIt97qxLk8e70@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary semicolon at the end of switch block closing brace.
Issue identified using semicolon Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 9d085c05c49c..9da58ac5a8b8 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1693,7 +1693,7 @@ static int mtk_dp_training(struct mtk_dp *mtk_dp)
 				break;
 			default:
 				return -EINVAL;
-			};
+			}
 			continue;
 		}
 
-- 
2.34.1



