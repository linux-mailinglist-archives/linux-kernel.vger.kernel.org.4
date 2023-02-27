Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1256A4EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjB0WiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjB0Whj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:37:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79C62A16B;
        Mon, 27 Feb 2023 14:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677537226; x=1709073226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j9BBL22OrgQurYvsCPk5r9pfycy08TYIh2Hg/JVbOWI=;
  b=UYnZO4N5Gy3fmMwhsLJApLRwotz6r8FsUztJPM2aKegOGyE/x9f35OyR
   mkCkT9EYNcGBVkDz3Om0u5ld87aDi9jDVoXgHLAKm639fKiEFYPb3/35L
   alNmqujfGdRKLKxIvdO1k7ATWofQ4+S0TJ8jmQN4r0pOPtscwDUse0XmH
   VJ3+eXv2G6QHxQxw8O294jDsmWhyQDVOo2PNbntKOEOnUo+03sbN9AUnx
   uVEOGVRbZls2rNJS3BN+LBOBceWJDLEDoV3XBI6UN3e9b03BT3ROiUsJ5
   NkFbNQy9sWd2au1MTRXgj9srD0Ay12U3feE54KbrM/iYhekO35IhBuha6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313658490"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313658490"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:33:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="742734203"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="742734203"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 27 Feb 2023 14:33:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pWm3a-00D1je-1i;
        Tue, 28 Feb 2023 00:33:18 +0200
Date:   Tue, 28 Feb 2023 00:33:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
Message-ID: <Y/0vrqZjKcAnaZAH@smile.fi.intel.com>
References: <Y/iywbFbiUAA6ZD3@kroah.com>
 <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
 <Y/qcXOxTVHTNDQbY@mit.edu>
 <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
 <Y/u59FFG+ID0OAbg@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/u59FFG+ID0OAbg@mit.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 02:58:44PM -0500, Theodore Ts'o wrote:
> On Sat, Feb 25, 2023 at 06:14:11PM -0800, Linus Torvalds wrote:
> > On Sat, Feb 25, 2023 at 3:40 PM Theodore Ts'o <tytso@mit.edu> wrote:
> > >
> > > For what it's worth, in the VM world (e.g., qemu, AWS, GCP, Azure,
> > > Linode, etc.)  serial consoles are quite common way of debugging VM's,
> > > and as an emergency login path when the networking has been screwed up
> > > for some reason....
> > 
> > Everybody seems to be missing the point.
> > 
> > We don't make new drivers "default y" (or, in this case, "default SERIAL_8250".
> > 
> > It does not matter ONE WHIT if you have a serial device in your
> > machine. If your old driver was enabled and worked for you and you
> > used it daily, that is ENTIRELY IMMATERIAL to a new driver, even if
> > that new driver then happens to use some of the same infrastructure as
> > the old one did.
> 
> Oh, agreed, I wasn't responding to that part of your message.  New
> serial drivers should never be enabled by default.

+1 here. I don't know how I missed that during review.

Some of the "new" (not really, the split of the 8250_pci) drivers
I made in the past inherited that so user won't see the change
(sudden disappearance of the console w/o touching defconfig).

-- 
With Best Regards,
Andy Shevchenko


