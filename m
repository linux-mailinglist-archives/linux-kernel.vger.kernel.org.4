Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22741619E5E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiKDRVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiKDRVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:21:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E280541995;
        Fri,  4 Nov 2022 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667582458; x=1699118458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fXSKXTbaflS2uuSmlIGEbT7emXcpOfZgNSVzxTrME1M=;
  b=hwrXcLVdlr3eLzAXQtV5WjhOzVARdcDr/hGXw0lihSX8ESQ0R5jl9VE4
   CPuAwP/IfWEUL8fWRohbgmxClafXGNiv4yaYkk4ZRMlcyRsC5xn9hQdBH
   2wlvdBLlkSbEfNJaECwLX4/nCOGyEwBKsmRGEmSlovFhLyiPjZPYIWkiu
   p1ylTcTSPce4C1LkVMHNC4q40WsQStptWERl7ufQU0Vp5IyfgjlqA7I1+
   LK9WaFAC4Z7Pp1tnqNMfN9l7txgoOodvFTPQnAsIw3+HM/+QUrH24+iFy
   QSf9ctLycu/P2e+iz7WPMYgzObR4k/jbDtfQ0jmiU4gB/DlFUVmMWT1QP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="374261849"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="374261849"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 10:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="740699853"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="740699853"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2022 10:20:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1or0NB-007Syj-1S;
        Fri, 04 Nov 2022 19:20:53 +0200
Date:   Fri, 4 Nov 2022 19:20:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [rft, PATCH v2 1/1] gpiolib: Get rid of not used of_node member
Message-ID: <Y2VJ9ZLEitrJsT7c@smile.fi.intel.com>
References: <20221103180643.79352-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=McicB36evBh5thWPtnMPuzbfY+4m29i6Mp-1tJSw9OvjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McicB36evBh5thWPtnMPuzbfY+4m29i6Mp-1tJSw9OvjQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 04:09:59PM +0100, Bartosz Golaszewski wrote:
> On Thu, Nov 3, 2022 at 7:06 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > All new drivers should use fwnode and / or parent to provide the
> > necessary information to the GPIO library.

...

> This looks good to me.


Thank you!

> I'm thinking about just applying it and giving
> it a spin in next right away.

I would like to split it, one patch, btw, had been already sent separately.

So, if you are going for the Linux Next, I would like to ask for rebasing
later on.

Also note, it requires patches that are in Linus' W. and mine trees.
It will fail if you apply without those to be proceeded first.

> Linus: any objections?

-- 
With Best Regards,
Andy Shevchenko


