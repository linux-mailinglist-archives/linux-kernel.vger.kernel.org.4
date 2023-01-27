Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C6367DF91
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjA0IzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjA0IzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:55:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888332CFEE;
        Fri, 27 Jan 2023 00:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674809713; x=1706345713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5EtIEm42IHV01iMizUOOx7faj9GU6x1wMk2ehQepqKU=;
  b=SGdjOO43a7OtkgI/EC4oAAm3mVUEInLKrx+yFy9m5Hm0PZSQ16Uqrrci
   TbmZz4btZHIUCZIKkA7Bd6gvXQaXMnIj7ooMMm1RBW9nOieH+pWv6Cdvk
   6Zg0nCr29+qFsHEBd7ct6R8FF7GEQwWKerkyfG+/uTRnBSGZg+wPdPt9w
   fnV+LhKXJyCtABwhE3RqK9tqq119SWRJ6Kzir4i26ChsDttMZQLupVa1w
   qJ/FRLRjzA6OF/O+LJumZ7KzBJTMynjGCRO8Z1+p4aaOlHjpKwfYJ5DL7
   hCqmx+sbqm0hB60MxR3tTDmpk+tNLSFMEAWk6YbQTKQj1gwL6f7CG89v4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="391596594"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="391596594"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 00:55:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="695447179"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="695447179"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2023 00:55:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLKVq-00FsrN-1d;
        Fri, 27 Jan 2023 10:55:10 +0200
Date:   Fri, 27 Jan 2023 10:55:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] usb: fotg210: use
 devm_platform_get_and_ioremap_resource()
Message-ID: <Y9ORbi8hz7o5ek7W@smile.fi.intel.com>
References: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com>
 <20230120154437.22025-5-andriy.shevchenko@linux.intel.com>
 <CACRpkdaeAkPuAQu0BW45Bn94Q_eO-Ven0-TSd38upe9XpXMzwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaeAkPuAQu0BW45Bn94Q_eO-Ven0-TSd38upe9XpXMzwA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 09:02:30PM +0100, Linus Walleij wrote:
> On Fri, Jan 20, 2023 at 4:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for all your reviews!

But I think you are a bit late with them as Greg applied the series like
a couple of days ago.

-- 
With Best Regards,
Andy Shevchenko


