Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8AA613196
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJaITl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:19:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2059FEA;
        Mon, 31 Oct 2022 01:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667204378; x=1698740378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lbmevJjnjpGGx89wIvYMNqwP6/k7SVFB7D/svXf4f3Q=;
  b=ZFmgBRtrG/AzYYinGijkyX07wvba3HRqSwiWSVxrXGAnzx0SNHyquXZY
   Jjn8ugRRuPpN+aUUp9bguQ6dvJSUXxOLWfFHuARvgye41zVb6OH1zoLk8
   3fLtB7SSltUaZ4Hna75rZmgrCydoS7dEw76PyQ23uGGertUNVJaG2zEsZ
   3cffd6WI98j0YWrrWDFpwUarjOw0V1YBgFvcZzaMbwYWxLnvPLeF04lXN
   KPgWkOVfBxfVEl2B7Qoyvur9W9OCaoPHGPPxlTok318wvc2sKwWAlscWm
   CvihE1llBYOjTax3/dbjWCjI4BeypTGgE5wPUH7ejMLnLHwC2Lp/O7ist
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="335500652"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="335500652"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 01:19:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="776051657"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="776051657"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 01:19:34 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 130C72026C;
        Mon, 31 Oct 2022 10:19:32 +0200 (EET)
Date:   Mon, 31 Oct 2022 08:19:32 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 4/4] media: platform: Add Renesas RZ/G2L CRU driver
Message-ID: <Y1+FFD4/XCY8HyYa@paasikivi.fi.intel.com>
References: <20221027103104.74576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221027103104.74576-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1qCbUoLrR6qlQwa@paasikivi.fi.intel.com>
 <CA+V-a8seroka4YkyCnSYa2KMPDWMG1Zk8tyiqRntdPUQnc+nrA@mail.gmail.com>
 <Y1vJbJfFjV9jRNzz@paasikivi.fi.intel.com>
 <CA+V-a8tONhJ1_x3T7+6n7tu=xyFBZfsqT2v3iUGd2Jy5_NuZCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8tONhJ1_x3T7+6n7tu=xyFBZfsqT2v3iUGd2Jy5_NuZCg@mail.gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Sun, Oct 30, 2022 at 10:32:43PM +0000, Lad, Prabhakar wrote:
> Hi Sakari,
> 
> On Fri, Oct 28, 2022 at 1:22 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Prabhakar,
> >
> > On Thu, Oct 27, 2022 at 08:04:40PM +0100, Lad, Prabhakar wrote:
> > ...
> > > > > +static int rzg2l_cru_ip_s_stream(struct v4l2_subdev *sd, int enable)
> > > > > +{
> > > > > +     struct rzg2l_cru_dev *cru;
> > > > > +     int ret;
> > > > > +
> > > > > +     cru = v4l2_get_subdevdata(sd);
> > > > > +
> > > > > +     if (!cru->is_csi)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     ret = v4l2_subdev_call(cru->ip.remote, video, s_stream, enable);
> > > >
> > > > It's up to the driver how call pre_streamon() and post_streamoff(), as long
> > > > as it takes place on both sides of s_stream().
> > > >
> > > > In other words, as it seems your device doesn't need anything special, you
> > > > could waive implemeting the callbacks yourself and call pre_streamon() and
> > > > post_streamoff() here.
> > > >
> > > Here the cru->ip.remote = CSI, in the rzg2l_cru_set_stream(1) where we
> > > are calling pre_streamon()/post_streamoff() callbacks the subdev is
> > > CRU-IP. So the calls from rzg2l_cru_set_stream() land into
> > > rzg2l_cru_ip_pre_streamon() and rzg2l_cru_ip_post_streamoff() which
> > > are calling pre_streamon/post_streamoff for the CSI subdev.
> >
> > Again, you should call the source sub-device's pre_streamon and
> > post_streamoff from the s_stream handler (not from
> > rzg2l_cru_ip_pre_streamon or rzg2l_cru_ip_post_streamoff).
> >
> > Starting streaming takes place link by link. This allows a driver to omit
> > implementing pre_streamon and post_streamon callbacks if it doesn't need
> > them.
> >
> Thank you for the explanation that makes sense now to me.
> 
> Now with this approach the initialization sequence of CSI + CRU won't
> align as per the HW manual. Unfortunately I'll have to switch back on
> exporting the functions. I hope that's okay?

It is not.

What exactly would you like to do that you can't with the
pre_streamon/post_streamoff callbacks called from s_stream?

In the worst case we can redefine where they are to be called.

-- 
Kind regards,

Sakari Ailus
