Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9CF5E67B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiIVP4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiIVPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:55:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCF8EFF76
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663862152; x=1695398152;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=RUcI0OChfHMDLKVoJEgdf05BHx0jxru6KL51dQEr7Ns=;
  b=JQ1tRJfMof0p0Q/EN2koaaYtut/31wyuYe4ZT5nII1qFjDfq/hOWON+E
   BnCB5LpvDMNxs68nlmZylLGHxVbZAzGh1lS++oyaW8ZTIy0xu/O4ZLHnf
   rzxQzMaDJeE30JRot1aEruiVEGkZ0sH6EWWYHe/KS+91lmBXGaenYr9YH
   r2gwTghNIMqVuYS8cScQXQpuM09MRlgepET2DFJKbDKFvQe8m+6xRe9LP
   sKUJ9dPD3gMf1R6MI73jv73gC3mtATu6OujjDJo4ksumykn4hIOB6CvVa
   zLKlvoakX/HWQpMjeJCphdxaaa1hbmPhHeI1fW0yTQesZ2IuTi1jbB5pU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="287422136"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="287422136"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 08:55:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="795141574"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 22 Sep 2022 08:55:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 08:55:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 08:55:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 08:55:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCJlowL8StgdJaJhwDiQwIB7ZwZB2aCnght71yMkcCctexPwB2gDNQUILI3kzBSHSoYL8YvKuV6HSudP/SCN5xdq63j31NJYZQDKRA4qK8C/Ktz71SKyYRZaFSK4xXm8w1FIvLiSAidAvKslN3irR6FpV0VkYg1sTqU84BFVevzUqRhoLW7hlyscszpjEIQ3v27xtEPIQUoKtBJYd9oSmWYHdqKMS9AvKV5H4I2Kmn9/ippLNowyJvmcimaYjwOMze3lUGINgI2rF9k4+oFfZiRylMbmsEt9eCkpQO4w4isE45irlYLtWxB2r9LWhBm7DjG1xPZK+kz0WcKGP89FbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNnVmtZDkKBOGtVRzn36E7ChC3kPKOPz5WDI1cRVZ1s=;
 b=bUWnJ7iQyaorZ6j+ZbwXOppM3xZnlTfznB8EsTZ7b8fTkBDnwfY2qW/amBcQUAFu+a/pdTNuohkmulBI/3h8215D3U1FK8er3VhhsI4GHWJEfeOxQA+GsxUNf0zdpendkPr7KnlpCCg+hDBX/+5Ru12HCrVdpZmfZoarH66rAptoAo0Z5nBsh+BitTKYw2tuV/NYlyvt80GUDLf3ePJ29aZxY9CYaEjmlBC3V2O6hui+jikT7busl6xIEM7JBxqgoWVT06sL4Srrrby2gPeaksZtQ57BJ3Uftuz7+6u0EuHCgU5L2C/JPbgaMICFiEbZWTCkw8BUoEI0e3n9mlIr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 15:55:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5632.021; Thu, 22 Sep 2022
 15:55:48 +0000
Date:   Thu, 22 Sep 2022 08:55:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Evgeniy Dushistov <dushistov@mail.ru>,
        <linux-kernel@vger.kernel.org>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Subject: Re: [PATCH v4] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <YyyFgC+RK9uT4Z5t@iweiny-desk3>
References: <20220822144420.7442-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220822144420.7442-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BY5PR17CA0046.namprd17.prod.outlook.com
 (2603:10b6:a03:167::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c5a731-3b08-497d-574d-08da9cb2ea9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nb5olCW+X6kqfzGnOoU1EAU9qSdKHerg6MxVD/Xh5xMsyN9ouLFgeL4uONSts3xUpM+Ck7FnB2zZTK+zbd5htDLKRzrZbs1edjBNx7Lfe0wvmJH7tyUwE2mHVwlklYEUQDCjMtiHKBgYctsfUQu6BW6TwkAixpZQ7w6AQZC+MPiSrICT9ZZ53DNwYTlCMNHwafnrNo1//yUs/ZxCWPT/tuq1h0g5ckBc7H9Dx00pum608popoDPoXMg51vBo3/MyYvO8InVJVqL5R5VhQYKGbKjHRQ4XDuKuJ/XVOhrCZMK644J7ZuyMdK0FFe6XNJ5WYREdoZrLEQ2m+RS1TFqVVhTSydkq89iS6I3tQIG2zhqqij1PE1EXZ2tUfvN/TvGtA+Gy7BZzpKZLuoynX1a5VvJgdBoFKap2GnzypoCDPZr6OdFuL57s2lJ56sIy+O/bhSMrNCYF8m8XfuFVTaPDFuJbbq2JJ8khM28DrulLswqptnHg3O8Q0yr6JIyst8B8GgRfeDA1eERG4d9sVzwbaaKU3nyGn9nxfXomY5J/zNQF2HJ/0xy48h7/Dg3tDwfTCkhKgJbJmNF2U4p1Q8RATMvnQSD2SKVXpOkocEAQqRgi4vFFopdk3YpxYUyBmEOgpFtdNJK3pJcjbHMBdNl/mZVTvufBjNeKDg5JO5VT6Chxfiwj8NKU+XDJIyDIMK23KB5JYFhp84cvu9jbZb6ctGqaO/cnUBg+87i596bj0YJTAutZrof5LJ0/qJ2gSYLN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(66946007)(4326008)(6506007)(8676002)(26005)(6512007)(8936002)(66556008)(66476007)(478600001)(107886003)(6666004)(41300700001)(30864003)(44832011)(5660300002)(2906002)(186003)(6486002)(9686003)(83380400001)(86362001)(82960400001)(33716001)(54906003)(6916009)(316002)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnBaOUFRM1c2bHV0ZVkzekZSV3pkZytEZmhmRGZZeDRqam5KSEFwT0loMlVy?=
 =?utf-8?B?UkpxaWRqWUpXME9QZEdVWEgyMjdjMk93SVBBQmFVVld4OUxEc2RjM3hlTWVY?=
 =?utf-8?B?SjIyQ0M2UEMrbEhHSnNZNUxERm9LVU9WZERVWm5ibnlGeTJNczZzbHMydSt2?=
 =?utf-8?B?Vk9tZFVXTzhFSzV4K0czeFIrbUpQbjRxMEJJY3MrWDdsSDk3VGgxK0k4bUps?=
 =?utf-8?B?eEp5SDgvenljWTdtOVNjOVN4UlR5aEROZTIrMmxHcGtqYnFKZVhFNVhkV1Ir?=
 =?utf-8?B?K05mbitjK3ljSDQrRDFSbk9TOEFuZHhvT3dZbjNYK0orVDNCQmZqWVlwTUY1?=
 =?utf-8?B?RVRkSEVrSFRYWGdyaVRYaTZrZHAyeXI1c2ZGb1gwdFpuOTZ0ODROdmFWYjdy?=
 =?utf-8?B?NG1BcWtqakdPTWxhZWNNRTZMQzZCZ0xnbjdvOVVGa1dWT0RRWlFoeFhncElR?=
 =?utf-8?B?amdtcHp6RTVOR3NNYzZ6NE1jbXIyYWVveC92cXVjTFZGSnBjNDN2L1lydDhV?=
 =?utf-8?B?eFRZdHI0UmRiQUw3S2RrcitUR21hU2lHbFY5OXJsVkY2OUliYkVUWTlMM3VM?=
 =?utf-8?B?UXhQY3IvQXRCU25ac1B5aEhIdDJ4alBnK1Q5RzU0OXFscEdoMFhyVWR0T2FP?=
 =?utf-8?B?ODg3bzZORTVHWWR5ZFI4aU1Fb3lJZDMzdzVjdVAwTlIrcThLZExKRnpXZzJI?=
 =?utf-8?B?eXE5R2ozaU04UG9uSHU4cE5iOWFrNGtWcFJrdUdnNUFsaUtOWDY1WUowZy9u?=
 =?utf-8?B?WHYwOFptdU9sdnFxdXZSM0NMYnNiUW9VVEhMUWR5T3ZQU1hObmh4RDN1dzZ5?=
 =?utf-8?B?TG1QYWFhVHpwcWM4dFByQ1hqYndOR3R3TVB6czNPWHlRY1JzaWFRYWl0b0Jx?=
 =?utf-8?B?MDFvdUdEKzhMTXpweUJrZlVGeGlsdWJqbTdBMWl2cU1EL29UTEUwNnRnSERI?=
 =?utf-8?B?bHFaTVZxUm5MaWt2OHE4ajYzK0tQOUdjOVdKTXRjRWJhMzRONzRFUkJTMHZo?=
 =?utf-8?B?Qnk4Z01MWFVjMHR1aWsrSkUrRlBjQVdPUEoyWEtKUXFzbjh1OWJjbTZZQm9Y?=
 =?utf-8?B?UitZTnR0WEU5MldFNWtpRWRKcWdJYXVveUJXOU5OVWVjRUlKTE5TUE1mSTJm?=
 =?utf-8?B?ZHJTS1BUUFcwdSs3dDhLM2wrVTBrdkVsRU1KZ0JNZm1sdGwvc0NSYWhuQ0Vr?=
 =?utf-8?B?UGdXQ0VEYVlSc3BncjJWMWhXMnh0UHJ2M1V0TDB4WHVlam8vYVZtL3cyeHJX?=
 =?utf-8?B?eGRuU3BiK0o1RHdWdFY0U3p1dlFFbGRNN3FJNGltSjlqWHh2NWJuTWdIVWEz?=
 =?utf-8?B?S29uTkYrU0lHYWRKUmVhMlV4bEw3bzRYalQwb2hNKzcydXNjSXBSSCs2QlNG?=
 =?utf-8?B?eUl6aGljTVMwU3phTUZ6dGFvYm02N0ZzZVZaVGVVZW1NUGFHWFErdHp1SFoy?=
 =?utf-8?B?UzczR0EzYjdkNTA0SG1NN1RhclE4cGFXcjl4TjgzWUdtSU5JZFdMU2k2MzJG?=
 =?utf-8?B?SldhUmIwMnRwM3VUa0t1ZDNVcFZuazlEK1hBaFBwbWFWcmgxYWx3ejF6L0pQ?=
 =?utf-8?B?MjJ3UzM1YzRnNXJiUUNsM09UVERERVVzclZPUHFDamdWR1gyVHljeGVhcDNk?=
 =?utf-8?B?VC82VEpkZmJrd1ROTnNJVGlqMzRNbWJxS3Z4ODVGeER3Y0pKU3FhWmc0UmR2?=
 =?utf-8?B?c0oyNFdVb2E2ampTeDRqRmpkOGszMW9LN1JXbnhrY3c0TVM5QVpEeThtU0ZN?=
 =?utf-8?B?YU8remZuVVBqVEhVYmVka2lvUGhvS2ZDNURiQnQ2d1VWZmJqVVlwMzNSUW9W?=
 =?utf-8?B?ejh1TmpmbVFtS3RKekk3SGNTMDBaZ3plUVNJM1VmT3FqcWJ4cDZsdmVkejZ0?=
 =?utf-8?B?cndPYlpVeXV2QkY5aHhkMXBQUHEvb3JucFJLc3JDNjBOUnZzdjBjdld0cUNi?=
 =?utf-8?B?RHpsUmNZZGtWaUdiREtRSGlmaE56ZkV4L3dBSWtDUUh5eFY5Y3V3K2RNYk90?=
 =?utf-8?B?N2ZhNllSQ0hSUm1XZFplRUlpMGl5Q0xGaStUTU8wRFB3dGxPWk9QeWhUQTZ2?=
 =?utf-8?B?WDNTcHBCT1FPY3gycVBQTXZLamtXZjVIeS9GQmxGdG5EUmpQVlYwd0dQWnJ4?=
 =?utf-8?Q?t1aFcMhx76pZGb9EEJ65wjGdX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c5a731-3b08-497d-574d-08da9cb2ea9c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:55:48.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSwN6vVodI7is4hKAuVjA9AmdQyWpfxyfJ7fceUNXqKlYpSvR/5c2ybYNz0jIhxf3Q/k7D+hLf3mHqNVtOxfiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 04:44:20PM +0200, Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
> 
> Since its use in fs/ufs is safe everywhere, it should be preferred.
> 
> Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
> requires the mapping address, so return that address from ufs_get_page()
> to be used in ufs_put_page(). Where suited, use the standard helper
> memzero_page() instead of open coding kmap_local_page() plus memset().
> 
> These changes are essentially ported from fs/ext2 and are largely based on
> commit 782b76d7abdf ("fs/ext2: Replace kmap() with kmap_local_page()").
> 
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> This code is not tested. I have no means to create an UFS filesystem.
> Despite nothing here seems to break the strict rules about the use of
> kmap_local_page(), any help with testing will be much appreciated :-)
> 
> v3 -> v4: Convert another kmap() which was overlooked. Since the code
> 	  changed, remove the "Reviewed-by" tag from Ira.
> 
> v2 -> v3: Rename a variable for consistency (Ira Weiny). Add a
> 	  "Reviewed-by" tag.
> 
> v1 -> v2: Correct some style's issues reported by checkpatch.pl.
>           Remove an "inline" compiler directive from fs/ufs/ufs.h,
>           Reported-by: kernel test robot <lkp@intel.com>
> 
>  fs/ufs/dir.c   | 116 +++++++++++++++++++++++++++++++------------------
>  fs/ufs/namei.c |  38 ++++++++--------
>  fs/ufs/ufs.h   |  12 +++--
>  3 files changed, 102 insertions(+), 64 deletions(-)
> 
> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index 391efaf1d528..db7564852391 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -61,9 +61,9 @@ static int ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
>  	return err;
>  }
>  
> -static inline void ufs_put_page(struct page *page)
> +inline void ufs_put_page(struct page *page, void *page_addr)
>  {
> -	kunmap(page);
> +	kunmap_local(page_addr);
>  	put_page(page);
>  }
>  
> @@ -72,11 +72,12 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
>  	ino_t res = 0;
>  	struct ufs_dir_entry *de;
>  	struct page *page;
> -	
> -	de = ufs_find_entry(dir, qstr, &page);
> +	void *page_addr;
> +
> +	de = ufs_find_entry(dir, qstr, &page, &page_addr);
>  	if (de) {
>  		res = fs32_to_cpu(dir->i_sb, de->d_ino);
> -		ufs_put_page(page);
> +		ufs_put_page(page, page_addr);
>  	}
>  	return res;
>  }
> @@ -84,11 +85,11 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
>  
>  /* Releases the page */
>  void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
> -		  struct page *page, struct inode *inode,
> -		  bool update_times)
> +		  struct page *page, void *page_addr,
> +		  struct inode *inode, bool update_times)
>  {
>  	loff_t pos = page_offset(page) +
> -			(char *) de - (char *) page_address(page);
> +			(char *)de - (char *)page_addr;
>  	unsigned len = fs16_to_cpu(dir->i_sb, de->d_reclen);
>  	int err;
>  
> @@ -100,18 +101,17 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
>  	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
>  
>  	err = ufs_commit_chunk(page, pos, len);
> -	ufs_put_page(page);
> +	ufs_put_page(page, page_addr);
>  	if (update_times)
>  		dir->i_mtime = dir->i_ctime = current_time(dir);
>  	mark_inode_dirty(dir);
>  }
>  
>  
> -static bool ufs_check_page(struct page *page)
> +static bool ufs_check_page(struct page *page, char *kaddr)
>  {
>  	struct inode *dir = page->mapping->host;
>  	struct super_block *sb = dir->i_sb;
> -	char *kaddr = page_address(page);
>  	unsigned offs, rec_len;
>  	unsigned limit = PAGE_SIZE;
>  	const unsigned chunk_mask = UFS_SB(sb)->s_uspi->s_dirblksize - 1;
> @@ -186,21 +186,28 @@ static bool ufs_check_page(struct page *page)
>  	return false;
>  }
>  
> -static struct page *ufs_get_page(struct inode *dir, unsigned long n)
> +/*
> + * Calls to ufs_get_page()/ufs_put_page() must be nested according to the
> + * rules documented in kmap_local_page()/kunmap_local().
> + *
> + * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page()
> + * and must be treated accordingly for nesting purposes.
> + */
> +static struct page *ufs_get_page(struct inode *dir, unsigned long n, void **page_addr)
>  {
>  	struct address_space *mapping = dir->i_mapping;
>  	struct page *page = read_mapping_page(mapping, n, NULL);
>  	if (!IS_ERR(page)) {
> -		kmap(page);
> +		*page_addr = kmap_local_page(page);
>  		if (unlikely(!PageChecked(page))) {
> -			if (!ufs_check_page(page))
> +			if (!ufs_check_page(page, *page_addr))
>  				goto fail;
>  		}
>  	}
>  	return page;
>  
>  fail:
> -	ufs_put_page(page);
> +	ufs_put_page(page, *page_addr);
>  	return ERR_PTR(-EIO);
>  }
>  
> @@ -226,15 +233,29 @@ ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
>  					fs16_to_cpu(sb, p->d_reclen));
>  }
>  
> -struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
> +/*
> + * Return the '..' directory entry and the page in which the entry was found
> + * (as a parameter - p).
> + *
> + * On Success ufs_put_page() should be called on *p.
> + *
> + * NOTE: Calls to ufs_get_page()/ufs_put_page() must be nested according to
> + * the rules documented in kmap_local_page()/kunmap_local().
> + *
> + * ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page() and
> + * must be treated accordingly for nesting purposes.
> + */
> +struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p, void **pa)
>  {
> -	struct page *page = ufs_get_page(dir, 0);
> +	void *page_addr;
> +	struct page *page = ufs_get_page(dir, 0, &page_addr);
>  	struct ufs_dir_entry *de = NULL;
>  
>  	if (!IS_ERR(page)) {
>  		de = ufs_next_entry(dir->i_sb,
> -				    (struct ufs_dir_entry *)page_address(page));
> +				    (struct ufs_dir_entry *)page_addr);
>  		*p = page;
> +		*pa = page_addr;
>  	}
>  	return de;
>  }
> @@ -246,9 +267,17 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
>   * returns the page in which the entry was found, and the entry itself
>   * (as a parameter - res_dir). Page is returned mapped and unlocked.
>   * Entry is guaranteed to be valid.
> + *
> + * On Success ufs_put_page() should be called on *res_page.
> + *
> + * NOTE: Calls to ufs_get_page()/ufs_put_page() must be nested according to
> + * the rules documented in kmap_local_page()/kunmap_local().
> + *
> + * ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page() and
> + * must be treated accordingly for nesting purposes.
>   */
>  struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
> -				     struct page **res_page)
> +				     struct page **res_page, void **res_page_addr)
>  {
>  	struct super_block *sb = dir->i_sb;
>  	const unsigned char *name = qstr->name;
> @@ -259,6 +288,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  	struct page *page = NULL;
>  	struct ufs_inode_info *ui = UFS_I(dir);
>  	struct ufs_dir_entry *de;
> +	void *page_addr;
>  
>  	UFSD("ENTER, dir_ino %lu, name %s, namlen %u\n", dir->i_ino, name, namelen);
>  
> @@ -267,6 +297,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  
>  	/* OFFSET_CACHE */
>  	*res_page = NULL;
> +	*res_page_addr = NULL;
>  
>  	start = ui->i_dir_start_lookup;
>  
> @@ -275,9 +306,10 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  	n = start;
>  	do {
>  		char *kaddr;
> -		page = ufs_get_page(dir, n);
> +
> +		page = ufs_get_page(dir, n, &page_addr);
>  		if (!IS_ERR(page)) {
> -			kaddr = page_address(page);
> +			kaddr = page_addr;
>  			de = (struct ufs_dir_entry *) kaddr;
>  			kaddr += ufs_last_byte(dir, n) - reclen;
>  			while ((char *) de <= kaddr) {
> @@ -285,7 +317,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  					goto found;
>  				de = ufs_next_entry(sb, de);
>  			}
> -			ufs_put_page(page);
> +			ufs_put_page(page, page_addr);
>  		}
>  		if (++n >= npages)
>  			n = 0;
> @@ -295,6 +327,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  
>  found:
>  	*res_page = page;
> +	*res_page_addr = page_addr;
>  	ui->i_dir_start_lookup = n;
>  	return de;
>  }
> @@ -312,6 +345,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  	const unsigned int chunk_size = UFS_SB(sb)->s_uspi->s_dirblksize;
>  	unsigned short rec_len, name_len;
>  	struct page *page = NULL;
> +	void *page_addr = NULL;
>  	struct ufs_dir_entry *de;
>  	unsigned long npages = dir_pages(dir);
>  	unsigned long n;
> @@ -329,12 +363,12 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  	for (n = 0; n <= npages; n++) {
>  		char *dir_end;
>  
> -		page = ufs_get_page(dir, n);
> +		page = ufs_get_page(dir, n, &page_addr);
>  		err = PTR_ERR(page);
>  		if (IS_ERR(page))
>  			goto out;
>  		lock_page(page);
> -		kaddr = page_address(page);
> +		kaddr = page_addr;
>  		dir_end = kaddr + ufs_last_byte(dir, n);
>  		de = (struct ufs_dir_entry *)kaddr;
>  		kaddr += PAGE_SIZE - reclen;
> @@ -365,14 +399,14 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  			de = (struct ufs_dir_entry *) ((char *) de + rec_len);
>  		}
>  		unlock_page(page);
> -		ufs_put_page(page);
> +		ufs_put_page(page, page_addr);
>  	}
>  	BUG();
>  	return -EINVAL;
>  
>  got_it:
>  	pos = page_offset(page) +
> -			(char*)de - (char*)page_address(page);
> +			(char *)de - (char *)page_addr;
>  	err = ufs_prepare_chunk(page, pos, rec_len);
>  	if (err)
>  		goto out_unlock;
> @@ -396,7 +430,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  	mark_inode_dirty(dir);
>  	/* OFFSET_CACHE */
>  out_put:
> -	ufs_put_page(page);
> +	ufs_put_page(page, page_addr);
>  out:
>  	return err;
>  out_unlock:
> @@ -441,7 +475,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>  		char *kaddr, *limit;
>  		struct ufs_dir_entry *de;
>  
> -		struct page *page = ufs_get_page(inode, n);
> +		struct page *page = ufs_get_page(inode, n, (void **)&kaddr);
>  
>  		if (IS_ERR(page)) {
>  			ufs_error(sb, __func__,
> @@ -450,7 +484,6 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>  			ctx->pos += PAGE_SIZE - offset;
>  			return -EIO;
>  		}
> -		kaddr = page_address(page);
>  		if (unlikely(need_revalidate)) {
>  			if (offset) {
>  				offset = ufs_validate_entry(sb, kaddr, offset, chunk_mask);
> @@ -476,13 +509,13 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>  					       ufs_get_de_namlen(sb, de),
>  					       fs32_to_cpu(sb, de->d_ino),
>  					       d_type)) {
> -					ufs_put_page(page);
> +					ufs_put_page(page, kaddr);
>  					return 0;
>  				}
>  			}
>  			ctx->pos += fs16_to_cpu(sb, de->d_reclen);
>  		}
> -		ufs_put_page(page);
> +		ufs_put_page(page, kaddr);
>  	}
>  	return 0;
>  }
> @@ -493,10 +526,9 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>   * previous entry.
>   */
>  int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
> -		     struct page * page)
> +		     struct page *page, char *kaddr)
>  {
>  	struct super_block *sb = inode->i_sb;
> -	char *kaddr = page_address(page);
>  	unsigned from = ((char*)dir - kaddr) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
>  	unsigned to = ((char*)dir - kaddr) + fs16_to_cpu(sb, dir->d_reclen);
>  	loff_t pos;
> @@ -522,7 +554,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
>  		de = ufs_next_entry(sb, de);
>  	}
>  	if (pde)
> -		from = (char*)pde - (char*)page_address(page);
> +		from = (char *)pde - kaddr;
>  
>  	pos = page_offset(page) + from;
>  	lock_page(page);
> @@ -535,7 +567,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
>  	inode->i_ctime = inode->i_mtime = current_time(inode);
>  	mark_inode_dirty(inode);
>  out:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	UFSD("EXIT\n");
>  	return err;
>  }
> @@ -559,8 +591,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
>  		goto fail;
>  	}
>  
> -	kmap(page);
> -	base = (char*)page_address(page);
> +	base = kmap_local_page(page);
>  	memset(base, 0, PAGE_SIZE);
>  
>  	de = (struct ufs_dir_entry *) base;
> @@ -577,7 +608,7 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
>  	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
>  	ufs_set_de_namlen(sb, de, 2);
>  	strcpy (de->d_name, "..");
> -	kunmap(page);
> +	kunmap_local(base);
>  
>  	err = ufs_commit_chunk(page, 0, chunk_size);
>  fail:
> @@ -592,17 +623,18 @@ int ufs_empty_dir(struct inode * inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	struct page *page = NULL;
> +	void *page_addr;
>  	unsigned long i, npages = dir_pages(inode);
>  
>  	for (i = 0; i < npages; i++) {
>  		char *kaddr;
>  		struct ufs_dir_entry *de;
> -		page = ufs_get_page(inode, i);
>  
> +		page = ufs_get_page(inode, i, &page_addr);
>  		if (IS_ERR(page))
>  			continue;
>  
> -		kaddr = page_address(page);
> +		kaddr = page_addr;
>  		de = (struct ufs_dir_entry *)kaddr;
>  		kaddr += ufs_last_byte(inode, i) - UFS_DIR_REC_LEN(1);
>  
> @@ -629,12 +661,12 @@ int ufs_empty_dir(struct inode * inode)
>  			}
>  			de = ufs_next_entry(sb, de);
>  		}
> -		ufs_put_page(page);
> +		ufs_put_page(page, page_addr);
>  	}
>  	return 1;
>  
>  not_empty:
> -	ufs_put_page(page);
> +	ufs_put_page(page, page_addr);
>  	return 0;
>  }
>  
> diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
> index 29d5a0e0c8f0..cdf3bcf9d02e 100644
> --- a/fs/ufs/namei.c
> +++ b/fs/ufs/namei.c
> @@ -210,13 +210,14 @@ static int ufs_unlink(struct inode *dir, struct dentry *dentry)
>  	struct inode * inode = d_inode(dentry);
>  	struct ufs_dir_entry *de;
>  	struct page *page;
> +	void *page_addr;
>  	int err = -ENOENT;
>  
> -	de = ufs_find_entry(dir, &dentry->d_name, &page);
> +	de = ufs_find_entry(dir, &dentry->d_name, &page, &page_addr);
>  	if (!de)
>  		goto out;
>  
> -	err = ufs_delete_entry(dir, de, page);
> +	err = ufs_delete_entry(dir, de, page, page_addr);
>  	if (err)
>  		goto out;
>  
> @@ -250,27 +251,31 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  	struct inode *old_inode = d_inode(old_dentry);
>  	struct inode *new_inode = d_inode(new_dentry);
>  	struct page *dir_page = NULL;
> +	void *dir_page_addr;
>  	struct ufs_dir_entry * dir_de = NULL;
>  	struct page *old_page;
> +	void *old_page_addr;
>  	struct ufs_dir_entry *old_de;
>  	int err = -ENOENT;
>  
>  	if (flags & ~RENAME_NOREPLACE)
>  		return -EINVAL;
>  
> -	old_de = ufs_find_entry(old_dir, &old_dentry->d_name, &old_page);
> +	old_de = ufs_find_entry(old_dir, &old_dentry->d_name, &old_page,
> +				&old_page_addr);
>  	if (!old_de)
>  		goto out;
>  
>  	if (S_ISDIR(old_inode->i_mode)) {
>  		err = -EIO;
> -		dir_de = ufs_dotdot(old_inode, &dir_page);
> +		dir_de = ufs_dotdot(old_inode, &dir_page, &dir_page_addr);
>  		if (!dir_de)
>  			goto out_old;
>  	}
>  
>  	if (new_inode) {
>  		struct page *new_page;
> +		void *new_page_addr;
>  		struct ufs_dir_entry *new_de;
>  
>  		err = -ENOTEMPTY;
> @@ -278,10 +283,11 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  			goto out_dir;
>  
>  		err = -ENOENT;
> -		new_de = ufs_find_entry(new_dir, &new_dentry->d_name, &new_page);
> +		new_de = ufs_find_entry(new_dir, &new_dentry->d_name, &new_page,
> +					&new_page_addr);
>  		if (!new_de)
>  			goto out_dir;
> -		ufs_set_link(new_dir, new_de, new_page, old_inode, 1);
> +		ufs_set_link(new_dir, new_de, new_page, new_page_addr, old_inode, 1);
>  		new_inode->i_ctime = current_time(new_inode);
>  		if (dir_de)
>  			drop_nlink(new_inode);
> @@ -300,29 +306,25 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  	 */
>  	old_inode->i_ctime = current_time(old_inode);
>  
> -	ufs_delete_entry(old_dir, old_de, old_page);
> +	ufs_delete_entry(old_dir, old_de, old_page, old_page_addr);
>  	mark_inode_dirty(old_inode);
>  
>  	if (dir_de) {
>  		if (old_dir != new_dir)
> -			ufs_set_link(old_inode, dir_de, dir_page, new_dir, 0);
> -		else {
> -			kunmap(dir_page);
> -			put_page(dir_page);
> -		}
> +			ufs_set_link(old_inode, dir_de, dir_page,
> +				     dir_page_addr, new_dir, 0);
> +		else
> +			ufs_put_page(dir_page, dir_page_addr);
>  		inode_dec_link_count(old_dir);
>  	}
>  	return 0;
>  
>  
>  out_dir:
> -	if (dir_de) {
> -		kunmap(dir_page);
> -		put_page(dir_page);
> -	}
> +	if (dir_de)
> +		ufs_put_page(dir_page, dir_page_addr);
>  out_old:
> -	kunmap(old_page);
> -	put_page(old_page);
> +	ufs_put_page(old_page, old_page_addr);
>  out:
>  	return err;
>  }
> diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
> index 550f7c5a3636..20d224c163ab 100644
> --- a/fs/ufs/ufs.h
> +++ b/fs/ufs/ufs.h
> @@ -102,12 +102,16 @@ extern const struct inode_operations ufs_dir_inode_operations;
>  extern int ufs_add_link (struct dentry *, struct inode *);
>  extern ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
>  extern int ufs_make_empty(struct inode *, struct inode *);
> -extern struct ufs_dir_entry *ufs_find_entry(struct inode *, const struct qstr *, struct page **);
> -extern int ufs_delete_entry(struct inode *, struct ufs_dir_entry *, struct page *);
> +extern struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
> +					    struct page **res_page, void **res_page_addr);
> +extern int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
> +			    struct page *page, char *kaddr);
>  extern int ufs_empty_dir (struct inode *);
> -extern struct ufs_dir_entry *ufs_dotdot(struct inode *, struct page **);
> +extern struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p, void **pa);
>  extern void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
> -			 struct page *page, struct inode *inode, bool update_times);
> +			 struct page *page, void *page_addr,
> +			 struct inode *inode, bool update_times);
> +extern void ufs_put_page(struct page *page, void *page_addr);
>  
>  /* file.c */
>  extern const struct inode_operations ufs_file_inode_operations;
> -- 
> 2.37.1
> 
