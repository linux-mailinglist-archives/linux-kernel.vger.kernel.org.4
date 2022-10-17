Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82818601D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiJQXN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiJQXNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:13:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8266283202;
        Mon, 17 Oct 2022 16:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666048413; x=1697584413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gJSpnXDd9a5URqKvHdRUeBNM0VMnrYwNhXSPkWnnaas=;
  b=i7p07V7BO9jHvr+T4hYt+0OBeI3ZiwHRkiCyDjpPhUDsweROB7CSdJQq
   +wXlw71ZvZDWxaN2k0Dc8/+zFLhRXSpI6CBWe2xZUIcH+izDn0ZBnsSYz
   9J+MMM4ZrOUtefMiBI+vW0ZcWeWFDx+7RSfW65leEuZs/bcCmoRRI9vN0
   Yd5cIdvyZwVq4oo/pd+qc2H7AIxAWeHNM+Y6U8yOr0qxxtErNXvEjXIqm
   4KA0sOtAZdN3GlEsRfry2zdAtPl5a5Djd7ccZQF0PDR2mVx/1yQbW1y4r
   KQfxV832Lmvgz4ELf48mtmD4FQaBo+yBrOsifN7VXDQVWtw1G/xZh0+tk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="304680758"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="304680758"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 16:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="733351877"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="733351877"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 17 Oct 2022 16:12:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1okZHc-0095pi-2V;
        Tue, 18 Oct 2022 02:12:32 +0300
Date:   Tue, 18 Oct 2022 02:12:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] usb: dwc3: revert OTG changes for Intel Merrifield
Message-ID: <Y03hYB0MU9y6sP8U@smile.fi.intel.com>
References: <20220927155332.10762-1-andriy.shevchenko@linux.intel.com>
 <CAHQ1cqEAqRx092Ok9uRUpQCuGHAhkq08W78OFst22Ej8ZmmAsQ@mail.gmail.com>
 <20221017222237.qaxskzyf6dj633oj@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017222237.qaxskzyf6dj633oj@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:22:46PM +0000, Thinh Nguyen wrote:
> On Mon, Oct 17, 2022, Andrey Smirnov wrote:
> > On Tue, Sep 27, 2022 at 8:53 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > As agreed with the author, the v5.19 change is going to be reverted by
> > > this series, so we will collaborate on a new one in the future that
> > > brings no regressions.
> > >
> > > Changelog v2:
> > > - added Cc: stable@ and Fixes tags (Greg)
> > > - rewritten cover letter to point out what the version is touched and
> > >   what the decision made with the author of the original change (Greg)
> > > - fixed the placement of one piece of code (Andrey)
> > > - added Tested-by tags (Ferry)
> > >
> > > Andy Shevchenko (2):
> > >   Revert "USB: fixup for merge issue with "usb: dwc3: Don't switch OTG
> > >     -> peripheral if extcon is present""
> > >   Revert "usb: dwc3: Don't switch OTG -> peripheral if extcon is
> > >     present"
> > >
> > 
> > To spare everyone the need to read extra long thread in
> > [PATCH v2 2/2] Revert "usb: dwc3: Don't switch OTG -> peripheral if
> > extcon is present"
> > 
> > NAK, on the whole series. The regression doesn't repro on my
> > Edison/Merriefield setup and doesn't repro on the original reporter's
> > HW with my build, so it's very much unclear what's going on and what
> > the problem is and until it is the revert doesn't seem warranted.
> > Please don't apply this.
> > 
> 
> Thanks for your tests. The series was already applied. It's a bit messy,
> but it seems like we need to revert series as there are already reports
> that this it already breaks other setups.

I will prepare a patch to reapply what was before the revert.
Sorry for the mess.

-- 
With Best Regards,
Andy Shevchenko


