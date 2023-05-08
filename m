Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756E76FB7DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjEHUAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjEHUAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:00:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6B6133;
        Mon,  8 May 2023 13:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683576020; x=1715112020;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i0Q9z2bGFOs39jWEbeCR0l19uFMssr0o2/HhCsbt3Ms=;
  b=PdTzdd09+qTyrPllzE1SiTKJ5AxO4Z3rEB4vDs0obNkJC/58jt/VKR29
   HZc725zLHO/wW3h+N3OtKt5qeNExvrKsn/8z5hdEQliyKDlgauSNP0quT
   7TsMeQ/wE4nuiyy7aSxQ+nYPIJSLN//yfLEufxQh0PPffDI5DW21BdBHX
   1I+Z3W5ahAk6MmYCbr4SS/FifReOrXHsKENQe5OYkVHWH01ZhssI+QLUb
   Nclh/sEnN0Jbc+rfQjwMkPQRRjYbTxlEdt8v3l+7ZpunIfYYF1ZFJUZ5T
   p7iZkVnt8x1nv2T2JuybltnlhjZhRDuLk+kUUuF9N6mG8E1Xb7wA2Xzh6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="352803327"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="352803327"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:00:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="701549156"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="701549156"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 08 May 2023 13:00:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 13:00:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 13:00:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 13:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY6RUqf3wlHiusxBQg9UUD1lVMeJCU8WKwX/ONh4wkzaiBeHj2KJtDeZ6iSYEWkbi79hqmAS8C+D16HaT+zrqZDSP9SDlg203SyFv/SPwlcMNex+PXixjP8ZjkfgzJWahOUFDPIDwxlUmx+GrkxLg96uE606Jnt5t7ZzxmcwciquPEnrMAIz/rSrDYjFNq2Gdxyl98gLsBZvLFCNT0MARRuKQgogPUerv8Vve8bRGGXJ4KcH/8SJhz9z75U7iTlplEvw30nqI1z7W3ZFUN3IOeeqnF+J2qDg0D3dJr1cgs/S4PcHfhD/lUuK0whIWwcMoQJv8Andgq7oJt17fMg+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iyb26+jsIFneMlCil1VJMtNfc9sWBjFKYkgJaiYmDg8=;
 b=ZtUzr9hZqA3YXHsvQDoImRmwUKO/AYs8z4S43o2XPVCSsHaU+4h1HyRWT32pcQNHhxGbdDH5XVSM5AEitFFXd5QfzZ+BxnUFFRzWrUTA96VcnK/aCpQ+De0R+VXWtV2asnUBfs835P3jwmRfZvInwN0kUwEUkVMAQERVMl0Ib+t9yHYJ41lRx7dvrV0b34ug5Uj4B9AGwrrOZmA5EVZrjUk2hohciHCXf7XHnwwNc0UpdzM++Gae1khCQe+09o8jONNXi8lEkaYLPaRBCNZzGRUSFU7UvzRSw5YzyHUhmc9rjXf6QqqC/XMwERd9Th7RBzDupCpy6tXtYVCFZTMWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 20:00:12 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::cfb2:e73:907d:cb77%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 20:00:12 +0000
Message-ID: <db6965d9-e3d2-8119-03f8-0ad57bdacb67@intel.com>
Date:   Mon, 8 May 2023 13:00:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 11/12] crypto: x86/aes-kl - Support AES algorithm using
 Key Locker instructions
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "gmazyland@gmail.com" <gmazyland@gmail.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@suse.de" <bp@suse.de>, "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Keany, Bernie" <bernie.keany@intel.com>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Rix, Tom" <trix@redhat.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-12-chang.seok.bae@intel.com>
 <MW5PR84MB1842D5D264A5B067934F30CEAB719@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <MW5PR84MB18427DC1BA5C09778A0A057DAB719@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <MW5PR84MB18427DC1BA5C09778A0A057DAB719@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0060.namprd08.prod.outlook.com
 (2603:10b6:a03:117::37) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|MW3PR11MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: d36dda16-f522-4520-b74e-08db4ffed50b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlsQ94ee5VflYpwX3vWG+6X6H+abiQc+U7uAShB9t33V8/76Z9An7ln0wTpYV6LDGv998DmtkcmjyL26NBXMd9/qm9/JUY9/8Nm13YI7RUbwWA7ERkTFnu+gNkbcgULauhOOO4pl4bwOg++F7VuCHnwmtz3b/3wyygA3cIu8Z3r/L0gP+D+jO5Oa+EPxBZl9dpNyfB7qpXA+buTT6pvIFMlF6Ak8tcYZJvfO8QOiZrgINOwpDw2TY66shfaapUia4S+3d6nPb2mAAGazS3q3P2LpmB0cgY1urUWTqGpPZnO3UlEmAa69aG2B8ZpvkGCx4DiwTSiEEsaCk09NOIOAnqOQFG44MJkZmd6pn21DGognNSutWEPhnOIawYS0kNX7gnovoTFRcAT5vawnRp7SjBI5HK4D7AaWokXQ5EvIYWwmA2wLvpyb3QVaUXcI8bTuxc08+1/6uZA2U7guSdi/xdO7pbItBkJ/bGMD4rh1oXb8bXOucECC6hWZS9a9Q2JA0XxZykmJcaZulUhVozFOSdUC7p0O5+1Ft/qzeYub8Zb3qPJcUw6/xVcmiICLO3yk5ODanpuG4cMONOg23xjjUWvPPSQkDbUzqG1W1NFqYxOJ3fPe8ql6J32B2c/SYYp2Lcy7DulGIe1O5pkRswd8aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(53546011)(36756003)(31696002)(66476007)(110136005)(54906003)(4326008)(66946007)(316002)(66556008)(6486002)(86362001)(478600001)(296002)(5660300002)(2906002)(4744005)(8676002)(8936002)(41300700001)(7416002)(186003)(38100700002)(82960400001)(2616005)(26005)(6512007)(6506007)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzZ5b0Y3MkRPSDVaSFE2N2RPTWpSMUhwaGlhSjMrazJMUm1ObjRlUFFzZUlK?=
 =?utf-8?B?VFpWTGprejZITlZ6WTJndHcxbzkvVzNISzF3R2RxaU13Vko3UkYra1pQR05M?=
 =?utf-8?B?NytIbEk4a1g4RURRVEVUWTFLUm5UNzJhT2ZSVFRQUjlvc3hITUdqTWs0dzZU?=
 =?utf-8?B?cTI4RDNiLzRDd1hBM0s5eDFDNnJIVzVpYjAzMUp5WWdaYkY5N21RTWZId1RW?=
 =?utf-8?B?V3ZpNGdXZVVwek5MWHB2ckRjM2ViRlZzMVdkcmQ3LzFicFRrOHFsaFlPekJY?=
 =?utf-8?B?Z0x4QmQrdUpSWTFmUS9YUWlUT2NsaWRpbk1ZVEt1TFh4U1JSUXJXcDZjRWZy?=
 =?utf-8?B?Mnc0WW94R21kMkFJUjU4Y1MzVXdqdnY3bVBaUEY3a29MSVJPL0hnRUE0UjVX?=
 =?utf-8?B?QXdEcXgzZzZEeC9SaGU4ZEZhUjZnNFpQeGJoRzVaWXBscTFxeUpmejFlRG5D?=
 =?utf-8?B?N013bTF4a0YyZE1hNEthRVVKb2pDR3dXbmV2MmNVamJIM093Q01QRkJzczNR?=
 =?utf-8?B?VWJjRzhxMXZpTFlTK2ZPQzlJdm5rOFZIdTBWUTRjTjYxVFg4NUZZOGlqcGw4?=
 =?utf-8?B?V1dmUzVlaXVPcko0N2dBNXd1RjNmaHRtNkJEd3pLM1ZiV0dudnM4REF1ZG9U?=
 =?utf-8?B?bXJWUjFzTk5Pc2FBMm05czFCYlE0dFZJQVhMWVQ4RTBUVlJ4YTFrQ3FLY2hJ?=
 =?utf-8?B?L2RPS0E4dThTU1NzWWlKSmdZdzA4UHpHdWhjeFE1aFlPeTNRZWJTVm45TEtY?=
 =?utf-8?B?N2pyMTA5MVZJYis0UnVML1E5SHo3YkxlS25aR1RBUWJSTEtsdW9kclNkelJN?=
 =?utf-8?B?R1B6VTI3VFlORzZwc1kwOTQycDZJQUdrcHlmZzlJVnI5ZkF5ZW9QMjlmVzk4?=
 =?utf-8?B?b0hVaTE0bTJhYnE2Q29VRktSVHRUTXp3clAreWxpWk1QTGNnVFJOOEwxalYw?=
 =?utf-8?B?LzBsS3FzTno3YlFqMTZ1TjF4cExTSEpDMGd5UHNiTWs5bCtJWC9yRkI4bWU4?=
 =?utf-8?B?ZkhuZGpsM000T0tZaUlyUzc5S3BQa3dSakw0bVpVOFVtNjlVK0FENmMvd0Z1?=
 =?utf-8?B?Uk1EK3BINlUxeDEybjBuUUhFUDNkT2Q5RC9iUS94MjhVVG1BZWEzcDhKa2U4?=
 =?utf-8?B?WjJUMVBiU3RKejd1cFBFNDlYR2dJV0V2VFFoSXMyN2pSUHVGem5YMXVNc2p6?=
 =?utf-8?B?K2c4Y0xXWE5EejJwK2V3R2RqV0JkS3RSMDlKS2lmWUtwNk4xL2lUVTZ5dnc5?=
 =?utf-8?B?aW5HQmNpMStnRnRXL0dJa29yeVNBQXFibnhoUjY3MGtEeXgyVU1iLzhUU1Jt?=
 =?utf-8?B?UldGMThhbVBDQXk2OXk2VCtQTkhjMTdpK3pyOGZseWIybDlabWFqZzhYL3I5?=
 =?utf-8?B?V2FSUEIyeGlsaDVJTFRrd3EvdWtOWWVXNmt3WVZ1M2dENWVyQ1FlZnFySk80?=
 =?utf-8?B?YW9WOGNrR3hyZkRxWllGM0tkckFkbW44TDM4RmN1djQwODhQWHdZQ0R1RjF3?=
 =?utf-8?B?TkI0UGVNTmlkSUxFS1lUTXp0Qmtmbm1IMzRiaEJpaVQ5VmhodVcwWUdtQkQ0?=
 =?utf-8?B?SEhRQlZ6NERxY2FSc1lJbWJ0Y0gzTFBKbVFIOWRoUHpIaStISURzOC9WaVpa?=
 =?utf-8?B?YVZITVF6VXlhUkNVMUJoSUwvaGwyRkxHcGZ2Y3Q3NUsyeHBOaExISHdrMVBC?=
 =?utf-8?B?YWFDSytqZUkxOG5LSXY0WlpxVk5mQUpTdWtMaE04eWdFMjFvMEplZmJtT1Z6?=
 =?utf-8?B?V05xWTdsZ3hSYjRPOGU3WEptVGI4WVE2VTkzTUlFeFkvbmQ4bnBzM3psVUVZ?=
 =?utf-8?B?bWRwT1FmOUNRcW5WVmEwNXBCUW5mSVEvaGszSHRjZzBrNU9RM3RaSG04RWtD?=
 =?utf-8?B?RTJtK2FtNEZjZGZPbE9zaWEvVWJrU0lHNnZIMHc4Qk8wY293bndJbXNUK3NX?=
 =?utf-8?B?aGxEWUFmcVlpMGJUd0hUTG5sN2VlTlUrWDN4cWh2YTJSQVpmOG1rbzByWldK?=
 =?utf-8?B?bGlmc2dXRk1BQW5pa2Qrc0RCQ1lHZnJiYTgxUHdQTWFuaWlBYUluWjR4YUph?=
 =?utf-8?B?Vy9QdStJOUdnL081WlUvRCtFdFo5RXBWVVVGUGR1QmxKRzBiamxYa3hIN1ho?=
 =?utf-8?B?OVhBM0NKN1I5VlMzK1NINGg0QjluOCtXNXBkdVptK3lFdDNiV3FXZVYwUGhH?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d36dda16-f522-4520-b74e-08db4ffed50b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 20:00:12.0443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2YLIUAbB0w5JWGprrjfhK6KACmu7tEGZnGW5ZYNXQMALuoYqh3uuvQqUYvbBLNxUbzpRxFIAozhFk0UAzMyhxhYPjxG2M38MoirP7knhfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/2023 12:24 PM, Elliott, Robert (Servers) wrote:
> ...
>> This material belongs in arch/x86/Kconfig now (which didn't exist when
>> this patch series began).
> 
> 
> Sorry, omitted one level:
>          arch/x86/crypto/Kconfig

Thanks for pointing this out! Otherwise, it might happen to be based on 
the old mess before 28a936ef44e1 ("crypto: Kconfig - move x86 entries to 
a submenu")

Thanks,
Chang
