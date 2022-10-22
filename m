Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C43608D51
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 15:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJVNC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 09:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJVNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 09:02:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492B7284867;
        Sat, 22 Oct 2022 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666443744; x=1697979744;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cwggQ5sgMbXnlXVi4Mcl7RphyzqZqS6M7Yah5FWRc2E=;
  b=M656EUh2lJPVXEs45jY3c3GsDYdtGo88XFlq1KeW3yotKhovaA5Cmwoo
   4r1AXaFf7YKG2f+K+9I5ormSg4vFDD3e5xQhyXuVMaisXMT7D5kgzEoNf
   1mcEcdo3FR5xFy023Iez2CVuUFjrSYtA67YDMvO4KXJF5dIsVxf1881n+
   qB3TascauS+IbHGhng5/kj+L8qL7biPBTbEb2aBiMqopxnC9O6U/AhhdW
   9BLSQmzUpQ2j99ruJOQF7+zr+sLue7Iw4P9h97aIdzqJ0LTl9RY9GhisE
   qpHJ1iD3xtMUSabP3HnrEcmHld4PlSJy1s4oSEKseZHdNcToNsbUaT5lm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="304795311"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="304795311"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 06:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="805858120"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="805858120"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 22 Oct 2022 06:02:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 06:02:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 22 Oct 2022 06:02:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 22 Oct 2022 06:02:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnOe2cfr5RHk0+cd9+tmDQkIaLBtrchODCzx6Xsp1jQyXz8/7jelnj2ZP0/9jxkJqra/DrNWe/4O6/EIg38bh4nhpZps64L1TNYgUIQXvD2L+BqyRPybIVGpmDEg5MVRfaORdczg4JqdZf1D3Qqc1Pi0BCH5ao+PWVxhLCaymQ4CotHecZVFMLP+R9OZMdCu//6pIVImjFZJ94KH5ZfcLJUEcRlX5nXb6SZsgwEf1dF+jg3svT3PF7FmHciXPiYeK5Wz5Q1Rp+06hJ4J8urGLknzz/fMtA7pSuXgzyY1m1+HKNlJcSO5a4spqdw0J3kBu+/zmVkbUDA4HSuAAqbQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3XS3skG9gAAu9fJ0RbNO3C6/cZR/ngBttbaxw7ILmg=;
 b=e2nEt8b2AIhJs09CA3TdQDqyerZ35F57RCmF5NcxA+m91jpuxqSYXanW9T2S4SY3GMNeGXAOeN9iOMTLVkeCFdv7FDTwlmv/Vq0XZhWkzDhLlMgqQbVfHS0DFn2UU4vuBQuRInU3YgaGCJh3AE4WBnCdwagDh1NHEb5bTuaIwI0V0ges+WX959tnn248hnsts2r36iSvJUZxp1ftiVQ5O4uQCaC6DOC+Nmw4gDZ7IUy5kUvTtnCYWFp0K5OwsaLvRNA1AfWFujXVoNNhAXTQD/BsWC0EMI7sUh8GvbLDaWTtYawQ0p8WaHjU5cOHkC7L0rs04iox5HxAH1AcBIO0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by CY5PR11MB6187.namprd11.prod.outlook.com (2603:10b6:930:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sat, 22 Oct
 2022 13:02:09 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e%9]) with mapi id 15.20.5723.035; Sat, 22 Oct 2022
 13:02:09 +0000
Message-ID: <a673d19f-d7ba-c3b4-e932-5310b0088812@intel.com>
Date:   Sat, 22 Oct 2022 06:02:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: x86/urgent] x86/fpu: Fix copy_xstate_to_uabi() to copy init
 states correctly
Content-Language: en-CA
To:     Ingo Molnar <mingo@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-tip-commits@vger.kernel.org>, Yuan Yao <yuan.yao@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
References: <20221021185844.13472-1-chang.seok.bae@intel.com>
 <166639111821.401.9381657733834636095.tip-bot2@tip-bot2>
 <Y1OMSAmyUg99iorm@gmail.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <Y1OMSAmyUg99iorm@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::16) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|CY5PR11MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1b882e-cea2-4aa1-c9e7-08dab42da10c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iG4HaNyXbCPa3ZmVI3OMwlVjlb0gdpW0L46cmIlV3iEp8CGjI7d3RXqYbyOoC19KDs5CGbBkHDUKxuZ8lIJM3Nmu7Cjfo6aFDK53kVx44IL6G8cRvza0AbSBiwHcRxkab0rRKXWSaXidOHggIIDxeYFe14QSE2vwrQGuABtQmDLbsWT6nmWMCr7SfLMPAwMnXKg7gBIXzjShvPsz0oYx0wS9227OTC/KC6bvViFGd+hb6uKgkokkVz5iET0PBQ0hXu1UA+zWoW4xdYr51GC1Tu/akdW/XJJUqvRlJrKRVVTEb5hKJnVBATXsaVyQyWoYqsBGgrx9nzNjzr33noWi1WVoYd2h7k9tFTkzd0J0GyFQpyvTnRkBLSHSfUVslE1hi7kkqM+g43wY3Y7KFRrXin22GrA/as+TATApnW3tJPk7dLFqyHIOB5rikvyayct6t7O+D58BoCit0pUlnIEDeXMBQ1UFID2xdEwk04t3l2SRlRcPa7KO6isshNxPUUm6wa07uiQsAzaHRqHBdWIe+9KHKBvVMtE5l6plMQiTjXBLF2Ck/H4PInhA60leV2zeh0hQq3+cVqps+HTMtyPrWqoFqrTMZmd1ZxWgdzAEtcYoRrt8joaqSNwYiUw5T+CLwdI0J2YsyQiqH4Ao4b4Wh6JZs13SgOVod2oSIcuCCcZu1af3nrTspU4FXzrosy99f2clG54dkYs6GHA+W1h2hTHuAWi8Zn4/lXIolVC3bMXylJkSps70C6KpTJkT+XZRCu/j6DMoN6mVBYdAd3GhA/fdK6Q88L3Po2g2Lk0pHA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(6486002)(31686004)(478600001)(31696002)(86362001)(82960400001)(5660300002)(66476007)(66556008)(53546011)(8676002)(54906003)(2616005)(558084003)(316002)(2906002)(186003)(41300700001)(6512007)(26005)(36756003)(6506007)(4326008)(38100700002)(8936002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEVCQ2RXaS9HeXlCYURMMVoyRlVZUFp4bnRYV3AxY1dEZGxsWnd5dUJsV0Vr?=
 =?utf-8?B?bUs2eThsNWs2T05Sem82RGJNeXNhWlQzbDBpakxIY2J4SGhJU3lMOVJKRG9o?=
 =?utf-8?B?TEswQ1YwdG9HaWNsbC91QzN6Smx0SCs1NnBHeGR4dXRML2l1Y1FTYlh3SVhq?=
 =?utf-8?B?UnVnVUVldjZwblFXaVFzb25UUituN256cTJCODd4NnFDc3FIcjYwRGduT0Jq?=
 =?utf-8?B?UmhxcU1hVE8xM1hCdGZKT3VXR2JoMDA1bzBKR3JuSnlMNW9hU3Rpam1TWE9j?=
 =?utf-8?B?NkVHUURkK2h0endDakFYWDBlMXFPRUE5R244L1UzUTR0OFQ5Q3VBVVBzTzJt?=
 =?utf-8?B?MGNGTk9kV1V0V1QrTC9IUUR6NjhtR0NXeUE5dnhKT0RFcXo2cWhHdkcvNy85?=
 =?utf-8?B?T1hYWUFNSEZJWnRDbk9LZTQzTkt5VXhHY1Q2akc4UFFCRmpHNmpyRVViVUF4?=
 =?utf-8?B?bmVlL2VGZVdhVHdDeE1lMGNjNXFNaU5EcERsYzNxQmRGRXRvb1JZUEkzTmxj?=
 =?utf-8?B?bVdlaUJ6RDhMQy81VStnZlN1NlR3SDZqYStJZHpZY0p1SzlIQkxGYUtJcUhN?=
 =?utf-8?B?RUFUWW1kYk0vTi9VNTRMU0ppaUpseGJ6d3JVSTlsNVhxbVdwOVF1ZmdHT082?=
 =?utf-8?B?dmF4Z3hCa0xPS2lobTExa2Q2UjFaTE5KTlZEV3ZPUWdJTVF2UXpJaHc1VnJK?=
 =?utf-8?B?RS9RRkQ1ekFNVU43dkY2aXFNWklnYjRLcytkSFRYTm9Rb2dJeEx5VDZaQjhT?=
 =?utf-8?B?WmRWakJUaURBVkNKbGJveTBkTnNodUdwemk0dDZscE1qajEyV3BNbU45N0hL?=
 =?utf-8?B?azdyUWlzMEhtaUd1RFlxMmpJaGtYOWN2eU8zTm9HNVNRTWFMT0sraU1jaWFu?=
 =?utf-8?B?RFhFN0duM1B6ZWd2SWlEQzdtMGpCUlVZL0NRQTZ3TWp6Qm0rclVYaXVsajFG?=
 =?utf-8?B?Ym1Qb0VxWHA3QVVoQUxVOFl2WHhvUzVrQ2tlL0lEeTFoVGhEcmc0aEo0aW9M?=
 =?utf-8?B?MlJNdGlHNkRYaW53eDdEM3FjZ0Q1b2laVncra1lXdnlpK1N1ZnJSUWFpaW9p?=
 =?utf-8?B?ekF3TWt6U3l6dC9wMUxlOWdiRHVnbGtSS1JtQTZLTVh3VDQ4a1RaczhUL2xp?=
 =?utf-8?B?SjdZYkQ5Lzh0eUJEVGtYUXFhZ0tMU3BocVAvUmJySHh0bFVBN1dPaFZxbThQ?=
 =?utf-8?B?Z3RNak1MdFZGNEU1bWJZL3Zsams4QlViVEh1dWwvWGVkWDJrSm5BazE4ZGJU?=
 =?utf-8?B?b1BRNmFxS3Y0MzZoU3ZXRDNkYjg3Tk1ETThiSWt3R25sQW40NlZDdHBUMXYy?=
 =?utf-8?B?cERFdlJOelNEc3doSmFNVUpSLy9KWTQxc1RSMjFEM0o2ZnhLdHJiU2dVK3Qv?=
 =?utf-8?B?RkZLWUhSdXNEWU9LWTVBOGM5bStLdVhXL3JRY3hrNjIzeGJONmU1M0xJTG5I?=
 =?utf-8?B?cGJmeU5CTkZNR0M1R0RZQ2NiT3JQZ3lrVFFXSGxUaEVTVUpWRXZvTmdReHds?=
 =?utf-8?B?WE5meEVaSFZYZDBpSVdMS0lwZXlYN2ZKdE5SOUk3L0tHd3dBRkhxYnNnSW9F?=
 =?utf-8?B?dE9MSDNDU3B4SWNJcG1lM2RZNlpiRjNwSVZiVWhjeDY5WGl1R01MdnJsUzBH?=
 =?utf-8?B?Zit2ZkVEVWo5YkJGcE90MHVLM1F1VWoyaEFTazlyZmtOUjhTWGJseHlUcDdK?=
 =?utf-8?B?OWVqVEtKekZDOGJjQWZ5TGhzYk5yQ09NR2x3dExqMnUyRjN2OVJIWHFEMGpC?=
 =?utf-8?B?akRmdjVnWGY1cFdwYzlGRlJ4UFFCQUVEckdwdlZDaTdlMEpBSkIzSENKRTN2?=
 =?utf-8?B?UVZUMGdQWlhuRjRPYTU3LzRpa1RoTVczWVVSVjRQTVBjVjlYYm9GZWFFMXlK?=
 =?utf-8?B?Njh4TlV4MndVOFJZWjkwOHJQRWUyd2FINklMeEtOMUhkY3YrcWkwSDRXNkEr?=
 =?utf-8?B?bzF2YWZieE5IQmxpNFZHeGg4QXhvZmxQeFlIazJhLzNFRysyOUtITTRhR0NM?=
 =?utf-8?B?MytCYW43dW5ZUmVJcExFZ2FWZ1Zrb2tBUjJvZGR2ZG9XUnozeXp2Q3Rqby9T?=
 =?utf-8?B?ZW9ZbldQRmlLMlBDb2Z4YUdJanBFU1pPSXRzRTlYajZuTmNoNEJuYWd5SUtW?=
 =?utf-8?B?TUdBcDQ3cWt0U29YaVhRZVhUL2QyWHQyVEpndEFmeXRtV1l4TDErUDdlYnYw?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1b882e-cea2-4aa1-c9e7-08dab42da10c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 13:02:09.7188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdz6yKo22Q2iDUs1dGYxt1IKbExEuwNzw4alsKEycQ+4oTCZSKX2R2Wy+ygOVjyk+SE7Iqqz7TQZFerIu515AaKuPrZjCFCK7aYD11u21/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6187
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2022 11:23 PM, Ingo Molnar wrote:
> 
> Nit: those parentheses are not needed.

Ah, right.

Sorry, let me follow up on this later.

Thanks,
Chang
