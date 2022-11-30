Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D363D3D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiK3KzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiK3KzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:55:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C44D18B32;
        Wed, 30 Nov 2022 02:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669805707; x=1701341707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IQCNlMQYsfuqqjPfnZdd0e9JtFAPXzKRS8AZMTuMtNs=;
  b=E9no2U4fDClP2IIupphBodWe1/S5m091axjrdcjCGEMwD0x8dPaHbSlP
   yjahWjqjrDNC5V1z7eNh5c0kaJQ/jgpWeFfljkvOx6jz6rjw9TacwLsHu
   q3gLRn+vfG8Ep9ftzAdNMPLV0I5gvfKrTrtXvlSXKAn3KbasqM4KOW7lb
   ecAkK7ZAe6acOGz0u32D+rF9gFTZ5FgfHm2nTUs1JNijrKZrp5vCrmI4/
   nBfkyus22+RaIbPCI3kBaClsGcJKQs/bQKzqZpfqOeQXFToE25PTkAoiT
   m5bBGSZKURD7YQn4cGXURU8PPm496W0522/dMQaT2U5wn9H/yaC/WysHw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342286081"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="342286081"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 02:55:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="786421323"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="786421323"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 30 Nov 2022 02:55:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0Kk2-002Dpc-0W;
        Wed, 30 Nov 2022 12:55:02 +0200
Date:   Wed, 30 Nov 2022 12:55:01 +0200
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
Subject: Re: [PATCH v4 3/3] iio: magnetometer: add ti tmag5273 driver
Message-ID: <Y4c2hWw6kywpChb3@smile.fi.intel.com>
References: <20221129064540.3218982-1-gerald.loacker@wolfvision.net>
 <20221129064540.3218982-4-gerald.loacker@wolfvision.net>
 <Y4Y1VqvYS0XsWi1r@smile.fi.intel.com>
 <b2d8b5a6-15a6-9cca-9f87-fbbe1acfa4f3@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d8b5a6-15a6-9cca-9f87-fbbe1acfa4f3@wolfvision.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 10:04:41AM +0100, Gerald Loacker wrote:
> Am 29.11.2022 um 17:37 schrieb Andy Shevchenko:
> > On Tue, Nov 29, 2022 at 07:45:40AM +0100, Gerald Loacker wrote:

...

> >> +		snprintf(data->name, sizeof(data->name), "tmag5273x%1u", data->version);
> > 
> > Thinking more about this format, perhaps
> > 
> > 		snprintf(data->name, sizeof(data->name), "tmag5273x-v%1u", data->version);
> > 
> > ?
> 
> I'd prefer to keep this as it's related to the orderable part number,
> e.g. TMAG5273A1 / TMAG5273A2.

I see, can you add a comment above to clarify the chosen format?

-- 
With Best Regards,
Andy Shevchenko


