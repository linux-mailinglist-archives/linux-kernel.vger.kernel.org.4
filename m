Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080456CA518
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjC0NCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjC0NCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:02:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402681FC9;
        Mon, 27 Mar 2023 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679922151; x=1711458151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GnN5yMqKyMoVbSr4z5kndngc7czLeDZTZGsv8tnHdGc=;
  b=V+HX8Eoprow8Teo2tLScxdFqERdBKybHJZIAKrUE6D7IzcEgybG+zAaA
   NokwtY5lmjykbW7pdR9uwwCyYRdsM3sl/6sfFlWA3eXzugPtxnpOqWHDb
   8E8kfUFL3tjb/s0NDMSFH7PeKwoY8tbySAf6720kDu5C5bKYGDTbX4aE2
   40FI+aB7jzTklQKojPNhfBYqDF7IOoty8Ka9TQ9U/lYU7NLelsz9d4J5v
   B1b4BS4tqu4OQqX/eDjqna4Os19BHQs2XSTlj4GHs5FwJHGffzlrYod8U
   hc6w5ym63e8vD18QMmaX6WNgTQkBT8yPWJIgJmxpl2rwuauRoTtVIAufx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="324137774"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="324137774"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 06:02:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="676954488"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="676954488"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2023 06:02:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pgmUV-009EsW-0c;
        Mon, 27 Mar 2023 16:02:27 +0300
Date:   Mon, 27 Mar 2023 16:02:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] device property: Remove unused struct net_device
 forward declaration
Message-ID: <ZCGT4iONq6hjNQIK@smile.fi.intel.com>
References: <20230323151519.58479-1-andriy.shevchenko@linux.intel.com>
 <ZCFryP+yZ7w38Ix9@smile.fi.intel.com>
 <ZCGChRgzVZoaElge@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCGChRgzVZoaElge@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:48:21PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Mar 27, 2023 at 01:11:20PM +0300, Andy Shevchenko wrote:
> > On Thu, Mar 23, 2023 at 05:15:19PM +0200, Andy Shevchenko wrote:
> > > There is no users in the property.h for the struct net_device.
> > > Remove the latter for good.
> > 
> > Oh, this seems unfortunate as it doesn't Cc Greg. Folks, shall we add
> > the header to "DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS"?
> 
> Yes please.

Done as v2 with this patch also resent there.

-- 
With Best Regards,
Andy Shevchenko


