Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47046D1ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjCaIwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjCaIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:52:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15E61CBAB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680252767; x=1711788767;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=22IdFRqNf8P1MoyGzhkPX1q6odjhAgz2FGcAZANV2yI=;
  b=ehzOQ4yoYyjReC8fdEDD9hEwRbfeq+me+IESU3flbXFQ73QIXVByeC4/
   gjw3gN/WejZ5YX0dyTWnjutnvbD8eNENTnppbzePH4q4wp7K4jdqQP/7V
   frHMW0jdu2SWxw7TKtu5EoNn9vt3VDbxFNYB1C5HvLwO0wpoL8udK7ERl
   AWsa6NXM0bhmn8OiEkonMSZ6KeuVc6v5LwAqSmOqpYzShYiZFrmOB04xa
   XE0qsyaVeNhdugJ86ATl6sLjwJPJM/rhgJqZWynx4xOT4FKGVfi6HKSqM
   pd9f46t58k3LBo0qtAOeoIUp9by1fnd/gR2IqZirWqjNETASqCXxG1zN+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="343918246"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343918246"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 01:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="715379617"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="715379617"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 31 Mar 2023 01:52:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 01:52:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 01:52:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 01:52:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6ZESWhwvB7ydH1pLiR7IMsLeZvXQ/Drxr6OsRrj0nYAjVRGMa/7O0Aeyo8eysZiqFqJVMtkS0JhQZYSTKcPbyvjwHyIgt4+Wbbmo/l+9YApPTETm1dIUvCmJKqac3iBJD0Id/gzVz6GBrF2Bpg38YwAnFXgf2Tb1mABu5ecH/ioR/nhFhrC0fT/RVvJ1DNMu8k+SEBFXcxUizJtpzLR+DDLNIY7d9I6HEb36uwfHwXkRn9pt3CUrQqhFNPucNHSKZHCBUDa8wXyj0UX2aLLJkbKWoZMry6L/KvGrQ39EXCX1PEwcJcf3mYbyQ8vDMhDvL2I+m9yFK5qZ7y9Q3lYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvIABzJ378HSyOR5Rkr3oBaP8Pth357b8boMcMNOSSs=;
 b=oe+VUTReerUZJGMMdUrpcQnjSVSiHesH0vbKigqglMWotvdzQgvqgIuJKZT23QOUsvd+l4aBwXyYx53zmGhSqD36j62IfMvv5vsszQfQxmIgzz0i7cgGacNLfuPF5yTrDID+JBC/Bpn/hICWqXaKLtV0rYXVproYe9BYKASSoazPXgg9OYZ0YnqPBGXg4qZi2ZoY3J2Wo9CHxUIWUyGF7bptw/Li+vZFxroYDTcB13JdueX8Xqzyskjh85XQi0P/MjJBmOB+WWwXvoFetz47XIUkC6GlQvcYlPNV57ZEpVQaV9iI38mL0cLgpVxxdrVuEPUQSjCi8OCsDOWius7YkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SA2PR11MB5194.namprd11.prod.outlook.com (2603:10b6:806:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Fri, 31 Mar
 2023 08:52:40 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 08:52:40 +0000
Date:   Fri, 31 Mar 2023 16:52:29 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched: Introduce per-mm/cpu concurrency id state
Message-ID: <20230331085229.GB186694@ziqianlu-desk2>
References: <20230330230911.228720-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330230911.228720-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SA2PR11MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fcdadf-deb1-46df-88d3-08db31c548a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqAxcXhF5HUMaUmokoPRr53oxzWIDkbjQSJFT7EM+kLOhIQbZxkqVZB4EA2+rvHjzeEXo3prNv8TdM7ODSjMqRZt+fC9iUrMZPGl2wkQ2l7CbnTTyfU6Ms+qXg2DGtvN0wtmce++rjxFikCS8dm4v2qJZ5f7NJrAlJqQZZFX/SanfkXIDNKWpJxOJWB8TDaN4/dgbHxLJ4RwzrEVhVdDclWPC1N/cNoOV9TcaUc/gIOqyJfxKld9+rmQ0N0hq5lxf5k8SlZldGrnW6JaQSuvg069H2Rjsn8U4OqI1xWy2Ot3lGKnpidNogurhsb4Nz8xx9zvmsFP1v26r261nju+Kt1B1l7IP1JFX3hbHxATp/Qk7NGpNZgMjWxfJfFTJ4WjmcqByrmnAQws0Tesk3E/FNgs8CUr82WJE3DoCzObgxw5mpdl/ZQDQDy1X4BHw9ViB65UnrBXEt57o9X2ba/wboZcoPdiTjGWHKm3OezbGUhSfnO0ImsEwZ8FUNKx+w/YppTqFDRjtafb04hozm1AT5lYyB+nLVdRqw5qEUxHJzc5Ad1IAs/cXwsM11rv6uAB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(44832011)(5660300002)(8936002)(86362001)(41300700001)(2906002)(66476007)(66556008)(66946007)(6916009)(4326008)(8676002)(478600001)(316002)(6486002)(6666004)(9686003)(6506007)(6512007)(26005)(186003)(1076003)(33716001)(83380400001)(38100700002)(33656002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dbXOC5UbyqymIZQqNPifLug9dtSRJSwdJhFtWctO9pR971Q0I0JQ0qmh6h+3?=
 =?us-ascii?Q?g4hG19LgSYwQX80Y0OQBIOoW2Ayo7oCRloJneAOE1oBfwhFlDxSaNZI1sKzA?=
 =?us-ascii?Q?Yg0q26Wj8HqKUPNnfL4312/eB4E1Qf4agumeTedaA4wDL9IPKgkwHmBrTCd3?=
 =?us-ascii?Q?CDPqaQawEdlsWbr5k1/hYsfKJ+1A3SpNaCgCC85Tq8Bue7oy7N6l/odY0r8W?=
 =?us-ascii?Q?ZCAIlR6m5u1grXuvIjVWvjdm40zTftOnGP05THR/3+69MPGY7ff6FD5UHElu?=
 =?us-ascii?Q?wXgx3XM4AP+x62XytwnCUEe+7M5dWx5ldVCkqnTs0/zzM9bfYwjkTKnV/Cyb?=
 =?us-ascii?Q?Fg+pabjqhXTshVPCUFitjh+38gYA+U+aZ6ow2UeE5cQAMJhYIo4BTg/MYE55?=
 =?us-ascii?Q?N5d/txPLRH4XPKtkE26XURsKbP9j1fcoBVTptY/V2m/G8vRy8Obcjjn9Dmj2?=
 =?us-ascii?Q?UQdjea770V16b1KzOJf1jZ2kBLmuv+ijzgNWzzuOdzC9DcmH0xC05pv8urXK?=
 =?us-ascii?Q?sD+n2W1w265fAdj86LpMapwBk+CkCiAZz4sILuHI+FyUpi4RRw4B9YlYClPo?=
 =?us-ascii?Q?CShjhHCElMAx/W9bA5EkqX53o3O33qlOQjyTxhx5U7hIY3R4S2nWiJ6AfFKl?=
 =?us-ascii?Q?tVCAiHhtCEPy1c9rTGJh2iiuSqxOQ4+/xPPbMVZHfiHOcjclmKpFsFhtaaYJ?=
 =?us-ascii?Q?TyMvcNnhoFziolIwpakoIZcuMAFtfHro0wKRp4WRsNE7WiDwb+/Yn5D9eJL2?=
 =?us-ascii?Q?8j9tCuC0SrnCppjtvBVBMdp/jLV+Y4OEsXACPTN831EPG3iXC+RtQTAIse2a?=
 =?us-ascii?Q?6UycOZOgvvGAdNKsady0LQZRNIOfSPmFPMTKEUYvXflLXZOSYpAO4/9MYogJ?=
 =?us-ascii?Q?ieS5K0nqiqTL1Qs/BRJRaprJIqZ93cg9dTs05yq5xEfCppCu8JORY+JkgXXN?=
 =?us-ascii?Q?p1T23kwOAH3K62AmCs+9/39hZvtwSak70ULnOwEA/HuZmkqLytmM3kAXTcG2?=
 =?us-ascii?Q?UyqBZN9Xe65rJDICMTN9v2wBFbQZ9t3UT1C+GmAcf8jMlm22Yub9rrLQubkR?=
 =?us-ascii?Q?YsyDpDeoTv+om3RioNPOZui2NEgD+QRiHoC0THaZ9x0KegQSPZhsdY4pEsEG?=
 =?us-ascii?Q?xfIvDHliHrX1JdYCxsV+W7S6bIB7ScDD1+Ao1oSV5ISbyRs10snCluBaRZQm?=
 =?us-ascii?Q?zWmug6UHfYMPCXJQoSG1O0odecOvIOao6jG32fXe8nxrj2dHLE4WH0oB50WR?=
 =?us-ascii?Q?aCnYG0goU3ZJ6JLdKVRwi8PRIS2OCSrZdTzO8Vs5nWsYPB++uRqsQDos4UI2?=
 =?us-ascii?Q?zFQ3m10cUrKDE4p3hgbC8tji7r0XfUXKVJHFULJCF4lWQyDucAJUCsbuUu2t?=
 =?us-ascii?Q?YS6kAOKEjBU7/lL9MimZVeg+iafQLxzQplRazkMFbYJc77pJ/vRo+UQ3NA8x?=
 =?us-ascii?Q?lHpzi+yppkfX0c336kX8Hfg/vrtI1GmZUrJuiNpwVDjabCAAIRGTgmNMrT6G?=
 =?us-ascii?Q?Ke7t8q8e9GE5OGqwObWfFPW2YQmMyPxFwMZy4A+P3zjgd5TJ8KdWiMFy1D3Q?=
 =?us-ascii?Q?Dvgd6aW8PHEfo26YbkQsKJf4xEXOpEIBR9+WZW3T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fcdadf-deb1-46df-88d3-08db31c548a3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:52:40.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zX3Y0R9jZGb0GchsvbHxJISRidg1erh6P+XAJ0HtTteQfEc/Ixcq0nL8D4lp9+jYPRFMOlaDJVAKh3hHsGbkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5194
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 07:09:11PM -0400, Mathieu Desnoyers wrote:
> Keep track of the currently allocated mm_cid for each mm/cpu rather than
> freeing them immediately. This eliminates most atomic ops when context
> switching back and forth between threads belonging to different memory
> spaces in multi-threaded scenarios (many processes, each with many
> threads).

Good news, the lock contention is now gone and back to v6.2 level:

node0_0.profile:     0.07%     0.07%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_1.profile:     0.06%     0.06%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_2.profile:     0.09%     0.09%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_3.profile:     0.08%     0.08%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_4.profile:     0.09%     0.09%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_5.profile:     0.10%     0.10%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_6.profile:     0.10%     0.10%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_7.profile:     0.07%     0.07%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_8.profile:     0.08%     0.08%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node0_9.profile:     0.06%     0.06%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_0.profile:     0.41%     0.41%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_1.profile:     0.38%     0.38%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_2.profile:     0.44%     0.44%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_3.profile:     5.64%     5.64%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_4.profile:     6.08%     6.08%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_5.profile:     3.45%     3.45%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_6.profile:     2.09%     2.09%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_7.profile:     2.72%     2.72%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_8.profile:     0.16%     0.16%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
node1_9.profile:     0.15%     0.15%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
(those few profiles from node1's cpus that have more than 2% contention
are from thermal functions)

Tested-by: Aaron Lu <aaron.lu@intel.com> # lock contention part
