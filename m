Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987D273AD00
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjFVXPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjFVXPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:15:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBFE268C;
        Thu, 22 Jun 2023 16:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687475692; x=1719011692;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YyNAaz84Q84r0njmZbVJdKgQtkfToOMBD8VzG3t6Ofc=;
  b=V5T+xw99v9Jy66t+SroS0/tgt+ePk06/X1fqBPGhPrYU8CGDeIl1iwiz
   lryIOYIPrVXH+7L+XJKjwqipTHLj/0wlZJ9YEtZNkNgXRGlYpcQ1pIrCq
   Gde3GmZC9PgnsjvMJ1SwDrjxmz9wL7/9iHSA2kFK94X+9Q30nNNJSlfex
   MsCS7qji9AreOeHSsFyHOprF+95umupKpj8NvX1QBKMbTbS12K37NgD+U
   o2YPm0eQlfxttLMkuaCWxCxXUzu+gqYEG6asx63kVLXlcmsSZAxV3WPvU
   PZLdjoCZZg8RZBx/iljqdvl3HapBnGiVqRZpgF4FiGxoUuvjetISOJUOF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350400020"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="350400020"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="665253792"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="665253792"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2023 16:14:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:14:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 16:14:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 16:14:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2p15Lnn4Id8IareZIVGxhlZxLaVehBJz74T580HGjX8yaiG5kQdA5nKJ9I07a8lSQRBLqDJwm9yPdfKXQ6qPWh9jeJxqHoSp6oR6spzXx6JgM8IZQ1ovjm+mrAv0nUqkXjGVoySb9fXkJdVXIAu7dFu+as0dror3kZcSQQC2I9spmWpd+CJCaMcSZ3wIGOn2g7tqXs4TIT70svop3RUmXPhOsttb5p9kwpvSHaWg7YPnIpd+THo/NDZo5Rev6pB/LgJikg7E1TGEMFtgPrTcrtq/UYd5Xu0jNzlnI1l1tOfDTrLBPKU6ji89swFNvnqFEWpm5xA4N2nDK0mO8aU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTh8M/jmQKs2B4to++gQlLgH9ULp7zNUYybzfzESkMk=;
 b=UiRwwTahgHl7pkVHfknSwoIH+X6vzWSwVruDpO6HLTOJGpd2iBmM2fHVACQL2hxQW1/TE2RM50tuvc7MBZ7HDnlXaZ22xqlpJsvLqSPt94xjMZqLiAkWT/gCxguvsTqkR/YX4QOyfoC7VavgDE9BS3fvqiqes5dmHu3RlzR/l1FOFgG0Merzz72SYQyufTXfK9TU++1QLVMaoEmU0hLbRYfOCB+U4qps1w/J4K65BcBRkWa6gRnC/YDB7wHI2cVLueMV/51VAaSmIN51Ra+Nm0LWWrulsW9yM6bRMwSxoVIJXUrwHZxWfpANy29wwZx6UC6JRHLRrgoZdVugUFNF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB8259.namprd11.prod.outlook.com (2603:10b6:510:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 23:14:49 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 23:14:47 +0000
Message-ID: <2d063e49-8d58-08ff-c2d3-1f27a9576a68@intel.com>
Date:   Thu, 22 Jun 2023 16:14:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v6 08/27] cxl/pci: Refactor component register discovery
 for reuse
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-9-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622035126.4130151-9-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:a03:338::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1f892f-0d52-4e8a-5cf4-08db7376789e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qwVmjYzjKj8+tm9o/ou5F+3by6Q1ft0irzO3vDoIYe32kHLjsQHsS1WaDx4Asp4NWpCpJIDBmlxXolu1LOdnfzGuwdG8WX7yK8L59jtV2BvalK1IgFEYeblN8kC4AJlkXvdTcRMdEZh+MfgxYaT7oPmcz1CkS+iySHaOsK1Av9Spt8tQFDccKv5zi9glJCmIHaPg9uVkH1krhpaOtoJQxq8Y/X7Ge2egpcHN+2I/sWxJGqbaqWUWAeh2pQHe3dE1WFxpfLDIy483k//6h+jeS0WlhURGxyDs1ti1UOx1OAgzV5g44JSwHbI8yK/RMMOX5mFGFi1Ms18bUBXPnhuvAbhsm0KerIq9IlVH7WwT8DG4Pb8nCXhZw0xL6byZkwbGQSkMIrKL1u5/6TV+cBL8PMuvMDKViaB3aIxrd6nbL4QKY/RX1i9WK4PfvjEDD1ftRvnqwXfuXmqjJ0te3KpLEDeJadz55CdiEoIP4JG0WiANRnwCj1YZFhU9TnFrbXuZHL5jriq0fNwa/bx4jp8tN4YuLcfOU++NX/dNtnYR7PHbTNNVCo58NUYOkIyZ9OnNQGiEr1A0hEoW4jvH89LhPClDvHsyUnCpVu+RXhJq/4WsU6++4aQTDKNPjSIELgkBlyc+h7JJi1TnzxApI2/2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(82960400001)(38100700002)(2906002)(44832011)(83380400001)(31696002)(36756003)(86362001)(31686004)(53546011)(6506007)(2616005)(186003)(6666004)(478600001)(66556008)(6512007)(26005)(6486002)(66476007)(66946007)(316002)(8936002)(8676002)(5660300002)(41300700001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk12ZEMzbE0xWk5NN3NjWWJXdU1Dc1h2NUpOWmluTmRqLyswazdtNEM5S3Yw?=
 =?utf-8?B?ZmlIRUVPdUVGaWUyVFVTN054dmtVK1FhMUt1aFRzQXVsRnVlQ3BsTDB6NHU5?=
 =?utf-8?B?V3Y4Q1VhQkJJcjEzZGxLSEJiVXJjKzRDUnlqM0JUNm41TnQvUXd3anIyOTZH?=
 =?utf-8?B?TTZROGRkQ0d2VjdlYmlhWmt1bVpBQWpSYmNiUUpjOThMbzdVekNHbEdTeG0x?=
 =?utf-8?B?aEcyeEkvdW05THFUdTdDVi9ETTB4RVZURGQ2enNWaDhablY0MksxNUJUY21R?=
 =?utf-8?B?Vko1ZXNwVjk5N1kyUFZtT2dyRzNTcEg2d052SUc2VmRRbGJDQW93Y29VbHN5?=
 =?utf-8?B?VTVrM3hlWHp6ajRMVlBpTWhXNjl4eElJcEFHYWZlYXBYOWdDcUw4RytTUWtl?=
 =?utf-8?B?TTJkQkFJYWtRdjRNSUk2UVM1N0ROdHdhalpKUGk3Vmg3WXlUZUY0ejlPbXM0?=
 =?utf-8?B?K2FmajBZVThiMGpBOExmU2x0eFIwakRDdEpnaW5Menp1TkpxTXYxM2ZLOVl6?=
 =?utf-8?B?ZlZGb1A0NXFBV2lCT3YxY3F3VGduWDRnMkZBU0VhZ0xJMW5FZjJKUnlkekcr?=
 =?utf-8?B?MnE5aklzL1NuOFQydEtIanZwMkY0bEtDbVNKTEhrajkwRi9EYjZuekswTmJ4?=
 =?utf-8?B?akpuRkxkbDlac3VNcVFnZnN1UjU2d2VGL002Wm1obkRIS1VwU2ZrbGRFOEk2?=
 =?utf-8?B?KzB2MDBHM1hUeHZnU2s2eHFPVlZ3RFdWdzkzNHkwVDN6L256TjJLZ0U5em0r?=
 =?utf-8?B?cTh1TlpLMkZ2dlB2QklJWXZ2dHhoekY1bDlZRDQvQktxZU1zZ0Vxak5qVXlN?=
 =?utf-8?B?MWFGbDhlMFhhUk9JcEtqeVh3ckw1b3Jnelp0d2dBWnhqVVJSU0pybVRLZ0Nt?=
 =?utf-8?B?R3lTQmJTejlxK2xsWjhVLzk3RGxacEdMbHk5NDgrRGNtS0lFb2FQRVU2QnRS?=
 =?utf-8?B?OUtrc2lnY2M1UXZzNG1ad3VqS2xyNmN2NkpvdW8yZnlvRWlXcldmVGQ1bDlq?=
 =?utf-8?B?dUliU2xtbkg3MjVMYnBKSVc1Y3o2S1luSFovdHVrRk1scWJTc1ROK2RjRk5x?=
 =?utf-8?B?LzZDRXFYRFRyQm1ueE9zSEZuaTZPSjF3LzFlN2FQYk9pcVZKOWlSVXNwN3hu?=
 =?utf-8?B?UVJjRWNFWjVrWlZmdDlub2tZOFBxWnU2b1NPM0Y1blRVbWg3V3AvczluR2U4?=
 =?utf-8?B?Q3R4K1J1QVQ2K3JWdmUwZjdqNWZSeUdjUStBMU1wWVFZbG8xblpoZXlUWmc3?=
 =?utf-8?B?R1h6cndETlFyOWYrbVNJOXVJTFBLVVFEZjFSMXdoRDk0Q0Y3QlU3OFpnSHgz?=
 =?utf-8?B?WnJFRWpOQUVGbEF6ZG5aTGFqOXR6R2lXRldVUjM4Qi9xY0M0S0JYTG9TNVlV?=
 =?utf-8?B?eTdCUTg4QWtDbldpeTdHUHhNWFAwWjU3UThRTVI3NDVzb3doUzd2QTg5dWZS?=
 =?utf-8?B?clJERURlSytWSzl5aUhLenhMNXpnNmljLzZrUFZhMDhkTFBkaGdLNCs2YzE5?=
 =?utf-8?B?RWxLOENCNmZNcmhqL3ZWcThkT1lxN2ZUMjE1YnJHRGdXdDhxYVliM09vM3l6?=
 =?utf-8?B?cGxHWmh0VzdrU3AxSHYwM0R0c2drRVM2aWpjRTNHSlhMVVkrazVDM2Z6a2tC?=
 =?utf-8?B?M1F6L292emExSlVHMFBFRTVjWERlVWRhcDhMdVZFRG42NmJqSEcyL2hFSThz?=
 =?utf-8?B?Y3ZXZCsyNDNXSUhoaUVmNzNLWnVkd2U0dnoxY3Jha0sxQXhvM2U0UjZUTmxE?=
 =?utf-8?B?YSt3c3dhRlNDSGVOWTFZSlZxRzB4RWdPRFdsdFgvMDBGYWdXbFFDSFdNRkxr?=
 =?utf-8?B?aGRKWkh3OGFaYlhnSkZKZ21DU2gxK2J4djVEWjg4Z2ttWjZScTZnT1laQ2tH?=
 =?utf-8?B?b215cS9oMkRIZGtyRjk2c2plOElWRUVnVXJIL3U2WEpCb2hleGF4cmdIMEtr?=
 =?utf-8?B?NERyQW5tVVVGbW9jYmc2OXVPNXFMMnhqbkFxdFVMaXVTQjhxcTJZM29HU2h1?=
 =?utf-8?B?TlN3Vnk3VXFJdmRETW1IKzU4T3gwMGxJSGhtWXJzSDlGVUdIb1Q3cjZMeXQx?=
 =?utf-8?B?WDVuK2hhY2FHOW9EdHprMDhPSUh0SG1ad3BjRERlVkhNWUQyR0FpOUxaSWhG?=
 =?utf-8?Q?YuFvVcwKwno4a90S+Byw1ggos?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1f892f-0d52-4e8a-5cf4-08db7376789e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 23:14:47.1511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jd/UedJkHDqcNFGzH6oz9dz+i4vVRKdFVgsrkUqFMeZd3gddAjjWmvHLJZuOqtvDG+XFMD5QctoDYrEPVagCKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8259
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
> The endpoint implements component register setup code. Refactor it for
> reuse with RCRB, downstream port, and upstream port setup.
> 
> Move PCI specifics from cxl_setup_regs() into cxl_pci_setup_regs().
> 
> Move cxl_setup_regs() into cxl/core/regs.c and export it. This also
> includes supporting static functions cxl_map_registerblock(),
> cxl_unmap_register_block() and cxl_probe_regs().
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/cxl/core/regs.c | 77 +++++++++++++++++++++++++++++++++++++++
>   drivers/cxl/cxl.h       |  1 +
>   drivers/cxl/pci.c       | 79 +++--------------------------------------
>   3 files changed, 83 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 713e4a9ca35a..e035ad8827a4 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -338,6 +338,83 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
>   
> +static int cxl_map_regblock(struct cxl_register_map *map)
> +{
> +	struct device *dev = map->dev;
> +
> +	map->base = ioremap(map->resource, map->max_size);
> +	if (!map->base) {
> +		dev_err(dev, "failed to map registers\n");
> +		return -ENOMEM;
> +	}
> +
> +	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
> +	return 0;
> +}
> +
> +static void cxl_unmap_regblock(struct cxl_register_map *map)
> +{
> +	iounmap(map->base);
> +	map->base = NULL;
> +}
> +
> +static int cxl_probe_regs(struct cxl_register_map *map)
> +{
> +	struct cxl_component_reg_map *comp_map;
> +	struct cxl_device_reg_map *dev_map;
> +	struct device *dev = map->dev;
> +	void __iomem *base = map->base;
> +
> +	switch (map->reg_type) {
> +	case CXL_REGLOC_RBI_COMPONENT:
> +		comp_map = &map->component_map;
> +		cxl_probe_component_regs(dev, base, comp_map);
> +		if (!comp_map->hdm_decoder.valid) {
> +			dev_err(dev, "HDM decoder registers not found\n");
> +			return -ENXIO;
> +		}
> +
> +		if (!comp_map->ras.valid)
> +			dev_dbg(dev, "RAS registers not found\n");
> +
> +		dev_dbg(dev, "Set up component registers\n");
> +		break;
> +	case CXL_REGLOC_RBI_MEMDEV:
> +		dev_map = &map->device_map;
> +		cxl_probe_device_regs(dev, base, dev_map);
> +		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> +		    !dev_map->memdev.valid) {
> +			dev_err(dev, "registers not found: %s%s%s\n",
> +				!dev_map->status.valid ? "status " : "",
> +				!dev_map->mbox.valid ? "mbox " : "",
> +				!dev_map->memdev.valid ? "memdev " : "");
> +			return -ENXIO;
> +		}
> +
> +		dev_dbg(dev, "Probing device registers...\n");
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +int cxl_setup_regs(struct cxl_register_map *map)
> +{
> +	int rc;
> +
> +	rc = cxl_map_regblock(map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_probe_regs(map);
> +	cxl_unmap_regblock(map);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, CXL);
> +
>   resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
>   				    enum cxl_rcrb which)
>   {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index bd68d5fabf21..ae265357170e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -264,6 +264,7 @@ int cxl_map_device_regs(struct cxl_register_map *map,
>   enum cxl_regloc_type;
>   int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>   		      struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map);
>   struct cxl_dport;
>   resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>   					   struct cxl_dport *dport);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0a89b96e6a8d..ac17bc0430dc 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -274,70 +274,8 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   	return 0;
>   }
>   
> -static int cxl_map_regblock(struct cxl_register_map *map)
> -{
> -	struct device *dev = map->dev;
> -
> -	map->base = ioremap(map->resource, map->max_size);
> -	if (!map->base) {
> -		dev_err(dev, "failed to map registers\n");
> -		return -ENOMEM;
> -	}
> -
> -	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
> -	return 0;
> -}
> -
> -static void cxl_unmap_regblock(struct cxl_register_map *map)
> -{
> -	iounmap(map->base);
> -	map->base = NULL;
> -}
> -
> -static int cxl_probe_regs(struct cxl_register_map *map)
> -{
> -	struct cxl_component_reg_map *comp_map;
> -	struct cxl_device_reg_map *dev_map;
> -	struct device *dev = map->dev;
> -	void __iomem *base = map->base;
> -
> -	switch (map->reg_type) {
> -	case CXL_REGLOC_RBI_COMPONENT:
> -		comp_map = &map->component_map;
> -		cxl_probe_component_regs(dev, base, comp_map);
> -		if (!comp_map->hdm_decoder.valid) {
> -			dev_err(dev, "HDM decoder registers not found\n");
> -			return -ENXIO;
> -		}
> -
> -		if (!comp_map->ras.valid)
> -			dev_dbg(dev, "RAS registers not found\n");
> -
> -		dev_dbg(dev, "Set up component registers\n");
> -		break;
> -	case CXL_REGLOC_RBI_MEMDEV:
> -		dev_map = &map->device_map;
> -		cxl_probe_device_regs(dev, base, dev_map);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> -		    !dev_map->memdev.valid) {
> -			dev_err(dev, "registers not found: %s%s%s\n",
> -				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> -				!dev_map->memdev.valid ? "memdev " : "");
> -			return -ENXIO;
> -		}
> -
> -		dev_dbg(dev, "Probing device registers...\n");
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	return 0;
> -}
> -
> -static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -			  struct cxl_register_map *map)
> +static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +			      struct cxl_register_map *map)
>   {
>   	int rc;
>   
> @@ -345,14 +283,7 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_map_regblock(map);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_probe_regs(map);
> -	cxl_unmap_regblock(map);
> -
> -	return rc;
> +	return cxl_setup_regs(map);
>   }
>   
>   /*
> @@ -683,7 +614,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		dev_warn(&pdev->dev,
>   			 "Device DVSEC not present, skip CXL.mem init\n");
>   
> -	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>   	if (rc)
>   		return rc;
>   
> @@ -696,7 +627,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	 * still be useful for management functions so don't return an error.
>   	 */
>   	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
> -	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>   	if (rc)
>   		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>   
