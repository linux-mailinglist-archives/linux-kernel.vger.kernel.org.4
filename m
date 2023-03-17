Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B66BE8CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCQMHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjCQMHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:07:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3A46A2F1;
        Fri, 17 Mar 2023 05:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679054820; x=1710590820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lB7z9JTEaPfgVe/3yaQB+3xyKnwK8qEpyWv6LLW5lHk=;
  b=deiWSrWeElKunYrY2shzuf04AoUlhPk6rzWJk2CCJBRYLH/GYQOus2cS
   TpQdwSbzkjQqNMtk0xZS+3/uyvpX0yUFe+orf+AoNBC/ZK2MssMHDDMzm
   N+XNaWKTo8NXn0gZfqaIEqptV6cL0wXgwCbFYVEXjaBaujxv8Lxhd+bj1
   REVBJJCb/5eBWkpEjzHxh3dAlyq2fcX69BCqtEioGDZNbcBTA9hCgRGqi
   4UtfhidzQXu5Bt59X+ZE+XvyweTHaHTjtG6Ch2TitXXhKKsftRSVh4b+3
   lJztjlS3EPJXZ3X89hhnHVfsfZ/JKxBo1iSw5G0v9BUfdHxeb8KIzB/1W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424517196"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="424517196"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 05:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="673533085"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="673533085"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2023 05:06:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pd8r1-0050lS-2z;
        Fri, 17 Mar 2023 14:06:39 +0200
Date:   Fri, 17 Mar 2023 14:06:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
Message-ID: <ZBRXzymSWZaRDyhq@smile.fi.intel.com>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 12:48:36AM +0100, Mehdi Djait wrote:
> Refactor the kx022a driver implementation to make it more
> generic and extensible.
> Add the chip_info structure will to the driver's private
> data to hold all the device specific infos.
> Move the enum, struct and constants definitions to the header
> file.

Please, compile and test before sending.

...

>  	.driver = {
> -		.name   = "kx022a-spi",
> +		.name	= "kx022a-spi",
>  		.of_match_table = kx022a_of_match,
>  	},

What was changed here?

...

> -	.id_table = kx022a_id,
> +	.id_table = kx022a_spi_id,

Why do we need this change?

...

> -	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-kx022a",
> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-accel",
>  			      dev_name(data->dev));

Shouldn't you use the name from chip info?

...

> +#define KX_MASK_BRES16			    BIT(6)
> +
> +

One blank line is enough.

>  #define KX022A_REG_WHO		0x0f
>  #define KX022A_ID		0xc8

-- 
With Best Regards,
Andy Shevchenko


