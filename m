Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11DF641313
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiLCB6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiLCB6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:58:05 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D523D92D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 17:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670032683; x=1701568683;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+mSXG0LK5FxL2c3UJUXn2nFmI+OdxkvJOVrvfm1WwKQ=;
  b=Zq7xX4zu900qVPcvmErsK0w/YJZAX2sSgzr+SG3OrFpxB26caykkBAdh
   JEnF92MwAu0TL+scjjGxTawhRABGy8iffuvrqAjKZd7fOuy3gFq1EBtH+
   yVnxtUlFLHohDDjUNumV/zf0rt3r0Mr0ywvsgD2RHA+jI0RgW657MneeZ
   SMujP/nOzCFwnyOfMTA8j8UNioqKgUB2b2ZBARw4DlDklZ3zK5pj+J1LB
   1Yql6tGX0YsH22A3VE70EWiJyb9sP1fuzD+sxSynyBeexznRVY9wV4O1Q
   CPC5Ruv5+8GXjZZfgn95S8pjtfE85DgElR5bG5tgLaRcL6X6e9fkKqt3r
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="295778305"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="295778305"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 17:58:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="595639468"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="595639468"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2022 17:58:03 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 17:58:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 17:58:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 17:58:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X19URnkl3Ryo9anNxGk/J0uzpbI/1kjuqtct/JAzQMG4qp6sYeMe3Ko3LLtP+DAaFYrT9tf9xVgo0j3G+YHh4vOMh9ouHqyv+HEIHVVL8T++vXg6gOIK84nmbrOl/HFkZJD1vHEQXYCSibCzSEqa5sUqYTF+FJM9EwOBUkbd7AhAHb9hrmu2ogaH28iAcwUL8Unz63TK0EQi9UUGWtj0s5Ai+8wfInonclYWGAWtrwZZ1bwifDl6ut2/1X9vAEoJ+dH22mlPaCAWFog73e8mBUDc8utl9DGrwUiXEjfO1pVuHIp19irEyb+HLL4eNgNjhFU+H3FDYxpYWR3DdEIUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6bdwQ+9aSzVeyaVY10Ny3awVFHAXEUoTvMUq3R/OwQ=;
 b=bbUZAxzoOre5gFJTSeiRlQAi/knpM0zZoFJkKaU88qiL+ualgeEkFZzNTsr/eY4o1DGYmVEdoIsWajdIZQ/LCXemP20fTfKR9l6+qrHmpDGSL/dslXjguUgI5UVTlCXDfgaz2lhAgwKehIMF+rvEuezm/1hA7inbaqZoiKuRQN08Mv5ACn69GO5xs2y+EBc1nmiFCME/8U4/K8RCHqMkxEpKzGa/cTTm3WOnZgbSykTCdczIpa8ZOBRDgGM8FPb8f3ZmwoEvNwC/FhJGVifnmTlITIV3StD97uns+8ihxYVDMKbKGkVrdTjKwF0/L22dBGWzgOijGVNTBi2Rqa8ofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH0PR11MB5032.namprd11.prod.outlook.com (2603:10b6:510:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sat, 3 Dec
 2022 01:58:00 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 01:58:00 +0000
Date:   Fri, 2 Dec 2022 17:57:57 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Borislav Petkov <bp@alien8.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch V1 4/7] x86/microcode/core: Take a snapshot before and
 after applying microcode
Message-ID: <Y4qtJRWt/QXD5ngJ@a4bf019067fa.jf.intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-5-ashok.raj@intel.com>
 <874judpqqd.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <874judpqqd.ffs@tglx>
X-ClientProxiedBy: MW4PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:303:b8::7) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH0PR11MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5dacfb-45ae-46ba-291b-08dad4d1ce78
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vG/aO1SMM/raKagNBB2T0IgEDm/ZJU/fpEXCivbUUmYl8N2kZQyW8NfXa9rpyq9LTdwStvGEqAhhHAwuRah6hJpGlYChJgZ/4E3iJiQbs8AdA+XXecOpWllfpbM0dvlVfJC0L36SKxQndZvfI2omiwFY0Bd91+vlWxBzFiiexdyZ6o2fTRgm/nvXS/go8cGBKpmLkj5fqBPgQ+yWXkWcv1VWFB3wOF8iLVVJMKRX4DrhACkPZoUjFai+ldBgwULyrXIf0i8ARX1QD5haNHGbwXuJNVIHFDv/8+XQYGoha4J9tMkhJi5LK5Wo0Sqgz0hmfR5YbA28HaCoApzRLwg7CYKrTNTr09e1mjgaRo65ruUItHL9HQQvbaearkMK11EdaKX+ZyhaA+nmn3udNSu/x/oxRyy5J/Qm99M3Owe88Tk1EhrstTD9RqnxmCH7Yq6hK0MNw51r5RT8/gGC5SCugcV9PitMcO+LtVJr9Bu06eIxF5EbdWX85ajnYQIHLTP9qrX7Eda91RMcIelsSUrRJovSvyG9lOzcM45Y0d5VJLXfsLiMOYyfEdeehfQ6MLV+FJXX9qVWN7L/npZ2nuwJo5JdzxiKCsRyyfCtUk+HtQfxCwZPPPQ3VzPaGKdqDfMpoY0MQNIBCHRUYomsWy2VXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(86362001)(478600001)(6486002)(6512007)(6506007)(186003)(6666004)(26005)(4326008)(4001150100001)(66946007)(8936002)(316002)(66556008)(6916009)(66476007)(41300700001)(54906003)(8676002)(5660300002)(2906002)(82960400001)(107886003)(38100700002)(44832011)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PLoa9vjSYk6p2inGNFetMArJOGzhvBJXD2tnobr1uZl2HmYQzKO6f79qDJvb?=
 =?us-ascii?Q?eK98BEplHOCemoUBpQEe+5MxafklCQLUjbyoJzYR6USlUd77Z7loJRP3/GIt?=
 =?us-ascii?Q?4d6j8+vq2ILm6HaFZ3nAs+1CCmrctyAIi7Ca5n4bA7ametN4qAZKtEygY2W/?=
 =?us-ascii?Q?uKrkzEreTpYYUbKlFHmo8S9I4wYSOTMiSDJ9lDZa+S5LmR3j/UjWmlJEDwaH?=
 =?us-ascii?Q?p9oTVqxMQXwLzzCjofL+dkLuS3hNTBau8swDzLUoTU4y5kZAf3036hsNbqhP?=
 =?us-ascii?Q?XnbiNobwWQMy8sp20nc2ffy1BsTu5NKrjbTW9YXxP53CnuJghhuxMIuA17cV?=
 =?us-ascii?Q?sLnhV7dXTmwCWepGMxNj6OlytIa4wEMYFCT7EbMFSSekRi7TB0vZCAcNMu7Z?=
 =?us-ascii?Q?6KD6WJCi5jZb2AhqqfUhrc7ADREnFsXHxPAduFqVemCfKpKicEOgyFXFmaXO?=
 =?us-ascii?Q?fl/KPAb4UacCfQXXgoz8CAKRWDzKM9hrSO6hvolka9fNBPYuUpR4pcA0IH2i?=
 =?us-ascii?Q?Fr+TLaAwwRzATB94nWEAQGhEWy9pMVRN/unO9nR4rMU0PAEinxepEthMkTDP?=
 =?us-ascii?Q?Zvq4LNCuDFj5aNHDEmoCO6dNgYCjPTHXDko+67vRkGOong8rpQg2zAvqDoxR?=
 =?us-ascii?Q?iNr7NIyn0C64V3KE6d0tq24fByALGrN4l+alRWc+x4l3WUP1PB9btutuWmqB?=
 =?us-ascii?Q?bPYGS79mPYz+aKuO5aKb4IAWwpeGGWQkDqvXJWQxSX0M442T2sH+EJ+FN8IN?=
 =?us-ascii?Q?+NNCdIkCrs26L1ciOjZ6CLX9kKBPYxkV5gdMLt2xPZ/Iz4YbzjJLc+vzg5qM?=
 =?us-ascii?Q?oWuCy6F8sLHMmtU8hac/nCBFcF5yjp1LH5UVLs2p3MXaDKoHByanpKiooR0S?=
 =?us-ascii?Q?hLVIdyvz/hkYZNWoumGgXEZTZHcY4vjnwogcKNrU3qXhMkyj+mWm89mCbtT5?=
 =?us-ascii?Q?7jpThAO0pfdMdN4Zw1tBqkWTekVaGDkL4mUmghIN+6mxvBEXUkKkA+TWcSjS?=
 =?us-ascii?Q?FnSBRpKvdXW+IPusu6vnphHQChOejZFFUr5Td7sc6Qo2GYWNC3ji9eWmjyZ9?=
 =?us-ascii?Q?/gOAIC76pEKAUTL39G0kMyC/XIvmSc4gdgT0QVJ2PTS032H1U2D7w9+O1vzo?=
 =?us-ascii?Q?bar67GjJkAG7Khps6JCm3044kPFX64+ylQSXbnyCTWuaIPgtSQNbaD9vrCBJ?=
 =?us-ascii?Q?8iqxlXIB1Y1URVgjUgT8ur8MserKRwN84Azvr+QXTdFfTT1f+fU0/SxlBhhu?=
 =?us-ascii?Q?uqHYTyMxOaoZFDxlqNoqu4NXVCMzJMllQYOZhRD/AmJ1FJJ70It1AVM/25Zy?=
 =?us-ascii?Q?Mnfg/1sQ9TzpObp8/sMAKpUOrOU7JprnZ5k6x3uVusfpGrXH1VTpwYxLY7FJ?=
 =?us-ascii?Q?D5CDFkxN7Ou3icdzuP0IOyvOlQGdZgEtLFACn2J4go69fwfpxqXbXIJtJgSI?=
 =?us-ascii?Q?sVe33Svg3W4nu+9d3icxNxmg5Dai9d20UADu5Q81/crqVtO44uEnw9Be36xj?=
 =?us-ascii?Q?6hMkA8xp+20MpDg/lsBuOdKPRh21FysYq9NR1efDOtKynN7tEl8l44W0p9YL?=
 =?us-ascii?Q?l3ySHPBYomGxH1P45ThNoxKRQnyjQ6uWfPHpb/adqIFF62gvgXRsEs86ZkMn?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5dacfb-45ae-46ba-291b-08dad4d1ce78
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 01:58:00.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uW9CCQ03ZOVlpgvUNMtvye8gLeeUcJ28lg/fshGq5oy/U+Z0osiU3za8Dx5xjtVCnjjwTm1lqGk8YCGOlZaC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5032
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 08:09:30PM +0100, Thomas Gleixner wrote:
> On Tue, Nov 29 2022 at 13:08, Ashok Raj wrote:
> 
> > The kernel caches features about each CPU's features at boot in an
> > x86_capability[] structure. The microcode update takes one snapshot and
> > compares it with the saved copy at boot.
> >
> > However, the capabilities in the boot copy can be turned off as a result of
> > certain command line parameters or configuration restrictions. This can
> > cause a mismatch when comparing the values before and after the microcode
> > update.
> >
> > microcode_check() is called after an update to report any previously
> > cached CPUID bits might have changed due to the update.
> >
> > Ignore the capabilities recorded at boot. Take a new snapshot before the
> > update and compare with a snapshot after the update to eliminate the false
> > warning.
> 
> Makes sense.
> 
> > +static void copy_cpu_caps(struct cpuinfo_x86 *info)
> > +{
> > +	/* Reload CPUID max function as it might've changed. */
> > +	info->cpuid_level = cpuid_eax(0);
> > +
> > +	/*
> > +	 * Copy all capability leafs to pick up the synthetic ones so that
> > +	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
> > +	 * get overwritten in get_cpu_cap().
> > +	 */
> > +	memcpy(info->x86_capability, &boot_cpu_data.x86_capability,
> > +	       sizeof(info->x86_capability));
> > +
> > +	get_cpu_cap(info);
> > +}
> > +
> >  /*
> >   * The microcode loader calls this upon late microcode load to recheck features,
> >   * only when microcode has been updated. Caller holds microcode_mutex and CPU
> >   * hotplug lock.
> >   */
> > -static void microcode_check(void)
> > +static void microcode_check(struct cpuinfo_x86 *orig)
> >  {
> >  	struct cpuinfo_x86 info;
> >  
> > @@ -446,15 +462,13 @@ static void microcode_check(void)
> >  	info.cpuid_level = cpuid_eax(0);
> >  
> >  	/*
> > -	 * Copy all capability leafs to pick up the synthetic ones so that
> > -	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
> > -	 * get overwritten in get_cpu_cap().
> > -	 */
> > -	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
> > +	* Copy all capability leafs to pick up the synthetic ones so that
> > +	* memcmp() below doesn't fail on that. The ones coming from CPUID will
> > +	* get overwritten in get_cpu_cap().
> > +	*/
> > +	copy_cpu_caps(&info);
> >  
> > -	get_cpu_cap(&info);
> > -
> > -	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability,
> > +	if (!memcmp(&info.x86_capability, &orig->x86_capability,
> >  		    sizeof(info.x86_capability)))
> >  		return;
> >  
> > @@ -469,6 +483,7 @@ static void microcode_check(void)
> >  static int microcode_reload_late(void)
> >  {
> >  	int old = boot_cpu_data.microcode, ret;
> > +	struct cpuinfo_x86 info;
> >  
> >  	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
> >  	pr_err("You should switch to early loading, if possible.\n");
> > @@ -476,9 +491,10 @@ static int microcode_reload_late(void)
> >  	atomic_set(&late_cpus_in,  0);
> >  	atomic_set(&late_cpus_out, 0);
> >  
> > +	copy_cpu_caps(&info);
> >  	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
> 
> You clearly ran out of newlines and comments here.

:-).. I'll add comments and some separation in my next post.

> 
> >  	if (ret == 0)
> > -		microcode_check();
> > +		microcode_check(&info);
> >  
> >  	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
> >  		old, boot_cpu_data.microcode);
> 
> Unrelated to that patch, but it just caught my attention. Why are we
> printing this is case of failure?

You are correct. I do have one, and for some reason was stuck behind couple
other unrelated patches. I moved it up and will include in my next repost.

From: Ashok Raj <ashok.raj@intel.com>
Date: 2022-11-18 19:49:09 -0800

x86/microcode: Display revisions only when update is successful

Right now, both microcode loading failures and successes print the same
message that Reloading is completed. This is misleading to users who would
need to deduce the reload failure by checking that the revision fields
didn't actually change.

Display the updated revision number only if an update is successful.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>

---

 arch/x86/kernel/cpu/microcode/core.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index fab2010ff368..58ee81ea09ed 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -493,11 +493,12 @@ static int microcode_reload_late(void)
 
 	copy_cpu_caps(&info);
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
-	if (ret == 0)
-		microcode_check(&info);
 
-	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
-		old, boot_cpu_data.microcode);
+	if (ret == 0) {
+		pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
+			old, boot_cpu_data.microcode);
+		microcode_check(&info);
+	}
 
 	return ret;
 }
