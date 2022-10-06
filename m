Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57E5F68C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiJFOEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiJFOE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:04:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA218A7A8C;
        Thu,  6 Oct 2022 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665065064; x=1696601064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dSN5ls+faU5biUqUsahYkwk5ZW36AQkBVswr/zkx8wM=;
  b=A+MLMgMeB6jBqtao2XHtF/333ZNtwKvVMJb491e4FIyGzD3XrGriVHgN
   QWsMZlaUYgHfG4hG/WK0Mbq1VM0ai0hJRKOIfqvEqH65Mh3fOWRYDK9dg
   YxEeprx1OiK3AWTE6m5+S8coCrLeI0RJSJc7c168DJS1e6V8CXMRPSN7P
   8+6U3Ac+qn4KXXcBwM0AjHEsLYyeBq0IiFVOtYok7Dc2vxovrNqCarkrD
   LLGKMChxS66Nu/Iq19hjl8arqVkc4JIW4z6TqjaSUqywDY3gkCyDjf1u4
   nawSB7NImZPmJaJiggY6j305jGC6qhaLGpBxRNb6zhmr5fCWO7kpcz4pO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="290707470"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="290707470"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 07:04:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="729157001"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="729157001"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 07:04:22 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 4DACD2033F;
        Thu,  6 Oct 2022 17:04:20 +0300 (EEST)
Date:   Thu, 6 Oct 2022 14:04:20 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] device property: Fix documentation for
 *_match_string() APIs
Message-ID: <Yz7gZF2ktEM3JVoJ@paasikivi.fi.intel.com>
References: <20221006123807.37014-1-andriy.shevchenko@linux.intel.com>
 <Yz7N9b3qibyaPAhJ@paasikivi.fi.intel.com>
 <Yz7QKTrKtjh3RTYg@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7QKTrKtjh3RTYg@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:55:05PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 06, 2022 at 12:45:41PM +0000, Sakari Ailus wrote:
> > On Thu, Oct 06, 2022 at 03:38:07PM +0300, Andy Shevchenko wrote:
> > > The returned value on success is an index of the matching string,
> > > starting from 0. Reflect this in the documentation.
> 
> > > Fixes: 3f5c8d318785 ("device property: Add fwnode_property_match_string()")
> 
> ...
> 
> > > - * Return: %0 if the property was found (success),
> > > + * Return: index, starting from %0, if the property was found (success),
> > >   *	   %-EINVAL if given arguments are not valid,
> > >   *	   %-ENODATA if the property does not have a value,
> > >   *	   %-EPROTO if the property is not an array of strings,
> > 
> > There are other error codes that can be returned such as -ENOMEM or what
> > else may be returned by fwnode_property_read_string_array().
> > 
> > I might just refer to fwnode_property_read_string_array() and document here
> > those specific to these functions.
> > 
> > Just FYI... I guess this could be a separate patch, too.
> 
> Right, I think we would rather do an incremental change since that will be
> more intrusive and would not be exactly the fix (improvement?).

It's a fix in documentation. It's perhaps unlikely a bug would have been
introduced because of what was missing.

> 
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Thanks!

You're welcome!

-- 
Sakari Ailus
