Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE0A5F66FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiJFM4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiJFM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:56:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349BBA598A;
        Thu,  6 Oct 2022 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665060925; x=1696596925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S5navL3jnwUzMbkOa6ZBmAleAMC/wLUzNSkL2hnfgy8=;
  b=Fmz13lQV/0WzaQrvvX5t/tXe8jkg5/GJyl0zWZJtrZnzpUdh+CB/a8J9
   U86FsZoDjm7k4/DS3PVjZd6aLSJ3GTlAUo25IU7XZv6L2ahvq0/pZoSar
   2ixkg/ZAxHBUFzMAKjahWHuVtQeH4ksn593Zworb4VUETd6CTXLUoudJa
   bwD0VP/ZowZITjSjHuQ09K59GVV1g1gUwD7SWcaXN+jYL77JP7sS6sk6v
   yZyfWFdnc2ZX4ldymFIYDt8Wvl35dwWK8hyOfJRkyRKT8XKqT3dAFyR2M
   5v28PQ1m84GAY7Y/gsTw2q/AZ8EP1ntVGDJwyagpHIwLLEyqo6LraLYhz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="302151218"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="302151218"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 05:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="693341005"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="693341005"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2022 05:55:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ogQP3-0039HF-2x;
        Thu, 06 Oct 2022 15:55:05 +0300
Date:   Thu, 6 Oct 2022 15:55:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] device property: Fix documentation for
 *_match_string() APIs
Message-ID: <Yz7QKTrKtjh3RTYg@smile.fi.intel.com>
References: <20221006123807.37014-1-andriy.shevchenko@linux.intel.com>
 <Yz7N9b3qibyaPAhJ@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7N9b3qibyaPAhJ@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 12:45:41PM +0000, Sakari Ailus wrote:
> On Thu, Oct 06, 2022 at 03:38:07PM +0300, Andy Shevchenko wrote:
> > The returned value on success is an index of the matching string,
> > starting from 0. Reflect this in the documentation.

> > Fixes: 3f5c8d318785 ("device property: Add fwnode_property_match_string()")

...

> > - * Return: %0 if the property was found (success),
> > + * Return: index, starting from %0, if the property was found (success),
> >   *	   %-EINVAL if given arguments are not valid,
> >   *	   %-ENODATA if the property does not have a value,
> >   *	   %-EPROTO if the property is not an array of strings,
> 
> There are other error codes that can be returned such as -ENOMEM or what
> else may be returned by fwnode_property_read_string_array().
> 
> I might just refer to fwnode_property_read_string_array() and document here
> those specific to these functions.
> 
> Just FYI... I guess this could be a separate patch, too.

Right, I think we would rather do an incremental change since that will be
more intrusive and would not be exactly the fix (improvement?).

> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


