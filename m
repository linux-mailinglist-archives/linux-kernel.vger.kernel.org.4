Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74926AC0A9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjCFNUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCFNUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:20:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C13298E1;
        Mon,  6 Mar 2023 05:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678108798; x=1709644798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GjtSoBQA3iwBRLGPkqN10GTpyI29W8kD8ysILMji5Ig=;
  b=XS3qH+Y+0L1de6z+UUH3pPHVXI5oaUZ2Chb+PzFlRNN8UrW7hdGF8CLa
   ix1U3seMQWpw3UW5pmnKnhCJYeosmntxrQieeCGuXMvqNEHCLpx+hFizx
   Wja4WpoUd/B2SUkM8GoAH1yI6UM0wYY2GBzQHOAUsIoSrDN8obAHX2yoj
   nYjR3jQQ20+i8mBD2bOg8UdhfnWl3NJ6JyNhR/qH/+AapKMUmi1cXIMQL
   uYF0j1tS3ft+HHkrS1A7rJ86p/5QMY7TiTYHrF3aT9M2G/L+FjGJcpwAr
   VIm4fSXr3FKe/EDsaAZQJuaAB7fMNlyZHMcbE+MWa4xJLfmreXWHuhEtG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="334263949"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="334263949"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 05:19:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="786228977"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="786228977"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2023 05:19:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZAkq-00GRBv-3C;
        Mon, 06 Mar 2023 15:19:52 +0200
Date:   Mon, 6 Mar 2023 15:19:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <ZAXoeCHcrFdf3rC/@smile.fi.intel.com>
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
 <20230228063151.17598-2-mike.looijmans@topic.nl>
 <20230304175751.2daae308@jic23-huawei>
 <ZAXYhIETzMa/7G6N@smile.fi.intel.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.be34025c-a863-4735-b566-67fda50f37f8@emailsignatures365.codetwo.com>
 <abe9224f-9c4d-f8f5-ad7c-5d034bd1056d@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abe9224f-9c4d-f8f5-ad7c-5d034bd1056d@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 01:56:15PM +0100, Mike Looijmans wrote:
> On 06-03-2023 13:11, Andy Shevchenko wrote:
> > On Sat, Mar 04, 2023 at 05:57:51PM +0000, Jonathan Cameron wrote:
> > > On Tue, 28 Feb 2023 07:31:51 +0100
> > > Mike Looijmans <mike.looijmans@topic.nl> wrote:

...

> So I propose this code:
> 
>     if (gain <= 0 || gain > 8)

Maybe BIT(0) and BIT(3) will be more explicit.
Otherwise I'm fine with it.

>         return -EINVAL;
> 
>     regval = ffs(gain) - 1;
>     ads1100_set_config_bits(data, ADS1100_PGA_MASK, regval);

-- 
With Best Regards,
Andy Shevchenko


