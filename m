Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533106A3B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 07:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjB0GCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 01:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0GCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 01:02:49 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD05E384
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 22:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677477768; x=1709013768;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oZrWbQLwOJv0V7qXbWVZbEbSrPxdmcSG/TkS6STZ9p8=;
  b=HFSlprw69poJv3CRbWUKRrxkTs12kWDf8SbvQQ4mvxDs5uhCMG00GNvo
   bSMnIX6goUbUNTtY3Z5q1PyxbWVV9SKfp4RYYGoSJ8MBlhS3hBVJOg2cl
   qgUKtIuLX0EmHafAE9j9j61mgZ7HF1i37+1o8lxIqAR7/DPkbwQE8ps6G
   Fj7EzKsE51lvZYUoMkIDE0NFkOvYX4X90xykAqpK/KeWlBqyujIwa5AP/
   RloavQWFYkDmBRw7xTfFZ1FFcUtr6EXqkb1bzXKbADv3oBEs5/t1dLgsU
   nHyXeIO0tuVOjERCM7TSJI1MV8B0UZd/ja/95aeRxoSvyl0uJbBZxJ7Di
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="333827737"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="333827737"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 22:02:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="816492793"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="816492793"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2023 22:02:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 26 Feb 2023 22:02:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 26 Feb 2023 22:02:44 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 26 Feb 2023 22:02:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fny9eOzovKzw1FcnzH6Nv5z8x7gIlJDLciUycWNMbON3LphepXy2UoEh4S3upFJaJyDQcqDQ8WO7JUzWL/ftDOZ2QTPgbn1FkZlPRUO+1Y3rRKPRsUR6hRJ/CJpCvHp7y18D9rKYP8C+eE5gmGkSUJ76iyQ65MWgK7//1MXjn2FvZR19OPsFAPuNsiyPjit8d64gRoG7YwbWk2NMev9m1yp4rWOnixsg7NMuQLX+RgrOBsFLmSTZSKZ/R6K0zH9ew0sWVGR9fXbyqXvu2xwm0zc6zVMavt6ew+K5/CxQUQPrIpZLlBa8SwefQizQZhQRh/xytDim0o6oCUUdvSjeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TVtOWsmD3KDTTX8TKUaN4hyRep30Obmzs/LCmcG33w=;
 b=agZdMU2skEo+pfX84qEHiUUX1hyw+R6sqtdH4QZfTSVXsxPBcWELJiVaMWmNTDzENeiiCi+umZqUzayzVod3m2B6/EaFoXuB1r65eLsOO9uPIG9qylB3diLTiiYYrYj/rn6isfUPSKuwZ8AAm2HMwleZdiu7Udzf2AWVoNA/G5M4z+vw2issAHDjsVCaPu8ZeLTab+lxFyYJRlVGbQ0EJd2eWg/0uVyGfPRtDdRVQlowwkgBGXDVxGrZvIc71kDRdFaF+Dd5ozg90O+dNyD4sLFLavpbFvGbbq8t3SDHnqEg5WAwZf/BOQJsQ5TV9cSQ4T7OWN7+1HMPrpk/eZ6UYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 06:02:42 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 06:02:42 +0000
Date:   Mon, 27 Feb 2023 14:03:56 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <baolu.lu@intel.com>, <yi.l.liu@intel.com>, <kevin.tian@intel.com>,
        <heng.su@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Syzkaller & bisect] There was "iommufd_test" WARNING in v6.2 in
 guest
Message-ID: <Y/xHzER5ZO482zEH@xpf.sh.intel.com>
References: <Y/hOiilV1wJvu/Hv@xpf.sh.intel.com>
 <Y/jOTXCgySjAQnuX@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y/jOTXCgySjAQnuX@ziepe.ca>
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 30efb135-414f-4c87-fca0-08db18883cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCRLZLOibgmKIec/n1OloGjhKLHGWgPYJaRFeGhRK1y4s1AN1PODtrbjFKCIT3xsl3LLcJyCJD9FS4QOA/+pZEahi59rX8OY40sbLfzUrgE0dty0pwRhoYsNHKHpGGGtaXXtS1U2ephkaU7vgZQkUSI9JF95EL12X1Rww6wUPrzu0/ya7Cqg+wGShjKoVv+B0NVYM3KR2Weo3GpSyxbUBZ535rtryi/XGmKxehgVsa/6pre8IwSA6CcxguVF7QShs9pYBoe82k92YkWPXmoVTStnOUBqyyEXbD2k856EuvIGnALjGp9A7H7c4xfvsblM8KI4BYtvHoCFCEZ1EdlXg3V521XaVys2MD9AvPN78+rm5eGzCBRg5ZmQaCvtkoPloZ6DSzKKlbeSgxNbPSo5xPnkcl0ckLFJ66nOFJADsiMKF8BCZdynve9WB+e5mav3YlMVP42PLa4efUdcaaGHx1IFRAiUBWaRnEIVK/3jbjmo4XBGuAlYtpQgYSDmevFvvSkxxOmaqpSNmgE6JDLxNQbTMrD2aj0XndPUH3fm8o0KMmF+uX0PLthoEZjnKjm2PuhaMTujMVrS3QkmMdjiyTQ3StGWbgxilx0E8IPTr8Ag/IKTpCxy1M8f8YHhutRqdvpq+1eziDmsHmSPVB0+YxodAH+g2ZsZQTjuX7BHouU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199018)(316002)(6486002)(966005)(478600001)(45080400002)(5660300002)(8936002)(2906002)(44832011)(66946007)(66556008)(66476007)(8676002)(4326008)(6916009)(41300700001)(82960400001)(86362001)(38100700002)(6512007)(186003)(26005)(6666004)(6506007)(53546011)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wuzIzjAIxoz8EkWCxJiZm3lfBsrv7xVj6tGGiIojmCMYDi2wOs0gmT19slhS?=
 =?us-ascii?Q?5FwpoVMVplYUP4c4RVIW2nA0IqWSrT2ntYza0T+lKOIB/RyjVDtJlvn3mDxb?=
 =?us-ascii?Q?mktbx71NqmfXhYvLQdt70spTAApOcu1af74ioISXydBIW/uaLf6jgPqztu3F?=
 =?us-ascii?Q?vdip4g7atIaKrR0rXNNm6iejMxQnEv/WhIg73pM1FjlP/0vTpBmV6OVCj96p?=
 =?us-ascii?Q?3KBBu75jk9KRpAga13OhANp36Cfky74suIA5b45X+5pMclyeyMkMhTY348g8?=
 =?us-ascii?Q?8JXw3fcLJbknQug9/rZvFheR50hkYYfj9WDXa9KWAXm9/7qRoxFwzI/EQcJQ?=
 =?us-ascii?Q?AX8svy8jlgVHlsFQr8fV9ZF4teajSOYobiCBWQez5V/4I625TDJRHd8+NlIP?=
 =?us-ascii?Q?pWYCb8lHY+g+cibsey3LLj7phVYQZ85MdmjQO1lA7HbMEkDbgQrE8IAHVv02?=
 =?us-ascii?Q?16ofpdafScZUCgNe/v9lgon6pnfvdQSDWpnVMUDdugyGxlp7wNfQZUPV9QDH?=
 =?us-ascii?Q?N2srwCjA6IQMcIYFHl+vWac1di5nhBD7HCtfGS68ywd6AN43djM886u0qt60?=
 =?us-ascii?Q?97HGqkhbvL+ulBQ/ZLyYYQm0FMPSJHbssmt9zGKQnITgQQA2L9vswytQcDvM?=
 =?us-ascii?Q?IGxkrlDhMvfxsoSBEKf9X60GC2C9n8DWnCBFPp3sH6r8SuZJC7MAo5RuIDNN?=
 =?us-ascii?Q?9cnScsNo+AR2Ie6U38LEBiCw2z4SfkXRHpC/V1yKyN+/Pc2mEjpyvYPLXgkE?=
 =?us-ascii?Q?2E8g2EPUXU0+jEbkg/7WBBdAk4Ea7zY3uCPj9lmejNzr/gz9FNKC9CH1AJXO?=
 =?us-ascii?Q?DOST7GiuR1DFFBYXCBRksmDtxmkc8YcyMc/kVaDU6/Mb0nURo+LU9yaFlOZZ?=
 =?us-ascii?Q?53MGjDKDvF064qs3UXe5OiUJ4dZ/Mmvz1grgP50T3NypFaeVCF4GNd//Ky/H?=
 =?us-ascii?Q?iIGBapDcKcZU+C/LXQJWnzi2MdDm33RxCG+eiD5mhJ+MCDfBiIOnyuQCUSkQ?=
 =?us-ascii?Q?u0UNohA0M420xhWbWwFkhHuX4qVS/L5LXrPvu9ZUXxb+rYBC0v8uQQGFg4fo?=
 =?us-ascii?Q?irn41mkqtQjTTVEMQ4iRcHpNO9HO8ZkyQoOZdhKzo6eZg8Io0rHtZRvuV9LB?=
 =?us-ascii?Q?thbYlfAKjhEiBL9jEQR1oV5BJdou257H3inYQ8hyZuQIiNm4Boh+8KzDg4yT?=
 =?us-ascii?Q?k7CXRH2bJSM6htRHy7qQM0UXK2BT9fsURRtRIUTTFXYmwt86GuGvAaR0t3nH?=
 =?us-ascii?Q?sG3A66USOytaSf7ziBejxkQHVwBewNHHM0N/gI7I+pfGAJMcON0sJyPYl6/t?=
 =?us-ascii?Q?K0RkRmL+S4KFG2lm1qaHIBPm3NhnWPBzy6QMTXyT2WvTkYVLqKz5GDbvRyxy?=
 =?us-ascii?Q?fk6fL2oYpKU+vz33+LFzc84CPmL2vngzj0iWgC0lKxNT20X12KwI6/2rTlhf?=
 =?us-ascii?Q?NqHnw7x/nHhtoH1JdmqYa4RxC14yoflmXWWL144K8PFJvgL4s28QtkNjJfEb?=
 =?us-ascii?Q?bN2Pj0VEs8iDc7+3jzAmEv6tbJdPXmFoAxfUROgfvIY4PuPDaLEaD9frW1ZN?=
 =?us-ascii?Q?yXRQ9o9msvQrDjeRYcxVKGZFj43PSh//DD9nkmpZydrZnB6gsFV4NWV4dqrv?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30efb135-414f-4c87-fca0-08db18883cac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 06:02:41.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJhnn3oJO3noXpYCGIUE6E4kCwMOosYUN6ti0VUHfmtOhALPWO3ITfVd5yzvIVKHYPDPijz4chgRE5p1bG+DAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 2023-02-24 at 10:48:45 -0400, Jason Gunthorpe wrote:
> On Fri, Feb 24, 2023 at 01:43:38PM +0800, Pengfei Xu wrote:
> > Hi Jason,
> > 
> > Greeting!
> > 
> > Platform: ADL-S and x86 platforms
> > Host kernel 6.2.0-rc7 which doesn't enable iommufd by host kconfig setting as
> > below:
> > "# CONFIG_IOMMUFD is not set"
> > 
> > Guest kconfig with iommufd enabled: https://github.com/xupengfe/syzkaller_logs/blob/main/230224_044002_iommufd_test/kconfig_origin
> > Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230224_044002_iommufd_test/repro.c
> > v6.2 problem dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230224_044002_iommufd_test/v6.2_c9c3395d5e3dcc6daee66c6908354d47bf98cb0c_dmesg.log
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230224_044002_iommufd_test/bisect_info.log
> > 
> > There was "iommufd_test" WARNING in v6.2 in guest:
> > [   32.012827] ------------[ cut here ]------------
> > [   32.013027] WARNING: CPU: 1 PID: 393 at drivers/iommu/iommufd/selftest.c:403 iommufd_test+0xb19/0x16f0
> > [   32.013410] Modules linked in:
> 
> I didn't include the IOMMU_TEST_OP_MD_CHECK_REFS in the syzkaller
> descriptions, how did you hit this?
> 
I am new to iommufd feature, and I'm not sure how syzkaller got to this
unexpected test point.

Anyway, I provided syzkaller repo top commit id info on that ADL-S:
commit bcdf85f8bd3fccff5bc9507a589c4847d9b35405 (HEAD -> master)
Author: Dmitry Vyukov <dvyukov@google.com>
Date:   Fri Feb 17 09:58:24 2023 +0100
    dashboard/config/linux: enable DWARF4 for all

And I didn't change the file "syzkaller/sys/linux/dev_iommu.txt.const":
"
...
AT_FDCWD = 18446744073709551516
IOMMU_DESTROY = 15232, mips64le:ppc64le:536886144             // 15232= 0x3B80  =  IOMMU_DESTROY  =  IOMMUFD_CMD_BASE
IOMMU_IOAS_ALLOC = 15233, mips64le:ppc64le:536886145
IOMMU_IOAS_ALLOW_IOVAS = 15234, mips64le:ppc64le:536886146
IOMMU_IOAS_COPY = 15235, mips64le:ppc64le:536886147
IOMMU_IOAS_IOVA_RANGES = 15236, mips64le:ppc64le:536886148
IOMMU_IOAS_MAP = 15237, mips64le:ppc64le:536886149
...
IOMMU_TEST_CMD = 15264, mips64le:ppc64le:536886176       // 15232(IOMMU_DESTROY=IOMMUFD_CMD_BASE) +  32 =   15264 =  0x3ba0
IOMMU_TEST_CMD_SIZE = 56         // 56(0x38  for CMD size)
IOMMU_TEST_OP_ACCESS_PAGES = 7   // no IOMMU_TEST_OP_MD_CHECK_REFS:4 in the const file
IOMMU_TEST_OP_ACCESS_RW = 8
IOMMU_TEST_OP_ADD_RESERVED = 1
IOMMU_TEST_OP_CREATE_ACCESS = 5
IOMMU_TEST_OP_DESTROY_ACCESS_PAGES = 6
IOMMU_TEST_OP_MOCK_DOMAIN = 2
IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT = 9
IOMMU_VFIO_IOAS = 15240, mips64le:ppc64le:536886152
...
"
I didn't change syzkaller/sys/linux/dev_iommu.txt and
syzkaller/sys/linux/test/dev_iommu also.

# [root@p-adls01 syzkaller]# pwd
/root/syzkaller
[root@p-adls01 syzkaller]# git log
commit bcdf85f8bd3fccff5bc9507a589c4847d9b35405 (HEAD -> master)
Author: Dmitry Vyukov <dvyukov@google.com>
Date:   Fri Feb 17 09:58:24 2023 +0100
    dashboard/config/linux: enable DWARF4 for all
[root@p-adls01 syzkaller]# git diff
[root@p-adls01 syzkaller]# git status
On branch master
Your branch is behind 'origin/master' by 51 commits, and can be fast-forwarded.
  (use "git pull" to update your local branch)

nothing to commit, working tree clean
[root@p-adls01 syzkaller]#


I'm not sure how syzkaller hit this unexpected test point:
https://github.com/xupengfe/syzkaller_logs/blob/c7cc00a25b3f5d1efd4b83bf3cfc552049628c96/230224_044002_iommufd_test/repro.c#L34
"
  *(uint32_t*)0x20000000 = 0x38;
  *(uint32_t*)0x20000004 = 4;
...
  syscall(__NR_ioctl, r[0], 0x3ba0, 0x20000000ul);
"

Checked IOMMU_TEST_OP_MD_CHECK_REFS in linux_kernel/drivers/iommu/iommufd/iommufd_test.h
"
enum {
        IOMMU_TEST_OP_ADD_RESERVED = 1,
        IOMMU_TEST_OP_MOCK_DOMAIN,
        IOMMU_TEST_OP_MD_CHECK_MAP,
        IOMMU_TEST_OP_MD_CHECK_REFS,          // 4
        IOMMU_TEST_OP_CREATE_ACCESS,
        IOMMU_TEST_OP_DESTROY_ACCESS_PAGES,
        IOMMU_TEST_OP_ACCESS_PAGES,
        IOMMU_TEST_OP_ACCESS_RW,
        IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
};
...
#define IOMMU_TEST_CMD _IO(IOMMUFD_TYPE, IOMMUFD_CMD_BASE + 32)
"
Thanks!

> Anyhow, it is a small issue in the test suite because uptr + length overflows:
> 
  Thanks a lot for your patch! I'm glad it's helpful.

  Thanks!
  BR.

> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -568,13 +568,17 @@ static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
>                                       void __user *uptr, size_t length,
>                                       unsigned int refs)
>  {
> -       if (length % PAGE_SIZE || (uintptr_t)uptr % PAGE_SIZE)
> +       uintptr_t end;
> +
> +       if (length % PAGE_SIZE || (uintptr_t)uptr % PAGE_SIZE ||
> +           check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
>                 return -EINVAL;
> 
> Jason
