Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBA95F04E1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiI3Gim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiI3Gii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:38:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D91411F7CA;
        Thu, 29 Sep 2022 23:38:33 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mf0nJ4BDyz1P6yT;
        Fri, 30 Sep 2022 14:34:12 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 kwepemi500009.china.huawei.com (7.221.188.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 14:38:29 +0800
From:   Dong Chenchen <dongchenchen2@huawei.com>
To:     <airlied@gmail.com>, <daniel@ffwll.ch>
CC:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Xinhui.Pan@amd.com>,
        <alexander.deucher@amd.com>, <Jerry.Zuo@amd.com>,
        <yuehaibing@huawei.com>, <linux-mips@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH -next] drm/amd/display: Removed unused variable 'sdp_stream_enable'
Date:   Fri, 30 Sep 2022 14:38:27 +0800
Message-ID: <20220930063827.1835856-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c:
In function 'dcn31_hpo_dp_stream_enc_update_dp_info_packets':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c:439:14:
warning: variable 'sdp_stream_enable' set but not used
[-Wunused-but-set-variable]
   439 |         bool sdp_stream_enable = false;

Removed unused variable 'sdp_stream_enable'.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c       | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index 23621ff08c90..7daafbab98da 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -436,32 +436,28 @@ static void dcn31_hpo_dp_stream_enc_update_dp_info_packets(
 {
 	struct dcn31_hpo_dp_stream_encoder *enc3 = DCN3_1_HPO_DP_STREAM_ENC_FROM_HPO_STREAM_ENC(enc);
 	uint32_t dmdata_packet_enabled = 0;
-	bool sdp_stream_enable = false;
 
-	if (info_frame->vsc.valid) {
+	if (info_frame->vsc.valid)
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				0,  /* packetIndex */
 				&info_frame->vsc,
 				true);
-		sdp_stream_enable = true;
-	}
-	if (info_frame->spd.valid) {
+
+	if (info_frame->spd.valid)
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				2,  /* packetIndex */
 				&info_frame->spd,
 				true);
-		sdp_stream_enable = true;
-	}
-	if (info_frame->hdrsmd.valid) {
+
+	if (info_frame->hdrsmd.valid)
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				3,  /* packetIndex */
 				&info_frame->hdrsmd,
 				true);
-		sdp_stream_enable = true;
-	}
+
 	/* enable/disable transmission of packet(s).
 	 * If enabled, packet transmission begins on the next frame
 	 */
-- 
2.25.1

