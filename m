Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F266ABEC0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCFLwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCFLwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:52:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A428D2A;
        Mon,  6 Mar 2023 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678103519; x=1709639519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+vJI7YuA2cKvI0b1Mt8oP5n5z7Z9J/WAV96Z+3jwwp0=;
  b=YoR/0BlFufDt82EfuDw+8VenkZw7/aP8F2rQgNG1Y1jqAtXN+/iJOEA8
   iwFUoJNXeAr6YBE5Nl5KS5bIIa3TrnALEjSyae3+/JWHpqpelDFeRfCrm
   XAQt868omreiOIlKahzP+Ql+SlgW2tmUbIKGPJEG31ywXY/xDLDkZRGXJ
   1pZ4PTIQwFjodZpqDTPM7QbyUlMI3ObU9+PhqVEGzROUTlqgMghtzzClL
   1qsRkYuJvJkM4sel2E2oKvUD/rxVWiBCGP/lMK/ovMC6MOkLvyVq2jQwl
   l2mBHkHko99bmVNTbIddUD3QbZuDgrytROykC9rcgwiwBF+g5Gr8HqCrP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="421805982"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="421805982"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 03:51:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="678444901"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="678444901"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 06 Mar 2023 03:51:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZ9NY-00GKgD-22;
        Mon, 06 Mar 2023 13:51:44 +0200
Date:   Mon, 6 Mar 2023 13:51:44 +0200
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
        Stephen Boyd <swboyd@chromium.org>, linux-acpi@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v13 05/10] drm/bridge: anx7625: Check for Type-C during
 panel registration
Message-ID: <ZAXT0JFjERb8Q36f@smile.fi.intel.com>
References: <20230303143350.815623-1-treapking@chromium.org>
 <20230303143350.815623-6-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303143350.815623-6-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 10:33:45PM +0800, Pin-yen Lin wrote:
> The output port endpoints can be connected to USB-C connectors.
> Running drm_of_find_panel_or_bridge() with such endpoints leads to
> a continuous return value of -EPROBE_DEFER, even though there is
> no panel present.
> 
> To avoid this, check for the existence of a "mode-switch" property in
> the port endpoint, and skip panel registration completely if so.

...

> +	port_node = of_graph_get_port_by_id(np, 1);
> +	count = typec_mode_switch_node_count(&port_node->fwnode);

Do you need to drop reference count here?
(I don't know myself, so, please check this)

If no, patch LGTM.

> +	if (count)
> +		return 0;

-- 
With Best Regards,
Andy Shevchenko


