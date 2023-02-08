Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E004568EA31
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjBHIu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBHIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:50:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E3645890
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675846255; x=1707382255;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GTQa8f3kuB+gTITyuOID96hrEXZh6z3Bf6RC8iwpRJI=;
  b=OGpE6Ud8zr1XM1h7SKhkY7dk9Mr1/TcE/pYIsl6yt6yTJ/WgmUCHPk4A
   xUNVFZC+ewp7q5u2HUc894nLcYcxZNGY7draJlPVTGmta5O/LIFWrqgn9
   jRGQ/l2TesmdnoWkGNz7nSr+4Dx2rjdCgmIV2iMAsrS7Y8lH2mPkgM3Er
   U/qG55t8OXc71ceEKzNbBT2zx//FTM5KWfJs6h7cZn8++hE8FuVdPCIrX
   zImUORvmFE6ijIqcEBQa9iwFT1e6CJT59ZslteTJ0Cgs5rhbAN17pS0WC
   6jVdRFwz0dguyQZMTTImHf/TKXP4zKwA3fs/fiwppAYbs/H1MJIePKH+c
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="357135413"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="357135413"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 00:50:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="809871423"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="809871423"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2023 00:50:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 00:50:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 00:50:54 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 00:50:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnRhi5aSqdfFgEOieIb8ltSkE0BiSMIA2muSlUtN3Q927PFrgThqpG8qFZivgCLnFKPv4Fe3+QQ7ft+pDlS8be0ZT05U56lbktV5beFlAK2iMxp7GN5ACJN9BghEVHxhCDUoGp5jCC12TjdKsXxE9MQOJ0hGEKQMMt98Y7Y2NiXDpP+lCT3csY78eY3cSY1QRvwy0HbBMGXrO6uMEB+IJnNloA4ZV/CKmcTSG1+gDzINKqI9fYm/JHniT3v/rnQ97xBGWOiQI8shu+qMM8AoaaUJ8FlIVXM0ohVwKnwI2qJqUDHnHCidsPKDMoRTy1T5H9zs7/hlZADj7087zETLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cuo/zr60mpb8hiWbmFIj9d7rKEv1ssDS684emp85MLw=;
 b=joX32u/UghjfE1wEszrUVIPyUUVL6AM40qcJ86ZyZdkNlr8VKeSqGdcRJ3zGrN3p04NoJPJv7pFxgNTpCryplHE+VwPvCQs/cDAO7Q3DyynQk9+r6b8Kj/y3pE4uWJ4mTKAOqLhYjaXwfbTBsOoro+Z8ClANFUw6e2+hGYERT1/cD2PIORvJEvl6v427pOf1rVnH0D5IiRPmTY2zTjZAYKxj0Pl6Heg6dgPdJcZfhNyzKen/3oYUd7S4frjX0eL48bKKv+AZagH+QUIkK6JMOSWaK6Es8cV764MwqIdjSVwQovRZF8BMZ9jcZahbSPdXnSTs3dFEDeGUJ+zJ5LTbYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MN0PR11MB6181.namprd11.prod.outlook.com (2603:10b6:208:3c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 08:50:50 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb%8]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 08:50:49 +0000
Date:   Wed, 8 Feb 2023 16:48:16 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Patrisious Haddad <phaddad@nvidia.com>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: include/linux/fortify-string.h:414:4: error: call to
 '__read_overflow' declared with 'error' attribute: detected read beyond size
 of object (1st parameter)
Message-ID: <Y+Nh0JNxnn3ZNQFv@yujie-X299>
References: <202302080231.ZqOmpanX-lkp@intel.com>
 <Y+KgMv3Coc4gnV2p@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+KgMv3Coc4gnV2p@dev-arch.thelio-3990X>
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MN0PR11MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abc2f31-f688-4643-1a28-08db09b193ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QbqKjSe9G9iDloAfg1rkxEeqZzdO7Jl5FCwJRc7cEySZK11//4WXxnjQDQkbmqZ/LSXx2a+p9fhgNHVTf3USnyUOGnagyWwyHlTHJJtdS16hnqlbuwuqxbIlMBP7RE19etSNnMxjez/isJWT03ywzSGgPU3hePMrrvVnaRMEfnFTFCc2E1vZqle3XY63Q3Q9AFJdImA1YsWglwBj/K9wzxs95nidakHGcRTIBBGEVupmV/V79AgztScdHeD1WCuqUgqUVYnZfS4t3lAIZZbzm1/6MOHlImL0G8jOPVWXsHvJQjWkTsN7jmump4rUmQbqWDXRWo+7JS9Jo2DBIu5vC1nxbAR1O5C/KU0hYzkTxjKKTpVGq3XpFZW7ngZ+0hS7ficHZjqIPDixy4VHBMZawlJslPYV7gOahFAarsYO2NyUJfpYEN/oeq5ekmj7nw2Hv8TWDSBNkNghhJCO11HOKMQVdEWF+vkGoWwwB65LpIHJiEphPWbZhLynxTuPmuE49gHwKikh5WTmo6WG78BNg3jrVo874aKKEN5RVRDsSVbmDRFjBG4erMt1LDfu4EXJgaVmkYGiNtqwjnxr47pSoF22POJdXYtoYJcCHxYrLYsOILPDDWrrIOYCrtkQqoXyKgv0+3lPEgkJV7GWWEgDJ44lRnBWcgkBI61T3BuFRmNQSpb9npnAQ4GRUkdTsxklfj+q27UdBE+am9IP8q7nZmQETGi4lQpTe120sl0AuuB+aZu7uI8mOXHlEmEouYo1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199018)(86362001)(6506007)(5660300002)(9686003)(26005)(6512007)(44832011)(186003)(8936002)(6666004)(2906002)(82960400001)(66946007)(6916009)(66556008)(66476007)(4326008)(8676002)(38100700002)(41300700001)(966005)(316002)(478600001)(6486002)(54906003)(33716001)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c11qGCQ/VqUyx4YWfnSnoa55kBxWM6v7w8IlKI16BKYqpLx1xmTQhHRsWReo?=
 =?us-ascii?Q?iGID4qHI/KWDSENYWO+7bakKLrcNArPgZXpYt5wwcFzHVyj7z1hZQYWsVzW+?=
 =?us-ascii?Q?fP+MWCZFqIlbAAs0gpUJaoeqSb1zNFGcbgVRdNuP9yZS6tku2htaaPOJldwU?=
 =?us-ascii?Q?0Knh9hS+HSuj3ghP87BLIwX1DNiKvWGxTe1NJ6qdTgJigyIkO8UiqIplFaOt?=
 =?us-ascii?Q?2qAoE+jkld9g+nBUoiAgZjZsMcNSNnLrd5/u6thvzzlao/dPjS+1/zeceYD8?=
 =?us-ascii?Q?/GutqBJW4zFAfNxYTHu5jSQkK+PT8g88iBi1A97s9YA6blzEAjv7AqPLs/aN?=
 =?us-ascii?Q?y2zNi9/1kxHdLQe0Z997aaK5B0hr51UrgtdzAQDYhJPnaV1KZyvjoB3tYE0/?=
 =?us-ascii?Q?lkhJv2MYCK4O1zd1SwcBSQTQvSQgNDOJNbf9PaPJRvZdS7WOCr1vr0eZHnI4?=
 =?us-ascii?Q?ERujsvKIwf+If60TPmusSALjGytyLAUCwm913LZjvkkPtOFH46e1qo9H5tAS?=
 =?us-ascii?Q?/61PdEh5LnF4WoaNubXib+6iGgqwOXIrrSazCfJ3cCVNn++q2jcYCngdppCX?=
 =?us-ascii?Q?9wwHR9eEPUmCiNiJ7isNgi1aDVg9jWU3VqnFtZ54kMzwLAihl2eB7aQR3EtQ?=
 =?us-ascii?Q?Sw0K8tv1CwcQS/K9/IX5c+D2VyPhV/yw0XCzBpVAQZvlGYnJUeFnLV/ThZR1?=
 =?us-ascii?Q?qdl+xId7OjsXrKuclMPyLwOmibSqVZwFM/qsd4XLbCeJ5VHdG75QiFqrrCW3?=
 =?us-ascii?Q?nwDKeyFtRrCwffTdWKlEJ43gafGhhG4tjCoByM9H6KlaAVZ6lDwxVGrV9IsW?=
 =?us-ascii?Q?u4k/AeUWZmTvNQUzL+WrjgROPqC+f66fcIdOA+ymFD2cesd0fvhgp7jUL+lf?=
 =?us-ascii?Q?05k5K4buQ4tK9ldB96n5uxXZBJwxpNPiMawokmZDbhYBKJoAvv+oFPAfZAyi?=
 =?us-ascii?Q?TnIV36sWFO5oJyeWTAty4lW0KjcdwemwfD3Zm++7BDqAZwHVC6CLqPXofZ77?=
 =?us-ascii?Q?D7j3gUY1uD1PeY/GMbnVM8kBRSc17zfRMlHI5D1Hx8gKm9sPMz+OF32MaHBo?=
 =?us-ascii?Q?JHUi7ivwzUNOLOrkMQ3d2zrS10KmW4Pbz+QDsWpCNfwLlyHsisuHchVSmNSA?=
 =?us-ascii?Q?4DeVL91Rcdokjmp7VkZGfR6DcHsaPqnlT0IsG720CCy9SOo1RYPtoDMky2f2?=
 =?us-ascii?Q?mNLGmTKBf3feci7nz9Abz9U5wIC9G4ZvtcvIb5LFm6x2bazYcp62byu9nFm7?=
 =?us-ascii?Q?FcFKX2Ts8rgJvK4b67ZHtlmyc+RcNLQbfY+VBrcNhN3jfQHPuPV6NvJizPCE?=
 =?us-ascii?Q?CDQ5rgkjfRNO0ApX/gFGNHWqMOupOMSUIVYSWYQxa5pWpdCti6K1VWnleAiL?=
 =?us-ascii?Q?LLSrsmJbdSu9qQFgHbVqvUnopG3xyTlNE4HpZZfk/HqfV75lni7TpbiquTTI?=
 =?us-ascii?Q?2nEpg8bh3bIk2WHUZ1bSDgBYovgxqYWmkNVR/G6XEF23usf8qZMKrJN59j8r?=
 =?us-ascii?Q?1bKkW0UiWd3N8WMY7GnpwGxvUr1FHD4MlNnwg7bBR/W+31CE/Y9enGWDposY?=
 =?us-ascii?Q?XzT8Ypj2GKpU9I1Yry2BtoDiLZcmIheR048Sh3ZP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abc2f31-f688-4643-1a28-08db09b193ac
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 08:50:49.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7djOoU8fguOt3TZWcQTPkK0LUr/ckP76CVNn9Z0f6l5lw6tZQ+d3U9f2HkC8MpCQpmrJXj+z548vt6I76gUjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6181
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

On Tue, Feb 07, 2023 at 12:02:10PM -0700, Nathan Chancellor wrote:
> On Wed, Feb 08, 2023 at 02:59:05AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   05ecb680708a1dbe6554d6fc17e5d9a8a7cb5e6a
> > commit: 925d046e7e52c71c3531199ce137e141807ef740 RDMA/core: Add a netevent notifier to cma
> > date:   8 months ago
> > config: mips-buildonly-randconfig-r006-20230207 (https://download.01.org/0day-ci/archive/20230208/202302080231.ZqOmpanX-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install mips cross compiling tool for clang build
> >         # apt-get install binutils-mips-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=925d046e7e52c71c3531199ce137e141807ef740
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 925d046e7e52c71c3531199ce137e141807ef740
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/infiniband/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from drivers/infiniband/core/cma.c:9:
> >    In file included from include/linux/completion.h:12:
> >    In file included from include/linux/swait.h:7:
> >    In file included from include/linux/spinlock.h:55:
> >    In file included from include/linux/preempt.h:78:
> >    In file included from ./arch/mips/include/generated/asm/preempt.h:1:
> >    In file included from include/asm-generic/preempt.h:5:
> >    In file included from include/linux/thread_info.h:60:
> >    In file included from arch/mips/include/asm/thread_info.h:16:
> >    In file included from arch/mips/include/asm/processor.h:15:
> >    In file included from include/linux/cpumask.h:12:
> >    In file included from include/linux/bitmap.h:11:
> >    In file included from include/linux/string.h:253:
> > >> include/linux/fortify-string.h:414:4: error: call to '__read_overflow' declared with 'error' attribute: detected read beyond size of object (1st parameter)
> >                            __read_overflow();
> >                            ^
> >    1 error generated.
> 
> This is tentatively a bug in clang, although I do not see KASAN enabled:
> 
> https://github.com/ClangBuiltLinux/linux/issues/1687
> 
> I do see CONFIG_UBSAN_BOOL=y though, so this could be a generic
> sanitizer problem.
> 
> Cheers,
> Nathan

New rule added to the bot and will send similar reports to llvm list only.

Thanks,
Yujie
