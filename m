Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8A6FFD34
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbjEKXUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbjEKXUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:20:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305E95B90;
        Thu, 11 May 2023 16:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683847213; x=1715383213;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4DQwW7nMACiUnh3g6nZ5VUXbLKJ7/TF58kJuOILOqVI=;
  b=E13jpQVD4TpZImjuEV8zIxhuj0dIB0v9KvGpezKeDR0verjtQA0WOs0f
   JMrpb+mrytfIYRppFbP/cGffqKGDBRzPsSmWnvU3/kgJhUBmR1kXnMQUf
   s9vviFwjzsMnPis7md00G1eyaxvEonkZsPWkeKpcU01C423cCVfcGhdek
   ikSlifIvi6/DDDeqV0cmP5+b8HokLPiTEKm8buTNsUO1Fy10zFrfjJqBT
   2mNlnxH4uGFlPB7hLsBq16QeNLDSHWv2fC05icGDF3t7zC7y9zV+KtPXv
   1hbtKW5unEiExPjk3T/rXpa/iaMfiY+wlTM+aVKYNDzZP5btsqjZkU6/4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="416278867"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="416278867"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 16:20:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769568653"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="769568653"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2023 16:20:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 16:20:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 16:20:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 16:20:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U31mEBOfy1i6lzS1EBSw+6+e0mN3qowGVxUHYOI+yvfmp4qYaR/v4/5NxOQTDeW9Yl/LXOZOn6uwxwTMoplhJs3Q7gZDtW4EkWtBOAO+gIcmGH24BrKQkOGsES4z+Wu7HLxGcRcJ4hfx4dQr4S2/13mDRSO0g7L1hF7m5Y3oEkROxxB75QLBsjbSjEctVKss1/ppru7/AlxIxElyqy0U5ibcq3/x5QDk/GZuIeyLrrdSRyEVGWbI8z0OD/ZSQg8lty2xuZgr4jKur1AHYoJ7EUJgiImRwd5kcKOjIf1mPv7WozXAtZXNU6SG4Kdmw4m6COy5f2R3dtZy/HPbtfLBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+A8zJhraUY5RN2lePeFO6bVG/aCejZcgGp7MN+JdV9I=;
 b=GZg6Wk7TG2A98Mus5nBUm9Lk8Ag0GP+/CZA411wlkZTYDuvRvutrTUVEs707EwmLyhmux6iSwwxaYuNcTrDS5bP5TwGHXJqmdpnAEVsRvDULvsqqPxr77mhoeQ7Qo447GIDzstXVelh575sufIAViIqBK2PWjEBdxbtDu/OoppqCoC7PpxXF2LI95NAnueUZ1otx2h5hVRjz4NunpBQF6JuGV8t3yXKpBzEcT14QIsYIKA//LdAXYVn5OBZFMsxY6TGTTecZBa/jJXl8+z5g8a++8TlvNDU9mGrxM2glJuyh9kZnvE3H1uZ5hDHNFwZe1AkLdOAs0N9NOyTuEvxwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by SA0PR11MB4733.namprd11.prod.outlook.com (2603:10b6:806:9a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 23:19:44 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77%5]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 23:19:44 +0000
Message-ID: <76fb5763-c765-b3cf-9eec-1ac344cf49a9@intel.com>
Date:   Thu, 11 May 2023 16:19:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 10/12] crypto: x86/aes - Prepare for a new AES
 implementation
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dm-devel@redhat.com>, <gmazyland@gmail.com>, <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <mingo@kernel.org>, <x86@kernel.org>,
        <herbert@gondor.apana.org.au>, <ardb@kernel.org>,
        <dan.j.williams@intel.com>, <bernie.keany@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <lalithambika.krishnakumar@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <08da7a0a-6b66-2c0e-eb56-96b5ee8faa30@intel.com>
 <20230511190517.10149-1-chang.seok.bae@intel.com>
 <20230511213948.GA838@quark.localdomain>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20230511213948.GA838@quark.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::15) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|SA0PR11MB4733:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa752b0-72c9-48d8-8a92-08db52763417
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 880stWe/nHrHxoQ0WkHwLcyHi6Qqj2g+fvl/XDBREvbbqNEti70lwPtlUSrkmfvK7wsD0VB40STOFIHg6QMD8E+Ywmfvw5nCE1ukYECb6ntSt6Ui+m7sOZUndoWrc922pb0ThORLI9ZsoVCbW6N0SBHC7iYA28FUz2gmBgvPPkYwpPv7hCwAICL7wak292erKQCnUdc7/AX2Y7H97n0tS0sNTrM/vsJG9XDsf/NI1z8v2wyql8V3yyJ1FxJmEBjiV2Gld5SUFB0vaWePlhumTeApdAMZyHDZqETRDMU3ctfyDqrQdF0mEZldxxIlsxf/2YanyRQW3zkL3nvgfCz5YDBjgvwv/NYNzkASmeNKRwkSp7GiVlGKUe8QpQs0hMGZMDBgUI7z9FGQXKs+QgWVJgYZeVGWHsu0RNNVNhMUaKL/wqf/CATCiOz5LAalNE2uU2pDUFW8z3/dpROmo6J17Gy53EUCM2EiUlo6XdH5EiVeqA5H/DgG25fVSXhtWSfCYn4GVRoxFtTafB4vnMEY9b2t2PUzK4Q66tvPSgcqY5idIJ+PO0ccaVMA/U7pcjEbyIhL2caY6Ttlu6BP+G1gx8OMpGnPjO1W2xAd46BBgVlbErCeX/Hi+u0bbdcn7XwLv5HVEPrfC/ntUBh6t/0xCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(31686004)(66899021)(83380400001)(2616005)(4326008)(82960400001)(41300700001)(38100700002)(6916009)(8676002)(316002)(8936002)(6506007)(36756003)(5660300002)(26005)(6512007)(478600001)(86362001)(66946007)(66476007)(66556008)(186003)(31696002)(2906002)(7416002)(54906003)(53546011)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QS9aQlNjdjFuUHFjb0dYSU1OV1dxaFBCeHBOYTdldjdGUjNUQ0dXSDVvUE5K?=
 =?utf-8?B?WVBGYUpQUzlienVSeTYyYkJhZzcwTzJML2lYSG1keVNNaTd4eitGeGsyWHll?=
 =?utf-8?B?YzFkRDdIRlRTWm8xZmxiaGhhbnY0a0J4OCs4VVJ5clpEamhWdHJQNitzVG82?=
 =?utf-8?B?Ymhtc1hLdGlvTGx6dG9PbnNTbWEwdGdrbFBia1BGSE55dHZYZW5xOTJST2xB?=
 =?utf-8?B?azNHL0YvMmF0VFIyQXcwWVQ1Ukp2WkQ3ckNrZERLbG9paXU4QXBoblZMWXFw?=
 =?utf-8?B?Vy9jQUVudkltOXhuZDZkQjdHU1RscGdBczU3MXVjbU04OE4zVU1Hb3Y1UWVK?=
 =?utf-8?B?MDJVM2tkYXRhU1BidEQ1TzIvZXd0RDMyVnRPZXlIUndpdFRxbnZNd3VjQkFO?=
 =?utf-8?B?d3E5b0FyNmlCRzVRT2JWUlRZZEVaTFlubmFrSlRTK1JuRllwRTh4Tm5jVGRv?=
 =?utf-8?B?T25LS1RPaEx4QlZDUmZmdkVjdk02d1Awcld3czhWUVdYUlZYMmNUY3dnWkRS?=
 =?utf-8?B?UkpFK2p5c3NFNnRYSWl4dXZVWGgxZkNOVjg4a2J4RlBsWm1WeGQxbnRGTU1t?=
 =?utf-8?B?eUVWNUtzU1MvazZ4d1B3blI2NGN3Z2NxczFPak9mck9TeUc4SHFVTy83cXlt?=
 =?utf-8?B?ZTE4L2V4aU5PRk9GUUk3bGM5dDY3c2w4bEg0VXZ4VU1yK1lmbk1lM1JFTnZK?=
 =?utf-8?B?VzRJenJMQVJHempxaXg0VHo5K1lzV2VQQmtUV1IyWmpFN2pCMUpqWWVTU21x?=
 =?utf-8?B?MnNmODVkWEtsTmxBcG04SWd5c0l5SjN2bWF6WkI2NXdaam0vbXNROE5CVG91?=
 =?utf-8?B?ZEM2RFNGSWhuRTZKYWNRS3IxK2tXdXRMNjZld0ZnVHdlS0RyTUFYTnRzUVBQ?=
 =?utf-8?B?TjBTOElQWENrUmNuMDc0UzU1OEwyNHM0MmxFdEdmbWtwMkJ4dzhDQUJicFl2?=
 =?utf-8?B?OHlNcm41d1RtSVNPckU5R0RuQ0JVak82bHRjNUpNUHhhZmZkNnRJU3Bhd3ZD?=
 =?utf-8?B?ZGhOT0hCcDAzd0REMkNDOVR1dzZ6OXlqemxkU3VqWmxRWkdHb1FyekMwMTdp?=
 =?utf-8?B?VHdhcnQxZ2liMWJPWWdxMmF4bDBxMnFMKzZveHQrNG0yUldzWHgrOU5zOTJK?=
 =?utf-8?B?S1BWK2h3UVQ5bnp0aHA5TjRwVDNNWmRWVW5wOW92VjlFa201QUdqVEVaeG53?=
 =?utf-8?B?VS9mWmF1YzRHK2FLWVNycFZkbGhKNW1aUjVyY3d4VTZYZ3JYeWNUSmkzcE5L?=
 =?utf-8?B?NWZHeS9WQnJHWjZBV2RwM2NYM051K2FSNmN3aEpuYWszQmRqZkQrRzM5TC8w?=
 =?utf-8?B?MG9Ndm9PWEdTTTRzQzMwNmdJbVp5eXl6RGNMSC9vQkM2ZTcvSjVydjU5aW5x?=
 =?utf-8?B?SysvdVgveXN3R0t3djk1RkdvN0hPY2dsak1BSTR1WkREL3d4eFh1Z3dObklV?=
 =?utf-8?B?S0FFZ0FyNHlDY3VITjNZOXF2SlBoWmZLekc1cjIybW54QXhvSkhpVW1FTUpP?=
 =?utf-8?B?VFUrTS96NlMvOWYrNXRWU0pxc3Q1c1ZMVzZOcnlnc3BsYzJoVUUxTTIxOU9m?=
 =?utf-8?B?U1J1ZmV3QXQ1d2lJUVpxTVl4U2tweDFyZWh0MHFWQ3dubUNKZnkwMjMraXRN?=
 =?utf-8?B?YTJyVGpFZWNranF5WGdVSVFHQjluTUFYZTZ0cGRLNjJUcXREYXFoS3A2Ukww?=
 =?utf-8?B?UmFOVUxiVS9ydjFjVkplT2JEVEtFNzJvWTJCbWF3TTZqQ2NmVVd3bHR1dlNU?=
 =?utf-8?B?WjR0eVRjTWJZV3ZMSElZYkFNM1Mrd0pwZmN5SE5zZDVZNW5FOEU0S0UyYkpv?=
 =?utf-8?B?UkZiLzdrSFBVSzg0WVNPTithM29NaS9RZFNrdi9QaDdONXlhVzhzSGlWaXZV?=
 =?utf-8?B?MDc0OVFoenZxa0s1WlpuT29nV09VeTZ4ZUFkODVTRXIxSm5FK1dYMTdrQUdu?=
 =?utf-8?B?UGswQUFMc014SDJWU2xtbEJnRmw4YmFOcWpjQndybkVtK0tKc2Z5NnM5N0k1?=
 =?utf-8?B?TkVLbVB4MnJSMEtrakV0UUlVU1N4T0RFRlBSemsvR093YnROL2xna1ljbDZJ?=
 =?utf-8?B?ZjgwUTMxb2FmaUEyWjB1a1l0NkhVM1NZajJHNWtjMG1Ua0tEYXI2M3BCUFJr?=
 =?utf-8?B?bjdBQWZJWmYrU0ttYzN5NDlIMUswWHExS01ONGlXVmdGZXQxc0FhZ2laMWRv?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa752b0-72c9-48d8-8a92-08db52763417
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 23:19:43.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slQd/2qIOD06BWRUx2ePTkaPED//lWq3VC8gmCdcUqEla/JGe1eV+13UojHCCPGhKJYuz/I68OZNf7NFg0aDWBbewkfWntWtOut0v2tGhyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4733
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2023 2:39 PM, Eric Biggers wrote:
> On Thu, May 11, 2023 at 12:05:17PM -0700, Chang S. Bae wrote:
>> +
>> +struct aes_xts_ctx {
>> +	struct crypto_aes_ctx tweak_ctx AES_ALIGN_ATTR;
>> +	struct crypto_aes_ctx crypt_ctx AES_ALIGN_ATTR;
>> +};
>> +
>> +static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
>> +{
>> +	unsigned long addr = (unsigned long)raw_ctx;
>> +	unsigned long align = AES_ALIGN;
>> +
>> +	if (align <= crypto_tfm_ctx_alignment())
>> +		align = 1;
>> +
>> +	return (struct crypto_aes_ctx *)ALIGN(addr, align);
>> +}
> 
> It seems you took my suggestion to fix the definition of struct aes_xts_ctx, but
> you didn't make the corresponding change to the runtime alignment code.  

Sigh. This particular change was unintentionally leaked here from my WIP 
code. Yes, I'm aware of your comment:

 > The runtime alignment to a 16-byte boundary should happen when 
translating the
 > raw crypto_skcipher_ctx() into the pointer to the aes_xts_ctx.  It 
should not
 > happen when accessing each individual field in the aes_xts_ctx.

> There should be a helper function aes_xts_ctx() that is used like:
> 
>      struct aes_xts_ctx *ctx = aes_xts_ctx(tfm);
> 
> It would do the runtime alignment.  Then, aes_ctx() should be removed.

Yes, I could think of some changes like the one below. I guess the aeskl 
code can live with it. The aesni glue code still wants aes_cts() as it 
deals with other modes. Then, that can be left there as it is.

diff --git a/arch/x86/crypto/aes-intel_glue.h 
b/arch/x86/crypto/aes-intel_glue.h
index 5877d0988e36..b22de77594fe 100644
--- a/arch/x86/crypto/aes-intel_glue.h
+++ b/arch/x86/crypto/aes-intel_glue.h
@@ -31,15 +31,15 @@ struct aes_xts_ctx {
         struct crypto_aes_ctx crypt_ctx AES_ALIGN_ATTR;
  };

-static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
+static inline struct aes_xts_ctx *aes_xts_ctx(struct crypto_skcipher *tfm)
  {
-       unsigned long addr = (unsigned long)raw_ctx;
+       unsigned long addr = (unsigned long)crypto_skcipher_ctx(tfm);
         unsigned long align = AES_ALIGN;

         if (align <= crypto_tfm_ctx_alignment())
                 align = 1;

-       return (struct crypto_aes_ctx *)ALIGN(addr, align);
+       return (struct aes_xts_ctx *)ALIGN(addr, align);
  }

  static inline int
@@ -47,7 +47,7 @@ xts_setkey_common(struct crypto_skcipher *tfm, const 
u8 *key, unsigned int keyle
                   int (*fn)(struct crypto_tfm *tfm, void *ctx, const u8 
*in_key,
                             unsigned int key_len))
  {
-       struct aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+       struct aes_xts_ctx *ctx = aes_xts_ctx(tfm);
         int err;

         err = xts_verify_key(tfm, key, keylen);
@@ -72,7 +72,7 @@ xts_crypt_common(struct skcipher_request *req,
                  int (*crypt1_fn)(const void *ctx, u8 *out, const u8 *in))
  {
         struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-       struct aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
+       struct aes_xts_ctx *ctx = aes_xts_ctx(tfm);
         int tail = req->cryptlen % AES_BLOCK_SIZE;
         struct skcipher_request subreq;
         struct skcipher_walk walk;
@@ -108,7 +108,7 @@ xts_crypt_common(struct skcipher_request *req,
         kernel_fpu_begin();

         /* calculate first value of T */
-       err = crypt1_fn(aes_ctx(&ctx->tweak_ctx), walk.iv, walk.iv);
+       err = crypt1_fn(&ctx->tweak_ctx, walk.iv, walk.iv);
         if (err) {
                 kernel_fpu_end();
                 return err;
@@ -120,7 +120,7 @@ xts_crypt_common(struct skcipher_request *req,
                 if (nbytes < walk.total)
                         nbytes &= ~(AES_BLOCK_SIZE - 1);

-               err = crypt_fn(aes_ctx(&ctx->crypt_ctx), 
walk.dst.virt.addr, walk.src.virt.addr,
+               err = crypt_fn(&ctx->crypt_ctx, walk.dst.virt.addr, 
walk.src.virt.addr,
                                nbytes, walk.iv);
                 kernel_fpu_end();
                 if (err)
@@ -148,7 +148,7 @@ xts_crypt_common(struct skcipher_request *req,
                         return err;

                 kernel_fpu_begin();
-               err = crypt_fn(aes_ctx(&ctx->crypt_ctx), 
walk.dst.virt.addr, walk.src.virt.addr,
+               err = crypt_fn(&ctx->crypt_ctx, walk.dst.virt.addr, 
walk.src.virt.addr,
                                walk.nbytes, walk.iv);
                 kernel_fpu_end();
                 if (err)

Thanks,
Chang
