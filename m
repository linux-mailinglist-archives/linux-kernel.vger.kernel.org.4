Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B496DF44E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjDLLxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDLLxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:53:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB75C65B8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681300397; x=1712836397;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZzeWdU3ejKcjBwQRJQ6eM0JIfCQpBFHlu0gCYDRCceo=;
  b=JVfY0Tpw9D6JgNEub52nQF1PfwAwXU9RZOJEsYc49Nihpzp9/feE4jJH
   3lSKN9DCJ4yk129yLOHcCIQ3224fqutQPY6Y6nSiOzLpzKwJSwjVN3tCR
   roq4LxGehB5SzwU+5S24FyOnT0ZUZYeplPFuqgyTzE7H9R65i7B/x9944
   2G8l3WoKuIO45hbF0TM/E0DSmAiCTPtwlNhcv0kzc/j31X1VZrv/FcShG
   JbU6wZDpgWenxowNJe5kI/CYo6adF6XDnh+ma92rxc7YKdh6euFqUpTYE
   2jTqqdFjgR1hjfKw43Kkj7Akchsm8ZPTYxyXgGX2Bh/Ca3Ra/c+Bficdo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="342627567"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="342627567"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 04:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="863274096"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="863274096"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2023 04:53:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 04:53:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 04:53:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 04:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INgNgrdRi1TbDencW4VcCqLP7UgA1adA5HXEQ30UqyPdsSgN/XzbqtqVm1ZpTdvZC1o5e8/EcjNzSZKiMQVfadXj+K9bf2WfTC9R4ldngJeFZswtAgYMqfwu38dz7KIPV4ADxHDDFIcN4lGWnIiIKaK0NrwDdG6y/99QQYbrpQ0xXYRmrVtaqX7u6HkbRH1duTKOVbg368BL6jP6uXmXu6jeyteixsQxDQyoUFTjCnbhAWysRLrRnUsib2jRiOtlsTis9i0CzG8zf31NFzuFhK2fDNhWYQiSyJKFwthAnYCK+DT/2DvXnQFcfRWUDq1Pje5MdysqsmV3TiFby0++HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBZupOkgbTckiGvSwywiO+s371Dl+vbAtl0dDr3nd/I=;
 b=n8I+EpSRhg+BFzrRCPXE6GKFlf7Cv5jBlx6wFa0QTer3VXsKkSEcUcBIVHM+jV+jf4XNFtt2Fntu7ey8VX2YzmtFmGMThnp3l8/03GGtvUOHNGZKCEF615k+rT5sxoqsawe1hVacZpVwRsdeVYKkyduEsGzQYhNEzoAdzt4STSpyEI/i+E2aTcQvowomA1Cber4m9dnvFgTCubQ63JBl+OIidQytHLdCROP8e2cckaS/BQpK2Ya5ftymE0MbfVNldNfU5sWojbTr0+svGnRooxQxO22wdouBrWFaOTimB3mxQpTwYcEKibZkSTc6/7/HPZtbmsPtRMJmad/N0Yne+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 11:53:13 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%3]) with mapi id 15.20.6277.031; Wed, 12 Apr 2023
 11:53:13 +0000
Date:   Wed, 12 Apr 2023 19:53:05 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH] sched: Rate limit migrations
Message-ID: <20230412115305.GA155704@ziqianlu-desk2>
References: <20230411214116.361016-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230411214116.361016-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DM4PR11MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0ff4ea-4c3d-4d54-bf5e-08db3b4c7e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIiaDaVMg8z3KAW6gtpbD9uE6pmlAzObx2CIH+gi6J02l04nSuqTS9nyMolHfYWhvfn4dNbwPI0Xa6te33okk+5y+3aQOnvI1BOvXKBP4z1MJYR1N5X19db+RPH/WFJI0ooezJyokozsTjiagLJTNt1BFpcyNZHd7P19D2cu0NIRL3LC4tCah4pAfy7UX/CilPSFLbRZ6kJWtYx6LS5WztkXu3L/hv+zS8BRPiJIG++vlmUeif+w1ljqJSVn56n7ygCEvF95dcy2JTcoXVEIOi6DDOveVWXlbnbzCTjP0rVKqrunFGvaqhFLNmRuiVURLyp2zFwlV2bO6fynr5twlCIafKWJR80aszZHiNPBBMYvnl0NChaowLnhyOj8pJXmh3ECJLfgY8b1O2A7j6dG4AszptQH1nuy3n7+9iTm/bO6kM+mSkT6uT3zM02NO5H4N+BuWwkJKNyGt4OEVCem9m+6nidVvO2k3JbsJ2wHtFb5/QZ2Ni3/cvL1L2aGe+57TB40HuLlQrSkTjXCewKCmRFyIwcpPSbGc6VbAO2MZez6HxCsn9rAT6ckIf68hrj4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(316002)(41300700001)(6486002)(6512007)(1076003)(9686003)(26005)(6506007)(186003)(38100700002)(6666004)(86362001)(33716001)(82960400001)(83380400001)(66476007)(66556008)(66946007)(6916009)(4326008)(54906003)(33656002)(478600001)(8676002)(8936002)(5660300002)(2906002)(44832011)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wS+UO/vBYz8IVlilMXUAxpAs9qxko+SusBFjh+PU8FDxye7J/A0lqrnzgOYy?=
 =?us-ascii?Q?gfOCLo5jwfaf8kTfF9no+Zx92wOIR5KmBu+NY9njLqKi8ctLRAoqvzwWlkHg?=
 =?us-ascii?Q?HCzMxPEqF7CHBy7m/EcPd7cGiNxHHQciibs9h1Is/LhGGSU8c0ptINmhxPUU?=
 =?us-ascii?Q?SNnxpiILa4Pj1pNVnlY7KWzp0hXxBAeMv1DNsB2XubsFH9/uQJFI8frtQ12c?=
 =?us-ascii?Q?f9eDT0uEqUys7ZnHVHChUYkUR+/YB/Axtr00ag6RCemzaJCBDUeN3AYosHbF?=
 =?us-ascii?Q?BjVwKpyl/qO+Id0z2nLccXzm6mB7JlMi2tuKo7qSFxkJmsE6OFDSNhjHXkk3?=
 =?us-ascii?Q?Qro9BxHJWWt3+e+9scTTsGADyv8wC4so2O6WDzdyFNWZ8TIl85ZZ/prk8ldH?=
 =?us-ascii?Q?d37LdWhbiYsl78Au1NLcbwJU2auHQGiwLmOSzbbVLzJgpmgNEg+pZdBxsfTf?=
 =?us-ascii?Q?Gg6N1BaluaGCoagq8zIAWih2tl/V1rEVTyxjxmxMzAqJUl6KizW/gtp0HkCE?=
 =?us-ascii?Q?akLjiErZTcwzQyLYxAEBPwf4vuOlIC2GFRU46JTj7w2fUoqglK7CWCHX3DAA?=
 =?us-ascii?Q?2etyQ97yBbcqd3cB88WvChp38TuvORjZEhte8zxUgX/jYbKWCFv4oQSzoSOP?=
 =?us-ascii?Q?NdCxU6B1LArWNOXUYKgT/yUEL0IvMgbZXrTeSjWuVr7uO1Ck2X1ruOMg9TFe?=
 =?us-ascii?Q?3t4e/GKAu0qGzOFpLkIQ9KhMfuyHM2LvavVZUstRTQVb97zUzngsd6jLL0r6?=
 =?us-ascii?Q?xevGiTP75GQpvFmzEfV3QrMxXq4OCIycyscDuMcp08OOTsLRqSsrhyJ+EIga?=
 =?us-ascii?Q?sIMQsAz3v3FBhzzIVmPIhG4GEq6pZzPWuoCcB1M2TtckVeXr7l/TnTORAQxg?=
 =?us-ascii?Q?eh7BrqsLFIDfUkq/UMUL7Wqh2BzZmEAp/XKUBiEXakrCHxFdEjlfpnqwE2At?=
 =?us-ascii?Q?dMQ+o5Ra/yiVIKogGsxEpEYN71XAX7lVIWlxvJi+d84uKMDVaULSp7id+iKN?=
 =?us-ascii?Q?3Gb380qltJFY8+sVk1Ney1M9Vv05gO9VFAzxp2+1i68D6wggoINC2K6ygDPB?=
 =?us-ascii?Q?AhRw+ZSQ0x6yR3Qd14+km23IymBTPwAZp2b2g4OIfhT/WmAQLi115ofbAePy?=
 =?us-ascii?Q?KuyEASenUbn/bOW3EEP7jRutxlGOZkqmuayIiciF20Pd3eabKSL8yTikh1jL?=
 =?us-ascii?Q?xNzc2h+1G5jrX2QSqxwuAO+TSvA77E3vDFZFJyYos9+YR4OaSQaF2sl5fJM9?=
 =?us-ascii?Q?JA3dcv9yknGDBXwoH5z8E0eNJV8NGVdA1ZRGpN5KtaSmYTbR7yAtctfiI+tW?=
 =?us-ascii?Q?+/X91NF86Vw7MyPkYw2v1R2nb+XqnFmeXrEEY7X3GUxsUR72XRI6u5xmArqI?=
 =?us-ascii?Q?qPUzAmQDgt9b+TbR+A4WSbF1sQoTUFCi9gKhyIFsBNyIaY2tw8HyLBdLzjyl?=
 =?us-ascii?Q?7+1pDzgLI7ZM12AfPU83TcaBQPGUy0v2K0MRm2IuDv6rUnk9UrzqgGvEm2qq?=
 =?us-ascii?Q?sk+95q0ej4JGMVsl4M26pyWTFuvyN6cAK85WGu7qiiZzG40+ldSxNb391d11?=
 =?us-ascii?Q?J83GVCD3vIGHuLjj43F0kYTmurqDbUabvXXm83Cq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0ff4ea-4c3d-4d54-bf5e-08db3b4c7e77
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 11:53:13.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlARJh8r/ljn/zCV/cVmfhFqSznrQbcUpEK1DcS9lAaUQPe20BJG8nwxjK9+d+8YEgqsulEH2j+50C0tCKv3QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 05:41:16PM -0400, Mathieu Desnoyers wrote:
> This WIP patch rate-limits migrations to 32 migrations per 10ms window
> for each task.
> 
> The specific migration count and window size can be changed with the
> following defines in kernel/sched/sched.h:
> 
> - SCHED_MIGRATION_WINDOW_NS
> - SCHED_MIGRATION_LIMIT
> 
> Testing is welcome, especially to see if it helps with Aaron's
> migration-heavy workload wrt rseq concurrency id performance
> regression.

Initial test shows the migration number for a 5s window is still in some
millions and profile wise, contention didn't change much, still in the
range of single digit to 20% something during 3 minutes run.

If this limit works, then the total migration number should be less
than: 224 * 2 * 3200 * 5 = 7million so hard to say if the limit works as
expected since the number I captured is indeed less than 7 million.
224 * 2 means totally there are 448 tasks, 224 client and 224
server. 3200 is the theoretical migration number for a task in a 1s
window and 5 means 5 seconds.

I'll play with it more to see how things change.
