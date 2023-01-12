Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B5B667E87
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbjALS7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjALS7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:59:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CAB1E3D2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673548608; x=1705084608;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=PdLlmRSGdF7ZzmsQtiVIT3BU5bDOeqf7TpzZoJDJU1c=;
  b=XPKl/g7TLcDK56e2iLCmgLf9/vC3BpdDmGjAHh/dw7xh3kJclWQL94NC
   YCm+K1Z1At4ZlDy7gLTC8CcIEcEt3tD67i4Sla0sA8YaibULpVxWW4FkQ
   bBVPp8t0XZOhqjT7zgPF60TRUqXUpUttu6eyKIYRiMmqyarENFID+3idk
   LrqLqHKzNEFkzs0NxoLy8GtHWHzCkHIQ+bPnCFZRoDqi4hPKIel6yWlJG
   9TyXqiLrDLgihwuXrF465UMW4gba9sDqTWaHNgBSAWkFJwYJ7MFMKgPFo
   qC7OOymv9r3tig4+qNIfW4pYEum3Qofh57n2g4MPvwasVSyFsYaKarOZd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="303487805"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="303487805"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="746641544"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="746641544"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2023 10:36:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 10:36:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 10:36:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 12 Jan 2023 10:36:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCnt+Z30v4XQGc9ZMVBJHe+iL+l7/OoSEWeeZYd2po9ZdupiWXiUiaQRbG4b3A358X9cgwaW9M698CBatZNSgDIfFhJQ+b887aKn2zSPhktckpolAEDLx8pQeOjyQq3nD7r+8cXa+nztEOu/3a8Y0NLGYCi/TPmlhPg9AphUM4y4eVQeipaZ44CqErlGtPmS5TMU4qr4iT7j/xl4PJ3avqNHHNZpM+4pRxprEBsX8XaxPTEFZqo4rGGAYAPprOmQS48Ty7eHlefkn19sooXg+77gBVoFJz1L9yTBxJKpWDaGowePfDjhIJEIGo4RtZMGYDBvCIWxByFnfcMtJmeehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V344PUV98P00tAAGOW3Dl1uOTG0VG4ScqvNYSdf/cI=;
 b=QiGERMurQlRlPcjVL5exX2nrkhMCXXZJ50oJsYNs8p6ZQyEV8+uYDTYAtGldUxhtRhRPE5T497PzDVGKOc7DeEaO1gTAfe+gE/j8M9Xl+zqy0i7/hEf7lB7rg2cLykXE0oj42CuPEZe3THAkl/C2bK/zVoqlXfaVk4fmddo8wn5sbfNTJP6uVrDmXLaHQdW6Qc8el+m9PFCaFptQ/Z62OVytixOvl40Mp9yXpylDKb7YRkEg+wunjLXLOCp7B1ZRTYx9pT57XoBadmedABJTgyD5h6v8sYs/yv7cfW6lnIcN3R1oqQpP+7e3XHOVi+ZhiIGPg3Z0dwNYOVoQYzoAkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 18:36:43 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 18:36:42 +0000
Message-ID: <9e0a8b20-cb76-b06d-67fb-f8942df5a2f7@intel.com>
Date:   Thu, 12 Jan 2023 10:36:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 3/7] x86/cpu: Disable kernel LASS when patching kernel
 alternatives
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-4-yian.chen@intel.com>
 <693d8332-3b86-3dcf-fc87-5c3a08a752db@intel.com>
 <ad2da884-c8c8-bc57-e21f-452a08cb10cc@intel.com>
 <b9e73d06-bd95-7c54-3ff1-f9e43c9967a4@intel.com>
From:   "Chen, Yian" <yian.chen@intel.com>
In-Reply-To: <b9e73d06-bd95-7c54-3ff1-f9e43c9967a4@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::30) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|SA0PR11MB4767:EE_
X-MS-Office365-Filtering-Correlation-Id: eba17556-7a44-4366-1343-08daf4cbf361
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfR5VgcoA7doe8JATrUACkzZPUYBCiy2PdvqFW65+g5D+nUrB4ddnmu03Gh/EN6FHujFrJs5nMKcXTXGcfsxGCC+hXnsOu6H8R2FrbOC6hhkI3SX9pUgrcjGLahvkYMdFtKYaxxAGfXMzArgaSRLm9gG3CTEQQqWw39+rRvMUvSN5D67Ru8FCte40Yni+u275KEHEVrahoBWweYa1QP1eiVgtMhrJooekx+0vH4RSKFON6FniF5viCrJOSzPAilNhUEkKG7HgunfpcE7sLO8NxUdL4Hw7dfBm1Pvzm2wtq/56DtXQoHEJU0C5zqVzr9Vz/RPShkzN+C3ggXTUePiqJgxyYV4uTV+QhL7qLQRLgs/nMqbkcYOio0AEXNR1HiTYgFpQLNTFwkkwov46FumpLgiPzhkB+gHSH2oNCqhIxJ/3b/pMll5yIyFcBw1IBNnMuiZxGykIkRV3QGmz5jbe5aS+P/NpvehbskjBnbnoEYFMkUxVg4ef8Fes32DUAC0tLMsEInPpopVMQKiZtx0QLFRKCJ+fsNpbuGFNHhFw/RcAp8FsSDgFO2PzSQE7/obPUwjdFmo5AZm7Hjw8jNLFK/giUJjiGPUEcXNVrxcKXP38YyFAjoJFUxAIq5o+OptzAFuc2Eifhd42kUXi5Z1U33g2wMg8aFysv2OxsBsE/WgdUAA9xJyQ5pxBcwgIdcIh/AH3kaRQ0qVLSMWmXDxWzLV0pap6Ty8IjYZNSKCfjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(6506007)(6666004)(2906002)(36756003)(53546011)(5660300002)(31686004)(8936002)(83380400001)(4744005)(8676002)(38100700002)(6512007)(82960400001)(41300700001)(6486002)(478600001)(66556008)(66946007)(26005)(66476007)(186003)(31696002)(86362001)(2616005)(316002)(110136005)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1NRNWZEVDJnMUFRaTZUWEw5ZnpGVnhWdHR3MVhDanVhNkZiaTVDUFBLMTFa?=
 =?utf-8?B?NWVXUTVCUDE2cDJtdzkzc1k0TkQxMGtkZUNYS2ZYdGNCK0RLN2tTNDRHWDZi?=
 =?utf-8?B?VEo4Nys2elBubTAxZFA2VStVN0U3ZjBzRGhxTWVSZGNyelVEK0JGN2ZiNXJR?=
 =?utf-8?B?c3NWbkExZUxqZEI5cUV2eFQrN1pCeXgySllSNGpMRkFCQW9qWXhIWmNEbzl4?=
 =?utf-8?B?d05wdU1mQlQyUFNqOWdwQ0ZyNVdRckNyS2M3aWx2MVE5S0JCbUFmSGtNcWJO?=
 =?utf-8?B?OEhnVC84YXIyblZmMHBIcW1jbVdiZHNxbCtFSTk0d3hXekdDSlBZK1R0cThE?=
 =?utf-8?B?dzBOa1VUQnpYOGZKd2RYd2xwL2NYSDkvdFdoS1A5dWZYZzA0SXQ3SllLYWo1?=
 =?utf-8?B?VitIbGNRd1FhZy8zbThkcG5ybmVzV0E2TVlmS1VpOG5MMXJNWHRWd2hBVzk3?=
 =?utf-8?B?enZ3Mzd5M1JVaFd0UllhMGc3amg3eGhhaDc5YW5qeTNYMEs3dHc4Y2hRcDBJ?=
 =?utf-8?B?MUx6SUtuYlhZN0Rwc2c5ZVFGS0RBemhON0MxWmdkMnJhQ1cxenVwQlhoS0c4?=
 =?utf-8?B?TG1yYmxVbU4rblFlbXVMemV1UHFHUGVhZUwzZjZZazROYUtTcVBQaHVjRjU2?=
 =?utf-8?B?TzVkSkYzT2ljTndtNGVoVElId0ZVMUw5OFFlSHkyV0tmZEl5eXM3eXJLZnN2?=
 =?utf-8?B?NENPRlp1YVdwampSbjFOajFsTEQ0bHRScitCZ0RrYjZvNVpLTFE5WEwwWlho?=
 =?utf-8?B?Nm13aUZrMlZka0xRaDhKZU8rRmEvNkpaSDV0eGdUSklYU3g0enF2TFZENVAv?=
 =?utf-8?B?bnhleW9ZK3I0dWVJMU9jTnZTZFlNK2l6Z0VRdkZyOTNtVHltSWF0YVlvUm1P?=
 =?utf-8?B?ZWhlSkJmZEtJdGY3YndoVy9iM1UxcEhHSnZNTGl1QmNCMnpmRWhSODBQR0FK?=
 =?utf-8?B?N3NwTVc3Q0ZqOTZES3hlNkdQNjR1aXFNRTFNVUNMTHJvR08wQmpkcU9iMVAv?=
 =?utf-8?B?dWxINmVnNkRPck84QkJlby9CWklPOVBvY3hzdUNjekVsMEQxN3RBdjB5KzN2?=
 =?utf-8?B?T0FBa3Bad2FYSmhLeERKRlJCQ2pWdTQ4TkRqTGcrM0E0R2RKVjV5Q1REL1BJ?=
 =?utf-8?B?ZTBibEt0eTRjSWVaMm0rS1NJVXpFMC9IS3IyVmRQZ0VwNm9QdVM0WDhNSjlG?=
 =?utf-8?B?K3E5dnBmdzBvMjJyeHZscjY3WjRsS2M0WTNFeW0za21QSi9TVVRSWWljd1cy?=
 =?utf-8?B?UGp4T3lqU1ZCYmpaMGovQjJnOXgzRzVuS2NVZVBFL0xac09TNWhNZU52NnRZ?=
 =?utf-8?B?M041MEpsMm1vYmtmOXNDUEhBVmdiblVpSE9iemxJUVVoQUhkM0I1R2U5VSt2?=
 =?utf-8?B?Z3BWRmNSejVUalFYdFBmWG1KVTZjWDhINHNGM0grYmlyVUJkVkFwcE5wNXZH?=
 =?utf-8?B?R1pIL3FBSjZ5R1lIR0pDOU9QcVFsL2QxOEh5VWdabVZIU2tXWTZLQTF1QnhX?=
 =?utf-8?B?MW5lSW1HTWZ5dlJXWFNxMDNzZ2EyYW1iRjZhSWpZMUxYYnFTakJIN2JYeGtp?=
 =?utf-8?B?S1JZVDhDS3FRQkFVRGVmUjUveVgyYldqOS9NWnJMN29GT3E1WE9Lb3dtVHBr?=
 =?utf-8?B?RjZQSFhZR0RVNXQxOGIvVUVQSmtnbWV1U3o1dm1kbkwyR1oyYUpoVHJzU3Y5?=
 =?utf-8?B?VXdxQy9za0RSc2dQOFpiaXF5dFFRZEg3ck8veTgvUzkzejJmeVlBNlNLSUxn?=
 =?utf-8?B?SlhKcFY3NmFHUEV5MG1OVnQ2aUhBZmFwNk50cHNGS1JOaEZkVDRXYTB6RDdC?=
 =?utf-8?B?bDhtUU9SdVYxR2haS3hyU0dEczZNWWIrN2Z6T0xuaDhqZENFa0JnZHk1bkZh?=
 =?utf-8?B?TkVzOHlFWHFIcEl4MWhmYjcyVVV5WjBkcEcwbS9sS3c1ck1uRml5Umpxa08y?=
 =?utf-8?B?aFZxaFdFN0ZHSkhLY0pIcEtBWWZGSjZLbTlnOUU2cFpJK1d4bk9JWGtCVkVF?=
 =?utf-8?B?QWVjTFMwcXRpZzZvdm5UQ1BSa3hvN2R3ZVZmYTlPdVU0VXE5SHdPejBhaklC?=
 =?utf-8?B?SmI2b3hpWU1meldOTnZmelJGOHNOVFhnNUVhbUc3TndyZTErZnpDZG9FanE4?=
 =?utf-8?Q?kc3Cs0mnRW1cXPFh2RM5M7JuY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eba17556-7a44-4366-1343-08daf4cbf361
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 18:36:42.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjUnxWHGZ52CtrzRVwWtEanL4yGTrXVxtfhgEooE4HyWrxqeJC106gxpsmWMLldpF2H//+DDzy4TMk2qvxtpTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/2023 4:37 PM, Dave Hansen wrote:
> On 1/11/23 16:27, Chen, Yian wrote:
>>> It seems we are implicitly relying on the on stac() and clac()
>>> calls that are added for SMAP. Have you tried running with SMAP
>>> disabled i.e "clearcpuid=smap"?
>>>
>> Yes, I tested with clearcpuid=smap.
> It works by accident, then.
> 
> clearcpuid=smap means that the kernel should be running as if
> CPUID.(EAX=07H,ECX=0H):EBX.SMAP[bit 20]==0.  STAC/CLAC should #UD in
> that case.
> 
It could be something wrong in my Simics simulation environment.

> The only reason that it happens to work is that STAC/CLAC apparently
> actually continue to work even if CR4.SMAP==0.
> 
> I'm actually a _bit_ surprised by this, but I bet there's a good reason
> for it.
> 
> In any case, please just make LASS dependent on SMAP.  It's the right
> thing to do on several levels.
Sure, I will add the dependency.
