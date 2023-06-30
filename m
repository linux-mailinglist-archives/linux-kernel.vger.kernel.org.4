Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB36A744037
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjF3Q5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjF3Q5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:57:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C171E3593;
        Fri, 30 Jun 2023 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688144220; x=1719680220;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h7uxadgT9xdmcIDAYAWaQqoPknneE7Rmp/fSDphJr4c=;
  b=CZrKLwIJL/nroied52EJmjuXX40GFA2Ecrx6FoIyIRZcaECBRH8SfOFy
   C72AaxzUAuJIDWQNf7O/bwgj2GD61wBnNr9AO+bXP3akCImbj0eTfsuSv
   RHO1Fbn/K6mK0IHlZTqWzHZAm/6Rbb8C4yYDVCN3dvuHOxbyxgqN3Etcs
   Td1i86Kb7cIl83wtl9qiDIqyTBxwtxV+UhIwnYWjCr14mux6b2ezeeb+5
   syuWweZzRMQxG109xRbuv8JAfmwovPzu/b5kYOWgnqUDtdELCFS/cyYpx
   ZyShCq4OhU8YLkOkSY70+1kbREaYIRoa/2DA1zp+FZlPOCXpmxvoJR7Z9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="347221875"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="347221875"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 09:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="807833804"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="807833804"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jun 2023 09:56:59 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 09:56:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 09:56:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 09:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wb4Q3nP+rjiB6+Uwpb/J+VKCbfOKk5x+nlJGI7nqctTJFE0vCRBWnyYQbIRKanfdryciXvAyIq4hBpxKKKJAmR/o3xMG2pLb02QCXtiVofREq3iILN7Mki/w5wVOPzbpcC3HdzOY+ZD+9hQn7gJjsTIHqWE0aOpp/TJ25muweiMWy7qM/CUxmr2gqLagBbzna2p26t9R0+UVwA130VSof6Bpaf0I6HKEfKALTRthiXNBiv+c/x985kZ37wz9Wa5wEV0NzVVcyE+RVbPYQFf6Nywx1is4Bc3KXCj8uItUsqhIxnubWEVk+bfDlB9kEEccelvtkLMEfW1YVjH4+EyXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ViRpKXy6807RopMv74LOmylXodazl8k8rmHFYkwIS0=;
 b=U55zJdHHqYvd/mUGEml2MB6312uO/b+8q26Q7fjI4vMam1jSH/XfSqlSDMrL6YcQLcGz62fiLVhtkbyYLJ04ct9OTA5+2qOmqeHMwx/DP/3jYB031hmhIX5FPvt/yhVIqPcOkyFCHkpPiFFLCpb02EwSWG7DbNOZsVfvBa7X+VtmarFY4lVnB5WhxHyoNQgT0wGlsU/BilpYfFIgA1ZWvqAmwl794a7kvKxMXgfgXST2+a54ktmyRVRN5286X9GwXznKPKqRlPd3A29s7nZkdduqWgaLnhwf1wrebwiIIAGffd9DL2pXVkxS9W9t63TceNCmZfKCJhXY1RYnldL5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by CH3PR11MB8316.namprd11.prod.outlook.com (2603:10b6:610:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Fri, 30 Jun
 2023 16:56:52 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 16:56:50 +0000
Message-ID: <81dbbc8f-fc05-754d-56bf-5e74169b8dc8@intel.com>
Date:   Fri, 30 Jun 2023 18:56:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 09/10] acpi/nfit: Move handler installing logic to
 driver
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-10-michal.wilczynski@intel.com>
 <649def832ce1f_11e68529491@dwillia2-xfh.jf.intel.com.notmuch>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <649def832ce1f_11e68529491@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0323.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::8) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|CH3PR11MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 598b07e6-7d51-4e9e-1b10-08db798aff95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYKWqKGG7wfxMbrPFzm4MIeeNZvMns9hmGAKltrHSgzKFZmj37SN0XpH3If1E7HamQpLlsSxsCZqGrGozt1JSeXB8WiyDcelUDVmPtE4nOtr/wyzGlWccSM/iO+rr4HSxEAdK+3svpmZY+JoTIkJRvVMaMGMj1jLtJdgsYlxYiiDFluyrhy1xMlFQzY0ZsoMtmZw/ACKf7IJuJTkbBbqva0Y6SbVrEcSEx8tm1mXyqJF1wUJLYTMPONH9Q5p/itS2w87hiB/YuVVUnsfeE3daOSHhT7ZztcsDG5Tbk60PTbKQLz0Vd0QC+AXX/5L2YymDmy7gZQB5xzdfgT3E1DDqgWqtQ6h6AkGdg5qbrnq2Hbrzys117QdshkRQlWQYm/1QSpXmEg6wxq91qKnTUIAnVyKYSVy80w6RzFNiPl5pIjeMaJFEE0qHaGoB9tZZ/4ypoRst/ccEAKkDOW9KvHjykwnpQnJX4iKt9GvchHYZDe1C5IfQZymFseLCuaDh02ybaZSeT5ujBYXtCcI1kPkc80b+uEAQECWgRuwTKZeWeduwi+SG3lKSQRDAsG2WBBteGezgud2ONnXgHJPn10YmEeh/o+oVBSTikKv4Qh52ZEnfuOlwNcr6skZZyGlPgBeE9OKx8VP6oXR85QbjtVDjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(2906002)(6486002)(186003)(82960400001)(6666004)(38100700002)(107886003)(26005)(83380400001)(6506007)(2616005)(6512007)(53546011)(41300700001)(31696002)(86362001)(478600001)(316002)(66556008)(36756003)(4326008)(66476007)(66946007)(31686004)(5660300002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdWajN3WUxMWEVFWDQyb085Y2JVUzcxdHZSKzRuQVJidVJvRkdoZGIvM2xr?=
 =?utf-8?B?c3FhZzlKTktnMzljNW5GTm5wdk5XUWZhMEJHeXgyWUltbHU4Y3VjVnB0WHh1?=
 =?utf-8?B?THA5c001TWRnbXBjNTNQT2lxSS9lVlpadGVzSTNWelFSMWFLY01VNFJMY2pO?=
 =?utf-8?B?TmdNSGpGbFBjbE42ZEp3K0U2Z0FEUXRhUGI3em5yd0hNU1haYmhlbmdnMlYr?=
 =?utf-8?B?aUgxV3RldTZoanVURmgzR3JBY0grTFdneEdrNGxiT2RLTFp2UGpWMnBYOWRU?=
 =?utf-8?B?WWRBbk5UdjEzUVMzcHFqQkdIM2xrV2NzamNlUUhMc3R2WitsdDBuY3R1ellJ?=
 =?utf-8?B?elFscFhBNEpYNHNXWUY1cWg3VXQrNXBqNjVTZXZGM3BpbDQzdDBOVFBhZEJO?=
 =?utf-8?B?aFFDZklVcEVOa3RwenVmbUpzSS9wcUcvR3E0M1U2S3E4Mktqb3QwL0tRTmZh?=
 =?utf-8?B?UW5Ra2JhUlhLeEk5RCtDd3pyNzFySXFheVlkcTdyT3I1TmV2TUI4aVgrR0My?=
 =?utf-8?B?QTUrRWswUSsrQ1pIWDBHN2djMzgrMjR5YlBXc0NDZWJjWmlWRUZSSUJlRXJL?=
 =?utf-8?B?MW0yMHFxbkJzZXFjeHlsSFRxSEVpYVpOdGNGaGZySFRyOEMwa0YvYVcyS1Qw?=
 =?utf-8?B?VFZaMVRSaytVd2Y3aDRJbWhTcklkZDFVSWdYRisvN3ZtcU1od0k2L2U3SnhU?=
 =?utf-8?B?U05UMjVVVmJUbFNIc0lQUWxkdUg5RUplU25ZT1owa2M3OS9xWkJxWnJLdEwv?=
 =?utf-8?B?VkhDYmIvTzFjUUN6TnJUc2FWTHF1d2tGTFJJUlVHQklMc254UWhhYlZWZktW?=
 =?utf-8?B?aXFPb1BNdkJTNjgxZUJqU2MrT2VEa1prR0dFTlZBT3dKTlZWUmZYRkhBeU5Z?=
 =?utf-8?B?dGZnWFJXYW53WU9FTWZ3ZEZXOFNRV1ZUL21pRDNhS0V4cUFQUitxWjk0TVFD?=
 =?utf-8?B?c3V5SFhnZmFNMmt2bWpBaTBkMTJpNTczK2tvR3FzM01weUdveGJUUGRQN1RS?=
 =?utf-8?B?djN0Z1hXc1ptRFZDUCthY3BLY0NTV3A4T0FZZVo2NGlZOUk2WmljRkhFREpo?=
 =?utf-8?B?bjljdXVUOXEwQnE1RmJXeVlhbnc3QXFPUFdTelJQQnJNQ0NmN3ZkbFBLdE1K?=
 =?utf-8?B?TXM2V3pQLy9ZRXR3Uk94aTR5bnJ0RHc1dWFGd2RsYU93aFVkRzF5SGpmOE8w?=
 =?utf-8?B?bmtEZ20ya21sZ2I3VlBDeWR0a3Y1aWZOVklGaDM4akVUd3liYTgvb0QyL0ZB?=
 =?utf-8?B?S1dZWWdGelhadXNVa1FWWnM3OFIwZWcySGxSY09ramFSOHR5TzNJRXJ3amlF?=
 =?utf-8?B?a1BCWU9yTUVoTURqRHdHT3N6TjhIeUNQaS9TMVV0a3duTWZ5aEpyVnZ1bzB2?=
 =?utf-8?B?dzI3aUdhc0JSYzZwMXFiM2QxdEh6U205K0xhMVNPRXJiTEgzZDFEYVoxQ3lv?=
 =?utf-8?B?OE1RTGFlVFVJOTR6VUNtU21pZEZLckh2M25iUXVyT2xYWHQ3MERBTzdSaDdv?=
 =?utf-8?B?TDZoRWp3RFloK25Ra1JEc1luaitCSzVJby9aVzhSOGgwcDlQdzBrUkdXazN4?=
 =?utf-8?B?SGVJWHFLZVNFb1ZWcklDL081aEVSY3hhVlovR2ZDV25qVW5GTUlOVlo5K21J?=
 =?utf-8?B?NXRybGd1VWVYaTVGcHQ5eUhseW1qVzlRakpldUVlUWxzOGw1cU1nTmNmZTF6?=
 =?utf-8?B?ejVUcGkwSVFDZzJkKzM1empDbWZVdzdSWDNSUGZCQ25XS1lqeW1nTUVjQ1ln?=
 =?utf-8?B?SWhvNUJlMU9qVndYRnJ1YVpZSERuVU9hd3d1TG1UZVh5c2R4Y1BvenhWZ3JL?=
 =?utf-8?B?eDBjT0NBVEZOR0Z0cHhoaHI0ZWU2VHdNNm1TSUVlUTRnSmJQZmVqZWtXVnZH?=
 =?utf-8?B?YlhHOHU1RkRCZDV2N1FGdWIxekF6cHNTY1poOVhGM2hZU0JwUTEvZ3ZjWVpM?=
 =?utf-8?B?aTgzTHNMT3pjZlJZVzVxZGc4dnhZaExTTmwydm13djVWa3oyUlk2MHZxNVdH?=
 =?utf-8?B?MzJHWjZTZlo4UzU1cHMvZHJFZTVkQlB2RHZqK1RpWW1oR3I1L2U3eW1ISGMz?=
 =?utf-8?B?R3JYRnpaMGVhclR3U1QzemNZcXNkQkdwU3BMaUpYZ0w5K2drWXpHQWxtbmZ1?=
 =?utf-8?B?Z3ZmL1dOb0V0ODZySzVwN3FYWm4rbE9RZldvZEpMUnI1TTFsWFEyTWwxVkxF?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 598b07e6-7d51-4e9e-1b10-08db798aff95
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 16:56:50.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPA/hUqQFt+UHCNnKzBt0RK+D49ElEgpW07HXysQHFdR4CKIk75NTtMuK4QbJXPr92XfR+7vr9zToqfm1HFRzcFZir8BEzHYW2rXpyQmPHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8316
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2023 10:54 PM, Dan Williams wrote:
> Michal Wilczynski wrote:
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
>>  drivers/acpi/nfit/core.c | 24 ++++++++++++++++++------
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>> index 95930e9d776c..a281bdfee8a0 100644
>> --- a/drivers/acpi/nfit/core.c
>> +++ b/drivers/acpi/nfit/core.c
>> @@ -3312,11 +3312,13 @@ void acpi_nfit_shutdown(void *data)
>>  }
>>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
>>  
>> -static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
>> +static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>>  {
>> -	device_lock(&adev->dev);
>> -	__acpi_nfit_notify(&adev->dev, adev->handle, event);
>> -	device_unlock(&adev->dev);
>> +	struct acpi_device *device = data;
>> +
>> +	device_lock(&device->dev);
>> +	__acpi_nfit_notify(&device->dev, handle, event);
>> +	device_unlock(&device->dev);
>>  }
>>  
>>  static int acpi_nfit_add(struct acpi_device *adev)
>> @@ -3375,12 +3377,23 @@ static int acpi_nfit_add(struct acpi_device *adev)
>>  
>>  	if (rc)
>>  		return rc;
>> -	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
>> +
>> +	rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return acpi_dev_install_notify_handler(adev,
>> +					       ACPI_DEVICE_NOTIFY,
>> +					       acpi_nfit_notify);
>>  }
>>  
>>  static void acpi_nfit_remove(struct acpi_device *adev)
>>  {
>>  	/* see acpi_nfit_unregister */
>> +
>> +	acpi_dev_remove_notify_handler(adev,
>> +				       ACPI_DEVICE_NOTIFY,
>> +				       acpi_nfit_notify);
> Please use devm to trigger this release rather than making
> acpi_nfit_remove() contain any logic.

I think adding separate devm action to remove event handler is not
necessary. I'll put the removal in the beggining of acpi_nfit_shutdown() if you
don't object.

>
> An additional cleanup opportunity with the ->add() path fully devm
> instrumented would be to just delete acpi_nfit_remove() since it is
> optional and serves no purpose.

Will do,

Thanks !


