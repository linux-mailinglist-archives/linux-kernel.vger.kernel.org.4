Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD15F968F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 03:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiJJBYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 21:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiJJBXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 21:23:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5C133E09
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 18:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665365034; x=1696901034;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RZnDxSlXws+u7NryGI3Unp/k+NfrvnZpoR5xp8G9HY4=;
  b=DCPubE6fLYtXUggWNtcc4RkmXl9T1o817ntmzgXO6WqoxLb0QclDMghT
   usq3Vv5RDmRGvLYdLG681XZzTNs8boOYdIWxj1WAMVMJdXa8zhLYwWSji
   LO5v52nVANckeHYuprH9oOPvBiZ7ugdzEpTbjyTji4FXN9TYs6ATD3YxH
   zeJgWvgUfcNpqDEg/ARToz4i+Hw2lova//S9pRZWzuhOlGKu+xxtVDxK3
   KapQJcg6xlxQPq8kNM2X8WHuLn0Lk2eN8kQTmdXMG4W2i9EHAVzom004N
   bapg7Vr4YY3Pa0pDGN1rZqg4JA7jpCGBV6CzF4HKmMDm2ohJryUQATWgP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="304104267"
X-IronPort-AV: E=Sophos;i="5.95,172,1661842800"; 
   d="scan'208";a="304104267"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 18:23:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="768220120"
X-IronPort-AV: E=Sophos;i="5.95,172,1661842800"; 
   d="scan'208";a="768220120"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 09 Oct 2022 18:23:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 18:23:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 9 Oct 2022 18:23:53 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 9 Oct 2022 18:23:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWz/8vX2jfZBgE43jsWy0K1eaXIIC/1t7cFMfFnMdNMdcJ4WLBcIr6oqljpDRHq6Xh+tORNSQwBmJO7paWGTGYe/Wovq7eWIlfQpmZRL3dNUDCVW/bdXCIJE1o6ckK7a/ZMTnwFhHPEQbVr66OzMswPBzXXG/jXgHPXtnDQECUAEucQPIU0q9SCISMLVzzUMBvbNkl5L4Ym9CcTI91iaacEEcqxA8VmC/hVxA0K2+uwKvBZrkSHF5a06b4//aafS1Z74wxquyUg5gYQZKUrDE8OsR9hPACrt6oOIQ6b0vXcp6m4KfK6R7soPQMZ60fUKSDeH3cjf5oe2KHVnR7r41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4TTNyWYZwXHYpf/cFLIsLasbnbKdfLPEkOcS84cLpw=;
 b=I645Tj8tJw02X/hV+coEke2UUxQLkFYsoeODiuaiqd/QKtey1PkrienJ1Vj8JVhinasyAtXbgPDHxOrVrNqkmF4TyRvpOs7O2wT0tTphBdKxC0K/p+YNVs0gfFEeDlRMueAX6PQaa9SiZaNd+rZT72n5H+7WDyI1SMqGjiqwm0nHiMrXJrMzO1GKJXHL9PDqdlRkcnRlBFXM9LHHEiEIXZTYS+xMdxmTTiqO6Bnx8pr+n3zU+ZV9BgffTJg8gPfpQYZ+fop8iku/b0LoOvZFA92VQGdU/iWy9zk3E+zA4UwNJ2xbmDgFKW0ZbK6RbdS6R50/31phKEkcbkX7y310NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM6PR11MB4722.namprd11.prod.outlook.com (2603:10b6:5:2a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 01:23:51 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 01:23:50 +0000
Date:   Mon, 10 Oct 2022 09:23:28 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH] x86/tsc: Extend the watchdog check exemption to 4S/8S
 machine
Message-ID: <Y0N0ENurfliW315D@feng-clx>
References: <20221009051209.393377-1-feng.tang@intel.com>
 <Y0LGLGW7RSlklKyl@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y0LGLGW7RSlklKyl@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM6PR11MB4722:EE_
X-MS-Office365-Filtering-Correlation-Id: e99770d0-e886-4d10-2542-08daaa5e162e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAzD3t+4uNfSlW+PMrV4lCfJzGO2tyrqP66eJ+RrP8aDRaGln/d5R9oQSBBZttPrFTDazVOCXeYFaHQKIg9lXUf5jM6lo8bH1NB7T19K1Ba1ohJD4SEgIIMC2ckXv3iB0e/71sNxET9kN+/LDMLaEJQ+T11UWGY8oFl2po+rZFwHgS+C98gUaGqTjidDivBRKUyZdJt291CKV/t1/yXh7yHa+97G1omb1qSuQZ/lKeSmVMBd/jOJaXz+ke003sGi3vp1z3TCFpTk/VB0K/6gzLfhONHJmmJGY8fJhxqU8d3wFoAUJA4kCJlFM7r1LlsDBOKsOGEZCNPoWvzDx2Y2t8VgzVysLL6Igcbp1pIu/LgdLrJQtq8ZPC/qQJ0X5gg3YL4ksCeKa68iIyGMmDN9beSdyKDK4Qvpc2aTpFMBUkRP8z9cIGuLF9GAZzhe3KuagwrpdIomwNMbMhcay+infvVK6f/JxZElOJdptL0pkYeXCEYv0e5UxtYAAoQjv9eIFqVunjJdglfXr5rfg2DPZLmIHUrd/UXal6uT9WRFwxJFY+Q+v1huI7i05ErybvoAFtZDN/74u9/QgXhrCaZ3urktyQBoJbVjeobADMb6+QlokySvt5htPXwbjyc0wIZe052W2ZacomsZbIViIPfIaljUqgbArAIr062lOVnhc7k4YJCoqWqjAgjN6Xt9fGSIK3SKN67vlM6apzWHtqYXEy26cRND5GmkdSz/NKLZEvu9Qy22c32hop/T25ZZBLSNQPSnawUwhf9jP3zc39BmAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(6666004)(6916009)(41300700001)(54906003)(5660300002)(478600001)(86362001)(6486002)(82960400001)(966005)(44832011)(33716001)(8676002)(316002)(4326008)(66476007)(66556008)(66946007)(186003)(26005)(38100700002)(9686003)(6512007)(8936002)(6506007)(83380400001)(66899015)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tYJ86Ee5xfcCJTLkFMJ6HNgjlthsDQtYlP8Vw/g50nFmHrVZoV0WC+orXcbw?=
 =?us-ascii?Q?8Wue2+/J+CphOgVIvyUgSPUpFVeTOrj61a76SWIO9rayhuCb5BcdQWTbuIua?=
 =?us-ascii?Q?QlLZlPpU7JSEpWffM2GQOdm6vYgnk/b64xjS/Nbtcuhvqtf0zFXKp2whtFG3?=
 =?us-ascii?Q?FjBZvVO02MdltR3Pv0csJK9B3fcCgj8fyUHQcN4FcGpfE0wnzR0r/GuEWeLh?=
 =?us-ascii?Q?zN54iaXuqTbUsRYXTVd0lQUqhgE2k/p3mv0qubm9pX9/ccfv3ZlWERx2thV3?=
 =?us-ascii?Q?KhjWUyzjbxhy/DlMfuX48e5tDBoXuJcoZZqHJW7fl41NAoTPHLw+wwtoyqT9?=
 =?us-ascii?Q?uKJoB0N91wo+etDJyBARtc10+zSUWLjNcngGLLGgfUND/Gal3QdsWtfoPQjn?=
 =?us-ascii?Q?qnWXg0c0dOoC/vFhD/kRhtvaHtbam7HwSC8GA+lpnviSSMTqTz56RYUfdeTt?=
 =?us-ascii?Q?bgrN+aRyMEQHEw/XFqYfZniCtDTJfSywoxnEkM7KZm04O2l9LPw8hCMOGcxM?=
 =?us-ascii?Q?nYR88hdpQpy2ayc7+Vj6MMAPk8EKTgNw4P3XMOMFis0Nd88819yHMyshkNZj?=
 =?us-ascii?Q?kYSjCYoU58/yYxJYQTtzpYaVt0Z7xkULDKxJYl1Un3ak2slyjIQL+1l0CNBD?=
 =?us-ascii?Q?JrJ2zyb89DEp72Ru++G6vX1o2yFPKXRDZm1IOR9a7RKhzThevfyHkcmc1xrs?=
 =?us-ascii?Q?0RAWZkKJteS4NUUlvjmxa/jcj6GgJtYHDFhOXwJo+85OzDzL54dXQAJMXsf0?=
 =?us-ascii?Q?Oc5oDeDHSXeIsWlhM6pgT3HrhvzzX1Rf4f/8xqnTdlzxwR/sEy039LXVZ1sj?=
 =?us-ascii?Q?6j55JaRpIIGFTfiQsDxv2gIyzEZqIHkxu1tBnEvQKpLFRcIydHdA7fHFnwe9?=
 =?us-ascii?Q?lnPKbIgPEZBdVSfT7XUtN3nL6hn1CL2BU7Cbp023HQTKIgoyHfgthCxKrkN+?=
 =?us-ascii?Q?YqxXyKljcHsCRXtGzrNFDSwMaFwxY0H4IJ9NBE+BR1XnR/Rx/1bqJldLQWQh?=
 =?us-ascii?Q?ByxobbUrjkTio8O3Qb/nkphlR8ha5YoP8SyA/etEztBW+4eLk1dqQFLlWgBm?=
 =?us-ascii?Q?08PawQVZ+50clQtZIPOjPOccNkVKgasWfDUBjApUsKL/IZyRdg5To09ZGiue?=
 =?us-ascii?Q?fxcZY/I5ec0X2k7q+KR2tdn+aH/tdzY97o3daiHkA4Q+H51J1ldv3IV1uU2y?=
 =?us-ascii?Q?+JLCpjxe1HMtB/UGtCjAkKikaLFLcBonz64+r4C8IeQe6YvBDjYoswQSD9G7?=
 =?us-ascii?Q?IgCPDLnsfXZzmS6Q5unWcSK94RJlWs6OLFCCMuAYThh8t90nipb6453AO3cO?=
 =?us-ascii?Q?drA9DxJOdD+FLRP81b4MyxUkr/bmmlZyQOV70H0ndnWzADsxQ+JzC/stmmf9?=
 =?us-ascii?Q?4utEFgDdRk3hq68ePz5ERKZJCjZ5DGGx66IiPqdLEi30Ay7kymAC8e1RscHr?=
 =?us-ascii?Q?TlcbIM5l3RUd8FTWbxwox2t2P1ggu4iq/9YA/jK5jQQet7ZOClYTlx9Qgem0?=
 =?us-ascii?Q?7UkLpgF+MXP1ZpHRIbGgOBD9f5ekRQmgGcnWl9Id6sE4+ipDjR/tHgT5Po02?=
 =?us-ascii?Q?OJvD1tD9SSUW1jKrlBSj6yzy5tsToHDCW0v/cpoQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e99770d0-e886-4d10-2542-08daaa5e162e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 01:23:50.3523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 185rPhtDcnPyZ4nRDH3CgL3lmMqe741WKoYzBCMHOqnzZPcSsEh5lc34oh4p/GuWQMtzh/nVDA2MWp5SZCUnMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4722
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 03:01:32PM +0200, Peter Zijlstra wrote:
> On Sun, Oct 09, 2022 at 01:12:09PM +0800, Feng Tang wrote:
> > There is report again that the tsc clocksource on a 4 sockets x86
> > Skylake server was wrongly judged as 'unstable' by 'jiffies' watchdog,
> > and disabled [1]. Also we got silimar reports on 8 sockets platform
> > from internal test.
> > 
> > Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> > on qualified platorms") was introduce to deal with these false
> > alarms of tsc unstable issues, covering qualified platforms for 2
> > sockets or smaller ones.
> > 
> > Extend the exemption also to 4/8 sockets to fix the issue.
> > 
> > Rui also proposed another way to disable 'jiffies' as clocksource
> > watchdog [2], which can also solve this specific problem in an
> > architecture independent way, with one limitation that some tsc false
> > alarms are reported by other watchdogs like HPET in post-boot time,
> > while 'jiffies' is mostly used in boot phase before hardware
> > clocksources are initialized.
> > 
> > [1]. https://lore.kernel.org/all/9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com/
> > [2]. https://lore.kernel.org/all/bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com/
> > 
> > Reported-by: Yu Liao <liaoyu15@huawei.com>
> > Tested-by: Yu Liao <liaoyu15@huawei.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  arch/x86/kernel/tsc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index cafacb2e58cc..b4ea79cb1d1a 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
> >  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> >  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> > -	    nr_online_nodes <= 2)
> > +	    nr_online_nodes <= 8)
> 
> So you're saying all 8 socket systems since Broadwell (?) are TSC
> sync'ed ?

No, I didn't mean that. I haven't got chance to any 8 sockets
machine, and I got a report last month that on one 8S machine,
the TSC was judged 'unstable' by HPET as watchdog.

> AFAIK there is no architectural guarantee for >4 sockets to have a sane
> TSC. If there is one, the above should be limited to architectures that
> conform. 

Thanks for the note! Yes, we should be very cautious for 8 sockets
machine. Will limit the max sockets to 4, which was also originally
suggested by Thomas.

Thanks,
Feng
