Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AAE5BD565
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 21:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiISTyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 15:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiISTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:54:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9DF1402D;
        Mon, 19 Sep 2022 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663617282; x=1695153282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TFylzeOIAdoKTrYXFOCkIxj91jitXePjqSvx77D6gYQ=;
  b=VAm/VFgeATtp58tv83ToYGxb3sndvgWbMAx5yVKNYt3BOan8y+06td3C
   y/SengAMrqjXLJOs2Bcd0vNtEN7DDJCAn6CxmvNsiRkx222K3eWzIpAWg
   MejAzbyV7FF0oaJj2SAIhC947BsaCNbgn7nOFKMV0B8eNH9gLXjxIqBt9
   L05V6E3faLxio9UZgFkUIcIDoBuDlQOLdtJRdx4XjxJFQVzzbrV+m98ic
   vSiRSKw+q07PGfSGR5OMsrC89/FEanVRxeXZybKfBoKxRHISjct+72TxU
   WrTxT6QRXhqozU+1xk0mgrSDA3xnecY/oFVFJ4hyKXkljxidjSnmIHoDN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363466369"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363466369"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 12:54:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="722439432"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 12:54:38 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 0EF4020238;
        Mon, 19 Sep 2022 22:54:36 +0300 (EEST)
Date:   Mon, 19 Sep 2022 19:54:36 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, hverkuil@xs4all.nl,
        jacopo@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 4/4] media: tc358746: add Toshiba TC358746 Parallel to
 CSI-2 bridge driver
Message-ID: <YyjI/JOcryD8yKzT@paasikivi.fi.intel.com>
References: <20220916134535.128131-1-m.felsch@pengutronix.de>
 <20220916134535.128131-5-m.felsch@pengutronix.de>
 <YyhktzmcgXKnrMFU@pendragon.ideasonboard.com>
 <20220919171142.6av6ap5gwweldado@pengutronix.de>
 <Yyio06jhK13BiNiP@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyio06jhK13BiNiP@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 08:37:23PM +0300, Laurent Pinchart wrote:
> > > > +	ctrl = v4l2_ctrl_new_int_menu(&tc358746->ctrl_hdl, NULL,
> > > > +				      V4L2_CID_LINK_FREQ, 0, 0,
> > > 
> > > Shouldn't the max argument be set to the number of items minus 1 ?
> > 
> > Right now I would keep it that way since the driver only supports one
> > link-frequencies setting. So the ctrl don't let the userspace assume
> > that there are more than one link-frequency.
> 
> Good point. Can you add a short comment above the call to explain this ?

Wouldn't it be just easier to do what Laurent suggested originally? The end
result is the same, isn't it, and no comment needed?

> 
> > > > +				      link_frequencies);
> > > > +	if (ctrl)
> > > > +		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;

Now that this is a bridge, this value presumably doesn't need to change.
There will just be more blanking if the source sub-device pixel rate is
slower, right?

-- 
Sakari Ailus
