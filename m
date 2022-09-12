Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8955B5C39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiILOb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiILObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:31:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EFE22D;
        Mon, 12 Sep 2022 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662993078; x=1694529078;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4WYVlZirzcxhdk9ABqpgzzJils+Y5jF47Kf534SPtbY=;
  b=LcNEHIMjMgifzT7EYZFqxhTq6dI3Z3kF3poJcGcCCzIbq2Rqx/a7+oxc
   Ll9SRzfAJGUUGtIq4g24HhxjqI7RzqueYzYS/3fFKJVknP7+uaP4gW0ZQ
   zU5tgFnl+drNT1UUiMav9GaYstUYgZqKGzFk24kCMn572yUi27Aq7vHZC
   ZQG63CZ3Q2yAPH7jLR0yKua7MdxQZY91mAcyMSp7Vj/KSKp/rIH2A2RJD
   8w/X+TJQGum/7l3nRLEttH2spVmBu2GtuBdrwwSMYprjaExhREi5ttCzV
   nrYUs+mJQTvM0O/JdAzO9TES5or6/2UNgTA/3WdtBk7GePRWnEnWm9yVp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324110997"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324110997"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 07:31:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="646479191"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2022 07:31:18 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 07:31:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 07:31:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 07:31:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/+/hm4kt6BzRsjWpR6YAKSc/TqIfgCAvCLevE4SB+VBZI7C95viD/JWSl3Fz4M3VIlcnneyNVuoHtPazkiVPeskZLh0qirxvYbI8xBZPfSKnFFWWP8cdvXhGRWMCu1O8swAF9qxJB+2eVbtX58hfzLQaXU6vXwz7mEt5SW5bFr6nH5JR+ba/uSYt7aOpd5wBlNLRqhuM+CYATOzU4d6Rjrxt95tWV65uUowKepQu8csUWYgbWrFGPdDyi9FSoGlw1rQB02+VWkkeB+h9yZeEc51YxoYlMK6HfHzUtiT6B4hFS4WL6PAYbf1TP8d7LYcUzKHRIuRvA9/TtemUhhUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5PcxAuwgIpgHOAMfsUbVdP35bmWFKa+45N0FZhCFmA=;
 b=h7XOCQKCF0zWy735j5cf83gP2XpOpmokLg6trW+uANk3EV5/7ItyXVeoN2JBGKY+DWOH1HacR0BMAPadZ58nwG3wdbSM7diTrDSUxTiBgIDPiGHaGVAPo9K9xkJ1a5Kp6HWYCn8qqHcBqidfmejULVcLh5Mx+w1wYXrjcADAFynCpa9iFFKVC6boOXmMGioSuxmkR+cmp18A+ZpfUHlJMy83xP6CiaDL1CpOUWirqVhBkrDmEUnojLoC7QdyACcoA6/hW5czhKz2lNeXCFmdjgfHtzbPnuaANZBOAbhLZ8PJBuA7SJ/SdPA7iDv7AB7tk2bRAXrdgC10i5ywcX1NJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.19; Mon, 12 Sep 2022 14:31:15 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 14:31:15 +0000
Message-ID: <ce358ac4-a473-158c-ccce-c50af813fb6d@intel.com>
Date:   Mon, 12 Sep 2022 07:31:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/intel: Clear SGX bit if both SGX driver and KVM SGX
 are not enabled
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Kai Huang <kai.huang@intel.com>
CC:     <linux-sgx@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <seanjc@google.com>, <linux-kernel@vger.kernel.org>
References: <20220909080853.547058-1-kai.huang@intel.com>
 <Yx8OTDwhqbgvGp4p@kernel.org>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yx8OTDwhqbgvGp4p@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0059.prod.exchangelabs.com (2603:10b6:a03:94::36)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM8PR11MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 98405c45-322b-4709-800c-08da94cb72be
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snqCDlHLZJEdL/h5UlMc57/P2LAlHKOOaXhqGjNGwVHE7658eLzx/aLLYMjQippVhHCdtD5AeHk1aG0w1hJ5gd1hb08s7sgb9wAMR8cUmRGw7XB82JQBbE9pTopmB7csc6KHlAoCxzNCq5k2Fd0pGZ7ca9DBIs79BAoLPaEDI+Javb5qWuC/si7xE8VrAjuAfkQse0AAy0bxs9AFk+VYgn46gyyG51ofzxHTMALByAeNv1+3KmtjVzQJJshVTslM56zVo/rXrKV8el0rMVZBwX7uvIkhxE3HEx2WDSnZxLlBp4lq0yodbJU63ox7lxaQksaId8U9MoN5FVp8NVd0rjGK0NG6PvzO8vXxSV1qKFbsXMPmGS0nCoryH/rYkWi0AseofWBxZ/+IrAYf+abrUVr+SB2MJCLWdKNXyCFLy57thZc5mI0Iu26LdCA6F9WAUSiVem0cYEQsQc053Hn4E6gq9L+FDHqiQzN1g4liftODuAlmxgLJvi8twyOlS8UZlTv6jpUsQ6kr3QyOXW0eGdcEAa9VFlJGowvb2uz87GtanlE5xk6ChWWYfOBitPv0XRA8TdXbZQPdbt8kNkrfjG9jdikUDzZ++VPuKw5QGVhfvOKcLH0C3Cwr5PfB3i8w8gLUoEUePbT8/8O5qQL1Au2ELBJTofrH/UWBM3D6ToSpiA3VCpVXYvZy8mBCOA5HPka4Djdb9SOLvOb2o3hbf253UNejlmWYLvXLhR7gDeuJwQl5uF2UxumT5B3X7F7iEV7vJOiGveSmwJsZxW7w1aDDuUrSFOkkI0ctWY0CbHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(136003)(376002)(366004)(39860400002)(53546011)(6512007)(478600001)(6486002)(26005)(186003)(83380400001)(2906002)(2616005)(110136005)(44832011)(5660300002)(8936002)(316002)(41300700001)(6636002)(6506007)(66556008)(66946007)(66476007)(31686004)(38100700002)(8676002)(31696002)(36756003)(4326008)(82960400001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkdyUUtwV2ZJa21hVUJzaVAyTFp2WXlSKzdBNU5QZUd4c000TTZjZjNMUTgv?=
 =?utf-8?B?ZDhGb1I4UUtVeTQ4VVFZUnREL2hvUXRzTmNLanJYbGRGd2V1YXpXM2JSUU00?=
 =?utf-8?B?MTRjUVJXc3V0RlE1QXdzT29oVE9RdnhaOWM0RGdGdTl0M2FkUkpoc20rV2FX?=
 =?utf-8?B?MXNraGJFbDJNWnV1K1l3bENtMHNwb2dOUDBuVWg4QVl1d1dBcVpJc1dRVFpa?=
 =?utf-8?B?MnFtdHZxUERjaXBBWC8zRzhFUUQveE1IUDd2NGNOU0JHSjg1SCtacDJEOWh4?=
 =?utf-8?B?bEpUWFB3Ky9oY1h6ejd2eHlLNnJUTVVhV0lTYnd3OERkdzBZMDdQREpWWjhY?=
 =?utf-8?B?dE00NUQwci9FZ3R6KzFvUGVJeFZ6ZmU0bUJkQkJzZmtCaldDek5WWnQxY1pr?=
 =?utf-8?B?VmMyRlN1QitNNk5HZ1Q4dWo1ako2aHd1OVMrYlpXb2Z3cW1BYjNXdVphMEFK?=
 =?utf-8?B?dTl5VmhsRDlpc2p5MzJHQk4rbEdWd0ZCc3Rra1ExMGIvdnk4dHJlNEl4bGdJ?=
 =?utf-8?B?UmRQQ0pTeWY2dmpDR29rLzRtbnFEaG1QOTJuc3AvY3g4SU9McUhBUnlXZHl5?=
 =?utf-8?B?aWxtbVVIeFdNLzh4RmhieGlsMVBFa0Z1WVVQRThWS20xMlY4Z2dFaVBxRTM1?=
 =?utf-8?B?TTdCbTB3cDArNk5BQlRLTEdvSk5WNXY1M3NIT2Y3VDA4dWZyZHFRT3puMFZF?=
 =?utf-8?B?aFNVazhjTzlTTy9DdURDYVZDVzB1b2VTbmQ3NjVtaGRnNjVJRWZDOEdRcXpr?=
 =?utf-8?B?MkdDUTduMVBpaG1DVkVFTGdMcnJ2WGp3dmZqMHQybEdUOEFYK3Fjc1g5am5P?=
 =?utf-8?B?TFhMNFl5NEZzWnNmZFY0SjFsU3VyekliSzV4cGNJMGpaVnpVQ29oNEZvVlRG?=
 =?utf-8?B?OHhuM3lHc3V5MDZWT1EyRkRoQUJiT1Z0ODR3ZHZSQU5namFrT3U5VHBFamtv?=
 =?utf-8?B?MVBiN2gya0RLaUlocmdyUGFmNktXenN5K2Y0YTBaZFk1bTdlOXMrQmMwNjV6?=
 =?utf-8?B?UE1Kb0VwdG5zMlpLZGcxaDhrMmNtTTNCZXNNRjA3V1M2TzRsQkp1NXpDdzJ3?=
 =?utf-8?B?em13OFRkM1lRVUszaUdUMUQrU3BLdGVlK1d5eXV6VGlCYktJNGVYV1RKeUlI?=
 =?utf-8?B?RFN5RzFYYXliYnhLMVJ1MUdQY2R6RDVaOG5wSnZiS0xLcFRueGVwY3Y3bXcw?=
 =?utf-8?B?MDhwMk5WcGZ1WDN6eEZxRTJBeS8vY09mMnBLTkdVWWJrZnB6TG90Z05HY0J1?=
 =?utf-8?B?blNGR2JEVTVqMWFHY0lxcWo3UFJ4OUJVVCtDQ0tYUVgxam1LS3NGVFZoMWpm?=
 =?utf-8?B?WEh6Q3NZa0tNb2kvbjNEOEgvaXlsTXlsMndndVA5ZVEvalNXUnpTY3BUNEZl?=
 =?utf-8?B?VXMyWVo1aE1BQ3BoWUhMZ0I5VHE1WGNkNCt3KzJRSWQ2MHlJbCtydnhsRnRZ?=
 =?utf-8?B?MkZnakJKM0NtcS8wbEVoYzI3bUwzelY3WEdYdDVGOGxXODBKY2xmenVLZ2dI?=
 =?utf-8?B?WDExMCtIMmtNZSsvOWR0WlF2akRNMzYxL3VjWC9hRVlseDNwQnpHWlRjUlpN?=
 =?utf-8?B?SDdsRmIzQk1BNWFMa2ZNR1B4TllDcE5XNnV5eFRnZTJwdlNFSGV4QmN3STli?=
 =?utf-8?B?Z2RWa3lZejJpaFdmNCs3TUJJbzFidVNicXA0TEkzWEw3Mk16M1RoTEpSM28v?=
 =?utf-8?B?YVIxQy9ZUVlIVHR4MXBCQ1hSbWN4eG4yaFlJbEdYTVJ5R2dKZ2xlNWNTZ0RO?=
 =?utf-8?B?aWJFdmR4RjlFM2szYk9aRjBBK1A3YTdrbWoraGVId0o0RSt1OW1uQzRxNnFM?=
 =?utf-8?B?VmFXaGU2TERwVzE5dzltWU1Xdi8yWlYxT1B1ektzNVRiQVIvVVJYTlA5NnIv?=
 =?utf-8?B?M2ZBZjhEUkI1bHFORlBXTmludjRVcVM3K0s1cktybWgxQXc0YUFBMGpORmdV?=
 =?utf-8?B?c3NiTFRGR1lDUURSaVdxN2dWTjZ0OTZOQ2h2bEYwdUM0ZGdSM2ZsRHRlMkV0?=
 =?utf-8?B?dWxLMEQ1R3ZDSzNFeitldHRONUtZdVdTbDVEc3R2eDBGQzNsNlM3Ukc0dFdw?=
 =?utf-8?B?cWtCVTllcUpma3hLeHFuSFJjNTFvT1NpazFjcnVVSytWT1dmeG0xa1NsVDZp?=
 =?utf-8?B?bVhUdnc5aDRhR29GTEhEeWRjSWxMMlJWd0pBc1gzQmF0VEN1eHNGTU83bzFx?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98405c45-322b-4709-800c-08da94cb72be
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 14:31:15.2268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc3fLJjbyhSdJmG7rk0imTPq+z1fRflV+CEBw0jwlgMDD3X0JGE6a+eIR13/hgkixEA2JsW2d0siMqey0NzMaaublsve9Qn+E5lfNJsx2vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5687
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 9/12/2022 3:47 AM, Jarkko Sakkinen wrote:
> On Fri, Sep 09, 2022 at 08:08:53PM +1200, Kai Huang wrote:
>> Currently on platform which has SGX enabled, if CONFIG_X86_SGX is not
>> enabled, the X86_FEATURE_SGX is not cleared, resulting in /proc/cpuinfo
>> shows "sgx" feature.  This is not desired.
>>
>> Clear SGX feature bit if both SGX driver and KVM SGX are not enabled in
>> init_ia32_feat_ctl().
>>
>> Signed-off-by: Kai Huang <kai.huang@intel.com>
> 
> Is it a pattern that flags are cleared when they are disabled by the
> kernel? I don't know the answer for this.

There appears to be relevant text in Documentation/x86/cpuinfo.rst:

tl;dr "In general, /proc/cpuinfo shows features which the kernel supports."

Longer quote:
"If users want to know if a feature is available on a given system, they
try to find the flag in /proc/cpuinfo. If a given flag is present, it
means that the kernel supports it and is currently making it available.
If such flag represents a hardware feature, it also means that the
hardware supports it.

If the expected flag does not appear in /proc/cpuinfo, things are murkier.
Users need to find out the reason why the flag is missing and find the way
how to enable it, which is not always easy. There are several factors that
can explain missing flags: the expected feature failed to enable, the feature
is missing in hardware, platform firmware did not enable it, the feature is
disabled at build or run time, an old kernel is in use, or the kernel does
not support the feature and thus has not enabled it. In general, /proc/cpuinfo
shows features which the kernel supports. For a full list of CPUID flags
which the CPU supports, use tools/arch/x86/kcpuid."


> 
> I could imagine that sometimes you might want to know whether the CPU
> supports a feature, even if e.g. your distribution kernel does not.

Indeed ... this seems to fall into the "murkier" part of the above quote.

Reinette
