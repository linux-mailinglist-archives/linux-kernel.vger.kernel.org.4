Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477B0671FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjAROjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjAROj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:39:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A945BFE;
        Wed, 18 Jan 2023 06:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674052170; x=1705588170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8+fojA/7h/Ru//XT9YiU9bcdKtVKTeplGKeIMROnBDA=;
  b=Hiz+YTDE1lg8CwJphjizq7UxfdjGwZ3TeZcht+iAmmdCOOx8srSHLK3m
   VmQx+u8MP+FZGM986RMFcdE8onDJFDZdkDPY2YbfsOH/JehmFCkqe1ioz
   an48ELPpQiFivqtPEyr5fGZIoR+cPuYg5HYes2hOyzqTjvAtqv2kZdP19
   oXjh3cvZeOZVGRzyGjoZLp3VJxXRB1t34pbgYgfXmUSA1LycoOiXIayHD
   dEYSYwDiaMjoQm/TmLq+Ft/gNxruDJ9w+6lbaJvZXk6qpyiZYCsqlIMg0
   OpLJoL9F+KR+7Q9jDd+iTEwFUqccr32lqFmUqXGT6p04iBhxPFwW1od8L
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="325045424"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="325045424"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 06:29:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="661723988"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="661723988"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2023 06:29:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pI9RM-00BDsZ-2e;
        Wed, 18 Jan 2023 16:29:24 +0200
Date:   Wed, 18 Jan 2023 16:29:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <Y8gCRECOja+FxRsf@smile.fi.intel.com>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
 <20230118123528.oaxtjbdier3ojd3m@SoMainline.org>
 <Y8fyonSp49QoAb8v@smile.fi.intel.com>
 <20230118140423.y4ogqdkyti7vcwaz@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118140423.y4ogqdkyti7vcwaz@SoMainline.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 03:04:23PM +0100, Marijn Suijten wrote:
> On 2023-01-18 15:22:42, Andy Shevchenko wrote:

...

> > > > +	name = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", fwnode);
> > > 
> > > Is this better/cleaner than copying the string from fwnode_get_name?
> > 
> > Coying to where? And what would be the lifetime of that string?
> > 
> > With devm_kasprintf():
> > - we don't care how long the string is
> > - we don't care about corner cases of lifetime as it's the same as
> >   device itself (i.o.w. the same as the IIO device container)
> 
> Curious if there isn't a devm_strdup(name) or similar?  Main point is
> that %pfwP seems like magic when fwnode_get_name is not (but returns a
> const string that we cannot modify).

The devm_kstrdup(fwnode_get_name()) is an open coded variant of the above.
I don't think we need to open code and produce NIH even a single API. And
no, there is no magic behind that. At least from the fwnode point of view.

You may very well say that > 1500 instances of "%pOF" is a magic...

> If there is not, let's stick with
> devm_kasprintf().

There is, but I'm against it. See above why.

> > > > +	name[strchrnul(name, '@') - name] = '\0';
> > > 
> > > This is the same as *strchrnul(name, '@') = '\0'; if I'm not mistaken.
> > 
> > Yes, But it's harder to read and understand. I believe the compiler has
> > enough power to optimize this to the same assembly code.
> 
> I find the latter clearer as it doesn't require the reader to figure out
> that name - name cancels itself out.  Alternatively we can write
> strchrnul(name, '@')[0].

I don't like to have Pythonisms in the C code, really.

P.S. I guess this little patch already emptied my bandwidth, so I leave
any further discussion to you and IIO maintainers. Thank you for the
review!

-- 
With Best Regards,
Andy Shevchenko


