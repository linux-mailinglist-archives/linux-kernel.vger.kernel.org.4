Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A816E8D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjDTJFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjDTJFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:05:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066197A82;
        Thu, 20 Apr 2023 01:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681981165; x=1713517165;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=q0Y83utopegjLaggA2Xkz05LGdX922bzA+sNOFJyeAY=;
  b=EBCvZ9Nfke76s9jPB0V/EzXh4brAZZr4EdeqgusIKbQADiNubPvmVVW9
   Ikc/kKo5csfeV6JCfgYPZtS0WeUb1yuTBlqRVb/zVy07ocqTVHQHb4aOy
   xf9pJWm1+qX2zF7YcJqMnz4nss3sgjPMOvKOrtoT2JKLpsscxqXyGBHyn
   z68eDFSEfkFdVrnAy0/VfcsG+jkCNUYB/pq+KDobDeN6rshgshhdN3Y60
   PezS1RgjnJN6oHDjmk8JB3t/TSb7byAvTNJNFXgz/jQpxfmR0BjREH6np
   uvSkVciP7Y0RCYNs8XRKDNoFh1g/btKOAZsMlsnx7iEmSyK06onAF7GrO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="373572161"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="373572161"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:59:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="1021517546"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="1021517546"
Received: from akirasen-mobl.amr.corp.intel.com ([10.252.32.100])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:59:16 -0700
Date:   Thu, 20 Apr 2023 11:59:13 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Moger, Babu" <babu.moger@amd.com>
cc:     corbet@lwn.net, Reinette Chatre <reinette.chatre@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v4 7/7] x86/resctrl: Add debug files when mounted with
 debug option
In-Reply-To: <933d8ae2-d8b7-7436-5918-f639405c9ecb@amd.com>
Message-ID: <346622f4-3ea9-c19c-6175-3346ffc6016@linux.intel.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu> <168177451010.1758847.568218491528297451.stgit@bmoger-ubuntu> <56497126-8f60-e590-bb13-b3739114375@linux.intel.com> <933d8ae2-d8b7-7436-5918-f639405c9ecb@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-353585656-1681981002=:2051"
Content-ID: <60e2175a-39f2-8ea0-1482-debe437a1fb9@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-353585656-1681981002=:2051
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <ae2428aa-843f-4ba1-4343-d66a1e4ba57e@linux.intel.com>

On Wed, 19 Apr 2023, Moger, Babu wrote:

> 
> 
> On 4/19/23 08:20, Ilpo Järvinen wrote:
> > On Mon, 17 Apr 2023, Babu Moger wrote:
> > 
> >> Add the debug files to the resctrl hierarchy.
> >>
> >> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >> ---
> >>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
> >>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   54 +++++++++++++++++++++++++++++++-
> >>  2 files changed, 54 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> >> index 1eac07ebc31b..855109abb480 100644
> >> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> >> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> >> @@ -288,6 +288,7 @@ struct rdtgroup {
> >>  #define RFTYPE_TOP			BIT(4)
> >>  #define RFTYPE_RES_CACHE		BIT(5)
> >>  #define RFTYPE_RES_MB			BIT(6)
> >> +#define RFTYPE_DEBUG			BIT(7)
> >>  #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
> >>  #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
> >>  #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
> >> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> >> index 15ded0dd5b09..1ec4359348c2 100644
> >> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> >> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> >> @@ -1880,6 +1880,7 @@ static struct rftype res_common_files[] = {
> >>  		.mode		= 0444,
> >>  		.kf_ops		= &rdtgroup_kf_single_ops,
> >>  		.seq_show	= rdtgroup_rmid_show,
> >> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
> >>  	},
> >>  	{
> >>  		.name		= "schemata",
> >> @@ -1909,6 +1910,7 @@ static struct rftype res_common_files[] = {
> >>  		.mode		= 0444,
> >>  		.kf_ops		= &rdtgroup_kf_single_ops,
> >>  		.seq_show	= rdtgroup_closid_show,
> >> +		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
> >>  	},
> >>  
> >>  };
> >> @@ -2420,6 +2422,49 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
> >>  			     struct rdtgroup *prgrp,
> >>  			     struct kernfs_node **mon_data_kn);
> >>  
> >> +static void resctrl_add_debug_files(void)
> >> +{
> >> +	struct rftype *rfts, *rft;
> >> +	int len;
> >> +
> >> +	rfts = res_common_files;
> >> +	len = ARRAY_SIZE(res_common_files);
> >> +
> >> +	lockdep_assert_held(&rdtgroup_mutex);
> >> +
> >> +	for (rft = rfts; rft < rfts + len; rft++) {
> >> +		if (rft->fflags & RFTYPE_DEBUG) {
> >> +			rft->fflags &= ~RFTYPE_DEBUG;
> > 
> > I don't fully follow why you need to play with ->fflags like this.
> > 
> > Is it for the ->fflags test in rdtgroup_add_files()? Can't you just do 
> > some extra masking there for RFTYPE_DEBUG based on resctrl_debug which 
> > you already keep?
> 
> Actually with this change, I can remove all these tricks here.
> I don't have to change the check "if (rft->fflags && ((fflags &
> rft->fflags) == rft->fflags)) {"
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1ec4359348c2..b560c44817bb 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1925,6 +1925,9 @@ static int rdtgroup_add_files(struct kernfs_node
> *kn, unsigned long fflags)
> 
>         lockdep_assert_held(&rdtgroup_mutex);
> 
> +       if (resctrl_debug)
> +               fflags |= RFTYPE_DEBUG;

Yes, looks good.

It matches to the idea I had in my mind but doesn't require putting it 
into the if condition itself.

> +
>         for (rft = rfts; rft < rfts + len; rft++) {
>                 if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
>                         ret = rdtgroup_add_file(kn, rft);
> 
> 
> > 
> >> +			rdtgroup_add_file(rdtgroup_default.kn, rft);
> >> +		}
> >> +	}


-- 
 i.
--8323329-353585656-1681981002=:2051--
