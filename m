Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D3E6081C3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJUWj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJUWjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:39:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417FF3B97E;
        Fri, 21 Oct 2022 15:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666391992; x=1697927992;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yayjkxL0vloEgJJqszNPhwwxb4l8Nfp+IHwukQ4RG1c=;
  b=jXz2zTBqKtSa+OFpYOdgp2ibS6Mlni/vs0PVAN3If9aYSS1TRsyS/qVq
   0admGfiZZpTvBJd/2by0zPWzGnfzqaZgN0BYXE/WnPZ7U9rSM2Qqrt+Sx
   44ptA2DuL+ab5JTm1eOOGp19eErN9eqwAzAykcu3/0g3IYT6+3BxEAtKW
   RB1gHprFePQY/XshLAktFFFFSUPGKv/JnO2LEvnX1BL3Lnkh0lRDPataV
   fCCotikfZILF04qW9xt+Sv8F5h5Jaz1l37Tx0Q6wVT+sQRm0EU9h2xy0D
   FGV3lz89SpAfru1klhq1h7S8V8K7dOXlds16qsNM6E6lZpcA2jpXhVdfP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="304731191"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="304731191"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:39:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="608551616"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="608551616"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2022 15:39:47 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 15:39:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 15:39:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 15:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOAHBaUnIHO5is2zG14YyguLhoJZY2PKd88QlJyx8ZFWPme1KMSOW8wjXA1ehuWysYP930ak1ZAMSbZWrzXTU1QwEhOf0tdsmJZMTEU8TYql+RED1AA465wH4J8Bkg1iyuQlAJ5RmhFBuOadS0SuunTwbeGY3FS1qUdGMIIG5wkzuQYu2duSbnE/TEQx9BEX2ZwHPYO5jF9xRSIMv4j1vPx82qJ95IdQArJCuI+f6ItNFeAq+c7FAnRCco88pmqr0794MziXw0whtb7jlIu4Gx+R/eFjB4AKgCW0Eq2nWvayqocqObp2WI0Sc7fXDn1r9KrhpL7YygsUOBAvZh8N0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2lK9C4Yyz7lSN+0kau8UAlUshVHiadycQGuG9PWqTM=;
 b=O5lfifZ0C1csEavUPkf68x3bCRevPk4aJYMGejT/vcV1ReBROesxa9vb7nT1SEX3Hop1ISKtGFTtx8gaBmq7hupbM8eYtBmlm41/qhy2GlH0geu0E3UtbSaNYtRxS6gMY3HlnimQHoDZkldkDBFdArbyy8x+tN1dThnlwBagmD6FVcH2LvXNZh0gxoo6weW3ypXEUXsWa+HIxmVtiWFpIo2/RS1MsvYyVF/jAwyzvCP5vn3tRAlYpfdQURrXfU5jUiWJGRcrXVmrwogQkulg4dA3cx8iPFh8MxzSjQaFKIXD6OPxy4iy53cJb1c9sptndE8liMGUO6vzVU91h6o0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA1PR11MB6784.namprd11.prod.outlook.com
 (2603:10b6:806:24c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 22:39:44 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Fri, 21 Oct
 2022 22:39:44 +0000
Date:   Fri, 21 Oct 2022 15:39:41 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>, <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 1/5] cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1
 support
Message-ID: <63531fad96dcd_6be129496@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <20221021185615.605233-2-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221021185615.605233-2-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA1PR11MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: b8645669-7d30-451a-d501-08dab3b52666
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4SY+U8akyDpsUqaPH14GdOfDk5enjeg9whyJmFkRLwmZoQkzJzOqy3UfUxsGSxx7rDNHCSR1y5FZpKicKTnVEnz8yyrm7U4FARimmxykcMjCXVuUKDzkfwaw7Av22PrvOy+x51Y5DXRF7vjdJj+AXS30CgqgTJi3XTFQveC6rqloR3kw4AaVLMlbPIty0ZG2Xuj4WDHlYyZhbIkFG0vb28TdNlIXzvWIyampARGBNSRxOjAx/VAOogZdL3pdBlpVdFrcqgVSkBT70xzO1rynC5NRydKMPi12S/6WqAC8bbw9IC5Q3I5MlrV8Fz25Abdt+n2t3xBHFwBBYTTOq3UwHflxDqcMR5rPJPl5Kivgl8YUTybY3RRICMwuXvK1Ddih2oIwcYZEXCiFD1GYJYcre1qKa1RVVQ9RJdrbLbpOaXKSHQKkFg0F0LPRZ9mx4cp3cdpdyrfaxvT9JhjCcbz3stIQtmuyECBw0VRod4+lOd8snVVK7kOSmMenoP8hUugKeWqPXbLx0XG05Vsznr6+LxfZ8sgYCW2Z9GTyIs25V/+zUDxj2ZvIH31LVhht3DBwqylQIotyS3ddrOpH89439OzNUspp3g8J6oSFihJ3jTTuqFTrIrYYMXof/Ykd/4Ettn4VYEOe7TY1gDXDeIiUvAA96muKwyFmjMvrvduF4iNE0cr+IqpShZ7reO6JhUl5iscU+ZeBVU9tkB0Jek1+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199015)(6486002)(86362001)(478600001)(66476007)(66556008)(8676002)(66946007)(4326008)(38100700002)(6666004)(9686003)(186003)(41300700001)(7416002)(26005)(6512007)(5660300002)(8936002)(2906002)(316002)(82960400001)(6506007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wE0P87ZhPSW+XdiXQIdXrlUtvWvicDdc7f1YYf1v6M68yTQcGX+g42288nga?=
 =?us-ascii?Q?iPQY28KSH+huuFZfFDct7ZgTX1DAW6Zy5UmlVx7zE7o0UfgnG/CRkX0xA5on?=
 =?us-ascii?Q?cLWDOkRxDvlpdLVd66Iv8BzHkUoHuUX3SnoNgENVjZlq+yDW3B+Dek5CZqsD?=
 =?us-ascii?Q?GEPLVJlHUTXTf5FRXa/kUKPHN9PTHphQkAeyYb36UsbJm7PTU8jA16rpXyS1?=
 =?us-ascii?Q?jhDPr72loynROGAfsyxTAoVSyFRIMpVWCpPCTiBUdi398UCVNdjySH4bMc5f?=
 =?us-ascii?Q?IjRhZ5oT5FbhglujKqi76IGUx6cDxkuR28YIFiLgiGAklbB97pkuWGQDEiiX?=
 =?us-ascii?Q?Qtx7nGnrWouz5WUvotCeKXVl7T8vUrWnM/WWzRO6lbQwYBiE9U9/aZU6URyi?=
 =?us-ascii?Q?gR8r+kI6JOpcUNe3+kg1hQhEXGaHqLgjoKLKwe/fzuQXPbDiVgV/ZzP9GeOK?=
 =?us-ascii?Q?xcMSrCXb9PoOKRotY7AdMhaQ/G0v8LccMtdoB1iU27UgYI7KfgnvviBcaoSm?=
 =?us-ascii?Q?/q3pfHGi49QHlPGjEptcJDCEqiYGYmJMJNDuBI9yOidqm0Mu/3VIeM3kGzzc?=
 =?us-ascii?Q?q9WBABJYxzELLnncA7P/iNn+km9njrluGlrc+4NBQ6zMaLcDKTirYISlDhr6?=
 =?us-ascii?Q?KOllHc7ofKCGigCNNgnTyHgcBvUZZ8C32dm1D99ogBQk6ymNPCt4ygex/aYS?=
 =?us-ascii?Q?roza0DTdhbu4TR0o5Bdpel1ZOGpxYCliB3k5FfKfq8hSrvJRHurQ3Z9gnVR7?=
 =?us-ascii?Q?xVFbmqUGSR3MGBialQdrSI/lgqSkgpTDbPZTXm5i1up2eK2eUoQL+q9K+9v6?=
 =?us-ascii?Q?omzaSAXJ9AcvtuItyNQE8lBRhGiXCWq7fgf6TiwCvFKsVeTrIYVuzjUXhHsN?=
 =?us-ascii?Q?NEYpDzhwv7xmUcxGzHcGPXKF9y+FkcZedemUK2LjRdKUFGZ3amJcKCv+svZD?=
 =?us-ascii?Q?o5rgdFg3xRfb4p76yAfSkWJ1iKI1zd8C1FOlIEqvZO+LEPfWaU52yb6j+YAJ?=
 =?us-ascii?Q?1h9M4ofD3ZRiakKbyINJdbRMzAlNHhZGzMHA82q+knTkLxacQ8ARLh3iJpQr?=
 =?us-ascii?Q?zFfg5bwgC3ZoXSWyhTdfP5OOwqxfF3EvWrnkNH59kDL61gw36FZCYRGAkbSo?=
 =?us-ascii?Q?VzOFqb9f1qZYkvgMr84frdlXsCkDgah26TRMwBWSzE4Dj1H/hSrToZOHM2w8?=
 =?us-ascii?Q?lzV+AYVCGG9aJcPjBi+2kne1gw79+Q5XeNSPf323iotoXrqmke1Y4ztRB2S3?=
 =?us-ascii?Q?STawUX0JszJbD/SmQJVi7cnxIgsLyvfVQ6QL+YJ8XCjOygGwCfoAMjL7CR1+?=
 =?us-ascii?Q?ULrA+TyIYwRibR0xLcE679pbNrZynShgCpCy0j1TyfiX4aZ1ato53UR0bzu0?=
 =?us-ascii?Q?QuHa/HacATN5vznby6VzI3YMnKzxg7p0RcTdd7K3HpSSb77r3OIt/1HxvxF/?=
 =?us-ascii?Q?hWkra2AywcEsUdIbXN8G+wM+uR37m4iMWcr7V/Oz4z0f5VNSDjOweum5Qzy+?=
 =?us-ascii?Q?V7M4v0R6ZpCc/pg9Ck63iKXpTyt9EU1gRthy3yP5PfKii48DyXRrNAJTy1SK?=
 =?us-ascii?Q?WRMaaTAKBPXxwPmaGVgfczrZ4RH8HNzB8rd58KCmgBaPyCtgtEvsYWNk49OW?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8645669-7d30-451a-d501-08dab3b52666
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 22:39:44.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLOpzWoDFK8aRLDDoITY+iZvFYgy75N3xHUdCvHoW1FWnyeR+nKDbr22blSJXiKK8T4SnoUK+0wc2Kttpi0/kVvPxjbUo2NsftUVQ4l4YvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6784
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> ACPI includes a CXL _OSC support method to communicate the available
> CXL support to FW. The CXL support _OSC includes a field to indicate
> CXL1.1 RCH RCD support. The OS sets this bit to 1 if it supports access
> to RCD and RCH Port registers.[1] FW can potentially change it's operation
> depending on the _OSC support setting reported by the OS.
> 
> The ACPI driver does not currently set the ACPI _OSC support to indicate
> CXL1.1 RCD RCH support. Change the capability reported to include CXL1.1.
> 
> [1] CXL3.0 Table 9-26 'Interpretation of CXL _OSC Support Field'
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/acpi/pci_root.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index c8385ef54c37..094a59b216ae 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c

Be sure to copy linux-acpi@vger.kernel.org on patches that touch
drivers/acpi/

> @@ -492,6 +492,7 @@ static u32 calculate_cxl_support(void)
>  	u32 support;
>  
>  	support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
> +	support |= OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT;
>  	if (pci_aer_available())
>  		support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
>  	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))

This looks good to me though.
