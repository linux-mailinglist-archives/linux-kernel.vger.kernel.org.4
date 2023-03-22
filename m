Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3076C48D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCVLQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCVLQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:16:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCA2457C5;
        Wed, 22 Mar 2023 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679483763; x=1711019763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wzqzOip5nRM30jduumeE01e2CiTZUbRO+8j67GEvMOk=;
  b=Qc1t9qTRfTDSqdGJQ5SXNPY7+4iu9tHHYIy0ZNJxn19DXp/fqO677Dv4
   WFkwg8MiSH/cDEgHIkXUy0wudxGW8aAg1fMAWICZRUHgr4RWPr6+djVWE
   RdKiC5A7Q9+ppwjZ1DgPlsiwv/eHbtNUb1SPyEiPUs42w6qBPyt5Ao/hR
   O59DLqx4x3pEkGUlvRZqUvEnh7YX5XOCwxddQxgTuXaqt8gAT1HCoIhyb
   cu3pg7zbShXRgtfnkO2XXGrUndX/vSR4+kihs8oUjRz/L8iHknmEm5nl7
   Zo2sf/LtpmfAiPoZH1bkabtU6Tlas1qJbDEMHkNj5sLDgfiAhWySkjTzB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="337908532"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="337908532"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 04:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="675226677"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="675226677"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2023 04:15:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pewRa-007752-29;
        Wed, 22 Mar 2023 13:15:50 +0200
Date:   Wed, 22 Mar 2023 13:15:50 +0200
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
Subject: Re: [PATCH v14 07/10] drm/bridge: anx7625: Register Type C mode
 switches
Message-ID: <ZBrjZj0VL20y1MUC@smile.fi.intel.com>
References: <20230322104639.221402-1-treapking@chromium.org>
 <20230322104639.221402-8-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322104639.221402-8-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:46:36PM +0800, Pin-yen Lin wrote:
> Register USB Type-C mode switches when the "mode-switch" property and
> relevant ports are available in Device Tree. Configure the crosspoint
> switch based on the entered alternate mode for a specific Type-C
> connector.
> 
> Crosspoint switch can also be used for switching the output signal for
> different orientations of a single USB Type-C connector, but the
> orientation switch is not implemented yet. A TODO is added for this.

...

> +static int anx7625_typec_mux_set(struct typec_mux_dev *mux,
> +				 struct typec_mux_state *state)
> +{
> +	struct drm_dp_typec_port_data *port = typec_mux_get_drvdata(mux);
> +	struct anx7625_data *ctx = port->data;
> +	struct device *dev = ctx->dev;
> +	struct drm_dp_typec_switch_desc switch_desc = ctx->switch_desc;
> +	bool new_dp_connected, old_dp_connected;
> +
> +	if (switch_desc.num_typec_switches == 1)
> +		return 0;

> +	wait_for_completion(&ctx->mux_register);

How do we guarantee this won't become an infinite waiting?
Perhaps a comment explaining that?

> +	old_dp_connected = ctx->port_data[0].dp_connected ||
> +			   ctx->port_data[1].dp_connected;
> +
> +	ctx->port_data[port->port_num].dp_connected =
> +		state->alt &&
> +		state->alt->svid == USB_TYPEC_DP_SID &&
> +		state->alt->mode == USB_TYPEC_DP_MODE;
> +
> +	dev_dbg(dev, "mux_set dp_connected: c0=%d, c1=%d\n",
> +		ctx->port_data[0].dp_connected, ctx->port_data[1].dp_connected);
> +
> +	new_dp_connected = ctx->port_data[0].dp_connected ||
> +			   ctx->port_data[1].dp_connected;
> +
> +	/* DP on, power on first */
> +	if (!old_dp_connected && new_dp_connected)
> +		pm_runtime_get_sync(dev);
> +
> +	anx7625_typec_two_ports_update(ctx);
> +
> +	/* DP off, power off last */
> +	if (old_dp_connected && !new_dp_connected)
> +		pm_runtime_put_sync(dev);
> +
> +	return 0;
> +}

...

> +	struct device_node *port_node = of_graph_get_port_by_id(dev->of_node, 1);

You use fwnode below, so why not fwnode_graph_...(dev_fwnode(dev), ...) ?

> +	struct drm_dp_typec_switch_desc *switch_desc = &ctx->switch_desc;
> +	int ret;
> +	u32 dp_lanes[4];
> +	unsigned int i, num_lanes;
> +
> +	/*
> +	 * Currently, only mode switch is implemented.
> +	 * TODO: Implement Type-C orientation switch for anx7625.
> +	 */
> +	ret = drm_dp_register_typec_switches(dev, &port_node->fwnode,
> +					     &ctx->switch_desc, ctx,
> +					     anx7625_typec_mux_set);
> +	if (ret)
> +		return ret;
> +
> +	ctx->port_data = devm_kcalloc(dev, switch_desc->num_typec_switches,
> +				      sizeof(struct anx7625_typec_port_data),

				      sizeof(*ctx->port_data),

?

> +				      GFP_KERNEL);
> +	if (!ctx->port_data) {
> +		ret = -ENOMEM;
> +		goto unregister_mux;
> +	}

...

> +struct anx7625_typec_port_data {
> +	bool dp_connected;
> +	enum typec_orientation orientation;

Most likely enum will be 32-bit and bool 8-bit. Which means that the data type
size become 8 bytes for no reason. Can you swap the lines and perhaps check this
with `pahole` tool?

> +};

-- 
With Best Regards,
Andy Shevchenko


