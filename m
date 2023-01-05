Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45A565E1A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjAEAei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbjAEAeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:34:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F302148CF7;
        Wed,  4 Jan 2023 16:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672878522; x=1704414522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9plvrRKtdEFVroS/0JXpoaPER1jxTams0RyqvoEb70o=;
  b=BVo6unt19C/yr1aalUgAh3Ps5hk9CDgobFtdH53FlVogqyiu3LnmBzRx
   qewL8qiCSvmbXd8m80qBtAAxmXd3Nzzz2QgH2QuNYJdew9Mv2BUcj3hJB
   EFWZ36gu/p3GJocY9lhUH1snGWCleHPoduFEpP+NTIJxkSlBXdlMJxbrW
   JbntKlBAcB/l2ef0NHVQUcHHk6PHt13syom6QYqtDLUH7O2BHsl4IQjnp
   NtgXtAKADhRgt9LIeiledhwKgUtuiQtKgT4LOoZRtV7w7KwmH7Avey3tP
   26akFVjDVkF2PzDhXID98yOd8t8fbZ8bVPv+8KA/mRU3QHy148N/4b7wJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="320787158"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="320787158"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 16:28:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="657299790"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="657299790"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jan 2023 16:28:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 16:28:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 16:28:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 16:28:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC1nLB6/l8sTKjVYXRhAwyGC+pDahJbA6bIA1gOkin9AiCtuKScjJ+USoPscbhD4biZ5B6e4MBGJW5vnvYCk99CGB5Ovre+QGwQXt/DRy3/QBqH4BlJ7GfriqtzAQHOAWvN0gB0iYMRWRdX2n1+ycGkPl5uTE1dDJGLKB23THDcpfylfyuaoU9ANHaJkKJsEXIah86kTnHJjBJH2R6WOru8YexeUCOSoXQzIIKw2jziO4LCzVSeHQuWUHdjgAS/lTqNnFrxz6GC7UrskTHYVn0CUxeyD0AcjpEarljNANmZZokWm36MRtBcmQfcPzMnHqfjWUZ6eXp4KNMt74MCjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoLzLp0VDLDsq7dqkXxHoeImcNlEC4TAdA2XeP8Kjto=;
 b=mpEAInvtoLbpQVM6s/IaBul0S7vT5jmWgcQqAnpnxoKmguVzWl9FTweEToDJYR0P+VqvrpZ2tbsbn5deHPj0JjQ4pVX8f0SEHAHMcZvgRHwjBRs2A2glHfPLCdlXMUwAxKlRF3M5m5ftLEmVK9aYEvDJSVfqXo8ecmJYbhyKpzCOw+nzNo2ENNNSfQq4FPkNCtUhBJWBkWYRMd3ECDBQQHZSWgAdRdblJH1Rl/9sENSIDDi/sERjImlloNp+2szFK3pIw9Bo3lPyNIiLSVyjBlxmvWAFgsJWsRirzrfwrh8U4Zb6COW+HcpsFyjbPa9qwUv0Dj70bEAJh0W3jnYUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7507.namprd11.prod.outlook.com (2603:10b6:8:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 00:28:32 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 00:28:32 +0000
Message-ID: <a67ac446-807a-d240-254e-fe8d5596dac1@intel.com>
Date:   Wed, 4 Jan 2023 16:28:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v10 01/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
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
References: <20221222233127.910538-1-babu.moger@amd.com>
 <20221222233127.910538-2-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221222233127.910538-2-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::34) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb1f30a-64dd-44cc-afa7-08daeeb3c69b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFbGose0gZkUW6tnasLSTs8kDXS5CDpehFVb8yvxB2Jn4mh/fRYRVKjS0n4M7W0Gs+SYTYGNq2Tf2bSxO5BG4mAcMwhgqDEwoMcOmo81BqZI0qCsM9jks9THtIimNSXfQmf31ot4yu1wTrN5nHo+13u0lr2blURDoGXWoNxePWdksFbmxFYZBNZOJ868SqSJeGzEmjGeN4k4fDfzKtVmd0Hyk5curSpmibsI0RUY+aZKzD01Tk3InSJ/nizKF+imx3FxAb8fu6W6NExbrt0oWRUphMiElFCqHpaBlYsqzjgIgOgIrauorqAkhbs45cm8TfjQAxO/IKTr598WnVQ7DdrBrK7zdmpOJ/SLRpDw4jfG7NNxhx+Nu0vq5heGf2XAHvN/qT+XC3ek/3Q1RrAwZvj1rP6Etf3azJ3pzruKatz2S7++baDpheBA2ZsDVqtCmlQJ8nnAM2B5ybRsmIFv+hC2EGOsZyEEg+mW8K/o5vxQn4N+WU/wv3shlj4lc1AwgPmTeuSZXjoEzgehtkoFMXudUCTCfWdXrqQa8Y9nXaPYjNR0bq4VFUp2qay3mTXbfZ17CAUtQ9YAucRBsvzv/drgShBN4/zOxs3kKkKCHas+xCT2fkop3rPZAivFZD/DBpuq0yCFnImQ7IGdgNWdB2LTCM5FafnObrKchYfkxU/5eStqJRZhLOUKM8o8w2VZq3O2jXRI8oX0ZgQqjnIXOzAeC+jO2LMeZcUAxnKaw10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(2616005)(31696002)(86362001)(82960400001)(316002)(4744005)(36756003)(38100700002)(31686004)(2906002)(44832011)(8936002)(4326008)(66946007)(41300700001)(7416002)(7406005)(66476007)(66556008)(8676002)(5660300002)(53546011)(6512007)(186003)(26005)(6666004)(6486002)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZEcDRyeWsrOVJkSmRZWWZNWjB2bjVuZDFvN3pIQjNVK3pNY29xS0ZvdHo4?=
 =?utf-8?B?SUQ3VjdMQXFtOWVVVWZ3bUU0Um94cWpCVldqbzVBWTNRRDZqTHBpb3ZsakNi?=
 =?utf-8?B?NlNQNDNuUVpoQTBjRG9TbHlHMzBzVHRQdXI0bTRydTQyRkZVajRpbG9lVjhn?=
 =?utf-8?B?UkhKaU1PUlhiUCtDUjRFN1h6ODNDc3ZONG5xakt1dHpuUk9KMlhKRGQxUGdo?=
 =?utf-8?B?clV4OFJQSG9rNTIxdW5tZlh5RXpNd2lQdGlKajVIOUJTYnBlTjR4STc3YjRF?=
 =?utf-8?B?TkdSVEhyZjlnSFluZVl1YlE5TG9pL05wclpWbXhZK2xaR0ZHZnE0UDBzRzlW?=
 =?utf-8?B?S3JLenFPcEtXaURuNGRYVk83S3VjT3haSThUMTlQRjMzSnREYStmQll2Y0hL?=
 =?utf-8?B?bGhtcklnSjYwbHc4VnNNTEtGS1BLdzBzcDBNYlgvRnFEYXprakdnTWUxSnpX?=
 =?utf-8?B?K1lCc0djQ1paZ0hXOUJTV3FKbHliT2hWNmxTeFZSb09VcDQ0Q1B0Qm10WEdr?=
 =?utf-8?B?V3hLbERMTmROQXBSemhjbTBhQ2ZGZXBSWVg4VlozT2dMdXlKVDhwVFc4Tzlx?=
 =?utf-8?B?OGxaWGxUSjBib3FWV1A3c1lzWDRlclF4QUhQNENiMWkrWERLYVVXL3VMczJ5?=
 =?utf-8?B?WHhyejFJV2JzdjVVYVZoYXB6cmlpSWR4T0k1VmxKKzdGTzliWWdCUUttTDVq?=
 =?utf-8?B?VnVBeTZkRjRzTTMyVXgvbGZqQmp2dmNkQ01ieTN0MDk4U1Y2bHRoNnpaZEVv?=
 =?utf-8?B?d1JMbUxucmI0dzNkMlVsWEUxVXpOZDBsQmc3ZXlDeW9pMkdVaTEvVkhpZDRF?=
 =?utf-8?B?cEd1Z1d2TXR1TlIrS3c0SHNFZXdxdDdGVFZJZ1craThrV1NnWXZwNnFFaW92?=
 =?utf-8?B?NURYaEZWOE9oK0JrcEdEbVZBZlFXL0lwQVhhSjlha3piUFpBcGJrWU5iV1Ex?=
 =?utf-8?B?dERWanl4QWZ2U0JTYW5tOENvRVBmcDdSK3NYMlNLZmpPV0dtS3V6cUxpTCsz?=
 =?utf-8?B?UzNtYVkyVXduZDV2Z2NsWnVBYUw3U3VUTmEyb2g2WVYwSGNqSkdtSjJTcnBr?=
 =?utf-8?B?RzJUdTF2ODN6K2xxREd6OXdNS3V5aUI3SnVIVzk2UWQxRFdQOG5tNWlGaHRV?=
 =?utf-8?B?MEVvWEE0OEpLc0ZGek5vMEtXVnl1K2NxZVdkWGRGM2puS2RBeS9SUG5jaVd0?=
 =?utf-8?B?VGxxV1FqOVVPTjlsSnVsd2JLWGpoRnAxVGMzSG80VXYrS09xRU1HNXl2TEVx?=
 =?utf-8?B?K1A0NEh3ZEtWN25iUVQyeWtPQ09wR3crVmd6NzBaaEFQZFdxRkJiWXBWcnRt?=
 =?utf-8?B?WENnNXhMSENzVzFMeGxKQ1FJWVp1b2ZZdVh2SzBxZUVBY1I4cDNRV1Z0NXh2?=
 =?utf-8?B?TmJWdUt5MWhGM3djYUN2VHBjcjMzRFhxblgyd3NrdG9saEhrT3Z0aWgvaDdk?=
 =?utf-8?B?WjJ4NGM3UG1GcFNvWHJXU2VTKzRrQzFzeVgvdUc1YURySDNQUzg5SUtxcjZD?=
 =?utf-8?B?Y0xUUm8ybVRuYXpjY1Q2MFRqMk1zN3RJWlEyS3pBa1pxZjRUckJOYUUvMVIy?=
 =?utf-8?B?UHhmYVJzamgzREsveUxneEFmQWpmS2hQS3B4cG9vK3M4c09EZUJqQ1oyWTNo?=
 =?utf-8?B?Z2JuamZPVXdzcStYekxPT0RuVWcvNDVBa015YUdRaDlHanNYUjVBVXdudk52?=
 =?utf-8?B?UE9VdGdxVGZSa0VVN2pLSVlyWDdUTENwcER2L0FzcXBVVmhwU0JTZHptUU8v?=
 =?utf-8?B?eWp5YnJxUmp2b1VMYUM5NEJQZzk4Z0Y4TnpVT1B5Z0VRKzF6Q2FvcC9TT1RU?=
 =?utf-8?B?cGp5NjBLNDBGckUrdGdZV3dWWDA5dEF1UEhucmQ0dUJnSElUMktObE1RSlIr?=
 =?utf-8?B?ZU54TXV6Z1A4WlhIekwvYjZ2RmJHbU9tZU10TWlkdzF6UDJBRnc4T2lqY0FP?=
 =?utf-8?B?Sm94TGFGem5UMjZ2UFhoSTZnMjVwNjE0bnE4NG9oYk85cWl5anhCM250ZGIw?=
 =?utf-8?B?bEl2TUVnQlZDZHlCNGJuTkR4WmtBWDFHSHBPR3d5WTFKY09TdFVNOWhtQTdo?=
 =?utf-8?B?ZmsrK0tEU0hWWTYySHVDUG1Xd1ZBQjJTT2dkUUdlcEJaUGhxWkhTNC8vL2hG?=
 =?utf-8?B?RG9uWmZ2UjVKeVl2THJ3SzI2T1FELzU2bjhjNlRTeUlNa3h4OXI1a1g4a1cv?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb1f30a-64dd-44cc-afa7-08daeeb3c69b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 00:28:32.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVY5UcwwpM4LnySTeHJOe6KT0qAJ8qBOkH2yASeKomzXOG4i93OkJPTVth5SpljCRNIa20p9A02SMbcUYjxWiPlwHNZw3uxGUihj33CjGks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7507
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/22/2022 3:31 PM, Babu Moger wrote:
> on_each_cpu_mask() runs the function on each CPU specified by cpumask,
> which may include the local processor.
> 
> Replace smp_call_function_many() with on_each_cpu_mask() to simplify
> the code.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
