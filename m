Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455B4713916
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 12:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjE1Kz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 06:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1Kz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 06:55:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2484BA4;
        Sun, 28 May 2023 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685271327; x=1716807327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7eBapmwuatu6STYCyR03YSp8av2m5gocW5nmyIw8UN4=;
  b=MkLAA19tQguLWfm3OL8TULjst3lFcrhC1I/gIw96fHtx7iaacpvLrWMM
   4KMwJYtq3d33+Aewzkzak3xSnOgZu2j0p9HkBQ8D2liZgxCbn0eJAiSLk
   TeXFrBTo34ZnOSBUX/1MCWwVz9utqKqdzHq15Xz4MRtvPcVJbHg0SD+d2
   dUuLXeQKGi7v/B1VU53GZ/PUroYU33GrENPfjgUzXxNdtqXyMP1z3U5lY
   ZgsoPE1pLfE7T00ckHpYB/Jzkc6r6iKf9lWCV7YMtRlOdWTPbKUUMO/78
   7G+Gm4KnuVv9ktWU3L+esL+gUKC9NO+h3RrNKDp4flbKZjddY+Wst1Aa0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="334128150"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="334128150"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 03:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="656162961"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="656162961"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2023 03:55:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q3E3U-000Jjw-1S;
        Sun, 28 May 2023 13:55:20 +0300
Date:   Sun, 28 May 2023 13:55:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v2] meson saradc: add iio device attrib to switch channel
 7 mux
Message-ID: <ZHMzGHsGEylDdgg7@smile.fi.intel.com>
References: <20230527214854.126517-1-gnstark@sberdevices.ru>
 <ZHMxDHPBWQOJSuaZ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHMxDHPBWQOJSuaZ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 01:46:37PM +0300, Andy Shevchenko wrote:
> On Sun, May 28, 2023 at 12:48:54AM +0300, George Stark wrote:

...

> > +static const char * const chan7_vol[] = {
> > +	"gnd",
> > +	"vdd/4",
> > +	"vdd/2",
> > +	"vdd*3/4",
> > +	"vdd",
> > +	"ch7_input",
> > +};

One more thing to discuss (Jonathan, what's your opinion?) I think the
following easier to understand and has less problematic characters in the names
(in case of sysfs direct use from shelll):

static const char * const chan7_vol[] = {
	"gnd", // alternatively GND
	"0.25vdd", // alternatively 0.25_vdd, 0.25Vdd, 0.25_Vdd
	"0.5vdd",
	"0.75vdd",
	"vdd", // Vdd
	"ch7_input",
};

That said, my personal preference:

static const char * const chan7_vol[] = {
	"GND",
	"0.25Vdd",
	"0.5Vdd",
	"0.75Vdd",
	"Vdd",
	"ch7_input",
};

-- 
With Best Regards,
Andy Shevchenko


