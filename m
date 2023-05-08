Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1E16FB05E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjEHMlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjEHMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:41:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191003AA3E;
        Mon,  8 May 2023 05:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683549670; x=1715085670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dWB1W1sKr0VoI4S3t1V+MlpJWf/wmSsuyC8DruCjijI=;
  b=YE+elcsyqdEy9PARp1RBVwNLmDU+iqz334PrXv5oVqEVdLMKfBwKzMPI
   bzqsThzqgjmpvuOMB++PcofLpG3l6WhXEjVVRSvrtjIh63ME3NSFYIlVc
   3ohyGwVgMx5iXBAD9xVc/4joBPR/YwNQIhRF6dbim6b0YiejyRthx1XqD
   ufpWRr/54kRAPuaqezIdeFzaUjzHYlnvXnylVGSD0I/6Ge1KRCgXoLbcr
   6Ml/iaUyS82YTa6QbmF4OdmSiJ9AAiVMwG1mElfXP3sM1zkaDNljVGiNU
   TJBcvFEoC69a82RnJyBHYaWFqq6b7e3OpU1Dv0oNUNXFhNEDPdqPaXNl8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="334071111"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="334071111"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 05:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="810253989"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="810253989"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2023 05:41:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pw0Ap-00ArPN-2M;
        Mon, 08 May 2023 15:41:03 +0300
Date:   Mon, 8 May 2023 15:41:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v3 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <ZFjt33rdupWOAsc8@smile.fi.intel.com>
References: <cover.1682495921.git.mazziesaccount@gmail.com>
 <fb35de40a3908988f5f83e25d17119e6944d289b.1682495921.git.mazziesaccount@gmail.com>
 <ZFF1NMaR1RYThcSB@smile.fi.intel.com>
 <307cc8ce-6178-7a86-2c90-eaf0ac8c122d@fi.rohmeurope.com>
 <20230507152443.754f2fab@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507152443.754f2fab@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2023 at 03:24:43PM +0100, Jonathan Cameron wrote:
> On Wed, 3 May 2023 05:11:53 +0000
> "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> > On 5/2/23 23:40, Andy Shevchenko wrote:
> > > On Wed, Apr 26, 2023 at 11:08:17AM +0300, Matti Vaittinen wrote:  

...

> > >> +enum {
> > >> +	BU27008_RED,	/* Always data0 */
> > >> +	BU27008_GREEN,	/* Always data1 */
> > >> +	BU27008_BLUE,	/* data2, configurable (blue / clear) */
> > >> +	BU27008_CLEAR,	/* data2 or data3 */
> > >> +	BU27008_IR,	/* data3 */
> > >> +	BU27008_NUM_CHANS  
> > > 
> > > Why not converting comments to a kernel-doc?
> > >   
> > >> +};
> > >> +
> > >> +enum {
> > >> +	BU27008_DATA0, /* Always RED */
> > >> +	BU27008_DATA1, /* Always GREEN */
> > >> +	BU27008_DATA2, /* Blue or Clear */
> > >> +	BU27008_DATA3, /* IR or Clear */
> > >> +	BU27008_NUM_HW_CHANS
> > >> +};  
> > > 
> > > Ditto.  
> > 
> > I see no value having entities which are not intended to be used outside 
> > this file documented in any "global" documentation. One who is ever 
> > going to use these or wonder what these are - will most likely be 
> > watching this file. My personal view is that the generated docs should 
> > be kept lean. In my opinion the problem of the day is the time we spend 
> > looking for a needle hidden in a haystack. In my opinion adding this to 
> > kernel-doc just adds hay :)
> 
> > 
> > I still can do this if no-one else objects. I almost never look at the 
> > generated docs myself. Usually I just look the docs from code files - 
> > and kernel-doc format is not any worse for me to read. Still, I can 
> > imagine including this type of stuff to generic doc just bloats them and 
> > my not serve well those who use them.
> 
> 
> Unless someone specifically adds this doc to the main docs build, the
> kernel-doc won't end up in the docs anyway. It just provides a nice
> bit of consistent formatting. Even if they do add this for some reason,
> there are controls on internal vs external (exported stuff) being added
> to the docs.

I can run it manually and see in a nice form instead of browsing file for that,
so there is still a usefulness in my opinion. Esp. taking into account that
comments are already there. It's just different and helpful form of
representation. No?


-- 
With Best Regards,
Andy Shevchenko


