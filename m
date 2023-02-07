Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E305468E0AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjBGS6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBGS6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:58:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3890B1F48F;
        Tue,  7 Feb 2023 10:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675796310; x=1707332310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dSXSHlEWikcv5Z/BCN//ZPxm4jYckMqyZIAa1x0kq5A=;
  b=lqgHbWBY8wqNEs5t0bEJDlpE5EyZy/+5zoR2ZaIWzK/v8NoARpp+ta18
   qOz4lI9+tJjP0UieL6sFvugi6bnslO3QAeNA22c8NWuWcui54hiSz3pFo
   BZwlu0+7FdK9cuoDw4TwWQP956JtHAL/EAkLefAkGlVuda2GMw2X7Ltt/
   MQiWXQ+ZL9mVtElJAZkin7JT5bpx3rU77oyjAQzTH6r3QVpCgnfGGyC1U
   x0WS2e4ifDT8SUUo0htpFLVPFd/HwOjCYlQCCU8LQbuRRuDlOAgxprgGj
   qt+AJ0CbNRdJfAKJwk2nocHrAvGBDGswz+sVqeS4qzM3qdav1aIUAR4iQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="309938274"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="309938274"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 10:58:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="730562558"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="730562558"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 07 Feb 2023 10:58:29 -0800
Date:   Tue, 7 Feb 2023 11:08:08 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 0/2] intel_powerclamp: New module parameter
Message-ID: <20230207190808.GA14018@ranerica-svr.sc.intel.com>
References: <20230205025902.2899734-1-srinivas.pandruvada@linux.intel.com>
 <a68a6f8c76cb719cd4865bd6aa726306772d4ee3.camel@intel.com>
 <60514763753f572f854f1bbf287c3c16fbbc12c3.camel@linux.intel.com>
 <468eedb9d8a839d22ffd18125d3104f8c014965c.camel@intel.com>
 <f33bc346d8d4ae086ddf59db2670ce9a8f80a250.camel@linux.intel.com>
 <20230207134237.GA13076@ranerica-svr.sc.intel.com>
 <1395f577409bb7928dc1d9dc954e1af039253111.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1395f577409bb7928dc1d9dc954e1af039253111.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 05:51:59AM -0800, srinivas pandruvada wrote:
> On Tue, 2023-02-07 at 05:42 -0800, Ricardo Neri wrote:
> > On Mon, Feb 06, 2023 at 02:02:28AM -0800, srinivas pandruvada wrote:
> > > On Mon, 2023-02-06 at 08:05 +0000, Zhang, Rui wrote:
> > > > On Sun, 2023-02-05 at 18:45 -0800, srinivas pandruvada wrote:
> > > > > Hi Rui,
> > > > > 
> > > > > On Sun, 2023-02-05 at 15:57 +0000, Zhang, Rui wrote:
> > > > > > Hi, Srinivas,
> > > > > > 
> > > > > > First of all, the previous build error is gone.
> > > > > > 
> > > > > > Second, I found something strange, which may be related with
> > > > > > the
> > > > > > scheduler asym-packing, so CC Ricardo.
> > > > > > 
> > > > > I thought you disable ITMT before idle injection and reenebale
> > > > > after
> > > > > removal.
> > > > 
> > > > No.
> > > > 
> > > > I can reproduce this by playing with raw intel_powerclamp sysfs
> > > > knobs
> > > > and ITMT enabled.
> > > > 
> > > 
> > > This issue is happening even if ITMT disabled. If the module mask
> > > is
> > > composed of P-cores it works or even on servers as expected.
> > > Also if you offline all P-cores then select mask among E-cores, it
> > > is
> > > working. Somehow P-core influences E-cores.
> > > 
> > > Since this patch is module mask related, that is functioning
> > > correctly.
> > > We have to debug this interaction with P and E cores separately.
> > 
> > Currently, when doing asym_packing, ECores will only pull tasks from
> > a
> > PCore only if both SMT siblings are busy. It will only pull from the
> > lower-priority sibling. These patches [1] let ECores pull from either
> > sibling, if both are busy.
> > 
> > I presume that by injecting idle, the scheduler thinks that the CPU
> > is
> > idle (i.e., idle_cpu() returns true) and it will not do asym_packing
> > from
> > lower-priority CPUs.
> > 
> > However, in your experiment you have 16 threads. If a Pcore is
> > overloaded,
> > an ECore should be able to help.
> This issue happens with or without ITMT and also without any idle
> injection active.

I was not able to reproduce this issue on my ADL-S system with ITMT. The
described bug is exactly what and old patchset of mine was supposed to
fix [2]. Maybe the CPU priorities in the failing system are such that it
prevents asym_packing from kicking in.

I was able to reproduce the issue without ITMT.

I had found that the scheduler cannot handle load balance between SMT and
non-SMT cores correctly. My patchset [1] includes fixes for this case. I
applied it on top of Rafael's linux-next branch and it fixed the issue for
me in the non-ITMT case. Perhaps patches 5 and 6 are sufficient, but I
applied the whole series.

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/all/20210911011819.12184-7-ricardo.neri-calderon@linux.intel.com/
