Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84A45F2E5C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiJCJom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJCJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:44:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684F2F57;
        Mon,  3 Oct 2022 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664789987; x=1696325987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sXZaQocFXY9yjGwvBQtBsjXvYzr4OXfPV0g7Jm5zPAQ=;
  b=QnUwUvQwdhJwbNtfcUNKu7sI38OLk/HXIOhCpWgxUuCio2grX6KdcI5F
   Dx17ZFfD+jkLuMnMf5D1dcQy2cz/ctB4TJShHSjo5szLb+09aASSpnZIw
   9+OkD8v8JVyXkpj7ZDo+x+RDxnK6ajSxMyzLtsH8ClPxeqWHCARgj9ub9
   4ardnsR2dnD0Cv5j+pRKBIPTLNfhRosJHSE2N0S/46Fmm+8tZqaUIPDFe
   dmgyohKmPd04UFV3tys8e0AL1B3kv+GOn0BhW+HXuw+Vuqd01gGOdzb3s
   ueGw4sk8VSiyThU7rp0NCmCWKKLW7QSg6P7omsqmTNYODGcfnAfD6UcdI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="289754335"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="289754335"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 02:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="727691643"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="727691643"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2022 02:39:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ofHv8-001Rh9-19;
        Mon, 03 Oct 2022 12:39:30 +0300
Date:   Mon, 3 Oct 2022 12:39:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev
Subject: Re: [RFT PATCH v3 10/10] iio: Don't silently expect attribute types
Message-ID: <Yzqt0o0yWsfCGQ6I@smile.fi.intel.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
 <63f54787a684eb1232f1c5d275a09c786987fe4a.1664782676.git.mazziesaccount@gmail.com>
 <YzqgqERDTLVkJH67@smile.fi.intel.com>
 <b36ee317-abfe-9f55-70b5-bbf3138f50c0@gmail.com>
 <7ae09809-4f3c-9872-5a87-0a05e73d39b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ae09809-4f3c-9872-5a87-0a05e73d39b4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 12:02:56PM +0300, Matti Vaittinen wrote:
> On 10/3/22 11:58, Matti Vaittinen wrote:
> > On 10/3/22 11:43, Andy Shevchenko wrote:
> > > On Mon, Oct 03, 2022 at 11:13:53AM +0300, Matti Vaittinen wrote:

...

> > > > +            attr[ARRAY_SIZE(iio_buffer_attrs) + i] =
> > > > +                (struct attribute *)&id_attr->dev_attr.attr;
> > > 
> > > ...and explicit casting here. Isn't attr is already of a struct
> > > attribute?
> > 
> > I am glad you asked :)
> > This is one of the "things" I was not really happy about. Here we hide
> > the fact that our array is full of pointers to _const_ data. If we don't
> > cast the compiler points this out. Old code did the same thing but it
> > did this by just doing a memcpy for the pointers - which I personally
> > consider even worse as it gets really easy to miss this. The cast at
> > least hints there is something slightly "fishy" going on.
> > 
> > My "gut feeling" about the correct fix is we should check if some
> > attributes in the array (stored to the struct here) actually need to be
> > modified later (which I doubt). If I was keen on betting I'd bet we
> > could switch the struct definition to also contain pointers to const
> > attributes. I am afraid this would mean quite a few more changes to the
> > function signatures (changing struct attribute * to const struct
> > attribute *) here and there - and possibly also require some changes to
> > drivers. Thus I didn't even look at that option in the scope of this
> > fix. It should probably be a separate refactoring series. But yes - this
> > cast should catch attention as it did.
> > 
> 
> Actually, now that you pointed it out - do you think this would warrant a
> FIXME comment?

Makes sense to me, but I'm not a maintainer of IIO :-)

-- 
With Best Regards,
Andy Shevchenko


