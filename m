Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2AB7179E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjEaIUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjEaIUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:20:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E903C5;
        Wed, 31 May 2023 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685521231; x=1717057231;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=26yvYqB2sL20HFu/Hf3dmTJPXsJo3ecrpBJKME3CpuA=;
  b=EKhD3YpNf2u07/tyo/FUQgD7jxYX06D1svQ8DLnDJihbUKtMkVnkg65z
   S+QtLHPVV6pPyEJh6qsE2HJXr/3Juq/SxXJMNGITu24x9RZxPyFH2HGv1
   YKa630ZxDdo1NxGv1iSJdb6uEWi1/NM8LqzLEdlwTC2kPhq5cgwFspVtA
   t5Pu/IHTVlqM8JfbZVgETpm+nuntG08EV4rgS8WbN2GHCKdloxgm4srRQ
   g93U+cDKZNWvfjO3pywCCBdJbXYDso+BqMKroWXnYDoOGf1BERB41jikm
   mUFwJwia9/NcKf10cu0mT7PCq/KJcczraeMoSz/Y2Ld6PNWkzoGrd0PsG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="334793588"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="334793588"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 01:20:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="881085971"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="881085971"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 31 May 2023 01:20:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 01:20:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 01:20:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 01:20:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTCqAsWyVSMq/IJgI5rHSA4Q732kCN4pW/CrxwfN1y9Weqbh3kwwvqYpBy9ZMHQklgFiVMRij1vawhbWQ5wqnSpmOwpUFYqd/LSg2QI8StpmuIjIznwhT1wiBcVKhuTkolBf6mOHmFa+hB+9nqdiSKnWNMMtcr+LMB53WOeC93u5as8j7hrs/fu9zzGjyjttu+Hfo35dMbJGHG5Hjg2obirRH17d52zmczTaQZ9a11madi4RaXlqMTKK9kFbWMGxFOqOAKe0l+uFuK3vvyxH4SQIby1CAsA28QSOQ0TA5mz/3lBNm/QJZ7TbjLQ0C6XV2pQHJ+rbWoQjHm1gy7ohPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26yvYqB2sL20HFu/Hf3dmTJPXsJo3ecrpBJKME3CpuA=;
 b=LxPy8DzRehluSYbd5P3HmFV3gHyeGwm/Tt48vnD1bZay+Ia2kVNZKMYZUA4UBQJ1X2IpP9MK9INC+kI6mxzI2x1k4XPuEt4uNwA2PCv7XV5GVmBtvojdrk63rVUAa2o/445hfqzGMc8YxUrQ9pDQU9DglDo97R/x7BJ6b3yPu6hPhSglGC17/OzxHD8PEDTfxh4JM+0EHe9Fa3O2osUFYtzIz0YS+jAkBxWM5KGcN4Jt7CyoNqP8lVFdygth2gJ+jbo655mbP7wGcL6CM3BmPerD/5CU/do93cF8VhuD+f6eGsqNzYd7g0yE6/sw6RGf4HYF7J8Y/Udvp3EostWOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SN7PR11MB7041.namprd11.prod.outlook.com (2603:10b6:806:298::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:20:15 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 08:20:15 +0000
Message-ID: <8a8dc05b-f173-bea8-a59a-137b95007be6@intel.com>
Date:   Wed, 31 May 2023 10:20:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 5/5] ACPI: thermal: Eliminate struct
 acpi_thermal_state_flags
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <5675481.DvuYhMxLoT@kreacher> <3737693.kQq0lBPeGt@kreacher>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <3737693.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SN7PR11MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f37e51-6fa2-4c23-9039-08db61afdca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAOSJ+4ExYyi0EGPfgDYPqYL2BuUGW/XPluD7BCdxCL/tnRaYQncK4HcvcMbO4uYVzpeXriBaJZ5fMtXzJfHVBwZAedlcPDLuaYDIcmSEv8x+Wr4IOXPuvJfNagNwvX1Bl7XeVYD0lpwEFuG/MPPFAJc8LyXK0k3/ZfvVhNiNifxg5+UuWonU999So37XAYQamM58NmMPa9jhuXOqiYO3XjB3YsDDY1udiJC5+RQ6sHEIZb6lKtq/FdqZ3g+kGHC37KZKEnZztTlFLckKMAEgIlb2h6Au1ls3cfPe+e62wR62JR7cn+xsI39YZu/jxl1zV2wpKVYfartftD+8L0PmgVfCY6lcVgT/y3IsofLANqcR3HrlWrxj75dZEc38SyChm7/fk9/qZ+OVSIMgsk2KIKQsqm2x6J1WmPeBSpcdVvlF7z+KSvbu9T23lPwCrDXk/DqaTTScDj+vOSd4DRedr0v0K9fvez5Yezz9VH7ZGozDttKy5hV47J864LZbgWI+4OVQ7S7WFIKDjxSjeh99N8tJ9PIBMnW3p5ygpjnOOj45Yn8SFtCnFBOUH8ERAJVpgoFWgTFH7CmT/NQVl2JTG35hNWTAfTdB4V4qIIA/kMJ29pBzfxoJoke+jLxJuZnjRgofGtbwk9TENfciwoxFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(38100700002)(478600001)(82960400001)(66946007)(66556008)(66476007)(4326008)(31686004)(54906003)(110136005)(83380400001)(316002)(41300700001)(6486002)(6666004)(2616005)(31696002)(86362001)(8936002)(5660300002)(8676002)(36756003)(2906002)(4744005)(6512007)(186003)(53546011)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTNRSERWWEpjanNSV3FSR3g4ZjhYUnhGcy9nZVpLbUZwMFozdHd2UHJyamRz?=
 =?utf-8?B?R0NYRG4rWE81bjJid0pmd25iTWtoSmZYWXZYdVBHWEU2VWRJZjNoRkZDOTR4?=
 =?utf-8?B?bjl3ck1CUXg5MXNqaEI2ZTl2M29pdEhwbGJYUDN5UjQ2UzNKS1lvZ1c5dkcx?=
 =?utf-8?B?bDFIdU1ZL0F4YTBBSEhtWkNBdnZQSmJuWU5PaTdYcGdjeEc0bTlWTUZxRkRv?=
 =?utf-8?B?bTZUQ3B0RDRlWEd4MEptc2RXWWhvZjgxOWZCWVFuSG11b29MZGJ3MVhnMisv?=
 =?utf-8?B?SHFUNWVqN2k4eHllandvMkdOTzVxekJib0l0c2VlK3JnYlNsNGl4c0ZZaWZl?=
 =?utf-8?B?ZnNJajB2QUdFellyakl1SUo5eldrUk5YRU9tSFZVblFaOEhxSlhJL251eTFk?=
 =?utf-8?B?ZEloN0dqUkU0eFNGek1mclNBamI3dC9kMU90U21yejNOR2xvZGpJdHlVdzZU?=
 =?utf-8?B?dVhlTVQvRjBQRUxiTkI3YXpIWFpMSDEwSWEwc3ZNTTR3SFZ0UzVjV1NPTHhT?=
 =?utf-8?B?TzV1R216Ykt4dkJDYkR2bUE5SEtFTEQ2QXJHbDBvVUdPVVNRZTRoVGduOWMy?=
 =?utf-8?B?N20zQkZrR2xYVlJCS1FYU09uc04zVFRhNWNvTkJCWmw3ejVXdmYwbHVxVEZL?=
 =?utf-8?B?UUxmSm5hL2JtNmQ3ZGlXTEJZNGE5emhmamdJc200cGtveXU4WWZRS1VtNzkz?=
 =?utf-8?B?S2VjcXVDUEl5ajR1MW93V0xHUWsveml6NDROam0wYzJBZG8rUERiejlnZHlE?=
 =?utf-8?B?dHpiVEpXaHhKQUJXcTVTdGowUlE5a0VEYkJxOXU1RklqZ3o0Nlg3ZENQeTdu?=
 =?utf-8?B?N290MVpWdUpBOENEZEhqTmpvRkk3L0MvU2RBUUpFeVBmMEJBWlF0R3g3R1Iy?=
 =?utf-8?B?SU02bmc5elZreWQ0YzlYdkt4bE9GTVdOUXBBVHN1K1ZGS3hranRQdW9zdGYw?=
 =?utf-8?B?V0FoOExYL3lTdHluK051cGRUZEhmNlRmQ2R6cTdiRlpIR3h3UVVzbHVLbTN2?=
 =?utf-8?B?MTQwSUVFU3BRajMrZUZNMUkwUWduQ0Mra3RQNmFtUWhhYU5rWmFralB1emZN?=
 =?utf-8?B?TWpBV3NrdEFEL1BwOHYrME1OVFNmdUE5U1JnRDB2TEtqSElDQnZvUTV3bXNX?=
 =?utf-8?B?U2Zkc0VlTkZPaDAyZEJVakd6WHFDb0ltOUZmU29DSHZnUVRPK0I2ZkFVY0lk?=
 =?utf-8?B?ekJwditGQ1J6dC9TSzA2b1lWNHkzYlJTSjhsbmx2VXZKMW5ma2NiL3BVT3lk?=
 =?utf-8?B?Tk4zYkdxbHNweENhMGYzZW1VQnJ1cWU3SGFrZCtaZEVRN1VNdkczVHdlNXNq?=
 =?utf-8?B?cTBOclpodHJWUXozVDYwbkpucUZYS0d6ZnNXSWo2d3ZNK09qTnYwdnRueXM2?=
 =?utf-8?B?NndFMWRLc1B2TkN2eDRjQ1FzQVdZUlBkNDEzM0JRWUNxOHBLMVZzdlpUVUly?=
 =?utf-8?B?UGFlckwxSzVZMVNMR0Fvd1dVUm1MVnZld1l4VkxBVFZzaEdNcmVqaFJFcGhR?=
 =?utf-8?B?WHkxazFlbW5Ia3E2ZDFuaktpK0Y3dmZtZjNsMkdadlA0bGExRjV2Lyt4VlQy?=
 =?utf-8?B?bkV6YzJLbDFlVGw4dzEvdlVoYThIVmNxZFFLMUxJL3M1VHNOQ3g4MG9QWUNo?=
 =?utf-8?B?LythUEx5UHo0K2wydUlKNnR6QjZLQmh6VThBWUhud1hBb0ZVdVc2NDVIRmdx?=
 =?utf-8?B?Y0F6MDFlODRmcUdaRHdIRW1PNEN3U0d4eDZrWVk0R1RFTlNVa0NTNHJ3ak1y?=
 =?utf-8?B?QmJzcWtkK3J5MU0vMklhUkY5aDZHSUJxZU9hVUVjWWhKc0RTamI5Y3c5dmZ4?=
 =?utf-8?B?UnRwVDk4WU40cGgzdHFTd01aU2xJVVR6aDdnZlRLU3N0aGRZSUs1RmNlOEth?=
 =?utf-8?B?K0I4NUZlTzZFOE56bWxGcHlyL0NpMTA5UDI1MHAzS2dVcUp3Y3psOHcwT3Rp?=
 =?utf-8?B?T2EzMWFIWFlkUHFDMURkZHlZeWp3SUJJSVB3SDh6Tkl2dlZwNmNmVkdURzJC?=
 =?utf-8?B?dVI0My8wVmV0QkJISDhsa0ZieDRBUnM2NTVBM0wrQ3BHVi9TdWhPZnJ1Wkk5?=
 =?utf-8?B?NVhia1MzRVhITXBWZW9wd2tQdHRKTVYxeHdxUUI5NCtGdUd0dXBvS1Zlb0U3?=
 =?utf-8?B?YlNneUVZYk5QWCtldXRtZmZxU08weEg1ZTZ2ZFRJWTVNRFlmdmR5b3dtMjhJ?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f37e51-6fa2-4c23-9039-08db61afdca4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:20:15.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKc5niuI0+FnYvvcLgzGN+3fYpXMETPZ2gpCL3oKV8Ykb9c7dFLzze0t8SWTVUma0+HirWcLEDy7r65S6tnqMSGniSZPMa7JMw7ZvsauofY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7041
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 5:45 PM, Rafael J. Wysocki wrote:
> |From: Rafael J. Wysocki <rafael.j.wysocki@intel.com> Notice that the enabled flag is only needed for active trip points, so drop struct acpi_thermal_state_flags, add a simple "bool valid" field to the definitions of all trip point structures instead of flags and add a "bool enabled" field to struct acpi_thermal_active. Adjust the code using the modified structures accordingly. No intentional functional impact. Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> --- drivers/acpi/thermal.c | 132 +++++++++++++++++++++++-------------------------- 1 file changed, 64 insertions(+), 68 deletions(-)|

Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>


> ||

