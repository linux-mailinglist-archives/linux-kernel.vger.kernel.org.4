Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9651D74E932
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjGKIgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGKIgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:36:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297EB98;
        Tue, 11 Jul 2023 01:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689064560; x=1720600560;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JoKrIQYVj2m+Pz5VukJhfK8OfshdXBH/M7P4yGOGtqY=;
  b=diPHtrtpDnUHf8MWIU/wyQrukxBq2c0lJPG7v9BALI+otHZA/QoPUBU8
   7M/SsMFFOWa7/7H8FxjO/8ITbBARKfY05RnayA3z0IFce4rp05uhMLj2m
   EMyuPk4hMR3kt5jm4zaZUl1prTRvzlneMdAmvZb4/ZRg2eYN7/WqHq37k
   vYXJ+q27AvoUV8pteQJTBcUlxOOaiQPFfH9KesgOk2oMrX7wRRazqmDTN
   /OWDm2mv7HVJ8nXls3x8J0VJYw3PdOhB4wcstIQmo7lO6XRYMM0YR7Qml
   NHt78kSGDqU/duMzYi9c66SnmljBEI6VlmD83FdUu04XXxPfBzR84+ppL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="349368209"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="349368209"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 01:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="721024607"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="721024607"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2023 01:35:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 01:35:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 01:35:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 01:35:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtTbVzcMc1obfHlctfNsMO+QMj5TaKzWUo519S++57cCX2vmr9O7h2qirgWrA4AIG2BjLhavpCh1Jj3H5vYxew2tFSOOCtxLDYnyc9C490IiK7iqfB3v/QXHEE2i+F3DEIdXSe/BG7DjU+Gny418kTWHzG5yhMXYprC+O1NAJY+xLqwuhTEdp5XfP5bxQFIFs8mqESwl+NvfnywcNARx6eueFl4+q2u5cG4VFkZ4eoq4zNm71/ORhVdzdKE7bU0eua4MefFodouX3TmqoXQKJlbkv38S2PAUdMFq1VnscDWhh++5+pp5GNhCfCuCZQkrNRywuH6oiOVZLSvVkM9Ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bUkvqolAEHLXTCBItaPCLIUb+5qGc8RDXsctMy/i/4=;
 b=f5UMeJoRoistnaL5gdHLa1u+kk5Sn6+VzIZ8I8bN+9eMpaTv96eluJ+KvoLJQcbjSdoVcbR7B7MVeMJuztqCxlPhNLWKgav7Vqsf6jDqLSGD3ZBUWTi83gJp0mBLuOTJEdJGPCHT3wWiwponh1lmgBWJRAelrgzQuzVL7BklX64sDOgrEj4mvSoouaECWEt3kjqUDxZ/pybel8Z/7pOY/Ft/HmqpIgmhWK4AwdYSEfpNC0OxLXPdlb85hheLqV1wt1tGUw4LtcjsoZDhYcArr4NSAN5FKC7HFKbxsvEiPTkq2Fa40iYHHGiwmfM2lumY3+i7VyTfNmM7VPiTB9NUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SJ0PR11MB6767.namprd11.prod.outlook.com (2603:10b6:a03:47e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 11 Jul
 2023 08:35:56 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::87ad:6b1:f9f4:9299]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::87ad:6b1:f9f4:9299%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 08:35:56 +0000
Message-ID: <da09fbe5-17e6-bea4-80dd-be4a0394541e@intel.com>
Date:   Tue, 11 Jul 2023 10:35:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 06/10] ice: remove
 unnecessary (void*) conversions
To:     Su Hui <suhui@nfschina.com>, <jesse.brandeburg@intel.com>,
        <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        wuych <yunchuan@nfschina.com>
References: <20230710064105.173647-1-suhui@nfschina.com>
Content-Language: en-US
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230710064105.173647-1-suhui@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::15) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SJ0PR11MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: e849f8fe-087a-4dd4-6efe-08db81e9d7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kz6DVXmrEXX0RoLZ+mP3+WT+W1mW5oa+ZWC97MFtZpR6POdw51qFSt6XuHVaRRt5YTUi+PgN6spS4v4iYXowZFLm1N6SjELRUPJfiaS5Kk1nZhpH3Wekp5uZAK57xT0QiXNclvnLD6JwimrUeWAau9+VqgFfVr6/lR7Unf1BR4zMKkU/tTlk/R+6wtFvl+Qx1A8CPcPQuVNlR1R1NmRZz/+Y6Zh2lVCzLNpDFv63mESH8HHkV//rMWb6BxFBJPiQz+CVoRG1iY/LZZg2+3aYT1yuJurqa3oRLPTaeLtmkfwHEur82zTxWM5UGZ+N/ajCii3VxPcZjPvlwb3uaM4uD74jpDO9koZjXXId5Mtzm7BlRB/T3ZZPeod2JrA8vV/kMujOkx8Z8a4S46cUNkgubyhqKqwuRLzvvViYTSHIaC4SgXmYuzyBbVKgBeYgeG9kKeCVGPawsr04IFWcjWGgWMKbqJjVkk5vIlmNriQad6t1KtBLdGoUJC3zzwhIQBhzI/XINPFSWzbtAnGfvmdhkiJ4akasR9SmTyv9z/4B5U9Y3W2RCIm/LSR++aUdQcHceGM0+B7RNW5NA1ffS37sP9KH1NCbLvBhwC1tryZTTc2jBfd2U9cTd/4AvH84dpIkiFi3tmjku/N5kHucGV28QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199021)(7416002)(31686004)(66946007)(4326008)(66476007)(316002)(66556008)(2906002)(36756003)(8676002)(8936002)(478600001)(5660300002)(41300700001)(6512007)(83380400001)(31696002)(86362001)(6666004)(2616005)(6486002)(82960400001)(186003)(26005)(6506007)(38100700002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0NTNnhPSXVLQWVmUHlpcVBHd1RBWGEyWHRQR2lGeExvQjVGbnAwbUJXcEVR?=
 =?utf-8?B?czE3TnBpZksvdGRrdEM2dW5BTk5ZZDNEVHV4eVlDbU9MOGpEQlVDT1QwUlhQ?=
 =?utf-8?B?Yis3US9waUdFVkZPRktXemxRWWR2bTV5clVPTndTRzRhNTR3SzlWbWJvU2FY?=
 =?utf-8?B?ZW9hakhzUlVWTjRDV003TGVtbEVMVzlWSTMwRGh2L3FES2tTK0hHZE16SDU3?=
 =?utf-8?B?Umw1UVVEU1l5S3RTcVZ6aE9pSXZGYkh1Z1FlYzBoNyt4eXBnRjBIYkdVVXB3?=
 =?utf-8?B?M0xWQ2s5ZHF6MDA2dzVUK3FnZmgrLzZoT2k0a0RsTWdRTFgzcGZCVUNYVzMx?=
 =?utf-8?B?K3daZUJYVUdIZUJqUWlPUlNsZTFEWFdMSXBqdGhmY3plelhONS9pSEk1M0pT?=
 =?utf-8?B?bWl2YUp2YkNSSStpcmJSODAwRksrMXpLc2czWTlsTmtLWEVEeEc0MERNZlJL?=
 =?utf-8?B?b1pSanBLYzBBa01tOWZYZmxlR1N4b2kzR1J2N1JpTjJZSXU3Skg3SU5xZVkr?=
 =?utf-8?B?SUMxdUw4Wlg3bmN0UE4rWVVIc0xaOElWOFduU2dnN2JLbW1UWmlXdHEyc0dH?=
 =?utf-8?B?NCs5RlVzQmlRSHhhSklyOXFjTC9lN21pdzVyQW9lTTVjNklhRXpMNDE1OFV6?=
 =?utf-8?B?aTNUTHcwZWxielZUcmxJMGdPeUFBTTI3dFBuRmZlK2NQTDV0MFJ6RGJrandG?=
 =?utf-8?B?RGFaUXVpUTlabjA0eU10WEY3bGhqZ1BBVWF6dU42UDRVM3Q5c0RvTDhDdG56?=
 =?utf-8?B?TG1tbk1qQTM1U2xuaFVXRzNPRHFUckpoY2tKVmhxbmVSeXptd21OZTh6L0pV?=
 =?utf-8?B?WllNNFFLR3Nyb2JkQmFZVzYyTGRYYlJYNndRaVhYbXdYdkY4QWxham9lNVBJ?=
 =?utf-8?B?SzhOVFpKSHh6OWNJK0dpVFR5MXR4WFdSL1dHTmlXM3J0YUs0SXQrOG50SFhZ?=
 =?utf-8?B?Z2k3aFkxcTgrV25QNFlxZ1NhcHhUTmRZRDQwSnI3V3NzNXpLQ0VLd3oraTl4?=
 =?utf-8?B?SDZua2NaSGMvZjZpNmZOakZ1RUtDVnBqR1ZJUFg5VU9TdDJBMTF3YUpGSXdO?=
 =?utf-8?B?Q3o0ODlxeWErRzkyU0MxSWw1dlZBNUQwZWN5VzdDeDR2RlhPMUtkdnRoZDlw?=
 =?utf-8?B?R3RMVDYyeGJiSnUxV05nd0ZtMFRlcGt4a0tZSkppZHZqelJLYlIrMjFFM2hr?=
 =?utf-8?B?RzNOZ1pBclc5ZkRiTm9TV1VhU2xNWEIyUnp4SFdUamhMTmFUaGFEN2c1Yitp?=
 =?utf-8?B?NnZGc1FTdDhCeTRxT2VJZ2JmaDkrQ2VJSTNrSmRObktBcXVjTlhkZmlHTU92?=
 =?utf-8?B?MTNCaXFHM2tmcFZMQmlTNmF5NTdCT2NjN3FNYXVDTS9pdml5SFEvRmxEQ3RG?=
 =?utf-8?B?N1hSNHRsZlRpUHZERGp0Zmhyd1RNRC9Eb01JZVIrUkN3Z0xOSUl5ZWY5eERG?=
 =?utf-8?B?MmdWWjM1STJKMXpURTVkVWI0cEdlZFZaaUpZMXp5SlIyK3Yyc1NsWFZUdjFC?=
 =?utf-8?B?ZHlvd1h4VlBsbXg4Z04yV3RwOEVMQkdvVGtYNEIzMGVYL2dSbTBua2RuQWoz?=
 =?utf-8?B?dXhlanMvaGhHSThOT3JMWGdnTjNJQXJCQlB4dzIyVWRjNEFrWVBpNkJaenpj?=
 =?utf-8?B?SWJFb21IRGVjallyLzVMUTlJa1kxbFlrd054UDJxVlhoa0orSGt0cnY5aXBo?=
 =?utf-8?B?TTNGYXNzaHlPWEZENzRqakg2VE1sK2haV0RoVGRHMzVXaGJVT3R0eDJCTE9s?=
 =?utf-8?B?Y2hKaUQzbzlZejFtcWFMU2JOVDAwR0VrVDZaQXhvM2pOajVvVm90NlIwSEtC?=
 =?utf-8?B?MHBUallTNjNIWm9oMHZ5c0F1YkFZZEF6VFBKZWV6REppeGFUbEJIZ3VIakpu?=
 =?utf-8?B?UURkZzV4elFoR0g4QWd1ekhIODdqdUFWUGFxV2VvcUg4OVJxeW5xZW81ZkNW?=
 =?utf-8?B?ZzBhV1k0ekdYSnFBN3BWQ3o2d0NRQ21SSVJuRGtNMDZJVFBXbkRDMThFOG0y?=
 =?utf-8?B?eXBsdDJWMzZZMVIyVjQ1NTI1elc4T045U0Y3WjFQUWszM0V6Z3Q4cC9CeG12?=
 =?utf-8?B?bU1zSG0vZ2wzSnF2enFEUUZ4eDNJdEpMMWdnRTVUQmQ3aGxJM3NlV3ZFbWxK?=
 =?utf-8?B?dmp3cWFpc0FvRDNKd3cwemkxdzg3a2toRkk2SzVPMk12Q1Bvbk9yelJlRjda?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e849f8fe-087a-4dd4-6efe-08db81e9d7f6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 08:35:55.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E38DDWA64YMqaEBtr+sUP0DxIkRU7VSBcCgfqEs4X2V55G1mkNx3Q88y9b1l8F9Yo6YX9A/uzTVE8hYsIOtaNzia0DoRhdhqzDrw2vJh6wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6767
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/23 08:41, Su Hui wrote:
> From: wuych <yunchuan@nfschina.com>
> 
> Pointer variables of void * type do not require type cast.

You should rather tell what are you doing here, perhaps:
Drop casts on dim->priv access, which is "void *".

> 
> Signed-off-by: wuych <yunchuan@nfschina.com>

You have to provide your own Sign-off when sending patches of other devs.

Also, preferable format is "Name Surname <email>", not a nickname/corpo-id.

> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 93979ab18bc1..52af3bd80868 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6242,7 +6242,7 @@ static void ice_tx_dim_work(struct work_struct *work)
>   	u16 itr;
>   
>   	dim = container_of(work, struct dim, work);
> -	rc = (struct ice_ring_container *)dim->priv;
> +	rc = dim->priv;
>   
>   	WARN_ON(dim->profile_ix >= ARRAY_SIZE(tx_profile));
>   
> @@ -6262,7 +6262,7 @@ static void ice_rx_dim_work(struct work_struct *work)
>   	u16 itr;
>   
>   	dim = container_of(work, struct dim, work);
> -	rc = (struct ice_ring_container *)dim->priv;
> +	rc = dim->priv;
>   
>   	WARN_ON(dim->profile_ix >= ARRAY_SIZE(rx_profile));
>   

Code per-se looks ok
