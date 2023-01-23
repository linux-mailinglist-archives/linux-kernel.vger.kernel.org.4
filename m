Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D48677A73
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjAWMDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAWMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:02:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ED555AA;
        Mon, 23 Jan 2023 04:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674475377; x=1706011377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gac31zA3L0a5rQtCHU57yyl10/98WWoOzbC9C/m7naQ=;
  b=KQhYLwm6Zds+Oykz0S4bi/POjHpPpGojBiuYP8td/cJOOQyeF2SNeQfb
   8uWHCQMMoK5sQ+AldXy8/d1gN8Cl5yYUEuEo/C0EuRciMivV1ym2ICXKb
   Gsqn1eDnIz0UGykfAa6eJYfeUAnL0tVXbiegRXplx46dRE/nlvsPIoABc
   Fg1/sBPO6BHW61xeGYPxAR+6i36pnNKOMeGLCcrAtdZrlWDnWF4h2qjQg
   jpF76wcHKeU6aJINaH6qLte5ieZiKtV74vaZBNFBSJnjmtgPsky2IGcT6
   KAm84OA3u/QV2XE2tL1gmS55mB05qVJDKvFq0Z2Eh/UPvBJPFF8NGEPIR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="305683345"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="305683345"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 04:02:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="663532353"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="663532353"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jan 2023 04:02:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pJvXI-00Diqy-0V;
        Mon, 23 Jan 2023 14:02:52 +0200
Date:   Mon, 23 Jan 2023 14:02:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <Y853a5jr4rfrDHfd@smile.fi.intel.com>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
 <20230122172441.4f8d75f5@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230122172441.4f8d75f5@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 05:24:41PM +0000, Jonathan Cameron wrote:
> On Wed, 18 Jan 2023 12:06:23 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The node name can contain an address part which is unused
> > by the driver. Moreover, this string is propagated into
> > the userspace label, sysfs filenames *and breaking ABI*.
> > 
> > Cut the address part out before assigning the channel name.
> > 
> > Fixes: 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
> > Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> LGTM, but given it will have ABI impact, I'd like to hear from 
> Andy, Bjorn or Konrad as maintainers and /or Dmitry as someone
> who has touched this driver fairly recently.

Hmm... But this is to fix the ABI breakage. It means that the previous series
by Nuno had broken it.

> Mostly I want to be sure they know this exists before it causes surprise.

-- 
With Best Regards,
Andy Shevchenko


