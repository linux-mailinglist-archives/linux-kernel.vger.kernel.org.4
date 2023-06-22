Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF63C73ACB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjFVWxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFVWxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:53:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAA810C;
        Thu, 22 Jun 2023 15:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687474402; x=1719010402;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W9xSm+SYn0Gd+mtO5fTzKkH4CAu7DXFa4yNwFh9fWEQ=;
  b=f0wkBcGs+Mf7SXrKPLjloo44PqXd7LJYm9VuY2+sd5pE3Ar+TR6vgg3T
   6ESlYR+xkjs893X8Ftpe8LI1veC/RjvA8wAlAZVALHU6yckZiWuQv15ah
   C0WZcNB8D5Kgko6lqofYfUftF8VEaYKJ2QzMuV9Bu1tWzLO8rtIcaur+C
   v1uo9iwtilcH0+4xMoWMOdtrrjBlmL51DbBRrMNRueiyW/D6FtpVN/ZvZ
   noLVNHvhJbjQLdGjJzZV0H5Sjw+YEQcobR9jQpAuXFgldsmi/R62z2c+g
   Tlx34oJ8XAkxAWe3uPYQ1u8oN1j4RJ/2UCfHYAkgPU72WpuGzM8FTLY/C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="426613620"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="426613620"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 15:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="889256778"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="889256778"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2023 15:53:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 15:53:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 15:53:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 15:53:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhJfRrlpTQ0pV1HfwFEuTE87iXPN5G7MG2g3rH58dkAMmqRgXV386gQ0MoQPjDljmlBpHGPLvMEmEJxMTeKONgyCAIRivDIgim7PIDJ7Q/QcIqnrCU8yzoJv0wGy9wHEg+DIwiZBBC9o5mK2SDAaC+aPYE4muocX7AglzBRsvhX4Z2jL/kOYlfCSNZr5y4xYcpHabi5aaGVtso8lSjrbHKEaHaDZy0reJI31sROhTaal4sU1I7rq0c7PY01h6oA2FBa0AKhG0tGudWUKicpu74i2c1Fmj1qVfv1vIPf57OS8QFVSxqJW/TyoYaj8TLiLWF1nezQQk6zAReYJ9UUfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfqhIZJexcAVhYkmuFfa7/1NmJwc4MdCon+D3uxKRSo=;
 b=nXdzOHFGIcHjqgHClu8Du6fy2mYrvfvLjQxzGibDJQhhOIqBZ+RAnYUp3JGUm00qXbpUIpcaNJoPdAO2JHrW+cn72VaZTj+yqzZa5YpcVsfMP1NrFJir0lGGfB+tUy1fUFSykGvtSewZcYTW5fug1kstQHCJ0fOD37eh50D+Gyt4xYjgnRfDncZ03GEk7onyf8yfIteDnmorlvsg+UL+iQ6T4+V5iCEMXWikSlAZkNeN9Pf6PSYEZ6jdAzQvjuhLEL526y2lUSZE0HvERMG82MVTtqjnDGK6m+4r7bJZViawqeoHZ77/Cjji8hRM1LCvHAdv3eyY1JrveGDEyDeH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 22:53:13 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 22:53:13 +0000
Message-ID: <c2a14448-f1c6-05ac-9511-994d320b3493@intel.com>
Date:   Thu, 22 Jun 2023 15:53:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 05/27] cxl: Rename member @dport of struct cxl_dport to
 @dport_dev
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-6-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-6-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::13) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e2d877-031c-49c7-ee98-08db737374d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqvmdSjRiL7ZKHJOwiOXjqRnWzezMAk5kgMJ4D+iAN96909WUjE/ASvACFxSibatH7kLPBBwn++nuGCw0Sdl5UTsHz8cC+akoAYdwByNOo6eO1j/yeMOlFfLDgis8TppLWSmCUXR9bGAzJTtk4OBGbhIllrndp8/GMfUuqwwB+4wDAYUp+IB5tQ12jQT9TTOeB4XN3AVIPPk/uTtAThlbX3UP/a4yEitxycrU0wJIOo4h9R1Qx/W9zG4hOqP7/oP02hJ0oz/Pr4OdCgqZW0LLHz9dqNLRK+dWV5CnfVuPaVjHBOoe5UmGn07ryuivTKj5490VPgWvwJKpEGFsy5+QPhXUh8x3RizsZJ34x0jJTv+PkuvdrjCRRP136OJZ27hEpgkAvSpMouf0C8DZjG2DmdlxyE6HhS1neNOr0RaIPYYS3DiO/T/i2yLYePnJII/ZXBMHjWSLn5D4biQ1Nki2yf9fWw9dYeUBr45giMFmzOJNjQ7PsNrzfgpT3QUy2C/i1PjSdScUGtu86bdAv+zmL39GAFFga+iE/YpxxLkJgnjNoNV7WFBfrnYL1SvNauJ0lPwM52qBrm3q3+BcHzqr2xOXO4iWFfBwv+44tOSnf0uZ4DxWWIJ4Y1R1y744RysqFp7zmDqG6I3DdLpNgNDTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(86362001)(31696002)(41300700001)(8676002)(8936002)(66946007)(66476007)(66556008)(2616005)(316002)(44832011)(83380400001)(5660300002)(6486002)(6506007)(53546011)(478600001)(6666004)(6512007)(4326008)(186003)(26005)(82960400001)(38100700002)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N05nRk9oWUJiOXBqaGhjVEVZV2hYUTl6cU5YUm8yMWIvWUFLaGJ0TXNQb2FP?=
 =?utf-8?B?ZXpNbkszckE3bmZTVFRSbkJxN0NRcHFKZVcvY1BIRDBnSHF2M1J5NGtlSXQv?=
 =?utf-8?B?YmgwMzJKMVpRampGT1lTeUdWTmlWVldVTURhc2lXT0hJaUhhdWFuZFR1UGZP?=
 =?utf-8?B?VVoyUnlWRklMUU1idmRnSlVpQ0JTdFpoTStGT1JFV0xlL1pDa0psTVhpbm9x?=
 =?utf-8?B?VlZ2azZHR1dyT1VYL3pMZHRtS2Z0TUdKSEVhS2tGMWMxaWZTM1hnMkRDcVhv?=
 =?utf-8?B?dzhIem50OWMzTmlMazR6dksyK0l1VVd1bVdtUmZvRUZWSWVOeHNvaTR1S2xm?=
 =?utf-8?B?ZUt0UWMwZkgwT1lmb1orSWpQTHdra0Jwb1lLL3I1cDBqOWYwdXVjd0FpZnBk?=
 =?utf-8?B?Rk1mWUxaYTV4aHh4MWN4V1lEeG1JaWpOVHE0a2h0czBPUEE3aTM3SHoyYXZW?=
 =?utf-8?B?ejBWZmJNOVVUakRUK3c5MURaVStaK3htMmtmbHRIaC91SUk0bklyUVRkTElp?=
 =?utf-8?B?Ti9ndTExZkppdnJrQStqeTV6NkptM1NkV3FwVitXT2RXUDBPeVVKT1Y3cDFO?=
 =?utf-8?B?d3h1NjZxSUtRd0ZjcTNhL0VqbTZCbnZtcllvcHkzdXNvZ2M5ZkRwcVNFSGlF?=
 =?utf-8?B?RHArV1lxaTJqalpDYnIrd0s4UjZYejdMR3I2RzYzcVhvWEQyZzZhREEzcUlS?=
 =?utf-8?B?UFZTU25XRXJXVzEwUjRjN3JCV3Faclh1RitTanZQRVB4R252c1hJK2NLRWJV?=
 =?utf-8?B?T1BDV1hwMktLL25mRk1nUHlFKzdUZWRKUDl1dUpMUnVneDRJRkJHR3ZCSkxY?=
 =?utf-8?B?TFVYZi9WU3RxQVlQNkl6TlVNZ2NCa1A3UnhENXA3OFVWREg0b2l5elpWTGp6?=
 =?utf-8?B?RDkxOEpiZ1JtdXQ5YU9hZVlRbDBIaHI3eVo1N1RodGZnZ0grcHhNZkVRZDRK?=
 =?utf-8?B?NzNnWTM3S2hqcVVDVjJYSjBSQ0V1TDVReHlGRFd5VGMzUWFQL2ZnZk9zcUpv?=
 =?utf-8?B?bnVDTGZnVC9rMTU0aklYRytEUnZIRE1aSWxPemc2VUNNS0FoSkxrdDhTeG9G?=
 =?utf-8?B?SW0ySlp5SnZaTmlrU05Da29PNUFyWEJwVjJMOWU4VlVyeE8zOGg0bVVWNHky?=
 =?utf-8?B?c3JnRjNQb3BTRzdBUjNINWZJcEd0UXp4YmlTTjByalg0ODFERkl0T3I4MWRh?=
 =?utf-8?B?dXNUK2I1VlpwV04vVHZCS1d5YUplc1VTTENUVUNQbjJFdkxWQWJtZUdUbEpV?=
 =?utf-8?B?aTE1MFJuUisvZWpqZVVNMm4ybUpmdmI3cHczdXdkTkovNVVuNmFFdjZyMDJR?=
 =?utf-8?B?SFpSd3ZzVlRLYlV4STR1aEFMV2NRVTgxa2lUdW92cXc4TkdBeTczVzZiVm9x?=
 =?utf-8?B?Q1QxTzAyR0ZKcUxUNlp3THpLZWpXRW4venFIUDdGSGRuUDB3U0ZCUWRja2Q0?=
 =?utf-8?B?QUJUWXBEc0c5N2ZzOFVzeFVYWW96Zk1BMEhXNmZsNmFhdzZXTFYxNnJmVUNX?=
 =?utf-8?B?Q1d1RkFSZ3RNaUV6YWdYTFRKVGtkTWE2RXUwM0E4elhzcnNIRnIrOFdjbWNu?=
 =?utf-8?B?YW5obVdlQXdxTzVZbW00WWdVNGgzRUs4b3JNbGp0aithUXJqZEwwRmhYRS81?=
 =?utf-8?B?RS9jVlZpL1VpQUVRdlBrS1Z2VVFYTUY0OFRZU0NUU0xEMWlXa3lDQWhhTXJD?=
 =?utf-8?B?OG1CaGpJQzBMaUxIelJtdGpvNWwvclJtbXl2cFhwMlB4bjc1K0E5elh1N2Jk?=
 =?utf-8?B?QWFPUXRZVWNyVXBnV0tRRHJxaXBrdTQ2ZEtMTCtzRElZVlErOFNPak9aMFBC?=
 =?utf-8?B?VVJPaHlmYmhRSkdBOE5KbTZNWlpQZXluSGJwUUVQeEMrYjUrM3ZieWszTXRH?=
 =?utf-8?B?ZXRBcmlLK1hhRzBhd0R5TzFOZCtPYldaWGhacHhId3JhTUIzVXVrZ3pGR1NR?=
 =?utf-8?B?QkVDVGxOeG1LWG53R2pzZDk4VjVsbUlNYjQ0UkVMVW9UNERBYytZeWVsODNL?=
 =?utf-8?B?Tm43MHNEQTViaFpRY1RNN2NnZkN5UDY2YnpBdXoxQS96SDBqUVMzQVd6czRs?=
 =?utf-8?B?Tk1pZlNmNWpoWVRrVkg4dXFyalZLUVJBaVhZenBYdGpnZWNnUldsWUlCQjJX?=
 =?utf-8?Q?jwjhAAEPf0E6U0vNWau0zlRCy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e2d877-031c-49c7-ee98-08db737374d3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 22:53:12.4587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgCclSnLUljA2uU92UAenewyJqA19EGZHtiUU2mmZuMVIg6NQV7MjkIxH5X5g6yHKQu46fhP+UIpHUvEumsm9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6408
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



On 6/21/23 20:51, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Reading code like dport->dport does not immediately suggest that this
> points to the corresponding device structure of the dport. Rename
> struct member @dport to @dport_dev.
> 
> While at it, also rename @new argument of add_dport() to @dport. This
> better describes the variable as a dport (e.g. new->dport becomes to
> dport->dport_dev).
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/port.c   | 20 ++++++++++----------
>   drivers/cxl/core/region.c |  4 ++--
>   drivers/cxl/cxl.h         |  4 ++--
>   3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 76888c75dae4..7d3079f5b7b5 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -605,7 +605,7 @@ static int devm_cxl_link_parent_dport(struct device *host,
>   	if (!parent_dport)
>   		return 0;
>   
> -	rc = sysfs_create_link(&port->dev.kobj, &parent_dport->dport->kobj,
> +	rc = sysfs_create_link(&port->dev.kobj, &parent_dport->dport_dev->kobj,
>   			       "parent_dport");
>   	if (rc)
>   		return rc;
> @@ -658,7 +658,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>   		if (iter->host_bridge)
>   			port->host_bridge = iter->host_bridge;
>   		else if (parent_dport->rch)
> -			port->host_bridge = parent_dport->dport;
> +			port->host_bridge = parent_dport->dport_dev;
>   		else
>   			port->host_bridge = iter->uport;
>   		dev_dbg(uport, "host-bridge: %s\n", dev_name(port->host_bridge));
> @@ -847,22 +847,22 @@ static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>   	return NULL;
>   }
>   
> -static int add_dport(struct cxl_port *port, struct cxl_dport *new)
> +static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>   {
>   	struct cxl_dport *dup;
>   	int rc;
>   
>   	device_lock_assert(&port->dev);
> -	dup = find_dport(port, new->port_id);
> +	dup = find_dport(port, dport->port_id);
>   	if (dup) {
>   		dev_err(&port->dev,
>   			"unable to add dport%d-%s non-unique port id (%s)\n",
> -			new->port_id, dev_name(new->dport),
> -			dev_name(dup->dport));
> +			dport->port_id, dev_name(dport->dport_dev),
> +			dev_name(dup->dport_dev));
>   		return -EBUSY;
>   	}
>   
> -	rc = xa_insert(&port->dports, (unsigned long)new->dport, new,
> +	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
>   		       GFP_KERNEL);
>   	if (rc)
>   		return rc;
> @@ -895,8 +895,8 @@ static void cxl_dport_remove(void *data)
>   	struct cxl_dport *dport = data;
>   	struct cxl_port *port = dport->port;
>   
> -	xa_erase(&port->dports, (unsigned long) dport->dport);
> -	put_device(dport->dport);
> +	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
> +	put_device(dport->dport_dev);
>   }
>   
>   static void cxl_dport_unlink(void *data)
> @@ -954,7 +954,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
>   			&component_reg_phys);
>   
> -	dport->dport = dport_dev;
> +	dport->dport_dev = dport_dev;
>   	dport->port_id = port_id;
>   	dport->component_reg_phys = component_reg_phys;
>   	dport->port = port;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f822de44bee0..13cda989d944 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1162,7 +1162,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
>   				dev_name(port->uport), dev_name(&port->dev),
>   				dev_name(&cxlsd->cxld.dev),
> -				dev_name(ep->dport->dport),
> +				dev_name(ep->dport->dport_dev),
>   				cxl_rr->nr_targets_set);
>   			return -ENXIO;
>   		}
> @@ -1173,7 +1173,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   	cxl_rr->nr_targets_set += inc;
>   	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
>   		dev_name(port->uport), dev_name(&port->dev),
> -		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport),
> +		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
>   		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
>   
>   	return 0;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7c8674079f1a..7232c2a0e27c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -589,7 +589,7 @@ struct cxl_rcrb_info {
>   
>   /**
>    * struct cxl_dport - CXL downstream port
> - * @dport: PCI bridge or firmware device representing the downstream link
> + * @dport_dev: PCI bridge or firmware device representing the downstream link
>    * @port_id: unique hardware identifier for dport in decoder target list
>    * @component_reg_phys: downstream port component registers
>    * @rcrb: Data about the Root Complex Register Block layout
> @@ -597,7 +597,7 @@ struct cxl_rcrb_info {
>    * @port: reference to cxl_port that contains this downstream port
>    */
>   struct cxl_dport {
> -	struct device *dport;
> +	struct device *dport_dev;
>   	int port_id;
>   	resource_size_t component_reg_phys;
>   	struct cxl_rcrb_info rcrb;
