Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE2A69AA4F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjBQL3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBQL3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:29:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0336060A76;
        Fri, 17 Feb 2023 03:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676633342; x=1708169342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9hg3mvBtW3Rm/ybV14ZW4cgkC624VWNBgoiOXRf2cZk=;
  b=GkXKlPILom5/HyHssz65TWupO1JrTyyrPAEM2hqPkqQAE0+8+evIxWOQ
   ZGArXCPg8HowNTzFnOmZcXd97hwVSFxW0BdIP66/Xb3x3kttbGV/GUJEk
   wPNyVzRH3QpUbqjk/i2lv8kZxCOgo4BZ2+wVwbihC08Rzz9oeIC0u5wvp
   YrM/4Fk55+QaXUnW01Pt1GnFofYou1AzRPkUyDxKnMRVmA0uyYj/NtH7f
   pZGtIbOga2rZATtGa3oHAOleQzXCKvsI0asSRuDOBTM5B6TGN6ZCa0hFZ
   Sw1i0ddIsB8YwyRh7fL1QKg6Vlz6aw/Z7d80991mReRel3Dp522IUClhw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="396641399"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="396641399"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 03:29:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="620364449"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="620364449"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 17 Feb 2023 03:28:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSyvA-008BGB-03;
        Fri, 17 Feb 2023 13:28:56 +0200
Date:   Fri, 17 Feb 2023 13:28:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Kaehn <kaehndan@gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Clarify description on returned
 value in some functions
Message-ID: <Y+9k9wkRgE1JOsr0@smile.fi.intel.com>
References: <20230216205708.13453-1-andriy.shevchenko@linux.intel.com>
 <Y+9Wqbb+zzvH2Ozb@kekkonen.localdomain>
 <Y+9ek6I0tCMHcHRQ@smile.fi.intel.com>
 <Y+9ihz8La+JrIa/L@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+9ihz8La+JrIa/L@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 01:18:31PM +0200, Sakari Ailus wrote:
> On Fri, Feb 17, 2023 at 01:01:39PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 17, 2023 at 12:27:53PM +0200, Sakari Ailus wrote:
> > > On Thu, Feb 16, 2023 at 10:57:08PM +0200, Andy Shevchenko wrote:

...

> > > >   * fwnode_get_next_child_node - Return the next child node handle for a node
> > > >   * @fwnode: Firmware node to find the next child node for.
> > > >   * @child: Handle to one of the node's child nodes or a %NULL handle.
> > > > + *
> > > > + * Caller is responsible to call fwnode_handle_put() on the returned fwnode
> > > > + * pointer.
> > > 
> > > The loop itself will also put the child node, so this is only relevant
> > > outside the loop.
> > 
> > Yes and this is exactly what people stumbled over. Hence this note.
> > This call per se doesn't loop, so I didn't get how your comment can
> > be transformed to anything here. Care to elaborate a bit more on
> > what I have to add here or reword?
> 
> Ah, indeed. This is achieved by putting the previous child. Generally this
> function is used via the loop helper macro and not called directly, hence
> the documentation there matters the most. Those functions appear to be
> without any documentation though.

So, what should I do?

-- 
With Best Regards,
Andy Shevchenko


