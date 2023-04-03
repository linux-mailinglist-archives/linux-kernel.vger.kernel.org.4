Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DCE6D502A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjDCSVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjDCSVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:21:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B1F2704
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680546105; x=1712082105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LJ61aYSD6AMXrA+Uc2uDU+JreNt9Fv3DRuUMveObUyg=;
  b=bZEAhIPsWSdjeKa8NIYcI0eEQigsEIZIvbyaSvrfirZrrMp4cxgtou5N
   DXB4+FIOHt7uumqqR7kUgwkCj+gY1FM+o6+LplA5Jpld7Y0Pwf8VGwZrf
   L53ohjFebYu3EmRX5ZHSGdEklaRNNnANAVLgRllpGKJRmTqPEqr/4/S/I
   /DAf3eB+e+Zg0BMHfDVOpUHgayEANkb7OgNGS7gMVeG/ov8KiWXn7t8DQ
   J5XcSzvWQzV0uWqCYev7FG8kMzAeTjIjxd/XD3lbt4BtyOsXGHHvH2iyB
   6iV0GPKvSfzJXgyii1Bsrt/VLgsROr1NMkAmq8LeFu4jYIHpxifjrnbWO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="325993061"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="325993061"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 11:21:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="755355518"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="755355518"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 03 Apr 2023 11:21:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 11:21:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 11:21:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 11:21:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2dNqxbE/Tg2Ml3mM3UUVQyAECTqfFNzfvnAPx4XV09Udkw2p6QIDCmBrVxv4Hbl3FdQEOpHw3yzDn0mx0+2A4fJ/9cxP8wNCzTp8EROL3Bb7pFkR68B8BNe91H0uCowOtD1OHFOOucBV6si/Qp1L4mYoTKuJLoc0Xnsu0PR2772c7I8zs0mxffnl9TcGFa47jLz6ZA8JeyGLiicNWRpPTs7HE/nFVuxiwFMcbiLNP5AqsvJwdVrGTlJT/xgPnilu1vXBnLqu/x5aMIQL1Bhx540L/G9NqB0qxqf/Q32XqKdDdqIZxUFzoV2ced110DOPhF0oOzECtqseV7RwNq11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1cSX5kAIkb543lS9p7QkAgTOTB413eVCE4pwzBNNJU=;
 b=ZBIK6pu0xAp8mPGx6nnzU+XGeD13Iu+5ax+10rEgP+lgyINSir44CQDB2p9/MpVPV8pvM2U/qA69iYOH0THubs8tVqM1kDhkm5PCHL5qPttngyppxHqfIPbcPvLZCINhTV3HdxsSVShZyd/0ImMr9SFV9AnKU2b6kNIXdGOok6P/ElGzvRlOvSJud6WlsxoGR5nPaFtdjCDYYgnDjWjBBXGEHYkOERFy7uIA60cxURpxmnOUIiEHRU/nFcwAjTnmZLue0RG5PGx0Htr9lFhhxomAAbXxDPdqtFxPs41sbbc7rgSSvj0UalL2HHxreSUOVzxJh9Tr5D1npSKmYmbpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 18:21:36 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 18:21:36 +0000
Message-ID: <af4facbf-8301-69e5-b5c3-20527f265f48@intel.com>
Date:   Mon, 3 Apr 2023 11:21:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v4 3/3] x86/resctrl: Implement rename op for mon groups
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     <fenghua.yu@intel.com>, <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <gupasani@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <skodak@google.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
        <x86@kernel.org>
References: <20230308131452.383914-1-peternewman@google.com>
 <20230308131452.383914-4-peternewman@google.com>
 <4a276e2d-9f56-437d-8284-c95def0d2487@intel.com>
 <CALPaoCgiFCG8FcBS5Svj63oeqbmARByCGh9ox-ZPUY-6gkBMqg@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCgiFCG8FcBS5Svj63oeqbmARByCGh9ox-ZPUY-6gkBMqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|LV2PR11MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2f6fc9-d339-407d-07d6-08db3470427b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+8KIdIAyvKGmtGVsJP2692Tl6gH6BGYMN1k1o5dXXYtGtYJqYmIuXXzl+2hlSzbGW9oCdznScHZ+0qoBypczlNEq1qq6wPNjWX1GseuNKsaAW6Gl5OS58qfhRZ5MANXj6noEQGc/oJQqxrPU5s4uSuVFF+wIdCq77jcxLf4UnVsKXHG5MCmhturYWNIqFMjPuGSZvEzsYFUs7xzKtGasjnS/qE1JzFQnRlMNhVIu/d5x3/MK8ELJ6WEzbmtdPtB6f8VDLcdZLhHcWoayDmERJzAP0wWnQeFXVAZrd1R7nZ66fK9Sbv6Xyg26B2705DnIppio6GWKCB5i36FdVn0XMwVZ+uAMlEWJCz2WS1sX+5b9wXIbOUrZCIedBVC4ZlTjj/G4ijkABqu6Vv1zvMDwp0VpX4SY/LHX6VwqHSIyGzwWUD8QDo/H31FcAo3b6u0zVEMY3zl44H22FDDtqhtRewz0AoyJ3vcbCkTlxEfJS7PAjJpu2zE3zFHIG8oLzzdlV3bXo2UvdK1PjbQOXu8bBHOGrruM30/xj5Nparnwsqx1fgUnZFLsDEdrkVIhkE6lmIldRFN8Jr4N1sw+oM4coBLjEKVH4H1uWYx22DTBJqQ7z90bsb1wLESBkB2gLE044+LXqagYNhe94ukFOX5vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(41300700001)(8676002)(6916009)(66556008)(66476007)(66946007)(316002)(478600001)(44832011)(4326008)(8936002)(4744005)(7416002)(5660300002)(82960400001)(38100700002)(53546011)(6486002)(186003)(2616005)(6506007)(6666004)(26005)(6512007)(86362001)(31696002)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmVRMFZqSmM5TUs2TGtncDE4ZDVnbkhSc3czTjlpYTV3bnhBcGFDcmhRajFv?=
 =?utf-8?B?NW53MzJ0KzUrWnBtcGF5K0EyNFI5dkJhcFJ1dGM3d0xyRjhCTkdSbzh3UFY2?=
 =?utf-8?B?L1F5WGROTFJLQTE4Y3VJaERkdm5qNU42VWtCQXZVTWsrNmJ0WG90My9uU2cr?=
 =?utf-8?B?STIzWUZSWHNvWU9WYWdsbjZSbGZJeHJLM05lcElXZVU2Y0VIZi9SYldDOUZK?=
 =?utf-8?B?M0JtalR2OTNSa3dLL3k3ajBIZjdGcmFGTEJ1L2h4VkYrdGhLZFFnQVREWEwv?=
 =?utf-8?B?c1B3MEJ3NDVNMnpUWGVFeVNXOG50cDVEcmp1UGhZYnhiei9ZK2tKbnR1NVhS?=
 =?utf-8?B?TDNCek93Zk5KdkozcUwyWFNtcGtwenBMeVJjbzg1dlpzMSt6THRqaWkvb3h6?=
 =?utf-8?B?KzNPYytwYlpyMW5sZ2N5amVSeXdoSE1jVW44M1h1LzFmcFVNTHoydHM3cjhH?=
 =?utf-8?B?TjR0dFhFY291SCtMK1AzZktpeFlkZ2ZiZGE4WWkrODB6NkZHb0ZvdmRUSG5y?=
 =?utf-8?B?QWJ0STJaeWplbnBsRjZPSTNuMC9iLzNJUEFjMkY1L3ZldTQ5K1RQQ0twdy94?=
 =?utf-8?B?UjFhSVZEV2l5RU8wK1l2cEwySE9PekZUTXc4QmlYNVhobWp3VkpVaXlXV0R1?=
 =?utf-8?B?MXoyL3lkUUpySEpjUzhUQ3JCdUZTVVVsV2RpbFlCTTk3dzM4YWcvTlljQWdD?=
 =?utf-8?B?NVJOUWRZc2VLUVhDbCtsQ09MUmdCTGxLc1drYm9CWGJrTWZvYklNK2laU2lr?=
 =?utf-8?B?M2hYZXN6cnpJK2ptd3NmL1RBUG8rUUhBaE53L2N1U2MxRXhZVFR3TjZSVzEv?=
 =?utf-8?B?ci95a1JzVjhHSCsvTmcwZFNrYzlpVGdIa3hOWSt2M056ZFNxUHRFQ2JoWGhE?=
 =?utf-8?B?OWdUdkszSXVHRlVVUk96NVI4VWVmd3JqdDlybEFxTW9IUHNmNjFjeGFoYWNy?=
 =?utf-8?B?SzYwbEkwMGlWTTIyeW1aMjFPRktZQ2N6VmIxNzBjRGQvTkdnM0dmVnFPMHls?=
 =?utf-8?B?VEJMQ1pvbDRVeVdOUThvckN3aC9VVmNoT2lPSEQ1b1Z2WEhBZzdTTmgvenh5?=
 =?utf-8?B?SG15KzhhL09Pc2VCTlYzTjUvaFlOVC9ZeDVXc1pFKzRWNG5FMHlmU3E2Z2Jt?=
 =?utf-8?B?Y2RmQUJrTmxUb0dVQVBkY3F5ejY4dDd5TmxTOElZczN4dEhjNHZoaEZ2WjhH?=
 =?utf-8?B?bnhHenlqOVpNUlpscS9YTkFQWlVWRkFiNVh6SGE1M3BoeklkMzNtalAza3NB?=
 =?utf-8?B?Q3JuRDJUZkxLenBHRzhZTWdvQWFXSmxUdkFtRnpFc2tCSmJHdjNXYTQwMU5W?=
 =?utf-8?B?bG1OcVNnTERrWEpyVzN4UXJlR090bUREcEZiUUFRM1BFRFVITm9ZZlM0UW8w?=
 =?utf-8?B?MjM2QTRCVVh6WHVFMU1kNC83UHNWRWFPK2xiTEdkcEhWNlFhL0FHSzhWSHBt?=
 =?utf-8?B?OGxsQ2NjdFNTSERMVCtxNFloaVcvaHpZVm84UUJER2luejV3azUwTkRRbWhV?=
 =?utf-8?B?cVBNQXFiKzBDaEJENUltejhhRjJ1eENxSXVQd3FiT0NUSlpJS0FPTHNWRnFE?=
 =?utf-8?B?UStSeTgycUJMTTg4c0E2ZlA2UXhlY25tSkFmdklqL001MEgrV2xYRThOL1hV?=
 =?utf-8?B?L2JORjhHaW8weHBFdmVkZ1gwaDZDMFV5V3pmYm9LTHVzRlg2eG9VTjdxL3pV?=
 =?utf-8?B?OS82U0s5U3Y2K084NHRVUTRSNWtKUUNtTEZmeHVuNXZPSy9xSisrTWNBeDg0?=
 =?utf-8?B?ckVGZGRXZmtSdnVCaEI2eDl5aW01RlJDaFc3bHJUVndaQ1ZwM2JHN0dWM3ph?=
 =?utf-8?B?anJ5aEhNMGdFdTZqZ3JzZm9FSk43cC9oN0tOTmp4dFcwUTVxektheStXeXlF?=
 =?utf-8?B?cEVrTzFQeStRSURoUDZscms1RXovL0N6ajRoNTVJcWllWlNUYTNGby84UFhF?=
 =?utf-8?B?Q3lSWHpSVm9JTXVRVDhHUkRjbnl6bmRZbDdhNUg5Vk95aTk3ZTdSQXUwSDIx?=
 =?utf-8?B?TkJUQnZOZ1ZnOFJTOEt5UERKVFVRUllUM2sxL1N3R3BjVEhBdXVjbzJYNlZY?=
 =?utf-8?B?dEFsV2RGSDRvYWdNNmJ0d2xYVkpRQXNxMEZlME9Wb2t3a3FFMFBSZUt4eFIr?=
 =?utf-8?B?NG1VdXJRdDI1UWFjOWZvYkhmMFZJSEJJOCtjWGdIWElaTUl0K0hnb0h6KzNk?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2f6fc9-d339-407d-07d6-08db3470427b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 18:21:36.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T4DmhbAJLiyuzute+xcjsqm4g9sEDqlQip4txiHUSsMYJLkFnIFbuvcCsqkPh76UI9D3CVoOvAcGy2ZZH64G7r9ofaiyoTWFoAhj1Wu1+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/2023 6:43 AM, Peter Newman wrote:
> On Thu, Mar 23, 2023 at 7:08 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 3/8/2023 5:14 AM, Peter Newman wrote:
>>> application container, a container manager must write all of the tasks'
>>> IDs into the tasks file interface of the new control group.
>>>
>>> If a container manager is tracking containers' bandwidth usage by
>>
>> "is tracking" -> "is additionally"
> 
> That doesn't sound right. Did you mean "is additionally tracking"?
> 

Yes, sorry, I did mean "is additionally tracking". The first
paragraph introduced the container manager's role as one of
allocating resources. I found this adverb to help with the
transition to the container manager's monitoring role.

Reinette
