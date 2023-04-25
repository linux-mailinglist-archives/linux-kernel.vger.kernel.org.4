Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73896EE341
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjDYNkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjDYNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:40:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959B71A5;
        Tue, 25 Apr 2023 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682430013; x=1713966013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ZnMxW7FQXteRzNnv5JBtPM4OmwntBA5Vnutp7lOVns=;
  b=JAoJ9PTLlojTAt3TPpMsFd935Dx3tYkQwbiRdTIMka0q3CAgVwbahGp5
   MMbeOTpT3hzl0X0Qq18FW9Tvnszl+ELzNE7Lf7n99IQOVAWOTzAVCR3r5
   ykOry0Rzm1KA5eJZ4Wfl8IWwBdCM/IC0u8NtvcAML0TPoAxg1Hp3L24MJ
   d1ZlEgrfBX5T1diQWdLHH7SYKGU4FRqxjRfncCEUg36uTAErcSdlLcfnn
   HXxVv09hwveXRCMYNDM9RCE2Y1lx0mXuylnLdcikqy8xZKE3YbJMsgNyO
   QbFn+CKNVZa/4M4HDLMXnVV8Hfs0wu3CxRQDBLqbZyAOQWQw+HmonNXqe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="433027300"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="433027300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 06:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="805074658"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="805074658"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 25 Apr 2023 06:40:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1prIts-004zyA-1h;
        Tue, 25 Apr 2023 16:40:08 +0300
Date:   Tue, 25 Apr 2023 16:40:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id
 table
Message-ID: <ZEfYOO9TQSbEyCu2@smile.fi.intel.com>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <a232fe7a8104f8d1cddfc5950aa48748ea90bffa.1682373451.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a232fe7a8104f8d1cddfc5950aa48748ea90bffa.1682373451.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 12:22:24AM +0200, Mehdi Djait wrote:
> Add the missing i2c device id 

Seems like unfinished commit message (also note missing period, that's why
I paid attention to this).

...

> +static const struct i2c_device_id kx022a_i2c_id[] = {
> +	{ .name = "kx022a", 0 },

', 0' is redundant.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);

-- 
With Best Regards,
Andy Shevchenko


