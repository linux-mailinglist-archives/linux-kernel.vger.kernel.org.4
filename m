Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2F73ACB6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjFVWvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjFVWvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:51:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4CC1BD3;
        Thu, 22 Jun 2023 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687474297; x=1719010297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R7TW9I1mgwZvEHZzB7pNo8A/mLRgbCKgkbJUrp8/ApE=;
  b=OLANC7ae3c4zWpZv9LzYrq/vSiRfIwQaxn3CnCcaNoUpno/Ha7sLCFFt
   l7zX8BrN/mpUwJE0BKyHPflpkA+at9OpWLJ9oYqreeedTIeNXOZS5Otx7
   rvm78BeXbm7okmu3w1fVUDUuF6gXHBBL66gZIPjt4vHgyayL6g9Sor9Wu
   E00Mdg0WWiNMYC9+x3+3qj6BVvRpe80mHsvtvihjq/Ws8U40j1AeYX7O+
   V9O7proY5sc0Cp8rdSoaeZ6Zogw31JhgcQn8wNtIfKxrIS0uddHVXkvS6
   3gVfTcrkJcqz3TRQsoDwanoiqD1nmulGJVjEt63B55++sASIxHhmYZ9/9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350395854"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="350395854"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 15:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="839233881"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="839233881"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2023 15:51:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 15:51:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 15:51:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 15:51:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmEwL2in9oTZsbNbOT1PX+Q6mLwFvwSHLTt/WyXNJ8HutQX707s9dEOWMgX4aD8qqHaSTLCF3Z3qthOIK6Qouy3jgm84aETCWPuK99OxXSwQINSvgdJil3IEAs+ejBX6wA0u226WvKD8XEGXFXiUnr364wU5pPHkiCM5LlVPDdQct5RI+LsKB2Y9u+6L0TiBzZHfT7Jhd4EwnAg4s8ia7zglMUBt2GMH+UZkoJulQ14i499/7XrwC74xTfiXiTej2EDTvDeCgEUWdPG4U7lI2NA3L6O6pZUsD3wMsn2kYKJLUPyrb0QzTnusqTTp2byru6bHwVwJ6nWIXRfJPHl8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyTfr/YVmzwKI3u031paH2lUAGPApfznHquGsnjgE+I=;
 b=OJTlbZUZam7Gwku8cMClnIiT8foG8WazQVAXzPYSIHZuIHuT11osEVBp62BSUZW3rULmHMhmBLiCroA5UZCcc+jMzMCCGGX+lTeWwJv3VdXevVwBd/7/xSZHWxmZlzkRvXvVgMogJ/YrmdiSec4bH/HwvJIcPFV0NwymRB0s9So7aCmifu5UCA4LplV44nfq44YPdIVWxrSMDKbmMrYcPcA1KN0T/r9Q+zV3soDLl2nAxCaL8O93eLrKbgKJHzDRT/cCMRdXI2kM9vSF5Uoi0IiHDn0lIqDGP958p3E3Qbb+k/3gB4fCwOK28IkzvNhgoDuvHNA+3SrlacLvv5HNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 22:51:33 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 22:51:33 +0000
Message-ID: <cf141508-797f-8ae0-4a1a-ce5b046fb364@intel.com>
Date:   Thu, 22 Jun 2023 15:51:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 04/27] cxl/rch: Prepare for caching the MMIO mapped
 PCIe AER capability
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-5-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-5-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: e621827b-10d6-4120-8c54-08db737339e0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhQoEE89dB52oAVCszJmWmlCO1ZK5C/Zq598P9XQRhFv/h6Bqe9iKkCmvQYTfUQLj/v51O2uJzeUOV0Ib18ddq57QscMZd981YTpr8Yb/ZcFUvvo720qSXLtA5L9rtVPE2S80F279nqGEenMt2kebDZ8mrZRuiIbqAfzO08j6sWDwLKPbJz/YUuBZrvG7vTcMLtTfnFhJwVOwUmLOvkc5VyKAgY+DETsLpkQfN9UEyEehVYibctNRR7Z1snCb4klQqanA2RMaxprz891LjnXWjv5VT0m9L71wIMf6mmXaVSsqf5m8qtQ+PP+GTMYELPqixvZZ0f2dk3X0OJXs5XeRMYHYEFx/WldE4bHpo0+ppJfXKc5g3rwNNf5zx4t+UsIcYcIem0p82/Fvy3e2TfcblUdlalqeIxZcMNPKp3GueZA7vv3v87yFVMSyyEPr6ulykik3GbgDXpPn/Zox3sr49R1I1daeQVph03lwwn6P6soiGWg1yoxjIbLqfSMkFiq/wT9T9CTv9c3JUclS/o5WFC6y9FFXOTbKxOGpgf1PwE+sS+LlfGN19+W3xyXQBU2p43mrM1eBM+8dwrJIKay44gdHx7s709ocsXiJpdanvgjAZqDiMnmW9qyEHd3+ow4gmfWspCkP1g/JaqrRUprLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(86362001)(31696002)(41300700001)(8676002)(8936002)(66946007)(66476007)(66556008)(2616005)(316002)(44832011)(83380400001)(5660300002)(6486002)(6506007)(53546011)(478600001)(6666004)(6512007)(4326008)(186003)(26005)(82960400001)(38100700002)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnFEVGpnb2xsaGdxc2V3SjVZRDUyc2FmdENueDIxS0dCYVBpT3NEOUR0OTcx?=
 =?utf-8?B?MkhRNWJFTGVFNkg3QXQ1ZWhNZlU5ejlTbE9XbHFQSDdoMm85SmQ5SjJoNFpR?=
 =?utf-8?B?YzVpQytNMEhBUndQVTlOMk5rU3JSNDJyMHZGcEdaT0Zoc3FqMWRpQTJCRjFy?=
 =?utf-8?B?alNMaG9WOGR1NFdmZHlEMlhCbFdLRGM1OUY3dkNaZXEvZTZlUjlMYnBKNEla?=
 =?utf-8?B?SE5XcFVBMUpJcXM0aWNOaFFtN3h6S2tUNzZIK0cydjhGSGVRTVlKSWMzNGJi?=
 =?utf-8?B?TU1jZjdOOGRGMW5OUlU2Q1kxQS9WME1pL0U5VjhtRW1xb0Q4QU9yL3Jzc2dN?=
 =?utf-8?B?QysrOUNRNjRVaWRjaUhLK25HYVBPQjUrVFZIb09nV0Y1QUl1N1huOGVTNHZR?=
 =?utf-8?B?UUtMbWNwWHgxVTAyckRWanNGZ21XVi8vTU0zTjdMb1FyTFZGZ0RsOXdmZzdO?=
 =?utf-8?B?K0JGdlAxMVd1TEh6TmtRamlVcEFRUVp6bU9SdEZIQUl4bFNWWFJHSGczbW1M?=
 =?utf-8?B?SkJuOVQ1S3M5RlU4Q0ppekZzZWZLbjlRa1VkM3dmcVFtdGszTk80ZDMxOGtY?=
 =?utf-8?B?OGpjdU9rWjJEZ3B1MDhkOUNVV0x1MElva3oxZGNGZnc2TldzZkVjRnVSK042?=
 =?utf-8?B?MFVEK3F0cE1VMjJVWmg5dnQ3aHJWOUlSTFRmR05jVE1KL2d3YWF6cFpCU0dK?=
 =?utf-8?B?elozcHErbmZQTElZNSttQ2M5UnpCekh6QXdQUlJoQVlweHdWWlJFZDE0THZt?=
 =?utf-8?B?eXNxdXUrUkJDVmJFdlI0bVRrblF2b205NmZoeEk1bFRLbXdiT0xaWUUxRDdx?=
 =?utf-8?B?aUlpeTRUeXh3aVN1Ulp6b3Z0OXFqbjFicDRCVlh6NHZ4M1Y2a2JuektWdk1o?=
 =?utf-8?B?UHp4cDBVdnJQOUFSL04wS1FRbURwSDUveFVTdnVnMDduUnBxMjBhZWhVVUxp?=
 =?utf-8?B?c2dZMEMrd1dGUHc2OEo5UGVhckY5Z0xMbExvaGkvTWhybDdGODQxakR0VVJz?=
 =?utf-8?B?emU1ZVN1MHZxV0J2M29weVYwaUkxNE9XR2NnbDBadjZvMkxBYWNDTjN6VGdy?=
 =?utf-8?B?VnBzWmhPQVFRaWg5cWpiWnBvbTJqMGRlTGJ3dDBGK05lSFhtL2xVVm5xT002?=
 =?utf-8?B?a0tDY1BQZGlYSWw5eUxRZlpQeTNKb2Y1cFBNbEtWTmsrYmNuNVlYWUhKemdp?=
 =?utf-8?B?a1pySVNKTm85MkNERHAvTEIrMmoyemJ0cDNEUXp0WHBjekNKUXZKd0M4bnYx?=
 =?utf-8?B?VW14dmxyaTdMdXQ0cEZ3a3FmY3Nydm5jK2x3aG91dGg1dWY0VEU1Z2Q1bllU?=
 =?utf-8?B?WllTSmVvV1pFUUZWMkhVZ0I1RUFsc3RkTW12b2xXVTNsRjRrM1ErL29UcWpG?=
 =?utf-8?B?YnpRZ1hLTGZFbXRSa0hPRU0zNDFMTUFHNWZjTUFLbmFWVE8zM0FBSW9sVFVa?=
 =?utf-8?B?ckpYR1JnYlQ1dUF6ZllUdXR1aVZZc3A2TXRsNkx2b3hDTWFPRGp6N2dhUjJm?=
 =?utf-8?B?RkQvcTFSZGovWGd4Q0NsTm44L3lSanlGT1M4THg3YjU5NmthOFY3VXY5Uk13?=
 =?utf-8?B?eHpCYU9lOVhNTkVKNzhKMzdrWFVIRzdnWkIrRG4xOGxZbno2cG0wY01NY1l1?=
 =?utf-8?B?alU1UWRreGxycWlSZ0hEWDVib0x6TU1MY1d1OEgxQjFBL2FHT2cyYm9aU1g3?=
 =?utf-8?B?Uk83N1Q0WVpldTh5dEVPL1hBSmtvYmptTnIyYUNMcjBkREhnWGZGSmd2OWlp?=
 =?utf-8?B?VmY3WVM5aGtZOFBzMlpwb1dsYUFKMDA0VTZQcm16N3pQcEYrSG8veVB3WTB3?=
 =?utf-8?B?NmlmakNhYmJVTHQweVRXRTBNZnNGYU1pc1cwMkRYc2c1MnhPYTRheXNialNQ?=
 =?utf-8?B?MUNZTTBqYmdRbk9KeU4rUitRQXg3eFVaa2FadEpLZ1ZaNXN4U0RsenhFNERn?=
 =?utf-8?B?aHZLR2JXbHJsVjJUYW5ldC9LdjlKbXpYYWZMNGptdDFrRGJ5OWpCcVNTWG0v?=
 =?utf-8?B?V2k3dzd0UlY5eTd5bnA5MGFLWDlCclRSNzkyVmJlYmJMcUZwQ1h3NkpwVEs2?=
 =?utf-8?B?SGErcGFOQXZMTDBJMExQTGYyVkhENzVzSTZ0emM5VHRKc25GQ3ZRMDBvYnZO?=
 =?utf-8?Q?ABgRsYrVjDUY0SNGqQDm3OCVV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e621827b-10d6-4120-8c54-08db737339e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 22:51:33.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3v8JaFRGzpkbpsyEnS1vSFt9Oodimv+iRZUikax7EZMcG2XxhYg5Z2YFsmfRqIZv9tLLhbeqovFCEQB3sg7MkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6408
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 20:51, Terry Bowman wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Prepare cxl_probe_rcrb() for retrieving more than just the component
> register block. The RCH AER handling code wants to get back to the AER
> capability that happens to be MMIO mapped rather then configuration
> cycles.
> 
> Move RCRB specific downstream port data, like the RCRB base and the
> AER capability offset, into its own data structure ('struct
> cxl_rcrb_info') for cxl_probe_rcrb() to fill. Extend 'struct
> cxl_dport' to include a 'struct cxl_rcrb_info' attribute.
> 
> This centralizes all RCRB scanning in one routine.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/core.h       | 4 +++-
>   drivers/cxl/core/port.c       | 4 ++--
>   drivers/cxl/core/regs.c       | 5 +++--
>   drivers/cxl/cxl.h             | 9 +++++++--
>   tools/testing/cxl/test/mock.c | 4 +++-
>   5 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index bd0a5788c696..b001669a5133 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -68,7 +68,9 @@ enum cxl_rcrb {
>   	CXL_RCRB_DOWNSTREAM,
>   	CXL_RCRB_UPSTREAM,
>   };
> -resource_size_t __rcrb_to_component(struct device *dev, resource_size_t rcrb,
> +struct cxl_rcrb_info;
> +resource_size_t __rcrb_to_component(struct device *dev,
> +				    struct cxl_rcrb_info *ri,
>   				    enum cxl_rcrb which);
>   
>   extern struct rw_semaphore cxl_dpa_rwsem;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 45f5299af7a6..76888c75dae4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -939,7 +939,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   		return ERR_PTR(-ENOMEM);
>   
>   	if (rcrb != CXL_RESOURCE_NONE) {
> -		component_reg_phys = __rcrb_to_component(dport_dev, rcrb,
> +		dport->rcrb.base = rcrb;
> +		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
>   							 CXL_RCRB_DOWNSTREAM);
>   		if (component_reg_phys == CXL_RESOURCE_NONE) {
>   			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
> @@ -957,7 +958,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   	dport->port_id = port_id;
>   	dport->component_reg_phys = component_reg_phys;
>   	dport->port = port;
> -	dport->rcrb = rcrb;
>   
>   	cond_cxl_root_lock(port);
>   	rc = add_dport(port, dport);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 564dd430258a..6c4b33133918 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -332,10 +332,11 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
>   
> -resource_size_t __rcrb_to_component(struct device *dev, resource_size_t rcrb,
> +resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
>   				    enum cxl_rcrb which)
>   {
>   	resource_size_t component_reg_phys;
> +	resource_size_t rcrb = ri->base;
>   	void __iomem *addr;
>   	u32 bar0, bar1;
>   	u16 cmd;
> @@ -400,6 +401,6 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>   {
>   	if (!dport->rch)
>   		return CXL_RESOURCE_NONE;
> -	return __rcrb_to_component(dev, dport->rcrb, CXL_RCRB_UPSTREAM);
> +	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 28888bb0c088..7c8674079f1a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -582,12 +582,17 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>   	return xa_load(&port->dports, (unsigned long)dport_dev);
>   }
>   
> +struct cxl_rcrb_info {
> +	resource_size_t base;
> +	u16 aer_cap;
> +};
> +
>   /**
>    * struct cxl_dport - CXL downstream port
>    * @dport: PCI bridge or firmware device representing the downstream link
>    * @port_id: unique hardware identifier for dport in decoder target list
>    * @component_reg_phys: downstream port component registers
> - * @rcrb: base address for the Root Complex Register Block
> + * @rcrb: Data about the Root Complex Register Block layout
>    * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>    * @port: reference to cxl_port that contains this downstream port
>    */
> @@ -595,7 +600,7 @@ struct cxl_dport {
>   	struct device *dport;
>   	int port_id;
>   	resource_size_t component_reg_phys;
> -	resource_size_t rcrb;
> +	struct cxl_rcrb_info rcrb;
>   	bool rch;
>   	struct cxl_port *port;
>   };
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 30119a16ae85..dbeef5c6f606 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -271,8 +271,10 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>   	if (ops && ops->is_mock_port(dport_dev)) {
>   		dport = devm_cxl_add_dport(port, dport_dev, port_id,
>   					   CXL_RESOURCE_NONE);
> -		if (!IS_ERR(dport))
> +		if (!IS_ERR(dport)) {
> +			dport->rcrb.base = rcrb;
>   			dport->rch = true;
> +		}
>   	} else
>   		dport = devm_cxl_add_rch_dport(port, dport_dev, port_id, rcrb);
>   	put_cxl_mock_ops(index);
