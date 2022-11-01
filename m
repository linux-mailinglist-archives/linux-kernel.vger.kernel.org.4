Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AA461561B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKAX1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiKAX1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:27:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E882017E11;
        Tue,  1 Nov 2022 16:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667345248; x=1698881248;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dUzSZay7ULKxXQaGluM08DI2Dc71hvYu3m/CrigHHl4=;
  b=PAUqLOqZtPQyWNg32dhf9KJOwEj9ZsZ8G2zcbau2o5iAEAcCuoeqie/k
   HCHdrI2labW8z7qPJT6FBam6N5XJTyFsSRa1/DyWkVTqdJQTQy4Cj08cA
   m/7G1ATg89Irezf8fjV5D5F2YVCu8d9Zm0Mx6y6WjZoWNyrzg+pcXJHOg
   aZugCE3tISqUQp5X4F98QyMgU3vFkz9BgbDjHfjdatjKTck5fwqF0Yr2T
   143q703P0ae4Y8WDbknxnodyiBYYlHVvb/KmflPvK44YJ1N/07JuC5gvC
   FmaxD1eySdIDRXp91VL/oXZUnPtf42nGq+SVKX0yIuz0woIkf+rSvOUHm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="371353744"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="371353744"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 16:27:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="665332918"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="665332918"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 01 Nov 2022 16:27:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 16:27:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 16:27:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 16:27:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMu1N4LryvJ7bmpDpb6VTKroaRHtBQ3hy4FvjIMuTbCj5G6DaXkX6AOZghyANVo954I7CYTj1fTb4Q31Sl+PVcsZpFJDNaZ1XSc6tn6WCkaMJt60slNtl0+gx6yLi/tonVjDXPsTcgPMq7bG35SGjD/3V2U29+pZNDheL+Q5/3qjikPA/bXb97bXMSVgfKCr44sJZ/H+jYyP0x/cA20cKk3PsSKiHIAnpV8MBcgzI/+NfjziitODJBM+a0aAb/duccA/LbqPrX1qZRKuUoMTeTTzuCHAhL+13PNUCTetTLIrkTw6lqberDxe4K8TGCYNQmnv0wEYRDRzGIZjak/BKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1aXs6Pv9dv5qPq34bwMyMqm+FGZ/d6PW/9aI6PqC4s=;
 b=DolgFQK1waJZq9gCa7+AjgRcu8EpOseURG44Fm66XpV8n/rLGtx/BvHZWEm4KGbMNF1QOo6tHn9GLdW35cJ00YBNAzL4xetRz77pa8NGAVSpdRmCvYsu+I3AoB+CqqmKYF/HiwofUlrdekzyI6QEYkGd0cysYDHmPOFpNhsL+co9Jv+5HolCJETe+IiPhx3gLAmHv3EPvRkgmYACAfyzKoS0fD2gH7SbUahdYVmYM6mePR2vWcYi94LwjN/zkboYQYnSA11OFLBbcndwb9W5uwljKAz/7sK/4mj7OZQd28YffKbLQvZVBpH4/ee1V8SlXpgx2gz6hoByU+jcgdZRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by SN7PR11MB6898.namprd11.prod.outlook.com (2603:10b6:806:2a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 23:27:18 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 23:27:17 +0000
Message-ID: <5edd67d3-e16e-5696-57b4-a9514aa6de63@intel.com>
Date:   Tue, 1 Nov 2022 16:27:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-13-jithu.joseph@intel.com>
 <9bfd45cb-ab5c-1d46-1e16-03417c89298b@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <9bfd45cb-ab5c-1d46-1e16-03417c89298b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::45) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|SN7PR11MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0ae0d2-fa93-43bd-c430-08dabc609d62
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzOwuyiOEaDu0gNK96dL64jwBdhNOV1uBWhAgAnQmMLSMk5DqIkNOebscT3PIXdhWfducaHAqo1fm/Txjs6fLCkD/JVejbuTPh8JtfUw59N+CuLENPffNULeS7tFIOIgUGQJwaBm5EMXw/3BO14IELRT702hyvqVDvNkE6aAsEvbHDaZPD/j2OjsSh/dlzjspuXis4xXTMSTrrOfVR9qYLDQWrolDHMvoQID+pFPtvg+r2QGa672rUxxSmUSpfpW8Rjm7U2Q0zi5eP/vqh9aqxOIVWmcfpVI4ShSjM5CiEfEnxBNDyUpFkJIlMzcmW9PeFyxbhRD4klWz9Ncv4Ag9axDuvaCYhuL53Vf7mQZmkYwJcODct1Zi8OHn1X9vzY/WUejT/5AKklEsFTf9LP7/a4HGD+5aFbA1Q/8Qhwkdm66hKZssPkw5fiHwO2iFU2ZqLzL9i4m8bkESF+luOMvTnQPaBnhtMSjDKCf8nBvCB975mHrGGn0uKnVN6GU6x/r3LcA6NmhIgbz9nqtlBcqE/u1GW8llmaB7qYiMyZcDv9DRvkVxVT/qRhcyl+FGEORCzi9aVnBvPcNwbe8TRs1rXSm3h1JrCofFVgm8ArGgqHvA4hiBI/5UMlCG0sWXLhI4bry11KMtEGqtsfQTBZg+w2QPrKpGVhxTmyehU8WeXx04JEfW8tI7sR+/iSI8u8kS9SYNGukI9q3eu4k6i0rysalShng/w5Ev7vZS96qEnYL5nx0TJpqzj1TccIm9awu7OyV9L48+fZnk1f/6RAG+4h6CAZgkQP0IylnW7w93Ws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199015)(186003)(7416002)(2616005)(8936002)(5660300002)(6512007)(2906002)(41300700001)(26005)(82960400001)(38100700002)(36756003)(83380400001)(86362001)(31696002)(31686004)(316002)(6666004)(66946007)(53546011)(478600001)(6506007)(4326008)(6486002)(8676002)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJ1R21kYTNCRi84Y1BOcWMvYXFFbXM5RVBNaDJiZDBIUlpGRGRpNzNLWEx4?=
 =?utf-8?B?a0lidnk3UVJJNmw3ZFF4czVRYzBIbmNIUkdWanIydDcvS0I5ZldNZ2Rac0E4?=
 =?utf-8?B?ZVBKZWtMYks3UEMxdytIMDk5MDNFMTBqNjFWdWRkU3FsVzJFYnBNNEFwZ1Nz?=
 =?utf-8?B?S2R0dlNJUmVCZDNIN2t1NnQzNlV1TGo5VVltZlMzRjBQcjB1Zzc1VUFkb245?=
 =?utf-8?B?R0hTcEpvRHZNOWp2enJ4cXRobmRhbVphZFJPNlhDVmNqTXBnTXJ2bkRYUzYr?=
 =?utf-8?B?OWFHb2pObVdzR3k0YXc3YldlWjN6dFRBZk9DdFJ5VHAwejQrSWFUTytYV0F1?=
 =?utf-8?B?ZGJpeUlHd1NqL0lVSy85bHlFeUFsdEdYQ2RmektMeGxCa0wzYXg0cUNIWXF3?=
 =?utf-8?B?Nlpjdk8vclVRZnhQZHVyeU53b2pIYitUTkw4eThlUTA0U0NHSnJPdUxCTEFO?=
 =?utf-8?B?NGU4NFRqam5nZjlaS1NueGFYdDIwdUtNYnJOQjRNMHVveEV3RUVXUlMzdDN5?=
 =?utf-8?B?UlF3VkZuR0pXVzRhaEF2SXNuVnFJOVpBRFVabnNXd2hKd0cvbUc4ekw1RkRC?=
 =?utf-8?B?UWh3UGNod0dOZnltOWtBR2k2S3dwTThLemppM3oybXdjTlhUTXlFMWRJZ09v?=
 =?utf-8?B?dUMvdUw2OG0wM3NPeXdWa1VJeEhPZGUvcE05VmgrbERNaGZsK3pxTElGYnZj?=
 =?utf-8?B?QWZtam9URDJIenhpRkxrc0J2eUFHTG1SU3BGa1YxU1huOGJRMzNxR2IrcEJK?=
 =?utf-8?B?NTk1NmxodUs0TTJPRjdxOTY2NW9SdEt4WUtHWTYxMjVaSWptRmVHUUY5d2hi?=
 =?utf-8?B?c1puYmc0bHBHd1NoQjkvdmdMNnN0WjJiVzFuZVp0emRIUnpVQjFSWjVUam90?=
 =?utf-8?B?ODFINmFQRFpDNmpieVNVVVlPNDVtVGJXcHNJNVpjSzJYR2cxbWk0L3kvbnNG?=
 =?utf-8?B?dnZqTkd6N25yNytocWR0OTlYUm9WcWtkTmZjR2FnTUxURy9FbmFOQm9yVG9I?=
 =?utf-8?B?cWN1dXFhdWhxZTh4ZURHNlZ0aDF6NVVDQklDTHNYbVV1UDA2RnRzS0d3WUdi?=
 =?utf-8?B?Z2dsTnlwNzhHbVFZUE5EcTZkdkpUS0NRdlNQakNYUnJwWjRPUHhyTVp5K09j?=
 =?utf-8?B?aTVyKzMxSkNXNDJ1aWE2QkszRXRCRGVIdDU5QS81ZHNDZ2pCUDZtamhWZjla?=
 =?utf-8?B?ZithbFI0ZGI0SGJFemJaU3VtNnFaTEQvUlBKYVFERUdJajljTkhlYjlhcEhn?=
 =?utf-8?B?cFI0YzI1TjE3Zldzb1JNWXZTZUd1MTJuYjFIejFsYzdPdFpzRHNmQ0Z3TE0w?=
 =?utf-8?B?UTI1N0xuS3dpTDZHSWYvTE5iTUl4dU0wRm5HMW44d0x1MUgwWjNrVmFtanRT?=
 =?utf-8?B?dmU5M1k4SXN3NTZMY1hlS2F0ckVod2RRZThHMVZVUVRpK2ViditDQjN1RGFk?=
 =?utf-8?B?RjI3RUtiOGZNMGVUeEJrUjhyRkljWndwRFV1QkdhZy9YNkpaREVFdXNqSUdX?=
 =?utf-8?B?MU0yUnpselBnMGZBb2hpME1qdVNmV2ErcFgvUHAwOHZ0SVhCazdyRWRZTnZM?=
 =?utf-8?B?TjFWakFxbEl1U0lVcmFwUllNM2Rlc0RlYzVZNEtXTHNOQXVpZllrWWpYMEFS?=
 =?utf-8?B?dTVDd1YvWkpyOG9zakE0T29iY0hRSTRvM0hTSVR0RWdweGpMNWNzNnduWVo4?=
 =?utf-8?B?NmFGZ0IvckoyOFZXSURvUDNGWjNoZ21MNDRwdHBOVVNGeU5obkhRTmtLME1I?=
 =?utf-8?B?NkcwOG1PcllKMmloN1lVMS9ra1VocjVTSmF3dmxDRm1KRGJRUVV3VytEaUdh?=
 =?utf-8?B?MmRrTTdmTkRPQUl1MnNCcTI5TldMNkovVER1MDFnYW94N0t2bUpTWU4wNk84?=
 =?utf-8?B?WThGV0dSTy9mODZ4b2xWSG9qNDBkZTcyU3RPbXoyTlp1Qi81Umw5OUROWktZ?=
 =?utf-8?B?eHVjVTU2d3NXTlg1V2JlbWthRlVsVjd3L1oycTBXYy83bVE4SHpkSFlyQk9C?=
 =?utf-8?B?QVhjYmZGZkUzMXFkanB0bmF2ZWpYRy8zQzVUUERXTnVNd1VpUzVnMCtKdzAy?=
 =?utf-8?B?b1RpVjdMZENlZHZObU9tUW81WUsxYklpelFPOVZpbzYzUG5kTzNGRTA3RU5J?=
 =?utf-8?B?b1d4T09tZXNRd3pMbitxZ3lDNzIzTVZqOS9BUWsxeTFiTUlwcXBldVRFZzJS?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0ae0d2-fa93-43bd-c430-08dabc609d62
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 23:27:17.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lO8q2uDcxT8qsSuQiN7dc05jAOpsqBCXJsCDFYW44cPpoLYcK+TE9iXEpMSwr+Dhs9qQkImGgFuZ3KQ35uou2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6898
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2022 3:26 PM, Sohil Mehta wrote:
> On 10/21/2022 1:34 PM, Jithu Joseph wrote:
>> Initial implementation assumed a single IFS test image file with a
>> fixed name ff-mm-ss.scan. (where ff, mm, ss refers to family, model
>> and stepping  of the core)
>>
>> Subsequently, it became evident that supporting more than one
>> test image file is needed to provide more comprehensive
>> test coverage. (Test coverage in this scenario refers to testing
>> more transistors in the core to identify faults)
>>
>> The other alternative of increasing the size of a single scan test image
>> file would not work as the  upper bound is limited by the size of memory
>> area reserved by BIOS for loading IFS test image.
>>
>> Introduce "current_batch" file which accepts a number. Writing a
>> number to the current_batch file would load the test image file by name
>> ff-mm-ss-<xy>.scan, where <xy> is the number written to the
>> "current_batch" file in hex. 
> 
> Any specific reasoning why the name "current_batch" was chosen? To me, batch seems to suggest multiple or a group of files. But in reality only one test file is loaded at a time.

There would be a batch of test files (6 in the e.g described in the commit message). At a time you can load one by writing its suffix into "current_batch". So "current_batch" was more like a short form for "current_file_in_the_batch_of_files"

> 
> Naming can sometimes be quite subjective so it might be useful to get multiple opinions here.
> 
> As per my understanding, there is sysfs file called run_test which runs a loaded test. Instead of current_batch how about the name load_test (or maybe current_test)?

Each file would contain multiple tests. All these tests contained within a file would be executed when you write 1 to "runtest".
Given this load_test too would be confusing (more appropriate than "load_test" would be "load_test_file" or "load_file" or "current_file")

> 
> load_test - Write a number less than or equal to 0xff to load an IFS test image. (Description as-is from the documentation patch)
> 
> 
>>    * Running tests
>>    * -------------
>> @@ -207,6 +217,7 @@ struct ifs_data {
>>       int    status;
>>       u64    scan_details;
>>       int    cur_batch;
>> +    int    test_num;
>>   };
>>     struct ifs_work {
>> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
>> index 5fb7f655c291..1f040837e8eb 100644
>> --- a/drivers/platform/x86/intel/ifs/core.c
>> +++ b/drivers/platform/x86/intel/ifs/core.c
>> @@ -22,6 +22,7 @@ MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
>>   static struct ifs_device ifs_device = {
>>       .data = {
>>           .integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
>> +        .test_num = 0,
> 
> Is this initialization really needed? Wouldn't it default to 0?
> 

Not strictly needed when we have a single test

> Maybe if you explain what does test_num refer to it might answer the above?

It is currently used to form the path in ifs_load_firmware() for the test image to be loaded

> 
> 
>> +static ssize_t current_batch_show(struct device *dev,
>> +                  struct device_attribute *attr, char *buf)
>> +{
>> +    struct ifs_data *ifsd = ifs_get_data(dev);
>> +
>> +    if (!ifsd->loaded)
>> +        return sysfs_emit(buf, "%s\n", "none");
> 
> Why not:
> 
> sysfs_emit(buf, "none\n");

Will change

Jithu
