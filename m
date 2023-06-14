Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB4730965
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFNUrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFNUrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:47:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DCF2128
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686775638; x=1718311638;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Se8+2IQkY8nLaPxVNcdXKvlEDy4mqbrQzyt8lKVfMqs=;
  b=PCUR6/tCevtqLs9+FcUJ7EAFNJiLAGe9/oTwntI2lrOH1bDtHvpYRnLc
   4nju70gNbROwTEyGdmg06xhndK+ytSCj/bvOqsAENF4JDZ2bo4bRH8LYo
   cf8EMTIbAWwScZsz35a/24WddTefmGC1QUxHBNaz919c7FBx+kghUcaN+
   f6pYiIFg7RH6AF238zpJ0fjtSJZR0rCrBWpexUCE3c/a1ql3VuBPN0YyJ
   rh0+b9It975gvLDhCwwD+M/hOpDDne+BK9bxXeyb+9raOEAj+9Ftjlvmg
   yuJSvfDy8eyt73pJB/6zKoEQ4lFrNgTvZFl1j5xzOB89BydLUFjKxILYw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="358731920"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="358731920"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 13:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="802076579"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="802076579"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2023 13:47:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 13:47:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 13:47:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 13:47:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwpOYUQuQNRlctUk54uKUSF8qTTTH1A4JnqnEHTz/PJEdzA8eFSAWE1WI/yI1NKxuxMDAN9+xib90jP2rs0PSR/P3Zj+Bo8ERgAgFEQ0ph6gCp/6bok7yQ/ZPfLOD1bCxw111Er2EpJYI8RUawN4k88F3vcUtDS9eUsw3jvXhhEB8zzvpg/qGPPpHDtGX4+O2Oxd3yY9cmUCCYTc29r3czexqK02paTNButLEtsH3ctobXWEc1bIwq2axpTvrml5RNEzWYwxAknvrLd9yVD6c/WxRrRKqu4mnBMWI+8FhRcV+onCKF2URw5WmCeoA4RDVf7XI2j8WZa9n7Z1lo84EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9mJ9Bgiqr8ctZxEsEI6gIiLPiBmSAF40sq2MWyQpDQ=;
 b=mpfm2VpR7wsSvSNbNn7rRN8xQtsRSzhodwQdXLmNOmwMeM9+CoDqpHSmzd6iUfr93pCbYL5iSrr0KoIbio+EYYSCLq3d82Q1Cbyd0Yx6eOjHZlkNUbp220YE3nVAElcn6D4WLS1MLhPUiDvPbeqVuwKPZtPEOpAQwNd5XFctH7MG2MmezXJXCD5aMvqUToQ/ggkKyT/ebKN23ezQnjlwL7OfZAuzPD3sCaeEFa+hR6Ns0qoKBTGKHvRGJsQylIMeYIPiWQcUU3eFnvzO7jmtDkjB9mdD87bDBH5osWnNDLHMA+GFick1BH4zRTDx/0vsfWLbwQInSq4iJHaKjUumwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CYYPR11MB8357.namprd11.prod.outlook.com (2603:10b6:930:c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 20:47:14 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f%3]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 20:47:14 +0000
Date:   Wed, 14 Jun 2023 13:47:11 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Tony Battersby" <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch V2 1/8] x86/smp: Make stop_other_cpus() more robust
Message-ID: <ZIonT7+sxAx8IWEE@a4bf019067fa.jf.intel.com>
References: <20230613115353.599087484@linutronix.de>
 <20230613121615.639116359@linutronix.de>
 <ZIoYMakfbAU9EOjc@a4bf019067fa.jf.intel.com>
 <87ilbp95xq.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87ilbp95xq.ffs@tglx>
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CYYPR11MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 61480522-0e65-4a21-5b31-08db6d188881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCRzi4TJ0lDMz04HadHzCJfmlcVTa00o00PdtWcze5KPrBM9JE9K5nBgvClKB4UtAwGFs1cyeMmaTft+QSQz3LJTZWnFr1vPPg+yKVtULXmrrNXNlfijTepQfpfoDZZp9gjB1JRhhVvGqH21KxpcZFtpSbkX3BLARYvweLxsC8n3QIURIbP+tpGmQo7baXrZF/OWXuiOWxNitKpXERHVbPTNP0i3jiYSaX0Vt6Qzeh01onWfEeh2ZcupSCcc5t1Edt+XkAxL5BYdB4sTK73qPmkvR/k4vi+V2hgteLelT8IaRus4Yn3kka6HAcaRKJU5tGh0KPznsPezsOFgsdTswCBhKYdoKvzvlv8hZ5O7DYlYxYvu3ERoMpYEJfVEIrvQoAbCcKP1g4PieF/Nb5UPUuE4AKzmm7TC76JSFBfTaJMMc/+NX/8Ll+glZAOcsaZTgBLN0P6FWtXS+/p6KU2RE1mkyjVIbZGorVkbLrmHNtQh/cBe4BDJ3CurhYGs0kEHnM60pfjCoVMgDwERWjXZTNSzUCH6s1l6+Px+90mEunleBjIRC6oKaufj3/pMbj0CQVywHV5VhUs7bvaVhrhMw2iOedk93O8Df91+RoKkM99d5QuvZzOnm3eKEjfrqABJrP2X/su4dAH3TthQOS8EM5cZNYFL83NESN97P2Mi+YU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(8676002)(8936002)(2906002)(38100700002)(82960400001)(5660300002)(66946007)(316002)(4326008)(6916009)(66476007)(66556008)(83380400001)(54906003)(41300700001)(478600001)(6512007)(6506007)(26005)(186003)(6666004)(6486002)(44832011)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W0CIvZDYIAc2JpmYc1qriactgyA+gxcr7zYowJh/f7U+gAoZFO/uBZVmObfY?=
 =?us-ascii?Q?0iLebM0sx740xpW/L7nNUt1mHmGB7M1DqQq8VjAz0mXdPivlKs4yyhHtStjF?=
 =?us-ascii?Q?1p1MInfDq915/iRaC6NAxpP5P3TmWHRIi1jwycsMsbHvUkns6VrhrWk0eWCD?=
 =?us-ascii?Q?Wz9mEdlbzvwToklUC9y6nVusQnqfiA0OegJ0QOgFgJZ9xNx5Qgohvm5zKGsS?=
 =?us-ascii?Q?vXVsf9RD1QOENXwHdH3Uvzc4X0w0wpkNg5cE/pkYWg+VvV5lc4nzPda8bIVe?=
 =?us-ascii?Q?iz/N6Fi/kw98R+svC9p/pzX3sgC3Wq2b4xQBcOR6blumqZy/bzmAqay04a7K?=
 =?us-ascii?Q?uPmgrEYCgkvvKsQgyOn/lPVEJfNDnLgkPzDsknQX7FEUJM9d9asKsgSJYlTG?=
 =?us-ascii?Q?/6cRqNbh7EHHXyErY9hlpGh4F9CRg+uZm41g8e0vnxreqhrDBd0K7shDN6/U?=
 =?us-ascii?Q?lxVZqujtaWB7JhhTKXIi3kqyIIwOiMblpvQBMrkArVY2sV7zk1AN0mm/WvQl?=
 =?us-ascii?Q?r8tF7DeAcMe582J1rTJ/rFRLnv/UV+5CWp0mW92WNUiF1PXV1sk9Wh8H0xuS?=
 =?us-ascii?Q?LzXe6pRcEJYfetPJMqQKQyuX7hdzZDcGYNnC4ixlgXW4HpKaepGKn4q3GflB?=
 =?us-ascii?Q?8Ds2wJK/LsTV2ACmX52RGk7yNyFjeiB+7aj9M8gdIuRa29SF27/CeE0pqg4L?=
 =?us-ascii?Q?xYhoiNrrl8ZRYs66+FLbCI/i5WW/LSmgxop7NxWZoS1hTvravDIRCnR9CqPS?=
 =?us-ascii?Q?nhvW9aKd3iXwLvOHi6zCSbjwyxgZutWcpXRPcE/PZycpm6Cms2mu+BxvgBNh?=
 =?us-ascii?Q?0xHZd5mP0tiIYOok7mzSu3BlF5wJR67maQ9wnwLQl7JD0EnA7yYFFzjIt2a2?=
 =?us-ascii?Q?VC0NEm9I7Sl8ZCCyGpvv8jKJRvVoNWX7t56xiEhVQB0SR5aw/1rCTKRnuQ5G?=
 =?us-ascii?Q?p/39J+K1oDR+Z+vMMCuStwAgatui37NBweSSekwk4RobYi2QwPGrF1e3RCSQ?=
 =?us-ascii?Q?IbVVVaDlqbbo4l30PEMdObImnRVZIcRGi4ACLGK5fdrTHCfctgR8r36urCV6?=
 =?us-ascii?Q?bbWzBgRXFRfb3486Sqvmf93O6+17T2wngEnWeoOhgIbzvPOf764kbY73kFdF?=
 =?us-ascii?Q?vN+SkJucKmcgROmKXP3mUKqg+7ef7Hyw39X2c/AUSsovy01ElJWLNIwQHEeB?=
 =?us-ascii?Q?0LUFbLF2IjguRpEb5Zj+IRu+wNuY1GOba+RGoikvuWVRs2EWM+7E7OTPUzZe?=
 =?us-ascii?Q?mlkl04bDDQz8VY5xU3SoGIThWmUEwTVL8SKRr+/j1cN5G2VLevIyr0C+0z5u?=
 =?us-ascii?Q?n4jE7OIdUPLmOtWp8KqUuFSDPPITrDf8whlcuDrWyxBA7BzPa4r8UlinG0/r?=
 =?us-ascii?Q?jft7wOVXMhZjPfRtIogY4NMHWQTPF+ThSnVSr82PUfk+tJ9H2vCP5cgwDE6j?=
 =?us-ascii?Q?5Y6qi8F5kiAlNSbhlgW4y5JmeIeAF99Ou+TzMAb+Dk3ydTMDwDs8HGGvNRWm?=
 =?us-ascii?Q?FSJrjoOsdXIBVld27byV+NmMXbu6T50r53vwiS3ouzGVZOIVynK68ECtl4hD?=
 =?us-ascii?Q?Gh1PtW046gKEycevJFWiFHdzwQLhXR/qss6/PAEu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61480522-0e65-4a21-5b31-08db6d188881
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 20:47:14.1700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mCRTl9adZvaR8/KSJfjGTUdO/gy4TARBcGR3euKEuP2VH1OmXkcPu6GpbTX9mYbQcIupq7YoRMmxgPfo+YoTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8357
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 09:53:21PM +0200, Thomas Gleixner wrote:
> > If we go down the INIT path, life is less complicated.. 
> >
> > After REBOOT_VECTOR IPI, if stop_cpus_count > 0, we send NMI to all CPUs.
> > Won't this completely update the atomic_dec() since CPUs in hlt() will also
> > take the NMI correct? I'm not sure if this is problematic.
> >
> > Or should we reinitialize stop_cpus_count before the NMI hurrah
> 
> Bah. Didn't think about HLT. Let me go back to the drawing board. Good catch!
> 
> >> +	/*
> >> +	 * Ensure that the cache line is invalidated on the other CPUs. See
> >> +	 * comment vs. SME in stop_this_cpu().
> >> +	 */
> >> +	atomic_set(&stop_cpus_count, INT_MAX);
> >
> > Didn't understand why INT_MAX here?
> 
> Any random number will do. The only purpose is to ensure that there is
> no dirty cache line on the other (stopped) CPUs.
> 
> Now let me look into this NMI cruft.
> 

Maybe if each CPU going down can set their mask, we can simply hit NMI to
only the problematic ones?

The simple count doesn't capture the CPUs in trouble.
