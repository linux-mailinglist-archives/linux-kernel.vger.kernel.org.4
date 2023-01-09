Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21DC662355
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbjAIKlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbjAIKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:40:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33721186B5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673260390; x=1704796390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PbvXBZqo5nEkJec10f4nyY9EnbW+KTpvT9KNIUU+scE=;
  b=S37gteBBh7vprFHMCIefByX+837CO9n2/sSlrDBAIwZYkLpOZKpF6t9B
   y8uUf1KtAMo+QFyFXYz82cVn6C3JxFQhL8ujQx2aiyaSOktROWYz6Xo7E
   yxCA3Eelglqq6Jf14fOnwMDSf0va/iKTTci03RnooTHcD/gLB2IABTRAD
   X+xjK+8xm+0iRTA3+imNMc0O/T6qmFTidFny2L/kIbuGSEyvmTk9k9+aE
   nJq4o4HEnWwrNadkCcmeFJKWrefzJdSIeCHxrFmUOb0c8fgW6qthCIT47
   72ZyXgb28rv94TvCxReTWlcgKQraWDliidDgsZ/zColAqfRxl3iQWqRha
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="310636279"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="310636279"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 02:33:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="656637912"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="656637912"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2023 02:33:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pEpSl-006LLc-05;
        Mon, 09 Jan 2023 12:33:07 +0200
Date:   Mon, 9 Jan 2023 12:33:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] util_macros.h: Add missing insclusion
Message-ID: <Y7vtYkI4Szga8ngF@smile.fi.intel.com>
References: <20230103121937.32085-1-andriy.shevchenko@linux.intel.com>
 <20230105184354.ea9a981aa8c76bbfd6a2c212@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105184354.ea9a981aa8c76bbfd6a2c212@linux-foundation.org>
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

On Thu, Jan 05, 2023 at 06:43:54PM -0800, Andrew Morton wrote:
> On Tue,  3 Jan 2023 14:19:37 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> Does this fix any known build errors, or was it an I-noticed-this thing?

Not for my knowledge. It's rather the latter category to prevent such due
to header changes.

-- 
With Best Regards,
Andy Shevchenko


