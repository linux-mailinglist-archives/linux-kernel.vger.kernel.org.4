Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B50360D4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiJYTfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiJYTfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:35:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE7E986B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666726531; x=1698262531;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k1Pq6UN9MNrYKZnFLCz29KsNKl3GPbGVvAm4Hzgze5M=;
  b=Y6nnBIGLvQTz9oXG9ABe93RGvNXFZvtSVVxooMARdxhfDCdSiLsQEith
   HdUTlTKjmzkDOkSYVbSeRsKddHcBcbvHEgdKfhUy9CGeDFDUFdDOuYh6P
   UcAoIKV50Ny3MzilQYyHHHU/LFxmG5MQ+11aSRQwpaC5kVpLKf2iz7LMH
   965PxJAO7R7qKOjCranrRSImWDYtl6Gb4OmxIbjFgOz1R89vnYqPqkD+s
   7W2HgIWXUHMc089HG/rwD9xfDddCdsRAMxyR6HiaQ9b01F5cYbh/BV5D1
   9LsOPkgl/p+VsNEhp/5vElteYqcIlkwRZoIz4KsvCUYuO/ZHYSoGLE4jh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="369840162"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="369840162"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 12:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="662924952"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="662924952"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 25 Oct 2022 12:34:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 12:34:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 12:34:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 12:34:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0JUZ5XPll57CPOD0mOfF2kcOtR/oQLE+t9grlcEoLk0Pk2wxleJGbO2+exbCfI2KCScEvXp2fj+CTxDlYaRfHkau/IwcuuzxxOIe4/NKJqsmQvQ5a8Gj7H14Z+9C7VZV5NNEa1f3/Bk4g8DDJTHVvJ5IvShoWavquaieWvFrIOtIjmSKhDzTbyuzIK0S0XrFcSdfD/YBJVd24+GnlRam5710PrxfNfQzs4KYYXxCfe1CDIJNLlv6Y4kJBrYw3kgPrvCYtN6CFYcHhmSWK58mSnCNB/6chwdrViXEXC2wLl38w6sxKs04450mDcf7Zr/nuuILycocTeqwsVu/8TVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yuhQFu4y5DZwA2Qit3t4Or89DrgtHaO1AsJCL46C6M=;
 b=iA/ZwOSSn+WTfns0HuKfWeeqF2nk4GPtF2yIAz/+xZg0SDGgM+N0GJPrvy2HpXYVmOvSUBFaeOv01KeFBnm7JJE/doqR427L9px4r9cZqV8IsNA0uBmEa/G+YPcTT7mp1gFvb7d4CUayMT1HQUyNvzUYLIqLnZtbooRLP+f7ZQMcAcf8ZlpCpRRqz1rNoCld/XgRfJQkKP20PDPYBPiSoGY7Ki1mM4oULD9SzgiUTelGFGYmQ7Vtvi3wGjIwCX/Gjr2yjeLYLhtEuP1R3a6Yjq91TRlvTiQNGE0dL6e75OpWxVtqO9LQXOGtp14tG+bA6YXOM8O2WCxFGI7h6tGXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB5917.namprd11.prod.outlook.com (2603:10b6:a03:42b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 19:34:30 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.028; Tue, 25 Oct
 2022 19:34:30 +0000
Message-ID: <de3d3e98-ef52-e290-f47c-717f531a0659@intel.com>
Date:   Tue, 25 Oct 2022 12:34:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v2] x86/resctrl: Clear the stale staged config after the
 configuration is completed
Content-Language: en-US
To:     Shawn Wang <shawnwang@linux.alibaba.com>, <fenghua.yu@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        James Morse <james.morse@arm.com>, <jamie@nuviainc.com>,
        <linux-kernel@vger.kernel.org>
References: <1665304608-120466-1-git-send-email-shawnwang@linux.alibaba.com>
 <7fa6ed4e-abae-85fb-4e95-8c73755a4263@intel.com>
 <ad08eee6-cfea-3858-0def-e2e3fef315fb@linux.alibaba.com>
 <ff44b0ff-6adb-3bae-d17e-4c341c09df5d@intel.com>
 <86fc22a2-e779-b7ab-67d6-a3aff975ae56@linux.alibaba.com>
 <30637459-7419-6497-6230-b13c73a947de@intel.com>
 <2cdfbe28-01cc-926d-2f6d-2a974a4c5a74@linux.alibaba.com>
 <bbc21b48-58b5-6356-0248-656e22d95281@intel.com>
 <140177ee-da8f-c6eb-caf6-af0775a3de0e@linux.alibaba.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <140177ee-da8f-c6eb-caf6-af0775a3de0e@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ0PR11MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 906117f3-19e2-4ee4-69cd-08dab6bfef91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Ouj/PrZU9Ja/yhTN0wCBb7aoLotM0D+eAWe1CtUhf7i3wXS5monf5HwdboBVIGuWtAua52UrLysO2OgDipiZiQaeyJcwoBxa04ywbPXYkgvO80/KTOv7s/LcNPCy4UdupJe9khdR09IwzRjbiHfMMrxEuTaxtZ3ObTYvzchn2r3G2LDLmCzp+4WJVQM1QaqwR9UOKEi8JctCwOnG7ves8FW7TmG04Y01qdpw2gKNHAmKI8maLx/KTvQQ3WJ3jeOQa/kfboNlOBB/Oe677Rb5Dl8oijb7p/rKGEUYQtmwUQcxangcs1h6YgIth/riOf/ODTu5kz4s4OW+OgZfXIc9CbkGclhXTJ96Ult3YyGoVQItmthXA83+PqTEhff+RBZI760wL51zwptDcofkuOHXv9sFTBXOhChv9zTsTAv0PxawgV9ra3nBTeWMZAPX7zDUqXcme+k+OZajTLpA817Djc4fpbWF2YGxj0X5U9PF6he5d8Vx4C8KO1rzlLvZZVVavXh96GzZKk+NI/0+V/k3yNH4sZ/cK9qUkHV/L24ZKSyjomJOksCsZOXkXIoM08heu/xJYt17DodjMya5+jUb2/IoTEEPbhCzvlpWFRGdnxN6ewOJ2OeUYrz4puHkC54Weoppv66/XTRMCKniWf1XvHqkb6QoIEFghmj7826mCdNTvodFVeG74mRJeMhIRNqSJx+nmDiIZ19SHDRmvUP3wbisOKHFPf+yQENTR9QsGGrtm3kQlGjTUo2zRrIsrmWnjhMCHY2fQsaRIwhRih06wottmuAT5zBDL1eaINYkso=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(8676002)(38100700002)(6666004)(6636002)(4326008)(41300700001)(8936002)(66556008)(66946007)(5660300002)(7416002)(2616005)(66476007)(44832011)(82960400001)(26005)(6512007)(53546011)(186003)(83380400001)(6506007)(6486002)(478600001)(86362001)(31696002)(316002)(36756003)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXRmUHVJaVY1VkpmRzdiTXJZQXROWlZlamczc1FNdTVrb2lMRCtaYkg3SDhN?=
 =?utf-8?B?SGhCZzBpWDdCYUNZcVdIc0J2SllCLythR1pIK3VjVnV0b25GWjZZTHg0NjRp?=
 =?utf-8?B?TEZEajdnN2R5UThtLzN3N2VlU1BWbGdHa2lJLzIzZVQweGFhbVNTRkQ4U1cw?=
 =?utf-8?B?cUFxMEJseEhXYy9VZmYzai9sY1FrTE1NckNrZUNnOCtYSGpjUG11LzB3M0Zx?=
 =?utf-8?B?SE1GZ1pvTjdId1RGNjJXSCtrdmdvcUhLcjJHa1duVmpyaHlZVXEyRmsrQTRK?=
 =?utf-8?B?czA5OCtsNVZKT1NTYk1QNGpUVmUrZmh1MjNiN1ZNb25vQlJzUTRkZHFISys0?=
 =?utf-8?B?TE11TmNOeEh3ZzZjSEFTTHF2NWNGcnh6OWFveG45SEVKOEhtRDg3eXJ1WnFH?=
 =?utf-8?B?bEt5YkNjRjlVQlh1NmNLTndMM1Y4Qmoxa25NVGFCVUNFMld5TlRUam9zM0Rs?=
 =?utf-8?B?ZHpzOWdWSVhIbnFKb3lqbU1kbjBCeUlveVVPazZyRExtQ2h3LzcwWDZYZGM4?=
 =?utf-8?B?cXFLOUpnVktwelllbFdpTXdlYWZwaG80aHZVVDhJdXlwZENaeWVGcGJlenlj?=
 =?utf-8?B?dVZSdk9iOWQzLzJwYm1mY0M5Kzl3aWhSQUFueTdQd0UyVTRMSlZuQ082VVNv?=
 =?utf-8?B?UVlJc21wMGoyTzRvTlVEVGcvbzVyVS9BMWFnS1BweTJLOXZYUEhKZnp4QUNa?=
 =?utf-8?B?cTFqNDFOSTl3RGFZaHh6UTlyZmEzN0EwcUFjbVpBTXlyVHgycXlPUVlHQUxa?=
 =?utf-8?B?T0NPSm92UkVQdkpYTUhzelBwN0F4OXQzeENMUDJkZDZubkkvT2RxOTc4YzhQ?=
 =?utf-8?B?V3loQXFDMzgxSDkwYmk5NVRPM1pOZTFOeG1YSzhaclZoUm9yekdxUmhSQjNp?=
 =?utf-8?B?WWh6b0U3V0xlYTNKdGlwNjJhMFJPRkpVNFowRHpxeHV5bkVPbEFJOWxDREsx?=
 =?utf-8?B?SVIwbEtDdldzU0lLQ0ptUmZuaTUzYUN0MXJrdVNLdUlGbnI3QUhWbWlQMUMx?=
 =?utf-8?B?TWJ1eW1NN1Y2ZzFPMm0vLzVSKzRIbGZtKzNNZTV4MXVpQ2U1K2dzeWk2TkJy?=
 =?utf-8?B?RHNIdzRvVzFaTmZ1VFNxWGV6aDdMNnhLSE5PcTVCVnd2dFVwSTF6TTcxL2d0?=
 =?utf-8?B?STYrdzF1NDVJeFo3MG5PU25xdXphTHBBc0hHRHB5eEVqdW0rSUZZREZwQUJI?=
 =?utf-8?B?dmNZV2xna0xhbDNXZHFvWUI2YWM3WHBLclo1OU9sQWRXL3JxUnBmWXJ5Sk0r?=
 =?utf-8?B?Y0NKeWxwdkVmSUU5VkM3RllzWmx1K1pzY3hVVk9aNm1TenRKQllPcmQrYlAz?=
 =?utf-8?B?TjhyZDlYS20xRGhDU2RJY3pGUVMva2JIajFRRFNIejFhQzlPZ3VpVnRPVWFK?=
 =?utf-8?B?dGVqYUt2WWtnSkFDeGN4T1VaZE5hQkQ2aE1yelA2U29UVi9lTndUelczRnJX?=
 =?utf-8?B?dlRUeXFsK0JzUjJ3Mm8wd1ZZM3ZiNmVIQ0p2Yk40SFJzcUd5ZXVDTmxiRFVz?=
 =?utf-8?B?TkNNNUpvUVp4YUR6U1F1TEVpZERnZmFxZzQrMFFib09sVk8xVndzNHZRY2ht?=
 =?utf-8?B?dHFPek9adXh4SlBtSkRsU0tOWXhnWlU5bFE5RUJQMGtrWm9pZVVncFl4bUcx?=
 =?utf-8?B?WVpaRVhVUnZrc3dDR1MvaE9GYlMxZHp0dHpWNm9MNXRrcXh2QzZXM1RTT3Nq?=
 =?utf-8?B?OG5tRzhSdTRoSkdOL1RkMzM3QjhCelFCdHV6clFNZ2VkQ0dQK1FDQlhnVHl4?=
 =?utf-8?B?VklBa0ZMSVpzWm41YWVpRDVXK1ZEbXoxNUlnZnE4NCtJK0ZyQmI3cnBIeUpT?=
 =?utf-8?B?MHhUOVFqUlBNbTdHdlBuR2t1d3o5L0t4UmlGbDR0bFM0L2xjUnZmTHZOaktG?=
 =?utf-8?B?RlNZbVZ1Zk5HcjZMWUZuTzd2SnIwYW5SNVlnTUpDMXhneUplaFRGbi9HQzNx?=
 =?utf-8?B?Ni9NUW51c29hcmowWjlEU1BKQkpjWTI3OTdmVms0ZllBQzBoTjVWdVFYUjVH?=
 =?utf-8?B?TituYTZxdGJaQjdjY2MzeDZEOWhVNUU2ekRETkFGNjBSNWR3SDY1MXYwZFQy?=
 =?utf-8?B?cERxMFd5VmhEYnBBYUVZWTV0cE5KTHRxYkxrWDNscU94ektNREZ5RVVUVm93?=
 =?utf-8?B?dFRZd2g5SGpIVWlEVCt0S2hqTElWYVRsV3VJamVoR2N3ell4YklFVWVsMUpl?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 906117f3-19e2-4ee4-69cd-08dab6bfef91
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 19:34:30.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74YWNfVTebO3Wtzdq3a7aACZRtSLts5jSkzmKvooNa+bl1SR1Ih/6G6eRWnTSgURSJ0rHRt0G1EGnZdlcnxa1K/WL9kECih4fkcGs5EV4zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5917
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 10/25/2022 8:30 AM, Shawn Wang wrote:
> Hi Reinette,
> 
> On 10/25/2022 12:45 AM, Reinette Chatre wrote:
>> Hi Shawn,
>>
>> On 10/23/2022 7:31 PM, Shawn Wang wrote:
>>> On 10/22/2022 2:05 AM, Reinette Chatre wrote:
>>>
>>> ...
>>>
>>>>> It may not be enough to just clear staged_config[] when
>>>>> resctrl_arch_update_domains() exits. I think the fix needs to make
>>>>> sure staged_config[] can be cleared where it is set.
>>>>>
>>>>> The modification of staged_config[] comes from two paths:
>>>>>
>>>>> Path 1:
>>>>> rdtgroup_schemata_write() {
>>>>>       ...
>>>>>       rdtgroup_parse_resource()     // set staged_config[]
>>>>>       ...
>>>>>       resctrl_arch_update_domains()     // clear staged_config[]
>>>>>       ...
>>>>> }
>>>>>
>>>>> Path 2:
>>>>> rdtgroup_init_alloc() {
>>>>>       ...
>>>>>       rdtgroup_init_mba()/rdtgroup_init_cat()    // set staged_config[]
>>>>>       ...
>>>>>       resctrl_arch_update_domains()        // clear staged_config[]
>>>>>       ...
>>>>> }
>>>>>
>>>>> If we clear staged_config[] in resctrl_arch_update_domains(), goto
>>>>> statement for error handling between setting staged_config[] and
>>>>> calling resctrl_arch_update_domains() will be ignored. This can still
>>>>> remain the stale staged_config[].
>>>> ah - indeed. Thank you for catching that.
>>>>
>>>>>
>>>>> I think maybe it is better to put the clearing work where
>>>>> rdtgroup_schemata_write() and rdtgroup_init_alloc() exit.
>>>>>
>>>>
>>>> It may be more robust to let rdtgroup_init_alloc() follow
>>>> how rdtgroup_schemata_write() already ensures that it is
>>>> working with a clean state by clearing staged_config[] before
>>>> placing its staged config within.
>>>>
>>>
>>> I want to make sure, do you mean just ignore the stale value and
>>> place the clearing work before staged_config[] is used? If so, maybe
>>> the only thing the fix should do is to add memset() to
>>> rdtgroup_init_alloc().>
>>
>> No, let us not leave stale data lying around.
>>
>> The idea is that the function calling resctrl_arch_update_domains() is
>> responsible for initializing staged_config[] correctly and completely.
>> To confirm, yes, the idea is to clear the staged_config[] in
>> rdtgroup_init_alloc() before resctrl_arch_update_domains() is called
>> to follow how it is currently done in rdtgroup_schemata_write().
>>
>> But, as you indicate, by itself this would leave stale data lying around.
>>
>> The solution that you suggested earlier, to put the clearing work where
>> rdtgroup_schemata_write() and rdtgroup_init_alloc() exit, is most logical.
>> That makes the code symmetrical in that staged_config[] is cleared
>> where it is initialized and no stale data is left lying around. What was
>> not clear to me is how this would look in the end. Were you planning to
>> keep the staged_config[] clearing within rdtgroup_schemata_write() but
>> not do so in rdtgroup_init_alloc()? rdtgroup_schemata_write() and
>> rdtgroup_init_alloc() has to follow the same pattern to reduce confusion.
>>
>> So, to be more robust, how about:
>>
>> /* Clear staged_config[] to make sure working from a clean slate */
>> resctrl_arch_update_domains()
>> /* Clear staged_config[] to not leave stale data lying around */
>>
> 
> Thank you for your explanation, and it makes sense to me. But this will
> require 4 memset() loops, how about putting the clearing work in
> a separate function in rdtgroup.c, like rdt_last_cmd_clear():

Yes, thanks for avoiding duplicating code.

> 
> void staged_configs_clear(void) {
>     struct resctrl_schema *s;
>     struct rdt_domain *dom;
> 
>     lockdep_assert_held(&rdtgroup_mutex);
> 
>     list_for_each_entry(s, &resctrl_schema_all, list) {
>         list_for_each_entry(dom, &s->res->domains, list)
>             memset(dom->staged_config, 0, sizeof(dom->staged_config));
>     }
> }
> 

I understand that you are just copying what is currently done in
rdtgroup_schemata_write() but for a separate function I think something
like below would be more efficient:


	for_each_alloc_capable_rdt_resource(r) {
		list_for_each_entry(dom, &r->domains, list)
			memset(dom->staged_config, 0, sizeof(dom->staged_config));
	}

This would be more efficient since it would not clean the same memory area
twice when CDP is enabled.

Reinette

