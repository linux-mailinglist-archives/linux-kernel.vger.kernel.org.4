Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4CE672256
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjARQBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjARQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:00:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9533A37544;
        Wed, 18 Jan 2023 07:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674057432; x=1705593432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DkJy9b3JAxxLyt2nl0Vw3miTgnaruYcbY3qIyzZgzDU=;
  b=Xvm2bZZ/5kXFor7w3N9zSRnHWla7iTMlrmH60HSKnxUZPCXBZ9SBAukj
   a+p2si6+7HIrmEDSr6RE4967/mJJFyj52fDg66wqjEqsKPI2Gq/Sest8m
   U168oxs0hegtMaMddL9ZMxF9dxzQ6juHa4lDSpxWspFsUhaUQU/muPovD
   WSwJ0hPuR9pfDnd9J51NQVspRFO8sOy4wdIVL8hQvHPecCNCclew3RZqW
   XMsTzpk5o/HmVMNE0zptlKCi+CVXpv64XGfhNnSebG/deiTxvclKuDB3T
   ymaaL1JHxHjtyBnOjlrIsEwIv1qsFJ8jgL3yHEsVJoAuaCX/6iTJemIab
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323699437"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="323699437"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:57:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="659845668"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="659845668"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 18 Jan 2023 07:57:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIAoE-00BFsU-1a;
        Wed, 18 Jan 2023 17:57:06 +0200
Date:   Wed, 18 Jan 2023 17:57:06 +0200
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
Message-ID: <Y8gW0msz0KwkpQaA@smile.fi.intel.com>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
 <20230118123528.oaxtjbdier3ojd3m@SoMainline.org>
 <Y8fyonSp49QoAb8v@smile.fi.intel.com>
 <20230118140423.y4ogqdkyti7vcwaz@SoMainline.org>
 <Y8gCRECOja+FxRsf@smile.fi.intel.com>
 <20230118152121.blb74eplrqz5rww2@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118152121.blb74eplrqz5rww2@SoMainline.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 04:21:21PM +0100, Marijn Suijten wrote:
> On 2023-01-18 16:29:24, Andy Shevchenko wrote:
...
> > The devm_kstrdup(fwnode_get_name()) is an open coded variant of the above.
> > I don't think we need to open code and produce NIH even a single API. And
> > no, there is no magic behind that. At least from the fwnode point of view.
> > 
> > You may very well say that > 1500 instances of "%pOF" is a magic...
> 
> Forgive me for not having a clear definition of "open coding" in mind
> (showing a different way of implementing something, compared to the
> "status quo" that I was not yet aware of?), nor knowing what NIH is
> supposed to mean in this context.

"open coding" means to have a copy of the function of macro that is already
implemented and available (even if it's private to some driver or module,
we always can move it to the generic module and header).

NIH: Not Invented Here.

> We're in bike-shedding territory
> anyway, guess I should just bookmark the page that details all the many
> `%` format strings available.

True :-)

...
> > > I find the latter clearer as it doesn't require the reader to figure out
> > > that name - name cancels itself out.  Alternatively we can write
> > > strchrnul(name, '@')[0].
> > 
> > I don't like to have Pythonisms in the C code, really.
> > 
> > P.S. I guess this little patch already emptied my bandwidth, so I leave
> > any further discussion to you and IIO maintainers. Thank you for the
> > review!
> 
> Just soaking up kernel coding standards here :)

Right.

-- 
With Best Regards,
Andy Shevchenko


