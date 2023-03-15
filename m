Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF876BBC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjCOSpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjCOSo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:44:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B25C118;
        Wed, 15 Mar 2023 11:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905865; x=1710441865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WLI+eBHV6lUFS3nLbz1hKRoiOSDFzgDaiNLTPrUPDXM=;
  b=iNN+Tqzg6b7uxGSyFcLZQQvU48oiHgyoNuQojNfj4HNfV3+IJgHG7CnU
   pD3IeAgqeJCPFDViePWI5Euz3g+DoPD6mL1kHGL6C4xA5Q64u8ND6OSbC
   7mOHPGnia6UeZlpANCKeigtxRSvubrPUrvNYGFKvgpFAnZQBEKN3RnPAd
   D/LAW66F7VHy1Img7ok9k67lvwZ0kGQNM8OszWgQaNi3gvlHB3yUWJbNx
   I7Q9QnIsTn4saEc0txMTvrhSXcXb5qyfrkbYaL3Y8G7wgjT5NkxJdKceU
   Vy9xc4iGVMUK5XnNVQ/rin2c6Tr/EKTHATHbVLRCwONMDrbanXyIW7Z53
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="337813321"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="337813321"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="629563690"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="629563690"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2023 11:43:34 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:43:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 11:43:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 11:43:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRkywNjB2lKWsxbfgio/m7Tr998uKmeDQQN19DelBcPV8W9HG6jWKCdXJfdNdGvNg6v0isQGTv7XUpU491e2up5vJcv7Lz7t1jLBf6+0wMsy8p4XvHcW0Fcn3x7N+ub3gOekaF5Bxy9vtpZNqLnMW/Nr2dHSDc69R2cVVatxdRYq1f9LXaF7c4pkdPkrm2T6yzfxmB8ZcZJo7zrYhOKVyBVTIeoZbWlTC9p666oskQGs5sen92qk30u+05JQC3a9yFIEHE7ycPSAAu2wn9vJDNdQqn4eSFE5uKrroZl6W7I4IqmdFKGuMXegIMMFN9eOPhzKBNiKl8woKjn1J4uj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CkNle/NL9PbIPsM8x+/EgtTgLogqjjMklVvgcIHufY=;
 b=XePwxew5/HwstiyJEu+bzNXNRdroaRt5qO21DGpW/TLv6H5gMJpSzrBoMOgkq7S31mj6b4Jw1gNbBgyshQoHIK5Yi9aFVnLNCHOHCpw0XAT5ocmLeMBoegASCC6q9jwfU8voPKWkAbYs2fyBKT622ysKp1k4X/1cz5QKY5sB1imWaYh1PYWqvCin+uj6D2s6RN26O3woKqjn5pf1GJpsr8knJThGgSzPjVfXOs0OxB85JdTlSvR4y3f/vXaoqEXLGbjNsyMJMDFwv1jiVteyxrTQi2k1zSOT/lva0FXcz8Zxe6jw+fPQUQsX4hIpM89r6BEPNp2ST5yVX+2ENqMOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ1PR11MB6250.namprd11.prod.outlook.com (2603:10b6:a03:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 18:43:30 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Wed, 15 Mar
 2023 18:43:30 +0000
Message-ID: <4c33772b-fbb8-70ae-cbbb-2d93cc87e4f7@intel.com>
Date:   Wed, 15 Mar 2023 11:43:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v3 6/7] x86/resctrl: Introduce -o debug mount option
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
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778870113.1053859.9553109061915206299.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <167778870113.1053859.9553109061915206299.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:a03:114::12) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ1PR11MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec61d70-79bd-462d-e3ee-08db25852bc9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASrkh/4PqlvbYzSrQZJc1hhJ/Evk87PvZfz5tLj9aQ+vxszccrbXhF78hYPSUZmMI9+OU2QzYnexbt+amUTV8SLUXbnZpqyqqwedzFq5b1jcm/CAE7hMmUKl9Y17WnT5bHWLocg0Eh0WmQ0+v6QtG8OGrjAx/y4DwNIarcby6MTl2uowP/F8bbkipppgdfyvipCdDpqaxmlK6WpVid9bHoIDPlYhBXwN84jpiOEgtB93tEG+4SPPbk94Q40wIBYDoxM7c/WYsdK8dGYKfotazfQHxBfF4M0nrYefFWAlVdefvA6c287ejfOLugEi4FCY0EijXSnimb5oHIy5jpU3mTe/Atbsqz2oWSSRSc6LWlCsfgBM5EvBIUNCbL6uMrlUvtwxtMtA/8j/KchL2Kmo/yLedtiS4GCZX2jLhXyKCMcJFA+D29n+OLybGc5VcY1crt8fkDGVuLGYwJGDHcKrkJiRi9part+BTqNcqHSQNmzQbHwRI4hmV0zkmPOflcDeIrErEWCpRQh9wHvHdHbM46sAZET/g4cd06RlNo76+skqwweBMvWLsv+AR0TUFKC47ledPBnFO6kY1ta1NUUK2L8ZSEIgVSZQpqJYNRbxGuLMtAjk5ya4jZSPrfLPXWX2Dr/++9PSq/C6EyfpLxrgpDbtvrSZCSpotYi43l24BJARQVGidYcM51G5PeUgb7k2rsxNuhklRlEWfoCqt+SJtdqfBnGVGo4eCywfzMcYg8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199018)(86362001)(31696002)(36756003)(82960400001)(38100700002)(478600001)(66946007)(8936002)(316002)(41300700001)(66476007)(8676002)(66556008)(4326008)(44832011)(2906002)(6486002)(2616005)(7416002)(83380400001)(7406005)(53546011)(186003)(26005)(6512007)(6506007)(5660300002)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHg4WWk4dUZ4d1VWY3hkdTNkTTFuVFF3ZzFWZXM5cGMvU1dxTktBWXVSZmQ1?=
 =?utf-8?B?dytUWVVEcHI5c25JQjZoU3VUTUpGVkhZWHFWNmdRdWhoc2hKZFBqdHFRT2RT?=
 =?utf-8?B?cEFDQXlSNW5RR2NhTUttc1BoNE9KTUM1OXQ5UHpBaGx5cjF4aWw1VXMwdnBN?=
 =?utf-8?B?cVdSQzZ6Qzc5enlVcnJGVDZWRkJMbVdwV0VjZncyWEE1NVpKRGk1bW5GdmEx?=
 =?utf-8?B?YlJWcUZJSEJEbGhhMklqWWNNQUpGSVNaSkxESlp0Yjdwd01IcW1CWEpBRTA3?=
 =?utf-8?B?Wm51N2tZS0t6MzR0Q1Q0WHZyL0Q4WjBnZVBLcGUyYXhQVDZrUkszekx4d2JL?=
 =?utf-8?B?eDJNVG8zMmQ1cnh2dkloN3dZcUEzR1RWR013bzYrYUtnTjBWbzI2SkhVckNQ?=
 =?utf-8?B?MWVtYzVlcmdVQTRMdHptSm4xUC96Vjc4dEExM3BHNHpCM1VqMi9nSDMxUm9H?=
 =?utf-8?B?cENBbE55T1dQTjFFdlYyNEEzUVNkMGJKdXZiSkYrYk1uYUl3NGxRUnBhajZP?=
 =?utf-8?B?OVJwcEdWMmNvU2xqZE1oZ1B5ZTlSUUlZVmpwdGtvUUIvbHhyWklLeEdxNXVD?=
 =?utf-8?B?azZuTFdCMXppemdaMkdCTFB0MDU0T3Fnd1RmRE5WbjhnRHlIWG9MaEJYeEZJ?=
 =?utf-8?B?Q0Vod3N2RWg0VmtOcE5PS0hJYnpyTUN4R25zN2VxbkkrOGFqdkd1WUZuWEZK?=
 =?utf-8?B?ODAxT3J3U2pHa3Z2dUZlazRacnJvb3ZRejZ5azBydzBJMzVNbG1NY20yZkxY?=
 =?utf-8?B?SGN0NG1KazJuV1hWVlRHekhlN0NtZ0JvV3kzOGdMZTFqMlRlUTUzWktCeFZR?=
 =?utf-8?B?OHdaUnZLRi94M2gvcWsyVmkvOS9nYkU5b3ZmVVg5UTZySjJlbW1uWGRHaXlH?=
 =?utf-8?B?ZG5sRU14Um9Sc3JpbDA4UmNJYnJ2MWNpdUtvT010NG9GdFdnclNaM0ZrRmpS?=
 =?utf-8?B?ZUJma2tKV3lFM3hRYTRxUCtXVlozVjRLdGpLbDUzMWpLckNwNndtRjZGZzNo?=
 =?utf-8?B?QmJHbjJBUURYSTlnQlc2OTRFRC9CeHorMmVnU1lhK2cvTld4SHRTUG1JTEVM?=
 =?utf-8?B?RStPTFlVd201eVpETEZCSlRMcFN6Y0JFV21aZU5rMTg4cVlJNER2dU1PNkVt?=
 =?utf-8?B?dVZOa0pxbjd3akx5Y3JPeVZ0ekx2ejVSaVVMbHB5ZjU3dkwrYjJ6STBUSklm?=
 =?utf-8?B?bkgzL3dHVGhJYkNwVzR6c09UeWFLOXo0MklPeGRZNDNRTFBhU3Ntc0dtbitx?=
 =?utf-8?B?dUlieUVlZE02ME1aODRVSnJxQ0Z0VTBZTlVMTXZaU3R5cFdTZXYxNWhZcEZP?=
 =?utf-8?B?ZlFNZG1JYWtYbkFxNEs3anFZTlRQOU5Ga3ptUDF6YkpJQmw2MjViTWNhRkNi?=
 =?utf-8?B?dFJYazlTOXNmTm40dDZNcC9LbTdlcUcwZ0ozeEk3d2NiZzBuTDVtNXVHUjRj?=
 =?utf-8?B?bldRVlk5Qk4zSmRxZWdHR3dpOVlXUzRSVG9LMHNxa1lxaUlhY2ZNbWs5WVhN?=
 =?utf-8?B?NWtHNW1tcnRFRGszajNucnFFbDBWRktISG9obE1iaC9tREwxTjFwTkhBUUl6?=
 =?utf-8?B?UXRZT3pheEd2T2hKMkR5THo2dGNvdnZhYkFNQ2JxZzJTbjBoT0dsUEVpUm5x?=
 =?utf-8?B?aG15dWFoV2ZsV0RDK3hxRHlseG1vVHoxazZOKzV4QUFFWmU1RzdEOTk1eWE1?=
 =?utf-8?B?TzNLSFpFTFBwRW9JSGR6R2pPcTVvVWpqdUNLdFdUU09wVVVxR1NUM1JkVjcv?=
 =?utf-8?B?OXZzWjFKbUxOMEpZazV5bEg3SjRheTdpVkN1cGhuTDZhWmtUUW9FakJYUjRl?=
 =?utf-8?B?Tmx0a1dYelZ4UWFJU2gweWlYNFIzOWpZMXZyeVlDb3I2NU4wbWZ0eC91K29E?=
 =?utf-8?B?T3ZSUGRPVHpBMFZTdk9hTGcwMnM4cHR4bG40VWdUV1BKMTNYbFQ5ZWtpcG83?=
 =?utf-8?B?dXI1b3ZYWEw0dzNETDd0Vlp2QmdPM2xLMktMZ255VXVHOUJ4L29UUzBwU3hB?=
 =?utf-8?B?a3EzYUU0cHNNQkJjdEk4OE9xdnhuZktXcUYzcGRIaXlsSWJSRENqWWhSZk1V?=
 =?utf-8?B?aGwrNlcvTENHS3prRWV2bWdyYlc4OEtBTHNISWFGTGhMY05kS3VJRU9IVlJL?=
 =?utf-8?B?LzdyL2N2N29qZGZuOGhXYkNoOEV4RitCSDFsRkhiK2J6ejNKcksxMlRvZWk0?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec61d70-79bd-462d-e3ee-08db25852bc9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:43:30.1555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7pGb0EMnNPiaAqHZ6dJTYKFL+LFeAQRZ6IDdF2dcjaAWuohEJ2I3jyYYsz5/VP0D9xKeJUO9Wun+oLvM56WZAtGaD2CJ0zKBaSf6tytSR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6250
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 3/2/2023 12:25 PM, Babu Moger wrote:
> Add -o debug option to mount resctrl filesystem in debug mode. Debug
> option adds the files for debug purposes.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/x86/resctrl.rst          |    2 ++
>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   13 +++++++++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 67eae74fe40c..1ada4e0650dc 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -46,6 +46,8 @@ mount options are:
>  "mba_MBps":
>  	Enable the MBA Software Controller(mba_sc) to specify MBA
>  	bandwidth in MBps
> +"debug":
> +	Lists the debug files in resctrl interface
>  

This seems to imply that a listing of available debug flags
will be displayed. How about something like "Make debug files
accessible. Available debug files are annotated with "Available
only with debug option"." (please feel free to improve).

>  L2 and L3 CDP are controlled separately.
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 6767c85b9699..35a9ee343fe0 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -59,6 +59,7 @@ struct rdt_fs_context {
>  	bool				enable_cdpl2;
>  	bool				enable_cdpl3;
>  	bool				enable_mba_mbps;
> +	bool				debug;

Why not follow the prefix of existing flags?

>  };
>  
>  static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)

Reinette
