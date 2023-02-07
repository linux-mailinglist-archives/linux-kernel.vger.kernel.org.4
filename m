Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E0268D966
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjBGNdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjBGNdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:33:08 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA8B1F5C2;
        Tue,  7 Feb 2023 05:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675776780; x=1707312780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JXEbPFglSuiQr9d7wSUk0H3DKc91xWhi0p9Mc42n5FA=;
  b=PTWVqzeiZVa8JSHw6vt4+wmYHw9mJ8c6mmINi97695zS7K0A7+MEgOsm
   S9iVLdQZGRUxWfGpnGbHI2m1C/jGCksrH2mId+86tJzNk6DXP5GtK6HPg
   wYF6gTeF+Kn/+CuVfPALaqMEFqe+SSZKZFkd3CqXWOuP5XgqCPOUu21PZ
   /niOUNuoG6SjnyHJc6+/LQIpNLKjjB1woq+bKjblFTMrvJa+W96NdXtwp
   7BxHOXRTi3ccpVW2CCEGwhWPqI3K1adens4sPx6XAdX24ULgmbjIUc8DK
   tlXHjk7JU6L/+yu0RFixfItVCySS1fR+RHzHQdCJaqmw9iOkiATEiQ97Y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="391899591"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="391899591"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 05:32:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="755628365"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="755628365"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Feb 2023 05:32:59 -0800
Date:   Tue, 7 Feb 2023 05:42:37 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 0/2] intel_powerclamp: New module parameter
Message-ID: <20230207134237.GA13076@ranerica-svr.sc.intel.com>
References: <20230205025902.2899734-1-srinivas.pandruvada@linux.intel.com>
 <a68a6f8c76cb719cd4865bd6aa726306772d4ee3.camel@intel.com>
 <60514763753f572f854f1bbf287c3c16fbbc12c3.camel@linux.intel.com>
 <468eedb9d8a839d22ffd18125d3104f8c014965c.camel@intel.com>
 <f33bc346d8d4ae086ddf59db2670ce9a8f80a250.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f33bc346d8d4ae086ddf59db2670ce9a8f80a250.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 02:02:28AM -0800, srinivas pandruvada wrote:
> On Mon, 2023-02-06 at 08:05 +0000, Zhang, Rui wrote:
> > On Sun, 2023-02-05 at 18:45 -0800, srinivas pandruvada wrote:
> > > Hi Rui,
> > > 
> > > On Sun, 2023-02-05 at 15:57 +0000, Zhang, Rui wrote:
> > > > Hi, Srinivas,
> > > > 
> > > > First of all, the previous build error is gone.
> > > > 
> > > > Second, I found something strange, which may be related with the
> > > > scheduler asym-packing, so CC Ricardo.
> > > > 
> > > I thought you disable ITMT before idle injection and reenebale
> > > after
> > > removal.
> > 
> > No.
> > 
> > I can reproduce this by playing with raw intel_powerclamp sysfs knobs
> > and ITMT enabled.
> > 
> 
> This issue is happening even if ITMT disabled. If the module mask is
> composed of P-cores it works or even on servers as expected.
> Also if you offline all P-cores then select mask among E-cores, it is
> working. Somehow P-core influences E-cores.
> 
> Since this patch is module mask related, that is functioning correctly.
> We have to debug this interaction with P and E cores separately.

Currently, when doing asym_packing, ECores will only pull tasks from a
PCore only if both SMT siblings are busy. It will only pull from the
lower-priority sibling. These patches [1] let ECores pull from either
sibling, if both are busy.

I presume that by injecting idle, the scheduler thinks that the CPU is
idle (i.e., idle_cpu() returns true) and it will not do asym_packing from
lower-priority CPUs.

However, in your experiment you have 16 threads. If a Pcore is overloaded,
an ECore should be able to help.

[1]. https://lore.kernel.org/lkml/20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com/
 
