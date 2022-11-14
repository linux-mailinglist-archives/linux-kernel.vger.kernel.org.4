Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B1C627501
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiKNDfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiKNDfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:35:13 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EF415A0E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:35:11 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N9Zgx2ZR1z4xVnR;
        Mon, 14 Nov 2022 11:35:09 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 2AE3Z10W017281;
        Mon, 14 Nov 2022 11:35:01 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 14 Nov 2022 11:35:03 +0800 (CST)
Date:   Mon, 14 Nov 2022 11:35:03 +0800 (CST)
X-Zmail-TransId: 2b066371b767ffffffffd26f1041
X-Mailer: Zmail v1.0
Message-ID: <202211141135031107049@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <bskeggs@redhat.com>
Cc:     <kherbst@redhat.com>, <lyude@redhat.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <airlied@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRybS9ub3V2ZWF1L2ZpZm86IHJlbW92ZSBkdXBsaWNhdGVkIGluY2x1ZGVkIGNoaWQuaA==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AE3Z10W017281
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6371B76D.000 by FangMail milter!
X-FangMail-Envelope: 1668396909/4N9Zgx2ZR1z4xVnR/6371B76D.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6371B76D.000/4N9Zgx2ZR1z4xVnR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The chid.h is included more than once.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
index b7c9d6115bce..b19a3612b62e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
@@ -24,7 +24,6 @@
 #include "chan.h"
 #include "chid.h"
 #include "cgrp.h"
-#include "chid.h"
 #include "runl.h"
 #include "priv.h"

-- 
2.15.2
