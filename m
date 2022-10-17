Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA2601C80
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJQWjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJQWjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:39:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9991F604
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666046383; x=1697582383;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NUhg5l4uiPzLnYDU231jrljBkyQovsX8w7WcTIY6pg4=;
  b=n7vPAYd5dTYvrbRKPyfZbCVqZKK5YBI4+sNRxOPJtXCSXqjBKaYMYD9l
   130jqeUgO9YiM1Z4NZ7d0bG1dHH6IHmx9+vsVUCdY1dcT9vlU0b8iEzZa
   bgNcPwH1DnyHsetjphDkdaQTyLaUoq1aeVqvzYTit/SOubJA0YTHY46mq
   hUsMcSNkK+iWVCJskwZ12611+acqz8awuaAfZ2y1ERBSBV+/oS4fmVlAV
   xk9X/yvF2pShO8E1vMwyQCU4VRH2wDxZrDoy8AQ+nevTcXJOtzpb/dvHg
   yXHwd6JJyIrJ1FWJy9c4C7WwtCJupQS4n203+SqkENGrSek4z92xoL7WD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="303551529"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="303551529"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 15:39:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="579538830"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="579538830"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 17 Oct 2022 15:39:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 15:39:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 17 Oct 2022 15:39:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 17 Oct 2022 15:39:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAdZWaCy1dE0KrrUP1dLSxIlR92e518MIkuymrTo7uL5Yfl6/ebLUFVeC38aKUdLx2L0E989Amlp6reqOhuHGmQkSbQ4bo8/ZUBwCbZtKtqMTgGO+I/uCm30cpmdYm90xlUOJi/pgpBVIkxpTmoERUJXM3AQJWif5GRkv5GyzAyf5FMn+ebE0jPS4QJoHTTidZxCMHgMOEHVXBxuvGa+279wilTCTfOcG8S/KwiIAuzv5qde3Fc3WEEmMYvPslXlwNB7Crqy2LNSKhRoYO+uOb9JGv9a0eCvSmMkNi02pNZDM4DVN6i05osn5u5bkFl+rgASgaX8dUn7cfHxCOUWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGcCFRB70Lmp4/9Hw75QSTFvAUonREmlREyECmkNH0c=;
 b=BNLOhweWWhzHC6/yyT495lD+9yLqlUt9IR7Ec7cbkR3f8EopRGrI/Ou0rLt6OxQJj0oEmpN+FYUmwbHwd2YaCNwCbm4smDpqbmxk2Sn0p3WbgCs4Q1AO2wzhluvu5k2/NfVYZ4sHaZ8yyYpy+Vlp1GrOCWYiSYripI0iJiArcOG97hzPLQDKXz4+6FQq8aIiZjhM0OZpqUgCvwLqAt/t5TuTJCG2JI4txuRrM9DMyW8t6mJkmLVUzebgT77ioCvcWmHUc7H8YYKQWXFpS0PhZdT0h6EvzbCyVjSlbLSp+5zKfUcAcBNOAE6oy+bkG4h8LnoTyI5m7ECS7Ict9xLzfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 22:39:41 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e%9]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 22:39:41 +0000
Message-ID: <1bb04108-a250-7cc7-e008-a227cbafdb15@intel.com>
Date:   Mon, 17 Oct 2022 15:39:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Content-Language: en-CA
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Yuan Yao <yuan.yao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20221011222425.866137-1-dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|SJ0PR11MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b03a355-7c82-444e-9acf-08dab0907ae0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3h9faTOuhd79YHRbIuv9ZpTUpQ1rHJsv2NBgzTQyknhYFPH2/wY/IOwqcjxw69ZWwnlHrevVRHijyXFjEKKCRisDrwbh5ToY4huZlT9oClDZW2vPCswvYN0Uo0RjIt01RoN/Oh9SCGA6xl6HzjtxUZ1CF6oE+IvQeUyWdaTTi1P93XFz0P6WVRCI0gg9oZuhzCrNWlwvztjr1YvZZR04MEvsXNcp/6O/BzUMMkiwBCMx3cLIIPG8PKWxiiTZuv/PsqgUrEBQl2yR/3sCpalXM75i61Z55ZrdR237iLJmZA7aVAC3RL2ALpj2xvsp9Jwwwl5c1rbEzzaPtoxTuojCZcbqTnRjkghA5jrYQD/UnWXRIZf5mB6zswuA8W7s5kYxoiC8CKWBoKp5E2UT2VtSEBn0/kDop+02Fd6CeG5VC+qui152T0I+kzAiWWqVJbkNg0o9CtLNqMGQHocNzN5UR4xWGWREIYEh7A9nKNxzY6/n42jMvFmkTj9Jcy+MJ4ot7fiimALhWNBlGUjUr0Xl3pix1dAN+PfJflbc2Ur6/PxIuUndpAEImyP39NQFLfjbnZAjWtrAOoj/DcMKvWER2RvC+xWtWcBK+TUli7HhVhhxbRIFOlTTsjarUYcMrsXQt6Ml1sFjqxK+b7eo6RNtYp4qLyGp7Dn5wNjQqzwwTX89W5ut2hUKCloM7mApek6SGGTok626GzBS+tn4S5BOHUryhN+TxkHmXLJGHI7pgZczsPV9bJHSgqtkY2HjLd449iHx+jNkG8VnVtm0rXwuQ8/IvMxNWfqyop3/5rztU88nYi6EmxxhH/sv9iq1BNNd2ymIdxIXNRz9l5SgMBwy4psbtqdDmvxykHF/djGzEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199015)(2906002)(31686004)(5660300002)(66556008)(8676002)(8936002)(316002)(54906003)(36756003)(66476007)(66946007)(6486002)(4326008)(966005)(478600001)(41300700001)(6512007)(6506007)(26005)(83380400001)(38100700002)(86362001)(2616005)(53546011)(186003)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1RkNEgvNHVYWEVWZTZxcHhRSDg3Z0hoZHFyTGZsMS9kK05raC80bEpTVGhZ?=
 =?utf-8?B?dlNxYmp6ZzRUUHpVRkVkUHJMeSt1eFVDYUR1MVZLb291K000L3AvVlBMa2RL?=
 =?utf-8?B?WGhIbmJycFRMVkRmTjcxNFljYXlmMzc0R2hZeHZXR0VkanQxM2I3ajQya0xI?=
 =?utf-8?B?ZjAxSFRMa08zUHBOUjBkakdMVTFZcnpEU1duSXV4a1dwTGxBWXdPNWFsNUJL?=
 =?utf-8?B?M2x4d0lnNTh4VVEwQjFoRUptQ2JOa1oyNm90amxTN3BCeU9mYUlOYjluOFVJ?=
 =?utf-8?B?dmdjMDAxV3M1aUZ0NTZHQnAyemVYVHZJUXQ1Rjd3emw5N2dqZTNpd1hMbVNp?=
 =?utf-8?B?K0FhUjNSaHVhVUtpa2lPM3greXRJdHA5L2V6ZEthblJEejBMUWNWWnB6Vi9l?=
 =?utf-8?B?ZWtXem53NFNYSVNWdFBzY3pIaGRseGgrM2RIY2ZXUElZQ0tvVjZLL2cwZ2xO?=
 =?utf-8?B?QmVDRXpBTFlFdnFjWkdaMGlER1lLc08yc01mVDhmbjYwUUZFNlZLdmxaRVhQ?=
 =?utf-8?B?RFhiZXh3ekJoLzJRYkZ1ZDEyWkdQOVY2SkJvSktHR25zRVE3TVgrclltRDVq?=
 =?utf-8?B?dFVsazQxa2ZERG1Ea0NleW1JQk44TWxSeVJwOXlsb25ERzZvdUZrUjZ4UUxz?=
 =?utf-8?B?VytjbkhzTkVvOGJYTVEwUE1HQzA3MXo5OWpOdmZJeU9FeHRMM3ZtcTNudTZy?=
 =?utf-8?B?M21HcmxSeXZwL1FHNEhEWlRQRUxmZ3hkSVJTSGQ4VmFrUy9GMG11ODBOclRt?=
 =?utf-8?B?bGQvUG1NY3JIbHpBOUl4clJOR0M4SDJaZ1NEYWlxVTgvSk5DZ0lqVXdjTHNG?=
 =?utf-8?B?elJaNm01UFZBNjZ3RnhjazRwTGFMTFVMVnl6Y0w5NU1zV1h2WEVGdStJNENw?=
 =?utf-8?B?VWFqZHMyazNBRWp1WDJJS3BoY2oyYmVwbnpvZnlROXhVRFhwN2t5NW5OaFFX?=
 =?utf-8?B?RnAyeFNWT3U2WUJsSlNHYlRRQU8rUXZwMU9WRlpNZjVmZzMzZXRMbEVrbzVS?=
 =?utf-8?B?eDRVTVovLzZHMDVoWmRVaExWSDB1YWsyZ09DQkFtWGRTWkhTbVVpMUNsRldr?=
 =?utf-8?B?dU8wYWtzM0xWSkRFZHlvbkdjaEFDMEhDeTFPTEZEdWRLUWRZanIxMDMyWDc1?=
 =?utf-8?B?a1c2MDN1WlJhQ1gzQ3hKQ0Y2NzJ6RGYyQ2tOVGR6TzR3Szd6SzR3ZDBlaVds?=
 =?utf-8?B?M05CZmpBOThjQ0JWa1FpbEpYU1dKZHUydUFsZmh2cGlxWjRpNzRHdEQ5L0or?=
 =?utf-8?B?Y05wdXZUbFIreXU2TmdvOWIvRFFEdDZWcThkc1ladWYxdnQyK1BRREhBbmxM?=
 =?utf-8?B?dXRQOFZhUngvTmpLQTVnTVVML09Bem9IU1dEYTBDWTlCYUhjc2p0a1RKRjQ2?=
 =?utf-8?B?OWNic0F1amlvR0RjSVdpaGYyNjc5UkpmRytkV2FPSjVFcnFudnM3M3pGdkEv?=
 =?utf-8?B?K2tZM0l1MXVUU2E3aEVGVFozbmdKSkt4UGR6Vy81Q24zRmlmcVU1R0xFWFBJ?=
 =?utf-8?B?dzBlMmlpRzRUR2FxRFcvc05EVXdFUmpZaDRsY3JRbU9OSk1iQ0k4Z1E4TWJP?=
 =?utf-8?B?TFlBMWZGYXdLb3ZlY2NXV1ZBbzR4TUJKaVdIR251ZlF4eWtybllLMmwvU013?=
 =?utf-8?B?a2txNDdEalltc0REVXp0ZkZIRmhCcDNCVlNzUUZQY09UKy9ETHVuMTNrTWxk?=
 =?utf-8?B?eWkwYVp3V05FZTN2MDRRcEFLVGlpMWxobmMrVHdJTjZtbHBXbms0eVlqSGlk?=
 =?utf-8?B?OEMyK0p1N2twYkRsOWJVVFNMWFc0VjIyNFNIZVZNTFdRV3VnT0ZiRGlZejRH?=
 =?utf-8?B?endaaFA4SjBROHo0K1EreUhDd05pN1VhckJiTjJ1MGZGZEZyMEh3SzZjZFpS?=
 =?utf-8?B?THJaaVA0L0UrNyt0YmJ1d0orcEJGcWh3bDFpaW1ORnc1eFE1Tis2Y1k4MUQr?=
 =?utf-8?B?RW4xeFJmVXBoTFNXZnhmczdlb1VZVzV6eHJadWFJM0lscmwxdVRPeEFITGFn?=
 =?utf-8?B?SDNhVXQxTUNXWE1TdHFjelJQaE5KWUhvVFJTVmhXU3hWbmlhdXcwRUlqUVp4?=
 =?utf-8?B?WkpKVGJWckRvMTJORVh5ekdiQW9sOW5LZVRkMFo4MTVpd2FUdGZaclo0cFFo?=
 =?utf-8?B?d0xKeWFJN1hMSjVMRmk3dzI0Uzd6eE5Mdlh1OFhRUFN6VGtkMEFiaWJVUno4?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b03a355-7c82-444e-9acf-08dab0907ae0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:39:41.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4mgPMSG2ZFvpPZ/jrSRgTm3ZUEVQ1PdVwgnqrToXpv9oAb9Skg1xOoHcRzuJp8DWMbyPl8nQ7fOrvWZ/NSy+CiprqK/52kU54Tcogd+yv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
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

On 10/11/2022 3:24 PM, Dave Hansen wrote:
> 
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 3b28c5b25e12..4d64de34da12 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -526,6 +526,9 @@ static void __fpstate_reset(struct fpstate *fpstate, u64 xfd)
>   	fpstate->xfeatures	= fpu_kernel_cfg.default_features;
>   	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
>   	fpstate->xfd		= xfd;
> +
> +	/* Ensure that xcomp_bv matches ->xfeatures */
> +	xstate_init_xcomp_bv(&fpstate->regs.xsave, fpstate->xfeatures);
>   }

I have some difficulty understanding the problem without this. Maybe I'm 
missing something here:

We have two call sites for this -- (a) one for the guest fpstate 
allocation [1] and (b) the other for the reset [2].

(a) The former has a call chain to init xcomp_bv:
   fpu_alloc_guest_fpstate()->fpstate_init_user()->xstate_init_xcomp_bv()

(b) And the latter picks up the default area:
   void fpstate_reset(struct fpu *fpu)
   {
	/* Set the fpstate pointer to the default fpstate */
	fpu->fpstate = &fpu->__fpstate;
	__fpstate_reset(fpu->fpstate, init_fpstate.xfd);
	...
   }
Then, xcomp_bv looks to be subsequently written by XSAVE* or by copying 
from init_fpstate.

There are three distinct call sites for fpstate_reset():
* fpu_clone() [3]: the child will either copy from init_fpstate or do 
XSAVE* that will update xcomp_bv according to ->xfeatures.
* fpu__init_system_xstate() [4]: When the init task switches away, 
xcomp_bv will be updated by XSAVE*.
* fpu_flush_thread() [5]: xcomp_bv will be copied from init_fpstate via 
fpu_reset_fpregs().

Thanks,
Chang

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/core.c#n229
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/core.c#n535
[3]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/core.c#n567
[4]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n869
[5]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/core.c#n744
