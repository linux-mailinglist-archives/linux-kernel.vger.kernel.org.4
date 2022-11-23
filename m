Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C4D634B88
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiKWAMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiKWAMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:12:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A898531ECA;
        Tue, 22 Nov 2022 16:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669162369; x=1700698369;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4+df5E74e0sYrFKMScv03qGS+k8LudYFfEmlECsucE4=;
  b=YPkoqtScnwJ31jWdxKNOXYtsz4ln/P0dFKZmzhF7+AzYaZCgtQTxZsnt
   wiFfIae6A8/XTHtYNvEMgPqqQdpqnK7t3y29XgXo0Jp0+J3ZWcaHpIVfN
   6BVg/0ih8Q6OK5XoH9DwJiYCTuvxKquHbPhKN2sgElqFkpRDb0IiCS6F9
   jRYHLwvBYI/U5p8Wlkk/2HEdLPysIMocodikiarp75wBDRyaq3FlYxrzd
   JFerVSU2Y4QSkNX3t0SdZKUV01Yz26t4zERcX8DiS3IyX4hwTAzCTGw5s
   O/XhrBvS2xXTDSf++8id2tdLXg8V32nDxW7swaeimwQFOn8B3DpjbOJX5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="400236018"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="400236018"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 16:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="635722143"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="635722143"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2022 16:12:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.13; Tue, 22 Nov 2022 16:12:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 16:12:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 16:12:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQOhrs9tFbMl/qlBP8K/hLN6BWu1YN0ahOLg3jtrSERiszpnVVFT2pnVE+1ixZIiEiDh+qp1FDa4RmXW3BgBMMwMadRdYHsO8NPRj17pmjucjFirdaNdEbD/SKDj5YoQxAN9J4GrooCnUM/N2NwVSV2tqJ14UEbaPrO0T9+JYx7ssZTQC4ogsfLNOvHemySoXuVt8JdTjCfnO1A23iSdn7/x0kwrVF78QmkvTbuLraAMuN1LXN9t6vEMo+kiLItBnKEhrCvv5nDi4fIVVXsu6dMMOn4QdbrIjopfEydNTLvkQ+UXELLVr56MmyedhnohGHv26PkmaOYUqnwtXRnb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MArd2LJPapncXqnF4l2Z5EDYLIYynWZY92eQ03s3404=;
 b=CCiuQ27+uCcJt/6JpzJ+bsAnY9f24fLi288wt6OzFx7N0UE09/Grv/PbgIs2y8Sc/5cmc/yhWYXyaI2lwyi1jHk5VEyRylms7SE+VHz1gQMH2cQh1wINMOhwAX1tFCvSxjGXeCvD+oY2PgOSpuAlfDM6/xKw8Xm+Lq3GNpy4VkgFcgRN6/cXVCVAAnesVAVQBQQv4RUVhdkrkOno3u+m6qCR9oMLZ45j7LTgCOJza/rLikwfZIUQC5nvcDaq/erqnWg69MkqA6sTMK73HmLv0TkWDV+lHEpDJ6r0bhPcqPkz5rT1D/GOr3qZWPbkkOX1+d0Nby2JtWfiFxh1Tlsamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB5988.namprd11.prod.outlook.com (2603:10b6:208:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 00:12:34 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 00:12:34 +0000
Message-ID: <d2209b3d-374c-efdd-a91f-217f1db3b4bf@intel.com>
Date:   Tue, 22 Nov 2022 16:12:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 05/13] x86/resctrl: Detect and configure Slow Memory
 Bandwidth Allocation
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759202922.3281208.6231300030834095574.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166759202922.3281208.6231300030834095574.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0109.namprd05.prod.outlook.com
 (2603:10b6:a03:334::24) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: ae443f8c-3314-40da-7f23-08dacce76b8b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8+4fc6FH39OUOIGGENN/VYltS5G4nz3iDOC3Uk776q32RYbHo39zqSEF2HsURgMiAZKBEoPqnMNU7jm72FaNIaK7HtDC/yEGJ8S2ZDtg6DlbGzMjFxB5awZjPxlTCa8LXJF73aoDLGv5VtfP/+S4n8ivyVQ4Jwd3CwR01pbCE2TUjBpmcIVFZgZSU31Qc7iIcTuSnE1GzcvPyqodb8hQBXdF0n6QZl1KSNkmzFrSAvweD++Yys36YJgoVVuNY8JRh2VCMuGKoAtmM95j+gJmifSnsHdCGBG84z+R6DkfCgGbEstqTCwr48xTDUaOSXdZKBxa/ywFIHNQqzay+z18Kx+GvU+3iYebyC2uPH44d8cw1xlbdPr+z6WcZKo82nYNfmI9GwsMTs7L3GoQCgbav6OzURevP/pjAxVBufBG0EioJTtEiwsQa3rIM9MI7XPIV3Q6Lik8TRT1Y5GjTJPUrQ4fjb9tYCLLFf02sz/z6o8wGay/o1kp5Q091tA4BGY5hKE4kLKI+IEPxVMFJCpV4Qp5p/pe73m2zk72LidQBdfmDmBf8dkI7LhfyFUjWn+yVcPHEw+tCVmlSSmYmD6JqQQRAX7SNqeKls698B6oVkjEBVYF9cIyW0j1TCKzXWJBIxYA1zzwrJJ4y/J4MX2ZeXn5bZUOHv90r+Ec3yOknpkXw6eQPtggkdjxoURouZ336REuEXVCRanESs69Bmjw0K2pNef5K+Q+2rJbayvkXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(6486002)(6666004)(6506007)(6512007)(53546011)(26005)(186003)(36756003)(2906002)(478600001)(38100700002)(82960400001)(86362001)(31696002)(83380400001)(2616005)(8936002)(7416002)(41300700001)(31686004)(66556008)(66946007)(66476007)(44832011)(8676002)(4326008)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWNqQkQrNWdXellwWU9nY3oyL2pOMENtWUhYNGFKZUI3OWVhdWVranJlMFYw?=
 =?utf-8?B?anI4cHRabUxCaHJrTlJUYVpqQmU0RExZUG9MeWFnYUk2NExpVzEvWTA4UFNO?=
 =?utf-8?B?d25HVG9Ta3JsTXVqZ3B0WFA3ODRhbEY2aDFRZEh1a3Z6aVVybmxjcm1CRHRJ?=
 =?utf-8?B?YitKL2xWekFJckp6dFFPTy9ucmVJZmRtL0UxY2dkV0MzYXNjdDhqNmpzVDBa?=
 =?utf-8?B?Q2x2VTNsTExuc1JXNEhic0lPVE41MjZSNmNDNGk0UzdXUjdMeVVwdmJCb0pU?=
 =?utf-8?B?S1RTaFZqTHRHMzdlR1JOeGVRb3hSaGZ1eEE2aWxOR3RNaXJFeklQSTZCWU5q?=
 =?utf-8?B?NFFWRjIyMGsyaUZqZUk0anV3R0o4UGlDMG9MM1BmZFJCYTFYUlh3TnBsRHNv?=
 =?utf-8?B?SFF1eGNwVGJwK1U4VmFnRkpILzA5K2RuNWQyYU40aGxZL2ZMdUVYTXJpNUpU?=
 =?utf-8?B?cEFObUUvUDNiYVRhdy9mL1lGajlUTVpaVDd2L0ZITmlwUjZ6TUVKdXN5RE1r?=
 =?utf-8?B?Wm9MYWw2TC80dnFqNS9FSE9ldDZXTU03di82S0tHQTRtUUx4VUNSYWlRMmVm?=
 =?utf-8?B?b1FHMmZHSGl6ak5LdnBPNk13amtoYzFnT01zbEFYbzIxL0RpZVUzZ1ErNGZK?=
 =?utf-8?B?bGZnY3FTM3RxT1czZndnYU9rY2ZiYmFoY2xUZVBlYjR2emIwaHZJR0ludlph?=
 =?utf-8?B?VnhvZ3BmYmZyQit2S0VaRVVBOTZxMlI1S0Z6WFQ1aFRsYi91NVU1MURKYnp3?=
 =?utf-8?B?Y1BBMVVjNStXR0g5Rno3Z2djczdIZjJUNFdsaktDQ2puRTJXRnFqbnArWExm?=
 =?utf-8?B?azdDS3d5V0tsdUtvRERJbFdPVlpWL0VWMzFwTVh3MUJRNld6cUxTV0daMHBB?=
 =?utf-8?B?d0srOWdZSUYweHVyY29Qak14SjBzeUhwdmE0NmNWOEVTaGxXanlGdzA4Ykl6?=
 =?utf-8?B?dmhPOHdDbDhsT1ZEbGQxZ09DUVNNSnhTZ0ZNcHZpUFIxbFpNYXBZZU5taklR?=
 =?utf-8?B?RVR4bUVJcHd3d21YakdXUU9vcS94WHd4YytxbE91L3l1RC9jNGVxd3I3K2F5?=
 =?utf-8?B?WS9MSE1SemRXelZlTG1GaW02VTNyb2VobUU1U3B2S2MwWTRrNVRPRzRsbTRW?=
 =?utf-8?B?YUxLV2J6SVZzbkhDc2hPNzBFN1FidUk1MUFGQitrMlo1ZWI2QmFRNFVtejJv?=
 =?utf-8?B?TkpieGlxVVBSZkFLcmttSW16elhqS3VrQm05bVBramhrbk4vK0thQmRoKzZ1?=
 =?utf-8?B?Tmx6bEYxVTE2SXBUVTI1cHNFem5PWkwyczc3bFkvN2MvV2kyOHhTUE01WjRH?=
 =?utf-8?B?VXA3ekpTZzRCaC9raXhpYUF6TDlsRllLY3MvaWs0YlpWUFpiSVhsM3dXQ2dp?=
 =?utf-8?B?a1NwZXduT0NhNmNHMDl2ZnpMWVV0eEVRcVpYdUZOQ3F5NU05UEhISElvZnA5?=
 =?utf-8?B?NWQ2VUtad1dUS016TmhhWmdWYVhSZmpqZTM0d2loWXlJQ0JKdEljcjI1Nk11?=
 =?utf-8?B?bHllNHpCeHJyUFpzeFFxUDV0eXVHM0VNYm5uakFmeUlPcVpKVnpGU1UrQ3pq?=
 =?utf-8?B?S0FoT011NnBtNWROcEFpdnpWczR5bkNWYmFZY3JOQjlpdEJzdTA3bU9xNGFp?=
 =?utf-8?B?ZWVlWCtzcDBXb01UOG9uQnRHQnh4QVJVVTRBMEw0bWFKYjNNTElsWEptNlVJ?=
 =?utf-8?B?Z2VpdElOS1NxSjkySitmK0JvaDZkNjhMekpndmowRkhSWXpxOENGQStoeGlX?=
 =?utf-8?B?T2tkMFBUQmVOUWtSUDRtTStJSkdsTzMrdWR6bFlkdytuQ3ZEdEVkaSt4WXcv?=
 =?utf-8?B?aVkvQ0FaQzU5clNPcDNXOTRYM0lsTHprMXEzUHM1eTBndHRtN2hLSkwvRWV1?=
 =?utf-8?B?cEJuSy80ZXBKRWRnMThOcXJZWVYwNUpTT1NvblJSNEQ3Z2xHM3JvQkRUZTZn?=
 =?utf-8?B?S2tubnhpeGtwRnBKS3o3ZzdqdDZJTXAwODZJL3FObU9ZeWVMSFVrM0M2N3I2?=
 =?utf-8?B?TDhIaVN4SS81UjVhOU9sdDdGTU44Wi9CaTFxOU1YbVhtcTEyS1lreFRvaTVU?=
 =?utf-8?B?aXVUWHFFVThSYlkrdjdZVS80dzA1d1IvTXJ3WUFXTWxVS0M0NUE0Vk5NSW5O?=
 =?utf-8?B?dTB5L1N6TGlyZTlwdzRXazgzVnFWV2JsYmg5V0hzMWcyRlUxTElSdUtGa2JF?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae443f8c-3314-40da-7f23-08dacce76b8b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 00:12:34.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEiZh3j0//lTpHd2ZR0yaZWl9Ne9ZutgnnRZKbUL6qInG3uQjxz1Wgh0FE6QqRRpjfOr8mF1TmVC23Dkqu/+uk5eP00UXacmLb+NIXzhnv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5988
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

Hi Babu,

On 11/4/2022 1:00 PM, Babu Moger wrote:
> The QoS slow memory configuration details are available via
> CPUID_Fn80000020_EDX_x02. Detect the available details and
> initialize the rest to defaults.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        |   36 +++++++++++++++++++++++++++--
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h    |    1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    8 ++++--
>  4 files changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index e31c98e2fafc..6571d08e2b0d 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -162,6 +162,13 @@ bool is_mba_sc(struct rdt_resource *r)
>  	if (!r)
>  		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
>  
> +	/*
> +	 * The software controller support is only applicable to MBA resource.
> +	 * Make sure to check for resource type again.
> +	 */

/again/d

Not all callers of is_mba_sc() check if it is called for an MBA resource.

> +	if (r->rid != RDT_RESOURCE_MBA)
> +		return false;
> +
>  	return r->membw.mba_sc;
>  }
>  
> @@ -225,9 +232,15 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	union cpuid_0x10_3_eax eax;
>  	union cpuid_0x10_x_edx edx;
> -	u32 ebx, ecx;
> +	u32 ebx, ecx, subleaf;
>  
> -	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);
> +	/*
> +	 * Query CPUID_Fn80000020_EDX_x01 for MBA and
> +	 * CPUID_Fn80000020_EDX_x02 for SMBA
> +	 */
> +	subleaf = (r->rid == RDT_RESOURCE_SMBA) ? 2 :  1;
> +
> +	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
>  	hw_res->num_closid = edx.split.cos_max + 1;
>  	r->default_ctrl = MAX_MBA_BW_AMD;
>  
> @@ -750,6 +763,19 @@ static __init bool get_mem_config(void)
>  	return false;
>  }
>  
> +static __init bool get_slow_mem_config(void)
> +{
> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_SMBA];
> +
> +	if (!rdt_cpu_has(X86_FEATURE_SMBA))
> +		return false;
> +
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);
> +
> +	return false;
> +}
> +
>  static __init bool get_rdt_alloc_resources(void)
>  {
>  	struct rdt_resource *r;
> @@ -780,6 +806,9 @@ static __init bool get_rdt_alloc_resources(void)
>  	if (get_mem_config())
>  		ret = true;
>  
> +	if (get_slow_mem_config())
> +		ret = true;
> +
>  	return ret;
>  }
>  
> @@ -869,6 +898,9 @@ static __init void rdt_init_res_defs_amd(void)
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>  			hw_res->msr_update = mba_wrmsr_amd;
> +		} else if (r->rid == RDT_RESOURCE_SMBA) {
> +			hw_res->msr_base = MSR_IA32_SMBA_BW_BASE;
> +			hw_res->msr_update = mba_wrmsr_amd;
>  		}
>  	}
>  }

I mentioned earlier that this can be moved to init of
rdt_resources_all[]. No strong preference, leaving here works
also.

Reinette
