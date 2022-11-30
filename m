Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E1563CCF5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 02:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiK3Blb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 20:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiK3BlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 20:41:23 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E7973BBC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 17:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669772478; x=1701308478;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/UoOAd3GNMw7hOxVXfww7tCSSy80DspGBK3AFKRDcrs=;
  b=ZyrvYu2B92KJILslS1DPmmlFval8qnskEsjjxPdm/ZMCtfYcUxNEN1RM
   xz+EPv37cIaVJHQmEr5vz2uGTj1lG/gt2Cj58ohCoKb+3fkOJBNI9vTpz
   eJPVwPVBzOIfQPttE5Pe3HhgLp2pK1MLimD2rkb7uYert8a/zM7rWXoqc
   t1OwPlBUfZoQxqhQY6CDUlxpcLit72T/Smnd2asISjK+ok7m4JgayL5CF
   uCyikI39gYh6f7ODHGdDlHf4IYBq887tFwbDTKgFuTlVQpWYBKzCzorFA
   5TuM+SzdUQQNLeob/FatLIWf1MS2jQKNPHqLKHeSylRk6kk7v1InVTde0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="295641039"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="295641039"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 17:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="818445048"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="818445048"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2022 17:41:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 17:41:16 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 17:41:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 17:41:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=au816qdcOt1bncfnFPHFYnNjjjjbxoKke1KdVGVUergbyKeJVzYSlZ9ntzCcF5OdYsSZnLXaWqaGCfGx/a3H4jClRfQ6jgWEhii/PEIvUTVWgNn05uSYUE+2XrUHcnHpIXfkpEvTYW0x8AMxkxOwnLZZcet8rUNOmfMj7xLNFCAxo7qvs9kH4ig6UFbAZ2p8msVJOsa5Ox2BeJEM+ldwPgRz1gX1AVuNHQmCikJWIYpI6BMMIt8UtnHZv9jgvwFCEAwJcJ62hJdnEzswFdYGfBNwpPwjQMTB/47W8hAT1VIgOZ+AqKc/unch8pPmRQeNTs0bcBMN9sxzFHL7tEnytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvrUB5V0S20bJTH+E3nQ5UUT9pea1HosWjcQErXUE5Q=;
 b=mbjII/mbHa7291ijCcKizJyH8NcvseWEnYUpWQUGWaZKkqSXJVhK6EjPfh4huX8Di9bTaLBQdS+CnutXwZSJrXnwzPqIJJPxcABD7eyW/x6twLfva7/dBFSOpYfmA9XywWl9ORe2gSv5DumniSgRZ8dyH3XBEtFUi7k9eWmeKWXmhM46K1/xmGMgQTgOZThvZtmRluCbvhtHCC6Eb8CmPX9amJid/0Fv2zmXh7n1bF3Hd6ge5D+NLEu1e9NoO7oLBMh2FEomT4nzUIbcf3qOKtWU4fVSdJYSCjLUGBnb8BDQna12qVMHLpCp4RlIiKUk2GdtX18eq3I5g0x2ROr0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 01:41:14 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%6]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 01:41:07 +0000
Date:   Wed, 30 Nov 2022 09:38:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <john.stultz@linaro.org>,
        <sboyd@kernel.org>, <corbet@lwn.net>, <Mark.Rutland@arm.com>,
        <maz@kernel.org>, <kernel-team@meta.com>, <neeraju@codeaurora.org>,
        <ak@linux.intel.com>, <zhengjun.xing@intel.com>,
        Chris Mason <clm@meta.com>, John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <Y4az+FT5YjpAWjZc@feng-clx>
References: <87mt8pkzw1.ffs@tglx>
 <20221117230910.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3rMc2VbgVLHN9db@feng-clx>
 <20221121181449.GA3774542@paulmck-ThinkPad-P17-Gen-1>
 <Y3zxB6r1kin8pSH1@feng-clx>
 <20221122220712.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <Y32HFE+BaATh9+l/@feng-clx>
 <20221123212348.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4QZzzk+FdGj4AXm@feng-clx>
 <20221129192915.GD4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221129192915.GD4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d4fd66-1731-4701-2203-08dad273f2fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYaPu1DpX+mtvHj+WXN1UeLrA3YJDkJRWia1H/bdzu/GOInBOPLPTf9C39OHNNFlZJenGTUX8xczrSWZ4mN2H/zPwgd/xeoC3r9tVyTQ0XMv6iyvjX31bgaoTooSOHA8gujSsVGTkioDYUAaUa+H1VOxb/o5AURjYT7bEIVE4M/jUViaVyIYpYMdYgaD9KhtV6AXp9Ix9AU5dGBQet3cE0v1jFx0ikOVIDv7D+4DVgaECJie5ScbfnFdf2q4wsTr+4QXHNPxAD1saXNS+hSeDu7cL+c1yttL4tr/ZRR0+XT84yUcOAbq9bS9KuqnxXxacqGrWVglKw5hCYgnf8I/Hnq+/09KYLPk32tM0ambDg4khzSEVrBWuFFQBb1axQL7XHQaIWPsAq+RHihkBVN66w9Bx03Y7nifRH22EPCkgEgrZ/53/nmpH6z9KFdLikilZGKFoYB+L0+SL3atLrFC5HfzxSmd9HhfPm6FLFMTK+7Xiulq1yiLFkhhKdV4/4kt0ATP11IoWoG/L0V9ZOpJVsTc97doXNwykvwsKlbmSKFjw7wtnALYmeEgCMrC91N77rIT66sK2ISjHuPi617albfuBgw2txb34Zb6aiUgpwzQfCvOnr7KV5hJfsC/+NjmzpW2ZK+wwaao3VvIrqI8g+9cidfYtT0Ku6RpNqcyc6tdElPknICJA0j+lQCCd0nWAOUMFXc2lXBFJ3XuGgfMa7C3baGk1eAhZW/zkCCwJqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(5660300002)(7416002)(44832011)(66556008)(66476007)(4326008)(8936002)(8676002)(41300700001)(966005)(6916009)(6486002)(54906003)(2906002)(478600001)(316002)(66946007)(9686003)(86362001)(6512007)(6506007)(186003)(83380400001)(33716001)(26005)(6666004)(38100700002)(82960400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHQwQ2R2RVpEK3VsYlIxS3oxdGxHWXhVSVhrczVBSllBd2t2M1B0YU9KSVJY?=
 =?utf-8?B?amtrNVFjRFJwUVliSU9wakY3UUI0c3J6VVI5Nmg2SGl2QXRMdGU3T0J5eXUv?=
 =?utf-8?B?ODNGVlREM0VZdnlaQ0UvaEJvMTYyYUhSaGI4elIrY25DSUpacEZFNlhzZnI1?=
 =?utf-8?B?QTQ0ODVmRFdhaWhRVUZoaCtZV3dnWFdVTXlZdU9oTlN6VFB3VVRxR0gxTmZ4?=
 =?utf-8?B?V3pzdExFMHBBTllCTDBZbmx6MWd2TzBrVWxsYWFRamtnNXhjb1RhWm1UQ1VE?=
 =?utf-8?B?RDZ1c1pveGpvejE5U2s1ZHBNYVpmZnN3RTlrcnVpMmV4MjlsN1hWbkFtbExP?=
 =?utf-8?B?d0tjTGQxbXdIdkR1em1lbVYxRk5EbVhzYUcxSklORVBhM1A1dys4ejNBNjVt?=
 =?utf-8?B?RUhwa2RjSG1OOTkwRjBpRFNXc0JsR0twMTI5OUZkY3dHSUxrVFN6Ly9kcENl?=
 =?utf-8?B?ajhrcWFWS25sME4vdXNGdERONXFsbE1HQjFwU1BHTUxzV3AwSkpXcEg5ZXRX?=
 =?utf-8?B?SUN4cTlTU2lsb0IyZEk0VDRNVElsWW9uS1JvU1RTcjdsVjJkRTFKMTVTVi8z?=
 =?utf-8?B?c243RWlVWGZoL3Fja29pK1NmcG1XOU1SRjRSV0JVeGFkOGxSWjBTbWJ0eUto?=
 =?utf-8?B?YkhicHh0ZVlCNnEwWWpZMEsveWpsdmx1YjRtcjV1c1hYQkRTaXhmRkRLUXJm?=
 =?utf-8?B?U3JNbklXZXh5UGpwNk9IZzNYZ0pSVmxUQ3ljM09GS2NnSHRkaGN3eVVtSkJv?=
 =?utf-8?B?R1lhMEpTa0ZGbEYveVV4UUVVdlczQ25BN3RhRHd4V3JTUWhDb2pObjRPcHdm?=
 =?utf-8?B?RE52YytMb0RmM2RJL3hNRGg2M2FIL2RXNnBNWlI2cXB5cHJob2doeDRRRFBu?=
 =?utf-8?B?QS93N3J0Z2lnQnFMdjhSUTErcE9VWEN5bWVsMXNrcEZlbHNnWjd6SWxvZCtp?=
 =?utf-8?B?MXl0Nmg3MktHbVM4NlpNOEFkamZudEg1OXluTHQwSHhKdzFZei8wWkZRMHhG?=
 =?utf-8?B?VlZOU2hGVzRmS2haYXJmWHM5Q1l3S0tRMjNtbnJhbDdTY0JNcWxJV2FHV2Y3?=
 =?utf-8?B?RG56YVEzMmptSjBWQ29UeVpmZXFsTFRCQmpwdjU1dEFVSFV2c3VzNU5xQW1Y?=
 =?utf-8?B?djFIbDBUYVpodGowL3NwVWJpdWNxSXhBaGhEV0dTeXVwaUNhNVp1b2o4RW8x?=
 =?utf-8?B?NzY0RjFsOEVSYkhRU01MOXJjY25KaTZmZlJiUjhNRzFYUlRBaTg4dUVHeTNK?=
 =?utf-8?B?ajVkYjJHbXltTHcyWEErekdaakVrVk5Ld3VURzEvVGx2WmcyR0h6a09HMVp4?=
 =?utf-8?B?OHVKeW1wS3FoUnR4WTgxYzE0YURZSXFjYkpvaDZzcWRYQ3ZqbnNBWkhiV2VU?=
 =?utf-8?B?bXFaQTlwUHNxZVVSM2x3cEdCVFJFdEhlLzdGTEcrdlBNTmsrQ0xpNkUwc1ZR?=
 =?utf-8?B?dzlMdmc0MUNKcEkxb2tqeG43OTdyRkJOZ0ZwdmJnSVZGRTNoR1lmL1JFM2lW?=
 =?utf-8?B?SGp2VXYrMkx3R2tpYU9ZRUdoand2YS9jRC9NSHprbjFiNlRLcjh2MzZEZHlR?=
 =?utf-8?B?SDZFekU3TWpWMVllZnRBUE5OOWpJSTdta3VpUlJ0VXZYdFlYYVMyOEJRUmVQ?=
 =?utf-8?B?VXhnQWhDcXhUTTdjSk01S2dQVXZIYXVQNVJjVFZQNWdwQzdRU0d5ZW96MGVI?=
 =?utf-8?B?Y3lWZFoxMUY3TkRGMk9oNWRpUHAzK3JnUGp6amRxUGpZL3BvZ2xmL1UwK1Vv?=
 =?utf-8?B?S2pUVjZ1cVczeUdTM3dHSFE2SlVDZFNZWlJxSUtrdngrOGdqWEpoeVVIUWVo?=
 =?utf-8?B?MGxQc3lzL3Q2M0FzdGFHZkJZa3c3MlpBSVVsUExDNHVhc3BOaFkyYVNHMWc5?=
 =?utf-8?B?Y285QXp0bzNmc05HR2tVemQva1VTTm1jZ2p1ajJOZkkxSVVxTlBxV3JXaEcw?=
 =?utf-8?B?TlcrYkJCbi9saHBrZ3hncXpqNWdtdlF1dkYzRHMrSUozMitYUDVKbWtVeERI?=
 =?utf-8?B?R2gweThyYlNjTS9BeWFkd1EwN3kxc1UzUTZGbzdqeHRWOSs4ejI2NHJuZkpa?=
 =?utf-8?B?bUxwYWp2MWVCalpodmdMd2huMDh5a0NSVVVVbXE2YWpNUng2OWFtWEFEclIy?=
 =?utf-8?Q?OiXMQ4U8IkWp3tCwuzQ1OIOGv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d4fd66-1731-4701-2203-08dad273f2fb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 01:41:06.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stYwlfwZG1LrVcbSQm5siiJI1K4XPYl4zqF/TCy75wmbM/r32XpBDvvXwptDFZyRd6W5YZcvx1oNDNiiHyz5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 11:29:15AM -0800, Paul E. McKenney wrote:
[...]
> > > > IIUC, this will make TSC to watchdog HPET every 500 ms. We have got
> > > > report that the 500ms watchdog timer had big impact on some parallel
> > > > workload on big servers, that was another factor for us to seek
> > > > stopping the timer.
> > > 
> > > Another approach would be to slow it down.  Given the tighter bounds
> > > on skew, it could be done every (say) 10 seconds while allowing
> > > 2 milliseconds skew instead of the current 100 microseconds.
> > 
> > Yes, this can reduce the OS noise much. One problem is if we make it
> > a general interface, there is some clocksource whose warp time is
> > less than 10 seconds, like ACPI PM_TIMER (3-4 seconds), and I don't
> > know if other ARCHs have similar cases.
> 
> Maybe a simpler approach is for systems with such high sensitivity to
> OS noise to simply disable the clocksource watchdog.  ;-)

That's what the reported did, test with and without "tsc=reliable"
parameter :)

And AFAIK, many customers with big server farms hate to add more
cmdline parameters when we suggested so.

> > > > Is this about the concern of possible TSC frequency calibration
> > > > issue, as the 40 ms per second drift between HPET and TSC? With 
> > > > b50db7095fe0 backported, we also have another patch to force TSC
> > > > calibration for those platforms which get the TSC freq directly
> > > > from CPUID or MSR and don't have such info in dmesg:
> > > >  "tsc: Refined TSC clocksource calibration: 2693.509 MHz" 
> > > > 
> > > > https://lore.kernel.org/lkml/20220509144110.9242-1-feng.tang@intel.com/
> > > > 
> > > > We did met tsc calibration issue due to some firmware issue, and
> > > > this can help to catch it. You can try it if you think it's relevant.
> > > 
> > > I am giving this a go, thank you!
> > 
> > Thanks for spending time testing it!
> 
> And here are the results from setting tsc_force_recalibrate to 1:
> 
> $ dmesg | grep -E 'calibrat|clocksource'
> [    5.272939] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [   16.830644] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76450417870 ns
> [   17.938020] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> [   24.548583] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [   49.762432] clocksource: Switched to clocksource tsc-early
> [   50.076769] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [   55.615946] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> [   55.640270] clocksource: Switched to clocksource tsc
> [   56.694371] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> [   56.724550] tsc: Previous calibrated TSC freq:        1896.000 MHz
> [   56.737646] tsc: TSC freq recalibrated by [HPET]:     1975.000 MHz

Looks like there is really something wrong here. I assume the first
number '1896 MHz' is got from CPUID(0x15)'s math calculation.

I thinks 2 more things could be try:

* add "nohpet" to the cmdline, so the tsc_force_recalibrate should use
  ACPI PM_TIMER to do the calibration, say a third-party check.
* If the system don't have auto-adjusted time setting like NTP, I
  guess the system time will have obvious drift comparing to a normal
  clock or a mobile phone time, as the deviation is about 4%, which
  is 2.4 minutes per hour.

> Apologies for the delay, but reconfigurations put the system off the
> net for some time.

No problem at all, it's your holiday time! Thanks for trying this!

Thanks,
Feng

> 							Thanx, Paul
