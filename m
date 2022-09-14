Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9E65B80E0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiINF2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiINF2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:28:34 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DCE6E2DC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:28:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VPlkWyO_1663133287;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPlkWyO_1663133287)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 13:28:10 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 5/8] drm/amd/display: make mmhubbub32_config_mcif_buf static
Date:   Wed, 14 Sep 2022 13:27:39 +0800
Message-Id: <20220914052742.116297-5-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220914052742.116297-1-jiapeng.chong@linux.alibaba.com>
References: <20220914052742.116297-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of dcn32_mmhubbub.c, so marks it static.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_mmhubbub.c:103:6: warning: no previous prototype for ‘mmhubbub32_config_mcif_buf’.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2145
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c
index adf93cc8359c..41b0baf8e183 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c
@@ -100,7 +100,7 @@ static void mmhubbub32_warmup_mcif(struct mcif_wb *mcif_wb,
 	REG_UPDATE(MMHUBBUB_WARMUP_CONTROL_STATUS, MMHUBBUB_WARMUP_EN, false);
 }
 
-void mmhubbub32_config_mcif_buf(struct mcif_wb *mcif_wb,
+static void mmhubbub32_config_mcif_buf(struct mcif_wb *mcif_wb,
 		struct mcif_buf_params *params,
 		unsigned int dest_height)
 {
-- 
2.20.1.7.g153144c

