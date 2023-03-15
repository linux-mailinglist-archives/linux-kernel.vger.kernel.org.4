Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8E66BBC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjCOSeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjCOSeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3212704;
        Wed, 15 Mar 2023 11:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905251; x=1710441251;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VAsRDdCp5YyuKKi6mRMVdMirmQOzT171V15xscLCPpo=;
  b=m15O5dRN/S/WVwiJNV4FMK2qqdibZg7Umhl0D1jvUvr7TCOW6zd6jOcx
   lRguMJNJ5Bf8yY0Xzw9zHmgoKWQ7oEWtPdN9DGKTRBjk9ANnFDenxpMcd
   32ql/3piTuUoNMcWdqcT1qBFGZv/dyeiossyX71sbZNEZXjtEUjhVKtnz
   0uAw0gZmg3MAWsQQWCDPg3fp5skELwRIaSbReL63jvHbuCP9xTgtWQO+b
   oLCbKvtOYKStN2vMxM5B1QaBopY5hspgN6quPAWW6b2ZyRHmt999CNN4Q
   HfQ/R96TtyVu0ylyF3d46ndHTe59C7x1nNuhrZVAoc6g6SU2M9mvPvXzI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="317444407"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="317444407"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="656876643"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="656876643"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2023 11:34:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:34:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 11:34:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 11:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iv0qHN8AzuuRtLp6MG28lXcp1R2RWbpIme10KRC+7IhU6l4mJL8Zd5lSioijpepuFuSEdutrCWD1XBZ3JJa9YlX1+bdthgoElgKEQx9ClcFPA7ppZUZ59xm+UFPneTM/yoS9mwVM1YANBzCxdIVre21ZHY9riffSLh1q7tJTiNDUEwvtcqsz4HirHaDlsNyajwhDcurV0uL3f4FFd/z6L68fPSjmEzxOEekSRPoSUDzj/5vbA9JrWLtzBFGXsMOpmU79sYdE5hwhT88KiWS1M3Le7bMaCDQuAL63BXElOWL9OvCUkf/F/oRZvNyhm8MOK5f4JTj5aQpdBpEYcW6uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnjLHBypvAZARMlppMXO4Z8efh7cvmtibAed+K22ClE=;
 b=j9gBHln8bqHUuyB+YsUID9MCCfxhxzGATvPz7dnEybMMBV3p7cg0ATlwwSCDWVgIDcRD/LTiHNO1ZogJvfO7OczG5eKxLNZ2u6sQ9hHwzsiucMcATiOOu71ho+td4ucnJqGhZ5LVhFir6Am2AvX25WQSH06TSYQr9X2PEdxA2XZDS/t2s5ItHjPdyy1CIzLUBa7uMjC6bGb8ShRhNdZJ27kdX/OnCuUo3jWzeBl7QhyECHy7oMOMNPXT1f4DsskTTCrJ2jLd1jj1V6SWXzxJs4p+XRrUVBkg+/8im3OxIbtG9zMhXB6FPOzT/yB09l9mUmpOFtMTYaW1gWu/h0ENdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA0PR11MB7814.namprd11.prod.outlook.com (2603:10b6:208:408::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 18:33:47 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Wed, 15 Mar
 2023 18:33:47 +0000
Message-ID: <1a45fc82-9339-d086-2e70-27fd91906b8a@intel.com>
Date:   Wed, 15 Mar 2023 11:33:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
From:   Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v3 2/7] x86/resctrl: Remove few unnecessary rftype flags
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
 <167778867236.1053859.12920879751317268318.stgit@bmoger-ubuntu>
Content-Language: en-US
In-Reply-To: <167778867236.1053859.12920879751317268318.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0300.namprd04.prod.outlook.com
 (2603:10b6:303:89::35) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA0PR11MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: deed0765-f635-4cc7-a8e1-08db2583d076
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Daqq08sdfzTC6tqwbrBnNvJfUkLfeP6fyK0pRa68tnsJtKB7IMC5qQM7unQNFXsF34bjsfdxmxJtFHf4c4W0KYf4tqSlJGiLueQXYdSUGVgdhNWd8Va1Y31KkOtuFQLrTnPAd+SPzWyAW/Pv/xyAobW/WLSnEKtOTAtdQeHKquuC+kJ7iS1wmJlGT5qLu7WuAkG1N4Sl528U5syaT7D8H8ejj1x8mkH5bVaEZ36hNSX6TFH4G6d9cgMMbUpXqD4xN904JBg4rKbTx7n3iUbJ3+29TVzbJdhdvrmw7xfO9LVx9GS2bwnVgza3Dntf1wlt3QJ1je2TCVl8w++iqzqQ0UP8kCkU2baezkkEtZHV/IMQYCxOvrr1nnDqXpyxlcjxRnVfz6WSWmH12frXMBBFCXZ18yMsEOTze/mCUPsHd+UbYA2NUfv1Y7RxUWqZ4l6LivgcJDJQL+UAHZJPKi/BkJuOwXnFYkyqlh2nrs9K5JHRrKQulDPigpbSeaVCe/yxXn+f9LH/7ZcdHtVVu7sL3ukBfDaQNCmsYSc+0rZ7YDtmwOelA3MsU0xGZCxLhlgdzrced1diWb8WVMLhLE1i8M77aT3yIJyuwjsuo1cXufJuWCze2ldOxM3p6Ce+CVZbPVNFew4dLBLN5cHurY8I9cikHV/E/pBB9O9segGVboteYf4ibPnVWZdud5ShYotN0EAwfyz+06uz+EVUURt7rtUaiuggOxyHPUszegfBEYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199018)(31686004)(36756003)(41300700001)(7416002)(7406005)(8936002)(4326008)(5660300002)(44832011)(2906002)(38100700002)(31696002)(86362001)(82960400001)(478600001)(6486002)(6666004)(8676002)(66946007)(66556008)(26005)(66476007)(6506007)(316002)(186003)(6512007)(2616005)(83380400001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjZTRm55M0VpbEc3REx0Mlo0VjJndUZGU0E1dHhKcXlVTHZuWmdMK2ZUT1I3?=
 =?utf-8?B?UFFVaWE5K0JkSi8xMjdrdWlNKytWcTRYK0ZsV3BLaVMwUnA0SXpaaDI5Mi95?=
 =?utf-8?B?SnlvUXQyWXNtVmVlMTRVbFM4VmNiYzVwK0ZZT1VmTElmR0xCak5uaW9SdTg3?=
 =?utf-8?B?aUFlMXlRS2dXK3JPTDdQWE9lY0hwN0VNVG5pRWRRUzZzRUdGK3JBdzFSdVBP?=
 =?utf-8?B?cUY3RkFVQXkrbjBtT1I3bDRwU3AzWGxGb1hnZEpYU1J1V2JOWk9kVklxRzJi?=
 =?utf-8?B?azM1WGZaWndXVUxGeGpLTTE1Zm1Ta1dqRCtyZENWakJWZWhEb3dFbk1qc0k0?=
 =?utf-8?B?WUJjZTBVRU41UE5USFdPclU3bmZaSnA4TUJsK3hDUDliYm1PcDEvalh1ZWZL?=
 =?utf-8?B?L1FSNkc5S0hqV01ZakpVOW1YM0tOTFZMS0FDWEVEMUlxamRuQzNuc2N1OE9m?=
 =?utf-8?B?L3E0YjcxMjkrbjlOMi9PRW5jUTByaTVIczFzUVZ0TnJFRUxVbnRKREFyMkUw?=
 =?utf-8?B?TCs5cUpTVFd0UUFRWXRibjFyUDVRR1lJbzFsVVNudEpXVXo0clhNd0Z2R2Vi?=
 =?utf-8?B?OTFlQ3ZDb1NmY3R6V1dCd1pqOGhkWWlnb2R6aURvS3RzVGlWUVhNSkd4TUNR?=
 =?utf-8?B?R3VKeVlXZTVNbzB0c2xYRm8vYXgvbGlCL01FZ0Q0VEc2bEswcU5kYmdLRGIw?=
 =?utf-8?B?TVRzb0FsWTd6UFdrVkZoSjdZM3FLWXVneUE1cHJIb2JuM1NkSVcydFBVUzF4?=
 =?utf-8?B?UytBSmJaTlpDaWwwRVRjMDRuNGIwa1A4RUExUU9EVFc4N1M4ZUxqU01KSmNo?=
 =?utf-8?B?ajlJODlPL0hvb3Q4dktOVUdWTjRKWStrRzBEWnh6NXVwV0RJeEgranpXMVVu?=
 =?utf-8?B?K3poNDY4YXBRSGxsRzkvYnk0a1NUaWp5VElNVmErdENkVkUxa0YrekY3WDk4?=
 =?utf-8?B?eVdCNEE1Tk1MOGc1UzYvT3oySFVENjdkWXQ2akF4VUhaNnNaOVQvbC8wUWFR?=
 =?utf-8?B?dzFDK3FlajFPRHhERjRWck93RTRaVm04Lzg3NjBrZEJ5clpDQS9QSjl3azhV?=
 =?utf-8?B?YkhaRzFwL3lFbUs5aXF3TCt2T0luMDV4MUdVZkJnUkJOMjRKMUVndDZWamdi?=
 =?utf-8?B?elVkbVhwcGd2QnkwWndybEJ3REJ0aG9rTWs0YWE5OERyNi9IUVBYaGx0QkI2?=
 =?utf-8?B?R2dOL2pRb2haMG5OM1BrT0wwcHRoRWNiRXc3YS9VRTJSSXRBcldmM2hQdUNx?=
 =?utf-8?B?OEF2aWFWb1hlYnhXbEd2d0NjQVYrdVZ2czFkSW0rQXdlcHd1dHpGSmRBd2hx?=
 =?utf-8?B?RWtmYWEyQzZySWF2WkZhcDN0RjREUjNwRnlldkhtRUFFWXJ3ZUM0SUVWTGph?=
 =?utf-8?B?c1dZRzhQT3BxRlNIa0lhdWQwTlNPMGhKTHJvM2IyZTNDRFJRdnozY21ja1NZ?=
 =?utf-8?B?OWhTVFNWTmZYMnY3K2RoVDJoSHoxYTNVTFBPSGF0RkZrM3BaQ2lCTkV1d3ls?=
 =?utf-8?B?NC9qbWtqTVJ5QUpqNERQNVgxWUdUQnVub1JiYW53NnVsd2I4UG94M1V6Q1k3?=
 =?utf-8?B?cHhubmpzM05jRk9ianUvYWZUUnJLS3I2WHMycUF0RGFPM2tNd3dTNEZ4b2Yy?=
 =?utf-8?B?Y1hTRXdZdm1DQzJmZ0J4a3ZubFlhQ3JCWTdvZU1qem56dWJ2L29ZaG14eDdu?=
 =?utf-8?B?TXl0MlNQbGtUelpGM0l3ZHpVQjFBNDBBZGMwT2l5K1g4VkRPMWlubncwalN6?=
 =?utf-8?B?TkdXcW9GVlloSzZGMW5FbHozMlRzNndiK1NCY2tZUXA4cXZKaXRrbjNqYjhB?=
 =?utf-8?B?YWozTFVNVUV6cmJkSTFQakRmWTljMzUyeGJCT2RMc096VC9PcWRlbkpyVlFh?=
 =?utf-8?B?S0cwQ05NYkFIb0xGMFRkRlNCb25lSzVTVmNNYkNGQmUxNWppYUJYTkgzdmky?=
 =?utf-8?B?REdkQUs4OWozZXdEdnFnOVdLMmpDSGV4SU5YQUNienBIZmVWS3kycFJudjVa?=
 =?utf-8?B?aFBISlN6QUgvdEJnSmg3Q0tKYWo3a2o1WTF4TnVuVUNSQ2NRNlcrZDhKcSti?=
 =?utf-8?B?OWVYbHVrT3JDWHpVbVpWUDNpdVlaNmQ2QzF0KzN4RWhWam9EcnJLcEc4bEJX?=
 =?utf-8?B?eWhsTnJCdEVoak5NQWY1TkNwK2V2N0xhcGsycVd4QUwvU1ByckJWOFU4T013?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deed0765-f635-4cc7-a8e1-08db2583d076
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:33:47.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9XAPFn/aaP2TLXKsJl/2pCNxSWK8PDARD0OZTtqVLOTpwAe+vD3bnA2FAdqAAQN5Ae70gG4lXKBfD1ZWyvAS9e6TQu4Yq/6Uf/KCcyyiwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7814
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 3/2/2023 12:24 PM, Babu Moger wrote:
> Remove few unnecessary rftype flags and simplify the code. This is done

Please drop "few" (here and in subject).

> to further cleanup the code eventually.

Could you please be specific? "further cleanup the code
eventually" is too vague. I do not understand what is meant
with the second sentence.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |    9 +++------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   10 +++++++---
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 8edecc5763d8..571145d75d29 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -243,12 +243,9 @@ struct rdtgroup {
>   */
>  #define RFTYPE_INFO			BIT(0)
>  #define RFTYPE_BASE			BIT(1)
> -#define RF_CTRLSHIFT			4
> -#define RF_MONSHIFT			5
> -#define RF_TOPSHIFT			6
> -#define RFTYPE_CTRL			BIT(RF_CTRLSHIFT)
> -#define RFTYPE_MON			BIT(RF_MONSHIFT)
> -#define RFTYPE_TOP			BIT(RF_TOPSHIFT)
> +#define RFTYPE_CTRL			BIT(4)
> +#define RFTYPE_MON			BIT(5)
> +#define RFTYPE_TOP			BIT(6)
>  #define RFTYPE_RES_CACHE		BIT(8)
>  #define RFTYPE_RES_MB			BIT(9)
>  #define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 15ea5b550fe9..3c86506e54c1 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3163,7 +3163,7 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  {
>  	struct rdtgroup *prdtgrp, *rdtgrp;
>  	struct kernfs_node *kn;
> -	uint files = 0;
> +	uint fflags = 0;

Hoe does changing the variable name from "files" to "fflags" simplify
the code?

>  	int ret;
>  
>  	prdtgrp = rdtgroup_kn_lock_live(parent_kn);
> @@ -3215,8 +3215,12 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  		goto out_destroy;
>  	}
>  
> -	files = RFTYPE_BASE | BIT(RF_CTRLSHIFT + rtype);
> -	ret = rdtgroup_add_files(kn, files);
> +	if (rtype == RDTCTRL_GROUP)
> +		fflags = RFTYPE_BASE | RFTYPE_CTRL;
> +	else
> +		fflags = RFTYPE_BASE | RFTYPE_MON;
> +
> +	ret = rdtgroup_add_files(kn, fflags);
>  	if (ret) {
>  		rdt_last_cmd_puts("kernfs fill error\n");
>  		goto out_destroy;
> 
> 

Reinette
