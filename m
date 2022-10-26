Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BEF60EA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiJZUXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZUXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:23:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC5147D37;
        Wed, 26 Oct 2022 13:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666815792; x=1698351792;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JDD85jTYikx43D05oddma332+ipYFS7zEdO189VyjPg=;
  b=YND9xCYkMqxLMTJNNpix2hewN73oV5COXnmLAZKHUSmO8FAjkBGsHmiu
   U9Or7EXtU8a1PI1Aqy8lpDBrQ3+S6BD7ytM1XO/RWEQUzEo3K4SJ5l8xX
   4/wjRVaiwJo33vwTZqMYywVmmuAkpOjYggS3kAkKOETnvnqjC07yJgR7S
   rOXEu+VYbj1avhY/hZJNZLP1D1Eag2fq9XHlj9Xn7trhG9lG29wCfJ+9Q
   2tAmEk68dJ1KiDMaLnG4ayX4xah6gWSR3Zk/77otZ+f9cuQeWGQRcFJDz
   anExCIzc57KM7a9H5ORBZeWM7CINLpM6TQLofGYxpjVuLqYOb7Leb+4ke
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="334674913"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="334674913"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 13:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="665419929"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="665419929"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 26 Oct 2022 13:23:10 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 13:23:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 13:23:10 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 13:23:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH1PRTYb/OTmrueJMyeBpdlilnB2HdVwcscU2+/j2h1PdQIUcCi0/iap4/7FqYK9pxL++R+kGKo6gRcCdXUmW+nx/K3MG0ZOgIUbpvhz5aNI0sO7f+33X7SEDp8RuzJ9ga3Yxe7RzZTkXmjKwBgCsHcNhFeZ70rK5Jd3+5zLdbkwTZFRHJTN/h4MR5WYtNUqAWrR/TY5Jb7bDeuNFZ/ND9/BRUk69o7/aBz7p7fc0Xi3XmMS0A5lb4gTtFjOWVT7KJJ3L+e5l9AYD1MoITPTrMMMRIpuTy/KCNFi5rPiR0WHxsR3bJamsH9z6HNyuOBIIqQ/XFbEV0zh6Km+0BGfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tROt++hpiOtKakETdua8+32Y+UEYMffDfaLf4geaF/0=;
 b=ZENv24W52AdVojpNMwAi0QrlCQKT1RoRdN54hPwBRxZinAkCJ3CkDGgZEhG2KWrvYjb/5XBpvK/cqbCQUbRwa4gfU24WkK4DA8VQDJtgDJ6+einjhlWsK6e9hmBcK43BL0UdsTccKzv1x+JZisiOl6ucn2ZURAkELRxOt1+08nW8MpYdFbVZz420PItXTtK8FYwg2BQyjsoID/r2m7Xf6InKBOB45SImymm8g/lx2vhPr5Mt7OGKJ9RH6GyWGZ3mun9Na+DwDd8xJLuCKDMDSuoISrDLtza56Pp819q8wMD64mdOlkxi6Nz/h3Q+UDsFUDjHYWNEGxHZ4x2aBo0VFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 20:23:08 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.028; Wed, 26 Oct
 2022 20:23:08 +0000
Message-ID: <e299ce70-ebca-a05f-a1f1-aed6386c379f@intel.com>
Date:   Wed, 26 Oct 2022 13:23:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v7 05/12] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
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
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604559954.5345.14619487558472213422.stgit@bmoger-ubuntu>
 <c999a7f8-b083-72a6-ff07-201369339c92@intel.com>
 <ef734fc1-8a51-4c60-f73f-2d71fcc54b30@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ef734fc1-8a51-4c60-f73f-2d71fcc54b30@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e31fd4-acb2-407b-516f-08dab78fe55d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DcEzmmvtzjQuN0ckIhkAeumqsuS+z4aTa0abCCc7qFdYDlQ/xf0u/F/XcPAO11N7E02SU08VSjvCUGMfFvC0BhfnlQGE/QIkEuWD9I8xtP+0QjOzoG2wfXvFK5z0bA4hgGLrM6NWir7VSWBn7MPoO/n1taFxHNdf4N4g70SjB/dpz/a7K1caiGmS5wch30zASUweyYeAbq78GCGAdTXVXhtOsEVi7FO/RfjJ0/VNkE6pEbSFq/SMH1jhkPRyVvDqzs/KXnr587RdllFUfA0PFbr8kxSN83D5asgb+3UGuV1Gwl4+TqleqXeok+z7ShBPpONchxKk82ho63rdddRYPIDDDeEbmQpd2VET/HGq4xfVL8EqDrX+g6mL/0egeYb8x+9/YKS34az/j9/pfRZDgI7Y3itSMZVKa3ue+7X6QEEcuynfL1HyeF+N4/c/3uiY8cnUzVtbYV5EwHCPV0ZgquZRWJdTAMUEGENOT+9LbSv5/tIWmQkn9SseZqwEYFQgy6evDWh36SyrJInYmQvEjyMlA5gtsTaK9MK/bU0OJ+ypeuK2VzQtLkMA4ufphRslrAzmV2Rk+SUPl3uKZNgrjDjT8RyJo36iqfrfJ5pCdDcD5WteoxzMsFYlSGWjd9v8NIGNmpA59q4lzZttp5RZ5oQKq84BhoH0UGJuzq5Cf1tJspXBTkawBRSlYdstwJ5A68EZcwcTzRB2hmSKxaFTDBSfcB4A+LEODGiDjViJQh73h8NGddRRsu/KSxSuGipErSZPbwba12jEvdPbDb5eR3hIFy1WvpoKGDs1jf9hIKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(2906002)(6486002)(186003)(8676002)(7416002)(8936002)(44832011)(36756003)(66946007)(82960400001)(66476007)(66556008)(41300700001)(6666004)(31696002)(38100700002)(31686004)(86362001)(2616005)(5660300002)(4326008)(53546011)(6506007)(26005)(6512007)(316002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk8zcW9xc2IxOGZWNDE0azhpTCswaEMzM1ZTV3JpejhSVHhiQ1ovRDFvUk4v?=
 =?utf-8?B?SWkvZnVWa0NaYjloVEsvRUdvNXhORnFuUmdzL2ZCOG1vV0hIQ0tuY2JVMy8y?=
 =?utf-8?B?ZFNKbWVxaDJqb2dHQnpDUUpOa1JKNzhKc3VBWGtXb3A5ZWw2bEM0SU9UblNn?=
 =?utf-8?B?dXNVLzI1WHo2SXUyV1VJL0VRcHh3QUZrdFVYU0tsQUNaMng4WlFiK3grZm0x?=
 =?utf-8?B?WDVTbVZzWlJWUUI1c3JKc0xrUmsyM1FZOHpQSjBqL2JiTDZWaURvWTNzVGZB?=
 =?utf-8?B?THdBSE1pY25rQkFHT09VbDVEaWdXUmpOQjJ5YU1HVG1MOGI4MmNMcHNxcjYz?=
 =?utf-8?B?ZElrR1dxYjhWSnVzNkt3SGJ2TUhGSXZZN1NOYks1S1h6MUwydFVveEZkdmMr?=
 =?utf-8?B?NzA4SVFVSUtNQzZCbm9oM3ZwYjVNYmNvWFJmT3JRb0pTYW1QbDBoRGdyZk4w?=
 =?utf-8?B?Q3RNWWJqZTRVK0hDM1Q2NmZCdjRvMVp5UmxiL1hHM2dSYkhpV0pnaTFlVEdO?=
 =?utf-8?B?ZHdoZElDdTVvL1FNSUlTQmhUSUNmb0tLTlc2MlZwZDF5RENvcTV5ZG9QSTU3?=
 =?utf-8?B?MGJ3eWgyWlE0MHNTMDN2QUdnQndlSmRyenRzd1pDN2tJTnVER1Q2akgwdTRw?=
 =?utf-8?B?cVBkZGtLVTNaOXA0anYvelNPL0ZSS2l1RzRQVkZPOVVDd2ZORlhGMDVJLzNT?=
 =?utf-8?B?b1NvNzBtYTJOMjV6UEVTa3R4QldRQVRuNExDRWFWajZBNWJuY3BvdHp4L1lz?=
 =?utf-8?B?TURteVgxTEZJTWlBOUZGVGhEZW1oQWV5NitKQU5VaUZhcU5FSDM4VnRRNG4z?=
 =?utf-8?B?U2tmMTJPVnZIZHNuanM5ZVBsQi9Ud21kMGsxREs1ZUNaREdVZ1VTdUJ6T1VF?=
 =?utf-8?B?bEc5aXdad2FJTlAzMTBuRFEzelBQT0c0T3hqN0hWaE0xcS9hdU43WXh3ZTUr?=
 =?utf-8?B?eFZNeW83NC82SXcwZTdqVE5Bcm9STW0xTU8rSkxsWXQ3eHJZL3Bwa2paMlo2?=
 =?utf-8?B?K1RCa3haNmY4M2o4UUJoU0h2ZmdUdEJHME4vNm5UcHEvTmNDb3ZQT0tYdi9Y?=
 =?utf-8?B?aXhaSVFFK0x3cGJtL2E5blJsOEh6bGRoSlZmWE9tOGxtZVpiQ1hQYWs5R0tk?=
 =?utf-8?B?c0VlL0t2eGNqSkFVNXBlSWFvaHVLOEl4SE50ZVM5RTZGOG5qV3g5ZkxUWitT?=
 =?utf-8?B?M0gvc0JEejR3VWtNVEhtNFp0MTY5ZjhGNUlaakdSeXlWeXdJeDRMaEpNTlBr?=
 =?utf-8?B?WGxocS9hcFFFWlFrRDZLMUxNOFAwZUZhaDIvRDEzVDRqNkpzRHpPdHl1OGlB?=
 =?utf-8?B?Ykd4ZWxoWnZsWWVpaUFUVWZlc2JGS1UvTlZvYm92YVc1STFLd1NmSGFrL2pH?=
 =?utf-8?B?cUVVOWR5ZUk0QmpadjBPdHlKRlZTSjByYmhsN0ViczNIcjJHSnRVcWo2S2pV?=
 =?utf-8?B?ZTVaR1Jic2VDUFQ0alR6YWRYcU1HZTB5SFdudmpLWHNYLzgySWxVYXFHVy9v?=
 =?utf-8?B?MjJ3Ui9RL1NYWktvVENNdmVGY2FzWGNsNThTM092NGRIWGxVK2t3TU1IQ2Rw?=
 =?utf-8?B?dG5vVlVPQStGUFhSTFAzVk1qNVJXbmUveE1ENVFYK2VGVS9pbTN5eFNBYW5K?=
 =?utf-8?B?bTNtNzFKbG5CQUhIMWJGTFdTZk1OQmI0cnNGSUdjT0ttcWlOTFN4Y2NJTlZN?=
 =?utf-8?B?R2R3aCtJQzRFSWlwOFlTZ0s4S2tzaUIxK2c4ellYV0Y4bFhVT0R0T1RpUWty?=
 =?utf-8?B?aXV6Qy9iZklOQ3h6bFVYcGhTOG9DZUgxNWZ1Z3V3WkhDbkE2SVp1UytkczIx?=
 =?utf-8?B?ZUVIdVNPeWdoS3RWUnoxUHB3K0s2dTQ4NE15eGtzMllSa1lBTVZJOWljSGJl?=
 =?utf-8?B?dnpOSHcwRzR2cGtDbVliVE5jMU5XUzVCWThsOUNSdGdnU1JZOEtOeFdwUFBx?=
 =?utf-8?B?WkZISysxQUpJeVMyVlhsekNpVENiVXJKd3pSb212dzRDSUtibUU3MmlqTFlI?=
 =?utf-8?B?dkdRWGdxNTV1UGVBb2tQbzEwVmlKVzJvd1FZbyt0ZFZjY1Y2VXlhTkNWdDRN?=
 =?utf-8?B?blZTUDJ5ZFBUdzd1SzdqWmdseERvejBKU24rTmNRcWlub0xZT0cyU1J3SE1N?=
 =?utf-8?B?MFBvaHJQd1NKRVB4TGVCbWJwUFc4b1NvZC95N0gyUHdhVW1DQUNDUjJXWWVa?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e31fd4-acb2-407b-516f-08dab78fe55d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 20:23:08.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C87E10GJmDj0r1/2/nLKnRTS2CnDMFThN4saAkENk7FjMJRLXwuiJBwlS2kBHqzIcpU9GuW0eYmS4urJvDec8R+kpNRKq5DMkhTRewJCyhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6189
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/26/2022 12:07 PM, Moger, Babu wrote:
> On 10/25/22 18:43, Reinette Chatre wrote:
>> On 10/17/2022 3:26 PM, Babu Moger wrote:
>>
>> ...
>>
>>> @@ -2845,7 +2846,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>>>  
>>>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>>>  		r = s->res;
>>> -		if (r->rid == RDT_RESOURCE_MBA) {
>>> +		if (r->rid == RDT_RESOURCE_MBA ||
>>> +		    r->rid == RDT_RESOURCE_SMBA) {
>>>  			rdtgroup_init_mba(r, rdtgrp->closid);
>>>  			if (is_mba_sc(r))
>>>  				continue;
>> The above hunk and the ones that follow are unexpected.
> 
> I am thinking the above check is required, It is updating the
> staged_config with default values. Right now, the default value for SMBA
> is same as MBA default value. So, I used this code to initialize.
> 
> Did I miss something?

As I described in the following comments my concern is related to all the
software controller code still executing for SMBA. Yes, in the above hunk
SMBA would need (some of) rdtgroup_init_mba() ... but note that it contains
software controller checks and in the above hunk its call is also followed
by another software controller check.

The software controller is just applicable to MBA and these checks have been
isolated to the MBA resource. Using it for SMBA that does not support
software controller at all is making the code harder to follow and sets this
code up for future mistakes. I think it would make the code easier to understand
if this is made very clear that software controller is not applicable to SMBA at
all instead of repurposing these flows.

>> Note that the software controller, when resctrl is mounted with "mba_MBps", is 
>> only supported by RDT_RESOURCE_MBA. At this time this really is hard coded all
>> over the place, for example:
>>
>> static int set_mba_sc(bool mba_sc)
>> {
>> 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>> 	...
>>
>> }
>>
>> Since SMBA hardcodes "delay_linear = false" I do not expect it to support the software
>> controller ... but these hunks appear to treat SMBA as though it does. It is the "MBA software
>> controller", not "SMBA software controller". Why does it check above if the MBA software
>> controller is enabled on SMBA?
> 
> There is no plan to support SMBA software controller. Yes, I think below
> checks are not required.

Thank you for clarifying. Having the code reflect that clearly would make everything
easier to understand and maintain.

Reinette
 
