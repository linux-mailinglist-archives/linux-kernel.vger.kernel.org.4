Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBE5749BD3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGFMcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGFMck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:32:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35E4210D;
        Thu,  6 Jul 2023 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688646732; x=1720182732;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uF7PYbZe3eEH/tJFvDj2iXMKWKXZqVDBFfJmXHDG5QA=;
  b=FOZ5jTYAYUHYlzbp7P3uLQN1bbdFwGEcRuQyyQwXOPNFAPV+hBIEIkpV
   KdyvVbicqXcV0zGYEY9YHMkVwBzLJ28UO8OYCbyu6FOzWxG9YXkvNJCQC
   nDtQLontebwwvkudo21MaMy8wCBFxhKN3BYHcuDxH8YDIxNDbsaPnJY8w
   kSHa8rS0Q2YAvVrL2gbYlzRUiwwBd9KGv55zwFKsgBd9r6OhpVOk8+qgO
   hh94ucs66n8El5jHHL+4/0e2B5VHIGc5WV1zCP9iabmYTaV6z5gfdxGdi
   prm36pTzPt6nIFVMCUa/et2/VAGnyJzqZGA6RZUFGhlOhn5AXYoQ12xQf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="362459351"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="362459351"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:31:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="749124956"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="749124956"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2023 05:30:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 05:30:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 05:30:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 05:30:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNdSMRpwumJbHCBuKiyau647oIgq7Z5kvN5puccH5RXlOJmsuKIP/oETgMoUv8wCb8YBzu5OKsRyP0c0VtlmmFwvR9erGKmCM7uQuzsp1sI8UtFSDY/Oa9LkpNsNlCbD9OuN3hqaXAHBy9eNSVll27TCfct6UOLMxgGC559ciZ7xzk954yAEXT9qDfml+GMFS0NAe7iGQe9wCbOVs376QlU7R64DSyqzqjpcrISRqlNUwBaOwBPzjq4OnOntBkjvSkSQKPaW/5L2KW6fe4GDrTeFRQF0lp42eVmk7Lnfcch4BNv3DyMmb9mGy92FMpGmwnmekVpk9LaNK9Ot530PAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPP0QDhBcYt8uEswRaOM/KLG8j9xpdhXv0Ff2Rtpi4A=;
 b=npI003ZgBVWBmHzOZA/ObEX5gyoiLSZoFvaxAHF9olRqICVe9cNM5fhq3WpVGaJgRYg7L8XrFEmjm4Q3GuhFTju6mN/LqTBOYAeDAj8YF4/fGpR9hNTaqWlNZsMM5Lb3Dju2PhJKOfG9+7wzjSgzL/kiBppwm2//ZPrTgex8y0mPzuQ5Ocg8XeG5tnQPp1ypvbDd07F8PIQuK2H6pJL+DY14vRpHObBcggvIAL2Y7+El56bcCgF6mXTlU+UNhBMjsa9AQq08hKfZgufWCYHtYSDPSz4KGE18lhZiUtcRoHsMh0Y0hxbnjZ+o4AuoBlGySD4BDELmXvAqrA6xKjQuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by LV3PR11MB8555.namprd11.prod.outlook.com (2603:10b6:408:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 12:30:50 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:30:49 +0000
Message-ID: <b3113f37-0e4d-a987-ce3d-56fabdb802c0@intel.com>
Date:   Thu, 6 Jul 2023 14:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH 1/4] net: emaclite: Use
 devm_platform_get_and_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Simek <michal.simek@amd.com>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230706120850.11026-1-frank.li@vivo.com>
Content-Language: en-US
In-Reply-To: <20230706120850.11026-1-frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0021.eurprd05.prod.outlook.com
 (2603:10a6:10:36::34) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|LV3PR11MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 9697cb53-f59e-498b-50d5-08db7e1cd439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0gVrjyRAQAESaBoMM9ADU41WawAYFaqDWqyJHYUgOfgWeIvLWbG0eRQaiHSAV3GeuHWD9F6S5RDFqTpzjaeKT3kXOhQeDU41uSelBpWkcs5UmadxORT2aKpJuRBizBBmSOGAewJcRNKLRUuKblmSlUeVt+CggNdi7yjkjN6B6Ro4JLVceAeeDlgC3BiisaGKSTlktqp1Q+dusRETMVLP+R9+0XvtNsCFepPotRiLjxmdbYNMmKF3VRTEXY14ehQir8jURvilYT7+q9mkfUxFLbHreAsxKf8mEBTY02uy0hUq8hQTNncUlXmUe47DeT/heUxYZilsoZl+rLjubQUZHEFo/ee2vz1W0trYX9DyZ6jt/lxSbUwqLAweSLmN4J2Q6gTTuP0F39RsC2ocHP5YfrYRNlBINC/9syQTb9l6Qp6KYpRevhc+D/VSV8BEJyfAk0Vv2fdfzy6l0YdtB75gd3L81lgr4wPlLrXrGdh1WUeBAAxoiUH7jOsLLdGtXOM/gL13pQ8tjqZVMnFSxcye6sVtDFt62TZOUZj1AvXlRMMrxwm9Nrc+y/UkswRoNPe8q06M7USMlgWU9b3n8ZbEdHevy5ZYILApgqOljbBM6Q4cwBAScoT/0eWa1CPjujUuiHJMso/Kc4gehCAyIFNtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(2906002)(41300700001)(8936002)(36756003)(8676002)(186003)(31696002)(2616005)(31686004)(6506007)(478600001)(5660300002)(26005)(6512007)(82960400001)(6666004)(86362001)(6486002)(316002)(4326008)(6916009)(66946007)(66556008)(38100700002)(66476007)(54906003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjZiK2ZrSmY2dDk3ZzZjS1QyY3ZheitsaUdvZEY2NWEzSnhUZXR2Y0lsaW1m?=
 =?utf-8?B?S01sWDVySTBXaXpGcGIxRmY5bFpJTGUwd2R1ODYwTnBwTGJXak1CQmtYblBM?=
 =?utf-8?B?QVF2d2NTeDJqUkpHT0lnaHpIbEpyaHpDM1c2VGR4cTRiakNGQ2JGWEtXbE9D?=
 =?utf-8?B?bXBtNmtVRVo5OUdBbXNrTnB0VDZmQ0NPMlBjNTlVcFVLaEJMeExBUVQ0V0x6?=
 =?utf-8?B?cGpWZVplODVyc3V1STVod21LZStCeEQyV1JsdWZJQjBma1lZaThDVG1XbVB4?=
 =?utf-8?B?aXZhRTZJSUlabkxIQXVLTUJGYlFWKzh1eFowZUk2NEVzSTdyZUVLVHVEMFBM?=
 =?utf-8?B?NllZNEJDL0xwbWZPS0laQ0tFTS9yOFYyc1VUeHhDbEJVSTEzZmlMZjhNdTYx?=
 =?utf-8?B?RFpMNGg5SXkyQ1ZRTUk2WTlqTTdYcU1BaXdISmN6TGlwbU05L1hWVHVack02?=
 =?utf-8?B?bkV4OFVCZm5lRlVBbkgzWHJYMFpWT0Z5NXppNThKQTEyaEJpQ0tlVHN4SGRE?=
 =?utf-8?B?bXNtam1qR1o4aFUrSkhtQzVjaEZscDFIR2VERkhvQXRNdzk4STdEaVdwajFJ?=
 =?utf-8?B?NThwNkRYQ2N5S0Z0a21OSG9GVFNIbVBZdGdFVlJGNWhuL0I1OGRzYUdIbWo4?=
 =?utf-8?B?QWJpWW16L1loRWZtMlZsc0Q3QmlOL2pTL2JEZ0VhZnBlbzh0eEh5NExJdDJp?=
 =?utf-8?B?cE1GbFQ3ZHM2TFhQcjFNc3ozVWJvbFhQK3J1T0JQUWxraUhkRVhGSG4ra0xp?=
 =?utf-8?B?dWdNRGNyelg5S3crU29IK092cUY0blFWc3kybGJrUmpob0FKMFVnNm1iUm81?=
 =?utf-8?B?bXRnZUxDSUptUHM3R1lZZGJMd3ZMSFpZVnpiV3lva2dJbC9HY09wQWVsaEtR?=
 =?utf-8?B?YWlFVCtEQzNlUElCbmc5bW9GbnNXNEtHcytVZGdTallJcWcrTzRpZmYzVHUv?=
 =?utf-8?B?MG9WRkR1OGROS1Y3STF0eTRYY0Fqa2s4YndZcHdCU3grUzhjTFBiQzEzYTBy?=
 =?utf-8?B?dWNJQU1ZVE96L3BtUGluRnZqdlQzS2FpQXpIT29uK2hwbFRXekpSZVVlaDQz?=
 =?utf-8?B?OExzZzhXMVU1ZkY3NXQ2Q1prdjY2VThGK0ZCY2xNcWxlUGpEZjJrN3JLRUpW?=
 =?utf-8?B?Mkp4VHhxNUhGb3Z2V1pvRzRBeU5JbHhhcCt0QUIwV2lkOEU2OWVUWHdhQmpP?=
 =?utf-8?B?U0FPM3RjTFdzL2lBb1lGZHR3ZjUvaURuWEhJT1ZQSmVONXhvc0NNZUlUcWRL?=
 =?utf-8?B?b0kxQXpiUFdCbHNRSmMwbThEL3VrcnI3Nmg1eG5BczRkYy9BNGVLcnhldVho?=
 =?utf-8?B?dmhKUDF1QTdhWW1wc3Q2Z2JYQzE3NW5yazFvOXhxY0QvWVBidERldVl0SlJL?=
 =?utf-8?B?ZzNWYlViZXdtaFN2aGd5L05uUnBYcTN4bk54Z1o3T0gwWTNMczJBZXNaZkdo?=
 =?utf-8?B?S0l3WmZvYmZ5aW5rL3VkZ3lNRUFVOUdIcDdZTFJXbVBhTTBOU3pXbU41TTU2?=
 =?utf-8?B?Zi84c3J2VDdTRlBtL2Z3UHRGYkd2TmtwZGwxWERIa3drMGt0WXlSZ1ZZRlpP?=
 =?utf-8?B?eGdOckxwTTFxanB5ckxPMUFnU0NrQ0VYclBrYTVHVEx4WEpBRWNKT0dRRWl4?=
 =?utf-8?B?dEY4Tm1XT0pubmJsYWptZzA5M1BrUnVBNlFYTEx6SFliaGFtblBoY21RUFNu?=
 =?utf-8?B?UVlvRERmK0ZRa0VOMXUyK0VPbUsxN3VjT0VIdFd0MVJaYU9ESU16dDhEQ2ZW?=
 =?utf-8?B?VFBxaHZXblNCZ2Z5MkhSRTR1ZGVuRlRpL1Uzaklwc0piWE5lcUJmNWkxOVVE?=
 =?utf-8?B?L05mNXdhQXQraUZlWm9sWVpWcGwxVE1pUnhnRm5iRXFab0NyOG04WkxXZlNZ?=
 =?utf-8?B?RS9leUJTTUErV3p3T3YxQ09XZ3lIYkU5WGxRRlh4VXoxZjNVK3lRcGFBQ3R5?=
 =?utf-8?B?LzBJL0k0UEhXWFZ5R0s0Y0FVUnZGTE95WitjVWVXeFdnRlIzK0xvT1IxVTJz?=
 =?utf-8?B?YTNpWDAzMW9DQ1hCVy91QXFiVkNrVy9BTVZaQjdoNE9vUHhOM0czeDZvOWpw?=
 =?utf-8?B?TUw5UDlleE5EdkJKVWYvQy9vYXNYNXpDeHRRaXJVbThSb0ltME5QTTM3aDFl?=
 =?utf-8?B?a2pMUFlBcnk4WkpxMEpSYjF6ZXlsRDJyd1FsaXFRTEdwcy9xcU56dFNqejFY?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9697cb53-f59e-498b-50d5-08db7e1cd439
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:30:49.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F94sGH95ZT7r4SThvl124oHYzY7wifvmjYX8HDse+NLO4PCdzBJUkvI5WMHagURZVPY3bBTHSldJUqjR0RXMSgGVIpGjMGWzO4MDCvGskdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8555
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank.li@vivo.com>
Date: Thu,  6 Jul 2023 20:08:47 +0800

> [PATCH 1/4] net: emaclite: Use devm_platform_get_and_ioremap_resource()

Please clearly specify the target tree (net or net-next) in the subject
prefix. Since your series is cleanups, it should be "PATCH net-next".

> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_emaclite.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> index ad2c30d9a482..3cba947e4cbd 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> @@ -1114,8 +1114,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
>  
>  	ndev->irq = rc;
>  
> -	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> -	lp->base_addr = devm_ioremap_resource(&ofdev->dev, res);
> +	lp->base_addr = devm_platform_get_and_ioremap_resource(ofdev, 0, &res);
>  	if (IS_ERR(lp->base_addr)) {
>  		rc = PTR_ERR(lp->base_addr);
>  		goto error;

Thanks,
Olek
