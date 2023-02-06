Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FCE68C713
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBFTwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFTwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:52:11 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A8B2384F;
        Mon,  6 Feb 2023 11:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675713130; x=1707249130;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zuZgPhsJ2kjLJgPNBVCtXoy5ILm2ZtxReVmhIRF/rYo=;
  b=fNcEtSs/KpK1FypnJdxgOw4i2ZRT1OocjjOqtOegeKek7TBzE9IyTgLt
   55ZpRP8cOc84N80jDi8m+bKi4KEwyiYFdXFwtsgHhfRGIVQUb6FaFuLTR
   pV/XdERduLA1L8pLVD8zJ6rF71KNwF4Ka0KDwYv/PnpeLCqJkPBbkrVu/
   PmPqKmUj55bpVbd+SBcr6wPzHDlhgBK/g6olONj75MApireYCzWpTomhe
   aRfm3Ky6yobzNQXfsD95kxTj5yqHy5eLd1k2joLq6eJe9KoALT+6NBDK5
   r/vJj2QWbaxmXoVg7qh+i0rDewwhWQEjNJyE2PLvWQ7ZH6JKUC53wRoHM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="391695804"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="391695804"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="696980874"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="696980874"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2023 11:50:28 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 11:50:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 11:50:28 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 11:50:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBLWbzQUeHw6eM+bB3lf6M6nolAkwXWBmj7/SlKvQp1258dWQlzxmqL4J/snIRB1mQrMzGSE7VYnf4//Q0Mqyd5/fnRrjIq02Ul26N5NfgoLopl0KaiZ6VRC48059mYdBRGm4E60kMRwizrByt/GBPSnIZw2pD2ybz9+mv3C0vqhi4JhBnbWEu71FqnjnvcdjWxoa5OMb3FAFNEgOx1d37ykLH4XOwyZg2UvqqHE1AX/Vk9cDsKiihZj6A/D7Iklvk5rkB4gChXLBVKu0Y+gKuax7FZok7EFvSe6HlrQWAyNig61fnJE3yorSeY6IMT5UYY7xmsZrGRKHe6rGuA0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq6S53+bJ8ql8BEXro+k41lEB/RxvVmKfVwqhzUAqMQ=;
 b=PZkn5U0TxcvbNyKNGHo9pnpi0G26Z91qLMWK9oOaALG9fXw++I82pcDJrk5tmowyGwLo04A36INQ4guJxdW8dB/BxWAfB+/FTAbkPCE357UQxNwglVqz95A0+MW+MnX8p7vgSxhSgFtQMgXz63HV1OC90LpVVxz9X4D0xh9cnbqsZ3xw4u/PP4AQ2Z7TgAQaVnzYfTi8+FMKpoCvOFBOQ/WQTeWq9Uhayq/yM5vYLwNRwoiaT3hDtxKClJz97QE/Za3x94tNH7PQFAvN56wDHAxz2dGnpFnloygS7uFdC4eEnNbOx29KfG4xr1IvrJ0ii/RmajRst1+fIxjuoXyKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by SJ0PR11MB5631.namprd11.prod.outlook.com (2603:10b6:a03:3ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 19:50:26 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72%5]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 19:50:26 +0000
Message-ID: <c41e65c6-23af-0c3c-ae0a-73234652f981@intel.com>
Date:   Mon, 6 Feb 2023 11:50:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/5] platform/x86/intel/ifs: Trace support for array test
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230131234302.3997223-6-jithu.joseph@intel.com>
 <20230206114053.1c46fddb@rorschach.local.home>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <20230206114053.1c46fddb@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::17) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|SJ0PR11MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: 2204963a-2517-4e33-a010-08db087b6416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPV8WjNOCaWAahhSj9h5uEKo6M+T6CYWDCad3lzxOomCkE4X9F21s5jhu6EAZCxpkEQcJP/whsdiO+q969SmTYwiSNjqmFTBPk6F5zJjDjb6UOGupsbqPjs2aY80WlbicN0UYXX6FJjKdL23KqR2R1+O8MErea6xsmmCce6Bjd0TGxNTUzD8bRAOt4Ce67R/z9q9UUi2RiSDYTyxwZsB8DC3X0BXd+c5sJHKWAkq0BVnEhpsQ0cSCZV6KyazYVESyYBrXISVtLjo2tyxRREPSftAtgQVUeLpCc1IUFQPT/ajZuIeKUDVJbMMCl1PZkiY3FJ9P7aoncPKCwMoxc1Njb7mYK4g+OjjBalLWjSzeO+K3xsm7A5CC2zMbdpKbo3quEbW6Q3aPQw/dTuXAlFXuY8QHJ9h/y5W1magWdXdp3R8HpaLCq2Yl+fH+TtfM9brl/y338vNq7OrUDWi0YcZUanSKhWQH0Udz/zRzw5qhkIICYCmr6H6VLtH7nztC7+zFq+Ql38SFJpNqjCNVa5aMnqA4TIpNWydwDctKjDCIqmYlWjtZsYT3TLTSB50LTxYF1FGahCaeoyTW9hyraMlKtbmW8Z1Hc1/SulZ+Ll9WtqozgsT6SgTHiGEeICsg1+0Yndjs1ghLqIc64ElpK40QNOk/e0hAo6N/VrPk7TVWtqo7VZuhGYoz84AOZqCZ2YB6VtrIwKPuPoXhsuf4gj0bLg9XgwKT0foS5NEMOQGKtg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199018)(6486002)(478600001)(316002)(36756003)(2616005)(26005)(186003)(6512007)(83380400001)(31686004)(6506007)(53546011)(6666004)(7416002)(82960400001)(8936002)(86362001)(41300700001)(4326008)(5660300002)(38100700002)(2906002)(66476007)(8676002)(31696002)(66556008)(6916009)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJ2czVBVnJvQjljNk8zN0I1TFA2TGk4clI5VDQ0aU1hSE5uMytXM3d0d2l0?=
 =?utf-8?B?Yjg4N002WXQ4L0w1QWRjTWRUWFJnUXg0L3hlNkUybndOcmNka1FOVXc0NWtT?=
 =?utf-8?B?RjJOMkUreUlKTENzU3FEWkJaTXVWdytyRFp3VWxmT28xdjF6Nmp4T1FXTEFs?=
 =?utf-8?B?R0RLUTZzU2NLZTlMaUU0VWc2L1lJT3V3RXlROE85bHhPS2M1ZEVoZEkrbHk1?=
 =?utf-8?B?MGpOZGFQZlJBK3JPM0d4Y1Q1VFFIYlAvcnBVNW9ib3J0Q0JGUENRS3o2bndG?=
 =?utf-8?B?eUU4RkJ3ZGRUY0l3M2poTmZDSkQ1ekUvNnFPeHhoWkJBWU9iYk0wLzlZdGFY?=
 =?utf-8?B?NjVCSHl6bGgzSGM3T0l4SGVYUkl1VHNDaXg2bzEwZG5mMFdJbldmSUpOTTZo?=
 =?utf-8?B?NS9PTm9jRTVobE91Q0JzZzBvWnZYMGhaandidk8rQ3drTG9wR3ZJQ1R1NGZX?=
 =?utf-8?B?bU1LVkg5M0pSZjFYWUpobVB1RUtwdDdoSnNyOXJvbEIrM0tOdkNSaDM2ZlRQ?=
 =?utf-8?B?dm1lYTByRjVVQW5kYWJPV2h5blBhVlRPT2N6b241OTlzb0UrWnJVdG9wNDFz?=
 =?utf-8?B?cWIyRUpGWm0zQ0lpTjJWcEVCMi9uYmJ6K1dJdUlkdFBPNEhZK1pvVitLWWtS?=
 =?utf-8?B?VktrVE9Qa2d2Y1pqTWU4UE1sajAyRVpKR0pHT2hZR3QwNS8xekJtT1RIelBO?=
 =?utf-8?B?Mk1vVFJ0aFNndmhzKytuaWN5NUxvYzRJK21xYUhiTWVFVlg0WFZJSWJOMm83?=
 =?utf-8?B?TklDbUJ2WkhTMUo2OE92UFM2WWJqa3NtKzh6a21saUw1QnRBQm9FOFM2R3NH?=
 =?utf-8?B?dkxXUHBRUWtOQlhkTGhtWXhXcmlzK0R0TkVwYUppeUNhYldGdFVoN3V3L20x?=
 =?utf-8?B?NUZGdFZzYlNac09jZHdkOWk4MGF3Qmw0U0tsOGhFeE9ZaGlEeU16Z2pXWStE?=
 =?utf-8?B?Nnk0clBaTFY1Q1NFMGFMcU0wQnFlOEpLWVhxSHBVc1VQMXFqYVBMcUUyZ2xw?=
 =?utf-8?B?UWRtTVFFQjBXOGt1NEM5RE9TVVl1clRjdEpOQ2h5d09oWlNOT3R2SC9jL0x3?=
 =?utf-8?B?RmRNbVlpMEhVeFlteXFaYkFUekJQL2U4WmxOVXdKQVVNZ0ZzSFppRkVURTVa?=
 =?utf-8?B?Q3c4bGRGSzdHU2dDZFFMVjluV055Sjg2ZldYdzBmTmRQVkNpb1Vid0xIS05F?=
 =?utf-8?B?WDAvTytrcG91Q0paZlR3YUgwcDBrcVhjMnNFM1MzaVpQbzNFaHdyeXAyKzRr?=
 =?utf-8?B?KzN4dE16ZFprVlhVcWRNbHJVZUxPWmsyN2M4ZGxpRmV5TTFKa1JKcnJtTjVh?=
 =?utf-8?B?UjVsUkVtbTNnanB4TU1aeEdDS0p5OGtsNmtEakpTVWZIUUVyVU5pT0ttbCtT?=
 =?utf-8?B?RG5uT1hmWjFiMUlINWpJdVcwOTFlNTVickhlK0xWUXIzdHpobEVVRVJadHpt?=
 =?utf-8?B?Nnpsb2tpUmcrVU01Vno0aDIyeEZ6MW52dXR0OURtKytIYTUrMlVUL1JGUUZr?=
 =?utf-8?B?WGZrYUN3ZWt4QUw5MzRJczJNK2Q3K3pPUitYRVNIcHFkUGNiWU5LeGo5bTdX?=
 =?utf-8?B?NkMrVm9Qc2lKZ1FKWVdKOGNpTU5BcUNoZEFtdTExOThibTNVWEFQT08yN1Nl?=
 =?utf-8?B?S0dURjg2eGxMZVlXVE9MTDdaRDZjYXRCTzd3N1BkU0tmZGExdHhqaXZ5ZkYv?=
 =?utf-8?B?TzVQeFMrNVZMZUxjR0JrMjFrY2c2eXYwc0NJc1pjZlQvcWhMWkorT0RSRlRT?=
 =?utf-8?B?enhub3VOemxvTVdocGtCbHJtbGl3RGRYK2hqemVidnd0MjBNTHJwbEw0dG0w?=
 =?utf-8?B?RGJEK1ZHeDgzT2RIaExzaTUvN1RWc3hMMi9XMWd0WGplbHYweEtoWGdYV1o4?=
 =?utf-8?B?TEJCb1ZvY3YxNzh5dUhXQjE2K2lGWlZpaFFLeERaS0c4bURjV2lEOE1Mb3Z6?=
 =?utf-8?B?THY2UU1EKzgzYlc0UHhpbHhnVm05bVNER3dha2xPVTh0NVk3VVVuTW5uaXRj?=
 =?utf-8?B?ZjB1L2hQYy9BRk5OK1hrU3NEWWZoMUVoZkdyZjBsM3FKSkEvR3JCd09Tai9o?=
 =?utf-8?B?VWUrWmtNM1licmZ6aHBOMUk2RnJvSzBkb0JpMjhwOWtkZWZNb095NHBhTU1P?=
 =?utf-8?B?dDV1aUNsMSswdnNFRFdHaEYzeW81Mm12dzFlQXFLQmIvTzVqK0dWRUJqQTgz?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2204963a-2517-4e33-a010-08db087b6416
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:50:25.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAShBGXs/a/fmCchZ0L0+ktj1RODQn/Opk6jk3ih4rpusJ20KdEkYqg1pv2Y73F1jZAPMHHiGt6L7BoMBWXiIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5631
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

Thanks for the review

On 2/6/2023 8:40 AM, Steven Rostedt wrote:
> On Tue, 31 Jan 2023 15:43:02 -0800
> Jithu Joseph <jithu.joseph@intel.com> wrote:
> 
>> diff --git a/include/trace/events/intel_ifs.h b/include/trace/events/intel_ifs.h
>> index d7353024016c..db43df4139a2 100644
>> --- a/include/trace/events/intel_ifs.h
>> +++ b/include/trace/events/intel_ifs.h
>> @@ -35,6 +35,33 @@ TRACE_EVENT(ifs_status,
>>  		__entry->status)
>>  );
>>  
>> +TRACE_EVENT(ifs_array,
>> +
>> +	TP_PROTO(int cpu, union ifs_array activate, union ifs_array status),
>> +
>> +	TP_ARGS(cpu, activate, status),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(	u64,	status	)
>> +		__field(	int,	cpu	)
>> +		__field(	u32,	arrays	)
>> +		__field(	u16,	bank	)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->cpu	= cpu;
>> +		__entry->arrays	= activate.array_bitmask;
>> +		__entry->bank	= activate.array_bank;
> 
> Regardless of the "bitfield" discussion on the other patches, this part
> is considered a fast path (although if where it is called, then it may
> not be). I would just have:
> 
> 		__field(	u64,	data	)
> 
> 		__entry->data = status.data;

Will modify it as given below (in-line with your suggestion)

	TP_STRUCT__entry(
		__field(	u64,	activate	)
		__field(	u64,	status	)
		__field(	int,	cpu	)
	),

	TP_fast_assign(
		__entry->activate	= activate.data;
		__entry->status	= status.data;
		__entry->cpu	= cpu;
	),

	TP_printk("cpu: %d, array_list: %.8llx, array_bank: %.4llx, status: %.16llx",
		__entry->cpu,
		__entry->activate & 0xffffffff,
		(__entry->activate >> 32) & 0xffff,
		__entry->status)

In general this is not called from a fast path within, i.e rate of triggering the tests is likely to be
"per minute" (Though in certain scenarios of driver retries it can be more frequent than that)


> 
> 		__entry->data >> 32,
> 		(__entry->data >> 16) & 0xffff,
> 
> Or something similar. That is, move the parsing of the bits to the
> output. libtraceevent should still be able to handle this.
> 

Jithu
