Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B320B62E8A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiKQWow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiKQWou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:44:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7269490A9;
        Thu, 17 Nov 2022 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668725089; x=1700261089;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AJm6NPVytGUORI94lgiLZka1V7WhEWQWYswh8u6uOvU=;
  b=WHlOdYHC3R8zow/WUKxUZrgD5tHksTAihlW1gMHn1EgGXZk4/H8QRoVB
   sBN8Gwb941a7su+lWAt7Iq/pHE6Ka/3dwjoDvAhztXNkNpQ0CNJdqk4cp
   lf/hC9KHI/+6GLkn52q2lrAFtSa6IOeLdIOAd9ZvthleQur7/Q+q2Nxa1
   U4s/fRkZPqRtyIut0pMuSAVH+ZcLKh4GIp8fp5rMqzT+jrFF71ey5oINe
   nYn3crXoOidilWj+e2WIW2siCHaEMMpNsMb6fVYJM7nVpIwmvGDmLWbxW
   L7HcxHWqPz5TWNbA721kCoYIZY/NFsb3xBUHmg7t0qbzJEado90XQVoo1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="311699144"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="311699144"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 14:44:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="703513200"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="703513200"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2022 14:44:49 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 14:44:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 14:44:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 14:44:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czUne6qozLhv5kEIX1aqfke4ZRQPYQGHilBrx8QVw30mZ5xwazzku3j6XlZMSwO3fWpo6nIfOkVBNUsGFMIqh5EKIZ1Q5tqDJFzAjFGcaRYbAro4yfDXBwo1Sy1eLr3sKHbSqzvUuuvkj8tuHBreoCZoTD9dgCYgzycX4yXmqsHnTQoEboAWdXpMqRqyvajnfIFqVTkOVFhdRWkCabnLc3BGXrBbM44Y/etOHpfGUDytXBT96zfA5UoAe3mG7mF/SY1nX3u8xmwgHBHgRTK/q13xjpHVuPQ4zHSFVVf2wlw9SkzxoJnPApfO5blKntlU67q4pxNVEW8JBsO11yQP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hj/Bca3SkHRBgFmJYdSb+aPSGHhQG4Tqn5m+tjO3jKw=;
 b=aBxpBatN6dCVBx6R6JT2riY7lH2UNWkRVgWCaSO7Mqtxe5vxZ9S+NgdfGkv6vtZDxLIFoIKkuDRd6br6aHDLbpEyyB3YsGHCSrTr9J1zQZ8Vx6xqzFzNTZlSrGUv55KbR/uMbGmbzTscWY+79FRrqX28pi0Po/qaGCKwpn/MbZG/nfCKlfIGAD73ITA1Jnydl+jo2xfj6Z2wa3syLQ+Sn161lgQFPFq8pLGItwLk1vb0w4ENT1AMDopSR9ID3HFTpMYeqzuHk0gZ+OXy/d40ojBOj4sEJYx28i7JfB1cprS6zQwsoPjqDAfMuMuLTBinzDGHwB4XNhm3Nz4tRzC4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 22:44:41 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 22:44:41 +0000
Message-ID: <90b6e371-3cc2-ff0c-92fa-51fc9691c1f1@intel.com>
Date:   Thu, 17 Nov 2022 14:44:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 04/16] platform/x86/intel/ifs: Remove memory allocation
 from load path
To:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <c7414e8b-c113-eff8-b435-ddde705a6f6c@redhat.com>
 <20221117195957.28225-1-jithu.joseph@intel.com>
 <75da80a5-f727-2ef2-f0f5-939cce9b2b87@redhat.com>
Content-Language: en-US
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <75da80a5-f727-2ef2-f0f5-939cce9b2b87@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DM4PR11MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e00374e-d18c-4e18-8dee-08dac8ed50bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXoa3oiQXJd/bmDyPywVzGXX9hiAg1Qagfgw7ar0A9Bs7QBvgmJEWDwqK6lZoX4OX18eKHtzjW9pZiSU8uoL71tfXFYQIrbK5ScVQCrCYGxaaSNPvvm9fMp0WVoyHQpBXRM29ip5kDN8pIUxJotujU/IWUoqTUyWZiVEnAmX8/ci0Cq07W1copF7ZPeje3E0yn35VOv4MmHqVFUiz6INOgVkYMvrJc/tDz8gADKU/KkSgfKGn0AGLTNoAN7/hEQ7wiYGIXQmiHRCwyNXMFgJSAAv8oVY3hYbuouT+ufYOj0LMDZ5LrnG44No+9WZmG1mXl4R1pq1yNj/pUzZorG7oCOe9HAtfXMsub+Z6mJDHEbWvhPBrNv8c2Y1ft4LPAl1853KWHebJ8EiRiALZ7yUSt9uWqzsJfbnloqXZfl9TYVrPXvxG88BVDCsunztSO57NysC324zB6FMT+gY6vn66sasEsG8V+eWe4xM7t/pKkw94ws2M9JSPEnOdSEPrCDWbnq+vse3G4UlVMKLB1mvH6xrvVOqtsgiElFgk79vTrib1902Wonu+L4HFevZ6C7MPvOubQZrulbOb1JgcAq8xyFbaFIIXNRiafZIN8e6tUZSYz5evbeD7wkTkPH+9eQ5KxDXt0srhRwWWPAbMoXYnpuiEWodgE6X2kBPZVmfLTSOxGj146b5+8Nh0ndCe2OZhRtypfQC9FOreEAj/1mJujuujj9wbEgtH5rGxpIood0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(31686004)(31696002)(86362001)(36756003)(2906002)(8936002)(5660300002)(7416002)(2616005)(83380400001)(186003)(82960400001)(316002)(41300700001)(38100700002)(4326008)(26005)(6666004)(8676002)(478600001)(66556008)(66946007)(6512007)(53546011)(6486002)(6506007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTl3MGNJeG4zRTVybXZIT0Y3elR2Y0xNTSt4a3pYL3FNVTNyL0NFcDIzc0RN?=
 =?utf-8?B?RXRpMGd6MjdIMHQyR0FjQllhc0V6SHBIYlRiTWpHZGtpS1lhTjFia1ZFRU13?=
 =?utf-8?B?b2dIWHY1NzVXSnNaSElaQUd4YnF1UW5zK3huZzNvSUdwNk5veVJGMWhManVh?=
 =?utf-8?B?ZjNYWU1lbmM0SEdKa3dSUHFVMjhkUzRuOFN5MTBGYWx0YTZPZzBDTzc2NmlP?=
 =?utf-8?B?d0pucW9xei96L2tyZ1Q5WFhLL0JKRzlRTTYvamlNVy83QWdDdzBiVjJ4N2VY?=
 =?utf-8?B?eDNIdVdrTXZuZUtmNGlqSElIeVB1dU1TZXFyQWJTdmlzMlNVMUU5eXpML1h2?=
 =?utf-8?B?RithQlV5Uys1eXc4aW1MUkptbXh1ZGtudUVKWS83T1pFUFVCWUdqQ284cXo1?=
 =?utf-8?B?M1JrMEpST3lzT0ZMUDAyd3ZrQ2J0OTQ0NUVKc1Z2VmZ0QzZmWWhSaXRuZlpl?=
 =?utf-8?B?UzB3T0tQSGViUm5qT1F0UkZDRGNDOW14UFZNZXhVRlpSeWE5NWRXZG1aUzln?=
 =?utf-8?B?RzBVQWdqZ21zK1hPU0pRaTZ5RndMSmt4cktCN3kxeEUzWnFjZnE4V2Q3RUJQ?=
 =?utf-8?B?YWFyekE0ZFJoWUwrQThqN3N5azVXWEllQVhtSVo3Y1hNWDZha1VKUWNQNWs5?=
 =?utf-8?B?eXBYRnh0MmpkQVZ2ODVjbnhYbEdYUlJ4dEpzdnhxd0JvdTQ4aWdyaVBPa1VX?=
 =?utf-8?B?d2t4Wjd6M0ZHQkM3REJUUGYwMC9BTUNQcU9zclhKMkExQWMwMkpVRFJLWlE4?=
 =?utf-8?B?S1VUWk13L29aYVVDZjJEU2JNeWUxVzRiN1BlbmNla04rRGNZTWRoUFJBTzJ2?=
 =?utf-8?B?UGFjcXUxYVJyNkI0VnZNbktURllhREMydFkxQzIxeWpPZWpnbXpuNnp4bUJW?=
 =?utf-8?B?azhYZXFCdHNZbS85Zlh1STRRTFZoQitaa05TdVVaSWcxS0dPTWtCWkp0eG9p?=
 =?utf-8?B?bzJYMWNNQXh2d0xQOERmMGl2aGQzOXlWNG5zckRzMWV2MWhKWG45LzhYZTM1?=
 =?utf-8?B?Smt4M3NKajBoYndraytTNFk5ZUx0YTFxN2wwQlpSZjAzVi8yQ1FUc04wSXNE?=
 =?utf-8?B?RTNMdytnZ2pyUkh2S2g3cTc0WGVlOXRaRWZQK2VnVXNnc3BtcEZvRnY3M3lz?=
 =?utf-8?B?L01VYWQ1b2o2dDdhd2EzNHZpVU1iemtoeVRLSUU1VGkvV1lzYlpIVndkMk5X?=
 =?utf-8?B?VjYyQVFZQ0IwWFhBZXgrRWhIeDU5dm9yeDdDL2NYMjgwbExYRkZteldUZEdl?=
 =?utf-8?B?Y0hSK0c1ajcvcm1oZXhmeVNNU2QrTkw5eG9hSzkrVUZjeUZhL2lpZGRnQ0FU?=
 =?utf-8?B?eCtKekZqOG5ORGlnWUo1ZFNSTmlyOWpEVFNVTXg0bllIMFlpWHlvUzBad1M4?=
 =?utf-8?B?MnhHYk9mLzdmRHNIN1FBbjJDMU5FbHJ3NlFycXJDMjFCYXF1RVZRbVh3R0Ni?=
 =?utf-8?B?SUZiVTlKSGRLWDU2eVdKNHZ1enVJZU5zdmxRN3h1MzNGTVpoNUptOW9XMGxt?=
 =?utf-8?B?c0VXaEZNYUJESnRjYkwxTEpDYmxIa2ZFTyt0c1pmWjRGK0JOeTVpc3FPSS9n?=
 =?utf-8?B?aUtiN0x6N1I5S0Q5Q1VmRzZXM0ZUOFFsUjFHN0FLWjRDY01PYk5DTWFaWG15?=
 =?utf-8?B?Y2NYMHljQ3EzUVNSL0RldGdFbzBQMHBYMlRMM25oNEpJdC8zRktEaTh1S0wy?=
 =?utf-8?B?NUdFSjQ5VXY4azd0RlhNTGQvZXlOMmNRWEIxWW4zdTdhSWJQUThReEJROExj?=
 =?utf-8?B?d3VQaldWTWFnT2Z3dEVjMU9Kcnl6ek5vcEd2SlhKNHdINC9IdTdqaldSNjRq?=
 =?utf-8?B?R2dRVi9kb3ZmQWF2WVE3ckdXbzZlYS9hYnhnRCswU1dZZUJDOU1VQnZDZHo4?=
 =?utf-8?B?a0FKTEtLQzVwTUtqV3k1WEpYME9SVHpXcnVBQWRKdFlFN1hMeEEvZ1pJRCsy?=
 =?utf-8?B?ZGpQVjVCL2p4bGdGQXY4RSt1Q1FOY2NsS2tKUU0xdFJWWTNqTEtLbmJZQ3pO?=
 =?utf-8?B?cmZqWEJ0bWhQTmNhMEVPSjY1UmY3MnBPREdHWTJCMHFBOUxIRmNMYU1MUXA1?=
 =?utf-8?B?QjFLbWNIY3lLREtDaXdYRjl6UFBIUVRwZmt4bUtyU2h0L25FRVlLMFRPb2Ry?=
 =?utf-8?B?cXg1L0EvSEhacWFhWWZXNWtyU005bTl1MXhuQ0NlVFdHTWNhRUF5WHlrYmh2?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e00374e-d18c-4e18-8dee-08dac8ed50bc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 22:44:41.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlBIowItPZfyco2d2DL4szadBRvwPsCCamiWK38pw17SdAkL/nan1L3+QH0oxJqyczizKY/H/xo1bm4AgcZL3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2022 1:13 PM, Hans de Goede wrote:
> Hi,
> 
> On 11/17/22 20:59, Jithu Joseph wrote:
>> IFS requires tests to be authenticated once for each CPU socket
>> on a system.
>>
>> scan_chunks_sanity_check() was dynamically allocating memory
>> to store the state of whether tests have been authenticated on
>> each socket for every load operation.
>>
>> Move the memory allocation to init path and store the pointer
>> in ifs_data struct.
>>
>> Also rearrange the adjacent error checking in init for a
>> more simplified and natural flow.
>>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Suggested-by: Borislav Petkov <bp@alien8.de>
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>> ---
>>  - Replaced global pkg_auth pointer to struct ifs_data (Hans)
>>  - Rearrange the adjacent error checking flow in ifs_init (Hans)
>>  - With this change there are conflicts in patches 11 and 12 (I will
>>     post the updated 11 and 12 if this is satisfactory)
> 
> Thanks, this patch looks good to me now:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 

Thanks for the detailed review and suggestions.
I will now resend patches 11 and 12 which will apply ontop of this revised patch4 . 

Jithu
