Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47A66A8642
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCBQXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCBQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:23:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9A31A64C;
        Thu,  2 Mar 2023 08:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677774223; x=1709310223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TtSfFHfwjReVtU3EoxFAIwjjqKwQJVfyLsn5VHQ7vBU=;
  b=YoB1EHZ7zUaOjhTQLGKsPRXIoND90+UkA+V6oWMPTnOh/uo5ODkx+pgw
   mPyv0W9fdZQYpRaWMWADmqpf0RBAy1ZJrsdME5FkgYXy4UZdAXGkTgXXx
   dRtdvcTKmWZ7HvUFKXV9vYNo/dJbo0upJuHDLpGVWxjgyNd7+kknIxqWC
   3yw5Z4DsM6XhxvwZOv5pN8fWgEJDc89vFZQ4f4kmylAme9T7Fm5sz6OQ0
   aY/9f02ffdyEL+TWZcgkEAXBrgsFxIdl3r9SuJXB2I+q8knQEYb8s2mxj
   mK5KD6ZaHFwf/Nuu+8/hKxRs+MFFKVQUItYexWCp3G2J5JY/xNLFq3PQF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="315184947"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="315184947"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 08:23:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="677275714"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="677275714"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 02 Mar 2023 08:23:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXliF-00EQSo-1J;
        Thu, 02 Mar 2023 18:23:23 +0200
Date:   Thu, 2 Mar 2023 18:23:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: Improve the kernel-doc of iio_trigger_poll
Message-ID: <ZADNexu/8SnwfI0B@smile.fi.intel.com>
References: <cover.1677761379.git.mehdi.djait.k@gmail.com>
 <bd84fc17e9d22eab998bf48720297f9a77689f45.1677761379.git.mehdi.djait.k@gmail.com>
 <ZADGnRILByq1/1ch@smile.fi.intel.com>
 <ZADMRsDgxKZ/UfJj@carbian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZADMRsDgxKZ/UfJj@carbian>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 05:18:14PM +0100, Mehdi Djait wrote:
> On Thu, Mar 02, 2023 at 05:54:05PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 02, 2023 at 02:04:35PM +0100, Mehdi Djait wrote:
> > > Move the kernel-doc of the function to industrialio-trigger.c
> > > Add a note on the context where the function is expected to be called.

...

> > > v2:
> > > - Changed the expected context of from interrupt to hard IRQ context
> > 
> > Thank you for an update.
> > 
> > But it seems I messed up with this and my previous remark shouldn't be
> > taken into consideration.
> > 
> > The "relevant hardware interrupt handler" may be hard and threaded IRQ context,
> > which looks like your first version was correct.
> > 
> > Let's wait for Jonathan opinion on this as he is a native speaker.
> 
> If I understood the function correctly I think you were right. It should
> be hard IRQ context
> 
> The relevant functions calls:
> iio_trigger_poll --> generic_handle_irq --> handle_irq_desc
> 
> handle_irq_desc: returns Operation not permitted if !in_hardirq() && handle_enforce_irqctx 
> and it is the reason why the sysfs trigger uses the irq_framework to call iio_trigger_poll 
> from hard IRQ context [1][2]

Cool, thank you for elaboration!

In any case it's up to Jonathan now what to do. With your explanation it seems
correct to phrase as you did in v2. Hence,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> [1] https://lwn.net/Articles/411605/ 
> [2] https://lore.kernel.org/all/1346922337-17088-1-git-send-email-lars@metafoo.de/

-- 
With Best Regards,
Andy Shevchenko


