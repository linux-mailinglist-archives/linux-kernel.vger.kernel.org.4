Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE91634498
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiKVTbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiKVTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:31:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDBA91514;
        Tue, 22 Nov 2022 11:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669145469; x=1700681469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zyJQjgV0e1WVZZJXVzgDlssVZQ+0qMeIqZmVuMKL3lo=;
  b=QX9lLB3juMy9qqcd6SfHgBWM4/rzkwewaLcCjsIHH6H0FKuX8TNhhCdN
   SSBUfQLVDDuokBhewz5gSRQLt4tQwyvxZab0Y5ezwq/1hTmbDH1mWl5bJ
   vBsAJNZhJNPbEDkD0p3gaubtSKpQSqPA3CIM7TxJM7hJ4jG/7ECbKEEbF
   xSDiVAWCscblhZrNXufFiTHoM5P/+licIFsFgxSt9rqSvd4p4cdyyLoFN
   G5rHdouoCcXBGesJsZsCw5G1EGMzi9i4xteH4lcB2XHiGtR+zFwGx1wRY
   L6rIsLlq1W7wv0j8gPjSuZPNbkS+fkKwv0gu2RX8WYebPqrnR+G7vFvbx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="400188230"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="400188230"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 11:31:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="674457700"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="674457700"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 11:31:04 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 74709201D2;
        Tue, 22 Nov 2022 21:31:00 +0200 (EET)
Date:   Tue, 22 Nov 2022 19:31:00 +0000
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
Subject: Re: [PATCH v5 4/4] media: platform: Add Renesas RZ/G2L CRU driver
Message-ID: <Y30jdErgPI223eoM@paasikivi.fi.intel.com>
References: <20221102004329.5410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221102004329.5410-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y3yYkQhJJFLau08X@paasikivi.fi.intel.com>
 <CA+V-a8u9QS6Wk8SSmmJheHmtRiUWyOpv9DDJO6qDR8viz1Wp7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8u9QS6Wk8SSmmJheHmtRiUWyOpv9DDJO6qDR8viz1Wp7A@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, Nov 22, 2022 at 10:26:28AM +0000, Lad, Prabhakar wrote:
> Hi Sakari,
> 
> On Tue, Nov 22, 2022 at 9:38 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Prabhakar,
> >
> > On Wed, Nov 02, 2022 at 12:43:29AM +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
> > >
> > > Based on a patch in the BSP by Hien Huynh
> > > <hien.huynh.px@renesas.com>
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Laurent's comment arrive a little late but the patch does not compile
> > against the media tree anymore. The argument of the media_pipeline_start()
> > and media_pipeline_stop() is now a pad, not an entity. See what the changes
> > look like in other drivers (the commit id is
> > 12cecbf9150f67b0ce7d88bc2e243e67637726c2).
> >
> I'll go through them soon, when do you plan to close the v6.2 window?
> 
> > I'll still take the DT binding patches.
> >
> Or maybe we could wait and get them alongside the drivers?

Can you send a new version by tomorrow morning (Finnish time)? The needed
changes didn't seem too complicated, I wouldn't want to delay my PR much
later as chances slipping to 6.3 will increase.

-- 
Kind regards,

Sakari Ailus
