Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767F2732290
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbjFOWNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjFOWNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:13:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B020E272D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686867222; x=1718403222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=84BkT7yZiA/vwHE7ynfMldq9B9fs2L43eV+bTybmg/o=;
  b=Bhu1ArMtTzLym6unZiMx/AHB8rGEzXfB9gBnC7tXEjeBAxV3zmsfY2GK
   s3ACH0zNUI//WtDo1SusYOYbLhjOY7tPy4RML8nIfi7bHzaiP5vicqbWc
   CxbLHMb+RcmVxWooVy9nIMjDofGe6JOnOHmkoJ9ZSh4SFEz9h2rOm3PBR
   7L+71N7/DkkVjDm0f94m/nw54SIbqhj3OZ62AsZm0BE/LulUlVuGExerV
   4TEUi9yJoMxZrhWhhVaTwtQn2SmZec12Y0L5yQjOBI8Kaa43G51eSj44h
   o7EGpew+9JQYZ/q4wqRg6PUD249thecZKyM4jtskHnwf5nnstvAFAQx+V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343793294"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343793294"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="662931672"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="662931672"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2023 15:13:40 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:13:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:13:40 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i95sNdpVCf9XFR4S4FZaxfJn8ok2IdRLVvhriN9faK25nDP9MwtHp64fg4of8fp6Ap9vrWLLtovzJqCsG6xyhFkTGOmxenhsxCpSKWb62LTBOvqhPd8JsyF/qHvbCu+TUSsTARm8rxqUYnMEQFDg9jP+x8kVjdAVEQHg1k38FdqJt32gsCZZl/fwlZYue9itB3KL8Q1GZ+TIDChpC/Cf5OYlgwx/4XVzJ45wmMlOTn+VxWE1mfsC9usA4/ZcN6TwGu1T1scJ2emQC/mQ4IbjHhYcpFJwmnqmG93HnF6GwSege3qrfOCsVdYxZeg0m6pbAfue6nL743+Ktt5TqJDUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/lePUPKvPDi/4Pp0hNTkNRSpTGgMMwSF0UZIqyX6A8=;
 b=JVRO38DfRZiBHroNs7t9nkSnoIIdr5OzpyJUTSYQOlagkccwbC44EpxI2N7dLjkd6kIZQk5m1bL7VqHeVdoV/MSCe6ut+7d4OVPnKlEIoYg0C8YjsbvmpFEchdPnpQdO9HBQ7tLXVx37hDj7b1i77xvhk4QSkz8RhpWhyHQZkBNHBa0qOKPYWfgYTfq9+VUE4ig6Cz0oXYabI86be5IBUyAwOxfqbmtiKppLxwLkVVs7kZaWddqp1PhIhjas41bLwXAnuTCDJFshE1qaIuBU6ELLhBjdDq27L9k7s1VKZgEe49zmvuKKS4F1twXJ9nFXK4/vS9KCqOPNJtiV9pIhTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6367.namprd11.prod.outlook.com (2603:10b6:930:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 22:13:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:13:38 +0000
Message-ID: <c3f3ce07-3402-4cd5-fcf8-1d505ee820e7@intel.com>
Date:   Thu, 15 Jun 2023 15:13:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 15/24] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-16-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-16-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a40892-9b01-40a6-ddbe-08db6dedc50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JOVAFX/gEGfF5+JncKRCHfnObNcA/KzJUOYACaYQaVItBaSikUMxBKvFej2M0ZIeSTZDNYlgV2CpZ2r8kPei+oRIBlC+Co9foUsmCTsmIbceclEcStNrasT9U9W1J1MSnb5ze6wGeczQoEaDqys3uIowAGO09MVDRM0YEc69k8CFygJTw2SIYc6vrDCnd6B1CvTLg3OISxvemn5j09c4fZnzuZnTK4yqvpI5AJ5XtzLYhntpgzwC+0oQ/tEmnncdaM2lR6MCd08DJDtNjaL+acDEeoT5xy2ty+NcGJsSK4n51nJPdyySX/Ts8Xkx6EqLsumStHwth5rU6fTibUKaPDD3IFT7Gzwg+X022osnCrP48nfvta0v3PsPWL/2PAPwoU031tOYhdTpA6R4twC/Q15o9bdrqXB80ZRKi5KPpZXhtE5x+ToB25sikrtHi+L8mQTffX/BOS9a6aS1N4PX+3BVw4kF/fK27Suu6E6YTVObtAtXTtIO7RsxlQ+SjalJwknMk/qKQH12RDcbxk+9pmOgBxt9bSVw51rhslD7ecbHr0u7Q4xU5xQKrRALBTFiWJzSK7Z4D3TH9QbugUAf8cqB7DaYR38WQKGrR+j2erLezhFZ8nsGiF96oyjxwtYAoXCwur5LwMytwa/3d/c2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(31686004)(4326008)(66946007)(66556008)(36756003)(186003)(54906003)(478600001)(2616005)(2906002)(66476007)(316002)(6666004)(8676002)(41300700001)(31696002)(86362001)(6486002)(7416002)(6506007)(53546011)(44832011)(8936002)(26005)(83380400001)(82960400001)(5660300002)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REROanluc2cxTVdHbDU3djd0Qi9MWFBhZ0RxazZXcmZNcDVGazRjSUZLMTkx?=
 =?utf-8?B?eFBITmlwVTJpb3pHSnU1c3djWHJ0WDNXZmNETHh5Q29VNDdKMjkxdGJ2T0s0?=
 =?utf-8?B?UVRURFFKYU5CYXhxSThTemxxSG1CTC9tdjQ0aUYyaHZGT2l1R0ZZc0U1Nnpq?=
 =?utf-8?B?dlVLSmZYZTFIUWVvbVE3S2RiSXM2N0ZaNk5GQWxDbFpVOXFuSEowaWR0OEJX?=
 =?utf-8?B?OTNFYXQwU3I4ZzZXVXUrdWV6LzRNc2RCVjN6aFJBNEZLR3dHNnRHOHYwL2Jv?=
 =?utf-8?B?TDMrS3h2azlxYVZVL05jSlRHaWFhaStmYWJDeDQ2dEQzN2o5bHg1c3orWUZt?=
 =?utf-8?B?NzJoMHpUbnlxVTBCV2ExWVBrUVYzUC93TjhhWllzdlVySzZrTGY5aUxzWGRq?=
 =?utf-8?B?ZVpJaEV6WUNBTVF3V1RMa0Q2eXFDRlp6WXFUT1RPZnFnWG5FUG1MV0pwMUF3?=
 =?utf-8?B?aHJiUTZPczdYWkIxUGRHNTNtWENGMXJjVWJ5V2xCTjcwd0FrbEFpZ05UTkV6?=
 =?utf-8?B?b2kvK0FFWmkrUXBqSXY0eGJRa0xYWkU4cC9EZHJtTXBkK2grMWVlYkhlcE92?=
 =?utf-8?B?V202TDB1ZklnWjU4SjZzTFBpRWhFeXRWbUhDZnhkbTFSWFdKU3VacUlyQk5Z?=
 =?utf-8?B?YXZsbGJvWERjMzB1QldwMlJJQ0dXU2MxYlV6UGQ2NEZ4cG1LSzNvTlpzQUlM?=
 =?utf-8?B?c01GbmdZQUZtYjZuOVFrNFBrNW9KYW5vTXIrUG1EeWpoZEExUkdYbndwKzI5?=
 =?utf-8?B?ejZLUEV5dWtWaDJScXhLQm9PZ21JMTVlRjA1dVdwaGl3VmROdW5XaE1oNGtR?=
 =?utf-8?B?YUV6MTF6bHY2UHBCT2hjaEQ3cHJ0L0grekhFYWY2dG5ieTlxNlptaFJOMWxp?=
 =?utf-8?B?RjJqbzE4ZXRObXp5TkI0SEM4SzFtYmJhN0kyU043ZUhQdGNuaUNCU253Rmt5?=
 =?utf-8?B?YXJGcEVDOFo5Z2RKOHd5STVGRDVValZaRTZDbm50SlpreEhscEE1Y2Z4Nzhr?=
 =?utf-8?B?RHJFY1dxcSs2RlBqdUNiYlhpWkRoRnBzbHpsMWUyb25sQmxDQmNvQnA4TzM0?=
 =?utf-8?B?MUx1elFEN2xDSVNRck85dlJQRE9YZW91SjZhdFlpNlpiYVlKdjZsSVJoOE8r?=
 =?utf-8?B?cFJ4bjFpdTdlWTdvNHp1NjducXlFc1JBWGNEK3JpOGdRZHFhTVlYZGw1amVJ?=
 =?utf-8?B?SUIwREpPN3hnTHdWZnIydndibDRSalZVaTlWcGVOdUIyOW9jV0tWUW1GU2ox?=
 =?utf-8?B?ZlRmQUxCNG9ISzhESDZ4Q2daZHpLOWRRWlFNTnZDNVl6b0ViMHZRWFQ2U2dn?=
 =?utf-8?B?VS9OVWpNcnZFSVJDaGEyVWtYZ3dOTVpEOG03NzZzUEt2RGtEMHhvUkdYTGVB?=
 =?utf-8?B?N25VSmNmekc3WGNKVmlqQmJnQUlZdmc4S2k2UWVmdUp5MER2MFdpZHlrUG03?=
 =?utf-8?B?QkVFV0d1T3B3WVZMcndoemJNbndwQi93b3YxWnhON3ZsbHBHQWE0Z2RiNEtO?=
 =?utf-8?B?cElxdGhFVVJab1gzQmQxdVVGelh6Sm5XQWdmRzBmRVdRQXpjc2ZxanE3U0Zr?=
 =?utf-8?B?VmNMT1BHcDRIOVlqR0oyeWtWdkw1U0JyTmFScmZITWxkYkpTNGdQWGxPSlRN?=
 =?utf-8?B?MVpRVW9DU0FwakQrenlPek1VMk5PUHIwa3hEcWN1RmlENURsUHpjdWQzMDNO?=
 =?utf-8?B?d0h2NVJqbHhmMFExZGYrSU4rUis2MnFJK0lrMlRlVEdQbk9TV0V5WU5oMWtY?=
 =?utf-8?B?OVplYUlBbTdSRGFFRDZBM2NZZTBNajRsdUNnejNjMmlOSTdtc2Q2NXplQU5n?=
 =?utf-8?B?c2p5YUR2a0VJWVcvYlJoTnBrVmdGd0JtWFNnRzUxZnljZHIzZ1JMZHI1dUdO?=
 =?utf-8?B?ZFNOOUNZaFVRSU9qSVF5UEZLSHh2VFFqTWVJNmoyOXpEWHpwN1ZnMTdNa0FS?=
 =?utf-8?B?bVJiSlg2eUJtSXY2ZHdvRndUenpROGxGRGM4dlNwRFlMQzRZdHZXeEJSekh2?=
 =?utf-8?B?OXNkSHhJMnBkK3NCNGlmTFdQb3o0cW9KcEJKeE8weDdkU0ZOSitlL3lZVVFx?=
 =?utf-8?B?dHN5N2tIblVnM3hISXJLVmdtSFhNS25GWkh2bXFTK25OVS9OZTQrb1YyaTZO?=
 =?utf-8?B?L1NxVkVWMXk1S0I1bSsrZzk2NkNyck1TSkZZc2x2ZmxUYW9IUzlLUGlnYWVN?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a40892-9b01-40a6-ddbe-08db6dedc50b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:13:38.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCuHhrdFriVa4BSBh+1G1yWw+MoBWo0rdfPAURotz/4El5fYSpc1EcZPT2Th8+D+UZUKImw3MirqXY2D6Ep7sHKNp3rZQymnWcLMDvBblOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6367
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/25/2023 11:02 AM, James Morse wrote:
> Depending on the number of monitors available, Arm's MPAM may need to
> allocate a monitor prior to reading the counter value. Allocating a
> contended resource may involve sleeping.
> 
> add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains,
> the allocation should be valid for all domains.
> 
> __check_limbo() and mon_event_count() each make multiple calls to
> resctrl_arch_rmid_read(), to avoid extra work on contended systems,
> the allocation should be valid for multiple invocations of
> resctrl_arch_rmid_read().
> 
> Add arch hooks for this allocation, which need calling before
> resctrl_arch_rmid_read(). The allocated monitor is passed to
> resctrl_arch_rmid_read(), then freed again afterwards. The helper
> can be called on any CPU, and can sleep.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ----

Note the extra "-" 

> Changes since v3:
>  * Expanded comment.
>  * Removed stray header include.
>  * Reworded commit message.
>  * Made ctx a void * instead of an int.
> ---

...

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index fb33100e172b..6d140018358a 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -264,7 +264,7 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>  
>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> -			   u64 *val)
> +			   u64 *val, void *ignored)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> @@ -331,9 +331,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry;
>  	u32 idx, cur_idx = 1;
> +	void *arch_mon_ctx;
>  	bool rmid_dirty;
>  	u64 val = 0;
>  
> +	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
> +	if (arch_mon_ctx < 0)
> +		return;
> +

It seems that not all has adapted to the new type.

>  	/*
>  	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
>  	 * are marked as busy for occupancy < threshold. If the occupancy
> @@ -347,7 +352,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  
>  		entry = __rmid_entry(idx);
>  		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
> -					   QOS_L3_OCCUP_EVENT_ID, &val)) {
> +					   QOS_L3_OCCUP_EVENT_ID, &val,
> +					   arch_mon_ctx)) {
>  			rmid_dirty = true;
>  		} else {
>  			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
> @@ -360,6 +366,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  		}
>  		cur_idx = idx + 1;
>  	}
> +
> +	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
>  }
>  
>  bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
> @@ -539,7 +547,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
>  	}
>  
>  	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
> -					 &tval);
> +					 &tval, rr->arch_mon_ctx);
>  	if (rr->err)
>  		return rr->err;
>  
> @@ -589,7 +597,6 @@ void mon_event_count(void *info)
>  	int ret;
>  
>  	rdtgrp = rr->rgrp;
> -
>  	ret = __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
>  

Stray change.

>  	/*


Reinette
