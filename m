Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754F263881B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKYLBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiKYLBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:01:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C674A9D9;
        Fri, 25 Nov 2022 03:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669374094; x=1700910094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=omfNsrNIaeP/xU1KSWpTZU7Q1phlc5HugKhhDzBoTfI=;
  b=QNAhmi5i6hg1u4rMCQLB5Ptd1j+RfQMeAyZNTIn6IJYQ+i+Kw+rLGHsj
   inLLFC7iJJGp0iNBhfUMjjCqVNUvFMT4jtRXsWVnepOG0VEzXoiamY5ad
   xs4YSH7+ks3n1YvcCSvvsOmhee1S+PtQL5ZbCbaERpzE+UXRDuA4v7oSW
   BvoNFDFENqgNrV8mzteVMKZ+3daA382nrcQ1KAx5BLCCPxB21gWBGBiYy
   H7dMyuz69x2J85H93UQt4cWUTcFey+JvXkOXNJkgh/aW1cuepLSMK8b9V
   a13aC5bpo00qNxiHCOF/xLttGxqV0/pIEMcwXt2aaO4OEwJSsvCf77jax
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="378718283"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="378718283"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 03:01:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="767338871"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="767338871"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2022 03:01:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyWSW-00HCL9-2u;
        Fri, 25 Nov 2022 13:01:28 +0200
Date:   Fri, 25 Nov 2022 13:01:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v3 1/3] iio: add struct declarations for iio types
Message-ID: <Y4CgiMd4XQMV4KFV@smile.fi.intel.com>
References: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
 <20221125083526.2422900-2-gerald.loacker@wolfvision.net>
 <Y4CcspD1xkmhmWbh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4CcspD1xkmhmWbh@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 12:45:06PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 25, 2022 at 09:35:24AM +0100, Gerald Loacker wrote:

...

> > +struct iio_val_int_plus_micro {
> > +	int val_int;
> > +	int val_micro;
> > +};

Thinking more about naming, why not drop val_ completely?

	int integer;
	int micro;

?

> > +struct iio_val_int_plus_nano {
> > +	int val_int;
> > +	int val_nano;
> > +};
> > +
> > +struct iio_val_int_plus_micro_db {
> > +	int val_int;
> 
> 	int val_int_db; ?
> 
> > +	int val_micro_db;
> > +};
> 
> Actually why can't we simply do
> 
> typedef iio_val_int_plus_micro_db iio_val_int_plus_micro;
> 
> ?

-- 
With Best Regards,
Andy Shevchenko


