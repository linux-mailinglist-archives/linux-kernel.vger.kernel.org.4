Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F956752F5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjATLEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjATLEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:04:39 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A272326589;
        Fri, 20 Jan 2023 03:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674212667; bh=pFcAewn2quaVufqt8MmtsTzaNaBvytUqO76gWo5SNjg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Cbb6j9H2bD7Z7FDGGrPST7s+1kdY9TCjD4K3FrcuhfnGD+4tZZvWgNsTN90ih9UdU
         EpQ5VNhgs0wbFFIIKpp6oX+tTWm4CljmBXK/uz6lgzg1gaobzDbEp1HY40oT/qGeYy
         fXqqx0CgRBPtsicPkkdPDLBSCZFq/R40B3Etysx8=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 20 Jan 2023 12:04:26 +0100 (CET)
X-EA-Auth: 0ot/tZiiKTi0F/QTRJLyBwwxTY3M0aSyzIriddrSvkKfXh3ZFiTX2FktA6AgT6MOmBjuSX2ydcws6gMFGL5Br+buUxxSQm4+
Date:   Fri, 20 Jan 2023 16:34:21 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] drm/tegra: sor: Remove redundant error logging
Message-ID: <Y8p1NbUH16avUefO@ubun2204.myguest.virtualbox.org>
References: <Y5a4z0TZSqUPfRkr@qemulion>
 <Y6DQTkTMhEefCkBL@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6DQTkTMhEefCkBL@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 02:27:50AM +0530, Deepak R Varma wrote:
> On Mon, Dec 12, 2022 at 10:44:55AM +0530, Deepak R Varma wrote:
> 
> Hello,
> May I please request a review and feedback on this patch proposal?
> 
> Also, I was able to build the changes for ARM arch verified using modinfo
> tegr-drm.ko command.

Hello,
I am waiting on a feedback on this patch proposal. Do I need to resend it to get
maintainer attention? Please advise.

Thank you,
./drv

> 
> 
> Thank you,
> ./drv
> 
> 
> > A call to platform_get_irq() already prints an error on failure within
> > its own implementation. So printing another error based on its return
> > value in the caller is redundant and should be removed. The clean up
> > also makes if condition block braces unnecessary. Remove that as well.
> >
> > Issue identified using platform_get_irq.cocci coccicheck script.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> > Please note: I was not able to build this driver since I did not find the
> > DRM_TEGRA option in menu config. All dependencies listed in the KConfig are
> > enabled, however, I was still not able to find the DRM_TEGRA module in the
> > Graphics-Drivers list. Since the proposed change is known, minor and obvious, I
> > am sending in this patch without build testing.
> >
> > Any advise on how to enable the DRM_TEGRA module in menuconfig selection list
> > will be helpful. Thank you.
> >
> >
> >  drivers/gpu/drm/tegra/sor.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> > index 8af632740673..ceaebd33408d 100644
> > --- a/drivers/gpu/drm/tegra/sor.c
> > +++ b/drivers/gpu/drm/tegra/sor.c
> > @@ -3799,10 +3799,8 @@ static int tegra_sor_probe(struct platform_device *pdev)
> >  	}
> >
> >  	err = platform_get_irq(pdev, 0);
> > -	if (err < 0) {
> > -		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
> > +	if (err < 0)
> >  		goto remove;
> > -	}
> >
> >  	sor->irq = err;
> >
> > --
> > 2.34.1
> >


