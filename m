Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFEB74E955
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGKIsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGKIsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:48:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0732BF;
        Tue, 11 Jul 2023 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689065304; x=1720601304;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zbQ5JbnrOtPmMdT2dSeYok2DDXzrFt5jD+PxPbo2Nq8=;
  b=LjctyWWgOqwsrRVbGLQVq4wfqPz0SlKC0zrqXJRNMOoi243kqLEhyD20
   jPJZxJAMRQwGNtMLiE88YxsMZn4ONQqUxc8YLgdttMWJ+oxbAUiX4qW+6
   N0KTYHYGaoU2aUnHsGvfTHsx1gdEAAe3j+kzAdGxosztfFEcozduTS4pU
   W17oLsfB0elN0flTxiCJjVOY//mmVCBZYJti7hev2eOkfGi1ki3CP1U/j
   w7bpXOBYpWrD1+vz6HYjAZxm1LzENkNEqlvatT5qRKgNzu7is6u2iW4Ck
   CsY7p0zRvvzaxUvOdHR2sX28mMbM+DmToZEv9gynB3S54smO7HB0AlVTm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="428262367"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="xz'341?scan'341,208,341";a="428262367"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 01:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="865677134"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="xz'341?scan'341,208,341";a="865677134"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2023 01:48:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 01:48:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 01:48:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 01:48:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7pOBnVyMqGFP64hmZY1+E1ft7LCukZGztqHCf/zcBx2Gr5uha5mSGO9aYXFn2b4t0MOpvDtk7EhuBzH//WGUEU6RNkjcI+cO4iQW1G0uBcevCkgfC5XAb4LmwNV0OTHp31I0Lsg8f35tZGR5tjbQSjlVlL+rZcE7gFr/ws9cGxhykRyGtqzqly15RApL08R2JkpXdikGnd4zhV/PWGy4B1iMd0WYG7zxT32Ys8WAR1Gy/7/yL/8IqbAPo+BLOatU2Qa2HkIKExmKK3vXL1lczWkz6R+Yf0LIxUBk4v4JV6Cx9qiWZdfNK4324ucHfwV9+lSB2onsx6GuTQMpRpbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA7zmuppAuv6oTs9wQaKmJT2HvGpM3BbcCcbQMP1iMQ=;
 b=T15yKoisflBAbCG6/o3VoAeYKAA7xlMVLn43QQbF9uELt5bOWUC3hV/IGSa+e3UorjgpVciXX/oELvaC19SGT3cUX+cbzsvXYFdkZoe7ClCfUs7OStYeP+I+C73Tm5iIxDa+aK8lQSe0chBq9zx7fCyW7wuzq9njaR4//SbwFMW05OoIs6yFwuHoLtFaUOTia7BNGwmcHGzThlfCjMBb/VJsU2ZVA+zj0g3FiEHjgx4+Q4yTz2k4qScuOVfPHhILoIbjAs1tpfbmzRlClidsOeOlLxZYthxNMbnpiag+8mZbTATPYfTvhJnbw/5PUbw0LtyAkIdEbiQFz3r64tBEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22)
 by IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 08:48:17 +0000
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::b6b6:4109:345a:2aab]) by SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::b6b6:4109:345a:2aab%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 08:48:17 +0000
Date:   Tue, 11 Jul 2023 16:48:06 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: [linus:master] [rcu/nocb]  7625926086:
 WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_try_bypass
Message-ID: <202307111535.4823c255-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="1dAlrHZTd2tbY/Cm"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:3:18::14) To SJ0PR11MB6792.namprd11.prod.outlook.com
 (2603:10b6:a03:485::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6792:EE_|IA1PR11MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: b869f42e-9b77-4310-4df5-08db81eb91e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgOgtWxEaOoZidIfi8u9Xwd0Lx8eUNGDKl7OaAnHedTiNv1TFxU0jpRoeI5oAb5hZ/e8OuYCeV3NtPjv2W3sfxIaiAUnZIvZ96/87/t6D0NVIbif22jzdoeJqcYYVzkF/VgE5Pip7Sy8qu4I/vS9AEVTRO/EHyoW0YCZFOFE+NyLTSs7hzWVfxNh14rfSRSe8XheonljQJYg/L7wdT0dpAX3e5ElN+iLO42su6R5eQfWlqCgqspaWJzCaYvBRVom1QnMU4AaBN+wPmGRn3vkzEXieAolk/bBMp0zAZBKST3fQnAc1LF7a9uwVdURpLZ1oUn5IkS7qt82zk2KWqkRPRdySe3ir4Y5EMUnb4FeFR0nMWl7PtXCv3QmbUkWphY+qWuiv2D5Mz3IT0rpWGT2Oh3Scud6Tw3MrEoz/hCkWZpSwbewdEfzujQk7for1Z4aw734yVIOaPa1Bio98RR89aU5fllwTNyZMPIWqzKdXVWmt7RYt4XJdq4e77BSo433Lh5gbUDKga+GMqPNH1e7ZPTeDyMtxe9V3iM8zhiNYdzYn7T1RQ3wjgEf/0k5CjxWJsIpmrlyGct8ps2XGTg3Jzr/TgyCn8TmeU+gOL/Ikk41kQStQsqOvjOUrHYKuEX/uqFrvCFoGp6nEr1JrULD6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(186003)(6506007)(6512007)(966005)(2616005)(26005)(1076003)(107886003)(478600001)(83380400001)(41300700001)(4326008)(30864003)(66556008)(5660300002)(2906002)(235185007)(316002)(45080400002)(8936002)(8676002)(6916009)(66946007)(66476007)(6486002)(44144004)(6666004)(36756003)(82960400001)(38100700002)(86362001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rpd5xJlbvw5A9/5fdWG29anvZlLZLf+8d5udyIXxNLg09X4/hxgLpUWr885o?=
 =?us-ascii?Q?UP1/YIAVf0N6x3liz2QGvc2j0W6XaN1eugMOR2uNpg/9+HFryQ/Pl4pEVpph?=
 =?us-ascii?Q?fh2qR+YJFckGHyok8sK9FXeI0Pwbi15Z+/l3jYb03GTfABfABGjI4FxWqZ2D?=
 =?us-ascii?Q?cMLZTeLzEcUkRkMDJy6n+LshgZim1ON9y89fFnG6T85fohRFaf9bVcblKUfv?=
 =?us-ascii?Q?3q19VYkbeLsJKQpSHlv6mOwCUNvUnZnqNWAdjvdCSGhK2yPmocW4kn7J/rSy?=
 =?us-ascii?Q?s9T8DTyi3pWCB+oMx5PeIf/A+QFrb7F1ayz7223tPsBCzVQT4rqYzzjS6+uK?=
 =?us-ascii?Q?tS3pUieWPaTFOu3UyP7A2Zzq+QaYh6zvz1dAAy4paGga8lzcy+F6trYCeQoY?=
 =?us-ascii?Q?+G0Jm8Hw9t2HYVCS9wxjUD79JUQ/IFCn3B4ArP2i6svTjZA1blGkV9TEROCu?=
 =?us-ascii?Q?XkMv+ko0Xhofm0cBMrtllPIjsD2W2ceGBZRMNTXrp1l5l1ev82TV1eSdwGTV?=
 =?us-ascii?Q?CtYldZIIqM9PO3kpQouIP0AfIkJv8gR+PCE+l5cu3yPzizIGyDd74vkVuJfB?=
 =?us-ascii?Q?REwhfiQKqQ/BZnM4/Lws9jNL++is0dLlU9hbddTFzhPz0DRez3dU4oGi+EAP?=
 =?us-ascii?Q?DW7Gmm/BAYb1NIvoojgxKCPUWK+RnyXVn0DgEMc2velaqnMpNcsxLcFzSoX7?=
 =?us-ascii?Q?uLSEvDkPx+DXQg8Ytd7oBal0/71eJjDVNeyfsB0nVj7Fyiv8b/Kjy1rGXmex?=
 =?us-ascii?Q?QmjeXpfBOO6NJ+QBOtPNC5SOUGrsPLWz8HkW9fmFzBZSQwcToWOxuHMdDdAq?=
 =?us-ascii?Q?3WKoYgMqdu4O6Ha0ezd3J5NO7fJsXBceHNNMEcgOD4qf23DD1+PLCFNv25rO?=
 =?us-ascii?Q?F6/Fk3nZz3eO5uvPp8q01VfdJSuup/IgAC9hAXzfC75J3Lrw98ertHXmOTaf?=
 =?us-ascii?Q?1ki2SKoAY4Wt04d3DLmIJRcTnNRcaO6I7XSqQnRLXIlsOEILfcKwnpf9fAM2?=
 =?us-ascii?Q?Ge/SWBiT3tDZL9Xcd15DMnCVit6eRt8OvL9b8ZfruGXgRttX4RnBTQYeKuWK?=
 =?us-ascii?Q?lCnxo2jfS++lHPDcYzu0F+gzX6iDqDrJMMQjwBtUGgU4EnyxjF2i22xKDIlb?=
 =?us-ascii?Q?a8D83f6Zs75Qkc4qCZJAqE+RRp83O8dAwesdBkJt6jPRyzJWn0UrnDGaAYEf?=
 =?us-ascii?Q?uxPTpMWU34bhv+lT3QpwSEuoIqsGwvbOb9aLN+o+TXPtN4/33sYlKMjS51AK?=
 =?us-ascii?Q?tdiHeGtleT3fjCizeVMS393svEJngXXn1WiCG/G0goWiaNg6giE4F2pI+0jb?=
 =?us-ascii?Q?p5pddi4uP6YDjm+sJhrJfjIhQ0GVtUiH8tdSP69QBVFgO7IOaXkDm+XNhFhc?=
 =?us-ascii?Q?qcDM5zaKuWzmghz9t3LKdHq8RPVlu46j9iBj/hDUgy5PWTKjPX+2ufKoO7Ha?=
 =?us-ascii?Q?hozqvy7o/7NIZ6Zieurj/7dMtIroa+Dk/iXcelUiHKMaqnlj3iOIGEWuGFbR?=
 =?us-ascii?Q?SMzbWAEbdZ5SLoAOy6Yhbl/UMJZoHWB86zo75NHqaqe+Z3mgBcr/i5gaN6M9?=
 =?us-ascii?Q?wlNUT9ZysjBGNG0xWX8v+YbXPMLCFvLrlZQKO7B2i3aWIid0eeJq4oHmrmaN?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b869f42e-9b77-4310-4df5-08db81eb91e1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 08:48:17.4797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjmtGvjGbb9iND+Jji5E6dZdOcTe4C4yFsoC0wOgfXGEGUSZBdzuwVuk+xpAN1jPzFXqGz3YsHkagC/AMECszg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7869
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1dAlrHZTd2tbY/Cm
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_try_bypass" on:

commit: 7625926086765123251f765d91fc3a70617d334d ("rcu/nocb: Fix shrinker race against callback enqueuer")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master Linux 6.5-rc1]
[test failed on linux-next/master fe57d0d86f03a8b2afe2869a95477d0ed1824c96]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-00

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace):


the WARNING only happens in a low rate (10 out of 204 runs as below).
but since we never observed the issue on parent, and we also noticed
there is a WARN_ON_ONCE in code change, so just report what we observed
in our tests FYI.

5c83cedbaaad6dfe 7625926086765123251f765d91f
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :202          5%          10:204   dmesg.RIP:rcu_nocb_bypass_lock
           :202          5%          10:204   dmesg.RIP:rcu_nocb_try_bypass
           :202          5%          10:204   dmesg.WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_bypass_lock
           :202          5%          10:204   dmesg.WARNING:at_kernel/rcu/tree_nocb.h:#rcu_nocb_try_bypass


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202307111535.4823c255-oliver.sang@intel.com



[ 315.569574][ T16] WARNING: CPU: 1 PID: 16 at kernel/rcu/tree_nocb.h:124 rcu_nocb_try_bypass (kernel/rcu/tree_nocb.h:124 kernel/rcu/tree_nocb.h:513) 
[  315.569582][   T16] Modules linked in: crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel rapl qemu_fw_cfg intel_agp intel_gtt
[  315.569591][   T16] CPU: 1 PID: 16 Comm: rcuop/0 Not tainted 6.4.0-rc1-00002-g762592608676 #1
[ 315.569594][ T16] RIP: 0010:rcu_nocb_try_bypass (kernel/rcu/tree_nocb.h:124 kernel/rcu/tree_nocb.h:513) 
[ 315.569965][ T49] WARNING: CPU: 0 PID: 49 at kernel/rcu/tree_nocb.h:104 rcu_nocb_bypass_lock (kernel/rcu/tree_nocb.h:104 (discriminator 11)) 
[ 315.570472][ T16] Code: 41 0f b6 34 24 48 8b 54 24 08 e9 23 01 00 00 65 8b 05 32 7b f3 7e 3b 83 90 05 00 00 74 02 0f 0b 8b 83 48 02 00 00 85 c0 74 06 <0f> 0b f3 90 eb f0 48 89 df e8 44 7f ff ff 48 8b 3c 24 4c 8b a3 90
All code
========
   0:	41 0f b6 34 24       	movzbl (%r12),%esi
   5:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
   a:	e9 23 01 00 00       	jmp    0x132
   f:	65 8b 05 32 7b f3 7e 	mov    %gs:0x7ef37b32(%rip),%eax        # 0x7ef37b48
  16:	3b 83 90 05 00 00    	cmp    0x590(%rbx),%eax
  1c:	74 02                	je     0x20
  1e:	0f 0b                	ud2
  20:	8b 83 48 02 00 00    	mov    0x248(%rbx),%eax
  26:	85 c0                	test   %eax,%eax
  28:	74 06                	je     0x30
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	f3 90                	pause
  2e:	eb f0                	jmp    0x20
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 44 7f ff ff       	call   0xffffffffffff7f7c
  38:	48 8b 3c 24          	mov    (%rsp),%rdi
  3c:	4c                   	rex.WR
  3d:	8b                   	.byte 0x8b
  3e:	a3                   	.byte 0xa3
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	f3 90                	pause
   4:	eb f0                	jmp    0xfffffffffffffff6
   6:	48 89 df             	mov    %rbx,%rdi
   9:	e8 44 7f ff ff       	call   0xffffffffffff7f52
   e:	48 8b 3c 24          	mov    (%rsp),%rdi
  12:	4c                   	rex.WR
  13:	8b                   	.byte 0x8b
  14:	a3                   	.byte 0xa3
  15:	90                   	nop
[  315.570981][   T49] Modules linked in: crc32c_intel
[  315.571642][   T16] RSP: 0000:ffffc9000008bd60 EFLAGS: 00010002
[  315.572102][   T49]  polyval_clmulni
[  315.572412][   T16]
[  315.572413][   T16] RAX: 0000000000000001 RBX: ffff88842fd2e9c0 RCX: 0000000000000040
[  315.572911][   T49]  polyval_generic
[  315.573917][   T16] RDX: 0000000100000eb8 RSI: ffff88842fd2ebe0 RDI: ffff88842fd2ea60
[  315.574200][   T49]  ghash_clmulni_intel
[  315.574517][   T16] RBP: 0000000100000eb8 R08: 0000000000000001 R09: 0000000000000001
[  315.574715][   T49]  rapl qemu_fw_cfg
[  315.574841][   T16] R10: 0000000000000000 R11: ffff88817e599608 R12: ffffc9000008bdcf
[  315.575254][   T49]  intel_agp
[  315.575450][   T16] R13: 0000000000000001 R14: 0000000000000002 R15: 0000000000000002
[  315.575863][   T49]  intel_gtt
[  315.576078][   T16] FS:  0000000000000000(0000) GS:ffff88842fd00000(0000) knlGS:0000000000000000
[  315.576491][   T49]
[  315.576694][   T16] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  315.577105][   T49] CPU: 0 PID: 49 Comm: kswapd0 Not tainted 6.4.0-rc1-00002-g762592608676 #1
[  315.577277][   T16] CR2: 00000000f7f6f2e8 CR3: 0000000165fc4000 CR4: 00000000000406a0
[ 315.577689][ T49] RIP: 0010:rcu_nocb_bypass_lock (kernel/rcu/tree_nocb.h:104 (discriminator 11)) 
[  315.577861][   T16] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 315.578340][ T49] Code: 0b 48 8d ab 40 03 00 00 48 89 ef e8 2f 78 af 00 85 c0 75 27 f0 ff 83 48 02 00 00 65 8b 05 85 fb f3 7e 39 83 90 05 00 00 74 02 <0f> 0b 48 89 ef e8 67 76 af 00 f0 ff 8b 48 02 00 00 5b 5d c3 cc 83
All code
========
   0:	0b 48 8d             	or     -0x73(%rax),%ecx
   3:	ab                   	stos   %eax,%es:(%rdi)
   4:	40 03 00             	rex add (%rax),%eax
   7:	00 48 89             	add    %cl,-0x77(%rax)
   a:	ef                   	out    %eax,(%dx)
   b:	e8 2f 78 af 00       	call   0xaf783f
  10:	85 c0                	test   %eax,%eax
  12:	75 27                	jne    0x3b
  14:	f0 ff 83 48 02 00 00 	lock incl 0x248(%rbx)
  1b:	65 8b 05 85 fb f3 7e 	mov    %gs:0x7ef3fb85(%rip),%eax        # 0x7ef3fba7
  22:	39 83 90 05 00 00    	cmp    %eax,0x590(%rbx)
  28:	74 02                	je     0x2c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 89 ef             	mov    %rbp,%rdi
  2f:	e8 67 76 af 00       	call   0xaf769b
  34:	f0 ff 8b 48 02 00 00 	lock decl 0x248(%rbx)
  3b:	5b                   	pop    %rbx
  3c:	5d                   	pop    %rbp
  3d:	c3                   	ret
  3e:	cc                   	int3
  3f:	83                   	.byte 0x83

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 89 ef             	mov    %rbp,%rdi
   5:	e8 67 76 af 00       	call   0xaf7671
   a:	f0 ff 8b 48 02 00 00 	lock decl 0x248(%rbx)
  11:	5b                   	pop    %rbx
  12:	5d                   	pop    %rbp
  13:	c3                   	ret
  14:	cc                   	int3
  15:	83                   	.byte 0x83
[  315.578467][   T16] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  315.578809][   T49] RSP: 0018:ffffc9000019bcb0 EFLAGS: 00010002
[  315.579259][   T16] Call Trace:
[  315.579261][   T16]  <TASK>
[  315.579673][   T49]
[  315.579674][   T49] RAX: 0000000000000000 RBX: ffff88842fd2e9c0 RCX: 0000000000000000
[ 315.579980][ T16] ? find_next_bit (arch/x86/events/core.c:816 arch/x86/events/core.c:965) 
[  315.580390][   T49] RDX: ffff88842fd2ebe0 RSI: ffff88842fd2ebe0 RDI: ffff88842fd2ed00
[ 315.581398][ T16] __call_rcu_common (kernel/rcu/tree.c:2644) 
[  315.581812][   T49] RBP: ffff88842fd2ed00 R08: 0000000000000001 R09: 0000000000000001
[ 315.582136][ T16] slab_free+0x53/0xf7 
[  315.582311][   T49] R10: ffff88842fd2ebe0 R11: 0000000000000001 R12: 0000000000000000
[ 315.582469][ T16] rcu_do_batch (kernel/rcu/tree.c:2117) 
[  315.582594][   T49] R13: 0000000100000eb8 R14: ffffc9000019bd88 R15: 0000000000000202
[ 315.583009][ T16] nocb_cb_wait (kernel/rcu/tree_nocb.h:955) 
[  315.583301][   T49] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[ 315.583716][ T16] ? nocb_cb_wait (kernel/rcu/tree_nocb.h:1003) 
[  315.583975][   T49] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 315.584388][ T16] rcu_nocb_cb_kthread (kernel/rcu/tree_nocb.h:1010 (discriminator 24)) 
[  315.584686][   T49] CR2: 00000000590fb014 CR3: 0000000179d50000 CR4: 00000000000406b0
[ 315.585100][ T16] kthread (kernel/kthread.c:381) 
[  315.585339][   T49] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 315.585752][ T16] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[  315.585990][   T49] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 315.586462][ T16] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  315.586710][   T49] Call Trace:
[  315.586711][   T49]  <TASK>
[  315.587058][   T16]  </TASK>
[ 315.587313][ T49] rcu_nocb_flush_bypass (kernel/rcu/tree_nocb.h:381) 
[  315.587727][   T16] irq event stamp: 38560087
[ 315.587934][ T49] lazy_rcu_shrink_scan (kernel/rcu/tree_nocb.h:1367 (discriminator 6)) 
[ 315.588346][ T16] hardirqs last enabled at (38560086): _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 315.588643][ T49] do_shrink_slab+0x1d0/0x2ea 
[ 315.589056][ T16] hardirqs last disabled at (38560087): __call_rcu_common (kernel/rcu/tree.c:2629 (discriminator 3)) 
[ 315.589292][ T49] shrink_slab+0xa7/0x136 
[ 315.589466][ T16] softirqs last enabled at (38560080): local_bh_enable (include/linux/bottom_half.h:33) 
[ 315.589624][ T49] shrink_node (arch/x86/include/asm/current.h:41 mm/vmscan.c:565 mm/vmscan.c:6503) 
[ 315.589784][ T16] softirqs last disabled at (38560082): local_bh_disable (include/linux/bottom_half.h:20) 
[ 315.590054][ T49] balance_pgdat (mm/vmscan.c:7296 mm/vmscan.c:7477) 
[  315.590296][   T16] ---[ end trace 0000000000000000 ]---
[ 315.590570][ T49] kswapd (mm/vmscan.c:7737) 
[ 315.594237][ T49] ? balance_pgdat (mm/vmscan.c:7670) 
[ 315.594498][ T49] kthread (kernel/kthread.c:381) 
[ 315.594711][ T49] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 315.595014][ T49] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  315.595260][   T49]  </TASK>
[  315.595427][   T49] irq event stamp: 123174
[ 315.595658][ T49] hardirqs last enabled at (123173): raw_spin_rq_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 kernel/sched/sched.h:1378) 
[ 315.596191][ T49] hardirqs last disabled at (123174): lazy_rcu_shrink_scan (kernel/rcu/tree_nocb.h:1366 (discriminator 3)) 
[ 315.596724][ T49] softirqs last enabled at (122534): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:415 kernel/softirq.c:600) 
[ 315.597222][ T49] softirqs last disabled at (122527): __irq_exit_rcu (kernel/softirq.c:445 kernel/softirq.c:650) 
[  315.597720][   T49] ---[ end trace 0000000000000000 ]---
[  315.622775][  T212] [main] kernel became tainted! (512/0) Last seed was 144492271
[  315.622787][  T212]
[  315.624666][  T212] trinity: Detected kernel tainting. Last seed was 144492271
[  315.624673][  T212]
[  315.626388][  T212] [main] 1282601 iterations. [F:915248 S:367378 HI:102957]


To reproduce:

        # build kernel
	cd linux
	cp config-6.4.0-rc1-00002-g762592608676 .config
	make HOSTCC=gcc-12 CC=gcc-12 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-12 CC=gcc-12 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--1dAlrHZTd2tbY/Cm
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc1-00002-g762592608676"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.4.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
# CONFIG_UAPI_HEADER_TEST is not set
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
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
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
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
CONFIG_CONTEXT_TRACKING_USER_FORCE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
# CONFIG_RCU_EXP_KTHREAD is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
CONFIG_RCU_NOCB_CPU_CB_BOOST=y
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
CONFIG_RCU_LAZY=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
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
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
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
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_VSMP is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
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
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
# CONFIG_MTRR is not set
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
# CONFIG_ADDRESS_MASKING is not set
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=59
CONFIG_FUNCTION_PADDING_BYTES=64
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
CONFIG_SLS=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
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
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
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
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
CONFIG_X86_X32_ABI=y
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
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
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
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
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
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
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET is not set
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
# CONFIG_GCC_PLUGINS is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT_64B=y
CONFIG_FUNCTION_ALIGNMENT=64
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_DEBUGFS=y
CONFIG_MODULE_DEBUG=y
CONFIG_MODULE_STATS=y
CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS=y
# CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
CONFIG_MODULE_SIG_FORCE=y
CONFIG_MODULE_SIG_ALL=y
CONFIG_MODULE_SIG_SHA1=y
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha1"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
CONFIG_ACORN_PARTITION_EESOX=y
CONFIG_ACORN_PARTITION_ICS=y
# CONFIG_ACORN_PARTITION_ADFS is not set
CONFIG_ACORN_PARTITION_POWERTEC=y
CONFIG_ACORN_PARTITION_RISCIX=y
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=m
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
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
CONFIG_SLUB_TINY=y
CONFIG_SLAB_MERGE_DEFAULT=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
CONFIG_ZONE_DMA32=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_SECRETMEM is not set
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
# CONFIG_DAMON_PADDR is not set
# CONFIG_DAMON_SYSFS is not set
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
CONFIG_NET_HANDSHAKE=y
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
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

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
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
CONFIG_PCIEASPM_PERFORMANCE=y
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
CONFIG_PCIE_BUS_SAFE=y
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_HOST_COMMON=y
# CONFIG_PCI_HOST_GENERIC is not set
CONFIG_VMD=m
CONFIG_PCIE_MICROCHIP_HOST=y
# CONFIG_PCIE_XILINX is not set

#
# Cadence-based PCIe controllers
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_EP=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
CONFIG_PCI_J721E=y
CONFIG_PCI_J721E_HOST=y
CONFIG_PCI_J721E_EP=y
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_EP=y
CONFIG_PCI_MESON=y
# CONFIG_PCIE_INTEL_GW is not set
CONFIG_PCIE_DW_PLAT=y
# CONFIG_PCIE_DW_PLAT_HOST is not set
CONFIG_PCIE_DW_PLAT_EP=y
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
# CONFIG_PCI_EPF_TEST is not set
CONFIG_PCI_EPF_NTB=y
CONFIG_PCI_EPF_VNTB=m
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_CXL_BUS=y
# CONFIG_CXL_PCI is not set
CONFIG_CXL_ACPI=y
CONFIG_CXL_PMEM=m
CONFIG_CXL_PORT=y
# CONFIG_CXL_REGION is not set
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
# CONFIG_YENTA_RICOH is not set
# CONFIG_YENTA_TI is not set
# CONFIG_YENTA_TOSHIBA is not set
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
# CONFIG_RAPIDIO_TSI721 is not set
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=m
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=m
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# CONFIG_FW_CACHE is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
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

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_FW_CS_DSP=m
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=y
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
CONFIG_MTD_MAP_BANK_WIDTH_16=y
CONFIG_MTD_MAP_BANK_WIDTH_32=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_I4=y
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_OTP=y
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=m
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
CONFIG_MTD_SCB2_FLASH=y
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=m
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=m
CONFIG_MTD_PCMCIA_ANONYMOUS=y
CONFIG_MTD_INTEL_VR_NOR=m
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=m
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
CONFIG_MTD_NAND_CAFE=m
CONFIG_MTD_NAND_MXIC=y
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_PLATFORM is not set
# CONFIG_MTD_NAND_CADENCE is not set
CONFIG_MTD_NAND_ARASAN=y
# CONFIG_MTD_NAND_INTEL_LGM is not set

#
# Misc
#
CONFIG_MTD_SM_COMMON=y
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_RICOH=y
# CONFIG_MTD_NAND_DISKONCHIP is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
CONFIG_MTD_NAND_ECC_MXIC=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
CONFIG_MTD_UBI_BLOCK=y
CONFIG_MTD_HYPERBUS=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_FD_RAWCMD is not set
CONFIG_CDROM=m
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_UBLK=y
CONFIG_BLKDEV_UBLK_LEGACY_OPCODES=y

#
# NVME Support
#
CONFIG_NVME_COMMON=y
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
CONFIG_NVME_AUTH=y
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=m
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SMPRO_ERRMON=y
# CONFIG_SMPRO_MISC is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=m
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=m
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
# CONFIG_HISI_HIKEY_USB is not set
CONFIG_VCPU_STALL_DETECTOR=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
CONFIG_GENWQE=m
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
# CONFIG_ECHO is not set
CONFIG_BCM_VK=y
# CONFIG_BCM_VK_TTY is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=y
CONFIG_MISC_RTSX_USB=y
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
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
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=y
# CONFIG_BLK_DEV_BSG is not set
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=m
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=m
CONFIG_SCSI_DH_EMC=m
# CONFIG_SCSI_DH_ALUA is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
# CONFIG_ATA_FORCE is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_DWC is not set
CONFIG_AHCI_CEVA=m
CONFIG_SATA_INIC162X=y
CONFIG_SATA_ACARD_AHCI=y
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=y
# CONFIG_SATA_QSTOR is not set
CONFIG_SATA_SX4=y
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
CONFIG_PATA_MPIIX=m
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
CONFIG_PATA_PCMCIA=m
# CONFIG_PATA_OF_PLATFORM is not set
CONFIG_PATA_RZ1000=m
CONFIG_PATA_PARPORT=m

#
# Parallel IDE protocol modules
#
CONFIG_PATA_PARPORT_ATEN=m
CONFIG_PATA_PARPORT_BPCK=m
CONFIG_PATA_PARPORT_BPCK6=m
CONFIG_PATA_PARPORT_COMM=m
CONFIG_PATA_PARPORT_DSTR=m
CONFIG_PATA_PARPORT_FIT2=m
CONFIG_PATA_PARPORT_FIT3=m
CONFIG_PATA_PARPORT_EPAT=m
# CONFIG_PATA_PARPORT_EPATC8 is not set
# CONFIG_PATA_PARPORT_EPIA is not set
CONFIG_PATA_PARPORT_FRIQ=m
CONFIG_PATA_PARPORT_FRPW=m
# CONFIG_PATA_PARPORT_KBIC is not set
CONFIG_PATA_PARPORT_KTTI=m
CONFIG_PATA_PARPORT_ON20=m
# CONFIG_PATA_PARPORT_ON26 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_LEGACY is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
CONFIG_SBP_TARGET=m
CONFIG_REMOTE_TARGET=m
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=y
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
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
# CONFIG_NTB_NETDEV is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
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
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
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
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
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
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
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
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
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
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
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
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
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
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
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
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DFL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_LITEUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_IPWIRELESS is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_RPMSG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_SSIF_IPMI_BMC=y
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=m
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_CCTRNG=m
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_NVRAM is not set
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C=y
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=m
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
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
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=m
CONFIG_I2C_MUX_REG=m
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
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
# CONFIG_PPS_CLIENT_PARPORT is not set
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
# CONFIG_PTP_DFL_TOD is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AXP209=m
# CONFIG_PINCTRL_CY8C95X0 is not set
CONFIG_PINCTRL_DA9062=m
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_MICROCHIP_SGPIO=m
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_SINGLE is not set
CONFIG_PINCTRL_STMFX=m
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
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
CONFIG_OF_GPIO_MM_GPIOCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_IDIO_16=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=m
CONFIG_GPIO_DWAPB=m
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=m
CONFIG_GPIO_HLWD=m
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LOGICVC is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_VX855=m
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_FXL6408 is not set
CONFIG_GPIO_GW_PLD=m
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD71815=m
# CONFIG_GPIO_BD71828 is not set
CONFIG_GPIO_DA9052=m
# CONFIG_GPIO_ELKHARTLAKE is not set
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_LP87565=m
CONFIG_GPIO_MADERA=m
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS65218=y
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=m
# CONFIG_GPIO_TQMX86 is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
CONFIG_GPIO_RDC321X=y
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_LATCH=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=m
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=m
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=m
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_MT6323=y
# CONFIG_POWER_RESET_REGULATOR is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_TPS65086 is not set
# CONFIG_POWER_RESET_SYSCON is not set
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
# CONFIG_SYSCON_REBOOT_MODE is not set
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_IP5XXX_POWER=m
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=m
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=m
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
CONFIG_BATTERY_TWL4030_MADC=m
CONFIG_CHARGER_PCF50633=m
CONFIG_BATTERY_RX51=m
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_TWL4030 is not set
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=m
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_DETECTOR_MAX14656=m
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_MAX8997 is not set
CONFIG_CHARGER_MP2629=m
# CONFIG_CHARGER_MT6360 is not set
CONFIG_CHARGER_MT6370=m
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_BQ25980=m
CONFIG_CHARGER_BQ256XX=m
CONFIG_CHARGER_SMB347=m
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_CHARGER_TPS65217 is not set
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=m
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_RT9467 is not set
CONFIG_CHARGER_RT9471=y
CONFIG_CHARGER_UCS1002=m
# CONFIG_CHARGER_BD99954 is not set
CONFIG_RN5T618_POWER=y
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_SMPRO=y
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=y
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_GSC=m
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=m
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC2992=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX127=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX31760=m
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MC34VR500=y
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT6775_I2C=y
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_SENSORS_PECI_CPUTEMP=m
CONFIG_SENSORS_PECI_DIMMTEMP=m
CONFIG_SENSORS_PECI=m
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SBTSI=m
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHT4x=m
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA238=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=m
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set
# CONFIG_SENSORS_INTEL_M10_BMC_HWMON is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
CONFIG_DA9062_THERMAL=m

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_INTEL_TCC_COOLING=m
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_TI_SOC_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
# CONFIG_BD957XMUF_WATCHDOG is not set
CONFIG_DA9052_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENZ069_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=m
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=m
CONFIG_RN5T618_WATCHDOG=m
# CONFIG_TWL4030_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_MAX77620_WATCHDOG=m
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=m
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=y
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=m
CONFIG_EXAR_WDT=m
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
CONFIG_EUROTECH_WDT=m
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=y
# CONFIG_ITCO_VENDOR_SUPPORT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=m
# CONFIG_HPWDT_NMI_DECODING is not set
# CONFIG_KEMPLD_WDT is not set
CONFIG_SC1200_WDT=m
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=m
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=y
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=y

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=m
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_SMPRO=y
CONFIG_MFD_AS3722=m
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
# CONFIG_MFD_MAX597X is not set
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_GATEWORKS_GSC=m
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77714=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6370=y
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_NTXEC is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_SY7636A is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT4831=m
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=m
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=m
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
CONFIG_TPS65010=m
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=m
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS65219=m
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=m
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=m
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD71828=m
CONFIG_MFD_ROHM_BD957XMUF=m
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=m
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_MFD_INTEL_M10_BMC_CORE=m
CONFIG_MFD_INTEL_M10_BMC_PMCI=m
CONFIG_MFD_RSMU_I2C=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_ACT8945A=m
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ARIZONA_LDO1=m
CONFIG_REGULATOR_ARIZONA_MICSUPP=m
CONFIG_REGULATOR_AS3722=m
CONFIG_REGULATOR_AXP20X=m
# CONFIG_REGULATOR_BD71815 is not set
CONFIG_REGULATOR_BD71828=m
# CONFIG_REGULATOR_BD718XX is not set
CONFIG_REGULATOR_BD957XMUF=m
CONFIG_REGULATOR_DA903X=m
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=m
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_HI6421=m
CONFIG_REGULATOR_HI6421V530=m
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=m
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8893 is not set
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8925 is not set
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX20086=m
CONFIG_REGULATOR_MAX20411=m
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MCP16502=m
CONFIG_REGULATOR_MP5416=y
CONFIG_REGULATOR_MP8859=m
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6331=m
CONFIG_REGULATOR_MT6332=y
CONFIG_REGULATOR_MT6357=y
CONFIG_REGULATOR_MT6358=m
CONFIG_REGULATOR_MT6359=m
# CONFIG_REGULATOR_MT6360 is not set
# CONFIG_REGULATOR_MT6370 is not set
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCF50633=y
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
# CONFIG_REGULATOR_RC5T583 is not set
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_ROHM=m
# CONFIG_REGULATOR_RT4801 is not set
CONFIG_REGULATOR_RT4803=y
# CONFIG_REGULATOR_RT4831 is not set
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5739=y
CONFIG_REGULATOR_RT5759=y
CONFIG_REGULATOR_RT6160=m
# CONFIG_REGULATOR_RT6190 is not set
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=m
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SKY81452=y
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_SY8106A is not set
CONFIG_REGULATOR_SY8824X=y
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS6286X=m
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65090=m
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=m
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS65219=m
CONFIG_REGULATOR_TPS6586X=m
CONFIG_REGULATOR_TPS65910=m
# CONFIG_REGULATOR_TPS65912 is not set
# CONFIG_REGULATOR_TWL4030 is not set
# CONFIG_REGULATOR_VCTRL is not set
# CONFIG_REGULATOR_WM831X is not set
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_REGULATOR_WM8994=m
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
# end of Media controller options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_GSPCA=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
# CONFIG_USB_GSPCA_CPIA1 is not set
CONFIG_USB_GSPCA_DTCS033=m
# CONFIG_USB_GSPCA_ETOMS is not set
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
# CONFIG_USB_GSPCA_JL2005BCD is not set
# CONFIG_USB_GSPCA_KINECT is not set
# CONFIG_USB_GSPCA_KONICA is not set
# CONFIG_USB_GSPCA_MARS is not set
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
# CONFIG_USB_GSPCA_OV534 is not set
# CONFIG_USB_GSPCA_OV534_9 is not set
# CONFIG_USB_GSPCA_PAC207 is not set
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
# CONFIG_USB_GSPCA_SN9C20X is not set
# CONFIG_USB_GSPCA_SONIXB is not set
# CONFIG_USB_GSPCA_SONIXJ is not set
CONFIG_USB_GSPCA_SPCA1528=m
# CONFIG_USB_GSPCA_SPCA500 is not set
# CONFIG_USB_GSPCA_SPCA501 is not set
# CONFIG_USB_GSPCA_SPCA505 is not set
# CONFIG_USB_GSPCA_SPCA506 is not set
# CONFIG_USB_GSPCA_SPCA508 is not set
# CONFIG_USB_GSPCA_SPCA561 is not set
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
CONFIG_USB_GSPCA_STK1135=m
# CONFIG_USB_GSPCA_STV0680 is not set
CONFIG_USB_GSPCA_SUNPLUS=m
# CONFIG_USB_GSPCA_T613 is not set
CONFIG_USB_GSPCA_TOPRO=m
CONFIG_USB_GSPCA_TOUPTEK=m
CONFIG_USB_GSPCA_TV8532=m
# CONFIG_USB_GSPCA_VC032X is not set
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
# CONFIG_USB_GL860 is not set
CONFIG_USB_M5602=m
# CONFIG_USB_STV06XX is not set
CONFIG_USB_PWC=y
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
CONFIG_USB_S2255=y
CONFIG_VIDEO_USBTV=m
# CONFIG_USB_VIDEO_CLASS is not set

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_VIDEO_EM28XX is not set

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=y
# CONFIG_USB_HACKRF is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_SOLO6X10 is not set
CONFIG_VIDEO_TW5864=m
CONFIG_VIDEO_TW68=y
# CONFIG_VIDEO_TW686X is not set
CONFIG_VIDEO_ZORAN=y
CONFIG_VIDEO_ZORAN_DC30=y
CONFIG_VIDEO_ZORAN_ZR36060=y
# CONFIG_VIDEO_ZORAN_BUZ is not set
# CONFIG_VIDEO_ZORAN_DC10 is not set
CONFIG_VIDEO_ZORAN_LML33=y
# CONFIG_VIDEO_ZORAN_LML33R10 is not set
# CONFIG_VIDEO_ZORAN_AVS6EYES is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
# CONFIG_MEDIA_PLATFORM_DRIVERS is not set
CONFIG_UVC_COMMON=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
# end of Media drivers

#
# Media ancillary drivers
#

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=m
# CONFIG_VIDEO_AR0521 is not set
CONFIG_VIDEO_HI556=y
# CONFIG_VIDEO_HI846 is not set
CONFIG_VIDEO_HI847=y
CONFIG_VIDEO_IMX208=m
CONFIG_VIDEO_IMX214=y
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX258=m
CONFIG_VIDEO_IMX274=y
CONFIG_VIDEO_IMX290=y
CONFIG_VIDEO_IMX296=m
CONFIG_VIDEO_IMX319=m
CONFIG_VIDEO_IMX334=m
CONFIG_VIDEO_IMX335=y
CONFIG_VIDEO_IMX355=m
# CONFIG_VIDEO_IMX412 is not set
CONFIG_VIDEO_IMX415=y
CONFIG_VIDEO_MAX9271_LIB=y
CONFIG_VIDEO_MT9M001=m
CONFIG_VIDEO_MT9M111=y
CONFIG_VIDEO_MT9P031=m
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_OG01A1B is not set
CONFIG_VIDEO_OV02A10=y
CONFIG_VIDEO_OV08D10=y
CONFIG_VIDEO_OV08X40=m
# CONFIG_VIDEO_OV13858 is not set
CONFIG_VIDEO_OV13B10=y
CONFIG_VIDEO_OV2640=m
# CONFIG_VIDEO_OV2659 is not set
CONFIG_VIDEO_OV2680=y
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
CONFIG_VIDEO_OV4689=m
# CONFIG_VIDEO_OV5640 is not set
# CONFIG_VIDEO_OV5645 is not set
CONFIG_VIDEO_OV5647=m
CONFIG_VIDEO_OV5648=m
# CONFIG_VIDEO_OV5670 is not set
CONFIG_VIDEO_OV5675=m
# CONFIG_VIDEO_OV5693 is not set
CONFIG_VIDEO_OV5695=m
CONFIG_VIDEO_OV6650=m
CONFIG_VIDEO_OV7251=m
# CONFIG_VIDEO_OV7640 is not set
CONFIG_VIDEO_OV7670=y
# CONFIG_VIDEO_OV772X is not set
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_OV8856=m
CONFIG_VIDEO_OV8858=m
CONFIG_VIDEO_OV8865=y
CONFIG_VIDEO_OV9282=y
CONFIG_VIDEO_OV9640=m
CONFIG_VIDEO_OV9650=m
# CONFIG_VIDEO_OV9734 is not set
CONFIG_VIDEO_RDACM20=y
CONFIG_VIDEO_RDACM21=m
CONFIG_VIDEO_RJ54N1=y
# CONFIG_VIDEO_S5K5BAF is not set
CONFIG_VIDEO_S5K6A3=m
CONFIG_VIDEO_ST_VGXY61=y
# CONFIG_VIDEO_ET8EK8 is not set
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
CONFIG_VIDEO_AK7375=y
CONFIG_VIDEO_DW9714=m
CONFIG_VIDEO_DW9768=y
CONFIG_VIDEO_DW9807_VCM=m
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
CONFIG_VIDEO_LM3560=m
CONFIG_VIDEO_LM3646=m
# end of Flash devices

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
CONFIG_VIDEO_TDA1997X=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_TLV320AIC23B=m
CONFIG_VIDEO_TVAUDIO=m
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_WM8739=y
# CONFIG_VIDEO_WM8775 is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=m
CONFIG_VIDEO_ADV7183=y
CONFIG_VIDEO_ADV748X=m
CONFIG_VIDEO_ADV7604=y
CONFIG_VIDEO_ADV7604_CEC=y
# CONFIG_VIDEO_ADV7842 is not set
CONFIG_VIDEO_BT819=y
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_ISL7998X=y
CONFIG_VIDEO_KS0127=m
# CONFIG_VIDEO_MAX9286 is not set
CONFIG_VIDEO_ML86V7667=m
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
CONFIG_VIDEO_TC358743=y
CONFIG_VIDEO_TC358743_CEC=y
CONFIG_VIDEO_TC358746=m
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_TVP5150=m
CONFIG_VIDEO_TVP7002=y
# CONFIG_VIDEO_TW2804 is not set
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=m
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=y
# CONFIG_VIDEO_ADV7343 is not set
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_ADV7511=m
# CONFIG_VIDEO_ADV7511_CEC is not set
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=y
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=y
CONFIG_VIDEO_M52790=y
CONFIG_VIDEO_ST_MIPID02=m
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC0011=m
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
# CONFIG_MEDIA_TUNER_FC2580 is not set
# CONFIG_MEDIA_TUNER_IT913X is not set
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2131 is not set
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MXL301RF=y
# CONFIG_MEDIA_TUNER_MXL5005S is not set
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=y
# CONFIG_MEDIA_TUNER_TUA9001 is not set
# CONFIG_MEDIA_TUNER_XC2028 is not set
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_INTEL=m
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=m
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_KTZ8866=m
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_DA903X is not set
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_MT6370 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_RT4831 is not set
CONFIG_BACKLIGHT_SAHARA=m
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_PANDORA is not set
# CONFIG_BACKLIGHT_SKY81452 is not set
# CONFIG_BACKLIGHT_TPS65217 is not set
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_HDMI=y
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_CTL_INPUT_VALIDATION=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_MTS64=m
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=m
CONFIG_SND_PORTMAN2X4=y
# CONFIG_SND_AC97_POWER_SAVE is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
CONFIG_SND_USB_UA101=m
# CONFIG_SND_USB_USX2Y is not set
CONFIG_SND_USB_CAIAQ=m
# CONFIG_SND_USB_CAIAQ_INPUT is not set
# CONFIG_SND_USB_US122L is not set
CONFIG_SND_USB_6FIRE=m
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
CONFIG_SND_USB_LINE6=y
CONFIG_SND_USB_POD=m
# CONFIG_SND_USB_PODHD is not set
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=y
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=m
CONFIG_SND_PDAUDIOCF=m
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ACPI=y
# CONFIG_SND_SOC_ADI is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
# CONFIG_SND_SOC_AMD_PS is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_MQS=y
CONFIG_SND_SOC_FSL_AUDMIX=y
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
CONFIG_SND_SOC_FSL_ESAI=m
CONFIG_SND_SOC_FSL_MICFIL=y
# CONFIG_SND_SOC_FSL_XCVR is not set
CONFIG_SND_SOC_FSL_UTILS=y
CONFIG_SND_SOC_IMX_AUDMUX=y
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=y
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
CONFIG_SND_SOC_MTK_BTCVSD=m
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

CONFIG_SND_SOC_XILINX_I2S=m
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
CONFIG_SND_SOC_XILINX_SPDIF=m
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_WM_ADSP=m
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1372=y
CONFIG_SND_SOC_ADAU1372_I2C=y
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
CONFIG_SND_SOC_ADAU7118_I2C=y
CONFIG_SND_SOC_AK4118=m
CONFIG_SND_SOC_AK4375=y
# CONFIG_SND_SOC_AK4458 is not set
CONFIG_SND_SOC_AK4554=y
CONFIG_SND_SOC_AK4613=y
CONFIG_SND_SOC_AK4642=y
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
CONFIG_SND_SOC_ALC5623=m
CONFIG_SND_SOC_AW8738=y
CONFIG_SND_SOC_AW88395_LIB=m
CONFIG_SND_SOC_AW88395=m
CONFIG_SND_SOC_BD28623=y
# CONFIG_SND_SOC_BT_SCO is not set
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS35L41_I2C is not set
CONFIG_SND_SOC_CS35L45=m
CONFIG_SND_SOC_CS35L45_I2C=m
CONFIG_SND_SOC_CS35L56=m
CONFIG_SND_SOC_CS35L56_SHARED=m
CONFIG_SND_SOC_CS35L56_I2C=m
CONFIG_SND_SOC_CS42L42_CORE=y
CONFIG_SND_SOC_CS42L42=y
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS42L83=y
CONFIG_SND_SOC_CS4234=y
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=m
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=m
CONFIG_SND_SOC_CS4341=m
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_CX2072X=m
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
CONFIG_SND_SOC_ES7241=m
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8326 is not set
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
# CONFIG_SND_SOC_GTM601 is not set
# CONFIG_SND_SOC_HDA is not set
# CONFIG_SND_SOC_ICS43432 is not set
CONFIG_SND_SOC_INNO_RK3036=y
CONFIG_SND_SOC_MAX98088=m
CONFIG_SND_SOC_MAX98090=y
# CONFIG_SND_SOC_MAX98357A is not set
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX9867=m
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98520 is not set
# CONFIG_SND_SOC_MAX98373_I2C is not set
CONFIG_SND_SOC_MAX98390=m
CONFIG_SND_SOC_MAX98396=m
CONFIG_SND_SOC_MAX9860=y
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
# CONFIG_SND_SOC_PCM1789_I2C is not set
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
# CONFIG_SND_SOC_PCM3060_I2C is not set
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
# CONFIG_SND_SOC_PCM5102A is not set
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
# CONFIG_SND_SOC_RK3328 is not set
# CONFIG_SND_SOC_RT5616 is not set
CONFIG_SND_SOC_RT5631=y
# CONFIG_SND_SOC_RT5640 is not set
# CONFIG_SND_SOC_RT5659 is not set
# CONFIG_SND_SOC_RT9120 is not set
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
CONFIG_SND_SOC_SIMPLE_MUX=y
CONFIG_SND_SOC_SMA1303=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SRC4XXX_I2C=m
CONFIG_SND_SOC_SRC4XXX=m
CONFIG_SND_SOC_SSM2305=m
CONFIG_SND_SOC_SSM2518=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_I2C=y
# CONFIG_SND_SOC_SSM4567 is not set
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS2562=m
CONFIG_SND_SOC_TAS2764=y
CONFIG_SND_SOC_TAS2770=m
CONFIG_SND_SOC_TAS2780=m
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=y
# CONFIG_SND_SOC_TAS5720 is not set
CONFIG_SND_SOC_TAS5805M=m
# CONFIG_SND_SOC_TAS6424 is not set
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TFA989X=y
CONFIG_SND_SOC_TLV320ADC3XXX=y
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
CONFIG_SND_SOC_TLV320AIC31XX=m
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TLV320AIC3X_I2C=m
CONFIG_SND_SOC_TLV320ADCX140=m
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
CONFIG_SND_SOC_UDA1334=y
CONFIG_SND_SOC_WM8510=y
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=m
# CONFIG_SND_SOC_WM8580 is not set
CONFIG_SND_SOC_WM8711=y
CONFIG_SND_SOC_WM8728=y
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8731_I2C=m
CONFIG_SND_SOC_WM8737=y
# CONFIG_SND_SOC_WM8741 is not set
CONFIG_SND_SOC_WM8750=m
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=m
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
CONFIG_SND_SOC_WM8903=m
# CONFIG_SND_SOC_WM8904 is not set
CONFIG_SND_SOC_WM8940=m
# CONFIG_SND_SOC_WM8960 is not set
CONFIG_SND_SOC_WM8961=y
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8974=y
# CONFIG_SND_SOC_WM8978 is not set
CONFIG_SND_SOC_WM8985=m
CONFIG_SND_SOC_MAX9759=m
CONFIG_SND_SOC_MT6351=m
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8315 is not set
CONFIG_SND_SOC_NAU8540=y
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8821 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_TPA6130A2=m
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
CONFIG_SND_AUDIO_GRAPH_CARD=y
CONFIG_SND_AUDIO_GRAPH_CARD2=y
CONFIG_SND_AUDIO_GRAPH_CARD2_CUSTOM_SAMPLE=m
# CONFIG_SND_TEST_COMPONENT is not set
# CONFIG_SND_X86 is not set
# CONFIG_SND_VIRTIO is not set
CONFIG_AC97_BUS=y
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LETSKETCH is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PLAYSTATION is not set
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_TOPRE is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=y
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_ELAN is not set
# CONFIG_I2C_HID_OF_GOODIX is not set

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

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_FEW_INIT_RETRIES=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=y
CONFIG_USB_OTG_FSM=m
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=m
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_HCD_PCI is not set
CONFIG_USB_OHCI_HCD_PLATFORM=m
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_BCMA=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
# CONFIG_REALTEK_AUTOPM is not set
CONFIG_USB_STORAGE_DATAFAB=m
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
CONFIG_USB_CDNS_SUPPORT=m
CONFIG_USB_CDNS_HOST=y
CONFIG_USB_CDNS3=m
# CONFIG_USB_CDNS3_GADGET is not set
CONFIG_USB_CDNS3_HOST=y
CONFIG_USB_CDNS3_PCI_WRAP=m
# CONFIG_USB_CDNSP_PCI is not set
CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
CONFIG_USB_MUSB_GADGET=y
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=m
CONFIG_USB_DWC3_HOST=y
# CONFIG_USB_DWC3_GADGET is not set
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
# CONFIG_USB_DWC3_HAPS is not set
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=y
CONFIG_USB_DWC2_PCI=y
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
CONFIG_USB_ISP1760_GADGET_ROLE=y
# CONFIG_USB_ISP1760_DUAL_ROLE is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_USS720=y
CONFIG_USB_EMI62=m
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=y
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=m
# CONFIG_USB_EZUSB_FX2 is not set
CONFIG_USB_HUB_USB251XB=m
# CONFIG_USB_HSIC_USB3503 is not set
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=m
# CONFIG_USB_ONBOARD_HUB is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_GR_UDC=y
CONFIG_USB_R8A66597=m
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
CONFIG_USB_MV_U3D=y
# CONFIG_USB_SNP_UDC_PLAT is not set
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=m
CONFIG_USB_NET2272_DMA=y
# CONFIG_USB_NET2280 is not set
CONFIG_USB_GOKU=y
CONFIG_USB_EG20T=y
CONFIG_USB_GADGET_XILINX=y
CONFIG_USB_DUMMY_HCD=m
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_AUDIO=y
CONFIG_USB_F_FS=y
CONFIG_USB_F_UAC1=y
CONFIG_USB_F_UAC1_LEGACY=y
CONFIG_USB_F_UAC2=y
CONFIG_USB_F_UVC=y
CONFIG_USB_F_MIDI=y
CONFIG_USB_F_HID=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_F_TCM=m
CONFIG_USB_CONFIGFS=y
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
# CONFIG_USB_CONFIGFS_MASS_STORAGE is not set
CONFIG_USB_CONFIGFS_F_LB_SS=y
CONFIG_USB_CONFIGFS_F_FS=y
CONFIG_USB_CONFIGFS_F_UAC1=y
# CONFIG_USB_CONFIGFS_F_UAC1_LEGACY is not set
CONFIG_USB_CONFIGFS_F_UAC2=y
# CONFIG_USB_CONFIGFS_F_MIDI is not set
CONFIG_USB_CONFIGFS_F_HID=y
CONFIG_USB_CONFIGFS_F_UVC=y
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
CONFIG_USB_CONFIGFS_F_TCM=y

#
# USB Gadget precomposed configurations
#
# CONFIG_USB_ZERO is not set
CONFIG_USB_AUDIO=y
CONFIG_GADGET_UAC1=y
CONFIG_GADGET_UAC1_LEGACY=y
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
CONFIG_USB_FUNCTIONFS=y
# CONFIG_USB_FUNCTIONFS_ETH is not set
# CONFIG_USB_FUNCTIONFS_RNDIS is not set
CONFIG_USB_FUNCTIONFS_GENERIC=y
# CONFIG_USB_MASS_STORAGE is not set
CONFIG_USB_GADGET_TARGET=m
# CONFIG_USB_G_SERIAL is not set
CONFIG_USB_MIDI_GADGET=y
CONFIG_USB_G_PRINTER=y
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=m
# CONFIG_USB_G_DBGP is not set
CONFIG_USB_G_WEBCAM=m
CONFIG_USB_RAW_GADGET=m
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
# CONFIG_TYPEC_UCSI is not set
CONFIG_TYPEC_TPS6598X=m
CONFIG_TYPEC_ANX7411=y
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_HD3SS3220 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=y
CONFIG_TYPEC_MUX_GPIO_SBU=y
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=m
# CONFIG_PWRSEQ_EMMC is not set
CONFIG_PWRSEQ_SIMPLE=m
# CONFIG_MMC_BLOCK is not set
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
CONFIG_MMC_SDHCI_CADENCE=m
CONFIG_MMC_SDHCI_F_SDH30=m
CONFIG_MMC_SDHCI_MILBEAUT=m
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_SDRICOH_CS=m
CONFIG_MMC_CB710=m
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_CQHCI=m
CONFIG_MMC_HSQ=m
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_SDHCI_XENON=m
CONFIG_MMC_SDHCI_OMAP=m
# CONFIG_MMC_SDHCI_AM654 is not set
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=y
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_MEMSTICK_REALTEK_USB=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AN30259A=m
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=m
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_MT6323=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
# CONFIG_LEDS_LP55XX_COMMON is not set
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2606MVV=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX8997=m
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m
CONFIG_LEDS_LGM=m

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#
# CONFIG_LEDS_MT6370_RGB is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=m
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
# CONFIG_KS0108 is not set
CONFIG_IMG_ASCII_LCD=m
CONFIG_LCD2S=m
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=m
CONFIG_UIO=m
CONFIG_UIO_CIF=m
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
CONFIG_UIO_NETX=m
CONFIG_UIO_PRUSS=m
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_DFL is not set
CONFIG_VFIO=y
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=y
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
CONFIG_VFIO_PCI_VGA=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=m
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
# CONFIG_COMEDI_PCMCIA_DRIVERS is not set
# CONFIG_COMEDI_USB_DRIVERS is not set
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=m
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
CONFIG_RTS5208=y

#
# IIO staging drivers
#

#
# Accelerometers
#
# end of Accelerometers

#
# Analog to digital converters
#
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Direct Digital Synthesis
#
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_MOST_COMPONENTS is not set
# CONFIG_KS7010 is not set
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_P2SB=y
# CONFIG_COMMON_CLK is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_DMA_STRICT=y
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
# CONFIG_INTEL_IOMMU is not set
CONFIG_IOMMUFD=y
# CONFIG_IOMMUFD_TEST is not set
# CONFIG_IRQ_REMAP is not set
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_CTRL=y
# CONFIG_RPMSG_NS is not set
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

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

CONFIG_WPCM450_SOC=y

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

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_MAX8997=m
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_TUSB320=y
CONFIG_MEMORY=y
# CONFIG_FPGA_DFL_EMIF is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=y
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
CONFIG_ADXL313=y
CONFIG_ADXL313_I2C=y
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
CONFIG_ADXL355=m
CONFIG_ADXL355_I2C=m
# CONFIG_ADXL367_I2C is not set
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
CONFIG_DA311=m
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=m
CONFIG_DMARD10=m
CONFIG_FXLS8962AF=m
CONFIG_FXLS8962AF_I2C=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
# CONFIG_IIO_ST_ACCEL_I2C_3AXIS is not set
CONFIG_IIO_KX022A=y
CONFIG_IIO_KX022A_I2C=y
CONFIG_KXSD9=y
# CONFIG_KXSD9_I2C is not set
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7660=m
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=m
# CONFIG_MSA311 is not set
CONFIG_MXC4005=m
CONFIG_MXC6255=y
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
CONFIG_AD7291=m
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD799X=m
CONFIG_ADI_AXI_ADC=y
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=m
CONFIG_DA9150_GPADC=y
CONFIG_ENVELOPE_DETECTOR=m
# CONFIG_HX711 is not set
CONFIG_LTC2471=y
CONFIG_LTC2485=m
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP3422=m
# CONFIG_MEDIATEK_MT6360_ADC is not set
# CONFIG_MEDIATEK_MT6370_ADC is not set
CONFIG_MEN_Z188_ADC=y
CONFIG_MP2629_ADC=y
CONFIG_NAU7802=y
CONFIG_RN5T618_ADC=y
CONFIG_RICHTEK_RTQ6056=m
CONFIG_SD_ADC_MODULATOR=m
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_ADS7924=y
CONFIG_TI_ADS1100=y
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=m
# CONFIG_VF610_ADC is not set
CONFIG_VIPERBOARD_ADC=y
CONFIG_XILINX_XADC=m
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_ATLAS_EZO_SENSOR=m
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_CCS811=m
# CONFIG_IAQCORE is not set
# CONFIG_SCD30_CORE is not set
# CONFIG_SCD4X is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SENSIRION_SGP40 is not set
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
CONFIG_SENSEAIR_SUNRISE_CO2=m
CONFIG_VZ89X=y
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
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5380 is not set
CONFIG_AD5446=m
# CONFIG_AD5593R is not set
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
CONFIG_MAX517=y
CONFIG_MAX5821=m
CONFIG_MCP4725=m
CONFIG_TI_DAC5571=m
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
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=m
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=m
CONFIG_HDC100X=m
CONFIG_HDC2010=m
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BOSCH_BNO055=m
CONFIG_BOSCH_BNO055_I2C=m
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
# CONFIG_KMX61 is not set
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM9DS0=m
# CONFIG_IIO_ST_LSM9DS0_I2C is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=y
# CONFIG_AL3010 is not set
CONFIG_AL3320A=y
CONFIG_APDS9300=y
CONFIG_APDS9960=y
CONFIG_AS73211=m
# CONFIG_BH1750 is not set
CONFIG_BH1780=m
CONFIG_CM32181=y
CONFIG_CM3232=y
# CONFIG_CM3323 is not set
CONFIG_CM3605=m
CONFIG_CM36651=m
CONFIG_GP2AP002=m
CONFIG_GP2AP020A00F=y
CONFIG_IQS621_ALS=y
CONFIG_SENSORS_ISL29018=m
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
# CONFIG_JSA1212 is not set
# CONFIG_ROHM_BU27034 is not set
CONFIG_RPR0521=y
# CONFIG_SENSORS_LM3533 is not set
# CONFIG_LTR501 is not set
# CONFIG_LTRF216A is not set
CONFIG_LV0104CS=y
CONFIG_MAX44000=m
CONFIG_MAX44009=y
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=m
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
CONFIG_STK3310=m
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=y
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=m
CONFIG_TSL4531=m
# CONFIG_US5182D is not set
CONFIG_VCNL4000=m
CONFIG_VCNL4035=y
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=m
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_MAG3110 is not set
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
# CONFIG_IIO_ST_MAGN_I2C_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_TI_TMAG5273=y
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
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
CONFIG_AD5272=m
# CONFIG_DS1803 is not set
CONFIG_MAX5432=m
CONFIG_MCP4018=m
CONFIG_MCP4531=m
CONFIG_TPL0102=m
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_DLHL60D=y
CONFIG_DPS310=y
CONFIG_HP03=m
CONFIG_ICP10100=y
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL3115 is not set
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_T5403=y
# CONFIG_HP206C is not set
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=m
CONFIG_PING=m
CONFIG_RFD77402=m
# CONFIG_SRF04 is not set
CONFIG_SX_COMMON=y
CONFIG_SX9310=y
# CONFIG_SX9324 is not set
CONFIG_SX9360=y
CONFIG_SX9500=m
CONFIG_SRF08=y
CONFIG_VCNL3020=y
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=m
# CONFIG_MLX90614 is not set
CONFIG_MLX90632=m
CONFIG_TMP006=y
CONFIG_TMP007=y
# CONFIG_TMP117 is not set
CONFIG_TSYS01=m
CONFIG_TSYS02D=y
CONFIG_MAX30208=m
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
CONFIG_NTB_IDT=m
CONFIG_NTB_INTEL=m
CONFIG_NTB_EPF=m
# CONFIG_NTB_SWITCHTEC is not set
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
CONFIG_MADERA_IRQ=m
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=y
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=m
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_DPHY=m
CONFIG_PHY_CADENCE_DPHY_RX=y
# CONFIG_PHY_CADENCE_SALVO is not set
CONFIG_PHY_PXA_28NM_HSIC=m
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_INTEL_LGM_COMBO=y
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=m
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
# CONFIG_BTT is not set
CONFIG_OF_PMEM=m
CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
CONFIG_NVMEM_LAYOUT_ONIE_TLV=m
# end of Layout Types

CONFIG_NVMEM_RMEM=m
# CONFIG_NVMEM_U_BOOT_ENV is not set

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_BRIDGE=m
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
CONFIG_OF_FPGA_REGION=m
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
# CONFIG_FPGA_DFL_FME_MGR is not set
CONFIG_FPGA_DFL_FME_BRIDGE=m
# CONFIG_FPGA_DFL_FME_REGION is not set
CONFIG_FPGA_DFL_AFU=m
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
CONFIG_FPGA_DFL_PCI=m
# CONFIG_FPGA_M10_BMC_SEC_UPDATE is not set
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_GPIO=y
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
CONFIG_MOST=m
# CONFIG_MOST_USB_HDM is not set
CONFIG_MOST_CDEV=m
# CONFIG_MOST_SND is not set
CONFIG_PECI=m
CONFIG_PECI_CPU=m
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
CONFIG_GFS2_FS=m
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y
CONFIG_NTFS3_FS=y
# CONFIG_NTFS3_64BIT_CLUSTER is not set
# CONFIG_NTFS3_LZX_XPRESS is not set
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ADFS_FS=m
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=m
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
# CONFIG_JFFS2_FS is not set
CONFIG_UBIFS_FS=y
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_XATTR=y
# CONFIG_UBIFS_FS_SECURITY is not set
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
CONFIG_SQUASHFS_DECOMP_MULTI=y
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT=y
CONFIG_SQUASHFS_MOUNT_DECOMP_THREADS=y
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=m
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
CONFIG_PSTORE_LZO_COMPRESS=m
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_LZ4HC_COMPRESS=m
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lz4hc"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_RAM is not set
# CONFIG_PSTORE_BLK is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_EROFS_FS=y
CONFIG_EROFS_FS_DEBUG=y
# CONFIG_EROFS_FS_XATTR is not set
# CONFIG_EROFS_FS_ZIP is not set
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
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
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
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=m
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=m
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_KEY_NOTIFICATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_SECURITY_SAFESETID=y
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
# CONFIG_IMA_DEFAULT_HASH_WP512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_APPRAISE_BOOTPARAM is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_DISABLE_HTABLE=y
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ARIA=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=m
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=m
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XCTR=m
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_POLYVAL=m
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_SM3_GENERIC=m
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_VMAC=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
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
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64=m
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=m
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=m
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
CONFIG_CRYPTO_DEV_QAT=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
CONFIG_CRYPTO_DEV_QAT_C62X=y
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
# CONFIG_CRYPTO_DEV_VIRTIO is not set
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_CRYPTO_DEV_CCREE=m
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
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
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=m
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_INTERVAL_TREE_SPAN_ITER=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_CMA is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
# CONFIG_SYMBOLIC_ERRNAME is not set
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

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
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
CONFIG_OBJTOOL=y
CONFIG_VMLINUX_MAP=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
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
# CONFIG_KCSAN is not set
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
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
# CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
# CONFIG_PER_VMA_LOCK_STATS is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
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
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y
# CONFIG_DEBUG_PREEMPT is not set

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
CONFIG_CSD_LOCK_WAIT_DEBUG=y
CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_NMI_CHECK_CPU is not set
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
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
# CONFIG_PREEMPT_TRACER is not set
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
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_USER_EVENTS is not set
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
# CONFIG_SAMPLES is not set
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
CONFIG_DEBUG_TLBFLUSH=y
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
CONFIG_PUNIT_ATOM_DEBUG=m
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAULT_INJECTION_USERCOPY=y
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_FUNCTION=y
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_FAULT_INJECTION_CONFIGFS=y
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
# CONFIG_KCOV_ENABLE_COMPARISONS is not set
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--1dAlrHZTd2tbY/Cm
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
	export queue_cmdline_keys=
	export queue='int'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-next/master'
	export commit='7625926086765123251f765d91fc3a70617d334d'
	export kconfig='x86_64-randconfig-r032-20230710'
	export nr_vm=300
	export submit_id='64acf0200b9a931bc8a53ac0'
	export job_file='/lkp/jobs/queued/int/vm-snb/trinity-group-00-5-300s-debian-11.1-i386-20220923.cgz-x86_64-randconfig-r032-20230710-762592608676-20230711-72648-z7hz2l-62.yaml'
	export id='890c8f28d89d94bbb11c7f6ec2ccb0d7714d44e4'
	export queuer_version='/lkp/xsang/.src-20230711-092355'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export nr_groups=5
	export rootfs='debian-11.1-i386-20220923.cgz'
	export compiler='gcc-12'
	export enqueue_time='2023-07-11 14:01:04 +0800'
	export _id='64acf0230b9a931bc8a53afe'
	export _rt='/result/trinity/group-00-5-300s/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-r032-20230710/gcc-12/7625926086765123251f765d91fc3a70617d334d'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export scheduler_version='/lkp/lkp/.src-20230711-121528'
	export arch='i386'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/group-00-5-300s/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-r032-20230710/gcc-12/7625926086765123251f765d91fc3a70617d334d/102
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-r032-20230710/gcc-12/7625926086765123251f765d91fc3a70617d334d/vmlinuz-6.4.0-rc1-00002-g762592608676
branch=linux-next/master
job=/lkp/jobs/scheduled/vm-meta-275/trinity-group-00-5-300s-debian-11.1-i386-20220923.cgz-x86_64-randconfig-r032-20230710-762592608676-20230711-72648-z7hz2l-62.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-r032-20230710
commit=7625926086765123251f765d91fc3a70617d334d
nmi_watchdog=0
vmalloc=256M initramfs_async=0 page_owner=on
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
	export modules_initrd='/pkg/linux/x86_64-randconfig-r032-20230710/gcc-12/7625926086765123251f765d91fc3a70617d334d/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz,/osimage/pkg/debian-11.1-i386-20220923.cgz/trinity-i386-abe9de86-1_20230429.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/jobs/scheduled/vm-meta-275/trinity-group-00-5-300s-debian-11.1-i386-20220923.cgz-x86_64-randconfig-r032-20230710-762592608676-20230711-72648-z7hz2l-62.cgz'
	export kernel='/pkg/linux/x86_64-randconfig-r032-20230710/gcc-12/7625926086765123251f765d91fc3a70617d334d/vmlinuz-6.4.0-rc1-00002-g762592608676'
	export result_root='/result/trinity/group-00-5-300s/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-r032-20230710/gcc-12/7625926086765123251f765d91fc3a70617d334d/102'
	export meta_host='vm-meta-275'

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

	run_setup $LKP_SRC/setup/sanity-check

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='group-00' $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--1dAlrHZTd2tbY/Cm
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--1dAlrHZTd2tbY/Cm
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="trinity"
Content-Transfer-Encoding: quoted-printable

Seeding trinity by 144490431 based on vm-snb/debian-11.1-i386-20220923.cgz/=
x86_64-randconfig-r032-20230710
2023-07-11 06:03:08 chroot --userspec nobody:nogroup / trinity -q -q -l off=
 -s 144490431 -N 999999999 -c alarm -c bind -c brk -c chown -c chroot -c cl=
one -c close -c connect -c creat -c epoll_create -c epoll_wait -c execveat =
-c fcntl -c fremovexattr -c fsmount -c futex -c getcpu -c getcwd -c getegid=
16 -c geteuid -c getresgid -c getresgid16 -c getresuid -c getrusage -c gett=
id -c inotify_init1 -c io_submit -c ioctl -c iopl -c ioprio_get -c kexec_lo=
ad -c link -c listen -c lstat -c mbind -c migrate_pages -c mincore -c mmap =
-c mmap2 -c modify_ldt -c msync -c munlockall -c nanosleep -c openat -c per=
f_event_open -c personality -c pidfd_open -c pkey_mprotect -c pselect6 -c p=
write64 -c pwritev -c recvmmsg -c renameat2 -c rt_sigqueueinfo -c rt_tgsigq=
ueueinfo -c sched_setaffinity -c sched_setparam -c sched_setscheduler -c se=
mctl -c semget -c sendto -c set_tid_address -c setfsgid -c setfsgid16 -c se=
tgroups16 -c setitimer -c setreuid -c setrlimit -c setuid -c shmctl -c shmd=
t -c sigsuspend -c stat64 -c statfs -c symlinkat -c sync -c sysinfo -c tgki=
ll -c timer_create -c timer_delete -c timer_gettime -c unlinkat -c unshare =
-c utimensat -c vhangup -c vm86 -c waitpid
Trinity 2023.01  Dave Jones <davej@codemonkey.org.uk>
shm:0xf7f6a000-0x4716e14 (4 pages)
[main] alarm is marked as AVOID. Skipping
[main] Marking syscall alarm (27) as to be enabled.
[main] Marking syscall bind (361) as to be enabled.
[main] brk is marked as AVOID. Skipping
[main] Marking syscall brk (45) as to be enabled.
[main] Marking syscall chown (182) as to be enabled.
[main] Marking syscall chroot (61) as to be enabled.
[main] clone is marked as AVOID. Skipping
[main] Marking syscall clone (120) as to be enabled.
[main] close is marked as AVOID. Skipping
[main] Marking syscall close (6) as to be enabled.
[main] Marking syscall connect (362) as to be enabled.
[main] Marking syscall creat (8) as to be enabled.
[main] Marking syscall epoll_create (254) as to be enabled.
[main] Marking syscall epoll_wait (256) as to be enabled.
[main] Marking syscall execveat (358) as to be enabled.
[main] Marking syscall fcntl (55) as to be enabled.
[main] Marking syscall fremovexattr (237) as to be enabled.
[main] Marking syscall fsmount (425) as to be enabled.
[main] Marking syscall futex (240) as to be enabled.
[main] Marking syscall getcpu (318) as to be enabled.
[main] Marking syscall getcwd (183) as to be enabled.
[main] Marking syscall getegid16 (50) as to be enabled.
[main] Marking syscall geteuid (201) as to be enabled.
[main] Marking syscall getresgid (211) as to be enabled.
[main] Marking syscall getresgid16 (171) as to be enabled.
[main] Marking syscall getresuid (209) as to be enabled.
[main] Marking syscall getrusage (77) as to be enabled.
[main] Marking syscall gettid (224) as to be enabled.
[main] Marking syscall inotify_init1 (332) as to be enabled.
[main] Marking syscall io_submit (248) as to be enabled.
[main] Marking syscall ioctl (54) as to be enabled.
[main] Marking syscall iopl (110) as to be enabled.
[main] Marking syscall ioprio_get (290) as to be enabled.
[main] Marking syscall kexec_load (283) as to be enabled.
[main] Marking syscall link (9) as to be enabled.
[main] Marking syscall listen (363) as to be enabled.
[main] Marking syscall lstat (84) as to be enabled.
[main] Marking syscall mbind (274) as to be enabled.
[main] Marking syscall migrate_pages (294) as to be enabled.
[main] Marking syscall mincore (218) as to be enabled.
[main] Marking syscall mmap (90) as to be enabled.
[main] Marking syscall mmap2 (192) as to be enabled.
[main] Marking syscall modify_ldt (123) as to be enabled.
[main] Marking syscall msync (144) as to be enabled.
[main] Marking syscall munlockall (153) as to be enabled.
[main] nanosleep is marked as AVOID. Skipping
[main] Marking syscall nanosleep (162) as to be enabled.
[main] Marking syscall openat (295) as to be enabled.
[main] Marking syscall perf_event_open (336) as to be enabled.
[main] Marking syscall personality (136) as to be enabled.
[main] Marking syscall pidfd_open (427) as to be enabled.
[main] Marking syscall pkey_mprotect (380) as to be enabled.
[main] pselect6 is marked as AVOID. Skipping
[main] Marking syscall pselect6 (308) as to be enabled.
[main] Marking syscall pwrite64 (181) as to be enabled.
[main] Marking syscall pwritev (334) as to be enabled.
[main] Marking syscall recvmmsg (337) as to be enabled.
[main] Marking syscall renameat2 (353) as to be enabled.
[main] rt_sigqueueinfo is marked as AVOID. Skipping
[main] Marking syscall rt_sigqueueinfo (178) as to be enabled.
[main] Marking syscall rt_tgsigqueueinfo (335) as to be enabled.
[main] Marking syscall sched_setaffinity (241) as to be enabled.
[main] Marking syscall sched_setparam (154) as to be enabled.
[main] Marking syscall sched_setscheduler (156) as to be enabled.
[main] Marking syscall semctl (388) as to be enabled.
[main] Marking syscall semget (387) as to be enabled.
[main] Marking syscall sendto (369) as to be enabled.
[main] set_tid_address is marked as AVOID. Skipping
[main] Marking syscall set_tid_address (258) as to be enabled.
[main] Marking syscall setfsgid (216) as to be enabled.
[main] Marking syscall setfsgid16 (139) as to be enabled.
[main] Marking syscall setgroups16 (81) as to be enabled.
[main] setitimer is marked as AVOID. Skipping
[main] Marking syscall setitimer (104) as to be enabled.
[main] Marking syscall setreuid (203) as to be enabled.
[main] Marking syscall setrlimit (75) as to be enabled.
[main] Marking syscall setuid (213) as to be enabled.
[main] Marking syscall shmctl (390) as to be enabled.
[main] Marking syscall shmdt (392) as to be enabled.
[main] sigsuspend is marked as AVOID. Skipping
[main] Marking syscall sigsuspend (72) as to be enabled.
[main] Marking syscall stat64 (195) as to be enabled.
[main] Marking syscall statfs (18) as to be enabled.
[main] Marking syscall symlinkat (304) as to be enabled.
[main] Marking syscall sync (36) as to be enabled.
[main] Marking syscall sysinfo (116) as to be enabled.
[main] tgkill is marked as AVOID. Skipping
[main] Marking syscall tgkill (270) as to be enabled.
[main] Marking syscall timer_create (259) as to be enabled.
[main] Marking syscall timer_delete (263) as to be enabled.
[main] Marking syscall timer_gettime (261) as to be enabled.
[main] Marking syscall unlinkat (301) as to be enabled.
[main] Marking syscall unshare (310) as to be enabled.
[main] Marking syscall utimensat (320) as to be enabled.
[main] vhangup is marked as AVOID. Skipping
[main] Marking syscall vhangup (111) as to be enabled.
[main] Marking syscall vm86 (166) as to be enabled.
[main] Marking syscall waitpid (7) as to be enabled.
[main] Couldn't chmod tmp/ to 0777.
[main] Using user passed random seed: 144490431.
[main] Enabled 87 syscalls. Disabled 342 syscalls.
[main] Using pid_max =3D 32768
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] futex: 0 owner:0 global:1
[main] Reserved/initialized 10 futexes.
[main] Added 17 filenames from /dev
[main] Added 21335 filenames from /proc
[main] Added 10151 filenames from /sys
[main] Couldn't open socket (20:2:0). Address family not supported by proto=
col
[main] Couldn't open socket (29:2:2). Address family not supported by proto=
col
Can't do protocol KEY
[main] Couldn't open socket (24:1:0). Address family not supported by proto=
col
Can't do protocol SECURITY
[main] Couldn't open socket (35:5:2). Address family not supported by proto=
col
[main] Couldn't open socket (44:3:0). Address family not supported by proto=
col
Can't do protocol BRIDGE
[main] Couldn't open socket (27:3:4). Address family not supported by proto=
col
[main] Couldn't open socket (37:1:5). Address family not supported by proto=
col
[main] Couldn't open socket (43:1:1). Address family not supported by proto=
col
[main] Couldn't open socket (37:5:1). Address family not supported by proto=
col
[main] Couldn't open socket (9:5:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (32:5:4). Address family not supported by proto=
col
[main] Couldn't open socket (28:5:4). Address family not supported by proto=
col
[main] Couldn't open socket (29:3:1). Address family not supported by proto=
col
[main] Couldn't open socket (20:2:0). Address family not supported by proto=
col
Can't do protocol LLC
Can't do protocol PACKET
[main] Couldn't open socket (32:2:5). Address family not supported by proto=
col
Can't do protocol ASH
[main] Couldn't open socket (37:5:1). Address family not supported by proto=
col
[main] Couldn't open socket (28:5:1). Address family not supported by proto=
col
[main] Couldn't open socket (3:3:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (39:3:0). Address family not supported by proto=
col
Can't do protocol WANPIPE
[main] Couldn't open socket (38:5:0). Address family not supported by proto=
col
[main] Couldn't open socket (28:5:2). Address family not supported by proto=
col
Can't do protocol NETBEUI
Can't do protocol WANPIPE
[main] Couldn't open socket (3:5:207). Address family not supported by prot=
ocol
Can't do protocol KEY
[main] Couldn't open socket (21:5:0). Address family not supported by proto=
col
[main] Couldn't open socket (24:1:1). Address family not supported by proto=
col
Can't do protocol PACKET
[main] Couldn't open socket (5:2:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (3:3:0). Address family not supported by protoc=
ol
Can't do protocol UNSPEC
[main] Couldn't open socket (37:5:4). Address family not supported by proto=
col
[main] Couldn't open socket (3:5:0). Address family not supported by protoc=
ol
Can't do protocol BRIDGE
[main] Couldn't open socket (37:5:1). Address family not supported by proto=
col
[main] Couldn't open socket (28:5:4). Address family not supported by proto=
col
[main] Couldn't open socket (31:1:0). Address family not supported by proto=
col
[main] Couldn't open socket (9:5:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (11:5:2). Address family not supported by proto=
col
Can't do protocol UNSPEC
[main] Couldn't open socket (16:3:6). Protocol not supported
[main] Couldn't open socket (2:5:132). Socket type not supported
[main] Couldn't open socket (21:5:0). Address family not supported by proto=
col
[main] Couldn't open socket (20:2:0). Address family not supported by proto=
col
[main] Couldn't open socket (42:2:0). Address family not supported by proto=
col
[main] Couldn't open socket (43:1:0). Address family not supported by proto=
col
Can't do protocol NETBEUI
[main] Couldn't open socket (41:2:0). Address family not supported by proto=
col
[main] Couldn't open socket (9:5:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (43:1:1). Address family not supported by proto=
col
[main] Couldn't open socket (28:1:3). Address family not supported by proto=
col
[main] Couldn't open socket (8:2:0). Address family not supported by protoc=
ol
Can't do protocol UNSPEC
[main] Couldn't open socket (41:10:0). Address family not supported by prot=
ocol
[main] Couldn't open socket (11:10:6). Address family not supported by prot=
ocol
[main] Couldn't open socket (20:2:0). Address family not supported by proto=
col
[main] Couldn't open socket (41:10:0). Address family not supported by prot=
ocol
[main] Couldn't open socket (3:5:207). Address family not supported by prot=
ocol
Can't do protocol BRIDGE
[main] Couldn't open socket (31:3:7). Address family not supported by proto=
col
Can't do protocol ASH
[main] Couldn't open socket (32:3:6). Address family not supported by proto=
col
Can't do protocol KEY
[main] Couldn't open socket (4:2:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (12:2:10). Address family not supported by prot=
ocol
[main] Couldn't open socket (12:2:4). Address family not supported by proto=
col
[main] Couldn't open socket (33:2:2). Address family not supported by proto=
col
[main] Couldn't open socket (30:5:0). Address family not supported by proto=
col
[main] Couldn't open socket (31:3:3). Address family not supported by proto=
col
[main] Couldn't open socket (37:5:1). Address family not supported by proto=
col
Can't do protocol ASH
[main] Couldn't open socket (21:5:0). Address family not supported by proto=
col
[main] Couldn't open socket (37:5:0). Address family not supported by proto=
col
Can't do protocol SECURITY
[main] Couldn't open socket (21:5:0). Address family not supported by proto=
col
[main] Couldn't open socket (32:5:5). Address family not supported by proto=
col
[main] Couldn't open socket (44:3:0). Address family not supported by proto=
col
Can't do protocol NETBEUI
[main] Couldn't open socket (4:2:0). Address family not supported by protoc=
ol
Can't do protocol ASH
[main] Couldn't open socket (31:3:6). Address family not supported by proto=
col
[main] Couldn't open socket (24:9:2). Address family not supported by proto=
col
[main] Couldn't open socket (23:9:5). Address family not supported by proto=
col
[main] Couldn't open socket (41:2:0). Address family not supported by proto=
col
Can't do protocol BRIDGE
[main] Couldn't open socket (42:2:0). Address family not supported by proto=
col
[main] Couldn't open socket (11:2:2). Address family not supported by proto=
col
[main] Couldn't open socket (36:2:3). Address family not supported by proto=
col
[main] Couldn't open socket (29:2:2). Address family not supported by proto=
col
[main] Couldn't open socket (42:2:0). Address family not supported by proto=
col
[main] Couldn't open socket (43:1:0). Address family not supported by proto=
col
[main] Couldn't open socket (29:2:2). Address family not supported by proto=
col
Can't do protocol KEY
[main] Couldn't open socket (27:2:6). Address family not supported by proto=
col
[main] Couldn't open socket (3:3:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (8:2:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (5:2:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (23:2:2). Address family not supported by proto=
col
[main] Couldn't open socket (21:5:0). Address family not supported by proto=
col
Can't do protocol NETBEUI
Can't do protocol LLC
[main] Couldn't open socket (31:5:2). Address family not supported by proto=
col
Can't do protocol NETBEUI
[main] Couldn't open socket (8:2:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (44:3:0). Address family not supported by proto=
col
Can't do protocol SECURITY
[main] Couldn't open socket (20:2:0). Address family not supported by proto=
col
[main] Couldn't open socket (30:1:0). Address family not supported by proto=
col
Can't do protocol UNSPEC
[main] Couldn't open socket (29:2:2). Address family not supported by proto=
col
[main] Couldn't open socket (44:3:0). Address family not supported by proto=
col
[main] Couldn't open socket (31:3:3). Address family not supported by proto=
col
[main] Couldn't open socket (23:3:2). Address family not supported by proto=
col
[main] Couldn't open socket (11:3:4). Address family not supported by proto=
col
[main] Couldn't open socket (9:5:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (32:5:2). Address family not supported by proto=
col
Can't do protocol WANPIPE
[main] Couldn't open socket (27:5:3). Address family not supported by proto=
col
[main] Couldn't open socket (28:5:4). Address family not supported by proto=
col
Can't do protocol WANPIPE
Can't do protocol WANPIPE
Can't do protocol UNSPEC
[main] Couldn't open socket (16:2:9). Protocol not supported
[main] Couldn't open socket (23:2:2). Address family not supported by proto=
col
[main] Couldn't open socket (16:2:20). Protocol not supported
[main] Couldn't open socket (39:2:1). Address family not supported by proto=
col
[main] Couldn't open socket (5:2:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (21:5:0). Address family not supported by proto=
col
[main] Couldn't open socket (9:5:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (41:2:0). Address family not supported by proto=
col
[main] Couldn't open socket (3:3:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (9:5:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (9:5:0). Address family not supported by protoc=
ol
Can't do protocol SNA
[main] Couldn't open socket (38:5:0). Address family not supported by proto=
col
[main] Couldn't open socket (9:5:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (4:2:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (16:2:22). Protocol not supported
[main] Couldn't open socket (38:5:0). Address family not supported by proto=
col
[main] Couldn't open socket (2:5:132). Socket type not supported
[main] Couldn't open socket (5:3:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (8:2:0). Address family not supported by protoc=
ol
Can't do protocol PACKET
[main] Couldn't open socket (8:2:0). Address family not supported by protoc=
ol
[main] Couldn't open socket (30:1:0). Address family not supported by proto=
col
[main] Couldn't open socket (23:1:6). Address family not supported by proto=
col
[main] Couldn't open socket (40:1:2). Address family not supported by proto=
col
[main] Couldn't open socket (6:5:0). Address family not supported by protoc=
ol
Can't do protocol SNA
[main] Enabled 14/14 fd providers. initialized:14.
[main] Error opening tracing_on : Permission denied
[main] 12352 iterations. [F:8608 S:3750 HI:1919]
[main] 24248 iterations. [F:16946 S:7320 HI:3725]
[main] 34944 iterations. [F:24474 S:10513 HI:4239]
[main] 49076 iterations. [F:34365 S:14763 HI:4946]
[main] 59609 iterations. [F:41842 S:17827 HI:6869]
[main] 70192 iterations. [F:49205 S:21030 HI:8316]
[main] 82007 iterations. [F:57453 S:24610 HI:8475]
[main] 95602 iterations. [F:67017 S:28622 HI:8694]
[main] 105879 iterations. [F:74234 S:31691 HI:8694]
[main] 118483 iterations. [F:83092 S:35437 HI:8694]
[main] 128535 iterations. [F:90167 S:38413 HI:8694]
[main] 143389 iterations. [F:100604 S:42857 HI:8694]
[main] 156191 iterations. [F:109523 S:46744 HI:8694]
[main] 170781 iterations. [F:119817 S:51052 HI:8694]
[main] 182427 iterations. [F:127975 S:54542 HI:8694]
[main] 194116 iterations. [F:136217 S:57987 HI:8694]
[main] 204349 iterations. [F:143478 S:60970 HI:9140]
[main] 216095 iterations. [F:151741 S:64458 HI:11250]
[main] 227569 iterations. [F:159949 S:67718 HI:11997]
[main] 238638 iterations. [F:167859 S:70885 HI:13045]
[main] 252253 iterations. [F:177513 S:74860 HI:14407]
[main] 265284 iterations. [F:186600 S:78825 HI:15944]
[main] 278911 iterations. [F:196217 S:82839 HI:17862]
[main] 289415 iterations. [F:203603 S:85979 HI:19583]
[main] 300327 iterations. [F:211257 S:89232 HI:20591]
[main] 313177 iterations. [F:220353 S:92985 HI:20762]
[main] 323449 iterations. [F:227586 S:96049 HI:21656]
[main] 334553 iterations. [F:235434 S:99298 HI:22533]
[main] 349826 iterations. [F:246231 S:103772 HI:23000]
[main] 360490 iterations. [F:253624 S:107056 HI:23000]
[main] 373863 iterations. [F:262957 S:111089 HI:23000]
[main] 386163 iterations. [F:271616 S:114754 HI:23000]
[main] 396982 iterations. [F:279210 S:117976 HI:23000]
[main] 407541 iterations. [F:286625 S:121124 HI:23000]
[main] 417758 iterations. [F:293751 S:124210 HI:23000]
[main] 428847 iterations. [F:301424 S:127612 HI:23000]
[main] 438903 iterations. [F:308493 S:130593 HI:23000]
[main] 452851 iterations. [F:318437 S:134617 HI:23000]
[main] 464093 iterations. [F:326461 S:137843 HI:23000]
[main] 477986 iterations. [F:336375 S:141826 HI:23000]
[main] 488254 iterations. [F:343701 S:144781 HI:23000]
[main] 499563 iterations. [F:351795 S:147999 HI:23000]
[main] 511217 iterations. [F:360121 S:151333 HI:23000]
[main] 523246 iterations. [F:368732 S:154764 HI:23000]
[main] 536225 iterations. [F:378035 S:158458 HI:23516]
[main] 547860 iterations. [F:386396 S:161722 HI:25453]
[main] 558758 iterations. [F:394223 S:164804 HI:27592]
[main] 570462 iterations. [F:402623 S:168134 HI:29486]
[main] 581473 iterations. [F:410533 S:171258 HI:31316]
[main] 593312 iterations. [F:419032 S:174591 HI:33771]
[main] 604779 iterations. [F:427288 S:177808 HI:34985]
[main] 615393 iterations. [F:434902 S:180817 HI:35641]
[main] 626577 iterations. [F:443011 S:183899 HI:38712]
[main] 637514 iterations. [F:450883 S:186955 HI:39568]
[main] 654151 iterations. [F:462797 S:191685 HI:41213]
[main] 664395 iterations. [F:470211 S:194506 HI:41753]
[main] 674516 iterations. [F:477496 S:197314 HI:42675]
[main] 685139 iterations. [F:485065 S:200350 HI:43853]
[main] 698877 iterations. [F:494873 S:204275 HI:45396]
[main] 714194 iterations. [F:505925 S:208549 HI:45676]
[main] 724551 iterations. [F:513376 S:211455 HI:47068]
[main] 735735 iterations. [F:521366 S:214620 HI:47968]
[main] 748298 iterations. [F:530369 S:218178 HI:49144]
[main] 759625 iterations. [F:538569 S:221316 HI:51138]
[main] 772021 iterations. [F:547503 S:224776 HI:52267]
[main] 782434 iterations. [F:555065 S:227620 HI:53245]
[main] 793909 iterations. [F:563386 S:230761 HI:54217]
[main] 807374 iterations. [F:573139 S:234439 HI:55527]
[main] 817951 iterations. [F:580722 S:237434 HI:56527]
[main] 829998 iterations. [F:589447 S:240751 HI:57803]
[main] 845387 iterations. [F:600558 S:245062 HI:59049]
[main] 859134 iterations. [F:610498 S:248855 HI:59486]
[main] 872015 iterations. [F:619648 S:252563 HI:60991]
[main] 885278 iterations. [F:629344 S:256085 HI:65227]
[main] 897365 iterations. [F:638021 S:259506 HI:65744]
[main] 908370 iterations. [F:645844 S:262687 HI:66931]
[main] 921211 iterations. [F:655036 S:266323 HI:68142]
[main] 931493 iterations. [F:662472 S:269166 HI:70745]
[main] 945621 iterations. [F:672648 S:273114 HI:71325]
[main] 959203 iterations. [F:682505 S:276819 HI:72753]
[main] 970528 iterations. [F:690651 S:280009 HI:73477]
[main] 984613 iterations. [F:700713 S:284043 HI:75422]
[main] 999093 iterations. [F:711050 S:288192 HI:75950]
[main] 1012983 iterations. [F:721098 S:292041 HI:77636]
[main] 1024266 iterations. [F:729214 S:295184 HI:79175]
[main] 1035036 iterations. [F:736933 S:298250 HI:79783]
[main] 1047620 iterations. [F:745935 S:301828 HI:80404]
[main] 1058503 iterations. [F:753700 S:304954 HI:81191]
[main] 1072372 iterations. [F:763673 S:308833 HI:82650]
[main] 1084804 iterations. [F:772590 S:312339 HI:83060]
[main] 1098479 iterations. [F:782442 S:316142 HI:84433]
[main] 1109686 iterations. [F:790588 S:319188 HI:84806]
[main] 1122339 iterations. [F:799638 S:322806 HI:85616]
[main] 1133509 iterations. [F:807778 S:325826 HI:88366]
[main] 1146134 iterations. [F:816905 S:329326 HI:89748]
[main] 1156719 iterations. [F:824574 S:332219 HI:90053]
[main] 1168807 iterations. [F:833339 S:335530 HI:91373]
[main] 1183379 iterations. [F:843806 S:339646 HI:92945]
[main] 1193899 iterations. [F:851383 S:342592 HI:93312]
[main] 1209090 iterations. [F:862302 S:346861 HI:94661]
[main] 1222904 iterations. [F:872205 S:350771 HI:96249]
[main] 1238101 iterations. [F:883167 S:355002 HI:98586]
[main] 1248949 iterations. [F:890874 S:358117 HI:99938]
[main] 1259169 iterations. [F:898216 S:360996 HI:100542]
[main] 1272134 iterations. [F:907689 S:364492 HI:102099]
[main] kernel became tainted! (512/0) Last seed was 144492271
trinity: Detected kernel tainting. Last seed was 144492271
[main] 1282601 iterations. [F:915248 S:367378 HI:102957]
[main] exit_reason=3D7, but 6 children still running.
[main] Bailing main loop because kernel became tainted..
[main] Ran 1282601 syscalls. Successes: 367378  Failures: 915248

--1dAlrHZTd2tbY/Cm--
