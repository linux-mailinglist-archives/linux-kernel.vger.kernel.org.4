Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B116D2BB1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjCaX3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjCaX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:29:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6401A475
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680305367; x=1711841367;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OOUSFMw7cBmTkvSRwlDaaRG1eubDEEeWg8h/kM/d8EU=;
  b=R8Do86VEZT1cxOYVpGKm15FMqbvhRhgz9LakxtaUV+iKSRyQPRBIsmxr
   OZmmpYMo5bbv9xY/fcr+WxMFIQV9qofaNLJr3DJWh25X+fZLfTHYDWIvL
   0wBs8Pi3w46XlL6jm+ANJaes0D+XhcUE32FNKX4vMDGhEWtBLuyLlnZEe
   GC8m9YXs1ixG5ObtYYNaK/yKrgOuUFusmCjl6dw/oNSUBq4dflZTPkBpI
   ymQy13jv31IoBDs8kLCQs+IQ7sPUOhUN/ROoQKE2UkzvZX9msHr+/1NHY
   xdfGOoiKOZzzroUMi+lkxfeXp9js/aiP9jHu9jKMGd6LN/qdCIiXOHTSN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="427855530"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="427855530"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="796283309"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="796283309"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 31 Mar 2023 16:29:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:29:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 16:29:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 16:29:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgKdP2XoFed2W4zwYimMrHXi0qeHGEG+uHWFnoMsGnVjb3vVufa59JyVfJR2et5x1h2AOmcPMiaUx/+8yeeANP+KxiX9/l4exFJlKyfazaraqSDs9OfZtD7YuT0wjUikkjdV3XetKqR45YvIJnvq32v8XCVZMNmHi6thfOrEKm/G8IBr2qPvWjgbqjLQ1Ioqkr/cay6soqDsmpSs+JfDk5RK1si5L/2xBwKFg+u4c9zz58tnhyH8T59Mo6ciCbMI4z/o2pyWYXPXqXP8Pb1IEz5Pbss2OMa3wReMU0L7H/+ZIERBfQBxkQ66TEVUu1rcCqONaSfUV+X5T6BqEhBTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOUSFMw7cBmTkvSRwlDaaRG1eubDEEeWg8h/kM/d8EU=;
 b=M4hapE49CnnWeTlqsfJbGp0cgJVV9TLzwg3nO4FHDPMdJvdTe+DC26smn26VChx2tionk3/ytmYaXq+Xby3BJdV/rYMZ2KvmpOR2KB9oexNByjtzrB0+5OElNlpDx036QdWHLCSnjG1Wi2E/IUu/vWlTrkM1rb1hCaJw3ypThnmiLECrKyoNsru7o+ZGF6ZP7hqhLoWVAc416QND1XBvJKGozNIDvSiGQ3u45ZrRlmJ0FG028/Fj8ss1HpTpEw6/SsxTkT3DiWizu8PQZvE3uUtonuAzwJ9R2IvgNJPJZhYoqAOsnv7SUO4VDjbfDhpZak1Z4ue1oX/9u+hewnLdMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 31 Mar
 2023 23:29:24 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6254.024; Fri, 31 Mar
 2023 23:29:24 +0000
Message-ID: <80e2962e-0aa6-c939-8f69-8f0cda988cbe@intel.com>
Date:   Fri, 31 Mar 2023 16:29:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 15/19] x86/resctrl: Add helpers for system wide
 mon/alloc capable
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-16-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230320172620.18254-16-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e998796-0432-4c90-0e1e-08db323fc2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjpnN1oZmnX9prBq3tP4LPLMZ9eizsfP+LlXoX1D62Z89TI/ISO83W2tTco8M2ffNoofk5rrSwMKYKcR0oo01/LlmdGEsXOC2WZQr2Kz+nWPViEF9W7KBJeWP56cza746MBXShGR2zWc6EuPHpydW4qrcxBWyzg1XNzojMoW60C4t2EFUNpBehgmKqvYwD68QesDFQPTmVtNjRESlXjukwPTs1kR/PAQrw3HNCrgyOsCEmjh0J4XD4Xog9TL/9TvFWjVZ+YBu16BoHQFUgO386sbaDQehMGjOPTgnAP3ZnUVrjlGQVc36wU5RPZuNtXLhv1gIWdjWdTEDd1E5cgIGitqIwke0OIbaJcbO7YJurIn14SN1GGoLNMurHk1KuiZk6amRB5Ecjb/Xfrw4Hu/nzzBX2N6ra8MWAmaKI9e1Wy6EaTU+tBpyYCh4FrgJupLE/x3pUIqrrROnEjJZq6VZfvOmIEL+mb3jtfEiHkJFk/Oy0Lpo3F3ufozyqviLl9Vghx+51RvkZ2AmyOXfPkxeipB3HvPBP4fsdbM9aqZejEDx3vSMrhG8ZKza1kkIfkfZX179z8KnPwMf3213VwPRLexFPPLhcFcQqi/SUy7YtDiKojTdB8PBNvYutPTYVoj4EsqhrA/z3GxHlkv/AWxFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(36756003)(66556008)(44832011)(7416002)(8936002)(5660300002)(6666004)(2616005)(478600001)(8676002)(66476007)(6506007)(4326008)(86362001)(316002)(26005)(66946007)(31686004)(31696002)(54906003)(53546011)(38100700002)(6486002)(82960400001)(41300700001)(186003)(6512007)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVppaExOQkdMVWl3VG1kRVB3cXVTNTdSK05GZkJVbU92OER1MzI5ZkZ6YXow?=
 =?utf-8?B?bStiVE80WlJhZlN3aVJCRUdGNkpGUlRVa0tNYVFXbFVlWW03UUJkSldvVjVU?=
 =?utf-8?B?cTRtQW9DSUpvZmZSbnRGa1B4aEZQZEJnMDNUY2o1SllhdFpETHdGR2Q3VWpJ?=
 =?utf-8?B?YW81MEVuWXdCdkc0dGIyMmZvbXVNa3RQV2Rhd25vNXJmbW9TdytkNU45Mjl6?=
 =?utf-8?B?dThJM3kycUFnbmw2SUNxSk1kY1c3eldCL01UTEdkcjY4OVBPSm8xWWNMYllJ?=
 =?utf-8?B?cHZMSFAxTGV2YTU5OHNaTFoxRkRaZFJtWUtOS1M2QUQzdGtJKzY1MTk1bXJ6?=
 =?utf-8?B?eDZsd0xwTlM4MW90QVpQUEVDeEJSeVdEdEtnWllTbVZacDhEU3N0WlBoL25Q?=
 =?utf-8?B?MWFkMlQvR0JDVTZyTnJFTURyZlpUSyttVGNqYURmLy9qNGNMNGJMelVIcEtI?=
 =?utf-8?B?M3R4MU1qTk1oVDdEZFpuMk9SbXE3UDhRRGU5d3ZIUWcwb1lRUTNZZFh1eTVO?=
 =?utf-8?B?dEVQWlFxcjRDbExqL3RIU2dzY0U2dy9TSlVzNHo3bmxSNFhpWFVGWlFUU3Vh?=
 =?utf-8?B?M1dLbmFUWXFtdGh4Y3h2cFFJTFNWazYyb0pYbHJzWm1qSUxyWWFVSWFRSHJR?=
 =?utf-8?B?WVNVQ2dJOVJqRWkwYm9YOFZTOGp6cW1laVZ5RFNkTlRIdUI4QTY1Zk53djA4?=
 =?utf-8?B?NTNwTHFEU3NxWnNvMkNKdHNzTHkzSFYyY0xqRzQwVmE1VGw1Nkk3TWhobXBm?=
 =?utf-8?B?NXRLb1JsTjNtZXlBREx5OGh5bmtGM2xUMkFFYjJmb1dieUZTVmdyOWVSK1Vk?=
 =?utf-8?B?dFZGWWlwQWx0ZXFUbGtZcDVsRDdpTVgySzBBZitISjBJc2NCenBUZGd5cDJk?=
 =?utf-8?B?Qjd5UDFkcHBlT0pnWDdsOWpxTjlVeWlnSG5xWmFFSlVJL3RYZGpMT3RLYVcw?=
 =?utf-8?B?Z2w3aXhWeUJ3SkswR1U3YTdWWHdzMzZ3RFN1aUNIaUR6L1pLMmFNdXVLL0Nk?=
 =?utf-8?B?RzBNS0g2ZHNwRVdPeU5sQXZQeDdMc3lIbHluZ29NWldtd2lSdVhvaTZHbzFr?=
 =?utf-8?B?L3VBSFRSaUFqRCtjZllsbU1ZSWtPVjZSazhCNEIvY3J4R0tRdUl6NmE4K1dt?=
 =?utf-8?B?NS9LUHpUMzhRRWRVRHhoTW80N3ZjQmxCN1BjMnY5L2xiNlhlYkNxWHZMaisx?=
 =?utf-8?B?NmpTWnFxN1l2Y0EzZjZKMUc4RVE4S2FDQllQSXdrdldCTUk3Vm9BeUtuNi9R?=
 =?utf-8?B?OVJZMVp2c0ZDSm9FL0ltY1RacHo3dWtSbURZQlZrV0RmaXBlbjlwOVQ1clVQ?=
 =?utf-8?B?Q0FUYmhxVWFZM0Q3SFVKc0N6MFY3TkF0RTRUV0RGOWhMajFUSVE1K28wOGFt?=
 =?utf-8?B?d3lnNm5MakJ2WTVYQW55VVhJc3JWcUIxYmxTRTlSU0JWb3M2OHF6NzJCMEZu?=
 =?utf-8?B?dDJmZlRCNVRqV1lnamh4VC9BSXNvMWFVQ1RURnkyMHlvdURVcEQyaWdQZXEr?=
 =?utf-8?B?ZzVhVDNlaXh0UlFyRGF1SldiQWJoUGFrL3RuTmRDOE9CSk5UN1pPcXArNyta?=
 =?utf-8?B?SG9WdXBUV3B4VFFQMzZLYm80ZkkzN0ZTMTF3cTFqTjh4b3JuT09aQmFGNm9y?=
 =?utf-8?B?cWl2cG9GbWo5ZkRibFQvemdBM0xkSTJiNXl2VU8wU3lWTkZ5UTFqZElRaW8v?=
 =?utf-8?B?MlBxdmxzSGxkdnhrTFlkbjdiUm0rVkRuSlhRRGhKODJjekNNaFYrUjk4YVJq?=
 =?utf-8?B?L2dOaFF6N0NjbGM2SUl3cnREUjNOOHNaekN1TXZxZ09ncXo5S1VjSDh0QXFo?=
 =?utf-8?B?NGd6ZTM0Q1EzTmw0VCtwM1JPTHRPelBjcHQwQ1FjMVZWckZmNWk1aTk2aGl6?=
 =?utf-8?B?N2NkV3pHaXVvelBHeTV3R0E4ZkNlT0ptMStxaTFoVWQyM1RlU3EvdUNOV3Uv?=
 =?utf-8?B?NTdxRXdPVDFrSjZBOGZSdytPRlV4aE5KODIxaFFQczRnUEc5Si9zcHVxU3lt?=
 =?utf-8?B?V0tXeGJLZlprZjhRamNNalU5cnhPN01DNTBhSlhSbUhjWklNSWp5SysvN3Z1?=
 =?utf-8?B?SDZ3S080RVJCVEhyME94OUh6dlZhdFJkN241RzZsTEhiOVFUdHY4OUcrZTJ2?=
 =?utf-8?B?V29vdllxdCtpaENsZVg5UGorNHZUby8raXhxSU5iaHVkUzRsOXFhMytBMW1W?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e998796-0432-4c90-0e1e-08db323fc2e2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 23:29:23.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MS18Ta2JhN3Nbj0s2jFNy7EuFaKiA2QGO2G9hlbwMW4OAN85DTiCnyOzzwk+zUzAzQmNPUWXhi1X5eoxGWBysuJq+ecA+p7O0q6OvjCDzLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/20/2023 10:26 AM, James Morse wrote:
> resctrl reads rdt_alloc_capable or rdt_mon_capable to determine
> whether any of the resources support the corresponding features.
> resctrl also uses the static-keys that affect the architecture's
> context-switch code to determine the same thing.

hmmm ... they are not the same though since the static-keys
in addition means that resctrl is mounted.

Reinette
