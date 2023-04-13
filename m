Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6016E088C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDMIDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjDMIDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:03:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06840EA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681373014; x=1712909014;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WDRV1iBzE4EEIpV6bHZCFMy0qXEgId9A/h+09bFK5Z0=;
  b=hK3LrBVrQkWNFuoB548jibetQ1A+nGX2fyuMMPWJot+VXN/Zk08ZRFTV
   MWlgHwKuV0OWKxeq584VQh+mieyCtco7Cn6LJg5L5xROckwn4zAhiKo+i
   t33D95ESMw1vMwtF2fEhSfn0GN8Wky44FXWasMyXPG9RRgtaU0Ku0rR7n
   K+PVh9R0TnVuI1styn1jE6Pwij2J/lKVQm/t7TvyfVCUnVuFQhFrfB7Sl
   sb9h1E34BDOMZv6ZY0Hmo5pCYx0LvtajHXEFBo0NTtNpbkJD7gHYmqXjI
   SL6/xv0Nh9rquriDRqTCF1xovoCz6mTia2k3VpOipXkgIy2ochT4zvfrI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="341615321"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="341615321"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 01:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="778668877"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="778668877"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2023 01:02:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 01:02:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 01:02:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 01:02:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6sT00IXVn7aHYpzl1VzF2/3lGKuO/nh0cWw5X1nkBs+TubvMLet/0f1+pnD8Xm0Wlnq5BmwwfJFiPDH7bo8w0HNMfAXdzB6nopedYFh7CGs5MoWIHWl7DmpZ3Xc0pNOuGCA4F71RYI5/hTZDFKsYWKvBxyMpxWslkfFyPMe0MJGybAZgXyc+mRMZOiKGBlcfNuThVSR6B8hq2hP26k4GPBPy7lG38JfZDG3Gj7VtFWsSU4QO9CtnunZJgIWwuezeZVvjDVscRlHfA2Y9fN6W0bVZL3VOFBEaQ4oOGMaIRxfthhqhyrjI76YhzaBJVojyM1iCN3Tj4W2KKoixL/s+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iETgVSkyyq7+liDv5Mrl+ZXin2CBIApheDwt/LsMDgo=;
 b=XAi+5yaIQNrnI03jzG/BcxzFcWZglFBQr7gaP+b4rez7S3EmrogDeJD2QvmkrT0v+csE+WFa2kTwKBp5xqwAsGdb47JQkcK8CizsuimJJaBK6K1Py3RQEmSE0rr6GDfeVTK+RL3nl/62Hg8sDWXR7jzXlVf+LXYXTgM+AF1pi6WSNGCEC1t360eQXQxrdp9KXSihy0sNFNtmZ/zptXjhVvCQHCAz2NPfi9Jrp/XPkC6osH08SkfeuBJ+/zmW8nTu6OvnTgyZtAYQiiliuqEz9SoomGbSoKXljttbc6mQyOUL6yXTByZXev5mJmYkNNQWQj+j0YzUODeXinu57XK6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 08:02:18 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 08:02:18 +0000
Date:   Thu, 13 Apr 2023 16:03:51 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     <lihuafei1@huawei.com>, <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <lkp@intel.com>,
        <frederic@kernel.org>, <quic_neeraju@quicinc.com>,
        <paulmck@kernel.org>, <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is "task hung in synchronize_rcu
 bisect" in v6.3-rc2 kernel
Message-ID: <ZDe3Z2WD5hxeQFTn@xpf.sh.intel.com>
References: <ZBG4HOCQIlGFFcIn@xpf.sh.intel.com>
 <20230413070042.1479-1-hdanton@sina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230413070042.1479-1-hdanton@sina.com>
X-ClientProxiedBy: SG2PR03CA0125.apcprd03.prod.outlook.com
 (2603:1096:4:91::29) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH8PR11MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b487040-3982-4b9d-d41f-08db3bf566ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPYInga72SRYWAB2z6CGKrO0m5HXtj9bZH0HYTr1KdPYa0etzV/M/t5cquXtMuNCWoBKsJ0bm35VyCiWfhrB7RptyQIqOv41EDiX15Kp8EU2hGojH5uOOUcT4+kWLmdQSxGiOLpUC8krbrGGA7Jnol4+RDz6n5M+qlM5JpxJFuyQS+VHIyNjk4LeM7m/QmlOt9uOm2UXEVYpLssp6+/dlaPBOu1AZgonTp1sRaN8YdQoWJJGnqnoPbTIJ5CsGWD77yhvVqrOvP8wE0+VmQlDpFD+ywnC5md4RJpDI3UR71l8uo5VcXys7vuLgMUguKj85D3IH2mWqyxt1Wn40SZBExGnL0MYbqRtvZDN5trkPPzXdoYUUjJK0JxV2MwiBCihkk+XT1pVRJuhDsl27z9X76HTrMtILT0C0/C9XNwzrAscwamhREymEaThqnQBdqly6vb0PW3GyrJ8zdh6XNpeHnBqyuHqFGbh6mdwPj2uLUzCv6S53UG6jMNNANvY2PK17esmn+YLJYacZwCdWIgqxf29hXY3z1mTvqQzUYFpFWbPnrXq+RXxBui3MkL3x97+/YGAMawwRMJVFpLFtmObLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(478600001)(6666004)(83380400001)(86362001)(82960400001)(38100700002)(2906002)(6486002)(966005)(44832011)(6506007)(53546011)(26005)(6512007)(316002)(5660300002)(186003)(107886003)(4326008)(8676002)(8936002)(41300700001)(6916009)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s4XoR7WqEKzf02YjYOX0zOPCcV56TY8A4/GWn0ZOAVT7z5wQy32aw4YMlooU?=
 =?us-ascii?Q?poV/2gs4EY9Vd8Cafs+4Cpr7HTvo0KwhawLjj/qzrPEbHTGyPLX0SpbpaYAf?=
 =?us-ascii?Q?giW+lTMPSRfT7T6+Ejc0vEWLgGB0WwL0qRJkPx6Zs0MdYCmqRjpXREHD+xT0?=
 =?us-ascii?Q?J2iWFHChS4M6vEmJfpS/jjVzTdW0XQY15QxFw4EBZK9/14BY9qsgFUcg2xyq?=
 =?us-ascii?Q?G923Uf8xYhhxh5zClCDxBfB54KY6udprA761XCd4G/QoXsrfO70ev5B9a7uW?=
 =?us-ascii?Q?tT1Tvt1jdkmI6gHzrodPBD5B34M02MSoG67eHcr/++EOwRcY8izENesBw9Zs?=
 =?us-ascii?Q?2C6+bgqA78hV73UZShF0GHQA+bsY3uGA9AZUcWd7jeN41Njjwa9OCu1YwTg5?=
 =?us-ascii?Q?daN3IExtZzgVIRLSehMCXLfUNrWGVI4zVfmXm8uP6a8pK6K9j5LSAkrEBKjB?=
 =?us-ascii?Q?YwIhpxHg97LGH9sxRwsMlc9lQz23vXNjMCjf6A1jwPKP1PRscbL7MoeUZQ9V?=
 =?us-ascii?Q?YM21C3B+NepkOt+1SbVASN0HblSYZzQJsw14DCynTZ7e4ke7vhc3nvXqxgHl?=
 =?us-ascii?Q?gPx19eTX3Q2YqHFaQWnqOO6cft5Jfsce1pofvGsQ8T4DJARnBnMVW8cH4n5R?=
 =?us-ascii?Q?b2NlILCXiEoXdhwRtc12GiiZNEqhsakvfYIi96zwLjyyQYu8lsMJ1thiZXKZ?=
 =?us-ascii?Q?vfV3kJkUxl519BzEXl2KrnhS6uwxcHa06+FmASfh7w0cctEAJJEGA6+GaqjR?=
 =?us-ascii?Q?VkCx2ZZCg8AmPKX5akuL1obqYk7q0v5zd84UEXQAfgdCGOCNG9drwqLCGN9P?=
 =?us-ascii?Q?wMbsZxuA57y6dIvSH39eyEYc40kozBMPmUuoXBw0KV+mbPQkd23qg7SeSBgE?=
 =?us-ascii?Q?byS8CxqQvgAwziPF9F00kJlyDQPgHiXOc/aqcfvLmC/4I/HWdOI3Os9VFzr/?=
 =?us-ascii?Q?AvW+We8AypnIBrT2mDMsJY5grLS+7mXfgOXtzw+5bFQ8jPE6ebHoEpeViy6h?=
 =?us-ascii?Q?/domWfDRNWUsCMmP3cKD9m3HXwfSXIeRzpUtDdqGBvN6giXShKGWYm+0l+K8?=
 =?us-ascii?Q?BCODCM9AjAhqmUZC/NEXdJtotIQL7ckwBpqdSWR5DpbMkw9PlyEjZqzwDvTR?=
 =?us-ascii?Q?OXUL3sYrQJ/BBPSxwZZb+ftJ+EGJEDz4MRGxmxxfwAwy0NMa4yePK6p7o25v?=
 =?us-ascii?Q?bydiYOdD6G1y71qWZDH0Aa6HaJPkNjsb7yaZexjD41fslE18zZjJH3SojP5G?=
 =?us-ascii?Q?NwSe7k/wGHUd6h1oQQoR9n3+EIeaFpZw4aVZnOZvlzyslGj4R1+UEE+sTydK?=
 =?us-ascii?Q?AP8QBZcaA9RCueQHfcuQwgtxKcIPhLcJNwqL803+Uzn6tPnsGbFpBsmFg5Lc?=
 =?us-ascii?Q?/VzLyvDK9Er5x2mylbaljNUob2/nS4wJmvNB96qjNibm2TJAzela7sFK07Es?=
 =?us-ascii?Q?8KeFKdPC6TyhtYXIiENFgnwc/Y58iLmoENe0IW5Lzk29clPtvpHqQ4yfwmd0?=
 =?us-ascii?Q?VHOWfCBAhzCt26O0gQz73b7NLxmBg/BaeVVTq4mWIJfDlclufNUcokKOWCCz?=
 =?us-ascii?Q?NGwFUSvw2drekxfluCAQ3VzAkitCz29RYxTKCBaI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b487040-3982-4b9d-d41f-08db3bf566ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 08:02:18.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LI3zgda1YJvvxSGrW9fUyNu/ocqibMkKbAdQbTMhCAJptcTtKsPwhTJWiN6Hqad/LeCeWh/9M8PBkB03ORWxYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6804
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

Hi Danton,

On 2023-04-13 at 15:00:42 +0800, Hillf Danton wrote:
> On 13 Apr 2023 10:45:35 +0800 Pengfei Xu <pengfei.xu@intel.com>
> > Hi Huafei and kernel experts,
> > 
> > It's a soft remind.
> > This issue could be reproduced in v6.3-rc6 kernel.
> > It could be reproduced on Alder lake, Raptor lake and so on x86 platforms.
> > After reverted the commit "0e792b89e6800c:ftrace: Fix use-after-free for
> > dynamic ftrace_ops" on top of v6.3-rc6 kernel, this issue was gone.
> > 
> > New syzkaller reproduced code, repro.report, bisect_info.log and detailed logs
> > are in link: https://github.com/xupengfe/syzkaller_logs/tree/main/230412_031722_synchronize_rcu
> > 
> > Thanks!
> > BR.
> > 
> > On 2023-03-15 at 20:20:44 +0800, Pengfei Xu wrote:
> > > Hi Li Huafei and kernel experts,
> > > 
> > > Greeting!
> > > 
> > > Platform: x86 platforms
> > > There is "task hung in synchronize_rcu bisect" in v6.3-rc2 kernel in guest:
> > > 
> > > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230315_023443_synchronize_rcu
> > > Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230315_023443_synchronize_rcu/repro.c
> > > Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230315_023443_synchronize_rcu/kconfig_origin
> > > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230315_023443_synchronize_rcu/bisect_info.log
> > > v6.3-rc2 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230315_023443_synchronize_rcu/eeac8ede17557680855031c6f305ece2378af326_dmesg.log
> > > "
> > > [   24.844767] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=330 'systemd'
> > > [   31.392668] hrtimer: interrupt took 10726570 ns
> 
> What hrtimer/s triggered this print? And for what? The hrtimer trace helps here.
> Info like that helps work out the cause of the task hang.
> Feel free to fold in the debug diff below if it makes sense to you.
> 
  Thanks for your debug patch.

  I newly updated previous alder lake S reproduced syzkaller repro.prog and
  machineInfo0(vm info) info in log link:
https://github.com/xupengfe/syzkaller_logs/tree/main/230315_023443_synchronize_rcu

And tried debug kernel on alder lake S, there were 2 cpu in guest, and
CPU1 reported "interrupt took 331596 ns", then kernel should not trigger
"rcu_tasks_wait_gp" for this issue.
"
[  104.171591] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=334 'systemd'
[  126.770981] hrtimer CPU1: interrupt took 331596 ns      //  "rcu_tasks_wait_gp" after 15s
[  141.127282] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 2571 jiffies old.
[  171.272100] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 10107 jiffies old.
[  261.767189] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 32731 jiffies old.
[  300.102911] INFO: task repro_rcu:398 blocked for more than 147 seconds.
[  300.103408]       Not tainted 6.3.0-rc6-dbg-dirty #1
[  300.103743] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  300.104230] task:repro_rcu       state:D stack:0     pid:398   ppid:396    flags:0x00004006
[  300.104780] Call Trace:
[  300.104992]  <TASK>
[  300.105265]  __schedule+0x40a/0xc30
[  300.105706]  ? wait_for_completion+0x7b/0x180
[  300.106041]  schedule+0x5b/0xe0
[  300.106330]  schedule_timeout+0x4db/0x5b0
[  300.106959]  ? schedule_timeout+0x9/0x5b0
[  300.107364]  ? wait_for_completion+0x7b/0x180
[  300.107698]  wait_for_completion+0xa6/0x180
[  300.108141]  __wait_rcu_gp+0x136/0x160
[  300.108474]  ? __pfx_arch_ftrace_ops_list_func+0x10/0x10
[  300.108875]  synchronize_rcu_tasks_generic.part.24+0x3b/0x60
[  300.109263]  ? __pfx_call_rcu_tasks+0x10/0x10
[  300.109592]  ? __pfx_wakeme_after_rcu+0x10/0x10
[  300.110020]  ? verify_cpu+0x10/0x100
[  300.110353]  synchronize_rcu_tasks_generic+0x24/0x70
[  300.110840]  synchronize_rcu_tasks+0x19/0x20
[  300.111173]  ftrace_shutdown+0x1cc/0x410
[  300.111564]  unregister_ftrace_function+0x35/0x230
[  300.111950]  ? __sanitizer_cov_trace_switch+0x57/0xa0
[  300.112380]  perf_ftrace_event_register+0x95/0xf0
[  300.112733]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  300.113092]  perf_trace_destroy+0x3a/0xa0
[  300.113410]  ? __pfx_tp_perf_event_destroy+0x10/0x10
[  300.113768]  tp_perf_event_destroy+0x1e/0x30
[  300.114109]  _free_event+0x101/0x810
[  300.114470]  put_event+0x3c/0x50
[  300.114920]  perf_event_release_kernel+0x2de/0x360
[  300.115266]  ? perf_event_release_kernel+0x9/0x360
[  300.115685]  ? __pfx_perf_release+0x10/0x10
[  300.116036]  perf_release+0x22/0x30
[  300.116344]  __fput+0x11f/0x450
[  300.116739]  ____fput+0x1e/0x30
[  300.117031]  task_work_run+0xb6/0x120
[  300.117407]  do_exit+0x547/0x12b0
[  300.117739]  ? write_comp_data+0x2f/0x90
[  300.118141]  do_group_exit+0x5e/0xf0
[  300.118498]  get_signal+0x1465/0x14a0
[  300.119142]  arch_do_signal_or_restart+0x33/0x280
[  300.119697]  exit_to_user_mode_prepare+0x13b/0x210
[  300.120078]  syscall_exit_to_user_mode+0x2d/0x60
[  300.120439]  do_syscall_64+0x4a/0x90
[  300.120748]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  300.121102] RIP: 0033:0x7f2c55b8a59d
[  300.121389] RSP: 002b:00007ffc6ea72078 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[  300.121894] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f2c55b8a59d
[  300.122332] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
[  300.122890] RBP: 00007ffc6ea72090 R08: 0000000000000000 R09: 00007ffc6ea72090
[  300.123327] R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000004011c0
[  300.123765] R13: 00007ffc6ea721b0 R14: 0000000000000000 R15: 0000000000000000
[  300.124479]  </TASK>
[  300.124676] 
               Showing all locks held in the system:
[  300.125063] 1 lock held by rcu_tasks_kthre/11:
[  300.125370]  #0: ffffffff83d63450 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
[  300.126170] 1 lock held by rcu_tasks_rude_/12:
[  300.126476]  #0: ffffffff83d631d0 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
[  300.127421] 1 lock held by rcu_tasks_trace/13:
[  300.127728]  #0: ffffffff83d62f10 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
[  300.128551] 1 lock held by khungtaskd/29:
[  300.128834]  #0: ffffffff83d63e60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x1b/0x1e0
[  300.129607] 1 lock held by systemd-journal/124:
[  300.129921] 2 locks held by repro_rcu/398:
[  300.130209]  #0: ffffffff83e20668 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
[  300.131083]  #1: ffffffff83e1cd28 (ftrace_lock){+.+.}-{3:3}, at: unregister_ftrace_function+0x2b/0x230

[  300.132040] =============================================
"

Thanks!
BR.

> +++ b/kernel/time/hrtimer.c
> @@ -1866,7 +1866,7 @@ retry:
>  	else
>  		expires_next = ktime_add(now, delta);
>  	tick_program_event(expires_next, 1);
> -	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
> +	pr_warn_once("hrtimer CPU%u: interrupt took %llu ns\n", cpu_base->cpu, ktime_to_ns(delta));
>  }
>  
>  /* called with interrupts disabled */
