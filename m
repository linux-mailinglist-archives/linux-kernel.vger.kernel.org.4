Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A6C73AD59
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjFVXsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjFVXsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:48:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853B2121;
        Thu, 22 Jun 2023 16:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687477696; x=1719013696;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qFN/7O/IOUid8uKDjKNk1nakIvRnpSKQGjwVflZsZXU=;
  b=nfa3wIyFVvDDOCX/rvPOJDnwAxFh2JHDW4AJLGwREN9ZT7GEP74QFNzP
   6NvVzqTeDgBDfOs2CgwIhqEYos8nh2/rUjDDKW87y+7xD+dUCQ3nunnC7
   Vsh38L0enyufbkemL5h4AWBWZ+1zokgW6r7BFydGEVnida69vrX2D2AFx
   8PbklhftiloTH69TbXXVzqgS2BwwmUKdBtUOtfZuZGTrqAlIOdsbhGFcq
   /hHsC7x9Q3CfvzFEXbCBMofkdrbUornSFCjlx9eghi6QCDJt15cLo+9Rt
   PHfnLHUz0U0yuSFmENSmSrBQ9n8L+ZBozjHbF2qcggUr6hHYUZrCyTL6L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340981526"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="340981526"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:48:15 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="749536267"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="749536267"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2023 16:48:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:48:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 16:48:11 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 16:48:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIomqXRa/EQsfVdWEvrdWNAouHoxVbDejzeYMUo3RBwUA7B8FAx/loPLJ72f60pBN3Xl1e4TkVhT4QOt1dEBYQbA425RY+4QuRO+Vz1JF1nstOldamceUAptlkcozjHL2LFV3Ud+o6gKVNReI5nq494ZerVncYDGD8c0aZHB1TdGxp6JW+BRyYAjPiaeIoTg5WcJGWbLI/GhRqxke4dqQE1aKeCiD9VirBYKwZ+0TBC+G6r4L9ek4+E/jmDxXyIyePpnsaeJ/8VgczhBoAIdyLvbdY6G2VMGiuKu6CvqwyOpR0eheD75GUsUAlIGcDfj7g9d6RotLQUpaS2CNSKRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPcAmoQH/Kf0IBibo7jM51xXWIut4OJJIZaH5VRyf1k=;
 b=bhLYGkezydQ8+OVk4NLmR+X6P6lW/5N2KY3iPMUdAyYz6Z8MF1u+j4NHllb6C3e7BEFY5ut2UlkFll8KHAmNS/pQYtY5cPt6hQMZ+tMOnAbZQV5xOPlfAZLGAzxr7U2h4cuskBoFqnuZF/NsUD5gmY6oO+3rAyyJWGOkxkNcBeKUxOK95Q+cRuhV+HrMnHBVOd2MzwCybcbU4GBaYw797IrfP68jqq9mmpRJYYY9bm55ROqBZo1A63UsFsNitFIcMzc2LZrPZi9hJo8VA4vmuYNIi//EP0gnxgUareyEcFcYEDS+dVhnorUq0lgBYuYQZgXcFyjq8O3URQaEjOngLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB6540.namprd11.prod.outlook.com (2603:10b6:208:3a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.40; Thu, 22 Jun
 2023 23:48:10 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 23:48:10 +0000
Message-ID: <a451d410-4acb-8d79-36ed-da14bfd5a9c6@intel.com>
Date:   Thu, 22 Jun 2023 16:48:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 12/27] cxl/regs: Remove early capability checks in
 Component Register setup
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-13-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-13-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: ab897432-5e9d-450a-e6fb-08db737b2256
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wD8rdANW+5ro/ebZCbrFEdFIrN/mkM53kKPfAKVuAYRYku8qaGBRUlIpgOfrQCzAl+NtPzXgUgx1uEJjMwwAPPL6K5ALZ4xWGG60yyQf525Ago9GNBKd18WWWewos+i+744M0yLV3kvH4CmMG7t4VCVfIIaSYtGm0NQLPF4Eb0spVM9iHkQ+DqgbBZwEYDvDsc+/yao/uHtLmBncKoQYxhh0qSsQ0VqiBDOKd8h/1eBdd0aBpOwQ4pvOh/aHex0jZYN2S10cftFaSsItkLkiNDlXa4cIaJfuxdUFmAjvl6GebMRI2cIOkpkNU4ECwFPbmoCxodLfD8qNBrWnPuX9vcRhSTHphmhfeMODRa5JgociKkdrWRrmxdqK/6RBuNNtOs8ziXeEy8t3XuYLW4Tvr+4kQHmfjDoZ2/yVGHNok5TofjvHsZ/6eSxOqlGg9+eiOdq4DPHOM09ignqiEnp8Zx/E8oOk4UCLkKLYsHe3sQo37Rj0XDmZMhsBNC1ruoHP80B/ugKMz/m5pYhdBolLSxe8FuFFWfBH7PPIwPodcSQpWZGfsRfEjs/wXx057W0jVashfpfk9+MJRGDNXrNlfWsx3jMFbD0g3n1tR9QOz6S0JyLbkPiBeEpt/HeqsFtulnoxfkaS6dZTbRpXUh8ehQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(53546011)(82960400001)(38100700002)(26005)(6506007)(83380400001)(2616005)(186003)(6512007)(44832011)(8936002)(41300700001)(8676002)(5660300002)(36756003)(6666004)(66946007)(6486002)(478600001)(4326008)(66476007)(66556008)(31696002)(86362001)(316002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTVKWHJVWjFzNVBOQVd3OUtEek8zOGRyVzFEVGIxeHljM1pZY1pmMjJkTVg3?=
 =?utf-8?B?Nk1nRHkxMTV3WEM5dEJvNjRvQzNVeEJFMC85aUxVL3ZIVUtVMHhQbzdVcjJP?=
 =?utf-8?B?MFFYTm1BWk9PM2REUFNIb0hXTGJzUC9Sc1RGYkVwNzFjR3lMVHNiYjFpOERV?=
 =?utf-8?B?a2VWRjZRQmdJd3UwRUR1YkRlZGdobjRIaHRsN2F0OCs5M1BpZGlpcElCblpL?=
 =?utf-8?B?Mi9oTStkYjRzNk41RXowaXllUXBRRjRUUkkrdCs3WmZLT3BtRlFIcmw2My9w?=
 =?utf-8?B?OHhvdWJERTdSdTRNZXVUcTJKdDZCRUNKMGllMFJ1NkVvK3BOcU81NUNJZDNl?=
 =?utf-8?B?YjM2MW0ralBZRDd0ckxJMEtoSEpGbURDci9aQWhhc1V2V09iVHpNMHBienZO?=
 =?utf-8?B?TTc1N2hZMGI3MHM0MWVDUGp4QUdFK3VUT09ZOEZNZDI0N3FMVHJFa2FFd0Uw?=
 =?utf-8?B?RmQ5cVVsNVdQTk9GNGZPTXpmMUNZbmVsbFZMMG1wbkRjeDJKNy94cjBFY1N4?=
 =?utf-8?B?ZmV3aCt2U2dDK3ZleWd6NXRBUmxDNW0zL2VuUXhQZitmb3EzU0I1Y2hWNlpr?=
 =?utf-8?B?OVV0SW1CeXlnVG0yeis1RlV3TG41Snh5QTVaQ0RRaUk5eUd4dGE1L2s0VEla?=
 =?utf-8?B?ellkczgwNjhSOHBML1oxZHZ2VjQ1RjExMkxKd2k3VWk2cmxEUm5NaUQ1VURE?=
 =?utf-8?B?QXdZRzkvZFBrWlQ4SzM2VTlaZndRaUs3Nm8xZFVMbUdFa2F2bk8wVDVvVmhS?=
 =?utf-8?B?WDJML1dldXBJWGEzaUxCTXBLVGhGTEM0NjRQWk9USUtxMW85U0ZSckZ5OVFo?=
 =?utf-8?B?N3IwTllsL0FoNnk2UktaKzR0eEhUNFI0K2gwZU1kVXQ5NGJ5WlFWeVlFYlAy?=
 =?utf-8?B?M2ZsQytrQVpRS2dMQ3UyK25pNXp3Mno2V3FDMGdsemRmMS9od1RidFRjNWp3?=
 =?utf-8?B?ek1rZHVHUkhnYmpQV2VYdFh4Si83Q0dkcmxUdEJVbGpMTFBOektqTDhMTGtL?=
 =?utf-8?B?TnUvaWZ2cERSR1lrWDlZVW1yVWlBUXRCYkEzWUtlNmY4YUtUMHI4Nzdnb05u?=
 =?utf-8?B?b3JmYjRBNDZGTXJZMlZlNkI1ZGJjWGlHdC9HUUcwakhTa1RvUnljTWJQL2RK?=
 =?utf-8?B?WDlOc0E3OXpOWEJsWHFxMjd5dXdBK3hBa3plQkJhL1dnVVIyRjE4MU1PM3Ar?=
 =?utf-8?B?Vm9Ca25LWGU2ZnN0a2lON1FmZWMyK2ZtMVV0M3RsOFY3VGRCSnNRSmhwVk1i?=
 =?utf-8?B?TzFGWjU2a0hHUERLNFoyTDBYRm1DVEVLaDVBQWtNblNoWnorcmNldHN2RXBh?=
 =?utf-8?B?TVNzTlRaR0FkT3djd0hFUmZWMUV4YWNjY2YvZkFBN1RXYU9hYi9SaDdxYUpa?=
 =?utf-8?B?VWVndC9HVTNscjU4OFhpckwveFVCMDk5RlRNek54eTZIak9jcmdDNkdOTEV5?=
 =?utf-8?B?c1NNTGtxQmhqcW9pOHV1UFlOTWJMTnNRUVI0TE1JZk5oNUl2RTJMRGZaYS9j?=
 =?utf-8?B?RUMwT2c0YTdaU0xPS1RBZWZQT3hBQURGdWlEUVNtVzE3K2xISkpRRXlWQ1lH?=
 =?utf-8?B?S2hFRlpIS2srYTdyOURoQlRUYTQxaTJSMDREeC9tZHBwdVVWdC9iU2ROSUhR?=
 =?utf-8?B?aHl3UVBlUEJ0QkZlZThnTmNsQkJ4aFNXVkxTbDNRTnZzNGZrS2lOQUE3L3Iw?=
 =?utf-8?B?amVQYysybitUWnFQOC9DNmgvcWQyUDhtRnNzenUvTUluazgwaU5qWmtLSU1W?=
 =?utf-8?B?NFdqdGM1UlMyM0RMWlRZYUZ1Z1ZHcTI1bFNjYXJSL2dva2FzZ0RPOThSUFZv?=
 =?utf-8?B?eVoyT1lQRmsxeUY1MmkwZ0hhZk05aFo4M0FpYkdsSXZpZlk4WlVFWFlZbWZs?=
 =?utf-8?B?cHZmQWJNb1ZwQytDc1JRTGpnMmxwcWRTcGJLOUgwSE1COTNDUXB2Zk1STTN3?=
 =?utf-8?B?eDdzZkRSYXpHeEVwTm4zZHE0V1A2TUtEOFgyOG92WkEvRUE5b1RNU0h6bHNH?=
 =?utf-8?B?RzU3SGxrNWNaUGNxckpLeTVlTFlkRkdCVE5HODQyMzVQcnV4aDB4ZnlPZXM0?=
 =?utf-8?B?K2JJWU5HT3ZkRVN1VDZ0RjcwQnM1dllQb09pVWpGdHVoTTRXWmpBb2JBY2RJ?=
 =?utf-8?B?aXBIOEYrcTJDb242NHBqK0tXNzM1R0xtTzJTc25zS0lvRG1tMzhLcUJzYUhG?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab897432-5e9d-450a-e6fb-08db737b2256
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 23:48:09.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LX5NTDN7+KuhXNflYGp/3stJ4hKTEN1gD0+ob2Fiko1p9EjiMbpJ2WcfiQh++Fp0powe7v014M0Wn/E/VfrUiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6540
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
> When probing the Component Registers in function cxl_probe_regs()
> there are also checks for the existence of the HDM and RAS
> capabilities. The checks may fail for components that do not implement
> the HDM capability causing the Component Registers setup to fail too.
> 
> Remove the checks for a generalized use of cxl_probe_regs() and check
> them directly before mapping the RAS or HDM capabilities. This allows
> it to setup other Component Registers esp. of an RCH Downstream Port,
> which will be implemented in a follow-on patch.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/regs.c | 8 --------
>   drivers/cxl/pci.c       | 2 ++
>   drivers/cxl/port.c      | 5 ++++-
>   3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index e035ad8827a4..e68848075bb6 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -369,14 +369,6 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>   	case CXL_REGLOC_RBI_COMPONENT:
>   		comp_map = &map->component_map;
>   		cxl_probe_component_regs(dev, base, comp_map);
> -		if (!comp_map->hdm_decoder.valid) {
> -			dev_err(dev, "HDM decoder registers not found\n");
> -			return -ENXIO;
> -		}
> -
> -		if (!comp_map->ras.valid)
> -			dev_dbg(dev, "RAS registers not found\n");
> -
>   		dev_dbg(dev, "Set up component registers\n");
>   		break;
>   	case CXL_REGLOC_RBI_MEMDEV:
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ac17bc0430dc..945ca0304d68 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -630,6 +630,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>   	if (rc)
>   		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> +	else if (!map.component_map.ras.valid)
> +		dev_dbg(&pdev->dev, "RAS registers not found\n");
>   
>   	cxlds->component_reg_phys = map.resource;
>   
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 4cef2bf45ad2..01e84ea54f56 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -102,8 +102,11 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>   		return rc;
>   
>   	cxlhdm = devm_cxl_setup_hdm(port, &info);
> -	if (IS_ERR(cxlhdm))
> +	if (IS_ERR(cxlhdm)) {
> +		if (PTR_ERR(cxlhdm) == -ENODEV)
> +			dev_err(&port->dev, "HDM decoder registers not found\n");
>   		return PTR_ERR(cxlhdm);
> +	}
>   
>   	/* Cache the data early to ensure is_visible() works */
>   	read_cdat_data(port);
