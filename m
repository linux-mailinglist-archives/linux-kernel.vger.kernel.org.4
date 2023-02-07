Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A03B68E2F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBGV0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGV0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:26:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3397B3EFF8;
        Tue,  7 Feb 2023 13:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675805149; x=1707341149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wNen/FnBjNX3bzOs+p58aweLxojs1tMz6HAqiUGxA78=;
  b=MlgW8QcLa+XIsZoejVc1UIbmHkyvefrbedsQ2HDfmjGn22HYAdVhWrLk
   jb54i2ck3nsKMVQEZ+H8Ykx8HZKJjwl0pj9oNJBdkzJdPmUXjAqaVgS4x
   P6KQyuh/Zdep8+uoK0l2bEwNwy9fx7URarzOH0rYIfobECOKHgI3xNYr9
   6gL1BEq3v4oNAKWoIRlzWGrnv2iglDzD1sRwlgtcVfg3bSns5ZCShRVyI
   S7kY1yHmND0/lTiTa72Ohl7xzC4IAhCypmNiH362WlO2lUFeA/Kfygenc
   xfdyVnkpS5QMSvZF5Zr3OFETz4rm/DbToOoEGs2UXjMEQ+KkCABfudSOj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331765716"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="331765716"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 13:25:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="730595933"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="730595933"
Received: from isergee-mobl3.ger.corp.intel.com (HELO intel.com) ([10.249.37.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 13:25:37 -0800
Date:   Tue, 7 Feb 2023 22:25:34 +0100
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org,
        =?iso-8859-15?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
        devicetree@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        Lyude Paul <lyude@redhat.com>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        chrome-platform@lists.linux.dev,
        Alex Deucher <alexander.deucher@amd.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v11 3/9] drm/display: Add Type-C switch helpers
Message-ID: <Y+LBzkP+/j6RQ5Jy@ashyti-mobl2.lan>
References: <20230204133040.1236799-1-treapking@chromium.org>
 <20230204133040.1236799-4-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204133040.1236799-4-treapking@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pin-yen,

[...]

> +static int drm_dp_register_mode_switch(struct device *dev,
> +				       struct fwnode_handle *fwnode,
> +				       struct drm_dp_typec_switch_desc *switch_desc,
> +				       void *data, typec_mux_set_fn_t mux_set)
> +{
> +	struct drm_dp_typec_port_data *port_data;
> +	struct typec_mux_desc mux_desc = {};
> +	char name[32];
> +	u32 port_num;
> +	int ret;
> +
> +	ret = fwnode_property_read_u32(fwnode, "reg", &port_num);
> +	if (ret) {
> +		dev_err(dev, "Failed to read reg property: %d\n", ret);
> +		return ret;
> +	}
> +
> +	port_data = &switch_desc->typec_ports[port_num];
> +	port_data->data = data;
> +	port_data->port_num = port_num;
> +	port_data->fwnode = fwnode;
> +	mux_desc.fwnode = fwnode;
> +	mux_desc.drvdata = port_data;
> +	snprintf(name, sizeof(name), "%pfwP-%u", fwnode, port_num);
> +	mux_desc.name = name;
> +	mux_desc.set = mux_set;
> +
> +	port_data->typec_mux = typec_mux_register(dev, &mux_desc);
> +	if (IS_ERR(port_data->typec_mux)) {
> +		ret = PTR_ERR(port_data->typec_mux);
> +		dev_err(dev, "Mode switch register for port %d failed: %d\n",
> +			port_num, ret);
> +
> +		return ret;

you don't need this return here...

> +	}
> +
> +	return 0;

Just "return ret;" here.

> +}
> +
> +/**
> + * drm_dp_register_typec_switches() - register Type-C switches
> + * @dev: Device that registers Type-C switches
> + * @port: Device node for the switch
> + * @switch_desc: A Type-C switch descriptor
> + * @data: Private data for the switches
> + * @mux_set: Callback function for typec_mux_set
> + *
> + * This function registers USB Type-C switches for DP bridges that can switch
> + * the output signal between their output pins.
> + *
> + * Currently only mode switches are implemented, and the function assumes the
> + * given @port device node has endpoints with "mode-switch" property.
> + * The port number is determined by the "reg" property of the endpoint.
> + */
> +int drm_dp_register_typec_switches(struct device *dev, struct fwnode_handle *port,
> +				   struct drm_dp_typec_switch_desc *switch_desc,
> +				   void *data, typec_mux_set_fn_t mux_set)
> +{
> +	struct fwnode_handle *sw;
> +	int ret;
> +
> +	fwnode_for_each_child_node(port, sw) {
> +		if (fwnode_property_present(sw, "mode-switch"))
> +			switch_desc->num_typec_switches++;
> +	}

no need for brackets here

> +
> +	if (!switch_desc->num_typec_switches) {
> +		dev_dbg(dev, "No Type-C switches node found\n");

dev_warn()?

> +		return 0;
> +	}
> +
> +	switch_desc->typec_ports = devm_kcalloc(
> +		dev, switch_desc->num_typec_switches,
> +		sizeof(struct drm_dp_typec_port_data), GFP_KERNEL);
> +
> +	if (!switch_desc->typec_ports)
> +		return -ENOMEM;
> +
> +	/* Register switches for each connector. */
> +	fwnode_for_each_child_node(port, sw) {
> +		if (!fwnode_property_present(sw, "mode-switch"))
> +			continue;
> +		ret = drm_dp_register_mode_switch(dev, sw, switch_desc, data, mux_set);
> +		if (ret)
> +			goto err_unregister_typec_switches;
> +	}
> +
> +	return 0;
> +
> +err_unregister_typec_switches:
> +	fwnode_handle_put(sw);
> +	drm_dp_unregister_typec_switches(switch_desc);
> +	dev_err(dev, "Failed to register mode switch: %d\n", ret);

there is a bit of dmesg spamming. Please choose where you want to
print the error, either in this function or in
drm_dp_register_mode_switch().

Andi

> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_dp_register_typec_switches);

[...]
