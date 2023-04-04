Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58F66D6D05
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjDDTRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjDDTRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:17:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A9A35A6;
        Tue,  4 Apr 2023 12:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680635832; x=1712171832;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RL/Oa2ge8QEbGqtMVn4G/4bNJFmAE1eYb/6bmQFb8Fg=;
  b=RG4qemh2l6yXsPduFyQybJPDCxF6Xw2cDk8O0mV0L0hucNdUoG/T11gb
   IiyuzEJYlpxfTybreFLSJ3AIbFiuT2o6rbFmYltBmjw4j6ek6stWws63A
   yhLX5CqWfaV1+1r3EZtB28Vh1eN5Md8sdX+51WisU1A3e4rOKWwuD0fu+
   KuyU2VXByoNMdrEasxMUCQm6/cVgJwzarZ1nURO9Yi7Bk0j6KiXm1e/IV
   ldmLhKNNc3pm0tGDyJlt+VmBrb2RaWpzXOyvQS5LDhoGkH1Qt2QPWHOrj
   11BkO/D+7LQ0n2udiB4EVmJktghHb/L2+wUwRgCRKQIYonrR8PVMTqL1N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="339773633"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="339773633"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 12:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="775763256"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="775763256"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Apr 2023 12:17:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 12:17:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 12:17:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 12:17:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP/8gbY30yC9BqeVEJkW+kBnZk0/hEYp32vfATbukHCEmYKCpv8KUiWOrs39JlDco3nZlPgv007vIjUitUxOMBFL0CPuNzLX1sME3ErgR81kkb+rajWLH9cCpZQ+8vuWClxfhJ3zF3VM1StaqRJ/v4liCsik6dhbhYPZAzVWO3UyLMZ/3K3ehx2WhSUcUX78vewOYzpAMmiQVL/NYdwRZC1nqCcf68V+aOOBhn5VMgVNifeZs30tDQI09R3+UVqnh9Yb+DN5WU4Zdf1jwNrqU15h8yh39joDDO9mBSpb45qKO9bz+phtz/n9X8B7j+2gCz1nG5Uem1TWm31/arss1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfAP8xYOhvbB9b/Ge6XRsu7d0zfWJCmSbpiPJQ20apg=;
 b=LzI+LY4Xomm9v478Gf5Ph68iUmIxsAWm/ih4BjjFiRRd7E2Tzhlt2jMz6TNbdtjwQMgvDhuo6aHLKZ/06QrBqe8e+4ZcXDirmNZuqtqmzIVqmK8nDvYrWsdZsZwF7BIs4xbH07j79RvzlyPTNU61kmBzALIX8kdRJ+0xp2BSuC0HQRPStgMcVRssJwMgK8GywZMnNGaLTCfCJHGFO8h6JMe0gBqCSwLOZvbn3AKKgn866vHoiWY4Y8juMYTL5kg3Agg1J7W1ZWCnaoSU5m2EL+jPrk8T48ahBQuWLq4zAFoGn4HkhOszaAGPlPo5mDs4HVjjpm2Y9iZIvPyJ9QBRKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4797.namprd11.prod.outlook.com (2603:10b6:a03:2d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 19:17:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 19:17:03 +0000
Date:   Tue, 4 Apr 2023 12:17:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: RE: [PATCH v4 3/5] cxl/pci: Find and register CXL PMU devices
Message-ID: <642c77ad5f0d_21a8294fe@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
 <20230330164556.31533-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330164556.31533-4-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BY5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4797:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b3c412-ba0a-4e18-d855-08db35412c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1eDft7okUI4UnLMXeBoP6rQOS4bYjlVSvf3i+6ASLUTzlePOar/z++uYDMj0h2oGHl3YzR4snfrVaYIzEKhLMxszXCG2VhRVzwwegZ0xZ/chiGZ4HVoIIi/gEwT7UtiFsfifCVQqSBaPY2wWN1JeFdvJbNUFzu3uXFnHZZqAKbrQjkGVDzVInowkPXcFj3ykjnkev3TD/6NsAgMQiWfdKmhn38dCsB/7wd7LG0UlCVk6TJjD7/UsuEQXRWVtjPdcYpwLf46Jx0Bj9Kk5ZZQ9du5Ib7PyQ+AhqnSgLco/YfcRlkew6+avWALhGArijiMwqHSatfdvz+fzaOEk6R9GHBILhMdo9igqMoIR83FArziDN9Iijyvp6xbMYXl0cf1Ca0dOoDT82TKeeH+nFj+H6e3uLjTAzdxOz8I5B0niycR/uAwvcyJAGUziPSsyHkZMannOBlZ5XgxSWPUn6BEV+NYPidzgwkJhsTIGm0eT04xsGu8fP17JW1dZZtQqlkOQPLx8vPiKn1JGgAbUQ2QdxV4sAVb1rjCGS3j/AcFNPICINxCT6xatSjIoReCoB3d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(186003)(26005)(8676002)(66946007)(83380400001)(6512007)(478600001)(41300700001)(316002)(54906003)(6506007)(4326008)(82960400001)(66476007)(66556008)(6486002)(38100700002)(110136005)(86362001)(7416002)(5660300002)(2906002)(9686003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?plmCYOQt92MC3wnMPMBQg0sURb6XHK9Y15rbnublEDvEEGGPQUVSTnqUHQ9Z?=
 =?us-ascii?Q?4lHrRLmMIatVTI5+65xDuGRqriL0jDs+IaObrinXc7erkb+bVUmkHPkp9umH?=
 =?us-ascii?Q?p6aC49nEKvrZi4Ulqi2PwttHgcNgsugJ+KYEz56LotbklDNuRa7HGcLPVDbv?=
 =?us-ascii?Q?u3Ozj4aGjt2vNP4h7uLWBgF3iCxKewXVkg0HqCzu++TTGNSuxP6PiZ0eyZd8?=
 =?us-ascii?Q?WV8lPwAjouZtWso9+h4hfOQedFPpsRGDK97nWye+7S5EykJezqXEcD4dz+M5?=
 =?us-ascii?Q?zcSSVXvquiXytI2GlnkGljDipQchO80eEM5HHgLwUORzt68zeZ+pkMwzrKC1?=
 =?us-ascii?Q?Ih+sP7/ylNYFVVTRi9iUk2FtGSBXH2uiumSd85wuSpiHmRvbN64tvDVMyGY6?=
 =?us-ascii?Q?2T0Umr3KSQI5JfsFX1u+V8BWvVYcv3d07EwIcWkE73YKsrwcJU9cd1WCY0NC?=
 =?us-ascii?Q?43cFNHif51Vhq98iWNygBURqhwxHQMJnN28lQt+ROwNJKTk2uezEHhHOnYZH?=
 =?us-ascii?Q?XPUXEAlebVubBr9zHxYoaab9uM1hleZB09aVfGZR5P3yQ8wR/zmVESarNsVI?=
 =?us-ascii?Q?4yC13uGilAbnVBXGWhE+qKtAX52VsllagGXaLtXWQEmzqAtFnbh6uoNKoOco?=
 =?us-ascii?Q?eHvwBODz+qnlkjIRwMDLkqMAKrNqyi2J1TOTaoleeY2JTTwCcuPoxePDhA5A?=
 =?us-ascii?Q?T5V2OLYH76bOnBm8DI1CJKM1C7Md71CcmIA7q5C1iv1JjtHVlveBm3006zSy?=
 =?us-ascii?Q?xXvNwx9EO1GDxufWTj0GPQgckaspqL8iRpcZbmckMjUosOL3BSjv9FzyCnWi?=
 =?us-ascii?Q?TSDzDqMx3xh5LKe7qEZ6+vG0eHUYm6DZannrMaEcu0e09o4pLQGm5wluQMIZ?=
 =?us-ascii?Q?nzyWC0Dwv2I4jh2cyLIT+BpyWSqKro+Y+dEdsavtRB+AvEVXPhR0HQ+AhoGX?=
 =?us-ascii?Q?eGLbZI8RhNV8pYuPRKZ5D4dDgjYd63kQbxcFiJZ+W5pa4emekL3CzIkwxiyy?=
 =?us-ascii?Q?Bi7ixD6EkOi2OlKh7GX6CNjKUePwM3cO44XO1L1qrI2KTpP5/IUaIRjIiZ9M?=
 =?us-ascii?Q?6QXES3RgFE1NhmHcjR+1S1Hjb/gO4Ay+YZa2yOQfOpni65xdwhzPrZepSU9n?=
 =?us-ascii?Q?MJ5A44A/BLmExknMGFVXYm53w5yXP+Jd27EtYo2ePb35DqrRV3FIIypVslwm?=
 =?us-ascii?Q?pAodAzx2tTf1yD3l1kVbEse+x6R3gsuyRAG+9/hWP8ZiNRbaOEn4+YVWoxiu?=
 =?us-ascii?Q?TINmdxwH9QFAc9uLpYpZpNDGq8LPHTXU2vn+08QOUrqKb04yqmEX8TaZ8R0M?=
 =?us-ascii?Q?I1FOILUgn0sLYwx2MCFZVSSXR0AKyNKeNuZCRdGv20n9NRgruVdPmm1F8UWu?=
 =?us-ascii?Q?jNYpX5gbOmsA9yF+YOIEFGlrQwaQ1FDi1mog1dk6nVn3vsmjTD89V28x1M74?=
 =?us-ascii?Q?PJgtL42ReJRnpuK+leALtC0PRdlTAjMqnV0iyfPpgjOuUeqfJnJ3udyAaQTi?=
 =?us-ascii?Q?W7ZCQZvy6yusl1qS4h1fIZAO726H5JLTWUGm3j1POFj9dcE6pY8MAsyq/HE3?=
 =?us-ascii?Q?CHGmxusV3Iof7e6H83RbuYrMFsi/SR4E63VW4SLtBmPDSZZZ7hKPhmkn7oWH?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b3c412-ba0a-4e18-d855-08db35412c1b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 19:17:03.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFpBGLESnGZ8PSmpVFHi863x2gPXHwc9tnuffqP+fURnaYR3U2r3qJAHqNkvnz+ldZk01UCzcOhAWNfLj7dwhfR3bzq8t9xzNFR9MH7+T4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4797
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> CXL PMU devices can be found from entries in the Register
> Locator DVSEC.
> 
> In order to register the minimum number of IRQ vectors necessary
> to support all CPMUs found, separate the registration into two
> steps.  First find the devices, and query the IRQs used and then
> register the devices. Between these two steps, request the
> IRQ vectors necessary and enable bus master support.

It's not clear why this patch is talking about irq vectors and bus
mastering when there is no irq query/setup logic in this patch?

> Future IRQ users for CXL type 3 devices (e.g. DOEs) will need to
> follow a similar pattern the number of vectors necessary is known
> before any parts of the driver stack rely on their availability.

With the new pci_msix_alloc_irq_at() it's not clear that this 2 step
approach is required, right?

> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v4:
> - No change.
> ---
>  drivers/cxl/core/Makefile |  1 +
>  drivers/cxl/core/core.h   |  1 +
>  drivers/cxl/core/cpmu.c   | 72 +++++++++++++++++++++++++++++++++++++++

A quibble with the naming, I prefer:

drivers/cxl/core/pmu.c

...since "cxl" is in the directory path. Also, usages of cpmu
already have a cxl in their symbol names, so just s/cpmu/pmu/ throught.
The usage of CPMU_ for register macros would seem be more clear, or at
least more consistent, as CXL_PMU_ like the other register offset
definitions in cxlpci.h.

>  drivers/cxl/core/port.c   |  2 ++
>  drivers/cxl/core/regs.c   | 16 +++++++++
>  drivers/cxl/cpmu.h        | 56 ++++++++++++++++++++++++++++++

drivers/cxl/pmu.h

>  drivers/cxl/cxl.h         | 14 ++++++++
>  drivers/cxl/cxlpci.h      |  1 +
>  drivers/cxl/pci.c         | 25 +++++++++++++-
>  9 files changed, 187 insertions(+), 1 deletion(-)

Other than those minor issues above, this looks good to me, with those
fixed up.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
