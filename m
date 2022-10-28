Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC15A610A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJ1G1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1G1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:27:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C071B157B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666938433; x=1698474433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RTC841e0CRuaY6V+svuNo6eUjyrv6bbnl0RMManKzWE=;
  b=U1ztkFviBNvWRaa8AUTKfUgzuoGdxI+qu3UNaSqUApnFN5rB09rQLdQv
   QpaUcyDWb1XHYIfJGcmIdIwubnz4kxKBM2MggolhBPM0v8aWvxawT2/6o
   Zd7iMCBzM4wkTmZhzlzfZIuvb6bQ/E57LIOqU84y58b37NshMUM3wEwbr
   AtUgWfg0kvu4Guzj9MzHSEiLpUDQvlKb1n+VZr6qHhpWk6mYISIMK6iWu
   0Q/4SI1vdiAqLSg9cnIYXaOu9M6R9zVuFdG0Vuj2nWbg0NZnKLYeRxkt2
   K9LGJ6KSop/gILVpkL5y0PxoTKCYmcbI8nW5pN3DSfv81Siu+bU8Z5r/n
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="370488000"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="370488000"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 23:27:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="757979982"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="757979982"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 27 Oct 2022 23:27:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 23:27:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 23:27:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 23:27:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3ZOkc2ChUjSkzrv1mDExuMfKL73B6qc7x3/HMcwCda9uINXXplLUUfiPvhFV2yIscndYmqkzpIJfzrVgWretOhbJkAwWGh1AbR7k5KPt6VGAQAVQ7UueGURL0obLGU5VUh36LHvh6RPOKVQJK5vF9if8nZE4r2MVVO1669carhh/Cd4Qd39aQu6bhdX4qiCfgDgAOLoFTQTi1WniXq4huYqzj0YS4keKp1a6DmtgjaeJF9vWep/kGMgDor1X9Iep1QFAuGWcOPTfhgNd5xLYK20/KrTsOosZOUqQ7PLXBp9gnwhYmBrxrOKILUh+vgTuT5otjkWzU/bT1uq23wzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0e5n3QYrPDzaCmZLkBfayMfa2WgPYbSvMEFGOliir0=;
 b=WdLhWqDu0rblXnmGu3V2kF85KJ6Dv7Kye3KHa/KroLlXZy3INlXeX9mwnLycbrXXmU2ChoLvYjwTFNXbxKgU1bq5V9HhJGrtevlmMeTYrHH9VaWDXE0L88eseuQI0IoqId+VbcT+m7CWbzGaD2ZKDFCNNCRSz0Dy+lK9ADIYzm4tVEUcxdYwAWaYYHJkaNkhxdkLXS8Ajl8gTI6HwtO1H7D/wlOiw0IBfLSXryqdGoAvd3mCCRb9eRu3StBzrRJGOMUHGmF4cPp9fzZTNi1clhEUT6rK5UdzUpAknso2X7NQ1zAo+7ajNjw1qeonsMlGDrqUi9Bvi0A0JN0t2rdTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5409.namprd11.prod.outlook.com (2603:10b6:610:d0::7)
 by IA1PR11MB6324.namprd11.prod.outlook.com (2603:10b6:208:388::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 06:27:11 +0000
Received: from CH0PR11MB5409.namprd11.prod.outlook.com
 ([fe80::4ec5:eced:e4:7706]) by CH0PR11MB5409.namprd11.prod.outlook.com
 ([fe80::4ec5:eced:e4:7706%6]) with mapi id 15.20.5769.014; Fri, 28 Oct 2022
 06:27:11 +0000
Message-ID: <aef60a35-86e2-a1af-ed5e-63aa59d7dbfa@intel.com>
Date:   Fri, 28 Oct 2022 09:26:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] drm/i915/hwmon: Fix a build error used with clang
 compiler
Content-Language: en-US
To:     "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     <anshuman.gupta@intel.com>, <intel-gfx@lists.freedesktop.org>,
        <llvm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>
References: <20221024210953.1572998-1-gwan-gyeong.mun@intel.com>
 <87mt9kppb6.wl-ashutosh.dixit@intel.com> <Y1ercgaqQwfqt42U@ashyti-mobl2.lan>
 <87ilk7pwrw.wl-ashutosh.dixit@intel.com> <Y1h8yn4QHI3aBlCe@ashyti-mobl2.lan>
 <CAKwvOdkpQvk31zbipLDPXfsDZ8FpGHs9t-+9JfFQO85Bs4h=wg@mail.gmail.com>
 <877d0lxl6s.wl-ashutosh.dixit@intel.com>
 <CAKwvOdmVJn8HvfF9WTnOAc+HsdJ4c1Tdck8E7Caky7AoCq4ZTA@mail.gmail.com>
 <875yg5xgkp.wl-ashutosh.dixit@intel.com>
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
In-Reply-To: <875yg5xgkp.wl-ashutosh.dixit@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::7) To CH0PR11MB5409.namprd11.prod.outlook.com
 (2603:10b6:610:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5409:EE_|IA1PR11MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: cf59b2c3-a362-44cc-6462-08dab8ad7207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8o/7ux5GZI7SSEGKVNhdEppWP0++8Tq4c1DUqtUkv/sZgWg/g5yZ7xJkenTOoXTrq2ghYrAHSoACzFgcsZ+f3/7ii2LJNZpBC0lgI3tXGPcftxB10YAok7q8TSjEckLtJ/oiHo4IFjCAw6TGXxu9HLJNvlOr30SmNkJrc0Em+SNwQ1GPvVY1ulzcHyD95q+FVDgSJHElvOPsMpoNrPHQ3+oR/4bFhoMwD7PD1NhfynoAohRHHT9BnAtaha7JD9u0XG6Uo7FuLP+RQLM2ArmRryuBPuYvAZdJkOTOnN7J8hp51/btScHUCQe8NjAPwPwZCekzxRc64Dq3ji8LZNSFGRI+i8ILMfbxrHgrIAtxZTP/5uZ+uw6ReN6SsY5aKmEPyn1xHsqEjD+DU1pc5gQbhVRsgqPINTDLxw1Y4dujkVuOGUbdEZupjMOutVtCf+HG/dJAjE1M//P0vGKomJ1NpHI2FkfqnQBsZpQLRxQMCa12awz1sLFf5X+QJIVkEE6ttOuNz5Yk4glYyWo3fGVdOgZIwODRF2dUbe7+WSVJfqsM+Qg9/ThcSfCH/9n6RE3IfcccTrAGKLZ0aXbXuKm7Vdd0fOidka5+gMh90JNZ9UCMTAVZ5t2YWtOSIh7YR7sQ20CV24gdDagw0Qo9IEjGfPyDHzHO6JZV8xCK7rlB5+H3uaE0NqgqpiF1RRxiKSREtY4YGQnVH185diFgbUEG0g/nDT1ekvpnTb7ySVKIQmMpiM+JuS8tzjPHJJtqrqqS6n7oUHu4RUvZFzL0CE+ImnVYV2o1mF6zLEQAQ/v8sF4tlaHCeEXzTMlpEax1esK3suAHYUYtYY6KqO0+ukyCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5409.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(478600001)(31686004)(966005)(110136005)(41300700001)(8676002)(316002)(6506007)(66556008)(6666004)(36756003)(66476007)(4326008)(26005)(6512007)(66946007)(53546011)(8936002)(38100700002)(2906002)(6486002)(2616005)(83380400001)(5660300002)(82960400001)(186003)(30864003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWRwcWJhb3VmUmovRjdvY2VmN2V3eEhkeFl3UXBaLzFBU1pjVHVLWlhDSWpP?=
 =?utf-8?B?Q1hwcmJUZzFIUXorWmgrUkZDU1V1Vlh2bU9zVDdtMUgvM1Q2aFZMeURWK2dH?=
 =?utf-8?B?Wm9ZUUtmaC9LWk5mRTcxVDJKT01RVnl5dDRXbDJhRFNaUVpOcHNYNEd2eVdJ?=
 =?utf-8?B?NmNFbXNuQzVDaitNZGl2clphOVRaVDdUQU5STS84dFRSRGVjNkhNZVdDUWVT?=
 =?utf-8?B?ZkVFK0pOVnE2RVg4VE11L0xDYUdKRmVMTldNYzlmK1VJZ091djUxRktmZm1T?=
 =?utf-8?B?akkrdnN3MUtHQUxPYWNZcWw5dnF3MjI5UFYycW9ENCt2SXJQdFhaQzgzQkFn?=
 =?utf-8?B?VWdWZ09qYkQ1RHB2RWVtSDhXc0dKQndRa2p2V1d4ZjJJZ2hwa3V0c3VwQ3pM?=
 =?utf-8?B?SS9vYlB0bDR1RjFzUWNteDlRN1RuRmxPQ3F6MUdoNk9QY01MRjJZaExzQW9Y?=
 =?utf-8?B?NVUrRmxON3doMnM0Q04zZXZicjBEK2VIQUhlQWRpcEs0Qi9iQTJ2WGtSTlBO?=
 =?utf-8?B?TkFHSTlsREdaUUpZNksvcHMwR201MW9kS2sxZmkvN2FKZDhKZFo3NWE5OHBI?=
 =?utf-8?B?NlQ2SFNkVEJpL2szK3BFeVJBSE9mdkZkdEZyR2g5MERsbTJYaTZTLzBNTDd4?=
 =?utf-8?B?clNKdUduS2V3anVXY1FIU1lNZmg5dml5dnpsaTlIaStuREVZeHZJeFQwZ095?=
 =?utf-8?B?V2V5ZUpjY1A0YU5jRXhyUHZ0Lzl1dysxandjLzJiL3FKcFBFaEg3bVB3MGtY?=
 =?utf-8?B?SXUzWkI2dVZsMENyQzlZbnptaEllKy9iRGduV011d1ZSQ0RObHFpTEw2bk9t?=
 =?utf-8?B?TGl6TktHMzIyYW9vVDdIV0F0U3R5Nk45R1czdS8xY3djcVY0dGxDSnNIam0x?=
 =?utf-8?B?TVYrblZoS205bkFPOHJEM3NmeHR5amZFS3JpMXpOSUdaRlI3ZGpWeEhhOUZw?=
 =?utf-8?B?QTRjZEp0dFlpekp3UXhXUlNYM3FSb1RGTmNKQlVZMkJWMXExekNvUUgrR2xj?=
 =?utf-8?B?RDRrZnZLWHRsajNJVnpDQUJPUlZvQWdKVmtKRUx1cXhJL0U5MVVkbVdjY2ZO?=
 =?utf-8?B?K3R6MHJ4dzBjYVpTS3RPS1ZDOXlpcndZMWRJUlZCUWRXSlE1ODVidzh5TWRL?=
 =?utf-8?B?MDhTNXgxZ3lYd2hCdkRkeU1ZamQxVjhlbCtnUURXQlJqb3NuM29NUzRpMFB1?=
 =?utf-8?B?UnczdS9kOXIrUlRxMHpkSnR3TmN4ZmxaVnljbmRDckhHZGZkdVcyYm52OGd0?=
 =?utf-8?B?TzFnaE9YTVZjczN3ZzBKRklTaU5UWXpKQllGT1p1d3JkOTBrTXJySjAzdFpI?=
 =?utf-8?B?dmw2SmpwSlk2MFYwR2tZWCsra0NFR1hQRmg0cW10allMdzhEbXhuSERQMEVn?=
 =?utf-8?B?YjEyMWl1bVk1T3VwUUxhZUJWWXVJa2w5VTM5Z05WaHA4NWFkMDlLSncwUmIw?=
 =?utf-8?B?TzZaTFdjQVVkNWpQVjU4NUEvQmtFMnU4OXZBRkowN1gyc3Iwc2Nsbm02THBS?=
 =?utf-8?B?RFZERkRLKzQrVkFLekpBNm9QeGZxM3pvQ0pXRFRVNi9BT3pzQ0sydlpVVkNi?=
 =?utf-8?B?OUFYbXo5c2szRWcxYTZ6YUl3bUFjRmhtbndaZWV2L2xrTFV2NktpVDRxbVdY?=
 =?utf-8?B?VnBmUktmSk13cVZkT05mL3NmQVZqcEFmTmo3TW1QL0xySVJlVFY3a0Q4MHMr?=
 =?utf-8?B?UGNhdWxIbzF2c21vbHIxNUZWNS96RExnTFhyNko4dHFQN1g4R3hMVENZMFh6?=
 =?utf-8?B?ZFh6ajJhdFd6YkFEMk9XUDlsaTU2QVRxemlwTUVKa0ZQOFJ2YkZRL1FPYmdR?=
 =?utf-8?B?R2tqdkIxN3JGemtnYW43eDQxSVBoY2dRZjUyM0NYK0RMUlQ1UjFoM00wL2oy?=
 =?utf-8?B?MSttU3YyTk0zSm5sRjNPNHRVQ2FGSEN1SU5IL3ZjSnRyeEluSFRtMlNZcm13?=
 =?utf-8?B?MkpYOFVRQ0ZuMTQxckh0TXMvLzYrSXVxTXZkVGtzK2M4UkU5RXNPQ3VlTnMv?=
 =?utf-8?B?ZTRYRTIyRUNVUnNtcllJbGg1YjN6WEpaYktqeC9OdmNFbXkvbGNrMS96Zkxu?=
 =?utf-8?B?VURCbnJpM2xDZUhDNGUxNm85QWpnaXg0LzhpL1hBSkgvSDJSdVlkVEdPZlNC?=
 =?utf-8?B?ZGRvYnJ3UGxieWVsR0pBRlEzWkZhcjI3OHVacVFaSGRGb1pwMVJsUitwMkFT?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf59b2c3-a362-44cc-6462-08dab8ad7207
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5409.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 06:27:11.0161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7H7mBlvGNZ8mcyzh6XQ5+dB4Z6foFvqQ0y3AVZ3Y3BU/ZKbWVYS0IAMKDw2tzqPts09p4G9ZCARxINE5xVh2aebKeZDaZyV2dClnlG0ZxEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6324
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I should have written the commit message more accurately, but it seems 
that it was written inaccurately.

If the FIELD_PREP macro is expanded, the following macros are used.

#define FIELD_PREP(_mask, _val)						\
	({								\
		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");	\
		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
	})


#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
	({								\
		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
				 _pfx "mask is not constant");		\
		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
				 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
				 _pfx "value too large for the field"); \
		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
				 __bf_cast_unsigned(_reg, ~0ull),	\
				 _pfx "type of reg too small for mask"); \
		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
					      (1ULL << __bf_shf(_mask))); \
	})

Among them, a build error is generated by the lower part of the 
__BF_FIELD_CHECK() macro.

		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
				 __bf_cast_unsigned(_reg, ~0ull),	\
				 _pfx "type of reg too small for mask"); \


Here, if you apply an argument to this macro, it will look like the 
following.

__bf_cast_unsigned(field_msk, field_msk) > __bf_cast_unsigned(0ULL, ~0ull)

The result is always false because an unsigned int value of type 
field_msk is not always greater than the maximum value of unsigned long 
long .
So, a build error occurs due to the following part of the clang compiler 
option.

[-Werror,-Wtautological-constant-out-of-range-compare]

You can simply override this warning in Clang by adding the build option 
below, but this seems like a bad attempt

i915/Makefile
CFLAGS_i915_hwmon.o += -Wno-tautological-constant-out-of-range-compare

The easiest way to solve this is to use a constant value, not a 
variable, as an argument to FIELD_PREP.

And since the REG_FIELD_PREP() macro suggested by Jani requires a const 
expression as the first argument, it cannot be changed with this macro 
alone in the existing code, it must be changed to input a constant value 
as shown below.

diff --git a/drivers/gpu/drm/i915/i915_hwmon.c 
b/drivers/gpu/drm/i915/i915_hwmon.c
index 08c921421a5f..abb3a194c548 100644
--- a/drivers/gpu/drm/i915/i915_hwmon.c
+++ b/drivers/gpu/drm/i915/i915_hwmon.c
@@ -101,7 +101,7 @@ hwm_field_read_and_scale(struct hwm_drvdata *ddat, 
i915_reg_t rgadr,

  static void
  hwm_field_scale_and_write(struct hwm_drvdata *ddat, i915_reg_t rgadr,
-                         const u32 field_msk, int nshift,
+                         int nshift,
                           unsigned int scale_factor, long lval)
  {
         u32 nval;
@@ -111,8 +111,8 @@ hwm_field_scale_and_write(struct hwm_drvdata *ddat, 
i915_reg_t rgadr,
         /* Computation in 64-bits to avoid overflow. Round to nearest. */
         nval = DIV_ROUND_CLOSEST_ULL((u64)lval << nshift, scale_factor);

-       bits_to_clear = field_msk;
-       bits_to_set = REG_FIELD_PREP(field_msk, nval);
+       bits_to_clear = PKG_PWR_LIM_1;
+       bits_to_set = REG_FIELD_PREP(PKG_PWR_LIM_1, nval);

         hwm_locked_with_pm_intel_uncore_rmw(ddat, rgadr,
                                             bits_to_clear, bits_to_set);
@@ -406,7 +406,6 @@ hwm_power_write(struct hwm_drvdata *ddat, u32 attr, 
int chan, long val)
         case hwmon_power_max:
                 hwm_field_scale_and_write(ddat,
                                           hwmon->rg.pkg_rapl_limit,
-                                         PKG_PWR_LIM_1,
                                           hwmon->scl_shift_power,
                                           SF_POWER, val);
                 return 0;



In addition, if there is no build problem regardless of the size of the 
type as the first argument in FIELD_PREP, it is possible through the 
following modification.
(Since this modification modifies include/linux/bitfield.h , I will send 
it as a separate patch.
   )

However, it seems that we need to have Jani's confirm whether it is okay 
to use FIELD_PREP() instead of REG_FIELD_PREP() which is forced to u32 
return type.

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index c9be1657f03d..6e96799b6f38 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -9,7 +9,7 @@

  #include <linux/build_bug.h>
  #include <asm/byteorder.h>
-
+#include <linux/overflow.h>
  /*
   * Bitfield access macros
   *
@@ -69,7 +69,7 @@
                                  ~((_mask) >> __bf_shf(_mask)) & (_val) 
: 0, \
                                  _pfx "value too large for the field"); \
                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
-                                __bf_cast_unsigned(_reg, ~0ull),       \
+                                __bf_cast_unsigned(_reg, 
type_max(__unsigned_scalar_typeof(_reg))),    \
                                  _pfx "type of reg too small for mask"); \
                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
                                               (1ULL << __bf_shf(_mask))); \
@@ -84,7 +84,7 @@
   */
  #define FIELD_MAX(_mask)                                               \
         ({                                                              \
-               __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");     \
+               __BF_FIELD_CHECK(_mask, 
type_min(__unsigned_scalar_typeof(_mask)), 
type_min(__unsigned_scalar_typeof(_mask)), "FIELD_MAX: ");   \
                 (typeof(_mask))((_mask) >> __bf_shf(_mask));            \
         })

@@ -97,7 +97,7 @@
   */
  #define FIELD_FIT(_mask, _val)                                         \
         ({                                                              \
-               __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");     \
+               __BF_FIELD_CHECK(_mask, 
type_min(__unsigned_scalar_typeof(_mask)), 
type_min(__unsigned_scalar_typeof(_val)), "FIELD_FIT: ");    \
                 !((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
         })

@@ -111,7 +111,7 @@
   */
  #define FIELD_PREP(_mask, _val) 
          \
         ({                                                              \
-               __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
+               __BF_FIELD_CHECK(_mask, 
type_min(__unsigned_scalar_typeof(_mask)), _val, "FIELD_PREP: ");       \
                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         })

@@ -125,7 +125,7 @@
   */
  #define FIELD_GET(_mask, _reg)                                         \
         ({                                                              \
-               __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
+               __BF_FIELD_CHECK(_mask, _reg, 
type_min(__unsigned_scalar_typeof(_reg)), "FIELD_GET: "); \
                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         })


Br,

G.G.


On 10/27/22 9:32 PM, Dixit, Ashutosh wrote:
> On Thu, 27 Oct 2022 10:16:47 -0700, Nick Desaulniers wrote:
>>
> 
> Hi Nick,
> 
>> Thanks, I can repro now.
>>
>> I haven't detangled the macro soup, but I noticed:
>>
>> 1. FIELD_PREP is defined in include/linux/bitfield.h which has the
>> following comment:
>>   18  * Mask must be a compilation time constant.
> 
> I had comments about this here:
> 
> https://lore.kernel.org/intel-gfx/87ilk7pwrw.wl-ashutosh.dixit@intel.com/
> 
> The relevant part being:
> 
> ---- {quote} ----
>>>> ./include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
>>>>                  BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
> 
> So clang seems to break here at this line in __BF_FIELD_CHECK (note ~0ull
> also occurs here):
> 
> 		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
> 				 __bf_cast_unsigned(_reg, ~0ull),	\
> 				 _pfx "type of reg too small for mask"); \
> 
> So it goes through previous checks including the "mask is not constant"
> check. As Nick Desaulniers mentions "__builtin_constant_p is evaluated
> after most optimizations have run" so by that time both compilers (gcc and
> clang) have figured out that even though _mask is coming in as function
> argument it is really the constant below:
> 
> #define   PKG_PWR_LIM_1		REG_GENMASK(14, 0)
> 
> But it is not clear why clang chokes on this "type of reg too small for
> mask" check (and gcc doesn't) since everything is u32.
> ---- {end quote} ----
> 
>>
>> 2. hwm_field_scale_and_write only has one callsite.
>>
>> The following patch works:
> 
> If we need to fix it at our end yes we can come up with one of these
> patches. But we were hoping someone from clang/llvm can comment about the
> "type of reg too small for mask" stuff. If this is something which needs to
> be fixed in clang/llvm we probably don't want to hide the issue.
> 
>>
>> ```
>> diff --git a/drivers/gpu/drm/i915/i915_hwmon.c
>> b/drivers/gpu/drm/i915/i915_hwmon.c
>> index 9e9781493025..6ac29d90b92a 100644
>> --- a/drivers/gpu/drm/i915/i915_hwmon.c
>> +++ b/drivers/gpu/drm/i915/i915_hwmon.c
>> @@ -101,7 +101,7 @@ hwm_field_read_and_scale(struct hwm_drvdata *ddat,
>> i915_reg_t rgadr,
>>
>>   static void
>>   hwm_field_scale_and_write(struct hwm_drvdata *ddat, i915_reg_t rgadr,
>> -                         u32 field_msk, int nshift,
>> +                         int nshift,
>>                            unsigned int scale_factor, long lval)
>>   {
>>          u32 nval;
>> @@ -111,8 +111,8 @@ hwm_field_scale_and_write(struct hwm_drvdata
>> *ddat, i915_reg_t rgadr,
>>          /* Computation in 64-bits to avoid overflow. Round to nearest. */
>>          nval = DIV_ROUND_CLOSEST_ULL((u64)lval << nshift, scale_factor);
>>
>> -       bits_to_clear = field_msk;
>> -       bits_to_set = FIELD_PREP(field_msk, nval);
>> +       bits_to_clear = PKG_PWR_LIM_1;
>> +       bits_to_set = FIELD_PREP(PKG_PWR_LIM_1, nval);
>>
>>          hwm_locked_with_pm_intel_uncore_rmw(ddat, rgadr,
>>                                              bits_to_clear, bits_to_set);
>> @@ -406,7 +406,6 @@ hwm_power_write(struct hwm_drvdata *ddat, u32
>> attr, int chan, long val)
>>          case hwmon_power_max:
>>                  hwm_field_scale_and_write(ddat,
>>                                            hwmon->rg.pkg_rapl_limit,
>> -                                         PKG_PWR_LIM_1,
>>                                            hwmon->scl_shift_power,
>>                                            SF_POWER, val);
>>                  return 0;
>> ```
>> Though I'm not sure if you're planning to add further callsites of
>> hwm_field_scale_and_write with different field_masks?
> 
> I have reasons for keeping it this way, it's there in the link above if you
> are interested.
> 
>>
>> Alternatively, (without the above diff),
>>
>> ```
>> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
>> index c9be1657f03d..6f40f12bcf89 100644
>> --- a/include/linux/bitfield.h
>> +++ b/include/linux/bitfield.h
>> @@ -8,6 +8,7 @@
>>   #define _LINUX_BITFIELD_H
>>
>>   #include <linux/build_bug.h>
>> +#include <linux/const.h>
>>   #include <asm/byteorder.h>
>>
>>   /*
>> @@ -62,7 +63,7 @@
>>
>>   #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                      \
>>          ({                                                              \
>> -               BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
>> +               BUILD_BUG_ON_MSG(!__is_constexpr(_mask),                \
>>                                   _pfx "mask is not constant");          \
>>                  BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
>>                  BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
>> ```
>> will produce:
>> error: call to __compiletime_assert_407 declared with 'error'
>> attribute: FIELD_PREP: mask is not constant
>>
>> I haven't tested if that change is also feasible (on top of fixing
>> this specific instance), but I think it might help avoid more of these
>> subtleties wrt. __builtin_constant_p that depende heavily on compiler,
>> compiler version, optimization level.
> 
> Not disagreeing, can do something here if needed.
> 
> Thanks.
> --
> Ashutosh
