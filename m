Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22EC74D19D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjGJJeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjGJJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:33:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB64273A;
        Mon, 10 Jul 2023 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688981532; x=1720517532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y0chWFAK1q4a4KdS5bU1/aspWN7zc+1TNroqjrdVK0M=;
  b=RmNRX9BzWpHNif231Nb5klenDkK5rTaNGPMtLC0j5XiBiF/F4xgTWj4g
   7MzpCWRmBBgJTmwvhSZ+rsWCXkjL6Tol2a0bnfpEoXb9GBftGtL5gP5mU
   OJaneBdkqz0cligVAIyqxVzCsuO8x9azwc3VdGoWYO9NvaIvkuSunPVBP
   oGgazAlRIhn2OuRUnvzF6VN/peVlNzpBhlfmnfMw2XoTcQtY82ZWh3mYI
   fGC58dTgQfuTZPY6Gsr2f/8z86RxsmvA4FgqYVrPIYaauceiAw7CpHhcI
   iYjWsDTt/HW0piPs0+27e1Ja2hJDM1tJippjQeXp4LdPx6GQEnS8NVu4o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="427990976"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="427990976"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="810751721"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="810751721"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2023 02:29:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qInDG-001Vug-2G;
        Mon, 10 Jul 2023 12:29:46 +0300
Date:   Mon, 10 Jul 2023 12:29:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v4 5/6] iio: adc: meson: add channel labels
Message-ID: <ZKvPihNXVWHTuYxS@smile.fi.intel.com>
References: <20230707153322.114302-1-gnstark@sberdevices.ru>
 <20230707153322.114302-6-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707153322.114302-6-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 06:27:42PM +0300, George Stark wrote:
> Add channel labels to provide human-readable names for the channles.

Either drop first "channel" or "for the channels" to avoid tautology.

-- 
With Best Regards,
Andy Shevchenko


