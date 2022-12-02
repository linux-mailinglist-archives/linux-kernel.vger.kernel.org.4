Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA5E640C97
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiLBRvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiLBRvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:51:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57816E119F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670003460; x=1701539460;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vN9paOHcGe4HCQDldrcjb5cEvNT2Seh5klgU648wMt4=;
  b=Iek6g78nRfObbsE9Ie+rqXzGgyLAJGaLKmkrbf6SsXrODiSNSkWkrZuZ
   QgpLfF+4BRLVSolaXwkKbSqFnbwgp2VfCnYGuOmK8ek2w6sOuiRf1inu/
   rqrlrsGFGUW3tUTxMRedaAXPGslmL1EHiFQ0aFNuOC8FcBYwWHaVA9PlT
   lR/FbohZHaalPEqwRP3Te9GW7OeANWMBvm20WNTrZZKWayjUoX/68Fi/x
   Tns0QRkceczsMHLwOgDTsQQkBulxdO8NIjkii97AS/aforEcxvlBTeUOI
   WQipf7ahbvmiDEOc1n0o+q9h3YypVhCNstXqhzk1jfwGWjYqYMlLxDojm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314713619"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314713619"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 09:50:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="751351047"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="751351047"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2022 09:50:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 09:50:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 09:50:56 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 09:50:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+hvMy5NxtYyg+qG/Erz5NhcjMTWS/Ca4L7bjn0awQFUuLH2WoTQVWn9v4YtVp4i2gwGqs6QUsLjLrkJx9F1F8xUc6DToy7GIRvFyPJUTLD/jUD2oTaMljCOQw5rBxz/gRC/W2fKbOww+rwg4dGXuzfFxanJD0dHcTE/ULcnIimryRBzvwqZfa6PAIFHuMomjuyEzioxVI/xUu/ofueXDFd2hkOcN894ybR/hWZzfkzT+5qGhkqEgIhyWtjVvVpPXxnSKH9FOectjuKNs6g89VerPDPDtlX+r8uXKEiD4MC8MmyoiWpTSaoZtT8D52Uee0Zdm+YRTJQ4Emo+Ah7p4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzsd/qFuDwugkMK6cQ3KYKZICAGcgsL/KW4cABr53fM=;
 b=dF2yt88yQc2bt1pOcrzdNXlCgtYanBb2rj3fpqTrJn9LE7q7vYn6F6I13EComulu4MpQA1Mz7l6m4Ceh2vQaRhQ9MQETuQ5OrwZL4TAKSokUbZWbVqbdzn0AxvVQyrnhw/s1LekoDV8o9uePIF1JBaZ+QfSu1M6JN7taKvp8oWPoSZ8VJLuQI/skTxx4vkDYc0Fk/dkV1Be9064A+AYs2FLaDtcK29q7ey3GMWvD7NraJqsqnstyv1k4/1Rqy/yPnEBds61bzPhZOUJNcsg4vLsjUGudKG23lanMg6U+Hh/tv0CRwF0RVWia7EWN2uUr9ELraPydsEMW8BJauTDFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW4PR11MB6960.namprd11.prod.outlook.com (2603:10b6:303:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 17:50:49 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::513a:f91a:b65c:be1d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::513a:f91a:b65c:be1d%4]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 17:50:49 +0000
Date:   Sat, 3 Dec 2022 01:48:44 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Shakeel Butt <shakeelb@google.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Eric Dumazet <edumazet@google.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kselftests: cgroup: update kmem test precision tolerance
Message-ID: <Y4o6fN9kWHW0iJcg@yujie-X299>
References: <202212010958.c1053bd3-yujie.liu@intel.com>
 <Y4m8Unt6FhWKC6IH@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4m8Unt6FhWKC6IH@dhcp22.suse.cz>
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW4PR11MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 418e6332-2376-4b2b-7756-08dad48dbf94
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y05i+fFlt4L4eMfvq15g3uTpWUyDLOzbIjbW6oKyOKDXwN/qrpQHJsTIUXjG+x8muxC8tsgZedBcGgiNzNUunBt0aDcZDSdBoML7tHEvhi9b3kg8Zztv2KaAWdhJ7CaOpC1XO35OaAjGyfSdBKptYE/wbGM3fe0gJrImJedUBks2GYAavbWLjZqMeO6aWPhh0IKOCegLDyhjAk6T5Z1UOw6x6mtMVXIkU9l4Uolkeix/tQGgsSDojrzbXFlg309Y2Ema7y7LRewlpezezzjCthx+0K3ZZ2W9E2HUr8ABioFMZwP4NfmBbBueMCgKTo9N6hTDBF9qrH/Q7cVByutkuIYkqDlhpL8Cgi9ruWjO+c1l9JR5w+Rfk1DMBW0JKuaSZ+PWhF6bXIqbXv3qq6aalaQCp2tSck2XSitBRcDx0WrRwXYIr+SAIZoopZEkYHDho07Ke4yJq4yaf0G/5SkQ5D8A6A93k2OXSTWrORtpPrg7ip15qRbSUn2c56CotIglfWE3STgBG5F9nrsx1vQbM9mCNqENwGKCmd8R3XuRJuY2YdBniDXcXUXfu+ZJN48OM+wlMneVjjL7NfyiEYfsX4fCbYbhU8mAZshUrbGaFQHuwDtb+6ZwF651ba2esx6uPin8Gne4S0XOL2ddbDEOrsJzmCMUBehSTl+COmH7OIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(86362001)(41300700001)(186003)(66476007)(44832011)(8676002)(4326008)(6916009)(5660300002)(7416002)(6506007)(6666004)(966005)(316002)(6486002)(8936002)(478600001)(54906003)(82960400001)(53546011)(9686003)(26005)(6512007)(38100700002)(66946007)(33716001)(66556008)(83380400001)(15650500001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dGCEBsAaOqNyeRILc3VtQPoKTkYFOkLBmE36zWT5+6iahO/5BA0Q2L7MRjJo?=
 =?us-ascii?Q?RYgXmamAhvMWGmL6CdH8M8U9QMTwNpr9rack3UytcVG3IauPxzqxV2dltaLA?=
 =?us-ascii?Q?X19ZWPGh54pQ0jxF+vz/poI0VGFMTy2sAbMH1dVgI9xZcoOA14vmKJ0OB3a/?=
 =?us-ascii?Q?7qQSvpB/5AUz957Q90gCWWqj8iI6yPSV/gvs63mi3SYwqttmO/9ivfLvlIah?=
 =?us-ascii?Q?AvOBzELrUX1c2WTRV73hJhLPf0JuOFUzr+poZUT/OUR+P84EYM3mXPQQ5+kS?=
 =?us-ascii?Q?RslMlCPtFF5tYH5I/rzu9oZwVoUzMUxY5G56HT7tNqxfOKttQMW7tzJ1RI6g?=
 =?us-ascii?Q?YKz3+jxITqQ1BxdBc26X8W9zj+DaWaD+HH4B75WK2fcILSZiJgYk7U+/0FE0?=
 =?us-ascii?Q?VNiZ19uJ/JLXaAR8GFK5bIoIC6+f9MR3LIM6RLhWyS1dk+ToSF3F8F7sHmnO?=
 =?us-ascii?Q?Q8WbkMZ3+qLnjILpAbCE6qf5oO4O4tlUGAfX/uSko/WTy+k0Mrq9O5BJT3wT?=
 =?us-ascii?Q?W8F0qJO3rLNVBpejce/DVs57zdyOH0H+DLlPxK0T9g0+l6rv958kiyf0ws+X?=
 =?us-ascii?Q?LgqTgfmP48m622ZXeTQellJEZmWUtTanl7csqgrmcAmueJMWBPoUWqdlvHd8?=
 =?us-ascii?Q?gwdSk3hYJQNQWVLYJMKAKrGDbUBEVB2uwdBJvIuvetExiQlaA8tdEiclCcld?=
 =?us-ascii?Q?ix3hqMNJxxJKgfmdNbp8C7bJbxxC4vvNC8bCmA5GBkOjDtm2CXgNb4u0nmLP?=
 =?us-ascii?Q?icDEkfjOvr0hnfxAHWLdpHOn1G7TRLKJq6/R4/MM9MQUXLxH9HkRNoyVoBlc?=
 =?us-ascii?Q?gGtxZ7W63L3MfamGw6AykqSdAIp4vP5VYC0MrjLQWVZrxCAJ7B1fL9TijiIH?=
 =?us-ascii?Q?FyfCYELPwddnLMGKHn3F8zrbagMMuHjokZ3OtJlnRn5NDydMDp9IqDTd5mo+?=
 =?us-ascii?Q?oHEUv5m8bUtFpNaRSq8mJP7BV6wiRRD+EbtbU8cdfnnbp6s0UT2ZTGygYelr?=
 =?us-ascii?Q?Gd3+2e0vU8Hn/YX16DRP3lVcCLOhrKV5iXFwxDc5uj5c5PE2WE/zWZRvxdZO?=
 =?us-ascii?Q?qzb876NVZQakFrS4uA7YQDFTxU2XCcv9PnECNxg47oz/sPZRzHtpsdCNUZfa?=
 =?us-ascii?Q?rf8OCtB6cwHDJZZjQE0GeeY1cF9UEabs9eR/d6BPe7jAlourkdt/+K3zyj7H?=
 =?us-ascii?Q?OFO0gn4N2jJp3mnzLg8rDmLgQYlzwvkvP+ufEI+kSabFRbL94Nufs/shxbGp?=
 =?us-ascii?Q?DLquOwkRqbjU8Cei/L1/jmpcZekhfJIDYSlYTePhEHZEyG63RQCV9uVaIAhl?=
 =?us-ascii?Q?xYL5QqvJuaOG/FcSrlEdc+dBYq93nGtR32gh9ViArzhjGbYBKbQxbHa2N2la?=
 =?us-ascii?Q?GR7kEpiJMStCTUNZE1T6zNZQYRtg7VGQV5oMd7KcUe3ITBYoVPEPKY1ghKcx?=
 =?us-ascii?Q?YwjKaaPlfC5xBdyXTcTdVENJb3eOVpmxuCKftSWAdx7BGlf/M97ztPhpXVxH?=
 =?us-ascii?Q?u0CNooLhGkm7f0hOJU6JmmmokJfeSTQa2E7v/9YDtbVKt5oZ4BZKrQEQXd6E?=
 =?us-ascii?Q?zkWT9XOR1w6rIwZ+yuZ4/kWR8sB1eKykelL1ljvW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 418e6332-2376-4b2b-7756-08dad48dbf94
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 17:50:49.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33fsGc+RlydIHiA3ytsSpxmt/OBsU7P/dNYwy44SND+xR9CcMbz2hkvAFP1Q7Vz3kucc4VKsbfViZYyCFNx1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6960
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 09:50:26AM +0100, Michal Hocko wrote:
> OK, so this is a full patch to fix this
> --- 
> From 7f338ed952ba4a100822004bc8399bf720b42899 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Fri, 2 Dec 2022 09:45:29 +0100
> Subject: [PATCH] kselftests: cgroup: update kmem test precision tolerance
> 
> 1813e51eece0 ("memcg: increase MEMCG_CHARGE_BATCH to 64") has changed
> the batch size while this test case has been left behind. This has led
> to a test failure reported by test bot:
> not ok 2 selftests: cgroup: test_kmem # exit=1
> 
> Update the tolerance for the pcp charges to reflect the
> MEMCG_CHARGE_BATCH change to fix this.
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202212010958.c1053bd3-yujie.liu@intel.com
> Signed-off-by: Michal Hocko <mhocko@suse.com>

The failure is gone after applying this patch. Thanks.

Tested-by: Yujie Liu <yujie.liu@intel.com>

=========================================================================================
compiler/group/kconfig/rootfs/tbox_group/testcase:
  gcc-11/cgroup/x86_64-rhel-8.3-kselftests/debian-12-x86_64-20220629.cgz/lkp-icl-2sp5/kernel-selftests

commit:
  1813e51eece0a ("memcg: increase MEMCG_CHARGE_BATCH to 64")
  8046f9500f4b7 ("kselftests: cgroup: update kmem test precision tolerance")

  1813e51eece0a                8046f9500f4b7
---------------- ------------- -------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          3:3         -100%            :5     kernel-selftests.cgroup.test_kmem.test_kmem_memcg_deletion.fail

> ---
>  tools/testing/selftests/cgroup/test_kmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> index 22b31ebb3513..1d073e28254b 100644
> --- a/tools/testing/selftests/cgroup/test_kmem.c
> +++ b/tools/testing/selftests/cgroup/test_kmem.c
> @@ -24,7 +24,7 @@
>   * the maximum discrepancy between charge and vmstat entries is number
>   * of cpus multiplied by 32 pages.
>   */
> -#define MAX_VMSTAT_ERROR (4096 * 32 * get_nprocs())
> +#define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
>  
>  
>  static int alloc_dcache(const char *cgroup, void *arg)
> -- 
> 2.30.2
> 
> -- 
> Michal Hocko
> SUSE Labs
