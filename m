Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB3628F84
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiKOBtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKOBtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:49:09 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC90560FB;
        Mon, 14 Nov 2022 17:49:07 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VUqrO2I_1668476944;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VUqrO2I_1668476944)
          by smtp.aliyun-inc.com;
          Tue, 15 Nov 2022 09:49:05 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     robdclark@gmail.com
Cc:     quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@gmail.com, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/msm/dpu: Fix some kernel-doc comments
Date:   Tue, 15 Nov 2022 09:49:02 +0800
Message-Id: <20221115014902.45240-1-yang.lee@linux.alibaba.com>
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

Make the description of @init to @p in dpu_encoder_phys_wb_init()
and remove @wb_roi in dpu_encoder_phys_wb_setup_fb() to clear the below
warnings:

drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:139: warning: Excess function parameter 'wb_roi' description in 'dpu_encoder_phys_wb_setup_fb'
drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:699: warning: Function parameter or member 'p' not described in 'dpu_encoder_phys_wb_init'
drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:699: warning: Excess function parameter 'init' description in 'dpu_encoder_phys_wb_init'

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3067
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 7cbcef6efe17..62f6ff6abf41 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -132,7 +132,6 @@ static void dpu_encoder_phys_wb_set_qos(struct dpu_encoder_phys *phys_enc)
  * dpu_encoder_phys_wb_setup_fb - setup output framebuffer
  * @phys_enc:	Pointer to physical encoder
  * @fb:		Pointer to output framebuffer
- * @wb_roi:	Pointer to output region of interest
  */
 static void dpu_encoder_phys_wb_setup_fb(struct dpu_encoder_phys *phys_enc,
 		struct drm_framebuffer *fb)
@@ -692,7 +691,7 @@ static void dpu_encoder_phys_wb_init_ops(struct dpu_encoder_phys_ops *ops)
 
 /**
  * dpu_encoder_phys_wb_init - initialize writeback encoder
- * @init:	Pointer to init info structure with initialization params
+ * @p:	Pointer to init info structure with initialization params
  */
 struct dpu_encoder_phys *dpu_encoder_phys_wb_init(
 		struct dpu_enc_phys_init_params *p)
-- 
2.20.1.7.g153144c

