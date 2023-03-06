Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB28F6ABE11
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCFLV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCFLVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:21:50 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3D423DB7;
        Mon,  6 Mar 2023 03:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678101709; x=1709637709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uJGZkkOZUOLtV4OMGL6xsHq8XhYEfQ1vxoKiyq5x9V0=;
  b=Uh9N28ayLBwWqdzsjFdbEUJwNQme3AtA/UtBv5/dsxgpqRcYUwQILrvr
   Uv1kVrBLWjo1Aux8aMTmxIhCsXfdx2jAO/dzHkiem5dgP4Ux/FKE1f7pW
   2v24DNzRvtds2DKFvy17lagfO9sjsr0cVoetugfunzBgMiCx138wjAYxp
   JLa9Wu4ED35qke91TjFBs0GANpp3Gdn2lTlQ23a809+/9Eaju7AR2uaow
   VAVGcx7jt7I4mopLR6Ip2t6RkFOVTDzce4dkZHqNZsoToV3d/evo42iY5
   pFDkCfS8x837vRICIHy3VxB/WInF+22tVw1USkbyEKhHPgWdKghsxZ07H
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="333004401"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="333004401"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 03:21:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="626125781"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="626125781"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 06 Mar 2023 03:21:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pZ8uV-00GJxv-3D;
        Mon, 06 Mar 2023 13:21:43 +0200
Date:   Mon, 6 Mar 2023 13:21:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <ZAXMx9orQMoNnWr8@smile.fi.intel.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
 <20230304201720.2d554f07@jic23-huawei>
 <4beef812-8f4f-3857-c814-efd9173d49e6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4beef812-8f4f-3857-c814-efd9173d49e6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 03:10:38PM +0200, Matti Vaittinen wrote:
> On 3/4/23 22:17, Jonathan Cameron wrote:
> > On Thu, 2 Mar 2023 12:58:59 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > 
> > As per other branch of the thread.
> > 
> > 	ch0 = max(1, le16_to_cpu(res[0]);
> >  > would be cleaner.
> 
> I tried this out. Comparing u16 to literal 1 results comparison of values
> with different sizes:
> 
> ./include/linux/minmax.h:20:28: warning: comparison of distinct pointer
> types lacks a cast
>   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>                             ^
> ./include/linux/minmax.h:26:4: note: in expansion of macro ‘__typecheck’
>    (__typecheck(x, y) && __no_side_effects(x, y))
>     ^~~~~~~~~~~
> ./include/linux/minmax.h:36:24: note: in expansion of macro ‘__safe_cmp’
>   __builtin_choose_expr(__safe_cmp(x, y), \
>                         ^~~~~~~~~~
> ./include/linux/minmax.h:74:19: note: in expansion of macro ‘__careful_cmp’
>  #define max(x, y) __careful_cmp(x, y, >)
>                    ^~~~~~~~~~~~~
> drivers/iio/light/rohm-bu27034.c:1057:8: note: in expansion of macro ‘max’
>   ch0 = max(1, ch0);
> 
> 
> I could work around this by doing:
> 
> const u16 min_ch_val = 1;
> 
> ...
> 
> ch0 = max(min_ch_val, le16_to_cpu(res[0]));
> 
> but I think that would really be obfuscating the meaning. I assume
> 
> ch0 = max((u16)1, le16_to_cpu(res[0]));
> 
> might work too - but to me it's pretty ugly.

That's why we have max_t() and clamp_val().
And you know that.

> 
> The more I am looking at this, the stronger I feel we should really just
> write this as it was. Check if res[0] contains the only unsafe data
> "!res[0]" - and if yes, set it to 1. The comment above it will clarify it to
> a reader wondering what happens.
> 
> I will leave it like it was in v2 for v3. If you still feel strong about it
> then we need to continue rubbing it.

You need to convert bit ordering first, then check for 0. It would at least
make more sense. (Today is 0 you are comparing with, tomorrow it might be
0xfffe, which is different to 0x7fff).

-- 
With Best Regards,
Andy Shevchenko


