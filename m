Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59F16084EE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJVGHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJVGHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:07:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6D52B4155
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:07:19 -0700 (PDT)
X-QQ-mid: bizesmtp62t1666418829tqj9mya4
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:07:07 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: vqKIKKdRGsxDH5i+9QIw5s1dQzvr+IZCA0gIoU16ztiaT59WKq8wUX+0LbcR0
        yMA/pJnmYjsuLH5NDDv9uGhlb1XKpdptLRAu9sOmWomcyrBGZcBvjPPSiLtah4Z788oPgpL
        f1GyRAmfG7xzzWb1diH6u+zh3j9Ruftv8aPIy7vT5WYsl8kxbGWhPRnOVDmNGCI0qY0xBvU
        Jrnhw+TO8/tgDOq7l8Cf0o0FJN+MeiJShVh6RaaHAE5RHe2HBJzkExi5kpeSE5t0ELVAGio
        cfEJyzLTqzcz5yBPv7jFGR22oJBph7VhtyOwDscRM/8jLZ4cpjf0aayqP35kmm9U2uGX6Lt
        fnboXCXDwhlZkW4X2EKUSEQPk83CCtsYw7sS5YCgvHixJOVeRc=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] gpu/drm: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:07:01 +0800
Message-Id: <20221022060701.58280-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/drm_rect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_rect.c b/drivers/gpu/drm/drm_rect.c
index 0460e874896e..85c79a38c13a 100644
--- a/drivers/gpu/drm/drm_rect.c
+++ b/drivers/gpu/drm/drm_rect.c
@@ -80,7 +80,7 @@ static u32 clip_scaled(int src, int dst, int *clip)
  * @dst: destination window rectangle
  * @clip: clip rectangle
  *
- * Clip rectangle @dst by rectangle @clip. Clip rectangle @src by the
+ * Clip rectangle @dst by rectangle @clip. Clip rectangle @src by
  * the corresponding amounts, retaining the vertical and horizontal scaling
  * factors from @src to @dst.
  *
-- 
2.36.1

