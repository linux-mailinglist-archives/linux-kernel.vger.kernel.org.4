Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2CC6003D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 00:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJPWLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 18:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJPWLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 18:11:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0D7303DA;
        Sun, 16 Oct 2022 15:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665958261; x=1697494261;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LgzF4phRd7zzOgU1v900RxZNRYtkGm0GApBfuAYcL7M=;
  b=Fy/N9R88IkfaAXXvvViVUGP0CmHwhHWOocVNCPLaPjjymfwrgfsjqaUe
   6EjLCDWMf6pNNqyD0m2FcRA5TYZbYerBGa/Jt2CYVV3FEgEx/mg5+C5bP
   eMvWq3MD0GI7qk06Ga4QXmUo8gznPJnC/axFonf8NZjah/tmp21wA77Cy
   C3vz+W/vm+01fGGJGKcLJpnI+pHeZcyb9NJz076oFLlWSqvltSqaHgZNY
   YnHM42LfMMOys4CYQCrzSS77gjEqtL4SgaNENAlFGvKNERZaHgLvmsutP
   bIlGQEYIag3LleXO3Jxt8r1b5qfPUzPLMWpO+OmhCblcaUWsUwhE5fZx4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="307324212"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="307324212"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2022 15:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="628099739"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="628099739"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 16 Oct 2022 15:11:01 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 16 Oct 2022 15:11:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 16 Oct 2022 15:11:00 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 16 Oct 2022 15:11:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fkhx0eN2w80i2rWMbS6uJdBFy0orDyJT10h2TlTKeagdKhz/pahvP6hwtV6Ej+RaRWbStGvOeOdCPmY2GbriUcJwOZw8ic3PJpaCGzltxN7MjhJ+EtMrRoC36EFge8cpFgaX5GYXAkk3TPEvjtoDxWhxeSslCR9RA1/gkuMq3pC7P3bLhl6uwLAFn75RWgNce7BRwE8azt8ucqAKGxFLEGvw0NxF4BNwLEC+cRJ+F7lhMAQ2J2Rq6drnbW6ao/S5DaA12ng2Q2Tqsn36/flRbnhTj9As7326WIhZnYROBMXFsRzBUXWav5pLR9B/WpQ6ddUH9Ev3/O0FWIwPdQ9oRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw3K0ZGZQzt9j6TWHHWIUrvxEUVwqSqZLYXQGcftHEw=;
 b=Up/dq1VTCYYzR9kTnkH8Z6EONYZmC6Dh2ABBIkJV/KT3E53FbuydNiMWgAEr3mKkhCy0yKv1Uy/2tdC1xms1Qmhr9HVETFzitozTI0tHPg6/mGM7Ww4ojSTX+XZYXB6+UsFWGJihAaJeRQ236B0HbYImB3QVuygO77y7SObV4OCgrLbLC8Mrmoi50+cCmDF8C00I5NPG7K2s75eEvjJXeTN2yn0L9qlRIZQXAyiTTw4zCrPAYtJURDhII8SKYd4kskz6Hvr24NSr1zbc9VKbc2g2EwLMovwvA5Bh2b0wSyQ1MwoEXOBziwvnS39M0V9HYfZ+GqnXgcQMghztAmdz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6906.namprd11.prod.outlook.com (2603:10b6:510:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Sun, 16 Oct
 2022 22:10:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.032; Sun, 16 Oct 2022
 22:10:58 +0000
Date:   Sun, 16 Oct 2022 15:10:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <Jonathan.Cameron@huawei.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI/MSI-X interrupt support
Message-ID: <Y0yBbjJgqyBS+viw@iweiny-desk3>
References: <20221014194930.2630416-1-dave@stgolabs.net>
 <20221014194930.2630416-2-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221014194930.2630416-2-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1305de-40d3-4d6c-4a46-08daafc34d82
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynF1T6TnWe6tzDpkVEvAZvOS2NmHWvPuKRbLjOKf1zSVfEKXIDI2T6PoP3cVDgMqeBa/G3XzHTYKZ3DLm9e5Gmk28TgkUYhN0NDEeXxdTflMYfy6UQCIe6V3aNBJtBn/yMpkPPi2K756XFa02co3KIOpJscmlN6rjllqbSRfR5AoKfsUSkyyAR7vsJXpM6pXN1y987ldOsCVNvyptOG+UCt+4cU4RHkV8JLrGSHat7hZSplIFLSbTa792DA6o35+Ke3EO6PpjkdKZoenKnwu3+VlVbEOQwIKPVFvlKIrgwlkuHNU6gKigXx3oJKJF61YJn0DSDsj00epAYBH9lyFGi7xaem2t3Jd1wFUmvnkWRnsPl67d35hAEF2tbScHW6p4YNjxgvPoeTQLO927mrjev1ZmK26MeJ0OHxjHMWE5eiZwDH9KgrXdxutDsTbGU4eaFHh7lVnGrmigkohREq5g0gwILSkyepOjnL8VowHUDXPH+6VBQ7Fd4PSFdcJnFByk8Vth0D99obLS4iBfAOK8VXhtMwvnlvhzOS7SLl+8Pg9+x8HinmRNTOmsXB8/lgYTcwFgQCy5NjiMRmtbkk97LJCW6tnxfB+cISGHKZfgkC3X3Yv3JYavDRwpFYP6aR+esgTtGrMXw0K2vxfDl5+LXHE9AuilI/9oUXkW1wDy8WgjiD8nMufl7wURUEUg4559uwBns2b655ZnEV44j69jm4Gi44NGHdOwZIfSQxSsenyGK0SSeZCu9qofqtQXjFqngD6atvK9IX3nkwqz6dLVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(6666004)(66899015)(41300700001)(6916009)(4326008)(8676002)(5660300002)(478600001)(6512007)(6486002)(316002)(9686003)(82960400001)(86362001)(26005)(66476007)(44832011)(83380400001)(186003)(66556008)(33716001)(6506007)(2906002)(8936002)(66946007)(38100700002)(41533002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t1U3i+HoAKIiXhviwsq/1yEw9lrc4QoGzo/Gt5YMX4M8NbM69oS2PJ+gLYMW?=
 =?us-ascii?Q?a4+nFImrBN5W7KtqG+LdmuJosnigr/oT3Wgn4FrGFlnUdlIhyOfMV1o5IqOR?=
 =?us-ascii?Q?PmNTAM5sOXPJ0/yO6gHW13s6Vusp0j8ybvGwHOpErpbnuRTK5ZFZqB3ygQSr?=
 =?us-ascii?Q?+t4lcOtB4PrsGC0tWPpRi/TmB5jygfd9RfO1NqI+AOo0WhwOwuIFG5zREOL7?=
 =?us-ascii?Q?UijQ71FRC7X/DOsu3uFUYv4Kvd9CEdq1tmEyZGKOWu3e2+JJ7RJlrSLGBVCp?=
 =?us-ascii?Q?6nEuqfN19UIjvZrQumD9YzPkNWnlaHPA6imkk3se5w9/zRdfLh+CuyJL5yGa?=
 =?us-ascii?Q?ZW9UM0uKSDkNIJErUjBc4pXfgLOMhY7EyZ2b/26sodQ2KTromHfZanRufJZT?=
 =?us-ascii?Q?m8WgujT7iPW8gM5c3pch//+A5w9xpqnFYZCyDcbtr/Vbe/6B814KBPykCSrG?=
 =?us-ascii?Q?u9T4XO20YaD2Nf66uyO/5P6QS/y2BKKO7hBv2MPQiGiqR7ZlGvEvlwDDJgRk?=
 =?us-ascii?Q?hMlH2YXlsAAhuMpDSrWJkqpFAez6OrNpOuHshGTJv65wu+BCTDzDk6sOA+mF?=
 =?us-ascii?Q?R7o00bfpJ/1RxzYHlqPmY6+I4kItGOTMpslGvZG86C69O0DWGw0RiQ1yXjYP?=
 =?us-ascii?Q?Us8+hNAu712yYkFlgAZ1Yl0YjY7495rUMk21G2gL6WJqExnvgIWgtNZ/Z4HN?=
 =?us-ascii?Q?zASU/KOpDt4NGL5aQCJIMpIac4t/WevVCbokZClZFN3Qfa544IrOp2FmHjTw?=
 =?us-ascii?Q?8/QGqqA6yJF3vmSe78x/fX2/O7/d3G8UgK5rHNZudIJNxDagjRNspWiulQcI?=
 =?us-ascii?Q?iGcvAwGMoZcLd6agfjF5JuAHGqNl2X+SN8JAAR2EAFwiQJpOIhBCiH3ZHoE5?=
 =?us-ascii?Q?YRPwCOeDd8KVvVBVYGSuxV4cAovGm0E/N3AjZNeyGAtgzYR3jeafRjChRVBn?=
 =?us-ascii?Q?h2tjCtloJofY1uRCHnrQr5DC3bCvVuZ2wxkh8hQf6WfEWXA9AszwoF81kxBV?=
 =?us-ascii?Q?E8EtPZWIDc9AnouJzAcDw/vAx1JT93BQLN9EpXYXyyCjFUVI4OCb1ZlaawaC?=
 =?us-ascii?Q?1NQwHkCZ+86DrbEGfdvX+C0fgG9L8Q3xYzBoPjybgmbQ0Jnmoe2o6xwxKFuh?=
 =?us-ascii?Q?/QxRcdJx45aOzQtR8E6D7gllzr6vjf9FYfMbZD4PSNAOTUVlDrA5WQ1fn2Yi?=
 =?us-ascii?Q?Llkcn7p0txKkYTZd+c2eIEpvcnf/GiJNsrs/TRHxWXnlngGvVLjQ6wl9a2sE?=
 =?us-ascii?Q?rSv2Vi9AJBGwqTajz4jfvzU2HhziOQn7nv2PXGwpmaGFxIa1En+gpmcNh1qg?=
 =?us-ascii?Q?lOesUX2wmJWLbSzfmymOZRN7Cz80ANSd9SjNRN56U4suMKtYHEfxmbGK7ODK?=
 =?us-ascii?Q?e+Q8skY5gfXMQrd+F9xzx7VSE8FiVRQX7w2LkBswqg5BDG1JihbwQkEBOuDl?=
 =?us-ascii?Q?1dEZD4p7PJxPtZmtn1Pp92eWgIONZ3HvShQUDT3ror0tbkg5QYc/bD150t20?=
 =?us-ascii?Q?NdJg7PN9DenQgHOw020fqpvU9YntDikl0Nq2q9uHvwLPGsvXTUbR/UsXIL46?=
 =?us-ascii?Q?Hh/35PTvOeEGr6aCwCay0tUAuqe4mhf7Bteh4LB7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1305de-40d3-4d6c-4a46-08daafc34d82
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 22:10:58.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+PlMNYafQ4/4CzzDEc6NQhs7jgOGbQZKS2d6m+J3DpHIFci2ZO4CmjhApwDpsf/vzCoRUHXtn+h4owjW4KnUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6906
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 12:49:29PM -0700, Davidlohr Bueso wrote:
> Introduce a generic irq table for CXL components that can have
> standard irq support - DOE requires dynamic vector sizing and is
> as such is not considered here.
> 
> Create an infrastructure to query the max vectors required for the CXL
> device. Users can check the irq_type in the device state to figure
> if they want to attempt to register a handler for it's specific irq
> and deal with it accordingly.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/cxl.h    |  5 ++++
>  drivers/cxl/cxlmem.h |  2 ++
>  drivers/cxl/pci.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..879661702054 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -119,6 +119,11 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
>  	return 0;
>  }
>  
> +enum {
> +	CXL_IRQ_NONE,
> +	CXL_IRQ_MSI,
> +};

I don't recall this being in v1?

Right now do we have any users who will register irq's without having MSI
support?

> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..ca020767f7fc 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -247,6 +247,8 @@ struct cxl_dev_state {
>  
>  	struct xarray doe_mbs;
>  
> +	int irq_type;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..942c4449d30f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -428,6 +428,67 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>  	}
>  }
>  
> +/**
> + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI/MSI-X irqs.
> + *
> + * @name: Name of the device generating this interrupt.
> + * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
> + *		    feature does not have the Interrupt Supported bit set, then
> + *		    return -1.
> + */
> +struct cxl_irq_cap {
> +	const char *name;
> +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
> +};
> +
> +static const struct cxl_irq_cap cxl_irq_cap_table[] = { NULL };
> +
> +static void cxl_pci_free_irq_vectors(void *data)
> +{
> +	pci_free_irq_vectors(data);
> +}
> +
> +/*
> + * Attempt to allocate the largest amount of necessary vectors.
> + *
> + * Returns 0 upon a successful allocation of *all* vectors, or a
> + * negative value otherwise.
> + */
> +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc, i, vectors = -1;
> +
> +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
> +		int irq;
> +
> +		if (!cxl_irq_cap_table[i].get_max_msgnum)
> +			continue;
> +
> +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
> +		vectors = max_t(int, irq, vectors);
> +	}
> +
> +	if (vectors == -1)
> +		return -1;
> +
> +	vectors++;
> +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
> +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);

Yea without PCI_IRQ_LEGACY I don't think we need any communication about which
type of vectors were allocated.

Basically if cxl_pci_alloc_irq_vectors() is successful all users can assume
that at least MSI is available...

For the mailboxes they could key off of the message number being set in cxlds.

> +	if (rc < 0)
> +		return rc;
> +
> +	if (rc != vectors) {
> +		dev_err(dev, "Not enough interrupts; use polling instead.\n");
> +		/* some got allocated, clean them up */
> +		cxl_pci_free_irq_vectors(pdev);
> +		return -ENOSPC;
> +	}
> +
> +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -478,6 +539,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	devm_cxl_pci_create_doe(cxlds);
>  
> +	if (!cxl_pci_alloc_irq_vectors(cxlds))

This can't be here for the event stuff because I need the mailboxes set up to
find out the message numbers for those events.  I had a hell of a time by
accident putting it here.  :-(

> +		cxlds->irq_type = CXL_IRQ_MSI;
> +	else
> +		cxlds->irq_type = CXL_IRQ_NONE;
> +
>  	rc = cxl_pci_setup_mailbox(cxlds);
>  	if (rc)
>  		return rc;

Can't the mailbox irq's be set up after this call?  Mailbox access during set
up is probably fine using polling, right?

Ira
