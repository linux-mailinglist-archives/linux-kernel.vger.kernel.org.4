Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B915A6D2BAB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjCaXZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaXZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:25:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEA9F745
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680305147; x=1711841147;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aNCzOzUaSM5UC8frpYivD0I7+1czNGH4jEmt2dW6Hr8=;
  b=EBoGUIvtWzfZ7hJ732tORbnEZmvEHpuqPkkkebZht8BaFidJpjXNeDbU
   T/2JUr9uxc2OsPH2B6cHq8rBpPQbjp8cshIu/0U55C5V+dAqEgn9w4yJ2
   ugAXi9TiNTGcSoGl2MbZoE3JrCzcbVEahWcT0WsXdMIEGpIKzNNb5HDWv
   qeSlzi4JFdu6Y2iK/8UEuIEA5jk/XLhN4mzgP+ouExOx8SAFkwuYgrE7j
   K825YSqR3N2Xr+DhqtkUyKk0hc7ivpGXMjSCyu6MylPbmg8mmwTywuuwC
   CwhCLNC32fr/CRm5grf5nC4T0Rqf4Ab2NQ49oCx929rqvxD8hLpgiMSu8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="369371253"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="369371253"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="809199357"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="809199357"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2023 16:25:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:25:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 16:25:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 16:25:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0a86sVhCdNy/M0XC4yj5ajfdofa7y3ZJizYDw33XpbC+XPOPOQHQQbHQGt5FYs3LOh9aaZaVubTTqNS9Fv8Oy33oc4LV/KxONTKJbe9I1S2GYY8QMp4pU4vwD/MXmBHIPUtVL3ehDLzdNks4rae3zqKvxfiSxrS/cWqmFEeThQyhoei7P0QxHdSCVHcr1FI8Ipkb4siQ8QqMRdxWI9rKiz/IGPDuRwIMTYT0dmF1KcQMeY6gceqlTcUufFWO4uVupupnxMAFPXrNqjYVimWjIIzSncyAGCUIMgmfpDiUpQqvTav4dbZ0FBHPwgS4SMopuWsRIeighmDxBFHAiTXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MF0OFXYLiNtCoLHSyVDqbfOGEi4/lg9IdyxGJAPBigg=;
 b=nApLEwH0zsqX/qaEF9uY/lh+a4Xbx71AyIHdih58yLDhLXYtumceK3hxv9L8o7JvkcOOH7w+myNSzeCcCNROcDj/LsmvdSsGfB65FUOYsg2ILqfDGvMBkJV8vqDw663wYSmjiRHYYsAh4IPDMtkAnapmd4OFoFtBNz07vtgWIvZGYkOolsCynaY6cHlbi1TRLj9Hl3OKzNitX52W9Zp3PhLlgYiLOthQThJoDX+6dphp46SViQ0Pg6lic0UTaoOeVe4VAQ2FPSUA6ABVcl0in329g76pkmMCZXwmEocFqqte/EAiwnrMBfBGKYKpA1cd51inYi5wEsqUUEsHHc5t0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 31 Mar
 2023 23:25:43 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6254.024; Fri, 31 Mar
 2023 23:25:43 +0000
Message-ID: <5e6a2e0a-6f31-c9b0-5eec-346fd072d286@intel.com>
Date:   Fri, 31 Mar 2023 16:25:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 09/19] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
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
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-10-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230320172620.18254-10-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::23) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: dc59abf0-3911-4b66-0ce2-08db323f3f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwE1zXtXvFPv+pn+3g2AZwRKClCQU4B/96u22NxxPYEayr02Sq5thaqmjxZWWOG3+OjYksEhbTVFzhF5wAWTNWHcO4I4+0zot+wyL+y4S3Cw1j0QFaXRWwDOsyyAs/bzGVNS6Pfig9pjEoF/linL38vLAeYtSm39pVt+lN8tUjyM71rxOTTv4NyWQICcT8ldSjcdgI4kF6LbvdP0Uc1pv1Eq6YBW5KYSphfT6RU3ewilWrSLxLpporW+PfHmTlAdjtHHYJqwDAoX8UnAkF3pnf8z5zRm83TPOSOE3P5Ks/NVFXal21NJQ4zR4CUrxcTtyLz7o7Y91HRUuRI/B0ujtkmJZ6jT28/boZFDmuOdv0hvQ2cRxgegcoo6dNr9TTbLvn1ExB9oQbUesQpJ1ttA8xqNcYi0vNQpnguGesrLZ0o7oRCwNA2KBHMKREsKkla9L/rSrsMsoppYK9FTTc7wu/djssyEuevCWSXkBJNIHpwwinP4yJwIy+Re8VyzTD9DwP9ayhVYH9llqJQ+ClRDFs/K5N8uR90JjVptz5GYcpcjmem41hmB2fn1aTdejtZmlFfI7SBYJoe8Y5AJwC8E5L4eDEuIWd9zcbS0dDS4SBDo5c87fdVy5+bFw4OqX56aWzUPANVcmq/4brl0DWccBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(36756003)(66556008)(44832011)(7416002)(8936002)(5660300002)(2616005)(478600001)(8676002)(66476007)(6506007)(4326008)(86362001)(316002)(26005)(66946007)(31686004)(31696002)(54906003)(53546011)(38100700002)(6486002)(83380400001)(82960400001)(41300700001)(186003)(6512007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG1TREc4MWZFU1FRbHpZQW9tdlVSSEhZRDNxblFtakNBMGloVlkra1VKMlhD?=
 =?utf-8?B?SStjWUNjeXNLQVhtdjJPb3ZMNkphMng1ck9WQlhpZjV0eDc3RzVQMFlDQ0dt?=
 =?utf-8?B?TUtQMEk3TFpnN3N6OEhkVWdXRVNjV25MUGYyenZHL2d5OW1EUGZwem96S2U5?=
 =?utf-8?B?cng0Q3U1SmN5azBHRVRGbnpNQXZydjBIdHd2S1k3U3lOKzRQU2hjY1dsNkMy?=
 =?utf-8?B?bUgxeGRPTjl3K2xVazNBSFQyd0lXL2FJYlRUdHppdnk5V2FLM3hKOXgwQzBR?=
 =?utf-8?B?VXVzU2dXZkJmQUNSaFVGeFBBZWxYeHFQSGVaYlNVaGJaN1lESWdJWnBwQnlI?=
 =?utf-8?B?VVUxdTl3YkY0LzgwZXY1ZElDR3ZmR0JkcWlnK2NxNkxmWTJrQi9GakRBZ2R4?=
 =?utf-8?B?MVRaYlFoQ0hVQ0tMRlhVZEpnVEoyZWQvZkVJSjdsR210d2RkMERqT0w4YjQw?=
 =?utf-8?B?TkFlY2JBOFljOWEzSkJ3VnVsWmdIak1WMjEydEJTY0NPMlhGdGZlSW1kRUxr?=
 =?utf-8?B?bnJoaTROdzRBSmRHeWx2RnJjcnlZK0Z0N2ppSDdMRnoxWnJZUDVtWnZVbXJV?=
 =?utf-8?B?SFdtL2kxb1BJd1VvYitYTExYOVMybHR1WjhpdldNamdoK0liaEx4U21pb295?=
 =?utf-8?B?RXpMclRIRGlQQkw3UFBiY291ZDB2T3lpWVpQUmsxNmo4RXViRk40Rmt4U0tK?=
 =?utf-8?B?VGttZzdlSE9hRGZvd0dpT1R3TE5WNTNnWFhQYjhrdENhaWM5TThCdDBtWGlW?=
 =?utf-8?B?Q2taRndzNFJBN1dwLzRXVFEwVHgzejJZY1VJSUZnYkt6NS9LTVlock1ncGdI?=
 =?utf-8?B?YnVNQXZUMHppS3pXclBKNWdpcnFRdC9BVWV4MHFGOE9FczNGS05EZDZEMHhB?=
 =?utf-8?B?cnE3QVhwaXVGSkoxem8rQlNlWHUwZDQ1VTdPYjN4MzQrLytzT3JDYnRyQ2dh?=
 =?utf-8?B?c1g4bEFjRVlZQko5NGVxZE1QTTJhaWhRb2lXd240MzJHbzVyUzhrZk5PUS8v?=
 =?utf-8?B?azhiUkd3UVBQMWpqYlB1cXNFSmp6WTVvN09ObE43czB4b29jdVJuUlEvb2FR?=
 =?utf-8?B?WVUreHZBZW5DZjllUWZqcDczQi9zMzluYk9wODhsODJZZVN4Y3B1eExvWHd5?=
 =?utf-8?B?Qm84ejJOa0M0Uy95cmxDSHhFVG03TElVUkU1LzJOcGEzR0t2TVNPalcybHRB?=
 =?utf-8?B?NmI4L1BOUGdFejcvbWJ1YU1QcXBqcXZPeURRNFd1cWJPVHB1MGo4VkNCR1Bo?=
 =?utf-8?B?dW9zTHdsb09HcWpsTloyaGFVZUxEcE9JOVAvT0VPL242U3pIeitVZE9JQ0NV?=
 =?utf-8?B?UHBuR29qakNnTDIrQWQ0OHZ1ZVpTa3V6Y3JzTE9NQnNwaDFja245RHNHV3N2?=
 =?utf-8?B?NU5ZMTdFZXFBVnlnUkdzNUdDQzRoa0tRN2xhemRvODNjNmhwdGtpYzZHVGQw?=
 =?utf-8?B?T1RobWtKTTYvc1Jxc1hhdStFRmxhSXpSSnpnWGYwNE1sZjg4MzhYODEwYTdh?=
 =?utf-8?B?N0haUThlb21SWGVuWjMzOGhhYkVvbFZPU05Ic3ErR1l0eklvMGgzWEZsUS9U?=
 =?utf-8?B?Tk4yNjUxM0NJZHdSbUhXZExoWk1VYlY1b291SVNjNjRGcm5vdHpmNVJzVTZR?=
 =?utf-8?B?SThBR3NsSm5zSVM4WjFHUzlOakhCTDNhQVNrZktUc1krS25jK1I1dmFETGtS?=
 =?utf-8?B?cGdHS1BUWXpVYjZOVXFXZUNCSTc2ZnpDNXNCNlhxMnFld2o5RzlOWkh0bTNM?=
 =?utf-8?B?T2xmV1JYenNhVy9Hd2JCUUx5N2pVQlY2QVoydUVMSjI4ZzhOQ09VTmdZUFFl?=
 =?utf-8?B?VEdlQlNFeFA3M25FbUlrKzVsUVZhaWpjZW0yekpTMlhCWjlkZ1RJYTAyYmtx?=
 =?utf-8?B?ZFVIMkdRaU1STldQN3diUmFkVmNFTmRPZmJxYVhRWjdJRDNJYUFXZWtwYVIw?=
 =?utf-8?B?cjVsRkpMLytJNnZETWVYeGR5ZEVZL2ozcCtqVUtuSXQyNHIyRm1sV3Bwemky?=
 =?utf-8?B?UWgybjNQS2krUWd1My9qTnI1UmhpQjg4VVloLzUxVE0vZVBMSkZVcE5hMW9i?=
 =?utf-8?B?Ui9LSlJobUcxTVFLSmhqa1Fnck1FQ2ZZbk1uaTQzYndpcmRqZDNCNGV5Y3JI?=
 =?utf-8?B?Z0dWKzZmYk1zRkpvMW13aGZ5eVRqL081SEtQemtzMkJidzcvRUp2Rno5U1Jq?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc59abf0-3911-4b66-0ce2-08db323f3f56
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 23:25:43.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHyGqhFLm+5FqOZEI+A0ouclBK5tOGbN9ObjAxtnGl0R5klNDiNzF0X0iU8vJF4KUxEyouWK1w2bIwJP4GfEIBkgXksptzkAgOynhOJ7VJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/20/2023 10:26 AM, James Morse wrote:
> x86 is blessed with an abundance of monitors, one per RMID, that can be
> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
> the number implemented is up to the manufacturer. This means when there are
> fewer monitors than needed, they need to be allocated and freed.
> 
> Worse, the domain may be broken up into slices, and the MMIO accesses
> for each slice may need performing from different CPUs.
> 
> These two details mean MPAMs monitor code needs to be able to sleep, and
> IPI another CPU in the domain to read from a resource that has been sliced.
> 
> mon_event_read() already invokes mon_event_count() via IPI, which means
> this isn't possible. On systems using nohz-full, some CPUs need to be
> interrupted to run kernel work as they otherwise stay in user-space
> running realtime workloads. Interrupting these CPUs should be avoided,
> and scheduling work on them may never complete.
> 
> Change mon_event_read() to pick a housekeeping CPU, (one that is not using
> nohz_full) and schedule mon_event_count() and wait. If all the CPUs
> in a domain are using nohz-full, then an IPI is used as the fallback.

It is not clear to me where in this solution an IPI is used as fallback ...
(see below) 

> +	int cpu;
> +
> +	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>  	/*
> -	 * setup the parameters to send to the IPI to read the data.
> +	 * setup the parameters to pass to mon_event_count() to read the data.
>  	 */
>  	rr->rgrp = rdtgrp;
>  	rr->evtid = evtid;
> @@ -537,7 +543,16 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  	rr->val = 0;
>  	rr->first = first;
>  
> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> +	cpu = get_cpu();
> +	if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> +		mon_event_count(rr);
> +		put_cpu();
> +	} else {
> +		put_cpu();
> +
> +		cpu = cpumask_any_housekeeping(&d->cpu_mask);
> +		smp_call_on_cpu(cpu, mon_event_count, rr, false);
> +	}
>  }
>  

... from what I can tell there is no IPI fallback here. As per previous
patch I understand cpumask_any_housekeeping() could still return
a nohz_full CPU and calling smp_call_on_cpu() on it would not send
an IPI but instead queue the work to it. What did I miss?

Reinette
