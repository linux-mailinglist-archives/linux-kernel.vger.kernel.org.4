Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A39666623
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbjAKWWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjAKWW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:22:29 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90A84319D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673475748; x=1705011748;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=X9eTViyWUripGwubn5NZfW9narAAMF/hUA8QCGfZ4wM=;
  b=KzJprQ3lkRhEKElwOoJwbJcF7icQakBfwhcYFVWTUUOyXEcQqMU0GF64
   cHpZusVHH1yr2aEpWJFUihdSQc4gOd7WLCklvIauouT4HcQ19oRYF719q
   lez37q+puBySkUjJ20ukdIJra9IPTnkWINaZMI4LXHmbfasDc7LwfmoGd
   edSGM11w+M/r/rrJZsRBxA3xlF52LPmyXmbb5M0LFeVzqsEjx14ymMwz+
   1q0n7wuIhgN0X3tqlJ2PkQFuynPbbvtU0aXXUCyR79ZkOUjQ+uQpKx8lh
   8LQ4cZ2AlAmYdf0IssKFkvu8zQQd7iMHIlvPkidXmsWK9rGiPt2hSgVOe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="325566810"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="325566810"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 14:22:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="746326399"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="746326399"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2023 14:22:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 14:22:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 14:22:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 14:22:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+FMwULtNcZ0yST6QMaE/xqwbaF2IMuKAY+xjJw8y7aYS+fN2w31koe79rNn4Zz09zR9UCgDpO2alOChBBvrVLkG5rsnar7L7Qw2Ui4/4CqWhmoalSASqW2+ddAscfQqQUvG3A3Btgaplej/pOrCLmsRNx80qkgqDPbnR36kCYmjyP7NUbgd9xeZuehtx2QvaApKrwsYss8RrbmLYglPbiyk5GlNXXK/EipMT8uu4VYavaMOqdVL+noBWoU1Rt1cMW8H+cSjFfNLASiqlT0O75xsOWIGbpSLWQVVcTsgTURUbRVsXgs+0Q89hgdoNvCmow58qEtWrw2qxzOUKJTVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGqtHYfQcaSnys7Xvku/sIchFOp8xj5B6pnht7wAMOM=;
 b=mD5BaksKvuL9UJwyrZRGnLyP8rVEZq4YSvjzq+YhujjKsAw7KS9yhkKDb3Op3lWN5azcxK2ir4z1O6X2VbADlJ4rwPO0z0894ODkxZBLhZR8vuueyREkWY5zrlkDg3IjMneWaHGYelx/Bf/c192EHNr1lFvvgojAlBvkQRmPI7Eff38ao18dSELFUfbx91Vq/ZsMBa7d2JYZqk/pAVecfGYqzsZ3G9WCCOpVgQEH/vzOg2oaOWpgfJKsUYma2FfRdUZ6hG/cKckJl6S/kkesxHCjp6/+niWzp5dsTKvLWPxGOlKgEShMjmUmjp/HE+g0uZi4JtgxVbPiKCuctVg2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 22:22:24 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 22:22:24 +0000
Message-ID: <2b523ed5-a809-1354-1050-a4cc415a102c@intel.com>
Date:   Wed, 11 Jan 2023 14:22:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/7] x86/cpu: Enable LASS (Linear Address Space
 Separation)
Content-Language: en-US
To:     Yian Chen <yian.chen@intel.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, Paul Lai <paul.c.lai@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-6-yian.chen@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230110055204.3227669-6-yian.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH0PR11MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 9224da90-1d2f-41e7-2bce-08daf4225087
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpJ7bBz2Kh9kYZ1ojEyLGARPBJ5QJwHuub2YbS2XnFlGGNLbxolnjTHQZVH7oqJUd73qWAIbi2HnstwdPY7nrLm0Jm3Y5D1IviGnX3Rrl4gtjXCzBCJrpxpAXk1AJ/Oo4xFu3iQJ4gC/TPOu4isffvBKtc6Z2pnFq1ZLKKSQGdENVjAZo9dWNC1lyI4Df2EITv/zWuwpVTBrCqeUIAz9dwxjOAlx6HtYpcAWDA0wsXtsLqTaBYZans5eAKRCXFNmGiwFadac75kWgAZf0HsYkKyV/++1sXEDuZvZ++KFN0WXxY22IkAUxii04cSuHwTV2snnytQ0AQZDaoM16npwJCMEyXz5jwC2TDpmGEFNOLWGkT0X/DQP3nfQnepPNSKHLnmSrxPGrgzTWwJMSMPc1sIOsbP94rNflLjHo9VpmIbg/iLEA9e832xon9UO9CI7znryQkqkfWyqt1CmC2hM0JHavy/wNP9GqzE2Mtr1AetpwjUkTA2HwWV62L3ZGySP1HUp4cLih4HHeyVvrig0eIYGJ3rshCvEj3ttljxI9i6/6QA6hOugG/JsDo5/AZ/x7SCSxdxj1gTzLi3aaWs5BCffQdd10e0bIG5LEIuJQK1HvUTEHn+mltS57id4/9TsLEWvMUlLQl4EbYblPdyay2YnnCoo1LixQhWyMHGUDsNCxCcyuhUdE3w3iZ6G4CQ3z1tdi9Mq09phithuKvAT9xeynG4aWrESMUpbm6T4Kxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(31686004)(66556008)(44832011)(2906002)(5660300002)(36756003)(8936002)(66946007)(8676002)(41300700001)(66476007)(2616005)(316002)(110136005)(6486002)(478600001)(26005)(6506007)(186003)(6512007)(31696002)(86362001)(82960400001)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjV0aTBON2dicytXRUFobEVnNTRjQWovR2QzbmRLRktENDZ4UTRLWVQvSGt3?=
 =?utf-8?B?SnhsWTJYVTJ3eTZEU1NhblJaM2s5dy9LamdmTWRhQWJUYXNoaFRrSjcxemxZ?=
 =?utf-8?B?clRXRzFGZkErWWM3bVhpOWRLa2dBZjRuMkFkL2NuWUFJOTJ0VVN6OTMwYUl2?=
 =?utf-8?B?b2hEL0pzeThmVWh4czF6WDYrWmRkZEU2cWFxOTNBU1FIN0VEUWpUUzBiYkJC?=
 =?utf-8?B?L28xRkhwNmJDclh6cDlJeGZhMUpnVG5LbjVxbzZad0doRk92TDBlUlI1QjN1?=
 =?utf-8?B?bFZzR2Q2b1hMb0w2VXJaY1VrZHlObHBzQnlQUGxjNUxjNWpNbGZuZWgvcU5L?=
 =?utf-8?B?SVJPUDN2WVhBblJzN3kyUmNnSDBSTHNOa1VRYU96by9kSEt3Sm13YmRkcEgz?=
 =?utf-8?B?bkkvdWJndk53cUo5UUpPeTNQbzhzSHcvSmMzdys3NGJaQUpYcVpyeHdRaEFp?=
 =?utf-8?B?LzRhenZ2c29pUjVnaGpyS2hQaFFXTnE5MGgvTUhMZXZxd3g3aEpOK3BZNVZV?=
 =?utf-8?B?U2lSelJwVU92L25aN3R2eCtTWU95cTlOajNVaHFETnpjdG1tNmxDODVUNkxj?=
 =?utf-8?B?bjZXL2ZhWXB5TGVId0pqQkpvWlB3c0kvWjB4ODBlMnNwbGRQM212OG9XMzBE?=
 =?utf-8?B?Sm1tbGVyRDI2WU8vZ2ZyMnNnc1ZHR20wRHQ3ajh1K0h1MlNjRkdSWkhPNmlj?=
 =?utf-8?B?MUw5SzN2dHRmaUpGazJEN2tiV3g4dGxZVlgvcTl5VlQrQXBOWDZxMDl0enBv?=
 =?utf-8?B?Wk43MHZRaHgxR0Q3Mkdnc1ZKeW1sc1J0UWxFWGpPUmo2RVZnTEFuelJWdzZk?=
 =?utf-8?B?OE5uNmVGZFpxc0JEVWw5MzlMemZPM0ZrY2FRdmtWbStVQkI3Ujd2R05rOXdD?=
 =?utf-8?B?L3VabG9BaUxMSldFN0kvNnAwVWJHWlZkMm1DTjZBNEcvUG1YNk1nVGZxL3Z4?=
 =?utf-8?B?emxWaE5SZiswSS9PTSsrOGFuUmdCY3JLblFjbTlMRWV2WUVYWS9jbW5xd2x4?=
 =?utf-8?B?YVFleXl3aXdqcms3SjRPeGpsOWFpbDhWY1BLVVBiRGlBRzlEVFdTWW5SSFEz?=
 =?utf-8?B?UnJNdE1pZ1EyNytHNUlHZlJQcldKSWgwZVlyVnMwemM1ZjAxU3dZZHJFR1po?=
 =?utf-8?B?S2N3aDMwVE8xa0FPNUR4a0p2ZnozT0NGZE11dDVUSEpkVVBlVlZnRGJ2d05H?=
 =?utf-8?B?SzdmZnozK1lIQ3JXd3A2b0RYL1EvenJkNU5lcE9wNndDL1MxdGZIZmh2Wmhs?=
 =?utf-8?B?WFEvaXVTMit6aHV1TklSNUdVajQ0VU90dERtMm1uWDgyY3hXSnBGRTRCeXFu?=
 =?utf-8?B?aFNpdm1qR2czT0haWW1OVmNyaVZDUW1uZGI2SUpjc0J4TTVPUWRna3ZDdnFk?=
 =?utf-8?B?N0JCRnBDUEdvd0F0MjNOSnBkVTVRK3FibmdibzQ3S2ozSmJKZjcyN0pEdmN4?=
 =?utf-8?B?bnNocmp3VjNraGdxTWZsaEZWUTZGUVBvZjZxT1BQaUQzdUlnV2hVUDNJOVF0?=
 =?utf-8?B?aEhmMnk4Tk02Zk41eW5OMk94Y1lkS3h2Y0U1aFpkZGNmNXQwbW1FN2NSMHVn?=
 =?utf-8?B?dDVQYmtMLzdDRGdBclltellaTzJBWWQzMTVaemFGR3NwRy9WZjVLZ3N4QVJq?=
 =?utf-8?B?cTRRcGkyeUlWczhIUmdyZHRDRkJDdGdTOGEvWVE5N215QVdyS2NmdWkzR053?=
 =?utf-8?B?bXRxSTRlV3BFcGVTQUxGbTkvTlVkU25aZENlMnVoWnlmZTNFMXRjdzE0dmlT?=
 =?utf-8?B?UEZxbnZRQnNyN0RMTXlIOHNHQnYvN1ZrdWJYUFZqQWkyN05RVE1SbHo2azZq?=
 =?utf-8?B?WHQ3NGtFZTNWalladzJBSDFnRTFiTm96V1BxY2xySk5BSUFhNE8rK0Q3YWd5?=
 =?utf-8?B?MHRsL1lmem1YUFg4SFBXaUJxSWxGSHU3ZHVMeUhuWHd6M25FMUtzZmEvRkZ0?=
 =?utf-8?B?ZHNJZ3lRTzFXYmt4KzlxMjlnS2RRVXJqSjJEU2Q3TFc2SkpJQk96cGZiMjZj?=
 =?utf-8?B?MjltRytwUkp5dUdpSUp6Zm1vakNPcnlYYTZzVVpuZmRGczhrWjJTTitWNlRt?=
 =?utf-8?B?ZzdJWG9SWUhrVGJPSEJmVWcvcEN0TjdSY3NKbkMxYndXelE0VVhmVlk4amNC?=
 =?utf-8?Q?PwhytGmFTQ5jj9qhhGZ5HJl8w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9224da90-1d2f-41e7-2bce-08daf4225087
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 22:22:24.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twrtwx/wZI6EOIWVfEFanfEJIdlwMwu/UDbgaywoSw7fSvGN2Y9DNl0qIC7y89qTrkp59UMJSPsB1jXUm3iR9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
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

> +static __always_inline void setup_lass(struct cpuinfo_x86 *c)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> +		cr4_set_bits(X86_CR4_LASS);
> +	} else {
> +		/*
> +		 * only clear the feature and cr4 bits when hardware
> +		 * supports LASS, in case it was enabled in a previous
> +		 * boot (e.g., via kexec)
> +		 */
> +		if (cpu_has(c, X86_FEATURE_LASS)) {
> +			cr4_clear_bits(X86_CR4_LASS);
> +			clear_cpu_cap(c, X86_FEATURE_LASS);
> +		}
> +	}
> +}

I am quite confused by the "else" code flow. Can you please help 
understand how this code path would be exercised?

Also, why don't other features such as SMAP or SMEP need this type of 
handling? I see something on similar lines for UMIP.

Also, how does the CR4 pinning code in the following patch play into 
this? Could it flag a warning when cr4_clear_bits() is called above?

> +
>   /* These bits should not change their value after CPU init is finished. */
>   static const unsigned long cr4_pinned_mask =
>   	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
> @@ -1848,6 +1865,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>   	setup_smep(c);
>   	setup_smap(c);
>   	setup_umip(c);
> +	setup_lass(c);
>   
