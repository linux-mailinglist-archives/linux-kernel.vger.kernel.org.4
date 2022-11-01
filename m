Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86734615547
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiKAWse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKAWsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:48:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA47BF020;
        Tue,  1 Nov 2022 15:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667342910; x=1698878910;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TEYJAIrAPW6/wnMtVgOUKD9Ppy/FQg0GH38phhQ3ZNQ=;
  b=LXlF+2cEuHflfPgE6H2U+iQ/Gg472NwEjpYMaNzWoFd0/oVEZO512mMZ
   J5XpbHY79uKDxpWeqPrjAJuWIcoppaTJE6STGkiSilytH1Mj4yCZ7D+Xp
   dBRGPso+i1jk5wj2EmMY3yPucW/1LtgoD1ACMIRdLobBmmRsdsPjAkl7+
   XKZ94k1Vt4keYAdxOJXTf6C6YvnDFx7+ADUh4m1mMdqELyd7P54bleCsP
   MJgLN/2MG8bi1qOf96gYfVnc+lZmksMd/THEU6H6CRazwkrNoIWf0yTJz
   HfrWVvnCl+doR+MBhinLzgkcr4rxg12+RoDJZojqf2gx2ucyni11v40jF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="307981646"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="307981646"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 15:48:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="667358062"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="667358062"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 01 Nov 2022 15:48:13 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 15:48:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 15:48:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 15:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZ/uujU63ceuLDCnqsdIz6eR+DqUQZfACmD//3maw3ZoXWFHcrvIOlAZiK2Lh9z38KQo+D+TKwOxcTPSLlCLE0rwQ9aGQqZoG7FF/051DNPDbsMLtN9ZId2erdCBo/h1fSjfjkvifoJo22CsPPv7yqojaWDBC/LXvoM5IG/dKaDeYholGHH79qkmrNffFo5hEu3alVnSEtEY97FCiCEsAQwSrGXol0LxahmEuelT1ehVb9QOhapp29odMrOVU3VW+o/dPVK5cZBaokao1Tw96/HZPS/MbVgazvKKC7PbueZIl51AgAodMBfjlFKMqmzApSVY1woG7R+5k79cMemMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS/ZEnHjD0IyT+YF1AIuloWnWAlAK7QZi29TTYSW3Ww=;
 b=NBMS51qHebJx/9foCL0UKPDSKqo5uByBtOpfqixUob6URCMi3RIY8qZt5hJO32WxVcGrkrEENM+cwn3CeVKLQTiCaR7cq+/tF1mkR28sPhGiGHsYfnsFqYfV/4LVnNvGluPW+AH7c/Bk7dkZTTc7TlcuBn6qxO1cQhiq/J2Tfux8BLGCg4B5bj9pPI4LU1UMl2DVjSk7sabLjMKnEZFrQChntUubogb+65wXb3bML1ZPkPhKFQJmsPycAinbDMlbDba8fFBPHdkIrnb11ACtR5RkoP/7WyBkC5F9t+FOU1s/RnVLYC1ICIKxxFU1kyDlw2qbdJzjAHJQCmKhv0yppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DS0PR11MB7288.namprd11.prod.outlook.com (2603:10b6:8:13b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 1 Nov
 2022 22:48:11 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 22:48:11 +0000
Message-ID: <511d9020-04d2-0deb-5f92-a7b2d6b9830e@intel.com>
Date:   Tue, 1 Nov 2022 15:48:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 13/14] Documentation/ABI: Update IFS ABI doc
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
 <20221021203413.1220137-14-jithu.joseph@intel.com>
 <0722deb9-797b-c8b6-ac15-a6d9a7d50a67@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <0722deb9-797b-c8b6-ac15-a6d9a7d50a67@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DS0PR11MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: e67ebacc-d81a-4ab1-074c-08dabc5b26fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yxh7JN/xfJDZOZx7TYcZJMwxdMfM0OcsMWMoeCA/DgHBCumPXnszeEGRJhgvLioohkeF77h/SMKdZbC+7Krr8JDgFPBMZQLB8JrK/ry548KMO7STUplWXe6pqtDYebTLFu7WmaR6fQPtZAGgzxeZWpQalZYqidoKI1oaedBRsDjKGCDAwQTXtxlP57jHShZ3n+ZpodAgM0UWp8esCWrful3n0wpu0enMWSiZXR8nqy26AAMTkOrasSYaH8kO3GaSYfoTJJaI/gFAE58bzUJv3oYGk1K+UKA8li6pru8mgfXqsYQgk9wtn/M7VQpQ0adD3SSz+giwRhS4IDV924WS8fQZgDwhKUB1QYzBWSw/u3hEhF49dqXupxXCswVCGip8kSb7RixNWctHh7WYNYp4jWEAITb9ulE1VU+lCKL3rN9lQrnldHfbXApnA7UHPHrvYf80YiPZbeu8mQvYLNNyZgotZaBskpRQcLwH2qiis8ahTudLJxS9GtpWbi+peKRZvcndvgb2IIr2xnnwIWZnm22ii/Z6PZmdyhcDf2zTMjQCc0jviq2NoCpC/hC7WRLla9sMUVaz/XX1oUZxhD2LDp2w0/Zq1g+RuUDDPBiaRfAHlPb1Y8N0TV/2sISo1Fzps1AVZVfBGqixO2+EWBqkN8lv7CqazMikr2W/kb2qIsDJ+j/KvqrvmUCaHe0wEb4Onxpbey/TPU6BCHxwT4Wm4bgYGIJlATFWdC3lgxJ7egldoNYKC3ovRl242CwpaAECVVJ9adP4n2W1Bwbnb6MnZATCxVed46WhALEbOQE+icw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(86362001)(31686004)(6486002)(478600001)(82960400001)(316002)(38100700002)(6666004)(7416002)(26005)(6512007)(41300700001)(2906002)(186003)(5660300002)(36756003)(8676002)(2616005)(6506007)(66946007)(53546011)(4326008)(8936002)(31696002)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDJWVGUwWlhXS2t1Zy8rYzM1ZVVLS0tPUkRyM2dxck82bDVaS1MvQ3Bzd0ZM?=
 =?utf-8?B?VUErMExpazlEWkJicEZPUjArQ296bFlCaWM3MFBaNU1WOE44RUJaNDVuYzkw?=
 =?utf-8?B?Zkh4a2p2WG11dCsvWllteEUzd0h1Nkt0QmZSNXEwblpoNExPWHZQN0ZlN25u?=
 =?utf-8?B?a01SQnBUeU5BbHFWOS9CTXpqN3p2QlA1Tmx2TkNrVk9xdElKQVdwdkcySVQ3?=
 =?utf-8?B?eEVKcC9ReVF0bm94dEh0akd1aDllRzNwQkFQTEIyZzVoUkxTcFg5V3dVOVVG?=
 =?utf-8?B?Snh2YzNhOWZ3SjBQeXNSeUF2b3hxRk1Ec2xiTTYvcGt3T3I1NG1mREw4NCtz?=
 =?utf-8?B?M0JqSjJxQW9YVVJRVTJ2a1ZiRjJpV2tLWmRscWhuOHlUTU9wZGcxbmV1aHoz?=
 =?utf-8?B?c1pwbzR0bWVod2svZlRHdWlNNjk4T0VLZkJtZks4Ymdyd21mVFpBempHVEkx?=
 =?utf-8?B?VytYT0NKWU42YklicnMvelkwcEhKMFRXZWpUSkRpZTdwTUZtZGtxM3ZtRUxJ?=
 =?utf-8?B?SlFoUzRlREkrUnhyYkkzeFp6YWVsc1d1c0daY2pwZEIrRFF1UG5aMDI0SFM4?=
 =?utf-8?B?SEl4ckJtQ1E4Q3RhRmpoNm1iUnVMeFZEWEk3Y25NWmNldDB2cyt6dUJmdFlx?=
 =?utf-8?B?YnBCemZoTTN5OXRSUm1wSFdZUFJvYlNid3JhRjdHVHdySlJIblYrMkpmWW5H?=
 =?utf-8?B?WUU0Zmx0djY2VTJVMnMraVgzeHdjd3JvOFBTWVh3V1JLMzZqR3RhQ3Q2QVJI?=
 =?utf-8?B?RXNsZHR6WURPUWFVUjZaSW9Ja3MrOTVWanJQR0Rpb3FDV1RvLzFHamVVYitl?=
 =?utf-8?B?d0lVZklDQld4eHZJWitudEhlTnNZVm1tK1JGVGp2b0J6Vm5Jb3BtWHU4TFh2?=
 =?utf-8?B?S3VhQy9IL2xmdkJOZGZCWVRPMzA3L0VXWmh5MDhoRTY1eWE2cUEvU0xQa3h1?=
 =?utf-8?B?Q0MzWHI3blZpVG9BYXdBTENJVTNDbTdGS29wMEFEWUVXMmhtQVl5RUU0cGdl?=
 =?utf-8?B?cXJPSjl3MzdhZUJiaWl1T1JxRktNRytud0RIRXpVWE55ME9EeXRmaWw5czYx?=
 =?utf-8?B?Y2kwVnhRMzdtNnZ3S29tc3VzdDljaGRiWEJhdE9HM1daSkQ2TXZlK1k5YjJI?=
 =?utf-8?B?NVFqNmE4THI0MC9JeTN5cFhTL21POCs0bW5EVy9GV0xTSE5FaXluekloV3Ex?=
 =?utf-8?B?ZjF4alVsMTltVmQ3VGVERHMxNkttUTBLMVRPbE84ZEFxTUptS1g4VkJBMFY5?=
 =?utf-8?B?VjJ2dHBsUVkxd1NhY2ovcDVwL1ptT05qaW0xM3V2Z0lKRTd3L00yU2oyejRT?=
 =?utf-8?B?YzVqeXBIdGRNRENxalBBZ21ic1V0Q1R4cDJlWlFibEVKajBXRm1nUCs1eXo0?=
 =?utf-8?B?bHk4bVFVdy9vZVV0dDdUSEkyQ1ExRUcrMDNZY091UldBdU5pcUlIOU5oY2NZ?=
 =?utf-8?B?b3ZVUmY4MGFULzF5TGRVSm1oK1dTbkRDOHllOE5xci9nTkRzbExJL0Y0NnpO?=
 =?utf-8?B?Nm9oZys4NXV0UFlxQzVqOVh1ZTJjL1R1NU0wQ0UwcDk4d3VPUGsvTjR6YWc2?=
 =?utf-8?B?YUw4aHFQazV1ejhQc2p1M0NIOTVCTURUanhvWDVVckdjK0FRK2YxOTZnaEtw?=
 =?utf-8?B?ZjhDd1RYKzQxeTlvUlhrMGhsc0FlQ0dhZkdyRXd6T1FEcTkyUFRhVy9uRy9v?=
 =?utf-8?B?ZFUrNmRwdnRvYTZNeFNnL2I3Vkw2RWhJaldhVkVwTUdYcWNYWE13RFJpVkRo?=
 =?utf-8?B?SDIxM1MrQndVWHM4TEVZVnFrZ3lQMGpOODY0QXNMVWdOUHg5cjl6ekFrM0cx?=
 =?utf-8?B?bmxMdERoUGRZRXdMRUVqeXI1Nms2b1hsVEZVTUhTdDI3QWFuc08zWGpUTFVE?=
 =?utf-8?B?aENiUERCdTBUbTRiT040TGl1KytlNzg2bzBSQXF4U2x2NlNQK3Y5OWIwazhP?=
 =?utf-8?B?ZUpmZlg2ZDNuYkEvbjY1eGFzeWI5UzNpb2N1UWxBMUtmU2l4NXh2OFhCVVo4?=
 =?utf-8?B?VmZGZDBYR29SOHpueGU1dmpscm50K3d0Yk5WRy90bFNlMmYyTEhzT1pMbkxu?=
 =?utf-8?B?enh5NmZ1S0lIeGdGS1FVemxkWEZWQ3VlRHRGTS9qcDBaNWdNZkxKRit3dThF?=
 =?utf-8?B?T1o3ZTNYQ3NhdEp5ZlZ0bVFveXM0UEhxM09iS2RVemg4MS9xcm5GSEF6TnNm?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e67ebacc-d81a-4ab1-074c-08dabc5b26fa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:48:10.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3tfK75WO0BzTgCiVmJD8ToGUNUs7amInyHHBd/O9nLhB2ESo+GSP0s6RSDtdGoDCb0T6/tOLTSergwHT740kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7288
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



On 11/1/2022 3:34 PM, Sohil Mehta wrote:
> On 10/21/2022 1:34 PM, Jithu Joseph wrote:
>> -What:        /sys/devices/virtual/misc/intel_ifs_<N>/reload
>> -Date:        April 21 2022
>> -KernelVersion:    5.19
>> +What:        /sys/devices/virtual/misc/intel_ifs_<N>/current_batch
>> +Date:        Sept 30 2022
>> +KernelVersion:    6.2
>>   Contact:    "Jithu Joseph" <jithu.joseph@intel.com>
>> -Description:    Write "1" (or "y" or "Y") to reload the IFS image from
>> -        /lib/firmware/intel/ifs/ff-mm-ss.scan.
>> +Description:    Write a number less than or equal to 0xff to load an IFS test image.
>> +        The number written treated as the 2 digit suffix in the following file name:
>> +        /lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
>> +        Reading the file will provide the suffix of the currently loaded IFS test image.
> 
> A few places in the code use the following string: family-model-stepping-02x.{testname}
> 
> Does that mean that the in future there might be other extensions apart from .scan?

yes as when when support for additional tests are added

> 
> If so, current_batch would let the user identify the 2 digit suffix but how would they identify which testname is current loaded?

The testname would be inferred based the sysfs file context (the<N> in /sys/devices/virtual/misc/intel_ifs_<N>/current_batch) from which the operation is triggered. 

Meaning if the user writes to /sys/devices/virtual/misc/intel_ifs_0/current_batch it would look for ff-mm-ss.scan and if they write to
/sys/devices/virtual/misc/intel_ifs_2/current_batch  it would look for ff-mm-ss.<test_type_2>


Jithu
