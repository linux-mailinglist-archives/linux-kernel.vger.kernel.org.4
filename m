Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2686695C3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbjAMLh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbjAMLhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:37:06 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0503C0D;
        Fri, 13 Jan 2023 03:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673609162; x=1705145162;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3zWCepS/PjqqIlq4uR9kQQQ6flUr/KG7RcCHKr25P5w=;
  b=bTZspTfoNFfvzxAE6Gah+xIRy3StndkQjnxqzpIcxSL1au/fGPwNYip2
   StJSciZ/2x71pmq15E7j3IxJDDgHuQK3+iHq7NO1C/Tb04aTdJmEe7fgi
   h1K2Xn2/CXiNiFYM4iC5d9OrsiwOLOq7jQ8l/PtYmfUS4UutrxpTLYT9a
   DXnqQoX+wj+imLCMudFxZ+5AHCvASw1rjgUuyoAwKrIEhvWbvWuALEoE2
   4lo3R8Z8A9H3fhuLXaHes0RwWaOm/pPQKRZPHXSlK5oe+jwAgymNpZipb
   9TWUvJL9Tky9Ik6K32KVY+qGK9Kg1/5vMKkVT4rto7SXklIr3Y6jrxz1O
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="324032447"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="324032447"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="800572954"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="800572954"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2023 03:26:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 03:26:01 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 03:26:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 03:25:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQXcl9WyvTFPHE+Qdpzry7jWMNn+aPPGqrO56KQ8u/QeX6aoigtpRgap6IQZwosVO0vwIISrKT79/Jv4Rmxzdq8TNXA+2Wd72bGVgbx91XUMG9du3OxWf6/A4uH4W0qItMz2tJZ9bVRP4GL1rxxStjO0QkkiTZmuwCHtH1hydyFKEbTHmDfcOCBID49SunKEDpx6eJ/tdKpPOugHny8ZAUWAJJmU7vf/l3Dqr0sU/zviGqyV9J39z1lpKVB8GWKvgj6795dt0Y3BKH2P8gBPHL3UCbzBOdSNORmu0quVxWa+OLzB92LMM8Po0TPvdYwEOEMy2CWTxJtDMer+PvnPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/izAONncReZHFGQZeXBVEurOiZb1SgaVz8ccFhAnJg=;
 b=ai/VUNLjMKHhUU+1H0h6xIz25x5N0HbQn+IJ6g+rDt3nOxEo1d4Nye1s9CRky83Zl7m2Al39w4Wgxbmch8DY+rcfhjwJfzZpEhnR0h262tJh6adZmgjXbPb0omdgOANaWJEWrWRe09ce6r5W/R5fdMEK0NYbJmzJxKU82kExM1ccGxgCjXMggmaX6vk+bk96rcVix8X/fhQwKrNymXmdActBcdbEFyIYFraczai3hhM0cgPW9a+l/sXAblsZ6WeLDdzXC/74foFTsbl6nNCdmOX9PXeQod3UgAgj5PxaipO9SjWbu6t40AJf9BlvUmSfIBVQBHe5NX5qD7brqnnUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by DM6PR11MB4627.namprd11.prod.outlook.com (2603:10b6:5:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 11:25:56 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::a329:b6fa:2276:4693]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::a329:b6fa:2276:4693%3]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 11:25:56 +0000
Message-ID: <608756bb-3012-e02c-5b16-04314cdc9889@intel.com>
Date:   Fri, 13 Jan 2023 12:25:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH rcu v2 15/20] kernel/notifier: Remove CONFIG_SRCU
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
        <rostedt@goodmis.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Borislav Petkov <bp@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        John Ogness <john.ogness@linutronix.de>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
 <20230113001132.3375334-15-paulmck@kernel.org>
Content-Language: en-US
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20230113001132.3375334-15-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::18) To SA1PR11MB5825.namprd11.prod.outlook.com
 (2603:10b6:806:234::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB5825:EE_|DM6PR11MB4627:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d819a7c-768e-4711-6a92-08daf558efed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40t5ekv5ysGpVtu1AF89E77zHWXvqV3Hrker5jo4CGsQfBjHPnJE5RletHMmIFZQUEvoG5w1MRhJwXAYmn1neHbdkcYFDtymwr7vNiVZ8HWAvR84+2nh1Vpw8sv4sxOSaC/9Gz+P0Uh2nUv86PwnyEESeYdrbdPYG6StcxZaf4mPcfMZgdOEfK2wnl14HsarFQsl3PhtZ2T9iF7DDribKx+CHlCGKBwhDtBK62qkOjp3ijtpwlnhC5TEcfmGsCYrq5C39Sb98o5MLShxO4QDeY2Git1DQRGmLgwWsIokPYW5G5Ua9Rxe/fooZstnZ0kvd2adBNJru/FjdEffd4BZvdSHJ9wcZeQMQ/8mhx/xBwsdhf4BtmM4KE7JlHLRagqYKS9uGbAjhMIr9e94Kee44lgHsp43mWk+DZbJ+KnDGFy14KNeeq2pyZls0fkdZu7lahUdjNgqvRMBqX1bd9OxJyK3kxfWWIELVAlJUg7XajjdXpiyoV2eA/nzHJgPDzxQDBqkvOVybF9TKqj/K1ufzFzQdts97AxmAfr1vMGUiEloY3YvDx8EhD39MktnHYtOToB9kVcqTYZKZSIwaihNcWCaL2t/NCE2r+00Zsob0Ymk6dSNcj8w8SdzK00FcNMipyd2gTMz9aft4msfqPABq/Fj6c/cyPiPzrf4GfXQP02flFV8o7Tw/3A6wtAIJYISWgKU58gT5jggJvOUjgLEbnxQMOPGsCRCHtsOUl8bKkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199015)(41300700001)(6506007)(31686004)(5660300002)(8936002)(6666004)(2906002)(53546011)(83380400001)(66556008)(8676002)(4326008)(36756003)(38100700002)(82960400001)(66476007)(66946007)(316002)(54906003)(478600001)(6486002)(2616005)(86362001)(186003)(31696002)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGdhQ2dmZngrY1YyZmt2bDRjeDBmLzZ5WTdlNUJaVmlUemRtRHNKaFRJbngr?=
 =?utf-8?B?dGZSWm5UZy9oR2pzMks3VTdDWVJVaTdmRkprQ1I3YlJJZ1N0a2R1UDc2UXBn?=
 =?utf-8?B?NUpBdXNIMmpmMWdpVEs2UUxrWWltOUFkaWwrRGpueU1DbllmV3NYUXcxQVpm?=
 =?utf-8?B?YjFRdHNKSW55aGlYeUR5dmFkWDRoMURrdTNiWXBOY3ZEWnVWc2tlaHZITkxR?=
 =?utf-8?B?VzR1STU3dnlNM1lkb1cwckRnamJuVHl4TFg3U2orQm9LaUdWWlhtQ1p5cWZI?=
 =?utf-8?B?ZnRYKythRFhBRVo3a3pBNXFhMjRRYTBZWEtQdG1pNnZOdXJOOXJYUjBRNmEx?=
 =?utf-8?B?eDk4c0JLeldtaitObnhGbWFYNUVWb3ZyL0VpK0VFSlZLWUdWZ3ZuT2tXSXJk?=
 =?utf-8?B?eVpIa3V1TFJnSFd3SGNhb1FSRmhBZUtXb3liNm5WRFQ3b1Y1cU1EbFhsSUpt?=
 =?utf-8?B?dlM5aTh5aVZpZjVEU2ZzSngwMjNZbUo1Nk0xMnVNK1FzV1JCbWMxczdLWjBv?=
 =?utf-8?B?ZDZ2MFhYYkRHZkEzT0o5QU5iQ2M5LzRLamZldU83VDJlMmJtRkZUTkE0ZE1H?=
 =?utf-8?B?NHdvVnkzcnp1ZmNnT0g5V3BubzJuS05VZlBEYTNJaWJyQjh5T2hVRzV4MDhH?=
 =?utf-8?B?Y05mdjJqRWxaa3dnQnFyTFpNOWJtd1hUWXJqNEQzdzFHTFVUU21BcjVhU0Nx?=
 =?utf-8?B?eUhaT0FqR3E2T0ZJSDVyQml0anhsa1V2djM0cWZqUXg5MjlKTUtWK29DdU9K?=
 =?utf-8?B?L3ByMXZPMlBadFVEMUxWemxsejlGWXBITGRyc2JTUzloNmtMVXRyR1BqTVFD?=
 =?utf-8?B?UFZ3TmNQeFBWcW1GUVR5bHNVQjJLN0dua1dRQjlyRXhWeU1NSW5vZWYybFph?=
 =?utf-8?B?NENXb2Z6VnhGTmxsZUVhTzBvd3F3LzBFVVJOUktiUVZqbU4xRmF3UWdnSXMr?=
 =?utf-8?B?bldoay9uNFZna0lBRC9zTzFhZEk0ZFB6cHVTczRmaEdabVVBT29XTW9ETlFh?=
 =?utf-8?B?WkhMZzVjRnh6cjJoVGRXR1drWmQ1ZUtGdDZoWkdaak1NcW92cmZnWEQyb0Nq?=
 =?utf-8?B?bGtKOG9kUFdTdTEvRk9tTXFwZlRXWG1EVTdDcnprQmYvc0RTekpzS2VmY3RI?=
 =?utf-8?B?QytFYTljZ2h2T29IK25OdnA0L0tFNHFyZzlVV1d1U3d5dmRUTzBrK3RxUk9h?=
 =?utf-8?B?WTQrdGtNU2I2WTdmWVZoSHZuRkI2cTcyR2FUek94eEFNSzZqbmtnYTI2RWZV?=
 =?utf-8?B?KzhnOGROUVpaM0lPUnhnUUpOR0JTWWJkNmptekdtMDB2SzhxRERZa0xvalBE?=
 =?utf-8?B?MDJUclhIVnlqM2tkcGhMcVBCY2o5YTE4b2hxYlEyVGlIUUVKN1pGZ3B1dm43?=
 =?utf-8?B?bXdqd3V1enNJNXp1cXFqN3dDZmNmR052UUpEdzZ1U2tHV1RaNWl1dnRrT0FT?=
 =?utf-8?B?MnNrc1huSWRxU0gyOXV0L1gvYWJqRFF5cnQvajYyOUVOMHZEc2U0RzFmeFRs?=
 =?utf-8?B?aHc2dGxDRWN6WHpKdDRkYXlodXkzaUN2OXd3WnhWb29wOEI5YU1idHZ5RENs?=
 =?utf-8?B?b3VGaWcvcG94c3JJa0kyclNpQ3E2Z2lCNnF0YWlEUmJTeGsvMzBwVVpVZFNz?=
 =?utf-8?B?NHVueGVLbDQrSW9oeW92NnRvN2Y2dG5DUWphcGkwZStYTkl3d2RJYXJZQnRt?=
 =?utf-8?B?NzdNRFFDNjdUbkRzaEhBREg3SjVFR09LWDNpclEvaTJHSktPMHV1Y0Q4QVV1?=
 =?utf-8?B?cnZEdzN6d01ORjUrd1FkMldIQXBWSE1EN1V5SXVKZFk1UmMwWHlPejVjWkNr?=
 =?utf-8?B?MzhxSlBPcnU4cURpblZIREdaVVVSWEJvRDcvenNqcHorODVWNStWRUIxN281?=
 =?utf-8?B?UHdUV2JjL0s4Vzh5MWxUZFdldUY3cGdIVkhscXl0dnZTeU5WM2g1ZGE1VGk5?=
 =?utf-8?B?OWVxalZmQVErVzVkV2hqZ1dTV1p2eGVwNVhvZTFOQXZHdXFlTGpLaHpsZExU?=
 =?utf-8?B?cTFzakhlcGdUazNHR09ScDd3NGpTdmpPenRyL3pHQUpLRTN0ZXYvRmhSb1dy?=
 =?utf-8?B?L3FXNllYUFViZkhWbkQyMjFDQUR1T21EY1c1M1YyQjFNRisxL0JtZEU4Vjkz?=
 =?utf-8?B?Vzh2MDZlVHZTR3g5YWxaeE85TVBnWlJuc041SVNPZy96K1RFc2tGUUNsTnBY?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d819a7c-768e-4711-6a92-08daf558efed
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 11:25:56.1037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6DXRf9z12u0Wd9zEWDvdTRZFWpshdfr2QpsmzhOVyjrIi43ni3xJiTSkuvosteXQy6EPO3OXpb7+xG1Gz2pxwdniVJ2vNQhI2PSxbtzmRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4627
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/13/2023 1:11 AM, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in conditional compilation based on CONFIG_SRCU.
> Therefore, remove the #ifdef.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   kernel/notifier.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index ab75637fd904f..d353e4b5402d7 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -456,7 +456,6 @@ int raw_notifier_call_chain(struct raw_notifier_head *nh,
>   }
>   EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
>   
> -#ifdef CONFIG_SRCU
>   /*
>    *	SRCU notifier chain routines.    Registration and unregistration
>    *	use a mutex, and call_chain is synchronized by SRCU (no locks).
> @@ -573,8 +572,6 @@ void srcu_init_notifier_head(struct srcu_notifier_head *nh)
>   }
>   EXPORT_SYMBOL_GPL(srcu_init_notifier_head);
>   
> -#endif /* CONFIG_SRCU */
> -
>   static ATOMIC_NOTIFIER_HEAD(die_chain);
>   
>   int notrace notify_die(enum die_val val, const char *str,
