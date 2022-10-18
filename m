Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912ED6030EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJRQoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJRQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:44:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABAAE9871;
        Tue, 18 Oct 2022 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666111438; x=1697647438;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IZqbzP6nszyYd+SZkFf54LdHUn5itwpQmk3ra8H6A+U=;
  b=KIRT0LcerJ74o6jWdHImv9g2t+mU5VKqpOo/hqR5vKcipt2jdaXuFDCL
   4kvqmjjxnfd3JE3rwXSM+ttTkDG5D/8q5T6pF4+fU4cj4BM6VoWN9j2pO
   qheq3W9la47I0yIGU+b9Ql/2X4g9OnHu5/XL7zusVZZ8/aezW8UqQpCIz
   kmQPrAdzEQUz5kaHW8DAC1DRADh+T/PKZqgk0NS9iCR8q8LfJR2MiNDAw
   5pgjn2EbXlaXwLzC2W4KHzhvrVkVLEzOKR58NyqbA04cZ/lIgr9duId+B
   q+EUb/RPd4SmW6hAgiYIEyI7A2qCRLpa9QI9+6EBHfcnR+o/Z6Lbyv+3u
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="303779073"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="303779073"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 09:43:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="623701609"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="623701609"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 18 Oct 2022 09:43:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 09:43:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 09:43:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 09:43:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF0Q4I7XGa71zHChBePe7dFlQRWrSphw9ClinsRNUaWn7P3WEhzmGKG97YAPVCzrD9IwQ5ikn2fPbf1KSISCr+JEZA3JCf/ftE+3miK5joj9Nm7O2TKqN71i6DQBm+BomNGoZFg/CUsBBjt9iwA1ho1rovGxTLhFqjlFFi2PqFaK//yg1Zz/owVOoRGRbmvgBT5TIwE8fMifOxhAqUzDL7pfAlff7Bj+W0rVLKUtp+fHOGhWnPKFmedfrPvKW4FmJAXgLCbFabpesvqayoMMqFzmKvdY5o8qXYjrLGN8JZuTLuN8mm2KaNmf/HbmgrGl+kuam67j8HS2qJ/Gi+F9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1hogvzJoo3y4yxVgqcaQ9oORiMilLirFcR2DT/NBck=;
 b=nwOuZN6ldITZ9NtBA5qZEnmN5hSqMzn0NJ/y3M2tDidUawVbZ6jW9reKG6YT/1/+UqVX195ivWYnZoZ2vKQzIC8xRW95IaiJyrwSoa9im0YE5EbdQMWWdk0JzX0aqp+6vCaf9O/oFjptIPSwWyrd0RP21Oc94ORCjN+k3BlJcWIiIENwweV5hiKJsuK6CcGvMSxhqIt3TDw9O2yJlCta6a6L50m757GJbM9iRts6Tkx2RXToCA4cia3AXwIa1AoG0W5+v+7lSokyGXQmiMcP+3ODsAaw6fTSfnVhIBClUXRfktxfwE+1RRPBR7s2minkoxes+Lc8+Jici46e3Y0anQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 16:43:19 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5723.033; Tue, 18 Oct
 2022 16:43:19 +0000
Message-ID: <fe3baf5f-1536-46d7-9472-5ab908b8f4f2@intel.com>
Date:   Tue, 18 Oct 2022 09:43:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [PATCH v5 0/2] x86/resctrl: Fix min_cbm_bits for AMD and code
 cleanup
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, <fenghua.yu@intel.com>,
        <hpa@zytor.com>, <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Babu Moger <babu.moger@amd.com>
References: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
 <703e6dfd-68d6-6def-183d-fb99b39692b3@intel.com> <Y07VzWTRpSnpbuc2@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Y07VzWTRpSnpbuc2@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:40::39) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|LV2PR11MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: ec30c47c-5e07-4cd6-3fde-08dab127dcb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LfawwrODqXnyNnKur1tW7orFSzc6jfZu8vL1Sd9j2j+8Zns6n0WMvQLJ/EgVGRSCSA0wYFQVCQ1vHDshpkI20r7XLoNgJZjZSdYq1AMMyECm+YjSWNHlqnvGQ9TVhVmcvvSkYMdstSOsfVV/WWAFK2UzNhxkh3BZ9Du94vj2tS9uXPt6q3td+7/hHcgYlKpHGTENG3GQwD7vFWrL4Rq+SDrrUhhJ6DwDpyDuNqx0Lhok1a8W8t1RuY95BpWQ5sliNVTsIlbAPHrTuuEbZ7FUQeuir6EZycMlPJCWBmPofzkXzsWkWlQELJuK6cXc1xB+vqRAcyKvZzToW1QDobhtXX0SABBO2WTLnMWzdBmIU3uUAATbiX8BYLhhltBfnsGN6dHyHhpMfK/4hwCwuqHns+DecYkjQe9H7ez6BVODa2Cs8BPOLsHEKjK/ZZQFEUR8hc/nHRgkLhKSkBw/Bis2J7NQaVWbnHceFuDt1bMiVNrfMk+aWy25dZnA0+sG63sJmDK1Mj+QMs0cFosqTCjQ+fh/1Ov+79mFb6z8NgmLZrlcz3L4ZO7D3YZz808bc0cpFVyoyj9Q+AItfObVBWbyADPOqJyVZfDcqf+LBXnKfsUv0E/o1xzdF9QSQoTP0AJ9kj+Dvs6icXynDQ45igF73I9Gi3DOsntfsJ82JFSSJtV7aHjfTV2uqEfVxVQkKceB2JWYARXkPu7uziGGlUP7XYEBpoSwFxzl93H1trq731QcGnQuDtbAcuilHRmAd+3VO1czpkev1y7iBKB/OCu68ih2wxgLC5GeBuQ82ukT80=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(6666004)(53546011)(186003)(478600001)(82960400001)(2616005)(6512007)(66946007)(8936002)(5660300002)(38100700002)(4744005)(31696002)(6486002)(86362001)(36756003)(7416002)(6916009)(4326008)(8676002)(54906003)(6506007)(31686004)(66476007)(26005)(316002)(2906002)(41300700001)(44832011)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjNocFl5dmU0RFlqT0hxMTNxYXRmc2VsVFYrTG9wRWowRTJwMnpDRlJqVzNZ?=
 =?utf-8?B?ZkNieDhYNTRuVUxqaFFZdzkvS0licnc4RTlwaTVvVTV2SGxOdzBoK0Y0QThE?=
 =?utf-8?B?WkRKaTEzL2xaWXE4R0g2bDZWSkNjVWxTVjduN3RNUjc5UzFHYjh0UTQyUm1W?=
 =?utf-8?B?c01WNm13RmRZakFxZEZpaFZUNDlEQW1XaWZOcjFibU1iK1dib2Q1YzBIbEg1?=
 =?utf-8?B?TGU4M3UvSEdEK1o1Q2k4dFltZWVJVnBXRVVyUC9rclNiUVlxUnZiQmI4UFNH?=
 =?utf-8?B?aStsRTFrdUE5d1JRMGY0S1g1dXk0SExKeTRXejVEbXlIV3FuRnF3bTBZNkN2?=
 =?utf-8?B?ckl5MUpoeStvdmVrTWZZU0U4em5kQndHVW5HanR5M3dsd0UrZEh4WXh6OGVy?=
 =?utf-8?B?QXRDWnI4WVBOVFd4SUdOaDg5MXdPTHpJdnc2WVpnKzVReDBINm52bXNNTVIr?=
 =?utf-8?B?VUc2V2pneVNZYWFZWHpGSTJHVUFTaFRlS1dJNWs5enNTd3BvSEZXd3BCTGk0?=
 =?utf-8?B?OEthZk4wZmV2T3NhcTF1WGg1YzRPZkMwVVEzcXMzeTd1YkF3NXl0OGZzeDZu?=
 =?utf-8?B?akMybGYvSjdpTGRoQnl5L3cwT2ZlclZFZGwzUFNFR3kydDlKOEJRN3RvSWF2?=
 =?utf-8?B?eksxdWt0N2w4Q0grUFg2ZGlnd085Wm5TcFNSbWFqVGM2K2RveVJEVDBJU0V0?=
 =?utf-8?B?ZGV2NVhKSFF0UDRlays2MmZSWmE0YldUK2R6K3RLdzcyYS9Bb0FLZEx5MkFR?=
 =?utf-8?B?dnlDUXIzd0grc3hBN1FBU2lzbG1CSmVkOS9IZ25oejZPZll5eUwrOGdZREUv?=
 =?utf-8?B?QUFWUVFRbytudGg1VytBR2thU3JydmNCK3NXdFNiK2sxeWIrMThqSXBFdVl2?=
 =?utf-8?B?YUhyZnNLUk15SzU1dnQwVU1hVG1TRVhkOFR4V21BZVdsS3hxMmk0TVdXRVJD?=
 =?utf-8?B?VlZ3Z242L1J3cEVwMlUwcDNCRDFjelRhTmFsUmlHRjNuYXVReEovMVFsQ2lE?=
 =?utf-8?B?UUlyd3Jhb0J0Uk1BTTJYZ2ZHRXVKREdWZHJxSGZpRUhHWXAwVDRSTzVPZnFt?=
 =?utf-8?B?NjRTN0djU1dUZHFKUlVWZ2NBYktVT0R0bDk0T1haUWV1MWhqeC80Q0tPOVoy?=
 =?utf-8?B?MjJyNG04RlZYdmYyNUZGRENjeCtKelFvdU1hRkRRODZTZkJ6cTFZS3QydGpS?=
 =?utf-8?B?U0Y1MFUyS3p5SElzeGpHaytvSHJuWmhhTWF4ek1RbTF4NUhXV2ZaMTBaRXBJ?=
 =?utf-8?B?cUJLTFppeVZsenVSaUcxZ0RCbDFqKytTSS9OUzJRdzQ2dW52RXRjMzF6MFlX?=
 =?utf-8?B?dlBQMVJ2VEQraHdBUWYreHN0N1J3UjFmUHhHTE5JUjFNUGYzWjhUa0FpcFo4?=
 =?utf-8?B?UlE4dE5IWG13NGNCUG1FQTltOCtZK0hIejJVaTlKNTFCOUoxb1E4Tmloa2Rm?=
 =?utf-8?B?NHRadnVhWlFBems2djRHSUE5dEFjdnlmaFJhdTNXRHp0eSs5QmNoYmN1dHZJ?=
 =?utf-8?B?UmcrT2xPTU13aHI3VkFOWjB4QjJBaE0xRlcyVmNrQmErdlhxNDdzMlordFpM?=
 =?utf-8?B?cSt4blNIRUZZcHlJdVRlaGd5c3lZTVIyMCsyRmt0ZEo0Mk1qL1pLeitmQk9Q?=
 =?utf-8?B?V2RVUEsxNWtzaVFjNWtCTWhhNTNhNE1sTkFuWnpiSzcwZTBueEVMUk52clF0?=
 =?utf-8?B?YzR5QjBQeUZjWTc1WW9jOG1aUDBSMmN5Ri9saDB6N0tmWFpGUkpKV1RmMmpw?=
 =?utf-8?B?MGZtaTBSeVF5T0ZQL2F2UUQ2dERuTDJCc2FoSnRucUhaMzI4aGFXM0k5cnZx?=
 =?utf-8?B?TFllanZRWEJ0ZnFuVVNOUXBpUG5qVUhWRFY2YnRxNDBiYWlGUkx1RGpnU05G?=
 =?utf-8?B?aGJCTEN3TjB2OW5BUUhQSFd1WHRWVFdXamNFWmZBS1BETmI5RGloaENVTzhM?=
 =?utf-8?B?R0JSbS9aZ3c4YU5OUTNyeFJaVjdtcVRxSkZJWGx2QzdmSENFUWl0MGs0dS9N?=
 =?utf-8?B?UDIvbGErU2U3ZEliVFJ0TTV1aEpNZnFha1BTRGowVWduMzE0aXYydHRQV1Zn?=
 =?utf-8?B?cXp2MjU2YXUydTRyQkw1cjh5TE1xWUZUaStUZUtLVVNNNWlVZHdibkxKVTY4?=
 =?utf-8?B?bStQc2UwQ1RiN2RDbVN5MzhzMGl6bzdwbXF4eWQxcDJTd2pGNFVOT2hNOGdQ?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec30c47c-5e07-4cd6-3fde-08dab127dcb2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 16:43:19.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ad8lvY8Q6RKk7CcPYNmaYlUpJE+MezPaTF50JfGgBbNkUV5nL0JfrcULabCTzMD0EaEl0MlKvH9vHFtd0S/slRgad97xajtfKK3kFApjrek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6070
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/18/2022 9:35 AM, Borislav Petkov wrote:
> On Tue, Oct 18, 2022 at 09:26:41AM -0700, Reinette Chatre wrote:
>> Hi X86 Maintainers,
>>
>> Could you please consider this fix and cleanup for inclusion?
> 
> Sure.

Thank you very much.

> 
> From the looks of it, the first one needs to go to stable, right?

Correct. Apologies for missing the "Cc: stable@vger.kernel.org" in
that one.

Reinette
 
