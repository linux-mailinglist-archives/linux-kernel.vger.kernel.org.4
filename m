Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5221F64DDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiLOPfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLOPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:35:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C36915804;
        Thu, 15 Dec 2022 07:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671118552; x=1702654552;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UzOBt2ik43IGhJKBFGjLWPTv1irdn5mz85qfG32gysg=;
  b=cLwithXtP9zMCma7LAS7nbXVSOmof2YymKhkTEIhA3tR6M5Njyrf8bOv
   aWfh0vwlvjsl1C8pZJWK0g/JIXtdnm0BEILghCdw1R2+SfptHUblv9uPV
   Wkc1shvcJmQY3LXpb9U3WS9Faa12IpXOysZq8cU4GswEeOxLi3pjUKhZu
   SOwY12XWUrQ8ItU6m4+QUZLT7HyZERG5rZLGMUIqA3RBWluNcwUrTX/aN
   5bXc06Ws44Is3car68fJAzXiZekRscEhB5tPjX8sVEoOIcwOkBzCGVDbN
   uXQQYFPmZXEXBo9VQF5fr3xegJE5wKUhTWBu97gzf2/g2W9+YsVfq3MjC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="316341417"
X-IronPort-AV: E=Sophos;i="5.96,247,1665471600"; 
   d="scan'208";a="316341417"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 07:35:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="681945199"
X-IronPort-AV: E=Sophos;i="5.96,247,1665471600"; 
   d="scan'208";a="681945199"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 15 Dec 2022 07:35:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 07:35:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 07:35:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 07:35:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g45ATGHZd9fwlNP/pXZYMrpy6QRBN7ubM6bIPeEITMr4uYEYkucfjoXr+z2RZq2NTllsSqdtPA4ET2ceDWcgNmNhStlzCUlqqLRV6ddOZ7bU368r1/VVEbaFS0XNtffayAoOzkO7LzgTOZkVc4nerQo/nnRgfbbJTd3J8wBERi3NkGK9Jp1Q1Hf7Da50OaYdl+UwK2MAoNM0noqdY0HTgQEsMt9S+BNiV7c6PffHlBVDgvgN/7lI1eMLliuZiD4yLW1Jz+7KlM1MHy6Zv1MbwAYPxO5/roFbmkmJArX+U72C/AimMBp+sMwRhvl53lsr0VQ1WjChdVWjWpKnl9diqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVu514IurfuSlJwiAk6ts7lV23mVjotFKEy8ZcVkqrM=;
 b=WArMCC5TobeQ+5msGAKP6CMh1lU6Na585MyEtfuBgpeeAU9u0hXp/GHBrWDhipkAq737/HnKXDShdJQ0Y19PtlI5mLsbcRZbKWSr3Mc2z9NWeIsu32og49KDlDz34tVWbDPnvqsfCa2w3eOGihj5V7o5xH8Hlos6cVVQ4U0CqHABaN02FdKnhVM/nsCQu9E1hqmtd6wm3ohqT+JBrZzLwFvOgxJAQEmSIn2VipTmROaxiNzzfhiinaoTo4P+T987O5KmDHToGZYDcdnfIaX3fqmZAfer0Filw6+5T7JhPaverV/XnjXFiby+YRAzJLg3b4KCSISfWXgETI2efknmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7261.namprd11.prod.outlook.com (2603:10b6:8:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 15:35:46 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 15:35:46 +0000
Message-ID: <f44e1e4c-ef68-7818-d4e1-ffabc92087b3@intel.com>
Date:   Thu, 15 Dec 2022 07:35:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 00/13] Support for AMD QoS new features
Content-Language: en-US
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <MW3PR12MB455392E4A81DB52A9B6B0DB195E19@MW3PR12MB4553.namprd12.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW3PR12MB455392E4A81DB52A9B6B0DB195E19@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0088.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2c8876-dc87-4c6a-3f76-08dadeb208cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+9b5Sfgr9aWgK6fKBfTVYSwwvrmcj6nlkzje0Lqqjkjp6YG8s82uhlkBFU2bH2VQ8W5CpqGUbVYOLBDk2j3iOtWLGB3pSmj0882v/JXxmbQ5xNJKN7bxQTfyaK627pA/OmqeKhDGOcScB/fvkhC4az9gN0aMa/5uldra5wOOQRYzw1zCI7v8Oqt4xWqk+ghHu7bKi+HyoyRyzXNNgnBElQvdXTdceOaCXTANTcFsbmFb4ovdiPaQadvRqSnrcYQtUSbe2GSpYmezrQDy8MbgBfBtPvWpoCHJChRE5iuSupYC/pOtF9tQBGj8CvkBlY408dK4I9SxtocQg6nbLS1p4zItltBu7Wh+vpponPss8GuSzcAG65SME8JNFswj0yKNyVwx8xjGK/wY4p8zCELV8Zsc3kt1/ztmrh+nuuAf4u/bNqzGwi+musphCmKPQwsZA3r4l/8vFuU3MfoIRG7UfvulLEL2P0mjDHAUe5Vut+cv7mHllV427xzUYZV1LavW4K6+y+2PXdHHt1oJzIPTXgJjUqCQhAP85vC+N6R+UZBi3p1UQWoBwNBHFyZHnbvzdbpKodJnWuFFf96pjynkFI1gFdoFyQx2xIiBNg3JTYYpPuVF6cphV7Mt1h2Txf08I3NOpxobQp1UXBPb9GJorBAKTY2zD1Tpk0nwnNcXIRs/qnEruZlKQpdWe7mEf3uLZhlMdFVbhOHjrfRY+nYbZJ9piEbA8GqfdIRWLg+eZBfs+6GWO9YModXgNxRq9vp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199015)(2906002)(44832011)(41300700001)(4744005)(7416002)(5660300002)(7406005)(31686004)(36756003)(66556008)(38100700002)(8936002)(66476007)(6506007)(54906003)(26005)(4326008)(110136005)(6486002)(316002)(66946007)(2616005)(966005)(8676002)(53546011)(45080400002)(186003)(31696002)(6512007)(86362001)(82960400001)(478600001)(6666004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFR4aVlqNmZ5Q3k4N0NaaVNKd3ptYURuMEk0cUVkQlVwUzlFY2tyR2d5L2d3?=
 =?utf-8?B?VkNRSkxaclFPL0tyV09iR1hVaWJaTFFnR1d4UVN5U3lIQWhJUVdvOEhCZmVr?=
 =?utf-8?B?OWtZQUNzZ28rcmVxbm1CdHZJUUJ2SUFVVVZtZW5NQ0p2d3lYN2dybTFkYWVu?=
 =?utf-8?B?RDJWSi9mbmZPY0I2OEJrVkpDTGw2S21PWjA1TlplRmpJZjlrY24rU3dSSnYw?=
 =?utf-8?B?djFpY3dyYTZhNEw5OU9PYTNpczYzMkIwTVdyTzVPbkZnaURXb0U4KzZRenlG?=
 =?utf-8?B?TExlU1RaNE5DQ1RXNGFib1BXZ1QveC9GbVZJamx3SW1KeUpCUndId05rQ01W?=
 =?utf-8?B?VWRibHh2bjNyYVZrYzVGYkF3REpGTWYrTWlyZ1c1VHphcjN4c2QzaWQ0U0Jz?=
 =?utf-8?B?dFRpWURpT1F2QUMyL09xOG8yRlZqZFN1K05NOWgyTlZlYlAvOE5HNjRvd0hv?=
 =?utf-8?B?MjJ2eTNmTU1rNW5aZ0Ntbm9DZ1plV1NTTlJPelVKek9lY05jVGlOTW84eXRY?=
 =?utf-8?B?YVVmTlllaEpuOU5LV1VkM1grU3hyN2t5V1pCQTNmUldqMnl1T2dqZEQ1LzI0?=
 =?utf-8?B?NUR0T3NCTlhjeVowMnlSVzZGdWk3ZlFzN0o1eW44YUw3VnlGYVBNSGhWa0FV?=
 =?utf-8?B?VEtveWRTWmc0ODZJbXBjMlorWk5hdFBZTHhyT29yeWdzVGhQRWpUNDBSMG5D?=
 =?utf-8?B?ZGNoRVMwYjFaZjAxMjhrVUJGTThLeUZKWEM0bU1qNXNoamg5MkpGQi9sOGJR?=
 =?utf-8?B?TWNHajdVQytpUjZ0VlpwRG8xN3J0ZUhmVmRCUGtmQWNZODl2OXNvU3hqWUJr?=
 =?utf-8?B?dW9FbUYySHJ4K0lnK001MERXUGJOVEkzaGFpTzU0ZUg2TWVaQjE5MzIwcWNo?=
 =?utf-8?B?ZXNiOFFhdzRacEc0T0oxZk41UXU0R1UyTzFaaHdjRkV6R1d5NFQxT0VQK3do?=
 =?utf-8?B?dFF2MDJzRW9QMk8vei92RStldmwzSUU2NjZObDFXbktSdFUxOU1sUDdXUGI4?=
 =?utf-8?B?SkFVUVBHb3ZqRmxnL2NpVldUZnFHcXU5TjJIa2RiYU90cmFBekFuQWp2Z3hT?=
 =?utf-8?B?RUdMQ0VwQmxvMDh3RmRpUmNsTkpZL0dpWEgwcXZ6aVJsYXRYdWkreUZNYThZ?=
 =?utf-8?B?UElTQ2Qrb1JBYnBaS3ZHRng3dGVkLzhrVTJGQ2FKRTJQa3ZlSUVGaDZRWitI?=
 =?utf-8?B?TVR2TGR3UTJjT01lOHQxdU92Sm5LNk1FM3lFUEtkK2Nxc1JDWXBqZHFvOE83?=
 =?utf-8?B?RHFCWWZEOWc2bW4xZEFLRVc5RXl6amFJaXVyUU5vQTFvUjJFSFJDNkJ4YURv?=
 =?utf-8?B?RWhMZVYyQlJRMGo1Wm92dG95UEJKUFA5R2o4WFhVQlFISXl5d3RXYm8zM3lU?=
 =?utf-8?B?K0tsSlYzNEdIYVVCVnFRZ0QxMEJqcU5BU1RLbmxpd2haWXVKTnpQWHNIc2hE?=
 =?utf-8?B?NnYyZHM5VVFFSkpsTU8yeDRXc1JTbFYrbE5oZ0tHbG9jbUhDSWZVK29uZ3Q3?=
 =?utf-8?B?MnNicXd6dUw5clhNTGRCTG1RK0VodnM5Uk5ORytRSDF4YmtxTnMwZzdXREdj?=
 =?utf-8?B?aFhRZUlaRzNBZTFobE9GR2ZwLzZyL0xlVytLeG1ETGpYSjFrRGxMUXZCZHkz?=
 =?utf-8?B?UFdVdTNGQTBUL0xaczFVY09QZHYzZFMzQTBIdHJvdkRDTWRpWkhBTVVKN1Vj?=
 =?utf-8?B?WHVmYWNqU1FPTFJRY1JWcFl0UzFEb3p2dW1tV2tvTTVhZXpFZ0JBcHZ2V2cw?=
 =?utf-8?B?YURYanhyVVlzVXR1NEZEbThEMnhHWXd1UHkxK1dqQTZXS0hRcHhqWTd6THJL?=
 =?utf-8?B?ZjdnS0Q5ZlVvYUVzZEp4alJzdGNwMXN2cysvSnFmUHJUOTAyc3lEQ2Q5MjNL?=
 =?utf-8?B?RVNVZHV4aWQxT25CMVZUTjZlVllveXQrbEtnT1orV3VuQzJmSFF6eHlJODdl?=
 =?utf-8?B?NXpwdnoxT0FPODFBQXAzc0xTTzRYK25vSGZmR2hHcW5BVGpFWkhyaEVlV0lQ?=
 =?utf-8?B?bUVwKzhUQ0dIQllmR2JjS0lWT3dnaGZ3U0JqVG0rZ2NyKzVhd2kvdUw4TG9t?=
 =?utf-8?B?cG5TN1hZa1NkQUp0YVFyQmFkaDEyMEZtQmFKOTRsd29MVmFBcmNhM0hjVlQz?=
 =?utf-8?B?T2M2eXVLNTkzQzlWa2RNUTJNNHVhS3JGOGJkZ0xIWkxwbDVXYjFlQ0YzbFdU?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2c8876-dc87-4c6a-3f76-08dadeb208cf
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 15:35:46.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RabTYmO3HXvItk6DnLB+gHhDpIbFFFeipYRgumsfCrkt0+HfipAAjs6JidntHxbMm4a/0ZAbRwD1sl0t8RkvCV01lMVytvNhrqaMs872YGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7261
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/15/2022 7:08 AM, Moger, Babu wrote:
> [AMD Official Use Only - General]
> 
> Hi Reinette,
> I am planning refresh the series. I have couple of changes for patch 10.
> https://lore.kernel.org/lkml/MW3PR12MB45538A17F57BF80C21BB46C4951D9@MW3PR12MB4553.namprd12.prod.outlook.com/
> 
> Let me know if you have any other comments.

Apologies for the delay. I have a few comments that I will post today. 

Reinette
