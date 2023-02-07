Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7B68D9B3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjBGNwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjBGNwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:52:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3387A6A69;
        Tue,  7 Feb 2023 05:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675777926; x=1707313926;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/YLarjhVCWM9ERQghsklWhPfmj3oGMn0+g3tgiwq1pc=;
  b=TTPPsQaVXERCyzKpsT0KQ1yWwx9CMjCmZis6w3r5MVsH9P513gzivgq6
   ycMJUljWVBTI6q6NThntVYRBErUNbBYgtWEJIK2t0nuOPRLa5/6sEg+/b
   o/gjSmaxmEN/JC46hALUme7mLXl2IF+ea8KFy60Vt5WVi5rb6C7QOA/jY
   3+Az/XznHFfp9zJiODyqnjIjmiIS91siOXkKZP6AKQs4lXqLLxLc3Weo6
   0+UnkSi7DpRz1CF2JQzLnnXkZIrYaJG3+dFuttswIcX5RqofE9pvaQ42Y
   9lnSttTBcUGJG0J7uEW4hxIOpHLeu1DpWfCdeAOiV/TMpBZ5E6X/rSvXf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="394104626"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="394104626"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 05:52:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="735555721"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="735555721"
Received: from amarna2x-mobl.gar.corp.intel.com ([10.215.112.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 05:52:02 -0800
Message-ID: <1395f577409bb7928dc1d9dc954e1af039253111.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/2] intel_powerclamp: New module parameter
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Date:   Tue, 07 Feb 2023 05:51:59 -0800
In-Reply-To: <20230207134237.GA13076@ranerica-svr.sc.intel.com>
References: <20230205025902.2899734-1-srinivas.pandruvada@linux.intel.com>
         <a68a6f8c76cb719cd4865bd6aa726306772d4ee3.camel@intel.com>
         <60514763753f572f854f1bbf287c3c16fbbc12c3.camel@linux.intel.com>
         <468eedb9d8a839d22ffd18125d3104f8c014965c.camel@intel.com>
         <f33bc346d8d4ae086ddf59db2670ce9a8f80a250.camel@linux.intel.com>
         <20230207134237.GA13076@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-07 at 05:42 -0800, Ricardo Neri wrote:
> On Mon, Feb 06, 2023 at 02:02:28AM -0800, srinivas pandruvada wrote:
> > On Mon, 2023-02-06 at 08:05 +0000, Zhang, Rui wrote:
> > > On Sun, 2023-02-05 at 18:45 -0800, srinivas pandruvada wrote:
> > > > Hi Rui,
> > > >=20
> > > > On Sun, 2023-02-05 at 15:57 +0000, Zhang, Rui wrote:
> > > > > Hi, Srinivas,
> > > > >=20
> > > > > First of all, the previous build error is gone.
> > > > >=20
> > > > > Second, I found something strange, which may be related with
> > > > > the
> > > > > scheduler asym-packing, so CC Ricardo.
> > > > >=20
> > > > I thought you disable ITMT before idle injection and reenebale
> > > > after
> > > > removal.
> > >=20
> > > No.
> > >=20
> > > I can reproduce this by playing with raw intel_powerclamp sysfs
> > > knobs
> > > and ITMT enabled.
> > >=20
> >=20
> > This issue is happening even if ITMT disabled. If the module mask
> > is
> > composed of P-cores it works or even on servers as expected.
> > Also if you offline all P-cores then select mask among E-cores, it
> > is
> > working. Somehow P-core influences E-cores.
> >=20
> > Since this patch is module mask related, that is functioning
> > correctly.
> > We have to debug this interaction with P and E cores separately.
>=20
> Currently, when doing asym_packing, ECores will only pull tasks from
> a
> PCore only if both SMT siblings are busy. It will only pull from the
> lower-priority sibling. These patches [1] let ECores pull from either
> sibling, if both are busy.
>=20
> I presume that by injecting idle, the scheduler thinks that the CPU
> is
> idle (i.e., idle_cpu() returns true) and it will not do asym_packing
> from
> lower-priority CPUs.
>=20
> However, in your experiment you have 16 threads. If a Pcore is
> overloaded,
> an ECore should be able to help.
This issue happens with or without ITMT and also without any idle
injection active.

Thanks,
Srinivas


>=20
> [1].
> https://lore.kernel.org/lkml/20230207045838.11243-1-ricardo.neri-calderon=
@linux.intel.com/
> =C2=A0

