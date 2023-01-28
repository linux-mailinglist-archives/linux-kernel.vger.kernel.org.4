Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87E067F3C2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjA1Bhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjA1Bhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:37:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD610A81
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674869852; x=1706405852;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lx4HoUnl5/zqb3dA29GMw7tV5pu+Vuduater0H24ld4=;
  b=WiPuuQdYjbTtb7af/qwDZfTArhhTljs2k5/xl8OvmiBez09w2cj3k/uN
   LJMN4VlycJO52Q+0biRrUhXHlQOi1/75tgF45xHOObAj7oq2ckRc/xLn+
   zBIbC5OLBvUOc4dmV/pZ9iV1OynovqynogmnMls6iTt1XCkeDPaWJjGHn
   Fa5iaOmKPQZVtwLgz+XHNMZ0rfQIqB0LUNLd3D0NdW8uJtNXebrMXjN3n
   ezUGxkCt6XqjVOfBEUUYtrDjcEOc6h6X8IOwQ4bhvkgPgqAerRiVe1ROz
   RY05gUFXwXL8vTGXB03QUT3NNSOdpENY6yNjnA8wQaW+gxQhKSOd7l/+D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="306896131"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="306896131"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 17:37:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="656809908"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="656809908"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 27 Jan 2023 17:37:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 17:37:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 17:37:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 17:37:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4z2Nx1zpnvyn3ZcGZvkGi+tRdPIBir/jcAlCg9BOBDO1OA1UwiDBJQaFZVRYEAYxzzvFXzchwFy6r7Go4DjQ6dF1nPE6T8mqmN+cgC7VF6QWcRoFVbh7V3Rt5tuZD2uo+qK5x99KzAJwaLk9hlMBf2Uano/SOKrtCagqu8XWV3dUady4DIhcisqL1CYw5PdtT1EpPbrpzKLgOkpxkrotae3nbZ8Hho55DSvqZlxvv4uDeUZhonD/tztrpvjY5KQOWFVHQyBwoS3feErp620yqyl2OZ9WhUsqWqhta9HsuLCK8rzYR3j5DQ8RQzgLDDUdFxjYLkv1m0rElssiehTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDyxSaFzl5EgYEIANf70mIhFeLQuphAtWhWwP/TsiM0=;
 b=DPR17rA3AP9ope9CE/7pQOvD1IHrRkaZjt67w9pDM9SWmntgJbuy3T0g5K2C0RsZcWWCh2XCh7k2IEt0Cr3KNVhgUBreTTzQ4uQEhmhkEBfk4HIA4P8TwkvewIsmtanThF3DDRrlPm2HfR4/FIBBXeO06auEbCp1l4GZp+uKRgT3ywLJ4/EgNIJXdsBL+or2hslu5xbrKG+9DZd0dVTv/J0BvcBpo48StOaASLzWF1cVLEv0QpRaEudWXbhnTs7fROn8E1Y8OouWFLaz4tiq45w9xubWNkWMSvnnOrOQfsHb/FZiycIZaLQw3ETgOPG88pl+tfPxU8gf6GsqizWN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Sat, 28 Jan 2023 01:37:28 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%3]) with mapi id 15.20.6043.025; Sat, 28 Jan 2023
 01:37:27 +0000
Message-ID: <42194ba4-cc3b-c8b3-06e6-e2938df3a87c@intel.com>
Date:   Sat, 28 Jan 2023 09:37:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [linus:master] [apparmor] 1ad22fcc4d: stress-ng.kill.ops_per_sec
 -42.5% regression
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        John Johansen <john.johansen@canonical.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <apparmor@lists.ubuntu.com>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>
References: <202212311546.755a3ed7-oliver.sang@intel.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <202212311546.755a3ed7-oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc02db8-0fbf-438d-9f98-08db00d036c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OnzlzW9FTr/KTTtQRR0dRZp7ddhr6Twrw9djbDlVE5vR+yxOtGbrA7ylYHDNqqO9wkIDKEOZKbN9MODKwfQ+odkU2gilKGwv6ic7VTLfWbmwiFFSxRK1JOeBY6X3fBT3Cshy0HTNz1+clXbjL1yxWU6LsFVDtaQgf2zw2eMg9Q+8upQXozXiYpygiZqo8xDENXEByN4QGSkkPp3lXzbkHSXQOtUHZ6cbYTnt1A91uP6Cv0Y+Xzme687Ce5I4+iu+IzOBC8q2JIblmY3R4kP9sxaiSMu6PEwX7ynMaQ7o81oEQ/Dlg9DJOpZnmjoca5SFLSBZWgHt0biCbXNbHJeZAgOYZ2d0J+9KKTNOcvpqzsVeuHb/zpyUiQHr2OUMF27sd+m3M6ZEMMJDznLInHKMzBm59OB5VRWxdhujsErKe2szKmJGhqqF5jbNwBQDy+WGz3cYhUZRLWBkilCDOZXvqKvvlxNAKpDYG/pJhVa+2pcdG+j+JsInzDi0XEF6hxpDiOGWy9y/tZ4BHl4uwxHpMO7zQ5eQo4s7BANmXelx955FGY+cnkYmE1/vKa7UIiqsx4xNIL2JgGRHZ0L08+eEtBmrzGRsU1nkPytbT8CDPPWzuWNpK3S0ubZm8EKmAxK6LzxAt0w/lsFXYeI+3plNTDrisGKp152+tecOlVo8fszX5LHizuJ11g9nkxc44P1xAgEV2GAOFo1IKvtSl/iJyDAmfaSX3dphNU26G9ecbVAnK9PU02we4I2E9X0J8ZASlyoRjU+IEJawG6OrPlqxPsq3d0farA/eAkWdid/huEJrG/HKBk7oF6bTg7uL7eR6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199018)(316002)(38100700002)(41300700001)(8676002)(66476007)(36756003)(8936002)(66556008)(66946007)(4326008)(86362001)(31696002)(5660300002)(2906002)(82960400001)(6506007)(110136005)(53546011)(26005)(478600001)(6512007)(186003)(31686004)(966005)(6486002)(83380400001)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THpzYXhVMk94aWdxWko5TythRStnSFl1YkFFOFJTejNodktNNG1yWUorTnRW?=
 =?utf-8?B?bDV0WGJsRFVjODdmOGZwNFhTczUyczJSaEZ5NGQwM1VxdmRyRGhrY2tETEZS?=
 =?utf-8?B?T3dhK3RSRTZDTk9qaHIzV0xUL2pJemM0bnZENVhaZ002dXREdmt2VmFodjdk?=
 =?utf-8?B?ZEJhdElIc0JtbVhxUTJRNVJEVmszeDNMbmxjRUlJV3pWdDlFaElzaGNhV2dO?=
 =?utf-8?B?cEJ1MUdmVnUvU0p1NHNOb0trQU5hMGZJNnZYTW1aRmsxR0FZQU4yd1RUb2xo?=
 =?utf-8?B?NE51ZFBWUmFRbEdud3VwaFdMRGg0VWhUNXNyVkk1RC9ZRnVHMDF4d09EWnNa?=
 =?utf-8?B?K1hOemphV1c0S2E1RENpWjlmRmhBUm1qNnYxVEk2ZUg3VmRMZXJKSC9IZlI2?=
 =?utf-8?B?eFd4a2lCdkpPbWJXbWw0R1drRDE2WlVWUUo0SkdLaG5IcWdmK3ZYT01UZDVE?=
 =?utf-8?B?a2FuTW55aDZWbXQxU1pvckhIVmg1WnZKWnZJcE5LeWNNdFVGaXpUN2E2OC8x?=
 =?utf-8?B?UHJldENvOXZhWVVYbjVaUXc1c0I2Rjh6L0Y5MkQ0Qk5Xd3p2UHB2R3F2U0Fh?=
 =?utf-8?B?Mk02QnJHeWM0eG1XelhyMGgvU0JxUHlTNncxTCtMU2ZoQzVsOGFLZ1N6clVZ?=
 =?utf-8?B?SUluZHh5bmpuMWsvWUF4NFBhTkpFSTFFcG9YOXRHc3BWaWJuTDE5Z0ZVZS8w?=
 =?utf-8?B?MTU0ZGJpR1RqTHdlSHhOeTRrNU0va3VOcGpQSjI4NjF0UTdhOEJhZGttQ3Zl?=
 =?utf-8?B?RG5HSFBPNTMyYU8yVG5nbGhRanA0d2Y0ZDhsdy9uemZGUUY2ci9wU3ovV0xa?=
 =?utf-8?B?NDJvSFNsNWc5MzMrSjNSRExUMW5TWEpkYUxOR2JZUlA2M25NdTU3eE5JK09u?=
 =?utf-8?B?TjBwMUVEMFR1Q3ZFSk9LelY0dDdVSG1kNk15NEtVTFpmNjZCODc0N3AyS09W?=
 =?utf-8?B?QWpkMFJxOEZhSHNwNnM0MFBKSjVNWDhWTFRmNkt5RUhvK2xiU29wWENNN0NV?=
 =?utf-8?B?UWFLaEpOWWQrU0ZveEU4Nnk5cDBVU0tRUFduN2ZoNUlOOTJ1Y3dYSGVjZUFl?=
 =?utf-8?B?WTl5aFJrTERTQ3FIRE8xN1Q2UW1mdzkrMlRobTE3bEJGTE5sVElldEphODFk?=
 =?utf-8?B?YmRNbFdQeWJtQzg5WW1XckgzalVYZEpvaGRsWHZab05qSnBGcU9Kdm5ER0Fk?=
 =?utf-8?B?OStRcXk0UzBSZEwvYWJzcm80aGw4ZW5yTXF2Q2x1NVE3Q3NISGdkVU1oakxj?=
 =?utf-8?B?dFZFcFd2bHdRNkg3ME81WTV1bzQwOSs5emwwZ2R4UnhiT2VpQjRVR0VsSSta?=
 =?utf-8?B?cWRsZzc4OXBtZDBnTC9EMDNjZnkxcUkzSU9UNWpkVWtKU2lkRmtnZkhMbWZK?=
 =?utf-8?B?U1B2b1Q4ZmllZWFzZjJYUnNYNi94bTBQMWphWHJUUUVKZVhna2Q3UkN1SGdG?=
 =?utf-8?B?L3VMWlNndldZM1A1WU15eUhPUmhQWmZiNU5WM1RrVWRPTlNkY3I3dzd3bzJE?=
 =?utf-8?B?eXFHamlpTFpLdEtKZDUwdS9JT25aa1VYejVsQWdUck14dHZyQjJPK3Y0a1pE?=
 =?utf-8?B?UWRWZnl0TW9pVkZKNDNWQSs5bkhFc1dpTUZuWUdUdHcvVU5idmxMUW1Rbitr?=
 =?utf-8?B?NXVOZWk3dEdwcVpDd0JpRmJUaGJzamRDbmhscjdmY21kSGRnaTlHRk96UEYx?=
 =?utf-8?B?d21PdmNVNU5ibVJ4UmRvVDUrR1hXU1NOUDU0MUJUMDB6dG1zbW9LcS9ua2R6?=
 =?utf-8?B?YitodXZVWmQ3cmMxL1hkTTRHWmE4R0Y5OEJXRnRoZG81bWRPcndlZ3Z0NTlo?=
 =?utf-8?B?cmFHbFVQUjZiQWRKOENwb3o4dlRDRnk0a01vbzBXRXdHdE51cmwyMVZCN0to?=
 =?utf-8?B?eU5VZ2NLVDlhUXdXV0cyQWNnN2lmb0RSblFhRDBKaDM2NGQ2OXNRMjdlSk9N?=
 =?utf-8?B?UCswNW9palVzYkxmTjVwOVFyN0JOV0h6UHFkV3dPUlZhdS8ydmxJWVR5RDY0?=
 =?utf-8?B?ZEVHV3VlbjliaHgxZHdYM1RwQUlxeUgrOU5HS3lLWVo0MGlXMm1vbTY1azE0?=
 =?utf-8?B?YWV3U1J3OHI3TldoZytzK0l4Ui9CSjBnWlVuRXpNcU1pS0prQThnQ0xCaWFC?=
 =?utf-8?Q?2Wi+3gCrHlQpaFWyR7KO2r10D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc02db8-0fbf-438d-9f98-08db00d036c3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 01:37:27.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeKRmPWO2n2UXNQE6obUPfcLPzmGIX8pVJy/a5CDTs4jNuEqK/xdRK4JXoANWKdo3ck7wdq3ktYW1NQX46R6Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 12/31/2022 3:18 PM, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -42.5% regression of stress-ng.kill.ops_per_sec due to commit:
> 
> 
> commit: 1ad22fcc4d0d2fb2e0f35aed555a86d016d5e590 ("apparmor: rework profile->rules to be a list")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: stress-ng
> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
> with following parameters:
> 
> 	nr_threads: 10%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: ext4
> 	class: os
> 	test: kill
> 	cpufreq_governor: performance
Do you think any other information need be collected for this regression
report? Thanks.


Regards
Yin, Fengwei


> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202212311546.755a3ed7-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> =========================================================================================
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   os/gcc-11/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp7/kill/stress-ng/60s
> 
> commit: 
>   217af7e2f4 ("apparmor: refactor profile rules and attachments")
>   1ad22fcc4d ("apparmor: rework profile->rules to be a list")
> 
> 217af7e2f4deb629 1ad22fcc4d0d2fb2e0f35aed555 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>       2820 ±  2%     -42.7%       1616        stress-ng.kill.kill_calls_per_sec
>     511090           -42.5%     293660        stress-ng.kill.ops
>       8518           -42.5%       4894        stress-ng.kill.ops_per_sec
>       3778 ±  2%     -58.4%       1571 ±  3%  stress-ng.time.involuntary_context_switches
>     859945 ±  3%     -29.7%     604857 ±  2%  stress-ng.time.voluntary_context_switches
>      70351 ± 12%     +22.0%      85795 ±  8%  meminfo.AnonHugePages
>       0.05 ±  7%     -22.6%       0.04        turbostat.IPC
>      28627 ±  3%     -27.0%      20903 ±  2%  vmstat.system.cs
>     128187 ± 92%     +78.6%     228921 ± 49%  sched_debug.cfs_rq:/.min_vruntime.max
>      20901 ±107%    +124.7%      46965 ± 59%  sched_debug.cfs_rq:/.min_vruntime.stddev
>     -24201          -149.5%      11969 ± 74%  sched_debug.cfs_rq:/.spread0.avg
>      69818 ±123%    +170.9%     189126 ± 59%  sched_debug.cfs_rq:/.spread0.max
>      20904 ±107%    +124.7%      46965 ± 59%  sched_debug.cfs_rq:/.spread0.stddev
>       1.19 ±  8%      +6.3        7.48 ± 10%  perf-profile.calltrace.cycles-pp.aa_may_signal.apparmor_task_kill.security_task_kill.kill_something_info.__x64_sys_kill
>       0.58 ±  8%      -0.2        0.40 ± 13%  perf-profile.children.cycles-pp.check_kill_permission
>       0.30 ± 12%      -0.1        0.16 ±  8%  perf-profile.children.cycles-pp.profile_signal_perm
>       0.20 ± 10%      -0.1        0.12 ± 13%  perf-profile.children.cycles-pp.audit_signal_info_syscall
>       0.21 ± 23%      -0.1        0.14 ± 12%  perf-profile.children.cycles-pp.pause
>       0.18 ± 16%      -0.1        0.11 ± 20%  perf-profile.children.cycles-pp.__task_pid_nr_ns
>       0.15 ± 10%      -0.1        0.09 ± 14%  perf-profile.children.cycles-pp.__kill_pgrp_info
>       0.16 ± 13%      -0.1        0.10 ± 14%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
>       0.16 ± 15%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       0.10 ±  9%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.audit_signal_info
>       0.07 ± 18%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.alloc_empty_file
>       0.07 ± 18%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__alloc_file
>       0.11 ±  7%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.do_send_sig_info
>       0.10 ± 12%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.__send_signal_locked
>       0.10 ± 17%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
>       0.06 ± 14%      +0.0        0.11 ± 18%  perf-profile.children.cycles-pp.ns_capable
>       0.06 ± 14%      +0.0        0.11 ± 18%  perf-profile.children.cycles-pp.security_capable
>       0.06 ± 14%      +0.0        0.11 ± 18%  perf-profile.children.cycles-pp.apparmor_capable
>       0.09 ± 11%      +0.0        0.14 ± 23%  perf-profile.children.cycles-pp.kernel_clone
>       0.09 ±  8%      +0.0        0.14 ± 24%  perf-profile.children.cycles-pp.copy_process
>       0.04 ± 71%      +0.0        0.08 ± 18%  perf-profile.children.cycles-pp.__do_sys_clone
>       0.07 ± 18%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.__x64_sys_exit_group
>       0.07 ± 18%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.do_group_exit
>       0.07 ± 18%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.do_exit
>       0.06 ± 47%      +0.1        0.15 ±  8%  perf-profile.children.cycles-pp.exit_notify
>       0.29 ± 12%      +0.1        0.38 ± 11%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
>       0.15 ± 10%      +0.1        0.28 ± 13%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
>       0.36 ± 10%      +0.1        0.50 ± 10%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       1.24 ±  8%      +6.3        7.56 ± 10%  perf-profile.children.cycles-pp.aa_may_signal
>       0.28 ± 12%      -0.1        0.15 ± 10%  perf-profile.self.cycles-pp.profile_signal_perm
>       0.23 ± 16%      -0.1        0.12 ± 17%  perf-profile.self.cycles-pp.check_kill_permission
>       0.20 ± 10%      -0.1        0.12 ± 13%  perf-profile.self.cycles-pp.audit_signal_info_syscall
>       0.15 ± 11%      -0.1        0.08 ± 13%  perf-profile.self.cycles-pp.kill_something_info
>       0.16 ±  6%      -0.1        0.10 ± 20%  perf-profile.self.cycles-pp.security_task_kill
>       0.14 ± 11%      -0.1        0.09 ± 14%  perf-profile.self.cycles-pp.__kill_pgrp_info
>       0.16 ± 15%      -0.1        0.10 ± 22%  perf-profile.self.cycles-pp.__task_pid_nr_ns
>       0.08 ± 13%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.audit_signal_info
>       0.06 ± 14%      +0.0        0.11 ± 16%  perf-profile.self.cycles-pp.apparmor_capable
>       0.36 ± 10%      +0.1        0.50 ± 10%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       0.96 ±  8%      +6.4        7.38 ± 10%  perf-profile.self.cycles-pp.aa_may_signal
>      16.17           +18.8%      19.21        perf-stat.i.MPKI
>  8.529e+08           -30.2%  5.952e+08        perf-stat.i.branch-instructions
>       0.68 ±  3%      +0.1        0.79 ±  2%  perf-stat.i.branch-miss-rate%
>    7256065 ±  3%      -7.7%    6698864 ±  2%  perf-stat.i.branch-misses
>      13.08 ±  3%      +6.0       19.07        perf-stat.i.cache-miss-rate%
>    9361692 ±  2%     +16.3%   10884924 ±  2%  perf-stat.i.cache-misses
>   71450858           -20.7%   56687571 ±  2%  perf-stat.i.cache-references
>      29596 ±  3%     -27.5%      21452 ±  2%  perf-stat.i.context-switches
>       6.21           +50.4%       9.34        perf-stat.i.cpi
>       2974 ±  2%     -14.4%       2547 ±  2%  perf-stat.i.cycles-between-cache-misses
>       0.02 ± 13%      +0.0        0.03 ±  6%  perf-stat.i.dTLB-load-miss-rate%
>  1.408e+09           -32.2%  9.544e+08        perf-stat.i.dTLB-loads
>  7.763e+08           -33.2%  5.183e+08        perf-stat.i.dTLB-stores
>      34.02            -3.0       31.06        perf-stat.i.iTLB-load-miss-rate%
>    1109352 ±  2%     -18.6%     903511        perf-stat.i.iTLB-load-misses
>    2150307            -6.8%    2003881        perf-stat.i.iTLB-loads
>  4.552e+09           -30.7%  3.153e+09        perf-stat.i.instructions
>       4134 ±  2%     -15.1%       3508        perf-stat.i.instructions-per-iTLB-miss
>       0.19           -26.4%       0.14        perf-stat.i.ipc
>     814.65           -16.5%     680.21        perf-stat.i.metric.K/sec
>      31.63           -31.9%      21.53        perf-stat.i.metric.M/sec
>      80.72 ±  3%      +9.8       90.56        perf-stat.i.node-load-miss-rate%
>     325431 ±  5%    +970.6%    3483935 ±  2%  perf-stat.i.node-load-misses
>      79936 ± 19%    +323.7%     338676 ±  6%  perf-stat.i.node-loads
>    4260901 ±  2%     -34.5%    2792405        perf-stat.i.node-store-misses
>      15.70           +14.6%      18.00        perf-stat.overall.MPKI
>       0.85 ±  2%      +0.3        1.12 ±  2%  perf-stat.overall.branch-miss-rate%
>      13.11 ±  2%      +6.1       19.20        perf-stat.overall.cache-miss-rate%
>       6.03           +44.8%       8.73        perf-stat.overall.cpi
>       2931           -13.8%       2527 ±  2%  perf-stat.overall.cycles-between-cache-misses
>       0.02 ± 10%      +0.0        0.03 ±  7%  perf-stat.overall.dTLB-load-miss-rate%
>      34.03            -3.0       31.07        perf-stat.overall.iTLB-load-miss-rate%
>       4104 ±  2%     -15.0%       3487        perf-stat.overall.instructions-per-iTLB-miss
>       0.17           -30.9%       0.11        perf-stat.overall.ipc
>      80.44 ±  3%     +10.7       91.14        perf-stat.overall.node-load-miss-rate%
>   8.39e+08           -30.3%  5.852e+08        perf-stat.ps.branch-instructions
>    7111005 ±  2%      -7.8%    6555177 ±  2%  perf-stat.ps.branch-misses
>    9215998 ±  2%     +16.3%   10714798 ±  2%  perf-stat.ps.cache-misses
>   70327211           -20.7%   55796363 ±  2%  perf-stat.ps.cache-references
>      29136 ±  3%     -27.5%      21118 ±  2%  perf-stat.ps.context-switches
>  1.385e+09           -32.2%  9.386e+08        perf-stat.ps.dTLB-loads
>   7.64e+08           -33.3%  5.099e+08        perf-stat.ps.dTLB-stores
>    1091797 ±  2%     -18.6%     888828        perf-stat.ps.iTLB-load-misses
>    2116297            -6.8%    1971620        perf-stat.ps.iTLB-loads
>  4.478e+09           -30.8%    3.1e+09        perf-stat.ps.instructions
>     320258 ±  5%    +970.9%    3429628 ±  2%  perf-stat.ps.node-load-misses
>      78661 ± 19%    +323.8%     333386 ±  6%  perf-stat.ps.node-loads
>    4195116 ±  2%     -34.5%    2749032        perf-stat.ps.node-store-misses
>  2.847e+11           -31.2%  1.959e+11        perf-stat.total.instructions
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
