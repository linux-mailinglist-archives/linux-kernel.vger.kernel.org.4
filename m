Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC8B66E23F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjAQPe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAQPeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:34:22 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A5941B49;
        Tue, 17 Jan 2023 07:34:21 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="389221880"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="389221880"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:34:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="609281951"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="609281951"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 17 Jan 2023 07:34:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1pHnyW-00Adds-2m;
        Tue, 17 Jan 2023 17:34:12 +0200
Date:   Tue, 17 Jan 2023 17:34:12 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     hdegoede@redhat.com, mchehab@kernel.org, ailus@linux.intel.com,
        gregkh@linuxfoundation.org, error27@gmail.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: atomisp: pci: Replace bytes macros with
 functions
Message-ID: <Y8a/9GI+OsSRo+te@smile.fi.intel.com>
References: <20230117150841.18061-1-bpappas@pappasbrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117150841.18061-1-bpappas@pappasbrent.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:08:41AM -0500, Brent Pappas wrote:
> Replace the function-like macros FPNTBL_BYTES, SCTBL_BYTES, and
> MORPH_PLANE_BYTES with static inline functions to comply with Linux coding
> style standards.

Thank you!

But I think what you need, besides dropping unneeded parentheses is to use some
macros from overflow.h.

-- 
With Best Regards,
Andy Shevchenko


