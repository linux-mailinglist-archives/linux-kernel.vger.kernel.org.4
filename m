Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D687072A192
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjFIRqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFIRqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:46:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C26C210E;
        Fri,  9 Jun 2023 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686332757; x=1717868757;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cc9iwUij6vM+joAEwGbMl1FB/1ykWvdjLGPUa9gA69c=;
  b=Zb91PvTtsBlkDPSFr7qQvLs6/oT67rmDH0BWSY9UZBpu1rIbq8CzOxVH
   iTkvvq3v+9ixB6wfmw/3xSyDgNNWBGhNROh73IASWLvJO8OKixcHOV60b
   Uqj49LUkGgCzcejXvpaN0F6ve7ZuOH1ToJnBRCxbQslvqmJktZ62g1beI
   GBkk6j+oGzG6Ev3n8KFXHILEU5csqSBqNAqFYcTAzV49CXuPEqtc8HzKI
   sXGe1gaD9cjR9DT6/MNSpQdxUIst1AF6vHYBKKtByLDOWqMTIbvOhPagP
   okv1rfrje9nQV/tYrC1bN5s207HkU2U/0iw0Bj5PS9JPJGFNBq/qqUHvA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="338011996"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="338011996"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 10:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="854813845"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="854813845"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2023 10:45:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 10:45:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 10:45:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 10:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQYiPc2O2/HjfOMjNcx1AYLdNlM1eKTIb0JUXNwLuDMa9iw/DYw16Qr3FMHB4EUJKZMS7ohuOLFiPHAsXsgCKYj9IMjE6Iwl7hFBJn4uXww06mgkMFVF+Vyb4Tzwr3tFXZNBqih437vzAnTNHXPHLUmOJgS3Wpnnqe7t7e9hpNDhAnWOEAOahnkbUi+RvCDF6CBZFUM6y+6qTLdhXAqbIn+TxGOxAf8dcCAnEyf56z0/XHP7TVie5ECy0wNy9pCycwkDcm/BS1WWndwca57ieTDC5HDuRzXLKqXM1JAWSS1oN/BWxaX5ipOBWOTK9W73LHtFlr4xdRHurEUbvtvI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUxm/BScPbCIRx86/s8HYMILzfw7KyD6EYojQxOVxgU=;
 b=LaYP+o7ikz1bDRhEptNAk2cjy4UwL7GjkdZa5cLUZJo77lO78oPv8wi9LVSOZwZBMtM85CGkXm/u0dBSBRqKdOJB/gWWPZV3YCHYUjemuOh3z3KEv0U095/bwBBeesQuFFLEKzFTeP93V3B1jd8yrhdole/wcYG2rmyNKPMDNOxpVbaJKoxu0XLrE5oRPRxMp/6psDQNciyDWEo+wNcj1LalYdYE7YPOVSoV2/+4Bn/tXVjHQPKjffgiZOscl0XM2w/YKeLcUm7dyC1rimKJcGWYMXD4AzHUj8HPd8IGgW6MSq20COZyFIm/TC1Igs5b10Z14SPWLkQ/o8gloMKh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 9 Jun
 2023 17:45:05 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 17:45:00 +0000
Message-ID: <8d043ad3-e117-7bc6-d18e-6b7f17bf4de7@intel.com>
Date:   Fri, 9 Jun 2023 19:44:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFT][PATCH v1 1/4] ACPI: button: Eliminate the driver notify
 callback
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>
References: <1847933.atdPhlSkOF@kreacher> <2176493.Icojqenx9y@kreacher>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <2176493.Icojqenx9y@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0258.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::11) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SN7PR11MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad85273-9f09-4139-4f9e-08db69113f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TwOMr3iuJEBlACKdb93Pu7QhQRJoAwJd83LXlPa0J77NOohYWy4sIdf8cqDW4QDW40SlgGbnsQ8UucVPF8F8xpYfXcsM2hz4H2Bw/JjlNR9RgD2zwt8Nn+tk+vB81Eaw46BcKs41YWj2C00zxcBOBuIYiAhZ7WJAsgXh2VyEeBU3oc7THbGU2n0njA3qoWyTik9eEYbn3+fhQw45+le2biE7aT3kNW5k6cbpTMFHnfV4Iaw+usKzxB0/UZB9e9mpL1BvD9RY3HtvtMlsF7feGDRyB1bQOQBKKefy46TZa8pSh6617kQbNBR1ygnP4GmEdEc3lj5qUMO+xgxwI65MxziPvY1ByL+RoH8g3Ych5yTO+76C2jWD+le10g0nQowQsxzHN2355xM1sn42o/XGVQXtOiQM4WMT9+JKSkoqmWMRAU0t3QYz/jQljsfOM45BAAB5XmdRw7l0gqdwnLEcQlaFc9SOApdbHtq5adSydAOK2aF0TEXHV8NUDoteBOLo9TaksLb/eG7O1etND59Soa8N6ME1W7w/8DyfJHVVITVPI1n0xX+Gnf290wq1QpQArj3dVWXBi2FQUSdUeHZDKDDiTfMKpgSm/7b4w0BybOSOz0KReo6epT1g9tagprjfWOGPQQ8+ClVxpl10XoT6PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(66946007)(4326008)(66476007)(84970400001)(8676002)(8936002)(66556008)(2906002)(86362001)(316002)(41300700001)(110136005)(31696002)(5660300002)(31686004)(38100700002)(6486002)(478600001)(82960400001)(6666004)(53546011)(36756003)(186003)(6512007)(6506007)(26005)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9iQ3NtSllzelZReXRJdTNITVNBc0o5TTVrMCtWN0Q5UEdwYVhPeUtYUGp4?=
 =?utf-8?B?Q1E2ZFVPTGM5ekw1TEp1WGxSRVcwZmUzZU1RT1UvZE00KzJ3Vk9HT2dzS1dB?=
 =?utf-8?B?aGhXeE1Oa0UzUmdaU0VZakQ4T0gyckcvWWdXWm4ycVZvWFlPWG91LzhDS1FH?=
 =?utf-8?B?YTNFL1BFdEh5QUh4c3NlQjFucWUyZVFXcUUwYktDMmRDdWZUMHArUS8ybUNI?=
 =?utf-8?B?amQralRaNnJxUUlzN1o0WFJrR0FoQmZCRHlTZHBOWTNFZldUWnhTeDAyUUp0?=
 =?utf-8?B?dGprR2RyaXN6QzNCOVJIR3FWa09ydVBZLzl3SVhVWjVkSFpFQmhacktZMjFq?=
 =?utf-8?B?eDQvYTdzNEpzbllLbEZmdFZNUVEzVnRia3dqbzZ0MVNGL253a3ZqNWtMcXV6?=
 =?utf-8?B?QXhlYWdFWUc0ZE1WdWR5bldoUzVLc3BnYjFTS0tXTW5jeEFvQzAwSTRZOEVo?=
 =?utf-8?B?SHBlMVRDdm5Kd0puSTc5RHptSWtuRTVXM3JyM3ZKYTVNak5QbTQ4YTRyaldW?=
 =?utf-8?B?cU4vSjhuUVQrb2l3L09TeWUwRXd0NUlCNnN6K1lBTW5HVE9yYTlOLzFsaFUr?=
 =?utf-8?B?YUIzcjhpKzgxUjJ4amVYb2tZdUltTmRoa0oyU3ZxN1VNdjJrT0dwNnhoTVp6?=
 =?utf-8?B?eGJ1bW9Sc1JkczBHV3JaQWI1UGJaa3E0ajhqUkZDR0JQK0toV2JkSlBDZ3RG?=
 =?utf-8?B?eDQ2S09BZCtkQ2tjUm9PM3BOMWFMeHFlcGdodVd1NllDeXBmZGIxTndFaDF5?=
 =?utf-8?B?YmI3T3JsR0FMZmV4VUZ4MFRPcjJqdUQrc1B2TjduTDdBWWNuNmtzSHZkSzZ0?=
 =?utf-8?B?R3NXZ2RSdVNvZ3F5ZStucnB1cmhHZVVlQml0ZHBPME5CT2pKL0dkbHZKd3ha?=
 =?utf-8?B?RWNYOEhlcHlERUFWRUNBSUJjeVJZVjBTVmp4MFBvcklvbDdreWV1cFM2UGNL?=
 =?utf-8?B?ZDE3UFE3Rnlha0E2aGh2Y3Vjd2tFYjI4QVI1MVQrQ0pLRTNTcFR1ay9LS29L?=
 =?utf-8?B?OFg2RjREL1NTMlowL0dpd0dINGdMRGZJUmc2eVRZZTA0TU9TRDlWakk1dDlK?=
 =?utf-8?B?SC9BMkRQT1FIYWdSQUhpZ0dWSXlKK2FyckxHSzJicldTWWNpUCtSc25hZy9a?=
 =?utf-8?B?OGxUdG8xRlkwNitWemVPZWhTeENjZGFVUVFBdU5xU3NjQk1lcUZiSlB1cmhl?=
 =?utf-8?B?Y2NiRXFoeU5tWmp5L0dxQ05DeThQWlNST0xZb0Zmd29ITFVGUVNmQ0w5OWVy?=
 =?utf-8?B?SmtIWW1WRUcvUmN0ZHE5NWZWSTNyRi9lbkxRRjkvMHcyNjFmS28rWW5teTFq?=
 =?utf-8?B?YlEvTlFkWWZyYk8rRzJXMHk4SlltRkFxTEFJOHRBK244dUY2QjlXN2ZuaXJm?=
 =?utf-8?B?WHNQcy9ERTR5RHptZll4Vno0alhuZFk2WmJEUEhPVEJod0dDVzNicXRXOEZ5?=
 =?utf-8?B?ZFcvdWkraGxuZGJwRW9nMDl4OXQ0OGcyTXcvVjI5b0hjSkJBUzJ3bitMand6?=
 =?utf-8?B?MW4xYzdDSkZaTU56YjZYbWtabU4zVmdxYmdwSjgvenJZTGlSTFhreVFQWXhw?=
 =?utf-8?B?czU2aitUZzZxbE1YVVY5eGRISFVOaVFmT00vUTRNVERjUVd5K3lmVnFoVjNl?=
 =?utf-8?B?U1NYcFRYOFhjVXluOXNLZ2xJMldIV0oxdmV3eG1oTHdjbi90VWZwMmFISWFC?=
 =?utf-8?B?d2Viemw2RVdLRjk5U3Bvc09kT3pCd2lhNlJuNUNHU2NZK2x5MGc2SkpiMXA1?=
 =?utf-8?B?enpVYnlUSHBBK1hpalpJWXA0c0daazRRNEpHQnF0TUFjYXRoREEyV1hyRWRa?=
 =?utf-8?B?aDZJM1VrOU4xSExERFQ3aDlodnNTaVBMaHVUV09CQUYwTGJZTDZDT3NWNFlz?=
 =?utf-8?B?THNyUHQwNGhyTU92eW5rejJqN2g1ZC9EQ2NldS9qQkd2d2kwTFB3aEprRGZO?=
 =?utf-8?B?NzJUZlVOTlRmYzFXRUdNTXNYRmI5aXR5VHFEQU9DbEl3bEJyRVdmZzZVUXpX?=
 =?utf-8?B?a1ZWRGdKNkQvcFo5SWZ1RzMyWHBQR1h1RmVuTkZ6UWZqem9NcE9vY0hteFc5?=
 =?utf-8?B?SEM2YTNYaXhIV29rQ1BYVk53bG9DN3RRT21EL29BTjllUVZnSGhOL2MxNHZR?=
 =?utf-8?B?M0hjZVBpSUxnRkJlMG13SGpwbnl3NG1WNTJWYUJhZVhKYTJSZTVyVWRVaXdQ?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad85273-9f09-4139-4f9e-08db69113f61
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 17:45:00.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A78Fe83NySACqvilTg/xd/yNqGr+CC2gvRoNRzVbF3PT1XHXYdGJnumNYotP6/Be+/hZ68qrSa5NlNiIgIlVzElXjdD14r+jsUIHP9+NNm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
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



On 6/4/2023 5:19 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Rework the ACPI button driver to install notify handlers or fixed
> event handlers for the devices it binds to by itself, reduce the
> indentation level in its notify handler routine and drop its
> notify callback.
>
> This will allow acpi_device_install_notify_handler() and
> acpi_device_remove_notify_handler() to be simplified going forward
> and it will allow the driver to use different notify handlers for the
> lid and for the power and sleep buttons.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/button.c |  140 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 96 insertions(+), 44 deletions(-)
>
> Index: linux-pm/drivers/acpi/button.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/button.c
> +++ linux-pm/drivers/acpi/button.c
> @@ -135,7 +135,6 @@ static const struct dmi_system_id dmi_li
>  
>  static int acpi_button_add(struct acpi_device *device);
>  static void acpi_button_remove(struct acpi_device *device);
> -static void acpi_button_notify(struct acpi_device *device, u32 event);
>  
>  #ifdef CONFIG_PM_SLEEP
>  static int acpi_button_suspend(struct device *dev);
> @@ -153,7 +152,6 @@ static struct acpi_driver acpi_button_dr
>  	.ops = {
>  		.add = acpi_button_add,
>  		.remove = acpi_button_remove,
> -		.notify = acpi_button_notify,
>  	},
>  	.drv.pm = &acpi_button_pm,
>  };
> @@ -409,45 +407,55 @@ static void acpi_lid_initialize_state(st
>  	button->lid_state_initialized = true;
>  }
>  
> -static void acpi_button_notify(struct acpi_device *device, u32 event)
> +static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct acpi_button *button = acpi_driver_data(device);
> +	struct acpi_device *device = data;
> +	struct acpi_button *button;
>  	struct input_dev *input;
> +	int keycode;
>  
> -	switch (event) {
> -	case ACPI_FIXED_HARDWARE_EVENT:
> -		event = ACPI_BUTTON_NOTIFY_STATUS;
> -		fallthrough;
> -	case ACPI_BUTTON_NOTIFY_STATUS:
> -		input = button->input;
> -		if (button->type == ACPI_BUTTON_TYPE_LID) {
> -			if (button->lid_state_initialized)
> -				acpi_lid_update_state(device, true);
> -		} else {
> -			int keycode;
> -
> -			acpi_pm_wakeup_event(&device->dev);
> -			if (button->suspended)
> -				break;
> -
> -			keycode = test_bit(KEY_SLEEP, input->keybit) ?
> -						KEY_SLEEP : KEY_POWER;
> -			input_report_key(input, keycode, 1);
> -			input_sync(input);
> -			input_report_key(input, keycode, 0);
> -			input_sync(input);
> -
> -			acpi_bus_generate_netlink_event(
> -					device->pnp.device_class,
> -					dev_name(&device->dev),
> -					event, ++button->pushed);
> -		}
> -		break;
> -	default:
> +	if (event != ACPI_BUTTON_NOTIFY_STATUS) {
>  		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
>  				  event);
> -		break;
> +		return;
> +	}
> +
> +	button = acpi_driver_data(device);
> +
> +	if (button->type == ACPI_BUTTON_TYPE_LID) {
> +		if (button->lid_state_initialized)
> +			acpi_lid_update_state(device, true);
> +
> +		return;
>  	}
> +
> +	acpi_pm_wakeup_event(&device->dev);
> +
> +	if (button->suspended)
> +		return;
> +
> +	input = button->input;
> +	keycode = test_bit(KEY_SLEEP, input->keybit) ? KEY_SLEEP : KEY_POWER;
> +
> +	input_report_key(input, keycode, 1);
> +	input_sync(input);
> +	input_report_key(input, keycode, 0);
> +	input_sync(input);
> +
> +	acpi_bus_generate_netlink_event(device->pnp.device_class,
> +					dev_name(&device->dev),
> +					event, ++button->pushed);
> +}
> +
> +static void acpi_button_notify_run(void *data)
> +{
> +	acpi_button_notify(NULL, ACPI_BUTTON_NOTIFY_STATUS, data);
> +}
> +
> +static u32 acpi_button_event(void *data)
> +{
> +	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
> +	return ACPI_INTERRUPT_HANDLED;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -492,8 +500,9 @@ static int acpi_button_add(struct acpi_d
>  	struct acpi_button *button;
>  	struct input_dev *input;
>  	const char *hid = acpi_device_hid(device);
> +	acpi_status status;
>  	char *name, *class;
> -	int error;
> +	int error = 0;
>  
>  	if (!strcmp(hid, ACPI_BUTTON_HID_LID) &&
>  	     lid_init_state == ACPI_BUTTON_LID_INIT_DISABLED)
> @@ -535,12 +544,15 @@ static int acpi_button_add(struct acpi_d
>  	} else {
>  		pr_info("Unsupported hid [%s]\n", hid);
>  		error = -ENODEV;
...
> -		goto err_free_input;
>  	}
>  
> -	error = acpi_button_add_fs(device);
> -	if (error)
> -		goto err_free_input;
> +	if (!error)
> +		error = acpi_button_add_fs(device);
> +
> +	if (error) {
> +		input_free_device(input);
> +		goto err_free_button;
> +	}

This logic is correct, just a bit weird to read and it's saving just one call to input_free_device().

>  
>  	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", hid);
>  
> @@ -568,6 +580,30 @@ static int acpi_button_add(struct acpi_d
>  	error = input_register_device(input);
>  	if (error)
>  		goto err_remove_fs;
> +
> +	switch (device->device_type) {
> +	case ACPI_BUS_TYPE_POWER_BUTTON:
> +		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> +							  acpi_button_event,
> +							  device);
> +		break;
> +	case ACPI_BUS_TYPE_SLEEP_BUTTON:
> +		status = acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> +							  acpi_button_event,
> +							  device);
> +		break;
> +	default:
> +		status = acpi_install_notify_handler(device->handle,
> +						     ACPI_DEVICE_NOTIFY,
> +						     acpi_button_notify,
> +						     device);
> +		break;
> +	}
> +	if (ACPI_FAILURE(status)) {
> +		error = -ENODEV;
> +		goto err_input_unregister;
> +	}
> +
>  	if (button->type == ACPI_BUTTON_TYPE_LID) {
>  		/*
>  		 * This assumes there's only one lid device, or if there are
> @@ -580,11 +616,11 @@ static int acpi_button_add(struct acpi_d
>  	pr_info("%s [%s]\n", name, acpi_device_bid(device));
>  	return 0;
>  
> - err_remove_fs:
> +err_input_unregister:
> +	input_unregister_device(input);
> +err_remove_fs:
>  	acpi_button_remove_fs(device);
> - err_free_input:
> -	input_free_device(input);
> - err_free_button:
> +err_free_button:
>  	kfree(button);
>  	return error;
>  }
> @@ -593,6 +629,22 @@ static void acpi_button_remove(struct ac
>  {
>  	struct acpi_button *button = acpi_driver_data(device);
>  
> +	switch (device->device_type) {
> +	case ACPI_BUS_TYPE_POWER_BUTTON:
> +		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> +						acpi_button_event);
> +		break;
> +	case ACPI_BUS_TYPE_SLEEP_BUTTON:
> +		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> +						acpi_button_event);
> +		break;
> +	default:
> +		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
> +					   acpi_button_notify);
> +		break;
> +	}
> +	acpi_os_wait_events_complete();
> +
>  	acpi_button_remove_fs(device);
>  	input_unregister_device(button->input);
>  	kfree(button);
>
>

Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>


