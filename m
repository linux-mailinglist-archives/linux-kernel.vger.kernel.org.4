Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5CD63382B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiKVJSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiKVJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:18:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E493B44
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669108684; x=1700644684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kv9gWX/RLeWF2efkzDmLjHFJX7rs4RTCkA7BaeF88k4=;
  b=h/rTnX6/KlbwE2sd5crs2z776BeiV3PhXmpTvXqTFAjhxF4stRnp8NLw
   T4OpjfT7CpstmS1Ny4iA7bNWMZ/gGSRXrk7vNqME70X2HesdI9IyGnVEl
   XKA1sVYOYflk5tIUpX/BFnhcJ+NWBc6xB1F5AfP1XaHHi7oM7zDaztwkk
   nexvhC5AzQDlFDhUIDIgM7ooo2pe3+zCRShNO40hrC4Biy37ili5TzXoT
   PvCQZvK1KECjAfJi25aeVCdBJUVVKUFreRjE9ekjB4drTf/bN4NiEWEzz
   9Kq6Oua7HAgOz7L53ONAKWFCf4N5enk0o0Yb0QiWfyC3JF1rN7f/HtdfF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="311402102"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="311402102"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 01:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="635479737"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="635479737"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2022 01:18:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxPPh-00Fgx5-3C;
        Tue, 22 Nov 2022 11:17:57 +0200
Date:   Tue, 22 Nov 2022 11:17:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     bigeasy@linutronix.de, robh@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH v3 0/4] x86/of: Fix a bug in x86 arch OF support
Message-ID: <Y3yTxRAVSOJTMuUu@smile.fi.intel.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1669100394.git.rtanwar@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:39:06PM +0800, Rahul Tanwar wrote:

> Rahul Tanwar (4):
>   x86/of: Convert Intel's APIC bindings to YAML schema
>   x86/of: Introduce new optional bool property for lapic

You need properly prefix the first two patches. I guess it's something like
"dt-bindings: x86: ioapic:".

-- 
With Best Regards,
Andy Shevchenko


