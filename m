Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4CB68D3D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjBGKOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjBGKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:14:08 -0500
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 02:14:07 PST
Received: from st43p00im-zteg10063501.me.com (st43p00im-zteg10063501.me.com [17.58.63.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC572559C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1675764394;
        bh=uy/u/jBsLuDEhP7DZbXSmCIaVmd50OFJVFk6lVxCMTQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=WE5GgMq/MzwH3oRueLocrSeoZKe//cptxsnNPSY1ZBvNgM05+hC8sEMOsNN5hBhzZ
         C9i09bsvt7WkMCX0sjEZXoBP/Q6oG1v/9+ypNeEbIdjctQDhAIWH35s9pIcBtTbLkm
         VhbMC5+z6c7FCo+wkYEReLGEbhrTFeIgrPVSS1hoIhDVmWQ6iZU7nNuxanUVep+sYn
         Cwdn2HNfqRJKLV9vX79byWHAEuhdofpGC4UqjujvfUodn2d94kMJNWlzpStXiy/jk9
         MWUqibOgw4NF+4jMyHdWnAXKbSphTdorNV5Wr3brrkUQJVta4TKuLuVBh0KdosMKDa
         zBY/KIbGporHw==
Received: from apollo.fritz.box (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-zteg10063501.me.com (Postfix) with ESMTPSA id 308374C17A5;
        Tue,  7 Feb 2023 10:06:33 +0000 (UTC)
From:   Lucy Mielke <mielkesteven@icloud.com>
To:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: [PATCH] fbdev: omapfb: cleanup inconsistent indentation
Date:   Tue,  7 Feb 2023 11:06:30 +0100
Message-Id: <20230207100630.11644-1-mielkesteven@icloud.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Gq_PqnEGhE0xunAGRdTHGMQPVdHOi2Vh
X-Proofpoint-ORIG-GUID: Gq_PqnEGhE0xunAGRdTHGMQPVdHOi2Vh
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=681 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302070090
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up the indentation according to the Linux kernel coding
style, and should fix the warning created by the kernel test robot.

Fixes: 8b08cf2b64f5a60594b07795b2ad518c6d044566 ("OMAP: add TI OMAP
	framebuffer driver")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lucy Mielke <mielkesteven@icloud.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 32 +++++++++++++++-----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 1f3df2055ff0..4b673daa32cb 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -78,7 +78,7 @@ static struct platform_device omapdss_device = {
 	.name		= "omapdss_dss",
 	.id		= -1,
 	.dev            = {
-		.release = omapdss_release,
+	.release	= omapdss_release,
 	},
 };
 
@@ -544,19 +544,25 @@ static int set_fb_var(struct fb_info *fbi,
 		var->yoffset = var->yres_virtual - var->yres;
 
 	if (plane->color_mode == OMAPFB_COLOR_RGB444) {
-		var->red.offset	  = 8; var->red.length	 = 4;
-						var->red.msb_right   = 0;
-		var->green.offset = 4; var->green.length = 4;
-						var->green.msb_right = 0;
-		var->blue.offset  = 0; var->blue.length  = 4;
-						var->blue.msb_right  = 0;
+		var->red.offset		= 8; 
+		var->red.length		= 4;
+		var->red.msb_right	= 0;
+		var->green.offset	= 4; 
+		var->green.length	= 4;
+		var->green.msb_right	= 0;
+		var->blue.offset	= 0; 
+		var->blue.length	= 4;
+		var->blue.msb_right	= 0;
 	} else {
-		var->red.offset	 = 11; var->red.length	 = 5;
-						var->red.msb_right   = 0;
-		var->green.offset = 5;  var->green.length = 6;
-						var->green.msb_right = 0;
-		var->blue.offset = 0;  var->blue.length  = 5;
-						var->blue.msb_right  = 0;
+		var->red.offset		= 11; 
+		var->red.length		= 5;
+		var->red.msb_right	= 0;
+		var->green.offset	= 5;  
+		var->green.length	= 6;
+		var->green.msb_right	= 0;
+		var->blue.offset	= 0;
+		var->blue.length	= 5;
+		var->blue.msb_right	= 0;
 	}
 
 	var->height		= -1;
-- 
2.39.1

