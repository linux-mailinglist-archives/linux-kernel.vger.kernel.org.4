Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE8692526
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjBJSRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjBJSRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:17:08 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E2555E7D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 10:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676053016; bh=oHz2us9DLQA/KqfKOt5nfmI+i7BQogAbxnCbfbeMgAs=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=gbGD5YknB4XJWyv4+tct9/A3jL1q+mdSrDkPPu0ysPypV+j7XM1IXmZ+D3JgzJep1
         ApbgJa1e2owK4h5MJT42bCvyerTaghqnFRntGFXaCSr5zZWc5dtLfzV1AW62vRh05Z
         +CO0bmc91yJR4Z4Dy2YSsDYtM3jIePUF9irBQfyc=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 10 Feb 2023 19:16:56 +0100 (CET)
X-EA-Auth: XTggIg9IL3jabOPU+QSxv8wRN0TBE7TEalSdCPg6zWW3MrNZ4vy5o1vFgYccKngUZ/1LN318OWayxbn42CNidsmPo6SzKz3q
Date:   Fri, 10 Feb 2023 23:46:50 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate/repeating expression
Message-ID: <Y+aKEmbSg5rCq87g@ubun2204.myguest.virtualbox.org>
References: <Y+YYZ4SbMQBcpTZP@ubun2204.myguest.virtualbox.org>
 <c64bb7b8-ab50-78c3-bb56-820ce96a1e14@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c64bb7b8-ab50-78c3-bb56-820ce96a1e14@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 10:22:00AM -0500, Harry Wentland wrote:
> On 2/10/23 05:11, Deepak R Varma wrote:
> > Remove duplicate or repeating expressions in the if condition
> > evaluation. Issue identified using doubletest.cocci Coccinelle semantic
> > patch.
> > 
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> 
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Thank you Harry. There is another similar patch I submitted for a different
file. Could you please also review that and share your feedback?

Thank you,
./drv

> 
> Harry
> 
> > ---
> >  .../gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
> > index 61ee9ba063a7..6576b897a512 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
> > @@ -51,7 +51,7 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
> >  		*BytePerPixelDETC = 0;
> >  		*BytePerPixelY = 4;
> >  		*BytePerPixelC = 0;
> > -	} else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16) {
> > +	} else if (SourcePixelFormat == dm_444_16) {
> >  		*BytePerPixelDETY = 2;
> >  		*BytePerPixelDETC = 0;
> >  		*BytePerPixelY = 2;
> 


