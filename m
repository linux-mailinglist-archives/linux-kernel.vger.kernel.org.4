Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49E974D19F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjGJJeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjGJJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:33:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE86810D1;
        Mon, 10 Jul 2023 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688981544; x=1720517544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ToE9U1OfjykExkygbmbaQkioLW5ROLoBvtmYdNCPghI=;
  b=Fj97Oyj0WiIDngfw6seQoZDVDmtkS4lY1KxACkjCVypmi+BE4jC3R85/
   OjdYsPfpbow+3PQ/WM66+Egnz/OQx/dhFNBAFRezGxxWJ+nKbPrFcSDPP
   ZZTODO5DDaWaLcuuSypYIbKFczx19Dua09QGVPvsQJNZWa+NcGUeEcmWW
   f2Qce27RNb3uRnwfdbRQ2rgjyx5cD6wvMg6VBqKUM8CeD+h8UWOmlXqeO
   q/G6NR93MVQrlBkgZ82oXUVeACaB0ZTQLxo6hVXFssjealDMlmkySKjK9
   W5ZkJhPca8kyWU7YEHZFU/HWPTQXMWk8TZDUhTrRya8Jju0D026Of9oKl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="395079690"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="395079690"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="755937676"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="755937676"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2023 02:32:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qInFi-001VwO-08;
        Mon, 10 Jul 2023 12:32:18 +0300
Date:   Mon, 10 Jul 2023 12:32:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v4 6/6] iio: adc: meson: support reading from channel 7
 mux inputs
Message-ID: <ZKvQIWCc3vMoA80N@smile.fi.intel.com>
References: <20230707153322.114302-1-gnstark@sberdevices.ru>
 <20230707153322.114302-7-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707153322.114302-7-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 06:27:43PM +0300, George Stark wrote:
> Add iio channel for every channel 7 mux input.

IIO

"...for each muxed input of the channel 7."

> Meson saradc channel 7 is connected to a mux that can switch channel
> input to well-known sources like Vdd, GND and several Vdd dividers.

Make this sentence to be the first in the commit message.

"can switch input" (again, avoid tautology).

-- 
With Best Regards,
Andy Shevchenko


