Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C7160D307
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiJYSHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiJYSHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:07:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B331359;
        Tue, 25 Oct 2022 11:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666721243; x=1698257243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VOpBFPiXCf+5fX6cR64v+oy3Xni2HfEQZgB+4zR/DtE=;
  b=JJiYCWUGCCggS5hAAwpTiO3sPrDml0Z3DEcgWMYSUrlQp4q2+LdLJp6M
   qyT0nnB6sowG9rSzhj3moh8yyD+P0NemxiaSizSPM+mU/RTfrE+csKDH3
   AW+CRqH04yA+oydcBaEQwmzvCPPd3e2ZKErWzYo5nGEN7oiHuGitzFae/
   3DNWWaxnAgIKUoue0X+Cc8v57HJAZLhQakrE73D5UtGQN8UV7Nr+hfZG8
   wQIbbCZQkF10NLy1yRoy6qf1H9ogiAEacmru+HfcCa7I7qCszvaGD2R/K
   vy7J3/EHLcVMYwxyYEY2kUq1ULVCa9aOt4eWlCDTmEgM84vFDMnR15tvE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="306483283"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="306483283"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 11:07:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="631722499"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="631722499"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 11:07:18 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 85AFE2026C;
        Tue, 25 Oct 2022 21:07:16 +0300 (EEST)
Date:   Tue, 25 Oct 2022 18:07:16 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mike Pagano <mpagano@gentoo.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marek Vasut <marex@denx.de>, Jimmy Su <jimmy.su@intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] media: i2c: add support for OV4689
Message-ID: <Y1gl1FMAjhXCfCmk@paasikivi.fi.intel.com>
References: <20221022162042.14113-1-mike.rudenko@gmail.com>
 <20221022162042.14113-3-mike.rudenko@gmail.com>
 <20221025130958.bnedjlkm6kmiluoe@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025130958.bnedjlkm6kmiluoe@uno.localdomain>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Tue, Oct 25, 2022 at 03:09:58PM +0200, Jacopo Mondi wrote:
> > +static int ov4689_configure_regulators(struct ov4689 *ov4689)
> > +{
> > +	unsigned int supplies_count = ARRAY_SIZE(ov4689_supply_names);

No need for a temporary variable.

> > +	unsigned int i;
> > +
> > +	for (i = 0; i < supplies_count; i++)
> > +		ov4689->supplies[i].supply = ov4689_supply_names[i];
> > +
> > +	return devm_regulator_bulk_get(&ov4689->client->dev, supplies_count,
> > +				       ov4689->supplies);
> > +}
> > +
> > +static u64 ov4689_check_link_frequency(struct v4l2_fwnode_endpoint *ep)
> > +{
> > +	unsigned int freqs_count = ARRAY_SIZE(link_freq_menu_items);
> > +	const u64 *freqs = link_freq_menu_items;
> > +	unsigned int i, j;
> > +
> > +	for (i = 0; i < freqs_count; i++) {

Ditto.

> > +		for (j = 0; j < ep->nr_of_link_frequencies; j++)
> > +			if (freqs[i] == ep->link_frequencies[j])
> > +				return freqs[i];
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ov4689_check_hwcfg(struct device *dev)
> > +{
> > +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > +	struct v4l2_fwnode_endpoint bus_cfg = {
> > +		.bus_type = V4L2_MBUS_CSI2_DPHY,
> > +	};
> > +	struct fwnode_handle *endpoint;
> > +	int ret;
> > +
> > +	endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
> > +	if (!endpoint)
> > +		return -EINVAL;
> > +
> > +	ret = v4l2_fwnode_endpoint_alloc_parse(endpoint, &bus_cfg);
> > +	fwnode_handle_put(endpoint);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (bus_cfg.bus.mipi_csi2.num_data_lanes != OV4689_LANES) {
> > +		dev_err(dev, "Only a 4-lane CSI2 config is supported");
> > +		ret = -EINVAL;
> > +		goto out_free_bus_cfg;
> > +	}
> > +
> > +	if (!bus_cfg.nr_of_link_frequencies) {
> > +		dev_err(dev, "No link frequencies defined\n");
> > +		ret = -EINVAL;
> > +		goto out_free_bus_cfg;
> > +	}
> 
> As the driver has a single supported freq I wonder if it is required
> to have it mandatory. I got contradictory feedbacks in the past, so
> whatever you have here I guess it's fine (same reasoning goes for dts,
> if there's only one accepted item, does it need to be made mandatory
> ?)

This check could indeed be removed, the one below already handles the case.

The driver can be amended in the future to support additional frequencies.
It probably requires more code here, too...

I've got this in my tree, feel free to send a follow-up patch.

> 
> Nits apart, the driver looks sane
> 
> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks!

-- 
Regards,

Sakari Ailus
