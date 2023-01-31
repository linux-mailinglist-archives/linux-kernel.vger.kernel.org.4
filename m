Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33881682454
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 07:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjAaGOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 01:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjAaGOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 01:14:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7319F3B3E5;
        Mon, 30 Jan 2023 22:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675145677; x=1706681677;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=v7zpthaWfqFLVy9ZyLZWz/mqaKXkRwyi+ubZUQuSmYU=;
  b=JZTRLg1Ejn5xzYQEEwPjh/wFKja8L0IQGAPigPZdfxdpB6Cl8pw/Ykok
   aoav9hgkPOaWPzzon6jjr4PMyUlGutUB8iqUDxHa1RgXJsIN0tJbX/lEG
   GWZe1Xu3HdyPWK+lwW4/WVXrwV+u+eKJGDvWg0byY7/V908LTzWspgwyH
   qX5oTh3VqdVmgTJp9ku09kBQDhdC6yUKdFSCWvAgCynGf/UEVChRZ23H7
   zlkhLR38O/VbNPDxOLi2D+1ImpoOxBZ65SJn1wCm1D0kMt3UTSLQaxkx7
   ooMdghVMzah0Cs/oX4tPHqDPumG7rg6FGdj4pZ6qKUgGHLTYJ1FtuGNvE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="329032410"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="329032410"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 22:14:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="664371554"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="664371554"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 30 Jan 2023 22:14:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 22:14:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 22:14:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 22:14:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKCLWcVjtRvGypvVk7/YwayhhP6u3wtp3oyaSmfJT3aGH1Oy4K3KnXxjUcuvWys8owTfMHxNA8z2uWigWmFHLNQ/284A5ZMqchE+VJr1ql2qSN9XgOrFkV/rs2nC6pzuKTmNi4OTk9y4EY2mfueskyaXYxVDNlJCniJIAeHt9ia912+3eZdHUJR83ZkonzjfsR43s26y2keEqlvaQAVbLBT3hI4rwT30oGyCCoXGqM4pps+1xkkjY3SC8BTbvvQulriqvVHptKTJjtgd1wRDaHlW0EWbJwFohnI8463b21FlcbWJ88gIGrRvjQ6emqfY3rHZfJr/DagdwKzARWVFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUmtH+AHkPFzdXEoc7oD8zN4+4H7JX7fT2aKp+VQuhI=;
 b=PvX0/PCJypWsFYd9SQw/N1NFVx1F/0Bz8YkDp8sVAHjCIeX+BxJCH85T3TSkyQ/zH2O+847Rc8gT7ru0mp6gVcVmvrNqZg5dzF/6kcZAY5xoicz/tNJ2qRyERjxer+UUZlyMapqNYvRi1sCiTdRb1Rz4IUlyN+YmbR4tTreAQvP20Ed2bCEwDVwxHcYayYfr6JjNtHc4stS23kidkBBsJKURX4J1JhWsrNlrOd8nULNwMeqMprjkQHhTCfxBOC15XSL0TFUApuJWEIfIih37Ea8h9pwLr0MMjP0m6MCRmUtuiK9mXA/3Y4IkjTHESRh/qfgxX5c4kHIlRaqzFVHZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM6PR11MB4514.namprd11.prod.outlook.com (2603:10b6:5:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 06:14:33 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 06:14:33 +0000
Date:   Tue, 31 Jan 2023 14:11:58 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [linus:master] [mm]  f1a7941243:  unixbench.score -19.2%
 regression
Message-ID: <Y9ixLimDNWk9Rf6o@feng-clx>
References: <202301301057.e55dad5b-oliver.sang@intel.com>
 <Y9dETROtv9Bld9TI@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9dETROtv9Bld9TI@casper.infradead.org>
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM6PR11MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dcf071e-3993-4308-4185-08db03526b68
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/WTKLg+nYcsBQaVzDg505zmEuchGXv2lTXzVKsao04Dde9Os5vbFZoGTUtGLxQUKzeZ84JI+OnQZlmXfIMKTWmUP6z3rvjfkBk0dJ+9jgnYf2R4xHMrT7spAU6eiV9EOc3+vWVbNYXBigYP6hPbMUbXOwC/ncxXD0k8qZedCjnTbwM6oyDMn5z7DMLbKVA2CaAV/jMeTnYnksUHB70nuHhNSN1XEB3H07iIqDmrTcKTh0btt/B2cCDVj+PzFdbUFMD7nDM9UYpHI5/yklX7wJ5YqdzP6UKOpksCqiAfczcFCGEWYu/3bKQ0p7X/y0rOp0oml1u4uKXQVS6lR3AcwQ0COpR7qgv1uxaT84ZA+klSMKsW67KXZ0wbMDxmoRFNDUSEPK7HsPibHNzK6ya9Qn0jOJrKNcEpxHY181TPZKimDIcuWXTUuzc0S86dqQ3CI9zW2Wm+7wyPGaSQCtvW+gH+a/XiIJHn+CafEjc8jmbWIGCxeEZiRxVZxRNYABCwJ3TcgJoFWKOXMJR9ih0crgIGpvkBRq7SKpzGyb6CajkY9HsVTq5YGwME7XY3XgGjgFfJw3jSVmDDrP9lcr+AuhfLGMkPoU7sDsxfbB0VzN/+fwgSPTIhQ0Fqe6yfY8ZEvJebn3cdZ57rHbd9YkLk+KzFrHEqZ1UkCEOBwTnJK2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199018)(8936002)(41300700001)(44832011)(66556008)(5660300002)(83380400001)(86362001)(38100700002)(66476007)(82960400001)(4326008)(6486002)(6916009)(8676002)(316002)(478600001)(54906003)(66946007)(186003)(6506007)(966005)(6512007)(26005)(9686003)(6666004)(33716001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3lmaGdBeFNOOCtLNXZLRTUwa09YL3JLN1VNRUlTQ3lKM2tyNXRtbnljMlU4?=
 =?utf-8?B?MWh6SG5pbjZUWFdHSDVoVVZuN1p1N1dKb0EyK016SHE4VVNvRzVpUk0wbzIy?=
 =?utf-8?B?RkpLcUxzRXB3RVlDNWphVzJkdk15b25PcVg4MmpEbzJUZDBFRCsyUkltYkFi?=
 =?utf-8?B?RFQ0OVFCTWZNN3NWR1ZHUHJyenJrWWphd3VxSG5maWVDdlF0b2tZNC9rcUx2?=
 =?utf-8?B?cE1LVHZIWUFSazFvcUQ1enNOKzhBeTN2QjEyVms3VjVtK3A2RDU3SmFaUW9k?=
 =?utf-8?B?VEliQnZFSHo2U0FYWTVOODlUWFh0Wm93bXhYeUVPaEUzZW8rZU56L1RSZTJY?=
 =?utf-8?B?MlNudktNR1dTVXVvL3UxdFZDOFc5TWtCendWcVVnVHl4L1BWc2crcXRGaUJO?=
 =?utf-8?B?ZlhNRHlaNkdVWVFSUlpCeFhVZHcyUjJuWVVjSVpTeG42M2d3bkV2dDBOUUdy?=
 =?utf-8?B?QTFoQWNqOFFGRFFqM2ROaXlaVFZOcFA4YnQ4WlpscFRxNU1jSWVHS1UwK1ls?=
 =?utf-8?B?SC96UGpsM1E5TUkyTUVNQ1FEeFlQMWowYkdNZlhLK2ZmbzRzOFFhM3ArQUVs?=
 =?utf-8?B?b0dpNVlEL2dHc1E0aHlwa1J1eEYvOHZLbUgwZnFrTmx6YWYrZmhmWmprWThx?=
 =?utf-8?B?K2VqeXRUR2FtR1dKN3pxamFRdUtUU21oYnZYcHVrakZUYllMaG1COUhvcjlE?=
 =?utf-8?B?WHU4TS81VG43SWxiL2lUQlNERlFPM0xZVDNrVEZuanNGcUd6MmpScFlkb0Ix?=
 =?utf-8?B?Rmc0SXovR1FlaUNlZm5VblV2ZnVvUDVrZzFyenNvU1ZjcjVIR21MRjh1cmJI?=
 =?utf-8?B?SnUzOGNPRjhPc3QwY0JMWjZKMXI2aU9wTTBucE9nV1ROcGpaOWlUWmw3bnJx?=
 =?utf-8?B?MWlGSlNPbi82V2Z6ZnNTak9SMXNBOFRzcjFla3M5NVlmMzdmbzVpZEx6d29t?=
 =?utf-8?B?ZkhxVEJYSHpjdXhwSkJyVk5jTVdQYVlOTm9PRzhaVDB6UVJRM2RPS01PSHlP?=
 =?utf-8?B?dFRTTkR4QnNwNC9VT3ZUQncvQ0hyYWVCaHNaMkw1U29JenlrTml0a1RqZFY3?=
 =?utf-8?B?bGRValhvY2NsQmwra0pydXVGTmRHR25tbjhnQU5HcXU1dm5hdmpUQ2ZiWE1m?=
 =?utf-8?B?R21iMHNTQU1jVHFSTzlHL3Zkd2FlRHg2WjNiL0o0TUF4dktBbVlKZm9oUUFk?=
 =?utf-8?B?QldRaU9RMVppSndGaHJEaXBTZVNMOVJrQmRsUzVCeks3ZUsrcjJmYmFyRndP?=
 =?utf-8?B?WHUxM2FIKzZsQWRtb0NUZkdJcEZRYWlzS1NJMEV1aDl1ajFjTDFqNU80bmFh?=
 =?utf-8?B?Y0tsb2NjRmMrZHM4U2RTSnEzOW9OS2hXa0dDM2xvWXpYN2JTTDRXQlY2aTNB?=
 =?utf-8?B?OHJhdnV1eDZIRktVUlBmWDRhcy9GMzZpRkEyR2tlWURqQUl6ZHlXdjhPbXhF?=
 =?utf-8?B?dzlkcTNtd0VOUEFZa1p0SHZJSWtoVlhzSVQ5N0FaMDNXNjdVcGkyQnZRM3JI?=
 =?utf-8?B?dDVXMDVZdGJLQWIxNHcySWRKQ1V1eURLYy9wRUFjS2lUWEM0dVM1SXR6VVFi?=
 =?utf-8?B?blNKa3VXZzYzWVhwNFQ3TDVxMGVVNzhzL3FwY3d2SjNyOVZ0b0xwQUdBK2x6?=
 =?utf-8?B?dlUva040dXB5QysreDN3VThwZHhZaHB3MHdHQTRDblNuNVdrcVRSdjJrbmpD?=
 =?utf-8?B?NnFZSDMzNE5XckF2S2lnNXdQSk00RGJtempyNThIWkxVSHFVa1BqUFBiUi9U?=
 =?utf-8?B?dmpMWEVCanpFSG9FKzJ5N1NtZDZ1VGdxcmxVQ3dhb2dMQXlVRkJZYlk1ZUlJ?=
 =?utf-8?B?UWVuSmhkdDBXbjh6ZUFoTXJRUXR0Vk1OUEU5MnE4Tnh6VnIrMG5JT1FvOVdP?=
 =?utf-8?B?UzZtQW1IWnBjMHVCWjJBV3B3aHMrQ3ZyaEZKaVFYd3ZpNktlSzVJdERDU05l?=
 =?utf-8?B?ZUZ6SlEyVG14ci9PbklkMW9lV2ZEN0lHNmdCSDlYRXpXMmxQUVBrcWtBRnJS?=
 =?utf-8?B?ZUNoZlVjN1crclJWaWdYeW9hZDVMWXFGS1poS2o1Mk0yTU45V1poUjFVUkFO?=
 =?utf-8?B?aVduMkJaK1JzcCthZ1cyTnpZbVpLMjkwUXBlSlFWbFNTU2d6MnhxeEM5ZHBt?=
 =?utf-8?Q?iSil5S+FRPvK+ojM291XKtluu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcf071e-3993-4308-4185-08db03526b68
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 06:14:32.8971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3cFo85vYS+0SxmjSoZStd4EOtO/O4wsIX+vqwgBO0jLk3Fj5P9fBTqt3jkD7kPx+ljn01QH+Y3hnUFe8M5PyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4514
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 12:15:09PM +0800, Matthew Wilcox wrote:
> On Mon, Jan 30, 2023 at 10:32:56AM +0800, kernel test robot wrote:
> > FYI, we noticed a -19.2% regression of unixbench.score due to commit:
> > 
> > commit: f1a7941243c102a44e8847e3b94ff4ff3ec56f25 ("mm: convert mm's rss stats into percpu_counter")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: unixbench
> > on test machine: 128 threads 4 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	nr_task: 30%
> > 	test: spawn
> > 	cpufreq_governor: performance
> 
> ...
> 
> > 9cd6ffa60256e931 f1a7941243c102a44e8847e3b94 
> > ---------------- --------------------------- 
> >          %stddev     %change         %stddev
> >              \          |                \  
> >      11110           -19.2%       8974        unixbench.score
> >    1090843           -12.2%     957314        unixbench.time.involuntary_context_switches
> >    4243909 ±  6%     -32.4%    2867136 ±  5%  unixbench.time.major_page_faults
> >      10547           -12.6%       9216        unixbench.time.maximum_resident_set_size
> >  9.913e+08           -19.6%  7.969e+08        unixbench.time.minor_page_faults
> >       5638           +19.1%       6714        unixbench.time.system_time
> >       5502           -20.7%       4363        unixbench.time.user_time
> 
> So we're spending a lot more time in the kernel and correspondingly less
> time in userspace.
> 
> >   67991885           -16.9%   56507507        unixbench.time.voluntary_context_switches
> >   46198768           -19.1%   37355723        unixbench.workload
> >  1.365e+08           -12.5%  1.195e+08 ±  7%  cpuidle..usage
> >    1220612 ±  4%     -38.0%     757009 ± 28%  meminfo.Active
> >    1220354 ±  4%     -38.0%     756754 ± 28%  meminfo.Active(anon)
> >       0.50 ±  2%      -0.1        0.45 ±  4%  mpstat.cpu.all.soft%
> >       1.73            -0.2        1.52 ±  2%  mpstat.cpu.all.usr%
> >     532266           -18.4%     434559        vmstat.system.cs
> >     495826           -12.2%     435455 ±  8%  vmstat.system.in
> >   1.36e+08           -13.2%   1.18e+08 ±  9%  turbostat.C1
> >      68.80            +0.8       69.60        turbostat.C1%
> >  1.663e+08           -12.1%  1.462e+08 ±  8%  turbostat.IRQ
> >      15.54 ± 20%     -49.0%       7.93 ± 24%  sched_debug.cfs_rq:/.runnable_avg.min
> >      13.26 ± 19%     -46.6%       7.08 ± 29%  sched_debug.cfs_rq:/.util_avg.min
> >      48.96 ±  8%     +51.5%      74.20 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.avg
> >     138.00 ±  5%     +28.9%     177.87 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
> >     228060 ±  3%     +13.3%     258413 ±  4%  sched_debug.cpu.avg_idle.stddev
> >     432533 ±  5%     -16.4%     361517 ±  4%  sched_debug.cpu.nr_switches.min
> >  2.665e+08           -18.9%  2.162e+08        numa-numastat.node0.local_node
> >  2.666e+08           -18.9%  2.163e+08        numa-numastat.node0.numa_hit
> >  2.746e+08           -20.9%  2.172e+08        numa-numastat.node1.local_node
> >  2.747e+08           -20.9%  2.172e+08        numa-numastat.node1.numa_hit
> >  2.602e+08           -17.4%  2.149e+08        numa-numastat.node2.local_node
> >  2.603e+08           -17.4%  2.149e+08        numa-numastat.node2.numa_hit
> >  2.423e+08           -15.0%   2.06e+08        numa-numastat.node3.local_node
> >  2.424e+08           -15.0%  2.061e+08        numa-numastat.node3.numa_hit
> 
> So we're going off-node a lot more for ... something.
> 
> >  2.666e+08           -18.9%  2.163e+08        numa-vmstat.node0.numa_hit
> >  2.665e+08           -18.9%  2.162e+08        numa-vmstat.node0.numa_local
> >  2.747e+08           -20.9%  2.172e+08        numa-vmstat.node1.numa_hit
> >  2.746e+08           -20.9%  2.172e+08        numa-vmstat.node1.numa_local
> >  2.603e+08           -17.4%  2.149e+08        numa-vmstat.node2.numa_hit
> >  2.602e+08           -17.4%  2.149e+08        numa-vmstat.node2.numa_local
> >  2.424e+08           -15.0%  2.061e+08        numa-vmstat.node3.numa_hit
> >  2.423e+08           -15.0%   2.06e+08        numa-vmstat.node3.numa_local
> >     304947 ±  4%     -38.0%     189144 ± 28%  proc-vmstat.nr_active_anon
> 
> Umm.  Are we running vmstat a lot during this test?  The commit says:

Thanks for the hint.

Right. IIUC, 0Day normally will run 'vmstat 1' and collet info, and
also read /proc/vmstat and /sys/devices/system/node/nodexx/numstat
per second.

>     At the
>     moment the readers are either procfs interface, oom_killer and memory
>     reclaim which I think are not performance critical and should be ok with
>     slow read.  However I think we can make that change in a separate patch.
> 
> This would explain the increased cross-NUMA references (we're going to
> the other nodes to collect the stats), and the general slowdown.  But I
> don't think it reflects a real workload; it's reflecting that the
> monitoring of this workload that we're doing is now more accurate and
> more expensive.

We tried to disable the 3 types of 'vmstat/numastat' monitors
mentioned above. And the regression is still there with
similar rate around 19%. 

Thanks,
Feng

