Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3795B6C6833
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjCWMZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjCWMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:24:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABCC26CFA;
        Thu, 23 Mar 2023 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679574286; x=1711110286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hdELLoi3Y38QEaItXzUyqQG5Ep4EpLLrnUbgP0dSIQs=;
  b=ChSx1ZvdBGeMrvclGTBA/VlGL/X8XU1A4+F2ft3lQHAydbc6c0cN+9In
   XuaRYoBVneFxA6oG37hmHgwu3FUmHRI4DjV90GtGXxuj2zWJFOv6gzCSk
   gWKuAgoBflpJ7yKb6AThHusLFiJ0FBKJOJHcBUiru3PdTUQo57UXvDk0r
   M+TFu53c4nC3845VP06+A6rNdJZhlAUw4PEdoeGN/sgL8QSrnDL59OuFh
   7QW2sQ94QVFMs/uUjH0SuRiwvXP/xqRibbpUmPMbMm+ViNlm6ejyJ164v
   UjSNQVbWyATlcNgVUQ98894/6yYeUnOUmIhn398BAfJn4gxZmlQ1o2+/N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319859561"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="319859561"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 05:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="793000027"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="793000027"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2023 05:24:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pfJzn-007VQ1-14;
        Thu, 23 Mar 2023 14:24:43 +0200
Date:   Thu, 23 Mar 2023 14:24:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 2/2] ACPI: SPCR: Amend indentation
Message-ID: <ZBxFC6prEE5p4Wu1@smile.fi.intel.com>
References: <20230322102258.27390-1-andriy.shevchenko@linux.intel.com>
 <20230322102258.27390-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0imGNb8pETxdJmjJ9cSJQedeb=w2dcG6huDB=SpL-ufqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0imGNb8pETxdJmjJ9cSJQedeb=w2dcG6huDB=SpL-ufqA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 07:50:55PM +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 22, 2023 at 11:26 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > 2) Remove double spaces for consistency.
> 
> I don't quite agree with this.
> 
> Double spaces after a period are recognized as end-of-sentence markers
> by some editors (notably vi), so if they have been used intentionally,
> I see no reason to replace them.

For the sake of consistency. There places in very same file which do not
follow this. I can invert and add a space to the rest. Do you prefer that?
The reasoning will be kept the same, though.

-- 
With Best Regards,
Andy Shevchenko


