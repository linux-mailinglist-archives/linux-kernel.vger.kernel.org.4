Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06086B7688
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjCMLsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCMLso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:48:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BF51A64E;
        Mon, 13 Mar 2023 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678708092; x=1710244092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PraY/NBSpSOEe3yeG3aJePM/Xx+W2T8DfCL/4PKtSek=;
  b=j1x7GhxyaO434W514LFPQh1+z38QqoIyCHA7kwMxh8P2hOjC55PE3GvN
   UCjdFDw/2qeFvunbr6I2LwZuKHbXXO+YivA49s5R9IU+1r+/aBWJxZEzx
   IVeNhqvR5gdBGQqgeufBMsZj4e3Wgk4aEubExwlwBrNtzkWoK/6+tvSN0
   CiP/539nZG7yzD7d7YmgFlyD0pKXb9SE2JJ98regsrttNYEbQnnhzl6i2
   yuEmzlLfkogdmD5sMhudTcdHCMQWNCfBAjINZu1au7UKPXZVaajYvgqUX
   OFogzUIkfdOfOD5xBYgk2rwv2jULisW15NRSzG5J02qjCU3oXZ9/qv3BU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="337146472"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="337146472"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 04:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="655949945"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="655949945"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2023 04:45:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pbgcO-002bZ4-1Q;
        Mon, 13 Mar 2023 13:45:32 +0200
Date:   Mon, 13 Mar 2023 13:45:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: Tree for Mar 10 (drivers/spi/spi-mpc512x-psc.c:)
Message-ID: <ZA8M3NZbMxi80z7O@smile.fi.intel.com>
References: <20230310124850.245ba584@canb.auug.org.au>
 <ed382974-1613-8a60-913c-60cfc27f8ab3@infradead.org>
 <20230312105006.6c46df35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312105006.6c46df35@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 10:50:06AM +1100, Stephen Rothwell wrote:
> On Sat, 11 Mar 2023 15:36:10 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 3/9/23 17:48, Stephen Rothwell wrote:

...

> > drivers/spi/spi-mpc512x-psc.c: In function 'mpc512x_psc_spi_of_probe':
> > drivers/spi/spi-mpc512x-psc.c:518:17: error: label 'free_ipg_clock' used but not defined
> >   518 |                 goto free_ipg_clock;
> >       |                 ^~~~
> > 
> > 
> > on allmodconfig.
> 
> Caused by commit
> 
>   9e21720a4958 ("spi: mpc5xxx-psc: use devm_clk_get_enabled() for core clock")
> 
> from the spi tree.

It's fixed already in the SPI tree.

-- 
With Best Regards,
Andy Shevchenko


