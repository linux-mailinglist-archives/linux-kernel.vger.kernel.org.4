Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDABE6BC251
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjCPASt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCPASq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:18:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B35186DEF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678925920; x=1710461920;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=RHPoti1TVTSkXIMkKe9P0pSd8TauvU4FyaLY0ddDD5c=;
  b=mr+DdLZfrtfG3Nl+8ZIKNjzvvyKbgdFvE9oLhChx0qOZqFPzRtX9vOKH
   8E7gTJ6iRfz2ORV00/qBQHSkVD9BPEgEf/cr7sFDsWhTjpQ+MKh/jHB3V
   51BBV6tBxxk8u779brTHAYj7+47QgFFpLRr0QVzO51Wk6rV17rh3a9RRt
   iwNWV6bmwwWfSHi8T1lk7tK4RBuIcvXr8KmUE7AvVTJ8Pq5us5MiLRvVL
   e8L630R1WD2lReMRJbR44V0G74dgpABh9N7q1z1Yd/i9R49J3rp10RVnR
   ZK638s9/X1Yf7pjxV16st+z0Wog5bu8rUHkEBAyHkmQPCIefa41aMzVSU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="402720956"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="402720956"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 17:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="748655947"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="748655947"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2023 17:18:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:18:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 17:18:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 17:18:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flWLumMbyrMxAWuuwLgEdpUcMhzYMRA+DBbZy8Hfl54YMPGIfJWPs9FE6/LemvW04oe89l1JGhYDqK5zwljIBVbpONTUo+JHdt4lTHFh41CguEhdU4aniz5Yv83fFZsD5K2xz0nriAdiIS9hYSMm2Cs9P/j/8AcJX97FMAbsmkdnLyXuG23T8Dm1QVUw9dbracms/MixjyJBlx1isyWabZEj93DBTlPmVystKEcPV11FwxRZdSNHUeRAiG1aAL+5e18K8tyR78VFRUH46iA/0ugsmoEUQPoB7dwgsnTpv31xzSdxCsPZf6POEkpD01EM5UjyH6yxGmQcb3B3i99HPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbl0djtqjMHcEQEz6bvm3w/FMDn+rZR13mU0X8SyKaI=;
 b=Px0iPv9NyV4saqhy138DQR+pHjc08VueOYmxVLfdvZqSZcTiCZwUWNsSFpJc8Sjha+CG6gMO11n383xFZ6tbdzTTYeJReVA7Chum9RUBivD6kWXM18BVkcItpclykW1EIjI3dCGHuLC5edYci9mtYd00tuqkjxWrfW0ohjAHXhCXkCI/Hu6h7lhQAOWMoeMRORmnnVz8pjwWYr1k7trA1/7KaygaouimKEkYFmT5ol/eNGEU0OKaV1VzTHt9rN+0kvaI2/nRygIfNW3QqBNzQXnp2qtyU04KQN2iDwK1nyN/9CGPxEnn1cwp2GAA+lrf9rjNH5FHhdPVtnULWWdq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BY1PR11MB7983.namprd11.prod.outlook.com (2603:10b6:a03:52b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 00:18:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 00:18:30 +0000
Date:   Wed, 15 Mar 2023 17:18:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, <gregkh@linuxfoundation.org>
CC:     <outreachy@lists.linux.dev>, <martyn@welchs.me.uk>,
        <manohar.vanga@gmail.com>, <zoo868e@gmail.com>,
        <jerrykang026@gmail.com>, <cuigaosheng1@huawei.com>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-staging@lists.linux.dev>
Subject: Re: [PATCH 1/2] staging: vme_user: add space around operators
Message-ID: <64126052e09c0_2595222947e@iweiny-mobl.notmuch>
References: <b56c7b94e59a4051373af8b5d90a0685dfc9233a.1678882204.git.eng.mennamahmoud.mm@gmail.com>
 <641212c8d481f_253a1e29437@iweiny-mobl.notmuch>
 <f9988309-d4f1-8e50-555d-3fd813952893@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9988309-d4f1-8e50-555d-3fd813952893@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:a03:333::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BY1PR11MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd660ed-c20e-48c7-ba11-08db25b3f8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oe+Nhj26a/EQkXw1t0bIDkUM5GrKgRXbw7/j5aIiaX4qOfjpSqxwoOL4Uy9y+9DX4Rk7D7jqqp3G5esn0lRFA2tZh6NqjO81tpEezzKwrNOSGpMUMYxGz9uF4qt04SF0/8hI611N19O9WKliH0L8uU86T5jdKt/tSWuqqosAsBvc9w33NXAuzQmVChXj45aIKWGdpaC9/0mDJtIyig9CuKbLo385O9YnAMRV0OsI2zSbmuLyI9gTUwFd8m1vfYCgQAsJD/IJdynJYiC7xMUUtNLjqhqVhOw4gZ7CTyg3Q3yoo8DruKEhc5NifLR5XdK8ovDTrgFYzOZ+gUccvzVOADQ/PzDwz0K6dA7brf5OKyKEp8mIUyVJ207FiOj8PJMhK/Y7immnH9xA2IFY24QA0FuF0t7wcmA0rnfscXpBDShzWRsvedueBjTvVeUXLwcTNuRt+6+rdgwHAXovI4+Mpb9Q7qI5k1fSo8gczwiIO2fm8Wcy+rX7MVC9RtB4j8xde8jpGULD/d5RXVcqRooLFJcWVfQ4LTy1PxmjgS5RaomXPKToB3JgpLZa5VkVyMOKtXlW84ifZFk+obKmsIroTLTLE6PT37Zkgx2kJkBexhaujyKZRKH2cG8Xexn9sKKi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199018)(966005)(6486002)(83380400001)(478600001)(6666004)(186003)(6506007)(9686003)(6512007)(66946007)(316002)(110136005)(66556008)(66476007)(8676002)(41300700001)(4326008)(8936002)(44832011)(5660300002)(7416002)(38100700002)(26005)(82960400001)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lWVXRTeWhOVGpzN0ZSZHQ2VG5WanhoenZxcE1EV2E3OVdyVHNBYk5mOS93?=
 =?utf-8?B?OHMrVlY3KzBYL1NtQi93eGVVREpkL25rTS9iZGI3blBoY3hoQzY4TjRoWFNy?=
 =?utf-8?B?TnloSnA4a2RDWGgycVN3QjF6Y1ZzdWxrQUpCS0FXUFgrc3U3RXJXWWJBTjJn?=
 =?utf-8?B?OWVCOVI3QURPYmY5enJtdS9rU0o2OVhrU0t1YS82a0NMd2dmM3BVd1krNjRj?=
 =?utf-8?B?N2F6cStwNndGS2lyUkc4SWY3d1VwT3o1Ky9jL1cydlFHRlVPVC9vY0x3TjQy?=
 =?utf-8?B?VzdzamR4QmZ5MVcvdzcxVXJPZjZER0c2b0lQZ2J3bGM5azFqajVZNnBXaFRE?=
 =?utf-8?B?QW1HS2tJcEVmbHRWMldGOXU3SjhnZWEzMHRaUkYrSHVncXI2ZEdBTWxSd1Ew?=
 =?utf-8?B?cmVEa0F4bzNacWZjK3Fmbkt2WE9DRXkxZnNpSW14SEZmY0hzMDBmS2kvWit0?=
 =?utf-8?B?Sy8weG5YS2dOR0E5RkZ6VWFDZ3JMSTkycGdqREExVWVJZmJSUUxmUVduUFlO?=
 =?utf-8?B?eW5yZFZ0ZG1mM3UwOHFPMWVGRW95Ujh4U1RaZkRwY2F5S280aGFyZXJEajJR?=
 =?utf-8?B?Y3VXWWNqYWV4WHpxWFdPMHB1anNwSUgxRzllcll3MDJsS0Q1NkVUcVFMZnEw?=
 =?utf-8?B?Vm8ydDlERVhrRHE3UTB1TXM3akNHbDhDRmFNUFc1TWxpVGh1dXlsb1M4ZTFR?=
 =?utf-8?B?TUJZUWhFNHlZZkROUGQ4ci9ZYVY2dlEyU29rQ0UwcmVhbnFkQXNaenlkaEFn?=
 =?utf-8?B?OEo4cTZQV20waVRzRUxQTndsUVYwcGhqVVFwekJYSk9RdlpzMC83UnJVS3Za?=
 =?utf-8?B?RmZXbGRsR2c2azlsaWhBTTNKN1pFTHljRk13bzU1SWJ4TzVLUUVMajFYRlVI?=
 =?utf-8?B?RHJ4dWhBNTVUbElOSXFRQXJFaE53MVQvaHVmUUhPTTVzY0Fzak42bitpSzkv?=
 =?utf-8?B?K1lWZzI4MGM4R244SWtVNHdjaFE2bmRLUDZjbGM4ZVVwbWZLb3VLZ0pCVCtM?=
 =?utf-8?B?dGxhS1dSS0dZUFpTWHJXZlpuTXJ5a3ZMMEoyNDZrZlJMc2hmeXFweldWWlZo?=
 =?utf-8?B?a3JKZ20rVmZlcGQzNGpTcXNUSHNxeVp2TWdRNk40bVlRbHZtUjhja2lxZUVX?=
 =?utf-8?B?bHpIUTFHaVFzVkdPOW1ZWndmSUc0NjRnVlpSb00wTHhYbVdxbklSWUdhV0tu?=
 =?utf-8?B?Vlcya3NSeWNyUm5jTGVOWWdtVHBNRkpOeGY2U0hoekhnZUhZdlBDaW1MblEy?=
 =?utf-8?B?V215QkgwVWY4bE9JQ2VteEhiMWtaQVlYajgzYW45eHRaZENZeDBuSjlieHlN?=
 =?utf-8?B?LzBXQVZNMFdIS2tXc0V2ZE4xZk9JY2tSWUpmV3JOWHBJZTRnZkdJdXgxZkxz?=
 =?utf-8?B?QmNSRlZJVUtVUnRVVXNKU2lhT1FrNWJPSktudEh2dlpqdzM5VG82cEtJT3NF?=
 =?utf-8?B?RnJqZWVmVU0raWE4bVVWazdpdG10OHZMRmkzQUFiOXpMK3NaRHR3SUliUE9Z?=
 =?utf-8?B?UWZUY2xDMU1mdkJCUlM5VkgxNDdhY1JpZ0IzVDFqZkY4MGZrVDA5Y1JzRjl3?=
 =?utf-8?B?MkJYYWJucXBCOEc5RFh0L3pFSmhWSEhkb3F5dS81V204eVEyd1ZTV1RXdVdl?=
 =?utf-8?B?YXVKT2lheGdmeTdkUzFibCtPTkRSdTROOTlESDQyOHplY0ZGbnIyOVZVL3BQ?=
 =?utf-8?B?NkdMWEJjb3MvZVh1a3JSSEo1bXQzclZIcCtDZDJBc1BGMEZWL2QybmM5M1h2?=
 =?utf-8?B?aTc2R2dpcG9zMU1nOVR1Z0I3Und0M0djN2JXY3BmS0dnOS83NWw3ZFhkZThw?=
 =?utf-8?B?VzlEdWRMeDBicVVIODBrOVIrL2hEeE9OSjdzNkJrMkRMeFhCRGVOYTRyOHZG?=
 =?utf-8?B?NVliazJXQTdPVTZQQnkraVdXdk5iZnp3aGh3YXFidGwyZXRKZWh4VGJabkZh?=
 =?utf-8?B?OUE3bW8yOG5YSzlzSUhIWEdwYXVzRDVqc1FwQmFUQzkzWCtHd3NtUWt4UnBN?=
 =?utf-8?B?dkc2VEhkSkxEbXpDUlZGRzMzRkNvY2t6alFyeXlkRDMxWExWSjY5NTZDQUN5?=
 =?utf-8?B?RUJoUEk2NkIweEZzeXFhRGc0cU10NXYvb2pUSlczeXFzNCtqT2ZQcHhTL1dC?=
 =?utf-8?B?S2JESHpBc0U1R3BNL1ZDU0c2ZEx6NjF0MWFwWnBlbEk3ZHBickdubFkvR3hm?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd660ed-c20e-48c7-ba11-08db25b3f8c7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:18:30.7988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wb0/s3MRseKdqGucPs5eZrxkDQJQZ/zhQVn9ijB613XxcRbL0sCTR0Z9d/rDTyafHQKv+qjN6gQSXT2s3iju7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7983
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Menna Mahmoud wrote:
> 
> On ١٥‏/٣‏/٢٠٢٣ ٢٠:٤٧, Ira Weiny wrote:
> > Menna Mahmoud wrote:
> >> add a space before and after the operator, for readability.
> >>
> >> Reported By checkpatch script:
> >>
> >> CHECK: spaces preferred around that '+' (ctx:VxV)
> >> +		image->bus_resource.name = kmalloc(VMENAMSIZ+3, GFP_ATOMIC);
> >>   		                                            ^
> >> CHECK: spaces preferred around that '<<' (ctx:VxV)
> >> +	temp_ctl &= ~(3<<4);
> >>   	               ^
> >> CHECK: spaces preferred around that '>>' (ctx:VxV)
> >> +	cbar = (cbar & TSI148_CRCSR_CBAR_M)>>3;
> >>   	                                   ^
> >> CHECK: spaces preferred around that '<<' (ctx:VxV)
> >> +		iowrite32be(cbar<<3, bridge->base + TSI148_CBAR);
> > Similar comment to what Fabio made.
> >
> > But I'll add some formatting comments.
> >
> > It looks like you have submitted a 2 patch series which fixes all the
> > checkpatch errors in the vme_user driver?
> 
> yes, each patch for specific error in multi-position.
> 
> >
> > Kudos for separating out the 2 patches for the 2 different types of
> > checkpatch errors!  And for submitting a series which fixes the entire
> > driver!
> 
> to double check that i understood right, you mean I should create one 
> patch-set for one error?

No what you did was correct.  Each patch should fix one type of error.  I
only meant you should include a cover letter which explains the group of
patches as a bundle to fix the checkpatch errors of this driver.

https://kernelnewbies.org/PatchSeries

> 
> Because I have already done that in previous patch but Julia commented 
> on it that no need to create patch-set
> 
> for the same error.
> 
> 
> > But you should also include a cover letter for your series.
> okay, I will include it.
> >
> > How are you creating this series?  Are you using 'git format-patch'?
> > 'b4'?  If not using 'b4' I strongly recommend it.[*]
> 
> yes, used ' git format-patch` but I will try b4.

While I still recomend using b4 check out the --cover-letter option to
format-patch.

    --cover-letter        generate a cover letter

Ira
