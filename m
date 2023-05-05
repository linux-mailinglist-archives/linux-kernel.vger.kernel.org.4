Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2F16F8917
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjEESyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjEESyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:54:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0B11608C;
        Fri,  5 May 2023 11:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683312854; x=1714848854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nk0d2MN4QU5N/fADCxlqeMhf0XjO9CjkUT4jr2/Jsf0=;
  b=TvkMshnfhZpnqp+ruUeU3WAMnUim1PWqJt1zvY1pNwvrRuAL6Y8Y+7gA
   uZIqIQCDdUv1X7c6zKVNWeGHCbAYkYDp7OVJ3yhndzVDX7/+VpI02xVxq
   nTAr2yCXaBw14XGxerPf5wVFBk4Fz6mKOBRjdKaLeMJ2khtpdzsGSHXSA
   Qv+f3UZR4Edgg0G8nM+faf6dMVrOgwvRvxH1gB/aKYNCkazarBMJCUCzj
   mAirX6C3fMffj+5OhIGgeqLll0Gmm1N0/pN/xHTsCH101QzFt/1hyjT2R
   KAJpmLqTnqv74x08HH4kFQ+jdnWMqjgCkiBLgrQO3UrkWO41hnSJ16npl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="412516641"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="412516641"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 11:54:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="762570692"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="762570692"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 05 May 2023 11:54:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 11:54:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 11:54:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 11:54:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SERqpd9yIYZpHgqGf9xQCqAmGomJ8cXoIMbblG9p21tv3pcpWbIcEPzhLbOzeSzOg01UW6wZTwjx7f290asOMu4NaAnZsfx6c8INnulXHS5EPsXlsnbyMrpgC/YWjDOniIHJtJ7TZL2hqtZAWYM2SYvE9yDaxUXhA41GSJmCBTwZbJHxqwQ/irhLtiZ7rbQxBZD9MGy1awYBWsDqoxDC6GGFCIa+bqtyXBlxU/fn3sJ1GybQZYrTZqrI8Uj+irurO30Tu/HzPWUNIiGXwmoziOkou8CzmGDVCXp+PAnrM3APlWxvFay0jPVRyL1qT1cocysE3Oyt6deSHqMaxbZBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yEvmWmeX3Bh1Aftw+Sl/ZvRTq5bo5rjWiGV3UvC/BI=;
 b=DYB4QOhYs8pwv2knV6FDYv+COKvutqcWoIZVNeBouDgEcTKZDW4UV+vhIdzAgHemCfe/Y532Ftp6pvf6y6ymY6YGrGZWsTCYtRSYKfef7WFNxzkRrX794mQu9c9OKYOytG6npqayFx6PLq7Ls1LY7ycWPDcYjFvKJOeZjQrrpAaMjFxCkS3jI7ix2u/Kq+jCeRjlZHpXooPBxochnzvlBgqyZsmbzsDJbfdgZ2KbN64ZVRAZUqPvI9CfeZ6ZtVSy7piIfXnGXE6Alsg0uMzFc9hYBdBvSQql64NzHgwOOp1b6VGYHD/iz0aeFy+ZM49C/6cVet8up3VVM21zuErDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7354.namprd11.prod.outlook.com (2603:10b6:208:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 18:54:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 18:54:09 +0000
Message-ID: <efd45c71-2241-e0b8-e1c0-6fcc1e95b321@intel.com>
Date:   Fri, 5 May 2023 11:54:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/7] x86/resctrl: Remove unnecessary rftype flags
Content-Language: en-US
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177445556.1758847.5029687867896978170.stgit@bmoger-ubuntu>
 <4275aa91-5834-2c03-f455-f1d3d666fec7@intel.com>
 <MW3PR12MB4553E65A5D5DE6E27045766595729@MW3PR12MB4553.namprd12.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW3PR12MB4553E65A5D5DE6E27045766595729@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0057.prod.exchangelabs.com (2603:10b6:a03:94::34)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 08cc7d64-ca47-441c-6d93-08db4d9a1bfa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zfwz1gGULBsxFE+uryKhBtHDHnQ4DAluGfeWnMaD1p7gUgEzQ5w8Shsiuq4yRsc0XnkMIA7KcSz+kv1NKnns7MP4zNbCRZ2sYFRVSyASclNx5LYln+8yRuuiSMHCRgeRubq1JGae4hPE/HXtDkv1Ke1gDHkB0XmNMeCk7zHlOgLa5+AGU5ajNtUpgKmVeglRe0RnRs5Cg3m0nMvH4jSilmkLDVoWEPPFi3tiPDBwwkMHulQTWZsg0SJdKRqVPlu+ZRaWmIB3bI28jbPJhA/Mfg/N0tqw8aM2sIKXqNK09pYeYtSXoH91oTsbbfKHNp2+YyRzHlc9lh7K/j/ccQHuMaZHQgjkDf1GMlHgpt3phdA0j9YL8pZE9HxuAqKAMpqVdknyY8Try0imKbM44lYc5fu7xyjMHFJsJzQnfAD1MUMcCVP8alryI1rww/Cvzyju6jz/8z6czsgE1X+oj53xnd+Wegf0hkkhvGKpfRkdJlJL+i8GsQ0H2UF2eX9hxpVNk2bwzcbGqvGeBnQbnlS/QpbvCmX325Hr1wh1EkNy2mj4OR5P3NJ0cPsVomCk29CMVQcSDpq+DYk5YPKKTZg3jmMPshxn17aUj5WaISHv95T+5BWaFd5UoLG+a2HFd6LEM7x+9QpDCJ/LG1hKsqye5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(36756003)(7416002)(478600001)(44832011)(7406005)(8676002)(38100700002)(5660300002)(8936002)(82960400001)(54906003)(86362001)(6666004)(6506007)(31696002)(6512007)(66946007)(6486002)(66476007)(66556008)(83380400001)(4326008)(186003)(316002)(53546011)(31686004)(2906002)(26005)(41300700001)(2616005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJBdmtNR25VUG1GUktvdTBmSHA0TTc1QlF3S3NSQ2hXL0o3SGtxMUhXZ0tZ?=
 =?utf-8?B?bHFLSCtsaVMvK2VqUEpKRkFUUVVIYUFieE1ERGwxTnJYOHptUlJiZEQ0ZEY5?=
 =?utf-8?B?K294SmsyZCs5RTVQN2J5NkV6RndIc3dGNUpUK2M5UTlvUHdZOWpEdE9seCs3?=
 =?utf-8?B?Wit4aXBrRUlkeEhJM3VMREM4MkpyL3p1ZE5DSzRFRHYrOEYzaFdINlhkandY?=
 =?utf-8?B?NjRTZk9ZZHpmQzc3OWdjeFlIUEE0NGlZZzEyWURVbGRKbTBoRUNDSjlxVEpR?=
 =?utf-8?B?U2YzZ2sxY2ViTHFaWUNub3pvZ1RkS0VMaFFTd013dWxLTXRMKzRpU2hwWE5t?=
 =?utf-8?B?dkt6Mm40cFVkdDVPQUxiSnVsZHdUZzVsZm9nVG91aHNiOExtRTJvR0pwMnRq?=
 =?utf-8?B?dC9HbmpEdDVoeVJvcnRkWmsxRW9xZUorcHk0MDRlQ2JHcWVIeDRTTlhTRnFs?=
 =?utf-8?B?RGx1OUtPNTYvd2hTS3VGT3dPczV5T0FjRlpJQXF5MkVFSDBDMTcvanM4YlRr?=
 =?utf-8?B?OWVGVUFGejU2dlUyN2kwUE14clVsM0FZaXdnWEZjSzdKaUF4cU5tNnFKazZa?=
 =?utf-8?B?UktORmc4U2hVVng2a2ROVFNlazI1aWovY2pYZ3daVUxIUmQxNDFjV2g3azNE?=
 =?utf-8?B?aFhLMlNFMXBJM3NpMjBLYVc3NHdLeUxqcnJjY1haU2hJK01jSXIwZHV1TjVJ?=
 =?utf-8?B?YXdSSGtoWWRUOHczemxIbnI2YmxOcHdFdXlPN0Z4b3ZjNEFjbFI4QmRYTTRU?=
 =?utf-8?B?dnlMQ1A2VXg1MFZKbmhaUG1xayt0S3NNZWxzRHJrRlkvSUVXdWJoR1M5bjkr?=
 =?utf-8?B?RExBcW5hQjRyVCtJQlp6UmhlS3dpNG5RNTQ0OUtYTTFqbzlPcFNycVdtNTJa?=
 =?utf-8?B?bVk3alFscVU3OG1QdXc4d2s4bjI2cWp3RTJrV01TSjZteXpWaWJIYU5vWkNk?=
 =?utf-8?B?VTU3UXlQZU8yQ240RHFQS2NwZ1g3NVdvYVRsTkhKczhBbXdkTEh3WmE1U0F5?=
 =?utf-8?B?QkkycVovZUt5cXRkV3ExSnpuc21sSDVvcUZGa25heGRhTzFhbm1XQy9RSDg5?=
 =?utf-8?B?Y0tOWHRxSzRVaENjWW1BcXhyWG9paWVaUmtTNmh1QmJDbTNaZUYzU09VeXQz?=
 =?utf-8?B?NXM5Zkd3QnArYUJsTnpNczF5SDN5Q2R5UzZNeG05TUx0eTAzR0Nnb294TllJ?=
 =?utf-8?B?QTU2Wk93SXErZGlRRUxURkpXTlJFd0N0dU9sOU4xNnZ4TUhsa0UxcTdxdTV4?=
 =?utf-8?B?ZGJvUm1tem52bFNKZ2ZLTGFuR2RidFdsZU5aNitLcHV0Z2U2bHhuTmpuSWdT?=
 =?utf-8?B?SlFBWVJOQ3dYays2T0hBUnI1elZQY1FLNmljNlF6RDBuTkRsNWhVTU9qOFBi?=
 =?utf-8?B?aWJHcWhWR1JsUXhpRCtLc3Q3anlIUGdPVEpHTFlkMEUwSGR6OG5icHhzdVpE?=
 =?utf-8?B?MmdMTEpaT0RDVENPV3hqL0FWbFBJVFFubTZiSS9Lb0dabXJMS0ZmbFoySmtz?=
 =?utf-8?B?RSs1YVpMdFlvcDFKZlZZS3lwcVhDQ0hYYkQrOWZ4M1VoRHA4RktiKzRvZGpS?=
 =?utf-8?B?UzFTS2hVTFhLT3NyK2kvZDdMNFp1bDM2cmM3OTFMemxGd1RXSGxRNDgzeHl0?=
 =?utf-8?B?ZnE0OUdZN2tnbDVlSlR4WHFSdGhJbCtlT2pHTCs4SS9DbnVTWk9DY3ladVVB?=
 =?utf-8?B?QjV0ZFdCendiRWJZMGdNVWwrZWc4c3BEVGcyNlhhUitJTzlDM0hLczkwWHpW?=
 =?utf-8?B?NnVvSExwcWJ6bW9hRHpiU3RWTWdQTEp3VDBwYURreHYrcUhBVE4vNHNwOWZG?=
 =?utf-8?B?WjdIMDBrMmR2QmREcTdIZ05udDFTN1AybXRtaWY4Q2ZBRnJwaVJtb2xpQzRU?=
 =?utf-8?B?T1ZEaFU2eVU5aStRNHl2Wjd4YzFRUHJKaGZBYUxMRkhRV3cyUE9YWDZ2ZkIw?=
 =?utf-8?B?RTdSRFZmU2l2TTBiM3kxNzd6dk1KN0NicVFlRWF1dGZvMDlZeWt6YU5mSS9L?=
 =?utf-8?B?UnRGeDBseFFGcHBCLytZcWQ4UEtUMFhTcVZKYUVHakd1Nk5uRmlTd0pKeE9h?=
 =?utf-8?B?OXp0eTdHbmg3OHQ5eVpwU0owVVNJQUI5KzN0VGE4dm5OSFN4VWdhYTZNL2hN?=
 =?utf-8?B?M3JHREN1SkNMSEJUdm42NjdnMUJMMjRiUXpXb0I0K2ZHUWcyT3NmeTFaeDg3?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cc7d64-ca47-441c-6d93-08db4d9a1bfa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 18:54:09.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yA7iwQ5mL83L06BXkE0vpMRvsWj3KoT24odIctSd5Y8yI1UsNU8jJY72qyOsh1NiiUuGulNAmffWVDfQFHRbNc4jTYrKp5SKQDyrhbEhGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 5/5/2023 11:31 AM, Moger, Babu wrote:
> [AMD Official Use Only - General]
> 
> Hi Reinette,
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Thursday, May 4, 2023 1:59 PM
>> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
>> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
>> peternewman@google.com
>> Subject: Re: [PATCH v4 2/7] x86/resctrl: Remove unnecessary rftype flags
>>
>> Hi Babu,
>>
>> On 4/17/2023 4:34 PM, Babu Moger wrote:
>>> Remove unnecessary rftype flags to avoid multiple indirection.
>>
>> Could you please elaborate what makes these flags unnecessary?
> 
> Yea. Probably should not say unnecessary.
> How about this ?
> "rftype flags have two prefixes, RFTYPE_ and RF_. Remove the flag names with suffix RF_ and avoid indirection."

I do not think that having a different prefix is a motivation
for a flag to be removed. Having a different prefix could
rather be a motivation for a flag to be renamed to a consistent
name.

Could you please describe the problem being solved?
That will help to clarify if this patch is really needed.

Reinette
