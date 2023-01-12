Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06BE66715B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbjALL4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjALLzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:55:32 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF24DEB8;
        Thu, 12 Jan 2023 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673523984; x=1705059984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=48b18wuQk9eJKcK1WEXv3Eqzs0Sp3dxKG6GZMS1JotA=;
  b=P+xRYvzy6sOxaOkY8C75BOE8koH14VYdlJpt2lJIBZ2d2/MerEv8QQwL
   CzJG2Es/GNTokwWDoMOw14AgDfqfyfz9k//wqYLgj4wvk9zbnYs11718B
   pRnDesDkUMd6/snGVjRbvT7tI4FT/QZ/0X+OgOTWJfaUQU6HCR91WXJLw
   0KTp9aSofh3SRmWmhABRlFDUpJGhU3cxiUvGroXZPP2ZzweTompgG962f
   Oon/cJg7zbcog6r0z5TjvoV0zbR7H82H40U4D5qwr/NA7i55w/1uHpBVu
   nFheVonp8/gGFt5aWa+WkujqyS+HQSonhHhGhj3U/tNDAevoUXdxexeEV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="323744642"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="323744642"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 03:46:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="765584704"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="765584704"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jan 2023 03:46:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pFw2G-0081iU-2J;
        Thu, 12 Jan 2023 13:46:20 +0200
Date:   Thu, 12 Jan 2023 13:46:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Niyas Sait <niyas.sait@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: Proofreading and updating the
 documentation accordingly
Message-ID: <Y7/zDAhyuoJrMfiU@smile.fi.intel.com>
References: <20230109205456.30618-1-andriy.shevchenko@linux.intel.com>
 <Y70sHNqLVvx6UF41@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y70sHNqLVvx6UF41@debian.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 04:13:00PM +0700, Bagas Sanjaya wrote:
> On Mon, Jan 09, 2023 at 10:54:56PM +0200, Andy Shevchenko wrote:
> > diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/driver-api/pin-control.rst
> > index 0022e930e93e..0274313e9997 100644
> > --- a/Documentation/driver-api/pin-control.rst
> > +++ b/Documentation/driver-api/pin-control.rst
> > @@ -11,7 +11,7 @@ This subsystem deals with:
> >  - Multiplexing of pins, pads, fingers (etc) see below for details
> >  
> >  - Configuration of pins, pads, fingers (etc), such as software-controlled
> > -  biasing and driving mode specific pins, such as pull-up/down, open drain,
> > +  biasing and driving mode specific pins, such as pull-up, pull-down, open drain,
> >    load capacitance etc.
> >  
> >  Top-level interface

Thank you for your input, can I add it as a separate change on top of mine? I would like to keep
my stuff separate from the more intrusive changes (scope is mostly on the examples and function
references). If yes, can you provide your SoB tag?

Btw, the pad table is not align on purpose AFAIU how BGA looks from the bottom.

-- 
With Best Regards,
Andy Shevchenko


