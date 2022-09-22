Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE1C5E627B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiIVMeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiIVMeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:34:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301D1E720F;
        Thu, 22 Sep 2022 05:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663850049; x=1695386049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X+QFuCDurRscvZ+T+naQ/Ko/Utvu3qN+BEERVqLzVg8=;
  b=ND99VllimLoUoviMcBH+XqBn0Of2xcFN+5WpifSOzJzh/LbYsmzfz/Jg
   A3IJJSZzMKuMYGaTa3vQmL6V+mYX++rCmDMzi/sMwCmvctjC93Bg+TiwM
   CSjSB4Bnh/mt2PY3mKnYO0lXqNzqnT4eEM/4oImrHPISJk5o2yDybz3Bg
   6h8jIbPjxe0khiheRE2DBED4FSGj2WqCU52M/sPOKpt2luqX8Nt9O72pA
   SIh+gqqOIURTQzXz/cVa4BnOVg8XIU64p8MKF80Yde0PgasS+nKVd9v8y
   o89/s/u0dRj5TxpRfb8Qsg+6PhrOngxhKVwv4DGIyhe291bSoJ2Powk1E
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362050305"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="362050305"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 05:34:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="864836418"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 05:34:04 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 23EEF20075;
        Thu, 22 Sep 2022 15:34:02 +0300 (EEST)
Date:   Thu, 22 Sep 2022 12:34:02 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 3/4] media: platform: Add Renesas RZ/G2L MIPI CSI-2
 receiver driver
Message-ID: <YyxWOuWOrYmMexNj@paasikivi.fi.intel.com>
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Yys4CRNnKP3LXyAO@pendragon.ideasonboard.com>
 <CA+V-a8uiT9rV=T6LmFovRwULf3SO=JKdqr1yacAqN8gJmv9VPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8uiT9rV=T6LmFovRwULf3SO=JKdqr1yacAqN8gJmv9VPw@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Sep 22, 2022 at 01:08:33PM +0100, Lad, Prabhakar wrote:
> > > * Switched to manually turn ON/OFF the clocks instead of pm_runtime so that
> > >   the mipi/dhpy initialization happens as per the HW manual
> >
> > That doesn't look right. The driver doesn't use runtime PM anymore, so
> > power domains may not be handled properly. What was the problem with
> > clock handling using runtime PM ?
> >
> If we use the runtime PM all the clocks will be turned ON when we call
> pm_runtime_resume_and_get() which I dont want to. As per the "Starting
> reception for MIPI CSI-2 Input" section 35.3.1 for example we first
> need to turn ON all the clocks and later further down the line we need
> to just turn OFF VCLK -> Enable Link -> turn ON VCLK. Due to such
> cases I have switched to individual clock handling.

If that is the case, then you should control just that clock directly,
outside runtime PM callbacks.

Runtime PM may be needed e.g. for resuming a parent device.

-- 
Regards,

Sakari Ailus
