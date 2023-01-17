Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426A966E29E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjAQPpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAQPo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:44:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B60C442DF;
        Tue, 17 Jan 2023 07:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673970184; x=1705506184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9VNe08JYBh7NILu/PbEoLMpU1WohzzRCWSJikR4GRho=;
  b=O2U1h9tDO8qp4loDvQGHKxZcB8ldj5M9jRfyOHGsRJx6iBpTCubACf5s
   tJLr442Bq4iMLN85OIttNaWb1n5xgsm+GlTRgW28oYQcES5Ji7vxSl3ak
   25lgBrqhiNBF/ys2CRdbHNkpw0vq2vx/FypPnlX1OH52Th/UYlqlM3UGY
   pqmlLrtTkM6Jp+APNBs/SB46VAiXdMUS2nKkcBDBznxSU5rUctpZHdAUK
   BKPVM1M9s7Qzr2UGalD7x1XVReXpq60nHH25jyzFcxdfCzI7IyLf+44YT
   ZnJEmQihZx5x9tscMc+Ovu7rrcMjzZHDpG6CdOU1KEXR6fY2g5S+5Qlxa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="351971518"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="351971518"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:43:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="722710232"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="722710232"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2023 07:43:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHo72-00Adpw-24;
        Tue, 17 Jan 2023 17:43:00 +0200
Date:   Tue, 17 Jan 2023 17:43:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: Proofreading and updating the
 documentation accordingly
Message-ID: <Y8bCBMoeNHlBG97a@smile.fi.intel.com>
References: <20230116153347.15786-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbVa3XEDzcuy7iCqx0cvj4trzPe7N0B5PswA1mQ7O+GtA@mail.gmail.com>
 <Y8avtfifZpy89rS3@smile.fi.intel.com>
 <CACRpkdYTFDsU7xhu812Lh1mA1Hs9kGeid+akR84ervAsaxVYkg@mail.gmail.com>
 <Y8a4BAotZAax9Zx4@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8a4BAotZAax9Zx4@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 05:00:20PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 03:26:31PM +0100, Linus Walleij wrote:
> > On Tue, Jan 17, 2023 at 3:24 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > Actually I have missed the repetition of the comment I put in v1,
> > > i.e.  that this would be good to be attached to my PR where the
> > > struct pinfunction et al. have been introduced. Can I have your
> > > Ack?
> > 
> > Sure go ahead,
> 
> So, which tag to use?
> 
> "Acked-by: Linus Walleij <linus.walleij@linaro.org>" ?

Added this tag and pushed to my tree, thanks!

P.S. Tell me if I should do somehow else.

-- 
With Best Regards,
Andy Shevchenko


