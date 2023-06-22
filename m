Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB0A73ACBC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjFVWyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFVWyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:54:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78610C;
        Thu, 22 Jun 2023 15:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687474471; x=1719010471;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+70CCApOFm17oK99RKXFdVLnYvoywHxGvK5buKggR7w=;
  b=fR7DcF7jv8ZOeQccE1bT/6r9AG18cy6iU42y5UeaskrMHlFsq1Ixt6lc
   S3j/KjxRmOOU6tSn4cF/z3l6Aojj0uADnzT2KQ/tOo/r8xsmpsiUdwEJo
   7dpz33M1XFjuut9SBrePKWBnLv0BWM318nUGG1dt+sr8z1VNyoxb6uEtA
   Z0gS9cz1P6+WWOdcoS/4Ki8Lyv/qOV/ATsNQMvhA+lGxmVYNGLBFaPmIx
   2U9MLyB9Yk+heVvj42lLboPOKEVOnFCspKyXz4tJ3/62EptAG9PZN2v1+
   KzCW8TNjcC6x7qEIIls+Jtz6M12oskWrgVd1FUBTJ10SL75vVHl0X5JsC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="447009466"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="447009466"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 15:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="1045420216"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="1045420216"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2023 15:54:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 15:54:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 15:54:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 15:54:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUW37yF/qUJXo7ctAr+hBKUVKlMZR36J5nc9myfus4Xzh10NGLJ7lxBYYXtUf4vv1imVLNKdT+K2Em9fW4hYxZ6HbPy7u3VlQ5Qw7Ppbj0bTJXsMhCEyxL2PGBuJEFwlBhWNV+nqQY1oiAwTyK63pOnoPKNsARYvYoIGfQlyXYzmHfmqXcyoy59vgxqgyi8Nen+t/VUaRH5xSPWSTd4LFQPUHmkElO4om7iwk2sJNwQhZaEhxON74HUbHq8qmVd3T1ID6vy2gMgbFgPj1G+cQ3IupprH4YpfztcyM2ojGQgDTYLvgeytHG1TpZk/Lp34HBOzkoX5X5jiuVlcXHC44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azjM/TEHBf6utlGU/CkXZpk9a77aLHTa7hG3UPs2vls=;
 b=m+JMPGsIgMr1qr+KjsSrFRF7wCmL17QDi96EBNm8PhLEUOAGeBDlbrY68jXcw0VNYMnEAbfdVWYfN7BhI8ICb2xg5jMRV/BBCzC2OgPr5vwHJ33T26nppmZw9ZCE+QcMAEDMxVIveDHEgv2VMWs2hFLztzWYKvv75tgEB8bbZAzgwC3bWrT4bUoK4u3klwpazdrozipjpRvvHWKglABQVRtuhGJkT7oHeAHZJUPUSSTyKK7Ub9WZkUV6/QX8kOJka7hWo4yPHmJvOTPygpTjl3q1nhYUwuynkoRjnzbULuvgtfviPAb4ys7STTpymHgIkeMMs6adz8noHa25M1FvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 22:54:22 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 22:54:22 +0000
Message-ID: <696c7b09-752d-ba82-f857-2747eb98cef2@intel.com>
Date:   Thu, 22 Jun 2023 15:54:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 06/27] cxl: Rename 'uport' to 'uport_dev'
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-7-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-7-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d2da99-e2b7-4e76-e4db-08db73739e64
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adQ8YAS2QiEMnDaHU+eJ+dM1SLcK40TZKUhrYFHwIC4yFtaVTISBfM/g44VaRr1UW5VKd9UzQ2HmchT2Xd0TXTz724hEHnR/aypbDvRWqaWOnKyG0ISdqwJrw5MPoSDog0WTSDYL2d+pyocu+6qSqd7VrPq9V7XSxbxhLr/HevkQSwQdxpR9c9n/yVm3uaIsgQ6kuECuQamwIkElUrudzvfvIrbhnBrlhVOpJzRRC7wKwKxN4nga95oDmD5Ycw4bNbh7eQxgZxHGVEW6l9Cyix2B50uUy5nzrMBYr94lM3X02Spmkv0PylmZAywpbwWFvp6InEH7IOKergM1UsBvuSdRm+kDcNn5MD0o0XXQB35/GKeIPfqA9jcWlnaQU5NkOc2+oF5bSXPElRxc2WAf3bdcKQF/0+PIRMZtHD5yhD1tbRfGveTyd+KXDBQBjPsNKewOtESSDQIRW6Arjy/pAnPtq3VTUvI8J8/ErrTEvoH7eodRtiE4T2gYMbIzeVbbDX8iIHHH4aJTfcthTDTkqCx3bV17nK10ZHZm6vLLDgmUyl37IVFhnOmcYGR1g836z6mgwnIYDuMBh4dwIHmFEeg8c4QtYL4Ed7TVS6Xrb2/G+043jNGYFT2xX1rm2ytb0x/4D45YooLimLNVlx1d8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(86362001)(31696002)(41300700001)(8676002)(8936002)(66946007)(66476007)(66556008)(2616005)(316002)(44832011)(83380400001)(30864003)(5660300002)(6486002)(6506007)(53546011)(478600001)(6666004)(6512007)(4326008)(186003)(26005)(82960400001)(38100700002)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdRbC8yc2ZZRWRjU0paRFlIMStKV1NuWjJreHhUdEJ4dnBXelFZNUxESEdt?=
 =?utf-8?B?S3dCVnJhZlMvTUVmekt1VjRRTjFFSms5RkxyOTk4VHMyWWRZTXBFRWhoeGxp?=
 =?utf-8?B?UVRXemNMNTcySXVZSFUzOEV0cklKaHdKd1o5UGhHcTlURTJKUUtGMXBsb3RP?=
 =?utf-8?B?b1JsNXFNcnl3NGJuMFlYNFI0bWtkWGNPMWF1aDZwQjRQTm1SM0dsSWMrSlQ4?=
 =?utf-8?B?MzYvc0RaREJiVWhzRVZyZWdlcmwxbTZ6VmVXWXFkOWpHM3JRREltcm91M1lx?=
 =?utf-8?B?MGZ0YnpLRmhYWXZva3ZtS0lrcXdlZG93UVo2UjlwK28zb21VbVZSYXVHTHhk?=
 =?utf-8?B?TTAwZVRDekdOVzBFNkhqUTdENldjMmVnd2Qwd1BzdTRiaEt0WGJHakFpaHZ5?=
 =?utf-8?B?d2diMUxaZndValhMeTJlZE9nR0poUm1XeW9mRGhrNEZMQS9vcG52SnFHVFpT?=
 =?utf-8?B?bFBSTHN3alQxSkk0Q0ZJbXdRR2hUUURZSThMaGNPOU1IeC94T0IyL0Y2NWpj?=
 =?utf-8?B?U05GSVlkZzJlSU9wVmdzUU4wWlpvSTcyUnhlSHJGQUNQNEl3TDJqNkpIbHNT?=
 =?utf-8?B?c3NlWE5NL3RmajgxMzdTcHpIT1M0S2dzWG9nL0k0em5RZnFZZ2dpMkFrcFVq?=
 =?utf-8?B?YzQya0htOCtGS0J4MEs3bTVPcFhTTVY3b2Jza3ZNc1dJZjEvc1VYYkc1K3Zt?=
 =?utf-8?B?dkt4eU1SZ21oZTlJcFlEdGVpQk5ZR28yOG0xTWxTZUNrbzI1WUtqTU1DenR3?=
 =?utf-8?B?YlN2MG50TzZkQnArT1dYaEhKRnZxWk5vdy94ODh3d2xRN0JrRXZQY0YveS9P?=
 =?utf-8?B?V05SRWVQM24rdUdwdTI0aFl1WDJnSVRMZmJVUjFpWmVjTXdJcmEzVDJHbWxH?=
 =?utf-8?B?dGNHNHdvb2s4VVdncWdOZmtzOFNJa2pLMFUrTFQ1aHNtc2JLV2N4bjFxUEpB?=
 =?utf-8?B?bjN2Mk9iRlRyTHVoYXl4RzllMDNDZWRieGUzaXppSWxYbTQ2cW9MeCtKT0lV?=
 =?utf-8?B?ajAycHJONUhpYStjSTlBR3AvYmp0ZkVwZVVpUCt5Z054TEp1ZDM2SXZPL2dX?=
 =?utf-8?B?emFrdjc5Z2U1MVpFeHBDTUNxSnAvM09xSmhldDMxTkdvMGZ1SVkrb0dOdEsw?=
 =?utf-8?B?c2JvN2MwQ1gvTmVNaXlTVkNBamVqUG5WVURSSVVVekZnUW9GUWxBQUlPT01D?=
 =?utf-8?B?YXNIZmdwTmsxZ2NFUVl4REZYTHRHOWUvNDhVNzJicVhxZURmWTd5cEVKZitV?=
 =?utf-8?B?TTZLaGNPUjlkMm9seGNxZGw2eDVaNkNkT1pYRjdRMTRYTVJhWk4xck12cWND?=
 =?utf-8?B?Q0dxM1kxSCt0Zjd2ODgwcm81eXFzYmc2K2RGTjVkTXRWN3IxaGZpRk96QWQ5?=
 =?utf-8?B?S0djNzJxUzZUQnhwM2RpMFExeHdnTk1TRDN0NDRNTjAzZWxSeUNCSXJEbDU3?=
 =?utf-8?B?Tkt5ZmVsOTFoK0h2a1Y4T0Q3WElwdFIvOXl6ZmhzOXR5QUlMQWFjeDM2TTR4?=
 =?utf-8?B?dXlYVXJmemplOG41VkJyaFExeXlVdUVrWXhBamI1R21YeCtqYlhzWEFFN0da?=
 =?utf-8?B?TWVxS0xtSjlIMzJoaTh0QjFmVEJqYXZCUDl6dHRBZSswbzhxMXc4a3Z0UnQ1?=
 =?utf-8?B?b1dXbk1KTmlXMkl5ekRmYzl4cnoxQktKY2FlbUVjMytaNEdXQ3hQMmh5b3c5?=
 =?utf-8?B?YXR6ZjhJQ1RuMDdQMFdia0ZjajF0aldzM2VVS0NsaloyUktvbUs4bm8vV3pG?=
 =?utf-8?B?YTBkRVRqN1hVSjNZYlBaek5VWm55YTNBUElsazlhaVVmZUlVV3JNSG8vRnN5?=
 =?utf-8?B?QzhxaHRXc2dTSXQ1OVVxRWFlSkRFNE9ub29rTldxZzJBOGwwRWVzcmI1WU5M?=
 =?utf-8?B?dENCUDEwZGV1QmFsZTBGYnI3bkVBeldxeTdLUkhUcUk4eDZxWlF4WXh1ZTFs?=
 =?utf-8?B?Wjh6S3ZXRlQrclU2WjkvU3A4YnlwNkZJYXBUYW1TYldWUmdwR1FyeWVLdTdt?=
 =?utf-8?B?M0ZiT2ZreHBHUnVJVWFvRVRaL1VmdW5lZmYrcHp4SzRvdXNJRGZmc21pb2gy?=
 =?utf-8?B?S3hZVG1OYWthSW9lQlVMb1BFS3RTaUtzb0JxVGEySnRDMTVzV2lxSUI4T2x4?=
 =?utf-8?Q?Z5gblxeES+GCgy2CeGalqVWMX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d2da99-e2b7-4e76-e4db-08db73739e64
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 22:54:22.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9+kSmqIJb/RuNr2bXga5niNLOc5Mf5qorM4ELQHf9rnnskoxe7NGazf+4pgX/r66E2si/mI1TWb3wQsaWiPNA==
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
> From: Dan Williams <dan.j.williams@intel.com>
> 
> For symmetry with the recent rename of ->dport_dev for a 'struct
> cxl_dport', add the "_dev" suffix to the ->uport property of a 'struct
> cxl_port'. These devices represent the downstream-port-device and
> upstream-port-device respectively in the CXL/PCIe topology.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/pci.c        |  4 +--
>   drivers/cxl/core/port.c       | 61 +++++++++++++++++++----------------
>   drivers/cxl/core/region.c     | 48 ++++++++++++++-------------
>   drivers/cxl/cxl.h             | 13 ++++----
>   drivers/cxl/cxlmem.h          |  4 +--
>   drivers/cxl/mem.c             |  2 +-
>   drivers/cxl/port.c            |  2 +-
>   tools/testing/cxl/test/cxl.c  | 20 ++++++------
>   tools/testing/cxl/test/mock.c | 10 +++---
>   9 files changed, 86 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 67f4ab6daa34..375f01c6cad6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -67,7 +67,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>   
>   /**
>    * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
> - * @port: cxl_port whose ->uport is the upstream of dports to be enumerated
> + * @port: cxl_port whose ->uport_dev is the upstream of dports to be enumerated
>    *
>    * Returns a positive number of dports enumerated or a negative error
>    * code.
> @@ -622,7 +622,7 @@ static int cxl_cdat_read_table(struct device *dev,
>    */
>   void read_cdat_data(struct cxl_port *port)
>   {
> -	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>   	struct device *host = cxlmd->dev.parent;
>   	struct device *dev = &port->dev;
>   	struct pci_doe_mb *cdat_doe;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 7d3079f5b7b5..cdfe0ea7a2e9 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -561,9 +561,9 @@ static void unregister_port(void *_port)
>   	 * unregistered while holding their parent port lock.
>   	 */
>   	if (!parent)
> -		lock_dev = port->uport;
> +		lock_dev = port->uport_dev;
>   	else if (is_cxl_root(parent))
> -		lock_dev = parent->uport;
> +		lock_dev = parent->uport_dev;
>   	else
>   		lock_dev = &parent->dev;
>   
> @@ -583,7 +583,8 @@ static int devm_cxl_link_uport(struct device *host, struct cxl_port *port)
>   {
>   	int rc;
>   
> -	rc = sysfs_create_link(&port->dev.kobj, &port->uport->kobj, "uport");
> +	rc = sysfs_create_link(&port->dev.kobj, &port->uport_dev->kobj,
> +			       "uport");
>   	if (rc)
>   		return rc;
>   	return devm_add_action_or_reset(host, cxl_unlink_uport, port);
> @@ -614,7 +615,7 @@ static int devm_cxl_link_parent_dport(struct device *host,
>   
>   static struct lock_class_key cxl_port_key;
>   
> -static struct cxl_port *cxl_port_alloc(struct device *uport,
> +static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>   				       resource_size_t component_reg_phys,
>   				       struct cxl_dport *parent_dport)
>   {
> @@ -630,7 +631,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>   	if (rc < 0)
>   		goto err;
>   	port->id = rc;
> -	port->uport = uport;
> +	port->uport_dev = uport_dev;
>   
>   	/*
>   	 * The top-level cxl_port "cxl_root" does not have a cxl_port as
> @@ -660,10 +661,11 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>   		else if (parent_dport->rch)
>   			port->host_bridge = parent_dport->dport_dev;
>   		else
> -			port->host_bridge = iter->uport;
> -		dev_dbg(uport, "host-bridge: %s\n", dev_name(port->host_bridge));
> +			port->host_bridge = iter->uport_dev;
> +		dev_dbg(uport_dev, "host-bridge: %s\n",
> +			dev_name(port->host_bridge));
>   	} else
> -		dev->parent = uport;
> +		dev->parent = uport_dev;
>   
>   	port->component_reg_phys = component_reg_phys;
>   	ida_init(&port->decoder_ida);
> @@ -687,7 +689,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>   }
>   
>   static struct cxl_port *__devm_cxl_add_port(struct device *host,
> -					    struct device *uport,
> +					    struct device *uport_dev,
>   					    resource_size_t component_reg_phys,
>   					    struct cxl_dport *parent_dport)
>   {
> @@ -695,12 +697,12 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>   	struct device *dev;
>   	int rc;
>   
> -	port = cxl_port_alloc(uport, component_reg_phys, parent_dport);
> +	port = cxl_port_alloc(uport_dev, component_reg_phys, parent_dport);
>   	if (IS_ERR(port))
>   		return port;
>   
>   	dev = &port->dev;
> -	if (is_cxl_memdev(uport))
> +	if (is_cxl_memdev(uport_dev))
>   		rc = dev_set_name(dev, "endpoint%d", port->id);
>   	else if (parent_dport)
>   		rc = dev_set_name(dev, "port%d", port->id);
> @@ -735,28 +737,29 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>   /**
>    * devm_cxl_add_port - register a cxl_port in CXL memory decode hierarchy
>    * @host: host device for devm operations
> - * @uport: "physical" device implementing this upstream port
> + * @uport_dev: "physical" device implementing this upstream port
>    * @component_reg_phys: (optional) for configurable cxl_port instances
>    * @parent_dport: next hop up in the CXL memory decode hierarchy
>    */
> -struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> +struct cxl_port *devm_cxl_add_port(struct device *host,
> +				   struct device *uport_dev,
>   				   resource_size_t component_reg_phys,
>   				   struct cxl_dport *parent_dport)
>   {
>   	struct cxl_port *port, *parent_port;
>   
> -	port = __devm_cxl_add_port(host, uport, component_reg_phys,
> +	port = __devm_cxl_add_port(host, uport_dev, component_reg_phys,
>   				   parent_dport);
>   
>   	parent_port = parent_dport ? parent_dport->port : NULL;
>   	if (IS_ERR(port)) {
> -		dev_dbg(uport, "Failed to add%s%s%s: %ld\n",
> +		dev_dbg(uport_dev, "Failed to add%s%s%s: %ld\n",
>   			parent_port ? " port to " : "",
>   			parent_port ? dev_name(&parent_port->dev) : "",
>   			parent_port ? "" : " root port",
>   			PTR_ERR(port));
>   	} else {
> -		dev_dbg(uport, "%s added%s%s%s\n",
> +		dev_dbg(uport_dev, "%s added%s%s%s\n",
>   			dev_name(&port->dev),
>   			parent_port ? " to " : "",
>   			parent_port ? dev_name(&parent_port->dev) : "",
> @@ -773,33 +776,34 @@ struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port)
>   	if (is_cxl_root(port))
>   		return NULL;
>   
> -	if (dev_is_pci(port->uport)) {
> -		struct pci_dev *pdev = to_pci_dev(port->uport);
> +	if (dev_is_pci(port->uport_dev)) {
> +		struct pci_dev *pdev = to_pci_dev(port->uport_dev);
>   
>   		return pdev->subordinate;
>   	}
>   
> -	return xa_load(&cxl_root_buses, (unsigned long)port->uport);
> +	return xa_load(&cxl_root_buses, (unsigned long)port->uport_dev);
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_port_to_pci_bus, CXL);
>   
> -static void unregister_pci_bus(void *uport)
> +static void unregister_pci_bus(void *uport_dev)
>   {
> -	xa_erase(&cxl_root_buses, (unsigned long)uport);
> +	xa_erase(&cxl_root_buses, (unsigned long)uport_dev);
>   }
>   
> -int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
> +int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
>   			      struct pci_bus *bus)
>   {
>   	int rc;
>   
> -	if (dev_is_pci(uport))
> +	if (dev_is_pci(uport_dev))
>   		return -EINVAL;
>   
> -	rc = xa_insert(&cxl_root_buses, (unsigned long)uport, bus, GFP_KERNEL);
> +	rc = xa_insert(&cxl_root_buses, (unsigned long)uport_dev, bus,
> +		       GFP_KERNEL);
>   	if (rc)
>   		return rc;
> -	return devm_add_action_or_reset(host, unregister_pci_bus, uport);
> +	return devm_add_action_or_reset(host, unregister_pci_bus, uport_dev);
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_register_pci_bus, CXL);
>   
> @@ -920,7 +924,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   	int rc;
>   
>   	if (is_cxl_root(port))
> -		host = port->uport;
> +		host = port->uport_dev;
>   	else
>   		host = &port->dev;
>   
> @@ -1374,7 +1378,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>   		rc = PTR_ERR(port);
>   	else {
>   		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
> -			dev_name(&port->dev), dev_name(port->uport));
> +			dev_name(&port->dev), dev_name(port->uport_dev));
>   		rc = cxl_add_ep(dport, &cxlmd->dev);
>   		if (rc == -EBUSY) {
>   			/*
> @@ -1436,7 +1440,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>   		if (port) {
>   			dev_dbg(&cxlmd->dev,
>   				"found already registered port %s:%s\n",
> -				dev_name(&port->dev), dev_name(port->uport));
> +				dev_name(&port->dev),
> +				dev_name(port->uport_dev));
>   			rc = cxl_add_ep(dport, &cxlmd->dev);
>   
>   			/*
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 13cda989d944..39825e5301d0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -906,10 +906,10 @@ static int cxl_port_attach_region(struct cxl_port *port,
>   
>   	dev_dbg(&cxlr->dev,
>   		"%s:%s %s add: %s:%s @ %d next: %s nr_eps: %d nr_targets: %d\n",
> -		dev_name(port->uport), dev_name(&port->dev),
> +		dev_name(port->uport_dev), dev_name(&port->dev),
>   		dev_name(&cxld->dev), dev_name(&cxlmd->dev),
>   		dev_name(&cxled->cxld.dev), pos,
> -		ep ? ep->next ? dev_name(ep->next->uport) :
> +		ep ? ep->next ? dev_name(ep->next->uport_dev) :
>   				      dev_name(&cxlmd->dev) :
>   			   "none",
>   		cxl_rr->nr_eps, cxl_rr->nr_targets);
> @@ -984,7 +984,7 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>   	 */
>   	if (pos < distance) {
>   		dev_dbg(&cxlr->dev, "%s:%s: cannot host %s:%s at %d\n",
> -			dev_name(port->uport), dev_name(&port->dev),
> +			dev_name(port->uport_dev), dev_name(&port->dev),
>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
>   		return -ENXIO;
>   	}
> @@ -994,7 +994,7 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>   	if (ep->dport != ep_peer->dport) {
>   		dev_dbg(&cxlr->dev,
>   			"%s:%s: %s:%s pos %d mismatched peer %s:%s\n",
> -			dev_name(port->uport), dev_name(&port->dev),
> +			dev_name(port->uport_dev), dev_name(&port->dev),
>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos,
>   			dev_name(&cxlmd_peer->dev),
>   			dev_name(&cxled_peer->cxld.dev));
> @@ -1026,7 +1026,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   	 */
>   	if (!is_power_of_2(cxl_rr->nr_targets)) {
>   		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> -			dev_name(port->uport), dev_name(&port->dev),
> +			dev_name(port->uport_dev), dev_name(&port->dev),
>   			cxl_rr->nr_targets);
>   		return -EINVAL;
>   	}
> @@ -1076,7 +1076,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   	rc = granularity_to_eig(parent_ig, &peig);
>   	if (rc) {
>   		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
> -			dev_name(parent_port->uport),
> +			dev_name(parent_port->uport_dev),
>   			dev_name(&parent_port->dev), parent_ig);
>   		return rc;
>   	}
> @@ -1084,7 +1084,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   	rc = ways_to_eiw(parent_iw, &peiw);
>   	if (rc) {
>   		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
> -			dev_name(parent_port->uport),
> +			dev_name(parent_port->uport_dev),
>   			dev_name(&parent_port->dev), parent_iw);
>   		return rc;
>   	}
> @@ -1093,7 +1093,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   	rc = ways_to_eiw(iw, &eiw);
>   	if (rc) {
>   		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> -			dev_name(port->uport), dev_name(&port->dev), iw);
> +			dev_name(port->uport_dev), dev_name(&port->dev), iw);
>   		return rc;
>   	}
>   
> @@ -1113,7 +1113,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   	rc = eig_to_granularity(eig, &ig);
>   	if (rc) {
>   		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport), dev_name(&port->dev),
> +			dev_name(port->uport_dev), dev_name(&port->dev),
>   			256 << eig);
>   		return rc;
>   	}
> @@ -1126,11 +1126,11 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>   			dev_err(&cxlr->dev,
>   				"%s:%s %s expected iw: %d ig: %d %pr\n",
> -				dev_name(port->uport), dev_name(&port->dev),
> +				dev_name(port->uport_dev), dev_name(&port->dev),
>   				__func__, iw, ig, p->res);
>   			dev_err(&cxlr->dev,
>   				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
> -				dev_name(port->uport), dev_name(&port->dev),
> +				dev_name(port->uport_dev), dev_name(&port->dev),
>   				__func__, cxld->interleave_ways,
>   				cxld->interleave_granularity,
>   				(cxld->flags & CXL_DECODER_F_ENABLE) ?
> @@ -1147,20 +1147,20 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   			.end = p->res->end,
>   		};
>   	}
> -	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
> +	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
>   		dev_name(&port->dev), iw, ig);
>   add_target:
>   	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
>   		dev_dbg(&cxlr->dev,
>   			"%s:%s: targets full trying to add %s:%s at %d\n",
> -			dev_name(port->uport), dev_name(&port->dev),
> +			dev_name(port->uport_dev), dev_name(&port->dev),
>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
>   		return -ENXIO;
>   	}
>   	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>   		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
>   			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> -				dev_name(port->uport), dev_name(&port->dev),
> +				dev_name(port->uport_dev), dev_name(&port->dev),
>   				dev_name(&cxlsd->cxld.dev),
>   				dev_name(ep->dport->dport_dev),
>   				cxl_rr->nr_targets_set);
> @@ -1172,7 +1172,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   out_target_set:
>   	cxl_rr->nr_targets_set += inc;
>   	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
> -		dev_name(port->uport), dev_name(&port->dev),
> +		dev_name(port->uport_dev), dev_name(&port->dev),
>   		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
>   		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
>   
> @@ -1492,7 +1492,7 @@ static int cmp_decode_pos(const void *a, const void *b)
>   	if (!dev) {
>   		struct range *range = &cxled_a->cxld.hpa_range;
>   
> -		dev_err(port->uport,
> +		dev_err(port->uport_dev,
>   			"failed to find decoder that maps %#llx-%#llx\n",
>   			range->start, range->end);
>   		goto err;
> @@ -1507,14 +1507,15 @@ static int cmp_decode_pos(const void *a, const void *b)
>   	put_device(dev);
>   
>   	if (a_pos < 0 || b_pos < 0) {
> -		dev_err(port->uport,
> +		dev_err(port->uport_dev,
>   			"failed to find shared decoder for %s and %s\n",
>   			dev_name(cxlmd_a->dev.parent),
>   			dev_name(cxlmd_b->dev.parent));
>   		goto err;
>   	}
>   
> -	dev_dbg(port->uport, "%s comes %s %s\n", dev_name(cxlmd_a->dev.parent),
> +	dev_dbg(port->uport_dev, "%s comes %s %s\n",
> +		dev_name(cxlmd_a->dev.parent),
>   		a_pos - b_pos < 0 ? "before" : "after",
>   		dev_name(cxlmd_b->dev.parent));
>   
> @@ -2059,11 +2060,11 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>   	if (rc)
>   		goto err;
>   
> -	rc = devm_add_action_or_reset(port->uport, unregister_region, cxlr);
> +	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> -	dev_dbg(port->uport, "%s: created %s\n",
> +	dev_dbg(port->uport_dev, "%s: created %s\n",
>   		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
>   	return cxlr;
>   
> @@ -2191,7 +2192,7 @@ static ssize_t delete_region_store(struct device *dev,
>   	if (IS_ERR(cxlr))
>   		return PTR_ERR(cxlr);
>   
> -	devm_release_action(port->uport, unregister_region, cxlr);
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
>   	put_device(&cxlr->dev);
>   
>   	return len;
> @@ -2356,7 +2357,8 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>   
>   	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
>   	if (rc == 1)
> -		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport), &ctx);
> +		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
> +					     &ctx);
>   
>   	up_read(&cxl_region_rwsem);
>   	return rc;
> @@ -2732,7 +2734,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   
>   err:
>   	up_write(&cxl_region_rwsem);
> -	devm_release_action(port->uport, unregister_region, cxlr);
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
>   	return ERR_PTR(rc);
>   }
>   
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7232c2a0e27c..754cfe59ae37 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -536,7 +536,7 @@ struct cxl_dax_region {
>    *		     downstream port devices to construct a CXL memory
>    *		     decode hierarchy.
>    * @dev: this port's device
> - * @uport: PCI or platform device implementing the upstream port capability
> + * @uport_dev: PCI or platform device implementing the upstream port capability
>    * @host_bridge: Shortcut to the platform attach point for this port
>    * @id: id for port device-name
>    * @dports: cxl_dport instances referenced by decoders
> @@ -555,7 +555,7 @@ struct cxl_dax_region {
>    */
>   struct cxl_port {
>   	struct device dev;
> -	struct device *uport;
> +	struct device *uport_dev;
>   	struct device *host_bridge;
>   	int id;
>   	struct xarray dports;
> @@ -641,21 +641,22 @@ struct cxl_region_ref {
>   /*
>    * The platform firmware device hosting the root is also the top of the
>    * CXL port topology. All other CXL ports have another CXL port as their
> - * parent and their ->uport / host device is out-of-line of the port
> + * parent and their ->uport_dev / host device is out-of-line of the port
>    * ancestry.
>    */
>   static inline bool is_cxl_root(struct cxl_port *port)
>   {
> -	return port->uport == port->dev.parent;
> +	return port->uport_dev == port->dev.parent;
>   }
>   
>   bool is_cxl_port(const struct device *dev);
>   struct cxl_port *to_cxl_port(const struct device *dev);
>   struct pci_bus;
> -int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
> +int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
>   			      struct pci_bus *bus);
>   struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
> -struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> +struct cxl_port *devm_cxl_add_port(struct device *host,
> +				   struct device *uport_dev,
>   				   resource_size_t component_reg_phys,
>   				   struct cxl_dport *parent_dport);
>   struct cxl_port *find_cxl_root(struct cxl_port *port);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a2845a7a69d8..76743016b64c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -72,13 +72,13 @@ cxled_to_memdev(struct cxl_endpoint_decoder *cxled)
>   {
>   	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
>   
> -	return to_cxl_memdev(port->uport);
> +	return to_cxl_memdev(port->uport_dev);
>   }
>   
>   bool is_cxl_memdev(const struct device *dev);
>   static inline bool is_cxl_endpoint(struct cxl_port *port)
>   {
> -	return is_cxl_memdev(port->uport);
> +	return is_cxl_memdev(port->uport_dev);
>   }
>   
>   struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 45d4c32d78b0..4cc461c22b8b 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -163,7 +163,7 @@ static int cxl_mem_probe(struct device *dev)
>   	}
>   
>   	if (dport->rch)
> -		endpoint_parent = parent_port->uport;
> +		endpoint_parent = parent_port->uport_dev;
>   	else
>   		endpoint_parent = &parent_port->dev;
>   
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index c23b6164e1c0..4cef2bf45ad2 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -91,7 +91,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>   static int cxl_endpoint_port_probe(struct cxl_port *port)
>   {
>   	struct cxl_endpoint_dvsec_info info = { .port = port };
> -	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct cxl_hdm *cxlhdm;
>   	struct cxl_port *root;
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index f5c04787bcc8..4f62eb55f8b8 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -754,7 +754,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>   		/* check is endpoint is attach to host-bridge0 */
>   		port = cxled_to_port(cxled);
>   		do {
> -			if (port->uport == &cxl_host_bridge[0]->dev) {
> +			if (port->uport_dev == &cxl_host_bridge[0]->dev) {
>   				hb0 = true;
>   				break;
>   			}
> @@ -889,7 +889,7 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>   		mock_init_hdm_decoder(cxld);
>   
>   		if (target_count) {
> -			rc = device_for_each_child(port->uport, &ctx,
> +			rc = device_for_each_child(port->uport_dev, &ctx,
>   						   map_targets);
>   			if (rc) {
>   				put_device(&cxld->dev);
> @@ -919,29 +919,29 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
>   	int i, array_size;
>   
>   	if (port->depth == 1) {
> -		if (is_multi_bridge(port->uport)) {
> +		if (is_multi_bridge(port->uport_dev)) {
>   			array_size = ARRAY_SIZE(cxl_root_port);
>   			array = cxl_root_port;
> -		} else if (is_single_bridge(port->uport)) {
> +		} else if (is_single_bridge(port->uport_dev)) {
>   			array_size = ARRAY_SIZE(cxl_root_single);
>   			array = cxl_root_single;
>   		} else {
>   			dev_dbg(&port->dev, "%s: unknown bridge type\n",
> -				dev_name(port->uport));
> +				dev_name(port->uport_dev));
>   			return -ENXIO;
>   		}
>   	} else if (port->depth == 2) {
>   		struct cxl_port *parent = to_cxl_port(port->dev.parent);
>   
> -		if (is_multi_bridge(parent->uport)) {
> +		if (is_multi_bridge(parent->uport_dev)) {
>   			array_size = ARRAY_SIZE(cxl_switch_dport);
>   			array = cxl_switch_dport;
> -		} else if (is_single_bridge(parent->uport)) {
> +		} else if (is_single_bridge(parent->uport_dev)) {
>   			array_size = ARRAY_SIZE(cxl_swd_single);
>   			array = cxl_swd_single;
>   		} else {
>   			dev_dbg(&port->dev, "%s: unknown bridge type\n",
> -				dev_name(port->uport));
> +				dev_name(port->uport_dev));
>   			return -ENXIO;
>   		}
>   	} else {
> @@ -954,9 +954,9 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
>   		struct platform_device *pdev = array[i];
>   		struct cxl_dport *dport;
>   
> -		if (pdev->dev.parent != port->uport) {
> +		if (pdev->dev.parent != port->uport_dev) {
>   			dev_dbg(&port->dev, "%s: mismatch parent %s\n",
> -				dev_name(port->uport),
> +				dev_name(port->uport_dev),
>   				dev_name(pdev->dev.parent));
>   			continue;
>   		}
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index dbeef5c6f606..da554df50bac 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -139,7 +139,7 @@ struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
>   	struct cxl_hdm *cxlhdm;
>   	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>   
> -	if (ops && ops->is_mock_port(port->uport))
> +	if (ops && ops->is_mock_port(port->uport_dev))
>   		cxlhdm = ops->devm_cxl_setup_hdm(port, info);
>   	else
>   		cxlhdm = devm_cxl_setup_hdm(port, info);
> @@ -154,7 +154,7 @@ int __wrap_devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
>   	int index, rc;
>   	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>   
> -	if (ops && ops->is_mock_port(port->uport))
> +	if (ops && ops->is_mock_port(port->uport_dev))
>   		rc = 0;
>   	else
>   		rc = devm_cxl_enable_hdm(port, cxlhdm);
> @@ -169,7 +169,7 @@ int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>   	int rc, index;
>   	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>   
> -	if (ops && ops->is_mock_port(port->uport))
> +	if (ops && ops->is_mock_port(port->uport_dev))
>   		rc = ops->devm_cxl_add_passthrough_decoder(port);
>   	else
>   		rc = devm_cxl_add_passthrough_decoder(port);
> @@ -186,7 +186,7 @@ int __wrap_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>   	struct cxl_port *port = cxlhdm->port;
>   	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>   
> -	if (ops && ops->is_mock_port(port->uport))
> +	if (ops && ops->is_mock_port(port->uport_dev))
>   		rc = ops->devm_cxl_enumerate_decoders(cxlhdm, info);
>   	else
>   		rc = devm_cxl_enumerate_decoders(cxlhdm, info);
> @@ -201,7 +201,7 @@ int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
>   	int rc, index;
>   	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>   
> -	if (ops && ops->is_mock_port(port->uport))
> +	if (ops && ops->is_mock_port(port->uport_dev))
>   		rc = ops->devm_cxl_port_enumerate_dports(port);
>   	else
>   		rc = devm_cxl_port_enumerate_dports(port);
