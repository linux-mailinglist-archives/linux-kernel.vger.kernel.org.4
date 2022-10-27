Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D50360EDEA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiJ0CZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiJ0CZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:25:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B91A2ED67;
        Wed, 26 Oct 2022 19:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666837506; x=1698373506;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EOh4xVQ3BKJtalq/YdaZdDfUCGkVBDTrMeEEuli8TVI=;
  b=cFIOdwJx371R0CR7bERJDJRSsIKo0HA+KyOJeB1eaoHfPirlO/yRyf43
   mJzOb600libUMtlkQWWXPYue2ftEE8UA6rqfjl4d4fH0MJ9L8Q8dsulDk
   Vh1VJBpz7hlUhVWcWNN8AsZF5kkYdq4IL3IxC0LyLZsQZQiyT2tO2om1l
   Ka24KnVJoHfIAa/xWCgCt+W0dGu/ZZgrx+bFrPPwriisQ85traJOyGXeK
   v0DQDStPCSWoYZxFUzVVRpn0F0HFhfe//+DBfuTI3mgsI184n2Z8ZzygO
   F9nBkH+X7vEm8Z/hgZitgs6C1lrRdWOJpO/vJknqUx/v/Edu0eIRSc1gH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="288507584"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="288507584"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 19:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="583383529"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="583383529"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 26 Oct 2022 19:25:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 19:25:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 19:25:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 19:25:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvQAHvF980EeFjeC6kIrYrNYKAy7aduPc4u16gYN3z8pvE8sL1+1qFwREuc9MTAgT6UzNBuofLieY+EkIJJihgkREuFKC4zCYHj1X2ShrAY9eC4xssNL6860gUL1qV7UH75S/ObgW/XlHv/l94a0SJ5GY3DpoL5acwDLxchyu9VZbmFtfY8OKeHZzjSF706SsEGUGG3YRRsoybQUQO4LDXLuZJ28E2QDVkNIHuQ+3pRVbWHKa+1wmVwbs4ffBReaW5ATssFrbPXrFUdf9gjq4s2uoJQSUX17vzcTZs80lcbkvHCXC5vvRaAaL+uFSxdj8VPKJT+A2/zbgXgw7exA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfR4gYvGKQ5gxPvsgBubr86vfEiDHGySNQoNY04EVKg=;
 b=Br78QrRlj86uZqky17DpufQ2fv0p0SLZkMpFDUbxXPCdi5ySIDEfcpXKI/+n6/Stl6xJC+By3V8H6uepLgXnc5lkaXKA7TJXLJkWfRcKdnHwzs3FAWAfqRybfkrjYVd+Na/NweSWczmt1d9+Pn5OAYpCI7sO8vR630EGYPEFA9gn/82mMktpqPHexy1BLrMaIdsQi8JfHgOv4ulrAaF79AjerkszarNWsvXL/3kQfpC4kaDeoPe2jSrIdVnED7B19xBrkuKY74JHknJHbjDkwImMXlDZbBifeMSPnWn5f8HDkjQQZDqKQKkqzuHu73uLUi/IImgQVnse5Z4UEomdCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Thu, 27 Oct
 2022 02:25:02 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d%9]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 02:25:01 +0000
Message-ID: <2543dfb1-d9dc-0888-dbea-e420a19d732c@intel.com>
Date:   Thu, 27 Oct 2022 10:24:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [tip:x86/core] [kallsyms] f138918162:
 WARNING:CPU:#PID:#at_fs/xfs/xfs_message.c:#xfs_buf_alert_ratelimited.cold-#[xfs]
From:   Yujie Liu <yujie.liu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <fengwei.yin@intel.com>, <ying.huang@intel.com>,
        <fstests@vger.kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
        <linux-xfs@vger.kernel.org>
References: <202210241614.2ae4c1f5-yujie.liu@intel.com>
 <Y1kDEmLeRA2UGeF8@hirez.programming.kicks-ass.net>
 <Y1kiuTIYobR4nexS@hirez.programming.kicks-ass.net>
 <Y1nobODPLUjcteJ0@yujie-X299>
Content-Language: en-US
In-Reply-To: <Y1nobODPLUjcteJ0@yujie-X299>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA0PR11MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f18c8d3-7776-4bfa-91ab-08dab7c27361
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7uDjfzbTP6HlGh424AIBBroD2qqZng4974/80ivoZ8O3UhCGWxzkElc+E4tdO0pT3eqL9rt/c7rDYLU5NtNjQxC2PyagRN0XYOmxLSv4gayeKDMDTHgICWY80IKJAl0zhOPYocP+1UCFcIjLqsi6kqzOh7yAxCudMBH+Ce982+zLN5G1h6+G/RBKOMSj3XUyQgkvbqbebMntJ6ksn6rdIXSHu5z/+Psj1TUgY1RodC2hsiGb62hBW2Cmk5AYEQgA33WABdu+YihSIOVG+3oY4L1/ogcGOcv9IJ/1D9S9YB8ghnA7celVaJjvlGrP5mdc7z1MhBy9wm0+HtrTbn+L52BCfC3eAQbs8x+p6kpkEJWcowC1sQolQiCCEeX7PMApLAkmx9p/kwVkpB9lP9R0yxycELFspTFb4A8PF2RhDTdLGegvwHsdyr0NFW4iob6EM6R4W5/r/zHGW6Dt4HZa2CtfUdhnM/GTWjGAL78u46d1DdXxBtqHgf+EB2RxRjeWdbeBrDoTYcSZcSfi5WPUKfI70BZ3CPHKO3GxkboHVPwEOk5+OdNKD0a054v+TeFGPDkijacD7D8dsc9ru6gUUSXR+pCGytaypZ9lZ5aVfbpA00bRd8FaAsWYeF9m73SXWzs11E9NwR7aZwyIUhb4YIx+VCXhuEKWBbBBfa3Oji38xqVj97sjBstiAiq/jjAuECVOwYylpYXaWcS/Su+dX5EZ0+n8kHHzK6sm183NVyHI1Aenm0HzGajsV4NmafNyuHAh/S5673CO9RqWF70mp5OFCpfo1x0ttHxwtd7OvBLKuzWhT5H1wFJ+fhANtJ/PDBZzDqDYPVuc0GctyBJ3lL+nTvKebfuEx/fUJdcQu7hXUHiRoLW+ix+738Nk7Py
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199015)(966005)(31686004)(2616005)(44832011)(2906002)(186003)(478600001)(6486002)(6666004)(316002)(54906003)(36756003)(6916009)(82960400001)(66946007)(66556008)(66476007)(4326008)(53546011)(8676002)(6506007)(8936002)(5660300002)(6512007)(31696002)(26005)(41300700001)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkxzVHFXR1AvNTFlKzVFYnFwZmxtUWhjb20xNkIxQ3A2d2FvWEV2UjViSzlV?=
 =?utf-8?B?S3RlVnhQVjcxbmZucjRkWU9zdFlWcU5ZM3M4TTVBeUpaVUdNZmtyK1EvNDI0?=
 =?utf-8?B?REVzbnRhWWdtUVpYYkNOd2dDMkV2TTNnV0FGZEt1QWtMa2toYkxDMlJENk5K?=
 =?utf-8?B?MmxGdWNyK0tuL1ExSC9Vb2t3Sng5eDM3eHVjOGpiOVQ2alVCNzVhZzNvVXpZ?=
 =?utf-8?B?UFlkOGMvRjlza3FaSUlLRk16eWt4ajZzbXEzcjc1dGs5TW4vRmF2UE5yRFp4?=
 =?utf-8?B?cDF4b1l0MzV3VmpyUjdDTFRHbGdSQ3liRGQ5VFN6UkZQdG1jQkxCWnNtcEVB?=
 =?utf-8?B?QWZndHRySGw0aFRLbHl2R3BxVzZUMDcxcFRQUXE4c0svSk9ZemorUkhyR3BW?=
 =?utf-8?B?SzZOdWd2RzRvN05GV3k5YVNiZjdLL0duR2g0YmxrQnc3ckw2RGpVZ0VYK3JZ?=
 =?utf-8?B?blF5V0VhMnB5WWMvbFpnbEVMV2N6Tm9OZzBPb1QxUHdHOHhGZktJdjVCNW1X?=
 =?utf-8?B?ckZjblplRFg3THhEbUdUNzMwbFlRKzNsbDFmREdINUVHSmJoYjAzU0xHMnla?=
 =?utf-8?B?TnVqWnNKbzYyRk5JeEpRcEx3NFFQVzN1M1lVekUvVWpPS3l1Rmsrc2J3K3NP?=
 =?utf-8?B?cFhkRHQ4OHAzTjd2aDgvVDB5RU5jTFp0Tkd1VlUydUl5bkpzakRJZk81dHJX?=
 =?utf-8?B?YWhjbXh6OG13TVFwYU5aQVJocHhwMDRaR1E5UStUVGN0cjU1dG5JYWhpZkxL?=
 =?utf-8?B?aERKdG5MN1NpSDlUUUxMK1dKZnU4V2ROQ1ZXOHJ2NDZxNHZIZ2lvNVJraHFz?=
 =?utf-8?B?NE1RVk9DQUIwejBRaUJGTnNZRVpCNFJWQVRpakhhVVhYamRWMHB2Uno3Tlkz?=
 =?utf-8?B?VWw1TVFTcmNEV2lIU0V2dk5iRkprV2NvOUpDNzRpNmpvZytKL2hWck5HQXRK?=
 =?utf-8?B?K2ltc2xzenlBTDZDaEdTaWZnUTBERDAvbFpYUnJQb04zOXhpUHhrbVN6WTQz?=
 =?utf-8?B?VytRL0JsN014SWZTZG9LelViY1oyQ3N4aTd2Z1dRTXlGWkM0WlNZZlpwdXVK?=
 =?utf-8?B?SXN1TlRDaG5XQzZZeXlGK2dXd3NQdmdFdnl6VHVFbW9lN2d5UThleXJJY0JC?=
 =?utf-8?B?SExTUnFFbEJYRGFvUytmdGU5TnVkVTMxUGJxdU0yY0txWitOek9JdXNKSmhY?=
 =?utf-8?B?NUtsUWZGRituWWdGaTJrTkhpc21PV1QyQkdvdVVGcnlCQ05MdUdxOVlUMjBN?=
 =?utf-8?B?ZWJkM2pqaUZOSmVWcFBPYXEyNFlXb2NkV0hyaWhqREpwTk96bzdVdXh0aTlm?=
 =?utf-8?B?b0RFRFhVYkNVcFRNWVRsVmFLTW9ZODF1ekw2T3Q5OUpXYk53Um4xNFJxS0dD?=
 =?utf-8?B?bDhlbjgvTDNmRWpOWlVqSk5mQWZiL0l3ejlJamZySUlUM2UvUXoxRnN5aFpB?=
 =?utf-8?B?UmNUbEV3bVRRT2FmU2VOdFBkblpFNjdVaDlzNFJjV3dGZ1Y0NGU3U3NORVFz?=
 =?utf-8?B?c1MzUTkyZlpSUURpa3hIZnNJWWhZc0xSUnl4WUFHS3F5WjNybjdTeWVTdjJa?=
 =?utf-8?B?MHV3TlFTYmhVd2Q2VitDWDh1M1RIQkZxTWFvYThudkRYQml1cjdlMVR3Y0tz?=
 =?utf-8?B?a21vdTBFTFp2VnZkL2xYbk1zbnVDY0dHUkw5RnpSZDFRbldHRFl6S3EzYy9x?=
 =?utf-8?B?UXVZMXM5eXhJRXdSRnVXK2dqZk9TRytRbi9YSmduemlKN1FFb1JzZnZxMysz?=
 =?utf-8?B?MjNIY3p5bVRPWkxSRElvdmtycGRGRzk0NXBpNkJnQzlTdmdwTW05aGt2ckNL?=
 =?utf-8?B?SjBaT3BUTFMzY1lxYTZHYnFOMFUxa2xnTTlScGc5eE9rNFFXSVFORzIzZmZs?=
 =?utf-8?B?bWlIcE9SOW5rY2xVWGJPM29PNmZSZklCVGxURG5HM2lGaDdPQ3kvMktneGFO?=
 =?utf-8?B?OUl1R1RlTTZ2ZnhFYkhvMGR2R1pKUnhzczYxSU43ak14SXh3OUg1YnJHUGVj?=
 =?utf-8?B?ak5TL0x2UWJkSmVLUG4rRjQ3QTdzekgwdmdUckZEaDN3WnlpZTJMWmFUUUJH?=
 =?utf-8?B?LzNRMi9kRHAxdjZBY0hkSFdFRklNdVhXcC84NndFRXBJaUtVQ2Y5bVRHWHhy?=
 =?utf-8?Q?r8Y42Oxq80gUBBWzmAxBeGPq5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f18c8d3-7776-4bfa-91ab-08dab7c27361
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 02:25:01.6471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jw0VmMv7E4UlkM5XfRZJUCdl8LU2KyFzjZvWug29YpE8Kh1j8gwRDyqxazlJ3Eiipz9rbISiPfuBvaEZcD0OoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/2022 10:09, Yujie Liu wrote:
> On Wed, Oct 26, 2022 at 02:06:17PM +0200, Peter Zijlstra wrote:
>> On Wed, Oct 26, 2022 at 11:51:14AM +0200, Peter Zijlstra wrote:
>>> On Wed, Oct 26, 2022 at 05:10:28PM +0800, kernel test robot wrote:
>>>> Hi Peter,
>>>>
>>>> For below patch, we couldn't find any connection between the code
>>>> change of kallsyms and xfstests testcase, but we got very stable test
>>>> results. We tested commit f1389181622a and its parent commit
>>>> 7825451fa4dc for 12 runs each, parent was 100% good while this commit
>>>> was 100% bad, so we still send out this report FYI though we don't have
>>>> clear clue of the root cause. Please check the details below if
>>>> interested in further investigation. Thanks.
>>>
>>> *groan* I'll go have a poke.
>>>
>>> Also; I've had these patches in my queue.git for over a month now and
>>> this is the first report, how comes?
> 
> Hi Peter,
> 
> Sorry about late report. We did catch this problem on
> call-depth-tracking branch of queue.git in Semtember, but we used to
> think it may be a false alarm since we cannot connect the code change
> with xfstests, so didn't report at that time. After merged to x86 tip,
> we did more tests and reviewed this problem with more developers, and
> sent out the report finally.
> 
>> dmesg starts at 42 seconds, you don't happen to have a complete one?
> 
> Sorry for the incomplete dmesg. Please check if attached kmsg.xz helps?
> The time may vary a little since it is captured from another run.
> Thanks.
> 
> Not sure if this has anything to do with xfs or testcases, so add
> xfs folks to consult.
> 
> Hi xfs folks,
> 
> Could you please help check the original report at
> https://lore.kernel.org/r/202210241508.2e203c3d-yujie.liu@intel.com
> to see if can find any clue for the problem? Thanks.

Sorry, wrong link. Should be:

https://lore.kernel.org/all/202210241614.2ae4c1f5-yujie.liu@intel.com/

--
Best Regards,
Yujie
