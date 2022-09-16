Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A425BB08A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiIPPwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIPPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:52:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BA0AF49A;
        Fri, 16 Sep 2022 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343570; x=1694879570;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qIR2sXmikXF+aoFAhk9KRQmDQ34nUaly/euONF3ldTY=;
  b=FBbsXnv3OKQ+kRAi1gwowfsIzPIrFMKCo2gUVA46ghZmQ3AFpXW7FDSH
   RgULndLaIVQDFiosVABm27+HCuba6DObSQvfG8ihn+MpxtrOS+U3iKsdo
   2hAKL0w5qfamV5iRC4wJVY9XoAa0H/ZLijIjSVm/7xrI2J/ey7OIMv1vA
   mvQ5j2YQ1WGmw6hTWtXPegfoOUuFRRST2t+7siBFbp46SinQUUT5pgZN5
   1FptzheFeguKype5oRGlNLj8HwuIqEX8wtEOfOjt+9Jmc7/yFqHBWYfDJ
   id9FfCtJpMJrGD9Pf2F1GqTf38xPC+dg5mmN5e8brDniyez90uSK+mqEg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="296606936"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="296606936"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="721465375"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 16 Sep 2022 08:52:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:52:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 08:52:49 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 08:52:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSp+DLjUEB2ATIr3JVBkXYoHwC4kW6J7toPm9g31/K2ZHZAhM4xuMtZjeI7kFLNXGB1pL5PD9SZ4zQS75L9Po9k1aBYASyZn82/uOuH/q2ayU28Hs7+5S4EPYE2LURWXZSvPXU3FTWlI32TeLG5TkuTbSiTXLbYh47xSE9qyUJCI76I4IxpYReFpme02qKkJcIXaKeIm79s4ngPdacn9vw8p3cy5UmAJBfCOHkR2oFjpQmy74GjsEh+MD3k2pEQqg/OsbzWWwO95J3AivFfhmaO9qZzyjrjQvB4AeOulqQeK7fWjZIVI1xj4EQE/cQ5YYqU3qBA6BkqsMz3NaFOfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObSB7HXlHzyfPjdGuzrq2inm/IWe9S4PBmtW84mYMZc=;
 b=R3nhKOZmYEwojXjl6slosAvw6byP2CpisIxnGmEiEvRLkrmyHvQjjbt6ex1C+nz0p94PwKRIfXVM6tk0IT8TVyKqsYGggQAOFHXNsQ0XnOoSP3mgz9FhO7SMmMt9YUaHfyLYw5sqcgaUt8SwBwz8K5fZfHlyLuKREeTEVMP0RQ9XP6VOQE+QDtf1+RF8OMj1ahBD0y/tvZ79cS65jadaffnkHBCRiu1zzJYgCkUP/bIDTowG2KbOCUFE20FPz7ZkcxfDofOet1oJ+UMnWK21X6qawXDS+N/wYWyYMvzQrGqb3wfHdF4cnawLDURskD8SCl/nutHa46vA1kOE9FvdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 15:52:42 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 15:52:42 +0000
Message-ID: <84da1039-20e0-e0fa-84d2-e718e746fed8@intel.com>
Date:   Fri, 16 Sep 2022 08:52:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 01/13] x86/resctrl: Fix min_cbm_bits for AMD
Content-Language: en-US
To:     <babu.moger@amd.com>, James Morse <james.morse@arm.com>,
        <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257359679.1043018.9253512972611409799.stgit@bmoger-ubuntu>
 <a60be378-dce6-08fb-02b8-1efc660ee3cb@arm.com>
 <b3b25255-c5de-f358-33df-1dc53939a5c7@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b3b25255-c5de-f358-33df-1dc53939a5c7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a24dded-ff10-45c0-b12a-08da97fb7d63
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRU0o5lHdmHal6Vi08pSx5CEsk/PXyhmJCC5mBmOyCsZfAeno+thw3RNkjeHe4aSpULi6d/fb223Tq+/LvZdMNBfJosNCMDJyeFcoMiihab1X+Z1Mv9bHpfQGt3Qea0WyT0HJOKbRIoHUTcBELBLmzWN0kZ3OPtG+YZIJp/tQ5M94Y9NPkbxu0iKmX4OV8e/lX541c939iKhrz4tq4WGJBwy/S8qCWfKFyGBpgzg2azMVruFK7YXXLIlQPuiAAbvO3eG9DXUwK61GkJo+c0EBjz/dAgIqWIGrutGzARFpTCelEWAJUc6peIHJTWdW3TbgZSgp1fQOcEow6DBHSQ6WR8n+q4d6oetoQXT9uKG8T7UBpg+r0FT4tfObgdoB2V/+3B0QNddzK6hf/42L1Z4/2JZba6UR+d6zPY7K2LYUyeZoodGlEphQ8XJl2W8GVieRpbScADudCt96qiF1Q04cmOE4wjeHO1NOeYs4YMcMyhLFxl5SAhNgoB5ZbxZoCNmUir+jUxicvD/f37i473UJBTFGM76I0pcvLXY6VgjK6zY1SqIfxXdLFoiMCc1dwAitJdmba1Diuz6zrUmE+44K6pLRlTwsZI5d4vBy02g0K6wLPOQy4lZq6EY9kmJ9sf3uZZxPTNpF1sCd+UppcgkeqrXcS5VMAMeSacND2MfkXyQQzQoGOR7ufkavDTxnNZIEuWyb4QLWQ/4nBDs+LfricyzWnDeM5JDMCUU/pXJa/NPeXSUgPG1qxIyj/C4tLHndnaxm+Xcf8/Qxotpo1r3z/Kfvw6QvS8i5mHXm6BjT+y5RTJk6Lfr1VXpaXLRH2Gz188hhwkdBynIqEKq5PFKm3la/2i1SFcOEYhVbKB2i0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(31686004)(2906002)(44832011)(36756003)(82960400001)(38100700002)(7416002)(8676002)(5660300002)(8936002)(316002)(66476007)(4326008)(66946007)(31696002)(86362001)(186003)(26005)(478600001)(2616005)(66556008)(6512007)(6666004)(966005)(6486002)(6506007)(41300700001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUdocUg4Zk9vZ0p2b1owZTArek1IT1V2SVVTdE1sQWlydVV6NkZiMmNVNjRi?=
 =?utf-8?B?ZEZlcDU3MnRvWDBZQjZ3VEYzQXZjMmxiMHloMFQ3MFA1WUVkbWZ0RmZJU1py?=
 =?utf-8?B?STE2K1BLdDFucnQwMUpLR1ROOENQNFRoUjRUZkxVZi9jeE96aW9UY2Z2aDh2?=
 =?utf-8?B?cnB1eWloOU9TREJQd1FUMEpLT01sY3RKYVRPQUw0UXFMUjZkTnZmTjdkenFh?=
 =?utf-8?B?Z0Z2WWh2QTc2MSsycVpEeFBjUisyeWRXZVFiRXhvanc2MzRKclZoeVhzT2tN?=
 =?utf-8?B?UVJpbVRLa0F6V0hUSGhLd0FmelVCcFRPc2dESlZvd1ZzYmZwV2RMT2RzUGFO?=
 =?utf-8?B?YUp0UDJhWGhpZDVld0NXZFNHSDhXT1F1aGRkOUFsM053UXhyalpHK044MHFF?=
 =?utf-8?B?VUNPU2RJTnVTajc5Q0xUbU16eVhNeEpxMDB5RUg4cUEyUHpTTVpFemNNSk80?=
 =?utf-8?B?bElaeFIyam5iRHd1K21ERHNyS1pxdmJtem1ZT01mMDNlalY0eWc2cTl3VkQ2?=
 =?utf-8?B?dUthWGsvdU5CdkNBOFZERzRJcTJRZnRWTzZRaXRqZEZrbWRMMmxRVkRhL01k?=
 =?utf-8?B?S2VPd0VvSER3Q2RTelp5dmVxbFlWMkxLTmw0cnFyT05yWmhWejZlcERzTVZt?=
 =?utf-8?B?OHhDSlZyaXNheThJdWd6OTdXUWVRK0xhM0tVK0dqK1FkUEFmNmt0YWNUQk9D?=
 =?utf-8?B?T3hVMkRHRllDcnl4eUFjL01UME5McWJndFluTXBpcEFPY3BsK2tUMm9sNHNw?=
 =?utf-8?B?T29kSUR6TlNhRXRnQ1dBRzV3ckpFd3FpdEhnem55WlA2U0tyNDh2MlhraEVw?=
 =?utf-8?B?ZkdnOS9JNG9DYTJFUENzVnUvaXNjWTE3b3hMV2xPcjlIMUNyeGM3S0RvU0ky?=
 =?utf-8?B?bHlxUGx5WmhhYmpFRGdOVk9xMFhoTnpZMlJKRkYrTWpibjk5d1F5RFBXdWcv?=
 =?utf-8?B?RjYwM3B5cFNhRENXUElmbERQYURsY1RVc25XSi82dGgyUHl6SS9WTGY0c1dn?=
 =?utf-8?B?QXZ4ZzUzWU9oc2hwSEZTRUsrTlUyUkpSajU3ZkxuZWVIQlR6Wm9CRTNtQ3h2?=
 =?utf-8?B?VysrNzAwSjNSYi9vZHlmeXFWVFZ0Y3E2UHZ4bytWV0lTZHBsY0tpZWNRYTVU?=
 =?utf-8?B?UUdBeWlIN3E3N2IvYnVuZXdVT0lhZGNHUGVEK3FIaktKTHpRUWpvdTRpdm1l?=
 =?utf-8?B?YkkySUZxcUhOZW16TSs2ZkJYbWZwWjR0NXVaUE5saE5FakpHK0ZaZE50WmI3?=
 =?utf-8?B?NHhNcnQzNzRmSlJ6c0RTRlliMnllOGZwall3eUpBQTJwSmhBaGFja3VZa01X?=
 =?utf-8?B?c0VQSHFwMEtIMTJwb2xCa2s4TXlONzZUZ0NhcE9QeXFaUmVkK3pUSytKMlZ0?=
 =?utf-8?B?ODRQOGJobVZSaDZZNm1GWEZ2NHgwNUJSUDFTZExnbWt4QWNDbnNDQXZPenhl?=
 =?utf-8?B?M0xUdS8vT2hkZVpVM1RWaW5HUGxtakErMUZBZEpjdTA0Y0ROdnRIaHEwbVVO?=
 =?utf-8?B?YnBUc0g3S0orWDRGNC9BNDVBNnJiY0ZnbUcwL1ppTElIVmc3MVpnVVBiTk9L?=
 =?utf-8?B?Z1hWbXpWdTJTUkpZNzU3MHlCdDhSY3l1dHppR2xzK3FlbmNnc0ExUFdLMlM5?=
 =?utf-8?B?cm1pNmQ4ZkZqdUZFc2tHbGxsUHpJQmJmd2Y1Tk9rOGdTakw1TkswcEExSWNT?=
 =?utf-8?B?azdjcjI2WVFwYmh4bE91aGxQbTRLeXFlbjJoSXR4KzBySDFoeFMrb0N4WW5E?=
 =?utf-8?B?RDdURmRoOUxNejlIYkRrRG5qWlRqWW5DdUtXK2ptUHZkblEzeG03OHlwQU92?=
 =?utf-8?B?MzNIODU1SnMxeDBCdmdjL2hFV0xiSW9SWkFBa1pMM0tpTkRqaTB1ejhramVO?=
 =?utf-8?B?NFdicFpUQ3FUSm5vRDhrTGZhNGhOQitXdFFLRE5MeEZHZnBzVEhIamtsajJx?=
 =?utf-8?B?WjNpd3dLWEF0TGNmZjR2ekNheGJSNXkyd3doTWFmdm9sQ09VV0dpeVFtekgx?=
 =?utf-8?B?cHd1QmhtMDM1K2thdkl4NEdCUjg0bzNLZkdDUm9ZbDFYV0VHTk1PUk45dkwv?=
 =?utf-8?B?NUw2bVRPNzFjVi95ckQvczY3V0RiVEdFdGRBRkh4dUxsZklkdjQ2U1d5QUZn?=
 =?utf-8?B?N05NdS9oeDBtekx6bms1L2VGU2JjTEdNcXF4OStUZEFmYUc5MmI5cmt5ckJM?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a24dded-ff10-45c0-b12a-08da97fb7d63
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:52:42.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5eMYPnw3KWrE5Zamz8waa1FMsR0eFzSgU0ZouhXN+y9tvUPBKfNEyPr7SVkibYrdj+91Aq+F/NhM8+vgxFT/IB65OapEvcE3Ckw9ZI2KZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/12/2022 7:54 AM, Moger, Babu wrote:
> On 9/9/22 12:00, James Morse wrote:
>> On 07/09/2022 18:59, Babu Moger wrote:


>>> Fixes: 316e7f901f5a ("x86/resctrl: Add struct rdt_cache::arch_has_{sparse, empty}_bitmaps")
>>> Signed-off-by: Stephane Eranian <eranian@google.com>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Er, who is the author if this patch? If you are reposting Stephane's patch then there
>> needs to be a 'From: ' at the top of the email so that git preserves the ownership. You
> 
> I can add Stephane's name in "From" if it is right thing to do. But this
> patch was modified from the original version Stephane posted.
> 
> https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.com/

True, but also please consider what Stephane posted originally:
https://lore.kernel.org/lkml/20220516055055.2734840-1-eranian@google.com/

A "Co-developed-by" may help with attribution: 

Co-developed-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>

Reinette
