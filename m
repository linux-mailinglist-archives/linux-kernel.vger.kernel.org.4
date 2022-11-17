Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB6462E52E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiKQTXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiKQTX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:23:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A275685152;
        Thu, 17 Nov 2022 11:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668713003; x=1700249003;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d+KiMbXuxH2a6jmjfwcI4CxcJZhMpaq5iYUlZwSCWc8=;
  b=d/s/fGmwPxkeK8XLKk6dihk9GyHzhLaUj+Uz64S59tfqZ9iNTNAu2joX
   8CdzJUL1a5e0WGPY2aLTJjM63deuMIhqjePtGPVgM20uPvyTaHGWT2QaW
   +gw94Us3ayl3bE4mmL6odv5cESzbLCw5ggQ4cBRatLGCnv1tCy3TNJ5Cb
   ywIBAhKCDJjKzlrzdMV98kBIv+2qLD5tKZlgUngeH5FeILM94/EIWbMi9
   QFBVyCAvpC1IQB/wmOT6XbRGJgDjB1Lz8sa2MLq01IRx29/mm5s2WCK8J
   hHGCtFXhZvnUWDDHfQbcg6HJK5gURByFg9j3ouuIjCp0xf0V6FjHIs2Ea
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="300484231"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="300484231"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 11:23:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642221582"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="642221582"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 17 Nov 2022 11:23:22 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 11:23:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 11:23:22 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 11:23:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncDGlKC1p9v+jfhKJ8309UJ5beJj7/D09PJMhWJiPHRL+CSDb7rl4rkmMW4ht4mYM5Uvcg6J9C4Bw2ASqV0/8V7sUc4+Oz//9fYYjeftCA/S00dRgDwtSkgk5InL06C10jCnIGbz5kfytzfstM/Pl5HX6/jWEAic5BGSe6Ip/k1+GI8NH40lnl7oHnFFoj72u5w8ct5WCxTJDRAFF/ahf/KYDIb+QlmH4wOl9oLO6U2q6H7d+0bjlGXiDTPF99mwfiOesDN3qecR3V/Grx9cywnaKVTjKxmTQm1ZdYtsegwouiCJc9/Jc1z7w2ozo3cz3DtHwZ/h7WWPH5VZw6/Qog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y060BLqJrkYXHz98ucA2F/agSanbOqzVBFL+txvrGOA=;
 b=DriE6VQFK6A45MiZy7EclcSUAVCtBNn7Nilpbo0qIz5XcBtUb+MHfVIc8lI1MYboztDKDKuJucp+lqPLQiwkH43CW0vphEYoTUzpfh5KwNALuKQ5Q4oYjFoWCBA2/jhJFt9ozPnj3MDS8XIPLgSm8zkNShHkRq/I2+s8rBM4wpN+NnfNwe74OBMYGZAwhL2OaCZElx9IA0LG/fouwiCG+2uLi6Lpw5AoKnSBE9WdtqiUZXZnDBbIAAKG37QXGWg1rfwBXFLsLwGg6MD8095la2jsM6lg5Zu+u6ZylcMZLSQesHloeCIYsNJxAhCPAJNjA4hBd/tKiZZRoL2FjYwYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY8PR11MB7289.namprd11.prod.outlook.com
 (2603:10b6:930:99::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 19:23:18 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 19:23:18 +0000
Date:   Thu, 17 Nov 2022 11:23:16 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v3 2/9] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <63768a244a14_12cdff29469@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-3-rrichter@amd.com>
 <6372b35953580_12cdff294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ODbwk+12JvWyhJ@rric.localdomain>
 <6373d24866bc9_12cdff294e3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3YoBpIsgRRbRyLk@rric.localdomain>
 <63766d77d1ece_12cdff29499@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3Z8kZym/37P6/yg@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3Z8kZym/37P6/yg@rric.localdomain>
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CY8PR11MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b64b0a-a60a-4699-730c-08dac8d12ec8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +U6nTEdp97aHqBKIUdKovG3WkPoMnWC58HVidInYL5jbk1NDmd2i/E2cAxAwVJ8QQALiZekM+YS9y7tAQBN56CA0NvJimgsDqKttSzkSjqvv7+C+/nhJY97SgIRhBNP+BUDDNlR3aimEmcp3mZPnx5/5zvL51KLH/MC9TnTHTH/mselE7/X5zQSOJs2Ttg25V+qOU7P/L90xBA3mH6c/I2oaRH+ld6w4q1TMhPz6qVpt3BRXINkn/QhPOllntidUO5QzkqUUpsykC9yueQTyCg1IL84gi3GbNIlASy4fW2G/CAn5BTYBdoOxcccCMp+qSpL6yvll3uSulb8wzfVCySnP4P+TEToFk6MDj/5sVtXgp5nH8bpcU3vfcZsbluSYiPZzBrvg1/k/P0Apq5FS4GOKpOr9UGfdv8AzI1F1aCWrPSVIB3Z+2iEZNIiWW3s4Kh8umV2qDO4Xp3GnonJYw3zrpmYXygWKyTcw5y8154n9wb1yChztrI12/0bQJA505D/vYpNntnNUxRjUU4eUeNMg60TYjH0O9eBTMiGPId/OVuc+8pm6rrE9LHL2AfPscO8v/Q7QVEUSlRewqDvXmOfmsA6QFhiQk/P8WMMVHPyeShF1+pN4bjq5eL6NYrdk1nnlGoyGwk73C6CrkinKdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(478600001)(6486002)(41300700001)(26005)(4326008)(66556008)(8936002)(8676002)(66946007)(66476007)(6512007)(9686003)(5660300002)(7416002)(186003)(53546011)(6506007)(54906003)(316002)(110136005)(83380400001)(2906002)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?scQtsq1T7cS6U7hIusPuZ+rlXSMzCBWDSHZNJaynrDbMmwhP/g5e1gKigfqW?=
 =?us-ascii?Q?hxu4IXwMbjU9J4u+gMyla/7Lh4/RDeNXsbTHlPoKM3TVS2JtpercXkJ7/9dF?=
 =?us-ascii?Q?McdSr/3TVCigv0WJR7qAkbJmrQNAH8Shx2EalkUneSBNNh0K2zzf2vn9q1OC?=
 =?us-ascii?Q?lwITUUq3u/hmqoPA7Al68fNFrKIeEzFMsTCVUwNZ3/D+CVBTpBYT7W9/jyXS?=
 =?us-ascii?Q?nbdyPuhjandvYobCxSd9PFVVdpOAngkuYV47ChheuHodrR4/pLT57IUdHSy3?=
 =?us-ascii?Q?/tj7fVglbJjxxGAKQcPWIFbwy2TlNIYMF1EqZIWwc4YJdxux5ghwU6CIKKEa?=
 =?us-ascii?Q?YSKkfEs0DjS98C6bHHOKPaZq5nPmrPHsRBon1C0igxrn2YadodRHBZW3EWmv?=
 =?us-ascii?Q?E0XG2QSXmIN2vzFxjkcVj6eeACYSXC/5LAD+1P2wqCGokz1iUJ6HbAZWnPdf?=
 =?us-ascii?Q?6RE9AOcwLBnJO3vNfxIQVwn4bcS/qIHJyBG9U3Jh7SnAbxnpJJKEVWVsKi/G?=
 =?us-ascii?Q?On6pdSemvRBTd3yYdpS2bIInpyJB1exDk2h27jNjWScqcGPJtQmNCd86V4OH?=
 =?us-ascii?Q?FQ1858oAtAyOmq6vb4R3H4NT3qkwQEi0jDq0VD8K1A00c7+5Y1rS7nF22A6N?=
 =?us-ascii?Q?LvB7wHiGRfOat++rc/ttOg3efSQhZoBi8oCx5PxDMCCNzU8ZfjpjZo/8lK1X?=
 =?us-ascii?Q?wdUb99idc5nbUv0W0hea/gD7iLHsZJaYFE7bkAgjln3tWffDvf+vajPZqrtR?=
 =?us-ascii?Q?STrIrb/DYuHVWfzYEL3rK8JDiaplM849K0kjmyHe5BeBlCxlZlQFNS0sJZmo?=
 =?us-ascii?Q?s2J3Wso6vL6YTvxpWvB4WEpyX6/eKvRYr3KYwVnqorGFVNfRXcISt2FJUppN?=
 =?us-ascii?Q?2WNEyxSjVUePVxuv1Z/GWOiLGX3qvgPUz4d5J1TrunwqabTDnstqT90y5jCV?=
 =?us-ascii?Q?IGF12STRx6UNOF26JTKLm/0tF4wWj6r9ep2wbudO3vcNnVQHRK3bNOAblQZH?=
 =?us-ascii?Q?payciuiqVeI0zZp/8yjGLlRTzBUquF3fzt26kVSoT/IysTsqsmLMfD2Y6utj?=
 =?us-ascii?Q?1M3jssIV3+UhifKVNK7hXPiK1i2lweU3eZFlx9oLl39uowBDewkqdniXrPq0?=
 =?us-ascii?Q?+ZB5Q8mpTYDqP7xCXt6C6ghW/nYGoNP4MPHFrXbG82upZvsvqZZbgW+9dF4q?=
 =?us-ascii?Q?iyHVDconQSQDCpDtGLsuabaoqV0RR14oAOkWjAJ7D19FyGkF9TDVIvVWZzCw?=
 =?us-ascii?Q?i4xiPjrEwH5oih818DFUifmGm7cTuPbs9BhHTEC55+/ib/sLM6BFBg1kuayy?=
 =?us-ascii?Q?TZIXLPjZEn/oPCWtZbKhleraAXz0jvCP2ZiPFRdTcl4jK5KoODOFKOcN/BqW?=
 =?us-ascii?Q?0z3hZd1hL4+Mxtchtvi2fVaSDkwvmJbZp1vy05yY/NOmE+pz5aNnGnmkSn3E?=
 =?us-ascii?Q?qz9GawK+6y3kuo4Ej71mgTCVOumayE0sVkl9V+O80//4aS2ecXGV51f+nt1r?=
 =?us-ascii?Q?5lnIQEUIJz93uoaLbQlMRawNAHZEz7TW75l1DC+r5P+biy07Bbidm/JkPT4K?=
 =?us-ascii?Q?7BrvJ8n0Cdug56s4i+AHED4cP6gDA8e6EcEbSMFQLL7KJnrXDj+RHx7dLwVM?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b64b0a-a60a-4699-730c-08dac8d12ec8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 19:23:18.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7as6IJ4CU2lvj+DuE3MJn1bi8Tbv1NhlCnudVSxCxszQXGepX+0ovU6ZSD1SZHqGovv4XFgvAZE9NgPmScVFlKTYf7lzHf5CDw2v6YSYwxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7289
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> On 17.11.22 09:20:55, Dan Williams wrote:
> > Robert Richter wrote:
> > > On 15.11.22 09:54:16, Dan Williams wrote:
> > > > Robert Richter wrote:
> > > > > On 14.11.22 13:30:01, Dan Williams wrote:
> > > > > > Robert Richter wrote:
> > > > > 
> > > > > > > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > > > > > > index ec178e69b18f..7a5bde81e949 100644
> > > > > > > --- a/drivers/cxl/core/regs.c
> > > > > > > +++ b/drivers/cxl/core/regs.c
> > > > > > > @@ -307,3 +307,49 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > > > > > >  	return -ENODEV;
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> > > > > > > +
> > > > > > > +resource_size_t cxl_rcrb_to_component(struct device *dev,
> > > > > > > +				      resource_size_t rcrb,
> > > > > > > +				      enum cxl_rcrb which)
> > > > > > > +{
> > > > > > > +	resource_size_t component_reg_phys;
> > > > > > > +	u32 bar0, bar1;
> > > > > > > +	void *addr;
> > > > > > > +
> > > > > > > +	if (which == CXL_RCRB_UPSTREAM)
> > > > > > > +		rcrb += SZ_4K;
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * RCRB's BAR[0..1] point to component block containing CXL
> > > > > > > +	 * subsystem component registers. MEMBAR extraction follows
> > > > > > > +	 * the PCI Base spec here, esp. 64 bit extraction and memory
> > > > > > > +	 * ranges alignment (6.0, 7.5.1.2.1).
> > > > > > > +	 */
> > > > > > 
> > > > > > A request_mem_region() is needed here to ensure ownership and expected
> > > > > > sequencing of accessing the RCRB to locate the component registers, and
> > > > > > accessing the RCRB to manipulate the component registers. It also helps
> > > > > > to sanity check that the BIOS mapped an exclusive range for the RCRB.
> > > > > 
> > > > > Right, that is missing.
> > > > > 
> > > > > > 
> > > > > > > +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
> > > > > > 
> > > > > > That PCI_BASE_ADDRESS_0 does not belong there. It ends up being benign
> > > > > > and forcing ioremap to map 12K instead of 8K, but it is a
> > > > > > config-register offset, not part of the RCRB size.
> > > > > 
> > > > > Note this is BAR0 + 8 bytes, not 8k, and it does not map the whole
> > > > > RCRB region but instead the first part of the config space up to
> > > > > including the 64 bit BAR.
> > > > 
> > > > Oh, sorry, yes, my mistake. However, there is not much value in mapping
> > > > less than 4K since all ioremap requests are rounded up to PAGE_SIZE.
> > > > Since an RCRB is only 4K per port lets just map the whole thing.
> > > 
> > > I was going to keep the ranges small to avoid conflicts with other
> > > requests for the same page (though request_mem_region() was missing
> > > yet).
> > 
> > What else will be conflicting the RCRB? Linux has never accessed an RCRB
> > in the past as far as I can see. If there is a conflict then we may need
> > to move this mapping to the PCI core so that it is managed like other
> > mmconf space.
> 
> The capabilities (PCIe and DVSEC) could be used by various subsystems
> and parts of the driver. I am thinking of the various RAS caps (UP,
> DP, CXL, AER variants) that are accessed from different parts of the
> driver. Of curse, access could be delegated but else there is the
> option to directly map and access that parts. In the component reg
> block we already see issues with that broad mappings.

Sure, but lets cross that bridge when we get to that point. Something is
broken if these competing usages can not at least have their own page
mapping since that limits being able to hand out control across security
boundaries (like VMs or userspace). Any ioremap less than PAGE_SIZE is
somewhat suspect.

The cxl_port driver so far seems to be sufficient for owning the entire
component register space.
