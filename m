Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ABA6D9F91
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbjDFSMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbjDFSM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:12:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8742D7F;
        Thu,  6 Apr 2023 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680804748; x=1712340748;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x00gcGg0KtEz1CEd1nzdSg630Kk7QhTFM270XTi9kus=;
  b=MPxP9ZPPrXCvutWCFcP/h+IgzqUHA/HrvRfMkkXKkC3e6LddFYigXieE
   D4WjcKLaBK4BYyCYWWPOuSKXb/mINOJUbn2vXlCI4dHkjp02PNKPNFTKo
   bJLLJwYudsVTEr8S5vFMyIbqjmYg9AXhVp6OwMq991gW8y+FFsFAmTDOD
   zbikcno9vPJVT3Hgzrs6cMfHEbZSEGCtQIrfzfCRKyC/xrND9HaFLIy8f
   T3iKTBkHPwrOw0hQYykcTkVOycnV1uTlwNJuak6ADtKWoVBjB8+TVhHFJ
   HmV1z65u1gV5HuIIriXX+tL7shAHyPMCelBkV/e13eRJzUspo9t8XzjOV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="341547457"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="341547457"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 11:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="719794491"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="719794491"
Received: from mjjuenem-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.81.95])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 11:12:13 -0700
Message-ID: <3a5a04091462fc33d4c61da2889fe7ce9bd55d97.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: intel-uncore-freq: Add client processors
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Apr 2023 11:12:12 -0700
In-Reply-To: <efcdc3fe-de74-0f0d-d9d5-3249fc1d5d53@redhat.com>
References: <20230330145939.1022261-1-srinivas.pandruvada@linux.intel.com>
         <efcdc3fe-de74-0f0d-d9d5-3249fc1d5d53@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Thu, 2023-04-06 at 12:58 +0200, Hans de Goede wrote:
> Hi Srinivas,
> 
> On 3/30/23 16:59, Srinivas Pandruvada wrote:
> > Make Intel uncore frequency driver support to client processor
> > starting
> > from Alder Lake.
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> 
> I assume that this is independent from the
> "[PATCH] platform/x86/intel-uncore-freq: Uncore frequency control via
> TPMI"
> changes ?
> 
Yes this is independent and there is no TPMI dependency.


Thanks,
Srinivas

> (just double checking before I merge this).
> 
> Regards,
> 
> Hans
> 
> 
> 
> > ---
> >  .../platform/x86/intel/uncore-frequency/uncore-frequency.c | 7
> > +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-
> > frequency.c
> > index 00ac7e381441..32e2515ee366 100644
> > --- a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > frequency.c
> > +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-
> > frequency.c
> > @@ -204,6 +204,13 @@ static const struct x86_cpu_id
> > intel_uncore_cpu_ids[] = {
> >         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,   NULL),
> >         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
> >         X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, NULL),
> >         {}
> >  };
> >  MODULE_DEVICE_TABLE(x86cpu, intel_uncore_cpu_ids);
> 

