Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D5C64F7A4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 05:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiLQEzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 23:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLQEz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 23:55:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447846152F;
        Fri, 16 Dec 2022 20:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671252927; x=1702788927;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XClyNzckstpWF6AyKU+G8w4UfBIrT97qVDDMbCDI72M=;
  b=HnszFyZMw7thZSvv+z5VT80tNQO6DbuBxB4i8oLcMzodWOHrvUVW8wFv
   yey4ua/IfKVrt6ahyI5Am1oEIRkXJ14FRNvWEdLkYL9BgF+s2Frt5uGTA
   DLHxMMCFjkS5KJ3pkp67E8KeyCRT82Q3yGhIQvUse4mIoQcGFlSYlIdOv
   7Fz5jBoOfz5iyJlUmvh+0MEfF553NrK5NKd127av9WVBjVzKlG86Q0Z1V
   ano3x4OFOVipWatztcuLCYpdmWNMSL9qOHNVs6VoKwwWmp6F5IXxXmeY3
   jCKtIwzjtduTnGYN+I9xAka6dvSl8EJBimNfsAzftqQPrSbW8Kp/d9KU9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="381326619"
X-IronPort-AV: E=Sophos;i="5.96,252,1665471600"; 
   d="scan'208";a="381326619"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 20:55:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="643478178"
X-IronPort-AV: E=Sophos;i="5.96,252,1665471600"; 
   d="scan'208";a="643478178"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2022 20:55:26 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 20:55:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 20:55:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 20:55:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5W4ENYlJgCt+6cgNJRgu+zUqy9p2LE/+uiMXdBdytQD3aObxfBPKnLw4mHbIASPNKcsUul7XukNXSnz2euMYpQDRU1QnbT3ufE/Cht/SkZ9r7r0ogc1gp/3hbGM09C3SzSWmBEweQ7I46sZoZPAjaK1dm2ECf3lbfO4UrBZpWZz723laiGbR6RxX9+G1ydB14r0VVq8rly6sXKvGNzki9cSh7aQJYM576pHo9+ZWdbCgQuWBhqbrnbJMHvIK0ZQ9RyXU+wwalMMzwSC086XcFLwdacclpmDqR32lPxHmFx1IELZm46yD7G5ERzA48BhJAy9GZA0lniTpLdPzG/KUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLt/Q/jzlhVUU9rXbAHLB/4M+3HZy/ySJwdww3Z6fTA=;
 b=FTg16BsJwHEqrVDQ5bsd1cJhLmjuj1ZX9HcsgzC0m0stHT6S4FW2Woj9MbgHJKjh+YZo7dbF/NXJUlOhi1PhV2Da0IHop792sKvm2N2izzESIx8l1KMnoReZ6IzYqaNBPSWNDD+HCHYcV3nE52XR3TMHXMReFbq8jjU4oR1modv9GnZtg6izwW62Hdja30PC16vBQk8QOQUYCZqMSB7ybJpn6SqPdYurofKSz+MAyiU/mNOcernsqQ3XFm+BxEsQEVH5HCghNV64TJTOtnUFQhwV/n6tJ8X8IrlKWtO/ko1ljzVlMghteAINfSaR6+XVRvHpGR0NGPTCd7T/iIY7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ1PR11MB6132.namprd11.prod.outlook.com
 (2603:10b6:a03:45d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 17 Dec
 2022 04:55:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 04:55:22 +0000
Date:   Fri, 16 Dec 2022 20:55:19 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <dave@stgolabs.net>, <a.manzanares@samsung.com>,
        <mcgrof@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] cxl_test: upgrade as a first class citizen selftests
 capable driver
Message-ID: <639d4bb71bada_b41e329452@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221217034947.1174795-1-mcgrof@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221217034947.1174795-1-mcgrof@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::12) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ1PR11MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: e1348720-9b16-4645-b5de-08dadfeae6eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mpk/3xvXR7oo3WVXc7oy51l9RWArTaaN1Z1Ukv644KDWeU2Rdz1N283bdt7WFuG7SHLrlvurDLVAB8T4NGP2i8UxA7ih8kbXckIO55Y1kMyYFrn5j/e1xzLU7OgTLk0H6yacs8wARaPA/l8iMO7QymHA7mQalmLJHyVGUxNlrhxyreUDTjPRU+eLU2oEZJ46lwQDHBqGFMshYHZ/utdx1TAClF8eN+2A6ZG1T6iY3K7QzOeN42Im8PPJzI89UCIKAAd241E7Z9kiYlW43TOtb1pD6DmUFcLSV/3KTepPFBQ4AkEUamHExIwBia831Gxry5Gylr43izrac1IvYfisvDCj7oZ36CsVQhgnNJUtZOxJbuTsOOlt9cT4iWzNuEQtCZpQF4MrKXNkhQgMcdBv2nli4tq4CzECxChFzGStrfh4wdf7PaT7gberkosJ5cBLCTgvZH3lH1E5MdUnKC58aD8Se1K/C4B1zXxJOwsdA8iqBOJVVLcmSVRRd1AZ+R7fMsLXnh6Lx60okVChe2hM4gS5Rpy6RQ9YT4qNF1ka+9si3fMGJQnujaHtmooEqb8W9Ns1DPUaDPALnvK9ss6HBzh65iPa+1/d94g4xSYTac8/WeG2sL16qDu2jnwdRRLC3372JmUqVmNuYGO/PY3dpruW15odF3Z1+WSHJ+qjPIE/Smp6pgsKK4g3ZX6hSTF5yDXhHShZWyvRGXbFEsPMPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(4326008)(8676002)(86362001)(6666004)(316002)(38100700002)(82960400001)(6486002)(186003)(6512007)(9686003)(966005)(66946007)(83380400001)(26005)(6506007)(478600001)(2906002)(66476007)(8936002)(41300700001)(66556008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8WkDzq2lSJ/nd3kLpISyjdQ3rZ+NrnuPDs+8q43v4IS4/m3c+MhqAaXx5/Sx?=
 =?us-ascii?Q?HsDP4LLoBJorxVxJVywW4eYUnYA+q03HkECcOQnccOuwelDLvl5UxsVPYBD7?=
 =?us-ascii?Q?iIAoHoOqz8/ALoLWzBTlNGW1vt1I86DXSFoj4PfPGwssuOMSo1BLITI5C6LA?=
 =?us-ascii?Q?0DA3MYc6xlhcGSKulJPJSAfdwogl9V4zvOw30HBrTfuqaCj0Ba5yybsNf+/q?=
 =?us-ascii?Q?90HmogOP9Ol7Cn8FKyv+34HJdS4V7zbKnR91JdEeqbqSeBkYhdB6uRyUiH8L?=
 =?us-ascii?Q?TboGb1693yiddVpVGc6vCai6/7gPzHlK0jqlgLGT5iGsyL3JUBtbFEOvQ2bA?=
 =?us-ascii?Q?JquImF6G8xbkoycM7RZdqxdRW82g00xtngCz3elTyxKH8gFrlOa2cyai9m+4?=
 =?us-ascii?Q?H7+Ue32UWuIDdvv16kduyy0mvo7O0bkimsJT4PFaORRXm5BRuKTqz5wWRgTF?=
 =?us-ascii?Q?hmLmU1ylcnmTOUG7keviIWZYokEnyBkDxhOM0ib2Vkedi3B64hvrTO5cFM8y?=
 =?us-ascii?Q?7HtSUkh3/8lkUHDNTsF6d0zSw6nknYt+4aWdkVBadeOnLMNF60BeFzArJJph?=
 =?us-ascii?Q?g4dlZWAaL76rjk/XJ2Gmn2/aSyucgf/y4g7KguluDrBGZI/7TcNs/Cclpwzc?=
 =?us-ascii?Q?GuW5EE2xeuai3mMEJoSxt6gN2kms1dnesHb1V2B7Mx+ksAmhDCUmudVOEUOI?=
 =?us-ascii?Q?Gg+vRljby7zd1tPZo1R8S4BYswcKTx7wMytd8dbaUnVjhA/ons3vlypaxlzC?=
 =?us-ascii?Q?vWiVWcVv6E43106oqeHVoF60ylEYhetkGfZalc2/ZjrtL2FX+6NULDaXx4Q8?=
 =?us-ascii?Q?JDrNcgbp/AV4WzHYR3FmaZ+lvg/i7KUuSlipNinDGy6oNS8mf1ZIP+Cbat/n?=
 =?us-ascii?Q?fZ06/mlNUHLJ7Q3DKhr+kxNjFRLCl/obtRNo9NHlN/WymGaEmlVm24T1uOXO?=
 =?us-ascii?Q?t7MKPDddzeWhT+BT7pxqjjzH46EJBI/yAGYvyN6pufH9JiVp/Cu6s8vqp5R5?=
 =?us-ascii?Q?pUQjuKjvVfO5IJR1/c4OJo886OrQh8AkfNM6CM+852KMWIlcJYMe3uWNyl7l?=
 =?us-ascii?Q?F+bAwssmH1qPmHibP3Xr6r8TXe8O3lWRc2G/lswYC67PyZBOf62No6Oj8vcw?=
 =?us-ascii?Q?R25GvqOLduT1VS98FagC6XsccEGrsfKITbOWBT8IDW5A89o7QQcvoxpfCEcO?=
 =?us-ascii?Q?+AnTb1huxWLpqo1q5hEF07BRdD7wj3d55E6eavHy3sIHYsqDxJkM/kfQx7eV?=
 =?us-ascii?Q?etkn6CU8J0gfPX7FfyyzKseypr3MV9DXnJ4ak2fuuH/8JegtKBju8/68Iuif?=
 =?us-ascii?Q?Y1ozxmwL8d8VIn0IiHSEE+Uqdq6Ryj7f1vmsR5cVdZctkPgH3F5+n9AR8GCi?=
 =?us-ascii?Q?rszNIUBDpiF2MSr7VzKULc1NjGwrF69BixbfMM4HaQOh+55+hcPGQDJptKvz?=
 =?us-ascii?Q?CQ9TeF3EgEjX6KVaqhz+j7pbI1530DbPLA52cBmW2H98S1zwl4PWrFHgItg3?=
 =?us-ascii?Q?zlxU45RcmDdJol7BFfIgpzIsQCag3l9ERT4l6c0DqHDVEQYYdvqi5EtLiNet?=
 =?us-ascii?Q?OVat9fRJltvqnb46pq9JQgm13bDhw/OCsgJQkcs1FMlnHaH0KtDkqnxAsPBk?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1348720-9b16-4645-b5de-08dadfeae6eb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 04:55:22.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lChRyyoAfycDCSFYsvI4tbHru1MGPe6zxVHR7vMnAXu86QI6lBTiWg+nl/WTp3ureA7QOpMoydXnTME+K9GbEhqbR3drz3jdP6yzUJcXPCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote:
> To unit test CXL today we make use of the ndctl meson test suite but
> this requires the cxl_test driver. There is however is no kconfig option
> for this driver as its required to be built as an external driver. To
> debug CXL with this framework is not inuitive as it departs itself from
> typical Linux kernel development debugging processes, requiring an
> external module build which also happens to *rebuild* all CXL related
> production drivers with some new magic incantations, and replacing
> your production CXL modules with the new ones.
> 
> This is quite complex, departs ourselves from the typical build/boot
> debugging process most folks are used to, and requires a manual error-prone
> process which in some kernels / configurations can leads up to a kernel
> crash [0].
> 
> We can replace this by having the requirements be defined through proper
> kconfig symbols and having the cxl_test driver and requirements also become
> part of the standard Linux kernel build process. This matches most other
> kernel kernel debugging frameworks for subsystems, which don't require any
> external modules.
> 
> Let's review the current strategy today, first, so nothing is lost:
> 
>   * one must manually *build*, and then as a second step install
>     the cxl_test driver as an external modules:
> 
>     make M=tools/testing/cxl/
>     sudo M=tools/testing/cxl/ modules_install
> 
>     Provided your depmod.d was configured correctly on your Linux
>     distribution you will end up with a complete set of CXL production
>     modules and cxl_test mock drivers to let you now use the ndctl
>     test suite. To be clear, you will not only end up with cxl_test
>     but also with a complete set of module replacements for your CXL
>     environment.
> 
>     This works by:
> 
>     a) allowing the external module to re-define the __mock macro
>        to __weak, used on to_cxl_host_bridge() and allows the mock driver
>        to provide a replacement for that single call.
> 
>     b) the external module build process *rebuilds* all production
>        modules *again* but uses the the binutils --wrap=symbol
>        feature [0] [1] to let the production CXL code use the mocked up
>        CXL features.
> 
> We can simplify all this considerably and do away with the external
> modules requirements. The __mock stuff is raplaced by addressing the
> to_cxl_host_bridge() mapping using a define based on your kernel
> configuration. If using the production code you use the produciton
> __to_cxl_host_bridge(), otherwise mock_to_cxl_host_bridge() will be
> used. This is the *only* eyesore in the CXL code to enable use of the
> mock driver.
> 
> The magic --wrap=symbol incantations are also just tucked in a new
> production drivers/cxl/Makefile.mock which is only read when the kernel
> has been configured for debugging using the CXl mock framework.
> 
> The last bit of work left is to move as built-in code shared code
> between a production environment (non-debugging) and between what is
> needed for the same code to run when doing mock debugging. Today the
> requirements are small:
> 
>   * The code to implement to_cxl_host_bridge()
>   * When mock debugging is enabled, just the code we need to
>     support mock_to_cxl_host_bridge()
> 
> For both cases this is needed you have CXL_ACPI enabled.
> 
> In the future if we wanted to then now use the kernel selftests,
> for example a tools/testing/sefltests/cxl/ directory, we can easily
> do so. This also enables us to separate out unit tests out from the
> ndctl tree and allow unit tests to also be developed and written
> upstream on the kernel.
> 
> Another benefit of this approach is that there is no bit rot,
> in the sense that now bots can go willy nilly test building this
> code, whereas before only those who knew the proper incantations
> actually were building this code and loading it properly.
> 
> [0] https://lkml.kernel.org/r/20221209062919.1096779-1-mcgrof@kernel.org
> [1] https://sourceware.org/binutils/docs-2.23.1/ld/Options.html#index-g_t_002d_002dwrap_003d_0040var_007bsymbol_007d-263
> [2] https://lwn.net/Articles/558106/
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> What do folks think?
> 
> The test results:
> 
> https://gist.github.com/mcgrof/2ab7f1601141faa5ac7b16240b4ea652
> 
> The summary of test results:
> 
> Summary of Failures:
> 
> 1/5 ndctl:cxl / cxl-topology.sh      FAIL             0.50s   exit status 1
> 2/5 ndctl:cxl / cxl-region-sysfs.sh  FAIL             0.44s   exit status 1
> 5/5 ndctl:cxl / cxl-xor-region.sh    FAIL             0.45s   exit status 1

At least for me the presented rationale and these results leaves me
cold. Yes, there are sharp edges but 0day groks this scheme when it runs
tools/testing/nvdimm/ (nfit_test) tests. The run_qemu script automates
cxl_test and nfit_test this as well. So the complexity has not proven
prohibitive. In the case of tools/testing/nvdimm/ it has not proven
prohibitive for years. In other words the suggestion that the current
organization ultimately leads to bit rot has not been substantiated in
practice.

The proposed direction to move tests out of the ndctl.git repo into the
kernel solves the wrong problem. It overlooks the fact that the tests
are more tightly coupled to libcxl changes than kernel changes. So in
terms of benefits of code being colocated, tests + libcxl + tools in the
same repo is more impactful than tests + kernel in the same repo.

I know Jonathan has some latent ideas about building up a CXL regression
suite on top of QEMU, but even there it's not clear that would benefit
from being developed in linux.git given the tight coupling to QEMU.git.

> 
> Ok:                 2   
> Expected Fail:      0   
> Fail:               3   
> Unexpected Pass:    0   
> Skipped:            0   
> Timeout:            0  
> 
> I don't quite get the failures yet, but hey it's a start.
> This commit depends on Dan's patch:
> 
> https://lkmll.kernel.org/r/6393a3a9d2882_579c1294b3@dwillia2-xfh.jf.intel.com.notmuch
> 
> But I can build another RFC if folks want without it.
> 
>  drivers/cxl/Kconfig                           | 23 +++++++
>  drivers/cxl/Makefile                          |  2 +
>  drivers/cxl/Makefile.mock                     | 15 +++++
>  drivers/cxl/acpi.c                            | 13 ----
>  drivers/cxl/core/Makefile                     |  4 ++
>  drivers/cxl/core/acpi.c                       | 30 +++++++++
>  drivers/cxl/cxl.h                             | 19 +++---
>  lib/Kconfig.debug                             |  8 +++
>  lib/Makefile                                  |  1 +
>  lib/test_cxl/Makefile                         | 13 ++++
>  lib/test_cxl/acpi.c                           | 28 +++++++++
>  lib/test_cxl/core.c                           | 37 +++++++++++
>  .../testing/cxl/test => lib/test_cxl}/cxl.c   |  7 ---
>  .../testing/cxl/test => lib/test_cxl}/mem.c   |  0
>  .../testing/cxl/test => lib/test_cxl}/mock.c  | 30 ---------
>  .../testing/cxl/test => lib/test_cxl}/mock.h  |  0
 
I do not think cxl_test is suitable to ship as an in-tree capability, it
is intentionally second class to keep test logic distinct from
production code.
