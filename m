Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F0D72A85A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjFJCYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjFJCX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:23:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F0E1993;
        Fri,  9 Jun 2023 19:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686363837; x=1717899837;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B5t3YKIL3MgAeeYvj8hP90YHKMCfrDLzvm4GwAc1OZY=;
  b=Rewbmh6w0hLFsts+VZUTs35Uz4DbbUeVdl6aeQ3H8l6pgdyVVje7JWmh
   n/tKiDC9wbtDJw+uEFDJsbumCbcMMc6HnCl9Yeikpa9AiEmqcCyTe3wUM
   VHLWHifhrY7Hzl8Yfl5K3cLtPFlL693Y0KfgNZJhd7rMGyBrthEMBk97e
   0Ejrs8kJi3eMm8wkE7yTRz0SF5DxOc+8nvWVD/d8PDFeQCeiSXU686lk3
   7QmHS1N2cg6Qiiat1J81W78fYUb1xe/naW6dGS0mIQ20IC7hTveZ1F8F2
   bTUKAVPeY/dzsCDnTviDU19oBQlz7oW4XOQgROUu7RB1XOT+nVUXfKQBV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="355211691"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="355211691"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 19:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="713715784"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="713715784"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 19:23:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 19:23:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 19:23:56 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 19:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3UcBn6BxM8GZ8/gt57A3hHkMe9sOunK3Z6ha69JUcfq9QaMXIWmo3Qm1POhcju2q0VehVtuaFgYzZzKGLH33xNTBLhCaSnw5M/oKu00YH9u8Wv2CfGX8wYorRyRb9AsoAv2I70eRh4HL6Y2bqI8STQrFj1aZ+0oCz6fsDrYtBhbro2cWGELlVwQqEM8QHzi/k7I4gGNSxHhJ2CowKSwz/EjPWiGBYowdjpB+9xBYOdU7qkCgPF3zG45lh4A9ZoW8ZdJIO2FfjbSHNX4n5QxeaxefuY7fWKsBKkZa7OWJTxD438D54ce4gMAFjb+pMH6UjuKq/T3pwoOxqpc8HSb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdrdNE3mKPOX5m+xiOgpLyWoQ9NFP8B2h2BBGgm6Oq4=;
 b=LDZoMAbTT1q7L65wGr5jCo7DqKc9p+ZRi0VpaRUIz/txr5+pBKO8Oa0uaWs7+XuFOtoBnKpE1fwS0M31mjAE64u+Ke47eeRMoitP+8RZTI60klX6eztDX+AzfMCuNa11gaQrjPFEDRQaJHT820IK7CJsWf7t/hatFuReGnTZ26oUyhm1i18yxO1BZAdPUENqjlAn7bOKZ6BP6wVj+5vjEWaK8DtsUQTGsDfgBx5qkuxGjn+MJ1YKkJyEwD3mpnd1U8gdMgyr/eSb05Ajr0PIscIhd7dBcwEdb+f7RoVOkG69+Ns9EFRpOPf83RRDk5KdtPEh9eebX0HAGvp5BSBjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Sat, 10 Jun
 2023 02:23:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 02:23:56 +0000
Date:   Fri, 9 Jun 2023 19:23:51 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 13/26] cxl/port: Store the downstream port's Component
 Register mappings in struct cxl_dport
Message-ID: <6483deb75d0e5_e067a29420@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-14-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-14-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: 19900220-68eb-4639-88ef-08db6959bd93
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4dsT4yUNZHNbTewUU+T50aVittmHY8jSgtg9AJIesUue9UB9NEdRnU3k5/4TqgCKMbWtQHoyhqoTG0ZHgB5nq9xa7IfiJNckkY++lMI694gTMydE6CZCf1fKa9WrthjBIMPrm8pJFrEn9Bexo9Pef1ayjy0cPf5PDQfOBAJk3EiVgLey/HfYmCh1FNxrfpYDtmVt3y2lomZX0iX03hGrS1iRZVDNDGzepU9tYy2VlIJeEvUfd8xpX0eCUZNE7TztBAoes1nGw0Y7rmhkOWXNgDGPA89j0zp2/5bK5iZZcbVCPNNBSUrk4lySyZTel7jUY/tRCKduYMAc87ch4q4BvaFVR20iY2b+lM01m5UhHKu4TA+ucllTxeHhmP35Xjn8SyEkCTQ+dpdmgzHuQPOk+einFDF5Wq8LNHp/Z6fRbhKXKvcfIcmnVLCJakGkHht5k93rQROYREzwBbG3lOxMTy7Z9utuQYZhTTjJ3evTgqZU5sVt4WoFFLWDrRl5I7Hf9tyQuUVyR488whjyR57pBafwW85R8ZnaJwd8QJnymQ22v/F86ADkHkOdhtoZZ8f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(5660300002)(4326008)(66946007)(66556008)(8936002)(8676002)(41300700001)(316002)(2906002)(186003)(478600001)(66476007)(6666004)(6486002)(6506007)(6512007)(9686003)(26005)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XVyq0vA4ZULtBlaYjBEEXBwAp1dtjGUCJdhsch5EP8HNhECdBkBxOl+bXOqU?=
 =?us-ascii?Q?DKQc0X1Qg01NtP3pmotQNZa1o7rHnrq9Ke58xg1iDOsB+whWppSL4MjYgC+n?=
 =?us-ascii?Q?NTk6SJilpgScxkQV4CTX0+MNsDoexxhE/BTvzrNcMuGvzJ5IFMZK6NDuphwa?=
 =?us-ascii?Q?2lI07T9O3UZ4UnPc2sAhvRRLgEaBZYqorl4Zw1xoxTKs6Lyxy2dZvkD/8P/K?=
 =?us-ascii?Q?/VIZnRCxcbcUUM4U+MdlwyHmZnIMkhDN4ICfUeM1EV6cTWbdAAxMC/Ho4a6H?=
 =?us-ascii?Q?EnFAA1VfeU3vkCJAWbRp6X80/BL3RINWKlAi2P77YWGdfYyby6YUqKA4+CQ1?=
 =?us-ascii?Q?ljBacnvkQi5eLXoDUDiQjHZb3ikwiHLHwO/S4jwSz+zCq1yuPLTEiA2Mo5iA?=
 =?us-ascii?Q?ELmGDqHTRJuHa7Ux00DfU1eoy68KfAjubqGho2iZYdZMb8kXb6JVKUdF1w0U?=
 =?us-ascii?Q?5BY3qP+pCVp6kkC0v7+IXQBF03YIHwREEgEeQqSiJ62lf/bDxbBUwHAziK82?=
 =?us-ascii?Q?xjLII6WsimRML6PV66hCH3TiCiEIX8hUDrLW/mocTui8ubSfvLB+Cy1DRr1S?=
 =?us-ascii?Q?1iio1pVGSc2/EyRIdRqkVgxgu2r+4cGKHjK6kWCm4VIP5c3+JxpiTu/Mp0UJ?=
 =?us-ascii?Q?CUk30/I+CRmYOVtY9NDrm5m6GgMc18gNRtHZNnhNLyQYCJCu+TY/V+rl+Mc+?=
 =?us-ascii?Q?TbXW70d8yRU2K/oAJf3lXhAK3kpuZIwGmws5Z36IjYO/z4wIuvDrZpJ1OCId?=
 =?us-ascii?Q?MNvCq5qKk21TA5xZ9P9kP2O0K3cafkUeXk5N4jF4l0Iyy9LLZLwa06wsoKOq?=
 =?us-ascii?Q?dLzqGrNuFF2A0C9IuLp90ONaDGNK+qxYuSDYpsbmkwI+KU8KaUgWzZw5aYfl?=
 =?us-ascii?Q?DywzQoTeL7jZHLL9dVBfmufAsCzQeIVLggBQ3GlXGeI+y7GxmeKS5rLDb2EM?=
 =?us-ascii?Q?1t1cutmLRaWcICh2xLnq3PovpFbhlQaQvYYUBl/CI6b/RasoBM8i1s912207?=
 =?us-ascii?Q?reDVQoG8HQeKWL79RVOWbpBgjOKPfISLtvpH/IOEBTodFRPoTePsE2UtIguZ?=
 =?us-ascii?Q?YZ+WXdtIzB+dAMPQB6RSV1nHJf6/sHVnjhT0Qkp9JSZSL2kbukE9adGQgH4U?=
 =?us-ascii?Q?/HYPGnSCJSARif50y6aj0NEGL0msoXh040KqLtED8dOqs5SjGpSLOlbmu27a?=
 =?us-ascii?Q?KzScm3cj3zrFIx+wb7s43nFu2Q7LYfRVJbObxxxsnx5jMeU9rexniUx8fvtq?=
 =?us-ascii?Q?Ytsuud328J7I/DB9aa7Y2J83/IiCi059F3cnVxkbLrVA7GghHmfHhfYGJWU1?=
 =?us-ascii?Q?e8k7dKNpPbf4cGEpasKn4p7cbJGZ0HOcP8391UWW9yP2Bc7XYpDDIjJIMC62?=
 =?us-ascii?Q?LM0rdGmc0ck4sZIPYBHDp8GEvOQvyzmu24hrdLDoPGSMaySC8obO4liqgu87?=
 =?us-ascii?Q?DEmtyQeXLMQoNXHG3OgJ9IkR8YGmQINZHW15WFZR2KWg3w8IBUV7y4PhiUjl?=
 =?us-ascii?Q?u/nM4ZPvQCzosApRElWcf6CZm6bTLhGZ4NoJRJ3fudneHXBdpf+9AS+A7qSZ?=
 =?us-ascii?Q?fbtRQ19pNTdew9XPahrMAZsRIqksgyWlnakLzdc6Ewo9A0DsW1paYTFx/442?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19900220-68eb-4639-88ef-08db6959bd93
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 02:23:55.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +p0Bwe6Do5t7Z5KeWPHUYEoUPIhF6Bh2B61V5KF4eWVlLGIEKcQSmeJtER8ilk9y53ipNLOBvuaKV+belvWIeDgeFjTL5FXriCiA1yPcoc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5162
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
> Same as for ports, also store the downstream port's Component Register
> mappings, use struct cxl_dport for that.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/port.c | 11 +++++++++++
>  drivers/cxl/cxl.h       |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 305125b193ce..a40d8cefb57d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -708,6 +708,13 @@ static inline int cxl_port_setup_regs(struct cxl_port *port,
>  				   component_reg_phys);
>  }
>  
> +static inline int cxl_dport_setup_regs(struct cxl_dport *dport,
> +				       resource_size_t component_reg_phys)
> +{
> +	return cxl_setup_comp_regs(dport->dev, &dport->comp_map,
> +				   component_reg_phys);
> +}
> +
>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  					    struct device *uport,
>  					    resource_size_t component_reg_phys,
> @@ -992,6 +999,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	dport->component_reg_phys = component_reg_phys;
>  	dport->port = port;
>  
> +	rc = cxl_dport_setup_regs(dport, component_reg_phys);
> +	if (rc && rc != -ENODEV)
> +		return ERR_PTR(rc);

Ah I see that you wanted to share a similar function between this case
and the last patch, but I would still remove one layer of indirection
and make the setup return 0 if there is nothing to do rather than the 

     if (rc && rc != -ENODEV)

...the stresses out the reader wondering where that special error code
case is generated.

Otherwise, makes sense.
