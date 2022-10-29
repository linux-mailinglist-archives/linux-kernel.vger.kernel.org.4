Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC87612635
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 00:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJ2WWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 18:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2WWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 18:22:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E622133850;
        Sat, 29 Oct 2022 15:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667082162; x=1698618162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zArReFz0K4WZAU7MHhzMeJpctz+eoMR8V6T85As7MO8=;
  b=eY8yrce/snCPALglB7j634xvg7ux8g4LBxwVRKEXxf4ltOsKFNjP0/NN
   eLCcquL5Ib0k1LIfYxs5cbM3cwMvvrO0FPcbHufRKd9Upe7my0CTUg3sr
   s9VlXoHAoT59JLLkuu/h+RffiFGLoNrYY5THcJy8b2qRgtp3WWIPHoU+U
   Kt+famGlZrClthSq9dQfpEtbH+zQxids7hI4swDYGL9o9rU0N2BzwhqCH
   3loHzo18v54u41bQMu0uEGMCMFE+zSsdozrHiv4b/R0kJnPAmAHQFXVFA
   Nal1c7jdH172pDNCTJAG9ylIY6MqWUCOcEAfdjH2WBEzCZCOnhH2etd+W
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="296105542"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="296105542"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 15:22:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="808169545"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="808169545"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2022 15:22:33 -0700
Date:   Sat, 29 Oct 2022 15:29:36 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: intel: hfi: Improve the type of
 hfi_features::nr_table_pages
Message-ID: <20221029222936.GD24473@ranerica-svr.sc.intel.com>
References: <20221018112240.25647-1-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hsWw2juPzLooVfDgykTwdepjgGSQGezhYeFBQN8yza_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hsWw2juPzLooVfDgykTwdepjgGSQGezhYeFBQN8yza_Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 08:13:15PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 18, 2022 at 1:16 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > A Coverity static code scan raised a potential overflow_before_widen
> > warning when hfi_features::nr_table_pages is used as an argument to
> > memcpy in intel_hfi_process_event().
> >
> > Even though the overflow can never happen (the maximum number of pages of
> > the HFI table is 0x10 and 0x10 << PAGE_SHIFT = 0x10000), using size_t as
> > the data type of hfi_features::nr_table_pages makes Coverity happy and
> > matches the data type of the argument 'size' of memcpy().
> >
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Amit Kucheria <amitk@kernel.org>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Haowen Bai <baihaowen@meizu.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  drivers/thermal/intel/intel_hfi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > index a0640f762dc5..239afe02e518 100644
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -137,7 +137,7 @@ struct hfi_instance {
> >   * Parameters and supported features that are common to all HFI instances
> >   */
> >  struct hfi_features {
> > -       unsigned int    nr_table_pages;
> > +       size_t          nr_table_pages;
> >         unsigned int    cpu_stride;
> >         unsigned int    hdr_size;
> >  };
> > --
> 
> Applied as 6.2 material, thanks!

Thank you Rafael!
