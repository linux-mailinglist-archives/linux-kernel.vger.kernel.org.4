Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B254F6C4DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCVOay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCVOaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:30:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175DC6285F;
        Wed, 22 Mar 2023 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495451; x=1711031451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YpXIfF5+mJiCxg+eDEG0Br0ZjXo5m0PVri6m2PIOARM=;
  b=LkqY6WJ69UJBtkxdyOO6T/hlBDk73xFZ+AZU0BTzh5VfYiZr1pLMGLgJ
   pIWpJhs0AzxDzxA1TYftpn4/7r4DdVqeO9P8otjRkmSq7L3P92+A5oO8E
   a4yiu7KIntACscMNc9P623qHQ/v9XnALvJfi+iCzQuMKr8sVJLIeXtqa9
   irphi4o6hSmYOWlmjgJuqz05vZ5FUF2BFZHB7f6NtuLXa2LUKrfpkGBwF
   pALw8F2SMlExRhsIahv3/35p3fDt+f6lER9pP8sXtnMmrxzCPkJpsn9g/
   4MV+IjjTs2SpWcNdzicW33jL24pmgiJIVMIskYefg2LS8Jg1jqnT8gBM0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="323070997"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="323070997"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:30:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="632010777"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="632010777"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 22 Mar 2023 07:30:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pezTy-007AGy-0O;
        Wed, 22 Mar 2023 16:30:30 +0200
Date:   Wed, 22 Mar 2023 16:30:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Xin Ji <xji@analogixsemi.com>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-acpi@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v14 10/10] drm/bridge: it6505: Register Type C mode
 switches
Message-ID: <ZBsRBV9dw+mb5ZxZ@smile.fi.intel.com>
References: <20230322104639.221402-1-treapking@chromium.org>
 <20230322104639.221402-11-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322104639.221402-11-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:46:39PM +0800, Pin-yen Lin wrote:
> Register USB Type-C mode switches when the "mode-switch" property and
> relevant port are available in Device Tree. Configure the "lane_swap"
> state based on the entered alternate mode for a specific Type-C
> connector, which ends up updating the lane swap registers of the it6505
> chip.

...

> +	struct device_node *port_node = of_graph_get_port_by_id(dev->of_node, 1);
> +	struct drm_dp_typec_switch_desc *switch_desc = &it6505->switch_desc;
> +	int ret;
> +	u32 dp_lanes[4];
> +	unsigned int i, num_lanes;
> +
> +	ret = drm_dp_register_typec_switches(dev, &port_node->fwnode,
> +					     &it6505->switch_desc, it6505,
> +					     it6505_typec_mux_set);
> +	if (ret)
> +		return ret;
> +
> +	it6505->port_data = devm_kcalloc(dev, switch_desc->num_typec_switches,
> +					 sizeof(struct it6505_typec_port_data),
> +					 GFP_KERNEL);
> +	if (!it6505->port_data) {
> +		ret = -ENOMEM;
> +		goto unregister_mux;
> +	}

A couple of the similar comments as per previous similar patch.

...

>  	/* get extcon device from DTS */
>  	extcon = extcon_get_edev_by_phandle(dev, 0);
> -	if (PTR_ERR(extcon) == -EPROBE_DEFER)
> -		return -EPROBE_DEFER;
> -	if (IS_ERR(extcon)) {
> -		dev_err(dev, "can not get extcon device!");
> -		return PTR_ERR(extcon);
> +	ret = PTR_ERR_OR_ZERO(extcon);
> +	if (ret == -EPROBE_DEFER)
> +		return ret;

> +

Unnecessary blank line.

> +	if (ret) {
> +		if (ret != -ENODEV)
> +			dev_warn(dev, "Cannot get extcon device: %d\n", ret);
> +
> +		it6505->extcon = NULL;
> +	} else {
> +		it6505->extcon = extcon;

...

> +	ret = it6505_register_typec_switches(dev, it6505);
> +	if (ret != -ENODEV)
> +		dev_warn(dev, "Didn't register Type-C switches, err: %d\n", ret);

> +

Unnecessary blank line.

> +	if (ret && !it6505->extcon) {
> +		dev_err(dev, "Both extcon and Type-C switch are not registered.\n");
> +		return -EINVAL;

Why not return ret here?

> +	}

-- 
With Best Regards,
Andy Shevchenko


