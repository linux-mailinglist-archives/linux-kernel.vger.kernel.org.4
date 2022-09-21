Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE305C0037
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiIUOpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiIUOpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:45:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FB570E5C;
        Wed, 21 Sep 2022 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663771537; x=1695307537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iKixqXcEefl/Xpj9HOMOB56b4Cbr/aAPwTYc0H7GWvQ=;
  b=lNUIz7ErRMIcdb4oWSY+dwzlLKH+7k4NKyHzO/qLF1q5Lpr+JON+JrxM
   bNpbMdduYT1NLc76n4rAMFsRzd6C8hqH3JzJBcEbHr5EP2622WBPEhnGu
   P3zcOISOn9GG3aoL4NmMt0NpdwE2nnup3Aju61Ch9a/drkfapyvIYceFh
   yf9p4n2IRscHnYhIoSJqmNwFViMNAlC3cy0t6F0JvoReToZwYR6CzCnKR
   BzBrmrLcoucEB7ZdIME+Wo4pK+RXmCGV0tFTuYzEeUwUaJNGTVgzkSqte
   pgbbO2RlsHcOtst6lvyj4/AYqt9SyIXQuP4H31RCKt7BI1ELXqiv/rtRB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297621062"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="297621062"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 07:45:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="687899979"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2022 07:45:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ob0yk-005az3-09;
        Wed, 21 Sep 2022 17:45:34 +0300
Date:   Wed, 21 Sep 2022 17:45:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, robh@kernel.org,
        linux-serial@vger.kernel.org, ribalda@kernel.org, johan@kernel.org
Subject: Re: Cutiepi, serdevs, and right way to handle its power button
Message-ID: <YysjjSXao4MERCwQ@smile.fi.intel.com>
References: <20220920205637.GA17170@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920205637.GA17170@duo.ucw.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:56:37PM +0200, Pavel Machek wrote:
> Hi!
> 
> Cutiepie is a small handheld tablet. It has embedded controller
> connected via serial to the main system, handling stuff such as power
> button and battery percentage. Currently they are using userland
> deamon for communication, but I believe that should eventually go into
> kernel.
> 
> For debugging, it would be really nice to be able to attach my module
> to given serdev. Is such thing possible? I see "[PATCH v2 00/19]
> Dynamically load/remove serdev devices via sysfs*" series
> (https://www.spinics.net/lists/linux-serial/msg30732.html) but I'm not
> sure if equivalent functionality exists in mainline kernel?
> 
> Is there some kind of similar hardware already supported by mainline?
> Using driver as a reference might be easier than starting from
> scratch.

Is it arm or x86 based tablet?

-- 
With Best Regards,
Andy Shevchenko


