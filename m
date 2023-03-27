Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955236CA189
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjC0KhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjC0Kg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:36:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13D32D41;
        Mon, 27 Mar 2023 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679913415; x=1711449415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S0i4W1W4m+Lq94hxja6SL1wsscjOQ463mDMWVOPfQOs=;
  b=ZjJx3e+UnDG8RvuOZ4yCGNvolEbVO1GcyUOs0QMxcSZbftOlJiwE4s/r
   +/bdl0/gONEXZ86rwqBbleSxcXNc6orm7Z6TY8LLhdAhRO0a+Dx2u8vP/
   /wIKR5vXTuyUxrn40Wj6iiG6y1M/H27cpo6AoR5BlwJmPnHrBKxgcljOx
   X5bpdOI6Q+cFDKa5uZymtzfB8h1hZQ9tgl424aKsgUrOZQYD8gJg58jdV
   fu7rcZno/MxSz5Sl7UEwKQHyeOjhedrP/aneW0ee/zKh3gRzSk4vNrVo7
   EfGKaq+nu3KdQBSo20uM1ud46yz0iVpzvO6+zfsLpFgLWdija84hA+ukC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367976394"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="367976394"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 03:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="676921847"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="676921847"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2023 03:36:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pgkDb-009B5o-1v;
        Mon, 27 Mar 2023 13:36:51 +0300
Date:   Mon, 27 Mar 2023 13:36:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the gpio-intel tree
Message-ID: <ZCFxw+6QGYJzl+sK@smile.fi.intel.com>
References: <20230327112026.409883c2@canb.auug.org.au>
 <CACMJSevvO0B8O0K4HtdTdxsGYGVfyHOug=qSg00SwVU+vw8Xsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMJSevvO0B8O0K4HtdTdxsGYGVfyHOug=qSg00SwVU+vw8Xsw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 09:14:00AM +0200, Bartosz Golaszewski wrote:
> On Mon, 27 Mar 2023 at 02:20, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > The following commits are also in the gpio-brgl-fixes tree as a different
> > commit (but the same patch):
> >
> >   782eea0c89f7 ("gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU")
> >
> > This is commit
> >
> >   a21031ccf31b ("gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU")
> >
> > in the gpio-brgl-fixes tree.
> >
> I missed the fact Andy already picked it up. Now backed out of my tree.

Oh, thank you, folks. for sorting this out!


-- 
With Best Regards,
Andy Shevchenko


