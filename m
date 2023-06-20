Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5674C73684C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjFTJsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjFTJsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:48:01 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCFCA118
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EVSAA
        Yeay8lPjMlTnk/Pgq9nLkaIdxvjcsr04P+ioqs=; b=LXZrzVH2IFDwFTBEMohO7
        OT6Z2xtO0wkCjfUAItR594nl3lhgF2XNzqIofEzrInLoHflwHdWPc4vT2aoNz2B8
        yXE01WfxvM83XHrzkeaO3lOl0TQ+N3o/syKEj4KJoi199KVtixG50MXSxLLbAcUQ
        QSLum8jGmNAUPAYdA6Ggrk=
Received: from openarena.loongson.cn (unknown [114.242.206.180])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wAXg3CldZFkB8yiAQ--.11241S12;
        Tue, 20 Jun 2023 17:47:19 +0800 (CST)
From:   Sui Jingfeng <18949883232@163.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v10 10/11] drm/etnaviv: Keep the curly brace aligned
Date:   Tue, 20 Jun 2023 17:47:15 +0800
Message-Id: <20230620094716.2231414-11-18949883232@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230620094716.2231414-1-18949883232@163.com>
References: <20230620094716.2231414-1-18949883232@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXg3CldZFkB8yiAQ--.11241S12
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1Utw1xtw13Zry5GFW7urg_yoW3Jrb_CF
        18Zr9rWrsIkr1ktr17Aa45ZFyIvFZ5ZanavwnFqas3K34DJr98Xrykuw1UXa4UJryxCFn8
        G3WkXF1rAF1xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn-o7tUUUUU==
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: jprymkizyyjjits6il2tof0z/1tbiEwmU0WE17eMXkQADsA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

No functional change.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 8907cdb8a1f8..c9f502a89de6 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -185,7 +185,7 @@ static int etnaviv_open(struct drm_device *dev, struct drm_file *file)
 			drm_sched_entity_init(&ctx->sched_entity[i],
 					      DRM_SCHED_PRIORITY_NORMAL, &sched,
 					      1, NULL);
-			}
+		}
 	}
 
 	file->driver_priv = ctx;
-- 
2.25.1

