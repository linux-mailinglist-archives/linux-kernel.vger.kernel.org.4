Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7CA6C2FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCULFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCULFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:05:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340253D08B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679396737; x=1710932737;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q+1aUFQOavPDBvO2fR0wBfOAzweGMgiEQPvCZ7oNbVM=;
  b=Zek3sU6sVeLz/6wiN7chsdoxTyF2783qc1+Yj9B2vKKaHlpwfCmr6scl
   uECDiGdPiJeNGipBrhxxfi5gcYcvy0a94FqYe3BNSFIAs81ISWvzyCD2L
   qtSzf6I3uTqhiYaMtnks/xUZIdr96SOBx0SAzxKsbTsMIjZsd7T2kSlci
   gvjA87ehy4meo74CZKTG0eqF5YvLMIVaJquon1W+yt9hKyV0LQyx0QGbz
   dgE4PtRsGGWTazI2BJAyvBmYsg0LXuDZLqVHOVrQbnYuMhPUz3gXHtPKc
   Y/PN7DIRC6i60+n/uwHp4UeVfbVM77P9ILKuO+vTXawhipiG5+o3eanPq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="425182935"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="425182935"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 04:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="745803277"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="745803277"
Received: from jluqueti-mobl.ger.corp.intel.com ([10.252.63.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 04:05:15 -0700
Date:   Tue, 21 Mar 2023 13:05:13 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     James Morse <james.morse@arm.com>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
Subject: Re: [PATCH v3 03/19] x86/resctrl: Create helper for RMID allocation
 and mondata dir creation
In-Reply-To: <20230320172620.18254-4-james.morse@arm.com>
Message-ID: <87dc96e1-e86-84f9-90dc-6e8f691dcd8@linux.intel.com>
References: <20230320172620.18254-1-james.morse@arm.com> <20230320172620.18254-4-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1050287707-1679396720=:1997"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1050287707-1679396720=:1997
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 20 Mar 2023, James Morse wrote:

> RMID are allocated for each monitor or control group directory, because
> each of these needs its own RMID. For control groups,
> rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.
> 
> MPAM's equivalent of RMID are not an independent number, so can't be
> allocated until the CLOSID is known. An RMID allocation for one CLOSID
> may fail, whereas another may succeed depending on how many monitor
> groups a control group has.
> 
> The RMID allocation needs to move to be after the CLOSID has been
> allocated.
> 
> To make a subsequent change that does this easier to read, move the RMID
> allocation and mondata dir creation to a helper.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 42 +++++++++++++++++---------
>  1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6ecaf34a4e32..b785beb0db26 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3135,6 +3135,30 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>  	return 0;
>  }
>  
> +static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
> +{
> +	int ret;
> +
> +	if (!rdt_mon_capable)
> +		return 0;
> +
> +	ret = alloc_rmid();
> +	if (ret < 0) {
> +		rdt_last_cmd_puts("Out of RMIDs\n");
> +		return ret;
> +	}
> +	rdtgrp->mon.rmid = ret;
> +
> +	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
> +	if (ret) {
> +		rdt_last_cmd_puts("kernfs subdir error\n");
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  			     const char *name, umode_t mode,
>  			     enum rdt_group_type rtype, struct rdtgroup **r)
> @@ -3200,20 +3224,10 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  		goto out_destroy;
>  	}
>  
> -	if (rdt_mon_capable) {
> -		ret = alloc_rmid();
> -		if (ret < 0) {
> -			rdt_last_cmd_puts("Out of RMIDs\n");
> -			goto out_destroy;
> -		}
> -		rdtgrp->mon.rmid = ret;
> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret)
> +		goto out_destroy;
>  
> -		ret = mkdir_mondata_all(kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
> -		if (ret) {
> -			rdt_last_cmd_puts("kernfs subdir error\n");
> -			goto out_idfree;
> -		}
> -	}
>  	kernfs_activate(kn);
>  
>  	/*
> @@ -3221,8 +3235,6 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  	 */
>  	return 0;
>  
> -out_idfree:
> -	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
>  out_destroy:
>  	kernfs_put(rdtgrp->kn);
>  	kernfs_remove(rdtgrp->kn);
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1050287707-1679396720=:1997--
