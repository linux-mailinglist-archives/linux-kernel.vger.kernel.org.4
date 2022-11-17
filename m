Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552F962D39A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiKQGue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiKQGub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:50:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C05E9EF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668667826; x=1700203826;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2Fx4+mZrA9Newxf0t3Fyfx2dm5JCYnsFvnQEytuK94o=;
  b=jY1EDZko5z/9vd48AeRbXfMVn4pQFaayObMQ9W0/GL+DUVVh+yE1FOtD
   ApsnVoW59qZbspczaMSq74ehgLyAQstmRIPNMggfiYP8s1ZMyEZ/itInY
   frJTVc3iq/weQsJKIvw7z6HNw84K3Msf1F59DI8VZgO1FUq5w3Cix1gAN
   otepp0NImvI+YVLklSLfJc+8EN3KKhdGeuPyDj+qGRG3CWrX3dDhPd7bR
   LzTgZ7+Ytd8PZrWaS0nNFDXcTUdihHUj+ZHxLJaoWVeL3++otR8P4QjuK
   Kb3EomtDzA9c3JK+pKuDPQWj5VdyBfXidaKYcMnRB1OpkpJ4vhpfZcbyZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="311478455"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="311478455"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 22:50:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="782095686"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="782095686"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2022 22:50:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 22:50:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 22:50:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 22:50:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L49U5K4LoCePPECkojV+oiEo+axlwIjF2HATrhhZX3rfjP7Tnh2fOdRhxpC899rZa6qUg/7dCIslJwyY/0866hCJCbtBMczLo34TmW1jpZDg6MtT+LyC/tykKgG4vyRb2trHzwu0LMgVjIdjIaaLE8V00SdEMliIZUM/ExKCxjbBk0Yr9u+B5y+5T6W0GvabOW9Jew10bA4oFfCel2Jan+YQoZtYZiL/mEaIfmQmCrXuFbYkWSacph+PC/3Rrr+++9BoWz+dfdqzpe79pp1Hs3+sIJ9++VN0lWptlbeJgTKgBXL4NkiYRmCikPZ4YAGyrDuiMKV7TJN9XktlGXkkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C+wz+uNSK4yJioVXjStcfWoy/1UZYf1a9xdaNCKLiU=;
 b=iq3XhKOCjeSbn65KrIGL3SFNobENXgGjYfh1Jt6gKPqC1YPO2y4sL6twGv5OakH0tuHH2/bnX1kSwMkkVJ0veJCctbZxk9hRZYEY8L0n9eQ0QG6blypfyX6mYhKOv/4HtGbhjg6rCVZJlU7KNuTqSez0HZ46nwHHgYUMZDqJLrvPqQO+akrBDGtYVMWvoFknkmtdUZzZeJONrnfabN3PUAc9a85Y+8msQORlqzffT4GS1Wl9NFeAdFRvKGsPYUtKYyngRlAshQBDZtivIY+OLOecab3VMiienTypwQg6kDNgGQ9Y1EGJYqasCHEIZ3asSB5C8HKMXefiQqNmZN+Acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ0PR11MB5040.namprd11.prod.outlook.com (2603:10b6:a03:2d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 06:50:00 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 06:50:00 +0000
Date:   Thu, 17 Nov 2022 14:46:50 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Yunying Sun <yunying.sun@intel.com>
CC:     <tglx@linutronix.de>, <peterz@infradead.org>, <paulmck@kernel.org>,
        <longman@redhat.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource: Print clocksource name when clocksource is
 tested unstable
Message-ID: <Y3XY2shpqb3Nn9ZI@feng-clx>
References: <20221116082221.25243-1-yunying.sun@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116082221.25243-1-yunying.sun@intel.com>
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ0PR11MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b0ce38-eb2d-4bb4-d2ce-08dac867f26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgaPjQjClVDqaZe3HmggezoL8cSBIrVGp71wRHFA2Yaf433J74ilRnzOZDwFqaSQiOG58wlrx36KXDRSANARaG+617LBi8qpdbWwjuK+dhBp8s30Ini+mIxICuQzkiO+rQkwrJku+h6MZlg8nmNGcN7NOTV9F2OH1wELIx3yL7MWhmZs1ODLqfPzqqsCbjp/eBOnQa16vdFFJBeLt4+KltQAPgICcirAIR+Racmf8Y3CBvNs7mkgqjOKuskOHCCpK6AxAB5nhhObqzz7y1bZF0rXg3T/710y9yaCm2GCvcFc0+RAiP/hQh4tq1kmTYX0joFk1jnG+mOS5fuPCR9DI/w+3Qwm0ETK1hFKOCQwy9I5JQP3kKGT9J3O1f1HrYM+VQgio09wQiQiehINUSZK5Ue3Z/kkV+VZP38YxubECVEDNiYFSWsaOE0pg0nIbq637JL7zQgfX4eD5H7FGZ/jxfdHcSarLmLIKEe04L4qYp2ddXRMcoObNyzzrRflGbc2/n4cq3V5PE4OtZuqit6UcoeCWG+RoJaUFVPGKabNKzLPkOo9wMMv72sGYUkbWoeI5rJcnUdEMUZXy03LBB5S5O8A80K/VeMDmkkZ1X9WrbO/oW7mjkmgP/AJad95OfeqQNZudcc/1mZ5Rf8jceqJcTyYzn1fU2Aic0e5Y0s1f0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(66476007)(4326008)(83380400001)(66946007)(86362001)(8676002)(66556008)(5660300002)(44832011)(8936002)(6862004)(41300700001)(38100700002)(82960400001)(9686003)(26005)(966005)(186003)(478600001)(6506007)(6486002)(6512007)(316002)(6666004)(6636002)(33716001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sgI9/FuuRanc3yfzI2pR1cQJO7csNStgQerFRq67hC2KK3xMZKaJs/uNmPQL?=
 =?us-ascii?Q?YFZPKPvdi75YUdkRYRyXINVEKiMkVVi3uvrVePYmRKT9lRTHZMd9v/LURGn/?=
 =?us-ascii?Q?W/6G3JqT8FLzDhA4Wfm6g+33ZGI4i8UaxHjDg8qrEzPcMOwNBmdmaxsARCVG?=
 =?us-ascii?Q?Qgqzs1nCI7ll3BXdKu7DMdGMdXXtCLAxTWmtWOk702PLBR/6S1qCNxtJQxu5?=
 =?us-ascii?Q?4Rsa3LzjmfcyRCRZrX931toXLmTDSsFd7+pv6rcFCMzI2Q1aEqd+yTpGTOzT?=
 =?us-ascii?Q?T7uVevw6bWW95Q7deIxsYLIg97bm5quMZRouBXA2VXWxWXHAZM2+QUOs7g9O?=
 =?us-ascii?Q?TK/HXLplzEu0uiLKkzplSXz/OG8f1US1g8H/c2NGmqQhuiNBjBDXNAD/jFak?=
 =?us-ascii?Q?d0aKki/6vTWTNJyRswJOOZXSxyS2TOypWJvI48zsG1/u82PMXGxoiLnuJ7/V?=
 =?us-ascii?Q?AlfDRgUdW2j/YtS3Z31h/2DHbPcQiRUMXJs9ngrm8INRjjeT8WLqqcr5ghsH?=
 =?us-ascii?Q?dcjYo/bvyZovQWeVwZ4ixEsTDTeJqmfOfOs1IHi7cTVf6Z1I3d0y8dFRN3YO?=
 =?us-ascii?Q?Ulg8xwlXPV3KA5SPg02JuWU4aVsDtoHIj6Xt9TmVOv4/toH5WQdirskMg4YH?=
 =?us-ascii?Q?5w2z6FTcvuCD4jj+mRZi9TNX3EFBnqtAKdQY4zOdWF4IZFIWM5iJyBtr3mZD?=
 =?us-ascii?Q?IHKegp6Htgl72gl5UJdOcJ+4mKId5x6Uv4R8TSCASiziaxR9PAhHsDgc2p5B?=
 =?us-ascii?Q?0rExvYaFTdCa9snoH9aB98MQ8Alne5qOrwIZ3UtDDNEGqNqBDCSKzQap4lwE?=
 =?us-ascii?Q?w+3EAIgyRaMmoBI62qVvXOxv2LS+PqSvgnmi28j2P+7k7R8rD6Zmj2ORfrC7?=
 =?us-ascii?Q?4wjbnTMNuysZ0BZHvjB1TRCWavwLoAypJcaBn18dsZzpSDmmk0UtYT6dmnXh?=
 =?us-ascii?Q?kOO/Das1wsHJspnNEGi32hYWVQ4AXPIO9ZyPDcb6uTNzqPQmdGcAEVHumbT0?=
 =?us-ascii?Q?YZ/lm2TGo6a1CA6uSiF8H1MU63odavGBrvfJUPpKK8tM8PNjLc/8mDQFTHyS?=
 =?us-ascii?Q?XIzM/FqDHCu5v8rIM7p1F7Svvg1t+Cp1ja04LhjtZwYlA4hgtXqNxIwF6Yxd?=
 =?us-ascii?Q?mkEhTL+wOH8Ms2aEz03nUqru/AMPk9N3SNxXg8QsVOKrm2sZQH1wIxJ7nBle?=
 =?us-ascii?Q?ud+VWslgxyCF+MVS6TRw74ySUk8CGa9XwpBKYPa8ctymttZVk8GupyO4i+/1?=
 =?us-ascii?Q?7yPZYqEoWvw6Ug70lMxeMRcB/ASmD+QchcIvzOqktsEah+149n1jT1j2VgWy?=
 =?us-ascii?Q?ZN/nq3BNVgoBTP/ydMW6LhsetrX8mW5LzbT6lh/OQQZfAMsPBWezR6pC5toS?=
 =?us-ascii?Q?iGJB/0QFU8RZQyPRg3fK2B+bWu+iOjap6Gv9c0JeWHwVv85okv7Y1bNEnfr2?=
 =?us-ascii?Q?lJfhd7k1a1qh9lOdSAXjqd4J+pEWpURHIsvZMAIFRATHdjJ3j8EYQmWH/h2x?=
 =?us-ascii?Q?BM3wlgVpwyBkgiqFZ3fqxN1ccAPem7cyB+U5LJzcca+oqyfjM1Exz6ChvYXM?=
 =?us-ascii?Q?EqX43/QEN8VEbuN0KtZlg1/0mI/Cs6wnEHOSCKcg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b0ce38-eb2d-4bb4-d2ce-08dac867f26b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 06:50:00.1935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/BAfRS9R5lOLSf0DSY/fizwQzzG+/0iHYTd67ulF8XEHn3UShumNQxiDPp1w4b29AM3TsfcPK74Vq04zVV+nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5040
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 04:22:21PM +0800, Yunying Sun wrote:
> Some "TSC fall back to HPET" cases are seen on systems that have more
> than 2 numa nodes. When this happens, in kernel log it has:

Hi Yunying,

If the system's physical sockests number <= 2, I would suggest you to
try the patch https://lore.kernel.org/lkml/20221021062131.1826810-1-feng.tang@intel.com/,
which is still under review and discussion.

Thanks,
Feng

> clocksource: timekeeping watchdog on CPU168: hpet read-back delay of 4296200ns, attempt 4, marking unstable
> 
> The "hpet" here is misleading since it prints only the name of watchdog,
> where actually it's measuring the delay of 3 reads: wd-clocksource-wd.
> 
> Signed-off-by: Yunying Sun <yunying.sun@intel.com>
> ---
>  kernel/time/clocksource.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 8058bec87ace..fac8c0d90e61 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -257,8 +257,8 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
>  			goto skip_test;
>  	}
>  
> -	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
> -		smp_processor_id(), watchdog->name, wd_delay, nretries);
> +	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd read-back delay of %lldns, attempt %d, marking unstable\n",
> +		smp_processor_id(), cs->name, wd_delay, nretries);
>  	return WD_READ_UNSTABLE;
>  
>  skip_test:
> -- 
> 2.17.0
> 
