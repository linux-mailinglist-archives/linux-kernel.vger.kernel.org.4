Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC8A5B926F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiIOB6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiIOB6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:58:19 -0400
Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7458E993
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:58:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VPqW7Ab_1663207091;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VPqW7Ab_1663207091)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 09:58:12 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 4/6] drm/amd/display: clean up some inconsistent indentings
Date:   Thu, 15 Sep 2022 09:58:00 +0800
Message-Id: <20220915015802.59967-4-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220915015802.59967-1-yang.lee@linux.alibaba.com>
References: <20220915015802.59967-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clean up some inconsistent indentings

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2180
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 .../amd/display/dc/dcn321/dcn321_resource.c   | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 1bbc0bdf5dc3..355b4b1d6628 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -820,11 +820,11 @@ static struct dce_i2c_hw *dcn321_i2c_hw_create(
 
 #undef REG_STRUCT
 #define REG_STRUCT i2c_hw_regs
-		i2c_inst_regs_init(1),
-		i2c_inst_regs_init(2),
-		i2c_inst_regs_init(3),
-		i2c_inst_regs_init(4),
-		i2c_inst_regs_init(5);
+	i2c_inst_regs_init(1),
+	i2c_inst_regs_init(2),
+	i2c_inst_regs_init(3),
+	i2c_inst_regs_init(4),
+	i2c_inst_regs_init(5);
 
 	dcn2_i2c_hw_construct(dce_i2c_hw, ctx, inst,
 				    &i2c_hw_regs[inst], &i2c_shifts, &i2c_masks);
@@ -922,10 +922,10 @@ static struct hubp *dcn321_hubp_create(
 
 #undef REG_STRUCT
 #define REG_STRUCT hubp_regs
-		hubp_regs_init(0),
-		hubp_regs_init(1),
-		hubp_regs_init(2),
-		hubp_regs_init(3);
+	hubp_regs_init(0),
+	hubp_regs_init(1),
+	hubp_regs_init(2),
+	hubp_regs_init(3);
 
 	if (hubp32_construct(hubp2, ctx, inst,
 			&hubp_regs[inst], &hubp_shift, &hubp_mask))
@@ -1670,10 +1670,10 @@ static bool dcn321_resource_construct(
 
 #undef REG_STRUCT
 #define REG_STRUCT abm_regs
-		abm_regs_init(0),
-		abm_regs_init(1),
-		abm_regs_init(2),
-		abm_regs_init(3);
+	abm_regs_init(0),
+	abm_regs_init(1),
+	abm_regs_init(2),
+	abm_regs_init(3);
 
 #undef REG_STRUCT
 #define REG_STRUCT dccg_regs
-- 
2.20.1.7.g153144c

