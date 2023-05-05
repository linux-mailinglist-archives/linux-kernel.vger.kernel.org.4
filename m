Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A66F8CC2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjEEXVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjEEXVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:21:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E565B84
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683328865; x=1714864865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9tpnXQjAfQYUv1p5QdZp8pMu3E9b9mSfJ44CrTyV4u0=;
  b=eRoSRSuZ7ZADvU7yni8FibO4La0IoIt9AM+CbjdFp5ytAhCSbT1O9BH/
   99nkB2dy+n0XQ74feJjQlQubhYo4oZickHkIiwFvebONmfaA9dUoY1bH2
   EVUMinFFXm0A8Z5qbUd2Gcj4lojSg8r1nHH6mODQMeSy6yQQO38ywpEKt
   xGPpNQOE3RHOJsOfMukEH4FwhZ8r/M+bMtVwSDSjtNcb7Ql18KrEuPsUY
   ANwnCsv2LB4HI2hNHCILUK7gbJLvMNgCDVCr8VYPZ0digyAx3Q8Ihx5Q5
   w2FnNc50A1GSNBYYmVkv3nqs/RjhyZ/FXT6FEQ+j6e4Ys5YV3WR0cTCQz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="351464108"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="351464108"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 16:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="648077674"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="648077674"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 05 May 2023 16:21:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:21:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 16:21:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 16:21:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtGze9aoSM7z0e5xdBBKgU7E/JiUwxj95Mnvj6wxKwEAdw8eTrhlSQpG0XWpqd8Q+5tI0bD0AvrPg3+0mIwT06r6S0MVNE6iEObeF7jOydXJosKW2ht7NmIl4lPO1sJqMSL8lCMizNwsllo7i+X4AMKCtShYJb69jrMev9VJaZ3Z30g30Fq27+vpjn3jsZslYj4zql3Qi6yw13Pa3uQLx00YMJYoKqr9xGOqddkA5ybRu8uDM37UVenjkQK0orn05+R0u+wBhlWNJH/QEdR4dZySdgshgPZgecxiI/0YHPtM89Sc05edUHWjmZZ9lX3sxxCikq9dadyPb3vQJ0jtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLlR5NwIwxcfnaBqBC7bwEyl7GUrQ07j/P/iqUs8aPc=;
 b=NSGqDx8H8M5n1AzBpa9Q4YrIubMKgzCvIJme31ppZhz04aJzitB63gXxPhVe+W3I8rTD+Wwjx5RKKONPLrFZhWFakkXtOgamUxsRPUJTa5llRnsdGB8nTeWLMuUsLPBzZF2L+XVjcqhhOa4n/MmceBCWhg/QvCpqSbvYoP518nUgggpOPwiOAEkSbxcRTe/GQhvOVS3FaVxzzQR+rDuvvvRVTNyFnHREzyZCBReUCp5JfIBeibi9YdLLHmEThEjRXLaROsju5m6oCJncd/PgEJZfc9tg7vZiKy9zMvuHaczyCzmXev/0ZYgDT0tZUEMdehygFaJu3dw2ERj9HB6mcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 23:20:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 23:20:58 +0000
Message-ID: <81a32a39-217f-0b4b-beec-46d909b41303@intel.com>
Date:   Fri, 5 May 2023 16:20:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 6/7] x86/resctrl: Allow a device to override an
 existing schemata entry
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <20230420220636.53527-7-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230420220636.53527-7-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0067.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::44) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b01598-4273-4e26-db91-08db4dbf61fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgd7olWNYTLczjZsJsXjnpHrYle48UZL0kK/Sox3bMHKC1BHPud5mMUgIKYF+tLrpRB5kDJHWtlTX9b+fm10M6KiN7S2wGIz0IXikbGvZAT8/dTxXPegNRB02G7iD4wLlQeTXKXIF+C2UpRy8txqKbKN/0ArirxP/LHWQ3G1/PZZSbwJwpirZ0AstMqv6I4Hf/9qXSF7HDt0cB7QUgMomWbhLZbI/cnXnkR5CDNhAgNvD3cqxWcDzvmz0sgpm0U7sQKL+IkewoDudQCnM4T5Xd41SGeKna8fmDx5FoKS6Fi+27C3GcVrh/zoNl5cadmIDgYJOlVhtA7I42NMFgmKnBLJmkkSstx1CfR3WhCZsoaAYRnJJ4oyc/CW9Q7ITpnY6e6JAr1fT3M1kPNKH7zhPtt3aEAjKoBKkdKoHeuRIQUeN0EAAgYODaPyAfsRylbVwudcu0WNo7c8DsBrATVBtK4Pz9krTHn6bnioKkp+sgtZPCuhUq/kMjNbxfB4vaovsA0GBFuN83xI2/yXG6JJI61dRhvklGJFrJKttGm43gHrbS3tMQmdgUHKZjeVCVld2OOVWZ0S9iZZ/lMflqpr67FM5pIedDloD9jzQsdCeA0DZ2mEQBV1dffDZA6N93MwQLPHLFck1RbsH4++e0Bnj2kotP+Nb8lEWtkUNTpFJTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(6512007)(53546011)(6506007)(26005)(31696002)(186003)(2616005)(31686004)(110136005)(36756003)(6486002)(2906002)(82960400001)(316002)(8936002)(5660300002)(478600001)(4744005)(4326008)(38100700002)(7416002)(86362001)(8676002)(44832011)(66476007)(41300700001)(66556008)(921005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0NxRHlvcHg1Nnhva0hxNSs0d2xoTEhtNzVaU01iQ3BvNy9jdUJzaFhTTEdp?=
 =?utf-8?B?TFR3d2g4SUVLd0ZBQWFPRW1iT1Vmb3pHVWVMZmpCWDFTVWFIYW9uN2lKTzRJ?=
 =?utf-8?B?UWVIbDRobjlMMjE2QldiclBCaUNZY2tKemxIM2xSZ1dkM2tjZG0yUHQxZCtU?=
 =?utf-8?B?Q1p3Nm1sQUxjV0h4dHhrMkdqeXhKeVlTejZ3SlVJWmhOUmlzeHR5RWUrczBK?=
 =?utf-8?B?RkF6MnViSEZEWUlRbzBQbSt1ZGdubzVRK0I0NXRuclpCL0NhZTd5a1JweVF3?=
 =?utf-8?B?N05QSlhFdlBnazEzSmxXa05tSXk5VkFhRjlqcWpmM3NPdk5OWFRNR05YaGdx?=
 =?utf-8?B?U3JpS2xVMGxHdEtRL2hldEQzM2dhUW1uRmV4RGt4RUs3TzNMVVliZFJDQVJu?=
 =?utf-8?B?RXJDdVhlMEREaFF6RUxqTCt0Vmd1cnFrZEVGZHNkSmpMSWduaTM5dXBNSm1h?=
 =?utf-8?B?ZUFxb3c5UFhMSFUzRnRnb0t2clpUSTdqbmZLL3dPV0lYMVNTOU90UnVuWm14?=
 =?utf-8?B?ZXlYOHQyRFVTQkxYaUtxdWhmZ0ZhQ2NCdGJ1b3AwMEJNUld6T0dXRUtJRGpH?=
 =?utf-8?B?MERpUi83RTAvNU9kdklXdFFtK2FtWHo2TC9jUnNBT1BPMW0raUsyNjZNblFz?=
 =?utf-8?B?b1VoTVBhV21CRWU3RnRvS1Jpb1RPL3dYdHdTVFJtbFZJcThQd0gwQmJsdGtH?=
 =?utf-8?B?OUFKTFVWM293R3cxa1BscU9kWGx6WFR6Wmx2T3Y2YUNxUHhrMzNaWDJFMFVq?=
 =?utf-8?B?Qmh2b0pTckFTK0tFRXJmN09ZMGxHTnRqZXY1MXVMQmRxT2ZOUDlQdlVjaUly?=
 =?utf-8?B?TmFOSllNSzdWYTJjOU5UY1puYnJmS09YUEZTWEl4WjNET2NEelg1WmswSjBo?=
 =?utf-8?B?VWtJTVQ1OWE4bEFrbjE3ZThMelhKcUxvVURucUtwVDFodTRHdmFYcW1VK1dj?=
 =?utf-8?B?V2RRRlF2WkFOZ2ppS2JUZmwzUmFibDZLSkpneUdoU2xSSFZXVmZnOFZWY2xj?=
 =?utf-8?B?RkY0blhwRkZsalF2bHNOamJ1TDJ5WFRxVjNmWVE3ZFpTTENRV05ZNkJCWnVH?=
 =?utf-8?B?KzdmZDhpeHpHZ05yU3ZjYkdtd1grZThSMm5nNVRZa0FnVTRnTWVmVzF1NzBz?=
 =?utf-8?B?eUxDNktTWGFvWVhBemhBTzBYOExSa1pKbVBGVFBScFFXRGhnZDgvSUUza2o4?=
 =?utf-8?B?QjczNWFJaUFHR085Q25nNFBwT2d5YXZnR3ZMcmdwaDZQZmtUbW5RZUJmNmw3?=
 =?utf-8?B?V0d2R3RzSUNWc2loUTk4VmI0UlI4aVBkWEQ0WDRRaDV1MnhYZjRYb21QYW5p?=
 =?utf-8?B?TU14eVNEOU5RYUlqcGRLK2lZaXZZb0JPSFNQLzlkOW1teVZjMXZhM25EMHlt?=
 =?utf-8?B?a25OM2piMXBFVmR5UDZadzNlSG1aWmEvUCsxeFR0NXBzS3dLczNOdG93M3Jv?=
 =?utf-8?B?UWNsVEVzdUhveWNMb21qRVdvMHZRVUhnNWJDc1B0ZmwxdE1zaVplMzd0VlJE?=
 =?utf-8?B?L1RYZVVtZWRUV1dhdVkxaWFNZmRXZmd6Vm05UDZuRVpVcjJRb3B1V1NCL3Rj?=
 =?utf-8?B?ZEEzUThzRHRyekN4Q2c1bUFaMmlJWHh6V01NVlB1TGdKUjdJNnk3WWgwYzBO?=
 =?utf-8?B?c2RHNVdoTTFvT3NaTzVKYURwMWEzMHhTSWtYZ2taSHEwMVNyUWlJOEc3Z0x3?=
 =?utf-8?B?WDJFcHV1TGM0QWRZOCtqbXJFbytNMmZ5dkhiWmxTSm51V1c4eW1NWTZDQVlO?=
 =?utf-8?B?Y25lSFJDWFUrNEJ3WFRSK3VJUkhySHNIWjhRMzZNL1dhdE94VnovWWUvQ1Y5?=
 =?utf-8?B?RmVvY29KeHpEa0c3UElGYU44U1dGZEVGeDhMZ1dSTkM4d0ZZNG9mb0IyN1Z3?=
 =?utf-8?B?RStKVVppS0tkckxLV1VGRnpoMDRVejJCQWJONHNkN1NKTHIxRTMwckIzUWUv?=
 =?utf-8?B?Y3FWdVdkNjhkNC81WnZ3M0hMTEhpTWpPOERWZVQ0aEs4dFA1RFV3TEEvNVh2?=
 =?utf-8?B?eW11MjgvL1Bicms2TURUbW1VVUhoeGlVdHBwTTJvL25PWG4vaFUxaEZ5K0M5?=
 =?utf-8?B?d3Q2M1pCR21TS2g5ZFEvczdNYnNQbTJPYVlFNHIrZHVBb3FLbk9OSkZ0MUVI?=
 =?utf-8?B?VHQwNzloRUNUaWhEazVmbi9qRWQxVzNIUEV0amIzNEt5WXR1VVl1MlBXQTNW?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b01598-4273-4e26-db91-08db4dbf61fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 23:20:58.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dF1m1hlp2uTM6c/i+K5jo9yOAvYat09qJp6H8WjwugCNesIl7jtAemGlqlSCDIsA2igL3C2YwvwqhARcTjh1qWRLtKMKvDSHCd3x+cQG5dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 4/20/2023 3:06 PM, Tony Luck wrote:
> Remove that entry from the resctrl_schema_all list when driver
> is loaded. Put it back again when driver is unloaded.

This is unexpected. It sounds like the system would advertise
a supported resource with appropriate properties but for some reason this
is not correct, optional in some way, or perhaps resources are 
conflicting? Where would it be decided whether the overriding driver
should be loaded and why can that logic not be in enumeration
within resctrl?

Reinette
