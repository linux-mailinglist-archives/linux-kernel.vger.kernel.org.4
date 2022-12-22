Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2004C653A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 02:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiLVBTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 20:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVBT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 20:19:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47782E0F0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 17:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671671966; x=1703207966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=inp4HSSP+t+Ulm+uznWg8Uh/Sek94pzJlXCZkCB8pTE=;
  b=Ox01lsz8BWV0hGrmPr11LJ8f7tzApBAhsTFJedJ0utHxIJjqW2KZWxv1
   w0rc47IkgxC1BncUyboXyp/gxsOHC3TF/X2KbAMOci/gnr73BcOKV6aiQ
   RzOHvTTZpvWXomuYzb/ePd2G+A1hU2NtOnZf8/aaTzC7Oqdasp2Ph6Nu1
   SP4hILG61KKD76ogJw3EJrhMifeOBRi6xPF+En5kF5dXT/1TCq5+c6smg
   T3p6JoWGyZqTUIU0de9Kxs/vxt999DTyXh4o9C50BpaVYJt4gwBJ6pPQD
   fk0HOLISfBYZEJIvWUBPwap5DArDqIND69yNdsrcBbmYAe7KfuEvza/1n
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="317652667"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="317652667"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 17:19:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="651596584"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="651596584"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 21 Dec 2022 17:19:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 17:19:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 17:19:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 21 Dec 2022 17:19:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXFtPYcBtKYRQf9mPp4e4oFPOJeUXm+vhU71LWxc6lDsaV0OVYr9AzYoyFGZIlj+YcSlT8ZQXGrb5b+4CMNY5oajQCAFL6GEcscou7W9j5M4pbWlYdaKOqHcrUc11UA8U33BhavjY0439ML5TD5ObKJy3uKJqEE/5MMxSNRbvzleFY8hQYoIY6AzRWLY4Aisss9+pht6gdI24ubVES7cmK4v7Vo6qR5V5u41vOgzn1vqd/kgHEf2KMCiAhz4tiRdzKNPeiCx1Mvq3fjsulKz0ePnb5Pob6UyOpKWPv8v97pYd3SsoGHbVytM5bIwYPcuYLQFr5+Qx62koJ8sG4UanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP6SvNKUWnBYr5VBqJIj3M4VWYomfMyDyIwHopXQNjs=;
 b=ENNTkdS3BdgX9AU+2sJzCjyTwr5wt54MNSptlPlb7XxekkRcqNoqk+JvvWgEDVYRJ3YHuKGvVVEah9w6EDdte/wpoyyzB0Ywb8iRffI9adzPZzoHzMnXbRKJlPaPq+RM8L4w8jPmZQopWavsz8+0XdNn0am0XYl+F+3LTbBPwdBvQMo9EhKkAEisdAXIY3QuJFJc/JiIiG+qLOlRFTiyx1N8t2Cht0K0KaUpbKjI9uiOJcVSAdtyT+3x8jNJKBnqQ7Lm0TSy+d+lV+aQQB0Gi2fAE7MAYI3z8W/f8ODbOK6hNb+ggJZuQzufrtS1ykTdpXLeHJVlj6p0H6sVVhCC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 01:18:46 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::505b:18be:f1dd:104e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::505b:18be:f1dd:104e%7]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 01:18:46 +0000
Message-ID: <ed6c9173-dbbd-6275-a285-04b21de26f13@intel.com>
Date:   Thu, 22 Dec 2022 09:18:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [linus:master] [mm] 0ba09b1733: will-it-scale.per_thread_ops
 -21.1% regression in mmap1 benchmark
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, Yujie Liu <yujie.liu@intel.com>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAHbLzkpF4tuuukmhqC1soeVUaS4D5XtDjNDugy9t9D77s_xG8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: d4385fd4-119e-4e84-aca8-08dae3ba7954
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmnPCGU/fsurDbzJZHJ5J93rT+qfX0EnJd0D9pPbUssmHsKgdgYDVM0eebOxbjlq2ba443Xv5rJwb8LzwI6Cmq7VKwI5iElb30GNK8JBQMYvY0TM6xV6Rzd/zN2khrar7WWSzI9cew5KB9cB1Xp1dgqW7uNY0ETFmh3CzFHMwPU06itff7bkq8SBgr0x7jdKAxblxwxhNh8lIJhzcQvj0aw8xAy3RQcLa+aYtrZ3QIBBm7VWDeCXYryfz6m3RHca1KCbn0e3S77qt0M0YaOiEK2VzBWploi11+DsQ0f6KEobakZJmeFxaiH6EDeBSQyewd4BFbFzPsdjIaW7grqVKYLgkKUUhxCNiuYo5Xqkk275S2YlhxpDCdyReA9yqidAwNXzR1CT648bAu5Hhko3ai0JeR7Jc2KEv7XyWqnEZhDIcvxvjhbKdHTfs+O/p3/2ta+iJQzIsWrhAwNVLv4NEmPN4IeD3J9otAZ/y3PP3leL2uNF3HWSMZ/JYiyE2jKqA0FB8rR2CIwgLomFIpQkyvxPA3maN060BSWPn1xhQ1VRNtlh5oMwfkvCXoXDM3pw8pVQDElkU9MkHpINPgKmmOvTTEXyKkqVTUWFb+w0jQCxSfPyPrx2YlfeAb2XfctQVB38/dzZHVEZHiclmPwnPdpvbovdk+aqTIz/yVtzoKdQXyJcUxwbVbIt/4KQQM4wOYq7WHR489ZqJnqdDDhV2c7srXinDU25L6pq1fxotHe42/BhBMY3dZyesGRS292qz2WS8PjDpT9BQ5ubiiU0G6h3fDaD7Sk8Uc6dCXx20ha9qqBOoWtzdEOVsTi8pQ11
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199015)(36756003)(2906002)(38100700002)(82960400001)(7416002)(5660300002)(8936002)(41300700001)(83380400001)(86362001)(31696002)(316002)(54906003)(66476007)(6636002)(110136005)(31686004)(8676002)(66556008)(6666004)(6486002)(6506007)(4326008)(6512007)(186003)(66946007)(26005)(2616005)(478600001)(966005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anFZU0NzTG1RVVhTZ1FrVTZVNHZHcDRqNm9uTGxVczdYbS81U0wxeEN6aGh5?=
 =?utf-8?B?SDNzbGNmb0JkS3ZMYkd0L0R4Zng2UUhqVE5WRm42c2NRQ3luN082eGthZFFR?=
 =?utf-8?B?TnkxNkhkMTNVdkgyS2hHWWpVRGwzM0UzU3RORGtWWDF4ZWlOdDhZcld1eWVS?=
 =?utf-8?B?ekdvdGFsY1NmOTg4K1NIMXVvLzd6dXFOa3p2aDJURnptODJhemw2ZW1uVncw?=
 =?utf-8?B?S3N4b2ozU2d1Q0FtanBYYjVUM2dza1dtV256cjBhNGNlaTJzeE4vZmZpUW10?=
 =?utf-8?B?ZWJyc0lIdmkwbVZDaE9tcmN0YXFMVW1LNGFKbHY4RDloaWVuUS9xTzJ4S0dL?=
 =?utf-8?B?YzZ0dGtvWUw2RGg0cFN5K0tCVzEzQmR6U2M4SWtMQVNPTk1sZXNTdzNCWmZJ?=
 =?utf-8?B?TkQweUExWVh0b3N6WHA3NEdQOVBGZ0pFREN6MXZoWUJadTJCS3p5Y1gra3pz?=
 =?utf-8?B?TUl6ZVM0aEw5WVJiYUUyS052bk8yTDVQWkFSbENSS1o2WnZnbDVsbStqY1Q0?=
 =?utf-8?B?RjZ4VkE3YzN3VHRDSG1vbGRnckpNUWRhamRrVC9KVjZxaUhVYjRHNlpKSmJR?=
 =?utf-8?B?eXkvWWNKTExpQzhmZHFCNDlkckViYjBvUXFyRmdiZFY3V2xaZFQ0Mm5GNmhI?=
 =?utf-8?B?d3ZxcGxTUThocVAybU9EZ3NITDMwWUNZK3lXdjEzSnpsTWZTMndsR1Nnckh4?=
 =?utf-8?B?VWFVRHhSa3Bpd1BYSWJ4QzNvZEl5OUh0eE9IWnY3MDg2aFk3VU9NREw4M1Uw?=
 =?utf-8?B?WW5KbjFJbDNCMFVpelllcjVXRVU0UDg5SC9XbElZY0VzbjBob0NreFhQTzBJ?=
 =?utf-8?B?Rk04WSs5NVFIVEl0VmRMbkpGUkdiUXhWcWJhVHByWEI0L1ZkNndUTnNobURQ?=
 =?utf-8?B?YThSb3c0T0FLaFEyM2w3b3dxK1I2aUQzZVlRdzZITE5zTTlyakN5a2Z1b2Nm?=
 =?utf-8?B?cEpaenFRbitIeDRMZmtFaDdFUHM5ZjRER0FBL1JBSzZZd0IzckEyQlBHTTVF?=
 =?utf-8?B?TkduenUxMWFtTjRDUlRqSnprT1J5MkNKVlB1SGowWFVEcG5aZzZDbWVwWjE3?=
 =?utf-8?B?bk9xeEViUkMvZ0tWUEpBUWgwemswVzlDVmtEUnR1Vjk2Zzl4NmthYjVKdU9L?=
 =?utf-8?B?Yi9SR3VCZzNueVlydXQxZHBmWnh6b3dIaURwVGE2VEsycDV4bWMyTnNLbHZx?=
 =?utf-8?B?YUhGYkpPQk5MS0FwYVk4cGhxSldLSlBXQ2NNWG8xbkQ1cHV4NWpVVFBWd0ZF?=
 =?utf-8?B?ZWw4WlZ5RkU4eVFHcDFpU0hNWm9jcmhITTRTUVhkUDJST1gwN0hLZUVlMWM1?=
 =?utf-8?B?bVM4SmZieXRNRzJrRDE3WHIxK0FOSU5qdHJ5TytlODlPcUVLT2pLNmJ3Qksw?=
 =?utf-8?B?N0xPWjRWVE9hMldxNHpFbHFXK2FhVTR6YVFmeHVTOVVBd2UrOGpwRi9STU5n?=
 =?utf-8?B?aUsxZFg4REZDKzVaY0VQaVNYT0NnSmRGUDFSUWI2ZnlnWFhybk1WcUU2SFZE?=
 =?utf-8?B?N3VvdGlCTm9xMzEyd0VaREpZUW0yTm9WYjhWZCttUWxiWEFWVjNpSXhyTTkx?=
 =?utf-8?B?M0NTMFU2NU50eERDSnd0UmNJajRWWDFpOHUramJJdFplc20remZSeVVUcEg2?=
 =?utf-8?B?Q2hMNFlHYWM3aXE4RDZRdE0zTE1XQWxtMnhpSVpuQ0pCcTJ4Ti96TzF2bTVo?=
 =?utf-8?B?K2JubFAvdWZ1QnFxanp4cjdpRE5jSFlwNi80a21zcmRxM1lveHBEbnBLWXov?=
 =?utf-8?B?cFk4dk1BRU1BTXNvMW1aUGhLbWRBTFFzSm5hazBRdjdSNHZiZUExODRKNzBw?=
 =?utf-8?B?MytlMlVWR0k5em8xdmZkbmxOM3ZWa0d5NTREaVZnZkJxaVdzd05VaXVsQ2Nu?=
 =?utf-8?B?dlhRRWgySW9WaFJkRGNQVjk3WW5QbW5kaDZ3K2NOMmlRR2hBeGxmc2FwcXdZ?=
 =?utf-8?B?ZE9NVHAzUytIbjJSdWtqS1pzS3BPY0g2cmlQODFYUXdlVUcyQ01ieHBJRWt0?=
 =?utf-8?B?MVJzU0p5dmtUclB4VXp4Y3hhOE45Q3dpWkhDMkpHNkI5T2QrdVRZUmZZM2ho?=
 =?utf-8?B?WWN4U216clpiUWsrNzN1TlAvWnJGMmQrTER5SU5uaW53cGtYY0RhMjhPSGhY?=
 =?utf-8?Q?3fEaZTNBe8RFuSGcamoPhLtMG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4385fd4-119e-4e84-aca8-08dae3ba7954
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 01:18:46.8173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1hHdaguRhhT+Di4XNyKDSHGX3cTeFmphCLuutUiXu2Wz05vbb20Vh/oZYh/Sqwf6hj/3vs3BDTGIc3nvmxJJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/2022 12:45 AM, Yang Shi wrote:
>> We caught two mmap1 regressions on mailine, please see the data below:
>>
>> 830b3c68c1fb1 Linux 6.1                                                              2085 2355 2088
>> 76dcd734eca23 Linux 6.1-rc8                                                          2093 2082 2094 2073 2304 2088
>> 0ba09b1733878 Revert "mm: align larger anonymous mappings on THP boundaries"         2124 2286 2086 2114 2065 2081
>> 23393c6461422 char: tpm: Protect tpm_pm_suspend with locks                           2756 2711 2689 2696 2660 2665
>> b7b275e60bcd5 Linux 6.1-rc7                                                          2670 2656 2720 2691 2667
>> ...
>> 9abf2313adc1c Linux 6.1-rc1                                                          2725 2717 2690 2691 2710
>> 3b0e81a1cdc9a mmap: change zeroing of maple tree in __vma_adjust()                   2736 2781 2748
>> 524e00b36e8c5 mm: remove rb tree.                                                    2747 2744 2747
>> 0c563f1480435 proc: remove VMA rbtree use from nommu
>> d0cf3dd47f0d5 damon: convert __damon_va_three_regions to use the VMA iterator
>> 3499a13168da6 mm/mmap: use maple tree for unmapped_area{_topdown}
>> 7fdbd37da5c6f mm/mmap: use the maple tree for find_vma_prev() instead of the rbtree
>> f39af05949a42 mm: add VMA iterator
>> d4af56c5c7c67 mm: start tracking VMAs with maple tree
>> e15e06a839232 lib/test_maple_tree: add testing for maple tree                        4638 4628 4502
>> 9832fb87834e2 mm/demotion: expose memory tier details via sysfs                      4625 4509 4548
>> 4fe89d07dcc28 Linux 6.0                                                              4385 4205 4348 4228 4504
>>
>>
>> The first regression was between v6.0 and v6.1-rc1. The score dropped
>> from 4600 to 2700, and bisected to the patches switching from rb tree to
>> maple tree. This was reported at
>> https://lore.kernel.org/oe-lkp/202212191714.524e00b3-yujie.liu@intel.com/
>> Thanks for the explanation that it is an expected regression as a trade
>> off to benefit read performance.
>>
>> The second regression was between v6.1-rc7 and v6.1-rc8. The score
>> dropped from 2700 to 2100, and bisected to this "Revert "mm: align larger
>> anonymous mappings on THP boundaries"" commit.
> So it means "mm: align larger anonymous mappings on THP boundaries"
> actually improved the mmap1 benchmark? But it caused regression for
> other usecase, for example, building kernel with clang, which is a
> regression for a real life usecase.
Yes. The patch "mm: align larger anonymous mappings on THP boundaries"
can improve the mmap1 benchmark.

For building kernel regression, looks like it's not related with the
patch "mm: align larger anonymous mappings on THP boundaries" directly.
It's another existing behavior more visible with the patch.
https://lore.kernel.org/all/a4bcddad-e56f-cedc-891a-916e86d9a02c@intel.com/


Regards
Yin, Fengwei

> 
