Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601836EBA34
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 18:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDVQJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 12:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDVQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 12:09:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A17211E;
        Sat, 22 Apr 2023 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682179758; x=1713715758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UxZNNg2iR21QuxXZOviYjeKG5ki4ex9gVhzKOBg6N/A=;
  b=RgXpeKe73eWRpqI/xu8WbUY5J5zvkrn+/cFX+14ijyD0SEw28TBi7CTU
   m3aQVpQimiAWBQxR/s/R6/8EDQaIYQbkYL5ztJAS1kTvIpaeBcnZBQW3/
   w5IP5MPz3jIA+Wh6GBpAyoiOkuHZrLgEFDF2dNM92TVVhoglSuUI+Wb9e
   CB/oxAmwaHjXxj/MMhFEt4Dmvo35BKMKzZxRvI924O7t9cr8i0KfgGGGi
   /8bgtAT2qCDFFLBTyRR9L74XrzseRbbJHFrEqzCwdyl5PRIdWxrcjxIWa
   JNAAu98NCDzEufBgYYls6OCgm95GeJ79cNg0cY7cOogF964EeddTI2e7q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="325771755"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="325771755"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 09:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="692580814"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="692580814"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 22 Apr 2023 09:09:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pqFnU-003fcv-2G;
        Sat, 22 Apr 2023 19:09:12 +0300
Date:   Sat, 22 Apr 2023 19:09:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org,
        mazziesaccount@gmail.com, oe-kbuild-all@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <ZEQGqFLIyxm5XENQ@smile.fi.intel.com>
References: <cef09595632a40eff8a0864fea2e0eb6653930a5.1682019544.git.mehdi.djait.k@gmail.com>
 <202304220729.FCofPRvH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304220729.FCofPRvH-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 07:19:44AM +0800, kernel test robot wrote:
> Hi Mehdi,
> 
> kernel test robot noticed the following build warnings:

I believe it's not just a warning, it's a full functional error in the code.

>    686	{
>    687		struct device *dev = regmap_get_device(data->regmap);
>    688		__le16 buf_status;
>    689		int ret, fifo_bytes;
>    690	
>    691		ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
>    692				       &buf_status, sizeof(buf_status));
>    693		if (ret) {
>    694			dev_err(dev, "Error reading buffer status\n");
>    695			return ret;
>    696		}
>    697	
>  > 698		buf_status &= data->chip_info->buf_smp_lvl_mask;
>    699		fifo_bytes = le16_to_cpu(buf_status);

You need to mask in the same endianess space, i.o.w. either on CPU or device side.

I believe you wanted to have fifo_bytes to be masked, but I'm not sure.

>    701		return fifo_bytes;
>    702	}

-- 
With Best Regards,
Andy Shevchenko


