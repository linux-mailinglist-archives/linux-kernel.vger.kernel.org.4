Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717B260C775
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiJYJGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiJYJEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:04:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1015A336
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:03:56 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="307621657"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="307621657"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 02:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="700469060"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="700469060"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2022 02:03:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1onFqW-001ukj-1p;
        Tue, 25 Oct 2022 12:03:40 +0300
Date:   Tue, 25 Oct 2022 12:03:40 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Nathan Moinvaziri <nathan@nathanm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering
 if chars match
Message-ID: <Y1embP5sEp/NPxK0@smile.fi.intel.com>
References: <BYAPR06MB557347406F22FBA1E400A5BFD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
 <CAHp75Vd4Vk0v-T3kfxApGHb-H26KTHgH59DGP3Wm4qBgunDt6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd4Vk0v-T3kfxApGHb-H26KTHgH59DGP3Wm4qBgunDt6A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:00:36AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 25, 2022 at 4:46 AM Nathan Moinvaziri <nathan@nathanm.com> wrote:

...

> > When running tests using Quick Benchmark with two matching 256 character
> > strings these changes result in anywhere between ~6-9x speed improvement.
> >
> > * We use unsigned char instead of int similar to strncasecmp.
> > * We only subtract c1 - c2 when they are not equal.

...

> You tell us that this is more preformant, but have not provided the
> numbers. Can we see those, please?

So, I have read carefully and see the reference to some QuickBenchmark I have
no idea about. What I meant here is to have numbers provided by an (open
source) tool (maybe even in-kernel test case) that anybody can test on their
machines. You also missed details about how you run, what the data set has been
used, etc.

> Note, that you basically trash CPU cache lines when characters are not
> equal, and before doing that you have a branching. I'm unsure that
> your way is more performant than the original one.

-- 
With Best Regards,
Andy Shevchenko


