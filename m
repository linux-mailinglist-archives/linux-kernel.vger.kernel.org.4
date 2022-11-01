Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9551161450B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 08:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiKAH26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 03:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAH2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 03:28:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9425A14009;
        Tue,  1 Nov 2022 00:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667287734; x=1698823734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HAZYcRtHqojLwJ3h0qzSRwkQz7gCzCIccc5bbRmsFYs=;
  b=R/2ppsrQq0iuQP9bR+d4hj8B3oHz22lvPO+XzJEo9Pj6oRY7jDEEf/gg
   df+BXoZi3PxTtyU67MIeOk5UJMPFEmWnZ9IiyIsMdjilKjCoFEGbwEb7s
   5f926XuRl+xNRGKMvMwgRnpt2Xh4YyO3RvpfsCdMJA/Pj8x/3dXWVZ36d
   Y1LHeCyDWGI6R1jphMu6vCV3yVisDSua7eUk2pI3NClkvx56C3V4f+0PX
   deLCNyO197eZwHb6O9gg/QTveQjfK6USd1+SV4xxooNlAsNOxWEHjPS2S
   RcjRkjrLFFD7g1+dviR1RojTAbMAxbVnUU+455zwaLtF124myGNRWr2/c
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="373299274"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="373299274"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 00:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="808824898"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="808824898"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 01 Nov 2022 00:28:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 00:28:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 00:28:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 00:28:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYyU/BN77jqIWrEHu8f2YaQrUh/R2deoyksFn8JoNMnLfaEc1nkVr490p41ncDbC+h+WVM4JL4ygK1nUcoLrOfF1NqUgykNXBqyuh5u+CKaWoPQvSN17sxhyM/DhuiTsxgrjWePh0bnxa5jQO9hW5HdgVSLt3oMHtYkDX5VfAFt1akueEneCfMEk23GHOuFPJkxCYuMlGnWy5CC0ISklXhkwTvzgaXV3iRkgFazsOSSTtiYpiIZSgqF5ZFaxC388tgbvSRSgWLVmKr4vJjDyN89Zapsm6BxqNtx+dEwySu+Q2fn7xus0RjtDc9T9Abkkl9ft+L7T5Kqi5mYqc5vfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O3YftdcwKJrzx/Ql+qAEfNUj8usegnkNpgLjiKNzbE=;
 b=g7vUd0NEVmeysR3fA9hBGn+cAaR+Mc1Gj5QEhVT1/lwqx+wZc+3APVwBHHClWpsa5HRUV0K/GyH9XwHMN15eTbs+idoMOqYS+LI8w++TMWbM62fDCzCZITXZ7NclrBF4jmPw/dHFo7ceyg+8X4fW+H1/BQyBovWIZy5U1DtdKINt5gbuoBkizOQYAhCYwjbqUfbYLvZLItnmiwHaAvZdz30U1NgzCeCLjaf17ZAfN+p866CezPw+Trrf212XqEkHEoadgwGutGdBjBXoEdNJnCil88vIMR7YdJPfgDA54sVraaMwvjL2esDLhYMNA6MHpJBUJuJ5BcpN6KI6hAwO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA1PR11MB7386.namprd11.prod.outlook.com (2603:10b6:208:422::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 07:28:44 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 07:28:43 +0000
Message-ID: <c225e969-a88d-f3b4-de44-ef71f44dd463@intel.com>
Date:   Tue, 1 Nov 2022 00:28:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 07/14] x86/microcode/intel: Expose
 microcode_sanity_check()
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-8-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221021203413.1220137-8-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::26) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA1PR11MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: d910b3a7-ef21-4dc9-c538-08dabbdab4b9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMpQwunzG8ZdOVrgp8XFUjHwMc9GuvpJeIkYqcfboW9gTCiOpPFrJyA95hcXadJAm+5Gvjpe5kmdeGDlGm2+AWdtEvEDn4Or/5jUTx1nN3ryGj8iveYhMwtH3XVnrupsidU7n9NJr+Zpu0BaqG1qxMLqiWKJn5LMYlz8fqAnq3jYO7coI+4IhKs9dxtkaw08njG6Y0SQQ49LHcKyuHfAX6vxNXDbZIamg7cfeXrCiU66fp8xpOCwwxJj6tLbRJ1rp37Yl+9pWZ56BKELHtZolfdskgc+PxPVWnu876APaAtQVtWgy2blJpDMBt79FyC4Y2cjTHjCASjQ5SLHeMrH1R2WdQCE5IGIH4mSa4NmgbFk01X0toABAq8FYCIPuYQNk8vAzacAmWZAQuwToPjXmCNNv3s35EqyWxsNBZoCOyp0b2d4eVfNuvzkfeHO/EEzYOE9WvckAVPhvyS1CuD//VUeU3nraULr6Wyls5sE46jJBM91bET9BNhniQgLRzT+rwHCn9Rbj0Kwcd14fp6PQmaNOnjXIMQiyAh7nz+VJ6p7vzsQAnxd/Huzv92Tqf06BUZ6OXvxnsyXDkntIt2Q6uKDTTWZ+t+oJVjvQqhI5jUslNKel9D9cIqlZg9u+9OeEPm+mng+Da4SGpnTOLTpZNCePNy+hKZDiYMfHEv/qCMo0LE3ST4exgapIUDdN5D6zw7/jdemNG4FWPKFGYQsAJPiuwy3gYX9xCayQ9+LScfMWbz6FsjIVSB9Wt5DqMFP+46FXdeGFoKe0qQa9oLg9LGTYMU3YtwoevnqIsJjI2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(83380400001)(31686004)(36756003)(2906002)(44832011)(6486002)(86362001)(82960400001)(31696002)(6512007)(38100700002)(26005)(53546011)(316002)(186003)(8676002)(2616005)(66946007)(66556008)(4326008)(41300700001)(66476007)(5660300002)(7416002)(6506007)(478600001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTJadHdiNG5UcGdROG5XaUhjTEZtNytWaFZiREhlWGI4eUpmekxZcmxSbERh?=
 =?utf-8?B?K2o4MjNtMENHZmFmQmcySHMzQW5OeUluYUxSMitLNVBxc1NoTXlSSEdjRVMx?=
 =?utf-8?B?bUh2c2ZOQldnZzcwTEdzNEJOU3JYZVVLTTVsZWROY25rY3Bxem50U0lCbnp1?=
 =?utf-8?B?UXNjMG1aMkRxMm9iWjVzYmNSdHFOcmw0Y00zdGw5L3JKdm9xY0NBcVFsVWhO?=
 =?utf-8?B?ek9CSmN1SjBmUzJTdGswck96b1JkdjIranVFUlFxdUZlaXhodURoYkFNWllO?=
 =?utf-8?B?Tllkb01XVDUyTllxOEYwUS9Rb3VZOUJNano0cW1idHdjTUZCOURKMGorZjA2?=
 =?utf-8?B?b1ZGTWZMY0RPaTBiZUhFOGNma0NOc2M5QUhtZnlIeVhSamhwVjRTb0tORDlZ?=
 =?utf-8?B?VXNoK0ZNaXRSSXVQNGRuVElMYXIwY2QxSHpKQ21uSWVYQStiVDVKL2M3anNs?=
 =?utf-8?B?U2pCU0lacjg4VHlHL01lTWtWTmNFRUVWWFRxYUZwcGprWVg2UGcxcWF3ZzQ1?=
 =?utf-8?B?U1NHYUdoekFJV1psajJrTDE5djUxWVBPTkw5cmxXaW1rK3JNbElISlFCWjhs?=
 =?utf-8?B?UW1Oa2kyWG15R0JNRnliQ2hmdS9vVk1VTnVVckxOcFNQZnEyVTBFRmw3V3FW?=
 =?utf-8?B?R1lzSm5UTE5hWlRLeFJVUHBPSmdiY0Z5MlpBZWtTNDdJbFIrcy9VVEovaXJo?=
 =?utf-8?B?czMxcWlsSkZpQlIvbW5KN0h6WWU2YmRnZWgrMTlvWDVOaXZVckhXOGZ2aHhm?=
 =?utf-8?B?ZCtGNE9Cb1JUMGtKMjdPK2JKYitHTnI5SEUva3RTeFl2eUJYN2pvbWJwUXRS?=
 =?utf-8?B?eEFMSUh0TENkbSs1cWFQdFpIRGE0cGVNVDZPVzh2cjlUVHNoejBteHdQclZh?=
 =?utf-8?B?RzZ2U0RldXJrdGZ3OHN6TysvcHZCcW1MdEVSRWkwVkEvbnMyS2Yrd0lETTNj?=
 =?utf-8?B?ZERpa3BSMkFuSDBVWGtmVm8wZjFnWURoeVpJejdJcWhSZ3d5WExkUjNyL0Mv?=
 =?utf-8?B?Y1pzQ3J6OWthanZQblBQNGtmVCt0Sk1ucjBsZ2xqU2dvd3gyRHBuc21jV2xH?=
 =?utf-8?B?UHJSUjR5V0l4QitLQkgyVXViOHQyUUJxRUZkOVB1d0ZUeE5CKzVoUDVJb2VB?=
 =?utf-8?B?Y01iQkJqU1J0Vk9PaUY3TndvOCtNa0JTQlluZmJpOXpjVnNnS2w1SHVOdHE5?=
 =?utf-8?B?ZndXckVpaUUrYm5jM1l4UGpoNU5nemc0WjIrR2dWNTRtaFhHL2ZmbnY0bXdU?=
 =?utf-8?B?WHJHN2JxeWRTaHJYSDdPYXY5T0o3SkxkTXlwUTlRMVpUV1NkT1FTKzkrRUQv?=
 =?utf-8?B?WjVWVFduSkV2SmhISTdJbjFaTUtXQ3dUempyZnVzWk1CUlhaQ3dqMWh2ZHZm?=
 =?utf-8?B?Ni9UUVNDaWFzK3VYL1ZmTm1PME1oMG16aE9PMnp4d3BNbmhqelRMcE1aKy84?=
 =?utf-8?B?b21Ca2o2QnJmZjRxb2N2dVFUaFRCOWtIQVdiL0pURjY0SzA4NFlxd1psWHZB?=
 =?utf-8?B?M1JTUERIRUVRY0lFeFhKZlB2dVFuUHJzWW15Z1hwbkRQbk5SU3NFVTlzTTA5?=
 =?utf-8?B?UEEvM3lHb1I2UjJsK1JCYjN4RDkzK0I4ajdIRko2bkxzc0hNYmJXREJwY0Np?=
 =?utf-8?B?akZUK2lZS2JCSEI3a2NmbzNqSmZXcXVyL1hQZWYyTkR4YnZ3dzJqOUZNanl5?=
 =?utf-8?B?Y0lxVHlrWkdkdWRzVHBwYURkN2lmSlhrNmF1UG85Y2dRbVVFU1RJL2RrWEtO?=
 =?utf-8?B?ejB0MUp4UEZQR1NHeWFYZGU3VHZBN2lQRy91U2lCT0dlMzZYRGRoSnBZVS9q?=
 =?utf-8?B?UlA5OHkyYTJLR2ZWdXZnZ3E1YTRqOGZ1OUJ4QzZ5VHNQUGN5TFJvVnZlUWRr?=
 =?utf-8?B?Y0hhQ0hRMDEzQXB4STFzM2pZMzRDQWcyUGZKNlcwR2ZJS2ZTajdZMHhqT3VJ?=
 =?utf-8?B?aVlIQjV5WmpFM3BMdXZUR01xcFZoTEh0aFBxYlppSHh4ZU9sSEtjcmxwWHpI?=
 =?utf-8?B?MU5HYzA1Mys0SXBuWlpzQVBGRHJkM0N6cDBFalNIeStUNTJVakluSUs3Q1B6?=
 =?utf-8?B?SjdxcUVkV3pRSDFQeTBOaFRnMHVRK0pYVS9nd0w0VzJjMXllU0hlN0I2MEVh?=
 =?utf-8?B?eTV0ZVJtb1A3UE1oRVlmQVdGb1pjY3NLTXhwVWtOZkp4S0lRU1NYeG4ySkk5?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d910b3a7-ef21-4dc9-c538-08dabbdab4b9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 07:28:43.6934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10PHVCBagF7QGBa3UdqRwB5tm/ao+7RwRQXFcnr7crejZeotLDOEnAI+76gB3hozf9SXqMWL9c3H6y5bDyTf2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7386
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2022 1:34 PM, Jithu Joseph wrote:

> Refactor header version as a parameter and expose this function.

Isn't the header version part of the microcode data itself?

Microcode Format
    +----------------------+  Base
    |Header Version        |
    +----------------------+
    |Update revision       |
    +----------------------+

If so, why the need to pass it as a parameter to sanity_check()?

> 
> No functional change intended.

Maybe skip this statement. Apart from adding a parameter to an newly 
exported function, there is a change in an error print as well.

> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 5473b094baee..bc3f33a25d7a 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -37,6 +37,8 @@
>   #include <asm/setup.h>
>   #include <asm/msr.h>
>   
> +#define MICROCODE_HEADER_VER 1
> +

Should this define be in a central location, like microcode_intel.h?

You would soon be adding a define for IFS_HEADER_VER. Having them 
defined together would make it easier to follow.

Sohil
