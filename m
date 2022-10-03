Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF25F2E7C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiJCJto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiJCJtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:49:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335DE286F2;
        Mon,  3 Oct 2022 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664790513; x=1696326513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E0CTYykqySVbtBOf0bX2T6T6Ja5oP2vcKn42+x/g9l0=;
  b=I+q6kOISM6EW5zMvoP5MRJe4x13LcgvFOXAJ6f2kf20Fn2J4N6ZgrZqK
   R1l05S52dNliFPOcGJ+qfRLZwKfLlt/qyoOxGp+7k5gV9+Jt0cOWvfEMk
   9uWZEfCLKr3/lizI0kaqlD+3P8wB6a7iXSgWgaOj5jFHgVpyuKpSnkLWB
   qTZQM+APrtOA6XP/SnFZdH2IVxFqGcnvfK9mbJ/64RfHPK+vDe/HJrcwk
   MlH04ecbi0jP2z4Zg1JJzDqRkeSrcGFm5LMloCv5HBjzUtilYJzcHlhs0
   5HkBgWJSjPPkdn4gsjD+DyPiLcBW/rUUv/ZXeOTlEi0kF2s5H6Nhcuota
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="366635912"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="366635912"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 02:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="712527329"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="712527329"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2022 02:48:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ofI3p-001RuC-0U;
        Mon, 03 Oct 2022 12:48:29 +0300
Date:   Mon, 3 Oct 2022 12:48:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: LED Maintainership
Message-ID: <Yzqv7BI5McprlP99@smile.fi.intel.com>
References: <Ys/kruf8DE4ISo8M@google.com>
 <20220714112326.GA16407@duo.ucw.cz>
 <YtAIm+X2XchcSkFX@google.com>
 <20220714222541.232eadfb@thinkpad>
 <20220920085353.GB17087@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920085353.GB17087@duo.ucw.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:53:53AM +0200, Pavel Machek wrote:

...

> > > No problem.  The offer still stands.
> > > 
> > > I guess Marek and I aren't mutually exclusive either.
> > > 
> > > Any harm in us both helping out (if Marek is also interested that is)?
> > 
> > Hello Lee, Pavel,
> > 
> > I am interested, but unfortunately I won't have much time for reviewing
> > patches until september.
> > 
> > From september, I would be open to co-maintaining.
> 
> Ok, lets do it? Do you want to submit line into MAINTAINERS file? :-).

Any news here?
I think somebody can submit a patch and stakeholders can Ack it?

-- 
With Best Regards,
Andy Shevchenko


