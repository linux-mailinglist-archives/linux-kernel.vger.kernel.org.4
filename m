Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F9670BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjAQWfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAQWfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:35:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B438F82D5F;
        Tue, 17 Jan 2023 14:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673993500; x=1705529500;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w/R/g1TaJqNepSX5Fji37KiOi1dP79NmUkb0Vy2ScEY=;
  b=naaqOUo4GT8GBbGEWYmYbhnqsuiNpcoWoHuulmOxbapmWUh0ALHrEuYp
   jT4fA37NyBS3tpQkRPiU2ZdAYmWGJReDojja/lia3HB6r/LiRrdj91GAF
   pITeMK/aeD1oeZNiaIbP1UbAU73/vF/xubEw2fuzwJF0NSHFgj2G5oyxI
   lIgUtM59BxEh4oooUgEhHZTlNKFDkvQudbgVQDXWUfqhuoPnj7KgtEcGR
   SB5hmC+uQYDW72+jtK92wfpbayyoTfvkHyaR0a5lzi8J+ztMh+QmMpzi4
   2IHvTNUy/yEa0DOJuadCXTlZSwmo2he92AHfpOIjW4GE2soda/XU/yG8g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="323522950"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="323522950"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 14:11:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="904815877"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="904815877"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2023 14:11:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 14:11:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 14:11:24 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 14:11:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYL1rWNZhXMs6qi6pKmzyYY00Q9myAKd3BMWrLF1Vs9t6iovAHQMgwPaJJXojQuLvhkMX4IVQH3tS7mD+hNfB/wzc7Q+XZ7UxLLuVy/ih7xKPkmqKakRn0JBK315gncLRD2lhChXyhZYvUsUoeJur4weuU/24ybnqp2K4YR7Rs6EbtgmOdIo0aRVQZ716YdN3peqrckbBB/KVgDQ8kS6yjFb4qrNJl+KfCTQzrJ7gnnqAQ0a3KuDlG+jnShhLxjv6Zv1b3UnQGRVELdhPPnYw1HQ4/YBeLaP0DuEmoiQ/aONOwss8ujrG+ITaplCOxhWcCI5b98VHEyk3uQbiWUhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bmu4Bnc5aoDgIuvW1YIwkwa0Zf1FCtxShfOHbVLDx74=;
 b=Xd6qhd9MBf9UWOezBHrrU+4vLScjUWh61ECo516I2duhNuPSi+wrvIvTs7x/ValL+34aMGQURFNUpmim0yo86bEpTe1g8QXab1ZKcvx6lhfeXxQYgdUBEjakt8XywT97FQpCOwR2TDK4EJj93y9bq5boCNps6qJ/5ISDCYbl3I+/1Omc8Ee5Br2PhNNeDYpLPLb/AY7J5kKugTPmCrxB0JFURl4QPgpp9tLjsuJPVNDGOFpPL6XbspNnnI1R6Omj6zEl2zfgIoc9JPpo6rcrkFHJ1UfWPNMMpEQFFiYxKagsH1onBVknUm7k5d/Fuhy/v9bPflFulxu9vKjKU9yyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 22:11:14 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 22:11:14 +0000
Message-ID: <90674139-f8f5-4089-90dd-0100e671a653@intel.com>
Date:   Tue, 17 Jan 2023 14:11:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v12 13/13] Documentation/x86: Update resctrl.rst for new
 features
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20230113152039.770054-1-babu.moger@amd.com>
 <20230113152039.770054-14-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230113152039.770054-14-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::16) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA1PR11MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 53597b8f-a42b-46f0-6a75-08daf8d7bf6b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/QBse6+97HZK/5KRULUx9cOzI/6lPXlqDCkEumyxn4YOtr4V/rbLgin102Cy/95TK8AaVcYcJVulw2loX8L6gA3k+6N5H1wdll2kmB7NMJSKIJZisoUOrG+G3o1TzZOTzD7kWga5Q/b4+AtmVxoLaFLSNz1s0RGKRwfETlbA4GiLgQC0SIC0RNB68yiermXZON05cG4CuG9bt/f5j2Unlh0CWUBG/uCXXo6skq4zlR/pqwo/7JALDQEPgsK7k3o+wf2WlnXy0i5436T/4iuNiKWhpcslxkWQZjLMTKiIIb9lZLSuoJlqsi3VlpWv4kgdAa7Gz/e0CAFOVvJW+9ilui6L+w7xjV9ex56GwNkqTjo1NVbwhUrMyXQjzb8lATIbfKQn7w53fxuJpV0XvKyLV7MxtZmVhcPpFHHz19Pr2JCcGxEzOuD8Hqz/W+5CElcQ/hvYVd51Gv0v9p+iOa7C12BVcR8onsdLTjrckUYY1nM+imAUkttUh/lr3Da//f4OrRtOfpRWsebrweNwGWOlGEcr87fXHvlysO7pgl/dojC/qDo/X09IEabXUgWeA/PjFZ+gnRiuOqOpFrFz1nlQCzVL1nUvlazcTyrU0+pB4RCTdopjBQP8kvAbf1XsYGVSDZXZky0kNzjgZYBoGEnH0Yn2GipJ2aXlx8MDWtCrSZ+/H6rwfi+nmA8Zrixvj1nVsKT78IoOT+Pg3PDiJM0K8AVqlwXDAz+MS4jNGDVHCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(86362001)(2906002)(82960400001)(38100700002)(31686004)(31696002)(36756003)(2616005)(316002)(7406005)(41300700001)(66556008)(44832011)(66476007)(4326008)(15650500001)(66946007)(8676002)(5660300002)(26005)(8936002)(6506007)(7416002)(83380400001)(186003)(53546011)(478600001)(6486002)(6666004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW01YkJtVUFlVWloV3hremRyeGVtZnpwYjM2L2FTUDFOQVFlNDU3Vmx2aFZi?=
 =?utf-8?B?Wjk4RVE2YXl6QWhEM2JycDU5MXFxR2twWHpvbmdKVVAvUnFSRDAwalZwMGR1?=
 =?utf-8?B?RFFRQitPYUd1dVFtejZXbEpzU21LZTE2YjEwL243alBrVnpmKy85U1FrZG40?=
 =?utf-8?B?MXBFa2VvcWo3dlJHYmllQmErQ0Robk9UK1UwRk4rT1FiU1laa1ZjTHhYK3Ay?=
 =?utf-8?B?TU1wY2kzZHNNVndoNG11Nll4V3ViemJkbzJWekx6eXpod2RrQ1hlOHE0QkFi?=
 =?utf-8?B?NE8zeGZjWm96V09TYmxmc2d2SGxZcVJLYUd6SCtCUHZ5NVF3YkVzL2lGY2pu?=
 =?utf-8?B?MzBEQnN1cW1weUoxREttak9OZGtwZEQ0WFAxYnZHbDBaWWdTcVQxekNleXZN?=
 =?utf-8?B?THVQMGVaaEo4MDhEbnhJRnlXdDI0QmRnQ2NzMmtkR1BzWUZ1b05zWHlSQjAv?=
 =?utf-8?B?bnJCWGtpd1VsMkR6YklJZGNDWExKSnpxTDBBei95S1QrcS9JV3g2OU41Ujdy?=
 =?utf-8?B?SFN5Y09UTy85MGhGNWJqWDVPSFB4RVRVRmErdUhjWDFPRk9KaFIzZE80UG92?=
 =?utf-8?B?U3N0YkVTL3dXeFFESDZFb2J0VzgrVDJ0b0p2UXdFYmkycndsWGhvT1NyK3ox?=
 =?utf-8?B?bFlVd2U2cUtkVy9yVXM2bWlYdGxWbHgzOFVnY0Z2M1N5akd6c2NKK2NuZXpJ?=
 =?utf-8?B?eDRPeXVtMnQrZnNyMXE5OXB5RTFNMjg1eGQ4RXlkOHRwOUdmYXcyaFAyYzJH?=
 =?utf-8?B?Rm9NZVovOG9aOGk1K1Q1Z2lDckVTYlkwYkxNL3lqTEVoT05CSldKMnRkT1lS?=
 =?utf-8?B?L1NIRUIwWTlLaVdwZmpSMklNbTNXdDVSOXVPL2FCUkJ2MmVoaUV2aXU3b0JW?=
 =?utf-8?B?bVc5SWlBZi84blNNR3BtR2hkejQ5bFlOd2JWeEs0V3J5OUYrZUxuUDdMSHZU?=
 =?utf-8?B?RUlrbW80aHdwWE10cGxUVDE2Z0FieGdIRENRRmJ3RzJKcWhyVUZ0dWVhVGto?=
 =?utf-8?B?TStOS3NtZnFMejh4OGZGRmNLVU5taE9qd1NHS2ZlUkRuZ3hmUUJoUjBQU2d0?=
 =?utf-8?B?VS9GTU1mV2l4YmdTSDk2K3BydUZ3YVZCQVg5T1VYdUUyR05wR1JNS3JaZHE5?=
 =?utf-8?B?ZG5xWlBjeDlPQU9GRVhrSk54R254UGIvak1YSjd4N29QYlJ0Ujd3RzkxS3dl?=
 =?utf-8?B?RWRFZDFDRjMxUlRmM1dRODE3T2RNbWpMSmJZVktUQkw1RE5QTEs4eE1mOVky?=
 =?utf-8?B?NlRFdmFybVpxWUNlV2IydGxrcHYvTEs2SnNhOXovNVVOWTM5Y3hSMG5MTFNX?=
 =?utf-8?B?ZTlTS2VLd0xYQWd3YUk1Q243VzdvRTdjQUZ5UFAyWU5CQWxtWHR3MDZ2TnhW?=
 =?utf-8?B?MEp5MlBFZE5iL3NWZnNLYVFDVjVQVUVaMldHTDIxaGVCVEJZSWNHMnQrbFVX?=
 =?utf-8?B?WnAyRWtrQllnUjhOcDBWWDVDRGxrVjJ1cHRzanpKc2tFTWpvek12RU91ZDc5?=
 =?utf-8?B?Z1J0WnIwUXFYeXBNNjBNd043L0NJK0FSaU5ZUmlUZk9EdkNNZ013aWRDRDVX?=
 =?utf-8?B?blNqbzhEWWVEYWcvcFp2YkVPeXNkM2x3aEQ5M2hYRWwvYUZuU2NrWUpDUXJL?=
 =?utf-8?B?Qkkvejl0TVV2TmJHU3daSzBpZ2RpWHdaNW1uZlJTU3ZQRW5saEZPVHRtdW5x?=
 =?utf-8?B?aDZER1hQMmJwcnNnWU5aeUsrZmVQejRJYm51SGgvaG15VTUybnc1TDk4TUJs?=
 =?utf-8?B?QjFwQVVWRUdhMStpKzJueUttZ3JGbXdLMFhnby9yeVR6UUs1bkRQKy9oWlFE?=
 =?utf-8?B?cHpGMXYxL3gwNXpadVltbzEvdlhnZEs3RTM4NkJDYU51aDA1UDlWN2JKQTdS?=
 =?utf-8?B?aUlPOTFvaGg2YTNiYjFvSnZmQ3B2T2pCSU1QS1RlcmpVZzhmWmhqQ1o5Qno0?=
 =?utf-8?B?NGRBbzh4L0Mwdmx5eFNqQWRVMjg2R3NHVmo3WlkwTDJPNnNsNlVtdlNJNHl2?=
 =?utf-8?B?Q3l1QnBYakNHN2h4clNoTWVGSEdQOGVYeWhYRXhUd2Q3Qzh5dGZDZklWNDhX?=
 =?utf-8?B?c05ham5TcERHbTZSVHVXMXpsc2pVRWNCYjByRVJSV0dPZjczOEdiZkpWaEdm?=
 =?utf-8?B?c2szcEVDK3dUd1RzWXhzUVZBV0pXU1VhTlRBeGJQbGdxOWw5cG9pYStubDNR?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53597b8f-a42b-46f0-6a75-08daf8d7bf6b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 22:11:14.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chy8dF8Dg6dEFFqNl0DT6vpjndKpchZ5chZuZ0hbxYHd1Tcu6052LOLWtm0++mLKUkidEqXJokUFb+xogiAMt8k7WBF4BYtNhjvvHp9QYRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 1/13/2023 7:20 AM, Babu Moger wrote:
> Update the documentation for the new features:
> 1. Slow Memory Bandwidth allocation (SMBA).
>    With this feature, the QOS  enforcement policies can be applied
>    to the external slow memory connected to the host. QOS enforcement
>    is accomplished by assigning a Class Of Service (COS) to a processor
>    and specifying allocations or limits for that COS for each resource
>    to be allocated.
> 
> 2. Bandwidth Monitoring Event Configuration (BMEC).
>    The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>    are set to count all the total and local reads/writes respectively.
>    With the introduction of slow memory, the two counters are not
>    enough to count all the different types of memory events. With the
>    feature BMEC, the users have the option to configure mbm_total_bytes
>    and mbm_local_bytes to count the specific type of events.
> 
> Also add configuration instructions with examples.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
