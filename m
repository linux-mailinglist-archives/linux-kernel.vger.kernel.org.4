Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF22B6D0E54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjC3TIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjC3TI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:08:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4AAD539
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680203307; x=1711739307;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d3NEvkaE+NvfbwcY1cd9BdomFeNl6/XD/VMdQCHMMOk=;
  b=iLwAjw2ME3VDcv/1RGCjTQzFbU1IjR41mSGXxvRHDoJMdgUtdMbO+HBP
   TskKLVVJMzy/+XnIsj4VXK3KUAK3PTuGzwLCfzDw643VmHjWCeBpbd32y
   lLON9nILQ0Ihs5Mm/UH9b4TFOwDD/cky8z1gAIYXI33/eH9jsYQDCdsWa
   asdzPR26X8+dYug2C8AmeUwvmG2BG4rag+JnyILyuEDzTnoxorexzOAv7
   Mv7n4VBhBpJGOorTU5Fl5fk9VbdHNwVagSpvVEPA9rGN58IXmZqNy8sCf
   OkUzP3139K84338AHrb8j7XhWfE4BhXiz2TMf5i09sRYFv7yFnTx8Ac/W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="338764864"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="338764864"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 12:08:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="684822644"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="684822644"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2023 12:08:27 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 12:08:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 12:08:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 12:08:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joa2FAf3hLFgboC+dAE2OQDmxSHsnKnwv7xKCZSZcEWPBT2nLh7wMLM76EE0WGCV1pg8nHTzvSdPm7Gho4Y/aQ/YJGHuGgKkAJqiif+CiIFeXVHJmzeK6I7+o7nO8uo79WyEWI0K61GY8SFetTOHA+8MntoUiCYANwQD3XhGxsQRcTo44peJR7D09bZo5LgI3KGK0GfJOoq9IJGd/ioRJ+xcybFUl6qXpT7QJlsjNc40OT5Zp1OjwbypvNW41W3+dgheliTOV7wK9zGDoro0ji/5yhkIMb1oPAbKGkpvevkSRCVV9H7VaWSgqzNA88wFg1Finwco3BwGBn6EMdDCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEh8R+76SVObXBvIoHoxuDY/aMnON+ShSewww2fefAg=;
 b=eCvXznzCipGQIA2xoxtpSt5UwhABcRsHK9xj7WjcZCmUCD482jJ6hzXK0eqVaP1HWiLlGo6BeDS6AipLMX9yC4JlXkHD1aexlYvvZ110l7gxhFaKS2MUy43jWWK6Tf9LoxpdkFcWpfdSqCPjsbAD1FZcifRmkH9xQQ1btCyjDfnvAnhEl4UTGU7W+zjE2Qi5P8VLNpT+YdGNryFrMSDcwEumangnoFWjLOCCtPxDvIyVkeeP3mWdIKuyCJssgiEtbY7HkFAUuH1mTJGTmCxCV94gJWwCSZtzhL3vuCg/13RY5ajDaffgdcY+HLbq68eu8XIKhOfu3aPtnU7yIsiF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SA0PR11MB4749.namprd11.prod.outlook.com (2603:10b6:806:9a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:08:24 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::9121:8fa8:e7d9:8e46]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::9121:8fa8:e7d9:8e46%8]) with mapi id 15.20.6178.038; Thu, 30 Mar 2023
 19:08:24 +0000
Message-ID: <0891fecd-88e9-cd50-b2ac-8b50c7149b19@intel.com>
Date:   Thu, 30 Mar 2023 21:08:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [BUG v6.3-rc4+] WARNING: CPU: 0 PID: 1 at
 drivers/thermal/thermal_sysfs.c:879 cooling_device_stats_setup+0xac/0xc0
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230329165819.50ce6ab1@gandalf.local.home>
 <CAHk-=wiEdcjdceNdfVGPEcbSmAKh_rjtBSy5_Z3Yyx2GFEgLFA@mail.gmail.com>
 <22cab1d16c75cf07e0846a136c355615bc9b05dd.camel@intel.com>
Content-Language: en-US
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <22cab1d16c75cf07e0846a136c355615bc9b05dd.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0277.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::25) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|SA0PR11MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd4d07c-93a8-4aa9-42cf-08db31522209
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7X/+Iq29dvewAXZAGeg0VT1EQEKh7pN2ugqk9vA+Jtd5gK2czaev8BU2W6+U8+Dyh9h8uvcG7h88z9l7RCCY0dSmp1QR8vDzdxep9ItAy1BffBcrBZh5dh6NSgxmdT6S9MXmWc4ykw+HTRN17cpwFXDesUu6Chl8usrrgkdPeqJJh8N5rO2msiFMPctrWot4bgRj4NW0DAKyHjzbacai98XydJWiZeNRqr/PVueYygajZi1RfShggKWhf8kGFXzYw+kUmY6tJ+A8wcl+fG9DkgWeUFvd7OBRTbB26FeIsOGILtBni2THZvvmae0b0cxcJjOLO7tWkSi4BVI7OQULEw+RXCd9Hi12W84OoMi67DOqSBWKou9qNhFKzmjdEMrNczUlUVBGf1gsOeR1vGKfbCe8muou3cir1xpZcKpzS9ErfUnahOnmoMUgsZtbAqFqax86Kkueab4BfURbY8OFIUhr9QZ9ub+8hc1CL157tjLneJNXbK3xexiEkCLoMUP4sHFqLZ1qQYUHNSOSlc2z2zPy+f2knO/63qNpxuTf2QmjSQN21rEBDrszz/WPEXm5+3r5RUaGAwHLtoLjIKRU4oIr8EL9BBbPhQoi52T7TN0JEwm8GS2AjSc08IEjuMxSub80Eoc3/ktz3jJAKjQUJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(6666004)(31686004)(38100700002)(82960400001)(478600001)(110136005)(41300700001)(4326008)(5660300002)(31696002)(66946007)(66556008)(66476007)(86362001)(2906002)(316002)(53546011)(26005)(6512007)(6506007)(966005)(36756003)(83380400001)(2616005)(6486002)(8676002)(8936002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVE4WStRSjZqTjBIbngwQVd5VmdSVXVoWlo2REoyQjAzNnMvVTRmd3NpUS9o?=
 =?utf-8?B?TFNvalJ5aHp6bENabjd3RXZJamdCaE5wVExPZFlMR2tBREF4MnRQRk4yRUdD?=
 =?utf-8?B?Z0U5Sy8xSDBIMFRhODFqQVg1RVlyK1RRSG9yTUhPSU8vMDVQWDJ6VVByczd3?=
 =?utf-8?B?OHZkTDR1emMxamsvTC95WEpZbW5ONkxJQW1FMUtRZndCcXFnT3BYVWVEWDJR?=
 =?utf-8?B?d1NEUVZUZjhrcjNjTnlXeHR2dktTNHdqNXd6WmR5bFRHVmhQNjNPS0lCWXpL?=
 =?utf-8?B?cUlNR1dIK3puS1pqSjlKQ2V4ZFJyUXVIY3FJcWg0ZDRmRGVpbE9JMFhYeGZU?=
 =?utf-8?B?anVEdVhHYnpNRHZIVXF2Tk4vTDBIRWg3ellTdVJxMHJTOEx6WlBCbFBkaHBN?=
 =?utf-8?B?bWkyM2NiTGJJeEhOaGI4cjMvbnpucTdVdzFSUnJpTXZ4aDQ2OGdqdEEwT2tm?=
 =?utf-8?B?NDk1bW5CZ1RVQkhUOEdyOUptRDV6STlLbEswMk00OGc2V2VBUlRBMVRleHN3?=
 =?utf-8?B?YVNENEZjaW9yVzF0R2d3eGYwMjU2QTNSUGZiTHM5YjZWcDRpOTVEWWpIMTh5?=
 =?utf-8?B?a2FDYTdISCt1cGFiSyt1THlJd1RjMXFSUnN3eWtGV2FzdTVsakRDYkRabTJQ?=
 =?utf-8?B?RUV4V1BXeXBSZDVsTysydHZpTVFRS2ozTVRQemxXNVF6aHV5QzNwMnlhdXdk?=
 =?utf-8?B?dGZFWjNGOXIrTzJlRSsyeGtNUklZSmVkTERiZnpoSUxYbUFmSjBrZEJkR205?=
 =?utf-8?B?aENqTU5nOEEvQ1VabGJGOVRIR3k3TC83ODY1TGxUMnU1Z1ZueE8xV0daUm40?=
 =?utf-8?B?bllwNFFFMHdJeDdicXRvOVN3dVhFdG93OUNBc0k2ZmhwSzFDYnR3dDZpbzNq?=
 =?utf-8?B?Nzh2ay9GeUtONnZaOWwvc2dJaU1RcGRHNG5FWnBpbno5TjI0WlNUVnB3Qk84?=
 =?utf-8?B?OEFOK3AreEJMdjltOUVmNkozRDQzK1BnTTBMTnE0VzluY2NMdzdtcE91WWJX?=
 =?utf-8?B?bVhTNkhSQzVtY2NvWjZpODhNWDB1UDE1WEI0RzE2cXBRZit0SmZqaTRXOFEx?=
 =?utf-8?B?eUxmQTZsN2xHRmVGU2xWUCtzTW0vU3paWkhpUTRIU0RseGVFekdwZ0hsaEI2?=
 =?utf-8?B?NUtKU0JiWEdHK0I0WGF3eE03SE9jL09ZWElpQ1YxcXoxaCtEOHhsdXRzTWJV?=
 =?utf-8?B?WllzQlhVaDdkdTNHbFNSOXgvcnJyRXNxeFMzNGZhSVJDU2UwTWcxYVhKTmx0?=
 =?utf-8?B?VVNYaENiWVZ6WTk5aWNuVEpuNmZ4czBmK1ZkS1FjV216QndObVJqWDYyMEgw?=
 =?utf-8?B?dnRxUk5oS1VuVTNrZCtGTTFwWFo0QjdXM3dBVk1adk9BNmhyT1l6OWpkYmtG?=
 =?utf-8?B?Vy91RG9NVmY2VXIzMGJkTjcvd2plcSszK1FFTTRWWlhHS0VBOVg1V0VUd0VR?=
 =?utf-8?B?dGs4UjF0TU1pOHZRQytaVTR1a2MzUlR6WFdZRlAxQkRYbElaRmJiTVBMVVJm?=
 =?utf-8?B?aTRiQlFPcGlFTHJKdVR1bXkrWk1PZUUvQWloTTB0dXZ4SkRNZWJyT3BDaDlu?=
 =?utf-8?B?aW1UVjNZNTNDUlYzT2Y1QSs4cHhldWxNQlNYVUVOalVBL2RDSkNEcG5aZEZI?=
 =?utf-8?B?TnBxYjl1clg4L1FvWmF5QmxQSGR3SVppaStmVzMyQVdlQ0NGZFpoUHRSRkZQ?=
 =?utf-8?B?MXdYSlp2YzFUcTdReit4RjhlcnJ5c3RieDhYNlY5ek1iU0luc2liSUtkbVE1?=
 =?utf-8?B?UFR0eGRBdDhWR1Q3YzdiUWJwSVZsa2RJM2w5NWQwMmZ6ektMZ2VoTHRTS0hw?=
 =?utf-8?B?bTd0d2gxUGJ3MXYwT3poaDNoL2p6T1JHVWQwWlpOS3l2YjdBRm81UUJ4R0h6?=
 =?utf-8?B?WkhPTWtDbHEzNkFuR2VuQzdIdWhLUXloTDFPdXZsbnk3TFYwZEQ2dkpMbThR?=
 =?utf-8?B?VHQ2Y3VjVDFsTWhpa2ZiTzgzTFU4cEdNODFiOHF1V2J0UEVjcGVVcEc2V1ZY?=
 =?utf-8?B?bWFybXdYUTNGTVRFUi8wTGh2eGh3V1Z1ZEI3RWlqemlrRGQ2ZldRNURpK1Nu?=
 =?utf-8?B?SGtLZU1IcEswc0tocTJwbWN3VVhrTmozS1czbTdrSERDc1pxUEZIUlFuQS91?=
 =?utf-8?B?YU5Obk52RkFvT0x6Yk4rQTN1eEFPN080WlpLTm9rUkNyVSt6bjlQc2k3Vmdr?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd4d07c-93a8-4aa9-42cf-08db31522209
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:08:23.5386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4SZWWkpFHa/NYYdW5UY28LycDG+ymnB8ZFCyRCqe1ZeOHS73m9SoJfIlhWrQzGH3cDIaS4HJZAm3UNIl5G2OlQJrLZe8buaCJrV/U7CnLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4749
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

On 3/30/2023 11:57 AM, Zhang, Rui wrote:
> Hi, Linus,
>
> On Wed, 2023-03-29 at 15:52 -0700, Linus Torvalds wrote:
>> On Wed, Mar 29, 2023 at 1:58 PM Steven Rostedt <rostedt@goodmis.org>
>> wrote:
>>> In preparation to adding my patch that checks for some kinds of
>>> bugs in
>>> trace events, I decided to run it on the Linus's latest branch, to
>>> see if
>>> there's any other trace events that may cause issues. But instead I
>>> hit
>>> this unrelated bug. Looks to be triggering an added
>>> lockdep_assert() on
>>> boot up.
>> So I think that lockdep assert is likely bogus.

It is, sorry about that.

I have a fix queued up, 
https://patchwork.kernel.org/project/linux-pm/patch/2681615.mvXUDI8C0e@kreacher


>> It was added in commit 790930f44289 ("thermal: core: Introduce
>> thermal_cooling_device_update()") but the reason I say it's bogus is
>> that I don't think it has ever been tested:
>>
>>> static void cooling_device_stats_setup(struct
>>> thermal_cooling_device *cdev)
>>> {
>>>          lockdep_assert_held(&cdev->lock); <<<---- line 879
>> Yeah, so cooling_device_stats_setup() is called from two places:
>>
>>   - thermal_cooling_device_setup_sysfs()
>>
>>   - thermal_cooling_device_stats_reinit()
>>
>> and that first place is when that cdev is created, before it's
>> registered anywhere. It's not locked in that case, and yes, the
>> lockdep_assert_held() will trigger.
>>
>> As far as I can tell it will always trigger, and this
>> lockdep_assert()
>> has thus never been tested with lockdep enabled.
>>
>> The "stats_reinit" case seems to also be called from only one place
>> (thermal_cooling_device_update()), and that path does indeed hold the
>> cdev->lock.
>>
>> That lockdep could be made happy by having
>> thermal_cooling_device_setup_sysfs() create that device with the cdev
>> lock held. I guess that's easy enough, although somewhat annoyingly
>> there is no "mutex_init_locked()", you have to actually do
>> "mutex_init()" followed by a "mutex_lock()". And obviously unlock it
>> after doing the setup_sysfs().
>>
>> But I question whether the lockdep test should be done at all. I find
>> it distasteful that it was added with absolutely zero testing.
>>
>>
> I just realized why I cannot reproduce this problem on my testbox.
>
> In order to test the original patch with ACPI passive cooling enabled,
> I rebuild the kernel with customized DSDT.
> This taints the kernel, and clears the debug_locks, thus I didn't get
> any lockdep warnings...

So I was happy when I got a Tested-by from Rui on this and I didn't 
double check.  Turns out this was a mistake.

Cheers,

Rafael


