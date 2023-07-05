Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E99F748BF6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjGESfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjGESe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:34:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB90B12A;
        Wed,  5 Jul 2023 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688582096; x=1720118096;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5a0pZh/ea8LxoD2YSQN629hD1xo9IHcLM4GIS+YXGWA=;
  b=nS0ohcwlDGeF/y7AyWHfZCo7hF51d2WxHadHDGtTXR74AQ7vsxr7eedh
   /v3aCG1Bov9Q9szrQ4Jq8GtsRjp9Hj5bhEnYhMWWzFkT09AA1flTnNw04
   2bPip5btEAwODPElI1yy8Bbwlun1V5NDFi7PH99lTFqX6kvx/yoUPQ1Mp
   urQYrebRf+/scU3zBi+jx8mEWIXSRF3oWg5PHwBi0HC2ryY8tHqTh6K1G
   lpj+3Qn88CvwqJCsgJ2XDabNCFONtLaU6Km+baw6uSLCFKGcHD+piurGy
   Qymbfj3+XxELP241zcyXH6ECUXI/NUsTF/xsgfvFMgGFXJvJbryWSHOck
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="449779976"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="449779976"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 11:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="893284956"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="893284956"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2023 11:34:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 11:34:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 11:34:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 11:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALMt29gUR4QQ/PQgOT5+s633atlvFGJcR3+RYrHep1xlANCtsECliuGyH2tgXVVfvkqjuxSvg+swf+kw7OMFRtINQWiUWGyVbI2CBaRFBinBrukmdG96hJvGKb3GQJdbYaMgGgDwW1JCf2fXgbfcmxob2g7S3G9gj8G5+8ILxjkliM4pGXye6r57Nauwo/tMI3IOHmUaS/kWTyZKNOA2rkxqe0lZ4No3Es9rwG7b+Bk6YhqwPyT0C0timsDOz4ClWldgpQ+E73okXHGqKO+sbrKHzVN0ggkUs/LUgV/5eES1gEgJAvykrEjAxNeFAaafdQArY+dmkfvUNzH17JaPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shBNn8Y6Dul1Y9ZIPOoJ1ctPCO70HAGRBCXCPeObCRM=;
 b=PepNKFuGe2mGFDUdvTzBLN1fpNSsk4W2wZaS89QzEuMA32f1nc7AcyKEhltLM6KUJYSgL+a+cjaDWxPZB5rU9aAUW7s8lVsJAMgGfBuIfU4nYztRn7GOuLYgWzF+Kv1byf7X/V2uM3MT6lRnhhBwO+1a2KXobiCXS29cuDUbh1t20RnMdLn43a3AZoZnZTP3TUExtFIcNsFboVvEZpzvdw8KGZkDge4FFS+IonqIz6Ll9ZaPStnGrZlbdKgn9ugTkdn5Tve3IRvyBoWO2xOo+MOZxdU92XPhACJy3e6dWhgu9g9Bw/jzq6JshVMt5k8ZmkPVmKV6HFtdVvYoYKi5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 18:34:24 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 18:34:24 +0000
Message-ID: <249aa741-4b1e-ebdc-471a-3e5a634fad32@intel.com>
Date:   Wed, 5 Jul 2023 11:34:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH] ACPI: NFIT: limit string attribute write
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <nvdimm@lists.linux.dev>, <lenb@kernel.org>
References: <20230704081751.12170-1-ben.dooks@codethink.co.uk>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230704081751.12170-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:a03:331::6) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB5550:EE_
X-MS-Office365-Filtering-Correlation-Id: e460b63a-f093-4024-53a8-08db7d8674ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwStSvr4C9OiHPTpIOYQsbNvFixt2992Qs6/Eg9DmpA1zpQw3wycxWPFCYjX1g23qcRHK23NuPwAurDlCY9t704oQ0vB200U2T5LK83nWVK1V3cvUcfiAZ+KUhCYKoUPeNHDLlKTzPpNdjwiJ4V+70IcCkdIe/K6Ab8RGt4hW91ZbAouxBz8FbCwtU1WnJafdRB3HYWRsbxaYmptP1wO4ujMhrV5q9XZCVoQZ3s26x7Pr/gs76C4ZY1ZhwqSoAlgEg21y2Fx6IUGcrdqeK6/+tLc4i8zTBzis7oL/K5MPMZ/p5nXMeja51xenxUzvWRycNsl6Mxg7JZnGc6uD3QtGcph1Zhg9suCYQa46HQ14onZ3lkp/A/ELGv0Lq8d1Qpn7sxcWVrbrfdpIZmuVu+sAjkNSDPW5iliG8Z2Avh95OhuiHbMIT59M0wxIGM/qJMOI7eL4XNDMx/Jrhzzmlf0QDwL8nOPQ1CYmeD+oWiuqyhuMjWP02eYK2RsWyvnrUtWNh7sY7WtZd4BI5QfZNaClU9zVJhUra4nXNb/lom9TSaWW2P85+6VjDmAP17Rgt7IHnoY77/cj7cCPwt/RU673/wKNmxPn3r8dRA31zGjGbyVlm5iDt96v5w2WgkRkw+0yxQODi+3UI1oetFOvH2PFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(66556008)(82960400001)(6486002)(6666004)(8936002)(478600001)(8676002)(41300700001)(38100700002)(66476007)(4326008)(66946007)(316002)(2616005)(186003)(83380400001)(6512007)(53546011)(6506007)(26005)(44832011)(86362001)(31696002)(4744005)(5660300002)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGE0UGRXRWJrMTlCWUxZVFV2akszM1JYamdaUEs3aEtOcjdmMk5DamFXNFBv?=
 =?utf-8?B?WlVOOVVia0dFMjcwWE42Y3RxQkltNGptZmhKUEZ6OEsrcVFxZzIxY215Y2k1?=
 =?utf-8?B?YVZEZmpzeWlxa2NBYjVWYWRJbytGQyszZmYyNk41cTZ1bUJMVzRNQ1QzTXFV?=
 =?utf-8?B?NWhxbmJlUWY0SC81ZlFxeFpucUlId1JrV1lDQWVydzhmUlZ0YVJOTzJOdGM5?=
 =?utf-8?B?WlR1cnhYQ2RsMmd2YmZuRnRjV0g4TU0xREJvcElGZFIxOURHdDI4bStwVSt3?=
 =?utf-8?B?VUtDM0drdmVTOHpQKzRDajFONyt6NmJobWFHNmlQTkdubnJVb1RzMjhBRDda?=
 =?utf-8?B?OVV4U0JNWkhRSTc0bXQrRm1yVmwzMGtYV3BVUFFCajZhNGZScFArZi9NUzkw?=
 =?utf-8?B?N2xEZW5xMTlZM2FHcTd2MW5zZnV5SU5WaG1laEgvQXowbTVGZGlOdUw2RWhH?=
 =?utf-8?B?WTZ6UlBxaU1BREt1MkF0bHJERGQreGFCWkZJRmJhZXFQQ2J3UDVvekhJcUhs?=
 =?utf-8?B?Y1p4REJ0bnNENkdmTkNTdWV0N0hSZEoybmZ2Q1VvQWdydkxoMHdFWmVBdm9W?=
 =?utf-8?B?M2NqRFJiMDhwV0xSVS80UXhkOTdjUzFWQlRFVWczeWdaY1pZUlZ0WEtKUmNM?=
 =?utf-8?B?WUY4L2IxcTN4ZnJZV2Rua05uUVAwS2x6THdWY2RSR1hadFJkTnRYamFxZmVZ?=
 =?utf-8?B?cDg4eUw5dXowZTlyYjU5N1BwVEgyWEN2Q25GZG16SUd5cUhxbWJueWY0Rmlk?=
 =?utf-8?B?eTJRU1JaRFFKaUtrMmE0WUM2dHdueGJNWmYyL0pRSXhmaGZpaldqZERUMWxH?=
 =?utf-8?B?SzExMlVFaHRLM1N3SkM4TFNLUDIrUktWTStSWG83ZXlPcVlibjRqZjR3a2hV?=
 =?utf-8?B?K2E3d2RXY0c2OHhsODlxemJ6QTBsNTJGRDI1QTdGZC8rdjZ3V1NJVjhpSkFY?=
 =?utf-8?B?R2FzY3drRjJNNlBtZWxMQy9IYVprNUxodnQzWnRTL3FkTlUwQ1g0V01WYUtG?=
 =?utf-8?B?NGVMT0xrQk9yMTJzN01DcUlSdEUvVkx3RnB6TVpUaUt6UFdaUVg3RVVQYTJP?=
 =?utf-8?B?d3pFeWlsb3c0ZDljVnNSZ2d3SnRJVTEzZHpQbENZNkNrNlBhZ001a2ppUmVZ?=
 =?utf-8?B?U3ZVSnd3WjA0MFBCQVZ3bWE5OE5KRlhLeEpiTE42RUowelBUcm1PU1gzVms2?=
 =?utf-8?B?eHNWQ2hna2ZvREhNeVVZQWY1dlBKQWZ4YVpUNnBaOTBXQ0hpNlVqS0VQeDl0?=
 =?utf-8?B?Y1c0T3lvSlFBcGN3VjNDQ1dXTzcyc1MzODUxcGdqUy92Z1NQMnNoS1VmTCtl?=
 =?utf-8?B?b2c3SENpTVZCT1VWZ2s0WW1XMEVTZk0wQXdTVk56V0xFYUxhYXU2UzNFQXJR?=
 =?utf-8?B?aTcreVJGSUR3UzBROVg2RHJ3WDRMNXhQVHJ2TmVZVUVCMGVOWWUzVTQrVERW?=
 =?utf-8?B?MUxZemNmMVBEdkxYVVlHQW1UbDZLcE1ZcDRqNFBoS0dmZ2lCQWxId3pZaTkr?=
 =?utf-8?B?dklOZHpKNkN1L1NncXhxRnBxdmZNMm0vM0Z2bmNla3lHQkNwRXhyb3hzZUpI?=
 =?utf-8?B?QTRkY25takJmOGY0MktLT202aEdHV1ZiWXZYNDNWVHhnMjZKNEJlcWRBVDI3?=
 =?utf-8?B?aGtQYTB4a3ZoZkFQTzh3aXFMc3lRZE1aZHg1RDZVRmxpTFZ4T29xTjR3bDlL?=
 =?utf-8?B?ZkVva3M3MEdya0syVGFUN1pGT3RISW81L2I5WEtZUkZiZU1SRjdyYkJUai9s?=
 =?utf-8?B?V2U3VDh1dmQya1J0RVl6OFJsMWkweHBxWk9yNjhTb2t5d3F6Q0dlVnFIb0t6?=
 =?utf-8?B?V3FGV3hpVzBwTmRDc2JPL1FwbWtETDZHSzlFMUVaandFenZXSjJwaUpuZXd3?=
 =?utf-8?B?MXZHcWJhU1Y0TG4yU0sweEN3TktEYW9ocjdrbXVXbGlKYTN0WEllbzROcmsx?=
 =?utf-8?B?cTlkbTllcWZwaW90VUJ0c2o4UE9Cc3ZZQU5QQ0pua3grS2ptSTQzaERQTkZ1?=
 =?utf-8?B?VE93aEJERURMSHJrbzhwY3hVckowY082WEtueEpGRC9lOVNqWHpUZmFQZ3Ja?=
 =?utf-8?B?SDNVbDVWeFdBR2ROTVNjWHhXVWF6TkEvVW1wUUFxSndQTlFOeGpCRXh4K2Jz?=
 =?utf-8?B?NWxQWlJLOVh5Y3pvSFpSQ2dwcTJCTXVPVEU3VkQ1QzZrRFh0R21WL1ExU0Nn?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e460b63a-f093-4024-53a8-08db7d8674ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 18:34:24.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9BS6ryYcbzsuxadLwldIOY6eWtbt1mdr4SuIqIF6Y5tpJcnbd8Ec4etzHya0GGx2dJzjwAHZ7hUgWtOPiEp6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/23 01:17, Ben Dooks wrote:
> If we're writing what could be an arbitrary sized string into an attribute
> we should probably use snprintf() just to be safe. Most of the other
> attriubtes are some sort of integer so unlikely to be an issue so not
> altered at this time.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   drivers/acpi/nfit/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 9213b426b125..d7e9d9cd16d2 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1579,7 +1579,7 @@ static ssize_t id_show(struct device *dev,
>   {
>   	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>   
> -	return sprintf(buf, "%s\n", nfit_mem->id);
> +	return snprintf(buf, PAGE_SIZE, "%s\n", nfit_mem->id);

Why not just convert it to sysfs_emit()?

>   }
>   static DEVICE_ATTR_RO(id);
>   
