Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584F566B237
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 16:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjAOP4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 10:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjAOP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 10:56:38 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A465590
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 07:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673798194; x=1705334194;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=j2+kHyXpC7LIMAw5jMVZWe1n26fUpZIVFt6tUXOcrTo=;
  b=kiL+m7zZCTM3eCYp7jH3ibHt5fINkx22LxaJt57WL/joXM4RTQIBwl4x
   Fz26bagOSfuHc5s0ImGwOPivnJgu4T53h9H/QHXxpsu/UVw4jOfbV1apP
   Yy9ylKGx0Ht18vJDoy1uHncEme1hcTkRfmBgqv0gBPVtHnkQ7JnAPI40r
   A8r+xkMk1v+0S5sw22Yv4ynWnSB6OMFq7Ks6wL1YWCCwBMLiu+LRzUA8N
   LKACDwRsi7KYjrF+z7ZVZ7K+Z6TBrWm6OPxoWP/7ieC8fMBwBG6kkTY5h
   aHntEky7PXh2SjQ7979f/6T07YpkL5NjYa4VXsYIoG62P+3oiRJTp2z7D
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="312153030"
X-IronPort-AV: E=Sophos;i="5.97,218,1669104000"; 
   d="xz'341?scan'341,208,341";a="312153030"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 07:56:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="608672349"
X-IronPort-AV: E=Sophos;i="5.97,218,1669104000"; 
   d="xz'341?scan'341,208,341";a="608672349"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2023 07:56:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 15 Jan 2023 07:56:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 15 Jan 2023 07:56:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 15 Jan 2023 07:56:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxApdXjb3K3RIcD+NmFwI4R2is520xqp4GzlpRjmT8yoljnHhHa9MwoxTRTXJTahFBT1DFtejAk2lh7D9iLCCc/H1549p+7xicR3ZBcXQ5SaRIhaB/y2tvzSWKL9pLqDVttUrE3vjCzpVc5Goajf8WbP7FQIOAKpgQMcxNsNwNQg/K8R67cg7Uoz1TD/U14NCP9ZyKio7ZxdzMuO/cyr0PUJaVmwZNjq/L0TKBzaczTf4+wQYESm4TwWlrwJR0y4yUFA31BHS4DopRbEZWpY59Bv15OlEzS3OO14YtXmoDbNrJ34ILKHjV5f0TtqgTaWMT0L/mFEBz9y3Krx4djelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx2Xe+TLO4bAgN5VCYVA0FEmfK2g+sxBBsmlJIuYgw0=;
 b=GxPkOSiK3UkVDreTjEquEtn9RrfM2MGuaZOiVNOd33Kc12y8skb5gLFFU284p0GvZy3KRdYtV8lro/d1HcN7f1/uDgSjcRfZxwuJNkhvp2jaZH37WszIgjEZAXw98ImDqo1LRBbW1+n9QDBXnuf7jt8+CCy0VNT6MyAvZjt9or5BTBpfJWu5QG9BtWc0xs/A3q702JsjPfoTV6J4qyQaDFSAtcKqHfIlADxNAY1vImCYj5xebtkp8gtVHzoTjCRxoyg/0X0sjsCxfWLU/VJeCZfVwUk3TGrfqus3QZWYAao772YPmNazYRc/sPmzaa+9/HuO8xfv1CN0VlKf5vSUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH0PR11MB5078.namprd11.prod.outlook.com (2603:10b6:510:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Sun, 15 Jan
 2023 15:56:24 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb%9]) with mapi id 15.20.6002.013; Sun, 15 Jan 2023
 15:56:24 +0000
Date:   Sun, 15 Jan 2023 23:54:23 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Waiman Long <longman@redhat.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Wenjie Li <wenjieli@qti.qualcomm.com>,
        David Wang =?utf-8?B?546L5qCH?= <wangbiao3@xiaomi.com>,
        Quentin Perret <qperret@google.com>,
        Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 2/2] sched: Use kfree_rcu() in do_set_cpus_allowed()
Message-ID: <202301151806.7a38aef3-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="mfOYB9PSQvRd+oox"
Content-Disposition: inline
In-Reply-To: <20221231041120.440785-3-longman@redhat.com>
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH0PR11MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 33291ca6-7dc9-4e23-60c3-08daf7110d5e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/GBf+kPr1MwAPrTCHNwWsdBcGNWwjYBe88h+1bSdvjsFP3hpdIGuhS9Q5OT7Tbh7NajEdhDz5QYwP9EQ6VLne1wjVtpxpLg8qzLPRbMUaJGhRaDTC805fCfd/P4f7eRy8kgihkV5FngB59VxxVqKJAiON+LNoCZRzMV7s0DGTA7etu6u7HwdexKGx9QWRSihyVzfTl2gasMtyHWJlRiQ7LzgfEdU7kxqEdhh/Nk1nrnm3pJumpUOcUcirFFtcsdXSLQOK8FKWpX/CryG+OSpyNHLdcUybPgCN5vatr2LkcBK+NsPP6PaFDNhsaGi1jmgVXiN32UGn6/+0F7TuMN7AmSwlepnowNBKi4XwFTOItGBeBqWLYsjes/T8odXQBBXCm9BJQu025omu0ZmQ8baBIy+yYUvH25UFq3HWgfVM2P+jQH32hXN6SBs3qev1KZU6wEOW8qjpG+PN+dUAGlfUTr/mPlpi6jhbpI0z8HKNJsrVa7EfMZOKWaiAzT21BaaMcnsZiqcQwnFkpuapDTlYdvd5eynPF7CdVI2aqCLRiEDbJVU/kylXSl8A8it7lD2VDYYyF8bHhXcAS8ctO1EZ48p48GGjgZ/Zk26zx/+hbVqadA1Iq0I5s4CevYe50VaTmmmfSR9uGGvtVs1WtQFnGU7QvMpYmzBSHCXoOwGywdXho4yOh8/1Q7M1puqXmkbSF9yZvRgmCX94nKKBC8bXFBs85yz3TAJYQ+n7F2Gts4QR74/j/4cN/JqJoMdcNEEcxfggP/ESVD5H2/ed3qzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199015)(82960400001)(38100700002)(7416002)(5660300002)(45080400002)(235185007)(6506007)(44144004)(478600001)(66946007)(66476007)(8676002)(4326008)(66556008)(6916009)(26005)(6486002)(6512007)(54906003)(2906002)(186003)(966005)(36756003)(8936002)(1076003)(86362001)(316002)(2616005)(83380400001)(41300700001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z6OgHklb7eJXFfaw/fmQNr4nJjinJAfsqXpcWOJ+FfOMH+PS9jaxP4sijMrB?=
 =?us-ascii?Q?lhICx0Y26yC2UO3dTjdoOyRJtRVbLA4RixsvPVj7pslVm4U8kDYtefPlpjv9?=
 =?us-ascii?Q?+pkBi0qZEj23VRFnfs2ASXeQOII9I5gdDfo9HUVhjackssM80kkaosWA6r3h?=
 =?us-ascii?Q?k8CQ/m7wLrlYnYH8QbEw9SEp3H3+amBcRfhwzPwGGcN4/2c3PoLp5ec0Ip0V?=
 =?us-ascii?Q?JPcA5df3GbFGdXN5eOKPxEOiH+RSwVm7kHhQ78r/nPX5nHzJrCxIMZR4EE4x?=
 =?us-ascii?Q?+AnxZ3toRbjIBZSyYSfDWi3ClIJaT6+enMt1QP+Hyva5thFU71wMJxehD3xU?=
 =?us-ascii?Q?4Y+3wzVmyFfFUc/uCUDoaXyfQlmlEq1ks2LbV1Xl0RoIULx0DFCuJJB2wWAC?=
 =?us-ascii?Q?r/Uar/AaA465kdnpu3bnoJIHClmt8ogSntdB0HAjHEb/GlcqAj++G+VDiXdR?=
 =?us-ascii?Q?rc+X/zwQM3gx5GQZUfCOv3GBqmwEuC6Yc8B4pxNuO5jXTtsv+QwZkAcA4sKu?=
 =?us-ascii?Q?IIvfdCoy5qEcv6Ajk2G+n1XJkdcjupHUxuG1Ovw8MMcMSurbOsj3/8lS6qiO?=
 =?us-ascii?Q?wF8nPy6w0Dl5+unC5uYrBSlD38Ztk03DerirADMLZbNOvYTKBOHhrinupHI7?=
 =?us-ascii?Q?C0PnQCmtAZsqQbwaWbt1Pn5+1HqqCqsEqNTVrb/PkZlu543elpAxCYLb0pQc?=
 =?us-ascii?Q?ZsJiAOPR55v88A+OK48C7ZaKBBGFiKNKa2QMnCM9fMJ17AGmNonu3eTyJsW5?=
 =?us-ascii?Q?dVd4yZmx91LXEehR4qIMcTHPw25+TVEDQR2NRFIVs2ZcQ9B1XCyl9qps+yWV?=
 =?us-ascii?Q?yJi8i75PTwCvZlvrjU6oUYwkwl0zOyc5sN1YPUx92IMSH3MzfV+wXnoKJawY?=
 =?us-ascii?Q?o6DNBZFLXfhgANy27x5exyzyWX+u0Sh2z9hWqAuyNBGOnZOJGfc8VGSgDSiL?=
 =?us-ascii?Q?JbZCsIyntVJDuOSAkGWv+LXWwTuVexxh//H6RghAxgykgb7kAEduZSpmDu2v?=
 =?us-ascii?Q?Ibo5ptxBZjTBrCdCW10ZMhAIcihEkMFD65Si3nrHS9DRbBynuL31PKMzy2iD?=
 =?us-ascii?Q?rhvzavNDhN2e5e51DOvRnYnSGJdCIFOWdpCrZNMcxz6+Vxo71jEJwN36MPRP?=
 =?us-ascii?Q?qX4RbUdxZNxsautOcXqWf+W0I/iJH9fVqCwS16w5Rtf91umkADm6WhB4K+YP?=
 =?us-ascii?Q?ySF3aAV4ceLK/y76KeLtYiVtbEGge0V8DykWygCuX2vy5uhFEvxCrlc34Q3I?=
 =?us-ascii?Q?01jjYtcv05tYIsv4rCY90N0AUAEIbOUTSF+dcJp+sUykbVXYn+OslZo4bMzl?=
 =?us-ascii?Q?Tc8OTPX68iSJTMs3Y7/WdlaOvvHWi99d/yKTrUn/2VEWxQB2Jns8HVqH4gbX?=
 =?us-ascii?Q?HIDqu139mL/27k/FnOya1dhZnat3Xv34Pzuhu3DoOyxXVLLZtr45u6nGRpYl?=
 =?us-ascii?Q?jOquuHu3W9WdFgpSU50DJQ+lpkU/yiZOXTEYjF35mZyqHzJKRdZ7l6FryFUb?=
 =?us-ascii?Q?8V3Sb1mEQGj/m0jOpt9rED6UB4TO8ZribRkQDVd/B+KUL5F+2WStm9Sb/S/2?=
 =?us-ascii?Q?38yVMkpYKmG26/QHyYEIk9Std3i3JEigG/bP+Nqm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33291ca6-7dc9-4e23-60c3-08daf7110d5e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 15:56:24.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVnI+ZMqsMVsSLvpmG388k8DkpM1rlRd2mnS3cWu2Kza37OX949cwTewj3YCRAprFGQ/FG2U/0xFTTS94RADrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5078
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--mfOYB9PSQvRd+oox
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greeting,

FYI, we noticed general protection fault due to commit (built with gcc-11):

commit: 66f9c1813a72eecafa25492b551bb91b4fad59e1 ("[PATCH v6 2/2] sched: Use kfree_rcu() in do_set_cpus_allowed()")
url: https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/sched-Fix-use-after-free-bug-in-dup_user_cpus_ptr/20221231-121414
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git c89970202a1153b2fc230e89f90c180bd5bcbcef
patch link: https://lore.kernel.org/all/20221231041120.440785-3-longman@redhat.com/
patch subject: [PATCH v6 2/2] sched: Use kfree_rcu() in do_set_cpus_allowed()

in testcase: trinity
version: trinity-x86_64-e63e4843-1_20220913
with following parameters:

	runtime: 300s
	group: group-03

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


[   84.410147][  T190]
[   84.419943][  T190] Seeding trinity by 195457372 based on vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a011-20221226
[   84.419977][  T190]
[   96.648869][  T190] 2023-01-13 19:33:59 chroot --userspec nobody:nogroup / trinity -q -q -l off -s 195457372 -N 999999999 -c accept -c capget -c clock_settime -c clone3 -c fchmodat -c fchown16 -c fstat64 -c futex_waitv -c getgid -c getpgid -c getrlimit -c inotify_init -c io_uring_setup -c ipc -c kcmp -c kill -c madvise -c move_pages -c mq_timedsend -c munmap -c old_readdir -c open -c openat -c personality -c pidfd_getfd -c pipe -c preadv -c process_mrelease -c readv -c reboot -c rename -c semop -c semtimedop -c setfsuid16 -c setresuid16 -c shmctl -c signalfd4 -c sigprocmask -c sigsuspend -c ssetmask -c timer_delete -c times -c truncate64 -c userfaultfd
[   96.648897][  T190]
[  102.200867][ T3929] general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] KASAN
[  102.202727][ T3929] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[  102.204168][ T3929] CPU: 0 PID: 3929 Comm: trinity-main Tainted: G                T  6.2.0-rc1-00030-g66f9c1813a72 #27 d46a36d033aa326de17d60a34c369156bd255876
[  102.206484][ T3929] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[ 102.208121][ T3929] RIP: 0010:sched_setaffinity (??:?) 
[ 102.209102][ T3929] Code: 4c 89 fa b8 ff ff 37 00 48 c1 ea 03 48 c1 e0 2a 80 3c 02 00 74 08 4c 89 ff e8 47 8c 2e 00 b8 ff ff 37 00 4d 8b 3f 48 c1 e0 2a <80> 38 00 74 07 31 ff e8 9c 8c 2e 00 48 c7 c0 48 26 b6 84 ba ff ff
All code
========
   0:	4c 89 fa             	mov    %r15,%rdx
   3:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
   8:	48 c1 ea 03          	shr    $0x3,%rdx
   c:	48 c1 e0 2a          	shl    $0x2a,%rax
  10:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  14:	74 08                	je     0x1e
  16:	4c 89 ff             	mov    %r15,%rdi
  19:	e8 47 8c 2e 00       	callq  0x2e8c65
  1e:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
  23:	4d 8b 3f             	mov    (%r15),%r15
  26:	48 c1 e0 2a          	shl    $0x2a,%rax
  2a:*	80 38 00             	cmpb   $0x0,(%rax)		<-- trapping instruction
  2d:	74 07                	je     0x36
  2f:	31 ff                	xor    %edi,%edi
  31:	e8 9c 8c 2e 00       	callq  0x2e8cd2
  36:	48 c7 c0 48 26 b6 84 	mov    $0xffffffff84b62648,%rax
  3d:	ba                   	.byte 0xba
  3e:	ff                   	(bad)  
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	80 38 00             	cmpb   $0x0,(%rax)
   3:	74 07                	je     0xc
   5:	31 ff                	xor    %edi,%edi
   7:	e8 9c 8c 2e 00       	callq  0x2e8ca8
   c:	48 c7 c0 48 26 b6 84 	mov    $0xffffffff84b62648,%rax
  13:	ba                   	.byte 0xba
  14:	ff                   	(bad)  
  15:	ff                   	.byte 0xff
[  102.212105][ T3929] RSP: 0018:ffffc90005237e40 EFLAGS: 00010286
[  102.213141][ T3929] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  102.214501][ T3929] RDX: 1ffff92000a46fdd RSI: ffffffff8410cde0 RDI: ffffffff839661d8
[  102.215862][ T3929] RBP: ffffc90005237eb0 R08: 0000000000000000 R09: ffffffff8597ace7
[  102.217213][ T3929] R10: 0000000000000000 R11: ffffffff811a63eb R12: ffff88816fe32880
[  102.218596][ T3929] R13: ffffc90005237e88 R14: 1ffff92000a46fc9 R15: 0000000000000001
[  102.219945][ T3929] FS:  00007f23de705600(0000) GS:ffffffff83cd4000(0000) knlGS:0000000000000000
[  102.221395][ T3929] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  102.222380][ T3929] CR2: 00007f23de624060 CR3: 000000013f39d000 CR4: 00000000000406f0
[  102.223604][ T3929] DR0: 00007f23dc674000 DR1: 0000000000000000 DR2: 0000000000000000
[  102.224807][ T3929] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000070602
[  102.226095][ T3929] Call Trace:
[  102.226701][ T3929]  <TASK>
[ 102.227316][ T3929] ? sched_set_fifo_low (??:?) 
[ 102.228240][ T3929] __x64_sys_sched_setaffinity (??:?) 
[ 102.229285][ T3929] ? sched_setaffinity (??:?) 
[ 102.230220][ T3929] ? lockdep_hardirqs_on_prepare (lockdep.c:?) 
[ 102.231362][ T3929] do_syscall_64 (??:?) 
[ 102.232178][ T3929] entry_SYSCALL_64_after_hwframe (??:?) 
[  102.233183][ T3929] RIP: 0033:0x7f23de6240d7
[ 102.234006][ T3929] Code: 1f 40 00 48 8b 15 b9 8d 0d 00 f7 d8 41 b9 ff ff ff ff 64 89 02 44 89 c8 c3 66 2e 0f 1f 84 00 00 00 00 00 b8 cb 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 29 41 89 c0 83 f8 ff 74 18 64 c7 04 25 38 00
All code
========
   0:	1f                   	(bad)  
   1:	40 00 48 8b          	add    %cl,-0x75(%rax)
   5:	15 b9 8d 0d 00       	adc    $0xd8db9,%eax
   a:	f7 d8                	neg    %eax
   c:	41 b9 ff ff ff ff    	mov    $0xffffffff,%r9d
  12:	64 89 02             	mov    %eax,%fs:(%rdx)
  15:	44 89 c8             	mov    %r9d,%eax
  18:	c3                   	retq   
  19:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  20:	00 00 00 
  23:	b8 cb 00 00 00       	mov    $0xcb,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 29                	ja     0x5b
  32:	41 89 c0             	mov    %eax,%r8d
  35:	83 f8 ff             	cmp    $0xffffffff,%eax
  38:	74 18                	je     0x52
  3a:	64                   	fs
  3b:	c7                   	.byte 0xc7
  3c:	04 25                	add    $0x25,%al
  3e:	38 00                	cmp    %al,(%rax)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 29                	ja     0x31
   8:	41 89 c0             	mov    %eax,%r8d
   b:	83 f8 ff             	cmp    $0xffffffff,%eax
   e:	74 18                	je     0x28
  10:	64                   	fs
  11:	c7                   	.byte 0xc7
  12:	04 25                	add    $0x25,%al
  14:	38 00                	cmp    %al,(%rax)
[  102.236736][ T3929] RSP: 002b:00007ffcfaa833d8 EFLAGS: 00000206 ORIG_RAX: 00000000000000cb
[  102.238145][ T3929] RAX: ffffffffffffffda RBX: 00007f23dcfd5000 RCX: 00007f23de6240d7
[  102.239362][ T3929] RDX: 00007ffcfaa83410 RSI: 0000000000000080 RDI: 0000000000000f59
[  102.240707][ T3929] RBP: 0000000000000f59 R08: 0000000000000078 R09: 0000000000000000
[  102.242100][ T3929] R10: 00007f23de7297c0 R11: 0000000000000206 R12: 000055abbb602180
[  102.243459][ T3929] R13: 00007f23dcfd5000 R14: 0000000000000000 R15: 0000000000000000
[  102.244777][ T3929]  </TASK>
[  102.245406][ T3929] Modules linked in: crc32c_intel polyval_clmulni polyval_generic input_leds ghash_clmulni_intel mac_hid processor fuse stm_p_basic ofpart cmdlinepart
[  102.247940][ T3929] ---[ end trace 0000000000000000 ]---
[ 102.248887][ T3929] RIP: 0010:sched_setaffinity (??:?) 
[ 102.249926][ T3929] Code: 4c 89 fa b8 ff ff 37 00 48 c1 ea 03 48 c1 e0 2a 80 3c 02 00 74 08 4c 89 ff e8 47 8c 2e 00 b8 ff ff 37 00 4d 8b 3f 48 c1 e0 2a <80> 38 00 74 07 31 ff e8 9c 8c 2e 00 48 c7 c0 48 26 b6 84 ba ff ff
All code
========
   0:	4c 89 fa             	mov    %r15,%rdx
   3:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
   8:	48 c1 ea 03          	shr    $0x3,%rdx
   c:	48 c1 e0 2a          	shl    $0x2a,%rax
  10:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  14:	74 08                	je     0x1e
  16:	4c 89 ff             	mov    %r15,%rdi
  19:	e8 47 8c 2e 00       	callq  0x2e8c65
  1e:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
  23:	4d 8b 3f             	mov    (%r15),%r15
  26:	48 c1 e0 2a          	shl    $0x2a,%rax
  2a:*	80 38 00             	cmpb   $0x0,(%rax)		<-- trapping instruction
  2d:	74 07                	je     0x36
  2f:	31 ff                	xor    %edi,%edi
  31:	e8 9c 8c 2e 00       	callq  0x2e8cd2
  36:	48 c7 c0 48 26 b6 84 	mov    $0xffffffff84b62648,%rax
  3d:	ba                   	.byte 0xba
  3e:	ff                   	(bad)  
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	80 38 00             	cmpb   $0x0,(%rax)
   3:	74 07                	je     0xc
   5:	31 ff                	xor    %edi,%edi
   7:	e8 9c 8c 2e 00       	callq  0x2e8ca8
   c:	48 c7 c0 48 26 b6 84 	mov    $0xffffffff84b62648,%rax
  13:	ba                   	.byte 0xba
  14:	ff                   	(bad)  
  15:	ff                   	.byte 0xff
[  102.253027][ T3929] RSP: 0018:ffffc90005237e40 EFLAGS: 00010286
[  102.254116][ T3929] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  102.255456][ T3929] RDX: 1ffff92000a46fdd RSI: ffffffff8410cde0 RDI: ffffffff839661d8
[  102.256858][ T3929] RBP: ffffc90005237eb0 R08: 0000000000000000 R09: ffffffff8597ace7
[  102.258260][ T3929] R10: 0000000000000000 R11: ffffffff811a63eb R12: ffff88816fe32880
[  102.261801][ T3929] R13: ffffc90005237e88 R14: 1ffff92000a46fc9 R15: 0000000000000001
[  102.263250][ T3929] FS:  00007f23de705600(0000) GS:ffffffff83cd4000(0000) knlGS:0000000000000000
[  102.264793][ T3929] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  102.265904][ T3929] CR2: 00007f23de624060 CR3: 000000013f39d000 CR4: 00000000000406f0
[  102.267328][ T3929] DR0: 00007f23dc674000 DR1: 0000000000000000 DR2: 0000000000000000
[  102.268665][ T3929] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000070602
[  102.270108][ T3929] Kernel panic - not syncing: Fatal exception
[  102.271164][ T3929] Kernel Offset: disabled


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202301151806.7a38aef3-yujie.liu@intel.com


To reproduce:

        # build kernel
	cd linux
	cp config-6.2.0-rc1-00030-g66f9c1813a72 .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

--mfOYB9PSQvRd+oox
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.2.0-rc1-00030-g66f9c1813a72"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.2.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_CGROUP_FAVOR_DYNMODS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_X86_IOPL_IOPERM is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
# CONFIG_SPECULATION_MITIGATIONS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_FPDT=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=m
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=m
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
# CONFIG_ACPI_THERMAL is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_CONFIGFS=y
CONFIG_ACPI_PFRUT=y
CONFIG_ACPI_PCC=y
CONFIG_ACPI_FFH=y
CONFIG_PMIC_OPREGION=y
CONFIG_BYTCRC_PMIC_OPREGION=y
CONFIG_CHTCRC_PMIC_OPREGION=y
# CONFIG_CHT_WC_PMIC_OPREGION is not set
CONFIG_CHT_DC_TI_PMIC_OPREGION=y
CONFIG_ACPI_VIOT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
CONFIG_CPU_IDLE_GOV_TEO=y
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32_ABI is not set
# end of Binary Emulations

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODULE_UNLOAD_TAINT_TRACKING=y
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_FC_APPID=y
CONFIG_BLK_CGROUP_IOCOST=y
# CONFIG_BLK_CGROUP_IOPRIO is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
# CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=m
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_STATS=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
# CONFIG_PTE_MARKER_UFFD_WP is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
# CONFIG_DAMON_PADDR is not set
CONFIG_DAMON_SYSFS=y
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=y
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# CONFIG_FW_CACHE is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=y
CONFIG_REGMAP_SPI_AVMM=m
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MOXTET=m
# CONFIG_MHI_BUS is not set
CONFIG_MHI_BUS_EP=y
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=m
# CONFIG_GNSS_USB is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=m
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_OF_PARTS=m
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
CONFIG_MTD_MAP_BANK_WIDTH_16=y
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
# CONFIG_MTD_CFI_I1 is not set
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_I4=y
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
CONFIG_MTD_SBC_GXX=y
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=m
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_PCMCIA is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_MCHP23K256=m
# CONFIG_MTD_MCHP48L640 is not set
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=m
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
CONFIG_MTD_NAND_ECC_SW_BCH=y
CONFIG_MTD_NAND_ECC_MXIC=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
CONFIG_MTD_SPI_NOR_SWP_DISABLE=y
# CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE is not set
# CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
# CONFIG_MTD_UBI is not set
CONFIG_MTD_HYPERBUS=y
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_HI6421V600_IRQ=m
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_HISI_HIKEY_USB is not set
# CONFIG_OPEN_DICE is not set
CONFIG_VCPU_STALL_DETECTOR=m
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=m
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
CONFIG_ECHO=m
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=m
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=m
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
CONFIG_SCSI_ADVANSYS=y
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_DWC is not set
CONFIG_AHCI_CEVA=y
CONFIG_AHCI_QORIQ=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_SBP2 is not set
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=m
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
CONFIG_KEYBOARD_ADP5588=m
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=m
CONFIG_KEYBOARD_DLINK_DIR685=m
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=m
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_PINEPHONE=y
CONFIG_KEYBOARD_SAMSUNG=m
CONFIG_KEYBOARD_GOLDFISH_EVENTS=m
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
CONFIG_KEYBOARD_TC3589X=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CAP11XX=m
CONFIG_KEYBOARD_BCM=m
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADC=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_USB=m
CONFIG_JOYSTICK_IFORCE_232=m
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
# CONFIG_JOYSTICK_XPAD_FF is not set
# CONFIG_JOYSTICK_XPAD_LEDS is not set
CONFIG_JOYSTICK_PSXPAD_SPI=m
# CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_QWIIC is not set
CONFIG_JOYSTICK_FSIA6B=m
CONFIG_JOYSTICK_SENSEHAT=y
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_APBPS2 is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LEGACY_TIOCSTI=y
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_16550A_VARIANTS=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=y
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SIFIVE=m
CONFIG_SERIAL_LANTIQ=y
# CONFIG_SERIAL_LANTIQ_CONSOLE is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=m
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=m
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_FSL_LINFLEXUART=y
# CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_SPRD=m
CONFIG_SERIAL_LITEUART=m
CONFIG_SERIAL_LITEUART_MAX_PORTS=1
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=m
CONFIG_VIRTIO_CONSOLE=m
# CONFIG_IPMI_HANDLER is not set
# CONFIG_SSIF_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=m
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_CCTRNG=m
CONFIG_HW_RANDOM_XIPHERA=m
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

CONFIG_MWAVE=y
CONFIG_DEVMEM=y
# CONFIG_NVRAM is not set
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=m
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_CHT_WC=y
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=m
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_RK3X=m
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_DLN2=m
# CONFIG_I2C_CP2615 is not set
# CONFIG_I2C_PCI1XXXX is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_FSI=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=m
# CONFIG_SVC_I3C_MASTER is not set
# CONFIG_MIPI_I3C_HCI is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_CADENCE_QUADSPI=y
CONFIG_SPI_CADENCE_XSPI=m
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_DLN2=m
CONFIG_SPI_FSI=m
CONFIG_SPI_NXP_FLEXSPI=m
CONFIG_SPI_GPIO=m
CONFIG_SPI_INTEL=m
# CONFIG_SPI_INTEL_PCI is not set
CONFIG_SPI_INTEL_PLATFORM=m
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_MICROCHIP_CORE=m
CONFIG_SPI_MICROCHIP_CORE_QSPI=m
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_SC18IS602 is not set
CONFIG_SPI_SIFIVE=y
CONFIG_SPI_SN_F_OSPI=y
CONFIG_SPI_MXIC=y
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=m
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=m
CONFIG_SPI_SLAVE=y
# CONFIG_SPI_SLAVE_TIME is not set
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=m
# CONFIG_SPMI_HISI3670 is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_AXP209=m
CONFIG_PINCTRL_CY8C95X0=m
CONFIG_PINCTRL_EQUILIBRIUM=y
# CONFIG_PINCTRL_MAX77620 is not set
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08_SPI=m
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
CONFIG_PINCTRL_OCELOT=y
CONFIG_PINCTRL_RK805=m
# CONFIG_PINCTRL_SINGLE is not set
CONFIG_PINCTRL_STMFX=m
CONFIG_PINCTRL_SX150X=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=m
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=m
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=y
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LAKEFIELD=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_METEORLAKE=y
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SYSCON=m
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_WCD934X=m
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_CRYSTAL_COVE=y
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_DA9055=m
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_LP87565=y
CONFIG_GPIO_MAX77620=m
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_TC3589X is not set
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL6040=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=y
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=m
# CONFIG_GPIO_XRA1403 is not set
CONFIG_GPIO_MOXTET=m
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_LATCH=m
CONFIG_GPIO_MOCKUP=m
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=m
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2430 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_ATC260X=y
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LTC2952=y
# CONFIG_POWER_RESET_REGULATOR is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_TPS65086=y
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
# CONFIG_SYSCON_REBOOT_MODE is not set
CONFIG_NVMEM_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_CPCAP=m
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9052=y
# CONFIG_AXP20X_POWER is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=m
CONFIG_CHARGER_ISP1704=m
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_MAX77650=m
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_MT6370 is not set
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_BQ25980=m
CONFIG_CHARGER_BQ256XX=m
# CONFIG_CHARGER_RK817 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65217 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=m
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_UG3105=y
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_CPU_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=m
CONFIG_MAX77620_THERMAL=m

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_TI_SOC_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=m
CONFIG_MFD_GATEWORKS_GSC=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=m
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_MFD_HI6421_SPMI=m
CONFIG_HTC_PASIC3=m
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_CHTWC=y
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77714=m
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6360 is not set
CONFIG_MFD_MT6370=m
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_OCELOT=y
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=m
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_SY7636A=m
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=m
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS65219 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=m
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=m
CONFIG_MFD_WCD934X=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_QCOM_PM8008=m
# CONFIG_RAVE_SP_CORE is not set
CONFIG_MFD_INTEL_M10_BMC=m
CONFIG_MFD_RSMU_I2C=y
CONFIG_MFD_RSMU_SPI=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_ATC260X=m
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BD718XX=m
CONFIG_REGULATOR_CPCAP=m
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9055=m
CONFIG_REGULATOR_DA9121=m
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421V600 is not set
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP873X=m
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LP87565 is not set
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8893=m
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8973=m
# CONFIG_REGULATOR_MAX8997 is not set
# CONFIG_REGULATOR_MAX8998 is not set
CONFIG_REGULATOR_MAX20086=m
# CONFIG_REGULATOR_MAX77686 is not set
CONFIG_REGULATOR_MAX77802=y
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MCP16502=m
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=m
# CONFIG_REGULATOR_MP886X is not set
CONFIG_REGULATOR_MPQ7920=y
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6315 is not set
CONFIG_REGULATOR_MT6370=m
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCF50633=y
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_QCOM_USB_VBUS=m
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_ROHM=m
# CONFIG_REGULATOR_RT4801 is not set
# CONFIG_REGULATOR_RT4831 is not set
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5759=y
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6190=m
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=y
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_SLG51000=m
# CONFIG_REGULATOR_STPMIC1 is not set
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=y
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS6286X=y
CONFIG_REGULATOR_TPS65023=m
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=m
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=m
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_QCOM_LABIBB=m
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_N411=m
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
CONFIG_FB_SM501=m
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=m
CONFIG_FB_IBM_GXT4500=m
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_VIRTUAL=m
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=m
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=m
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
# CONFIG_LCD_VGG2432A4 is not set
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_DA9052 is not set
CONFIG_BACKLIGHT_MT6370=m
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_RT4831=m
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_TPS65217=m
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
CONFIG_HID_BETOP_FF=m
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_CORSAIR=m
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=y
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=m
CONFIG_HOLTEK_FF=y
# CONFIG_HID_VIVALDI is not set
CONFIG_HID_GT683R=m
CONFIG_HID_KEYTOUCH=m
# CONFIG_HID_KYE is not set
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=y
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
CONFIG_HID_XIAOMI=m
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=m
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LETSKETCH=m
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=m
CONFIG_HID_MEGAWORLD_FF=m
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PENMOUNT=m
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=m
# CONFIG_PLAYSTATION_FF is not set
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=y
CONFIG_HID_RETRODE=m
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SEMITEK=m
CONFIG_HID_SIGMAMICRO=m
CONFIG_HID_SONY=m
CONFIG_SONY_FF=y
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_TOPRE=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=m
CONFIG_I2C_HID_OF=y
CONFIG_I2C_HID_OF_ELAN=y
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support

CONFIG_I2C_HID_CORE=y

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_PRODUCTLIST=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=m
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
CONFIG_USB_OHCI_HCD_PLATFORM=m
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=m
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_STORAGE_ALAUDA is not set
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
CONFIG_USB_STORAGE_CYPRESS_ATACB=y
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=y

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
CONFIG_USB_CDNS_SUPPORT=m
CONFIG_USB_CDNS_HOST=y
CONFIG_USB_CDNS3=m
CONFIG_USB_CDNS3_GADGET=y
CONFIG_USB_CDNS3_HOST=y
CONFIG_USB_CDNS3_PCI_WRAP=m
# CONFIG_USB_CDNSP_PCI is not set
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_HOST is not set
CONFIG_USB_MUSB_GADGET=y
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=y
# CONFIG_USB_DWC2_PCI is not set
# CONFIG_USB_DWC2_DEBUG is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_CHIPIDEA=y
# CONFIG_USB_CHIPIDEA_UDC is not set
CONFIG_USB_CHIPIDEA_PCI=m
CONFIG_USB_CHIPIDEA_MSM=y
CONFIG_USB_CHIPIDEA_IMX=y
CONFIG_USB_CHIPIDEA_GENERIC=y
CONFIG_USB_CHIPIDEA_TEGRA=y
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_SIMPLE=m
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_IPAQ is not set
CONFIG_USB_SERIAL_IR=m
# CONFIG_USB_SERIAL_EDGEPORT is not set
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_F81232=m
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
# CONFIG_USB_SERIAL_IUU is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=m
# CONFIG_USB_SERIAL_PL2303 is not set
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
# CONFIG_USB_SERIAL_SYMBOL is not set
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
CONFIG_USB_SERIAL_WISHBONE=m
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
CONFIG_USB_SERIAL_XR=m
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=y
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=y
CONFIG_APPLE_MFI_FASTCHARGE=m
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=m
CONFIG_USB_ONBOARD_HUB=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=y
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
# CONFIG_U_SERIAL_CONSOLE is not set

#
# USB Peripheral Controller
#
CONFIG_USB_GR_UDC=m
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
# CONFIG_USB_SNP_UDC_PLAT is not set
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=m
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=m
CONFIG_USB_MAX3420_UDC=m
CONFIG_USB_DUMMY_HCD=m
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_ACM=m
CONFIG_USB_U_SERIAL=y
CONFIG_USB_F_SERIAL=m
CONFIG_USB_F_OBEX=m
CONFIG_USB_F_MASS_STORAGE=m
CONFIG_USB_F_HID=y
# CONFIG_USB_CONFIGFS is not set

#
# USB Gadget precomposed configurations
#
# CONFIG_USB_ZERO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=y
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_MASS_STORAGE=m
CONFIG_USB_G_SERIAL=m
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
CONFIG_USB_G_ACM_MS=m
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=y
CONFIG_USB_G_DBGP=y
# CONFIG_USB_G_DBGP_PRINTK is not set
CONFIG_USB_G_DBGP_SERIAL=y
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=m
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SIMPLE=m
# CONFIG_MMC_BLOCK is not set
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set
# CONFIG_MMC_CRYPTO is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
# CONFIG_MMC_SDHCI_OF_AT91 is not set
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
CONFIG_MMC_SDHCI_CADENCE=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_SDHCI_MILBEAUT is not set
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_SPI=m
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_CQHCI=m
CONFIG_MMC_HSQ=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MMC_SDHCI_OMAP=m
CONFIG_MMC_SDHCI_AM654=m
CONFIG_MMC_SDHCI_EXTERNAL_DMA=y
CONFIG_MMC_LITEX=y
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_CLASS_MULTICOLOR=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AN30259A=m
CONFIG_LEDS_APU=m
CONFIG_LEDS_AW2013=y
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_CPCAP=m
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_EL15203000=y
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=m
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP50XX=m
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=m
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=m
# CONFIG_LEDS_PCA955X_GPIO is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=m
CONFIG_LEDS_REGULATOR=m
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX77650=y
# CONFIG_LEDS_MAX8997 is not set
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=m
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=y
CONFIG_LEDS_SPI_BYTE=y
CONFIG_LEDS_TI_LMU_COMMON=m
CONFIG_LEDS_LM3697=m
CONFIG_LEDS_LM36274=m
# CONFIG_LEDS_TPS6105X is not set
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_LEDS_TRIGGER_TTY=y

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
# CONFIG_RTC_INTF_PROC is not set
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=m
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=m
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_HYM8563 is not set
CONFIG_RTC_DRV_LP8788=m
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_MAX8998=m
# CONFIG_RTC_DRV_MAX8997 is not set
# CONFIG_RTC_DRV_MAX77686 is not set
# CONFIG_RTC_DRV_NCT3018Y is not set
CONFIG_RTC_DRV_RK808=m
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_ISL12026=m
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=m
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=y
# CONFIG_RTC_DRV_TPS65910 is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV3032=y
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
CONFIG_RTC_DRV_M41T94=m
CONFIG_RTC_DRV_DS1302=m
# CONFIG_RTC_DRV_DS1305 is not set
CONFIG_RTC_DRV_DS1343=m
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=m
CONFIG_RTC_DRV_MAX6916=y
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
CONFIG_RTC_DRV_MAX6902=m
# CONFIG_RTC_DRV_PCF2123 is not set
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
CONFIG_RTC_DRV_DS1689=y
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9052 is not set
CONFIG_RTC_DRV_DA9055=y
# CONFIG_RTC_DRV_STK17TA8 is not set
CONFIG_RTC_DRV_M48T86=m
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=m
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=m
CONFIG_RTC_DRV_PCF50633=y
CONFIG_RTC_DRV_ZYNQMP=m

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=m
CONFIG_RTC_DRV_FTRTC010=m
CONFIG_RTC_DRV_MC13XXX=m
# CONFIG_RTC_DRV_R7301 is not set
CONFIG_RTC_DRV_CPCAP=m

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_DW_AXI_DMAC=m
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=y
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_PLX_DMA is not set
CONFIG_XILINX_ZYNQMP_DPDMA=y
# CONFIG_AMD_PTDMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=m
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_VFIO_MDEV=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_COMEDI=m
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=m
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
# CONFIG_COMEDI_DAS08_CS is not set
CONFIG_COMEDI_NI_DAQ_700_CS=m
CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
CONFIG_COMEDI_NI_LABPC_CS=m
CONFIG_COMEDI_NI_MIO_CS=m
CONFIG_COMEDI_QUATECH_DAQP_CS=m
CONFIG_COMEDI_USB_DRIVERS=m
CONFIG_COMEDI_DT9812=m
CONFIG_COMEDI_NI_USB6501=m
CONFIG_COMEDI_USBDUX=m
CONFIG_COMEDI_USBDUXFAST=m
# CONFIG_COMEDI_USBDUXSIGMA is not set
CONFIG_COMEDI_VMK80XX=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=y
CONFIG_ADIS16240=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7816=m
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
# CONFIG_ADT7316_SPI is not set
CONFIG_ADT7316_I2C=y
# end of Analog digital bi-direction converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=y
CONFIG_AD9834=m
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
CONFIG_STAGING_MEDIA=y
CONFIG_STAGING_BOARD=y
# CONFIG_LTE_GDM724X is not set
# CONFIG_FB_TFT is not set
CONFIG_MOST_COMPONENTS=m
# CONFIG_MOST_NET is not set
CONFIG_MOST_DIM2=m
CONFIG_MOST_I2C=m
# CONFIG_KS7010 is not set
CONFIG_GREYBUS_BOOTROM=m
CONFIG_GREYBUS_FIRMWARE=m
# CONFIG_GREYBUS_HID is not set
# CONFIG_GREYBUS_LIGHT is not set
# CONFIG_GREYBUS_LOG is not set
# CONFIG_GREYBUS_LOOPBACK is not set
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=y
# CONFIG_GREYBUS_VIBRATOR is not set
CONFIG_GREYBUS_BRIDGED_PHY=y
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=y
# CONFIG_GREYBUS_SDIO is not set
CONFIG_GREYBUS_SPI=m
CONFIG_GREYBUS_UART=m
CONFIG_GREYBUS_USB=y
CONFIG_PI433=m
# CONFIG_XIL_AXIS_FIFO is not set
CONFIG_FIELDBUS_DEV=m
# CONFIG_HMS_ANYBUSS_BUS is not set
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_SURFACE_PLATFORMS is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
# CONFIG_P2SB is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_LMK04832=m
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=m
CONFIG_COMMON_CLK_RK808=m
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=m
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_CLK_TWL6040=m
CONFIG_COMMON_CLK_AXI_CLKGEN=m
CONFIG_COMMON_CLK_RS9_PCIE=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_VC7=m
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_LGM_CGU=y
# CONFIG_XILINX_VCU is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=m
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_IOMMUFD=m
CONFIG_VIRTIO_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=m
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_FSA9480=y
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_INTEL_CHT_WC=m
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=m
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
CONFIG_ADIS16201=y
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL313_SPI is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
# CONFIG_ADXL345_SPI is not set
CONFIG_ADXL355=m
CONFIG_ADXL355_I2C=m
# CONFIG_ADXL355_SPI is not set
CONFIG_ADXL367=m
CONFIG_ADXL367_SPI=m
# CONFIG_ADXL367_I2C is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=m
CONFIG_BMA220=m
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
CONFIG_BMI088_ACCEL=y
CONFIG_BMI088_ACCEL_SPI=y
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
CONFIG_FXLS8962AF_SPI=y
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
# CONFIG_IIO_KX022A_SPI is not set
# CONFIG_IIO_KX022A_I2C is not set
CONFIG_KXSD9=y
CONFIG_KXSD9_SPI=y
# CONFIG_KXSD9_I2C is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
CONFIG_MSA311=m
CONFIG_MXC4005=y
CONFIG_MXC6255=m
CONFIG_SCA3000=m
CONFIG_SCA3300=y
CONFIG_STK8312=m
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
# CONFIG_AD4130 is not set
CONFIG_AD7091R5=m
CONFIG_AD7124=m
CONFIG_AD7192=m
# CONFIG_AD7266 is not set
CONFIG_AD7280=y
# CONFIG_AD7291 is not set
CONFIG_AD7292=y
# CONFIG_AD7298 is not set
CONFIG_AD7476=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
CONFIG_AD7766=y
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
CONFIG_AD7793=y
CONFIG_AD7887=y
CONFIG_AD7923=m
# CONFIG_AD7949 is not set
CONFIG_AD799X=m
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=m
CONFIG_CC10001_ADC=m
# CONFIG_CPCAP_ADC is not set
# CONFIG_DLN2_ADC is not set
CONFIG_ENVELOPE_DETECTOR=m
CONFIG_HI8435=y
CONFIG_HX711=y
CONFIG_INA2XX_ADC=m
# CONFIG_LP8788_ADC is not set
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=m
CONFIG_LTC2496=y
CONFIG_LTC2497=m
CONFIG_MAX1027=y
CONFIG_MAX11100=m
CONFIG_MAX1118=m
CONFIG_MAX11205=y
# CONFIG_MAX11410 is not set
CONFIG_MAX1241=m
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=m
# CONFIG_MCP3422 is not set
CONFIG_MCP3911=m
# CONFIG_MEDIATEK_MT6370_ADC is not set
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=y
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_SPMI_IADC=m
CONFIG_QCOM_SPMI_VADC=m
CONFIG_QCOM_SPMI_ADC5=m
CONFIG_RICHTEK_RTQ6056=y
# CONFIG_SD_ADC_MODULATOR is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
CONFIG_TI_ADC108S102=y
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=m
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS7950=m
# CONFIG_TI_ADS8344 is not set
# CONFIG_TI_ADS8688 is not set
# CONFIG_TI_ADS124S08 is not set
# CONFIG_TI_ADS131E08 is not set
CONFIG_TI_TLC4541=y
CONFIG_TI_TSC2046=m
CONFIG_VF610_ADC=y
CONFIG_VIPERBOARD_ADC=y
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_AD74115 is not set
# CONFIG_AD74413R is not set
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# CONFIG_ADA4250 is not set
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
CONFIG_AD7746=m
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_ATLAS_EZO_SENSOR=m
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_BME680_SPI=m
CONFIG_CCS811=m
# CONFIG_IAQCORE is not set
CONFIG_PMS7003=m
CONFIG_SCD30_CORE=y
CONFIG_SCD30_I2C=m
CONFIG_SCD30_SERIAL=m
CONFIG_SCD4X=m
# CONFIG_SENSIRION_SGP30 is not set
CONFIG_SENSIRION_SGP40=m
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
CONFIG_SPS30_SERIAL=m
CONFIG_SENSEAIR_SUNRISE_CO2=y
CONFIG_VZ89X=m
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORS_COMMONS is not set
CONFIG_IIO_SSP_SENSORHUB=m
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
# CONFIG_AD3552R is not set
# CONFIG_AD5064 is not set
CONFIG_AD5360=m
CONFIG_AD5380=y
CONFIG_AD5421=m
# CONFIG_AD5446 is not set
CONFIG_AD5449=m
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
CONFIG_AD5624R_SPI=m
CONFIG_LTC2688=y
CONFIG_AD5686=m
# CONFIG_AD5686_SPI is not set
CONFIG_AD5696_I2C=m
CONFIG_AD5755=m
CONFIG_AD5758=m
CONFIG_AD5761=m
CONFIG_AD5764=y
# CONFIG_AD5766 is not set
CONFIG_AD5770R=m
CONFIG_AD5791=m
CONFIG_AD7293=m
CONFIG_AD7303=m
CONFIG_AD8801=m
CONFIG_DPOT_DAC=m
# CONFIG_DS4424 is not set
CONFIG_LTC1660=m
CONFIG_LTC2632=m
# CONFIG_M62332 is not set
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=m
CONFIG_TI_DAC7311=m
# CONFIG_TI_DAC7612 is not set
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Filters
#
# CONFIG_ADMV8818 is not set
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
CONFIG_ADF4371=y
# CONFIG_ADF4377 is not set
CONFIG_ADMV1013=m
# CONFIG_ADMV1014 is not set
# CONFIG_ADMV4420 is not set
# CONFIG_ADRF6780 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
CONFIG_ADXRS290=m
CONFIG_ADXRS450=y
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=m
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
# CONFIG_HDC100X is not set
CONFIG_HDC2010=m
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
CONFIG_HTU21=y
CONFIG_SI7005=m
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
# CONFIG_ADIS16460 is not set
CONFIG_ADIS16475=y
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=y
CONFIG_BMI160_I2C=m
CONFIG_BMI160_SPI=y
# CONFIG_BOSCH_BNO055_SERIAL is not set
# CONFIG_BOSCH_BNO055_I2C is not set
CONFIG_FXOS8700=m
CONFIG_FXOS8700_I2C=m
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
# CONFIG_INV_ICM42600_SPI is not set
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
CONFIG_IIO_ST_LSM9DS0=m
CONFIG_IIO_ST_LSM9DS0_I2C=m
CONFIG_IIO_ST_LSM9DS0_SPI=m
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=m
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=m
# CONFIG_AL3010 is not set
CONFIG_AL3320A=m
CONFIG_APDS9300=y
CONFIG_APDS9960=m
# CONFIG_AS73211 is not set
CONFIG_BH1750=y
CONFIG_BH1780=m
# CONFIG_CM32181 is not set
CONFIG_CM3232=m
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=y
CONFIG_IQS621_ALS=m
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=m
CONFIG_RPR0521=m
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=m
CONFIG_LTRF216A=m
CONFIG_LV0104CS=y
# CONFIG_MAX44000 is not set
CONFIG_MAX44009=y
CONFIG_NOA1305=m
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
CONFIG_SI1145=m
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
CONFIG_TCS3472=m
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
CONFIG_TSL2591=y
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
CONFIG_VCNL4035=m
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_BMC150_MAGN_SPI=y
CONFIG_MAG3110=m
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
CONFIG_SENSORS_RM3100=m
# CONFIG_SENSORS_RM3100_I2C is not set
CONFIG_SENSORS_RM3100_SPI=m
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# CONFIG_IQS624_POS is not set
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
CONFIG_MAX5432=y
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=m
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
CONFIG_MCP41010=m
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
CONFIG_DLHL60D=y
# CONFIG_DPS310 is not set
CONFIG_HP03=m
CONFIG_ICP10100=m
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
# CONFIG_IIO_ST_PRESS_SPI is not set
# CONFIG_T5403 is not set
CONFIG_HP206C=m
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=m
CONFIG_PING=m
CONFIG_RFD77402=y
CONFIG_SRF04=m
CONFIG_SX_COMMON=y
CONFIG_SX9310=m
CONFIG_SX9324=y
CONFIG_SX9360=m
CONFIG_SX9500=m
CONFIG_SRF08=m
CONFIG_VCNL3020=m
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=m
CONFIG_LTC2983=m
CONFIG_MAXIM_THERMOCOUPLE=m
# CONFIG_MLX90614 is not set
CONFIG_MLX90632=m
CONFIG_TMP006=m
CONFIG_TMP007=y
CONFIG_TMP117=m
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX30208 is not set
CONFIG_MAX31856=m
CONFIG_MAX31865=m
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_XILINX_INTC=y
# end of IRQ chip support

CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=m
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=m
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_DPHY_RX=y
CONFIG_PHY_CADENCE_SIERRA=y
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_LAN966X_SERDES=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=m
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=m
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_TUSB1210=m
CONFIG_PHY_INTEL_LGM_COMBO=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_SPMI_SDAM=m
CONFIG_NVMEM_U_BOOT_ENV=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=m
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=m
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_MGR_ICE40_SPI=m
CONFIG_FPGA_MGR_MACHXO2_SPI=y
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
# CONFIG_XILINX_PR_DECOUPLER is not set
# CONFIG_FPGA_REGION is not set
# CONFIG_FPGA_DFL is not set
CONFIG_FPGA_M10_BMC_SEC_UPDATE=m
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
# CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI is not set
CONFIG_FSI=m
# CONFIG_FSI_NEW_DEV_NODE is not set
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=m
# CONFIG_FSI_MASTER_ASPEED is not set
# CONFIG_FSI_SCOM is not set
# CONFIG_FSI_SBEFIFO is not set
CONFIG_TEE=m
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=m
CONFIG_MUX_MMIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
CONFIG_MOST=m
# CONFIG_MOST_USB_HDM is not set
CONFIG_MOST_CDEV=m
CONFIG_PECI=y
CONFIG_PECI_CPU=m
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=m
# CONFIG_F2FS_STAT_FS is not set
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_F2FS_FS_COMPRESSION=y
# CONFIG_F2FS_FS_LZO is not set
CONFIG_F2FS_FS_LZ4=y
CONFIG_F2FS_FS_LZ4HC=y
CONFIG_F2FS_FS_ZSTD=y
CONFIG_F2FS_IOSTAT=y
CONFIG_F2FS_UNFAIR_RWSEM=y
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_DEBUG=y
CONFIG_CACHEFILES=m
CONFIG_CACHEFILES_DEBUG=y
CONFIG_CACHEFILES_ERROR_INJECTION=y
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=m
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=m
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=m
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=m
CONFIG_TRUSTED_KEYS_TEE=y
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

# CONFIG_RANDSTRUCT_NONE is not set
# CONFIG_RANDSTRUCT_FULL is not set
CONFIG_RANDSTRUCT_PERFORMANCE=y
CONFIG_RANDSTRUCT=y
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=m
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_POLYVAL=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_VMAC=y
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=m
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=m
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_CURVE25519_X86=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=m
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=m
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SM3_AVX_X86_64=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=y
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_RESTRICTED_POOL=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
CONFIG_FONT_MINI_4x6=y
CONFIG_FONT_6x10=y
CONFIG_FONT_10x18=y
CONFIG_FONT_SUN8x16=y
# CONFIG_FONT_SUN12x22 is not set
CONFIG_FONT_TER16x32=y
CONFIG_FONT_6x8=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SHRINKER_DEBUG=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=m
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
CONFIG_SAMPLE_KOBJECT=y
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
CONFIG_SAMPLE_RPMSG_CLIENT=m
CONFIG_SAMPLE_CONFIGFS=m
CONFIG_SAMPLE_VFIO_MDEV_MTTY=m
CONFIG_SAMPLE_VFIO_MDEV_MDPY=m
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
CONFIG_SAMPLE_VFIO_MDEV_MBOCHS=m
CONFIG_SAMPLE_WATCHDOG=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--mfOYB9PSQvRd+oox
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='trinity.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-review/Waiman-Long/sched-Fix-use-after-free-bug-in-dup_user_cpus_ptr/20221231-121414'
	export commit='66f9c1813a72eecafa25492b551bb91b4fad59e1'
	export kconfig='x86_64-randconfig-a011-20221226'
	export repeat_to=6
	export nr_vm=300
	export submit_id='63c19aa7dc96409a8f6b0c32'
	export job_file='/lkp/jobs/scheduled/vm-meta-237/trinity-group-03-300s-debian-11.1-x86_64-20220510.cgz-66f9c1813a72eecafa25492b551bb91b4fad59e1-20230114-39567-spiaaq-3.yaml'
	export id='124e09c5e70c8a2804541f5fc3b4ae6cd0ced6d4'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export compiler='gcc-11'
	export enqueue_time='2023-01-14 01:53:43 +0800'
	export _id='63c19abddc96409a8f6b0c33'
	export _rt='/result/trinity/group-03-300s/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a011-20221226/gcc-11/66f9c1813a72eecafa25492b551bb91b4fad59e1'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/trinity/group-03-300s/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a011-20221226/gcc-11/66f9c1813a72eecafa25492b551bb91b4fad59e1/3'
	export scheduler_version='/lkp/lkp/.src-20230111-092854'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/group-03-300s/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a011-20221226/gcc-11/66f9c1813a72eecafa25492b551bb91b4fad59e1/3
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a011-20221226/gcc-11/66f9c1813a72eecafa25492b551bb91b4fad59e1/vmlinuz-6.2.0-rc1-00030-g66f9c1813a72
branch=linux-review/Waiman-Long/sched-Fix-use-after-free-bug-in-dup_user_cpus_ptr/20221231-121414
job=/lkp/jobs/scheduled/vm-meta-237/trinity-group-03-300s-debian-11.1-x86_64-20220510.cgz-66f9c1813a72eecafa25492b551bb91b4fad59e1-20230114-39567-spiaaq-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a011-20221226
commit=66f9c1813a72eecafa25492b551bb91b4fad59e1
vmalloc=256M initramfs_async=0 page_owner=on
initcall_debug
nmi_watchdog=0
max_uptime=1200
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-randconfig-a011-20221226/gcc-11/66f9c1813a72eecafa25492b551bb91b4fad59e1/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/trinity-x86_64-e63e4843-1_20220913.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export kbuild_queue_analysis=1
	export meta_host='vm-meta-237'
	export kernel='/pkg/linux/x86_64-randconfig-a011-20221226/gcc-11/66f9c1813a72eecafa25492b551bb91b4fad59e1/vmlinuz-6.2.0-rc1-00030-g66f9c1813a72'
	export dequeue_time='2023-01-14 03:32:05 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-237/trinity-group-03-300s-debian-11.1-x86_64-20220510.cgz-66f9c1813a72eecafa25492b551bb91b4fad59e1-20230114-39567-spiaaq-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='group-03' $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--mfOYB9PSQvRd+oox
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--mfOYB9PSQvRd+oox--
