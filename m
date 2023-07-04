Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6377466A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGDAjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGDAjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:39:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA84130;
        Mon,  3 Jul 2023 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688431187; x=1719967187;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PsNvYoYNFjOZCoZ6LTsr4kB704Y3cmyhV1xHsRLQbbw=;
  b=fKx0QPdg56yAqjeC08LZLib1Lj2hm1C20sLNWSEgUQC+1OCKRMtQvIEq
   20nyc30sc/Cz/2eHag+3/WJT9j9SWKF+btZYKfwUDR7ihZMI2VOSzolPG
   u+UBmHRnBjlR1Zeh/kyCBSKUwu9n/ZD+OJ5iPu4L+ML7Oy31qVCUsDvbK
   h1g4aRFN4DR2YxO8/VxaN7RmHekAGqgJF8ceXqGIhBgFtBkELaiR+dZml
   PtcTqXd60HF4fygzsuE/FoKssDHNM70Jlu1kwqHN9lYpTVKTxmaVpW+TP
   R4gY4lvVY5fLTDTWyzvna3Z+EgHS9ZBy08AdWUt/CvLXwW6AY5WhQfYpX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="429034190"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="429034190"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 17:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="892684597"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="892684597"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 03 Jul 2023 17:39:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 17:39:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 17:39:46 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 17:39:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGF/ysL8+X4U3VyRIzfvfCqKk8D0AkHUlHPLcVhc8eg3wv6tifNE6pZ3xKder9CE33eWhu2396d3hHZ5cjrLp8WwR0odjAyeAJYSWGITYWmpVDJ3FLi1vOjNWIrX8UxJoziSoY4BENdoaVv18Tz+tt6OaiF7JVO2BX7/mtB9jXBoakCjMA2Dbr/jlEX2aHgnPN3fKqI9KzrkgS8/WgzK6CFZODPJKFE21MNKWcc3V44K311q1jZlBCzqR3lACk1eTOqPuCLcId0ATZocVTUSG2QMXUaBfPv/YUDXWyyWyqK9/P1CL6kgwFjqTcnLBGZDCJNDGSf8eP8+SXsJOV2kBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDKQpJhQPepHdzcYyimp0pDY4zhda3CoDX4DpK/bCmY=;
 b=f7+VcG/jHPe7cM7/xU+WQRkinX5ZMJ3qRV3//dEvpv/Bj33F0xYgsS3PUMdbYIet6hnCzaKmpUELtmJg5ATNLB8k5tyEpnSqDtXSEoSfo/PGjYoEioijwMoPaGnQZYDVvAX4pW+5yv+eZWYr4IoZBqGobVzXTahLDMZuTCe4XWpUiqBBWh9PQxzBwTT+bUcjj8cY7Isah0ickLNsbxsp2in87Vdc+QlhbyXOTXG8oKM8YEkVH4DGUekut4i3R2lrrdXjJgi0OJUyYLaai1HEixHwPK2PBpULLvkRHFgX7mDon5Cacg7D7Q6JbUnBaq65htpM03FHeYisNT7c2Y64nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Tue, 4 Jul 2023 00:39:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Tue, 4 Jul 2023
 00:39:43 +0000
Date:   Mon, 3 Jul 2023 17:39:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v8 03/14] cxl/hdm: Use stored Component Register mappings
 to map HDM decoder capability
Message-ID: <64a36a4a39351_8e178294c5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
 <20230630231635.3132638-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230630231635.3132638-4-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 57895abd-1fe8-4069-a439-08db7c272887
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVcQA0UUOHDP3eArCnA7MVJUUA8HzYn8KjMvu1gCGm8eVcdA8LxNfYih3Zrsb3OVAKmkJrbP0fzeOGvyX4cz/Q+ViRvVxL7NqnEtiM/oxI+KUeONeu3H+Yo1vY23xXpf4P8OvS02fiaeHTcKIgE82qLmVN6jMXK2lB71rqO0mlqVKs+EbXtNUJ9EqkfVyPpzjUqsny8+fFDaGvAyclTEDl/kMysbSO4suj3I6IOCazUAmM/SsY1gBmHElwhsnwCfMJLQ8iCU1tvBC13lqikHxa31ExoIUU7OOToMFOjLGBGPR2BpEVFfpet0CmRKWBBoNGCYQ8o0QdwnbzJ+arz5ctoyoLd0/3KW3xya0zxfirqJVZaFVnIgnAuPxCXWGG6UWn9wFOG2kbosXRiWMdQnqktZ1dKiUfrqYe3h1y3i5rMPOXOtjDK3H1D5tIhb5YjxETxgKWs7kRWeMOo+aeyBdkMEe6UPccxkLc/VxZIt6aqJjPJ0h2t5BkThmYakF/yCtICr3KOZ9WSDcryGJ7x+D7zOp1CsSx1GCtbxaazLhfUuiUt+O/c2jcygA1Zg/T5S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199021)(316002)(41300700001)(6512007)(6486002)(83380400001)(26005)(9686003)(6506007)(186003)(82960400001)(478600001)(6666004)(38100700002)(66556008)(66476007)(66946007)(4326008)(5660300002)(86362001)(8676002)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A2UBmJYJWNBeju5ybp7Xab3KU7UGiYzgB3BHyjnDbHW1c6MIqQjbsCL0Uf2n?=
 =?us-ascii?Q?vbYfQmg5CxYMAiDqipBkjIKV/3UWISW4h3AxWmpxkR9tYMkmceRwx1mzRYCw?=
 =?us-ascii?Q?PUvLC5UStjSqVSHLFfkHm7Z9ikOXN+qObJcWOTgGBv9cyAgSFmL5T6jWxz4G?=
 =?us-ascii?Q?eDth3RML1aLXsxwNKsaEeh9pySHxJxiz2gl3o+VqXOQ2sYfghBHT5ncgNDTu?=
 =?us-ascii?Q?pSRP8PIAL9JKc9QQkJExSgIeUQ9qd+IbO8c7I6Oxew8VbnFPp/pd26w350fc?=
 =?us-ascii?Q?tp6v3d1BoL3tD56HQ406vELjhkpgINEV8P2OKmO5vq/7OCnmaNbbUGW+gBM4?=
 =?us-ascii?Q?BtOmEKGNgrIhp2mxB6rzSVFr5yl8E4teb9LZKd50MoZ0XLuHepWuqYp6EAnW?=
 =?us-ascii?Q?1rKCHw4n9yW7fpIm9a1xlmhU8tENCPHMiAK0YMfzMs9QDuCFsr7eqfu4GQpt?=
 =?us-ascii?Q?JoCY67LCjtYQm1ttEoWjb1TvynCj6uTPk1YSOQhpsOmP0qDGFpzc4bUobPOv?=
 =?us-ascii?Q?mmyN/R3WWNuT5LyQ/pgOC0HJlI297FzrzLYjjXeeKbLS1MoAT/zKg5IRCXb1?=
 =?us-ascii?Q?5YFoc9vt0v1l/dzGey/S7O9zpro2Q+xtqLbZk1+MXieiByTrEcMVT2tqTHvB?=
 =?us-ascii?Q?zgsAtfNAppo/tN8Tv5gCjf84+td2zYNYZQxadqtH+WVwa+APTqQdnfHI6IHZ?=
 =?us-ascii?Q?Rw4wJqSRjuCiu8mevrztfKKKJNzstLIVD465VVg/9UaszB6daP8hPVJpL92F?=
 =?us-ascii?Q?nuiA9n5kSKJqVsKabXnmL9UvPvmrBYz6fy6B34GNSdAS086G0Zna1RQOlj35?=
 =?us-ascii?Q?r3lemdQXuFZIhPYS2GAhZ9GuATXY9l1eVv5iEbwdByd3PxC5MjzIj/P7aBBd?=
 =?us-ascii?Q?136zNl8YfnmjKFl7oUq0LoGeaYMRccmVq3P8LyLAgWDrVb6KIw/KkRmpCaX9?=
 =?us-ascii?Q?rtPEqqDZcSIBFypKXXjifyUp5u1S4J9f9vluVTyCatdoSokfHtE+fQfynKyB?=
 =?us-ascii?Q?Rh4kqONySeKGO+LswhOFwf6dTVt199PlY/1J6ELvcfXQJffh8f85aohgimDp?=
 =?us-ascii?Q?m42BkPmStCjLb9oK/zfRGXXGgxBxd9tjiN01oEoazyM3VJFQYOfgkYq62TK9?=
 =?us-ascii?Q?HoLoIZTbn/03bJ7f5vB6NhMKl/EdpOLVIp2OuthExhRccBW89rhnaBKQAocS?=
 =?us-ascii?Q?s0K+WthQ8UzTIKgFMye3YTXm3wrEFn9nItMcBQ1YFBMy4z1cB4lsu1XTjvxX?=
 =?us-ascii?Q?gKHgI7wwE/c0g1l6RU8aZids3mGhGy0bXQGKGUgpp++aMRy1Gwo8q53E7eXI?=
 =?us-ascii?Q?J8+tveiiEPtVqsz3nJ0kFvmmOCpIFYB+jGH/q9zOuPjjSlHV+zpi8dUuw+BY?=
 =?us-ascii?Q?k8ISCDwPfij5hWeaT04qUWk6kfGeubfdOmfLDH1nio47JrRrpPs1yaeioTqN?=
 =?us-ascii?Q?La+iOUQfDGDYxY/NcI36Nu7mCBv/lZtbpU6ucBxuMEJ+lFfC1M0FtaBv7Nkk?=
 =?us-ascii?Q?5R8fSbjIID04+yXxaw7EHgRAUjpKIZWoYANJRsKSQKK47dO1raL7L5H0MZVX?=
 =?us-ascii?Q?NP/xTEeTWpd3JcxOn+xkdYcjCo5mcaJQT83QafcgnDsfjPqdvnZe48N1GUyc?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57895abd-1fe8-4069-a439-08db7c272887
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 00:39:43.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlj9cIjRGegY4Xu6C0et25p0n2L2gjhBqfFgjHQKmgHLo0kXvUfV9qslafFbcwc2UvLU7pLILeR4aMTgUoRUblVZKbQiYqFJ7iSmIwRt9/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5970
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Now, that the Component Register mappings are stored, use them to
> enable and map the HDM decoder capabilities. The Component Registers
> do not need to be probed again for this, remove probing code.
> 
> The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> Endpoint's component register mappings are located in the cxlds and
> else in the port's structure. Provide a helper function
> cxl_port_get_comp_map() to locate the mappings depending on the
> component's type.

This causes a regression that cxl_test tripped over. It's likely
something you could reproduce without cxl_test just be reloading the
cxl_port driver. Root cause below, but here is what I see on a test run:

# meson test -C build --suite cxl
ninja: no work to do.
ninja: Entering directory `/root/git/ndctl/build'
[113/113] Linking target ndctl/ndctl
1/6 ndctl:cxl / cxl-topology.sh             OK              12.78s
2/6 ndctl:cxl / cxl-region-sysfs.sh         OK               7.72s
3/6 ndctl:cxl / cxl-labels.sh               FAIL             1.53s   (exit status 129 or signal 1 SIGHUP)
>>> LD_LIBRARY_PATH=/root/git/ndctl/build/cxl/lib:/root/git/ndctl/build/ndctl/lib:/root/git/ndctl/build/daxctl/lib NDCTL=/root/git/ndctl/build/ndctl/ndctl DAXCTL=/root/git/ndctl/build/daxctl/daxctl MALLOC_PERTURB_=67 TEST_PATH=/root/git/ndctl/build/test DATA_PATH=/root/git/ndctl/test /bin/bash /root/git/ndctl/test/cxl-labels.sh

4/6 ndctl:cxl / cxl-create-region.sh        OK              17.05s
5/6 ndctl:cxl / cxl-xor-region.sh           OK               5.18s
6/6 ndctl:cxl / cxl-security.sh             OK               4.68s

Ok:                 5   
Expected Fail:      0   
Fail:               1   
Unexpected Pass:    0   
Skipped:            0   
Timeout:            0   

Full log written to /root/git/ndctl/build/meson-logs/testlog.txt

It's not that cxl-labels.sh causes the error, it is loading and
unloading the port driver trips over the problem below:

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 64 +++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 4449b34a80cc..b0f59e63e0d2 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -81,26 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
>  }
>  
> -static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> -				struct cxl_component_regs *regs)
> -{
> -	struct cxl_register_map map = {
> -		.dev = &port->dev,
> -		.resource = port->component_reg_phys,
> -		.base = crb,
> -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> -	};
> -
> -	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
> -	if (!map.component_map.hdm_decoder.valid) {
> -		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> -		/* unique error code to indicate no HDM decoder capability */
> -		return -ENODEV;
> -	}
> -
> -	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
> -}
> -
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -145,6 +125,22 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  	return true;
>  }
>  
> +static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
> +{
> +	/*
> +	 * HDM capability applies to Endpoints, USPs and VH Host
> +	 * Bridges. The Endpoint's component register mappings are
> +	 * located in the cxlds.
> +	 */
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
> +
> +		return &memdev->cxlds->comp_map;

...but why? The issue here is that the @dev argument in that map is the
memdev parent PCI device. However, in this context the @dev for devm
operations wants to be &port->dev.

> +	}
> +
> +	return &port->comp_map;

...so this is fine, and folding in the following resolves the test
failure.

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index b0f59e63e0d2..6f111f487795 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -125,22 +125,6 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
        return true;
 }
 
-static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
-{
-       /*
-        * HDM capability applies to Endpoints, USPs and VH Host
-        * Bridges. The Endpoint's component register mappings are
-        * located in the cxlds.
-        */
-       if (is_cxl_endpoint(port)) {
-               struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
-
-               return &memdev->cxlds->comp_map;
-       }
-
-       return &port->comp_map;
-}
-
 /**
  * devm_cxl_setup_hdm - map HDM decoder component registers
  * @port: cxl_port to map
@@ -160,8 +144,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
        cxlhdm->port = port;
        dev_set_drvdata(dev, cxlhdm);
 
-       comp_map = cxl_port_get_comp_map(port);
-
+       comp_map = &port->comp_map;
        if (comp_map->resource == CXL_RESOURCE_NONE) {
                if (info && info->mem_enabled) {
                        cxlhdm->decoder_count = info->ranges;


Am I missing why the cxlds->comp_map needs to be reused?

Note that I am out and may not be able to respond further until next
week.
