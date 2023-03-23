Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB5C6C681C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCWMXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWMXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:23:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72CC2106
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679574197; x=1711110197;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2omX0kxqscTQw3RN1+N5HgwEHLkRvLJh2+lKzRDOnC4=;
  b=eEmCDGvmafzbfbsgRN8IYoZfmRP2Jyn9SXg78SkBMVV2hH5NQAgv0oxc
   yaBafVFTqf3OEdNEEv07MouuyFrtdZqa05YGpYGXPjMqvROR/6B9FtwZf
   8brEXj5Y6YGoD+P2NPGsbeo492DxN5JhlUbf+y1QO4Jjrovf6/M+ifeCv
   31nj2VQvqrRPZeAeKXBZ4EWUU0sL5e6AyeK2WsUX4OnJHWZHuKjnASmXe
   vJr8Lg9h0VGUnyEDha80Itwh3nw73KAwX7vQOLD0mbckvo023NdHFml70
   Qxo5gMIHGLeV8vaK7VLP6Yw7B0TM8mJJnUHlMhOoqbFY6qQCAwpJpRs2M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341009147"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="341009147"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 05:23:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856463180"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="856463180"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2023 05:23:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 05:23:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 05:23:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 05:23:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEtwsPQceIVTz75a9zvmGHwLuNn88BKhEPyt546bwfF9hVOG98gJ1TXj+Y9MxMDW5vXyHa4NSvHbLXAbIO7XxvQD+MHjULtMHdtrQn1/hwSpep19Ya8JQu875UH5o0FpISlrpS1dDzdizNLo9dMK0OA24NX1NYejuKqzCmD4uBlQ+ndQGmNBv5M8YiMRtHyad+lRy+lQ8L9pyF+UUMNKleGVBsGouH90EjYz6SI+GFIJEusxULfBnkEE+MFIaqYSz1WqrcStyc2boPI9SonMylEFaSq724iiN4VwqlwE1cj/8ND1/Sk0W0sI4FwEbz7gJGGw3lbaoyw3Jbr5Q7e48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82UB3l6kwQXhGaCPxVxZelby61nUsM8lgvrxrcnT5L4=;
 b=R/4au+4jKiJ//f+NP4diXuj/Y3vTQ+RWOQP/kZFrxbkGvENGa+XehEpFVmRp9REFPzzRtgD/o+8j/P+sGH7Km/m7Qa9AVFs7iGs8whoYf4h1qdsIeRiEeeozrhwZSdqjhyCiHDAnejoB3Pq3iSvB0P9ui4298Q5c+QPLrETgD7pdZnBzsQ1Amk7o6FHJJna6PP/lbJkmnO+u1wwSkwyYjVOINPqUaGYExWiYg+plIxGBQFSciWSs3ka0RQnINQmbOHF2KbV1Pv2i6JPkK2k06Dc6mtDU92VYkADLDliu0VodP6uGVE8S3Dvd86TjqgVs+GEvLVVXU5AEys5gbHHn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 12:23:13 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::93fd:14c:bf9f:6d03]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::93fd:14c:bf9f:6d03%7]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 12:23:13 +0000
Date:   Thu, 23 Mar 2023 20:23:02 +0800
From:   Philip Li <philip.li@intel.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Zi Yan <ziy@nvidia.com>, kernel test robot <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/sparc/mm/tsb.c:405:39: error: left shift count is negative
Message-ID: <ZBxEppxm7lQKJaSK@rli9-mobl>
References: <202303231810.eJX8zyTf-lkp@intel.com>
 <91E887E4-0867-421F-9C75-FB9CFF15C33A@nvidia.com>
 <ZBxCYk6O6M9p9wB0@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBxCYk6O6M9p9wB0@kernel.org>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d932a55-80e9-4fc7-e9ba-08db2b995ee2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVCM6mx4AeALeyXlilT2cjkY/N+4Sae48cDixr4+MsZ5PinikE2naW6Ch7bhMUgEhg7OcmaAsqLkIgYdopB6DtXmElaaiqiEgBEKkAUu7wRoXu8rOrREwqP5OSYV8LVwC0YHazbyeT8qS930bK6Ht7ZxUhNMTwwTKoR0uUbA88mhWm0/YiOzUnbg1oZc3B/CGO527A1wcSswYdbzncES+mDnXusmYmwXphPO9geemFdh2VrrYQuU+otbxUqXTWUi4Df2O6eA0grD8o+c/5t43IGVacDBER9ejCEbisbjyJzmmMRb15TavfpsdtD/5vL7AXjUeuSoypMVrCkfgraOE0GWC0amjWAa9xtP3D7ZpzeDYRlqAweTKOqAPI5y3QmVRw0aRaxyktg1oJKyWQs4bvtvLsYE9mZErqSmHVuiTXdr9d198KoIWLdnb8Ht/ARj/9HjM9DZGLvQFewiXT0w7Ag0EcZJRIoxSObcoxWh1gqQLdeNZHTDul/udgjHIZ+wRdmz3ZKvXjPjVJqu1rpvFeZ5ezAWy7Qi2edukunW52NPpkBCsGMdYhm19pEFGpdyRtHnKZp1uJNsQCF3OF5SWOf5+Nnm/ZSxYQNlFOE8c43BYRcK7+iw/HxH8kNYhG1st6gjqGk8ZFLxiV6a+sGdBkUBr/mkmzehxawCZms3Ycs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199018)(86362001)(82960400001)(38100700002)(2906002)(44832011)(41300700001)(8676002)(6916009)(4326008)(66476007)(5660300002)(8936002)(30864003)(66556008)(33716001)(66946007)(53546011)(9686003)(186003)(6512007)(83380400001)(6506007)(54906003)(478600001)(316002)(6666004)(26005)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tdkei6ifcNlIyIBuhq5cyL6eK7s2kneanjKm/T/2cd1osrbtFVKo5TWYX2+l?=
 =?us-ascii?Q?TaEWFuGb70DwVHsDK5FBE6/keFVaozl2Ial3O7ZS3IjzuhAUFn4m6azLZIzL?=
 =?us-ascii?Q?K+3a5In84VTq2sqsuLZe4b9ULJ2sDsXP65CVG8oXNreNOvhQd913FxL5L+u7?=
 =?us-ascii?Q?JBiBJD6MV3cxpT2x9nUe8PIGvnF0DIvM9rInHSG4X1U58c/ftt7/TRf+65dp?=
 =?us-ascii?Q?t1cn9WXTynrYFTZZ1kf8kpSQWJMs52ZZZcnAxp5brTuGnmGJyIjsr2GPRWou?=
 =?us-ascii?Q?nH0sivYZaprtixL4DZiOrqjN6Cc/KZ04Je+nD8JQiW/ZSr7dWfls4Yu0nRIi?=
 =?us-ascii?Q?jiFOFqOh50DcU2QJ8ARI6Ivl1GA/UtZujmWGJBJ7jmUG4N5uXmhaJqs1ehyI?=
 =?us-ascii?Q?uyLMC+86zHedB9IbOif4OQp//CyhfH2IE4CrotmyzuypZ4ayt4N2Qu2LHO1B?=
 =?us-ascii?Q?fQ7CM+7JKCYBU07bDrlLi52G5ViQt5BVBaFUOBIsSlW/yyX6HQSVaZvseCGM?=
 =?us-ascii?Q?QIcS3PyNkIUmMu5DCikr9vT5BLRh8ZQrd4qpF2ugdWDu298W6zzLFZIAolcL?=
 =?us-ascii?Q?JAC+MJDjY3/vGY6+7AeMZCrTnxOeaM0Rf6n03y/0SRrf8AZItXeIAZXPTSHz?=
 =?us-ascii?Q?2d287fY/JvthXRUIxP+RneTiHtR7d+dC9Fs2c4NptHof9Uz1Oi1Jk13RlQ/w?=
 =?us-ascii?Q?/O8LMxnnaZHK9UMIhFME8ZXre4MP1K1YLVP3Xx/6+MSiJacf8cBldysJ6J3u?=
 =?us-ascii?Q?PLkCIZYzMSQ8YVqODzySErwtZ8qvu80OB5KW8YG946bJ/jvGhgImnzhvYImt?=
 =?us-ascii?Q?aesyWCxv8SXWUlVYz2vcg+p9LU1Yh24PBYJ5fkohkHZ5AqVyygVNHItKvMvb?=
 =?us-ascii?Q?VPdqTHs58zp+0zlCpf/BHezSF5vQOQJqroX9EzDwtBZfV0C/l45iK2O6qBhM?=
 =?us-ascii?Q?4wAjyLqMn4RmVQJybSGLwzaAVPRNu0GF2px4SsP41cpRZM64WCaAzFKCtEbq?=
 =?us-ascii?Q?JPDi/socwKgs0Lq0BnLVyimItyODoEcavlKZSMENPtqGMAYqoGFrb9u1BYkr?=
 =?us-ascii?Q?doLcI7/Sm02rENht8U6zjBwBn6UmhnKiAzVb4R1WH785iiWHmzKIjHfAkQ9j?=
 =?us-ascii?Q?uUAr7PBV7eBO4dUCr2srnfLD79vRermUQQC+Wj11YVnO0+lBh5EDsBIq/TBh?=
 =?us-ascii?Q?v1MGFDLriBaoN/JKVfuJtnhdXbxx5+uPIPBNiACIzMERHWWUa9anIss1XX7f?=
 =?us-ascii?Q?OsuWvF2INMPfmWFKXjlXOIXl2jz8nrdlAZ/gyLly9hARQ/kUec+f3i4XJXMn?=
 =?us-ascii?Q?MjUzikSkcpJt9D5LTj4QAPZP8k4IAWA/5MZ8H2g50CDwexFW8DfCNhyUMkJd?=
 =?us-ascii?Q?183atsGPte4KUjY1mQr1IM6+lro7LE5uASiwQclAVWthwU1AumZC/tUKNp0c?=
 =?us-ascii?Q?FF2kYhh5u+IcRIpsT9B91lDdg3yDsnDV4YnM79csEO6p/KFXPbpY2svOF7aT?=
 =?us-ascii?Q?6zJ9UOjPOaZW6VZTCQeVfoL5mhnih63Ya/qQE6MePhMJhH9ZPJkEkpeqZNGT?=
 =?us-ascii?Q?pvzKQeT/JUO+PAI3V6QRIDrObeS3mIpcA++poJHtSf9pWdoxI+pWEtioKJ4y?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d932a55-80e9-4fc7-e9ba-08db2b995ee2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 12:23:12.9195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Njl8hpj+8NcnYjLnAzAo2SmKo+uugYEwBHRqxW9gDl4WvOTp2Sya14QEa5Xqi/hoyUDorSnvefGhjg41GvsAgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 02:13:22PM +0200, Mike Rapoport wrote:
> On Thu, Mar 23, 2023 at 07:50:01AM -0400, Zi Yan wrote:
> > On 23 Mar 2023, at 6:40, kernel test robot wrote:
> > 
> > > Hi Zi,
> > >
> > > FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   fff5a5e7f528b2ed2c335991399a766c2cf01103
> > > commit: 0192445cb2f7ed1cd7a95a0fc8c7645480baba25 arch: mm: rename FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER
> > > date:   6 months ago
> > > config: sparc64-buildonly-randconfig-r002-20230322 (https://download.01.org/0day-ci/archive/20230323/202303231810.eJX8zyTf-lkp@intel.com/config)
> > 
> > Cc Mike, since he is working on ARCH_FORCE_MAX_ORDER.
> > 
> > This random config sets CONFIG_ARCH_FORCE_MAX_ORDER to -1, causing this error. I am not sure if we need to always set a range for ARCH_FORCE_MAX_ORDER or random config generator should be changed to not use non-positive values.
> 
> I believe it's the same issue as with Kirill's MAX_ORDER change [1].
> Apparently kbuild used an old config as the template and renaming of
> Kconfig option caused it to be set to -1.

Sorry for the false positive, -1 is wrongly set here, we will look into
it and resolve the bug.

> _
> [1] https://lore.kernel.org/all/202303201615.Qfu18nWV-lkp@intel.com/
>  
> > BTW, this issue pre-exists my changes.
> > 
> > > compiler: sparc64-linux-gcc (GCC) 12.1.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0192445cb2f7ed1cd7a95a0fc8c7645480baba25
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout 0192445cb2f7ed1cd7a95a0fc8c7645480baba25
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 olddefconfig
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash arch/sparc/mm/ drivers/base/regmap/ drivers/media/usb/em28xx/
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Link: https://lore.kernel.org/oe-kbuild-all/202303231810.eJX8zyTf-lkp@intel.com/
> > >
> > > All error/warnings (new ones prefixed by >>):
> > >
> > >    In file included from include/linux/gfp.h:7,
> > >                     from include/linux/slab.h:15,
> > >                     from arch/sparc/mm/tsb.c:9:
> > >    include/linux/mmzone.h:636:33: error: size of array 'free_area' is negative
> > >      636 |         struct free_area        free_area[MAX_ORDER];
> > >          |                                 ^~~~~~~~~
> > >    arch/sparc/mm/tsb.c: In function 'tsb_grow':
> > >>> arch/sparc/mm/tsb.c:405:39: error: left shift count is negative [-Werror=shift-count-negative]
> > >      405 |         if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
> > >          |                                       ^~
> > >    arch/sparc/mm/tsb.c:406:43: error: left shift count is negative [-Werror=shift-count-negative]
> > >      406 |                 max_tsb_size = (PAGE_SIZE << MAX_ORDER);
> > >          |                                           ^~
> > >    cc1: all warnings being treated as errors
> > > --
> > >    In file included from include/linux/gfp.h:7,
> > >                     from include/linux/slab.h:15,
> > >                     from drivers/base/regmap/regmap-debugfs.c:9:
> > >    include/linux/mmzone.h:636:33: error: size of array 'free_area' is negative
> > >      636 |         struct free_area        free_area[MAX_ORDER];
> > >          |                                 ^~~~~~~~~
> > >    drivers/base/regmap/regmap-debugfs.c: In function 'regmap_read_debugfs':
> > >>> drivers/base/regmap/regmap-debugfs.c:229:32: warning: left shift count is negative [-Wshift-count-negative]
> > >      229 |         if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
> > >          |                                ^~
> > >    drivers/base/regmap/regmap-debugfs.c:230:35: warning: left shift count is negative [-Wshift-count-negative]
> > >      230 |                 count = PAGE_SIZE << (MAX_ORDER - 1);
> > >          |                                   ^~
> > >    drivers/base/regmap/regmap-debugfs.c: In function 'regmap_reg_ranges_read_file':
> > >    drivers/base/regmap/regmap-debugfs.c:376:32: warning: left shift count is negative [-Wshift-count-negative]
> > >      376 |         if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
> > >          |                                ^~
> > >    drivers/base/regmap/regmap-debugfs.c:377:35: warning: left shift count is negative [-Wshift-count-negative]
> > >      377 |                 count = PAGE_SIZE << (MAX_ORDER - 1);
> > >          |                                   ^~
> > > --
> > >    In file included from include/linux/gfp.h:7,
> > >                     from include/linux/xarray.h:15,
> > >                     from include/linux/radix-tree.h:21,
> > >                     from include/linux/idr.h:15,
> > >                     from include/linux/kernfs.h:12,
> > >                     from include/linux/sysfs.h:16,
> > >                     from include/linux/kobject.h:20,
> > >                     from include/linux/of.h:17,
> > >                     from include/linux/irqdomain.h:35,
> > >                     from include/linux/acpi.h:13,
> > >                     from include/linux/i2c.h:13,
> > >                     from drivers/media/usb/em28xx/em28xx.h:22,
> > >                     from drivers/media/usb/em28xx/em28xx-audio.c:14:
> > >    include/linux/mmzone.h:636:33: error: size of array 'free_area' is negative
> > >      636 |         struct free_area        free_area[MAX_ORDER];
> > >          |                                 ^~~~~~~~~
> > >    drivers/media/usb/em28xx/em28xx-audio.c: In function 'em28xx_audio_init':
> > >>> drivers/media/usb/em28xx/em28xx-audio.c:808:29: warning: variable 'devnr' set but not used [-Wunused-but-set-variable]
> > >      808 |         static int          devnr;
> > >          |                             ^~~~~
> > >    drivers/media/usb/em28xx/em28xx-audio.c: At top level:
> > >    drivers/media/usb/em28xx/em28xx-audio.c:47:12: warning: 'index' defined but not used [-Wunused-variable]
> > >       47 | static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
> > >          |            ^~~~~
> > >
> > >
> > > vim +405 arch/sparc/mm/tsb.c
> > >
> > > 0871420fad5844 arch/sparc/mm/tsb.c   David S. Miller 2008-11-16  379
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  380  /* When the RSS of an address space exceeds tsb_rss_limit for a TSB,
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  381   * do_sparc64_fault() invokes this routine to try and grow it.
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  382   *
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  383   * When we reach the maximum TSB size supported, we stick ~0UL into
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  384   * tsb_rss_limit for that TSB so the grow checks in do_sparc64_fault()
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  385   * will not trigger any longer.
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  386   *
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  387   * The TSB can be anywhere from 8K to 1MB in size, in increasing powers
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  388   * of two.  The TSB must be aligned to it's size, so f.e. a 512K TSB
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  389   * must be 512K aligned.  It also must be physically contiguous, so we
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  390   * cannot use vmalloc().
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  391   *
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  392   * The idea here is to grow the TSB when the RSS of the process approaches
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  393   * the number of entries that the current TSB can hold at once.  Currently,
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  394   * we trigger when the RSS hits 3/4 of the TSB capacity.
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  395   */
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  396  void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  397  {
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  398  	unsigned long max_tsb_size = 1 * 1024 * 1024;
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  399  	unsigned long new_size, old_size, flags;
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  400  	struct tsb *old_tsb, *new_tsb;
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  401  	unsigned long new_cache_index, old_cache_index;
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  402  	unsigned long new_rss_limit;
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  403  	gfp_t gfp_flags;
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  404
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31 @405  	if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  406  		max_tsb_size = (PAGE_SIZE << MAX_ORDER);
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  407
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  408  	new_cache_index = 0;
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  409  	for (new_size = 8192; new_size < max_tsb_size; new_size <<= 1UL) {
> > > 0871420fad5844 arch/sparc/mm/tsb.c   David S. Miller 2008-11-16  410  		new_rss_limit = tsb_size_to_rss_limit(new_size);
> > > 0871420fad5844 arch/sparc/mm/tsb.c   David S. Miller 2008-11-16  411  		if (new_rss_limit > rss)
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  412  			break;
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  413  		new_cache_index++;
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  414  	}
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  415
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  416  	if (new_size == max_tsb_size)
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  417  		new_rss_limit = ~0UL;
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  418
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  419  retry_tsb_alloc:
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  420  	gfp_flags = GFP_KERNEL;
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  421  	if (new_size > (PAGE_SIZE * 2))
> > > a55ee1ff751f88 arch/sparc/mm/tsb.c   David S. Miller 2013-02-19  422  		gfp_flags |= __GFP_NOWARN | __GFP_NORETRY;
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  423
> > > 1f261ef53ba066 arch/sparc64/mm/tsb.c David S. Miller 2008-03-19  424  	new_tsb = kmem_cache_alloc_node(tsb_caches[new_cache_index],
> > > 1f261ef53ba066 arch/sparc64/mm/tsb.c David S. Miller 2008-03-19  425  					gfp_flags, numa_node_id());
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  426  	if (unlikely(!new_tsb)) {
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  427  		/* Not being able to fork due to a high-order TSB
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  428  		 * allocation failure is very bad behavior.  Just back
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  429  		 * down to a 0-order allocation and force no TSB
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  430  		 * growing for this address space.
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  431  		 */
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  432  		if (mm->context.tsb_block[tsb_index].tsb == NULL &&
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  433  		    new_cache_index > 0) {
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  434  			new_cache_index = 0;
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  435  			new_size = 8192;
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  436  			new_rss_limit = ~0UL;
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  437  			goto retry_tsb_alloc;
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  438  		}
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  439
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  440  		/* If we failed on a TSB grow, we are under serious
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  441  		 * memory pressure so don't try to grow any more.
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  442  		 */
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  443  		if (mm->context.tsb_block[tsb_index].tsb != NULL)
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  444  			mm->context.tsb_block[tsb_index].tsb_rss_limit = ~0UL;
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  445  		return;
> > > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  446  	}
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  447
> > > 8b234274418d6d arch/sparc64/mm/tsb.c David S. Miller 2006-02-17  448  	/* Mark all tags as invalid.  */
> > > bb8646d8340fa7 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  449  	tsb_init(new_tsb, new_size);
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  450
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  451  	/* Ok, we are about to commit the changes.  If we are
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  452  	 * growing an existing TSB the locking is very tricky,
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  453  	 * so WATCH OUT!
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  454  	 *
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  455  	 * We have to hold mm->context.lock while committing to the
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  456  	 * new TSB, this synchronizes us with processors in
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  457  	 * flush_tsb_user() and switch_mm() for this address space.
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  458  	 *
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  459  	 * But even with that lock held, processors run asynchronously
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  460  	 * accessing the old TSB via TLB miss handling.  This is OK
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  461  	 * because those actions are just propagating state from the
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  462  	 * Linux page tables into the TSB, page table mappings are not
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  463  	 * being changed.  If a real fault occurs, the processor will
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  464  	 * synchronize with us when it hits flush_tsb_user(), this is
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  465  	 * also true for the case where vmscan is modifying the page
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  466  	 * tables.  The only thing we need to be careful with is to
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  467  	 * skip any locked TSB entries during copy_tsb().
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  468  	 *
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  469  	 * When we finish committing to the new TSB, we have to drop
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  470  	 * the lock and ask all other cpus running this address space
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  471  	 * to run tsb_context_switch() to see the new TSB table.
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  472  	 */
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  473  	spin_lock_irqsave(&mm->context.lock, flags);
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  474
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  475  	old_tsb = mm->context.tsb_block[tsb_index].tsb;
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  476  	old_cache_index =
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  477  		(mm->context.tsb_block[tsb_index].tsb_reg_val & 0x7UL);
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  478  	old_size = (mm->context.tsb_block[tsb_index].tsb_nentries *
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  479  		    sizeof(struct tsb));
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  480
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  481
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  482  	/* Handle multiple threads trying to grow the TSB at the same time.
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  483  	 * One will get in here first, and bump the size and the RSS limit.
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  484  	 * The others will get in here next and hit this check.
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  485  	 */
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  486  	if (unlikely(old_tsb &&
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  487  		     (rss < mm->context.tsb_block[tsb_index].tsb_rss_limit))) {
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  488  		spin_unlock_irqrestore(&mm->context.lock, flags);
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  489
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  490  		kmem_cache_free(tsb_caches[new_cache_index], new_tsb);
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  491  		return;
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  492  	}
> > > 8b234274418d6d arch/sparc64/mm/tsb.c David S. Miller 2006-02-17  493
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  494  	mm->context.tsb_block[tsb_index].tsb_rss_limit = new_rss_limit;
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  495
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  496  	if (old_tsb) {
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  497  		extern void copy_tsb(unsigned long old_tsb_base,
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  498  				     unsigned long old_tsb_size,
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  499  				     unsigned long new_tsb_base,
> > > 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  500  				     unsigned long new_tsb_size,
> > > 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  501  				     unsigned long page_size_shift);
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  502  		unsigned long old_tsb_base = (unsigned long) old_tsb;
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  503  		unsigned long new_tsb_base = (unsigned long) new_tsb;
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  504
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  505  		if (tlb_type == cheetah_plus || tlb_type == hypervisor) {
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  506  			old_tsb_base = __pa(old_tsb_base);
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  507  			new_tsb_base = __pa(new_tsb_base);
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  508  		}
> > > 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  509  		copy_tsb(old_tsb_base, old_size, new_tsb_base, new_size,
> > > 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  510  			tsb_index == MM_TSB_BASE ?
> > > 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  511  			PAGE_SHIFT : REAL_HPAGE_SHIFT);
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  512  	}
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  513
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  514  	mm->context.tsb_block[tsb_index].tsb = new_tsb;
> > > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  515  	setup_tsb_params(mm, tsb_index, new_size);
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  516
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  517  	spin_unlock_irqrestore(&mm->context.lock, flags);
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  518
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  519  	/* If old_tsb is NULL, we're being invoked for the first time
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  520  	 * from init_new_context().
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  521  	 */
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  522  	if (old_tsb) {
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  523  		/* Reload it on the local cpu.  */
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  524  		tsb_context_switch(mm);
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  525
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  526  		/* Now force other processors to do the same.  */
> > > a3cf5e6b6f2548 arch/sparc64/mm/tsb.c David S. Miller 2008-08-03  527  		preempt_disable();
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  528  		smp_tsb_sync(mm);
> > > a3cf5e6b6f2548 arch/sparc64/mm/tsb.c David S. Miller 2008-08-03  529  		preempt_enable();
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  530
> > > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  531  		/* Now it is safe to free the old tsb.  */
> > > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  532  		kmem_cache_free(tsb_caches[old_cache_index], old_tsb);
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  533  	}
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  534  }
> > > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  535
> > >
> > > :::::: The code at line 405 was first introduced by commit
> > > :::::: bd40791e1d289d807b8580abe1f117e9c62894e4 [SPARC64]: Dynamically grow TSB in response to RSS growth.
> > >
> > > :::::: TO: David S. Miller <davem@davemloft.net>
> > > :::::: CC: David S. Miller <davem@sunset.davemloft.net>
> > >
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests
> > 
> > --
> > Best Regards,
> > Yan, Zi
> 
> 
> 
> -- 
> Sincerely yours,
> Mike.
> 
