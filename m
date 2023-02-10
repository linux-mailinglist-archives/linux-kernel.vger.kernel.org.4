Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A9D691C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjBJKBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjBJKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:01:21 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5454E7B145
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676023251; bh=OSyoTpdJIQ68wdvoa27f76+Ft7Eat4Qqrj2ni75ZjlY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=dLN2v0lJNO/R9XxljsTYyDGzEDcp46LY7SNLllVfNCzD59qU1Xfh2AAjjb77EzHlD
         0iCewyeMeYqIgOf9b9gL22kOyJnhRoj1jaIRP20lGA/uckiiTteo1Y2WYCAzHKM14E
         86VlK2KInkvDzlH/OUhk76ITv+OKG7NbznBa4rmI=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 10 Feb 2023 11:00:51 +0100 (CET)
X-EA-Auth: Nf6tPsEPxv5OhlOXiVf8OdDvgK+wSKjuCHgTMdsYfS0p/LNkCjDFiz1fDavnjR+SPdxr0xlQkEZmnQxvn4NhObJwXjiOC9io
Date:   Fri, 10 Feb 2023 15:30:43 +0530
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
Subject: [PATCH] drm/amd/display: Remove duplicate/repeating expressions
Message-ID: <Y+YVy7RaxnXokJ3l@ubun2204.myguest.virtualbox.org>
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
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c    | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 4b8f5fa0f0ad..ae89760d887d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -2335,8 +2335,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 			if (mode_lib->vba.DSCEnable[k] && mode_lib->vba.ForcedOutputLinkBPP[k] != 0)
 				mode_lib->vba.DSCOnlyIfNecessaryWithBPP = true;
-			if ((mode_lib->vba.DSCEnable[k] || mode_lib->vba.DSCEnable[k])
-					&& mode_lib->vba.OutputFormat[k] == dm_n422
+			if (mode_lib->vba.DSCEnable[k] && mode_lib->vba.OutputFormat[k] == dm_n422
 					&& !mode_lib->vba.DSC422NativeSupport)
 				mode_lib->vba.DSC422NativeNotSupported = true;
 
@@ -3639,7 +3638,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			if (mode_lib->vba.SourcePixelFormat[k] != dm_444_64
 					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_32
 					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
-					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
 					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_8
 					&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe) {
 				if (mode_lib->vba.ViewportWidthChroma[k] > mode_lib->vba.SurfaceWidthC[k]
-- 
2.34.1



