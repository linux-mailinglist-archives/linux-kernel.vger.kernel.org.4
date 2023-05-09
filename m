Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D56D6FBC2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 02:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjEIAzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 20:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIAzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 20:55:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA933A84;
        Mon,  8 May 2023 17:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683593739; x=1715129739;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=85NKjf1TiKJBicC0LiN1lvQplyn67NRkiTrFUGQ0w/c=;
  b=AvY6CK22/r6SLz+oD4Fl4w+WOXPgZPdEI0tf/1pfFdz+CENkfgZHjDa2
   gDTrrvEUIZYn1z5r8lfazhWtrxzgee/6L2dwPNQr1Rocj2lKGPuaYdNf2
   Rb73vKqfCT70sQw44G2YkGTGLlst3uxaQND7twt3xV0eiOjblDrNvi0z1
   KrnocIZy+YEfHndw/jhNaJK1Wohm3lDxKqFw3P7nDIgyZ0hmJGNKplmfM
   YjEr2znfE3XaHWp1t8ajJ+fQ2EQ1U/uWPhKRrM8F/Gx4QPtNLlqkrJF3b
   DX2wrVESKGxSo1phUSzeOlIehlS+RUczn0/5lWU+fWg6udcExEhQZ7V59
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="339009389"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="339009389"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 17:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="945068462"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="945068462"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 08 May 2023 17:55:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 17:55:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 17:55:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 17:55:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZSIw6c6TN0bF8klJhZgZ9dLKd8a7PtwgjLMTnEHQmXMslOkvh2jVE2jPwwJfwhgN9KF/yx+SK6PS72ag3kqamQGnkP9M7Jnn9ULLUo3KPIvMqm+xvBfouK7ftQArx2Guw2pzKE9kkUwSMnctlqGY1C4HNTWh6IaDx9ld34weO4eK2I3FL5a4k+HddWH0hMqZW3SGADU+WBIAZsD9DOHvTMN2LNSS7zBsTBn7fluI/0acU/77IHlk1qdHoHxZN7WDZld3SKlgaFFBT8z/+D3efxWcOjiGS9qjASv0t+l5io3ro9sZcEWx12IdLrufVUPEoZALCWX0BmDhRGWwC192g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhFlOPrDb4YMNTM3BtGKZ3+abpuLUbF8kJYEC2Dmjks=;
 b=ke770zElE3OZ/9JlLKdqEUJvFZnUxgNjTygMWj8LjtU+jPqyqjwNhOpAq9ccW5hL6qZg63uG1xHq2e4AReYQDOn/YWjEtgWcV5aQACzfASWhIFWvrMS6gAV72kIP+rmzMcSUn1XIL+5eo5xquTnQwabvhOfNF195/Ufqu9Ovr1tRmyx+rsTkmwdtENGQRqrSDMhFsl4tMva2TmOBTfvDQvz2JmiJ5x16i4lYAUOFUK8xQDveUsi8cPteDvWMCkqnyL3/0ay4tsvJQec2ZNXfKsLTw0FEnbhwb5zsuVU+OettPh7/+uRvLzHR/bpjYlEKX2SZQzUFTacQMF9kZImToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BL3PR11MB6410.namprd11.prod.outlook.com (2603:10b6:208:3b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 00:55:32 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77%5]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:55:32 +0000
Message-ID: <08da7a0a-6b66-2c0e-eb56-96b5ee8faa30@intel.com>
Date:   Mon, 8 May 2023 17:55:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 10/12] crypto: x86/aes - Prepare for a new AES
 implementation
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dm-devel@redhat.com>, <gmazyland@gmail.com>, <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <mingo@kernel.org>, <x86@kernel.org>,
        <herbert@gondor.apana.org.au>, <ardb@kernel.org>,
        <dan.j.williams@intel.com>, <bernie.keany@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <lalithambika.krishnakumar@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-11-chang.seok.bae@intel.com>
 <ZFWQ4sZEVu/LHq+Q@gmail.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <ZFWQ4sZEVu/LHq+Q@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0058.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::35) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|BL3PR11MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed1f339-dcc6-485f-bfcf-08db5028173b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAN0CyfLiivzUeVGvmNY5q+golORL20Mx96G2hLS+u6ZgMIjhibr5D/B/NBp5MA/OLbXKNIEEPZIWsoymPu8/tvar51KxVwODHisWYLJrNn1uHkGuk0RkCJbG5srrTUKMppu1XaVqG6nkWVlUhmdR+Gq/HvJ1zp2i2yck5iDBcKKOxlD9wSmNTyWm83c2K/MWYKYDBhwuTVWspM7L3/6Tq00RK4Df3RRzFeJoc+SLhFt9AAI5/mJRpRm0TxlE2uRRJxDSENP7wuUi08Lq5K637VNctA9NEOIbkX+9dvKEwqp40mVRVVgNu6Fn+GTLP9Go+gLNNEEv5E9Srn0z5E45UK2J12cJcmG+Puda8QHC7FDFsvxFfSUq5OtJ3HT53b8QU5nZaAAXVdYTOY5rcw5vr1rednftfgTJ6+JxlWtax66iDkxZziafh3bjRkgurM3Ts4V6jp5aebIlZWNvzgUDLNKmoME8YITamZrDo2Pctxbqihk/gXXFxNzapzdsPl0A4D3pXuyTNEDCS6/NjiRLVeaWXEMmDomms1jL65l/UvD4GEdePYB50N19iwPnN/Tcz3822PoGj8vv9obtNUEORbD2imTXporRMceYQ2OEqKgpM+QqEFgKNDH60n7XpSmqOt13D05fVk25xHbqRyTRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199021)(6486002)(6666004)(478600001)(83380400001)(2616005)(26005)(6506007)(6512007)(186003)(53546011)(36756003)(38100700002)(82960400001)(86362001)(31696002)(966005)(66946007)(5660300002)(66556008)(66476007)(7416002)(316002)(8676002)(31686004)(8936002)(41300700001)(6916009)(4326008)(54906003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzBWNmRkeWxZOTRJMlp2NG1Nd3N4RzhzRTA0ajZkU3hZYXFzUFFmcS9GQzlV?=
 =?utf-8?B?Z2xGMWpFQ0FPRHlaekFUVzRYNU9USjBLbnpqYWNRVHBDUlpLRi9iR0lBQWMy?=
 =?utf-8?B?S25GQlNHMWdTdTQ0TGJPdE00dzlIOE5NTVNCM0tERUJyajBZOGhiTElTVERM?=
 =?utf-8?B?OUZ6dy9DZmlzOEFTcWRrdjVOdGtIRENZRCs4UE10MW1Ta0lvRC9YOGpCSTc3?=
 =?utf-8?B?c1h0eTJHZDgxa040RWRkTFNIb2ZhazI1QzNUbFNob1NOeUxJM2ZlY2xtNnYr?=
 =?utf-8?B?TERYQmNTbHphOEgzcXVROUZmVU5xb3FpOTJBK1ZOb0o1cWczbnZwZ3FLdkZX?=
 =?utf-8?B?T24rZm11UW9YQmVWL0wrcjhyOGYxbXZGL3ZrbDJaR1o2LysrMFY5Qis1cWlp?=
 =?utf-8?B?ZWwycG5QaWM1MnpHd0FPYnoxUmVaQ2hQV29wNEJsRjlnQ0RmV05GUm1Na3ZS?=
 =?utf-8?B?b1hCWER0QllhemtVM085aWVCTEExQWlOT0RrV2o2MDZHQ0pxeHhhVGVHM29W?=
 =?utf-8?B?Q0h1VG1vOXZJd2g4YlhCa2FiSmI4Q3NMMnJ2TGdlQThxNUk0TGpNanZMcUVT?=
 =?utf-8?B?akRqTVBod2tOS3lFdGZaTUUyRkZ4c3hUWGxEcStPcWxtcm9UUXd0eVk0L0Jp?=
 =?utf-8?B?NjBkblZVT29EN2grYUVmVnZkK2F4MmdQUUQvMnpWRU5Oci9mdkp0elRmUHIz?=
 =?utf-8?B?VlZYZ2J5Qm5JWWJIckRtY0FySEE0Zm5zLzFmbU1HYzZ3MGxwakdDYnBTTHI2?=
 =?utf-8?B?aDBxMERSWm1yV0I0TGJnNGF2RWRGNS9YKzhIRmRzdU9SeWlaQ0wzeW85TWM4?=
 =?utf-8?B?cElHS1laR2tUWkpPVTBZSXEzWnRmMUlHOVFneVNUVm5vNTk3VitmYkJnM0xr?=
 =?utf-8?B?UXNsaVhBWWcxT0JDU3AzZGpSRTJNNnpobVdiS3lGaG91L09lOVp3MHIvRGJV?=
 =?utf-8?B?dzVlMWwyN002QnZlL3I3bC9lSjU0RExZYlFZcUJSVUl3K0pWZVdRbmZvdCtt?=
 =?utf-8?B?TkMyd0Q5L0V1VS9tV1JDeG03K05EVktXYWtPWnlnRE1IVGIvSGtjdzNHKzNH?=
 =?utf-8?B?ZHJnOU9aNW9VVGdqSXZuN05FY1RxanMySndEb1hNTFBmUnBOQ1NQeUVJelVs?=
 =?utf-8?B?cWp1d09JM1I1VURHYkhHVFpjd3VaWEpsUEtHNHV5ZlAwdW00eU1ITWQzOHMz?=
 =?utf-8?B?cjFkRnN3dHpBQVBIaFg4RWloNG5tRlRNWUVnczRrMUtsckZNdnJzc0FqcjRu?=
 =?utf-8?B?bjB4NlltVyt3aG11VkdSOVlQV2x4eGJjMzhGSU4rbmNuNm1lclo1SlQ3ZGty?=
 =?utf-8?B?ak96Vis1dFdqcmVvU3AwbUNUSUE0MWc1d2l5OEZZeHFqRFV4a3MzYnM1ZmlH?=
 =?utf-8?B?QWFHOTJiSGtIL0JkUGlUS2tFeERSdlJoSnBkSE9PeWhvNy9MbjhnS3lOaFdl?=
 =?utf-8?B?YXF6SU01aERYRnBwVVpmUk8wTExzbXd2OExQR09VUGxrMGtRaFl5VjFmbUJ5?=
 =?utf-8?B?TGVhUWNwYW1KK1EwZXpQY1RsaU9Ub3JGdWFwc3lhalZyUkIzSzFUSmIrdGFS?=
 =?utf-8?B?c2txcDZwNTlwSmt2YUtoU3VjMEtSeXlUNHpsMVBhZk5UblJpdHNGNGRrdnNr?=
 =?utf-8?B?QmZuYWkvNVBSL1RldEV5cXkzdjY5Yk1XMG5oN3dRdFNycmxmbDc1YUFBK2tk?=
 =?utf-8?B?dlFGQXJVTjVQM240K01sbktUUXhpVnAyTTFBejZYSEZaWmRNUXIrYnY0ZnV2?=
 =?utf-8?B?bkpnQlNsM1QxQ3g5T01NMEVTbjROL0gzOEhsYXE2N2N5Vm9wL1FxeUVmQWVv?=
 =?utf-8?B?ajVEWG9udWt2aVpVTUJhZW91d3RIaHhlay85WkwwL21OUlZudFZ4UXdveU16?=
 =?utf-8?B?VHpHTDErMWIySUR5cDVGOWw2aWRIMVpvMzhCZXhMZ1hFbGRHMmlCTUNyMUJL?=
 =?utf-8?B?bVA5ZGI3MlA2ZE54WllkbHNuNkJtR1EyZjQ0RkFLdFZpbThxYjhCaURFclFK?=
 =?utf-8?B?TUpPT2NldnhiT0krcXorNjU5TUJXcFBGU3FOVld1V0cwVzdDVjczVEpuN1J5?=
 =?utf-8?B?WDl2MHVDUTB4ZHEzWkl5UVN3dkVrL1pscGJheWJqVjBSdVJBMWw2bGZibHJm?=
 =?utf-8?B?ZXJmN1ZFYXpuT1QramJrb2JGWUgyc0p4cFV4aFlDNFdaOHRpSmFjZnRrMU9r?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed1f339-dcc6-485f-bfcf-08db5028173b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 00:55:32.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsMRBLTMDhoRRTXbpi+2CeKoWMtRNj34kAhZvOwVcI+uqfOWd5YfzUl8XgRXU9/igEBCOXpCg9hnas5pgpuo6gsjlY9m25YFMTQ6NXA2Nao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6410
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/2023 4:27 PM, Eric Biggers wrote:
> On Mon, Apr 10, 2023 at 03:59:34PM -0700, Chang S. Bae wrote:
>> Refactor the common C code to avoid code duplication. The AES-NI code uses
>> it with a function pointer argument to call back the AES-NI assembly code.
>> So will the AES-KL code.
> 
> Actually, the AES-NI XTS glue code currently makes direct calls to the assembly
> code.  This patch changes it to make indirect calls.  Indirect calls are very
> expensive these days, partly due to all the speculative execution mitigations.
> So this patch likely causes a performance regression.  How about making
> xts_crypt_common() and xts_setkey_common() be inline functions?

I guess this series is relevant:
   https://lore.kernel.org/lkml/20201222160629.22268-1-ardb@kernel.org/#t

Yeah, inlining those looks to be just a cut-and-paste work. Then I was 
curious about the performance impact.

So I picked one of my old machines. Then, I was able to quickly run 
through with these cases:

$ cryptsetup benchmark -c aes-xts -s 256

# Tests are approximate using memory only (no storage IO).
# Algorithm |       Key |      Encryption |      Decryption

Upstream (6.4-rc1)
     aes-xts        256b      3949.3 MiB/s      4014.2 MiB/s
     aes-xts        256b      4016.1 MiB/s      4011.6 MiB/s
     aes-xts        256b      4026.2 MiB/s      4018.4 MiB/s
     aes-xts        256b      4009.2 MiB/s      4006.9 MiB/s
     aes-xts        256b      4025.0 MiB/s      4016.4 MiB/s

Upstream + V6
     aes-xts        256b      3876.1 MiB/s      3963.6 MiB/s
     aes-xts        256b      3926.3 MiB/s      3984.2 MiB/s
     aes-xts        256b      3940.8 MiB/s      3961.2 MiB/s
     aes-xts        256b      3929.7 MiB/s      3984.7 MiB/s
     aes-xts        256b      3892.5 MiB/s      3942.5 MiB/s

Upstream + V6 + {inlined helpers}
     aes-xts        256b      3996.9 MiB/s      4085.4 MiB/s
     aes-xts        256b      4087.6 MiB/s      4104.9 MiB/s
     aes-xts        256b      4117.9 MiB/s      4130.2 MiB/s
     aes-xts        256b      4098.4 MiB/s      4120.6 MiB/s
     aes-xts        256b      4095.5 MiB/s      4111.5 MiB/s

Okay, I'm a bit more convinced with this inlining. Will try to comment 
this along with the change.

> Another issue with having the above be exported symbols is that their names are
> too generic, so they could easily collide with another symbols in the kernel.
> To be exported symbols, they would need something x86-specific in their names.

I think that's another good point though, they don't need to be exported 
once moved into the header so that inlined.

>>   arch/x86/crypto/Makefile           |   2 +-
>>   arch/x86/crypto/aes-intel_asm.S    |  26 ++++
>>   arch/x86/crypto/aes-intel_glue.c   | 127 ++++++++++++++++
>>   arch/x86/crypto/aes-intel_glue.h   |  44 ++++++
>>   arch/x86/crypto/aesni-intel_asm.S  |  58 +++----
>>   arch/x86/crypto/aesni-intel_glue.c | 235 +++++++++--------------------
>>   arch/x86/crypto/aesni-intel_glue.h |  17 +++
> 
> It's confusing having aes-intel, aesni-intel, *and* aeskl-intel.  Maybe call the
> first one "aes-helpers" or "aes-common" instead?

Yeah, I can see a few files named with helper. So, maybe 
s/aes-intel/aes-helpers/.

>> +struct aes_xts_ctx {
>> +	u8 raw_tweak_ctx[sizeof(struct crypto_aes_ctx)] AES_ALIGN_ATTR;
>> +	u8 raw_crypt_ctx[sizeof(struct crypto_aes_ctx)] AES_ALIGN_ATTR;
>> +}; >
> This struct does not make sense.  It should look like:
> 
>      struct aes_xts_ctx {
>              struct crypto_aes_ctx tweak_ctx AES_ALIGN_ATTR;
>              struct crypto_aes_ctx crypt_ctx AES_ALIGN_ATTR;
>      };
> 
> The runtime alignment to a 16-byte boundary should happen when translating the
> raw crypto_skcipher_ctx() into the pointer to the aes_xts_ctx.  It should not
> happen when accessing each individual field in the aes_xts_ctx.

Oh, ugly. This came from mindless copy & paste here. I guess the fix 
could be a standalone patch. Or, it can be fixed along with this mess.

>>   /*
>> - * int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
>> - *                   unsigned int key_len)
>> + * int _aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
>> + *                    unsigned int key_len)
>>    */
> 
> It's conventional to use two leading underscores, not one.

Yes, will fix.

Thanks,
Chang
