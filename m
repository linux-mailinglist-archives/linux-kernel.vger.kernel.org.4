Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB36003D7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 00:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJPWGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 18:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJPWGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 18:06:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6971B356D1;
        Sun, 16 Oct 2022 15:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665957991; x=1697493991;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tjsCNJLy72g7ToGVhZCS8H0KnrNC5u36rH/FmFE3bzE=;
  b=enbRrFddhOutZ6w/b9O1LdNIx1Uzaz8azMuTcgv2rDjdOTnovHCkKvD+
   iwQgFMg2+hKFlTfp2vz4eg2Mc2YKFkM44Y4Ro/lu2WKfUYYdwM+49DLBv
   TenOKouLSWkDoFyAvI11YyYV/7mdxSSwbvrhvEh0cYz1ECSLtyL1Zup+l
   2rxgg2KGWsnzqeLGr+S7R3k82OvZ+dXBBO9zXTntGC4HHwjwtwlAUsZ9L
   3JfSml+vokvx8jIjci9A4mFQtN2+m3cd3YCb8E8TzQQuZ1sOEMpy9pNlv
   kXo/3R6ouDCYsMXzilz82ofo4Qqori3wgFHn54k2U/4puWYeWMOYaXK60
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="286056822"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="286056822"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 15:06:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="659148182"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="659148182"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2022 15:06:30 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 16 Oct 2022 15:06:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 16 Oct 2022 15:06:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 16 Oct 2022 15:06:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bylbYYdav9q4ZsqX2ff0CkAaV368oVVkpgiK88hRSxaKVOq1+2KnTj5affZF80fIj0Vz3SU8fDHK3nBXeqsUg+uR1KqD7Cam1HdRPxmynynmtiSnw58M59yaHpCvh5JDQ2y0rbOBPCUNZm56aEFlEdID3INbYVEBKRXOT+5cRVRZWJOThlW0us8wCUBOMAORGGDQj8zDl0BMdUh5BANLMRMFimM+JbaBv80knRSPuWQfO9XE7QieccbTiNmgr/78DF8MzIqTi8J6UX3BEBmevgZysC09Qg7tMcEfrBLIDC2oXMCzXdXGl39BwRrlpSt0bIA8JtnIl1jL1NZeSDECMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsNPxgTFdMEess7R8ZA1ZxR4ugOCtXuKKkJnCys4Pw8=;
 b=mSVkXQ1IDOkZWNc8EZgF7qWkSwTpfVF28XYMsuHs83cdNUTtCuB3t24rt5mmTkrvyc4YfPnbMhpy183OKH8jmpx/OvZQlNsISzpJQ3QvDq9dmR3WDdWLWY1S1ZgoCfB8GHnYITxYDRmxaLisasS7TcKsdOzUybmOoLc9/4kwttSKXsRj1+hRaM90pmjxjavs0LUgbG6KQu4u7M/uxo33eVND+qQoX7tGGfnYWOnH2r8cfF6bfqyEjy02iclTEgrukysYsA0jq8tKeTKL6gQjwj4Eo3kxqlc1E17PbXFgsfc3C07XS+02q06VcBnWFEIWZcVR7jJslw0D1VZTuT1LQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB4966.namprd11.prod.outlook.com (2603:10b6:510:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Sun, 16 Oct
 2022 22:06:27 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.032; Sun, 16 Oct 2022
 22:06:27 +0000
Date:   Sun, 16 Oct 2022 15:06:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <Jonathan.Cameron@huawei.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/mbox: Wire up basic irq support
Message-ID: <Y0yAX1fTCHhKKzeb@iweiny-desk3>
References: <20221014194930.2630416-1-dave@stgolabs.net>
 <20221014194930.2630416-3-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221014194930.2630416-3-dave@stgolabs.net>
X-ClientProxiedBy: BYAPR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:a03:100::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB4966:EE_
X-MS-Office365-Filtering-Correlation-Id: 2754f605-e514-416b-ddf8-08daafc2ac39
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNqSCXfv8/i4hu5nxgJcD6NvsJAG/oLfbqCxCCZBoxcgTt23W1lU8/VVBz4zWrrv7xxK2niGypu793nPeqw/8BYlCjA6GnuwkxhJliy/1SbniOXSA8kOB6XIB4TF5nGxEZWXmrygeqC8v+7q5eyTA0m9nOqII3mlnU14APBeaazAG3OXsc0rwuop2sNRgLgDatspKjiouAQ5Mmw7DBQzRRKOj37yYgiHv8T0/lWqBiU+MCOWC+ULW7KiVB+mb/Ap1jMA98UVYUekfSlLdMBOA89FN+7BhpRYQ577We2BQMH7MJWEKRimHAJwzqPZuQX8QFJgOjmXddqYFCN15TR5+z2q//9blbhrPzpfamEWKBpJlOVYTAEUfFJF3rAYCJK2I/9SUb1ZyRz8kXLEbnS0yhPouwpKm7gEFI/6kh2y8MqTKDibXx8vfJ7oVa6SbmrVF1dPnr3d7E8gIFIYXgxqWr+xJL7qTGJIu17MGAYTwZlKWfgYHcJupsDI9zK+kj5eeleykLycnt3ZpxSQKL4fOg+c/NfO13wj7bA02OSHT2EXNO38SovvztzKwVv1+RyKCBDnbUQmaLtgsul/bmsLG7NA8TCJkCQPn/BEMkFsC+TON8feBDkO/rALfuCn3w1LIzOsADAcc4MC2YzoaFtrPpe/dhT1lFMtdqeRx8ypj26ByDvxjxBzSG8x2KstxjsxVu42Yu/I06E5W3hJUdioGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(86362001)(5660300002)(44832011)(2906002)(38100700002)(82960400001)(186003)(83380400001)(6506007)(316002)(478600001)(6512007)(9686003)(6916009)(6486002)(66946007)(66556008)(66476007)(33716001)(8936002)(26005)(41300700001)(4326008)(6666004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GyHMc7RSaCqTZfRLrkqKokdVer7aldsHcv6Uz9UFwhHtFoPUtb73sxqXusxy?=
 =?us-ascii?Q?ghTcZcbY3AE7OAPGW9ztUIEQDfn7FvhGCl7OvxMH2v7HSHpVJ/NEWD1VlXIW?=
 =?us-ascii?Q?CGFZOVz20G2mJw8WB6a8gtMeE8hSyUis4DhRrt3r0A7h3rw4TY9k/jzE/Xr6?=
 =?us-ascii?Q?RQFGuV0aYnqWpGfDxM10jhxERudEwZpjyLCe76f+oC0q+M2/vSz5MWtvYxHP?=
 =?us-ascii?Q?Ids/+285WE2QLKpripJ4uPr81o+DMa31ME463ikZAEkhmhU5SNvPe7U/vMD0?=
 =?us-ascii?Q?QCcU/pHSOPaevlDj5jTqKmmhcCxP46AbW2bRW5cbmoz3tvCD6cdHO1E3WJlq?=
 =?us-ascii?Q?YAp+JeJV5sCoVO30vg9aJ/4KYt07lUhjJ8qeu0lmDibgzRm84f0AChKnjXnr?=
 =?us-ascii?Q?47i0IYhl9rgp0O8u2yuuV1nThAT41Rzs5gE1xucURoZuLk3WkctuXACypiE3?=
 =?us-ascii?Q?CC3K2vus2zJSUCO3IhEg4c0GcsQDOIBdn7H2McVVtt+bm20yAd6eFNcPIiCg?=
 =?us-ascii?Q?GMWL1IRVW4bXbHX7XBRkyvqB4VaGkodvnzxdBJjfhtK+d65a5x0E1iTinCCp?=
 =?us-ascii?Q?v6agy9xCQkamgSOp7ZpbUME0tvSRfvpVMnmRgVdl0WqJ+Bze6ob42UrmW8Lt?=
 =?us-ascii?Q?S+rnQvqswuhqZguwtu07g73yR/ulf+msT0+jFUpSxtJZgMA0Xcck9f0hVNDJ?=
 =?us-ascii?Q?Ex5p1geJarNnF2e8Brk7LxUb7h8FUw5OfWyfT2GUn0m58VIGMHHFUyRZZlbI?=
 =?us-ascii?Q?IfFLayaXbinNvtKu1itTZ/wl2jEh6ihVac9IRgNuhimLay+Nm2lf12uz62A2?=
 =?us-ascii?Q?xgAkxES99oin+FZY5C3lFQp3MrvLlrGCwwAI2aDVgYc4W9RIdsUCvaDro65u?=
 =?us-ascii?Q?XSQ1pQ74WaipbGjFfSGTvzT3D2ECOCpe4tC4UlJF6SWK6J4H/kVRdYJHYEJ9?=
 =?us-ascii?Q?3uYP2wJ7KkZf1C5X4KXL87FOEaBmYUtop+UXzI2ijmovRem+G+r4qarwyTpZ?=
 =?us-ascii?Q?rC00zRoJYu/U9IxnLjHY/AY0bQu1wFQPP+t1Mvqxa/+D2wPEu9C62AmWD14N?=
 =?us-ascii?Q?zQ0tKaQeC/YsCT5yN7XwOL5LKCUs8CxF57PC/8SQR/Y6HH0LN9RXaPmUiq2a?=
 =?us-ascii?Q?6eyBQ3zbTFT04Oo1e15m6Gb3R41XR/83v4Actfm2s/niytXwomSAJvnVeyPM?=
 =?us-ascii?Q?UPAKOncCrDiDbzEf7Y9G4mgLGjMG57nDf2S0Mu6Py9T6v0BjZdnOpM3K9GaD?=
 =?us-ascii?Q?sMXe2SLsaxB0CwI1sxZX0gyhn5p5YdXFWpcGXF9j7fMpilT5vnn1IqEiOmY1?=
 =?us-ascii?Q?yefQBaK5CAiLeOHf832mA9bIMpg1hrFVfGuiHK08rgqObBHHWq8bMbQKKgw8?=
 =?us-ascii?Q?0v7muK/AyjahSoBtqDYzzzSpEn2UwHXlzQ5XGNtiJYL1C3UvbGlbi+fxEpln?=
 =?us-ascii?Q?Q0djoZgFXADZNTInBFNwK1T0sRBdY+CqVhmOcEjhtPG6IeyfT/UuUc5CkUne?=
 =?us-ascii?Q?bkM+FG5CEDJKo9igxv8vR9zmu2MVCKCzb8Z8EZbHsmYqDryN/uUy6EorwKiR?=
 =?us-ascii?Q?FMY+Jg8ExMY7Uug9nVZF2msiFT4I4PDeb54SPTAv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2754f605-e514-416b-ddf8-08daafc2ac39
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 22:06:27.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSTK7pDKMT1LmAYxJ3k3q5SOGL3C6+zrz0bo+tfunZ33OfBzfdOljV6Xo1tzwjKPu/fU8rDkULdEwll9EKrvqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4966
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 12:49:30PM -0700, Davidlohr Bueso wrote:
> This adds support for mailbox interrupts, which are needed, for
> example, for background completion handling.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Note: We could also handle doorbell irq, but not sure this is
> actually needed.
> 
>  drivers/cxl/cxl.h |  1 +
>  drivers/cxl/pci.c | 27 ++++++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 879661702054..d15a743bfc9e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -140,6 +140,7 @@ enum {
>  /* CXL 2.0 8.2.8.4 Mailbox Registers */
>  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> +#define   CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK GENMASK(10, 7)
>  #define CXLDEV_MBOX_CTRL_OFFSET 0x04
>  #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
>  #define CXLDEV_MBOX_CMD_OFFSET 0x08
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 942c4449d30f..6e18ca3e551f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -51,6 +51,20 @@ static unsigned short mbox_ready_timeout = 60;
>  module_param(mbox_ready_timeout, ushort, 0644);
>  MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
>  
> +static int cxl_pci_mbox_get_max_msgnum(struct cxl_dev_state *cxlds)
> +{
> +	int cap;
> +
> +	cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> +	return FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);

I'm not a fan of the irq_type in cxlds.

Why doesn't this store the msgnum in cxlds and...

> +}
> +
> +static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
> +{
> +	/* TODO: handle completion of background commands */
> +	return IRQ_HANDLED;
> +}
> +
>  static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>  {
>  	const unsigned long start = jiffies;
> @@ -271,6 +285,15 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
>  		cxlds->payload_size);
>  
> +	if (cxlds->irq_type == CXL_IRQ_MSI) {
> +		struct device *dev = cxlds->dev;
> +		int irq = cxl_pci_mbox_get_max_msgnum(cxlds);

... use the stored msgnum in cxlds here?  ... and use that as a flag if this
should be set up?

> +
> +		if (devm_request_irq(dev, irq, cxl_pci_mbox_irq,

I was using pci_request_irq().

Is devm_request_irq() correct when having allocated the vectors with
pci_alloc_irq_vectors()?

Looking at pci_request_irq() is uses pci_irq_vector() to convert the msgnum to
the irq parameter of request_threaded_irq()?

Ira

> +				     IRQF_SHARED, "mailbox", cxlds))
> +			dev_dbg(dev, "Mailbox irq (%d) supported", irq);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -441,7 +464,9 @@ struct cxl_irq_cap {
>  	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
>  };
>  
> -static const struct cxl_irq_cap cxl_irq_cap_table[] = { NULL };
> +static const struct cxl_irq_cap cxl_irq_cap_table[] = {
> +	{ "mailbox", cxl_pci_mbox_get_max_msgnum }
> +};
>  
>  static void cxl_pci_free_irq_vectors(void *data)
>  {
> -- 
> 2.37.3
> 
