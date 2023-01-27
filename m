Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194BD67DCE1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 05:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjA0Ejm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 23:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjA0Ejj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 23:39:39 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449D73A5A0;
        Thu, 26 Jan 2023 20:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674794378; x=1706330378;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2mcTYZlM3HvY/KsUW0SFQenYu5yOt8/iQGDja+0Rj44=;
  b=dXEz4J5IhJFa+kEdFmMZQBIbiysLnCKhL57E9ZaRh4zbsptbYBZA+mOW
   5nvCtUrdJo6sKjRdq2s84Tj4YZ2mekXmaiYYCq9zI8SUD5EANUlgjZA6B
   0m7URfqg1C8/QffrEhvLJtQ465ZCMTu5dsVeFbMOQwTmeOgqpY7KcVQZ6
   YnusRJ6UzvtH80vR/WvHfU68EauoF6uSMU2Qi6JydxtPk7vYhllNmuNe8
   cU3+k+8A2S+xgN4beWsBWOEuCL+R62CYWhyGFj4p1WZCq96ASNEZdLtq/
   gc+m7Ap2k+aTyqoOzWLaWuZV27WHmy6uqZlbKE3wzYr7LmRFuYYoid+Em
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="327038682"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="327038682"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 20:39:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="665142536"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="665142536"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jan 2023 20:39:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 20:39:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 20:39:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 20:39:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JetlrYHLmuw0RvZxtOX2bNwXJHIH+PS0tylLgENvLuguAoWUaToNPOJuluHdzWQDmTTHdw9/+X8yX7Jd9MnJB6RYd3+EsdRo90RWKcz2bSOaNDxqULm8xWtOTUXuywXoJEkfFNHIJOn8pxylG2TnuNKkudTM0GVwGo108Zx1Lu2xGtbW8FDh0h+4o+uAzpjoUUCikrFs7LVJLBR8PH8scraorclURS9A9/3aMRxNwlm/fVi3ZlIUfEkjVjIoaqbdF1mLWoBxIqu/LnQEiVZV15gKAPaExV0VQdqsCK3UwcJOfNs+Y2TpYIP31QjxGtzEZMjP27RGjjLE6ybEDkZcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RWlp6QrwNSh4EiADEdTJjNlPTHWpj18qca/hj5irf8=;
 b=oOPKby0WiYt113KeypyWutI4rWlfr6EE3vHJIh1QW9+S1FpSuLGtXL6/50FPeLu9J8DtGEU+zlmLnb7Ivzlx0+op7N0bbJ+pX2KzzuQk8sAcz+MLfc8687Bc/6+llG7sJb0D9n9e0RkXXyopNuKr8CM3RcmyLaogzMYxjKedqNa+0u5ZNy78Rtiq/9pDCRGsvDE2rpZvZH7WAKNpOTmfOGkDeu6+EOBphUCx8nnfXGXiMm8OfFQ+Td3iVRMLFPoLFTGvGv+D670i94kpu8jTYhCJqN8oxOmvb0pZopOCeHQTD3JsJu3fpuE+6fVvyp2Tpay6/zL+wqSzfmpwjkDYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6367.namprd11.prod.outlook.com (2603:10b6:930:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Fri, 27 Jan
 2023 04:39:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 04:39:29 +0000
Date:   Thu, 26 Jan 2023 20:39:26 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v5 1/5] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <63d3557e6b656_ea2222943f@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674070170.git.alison.schofield@intel.com>
 <de11785ff05844299b40b100f8e0f56c7eef7f08.1674070170.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <de11785ff05844299b40b100f8e0f56c7eef7f08.1674070170.git.alison.schofield@intel.com>
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 23120e40-f758-4f81-ac9d-08db00207a0f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wpl1PwTuPCRijyrx2gvnGgcPlCfApG2d/4okmPwxyyjjlgaBc6gZ24OYMTbm8fjPRjarQuzuHCkGBuxPweNjT5ZUwLIjvvwfGDT9li3brJ9h5OoKoHurB8ctDGgeotntek7E4QHyHhRqOKT8Jf2NXrLjyI1Ax0Wdb6LNfpvkSj3PpWKXBF1eD5yLI8YlDeRjJHVwAgOUQgg1jAl7zMyLR829E5gbS6bGXL9lnotr8ewX/HqSbmGAnP/gn1AG1JgQ4gJfRPPy4PfRAnqmCKNYtePE4WlmONH5zLASqeHrkEQCDBZ8hVLuyO7SpVjwyP2jmbus+N7RCYPKZ5G9rTlEgEM7DtMDekHmG8lE0JptxBVCIriGHPk/5ZrpodnL6vooNxbH7HGO5NIs/75TbEpZhD7WcrYyE5Z/B9y5OuQfNsBcULyLYRxJfTPsSmNYw5xiTi9aF1nE000tRzORcC3E5XIY3dw9w4Jv2Ap/0Czw6utQX6Bndf3LFCRim7Ioh6WP5ObszNEZcI5T4749rFzIlbtR3oNyZvw/VbL3SBSdnT0QQb+GTGV/yeUNMNPt1Tg+eO1B/RebE8OTjFVPir8e77MWsA5QkDUn1/7qQZUUoqmsugRhCdyL0w3dpRLD3bxks1twLGf4Xt6WMFiLXglZGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(4326008)(6486002)(478600001)(82960400001)(38100700002)(6666004)(83380400001)(15650500001)(86362001)(66946007)(110136005)(316002)(5660300002)(6506007)(41300700001)(186003)(66476007)(26005)(8676002)(6512007)(54906003)(9686003)(66556008)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+7gThcYYBy5yKn/smkwpYTw66ec7WF494+HQg8b3fVPH77V0kgQLWhcR9eXb?=
 =?us-ascii?Q?QEf+kOqMeT3JEIjY+p1KIGZ3B0NwbZRM4PDLoppbVSkKjQ5ynY0IvPeXTRa3?=
 =?us-ascii?Q?ZXzxgIL4jMClVA8OzvOS/ylozkqEwE8EiS22qynIpMBnKEzG1uSj8vjEIlB7?=
 =?us-ascii?Q?Xi1fQ+qH5cayw+A3CpY0XQp1KUfBP8P8Xl6FyZMQ4p0zONO5vSS3R6tpwgso?=
 =?us-ascii?Q?8zLl79tzrWxE0mZ7rjzqUxLZG7xFIvRFlxhKx2GiONBNR589vxKxgQxIsm7j?=
 =?us-ascii?Q?4GCFk5nOQTckPrPL6Nu4n7gWMOMfv7zxdgkYhYRu6btNpOW84xLuqKO4dRYk?=
 =?us-ascii?Q?iQOsTAJVdrF0LqBhByCHLuzbk0EbxlrAhLIDjw87zFbl8S15Tsn0Lm/733QH?=
 =?us-ascii?Q?j6GrqdnISPs0gLMq0UiDZG/TVoV2Ah2OTSfZNIvZYJCtRVk8XuWee5ngfETb?=
 =?us-ascii?Q?FcdKbq3sqTepbDORRKsGUDE60hRf7G5Zb7K1lMA0wVMI9S1LjPh0bxN4YFOd?=
 =?us-ascii?Q?duvBBWdo9xNDI/KC9IYLOGBbfIog4WdGiFap+Ak0cBlzxw46I/HTSxj+GXsE?=
 =?us-ascii?Q?VybkfrxeM80IFWZb+QoKh+7DSwW95evpbX4K2oCXp35WO+zxw0evssfxH1Lc?=
 =?us-ascii?Q?GKU8/4ZZVO69XGzPmgERdgilESqOqD+yhq94o7XxgVKufy8Cqgl8bD6tAWz+?=
 =?us-ascii?Q?7qWuC/+Q4civIPgowH6Om+B1Q1i6qwD5avnoFLsqJM10DBYt86nu3adRJ1Km?=
 =?us-ascii?Q?+Q/A6C3bu4xit2ircItgx2vCUJUpr0PNh+x7spzlsAOoOHGTtmce162j1Eww?=
 =?us-ascii?Q?oTDwpxfqDOqo9TZn4qWbjx2dhA4/+Jhf29dHz0hK+nqAvPtfdDVVDAqQqm0R?=
 =?us-ascii?Q?POvyiMGWPOuaZK9Kv3DL/+heTZT7evRrcXfDaL9lRPhl3eSD/1hT+8VvPfcs?=
 =?us-ascii?Q?qqOni/cRF0yopfXgDJtMPkut34klLPLbFMG0VMyFDRUXcYv46Ws1ozi8SEyy?=
 =?us-ascii?Q?saza5ngkTTlSnYSMTLQqw+N0w+UBH3/ZcYqpWt7VZOy5+/wnoMnZdgKeD8zH?=
 =?us-ascii?Q?q31JWm6y+1tAvhwSPbSqZNw3y1z129ZLbxAppXETabgF99UfyVVE8rIxGfR8?=
 =?us-ascii?Q?yIAJNAc4wEE3Fh2mZxkhvWOwCaIOeoxJWFe6fhtWt1HGCUKfqvnlp5u/TkYx?=
 =?us-ascii?Q?5FQfiD2/dRRIuCUxFtNx3OK1Xq/nSHH0Y2pbbYJrGsdVZ9DkEuW0SM7tp8FA?=
 =?us-ascii?Q?Du2r3ZllOHfkRPIJMpwGqiDYrSalfHRKPXVE8556a8oemimrGvvX8zfXOo9K?=
 =?us-ascii?Q?tQ5bjpA9B+5rcOcJdjWnhHIycH7SLKgTsRirpn60dEZSxHMixCFdsKmFQ/vh?=
 =?us-ascii?Q?DA1ijtNNXD6Ew8TFJ7qobiunKHC+SDQWgd042Kt7SFnR0evZ627HA7k0J0vO?=
 =?us-ascii?Q?3L4Hj6USX9cP2yx9vFE2aoKwZn1F3BEaoCm1CZ7EhVHIStPSqcKtSRFnM2tN?=
 =?us-ascii?Q?4fxAM9PTC36OqUcqvz/YWFoVdjudKkh8IjW0rWSoaT2pBvY7ELOhc5V2mNOR?=
 =?us-ascii?Q?35VaoLz/viyW4P7rOMEipC9BPuM9W3DDENkqMhMgZuGcaIgCoAYEoyzu8S1U?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23120e40-f758-4f81-ac9d-08db00207a0f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 04:39:29.2358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOD7V6NfaX3Uodf9+05Rs8oGWXCuz7PIeAg7TOU/4uErrd/ZP+TlyMTC8/lTL7beVw/uuEL/OgiCdaCh+hAoJrHRr/E6Bycj4eko7xB+yOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6367
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices maintain a list of locations that are poisoned or result
> in poison if the addresses are accessed by the host.
> 
> Per the spec (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
> list as a set of  Media Error Records that include the source of the
> error, the starting device physical address and length. The length is
> the number of adjacent DPAs in the record and is in units of 64 bytes.
> 
> Retrieve the poison list.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 74 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 67 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/pci.c       |  4 +++
>  3 files changed, 145 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..a38be141e108 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -4,7 +4,9 @@
>  #include <linux/security.h>
>  #include <linux/debugfs.h>
>  #include <linux/mutex.h>
> +#include <asm/unaligned.h>
>  #include <cxlmem.h>
> +#include <cxlpci.h>
>  #include <cxl.h>
>  
>  #include "core.h"
> @@ -770,6 +772,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
>  	struct cxl_mbox_identify id;
>  	struct cxl_mbox_cmd mbox_cmd;
> +	u32 val;
>  	int rc;
>  
>  	mbox_cmd = (struct cxl_mbox_cmd) {
> @@ -793,6 +796,11 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
>  	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
>  
> +	if (test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds)) {
> +		val = get_unaligned_le24(id.poison_list_max_mer);
> +		cxlds->poison.max_mer = min_t(u32, val, CXL_POISON_LIST_MAX);

There are not many abbreviations in the subsystem, most names are
spelled out. So, s/cxlds->poison.max_mer/cxlds->poison.max_errors/, or
something like that?

> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
> @@ -857,6 +865,72 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
>  
> +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> +		       struct cxl_region *cxlr)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_poison_state *cxlps = &cxlds->poison;

I think similar to the cxl_nvd / cxl_nvb concern that Dave raised,
@cxlds is too close to @cxlps. Just type out cxlds->poison.lock. No need
to call it getpoison_lock when it is already in 'struct
cxl_poison_state'.


> +	struct cxl_mbox_poison_payload_out *po;
> +	struct cxl_mbox_poison_payload_in pi;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int nr_records = 0;
> +	int rc;
> +
> +	rc = mutex_lock_interruptible(&cxlps->getpoison_lock);
> +	if (rc)
> +		return rc;
> +
> +	po = cxlps->getpoison_po;
> +	pi.offset = cpu_to_le64(offset);
> +	pi.length = cpu_to_le64(len / CXL_POISON_LEN_MULT);
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_POISON,
> +		.size_in = sizeof(pi),
> +		.payload_in = &pi,
> +		.size_out = cxlds->payload_size,
> +		.payload_out = po,
> +		.min_out = struct_size(po, record, 0),
> +	};
> +
> +	do {
> +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +		if (rc)
> +			break;
> +
> +		/* TODO TRACE the media error records */
> +
> +		/* Protect against an uncleared _FLAG_MORE */
> +		nr_records = nr_records + le16_to_cpu(po->count);
> +		if (nr_records >= cxlps->max_mer) {
> +			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
> +				nr_records);
> +			break;
> +		}
> +	} while (po->flags & CXL_POISON_FLAG_MORE);
> +
> +	mutex_unlock(&cxlps->getpoison_lock);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, CXL);
> +
> +int cxl_poison_state_init(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_poison_state *cxlps = &cxlds->poison;
> +
> +	if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds))
> +		return 0;
> +
> +	cxlps->getpoison_po = devm_kzalloc(cxlds->dev, cxlds->payload_size,
> +					   GFP_KERNEL);
> +	if (!cxlps->getpoison_po)
> +		return -ENOMEM;
> +
> +	mutex_init(&cxlps->getpoison_lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
> +
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  {
>  	struct cxl_dev_state *cxlds;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..f53fae20f502 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -193,6 +193,24 @@ struct cxl_endpoint_dvsec_info {
>  	struct range dvsec_range[2];
>  };
>  
> +/**
> + * struct cxl_poison_state - Poison list retrieval
> + *
> + * @max_mer: Maximum media error records held in device cache
> + * @getpoison_po: The poison list payload returned by device
> + * @getpoison_lock: Protect reads of the poison list
> + *
> + * Reads of the poison list are synchronized to ensure that a reader
> + * does not get an incomplete list because their request overlapped
> + * (was interrupted or preceded by) another read request of the same
> + * DPA range. CXL Spec 3.0 Section 8.2.9.8.4.1
> + */
> +struct cxl_poison_state {
> +	u32 max_mer;

Suggested rename to 'max_errors' mentioned earlier.

> +	void *getpoison_po;

No need for this to be named getpoison as its already prefixed by
"cxlds->poison". This can also be a specific typed data-structure
pointer, right?

> +	struct mutex getpoison_lock;  /* Protect reads of poison list */

Suggested rename 'lock' mentioned earlier.

> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -211,6 +229,7 @@ struct cxl_endpoint_dvsec_info {
>   *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
>   * @mbox_mutex: Mutex to synchronize mailbox access.
>   * @firmware_version: Firmware version for the memory device.
> + * @poison: Poison list retrieval
>   * @enabled_cmds: Hardware commands found enabled in CEL.
>   * @exclusive_cmds: Commands that are kernel-internal only
>   * @dpa_res: Overall DPA resource tree for the device
> @@ -245,6 +264,7 @@ struct cxl_dev_state {
>  	size_t lsa_size;
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>  	char firmware_version[0x10];
> +	struct cxl_poison_state poison;
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>  
> @@ -372,6 +392,50 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +/* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
> +struct cxl_mbox_poison_payload_in {
> +	__le64 offset;
> +	__le64 length;
> +} __packed;
> +
> +struct cxl_mbox_poison_payload_out {
> +	u8 flags;
> +	u8 rsvd1;
> +	__le64 overflow_t;
> +	__le16 count;
> +	u8 rsvd2[20];
> +	struct cxl_poison_record {
> +		__le64 address;
> +		__le32 length;
> +		__le32 rsvd;
> +	} __packed record[];
> +} __packed;
> +
> +/*
> + * Get Poison List address field encodes the starting
> + * address of poison, and the source of the poison.
> + */
> +#define CXL_POISON_START_MASK		GENMASK_ULL(63, 6)
> +#define CXL_POISON_SOURCE_MASK		GENMASK(2, 0)
> +
> +/* Get Poison List record length is in units of 64 bytes */
> +#define CXL_POISON_LEN_MULT	64
> +
> +/* Kernel defined maximum for a list of poison errors */
> +#define CXL_POISON_LIST_MAX	1024
> +
> +/* Get Poison List: Payload out flags */
> +#define CXL_POISON_FLAG_MORE            BIT(0)
> +#define CXL_POISON_FLAG_OVERFLOW        BIT(1)
> +#define CXL_POISON_FLAG_SCANNING        BIT(2)
> +
> +/* Get Poison List: Poison Source */
> +#define CXL_POISON_SOURCE_UNKNOWN	0
> +#define CXL_POISON_SOURCE_EXTERNAL	1
> +#define CXL_POISON_SOURCE_INTERNAL	2
> +#define CXL_POISON_SOURCE_INJECTED	3
> +#define CXL_POISON_SOURCE_VENDOR	7
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> @@ -441,6 +505,9 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +int cxl_poison_state_init(struct cxl_dev_state *cxlds);
> +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> +		       struct cxl_region *cxlr);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3a66aadb4df0..d21357f3eca0 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -482,6 +482,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_poison_state_init(cxlds);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_dev_state_identify(cxlds);
>  	if (rc)
>  		return rc;
> -- 
> 2.37.3
> 


