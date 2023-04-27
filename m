Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BBE6F0F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344401AbjD0XgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbjD0XgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:36:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAE3273B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682638575; x=1714174575;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3foHDkFUsO6dk5FKgmLZgyohSl/gapXlTXjwMqnGVf0=;
  b=Nw3Dv/7nCbjVXuvmPqIr50z8kiL0AqLIenOn6J52Df6iYNJ10NJVA1YI
   Sjy3qpETjrZzRumVFfbcyfwJbtVyFMC/jdSSudI4WmVtMZn3UKnnbNe1E
   Ws7xigLbXY7B/P1iAtuqbmCPDWyF0GiceguWSNyuif3zlX0cd8lx/VXHT
   bgF9qm9ilM2CTPvFwa6eQTFfmZm2tsk5aP/iE+bGOdmVEdXZYAIAY8plk
   lXadgtN4sWhfVljmtayHF8mt7YxK7mhCohmh13DfFJqQeI7JGujioP9/2
   sXf/6IdJgPeNYt4kx8HAb6R+zpDiUO6kKE4NFhppge8W8iCNW/y6v8Ovt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="350506076"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="350506076"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 16:36:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="838626418"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="838626418"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 27 Apr 2023 16:36:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 16:36:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 16:36:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 16:36:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeMoy2zje5blhkLgKkmdEjz+qIxiK3P0yjY8hZj62wXrdBPKziQlaEy995epsa31Fy+XYmKELBmYLKn/9G0fofkRie13phO5JzOSswfbQZJ73vaOBggN2T+iQ4d12rKLaQho4s0FhKP+kZOhkHkPuamaHfTe12jcCcblOlXKGVYLcbVazICnwbd5Owrur5Jia1LvXt17/RQ4E3OFegd2JNjioTGwoDBHb4qFzOmiyITwgTek/5VvGf4P3LIi6PmCVYyLQnHhgNoy44guWcAX1l6zLcaqKmGhCJRrbpVTbgTVNwvtK6kSElhQcFTFbT+3QBSminxYKBhk5CWReoGJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btyoIEyxtd4yIB0TFOdfs0Z/oFeKZt08UswdSx1OxZ8=;
 b=HeCD51iOT8VhqjX6/2Fl8LZ/vDWTm56a2n/WYkuQO4/chdOezzcJJmycCs29dUaEmiPmUCFdpgMFrni6lbkDAIhY5ssCr9Lvt59klfbZm0jW4563yaCSJ7tMzWruB1hmRKs3ySsS7I98XZM5JNRGGv0mLtGR723+HKO0qviOU+rc3LNvlij2y/XpiOOYJmA41cabiqjJApa3KNrhc+pSevx81efIvXSBvdQJdjX6AUyBS8TnNSBpUhFbpcpS0Mqqaj3PyF8lCkxiSTwhKy7K0Im0Nw3YN8A5tET328l9uorjeeYZvuC6u4386uXRobE1FCPJjC2jk0PrJvrBZd4mBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5460.namprd11.prod.outlook.com (2603:10b6:610:d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 23:36:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 23:36:06 +0000
Message-ID: <c099e82e-540a-c4e4-2efb-3db24481a64c@intel.com>
Date:   Thu, 27 Apr 2023 16:36:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v3 08/19] x86/resctrl: Add cpumask_any_housekeeping() for
 limbo/overflow
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-9-james.morse@arm.com>
 <3145caff-4e73-0ef2-5bc2-70cdfe7953e9@intel.com>
 <78256a0f-d6e2-9c65-610d-ff962fdfed5b@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <78256a0f-d6e2-9c65-610d-ff962fdfed5b@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4c0e44-3e4a-4414-a681-08db47782bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIp22BFtWTkZDE3GxVRUDmE9viALeQRvKpluEI4gVg31d4BQwFO5E+JfUWgTQY14deNuOFebxWL81vKunpIshSy6Tck1oGGf924Qf0teL/qHssK+HxCMp6AP8JsPif1UdTrcogMaXdbFacmUP8QFvnYceCPMJMXazSvNM/wXw1Nv+WziQTNKmqHTQXHiQbdLKhngtKU/Frlmat0AEV2lK69c8JElI22ZG0v3Q8v3TwExyJxHfTVaiIOKd85/GHIjE9ozxBRStrDjtSZjM/pOO7AbeAOYl+UEeTxwalZpjkuSeVdFGezJ3rh7x9rYnPmkQtNevQoLN23KJckym1wa8cIX0a7MLd5c6qqFbldh+45ToDDSnBYYKCMr1qPkxQXNBtcayr+EvaxjYnkDXonaSebJlUtFFSuZFBoPPpz7+CEbJcBV0bPVcM8rkkT0Hy1TRJ6Wc2wWCnfWQmj7InNcMADdpfEcEnG5s+Pxga8+wpjqCz4WYuhe5/BUqcJFYZgQxnzXJAfk71dSHp2qE5CMoN2XYKHtFOoAAVETF5PYsZ0aBAi0eHdLDnie/LEgAV1gsI6Pb3VtzPicwkUagu4ocTxG7LTN9F9pM1fM3IP7ekrBpeAS/GSQpi7qUDkyberedUcTtR0C7S1nUZuN/agMmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(26005)(2616005)(6506007)(316002)(66476007)(41300700001)(31686004)(4326008)(66556008)(66946007)(31696002)(82960400001)(83380400001)(6512007)(53546011)(186003)(86362001)(6486002)(36756003)(478600001)(6666004)(66899021)(5660300002)(2906002)(54906003)(38100700002)(8936002)(8676002)(44832011)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnE2UG5ibXN2Y3dqOWNiazYwVWlFOWNzeXIyQkRSKzBWSzFvazN3cU1RUXZZ?=
 =?utf-8?B?Wm1DcFYrWjNQMHN0cWpQYlhIKzhiV1FNYlNXM2dDUmZkY2p1NE1Ib1FmclF2?=
 =?utf-8?B?QStHeXVZTWZOcTBWVHVUOHpwN2VmeWFmOENRSzZEV3kvL1JQZytOL25qOENG?=
 =?utf-8?B?VUxWMG8zcmxWU1NrTmg0Vm1rU0ZnZm9mZ1NIdjkxSkNYSTNqL1VIeUVGOFhY?=
 =?utf-8?B?a0RFeXNnaDZVVWxWbWJFVE9OQzFqejRGcHowOTZsTFFDNGFDQVA5THdNVDFF?=
 =?utf-8?B?QTFXTUJmOHMzcW43UGlxandjRU5LckV4bG5YSnlUTk1NOWROR010UGlDQkxQ?=
 =?utf-8?B?MllqZkR3SnM3eDd3aGd1VDNTUFlaQXFxVm03VGg5c1M5Z2w1Z3ZYRUd5SXlw?=
 =?utf-8?B?WEFhWjFhVzJKdjJTdGtKQzhQZUF3ZFk3NlhEVDZURkVob1BvN1BjdDdab3FD?=
 =?utf-8?B?RE1qQzR4eDU0QWsvRjdHbjFBa1lSbHAzMGdqb2QvaVdBL3RmR0xuZTY0OFha?=
 =?utf-8?B?Tkl3MnBXUHNXRENNT3dCRGw5NFo5RnNkMzhCZDhZLzNBUVdxVzVER2prK0NM?=
 =?utf-8?B?RllIWEh0K2lXbkRyV2VoQjg1cGpmdkNGWmc3eThtdFJhYzJLNUt4VzJUdW5E?=
 =?utf-8?B?bVJDbUppMWNDVllXV0c3REswblcwdTMwME5iQmFmeEF1MUdJK1lCalc0SS93?=
 =?utf-8?B?Sktsa042dm5idFk3QnB2UFhTU2N0MzA4MUJtOXR1b0hTdVdqMzkzdWVGQmdQ?=
 =?utf-8?B?UDJZVmJBTEkzRWVrb1ZNclowSnhNdjZiRGNDem1iWUx3YzhiRHU3dDZIb3R5?=
 =?utf-8?B?SGc2N1RrNGtsOS9EMURHcVdJc2dpRnVSMjgzOXUycmEvRGVCUzgrMklUdUpy?=
 =?utf-8?B?Qm9EM1E3Mm9YZDg4azRMK2RXKzBOU1VvYmRodm40Z2ZXSUdBTzMwMzRCQ2wv?=
 =?utf-8?B?dVlGTHhZVFM1YldhQXdIMkxhY0lQeXk0SlExVEVYTXhPWEdsb092QzJpWGY3?=
 =?utf-8?B?aVdkMzhsNTVGbUZ5aEdzeUZHZWRFN0JBeU1TVVgzVnJMYXFkckJZQWFRdExs?=
 =?utf-8?B?em5vZE1SZU0vRktLMUZpTkJpZStOVzJLOS85SGg3VlJYZDMzNDl6T29GUllO?=
 =?utf-8?B?bUlYT0tkc0lRb2ZYNHlXV0I0a0ltREpyc0Z6cTdkN0hvNVRIMnpqa2NWT0U3?=
 =?utf-8?B?WUxiZkxSaWRQaWRML21kVnE2VFNOS1RsNXhCRmlBMzBxRXhxTWowVzJyR2xt?=
 =?utf-8?B?OXQ0dm1XQy93cHVTdXpyQ3FITVdXZHQwL2pNQ3lMZHp3M1lMUzlReEFMQjFh?=
 =?utf-8?B?NC9uQmNuOExvcUlSMU1NVklyS3dPMWZvVHg1UGtKL1VxTnB2bDNCa1VQMmpk?=
 =?utf-8?B?R2ZYSSswNXgvZmpoQ2g0bXpXaVpQMkdPNjFRSXAzcVV2YmJ2K0EwakhhNUhU?=
 =?utf-8?B?ZHFiMHVaa0Y4L01Wbzk1S3krS3Q4ZlpRQTZZTTJCUjhxOU84c0k4SjhkK3ly?=
 =?utf-8?B?NkVBRXVlcm92WlVRdTEzR1JlVExXZUpTQ2JlYkhjM0pwTk4rc0FwMnhBWjhF?=
 =?utf-8?B?R0pQb3NUQ2pHQUEycGNDMnJkL25GQldVY3N6OFJmZEphRjhTSVRVZFJBUXQy?=
 =?utf-8?B?b3Q1MnNtTlA4QzRvaDVpUlc5ZUxmaE1GczJ4S0pSK0QyZ0Rxb1NnNjhKcXBO?=
 =?utf-8?B?Sm5ZSWFNZnV2eGxvSytyRVZaU1VqLzZVZTlPOTBlM2xGS3BQSXpPV09za3hQ?=
 =?utf-8?B?eXdvWVJnRHJUb0ttN2hncVdMQTBhVXBLZ3VXNzM4R0gzTW5PL1dEWi9Mb0dO?=
 =?utf-8?B?M0RsTXVZbTVpWTVhRFhxaXNkY0FlRk8vT0VHRk9wOHgzd2NvS2RZUHNqSkVR?=
 =?utf-8?B?ZGRPRlJqSDFpdXJFTTBPdk1zOHdNbXV5N20ySjI2MFNVVG5vejhBRmhFSk4y?=
 =?utf-8?B?U0kvd0h4ZktQWG1EdGlkdzFDS1VOV0gxQTlUdXN3WnVFcWtOY3ByZXVGclJt?=
 =?utf-8?B?RXZWTkEwRlU0ZmNKNkhtcHR1VmkwQnNBdDRlVUtRMmZSNGJpTVp4T0NXYzlr?=
 =?utf-8?B?WnBRSEw4V2tXdWJ2MWtoNzk5bUJxM00wZFZqeHREWVdZa1lVU0x0cnNUaWFC?=
 =?utf-8?B?b1FxR1lBRWRRbnkrUzVwVjBvc0pORmNCQlY2cGlOT29FRVNSdzRXbDd0R3Jq?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4c0e44-3e4a-4414-a681-08db47782bef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 23:36:06.4277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1sadP7TRqQTH11JAFo0VEuNlIjxpznoWStr6JWk2DKQYJLDsoGLVLnJWlbS27C6Xr8D9IunMoJExOIvNTo3Qb5Vh0PUOrGuieHiqewlKCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5460
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/27/2023 7:10 AM, James Morse wrote:
> Hi Reinette,
> 
> On 01/04/2023 00:24, Reinette Chatre wrote:
>> On 3/20/2023 10:26 AM, James Morse wrote:
>>> The limbo and overflow code picks a CPU to use from the domain's list
>>> of online CPUs. Work is then scheduled on these CPUs to maintain
>>> the limbo list and any counters that may overflow.
>>>
>>> cpumask_any() may pick a CPU that is marked nohz_full, which will
>>> either penalise the work that CPU was dedicated to, or delay the
>>
>> penalise -> penalize
> 
> (s->z is the difference between British English and American English)

My apologies.

>>> processing of limbo list or counters that may overflow. Perhaps
>>> indefinitely. Delaying the overflow handling will skew the bandwidth
>>> values calculated by mba_sc, which expects to be called once a second.
>>>
>>> Add cpumask_any_housekeeping() as a replacement for cpumask_any()
>>> that prefers housekeeping CPUs. This helper will still return
>>> a nohz_full CPU if that is the only option. The CPU to use is
>>> re-evaluated each time the limbo/overflow work runs. This ensures
>>> the work will move off a nohz_full CPU once a houskeeping CPU is
>>> available.
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index 87545e4beb70..0b5fd5a0cda2 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -55,6 +56,28 @@
>>>  /* Max event bits supported */
>>>  #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>>>  
>>> +/**
>>> + * cpumask_any_housekeeping() - Chose any cpu in @mask, preferring those that
>>> + *			        aren't marked nohz_full
>>> + * @mask:	The mask to pick a CPU from.
>>> + *
>>> + * Returns a CPU in @mask. If there are houskeeping CPUs that don't use
>>> + * nohz_full, these are preferred.
>>> + */
>>> +static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
>>> +{
>>> +	int cpu, hk_cpu;
>>> +
>>> +	cpu = cpumask_any(mask);
>>> +	if (tick_nohz_full_cpu(cpu)) {
>>> +		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
>>> +		if (hk_cpu < nr_cpu_ids)
>>> +			cpu = hk_cpu;
>>> +	}
>>> +
> 
>> I think as a start this could perhaps be a #if defined(CONFIG_NO_HZ_FULL). There
>> appears to be a precedent for this in kernel/rcu/tree_nocb.h.
> 
> This harms readability, and prevents the compiler from testing that this is valid C code
> for any compile of this code.
> 
> With if-def's here you'd be reliant on come CI system to build with the required
> combination of Kconfig symbols to expose any warnings.
> 
> It's much better to use IS_ENABLED() in the helpers and rely on the compiler's
> dead-code-elimination to remove paths that have been configured out.
> 
> (See the section on Conditional Compilation in coding-style for a much better summary!)

My assumption was that you intended to implement what is described first in
the document you point to. That is, providing no-stub versions for all
and then calling everything unconditionally. Since I did not see universal stubs
for the code you are using I was looking at how other areas in the kernel handled
the same. 

Reading your response to Ilpo and what you write later I now see that you are using
a combination of no-op stubs and conditional compilation. That is, you use a no-op stub,
instead of "IS_ENABLED()" or "#if" to conditionally compile some code. I am not familiar
with how compilers handle these scenarios.

>> Apart from the issue that Ilpo pointed out I would prefer that any changes outside
>> resctrl are submitted separately to that subsystem.
> 
> Sure, I'll pull those three lines out as a separate patch.
> 
> 
>>> @@ -801,6 +803,11 @@ void mbm_handle_overflow(struct work_struct *work)
>>>  			update_mba_bw(prgrp, d);
>>>  	}
>>>  
>>> +	/*
>>> +	 * Re-check for housekeeping CPUs. This allows the overflow handler to
>>> +	 * move off a nohz_full CPU quickly.
>>> +	 */
>>> +	cpu = cpumask_any_housekeeping(&d->cpu_mask);
>>>  	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
>>>  
>>>  out_unlock:
>>
>> From what I can tell the nohz_full CPUs are set during boot and do not change.
> 
> But the house keeping CPUs can be taken offline, and brought back.
> 
> With this change the work moves off the nohz_full CPU and back to the housekeeping CPU the
> next time this runs. Without it, you're stuck on a nohz_full CPU until you take that CPU
> offline too.

Good point, thanks.

>>> diff --git a/include/linux/tick.h b/include/linux/tick.h
>>> index bfd571f18cfd..ae2e9019fc18 100644
>>> --- a/include/linux/tick.h
>>> +++ b/include/linux/tick.h
>>> @@ -174,9 +174,10 @@ static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
>>>  static inline void tick_nohz_idle_stop_tick_protected(void) { }
>>>  #endif /* !CONFIG_NO_HZ_COMMON */
>>>  
>>> +extern cpumask_var_t tick_nohz_full_mask;
>>> +
>>>  #ifdef CONFIG_NO_HZ_FULL
>>>  extern bool tick_nohz_full_running;
>>> -extern cpumask_var_t tick_nohz_full_mask;
>>>  
>>>  static inline bool tick_nohz_full_enabled(void)
>>>  {
>>
>> In addition to what Ilpo pointed out, be careful here.
>> cpumask_var_t is a pointer (or array) and needs to be
>> allocated before use. Moving its declaration but not the
>> allocation code seems risky.
> 
> Risky how? Any use of tick_nohz_full_mask that isn't guarded by something like
> tick_nohz_full_cpu() will lead to a link error regardless of the type.

I assumed that the intention was to create an actual "no-op" stub for this
mask, enabling it to be used unconditionally. That the intention is for it
to be guarded and how the compiler deals with this was not obvious to me. I think
it would be good to call out this usage when submitting this to the appropriate
maintainers. A comment near the declaration may help users to know how it is
intended to be used.

Reinette



