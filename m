Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A984D738671
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjFUOLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjFUOLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:11:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B932122;
        Wed, 21 Jun 2023 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687356646; x=1718892646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ouC2uUhcHNQmb+8A8CRknY0+a4vXftp/tDcG/6xIf3k=;
  b=cqouId86rn07+PZad4CF7TXoV9I0PrINz+6v1D3N9dgZbLNAN6MTaqmN
   yvIR8a08ZW/rnGhw+YMjvOqLejUyKfCFymtAQq/d4ZwqRERdwH19LDT4f
   uv//9Qyd7T3jg538txcr5uYD2eqRDNjWPNSlb4E0H4X2pb6/Rp9acdViF
   /lC23SRMaN5hMWk0KkX0dm4Y225U2AUviR3h3F3YI2VJTq9ajbs6yzKoX
   bGE2fTOuL5aBjhRdk9swr2YF3JdYa5FgNDsgfoLMjANXXnlfb/yjkgagT
   IHWkvCCnZZvLMS3ZQ0lRKwN7e0Nr14bfpDhq/qwy0oT5STfZyQtRPHpNg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="389693891"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="389693891"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="691868682"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="691868682"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 21 Jun 2023 07:10:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qByXf-005Vxe-2e;
        Wed, 21 Jun 2023 17:10:39 +0300
Date:   Wed, 21 Jun 2023 17:10:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v1 0/3] meson saradc: add iio channels to read channel 7
 mux inputs
Message-ID: <ZJME39cOHsKkJu2Y@smile.fi.intel.com>
References: <20230621062715.455652-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621062715.455652-1-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:26:07AM +0300, George Stark wrote:
> From: George Stark <GNStark@sberdevices.ru>
> 
> In meson saradc channel7 is connected to muxer which allows to measure
> inner sources like Vdd, GND, several Vdd dividers. This patch series
> adds independent iio channel (with label) for every chan7 mux input.
> Mux switch is handled transparent for clients.
> This functionality can help debug\test\calibrate adc.
> This code is relevant for all supported amlogic soc families

Code wise looks good to me, some remarks about commit messages and comments.

> This patch series was created after discussion [1], [2]
> 
> [1] https://lore.kernel.org/lkml/20230524000111.14370-1-gnstark@sberdevices.ru/
> [2] https://lore.kernel.org/lkml/20230527214854.126517-1-gnstark@sberdevices.ru/

-- 
With Best Regards,
Andy Shevchenko


