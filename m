Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6A748ACC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjGERnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjGERnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:43:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9CC18E;
        Wed,  5 Jul 2023 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688578988; x=1720114988;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d6YJUXKJZs3qesFcmd9jfJFhkvIlRkAK7XvgoMWq/m0=;
  b=bvUADTvo4RNcTRJUZLVbJ5n/2jaJbgYvy5wesPNErkAkcySFxBslEjHh
   xvp49TTmg2HZrmt20htAWvwlowLZ0CIi3OgM1vINo2FCxPGSuxP+iE4kZ
   n8y1+N8ZP36E63EJxZlQwZQ+2eoCz9PFvKkmlrUhAP3nNwHwkJ0cFpQd8
   KGVkKzZPhE8TwdnGCa/KD2WXyj+pMX/Q1o+pJIGvPeq8HTLf4D7vDPc26
   ehiWQOdPsUcyEsFLgYI15OkVFYgIwsaBxUGHIn9ct45MzYbkUPO8B5yku
   QN9v7W08QOTXbxIi9bpAmtdjT6QguLXgjneQ7pNpU55V24eJFrIblVDnU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="427087120"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="427087120"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 10:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="809330030"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="809330030"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jul 2023 10:43:07 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 10:43:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 10:43:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 10:43:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/0okROk3P6n6g/ryBBbXA5FfcqM6FjI2ue4RzomD07namU+v9cJVzyJpo/2W3V1hmBab8KQmh017unizaD8whHZMMZacAEvHl4t7zFn3mO3y3LOL9S1mPCcLXzEon4JS9x56BQEaQI0ooX0laiG1F5UBo7CPwBz3bezvWe/KtUGJw1jVEJM205i78aKVwy+ijlO2clYpBfIZxyGT2FM39qb13KN74rAp2Pg9fcGv+EPEfhKHM7Wenzd6cjbiB7e/Lmkw9MHiV4uw5RTobh1INKWdI1/V5HvK2g4sgCEjv3sVjtqOQRMBIc//chuGCfjN/00gp1nOqoF3nfL7E3w5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLbcXdpye1vNlJjXEVXR9Vsba/hA/bbd4ZzJeKvDmTE=;
 b=NhvVlCtJ4fHQJE014swcBqOt9h6pDnvYMhC+2k8pLbbhvYmrfdkFOKZWiD8qctxy80QpW0P6nQsMNXc30XHziMljTGnT+rXS9CEvOXxnIpE4P7C5NrHo74idfDioFG8fc0nLzieXyr43nUSqSaCSw9l5RC6PG3ogn535ePQiboieOF5+A75xAk53wPK7kq/TgVyVcPCVi39dqrl2TElV7gorCmpQ+MDdgqSlXzxoM5U6rqPjTI8/rKCmKN//l5d+1Oz2z0bbm5xZNYp9iYFhd855KVc1tQw6dLtB4uvhH/Rkt/YZWOdv7I/w/KhUY+yzxhv00LX7es7oXI/8SQZLQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY8PR11MB7732.namprd11.prod.outlook.com (2603:10b6:930:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 17:43:04 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 17:43:04 +0000
Message-ID: <a19dde63-2f84-4256-fd3d-101b5c471fda@intel.com>
Date:   Wed, 5 Jul 2023 10:43:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH] cxl/mem: Fix a double shift bug
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Vishal Verma <vishal.l.verma@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <a11b0c78-4717-4f4e-90be-f47f300d607c@moroto.mountain>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <a11b0c78-4717-4f4e-90be-f47f300d607c@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY8PR11MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c00b34-7f09-49bb-10db-08db7d7f489e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /W4UFh+Fu7/1d4dUVmXi0wTBN9BIAW+sWRxk2TtCbp3s0QjJGunvzCIxLtZhQNAWkKKnhTXKAL5kh92NbJyHyqkiDMUJdHna32AKjvQIqeIdp8QMavqc8pk1ZZO1Jwzsqxy2z/tTqJkXoDlGDe/Ko0ihFUTJ/x1hYSqDetleidWRzEHmNOpTDJ9pbOVczuuT9pHtoym6RAj+5N26jA7RBpeZAgYmy/KHvuCgi49Up3SPhnyBrg0XEeFaMqgvbvYnQmCV6l1oXQC+0OD5W4utPV/2bTBqzYD1eJtrpNAsIY+IWRqg91Z0Fj43QgkE4R33I48g4XmXF/BQ/fhc5XSJXnrW5Mbnj3oNRi3bcp0dcvBjIfeW7GQ5SzK9hbKGe+OsCjktoI/4UGcrVQKrXNfuRJ6CpdESzhv7drl9bzU4ycuvg8SyoAxDAWXczZ+T9xkct5wD7jf2GvBDR6CC2OEUGBPmaerj18E3Z955KU92f68ArmJQhoFdOtipmq90W2MPY81pgnD7mjYn76PVRn6M269oFwsBzQ3N7UI0A5LI+TukfV4Q5nl0C75txhJCj0TkV8KsfL2E/RmbWhFb8nwfxLs7pEGc9mvYLqSPnKP6zVIapGlJFgdldi9sPSuQb81Xo2gYN2c0xw+yE3YGpZPBUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(8676002)(8936002)(2906002)(2616005)(5660300002)(6506007)(53546011)(26005)(44832011)(186003)(31686004)(41300700001)(6666004)(6486002)(82960400001)(66946007)(4326008)(6636002)(66556008)(66476007)(36756003)(316002)(83380400001)(54906003)(110136005)(478600001)(6512007)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVBpS2prM1hoSjlySytITVViQndwMThnd01hR0p2eFZ2MXlVUUNWRUdkOVhD?=
 =?utf-8?B?NmVCKzRzUjNIQmxhTkNnUS82dnhsOVhySHpWcTdEOU9rT1hDZWljSldnVmNq?=
 =?utf-8?B?YUY0TldsaXNpclh2Q1JyTUUzdnZyWG8wV1h5eXkvUkFwQXNqbHdoNGpUTWJ4?=
 =?utf-8?B?UEdXS1JHZE1kZW5qZ2JxeFdKWkpQcnhobTBKTHZMMGN4UWExaFV5ZXlwSTd3?=
 =?utf-8?B?Qjd0enZTYmhBUkZ5QlhnTStxdXhPUjZveWNRQXg5RTBEcGk3cS80S2VyKy9z?=
 =?utf-8?B?dXd0Y2xaSmhqYlBuUW5TVHFhWlYrWXlkbnBZc1ZCYWZVVjUrdFlUdmV2MGd5?=
 =?utf-8?B?K093TXc0dnZ2Szk3R1BnTzhYSWdQc3JXZGprc3J0aXhMLzdheUZwOGQxNEpu?=
 =?utf-8?B?VjNDRm5pZEdqdGZ5ZEpkVGszNnY4enFYUHBvcEZyQ0Jac05MSjg2b0tIaFFV?=
 =?utf-8?B?b3JlMG5LaTdpaVNaWnhpaE1YRk5uTU1FM2hIUTUxLzVldEtFcDY0cFYvNjJ3?=
 =?utf-8?B?ODBGdVpyTGkzQmdHK0ZEVkQ2WGM0WGU2RjB5bk1hTDZZL3lCaGx1UnlabEZW?=
 =?utf-8?B?dktaQWJkZ29aTGVNU1ZmYnJkSzNTRWREZ2dwOGxKdkJzb3BLVkJMNmY3bGFW?=
 =?utf-8?B?ZytWQ1JmUWkvWTlycmRjUzNzRm1pYVpxQmNwRHRka3NYSUFNVjZaejk5MTd2?=
 =?utf-8?B?TW96R2owdEovMVp6TnZsODFLUmJjRWEvamkrT2NlRFR0OG94WnhvZE5MTlox?=
 =?utf-8?B?citzRVNtY1YvQXdjQzNRbUVaSzhNZnQzSlRlZDZRR0FGTmxUNDZuNmx1a3l2?=
 =?utf-8?B?MFBvSHZUQW9lOWUrbVJycDREak9xQzBHWnZIV2RUZGkyV0tCSHVFUWVXU3lP?=
 =?utf-8?B?OURSWHAvM0FFc2hPb25NdVhMSUpaQ0tTbGI1aFd6WjRzVno4R3Uyc1pqKzdr?=
 =?utf-8?B?RGhSVysrcFlEZi9WeFdlbmlwcWc4dVVDWkdRZjNCMVJjWVZoSXNDYUMzWExi?=
 =?utf-8?B?bDZodTZtNUx4YjhJZFkvMktieUtTOC9iWHc1bWFacFFEcEZ3WGV5MDhBSkx1?=
 =?utf-8?B?Zyt4alZ0bTljTWsrWG50V1BLcWM0STdaSmtjcTh5NUYzcUJVN29zdWZuZDBK?=
 =?utf-8?B?S0U1YWwzc2c2K2U1Z0JuWGppb2ZrYmJSMVA2RHNDMy9KZVl2NVhpd0tuQnBn?=
 =?utf-8?B?SkR3Wm1MVGZvZDEvOGFPbTUzZ0pIdzZzRGZXNFcrRjhtQnRENzNuV1cwOWxF?=
 =?utf-8?B?VGJUMHdOekVIVTNYb1R3S05FQVdObll4d1RUdDNydWhVcVpJL2lsNmg0R29y?=
 =?utf-8?B?NUJ0ZlByOEUvZjV2V1h4WDJGWmNJMlRhUmhLNGhoS1RueGJmRVFvTUhxWDJO?=
 =?utf-8?B?NzNabkZhOXFEcFI3SkNXUGNac1YvUjFIODR0NGJRVUJEdnhRczZvNmpkbkc1?=
 =?utf-8?B?U1ZlVVBmblF0cUlMTzVyTms4MHQ1YWJGWWtreWhUaDFlRWx1b1JrOVFCOWl2?=
 =?utf-8?B?QWx3NENTOUhha0JoamlZVThQeVVzY3EwTnh0VVo2Y2tXRk1YV3N0RnRFRXJh?=
 =?utf-8?B?L0xxbjhqZUg2MXpGc2FpVHM0Ry9zaHMxOWxQL21zMm5pdThHWDA2QkFFZnZM?=
 =?utf-8?B?ME5pRTdKNCtTOW56aStIZmxzN1dXYjUwc3k5MXR5K25jQkNEVmJhb245cDlw?=
 =?utf-8?B?TW4vSlZjaGdlZTI5RUw2VmdyV05mVm95N3ovWG82RFI4SGp2SWpCdkRhWXFU?=
 =?utf-8?B?Y25MZjdLdVUrdWt5Y3JHYTByY25aUGFYL29tbElPWnZnUHNrTm1wOW5zaEV2?=
 =?utf-8?B?QWRTdVU1NTFhZkxlRENLWFNsT3hLL3AzU1FCWnZLTDI0VjMrNFBRdWFVdkZU?=
 =?utf-8?B?bzcxdnZSZnRrZzU2SVpqYmIwSm9Zd0xSdnJBU1V4V1FZdSs5SG5OYzlTOTRM?=
 =?utf-8?B?Y1BjNlplT1VTbENOY21Bc1dQcjgrclpYU0FSNDVPTDhEdGM5RmVxWndSMHZn?=
 =?utf-8?B?L1J3V29ZRk5qQVU1Q3VTWEtub2VEdkhvMTNiRncrUmZFaGhyVndmcUd0dlpG?=
 =?utf-8?B?dzgwWTE5L3JZV04xSUZIQWVKWi91OEFuTnErTSs3ZEg4N21mcUJ1YnpMOW9C?=
 =?utf-8?Q?b2oxJYZZaaAW9G6z26vDn78Fq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c00b34-7f09-49bb-10db-08db7d7f489e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 17:43:03.8869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9d0InzwS+LtYGCmG8G6Flj0BzugGWNqkU128r7MSFAcUAL0nNrMVQpkUAzednbFGRQmAa87iVDvBRMlThRMpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7732
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



On 7/3/23 07:17, Dan Carpenter wrote:
> The CXL_FW_CANCEL macro is used with set/test_bit() so it should be a
> bit number and not the shifted value.  The original code is the
> equivalent of using BIT(BIT(0)) so it's 0x2 instead of 0x1.  This has
> no effect on runtime because it's done consistently and nothing else
> was using the 0x2 bit.
> 
> Fixes: 9521875bbe00 ("cxl: add a firmware update mechanism using the sysfs firmware loader")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/cxlmem.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 79e99c873ca2..499113328586 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -323,7 +323,7 @@ struct cxl_mbox_activate_fw {
>   
>   /* FW state bits */
>   #define CXL_FW_STATE_BITS		32
> -#define CXL_FW_CANCEL		BIT(0)
> +#define CXL_FW_CANCEL			0
>   
>   /**
>    * struct cxl_fw_state - Firmware upload / activation state
