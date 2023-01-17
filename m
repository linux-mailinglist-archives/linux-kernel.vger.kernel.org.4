Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD28A66E08C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjAQO1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjAQO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:26:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92F92A991;
        Tue, 17 Jan 2023 06:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673965497; x=1705501497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TtFt5vWHnXAw3Rqc9ppf+Ympu/5BdGeFC1aydX0aV3Y=;
  b=UpktkCYbglo1+7vJk2cXDAMwyxPtiCcjw51su8PtqFt9bDL9AW8cYzz9
   9W6D2ZjZ7GoZgFjgWZygzBtMZ2zDZUxoFn99hsMXshaEb/GsROi6RUbl6
   bvZyeLT1Qb4KgBrV9KHlKiOOqpRb4LcZ0XGa+oB5WMnhH6RTjyOS1BDeJ
   YwFTc8RJwwGaDuvNOIbhnQ//S5wSsRXODTAvoTN6P7zMuia3wXi3vnJAl
   Wr67LNk2CF86yhIN4Tp4Ei+G+HNmrWUcNIQeiy8M7xAgbMMJ2QeQIVgRB
   kXE5WDhforVXSBkOaR6RGJIr2fhHzhLNrfZFgzqovXnAK2nIrBCf+3EJa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324757962"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="324757962"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 06:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="748057075"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="748057075"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jan 2023 06:24:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHmtS-00Abzo-0p;
        Tue, 17 Jan 2023 16:24:54 +0200
Date:   Tue, 17 Jan 2023 16:24:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: Proofreading and updating the
 documentation accordingly
Message-ID: <Y8avtfifZpy89rS3@smile.fi.intel.com>
References: <20230116153347.15786-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbVa3XEDzcuy7iCqx0cvj4trzPe7N0B5PswA1mQ7O+GtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbVa3XEDzcuy7iCqx0cvj4trzPe7N0B5PswA1mQ7O+GtA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:15:45PM +0100, Linus Walleij wrote:
> On Mon, Jan 16, 2023 at 4:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Proofreading and updating the documentation accordingly, i.e. fixed:
> 
> Both patches applied! Thanks for your usual attention to details.

Hmm... okay.

Actually I have missed the repetition of the comment I put in v1,
i.e.  that this would be good to be attached to my PR where the
struct pinfunction et al. have been introduced. Can I have your
Ack?

-- 
With Best Regards,
Andy Shevchenko


