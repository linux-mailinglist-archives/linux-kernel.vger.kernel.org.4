Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9106E654C77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLWG12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLWG1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:27:25 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1057B2DC0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671776843; x=1703312843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jgw7GaYI1fzPNLxOOJLZKpxQmRt8znlt5ibTNkwDsHE=;
  b=cmrnnXhTOqtBfgCkQDNXx4KmnTlDDDKk1EEWNW6O8z0EU6J8uurqE1PQ
   72Av2+wYvgNjnwDscGNZtXlWyTl4u0/QKh5dqV8Xzyu7CqOAxCiJPWRQ2
   Vp0h1WAqYD7sLYaDZh/UtEzOKPgE5aS6w7I/39qohMkWq9NLvrFfHxpRG
   BLni03D49Ma2Jjg+apwpi13syrpg5IIgIg3syAKDSTQPyWp/Ix5bNkEC8
   E+LnH/cVQLw3AqWSswTqtIVNBMuRY+o6bTzenUnBRhua7abgdx0uEDco9
   xx2BIw6RdvepPqmT9dZchr7hemATIkx+vWw+4gW1PWj2xWGMI3zI3jHV0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="303754405"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="303754405"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 22:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="715417893"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="715417893"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 22 Dec 2022 22:27:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 22 Dec 2022 22:27:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 22 Dec 2022 22:27:20 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 22 Dec 2022 22:27:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4jC8a6Ng5u1bJaazZ6Cu7KKYdvQko/NBioUIxMQfyNGk42Yrply+4rP9CQAzXBexqA0K+ADXdacelFJ5hGF3J/2xiCzgU3xLraiGmRazVvLYhxxRga0zh6IjH16tFfBLkEdjJpB5V5ftqAQji9pqH2gaDmzC0c9h+76imH4yGyKQh0PqirjcCvcFwoIsmMFwCmqrfH2I32GkQninc0jas44oLJTaw1N+wQ6wLxMSCfLkM9YBYWp6hgPyO57JEzBaMvCeitZGsk8RVZoxsODu6Fw/k8NnJQAfny42rSBOLoAgKUIHuGG6Dfco8Z8/bX2Dy/iIdcw4M6PKqmUaVPB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtE0trYz621RWO+jsmUNVSFUN/hgSIj8VhDh+Kw7WnY=;
 b=OP+OvS2scmvkIyxbH9f26nKiA2dG4epSTMEVWwpo60hAVyZF5hiEUQo7zbj4RpZVQ94KLBzZXD/AnhZXA2wqnlED/YL9DhmzlrFiJEnVjP9jvkIielP9J2ZyUup8wlthOz5SP2QU08UjuGb5PDQbTF4+G5eu404YDxHQOJxbq+7GJxWhhVfWcShafhKNk8SbD7RE42omCSEQs6QRu3jfE/BFKA+KKxbz4dmrbUbYu6GPNxUIdLk6oD7ckZPqWVy0AO9NB9SoVxu4UrDJBEDeihz7mSiIFfIPOKWxTRXp4Zpb4g1m5z/frzaS1/UNwxkqTmlXz1K9QzT03zBfpcrfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 06:27:12 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::505b:18be:f1dd:104e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::505b:18be:f1dd:104e%9]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 06:27:11 +0000
Message-ID: <99bc3831-8f5f-4a79-b0c3-8a492a7e5867@intel.com>
Date:   Fri, 23 Dec 2022 14:27:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [linus:master] [mm] 0ba09b1733: will-it-scale.per_thread_ops
 -21.1% regression in mmap1 benchmark
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     Yang Shi <shy828301@gmail.com>, Yujie Liu <yujie.liu@intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>
References: <202212151657.5d11a672-yujie.liu@intel.com>
 <CAHbLzkpVr62M4dWCb9J+eMErDvxx0hiTF6DD6bp2qEivzZYXCg@mail.gmail.com>
 <20221220204845.ul2wf4bj75dl5gbc@revolver> <Y6JwkEraN79acHP0@yujie-X299>
 <CAHbLzkpF4tuuukmhqC1soeVUaS4D5XtDjNDugy9t9D77s_xG8g@mail.gmail.com>
 <ed6c9173-dbbd-6275-a285-04b21de26f13@intel.com>
 <20221223024321.itxwvcdyckepnyiz@revolver>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20221223024321.itxwvcdyckepnyiz@revolver>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|BN9PR11MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f3ab60-cbb2-46df-7e72-08dae4aeb956
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnAqZGcD3igpfxOUE+4CLifCIHRCfIthaoSSPYLdMVjuOYwhaVYxB1OCoHFJPoutwPG6PbxETc1wZk7tq0NY3RV+cifbm1rEthj8Cnqwm8/+tGaDFzx1rX9biXEQODAaYGwuEjbMUtoLhq0+iFe83Fh8vJgyRgxb3mo6hXhlwm0fm96MgeyzrXWe3/KJmodzLbjERNCByp1Ea2v6CJWkdDjvKZH5+mTJ13PjBmq1jpLgCmRmC19FlMCUpnqpZWqZW/WaDltSOLmOC7Mkj084/lCwAEHzi/3UsxO976OPVJ3gdXRbafLrTSC8ROUc9UcpHt9WsdDhba38LJwhkeyKK9y+nYbXDzvuk5n3Grp9jaJdH4xusowhQoLCfROGfNESdaVm3xJIJf/rSyCKH+gjQaQeg3KcuGHONlnC0fIgCQqT4IXJ3Kk1GOCzQMPa943jDY2XE9IEtvdQiVZFKfnswqvFeljCB47cOPco+rK6yMxK+CGBydVXaWtgchk7d3Y0iXBCQ2t3tSYMaANIj/AM3abcB/TS4kDYbRs7BORehzkjv6w3OjkNuZdDaGRjtCn7y1a6ml4E5XqIEmVg8KSbNhh0l1hKyqIs2Lsz6zZGa9HoHsB5agdDEpzTUc9okqE+g8fiqyNrAJqvJIqlEFzViRqO1Czbm12k6r1qMOGsdLFT/smg+MCI1OLBjFYR/UF8+/GOGNZvk4gLsXkj+vaY7BcnEXmy+192OKLUOwQPOFkRYA23boDkcc8oqONSY1rGIO5+HNvFEXw96tuyB/v1QHMg0evlwDHSS5S+VotIndEHdJ1wmV9bAg4jQWnDoS55
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(8676002)(36756003)(82960400001)(66556008)(6916009)(66476007)(31696002)(4326008)(66946007)(38100700002)(316002)(86362001)(6506007)(83380400001)(8936002)(41300700001)(31686004)(6666004)(54906003)(26005)(2906002)(5660300002)(478600001)(6486002)(966005)(7416002)(6512007)(2616005)(53546011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlDeHRoNkx4emNEYjZTdEYwM1dGZTJNTXQ2c2pzYzdmMlA1MDNEb21USHpx?=
 =?utf-8?B?S3BId21meTNFSnBSbWNVUWZxSzQ3MFp5NkNMRmczRWZQZXFyNDBIRHZqaWNG?=
 =?utf-8?B?eWYyaCtKWE1ITmZIZkZuU2dhSDgzY1d2bnduNWQrRjBnYXNnZVQ0NnFiY1l3?=
 =?utf-8?B?NkxQMFJvOTZET0JaSFcrMk9lS2FDNVF4UVp3UDh3TVMwcFNnRmtSb1dHUEo2?=
 =?utf-8?B?T3ZEZnYxRzVFY0lLOGdOVUw2cjMxdGovMWU5aWVKS2hudEFqY1RoNEJLUy8w?=
 =?utf-8?B?ZTFqMjc0Smk2SFU3Zmp1cVIvMjl2REVPdURjYTRyQWxSQXRtV2dtT1FEd1R2?=
 =?utf-8?B?bDgrYmwyelV5dzAvZ2NvMXRqZDQ5UUd1TDc3UldadU5nT0M0ZW1zcDRkdFRl?=
 =?utf-8?B?Y2Q2RXBsUEIzR1ZCMUl4TDFOaXROWld1enhlbmRGSmZ0L2FCQm1KY2JRRjBR?=
 =?utf-8?B?SFpSLzlmOXJXeGE2R1RJYnU2ZktTSzE5MWRaem00d0RkakJUOE5udjdzQkIv?=
 =?utf-8?B?UGV4T05MYU9xU2lrSkxaUFgzQ2d6S3FuMUx3MWlTTzZuU0wxeXlnRTh3cHc3?=
 =?utf-8?B?MnJ6QUxKNTdQZWRSRG12T210SEpzUDFQdi9qMGt2MkR4cGRDRWN6alpoeklG?=
 =?utf-8?B?bjNxKzFSRHdUVDc4WHNWVzNKdGl6TVEybkhNeTlSRWlieW9rd1V6ZldQOS9R?=
 =?utf-8?B?cExGbVNhWlhiU1MxUnRKRm5IWWtndC9pT240Mk0xWkNoN1pTL2M1TXYwRVBy?=
 =?utf-8?B?bXVrMnlUL3VmQmFleHdjbDJCajhNV2FwMURFd3RtbU5YdC80aVRaeVBQSmdV?=
 =?utf-8?B?eWExbzlSKzRiNWdVcnNJa0ZEODZISzlRZ1hoMEM4ZmthS0ZoSVZHaWpqeXIw?=
 =?utf-8?B?RmxWSE5NNDZOL01IelM5YjhSQzlaUFE0cks5enBybG82ZXVZK09LM1Jpc3pZ?=
 =?utf-8?B?ektpTWY3a0NTcm04bmNKSkxGYUREeDA1TjNBMmdIRXdyVzN6Y2tNRHRBWGY0?=
 =?utf-8?B?Y0JJZWFPczN0K2pKYjh1WW5YdDAvTG9UaHhvRkRmM0JBTGFwRFJ0QlpQbDZS?=
 =?utf-8?B?Y0J2NGNTR1Y4NFpwOUNTQnRmbHpJMVh6TkdsYUdNb1ljQVJsYjY0NmlDdFNi?=
 =?utf-8?B?dC9neno3aUdiZVl0TkFOTVkyQlZsQ0M2a0hJbzM3TUhTSktGWENSVWp0QkEr?=
 =?utf-8?B?TDQwYU1lVmpYM3gvQ0IwTkxIajVkTzMwdnlDYThJMU9xa0NBNkplaTlVSWlW?=
 =?utf-8?B?aW5JYXkvckQrMGFkUnN3bFFrdlVGU1d5Mmx6VjJIdm9VekJDaFBCbUxxOWEv?=
 =?utf-8?B?cHVHRkxSa1orMTZlTmtqRTI2WHRtUkFtOEtmVXRxcHdMTCtWaG5TRDBXcC9o?=
 =?utf-8?B?WjQ1TTVPNmJTcVE4REtrb3VFQklvVlVWbEg2ZjFOVEEvQ29acWVOUXh5TE9x?=
 =?utf-8?B?SU4zWDRqbDF4OWZzYkdUQitja1R5RS93UTZ6T0l1Wk5heFlFUmM3MXFOK1Qz?=
 =?utf-8?B?YmRQbWRvVEhza0RGWityanZsWENiajRwMXZ3cUlWWjJqd0JUMUh2ci9VdDJP?=
 =?utf-8?B?ZmZUY3lyNFhNV2hHalpsaE5rTmc4bjlSUlRjZCszTXFOUCswRkYxL2ZTYVV2?=
 =?utf-8?B?OHREREpHSVdsWEMxTVdXRVEwWTAxV01pU0ZKMXBwRlJxMG9pSkd3bHhQdytE?=
 =?utf-8?B?TG9zeHVPd2g0akFCL0djRDB1dUhSWHplMUsxd3Zyd3UwVzJKc25ySHU1aGpG?=
 =?utf-8?B?S3pscVJ5ZU1pTEU2VTFBYUpOS29HMXhuS1gvYTg3NXdndEphbHlOU040WjF0?=
 =?utf-8?B?bmUxeUxHK1A2U1pPcFBVTFJ5ZEtFU2RiNjdRTllBS3ZFMHVjbWtUQnA4MVVW?=
 =?utf-8?B?bWxneWRraERQSlFLT1NEaEdKckRRQUpoUXpDY0xTYjZ5WEExNnJJTXQ3czNP?=
 =?utf-8?B?V0ltNFJaSWhrbXNmYmtLZ3diUHE2c0M1TXFXVEJHdXk5STl0a1pldUptUEFk?=
 =?utf-8?B?djRLVmV3aXkxUnpydm1IbzcrZWpuSC85TG1NOFNmK3E3elBhZkg3R3k1N01m?=
 =?utf-8?B?RFB1T0EwSTNBUFR2TTd2Y3lQdFJnNzVJa0RNWFVobERaVGxGbnN2a2pZVVds?=
 =?utf-8?B?ek84aU16RlUrLy9xNXhQOHZNbnh5bDl4Q1VBWlBqUXlScUhwMWd6ekhmMlFq?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f3ab60-cbb2-46df-7e72-08dae4aeb956
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 06:27:11.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILRlCi34ZudUFFPnyuvNSGELzvwVCJWDFIVg/IvH5zzrFpozTc8bh6/WeDSqOH8fSktOrMI0Zgnpl/TC084AuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5370
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/2022 10:45 AM, Liam Howlett wrote:
> * Yin, Fengwei <fengwei.yin@intel.com> [221221 20:19]:
>>
>>
>> On 12/22/2022 12:45 AM, Yang Shi wrote:
>>>> We caught two mmap1 regressions on mailine, please see the data below:
>>>>
>>>> 830b3c68c1fb1 Linux 6.1                                                              2085 2355 2088
>>>> 76dcd734eca23 Linux 6.1-rc8                                                          2093 2082 2094 2073 2304 2088
>>>> 0ba09b1733878 Revert "mm: align larger anonymous mappings on THP boundaries"         2124 2286 2086 2114 2065 2081
>>>> 23393c6461422 char: tpm: Protect tpm_pm_suspend with locks                           2756 2711 2689 2696 2660 2665
>>>> b7b275e60bcd5 Linux 6.1-rc7                                                          2670 2656 2720 2691 2667
>>>> ...
>>>> 9abf2313adc1c Linux 6.1-rc1                                                          2725 2717 2690 2691 2710
>>>> 3b0e81a1cdc9a mmap: change zeroing of maple tree in __vma_adjust()                   2736 2781 2748
>>>> 524e00b36e8c5 mm: remove rb tree.                                                    2747 2744 2747
>>>> 0c563f1480435 proc: remove VMA rbtree use from nommu
>>>> d0cf3dd47f0d5 damon: convert __damon_va_three_regions to use the VMA iterator
>>>> 3499a13168da6 mm/mmap: use maple tree for unmapped_area{_topdown}
>>>> 7fdbd37da5c6f mm/mmap: use the maple tree for find_vma_prev() instead of the rbtree
>>>> f39af05949a42 mm: add VMA iterator
>>>> d4af56c5c7c67 mm: start tracking VMAs with maple tree
>>>> e15e06a839232 lib/test_maple_tree: add testing for maple tree                        4638 4628 4502
>>>> 9832fb87834e2 mm/demotion: expose memory tier details via sysfs                      4625 4509 4548
>>>> 4fe89d07dcc28 Linux 6.0                                                              4385 4205 4348 4228 4504
>>>>
>>>>
>>>> The first regression was between v6.0 and v6.1-rc1. The score dropped
>>>> from 4600 to 2700, and bisected to the patches switching from rb tree to
>>>> maple tree. This was reported at
>>>> https://lore.kernel.org/oe-lkp/202212191714.524e00b3-yujie.liu@intel.com/
>>>> Thanks for the explanation that it is an expected regression as a trade
>>>> off to benefit read performance.
>>>>
>>>> The second regression was between v6.1-rc7 and v6.1-rc8. The score
>>>> dropped from 2700 to 2100, and bisected to this "Revert "mm: align larger
>>>> anonymous mappings on THP boundaries"" commit.
>>> So it means "mm: align larger anonymous mappings on THP boundaries"
>>> actually improved the mmap1 benchmark? But it caused regression for
>>> other usecase, for example, building kernel with clang, which is a
>>> regression for a real life usecase.
>> Yes. The patch "mm: align larger anonymous mappings on THP boundaries"
>> can improve the mmap1 benchmark.
>>
> 
> If the aligned VMAs cannot be merged, then they do not need to be split
> on freeing.  This means we are just allocating a new vma, write it in
> the tree, removing it from the tree, free the vma.  We can do this 4600
> times a second, apparently.
> 
> If the VMAs do get merged, we will go through __vma_adjust() to expand a
> boundary, write it to the tree, allocate a new vma, __vma_adjust() the
> vma boundary back, insert the new VMA that covers the boundary area,
> remove the new vma from the tree, free the vma.  We can only do this
> 2700 times a second.  Note this is writing 3 times to the tree in this
> loop vs 2 in the other option.
Thanks a lot for sharing the quantification of two path.

> 
> So yes, merging/splitting is more work and always has been.  We are
> doing this to avoid having too many VMAs though.  There really isn't a
> good reason an application would do this for any meaningful number of
> iterations.
> 
>> For building kernel regression, looks like it's not related with the
>> patch "mm: align larger anonymous mappings on THP boundaries" directly.
>> It's another existing behavior more visible with the patch.
>> https://lore.kernel.org/all/a4bcddad-e56f-cedc-891a-916e86d9a02c@intel.com/
>>
> 
> Having a snapshot of the VMA layout would help here since the THP
Can you share how to do snapshot of VMA layout?


> boundary alignment may be changing if the VMAs can be merged or not.  I
> suspect it is not able to merge and is fragmenting the VMA space which
> would speed up this benchmark at the expense of having more VMAs.
Same thought in my side for more VMAs here. Thanks.


Regards
Yin, Fengwei

> 
> Thanks,
> Liam
