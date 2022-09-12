Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643D45B5833
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiILKYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiILKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:24:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE346595;
        Mon, 12 Sep 2022 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662978278; x=1694514278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rJ+vo42kIPEeK6pN9V49hqarJLzU45CCJvpzPtmdyZY=;
  b=nnFIucTSVxD3l624SFtqd5oFOh0dACh3lLtZy0rdIym+1X/V4omPSuqs
   SxdfyO3ik88Vq3uD8iNnw1I6EX/EenhTRA32HxTvjMLZiJcvalIiTmb9W
   wIhKwMhupgwBaII8+aRnuknDEUXXYD5E5U7RSG4ZcVg755is3RvBes2/D
   DhAYchffYopqBBGLMEAbVjMECXZFoMHzrtpmW41E5s36Z98doGaN2W998
   gPvCgNyd+PgJU14MC7fSHE7W95ZYSzFxrKyR1kfiPRf2pq0NjzuP8Shbf
   50RWhx147xMi14u9GrVBryJFbLitEaunbaECOWA1e8TX3h1EmZ3eD0Gxa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="296566941"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="296566941"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:24:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="684376969"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:24:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oXgcD-001IXP-0s;
        Mon, 12 Sep 2022 13:24:33 +0300
Date:   Mon, 12 Sep 2022 13:24:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v1 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
Message-ID: <Yx8I4RGIchUT1/7y@smile.fi.intel.com>
References: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
 <20220603181006.2c5cc6c4@jic23-huawei>
 <20220620204225.34d40a3f@jic23-huawei>
 <YxdM1KUFcdVlnKuO@smile.fi.intel.com>
 <20220911105215.72bd79f3@jic23-huawei>
 <Yx8IQHLBhIilMfEw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx8IQHLBhIilMfEw@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 01:21:52PM +0300, Andy Shevchenko wrote:
> On Sun, Sep 11, 2022 at 10:52:15AM +0100, Jonathan Cameron wrote:
> > On Tue, 6 Sep 2022 16:36:20 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Jun 20, 2022 at 08:42:25PM +0100, Jonathan Cameron wrote:

...

> > > Any news on this one? Maybe I need to resend with the better commit message?
> > 
> > From glancing back at the thread, looks like you said you were going to send
> > a v2 with property.h include.  I think the rest of the thread is concerned
> > with a different issue entirely.
> 
> Ah, I only read last messages in the thread and didn't realized that I have
> some ARs to accomplish. OK, v2 will come soon, thanks!

After reading more of the thread I think this patch should be in a different
form, so no v2 soon, needs more investigations.

-- 
With Best Regards,
Andy Shevchenko


