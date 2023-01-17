Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC69A66E6ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjAQTZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjAQTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:14:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A877442F2;
        Tue, 17 Jan 2023 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673980101; x=1705516101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+pAd4vbUUJugp6qXfBkXwcFSz+Fk8omLGMJqI616UCU=;
  b=S4GX9rJSKokVPYzxQ7JL2ViCF82FkTTho4SvgEe9CmYXEmofaJzGpjnD
   cLV/Irsip9vNT0wz5XuykgN+moKBmxwSUd4uKGzpHGyloqNw+BN4EuRlU
   cLAKbOpNeQla2WRt0TDeXSbLuMaUetfXp7kbqNKFfgiUlx4Z1KY8AoUSp
   ITUEB83H7V1cbWQb94zeMYOTUdcLQq6UlrkLyXkjbMgL3CZ27cASQU69+
   C5ebmH6ylhPg7pFT5ygBp/OcSc7+z9oLUPY9joviqDbK1dG5/l2HwAGEG
   GTnub3NRzmZHQxu1v9Bl+xh6G9+lW5Yny2DZXFgOUADO9CNEpCOSi6FYs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="304460270"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="304460270"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:28:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="783341305"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="783341305"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 17 Jan 2023 10:28:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHqgy-00AiwK-2C;
        Tue, 17 Jan 2023 20:28:16 +0200
Date:   Tue, 17 Jan 2023 20:28:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: Proofreading and updating the
 documentation accordingly
Message-ID: <Y8bowKRMI+ukC4Ah@smile.fi.intel.com>
References: <20230116153347.15786-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbVa3XEDzcuy7iCqx0cvj4trzPe7N0B5PswA1mQ7O+GtA@mail.gmail.com>
 <Y8avtfifZpy89rS3@smile.fi.intel.com>
 <CACRpkdYTFDsU7xhu812Lh1mA1Hs9kGeid+akR84ervAsaxVYkg@mail.gmail.com>
 <Y8a4BAotZAax9Zx4@smile.fi.intel.com>
 <Y8bCBMoeNHlBG97a@smile.fi.intel.com>
 <Y8bCQ9QlhMpFdTiC@smile.fi.intel.com>
 <CACRpkdbn+UWU-dzp+MXSVB+JkpsFwENyi+5Eq+GV1zPaaaf3rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbn+UWU-dzp+MXSVB+JkpsFwENyi+5Eq+GV1zPaaaf3rA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 07:16:00PM +0100, Linus Walleij wrote:
> On Tue, Jan 17, 2023 at 4:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Jan 17, 2023 at 05:43:00PM +0200, Andy Shevchenko wrote:
> > > On Tue, Jan 17, 2023 at 05:00:20PM +0200, Andy Shevchenko wrote:

...

> > > > So, which tag to use?
> > > >
> > > > "Acked-by: Linus Walleij <linus.walleij@linaro.org>" ?
> 
> Yeah that's fine sorry for being unclear.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thank you!

> > > Added this tag and pushed to my tree, thanks!
> > >
> > > P.S. Tell me if I should do somehow else.
> >
> > Note, I have slightly amended couple of lines, and if you keep the patches
> > in your tree as well it may be a minor conflict.
> 
> I pulled them out now!

-- 
With Best Regards,
Andy Shevchenko


