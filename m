Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3E164E0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiLOSdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLOSbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:31:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B397211150;
        Thu, 15 Dec 2022 10:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671129050; x=1702665050;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YNvCOExFlsip5+ialnPbI00Af2vBmhjuknMTmatuPvE=;
  b=Gvpk9J5IUW5n9rQv3kqQZwHiV8JYHsw8/wol+fe+Keov1kQL4ScfHSTV
   iyZVSiCYY/QM6GHGYLzuBLa2Xn0nJDcpNuswYmlK+2x/6FoTJdpOxxvYu
   98LqQ5B238goyZwJOHE8mjZg6PZxfIKwIGiOVHkkQU/doH5Plpy/Q0zLp
   T7jZ1tAsA98FkQYAuP7hxx0dPXe4JfrdoHSOUD8jtWDUKF/uOtmyCSD+m
   kkpVSsNyh99dUt8PiTq440zuIvTYOfMDA5zSs6o+oFehOWKwz5cW0/Yg9
   DUXOl/2twyerNIA6BkSRZmQoK1ez7vkWGgaSuuC+aiIu89cGWdXwN1yhy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="299109131"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="299109131"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:30:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="642998300"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="642998300"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2022 10:30:44 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 10:30:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 10:30:43 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 10:30:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cudo9sIo8G2YytNKyc+5ZCvtItM1pPzLVHd7wrocmRiKpItaGWsv4GZ4zdgnFNkTteU5d8dMcyHBCK8x0CwKEQ6l0YonInoCNNTd5pF2Jm/XTV7IQEXpkw5/oInaympynIlTmL7IaCyokonLcc3piWIVJUajFCATJVtInYzRABtgNJ/HEO9n6EZ96SHlb9wpd8ZEyj2Hl97IYinpaGOE/zcg+19w1ISq/ffyJoLeZ3IkDxrLkhRL9EngjBvgoOfssKPvoPWfR0Pee1H6+/krEQ/aPjRxLA2grq96J2NvUG8s90CwgbiCEm+O3oiwzXeO6FNwf1XgqXPV4mi04mECAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8TJPCgJJWjHgiK3/cu7XYr8WRTcN5UgP2FTazO/nQ8=;
 b=d5dflZi9wM4LnCu8xDLpGlBWqZcI3i7ZqGvIeCS9RyCHWfJgrZ2YOGcOhF+BPWWv5suDNd9FbShoRTz6svlSdD4yZiyvrIynqaapM93m9z7j79Z9zSwX0rDyNsxGADPvfgO46KclNX1AydmC06q2zuB5FTvidlVHhUFJ52NKPB/NNBST+Pgy/OZQJeJ+U+sMoQ7d2AJEjU126opmbRsgJ2HnvYcigmd8WMvzq8jzO1GfQWiiFxM+/j5PoIsNC51AQTjQ0wopRWwwOLRHPrpMEx7dmaFmbS4y4KLgvMm1WTIzTDaqalSvgL/bx6SXes6mU/KkduVlW2AVdxSdkHbbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 18:30:37 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 18:30:37 +0000
Message-ID: <14aca9af-e649-19a7-1be5-2389d6f8348b@intel.com>
Date:   Thu, 15 Dec 2022 10:30:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 13/13] Documentation/x86: Update resctrl.rst for new
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
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990905693.17806.6942517971262471285.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990905693.17806.6942517971262471285.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::19) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CO1PR11MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f97d47-f2f1-4aad-2809-08dadeca7616
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3tQjyMJkLCTC+yuu6F5zdN/NP3Tcuqo/JrotkBwi8DIltim9GRPJsHCF2xNArMPlMvSmsh9KJMcgk2R2j6bHP87uZa4U4cJTOOK4tfLZrl/PdFWVWleg9gbKW4OJZgohbrRCkOAbEU7D4R8j9VUDgYFLnnrtTMcpBHyhjdsPx8E253G16rCw1sEPf28zAn9AUzHJOHXS9TcMxx9Um4LC7oeveyU8vMf1BWSwcW++p1LGLn/n1IBNMFloTABmXbMvnGW8zehDh6ql2z0A5ny+vjSbPvrThHoxdS/TcVOWiJtG/jy/5uiw9MKHoMzCnO4twxG1MYHesxkslHZLnX3iVj3oKD4XyGEX5Ed95QKZ8GiJ1GkhGjbBqyPu+YuspqJMxlit8IquaPpPSa7f05azYYZbxUi8B313AnuVbdvMDmVAxk9qYYMTumINmm+5nSIRtZiT2kr7bUJ+KFJJzkOz7827UR2hFf96xy4E5ZnYvRFuF2u4C8mJQEzXrx7EiNMvyJUfL4m38Tb6vlHGl2xRcgT+bEdoMuLPYKUDgfdeRs2kxkt0c8trwIAqnh6rRBYKWkQNJNqUc9x/DSoIrMax/uk1knub0h8okETNkZcIA1Xnrqv62NxjUwg3eH698oBpHqkhGc6MPqNkmhOc14eYtU4VUBg2FjwiK2U9D9UX9F6Kgjn3F2xLziEPKCovbcUP+k2PUfUK2m9s1IGjx0jon6b26g1/iLyyiCEW5sDDII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(83380400001)(86362001)(31696002)(82960400001)(44832011)(15650500001)(2906002)(5660300002)(8936002)(7406005)(41300700001)(7416002)(4326008)(6506007)(6666004)(186003)(26005)(2616005)(6512007)(316002)(66476007)(66946007)(66556008)(8676002)(53546011)(31686004)(478600001)(6486002)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDJ4VGR4SVFBdVFpbi9LeXozM1hrZnNEVUloRnFEbW1Kc3Vva1ZGUjZ1b0p1?=
 =?utf-8?B?azE3bzBGa28xMEtpYjNDMllRSHl4OFpXT2ozdWlxL0FBK3hGczZUOGRIRDIw?=
 =?utf-8?B?K015d2RrUStiYVJLbW92WEoyWWU2SDN2RjBqdDJkc2NNUG5iNE8yQjB1d2ho?=
 =?utf-8?B?VTlsUzhWbkFtRGduc1BXanlJb0EvR2MrRE1wT25qWkVqM3VBUFZQb3dCTytN?=
 =?utf-8?B?WW9sRHRZTnA5Zk1VNlBENCt1QnkybmFRTUk3UE1GU0pGYUg5MGdCalptMWRs?=
 =?utf-8?B?c2JLZzVja2FLMWhzM05oQXhjSjVLenN4dXZSNmVBVGh5ZXlDWXUxRHZuUlp6?=
 =?utf-8?B?ZG5FaTVRSHoxcElmaUFEMmVIUGJRYVFkVEJmeDlYRVpXQ2tLUkFrWFFZZE1O?=
 =?utf-8?B?eXFBMVc1akhhQ09MNWh4dEtHek9BcUxGbWhoMk9ldjlJN1Y1VHFSVGtxN3ZB?=
 =?utf-8?B?NFFzYVgzeElja004Mi9kRzBHNmdOTVFucTM5ajZwbnlMNlNGckJwNmNuRVhw?=
 =?utf-8?B?dys4cEt3OE5uTC9XbHg3SVA0c1V2QkFZaWpwQXEyWmdNL1B1bFIxZ0JrOWE0?=
 =?utf-8?B?RmkyQ2J5amhJNlAyeUQ2Q2l6QWJnV3hsaU9yZjF1dnE0aFhOZ1RHL0FESjFn?=
 =?utf-8?B?aTRTUUp4RVJzajU0Y3h1NjdPYndSTVVoc0FQNlZ3TkxCMWtneDRMZGRmRUlj?=
 =?utf-8?B?akk2UmlpYkl6V0w1MHZlRm11UW81N3M0WVJmd1VtMDNRd3V0VWRVSDNVR2pt?=
 =?utf-8?B?dW9Qa255NDdibnZlZkd6NGp1cmlHcWJWN1cxblJ6T28rMUtWaGtOajFTK3Jw?=
 =?utf-8?B?QWhzeEptMFZoWG9PM0ZOVHNDVHAvUjFCMHN4cDJhdUc2MDdJbmc0QVF0WkJQ?=
 =?utf-8?B?SXRRQURLbzg3SU9MMjVCcWJRNTVNT3FwYVB4dVduemM0Z1phakhHd2djV093?=
 =?utf-8?B?UXFjT0N6NncweXJ0QjBSa1ZTL2tEZks5SmtCVm5FREFjNkN4cXlTcUVQZ3NF?=
 =?utf-8?B?UTJtMFNrbndpRVJRMmtZM1htWko5cG5EZit2dnk4aENNQ0U5T1dVTTBrb2Y2?=
 =?utf-8?B?N3JURXNkR2RWbDZhQ1ZLQ0FzcU1MRDUvcDF6andoOFhGUHlyNzVPcWVwTjNM?=
 =?utf-8?B?Q3RFMUlaNWVPNjQ5aGtrQ1Bldkp6Z0lSK2gwbHh2MWF6K0tEQ2E5Vmc5TmxC?=
 =?utf-8?B?SUlNUnYweGRsTTRpWmhsMm9KUXVlWkdsNVg1aGYzU3NMb3dheWYwNlNiYzZZ?=
 =?utf-8?B?MjdlL2xkdDdHNko0V3l0UzRubjVVU0ovY0RCbTVJdVJCYVdvRC9NL2JFOU5J?=
 =?utf-8?B?RktwcGdnalJvcFNmRUt3RVJIWTVteEdDSjUzTVB1TjhxWGVwa212eWxKc0Fh?=
 =?utf-8?B?MGJHaHpNU1psa0hlSEJrMHROaUFBMkdoWjIvSEw2ckhBMEp1MWM2OVNsNHhI?=
 =?utf-8?B?Vm02WjJSU2o4ek5aVE9KRVBkSkt6aHB0WUxPZmp3MXBrd2RycEJGSU1qYVcz?=
 =?utf-8?B?cXNnREpZcUNjcjNyTzRFS25YZXRrd0JQUGlLQXA5UFoxWTNLcUlYMDZqNW1Y?=
 =?utf-8?B?MkhNNG9GbEs5aE5ZdStlbU5mYXdjeEJXeEVzYWpHc3BXd0xSa3ZwVjVWU1dz?=
 =?utf-8?B?cGZtTjlLazVrd0wxbVVxMS9CczkwS3lnRHdwQ2s4anh5amJ0dWpUVlhnTzVy?=
 =?utf-8?B?U2REek5kK0lEeWdtdnBXbi9RYlZZaFNPV25tWlFqU0VYeEZscHN6NHp3TTFo?=
 =?utf-8?B?YVdoaDhERW93bjAraXFrbkc4MDFxRk4zUnR6Mm9UeVFqa1o3clB3WmE4dWEw?=
 =?utf-8?B?TVo5UGsxR3l2RS91SGdNMG9ieGZYaGhjcFBEVGt3UFZMejY3UGJhTHNDckRZ?=
 =?utf-8?B?aWhUWUE4emNLVGRkRDZLL1NnbWQvUGlTZ213SEdqK0EzY3RPUmpETGpMSjBX?=
 =?utf-8?B?ZHNObDRQb25yckNVWklRd1k5cXBFZDhEdEw1aERpaFFkejlBVUFEdElncTVY?=
 =?utf-8?B?ZG1rMEc4UHpITzFOalRMTTdxWExEZGdMMVBjVkxUOVFUc3o5eUE0QVc5ckpz?=
 =?utf-8?B?cFFTUlc2d3dySFFPNXdhUnUvSmNXUUwzS0NzdUltMnV4SGJiaEtJQ2VSWjlR?=
 =?utf-8?B?VFVMRW5LOWh3ODJPMWR0YVhsaHlOOUlvQzNnRC9TTVlINnVpL3EyQjdRdXc3?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f97d47-f2f1-4aad-2809-08dadeca7616
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 18:30:37.4301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQ4bF85JRM6I01upuYPBMao3ODFoRfgroY/LeUlIB+uddg0Hp+atI45VsgyNJ1Eqi+b1saHlOhR5a+Fegjk3XPNeYIMkSdB8ZoU/ksv+nCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4849
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

Hi Babu,

On 12/1/2022 7:37 AM, Babu Moger wrote:
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
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/x86/resctrl.rst |  138 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 136 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 71a531061e4e..60761a6f9087 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
>  This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
>  flag bits:
>  
> -=============================================	================================
> +===============================================	================================
>  RDT (Resource Director Technology) Allocation	"rdt_a"
>  CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
>  CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
>  CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
>  MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
>  MBA (Memory Bandwidth Allocation)		"mba"
> -=============================================	================================
> +SMBA (Slow Memory Bandwidth Allocation)         "smba"
> +BMEC (Bandwidth Monitoring Event Configuration) "bmec"
> +===============================================	================================
>  
>  To use the feature mount the file system::
>  
> @@ -161,6 +163,79 @@ with the following files:
>  "mon_features":
>  		Lists the monitoring events if
>  		monitoring is enabled for the resource.
> +                Example::
> +
> +                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
> +                   llc_occupancy
> +                   mbm_total_bytes
> +                   mbm_local_bytes
> +
> +                If the system supports Bandwidth Monitoring Event
> +                Configuration (BMEC), then the bandwidth events will
> +                be configurable. The output will be::
> +
> +                   # cat /sys/fs/resctrl/info/L3_MON/mon_features
> +                   llc_occupancy
> +                   mbm_total_bytes
> +                   mbm_total_bytes_config
> +                   mbm_local_bytes
> +                   mbm_local_bytes_config
> +
> +"mbm_total_bytes_config", "mbm_local_bytes_config":
> +        These files contain the current event configuration for the events

"These files" is redundant. Note that this is already introduced with "the
following files:".
To match similar files it could read:
"Read/write files containing the configuration for the mbm_total_bytes and
mbm_local_bytes events, respectively, ..."

> +        mbm_total_bytes and mbm_local_bytes, respectively, when the
> +        Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
> +        The event configuration settings are domain specific and will affect

"will" can be dropped?

> +        all the CPUs in the domain.
> +
> +        Following are the types of events supported:
> +
> +        ====    ========================================================
> +        Bits    Description
> +        ====    ========================================================
> +        6       Dirty Victims from the QOS domain to all types of memory
> +        5       Reads to slow memory in the non-local NUMA domain
> +        4       Reads to slow memory in the local NUMA domain
> +        3       Non-temporal writes to non-local NUMA domain
> +        2       Non-temporal writes to local NUMA domain
> +        1       Reads to memory in the non-local NUMA domain
> +        0       Reads to memory in the local NUMA domain
> +        ====    ========================================================
> +
> +        By default, the mbm_total_bytes configuration is set to 0x7f to count
> +        all the event types and the mbm_local_bytes configuration is set to
> +        0x15 to count all the local memory events.
> +
> +        Examples:
> +
> +        * To view the current configuration::
> +          ::
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> +            0=0x7f;1=0x7f;2=0x7f;3=0x7f
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
> +            0=0x15;1=0x15;3=0x15;4=0x15
> +
> +        * To change the mbm_total_bytes to count only reads on domain 0,
> +          the bits 0, 1, 4 and 5 needs to be set, which is 110011b in binary
> +          (in hexadecimal 0x33):
> +          ::
> +
> +            # echo  "0=0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> +            0=0x33;1=0x7f;2=0x7f;3=0x7f
> +
> +        * To change the mbm_local_bytes to count all the slow memory reads on
> +          domain 0 and 1, the bits 4 and 5 needs to be set, which is 110000b
> +          in binary (in hexadecimal 0x30):
> +          ::
> +
> +            # echo  "0=0x30;1=0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
> +            0=0x30;1=0x30;3=0x15;4=0x15
>  
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
> @@ -464,6 +539,25 @@ Memory bandwidth domain is L3 cache.
>  
>  	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
>  
> +Slow Memory Bandwidth Allocation (SMBA)
> +---------------------------------------
> +AMD hardware supports Slow Memory Bandwidth Allocation (SMBA).
> +CXL.memory is the only supported "slow" memory device. With the
> +support of SMBA, the hardware enables bandwidth allocation on
> +the slow memory devices. If there are multiple such devices in
> +the system, the throttling logic groups all the slow sources
> +together and applies the limit on them as a whole.
> +
> +The presence of SMBA (with CXL.memory) is independent of slow memory
> +devices presence. If there are no such devices on the system, then
> +configuring SMBA will have no impact on the performance of the system.
> +
> +The bandwidth domain for slow memory is L3 cache. Its schemata file
> +is formatted as:
> +::
> +
> +	SMBA:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
> +
>  Reading/writing the schemata file
>  ---------------------------------
>  Reading the schemata file will show the state of all resources
> @@ -479,6 +573,46 @@ which you wish to change.  E.g.
>    L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
>    L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
>  
> +Reading/writing the schemata file (on AMD systems)
> +--------------------------------------------------
> +Reading the schemata file will show the current bandwidth limit on all
> +domains. The allocated resources are in multiples of one eighth GB/s.
> +When writing to the file, you need to specify what cache id you wish to
> +configure the bandwidth limit.
> +
> +For example, to allocate 2GB/s limit on the first cache id:
> +
> +::
> +
> +  # cat schemata
> +    MB:0=2048;1=2048;2=2048;3=2048
> +    L3:0=ffff;1=ffff;2=ffff;3=ffff
> +
> +  # echo "MB:1=16" > schemata
> +  # cat schemata
> +    MB:0=2048;1=  16;2=2048;3=2048
> +    L3:0=ffff;1=ffff;2=ffff;3=ffff
> +
> +Reading/writing the schemata file (on AMD systems) with SMBA feature
> +--------------------------------------------------------------------
> +Reading and writing the schemata file is the same as without SMBA in
> +above section.
> +
> +For example, to allocate 8GB/s limit on the first cache id:
> +
> +::
> +
> +  # cat schemata
> +    SMBA:0=2048;1=2048;2=2048;3=2048
> +      MB:0=2048;1=2048;2=2048;3=2048
> +      L3:0=ffff;1=ffff;2=ffff;3=ffff
> +
> +  # echo "SMBA:1=64" > schemata
> +  # cat schemata
> +    SMBA:0=2048;1=  64;2=2048;3=2048
> +      MB:0=2048;1=2048;2=2048;3=2048
> +      L3:0=ffff;1=ffff;2=ffff;3=ffff
> +
>  Cache Pseudo-Locking
>  ====================
>  CAT enables a user to specify the amount of cache space that an
> 
> 

Based on earlier comments I am awaiting information to understand if some
more detail/example is needed to describe to the user what can be expected
after a counter configuration is made.

Reinette
