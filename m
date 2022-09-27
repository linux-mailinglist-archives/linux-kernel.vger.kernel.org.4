Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04845EC8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiI0Pys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiI0PyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:54:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F128FFA43;
        Tue, 27 Sep 2022 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664294050; x=1695830050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u8hRBebfGhAcD/eNs0QVOSD5vi4YYTrgF5ECepiux3I=;
  b=SL8hUFxNOigX7N9hBLENIETYBEHplj2hDhnnhdBOOOVDSnu3aGufEbeB
   ySJp/U+RsjXGh5uHa0m+0R49y8BIGSVQ33h1ezKl5JfPmbmdUiiySgiKh
   n/1pdnAzPDkwSRS5NcjO8F20vaX1hOpCMA7gT0m4zQ2MhpQ5wrifHdNxz
   Lk38gIfrx+eOT+LVqDrS+SLZgXNM1XtmYEsC7tQQBa0A9Ixss2ZEt/wuo
   wJp8EexVjTrO1NxLGiDAaGfiWvHoPm7GpB48zY7bR+EMSfew3adAdikTY
   i+5djJntmy9mSgKcDxOMMnsh7B4OZwIRbJsG216rRcWzcL2ZoNCgJpYxF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301330170"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="301330170"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 08:54:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="654773487"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="654773487"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2022 08:54:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odCuJ-008WBJ-1K;
        Tue, 27 Sep 2022 18:54:03 +0300
Date:   Tue, 27 Sep 2022 18:54:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: twl4030-madc: add missing of.h include
Message-ID: <YzMcmxYzzCwJ1DTL@smile.fi.intel.com>
References: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
 <20220927052217.2784593-4-dmitry.torokhov@gmail.com>
 <YzLreedzM3/+2gBh@smile.fi.intel.com>
 <YzMYdoQmDt6YAvdr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzMYdoQmDt6YAvdr@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:36:22AM -0700, Dmitry Torokhov wrote:
> On Tue, Sep 27, 2022 at 03:24:25PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 26, 2022 at 10:22:16PM -0700, Dmitry Torokhov wrote:
> > > The driver is using of_device_id and therefore needs to include
> > > of.h header.
> > 
> > As per patch 2 comment, mod_devicetable.h is needed for that.
> 
> It also uses of_match_ptr(), so of.h is the one that is needed. I'll
> adjust the patch description.

Thank you! In such case feel free to add my tag.

-- 
With Best Regards,
Andy Shevchenko


