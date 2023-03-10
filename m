Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8296B4E72
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCJRZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCJRZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:25:19 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38EE5B9C;
        Fri, 10 Mar 2023 09:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678469118; x=1710005118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GsLnhiYrMaYeFzjQo7MAFHM9kLVSoa7vMje66c4oWB4=;
  b=i5igMe73ewO4QRoXULD76he26+1bExrMS0Xjda21CikLa+hzSqIMjqiU
   UtdfsJvwS6mTRtGYVz9Yeof4WoWycMiA4cqcZ8bk4n0CaX1awGDIm42GU
   6THxGl7gZQiauh+37MFoNxZyMJ6O6LFYYTn4lNLaE5BT0erVKqqofGPBl
   vr+d1YAyN0nd2WWuYGGUgThsddiy/WDrlp9LBwqjZN0QPzdjp3uehIMxY
   6ihTct+AmdLSajGrq2/SCBDiT80gDQqVbfLkstz6QmsohU+niBJQGdit+
   QX/Erz67LLsRMcrfTPhf7laesWsTQzmiJoZIJPFXgktnHikO+6ZMe/9q0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="334259876"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="334259876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:25:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="671152676"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="671152676"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 10 Mar 2023 09:25:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pagUT-00134s-2r;
        Fri, 10 Mar 2023 19:25:13 +0200
Date:   Fri, 10 Mar 2023 19:25:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 1/3] Documentation: gpio: Input mode is not true Hi-Z
Message-ID: <ZAtn+TIB/5ngaF7w@smile.fi.intel.com>
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdYVU2KJMw=FRxCLXbpWY+42RGheHvnqzg2bo2=JjTRCOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYVU2KJMw=FRxCLXbpWY+42RGheHvnqzg2bo2=JjTRCOw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 10:33:50AM +0100, Linus Walleij wrote:
> On Wed, Nov 30, 2022 at 4:55 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The true Hi-Z (a.k.a. high impedance) mode is when pin is completely
> > disconnected from the chip. This includes input buffer as well.
> > Nevertheless, some hardware may not support that mode and they are
> > considering input only as Hi-Z, but more precisely it is an equivalent
> > to that, in electronics it's basically "an antenna mode".
> >
> > Sligthly correct documentation to take the above into consideration.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Bart, can you apply only the first patch from the series, on which we have
a consensus (I believe?).

-- 
With Best Regards,
Andy Shevchenko


