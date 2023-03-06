Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD42F6ABEFB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCFMDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFMDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:03:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4171B306;
        Mon,  6 Mar 2023 04:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678104188; x=1709640188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1mL4e/xUak5PVuwnTqWGIvoCVk6E+88xbDwsqxlcMrs=;
  b=FL85yAVVYz0nYwDK5cZWpAEf3FElNR8zG7BBjt0AX7I9ndiBKUAN9adT
   oh2QMh2U9V9f1K30oRF4wQzCPf5HNDPfuf2NLdYOxSIPwDjjTbpOeLj7I
   ApKOKOrId/dpGCYIwPRcPbUXvdDiLBi+lq27Y8dTyd89/yk9ZCl/a4OsC
   JdmSpVXVPYceuzOyY+9uzdCQhZ1nIPVZe3GUJn/gaI9jQB30otB9KVww2
   LKoX2TOXibAtSZjwunXUAEtH/XPGDW9hvIS9XwKdFj/gpNLMz+KeyP3ra
   CqRW4mxB0Rk40PmGGzMXvvU1FQsNJW7vkmjd+SzA/3d4sQYJzs1cccPqt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="315195781"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="315195781"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 04:03:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="708626116"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="708626116"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 06 Mar 2023 04:02:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZ9YN-00GKx1-0x;
        Mon, 06 Mar 2023 14:02:55 +0200
Date:   Mon, 6 Mar 2023 14:02:54 +0200
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
        Xin Ji <xji@analogixsemi.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        chrome-platform@lists.linux.dev,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Stephen Boyd <swboyd@chromium.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v13 10/10] drm/bridge: it6505: Register Type C mode
 switches
Message-ID: <ZAXWbkq4oLfrWUR7@smile.fi.intel.com>
References: <20230303143350.815623-1-treapking@chromium.org>
 <20230303143350.815623-11-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303143350.815623-11-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 10:33:50PM +0800, Pin-yen Lin wrote:
> Register USB Type-C mode switches when the "mode-switch" property and
> relevant port are available in Device Tree. Configure the "lane_swap"
> state based on the entered alternate mode for a specific Type-C
> connector, which ends up updating the lane swap registers of the it6505
> chip.

...

> +	it6505->port_data = devm_kcalloc(dev, switch_desc->num_typec_switches,
> +					 sizeof(struct it6505_typec_port_data),
> +					 GFP_KERNEL);

> +

Same, no need for a blank line here.

> +	if (!it6505->port_data) {
> +		ret = -ENOMEM;
> +		goto unregister_mux;
> +	}

...

> +		it6505->port_data[i].lane_swap = (dp_lanes[0] / 2 == 1);

' % 2 == 0' ?

...

Wouldn't be better to have

	ret = PTR_ERR_OR_ZERO(extcon);

here and amend the following accordingly?

>  	if (PTR_ERR(extcon) == -EPROBE_DEFER)
>  		return -EPROBE_DEFER;
>  	if (IS_ERR(extcon)) {
> -		dev_err(dev, "can not get extcon device!");
> -		return PTR_ERR(extcon);
> +		if (PTR_ERR(extcon) != -ENODEV)
> +			dev_warn(dev, "Cannot get extcon device: %ld\n",
> +				 PTR_ERR(extcon));
> +		it6505->extcon = NULL;
> +	} else {
> +		it6505->extcon = extcon;
>  	}
>  
> -	it6505->extcon = extcon;
> +	init_completion(&it6505->mux_register);
> +	ret = it6505_register_typec_switches(dev, it6505);
> +	if (ret) {
> +		if (ret != -ENODEV)
> +			dev_warn(dev, "Didn't register Type-C switches, err: %d\n",
> +				 ret);
> +		if (!it6505->extcon) {
> +			dev_err(dev, "Both extcon and typec-switch are not registered.\n");
> +			return -EINVAL;
> +		}
> +	}


Perhaps

	if (ret != -ENODEV)
		dev_warn(dev, "Didn't register Type-C switches, err: %d\n", ret);

	if (ret && !it6505->extcon) {
		dev_err(dev, "Both extcon and typec-switch are not registered.\n");
		return ret;
	}

?

-- 
With Best Regards,
Andy Shevchenko


