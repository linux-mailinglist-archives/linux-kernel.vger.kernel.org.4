Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B935BBCEB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIRJtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIRJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:49:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9E823BCD
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663494545; x=1695030545;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gf7J2/Z1DE1s5+bhNsbAL/mSxgpuy/eCe/FkI3EI2kI=;
  b=kL/5NqECEeZzVJBEnxjhU07gYvXL7uSXukLv543ojFKlxATHa0lsPVdF
   fIHnYojTyb1CxkjvpDmK3CHIyZzi1f0n9/r0t47blirRQwN/qTI6V0eGX
   QRrmfgWEqoJ1unqYF7+moWIZUNbYe2Q1+IgItR4xPQdZ8DJmkimWH8aFe
   8w2JVczTa9IDyQGOo0VhwXAPTifWQYZZ4MrssrPom2ietR+r6MGriGb3l
   i4Bf03bt/VFGef8ZRdzvu4xAeoWocALl7wvr1WPpOoZh2dijKfMhU5VD4
   bBTM/I5BiOcRLhmfrKEQ7M6mnFNeA4PQ0Dqf151/CQG0ah7CYOTZL5mAb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="360958332"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="360958332"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 02:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="707249771"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Sep 2022 02:49:05 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 18 Sep 2022 02:49:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 18 Sep 2022 02:49:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 18 Sep 2022 02:49:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnpMDKdfTScpzGwSRsTkk1yVQf7wnOO+p5Tc1Yn9S+txxPsNGKd5D74cDTwnIRPx7R6aVEoy2co1gMwLgbVRQpgauzROBTyyu6fa3WOc4aL01iurgi7a5oYbmS5i1/0OC8mdzymKzUEex92ehwNF50dDmtzekWxn+GkWxXYT8nYKBkAjQFTCp+uZdm070rdPNYIaL9sg5wlg0BctpYHMvpwx5ei1jo/oHxn46vz6jJMGTp6Rz92UZKykpFlxpcxqMc3dPEsnFbANKL3gkekhSTNM+B+NmdCokdornHgppyRGIJWf+DC1a0qUJLAd0VAALKWML4jmT3unPT09M+JXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SzIAJZR7eXJ9ZMrnq1ZY4f0IkKp7efLB7NxidGxCsY=;
 b=ObyxwWi8OZ4Ft+Wqn05w+61DAGfHIGjArw1TktvSt89s4I5OVkBwEZ3b+aZpQcU93ZG19PhOrcEBQ+WnImZi0Wr3iCLXJxxlNZyi0Z6oU12FRX7lSko1VyQvmv2oBw2Sg3MeSpwVxR76V0TkMbQSJSeSlCIoSHQIn8CmWt6AlpfIJWAbsF/qqFvyNe3ZlE62B+nZ0Tb92sDmqCOBPPOqKQLmQdoyJOG3gm4L8VpFod+bUF5SnIEV7rJlJN6qdBIBrVIXqweslvQhCfyejY+LcxCZTtxoT40SpOh8BBWyudLemqqZAxMlwCFb2J22x9BmmqlPBQ/cjCscUZzllf0P2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by DM4PR11MB6067.namprd11.prod.outlook.com (2603:10b6:8:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Sun, 18 Sep
 2022 09:48:57 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::101b:16b9:9211:831b]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::101b:16b9:9211:831b%4]) with mapi id 15.20.5632.019; Sun, 18 Sep 2022
 09:48:57 +0000
Message-ID: <03c9e680-daef-9efb-19b1-0669d79ec557@intel.com>
Date:   Sun, 18 Sep 2022 17:48:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/3] memblock test: Add test to memblock_add() 129th
 region
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
CC:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220913064138.407601-1-shaoqin.huang@intel.com>
 <20220913064138.407601-2-shaoqin.huang@intel.com>
 <YybkBdrHgo07uxj7@kernel.org>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <YybkBdrHgo07uxj7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3870:EE_|DM4PR11MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a0430b-17c3-421f-c543-08da995b014f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGFQQUjcH+w7rp7SE+RMFjxHq4GEhUg9+9n3opPEV8xrjj42vqWJEld6O5P93k4LrO5+R/MY1LMkCOMLGFMwbFGMbHmWI0cfBjq0CjgAeXv9d/odxPJGfiUbNqpXfPk2xzZ8tnHTObADXhQcytmCHEfiGG/HNkkl5kZG/VUF+jWZxRCT0eObI01ggeDSaW3VBNce/z4n/+VxCcziHfK1E2jol3DffcOscnN6cnDbqOMmT8+pbors0mRUWSPb5zUGJeizDwbX++IAvULnM47yNxQkD0ju+kvohoYlh/gurd255Qrt0ecI+Z/Njzjz9Af3JiV8xGGjeWZvzb37CoFgSjSk3dgWPOp93FoIySZfTNj1THKPicMADzwpzzQP/iH+j3Cj9Z2rb8iUikA2o3lD8OhZCeFCYenA0l+79KwOtDydYq0Ex34PrWuub3B1/a88ruwReonl9o6aTbvR2lRC6ZN+U8IbE7QDc4NQJGR0/dty8n8yongm/OFOf/kOu37xZAKvKcs9j7cZ87mRNVysW2zJ3HF+R1z6DLZHHmYxrI9RNryFLO7CJ3+2NEhzfGSdestGJ/mnXyxZTx3ZVIJOWpQa257J90NlqxJu8ym7zwAjwj12N223jqMjXpgJlfV1pqVQeOFWaOMVBN3w3p1DeNMUBNW6BwjNcY9Xf6ZpMd94L4p8o5tRMvt4NUQYISuiOsi7Gk8S6cT0GgRb5VYBX6H/0WLATKI+N1S0s8NFIZh0IH9uJFV/ZyPjxVx0Zh+TcDA++GiIgHkSWaGSdXE2pDl3H6vLUX1e4KRIsCx7n9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(316002)(2906002)(6916009)(31686004)(54906003)(38100700002)(53546011)(8936002)(83380400001)(6506007)(66556008)(41300700001)(26005)(66946007)(66476007)(6512007)(31696002)(8676002)(2616005)(6486002)(186003)(6666004)(5660300002)(82960400001)(478600001)(86362001)(36756003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sml0RHlWUnI5cTZwcVRIanl2WUFNQ3pyWk8yc3hBMmZrYzJQYnA0Sm9xWXVT?=
 =?utf-8?B?MVNGUzZvR1dGYzNMZlBpenRSdWsyakI5UjZBQkpsM3poT0hRamNuNG9VQzh4?=
 =?utf-8?B?RFdkbmpIa1BPdVJ0cjJqOXIySlFOMTR4Rk5xaFl0bURaa1JVUFNHbXRPSlhC?=
 =?utf-8?B?TllYUEVxRFVjVlgrTjBWeEpuSWpSTVhxRTBzUEg2eXZlVXo5NnRmdFg2V0w4?=
 =?utf-8?B?ZzhUcy9HUjBZRStWMHZCMUNCMnhUdkJhUGVhbEhCakhSQkxJbUlXVnBKc0tn?=
 =?utf-8?B?WlRlcGF1RzNnaHJseThNa1RXZWgvRm0zRW13NFVpaitZU0FiZThyZVU4RWIr?=
 =?utf-8?B?YlZhUTNaZ3RteUpjRlhrbG9CVjF6am0ydWFpVzZldE9kcHhMZDJoQkoxajlH?=
 =?utf-8?B?TXpaZkZGV2VvSWd4TDFucjNGc3R0bkNSaDIzdjlmZ0c3ZTdjUnN5QndzRWxD?=
 =?utf-8?B?czlDUlR0L0w3T0dsdm8vVWEzYnFvVjMrdEJ5MUhYRjRRZWJ6ZlJ1SGt6S0hQ?=
 =?utf-8?B?Tm5uMTR1ZkI1WlFDUXl6dktkdmY4NEFRU0dRaTQ5ZHhVSW5jY0p6T21ncHU1?=
 =?utf-8?B?cHZUQ0FhY3dtekZaMm1SNVFGUGp4aEw4YzlLenNOUDhOOFFyUW9GMEVkeUl2?=
 =?utf-8?B?RkJlYnh2WUQva3RTeFJCUHFka09zV2t1dHdpNGdkcitEWkNKL3ZWT1V2aUlD?=
 =?utf-8?B?M2RLcjFpRlFWMVFTaDZEc1ExYzRyS0c2T0FML1FCbnhINWJzLytuY0NvYS9k?=
 =?utf-8?B?QS82QW1hYjBOSDkzMStuSG1JYk1hZlFkbUJsWWZHUHJtbGdZUGg1RHVCK3lq?=
 =?utf-8?B?YUJNbGQ1bU5DQmcrRnVjZzBwajFNdkhwOVZGMWkxcGp2eTBUb2t3V1ppVTZS?=
 =?utf-8?B?Y2JoQmpGOUFhMS9Xd3pWaHRidzBQeWxua01JUG5CNnNtVEp5b1podU84YVhv?=
 =?utf-8?B?dmpWY0xXcDVaSjhqQ0M3Y0svQlpYQ1g4ckVZYVBwaGF1QjAzZlZBZ2QrL0Ix?=
 =?utf-8?B?Z1lxY1QzUmlwWFp5N0VBTCtGdGJ2bDZWZDhUMVVmMnJJM055Mi93Zi9yN3FI?=
 =?utf-8?B?OXkzV0Q5SENQTFdqWU9QMVYwcWJIZDBsRE83ZWwzVi9YNmNuWHY1QXNDcHJW?=
 =?utf-8?B?b1QwdVpkWW9Td3VQK1lMMmxJSnprMTVZZ2FFMCt0SFUrVmhiOWY1SXVXOGJw?=
 =?utf-8?B?dW9yV3RvQ2hJZk4zU0h4SlRCWFJGZUVhNlVmY1pndHJIeE05VXVOMUluMUVw?=
 =?utf-8?B?dVlFcDJkRWMzSld5YXFVYXRGWFlUVWkzdXA1L3J1TFdSWC9ScE94d3hpd0c3?=
 =?utf-8?B?aCthckovdUthNjlvZ2txdzE5aVI4UWZyelhqcVVtNHo0MUd2T1VFK0VXTWpH?=
 =?utf-8?B?NVh4TXpuTVR0L2Mwa1ROMEovWU5NeUx4bkZYVHpYekV3NmpTQUMyRnJOeFEx?=
 =?utf-8?B?WGJ0NGh6cTVTanpkeGpoVUhyVk4zS09yQnpGZDlrTmdoZjhtcUN1MlBLU3Q2?=
 =?utf-8?B?YmozaXBybS9XY0V2MXF5TktFTDROVUlNNW9oSWY4d0VFNEVBbXFVaEhYQnph?=
 =?utf-8?B?VTZvR3RFNzlKb08yNlNhR04wenJGRUk5eDI1MHBDcWFwZ2JadE1KdUQ5YzZ6?=
 =?utf-8?B?VXpaWnp5clRENkF6cW5PUkZKNWlGV2UyQmFQbTZodVhUSU95ZDA4azYxQW52?=
 =?utf-8?B?Q3MxSDFGOEp1Z2VRaTFNUW43Ny8ySy9KZGdkc2RDK1hCZWdwL1oxTEt6Ynh6?=
 =?utf-8?B?V1VsNVJldURWT2ZQT0pwOFY0eVZkLzEvSjBjVWFEMzJDTHBueGdqOERaOUw1?=
 =?utf-8?B?T0NEeXJZanFkMkxQenRTQXJiTnVaSHJEYzh0VGFpeFhnUmNyYWN1Y3ZxeGlV?=
 =?utf-8?B?ZmxTbEFRSlFiM25zVmh0bGl5U0ZkNi8yWGJIT3dka3EwRVJsYXpLTkQ1TFFz?=
 =?utf-8?B?T1drMkMrd0tta3ZTZkZ1SEhVWHVZeCsyK3p0cFVRZXRRRmhPeVlQVlNtUnpt?=
 =?utf-8?B?RGxkakw4RWtDV2ZpUXJFT0NzQ2FhTW12R0IyYmhOYTI0SmxJblMzVXZaWjJt?=
 =?utf-8?B?a1BQRmQ0bGxibUNOQjg4UCtKTmRTSUdwdEwwNHdCb2dmWGpHbFlVYUY3eXlo?=
 =?utf-8?B?SGowU3dIK2tpemtaaDI2SFBQVURIRWtUZDQ2KzRUNXZ4V05pdHVtN2FiMENP?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a0430b-17c3-421f-c543-08da995b014f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2022 09:48:57.3018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv/PCdKkaZjNl+8SLE9U33ZQf5MWEIVEK4uTLUFtB6R/hiNNt2FbED5i2IuC8Ik9UwruDOqOYeG4IbIJqmH+eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6067
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/2022 5:25 PM, Mike Rapoport wrote:
> On Tue, Sep 13, 2022 at 02:41:30PM +0800, shaoqin.huang@intel.com wrote:
>> From: Shaoqin Huang <shaoqin.huang@intel.com>
>>
>> Add 129th region into the memblock, and this will trigger the
>> memblock_double_array() function, this needs valid memory regions. So
>> using dummy_physical_memory_init() to allocate a large enough memory
>> region, and split it into a large enough memory which can be choosed by
>> memblock_double_array(), and the left memory will be split into small
>> memory region, and add them into the memblock. It make sure the
>> memblock_double_array() will always choose the valid memory region that
>> is allocated by the dummy_physical_memory_init().
>> So memblock_double_array() must success.
>>
>> Another thing should be done is to restore the memory.regions after
>> memblock_double_array(), due to now the memory.regions is pointing to a
>> memory region allocated by dummy_physical_memory_init(). And it will
>> affect the subsequent tests if we don't restore the memory region. So
>> simply record the origin region, and restore it after the test.
>>
>> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
>> ---
>>   tools/testing/memblock/tests/basic_api.c | 96 ++++++++++++++++++++++++
>>   tools/testing/memblock/tests/common.c    |  7 +-
>>   tools/testing/memblock/tests/common.h    |  3 +
>>   3 files changed, 104 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
>> index a13a57ba0815..7120fd8e47b1 100644
>> --- a/tools/testing/memblock/tests/basic_api.c
>> +++ b/tools/testing/memblock/tests/basic_api.c
>> @@ -423,6 +423,101 @@ static int memblock_add_near_max_check(void)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * A test that trying to add the 129th memory block.
>> + * Expect to trigger memblock_double_array() to double the
>> + * memblock.memory.max, find a new valid memory as
>> + * memory.regions.
>> + */
>> +static int memblock_add_many_check(void)
>> +{
>> +	int i;
>> +	void *orig_region;
>> +	struct region r = {
>> +		.base = SZ_16K,
>> +		.size = MEM_SIZE,
>> +	};
>> +	phys_addr_t new_memory_regions_size;
>> +	phys_addr_t base, size, block_size;
>> +
>> +	PREFIX_PUSH();
>> +
>> +	reset_memblock_regions();
>> +	memblock_allow_resize();
>> +
>> +	dummy_physical_memory_init();
>> +	/*
>> +	 * We allocated enough memory by using dummy_physical_memory_init(), and
>> +	 * split it into small block. First we split a large enough memory block
>> +	 * as the memory region which will be choosed by memblock_double_array().
>> +	 */
>> +	base = PAGE_ALIGN(dummy_physical_memory_base());
>> +	new_memory_regions_size = PAGE_ALIGN(INIT_MEMBLOCK_REGIONS * 2 *
>> +					     sizeof(struct memblock_region));
>> +	memblock_add(base, new_memory_regions_size);
> 
> Why don't you simply increase MEM_SIZE, to say 1M?
> This will make all the calculations here way simpler.
> 

Ok. I will increase MEM_SIZE. That can clean the calculation.

>> +
>> +	/*
>> +	 * For the left memory, we split them into small block and add them into
>> +	 * memblock later.
>> +	 */
>> +	base += new_memory_regions_size;
>> +	size = MEM_SIZE - new_memory_regions_size;
>> +	block_size = size / (INIT_MEMBLOCK_REGIONS * 2);
>> +
>> +	orig_region = memblock.memory.regions;
>> +
>> +	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
>> +		/*
>> +		 * Add these small block to fulfill the memblock. We keep an
>> +		 * interval between the nearby memory to avoid being merged.
>> +		 */
>> +		memblock_add(base + block_size * (2 * i + 1), block_size);
>> +
>> +		ASSERT_EQ(memblock.memory.cnt, i + 2);
>> +		ASSERT_EQ(memblock.memory.total_size, new_memory_regions_size +
>> +						      (i + 1) * block_size);
>> +	}
>> +
>> +	/*
>> +	 * At there, memblock_double_array() has been succeed, check if it
>> +	 * update the memory.max.
>> +	 */
>> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
>> +
>> +	/* memblock_double_array() will reserve the memory it used. Check it. */
>> +	ASSERT_EQ(memblock.reserved.cnt, 1);
>> +	ASSERT_EQ(memblock.reserved.total_size, new_memory_regions_size);
>> +
>> +	/*
>> +	 * Now memblock_double_array() works fine. Let's check after the
>> +	 * double_array(), the memblock_add() still works as normal.
>> +	 */
>> +	memblock_add(r.base, r.size);
>> +	ASSERT_EQ(memblock.memory.regions[0].base, r.base);
>> +	ASSERT_EQ(memblock.memory.regions[0].size, r.size);
>> +
>> +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 2);
>> +	ASSERT_EQ(memblock.memory.total_size, INIT_MEMBLOCK_REGIONS * block_size +
>> +					      new_memory_regions_size +
>> +					      MEM_SIZE);
>> +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
>> +
>> +	dummy_physical_memory_cleanup();
>> +
>> +	/*
>> +	 * The current memory.regions is occupying a range of memory that
>> +	 * allocated from dummy_physical_memory_init(). After free the memory,
>> +	 * we must not use it. So restore the origin memory region to make sure
>> +	 * the tests can run as normal and not affected by the double array.
>> +	 */
>> +	memblock.memory.regions = orig_region;
>> +	memblock.memory.cnt = INIT_MEMBLOCK_REGIONS;
>> +
>> +	test_pass_pop();
>> +
>> +	return 0;
>> +}
>> +
>>   static int memblock_add_checks(void)
>>   {
>>   	prefix_reset();
>> @@ -438,6 +533,7 @@ static int memblock_add_checks(void)
>>   	memblock_add_twice_check();
>>   	memblock_add_between_check();
>>   	memblock_add_near_max_check();
>> +	memblock_add_many_check();
>>   
>>   	prefix_pop();
>>   
>> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
>> index eec6901081af..2de6a2b6efd2 100644
>> --- a/tools/testing/memblock/tests/common.c
>> +++ b/tools/testing/memblock/tests/common.c
>> @@ -5,8 +5,6 @@
>>   #include <linux/memory_hotplug.h>
>>   #include <linux/build_bug.h>
>>   
>> -#define INIT_MEMBLOCK_REGIONS			128
>> -#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>>   #define PREFIXES_MAX				15
>>   #define DELIM					": "
>>   
>> @@ -84,6 +82,11 @@ void dummy_physical_memory_cleanup(void)
>>   	free(memory_block.base);
>>   }
>>   
>> +phys_addr_t dummy_physical_memory_base(void)
>> +{
>> +	return (phys_addr_t)memory_block.base;
>> +}
>> +
>>   static void usage(const char *prog)
>>   {
>>   	BUILD_BUG_ON(ARRAY_SIZE(help_opts) != ARRAY_SIZE(long_opts) - 1);
>> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
>> index 78128e109a95..ba14dc989ae9 100644
>> --- a/tools/testing/memblock/tests/common.h
>> +++ b/tools/testing/memblock/tests/common.h
>> @@ -11,6 +11,8 @@
>>   #include <../selftests/kselftest.h>
>>   
>>   #define MEM_SIZE SZ_16K
>> +#define INIT_MEMBLOCK_REGIONS			128
>> +#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>>   
>>   enum test_flags {
>>   	/* No special request. */
>> @@ -104,6 +106,7 @@ void reset_memblock_attributes(void);
>>   void setup_memblock(void);
>>   void dummy_physical_memory_init(void);
>>   void dummy_physical_memory_cleanup(void);
>> +phys_addr_t dummy_physical_memory_base(void);
>>   void parse_args(int argc, char **argv);
>>   
>>   void test_fail(void);
>> -- 
>> 2.34.1
>>
>>
> 
