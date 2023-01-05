Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B61F65E1AA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjAEAdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjAEAcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:32:07 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D282544FD;
        Wed,  4 Jan 2023 16:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672878586; x=1704414586;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WHzMxQor18ssY44/R24RYE8L5YiOibH3PJD3eKwBpkc=;
  b=kcdC6j40Z6kEhylgov5+nVv3lJTIb9R+vl9MyzB2uribESE4NMM1MMaA
   r98GCaPlJhzeqw4lwvsMr3fb7VcgIjhR9WsTwobdAVRfpWVyvKWfUApuU
   byG2YGNHjgs7RTGxuVxYYrAsJFSxJzV3ngMEGZyAQ7QqXU5RGyYN3dyj2
   E+/hXokf5oWnKXAACzzIcRy8JI/7Unr0agYKm6WDa2okV2JS9u41QSiUo
   buZSehvBtoJV0KjK2CXmUAfp82fkUifDx1S+++mvy+W9KrDnt+rXCQgt4
   SLTWPNsyTNS2Ckg9VQcE/UcG/j9+rl1vVxb0KBGf0ejZtVJUkS6MyvNCr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="323312060"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="323312060"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 16:29:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="723854430"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="723854430"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2023 16:29:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 16:29:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 16:29:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 16:29:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDVanw9wQHe6fFhdbKRLOMYZT659QL15lHhLLksqgoHq2DzKv21Uh6aqdJsb/6zCei8bCFfTKuqCvcrceYUJYzTZHypE3mfRZYK79znbl9jMrPUa97wRbgQxlCaosCVj5zMIsQ6t8BS5yyjczLEh6jDYvrucyd2xtpcvkoNvbKvaGKfSzJ3lwjfvZIgR+YlQUvcBigZBZnHSC3qS5SXvMbDkYqxhPn/L+17ha7INWY9jn34GrrQjgpcI8CVDd22LHs1QtlAtQ7gi6h6SotVsPFSiH0SaF+90rzGDPJzD897Zw9cl4+SoITBnl/AIVnIrfRi3F5LZTYX4b6xtSN7SmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8NBcl1fP7RdEvcnhLHEpvAokzDSEiXcw6dA4ZrVXNM=;
 b=H0x1k/dTbC9MfD/f0XSGneEDSPOGhYhzOlmC18A56C7kNd/q+wEv1z7zIa+yQqCWLZOtmxUVoUyUiQlrlZYemFY4rUH+sMSo+6mLEkRdgY9562R78yxySsRtubwZLL0POJOGTvoq7ENOoHN3nz/STiCyz/Pt2nEGnZAA7bBTYQZfSvagvTYF1kh53sLICLeS0YeG74SNowcgrIT/w/Ba5wZMMUhVsaeH5J57/vF6aVrZT5xA9AJivAFio2qlzfAQ2rbzPfr46mPlZcoloNgYVSxdX7WJ0qHHfDHdtD7sTVbr7VnpMBnasdh5gLFJLOdQl8Yca31dPayfA254yacRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7507.namprd11.prod.outlook.com (2603:10b6:8:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 00:29:24 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 00:29:24 +0000
Message-ID: <384d8a08-ec31-dceb-bb4c-f785a6418fbd@intel.com>
Date:   Wed, 4 Jan 2023 16:29:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v10 09/13] x86/resctrl: Add interface to read
 mbm_total_bytes_config
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
 <20221222233127.910538-10-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221222233127.910538-10-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0096.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::37) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 936f5937-5524-493d-aead-08daeeb3e530
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwLcfe+lnENvE09Xb8GjWjgSdXBpOJ+qcazBOW5oaxf0v1t6+x0xtWWyFfDHtiF+chS1PAVoD0yOiER6mi0vnG1teIy9mnv3WGQudoRiCOsGZas+xnKnlUaX44W4dNXFmG9rwsl38G+X+cvCkAh6VkTAumn0z7dZtC8ENFKOoG+fiUYVbC7vsMZdRXuG6J2WmmQ6ISejFZmiSH9+YLlAv+7fNUDZY0hbby8n0pq0lZzvFNOIYC6XPcBNtv941hIJ1p4gih5LzShLBnScDm5TElD6w3MUoJI628XxIPgeG85hyu5Vot0UwPRG5e18w0ciVLuy6yyv54pKQWik3tlTtbJ/aCLz5voohHq7KZvNV/KKiDtM6FOKwpkfo+e+Ic8xaNWHnWNxGTCWbT4HYxFzWfuf08zIjW0l2NjVwL5mvOGh7ZQpQ/BaeR6qqXAq5xH4wOnXif05CvalaUwMwyeXIYCIe1aJMStXMHUsBLPPv0YFjB0snTOqgbOOeeIoArFQGs5lkQbVd1eZJMm6nWDT+HFJQG4wBlHP/LIEbRPkFz+S9scfFbIbi3McaFoWgvVk3+uyTMXyv2DEFTzrYedPZYdl19upuxNPd6hXdh42A/CUy6O871jq7nA3GaaRPUMlr76x1Jqi1kRdyzqSnMUSSJu581P+XQudIbF9ZUG35GN6RILp/uBxJ5FyWHqV5JtPY4cHggi14Qat6NHi3JIEnzcppv9+9yNAkAzqrU+VSeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(2616005)(31696002)(86362001)(82960400001)(316002)(36756003)(38100700002)(31686004)(2906002)(44832011)(8936002)(4326008)(66946007)(41300700001)(7416002)(7406005)(66476007)(66556008)(8676002)(5660300002)(53546011)(6512007)(186003)(26005)(6666004)(6486002)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3Zrb0xUNWFwTTQ0ckhNMzlGRUxWQ0E4UEdvVUU2M3pEUTRJaVV4R0NYQzdZ?=
 =?utf-8?B?cjJUZEVpeUxvbUsxeUlYVGl4VHpXRkNpdDZNanhKQ1VUaXQwdU9YNVRZM0M1?=
 =?utf-8?B?eS9LRDVrRkxvemFmQkNNSklhbDgvbGNQMGcvNm5CcjlIL2czaEtwcHpmTCsx?=
 =?utf-8?B?dVBxcWxvSitxdGVpRlZZWHFEQURHZm5WK0kvMTJSWlVxR0FQM1kraCt3RUdj?=
 =?utf-8?B?eHlMbFJZUHlvTCthODd5NnVwQWZ3SGZEd2VVSFhuZnUrQ0pXcEQvQWNYOEFW?=
 =?utf-8?B?Z2UwU290UnVJTm1Fb3A0WUt0U1oxMDVyeUx1NmgxZng2ZVVDNUQybFVGdk44?=
 =?utf-8?B?YVdaOFZkMFZpRzdYR01odC9KMmRiaHcrY0c5bkthamdkQTdVVTNZL3NuajM3?=
 =?utf-8?B?Sjh6TUVLb3BGdlJKOFdjRlJRdTJBdWVjVW9wTkNUbUY4Yy9NV1UySHVLT0NU?=
 =?utf-8?B?VlNmbFhJTzhMUituTWpyRW5KYUxYUFVTeWRPUFlLSDNDUlBCY1UxQkRESHpq?=
 =?utf-8?B?d1p2UEFqVCtNTVgrVE5KcVhVbEtpSHBmaVdKZXF1eVhQbFd5T1NMakdGR2E3?=
 =?utf-8?B?TE9VY3dnK2ZJMGdmZDBaSFYyVWV0UnNVK0pnMDQzd2p5Vi9FdXltZUZoaGlO?=
 =?utf-8?B?c2lxcjFIVmczWlB2SEoyVTRKQklCZUlRVGt1N0JaVEkrU0tvNlJVZUpNcm5k?=
 =?utf-8?B?TEcwam5LTnAzQlJsaXNUQkYxeXB1VFhsOGI4WFlGUVZCdVlIQjV5OUR5Qjly?=
 =?utf-8?B?eGxxcTRRYmVhOWFZM0xEb2YzZHBta2hRUGtNajVCN2FlZzNZdTJqVzVqRUlD?=
 =?utf-8?B?MmFmdTVxZFhSV2ZuVHFYVXZxWFNvWWdibEpqTjJPNlJJMklYUHNKejh0N0lq?=
 =?utf-8?B?Z0QvcDRRbWRxSitGblByaHhEN0w3WStXRjdOc2xXQVVFeGg4SlNPd3JIaldQ?=
 =?utf-8?B?MlRqOHpoVEdvb2w2QndjYUhYd3RBakdBb1ZzZzBpS2JRdGt0ZnhqQlhVWTJt?=
 =?utf-8?B?TUhjcldMOFJVUy9COWNHK1BkbVI5cXBZNUFMS0FkTFU3T1Y1dVl4Yi9mYnZ1?=
 =?utf-8?B?Mk5SM21xMXYrTEgzUld1dDlFRk95SHFWaDZjS2lRZXRjSm1DK1pMK2lWdWhs?=
 =?utf-8?B?QUdRcTlmYm5zb3JRNCs0VkVLV1I5WDR4T3d5T21nY0kvd1lYMzAyeGh1MEt6?=
 =?utf-8?B?bEZzM0p6UUNqNGhjUXpoZ1grd3RWSGMzemwrTVovZHhGTWhRS2RSQXhndWg1?=
 =?utf-8?B?UEFOc0FOaHhLOWNnM3NCMjJxLy83akhvYmdKWll6TGNxM0dOYUdyRURWVVJo?=
 =?utf-8?B?bGdFSW1pYWZnUFl0T3NDTEZyNEdIanVYNXFRTDIxU3lENmZKZGNLRGR0NW4y?=
 =?utf-8?B?ekhPL2svaDBCQ2pNSmZFR1FoWGppRTRKV3FPdDdLL1JUT2l4QVNLRDNMNHhD?=
 =?utf-8?B?MlBTYUdmZDYvcWFQT2J3Q3h3dXdqODVMblMzdUkvVi9QUGU5OFNuZTBndEgr?=
 =?utf-8?B?REFvNi81WG80R3VuWEcxTGRLVUppSE1jMjhxQzRsTmVsYVpIR09Oc0hkZzlL?=
 =?utf-8?B?Z0pGZXhRTFRNYnZLY1lzK3dVVERsVEtKMERLR0M3OHM5Uk11TStwbDkwZUhL?=
 =?utf-8?B?S21nUjc1RlNpUVJNVzdnRVpaU2tFWElGMEVQWVdMYmFlY3ZodUd3YWo4ZUd1?=
 =?utf-8?B?NnVna3B1MzRTQmY4R0xtdm1wZGRTMWEydDhyNy8rMjdYaEdIMVB1ZGZkUWFR?=
 =?utf-8?B?RTNsam9nbFUvNG9PTVhENVhWK0Ywa1o5aW1JSDdoUDA0VjY5c1hMUldoWDgv?=
 =?utf-8?B?RTd4d1hyUmlPcVBabFZvS256dUdFZXl1MkNtUTc2VUd1YTRTTmlMYUNveWE2?=
 =?utf-8?B?WS81TFRhUmhVZzNaK2NyK1hiOS9pT1k4aU4xTHMvQmlUUjR5YXFpNGg5SUxr?=
 =?utf-8?B?dXFmS1NzVlNZTkk1cWNTNy9VbFBmS21yd3diakczd3MrM2t4b0ZTSHNvanBp?=
 =?utf-8?B?SnFJbmRqZTQ3VE9SMURhRXJ2Tzdrb0UxdUJyZ0ZIbnlNdWZHN3BBSEtHWlNX?=
 =?utf-8?B?b0dzM0dUZ3lyOUM3azZPbCtZdzdSZzZyckxXRUhYSUF0TW5aWWpGWmtENEIy?=
 =?utf-8?B?ZU9PWFF5MnZONUhtQlp0Y0FkQ1RLNE5EdnJ3dGNlSVcvemFsREZqNDBHZUty?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 936f5937-5524-493d-aead-08daeeb3e530
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 00:29:24.1044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIMY+YX7lia4K/W34mp7P3v8QJqoS9Vo6T2Q9DspJ3jd2OFOIrkmLPZPmVJC063Y3AjLhrsnEP0QhiDM0k1ToSqBylbs79ylxkubYEWnGVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7507
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/22/2022 3:31 PM, Babu Moger wrote:
> The event configuration can be viewed by the user by reading the
> configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.
> The event configuration settings are domain specific and will affect all
> the CPUs in the domain.
> 
> Following are the types of events supported:
> ====  ===========================================================
> Bits   Description
> ====  ===========================================================
> 6      Dirty Victims from the QOS domain to all types of memory
> 5      Reads to slow memory in the non-local NUMA domain
> 4      Reads to slow memory in the local NUMA domain
> 3      Non-temporal writes to non-local NUMA domain
> 2      Non-temporal writes to local NUMA domain
> 1      Reads to memory in the non-local NUMA domain
> 0      Reads to memory in the local NUMA domain
> ====  ===========================================================
> 
> By default, the mbm_total_bytes_config is set to 0x7f to count all the
> event types.
> 
> For example:
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>     0=0x7f;1=0x7f;2=0x7f;3=0x7f
> 
>     In this case, the event mbm_total_bytes is configured with 0x7f on
>     domains 0 to 3.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

...

> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -30,6 +30,29 @@
>   */
>  #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>  
> +/* Reads to Local DRAM Memory */
> +#define READS_TO_LOCAL_MEM		BIT(0)
> +
> +/* Reads to Remote DRAM Memory */
> +#define READS_TO_REMOTE_MEM		BIT(1)
> +
> +/* Non-Temporal Writes to Local Memory */
> +#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
> +
> +/* Non-Temporal Writes to Remote Memory */
> +#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
> +
> +/* Reads to Local Memory the system identifies as "Slow Memory" */
> +#define READS_TO_LOCAL_S_MEM		BIT(4)
> +
> +/* Reads to Remote Memory the system identifies as "Slow Memory" */
> +#define READS_TO_REMOTE_S_MEM		BIT(5)
> +
> +/* Dirty Victims to All Types of Memory */
> +#define  DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)

Some stray white space above.

> +
> +/* Max event bits supported */
> +#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>  
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;

Please remove stray white space. With that:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


