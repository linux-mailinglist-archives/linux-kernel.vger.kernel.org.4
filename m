Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC0F71794E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjEaH7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjEaH6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:58:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F7F10C6;
        Wed, 31 May 2023 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685519899; x=1717055899;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xNnH1lavUJaolj6gOGL6SiorSnClWZbZG1Jh0sV8StY=;
  b=c3zyFhbLzsiTcW29B4e2hfnKwbF4xOCASBN5c9SFygFzjS0tED/uY88Q
   LxICiPJaRP0VcI6UNKJ+AMhof//FLZsV4tDnb/7X1F1fp6TTIuGpzWVhv
   DSR3mWb4QyPu7k7h1Egc4S8YTMTE1xeIoiySRO8TBzLOeUdWCewQPDyhy
   Rj03Igy+tUJ4L05vT35gjWGIHUsKgA6dy3u0NJ4/IuTl7iAViHMhC4sY7
   mPr+b6x7U6HFRj+YtrsDIVeEt8xocRpmS9mZRvtPLWj6GUpoFtccfQU8e
   Z4RZLsMWOn2eRkF+l/m4WpSui1SqhWpPTku/rYUkn+oqSr5iwBdsCgAlc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="344676043"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="344676043"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="796603727"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="796603727"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2023 00:58:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 00:58:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 00:58:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 00:58:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOfwE5AWopSZzWezqv75p1EexNAmHbgM8QHa8zH22R1hvcSrW0RiLRG34lcbguiLByWV46W9ifLYpwlsPRBCoCfoayFbMjwobKt+VUCcHr9HUO4NRCnLuE8tb38Z3uDPjRJqVCF0xj1bIG7OLFn5kSNnHOxBXuPWCbrG2oOFsi1U0onQ0JqfmInDzADTUKImlVeL2a/uYdja3myhGNtumzYHLCo2oT7LwEzT3CPVt9ycBaEe9o+NGgW2OOPgQjBxwusRJrIDqC/OxNbmb61wb/395cxGSVSZ8fMxa77F1b4HAfKHMBi7x+KOf9XoqHTt4Gb8xk1rikDVXqa7PIMTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyTRTKxHRFf1kvCENXL1/Tbc2w8+QMQI2Guf6vh9u0Q=;
 b=EktVt1o/YF4Mo0fk4n+UptZH7qW/ozoKOGatySljCaetI9q683aAjKg5bqga1nGI8iQFm+nJrDEcMA8GmgwJ5a6BG9Y+pq7fzf6JmU26cyKSHym2esTaatbcgg4f9uRz9emfqRL6uyl0JBjsU7S5YT7lLka+hwAPAilVC3mEXkcfz1bMB9TOhydjnwG3A7M49NEiy/XMldKBrF8NBzUosULo0NvSBhGUM9Sdj5NAApZglvk+8uDM8axyJeUJiwEMagSaQAxPtsUCqihD2ffppOuQzxyUNyCQJcLkWeIXwf1H60omdVaW1/O1dfC90mYU6B/0GnH4gOdPKs+HwfOFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by CH3PR11MB8465.namprd11.prod.outlook.com (2603:10b6:610:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 07:58:15 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 07:58:15 +0000
Message-ID: <026e23bc-275c-332d-ee7b-f0cbc874fca2@intel.com>
Date:   Wed, 31 May 2023 09:58:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 3/5] ACPI: thermal: Move symbol definitions to one
 place
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <5675481.DvuYhMxLoT@kreacher> <2224091.iZASKD2KPV@kreacher>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <2224091.iZASKD2KPV@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|CH3PR11MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: d92f53a4-9458-4524-f6f7-08db61acc995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scjctQ4wTaAGnA7A3gOXhdGV1lwfBjwJIEPq6ZLERs6NQJCpqVNgQne/pqJSAXe45JUDtS9TjjGW+h5+fiIrJhvUegpRXgm7ksLoe5qeGlt0SkVQ1PIMrK9FFe4r1eRs4AZ8ompGrFslnVwssCjq1eVkV9tvyeqOm4vZUJhjZHuJqIScN0LOGs7ClZDLgNEg6L4SigI26Z+YHEl8fZvY1RvaTfdUT3w3MifYMqzqy6wH/YOWmqIZs6SNVVl0lJ3hjnbHDCtBV5h103iDS9kHdEwvDOzEZ1kj+RTn08/c+Ggi7ZAdvlz3dvOzMSY2m9BUFMZVestGb1ufSoQQ0+t0BV9D/i4L+As0ZrgyqlRHHGkRGa2THzPZ+yDh9JEtoAGD5JcJAoduLxyevC4poDJ92lnwuG9A1PM57b3RMLuVfU66LNdhTaaLXShmGZeHJXtKAyUkJCUUavwkTjtb3ihTGc4Bo2rT4F9AZOZ8snpVHI2VXSWVc3BbTUTl1mOVa2/aug+tcs3GcgKIRDstFz6lI7TMLOWossxezt3W3wAf2XzawNVv5hPt+/Pcu7Dcqrl3akz10wJqwbrpepAAWdIIZ9XijTjmvQNj3s42OkxgOhTX2quSY/YcW4fb0MAaZbpv0tovLbaALF2eCqyiXfIYTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(6486002)(478600001)(6666004)(186003)(36756003)(26005)(6506007)(6512007)(53546011)(83380400001)(2616005)(38100700002)(86362001)(31696002)(82960400001)(316002)(4326008)(84970400001)(41300700001)(66946007)(66556008)(66476007)(31686004)(8936002)(8676002)(5660300002)(2906002)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFBLWkRDbEYwQ3hIUUJGUHRCcmdmR2xla1dwZEx5UHJXOG4wSm9LRG4waU9S?=
 =?utf-8?B?ZUV5MXlPaVBOZkFEamNmQTFLakJmVUhYQ2hYSjJ2UlFLb2xyWC9MaXZuemdJ?=
 =?utf-8?B?ZUVVejZTQ2NPTjNqRm1uQ1V1cWp1RU1RWW1VKzBEcGhTOUVDOWZGS1kxZTJv?=
 =?utf-8?B?YzFyTnBXc2E1dTJvaTlPR0N4eU9hdGVCU0pRKy8vTllUdFVWSVBKSEEwK3VM?=
 =?utf-8?B?djV1anNWNk9LM0VZd2hXT1lxZzVNV3hJbi81MktHQnlETi9hVG5OdUtIemVV?=
 =?utf-8?B?S3k5bEdWSzFOSFdvcTlyUmx1ekxEVWxwM3dsay9XQ1FuR2RpNDZVRFdUdkNY?=
 =?utf-8?B?VEF4WHJ2cEdGUksvZldrbnJzeUVZbFJNU1JDazhta2xDRDNXQkkxOXhjdnFp?=
 =?utf-8?B?VG5kcS9aTHhmUFkvNFQwK3pIVHJPeXcwS2EzQWoyYklFNTdqVXpUZklnZ21J?=
 =?utf-8?B?TEhuak41NC8zMWtWRmRPRkNaUng3dXZwSGdxRGxKM0UxaWROTlVSN2ZXTllU?=
 =?utf-8?B?Y1JQL0FsR0wrOFRjTEYrWHdPK0VIMmcvcUNLSXJ4UHdTRWJ3NGlEZFFvclhX?=
 =?utf-8?B?bGVqUnR5UkZFVUdLQ0VhR1c5ZkdnN2EwQzF6UzhqQzY4ZWJ3YkZscEl0aTlP?=
 =?utf-8?B?TFZKanh0dmUrSDI2NWFQTFNyODNJZnRWM1RjenV6bld2VWRYTGlHUFI5NnJz?=
 =?utf-8?B?TmRtRzFyUlZpRFNNOXV1c2FCTFNweGk4TGpsT1d0T0pYR0llUVhlSVU4V3VF?=
 =?utf-8?B?NzBBQ2kwL2ZLTlU0TXB5R2t2VjdrZUR6QlVSalBEUW9LOUZoK0RybmFDdmZq?=
 =?utf-8?B?RlVZZm9XTzlnTndWcVZjY3FEUlhVQVlkRW5yalBVVkpHUTA2aDlVaUM5OWhW?=
 =?utf-8?B?cUxjekJzVFBJSGk1R1VoSXhJZHZDT2tTVitHQkVBemM2TmxRZWJJRXhaZXFj?=
 =?utf-8?B?R2JLcWNPWnVGaEZGNHlLM3p6Sm5pUUMvRlBURHI3UjNLL0hzaGxKdGlPU3Aw?=
 =?utf-8?B?QjlMZ21HZFhVM0QzVUtoS0dwWDdmZUpjdUhWTXZ4d2t1Mnd1SmUwWGYrWGdL?=
 =?utf-8?B?Qi9oVktFYnFqNWpjeVZuSUJmRkV4U3QyNEVIc1lpWkhRM3M2b0J0ZjM5Q0ZG?=
 =?utf-8?B?dTNVMTFJdEhKWk9aa1p3TlFBeWprRVhqMVFwcnJocWVNbG4zVzhidlE3TlQv?=
 =?utf-8?B?LzNZOXlpbWV5ejdVZHJta1BDam51TTArRWdHMWR5aFo3YjArV0VUR3FOcVhZ?=
 =?utf-8?B?d1E1d2g0aUZ6aWRjVWpQQWFlaHpkNUs4Z2dsempFa21LN1lCOWpnbmNLTkl4?=
 =?utf-8?B?YTlQdWZmaDZ2RzZBTXlqWEE5STk2LzdGN1RrT20xNzJERnJpcjR5Y0lacnVH?=
 =?utf-8?B?a1p4M3ZyUTdWSTE0UTJFVGZ3VUhaQk9zYzQyTEx4NmlrZWZWdGZRK3JJbEli?=
 =?utf-8?B?TkpKSWkzNmt2RUFjZEE0NU1ySEl5M0RxenJLUGtQOHdMdjVIOUg0V0lNeU5Y?=
 =?utf-8?B?RVhqa1FyWmVqM0haeHBnNXoyTFJKKzkySDBpRXh3Q0VlVmRYbXo5a2thQ0xH?=
 =?utf-8?B?Z0JkM0dpcXVHVDM2TStJUTNlR1hCd2FjcmlQYkRxc1Nibk0veHRWaVJDRzN2?=
 =?utf-8?B?SFlxbjBwSGlSckdLUk1OWVJRQzZXVXVocTM1ZU9HMWpyWTd0VDBoOTFUdmpu?=
 =?utf-8?B?UUZvOTdsdjV1YXh5bTJRdDBobFNlUnRKSlI5eUw0MUo0RERzblNsdjAyRDFJ?=
 =?utf-8?B?QW0wUktQLzNjcmdpbzZRaGVWTjRyTGR4Y3VwOEFRR0RpQmc0OUI4RFA0dXFR?=
 =?utf-8?B?anRGa3dWM3ZRQU9BNysydWx1Nlg4ZUNyVEoySmhTWm42RFArNXR3bjlyMG1a?=
 =?utf-8?B?VTM3U3YyTWY3K3Q2b3NYcG1ScFJHckdraUEveE9YR3JIcithUExxSTVYSU9G?=
 =?utf-8?B?YjNsSzJTVXhQY0hPYjJYOHZGTnVWS2ZqOEI2aUtjTjNlQUhoem5QeVdRdERa?=
 =?utf-8?B?YXBYWE1VVEhHTWlIUXJ6OStpckc2b2d2Yk9nR1YyeEZmT0xEK3I1a3ZsMzMr?=
 =?utf-8?B?Z3gzRXo3YUthaEhZMXd3YXVoVEdMRmovSWdFS2JPLy8wd2JNbDVlVWtHc2tp?=
 =?utf-8?B?UmhXYVJVODNBSHFkRWNUTW1KdWJ3cFhHb0p2TEx5OTF5QTJxVWk5d2dKQnIz?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d92f53a4-9458-4524-f6f7-08db61acc995
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 07:58:15.0455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cutHbdgYhcj6p7aalmqf7ubKZw3V+sfnGC+Bv1MY4YiUiQ/cSO97BusD1/z6V6l0bmWUGBL6aaR0qU/jRfcxNZg5n6iiJg6v2Qh1Tk18opY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8465
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 5:44 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Move all of the symbol definitions to the initial part of the code so
> they all can be found in one place.
>
> While at it, consolidate white space used in there.
>
> No functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/thermal.c |   58 ++++++++++++++++++++++++-------------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -40,8 +40,35 @@
>  #define ACPI_THERMAL_NOTIFY_HOT		0xF1
>  #define ACPI_THERMAL_MODE_ACTIVE	0x00
>  
> -#define ACPI_THERMAL_MAX_ACTIVE	10
> -#define ACPI_THERMAL_MAX_LIMIT_STR_LEN 65
> +#define ACPI_THERMAL_MAX_ACTIVE		10
> +#define ACPI_THERMAL_MAX_LIMIT_STR_LEN	65
> +
> +#define ACPI_TRIPS_CRITICAL	BIT(0)
> +#define ACPI_TRIPS_HOT		BIT(1)
> +#define ACPI_TRIPS_PASSIVE	BIT(2)
> +#define ACPI_TRIPS_ACTIVE	BIT(3)
> +#define ACPI_TRIPS_DEVICES	BIT(4)
> +
> +#define ACPI_TRIPS_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
> +
> +#define ACPI_TRIPS_INIT		(ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT | \
> +				 ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE | \
> +				 ACPI_TRIPS_DEVICES)
> +
> +/*
> + * This exception is thrown out in two cases:
> + * 1.An invalid trip point becomes invalid or a valid trip point becomes invalid
> + *   when re-evaluating the AML code.
> + * 2.TODO: Devices listed in _PSL, _ALx, _TZD may change.
> + *   We need to re-bind the cooling devices of a thermal zone when this occurs.
> + */
> +#define ACPI_THERMAL_TRIPS_EXCEPTION(flags, tz, str) \
> +do { \
> +	if (flags != ACPI_TRIPS_INIT) \
> +		acpi_handle_info(tz->device->handle, \
> +			"ACPI thermal trip point %s changed\n" \
> +			"Please report to linux-acpi@vger.kernel.org\n", str); \
> +} while (0)
>  
>  MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI Thermal Zone Driver");
> @@ -232,33 +259,6 @@ static int acpi_thermal_set_cooling_mode
>  	return 0;
>  }
>  
> -#define ACPI_TRIPS_CRITICAL	BIT(0)
> -#define ACPI_TRIPS_HOT		BIT(1)
> -#define ACPI_TRIPS_PASSIVE	BIT(2)
> -#define ACPI_TRIPS_ACTIVE	BIT(3)
> -#define ACPI_TRIPS_DEVICES	BIT(4)
> -
> -#define ACPI_TRIPS_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
> -
> -#define ACPI_TRIPS_INIT		(ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT | \
> -				 ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE | \
> -				 ACPI_TRIPS_DEVICES)
> -
> -/*
> - * This exception is thrown out in two cases:
> - * 1.An invalid trip point becomes invalid or a valid trip point becomes invalid
> - *   when re-evaluating the AML code.
> - * 2.TODO: Devices listed in _PSL, _ALx, _TZD may change.
> - *   We need to re-bind the cooling devices of a thermal zone when this occurs.
> - */
> -#define ACPI_THERMAL_TRIPS_EXCEPTION(flags, tz, str)	\
> -do {	\
> -	if (flags != ACPI_TRIPS_INIT)	\
> -		acpi_handle_info(tz->device->handle,	\
> -		"ACPI thermal trip point %s changed\n"	\
> -		"Please report to linux-acpi@vger.kernel.org\n", str); \
> -} while (0)
> -
>  static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>  {
>  	acpi_status status;

Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>

>
>

