Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0DB63E68F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiLAAg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLAAgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:36:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EDC532EA;
        Wed, 30 Nov 2022 16:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669854983; x=1701390983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+1EwT8TFUElk+EMHvagG68RtTqkBgylmDNZDPZiy7R8=;
  b=hUvXOjeGuaW6eMl5uzIpYpg0FOhoCTCwgb4km/1X0W2YHHGeKnlbHzm7
   1BLqKyGsDqwPBhjoNA3EnnE/Cq3J+PsbtQjkY4icFv0TCFUWiH/arzzmm
   y/Rp0DlO3VvS9U+8g1AFkCopse21sb/6I+ZEN3mi8czPogq+tbrAvsmVs
   ReTigJQaDahn+2527/r1FtzKNlhjCwdggNN7PULZ/q6YxZrXMrt9dHTLP
   zoDfAGvRjh9CJAhz6zA4xTB0jmvvi9k5N4zMC1xdAEdJQ8Wp4n+QJLcWZ
   w31tjJ71UAFb5pKk2GvCv6zmISHpHzMJ+M3hJBw7nueaq6q1qv1sv+oH8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="313177202"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="313177202"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:36:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="818835260"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="818835260"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2022 16:36:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 16:36:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 16:36:22 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 16:36:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2wKPqMyuSXoCMufhH2eCJgF6hy3kOQZxXYD7bvv2H2DeWiPitO+PFBF6x7BidZzm0QXrZcI400pkHVw1RHrm3we18q8eejGw00D/01A23iUcLLpSrWBocIhS3ThEua44NQQqz7j8qJzLIo5KkpNt9jnpvco2V2hu4L77+GUMhGLK7aiG7N2PLtlxYlprhB42yArzJFskThxJpLJ8oxFR+x2kdaDUHXEG+yuxlZqOhqMxN7v+Owz2gK9PBPgVWdZZMI4R/KezOPcrmnTAj5RR+ktd2r4knNseIUi1pwkDkDlqIRUcMfus6RQGfL+9fCgwxrIR7DqosNrGUKSZNivMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyLoyrBSDkMPtgol6Wyj5wma/FiKW6hzuppW345Gnz0=;
 b=iJ4evfNVY9/j511oSy8J1n2lOS9XkHNvFL3vyK61Z6Th71yZMRAfjSGlfaPRIhguDUWJkyr4cA5BP0tPGIbg624AbxvpAN9B1AUCbEHCq7yuQP3mrHKFfieRw1osYedL0q+QmG325MP9t4o1NnMSa768XXOJ/bLYPe9ciKNW2CeoFv1RlyIux90ovaQ7mWL23xP4hKOJjNfgvR3wN1iuEmCtX04CFyhaY+PgVDfaX2oVxlthk5Phlc1I8TTuDTLp+/mhG/u3A/FZOnURXqDLWyHmZkvTtDfLruox5OM8Q2sLD9djiANLezfon642nZyNg0yBCrTkOXHsfwGM4tkmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW5PR11MB5859.namprd11.prod.outlook.com (2603:10b6:303:19e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 00:36:14 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::b518:90b6:52bd:bef9%12]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 00:36:14 +0000
Message-ID: <379e4d1b-9b3b-dc83-99b4-e2a179395733@intel.com>
Date:   Wed, 30 Nov 2022 16:35:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 05/13] x86/resctrl: Detect and configure Slow Memory
 Bandwidth Allocation
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759202922.3281208.6231300030834095574.stgit@bmoger-ubuntu>
 <d2209b3d-374c-efdd-a91f-217f1db3b4bf@intel.com>
 <764c8eac-7b33-3850-3052-e6444ce496d0@amd.com>
 <5d17741a-c6a6-9ab0-fc05-673337b04a57@intel.com>
 <1b495f25-bc81-6181-e48d-729bf8211dc1@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1b495f25-bc81-6181-e48d-729bf8211dc1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:303:b4::6) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW5PR11MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: da6f6c31-d414-49e1-9db4-08dad3340213
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPIOnAxr7XRMQolErYjLFxbkHlgvtGCfsRwFMISERcNbWJkFcDEzYDQyOUwhWGURxhYwO3X1WEW7oCuAchn3y+VH26RMYNiFbpuYPI+mNN8GFYbW2A9yqQFNXl1Y09qK1eLo39Bi7oY2WyD2+7zvc6Uk9ThUUCOfSkk0EnFHHGaa4mIWZnMnTHz8Qs/v9QVnOBIrOEc3c9/GanFMajscPTC+ZE9sa6Pr7Zl1/3/pJPbmqlpPuHcT2PnGG80vXJi6ahczfbcJf0qU/b6YNVhGRDrxu7/OE0+IQ+rtlzrmZZMVBPtrtVZQ5yTVbK4luQ0037S4vnIUnWGDmMlH3TRQtek69fdopYn6mbSN04q92K1wHVfX/ZcCt+5+lQrTpc5r1gmH/CjDBvuWWTMcWMkg+JLl7DxlyH3/k4MBhH6x7I7Ry5ALd0qvkmkkL7GXm4qTbr/k6cpsadLElGLcb8ZQNdp8bKspZlo8f1dplUc+M53E079nbId3zlh0g39VyKwnBaCn/DCz20P3i43HJ4xoUI/A2mk/9Ce7gmj86COUghvHhH74Q3rStOwBVykV18Sxbl3YJBF0cp0TKfhY+Lj7a3sZT25hgmp27Kn3G+Mp78Ass0AGbrY2fr13P3bGjOXcAZGNo7sE6Zi1IasXqVoZc2N8R68eJA1jeIacipUm8INW6RfK3sPRz8l9LS/I4eMtMc+34vVLXtcK55L1NScmXZh9fIL7qWq9X4H6UzaRuv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(5660300002)(36756003)(316002)(83380400001)(6486002)(2616005)(186003)(31696002)(2906002)(7416002)(38100700002)(44832011)(66946007)(86362001)(66476007)(66556008)(8936002)(4326008)(41300700001)(8676002)(82960400001)(26005)(6512007)(6506007)(6666004)(53546011)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdrem9RSWwydkNOK0VBejg2UEJ4QTllTWRUeDlveU9SZzlwdEdGSGJnclp2?=
 =?utf-8?B?SjNXNSsxMWdSV1J3cG1HS3M3RWJ6czVFRE1uZXdod09CbVQ2dERxNzQ5ci9T?=
 =?utf-8?B?Z0hSUlBQbm1EenY3dm9iSGwrMW1JTkI1Um5aSVJYK0hlcWZkWWlLK290aXpZ?=
 =?utf-8?B?YmZtZXJKU2JrYk9lTUIwQ01nZW9TalFYb3VKbWNoYWJSSWtFaDk2QXlWMVMr?=
 =?utf-8?B?L1JkdlFzL3pZc04vT01jYWRwNU44eDAwbldsM2hCdEw3M013R0Z3SG9vemJO?=
 =?utf-8?B?YjJ6dFVQQ0lQKzhZakFXalJsck9Oc1lib1ByVGdET0dyV3N0cWx1czFiamJ5?=
 =?utf-8?B?UG9VSGROdHR1NlFZSVI3S0pheHhXUDRKZUR4aDlMS2k3QU5PMjRwTi9wTGtL?=
 =?utf-8?B?L0RBWFJITTFiL1luQURxaXFGZlM1Y1YrVTAzbEo2KzhhamVVcDZDM3Fhc0du?=
 =?utf-8?B?RDRWMEpLM1Y5a1BWcE1aV2o4TzRseWw2cWg3VnBaZngvNjBaZUlVUlNlWm1z?=
 =?utf-8?B?M3lFSlVKQ0JGYmdRV2dGZ3l6TW5PeEFzekNWQ3lhTXdSZlhuWUJHekdpNkdl?=
 =?utf-8?B?ZDhpaXFVTHRnZWkrUGpIZzg5V1V2SHJ1bU55K3VmN3VnenRnOXpXMW92eU8y?=
 =?utf-8?B?N1B6VHgwSzU4STFKekJidHdseVJYTnh3NXAzaEpoeExOeGtSUVdXaER4Z09h?=
 =?utf-8?B?VnBBVTBNL1JzMXkzZnp4cXFjcTBFRVgzZU5DNnZGYmY2bkRGamFGaXN2RWcx?=
 =?utf-8?B?NFdHaVdOZnJpQTZhTnNMYVB6TVFQNDVscjlPZ3BqZTZYYmNkeVNyWVNzUTJy?=
 =?utf-8?B?TG96Z0FRdXhzRVBzT3AwV0J5ekM3bm9yaEtvclAzSnN2TlJ6c1NNK0hmd2Ry?=
 =?utf-8?B?T09kdm9CUDlIVWZQNzJHR0xDM1YyUkxJR0lQQWFVUWpZQ3ZpbzQ0ODV5K09W?=
 =?utf-8?B?ZzJkTzhlbWx3OUsrVU1NUG51QUpDV0dEZFpzZ2N0bzJoNVVFMGJpVVJHMzgy?=
 =?utf-8?B?czNlcm5HeG1oZm10VzVLSlNHRUtpd0FzM1JHbWEraVh1dkxKblpkMDVsOXNh?=
 =?utf-8?B?c0djVnRUZmZRZ2twb2U3N2lpTE1NWVBFaGYycm5HSDk5Rkp5TmpESDJzZXgy?=
 =?utf-8?B?d2xsYThnMDhNQklEeXNOSFFXaWxJQWtDVHAwdm9FM1NZeXpCc3hrS09xVzNQ?=
 =?utf-8?B?ZmYrTW9ST3VqTDRiKzNOaVc3b01icnJNQmdGTWk5RzZ4UnpiOU93R09sSEFr?=
 =?utf-8?B?U1JINUJiTlc3K1pIUXFpb3NMYnZWcUlpOFhJT0dVT0RFd2FGZ3FDZHhhR1ly?=
 =?utf-8?B?YlJYamd2NHhCQVpxdWRSK0lMYU5xWVlsK2NHay9NM0pIamM2amhZM2lISXU2?=
 =?utf-8?B?WGgyK1djalJyaE5vNjNnSm1nNXMwKzZGZGw2cGFtNEFsaXp1UnNNeExneG5K?=
 =?utf-8?B?SjNSWlBQbGFoMHIzbkFyNWRMUkdEYVY2b0dIeDM1dThtL1NYdjZ6dnc4b09H?=
 =?utf-8?B?cS8rZ0Z2Qi8wSjFCR3l2TlRBRHpWeW43cStSSDZ5S2krekNyM1QrM3k3R0U3?=
 =?utf-8?B?d2Q2aklYWGVDTHpsaVRYNkIvQmMvVTgzVlNjK05aaVNvVjU2SGNUQk5QMHBY?=
 =?utf-8?B?dk4wekdlcmtlTjRWcUJTWG1mUlI4eUg2aVp2czFNeDFSOEozdUl0UHdLSDBs?=
 =?utf-8?B?VlZFb1FEbnM0RDlIZ0JuaS84UDBublRiVWNSdVFseE8xeWpRdVVreitJNlJy?=
 =?utf-8?B?TkIwTk9vVms1WVh1L1RyWk9zN2RxS29RQVdNYldVR2sza0ZZWFp4WnRqSUt2?=
 =?utf-8?B?amlZSlIwRWc0OFB4cmc2TGRJU0d6dklTTFhKVXJBQnRyTUl0VStzdDRtVWww?=
 =?utf-8?B?TmVmdWt2M1FsR3hLQ0RCMFJqUUthazM2TjdYVWJHcDZVek51S2l2VDNYYjcx?=
 =?utf-8?B?OHp2TTR1YmJkK3MrbUtJTlp4OHBQWWZjVE15VFgycFg2WDdWSDF3WDltd0VP?=
 =?utf-8?B?N2gyYWxXNDhqcUMwWEVkQVNVd3RmM1VKL2ExMnBlNUgwUjFVRnJsdlpBdjBT?=
 =?utf-8?B?RW5NRHNQWTNjN3czbTM1aUJtb2lSOUNML3JxNE83ME41ckU1WFJhSVhMWXB0?=
 =?utf-8?B?MzQreEMxNFp6aXRWYjM3aDkwQXFvamhZMGZ6bXlVZXcvdzZDaVFTN0RoQnBI?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da6f6c31-d414-49e1-9db4-08dad3340213
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 00:36:13.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DilFq2mImNvPU6q3LLOfHDUfPQiKG7WfdpDkHgVYXVX+0sXREyes97UyeyF92jMUUSke/AXHc3VZ/blmg9kcxHteaGKBA0gdVfLl94hixC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5859
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/30/2022 12:40 PM, Moger, Babu wrote:
> On 11/30/22 14:07, Reinette Chatre wrote:
>> On 11/30/2022 10:43 AM, Moger, Babu wrote:
>>> On 11/22/22 18:12, Reinette Chatre wrote:
>>>> On 11/4/2022 1:00 PM, Babu Moger wrote:
>>>>> The QoS slow memory configuration details are available via
>>>>> CPUID_Fn80000020_EDX_x02. Detect the available details and
>>>>> initialize the rest to defaults.
>>>>>
>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>> ---
>>>>>  arch/x86/kernel/cpu/resctrl/core.c        |   36 +++++++++++++++++++++++++++--
>>>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    2 +-
>>>>>  arch/x86/kernel/cpu/resctrl/internal.h    |    1 +
>>>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    8 ++++--
>>>>>  4 files changed, 41 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>>>> index e31c98e2fafc..6571d08e2b0d 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>>>> @@ -162,6 +162,13 @@ bool is_mba_sc(struct rdt_resource *r)
>>>>>  	if (!r)
>>>>>  		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
>>>>>  
>>>>> +	/*
>>>>> +	 * The software controller support is only applicable to MBA resource.
>>>>> +	 * Make sure to check for resource type again.
>>>>> +	 */
>>>> /again/d
>>>>
>>>> Not all callers of is_mba_sc() check if it is called for an MBA resource.
>>>>
>>>>> +	if (r->rid != RDT_RESOURCE_MBA)
>>>>> +		return false;
>>>>> +
>>>>>  	return r->membw.mba_sc;
>>>>>  }
>>>>>  
>>>>> @@ -225,9 +232,15 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>>>>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>>>>  	union cpuid_0x10_3_eax eax;
>>>>>  	union cpuid_0x10_x_edx edx;
>>>>> -	u32 ebx, ecx;
>>>>> +	u32 ebx, ecx, subleaf;
>>>>>  
>>>>> -	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);
>>>>> +	/*
>>>>> +	 * Query CPUID_Fn80000020_EDX_x01 for MBA and
>>>>> +	 * CPUID_Fn80000020_EDX_x02 for SMBA
>>>>> +	 */
>>>>> +	subleaf = (r->rid == RDT_RESOURCE_SMBA) ? 2 :  1;
>>>>> +
>>>>> +	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
>>>>>  	hw_res->num_closid = edx.split.cos_max + 1;
>>>>>  	r->default_ctrl = MAX_MBA_BW_AMD;
>>>>>  
>>>>> @@ -750,6 +763,19 @@ static __init bool get_mem_config(void)
>>>>>  	return false;
>>>>>  }
>>>>>  
>>>>> +static __init bool get_slow_mem_config(void)
>>>>> +{
>>>>> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_SMBA];
>>>>> +
>>>>> +	if (!rdt_cpu_has(X86_FEATURE_SMBA))
>>>>> +		return false;
>>>>> +
>>>>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>>>>> +		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);
>>>>> +
>>>>> +	return false;
>>>>> +}
>>>>> +
>>>>>  static __init bool get_rdt_alloc_resources(void)
>>>>>  {
>>>>>  	struct rdt_resource *r;
>>>>> @@ -780,6 +806,9 @@ static __init bool get_rdt_alloc_resources(void)
>>>>>  	if (get_mem_config())
>>>>>  		ret = true;
>>>>>  
>>>>> +	if (get_slow_mem_config())
>>>>> +		ret = true;
>>>>> +
>>>>>  	return ret;
>>>>>  }
>>>>>  
>>>>> @@ -869,6 +898,9 @@ static __init void rdt_init_res_defs_amd(void)
>>>>>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>>>>>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>>>>>  			hw_res->msr_update = mba_wrmsr_amd;
>>>>> +		} else if (r->rid == RDT_RESOURCE_SMBA) {
>>>>> +			hw_res->msr_base = MSR_IA32_SMBA_BW_BASE;
>>>>> +			hw_res->msr_update = mba_wrmsr_amd;
>>>>>  		}
>>>>>  	}
>>>>>  }
>>>> I mentioned earlier that this can be moved to init of
>>>> rdt_resources_all[]. No strong preference, leaving here works
>>>> also.
>>> I am little confused about this comment. Initialization of
>>> rdt_resources_all in core.c is mostly generic initialization. The msr_base
>>> and msr_update routines here are vendor specific. I would prefer to keep
>>> this in
>> This is a contradiction. Yes, rdt_resources_all[] initialization in core.c
>> is indeed generic initialization, so why is SMBA there? If this was really
>> generic initialization then the entire initialization of SMBA resource
>> should rather move to AMD specific code.
>>
>> SMBA is an AMD only feature yet its resource initialization is fragmented
>> with one portion treated as generic and another portion treated as vendor
>> specific while it all is vendor specific.
>>
>> The current fragmentation is not clear to me. Keeping the initialization
>> as you have in patch #2 is the simplest and that is what prompted me
>> to suggest the move to keep initialization together at that location.
>>
>>> rdt_init_res_defs_amd.Is that ok?
>> The generic vs non-generic initialization argument is not convincing to me. 
>> Could you please elaborate why you prefer it this way? I already mentioned
>> that I do not have a strong preference but I would like to understand what
>> the motivation for this split initialization is.
>>
> I dont have any strong argument. I was thinking, in case Intel supports
> this resource in the future then they only have to change
> rdt_init_res_defs_intel.

I agree that this is not a strong argument. If this happens then Intel can split
the initialization also. This is also not the only bits that would need
changing since only __rdt_get_mem_config_amd() can initialize an SMBA
resource.

It does not sound like there is a clear winner. To answer your earlier question
more succinctly, yes, from my perspective you can keep the change to
rdt_init_res_defs_amd(). At least with this change things would be more
familiar between MBA and SMBA and it will be obvious that SMBA is not
supported by Intel.

Reinette
