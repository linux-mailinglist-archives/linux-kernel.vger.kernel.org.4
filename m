Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5128C691C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjBJKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBJKME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:12:04 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880221E29D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676023916; bh=x+ol1GuNj8lUXdFUy7nxKOB8qI/lJjjjqxkzLP1nqOw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=JnXbx6RggW44GxhVaoNgfRgYHxNza8uwi30lCmECTQeL5hBiD78bdPbO8uGkkllb8
         OjdBvGsgiIyVmEFnnbBkMq45PZXtEpzc5IYJTRmUWB0C497vNK217KAzFDawAbLPf7
         daOtlp1doW7rLqvbyYgBkp5yY/7Sv1mSpooczEko=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 10 Feb 2023 11:11:56 +0100 (CET)
X-EA-Auth: Sbo/qh16eOqtAod7achHJ2BQWyUw0RzOgHfBeqtWPLNJkGnX2y+0U4r0fl9kq+vO9W22HHcxNd2Jf7pKXsZKrnu39qbRGlxE
Date:   Fri, 10 Feb 2023 15:41:51 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] drm/amd/display: Remove duplicate/repeating expression
Message-ID: <Y+YYZ4SbMQBcpTZP@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate or repeating expressions in the if condition
evaluation. Issue identified using doubletest.cocci Coccinelle semantic
patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index 61ee9ba063a7..6576b897a512 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -51,7 +51,7 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
 		*BytePerPixelDETC = 0;
 		*BytePerPixelY = 4;
 		*BytePerPixelC = 0;
-	} else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16) {
+	} else if (SourcePixelFormat == dm_444_16) {
 		*BytePerPixelDETY = 2;
 		*BytePerPixelDETC = 0;
 		*BytePerPixelY = 2;
-- 
2.34.1



