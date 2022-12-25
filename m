Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C10655D70
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 16:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiLYPMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 10:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLYPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 10:12:37 -0500
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7354055B3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 07:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1671981151;
        bh=4gyYfY5apDGW/eosN7O7fVTHYhGTtevXrZrItFuw+RY=;
        h=From:To:Cc:Subject:Date;
        b=oCmK1U64X3go8UcSnrgV6qFnym0HtnCed4YNAPNwKfmCaLXI1yySo3kRZ68diGU1b
         b37ecjYL+UoOl0km5kKiLFt533fvGIjG/qZ3P+D33UVfE8JfUAtdF29/cpChCEPMF8
         Xa1WojyhKF8xh1mx5Skash0OOC+5T7hVSqwUfMQ0=
Received: from wen-VirtualBox.lan ([222.182.118.62])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 2CC05057; Sun, 25 Dec 2022 23:11:12 +0800
X-QQ-mid: xmsmtpt1671981072toki2hhed
Message-ID: <tencent_13506618BF90E7B2AA796A9920DC49BEF407@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeie/LjKgMA5F+5e/BGMMcXVUrtcQ09uXcIXZnVQf2Y9PHof42Hm7R
         q+XXsqJsIHOfpYJo0o4QBA5TKF3Uc2f68G9HY9qzQRS3RzjoDHtdthbpx8rG1dDCGG1B3R/WV9hY
         zldUkH98qcXF84DEoj23T9yQthTbJcEiN40XmEuBnnjr3xXNqjJE5LcgmH/uSYRGlbJ3W3qqn5nk
         u+706JgKWAODSz1tTRWoyxMQJeRUtkpey58LQ+Iw+iP3D8iDNTXU00EaYrp99nGMOsbDtolcQieT
         l/phISKm6/qxu+Yv1vcxRl8IZPwMtyrsklf+EMJp5AIPN0d2+0TCV+r9vY7ckVehWLLSzGs4IyJR
         DIXN5XVDTHOTQYFNRE6wzP8nAAbIOts9HJja6YST1Yo+vEypZrUaEhgZ6p+i+d29YhNBpinchcp4
         XiCssglylaikQStP+FpxAYxgKwQO3B0s43R+q2Z/IfpZYJzMQIc8EIPRQgXnZfZUWy+a14xPBaIN
         +epWLj/ugm5rl9a9C8KRVL2h07+/XXdU3mhHzcPFhd+PK7ZrOAc3F3m1VcYWganATKyx2b2N+Wo/
         bTVEB0LpySwjsue1liZ2WJl8k1jLaGnBeUth8PDJOhEmtqNxmNmd64UmQG9UIdxetHKHPfPwnjEe
         nQ9I8JJXYJJrOdx+RvawZ6U05ywm0UgUlKZSFaPnpY1fkQaQwslH8t77Wq0czQNkHLA/AvZkaGZo
         nTfk8CNqaw1M2nsg4X4Q7G5KG74xdBypNO459NmlSnqZoSxGHjgfLjmrLEckGuBHHFJj20Ua9XFh
         4HQWNvGUjHnZzE7cu7bX/kxJ8Ef3Mf+OqtY+ZsHzRPDe4viliLz/Ps1BHmEIXDe1wc8/TNnSEM5x
         mkjtVLii37EdkmSf+7FlkHswi4WiaF1xY9BqB0xzfOE9Sr0nmOc0kLBDEvNweIDrKZXNCOc2DWiD
         Sad9Y6pZHJmrw2CubzocZDW0VkTkrhUsW1djvqn+MSrCWrHTdOi/keu3MqbCbqLyDzvN3WcSo=
From:   wenyang.linux@foxmail.com
To:     Alex Deucher <alexander.deucher@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?q?Harry=C2=A0Wentland=C2=A0?= <harry.wentland@amd.com>,
        =?UTF-8?q?Leo=C2=A0Li=C2=A0?= <sunpeng.li@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?drm/amd/display:=C2=A0fix=C2=A0array-bounds?= =?UTF-8?q?=C2=A0errors=C2=A0in=20dc=5Fstream=5Fremove=5Fwriteback()?=
Date:   Sun, 25 Dec 2022 23:10:58 +0800
X-OQ-MSGID: <20221225151058.749344-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

The following errors occurred when using gcc 7.5.0-3ubuntu1~18.04:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function ‘dc_stream_remove_writeback’:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:543:55: warning: array subscript is above array bounds [-Warray-bounds]
     stream->writeback_info[j] = stream->writeback_info[i];
                                 ~~~~~~~~~~~~~~~~~~~~~~^~~
Add a check to make sure that num_wb_info won't overflowing the writeback_info buffer.

Fixes: 6fbefb84a98e ("drm/amd/display: Add DC core changes for DCN2")

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 20e534f73513..9825c30f2ca0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -481,6 +481,7 @@ bool dc_stream_add_writeback(struct dc *dc,
 	}
 
 	if (!isDrc) {
+		ASSERT(stream->num_wb_info + 1 <= MAX_DWB_PIPES);
 		stream->writeback_info[stream->num_wb_info++] = *wb_info;
 	}
 
@@ -526,6 +527,11 @@ bool dc_stream_remove_writeback(struct dc *dc,
 		return false;
 	}
 
+	if (stream->num_wb_info > MAX_DWB_PIPES) {
+		dm_error("DC: num_wb_info is invalid!\n");
+		return false;
+	}
+
 //	stream->writeback_info[dwb_pipe_inst].wb_enabled = false;
 	for (i = 0; i < stream->num_wb_info; i++) {
 		/*dynamic update*/
@@ -540,7 +546,8 @@ bool dc_stream_remove_writeback(struct dc *dc,
 		if (stream->writeback_info[i].wb_enabled) {
 			if (j < i)
 				/* trim the array */
-				stream->writeback_info[j] = stream->writeback_info[i];
+				memcpy(&stream->writeback_info[j], &stream->writeback_info[i],
+						sizeof(struct dc_writeback_info));
 			j++;
 		}
 	}
-- 
2.25.1

