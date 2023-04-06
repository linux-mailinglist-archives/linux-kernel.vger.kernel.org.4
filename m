Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4C86D8FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbjDFG7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjDFG7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:59:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2983DE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680764346; x=1712300346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v/YbWxFOEv4CQQXEPp+UevBCFHBoBWxByQiB16GEiJQ=;
  b=Dz7PMItzqzOy9ftBMGQqZ2IB4Fyc8F0s4bz4EOkhkwCCbrLmUEJaPx53
   8wI6TGg7XC47M6qyPTEkGmpvHmkSHhTM8ohrDu3ZujZ1ogs+h9QTaa6k5
   t0KVo9XL/BJJGqtCHazqFnP/vPuqCXz4izCUaBoUIKfxZ/qVReCjOsUwc
   hTqCq7sF231+T3SuhmkSHqjFZNerEDVmhbUFyrZkZ2ekuapubr7N0/eA4
   DCxDcNS7hI7YjByrWZeLCBeKIIwQIYLy0YLevhFegPc3kA/2NK+twIC7o
   T7zrNhTuwL5+OsBNeVBOG/XOHtqIGXVhiwDnu2jKldMistwnm7LhU7r3V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="322309900"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="322309900"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 23:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="717337498"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="717337498"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 05 Apr 2023 23:57:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 23:57:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 23:57:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 23:57:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cv0z5QraEJScaeztmavW9qV0JBBQSsynRqzWpMk4F9axmmTYdvU4OvQJFMnFLUA1n3oltlPtuxdQ4zsfq06KqP7IsPapti0wmAq1I4jQtyx9mEInwT0uGfUmZWjGswxgGwDRcIdTXm2mJxBUrWQhh+or+AqAMK30Knlh+cfrhBAlhdG2iuhdIf0dNeDqhW+nlSBFv4AdAd8jfNku6KXK8gwjtv5sf4JVNGjG/IYqQod1Wa18c3ulpmtGGS9kjGHgzatbj8FhQU0LUcJAATmP2/+xM6Qvy6zau7Lm+LjHOk/OQO028NbjBPnIvwRgLyKqy6tNGZkndeFCk0M0N/ZSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pa//YbX/XcHUuNIggZ7GdyQglJHLLqjH1ntbhbh2NU=;
 b=T0+rVQISt94coYIoThbrXj/He/kDR6gsADxsiA6+enhnIwLyYWpS83z3trNizKRWwhn/93M9ct8zLn3EUYARK1+2fyAJsTUGvIyHWmNeVld1ZqnOPpkDcQVZOgvQxVP75OY28BryPFz6Yw5uH5/4bZRas7V/NmSuTmp8BglgTQo3pPpMEdVUFLBWTmvc1G/WTpXShQtuQHkkk5cCKeWV3t9Ym+El9rjHfeV4EPWC5nBaR0qBf2UFBSoERX3ND7lIzbyDCydGYOEmEIVu2teU+YZoXehWleiTBHXVrXVHXK+sSEG26AMPm4/ztuzC374Nfb6eEAUBIzzhxBpfoESeQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY8PR11MB7010.namprd11.prod.outlook.com (2603:10b6:930:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 06:57:06 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 06:57:06 +0000
Date:   Thu, 6 Apr 2023 14:56:52 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     chris hyser <chris.hyser@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <dietmar.eggemann@arm.com>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
Message-ID: <ZC5tNK50QouEvX7Q@chenyu5-mobl1>
References: <20230404182915.2264557-1-chris.hyser@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230404182915.2264557-1-chris.hyser@oracle.com>
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY8PR11MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: c0283923-219b-4cf5-ec80-08db366c2285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clIOZoRyK/nJHrd+98zVUhy2nH4edNw0QAXGUiY+ZSGZ46pyWxE9gPrM/xiej50W29do3B3nDBRI3/DLsgq1If35u5QS7aCz8AG6uKsWdbmxIywH+KCZde576/m1Yxq97MeetJViZIteH8pGsHVXSwM0GdL/y/NjWnMtrBw0BZy/pIXbOUi9yP6GtFo2mNEyiB4K1yhhQ1MqG1kiT0kPf7dz4A5Hl1Qfhjo3YTragm2Psr+mQGENLSQqjrTSgoyjsrMj6N6UcgfIua0E9tz59JipZNTq2flvptB/RCl3BatTmZ/fGQHGBzkuD8GtbCqD69FgBU7/IahZYfpGZFnMOyO/z8IKjcE5u2gbJWIzgMGuGNrNxIEi/QugfGlzz82X+fWWDIEVZzsgrz/MY3iEnKzz9xnroSMpfkX1rABN+rTnMfJ1StohQ4BSAfIcfLPto/F6F1pZZSsf+lPywSgBV/KwGqeHTkA4shKwG11Co+WYP/m5i1wZKraLPw7FkAG+eRsaT91kym8TUnJ2ouzvrdVenptSVA5hIa6Tjr9z4HU6/M8HXS2F38BDMtzb+fJr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(33716001)(38100700002)(5660300002)(26005)(316002)(4326008)(53546011)(86362001)(6486002)(6506007)(186003)(9686003)(6512007)(478600001)(6666004)(4744005)(66556008)(82960400001)(8676002)(66946007)(41300700001)(6916009)(8936002)(66476007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VdBXbZX8Zi1zmIfjnRIpsKxuo/wk/XYxJ8yBF0SqzRipQn0qpCv1/+ZwgAan?=
 =?us-ascii?Q?j2VPoKNxpbY2e8ce3hl1T45BC7utQN9EAPWu72hncQeHUpG8R/YULLuhyUod?=
 =?us-ascii?Q?/tiNnn8k8VfLU0Vw8JGDajqTIAO2qf6tytk0BaxP5oEobJ1v4/EzZMNcg7NJ?=
 =?us-ascii?Q?vnA9Ys04mLz1lXYhySlpDvFwUxDftvqKuRj9EWRHJtvaiBd1/Fqw935v1Inw?=
 =?us-ascii?Q?UxRepzae2Q2nUYxLXZSmhondjsL6VC/5cYErPaFgTI0UpqzI0tN35I6+mmA0?=
 =?us-ascii?Q?RmpnHvS9xT6PD0Sx+AvSvfzWOt/QNFsviQ9M0fsUnMrt8roRif26ADVVggr4?=
 =?us-ascii?Q?bKlgj15IpG1RgCbEK+9cg95jyikZXzM/CQtcv1GcPpAHDDmOOj7w8pFCTu4i?=
 =?us-ascii?Q?SBs652y355nKZ5fbDfP11KjIMvR0NncZXhvTDKdQgxY9o452/TuokxgZgogP?=
 =?us-ascii?Q?IWHu0JUxXJawPEuZa1G1ERq5hfJNYzhrGzuzdCE7x651DL9ORYRUGaC96XAI?=
 =?us-ascii?Q?FTwUA4SSfhfC+3dGstbRdnbh723C9OeRghQctjJJsWtkpNaSmBFrelcK3Em/?=
 =?us-ascii?Q?e8afoRs2NyW7emglGYm7VhLsthCeImZJrmPtAz/ai1c1wuXStg95sM+NTuTP?=
 =?us-ascii?Q?ztBMgDI0WRm5HYlsivW460LqTDwq/kk2I3jJ9wr3FurPUfY1bOE68VtBj7eA?=
 =?us-ascii?Q?dDWVl5QRwTsDREZd0W3xE5S9b0Mn8hS3lQGjQgBzPJNP3NyCSwWv4cC2H0Tk?=
 =?us-ascii?Q?ZQZ1UNrfqjwKaM0p9qAdtibcMk2+FMhO8HuSpQEHm2JD/Zd48yRaesVKmnhY?=
 =?us-ascii?Q?vhjtIYGd1nbLv78vq1tpelyycG1z7tKMlTAlWdP6aKXvJAjNMoBY7udN5Ji4?=
 =?us-ascii?Q?FTqWcHEouwlKbUbz22x44SgxhGo4fBokdh02huVQEpQLAsOgOAiGvbtGCdl5?=
 =?us-ascii?Q?5OCxl84kqPp9AFJBnSrqQzwD4VOgtsxtIGr7i9HVrjFllVML7ghyUG+nEv1V?=
 =?us-ascii?Q?0rl82xleH6b6mBcxc1VYc7btKhA2kyZdiYf9KlUlBIyGuExYTo/Nav1dOHNA?=
 =?us-ascii?Q?qPgRu/TmwTFhYpaBbs/ga9kVaEk/WmFLHrVnpiBC/XXSdophZy1DrOMFxhxn?=
 =?us-ascii?Q?kYBvi9o0n4jkjhn30CtJ7C2zqk2aDhxVb14jLz5tlzo5DrZDYNJ7Jl69LIX9?=
 =?us-ascii?Q?tTe6dAulQl4H6l7kfFc+yWB9tpgXVBufpmdoNKaBO3gEco2+lxHYMAH3wBE1?=
 =?us-ascii?Q?L4/U6gK4yb9Zdnb3Ayj9HYVsSKAjOrcOVsI7NCKZ7RWY08QNbA4TSlZZHijv?=
 =?us-ascii?Q?J0blk6elpjNMnfNbZi6UD3NpyKcGbnL9Sh/kwYi50tNx8WGFDZY2BeYtus9J?=
 =?us-ascii?Q?obvLXS6Je77lyvAUnoyVKqiDT/5r2F1IDNGXphaYTLeQvjvhpnV8qIV+QoIQ?=
 =?us-ascii?Q?MKgRbTVFu/69bMCvq46ouqw7kvzNnPrskRa3gZdug4VDKop1xc9ST6grSquP?=
 =?us-ascii?Q?u8aB+bCVGSja/Lrp8Qxavhc6ctNPBX2krhBv1jSsmREOj2Q2Z+nMDRz8VisG?=
 =?us-ascii?Q?rGoyBj84JS77a/Rdj7LQkGTepIBxf/VJ5eyLjKDY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0283923-219b-4cf5-ec80-08db366c2285
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:57:06.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBa0lEQLgSfAFjadn550sTKa6HN91WkR23L065FMicVT4wFdA+3qZhkFB5hRsC0hEZIqhS/nG5Xi7Zy80qoWgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7010
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-04 at 14:29:15 -0400, chris hyser wrote:
> Commit 6419265899d9 ("sched/fair: Fix division by zero
> sysctl_numa_balancing_scan_size") prevented a divide by zero by using
> sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
> value of zero. When moved from a sysctl to a debugfs file, this checking
> was lost.
> 
> This patch puts zero checking back in place.
> 
Maybe add a tag
Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>

Other than that,
Tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
