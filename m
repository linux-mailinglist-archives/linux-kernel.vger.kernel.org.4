Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91187617841
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKCIDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiKCIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:03:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283E638B2;
        Thu,  3 Nov 2022 01:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667462596; x=1698998596;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tRXGdbEJ04NaYCsPVGAM8i5Xliv5Yu5FosJIXsCIOtI=;
  b=OP9+ZWHo4Si9ptMLAtp74jL21aJ7Y5U+M6YUYSCp2Is1lD8AB9u+JM60
   YqCh54ecebq7MMlMDLw1Hc+lzuWjrVgT68WsBbcJQhxV7B518KrYMtcny
   E5tgt/MkLfDzh0GefrhVIgg06r476VcRAE9szraJWAX9d3SyxOTQFO8+D
   LxRmt+G3fmajtCkpe45QvSRUKBrU/Wkck05tnmqSsDtYnoHuQX7eX6+XP
   JC9ts1OJZ+0vcq6JzdrIt17XfmQDF1ZCAqiR5tSGg5nTsFfwzjIp8FP09
   XmxOMClKdvdsLqG1vZQruCtXqMkMZ4D+rlsJUkhjBOhtVpBJ18oMFXRuq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="336305401"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="336305401"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 01:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="637078159"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="637078159"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 03 Nov 2022 01:03:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 01:03:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 01:03:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 01:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avMfXT1stU/PiiBaiZu+uRqcA/OeEGaBqd32wihA39OP4/AQ/YYTxaebG/SJ3tKNNk7YNaW3waSzIFzZpgnpRlV/vsfY1Ef6ECEGGY6KNj/z+FYk63Gxp8hqJ+1bp3zojy9eX3ao7Jb6eIt/Fc4y0nON+hY4pWi1ZVEIev5ucEl2eOBp88KFzqpj7/821wSO0lKxQm+hh6lZf9zc/pOi6SoUM19Adniq0j5evV/rmlfGY/D4psgTWWfd1hx6hirkqxJpfsHoIpeCEaR41EbJz2G8nM8VLDuIUwrZVMhYpvXWzJh9dU8T3gJQXfhexvw3eRBPRvctdf5FyMFXESARtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbXtm/6oGGlu4lzAMYBINqB0RhtQfFILrkzFwXtojc8=;
 b=QQR7Id+lX/EbCr9SXAmvrJk0/R6iEYYHh+AwN7ysuknqY8iWK2QYRXZd4qrFBQItQg0Gwcpf1hZW/iQICi6zcr0VvTW4wqY3AYmK9M9BNYgaNwPExe5J5PMchg1+uQzBqZvCBkutIz7CAOnq5f8smPvdQkR7+OK77xAihVvu/FeFvZM8MDfHlrHocizTxxHIGDDuNPavyRMYVQJz+pNR2N6Y/zb7grg5wxy8B9Dw1X2e+jlOUX9vx7FmcIBf/Vb5fbVy2OCusDJUNBT0huxztv9kdLzNKtqM5WZN7kMAbICzs1mMhJxXY7Z9p8GBDobmoVqWlc82S42B2tzVrp0HKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 3 Nov
 2022 08:03:10 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 08:03:10 +0000
Message-ID: <dee13991-49cc-2cd9-3103-121627114ca4@intel.com>
Date:   Thu, 3 Nov 2022 01:03:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Content-Language: en-US
To:     "Joseph, Jithu" <jithu.joseph@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-13-jithu.joseph@intel.com>
 <9bfd45cb-ab5c-1d46-1e16-03417c89298b@intel.com>
 <5edd67d3-e16e-5696-57b4-a9514aa6de63@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <5edd67d3-e16e-5696-57b4-a9514aa6de63@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f721be-1e5d-43e7-e8de-08dabd71d9a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBLspO35j9URzsTRQqx6Wng95uL+ts56Zm8Nw+7aGp9BrodeGO9cXtmOefcn9AEUFSS9zThfqZ+EEafyRt0vjLP59ncaE/31sKDU9LFm8Rh58Me/RVmX5uI0IVdLtwb4lXfUwn9IncYA76HEgiYwL1MLlqTqV+MXU3lK8Qz5tLW89a2FEcNW1obTsV/z2yy7Ng6eBbN9a7KsVzzbB/glUveHAe9PnvpkiXEfdJ+P+LMGe5gVisNjC907Rqrq3zRl0jAlmZOmiP8VYtYMvscHDUc8aVbtkG77uk+AU7bJ/1HfvVQuAQ4nIkBEIdbV9pZOQr5tZ3lHszKePvcLpfsmsVkuLGS56ffRCNFObUaI4orkeDV6Ad7Ga/0surDUR0Xd8LS+W9g3IBhHTFYFxKV7ESeol6Ku5TvWM8nGQdjv044vxgLsGNkqsBVm2dDcaW1QsGwca7XLlunhm+Ic18s1zKOsL//niPG8BoJOgMbC8mhLyAHy6vM+ad4oiWkJp8k0dChF0xa1JBicWEpc8GHaBUg+oxCg8McqpJ8AiCelCeehfC/aZ/8R5zJGgo673vlgGKp+rJBSw6+q2l4Wln2VzaarBwb+WMl/vI2vNE7HpNsO4OoXhpTShyfzqJZooJoPR7q5UaO/P32aSsvr4hiG7rg75PIQ7JM1Ve3X+hf/LrlA2dReMdvxmJgac6jNrzIJMRp4Zk0wyJg1rXzkyeXpP6OxM1V2aR0fFSW7kZXsZ/qRp2fVzCO8njAXwEY1ie3Sh3NDYU2iZad/43JClQ4Ri+3zPoMfN4GNrv3/vJ9GHwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(6512007)(186003)(7416002)(6506007)(2616005)(86362001)(38100700002)(2906002)(44832011)(6862004)(82960400001)(6486002)(8936002)(66476007)(4744005)(26005)(5660300002)(41300700001)(8676002)(66556008)(66946007)(37006003)(478600001)(31696002)(316002)(4326008)(6636002)(36756003)(31686004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXVSZVJTV2NTblBTMllaS2hFWHBBSHMrQzNXZWlHbUtoV05JZFh3R3A1N0x1?=
 =?utf-8?B?MU42WDl1bnZncG5MMnN0eWF1Q0xTMGc3REFMRHJTTEdUTjRqNkVybHptaFNC?=
 =?utf-8?B?dXI0N1o5RStkcXpmTXR1T3BZa3BsUURHc1A0Y3hiQTF4ZlRDL0dqTmhtdHRS?=
 =?utf-8?B?d0h1YzRjbnRHUm1VQmpMRFJEdHRkZWlKRmFKb3ZHN1ZaNm45V0JRR0JheXBK?=
 =?utf-8?B?YnJVMGZmRDJMYnpzclNJeEYrWXJ5RGhiWDFVclJwamIwUWVCaXRWYkp0eVdk?=
 =?utf-8?B?S3B5bDBEZ0pVa0N0QjhlMU1mTmR2YnplSFlSdnphak44L3pUWHFGVkVydWV0?=
 =?utf-8?B?YStPQjJMTU1aNkVqOHdnZVI5aThaU3BYU3lLZklFZlZuYVFSNkg1WUlFQU9Y?=
 =?utf-8?B?TEkxdFQ5UTB3cmRPRXBOdkZXRVFhS2g1aXRrUG9pYnNrWThTKzU4VGVLbTBF?=
 =?utf-8?B?dnY2QnFmMUdjUzArWkRLNXF5MHpjdnNWVVUxTHRjdE5WNXdGbk4vbWZXMkJ4?=
 =?utf-8?B?YzAyRm5ycGpZb2JsTmFUemFxcUN4czR5ZWxVU0MyWGpWRHFXbnR1emc0dkdC?=
 =?utf-8?B?Qjd6amlBRWo4ODNsRkNGeE1sUXlXTFhMOXdLcHRKYS8yYWphU1hHQkpBbDk3?=
 =?utf-8?B?UVZpZ3pybFFuTEF6UHZiZWpKL0hNV2xFWXR3NWRFWVR3ek01c04wT0ROR1d1?=
 =?utf-8?B?UjFvUDBHR1Y5eDk3MS9EWEpVYmtBV1dpeC9Ycm1KMENrN2EzUnVUOVRGWFRV?=
 =?utf-8?B?eGhIUmV1bzZLZ2k2SVl0RGt2aUJNWmJBQ1FLYW5PTzI1NUJuZ3p4ZFoyZkx1?=
 =?utf-8?B?aDVYajFmRVN1a3cyWWV6eFI0VTh6YkN1WlV2Z2RsSlJhQTE2ekVobzNSYW9D?=
 =?utf-8?B?RjZKUzMxb0x5ZDNGeWNSd0hvbnZmYmFKMnpxbWY3eFA1U05vM3NreTBQWmJp?=
 =?utf-8?B?VnpsZnpYMmp2WjdpbU9RODhPSzE2U2p6ZDY1Z1d0RFl4dldCSFhVMEFZWnlp?=
 =?utf-8?B?WGgybzAzSVozbWVRZWZGOFdkT0V2d1ZoTG9xcndWang1MHhWYkhOci9aQzZ4?=
 =?utf-8?B?UjVWdnYyTm8rUGlKV3pacC9mYjZVdkcvZ1EycldGK3lUdW05ZTBNUHdNMFU0?=
 =?utf-8?B?MlhId05pcXY5WmtBWjNTRSswbU9GSDBsd0ZrMGNScEdxTkpZODRTbUNGZE5D?=
 =?utf-8?B?VXZkOXBHVjNEMzcrTzhGUStVaWNSYmxuRU5rV2VtL2JRR1RqR0F3cEhwejNP?=
 =?utf-8?B?ZnJwSFRPdVNFNUl4TitzN055S3hCMFZqUEI1WnRiSFBQS1BWalRYR3FMZUxB?=
 =?utf-8?B?ZkRwbldRbnF3RWdlZml1Y0p6N09yWjhzZHNmN1Vsb1pWUlNMQUM0NEpQSmNa?=
 =?utf-8?B?VWtjeDlZeHpCMTRPdWVVSktJQTNBSHlNaEhYcjQwdTJHaXhMZEZDYnRPT0FN?=
 =?utf-8?B?anJTSlBFSHRVMUdsUjh6eExXd0U2ZXRjSU1SeGwrQzJsTXdrdjhVZENjN3Rl?=
 =?utf-8?B?TjF4MDF3SHlWTTF6TVNTY0dNN0VxWTU1cWhsN2taRDZJUW9PUXVobTRMQUNw?=
 =?utf-8?B?UnNKRFRUTmFkekx2V2pyT0wrVm9pYk9RY2tGTktUbWxlZWpERTkxYksyS2tl?=
 =?utf-8?B?TXpYK1pFVkg5OVlreVc0WGNSdGF5TEhxZkxISWZPMElsTURZQ1NpTXR3RTRj?=
 =?utf-8?B?aFF2cFB1c2Ftd0FETitZeFY2Ny9sdlZRK3pBUnkxZFVjSU5GVGFXOHU2SG15?=
 =?utf-8?B?eTJzdGNsUTdUak91dTFvb1FhMlR0dXhwdFpSY29QSUFVQXVLZnozWlNsa3l5?=
 =?utf-8?B?NS9iQk85Mm1KcTNLai8xNlAyc25tc3c2K3BURHBGaUxlR3BXQ0pxc3JaR3hR?=
 =?utf-8?B?NzVONFVEOTA1ZEFGQ3FYakV4UUNxc0tVOEt2cWpsZmxRVG9OQlBSM05zVDhH?=
 =?utf-8?B?Y1BCOVo5UDBDcFNST2ZkazNDZVRrbzBoSlQwOVprOGx3T1FndWV2bFlJWTNQ?=
 =?utf-8?B?WnVuZVNXK21iRXJFS3Y4UFJyUDE0aXBrWGxHdGZINkN6S1MzTk05eklqTXZs?=
 =?utf-8?B?MVRTTWNLRCtlVkJ3QStTZHMvb1VVQ2xoWkhudkM1WStIT3V2NDl1bFF3Z3BG?=
 =?utf-8?Q?3oX+Ul0NuDhOeoXkth2MMmKz5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f721be-1e5d-43e7-e8de-08dabd71d9a1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 08:03:10.7661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkuly8ppbeXkvYsGq1T0FeqxTwGhVMnvpKv4TAdNY591nRzKRXRmHTxghIkPBVb53izuFO2JF9LYvXEPBdMODQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/2022 4:27 PM, Joseph, Jithu wrote:

> Each file would contain multiple tests. All these tests contained within a file would be executed when you write 1 to "runtest".
> Given this load_test too would be confusing (more appropriate than "load_test" would be "load_test_file" or "load_file" or "current_file")
> 

Yeah, not sure if any of them are more suitable in that case. Maybe you 
can leave it as is until someone suggests a better name or has a strong 
preference for one of the above.

(Probably you can add "load_batch" to mix as well.)

Sohil
