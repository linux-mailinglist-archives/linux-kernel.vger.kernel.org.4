Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0186B513B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjCJT6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCJT57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:57:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CFA30FE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678478275; x=1710014275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AvQXkWLwjpJ8v7CwePbl0zyFCBb/9wMGNOMxU9EW9ak=;
  b=CuIwj2LXRg2jjCDGJHtp5o4xcoMieHmrpbeBRn9/ohyWOK5qd/F+WJIy
   gxexZvv6Si9bstNrF9PRWWeWer7Z3mvMTxatOsRXg4eouKwxm53Bi4KPU
   xfMIegl4B/52dCDX8vziAvxRG33LU5N57gWjtPbFd+DJbkhRQHr8RekEE
   6mRmrsM/HDUjF4qscaKuY8ZHI6JnsZ71wZTXGXsscrJX0ls7Vx52Mmuca
   V47Kum21KVXrM/pdG8s8g6MxXJP6RHGNh2vecglcukGDHKAVA2Xqef5RH
   5LJPBOz9CiDeFUodrTvtsXbrUSFr4baQRKAiGCpEICW+JH1RbL5ANURMV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="334294354"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="334294354"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:57:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="852039692"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="852039692"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2023 11:57:54 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 11:57:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 11:57:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 11:57:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6PBMFZDXfMCsuHhzhsS4a+e8aoCA7DdQrjNQTBhIH4xxxqX69j+LDUxiXq59484B3jyM74tfPvPag0RpraJKocqUvFJregGdmUNea5lmY9knT8FV9Vh2tkBkE0BCBP1CHSfWXMpKYP6/P7+s2MPXMDajFrq+aYNbTrDHVQvbAdDEuzgTL5JX50s0hSVPcSEyasDmMOtMZ8iNg7QX8XkgzJ9pBp6vMXxQtSKx3eFa6DTCBB60IK8FPIFL4BMOQ8EDwcvcbynwB9zeeomW18c86K4YC0d+5nF1/kIwZzpTuXPI1FdnbdLLIzv9Wu3+IHfcewJaeF54c9w0HXVIj0i+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRTlr3ampdzK3dM2ABJzvNtkEJ78yT0AnUbe8gqR3CE=;
 b=a3jDUffqEn/QfCua7BOn1N1WgBgwJ3GMab9pWIRIVk0BkUSfha+jsB4+uuqFSr1u66ws2wSiQbfrFleC4hBwltOPzYtr7rjJqcjv5Az2mziAfmoV2iJ904f2SyfndF+/UwNPO5zf53Tx2Q9MAnM/R/HSPD8b7XyhQSFJdgIpranKXleBYY6GmX5kXGHVEAAG7d6K0vrcXonoNizH6lfqFXhIP2Whzwo+AphO/U8Gk3j1osr6Ps3xmal4EOYmdZ/4OoLD5z4EZDmJE87EBGXtBFEaholcX8uvaNCJpB8Nbf5EXIWqCJQ4ip2oINTIUqf8YZwuawrbdXsS8mnm7P5AGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Fri, 10 Mar
 2023 19:57:52 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.019; Fri, 10 Mar
 2023 19:57:51 +0000
Message-ID: <e15a6fe7-42e1-cb9d-37b7-d350d8168eb7@intel.com>
Date:   Fri, 10 Mar 2023 11:57:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH v2 05/18] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
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
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-6-james.morse@arm.com>
 <2ad21ffe-6019-eb34-a0b3-2c9d26799269@intel.com>
 <753cd447-24a8-0dd8-6f35-9ad75ba619c5@arm.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <753cd447-24a8-0dd8-6f35-9ad75ba619c5@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY5PR11MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c163eb-08b3-43ea-9d8a-08db21a1baf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEd6pfQGdx6VY35ofCgoxdXyjX0s0TgKPHpjM2CJWBA9IeBx1X5//bo/p2HfnbIXZRK7ElL0/YswU/wHHhLecBstKz8JyFgIg/IpMZweOz1kI8dtHYbABBgZTry3/jI8dcGmBe1lvgJQhNiMPS8Dvr8ZzirVqB5gt8/NcQjvofRVhejps8YgIBY5kNkZQ2j32ZqxA1mNN6Y8spAOtiRRYWDQX4LV7pxJrkY+9uswxjmoxhsB6VYSSZVM6pjUI4K+BHd2oAlAN470AVWeq9JMpUep2vX5yEKH4jl0Qdg6XwOZIwEDRmwcvbskbikGah1XhuUIlF4nrYpHciCnX1ObgQ0zx8Zo2LQltPM77TkIeaZeRqaY/A7qWcxspPjkLWB2t2Zs9vMzB5/b+EC6xjd+2EwNjF+s55ljnoHSciM2o+SfWLUTH5ZQZZtAXk9HPonhP0Qfr3IhGh+DJJbEnlEm7ESh8gS7qfnt8Vo9Iz9gmFTnIl5dGu26a1aVzbq/XYPjE7axuiSPO0EWU673Lvcsn7mHHBOZJoHL0rW3jQeMbMLvYR8qvVaeFco3bIHpR6pJ3pWp3NNoQIVV/OfVlwMMomzzQS+8FrNkq2nqCVNQ4E+orB97ccJDVRUKD0Y9TNbvHSnrQvGd1TAVHboEAtcA8uk7N4i6/ZHGakOVX1S6IukX47vnVJhM06XHHJtEA6qtJqHaz0+I0UoJvsaIBp4wv6ntl2PtjiR8CKKUMQ8W+zU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199018)(31686004)(53546011)(6506007)(2616005)(6512007)(54906003)(186003)(86362001)(31696002)(36756003)(8936002)(6486002)(26005)(82960400001)(6666004)(478600001)(7416002)(2906002)(41300700001)(5660300002)(38100700002)(44832011)(316002)(66946007)(4326008)(66476007)(66556008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZadUROQzRvZ3JldEJoZTRiNzZSenhYZDNvaldiZzNjL0w5VEVEczBkZHB3?=
 =?utf-8?B?SElYWFZPV2lVSEhOaGVHZUJEZ2pSYUc3blg0WjdaanFIS0RxTkJOOEpPT29m?=
 =?utf-8?B?c0NZNC9ieFN2M25NOUFjeG5rZkoxQ3Y3UnhQMWhyZGFmams2Q2MyakZuWWx1?=
 =?utf-8?B?R2RKMlp1ZVJqM2tPQ2RlbXZsL0tKZDg4Smx0YWdjZFM5Wm4wT2NGN013cjNo?=
 =?utf-8?B?ekpvTjU5K3VHOXdDK3hPK2trWkQ4ZVc3Q052M1JVZStMajd0RWdHN3F1a0xR?=
 =?utf-8?B?RE83NVVmWE1wNFlTSVcrNzE1ZzF2YXVJTVFYd2wzK1EzUlVRTVJHMUZ4VUJu?=
 =?utf-8?B?Sm1ZNXI1WXJTbTE5N0Z0MGIvb0hrcU5sSXp1L1RmWjZDcEpQeVZzY1IrN0Uw?=
 =?utf-8?B?WVhhRnpvT0NqUzZneTVJaTVhOU5BRU94cXhUbTMvcHA3Ull1Y1BlaVVoTTha?=
 =?utf-8?B?V3BJODBDTnhpUlNrQkVwek9EaGRuZTdmUU5TRHV5ZmVIMVNkUjFRVlo2RXJE?=
 =?utf-8?B?S1B6R2tmbFJHMVhVVU9SaGtoV0FxMFJYekw3WUVHMHdETnF0bEtKL3FBVnBx?=
 =?utf-8?B?S3FQVWdZQS9NV0IzU0ZBWFdwVDBwa2tzRVRQR3ByL1gzak1TVnNxRGhUcHRJ?=
 =?utf-8?B?M2xPdmEybC9hZ0p3M3NIcDVieHErWDZTb3Z6UitxKzBUdTFaWkcrSW0yMDVq?=
 =?utf-8?B?SFc2N3lQTEJtT3ZPb05tVXV4by9meWtYWHhyUmFVSEwzWmFYbUt1ZGRONzJr?=
 =?utf-8?B?VVQyL284YXJPbE13UmdrL25LSlNOR0s3UmJSbXIvTGlCaE53N04yS3NKSXN3?=
 =?utf-8?B?aEt0eHVzNWg3Tks4SkR1QjVSajgvbUx2VW9mS0phWTl2czZIblB4YkJRT0VM?=
 =?utf-8?B?dGtOUjZGUERiMTR5OCswalhINUVoTGREZ05OL2J5M2RoUUlwZHFZWHdybFJT?=
 =?utf-8?B?UllmSW5ZWmV0MGdtZWJaYUpuN2N6RFBOTGc0cjdPL1F3QTh2VU9QK2Y5bUlu?=
 =?utf-8?B?VmxwMitJWEtSOFJNVHh2T21ScDY4bEx3Qmg4WUlGRTBodmJVYW9pZSsxTSt5?=
 =?utf-8?B?VUdTemgzZGpLMzB5TjA2NFV6d0EwVERpUDUyZndkbSt2NVdpbEdicjErNENm?=
 =?utf-8?B?ejNUTSt6d3B6Qzl6endQWW95eUx6cHZKV3RtaVFUc2VhSTB6a2VOMy82SWNu?=
 =?utf-8?B?cGlYVWJBYUE2eC8yUUhHeVZOZ2hmWmdzRGJ3Y3NtbG96WHBsT294b1hkUzUy?=
 =?utf-8?B?V1l1SDdxc2srV1Y4V0VxeHJLVjR2S01hV1BJMnRpaHpxUnBzdFVKdnZVaENr?=
 =?utf-8?B?K0NsY0hnb2RoU3EwcWRUZEtzRVY3ZUJEbGtmZ2RqbytWSVBGbDhuYWxQM0w5?=
 =?utf-8?B?akkrTWdxeE1jWm5MOWNEcW1sTWpYMHpRWmZpdWdBdTF0eGtMQ0pPRzZ5STZS?=
 =?utf-8?B?dmZjNXdmMFRvcExvWE5MQTkzNFg0N2YwNmZ5dFNtNWZYaEx4TStQckcyNTlz?=
 =?utf-8?B?ZWZOaDFnZ0JicUlDRERqQjZac3FoTzcxdTRrTUR3andwblgzc1NyZmxkNnNR?=
 =?utf-8?B?SFNKUHZTMkhsSmllSThWa2FiZTVPZnJydTVTOHh4em1FTHFKL3JiNmRXWEMx?=
 =?utf-8?B?MGo4ejlFaFB1NlU4V3k0Qk1nMlNMT2VpQnhEcEtGVzdEQVRCMk5vdHd6OFQz?=
 =?utf-8?B?OEs4dmNvWVJKakozejZCdk5jWU04dnlkMnord3kycFlQUzZUWDByeDVHeGI5?=
 =?utf-8?B?Ym02NWtZOUdSY2NYT1ovWURzZTlsaCt0Y0xPUlZXbDQ4SGZvUG15bWgxcmpZ?=
 =?utf-8?B?RWRCMnhhQzhTclppWkhzeFlmUjg5cFYvV3RILy9ETWRhZ2VvZTVFbGlKWlV0?=
 =?utf-8?B?Zk1xM1BIRmV3RUk5Q2JEZnFwak90RDhkcTlSL3gyMUhPNFNDRFRzNDdHWW0w?=
 =?utf-8?B?a3VpU2oxWjMwS2FKS0RyaDk5VHVCTXBtd21PMitpSXBZQm81T0JDcjMwdGN0?=
 =?utf-8?B?MS9iSElmU2dLU0ZKWkRib1JOV1NVU2Foc3VRNXlzdlhaTUxld3JrY0lqRGds?=
 =?utf-8?B?ZGRUNGFGaEh5SVZlcUc0RlBHK1NRZXEvaDFVWU9QemwrNk42MWpwLzl2ZW1k?=
 =?utf-8?B?U1AxMjByTGZPNTB2d1lHK1pTb0JhU2dubFJKT3lnVnZLT2s4MXFVV1JEb0Nn?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c163eb-08b3-43ea-9d8a-08db21a1baf2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:57:51.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obf/Rl/CGWgVfXnQtq4ecyB9lsjHhQoEKFV5j4vWrGjr5qxz1fTmhs54RWrocX6BdmdWBN/uKqbG8PFUCAZvTZ6ybvPICJfc9sdf6RZjo1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6320
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/3/2023 10:34 AM, James Morse wrote:
> On 02/02/2023 23:45, Reinette Chatre wrote:
>> On 1/13/2023 9:54 AM, James Morse wrote:

...

>>>  /*
>>> - * As of now the RMIDs allocation is global.
>>> + * As of now the RMIDs allocation is the same in each domain.
> 
>> Could you please elaborate what is meant/intended with this change
>> (global vs per domain)? From the changelog a comment that RMID
>> allocation is the same in each resource group for MPAM may be
>> expected but per domain is not clear to me.
> 
> This is badly worded. It's referring to the limbo list management, while RMID=7 isn't
> unique on MPAM, the struct rmid_entry used in two domains will be the same because the
> CLOSID doesn't change. This means its still sufficient to move around the struct
> rmid_entry to manage the limbo list.
> 
> I think this had me confused because 'as of now' implies the RMID won't always be globally
> allocated, and MPAM has non-unique RMID/PMG values which are a different kind of global.
> 
> 
> I'll change this to read:
> /*
>  * For MPAM the RMID value is not unique, and has to be considered with
>  * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
>  * allows all domains to be managed by a single limbo list.
>  * Each domain also has a rmid_busy_llc to reduce the work of the limbo handler.
>  */
> 
> (seeing as the function doesn't touch rmid_budy_llc, or refer to it by name)
> 

Thank you. This is easier to understand.

Reinette
