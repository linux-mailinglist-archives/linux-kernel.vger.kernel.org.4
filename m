Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671D96A680E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCAHVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCAHVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:21:53 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7AC366A0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677655308; x=1709191308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+dxZYbHwg2Vtv6hDi2fFUHnQIUSVBLaiBr0d3pst6vY=;
  b=GxyyKOBiwqbG3/Osf+rnuSDFNYebZ4Q/2skYL2Barihr/8XE32RikYhQ
   9W2Hr+dP5xKjboKmeLEKMroh+JHZ1DF61gfhGS7/hxn74eNXMLdViUmXb
   erqAMgn9Oq6HoxO+nEj9EWVIBo4XrlfAEMOnVi3mJ+ziY8Z+tKA8hMKBo
   seDXSRlFFpCO+nZk+vcuXFnpPuSAlvJRYlpJ7P2mQDiPMhWKnVz9B0psj
   LbgMzkiUZX3gQFryfIrE33QXBiK37epcVmG/u0vmBESAbCEU0vMLMYdWG
   tL93f30Ek2o+I+Y6CG+OVaucqgMSOfLEECf6TtYnBOXUG9LLAm6mkjDOk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="318142773"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="xz'341?scan'341,208,341";a="318142773"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 23:21:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="1003547865"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="xz'341?scan'341,208,341";a="1003547865"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 28 Feb 2023 23:21:46 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Feb 2023 23:21:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 23:21:46 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 23:21:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5vaQsM/kkG2AcTJhNBto/1nttdWsSkqeGSZavI2K/4+QyxdvvLvcNkIEiHWnie92jvHxjPKbe5QoR39sRwIapxC2xLR6oaxVo9oEQMUNZr7dF7pOkWd1vpeRG4dRitZnf+8LO2d0xNskj/L1d3526Ji0IT90r+PwJx6yqBeYxItvADpKcs+Q93DDjPUN6qxS2du72oeRw+GGUQ+iBeHL6d/xW4Pt47shUjqPKE6j6K8LFCNpalPUp2A+kSTVWmSB/Wg/OXfNOAGbPZU5n6dqIihsC7e6yJFWh+Dz+V4dBvR1SCqajkjej298YbMHeijrQfxE79HT+BtLWkyuRPnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2TbQy1A13+R8lsoYkzNk7eQzkG1mKI+jSnZ9YCNh0E=;
 b=VjgCXcdWmTbT+TmJ3+lDEhpP4RclxbxyaY9miC3YGPlKdNaWfoV2EtmqrYG1beAb+Iof416XAWJDW9xUp6s64IcrogBOs0IhtP6BMnjNWeyHXypkZskQ2Qm+CK7meQWaEHGBUaJDl88fxMso6ss4gPwqk4pMzkipYn/D4R6utxeUaC3OofVWAivkqn5AhQ2ox43Di8yo9GooKHNYv1dIzsuePx+bEAVxmLFpL9YLZyWUojGJAT1rRHJ17b4FgOJ0cqTvVa+HRpOd/tFRYqc1jLaNObcJneM7PpFuhzsXAjWhXu4iArqfTGkvBYXfvqy6FqLIfFCVbBkp/FKfdASDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA3PR11MB8119.namprd11.prod.outlook.com (2603:10b6:806:2f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 07:21:43 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4%7]) with mapi id 15.20.6134.028; Wed, 1 Mar 2023
 07:21:42 +0000
Date:   Wed, 1 Mar 2023 15:21:30 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, <linux-mm@kvack.org>
Subject: [linus:master] [mm/mmap] 04241ffe3f:
 Kernel_panic-not_syncing:Fatal_exception
Message-ID: <202303010946.d35666d1-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="pQQbTQUfgm5sUotT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA3PR11MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac47d37-ae46-48e9-903e-08db1a259a9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvGMFSxGoawdOFeWLDA3AMtgxkSr/8F1++Wz1U6uSNAKgoQAhzD+/Zfqp5pzNKx5aP0so+eC+Zrq3Sy//8EPtSm3ASx4LQ9fddL/wYTdnVGlo0kzbKNsUzAbqQ5k9J4s7+MD0wS67e3MO+R6f2lEM3cE/KYveQd/Mo+MlgUsH5FUrarTDRdjyPhJnkKgjVJcgIIcTRoxLdK3Evh0rhRQ+iH1YEBWJXDyqCDPmeJHkEbfI59NAKUzE7dg6XMjQWks5GAwj6I+cn1xySjzWXHhZsNcPTcRpMSPyiA3JQ/gLBlnNBvNmGRl2Njgyd5V23/6+L8srKqRbfdnBMKOGVTGtf4/Z3Xmwnh/DKSl1TeKL427fgoSrLFuMI1lMk+w/CFhtfLA+yPLKMnwc3wZ0Gx93aFxTNQbLCdyUTpHTEJHPOjFqfzN5YTfsCGi8d4Y8JPu0P52mPnVznnBNGzNzrhZX9T6KXTQ47qN9g+EvZMhITPkKA97tqyExxQ8Td9PlSfj+TPKsYjV09Ctxp2QmxKvbXXJKZCO+FGAy3L7JrQaFYUnOj80Tr2L2LJLWjtRWp5zxYc1vud7Crx2liwOUB01OnAQaN2slQhc2jEJgL3fLpik7BWpBdP8ZsZJPLHI49VN5ltvcRkbuv0jck6fGuY7cw5kR8xFcx+mPkpyqZVEQt9T8hs29K7CEVqTiTTaG8GW9bWCySpRrBlacE7J8g6fzkpz1k5PMo+eq92hjrLu3wk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199018)(83380400001)(45080400002)(54906003)(316002)(36756003)(6916009)(4326008)(38100700002)(82960400001)(8676002)(1076003)(186003)(26005)(2616005)(44144004)(478600001)(6506007)(966005)(6666004)(6486002)(6512007)(66476007)(2906002)(66946007)(5660300002)(86362001)(41300700001)(235185007)(8936002)(66556008)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EyalNlMK2x+6k86LLd5MRR9aziiH4o6E46MjTiIOHr1xWM6I5eA10IgroFxE?=
 =?us-ascii?Q?pXMn1Qo9XjLmRFPCMN1AKTrbwWbx/HxZHGFdT6s0xdnnPmgApgl1XvHS7I5m?=
 =?us-ascii?Q?v7VyubHaF/Hb2qsfKnLQ11lg2l9Z2TAZ1HkM6jNdDUpFEUlExbzmntvVo6mq?=
 =?us-ascii?Q?uqo+OqUffGOFvOdU31Dc5v2stMxRwq17MT+Rz8Qng639C82LJzXX3pjuIDKR?=
 =?us-ascii?Q?9J6QhsWmlA4pJONmUnM7Rj60bgT6+GFNolZvveN6w+u0pSKPjpJO2KKZdvV9?=
 =?us-ascii?Q?NXthbzjNnhzXT68asG/MTABgyf8bQMz9PfhD/TMpzUVTw47gZhUIK6rxmxxt?=
 =?us-ascii?Q?1CAfnrz0ufO50MpOoGZnjp5OLNlS19nH0I+ozRp6Ql8AlS3rIMzbsMwt/rzy?=
 =?us-ascii?Q?Bdg+orvIQ0KqovV+1YdqpUksMf4VNHGh1PYEunlqjfNAqii0yeYv6GP1rn3V?=
 =?us-ascii?Q?QpFdLhvJOo5fGxiRBK333179amQOjOxQ/HOFahMxT2wQ0bb/mXLQzdSN+CeW?=
 =?us-ascii?Q?E6WvK2HOzT7D2bkoUGysRyjcW6xwBIFUceaEgMBwvIHH5OKDmF1ZvngYasBn?=
 =?us-ascii?Q?KJoNb3oEp/bhb5ZpJlZvmUfT1IfznjqvPZLvdbqmKMgIFETAKLNRaMYflhSK?=
 =?us-ascii?Q?/wMSNtZlbo4TSjYQwxLybVEg09WDIHP6pO7Qe720BD+yt0mh/sF0raWb7Ens?=
 =?us-ascii?Q?vRQ9Ast+Al+Ln3Eac2jZlMNRPCx5NUZbPtZmDlZV+w9wbY5FBj+d3aWbVjW2?=
 =?us-ascii?Q?po3qKsVvKm2hA0fgapK5rdcwoFNeyTgixP9M6Sr9NmZrYsShL2CgRgXFuQ9C?=
 =?us-ascii?Q?3rs5GWPTKjoNL2q6IF2wG3WtlxafF96IYX0vAaV1DAbTtLWCHf9G8OiTdInk?=
 =?us-ascii?Q?JHgPXMGBLe9pu/KFDLWVYIEveBxa2ZJO6/06jXVyNtjh7JczrV1qENgwwCBs?=
 =?us-ascii?Q?cn3hzUtJyNc4mp71k4jlxNtN8jhz2gx4dRhJ5oqGhvSLvOYcJE93aDJsgUHJ?=
 =?us-ascii?Q?/48w7p/kg5kNwOYatB7eVHBEdSrUDLB5W8LMbOyfqVSRAC8BboitNaVyFjes?=
 =?us-ascii?Q?kTCNff0slpzMa53mt/COujkuXdj/dknY4OkHnLqfD+emGL1W0Ts3T3dNZKf5?=
 =?us-ascii?Q?JbbnjvHzjT+cPy/+5AKs0hxKqes5Zfj8vm3DUSJAux0F2q4jJA2b9CQynkfW?=
 =?us-ascii?Q?8vVIFQvyw9ideS3ftX8MmIXHa6Zjs7ATniHEhQjnY5dhBBqMgljXYKi++9Mz?=
 =?us-ascii?Q?t/XjqqVjxP8AnZm3s9C4Kz+Bv9LeHt1VZqdDaTJdtx3KI76g32Tdzj0WKBYQ?=
 =?us-ascii?Q?6EDvhHfJTsWK4fW0rh7NGtf2G6oOH9/2eA+ORPNKTSCoDYs8qhotf6laB2FE?=
 =?us-ascii?Q?dJUFWpBLz/FoS3p9memCNdYN83WGZ3TQXNJ8EnvMTLoAKSdGsehJJQRZ3RhG?=
 =?us-ascii?Q?WaGMm0ZPt36rB94Aj/DzBPRvcwKjeNRYZlnYhp0SpgykIcj0mDN/3ba8dwKS?=
 =?us-ascii?Q?MY/OVhS5ztV4oA9VkF1vfWXGG+SJKn6ql2oT6Lrjr0PmchCD5rGSgsK1RHZ7?=
 =?us-ascii?Q?3saR3U1lxYWnd/Kz+HBSu1rm1LpVhHPcVl3mZzxPEzyoIeJUbdAZUkuE2zcQ?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac47d37-ae46-48e9-903e-08db1a259a9e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 07:21:42.1688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRerLDwm2/kYRnoN6DSc0r+gUiJjD9ZNMuJCMf5/HlkOaCDsS6nbKkUCLMkwwHPVLxp3jBuyMJm7nq+QuLXrHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8119
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pQQbTQUfgm5sUotT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed Kernel_panic-not_syncing:Fatal_exception due to commit (built with gcc-11):

commit: 04241ffe3f0458d54c61cf6c9d58d703efda4dd5 ("mm/mmap: introduce dup_vma_anon() helper")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master f3a2439f20d918930cc4ae8f76fe1c1afd26958f]
[test failed on linux-next/master 7f7a8831520f12a3cf894b0627641fad33971221]

in testcase: trinity
version: trinity-static-i386-x86_64-1c734c75-1_2020-01-06
with following parameters:

	runtime: 300s
	group: group-04

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202303010946.d35666d1-oliver.sang@intel.com


===========================================================================
sorry for there are still (??:?) below which we are investigating now, will
update after we fix this issue.
===========================================================================


[   27.110980][ T4917] can: raw protocol
[ 27.111989][ T4917] initcall raw_module_init+0x0/0x1000 [can_raw] returned 0 after 1009 usecs 
[ 27.122540][ T4918] calling bcm_module_init+0x0/0x1000 [can_bcm] @ 4918 
[   27.124271][ T4918] can: broadcast manager protocol
[ 27.125560][ T4918] initcall bcm_module_init+0x0/0x1000 [can_bcm] returned 0 after 1289 usecs 
[   27.437568][ T4968] general protection fault, probably for non-canonical address 0x63f7d3f61dcd64f8: 0000 [#1] SMP PTI
[   27.440138][ T4968] CPU: 0 PID: 4968 Comm: trinity-c6 Not tainted 6.2.0-rc4-00441-g04241ffe3f04 #1
[   27.442229][ T4968] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[ 27.444764][ T4968] RIP: 0010:anon_vma_clone (??:?) 
[ 27.446920][ T4968] Code: 0c 00 00 e8 4c e1 ff ff 49 89 c4 48 85 c0 75 17 48 c7 45 58 00 00 00 00 48 89 ef e8 44 fe ff ff b8 f4 ff ff ff eb 67 45 31 ff <4c> 8b 73 08 4c 89 ff 49 8b 36 e8 07 e5 ff ff 4c 89 f2 4c 89 e6 48
All code
========
   0:	0c 00                	or     $0x0,%al
   2:	00 e8                	add    %ch,%al
   4:	4c e1 ff             	rex.WR loope 0x6
   7:	ff 49 89             	decl   -0x77(%rcx)
   a:	c4                   	(bad)  
   b:	48 85 c0             	test   %rax,%rax
   e:	75 17                	jne    0x27
  10:	48 c7 45 58 00 00 00 	movq   $0x0,0x58(%rbp)
  17:	00 
  18:	48 89 ef             	mov    %rbp,%rdi
  1b:	e8 44 fe ff ff       	callq  0xfffffffffffffe64
  20:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  25:	eb 67                	jmp    0x8e
  27:	45 31 ff             	xor    %r15d,%r15d
  2a:*	4c 8b 73 08          	mov    0x8(%rbx),%r14		<-- trapping instruction
  2e:	4c 89 ff             	mov    %r15,%rdi
  31:	49 8b 36             	mov    (%r14),%rsi
  34:	e8 07 e5 ff ff       	callq  0xffffffffffffe540
  39:	4c 89 f2             	mov    %r14,%rdx
  3c:	4c 89 e6             	mov    %r12,%rsi
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	4c 8b 73 08          	mov    0x8(%rbx),%r14
   4:	4c 89 ff             	mov    %r15,%rdi
   7:	49 8b 36             	mov    (%r14),%rsi
   a:	e8 07 e5 ff ff       	callq  0xffffffffffffe516
   f:	4c 89 f2             	mov    %r14,%rdx
  12:	4c 89 e6             	mov    %r12,%rsi
  15:	48                   	rex.W
[   27.450788][ T4968] RSP: 0000:ffffc90000323cc8 EFLAGS: 00010286
[   27.452201][ T4968] RAX: ffff88810cb6b2c0 RBX: 63f7d3f61dcd64f0 RCX: 0000000000002800
[   27.454159][ T4968] RDX: ffff88810c843c00 RSI: ffff88810cb6b2c0 RDI: ffffffff811eb537
[   27.456050][ T4968] RBP: ffff88817ceb5990 R08: 00000000ffffffff R09: 0000000000000000
[   27.458086][ T4968] R10: 0000000000000001 R11: ffff888119a4480c R12: ffff88810cb6b2c0
[   27.460061][ T4968] R13: 0000000000000000 R14: ffff88817ceb5990 R15: 0000000000000000
[   27.461953][ T4968] FS:  0000000000000000(0000) GS:ffff88842fc00000(0063) knlGS:0000000008acb840
[   27.464014][ T4968] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   27.465582][ T4968] CR2: 0000000004000000 CR3: 0000000118cbe000 CR4: 00000000000406f0
[   27.467580][ T4968] DR0: fffffffff6939000 DR1: 0000000000000000 DR2: 0000000000000000
[   27.469573][ T4968] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[   27.471579][ T4968] Call Trace:
[   27.474129][ T4968]  <TASK>
[ 27.474972][ T4968] __vma_adjust (??:?) 
[ 27.476078][ T4968] ? mt_find (??:?) 
[ 27.477120][ T4968] vma_merge (??:?) 
[ 27.478184][ T4968] madvise_vma_behavior (madvise.c:?) 
[ 27.479398][ T4968] do_madvise (??:?) 
[ 27.480478][ T4968] __ia32_sys_madvise (??:?) 
[ 27.481632][ T4968] do_int80_syscall_32 (??:?) 
[ 27.482793][ T4968] entry_INT80_compat (??:?) 
[   27.483910][ T4968] RIP: 0023:0x80a3392
[ 27.484931][ T4968] Code: 89 c8 c3 90 8d 74 26 00 85 c0 c7 01 01 00 00 00 75 d8 a1 c8 a9 ac 08 eb d1 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3 f0 a9 ac 08 85
All code
========
   0:	89 c8                	mov    %ecx,%eax
   2:	c3                   	retq   
   3:	90                   	nop
   4:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
   8:	85 c0                	test   %eax,%eax
   a:	c7 01 01 00 00 00    	movl   $0x1,(%rcx)
  10:	75 d8                	jne    0xffffffffffffffea
  12:	a1 c8 a9 ac 08 eb d1 	movabs 0x9066d1eb08aca9c8,%eax
  19:	66 90 
  1b:	66 90                	xchg   %ax,%ax
  1d:	66 90                	xchg   %ax,%ax
  1f:	66 90                	xchg   %ax,%ax
  21:	66 90                	xchg   %ax,%ax
  23:	66 90                	xchg   %ax,%ax
  25:	66 90                	xchg   %ax,%ax
  27:	90                   	nop
  28:	cd 80                	int    $0x80
  2a:*	c3                   	retq   		<-- trapping instruction
  2b:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  31:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
  38:	8b 10                	mov    (%rax),%edx
  3a:	a3                   	.byte 0xa3
  3b:	f0                   	lock
  3c:	a9                   	.byte 0xa9
  3d:	ac                   	lods   %ds:(%rsi),%al
  3e:	08                   	.byte 0x8
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction
===========================================
   0:	c3                   	retq   
   1:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   7:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
   e:	8b 10                	mov    (%rax),%edx
  10:	a3                   	.byte 0xa3
  11:	f0                   	lock
  12:	a9                   	.byte 0xa9
  13:	ac                   	lods   %ds:(%rsi),%al
  14:	08                   	.byte 0x8
  15:	85                   	.byte 0x85
[   27.493398][ T4968] RSP: 002b:00000000fffe31a8 EFLAGS: 00000292 ORIG_RAX: 00000000000000db
[   27.495648][ T4968] RAX: ffffffffffffffda RBX: 00000000f703e000 RCX: 00000000000ec000
[   27.497643][ T4968] RDX: 0000000000000000 RSI: 00000000dfffffff RDI: 000000007509d669
[   27.499549][ T4968] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[   27.501564][ T4968] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   27.503516][ T4968] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   27.505185][ T4968]  </TASK>
[   27.506063][ T4968] Modules linked in: can_bcm can_raw can cn scsi_transport_iscsi sr_mod cdrom ata_generic
[   27.508517][ T4968] ---[ end trace 0000000000000000 ]---
[ 27.509861][ T4968] RIP: 0010:anon_vma_clone (??:?) 
[ 27.511207][ T4968] Code: 0c 00 00 e8 4c e1 ff ff 49 89 c4 48 85 c0 75 17 48 c7 45 58 00 00 00 00 48 89 ef e8 44 fe ff ff b8 f4 ff ff ff eb 67 45 31 ff <4c> 8b 73 08 4c 89 ff 49 8b 36 e8 07 e5 ff ff 4c 89 f2 4c 89 e6 48
All code
========
   0:	0c 00                	or     $0x0,%al
   2:	00 e8                	add    %ch,%al
   4:	4c e1 ff             	rex.WR loope 0x6
   7:	ff 49 89             	decl   -0x77(%rcx)
   a:	c4                   	(bad)  
   b:	48 85 c0             	test   %rax,%rax
   e:	75 17                	jne    0x27
  10:	48 c7 45 58 00 00 00 	movq   $0x0,0x58(%rbp)
  17:	00 
  18:	48 89 ef             	mov    %rbp,%rdi
  1b:	e8 44 fe ff ff       	callq  0xfffffffffffffe64
  20:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  25:	eb 67                	jmp    0x8e
  27:	45 31 ff             	xor    %r15d,%r15d
  2a:*	4c 8b 73 08          	mov    0x8(%rbx),%r14		<-- trapping instruction
  2e:	4c 89 ff             	mov    %r15,%rdi
  31:	49 8b 36             	mov    (%r14),%rsi
  34:	e8 07 e5 ff ff       	callq  0xffffffffffffe540
  39:	4c 89 f2             	mov    %r14,%rdx
  3c:	4c 89 e6             	mov    %r12,%rsi
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	4c 8b 73 08          	mov    0x8(%rbx),%r14
   4:	4c 89 ff             	mov    %r15,%rdi
   7:	49 8b 36             	mov    (%r14),%rsi
   a:	e8 07 e5 ff ff       	callq  0xffffffffffffe516
   f:	4c 89 f2             	mov    %r14,%rdx
  12:	4c 89 e6             	mov    %r12,%rsi
  15:	48                   	rex.W
[   27.515465][ T4968] RSP: 0000:ffffc90000323cc8 EFLAGS: 00010286
[   27.516952][ T4968] RAX: ffff88810cb6b2c0 RBX: 63f7d3f61dcd64f0 RCX: 0000000000002800
[   27.518954][ T4968] RDX: ffff88810c843c00 RSI: ffff88810cb6b2c0 RDI: ffffffff811eb537
[   27.520850][ T4968] RBP: ffff88817ceb5990 R08: 00000000ffffffff R09: 0000000000000000
[   27.522647][ T4968] R10: 0000000000000001 R11: ffff888119a4480c R12: ffff88810cb6b2c0
[   27.524607][ T4968] R13: 0000000000000000 R14: ffff88817ceb5990 R15: 0000000000000000
[   27.527653][ T4968] FS:  0000000000000000(0000) GS:ffff88842fc00000(0063) knlGS:0000000008acb840
[   27.532675][ T4968] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   27.536282][ T4968] CR2: 0000000004000000 CR3: 0000000118cbe000 CR4: 00000000000406f0
[   27.542599][ T4968] DR0: fffffffff6939000 DR1: 0000000000000000 DR2: 0000000000000000
[   27.547699][ T4968] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[   27.646310][ T4968] Kernel panic - not syncing: Fatal exception
[   27.651934][ T4968] Kernel Offset: disabled

Kboot worker: lkp-worker46
Elapsed time: 60



To reproduce:

        # build kernel
	cd linux
	cp config-6.2.0-rc4-00441-g04241ffe3f04 .config
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



--pQQbTQUfgm5sUotT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.2.0-rc4-00441-g04241ffe3f04"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.2.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23990
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23990
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
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
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
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
# CONFIG_NO_HZ is not set
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
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
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
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
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
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
# CONFIG_X86_UV is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
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
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
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
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=512
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
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
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
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
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

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
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
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
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
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
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
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
CONFIG_ARCH_USE_MEMREMAP_PROT=y
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
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
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
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
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
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SWAP=y
# CONFIG_ZSWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB_DEPRECATED is not set
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
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
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_VMAP_PFN=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y

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
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=m
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
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
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
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
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
# CONFIG_FAILOVER is not set
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
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_VMD is not set
# CONFIG_PCI_HYPERV_INTERFACE is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
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
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
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
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_MMIO=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=m

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
# CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
# CONFIG_CDROM_PKTCDVD is not set
CONFIG_ATA_OVER_ETH=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# CONFIG_PVPANIC is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
CONFIG_PATA_SIS=m
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
# CONFIG_DM_ERA is not set
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_AUDIT is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=y
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=y
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
CONFIG_B44=y
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=y
CONFIG_CNIC=y
# CONFIG_TIGON3 is not set
CONFIG_BNX2X=y
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=y
# CONFIG_CHELSIO_T1_1G is not set
CONFIG_CHELSIO_T3=y
CONFIG_CHELSIO_T4=y
# CONFIG_CHELSIO_T4VF is not set
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
CONFIG_SUNDANCE=y
CONFIG_SUNDANCE_MMIO=y
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=y
# CONFIG_BE2NET_HWMON is not set
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=y
# CONFIG_E1000E_HWTS is not set
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=y
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_JME=y
CONFIG_NET_VENDOR_LITEX=y
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
CONFIG_KS8851_MLL=y
CONFIG_KSZ884X_PCI=y
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=y
CONFIG_NS83820=y
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=y
# CONFIG_NET_VENDOR_NETRONOME is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=y
CONFIG_QLCNIC=y
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=y
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=y
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=y
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
CONFIG_SIS190=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=y
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=y
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=y
# CONFIG_STMMAC_SELFTESTS is not set
CONFIG_STMMAC_PLATFORM=y
# CONFIG_DWMAC_GENERIC is not set
CONFIG_DWMAC_INTEL=y
# CONFIG_DWMAC_LOONGSON is not set
# CONFIG_STMMAC_PCI is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NIU=y
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=y
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=y
CONFIG_NET_VENDOR_VERTEXCOM=y
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
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
CONFIG_BROADCOM_PHY=y
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
CONFIG_CICADA_PHY=y
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_LXT_PHY=y
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
CONFIG_MICREL_PHY=y
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
# CONFIG_CAN_SLCAN is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
CONFIG_PCS_XPCS=y
# end of PCS device drivers

CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=y
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOE=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_SLIP=y
CONFIG_SLHC=y
# CONFIG_SLIP_COMPRESSED is not set
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=m
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
CONFIG_USB_NET_RNDIS_HOST=m
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
CONFIG_USB_NET_CX82310_ETH=y
CONFIG_USB_NET_KALMIA=y
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_USB_RTL8153_ECM=m
CONFIG_WLAN=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
# CONFIG_WLAN_VENDOR_ATH is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
# CONFIG_WLAN_VENDOR_BROADCOM is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
# CONFIG_WLAN_VENDOR_INTEL is not set
# CONFIG_WLAN_VENDOR_INTERSIL is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
# CONFIG_WLAN_VENDOR_RALINK is not set
# CONFIG_WLAN_VENDOR_REALTEK is not set
# CONFIG_WLAN_VENDOR_RSI is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
CONFIG_USB_NET_RNDIS_WLAN=m
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
CONFIG_NETDEVSIM=m
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
# CONFIG_INPUT_FF_MEMLESS is not set
CONFIG_INPUT_SPARSEKMAP=y
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
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=y
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
# CONFIG_MOUSE_PS2_BYD is not set
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
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
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_HYPERV_KEYBOARD=y
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=16
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=y
# CONFIG_NULL_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_XILLYBUS is not set
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
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y

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
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
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
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
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
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX127 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

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
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set

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
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set

#
# ARM devices
#
# end of ARM devices

CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
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
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_HYPERV is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_CTL_FAST_LOOKUP=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
# CONFIG_SND_CTL_DEBUG is not set
# CONFIG_SND_JACK_INJECTION_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
CONFIG_SND_INTEL8X0M=y
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=y
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
# CONFIG_SND_HDA_CODEC_CS8409 is not set
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CA0110=y
CONFIG_SND_HDA_CODEC_CA0132=y
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
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
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_FT260 is not set
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
# CONFIG_HID_HYPERV_MOUSE is not set
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
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

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
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
CONFIG_USB_STORAGE_CYPRESS_ATACB=y
CONFIG_USB_STORAGE_ENE_UB6250=y
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
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_FAULT_INJECTION is not set
# CONFIG_SCSI_UFS_HWMON is not set
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

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
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=y
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
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="n"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
# CONFIG_VFIO is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
# CONFIG_HYPERV_UTILS is not set
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
# CONFIG_P2SB is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
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
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
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
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

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
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
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
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
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
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
# CONFIG_SQUASHFS_LZO is not set
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=y
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=y
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFS_V4_2_READ_PLUS=y
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
CONFIG_CIFS_DEBUG2=y
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_ROOT is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=y
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
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
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_INTEL_TXT is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
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
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_ARIA is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_TWOFISH is not set
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_CHACHA20 is not set
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
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
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_VMAC is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
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
# CONFIG_CRYPTO_CURVE25519_X86 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
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
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
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
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
# CONFIG_CRC64_ROCKSOFT is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
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
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
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
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
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
# CONFIG_UBSAN is not set
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
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
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
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
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
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
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
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
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
# CONFIG_EFI_PGT_DUMP is not set
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
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
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
# CONFIG_ASYNC_RAID6_TEST is not set
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
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--pQQbTQUfgm5sUotT
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
commit'
	export queue='bisect'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-review/Longfang-Liu/vfio-migration-Add-debugfs-to-live-migration-driver/20230217-165222'
	export commit='04241ffe3f0458d54c61cf6c9d58d703efda4dd5'
	export kconfig='x86_64-kexec'
	export nr_vm=300
	export submit_id='63f75bdb65fdc053ffa7517b'
	export job_file='/lkp/jobs/scheduled/vm-meta-31/trinity-group-04-300s-yocto-i386-minimal-20190520.cgz-04241ffe3f0458d54c61cf6c9d58d703efda4dd5-20230223-21503-s0nn91-0.yaml'
	export id='665d4b5c5282e5b5508a8c0b201738282a545b44'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='yocto-i386-minimal-20190520.cgz'
	export compiler='gcc-11'
	export enqueue_time='2023-02-23 20:28:11 +0800'
	export _id='63f75bdb65fdc053ffa7517b'
	export _rt='/result/trinity/group-04-300s/vm-snb/yocto-i386-minimal-20190520.cgz/x86_64-kexec/gcc-11/04241ffe3f0458d54c61cf6c9d58d703efda4dd5'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/trinity/group-04-300s/vm-snb/yocto-i386-minimal-20190520.cgz/x86_64-kexec/gcc-11/04241ffe3f0458d54c61cf6c9d58d703efda4dd5/8'
	export scheduler_version='/lkp/lkp/.src-20230223-123132'
	export arch='i386'
	export max_uptime=1200
	export initrd='/osimage/yocto/yocto-i386-minimal-20190520.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/trinity/group-04-300s/vm-snb/yocto-i386-minimal-20190520.cgz/x86_64-kexec/gcc-11/04241ffe3f0458d54c61cf6c9d58d703efda4dd5/8
BOOT_IMAGE=/pkg/linux/x86_64-kexec/gcc-11/04241ffe3f0458d54c61cf6c9d58d703efda4dd5/vmlinuz-6.2.0-rc4-00441-g04241ffe3f04
branch=linux-review/Longfang-Liu/vfio-migration-Add-debugfs-to-live-migration-driver/20230217-165222
job=/lkp/jobs/scheduled/vm-meta-31/trinity-group-04-300s-yocto-i386-minimal-20190520.cgz-04241ffe3f0458d54c61cf6c9d58d703efda4dd5-20230223-21503-s0nn91-0.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-kexec
commit=04241ffe3f0458d54c61cf6c9d58d703efda4dd5
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
	export modules_initrd='/pkg/linux/x86_64-kexec/gcc-11/04241ffe3f0458d54c61cf6c9d58d703efda4dd5/modules.cgz'
	export bm_initrd='/osimage/pkg/debian-x86_64-20180403.cgz/trinity-static-i386-x86_64-1c734c75-1_2020-01-06.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export meta_host='vm-meta-31'
	export kernel='/pkg/linux/x86_64-kexec/gcc-11/04241ffe3f0458d54c61cf6c9d58d703efda4dd5/vmlinuz-6.2.0-rc4-00441-g04241ffe3f04'
	export dequeue_time='2023-02-23 20:59:51 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-31/trinity-group-04-300s-yocto-i386-minimal-20190520.cgz-04241ffe3f0458d54c61cf6c9d58d703efda4dd5-20230223-21503-s0nn91-0.cgz'

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

	run_test group='group-04' $LKP_SRC/tests/wrapper trinity
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

--pQQbTQUfgm5sUotT
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4nARbe9dADKYSqt8kKSEWvAZo7Ydv/tz/AJuxJZ5vBF3
0b/y0sDoowVXAk6y6fqqnZJkEUqKwb80apN3hbcKdY7l+gdheREhaDsr6X9swkusSeB2D+K5N3Us
OQdbDEZVrFhICI/2Trx26C4lKn+yuRjMTjlUI17GJJdxS5+v3TO7faN/waP5LfdI0ezXWM/lb9lG
V1LvunlH0PmHAvvcJ0vBMQJO1ZDgNe/iYYTzJQkXJbdbtwBl4mQweSCHbYwoEGMaCNt1fAq5WZrT
KkUse0aCHuRM19R+ZJVxl/p49lMuzZ8jmcA5JZ/Fl9kW7DIgtqnCMgXvTHC/tT2hObGy8geJf/28
8vAZSlvaoIt+z9KsKvPSue5zdGUE7QgWFbioz8gpBphwRaIjCqN+9hkjoW5+aUzIfyS2WX/RU1hy
zAqNMbBciSXMlYkB7N7mLEz0Q/33Fp8lYe3nhAL2w3JS/9NBuvJuYb+7+iP+nPX1L6QvoqPlQ59X
pKBPSNIWA+Q40ZX7Ehd05tX+3tcGvnAa2wNtbvH2wy6NBvg9dkCYlrxMca7vJPOOGn9gTpwRilpc
lIZnsv6OVDTn+w0AK4Vz/kM59zi8wHLP06HikhhocOJHly4K/fK11N31IF6XKlcWmPve9exskvL2
53bDYBwLhaX3JQmWiBVrqql7VPdjmz8qX9bpilaDfvMLHkdpwiw0j7yCA0GtIhHU4G4hw4Twe6Vn
ID7hl/ROWKERcX99/VLl+CzztA8fqJmgc7MCRPXMNF7TGpaqPUUJ5b9XhZe9VVmBmDwuGIyeIcQO
1Y9Zi747LlNkD10m6i80Zl96Yf9VobbZThhNz3VSyS5TDaInzJlbtwzAjEy9gE7D7PyZF58RccWu
8kv1iiiqNr7pEycUOGDHPTDVaCIlP85WvR41gE8KlqVm1CtBIpY2Mw4FbKxjpKtE9IT7yfAjqeIr
I2kkstM8Vn+wLYcgaK0r3Tg7ITJdHVgOtyUPMbgb3iRLUSrv1e41Vv6ficGfPRXHVZdk3dS8+WZo
sIkIS35/VTAAGJKBYDbxMcPyIGOv//ma7uXsF+QttAXRGjpUbkUlO14nhGhfMgfBvt13Y8mnynRz
pwJdS3AH7BMSMyeVGdT/GhUruqEFEeUBgdvBkSi5CHym+NcDBJPI5yNwvW7ht5w26kJa3UYIzM6w
X0CnUSNY7MxrT/pIS56BgnJZjkqvH0QWe8bFVO8ZsA2u8ynvzZd6k8dfDLy6S4K8V9+TO/zCjwlf
PCot9k7sJo2PwwxxDg6Sna1BLlscMMmKCKfWODwUrOQDR2VAcGWmw0IGaUI/CUW50vqLg2nVzqdd
Evt+f8Z28Vq5HljO3Dw61lABOiIq2kCLBpuzS0VMAy5ODeq3OqJiG63xifAxCZmywB7ZlYJN8SOs
yx42+9IVEjPpDb/OlNGwIRbu2k1ZdaE4/qu+36VwngOPL+jho1J82atr/Z8QlhfE2s5+buUKAn1S
RDWcX/KuRJMlvlN+ptbFNeNYQNTyp/o76+dz9QODKJ29Fa4OnAAxjg1xyhPY0i0KFBjUtupx0/3Q
/ri3vzc0s3mG84zaGO3OhJ4DLi6RRrgYCTpyENcZif2ZAcGpPUzuC00j5R+peH8slVZxa3jz/pv7
3IVaZuql1M1P39nX88y4pOLnp2PiBa/OR53oVSGRN8OngOzy5yst5FCYTJebDkGHElfD/HFQVCct
BU2eVAYT3t4CUhN/6XWiXQaXH8xChKsBYT9cHmz1aXPIurLOR8QYCvhyFpSA00IZpobdryWn63P2
rDoqsNlNUMb5Wn/yvviLnTH9N16QI8zyZBRt+N8Fe9iOKxGxrdFssm6l5f2AHJ21OY7vDp1C0JX2
cckTo6zfKESswafVrwAsBoy2Tp3Yskx3UXCJ47V1HrLtNDN7TCkUHVNWAlGiniuzg2Z8yqAYYGH9
LZSnEknYORhDe+6/siYAa1NkC6Qz+xfN52Ku9KpN8st+yfQdsRFQZD1C3FdUc4HOcAsFRaTPlK2T
iGzmF3de1Lki6wfhaNbsAGZZylZhnWaXAb4JmRNNdWDMIh3Qw3jBnnm938am6RxVRXue3zbI6cnR
u/hu/Aam0zrqyxDRqiLOgN7pN5gOV/iX7tjesqIFTLcSejLIJbZOceJsgrca/RjvT6TO7EMnlAHF
zm+6uUhxPBjHQ660ZSIn5rUAwo0lsZiwrvEkXze77n8AdsnOX0uFGb1fUwzkc5OqOiZAZ3qBA3oo
NAjohxllFJVP1xZiGlJeWxZlFWVmuWgbNdczGd8qsuomE5Z3CSBzlhRG7tceFxJdglUmnf8O6l/1
gvNJNriaWoz8ySmlZ7x2RdL9t37MS5p3bKUE1BaRatZ0JJhiYpLiG4i/54A2l+9bF0Yu0BD3iNik
rVSZe3Pzot8Td7rb1tWuFi1qGgJyOh7uQYaZ3wgIGdmDGadbdzB8TEB+VVC38SiH9wX6SFU7HSKl
6F1PyODAyz585y9Wer5QlAieQQpP70nmG2S+KJ1CG/Rtw4hQSprqvf3hP55a5t+idc3ciaPSGZwB
BUWaB9StPmFjfvD1m5CEJ3pnBAtiBG6ma4Zkm7I0uirZKdDqgcBpsNPIfKJu445cnPJjlNg4R6bQ
oyhxLGBmdrWBKD+H6B/hQEj6tWkdYuUCvSLuITBq0Ub+m2sM6uyDwYaUDbNfezWRYlLouH4fC71y
IIgAFOiWteeOtr4M4FgaCaYqK8jMaRAfm8wtbcOb3MdGGjn4KVXErgWbnubvxYgRVQQ2mbV+ljD7
jvq3z72iAyUHKJzsGJAgbMrYPHwMkWBcD9ZwIKu90dKb4t9Qd0h2DGSx3yP0xpa999TyDYRtELyA
xQB1uVhplhQDf5xvdIjAKiAOQDrUHJ7LPdjgHVKnln/6WAZ1LI90w2BrCrZ948HE0Gh2PfkIGf0X
zD7npMVnOgUHnMClbGGSInoQJRikInTYEZVWjOjzCehA7HfJnC4lN1RFbUJmm1YW3nKDRMCTyu+Y
Gn21MBeoF0C7QOYO58xDViAW7yhjJLNZfMYaWP3A1D4RT1pDhUgeIQL2SGlR5FR4aGDj5OJ6r+O+
01NwtyHApXFOELMFQ2t0Aw6y86aW+t6vACL2y5Gzru/MNDQlr0XULPbSslwj+QiCsONiX106fdb9
oy8W1uCkyeXj6vWXFoWTO4kSv3s/+G+KT4bmBBq38SYcCpL402J8NOkH1kHO7YnwHTmOdOIIC73f
ipnr7Y0tgkxH5KkzppWfjRzLyxzSmk4wV8YbGNpXUQR6puA5kNqmum/3KFJiPmwmvNu9KYRHH/w1
pciEeqRNDYm2dr+s7Acuumz+NoofwLoU/EbKXwHrVaRiHulSF7yziBo4xV5MqbB7bIYrJrkCo7X2
YzsdWKDRNifJX/f0JWJxDo86ej9ADbA4gRtkJBHwsX/jFZxtE4Po7RskLTRDZgOgX17pePjSln+2
3Kq71yV3Pau3KpHvQzSDHAAjwRjGzqdDOl3RAZ+mtF7xIv/4yAd3JYD2cbJnZqrbd2xquI4Mcc/Y
7Rve5zvtDwtWaWHXdKK2xdiypaDHyGyMrGqfdiczVUaDrr4YdtfQA+jsjqu6PN3/HgoK9+QKes0I
dfRIIkq+CxRgesYIZ8hL73TPoKo2NQ1i+NuqAEjKQL5igTnDFObMV1EjCcfzZaG01ghAnqDMngcI
HUcZie/cNnaADTPj1vXsbhedyGX+/kzACpvZwSWqrKKTmzkuwRavhs2K/xkNNCMVf45UKkB/3TwM
iKR0TPyNJqodjpZf1mpCi1Q+StrlmyFCi36rhn+1mDAtQjRHbrvcjlYXLdtGU+XfM/p1aYCHvA8x
Brq+QoEcPcP4LarPPxuOmiRWxgOkhxE2WGghF3qLsCMQko4FFyWGVmHepjnhebG+a88j/jtrF3QW
a1QGG6KrIdd+0QS1yKUpJfXVZ+kdSLAcIGfE5Hn6DcuPb68PTtz+iq/5N4qKKGgLJviMlvVu/5li
AZ3eCkRWT/9eQ6aLzW/Aj2YodzvsI7fZCJgWpv6bUQmjeV3BdPm9n0zDLmj91ZhchJFgVvoLJNTV
SjedwpgkEqv27R20dum4aSHksxX3BZay5EfLTbehCvaMmcoA/WSNJwrrowNyotgAg6J0ulzVeD68
TXJzlGsPQ5LjXU0s3SwMCcjlCXxFnmb79x9v3maI0Z9kH2LUDg/gKUT+yZ4j4ExaMc07UEpQFuQ0
jjGK82wM/L+9JyGtvvInpvKQlGc5ZYhk9zk/ppHhtFehRLqNsHmuSATlZyrChsfuuCBwmpAYJ9JT
ihFkYP+tbVLLiiCGq2PhaxnxifRcat/eA00U0NrLcEAhxIMGOgjpHGUNylONNy6QPlsUV2p/VV5W
JHWWtdFACF+QcnpRNBiig4St8outZI3vL8DEJrzzYYMYPS84vYHp0hf+vcwNgRG8mPOelho4BJ9o
Kw+hFk9trUM58C8E/aIKvedF80dJGi9YiQNif4nKARrH+cLEqYmbEszIVXgz4s16onyhWi+aubI8
P2pozzAgtz2ZpIJ/HUHCo+uVKKxVOIjtV7Sp2KZ1Wx1Hvk4kmD5Kgg6zIIwoekNmiQDZNFf2qGuu
0t/doFYN3mtNT+vE+h5qcAAHYKecDqDqN062Ul59Xs2DyS1C6bZvFMC+nwFblQV2TmJC8zQ0F4yL
0utfzrcFm/bQdFVZ8GtHm829uuTGWiPFizHjwsOvtUu5ddJ5NfmdgDRqTK7aUZw/R0PRjLmPLY0A
gJoecrLho8YGGnFN4uMTqJbdO/K2y9BStP6I8TG24h2K0IyyIoDAUEqxluEI3URnAoKsLtHs069W
DBvfB2ugKl4JABRBEkMc2YNMN9lBr0szVuwNs7Xu2opKciXSY6DpPbhp0Uf3ppm38ESrYpVhXz8o
7NnWGork7eFSuNNFC/p88BxxljRVGxGezcSQdEly92fUXJcaoQGufkz510SoU/d+yDVjogNjo1IY
Cw6WHw/e7cgxq3e7gi2PFlSbt453dKUk2+4NOEE4aEpeStbey5TA7GI1sdZaUmMg8hnwggeBXPQJ
4I0Nw0MkVkzQm5r7JEknIjE+E/+Grv2L/zvxxBM1KBzixpIh4SbGhQmCDKKJ1acRg7utMRT/wE8B
zjjyhQFJko86DpcR5WNCNUevkI+AEODPV7XIyRVQrLFX1GpCDSrY59kfjLJYqKgf0PjvPR/XLUIZ
VGxobOZksLRHcDm83DBDM8BVpqls/+jw662ZRwMzx/qUjXAjsqdqNwxjP1P6rATCVWq5GNqntZ4V
YAGA/C7/9CrQcPlq495/MIITNBXm/yG8fB9kAsm7phc5KKtSjkw3KanwP7mjNGXCpcazAi9ha6qb
RA1i9nRPpzPvezsw3z5yKaD/mXJmwra7jlg0FPnuRuGQYLTkCKuHYt/iveYp8U1MIJh3QkdZb0Qm
sK3kPYLB3QiEuvGDO2/rwYUnQ7WafuPdppYLDrE16LI/GSS8CwLIQvvLzYzmkMKsL4bQJ+Kw7dye
G5aN1y6nh9Yea+Wmpz+vR+FwvH0dW/FsyIl1g55mIlFjxwP636NXjCYyzJgJKvL27o69nJ8UDII/
MUiCwziWVQyrDCWzIkKidmMKNmo7xuFsEks/Y3y6GZrrOsFWT+S9rPoN6ywO5UnE4W7nPZrdL6o2
HI0hi35VKkTDrNxyBg//wH4SbD/ozj5si52t9Ryam66Tp85Jui2t3v1vG0YOrXjcItM1oJ3lwHOO
rbJPRLV9gEAfuWTny7Zv9MWegzkQ8bktIKbm5siVzOR5g/zwOvlqfUA9sE03sUsxgVj7d9nn3NXi
ndpvaxK2qurHxL3jvhtYBvo71EDQmk5w9e2sBos9T/LGpImwwlL8Vb31QfPtvHkw9qnbAUZVAipe
c/9VWzdOuX5QPZchLR8JrJAwn7qeIuW1ng3PxN/MAccA1Ge979B+l3l0f/H9AMaMkAg0JE5zHIfy
7GKzT7FE1ktjZ26LM/MtvB5482+1Jb8aoKR01U/erC+iCpNXjVAlNsUwWcZHGA9I3OBq4v0jnz8k
v7LIgVGoAYcbVwRjuGiYJLsmlfT5NN4CmVoLm4kqmGUtzxy/LA2Tf+AfaQfTCZR7oeZYNBDi/BGj
FrCQ+eWxj2i+p48hg5ZJgoaNJW1LlFLAEoO1VP4OD5t7NZw+h5hUEU0ZhQA5ADYbbO3k0K2exc9Z
q9TrR0gcxfvkAa7lDjLHKHjnh/LW2Fl2vWweDNcEGobtoeokqy1MfgBUS2Dyc3fK30uKzd/6uL/m
TTljv2Erue/Eao/+sI3zsOGexnKW4sg1wmDxPLTa0Mp2uQeRk1MIYrTly5Nkll3HMnrkfuBVOb5U
G0lun4HLCmhHYwrEpnw8pWuFyI9sMDMAI83D457YXJjbyWVm9uJQmw4MppFbFJl82ndE5ZzOanz2
rKmaS0EktoD3DSSpyl78F5OlfCe2LIG5ewjeKXY3nu4w22ZolHDzK3AXKi8kcaGPaBm2eiaotvtf
tnk5KCymqRZRLEGiEd9htJjJv5aViKpf543V05hpD4vVLvSxPYM4qKcCPMeSHwJIpcdhg0pQRKNZ
jlZCH5kaKlvVS45Fez5s7ZdMQtgs2+L7NeSFU4rlf12JfzboGv54Ce52tZw0RQYAKssm9NVPkhdx
W+ZuR5+hf4A4UUyAvueiQY4q/HKs/tjSJH5ifqCk8RYe/3iyTFvhEUVqqjD9DlVW3WJF/JWZ27FB
5r3GFGevbJu3ni4Fp2mMcbnPE+1eHIuVxrZAFVjG9b3pkM+fRNE1MDp2yhv+jbuil9gYKsUgx4Sb
eMMPUoChzae0W7RoLJ+HIvZcaSSyrp1h9UoYVzebfGszl0ZEcyYocn3/1ZCSh/BiSyvEo52M10W8
Bqug6gs8jVFbRegZERD2pjtcPCcSa0Qu9hgjzLg1kOv1oobh2Vm5vuxnCX8UG5OzodN0jX2UfS9O
2I3aaEKYEM/herEwGbcQ/wSS7YDXQw9sVwtQFNPPSYYnvscSNifjl3Qh4MpdqH5iCfHZxlJMBZAV
gf3SEaeGJ2WOgX5GcUOXh0lukfib5/kN8OBN9VhsRnbpjZkTt2zrQM1wHvIzalmAwWVMuy2UkPH+
xi0FH+GWAJIRV4oPiJrabSofrAhle47CFF7LU4+rk6Xma9byp09HFOH6W0YwYJ1ZzoUDIx/dEC56
jX4dKaJr1l0gA7nOYMfNcfq/ilcIXVtcljLZdmp+q9BkaSR/DieNXDEBFEkPTL0UUyNx1PPyHdhp
vnZDfm0NZWhLxrrJNxXbwOcx58axeCkPET0gguIO1kK1C+BQ1jz1dIyxE1vhmT0BtVsePIwKAi1F
HBDHJ/vIRbOQfHgYQfRTTaB53f4mBrOyCOP5viW+ixYVkcjQxtdzFzejzhUUgWV3khKTrQSqQG5z
ouiX6fIXU7JMI+Naph1GYWPOkoknSv3StXJKFhYxvf83DGR2v2Y1bggSjN7bNkilBmFntLDbHJxJ
fam9Lpt52EMnwHZRMoHYpOJQDVMBQi5DVi8WwZ7dOscFTiKD2oP0aF0Mm7vgiVy4sooYLv1gaNa/
5ySwHAHGjXcTMrBBcPZxC7VPunqLT+s3xx7cedgjPlmMl5bDqXFPDWUp9fZC6alUOFHlqPuUugCY
Rf/CPn0C2IM9CSSlHZdT2FWt4gYFcOf+rGGcM5wPv+FIShPDtDQ3UJo3Ty8KKMIoFv7TIvKY5Otz
KriJ5guZXbUYxQG+zWnaBT7nbysN+qYBjWB1Ix8ijklNbKOhOiIueg7HH9TfBJDPkCnQpTtNLmME
YQni4T20nX7AHLIc4K1EC9VKXVPI5h2JNPD9x1amATpgY6Rnsv/fB/yGZy94ceCv5k5KsUx+F8aJ
zcdZRdYQIAYcZ459Xhj5c+zSt17IXAQ9nmsjK3Q4VoAN6q3bKlJYkR5RkFJeh4MxEqu9Fnu0BFUn
DMjAn6ZR3Z43Nbq+tZU4PlCj+tdHTHTUbD2axHQzL07XkXWxSXj23DRkI4LoqFJS6PDNYym4NXX/
rZYsALjfISrqRJ6THUvAJNcmHWTaAU5aF8+3WaX9CL2T3cD4xBvI8Cj1/TVvs2RbBHw3WzvbMKnY
h8xdbiqUlTWS9Fp9dNkovOz0ZOibxkEjRDV0CPAqoGHITSm2QEJiGWAKFdXhSdjOjz7y9qKVCzYq
sGmJU6PsFFlpsLxLErpEc/y5jLOJ4KijJCYj2iNPKOmfUGoRekjMtNhSrDn9bZEtFl/cDg3f+Rlt
w1h+Vwq3KIVonAZInqKvud+Oe/VXBwkliyEiV6S2Kgx1KMFfnCwJOK+WZCcv4keG6QPd2Pr7Hi0z
p5XR3kKCoqjtixgKmu5k1ghrwh4ic5ngF1dYPkhkBfvJeglJc38hXk62CbZ2O6FJJStxfj0I/FDz
wkZIHXFFjCSsUili4eVV4rW+o3SWz6G7ImQ2l0O4plmC5p5mXW7WsvCzu5t04g0qVRpSBcEC7wr1
n2cqHXGxaVau86MALI4uHkySFr0AUwmFjeRZd9Zj8wi15kGxp9j25u30nTVGQimT7T1HYaooKxmz
6jGc0fJfYdJ1MPeuuicDyazOSlzulYttAORgypwRG9/xnXWy/BICf5rPHEaRiuONSbQd4BPQ9OkV
s8Al+5RoQXQATuI5L7mw9rLO44/nI/M1wHwtWQE+1/v7q+uXqz0arJxdNc7TwI5QD5XwQQGh2EXE
YsePva8/Q0bw+KrHRE7gfrbszldzbZPg5Dc8U5qyWkzlzCRaf8wXWzLXG5goYdGhAx0HItEuQD+n
Dht+nBX1z+UdhFYjukTsPDFKYrSpugcQ8pI9Ic4Gw9aJBpihsKGZlkKOoSsyxamFyPUe7plg+FS5
oglqypFRlzgucakidYnW2r5MpC5HCmxMTE0ZcMMtzspIikTVkpj/AzUcyrQf9ByaKSQ3m3LNxs+2
BaWoIPw3eh2dKE1Ma24ACHoJ1Dto9GokIsKzF5voobdL1kChytV2QhPMtZeUJ44cPeaW7bEtm6kf
qdcfj41BmOvcvF6LVYyEj7GGZUq5dbSeV7kEvc4m2bdREh1WgfCkPqSAoT5kWe4oHOrU1SIACN6s
ztdvvu72tiM2TsRLd5hbA6M3zLrca6++CY6sZOafZkXsIDwKRanFPK0N4oRTBvfykh6am1JvmjL2
LuWNCyzdh3YsKnwXxmkwtO53+ZNAsSeyOzCgyvtbbx7VgOY2QWlSc9jfBxJe/fJ/9Wk7rnX89b/B
txy2mXAMDR5nVVSK4Pi4cNvyHPNnna06kIZ7vouC8ycCmjPgRuudkJqPrp4nV/whvkKxPJFMi8ux
FX4aMckfcu8x61W+XyWSwvpTydIHV8AWJdqpWK1WMDqpX5E50K3OTF6SroUz5aBu4TyFkfd6b0Vs
kPB9TuZwdyIFVSCaHAb0IutQORLYGjivF2SbwsFjpNj8EkpnmODRbqLttOfmwxrf1MfTq4bCNGVx
kc58Pe7rQlT5h0F0B+0qXDGM1rgWoq2FRXbE1WGMGo7lZw17WO0JHvSDgGPWmrJMaBLn2cdw82bc
xX2K/4oVeB7u3rOvDDEg2llztbcdSVrP3XUi80KemWaFd8x+aHf0QOfE6XjbUBbKNhG6KfJVYf5d
ebH3/xKWM9y1Ez5rZHfwseS8CNrnfxbF+MPIG1gUdiHuSR8v0CQUmYXIL1D5ixM2o/6zzALv22YF
TeNg60EmbRDuAXRITulBBZOniCuNM4wKFBNidNgSK5X/MfuqDpHOay04wj7bUVkYOPxFhBfEc/4y
nUDKRK+7K0C5RjumVUxs8bAFYfb43Wg0XO41emp/G3PvjFQcmQiCLLTbaNmdJYehp2WCCvngy66P
NDs0xFWErLCwz8XOIk3EfhZxWi6luO5E3sMSpBkxPK6qmk2dpK/xUuLWtew57Cpwi2K0Vj/R5sXg
K8WuZb+AjWM9tuTVL/SFjYJuxOYN3gXomiQKP5TGcmUr/l0+MxRlKS4YVz7kzhdsZicIG/tQYJGQ
RMmaye4nHwa0vWQPfhEUaX1HdKFO4TRpSlcsqey/GlPmST0MNL/TtG0LCdHuYzqyDAX9r7t/k1A9
F35KgpglyFHMy5Zd+a+KrT4ALsP1oeAq8PfccSQ8bQFeN94NpK9WHkX2BdVHk/WZjWrV2bNTSg3l
OWd+BFDBBTw4uPS2gNKe9+Ev6NEoQvjKzHwa2uA1SZ4thANKmY4emlFxlQFyuelZ+xZtnhxKzjZ6
BcGZkWsSVDktvzcQ5qo/5KFVcIqACln+W2umsn5YGJ+khaiycJ3OdH0hIPOn5Nm/gihcXlg8/Gff
5ZvrGor77Ayc/VQBgcsSfajikeRTqNz2e1nRaHkyLoqGaIPnAWo1+soZ3BDRORQc/Z2Q6az3by2u
qkwbW+ysMO1pD7FA1bpuQIWDcyPzZD+KXn21vN4+qdozRQSzKvzckpQU4Yv2MDIPiypIt1Q8gm2+
v15ea4/11aLI8FCV0SFU+t6Pj/r6+ktNQgtxYP2IUeCYU5fwP8jQMGhceFsw7f9RatgPEynxVjiC
mA17cHJkP3RFyeGJUpn1Ev+tOw8B7f/s+XkSAoaVWOdM4xMIKKMhXJi2qr6AfLN9fKjRevKPEOYx
s1vnzf0DukgMPKOY1LczX/bDH9UZPhSoKzdgamy5WkRyad9YbYMwAj1AsYnpCuvRE1wC/FGQjaBp
0C0OpMvW1qja2GTvNy59Pxa1icwlv8u+JAVRPIotEDwrsBVg4VkzN8Y+/1aqi07feEPS6kvcS89+
HgJk2troogLbTCMJCLZVh/OtzFMButyo7s8oEzPg94kNrKPNo3E7eaQyzXm7FmbpIzAFgB63UjpB
3mfmVjUnti+SqfmKN6JY7Pyye2lucmprtDPO7876plwoC00+IoO21pvq/mNBGXgftXs9b9QhhzrD
pZJ1BOk2PaovVEQNy3EPBkQ6JJBQC20yKEP+3ztB+FMAEuJL8OrZDJDYvFy4WSojz68//9rQsdCc
mBSBlbDOafHjx/K4lnJEnyVNzqc7GCB+BXZmu8emI4MkP3TTHURPZMrbRxV1HMUzyiq3hhxwrIJR
WufLb+Nd66qPPzExnzG3eFSv9VimwoAjWaTIWyPGZYhiEJKfBvZd1W+Td3YVu7tNYjp0Jll7Sg3C
YZpd+gv+eBiy/mIDNGQS1p0YaBw+7wocbkZnZw1M64OTOgECWVDy0BXGX71NHJx9Vb9N3sc/otXC
09AQLhtJldGOMjjc8H9lpLtDgITOMaq7ZV4w62Zj4zshjWdkVqDE3Wqu/rFvg7D2STbBkd47Mxo1
/Jxw+2qyKv0J9gTwkbwN40ZCcmT7ETcg1X4bY44XEl9AzkyKw4YiH2bEP7WQjtKuKNe0sO0FbIic
v0Cr3YGykmoBlmVfeW1fLG+F839dlnz7gZ9J98OQBOTU4DxkgTMLagDm9QPgAb60yV+VfsDimsYv
JtGO73M9DnBJrbZxO/n11NWPlnabVg6Y7wHHlFIniBRLddHh4dnYDJVBLal1ANF9GHGa6nt9X1Ot
DUDLNrgVZ5v/5DbxSgLrqlehPODMEs5NqEYPUKF4FGlAxkQ7DN9om73V2QqHd+2rUBYRttaNQxpg
r79/g2Q7x1qfrtYfzWPBBhGmETZbdEMRY2P0vd4jrc+YVCYyvXxY2h6CfMHFUrlw/MkaCRfD58De
2ZRcQeZjpTXieKONcEwb9AJamUymmzTnGiCU+NN2LFxnx/zuPuOlrbNTzu8bxNeoNRbc8afasLJZ
rvnKJ2ixjvD/3/JoW71YvGR3EfQN2mjAEALvYZJa1mn2E7HUkt34noSd7v4c8+iQOHaRylU2E69x
zLjLX7ZnGcYu5ImoSLWly8DcKOhftZ0rR9rWTiZwqAjXsufF/+CY02IfNcaA1o0Pgg3fB1l4LzAm
3ICCCh0fr/VXStB3h+1CGGvn9x3yxZy6JyKaUyqpx+1BYXw1ou3blJ7Lqjd0NFPhesMc21FzthW3
D1xSmWApeKQU6I16j1uEKDvthr50H9rGsAyI4We/vmB8PGNJ5NuPbcY10MG0TwPVAechEqPpkM7a
ttU1nqhDsdLH6w7qwSCoSashWo7w+ZSCkPDSVaceuRfHXoby8KfYbTua7HlxGBFa1bU/o008SWkv
0i6h2RNgUJ7f0vmqem/P0Z20tvQhN1r7dXW/WZ4EzqZg0d3ff5VAjfvXYMWQTT9N9pB5l6gx27SZ
iTZ+aYY/PBwCGlRoes+s/580sIJw7lNtbvOOOYFXbZfnd9+4oRU6C9pbstYYeyAfGGUkqovLjFeP
9PQdAM03C2+l5vlPihsi8FkgcBHA5iOewSgMgL87oOeVgd8P3fT1jIEn4RZyxbBSikF1UEfB6Sqp
e3n4QdK+8k4VemrBSmpD4cEwlDwl732W29I2Jh2GOQ5lMHquA9pVU5ZdrL3+LGwRPXffZJJln8IG
KBAx91c026SJpJGUBZrZJaUSNOGPkN9QMOVVCVKYrK9o/n0wzPtX9i6cbGVNsWmfd1GZHFx8MKLi
EtHfgtjirqGy1fGOxjBObobRYAk/gTymTxFZYVXt5YnsUA+BlR9SbuYacovmySCPi0frPRYUV0Am
bwVsd7jaatVH4d0aKvsorma62A4FoJN/0t+BB2fdJ31RQXRrY6HnIHSQ4Epu9gWu/Eaxql64Gw9h
I+Z++qUWd6Cj81csuVyAYAoOn+r8nYIo3wdyY6AVk0UYyn81ZQZGsjOXzTl9haUXuK7pXV9D3uFt
rmIECoKWv9uFkTkafxc2mBDn3akpFx1K9Fr+DLQGPk0gd3fL0opRv2OhlBaBoi3d5rH5K1CMqpnt
O5TfRiUfoMUO3ADxHMC8EYniA1b5TMm13Km4Bspc8kiCnuHY0Iw/g4aRZTRBnAPYjcfm6YbDm5LV
e3DOZWapR1FuK73voonTPTFZWTsG2xfQXlvv0jCLBTELVfkRADLtEA9zVSpxCgxRIlmqunYDQeHU
TTY6L0fUfKobf3369jRxL+ytwTG/l/ZbsBzwK+v37EErmol9cP9aq04PA4+6DqMeLjLa8i9f6XgD
LxY8A/sI9mEbgu04pIeP+jc/UsSCDVKfYMtuue+HsMdCMVSUOSzjI3TOMx+qKzyLYlhIbeXf0uWM
w3cpoHR3RfuCj5392ewpjw2q/vTRerKVtvkcolP7uImregVBsgYtcD2tRH9X5NyDxb2LkI7C8xHw
4QgqJuocwGw4GmVmOyuGTVMceBrwU2nFRAvfjWpJvU92rxS0T/AEcX65ai8g+0ORS8clpXp4L7wD
zpun0PBoFEBZYhNUCwDK5a4C7gDaVUq7Ui4IK40mwTcfnDzEaOtGJFDoT1qEV9qsVkTSrJN4NCvu
Mt7fll8bDQOZ11as+Cfz65dhjZkWW/XQnOl6ZgOARD8mL5gG79DUt5k/I+8PjiOX+VO4uhGXq2t4
ht0qFg+ThyZ+9IZJWVtW45igIt9d51H5uj8gdQUnbmf8EXYQ2Qx/S+jAYGEqE6e7nXNqNBwvf6tS
tqDeyX9WvY07chQqog8N6jei0DIT8xr3QMnK1TP1iW+jWj4XMOVUfiJb29KSn0tdLFRJO/atdX/5
lKMiScgxCFww3lXgC0kSmf9I3Jcw1TL9ETlm2zzwST5/bhlcNlqRM33yu+acWsGrGcaZ1ccQET2v
Ma1Zryxb7csulhpjm8Rjjh80JeOKGq8+vABZsE0pdpq/6ph4FG9vVRtIWXXSMOc/o8Mosqj9ErSB
v6jHFC+cE9E9K4VZwQU5IOk8+BEEXiFXTrI9JQGJwR3to4EOT1k+kQ1NxsOpfZOGiMxWV3YfOs0B
RzCALBmDnNPp+HeZUA6tOXaOWe5Gf0F8FRhO7vpBJ25hRkeQW2a0lwcK/TzugJj1cY8RVHzXOz+i
CxzWPf+BPbm3WIhcZ4sgnY6twlw4CRIEm8rCK36kAQDnYhv46Jb45IdD2ROwyDjKW8b1DTzIaZTq
04Xc+4QkQVSDUaoX5uWWhGDVjXYuFMKF7BFA1/Km2cXT6EeDCnup18NtpUbZCgce7Cz/ANITv6W/
6WnV2pIvnhs4ByKySf3mYay7m9XcdbvdPBAyHOCGTecB/EPxMwHj+2LsKeXKGm6ZeJRZZou5/kpG
STT1otemeizf3WPo7hnlERXnI753NDY94hQQ2y3X7TwqVetJqGSwidQgZ2rYvStdxwgFfM/Vw+25
qBfc1ZyxjFTkbXxb1pQbOyL1r0tMxZMiKc6kDLII52T2PEPlq0uNVmxnN+EM+4Znkrdg7nCMk2kO
sKk5wKOWUbrJCHSZOi1oPLKJ+F9kMV8LN5GherLJn3xqS+HMkgnmTRY01MNdNMVhHRYtVA+EY8AF
jLSEADotWSuYD6P9WWuISbB1FhCOReOoL2dQi1qqcOx2sh9fJxgumeT9I9cwLFALbUaPwRzHt8Sq
xLJusRdH5LSkw9936+jDR3dwnHPjKili2QGev8I/yG1CuioarZnBcfE8WhScresiFILiPNrsPewc
cijYHKNWtWcO3DcF3QuMPy7KBMULnP8N4i1WwlEoVlr32lFhYmEd5OqSroWVDI69eg0h3XXE0l+r
1yzKGMK5Ad3lA6xPB2PIp0Lb7gTQxGmoo0lnHJvRo5W5Qq5Wov5Ys97Id0vKwcodI9zfccC75op4
EedbOryFUWJQr8M3ni1d/+7UWdo7wYdB7Gp9ggPbKyn1nKvdid6vYWn3C6Ls4Q6N/Gz2o4AIeXVz
kZxW4YHbfy4RDznvATRRvoxPvY/z9p7SoL9UQN00DXNgcw59Y5HkO5FwwfmxmBlYEUTM483un38x
98skOQPDNCE0+j5kwU34WsmHtx6uu285jzPICXRj+gVq7/wUBYuavLPqzYwyCgs1bu6Xu6BRlihc
H/nl2i7N/asB9dC24LPNFWcOtxBEL2tu0CbPbwNhRgBwIqB3sKB7tVK71IOESDwtARKz0ac4wqGu
TeuLbi2LMLN92Bfo06U8ACcBf9HeB0PDojPGSIAcwkcqMML0aDA30tAN3MqDMu8/VRQjGH6gSi7p
aKAZZtIKe+Z3eh2qgSRF32pI0uHgxijs7hX/KyvCcuzHqs6Bt3xsQeQW1TqSe7DYcYufMIXdVlMM
dyDgJjl4yJWiB0w3degdua3OXMVYTexvKdK4yMDvzDDNbxDGJkCN92UY2KdwVp6e6kOgu9PaYjgK
Wl2tYKwGsrK5b8iAjXyldHWSIpmOsK06t2/TYCwIqCro5TV6wT3EpcMOd9nZASYJt/ytt/e9SrGp
VI66NbkKvh7c3VLJL3WtQz+IywagjCFnHXz4b2GZUyKsl7+8JEwtqL1oxfVB4tCK+aT8LBU26ZrK
V2bl5XCU0FnzidKh6vd8Nb+Swto2RDD8zn8NeB3GV0KVTisvPDt70x76XBAGVPY6uQi1QsDC5Sdj
gmo13tVDjHwHjyv+vzYRYbBbF0hXaSpQ+WxVfEpNOsSr8tqgWv5G3t1OvNAvIG2RUV+hPML/7uwX
LCA21jPzM4+z43PtL4UjRawvTeeCHRu8NtbqT4gtZQ8G0ygp6MqHWseWW9jybMjnI6ZeaR7Z77Y/
ip/Mi5JjNkergGBceHdjl6IlEcKcFE1Q7Ri0IPAqElFSq4dMD0/BZrbaAoTYjrfAdBmHQPNfQHNv
i/RWusW+pb7AjJYu712yLFU2DWF6VLzPRJxIlGOVbhvBHNHeijQYdiT7pjMpQ2Z25l0e8nb1p5lK
c3+iFoddtmEVSe5vSlZy2AdMeZEBP2xV8QtlTpi9IlpncU4mHTDdESaa6nWb13DULq77bnaLiKD1
6kLzw5+C05srxecJNVMXIZi0RrFbZ1ivvXW8WiN+xffjDYpVa417279siWHdAsjypdW2FOeJIycJ
Gwn7LIVugW69ulxRHE4P+6zn9WyCeM36fdlm3pRxuALI2UiAjENo5SPSvaShSoGrEHRdjOs2QZxo
EEhDsMJK3raWz+8fVjJHiSfHrb7sthnOTED6/hDybmPrxkxBz2ElEvUr++cugXBfCr6Th7RatYNb
1RwbY/ywOthTliQVk010Lge4gcs0BMZOYyd5053DpJykv8RKtA9yMdka9hVi4OGV/ybKsHhp+VY5
aEMOR0zf6uHPfsHL0lcgrFTe/M0sd4TYKaBHDSCg9hxMP9diHwETNn8kGGMPkXBZ50+3tu1sbxsJ
wOUUR0mnYvdreosWUBInLZRFwcHHkCtjpw+8QTql2r3mUDxjToOKHXv8cY15Lo7i04qRSeWcHePf
9NEq7oZRxewJl+H7PeQxWgbJslSuZ2vgHLeoGOFhApZ0FST7U6bcf8lNPf/eN4R9gCdY/Vfp/mmQ
qRIMVjYFiVMA8o+HS2ch+mE04uw0f2yQTJXKhNlhQVGcSZ4iyO6MjPJp9IOWbVMZYc0G3DD7wDe1
FYOnPB8bCMWQKkcHI4xyx4G3kp3NpI7SWrVCPKVFsKRsGr13pzUQT4grnC0b0HInYU4SUY2zAo08
yJT+4Bjqi/w2EAbt0y0vMdmmgDaEaS9NF5AysaXhfSLPHAczLWW0+9bcMAVmUstMEc3ZqjRd8gEF
9OKjdiRBxmuV33K5TtWemh8w41HsW60az2NiOzAPA+VUomPR9LzjCiUmnJCYDeAziTqLWeK2xEks
K0qcwck8glkE87HLEZgN5zMEvzxTBdEgdbp0tKwko15qeaRKJGvkDwY1VUmOZwqTDJ04np4A6vD/
+1laNR60BSfKgZ19bRbXbbkx0YjXvCNUqDNJGT11OK/VugYsS6SMsH7ddM5NUYpHs+mL8mq1vDc8
ec/r5PYakTZazTnMkNQB033MKjFBX8RKmQJ/tzkXYyKjg6cnO0M1FzHxC0kv+xW4KnGUBrdGlnsF
x+wZGYk+IPOfokBfZdMt5bdItMCxbWGqrqUYhOlHkoxR5gT+fDxsCNyMfXhTkc8W0nocuZ1qf7Mu
AK48F+SAb7xD4wC4u2kidiND/g0vLgD5Yo0fA9pWEuScsRmCkKWh0HW0MO6Fz2GOm1f+wS124imN
aLLq4hj0EF1rPUvHgwizPsLLs1/wGnrBTt0HqU+lcBs8zIn7hyezoO7uxCr46v/K7N4JrAzQZqHF
r0zBJit6woXZTG/fhoydb9APsCfbusWpo6uTeter1EZM8oiWIELhECfsol/uPMKJ/PlVMGDuLsWv
OMRKqSeALDZq94z6ux8pPgzzi1v7HbTOWnnuXE774igH2gduYR0wEKxf6YuGvcwSqnZ4o/5PoT1y
cjRD6rMFHGPLZeJ38/vO1EegA/HqpcKWBVRyerV/oEhGs7Klimvv8rXm45mv51R9vgy0k0tZNUEl
6ImxoYfx3JAvb5b+UFwML35eCey/ybauj2yNGzrmQQa3G69pETLMK6Nr1AOz2kN/42cUs/w3KNo5
SYeYEE4jU43gmDiZ8x8M8T0TxZQKXEerli3FuoFdPR01cMf+m8oWK8qKyBP9/r7lNqnFyFaISXoE
q4XNibqdWuWAKnmEWPDUcs2r2sAYK6vC+UdrJ4Ey/fftO9BhfbiZfEV9y21DyfHECsmb1hJZ5aA5
Cz38yS7dNuuguMmiOtZX21xQsbiQ/ELYUcyLQESLEu6jzdI61QPlJNBuSp+TlHCQ4MXPeabblFOe
XbEuawGu6SbFtdtOaJ2l2LVwgtJ1yioC8vITZqkEYpHZ776vu7lS0+p2709ZQdKLhb64YI6TKnre
gJW9JdC8uY+SpfYpVpeFicnIAA/aoILqyy6GHV2Ci79RRdzKqtFBFipvzDmF6nDOR1GClAqNWW3x
Rgh9cxeXx6Ur9Gr1No3EtER4ZjI2XiWayCkdvnob7vcx4WXckHdbECqjBGiIxKM+OXQ/ZNR9y3WY
ZrD92pBTFIPMubBJYdR/T3BGLUB9550cWdBoMvfrmdNfer291JqRdVhE+4YOUWDTVLKToUpTWvIi
gBb6epf/S52y2rtXTIS+gPWNUl1IleHs46hXrLS7DRHXgkRR1nvEsVJQyLvaOjE9hMaJgPICvhhg
ru5CxvKDwUoIVWCJvaBvnz/LLEuy3XGD1y6NZ3G4v9Qv9O5ist5iPEdePNC1dSQdrWtyOch8vZ3m
8Ne4K1Qm4QoPkJ5HHeMbnaI3tt6Up+zK4wf5bK/HhpusqjR+cYdjBARXDY75XrEwyfilNeCyHfTs
xyfH3q6QWCDyCyWd4iqR+F3+MsFowNNL6YG1qZmdw1RAiSaTUKTZklGzhWdFCn9SRdmtIHOOE9qo
m8431ed8mTjWcjYIsIqmLb+RDSt+Iy/55MfzESrf6P2l14y3JnzyxX8UZLxw2y3oB5zqWBH59jGR
NFXq83V8cSsz++KKx9YcF8pgIqUDn06JcJQIWojVKZKMg80RYkIkjXCWpC5IzzB8rnspOvpVmpZz
dh41OSHR7DYi/oFe7m2BpIz0ApGs8oATanWiZSBC8PkXhhtBzltYXSc0Ty9l7OMxJmd3GLPnJydh
+MElWvLsmYev50Qj0DDMI6vBMXpOLLpXMzwD3pJYkpobmmcyWiydzQTJknh3R//5xo3ZlAwr017A
2HKMuFplBON198KyOzLsqV/nnMPX0aThI0tT4XKj02+F4HQUaFd6Fq66TfU2WrsOURt1X3K4BhPI
YtRaVUb4qSD03mol/n9kO1dOgZ+tUSxo6goqt4cZr/HCIE5Z9+QJatd55iYnElyRB9t2lOPTjKo3
W/MMSNM16lHEUSWntef8BP8zunAArbIkI69xfjL59rIvsP5IfAPiPK/72MUVOU3aS9Izjk7Zgu9R
oXGyyE84K3ndcajEWAgcKHy05wZQFspJweA9Rn1fNSPejSKhu1ziXKj9Dzx3lwROev1nqIASr5Il
Uwp6JQHMfPpFWruGUK8tcKp1HpDSNik3PBO33rCTmA/7f+BN7hpXJsLMkIXCB2k2S89FHG6pragi
xDRftfhm+9wb46b+E1qdOMPCHEgpvbvvbDkTrXSc+0GEDtA7xPmmn7wTL0NGvrjjsKUh4HosoyPz
9f/4GMWWfLzyduEogV81a5pr+ctlgLUI3qfhYdAs0PXC0F//xqzmhzY9tZdILkIbUOkxStRZGBNX
g7jvPoondJAR7fZcCRBrmdOudlxWEdM6In6v8+hVDUs6oOEwZx8m3bz+dtyA0N7GjzRcwy1sYpWj
Ay5lgn2fTz0XLlvU30IyNADnOibnIczFr3a8QTdZO+vNGRi0FRDMeFgV9W91vjbWd2/oT+vuSofF
Re7ZgH9YkioTmgswl7VZVs+o3G3V4lk/D+ZkxQQ2HImQzFYxkHE2IVPnPTWMwl0PmbhVFhj95IOd
bWvfJhWtypPFCwXTGHicU+/cyFDFU6LVj1k//dnO3369xyDkkO5Fok9AyMxz9bcz1mkorMUYKddx
pDXKrvkiN7xCJ3QiaV/QKGBNSnURXm+FBUFcjllRU7QZiJS8wylvpfZAI59lHo46yx5IVlhmMbhw
xjycqw41JJ0XW6Ig0tAM2IAi1mzAGq1Xq93GF28ocTq6xFcWfDCeu93AKqKTaslf4u4d/C9/uPeZ
bi4wyp6ge7tohjeChNebCxZu9Y9cugxT4TUjGvmxAvg6QKpZKRzFDooUxRdtJqyUkzQ/ZlfgC7m9
tj8qZ9LMbnKR2FsqrLm10ToLPcDw+GDjQWT7Ugu6j6Tigqvw7ztupGqH/JIVqwUkxS36aa/hMREB
nCTlgFi8cE56PJi3mY6jeTg8xl2OB51eMUo86c0yZ2bAIe0SfIrzIApPTjaqCQloeypU36h45i0n
ypUXCgFfXllnsmuVbagwr+COZgEuf+Na0MiS18+TAplaB4oVFDYZM+fwrTivnr36FN0XD4Nm4lx8
2uJB4BAewt02ohuuFRvvI2yYLFP8vMuhd2ju5KP/LkwuZX9ApQO6M87Ly4DhxAos6eF4c336wYny
vE8SniadMzPSXK06WvlCTQoZQrgsuyxIbWqdYU8cOTZM8DN38xRALwB/774mSUPkN8Gvht3pyk54
i0vUmCrEzJGt9sk/o3f0E8iZrv7X1TwOC7I3dhVQM6b11mWJYpgCDg5Vq/qsVrOVzYteJCQGXrKo
aaoMl5bKN2UMVYIRMybl9m9Zs1Cz0s4jMqlfH1WSqjUBMkdVMx5dlIlag12RYCPrIneoFdTEfiFn
HLQ1RssC95YNTQ46L6rH/qm+IsGgptYZ4556X8hc1Mnd7tushmM09HLkTXF6VNnD/fL5IYqJOH20
cBeq96k9iooAazSimHk4dRdP7EFpe6JncjcgE3imb7Zi39ZcCiGuiUAPtcammp4XQ0PlnTVVyZqc
dV5sjkOhBB0ORjBGSX7Kj70uHfqxeBKIuJl4/DF3lZJL01NNIzmQrA+5QL6UG1tLWEzHQRE13uYV
dEQgVZpW17l0FcLzl0IkPo4hovLQsWj9udJrUTkYg/GV1lWrtHO8SwPRDhzWI+QdAQzslVyX1Nzc
T7VwzjRsZWApLhC0zf3CypussgvqjZVFUsZGJ/aGeqAbkGd8KYCZpLeFhhNwzYiOhaarGZzs4r8y
66EqFRBWfyuADTK8/EeghJSt04/+LkfKFMkp766oTzV9ylaDh1rFRB9g64z+DVTdhIdBONktfZgz
dgGD8C4ZeTFV2G1AI4RLcwxkJc9ob+MS72THQmhOpm/kCsCQze+bED5WRdDQCQ7yUckxIYzx0X92
Rx08k+7ds2Mnhvzy/0rYs4x89dOLWE19d9o0zDZWI7nXMNy6f931FllOCiCg4nARMZelN2U9Qv6k
BdxutZ5A9MKBE44AETK6iYItzkaxctTP5atbWwZZqSr5bk8PLyPlGF5IJv3L7JY73OFyCwvxL/Xu
KauVn+nbDOs/WJ3ToDQXmER4s/w8yvWAdDzYWMj5Us1o2PcyNZ1Pc1nszCxebjoAFDnzVxTA4SOj
QlrML7ad7QMCDwQ1KLbRCJatSfPklq6C1TmHqbc2Ic7wY3wD1sGbSnpu0yb4ds+gFfCQd3YksoMF
auy4UKEW3MYbXIhTjBxzQSEpO2TqTcNuhtCLharauf5fs2Yud8akWTMOgoEPdD+0TtoQ/32aaxM2
erObn4gx1xLlLOhEjK/U5gk+mowJE1FxwmzrESSJQnq1I9J+lIsOlrsOTN0JMv/IZJKhlDDema3z
W/7rDlkY9E00gR1klfX6gSsJPiIBJ/LJXRk7fkkZoU7/XGSVEBIGLwVkqBlx+s3d63x2uLZ8lLvz
UV57UoK2JCifv8V7QyEd9MgE7AwHiOrWEMTl/B6845jR/etSKsQv5FHzhe8Jrd1BJC8OLOB7NRJy
z/oCtBFZ6mY+cYJjITnIWoPs2hPhkjAf6DjjS1jFMElEdCgA9HkPdMTr6jhum1gTvR/EoZ91e71I
9Aq2MjSSY7UIwP/5aDXcyVUsLoaVaInL4vi2Ml4mP+lfeMjGHd2MJxwdAzLxbueBH5JDSkd0BaRA
BIaMqjoYXH1kt7yUP5pkcypZBpbUM4RZpvr4eXGj5Dk3AiC16MGNpFrlZlmwz5gBmsAYKxAATcBv
1i1k4GqBwgpo7WNTyV5D4XYta4p2jmiT+qGAhNnlbxHwuQq7p82fIK9Rfi7e2fBwp9R0meMutzLH
gr9N4n84CR3M/13uuQ5wrmc8jaHEuhgr15TRL9rdugtJsmuYTgxLb3CESDhm8waYLMhRF2E4lYD5
gkWIgff/CQf91PWD6KHfM2awv+VdqFAj5KrLlORzLAuwLblyJ86nabKBS+8g3LwB4HfOc/uDg+H/
SzFTjhgHFFol1m9hTlF1V6IZjPoJNNHEG48TonIic/XQRsvoptm5/k55HQU6skqKWHMC5BMC/RM9
P3jFdqETcNanEYR6pXKbJbUXt1/fCRb9VDIEf9PbNEO2uMX66vM5dditfyM2Nex1f6CE2xgx7sJT
JisS73qjwSenrpELJauwYdvaJeq5/vic369L9We+0KXun0y1NwaNRICT+4JP5x96vvQKK9BOOHsF
rOjdZl4XTD3haskAxnA3JT+87r9RU0PTmi9+Ynf7AWUouDYcG4dmneBuOQEv/cCcweNl4oLp3sFQ
rvhZ6rNOLsneMP6vnTEHI74rWP+J59ktO+YvPWZz4zMsAjhOjoIQQu5XvTN4rkFgH+KeU15BzzjC
AP1yLSsCfVykNXQbMOEcscc0xdsklbBtarnzhPGZrOjq1NA/Yv9HK6PJr0g6gen/PmA8M2JrfCYi
6MLLScM0E7XJK+G87fPqfoGhEVHNnNlPhnDcPZkp7FxrBU0VhaCIcx0/OlwVJwmhGJKB7BJltaJm
RYlK77Fiyvai8FMG9skaReSliexeQbljx62/titSrfWg72DU2dlAN0Nfi/FGTRkHFQtv7OfIbrzb
nY4DYBHUcuOb4hR/CpSOkXdK+Hz1e3ViIES8kfWQsriuyfp+grDWBmet3SsLXgIoenFlQbrkvJuT
wFQu2mME0BwZ2Cp6IP5vvHJabeexkgLltL7FnvjdXhp9OxtKwVJNOLyjypPMKe6jWE8EkBAN9L3A
diYy+GzLBPjjMXz2wUYAK0Pa69mePAwWPB4K5UIt4jy9cfW1qiLOOk3P3UgL6cEz0DxBMvln0R0v
SQgxJHpC2evgvlTz47cy4XsfpnfO46vh/5eIKaTYlQOIXjIS4to1d8G+p6RneeqVTjIXkL+JMgK8
Ew10D6A4wNeOxjCphig/rBvBXE6J/DMRQuOxSxjjEu3myNsDdkqitr0kH67SPuRwOlxjV0zEF4qQ
MlXbEP1D/pQWmlQ+YIreio41IPfbjUhRFWELwJp6ERCuHUJnT7kV3VwGB2WX3cDRynN+mtjuofNz
j66EjxH2QWJBKIfCfM6Ymz7IACioCecjozQrJaz5vYrynWHqNXCUPPJv8J0B250nmxuwNxMUmNi3
0utz6zSELk8Y52KXDcu1maVO/AuaOFw65cdBcBkXcdQ8HN2o1EDE3DcZwN1Snpv7vKLIXagwDdGd
t9InqCQ6rV3nTgRGcannZnoW7oZb8IsjWs+vCt6wvZx/JT7h9N2MBgB/yJckh9yZqttvTlGc4x8B
LLVd1C2CB6p7GJSy9m6mpYz0d9TRW2rSgcTbHQJtgzhsac3ON4MpjDdx80Z1E2XbiZ3iLRBxdfao
5hIX/tuGIwG27ddrRzVbKyE3J0y21KGj2qfWMsTSjYKYWKprdfHuQirBU0qqXm1F+thaiCkwZ1uR
dweb0O/OVYntV5ovQxdiQcHnRyze70ZTYWuEmsonhMiQv7y8PuT/AKzy3V/m4frfVp94Zkbi0jWH
6mlT/zKIhWe6NGAxgu6kPpbZpGXWHv9RWc79KYRHzXsY7GJkMW7fi1BPoHk2AiMR0XPb+cuzq+Gg
YlY1uLaKUf+xiKGbu4ebfMivXoRRtEGXANg07RaDQHuv/K3385w/3mrQmy6jHvKvaJEtPkgOjUcy
rKp7NQBbWIoSXKM3iE1Yjb7n/JC0nO68ysYbGA21k0B5mkdWrxW9ZIN6GsKwkiKbelVGWroxV/bO
JIwpy7yEohU0J07tLvA2LoE28UI69qtFF135+W72zkhLpBhbG9qMJSCjT2kZhHWuGjR8R2Fg5dto
+GqSARDCiQhv3iQpYJxgRv6r8LQBkrFZkCEb/MMVnCfihxR4qsHc0oxQec3Na4iqnh15jRjZeA5J
LQRqANF5BhHKDER4CqgLmybN4DagPzEoNqML/6fB093CN83GQps9+GCYygG7hOpd5jQ6vfXE/UkO
KTZtO8MBSwrS1Urdf/sped4kJ0YEhrV4IUepQTj3YyMfsyK+yv3KwMGrCo5JeWbiSWZQyxMT6KVP
z304xBEmN0jAGNXH/Ic2cgS7iCaubSd8TSDMzPIYd5cb+xXMNtJCk9JrPHegq3zdLAYHGthIDbTL
FkAbYh8hZdGPo7KuOXeiByz15arG3PuJlFoNNFDv8Iv5HEKQ5oVjLH+JD39U8+xmR2fs+8YvMamr
4kRhHJ36q9LVGoFNlTZRyrKBi2QbHxnc9wowtN8hir+1/uHHALB5MLnVKcUAGfT6oUymodX7P/mZ
dw3YISZOlbk3Ux0dnEtA80G/DeiEzl7WAx0RUXkHAOR3tRXqoPgIwXPMTElvZdneyxeAH198W+s0
MskQZTGq6ns1ghqMwicNc7tDe99FHW0WsU9eOSoW/mopRY9yXi632H6IlOkSHVOQk5cgleUUF4xD
b61TiPsH5H3w+HjSOfsYQ1346sci2A0CaZWYvzm8iFZ5ycgi1WY418agRp8l7lXGFpz4QpbQH2s2
mYDk6dAq/OetY/2ox5IFProKx0PPfs9csICI0LJ/RB0keEm5M5Xpbbyv8V1KOGovelGelS7lPdtT
gXyj1jxtashaeIRnRxfIaOYDu0nooprz+Rgv9MLZ89UhrFiy1dMynheN5r7lAgE+RWW93BFDE8ax
zy+/WApoPz1YtekaxoAQvrwtSHJRPyNwuoAe9MMtRy9QhEVYDv56hAfE963hb1UDJE0jmxPalO8N
ama7ViBEZJKIe3YUGaUOBvOxRqHXGAH5cpItK+68kVPaOnHOexFO8Dl1LGpNV1i00VUNLGqaztzG
kPDKZuoDNgnlUvlRkEj2uEDlydlWHz6qoUftw9OsfUbw/JUm06TAmyPe+SQJDknuQwiw8Oz0j8nB
oANgP3z6rhcm3NCakrzP7Zip2IqdnvXu1crLr5cbFIa2HtE/p1+1u8jWKAr/zvzUs+9y/yQnLGpn
x6akT9uq4Y7Lk/0mAMHIyatFjQYjIm9PUTwluDQ2la6cURpW/wtJuztpBQH+Te/mZTm7k8fKcFTE
ubKN1Mj3A0a6D4cb+UblEyWfnaw9EM+X4J3egTmNyb/T1GdlwFj6zkKIrZEYUXv46DF9NwNin13z
a5YEscOgEc3WU4hQhj4PXOGSjx2Z6h7ulYMaD8E1KSELJ+ovKiyJvdaTNef/+mm6g3wwbP0Cmfd8
N2mthfqnROFaxm3uVb6g3pDpFPNTrueKjFnprilei+EX5jYVugMmyGwApKjeG+7YIPM5TOXZmgm9
JnrvS1aaE1VsJcgLr65V78JUju+O521yZHHS0Rsr8o+7qhQNntWCeqNJp4JyAj11/yo/UwBNrvuh
splBPNhkPyVfRxm0eUABCPwt477dUWOTMCRe2pbD5UdQ3WMs2uKrQsf45oZHXzijBFfBZXzrD1sp
K5PsELuU21ekiCIrP9TOtWj7jtDGT/WY6OAPCAIsV6HBcoU0h1zZvMLyi3QGNRNk2zVz4DUe/oL1
bF+Ato+rmp1ZsQTfhE1+NOJ4RkU4ud/yFIbYycj+OkUEcxTrjkQ4PFhSXBPX0YylQXZQyZmKiQ3D
bqcPjQuHT4McShWheGEvavNM5Bh2jTRampEDsFrLtxANBJKB/zpNDRKn6pVHBM0MW33zyhWlUdF6
0j8++ftRMhNxT8xioIrsr71SiSiUPv8dfol+KtRciDAN17JJp9aWgznUapKR/6/BDIgjvKr4PnoP
4ms1+4xC1vwajQ68XLwJ7/55vF20gkfAyvrfA7MmBwp0Emc8KvP6JgR7awcVsbzr0hqWcxR125qr
eW9J+q5EeOPuSzYn7qARw3Ab1xVKawwACi3ndLsZrMwBhFxr5fdXlh7X4DFBuSt1zbUU/mzscgu0
8bEOugOnmoMmK3h6N7CDdpkr6zmOiqHNVrgx2Nw+2289F7X35nmgfj017IjlOvXvgj36RG6HWnEb
nfmGdQdOCfeuaWZU6jkk023i4stTsAtBZHnod127+EOw4es9Awu3x9NegfUeod/tur4eFx0FbqVk
kWIxhn60+P/qCkCKSe2KXAfse8wZLPy4iwS+kP29YnXoatKeAluhQGRxqRAvjpLUMSnFy+c9I/8a
lYdm3Rh9xkn0CvHiy3bgrtUUgREr7YMYw3cfBZbU+GdWAkl0mEdLzvjAdKEsqDm/U/sk189XAGxg
2Y3Gb/Y5dGtt1bKhhEB/wfgDfiMCec5Wwdioe5jI77297p6SAwejEvo1f5aq3INvvx7q3Q62V/Cr
HU8/Ub+EqfNKKFRWi7uayN55OcdhEqOCdeq9NtGeLYx3l1lhO4U9BOtnFa/wslV8EFJOWFozEW6/
RJLUyTKxGGWv/xXVPGW6nCpGGmJTCxfFNFxTtz4V6x5e4d6qSR2+ivTuit5Y2SQb+sbHOV9MxGOV
xRQtOmtvbKmjLDPHYr+R9/J6iF69hGVJeH2SPC51fcrxZodesU9bnMt+nxLYj5au27CtXKZXvDTh
on7mHKgUGw5hJeyXyFlX7uIW6PUvder7bfcmfZJ3i8A5apygwg2MUtTmUbA2SLbBR7ZM5oI8o10F
xxL955PQvXNnPVLpe7QhCMDvO6wOQZ6sNXGyQpUPcrNDVI9CVZflQiY73GcSaPfqoVm80BZG1TZs
siA2QpZ6PEPhIWz8GdujcjE/oGHcuf4Zs22VYOFGA/6QItEWPWnRRlV1Sv5wzB+vBGY3fmK3M3wC
ZKb2smUKS2HS6N7FBpFoMftWplYDbZfMzMvj0PnTqwdBVtN9/j/x4CW4w9J8YcxiO4Isvc4XlTqw
zqeqfq5zaHH4Hcq5bsuCma/bozW2co/ctjxabC4y5y8mhk9FfEEDb3HnHBEx1aAsy1MnbOdooJEm
gHcUb05Ca2ZHVbiaSofdcuA/SM5I23pdEay/12fMjAAd5QxyVxSU92Rb9idLfTMqFUqherxe82K9
tqiLQHcY6roleTmFZWv9rsNBL7Jw9MJsXEPc+v2II7x2z90WfJmXjrQnPDIAavmpRamyZDsY6pb2
l4PUVlD1Pssi0/GFG/bGUkNWCaLHqzGqzPTacT6YE/QfbeGvzxErhqgYik6zX7ohIebUET3N+Slk
My2bnV7sUdBbHSo8acu+vd/JQLkFdQCbPPljabO/mEfxdnRG7YlnxZecWnpGSY+QkmUGuIwrV/6+
/l3vlW8jqMg/UbW2feayBF7Ob76zfaxvUE+0hJ1FV/3+/EdvShlu6Xp9LYXu6VMwTxMY3u2bzcd+
kUF+dGSpuM5lw3yVGOdKy6kHZ0Oa2MCa7JVGTeOtPM+mop4HtguPyggUiAdAQOgkeWi6T6Xv2YE4
/nD/vVCOQDt+GsIdR8w2ykX3revWi0zsrxhJLdxEg9qwVumaC/SVYJidtMJDRdnY9Z+gz3+hzylb
RJpzlDFsO4sZgnpHYiI41W3tHfJj6Ksagoj4fLhIbDCYNIc4BVjBo/9p6g+RBcf22XyGReSpvD3v
zYtAEsnCK5XeXkNPZrW6/ZekC54NdoeryP169euEmCGDQaXonB+dHF/j+z03o2tU3kKJ4z5Lp/C8
vgucL5yE7Oo1wRXk7fyrUM1uS6JWY8AQaKc+WhpsIIUIHw/a1Tb7KQcl5A3Y8oUFzYzcgT0DnUS1
esOMV529C34qAral+w3cfy4KPscfgEqzEJdPFQwMqbwkC5Dgp4fWDvfJzjwOdFPWip0mMp/1f4Kw
raKQaC7tBcGGb6Yi5nN44k6bBKVwPzGkTdyxZBV+WkPDm0HAubRd3F+UmFOczUyZQsvBFPsAcDrD
ic92WlNaAjLkNdTWRlBGrllGiXKAul5D67GpioQfPm/GduZrecqBE9+0N10eRq7n0q6ASEW3GAX6
NrZnLGyxoutpZASmb9hHP17EBIcUkxalVyHxMN76/njL0QtWzddRDY8PUIKeeHVQyoUOAo1tKUhm
s+y2XW3oXXhFZGHahlbjgYL4auXh56oLX/t7OvHACpVm52dwJtvoKCpkekwHgF4bkSpTSqY0QqzK
LmjB3ILxcOwplYaoUGI2i9Kv47MrVlmN4D4WzzyK0/sr1q9kDoNgQgIpsA/6fqjByRXdFqSlUs1Z
Mcn1/V2f3lYiwlRZf4qRwlImQetPAlPNjgSuXjBHpwAj48XN79up+ILK59clXRuJa+vc5jwkf9Ib
psxq7y0iAqMOuM9qIytC4amLDX62/PhfKJkh8Uk+ENTFlOWexXaR1WoPsEHjjT+BkaCEubrqhKQS
oXNqPwJMglBQshXS0pjwL5d9PL4eLbVk09sMZT2ggi8VmTSiGd/L6t3StnR+67MMuEh4D+nKfNST
rnzVRfmQ0xnJddVXp6eL62rRP69uI8oIe1S+eI5XEBkJOg/B/rtmj982ZGLcE4V2eAR6hP9P25GZ
yigW8TrkUtcGaq8KUVrLP/MeMLY5VUdGAmFvLbKqbn2rmpgvI9nYuPuHm5aG7aYoXqdsa79vB9OK
qzNcIA7Sj5yKcMzBnZQwQrDu5sDvtqVgZuxR1+0lxiSGJcmholUFeUa+E0oq3f5B8Zo9PVfCq0Pv
Zkk8sqKQNUfFH1QQ9xYXUQx6Ro7rrS/9gjF03Py51bpsb3VgXQtNQfYVHEopU3HfvqQ08C0BKOwB
uIeh6zjHAESP4YBj7DJ/eCAyl6jlRSKwsqnqmMGShekKEBnmSl6TTyu1A2FWCzkBzqIbWCm/vw3d
VOihMc9ITzGG8d3u6sVJUxuhvdB6T9ARbwDugnly3MOswc7h3dvXko7+02xph+QGPjUuqhtLuavk
oy+nFaqG1aaThCIxBwzm5D8fSjIFabBYmIRpyUt7pOj9DFGEFPJ1FC/9nNHdBi3bnMRAB7XLV8Rm
sUmLGWpOhz5Xop92FFcuuk0vmuQutNWPCWfW81wXn2a9Upj5Zrwdi36N5xvl3oMCaPq3pkHofSvh
rGGCAk/WHfm3fxCJIcAp65mjJl3WdbnHvZAGimY8uMhxdRPfNgKFvVf6rOC1ioT1iA6s8QAmi9lZ
54KvS7fbUtoMa02sGJnWfOAUsEhql+JhOIXwY+rb6LtDQWQsURYKQp5oxx/OJL4nPmDgu0d54kiv
rdBRH+onf2JvjdR35zltMisI3zKwUdcr0wNL9m6QQhB9EIDjOazc59xXMNa3b26WAV2NnLrJ26Rn
sQCkHIZfaJttJYzt+zHUkfRtE+fMFGniBqJh/HVgvVawj3Rh3qtRkwbiGfHH02A4il2LmUby1tc0
a+4Db7k6VmyTExaXmtXbCbw1iZaTZsYQkqJzU9pvdxIxHTkl28Z51FZzAdNFRjmyjuvfFwNLucuQ
xcMFua8xbPh8/12esdbzKQexnTxw/fioi9Xz2boqHN0rKDGlRXiBHj0VVQV7FKJtyF8OpN7NPI5I
YToet2qC+1m8H4yleOhcp2H3AcQtClSpSQza7SYW6xeihngsd3eUOILAUG0Gi1T70FLa5Kx0tzmc
NBp/4mddoRL7emUPVhB/EZlTlgJR7Bxgr1zVmLaM+B24AzXn2YNYFDL70N2C8/OzAYecGfx1edMC
bAK7FezWAjM1nUXyv4Ak9Zo4RqR+8WWmlVrYq1fZNwYCuJYVUy/FlqbrBYlTdw3o54PulXKGO0CG
grYJR4V+qVWdbipsHkmyShAs+DtABqlKmfRXK23G35l7Xw0IAkICGBVv5fflUBgnT50J4dLwGZCJ
Jueklam+qLal2QHojrRf8MgSmkOudLl3m5h/kxA3TYxcnBq8GQsHhN3kDTUE9H+NcxGuFfOGCbNT
X511xfhq3iWz4OHyPuZ/GgF5QQX76q4md1RtYDYq6L2vHXcplk+ZnPDvUt9i4AvfMMNew7fJnhWp
X05rtO97Qis3RR93KqhncKUcZkONUBWVt4C40oazaVHShpbEqxsFFFBm0kXrflwGkfVOgG00LNlf
A8RxeDU8Ux71dGx/amtLwztwjKuQfJMZiJT04AanlVCjX7Qdzg3/yZRGCEhwcGq2pBvGBko+OrJ6
hceU00Bl77WxAecFw0mYZGYl+foXdx9GLOQ0QIf7OAW8Sb0iUHX1+5yszUWkNAwBd74lI2/AEXaX
Wl/pFJ/CoZHMluomM6QqTLcc/J1Y24FpB4Hkd7JrSR569W6oG/gwCLzaQuehlz95xe9UwNFlTZ5H
4Xiee1UwsOodtYwcCCqSN7c70Vr/EM07xFy2Dx4dVKOIYzJMoCl8wVEak0fm/xCzYUUqzW7the06
oN4qbtrA8Ojcnfs3BUWZnGScGa1cGXib3CnL+6YJSXWWXdCFb0ktKb27nO4NjowFt6CieI8AGSYX
ULswdyfQwfw/zvTp7Wg4P9yQZg8HBjqj5viRCVU7AbYLtH7Racf9/vRBJHm3Ff0v+J1FZ/F9t1ri
8W4UbV89uG0RPYnmOxrUM5wRTGpTVIpCv0n+zX6xN2LRS5LNp1G7W0mtWIqQqSwLsXYZyfrSVYpE
xzsUtKYov5HiXCnXNvTaRT5nJKmcSSWn65W2l3IY/cLFWBphFjeAJ+m+2B8hL2wfo/opTHkWZH5f
iGtSYpfEpYD4qw0UGXmqaBv1+gfmEmJMBNrcibsRrw34bbX6iobIi7MmUOChq+nBAMMg4589iEqu
2b2XKAIpzPdBXggSbI/K850MkAemfUT68/q/MFUMJBM6RGfmNDNMCK48UCMWwCo3GlTnwwAfLEem
DJAcF+zA8m9Axfo1TZ3m6wr8N0IPffBirspPfLMSb3AAq2VGDjdFhzeCXwmOhCuiRW9AXpimdJMo
6HWsLdTDEGLmWzWHQ7IRqUZ9+GTFxcFRQW/5NcE/uPgtDQGLbAFR5Chvkvg3cgiOKIFNbrBhPIzA
EXi4WiSlOATRxlS73AC0ZSc4GLc7J2MWRMZ+8YjhnnRLh4svoppzJH05Zvt/ylB7YI/cS7yCE5Fu
t9QGlm6AF/aE6JWflRltc8uHO31cmwHoEzqJ59K+7bf2m/WlSo/5RuQMQuaF1u09m3XDIvmL43Fv
QDZtODuMYsHE54qWMCHXmrlBCzR1mEwPvlCigwdGvx+g9D/39SAKmipfS4Lspj3EuvEkBkDSltzu
i9OJlxSCyXtXm972VNGHLM1DDmU5QM8FvKfKhUWyjqApG3UPgswJfn0movBTxU9nCsPN2A5RKqvk
J/760SE4nogIKenYJlfeCWeg+UN8J5wqNw4OADSc4n2ex07jN2CQgJECiIzuJmPChtFejYppXpiL
cc8wejon8BNEPJPpMHCwdSe6n6NNPJDIAaoDex+Oz/ta0XxNc3KwbtIqLayY6nGUCUJFNl6yoD/9
GJCi6E20QmEK1oIoigdQpAu5BasCOv1YzlbbcCvRdpzeHHYTtzEUfZtgVM80K2PWkwB87CpWspJX
aaBN+O4jfmbiP60NH1qUv6WrYW3Zwn8uw39iCzzveK5UZSMQXs9yr2Fu2RJyzaGsN3KWNaoV1dLt
Ka9S6CTMsQ/0p+s/ZhHvOcYqIhpqJMZOxE/uacvING6ek/SKAJrnK6ibm2pTZt87uzQTT1PgpMNd
PVenLE3ix9U/az0SjgE3gvgBLubItG6Q/+OFQd1ZFMmFqPH0V7cydlSswD+jwsMf8hzB50h5pu7Z
fHmA2gubnASKCgiLpIaCp/H4hhD+ThAsOieJuhEMTr6XH15tcNyGsQm57I+yMxZ/zq7oHV22cS3f
gPyTC+tDZSi2mXbEp+bQ/cDlDYH27OzqUP9IwhcFaYLA7qw6Vee54alU2zLuYEmbCGtaFH7BUzAf
5YHnY/1YBpqrysfxl4EC/lp5a5AhkuKgL1XunIrCRbpVvWQp1vovcSyrXHM+VaPOnFAMjy/xXXVJ
up2w+Da+RlvHgp7xnhHy9/J4VC3vmVpU7fwq+gOOnz0lFU67tC9uPjSVL27w76zT5IpRpFhRj54w
8LQBz0BkPXL6NeAMJbvTt3M8Lczso9HE8tlyp/7Q6AX5SJGawO4dGYPFY7g4vWBaw1pzjL9cd8ZF
WPWbVsbz5lrN1xw43RF3njXim6YudtFKPvUV7vIlZtpETIscuB4qle3VuGMoGmUtx9DP78HwJKAP
jVDgRIXk6CBhM7aidDqh9jeBWxtoSn9e7lPRDY2O+RJrSmNpXNgUZkqI4cinqo2NecMURlyu4dXP
M81s4CDBzNS20MnWVsyFu5vXPiCDhuadxwNoon3+ptRuokP5+LmwH0Z9E7gbKW7WpPhfIR9jmXJ0
kdWEDrq0m177ZSJetBIOx04PoS0Cs4jV0e34YXC10vp+Peo0BC6GGKbMF/wAfLeL4ugHf9hytUKc
3JMrCOcEuQ+3zURaAr6W/9GlukWGmNWH1qTczb79uiA4ikix6JogAxnUYEcX9GTakaoIMhcfNJkJ
lVfMI8GKxJIQnlpwZBWcMjoAedXVqPTSGJYLoB79qiHuLaHw1knRfJLbvktfrDz8OSJBvgysVT6I
L9ytYHJidn3mcD/JH4HTnYsZZNVFyKPrTbdLxQxDeRXuMUmPqWGsLPWuvei7NO/2nGXAIIROKtEo
8lT51f1ZWCwh2vSElIzmXk2Mu5+lAFpbYsTMMCvGguTRS8oyuIdRoL4SjR8b2t2AY9j4QUMc+FP5
HbDENsWtZfBFYonTqy3K2wNSyFkvjO4JVzSrzPuU1+PT9VKUf0sG7Go2vnU0pFfs6KnDJDHYEGDR
4TfPGMPT/foNSi8kRkAfZtPxVvHmHsPQ7FPl0pboqpnDidEpEsWMebT4yhWVoKk6rxL3pmyXOnBB
dh9z89OlTu4PF9KsYfRtFCeHIUh7J/K6HHi0qjUTI+pZoEIzz7VcjxtZKRgxlkPGm/7Q5g/rpJlt
HwsOWWpPIO984ZQ0Z4G89R6JMBz8ng27sgG5ownYZBCtx3TSDo9bcMMI92A32C83QXVIhz6TraeN
Qw7BwvAzy/siU/5s0ZDxOyROuU06wcY69SHOwrKy0C8F58uW9orqQ3yhXrCEFQi7GGqkdTgF2uid
DuXLU7eVDFnPgv+sSI9IWhkogWsvyuG1Vf9dKbi+wWnMmBxI3P1LmskWT+a+v1WDs2QAPz0kprm6
N4Rs1iE0SmO+7ZuNND31wAajisVW+5hXxHJT5p+S0ldAOcMPTsx2Q77CKI1ZvWIvWD5Ni34AZGCX
qEtacMntZovIza74NroGJDVNDGJszveC979bxGGVMWbK27WSBXomEyRAPbN0L6xECQrJFCM2nD3E
3dfoa8nQuuRq6fEPb1ln/zv85LL0km2lHfeSyYizbiz/9NzVPR+0FZZaAh7MnMSKdNZzCOqY9fss
DwLkocYblBYbNDtQFdaSDOBuIFmFu9o2u9gYD0yxKwP1KQrM4NPdzyEUv7CoN+nr1UydoLcxEjx6
g47Gy3MSRX0NnSVN9ggcs7i79dFMgbYdXvt+b0CF0etKHPCcUKK9ratcO5VFxFNKXAIuiPD1Gmnq
hDA+hTOAVDokANzT+p9dInZx+CRjTp0YdaEPZG3brVa4q//aBJ6tTqgPVUQEP/Wf8m9ohIeerI5J
BLsYgaCGiG2VJ6yyYWiEFZ1oh0qfYjDdeMCSsFci5TYh/WRmPgsKv7u+63CII8I8ridA97CTqzzm
Q1Th/uOK+xiyoUGkp5Kg4FA2zXB6bpATC24oj+8vY9qx+vRW0bZhZA1kwKNHm+aoI2h89NiP8FGR
Xgp9XqJt7fij6A86LHHtHwU5z06Pl7hFadyWHpMcjurkxH04spTUz/2b6rqGK9iYarTYIlgOoXRm
AXIh0sD/7ceFYp0g66YtEZGY/5fsrPekROJQFA3UIzV29l/BxismIHrtiz0zgktwGCQXU5aMKk8e
zRsl6uXtxsrnRh9GwTGzADEDvQtCrURJ1MjnQO9C66J86TOBzltd0AUo1c6MX77S4AAnQpmZg42n
AlmCl6rnZAJ+s3rF/Pd9kfLAIO4j+N2CxwH5qPb6GAtGgWj2x50hQqqtJLqoDyY4rTG/mikwM+Cw
QpNZUjAESGVtzo2t/F0d6+Bfx9/isQOJQzU5AGmjIvmpUa2G9f0JUhkeeRmkGFZTMue8U/ZILsWP
83LDk+qSx3xdFbGcauAEPbFjmNNiQLjb2RBwWRhMmpJcu8sGzxhK448jrR4X2kkkh1lmyGN0OODN
NJSHTE1WoO2lzcj0uFW19OpAK+ITuyDA64lCZbM7punNknqwMUTapvM5KxBZKHLHMF7bQunmfm0P
k7v6UzMAI6FJ//x8obFbJL9i55RcBpC4iviSPokB+hEcX7idpl5ktQ5y7QLRv2Mi3wtob6N7rNB+
qPlpLTvavb9x+ibQr+/LdYgjz21CYdmYpSYBFemlkSObeXoMdPWt3TiC55rgY/NfrYLFLHh4u9F+
YVYSTG6259Z+LIEpw9bd5x5aSHLvB9c7OE5R0HIoLyfRMwGFWZtJk+cNY/UvK8fYqbn8wQiQ/wS6
qTIYZ9+ac5IP3LwG6VORGGnNY6bhnUx8yAGbL9MrbZ6OVH165YFNCyD41qfj09wScUyNzsm64bcL
UTsDcdrYgnYRS/j9/GnmJ6Y0r45nzAbSLXqE5jW+Yuaxkp9XizOkQbukSc2vXYYjEKOqR//Vv9rG
oUQglFCYGWO0277xkgDrzJa5s56tSFgtCDpmBcODgvoUBpD60M0i+Wf0/SLg/vqmOY7kzhx5BwRp
3xROk2pylpYOsxt/WED08wuaDyqx7eAsZluz4H44yJA/nrgyZbx6X3UIef2FOvk/i6gnp2x++ZMq
0GUqqlvHaKyduD7ucrszJwB0eLIZ7F2uRaa7Ri9g0GRaNgrSPtrDx3UP7D0yDA6g2TSrNsoSQTC/
tpj+9ziG/knXHF3AP3JWHlZK9hvX93iLDzncH842pF5ifayISm9w2OgOcuQ57/ZnpJ1EWMlJe6eU
kWCLWTYpyKyOZPgnGDM3qudz6FzcDw94mEVrElTuSGF3iji4BnHZKdKT1SuZm6vKMx8gyoF87A5W
cHNu5BD0B5iFrsHE0TW3dHJe0Rt8iXO0egdTsz1rvYl0Qxskgh4tfSB5d6EDdq3MSrq0zndlvJ2T
bBLTOYJ8aB28ApkR38q5nePbAP3remqhGPVLWTSZzsko9qJgmjIS2MFUpSWfOaFpWYC6AbhxJb6Y
2jo8XTu6Dq4dhFluKlPsB/SHjW99LXKeibujXWtrTQpmAZNzRTbeTd6HbKLQEezF4w2wDA6oTTul
pDlK4xe8dYA1W58VVG74DwEbZyyJF2T/Yd1tIAN8EzvAcF4b9jtlCxrspRupR0oKUl979Kf9i2ug
76WKUXbJH1dKFay0AIrNfFOUw33vBn10B5qFnjKpWQLrwne5y6oxsLsSQtmXyXhzH9YMRO6n0L5E
QgLx9J+EQ5qrmWQl38gXj8MdWRoJPWLfK5bVaXv++qzq/zmwVe/Z4CHaik4aDinM5Me+IXhb2I0H
TLWo06mxfTR+7ynoDQKFMu70JXBWf+elNnNrST8FlxiHPLuUCTfn/uiVpkuS7w5mdMm5gyRrhdvX
8bPw4fe/f8VtEhhDQrXURMSUNfNg1YjfABinYxdpI+FgSzNXMCVd7o4jD4hoQC7fpCkGHJY8UIUy
4ea8mzjNspu5CjYlTVsyhjLVUlz28r5hI/SkhU/kgz4lpKyKSPcq3RQGUnHidsGyVJwNd3epsnfd
IwEbJJkhheVr1gW8h3i/xY3qxvsEIOOFKA/PBScJ+M+52wtN4R1A144USnmPrJe3pwGFjg+eH7Gt
9R/UltWQk3mGyN888o3SH89dIuv3Piflb+4iV+F0h8ZDkfEiW+kDPnVzdnX4vdH5JIgDF13lEG/w
jvg6ERQain6Vz+LEzHnR0onQSLDspE0QzGIJHYxGpzaKsp3x6s2lYwUjIZuH2+tWYmHbQwE2qID6
wtpN6COLwx4xytSdYGb7Yomi9fImD0ILOxVVgMHs6rQDGSCWMjqpO61ZfODH3HSRTFn4oc1xvj14
njjIUaGQ3zymISLEw4MbpvrGwK2ALt2S+Pqn06CTtW8XL9NwnsfbcnCm+Y3U0DxP7ej3sVvY9RNs
VA21HFYpWwflb0Y7ueSCvrk7gcf6x+rtaWvoMeBMgXJluqlOemChi13PrQDOOwJOPJpE8j7ODNHx
Jda9ubjUFXseBj2xZRJtsR2dIsaNSvit8j1NEOj1xAutb35r+2Fh1WdnHC2WZQ22v9j61LCrYuMB
Sjxybj7qVcKcqRsjvbCqFlMND8AN0oJuykrQb5C2cmMBJV+rdr0bsePcEi47OxcDGX0OPfeGVaqh
GpRYvzGHEq70JKu01TuaarQnZSsw2UIoU4M9m9oHLfxIpJN5bO3pvlIM0ZqVdjNYmALpj3NVew42
tfCTA9f+CtmcT4Fr1TDZr8Ax8nojIQ6vzXRTDYf3eW2nMrajbRbMtQEeGTpkcfRZ3Cz6o9SOsUfV
kW7gQRsGFOqQ0Wq44ptXHTC2E1/a/frmnqVz1yu82yg/EI3JLFAFj5AK0u5fH/RRXied8gSa6OGE
yMaDKh7oKxlJzxoSfcnu61TS43gOiMSJmtzn2ui83zuLC6Kvj/keh9ThD9MhufOf2afGqCmrMKTz
Pgzvlr110FriyU1gCmla1orytOPDreHEuOVrGWTS4gy2xyKqxt/RJM3VoRL6JvadRDba93G6Rpn2
+V9BrDXosMBBCr54dpACagb7YpoK061OFD75q/tnSQuh9ICx5Qi/oRBDwin3Qt1sWBBJc1zYeEKE
vdzvA0CnYXv08OmHwUvF6HuNGcvhd9TLcGugwKYjHgDsRav5ki3j2JbqfrzO50sQDIOfQljOMfaW
MnJ6l8ko0/zeB4TcwpJ/4PYxe3pR/a04G1gPmViVQEpPcK5Hb46EvJKccD1Dp8nYRHSwyO8Kd5M+
CpCf18u+f3zthsN+3whPGGHkK6vgnp4yyyEfR02yfgPaCZO/6QKcE0w/GX056d/Hp2JXPvz7Zqod
9hwyWlV4+3SOBYspTJpd3iBXzCr35cJV6C9Eu4XO0D+UGW+ckW7xE/tZZjWn8hND7TckuojSOMAg
uHXtLG3nOVCk8YrM9AyXUNu4OJLLf3+cJTLrAXHIahqEgxpv+hjnamhvTww4sgeM3Vd4zKc539JZ
RbT3TgD+1scmelFdJxOx320aF+f1lPEJsujH1c3PLt7onYdDhGGILRt3sme1LBq4UQdnEsN8Y9WT
UpXELl50EEskZomphAA3zPn8pjsMtWk4xdBoeY4s+e3YNsRNA+9kegSdyP7sZzEdFLNXOibyQY08
h1EaEt3pnF9E+V6lI+tc3Wuq87n3i7Qn4/oS/nXewwtG9Uf/Aw8ylv2oRMwYjDS25ZiNPFT+t15s
DMslepWSVkb3g2EOL0GdecRpUCkJKL8pKLrTmP/2neSrW5dRgc7sY3MurkkusUJV1DNGhZ7hrp8Y
zYyF5WUoZff6xVaz1wQl55khZreVMzZZBeSj2N5qhJPCHMN1+WQbN0O3DgGNTNr/54xbCZ+GOomb
l1aDtq9atFrXZdyhvZpeh8VEetx7KqULV2KSF+GiX2kOLknil2A43xX9NBZ0mCEp2QHrlVrDe8MR
AVGCb6tKe/Z9l5YIsmdbdIkNVEr4yHXTGRcQsAArCxRCwZHZJ8D65Ps41SLsF28ElKa78Gi+3VI0
SPoDu+TB/3EuWAYVeIuBnoSBNSolMWAzBWK53sePuLtO3onuAk3gx2wwpLs7I8Fiwi/mimshv11h
F1FZ/FhlVK9q5piD7+RZB+wuoVRbkjMDDf61CU5noQWpXrBsdNQfAixIe6PeUbbwi4Mfos/ebHiw
+5AMBQmeiHnZS4iYX+2oQRYcBIhi51Zc2JwmPXa2RlJmXXAzjoBb1wCLgxUygeUFHz89Uol51U6f
7L4N/XVworIBye4V2RQg/AAA9kyfDcWQlpgAAYvcAZLgCS3irpqxxGf7AgAAAAAEWVo=

--pQQbTQUfgm5sUotT--
