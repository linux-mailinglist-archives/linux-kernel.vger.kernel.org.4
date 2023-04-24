Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1836ED07C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjDXOqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjDXOqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:46:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F46659F5;
        Mon, 24 Apr 2023 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682347559; x=1713883559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tUvHsXlQ2ByySgWqpFGw+k0Fl2kN5oY9aO532Vuo1i4=;
  b=F3d3KZnPO8gGB7q1wAIZgUXpFG8buUcaI+cuKZNmkEtSxETOeRTBfKAQ
   BsN3pc50soJbgY8tFZ8geP0Q4t89xlWLuqtyNDrbck4GRNpLHb2KQ9LfU
   /W7d97seonoiEi7MIkyK82INop6QUzMVP/4olUkwJGEJxNYtcyRWsMIMo
   bAznNwk9cLTFjSwLxUuCOZfig9aZ9RBvXK8wXih9DgGvFiKjrJ4EikLWY
   iiF548fQ1ZVZnrwAMEb8fg0JmrGVqKq0h7n8NMMpbVt8UgXkbpIhyM5Te
   Lzi67fZSE+4eAjCbhLWWySZ5z7D5gwBVExqC1cxTKdyoZJm31Zxjk6cBX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="409405836"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="409405836"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 07:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="762460388"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="762460388"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2023 07:45:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pqxRx-004Yeh-1s;
        Mon, 24 Apr 2023 17:45:53 +0300
Date:   Mon, 24 Apr 2023 17:45:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lv Ruyi <lv.ruyi@zte.com.cn>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/43] input: keypad: ep93xx: add DT support for Cirrus
 EP93xx
Message-ID: <ZEaWIUeZMvQ2K/dd@smile.fi.intel.com>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-28-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-28-nikita.shubin@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 03:34:43PM +0300, Nikita Shubin wrote:
> - get keymap from the device tree
> - find register range from the device tree
> - get interrupts from device tree

Note, the below comments may be applied to the whole series where it makes sense.

...

> +#include <linux/of.h>
> +#include <linux/of_platform.h>

Why?

You do not use them. Please, check all your patches to follow the rule: include
only the headers you are really using (or their up level wrappers if required).

(Hint: in this case you have to include mod_devicetable.h)

...

> +static const struct of_device_id ep93xx_keypad_of_ids[] = {
> +	{ .compatible = "cirrus,ep9301-keypad" },
> +	{},

No comma for the terminator entry.

> +};

-- 
With Best Regards,
Andy Shevchenko


