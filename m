Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D9263AA71
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiK1OG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiK1OGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:06:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406C2124F;
        Mon, 28 Nov 2022 06:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669644369; x=1701180369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kK1XSdb8aoZkJ8xeQsAIDo4KCW0OUls0hSDk9JxDYEU=;
  b=gO1dsKvX0Xc/OEnGUxrN8sB5/1HDwKzgj/2JF3OCdd0Ys5fkb8hAS0Fw
   uQc2Edl1y8p+YAp+69tAjzI+nJkn7FcRsXWe//UzxJqvxGu2wPQnjtsNQ
   /e+jqBvvIdEU++oBoqh8BlxjE2/72RgW8El4gA6dLZaP7ATpI2s7Crtd9
   h3mr4FDC/8IN+i6oRUjXd1oKrfRCFBOlvMhq6LWBfJq3JU2GQkt8Y4vqv
   /eTZNtdFr2esZNuYIZqgsVv02TivlWhLcAGseajOQ3Eq8ayGTrxF8VchA
   rB7imVtmZhtYK2cIyJf96uyMfBYZCmlpjDtrmIuRFUpWja0GXzGUP3DqV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="379096714"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="379096714"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 06:05:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="785640121"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="785640121"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2022 06:05:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozekx-001AIf-1z;
        Mon, 28 Nov 2022 16:05:11 +0200
Date:   Mon, 28 Nov 2022 16:05:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH v3 1/3] iio: add struct declarations for iio types
Message-ID: <Y4TAF1hn0l1CziUh@smile.fi.intel.com>
References: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
 <20221125083526.2422900-2-gerald.loacker@wolfvision.net>
 <Y4CcspD1xkmhmWbh@smile.fi.intel.com>
 <Y4CgiMd4XQMV4KFV@smile.fi.intel.com>
 <a55e73f7-4daf-6892-34dc-61c6f6581d8e@wolfvision.net>
 <Y4S3WnYWVnmiVFc+@smile.fi.intel.com>
 <4d1b0054-efd4-e10e-17a6-d236052afa49@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d1b0054-efd4-e10e-17a6-d236052afa49@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:48:48PM +0100, Michael Riesch wrote:
> On 11/28/22 14:27, Andy Shevchenko wrote:
> > On Mon, Nov 28, 2022 at 01:18:04PM +0100, Gerald Loacker wrote:
> >> Am 25.11.2022 um 12:01 schrieb Andy Shevchenko:

...

> > It's a rule to use _t for typedef:s in the kernel. That's why
> > I suggested to leave struct definition and only typedef the same structures
> > (existing) to new names (if needed).
> 
> Andy, excuse our ignorance but we are not sure how this typedef approach
> is supposed to look like...
> 
> >> or
> > 
> >> 	typedef iio_val_int_plus_micro iio_val_int_plus_micro_db;
> 
> ... because
> 
> #include <stdio.h>
> 
> struct iio_val_int_plus_micro {
> 	int integer;
> 	int micro;
> };
> 
> typedef iio_val_int_plus_micro iio_val_int_plus_micro_db;
> 
> int main()
> {
>   struct iio_val_int_plus_micro a = { .integer = 100, .micro = 10, };
>   struct iio_val_int_plus_micro_db b = { .integer = 20, .micro = 10, };
>   return 0;
> }
> 
> won't compile.

I see. Thanks for pointing this out.

Then the question is why do we need the two same structures with different
names?

-- 
With Best Regards,
Andy Shevchenko


