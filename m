Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682B360DF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiJZLRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiJZLRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:17:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AD892CF4;
        Wed, 26 Oct 2022 04:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666783022; x=1698319022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/IDcXtJ6z41kSu2sqVrvnfo3I++QEoOsQfl7FITSHE0=;
  b=M0t0RjN2FbOKpEIn44ns/TZzWe0v5FmLX2RCPlSFejAoJCesiSXugB2U
   rH9yseivN2Ey3fkbbKowGJxcCmIn2HLGsSpw2QjoWXxT7oFhUsWdnRkWE
   KkX+c6X2PkFMP+nBl/0aPKJdg43OKBsMyFoXGPPl7kG2jpIP4aIPALC7T
   AL0ASrpZtTPW2B3nnIMUafdVqb80/4fThtGiAhI/d9B5hn4pa0ih3/Vrp
   P7Ju/rj8QtjTJINzznr3Hf4/yBEg2RL8vIbJz7J0Eag+IWBZe4RyZeQII
   MqDvxCV0KZHu4ThJS1SBFuMWu8/BcyR4mPmf8zo+m6gUqtOqqemWaoiOJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="288315158"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="288315158"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 04:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="721212128"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="721212128"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Oct 2022 04:16:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oneP3-002brA-1J;
        Wed, 26 Oct 2022 14:16:57 +0300
Date:   Wed, 26 Oct 2022 14:16:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] device property: Fix documentation for
 *_match_string() APIs
Message-ID: <Y1kXKUuLqAnoBMD+@smile.fi.intel.com>
References: <20221006123807.37014-1-andriy.shevchenko@linux.intel.com>
 <Y1em/YJwcvLV4J05@smile.fi.intel.com>
 <CAJZ5v0hKgtVSH51+XP+Yb6b9HZaMhmRgDjrkGSupuafg5MPKiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hKgtVSH51+XP+Yb6b9HZaMhmRgDjrkGSupuafg5MPKiw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 08:20:24PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 25, 2022 at 11:06 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 06, 2022 at 03:38:07PM +0300, Andy Shevchenko wrote:
> > > The returned value on success is an index of the matching string,
> > > starting from 0. Reflect this in the documentation.
> > >
> > > Fixes: 3f5c8d318785 ("device property: Add fwnode_property_match_string()")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Is this gone through the cracks?
> 
> No, it is not.  I've just applied it for 6.1-rc3.

Thank you, Rafael!

-- 
With Best Regards,
Andy Shevchenko


