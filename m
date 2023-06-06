Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF5723915
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbjFFHdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFFHdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:33:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F50106;
        Tue,  6 Jun 2023 00:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686036818; x=1717572818;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K7K6lLy1Q99OZX3KwxuMBihzz5fmN433L1ygyTEmGJI=;
  b=auFi8NuC9HcUK54Nor5QZ4mcBLGO0iTFFRk6ptgxBVyGz7U9Y4sh7Viw
   +j230hVTNdxeKKHq93QRrX2Pcsn07DhscGRQxXSLPwk4thg7ZaXIriLlo
   05Y588tMWwFfMoIRukoNYwXWX9QV6JZuFNpeDv2S9aXxo4EJmW4j5M95R
   I5k5K90QUKLouuJ+a+llQoBlzPTJUUhRtlreu1c/4TtWocmzHYeMYDEex
   wwz2wlXt89pQrAfmeX2Uki11RBfk51UHBk2LPfa6IWztoBQ36owIKvO4R
   jP2urbPdXwS7D9LUKETGyYHr/Jn13oREvDF7EvwijcMHlXbadINPeMVl+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356600604"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="xz'341?scan'341,208,341";a="356600604"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:33:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="774027479"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="xz'341?scan'341,208,341";a="774027479"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2023 00:33:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 00:33:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 00:33:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 00:33:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQqx2R4T1F6vD2dWmLJmxWwSfrnX4dTqDN+iwDj/zA1lud+QsLbGmKkSDTqlnzsiUd51DG4qNoNE7H8r5BsBAxOYruWHoYn+QyxrtnhgbhYCTltVHduswmnuREQaBmXLJzeuXDRdGvTnJrutKi0ZGLxPvYedqBnuUEMZ3FV79bgyV/KZOuuHwk0z7mUyrBGrtZHv7qhdRCc239iINZRS4XOgypmyMTg5kPbQtsK1F8UJIfNMmNfCkXMaPkRGB2Y68NmZ0y1Vjl0Sv/FZjMJI5Q0QjYXuuEuJdiIZXvqhp1LZr6Lc+pY0PKsQwOCuOUG+uhEHRsx4lXxvLuYIJz5FcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5pCRIoqecGGgrpVGDtBX56iIhq1d3ga7WjXDKad9gw=;
 b=iMymYK5pBQy5Fa0yTiO6T6weYCgeB1KAChaJsxe8fy6ZPua93S3M5ANI0JHs4g9e+ZrreUZzhXRu3USk+Os59gkJMHGs+lo5G+RHT+pFB1IzTdeDAHLOwBF2Xqd2yOHXITXOBsQw4fHEI2y8y51bHyAlbW0Oqjz7DuLGJGovmWHimHalr5+visS1Cib3b+UKnSL6VORS3pa2nAinMIC0VMQS/U+VhIEdHKJFORZF3eLaEYYUOXik7FiAa7BnPjvxXH9DD8tqlNw9zTwfhsJEoMWk7ZeDO4LivB1qt2Fa4E86JefC4Kp4QgR7TWIryOy+5so85CVLX1e6ibsWR5ZWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB5993.namprd11.prod.outlook.com (2603:10b6:8:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 07:33:06 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 07:33:06 +0000
Date:   Tue, 6 Jun 2023 15:32:54 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Tejun Heo <tj@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Lai Jiangshan" <jiangshanlai@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: [tj-wq:auto-cpu-intensive-v4] [workqueue] 6a97cb750b:
 WARNING:at_kernel/workqueue.c:#worker_enter_idle
Message-ID: <202306061447.d3e30636-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="Q7oridZjJgTZDwRk"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad2a72b-733e-4208-6543-08db666044a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ca9fkWaGhf6IZUMERcegas+9qp0UQ6LQ4JTDIp+34WKL22+ZjpmJ7BJZne6IE9gl+da2tyeabPgTMDO9TdWan47YD7H+DQ6N+Bvwks0AEUABIvzgCcy/CgcfVfBHwwaJVySXuU8biW9Bt4+X8ivm+tkvAJ2bTaykbZOjkomnIDUsUSzED11saQuYWOJTbGQUsyRaZg5PlKRwWMGXjYGPUEFTUZ03xCf2UA/goyk9nIwRkl9yjA3bz0wfPZNe6a8Ed4cUsyWZhqN/UVsKZDvFIDK7MeokPIS6eBEui0pzqHIPDkle42YsXYy4eYBS7oLH3uHaOW3e1Mx6QkCQ6VPAw4j7bJ9TujopvKMFN5JKtNYbAlj+Kkv1W9hmj0WVZ3c584Jg5aikFN7XwqbKR/iY8H8YumJLk/PUrkhNwchERO0mKzNSu+WYpHOYAvFARKxNyeacdrzC/U3cQmIgqSoHKwBuF0Zq8B5wCXoTruBMgZTRROH5/zwmcRZIBv/phkr/i77kDcK4q34KRuzNEO2ZNGHnJKWkdDoKlm8UpLeHYc6Uq1Db5NiyncJ4F4lWjGl0cWMZYhtoSsttxsLmx0aXZVtiyo62Wxg4T4P+vxkSQZo45PgHXUypXOy2WzvADLjarAbjeX5kMhnulddbWefKxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(26005)(107886003)(38100700002)(2616005)(41300700001)(6506007)(6666004)(6512007)(966005)(83380400001)(1076003)(186003)(44144004)(6486002)(45080400002)(478600001)(54906003)(4326008)(66556008)(6916009)(66476007)(66946007)(82960400001)(316002)(5660300002)(235185007)(8676002)(8936002)(2906002)(86362001)(36756003)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/sF4UdYwd7D7nsPNSuLj5EsO1b+FG7VyjrplUXSjP1XOeBfpszPiOUsC23LI?=
 =?us-ascii?Q?w8Lo2R1BDH2zYFVQCrKTecrH8fKEe7BgiwdsNfkPFBPkYrYC9uc4lzj6cmpN?=
 =?us-ascii?Q?Y6f64wCCH36zSLJhv+saCEjeRYn8boGVzIMHEJweFAV4qyD7nWwO+xzsc5Z2?=
 =?us-ascii?Q?4RR55dvDGco0bPumwdoFmcQRhFkCtAVHNmIwOGVAjkak8LaC79NzDZQrvtyk?=
 =?us-ascii?Q?KmAtJvalcgXuK6SgEq8w1vPCkCF7nMloQZDYWLYp0YM3ThDgG9QDVwF5sCsN?=
 =?us-ascii?Q?y5iLBE6yhWZa8paV7l1PnCgdfKQhqr1kf/n3P5LwXBzo7tfvCS7+5xleee7T?=
 =?us-ascii?Q?Xm8+C6NQXFNmv4CgdDQ75YwS/J4Iha1xwhIKgzQQY+Mt1aFKLPInGY927l/f?=
 =?us-ascii?Q?SSTXjauz6RsTrfAaEpWXdUuq8/Hz404BP2OGfzWlBbnaX6Fcga23vfVRTvxq?=
 =?us-ascii?Q?4WxAgqrZyr+cF8DTj/VjqCuzT8XZr7qd6P2BOoS5niisH8rfRxiwEcZKuikH?=
 =?us-ascii?Q?ySi3d8+slOFUJ3ezBxbZmdW31qpTshXe9pu1VWKkqb2MijkGMJS/hN/HGo8o?=
 =?us-ascii?Q?7isy+adkul2aDjehVz1zPkch4Z/K8TQt6aJwDaZSUZMVqmhj5n8bU1gcGW0B?=
 =?us-ascii?Q?5posTUKteNsPc3Vy9RgE4odvWoiGl9Ja5m3LO+xhEKihizNLYewyKugKUccV?=
 =?us-ascii?Q?YeadKoWMK0muiN2JBOlr1mN4s8JAvPDVb3+nd/wopXqYWwY7wI+bRK8GdVPY?=
 =?us-ascii?Q?EPwUbLgrPVHP3oQ00CnEHSfqdD9LE9keGz+Dd+Y6kefQxoK4YcVYm572Xuum?=
 =?us-ascii?Q?t/XOip9MaGZf8e/dAQ5JXm1lEEpDCfAJ+3V99lm0oDDgezMIp03+dwsKiA77?=
 =?us-ascii?Q?0nq+J96Sh2y6he9DtkWqmGhWoRRval8CmSqC4NKYOYCc63FAiavhAzAsGljj?=
 =?us-ascii?Q?tHXD5iIe+dzoOjUuV2oDHr1X4drSn6DJodNEVD9lw+uf2y4IfdIGFD6YVAvn?=
 =?us-ascii?Q?kOYj7hv9rxyPIA1+F+utcszWpIzULWkt4msvp9nICDEkj5anuG/vxtUC8cCO?=
 =?us-ascii?Q?8KU5cvLkt9kUhtrnJWIuC5/uql8n2Wqa6ph56OsQye4oiLKjxlu1LSRYHeHD?=
 =?us-ascii?Q?n70BwBWPfGyNcjSQ7ELjf/yjvTmqAHtyKk2AwJ7IRF5IQ4APle3deM8v7bzM?=
 =?us-ascii?Q?/s/OdEVPzuQTwOeU5hzmmykW0SU7/zMHCHItWu6ZSlS/w/8uARETJjqX/ugv?=
 =?us-ascii?Q?SRMBcIdUE5GwSvLnqKFXmfAxVGSULpxx8IMmh2zD/xy2URRAbBKFzZVua3xJ?=
 =?us-ascii?Q?QstfGcjx7OriGyfcNtO68qw7Z4Qd20+IukzOTypZ7xv807txkgHhH5Z3WmcC?=
 =?us-ascii?Q?CTAdikInVxyYYfsN87vrL71wOHPzvoN7eqbfb1S9LN6ztIupeARH85ia1DvE?=
 =?us-ascii?Q?TQRhpIIBDZfGucBB8f0maah7kUIOFuarH4ltoCfdmr8+N+oNCbjsaxkAiC2J?=
 =?us-ascii?Q?EGmOXsuKdMlIiXuUIyningWX9dEcnfU1O7aq5oz3sLTvWu4Zf1GxtwuL1BFs?=
 =?us-ascii?Q?JlQEWVT7RWhCuegY6GKiYYRfFbwABlXnKGS6UVfLxXZdfm1tsUDFsHuk59Nz?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad2a72b-733e-4208-6543-08db666044a7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:33:06.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0kolbSV4HW2qgg0NhXPFNdL7+lLAAyf9k7GRgqPTXBCcdKkwHvlhMGBP3IzfmV1vJz5HOieOjJllkIuODkotw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5993
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Q7oridZjJgTZDwRk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Hello,

kernel test robot noticed "WARNING:at_kernel/workqueue.c:#worker_enter_idle" on:

commit: 6a97cb750bf8a8f4b6e514355ab2b80a6866c542 ("workqueue: Automatically mark CPU-hogging work items CPU_INTENSIVE")
https://git.kernel.org/cgit/linux/kernel/git/tj/wq.git auto-cpu-intensive-v4

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: busted_srcud



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


this does not always happen, but not a small rate, and clean on parent in our
tests:


=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
  vm-snb/rcutorture/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a003-20230531/gcc-12/300s/cpuhotplug/busted_srcud

52185b931a87084c 6a97cb750bf8a8f4b6e514355ab
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20          45%           9:20    dmesg.RIP:worker_enter_idle
           :20          45%           9:20    dmesg.WARNING:at_kernel/workqueue.c:#worker_enter_idle



If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202306061447.d3e30636-oliver.sang@intel.com


[  383.839791][   T66] ------------[ cut here ]------------
[ 383.840594][ T66] WARNING: CPU: 0 PID: 66 at kernel/workqueue.c:1903 worker_enter_idle (workqueue.c:?) 
[  383.841389][   T66] Modules linked in: rcutorture torture
[  383.841872][   T66] CPU: 0 PID: 66 Comm: kworker/0:2 Tainted: G        W          6.4.0-rc1-00007-g6a97cb750bf8 #1
[  383.842740][   T66] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  383.843617][   T66] Workqueue:  0x0 (rcu_gp)
[ 383.844027][ T66] RIP: 0010:worker_enter_idle (workqueue.c:?) 
[ 383.844546][ T66] Code: 48 89 fa 48 c1 e0 2a 48 c1 ea 03 8a 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 78 4c 40 00 83 7d 5c 00 74 02 <0f> 0b 5b 5d 41 5c 41 5d c3 41 54 49 89 d4 55 48 89 f5 53 48 89 fb
All code
========
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	48 c1 e0 2a          	shl    $0x2a,%rax
   7:	48 c1 ea 03          	shr    $0x3,%rdx
   b:	8a 14 02             	mov    (%rdx,%rax,1),%dl
   e:	48 89 f8             	mov    %rdi,%rax
  11:	83 e0 07             	and    $0x7,%eax
  14:	83 c0 03             	add    $0x3,%eax
  17:	38 d0                	cmp    %dl,%al
  19:	7c 09                	jl     0x24
  1b:	84 d2                	test   %dl,%dl
  1d:	74 05                	je     0x24
  1f:	e8 78 4c 40 00       	callq  0x404c9c
  24:	83 7d 5c 00          	cmpl   $0x0,0x5c(%rbp)
  28:	74 02                	je     0x2c
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	5b                   	pop    %rbx
  2d:	5d                   	pop    %rbp
  2e:	41 5c                	pop    %r12
  30:	41 5d                	pop    %r13
  32:	c3                   	retq   
  33:	41 54                	push   %r12
  35:	49 89 d4             	mov    %rdx,%r12
  38:	55                   	push   %rbp
  39:	48 89 f5             	mov    %rsi,%rbp
  3c:	53                   	push   %rbx
  3d:	48 89 fb             	mov    %rdi,%rbx

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	5b                   	pop    %rbx
   3:	5d                   	pop    %rbp
   4:	41 5c                	pop    %r12
   6:	41 5d                	pop    %r13
   8:	c3                   	retq   
   9:	41 54                	push   %r12
   b:	49 89 d4             	mov    %rdx,%r12
   e:	55                   	push   %rbp
   f:	48 89 f5             	mov    %rsi,%rbp
  12:	53                   	push   %rbx
  13:	48 89 fb             	mov    %rdi,%rbx
[  383.846260][   T66] RSP: 0018:ffffc90000e5fe80 EFLAGS: 00210086
[  383.846801][   T66] RAX: 0000000000000007 RBX: 0000000000000003 RCX: 0000000000000000
[  383.847458][   T66] RDX: 1ffff11075e47200 RSI: ffff8883af239638 RDI: ffff8883af23961c
[  383.848151][   T66] RBP: ffff8883af2395c0 R08: fffff520001cbfad R09: 0000000000000003
[  383.864919][   T66] R10: 0000000000000001 R11: ffffffff81292f65 R12: ffff8883af239634
[  383.865648][   T66] R13: ffff8883af239638 R14: ffffe8ffffc05fa8 R15: ffff8881bfde8000
[  383.866360][   T66] FS:  0000000000000000(0000) GS:ffff8883af200000(0000) knlGS:0000000000000000
[  383.867160][   T66] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  383.867736][   T66] CR2: 0000000056625160 CR3: 00000001bf680000 CR4: 00000000000406f0
[  383.868439][   T66] Call Trace:
[  383.868737][   T66]  <TASK>
[ 383.869006][ T66] worker_thread (workqueue.c:?) 
[ 383.869428][ T66] ? rescuer_thread (workqueue.c:?) 
[ 383.869858][ T66] kthread (kthread.c:?) 
[ 383.870216][ T66] ? kthread_complete_and_exit (kthread.c:?) 
[ 383.870710][ T66] ret_from_fork (??:?) 
[  383.871118][   T66]  </TASK>
[  383.871392][   T66] irq event stamp: 372430
[ 383.871770][ T66] hardirqs last enabled at (372429): _raw_spin_unlock_irq (??:?) 
[ 383.872627][ T66] hardirqs last disabled at (372430): _raw_spin_lock_irq (??:?) 
[ 383.873463][ T66] softirqs last enabled at (372426): srcu_invoke_callbacks (srcutree.c:?) 
[ 383.874357][ T66] softirqs last disabled at (372416): srcu_invoke_callbacks (srcutree.c:?) 
[  383.875230][   T66] ---[ end trace 0000000000000000 ]---
[  383.911576][   T19] numa_remove_cpu cpu 0 node 0: mask now 1
[  383.913220][  T778] smpboot: CPU 0 is now offline
[  383.937638][  T778] smpboot: Booting Node 0 Processor 0 APIC 0x0
[  383.956429][    T0] masked ExtINT on CPU#0
[  383.957038][    T0] numa_add_cpu cpu 0 node 0: mask now 0-1
[  384.048832][   T19] numa_remove_cpu cpu 0 node 0: mask now 1
[  384.053689][  T778] smpboot: CPU 0 is now offline
[  384.087434][  T778] smpboot: Booting Node 0 Processor 0 APIC 0x0
[  384.088421][    T0] masked ExtINT on CPU#0
[  384.088903][    T0] numa_add_cpu cpu 0 node 0: mask now 0-1
[  384.161716][   T19] numa_remove_cpu cpu 0 node 0: mask now 1
[  384.165632][  T778] smpboot: CPU 0 is now offline
[  384.201629][  T778] smpboot: Booting Node 0 Processor 0 APIC 0x0
[  384.202678][    T0] masked ExtINT on CPU#0
[  384.203223][    T0] numa_add_cpu cpu 0 node 0: mask now 0-1
[  384.293717][   T24] numa_remove_cpu cpu 1 node 0: mask now 0
[  384.303187][  T778] smpboot: CPU 1 is now offline
[  384.325618][  T778] x86: Booting SMP configuration:
[  384.326196][  T778] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  384.330912][    T0] masked ExtINT on CPU#1
[  384.331459][    T0] numa_add_cpu cpu 1 node 0: mask now 0-1
[  384.452543][   T19] numa_remove_cpu cpu 0 node 0: mask now 1
[  384.470688][  T778] smpboot: CPU 0 is now offline
[  384.508469][  T778] smpboot: Booting Node 0 Processor 0 APIC 0x0
[  384.516760][    T0] masked ExtINT on CPU#0
[  384.524642][    T0] numa_add_cpu cpu 0 node 0: mask now 0-1
[  384.600928][   T24] numa_remove_cpu cpu 1 node 0: mask now 0
[  384.604489][  T778] smpboot: CPU 1 is now offline
[  384.634772][  T778] x86: Booting SMP configuration:
[  384.635438][  T778] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  384.638672][    T0] masked ExtINT on CPU#1
[  384.639204][    T0] numa_add_cpu cpu 1 node 0: mask now 0-1
[  384.711713][   T24] numa_remove_cpu cpu 1 node 0: mask now 0
[  384.715687][  T778] smpboot: CPU 1 is now offline
[  384.756551][  T778] x86: Booting SMP configuration:
[  384.757172][  T778] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  384.761578][    T0] masked ExtINT on CPU#1
[  384.762137][    T0] numa_add_cpu cpu 1 node 0: mask now 0-1
[  384.822854][   T19] numa_remove_cpu cpu 0 node 0: mask now 1
[  384.826733][  T778] smpboot: CPU 0 is now offline
[  384.854352][  T778] smpboot: Booting Node 0 Processor 0 APIC 0x0
[  384.855284][    T0] masked ExtINT on CPU#0
[  384.856355][    T0] numa_add_cpu cpu 0 node 0: mask now 0-1
[  384.907586][   T24] numa_remove_cpu cpu 1 node 0: mask now 0
[  384.911114][  T778] smpboot: CPU 1 is now offline
[  384.930329][  T778] x86: Booting SMP configuration:
[  384.930879][  T778] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  384.934490][    T0] masked ExtINT on CPU#1
[  384.935036][    T0] numa_add_cpu cpu 1 node 0: mask now 0-1
[  384.988713][   T24] numa_remove_cpu cpu 1 node 0: mask now 0
[  384.992191][  T778] smpboot: CPU 1 is now offline
[  385.014302][  T778] x86: Booting SMP configuration:
[  385.014842][  T778] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  385.018360][    T0] masked ExtINT on CPU#1
[  385.018910][    T0] numa_add_cpu cpu 1 node 0: mask now 0-1
[  385.070898][   T19] numa_remove_cpu cpu 0 node 0: mask now 1
[  385.074682][  T778] smpboot: CPU 0 is now offline
[  385.110766][  T778] smpboot: Booting Node 0 Processor 0 APIC 0x0
[  385.111739][    T0] masked ExtINT on CPU#0
[  385.112241][    T0] numa_add_cpu cpu 0 node 0: mask now 0-1
[  385.190845][   T24] numa_remove_cpu cpu 1 node 0: mask now 0
[  385.194656][  T778] smpboot: CPU 1 is now offline
[  385.220409][  T778] x86: Booting SMP configuration:
[  385.220980][  T778] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  385.224337][    T0] masked ExtINT on CPU#1
[  385.224883][    T0] numa_add_cpu cpu 1 node 0: mask now 0-1
[  385.280190][   T19] numa_remove_cpu cpu 0 node 0: mask now 1
[  385.285294][  T778] smpboot: CPU 0 is now offline
[  385.309929][  T778] smpboot: Booting Node 0 Processor 0 APIC 0x0
[  385.310916][    T0] masked ExtINT on CPU#0
[  385.311385][    T0] numa_add_cpu cpu 0 node 0: mask now 0-1
[  385.389121][   T19] numa_remove_cpu cpu 0 node 0: mask now 1
[  385.392753][  T778] smpboot: CPU 0 is now offline
[  385.425664][  T778] smpboot: Booting Node 0 Processor 0 APIC 0x0
[  385.426672][    T0] masked ExtINT on CPU#0
[  385.427199][    T0] numa_add_cpu cpu 0 node 0: mask now 0-1
[  385.515315][   T24] numa_remove_cpu cpu 1 node 0: mask now 0
[  385.519172][  T778] smpboot: CPU 1 is now offline
[  385.554725][  T778] x86: Booting SMP configuration:


To reproduce:

        # build kernel
	cd linux
	cp config-6.4.0-rc1-00007-g6a97cb750bf8 .config
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



--Q7oridZjJgTZDwRk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc1-00007-g6a97cb750bf8"

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
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
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
CONFIG_IRQ_DOMAIN_HIERARCHY=y
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
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_CONTEXT_TRACKING_USER=y
CONFIG_CONTEXT_TRACKING_USER_FORCE=y
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
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

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
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
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
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
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_SCHED is not set
CONFIG_SCHED_MM_CID=y
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_FORCE=y
# CONFIG_BOOT_CONFIG_EMBED is not set
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
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_IO_URING is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
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
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
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
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_ACRN_GUEST=y
CONFIG_INTEL_TDX_GUEST=y
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
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
# CONFIG_SCHED_CLUSTER is not set
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
# CONFIG_X86_PAT is not set
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
CONFIG_X86_SGX=y
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_ADDRESS_MASKING=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=59
CONFIG_FUNCTION_PADDING_BYTES=64
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
# CONFIG_RETHUNK is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
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
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_FPDT=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
CONFIG_ACPI_APEI_EINJ=y
CONFIG_ACPI_APEI_ERST_DEBUG=y
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
# CONFIG_DPTF_PCH_FIVR is not set
CONFIG_ACPI_CONFIGFS=y
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_FFH=y
CONFIG_PMIC_OPREGION=y
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
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
# CONFIG_HALTPOLL_CPUIDLE is not set
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
# CONFIG_ISA_DMA_API is not set
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
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
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
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
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
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y
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
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
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
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
# CONFIG_ZONE_DEVICE is not set
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
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
# CONFIG_BPF_STREAM_PARSER is not set
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
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
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
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PTM=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_PCIE_BUS_TUNE_OFF=y
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_PCI_FTPCI100=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y

#
# Cadence-based PCIe controllers
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
CONFIG_PCI_J721E=y
CONFIG_PCI_J721E_HOST=y
# CONFIG_PCI_J721E_EP is not set
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
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
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
# CONFIG_PCI_EPF_TEST is not set
# CONFIG_PCI_EPF_NTB is not set
CONFIG_PCI_EPF_VNTB=y
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DMA_ENGINE=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DEVTMPFS_SAFE=y
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
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
CONFIG_MHI_BUS_PCI_GENERIC=y
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
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
CONFIG_GOOGLE_MEMCONSOLE=y
CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=y
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_SMPRO_ERRMON=y
CONFIG_SMPRO_MISC=y
CONFIG_HP_ILO=y
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_VMWARE_BALLOON=y
# CONFIG_SRAM is not set
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_VCPU_STALL_DETECTOR=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=y
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=y
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
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
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
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
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
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
# CONFIG_KS8842 is not set
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
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
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

# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
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
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
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
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_88PM860X is not set
CONFIG_TOUCHSCREEN_AD7879=y
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
CONFIG_TOUCHSCREEN_AR1021_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
CONFIG_TOUCHSCREEN_CY8CTMA140=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP5=y
CONFIG_TOUCHSCREEN_DA9034=y
CONFIG_TOUCHSCREEN_DA9052=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX=y
# CONFIG_TOUCHSCREEN_ILI210X is not set
CONFIG_TOUCHSCREEN_ILITEK=y
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=y
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=y
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=y
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS is not set
CONFIG_TOUCHSCREEN_IMAGIS=y
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
# CONFIG_TOUCHSCREEN_INEXIO is not set
CONFIG_TOUCHSCREEN_MK712=y
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_WM831X=y
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SX8654=y
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_TOUCHSCREEN_ZINITIX=y
CONFIG_TOUCHSCREEN_HIMAX_HX83112B=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
# CONFIG_GAMEPORT_FM801 is not set
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
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_DWLIB=y
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
# CONFIG_SERIAL_SPRD is not set
# CONFIG_SERIAL_LITEUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_RPMSG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_IPMB=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
# CONFIG_SSIF_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_CCTRNG=y
CONFIG_HW_RANDOM_XIPHERA=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_DEVMEM is not set
# CONFIG_NVRAM is not set
# CONFIG_DEVPORT is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

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
CONFIG_I2C_I801=y
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_NFORCE2_S4985 is not set
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_RK3X=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PCI1XXXX=y
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SVC_I3C_MASTER=y
CONFIG_MIPI_I3C_HCI=y
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
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
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
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_AS3722=y
CONFIG_PINCTRL_CY8C95X0=y
# CONFIG_PINCTRL_DA9062 is not set
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_PINCTRL_MAX77620=y
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_PALMAS=y
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_STMFX=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_LYNXPOINT=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_ELKHARTLAKE is not set
CONFIG_PINCTRL_EMMITSBURG=y
CONFIG_PINCTRL_GEMINILAKE=y
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_JASPERLAKE=y
CONFIG_PINCTRL_LAKEFIELD=y
CONFIG_PINCTRL_LEWISBURG=y
# CONFIG_PINCTRL_METEORLAKE is not set
CONFIG_PINCTRL_SUNRISEPOINT=y
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
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y
CONFIG_GPIO_IDIO_16=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_LOGICVC=y
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_TANGIER=y
CONFIG_GPIO_VX855=y
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=y
# CONFIG_GPIO_104_DIO_48E is not set
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_FXL6408=y
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD71815=y
CONFIG_GPIO_BD71828=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_ELKHARTLAKE=y
# CONFIG_GPIO_JANZ_TTL is not set
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_MAX77650=y
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_TC3589X=y
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TWL4030 is not set
# CONFIG_GPIO_TWL6040 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_LATCH=y
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
CONFIG_POWER_RESET_ATC260X=y
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_MT6323=y
CONFIG_POWER_RESET_REGULATOR=y
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_TPS65086 is not set
# CONFIG_POWER_RESET_SYSCON is not set
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_NVMEM_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_IP5XXX_POWER=y
CONFIG_MAX8925_POWER=y
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SAMSUNG_SDI=y
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_88PM860X=y
CONFIG_CHARGER_PCF50633=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX77650 is not set
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MAX8997=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_BQ256XX=y
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65217 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_RT9467 is not set
# CONFIG_CHARGER_RT9471 is not set
CONFIG_CHARGER_CROS_USBPD=y
CONFIG_CHARGER_CROS_PCHG=y
CONFIG_CHARGER_UCS1002=y
# CONFIG_CHARGER_BD99954 is not set
CONFIG_CHARGER_WILCO=y
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_SMPRO=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_CORSAIR_CPRO=y
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_DA9055 is not set
CONFIG_SENSORS_I5K_AMB=y
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_I5500=y
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX31760=y
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6650=y
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MC34VR500=y
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MR75203=y
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_OCC_P8_I2C=y
CONFIG_SENSORS_OCC=y
# CONFIG_SENSORS_OXP is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_PECI_CPUTEMP is not set
# CONFIG_SENSORS_PECI_DIMMTEMP is not set
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ACBEL_FSG032 is not set
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
CONFIG_SENSORS_FSP_3Y=y
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_DPS920AB is not set
CONFIG_SENSORS_INSPUR_IPSPS=y
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=y
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LT7182S=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX15301 is not set
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX16601=y
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_MP2888=y
# CONFIG_SENSORS_MP2975 is not set
CONFIG_SENSORS_MP5023=y
# CONFIG_SENSORS_MPQ7932_REGULATOR is not set
CONFIG_SENSORS_MPQ7932=y
CONFIG_SENSORS_PIM4328=y
CONFIG_SENSORS_PLI1209BC=y
CONFIG_SENSORS_PLI1209BC_REGULATOR=y
# CONFIG_SENSORS_PM6764TR is not set
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_Q54SJ108A2=y
CONFIG_SENSORS_STPDDC60=y
CONFIG_SENSORS_TDA38640=y
# CONFIG_SENSORS_TDA38640_REGULATOR is not set
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_TPS546D24=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_XDPE152=y
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=y
# CONFIG_SENSORS_PWM_FAN is not set
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_SY7636A=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC2305=y
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=y
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_SENSORS_ASUS_EC=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_CPU_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
# CONFIG_MAX77620_THERMAL is not set
CONFIG_DA9062_THERMAL=y

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_SMPRO=y
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC_DEV=y
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_MAX597X=y
# CONFIG_MFD_CS47L15 is not set
CONFIG_MFD_CS47L35=y
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
# CONFIG_LPC_ICH is not set
CONFIG_LPC_SCH=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=y
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
CONFIG_MFD_MT6370=y
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_NTXEC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
# CONFIG_PCF50633_GPIO is not set
CONFIG_MFD_SY7636A=y
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT4831=y
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RT5120=y
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS65219=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=y
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD71828=y
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_QCOM_PM8008 is not set
# CONFIG_MFD_RSMU_I2C is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_ATC260X=y
# CONFIG_REGULATOR_BCM590XX is not set
CONFIG_REGULATOR_BD71815=y
# CONFIG_REGULATOR_BD71828 is not set
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_CROS_EC=y
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=y
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX597X is not set
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8907=y
# CONFIG_REGULATOR_MAX8925 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX20086=y
# CONFIG_REGULATOR_MAX20411 is not set
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MCP16502 is not set
CONFIG_REGULATOR_MP5416=y
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=y
CONFIG_REGULATOR_MPQ7920=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
CONFIG_REGULATOR_MT6331=y
CONFIG_REGULATOR_MT6332=y
# CONFIG_REGULATOR_MT6357 is not set
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6359=y
CONFIG_REGULATOR_MT6370=y
# CONFIG_REGULATOR_MT6397 is not set
# CONFIG_REGULATOR_PALMAS is not set
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCF50633=y
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_ROHM=y
# CONFIG_REGULATOR_RT4801 is not set
# CONFIG_REGULATOR_RT4803 is not set
CONFIG_REGULATOR_RT4831=y
CONFIG_REGULATOR_RT5120=y
CONFIG_REGULATOR_RT5190A=y
CONFIG_REGULATOR_RT5739=y
CONFIG_REGULATOR_RT5759=y
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6190=y
# CONFIG_REGULATOR_RT6245 is not set
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=y
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STPMIC1=y
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS6286X=y
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65086 is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=y
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS65219=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8994=y
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
CONFIG_CEC_CROS_EC=y
CONFIG_CEC_SECO=y
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_SWITCHEROO=y
# CONFIG_DRM is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
# CONFIG_FB_RIVA_BACKLIGHT is not set
# CONFIG_FB_I740 is not set
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
# CONFIG_FB_INTEL is not set
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=y
# CONFIG_FB_MATROX_MAVEN is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=y
# CONFIG_FB_S3_DDC is not set
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_SM501=y
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
CONFIG_BACKLIGHT_KTZ8866=y
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_CARILLO_RANCH is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_MAX8925=y
CONFIG_BACKLIGHT_MT6370=y
CONFIG_BACKLIGHT_APPLE=y
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_RT4831=y
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=y
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_LP8788=y
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_COUGAR=y
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
CONFIG_HID_EVISION=y
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
CONFIG_HID_XIAOMI=y
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SEMITEK=y
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
# CONFIG_STEAM_FF is not set
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
# CONFIG_HID_TOPRE is not set
# CONFIG_HID_THINGM is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# HID-BPF support
#
CONFIG_HID_BPF=y
# end of HID-BPF support

CONFIG_I2C_HID=y
CONFIG_I2C_HID_ACPI=y
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_ELAN is not set
CONFIG_I2C_HID_OF_GOODIX=y
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

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB dual-mode controller drivers
#

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_PCI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_APU=y
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_LP55XX_COMMON is not set
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2606MVV=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX77650 is not set
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
CONFIG_LEDS_NIC78BX=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=y
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
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_DW_AXI_DMAC=y
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=y
CONFIG_INTEL_IDXD_BUS=y
CONFIG_INTEL_IDXD_COMPAT=y
CONFIG_INTEL_IOATDMA=y
CONFIG_PLX_DMA=y
CONFIG_XILINX_XDMA=y
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_AMD_PTDMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=y
CONFIG_INTEL_LDMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=y
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_IGD=y
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_ACRN_HSM=y
CONFIG_TDX_GUEST_DRIVER=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MEM=y
CONFIG_VIRTIO_INPUT=y
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
# CONFIG_CHROMEOS_LAPTOP is not set
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
# CONFIG_CROS_EC_I2C is not set
CONFIG_CROS_EC_RPMSG=y
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_LIGHTBAR=y
CONFIG_CROS_EC_VBC=y
CONFIG_CROS_EC_DEBUGFS=y
CONFIG_CROS_EC_SENSORHUB=y
CONFIG_CROS_EC_SYSFS=y
# CONFIG_CROS_HPS_I2C is not set
CONFIG_CROS_USBPD_LOGGER=y
CONFIG_CROS_USBPD_NOTIFY=y
CONFIG_WILCO_EC=y
# CONFIG_WILCO_EC_DEBUGFS is not set
CONFIG_WILCO_EC_EVENTS=y
CONFIG_WILCO_EC_TELEMETRY=y
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_SURFACE_PLATFORMS is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_SI5341=y
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_CLK_TWL6040=y
CONFIG_COMMON_CLK_AXI_CLKGEN=y
CONFIG_COMMON_CLK_PALMAS=y
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_RS9_PCIE is not set
# CONFIG_COMMON_CLK_SI521XX is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_VC7=y
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_XILINX_VCU is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=y
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

# CONFIG_WPCM450_SOC is not set

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
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
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
CONFIG_EXTCON_FSA9480=y
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_PALMAS is not set
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=y
CONFIG_MEMORY=y
# CONFIG_IIO is not set
CONFIG_NTB=y
# CONFIG_NTB_AMD is not set
CONFIG_NTB_IDT=y
CONFIG_NTB_INTEL=y
# CONFIG_NTB_EPF is not set
CONFIG_NTB_SWITCHTEC=y
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=y
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_ATMEL_TCB=y
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_CROS_EC is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_INTEL_LGM is not set
CONFIG_PWM_IQS620A=y
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_NTXEC=y
CONFIG_PWM_PCA9685=y
CONFIG_PWM_TWL=y
# CONFIG_PWM_TWL_LED is not set
CONFIG_PWM_XILINX=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_LAN966X_SERDES=y
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_DEV_DAX_KMEM=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
CONFIG_NVMEM_LAYOUT_SL28_VPD=y
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

CONFIG_NVMEM_RMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
CONFIG_FPGA_MGR_ALTERA_CVP=y
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
# CONFIG_FSI is not set
CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
CONFIG_INTEL_QEP=y
CONFIG_INTERRUPT_CNT=y
CONFIG_MOST=y
# CONFIG_MOST_CDEV is not set
CONFIG_PECI=y
# CONFIG_PECI_CPU is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y
CONFIG_OVERLAY_FS_XINO_AUTO=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_DEBUG is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
CONFIG_PSTORE_LZO_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS=y
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lzo"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=y
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
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
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
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
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_STACK_ALL_PATTERN is not set
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

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
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_ARIA=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
# CONFIG_CRYPTO_BLAKE2B is not set
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_VMAC=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
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
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_SHA1_SSSE3=y
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=y
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
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
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
# CONFIG_CPUMASK_OFFSTACK is not set
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
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
# end of Library routines

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
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
CONFIG_OBJTOOL=y
CONFIG_VMLINUX_MAP=y
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
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
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
CONFIG_PAGE_TABLE_CHECK=y
CONFIG_PAGE_TABLE_CHECK_ENFORCED=y
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
CONFIG_PER_VMA_LOCK_STATS=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SHRINKER_DEBUG=y
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
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

CONFIG_DEBUG_TIMEKEEPING=y

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
CONFIG_NMI_CHECK_CPU=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
CONFIG_DEBUG_MAPLE_TREE=y
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
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
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
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
CONFIG_MMIOTRACE=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
# CONFIG_SYNTH_EVENTS is not set
CONFIG_USER_EVENTS=y
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_FTRACE_RECORD_RECURSION=y
CONFIG_FTRACE_RECORD_RECURSION_SIZE=128
# CONFIG_RING_BUFFER_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
# CONFIG_MMIOTRACE_TEST is not set
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
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
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
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_DHRY=y
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

--Q7oridZjJgTZDwRk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='rcutorture'
	export testcase='rcutorture'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='rcutorture.yaml'
	export queue_cmdline_keys=
	export queue='int'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='tj-wq/auto-cpu-intensive-v4'
	export commit='6a97cb750bf8a8f4b6e514355ab2b80a6866c542'
	export kconfig='x86_64-randconfig-a003-20230531'
	export nr_vm=300
	export submit_id='647eb8880b9a93c938263173'
	export job_file='/lkp/jobs/scheduled/vm-meta-214/rcutorture-300s-cpuhotplug-busted_srcud-debian-11.1-i386-20220923.cgz-6a97cb750bf8a8f4b6e514355ab2b80a6866c542-20230606-51512-1bk9o1q-8.yaml'
	export id='a4cc7559625ba7ec8f2dccfb396d6a23e2ee5270'
	export queuer_version='/lkp/xsang/.src-20230606-092506'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kernel_version='>= v4.17, gcc
>= v5.12, clang'
	export need_kconfig=\{\"RCU_TORTURE_TEST\"\=\>\"m\"\}'
'\{\"X86_VSMP\"\=\>\"n\"\}'
'\{\"SECURITY_LOADPIN_ENABLED\"\=\>\"n\"\}'
'\{\"SECURITY_LOADPIN_ENFORCE\"\=\>\"n\"\}'
'\{\"MODULE_UNLOAD\"\=\>\"y\"\}'
'\{\"RCU_EXPERT\"\=\>\"y\"\}'
'\{\"FORCE_TASKS_RCU\"\=\>\"y\"\}'
'\{\"TASKS_RCU\"\=\>\"y\"\}'
'\{\"FORCE_TASKS_TRACE_RCU\"\=\>\"y\"\}'
'\{\"TASKS_TRACE_RCU\"\=\>\"y\"\}'
'\{\"FORCE_TASKS_RUDE_RCU\"\=\>\"y\"\}'
'\{\"TASKS_RUDE_RCU\"\=\>\"y\"\}'
'\{\"RCU_REF_SCALE_TEST\"\=\>\"m\"\}'
'\{\"MODULE_UNLOAD\"\=\>\"y\"\}'
'\{\"RCU_EXPERT\"\=\>\"y\"\}'
'\{\"FORCE_TASKS_RCU\"\=\>\"y\"\}'
'\{\"TASKS_RCU\"\=\>\"y\"\}'
'\{\"FORCE_TASKS_TRACE_RCU\"\=\>\"y\"\}'
'\{\"TASKS_TRACE_RCU\"\=\>\"y\"\}'
'\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-i386-20220923.cgz'
	export compiler='gcc-12'
	export enqueue_time='2023-06-06 12:39:36 +0800'
	export _id='647eb88a0b9a93c93826317b'
	export _rt='/result/rcutorture/300s-cpuhotplug-busted_srcud/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a003-20230531/gcc-12/6a97cb750bf8a8f4b6e514355ab2b80a6866c542'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/rcutorture/300s-cpuhotplug-busted_srcud/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a003-20230531/gcc-12/6a97cb750bf8a8f4b6e514355ab2b80a6866c542/8'
	export scheduler_version='/lkp/lkp/.src-20230605-181446'
	export arch='i386'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/rcutorture/300s-cpuhotplug-busted_srcud/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a003-20230531/gcc-12/6a97cb750bf8a8f4b6e514355ab2b80a6866c542/8
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a003-20230531/gcc-12/6a97cb750bf8a8f4b6e514355ab2b80a6866c542/vmlinuz-6.4.0-rc1-00007-g6a97cb750bf8
branch=tj-wq/auto-cpu-intensive-v4
job=/lkp/jobs/scheduled/vm-meta-214/rcutorture-300s-cpuhotplug-busted_srcud-debian-11.1-i386-20220923.cgz-6a97cb750bf8a8f4b6e514355ab2b80a6866c542-20230606-51512-1bk9o1q-8.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a003-20230531
commit=6a97cb750bf8a8f4b6e514355ab2b80a6866c542
initcall_debug
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
	export modules_initrd='/pkg/linux/x86_64-randconfig-a003-20230531/gcc-12/6a97cb750bf8a8f4b6e514355ab2b80a6866c542/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export meta_host='vm-meta-214'
	export kernel='/pkg/linux/x86_64-randconfig-a003-20230531/gcc-12/6a97cb750bf8a8f4b6e514355ab2b80a6866c542/vmlinuz-6.4.0-rc1-00007-g6a97cb750bf8'
	export dequeue_time='2023-06-06 12:39:49 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-214/rcutorture-300s-cpuhotplug-busted_srcud-debian-11.1-i386-20220923.cgz-6a97cb750bf8a8f4b6e514355ab2b80a6866c542-20230606-51512-1bk9o1q-8.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='cpuhotplug' torture_type='busted_srcud' $LKP_SRC/tests/wrapper rcutorture
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='cpuhotplug' torture_type='busted_srcud' $LKP_SRC/stats/wrapper rcutorture
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time rcutorture.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--Q7oridZjJgTZDwRk
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--Q7oridZjJgTZDwRk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="rcutorture"

2023-06-06 04:42:15 depmod
2023-06-06 04:44:39 sleep 300
2023-06-06 04:49:39 rmmod rcutorture
[  267.972445] busted_srcud-torture:--- Start of test: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=3 onoff_holdoff=30 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000 test_nmis=0
[  267.978459] busted_srcud-torture: Creating rcu_torture_writer task
[  268.027807] busted_srcud-torture: Creating rcu_torture_fakewriter task
[  268.028656] busted_srcud-torture: rcu_torture_writer task started
[  268.046749] busted_srcud-torture: Creating rcu_torture_fakewriter task
[  268.051385] busted_srcud-torture: rcu_torture_fakewriter task started
[  268.061732] busted_srcud-torture: Creating rcu_torture_fakewriter task
[  268.068264] busted_srcud-torture: rcu_torture_fakewriter task started
[  268.079398] busted_srcud-torture: Creating rcu_torture_fakewriter task
[  268.082945] busted_srcud-torture: rcu_torture_fakewriter task started
[  268.097236] busted_srcud-torture: Creating rcu_torture_reader task
[  268.100725] busted_srcud-torture: rcu_torture_fakewriter task started
[  268.119612] busted_srcud-torture: Creating rcu_torture_stats task
[  268.123325] busted_srcud-torture: rcu_torture_reader task started
[  268.153019] busted_srcud-torture: Creating torture_shuffle task
[  268.154770] busted_srcud-torture: rcu_torture_stats task started
[  268.172555] busted_srcud-torture: Creating torture_stutter task
[  268.174927] busted_srcud-torture: torture_shuffle task started
[  268.182597] busted_srcud-torture: Creating torture_onoff task
[  268.184874] busted_srcud-torture: torture_stutter task started
[  268.200920] busted_srcud-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
[  268.201865] busted_srcud-torture: Creating rcu_torture_read_exit task
[  268.203617] busted_srcud-torture: torture_onoff task started
[  268.237549] busted_srcud-torture: rcu_torture_read_exit: Start of test
[  268.238273] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  268.678307] busted_srcud-torture: torture_onoff begin holdoff
[  273.583776] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  287.200121] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  287.217579] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  298.966122] busted_srcud-torture: torture_onoff end holdoff
[  300.532429] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  303.799185] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  317.272030] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  317.415153] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  328.156163] busted_srcud-torture: rtc: 00000000df4d836e ver: 6700 tfle: 0 rta: 6700 rtaf: 0 rtf: 6690 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 4795 onoff: 219/220:220/220 21,348:24,226 15083:10599 (HZ=1000) barrier: 0/0:0 read-exits: 64 nocb-toggles: 0:0
[  328.158589] busted_srcud-torture: !!! 
[  328.184132] busted_srcud-torture: Reader Batch:  570022 553 63 27 5 1 1 0 0 0 0
[  328.186246] busted_srcud-torture: Free-Block Circulation:  6699 6699 6697 6696 6695 6694 6693 6692 6691 6690 0
[  328.187319] rcu: busted_srcud-torture: Tree SRCU g68773 state 0 (SRCU_SIZE_SMALL) per-CPU(idx=1): 0(0,0 C) 1(0,0 .) T(0,0)
[  330.606162] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  333.536850] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  346.720577] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  347.085952] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  360.390740] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  363.468452] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  376.654807] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  376.681017] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  388.207459] busted_srcud-torture: rtc: 00000000135521de ver: 12052 tfle: 0 rta: 12053 rtaf: 0 rtf: 12039 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 6794 onoff: 680/681:681/681 21,379:18,296 45068:33402 (HZ=1000) barrier: 0/0:0 read-exits: 128 nocb-toggles: 0:0
[  388.209883] busted_srcud-torture: !!! Reader Pipe:  737805 211 8 1 0 0 0 0 0 0 0
[  388.210805] busted_srcud-torture: Reader Batch:  737175 712 91 33 11 2 1 0 0 0 0
[  388.211641] busted_srcud-torture: Free-Block Circulation:  12051 12051 12050 12048 12046 12044 12042 12041 12040 12039 0
[  388.212872] rcu: busted_srcud-torture: Tree SRCU g128657 state 0 (SRCU_SIZE_SMALL) per-CPU(idx=0): 0(0,0 C) 1(0,0 .) T(0,0)
[  389.863198] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  393.648446] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  406.846160] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  406.854753] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  420.062482] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  423.814299] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  436.924725] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  437.237982] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  448.220486] busted_srcud-torture: rtc: 00000000eeabb4b8 ver: 17540 tfle: 0 rta: 17540 rtaf: 0 rtf: 17530 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 8672 onoff: 1143/1144:1144/1144 21,379:18,296 74633:56373 (HZ=1000) barrier: 0/0:0 read-exits: 192 nocb-toggles: 0:0
[  448.222790] busted_srcud-torture: !!! Reader Pipe:  891529 231 12 1 0 0 0 0 0 0 0
[  448.223638] busted_srcud-torture: Reader Batch:  890775 827 115 37 16 2 1 0 0 0 0
[  448.224468] busted_srcud-torture: Free-Block Circulation:  17539 17538 17537 17536 17535 17534 17533 17532 17531 17530 0
[  448.225534] rcu: busted_srcud-torture: Tree SRCU g190405 state 0 (SRCU_SIZE_SMALL) per-CPU(idx=1): 0(0,0 C) 1(0,0 .) T(0,0)
[  450.399906] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  453.561256] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  466.886832] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  467.588902] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  480.801212] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  484.069705] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  497.182169] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  497.282042] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  508.234112] busted_srcud-torture: rtc: 00000000f9fef3a8 ver: 23446 tfle: 0 rta: 23446 rtaf: 0 rtf: 23433 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 10920 onoff: 1621/1622:1622/1622 21,530:18,323 104516:78945 (HZ=1000) barrier: 0/0:0 read-exits: 256 nocb-toggles: 0:0
[  508.236538] busted_srcud-torture: !!! Reader Pipe:  1080589 269 14 1 0 0 0 0 0 0 0
[  508.237471] busted_srcud-torture: Reader Batch:  1079685 985 134 43 21 3 2 0 0 0 0
[  508.238360] busted_srcud-torture: Free-Block Circulation:  23445 23444 23442 23441 23439 23438 23436 23435 23434 23433 0
[  508.239579] rcu: busted_srcud-torture: Tree SRCU g255873 state 0 (SRCU_SIZE_SMALL) per-CPU(idx=0): 0(0,0 C) 1(0,0 .) T(0,0)
[  510.422147] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  513.666857] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  526.950198] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  527.390200] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  540.486169] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  544.049864] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  557.655396] busted_srcud-torture: rcu_torture_read_exit: Start of episode
[  557.794582] busted_srcud-torture: rcu_torture_read_exit: End of episode
[  568.238151] busted_srcud-torture: rtc: 00000000df4d836e ver: 28830 tfle: 0 rta: 28830 rtaf: 0 rtf: 28817 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 12874 onoff: 2066/2066:2066/2067 21,530:18,343 134923:101406 (HZ=1000) barrier: 0/0:0 read-exits: 320 nocb-toggles: 0:0
[  568.240725] busted_srcud-torture: !!! Reader Pipe:  1254191 305 19 1 0 0 0 0 0 0 0
[  568.241662] busted_srcud-torture: Reader Batch:  1253173 1113 149 49 26 4 2 0 0 0 0
[  568.242563] busted_srcud-torture: Free-Block Circulation:  28829 28828 28826 28825 28824 28822 28821 28819 28818 28817 0
[  568.243728] rcu: busted_srcud-torture: Tree SRCU g317477 state 0 (SRCU_SIZE_SMALL) per-CPU(idx=1): 0(0,0 C) 1(0,0 .) T(0,0)
[  569.644938] busted_srcud-torture: Stopping torture_shuffle task
[  569.657164] busted_srcud-torture: torture_shuffle is stopping
[  569.661835] busted_srcud-torture: torture_onoff is stopping
[  569.665945] busted_srcud-torture: Stopping torture_stutter task
[  569.669177] busted_srcud-torture: torture_stutter is stopping
[  569.670334] busted_srcud-torture: rcu_torture_fakewriter is stopping
[  569.671634] busted_srcud-torture: rcu_torture_writer is stopping
[  569.672411] busted_srcud-torture: rcu_torture_fakewriter is stopping
[  569.673586] busted_srcud-torture: rcu_torture_reader is stopping
[  569.676630] busted_srcud-torture: rcu_torture_fakewriter is stopping
[  569.677361] busted_srcud-torture: rcu_torture_fakewriter is stopping
[  569.679717] busted_srcud-torture: Stopping torture_onoff task
[  570.070264] busted_srcud-torture: rcu_torture_read_exit is stopping
[  570.070299] busted_srcud-torture: Stopping rcutorture_read_exit task
[  570.073731] busted_srcud-torture: Stopping rcu_torture_writer task
[  570.074503] busted_srcud-torture: Stopping rcu_torture_reader task
[  570.077443] busted_srcud-torture: Stopping rcu_torture_fakewriter task
[  570.079870] busted_srcud-torture: Stopping rcu_torture_fakewriter task
[  570.080759] busted_srcud-torture: Stopping rcu_torture_fakewriter task
[  570.083491] busted_srcud-torture: Stopping rcu_torture_fakewriter task
[  570.085911] busted_srcud-torture: Stopping rcu_torture_stats task
[  570.087742] busted_srcud-torture: rtc: 0000000000000000 VER: 28922 tfle: 0 rta: 28922 rtaf: 0 rtf: 28913 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 12924 onoff: 2076/2076:2077/2077 21,530:18,343 135617:102016 (HZ=1000) barrier: 0/0:0 read-exits: 320 nocb-toggles: 0:0
[  570.092099] busted_srcud-torture: !!! Reader Pipe:  1258049 305 19 1 0 0 0 0 0 0 0
[  570.092990] busted_srcud-torture: Reader Batch:  1257026 1118 149 49 26 4 2 0 0 0 0
[  570.093866] busted_srcud-torture: Free-Block Circulation:  28921 28921 28920 28919 28918 28917 28916 28915 28914 28913 0
[  570.095033] rcu: busted_srcud-torture: Tree SRCU g318512 state 0 (SRCU_SIZE_SMALL) per-CPU(idx=0): 0(0,0 .) 1(0,0 .) T(0,0)
[  570.104033] busted_srcud-torture: rcu_torture_stats is stopping
[  570.317164] busted_srcud-torture: rtc: 0000000000000000 VER: 28922 tfle: 0 rta: 28922 rtaf: 0 rtf: 28913 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 12924 onoff: 2076/2076:2077/2077 21,530:18,343 135617:102016 (HZ=1000) barrier: 0/0:0 read-exits: 320 nocb-toggles: 0:0
[  570.319635] busted_srcud-torture: !!! Reader Pipe:  1258049 305 19 1 0 0 0 0 0 0 0
[  570.320622] busted_srcud-torture: Reader Batch:  1257026 1118 149 49 26 4 2 0 0 0 0
[  570.321542] busted_srcud-torture: Free-Block Circulation:  28921 28921 28920 28919 28918 28917 28916 28915 28914 28913 0
[  570.322756] rcu: busted_srcud-torture: Tree SRCU g0 state 0 (SRCU_SIZE_SMALL) per-CPU(idx=0): 0(0,0 .) 1(0,0 .) T(0,0)
[  570.327319] busted_srcud-torture:--- End of test: FAILURE: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=3 onoff_holdoff=30 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000 test_nmis=0

--Q7oridZjJgTZDwRk--
