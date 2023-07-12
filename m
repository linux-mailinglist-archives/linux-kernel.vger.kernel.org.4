Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A601750C63
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGLP0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGLP0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:26:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5DD1734;
        Wed, 12 Jul 2023 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689175565; x=1720711565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=opv4vWR11AnjxQzJ5kswyd24sS6ZcKGbyA2QSSHiKdI=;
  b=BxD3RHf/2kRNTrapLmKTo0GKT7PbhfZppDrtXuTKZ8nrQ11gw8DVXnD/
   DrgbOHiHirEIZwvi5X9w5J0wELodjRLMYZrWiAXF/qyqonNX/Atlw7GlQ
   6nLGdHBXGWknJCpi94tSHFfoAeAa7UdNrzwtIqp3lJ6lyORH+4Vo4eOOo
   jPQqGxR3Na1RB66GD/Xb1YTUsinK7m3QiEdzLy17SWgIun+gmnsjoZBVm
   TZD3WiRca4VUguwf3m89Uc04KjVCd9NwqLfM7D4BOZg2PgsJgaRgifvyM
   enEVfkmhgiWMYJoCi3eNQ7D3uOCTgNh0Dh9Mwckzppf8e5RR4EUl2X0zx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="344519100"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="344519100"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="791662575"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="791662575"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2023 08:26:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJbj6-002ADD-0r;
        Wed, 12 Jul 2023 18:26:00 +0300
Date:   Wed, 12 Jul 2023 18:26:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v5 0/6] iio: adc: meson: add iio channels to read channel
 7 mux inputs
Message-ID: <ZK7GCAgA1gljrxyl@smile.fi.intel.com>
References: <20230711200141.239025-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711200141.239025-1-gnstark@sberdevices.ru>
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

On Tue, Jul 11, 2023 at 11:00:16PM +0300, George Stark wrote:
> Changelog:

I gave you a tag, any reason why you haven't applied it to your patches?

-- 
With Best Regards,
Andy Shevchenko


