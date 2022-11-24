Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F8E6378B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKXMSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKXMSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:18:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CD9B2C;
        Thu, 24 Nov 2022 04:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669292296; x=1700828296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=88JzpGsV3l3i1UU+gsY2jc1hU9imedkQHBbOB9+/b6U=;
  b=YUaMM5UaZqbyyEQpCuhXV1DJXir/vkLlfXYkOUdcTw/cKhvc2+y2aj2u
   perQAc4l5HrDbMZ8leMOjpNOOHKP8FiGTZBEgk6GSt5UR0DldnH1NcK7W
   oLexJdz/2LToiLelm4tIm2jLtj/Le4LxyMabLvcosKwivtKHhcaEf5Rst
   /ywUS2ubuFm7AMH1enD28QzWIbS1vmeBrj64EMK5xbzNvYaCz3Q7s/ZYl
   kAPsQsC8Rx3iDNuRYTp6odqnhI4Eg4mkdrBykL6AbFhEFt//1okNhVALo
   3hrUk+ljQsoOt49nWNQwKyJPaaZXHwc8sCRX2Ilpk01lmXlt0HOzBtHNU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="312990215"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="312990215"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 04:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="887356125"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="887356125"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 24 Nov 2022 04:18:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyBB6-00Gjps-36;
        Thu, 24 Nov 2022 14:18:04 +0200
Date:   Thu, 24 Nov 2022 14:18:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>, Lyude Paul <lyude@redhat.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>
Subject: Re: [PATCH v6 5/7] drm/bridge: anx7625: Register Type C mode switches
Message-ID: <Y39g/OBLW3pt9qdy@smile.fi.intel.com>
References: <20221124102056.393220-1-treapking@chromium.org>
 <20221124102056.393220-6-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124102056.393220-6-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 06:20:54PM +0800, Pin-yen Lin wrote:
> Register USB Type-C mode switches when the "mode-switch" property and
> relevant port are available in Device Tree. Configure the crosspoint
> switch based on the entered alternate mode for a specific Type-C
> connector.

...

> +static void anx7625_typec_two_ports_update(struct anx7625_data *ctx)
> +{
> +	if (ctx->typec_ports[0].dp_connected && ctx->typec_ports[1].dp_connected)
> +		/* Both ports available, do nothing to retain the current one. */
> +		return;

> +	else if (ctx->typec_ports[0].dp_connected)

This 'else' is redundant. I would rewrite above as

	/* Check if both ports available and do nothing to retain the current one */
	if (ctx->typec_ports[0].dp_connected && ctx->typec_ports[1].dp_connected)
		return;

	if (ctx->typec_ports[0].dp_connected)

> +		anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_NORMAL);
> +	else if (ctx->typec_ports[1].dp_connected)
> +		anx7625_set_crosspoint_switch(ctx, TYPEC_ORIENTATION_REVERSE);
> +}

...

> +	data->dp_connected = (state->alt && state->alt->svid == USB_TYPEC_DP_SID &&
> +			      state->alt->mode == USB_TYPEC_DP_MODE);

Parentheses are not needed.

...

> +	/*
> +	 * <0 1> refers to SSRX1/SSTX1, and <2 3> refers to SSRX2/SSTX2.
> +	 */
> +	for (i = 0; i < num_lanes; i++) {

> +		if (port_num != -1 && port_num != dp_lanes[i] / 2) {
> +			dev_err(dev, "Invalid data lane numbers\n");
> +			return -EINVAL;
> +		}

According to Rob Linux must not validate device tree. If you need it, use
proper YAML schema.

> +		port_num = dp_lanes[i] / 2;
> +	}

...

> +	if (!ctx->num_typec_switches) {
> +		dev_warn(dev, "No Type-C switches node found\n");

> +		return ret;

Why not to return 0 explicitly?

> +	}

...

> +	ctx->typec_ports = devm_kcalloc(

Broken indentation.

> +		dev, ctx->num_typec_switches, sizeof(struct anx7625_port_data),
> +		GFP_KERNEL);
> +	if (!ctx->typec_ports)
> +		return -ENOMEM;

...

> +struct anx7625_port_data {

> +	bool dp_connected;

You can save some bytes on some architectures if move this to be last field.

> +	struct typec_mux_dev *typec_mux;
> +	struct anx7625_data *ctx;
> +};

-- 
With Best Regards,
Andy Shevchenko


