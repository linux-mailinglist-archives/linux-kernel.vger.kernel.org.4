Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF7F64BC20
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiLMSe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiLMSep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:34:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF5252A1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670956473; x=1702492473;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5M20nxb8+RdKtDtxqqazrIBIbVMQCvl622SclsIU4+k=;
  b=DbPBKlotN6CUuoPfwRW1dWMtHGSJkAD9j1pkfRtIL+nPmYAkib7iNZqf
   ASCkixcgECXBgcpq3KC+Km6ii74CFzm9kmaWQP/lSJqfI7WyzIS5cNVPU
   +f4C9GkV+v3K3kAHZgdfjwm+pttHVMjfb32tfXGGynuXGE9ys/xNNmt1u
   c4F0dqZF3Yglv7yhtrm0aMisc2WVWf0RVzvDk2u4SjWwVKNVn/blI8MFn
   2nKaVF4DcCEsHYd9mcM6Wlzw9bu7srkrLlzYZoJ6Kp1P1VkVrgVVLLP9X
   MWSzWhycqpDbI+qgnAFiKicYUPbKwUshlftmsSwv023HGJcxtFiOVYBRN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="320067375"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="320067375"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 10:34:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="648656700"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="648656700"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2022 10:34:10 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 10:34:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 10:34:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 10:34:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS/veQktdFBowcxaG515m2YrXiiaDOcGtBFcaBMDFR56XwXo77SKly2UTlDWCw32nnrg6ijIC+k95zfPPBrEfBkCl/a8y0VetRogIhB2lQxrG0rcIAEosYDjza+omj1YQ0Ov09zsiciAER5rUyhesnMbNAH5dunpwFlIGSa3WHkRGNP+67MN7T/u9dz5ChfytePUyBUKNVnp1wQHtw4XR09d0sVL6EcPL8VDX5/gj/bO9TdM6ud9OqAwXCHNimIUSeH+mWihFPrprmI18dL2Ykgvs3Bi9A7tXIis50SwPKHYy3IwtC0jODomaOLqb0wV5gVh9W6HBQT4m4vO+Im5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAih+SYSAZ/nTNrZHNIJXM4MxxZ5G6I5HuhKtNtd4Vo=;
 b=NxZ1YGb8nJ/2fM7F1lfA0AHtsErd7FfIW9iQNO9MTUOBgQjFn78MD+Y+tvn53zEayoze4z1wN2D/X+rNAUP5CPVwAKvYwZaqtcDkSsbb+GfXUMPi4sgO4mP54vOrn69PbQj8AKIVcg3fKJDz6zTAbf/VyzoZe6HU/rZ4j3QeTAj+7pckPk+XfHj3Pf0qrYJaUffHtcgdCdWh2BhUXhne8Y/7wSXToF0Z8BQ4aeQfrP6ABt67vrNvhJrkXf6AMW5GfH89c6VoM0oIrnFsgJgj41QvzLGYoT1MoJFEvMzAhV9VQfq3stsZX7S+ZxUJ4LN7DoJy43ORRjDJSJVwvVKNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH3PR11MB7346.namprd11.prod.outlook.com (2603:10b6:610:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 18:33:59 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 18:33:59 +0000
Message-ID: <3b020456-6312-89c7-1391-06241fa0f3de@intel.com>
Date:   Tue, 13 Dec 2022 10:33:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/2] x86/resctrl: Update task closid/rmid with
 task_call_func()
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     <bp@alien8.de>, <derkling@google.com>, <eranian@google.com>,
        <fenghua.yu@intel.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <jannh@google.com>, <kpsingh@google.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <x86@kernel.org>
References: <cdcfcd64-c76f-0d2d-6653-0229c956f2bc@intel.com>
 <20221212173638.1858573-1-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221212173638.1858573-1-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:a03:333::35) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH3PR11MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: e13d2853-fb0a-4a92-2507-08dadd389986
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0z2WdWQIK8kvvkw+/CvN6zrmD3TQ/kjf7wby6Xtz04TZ+tij7ZFToWy/rXMWfkQYadb9pb3AluPgy4wEKOykrSJdSB3M2w9aHCLiERfCSSuDegeNs9eRiwX1Bhb09S1TWaw/hOzEmq1kSeJHwy0K2K6ZDbl22sTaRUSrZo5si0YrLLik/9+gegj6ve8E1aZ9/v8D92e+AzQiQpsrmlT/j751DvkHyONVHBbftdX/fhIqYp+PViC1NbxaRYCp6WGH5IYJhIuTG/fBdBVwdUXDD7wwbHyJNw4YCxqZXkS1oUO8EaKQx4E3jX8DU1vDUACqe2tS8xT6zYbtVmA/ooY8HhJnFztOD4goT76IGQM43IVMp3PfuOsfPX+JYrVqOD7vN+k0EsXhYJD07QrSuYcyYV+TmJbVz7VdbphJmFAbDoYp7Z+cD0HBuegfYGEIn6Kb4YU80rOw0tLrs+KISYdLQxGUkRxnPak310aGuJpOYYpxbxTEutUlA1VbL4cb9O+kt5XZvynC5wn5yv+gkotMJSF3Zqw4kgFrT68M3cEd8L6gdaaEpFQoVP5/qq5N+XwqMcdZnYiM5wFtQzZ5/BeyODk7zRrbmrAZKfUSOMnkRvYD5eT4QuKOwwk99hWaJtZPwh0UjO5r0j/yNeZg5NekFngWdYiJ2/BUfPqP5Kh0dpw2d2UUIq5o3oajjgf0s32hST79aJt1cfGbfe14BAkSkLotG5mGuLkQYkZzVB41hmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(86362001)(38100700002)(82960400001)(8936002)(31696002)(478600001)(6486002)(6666004)(66476007)(53546011)(66556008)(66946007)(6916009)(4326008)(15650500001)(186003)(6506007)(83380400001)(26005)(6512007)(8676002)(2906002)(316002)(7416002)(2616005)(5660300002)(31686004)(41300700001)(44832011)(66899015)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFd5MXpVVmVCbEhwaUVlMnI5STVOa21RSmk4QlZNZXZ6MzNNSS81TGh0QklG?=
 =?utf-8?B?eHY1R2RBK0VNVnZUZW1xQWJQWmFPaER4bk82cnR0a2p1ajdLZnl1QlJJWEdS?=
 =?utf-8?B?SEdqbmVWMk80cEU0TktuYkZWeXc2cWxNUlVNcVRhSlBEbnFQYjRNdzcyd0tS?=
 =?utf-8?B?MWlYRy9GL21UbXA1M0FwOEtRMzd0VTVRL0hPbU9pOU54OThiWHg3c0xHVUFu?=
 =?utf-8?B?TlJSNVZBajlCSWYrSzVYeU4rajBHQUMwZW9GWkJPdDNYYmpmQlVPOThOTWhT?=
 =?utf-8?B?Z2FET2VhRGh0eEg2TFQrVk83UzBMQWlpSmgzTjdXcUVVUTZkQ0ZCOHQvWEhH?=
 =?utf-8?B?eU1TcVNFeURDUkduL25KTDJqekM0dmljNHRGZ2hUdHpkR3NEd2pwREIvY0lD?=
 =?utf-8?B?STVjM0JPWVhuMWMreGtHZlg3bU1iREhyTXAvRSsvcS8wc0Q4QXNPQlZBd3RF?=
 =?utf-8?B?YkxnalR6bUprbjNvL2w4aVdxbWZVWkV3bk9IalZ6clMrOCs1NFMzL3NRVHhL?=
 =?utf-8?B?UEFuSEJhWmx5WHVSYmt3T1VXWFNibjFLY2FmZDdBbE1iUE5aQ2tRL0x1Y1VL?=
 =?utf-8?B?d090cXR6Qjk2Y0twT2VCSFo2V0VreGtzZmdZUzVPMEtJSU9yZHNwbkVwMHFp?=
 =?utf-8?B?bmhvaTRVV1VjZG1pNlJqL0FyUkQ1Ymo3a3F5THZVdjRuc2RQd1dleVUzcVdS?=
 =?utf-8?B?VVVnQ29LODc2U3NKUklKVGpPaGpoMmxvR2dBdUc1cGwyOXZBdlVXamtJMzVN?=
 =?utf-8?B?UnpxNk5qTGZoTlo5L1NLZ0M4QTFGTzVwR3U3bERzTS9PalU3eHgyajgrK1FI?=
 =?utf-8?B?a09LOW4yZTZFemJVS2lsdkRvVDFMSE5uWU55RzF4VUIwYi9GTk84MW4rYnNV?=
 =?utf-8?B?TlJiTVZsSTVZRVVxbk1yblhQc044OTB6clR2c2FrZ1llU1l3UkhrVXdLcDky?=
 =?utf-8?B?Mm5aeDJaNmM5Y0VTUW1KV21GM0NCanZiS1d5TUtGWlFaYVdnanFLQnM0K3VJ?=
 =?utf-8?B?ZTJFTWgyaFZLTk9mSVFmRjZ2ZmxEZ0Y3aXo3K2NRWDhDajVqbUN3c21pSlFv?=
 =?utf-8?B?VGU2RWhBRmZXYW13VFhOZWtMR3FpRFpJdFdzOFRNM3BXOGZsYWVTWG1QZzhv?=
 =?utf-8?B?S3JYS05qajlhdWJkU2JuYTlQblA3VnFRWVBNM1FMZ2ZXNGFhdU5vUDR1cVRn?=
 =?utf-8?B?SU5GUitrMUtzZXBtWUEzTUQxQ09aempoZGp5bTVjRk5ybGtvcnN4d2wvZ3p5?=
 =?utf-8?B?ODZzMGg5Wkg5OGl1U1czWFBVSmdUZEpWVUJmdU42cEYwc0grN05RQjE5M3Nm?=
 =?utf-8?B?R2wzUlpMZlBKc2JlOTI5aFVwdWswODdQOXhoQ3lqajRtK0I4SjZrYTRlck4r?=
 =?utf-8?B?clNpa2ZxWk40VHdVZGpGOWsxYTZEOWVaYkZBZkFnMnpwcjhFU3Y2QWpTQ3Fu?=
 =?utf-8?B?b1ZQNmdaVHphdDEvY21hMkxuc3dGN2d4cSt5aTdIM05CRit2UUJ5TnlNQnhq?=
 =?utf-8?B?aXJUWC9FTDZkUXdzcWMzRVRSSDFja0Uyc1RBaFZBMlFjZm43UW9uTmcrdUZO?=
 =?utf-8?B?bU8zMmNyOHJ3bnZWQis0cXJMdlNpejhzbkt4VTM2cGlacUJVM2Fmb0NVRmxo?=
 =?utf-8?B?S0xSZjJsNWM4VlNZZkxwbllEc0ZJelVuRHFXU0NMazRCVnBKRmFtZHNMWWQz?=
 =?utf-8?B?ZHF3REU3VzFvTlBiNkdLYURTbkdaRXdpSzVKRkZTQnJ1eCtKMkdnZXBUTFp2?=
 =?utf-8?B?RnpnSzQrYlFBUS9YL1Y2VGd4ZEMzeXVMWVF6VjVudmhSRmMxS05wdGV0S2ow?=
 =?utf-8?B?b1hmZEgwTWFsUUFVdWtjL1FoVzYxNG9zdXJXNU91Z3dHNGh6clBRZ1lVbHlr?=
 =?utf-8?B?c0hZc3lTMHowV0lDUndLSTUyazhQaTNWcWFpMGJsalJOdTJ0Nm9DVlB1VHNn?=
 =?utf-8?B?WUNnRWlMRkR2a0RoMThWbUV3NG96TkhIbHhLMHI2MCszRzVFWUIyNVovWXVO?=
 =?utf-8?B?K0FueVlQVGJVZndVU0hQejRCQjFEbGdodXBDK0ZtMXdNZU1zT25jdExDalhO?=
 =?utf-8?B?aHN2bjNweUVOcVh0a05ET21qMkhtUVErVkUraWtJTFM2L25tK243aC9kcldX?=
 =?utf-8?B?bkpDejFGNzljMFpxaExMTVFQY0xxMTEzVzFoSEZOcitRSDJlaVdLZkdVa3Rj?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e13d2853-fb0a-4a92-2507-08dadd389986
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 18:33:59.2146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13g3ksWvx4bfbtgb4hMNR8ECBOvWOKsZkeqi2rOn+CFG9qzanznk5dkTbjpv47Q8UGmW3o8Vl8gO2y9QrOpnbhRAQt0W13KLjPNxAik5n+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7346
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 12/12/2022 9:36 AM, Peter Newman wrote:
> On Sat, Dec 10, 2022 at 12:54 AM Reinette Chatre <reinette.chatre@intel.com> wrote:
>> On 12/8/2022 2:30 PM, Peter Newman wrote:
>>> Based on this, I'll just sketch out the first scenario below and drop
>>> (2) from the changelog. This also implies that the group update cases
>>
>> ok, thank you for doing that analysis.
>>
>>> can use a single smp_mb() to provide all the necessary ordering, because
>>> there's a full barrier on context switch for it to pair with, so I don't
>>> need to broadcast IPI anymore.  I don't know whether task_call_func() is
>>
>> This is not clear to me because rdt_move_group_tasks() seems to have the
>> same code as shown below as vulnerable to re-ordering. Only difference
>> is that it uses the "//false" checks to set a bit in the cpumask for a
>> later IPI instead of an immediate IPI.
> 
> An smp_mb() between writing the new task_struct::{closid,rmid} and
> calling task_curr() would prevent the reordering I described, but I
> was worried about the cost of executing a full barrier for every
> matching task.

So for moving a single task the solution may just be to change
the current barrier() to smp_mb()?

> 
> I tried something like this:
> 
> for_each_process_thread(p, t) {
> 	if (!from || is_closid_match(t, from) ||
> 	    is_rmid_match(t, from)) {
> 		WRITE_ONCE(t->closid, to->closid);
> 		WRITE_ONCE(t->rmid, to->mon.rmid);
> 		/* group moves are serialized by rdt */
> 		t->resctrl_dirty = true;
> 	}
> }
> if (IS_ENABLED(CONFIG_SMP) && mask) {
> 	/* Order t->{closid,rmid} stores before loads in task_curr() */
> 	smp_mb();
> 	for_each_process_thread(p, t) {
> 		if (t->resctrl_dirty) {
> 			if (task_curr(t))
> 				cpumask_set_cpu(task_cpu(t), mask);
> 			t->resctrl_dirty = false;
> 		}
> 	}
> }
> 

struct task_struct would not welcome a new member dedicated to resctrl's
rare use for convenience. Another option may be to use a flag within
the variables themselves but that seems like significant complication
(flag need to be dealt with during scheduling) for which the benefit
is not clear to me. I would prefer that we start with the simplest 
solution first (I see that as IPI to all CPUs). The changelog needs clear
description of the problem needing to be solved and the solution chosen, noting
the tradeoffs with other possible solutions. You can submit that, as an RFC
if the "IPI to all CPUs" remains a concern, after which we can bring that
submission to the attention of the experts who would have needed information then
to point us in the right direction.

Reinette
