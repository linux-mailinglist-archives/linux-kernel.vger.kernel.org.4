Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB4B73864D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjFUOJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjFUOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:09:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50E21989;
        Wed, 21 Jun 2023 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687356539; x=1718892539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rPx+5YqJGhmcle9gXLDQG0ptIvu0NgL4FLwZd8hjZ50=;
  b=VH2Bi6mnG775MSV7eblQ/NauPQTwgriK4z2evZ199plaliH8tbjhx4Ba
   d5jsZqNvbyH1QGh51uhg0b7T/OwO0vLWNaYjDzQ/RL1b1fU+6yFLqJqHT
   8L6+PQALg75sDNz6T71ZjEYj2zi+VGQFU9Ig6CHN4D+ib9G21R0WaCFpJ
   ogBacIf9vqnscgNZTqXu1ssTdmtGk1ZlhZ/zOO0C7tCd0EVs68lyZ749C
   v86i19qLEALQIe09peThZDqnvI14hxCYzjAJqYP2KKNyUPoD8EWUQbA+d
   ZnOsGV0krv103PMGKihzADqOjt4LvsXA/w97P6OB4Ta/vvUPe35zsfJzA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360196828"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="360196828"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:08:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="961207162"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="961207162"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2023 07:08:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qByVp-005VwL-2X;
        Wed, 21 Jun 2023 17:08:45 +0300
Date:   Wed, 21 Jun 2023 17:08:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v1 1/3] meson saradc: code refactoring
Message-ID: <ZJMEbbVaUoxSay5i@smile.fi.intel.com>
References: <20230621062715.455652-1-gnstark@sberdevices.ru>
 <20230621062715.455652-2-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621062715.455652-2-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:26:08AM +0300, George Stark wrote:
> - remove channel array double definition
> - add channel index enum
> - move enums declaration before variables declaration
> - move meson_sar_adc_set_chan7_mux routine upper

4 patches then?

...

> +	// last item is temp channel

Is C++ comment style is used in the entire file?

-- 
With Best Regards,
Andy Shevchenko


