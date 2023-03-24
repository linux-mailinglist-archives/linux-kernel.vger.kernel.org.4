Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01436C7ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjCXJFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCXJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:05:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426E136CA;
        Fri, 24 Mar 2023 02:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679648751; x=1711184751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8lGzd2l365WJAtOkQ45lcxnK6kVGkUm4YJQ0Jombmr8=;
  b=PQWLRXVl6g4DWQ1OovyZu5b4J0w9RRW7aFtkSTpEcYj6RztkbIm00Q9F
   aEMgvLqBIZojP2qsIkyKsxf0Lm9xG2st2SQQ9hYhzQRmgU2rBTmn33zmJ
   CZiwFuDHnPC4c4wCqCXQH2RGWqdpsf0nUXp4Xua6QutqUCVpVYnfnPiM7
   bpIe3vZwTBaGIpI5GVq4RL9m2cVKwYjlME4RXLTSmPH9CqilIcyHE3Cy0
   syWLemhOJS1/qJHA3sLAZr4eCCr1EkTMZSqlTCaedlxCTkdlu8gv+vUeR
   TDm0fr7fhBhAHmQKQHd8N4JrImwZJwQ8xoqIryER9zDOue6QPTVR0dll+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402317625"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="402317625"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 02:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="856804545"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="856804545"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2023 02:05:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pfdMq-007q8m-2l;
        Fri, 24 Mar 2023 11:05:48 +0200
Date:   Fri, 24 Mar 2023 11:05:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 2/2] ACPI: SPCR: Amend indentation
Message-ID: <ZB1n7Om3oqE0eRo6@smile.fi.intel.com>
References: <20230322102258.27390-1-andriy.shevchenko@linux.intel.com>
 <20230322102258.27390-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0imGNb8pETxdJmjJ9cSJQedeb=w2dcG6huDB=SpL-ufqA@mail.gmail.com>
 <ZBxFC6prEE5p4Wu1@smile.fi.intel.com>
 <CAJZ5v0g3iJ+QL=mL0a8cfoN9qT_FgM_j803ZWgcYn2AOpCN6AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g3iJ+QL=mL0a8cfoN9qT_FgM_j803ZWgcYn2AOpCN6AQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 09:31:11PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 23, 2023 at 1:24 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

> > On Wed, Mar 22, 2023 at 07:50:55PM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Mar 22, 2023 at 11:26 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > 2) Remove double spaces for consistency.
> > >
> > > I don't quite agree with this.
> > >
> > > Double spaces after a period are recognized as end-of-sentence markers
> > > by some editors (notably vi), so if they have been used intentionally,
> > > I see no reason to replace them.
> >
> > For the sake of consistency. There places in very same file which do not
> > follow this. I can invert and add a space to the rest. Do you prefer that?
> 
> Not really.  I just don't think that this is worth the churn.

Ah, that's fine.

> > The reasoning will be kept the same, though.
> 
> Is the lack of consistency in this particular respect really an issue?
> 
> I guess you can argue that if there are mixed sentence ending styles
> in one and the same comment, it is better to make them consistent,
> which I can agree with.  Otherwise I'm not convinced.

Okay, do you agree with the first patch in the series?
Then I can redo this one by dropping these particular
changes.

-- 
With Best Regards,
Andy Shevchenko


