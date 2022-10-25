Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A56C60D43D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiJYSzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiJYSza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:55:30 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E4FC508E;
        Tue, 25 Oct 2022 11:55:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-12-207-nat.elisa-mobile.fi [85.76.12.207])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 579578A9;
        Tue, 25 Oct 2022 20:55:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1666724127;
        bh=3qAP2ptfziaJOJ/l9CrdXI1jDAs6RcHna+H7AdQM4JU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYK8hr9Lq0/6HSnjW95/xdT385/UQB9fV64itQ+fqfw8y6xTH+B58N0LhQXP/DirA
         SUTEzqboK2J5CSBCiVadI1tO/6ftc8bvRbomrd4GIy1kK2LNPYxBnvnJqlxFlj0LZE
         V/uFvQEot1FWTqoO98y6AXFiGhKg719v7k8N8Tz4=
Date:   Tue, 25 Oct 2022 21:54:59 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Pedro Guilherme Siqueira Moreira 
        <pedro.guilherme@espectro.eng.br>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] media: uvc_driver: fix usage of symbolic
 permissions to octal
Message-ID: <Y1gxA1k4tn/KGnEz@pendragon.ideasonboard.com>
References: <20221025050450.1743072-1-pedro.guilherme@espectro.eng.br>
 <20221025050450.1743072-3-pedro.guilherme@espectro.eng.br>
 <CANiDSCvN5DEDdjCkO-KXgYwnhF_FGE4c=DMGiUTy4KKp51ANFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCvN5DEDdjCkO-KXgYwnhF_FGE4c=DMGiUTy4KKp51ANFA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 04:58:56PM +0200, Ricardo Ribalda wrote:
> On Tue, 25 Oct 2022 at 07:40, Pedro Guilherme Siqueira Moreira wrote:
> >
> > Change symbolic permissions to octal equivalents as recommended by
> > scripts/checkpatch.pl on drivers/media/usb/uvc/uvc_driver.c.
> >
> > Signed-off-by: Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
>
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

And for this one too:

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 7b6c97ad3a41..c5adad4e51e2 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2362,17 +2362,17 @@ static int uvc_clock_param_set(const char *val, const struct kernel_param *kp)
> >  }
> >
> >  module_param_call(clock, uvc_clock_param_set, uvc_clock_param_get,
> > -                 &uvc_clock_param, S_IRUGO|S_IWUSR);
> > +                 &uvc_clock_param, 0644);
> >  MODULE_PARM_DESC(clock, "Video buffers timestamp clock");
> > -module_param_named(hwtimestamps, uvc_hw_timestamps_param, uint, S_IRUGO|S_IWUSR);
> > +module_param_named(hwtimestamps, uvc_hw_timestamps_param, uint, 0644);
> >  MODULE_PARM_DESC(hwtimestamps, "Use hardware timestamps");
> > -module_param_named(nodrop, uvc_no_drop_param, uint, S_IRUGO|S_IWUSR);
> > +module_param_named(nodrop, uvc_no_drop_param, uint, 0644);
> >  MODULE_PARM_DESC(nodrop, "Don't drop incomplete frames");
> > -module_param_named(quirks, uvc_quirks_param, uint, S_IRUGO|S_IWUSR);
> > +module_param_named(quirks, uvc_quirks_param, uint, 0644);
> >  MODULE_PARM_DESC(quirks, "Forced device quirks");
> > -module_param_named(trace, uvc_dbg_param, uint, S_IRUGO|S_IWUSR);
> > +module_param_named(trace, uvc_dbg_param, uint, 0644);
> >  MODULE_PARM_DESC(trace, "Trace level bitmask");
> > -module_param_named(timeout, uvc_timeout_param, uint, S_IRUGO|S_IWUSR);
> > +module_param_named(timeout, uvc_timeout_param, uint, 0644);
> >  MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
> >
> >  /* ------------------------------------------------------------------------

-- 
Regards,

Laurent Pinchart
