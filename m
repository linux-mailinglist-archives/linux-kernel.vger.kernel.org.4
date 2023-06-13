Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD36672E756
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243041AbjFMPfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243007AbjFMPfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:35:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F89F1BF4;
        Tue, 13 Jun 2023 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686670517; x=1718206517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BVwhD+woB9Rn4GIdKM9eg1WlU/5Y0ujWetNDpXzpdzk=;
  b=QIaW3szZIvx1yrHqPKQr3W3DABt76QvLnshX3sIO/TAknaI69kQr5rHx
   jcpKI3KqMJkqDGHjapfQ8KgUn3jIq7dtRyBtJMUB2qYlWgkwXemLzAkwT
   7SDM8OjMGtq6xhTq44/vJGdWYCBoh6YZjS6wYcDzG3bSuKEo9gXNhBTOI
   oP3urIwbDVZM8lz/Y17Yu+KTRj/+2KiAQbfg5VkpGYgGgVaG+kVxirEeR
   Fqid7kQIxGSMwSAvemv9Fb5upRT7jOM0iWHjZJ17o3pij6ozy5CryI4pZ
   8ir/dJJZg7c3qbzlQAr3HorSA1+OLodw7LAOHE7v3uIgTvFsjNSVxBhzn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361739619"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="361739619"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 08:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="705849507"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="705849507"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 13 Jun 2023 08:35:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9637-003UKV-32;
        Tue, 13 Jun 2023 18:35:13 +0300
Date:   Tue, 13 Jun 2023 18:35:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pinctrl: Duplicate user memory in one go in
 pinmux_select()
Message-ID: <ZIiMsUmhwRYcQaXu@smile.fi.intel.com>
References: <20230604131215.78847-1-andriy.shevchenko@linux.intel.com>
 <39569326-6b1c-39b1-0eb2-f1c1d11251ec@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39569326-6b1c-39b1-0eb2-f1c1d11251ec@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 04:30:44PM +0200, Markus Elfring wrote:
> > …, because asked lenght …
> 
> * Are there any chances to avoid a typo in such a change description?

Not anymore as explained in the other email, but thanks for pointing this out.

> * Was a cover letter accidentally omitted?

What do you want to see in such cover letter? How can it be helpful?
(Note that these are rhetorical towards this change, as it's already
 in the non-rebased branch)

-- 
With Best Regards,
Andy Shevchenko


