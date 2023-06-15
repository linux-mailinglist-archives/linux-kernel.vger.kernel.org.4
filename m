Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CBD7323B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbjFOXb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjFOXb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:31:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B625F171F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:31:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f76a4c211dso3269011e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686871913; x=1689463913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYCrQY+vD5Zhy3XYtfstQ901gmXcf6Fa7FD0xvyG1mA=;
        b=WkXEayk061Kdw3iPzXlRwePQmWd2w33QCzircznXEC0Xx0IC+D9GzBjbBVkK4jKq2q
         nfdE6tqVk/Gikz2CP+Thg4Q1DCawjcIr2SSaIclxQg+u0CPecJ/NTczT8BeRY3Dk/dET
         d+oQ293TtRZuAOMXp7I2K/t+PBKNmWMkHPNwSfQxviqsRH1vq9CtH5sao+riq5IN72c2
         /hxRKvTivMHKM90GmVp55bdLn7HnYcurm+je0mswz7Q26LMaedh8OnB1pKXpvjiFzHFA
         VYCVsmKzS3cipmmpHO02zO/oLBb3sQX5JWLKG0tEN13r+/hXo5JhvCj1IVf2tFlbKxq7
         POfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871913; x=1689463913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYCrQY+vD5Zhy3XYtfstQ901gmXcf6Fa7FD0xvyG1mA=;
        b=f7hvpEJUT35MrzMb4V2Om+CFDh3BL7zRHMxdDIBz2pv7bRNLwcAWCTdvYQxDQ+BzGd
         3CDPrI0Zdl5s4XRxBWLXvF67eNXT26efaYip7qxaQPGt2oCU7fH7nOp3g0pTDvWa5j9K
         sC5g/NMhxyuFP1N8W2/t+qE2nXLev8FPq/+IcKj22G2Ga1AimB30x6pSVnVMtGWpvAiP
         YYzrtYCooNZq9UV1DiI/9G6M2nha4g9+IerXv1r8/yfXWkH0crPXNTRRtOS9QTxe69ZT
         WgObpVPJqduBS0vRzrbI5sWrWy2+cbO9EXi47+R/ItLE9S98EnV8q18fySkZyTGLT1B+
         O81Q==
X-Gm-Message-State: AC+VfDwZgLdxaZogPC9jSdoTmtjYCfm7Gtohmrshsk73hdjDva8BVilb
        ZyACH4uUWKE8Xnkj1b0vxfU2+A==
X-Google-Smtp-Source: ACHHUZ67+RO4aZ/zllxkh6V7HrysWfqRH2iujxqDDBvPqKh9/DHLw/Kh5WD70xMyopEPLhoc1BpBfg==
X-Received: by 2002:a19:8c44:0:b0:4f6:2c03:36b0 with SMTP id i4-20020a198c44000000b004f62c0336b0mr104795lfj.26.1686871912504;
        Thu, 15 Jun 2023 16:31:52 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c028c00b003f736735424sm435340wmk.43.2023.06.15.16.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:31:51 -0700 (PDT)
Date:   Fri, 16 Jun 2023 00:31:50 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     pawan.kumar.gupta@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, jordyzomer@google.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cdrom: Fix spectre-v1 gadget
Message-ID: <ZIufZn+reW0rza1H@equinox>
References: <20230612110040.849318-1-jordyzomer@google.com>
 <20230612110040.849318-2-jordyzomer@google.com>
 <20230615163125.td3aodpfwth5n4mc@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615163125.td3aodpfwth5n4mc@desk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 09:31:25AM -0700, Pawan Gupta wrote:
> On Mon, Jun 12, 2023 at 11:00:40AM +0000, Jordy Zomer wrote:
> > This patch fixes a spectre-v1 gadget in cdrom.
> > The gadget could be triggered by,
> >  speculatviely bypassing the cdi->capacity check.
> > 
> > Signed-off-by: Jordy Zomer <jordyzomer@google.com>
> > ---
> >  drivers/cdrom/cdrom.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> > index 416f723a2dbb..ecf2b458c108 100644
> > --- a/drivers/cdrom/cdrom.c
> > +++ b/drivers/cdrom/cdrom.c
> > @@ -264,6 +264,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mm.h>
> > +#include <linux/nospec.h>
> >  #include <linux/slab.h> 
> >  #include <linux/cdrom.h>
> >  #include <linux/sysctl.h>
> > @@ -2329,6 +2330,9 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
> >  	if (arg >= cdi->capacity)
> >  		return -EINVAL;
> >  
> > +	/* Prevent arg from speculatively bypassing the length check */
> > +	barrier_nospec();
> 
> On a quick look it at the call chain ...
> 
> sr_block_ioctl(..., arg)
>   cdrom_ioctl(..., arg)
>     cdrom_ioctl_media_changed(..., arg)
> 
> .... it appears maximum value cdi->capacity can be only 1:
> 
> sr_probe()
> {
> ...
> 	cd->cdi.capacity = 1;
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/sr.c?h=v6.4-rc6#n665
> 
> If we know that max possible value than, instead of big hammer
> barrier_nospec(), its possible to use lightweight array_index_nospec()
> as below:
> ...

Hi Pawan and Jordy,

I've now looked at this. It is possible for cdi->capacity to be > 1, as
it is set via get_capabilities() -> cdrom_number_of_slots(), if the
device is an individual or cartridge changer.

Therefore, I think using CDI_MAX_CAPACITY of 1 is not the correct
approach. Jordy's V2 patch is fine therefore, but perhaps using
array_index_nospec() with cdi->capacity is still better than a
do/while loop from a performance perspective, given it would be cached
etc. at that point, so possibly quicker. Thoughts? (I'm no expert on
spectre-v1 I'll admit).

Regards,
Phil
