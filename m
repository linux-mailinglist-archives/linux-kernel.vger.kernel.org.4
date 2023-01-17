Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667BC66E258
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjAQPgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjAQPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:35:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377D941B4E;
        Tue, 17 Jan 2023 07:35:46 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="323419845"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="323419845"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:35:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="801779057"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="801779057"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jan 2023 07:35:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1pHnzo-00Adfu-26;
        Tue, 17 Jan 2023 17:35:32 +0200
Date:   Tue, 17 Jan 2023 17:35:32 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     hdegoede@redhat.com, mchehab@kernel.org, ailus@linux.intel.com,
        gregkh@linuxfoundation.org, error27@gmail.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: atomisp: pci: Replace bytes macros with
 functions
Message-ID: <Y8bARLuFubMVILIN@smile.fi.intel.com>
References: <20230117150841.18061-1-bpappas@pappasbrent.com>
 <Y8a/9GI+OsSRo+te@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8a/9GI+OsSRo+te@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 05:34:12PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 10:08:41AM -0500, Brent Pappas wrote:
> > Replace the function-like macros FPNTBL_BYTES, SCTBL_BYTES, and
> > MORPH_PLANE_BYTES with static inline functions to comply with Linux coding
> > style standards.
> 
> Thank you!
> 
> But I think what you need, besides dropping unneeded parentheses, is to use some
> macros from overflow.h.

And drop "staging:" prefix from the patch since media maintainer uses (dumb)
script that adds "media:" if it doesn't lead the Subject.

-- 
With Best Regards,
Andy Shevchenko


