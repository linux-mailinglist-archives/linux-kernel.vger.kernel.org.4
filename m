Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2D717972
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjEaIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjEaID3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:03:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7098F113;
        Wed, 31 May 2023 01:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685520206; x=1717056206;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NOPsxlEZMd/OrEQeLteYnSvk/eO2omYnjGceGhRBfTk=;
  b=Und6hVJkDvwS6qbRyP27DF16ATSihCdot1zsA2i8LL+XZokJU0fdwpSm
   qiDbcax4pxe7RrdkLpWCPpH8bvy0cblN1HacpdnDYdWL/tOp9IqJYdN+N
   Qjmc/xUH4DXOoam/MxJE2GN9dqosN7c5r4npWlVqMMS4GcR5te0d9QBKG
   ElXWlkJRdY5I+zYNeCRJcAhYUvg6c/SNuLrdc9clqu6p1QZYpgtOUyKL/
   UmcCxc5zuywpO1TpcICwRNmz9Dn3/Gu446V1npMsjVu1yYueXOXLNWiUb
   87MAbZXd30oOE2MF/18pIQQ/VOrjsS98clztVi9pVUDj1QdmWJFngCHxl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="354013941"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="354013941"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 01:03:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="701011881"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="701011881"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 31 May 2023 01:03:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 01:03:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 01:03:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 01:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhGSdimi4x0SofGOEQk34L5feYrqzUdUtNCmQm5+ypQHCTNUvlCuk8TpQbZQMVjZEFeIbNeHkO2knGL2UCoSk63IjkyIgSCuakDOyvIEa2CQ8AK6nT2KxNW8aRW5W0ygLkmNtuJXDHlCN5mWBVX3ntB9gMxPGYQIrvw+Pvfqjx/SsSZQudKARq7u9g2WL4f1JzZ/kIUYqK0RNla5Rfx6vu18blpRPjG5oeXOeNWRp2ULZP7BGnmBsziwd+oGgVgvU4RwRHws5Qs+QhX7Gqz6wp2aaCL1tjq2QlRlUsyQioao1pdr8/BFhxUipnc6pC3QqVHmCZSmYEPmt7cTULBBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEtixmJrafzsJHW6s9NPqHmZTTgVHOMae/nNBovJ9K8=;
 b=P3ZWB9P0ouq3daB9ti34E+xwmV23q2eTBL+6vByrHeWhCgjMb230SQc5R8I+Boavpu8nUQ72ECEt2EqsfM3ZtzS00fQKx8jANkkaSj6sok6hlIFx9ccZxbqRh4OFbfhY8CjcYzAg6XjW0/jY6slpBm0qv8SkPrIJ+U9857u4xfoungZyEYZ25mVodunzWjAaARwy9Y1hl3UU9w4asdMrxOG2YuLSRJ5zSR2k0pN9xObV1J/kYjKiQTw0MrPv8e4tlJSv0iw12ZA/yOpd764J8Mdt4OcGfnSaDMxPsHlD6CLpA9CmBwSlQdDNIRPO882363i1zs2TRmpK2dpwA4C+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by CH3PR11MB8364.namprd11.prod.outlook.com (2603:10b6:610:174::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:03:16 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 08:03:15 +0000
Message-ID: <3f8697c3-f99e-e467-3926-5a574d4c6bd4@intel.com>
Date:   Wed, 31 May 2023 10:03:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 4/5] ACPI: thermal: Move acpi_thermal_driver definition
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <5675481.DvuYhMxLoT@kreacher> <21889638.EfDdHjke4D@kreacher>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <21889638.EfDdHjke4D@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|CH3PR11MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ab7eaf-f49d-438b-0a9b-08db61ad7ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWmDAcNvQOyXPDv5yRNAq0phXUFZFxVZViQziqBsjwSdqxUOPBqYyxu3Sg68fB7dDotUm5qC3YTbEJ0fpoIZf46MZdaXH2M0t4L+QJvwD2LrI686tq7x/yXERlLg0g44+b/oCTBUU0AVpjHDQHS/v/yAsN0z7veaD+8ulOc7P2GorWilxa0j6Yzee4+Bg8QMtaqEt7DGimzCB3ttvsuqCG0keINnkClJjEOvSpT6zcqNlnrnCirfd8aiHIJywWAeQRP5oVU4ytW4y8UJuic02pG33arlRhUa3XN8Om/oZc2Ps6YsHWgx4FGkr4gxV5nAxKFpQEGN1XZW7JYZyXfnaa3RsWIPIN+90QHzLOhOYlKn4ZnuhCxlr/rGwBv3T8w+/kO/8+UZwcAUw9aSsnaYUpszyUQFB3e4r5P3zLTJJmT/Lc/ukTH4kbNvY2CPV7I7VfJwts/Kd0OS50U74VyBMVffKL3vs3ocpCY6V8HOONbeGA795EpmqTqh0VWuTbAsCtsXAt4SvBEIyGI1kAcTuy5rYOmwJwXzaRNRU2XYTA9uFDWLqh35y5iwDpTWuGgePt+jL6Iyw7PmbFqoF6H99dxtdimkgREUSuEmIPQoSo3qIh7txYQwwFT85XW6MqzcwDDteV66wj80YhTS4o32Ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(86362001)(83380400001)(36756003)(66476007)(66556008)(6666004)(5660300002)(316002)(66946007)(4326008)(31696002)(6486002)(41300700001)(8936002)(82960400001)(38100700002)(8676002)(54906003)(110136005)(2906002)(2616005)(53546011)(6512007)(6506007)(31686004)(186003)(84970400001)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmV4d0Y5emFpS0JQb05WbERJUEVGQjhiTzFqTmQ2RkJpYjFtRkJXVzlTOEJv?=
 =?utf-8?B?WUpjY2J5U0lZY1dvSklHYkJHbWw4OXZSZWNZVGxiYkdIZXcyck9lV1VzSFFT?=
 =?utf-8?B?R1hsQjhxVmdFKzY4eTdkQnc0NFhyY2pVWXlqd0htUHJNSGZLNmNuNEI3Ri9V?=
 =?utf-8?B?anZ5UHkzMDJjZHVSRDZRV3RBL2w3anFLY3E2ZlEvZVc0N1I4OWhRSnc3azg1?=
 =?utf-8?B?UVRHSU5Fc0NTR3B2Y1dsQklNUnptMFRkaTlDU1dSd1lzMG82b21sUjZwSkFK?=
 =?utf-8?B?bkxxK0loUnZGaE1KUHFlMFJNMmowU0ZFVS90WjVXaVdDNnZOZEhRbVZOKzgz?=
 =?utf-8?B?YW1Yd284NVRPLzF5UEhmMzdybWNGQ0I0ZlNQQXJGZy9Gd1NzVkdha2Q5elNa?=
 =?utf-8?B?N0hVWk8vdG9STExWOWNxRTIvMnd0V1hoMDFOZ3dzWXkybDRmNWVNaXN1QzdT?=
 =?utf-8?B?SG5EaUptRWYrSjNmelRoNU5YR2Job2UyenE5OHBWbmI2Qk11cmhRT1ZrM3M3?=
 =?utf-8?B?ZlZHYmFQRmRFbjlPRzFaY2xNM05OZ1cxbVJTck9jZzRUSERrcWUyYXJvNVhi?=
 =?utf-8?B?WEZqZTYzM1BuZnlBSzE5bDdNUW5yNkJ4WVJHa0xaanNNWk4vZERKdENyTHg5?=
 =?utf-8?B?RnhibU9FTlJHZ1R6RzZSU3hFMTdESGNGRFp6eUF1OHVBb1JvTnRUdHFGVTJr?=
 =?utf-8?B?ZUNrT2FOZjZzejBTUm1XMitUOVZROFhzTmJXWldFWXJrcHNMSlZDVHFMeWxX?=
 =?utf-8?B?aGllazJYcXBjRXBiSThaOFg0SEp4anlteHMzZXgrSDlkcHMxZkNPOVdLK2F0?=
 =?utf-8?B?R25iRDV6UnlGSkc3d09pQUI2Q2lXbEcwRFNhTDZJaHV4S3FQRFJuanU3YWVG?=
 =?utf-8?B?RlhObmpKUXUzZENlY1ZkR3dSVi9mMHlobWNIcjVIZEw1UTF2SzlER1BhTXFn?=
 =?utf-8?B?Q1pJOFRNRjFxWjBwMUY1L1BiaUF4Y2E1NWxSbWdLWXJKemx4Z3VxWEVReldy?=
 =?utf-8?B?TXVOSUVOS3VoZTBOa0M5WEw0bmREZGVjMTNOZEEvZEJ2RUttNjg5cXZRbFhp?=
 =?utf-8?B?TDlQUkhUVmlCeVVhWFY4aDVSSHZXS0grL3pMQlhvNURLWkFVaFR2Z3hSSHB6?=
 =?utf-8?B?T3JOeXVCc2hrYjBTN1Z5N05wdnhSQ2h6SERFZU9RUEtrbW54R0FUR0h2ZzA5?=
 =?utf-8?B?blI4bVZmQ3BGN3JLUUQySjNkSjhJb1QvWm9HbzFCbmwzY2JQTS9VSUErZkJZ?=
 =?utf-8?B?STQ5Y1B4ZVRoT2pRZDlvNUdiME5DUW5BZ1Y5eWk3U2VzRTM4akt2VzZLUUZw?=
 =?utf-8?B?cHJSMzlXVXhSTThXUXE5alFpWWdXT0t0MmNNQk9vQlNlcDdZb0Jlc1ZjdDRC?=
 =?utf-8?B?bUZIMHFLeUpFbHUvWGxWK0Zrd1FOQmZqTWJCalhqLy9KbXl5WkV5RjJJN2Z2?=
 =?utf-8?B?UU05Z2JFUm1FT3Q1TDRkVGpEaG1GYzEwZTVJdThhQTB1cUNsajhBZG5PQmti?=
 =?utf-8?B?clFyVURNZG1SaEFzcDBmNkNMSmtRSGoyREo4NFpzUU55OVZiSFVId0xaOWp6?=
 =?utf-8?B?cVJvSFJKREhCSkdkRy9rUVVEMEJ6MTBEeG9iYTIrbmFLenN0S29Hdkt4dlVl?=
 =?utf-8?B?WFlHYXowLzZzcDR2cm1WT2xaejB3aGhpejF2VFhJa0thbDUyU3kwUkY4YlRJ?=
 =?utf-8?B?QVRvazdIMDFDT1ZUOXdldmh5cXl3SkF2UlRGYjVVK0tEdGR0aHV6ZmtXOHFD?=
 =?utf-8?B?bkFXQVNGTnZzbUdtRmpjeFBHcUhTSm1sV3ZFZTFWa08wamJ5M1FvSmQwTTZI?=
 =?utf-8?B?bk41Wi81OEN6a2FXMmo5RUlmYnNweGdBWGtKQ2tNQWRNLzVlOGJLaC8rQVdG?=
 =?utf-8?B?UjVuWDdBZGFWZG05NHozYXdJeG81T3dVVnQ5dkRxS0dpQ0dkdm1UNGFvVUh5?=
 =?utf-8?B?c2hFckF0TDdKZGhkc1hmdjdMUjRkWlpLdUV6NUczbTJMR2RCRUUrVERrZkMx?=
 =?utf-8?B?ZWFlbXdwTDdUSGRDdGVDMDVNOE9zbUxxQmEvS2QvWWlkcGF6RzNPTDBnQVU1?=
 =?utf-8?B?L2RxU2xqUlJ3WUFxNDFUa2lkbGswTXphNm5kRmFpUGJUNm40RGR5Tlo4MTNV?=
 =?utf-8?B?VEVHRlJtK1lCZ1BUbDllbHJtL2hZbjhlUlM2ajU2UHUraUV2QmhxbVFGcXNE?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ab7eaf-f49d-438b-0a9b-08db61ad7ced
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:03:15.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQvYxaGRa3hWU5nxfvO0Z+jQ8i3S7tpzhb9wxZOHlST+WXzVxwqaCyfpjoT90+mMYYQFzEFRjH96feYncc1uRNBY5IvOHkIQ4R5prYwsN7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8364
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 5:44 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Move the definition of the acpi_thermal_driver structure closer to the
> initialization code that registes the driver, so some function forward

registe -> registers

I heard some people use 'codespell' for some automatic checking, but haven't
used that so far

> declarations can be dropped.
>
> Also move the module information to the end of the file where it is
> usually located.
>
> No functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/thermal.c |   66 +++++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 35 deletions(-)
>
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -70,10 +70,6 @@ do { \
>  			"Please report to linux-acpi@vger.kernel.org\n", str); \
>  } while (0)
>  
> -MODULE_AUTHOR("Paul Diefenbaugh");
> -MODULE_DESCRIPTION("ACPI Thermal Zone Driver");
> -MODULE_LICENSE("GPL");
> -
>  static int act;
>  module_param(act, int, 0644);
>  MODULE_PARM_DESC(act, "Disable or override all lowest active trip points.");
> @@ -100,37 +96,6 @@ MODULE_PARM_DESC(psv, "Disable or overri
>  
>  static struct workqueue_struct *acpi_thermal_pm_queue;
>  
> -static int acpi_thermal_add(struct acpi_device *device);
> -static void acpi_thermal_remove(struct acpi_device *device);
> -static void acpi_thermal_notify(struct acpi_device *device, u32 event);
> -
> -static const struct acpi_device_id  thermal_device_ids[] = {
> -	{ACPI_THERMAL_HID, 0},
> -	{"", 0},
> -};
> -MODULE_DEVICE_TABLE(acpi, thermal_device_ids);
> -
> -#ifdef CONFIG_PM_SLEEP
> -static int acpi_thermal_suspend(struct device *dev);
> -static int acpi_thermal_resume(struct device *dev);
> -#else
> -#define acpi_thermal_suspend NULL
> -#define acpi_thermal_resume NULL
> -#endif
> -static SIMPLE_DEV_PM_OPS(acpi_thermal_pm, acpi_thermal_suspend, acpi_thermal_resume);
> -
> -static struct acpi_driver acpi_thermal_driver = {
> -	.name = "thermal",
> -	.class = ACPI_THERMAL_CLASS,
> -	.ids = thermal_device_ids,
> -	.ops = {
> -		.add = acpi_thermal_add,
> -		.remove = acpi_thermal_remove,
> -		.notify = acpi_thermal_notify,
> -		},
> -	.drv.pm = &acpi_thermal_pm,
> -};
> -
>  struct acpi_thermal_state {
>  	u8 critical:1;
>  	u8 hot:1;
> @@ -1131,6 +1096,33 @@ static int acpi_thermal_resume(struct de
>  }
>  #endif
>  
> +static const struct acpi_device_id  thermal_device_ids[] = {
> +	{ACPI_THERMAL_HID, 0},
> +	{"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, thermal_device_ids);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int acpi_thermal_suspend(struct device *dev);
> +static int acpi_thermal_resume(struct device *dev);
> +#else
> +#define acpi_thermal_suspend	NULL
> +#define acpi_thermal_resume	NULL
> +#endif
> +static SIMPLE_DEV_PM_OPS(acpi_thermal_pm, acpi_thermal_suspend, acpi_thermal_resume);
> +
> +static struct acpi_driver acpi_thermal_driver = {
> +	.name = "thermal",
> +	.class = ACPI_THERMAL_CLASS,
> +	.ids = thermal_device_ids,
> +	.ops = {
> +		.add = acpi_thermal_add,
> +		.remove = acpi_thermal_remove,
> +		.notify = acpi_thermal_notify,
> +		},
> +	.drv.pm = &acpi_thermal_pm,
> +};
> +
>  static int thermal_act(const struct dmi_system_id *d) {
>  	if (act == 0) {
>  		pr_notice("%s detected: disabling all active thermal trip points\n",
> @@ -1235,3 +1227,7 @@ static void __exit acpi_thermal_exit(voi
>  
>  module_init(acpi_thermal_init);
>  module_exit(acpi_thermal_exit);
> +
> +MODULE_AUTHOR("Paul Diefenbaugh");
> +MODULE_DESCRIPTION("ACPI Thermal Zone Driver");
> +MODULE_LICENSE("GPL");
>

Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>

>

