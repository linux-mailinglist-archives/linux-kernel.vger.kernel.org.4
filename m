Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5064607BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJUQSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiJUQSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:18:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8799C254371;
        Fri, 21 Oct 2022 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666369108; x=1697905108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VaytRT87Myc4YmqlUl0V8eAIgrysFmZWUw/21sXlOCI=;
  b=HW8Kp4fCchIrusrEIngZukDzqfVDQXyhI68pgJLHJKGhDwZ6qF8121fF
   yLNuyph5AB3ZsaaWbFqVaGfkmo068URvcZt5J73hcFFNvGCGgrKneHLfz
   GNgA+QJnjTF3zD4SdWPZPdAkZMcE9Q0BwgzODga3K0jXhtQJVviYalas/
   mlynJR3uAI0cjA5QlRZ5FKUb+eI6aZ1Ah8Kb5klDE+3axmLAk4HaDKcq0
   bJ3AOz/vhDYs1LmU/wYOP5D6qeW4B05jDGWVcP+MHwaBLGCHJfRagKSYG
   CtTPgMHF5dq+FtRu60JL0+3Ct38nfyMi5gpjtZArttnprFi/zYSVbS4aM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308726982"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="308726982"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 09:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="693779105"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="693779105"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2022 09:18:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oluj2-0003sQ-1A;
        Fri, 21 Oct 2022 19:18:24 +0300
Date:   Fri, 21 Oct 2022 19:18:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Introduce the ACCES IDIO-16 GPIO library module
Message-ID: <Y1LGULB4L4IheMPk@smile.fi.intel.com>
References: <cover.1663519546.git.william.gray@linaro.org>
 <CAMRc=McQa0iDS+6OCOt9R1B-DdR7t1jD3D-Q3DTKbm=zidXpAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McQa0iDS+6OCOt9R1B-DdR7t1jD3D-Q3DTKbm=zidXpAQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 02:10:58PM +0200, Bartosz Golaszewski wrote:
> On Sun, Sep 18, 2022 at 9:54 PM William Breathitt Gray
> <william.gray@linaro.org> wrote:

> This series looks good to me, Andy do you have any objections?
> Otherwise, I'll queue it soon.

Nope. If anything, we can fix iteratively later on.
Thanks!

-- 
With Best Regards,
Andy Shevchenko


