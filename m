Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B3873AD57
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjFVXrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjFVXrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:47:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181F4E2;
        Thu, 22 Jun 2023 16:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687477634; x=1719013634;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zF6PHL0bDvUKCsKcUSjUWMeOKRQpiUJwTmuCbjwlhQU=;
  b=H/+pmbdTW62MC+tYXCwVb+kbjGYTw4uDC4/DriobwJcAnukjPkmL82Ub
   i+ptqZvPwWAj7gudsGRi6QwSV34AneLfe4Eztv/ZtAnca1ITqNaYWhkxo
   relXvXEHLqLD56synknZWnMNJBszM1KE1P13i0mazF/vVUJezHwMC75Ln
   cOEacPOBE8EhrnYGr8hFeJ0MXblCrLyYf+4LXn3vzO0OMgcQky8CnlG1X
   m8Qi/w1O7YJhvZfpJVJJNIlQPv3KrJc/lCWoR2tf5kLoRbLRcX3iLaWtU
   7Oz6K7QcUcvNSd9hJ8GH8kOweaVZNhyiTD5ch/qFBDDp4gGD3wSwDzyqW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350405575"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="350405575"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="1045439155"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="1045439155"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2023 16:47:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:47:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 16:47:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 16:47:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJIWh3Sm4deAalz4bVRl70J8ARmcJM25HlHOZtiyuBdI9lI2RQMqibfxxOVC/sUV5APASol5/lf33gHfq7adWwF2HqOifgPbmWDnurm4y4V8GCaPLDuM9ix/UActWR3eW2Uu9g2TqfgnSUvZAyV3EUo7HNwSYfXqIJPu05un6UZmeFB3/B10G2FQLDOc7kbu53BhjCxHexrvTqOkZnVONLyGtj1zTkCwJ94jST4uPruUz4Kt6skoHFtW9O/fv60uRpazmBI7SscNsRHZWGLBhHxRhxkXZ+jopKBUG6L0QQLOZ1pQ02nv2pIBLf5CLQCi9MQfLW3zCId5EnF3wrUcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AbrQdnRnncqWrjSKgB3kyL+38TSBuTPjWzUXfmaYMw=;
 b=R/S1XjmEbIyZyvMqbJWwPBV5sc9I7vRxgIwY3U9DfCcM0qUc84JiXHBN55XFVSyJBRdnv9lwPE1RNum/jcnIOZQANsCbKbScfMsaF8sEiWyga4tehAV4w77PpeIkV/zUgkS6Rb29L/ODgKD5xgUY+ZAcoy0dQ3VWsYRQiAXZKGLyc7nUN/LHK29Ai++RCzp8ARsOG/JczNq7CESUoQPRkL6kbUqZ4iOiQnOmOVPU3n5+B3n2DsMRZC3nVuoSmlP73zLxw6NOU9OhS3xKq+UHxeyJlhIk7IJKCs8rseXQaoYspQiv78lZMBkOm1JI3OcBiYPja4msk3nbO7KYnVAu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB6540.namprd11.prod.outlook.com (2603:10b6:208:3a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.40; Thu, 22 Jun
 2023 23:47:10 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 23:47:10 +0000
Message-ID: <6f66e2d6-4d0f-f5d9-3a0c-66f5ba08c39a@intel.com>
Date:   Thu, 22 Jun 2023 16:47:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 11/27] cxl/port: Remove Component Register base address
 from struct cxl_dport
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-12-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-12-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::47) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: ceca053f-ff80-4529-96d3-08db737afea3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMRwKnzOwZuPQldkOMdFc6wOhXOIYL08+Y5U2PNqHsjhL/gI55ILGfozByfbNGzqy8F6OTAguoNCFzChZ3OUU9l9E8Z/OWRxM6yxcluqve1o4tiVjJPPZKB1qOf5UcyLdsCZXStUhCXKWFjfsks1mqCt3w+UOqyu7BHHfcPg0tyWKMY0o1PaoBoEUS584/OtBDbc+TXHTUurG5rV5cYD+xCBuBzLJgDQo2kiDOkgna5QYYEyN6UdfVmdFLEFE8/AsmBCLwexQ6uYR4P7IeNeXzmwd/G5AI7QPPOcJy2MpM/ipnNK+fcC0midZIP1DF6IF5fyaSHYw6gbY+qIbJCr3zjWzX21pyBD1WiGNURszXRIkqFcqNzWU+x/u2Nbvy0CpqZrFt6mg6K9FGZYpHq5hiJAP18rxvbAc41AMZzB74tT2SlhXuVP6CS42drSV4cNEqjdkTgATz9LoSb4E+JzxYGARd1LmunwJInQTekbJodPeLuWgXDcdhT6HcQHb8h8uWYY59RUb0dkvEdqUk4giiMvH/aRPBTlOYNqVVqXz6i7hg0hGrPds0JL2TTnqPJle+/JXl4IH8kaAP/B5NjhrobT74SMHWPX2XmhqZKlVGdgpRT3li4N9x5jy0cZLx8VtbIp2icFk/yyZbtGAe5LGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(53546011)(82960400001)(38100700002)(26005)(6506007)(83380400001)(2616005)(186003)(6512007)(44832011)(8936002)(41300700001)(8676002)(5660300002)(36756003)(6666004)(66946007)(6486002)(478600001)(4326008)(66476007)(66556008)(31696002)(86362001)(316002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YktqZTJRYmsyY3ZPd3oySDdtZVJYLy9KdGx5TUdKWVI5NVZxY211aVNJZGVP?=
 =?utf-8?B?b1pWVVVXck9HVHZMTm9aQWZZN2JscWZ6cE5nbHozalYwdHg4eDZOTWxDODU2?=
 =?utf-8?B?NlE1UG5BSGRRYVgxWURqMEVsM3dETElVN3NkZ0ttejdVcE01b0JnL0RLYy9D?=
 =?utf-8?B?bjJsd0RYSGtmanFFUDUwLzN3cWorOVdNWVUyVjZ1QW45Qys0MlRLMWRnV21S?=
 =?utf-8?B?cUtKdmxzTkZRQW1aZ1BabWROL2czdW93akszNjJZd25laXMyNTJYZW9UdXE0?=
 =?utf-8?B?SG1KQlM2eVJXclZ4akZlcWE4R2lQcjlkSTRlZjEzVGhnTVAybEk4Y3p3TTBE?=
 =?utf-8?B?WTRpWnNlS1IzUmpIdkdtWEhvdzFDWXI2bVM3Ym5Jb1dVN3VqVFFWYnU4VGZs?=
 =?utf-8?B?SnprenF4ajdJQVFtQmdZd2RpbmM5SVNvcENwRWhBTkd1dWU3WFBuQ0I4VHhY?=
 =?utf-8?B?RUxSRGFuRHRFSFgweTdPNlZBb1hpa1ZKRzhSTXlycnJ1c1FQc2wzNC9RY0tC?=
 =?utf-8?B?SlJ0MkxScXo1QkNFVTNXNCtVWEN0Z0tXaGlSTnB1eTZzbXJoSVphVTNqb1lq?=
 =?utf-8?B?M1ZBUVB6MENMd0NLRHZ1VHBXMWIrQVBSeXMxbEpQaE5LQnNrbWJhcDlFN0dU?=
 =?utf-8?B?Qm9hMkVhNW5YcWdyQkUrTVhRNlRieTd3K3Nna2ZzSTlrUzBkRmV6a2NHNy95?=
 =?utf-8?B?YmZ0QXZrQnR6ZStrelJSOWhJc29ybnJuOGlsaThKTjJhVmt4Z1NBOHlQaEYx?=
 =?utf-8?B?bUJma2V2OHhqL3o5eFQwUmdaQmVSemVBM1lpWWExd2Qrams4ODd6azd1MWZ6?=
 =?utf-8?B?U0NuaThUV1ZQaUpVaC9GT1RrSktHQmdRcVZOaFQvSithMXZiN0loZ01SOGpO?=
 =?utf-8?B?V0FCUmlnWnBkV1RleUpRbzRodGdkNSs4My9tM09CbVo1SzVMVFRzajRsWlFo?=
 =?utf-8?B?UHRHbHNPNDh4My9IN21zdW1lQm1WeUE3VVlWMjk3ekVTQ1B4bldKa0htYW0r?=
 =?utf-8?B?RERVV3NPdGFESmIwZVlFU0hzRHRjZDVKVkh3NUVYZnNDZHYzcy9IcjExMHFv?=
 =?utf-8?B?V3pka0JuYUVIL0NwQy9QejcvQUEvRFF3cDdYWDhHb0s2MGRyM3hxRnV1TDFK?=
 =?utf-8?B?Rmk5VEdPNnFvajVjWEhVRy9tUWNGMzNpc2dJWXpsdUNpS0lBT1FROHBNOU52?=
 =?utf-8?B?MlJ1aFJOOVg2bnFaNDE1RlQ4Z2I1RXhjRkZvUVRGaTZoaSs2amJkQ1BFcjNh?=
 =?utf-8?B?UXlpKzNwUTBPaHozR2QxM0g4OGdDcmZrSFE3emJibzhkckNzRlQ0SVlWem1H?=
 =?utf-8?B?M2lRY3hXMnJiT2ZhR3c5OWM2UE1TV1YrbDBwOU9KTk8xVGxqcjFHeHorWXhk?=
 =?utf-8?B?VzlqYVRDUlFRK21DdEFzaytqMkVJQTM3MW51VFdGeDRYMDRoTWZLSzNFQ2Uw?=
 =?utf-8?B?M3dxZ1ZXclNSTW5zRXRTSGttcnV3Zmg4d3NqZ3VhTk9kSnYrR3kwc3puMnA1?=
 =?utf-8?B?ZVEzS0JqdEZEUzRLRTN2MFVuTy83NVczSW1naFVrTkFXRHNHbC9uQmxuRjVr?=
 =?utf-8?B?b2lzM2pqZHVmTTg4L2YzNmIyV292YVdJR0JXdTFzbVcwWjUyVHpWQ0FBWXFn?=
 =?utf-8?B?cXN4Qm9oRG95RDc3UjFHZXkxWERqNDZsSTZpZCtCNmxBRjEwbGtqazNUWXcx?=
 =?utf-8?B?L3BBdC9QTnRtNTFlYThNcDJnSTBhU2dvNnNTKzZxQk5yenBiRUsvU2NRUzNl?=
 =?utf-8?B?Sm5XM3VpeEFmSXlRdC9jUUljRHdYOHlCbDRNNlpwcTB3UWtHemw5SHBhSzNN?=
 =?utf-8?B?QmllWGgzSElKVklVdjIyOE1qWTQrT1c0QUlrR1JlMkpIdUpDRldaWmpwVXFr?=
 =?utf-8?B?am9sVlpjS28vOThCczV1S3dXU3p0bWkwOTdIeGdLVTQxUklNRnRpbVFuM1pG?=
 =?utf-8?B?U3NmNk94Qmd6QVYxa0RjWmYreDRkellhQVM4WGlDelVsYUU3WGhMU3kyWG84?=
 =?utf-8?B?MUMrTitRVzcxM25xUGo5TkFZUnVoWWdBbEpRaDlaZ1N3N1FaZUl4QjIyVzBl?=
 =?utf-8?B?UnFScUVWY1N2bGdWSHhOQW1ZVURTcDB1dHJ1WWFETWgvUDB3Q2FvY2tqQjNW?=
 =?utf-8?B?NS9GRjNhREpxcnZqb3JxZVpyRmkxWEcwQzRHZDJ0L0lwYm5jR0ltL01kZmxU?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ceca053f-ff80-4529-96d3-08db737afea3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 23:47:10.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmXSv69LzRBaXeaa85eXfDulpIrTaeHoiIIMspro/8I2R66YS59RPxAuk9RnFo+yitHe9KrXZV3SQL/+91J7FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6540
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
> From: Robert Richter <rrichter@amd.com>
> 
> The Component Register base address @component_reg_phys is no longer
> used after the rework of the Component Register setup which now uses
> struct member @comp_map instead. Remove the base address.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/port.c | 1 -
>   drivers/cxl/cxl.h       | 2 --
>   2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index cdfe0ea7a2e9..e0d2e7596440 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -960,7 +960,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   
>   	dport->dport_dev = dport_dev;
>   	dport->port_id = port_id;
> -	dport->component_reg_phys = component_reg_phys;
>   	dport->port = port;
>   
>   	cond_cxl_root_lock(port);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ae265357170e..7fbc52b81554 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -594,7 +594,6 @@ struct cxl_rcrb_info {
>    * struct cxl_dport - CXL downstream port
>    * @dport_dev: PCI bridge or firmware device representing the downstream link
>    * @port_id: unique hardware identifier for dport in decoder target list
> - * @component_reg_phys: downstream port component registers
>    * @rcrb: Data about the Root Complex Register Block layout
>    * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>    * @port: reference to cxl_port that contains this downstream port
> @@ -602,7 +601,6 @@ struct cxl_rcrb_info {
>   struct cxl_dport {
>   	struct device *dport_dev;
>   	int port_id;
> -	resource_size_t component_reg_phys;
>   	struct cxl_rcrb_info rcrb;
>   	bool rch;
>   	struct cxl_port *port;
