Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BA6262EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiKKUag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiKKUad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:30:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D46D175B4;
        Fri, 11 Nov 2022 12:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668198632; x=1699734632;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=327FMvj+b1Y/Id/V74KXKYldGY6TNzhAiQaEf9jWHJ0=;
  b=TpjHp2kH99bDjKmPqKmb2edQNFkjtjRJsIx2UhXhxg+5SUgXrddDgkO1
   fruWprC+NowgR25TC+KXu6YQwnzjAWUnb1D0FN8ZZfZHSn4E3KId4nmdd
   CxlT0gBHic7toyF6ER0gc53uBTusRMMVWBugYtayC/eBiOQnxf7WjgTNp
   LEpvDAWBomHDPpfH8unD+oCtNbvlh6BC8/pnX6chj2DYPn168DBWD4Zmi
   9h3fJPemNagCC+Gxo95B44EwDgYOIQ6PKVtqZLNtuHZqfu4zX8MCeV/rk
   TEzvPUOYVAuLVUr+i1aoJfksAtLFqtkIVnuBL0RSm/s8tpsJZ36L4dDL9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="312809629"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="312809629"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 12:30:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="668906567"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="668906567"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2022 12:30:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 12:30:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 11 Nov 2022 12:30:30 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 11 Nov 2022 12:30:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Txp9V9f0g7D3RoEZk7yf31sSEhN4ACYsXi0/ON26JghyvHMPju1NXiONQnINuSRKhb/jZRjIxMCkZNp6OGkTTtahT6Ed2N0nWYG/TmIUBmb6Bdzl41CMZR8eNJA+M7HhTGZIObZKsXeh0Hr5C3p1CU93fRZ4lk9eRm6IhZAIvzlUBUqU5kgzy8c6AdNNYHkYTOqrMIxQjwFkQFyhpugXMsDuL1L0I3W21b0AQ3sMnUGDZeYqZr00tqR/5tj+dRxvs27/wMa5gewPCJOE4XlCLgcRuZms7g8a8dfPsA0MIY62I7d91tAgdUngm8JO6Fg+gKVASNmJmnnTv7U/Jjugxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+esw+asLOunVrqRlHiAn/Tca48UgL7rn7o3pg6YzC8=;
 b=K5Rtra1g+OsWl97FBB3bObP7DCntu4cz16Ou+5BmvWk0e20rSjbUBmrgoRomgAjwaFoPIeRZeyGMOUcSDffa7Zokmjs+JWb5gT46Lfaxq0irQGwtvIeQmg6v/0xTMxtiTnVY5QAXRy/5sGhK9xadCzfppY3Q83ZYGS4cQXvUY3DhxC4DgxpcYWihPkWpjMz0D2NMinCpFATvwen4AYlV+CaQ438ODmPhomc2rGPBLEP0TYjSWv/8G+bByKC/6j/YNKobanaPebUSAmMaR6B5p91oFdo/CjEEO1TmLoHgy+DAN6sJLvJvejJ5gItl/bCi9ksj+LL0t2cEPGG7K1cwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 20:30:29 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::f980:8dbd:ddf0:11c0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 20:30:28 +0000
Message-ID: <f9212b4b-337f-7e14-9aba-2aa738203f37@intel.com>
Date:   Fri, 11 Nov 2022 12:30:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 10/14] platform/x86/intel/ifs: Add metadata validation
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-11-jithu.joseph@intel.com> <Y26W+emSSL5Xik0G@zn.tnic>
 <82d6137f-4183-d994-f8b1-56b4be3d620f@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <82d6137f-4183-d994-f8b1-56b4be3d620f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|SA0PR11MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: bae35377-e2e1-4870-9bbc-08dac4239279
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWlf61Q6IROmAjNOBitAsfJ6IPlRF1fk5kc8LtcKF3gaJo/PUKNb1cnuBOQo3QfNVG1sg1rfwNsxj9Qcn2PxBUFZ2Zx2uLiAzpkBJCvcaOLZK/Czy4vsrVUJKNfx//srIbAKanvzKnUM9kN/o9zhNDhX5ND/ub21vR50AHKtL/5GAmu7nbUDkwSx9r9bCLum9lpzDK2cc0zgQ2Yy6YsqZH4dyPNdOprZH48JFW9nvJn71+Xa1L5XmzEQSFDG4UNFiFa1R9yDIgO8yBnVsY7BVBPF4ngXs6EQBcqwn6L43+NvM5QCN9ehDNIh+T/oI78lBMPl812QRTqri8IbtRsNaMsBNWJmu4f7aZ1HTFWiyF9PkvmmqRsWCC3ZQY5FMb39yINv8zBkNLJ0bwqyePUoqatfPowYAYTMEaZKArCuwxTQDntI8sI0u/1fRT1qPpJYBx4++A46aR3C+kQ+auFgBFd9QQKuhcBzsDAgVtjkr6vEYoUBja2SQHcfuxgRszlB3M/axl580sb1TpYdGUOnxZjfLWhZI0Qz07CXHsJuCNgAJ7TClizuWkGLlGn43xBj0hGVX4HB7rpur+0nOwwUWB/i7pIodbSyORScNSmqJH+8DgJ7GG+kOGv33rlMp8my81vFPP7TsYcoMBP5jZrLbFP9CKek7EvAzd5U+OarzXjlKC21cObsS02lmMGKyZtK7Ci1QiT/TYtXq70uI+YGmd4tpL+MsShmQeod7q1VbyELUofQ0ibordzxGPmON592Alk9prwTD4i0iVetLmuv4ug3to9gep1Vn+sDQsAUjUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(38100700002)(86362001)(31696002)(2906002)(4326008)(6506007)(2616005)(53546011)(26005)(82960400001)(478600001)(6512007)(66476007)(66946007)(8676002)(110136005)(66556008)(8936002)(316002)(6486002)(7416002)(5660300002)(186003)(41300700001)(36756003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dCsxejM1cmxzd0dkYlZQVHVwZTNhWmhETHRGYlIraS9aOTNDSWFpSXVqNHB1?=
 =?utf-8?B?YXZtMDJlRTRySE1UVGw1aVBHWDRJRTBiRUdyb01Mb0MxTmR3TmFmaWtlWUZn?=
 =?utf-8?B?M3BnR2JMUUNOZWpSOWVHdHR3aWhWclJSR0xtSVhVa2w5TlFaVzMyNmpUcWw3?=
 =?utf-8?B?L2xBbmF6anQxNGs2Qm9hRWQ3ZnBRcEFHaFgrT3NCWkc1emptYkkzeEhnS2Fv?=
 =?utf-8?B?cWtwQnN5ZmxIOXJ3QUIzK1lEZTdYbitXNmVyR1FmeVZtUnFoQ0hvK2hnNm1y?=
 =?utf-8?B?eE5jMFp1cXNYdnc3WituR3pyU2t6TDR2TG5lVUtvZFpLNHFYd3BDWHZZVFFh?=
 =?utf-8?B?OUk0MXdvTGVWN0ZKOVZrWGtTSlIrdlRVQ0I0WmNsUFpGQ0s2cittWDNDN2lU?=
 =?utf-8?B?UitVTjRjeWNsRThlNHROMnFtRXBDUndMQUxPUXMxZktleHlrTFBXTmIyOWti?=
 =?utf-8?B?djczQTNIcEs1Z2NtUXFCTTNqd3VhZW5acm82TEEwbUphZ1FUd0c4TnRBeFFP?=
 =?utf-8?B?T3ZITGdvdE01MGVNNURTOXZSeUtCaVlCVFFGMEFISm95citHdEtxbXU4NHgw?=
 =?utf-8?B?SkRDc0p6Z0JGOFJxd00wcGZJR05OOFJZWE0vakYyQ0N5RHloMEkrNUdJTDJw?=
 =?utf-8?B?RUpjMFNJUnZLU3RzQzFqNzlIaHdKT25IY1VXQ2crL04wS21OVGlYWlZPeGVS?=
 =?utf-8?B?T3NuY3JObHlySDkySWhWUkswUFF1d0RscWFJNTlxekpDYnlkdGVqTFg5ZGxz?=
 =?utf-8?B?WnBXMEFzaEJJeHA2ckdSQUFEbkxnb1doWWQvdCtoandmRVU5UFV6dmNuT2Mx?=
 =?utf-8?B?UHVvc3pUeHpta0hlZ3ltWXcwTDZSUnU3UlZuZU0ycFA5WWFxa0dDUm14RktX?=
 =?utf-8?B?d1gxQUdYTlRuSVpQNXd6WGRKVTVvSGd3dzRzYmZEZHZjYWs4emdmS3ZQeDQ2?=
 =?utf-8?B?WFArblNwMUxqbExXcWxkQ0hVZm82ZlptbndrWWRZYjdjMFBjZjBYU0o4YjBB?=
 =?utf-8?B?TGZTTW1kcTJ4cWdhZUwrc29ySFN5cWx3WTI2S05KZWFWenFzZEZMeGgyRDNK?=
 =?utf-8?B?ejFHTFQ4K3FIL0F2ZEJDcnhERUdtWXNPVzB0V05PQisxbTk4WFowclBodWdZ?=
 =?utf-8?B?OWROd28zVnFxV2ZxZWhEVjJRb1g2R1hVS0FrNWZQOHdCMDFMblUxNHVBQTJE?=
 =?utf-8?B?aXlRM21SOXoraVVRQVg1c0phaTZ6TUVUaEl4cXhxWGZLK3BTbWMvUXVrYUc5?=
 =?utf-8?B?dEo5YjlwblNIaVAwTE9LSGN5VU81dC9uV3kzY0g5NTVKZEFmaVJKTjY2dkZD?=
 =?utf-8?B?V2V2NHorbTAvaTZFUG9rS0Q4TUlLN1R0a0t2a3ZOa2c2VWNzbWdvTUpEemRx?=
 =?utf-8?B?a1JHSTVLN1JSSTZIenA1TW1BQWN0dFhHdVVrWngyNHY2Ny9Delp0U2ltQVBj?=
 =?utf-8?B?b3FsZEltNDI3NEVoUkZKazFSdU1hM2trM3NyYTFveGdwTlFxSkQyclMvaWRj?=
 =?utf-8?B?Y2NYdytxdlk2Z0xreEZnQ1h1dkFlYWNKME1WTkgwTWlsUzBNTlJhb3ZCeUlr?=
 =?utf-8?B?V1hUcDFmNzk0Qlh5RWN2V1N2OFdMd0JvcjFRdDJNUmRNWndBSkFMcGJORER0?=
 =?utf-8?B?bGV3NHU3QkxpR3ZYN2ZDK285K3JFRDVQb01JU2wzRktsVjIxaTBmWVZpMGhQ?=
 =?utf-8?B?bm5YZVFSWFVZUGxvU1k5bWVwM29adGtmcm1zcWZrcFFJMGhXWFlpS01iNWdq?=
 =?utf-8?B?Tk5WQU9aNjlPVjV0VFlMaU5xcFhRdEx0czA4Z3Y5a3RQdk91aTIvRW1jeG9m?=
 =?utf-8?B?dDNyK2d3N3dSekxPSG9NSGRDY1hkenI4LzIvT3NRb2VlL3d0ekQ3UklmU3hW?=
 =?utf-8?B?MjA2M08wYm1MV0RVMUtMeWhiRE4rR2JBbEdKM2dRRHFhTDNOTmlOdHFnN0tL?=
 =?utf-8?B?TnZXWmxPeW93Y1FUUGxqQUlHOEFIbVk0b2pSeWNUY0NJU1d0dEpXdXNjdEFk?=
 =?utf-8?B?cEoxaGoybkhTanlUcU55ZFVFcThNWFBHampVR3djV1dmM3JHbnFzQmtiVEo1?=
 =?utf-8?B?VHNIZVhTWWFVZ2NBZDRlaGFQK3NEdkxLcnYwWnFiYnRMNzdhcDJqbXdMQysx?=
 =?utf-8?B?cWtFWWhkdlEzc3RZNkpiOVBtUktRWHg4dWJSSk0vSWsyemlIeGVoZTlLUGxs?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bae35377-e2e1-4870-9bbc-08dac4239279
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 20:30:28.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMxNFU2NKU3RKcte3NRzw5UJ+QFye0tz6XUk2R3SuPgoHKbHrXwpHgt/qM7r1Ltomn6TDg6h0X/ODPJXMI3WCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2022 10:48 AM, Dave Hansen wrote:
> On 11/11/22 10:39, Borislav Petkov wrote:
>>> +struct meta_data {
>>> +	unsigned int meta_type;		// metadata type
>>> +	unsigned int meta_size;		// size of this entire struct including hdrs.
>>> +	unsigned int test_type;		// IFS test type
>>> +	unsigned int fusa_info;		// Fusa info
>>> +	unsigned int total_images;	// Total number of images
>>> +	unsigned int current_image;	// Current Image #
>>> +	unsigned int total_chunks;	// Total number of chunks in this image
>>> +	unsigned int starting_chunk;	// Starting chunk number in this image
>>> +	unsigned int size_per_chunk;	// size of each chunk
>>> +	unsigned int chunks_per_stride;	// number of chunks in a stride
>>> +	unsigned int reserved[54];	// Align to 256 bytes for chunk alignment.
>> That looks weird.
>>
>> __packed and __aligned doesn't work?

The struct was mirroring the initial 256 bytes of the metadata section of IFS test image (replicated below). 
I will change it to union with a separate padding member as Dave suggests below.

    IFS Metadata layout
   +----------------------+  0
   |META_TYPE_IFS (=1)    |
   +----------------------+
   |meta_size             |
   +----------------------+
   |test type             |
   +----------------------+
   |fusa info             |
   +----------------------+
   |total images          |
   +----------------------+
   |current image#        |
   +----------------------+
   |total chunks          |
   +----------------------+
   |starting chunk        |
   +----------------------+
   |size per chunk        |
   +----------------------+
   |chunks per stride     |
   +----------------------+
   |Reserved[54]          |
   +----------------------+ 256
   |                      |
   |                      |
   |                      |
   |                      |
   |Test Data/Chunks      |
   |                      |
   |                      |
   |                      |
   |                      |
   +----------------------+  meta_size
   |   META_TYPE_END (=0) |
   +----------------------+  meta_size + 4
   |   size of end (=8)   |
   |                      |
   +----------------------+  meta_size + 8



> 
> ... and don't we try to use fixed-size typed in hardware structures,
> like u32?
> 
> There are also much nicer ways to do this:
> 
> union meta_data {
> 	struct {
> 		u32 meta_type;		// metadata type
> 		u32 meta_size;		// size of ...
> 	};
> 	u8 padding[IFS_CHUNK_ALIGNMENT];
> }
> 
> That doesn't have any magic linkage between the magic "54" (times 4) and
> IFS_CHUNK_ALIGNMENT.  It makes the compiler do the hard work for you.
> 
> Voila, you have a union that's always IFS_CHUNK_ALIGNMENT in size,  No
> magic 54's necessary.

Thanks, will adopt this.

Jithu
