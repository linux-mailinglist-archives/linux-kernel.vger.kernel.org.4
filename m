Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063B470FC7A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjEXRSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjEXRSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:18:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C20BB;
        Wed, 24 May 2023 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684948722; x=1716484722;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HbCt5jy8CXf6A0tu2BTAKveAKadXHasb93l61S5/VRE=;
  b=R0g0cnTH7ins8GazmB54fWzZOJ67OuRhnSrduVbCTRMULB8bQTe3u9WF
   /h/KyjGILq7dy8n5tybeJ/qtdMDs5u6srVJpFIHq08gsHJJzdwKAPyqQD
   3ZEb8n9VuC0WvrngV8Mi8P/sM2r9fH0aVjdGnShHZjrelg13bpayAAWnl
   GVd5UxCR6Hevr/Qoe1rPNjBARhl0LGBAgt55M+AVae5dcnc/2mB6VUiTj
   PFGcXYPC74IRK7uSXVRmYrwhTCIjTjZrSTopLdwAsivyo/zxovQ3Indyd
   XweH+0dxj8nEcH7Ol5bmWvibInMiCXYPY0/xYTSctCrBYgI8ubh4bTKBu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="351144277"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="351144277"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769531203"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769531203"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 24 May 2023 10:18:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 10:18:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 24 May 2023 10:18:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 24 May 2023 10:18:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHXNJ54Hs4sldYqZo5sXPabzruL3bsuHlxzobQAkZ0EhQKLRQfbbqmHyFodqju4cims3HHeDsFZ/QwXvgY/h6mBxn2mMjCpv1MMItoUBbmrxX9xd8Kimi8e2+yUgVlZkL3WtLNyp9FKISx3WwRCH4/SYQzvBZrl1rg2bI9lHUZud5lc9WO8c6pPO7pkwrWBJxqQubp/GIuOHzICXzIDrt1ADCPGSM8mUiqXlQ6nd+p/a3Y10kA0oRcrGqqFp2C09aGIC2v4nbaertmNSSmAyM3Ioiwz8eS4nJ65cFdwpZ5s/+1A0mRChb2QKqN9ws2mML/wuyHvaud8K0ONowpvYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlH4Iyf/0SLgLNGGfGM7dmSuH75p+bIUmqd//XStDRM=;
 b=liAoD7e9LFaAPx+dDtPAX7c4maKp3DJA2qxu9BazOYBqejzeaOz5tFQoxBNAtPU41GGxyg0dKYlB5yrKjMnhOtw7gIbunofSOwNu8zjyp1gtUBcg9QOTX98WZ5si8ni4P2Yk8DE92yyh5CN7OOkhRrHHe+gtUmC+wOOdNJvAeoBP/relLQoAASqaqctELfVEmvDECK9n9m8tJ6fouXXfPnuIessnQt3uzdT3duSZKqI3zbJ0Jp1Cc/fXb/5ZxDvQR9T6Zx0SXDaFme2/Js/jd/pGSS1FF4/+DOEvjXCLt0caSEbCwM08AQvP+hAuQIRJ7YuWBrqcck5rCbIptJGqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 17:18:23 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::bad1:92a2:fa0a:1850]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::bad1:92a2:fa0a:1850%7]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 17:18:23 +0000
Message-ID: <fce772b2-29e1-7daf-0a61-7e8e78f7331a@intel.com>
Date:   Wed, 24 May 2023 10:18:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 11/12] crypto: x86/aes-kl - Support AES algorithm using
 Key Locker instructions
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dm-devel@redhat.com>, <gmazyland@gmail.com>, <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>, <bp@suse.de>,
        <mingo@kernel.org>, <x86@kernel.org>,
        <herbert@gondor.apana.org.au>, <ardb@kernel.org>,
        <dan.j.williams@intel.com>, <bernie.keany@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <lalithambika.krishnakumar@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-12-chang.seok.bae@intel.com>
 <ZFWY6/VelArVYy1F@gmail.com> <288de217-f0ff-658c-5490-6fbf5f57f5a7@intel.com>
Content-Language: en-US
In-Reply-To: <288de217-f0ff-658c-5490-6fbf5f57f5a7@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:180::36) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|PH0PR11MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 393f1cee-0e98-4997-0f5a-08db5c7ae0ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDbMrULwgrIbAASEWmtW+W9YQ2WqB4Xt21WZ2LqoTiPmNsnnI7q7Wrdwn5/jUruEjBpc6vyjectaeTjbqgW2rCdsk+RK/0SMCUOj6f3jYVU0FK937lDc81SFhVRzsrE0ZGipqLwIOMjHrvz7u0koF0Ac+JMntMVXY3MT4lV0H2ASvIX/0jjJeDr68HKzjrTpmTBDrVcefpCtAh2sGuLsqI7tXc5bWLonQ4gOibxGE3r/Tp9rUqQXFJnbYSywEJmuXeU91IOHkm4TBxLVnJkEiFk49Rtys1Oibdc/+BBD/Bw0HYjr5AmAZwgzgLN2wf5EX1fKtVHVK5NqRfdsbpjJmTH+p9zX7TW9uQwreylVrqZgkydmpvMVs6Ss+8an3Xh/E1IBqCbw4eNPb8x8Nm7j/PE/KZByvdJjG1EuBjhvCBPlMGKATTWOLI9bCKjgVdVLsmvAZToi4AJiWzvvvFE/Wbw/Oh6RMpIYmKzkpLZqSKsMBxw3y2gAclPaPcA/7xqCUzxoqx7zvKq5bBMaEHSQbV6F7Uem0VbmfReHBfcG02j36OJjX5zcRly8J+zjvzz14V/4nbKw/7cLoYraKTQMS4eh1WiL6mPtBvMreKb0xgX9sBlI4Xz2047cRIJBZpGkGPUPJ2ryWfSVm2ssAIC+Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(66556008)(8936002)(5660300002)(54906003)(83380400001)(53546011)(31696002)(6512007)(6506007)(86362001)(26005)(186003)(82960400001)(2616005)(38100700002)(8676002)(478600001)(6486002)(66476007)(6916009)(316002)(36756003)(4326008)(41300700001)(7416002)(2906002)(4744005)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3FkN1p3alBzSHVidVpqQmJ0Z2J2eDBNOWJ6SlJJU2c1c1MrR2dtRDIyd1JL?=
 =?utf-8?B?d2xYdFI2aXRkR2RvdjZmay9VcVphay9FYU01d2t1UzFBNjk0OXBtS3Y5YkdG?=
 =?utf-8?B?YkNFakUyclZrT2g5MENLWnVOMHNJY1M0eGJMOVJsYjd2aDVMTHVwM3U5NDN6?=
 =?utf-8?B?M2Zwd2htb1dSUExoN1o5RFZtQlBQdmQ1RnlEY1pucXFLUGdKRTlTTmlmMk1H?=
 =?utf-8?B?VFprQ21ISW5uanRieFdJNTdkeFpyV25oWWhHSnVkQXZUYUlrMUdXYVdFU1VP?=
 =?utf-8?B?WHVYTi9jd1YzSVVzYyt1bk9PMDlBaXMxQ2xMM2k1ZXlqSGxGZ2p1MCtqeXFP?=
 =?utf-8?B?aWJoRkRVSERBeWVtN0E2cE9ZdTNuU093Z2VwdWhBVmRDNFJUclV5dDVpR2xJ?=
 =?utf-8?B?NGpjejBFQ2pxRHJpbnhKanQ2Tm4wZFdSdHNzaVZGZDltL1REMnhvZTFNTFp3?=
 =?utf-8?B?ZzUvN3VKT3htbUE4eTNBUVJpRHdySkd3S1FCalRuZzVYSW1qanNYVE5qMUo3?=
 =?utf-8?B?Rkk2Z1NOc2RuL1ZoMjZ2dFBRMnozVm9ieHB4QThYTkdOZUorYUtDcmpXSnJu?=
 =?utf-8?B?citTdUpVUmg4dXRpblJrZlcwMmNqaVpEcysydjE4RGpxRnMrN2dnSDIzVHM0?=
 =?utf-8?B?RDR2VGRJUlc5Mjh1bXVMQTRualB3Z3FxWC9ZbEwrc1hwR2F0N2lORlVBajhj?=
 =?utf-8?B?UzZRNUZlalRmMDNFUW9RNHJFSWJ1VE53d3ZvcEp4RWNyWE5qclBXVjBNQ0tI?=
 =?utf-8?B?aENUeU40MUpIYlBITXhHaEgrbVV3QVhMSDJZRmlJTGNhRk4xaU9oRjlUdDZQ?=
 =?utf-8?B?dzNpWFZmK3lkQnlJcUdkVlQvRHBTa1R5ZDU0NnZsWkt5Q25YaUhEMURxZjZV?=
 =?utf-8?B?RzB2U09PT0p1TVhUU2VlQnIvbklYMVNLaFBWS1RHSGhRUXJ6a0UybEtTS3g3?=
 =?utf-8?B?YTZ2Y3ZZUE5XVTFralJvQ0t4ZnpFREpaSXpkTTd3dk43eEEyZE13K3RSR0pQ?=
 =?utf-8?B?bG01NzRuWmVJQ1RWR3RQbmdhcHpSeGtSc2dUdDdyb2o1cStONEhHZXdJTkc1?=
 =?utf-8?B?ejNhck1QaWJSYmhSdUpDSXFtenNsQ2Fsd2laVFNRQm9yMG1nZXFRSEVwR3pr?=
 =?utf-8?B?Z2FLeXhQanlTZGJQNU9INHZMeElvSnduTVNHblNpMlJyYTg5d0hFQ2FLVDVT?=
 =?utf-8?B?NVNka2JpMXN3RXVBVzdaaGpOYnlxTE5Ea0tFeDJFZWd4RzNHb2xxUEl0Y3JL?=
 =?utf-8?B?cDVwUFZ4a3g3bWtYQ2VtWDNMTWg3YXhTYmM3MUxaalhpK2p6S3JqOVhnb2xr?=
 =?utf-8?B?R1NVZUEra3ZzcUEvWExwU25VcEY3WHEycXJ3N0ZhMzFLeW5IU0NVSnEwTWVG?=
 =?utf-8?B?MC84R0wvdUVHZUhqQUJSYlZoT2pOelhzZEN2b1FGdnZXQjVaT2xFcEFodXlr?=
 =?utf-8?B?QTAyKzZ4K3NwbGlGOWFFSW5GWXg1Qm40K25yTmcxeUVnQUtaMHlNY0pRTllG?=
 =?utf-8?B?bHVzbXRmNmMrS0F5RTk2Ulg4eTI0OUVQTm1sQ1E2RWdEYm5LdURNbTVYZ2Fl?=
 =?utf-8?B?SkZ6MVJXdllLVnRzdUxjN0IySEpzVTZsQ2dVd1EvOGFNSlRCckhjUnp6a2Vt?=
 =?utf-8?B?TnpHKzZBVEF2SkhNcEVoOUVTc1dkRmF5VHNMVFE5dTNBZlJoS0JrWEp1SFZP?=
 =?utf-8?B?K0lXWXNoNWFIV01ydHN5Y3dCVDRLc29HdmR6dTUyWFBVSUJtUXhDbExkcCtD?=
 =?utf-8?B?N0VqU0xjWTh1WlBHVGlSU3F3d000TnpKWEpjd1hqdEtXeUZQb3hCb05McllO?=
 =?utf-8?B?OHpTWG9JVVRCSjdmMC9rYmowNitFQU9xall3SVMzQUpOMHJUNFpMSHg5d2RT?=
 =?utf-8?B?OHpTbXFjcFZFZ012OGQxSmRMTHlpUUQ4Y3pITEtIOW1oblZFQUs2ZXBNd1p5?=
 =?utf-8?B?MVorUGpmckZrTURnTGduUXM0WUNOemU4bjJKOFFGRURHeXNabTY4d2JjT2x1?=
 =?utf-8?B?RGgxVnBjZ1pNRXRjaVYwdzBwcVoxWXlYekhjVFVHTXVzZDA3cmhPQnQxMGJH?=
 =?utf-8?B?MndsSytLZjNZMlVYSXRwcnJXWDl6aDNhbUZoRnp0ZnI1Nno0ZGN6MFZOVWl5?=
 =?utf-8?B?SXJCU3lrRGlTWmF3QXNib0RqKzlDWXlPUzRLQkRYVEhrTk5Kc2tPQVcrQ1dm?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 393f1cee-0e98-4997-0f5a-08db5c7ae0ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 17:18:23.4338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZZmXvfs2R4qSq+Q4WK2PEkOrSz+A1/oarfpSDX+9likOBMs9PD/frH7DF13NLtU9SKeTdQbGzPUZXDHeV8b8qEXVJVAyxxSzcBpApEDInI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/2023 11:18 AM, Chang S. Bae wrote:
> 
> I thought this is something benign to stay here. But, yes, I agree that 
> it is better to simplify the code.

After staring at this a bit, I realized that at least the feature flag 
check needs to stay there. This can populate a proper error code when 
the feature abruptly gets disabled (most likely due to the backup failure).

Thanks,
Chang
