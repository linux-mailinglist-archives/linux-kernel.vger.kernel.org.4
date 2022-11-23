Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22060634B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiKWAN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiKWANy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:13:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C541B58019;
        Tue, 22 Nov 2022 16:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669162433; x=1700698433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=et6fJCiXH2Mm+t009UaOO7np9jbk6DK0fjS+oiL35QA=;
  b=fiTBjJ6J3nGQN3Mf47gVwOJAXqUnh5BFASzwMN0gz2vsgAjIjGUGrAGP
   oJJu6VMmMpeWE+6jULBu6LTEJY1UaRiQsmVAXvTYIQpgHCw8mKcDJJ6+1
   3z6i9Uwqx4EkM6BTkQMxABgcEaaA3zv8NITKgcbeViX/rjWvDfqU9g97L
   1LovqQeTsSWdTR72xNQDA6Qfpp61u7piN3do8Oaf+m6CEnwS0i4SmMZwF
   kYe9eiRqw07m/xWJK0hPIBVF4dLO+OnhNvgVqPoDJbN77O3oAL8iFkiAS
   TF1RIZWAcM5AvoXLSlQUCSFNYvUrr+sxHK+xav1YTLT9h7141ZyHJ2AOP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="313977591"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="313977591"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 16:13:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="970663887"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="970663887"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 22 Nov 2022 16:13:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 16:13:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 16:13:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 16:13:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PD0re9qsLdcp0U/eiYnxzFeN55jarF2RanyszWnHUU3OCyCf0paXv2hlLJNJKilebsyJx1F650kBxTZhR64AH78a9JODQonKEFYDhPrTWItAbAdujTL4uDNfqpLjpw7C/ChMimNDAVYlfHF1walQExgKyTbti87IdlYDADZUWQuxx03E643RMiECHv8yuxi/MG8eW2Mh9MDwTXf11CXeTpsDnphjvWzEc46MHyRFxsKqtA6/iNlDjP2YtxCmxADwfj18J8/exjd/3towYSyjkjRYII5IYZBR1PHy9UFrKYw/tbNo9Th/h/F/McRKBmky1AQ5rZMuYdTVil4mOYaxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et6fJCiXH2Mm+t009UaOO7np9jbk6DK0fjS+oiL35QA=;
 b=C064YGlGGZdUjFH3Eqs4Oh/oNzGhQod0e/6A2e09lk5b0MYdMRfQdlAatUkfcVB5IiVFaXg21nQ543CgT2Kb52xdxiohw2HXc/YllA4NA8IWiw3jqNZBwKP6JVGKAN+gTf8kM104pJa7lw0kG4esQ3epVUnf/1EZq5/bKoOKDU1+RlJe7cXN+UlAsaaWDKT2kA6VAAty/yVJ83kpf0aTbB8XGK4svGlHFGDN4px54qdFq5Co1/YRAax42/JY30nfQ+6a0ANM7sgMvGjdEKF337Dapw4caqX/PZHkChW4QtKm8Yg0/NZX1JNEx0QWjMhUs4/5nGn15wDyGuNkJEDRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH8PR11MB6949.namprd11.prod.outlook.com (2603:10b6:510:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 00:13:46 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 00:13:46 +0000
Message-ID: <8ad235bb-0cd1-184e-9b83-2f3630136ef7@intel.com>
Date:   Tue, 22 Nov 2022 16:13:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 06/13] x86/resctrl: Remove the init attribute for
 rdt_cpu_has()
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
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759203614.3281208.12929995949176975687.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166759203614.3281208.12929995949176975687.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::10) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH8PR11MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: c15087ff-911d-445e-aacf-08dacce7965a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MlcdXKQ9z1s2mmXlYpGGq9xzV2Sun0KUJlRpuJhup9OiLZpcF6PpKShQo+jq3XQwesKVsm42FJfHmePCFRb4fmrz7kTCHbwrRSMreWwm4Kp3ceJN+wkj/189Taxf/5X+v1TPVXg4YzbdZYAlJlrxjn3KcpagviaNIXMQgN+UYlEGHyx8n6Q/OYYU5R6v6c1BhaDIpW6NxkLuOJrP4zW1+riGdTnhFmyMUCV1rekMkktktoNTN1RhImWPMGDzwpT7ITwdZwk+bRP27VRdRaZK+M3fwQYyxF6djk7o8XNrmmawaTHMEHXsbJ5J6OxqD4MzrwMv/2ETiq5fKARudFSjHwvoi3/0uSlIjH0gOMvOXI3rFj4VEcddcSrobmbsCUih0Cb1GzL9cMIcFU0nUCZDOIIbRnsxjnzX8KItOzXQQ/7e66uSZRMTxGVZ5WosbIwIeuBYRbKZ8ynC/QEGSCmsNR6/3pNyjfehlvFeLbBzvfwtboaOHOnxO8Ars/73cj2ErvD3I5M7Ce1fWRerQ2W1GUmv1ZyI3/YAkQMd36ZkMegYtjPRJh6ROsujhvVglLQHTXnHqHedNtJN4jP8WROlifF3EA5slep9KA7XTEm4NpKP2oNTYJyPWUqSZzFHqdB9HfqDqyK7S/G4KBbyh1OYXCdNGx0T26JKXxji1A4f1+DVJKfNFJ8NhL6dUpHV0O9h/PNTel1Z1/2mDF37bV1hXiWNY/5jFYwAXi4Ys5FiBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(36756003)(31696002)(86362001)(38100700002)(2906002)(4744005)(5660300002)(7416002)(44832011)(8936002)(186003)(83380400001)(82960400001)(2616005)(316002)(31686004)(478600001)(66946007)(41300700001)(66476007)(4326008)(8676002)(66556008)(6486002)(6666004)(6512007)(6506007)(53546011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXBjUVpiaE9RVCtvMTN3RWhZWXhpWGMyY3lITU9yaHBpN1MwVVNUS05CYjFW?=
 =?utf-8?B?ODkrdjgvWitwdTFaSHU3c2xHZ1RHNmw0YTlYRDhKd1YrVmMrME1LaVc1WlZk?=
 =?utf-8?B?M05qWVcxRCtCK0hmdmpSeDNaS29kM0lvT3BLUDN6amhzQ2JVN3pHWWozODRH?=
 =?utf-8?B?dndsYjI1YXpMbEp6NlAxbkMzc1d4RERoSlZzaDhyb3lyNEVvTC9yQ1dtaTR0?=
 =?utf-8?B?NGJjd0lSOFZvNnpVT25HQ2xtaDkvZytEUm5aSVZ3cldvanRMSHVNZ2FURmFr?=
 =?utf-8?B?QnluTjdCT0lid3J3MEtCY2xVTmxudjJaM2xSVlBQSU54bnZtSExjOVhKSWto?=
 =?utf-8?B?NFhYVjhNTzJSVEdHZjRHUlhweFNWZ3l1SmZ6MEtYWnFUMnBvM2tvUU1ndFBM?=
 =?utf-8?B?NHdlMFlxTWtZWlNZS2xKckFmeHpxQ0VVOTh3QytHdGgyZTRMeXR6YjJXaU5j?=
 =?utf-8?B?Wk5IZHpGVjdKY20rcytaMVU3cXVGbTRQYUtxdmMyK2l1SzRiVUt3L21YNUpr?=
 =?utf-8?B?YzBoa2FmSnJmTnIycjBOL2E2YWJnb2RvWVJiS3lBdXFJYzhsMS9aM1ZkNzM4?=
 =?utf-8?B?VDhOYUU1dGZwYVRJSHBZbEl4WkhNa1MxT0w0dzFWZzVINW5TK3Rpd2hrNEcr?=
 =?utf-8?B?d3JYUlJFeUdzOTUyWEtCWmM0RGJFbEtuczdUamJtdkRxZFEvczZNY0M1NVo2?=
 =?utf-8?B?R0VlcjBVODNXS2l4V0VMRVE1TGU1cTBlTGxqcVR2NlMyd29aUUoyeEJoeWtS?=
 =?utf-8?B?ZUZzYnB1d3dnb0tzSExWTXdEMXhJY1dMZ2JzUTFtVTZpY0dMWVdMRHJ2bVp6?=
 =?utf-8?B?RzcvVW44SEFyL3hDaER5OXJEOFZOa2dWNlZkYlVyUldMNGVJY2JZYjFaaGRs?=
 =?utf-8?B?eVB0TGF0dXNESEFtWS95bzBlYzNDbTV3SDlGQ2dVMlM4OEROcHdFYnJUbXVa?=
 =?utf-8?B?UG9MdHgxb0M4MStzR3RuRzZWUTA0MFBwNXRqQTNOYnVLblU4OFVoT1F2bVB4?=
 =?utf-8?B?RnltM2pkdXFOM3h1SkZJNGlDNVh3RWRWUnZIUkNPWFJtbHBGaW5DdVZkbDRM?=
 =?utf-8?B?S1JENmt2SFpURnBGUU9xMTNpQTd1RU4xbFBvdHh3aE1iSm5rRHFrL1ZHYXQ0?=
 =?utf-8?B?VmtubENYa3JBOUxHZUltSFhYbXRKa1VNZDFzdWExQkNLdHNNeDczY0k1MU1t?=
 =?utf-8?B?ZTdzQjFUZzFodXVkc2Z6YTNpT1p5M0ZKVmxPYVpsVlVHQzVieUI4cmhTVnlF?=
 =?utf-8?B?aDR1a0VrV3U1OEdmQVBWakdBQzUrMzNrY2dESnZkcmJacGZWbFN5QnlkeWJU?=
 =?utf-8?B?S0hLYUJ5Ry9lMSswQlB3YU5scmdRY1U2aTlNc2lRNVBlVG9QMExyWGt5SFJU?=
 =?utf-8?B?bzhqeWtycXMyYW9iWVpPN2pWUWFvMmVTZmt2eDJYWEErc1F2TkV4MHo2QnB1?=
 =?utf-8?B?b1B2UE1mU0xycUhaaHVVdGZmZENzeEFKRzVQcW9MT1psZUhNY21GcDFmL2Rs?=
 =?utf-8?B?KzVGVzgrQ2o5dzkyc0pzbEdQMnE2ejRIdnNzd0NFM25NS0ZKRlJxMkRXejdO?=
 =?utf-8?B?OHMvVHgwTVdRUlltV3kxNk1DNGFjU1BpenRpYnJWUlNsUDVhdFRFTllSWEV0?=
 =?utf-8?B?NHpCcjJML1RQd3g5ZG44NkhWbWFpa1BMeWVJY0dyMXlVTWxKRTdPUzZxSVB5?=
 =?utf-8?B?SFpxN2dUSXhiRkt2bnNWb1ZvNDB4SXEzMkNyN2xpa29KdWptQ2FtS3dMUGJ4?=
 =?utf-8?B?dUw3TnU5S0lUOHZ0aHpPeXJBTmpjWTVEK3pXbXVrc3NkREllZ0s5RDZndE1C?=
 =?utf-8?B?QVdVRk5qRmFTWXRoRGw4ZFExSFhQQlpBNjA3bG15ZFRYazRveFZncHBaUWE0?=
 =?utf-8?B?NE5wU2NTcGJVSDh2S3BpMWg3K1IwYkNPcWxFQkw1cE5IZFZHSmw0Y29OT3Jr?=
 =?utf-8?B?Z3UyV2MrVVBCcmpnT2UrbEdBb2cxNS96S0p5Q21yWURvOHdzalpydlZlVEJS?=
 =?utf-8?B?UEgvSVZNdHdsVWp5NTl2SHVXeEFWRmpUbEVYL0d0UjlHRnFmdm5MS3Y4NEJT?=
 =?utf-8?B?VXRhcWs0ZGMxWGVUTnpnejk0SUxXWnlPU2thYVFRYngyc1doTS90ZVlDVDdp?=
 =?utf-8?B?eHVKUkdhZS8xb044T3J3ZzI5bllldUhiTkpMNnBHMlJnTy9yR1VIcnZ6Mllh?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c15087ff-911d-445e-aacf-08dacce7965a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 00:13:46.0882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLPhanKAtKYRxWk2+HRHCzuUllovT45OyiqjAbxYDVUTgOhq5plVoCPngmaCfnYushNlEiiEBDYGUvj4nLFsDue17g1aIgmzuFRTrkjYKt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/4/2022 1:00 PM, Babu Moger wrote:
> The monitor code in resctrl/monitor.c needs to call rdt_cpu_has() to
> detect the monitor related features. It has the init attribute and
> cannot be called in non-init routines. Remove the init attribute and
> make it available for all the resctrl files.

I think this is the wrong way to go. The rdt_cpu_has() callers are
init code and they should rather get the __init attribute instead of
rdt_cpu_has() losing it.

Reinette
