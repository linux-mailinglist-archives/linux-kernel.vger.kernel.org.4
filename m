Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB2B69DED1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjBUL1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjBUL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:27:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D7C265B6;
        Tue, 21 Feb 2023 03:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676978837; x=1708514837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mu/cApGuk7VVKjAEkm4PpZVWYpUQxdGCpHYcvzLEl5o=;
  b=aR6qKFjyPolyNEvZQlz2CKFDZjKYbl49aZjzaYH422abZu6TLqlk0jaw
   XBCqLhXRVISisRX01OPo/nEKyeYzKk34niybjT+/YSIfJWfiRpHY/UhI7
   8qFHDYWrdSBaOHeVriMobNa0ADhZ7cemqZsJFhLETRsGkyKcBI0sIKIaL
   8FIC72SEZ16A6K4So1KZzrca33wqZm8srqQzICtFlFTXhS6llnv5ALYhE
   Ld8wLVgZP9Wbz5QEggBOjY9/2733P8Q79k01L67rUe2THiowKF7JD0yNB
   WmL6BTb8SIvos4/S+PMPYToFNHOGPaIzE0fVJdkvpPUEkf7K4RA5+zjUw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="397293428"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="397293428"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 03:27:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="621465092"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="621465092"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 21 Feb 2023 03:26:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pUQnL-009vxT-2d;
        Tue, 21 Feb 2023 13:26:51 +0200
Date:   Tue, 21 Feb 2023 13:26:51 +0200
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
        linux-acpi@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v12 01/10] device property: Add remote endpoint to devcon
 matcher
Message-ID: <Y/SqezaEvOjwGkUg@smile.fi.intel.com>
References: <20230221095054.1868277-1-treapking@chromium.org>
 <20230221095054.1868277-2-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221095054.1868277-2-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 05:50:45PM +0800, Pin-yen Lin wrote:
> From: Prashant Malani <pmalani@chromium.org>
> 
> When searching the device graph for device matches, check the
> remote-endpoint itself for a match.
> 
> Some drivers register devices for individual endpoints. This allows
> the matcher code to evaluate those for a match too, instead
> of only looking at the remote parent devices. This is required when a
> device supports two mode switches in its endpoints, so we can't simply
> register the mode switch with the parent node.

...

>   * @match: Function to check and convert the connection description
>   *
>   * Find a connection with unique identifier @con_id between @fwnode and another
> - * device node. @match will be used to convert the connection description to
> - * data the caller is expecting to be returned.
> + * device node. For fwnode graph connections, the graph endpoints are also
> + * checked. @match will be used to convert the connection description to data
> + * the caller is expecting to be returned.
>   */

Please add a Return: section at the end of the kernel doc.
Otherwise it complains that there is none.

...

>   * @matches_len: Length of @matches
>   *
>   * Find up to @matches_len connections with unique identifier @con_id between
> - * @fwnode and other device nodes. @match will be used to convert the
> - * connection description to data the caller is expecting to be returned
> - * through the @matches array.
> + * @fwnode and other device nodes. For fwnode graph connections, the graph
> + * endpoints are also checked. @match will be used to convert the connection
> + * description to data the caller is expecting to be returned through the
> + * @matches array.
>   * If @matches is NULL @matches_len is ignored and the total number of resolved
>   * matches is returned.

Ditto.

-- 
With Best Regards,
Andy Shevchenko


