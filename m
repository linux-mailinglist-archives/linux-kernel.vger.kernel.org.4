Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F366B6F0E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344344AbjD0Wub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344053AbjD0Wu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:50:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027DB2685
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682635825; x=1714171825;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n3KiJb3gmxnAJsUhlTNI1jmn7O+ktd991191p4d/gk4=;
  b=WTyaxx/q3HjyP3PAeX4jxjwUecEbPdoT5TQeOXW5SB4eAUxRVyptzh2I
   2d9wrajfVi8RuAX3ecoiGiQLuBLBQO06A6Dov/W3eOPmDjECmw5QKWNfF
   MLKm8Awrg9wqhR43blNBfXMNuAgZtcw2KWhna5NfB1kx9hMUbK0fQ8rsc
   TrcMydaBKVkSAs/wH3vdYje87VmGN6w9LnUWLSH8CmsAhzi3+zaTHaAQW
   /vD4LTyc8WhiyuksTmLYZGk2V33++ozwrqwgXUfSE8qIvVtj+v8iDZSLz
   fUIFhPwe8ymDRIMBQXHPTAvD3qZYFXV7r2HEpbrtZjIClD0OkjVyGJ9Tl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="331873301"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="331873301"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 15:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="783957383"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="783957383"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2023 15:50:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 15:50:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 15:50:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 15:50:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jv20QUMe+xpVyzfldJ47j/leGLGaHAKFop0wmRISC3bQZorM6g4DUgwpV8RlzaEZd3yIroEQ7tV/n33UW3RE29zafCA8ZLn0sbq0desRqaCA3u1FZZaAooanC9CTsdHv3LvVg1bBtrEbYDIHojzmupiegCcXdvZ1e/gw35W7G7S2ALOigJj8Dv2cOoPAb9pErdEKMlkKfEZVHmOTZxeA6NZdoUKZs1CkFmF9wcuS+ycJfb+E8PsnCEA128UsIknZvarnEP+gOJdrWI91O23uKnLjn2n6lLZpTgO+mL5i7l9gkEa50DmH4GzglgspJuc/Iiu4Qykb8nS0dn8iW1Ykmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzXYhzHuaGTgEYf5ib1n2STeV6qChDTAQ+mL7sZR83o=;
 b=RBGIzQCvLLyDwNWNxc6c3UkK850VE1yjp17x/kXhQXql6JUqTK1A1SqtHU4lygEikt0ojHdqBcUyMIiwg4HXAM2BgFmGGvzJBtBBrMRX0yQCQWdi9RhHpT0je/GmQB8yYNY16O1GStTEutetcLWQ0wn2dLA6D++u0Eh/t3MjRvQvKiLRcTEzn2F9Aot9eaL9tZMKJWPeRFm/bzU18FcLwwEqh/KAdk9pfnVfmCRtycxoDj8tHTkSyBkGZSHoKCwkyQXMNLmOvKvTaz/26KTHTT81aF4est1SFGCt4n2SoiDcUG/OgW/wxftqo6e7F/UQ2MqOjzgTQXhlJEsPxgsiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 22:50:23 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 22:50:22 +0000
Date:   Thu, 27 Apr 2023 15:50:17 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Li Zhijian <lizhijian@fujitsu.com>, <x86@kernel.org>,
        <nvdimm@lists.linux.dev>, <kexec@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <y-goto@fujitsu.com>,
        <yangx.jy@fujitsu.com>, <ruansy.fnst@fujitsu.com>,
        Li Zhijian <lizhijian@fujitsu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2 2/3] drivers/nvdimm: export memmap of namespace to
 vmcoreinfo
Message-ID: <644afc2952c25_1a1c5294e0@iweiny-mobl.notmuch>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
 <20230427101838.12267-3-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230427101838.12267-3-lizhijian@fujitsu.com>
X-ClientProxiedBy: SJ0PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: f75b294f-49f8-434e-e885-08db4771c87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mje7oR+jYSOCD0F2t5bgyI96GaC9IUXZusRLU8yD4jlEud4Ri7vv1NLuTXJzJHe3INaTCYW0I0h21MJIWjCPVMf/im4zxNF1A8b91nElUlg128ay8s8qpAM+Z/dSutv/0GuTppYME5+2W4TuJSxpXu58dwagmphhH4XWclm1h3I+UjRv/K9TXdLJVYQpPVfjwTfc/cNUHS1jnO7xJszXkA1zObEqEo05pwVcOGv2j4Z21m1NcPvWvaZCjBqVLRwvgV//SD/w8jGJXtdzEYkJ4ZA9Bsq/poqTqHaO3s9lcIw2+1xnjnG3LMkcrV2qXQoUkdPjZYVyWjCfw7u243RzYaLnV7uxR7AO3BJ0EyJ8bYbCCae6wmH3HNasm3aKSuJNgz6TFg+mDit4L0Spp+D+1M+xOhiUXhGMbQ75iCu99G38DT8cs2RYVAyWEnYGPlJartaIjNZW0cZA2802reehm0VFsyWU4XbXe4r3B9OX7d0gr17QQbAucwlqiv/xz1Hhpdzi7KQc/YE06HBoIpTRGBRJqT6A6AuglOTSNuGlRXcjn2Lv7kfpEI10tCAEVVT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(6666004)(82960400001)(478600001)(83380400001)(54906003)(6486002)(186003)(38100700002)(66946007)(66556008)(66476007)(316002)(4326008)(41300700001)(6506007)(6512007)(9686003)(26005)(107886003)(86362001)(8936002)(8676002)(44832011)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MunvAZePN7Qy1hLHyJEb9xgXL5UrssEGNptpqebX5r0bDk6811s2rEQnGB1b?=
 =?us-ascii?Q?aDiM4GydZmzxVD/WJIRH35L4kftn8B+voOObbNnECjvVTIC9yIdwjfnoB0bJ?=
 =?us-ascii?Q?TH1aH0M09REVE0k9XcwxLzzWHWOaaB04pOQx3hLk584KZrBn8KwGfVN8RK92?=
 =?us-ascii?Q?OBF3Ql4/c7VkfMbc7+d83a40Rkl+NOPmGsIEyOQgHR+DwWtpdndoiMptAY1R?=
 =?us-ascii?Q?7xfy93nwPYwRoVQMKwx7PeKAw6HmOGKULOs7ZxUI7Rgd5JmkBDnErbH5QiXf?=
 =?us-ascii?Q?gQRChyIdlZ070iWpPHxu4uN8IPN9gBN12lCC4XoxpElPEiPAxE83VUYYMgm6?=
 =?us-ascii?Q?7Go50vAdjpdwWYEOTE+t5us6XmdM2CJrSNCgs8kFX563gm0sytwcea1qx0k1?=
 =?us-ascii?Q?H6QSUTxRGblGbqCjsr67SlEERTsY+fxadBykUb8VR4lNbOozFC3JmIxjsOoW?=
 =?us-ascii?Q?fU8AL63VP7pTzpb2v5u6GgHzQBd+TB770Xjz8oEq+qsieh2AjeJDyy9zrCkq?=
 =?us-ascii?Q?LN/lWWAyRx+Bx0ivvB+gUco160TjG0T7eCWtD1Pras7ZkFqSzJMsozOffP77?=
 =?us-ascii?Q?WV7QAMLL6tk8gNJAktvrw9Y7jpMUTdllYKiBTduYzYCeiGhwksdY4ll2XhB6?=
 =?us-ascii?Q?tNjf6Ovcu6PEf9Jorya4624e9U0ODnuskgg7Zr+vi0GXIr1GC0S04UvqqpnM?=
 =?us-ascii?Q?/h3Jq/WmpGKk1Fr0ObUWdhurKzqE2sBERKZnZkoko/aqrmdTOaqxRVQoxWem?=
 =?us-ascii?Q?invG0Pt8Mk9nzN18fHuFcxvOReRXzM3kBBBQgFMTZfVeopJ8GLovUbd8Q9Ub?=
 =?us-ascii?Q?DUPfocgPjG9H9IFrYKUvtZ0Edio5qUU6D85KM/f4QNHrpFsXYfYI0KusH/zx?=
 =?us-ascii?Q?b50/DBXwwkhLJ8+bPTgb2+RC5o+yBQYSU3BmZW8ZIcOFusjC/wGq8Zhk4r1U?=
 =?us-ascii?Q?BYTj4IyB1q477kM7/zcXf8+fsfYjgq9JATbqxdZKKt5LHMT7EGzVjqh9luMD?=
 =?us-ascii?Q?VnXFiiPml6+kZEBg7Hj9zQLiI1vJz4b2bKHr0gjYfUb8muwHqaKQ83NL3e66?=
 =?us-ascii?Q?I4KTtUZmxnFuQRUklfPutSoG4QuYsH5wlPwNQ97ukXqz4mceXa75t3nB9eHu?=
 =?us-ascii?Q?/plqwDVIskQGbWuOkTvLS/dYP6XJUsE9nOmin3bUIlvmTUXeJou7l95NS/jG?=
 =?us-ascii?Q?/e/qEAJT6Nutc/2GVAd/rMV/MWruaP+Uk2heh/yFy6OACeh5JcCpAKmdz8qq?=
 =?us-ascii?Q?g+9rRqmzppw55saSblDoKuKeI7PUv8OMFn1kA3gathX61B8GaxU3Mr7yAy69?=
 =?us-ascii?Q?tIF6lLceOmy8+CRlngWULZ4actr+GqLGzY0ThtT947cdjdWlkOxttu0nq1ha?=
 =?us-ascii?Q?zY6PEZ4heeoZRfROYIh6kMhnK+YEQTPr8lR389zjcH8zL149Nmk0TCKdSsXY?=
 =?us-ascii?Q?rb8TG5iD7SCI3Qr7dwjYLTJ87N0MmoFcYOXWc6vSIlSgMq8XS7bwhxDrARyU?=
 =?us-ascii?Q?9TspXZk9cKYQXUzirTOKFJkSygvVzkjyiNxKieYgK83eVaXpIGDBgq9N0Xif?=
 =?us-ascii?Q?7ER9tZLbrKCMBHA0y6fElsUh9DDGmdmlRpn4wmOr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f75b294f-49f8-434e-e885-08db4771c87b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 22:50:22.6871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwCjZXum9kqHmmxKxqWuwRmim7o6iGpDapzzqBXXuf1q2WR0v5O4hXPJ9uLJCmb3ZXoCV/udI5NRsbB6kJzghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6020
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li Zhijian wrote:
> Each namespace has its own memmap, it will be udpated when
> namespace initializing/creating, updating, and deleting.
> 
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Vishal Verma <vishal.l.verma@intel.com>
> CC: Dave Jiang <dave.jiang@intel.com>
> CC: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/nvdimm/namespace_devs.c | 2 ++
>  drivers/nvdimm/pfn_devs.c       | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index c60ec0b373c5..096203e6203f 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -8,6 +8,7 @@
>  #include <linux/slab.h>
>  #include <linux/list.h>
>  #include <linux/nd.h>
> +#include <linux/crash_core.h>
>  #include "nd-core.h"
>  #include "pmem.h"
>  #include "pfn.h"
> @@ -853,6 +854,7 @@ static ssize_t size_store(struct device *dev,
>  	if (rc == 0 && val == 0 && is_namespace_pmem(dev)) {
>  		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
>  
> +		devm_memmap_vmcore_delete(to_ndns(dev));

This seems like an odd place to put this.  Could you explain the reasoning
more?

Ira

>  		kfree(nspm->uuid);
>  		nspm->uuid = NULL;
>  	}
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index af7d9301520c..80076996b2da 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -9,6 +9,7 @@
>  #include <linux/slab.h>
>  #include <linux/fs.h>
>  #include <linux/mm.h>
> +#include <linux/crash_core.h>
>  #include "nd-core.h"
>  #include "pfn.h"
>  #include "nd.h"
> @@ -716,6 +717,8 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
>  	} else
>  		return -ENXIO;
>  
> +	devm_memmap_vmcore_update(ndns, altmap->base_pfn, PHYS_PFN(offset),
> +				  nd_pfn->mode == PFN_MODE_PMEM);
>  	return 0;
>  }
>  
> -- 
> 2.29.2
> 


