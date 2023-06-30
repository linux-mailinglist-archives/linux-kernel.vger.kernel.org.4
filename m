Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8528743877
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjF3JkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjF3Jjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:39:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83357102;
        Fri, 30 Jun 2023 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688117990; x=1719653990;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ayC4wYLC/FDpDF0ffNeJA7QdmejwYATu05r0cSJ9AoQ=;
  b=KwFIp1Wx8CTuz9TXeWbEEFcZ6zRDrdjAw3NZ+hX+51R/UCoYjHjq4tDS
   HJtsuPpdne8zp3uHAErnLM6RlE7ldPCGF6T+UEZxPw04XHIcTRXe5+2Dc
   705PSHv4wRWK7OwC6Xide1gd7orqVg08uf5ChfAm1GIatfOy1tnnKE6Lw
   rFBjtWhIAF6qsBWXsngczk4XfCn4FzFRRtJyXlmfViafdPrlZLqmVzuLv
   KKSrqYaWFpMp5uZCo+kVISD7XisU5e6uGlcUcklf2+RWmkXQpFdRa6Sq+
   Ylf0NPcPzddScJ7znrSOi8n5ZTgYMhkKzgUh9NRmgUsqb41KN7pjgNfjV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="428399704"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="428399704"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 02:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841802072"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="841802072"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2023 02:39:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:39:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 02:39:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 02:39:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkTjU1VsGrbLpSUmAPawagxHpvRFH3MJ5h1PbSUwgrtFvS8a5Mthpay7HlczIdwEYf3eWSPGMCrtWYXkuCLiUTbIkZMdCZJUwTelVXBkYzp8Gf9/tgSrhMLooNxjbhmpg2IubT3g3b97gOHGHojRUoYuRHr91Yyu3aiKx1rvxL8J81qYFDE1nwPa0tzhg40ttajMQP8IOUxL5Txle3FvHpHid3jmNiaMJLC1gYecww7GglyAEs66bR/CWDYGUMTa+xoF4OsA6dN0reNsUi0zc9jVWL1kVoVRl9AmMh7BxASRLDII9O8/Z0iakA8Bp3Ti2I9MnyBg6WF8ByYIh+Ishg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOKYWhgRC3bN6KmT/HW4Qv+7iDjJMsv5gClO0KHbKEM=;
 b=fbvYL46F+jPejdQ/PAQvjys1eVzXSxZ+gdIYXBw77WyUt/Fl4kkB6laANkqCu7ePsD4huyd+IduhCDcl5Z/ZoHDfxUft5LorV6WAKCwSNRWhwwY9Fi1Vdr513r2V5BjOGGBuE/qGHkE2q1Kjj9TzZVyM4EbJGKu1NtRJvf9cxUU10B/VOvHGrTUOcmuGC+QavUDdNF235ZBNfGOuj1hLx5o7oibN+dzNOitXmwRTKMfBA5D+T5P2TO2dhCmLdGkgtR9VafLHhwhol/aPMp7dGvG/zDzNTaAft4E8Z2Gjo+uACSiub6hX3zUvDDgLSWANMPSIMX27ettG4hhE6lUWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by CY5PR11MB6414.namprd11.prod.outlook.com (2603:10b6:930:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 09:39:30 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:39:29 +0000
Message-ID: <ff596664-1062-92ff-a1fe-3b644925aeae@intel.com>
Date:   Fri, 30 Jun 2023 11:39:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 03/10] acpi/ac: Move handler installing logic to driver
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-4-michal.wilczynski@intel.com>
 <CAJZ5v0ippMo1Haa-YFszyWZNgUE_pPUtkFngQWjUyjJe4tm94g@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0ippMo1Haa-YFszyWZNgUE_pPUtkFngQWjUyjJe4tm94g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0494.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::13) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|CY5PR11MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8322e0-e1fb-468b-2051-08db794de6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/w1uPNM8tWELfQLv9dtiEKExqXIyBmbOQRMwxgC4jtrebhg9749/7YfrUH9reQo7iLlRRuQxC5xRAsElrU3n40DMgCbpzpklu5ceZ815JvWVU4HE2/9XQZrhEWmHNVmdX+qZkaoFOurD7tpUk10VUYtMJ4BBWtf78yf+mSDZnclU8aGzYlDpD0mK5XuPixuAhLiYEeUk5fC4O47iV87HN3sAK4iIk8qSK95QSHGKmdNIim1X4K8C8UF5ngO/RQrd/Q+2XMdNs+eSSAOiPg67ody3Nfxkzarlb3dK1EwwsyekizSb839bjWOwoHnofDkbwIx2VgTC1Ci5ueCXZXRWOiNX0fQNY6Q4YirjVwiunnODRXyDhLD4Y9il+WGiqyZhCW0WjxUzTINhBdGSPRPHrLsBhU9pvt8N2aObLVbKmeQQBIi9mrl9Jc4Gy/e3U9Pk5Tv12TiJQpD4mBxpT7hs9a+/9HRkuS//V981HkODlLz1fm7LlJ0pbq23b6BldJPki6JZIp+okeZLjU9QIx0dTnQmDtgNp1CdqSzcw6HUZv+0IqH8kskulcxt8HUpRNTsdrMGzMEAAyX3tAHo2tLKfPYfK8piXtE37VsvnwZ/41OlRIrpszsjfq14rwaxv/PXTJb/LoTcrt7ZtA6wmCyzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(6512007)(6666004)(2906002)(186003)(6486002)(86362001)(107886003)(38100700002)(83380400001)(2616005)(82960400001)(53546011)(6506007)(41300700001)(31696002)(26005)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(31686004)(66476007)(6916009)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkZabWpPWGpqTkJIWWhsWk8xMmY0c0o5TUF3TnY1NnR4SjRxa3ZocUFnNnFr?=
 =?utf-8?B?UDUvR3dFeGVIWitFOFRvTThFeUxMSSs4MTBEUkRqS083bWh5Vzl4RTVQWGg4?=
 =?utf-8?B?U3dKdzdyZlN5RktKZFBURjJ3YUUzQXg1bVQwWURaeEo2Rmx4K1V0Z0pMSHR2?=
 =?utf-8?B?YW1FSzFYdXdHWEE0ejgxRWpNNTJWbXU2eFB1dlN0bWVGYzRrbWNzZTRFNlZE?=
 =?utf-8?B?b1ZTSnNncHpiQ0FjUWlhTi83WGhiaXVWcDg1QjRBZXFMclR5b1hJVXhndmYx?=
 =?utf-8?B?cFRmUGRGNVhrRDlFMmovWjB4d3RKSHprRmwzRWpDaUxHRGlMRSs3RXI5SHFG?=
 =?utf-8?B?a3owZDNDUDR6dW1Ka2VKWTVCQUNSa0ZLWldJOGthQ1pFT0wzUTF2ZWViSDJi?=
 =?utf-8?B?ZDMxczVzeVJPSitiRW5sUlRRS3ZuZnhheldMSmRoNXVReU0rcERtaTdmZjg2?=
 =?utf-8?B?b2lpVG85c21XY2syOUJlaWg5WXF5MWNmaXh3WEEwRVpVU1BwR0g4NFk5Yi9u?=
 =?utf-8?B?dGFGOFFmTGdGSGhwMktXS0lJbHlvdWRQVTRCb0JzR1dlWXFsNmJZR0syTEx6?=
 =?utf-8?B?Q2hHeHo4MEhzRGlseEVmdDVKQlFoOEt2KysrQmg0M0pjeGsrWkxndGducWJ4?=
 =?utf-8?B?VktiNWVuUU93cVR1VkxvQ1hhTWV5KzB0SElxcXpyQTNUeTE1SmZ0NXlyQVJ0?=
 =?utf-8?B?TURkeUhhWHFyd2trV092eXR0VmJ5Zmx4SExlOHQxaHFnSTc3VytET2tHNXRH?=
 =?utf-8?B?azBaVTdRZnZyaXdlQkkyd3VQc05LMW5Ldi9SRHVIZ3JMVllNd0lDNko2Szlt?=
 =?utf-8?B?TmxmZHI3bjRvYjhyRXBiNXgxWEdVdkhEUGtmT3VlQ3VGYzMrdnNHS3ZuV0tr?=
 =?utf-8?B?S3BkNkx0ekViTUZ5Zk4yWEx0Z0picXFkeS91VHR5WlBwVmlxci9oWG0rd1pn?=
 =?utf-8?B?Sys4Nm54QjNLMG9qWWhqd1lJWTVIYlFwOGVqbUZYZGdORk9YQzJDNkd5SEFo?=
 =?utf-8?B?K0g3VXZqUW00SXBJb0VNRThEZm1oZ2tDRzhIRUFTaFJIN2RYVTNSNW03aTBq?=
 =?utf-8?B?V3dQUlk4L3BDMkkrZGlBenRyQ3hmMlhwYUR4b2EvTkNuVWtlTEF4NTgzY1NP?=
 =?utf-8?B?SXBtVFo2RUxadUI5c0NwS1U0YUEzYUQ1QXdnN3ZVdStNMmRCMU5tdVA2bUE2?=
 =?utf-8?B?RkMxa2hGaHNCVlpaQ1pDMThPa3dEb3RiN0U5cU5OcHY4cHh4eXhsREZsMWxu?=
 =?utf-8?B?Y2cwSWpSektpanJiRTBRYSs0R2NyS2NmRzh6TDB2Y3ZibllmTmFELzFpU2Ro?=
 =?utf-8?B?YzAxKzI4WWdMQk9PNmZydmN1UFFnM21aWHp5V20rSnRwRnZ2L1hZU2NJK1Mz?=
 =?utf-8?B?cEs0ZEswYytQL2FUeWhOWFNwTVpwdXkvb0swd1NEV01tek1YV1BRdXNpYXo2?=
 =?utf-8?B?V0N1UXpTa0tURnEvelpHemVGckJtY2l1Y0p6RWlEOHhRWHlwdGhacmwvZGRW?=
 =?utf-8?B?ZnlaeHVCNXhCMzRRVzlGc2dMV01taVh3UE1iMDFJaUJ2VHIvaTBJVWFiZnBP?=
 =?utf-8?B?bXpKc2NYSEhoenRjc3ZjWXRmMlIwQmtYTlhBa2UrQVZ2bEgwRkZnbDdSa2hV?=
 =?utf-8?B?U1ZtZk81Q0NLNDM5b2dabi8vTlVoMTRoa05SL0xWY0UzVjhTaHEvbnFtVXlB?=
 =?utf-8?B?TUV4SGVqZGxLYjJIUVdFZW1MMlF4TS9kQWVYckFnRWdjRzZ6bjJIcXc4RCtP?=
 =?utf-8?B?b1hNY0x1bFhwUGwrcVpTRjJySnRqV3Mzd0JmYzJ5dzk3ODkrU0dicFp1VmZ1?=
 =?utf-8?B?ZjFldU54MDYwZDZ6TjBSbUk1WlcwRmRnZklkYWtOMkhmcHY1UmsyZmZld2tJ?=
 =?utf-8?B?dzM1Y1BXT1VSY3dJZ2VlM0lXZUM4OFdqaGVQaXdZTHpkSHJGWFdENzlkNWYw?=
 =?utf-8?B?bXdaSU80RExtbTFReEl2cytIUjJWMEN3b2Nzc2xacWIxbjNyeHhaS2w4TTlS?=
 =?utf-8?B?Um5xN3FqR1hhNDdhcC9sWFVmd3cwOHdKcE9JWXVnMDRuVlF3MnNJWVJ0cTBO?=
 =?utf-8?B?YzJ6T3BMd0k3MXhjYmpETFFrVU1MaFppcW0wZm5zM3c3NUtZbnowTmtPSzdM?=
 =?utf-8?B?clRzeHNoVGNNblZLTHdIRCtpTjRHWEdqK1k3bmtvaGdVUTlHcXhkUlpzME9X?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8322e0-e1fb-468b-2051-08db794de6c5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:39:29.6729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mueMwFERzOFx8EEVAQadELm8EsPjCGtulUrVs68ZwV3S3EpvjubCf/xI6wXCFviS1MmVCw86bUUIO3BWJLhjOSYSLGcuvfxYFai+O2Wvdmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6414
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



On 6/29/2023 5:55 PM, Rafael J. Wysocki wrote:
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
>>  drivers/acpi/ac.c | 33 ++++++++++++++++++++++++---------
>>  1 file changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
>> index 1ace70b831cd..207ee3c85bad 100644
>> --- a/drivers/acpi/ac.c
>> +++ b/drivers/acpi/ac.c
>> @@ -34,7 +34,7 @@ MODULE_LICENSE("GPL");
>>
>>  static int acpi_ac_add(struct acpi_device *device);
>>  static void acpi_ac_remove(struct acpi_device *device);
>> -static void acpi_ac_notify(struct acpi_device *device, u32 event);
>> +static void acpi_ac_notify(acpi_handle handle, u32 event, void *data);
>>
>>  static const struct acpi_device_id ac_device_ids[] = {
>>         {"ACPI0003", 0},
>> @@ -54,11 +54,9 @@ static struct acpi_driver acpi_ac_driver = {
>>         .name = "ac",
>>         .class = ACPI_AC_CLASS,
>>         .ids = ac_device_ids,
>> -       .flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
>>         .ops = {
>>                 .add = acpi_ac_add,
>>                 .remove = acpi_ac_remove,
>> -               .notify = acpi_ac_notify,
>>                 },
>>         .drv.pm = &acpi_ac_pm,
>>  };
>> @@ -128,9 +126,12 @@ static enum power_supply_property ac_props[] = {
>>  };
>>
>>  /* Driver Model */
>> -static void acpi_ac_notify(struct acpi_device *device, u32 event)
>> +static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
>>  {
>> -       struct acpi_ac *ac = acpi_driver_data(device);
> This line doesn't need to be changed.  Just add the device variable
> definition above it.
>
> And the same pattern is present in the other patches in the series.

I like the Reverse Christmas Tree, but sure will change that

>
>> +       struct acpi_device *device = data;
>> +       struct acpi_ac *ac;
>> +
>> +       ac = acpi_driver_data(device);
>>
>>         if (!ac)
>>                 return;

