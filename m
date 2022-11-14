Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A68628B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbiKNVaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKNVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:30:11 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E501318E1B;
        Mon, 14 Nov 2022 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668461410; x=1699997410;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oXHKfoks2zNkNvRY/9LF8u+sFxSH+ew36VXQ2eDlR+Q=;
  b=R9yqMnKi7OyQXX7uUxgYCAy1Ay8RqGAwsU6mjFOCno66C5PcxRr2QzFH
   d05ej+0rjoehmjLps2OgusKhCrbfDVaiic5OHboxSx0XrfHuQ9rOXbf+G
   oVylDdJnivTMZWvfm0r622m0s2ZdrNg+oC6Twn/HAIGRpHxuCMZC7AcPh
   DYj4rH0ELg1fC/NGB2AjuPTj0cf3g9Zs+vcNQ0sAS2JhfkyiZYj5E5rWO
   uFmI3Yrb8IVPK0gcIgn1EgClfOyNH1Q06gNAwa2EK6aQeYRNwVXBwIT+t
   OyuNt3W7u3TWIWrCzfLxOjbMpEeRLP9SoMcvTPlIoCcERcqMsisY84hXu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398378048"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="398378048"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 13:30:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="616478993"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="616478993"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2022 13:30:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 13:30:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 13:30:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 13:30:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVX6JCuydoElohsnUnfqjik+L9N0+9KctCeHdJmOJXRUqWGY7U38MONtwu1rNGO1Ajuk0rAmrUJr2kW24kFZSqBtDLdWX80lzJM2AbuFqbugN4dECoAXvtVGS4Bfa7rOvhUG+SmRlNB/DSR7ynoHIvj4zMKZ5uhyJ2OanJ5Qjg7Yb7gR1BO4TBlxchOc12i62G/52CYUf6xX5AwJgGQdplzHLKc0eMpMcnK6Shvz0y/IJL+4fcMhtb6P+PiscIWBTegO/J2D7jJB7Tr8Xn+Xe1aOFHkYbHA8pmsRaJDIj+jjQsxroR6g+KgrfqBHk0hhCXYvHJ1cULwOxv8M2Kx2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U+m72Q45m8aQ8A2ZkZhRRYTGnSc2yJ4SJnPdWG6I/o=;
 b=XwXSe/kPJGAjDWgmIQyVLx10W+xulYXbZ/snt0xhBSpCAnVC80rw4OeRhgcL6A4sTpe24dcIzwMI1nsau7QDNLxFvTCLXko3jvKgiE/EpPdbnaaAeOmLXEJm3EjH/JiQVHVtFiR9PeUnzWw8afLwp5TgzVa1jcz4z0ufe+QsJ+qjVonWjS3N4B2gNhAa4nQvr9PUQFKaAMcxJsTHex64SorgoX59WiI182B5y5zIsT4mqPcrdsHUU3STCCWGOYztkPeLLxyt9qwZkpckpyHlyDuYesxqlnahp7BO0mugO/toKfLB03uSQyMbF4AyqxjQ5/4xIp4O3g9AZpPjDQWNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4599.namprd11.prod.outlook.com
 (2603:10b6:208:26d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 21:30:04 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%8]) with mapi id 15.20.5813.013; Mon, 14 Nov 2022
 21:30:03 +0000
Date:   Mon, 14 Nov 2022 13:30:01 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: RE: [PATCH v3 2/9] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <6372b35953580_12cdff294b7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-3-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221109104059.766720-3-rrichter@amd.com>
X-ClientProxiedBy: BYAPR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:a03:80::43) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MN2PR11MB4599:EE_
X-MS-Office365-Filtering-Correlation-Id: 2141c058-daef-453a-4615-08dac6876492
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CODdh2Dcr8qHlRhSys2Y8vLFxGPiWiYmeCfWnmlFLQxmr4EFhm2pbOi1dQeyAyVKKY6+D3Q/KnBISBLCifL3PXheGAAAhWxqtKIu4UdNfhaVHsWkd/m8PDl8gwtGSloFjgLZpQno3I7o5oKRzQIm1wiPx6Jgdav5jTbOd1FiUxMxeVspf/BSxPkLrNL487kU6+QLXYCrWXWukbkuX0sp7g8+Bd9KHWG21MifhjFLu8OVRbBk99PjSiZ6Q9AnoaPNKpvfGFZ6WgtjsGXNzJunQfhYxvAsMXTRMw4KLltURYJmT44tHFJzkc04vUN2YMHPYykPRiROaaKNy752d7kwGAx/fDDDZZ47BcQigtVt4rtXptJik7XU5O8rxcL0wQKBB/KzVELqQHy1PKsLJFj6m+1voWMKbLao0KnYq6EDg5NGMg2dd/AaWbCBiQt8GWOcDaFFT+XVsY6KYLJk+pO+FeWuDpJTAwvQlX/whY5CkrVaGFTDG3AIZIvcvDvNsnZWEzkoXGu4nfNwJeSY1/gzr4DnO8STuid21MYFJW4HHIutpoYMPHvvHB/fGsJuq3gt4IyogdXy7CAkiE+JpBTHKqWYQ+svkiq/NMx4UfV7otPZTYcU4iZGoWjXZ+9+IlkZMS/4PdW2di5p+gB6zsB49fIX40rqlY9eEKwni6TOSRct72nv4Oo5h+MXURwul+65u1lDAqh1CNju+4hGJRCNgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(8936002)(83380400001)(5660300002)(186003)(7416002)(6506007)(26005)(6512007)(4326008)(9686003)(478600001)(6486002)(66556008)(8676002)(110136005)(54906003)(86362001)(41300700001)(316002)(2906002)(66476007)(38100700002)(66946007)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pE9wWl8eAo1XGixCo3D3DYPpTEclf4NNM8CogMPxXSq/DwxauaAKCcuE2KlF?=
 =?us-ascii?Q?XZYga/Nk7wCfZQLiJS+HgeVIypIyOMfWJ1G9op99KGP0OW/BVnmazHGlnh2D?=
 =?us-ascii?Q?qxHlskM87ZUua1tVFfjzjTauj0SBb14X+Ps1NCalz4xzWOEdy0ZCqig9aRu8?=
 =?us-ascii?Q?GHWpvzZcVbgOol6oCNYTkDuTfkqhubseB0E4bo4U5fV0qslq6h90Gb1yKHQb?=
 =?us-ascii?Q?DX3joH2Y1f29/GQXfWKyk+5VHY6vReV2o1glw7Z+RmbSOu+/Fax8fr7rIlsT?=
 =?us-ascii?Q?gZg0h7HQktPpUFegNpyp3eC0UObRclFf8a3HgX/iZNlC5KDKpi0+++rSfqo8?=
 =?us-ascii?Q?55eANvKpH6haJ/HkJHe+J0o59w+lEe6pnWbEdFjKicauSDAG2WZC/W2IRGqP?=
 =?us-ascii?Q?JuvGSNO2T00q3spXb0hBMORPHebKZeySvv8Img+vTDy9mEALjSx0TZ2o+/NI?=
 =?us-ascii?Q?j61J3ZOIcmilNjmOWvLXf4eSbBH2tBYJ9V8OPLfdDO3UjauhA3Rd0C49hR0K?=
 =?us-ascii?Q?ZNzbJZdiMz6WdOcoDBZzFj+/3IK1VXW7GLeKvwC9xcVE765+8HCqcQyUFGB8?=
 =?us-ascii?Q?vYtOSPmKqlDDka05SI99plTZ1lE64lDT9P0ZGheMKqJMuPbIsePZ+XLUfwfW?=
 =?us-ascii?Q?sTfBlVaZX8tdBvkyLTCPMQughTNYUCYQy4f0ROkdiR9m+TP0TxK5tRznrFV+?=
 =?us-ascii?Q?nDvH1xouiIrutypH+GfSoD6fXrt6AsqxAOG122erRfv3ld7E3plnNH9/HQ4j?=
 =?us-ascii?Q?ek9EKVnYojZlUijhdrx9dDuljypECwCsLHecVybysNFCouH/XRsWzoWxypBj?=
 =?us-ascii?Q?JC2AXBbQi+DRZYBqzIPE++jVRAHsvgVZqKMagaZC1R4dYr3hp7tS6sNWhhGl?=
 =?us-ascii?Q?c3WjMQMB7dwwImUQuAmIPfLyuwUY/5eIwk63sH827JnpFsgs2GX5KE3HXVjv?=
 =?us-ascii?Q?Rxd+mugsqOLTw/8J5resrcHfobeuRGl3xJBA2f+x17Yn1vfbk4kxsvkJK31e?=
 =?us-ascii?Q?heNPH6YeEaLHaOrJh7/BgU96FycC4Hhd9qDy/0e0vAVABo9ee+j3L6z6mMug?=
 =?us-ascii?Q?CGIXvOXDGHJQMf+MmxrORYGEOmgmZAPHltBGrlJi3kygU9WHjBL3NVjGZyFo?=
 =?us-ascii?Q?N6nji19iltE+LqRETmLGoPaQr4yKqoz9v3VQ2IIsGYfC2P4fhMT4wnrRiTYL?=
 =?us-ascii?Q?In3ZHid55q35N9gaU7c19Czq8KjH4DPNdGgfHlsEi9eOeB4wVkjKp9gT6qTI?=
 =?us-ascii?Q?qYTFEQWoysBmYM1MKQmKUvxtQNVXH6+PaIvxlGnDh3QJO+eim+TGnUDHAPZy?=
 =?us-ascii?Q?JA8R/vNnI4xZwwpimvcRE6rP5ki5ENErN5a+i/qCQSR9jK1P/IVv6YRzCD5s?=
 =?us-ascii?Q?niLeQHtS7a+IlAc5hPiRAo9/p2axOnS4cLU9o+hX0cbORLucN2g7szW2sDQy?=
 =?us-ascii?Q?APsetg2ictIOKnXElkpac0v/CyPcLHtxsClSEsBtV/DCy/+qeDWLBcjZXcv5?=
 =?us-ascii?Q?jvO+ZspTAJm1fY+Z5CAWAXmwEn7chpReL3GXzHUuM1qcZ6LVMVWZPKlyN+Tl?=
 =?us-ascii?Q?2M2ZFl5KB2rIEq9ViuXcYLBoz4CUJsz9esJ6t58t5Hr/qmkrmBu7R1T4GIGB?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2141c058-daef-453a-4615-08dac6876492
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 21:30:03.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHlcllTDrRcV/ZF0blQL0cZGK0MsHUjVnzQFV10tbawV295EL0HBdS3/OaDlmsKSoXxVUKeTzZVhHEDk6VP6Jt8U0ObotIGJS2PK6zw/Ka0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4599
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> A downstream port must be connected to a component register block.
> For restricted hosts the base address is determined from the RCRB. The
> RCRB is provided by the host's CEDT CHBS entry. Rework CEDT parser to
> get the RCRB and add code to extract the component register block from
> it.
> 
> RCRB's BAR[0..1] point to the component block containing CXL subsystem
> component registers. MEMBAR extraction follows the PCI base spec here,
> esp. 64 bit extraction and memory range alignment (6.0, 7.5.1.2.1).
> 
> Note: Right now the component register block is used for HDM decoder
> capability only which is optional for RCDs. If unsupported by the RCD,
> the HDM init will fail. It is future work to bypass it in this case.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c      | 43 +++++++++++++++++++++++++++++---------
>  drivers/cxl/core/regs.c | 46 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  8 +++++++
>  3 files changed, 87 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 06150c953f58..caea42cf9522 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -9,6 +9,8 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> +#define CXL_RCRB_SIZE	SZ_8K
> +
>  static unsigned long cfmws_to_decoder_flags(int restrictions)
>  {
>  	unsigned long flags = CXL_DECODER_F_ENABLE;
> @@ -240,27 +242,46 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  struct cxl_chbs_context {
>  	struct device *dev;
>  	unsigned long long uid;
> -	resource_size_t chbcr;
> +	struct acpi_cedt_chbs chbs;
>  };
>  
> -static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
> -			 const unsigned long end)
> +static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
> +			const unsigned long end)
>  {
>  	struct cxl_chbs_context *ctx = arg;
>  	struct acpi_cedt_chbs *chbs;
>  
> -	if (ctx->chbcr)
> +	if (ctx->chbs.base)
>  		return 0;
>  
>  	chbs = (struct acpi_cedt_chbs *) header;
>  
>  	if (ctx->uid != chbs->uid)
>  		return 0;
> -	ctx->chbcr = chbs->base;
> +	ctx->chbs = *chbs;
>  
>  	return 0;
>  }
>  
> +static resource_size_t cxl_get_chbcr(struct cxl_chbs_context *ctx)
> +{
> +	struct acpi_cedt_chbs *chbs = &ctx->chbs;
> +
> +	if (!chbs->base)
> +		return CXL_RESOURCE_NONE;
> +
> +	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11)
> +		return chbs->base;
> +
> +	if (chbs->length != CXL_RCRB_SIZE)
> +		return CXL_RESOURCE_NONE;
> +
> +	dev_dbg(ctx->dev, "RCRB found for UID %lld: 0x%08llx\n",
> +		ctx->uid, (u64)chbs->base);
> +
> +	return cxl_rcrb_to_component(ctx->dev, chbs->base, CXL_RCRB_DOWNSTREAM);
> +}
> +
>  static int add_host_bridge_dport(struct device *match, void *arg)
>  {
>  	acpi_status status;
> @@ -272,6 +293,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	struct acpi_pci_root *pci_root = to_cxl_pci_root(host, match);
>  	struct device *bridge;
>  	acpi_handle handle;
> +	resource_size_t component_reg_phys;
>  
>  	if (!pci_root)
>  		return 0;
> @@ -287,19 +309,20 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	dev_dbg(match, "UID found: %lld\n", uid);
>  
>  	ctx = (struct cxl_chbs_context) {
> -		.dev = host,
> +		.dev = match,
>  		.uid = uid,
>  	};
> -	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbcr, &ctx);
> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs, &ctx);
>  
> -	if (ctx.chbcr == 0) {
> +	component_reg_phys = cxl_get_chbcr(&ctx);
> +	if (component_reg_phys == CXL_RESOURCE_NONE) {
>  		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n", uid);
>  		return 0;
>  	}
>  
> -	dev_dbg(match, "CHBCR found: 0x%08llx\n", (u64)ctx.chbcr);
> +	dev_dbg(match, "CHBCR found: 0x%08llx\n", (u64)component_reg_phys);
>  
> -	dport = devm_cxl_add_dport(root_port, bridge, uid, ctx.chbcr);
> +	dport = devm_cxl_add_dport(root_port, bridge, uid, component_reg_phys);
>  	if (IS_ERR(dport))
>  		return PTR_ERR(dport);
>  
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index ec178e69b18f..7a5bde81e949 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -307,3 +307,49 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	return -ENODEV;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> +
> +resource_size_t cxl_rcrb_to_component(struct device *dev,
> +				      resource_size_t rcrb,
> +				      enum cxl_rcrb which)
> +{
> +	resource_size_t component_reg_phys;
> +	u32 bar0, bar1;
> +	void *addr;
> +
> +	if (which == CXL_RCRB_UPSTREAM)
> +		rcrb += SZ_4K;
> +
> +	/*
> +	 * RCRB's BAR[0..1] point to component block containing CXL
> +	 * subsystem component registers. MEMBAR extraction follows
> +	 * the PCI Base spec here, esp. 64 bit extraction and memory
> +	 * ranges alignment (6.0, 7.5.1.2.1).
> +	 */

A request_mem_region() is needed here to ensure ownership and expected
sequencing of accessing the RCRB to locate the component registers, and
accessing the RCRB to manipulate the component registers. It also helps
to sanity check that the BIOS mapped an exclusive range for the RCRB.

> +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);

That PCI_BASE_ADDRESS_0 does not belong there. It ends up being benign
and forcing ioremap to map 12K instead of 8K, but it is a
config-register offset, not part of the RCRB size.

> +	if (!addr) {
> +		dev_err(dev, "Failed to map region %pr\n", addr);
> +		return CXL_RESOURCE_NONE;
> +	}
> +
> +	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
> +	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> +	iounmap(addr);

...corresponding release_mem_region() would go here.

> +
> +	/* sanity check */
> +	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
> +		return CXL_RESOURCE_NONE;

I would have also expected:

- a sanity check for "Memory Space Enable" being set in the command
  register.

- an explicit check for 0xffffffff for the case when the upstream-port
  implements "no RCRB" mode.

- some check that BIOS initialized the BAR values post reset given these
  BARs are invisible to the PCI core resource assignment 
