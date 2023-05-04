Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429E26F7230
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjEDS4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:56:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F949C4;
        Thu,  4 May 2023 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683226596; x=1714762596;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oyeCWcg3BmHYR9M5BmWtQiK2KLc7Ajv5ot2MSlNS9oo=;
  b=j6q0OUcpJv1XyXUbcZ/FASINHbdo7VZH67XFjc/AvPDmjuUaQKktsYJu
   TgsEmOvbtO9srHmGaLXyLTG0GnfwfJDeY1ZU3+R6H3pZKmt2V3EgLmIS8
   z+5YpJb/MJOcJHt88koQLuwbBD+BsFqVS+vXC2Y3PesuAWq0IxwmX3xb7
   mnivdxqkWCaY/pULpLQkang4FbybitowCxciIDsJlKeaJJmJ3dZ/ZtdUN
   KDk25M4aPW0x3P99hJuX0QhPYX1V199h3gBRYUa744MzEifuj5SB9zmKn
   mAQjJ5C6J6Mgv4vX5k6S4IDwJqhPvYKNLM2M4NySEY7kf576blkuj9stM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="352052750"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="352052750"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 11:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="674658201"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="674658201"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2023 11:54:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 11:54:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 11:54:27 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 11:54:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAPFFBbYdouO7tGmKJGOAvxHSF26SQA5Dkm9xD7KPbJq5kns6QQhffHBdKYgnIiJ9dxFv6kJ6B+0X0Bu+N4ieWKd1womInnpoQSk4cUe0a0vXwTnAHGV4kTifo3eiWKxtuVB90RCdXwLqkfgI/jHLZhxrjnP7oMqst2cMakgAj5481YHmClOISi0v07GEnQuxM+MMUsmUz6HRuMDeIEZwFxGPzqTbzKM+SKWh7IK2+IB2x+jN/XhZRN7suJQG5Q2EFDeruLzHejTqTB8E2YqsS3xpxkH04I8x67k/VvvW2kRzEQwqbX82JD8SgyIFVspfQ1BkxA73IrGpKoIvC51xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hs87WHe9BUct8Hy6xa3/CCJhOlnImZb+j34T93E6OQ=;
 b=d5Iu1veLUY0j8rX+P3UboJHbnGtxkXalYP2VYXXCow1laME9UZ+Fnc1Fr/nRvl/U59nyKQFSLBT9thDGbB002e0HqRCvs7SsprsHXTknOnu3WfvFcZDwkaNg+fdKf4Dvv4GkTUN3+1CXNt+dxq7kqFqo2rKU3CYfxmkZGNOwef8HpjRaVLsNeb3XiTDctREz3IIUzd5wEaaGh65zCLVl4cYHbLRD0ptRxztyGX5GONQNLGNcoSBLavn4P+69DLo13+dNCiO8tkK9Llm+ojypH+QwSEroIXIup0/6J+cQOPYKIFplhCf5vI9GX8NgZINl3K9ZJw0TCOybNrKq6Y4/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4870.namprd11.prod.outlook.com (2603:10b6:510:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 18:54:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 18:54:24 +0000
Message-ID: <d0e72b31-1865-9e23-51c9-5c43cd71084e@intel.com>
Date:   Thu, 4 May 2023 11:54:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 0/7] x86/resctrl: Miscellaneous resctrl features
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
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a2c648-d474-476a-f03d-08db4cd0fa62
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGbkT++zH3mKi194fJ6GLCYEGDq/6UUGoIGYxHq6ZWcLyJe/AI6Vvm6Ta2JeKg2/XgfrIDZl3aivtIX6jHyLg+7Y3lgwHE5LrF47CNU+DuVlOx416IRcQWe2ua6a7u/arx8qwykDmFPKyaIMtXZFBe+dEGNvb4OvofHj5b8N/igr0PzySiACfvHDuPql0hhCTW7kKdfAuRfZ9f8y2pY3yUQH3UXnZv6YojdsonstXmS8VUP333ZQoWqsnxz8yl/n8s5+xdpOhR16Wyvl1OkniOkN6Gyf1foWIj7ifVWyPARCLx+9/lDQUvD/ZDvZwWXdpPekWD59QW0JagYT+eVaUUSJAgm+pyGdrWChL4pRKbqmg9WPQw01eMFOjoAHsfN07/j2/yb7gss8+MO0eJHmHKsi7Ym8Byp9a9XZ7dESt2DACogPhF4lnXe5PGUqyUYghih5MsxOvNRenuvAxtbeBz5RIoWkH3K0Df+ocFwk5H8qs6lGgNiE3sSQZ0KHyV0leaH47KOmw9warmjZzacXAsDAMoxSHEe7fhv052W9AZiSZKn/X0j395EpMb9MwSQVeMor4tOjmBTAao++O4Kdbl9SbzoxBGkJgmze7MRE6/8ymCLEyKozZVZapwsKmkwRatV/aE5qgOSlm7hGT01sOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(83380400001)(966005)(478600001)(6486002)(2616005)(6666004)(26005)(53546011)(186003)(6506007)(6512007)(44832011)(7406005)(7416002)(2906002)(36756003)(5660300002)(38100700002)(4326008)(66476007)(66946007)(41300700001)(66556008)(8676002)(8936002)(31696002)(316002)(86362001)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVBBUW1abWk1ZEkyTmRsd1FGbTlvdmgva2tlNDNIcTZ5ekVlUWR0ZmUvNmo3?=
 =?utf-8?B?SFNtL052Wm9MSmR3Wks4c1lvQnZmY3ppK1pwQmFxcWRBTk5PSkhLNmNkYlZk?=
 =?utf-8?B?VlRBWGVzZDVPNldqOFJVS2NaaFRlSWdhRkdLRHhDTzRLS2VzNTVwZ1Fua2Fm?=
 =?utf-8?B?TGhSUjNpZEV3Y2dDQlJ1MDN4dUt3eXpVaytaRVk0eVZpb1U1c0hjZlZlNktB?=
 =?utf-8?B?cU84a1d5aytCcmpweXFvenJMWmRGZlhLQVQ1Zm5nL3djMjgxcTVWQjlvb0Vn?=
 =?utf-8?B?cU42dDJFeU9BOVJPejN5K2djUVdwM2ZZdkhib3FHNXdxa2Y3T3NuWmFmYlF1?=
 =?utf-8?B?UlVmTWw5K2dicTk3ck1BVlREblNYY2hFa0Z6Q0FiSzhRMjJPelRXdEZNYTYy?=
 =?utf-8?B?dlpVNm9IaGZPWEU0Y0hOSXJUOE9iMWxRM09lclV1NFdKYmNEOEE1ZUlxSWlV?=
 =?utf-8?B?cFJ1YjV4dmQ1VlpKVmIvSWxMemwrNHRWeENLT0lyTTR0dmNFUWZSVktvcHlC?=
 =?utf-8?B?QTJ3YzNOeFlxWEE3b3pRSjZXMndGR2NQaTZVZlNvSm5KeUJMQTFTdGVvM0Vn?=
 =?utf-8?B?SDZtY2IzZHRMTmdWSEVlUlltTEVteWR4NTVONEU1Qk1tSkF0UzNrT25pK0p1?=
 =?utf-8?B?OHhlYlpjOElKdGJxdmRhazFtT3hRQ0JDeVpsMDMzc3RpckN6ZlNwb1AvcWdW?=
 =?utf-8?B?cElnaEgyV09CbGJxTTAzMXpoZXBlYk1CV1RLTXZkdDV6Y295TUNZazY1U1dy?=
 =?utf-8?B?NlU5KzVyWW1TVlR0bWEwWHRGdGNCOHZud2Y1TGdjcEl5U21VR1A0NkFMZitp?=
 =?utf-8?B?b0F3b3dULzBQSzd0bzhzTFJOaVdtYzhZcjhKV0VsWW4vamNnMUxJVEdYRWtE?=
 =?utf-8?B?YnRFR1hxTUh1TkFrakZPWS9nTDd5OVMvdWFMV0psNTc5cVphZTVoNTgwcFkz?=
 =?utf-8?B?d2Z3WHJPK2UxbFdsdm5wRUV6M3A3QUw3cmpuVXhUSlFFVUF3bDJ6Wm4vMi9M?=
 =?utf-8?B?cU0zdnlibzhtck5xcUp2QlVMaFFYR2F6dG1pZWVoWFpBcDliMjZJTEVCTlc5?=
 =?utf-8?B?ejZPem5qT0FTV0Y2WXU0ZUpLWnJDM3cxank2ZnBqUW8xKzJId2w4TmczSE9l?=
 =?utf-8?B?eEtiQzlGN1V5RysvZGJ1MHBWMmVTTzFsSENPM01hNllnQm5CYU41NWFYSWNF?=
 =?utf-8?B?b1dzcHJKY0txRFc1ZlRNWU1Hb09YK1RDcHVGZEkrVTlNVlRXVDJaTnBSTnZL?=
 =?utf-8?B?c2dTV1pOa21ERm9yU3c5Y1lldVdxZC9INHhaSWZFVms4ODlvQS81V1hpTGtB?=
 =?utf-8?B?QXN6L1BqMGlDQnV2UjVxdDNpdDJKMHdGNTZLQkhqbVJoVERjZ1h1ZmZHSWli?=
 =?utf-8?B?dG9oN3p0b2J6OGlTQjg3UVUxK3NwWEgvRzZocmhHRDBoZFh1dERGeWJ2NmJT?=
 =?utf-8?B?ckV3bGVOSmptNE8xdGNxdnh6OUM3ODBCL3J2N0xmVUt2aFowVzZHWnFrRm5r?=
 =?utf-8?B?ZElNNTNwSVpib1JVUTg4aU5KbmU4emZsWUlLNUVGYjlDRmZPSFJaUkpaRzZI?=
 =?utf-8?B?YktsaGM1RktnNVV6QlRTMFpoZXVHZEErbUY1MXhOZDdtcFBaL3lWVktuNXBh?=
 =?utf-8?B?dnUySkRvMjdvWkJuRVl6TDhWSGRkejFVMVA5ay8vWnBBbFJFWUpOOWE1REFH?=
 =?utf-8?B?Ukc2Z3pmNU9HWGdRcEM3K2ZhWEZsUmtLaGtqRWNmbUZCc2xhQmluQkNGenlC?=
 =?utf-8?B?UHREQVpWMGw2NGt1SUk0eGY0NVZTbElVVDRFTmVUZExydVNERG9HUzlhS0xC?=
 =?utf-8?B?QW8wczZ6U2FYNUc5S0tFTHJpMnhmdmNxcjNKTmpYUzN6NUJQV3RWWDVpekZE?=
 =?utf-8?B?MGJDVWVIWjhoVVZlZmRVRlV5K3g4U05yRktWSzZKRzZvRWJBcTMrMHBaRUZQ?=
 =?utf-8?B?dXlhcGp5cDFLRXFxMklKTUlJby92cVAzMDdwZUFuNnBaN2J5SllxeWlUMk5j?=
 =?utf-8?B?ek1kSWpWY2QrTEhhNFdIdk11RE9vTW14OEdsdVFCK1dpWGpkTVFyTzk4QlZy?=
 =?utf-8?B?K1VtYTk5SHRkOXVxdXpjL0l1L1dESW03b01IZGxmUmJMTlBVQ2JpUzRLM2lS?=
 =?utf-8?B?blo0S2NydmU1WldwU3c2TE95MllrRklyeDRjWldkQ21GUEltTUlqQ3UvRWF0?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a2c648-d474-476a-f03d-08db4cd0fa62
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 18:54:24.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErK2ZyII+SgmeFuRl7Yf9imN/jUnzKs3p+kn3oyLPU6CHSKyS8WSZW1F/lw5LgGkMVj5rUxVVbL46aNXSCDxGVixWN/gn43dMgX21a1kssk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4870
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 4/17/2023 4:33 PM, Babu Moger wrote:
> These series adds support few minor features.
> 1. Support assigning multiple tasks to control/mon groups in one command.
> 2. Add debug mount option for resctrl interface.
> 3. Add RMID and CLOSID in resctrl interface when mounted with debug option.
> 4. While doing these above changes, found that rftype flags needed some cleanup.
>    They were named inconsistently. Re-arranged them much more cleanly now.
>    Hope it can help future additions.
> 
> ---
> v4: Changes since v3
>     Addressed comments from Reinette and others.
>     Removed newline requirement when adding tasks.
>     Dropped one of the changes on flags. Kept the flag names mostly same.
>     Changed the names of closid and rmid to ctrl_hw_id and mon_hw_id respectively.
>     James had some concerns about adding these files. But I thing it is big problem.
>     Please comment back if we can do better. 

From what I understand the primary concern was the naming of the
files, which you address in this version. 

A second point I saw was a request for insight into why user space may need this
(James recommended obfuscation when value is only shared between kernel interfaces).
You did answer this in your response and since there was no follow-up I currently
assume that this has been answered.

Unless we hear otherwise from James I thus believe that his feedback is
addressed.

>     Tried to address Reinette's comment on patch 7. But due to current code design
>     I could not do it exact way. But changed it little bit to make it easy debug
>     file additions in the future.  

Could you please elaborate? It actually looks like you may be headed there next
according to:
https://lore.kernel.org/lkml/933d8ae2-d8b7-7436-5918-f639405c9ecb@amd.com/

Reinette
