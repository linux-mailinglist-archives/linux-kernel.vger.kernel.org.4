Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEAA608FD0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 23:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJVVqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 17:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJVVp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 17:45:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F8F72949;
        Sat, 22 Oct 2022 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666475157; x=1698011157;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2q8xi3OHEETIXOOmmO+oNfEraQjKyjJX9SqbGULEeB8=;
  b=AM21S4BNQrOQb+tj7G2L0iO++06fCCdurBYukOGY5JSiUdzg3onUPMG1
   +nAdtQd1bbsVUWPQHpGl08NICM6jN4yu/gLdGFsf4QkCLJWMt5LmtcCAE
   aOvx+botVX9lyelVKjTVFc0SqfsFb67IRb3MKfDoins/OLl/tg6tqbnYM
   HvRxBz6NCPzV7LJPsSbMT8AXR4a+LwfdwnlT6VzA7XcOMp+ry+f76iaDp
   AAEeNi0eUM8ulDfxgwQbce3PdAuHqXfPU0QHMk0w3MfwBeYmMzKfEPAqf
   bcuCaWStbA3wUBgdyKrmyqUu/qt2pFc8GY7KLQIW0Q2KrgheKS41S4cWy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="287612804"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="287612804"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 14:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="630867052"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="630867052"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 22 Oct 2022 14:45:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 14:45:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 22 Oct 2022 14:45:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 22 Oct 2022 14:45:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDzHyP1NU9Idg0PLjiaIQQ9C8tK78i0BHcE5ElZUKr9z34mGBPkcssLq1Jb+N83sAu/5FQka3eDwSoimwBT0xjyhU27dw2YJ3N+3AMmJ2UCaJZgXMd/p2rvCsdhv/fEQLhIZk1oZiPfghzUJVpKv4imw/LNGuswVWMfZwRgWCZo5lfpqXS+HIEUIZRhA2Yy0S6Q8Ao+ohxeRWULnyyciM9fpMxIMx9q+Ljbb2SdTljnYNIEUhDfbHDBda0FB2BtrUt0G/kYKexM3vg4Go0l55esjSJLJiYeayhthcJctSwDnsYRzkNM+5PwZSrGbuoVpffdYxMEx1jlpibVTsnibmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9En51QxJweWIwn4Zw2ubkj8nnIc/nkvuaipPPVZMPU=;
 b=FZqsv7UK/xTDX4lWOzDa+XfqC+9pzQAUwlsoRnNQ6zXBVdzmnZEVxrlxwBrFqntP8BpmeCsPoMqO3lhcdq3remzdt9HGTvU2ZFH3k60HuEQGFXR846jgfc+9np1ZwyrFoy56efKoyXhZyiIqfZ+PVOkrTyVogYZtbYVqED27eoq/n50KqLVa4g4suZfROwAqipLT0EV5zXKNXofIy7fOt6GkjzFLKcEiA16Eu2j2SGFPju1ZtVDemvb0KgV7alE9lYkyZx/pjuM2zbTHYg/7VewPP6MF73JDpGo00eKB0uW5HzG+eZo9KFsex8opAgjzqxfqAhK0nJ+hExeYYMSnnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY5PR11MB6185.namprd11.prod.outlook.com
 (2603:10b6:930:27::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sat, 22 Oct
 2022 21:45:54 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Sat, 22 Oct
 2022 21:45:54 +0000
Date:   Sat, 22 Oct 2022 14:45:49 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: RE: [PATCH 2/5] cxl/pci: Discover and cache pointer to RCD dport's
 PCIe AER capability
Message-ID: <6354648d9b004_141929463@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <20221021185615.605233-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221021185615.605233-3-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:a03:331::8) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY5PR11MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb64e71-430a-41f3-33b0-08dab476cb5e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nurNMxfQ5qzcc1yXmapsvTedjOSvCJH2p6yWXd1uY09yRJHI6ufPFQPaK3bNYH+MNOQE76HOkqqp8Tf+fDwJIRbg1hJddx/d2W038O2ZjIJxmwTrAnq9yqRf25Ub93FNSPRrz+2nkpoO6YbMwaskYygYscP1wPIFcAW9rpIFO0ciLl+WjxJrTOECk4/ApC5AGEzUEmfiAc4xu7kiESPMRnS0skVCa9YtvW3QdE2RWsi6PwwQca3IJlUPjDeL/N/127NAnjE0O+qrHCs6RIuMWhoNPzyuMbykd9B7Yquofb9F7LNU8maYSm5xSyu90s6HXy0CFpCHTQh/yraBHbo5nDSPjuZZBuLrw49YTKa9JEvFA+CCW0N9B0w4qQlpSBOSS/SQWZfJbt3Zj2CAd/SBNJmZb85RvrzvLZMgZzao2AXvIBY7e/idPCB0RlktkR2WXYwvIU29dUgJCsOFKYXPy4nejhOaYhU8Q8K076Io7l9Z4g3i6vjzp6yo0kC5WmTAsbchH2e5kxWwA4OvW1wdigkvrt8lb+EI6c7/xCRboRkJzzwCd1kXUhgAIZlYNXdDSpdz56V0sG5wyUnkInqPXOjGYenjsTA2LKYVJFxD/XqFu9TlSypTVxJQFPE9FPj89LSbMldFEFxspdNwNBozetLXaBdQd+gcGDje6KdHzYEdqb5uNZsIFeEhWpahS6d+PDCXo721VGhsoQN8LNd8CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(82960400001)(86362001)(41300700001)(9686003)(6512007)(26005)(4326008)(8676002)(6506007)(30864003)(6486002)(5660300002)(7416002)(8936002)(66476007)(66556008)(478600001)(6666004)(66946007)(316002)(38100700002)(186003)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wSZ9/2+89H+8xUWSTXV+uryk4DZaZ5/DeFLPEh91mbk40s27YM8YhrsUh+iN?=
 =?us-ascii?Q?Io/gNUKMmaWLevpxE2m+4ldMpqjmBQNjXH+GgXV+YENt6o9KKCmxXuDMixS6?=
 =?us-ascii?Q?KB07NSv8svbNFtdC4FdXjl3HyoUiZMWhYYA694h+feAKdf/seb0pJmcOAXet?=
 =?us-ascii?Q?pXx/2qIWdfbyVweQxJezS2Rc0zIYAcVOn4zC2sYkfvSLcIvAQfCyf+606cfT?=
 =?us-ascii?Q?vFL0Q7tFJhW/r2YvX/T39Oh12T9sKATUvMewrKSVInC0B9dgV6+JuqCDY2a3?=
 =?us-ascii?Q?A2y0eMP3+oOB/uqICeLuf92OM0ck2Xo7YeeKYl5JQCi9e5I7ErleZZpNte+a?=
 =?us-ascii?Q?kp6G1+jhyn61yB3JrbgsackblsCsig4GQ+gMSqh60V7xj7olyVWZEsmylrBD?=
 =?us-ascii?Q?s7YNDmn5yc6k3jU1uIeCnqhNChz56BefeGovflZiay8qr2BlKwQ5Y9k1XJxn?=
 =?us-ascii?Q?qzDGpVzdMS1NLC/5eEaLO/C3z+/iKY54WcRW9NHhFeDf3kwHjG3qOlEScE7l?=
 =?us-ascii?Q?Wu/WOjyat6EPdN+NlgxOWQABSvrMuONow2NzVSPokS/uNbBHy/YAYfn2rmlU?=
 =?us-ascii?Q?hyXwQWPdDJqLENPvyzX6RIT/s042Gu3NlQm6w61J5GTMtsnSyFyqojv4tj89?=
 =?us-ascii?Q?UziUJNxq5Yig4VPpwNUJPocvGotDqNm0EnWoDlxBvwD07qLKSkXX1aC6hC0I?=
 =?us-ascii?Q?tRO4z3qalMdRvL6dwP++U2LVnUqcss0r+/wdVPDQrPx/2tTHlL+lk5ZSkeSf?=
 =?us-ascii?Q?qHPC7q+blAurDuWY67zXxoIaUv03LLkst0sZZrYqfP29DTAIQsyasZNsBOh+?=
 =?us-ascii?Q?7rLkILJyayPmfz07vkF1vmeaQHKedvmLojy6wXyi2ttKK6S6GPR6jWjbkSbV?=
 =?us-ascii?Q?EquuEOuVScidefK+/niQhkN180EryRp4VVu/PIUoicgj5kmZW6fLBp5DBYFA?=
 =?us-ascii?Q?RIjUAWplQRvqFLYRoUC4I2ZQ1TJfm5iJzy37ymRSmLdtM5odOrAY4lvi+mF2?=
 =?us-ascii?Q?eU2xpz5Z3CxnZmnd5XXljoRkqRi4fFPz/+Se37wrqNaAnN4PYccKW7qkaFas?=
 =?us-ascii?Q?0dKWVCpNn6socMsux5qMLEzq7vu3KitsDj5Jam700IAwWht5nzaD2C+6w7yC?=
 =?us-ascii?Q?snHFX7WHZspzPDfNLtgjxrpsRzybZfnBuMHhad7TkfmvhXX3MGgjmOdEEUCL?=
 =?us-ascii?Q?ozo8G+gkZBsiCB3fOk549oJWGjLRM/nITjMpumzhwWjQBh9ErC5i/Ysy+G++?=
 =?us-ascii?Q?NMsW+VqQqqOaNaWdYQJxs42nscp37K+Ap/pwG3l7BRQbMnzK5pWOlBPvjf7W?=
 =?us-ascii?Q?2XLM5Y9KViuCX/4ftNNS5KQlVnNMytmq4U4DXMKSNIRIMJDaApTslYvjh3yP?=
 =?us-ascii?Q?hJ2jPiCKiQmBN1kqHgCCZFfgh7YJAa5/W1/lVWtqJ2RG26ihSfJF0u7ESPbN?=
 =?us-ascii?Q?iVCkj5atFq+Ee3EnFDYND0jF1WGbZnk2PQ/AcwnaAfhcJCMgNz5YNjo2BJgA?=
 =?us-ascii?Q?0bPICmaDJ8jhRTR8jvoW3Z7GghvrZGoHEARiioxtKYKhjsM4SRs16GkS6SgO?=
 =?us-ascii?Q?sGHge4fLKUhgU2TXfeP3ArJ4ccjSOgJVf7vT3b4WA7g74oQwAK21nIlsF0kq?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb64e71-430a-41f3-33b0-08dab476cb5e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 21:45:54.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIhGyAAMXiWLPjMJ0ok6o6gVIcYJWoEC5ZfV5oVwqeabp2IuPD6xC7N/XWDida1U8BF5/38sgtQw9fPljWbIT5/bgxMYf8Wzm7jptFknjuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6185
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> CXL downport PCIe AER information needs to be logged during error handling.
> The RCD downport/upport does not have a BDF and is not PCI enumerable. As a
> result the CXL PCIe driver is not aware of the AER in 'PCI Express'
> capability located in the RCRB downport/upport. Logic must be introduced to
> use the downport/upport AER information.

Nice, I am happy to see this work get started.

> 
> Update the CXL driver to find the downport's PCIe AER capability and cache
> a pointer for using later. First, find the RCRB to provide the
> downport/upport memory region. The downport/upport are mapped as MMIO not
> PCI config space. Use readl/writel/readq/writeq as required by the CXL spec
> to find and operate on the AER registers.[1]
> 
> Also, add function to detect if the device is a CXL1.1 RCD device.
> 
> [1] CXL3.0, 8.2 'Memory Mapped Registers'
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/acpi.c      |  56 ++++++++++++++
>  drivers/cxl/core/regs.c |   1 +
>  drivers/cxl/cxl.h       |   9 +++
>  drivers/cxl/cxlmem.h    |   2 +
>  drivers/cxl/mem.c       |   2 +
>  drivers/cxl/pci.c       | 158 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 228 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index bf251a27e460..5d543c789e8d 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -232,6 +232,7 @@ struct cxl_chbs_context {
>  	struct device *dev;
>  	unsigned long long uid;
>  	struct acpi_cedt_chbs chbs;
> +	resource_size_t chbcr;
>  };
>  
>  static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
> @@ -417,6 +418,61 @@ static void remove_cxl_resources(void *data)
>  	}
>  }
>  
> +static const struct acpi_device_id cxl_host_ids[] = {
> +	{ "ACPI0016", 0 },
> +	{ "PNP0A08", 0 },
> +	{ },
> +};
> +
> +static int __cxl_get_rcrb(union acpi_subtable_headers *header, void *arg,
> +			  const unsigned long end)
> +{
> +	struct cxl_chbs_context *ctx = arg;
> +	struct acpi_cedt_chbs *chbs;
> +
> +	if (ctx->chbcr)
> +		return 0;
> +
> +	chbs = (struct acpi_cedt_chbs *)header;
> +
> +	if (ctx->uid != chbs->uid)
> +		return 0;
> +
> +	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11)
> +		return 0;
> +
> +	if (chbs->length != SZ_8K)
> +		return 0;
> +
> +	ctx->chbcr = chbs->base;
> +
> +	return 0;
> +}

This seems redundant with component register enumeration that was
already added in Robert's patches.

> +
> +resource_size_t cxl_get_rcrb(struct cxl_memdev *cxlmd)
> +{
> +	struct pci_host_bridge *host = NULL;
> +	struct cxl_chbs_context ctx = {0};
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +
> +	port = cxl_mem_find_port(cxlmd, NULL);
> +	if (!port)
> +		return 0;
> +
> +	dport = port->parent_dport;
> +	ctx.uid = dport ? dport->port_id : 0;
> +	if (!dport)
> +		return 0;
> +
> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, __cxl_get_rcrb, &ctx);
> +
> +	dev_dbg(&host->dev, "RCRB found: 0x%08llx\n", (u64)ctx.chbcr);
> +
> +	return ctx.chbcr;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_rcrb, CXL);

While CXL to date has been tied ACPI platforms there is no requirement
that CXL be ACPI based. Given that other coherent bus specifications
that were deployed on PowerPC have now joined the CXL consortium there
is an increasing chance of CXL appearing on an Open Firmware based
platforms. Even if that does not come to pass, the discipline of clear
separation between platform code and PCI/CXL mechanisms leads to cleaner
code organization.

All that to say, no, cxl_acpi cannot export functions for other cxl
modules to depend upon. Instead it needs to publish these details in the
CXL objects that it registers.

In this case my expectation is that cxl_acpi registers a dport decorated
with the extra RCH information. Something like:

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..b42f4759743b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -499,12 +499,19 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
  * @port_id: unique hardware identifier for dport in decoder target list
  * @component_reg_phys: downstream port component registers
  * @port: reference to cxl_port that contains this downstream port
+ * @is_rch: enable RCH vs VH enumeration (see CXL 3.0 9.11.8)
  */
 struct cxl_dport {
        struct device *dport;
        int port_id;
        resource_size_t component_reg_phys;
        struct cxl_port *port;
+       bool is_rch;
+};
+
+struct cxl_rch_dport {
+       struct cxl_dport dport;
+       resource_size_t rcrb_phys;
 };
 
 /**

Then, when cxl_mem notices that the memdev is being produced by an
RCIEP, it can skip devm_cxl_enumerate_ports() and jump straight to
cxl_mem_find_port(). That will return this dport with the rcrb base
where cxl_mem can arrange the AER handling. Likely we will need some
notification mechanism to route Root Complex AER events to cxl_acpi,
cxl_pci, and/or cxl_mem to optionally add the CXL RAS data to the log.

> +
>  /**
>   * add_cxl_resources() - reflect CXL fixed memory windows in iomem_resource
>   * @cxl_res: A standalone resource tree where each CXL window is a sibling
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index ec178e69b18f..0d4f633e5c01 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -184,6 +184,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
>  
>  int cxl_map_component_regs(struct pci_dev *pdev,
>  			   struct cxl_component_regs *regs,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ac8998b627b5..7d507ab80a78 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -204,6 +204,14 @@ struct cxl_register_map {
>  	};
>  };
>  
> +struct cxl_memdev;
> +int cxl_pci_probe_dport(struct cxl_memdev *cxlmd);
> +
> +void cxl_pci_aer_init(struct cxl_memdev *cxlmd);
> +
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +				   resource_size_t length);
> +
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> @@ -549,6 +557,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
>  	return port->uport == port->dev.parent;
>  }
>  
> +resource_size_t cxl_get_rcrb(struct cxl_memdev *cxlmd);
>  bool is_cxl_port(struct device *dev);
>  struct cxl_port *to_cxl_port(struct device *dev);
>  struct pci_bus;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..079db2e15acc 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -242,6 +242,8 @@ struct cxl_dev_state {
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
>  
> +	struct cxl_register_map aer_map;
> +
>  	resource_size_t component_reg_phys;
>  	u64 serial;
>  
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 64ccf053d32c..d1e663be43c2 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -74,6 +74,8 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	cxl_pci_aer_init(cxlmd);
> +
>  	parent_port = cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..2287b5225862 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -35,6 +35,15 @@
>  	(readl((cxlds)->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET) &                  \
>  	 CXLDEV_MBOX_CTRL_DOORBELL)
>  
> +/* PCI 5.0 - 7.8.4 Advanced Error Reporting Extended Capability */
> +#define PCI_AER_CAP_SIZE 0x48
> +
> +/* CXL 3.0 - 8.2.1.3.3, Offset to DVSEC Port Status */
> +#define CXL_DVSEC_PORT_STATUS_OFF 0xE
> +
> +/* CXL 3.0 - 8.2.1.3.3 */
> +#define CXL_DVSEC_VH_SUPPORT 0x20
> +
>  /* CXL 2.0 - 8.2.8.4 */
>  #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
>  
> @@ -428,6 +437,155 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>  	}
>  }
>  
> +static resource_size_t cxl_get_dport_ext_cap(struct cxl_memdev *cxlmd, u32 cap_id)
> +{
> +	resource_size_t rcrb, offset;
> +	void *rcrb_mapped;
> +	u32 cap_hdr;
> +
> +	rcrb = cxl_get_rcrb(cxlmd);
> +	if (!rcrb)
> +		return 0;
> +
> +	rcrb_mapped = ioremap(rcrb, SZ_4K);
> +	if (!rcrb_mapped)
> +		return 0;
> +
> +	offset = PCI_CFG_SPACE_SIZE;
> +	cap_hdr = readl(rcrb_mapped + offset);
> +
> +	while (PCI_EXT_CAP_ID(cap_hdr)) {
> +		if (PCI_EXT_CAP_ID(cap_hdr) == cap_id)
> +			break;
> +
> +		offset = PCI_EXT_CAP_NEXT(cap_hdr);
> +		if (offset == 0)
> +			break;
> +
> +		cap_hdr = readl(rcrb_mapped + offset);
> +	}
> +	iounmap((void *)rcrb_mapped);

The memdev owns the upstream port RAS capability, why is it mapping the
downstream port ras capability?

> +
> +	if (PCI_EXT_CAP_ID(cap_hdr) != cap_id)
> +		return 0;
> +
> +	pr_debug("Found capability %X @ %llX (%X)\n",
> +		 cap_id, rcrb + offset, cap_hdr);
> +
> +	return rcrb + offset;
> +}
> +
> +bool is_rcd(struct cxl_memdev *cxlmd)
> +{
> +	struct pci_dev *pdev;
> +	resource_size_t dvsec;
> +	void *dvsec_mapped;
> +	u32 dvsec_data;
> +
> +	if (!dev_is_pci(cxlmd->cxlds->dev))
> +		return false;

Just use cxlmd->dev.parent, no need to route through cxlds for this.

> +
> +	pdev = to_pci_dev(cxlmd->cxlds->dev);
> +
> +	/*
> +	 * 'CXL devices operating in this mode always set the Device/Port
> +	 * Type field in the PCI Express Capabilities register to RCiEP.'
> +	 * - CXL3.0 9.11.1 'RCD Mode'
> +	 */
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
> +		return false;
> +
> +	/*
> +	 * Check if VH is enabled
> +	 * - CXL3.0 8.2.1.3.1 'DVSEC Flex Bus Port Capability'
> +	 */
> +	dvsec = cxl_get_dport_ext_cap(cxlmd, PCI_EXT_CAP_ID_DVSEC);
> +	if (!dvsec)
> +		return false;
> +
> +	dvsec_mapped = ioremap(dvsec, SZ_4K);

No ioremap error handling?

> +	dvsec_data = readl(dvsec_mapped + CXL_DVSEC_PORT_STATUS_OFF);
> +	iounmap(dvsec_mapped);
> +	if (dvsec_data & CXL_DVSEC_VH_SUPPORT)
> +		return false;

There's no such thing as a root-complex-integrated endpoint in CXL VH
mode, right? Is this not redundant?

> +
> +	return true;
> +}
> +
> +#define PCI_CAP_ID(header)	(header & 0x000000ff)
> +#define PCI_CAP_NEXT(header)	((header >> 8) & 0xff)
> +
> +static resource_size_t cxl_get_dport_cap(struct cxl_memdev *cxlmd, int cap_id)
> +{
> +	resource_size_t offset, rcrb;
> +	void *rcrb_mapped;
> +	u32 cap_hdr;
> +
> +	rcrb = cxl_get_rcrb(cxlmd);
> +	if (!rcrb)
> +		return 0;
> +
> +	rcrb_mapped = ioremap(rcrb, SZ_4K);
> +	if (!rcrb_mapped)
> +		return 0;
> +
> +	offset = readl(rcrb_mapped + PCI_CAPABILITY_LIST);
> +	cap_hdr = readl(rcrb_mapped + offset);
> +
> +	while (PCI_CAP_ID(cap_hdr)) {
> +		if (PCI_CAP_ID(cap_hdr) == cap_id)
> +			break;
> +
> +		offset = PCI_CAP_NEXT(cap_hdr);
> +		if (offset == 0)
> +			break;
> +
> +		cap_hdr = readl(rcrb_mapped + offset);
> +	}
> +	iounmap((void *)rcrb_mapped);

All of this mapping and unmapping of the RCRB needs to be centralized in
one place and owned by one driver for the downstream portion and one
driver for the upstream portion. That *feels* like cxl_acpi for the
downstream side and cxl_port for the upstream side (when it drives the
endpoint port registered by cxl_mem). It should also be protected by
request_region() to make sure multiple agents are not stepping on each
other's toes.

> +
> +	if (PCI_CAP_ID(cap_hdr) != cap_id)
> +		return 0;
> +
> +	pr_debug("Found capability %X @ %llX (%X)\n",
> +		 cap_id, rcrb + offset, cap_hdr);
> +
> +	return rcrb + offset;
> +}
> +
> +static int cxl_setup_dport_aer(struct cxl_memdev *cxlmd, resource_size_t cap_base)
> +{
> +	struct cxl_register_map *map = &cxlmd->cxlds->aer_map;
> +	struct pci_dev *pdev = to_pci_dev(&cxlmd->dev);
> +
> +	if (!cap_base)
> +		return  -ENODEV;
> +
> +	map->base = devm_cxl_iomap_block(&pdev->dev, cap_base,
> +					 PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V1);
> +	if (!map->base)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void cxl_pci_aer_init(struct cxl_memdev *cxlmd)
> +{
> +	resource_size_t cap_base;
> +
> +	/* CXL2.0 is enumerable and will use AER attached to `struct pci_dev` */
> +	if (!is_rcd(cxlmd))
> +		return;
> +
> +	/*
> +	 * Read base address of the PCI express cap. Cache the cap's
> +	 * PCI_EXP_DEVCTL and PCI_EXP_DEVSTA for AER control and status.
> +	 */
> +	cap_base = cxl_get_dport_cap(cxlmd, PCI_CAP_ID_EXP);
> +	cxl_setup_dport_aer(cxlmd, cap_base);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_aer_init, CXL);
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> -- 
> 2.34.1
> 


