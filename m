Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B33D634BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiKWAWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiKWAWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:22:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451D125DC;
        Tue, 22 Nov 2022 16:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669162948; x=1700698948;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TOmPG2vtUj7/ibXMvJHHpgfaEhGMrTtCFoagD+/mHoA=;
  b=MGIMMwuRuI7jKYTg5jfN/CROJU5i6cX+UxSISQWLds5Kd/WX66wC2x6N
   eoST2XB/yx1Lk5Ih2AQcblywihbB73TDL59WwLlJxdOzcCNo4o5N004VE
   WZOT5Bgda0yL5eO1Xp9AtCcTwurwjLTBuCjhEwKph2HxOTRr19c1q8FNy
   CXXy7cPXYAchlI/EGiUuYBVgfH679Je2+QIPm2drv+wrvx5Hw0kEdCaMp
   eWfzaYtuZZZNHrWTRJ5s0Pq3b3CyYu3dSYvNRcBR1m29w7QnRuhfiW4i7
   VpLn8yeYM5JAtTi2+r+0NeQy7fhnrh7PxfhcEXzGETMllRbKG6/XjQxfi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="340821141"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="340821141"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 16:22:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="619411639"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="619411639"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 22 Nov 2022 16:22:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 16:22:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 16:22:23 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 16:22:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbC3e/dTFpNAEyJQ0iNlgXmC66tFdCi64wm8T8+cK4ygq7AYDZ6OKLdVVVE91BTfGxVY9NeNwWeYCDF1WiEUA+gE5+XVvZ4vAU3VO3vw/aj5zlquv5+03TzD7EprQoyN7MrBAchEcLXKqlkeLaDJCTD8wK9MUjvk1XemDlo1sx5YP7JjyC/x929sM+iEOMQAEtOIXAu2wIW9s/Bx15X0gnYCzg2s2kb1pBRi6yU5F7jA65QEsn6g3xGrTTBydCSO/GvHcrlZIb5m2wVXshrw0eAczSoECSTJLngK7o6OJcxMzUyjJ+5Exg+1cfdGsChwcu60A+4gTRTbK93XrXqNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzSWtUd7Ws7CRgbjT4lg0ZQLzl8sCKXjYY5bRBr/G/k=;
 b=aK7Ciutuu3BRUqJVCLbSoryeCbDtOUrH+sgEVN9K2KTdw3DxWqi1npRbHpb8axCtj+1mY9HPNR7oQ5CFThySMq/KpyYGWUglaLZ5IL99O2cHBHyPANtPErfWwIkVD5FHTSNy1oHwr6Jb4lACu3MhBjO0PolMam1i/ZPYypUCBE12guuk8OemrcXfN8tkqNvVB8TcWC3WD7WxGQqahlVD9PMMFIuYVK8hqPXpETZiZj8l1Ag0se9GYTmh+E1tahKARFTNasJ9VhbX6e5SPzDw1Qfvdik2NRfe49/nCBfqvnedNm6PgOZ9kFZDXI0Zh0ysr/Oe8+Rfs2tXhTUs0kU2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH8PR11MB6949.namprd11.prod.outlook.com (2603:10b6:510:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 00:22:20 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 00:22:20 +0000
Message-ID: <8be9c390-87ff-b503-59ab-27aa42f22c98@intel.com>
Date:   Tue, 22 Nov 2022 16:22:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 10/13] x86/resctrl: Add sysfs interface to write
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
        <eranian@google.com>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759206900.3281208.11975514088019160962.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166759206900.3281208.11975514088019160962.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::32) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH8PR11MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 4016f783-c4d7-4790-f8c0-08dacce8c8aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50VzxYrrgfoqTCkNUK1KPwnry6FjTRX6j37YZaDTFNcHnAFeuQlazEgwp2V3F+FZGpfIaEl3K5o67N8Ljx9XQ7M8JFTtup0HqrC2uUJJU5+UCBlMeMILEof77jwsIMrqvSkh0x06RMWuO/5LYSmVeTZ/CBASDwp0N6EVLE1hQ+4+3vzdCh/N+LUa5m6xLyhSmk6ktQ1dUA9KGy35dSatvn7Vk+xXK8tp6R8pjiNpb3ElXFRUHgu8suUHXgpT3cbwCuPRLc+rGtmYTC50bQsOnTgH3UJdd0VSEYCeZg14mFwBUimgwZco3pdf5GF+TT70PchV6x5NQFvievkAKaPi7tnd/f+TuylW7BJWCY5lwIajgO9gBMpnMS9VBs9Ek+A+5FM2l5njob2AwzYl1ayi4DxLBnf/Xy6USXFpnkJ7RFqG4A/JkG5YMsSXPq4oMqbvwvBbQVwscyzc0S9DfXrmqZQ2YAV8ydQUfEbgKvakKl5Lzkl9x5XGmQoxNSORsE5PGmC3BV96IrnRh2Y6IB+coq6AHgEGngB1Dz1WL8ev0dSJ0QgN+NXVZO16WMJQqerXhh5urofyvF4jbSeTouhCzoRzI9H/vjoEr/PVtGyd1YBjpt6wB/oKGSNHeAFu2pRc+/NpWAclEWusl2DwYT15scXQ+bJKkEYXazkIqJC4JRSDTU9kvrVdXUWFn9/hBsbz1OTaU/UYqIGP/4Qv+5U+TVugGCtnQwhXJUTuIsdH7PI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(36756003)(31696002)(86362001)(38100700002)(2906002)(5660300002)(7416002)(44832011)(8936002)(186003)(83380400001)(82960400001)(2616005)(316002)(31686004)(478600001)(66946007)(41300700001)(66476007)(4326008)(8676002)(66556008)(6486002)(6666004)(6512007)(6506007)(53546011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3dmTTYyOEFLTStobmpJaUF2amV1a3I1anFuVk52ODJHRmtoN2hzUzFGL1Rl?=
 =?utf-8?B?bWVtTDdGRW1QZVBGWnVzR1pxRkUrNHpFOHYwd0hSQjZ0WTRXcmdQVFo1RXE4?=
 =?utf-8?B?WC90OURha2J5Q0t6YWVCNnc5N2hRSHNIYkdZbFJTV0haY3IvTnh5cXA2QjRD?=
 =?utf-8?B?NXpLNU83RWtHZFZaN3ViRDE2SVRGL0N3QmphNU8rbTNqdjBTdXc1Tzd4Ym8w?=
 =?utf-8?B?VXZDcXZjSDRpbndlSy9tM3ptWVR2VGRtVEFVM0R3L0NuOExmQnVua0dCOHl4?=
 =?utf-8?B?OUoxSFNHRWpZQXErN2hoUkwrdGpBTmRpTHFmYTFzVzNvOXN6WFR6ZzNoWUIw?=
 =?utf-8?B?RndnQVVPK2ZUWmszeVM2dE9GOWMrSWtTNWZEMjkxcXBtNEw4NzJBaGhGNzha?=
 =?utf-8?B?ajBudm53QitpOHhFdXQ2bTRQeDdnSU5ieTVwNE5oL0ZBYU5HdnpKd2xuUndB?=
 =?utf-8?B?bjRPUWt6amJOMWxPTjhjTCs0RWhXbWpHV3BIa1VYL1czdXpZMGlhMm5ITjA5?=
 =?utf-8?B?SytwK1BXUGRpa05CeEQxQWNpZ2JaYVhqb1RQRGJRMW54MFVGVkpIemlxWVRt?=
 =?utf-8?B?L1g1TWUyZ0tNU3piT09iUnVLMFdMc2VzR04vQlMwSHlOZ3RsN3FWUTRBTDdV?=
 =?utf-8?B?TlNjME96bS9ncDBWa2p3UzJhak9ZUmIyMENPb2J2ZGpUOHkyMGZVNDZRZXdu?=
 =?utf-8?B?TVRjbmVOUlJXc1Z4UVVjUWYwK2t2Qlc4RVdoenJvSkZOcVpSN2hCTmZuanQv?=
 =?utf-8?B?eCtSbTkyM1oydExGcUhRZzRxWThKRlIvOFN2SXowcUhRVEg3VmhpQXpjUWpm?=
 =?utf-8?B?OHhEVlMwTzBrU2ZOZkpXQ3V4aCtTZVAyNGV1N0xNR1lQVHh6L0ovdU43ZkJt?=
 =?utf-8?B?Y0hxMlRrRzhjTS81YlQ2NFd6bDRqK0pDTWxGSXEycVFFMzNIZHpSQVc2U1ZZ?=
 =?utf-8?B?OUJEV0o4QkNxcXdxeVR6ZUlJeU55aUJZemdOK2ZMYjR5MlpZdGNPTjZNVDVY?=
 =?utf-8?B?QWx4Y3NmKzVJaXBCcGthQVNaNVdhdWxYK3R2VzUzVDlyVDVuaW4zaDRwRDJU?=
 =?utf-8?B?eTNiQ2hraTcvR2VkTXFhdjlvaGttRmhDN2VEWmRwT0x5MTRyYWVQS3QwZ2RK?=
 =?utf-8?B?V0dSbXRxc0p1U3FINy95Tm9ydEVLcEpOWXNyKzJVLy8yZzZId3hkdlkzT1lJ?=
 =?utf-8?B?Y3VEcjZURjE2aFJ0N0c5UWJGWHF5bFhDMS85eU1mMVNsVzhvMlQ0NElUdmRJ?=
 =?utf-8?B?R2dmN0xjYU94UXl3RjlFd2tBODJGV0I3QTJka0UzakpidmNlRVdYU0k5dWhi?=
 =?utf-8?B?OXk5TVFDZVNHcDhjNFRBMkxXMWdyb1JZYmN0Smk2bWhGaFp5clJQTU8vV0F0?=
 =?utf-8?B?Q1o1eHR2YmNjS2tqQXRCdEM4cHh5TG9BQnh1NGNlMmwwOGYzSmR6RDVqRC9C?=
 =?utf-8?B?eUt5cEpzTjY5Z1JoZ3U1bXBaM3ZSa3RvUG91V2tHOWR4cFZ5UjdLNFlDbFhS?=
 =?utf-8?B?UGZSeGZXUjZLOGtCdzk4cFpTc3drd0U5QlhzUG5PdnVSSVdGVjNzY1Z0RjZu?=
 =?utf-8?B?Tk94RVRSemJTdTNzUjlPRHNSbEFtL3JoRnA0cU9lNmFobEZYTGpnRXE1TVBv?=
 =?utf-8?B?U1VISEpHMUNVeXdOaGtMb1JyR2pjNEpIaWpndmRCWmxoWnpPUnh4UnFYY2F6?=
 =?utf-8?B?M1pGVE1nVFJSOUlmeENMT1NEL005dmYyc0lmK2VoQVVnaVByelFjR0xwUkRa?=
 =?utf-8?B?UHh5SW5LYUF3dzM1RGJjU3IxenI0L2NkUmVqeVZjRmlzZGJmMFBCTVBMaXRZ?=
 =?utf-8?B?UCttS1VZQXZEbDNXTHhuQmtFVXVOZ3lDcnM3ZlorR0R5YzJjR09heWxpcEFB?=
 =?utf-8?B?QlZ1Ni82VkQxOE1HeXIzaWJJcy82UElMa09BUFJKV0dBNlowSTlBeWVvVGNN?=
 =?utf-8?B?Ni9SQ09TKzYzQWFkRkRxS2FpUUdvWW9Ob3hKdXk1cTNuNkVvNW9sOGhTSUlH?=
 =?utf-8?B?M2pQYnJHM1hLOUpDNzUyTkJ0dEFyUllkemd1YW5ZQW02OC9vRjBJbTAzakEx?=
 =?utf-8?B?QkxCVTlqdGNOU3J1TlVpbUNMaVE3QzlHeTNEQ3ZCYmFKNk9kTXo1eU1HWlV4?=
 =?utf-8?B?SEZ2NnFLZ3lRSVFxR3lIVEFscndmTmkyeUFTanBHTG04TjU0bzNBZC9RWTI5?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4016f783-c4d7-4790-f8c0-08dacce8c8aa
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 00:22:19.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUxq9CRZBabMGimq4W74uwFDemmrLtyNSr+v0pK4b8OgCkOkpC2biJXVsOfQf7y42ZpA49hWnEFSQZg5jTYuQwXaVsND6cJGg+g/62thzqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/4/2022 1:01 PM, Babu Moger wrote:
> The current event configuration for mbm_total_bytes can be changed by
> the user by writing to the file
> /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.
> 
> The event configuration settings are domain specific and will affect all
> the CPUs in the domain.
> 
> Following are the types of events supported:
> 
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
> For example:
> To change the mbm_total_bytes to count only reads on domain 0, the bits
> 0, 1, 4 and 5 needs to be set, which is 110011b (in hex 0x33). Run the
> command.
> 	$echo  0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 
> To change the mbm_total_bytes to count all the slow memory reads on
> domain 1, the bits 4 and 5 needs to be set which is 110000b (in hex 0x30).
> Run the command.
> 	$echo  1=0x30 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  130 ++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 18f9588a41cf..0cdccb69386e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1505,6 +1505,133 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static void mon_event_config_write(void *info)
> +{
> +	struct mon_config_info *mon_info = info;
> +	u32 index;
> +
> +	index = mon_event_config_index_get(mon_info->evtid);
> +	if (index >= MAX_CONFIG_EVENTS) {
> +		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
> +		return;
> +	}
> +	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
> +}
> +
> +static int mbm_config_write(struct rdt_resource *r, struct rdt_domain *d,
> +			    u32 evtid, u32 val)
> +{
> +	struct mon_config_info mon_info = {0};
> +	int ret = 0;
> +
> +	rdt_last_cmd_clear();
> +

Why is this extra clear() needed?

> +	/* mon_config cannot be more than the supported set of events */
> +	if (val > MAX_EVT_CONFIG_BITS) {
> +		rdt_last_cmd_puts("Invalid event configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Read the current config value first. If both are same then
> +	 * we don't need to write it again.

Please no "we". Maybe just "If both are the same then no need to write it again."

> +	 */
> +	mon_info.evtid = evtid;
> +	mondata_config_read(d, &mon_info);

Here I see motivation for doing validity check in mondata_config_read() as
mentioned in feedback for patch #8. If hardware decides to use the other bits
in that MSR then the check below would have trouble.

> +	if (mon_info.mon_config == val)
> +		goto write_exit;
> +

Could you please follow the custom in this area? Please see goto usage in the rest
of the file that you are changing. The label should reflect the action being
jumped to. In that sense, "write_exit" is not clear. A simple "goto out"
would be clear and matches usage in rest of file.

> +	mon_info.mon_config = val;
> +
> +	/*
> +	 * Update MSR_IA32_EVT_CFG_BASE MSRs on all the CPUs in the
> +	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
> +	 * are scoped at the domain level. Writing any of these MSRs
> +	 * on one CPU is supposed to be observed by all CPUs in the
> +	 * domain. However, the hardware team recommends to update
> +	 * these MSRs on all the CPUs in the domain.
> +	 */
> +	on_each_cpu_mask(&d->cpu_mask, mon_event_config_write, &mon_info, 1);
> +
> +	/*
> +	 * When an Event Configuration is changed, the bandwidth counters
> +	 * for all RMIDs and Events will be cleared by the hardware. The
> +	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
> +	 * every RMID on the next read to any event for every RMID.
> +	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
> +	 * cleared while it is tracked by the hardware. Clear the
> +	 * mbm_local and mbm_total counts for all the RMIDs.
> +	 */
> +	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
> +	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);
> +
> +write_exit:
> +	return ret;
> +}
> +
> +static int mon_config_parse(struct rdt_resource *r, char *tok, u32 evtid)
> +{
> +	char *dom_str = NULL, *id_str;
> +	unsigned long dom_id, val;
> +	struct rdt_domain *d;
> +	int ret = 0;
> +
> +next:
> +	if (!tok || tok[0] == '\0')
> +		return 0;
> +
> +	/* Start processing the strings for each domain */
> +	dom_str = strim(strsep(&tok, ";"));
> +	id_str = strsep(&dom_str, "=");
> +
> +	if (!dom_str || kstrtoul(id_str, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing '=' or non-numeric domain id\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!dom_str || kstrtoul(dom_str, 16, &val)) {
> +		rdt_last_cmd_puts("Missing '=' or non-numeric event configuration value\n");
> +		return -EINVAL;
> +	}

There is some duplication above ... both if () statememts
check for "!dom_str" - is one intended to be "!id_str"? 
Could both checks really mean that a "=" may be missing?

> +
> +	list_for_each_entry(d, &r->domains, list) {
> +		if (d->id == dom_id) {
> +			ret = mbm_config_write(r, d, evtid, val);
> +			if (ret)
> +				return -EINVAL;
> +			goto next;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
> +					    char *buf, size_t nbytes,
> +					    loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	int ret;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	ret = mon_config_parse(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
> +

The naming here does not reflect what is done ... much more than
parsing is done here.

How about renaming mon_config_parse() to mon_config_write(), and
renaming mon_config_write() to mon_config_write_domain() ? 


Reinette
