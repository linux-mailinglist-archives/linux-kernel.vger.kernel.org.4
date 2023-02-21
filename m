Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5058A69DEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjBULhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjBULhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:37:17 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2965265B6;
        Tue, 21 Feb 2023 03:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676979411; x=1708515411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7ANYBaN3BRH6hFLUyPVgrXSlXGHP/g9XCIrZnmRZ6dA=;
  b=PKLY8I99MXQRA4zDr/tiszBffrLyM6qzAbeUfAkX26Ju39vzfjlj42vX
   3E12KuqTzf9gw06J+itv0MrdvdtCEsSADwrZz2xmN/SRfvd1TgWx+Z2dt
   uBl7ZI4K9+bPGiMHvRy2U0GX7a0+qBEQPBS3/xSOJRXc93Ej3JgAFIEOx
   bN6Nu0Z+9/0VRsUclMP1k2v4xisBZ/a/fqvrpBWajIiSNMVxIiNlqLFci
   3F9an3S+zu+fPPVoPcBHcglRDQW74h0D2NjJAvUsO9UMT83KS45XyBS0G
   fSbi1eljZ54/uIbBgHaheNn0ScQvFfqou/5md5joHgEP5Wy+R9rSUSeGA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="332614504"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="332614504"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 03:36:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="795494041"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="795494041"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2023 03:36:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pUQwW-009w6O-31;
        Tue, 21 Feb 2023 13:36:20 +0200
Date:   Tue, 21 Feb 2023 13:36:20 +0200
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
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Marek Vasut <marex@denx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Xin Ji <xji@analogixsemi.com>,
        Lyude Paul <lyude@redhat.com>,
        Allen Chen <allen.chen@ite.com.tw>, devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, chrome-platform@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-acpi@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v12 07/10] drm/bridge: anx7625: Register Type C mode
 switches
Message-ID: <Y/SstDfugez4/Qx4@smile.fi.intel.com>
References: <20230221095054.1868277-1-treapking@chromium.org>
 <20230221095054.1868277-8-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221095054.1868277-8-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 05:50:51PM +0800, Pin-yen Lin wrote:
> Register USB Type-C mode switches when the "mode-switch" property and
> relevant ports are available in Device Tree. Configure the crosspoint
> switch based on the entered alternate mode for a specific Type-C
> connector.
> 
> Crosspoint switch can also be used for switching the output signal for
> different orientations of a single USB Type-C connector, but the
> orientation switch is not implemented yet. A TODO is added for this.

...

> +static void anx7625_typec_two_ports_update(struct anx7625_data *ctx)
> +{
> +	int i;

unsigned?

+ Blank line.

> +	/* Check if both ports available and do nothing to retain the current one */
> +	if (ctx->port_data[0].dp_connected && ctx->port_data[1].dp_connected)
> +		return;
> +
> +	for (i = 0; i < 2; i++) {
> +		if (ctx->port_data[i].dp_connected)
> +			anx7625_set_crosspoint_switch(ctx,
> +						      ctx->port_data[i].orientation);
> +	}
> +}

...

> +	ctx->port_data[port->port_num].dp_connected =
> +		state->alt && state->alt->svid == USB_TYPEC_DP_SID &&

I would move the first parameter of && to the separate line for slightly better
readability.

> +		state->alt->mode == USB_TYPEC_DP_MODE;

...

> +	for (i = 0; i < switch_desc->num_typec_switches; i++) {
> +		struct drm_dp_typec_port_data *port = &switch_desc->typec_ports[i];
> +		struct fwnode_handle *fwnode = port->fwnode;
> +
> +		num_lanes = fwnode_property_count_u32(fwnode, "data-lanes");

> +

Redundant blank line.

> +		if (num_lanes < 0) {
> +			dev_err(dev,
> +				"Error on getting data lanes count from %pfwP: %d\n",
> +				fwnode, num_lanes);

> +			ret = num_lanes;

Can be written differently:

> +			goto unregister_mux;
> +		}

		ret = ...
		if (ret < 0) {
			...
		}
		num_lanes = ret;


What if it's 0?

> +		ret = fwnode_property_read_u32_array(fwnode, "data-lanes",
> +						     dp_lanes, num_lanes);
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed to read the data-lanes variable: %d\n",
> +				ret);
> +			goto unregister_mux;
> +		}
> +
> +		ctx->port_data[i].orientation = (dp_lanes[0] / 2 == 0) ?
> +			TYPEC_ORIENTATION_REVERSE : TYPEC_ORIENTATION_NORMAL;
> +		ctx->port_data[i].dp_connected = false;
> +	}
> +	complete_all(&ctx->mux_register);
> +
> +	return 0;
> +
> +unregister_mux:
> +	complete_all(&ctx->mux_register);
> +	anx7625_unregister_typec_switches(ctx);
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko


