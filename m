Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292C2614606
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiKAIvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAIvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:51:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D4514D10;
        Tue,  1 Nov 2022 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667292679; x=1698828679;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yw95zDdmYW/BW6jCfraYg4JBJL9vEXdtr4r3Z5zhG7I=;
  b=Hgbu+QQ3f6roCqBilMguaGnWGuuyLAwOE/QrWP/OW2D2UXwjv6xRyvvT
   foRWRGAcPbXaVvjo2oi6nZLLP/7XM6XZAQChoN3TlaXd+MpoUqSb6TIPa
   h9RPvu4kCGW4KEGQVqVL+omMEXpWh15CoIFgcp352aXje4XO+GkP4Oy+p
   lwvOEeIsFjnMhA8qzmNAGfiNLj6ASSI97BlZEU3NPyyHNBIHIoPHL72rH
   CoYUrWKw1Qxl4N651huHFuNZlsziTSV5DFEojz6V7yAc44d5MEL9dM3y5
   rH3YwjsbbYeKonDclcbrJ+4WkNPi6qm7dABnN+O+7zsm6Nhsvx4mIGh8+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="373310784"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="373310784"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 01:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="739262361"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="739262361"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2022 01:51:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 01:51:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 01:51:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 01:51:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD8H7o9ev+qzCsTq4Dx2Tsvjuc8wE4Q2qRZIrS/6UsrZpuhLOz8q4pX00QqD5wU8j1EkjIr6mFlGwMdGKZPhMDmpBW+AH9BR06Tr9LjX6mBXmleU/WGxVaD0XmeXYhWGmpB2eqEDiL02uj2eNh2n6zDpcdC6Rmr0ZEVL3xoy7CwZ/CRebBQ9q7uO3RkXT8c8L/gCwso/uaaqLZFGan4u2YJUI4k+l+yvTpU8tMya07HuMlk2O8pn0GVdZRCM49QchrupHQujcGYiVqb4zOL2/YZ79WhgzT1yk3Bm0WNYPl2xcVrkmhsqLMA5PjmBg5ZQnYy+9d0cvc1by3wgJExr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3XQK65hAqW3R8NCSqz0qSxos8gA/6Wr5gz75qgpCpg=;
 b=RvaZx4grdeJAPKoaHIVpR9qm7EJxWfuuMYkiJ2sM0mUPwR7tsL7qb3jxSqqOhM+pNLSQt3tpd81sP9NDwLgWS38ByQ3iTj3vuirK8qaBD3DdqKzIzrJPkTscVjjic0ND/H6USHOEnuxu97v1DTkx/Iti3EkS4WRXNXqHKZ09QAgUjbL9gPTAL+0cOy5fn6Gcs37F3+Cum7DsknVlRU2Im06/4hPuAfP1K/LLAgkM/QjICfA3K9crX6G+FNs55Q/q/wuQvHM051o/1awEW/DxL6d2ckDNqgjIens7GZAg25WRtwxsljKIFT/HgMnY6vp9ABLJUhd0YR94I/TlxvjRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BN0PR11MB5694.namprd11.prod.outlook.com (2603:10b6:408:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 08:51:12 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 08:51:12 +0000
Message-ID: <7ceeaf97-fbc8-54ac-2041-75f2ca8bc7e2@intel.com>
Date:   Tue, 1 Nov 2022 01:51:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 08/14] x86/microcode/intel: Meta-data support in microcode
 file
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-9-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221021203413.1220137-9-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|BN0PR11MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: ff44eafd-73e3-434b-9fdb-08dabbe63a6e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ui+nSl/oEEMQESuh4LHSYS7Rm2ZTiGAt28vFQ8KmGgBmAsGfCuE9HcRwMEi+yUJY6bj8NWxKuh+vRcJmVY2ktnUee35T1DiyU2LByGt7Gpda1rwgqdthAx/xFG5NbPyql5hbZLAlnBr5mckTRSZ3IBrDV0f1z1fnv81mNyCYbQi684CBpo1+VSWfFWWg9wDiVkixKAPvFTOkDiHzcWa+NGKuD8aCPZi/sZK3REQMMxYo+0Q7jEdSHWPTVwV7x2qshHL5vs/boQkJ2ESNYSMtNwYg2PpCqB+4ngEJ+h9djgBv1CHFNYwGSKWWZIZHTC5x1VwP0wdpUYPzACrnzVH7eSyqBctercJCffRjhQi4cv+psS+8vgYK0pL5T9Zp//ID5Sbns4S/7rS2J9OllmEu35ZgNa7JJuv6ial91d7dpHuhc8ipvew+FXvml3Yro3S+1a6AmKHGpYOqMxfkopsDsDSk86XlAd0Eo9PwXlE6I9MDtyqpx8fg+N90URiG8n2tMHK0YyYhLzGtl2rBJtFGOVghJN2muCAWi6uU+CClk7YkVcEiJmPoMBtgRgL/pvUE69aJl8YztabiLMUyad7Ia/wCpNK3lHAK8++TjB56W1EAj2cvbOOYoHgxVl09eW7aDcrilJ58rIAwjdLINh5BUydqkFDbOQtz5PymCDMjdpBqbQ08GJBgaqfN21u8e27H/O3UOO1TOnTX5iwDpIJXDYO7aboBdvH8mzsY6HpjAzfXR/7X86Nan5JFPSRz61quOQlC6YmySw4izqjNSspmsluIS6ciYVrxIpoT6UjBvrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(82960400001)(31696002)(86362001)(2906002)(5660300002)(66476007)(66556008)(31686004)(44832011)(7416002)(38100700002)(66946007)(186003)(6512007)(2616005)(6506007)(26005)(478600001)(316002)(8676002)(4326008)(36756003)(41300700001)(8936002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEN6RFBMeDF6cW1PeFlGc0pLVlZUdVBSejRpRU1ydkJvMHN4MEM5bG8yVGFy?=
 =?utf-8?B?L2FYcjVjSUowRU9CMVF5cnFDNEoraHVkdHRUQW81T1oyWVNvbFVjYzRrQlkr?=
 =?utf-8?B?Q0lsb1Ura0JIVllldEZqdk16M1Rha3VhZDJPWkI0OEN3OTE5YkFJYk8rRCtV?=
 =?utf-8?B?UjZvbDNNWk5kZ1FweXA4Qzd0TEhCODJXaThVMDdEd1BGaGVYWGtHTkd0SFZW?=
 =?utf-8?B?cEl2VVNMSEtzZ0JjR3JBTGg0WVRlN0MrVTUrVFBkbStWUysraW12U2FYYzlr?=
 =?utf-8?B?K0tIT2JTOHFKRFpZa2pxS0llWWRGUmpvaUJRQit0NThQTUNSRFpzUmFCcTVt?=
 =?utf-8?B?Vm05cE44MWZPYkxKT1BQN0NNWnM3T0xJVjRJSzdhOFd0MU1BWC8vTlBZOVUy?=
 =?utf-8?B?cHpKVkFGcDlPQkVhTk1oUko5a05VK0pSU0sxdUpwelFSN3czQVFsdU5vSlgr?=
 =?utf-8?B?dDNNVGhibHpYUUpxdHRHWlc1ZVQ0S091S2lWZDZlTUpYMFJNYi82aVFKeURo?=
 =?utf-8?B?S2w5SWdRN3c4Wmw3WUMzM3E0dy9qRzMxdmJMd0tSUUtGTnlvcDJwN3J0RU80?=
 =?utf-8?B?eDZWSnBlZExzNzdVVkRhQi9Vb0pWSzNXSkdJT1pFRThtdk0veERyNHJxaHlq?=
 =?utf-8?B?cElSZ3ZYdTA4QmJoSHE4OFgwTUxFMU9Ba2c2dHYxVEUrOWRhelZXbWdNZ01H?=
 =?utf-8?B?dDk4NmtTZDBkczZJT2g0aUZlbGRzSS95bzdadnc0c3lYYWo0TFhLZCs3RG11?=
 =?utf-8?B?ZWxLbG9VSm0yYnZ4Mzc2d2I2TnVjaGMzdG5OQ0xiK1IwajhRcmVtK1hOTjho?=
 =?utf-8?B?OFNiYlpTZm8zRzhNMG9EWGFuTVpTcXgvU003RmhXRDVTam9pTk9ZcmZtVThy?=
 =?utf-8?B?TERreW1WL3JXODdId1cvNHM4bVIvVmVaSXJlVWhzSWlhVzZ0YU12L0p6RitU?=
 =?utf-8?B?NkdJeEJka0h2UzdYTWVKRy9TNG5GOFo1Vk5zSzFQOEM1QkFzQmFJRm5BZnZm?=
 =?utf-8?B?SzF3MDJGNkdmQWpWYVRLQ2lhUGhIQW50T0ZYM3lxZTJFdVgydXQrcmQyV3BR?=
 =?utf-8?B?RjBPdnQ0blNCbnJUZGFqdFdsZUxjYXJsUGhRWFZ4dHpKR2ZOVis2WHp4TUtY?=
 =?utf-8?B?MU5pS0pudEgvM1BYeDdQNlQ0OWJHWC9Ccm1EOXd2RDJ1Vk9UVmo3K0M2Sm8v?=
 =?utf-8?B?d3graThoOGJlYW80V2RRWFZCU1dIaUNUcWdrKy8xdUJieWs1L25XUDNCT3pK?=
 =?utf-8?B?L0FudFFveG1WSmEzak5wa0F6dldkU2ZPak1PVDRHbzRqcStIVG1nMlpVU2xw?=
 =?utf-8?B?NFBNeDlGZzAxTTdEeXJFb2lyR0llZVU3L0dURmE2N3VKdFhmL0g4SG5MUGMv?=
 =?utf-8?B?aStZdTUrMlZTODRONUlaKzlYc3F1dWtoZmNySHk1blBVc0hobHkrZFlzV3lO?=
 =?utf-8?B?cHZERWpVYlF1MFpqYytwQjFodWh6dzhYYkMwcmVmNHMrY2hXd1dMMU14SkxJ?=
 =?utf-8?B?VVdnalYrYnlIbmE0cmhqODJibFJ2dHk0S1VjdFc2TDVGQVNiWk5sMTcrM0JX?=
 =?utf-8?B?YkdrT1hsZ1ZLdVlid05GYzkxMUkwMG00TDRMQUcvZEVFU3NMQjhYTVhWdEdV?=
 =?utf-8?B?Vnk2Nnh2YjMzWlAydm04NVlscXpZTGsvbHR4cTl3M0JtRWIyeWJsU2VpZ0Z0?=
 =?utf-8?B?V214ak5GdlFpM1l5U1NKMHRiRElWK0RzeGVKTExoUExaYVNpYks0STJETmlB?=
 =?utf-8?B?RjRUaUtNZVoyMXorQ2s2cGsxb0JvbEhsNytPS2ZJUWIvUDVrK2FpZVIreVVl?=
 =?utf-8?B?TWJUVE1GNkJKU0MvMk9hc2ZCejZGSkZrUnR1MDNJSGFaWk90OCtrdktVd2w4?=
 =?utf-8?B?a2tIbjhka2pCNGl5QVhpM3NCNExvVTZiUDhLWXVLVk5jZW4wUkNjN0FZM29n?=
 =?utf-8?B?K0doYlp5cWJXTlo2ZjV6NDU1aDhGcnBhRDJibW80eUgzVHJQQStqL2E1WTNi?=
 =?utf-8?B?RW9sQlFCUFhwOWxhNk0zRnBUU052eVp4NnFNRThMUXZpYWlaWXNPbFhnYnBo?=
 =?utf-8?B?MFFTc0xZZXJOTmV3NGJPdzloZWZiMVdtcHMxUUtXYmlFZklXeUZjMVBYK0NN?=
 =?utf-8?B?Z1Z0VTJRanRtaThrc3FJTXJzakFXNzVPbkVKQTZzODFBRFVoelA1VXN3b3V5?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff44eafd-73e3-434b-9fdb-08dabbe63a6e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 08:51:12.4640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewWT7AnxB0LDW7LPzBWEmp0nMGcsFUn2O6ovAxjKyirKPSzdq9LtDtmDCPFlDtaY7oE9irMlinyEXZN6lHwkWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How about?

x86/microcode/intel: Add metadata support

> +struct metadata_header {
> +	unsigned int		meta_type;
> +	unsigned int		meta_blk_size;
> +};
> +
> +struct metadata_intel {
> +	struct metadata_header	meta_hdr;
> +	unsigned int		meta_bits[];
> +};
> +

Can we avoid the meta_ prefixes in the struct variables since the struct 
name already includes meta?

>   #define DEFAULT_UCODE_DATASIZE	(2000)
>   #define MC_HEADER_SIZE		(sizeof(struct microcode_header_intel))
>   #define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
> @@ -76,6 +89,7 @@ extern int __init save_microcode_in_initrd_intel(void);
>   void reload_ucode_intel(void);
>   int microcode_intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
>   int microcode_intel_sanity_check(void *mc, bool print_err, int hdr_ver);
> +struct metadata_header *microcode_intel_find_meta_data(void *ucode, unsigned int meta_type);

Is there a difference between "ucode" and "mc"? They seem to be used 
interchangeably all over.

At least to keep it consistent across the exported functions, should the 
  parameter be named "mc"?

>   int microcode_intel_sanity_check(void *mc, bool print_err, int hdr_ver)
>   {
> -	unsigned long total_size, data_size, ext_table_size;
> +	unsigned long total_size, data_size, ext_table_size, total_meta;
>   	struct microcode_header_intel *mc_header = mc;
>   	struct extended_sigtable *ext_header = NULL;
>   	u32 sum, orig_sum, ext_sigcount = 0, i;
>   	struct extended_signature *ext_sig;
> +	struct metadata_header *meta_header;
> +	unsigned long meta_size = 0;
>   
>   	total_size = get_totalsize(mc_header);
>   	data_size = get_datasize(mc_header);
> +	total_meta = mc_header->metasize;
>   
>   	if (data_size + MC_HEADER_SIZE > total_size) {
>   		if (print_err)
> @@ -245,7 +248,7 @@ int microcode_intel_sanity_check(void *mc, bool print_err, int hdr_ver)
>   	}
>   
>   	if (!ext_table_size)
> -		return 0;
> +		goto check_meta;
>   

The code flow in this function seems a bit confusing. Can we avoid the 
goto and make this a bit cleaner?

There is already a check for ext_table_size above. Can the extended 
signature checking be merged with that?


>   	/*
>   	 * Check extended signature checksum: 0 => valid.
> @@ -262,6 +265,22 @@ int microcode_intel_sanity_check(void *mc, bool print_err, int hdr_ver)
>   			return -EINVAL;
>   		}
>   	}
> +
> +check_meta:
> +	if (!total_meta)
> +		return 0;
> +
> +	meta_header =  (mc + MC_HEADER_SIZE + data_size) - total_meta;
> +	while (meta_header->meta_type != META_TYPE_END) {
> +		meta_size += meta_header->meta_blk_size;
> +		if (!meta_header->meta_blk_size || meta_size > total_meta) {
> +			if (print_err) {
> +				pr_err("Bad value for metadata size, aborting.\n");
> +				return -EINVAL;
> +			}

This seems to be returning an error only when print_err is enabled. 
Otherwise, it treats as a success.

> +		}
> +		meta_header = (void *)meta_header + meta_header->meta_blk_size;
> +	}
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(microcode_intel_sanity_check);
> @@ -967,3 +986,28 @@ struct microcode_ops * __init init_intel_microcode(void)
>   
>   	return &microcode_intel_ops;
>   }
> +

Sohil
