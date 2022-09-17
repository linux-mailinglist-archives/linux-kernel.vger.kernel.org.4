Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613685BB894
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIQN4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIQN4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:56:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB1731DF3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663422974; x=1694958974;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rGupe2OB28mpV4hXzIEFA/Laju2LZQjxL8IZXC+cNlk=;
  b=IO4niPfrC9VswdTSEFXnHiz6seQkLWIRUe5b1ul0P5gxYEpwsq8N55VG
   hCFskSYLEWhL39vwaz+U4M8xzDB8ikYlgQjKPArIbkBY3YzXBXcwTAKO5
   +dZ1AVje7kerhGf/owATzVwiuVP8UZiD6DWTaU6zLihJ5b/NnurE7PIxf
   KHqvMRns5Cm+XkP8Awn4sxsRlTqxOdlpj5DwSpk/wc7s5x8ngnXGKI0tJ
   eAo4vdNY02KQE/7/PBpnk80jgdOj3RYEGP9E6ZL1cEXHOQYQ6eB94Mjs8
   GJTgTpzy/NLBfGQCI5lbiO2Ex1N7rs3hpyH9/lBJb6NFuG2LMSTq0/KeI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="282180827"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="282180827"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 06:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="648579014"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 17 Sep 2022 06:56:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 17 Sep 2022 06:56:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 17 Sep 2022 06:56:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 17 Sep 2022 06:56:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBO9eDmUY8diVC9drOo+EDxUNCnWUnY0PiP6I6ZQhOdmvdDsvq/P9xIBgmJKCf8a39Hs64ZKb+BygxEsv/6eI630irlv/o7wbp4N02GBe93V17atgJbnV10PIDMez4BdoUeFYwyUTFUTEPLsEGWpJOpDiiO5Y5sFK4fwZYRDigz1E9gaXl2UoDZgO3bvvC9baJUnRvtkAPb96hj6DzF4doizSFdVTQ0WonBgLIPmE1LSA3nL67jHfQrqPMfXu0U/d9htPWooIY6S8Jcg1YbLI3u4w9rcwu2vy44kz1/0ZVO+Wn4cQGanxYWPDZd/+04HrVRwaBBhYPFn5piMt4YLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bgNJwWWw/9ZcbFIkhDosbBhNcHjqYUrWz+HaXezu5U=;
 b=fUbWK0JYnMzhGzZiicv1l/vpLJ/Y5ckQsjn1/97YA7XppdMVguAZa4+JUAdleMwINJENOfIc/t0E53+uU0D2B6yspFxUi5c/JzRjBm79q6sBRXt9oyLLdcyMWsirv7nLfbFBTzvw2ULv5lB7ti6f3awC+fISkEX1DEd1XZ+vtN/yK5Yeb7HgimJrPiFo+OCOrfAPN7kH6Uyop1+BmExHffoTDf6EOUAkYSJHqJGbVBX7nnopedQ3VTJB7g9yE8fYCmgRHnz1Kd2zlserHd/3luFDfq4192er1pDq4xY4RufZz+nCTEWPxayEsvtYNuOb2ANyMVY+MR+UPH5Pr59fJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BL1PR11MB6028.namprd11.prod.outlook.com (2603:10b6:208:393::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Sat, 17 Sep
 2022 13:56:06 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::938a:4e6d:d912:db43%3]) with mapi id 15.20.5632.018; Sat, 17 Sep 2022
 13:56:05 +0000
Date:   Sat, 17 Sep 2022 21:55:45 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
Message-ID: <YyXR4YgHeTR4Negc@chenyu5-mobl1>
References: <20220915165407.1776363-1-yu.c.chen@intel.com>
 <YyRhvEGS4ivPGf+z@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YyRhvEGS4ivPGf+z@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BL1PR11MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: d28e78b2-4f9e-4f25-1883-08da98b45d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzR0ta3MtnfXg1N0P1KeGfNmSInsKP/j0eaIAFekE4+j87ioYJs4xvBy191TTsOUZukVT/LwNGZtb3hzKnmAvEphXXL+wLHCQL5oFwoFLn2pYBCg9m2mJUj5GSTgY8o5BYU/Le0UmBEEaL73by6epR6x+M2LL9r0npovV+GVGqJ7dPmp3gQ240NAPi9i/IUUGu52YcWD6A4M23Ksx1J3DZ0aR7MC2bdhCIKKV8lZTsf3VG0o7XrTfaMzgQH+MphgK1P1EZObdw0AjePKjTaE/ClP3PlaCngzydfhM7GtQNClko+HORmp88PBkhGJWv7j4ty9zn4sxpwIKMZC4j0EYUv+tgQY2tLrfxxcQjbPvIET4fboqTdIm5+6YUgI5VS4kVURHgkO60ot+6sYDOAymheX6qnJSmF6sxqc/1gWAImM1rYtWmba2KTKAIrvYZfb8xmP8jSbMMwUIAjhKcy6bVyn8H105DD+GZcJFLP0gBY4LSKDUmBKhJPR439VwGZmFVPCk4RjsXn3bPA5/5WTtbXC9U/ShzL+6L9nfVigU1xLOnibHdokc+EJPBbKa3dd4/DdhjDtjOasgZCNWk2JjE7V1MiLL2qCXhvnIiFy6JrmouYPOupg2W73I+qt5n0M+jyqKbIFvcctmG0YfnXb6fY/sInkTrJUg/rCVAgeYo9jjMrb8hgIFkVIYaMXQjm6B7eKy9jskYQ2KdLN4S063Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(316002)(54906003)(6916009)(186003)(33716001)(9686003)(6666004)(8936002)(2906002)(6506007)(6486002)(478600001)(4326008)(53546011)(7416002)(8676002)(66556008)(66946007)(86362001)(5660300002)(41300700001)(26005)(82960400001)(38100700002)(66476007)(6512007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UhgTQLgV+nGpah7UIDNojqB4OSg/Zx6HLleOBnpQMJX1UF/btQ7bRG45Howc?=
 =?us-ascii?Q?1ov0bncnb90exLn0U06C/tycPNN7YoV4W0yFXC9D9c6wGLUm4eYrJF/xjxpo?=
 =?us-ascii?Q?m+BDGoMEniK8y2XnfmZa+aRoaRMd9LHGGzskSnm9WvOrIzx/HLmegrRXd+Zx?=
 =?us-ascii?Q?HR0HrBlMjQwKUcyxOspKb/+kRsT5wgovDUFiajrzrZQOToI1T+eFNMrR3kLH?=
 =?us-ascii?Q?Yt8kAGZTA6DWxnfUemWclrhngwrqO6OEaFk3DuWrHw7TGRyYqLcHk17GkfNb?=
 =?us-ascii?Q?DDI76ipFJHhGiEk7fqX3aLBdjVZlSxMzDdo/8eEmog0GIjEIbAZ0NOCO/hsh?=
 =?us-ascii?Q?kE+GGVVh0HC4+H4/6v9M3PvCs0DyD+6k9J6ISpAV4ECd5iiyb9Ie1fk0qocT?=
 =?us-ascii?Q?Rvbr1mTBUhDvH0aYtrTRmjGPR76fpxE8/dKgZP9JjIUoiWaGzGc7DNMA+6CJ?=
 =?us-ascii?Q?N3cZDhVK+56JS1tl8yKN0+i5AbyECFCOhjJpKFV5wu1NUj5iGm3/+BEniXEn?=
 =?us-ascii?Q?MMs70H7b4IoLA2vMVPD7qMSCdn3TlaUxiy5SjgmXK+lZ3KONNZR9TMkFfKiO?=
 =?us-ascii?Q?R8ek30Fc577HjqkqOEbqJN/AdAXfb9Rm1TULh2OVXKnn5lsQdUbgSwsXFInm?=
 =?us-ascii?Q?3VDgdShSQ0Bt1HXBeJY6cpSSYdDgoP5+4Vxuk5nQAzIouTnOhRj8i/zCDmSR?=
 =?us-ascii?Q?wVbzowM6oMdaP53Agnrf7094xP7PFj18XTQcXizUVAiLCUcXZs8Q7hvFLn5B?=
 =?us-ascii?Q?HPskUndlcAK55ZMrj0qbJe1tEtvOPnGhP8ROUXYTxnm6V/w+EzSmBVaH3Ohf?=
 =?us-ascii?Q?BDNQUg2PCWSoUCRvGP/IyIcpDhIRiBvH4apFtn85DyRHBbq7LZybuaVRL+L4?=
 =?us-ascii?Q?njBb6H7J3BA2ql1i31/UsxyB256YeVltRlks8WdY+FZNeYkGl6MUWmFewyc0?=
 =?us-ascii?Q?aW/2hlFYrqCK5DXZk08ZuFZLVArUMxunYt5bRMBueK7pbnSIX/auPyHpjOhb?=
 =?us-ascii?Q?9n1jV2UgHbFQO8CZnfH4CtnGXydz3+tHtkqsGj1+0SGsm6rMTf43syrnFVYz?=
 =?us-ascii?Q?jYUzUC5CQ99C2hdkT4F//yU4K2YsF96YOD454JCDdQ7XMcVByJ8FtsoSf7GF?=
 =?us-ascii?Q?WeTsvsE9sn7jauFFzfrxi4xZCrOTLtJapQNqHZctOUa6qnmUvSca6lNo9HH6?=
 =?us-ascii?Q?+lQ6CecCrti8xQmHiodejSFu1HrvEcnF4BRNDr/FYn6EzDj9MjXxUwkY2Jmw?=
 =?us-ascii?Q?wZHDmgLBljxfzAfLnndRCPJdPx18OQe2wOO47RCzy4SX6xK/+WH8cRRw6vlh?=
 =?us-ascii?Q?SUN445CgnXZckm5IW2o/wR6wO12nusdOikGI+pYIAkwINSEVIOIv8JenXo/A?=
 =?us-ascii?Q?k7JZlCsmwwEP5A2CscZgIOQkedmvzmUQUWfO3RbmDN7gkWaJSa96q2Z2L20Y?=
 =?us-ascii?Q?cP5g57Nzyfu2wA8iW+22akOZJMRvy3QJCSevQQoXNXZyov8eCv1SND5ZrUgw?=
 =?us-ascii?Q?kYz7YQivCpSepuKEVw6tlbiRAQnuUsKi9JrlE9HgjYQWjjSJmjn0a6XlSgBN?=
 =?us-ascii?Q?yd6mB29eq00ezfXzd7TTqzcu75sO4xhHLdH8VrDb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d28e78b2-4f9e-4f25-1883-08da98b45d72
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2022 13:56:05.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHsHgrU2ZPM4ExTeY3wjtQtnhMAYkah+wDybxQ5FJSW7nHFJF7feyaIZXUjy0o2BiDx1Tzny4LXJmxrVV/7+Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6028
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-16 at 13:45:00 +0200, Peter Zijlstra wrote:
> On Fri, Sep 16, 2022 at 12:54:07AM +0800, Chen Yu wrote:
> > And the rq lock bottleneck is composed of two paths(perf profile):
> > 
> > (path1):
> > raw_spin_rq_lock_nested.constprop.0;
> > try_to_wake_up;
> > default_wake_function;
> > autoremove_wake_function;
> > __wake_up_common;
> > __wake_up_common_lock;
> > __wake_up_sync_key;
> > pipe_write;
> > new_sync_write;
> > vfs_write;
> > ksys_write;
> > __x64_sys_write;
> > do_syscall_64;
> > entry_SYSCALL_64_after_hwframe;write
> 
> Can you please addr2line -i the raw_spin_rq_lock callsite so we know which is
> the one causing grief?
> 
> Specifically; I'm worried about PSI, psi_ttwu_dequeue() can cause ttwu()
> to take _2_ rq->lock, which absolutely blows for this case.
Above perf profile result was captured with 'psi=0' appended in the boot
commandline, and with NO_TTWU_QUEUE on 6.0-rc4. To narrow down we disabled
psi the first time we saw a rq lock contention. But even with psi=0 we still
observe the rq lock contention.

To confirm this, the 'perf report -F+period,srcline' was used to leverage
addr2line to parse the line. However it seems that with DWARF v4 enabled
in the kernel, the rq lock issue could not be reproduced. So I hacked the
code to make ttwu_queue() non-static, and perf profile shows that it grabs
the rq lock:

raw_spin_rq_lock_nested.constprop.0;
ttwu_queue;    <----------
try_to_wake_up;
default_wake_function;
autoremove_wake_function;
__wake_up_common;
__wake_up_common_lock;
__wake_up_sync_key;
pipe_write;
vfs_write;
ksys_write;
__x64_sys_write;
do_syscall_64;
entry_SYSCALL_64_after_hwframe;
write

Then if TTWU_QUEUE is enabled, the rq lock contention issue could
not be reproduced, but long idle duration was still observed due to
sched_ttwu_pending(as descibed in the commit log).


thanks,
Chenyu
