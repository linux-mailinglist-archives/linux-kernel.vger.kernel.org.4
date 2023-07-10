Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3F874D347
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGJKYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjGJKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:24:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE5F95
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:24:16 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxDOtP3KtkHxkDAA--.3709S3;
        Mon, 10 Jul 2023 18:24:15 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx7yNP3Ktk6SYnAA--.5526S2;
        Mon, 10 Jul 2023 18:24:15 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Li Yi <liyi@loongson.cn>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/loongson: Remove a useless check in cursor_plane_atomic_async_check()
Date:   Mon, 10 Jul 2023 18:24:11 +0800
Message-Id: <20230710102411.257970-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx7yNP3Ktk6SYnAA--.5526S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWDXrykAr18GrW3CF48AFc_yoW8tF1rp3
        9FkryFkrW5Jrn7tr9rJwn8KrZxuayxGryIgFWUGw1SqFW0kry3Jr1kurZrurW7ZrW7G347
        trn7CFs0ga1UK3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU8uuWJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because smatch warnings:

drivers/gpu/drm/loongson/lsdc_plane.c:199
lsdc_cursor_plane_atomic_async_check()
warn: variable dereferenced before check 'state' (see line 180)

vim +/state +199 drivers/gpu/drm/loongson/lsdc_plane.c

174  static int
     lsdc_cursor_plane_atomic_async_check(struct drm_plane *plane,
175                                       struct drm_atomic_state *state)
176  {
177          struct drm_plane_state *new_state;
178          struct drm_crtc_state *crtc_state;
179
180          new_state = drm_atomic_get_new_plane_state(state, plane);
                                                        ^^^^^
state is dereferenced inside this function

181
182  if (!plane->state || !plane->state->fb) {
183          drm_dbg(plane->dev, "%s: state is NULL\n", plane->name);
184                  return -EINVAL;
185  }
186
187  if (new_state->crtc_w != new_state->crtc_h) {
188          drm_dbg(plane->dev, "unsupported cursor size: %ux%u\n",
189                  new_state->crtc_w, new_state->crtc_h);
190          return -EINVAL;
191  }
192
193  if (new_state->crtc_w != 64 && new_state->crtc_w != 32) {
194          drm_dbg(plane->dev, "unsupported cursor size: %ux%u\n",
195                  new_state->crtc_w, new_state->crtc_h);
196          return -EINVAL;
197  }
198
199  if (state) {
         ^^^^^
Checked too late!

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202307100423.rV7D05Uq-lkp@intel.com/
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/loongson/lsdc_plane.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loongson/lsdc_plane.c
index 2ab3db982aa3..0d5094633222 100644
--- a/drivers/gpu/drm/loongson/lsdc_plane.c
+++ b/drivers/gpu/drm/loongson/lsdc_plane.c
@@ -196,13 +196,7 @@ static int lsdc_cursor_plane_atomic_async_check(struct drm_plane *plane,
 		return -EINVAL;
 	}
 
-	if (state) {
-		crtc_state = drm_atomic_get_existing_crtc_state(state, new_state->crtc);
-	} else {
-		crtc_state = plane->crtc->state;
-		drm_dbg(plane->dev, "%s: atomic state is NULL\n", plane->name);
-	}
-
+	crtc_state = drm_atomic_get_existing_crtc_state(state, new_state->crtc);
 	if (!crtc_state->active)
 		return -EINVAL;
 
-- 
2.34.1

