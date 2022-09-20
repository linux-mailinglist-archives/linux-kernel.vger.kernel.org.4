Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F55BE0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiITIyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiITIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:54:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196686B64E;
        Tue, 20 Sep 2022 01:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663664045; x=1695200045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bE7Qmiy6NhKs0sdl809v9zg8SKzJzql0subSBeUamVk=;
  b=HrnEPjJ677FoXIU2d3z9K6U++X6aXVrotmUMGtyr+CdQSETZ5bpOHKjY
   G42WF9iXRgJ8ypbCmlHJytvJk7hZPnrlWoIW0fFF/yWH1g8r6qIsjU0G5
   mTpNlSJbcaFgQJMuq3TmcD3WphIbWnQ/f3r90mbTTOi4RQbIqdpHrYp6Y
   kpwX3T5l7eyXqESQ8BjR7RGjRvgT9UsKZcBT4MJGKyF1d0JW/YV3N73no
   I7w6ai0UhFVEgr9HOLn3dlgNpTSm5CwsFgCuCMgNTvqNR9kbwD8F6Fn0l
   1AmsOnG3XVhqDMh1YAt8A1icmLU50GxVamNVBUeYDDYdR9Jo7xT+iGaOf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="298364557"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="298364557"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:54:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="614317268"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:53:56 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id A54D1200DA;
        Tue, 20 Sep 2022 11:53:54 +0300 (EEST)
Date:   Tue, 20 Sep 2022 08:53:54 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        hverkuil@xs4all.nl, jacopo@jmondi.org,
        kieran.bingham+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 4/4] media: tc358746: add Toshiba TC358746 Parallel to
 CSI-2 bridge driver
Message-ID: <Yyl/oqZwUUb1Z0qM@paasikivi.fi.intel.com>
References: <20220916134535.128131-1-m.felsch@pengutronix.de>
 <20220916134535.128131-5-m.felsch@pengutronix.de>
 <YyhktzmcgXKnrMFU@pendragon.ideasonboard.com>
 <20220919171142.6av6ap5gwweldado@pengutronix.de>
 <Yyio06jhK13BiNiP@pendragon.ideasonboard.com>
 <YyjI/JOcryD8yKzT@paasikivi.fi.intel.com>
 <20220920083908.st4h3pb6usn4zavu@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920083908.st4h3pb6usn4zavu@pengutronix.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Tue, Sep 20, 2022 at 10:39:08AM +0200, Marco Felsch wrote:
> Hi Sakari,
> 
> On 22-09-19, Sakari Ailus wrote:
> > On Mon, Sep 19, 2022 at 08:37:23PM +0300, Laurent Pinchart wrote:
> > > > > > +	ctrl = v4l2_ctrl_new_int_menu(&tc358746->ctrl_hdl, NULL,
> > > > > > +				      V4L2_CID_LINK_FREQ, 0, 0,
> > > > > 
> > > > > Shouldn't the max argument be set to the number of items minus 1 ?
> > > > 
> > > > Right now I would keep it that way since the driver only supports one
> > > > link-frequencies setting. So the ctrl don't let the userspace assume
> > > > that there are more than one link-frequency.
> > > 
> > > Good point. Can you add a short comment above the call to explain this ?
> > 
> > Wouldn't it be just easier to do what Laurent suggested originally? The end
> > result is the same, isn't it, and no comment needed?
> 
> The end result depends on the device-tree given "link-frequencies"
> property. The driver currently takes only one frequency but the
> system-integrator of course can specify many more. In such case the 1st
> is used. If I go with Laurent's comment, all frequencies would be shown
> to the user-space but IMHO this shouldn't be the case since the driver
> supports only 1 frequency.

Yes, indeed. The driver can later be amended to support this.

> 
> > > 
> > > > > > +				      link_frequencies);
> > > > > > +	if (ctrl)
> > > > > > +		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> > 
> > Now that this is a bridge, this value presumably doesn't need to change.
> 
> The value can change, e.g. if you have a few freq. to allow a wide range
> of frame sizes. This can be the case to conform the emv tests. So there
> can be a freq. for smaller frame sizes and one for larger frame sizes.

Ack.

-- 
Regards,

Sakari Ailus
