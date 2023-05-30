Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2AC716F12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjE3UuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjE3UuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:50:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCE7BE;
        Tue, 30 May 2023 13:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685479808; x=1717015808;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wK5cnbcT1RPMhPsBkXIC6zljCYLaGhKmZjCtCp0vQKc=;
  b=KbRRUMCOhZXV7s0y7ygjTPYPdOnaaqQckqQcAQijQKehyucsCn8BW29A
   t56JCGn0VGCPBgdAzU5XKffqYpRkV+FyAMWa6skezN0T2FoU0fY6YPl5K
   iVttcyimKmBq03uAD+aGZ3NpSQ9cCq2XNl2cjppoEdN49E9Cb136ji2n/
   cFWB1tsBmuKuNNYVeJ5zu1DUX/nF+XQaSRLApi0A7D/B+KDbJhtUbXRRb
   3M9KmwE3NK9N6ReWRoBklMjvhdNAjgU7Dj7pufMlVgq7z+7plN/aAq+pT
   QRtpJru+UkgmAp6SGeOdS1HXFgratMOMYvCGWvLcd6vu6FPWl+dWHYndk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="353886420"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="353886420"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 13:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="796420297"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="796420297"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 30 May 2023 13:50:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 13:50:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 13:50:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 13:50:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+FQBBZSulYd4vjteQc1AuXi9fqcVbDhBM5sjVOexMpAQVac1fx5XhT5x7Z2oAjYtKX3HU+O+C8q+YgcBJ+3CX7NrA7Y3A+M/IWc4a9OJ3P7jM376Fk0tD2+PY4jRKhyrp20jfABZamwxRPXbuAlvII0/69FoZh/5cROB+pwB0YpOPyVdfOm70YM3GrNuoO4uUuYyT1s0kXF5Gz5Afzfs7gR3OqiG8vq3IU0/HQn07f4zPi/jBERM+XLG5lKo6y9HLIVhBkrQnf5vuHqtQjIuf5ZpNy2Kf9yrDU3ajfT1cFphwuFIpL0rZVgm6JWM4bp4Yo/kK3plKYpKsxQ9W/f9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21oTfV3+R4sCgUJMnj3sFXxGOV89TK9q5YrP+QzWsok=;
 b=bPiY+thinTtK1otN5o27FyEl/87dnkDQwXA3wIgNr5hM4AMSdfJUvpB39pgiGnZk6VFn2dK02T89K+P10M/44e1O+/i/x3GFEwuHboYbh9TerJ1cX665114WwmmUfmmVVxuh8TLAOZht92r3L6hWBxw/4RwlsJY5NxenrUssKBvOjiaLWnOYTP8+5M7wyFnau4HwwWHGC4NF7Ta1K0+PB2lUtDIX2Bcxor0mFjMjzSYtm7Wb890YuqyE64ES4tkBe7B+Q+m/eWHkcYHiEmpwv4+a4+HWXcHvreVH/ZdvbOXWWmDhR0cOW7DKqBGddPKUQ09f/sUHcKgEyLGYVHIM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB7168.namprd11.prod.outlook.com (2603:10b6:510:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 20:50:04 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::bad1:92a2:fa0a:1850]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::bad1:92a2:fa0a:1850%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 20:50:04 +0000
Message-ID: <de7e577a-b01f-cf93-7f77-288d2d04b4b1@intel.com>
Date:   Tue, 30 May 2023 13:50:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 10/12] crypto: x86/aesni - Use the proper data type in
 struct aesni_xts_ctx
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dm-devel@redhat.com>, <elliott@hpe.com>, <gmazyland@gmail.com>,
        <luto@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <mingo@kernel.org>,
        <x86@kernel.org>, <herbert@gondor.apana.org.au>, <ardb@kernel.org>,
        <dan.j.williams@intel.com>, <bernie.keany@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <lalithambika.krishnakumar@intel.com>, <nhuck@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230524165717.14062-11-chang.seok.bae@intel.com>
 <20230526065414.GB875@sol.localdomain>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20230526065414.GB875@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::33) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|PH0PR11MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3140f6-e2af-4b1f-f6a4-08db614f7199
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUYpKV4PDi3YCwy2El2xUe5A8jEptizWmyQFARtnqMpsgwLFr2W6TS6U7V3lBJjw9ZMd4Zwy0sJKJW4H6t3yj1CoqzSMlRFZSUuvZo/EDyzKQFeN1aM0h9eKyaJypKjVtsKi4XADQcMsKVhs/PSfmzpFBgQd/QHD4Hi3nKwLcYEuYvYVgLMovVTbriC+SSYVpeqK7YiWrerGwBf16mrZYQVHN/r3JKoFfM+vUQl/zy1qEW93HMVNWvBGEorxqchkSwIE5KNlO8z6wCI9I6WzrxFfgBEZ86a3d7apkf+cuNZ6Ynwu8rmFIxoC2ugACr+EPesqi44MRKtMXGnovHafG/2GzbZ7rSOEEiO21R0FOc4BObpH0FGIhZTZ0uXUwIUS2T5Js7eXtaGAqe78ftITIa2lZBsjC+6xlu2VlWKzH+5oVq5bModRY3FcJdxaYPPmNIQnmRGISdBnaadofyfS73UMz4hkkajMjPcKyJ+M3xwpGEzHlvSnQiE4Ut7zh8V+LXo/KRJ57Um7JMaHKFs0IU2FrIlajOsbyQVOGeXUNYb+P7dc4IIRza8amUgtUPnT5dtd7fs86k+sAGENrkNaRplaefadP6SQV/dBVwMAO2srLXyYW5jGTcv6qQq+UdOIc+e+t+Zwxr4XuH2NR9KmiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(6486002)(41300700001)(86362001)(6916009)(316002)(4326008)(31696002)(4744005)(66556008)(66476007)(66946007)(36756003)(2906002)(186003)(2616005)(6512007)(5660300002)(82960400001)(54906003)(8936002)(6506007)(8676002)(53546011)(31686004)(7416002)(26005)(478600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUF4U2FSQUYwMzBKbzhvZVFTcUVsK3poUkw3WkU4WlpTeWZESjlhazBzLzJy?=
 =?utf-8?B?Q3RFN0ppWjdmVzVPUGFjY2RQRWZrT2hsdVBoRUgzRlVSRFY0YmJqUWp2L1Rw?=
 =?utf-8?B?Tnl0U1U2MmlPTWQ4aHJtdlVTQnp5TmR5MjQ3WG91YzFVUW1xWkVTUGw3Z1lh?=
 =?utf-8?B?MXh5Wm1mMm5EQlpCSFFsblY3MGlMR0c1NFZKS3pkRFNSVE5IZFJvMUxlNW9s?=
 =?utf-8?B?Y1BFek9QejNuMkIyWXNtcHFXUy92MDlDMTZsZ2JwMzNOVVFYeU9sQlBZd25J?=
 =?utf-8?B?Y2I5SFFYT3YwTXhLR2h5VnQvcUg4RzRWenI1MWFEbkdaTlhyNG1JVDl5ZXNy?=
 =?utf-8?B?Vk94WVBsNWZSNEZUamhoUkJreXRHbUxvRUExNkQzNlBDUlRkZEcxcmZkOVQ4?=
 =?utf-8?B?bnY4cks3ZWFqSnBSWFc2ZWMzNDVMa0JoZW5PNzQ4aUswaWVydUdPV00xQ0NU?=
 =?utf-8?B?QjJBblVqaTU5ZGdxak90ZGgwVy9taWdVc21IY1d2UEZCeVBOL01PckFjc0lJ?=
 =?utf-8?B?SkZnQnZZSXBVNCsxenpieTNOMDVUdld5RDNveitvWDNxRFJxYk4xaFZYR1RU?=
 =?utf-8?B?SXFlcnVhU09PcWwyaU9RUEhiNkF1eUZpRUhKV0pGRytiZzR1RW84cSt4ZGN6?=
 =?utf-8?B?Q1QrS0VpVExWZ2ZpRHorN3BGZko3a01td1o1MmhmYUdmdk5jaVExYTA5a2Ft?=
 =?utf-8?B?TlJhalRyVU9wdGswS3ArblQ5bVVvMW85Y0J5R3NaUkxWdkdYSCt4YXExWWdS?=
 =?utf-8?B?WDNNSUJiMnA0a096WENCbkVMTS85RHlnTXBhd0piLzkxTjlQU0NGR2VFMEhj?=
 =?utf-8?B?RVh4RHNYcjJ2VUVucldndk1BWTNFcW9EUjM4TDRiVmlBbFAwN0o3Tm40UDdn?=
 =?utf-8?B?NVN3VnExNE8zWVE5ZVB5UDdNcW1LZmZsNzhmcXBtbk5qZEtPZ3dFcVV6VGpU?=
 =?utf-8?B?QWpTVXdoUDVNdURTRkplRnlVSlNzVDgxa3p4WkhJdjBGYzNvRzdHeUlHZ2xG?=
 =?utf-8?B?dGZ2SzNDQXpqeHl0bFIxeXFpaVp4eWt5RWN6SGR4SG5GblhuVnpuaDM1a1lC?=
 =?utf-8?B?cTZKTmkwa3c1U0VvWk1YTzRscUNMT25naXd4UG5rNjBjNTdqcW9UYlN4NkdW?=
 =?utf-8?B?ZlpvQjhtZUJ1SC83dmVKRitYemN5aEJWbVBFcHdNRXc1SitUWkRta2JpcVlv?=
 =?utf-8?B?QUpHRGtLOEl4WG1xQUJIeGFXdTB5eUxlUExxT3hhR1gwTXhUNHZYK0c0VElD?=
 =?utf-8?B?QjN0Qm9TTTFXQU5oZ0o0QUxnK1JTUGF0TFFRMGFCSzVIdzR0MS9xdStqUDN1?=
 =?utf-8?B?TTRZbkRKNFJFZFh5ZGZQSUdwSm5QcDNsVDBnbERET0tyc0V3T1ZLblgrUFF6?=
 =?utf-8?B?em56c2Y0aTZOOXNqUGRRUU5tSGdsNGplRWJtbmpKR09DRWhPRm9xbnVGbHlH?=
 =?utf-8?B?M2NmbUtOVVRvckFUOEwvZ1JJSUZqLzQzTHBPZUF3cXlXa3FmUGpZYmtudGhL?=
 =?utf-8?B?WDIwQzFTaWF5S2M0bm9EZ2NSMlQ5T1cxeEt2c0JQZzhHNkdxaWszQUJIL09J?=
 =?utf-8?B?d3hGS0RPblFzcnBTSC95STU5UUt0M0ZtWGN2TDZQanh3Nno3NzJwMlkybE0w?=
 =?utf-8?B?TW1hVWVySEFOdlZtVjlQeFVwd0FuaEJGdnY3QU9WRjIyeEhzT0hVS1IrNTZk?=
 =?utf-8?B?UHJ3bWVtZlRWWHpTdTBlQWJqaUowNlNXVXgrb2U0WEc3dVlkeGV0QnNKck1O?=
 =?utf-8?B?ejJwa0RoZEM0akN1dFM1ZXZ6dVIrOUU2cjlwSngwQVNYa3U0TkZTZVlNdXds?=
 =?utf-8?B?VFNZY25mSmdlR2hmY1dwblE4VkNNUzBrY3pMS0tLWCtSUmRieDdENFB4TW1O?=
 =?utf-8?B?cWFTSE5hbk0wRFFHVVBLdlNoTFFFbU1CT3JIOFNMUjNZdUJJeXh5RzU1WmxS?=
 =?utf-8?B?Tjk0VGNNdk5hKzFMWnNGaWxvcUFqL2lleStnc0o5YnF2YmZwbHlTV0FGV3Fz?=
 =?utf-8?B?NnVmYi9pbHdPOUc3MHpid3F6L0RtR21XdHhoZ3VSMVBtZzFFaGgrbjg0ZElT?=
 =?utf-8?B?RlR1cUppU3Awb0p1UytaN2tvN3lic2ZoOE1ldVdVeVRNVFdGeWc1dU10cHpK?=
 =?utf-8?B?N3ZGcDBDbWdhY3ZsMFp0SkNaNzMxOXphcG5aWjdxSmorVC9QdEMzSEtxMXRG?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3140f6-e2af-4b1f-f6a4-08db614f7199
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 20:50:04.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3FrHt79uNMtyimBYsZocgP8KUN1cd583fZP/2FIEb9YOgl55F7M4I5GiYhZAUn8tA3KIhXBTbIPlM5tbRY8efN1GJTvCdMS4YNTm3FkXZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7168
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/2023 11:54 PM, Eric Biggers wrote:
> On Wed, May 24, 2023 at 09:57:15AM -0700, Chang S. Bae wrote:
>> +static inline unsigned long aes_align_addr(unsigned long addr)
>> +{
>> +	return (crypto_tfm_ctx_alignment() >= AESNI_ALIGN) ?
>> +	       ALIGN(addr, 1) : ALIGN(addr, AESNI_ALIGN);
>> +}
> 
> Wouldn't it be simpler to make this take and return 'void *'?  Then the callers
> wouldn't need to cast to/from 'unsigned long'.
> 
> Also, aligning to a 1-byte boundary is a no-op.
> 
> So, please consider the following:
> 
> static inline void *aes_align_addr(void *addr)
> {
> 	if (crypto_tfm_ctx_alignment() >= AES_ALIGN)
> 		return addr;
> 	return PTR_ALIGN(addr, AES_ALIGN);
> }
> 
> Also, aesni_rfc4106_gcm_ctx_get() and generic_gcmaes_ctx_get() should call this
> too, rather than duplicating similar code.

Indeed, your suggestion can improve the overall code there.

Thanks!
Chang

