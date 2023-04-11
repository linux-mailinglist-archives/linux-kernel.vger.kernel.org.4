Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270E56DD982
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDKLhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDKLhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:37:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB76EE60
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681213039; x=1712749039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YPjrD+3mwHrcCrwE2Oq3I8nxe+q0Lx8hFRs76xaTrps=;
  b=fIvK/AqAF7yiML8/TKNfr4mZWeWyDWdZdfXdtHvkzodY1ciegWht6zwy
   I0pXSW9/yrZV/RHsxLFRaZhwLUAwDqrOxOhU59Xv2FwqpBA6LBwhWfMT/
   MiX+wYqvNOoZZ8ueopHUhugaGV4GOaiYLWNJAHJEQq0ajz3VbPtv0N75k
   vUtbCuJOMTLjOQPz009JO3U5hSfSXJIZ6xjUthU4VWM3tFw9ttVim65ST
   0D5U5Zi3FGZLT9ANw0lrbjeBzw32q8WQXfPRPdtPPecZ3gbNev3P39WFk
   FzNBbfhZn5N8t27i9GCg0NWwGSG6OPK/7APzHBi8OPrca/sECkkaFSHV6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="345379778"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="345379778"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:37:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="812535079"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="812535079"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 11 Apr 2023 04:37:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmCJH-00FF7B-20;
        Tue, 11 Apr 2023 14:37:15 +0300
Date:   Tue, 11 Apr 2023 14:37:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 2/5] extcon: Get rid of not really used name field in
 struct extcon_dev
Message-ID: <ZDVGay+hWCfPEVdu@smile.fi.intel.com>
References: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
 <20230405152745.24959-3-andriy.shevchenko@linux.intel.com>
 <4632ce69-2a94-0c33-9a76-b97596436e24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4632ce69-2a94-0c33-9a76-b97596436e24@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 04:26:35AM +0900, Chanwoo Choi wrote:
> On 23. 4. 6. 00:27, Andy Shevchenko wrote:

...

> > -	const char *name;
> 
> No I don't want to remove the name even if the edev->name is equal
> with the parent's name. I might reduce the readability and understaning
> of the code user and I think that it is not good to use 'dev.parent' directly
> at multiple point.

Obviously I think otherwise. But you are the extcon maintainer, so I assume
that I have got NAK for these patches.

-- 
With Best Regards,
Andy Shevchenko


