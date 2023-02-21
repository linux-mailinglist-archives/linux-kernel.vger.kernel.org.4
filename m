Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD0169DF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjBULsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjBULsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:48:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB68268B;
        Tue, 21 Feb 2023 03:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676980117; x=1708516117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CUAx3128p+wcaUqqwGRKUOEkNdn9/lm8qFQQoeWtsK8=;
  b=N9KVEOCAO0YpGXjkkz74c3iTGHJDIaqkTmQhu1RkpR3vrRSnrovCA2Es
   7G/PRy06pokMBsKu9LBdHAc47VLAMwW3xXwzdfCSAh0sRSdrqtbDJN42W
   8E1p4yFdUwfiIC51TDrvpOQmqamWtWTgHSRuGZM6j9reELfOEMQtJa5dJ
   RSi+xobmsV48qj0RDZcigJOFp17fx2Vv9woU+RxJTLHVfaXot7eWhxvjJ
   P0X9mxn6PMLOSDsIiBeNmWwUmWw+Yh6bpRTXbpYDFTQRM7/2XOFqSrUWY
   QoHL8ev+EhKy2idB5kmvSYunqks9MV3UN03v4/T3ZDipGT+lSCFw6tMyx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="332616851"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="332616851"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 03:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="795498978"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="795498978"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2023 03:48:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pUR8B-009wIJ-2y;
        Tue, 21 Feb 2023 13:48:23 +0200
Date:   Tue, 21 Feb 2023 13:48:23 +0200
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
        Douglas Anderson <dianders@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v12 03/10] drm/display: Add Type-C switch helpers
Message-ID: <Y/SvhxgjTM2cYZa+@smile.fi.intel.com>
References: <20230221095054.1868277-1-treapking@chromium.org>
 <20230221095054.1868277-4-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221095054.1868277-4-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 05:50:47PM +0800, Pin-yen Lin wrote:
> Add helpers to register and unregister Type-C "switches" for bridges
> capable of switching their output between two downstream devices.
> 
> The helper registers USB Type-C mode switches when the "mode-switch"
> and the "reg" properties are available in Device Tree.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

...

> +	fwnode_for_each_typec_mode_switch(port, sw)
> +		switch_desc->num_typec_switches++;
> +
> +	if (!switch_desc->num_typec_switches) {
> +		dev_dbg(dev, "No Type-C switches node found\n");
> +		return 0;
> +	}

What about

static inline unsigned int typec_mode_switch_node_count(... *port)
{
	... *sw;
	unsigned int count = 0;

	for_each_typec_mode_switch_node(port, sw)
		count++;

	return count;
}


And then it seems something like

	unsigned int count;

	count = typec_mode_switch_node_count(port);
	if (!count) {
		...
	}

	_switches = count;

...

> +	switch_desc->typec_ports = devm_kcalloc(
> +		dev, switch_desc->num_typec_switches,

Strange indentation.

> +		sizeof(struct drm_dp_typec_port_data), GFP_KERNEL);

> +

Redundant blank line.

> +	if (!switch_desc->typec_ports)
> +		return -ENOMEM;

...

> +void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc)
> +{
> +	int i;

unsigned?

> +	for (i = 0; i < switch_desc->num_typec_switches; i++)
> +		typec_mux_unregister(switch_desc->typec_ports[i].typec_mux);
> +}

...

>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/usb/typec_mux.h>

I don't see users of this.
But a few forward declarations are missing.

>  #include <drm/display/drm_dp.h>
>  #include <drm/drm_connector.h>

...

> +#define fwnode_for_each_typec_mode_switch(port, sw)	\
> +	fwnode_for_each_child_node((port), (sw))	\
> +		for_each_if(fwnode_property_present((sw), "mode-switch"))

Please don't use fwnode namespace (see above), something like

#define for_each_typec_mode_switch_node(port, sw)	\
	...

-- 
With Best Regards,
Andy Shevchenko


