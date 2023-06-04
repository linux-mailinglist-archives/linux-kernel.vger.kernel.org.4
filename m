Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BEB72168F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjFDMKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFDMKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:10:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C51BF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 05:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685880647; x=1717416647;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Bs6yeSiYjbIv+70XjF7wQua0u23+hi6QOl1SFF42BME=;
  b=NPAHvcDcjMr91etrDWehLu0m6YAgNFSOXY5RT8cNzoLtQU6x1hNCNLgu
   JRXVcQdLDnaPikZzLHRTKyE6pqQkvaS0RW+iW/BJrCYMvl+XbyHBLGVF8
   TiG2lPRoUCsbSOcJpKrjbzg9wG6GtAQ7sPT+vcUtC6+Zzv8xRtb95mAI3
   7Ry2FitzfgsZyipPzMESEPa37utHisoj+Dp6ULDhjZvOnoxJ+hMBs/+E/
   LHv1IrcZUSTZFS5nanbVxgJwjeXoZuESOc6PMWpmtaA3sZc/IBzonsKnK
   18xybklAShzweNQpbA6Q326x9lXdYyhxLF5lAQavEqTig+mumysNqeCna
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="442553117"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="442553117"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 05:10:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="658774452"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="658774452"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 04 Jun 2023 05:10:46 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 05:10:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 4 Jun 2023 05:10:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 4 Jun 2023 05:10:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8BCLflVPjEi88WWRLyEpIZQZxdEc10HD84L95RqCcNRlyFBRRlc69DEGoSwwNXzjlHSuXg6pT5mKgx12V+TA4WHlzKWSO8XKfAUTkMZvMfpcB7cOHXXWs54zM2QTVPVOW0i0dRbEL7nsUSfWfsLP/5tooH13x6BRb0pLIdQvjKBkeJTv54VlGBmE8hgf/zCO5pKcEMi21KvmtjUG79tAY4uyCZqyeYcsrXlrT9olG7aSiBVi/+1oPZBXMAYhKXp/6ticvqljWLv5uZC+KeIlnO1BUOVlF+30pL4UHPJc+ngjukMMiU6gtgUa/0lvvxbMTck7a2UT7LXIIA/AukVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/quMg/hKQ1wUdwW0xvpu9giOuE0cSD4pqNc/XOnZ4OQ=;
 b=dyf7kLGHeEknU9+ZGKhQYLscN7lXndCRfM3f14E8U5J1TQcbsmN2LIKsQVAPg0WOmn4AHLMnOLw4YQXmh92wT1uvzLDh5+ElLFK8nYHuNA30jjJ0TNSpBMYBdU34tp25af7NkE0jGz5RCH/lHzxAslDlBUkxGTmN0J+nOfDXBqvrqPqHygBOg9rBPyj2hWvITTedbkCtIaU1wZrhXlqjFmtkX2uvGDMCng43xEnCxC3Zj7Sy6shNnCTX4ikgKmevtBQa2G4mSWm1IRn8w7zXK3nFmuEzXJfjjsFpNAjjl6wF8A5F5tHRFJoqiEtF4oVT6W7Mx9VOMR4tnRtT/ix8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7214.namprd11.prod.outlook.com (2603:10b6:8:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sun, 4 Jun
 2023 12:10:44 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 12:10:43 +0000
Message-ID: <b6e07251-2c8c-fe73-9950-2b2a17748555@intel.com>
Date:   Sun, 4 Jun 2023 20:10:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
 <20230602185555.irsxyt7svz7h6igm@revolver>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230602185555.irsxyt7svz7h6igm@revolver>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfcd0ab-d8a9-4fb7-3bb7-08db64f4b87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L38sFFts0oNVJ9YS2LxWnTSkpLjl0XdyJ+YPcnBYxLJFHPyajXfg62S9nWDr6mCIc/WMPY0lp1HJ0jODDKaRTeHda7wTr19r5UzjmPPSzwU+J7DLxN/pN52sRTlCdzhuN6ndtC+fa3ZHBlJodqCEX4CPmyw/jHy6+KRgt9ksij/E8W4Rn6JpkISX9T/zcyrIFv8UtJ0FbkhWW+npTmp9EnpVe6oc/9wFLcm9Nt7Pr2VeG91GXv4eLfmOoA49DYcLLx9X0UoGRsuT9h1LMl7FQdwzh65ncmN9zPn2zBCFLyrjBMZCl21IwVq+L9xBYRFCEqyDGNRpYV+zuSpVl4mVNcRE3RoNkVQXu5HuWe3m1PyyuECRiBDYMiZpaDjn3n57vJvJyYVpSh+Gyx5BnrxnOgsob+lnZBpweiH4pFEgBesscaJYw4lgfZyykMKqdQf3gX3w4HLm8U/HiP8el1/Kcx7bS4sljDhvooXEHh4EubuWFNCsHcz52eyMLJO33zLJFDmXA5o3ojN/ULUhW3XWxmKVCaroefw/MAaZBYSHvo8O0pcOH+xJsoqND7kblM/LkDzyz/vQxx7sFa95ifo0YzEmr0LKyVXHajup9T5jMfQmD8szrVsbXLlYx/sdUuGpQNUf+QyWvc6KMXDLK51o0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(86362001)(31696002)(36756003)(38100700002)(82960400001)(478600001)(6486002)(6666004)(110136005)(966005)(8936002)(8676002)(6636002)(2906002)(5660300002)(66476007)(66946007)(66556008)(31686004)(316002)(41300700001)(186003)(53546011)(2616005)(83380400001)(6512007)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJMdzVjZVlmQzdDNVVlZWlPRlJMRitTcFRzUFRISms1bmFqMUtZZHVDamVN?=
 =?utf-8?B?cnRjbEVxWVNUVlNjdjNLcnoxMERKZEs5VXlxM1A5SldGMk0ycnVMYTg3UEhB?=
 =?utf-8?B?TDNUdXVvRmdzTGVLRlJ6WHNhS0R5NHlDVTdwMDV4cEg1VlVuT2VCeXdVRk0y?=
 =?utf-8?B?eE9oV1pYelRCVjhPYmdrcXpjVlFlcjVZUUNjd0VBQU5WSmlQdmxhVFArcWZU?=
 =?utf-8?B?UEFQbHAxTHpmUGVZai9jaEVIdTJ3dnNMc09EMUZYTnRNZldxc1hlOWgzNWhW?=
 =?utf-8?B?MlhwalpUYUZRRnJrRmtzVzB1VDZKRTlHc2JkdVhvbERCVDNiUkd0WmN2RGlm?=
 =?utf-8?B?VlB6Tld2dTM5QjhOeWRaUWxUajB0T2RmRU9Ia0orcTV3OEF5NnFWZFo4SjFG?=
 =?utf-8?B?ajFXM0xjZXh3WG5aWU10ek1iVWZVaTVKdlNMVUpWNE0yL0d0QmNvSTJ3bEZk?=
 =?utf-8?B?MGNEMS9sTCs3bEQ2V2lmelAwRTRKZHlKUnpJQlNJQi9IN1VqUldKYWFXL3FQ?=
 =?utf-8?B?eDdKdVA3Q0c0MXZoR0ZuLzllVzVIVFVabFZsdUFSOGp3TDE4SGtWVFdNMVZB?=
 =?utf-8?B?bUNqNnhPa0pBS1A1L2QxVmY2NXQ5dWtOMDErVVZJbzJITGxqTFNkdTQ0emlj?=
 =?utf-8?B?a3ZGcHBORXd0Q0tnLy84cXVIV3ZmT2lsb0dZUUxTYUFYRWdqVk1xS2xoeHFw?=
 =?utf-8?B?bFBzYTlodGx3dFlBRWV0bmwxUHdCb0hoZEZoaU1ZR3htUERoalBxU0FrY3JV?=
 =?utf-8?B?S3RVQnhkdnVzNkphVVR6Qmc1ekNvdHQ1bGdxdGprbU1YRC8veDVXdzBMclJp?=
 =?utf-8?B?TW9OL2RsKzVpcytCbjZVTmk5TkRyazA4N1R4KzFFdk1KaW5KVDZ1eEl3dDBR?=
 =?utf-8?B?U281Vy93bFJPYWJLdDNGbFowbXl6TGQvTVRPQVI3SUV1Z0JIWVdqU2N0VFVG?=
 =?utf-8?B?OHhWUFJoK1U0bkZGWW54ak5NVDM0eHV2dnk2MW9pYU0vbzZaMFBqc29hVWxl?=
 =?utf-8?B?SHEvZU5TY2wxejdlRXovQnFBS1plZUVvV3ViN0p2a3BnOU42Mkh1OWY4blNE?=
 =?utf-8?B?c0g3VVJpOVpnSWRlSEU4RmNMSWR6WmxBV3d5UnY2TW50MjEyWC96cVh0L3Nw?=
 =?utf-8?B?clZNT0dodUdHSE45SzFSektYWGdEYjBtWjNseGV0ZnRZQmNYVnZMU0R4d3Rk?=
 =?utf-8?B?bVEvREN5V0plcVhFS25aYXdJSzlxQ2xaNVQydTBTY3dpcTQ0bERxaWFlaFNv?=
 =?utf-8?B?RDh6M3g5d0pLeVE1NDROMXgvN0dPVjUzTkZ5UiszYzJVMUpNT2F5UGQ4dlh3?=
 =?utf-8?B?UzhjMXlvQ0R6YzFDVlNLY2hkZUdMSkorZ0Y0V0FqRWM3TmpSYVZTMmYxTGRW?=
 =?utf-8?B?a1gzV0dhajZEN2JGK0FlSmJiRVQ2WGlBdGlwYldTYmM1R0I5RWNoZU1rRlpn?=
 =?utf-8?B?WUtob3FoVnlBTmh4bmI3WjVZVURTMkYwMFdEOWU5dENZeEhpRXJpUmliY0Zk?=
 =?utf-8?B?Y1owSHVlMlNKRjJ1VkU3bDFaTTIxVldkbEV5ejhMQ05lcGpJbS9PTmxHZU1v?=
 =?utf-8?B?V3dadFdaVEVIZW5wKzJtaVllYnZ6dFRrYmRSbW1idnZ2QVcrUGs0TmZEQ1Y1?=
 =?utf-8?B?eXVDSkVMbHBBL1psUkZVUUIxa1ZaYzVHQlBiVWxsMXBzbnd4Sk9NMDM1V2dH?=
 =?utf-8?B?YXloRmg1eGNCYzJEd0JYVERFcExqQ3JGYlEwc0s0ZDZZdk9BQlprWTg1QzFs?=
 =?utf-8?B?dWlsMlBZSmhVbVM0c0VrWHJFQ0p5MG5lWkFqWWU2Zk9PWFZEeUtlb3NzVkF4?=
 =?utf-8?B?Y21aNGc1UmpNeHZrZ1R4UDFwQnRkSm42dG0rdEJrMVhmc2cvVHVnbmJXY08x?=
 =?utf-8?B?cmJ5Uzl5dW5VcWdGS21kd3VOQmdld0wyejJVZXVzR0NrNk5IdFIrbXpYYklX?=
 =?utf-8?B?OU4wS2M3N1g1VXVBdURKSEllTTA3L3BuZDAxc3B5Z0RGRzBsVmxKa3JpRUFs?=
 =?utf-8?B?a0FqcHVNUUJjcE5SelZ3NWRpY0FqWS95K09SQ084cFFDdHhBRU8xZmhuZUdv?=
 =?utf-8?B?UC9tUHZhbVBvZUNtVHQwcXhQU1F6blNka3MwZ3BIMFZkVmpiTjZmaFk2MXBU?=
 =?utf-8?Q?qN67L8PvmYddSzU52NdekmHlY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfcd0ab-d8a9-4fb7-3bb7-08db64f4b87c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 12:10:43.6384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXlKM36XO5am5WV0mbKaHsresyDnqwJ5MgwTWCyWSeflJdbHt9C4iEf6FFC7kms8r2+KrYjG6INoMCGiS/1HmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7214
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On 6/3/2023 2:55 AM, Liam R. Howlett wrote:
> * Yin, Fengwei <fengwei.yin@intel.com> [230602 04:11]:
>> Hi Liam,
>>
>> On 6/1/2023 10:15 AM, Liam R. Howlett wrote:
>>> Initial work on preallocations showed no regression in performance
>>> during testing, but recently some users (both on [1] and off [android]
>>> list) have reported that preallocating the worst-case number of nodes
>>> has caused some slow down.  This patch set addresses the number of
>>> allocations in a few ways.
>>>
>>> During munmap() most munmap() operations will remove a single VMA, so
>>> leverage the fact that the maple tree can place a single pointer at
>>> range 0 - 0 without allocating.  This is done by changing the index in
>>> the 'sidetree'.
>>>
>>> Re-introduce the entry argument to mas_preallocate() so that a more
>>> intelligent guess of the node count can be made.
>>>
>>> Patches are in the following order:
>>> 0001-0002: Testing framework for benchmarking some operations
>>> 0003-0004: Reduction of maple node allocation in sidetree
>>> 0005:      Small cleanup of do_vmi_align_munmap()
>>> 0006-0013: mas_preallocate() calculation change
>>> 0014:      Change the vma iterator order
>> I did run The AIM:page_test on an IceLake 48C/96T + 192G RAM platform with
>> this patchset.
>>
>> The result has a little bit improvement:
>> Base (next-20230602):
>>   503880
>> Base with this patchset:
>>   519501
>>
>> But they are far from the none-regression result (commit 7be1c1a3c7b1):
>>   718080
>>
>>
>> Some other information I collected:
>> With Base, the mas_alloc_nodes are always hit with request: 7.
>> With this patchset, the request are 1 or 5.
>>
>> I suppose this is the reason for improvement from 503880 to 519501.
>>
>> With commit 7be1c1a3c7b1, mas_store_gfp() in do_brk_flags never triggered
>> mas_alloc_nodes() call. Thanks.
> 
> Thanks for retesting.  I've not been able to see the regression myself.
> Are you running in a VM of sorts?  Android and some cloud VMs seem to
I didn't run it in VM. I run it on a native env.

> see this, but I do not in kvm or the server I test on.
> 
> I am still looking to reduce/reverse the regression and a reproducer on
> my end would help.

The test is page_test of AIM9. You could get AIM9 test suite from:
http://nchc.dl.sourceforge.net/project/aimbench/aim-suite9

After build it, we could see app singleuser.

It needs a txt file named s9workfile to define the test case. The s9workfile
I am using has following content:

# @(#) s9workfile:1.2 1/22/96 00:00:00
# AIM Independent Resource Benchmark - Suite IX Workfile
FILESIZE: 5M
page_test

Then you can run the testing by command:
  ./singleuser -nl

It will ask some configuration questions and then run the real test.

One thing need be taken care is that the create-clo.c has one line:
   newbrk = sbrk(-4096 * 16);

It should be updated as:
   intptr_t inc = -4096 * 16;
   newbrk = sbrk(inc);

Otherwise, the -4096 * 16 will be treated as 32 bit and the line is
changed to extend brk to around 4G. If we don't have enough RAM, the
set_brk syscall will fail.

If you met any issue to run the test, just ping me. Thanks.


Regards
Yin, Fengwei

> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>> [1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yujie.liu@intel.com/
>>>
>>> Liam R. Howlett (14):
>>>   maple_tree: Add benchmarking for mas_for_each
>>>   maple_tree: Add benchmarking for mas_prev()
>>>   mm: Move unmap_vmas() declaration to internal header
>>>   mm: Change do_vmi_align_munmap() side tree index
>>>   mm: Remove prev check from do_vmi_align_munmap()
>>>   maple_tree: Introduce __mas_set_range()
>>>   mm: Remove re-walk from mmap_region()
>>>   maple_tree: Re-introduce entry to mas_preallocate() arguments
>>>   mm: Use vma_iter_clear_gfp() in nommu
>>>   mm: Set up vma iterator for vma_iter_prealloc() calls
>>>   maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
>>>   maple_tree: Update mas_preallocate() testing
>>>   maple_tree: Refine mas_preallocate() node calculations
>>>   mm/mmap: Change vma iteration order in do_vmi_align_munmap()
>>>
>>>  fs/exec.c                        |   1 +
>>>  include/linux/maple_tree.h       |  23 ++++-
>>>  include/linux/mm.h               |   4 -
>>>  lib/maple_tree.c                 |  78 ++++++++++----
>>>  lib/test_maple_tree.c            |  74 +++++++++++++
>>>  mm/internal.h                    |  40 ++++++--
>>>  mm/memory.c                      |  16 ++-
>>>  mm/mmap.c                        | 171 ++++++++++++++++---------------
>>>  mm/nommu.c                       |  45 ++++----
>>>  tools/testing/radix-tree/maple.c |  59 ++++++-----
>>>  10 files changed, 331 insertions(+), 180 deletions(-)
>>>
