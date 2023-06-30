Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916E774388A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjF3Jms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjF3Jmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:42:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5192F10B;
        Fri, 30 Jun 2023 02:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688118161; x=1719654161;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MVR/f5BHd9q4P9aDF1bNnrxsCSGT9hXdTOcYfNKmsms=;
  b=YM+1UJ2r2YMzOcW2uIGDD37e4ewAHB4yb7WOC0sntTriN2fDIHqCwUQs
   v8S0MedxtmJ6qGjjCOpgNBRi9ixVIZF1d4Nvw+MezbCtIyuQQL7+WvBh7
   la7zsPlXhBK2c+o5E80odUxRoz+8DqTFbXwzWhNShP9GRz9UlTeXgwWfJ
   CMCV2SbMV6cEYdRXXb7c+p3RD0nF6G9UcIXgeZmS9qVwkYievbY4Hqz2f
   21r0FEVH5Yjaxs8Siwrry8SyyWsw0WZlxFak8fvZSyOu860QgNTTb+TVp
   p5cdZt/jCuVCTHAbI5rlR+kr2fuc5YyBsL4SrGmCNs3ZXBLsoqbvGJRP3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="448734139"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="448734139"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 02:42:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="964321480"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="964321480"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2023 02:42:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:42:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 02:42:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 02:42:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpRJcQiHZ4YprAykLNoXLOJB2LyHbEQfOrLcDyrzXUnAbbxjuOKf64Kg7XI3FNTn/mQYcaxzpJXClOI2WWxAAlZiAq2jmHpHmhh8AXAoqw3QWBrdCqGV5I32nnLzob+jeCuIimh/iTQAAgFq2o+tIVJ5k/lnYs2TWy+I5lz/VWKUkSBB1uQf0CakT4COJjTa5UaJWD+3+4aO7MSYR64JICVf+d7UT4y2TYtpfhWs85+k99gqO+sffmLKKO2hkLEDJgKNORU2moy1fV8Z/ZILIVL+VigeU/XdfEdYwtcBbEBW+gzm4CQyyEUqfLfYxRN6IleG1PuOzWv1yJixC2CLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BTj5GJC38llJjIz8acHoOPbgbm83HGqo+J/1jG3U1Q=;
 b=n9o55BDWIiFffmN9WmzH/wEcrxXltPKYlx2yCxPpjXhPvGJe9eCPPuD0YZ8FXrDi6+pi25zseJIX0Hh1DFGH3gToBhR3XTKOE72gVoJIbrFys7UyUO9I2iu0Ok0ImSaSW2/9Gi0hpH41PPa39bztOy6uaf9xcSNmt2yO1E9LEQ8q3wYgl0NGSjK1l6ceW97obym/qfT+1iAYO3rp2t5YfKV3gTxksFAe4umvdFSZOp2dGNpFJ1hI6Pcl0Nlo8eu2ELj6PY1h+Rf+zDjqe9BjY/zkPuHBJJbDmt/6fO50irh665bTZwBLGfg+y8MeY/IKmtZ+8etfceIY1wvt2k0tNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by DM4PR11MB5486.namprd11.prod.outlook.com (2603:10b6:5:39e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 09:42:38 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:42:38 +0000
Message-ID: <a7d71bff-8577-09f5-5014-5987da1b7c6b@intel.com>
Date:   Fri, 30 Jun 2023 11:42:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 04/10] acpi/video: Move handler installing logic to
 driver
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-5-michal.wilczynski@intel.com>
 <CAJZ5v0hZ-2Ee0DCcgzHJrOikRTOJuCbEbQj24xui_-vmbd+47Q@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0hZ-2Ee0DCcgzHJrOikRTOJuCbEbQj24xui_-vmbd+47Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::10) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|DM4PR11MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d58d20-c0d7-4182-5506-08db794e5711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWt5pfBXF4YRJlhW015I1pnA+0fZN7QdigWiIw7LH0SBgYIRv2xw6KNJcm4vois40XluPVPW5Y5MvYjS5MzMUqmqM/iFc9BSrzHAleBZWpz2wLo8MtDP/Njs3UvY7ZjYW2d/J5UDrTvBzopF96Gog6KQPjZAOszu7cH1e4E2b2KkOujzme+zcds5ZeZC7NkWPQtkhHlwVIDyJMJXhKb9wiPCJlW1AgZc/5tvAvXtVYQyQQ7CagiE58MNviYU6vVO/tmh0Re0Mua2k+cvZvrJNXPTB1YO99Kq5ncypmQZ6+7cPVuy+U546UUxaU3iXM0HJzTON4bmoeI5NYGGYsJq5rpOX+GahvSQ5yuKWhgm7V+gPMM/krpQ1ZNpRSx9QyFfNXsHL91qPoMOQ8LHEJfgPCbq/0u6ZAYtjF7eUPMtCO/cvgZARNYo5mV1EIAXkWF6iBstj9hf14eAeubUQyyqKAq8zjC1kPSc85QaR24yEXbQKg06bc3LzEHb5vBWtVaZF938pF4f2xhjYsbU4fiFICcoQdm9HVkqJu96ACK5hrn4aMFIO+yFvUDAxXchlo49AvH+mEAYWjOhiP28EeCYx5D93nDPsVXATKazNeFlkCTpVxl9uAa9oAcVSEaJ2QHFodbIH38jSwCh+hGBcxkkLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(31696002)(86362001)(36756003)(6916009)(66476007)(66556008)(316002)(66946007)(4326008)(107886003)(6666004)(478600001)(6486002)(8676002)(8936002)(41300700001)(2906002)(5660300002)(6506007)(82960400001)(38100700002)(2616005)(83380400001)(186003)(26005)(6512007)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWMwNHBLeStJMEF5WWdBaitkY0pNS2k2Ri94M1NldktSTXpLUSs5dXhxRkJp?=
 =?utf-8?B?VURpbTdKMGduNGRVRmh6d2U3NXc4YXJnd2hPWGd2TGkxeDlYTWl1bm5pbEtE?=
 =?utf-8?B?SUwva3psaEZ3aDY5L3V6MGordUVvVnBqZGNsY2FibmdOazMvc2NTMktqYTZR?=
 =?utf-8?B?U2tZZ3NlN3hQdVVUbGZoT3BRQVcweHRlY3paTzdMMzNOMHQ0WVZ5RXY1NCtI?=
 =?utf-8?B?YllHSm9KcjNoU0U1aUdSdzNTcWJROGlmUGc3WFgxa21ma1RpQjBjWUdrMHFp?=
 =?utf-8?B?SS9XQW1aOVJsVUFsN1ZFK1Z1UkZyczN3bm5RczM3N1B2RndWdGU1VHJCeE5F?=
 =?utf-8?B?OHZSMDl2TXF0Y2dEaVBwSDhCVWcvc3JRL3pZUEtBUU9mWW1vWHRLWEZUUDhV?=
 =?utf-8?B?OERNbnVWbzB1LzNIcC9JTE5tY1lBYW55K2IzdldPOTVUY1BZZkRjOHFvcFN2?=
 =?utf-8?B?Z1lGVlhIWWtFM2I1azJUUG1aUWNwUjBHMHhoTkRvVXBNRnRjN3BTUTZzQSth?=
 =?utf-8?B?amZaY2dNSmxWRFpkb2Nqc3FhQU5oUDFSRHZKVC8vdnlPNmJWQmdpbENBVEhB?=
 =?utf-8?B?RElCRENidWlpZUJ2QlZjSHorSnc5MlQ2UnVjMzFoUC9MR2FjY0dES1QzbHd2?=
 =?utf-8?B?MktaYU1EV1dDQlp1QXpLazVXNTAwVEVnay8rT3J6cWhiWm9QR1FIVnRKbHVK?=
 =?utf-8?B?Rk9udkY0RTFlM2Z5VEFLQkNVRjZWd1BYM1VtZndjcWdaWUNBbjhrNnpFNlRi?=
 =?utf-8?B?V2E0OWtKdW1IMWg3NXdJbDNnckJnNTNzRFBvaDlpOXlRbXVOZ1BNNmFGaThO?=
 =?utf-8?B?YUlIMERZd0t1b2dKRUVqdDdHZnVyT2hZcVh2OTdRZDVOOUtCMk9RUjhNYVAw?=
 =?utf-8?B?ZHBSb0k3ZzI0Y0VkM1lWdENITm5XNUYzYThrM3hnb3l3bU5hSWgxVzYzemVC?=
 =?utf-8?B?ek55M2NNVmlKUWVHSU0zYUJEa3pieTJrR1ppNDQ2QmVhRjBZaHlVeUZIYThF?=
 =?utf-8?B?NUt0ak11ME9sYmpDSGZ0andKTXpCRzI2UVA5dmVDek44Mkd6WU8xWnNmV0pK?=
 =?utf-8?B?K0tNNnBxUWRJbkxTZGRaZFFtZkkxcTlJZXRWVDIxVy9taE05V1JzcEFPRzFy?=
 =?utf-8?B?N2NSM0NLNXMxUWRNYzVtZnh0YXFLOHZFTVF6MTJ4Sk9IeDg2VDlGQzJCeXdZ?=
 =?utf-8?B?a3ViMlFIYUVjd2VwbGNmVlNBaGhxQ2pETTdiRWE4Snh6WlhxYkh5eUttZVp0?=
 =?utf-8?B?Nzk1Y2hkSlBwRm55YklwUlBTZkEwYVhLZ0ZPYzE2UFBuTEJHQWs1Ri93aXFn?=
 =?utf-8?B?anRLWkhENkVWTjlIUEF3czF6V1dtaTg4OStXbkllU29va2tYVzV0ODhYVmcv?=
 =?utf-8?B?RUF3d3ZVTHRuRHZlcEpZdDNxR1lwNHdYT0lRaDlzSzNscXQ1QitNU2VPNjBh?=
 =?utf-8?B?TkVGWElJbkcyYlZqdytCamNnOHBHS2l3bzI2NFNMcEppeityRUV3bi9CUk11?=
 =?utf-8?B?WlhyU0xEeFhWUVBuWjl4WUpDRFlrOTlZWEZoaWc0UmhhWThKdFZYK3QxVG9p?=
 =?utf-8?B?YUVNc09Eb2RLcW5PQXNlbGlDaWs1K3VmS2xVN2c5YllzalpFamtINkd6NXB6?=
 =?utf-8?B?RUZGeEt1NUlJVmtERGZZSHBCQ3BmRjVEQ2lTalkvZ3NLNGl4ME1KQVhZM1V1?=
 =?utf-8?B?TmQvSWJja2tiRmh0eXQxSEF6MGZnWGlhV1FRVnFmYk5tWS9ocVBVcFI0a0Rt?=
 =?utf-8?B?ZmpyVkRQajlRRDhFRnhnOE5FckxXV3ZhSWl2M2RwdzFWUGVabysxUkpWd1JR?=
 =?utf-8?B?N25GOWZZdlp3NmJJNXhHSHA0YlhPa0FUQ0V1dFp1amwvbno1UWhrK2Y0VjZS?=
 =?utf-8?B?UGdxa0l5aHhScy9xTGtGNXNiNzdlc2VBOU42eTZ3SlZwQWtEbUJ0SUo1eXlN?=
 =?utf-8?B?QkZYdW5iQ3VUWE5FNjJHbVlNNmVadXUydnJ5MEd0eDJWUTF6RUJ5MnoyVmZr?=
 =?utf-8?B?ZHpjeFVJeFhGay90aE5XMU5uU1AwU1MvUExjQUM3bzNhc2szN3RpREhQbjdw?=
 =?utf-8?B?a0NHZnZVSWE3Qk5oYzBkWjczOVkxcmY5ZnJORUd5LzlPOCt6YzZjNktCYW5z?=
 =?utf-8?B?UVBhM2JYVS9RV29Nc0NtdHpkYlVscnFkRVNnSCtNZTBDSG0zYStUUW1IcVM1?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d58d20-c0d7-4182-5506-08db794e5711
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:42:38.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHn7voEAp0UxrFEGpWPNrhTPhALu6/e4unTmoOqgHiyD4fCx7FPgpIZweh3UylleP7T5m70Ui0DRzLxleyG1+aAQLUu9HQqDwNDHexhSBd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5486
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



On 6/29/2023 5:58 PM, Rafael J. Wysocki wrote:
> On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:
>> Currently logic for installing notifications from ACPI devices is
>> implemented using notify callback in struct acpi_driver. Preparations
>> are being made to replace acpi_driver with more generic struct
>> platform_driver, which doesn't contain notify callback. Furthermore
>> as of now handlers are being called indirectly through
>> acpi_notify_device(), which decreases performance.
>>
>> Call acpi_dev_install_notify_handler() at the end of .add() callback.
>> Call acpi_dev_remove_notify_handler() at the beginning of .remove()
>> callback. Change arguments passed to the notify function to match with
>> what's required by acpi_install_notify_handler(). Remove .notify
>> callback initialization in acpi_driver.
>>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> ---
>>  drivers/acpi/acpi_video.c | 26 ++++++++++++++++++++++----
>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>> index 62f4364e4460..60b7013d0009 100644
>> --- a/drivers/acpi/acpi_video.c
>> +++ b/drivers/acpi/acpi_video.c
>> @@ -77,7 +77,7 @@ static DEFINE_MUTEX(video_list_lock);
>>  static LIST_HEAD(video_bus_head);
>>  static int acpi_video_bus_add(struct acpi_device *device);
>>  static void acpi_video_bus_remove(struct acpi_device *device);
>> -static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
>> +static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data);
>>
>>  /*
>>   * Indices in the _BCL method response: the first two items are special,
>> @@ -104,7 +104,6 @@ static struct acpi_driver acpi_video_bus = {
>>         .ops = {
>>                 .add = acpi_video_bus_add,
>>                 .remove = acpi_video_bus_remove,
>> -               .notify = acpi_video_bus_notify,
>>                 },
>>  };
>>
>> @@ -1527,12 +1526,15 @@ static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
>>                                   acpi_osi_is_win8() ? 0 : 1);
>>  }
>>
>> -static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
>> +static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
>>  {
>> -       struct acpi_video_bus *video = acpi_driver_data(device);
>> +       struct acpi_device *device = data;
>> +       struct acpi_video_bus *video;
>>         struct input_dev *input;
>>         int keycode = 0;
>>
>> +       video = acpi_driver_data(device);
>> +
>>         if (!video || !video->input)
>>                 return;
>>
>> @@ -2053,8 +2055,20 @@ static int acpi_video_bus_add(struct acpi_device *device)
>>
>>         acpi_video_bus_add_notify_handler(video);
>>
>> +       error = acpi_dev_install_notify_handler(device,
>> +                                               ACPI_DEVICE_NOTIFY,
>> +                                               acpi_video_bus_notify);
>> +       if (error)
>> +               goto err_remove_and_unregister_video;
> This label name is a bit too long and the second half of it doesn't
> really add any value IMV.  err_remove would be sufficient.

I've seen different patterns in the code, sometimes the label describe what failed,
sometimes it describe what needs to be cleaned up. I don't really have a strong
preference, just thought it might be useful to the reader. Will change as suggested.

>
>> +
>>         return 0;
>>
>> +err_remove_and_unregister_video:
>> +       mutex_lock(&video_list_lock);
>> +       list_del(&video->entry);
>> +       mutex_unlock(&video_list_lock);
>> +       acpi_video_bus_remove_notify_handler(video);
>> +       acpi_video_bus_unregister_backlight(video);
>>  err_put_video:
>>         acpi_video_bus_put_devices(video);
>>         kfree(video->attached_array);
>> @@ -2075,6 +2089,10 @@ static void acpi_video_bus_remove(struct acpi_device *device)
>>
>>         video = acpi_driver_data(device);
>>
>> +       acpi_dev_remove_notify_handler(device,
>> +                                      ACPI_DEVICE_NOTIFY,
>> +                                      acpi_video_bus_notify);
>> +
>>         mutex_lock(&video_list_lock);
>>         list_del(&video->entry);
>>         mutex_unlock(&video_list_lock);
>> --
>> 2.41.0
>>

