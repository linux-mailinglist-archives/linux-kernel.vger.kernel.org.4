Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB07364F1DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiLPTgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiLPTg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:36:28 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECD716584
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671219387; x=1702755387;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YH5dtCbw6g9ciFH7NTwIChWqifB/iRLo2t/3fI/9Sxk=;
  b=hU1zrREthTiIk8szP4EV5nuITD0KISMfqfxWaNbLopyimnu1w8d9vzgY
   qNfQDPxYd4DmRYcejzKlQKGGVmp217udlYJxgjjgx9TPMD7FNMX8wcMUv
   auZqPaPDuaIqFTIdQSr/6nt4ss4W4t2i4k++0fdGYMIF5S+mZFNFf4x8A
   XLLC9Yb3vgjIKtqK0LXk2EnCK4+aWy3u9Oz/NLK4mH6kWt/W3CtM++pwm
   iuKxoe/DQjhkgllkWrTUXZvnoqAMlbd+Yp+SYo4yjWlzlOD4ZGrIYZcJg
   HO2xGvw9i8ubeqBk4JlGq8qsOgxE3xHqi19jxvlPayEY6i5Sxji5cVXaY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="320927279"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="320927279"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 11:36:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="792190731"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="792190731"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 16 Dec 2022 11:36:25 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 11:36:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 11:36:25 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 11:36:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZJViAcE8JJUou1kGEm/FyrMOshWwIU2zVXvC8t9Vhu8MFj86Sxdf21ITVVZfkN7dyeIMU36eWy/8tEy6hvhG5mJeKXQQorN/SvDjix/XlR5Xgwa4tNOh/yqvhx+qlOJY6z04sk9pPwsPam1jPlX8CVEfzulHrhPUnsNCkBIsnT5NrgJz1XA1KPghsY7CArCY9owbuXeIl+WyFBCQXZ4ZyPyw/emrzDk4BjG+w38N53LMrH+fsGmWclH+hSq8CdupjhIUzPATBTzwVch9YbhKUghKCB0gtgoJSewrZk2gNAy8/954kHd6UYj93WWCEzfXNyyEnDUoYEgOgwN1zhtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6cIlmMWJPGVoSV3i67eHkTDp3VQkxdnrXDeGrs/HoE=;
 b=MgZlAzOLH7WJEsysXaFAx5wa6lXqGRrJ8zEAvdbHnUln2lz1fx4FKKvRMwrMYh685ia8S98/w1UXTYHvV6EqdLXPbkpxUBuRwjG5MSuA6Igydah/cxu/kkbUVvbe1APxNOqLnioIcl4gCHakkZAhYS/Wz9x6QdfrBP7RaqZzs5TTCA1PDy8gN5nFvLu2QpPt3ZCQwqpsVsmryR22o/6rTM0UpEZOZJcvfaPpzvZVIWRrEPeryDBjbQ75S4lMJKXpeSmu4lNJTU2N19bAd/8wJQiHjkeN6ob2r7glcTWAN1NKzWOhDzBn6BXrkA6tpQYfbkf31hVH31BeidLHCzw9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 19:36:18 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 19:36:17 +0000
Message-ID: <87a9df72-f15a-0cf6-566c-dd7522d40c4e@intel.com>
Date:   Fri, 16 Dec 2022 11:36:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/1] x86/resctrl: Fix task CLOSID/RMID update race
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     <fenghua.yu@intel.com>, <bp@alien8.de>, <derkling@google.com>,
        <eranian@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <jannh@google.com>, <kpsingh@google.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <x86@kernel.org>
References: <20221214114447.1935755-1-peternewman@google.com>
 <20221214114447.1935755-2-peternewman@google.com>
 <bbc57154-b7f5-4b9a-65ba-ca8dc0fe0dfe@intel.com>
 <CALPaoCgt+epHFO=O8B0LWfps0NjJ1RvwmfGey22XyamkUbm0hg@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCgt+epHFO=O8B0LWfps0NjJ1RvwmfGey22XyamkUbm0hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb09376-b1b9-43cc-1c77-08dadf9ccd34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DCPgN3yRxf3+pLCU2VL8SyvSRqaAFi/vsbxxbBhB5kjgRq+M0a44pB7mK283aKWgp/mP1dFgWVWMDRL/iv3TT9z5fNcsC7rRW3mXHdn3Ncm3Y1i8F55KQWBUu8SDTXVFfyMqucYDhFKKz2tuezkmMhsuoCpQU2Ne8dk2rLFCb6y2594OT7CNhr3KQ0AiyuexE0fXXVT2k1ZlshdT25fukktud+P1kEJCRZWimjqi9JNHmypOV7j5iUfsZSi6Udg38z4lsHAOSP2hvXknxkjawRSTiugPMwyc55NBzI8/pwJWVeas/Esnx+tSoX2JtLmHDualZ6DAONWpm8ef6ebOcBlCe3m+9260M9GB1bZPvx/kCz/YnCvj9HZ6tjhEe4Co6WVaTCy8coEpPLEwwoo+ql38RfhlR2ARwA19Zi5G9vVounEr9uHBiSKhaNG4rwkfwQYrUnLHbb1m74ruMmRA7mDM1JRixck4943bD0Q6GQXim0/SD6+LUjR6QrPdxeOKWAIq5hHh+mB6INzEsLRqwupOKUBm/cu6xIGaL1pNAXGWwd8K1A3hxXnmsxPS3LDhKqVQ9pOTpl0uM8U2+KDzY+hbvqS0uDYZig9dZKQmy6uQI1mr0On6+/aHHJY8NvPSlvLqptSb7v4LaI4OrCa8Ded16OokkFTg1vjv66GNmgTU58PlNXv+Ago9Ccrh9Tpqz/8ampl6tDaVHTgYtVeL+1nBdEHXbaJWMQhEVlxu78=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(31686004)(6512007)(82960400001)(2906002)(38100700002)(15650500001)(66556008)(44832011)(26005)(31696002)(41300700001)(6506007)(86362001)(4326008)(7416002)(36756003)(66946007)(8936002)(316002)(5660300002)(8676002)(53546011)(66476007)(6916009)(478600001)(6486002)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em93U2pnbmRsQm9sdHpoWVEyYmlMbTNYSnI4aVhIM2lKZzJPTml3N004Zitv?=
 =?utf-8?B?UUtPQXJUVHUwMFIyajVzbnVSV0I5YncxTFNDUk9kRFNEMFI1V0RDelZGc0RI?=
 =?utf-8?B?NkpBZERwZ3d2aVRhb2djanZtdnVWMnNjdEs2L3ZMQ2FqK0FOTm9xd0hVUTNp?=
 =?utf-8?B?cXVkTXJlcUlnRGoxYXNsYXVFU3dQZC9WSVp2V3JZNVQySjY0aWZWVHBHL0wz?=
 =?utf-8?B?L2xNMUJkRUhKNFZYUVh0cUgxUTdQaThHdEI1WU5SZkJCdTM0V1VqcXpLQjE1?=
 =?utf-8?B?RWM2Rzh3K1VGWnc1MHVyT00yUDRwVFhTQ1hGZm9qRnpqSkhuTVdyT1pBSjNF?=
 =?utf-8?B?Mjd6cS9WYjJRclhIOGEvUlVndWhtNStJajAyNnkreXZYQW1IZUlpd3FuRVpZ?=
 =?utf-8?B?eC9oSW5nKy9Fa2U0MmM5ZElGaWJNdjh3MnRaNXVKMWhmRVdvWC9vczRCTGNP?=
 =?utf-8?B?TmpZQ0NkQXIza1ZSaEVJM3BUcWtieXlUS2RBRHRKa1V4VnFtTEkvZUhiZHlW?=
 =?utf-8?B?MG0wMEhBYkF6VEQxQXlXekg2QVZBMXp6ajJENHd2UDhoK3pMWUZCTHZtV0x3?=
 =?utf-8?B?UEFrOW8xdkkyUDZST2NBSHdURFVlcGNvRW5hRjViUEJNUXVCdENwTWI4YXpT?=
 =?utf-8?B?ZEkwWktKeGNqYk5KeGUxbWZhRHN3ZnhDUzlFcklXUFcwOUNlNkkxNGM5aDRm?=
 =?utf-8?B?eTFOMytrYmhsZjcrdGxhMk5Zblhua3pQVndFV1UzeUthd0F1cktDbHJoeHh2?=
 =?utf-8?B?SHIyRjZ2VWYwS3pZT3FXNWROSjJUb1JabHNFQkdOM0lEVzRsT3lzTVlmeXZh?=
 =?utf-8?B?ZXNUUDVnNXRBWExpYWdxTEZmNmw2WUhPOUp2UmlDMXN0OFplUThwd0hMR1R4?=
 =?utf-8?B?OGdJQ05iemNYd1QvVWdvM3dDNFVuZytjSWRqZkhoaytrWEJuTGtGbCtHUUxx?=
 =?utf-8?B?TVJZT3cvOFB6dVJ5S05XMlNoMVozZmdRZEI0dER1NHJNczhHenNiK1ZaenJG?=
 =?utf-8?B?RlMrak5YOWt6Sm9DTGtubStnZnNKN05rdDZMQ2x0YjdLZWVwKzQ4WWY4TEIr?=
 =?utf-8?B?dlAyN2tBbU9HVGNkUGhRSzVNZy9IUHg5SVdqYU1kWStKUVArZ29DZTYvQUhH?=
 =?utf-8?B?TVZZcEhXYnF4dzhrNzdWMElpMFRtbEVxUkpVSVZEQmNZcWxGb095ajdZQzEz?=
 =?utf-8?B?S2E0QWlzbGN1eWdKTVVNSURRL3I5czN1YXZZQ0ljYTRYbExxeDM5QkxiWmZs?=
 =?utf-8?B?MGN1aVNnVUZSUkJrUFRCTkR5RkNYWkFFdGp0OVR6ZmFhRG9LZU1XVnZvUzFo?=
 =?utf-8?B?bW9ib1JpeVRZRkFoZ294Wi92VnJDVVRmTjMrbHlGRkJHa1FJbmpRRWxyK21i?=
 =?utf-8?B?eFl1TWEvTEJTMUFiaXlJdHZydytjNzVJZkwzdEhRRDl0RGlWR1M1WG5iUWdU?=
 =?utf-8?B?N1A0L0s1NS90b2ZlS2FkNFk5TVVwMG04TXljdHZVRG1RakZQblpRKzNraVg0?=
 =?utf-8?B?bXNSREptcHh2UmFBYW55MUNUdmtJZ3BZeTFqY3NpVkNxMXFEcVFHdEo4Um4v?=
 =?utf-8?B?MWRNUDFvckRwdFNQYnFFaDhiU0pkTk1oUmJQQ1NlaDJaUG9JclV1NjlBWUVX?=
 =?utf-8?B?Q0krU1k5SmVveXhOQWtjcUR6Tm1Jcy92VnRUYnFuQ2dLVkRacStuNmZlRE1q?=
 =?utf-8?B?NW4vQWN1alFrZHpyeWN6aTcyYVprSzZybnVFZ0JPdWlSeFRINmNySE9LQWIz?=
 =?utf-8?B?bi9aNXNaUXhDYU0ybGxhdzRYbUZHN0dvUytUZXpWR2pTampoWmRoSzI1LzI3?=
 =?utf-8?B?QXQwUkhPWjVINlVGcXJUQTMyMjYrTlYxQzRKQnlxTVlJdzJRdHQ3RW1PRzM3?=
 =?utf-8?B?VVRhaDZMSTJQMXhPVTU0aU5QNkhxL1ZDNFNlaXFqUUR4TjVaVTlzbHJzMXBy?=
 =?utf-8?B?YlJFUU1Nb0p0ZXFTeVZSd2pNdnNQYXhCTDRaMDhmT3lnTlV4Z0MwZ052UUp1?=
 =?utf-8?B?ZGk4eFpQNE4zN2p0SkNDN2NCYWdZaktqcnNyUzEyNUJ6aEw3cDFzSFdvMnpz?=
 =?utf-8?B?Zmgzb2YzRUsveGFpdWJ3SUY2VDR2QzFZNDNTd3g1bjRLQ044QXE1ajVZdFpm?=
 =?utf-8?B?VEVPbGI4ankwNkpVSGxJM1JLemxTYWVQUERyMC9CajR0REJmNURaM3EwL2pv?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb09376-b1b9-43cc-1c77-08dadf9ccd34
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 19:36:17.8701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpWujroM6199MvSHKgQ6s1Sy+0vA+xji7hFQ2BwHdwkuvpoLCW90SR/idoWyyLCp3KpU5rNtd2HmUld3oU31q89iu7Cjx9gDCYvsPwZiY2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
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

On 12/16/2022 2:26 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Fri, Dec 16, 2022 at 12:52 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> For a fix a Fixes: tag is expected. It looks like the following
>> may be relevant:
>> Fixes: ae28d1aae48a ("x86/resctrl: Use an IPI instead of task_work_add() to update PQR_ASSOC MSR")
>> Fixes: 0efc89be9471 ("x86/intel_rdt: Update task closid immediately on CPU in rmdir and unmount")
> 
> Thanks for preparing these lines. I'll include them.
> 
>>
>>> Signed-off-by: Peter Newman <peternewman@google.com>
>>
>> Also, please do let the stable team know about this via:
>> Cc: stable@vger.kernel.org
> 
> I wasn't sure if this fix met the criteria for backporting to stable,
> because I found it by code inspection, so it doesn't meet the "bothers
> people" criterion.

That is fair. Encountering the issue does not have an obvious error, the
consequence is that there could be intervals during which tasks may not
get resources/measurements they are entitled to. I do think that this will
be hard to test in order to demonstrate the impact.

My understanding was that this was encountered in your environment where
actions are taken at large scale. If this remains theoretical then no need
to include the stable team. With the Fixes tags they can decide if it is
something they would like to carry.

> 
> However I can make a case that it's exploitable:
> 
> "In a memory bandwidth-metered compute host, malicious jobs could
> exploit this race to remain in a previous CLOSID or RMID in order to
> dodge a class-of-service downgrade imposed by an admin or steal
> bandwidth."
> 

I am not comfortable with such high level speculation. For this
exploit to work the malicious jobs needs to control scheduler decisions
as well as time the exploit with the admin's decision to move the target task.


Reinette
