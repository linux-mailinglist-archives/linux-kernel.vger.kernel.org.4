Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1360660C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJTQmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiJTQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:42:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CDB1ABA34;
        Thu, 20 Oct 2022 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666284133; x=1697820133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mtmyWnBU7EHxFbOleRTpDFq4fp2GV0yFyVdIlqKcAY0=;
  b=Iak8azakFUvgKuY4lExTcq0mpv6+YIjBM4uVr9cwotfnzHgsFeRkKQIP
   LlTLIUhW3T1ez/N8/m5XP7ggsEaCZS7ha/vB3UzhcZsgq3R+mHMZaefL3
   cNloJIulG/BjNBzXihxhX2kfKPSPEWA7ntIKUwuC87E7DaGUMqASTp6Wa
   2Fv874BdbIPZe5MRrcnx7EA5ebcpKcexKWyFKaSBw7Disu1vTmW2N4z75
   9UHrAvtRcOnWzuPV5r1fE7z9ieiTS8J3yFviPu9DLS1IiWWzuA2Ku+5I7
   uXhjPh4Dle9NjkJGARHJMc9V/rd7fF/tPmEuyODXV08uiel4MZ+b5CrH+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="368815237"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="368815237"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:42:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="661029041"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="661029041"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 20 Oct 2022 09:42:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olYcT-00AeGF-2w;
        Thu, 20 Oct 2022 19:42:09 +0300
Date:   Thu, 20 Oct 2022 19:42:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1F6YRzRS2DR+cKL@smile.fi.intel.com>
References: <20221017171243.57078-3-andriy.shevchenko@linux.intel.com>
 <Y02ObkYoUQlY9oG/@sirena.org.uk>
 <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
 <Y02TR0UBseEKUjq8@sirena.org.uk>
 <Y02TxHp53XQo34ql@smile.fi.intel.com>
 <Y06RCxzwrPZwIETp@sirena.org.uk>
 <Y1ASXFOuc2uGXOlV@smile.fi.intel.com>
 <Y1AczgwCEQO2gvQ2@sirena.org.uk>
 <Y1F0z5aP3MsqnMan@smile.fi.intel.com>
 <Y1F2a6CR+9sY66Zz@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1F2a6CR+9sY66Zz@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 05:25:15PM +0100, Mark Brown wrote:
> On Thu, Oct 20, 2022 at 07:18:23PM +0300, Andy Shevchenko wrote:
> > On Wed, Oct 19, 2022 at 04:50:38PM +0100, Mark Brown wrote:
> 
> > > For example a check that the ID is one we know about.  IIRC that bit of
> > > context looked like a tree of if statements with no particular
> > > validation.
> 
> > But isn't it guaranteed to be handled by device core, i.e. we won't get driver
> > even enumerated if ID is unknown to us.
> 
> That's true currently since you're matching based on ACPI ID and then
> have the lookup done with the ID information in the acpi_device_id table
> but IIRC the patch was replacing that with some device property stuff.

But that one also based on the IDs, it's not assigned without real IDs of
the devices on the certain platforms. I don't see how it's different in
this sense.

-- 
With Best Regards,
Andy Shevchenko


