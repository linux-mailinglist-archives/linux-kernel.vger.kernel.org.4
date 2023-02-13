Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED87F695001
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBMS4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMS4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:56:08 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D2B1F5C7;
        Mon, 13 Feb 2023 10:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676314549; x=1707850549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vsBZP1hEviGNKOb8Fn2HjPjrYWP3jTqAc4o808JTUSY=;
  b=QNXBtX8JEgVRBnE/08Dj2Z0SyoM9K6HyWivy08N2Bj5GmwJBINeGzUvK
   YqEpXjkv74qRQmIm6UeJLIjihU+Eo7bqkkFY9o7N4Bl/ZHxe9AcWU+P1w
   KamfxSqbWDQChs9fDYM9+wXQBxvr9D4rKS4f+ponCfuMgIGmDIctTaxUa
   w1xNYs7sWq8TNVtnV9/QGOT8EElA6NrVND9jZcY2SZYU0to1TxzNlQh2l
   WwVb8WgJguIkyFzFLSo51zZqJs26oFxKnqtCw5vLA3elwe+GWy4H8SAZy
   AtHZvqsSSTzikaooy08sMkEYFWIRnAUfDzpGq0yag3ykOyQlMRsqVYlHp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="310602049"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="310602049"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:55:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="732589821"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="732589821"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 13 Feb 2023 10:55:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pRdzB-006VG3-12;
        Mon, 13 Feb 2023 20:55:33 +0200
Date:   Mon, 13 Feb 2023 20:55:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] Documentation: firmware-guide: gpio-properties:
 Clarify Explicit and Implicit
Message-ID: <Y+qHpa0GsIilc59A@smile.fi.intel.com>
References: <20230213132812.38646-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jkMez3_7rRqgyvbB9ik55fRxsU6yoLBZ-gVP7djwntmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jkMez3_7rRqgyvbB9ik55fRxsU6yoLBZ-gVP7djwntmA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 07:39:10PM +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 13, 2023 at 2:27 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >

...

> >  That said, for our above example the both GPIOs, since the bias setting
> >  is explicit and _DSD is present, will be treated as active with a high
> 
> Applied as 6.3 material, thanks!

Can you withdraw it for now, please? It has some formatting issues.
I will fix and send a new version instead.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


