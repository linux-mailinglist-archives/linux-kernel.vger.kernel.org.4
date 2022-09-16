Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE995BB106
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 18:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIPQR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 12:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIPQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 12:17:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA72B6004;
        Fri, 16 Sep 2022 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663345072; x=1694881072;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=46U8NN0tf0acoIRZ8hXNbNz+bDZ6dfEGJwuD8OnDibM=;
  b=LB4k2XEv4SdVFuLPr/f1vC6//Qta+oo1kQZorymM/8hb25uIIl493vwM
   uYTuvewfEd2gGR5jw692S8Vm+GaEWdYrux+bjDaG62SFGBZR7UzG1rI/g
   ZS6RYX1GgbjyzssrSL5GEieY8zzn6VQKJLFdJ1zNsrn/Mas3BHYpjaThd
   Iy/3PWq/fE8LkjBMDr5UVeGGXenFBrpG3CMtucCYqGOfNh3MnjeY0oyMr
   D0AwoTkk3NQSwAOA2VRawZP3aWn7rmxRfskogjL3IEhmHO8UyFI7yfYwm
   E44Le6job0oVCuHKxqDmrpWe85PbQJmknNyUhKriJljsh6fZSW/Veeq5X
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299847898"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="299847898"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 09:17:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="686191165"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2022 09:17:51 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 09:17:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 09:17:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 09:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHrXgA5WnMgRmfye0CYU08eL1KsHUL+FvxnyJQTil6dg7hWm8gJn7K8qrFGIKXDsfz2ahgz9ue32BrqvM1vEWKFTMqriKCxJdIfx9fCCRkijZVTxYsGOTUEjdMd1wvIKriRUNpczSyj340zOKX2SFEC0Z39HBHs0+Kslw9dgPxYaJvyrg7dGBsLOtuwwj9xrkMKeSVhRb/VFn1d5WJIwSLF9WiOj3z+4TKMlTKGmOt+uwNq74YTvp30xjy8eurox5PPSwvWkrRwI/vGAToFcqonx7oK715QIjgmlGRcAg1qCzQFD26vymcSikHhRZ5r7lfDSlOsBbdV8q8SbbMeTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+IWIktLA5LCqWoVIorGW4gWrUnIAPeTcyoOau5aF2I=;
 b=gWJ90GVtczEpEUbGe4f7SscgSMFm51D/WbnkcMMmbpVnNoCfFzOitv19qEWMc24+uK6EHksYxDd9A0spWQ4vsvx3tJvjwO88fVAEnrbypytZw07yMVLAw/zo1PbujRWAKsLTtCnfq5djt6ggAjH3MkdfQWKEjpUXdV52S2KL4bXoc1ByDxLkFVzJzk6Txl7obYqkZQ+OOeQK32CvRiaeT7tnEkrlCydsr8CpBVQBSxeyl+xilaFEUytnkh03QkQJ18DASjzI4FQ5mI3DXCA5aoFsy4cOGtFxlaZxXf5XRHQT70FGn93LOwW8hreMYoAktJtNNETm4mpLo6xfRAe7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 16:17:45 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 16:17:45 +0000
Message-ID: <32cfa982-037c-6edf-702a-c59d9c5d2f57@intel.com>
Date:   Fri, 16 Sep 2022 09:17:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 11/13] x86/resctrl: Add sysfs interface to write the
 event configuration
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
        <eranian@google.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257367603.1043018.15774268739007323339.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166257367603.1043018.15774268739007323339.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::32) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: ac19df6d-b09e-48da-2522-08da97fefd0f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 299zgOBZBb3PKeQKqY6XQiDeI0i7WxRc3uHUAFqfDl+sw8TrPjEJ1gqSKYWZMTIXhfGJgaF8QDI9iBK69qUaau1rnG0cLc4lXy1dO50Diqo6NhoBeBUP01O5Cf3EtTRGfCYhsY1R22Ma575H76yDQrAZ9vrmIe4pPg++nOvl4pWmQxqj6XQlrfgkCRp4ttw2egjoOt60houIeUvc5eXkhNY9dR1Mkx2WaOlQYJwb3k2iZbOepNE85ur2W6BnxJYNNC533qlbgss9fdYrRjOWiF2qmD8Vq1yiGvB22CXIDk5cVDQH4wIga6k+7IREtLE9DZMTxot5QcMqfXgM+3lD0R3BXv4u/uv9xUYQB+e/Bgf97ofbeXFPafEaK67eQxiES9/+r1pFDCIJQh3+ckcW0Qa9QJAi5Qsl2+JGp4jXsTlg6ejTFOnECylnTi8Yld55iJtjn8Jm9VhFJg9BrfJcGpbiW6nSYIFlmGtHKrUYKhQ3uHzD45rrpXuOY5iAsTdKuOuGL2jeEZMB9fApp9XMtADfcklGw6t0pKu7Pu2tTSPU4CcaH3loFP+s1tQVi7Np13vj0fTgZ3cf6AN9IlWkA/oeLvsRP0oorpn+OF69nRh91zhyWyTVHiew2WonfmVitrVOkrrAjsgBkZPcBAgmAluaXjKnIljOgCCBgPEUzWg1XY+pl6OTMhu1NeHHEH0I4dz9zV2QLgkMgXJcjEApr8Iudk6IQKDDrS7WwtDB6jPEpQFMDBhi+esYxVqBEmyIZeolLp4ejR3ZO16yRlLv0b1KWIS21jXA/GQfjNFsOPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(478600001)(31686004)(2906002)(66556008)(66476007)(316002)(41300700001)(6666004)(5660300002)(36756003)(6486002)(31696002)(66946007)(2616005)(6506007)(86362001)(38100700002)(83380400001)(7416002)(186003)(82960400001)(8936002)(8676002)(26005)(4326008)(6512007)(44832011)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzExTHY3Q00ra1FjSXhoYXlmNDhkWXIyZVI5bThhREdCVjhob0ZacUl4NzNt?=
 =?utf-8?B?Q2hUQlR4UkxjS3F1STljcHNzRUwrMXM2dlNHMlpSUkxiQXo1eVBiQmdOTjd1?=
 =?utf-8?B?VlpXWTBFZjRMSUwxSVQ5ZFpJMjVhZk5BbUF0clpUSDhyZkxBSFhkSUNOSkZZ?=
 =?utf-8?B?VlcrNnpsb0dNb0Mva1VJWEZqOTVoUUVTUXpHK2Y1eFM2OHJlWWlrdnpjcE8v?=
 =?utf-8?B?Q2k1YzRaUUt4ZzljTjVHOVVoaUdkMzFnV1F1Z09QTklwYzhOREF3Wk5iRGtr?=
 =?utf-8?B?SjdIT0x6VHlvM1J3UHhMK25TNGRva2Q2VWhCZHcybzdZYVdka3FnRHNrRG1U?=
 =?utf-8?B?TlR6ZFR1bERQVUx3M1VGNEtsM1cxSTA0MDNHVDdHOTRNMDdKa3JsQVpGYi9D?=
 =?utf-8?B?NVBkc2lqTWgrVm8yekdTbFNYZTZjbWpWdGtsY0NtLzQzclhtb2d3OTBQRUY1?=
 =?utf-8?B?eDNyZG13TnFkZnJiYnY3cTB2UUhRV0d2aGhtYlhZWWhadlVmZWk3SURNbjF2?=
 =?utf-8?B?NnFCN0p1dlhza3h3b2NlUUVWSXo5UE9jZXZBT05hbnd3Zkloejh6d1hwYk5u?=
 =?utf-8?B?TTkzMVpQc0lCVGE3Tksxc3lDTXZaNTFBSDdtSVRSSUdNK2xnYURVSHdRb01L?=
 =?utf-8?B?L1hKcVF3UDR2bWsvL0w0ZVd5ay9kaGd1N3VyYjRBandtTStFVnhvSVExdFRM?=
 =?utf-8?B?WHZZK3JxdEdPWGFTUDdibldVWWEzSi81MXRMZmVMSjNrMnRaaU9rRXlqa1d4?=
 =?utf-8?B?L0luSVRmOUNyRnNsbEx2aVJId2dFbWoxcmJEY1ZJelVTZGtuZy85VnFuMUF1?=
 =?utf-8?B?YytpdGRHR0RhK1ZzSFcwejhZeis2WmdUdm8wRERkOVhLS0FRU05JTkRwUjNl?=
 =?utf-8?B?eWhTdzlUU2FDeXpVdFRmeGowNStYOFNHL3F5WTYwbE5qUExsWEd0LzVJWDNz?=
 =?utf-8?B?dHBhd3JoSGNQK015U2RRTWhCUCs4RUdCb0l4OWNoL0l6aEF0WDZuM2xid3RI?=
 =?utf-8?B?SVNPbWRDdHNzT2taelB6ajc5cXFrYUFFb09GanA4cnR0dUNHbzZqdHlBMStN?=
 =?utf-8?B?bGxLN1R1S1BZSGFmUzM2VFVZSmN2YTBzNS9SdzE5eERZOHlSZVlaOXNPMmNi?=
 =?utf-8?B?TXdLMDNOSHA2SFJiQUlRR2pMSElSTG5BemxQeU5MaG5rK3dBbmJOd3R4MTA2?=
 =?utf-8?B?UDF3UVRZL0M1d1JPSElRa3hyUXdhaW15UHpySXFucVltQ2x4dU12bnE1cTJ1?=
 =?utf-8?B?NWdiVURQNHJnS1Q4YXFQNWFiMVBUMlZoR1p0c1RXSWNVUXB0dStrQ0VlUTFa?=
 =?utf-8?B?MVZIb0xVUGVqNU44eC9UNjJ4MUd0NU83QTdWcFd6YTVPaEpIUjVvMTlRQUpl?=
 =?utf-8?B?ZXprQ2hXb2tadVc5WitiV1FyTEIyNlpaY2FOb3V5UnRuSnBlVTROZTgxVncw?=
 =?utf-8?B?T1loUEZzUUg2WWFVY0xaQ2tnYjBtMEt6TVQ2QWo2aXl3d1NjdU5kVWlxWXdw?=
 =?utf-8?B?QlNJS3creVByOEN3UTdLRVB0eGp1U05GNDV0eEZGZHg0WEVvL1dtMVRxaVVl?=
 =?utf-8?B?VEJJbVNxVlB5ZFFQNEtJNDg5YW1vbnFQa0NxaFVFWmJDOFBsanFweGdLTm1n?=
 =?utf-8?B?dTFOZW16YWZITWVESEJMdVdvcWtYL1NORjBMWGZTNjNXbnVDRHBXZmFUTWV6?=
 =?utf-8?B?SGRXMVgvNml1VlRiRXVzQjB1Nkl0dmR2eXRSNjBKSHFJYnZMRHlGT2VBNW02?=
 =?utf-8?B?ZU4yRTF5NHYrNlR0ZGJGYWhOc0ZqYW9qVW9PUEJQeENIMUhlbnppTEJydGUr?=
 =?utf-8?B?MWZFUHk5ZG0yalUrSlVnVk5ITkFMcDZqK25nVjl1QVFWT1E4REZLbk8ySWpr?=
 =?utf-8?B?SkRxREVTWkU2V1J3c0dhSlhScDNocW9RYzVjRWVSMjhNc3pZbXprQU1hWVVn?=
 =?utf-8?B?eFFJR3krRUt4Tm93d0hTWVRZNlVqdlhiVWtXTE1IYmp2em9seGlXdG5nemZH?=
 =?utf-8?B?TUczeEZhZCszOElaZHlJNzVvUFBBSHUwL01ldUMvbzBwcFRFK0lUY1FLM2Zk?=
 =?utf-8?B?MTlXcEFVQ05SUk9Jc2d0d0dtRnRpTUJBVlA2ZCtVMXBHalRGdFZna3hBM0xZ?=
 =?utf-8?B?V2RCcFdqa2phVk5kK0NYZ3hFNlRlQWRaSWZMeHVhcHhtZ05SYmJzTWtCaWE1?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac19df6d-b09e-48da-2522-08da97fefd0f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 16:17:45.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBLkhEDEvowdk7dPWt2voD2mPaSg5zPDqwLBHuRIxcxNVx7DIcna7rrtNoyRvuWSGjbH8f7QCkX2Kc2Ejw5+mIxaXG+EgFPKZDLUXkV5Ebc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/7/2022 11:01 AM, Babu Moger wrote:

...

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6f067c1ac7c1..59b484eb1267 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -330,9 +330,121 @@ int rdtgroup_mondata_config_show(struct seq_file *m, void *arg)
>  	return ret;
>  }
>  
> +/*
> + * This is called via IPI to read the CQM/MBM counters
> + * in a domain.

copy&paste from previous patch?

> + */
> +void mon_event_config_write(void *info)
> +{
> +	struct mon_config_info *mon_info = info;
> +	u32 msr_index;
> +
> +	switch (mon_info->evtid) {
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		msr_index = 0;
> +		break;
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		msr_index = 1;
> +		break;
> +	default:
> +		/* Not expected to come here */
> +		return;
> +	}
> +
> +	wrmsr(MSR_IA32_EVT_CFG_BASE + msr_index, mon_info->mon_config, 0);
> +}
> +
> +ssize_t  rdtgroup_mondata_config_write(struct kernfs_open_file *of,
> +				       char *buf, size_t nbytes, loff_t off)
> +{
> +	struct mon_config_info mon_info;
> +	struct rdt_hw_resource *hw_res;
> +	struct rdtgroup *rdtgrp;
> +	struct rdt_resource *r;
> +	unsigned int mon_config;
> +	cpumask_var_t cpu_mask;
> +	union mon_data_bits md;
> +	struct rdt_domain *d;
> +	u32 resid, domid;
> +	int ret = 0, cpu;
> +
> +	ret = kstrtouint(buf, 0, &mon_config);
> +	if (ret)
> +		return ret;
> +
> +	rdt_last_cmd_clear();
> +
> +	/* mon_config cannot be more than the supported set of events */
> +	if (mon_config > MAX_EVT_CONFIG_BITS) {
> +		rdt_last_cmd_puts("Invalid event configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	cpus_read_lock();
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		return -ENOENT;
> +		goto e_unlock;
> +	}
> +
> +	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
> +		ret = -ENOMEM;
> +		goto e_unlock;
> +	}
> +
> +	md.priv = of->kn->priv;
> +	resid = md.u.rid;
> +	domid = md.u.domid;
> +
> +	hw_res = &rdt_resources_all[resid];
> +	r = &hw_res->r_resctrl;
> +	d = rdt_find_domain(r, domid, NULL);
> +	if (IS_ERR_OR_NULL(d)) {
> +		ret = -ENOENT;
> +		goto e_cpumask;
> +	}
> +
> +	/*
> +	 * Read the current config value first. If both are same
> +	 * then we dont need to write again
> +	 */
> +	mon_info.evtid = md.u.evtid;
> +	mondata_config_read(d, &mon_info);
> +	if (mon_info.mon_config == mon_config)
> +		goto e_cpumask;
> +
> +	mon_info.mon_config = mon_config;
> +
> +	/* Pick all the CPUs in the domain instance */
> +	for_each_cpu(cpu, &d->cpu_mask)
> +		cpumask_set_cpu(cpu, cpu_mask);
> +
> +	/* Update MSR_IA32_EVT_CFG_BASE MSR on all the CPUs in cpu_mask */
> +	on_each_cpu_mask(cpu_mask, mon_event_config_write, &mon_info, 1);

If this is required then could you please add a comment why every CPU in
the domain needs to be updated? Until now configuration changes
only needed to be made on one CPU per domain. 
Even in the previous patch when the user reads the current configuration
value it is only done on one CPU in the domain ... to me that implies
that the scope is per domain and only one CPU in the domain needs to be
changed.

> +
> +	/*
> +	 * When an Event Configuration is changed, the bandwidth counters
> +	 * for all RMIDs and Events will be cleared, and the U-bit for every
> +	 * RMID will be set on the next read to any BwEvent for every RMID.
> +	 * Clear the mbm_local and mbm_total counts for all the RMIDs.
> +	 */

This is a snippet that was copied from the hardware spec and since it is
inserted into the kernel driver the context makes it hard to understand.
Could it be translated into what it means in this context?
Perhaps something like:

	/*
	 * When an Event Configuration is changed, the bandwidth counters
	 * for all RMIDs and Events will be cleared by the hardware. The
         * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for every
	 * RMID on the next read to any event for every RMID. Subsequent
	 * reads will have MSR_IA32_QM_CTR.Unavailable (bit 62) cleared
	 * while it is tracked by the hardware.
	 * Clear the mbm_local and mbm_total counts for all the RMIDs.
	 */

Please fixup where I got it wrong.

> +	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
> +	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);
> +

Reinette
