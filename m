Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F6473228E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbjFOWNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjFOWNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:13:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E9DBA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686867201; x=1718403201;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uMcnyhk3g/K552B+SzZF0W6EONa/jQYa0so0GEqkCtw=;
  b=imxQVlM/BjR0bgam0FoX0zIr+h1ku4fCaqCujYGPVQYDEoTxd4OzC1Tv
   B9mgAW19W1oyTEQL0bp0DHlBYe7Cz265D2cBycMZj1+LxXVPvUUfyQBU4
   yyCT4oSZfuFT8wRUp2k6/h5FlAwzckIxeKmhbl+tLb2QeGvOdVA1T3bam
   y6dQa0/d2VW2LJgSwlr9zWgkTnlmzO2pCFtkJW8O3aYlu8Szuc/TcdU3R
   7l5Y/JOyLc7JjjvxkLMZ9t2ciyqvEBNGtB4WKT/rRo4Cw/JSmDzEHJCdx
   w+u1zq8WlmBB4t4lp+mmVgkPYPGtx4YvhFxakq6/p3DmptX+rWyW4U0d2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356543533"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356543533"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:13:21 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745846305"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745846305"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 15:13:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:13:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:13:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:13:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nssNI2D10GEl3H1QlBDH5a8TdPd938yzfjHECVoAAXOGrdeYdx8TZbDaUTP/DIy2l+hMis5DG9FMOKoZGJn9RK9yVmjr56Sh83lSJal2/f/aBjDD09wUJQnTob9TYJD789fZsJM4tCajKD0xPdwIg7GPlWsxVQdpyeISASOWSKkX3u8wEaM9A7OB0GeOGnPFCgiGBmhkppjvd6zAY/xI8RW12GHyYjctKmq4L2z2TyDiEome2RF/sC3A1xTSs4MLiL4unp4fh+vDBATDkW1YVsgXNx5LjziKfQeJEGfuA2fMd+swxetNqmM/0KUcYDPE0F88PwAZh4hFqUpTUMD5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1kmXAoCsRSdbQjx/SRhceudY67xZYTlYym0ZM3/tkc=;
 b=kqKWjGpgSTYUnC8jvDnNrAaI0cGcjA2I5kljcBsVWAkne+EGtWXnbkY5FBrdU6QLEWTCiiQjvLbrT2aj6VhfzkAFVD7uShrd+Urwx/l5jc1n0pO31uPhrWmRYFmSPFKBAS/gJxA7oWzdCFzyUNBXbkzsqtgAVEQN0/9Ha31Sr12coELUfApQeoCpUsdzi/73sWKq4f8zEXs0Jeg/XSdborGzkfnt3/erPqZuQaUvwe0gOumwpZ48zFmRMuwkIDumFdJ58Eh2UUEiQUXsnIlD2C7PJ6zaG5I4MM4j8xTt9CdZHnvXJ/CNvUN9dFUIfKEM2fKSt3OZvaxMSF4jBbJYFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6367.namprd11.prod.outlook.com (2603:10b6:930:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 22:13:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:13:12 +0000
Message-ID: <201aff6a-7bd0-e0e6-5ee8-1b9eab223cb0@intel.com>
Date:   Thu, 15 Jun 2023 15:13:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
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
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-15-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-15-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 48043e76-973f-47a7-5117-08db6dedb56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67s1Lr+TwkdAV61pnU5WvcG4l708/QMOXUlj97oE2q+gpUI4rcBeHEiL4nK803oHuLC6dsMZiRoh+1Hrb6b7Gs3LG0gj54xjBGDQxuEqSgyabkaT5Y9gPVXRHFztCE5GCsY3Lv2jwy6iL1b8ZvM0cmmUuNO0mq0Mw6ApYTDozARKvPgRNJMc6IH61ul0YTMARGCj7IT6H2/IePp+pZm8GAhlNYMxAT90vl+kel2+Q07p1S31HFmuVkVt/hTYYUSP49mD2eN5NQo3nAMCMB/9q71b6sb70hnD7QgBtboQt2xEHpP2KCfxcxuivF58qJdQCXgUeP/h0TYQ19DQFH24ezhoVU+jiFNzftK5lltZLNXu4WqDLX4YZJUq4CVbpOZGlhI245Z5FCaRHwfDE+Q2Vk1rkk/Ecq9pyZoxpajf6b5ONC7i2afahAa8pK2iTqOZIsjJb8tvlNTeG8HbOsMmdnnQ8E8rY00x7zJxC9y8JMbfUjKnPsp/HX5X7FsLy+N141nBeZjb5ZAQVZbVuSmuJFb2L/86n1hpdjnDL+leefXiHNv1q3/C48uUS9sWdKx8MwgiTemBIgH6c8yXURQNhoc7oRGjzBHIZo5kaWjUjphJ9cLhKEiCGec15YOAsSXe0A5bt2jBmjS75+drrLUBsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(31686004)(4326008)(66946007)(66556008)(36756003)(186003)(54906003)(478600001)(2616005)(2906002)(66476007)(316002)(8676002)(41300700001)(31696002)(86362001)(6486002)(7416002)(6506007)(53546011)(44832011)(8936002)(26005)(83380400001)(82960400001)(5660300002)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1VtemptVkE1bUNnQVJMTWFJc01qUzRLb1czWUx6OUZmVzNGTWk2ZVRLb0ZD?=
 =?utf-8?B?cHRHM3dvUzArT0VoWFA5eUJEbkRqZ2NJUmczd3V5TmRWZHNHRUUxUmQzRFlH?=
 =?utf-8?B?TUFoc1QxRjZMNkJiSkUvcGRMeUpVdnFGUDJGaE5FSms4cVZhWExRbk9nQzlJ?=
 =?utf-8?B?SDhDTFFRU09DOWNWenM4cW01dXFOaDA4ZDNKQWlpM2RtNE1rWGxxQU4vbnlT?=
 =?utf-8?B?R3FsSlNPYXpwdnI1cTFRRmtBeFB1SDVyTDVyQ3hjQXFQUXJqWWNLcUpFSlBt?=
 =?utf-8?B?cU9wZXh0cHhXa2puY29sVU1CaVVYb0svRXp1djAyaVJmcE43MC8wa0QwQ3hY?=
 =?utf-8?B?eFZJNUJvZTNaNC9EcVlDZHFNZ1Vsa0FKUG43NHN5TkpVR1dhSTNINGhJZ2V5?=
 =?utf-8?B?YkpBWitYQVhlVEd5NitINWlyM1NOTndxWkF1L0RPOXZFRC9JR0dIUjNSUnIy?=
 =?utf-8?B?aW1CVDdjbnR5M29xZDR1YWRUVi9VTnYrd3ovYXJHUUNyNExCZndzdzJxK3FV?=
 =?utf-8?B?b2cxank3ci9ja2MzZ1piblFYVnVlQzdKYmxNbmJWNHh5dWk2b2RJRXROTWdF?=
 =?utf-8?B?YUtHeG5IZFJRMVNpL3VEUFdyTkJZSTdvQ0lRUWY2VTU2ODByM1o4ZHNQRkY1?=
 =?utf-8?B?NGZjTTQrV25TWkt0cTNaeHpZZ2J0dFJzSlpxL1gxNUxQdmRsUnZtbG1QVVpp?=
 =?utf-8?B?U3R6V0RsSHoxajY2aENUZTBMSWppQ0ora1k1Vi92KzBaYlNDbTY1M2cvcHRE?=
 =?utf-8?B?c2ZWM1FBRC9uR1ByYkdXZlhGWnkyTzJia2F5WGNJZWhKaGVWOWFrcVBubGsz?=
 =?utf-8?B?dFRid1laSU9KMEdkSStPT2NnMS9rWXllamJJbWJTakFRbzJkUTBtbnNQUmpk?=
 =?utf-8?B?VFMvVEhDUUZPOHdPeHVDSjlWOHBPakVvWXVyNWM1OGRiMkZiT1dWY01uSExE?=
 =?utf-8?B?Ny93YnhIOXljS1drbGo3OGt1MldmUEU0WlNQbzJ2NTF5SUEyd2NFbGNOOVF2?=
 =?utf-8?B?WEltN1FQaURTMWNlamYxTkJxdFBhNUQ5Qm44ZHNiN1hDeHpqV1RYbWthRTN2?=
 =?utf-8?B?ZldkeEdyTkdoc2EvRVhCNXpTTGw0OUJDTXMvMU0wVWhvSlVKQzRSM1ptWVhV?=
 =?utf-8?B?c1VZVHR2QnhQNFQvOUNOYndlR2hCUXJwRXZTOEJUSmU3ZGlUMDNjSVQ4N01P?=
 =?utf-8?B?Z2NTMDhsa2JpTVhkRWlBSEI2dGwwY1UxTCtMcEZWcC9CeFh0SDNFeFJpdGRO?=
 =?utf-8?B?dkVZTkNlWWJQbWFTWWh5ZHo1RGdOdmVsRHZXUmN6YlIydG11ZkZueHZZQms5?=
 =?utf-8?B?MFFmV29IVVRZUndsd05OR3VtV0h0RmZKOU1kTW16OG1JUVlESGxZVStUd1kr?=
 =?utf-8?B?OS8vNER4eE1uMVhNcHFkc3Bkd3hWaUVEd1dkMC9abUFsSm4yZVAyWVU0QlZn?=
 =?utf-8?B?aHptTk9Id2hESWMwZEFOLzZBZ1B0cTdRN25SOENsNnZ5WUV5b3ROZWFYY0NZ?=
 =?utf-8?B?OEg0SVdMMTJuTk1hUVl0b1BTTjNHVVlnK1VUT2ZNUDhHZTFCVkJOMHl2aXBB?=
 =?utf-8?B?V3hwZ3Y2M0FDeHJpYlBZM2locHdWME16cHNEK3l1WUhBMGZHN0xNTVhldmNo?=
 =?utf-8?B?VStwa3NMQVhDOXZtRDAzLy9zOGZNaW5pNGNDMjFuQUduSWFLV1JTOHdwNnEw?=
 =?utf-8?B?T0ZKQUR0enlDckNrWXdEbVBIYVlZdXJvSlF5MFlEQzIxNEMxbzVDVU5DYkN0?=
 =?utf-8?B?ZzhoOGNERm9qQUtoNWdRQjRQVjlhY1JvWitPc0ZjZzl5cU5JU2JhOGVEcExJ?=
 =?utf-8?B?OE5ZeUJZYmVTb3BhakVGbk1XTUpnQUZ5NGtyRFFNcFVSMU5TLzFxaUloNTdR?=
 =?utf-8?B?NDc3bWcvYU9qbXEwUzhnVi9ESjdrR1FhdThQZFd1VElnUWVqbFBXM1JEcjNM?=
 =?utf-8?B?L0EycW0wTkE4dmRWMzhPdHVCdFZxa3E3a3JXNkpKVlUwR1phMDMrSVE3dFFC?=
 =?utf-8?B?cE1SWXRMSjEyakxqTGRMSHBYYk9BL3M3N3JHbU5sZ2RuaXE4ZEdDNVJrVXdW?=
 =?utf-8?B?SG84SThEUXUzbWEzNHNNUlZWdXJPbzZTWVpET3hmWk5qNjRMS0VnZkhJek04?=
 =?utf-8?B?QXJMdytnNXdWTVBRWXdOQ3lpUkgrS3JRcmlmOER4S3Bla1NDSmZ4Q3FZWEd4?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48043e76-973f-47a7-5117-08db6dedb56e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:13:12.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eA6AVDTc24unkAFrwo/ZB0Omm9oBsSekuDGlJPfxnLIKlagmzQUF0doNt3w3mSk5+vfccZs4JGc2L6AGNvIpcFCIxMNgtNoFLq595oZkd5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6367
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/25/2023 11:01 AM, James Morse wrote:
> MPAM's cache occupancy counters can take a little while to settle once
> the monitor has been configured. The maximum settling time is described
> to the driver via a firmware table. The value could be large enough
> that it makes sense to sleep. To avoid exposing this to resctrl, it
> should be hidden behind MPAM's resctrl_arch_rmid_read().
> 
> resctrl_arch_rmid_read() may be called via IPI meaning it is unable
> to sleep. In this case resctrl_arch_rmid_read() should return an error
> if it needs to sleep. This will only affect MPAM platforms where
> the cache occupancy counter isn't available immediately, nohz_full is
> in use, and there are there are no housekeeping CPUs in the necessary
> domain.
> 
> There are three callers of resctrl_arch_rmid_read():
> __mon_event_count() and __check_limbo() are both called from a
> non-migrateable context. mon_event_read() invokes __mon_event_count()
> using smp_call_on_cpu(), which adds work to the target CPUs workqueue.
> rdtgroup_mutex() is held, meaning this cannot race with the resctrl
> cpuhp callback. __check_limbo() is invoked via schedule_delayed_work_on()
> also adds work to a per-cpu workqueue.
> 
> The remaining call is add_rmid_to_limbo() which is called in response
> to a user-space syscall that frees an rmid. This opportunistically

rmid -> RMID

> reads the llc occupancy counter on the current domain to see if the

llc -> LLC

> RMID is over the dirty threshold. This has to disable preemption to
> avoid reading the wrong domain's value. Disabling pre-emption here
> prevents resctrl_arch_rmid_read() from sleeping.
> 
> add_rmid_to_limbo() walks each domain, but only reads the counter
> on one domain. If the system has more than one domain, the RMID will
> always be added to the limbo list. If the RMIDs usage was not over the
> threshold, it will be removed from the list when __check_limbo() runs.
> Make this the default behaviour. Free RMIDs are always added to the
> limbo list for each domain.
> 
> The user visible effect of this is that a clean RMID is not available
> for re-allocation immediately after 'rmdir()' completes, this behaviour
> was never portable as it never happened on a machine with multiple
> domains.
> 
> Removing this path allows resctrl_arch_rmid_read() to sleep if its called
> with interrupts unmasked. Document this is the expected behaviour, and
> add a might_sleep() annotation to catch changes that won't work on arm64.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> The previous version allowed resctrl_arch_rmid_read() to be called on the
> wrong CPUs, but now that this needs to take nohz_full and housekeeping into
> account, its too complex.
> 
> Changes since v3:
>  * Removed error handling for smp_call_function_any(), this can't race
>    with the cpuhp callbacks as both hold rdtgroup_mutex.
>  * Switched to the alternative of removing the counter read, this simplifies
>    things dramatically.
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 15 ++-------------
>  include/linux/resctrl.h               | 18 +++++++++++++++++-
>  2 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 6ba40495589a..fb33100e172b 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -272,6 +272,8 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	struct arch_mbm_state *am;
>  	int ret = 0;
>  
> +	resctrl_arch_rmid_read_context_check();
> +
>  	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>  		return -EINVAL;
>  
> @@ -462,8 +464,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>  	struct rdt_domain *d;
> -	int cpu, err;
> -	u64 val = 0;
>  	u32 idx;
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
> @@ -471,17 +471,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>  
>  	entry->busy = 0;
> -	cpu = get_cpu();
>  	list_for_each_entry(d, &r->domains, list) {
> -		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> -			err = resctrl_arch_rmid_read(r, d, entry->closid,
> -						     entry->rmid,
> -						     QOS_L3_OCCUP_EVENT_ID,
> -						     &val);
> -			if (err || val <= resctrl_rmid_realloc_threshold)
> -				continue;
> -		}
> -
>  		/*
>  		 * For the first limbo RMID in the domain,
>  		 * setup up the limbo worker.
> @@ -491,7 +481,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  		set_bit(idx, d->rmid_busy_llc);
>  		entry->busy++;
>  	}
> -	put_cpu();
>  
>  	if (entry->busy)
>  		rmid_limbo_count++;

Would entry->busy ever be 0 after this change?

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index ff7452f644e4..b961936decfa 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -234,7 +234,12 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>   * @eventid:		eventid to read, e.g. L3 occupancy.
>   * @val:		result of the counter read in bytes.
>   *
> - * Call from process context on a CPU that belongs to domain @d.
> + * Some architectures need to sleep when first programming some of the counters.
> + * (specifically: arm64's MPAM cache occupancy counters can return 'not ready'
> + *  for a short period of time). Call from a non-migrateable process context on
> + * a CPU that belongs to domain @d. e.g. use smp_call_on_cpu() or
> + * schedule_work_on(). This function can be called with interrupts masked,
> + * e.g. using smp_call_function_any(), but may concistently return an error.
>   *

concistently -> consistently?

>   * Return:
>   * 0 on success, or -EIO, -EINVAL etc on error.
> @@ -243,6 +248,17 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>  			   u64 *val);
>  
> +/**
> + * resctrl_arch_rmid_read_context_check()  - warn about invalid contexts
> + *
> + * When built with CONFIG_DEBUG_ATOMIC_SLEEP, this function will generate a
> + * warning when resctrl_arch_rmid_read() is called from an invalid context.

No need to say "this function" 
Could this comment be more specific about which contexts are invalid instead of
just referring to it as "invalid context". This seems to expect the reader to
already know what an invalid context would be. 

> + */
> +static inline void resctrl_arch_rmid_read_context_check(void)
> +{
> +	if (!irqs_disabled())
> +		might_sleep();
> +}

Could you please elaborate why the "!irqs_disabled()" is needed?

>  
>  /**
>   * resctrl_arch_reset_rmid() - Reset any private state associated with rmid


Reinette
