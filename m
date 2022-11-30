Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4601663D4FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiK3LwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiK3Lvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:51:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADED94092B;
        Wed, 30 Nov 2022 03:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669809108; x=1701345108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w0FIzb3rNPTqU3rvrXcfP9UfvCLZbtO9WXnKEYIkjnI=;
  b=fwZ9asFKSRsv9uhtOEvj6ezP2PdTM1JbolX+L3HVcXzKsvVIbaRo1GnG
   virkTOwk+GIZ+rl8t2dr1nstgXEENnfOqKTA0X4Sj2PlB7ChuAr49y1oy
   RdN3A0G9rHi14ZAxhTGJbfL7T/S2VTZmt1rssVpD1cm/7nOLqh6ps2H+t
   z95PJRR5x9RAvIIW0tlNgAunojeCS+B/qLzinK7Cdcg3zr/59xIuhgrK3
   TCwncGEIQmn7LNw3XKEp1vJFjO4/QxvhnqJoK+tTrQM4F5WArfgaNjHrn
   0hz2vx7avHNPMKmNA8NPOtKTzbrfwyUMjVCqw5vdlxUP4MERqkKo88DVi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="314069567"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="314069567"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 03:51:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="973075422"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="973075422"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 30 Nov 2022 03:51:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0Lcw-002F81-0l;
        Wed, 30 Nov 2022 13:51:46 +0200
Date:   Wed, 30 Nov 2022 13:51:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1 3/3] lib/string_helpers: Split out string_choices.h
Message-ID: <Y4dD0QaMO64jBnWn@smile.fi.intel.com>
References: <20221130115022.68956-1-andriy.shevchenko@linux.intel.com>
 <20221130115022.68956-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130115022.68956-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:50:22PM +0200, Andy Shevchenko wrote:
> Some users may only need the string choice APIs. Split
> the respective header, i.e. string_choices.h. Include
> it in the string_helpers.h.

This one can be skipped for now, can be considered just an idea.

-- 
With Best Regards,
Andy Shevchenko


