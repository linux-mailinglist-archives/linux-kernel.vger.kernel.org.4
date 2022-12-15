Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3202C64D57C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 04:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLODMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 22:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLODMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 22:12:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447062B63A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 19:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671073950; x=1702609950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UK8HrruxQJ2YsHrZCEMAMT6dWv1X9zG28yWS6eyMuX4=;
  b=VRXh1zWvLVkMmrt5UK1j5RDiOh0sE+0R/IGPZay4SBOC1AEodhLVK5ss
   xgH8y7qZEApADyxyWKZAuzOUl2fa0YKBZu/ANnSEi7XuA9vO9YWCk9Frc
   OdLCm+EgnIwkDTpU1BKo/10a1ItdPUXMdGND/K9jA2Sb3WSSgc2CJ/ZJY
   uz6lNMyHYlSOjhzHqUkxh4HukH/6yzLkyWIQiTy3UVPlCOlzMb/OYc6CO
   NeEdmsjXcnhsWRnH/snpkseyfzAn+V2XY9b2RvOm7WGu6ncrQ1oeriPLG
   FtxBU2i+krB5DRPCr1cIUCzgb1LP3/Secx6Tid0LXnlA92q9tLF1RhKLx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="298248946"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="xz'?scan'208";a="298248946"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 19:12:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="756166320"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="xz'?scan'208";a="756166320"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2022 19:12:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 19:12:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 14 Dec 2022 19:12:28 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 14 Dec 2022 19:12:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkIt0wf4iJzpNboYS/K4k/kUF8pZu7n7ASuTpOMvU3eTK9wYGoyNmFdE6BvMVDU3TaVaw8wvW2cQUTK5nHsp/1YaHAgiFZMvZb5k3sANruRdZgCdAfC0XIt+3P/k2Jk6LxD575WR6Ee6Pp0YGNJXhKtoZ4h5zMrlUWhY615At4Yk8fhEAf6X3WTjPoXbLB/a/ac+vAlghjqMYQAUOUVTSoKP7WxmDhmwK+Xqi5vzFblGC7jhzok+F5BFQSo2yhg9uecZadHMTv4s02FSj5vf/Zm7rbKTRhue4IPharTzB8sfOml0D0HOPpjYo/FIRBeSv+edSdef27ZmQVI7xERcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFukFB0ub/+OMlf6w10B5t9/zwhAHllr03oL+V5YoUg=;
 b=dUIBtKwFhxe1jGL67UKHpsTiyNoy4ywAeH2Ne5uU1rcRwXNS4assANTdYrkEN2a6wwguohIanWBhDOCAdSE2NvBkbWQ724NY9xgID4SvsSu/++yo1ZRo4asW0d6s5TwA3extLgSraMHSYpJiW6xznddmVMn7SxAMdQJRYyzwJHSJ3s8PYXpDm8uW9ovlf3EspZrPqFUhYQqCWKIFyila4r9vhuRF6jStwzCp1mGkbE3ZpMxhfdtmr/+FEmNJiZgc6d/A2eFqCvpd9g0zIx4fV1rpCORduNPAM1uSLzOlz2e16SOgmV0ZXNRIHIutV/OPb7YE6hL5JYMQl2+QvDZTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW4PR11MB7150.namprd11.prod.outlook.com (2603:10b6:303:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 03:12:22 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb%7]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 03:12:22 +0000
Date:   Thu, 15 Dec 2022 11:10:10 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [rt-devel:linux-5.10.y-rt] [sched/hotplug] 3dc80c2780:
 kernel_BUG_at_kernel/sched/core.c
Message-ID: <202212150942.84e60db1-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="shUZK62c1qujNoWl"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW4PR11MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 4134ca3c-3c7c-41d5-51aa-08dade4a2e85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FA21705kxj4VLstp7mqirpVCYLizs0Hrtp4WVK8y0D24nBbF4VOH20eCjjgC1MQek1zS6TLdP5MYeMykI7PRiPMwqCHGeXUozVIh0r8a8nHfXkUgS2xnj7AQfDHnXva7BcIlYalyNAit2RnfZv/oWqV7Qcr6chO3sTqHRYrsxMLVUzDQNV0yVVjs8rAtHi4FajRmyoJYV3/kWMOCoZV4vhqz+K366byYbWdAXCeBtFaNJ2pcW3+x0/1TnGv86xJUG93ezk6zVJNT4qeQ1CKuisLPONx0I9xEn4O+ZZuPxSlHy97DboLZ9bdg97eYHP43S1MStG0aCW3UsxWPMWYDY/jSIkH+ROQdYHuuuKspGDXVJGcu1BARUCYTjOhfpzj+NIYBSMwaxD3Ip6KVtZrTiXkPqHw8WjJAEFHxVjST1lL0kOtVDq+o07MiDP4j8JCzPiQ6oO8/kvcWh+ZReDXtLFGwOEav8iBj5rH1sBASWCLaRiwCvo6xdsyDPLzPRdm8Qnqax2kRbVB8m/7vZD3JHMDZBJpcnicCQZCdwJQLEomx6/Sq7CZ4jNox4Jgdo2BAkCXKN5ncaUpm2yV5IUmAx9wN9jNkagmUI3JMJs+sYDv4ekDRuvssrZAg4cLaT3FpjwdAH3uXOttfO4GUitXhG/gmhWzEkQoKu0QG1nXLBqoG0FlcY8V2JELuuO3D4gWPmveJCV57KZ4krKb55w743x7xuARdk4TugE5FCRd33mxlAmxresB/Xe/v6eCDciTag3Dm6H4kOALxHtKSM5pYwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199015)(316002)(235185007)(66946007)(6916009)(54906003)(8676002)(5660300002)(66476007)(26005)(4326008)(6506007)(36756003)(66556008)(45080400002)(8936002)(44144004)(86362001)(41300700001)(2616005)(83380400001)(186003)(1076003)(478600001)(966005)(6486002)(82960400001)(6512007)(2906002)(6666004)(30864003)(38100700002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fL/BOsvgC+gHJj2hh84MB2bhmfrx594gsLG+9WIxv0rOqoSBWnydIy0tC+Ws?=
 =?us-ascii?Q?iQlER/8n9otNsnDzDgoBU1Vdi1lgfKBLpYPeFIpgfvRo8q9pFYdGTpyndaGP?=
 =?us-ascii?Q?luvpKl0cprcRDRAI3SDn4hoipf2e7e0moyEfUC/xgPZ1CMtsCLv7FI8lqtlH?=
 =?us-ascii?Q?xDkIZfUn1ksxA11lGjLg68q0Uew4d8J0HwAjY35hZ6f5aV/yr83QZE1qpHIi?=
 =?us-ascii?Q?EstdbnYqWWoFYdgjRTJZbbSE8HJYR0Z+Mks9g5b7DshgO6pjvCjESCzoPz4c?=
 =?us-ascii?Q?aW4B8NrDr/cXSxXlGRGAW39TJc0aI4HOJuh0IDJcQlHM1r1TIaRiy3mF6XZ4?=
 =?us-ascii?Q?+hbaeFlQvH27lX6gZ0HhBUH4QPVZ04yezO+WbcXgnAjqUQm9UMCXMAj5W+hc?=
 =?us-ascii?Q?8jmB51s3v2AjEBaRzTR1VfBOONmxaMxs/HcZmqJAZN5Ednrx3IaDgcOwrbmI?=
 =?us-ascii?Q?hTGcvKqL46iE4mj8SO75CXBIKMgTCuHYxOnJwtpo6MLNhJrIVl6N1pe1S0Lb?=
 =?us-ascii?Q?GosIYKA5VBb9VzP+63kfkvME25SgM7IBmJMlebbIjp9J1V9+/u9w/sAVY+Le?=
 =?us-ascii?Q?iIZQh+TbDqHZfnX/PrY4OnLVR26eCQx0Qkgw4vS+kTW0bwW46uheumBSerzK?=
 =?us-ascii?Q?CBIa2/WLODQkT2jxxRqkYE1XOsri5S2cd0AkFe/gWixYMujt9G56yqRyQnQr?=
 =?us-ascii?Q?dW3SnoIL+CxOnjPfqL1AM3EzM9rLU5yKSsRL/G3W10AWrULpbXIT20DL6Z1x?=
 =?us-ascii?Q?aNM82sZ2n1OXCwI1Nt803OE2cURRoZPNIRu8ur2ZZ6aRudRT+B54mnxCwzga?=
 =?us-ascii?Q?ylwB9l5vBYjLXenZ5RgqW5RpA1G22B7H3K04B7aI6KWcpfPsgI2AZy65jXFr?=
 =?us-ascii?Q?YWbr2DNz7hpQ66y/m0Hc5SVrGJlNQpmHja2PxWq0qqahuyhMxn5CCiC0UYFV?=
 =?us-ascii?Q?8tNekuMz1TrTBqaL167eG1UsaTJ2CC9a1MY1PhoBSZdUUBd10jPpLDZ2fmry?=
 =?us-ascii?Q?H7sK4TebCZQLgIaAX0dQu8//FO6xPICMD55UE4DCV8fD73bzx+f3cSZQvqvw?=
 =?us-ascii?Q?GsGtdSUGf/M/GV+PFKm6FKI+Vyok7bfJyErZfr8u64pREqjGspT7Ehb1SQZ3?=
 =?us-ascii?Q?yLfO0sxD6ljqosaBpaWmGSSKymrSlcgmbgwaVu8LV/0XiA52m/+iJkdYoV36?=
 =?us-ascii?Q?4BumlXWCoxVLsnD11EjB4Dza2+1osk8JW3pwLYlJSTWJ4c0mTg1o209aDjKJ?=
 =?us-ascii?Q?Ba6Jv/vLIqEnQ3JQvWDnNmqVwT75SbxxwnEDzJARNGM+qG1cSi6JhUf6S/Hf?=
 =?us-ascii?Q?VmMZXyUxVp8Iza595iZ3XJeSPt/6xxYRFBgv06ydO8kb1jwEnbwIdtFbul0I?=
 =?us-ascii?Q?K9lt5kGhBMo05f1sGMuZiog/kI1YmAeNC5+yXYJMwwzTWjTQ58wY27l36GNH?=
 =?us-ascii?Q?yfjc92jNlEZJwgIhNMyF2VF3Nh2qc/HQ54IvicnuVgjAY05qH7z35C9d2jQw?=
 =?us-ascii?Q?v+4CtMfCe+mk1AVA76RZWhDpZo6ujj95xe6iVX5RaYeFeHLy7QnNyCREw5bN?=
 =?us-ascii?Q?dd8s+jkQWdZbGT1VYmNTP8Y5hr8ZSZQd0q6kiE+5F0zLecMBfByKISujBhIe?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4134ca3c-3c7c-41d5-51aa-08dade4a2e85
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 03:12:22.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLjTUErH+XRUEVM/0y5s2aVgse3VtEUmriYpd+h0RDpoMMG9VRYz7CYDcQjo2U3uOtFMbpG3L1wkUlK0PrIFdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7150
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--shUZK62c1qujNoWl
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greetings,

FYI, we noticed kernel_BUG_at_kernel/sched/core.c due to commit (built with gcc-11):

commit: 3dc80c278022ec43b137216ac51e25a9468bf2d7 ("sched/hotplug: Consolidate task migration on CPU unplug")
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git linux-5.10.y-rt

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: srcu

test-description: rcutorture is rcutorture kernel module load/unload test.
test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


[   99.675800][   T15] ------------[ cut here ]------------
[   99.677237][   T15] kernel BUG at kernel/sched/core.c:7078!
[   99.677911][   T15] invalid opcode: 0000 [#1] SMP KASAN PTI
[   99.678562][   T15] CPU: 1 PID: 15 Comm: migration/1 Not tainted 5.10.0-rc1-00006-g3dc80c278022 #1
[   99.679692][   T15] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 99.685108][ T15] Stopper: multi_cpu_stop+0x0/0x360 <- 0x0 
[ 99.685862][ T15] RIP: 0010:sched_cpu_dying (??:?) 
[ 99.686561][ T15] Code: 55 82 01 a8 01 0f 85 7a fe ff ff c6 05 fa 9e 8d 03 01 90 48 c7 c7 e0 b5 06 83 e8 89 fe 81 01 90 0f 0b 90 90 e9 5c fe ff ff 90 <0f> 0b 48 c7 c7 60 c2 d2 83 e8 c2 99 86 01 e8 86 15 56 00 e9 29 ff
All code
========
   0:	55                   	push   %rbp
   1:	82                   	(bad)  
   2:	01 a8 01 0f 85 7a    	add    %ebp,0x7a850f01(%rax)
   8:	fe                   	(bad)  
   9:	ff                   	(bad)  
   a:	ff c6                	inc    %esi
   c:	05 fa 9e 8d 03       	add    $0x38d9efa,%eax
  11:	01 90 48 c7 c7 e0    	add    %edx,-0x1f3838b8(%rax)
  17:	b5 06                	mov    $0x6,%ch
  19:	83 e8 89             	sub    $0xffffff89,%eax
  1c:	fe 81 01 90 0f 0b    	incb   0xb0f9001(%rcx)
  22:	90                   	nop
  23:	90                   	nop
  24:	e9 5c fe ff ff       	jmpq   0xfffffffffffffe85
  29:	90                   	nop
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 c7 c7 60 c2 d2 83 	mov    $0xffffffff83d2c260,%rdi
  33:	e8 c2 99 86 01       	callq  0x18699fa
  38:	e8 86 15 56 00       	callq  0x5615c3
  3d:	e9                   	.byte 0xe9
  3e:	29 ff                	sub    %edi,%edi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 c7 c7 60 c2 d2 83 	mov    $0xffffffff83d2c260,%rdi
   9:	e8 c2 99 86 01       	callq  0x18699d0
   e:	e8 86 15 56 00       	callq  0x561599
  13:	e9                   	.byte 0xe9
  14:	29 ff                	sub    %edi,%edi
[   99.689087][   T15] RSP: 0018:ffffc9000010fcd0 EFLAGS: 00010002
[   99.689883][   T15] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff8119a15c
[   99.690901][   T15] RDX: 1ffff110740fe9e9 RSI: 0000000000000008 RDI: ffff8883a07f4f48
[   99.691979][   T15] RBP: ffffc9000010fd08 R08: 0000000000000000 R09: ffff88810004d1bf
[   99.693039][   T15] R10: ffffed1020009a37 R11: 0000000000000001 R12: ffff8883a07f4f00
[   99.694020][   T15] R13: 0000000000000001 R14: ffff8883a07f4f18 R15: 0000000000000046
[   99.695022][   T15] FS:  0000000000000000(0000) GS:ffff8883a0600000(0000) knlGS:0000000000000000
[   99.696197][   T15] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   99.697046][   T15] CR2: 000055f1b8e6c3c0 CR3: 000000011dc36000 CR4: 00000000000406a0
[   99.698151][   T15] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   99.699155][   T15] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   99.700179][   T15] Call Trace:
[ 99.700616][ T15] ? sched_cpu_wait_empty (??:?) 
[ 99.701311][ T15] cpuhp_invoke_callback (cpu.c:?) 
[ 99.701905][ T15] ? mp_irqdomain_ioapic_idx (apic_flat_64.c:?) 
[ 99.702593][ T15] ? cpuhp_invoke_callback (cpu.c:?) 
[ 99.703314][ T15] take_cpu_down (cpu.c:?) 
[ 99.703926][ T15] multi_cpu_stop (stop_machine.c:?) 
[ 99.704560][ T15] cpu_stopper_thread (stop_machine.c:?) 
[ 99.709427][ T15] ? stop_machine_yield+0x10/0x10 
[ 99.710079][ T15] ? cpu_stop_queue_two_works (stop_machine.c:?) 
[ 99.710794][ T15] ? smpboot_thread_fn (smpboot.c:?) 
[ 99.711468][ T15] smpboot_thread_fn (smpboot.c:?) 
[ 99.712104][ T15] ? __smpboot_create_thread (smpboot.c:?) 
[ 99.712786][ T15] ? __kthread_parkme (kthread.c:?) 
[ 99.713400][ T15] ? schedule (??:?) 
[ 99.713917][ T15] ? __smpboot_create_thread (smpboot.c:?) 
[ 99.714525][ T15] ? __smpboot_create_thread (smpboot.c:?) 
[ 99.715202][ T15] kthread (kthread.c:?) 
[ 99.715714][ T15] ? kthread_insert_work_sanity_check (kthread.c:?) 
[ 99.716541][ T15] ret_from_fork (??:?) 
[   99.717135][   T15] Modules linked in: rcutorture torture bochs_drm drm_vram_helper drm_ttm_helper ttm drm_kms_helper cec cfbfillrect cfbimgblt cfbcopyarea fb_sys_fops syscopyarea sysfillrect input_leds sysimgblt led_class fb i2c_piix4 fbdev rtc_cmos qemu_fw_cfg drm drm_panel_orientation_quirks fuse i2c_core
[   99.720716][   T15]
[   99.720719][   T15] ======================================================
[   99.720721][   T15] WARNING: possible circular locking dependency detected
[   99.720723][   T15] 5.10.0-rc1-00006-g3dc80c278022 #1 Not tainted
[   99.720725][   T15] ------------------------------------------------------
[   99.720727][   T15] migration/1/15 is trying to acquire lock:
[ 99.720729][ T15] ffffffff83d7ff20 (console_owner){-.-.}-{0:0}, at: console_unlock (??:?) 
[   99.720736][   T15]
[   99.720738][   T15] but task is already holding lock:
[ 99.720740][ T15] ffff8883a07f4f18 (&rq->lock){-.-.}-{2:2}, at: sched_cpu_dying (??:?) 
[   99.720744][   T15]
[   99.720746][   T15] which lock already depends on the new lock.
[   99.720747][   T15]
[   99.720749][   T15] the existing dependency chain (in reverse order) is:
[   99.720750][   T15]
[   99.720751][   T15] -> #4 (&rq->lock){-.-.}-{2:2}:
[ 99.720756][ T15] __lock_acquire (lockdep.c:?) 
[ 99.720757][ T15] lock_acquire (??:?) 
[ 99.720758][ T15] _raw_spin_lock (??:?) 
[ 99.720759][ T15] task_fork_fair (fair.c:?) 
[ 99.720761][ T15] sched_fork (??:?) 
[ 99.720762][ T15] copy_process (fork.c:?) 
[ 99.720764][ T15] kernel_clone (??:?) 
[ 99.720765][ T15] kernel_thread (??:?) 
[ 99.720766][ T15] rest_init (??:?) 
[ 99.720768][ T15] start_kernel (??:?) 
[ 99.720770][ T15] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:277) 
[   99.720771][   T15]
[   99.720773][   T15] -> #3 (&p->pi_lock){-.-.}-{2:2}:
[ 99.720779][ T15] __lock_acquire (lockdep.c:?) 
[ 99.720780][ T15] lock_acquire (??:?) 
[ 99.720782][ T15] _raw_spin_lock_irqsave (??:?) 
[ 99.720783][ T15] try_to_wake_up (core.c:?) 
[ 99.720785][ T15] __wake_up_common (wait.c:?) 
[ 99.720787][ T15] __wake_up_common_lock (wait.c:?) 
[ 99.720789][ T15] tty_port_default_wakeup (tty_port.c:?) 
[ 99.720790][ T15] serial8250_tx_chars (??:?) 
[ 99.720792][ T15] serial8250_handle_irq (??:?) 
[ 99.720793][ T15] serial8250_interrupt (8250_core.c:?) 
[ 99.720795][ T15] __handle_irq_event_percpu (??:?) 
[ 99.720797][ T15] handle_irq_event_percpu (??:?) 
[ 99.720799][ T15] handle_irq_event (??:?) 
[ 99.720800][ T15] handle_edge_irq (??:?) 
[ 99.720802][ T15] asm_call_irq_on_stack (??:?) 
[ 99.720804][ T15] common_interrupt (??:?) 
[ 99.720805][ T15] asm_common_interrupt (??:?) 
[ 99.720807][ T15] default_idle (??:?) 
[ 99.720809][ T15] default_idle_call (??:?) 
[ 99.720810][ T15] cpuidle_idle_call (idle.c:?) 
[ 99.720812][ T15] do_idle (idle.c:?) 
[ 99.720813][ T15] cpu_startup_entry (??:?) 
[ 99.720815][ T15] start_secondary (smpboot.c:?) 
[ 99.720817][ T15] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:277) 
[   99.720818][   T15]
[   99.720819][   T15] -> #2 (&tty->write_wait){-.-.}-{2:2}:
[ 99.720839][ T15] __lock_acquire (lockdep.c:?) 
[ 99.720841][ T15] lock_acquire (??:?) 
[ 99.720843][ T15] _raw_spin_lock_irqsave (??:?) 
[ 99.720844][ T15] __wake_up_common_lock (wait.c:?) 
[ 99.720846][ T15] tty_port_default_wakeup (tty_port.c:?) 
[ 99.720848][ T15] serial8250_tx_chars (??:?) 
[ 99.720850][ T15] serial8250_handle_irq (??:?) 
[ 99.720851][ T15] serial8250_interrupt (8250_core.c:?) 
[ 99.720853][ T15] __handle_irq_event_percpu (??:?) 
[ 99.720855][ T15] handle_irq_event_percpu (??:?) 
[ 99.720856][ T15] handle_irq_event (??:?) 
[ 99.720858][ T15] handle_edge_irq (??:?) 
[ 99.720860][ T15] asm_call_irq_on_stack (??:?) 
[ 99.720861][ T15] common_interrupt (??:?) 
[ 99.720863][ T15] asm_common_interrupt (??:?) 
[ 99.720865][ T15] default_idle (??:?) 
[ 99.720866][ T15] default_idle_call (??:?) 
[ 99.720868][ T15] cpuidle_idle_call (idle.c:?) 
[ 99.720870][ T15] do_idle (idle.c:?) 
[ 99.720872][ T15] cpu_startup_entry (??:?) 
[ 99.720874][ T15] start_secondary (smpboot.c:?) 
[ 99.720875][ T15] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:277) 
[   99.720877][   T15]
[   99.720878][   T15] -> #1 (&port_lock_key){-.-.}-{2:2}:
[ 99.720884][ T15] __lock_acquire (lockdep.c:?) 
[ 99.720886][ T15] lock_acquire (??:?) 
[ 99.720887][ T15] _raw_spin_lock_irqsave (??:?) 
[ 99.720889][ T15] serial8250_console_write (??:?) 
[ 99.720891][ T15] call_console_drivers+0x237/0x400 
[ 99.720893][ T15] console_unlock (??:?) 
[ 99.720895][ T15] vprintk_emit (??:?) 
[ 99.720897][ T15] printk (??:?) 
[ 99.720898][ T15] register_console (??:?) 
[ 99.720900][ T15] univ8250_console_init (8250_core.c:?) 
[ 99.720902][ T15] console_init (??:?) 
[ 99.720903][ T15] start_kernel (??:?) 
[ 99.720905][ T15] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:277) 
[   99.720906][   T15]
[   99.720907][   T15] -> #0 (console_owner){-.-.}-{0:0}:
[ 99.720914][ T15] check_prev_add (lockdep.c:?) 
[ 99.720915][ T15] validate_chain (lockdep.c:?) 
[ 99.720917][ T15] __lock_acquire (lockdep.c:?) 
[ 99.720919][ T15] lock_acquire (??:?) 
[ 99.720920][ T15] console_unlock (??:?) 
[ 99.720922][ T15] vprintk_emit (??:?) 
[ 99.720923][ T15] printk (??:?) 
[ 99.720925][ T15] report_bug.cold (bug.c:?) 
[ 99.720927][ T15] handle_bug (traps.c:?) 
[ 99.720929][ T15] exc_invalid_op (??:?) 
[ 99.720930][ T15] asm_exc_invalid_op (??:?) 
[ 99.720932][ T15] sched_cpu_dying (??:?) 
[ 99.720934][ T15] cpuhp_invoke_callback (cpu.c:?) 
[ 99.720935][ T15] take_cpu_down (cpu.c:?) 
[ 99.720937][ T15] multi_cpu_stop (stop_machine.c:?) 
[ 99.720939][ T15] cpu_stopper_thread (stop_machine.c:?) 
[ 99.720941][ T15] smpboot_thread_fn (smpboot.c:?) 
[ 99.720942][ T15] kthread (kthread.c:?) 
[ 99.720944][ T15] ret_from_fork (??:?) 
[   99.720944][   T15]
[   99.720946][   T15] other info that might help us debug this:
[   99.720946][   T15]
[   99.720948][   T15] Chain exists of:
[   99.720949][   T15]   console_owner --> &p->pi_lock --> &rq->lock
[   99.720955][   T15]
[   99.720956][   T15]  Possible unsafe locking scenario:
[   99.720957][   T15]
[   99.720958][   T15]        CPU0                    CPU1
[   99.720960][   T15]        ----                    ----
[   99.720961][   T15]   lock(&rq->lock);
[   99.720966][   T15]                                lock(&p->pi_lock);
[   99.720970][   T15]                                lock(&rq->lock);
[   99.720974][   T15]   lock(console_owner);
[   99.720978][   T15]
[   99.720980][   T15]  *** DEADLOCK ***
[   99.720981][   T15]
[   99.720983][   T15] 2 locks held by migration/1/15:
[ 99.720984][ T15] #0: ffff8883a07f4f18 (&rq->lock){-.-.}-{2:2}, at: sched_cpu_dying (??:?) 
[ 99.720992][ T15] #1: ffffffff84100560 (console_lock){+.+.}-{0:0}, at: vprintk_emit (??:?) 
[   99.721001][   T15]
[   99.721002][   T15] stack backtrace:
[   99.721005][   T15] CPU: 1 PID: 15 Comm: migration/1 Not tainted 5.10.0-rc1-00006-g3dc80c278022 #1
[   99.721007][   T15] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 99.721009][ T15] Stopper: multi_cpu_stop+0x0/0x360 <- 0x0 
[   99.721011][   T15] Call Trace:
[ 99.721012][ T15] dump_stack (??:?) 
[ 99.721014][ T15] check_noncircular (lockdep.c:?) 
[ 99.721016][ T15] ? print_circular_bug (lockdep.c:?) 
[ 99.721018][ T15] ? add_lock_to_list+0x193/0x370 
[ 99.721019][ T15] check_prev_add (lockdep.c:?) 
[ 99.721021][ T15] validate_chain (lockdep.c:?) 
[ 99.721022][ T15] ? check_prev_add (lockdep.c:?) 
[ 99.721024][ T15] ? sched_clock (??:?) 
[ 99.721026][ T15] __lock_acquire (lockdep.c:?) 
[ 99.721027][ T15] ? sched_clock (??:?) 
[ 99.721029][ T15] ? sched_clock_cpu (??:?) 
[ 99.721031][ T15] lock_acquire (??:?) 
[ 99.721032][ T15] ? console_unlock (??:?) 
[ 99.721034][ T15] ? rcu_read_unlock (workqueue.c:?) 


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202212150942.84e60db1-yujie.liu@intel.com


To reproduce:

        # build kernel
	cd linux
	cp config-5.10.0-rc1-00006-g3dc80c278022 .config
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
https://01.org/lkp

--shUZK62c1qujNoWl
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-5.10.0-rc1-00006-g3dc80c278022"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.10.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_LD_VERSION=239000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_UAPI_HEADER_TEST=y
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
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
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
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
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

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
# CONFIG_TASK_DELAY_ACCT is not set
CONFIG_TASK_XACCT=y
# CONFIG_TASK_IO_ACCOUNTING is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
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
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
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
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
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
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
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
CONFIG_PARAVIRT_DEBUG=y
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_ACRN_GUEST=y
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
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=y
CONFIG_X86_MSR=m
# CONFIG_X86_CPUID is not set
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_X86_UMIP is not set
# CONFIG_EFI is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
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
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

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
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_ISA_BUS is not set
# CONFIG_ISA_DMA_API is not set
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32 is not set
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=m
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
# CONFIG_GOOGLE_MEMCONSOLE_COREBOOT is not set
CONFIG_GOOGLE_VPD=m
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

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
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
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
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_UNUSED_SYMBOLS=y
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
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=19
CONFIG_MEM_SOFT_DIRTY=y
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
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
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
# CONFIG_NET_SCH_HTB is not set
CONFIG_NET_SCH_HFSC=y
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=y
# CONFIG_NET_SCH_RED is not set
# CONFIG_NET_SCH_SFB is not set
# CONFIG_NET_SCH_SFQ is not set
# CONFIG_NET_SCH_TEQL is not set
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=y
CONFIG_NET_SCH_TAPRIO=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=y
# CONFIG_NET_SCH_CHOKE is not set
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=y
# CONFIG_NET_SCH_FQ_CODEL is not set
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=y
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=y
# CONFIG_NET_SCH_PLUG is not set
CONFIG_NET_SCH_ETS=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=y
# CONFIG_CLS_U32_PERF is not set
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_CLS_FLOW is not set
CONFIG_NET_CLS_CGROUP=m
# CONFIG_NET_CLS_BPF is not set
# CONFIG_NET_CLS_FLOWER is not set
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
# CONFIG_NET_EMATCH_CMP is not set
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
# CONFIG_NET_EMATCH_TEXT is not set
CONFIG_NET_EMATCH_CANID=y
CONFIG_NET_CLS_ACT=y
# CONFIG_NET_ACT_POLICE is not set
CONFIG_NET_ACT_GACT=m
# CONFIG_GACT_PROB is not set
# CONFIG_NET_ACT_MIRRED is not set
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=y
CONFIG_NET_ACT_SIMP=y
CONFIG_NET_ACT_SKBEDIT=m
# CONFIG_NET_ACT_CSUM is not set
CONFIG_NET_ACT_MPLS=m
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_SKBMOD is not set
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=y
CONFIG_NET_ACT_GATE=m
# CONFIG_NET_IFE_SKBMARK is not set
# CONFIG_NET_IFE_SKBPRIO is not set
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
# CONFIG_DNS_RESOLVER is not set
CONFIG_BATMAN_ADV=m
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
# CONFIG_BATMAN_ADV_NC is not set
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUGFS is not set
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_BATMAN_ADV_SYSFS is not set
CONFIG_BATMAN_ADV_TRACING=y
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=m
# CONFIG_VSOCKETS_LOOPBACK is not set
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
# CONFIG_MPLS is not set
CONFIG_NET_NSH=m
CONFIG_HSR=y
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
CONFIG_QRTR=y
CONFIG_QRTR_TUN=y
# CONFIG_QRTR_MHI is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
CONFIG_BPQETHER=m
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_YAM=m
# end of AX.25 network device drivers

CONFIG_CAN=y
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=y
CONFIG_CAN_GW=y
CONFIG_CAN_J1939=m
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_FLEXCAN is not set
# CONFIG_CAN_GRCAN is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
# CONFIG_BT_RFCOMM_TTY is not set
# CONFIG_BT_BNEP is not set
# CONFIG_BT_HIDP is not set
# CONFIG_BT_HS is not set
CONFIG_BT_LE=y
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_DEBUGFS is not set
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
# CONFIG_CAIF_USB is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
# CONFIG_EISA_PCI_EISA is not set
# CONFIG_EISA_VIRTUAL_ROOT is not set
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PTM=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=m
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
CONFIG_PCIE_BUS_SAFE=y
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_HOST_COMMON=m
CONFIG_PCI_HOST_GENERIC=m
# CONFIG_PCIE_XILINX is not set

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
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_EP=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
CONFIG_PCIE_CADENCE_PLAT_EP=y
CONFIG_PCI_J721E=y
# CONFIG_PCI_J721E_HOST is not set
CONFIG_PCI_J721E_EP=y
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
# CONFIG_PCI_EPF_TEST is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=m
# CONFIG_RAPIDIO_CHMAN is not set
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
CONFIG_RAPIDIO_CPS_XX=y
# CONFIG_RAPIDIO_TSI568 is not set
CONFIG_RAPIDIO_CPS_GEN2=m
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=m
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MOXTET=y
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# end of Bus devices

CONFIG_CONNECTOR=m
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
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
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=m
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HP_ILO=m
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
# CONFIG_DS1682 is not set
CONFIG_LATTICE_ECP3_CONFIG=m
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_PVPANIC=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=m
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module (requires I2C)
#
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=y
CONFIG_INTEL_MEI_HDCP=m
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
# CONFIG_INTEL_MIC_BUS is not set
# CONFIG_SCIF_BUS is not set
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

CONFIG_GENWQE=m
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
CONFIG_MISC_ALCOR_PCI=m
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HABANA_AI=m
# end of Misc devices

CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_IFB is not set
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
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
# CONFIG_CAIF_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
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
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
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
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
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
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
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
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
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
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
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
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
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
CONFIG_INPUT_LEDS=m
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

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
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
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
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
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
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
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
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_CCTRNG=y
CONFIG_HW_RANDOM_XIPHERA=m
CONFIG_APPLICOM=y
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
# CONFIG_NVRAM is not set
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=m
# CONFIG_TCG_TIS_SPI_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TCG_TIS_ST33ZP24_SPI=m
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=m
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_GPMUX=m
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=m
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=m
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
# CONFIG_I2C_NFORCE2_S4985 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_CROS_EC_TUNNEL=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
CONFIG_I2C_SLAVE_TESTUNIT=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=m
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_DMA is not set
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_NXP_FLEXSPI=m
CONFIG_SPI_GPIO=m
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_FSL_SPI is not set
CONFIG_SPI_LANTIQ_SSC=y
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_XCOMM=m
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=m
CONFIG_SPI_SLAVE=y
# CONFIG_SPI_SLAVE_TIME is not set
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
CONFIG_SPI_DYNAMIC=y
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
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=m
CONFIG_GPIO_HLWD=m
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_SAMA5D2_PIOBU=m
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_VX855=m
CONFIG_GPIO_XILINX=m
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=m
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=m
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=m
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=m
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=m
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=m
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_MAX77650 is not set
CONFIG_GPIO_STMPE=y
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=y
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=m
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=m
CONFIG_GPIO_XRA1403=m
CONFIG_GPIO_MOXTET=m
# end of SPI GPIO expanders

# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=m
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_MT6323=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_NVMEM_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=m
# CONFIG_BATTERY_ACT8945A is not set
# CONFIG_BATTERY_CPCAP is not set
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
CONFIG_AXP20X_POWER=m
# CONFIG_AXP288_FUEL_GAUGE is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=m
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_MAX77650=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ2515X=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_BQ25980=m
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65217=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=m
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_UCS1002=m
CONFIG_CHARGER_BD99954=m
CONFIG_RN5T618_POWER=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=m
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AS370=m
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_AXI_FAN_CONTROL=m
CONFIG_SENSORS_K8TEMP=m
# CONFIG_SENSORS_AMD_ENERGY is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_GSC is not set
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_GPIO_FAN=m
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2947_SPI=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=m
CONFIG_SENSORS_MAX16065=m
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX31730=m
CONFIG_SENSORS_MAX6621=m
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=m
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MR75203=m
# CONFIG_SENSORS_ADCXX is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=m
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=m
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=m
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=m
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CPU_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y

#
# Intel thermal drivers
#
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=m
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=m
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
# CONFIG_MFD_CROS_EC_DEV is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=m
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_GATEWORKS_GSC=m
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_HI6421_PMIC=m
CONFIG_HTC_PASIC3=m
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
# CONFIG_LPC_ICH is not set
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_IQS62X=m
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=m
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77650=m
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=y
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
# CONFIG_PCF50633_GPIO is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=m
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SI476X_CORE=m
# CONFIG_MFD_SL28CPLD is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_ABX500_CORE=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_SPI=y
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
CONFIG_MFD_TI_LMU=m
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=m
# CONFIG_MFD_TPS65218 is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_MFD_WL1273_CORE=m
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=y
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8994=m
CONFIG_MFD_STMFX=m
# CONFIG_MFD_WCD934X is not set
CONFIG_MFD_INTEL_M10_BMC=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_ACT8865=m
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=m
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_CPCAP=y
CONFIG_REGULATOR_CROS_EC=m
CONFIG_REGULATOR_DA9063=m
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=m
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=m
CONFIG_REGULATOR_HI6421V530=m
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP873X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=m
CONFIG_REGULATOR_LTC3589=m
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX1586=m
# CONFIG_REGULATOR_MAX77650 is not set
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX8973=m
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MCP16502=m
CONFIG_REGULATOR_MP5416=m
CONFIG_REGULATOR_MP8859=m
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCA9450=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=m
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=m
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_RT4801=m
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_RTMV20=m
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=m
CONFIG_REGULATOR_SY8827N=m
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM8994=m
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=m
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_V4L2_MEM2MEM_DEV=m
CONFIG_V4L2_FWNODE=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_TW5864 is not set
CONFIG_VIDEO_TW68=m

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
CONFIG_VIDEO_DT3155=m

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX25821=m
# CONFIG_VIDEO_SAA7134 is not set
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
# CONFIG_DVB_AV7110 is not set
# CONFIG_DVB_BUDGET_CORE is not set
# CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_PT1=m
CONFIG_DVB_PT3=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_VIDEO_TVEEPROM=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_VIDEO_CAFE_CCIC=m
CONFIG_VIDEO_VIA_CAMERA=m
# CONFIG_VIDEO_CADENCE is not set
CONFIG_VIDEO_ASPEED=m
CONFIG_VIDEO_MUX=m
# CONFIG_VIDEO_XILINX is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_TLV320AIC23B=m
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_WM8775=m
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_SONY_BTF_MPX=m
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=m
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_ADV748X=m
CONFIG_VIDEO_ADV7604=m
# CONFIG_VIDEO_ADV7604_CEC is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_ML86V7667=m
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=m
CONFIG_VIDEO_TW2804=m
# CONFIG_VIDEO_TW9903 is not set
CONFIG_VIDEO_TW9906=m
CONFIG_VIDEO_TW9910=m
CONFIG_VIDEO_VPX3220=m
CONFIG_VIDEO_MAX9286=m

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
CONFIG_VIDEO_ADV7343=m
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_AD9389B=m
CONFIG_VIDEO_AK881X=m
CONFIG_VIDEO_THS8200=m
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=m
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=m
CONFIG_VIDEO_I2C=m
CONFIG_VIDEO_ST_MIPID02=m
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=m
CONFIG_VIDEO_HI556=m
# CONFIG_VIDEO_IMX214 is not set
CONFIG_VIDEO_IMX219=m
# CONFIG_VIDEO_IMX258 is not set
CONFIG_VIDEO_IMX274=m
CONFIG_VIDEO_IMX290=m
# CONFIG_VIDEO_IMX319 is not set
CONFIG_VIDEO_IMX355=m
# CONFIG_VIDEO_OV2640 is not set
CONFIG_VIDEO_OV2659=m
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5640 is not set
CONFIG_VIDEO_OV5645=m
CONFIG_VIDEO_OV5647=m
CONFIG_VIDEO_OV6650=m
CONFIG_VIDEO_OV5670=m
# CONFIG_VIDEO_OV5675 is not set
CONFIG_VIDEO_OV5695=m
CONFIG_VIDEO_OV7251=m
# CONFIG_VIDEO_OV772X is not set
CONFIG_VIDEO_OV7640=m
CONFIG_VIDEO_OV7670=m
CONFIG_VIDEO_OV7740=m
# CONFIG_VIDEO_OV8856 is not set
CONFIG_VIDEO_OV9640=m
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV13858 is not set
CONFIG_VIDEO_VS6624=m
# CONFIG_VIDEO_MT9M001 is not set
CONFIG_VIDEO_MT9M032=m
CONFIG_VIDEO_MT9M111=m
CONFIG_VIDEO_MT9P031=m
# CONFIG_VIDEO_MT9T001 is not set
CONFIG_VIDEO_MT9T112=m
CONFIG_VIDEO_MT9V011=m
CONFIG_VIDEO_MT9V032=m
CONFIG_VIDEO_MT9V111=m
CONFIG_VIDEO_SR030PC30=m
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
CONFIG_VIDEO_RDACM20=m
# CONFIG_VIDEO_RJ54N1 is not set
CONFIG_VIDEO_S5K6AA=m
CONFIG_VIDEO_S5K6A3=m
CONFIG_VIDEO_S5K4ECGX=m
CONFIG_VIDEO_S5K5BAF=m
# CONFIG_VIDEO_SMIAPP is not set
CONFIG_VIDEO_ET8EK8=m
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=m
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
CONFIG_VIDEO_DW9807_VCM=m
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
# CONFIG_MEDIA_TUNER_FC0012 is not set
# CONFIG_MEDIA_TUNER_FC0013 is not set
# CONFIG_MEDIA_TUNER_TDA18212 is not set
# CONFIG_MEDIA_TUNER_E4000 is not set
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
# CONFIG_MEDIA_TUNER_TUA9001 is not set
# CONFIG_MEDIA_TUNER_SI2157 is not set
CONFIG_MEDIA_TUNER_IT913X=m
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
# CONFIG_DVB_STV090x is not set
# CONFIG_DVB_STV0910 is not set
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
# CONFIG_DVB_TDA18271C2DD is not set
# CONFIG_DVB_SI2165 is not set
CONFIG_DVB_MN88472=m
# CONFIG_DVB_MN88473 is not set

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
# CONFIG_DVB_MT312 is not set
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
# CONFIG_DVB_STV0288 is not set
# CONFIG_DVB_STB6000 is not set
# CONFIG_DVB_STV0299 is not set
# CONFIG_DVB_STV6110 is not set
# CONFIG_DVB_STV0900 is not set
CONFIG_DVB_TDA8083=m
# CONFIG_DVB_TDA10086 is not set
# CONFIG_DVB_TDA8261 is not set
CONFIG_DVB_VES1X93=m
# CONFIG_DVB_TUNER_ITD1000 is not set
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
# CONFIG_DVB_DS3000 is not set
# CONFIG_DVB_MB86A16 is not set
# CONFIG_DVB_TDA10071 is not set

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
# CONFIG_DVB_MT352 is not set
# CONFIG_DVB_ZL10353 is not set
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
# CONFIG_DVB_CXD2841ER is not set
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
# CONFIG_DVB_SI2168 is not set
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
# CONFIG_DVB_OR51211 is not set
# CONFIG_DVB_OR51132 is not set
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_SIS=m
CONFIG_AGP_VIA=m
CONFIG_INTEL_GTT=m
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_MIPI_DBI=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
CONFIG_DRM_I915_DEBUG_MMIO=y
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
CONFIG_DRM_I915_SW_FENCE_CHECK_DAG=y
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS=y
CONFIG_DRM_I915_DEBUG_VBLANK_EVADE=y
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_GMA600 is not set
# CONFIG_DRM_GMA3600 is not set
# CONFIG_DRM_AST is not set
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_LVDS is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=m
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
CONFIG_DRM_PANEL_LVDS=m
# CONFIG_DRM_PANEL_SIMPLE is not set
CONFIG_DRM_PANEL_ELIDA_KD35T133=m
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=m
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=m
CONFIG_DRM_PANEL_ILITEK_IL9322=m
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=m
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
# CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
CONFIG_DRM_PANEL_LG_LB035Q02=m
CONFIG_DRM_PANEL_LG_LG4573=m
# CONFIG_DRM_PANEL_NEC_NL8048HL11 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
CONFIG_DRM_PANEL_NOVATEK_NT39016=m
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
CONFIG_DRM_PANEL_RONBO_RB070D30=m
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
# CONFIG_DRM_PANEL_SONY_ACX424AKP is not set
CONFIG_DRM_PANEL_SONY_ACX565AKM=m
CONFIG_DRM_PANEL_TPO_TD028TTEC1=m
# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
CONFIG_DRM_PANEL_VISIONOX_RM69299=m
CONFIG_DRM_PANEL_XINPENG_XPP055C272=m
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=m
CONFIG_DRM_CHRONTEL_CH7033=m
CONFIG_DRM_DISPLAY_CONNECTOR=m
CONFIG_DRM_LONTIUM_LT9611=m
CONFIG_DRM_LVDS_CODEC=m
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
# CONFIG_DRM_NWL_MIPI_DSI is not set
CONFIG_DRM_NXP_PTN3460=m
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_PARADE_PS8640=m
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
CONFIG_DRM_SII9234=m
CONFIG_DRM_SIMPLE_BRIDGE=m
CONFIG_DRM_THINE_THC63LVD1024=m
CONFIG_DRM_TOSHIBA_TC358762=m
CONFIG_DRM_TOSHIBA_TC358764=m
CONFIG_DRM_TOSHIBA_TC358767=m
CONFIG_DRM_TOSHIBA_TC358768=m
CONFIG_DRM_TOSHIBA_TC358775=m
CONFIG_DRM_TI_TFP410=m
CONFIG_DRM_TI_SN65DSI86=m
CONFIG_DRM_TI_TPD12S015=m
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_I2C_ADV7511=m
# CONFIG_DRM_I2C_ADV7511_CEC is not set
# CONFIG_DRM_CDNS_MHDP8546 is not set
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=m
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_ARCPGU=m
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_TINYDRM_HX8357D is not set
CONFIG_TINYDRM_ILI9225=m
CONFIG_TINYDRM_ILI9341=m
# CONFIG_TINYDRM_ILI9486 is not set
CONFIG_TINYDRM_MI0283QT=m
# CONFIG_TINYDRM_REPAPER is not set
CONFIG_TINYDRM_ST7586=m
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
CONFIG_DRM_VIA=m
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=m
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=m
# CONFIG_FB_LE80578 is not set
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
# CONFIG_FB_MATROX_I2C is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=m
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
CONFIG_FB_VIA=m
CONFIG_FB_VIA_DIRECT_PROCFS=y
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
CONFIG_FB_3DFX_ACCEL=y
CONFIG_FB_3DFX_I2C=y
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=m
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=m
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_GOLDFISH=m
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_SSD1307 is not set
CONFIG_FB_SM712=m
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_LCD_OTM3225A=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_PWM=m
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_LM3630A=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_TPS65217=m
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=m
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

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
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_CLASS_MULTICOLOR=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=m
# CONFIG_LEDS_AW2013 is not set
CONFIG_LEDS_BCM6328=m
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_CPCAP=m
CONFIG_LEDS_CR0014114=m
CONFIG_LEDS_EL15203000=m
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=m
CONFIG_LEDS_MT6323=m
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=m
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8860=m
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=m
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_DAC124S085=m
CONFIG_LEDS_PWM=m
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_MAX77650 is not set
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_IS31FL319X=m
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_SPI_BYTE is not set
CONFIG_LEDS_TI_LMU_COMMON=m
CONFIG_LEDS_LM3697=m
# CONFIG_LEDS_LM36274 is not set
CONFIG_LEDS_TPS6105X=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=m
# CONFIG_LEDS_TRIGGER_AUDIO is not set
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
# CONFIG_EDAC_LEGACY_SYSFS is not set
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_E752X=m
# CONFIG_EDAC_I82975X is not set
CONFIG_EDAC_I3000=m
# CONFIG_EDAC_I3200 is not set
CONFIG_EDAC_IE31200=m
# CONFIG_EDAC_X38 is not set
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I5000=m
# CONFIG_EDAC_I5100 is not set
CONFIG_EDAC_I7300=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABEOZ9=m
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1307_CENTURY=y
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=m
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_RK808=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=m
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_RC5T619=m
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=m
CONFIG_RTC_DRV_RX8010=m
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV3028=m
CONFIG_RTC_DRV_RV3032=m
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_SD3078=m

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
CONFIG_RTC_DRV_M41T94=m
CONFIG_RTC_DRV_DS1302=y
CONFIG_RTC_DRV_DS1305=m
# CONFIG_RTC_DRV_DS1343 is not set
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
# CONFIG_RTC_DRV_MAX6916 is not set
CONFIG_RTC_DRV_R9701=y
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
CONFIG_RTC_DRV_RS5C348=m
CONFIG_RTC_DRV_MAX6902=m
CONFIG_RTC_DRV_PCF2123=m
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=m

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=m
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
CONFIG_RTC_DRV_DS17285=y
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=m
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_ZYNQMP=m
# CONFIG_RTC_DRV_CROS_EC is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=m
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_MT6397=m
CONFIG_RTC_DRV_R7301=y
CONFIG_RTC_DRV_CPCAP=m

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=m
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
CONFIG_UIO_MF624=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
CONFIG_VDPA=m
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=m
CONFIG_STAGING=y
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
# CONFIG_COMEDI_TEST is not set
# CONFIG_COMEDI_PARPORT is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
# CONFIG_COMEDI_PCL724 is not set
CONFIG_COMEDI_PCL726=m
# CONFIG_COMEDI_PCL730 is not set
# CONFIG_COMEDI_PCL812 is not set
CONFIG_COMEDI_PCL816=y
CONFIG_COMEDI_PCL818=m
CONFIG_COMEDI_PCM3724=m
# CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
# CONFIG_COMEDI_AMPLC_PC263_ISA is not set
CONFIG_COMEDI_RTI800=m
# CONFIG_COMEDI_RTI802 is not set
CONFIG_COMEDI_DAC02=m
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=y
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=m
CONFIG_COMEDI_DAS6402=m
CONFIG_COMEDI_DT2801=y
# CONFIG_COMEDI_DT2811 is not set
# CONFIG_COMEDI_DT2814 is not set
# CONFIG_COMEDI_DT2815 is not set
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=m
CONFIG_COMEDI_DMM32AT=y
CONFIG_COMEDI_FL512=y
CONFIG_COMEDI_AIO_AIO12_8=m
# CONFIG_COMEDI_AIO_IIRO_16 is not set
CONFIG_COMEDI_II_PCI20KC=y
CONFIG_COMEDI_C6XDIGIO=m
# CONFIG_COMEDI_MPC624 is not set
CONFIG_COMEDI_ADQ12B=y
# CONFIG_COMEDI_NI_AT_A2150 is not set
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=y
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=m
# CONFIG_COMEDI_PCMMIO is not set
# CONFIG_COMEDI_PCMUIO is not set
CONFIG_COMEDI_MULTIQ3=m
CONFIG_COMEDI_S526=y
CONFIG_COMEDI_PCI_DRIVERS=m
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=m
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
CONFIG_COMEDI_ADDI_APCI_1500=m
CONFIG_COMEDI_ADDI_APCI_1516=m
# CONFIG_COMEDI_ADDI_APCI_1564 is not set
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
CONFIG_COMEDI_ADDI_APCI_2032=m
# CONFIG_COMEDI_ADDI_APCI_2200 is not set
CONFIG_COMEDI_ADDI_APCI_3120=m
CONFIG_COMEDI_ADDI_APCI_3501=m
CONFIG_COMEDI_ADDI_APCI_3XXX=m
# CONFIG_COMEDI_ADL_PCI6208 is not set
CONFIG_COMEDI_ADL_PCI7X3X=m
CONFIG_COMEDI_ADL_PCI8164=m
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
# CONFIG_COMEDI_ADV_PCI1710 is not set
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
# CONFIG_COMEDI_ADV_PCI1724 is not set
CONFIG_COMEDI_ADV_PCI1760=m
CONFIG_COMEDI_ADV_PCI_DIO=m
# CONFIG_COMEDI_AMPLC_DIO200_PCI is not set
# CONFIG_COMEDI_AMPLC_PC236_PCI is not set
CONFIG_COMEDI_AMPLC_PC263_PCI=m
CONFIG_COMEDI_AMPLC_PCI224=m
# CONFIG_COMEDI_AMPLC_PCI230 is not set
CONFIG_COMEDI_CONTEC_PCI_DIO=m
# CONFIG_COMEDI_DAS08_PCI is not set
CONFIG_COMEDI_DT3000=m
CONFIG_COMEDI_DYNA_PCI10XX=m
CONFIG_COMEDI_GSC_HPDI=m
CONFIG_COMEDI_MF6X4=m
CONFIG_COMEDI_ICP_MULTI=m
# CONFIG_COMEDI_DAQBOARD2000 is not set
CONFIG_COMEDI_JR3_PCI=m
CONFIG_COMEDI_KE_COUNTER=m
CONFIG_COMEDI_CB_PCIDAS64=m
CONFIG_COMEDI_CB_PCIDAS=m
CONFIG_COMEDI_CB_PCIDDA=m
# CONFIG_COMEDI_CB_PCIMDAS is not set
CONFIG_COMEDI_CB_PCIMDDA=m
# CONFIG_COMEDI_ME4000 is not set
CONFIG_COMEDI_ME_DAQ=m
CONFIG_COMEDI_NI_6527=m
CONFIG_COMEDI_NI_65XX=m
CONFIG_COMEDI_NI_660X=m
CONFIG_COMEDI_NI_670X=m
CONFIG_COMEDI_NI_LABPC_PCI=m
CONFIG_COMEDI_NI_PCIDIO=m
CONFIG_COMEDI_NI_PCIMIO=m
CONFIG_COMEDI_RTD520=m
CONFIG_COMEDI_S626=m
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_NI_TIOCMD=m
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_RTLLIB is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=m
CONFIG_ADIS16240=m
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=m
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
CONFIG_AD2S1210=m
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
CONFIG_STAGING_MEDIA=y
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_IPU3_IMGU is not set

#
# Android
#
# end of Android

CONFIG_STAGING_BOARD=y
# CONFIG_GOLDFISH_AUDIO is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_GREYBUS_BOOTROM is not set
CONFIG_GREYBUS_FIRMWARE=m
# CONFIG_GREYBUS_HID is not set
CONFIG_GREYBUS_LIGHT=m
# CONFIG_GREYBUS_LOG is not set
CONFIG_GREYBUS_LOOPBACK=m
CONFIG_GREYBUS_POWER=m
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
CONFIG_GREYBUS_PWM=m
CONFIG_GREYBUS_SPI=m
# CONFIG_GREYBUS_UART is not set
CONFIG_PI433=y

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=m
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=m
CONFIG_CROS_EC_I2C=m
CONFIG_CROS_EC_SPI=m
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=m
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_MLXREG_IO=m
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_MAX9485=m
CONFIG_COMMON_CLK_RK808=m
CONFIG_COMMON_CLK_SI5341=m
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=m
CONFIG_COMMON_CLK_SI570=m
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_CDCE925=m
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_AMD_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

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
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=m
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=m

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_DMA=m
CONFIG_IIO_BUFFER_DMAENGINE=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
CONFIG_ADIS16201=m
CONFIG_ADIS16209=m
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
# CONFIG_ADXL345_SPI is not set
CONFIG_ADXL372=m
CONFIG_ADXL372_SPI=m
CONFIG_ADXL372_I2C=m
# CONFIG_BMA180 is not set
CONFIG_BMA220=m
CONFIG_BMA400=m
CONFIG_BMA400_I2C=m
CONFIG_BMA400_SPI=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=m
# CONFIG_DMARD10 is not set
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
CONFIG_KXSD9=m
# CONFIG_KXSD9_SPI is not set
# CONFIG_KXSD9_I2C is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7455_SPI=m
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=m
CONFIG_MXC4005=m
# CONFIG_MXC6255 is not set
CONFIG_SCA3000=m
CONFIG_STK8312=m
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
# CONFIG_AD7091R5 is not set
CONFIG_AD7124=m
CONFIG_AD7192=m
CONFIG_AD7266=m
# CONFIG_AD7291 is not set
CONFIG_AD7292=m
CONFIG_AD7298=m
CONFIG_AD7476=m
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD7606_IFACE_SPI=m
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
CONFIG_AD7791=m
CONFIG_AD7793=m
# CONFIG_AD7887 is not set
CONFIG_AD7923=m
CONFIG_AD7949=m
CONFIG_AD799X=m
CONFIG_AD9467=m
CONFIG_ADI_AXI_ADC=m
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
CONFIG_CC10001_ADC=m
CONFIG_CPCAP_ADC=m
CONFIG_ENVELOPE_DETECTOR=m
# CONFIG_HI8435 is not set
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=m
CONFIG_LTC2496=m
CONFIG_LTC2497=m
CONFIG_MAX1027=m
CONFIG_MAX11100=m
# CONFIG_MAX1118 is not set
CONFIG_MAX1241=m
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=m
CONFIG_MCP3422=m
CONFIG_MCP3911=m
CONFIG_NAU7802=m
CONFIG_RN5T618_ADC=m
CONFIG_SD_ADC_MODULATOR=m
CONFIG_STMPE_ADC=m
CONFIG_STX104=m
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=m
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=m
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS7950=m
CONFIG_TI_ADS8344=m
CONFIG_TI_ADS8688=m
CONFIG_TI_ADS124S08=m
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=m
CONFIG_VF610_ADC=m
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=m
CONFIG_HMC425=m
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_ATLAS_EZO_SENSOR is not set
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_BME680_SPI=m
CONFIG_CCS811=m
CONFIG_IAQCORE=m
CONFIG_SCD30_CORE=m
# CONFIG_SCD30_I2C is not set
CONFIG_SENSIRION_SGP30=m
CONFIG_SPS30=m
CONFIG_VZ89X=m
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
CONFIG_AD5380=m
# CONFIG_AD5421 is not set
CONFIG_AD5446=m
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
# CONFIG_AD5593R is not set
CONFIG_AD5504=m
CONFIG_AD5624R_SPI=m
CONFIG_AD5686=m
CONFIG_AD5686_SPI=m
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
CONFIG_AD5761=m
# CONFIG_AD5764 is not set
CONFIG_AD5770R=m
CONFIG_AD5791=m
CONFIG_AD7303=m
CONFIG_AD8801=m
# CONFIG_CIO_DAC is not set
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=m
# CONFIG_LTC1660 is not set
CONFIG_LTC2632=m
CONFIG_M62332=m
CONFIG_MAX517=m
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=m
CONFIG_MCP4922=m
CONFIG_TI_DAC082S085=m
CONFIG_TI_DAC5571=m
CONFIG_TI_DAC7311=m
# CONFIG_TI_DAC7612 is not set
CONFIG_VF610_DAC=m
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
CONFIG_ADF4371=m
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
# CONFIG_ADIS16130 is not set
CONFIG_ADIS16136=m
# CONFIG_ADIS16260 is not set
CONFIG_ADXRS290=m
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
CONFIG_FXAS21002C_SPI=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=m
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
CONFIG_AFE4404=m
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=m
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
CONFIG_HDC2010=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
CONFIG_SI7005=m
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
CONFIG_ADIS16460=m
CONFIG_ADIS16475=m
CONFIG_ADIS16480=m
CONFIG_BMI160=m
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=m
CONFIG_FXOS8700=m
CONFIG_FXOS8700_I2C=m
# CONFIG_FXOS8700_SPI is not set
CONFIG_KMX61=m
CONFIG_INV_ICM42600=m
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_ICM42600_SPI=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
CONFIG_AL3320A=m
CONFIG_APDS9300=m
# CONFIG_APDS9960 is not set
# CONFIG_AS73211 is not set
CONFIG_BH1750=m
CONFIG_BH1780=m
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
CONFIG_CM3605=m
# CONFIG_CM36651 is not set
CONFIG_GP2AP002=m
# CONFIG_GP2AP020A00F is not set
CONFIG_IQS621_ALS=m
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=m
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=m
CONFIG_PA12203001=m
CONFIG_SI1133=m
CONFIG_SI1145=m
CONFIG_STK3310=m
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=m
CONFIG_TSL4531=m
# CONFIG_US5182D is not set
CONFIG_VCNL4000=m
CONFIG_VCNL4035=m
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=m
CONFIG_VL6180=m
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=m
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
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
CONFIG_AD5272=m
CONFIG_DS1803=m
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=m
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
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
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
CONFIG_DLHL60D=m
# CONFIG_DPS310 is not set
CONFIG_HP03=m
CONFIG_ICP10100=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=m
CONFIG_MS5611=m
# CONFIG_MS5611_I2C is not set
CONFIG_MS5611_SPI=m
CONFIG_MS5637=m
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
CONFIG_HP206C=m
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=m
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
CONFIG_LIDAR_LITE_V2=m
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
CONFIG_RFD77402=m
CONFIG_SRF04=m
CONFIG_SX9310=m
# CONFIG_SX9500 is not set
CONFIG_SRF08=m
CONFIG_VCNL3020=m
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
CONFIG_AD2S1200=m
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=m
# CONFIG_LTC2983 is not set
CONFIG_MAXIM_THERMOCOUPLE=m
CONFIG_MLX90614=m
CONFIG_MLX90632=m
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=m
CONFIG_MAX31856=m
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
CONFIG_NTB_INTEL=m
# CONFIG_NTB_SWITCHTEC is not set
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
CONFIG_PWM_CROS_EC=m
CONFIG_PWM_FSL_FTM=m
CONFIG_PWM_IQS620A=m
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=m
CONFIG_PWM_STMPE=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MST_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=m
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_BRCMSTB_RESCAL=y
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_TI_SYSCON=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_USB_LGM_PHY is not set
CONFIG_BCM_KONA_USB2_PHY=m
# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_CADENCE_SALVO is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
CONFIG_PHY_MIXEL_MIPI_DPHY=y
CONFIG_PHY_PXA_28NM_HSIC=m
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=m
CONFIG_PHY_INTEL_LGM_COMBO=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=m
CONFIG_USB4_DEBUGFS_WRITE=y

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_DAX=m
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=m
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
# CONFIG_INTEL_TH_STH is not set
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=m
# CONFIG_ALTERA_PR_IP_CORE is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=m
CONFIG_FPGA_MGR_ICE40_SPI=m
CONFIG_FPGA_MGR_MACHXO2_SPI=m
CONFIG_FPGA_BRIDGE=m
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=m
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=m
# CONFIG_FPGA_DFL_FME is not set
CONFIG_FPGA_DFL_AFU=m
CONFIG_FPGA_DFL_PCI=m
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
# CONFIG_MUX_ADGS1408 is not set
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=m
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=m
# CONFIG_FTM_QUADDEC is not set
CONFIG_MICROCHIP_TCB_CAPTURE=y
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
# CONFIG_ECRYPT_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS=m
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_LZO_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lzo"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=m
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=m
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
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
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_KEY_NOTIFICATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
# CONFIG_INTEGRITY_ASYMMETRIC_KEYS is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
# CONFIG_IMA_DEFAULT_HASH_WP512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
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
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
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
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=m
CONFIG_CRYPTO_NHPOLY1305_SSE2=m
CONFIG_CRYPTO_NHPOLY1305_AVX2=m
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=m
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=m
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_RNG_CAVP=y
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
CONFIG_CRYPTO_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=y
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
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
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_GDB_SCRIPTS=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_STACK_VALIDATION=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
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
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_MISC=y
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
# CONFIG_PAGE_POISONING_ZERO is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=1
CONFIG_KASAN_VMALLOC=y
# CONFIG_TEST_KASAN_MODULE is not set
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
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
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
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
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
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
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
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_RCU_STRICT_GRACE_PERIOD is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
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
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_DYNAMIC_FTRACE is not set
CONFIG_FUNCTION_PROFILER=y
# CONFIG_STACK_TRACER is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_KPROBE_EVENTS is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACE_EVENT_INJECT=y
CONFIG_TRACEPOINT_BENCHMARK=y
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
CONFIG_HIST_TRIGGERS_DEBUG=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
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
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--shUZK62c1qujNoWl
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
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='rt-devel/linux-5.10.y-rt'
	export commit='3dc80c278022ec43b137216ac51e25a9468bf2d7'
	export kconfig='x86_64-randconfig-a014-20221212'
	export repeat_to=6
	export nr_vm=300
	export submit_id='6399c81ab4b1a4135d2878e9'
	export job_file='/lkp/jobs/scheduled/vm-meta-316/rcutorture-300s-cpuhotplug-srcu-debian-11.1-x86_64-20220510.cgz-3dc80c278022ec43b137216ac51e25a9468bf2d7-20221214-4957-1q61hs8-5.yaml'
	export id='4459343e986eee0ceee904f24bfcb7f76da912f9'
	export queuer_version='/zday/lkp'
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
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export compiler='gcc-11'
	export enqueue_time='2022-12-14 20:56:59 +0800'
	export _id='6399c831b4b1a4135d2878eb'
	export _rt='/result/rcutorture/300s-cpuhotplug-srcu/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/rcutorture/300s-cpuhotplug-srcu/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/3'
	export scheduler_version='/lkp/lkp/.src-20221213-145600'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/rcutorture/300s-cpuhotplug-srcu/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/3
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/vmlinuz-5.10.0-rc1-00006-g3dc80c278022
branch=rt-devel/linux-5.10.y-rt
job=/lkp/jobs/scheduled/vm-meta-316/rcutorture-300s-cpuhotplug-srcu-debian-11.1-x86_64-20220510.cgz-3dc80c278022ec43b137216ac51e25a9468bf2d7-20221214-4957-1q61hs8-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a014-20221212
commit=3dc80c278022ec43b137216ac51e25a9468bf2d7
vmalloc=256M initramfs_async=0 page_owner=on
initcall_debug
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
	export modules_initrd='/pkg/linux/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.kernel_BUG_at_kernel/sched/core.c'
	export kbuild_queue_analysis=1
	export meta_host='vm-meta-316'
	export kernel='/pkg/linux/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/vmlinuz-5.10.0-rc1-00006-g3dc80c278022'
	export dequeue_time='2022-12-14 20:57:26 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-316/rcutorture-300s-cpuhotplug-srcu-debian-11.1-x86_64-20220510.cgz-3dc80c278022ec43b137216ac51e25a9468bf2d7-20221214-4957-1q61hs8-5.cgz'

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

	run_test test='cpuhotplug' torture_type='srcu' $LKP_SRC/tests/wrapper rcutorture
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='cpuhotplug' torture_type='srcu' $LKP_SRC/stats/wrapper rcutorture
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time rcutorture.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--shUZK62c1qujNoWl
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
LRUAAb3vAdTTCjMBebexxGf7AgAAAAAEWVo=

--shUZK62c1qujNoWl
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="rcutorture"

early console in setup code
Probing EDD (edd=off to disable)... ok
early console in extract_kernel
input_data: 0x00000000058152e0
input_len: 0x00000000013e4714
output: 0x0000000001000000
output_len: 0x0000000004816a30
kernel_total_size: 0x0000000005c26000
needed_size: 0x0000000005e00000
trampoline_32bit: 0x000000000009d000

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
Linux version 5.10.0-rc1-00006-g3dc80c278022 (kbuild@7cee224d0a15) (gcc-11 (Debian 11.3.0-8) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39) #1 SMP Wed Dec 14 20:16:46 CST 2022
Command line: ip=::::vm-meta-316::dhcp root=/dev/ram0 RESULT_ROOT=/result/rcutorture/300s-cpuhotplug-srcu/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/3 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/vmlinuz-5.10.0-rc1-00006-g3dc80c278022 branch=rt-devel/linux-5.10.y-rt job=/lkp/jobs/scheduled/vm-meta-316/rcutorture-300s-cpuhotplug-srcu-debian-11.1-x86_64-20220510.cgz-3dc80c278022ec43b137216ac51e25a9468bf2d7-20221214-4957-1q61hs8-5.yaml user=lkp ARCH=x86_64 kconfig=x86_64-randconfig-a014-20221212 commit=3dc80c278022ec43b137216ac51e25a9468bf2d7 vmalloc=256M initramfs_async=0 page_owner=on initcall_debug max_uptime=1200 LKP_SERVER=internal-lkp-server selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2
KERNEL supported cpus:
CPU: vendor_id 'GenuineIntel' unknown, using generic init.
CPU: Your system may be unstable.
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000043fffffff] usable
printk: debug: ignoring loglevel setting.
printk: bootconsole [earlyser0] enabled
NX (Execute Disable) protection: active
SMBIOS 2.8 present.
DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
Hypervisor detected: KVM
kvm-clock: Using msrs 4b564d01 and 4b564d00
kvm-clock: cpu 0, msr 5433001, primary cpu clock
kvm-clock: using sched offset of 640479785 cycles
clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
tsc: Detected 2095.076 MHz processor
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x440000 max_arch_pfn = 0x400000000
MTRR default type: write-back
MTRR fixed ranges enabled:
00000-9FFFF write-back
A0000-BFFFF uncachable
C0000-FFFFF write-protect
MTRR variable ranges enabled:
0 base 00C0000000 mask FFC0000000 uncachable
1 disabled
2 disabled
3 disabled
4 disabled
5 disabled
6 disabled
7 disabled
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
last_pfn = 0xbffe0 max_arch_pfn = 0x400000000
Scan for SMP in [mem 0x00000000-0x000003ff]
Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Scan for SMP in [mem 0x000f0000-0x000fffff]
found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
mpc: f5bb0-f5c80
check: Scanning 1 areas for low memory corruption
RAMDISK: [mem 0xa92b0000-0xbffdffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F59B0 000014 (v00 BOCHS )
ACPI: RSDT 0x00000000BFFE199C 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: FACP 0x00000000BFFE1848 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: DSDT 0x00000000BFFE0040 001808 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: FACS 0x00000000BFFE0000 000040
ACPI: APIC 0x00000000BFFE18BC 000080 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: HPET 0x00000000BFFE193C 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: WAET 0x00000000BFFE1974 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: Local APIC address 0xfee00000
mapped APIC to ffffffffff5fc000 (        fee00000)
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x000000043fffffff]
NODE_DATA(0) allocated [mem 0x43ffd9000-0x43fff2fff]
Zone ranges:
DMA32    [mem 0x0000000000001000-0x00000000ffffffff]
Normal   [mem 0x0000000100000000-0x000000043fffffff]
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x000000000009efff]
node   0: [mem 0x0000000000100000-0x00000000bffdffff]
node   0: [mem 0x0000000100000000-0x000000043fffffff]
Zeroed struct page in unavailable ranges: 130 pages
Initmem setup node 0 [mem 0x0000000000001000-0x000000043fffffff]
On node 0 totalpages: 4194174
DMA32 zone: 12286 pages used for memmap
DMA32 zone: 21 pages reserved
DMA32 zone: 786302 pages, LIFO batch:63
Normal zone: 53248 pages used for memmap
Normal zone: 3407872 pages, LIFO batch:63
kasan: KernelAddressSanitizer initialized
ACPI: PM-Timer IO Port: 0x608
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
ACPI: IRQ0 used by override.
Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
ACPI: IRQ5 used by override.
Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
ACPI: IRQ9 used by override.
ACPI: IRQ10 used by override.
ACPI: IRQ11 used by override.
Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
TSC deadline timer available
smpboot: Allowing 2 CPUs, 0 hotplug CPUs
mapped IOAPIC to ffffffffff5fb000 (fec00000)
[mem 0xc0000000-0xfeffbfff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
percpu: Embedded 512 pages/cpu s2056856 r8192 d32104 u2097152
pcpu-alloc: s2056856 r8192 d32104 u2097152 alloc=1*2097152
pcpu-alloc: [0] 0 [0] 1 
kvm-guest: stealtime: cpu 0, msr 3a0421640
kvm-guest: PV spinlocks disabled, no host support
Built 1 zonelists, mobility grouping on.  Total pages: 4128619
Policy zone: Normal
Kernel command line: ip=::::vm-meta-316::dhcp root=/dev/ram0 RESULT_ROOT=/result/rcutorture/300s-cpuhotplug-srcu/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/3 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/vmlinuz-5.10.0-rc1-00006-g3dc80c278022 branch=rt-devel/linux-5.10.y-rt job=/lkp/jobs/scheduled/vm-meta-316/rcutorture-300s-cpuhotplug-srcu-debian-11.1-x86_64-20220510.cgz-3dc80c278022ec43b137216ac51e25a9468bf2d7-20221214-4957-1q61hs8-5.yaml user=lkp ARCH=x86_64 kconfig=x86_64-randconfig-a014-20221212 commit=3dc80c278022ec43b137216ac51e25a9468bf2d7 vmalloc=256M initramfs_async=0 page_owner=on initcall_debug max_uptime=1200 LKP_SERVER=internal-lkp-server selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ra
sysrq: sysrq always enabled.
ignoring the deprecated load_ramdisk= option
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
mem auto-init: stack:off, heap alloc:on, heap free:off
Memory: 13600520K/16776696K available (30728K kernel code, 14977K rwdata, 10612K rodata, 4240K init, 24488K bss, 3175920K reserved, 0K cma-reserved)
random: get_random_u64 called from cache_random_seq_create+0x66/0x150 with crng_init=0
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Kernel/User page tables isolation: enabled
Running RCU self tests
rcu: Hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
	Trampoline variant of Tasks RCU enabled.
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 4352, nr_irqs: 56, preallocated irqs: 16
calling  univ8250_console_init+0x0/0x27 @ 0
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
initcall univ8250_console_init+0x0/0x27 returned 0 after 0 usecs
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
memory used by lock dependency info: 6877 kB
memory used for stack traces: 4224 kB
per task-struct memory footprint: 2688 bytes
ACPI: Core revision 20200925
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
APIC: Switch to symmetric I/O mode setup
masked ExtINT on CPU#0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
apic 0 pin 0 not connected
IOAPIC[0]: Set routing entry (0-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-5 -> 0xef -> IRQ 5 Mode:1 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-9 -> 0xef -> IRQ 9 Mode:1 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-10 -> 0xef -> IRQ 10 Mode:1 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-11 -> 0xef -> IRQ 11 Mode:1 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:1)
IOAPIC[0]: Set routing entry (0-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:1)
apic 0 pin 16 not connected
apic 0 pin 17 not connected
apic 0 pin 18 not connected
apic 0 pin 19 not connected
apic 0 pin 20 not connected
apic 0 pin 21 not connected
apic 0 pin 22 not connected
apic 0 pin 23 not connected
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
tsc: Marking TSC unstable due to TSCs unsynchronized
Calibrating delay loop (skipped) preset value.. 4190.15 BogoMIPS (lpj=20950760)
pid_max: default: 4096 minimum: 301
LSM: Security Framework initializing
Yama: becoming mindful.
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
numa_add_cpu cpu 0 node 0: mask now 0
Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Mitigation: Full generic retpoline
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Speculative Store Bypass: Vulnerable
MDS: Vulnerable: Clear CPU buffers attempted, no microcode
Freeing SMP alternatives memory: 24K
smpboot: CPU0: GenuineIntel Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)
calling  init_hw_perf_events+0x0/0x3db @ 1
Performance Events: no PMU driver, software events only.
initcall init_hw_perf_events+0x0/0x3db returned 0 after 0 usecs
calling  init_real_mode+0x0/0xc1 @ 1
initcall init_real_mode+0x0/0xc1 returned 0 after 0 usecs
calling  trace_init_perf_perm_irq_work_exit+0x0/0x13 @ 1
initcall trace_init_perf_perm_irq_work_exit+0x0/0x13 returned 0 after 0 usecs
calling  validate_x2apic+0x0/0x97 @ 1
initcall validate_x2apic+0x0/0x97 returned 0 after 0 usecs
calling  register_nmi_cpu_backtrace_handler+0x0/0x16 @ 1
initcall register_nmi_cpu_backtrace_handler+0x0/0x16 returned 0 after 0 usecs
calling  kvm_setup_vsyscall_timeinfo+0x0/0x19e @ 1
initcall kvm_setup_vsyscall_timeinfo+0x0/0x19e returned 0 after 0 usecs
calling  spawn_ksoftirqd+0x0/0x46 @ 1
initcall spawn_ksoftirqd+0x0/0x46 returned 0 after 0 usecs
calling  migration_init+0x0/0x19 @ 1
initcall migration_init+0x0/0x19 returned 0 after 0 usecs
calling  srcu_bootup_announce+0x0/0x30 @ 1
rcu: Hierarchical SRCU implementation.
initcall srcu_bootup_announce+0x0/0x30 returned 0 after 0 usecs
calling  rcu_spawn_core_kthreads+0x0/0x186 @ 1
initcall rcu_spawn_core_kthreads+0x0/0x186 returned 0 after 0 usecs
calling  rcu_spawn_gp_kthread+0x0/0x1ad @ 1
initcall rcu_spawn_gp_kthread+0x0/0x1ad returned 0 after 0 usecs
calling  check_cpu_stall_init+0x0/0x1b @ 1
initcall check_cpu_stall_init+0x0/0x1b returned 0 after 0 usecs
calling  rcu_sysrq_init+0x0/0x3b @ 1
initcall rcu_sysrq_init+0x0/0x3b returned 0 after 0 usecs
calling  trace_init_flags_sys_enter+0x0/0xf @ 1
initcall trace_init_flags_sys_enter+0x0/0xf returned 0 after 0 usecs
calling  trace_init_flags_sys_exit+0x0/0xf @ 1
initcall trace_init_flags_sys_exit+0x0/0xf returned 0 after 0 usecs
calling  cpu_stop_init+0x0/0x177 @ 1
initcall cpu_stop_init+0x0/0x177 returned 0 after 0 usecs
calling  init_kprobes+0x0/0x331 @ 1
initcall init_kprobes+0x0/0x331 returned 0 after 0 usecs
calling  init_events+0x0/0x11a @ 1
initcall init_events+0x0/0x11a returned 0 after 0 usecs
calling  init_trace_printk+0x0/0xc @ 1
initcall init_trace_printk+0x0/0xc returned 0 after 0 usecs
calling  event_trace_enable_again+0x0/0x1f @ 1
initcall event_trace_enable_again+0x0/0x1f returned 0 after 0 usecs
calling  ok_to_run_trace_benchmark+0x0/0xa @ 1
initcall ok_to_run_trace_benchmark+0x0/0xa returned 0 after 0 usecs
calling  static_call_init+0x0/0x96 @ 1
initcall static_call_init+0x0/0x96 returned 0 after 0 usecs
calling  dynamic_debug_init+0x0/0x2f1 @ 1
initcall dynamic_debug_init+0x0/0x2f1 returned 0 after 9765 usecs
calling  initialize_ptr_random+0x0/0x42 @ 1
initcall initialize_ptr_random+0x0/0x42 returned 0 after 0 usecs
NMI watchdog: Perf NMI watchdog permanently disabled
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
kvm-clock: cpu 1, msr 5433041, secondary cpu clock
masked ExtINT on CPU#1
numa_add_cpu cpu 1 node 0: mask now 0-1
kvm-guest: stealtime: cpu 1, msr 3a0621640
MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
smp: Brought up 1 node, 2 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 2 processors activated (8380.30 BogoMIPS)
allocated 100663296 bytes of page_ext
Node 0, zone    DMA32: page owner found early allocated 6 pages
Node 0, zone   Normal: page owner found early allocated 25739 pages
devtmpfs: initialized
calling  ipc_ns_init+0x0/0x11a @ 1
initcall ipc_ns_init+0x0/0x11a returned 0 after 0 usecs
calling  init_mmap_min_addr+0x0/0x16 @ 1
initcall init_mmap_min_addr+0x0/0x16 returned 0 after 0 usecs
calling  pci_realloc_setup_params+0x0/0x41 @ 1
initcall pci_realloc_setup_params+0x0/0x41 returned 0 after 0 usecs
calling  net_ns_init+0x0/0x121 @ 1
initcall net_ns_init+0x0/0x121 returned 0 after 0 usecs
calling  e820__register_nvs_regions+0x0/0x14c @ 1
initcall e820__register_nvs_regions+0x0/0x14c returned 0 after 0 usecs
calling  reboot_init+0x0/0x51 @ 1
initcall reboot_init+0x0/0x51 returned 0 after 0 usecs
calling  wq_sysfs_init+0x0/0x2b @ 1
initcall wq_sysfs_init+0x0/0x2b returned 0 after 0 usecs
calling  ksysfs_init+0x0/0x99 @ 1
initcall ksysfs_init+0x0/0x99 returned 0 after 0 usecs
calling  rcu_set_runtime_mode+0x0/0x5f @ 1
initcall rcu_set_runtime_mode+0x0/0x5f returned 0 after 9765 usecs
calling  rcu_spawn_tasks_kthread+0x0/0x5c @ 1
initcall rcu_spawn_tasks_kthread+0x0/0x5c returned 0 after 0 usecs
calling  rcu_spawn_tasks_rude_kthread+0x0/0x1e @ 1
initcall rcu_spawn_tasks_rude_kthread+0x0/0x1e returned 0 after 0 usecs
calling  rcu_spawn_tasks_trace_kthread+0x0/0x5c @ 1
initcall rcu_spawn_tasks_trace_kthread+0x0/0x5c returned 0 after 0 usecs
calling  init_jiffies_clocksource+0x0/0x18 @ 1
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 0 usecs
calling  futex_init+0x0/0x1c4 @ 1
futex hash table entries: 16 (order: -1, 2048 bytes, linear)
initcall futex_init+0x0/0x1c4 returned 0 after 0 usecs
calling  cgroup_wq_init+0x0/0x36 @ 1
initcall cgroup_wq_init+0x0/0x36 returned 0 after 0 usecs
calling  cgroup1_wq_init+0x0/0x36 @ 1
initcall cgroup1_wq_init+0x0/0x36 returned 0 after 0 usecs
calling  ftrace_nodyn_init+0x0/0xd @ 1
initcall ftrace_nodyn_init+0x0/0xd returned 0 after 0 usecs
calling  init_irqsoff_tracer+0x0/0xf @ 1
initcall init_irqsoff_tracer+0x0/0xf returned 0 after 0 usecs
calling  init_wakeup_tracer+0x0/0x2d @ 1
initcall init_wakeup_tracer+0x0/0x2d returned 0 after 0 usecs
calling  init_graph_trace+0x0/0x91 @ 1
initcall init_graph_trace+0x0/0x91 returned 0 after 0 usecs
calling  trace_events_synth_init_early+0x0/0x27 @ 1
initcall trace_events_synth_init_early+0x0/0x27 returned 0 after 0 usecs
calling  init_zero_pfn+0x0/0xbb @ 1
initcall init_zero_pfn+0x0/0xbb returned 0 after 0 usecs
calling  cma_init_reserved_areas+0x0/0x45 @ 1
initcall cma_init_reserved_areas+0x0/0x45 returned 0 after 0 usecs
calling  fsnotify_init+0x0/0x87 @ 1
initcall fsnotify_init+0x0/0x87 returned 0 after 0 usecs
calling  filelock_init+0x0/0x17e @ 1
initcall filelock_init+0x0/0x17e returned 0 after 0 usecs
calling  init_misc_binfmt+0x0/0x31 @ 1
initcall init_misc_binfmt+0x0/0x31 returned 0 after 0 usecs
calling  init_script_binfmt+0x0/0x16 @ 1
initcall init_script_binfmt+0x0/0x16 returned 0 after 0 usecs
calling  init_elf_binfmt+0x0/0x16 @ 1
initcall init_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
calling  configfs_init+0x0/0xea @ 1
initcall configfs_init+0x0/0xea returned 0 after 0 usecs
calling  debugfs_init+0x0/0xb3 @ 1
initcall debugfs_init+0x0/0xb3 returned 0 after 0 usecs
calling  tracefs_init+0x0/0x63 @ 1
initcall tracefs_init+0x0/0x63 returned 0 after 0 usecs
calling  securityfs_init+0x0/0xba @ 1
initcall securityfs_init+0x0/0xba returned 0 after 0 usecs
calling  prandom_init_early+0x0/0x2cf @ 1
initcall prandom_init_early+0x0/0x2cf returned 0 after 0 usecs
calling  gpiolib_dev_init+0x0/0xe5 @ 1
initcall gpiolib_dev_init+0x0/0xe5 returned 0 after 0 usecs
calling  virtio_init+0x0/0x20 @ 1
initcall virtio_init+0x0/0x20 returned 0 after 0 usecs
calling  regulator_init+0x0/0x9c @ 1
regulator-dummy: no parameters, enabled
initcall regulator_init+0x0/0x9c returned 0 after 0 usecs
calling  component_debug_init+0x0/0x1d @ 1
initcall component_debug_init+0x0/0x1d returned 0 after 0 usecs
calling  opp_debug_init+0x0/0x1d @ 1
initcall opp_debug_init+0x0/0x1d returned 0 after 0 usecs
calling  cpuidle_init+0x0/0x46 @ 1
initcall cpuidle_init+0x0/0x46 returned 0 after 0 usecs
calling  sock_init+0x0/0xa0 @ 1
initcall sock_init+0x0/0xa0 returned 0 after 0 usecs
calling  net_inuse_init+0x0/0x29 @ 1
initcall net_inuse_init+0x0/0x29 returned 0 after 0 usecs
calling  net_defaults_init+0x0/0x29 @ 1
initcall net_defaults_init+0x0/0x29 returned 0 after 0 usecs
calling  init_default_flow_dissectors+0x0/0x50 @ 1
initcall init_default_flow_dissectors+0x0/0x50 returned 0 after 0 usecs
calling  netlink_proto_init+0x0/0x2a7 @ 1
NET: Registered protocol family 16
initcall netlink_proto_init+0x0/0x2a7 returned 0 after 0 usecs
calling  genl_init+0x0/0x43 @ 1
initcall genl_init+0x0/0x43 returned 0 after 0 usecs
calling  irq_sysfs_init+0x0/0xba @ 1
initcall irq_sysfs_init+0x0/0xba returned 0 after 9765 usecs
calling  audit_init+0x0/0x18a @ 1
audit: initializing netlink subsys (disabled)
initcall audit_init+0x0/0x18a returned 0 after 9765 usecs
calling  release_early_probes+0x0/0x59 @ 1
initcall release_early_probes+0x0/0x59 returned 0 after 0 usecs
calling  bdi_class_init+0x0/0x6d @ 1
initcall bdi_class_init+0x0/0x6d returned 0 after 0 usecs
calling  mm_sysfs_init+0x0/0x4f @ 1
initcall mm_sysfs_init+0x0/0x4f returned 0 after 0 usecs
calling  init_per_zone_wmark_min+0x0/0x69 @ 1
initcall init_per_zone_wmark_min+0x0/0x69 returned 0 after 0 usecs
calling  mpi_init+0x0/0x134 @ 1
initcall mpi_init+0x0/0x134 returned 0 after 0 usecs
calling  kobject_uevent_init+0x0/0xc @ 1
initcall kobject_uevent_init+0x0/0xc returned 0 after 0 usecs
audit: type=2000 audit(1671022678.637:1): state=initialized audit_enabled=0 res=1
calling  mhi_init+0x0/0x16 @ 1
initcall mhi_init+0x0/0x16 returned 0 after 0 usecs
calling  acpi_gpio_setup_params+0x0/0xf3 @ 1
initcall acpi_gpio_setup_params+0x0/0xf3 returned 0 after 0 usecs
calling  pcibus_class_init+0x0/0x18 @ 1
initcall pcibus_class_init+0x0/0x18 returned 0 after 0 usecs
calling  pci_driver_init+0x0/0x11 @ 1
initcall pci_driver_init+0x0/0x11 returned 0 after 0 usecs
calling  rio_bus_init+0x0/0x46 @ 1
initcall rio_bus_init+0x0/0x46 returned 0 after 0 usecs
calling  backlight_class_init+0x0/0xee @ 1
initcall backlight_class_init+0x0/0xee returned 0 after 0 usecs
calling  tty_class_init+0x0/0x58 @ 1
initcall tty_class_init+0x0/0x58 returned 0 after 0 usecs
calling  mipi_dsi_bus_init+0x0/0x11 @ 1
initcall mipi_dsi_bus_init+0x0/0x11 returned 0 after 0 usecs
calling  devlink_class_init+0x0/0x46 @ 1
initcall devlink_class_init+0x0/0x46 returned 0 after 0 usecs
calling  software_node_init+0x0/0x51 @ 1
initcall software_node_init+0x0/0x51 returned 0 after 0 usecs
calling  isa_bus_init+0x0/0x3f @ 1
initcall isa_bus_init+0x0/0x3f returned 0 after 0 usecs
calling  register_node_type+0x0/0x18 @ 1
initcall register_node_type+0x0/0x18 returned 0 after 0 usecs
calling  regmap_initcall+0x0/0xd @ 1
initcall regmap_initcall+0x0/0xd returned 0 after 0 usecs
calling  syscon_init+0x0/0x13 @ 1
initcall syscon_init+0x0/0x13 returned 0 after 0 usecs
calling  spi_init+0x0/0xf3 @ 1
initcall spi_init+0x0/0xf3 returned 0 after 0 usecs
calling  hsi_init+0x0/0x11 @ 1
initcall hsi_init+0x0/0x11 returned 0 after 0 usecs
calling  thermal_init+0x0/0x1b6 @ 1
thermal_sys: Registered thermal governor 'step_wise'
initcall thermal_init+0x0/0x1b6 returned 0 after 0 usecs
calling  eisa_init+0x0/0x2c @ 1
EISA bus registered
initcall eisa_init+0x0/0x2c returned 0 after 0 usecs
calling  init_ladder+0x0/0x6d @ 1
cpuidle: using governor ladder
initcall init_ladder+0x0/0x6d returned 0 after 39062 usecs
calling  teo_governor_init+0x0/0x11 @ 1
cpuidle: using governor teo
initcall teo_governor_init+0x0/0x11 returned 0 after 0 usecs
calling  sdw_bus_init+0x0/0x16 @ 1
initcall sdw_bus_init+0x0/0x16 returned 0 after 0 usecs
calling  qrtr_proto_init+0x0/0x4b @ 1
NET: Registered protocol family 42
initcall qrtr_proto_init+0x0/0x4b returned 0 after 9765 usecs
calling  broadcom_postcore_init+0x0/0x8a @ 1
initcall broadcom_postcore_init+0x0/0x8a returned 0 after 0 usecs
calling  moxtet_init+0x0/0x64 @ 1
initcall moxtet_init+0x0/0x64 returned 0 after 0 usecs
calling  boot_params_ksysfs_init+0x0/0x92 @ 1
initcall boot_params_ksysfs_init+0x0/0x92 returned 0 after 0 usecs
calling  sbf_init+0x0/0xcf @ 1
initcall sbf_init+0x0/0xcf returned 0 after 0 usecs
calling  arch_kdebugfs_init+0x0/0x1d @ 1
initcall arch_kdebugfs_init+0x0/0x1d returned 0 after 0 usecs
calling  mtrr_if_init+0x0/0x143 @ 1
initcall mtrr_if_init+0x0/0x143 returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x60 @ 1
initcall activate_jump_labels+0x0/0x60 returned 0 after 0 usecs
calling  ffh_cstate_init+0x0/0x5b @ 1
initcall ffh_cstate_init+0x0/0x5b returned -1 after 0 usecs
calling  activate_jump_labels+0x0/0x32 @ 1
initcall activate_jump_labels+0x0/0x32 returned 0 after 0 usecs
calling  kvm_alloc_cpumask+0x0/0x196 @ 1
initcall kvm_alloc_cpumask+0x0/0x196 returned 0 after 0 usecs
calling  gigantic_pages_init+0x0/0x57 @ 1
initcall gigantic_pages_init+0x0/0x57 returned 0 after 0 usecs
calling  kcmp_cookies_init+0x0/0xf1 @ 1
initcall kcmp_cookies_init+0x0/0xf1 returned 0 after 0 usecs
calling  cryptomgr_init+0x0/0x11 @ 1
initcall cryptomgr_init+0x0/0x11 returned 0 after 0 usecs
calling  acpi_pci_init+0x0/0x114 @ 1
ACPI: bus type PCI registered
initcall acpi_pci_init+0x0/0x114 returned 0 after 0 usecs
calling  dmi_id_init+0x0/0x168 @ 1
initcall dmi_id_init+0x0/0x168 returned 0 after 0 usecs
calling  pci_arch_init+0x0/0x10c @ 1
PCI: Using configuration type 1 for base access
initcall pci_arch_init+0x0/0x10c returned 0 after 9765 usecs
calling  of_platform_default_populate_init+0x0/0xbd @ 1
initcall of_platform_default_populate_init+0x0/0xbd returned -19 after 0 usecs
calling  init_vdso+0x0/0x14 @ 1
initcall init_vdso+0x0/0x14 returned 0 after 0 usecs
calling  topology_init+0x0/0xea @ 1
initcall topology_init+0x0/0xea returned 0 after 0 usecs
calling  mtrr_init_finialize+0x0/0x6e @ 1
initcall mtrr_init_finialize+0x0/0x6e returned 0 after 0 usecs
calling  eisa_bus_probe+0x0/0x70 @ 1
initcall eisa_bus_probe+0x0/0x70 returned 0 after 0 usecs
calling  uid_cache_init+0x0/0xf8 @ 1
initcall uid_cache_init+0x0/0xf8 returned 0 after 0 usecs
calling  param_sysfs_init+0x0/0xf0 @ 1
initcall param_sysfs_init+0x0/0xf0 returned 0 after 39062 usecs
calling  user_namespace_sysctl_init+0x0/0x4e @ 1
initcall user_namespace_sysctl_init+0x0/0x4e returned 0 after 0 usecs
calling  proc_schedstat_init+0x0/0x25 @ 1
initcall proc_schedstat_init+0x0/0x25 returned 0 after 0 usecs
calling  pm_sysrq_init+0x0/0x19 @ 1
initcall pm_sysrq_init+0x0/0x19 returned 0 after 0 usecs
calling  crash_save_vmcoreinfo_init+0x0/0x8a0 @ 1
initcall crash_save_vmcoreinfo_init+0x0/0x8a0 returned 0 after 0 usecs
calling  crash_notes_memory_init+0x0/0x39 @ 1
initcall crash_notes_memory_init+0x0/0x39 returned 0 after 0 usecs
calling  cgroup_sysfs_init+0x0/0x3e @ 1
initcall cgroup_sysfs_init+0x0/0x3e returned 0 after 0 usecs
calling  cgroup_namespaces_init+0x0/0x8 @ 1
initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs
calling  hung_task_init+0x0/0x4f @ 1
initcall hung_task_init+0x0/0x4f returned 0 after 0 usecs
calling  send_signal_irq_work_init+0x0/0x14a @ 1
initcall send_signal_irq_work_init+0x0/0x14a returned 0 after 0 usecs
calling  dev_map_init+0x0/0x133 @ 1
initcall dev_map_init+0x0/0x133 returned 0 after 0 usecs
calling  cpu_map_init+0x0/0x127 @ 1
initcall cpu_map_init+0x0/0x127 returned 0 after 0 usecs
calling  netns_bpf_init+0x0/0x11 @ 1
initcall netns_bpf_init+0x0/0x11 returned 0 after 0 usecs
calling  stack_map_init+0x0/0x14f @ 1
initcall stack_map_init+0x0/0x14f returned 0 after 0 usecs
calling  btf_vmlinux_init+0x0/0x7d @ 1
initcall btf_vmlinux_init+0x0/0x7d returned 0 after 0 usecs
calling  oom_init+0x0/0x30 @ 1
initcall oom_init+0x0/0x30 returned 0 after 9765 usecs
calling  default_bdi_init+0x0/0x36 @ 1
initcall default_bdi_init+0x0/0x36 returned 0 after 9765 usecs
calling  percpu_enable_async+0x0/0xf @ 1
initcall percpu_enable_async+0x0/0xf returned 0 after 0 usecs
calling  kcompactd_init+0x0/0x98 @ 1
initcall kcompactd_init+0x0/0x98 returned 0 after 0 usecs
calling  init_user_reserve+0x0/0xa0 @ 1
initcall init_user_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_admin_reserve+0x0/0xa0 @ 1
initcall init_admin_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_reserve_notifier+0x0/0x3 @ 1
initcall init_reserve_notifier+0x0/0x3 returned 0 after 0 usecs
calling  hugetlb_init+0x0/0x652 @ 1
HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
initcall hugetlb_init+0x0/0x652 returned 0 after 0 usecs
calling  ksm_init+0x0/0x23a @ 1
initcall ksm_init+0x0/0x23a returned 0 after 9765 usecs
calling  hugepage_init+0x0/0x1a2 @ 1
initcall hugepage_init+0x0/0x1a2 returned 0 after 9765 usecs
calling  io_wq_init+0x0/0x35 @ 1
initcall io_wq_init+0x0/0x35 returned 0 after 0 usecs
calling  seqiv_module_init+0x0/0x11 @ 1
initcall seqiv_module_init+0x0/0x11 returned 0 after 0 usecs
calling  dh_init+0x0/0x20 @ 1
initcall dh_init+0x0/0x20 returned 0 after 9765 usecs
calling  rsa_init+0x0/0x50 @ 1
initcall rsa_init+0x0/0x50 returned 0 after 0 usecs
calling  hmac_module_init+0x0/0x11 @ 1
initcall hmac_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_null_mod_init+0x0/0x6d @ 1
initcall crypto_null_mod_init+0x0/0x6d returned 0 after 0 usecs
calling  md5_mod_init+0x0/0x11 @ 1
initcall md5_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  sha1_generic_mod_init+0x0/0x11 @ 1
initcall sha1_generic_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  sha256_generic_mod_init+0x0/0x16 @ 1
initcall sha256_generic_mod_init+0x0/0x16 returned 0 after 0 usecs
calling  sha512_generic_mod_init+0x0/0x16 @ 1
initcall sha512_generic_mod_init+0x0/0x16 returned 0 after 9765 usecs
calling  wp512_mod_init+0x0/0x16 @ 1
initcall wp512_mod_init+0x0/0x16 returned 0 after 0 usecs
calling  crypto_ecb_module_init+0x0/0x11 @ 1
initcall crypto_ecb_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_cbc_module_init+0x0/0x11 @ 1
initcall crypto_cbc_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_cfb_module_init+0x0/0x11 @ 1
initcall crypto_cfb_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_pcbc_module_init+0x0/0x11 @ 1
initcall crypto_pcbc_module_init+0x0/0x11 returned 0 after 0 usecs
calling  lrw_module_init+0x0/0x11 @ 1
initcall lrw_module_init+0x0/0x11 returned 0 after 0 usecs
calling  xts_module_init+0x0/0x11 @ 1
initcall xts_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_ctr_module_init+0x0/0x16 @ 1
initcall crypto_ctr_module_init+0x0/0x16 returned 0 after 0 usecs
calling  crypto_gcm_module_init+0x0/0x5e @ 1
initcall crypto_gcm_module_init+0x0/0x5e returned 0 after 0 usecs
calling  crypto_aegis128_module_init+0x0/0x11 @ 1
initcall crypto_aegis128_module_init+0x0/0x11 returned 0 after 9765 usecs
calling  pcrypt_init+0x0/0xb8 @ 1
initcall pcrypt_init+0x0/0xb8 returned 0 after 0 usecs
calling  cryptd_init+0x0/0x227 @ 1
cryptd: max_cpu_qlen set to 1000
initcall cryptd_init+0x0/0x227 returned 0 after 0 usecs
calling  serpent_mod_init+0x0/0x16 @ 1
initcall serpent_mod_init+0x0/0x16 returned 0 after 0 usecs
calling  aes_init+0x0/0x11 @ 1
initcall aes_init+0x0/0x11 returned 0 after 0 usecs
calling  sm4_init+0x0/0x11 @ 1
initcall sm4_init+0x0/0x11 returned 0 after 0 usecs
calling  cast5_mod_init+0x0/0x11 @ 1
initcall cast5_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  cast6_mod_init+0x0/0x11 @ 1
initcall cast6_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  chacha_generic_mod_init+0x0/0x16 @ 1
initcall chacha_generic_mod_init+0x0/0x16 returned 0 after 0 usecs
calling  deflate_mod_init+0x0/0x44 @ 1
initcall deflate_mod_init+0x0/0x44 returned 0 after 0 usecs
calling  crc32_mod_init+0x0/0x11 @ 1
initcall crc32_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_authenc_module_init+0x0/0x11 @ 1
initcall crypto_authenc_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_authenc_esn_module_init+0x0/0x11 @ 1
initcall crypto_authenc_esn_module_init+0x0/0x11 returned 0 after 0 usecs
calling  lzo_mod_init+0x0/0x3f @ 1
initcall lzo_mod_init+0x0/0x3f returned 0 after 9765 usecs
calling  lzorle_mod_init+0x0/0x3f @ 1
initcall lzorle_mod_init+0x0/0x3f returned 0 after 0 usecs
calling  lz4hc_mod_init+0x0/0x3f @ 1
initcall lz4hc_mod_init+0x0/0x3f returned 0 after 9765 usecs
calling  xxhash_mod_init+0x0/0x11 @ 1
initcall xxhash_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto842_mod_init+0x0/0x3f @ 1
initcall crypto842_mod_init+0x0/0x3f returned 0 after 0 usecs
calling  drbg_init+0x0/0xe4 @ 1
initcall drbg_init+0x0/0xe4 returned 0 after 9765 usecs
calling  ghash_mod_init+0x0/0x11 @ 1
initcall ghash_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  zstd_mod_init+0x0/0x3f @ 1
initcall zstd_mod_init+0x0/0x3f returned 0 after 9765 usecs
calling  essiv_module_init+0x0/0x11 @ 1
initcall essiv_module_init+0x0/0x11 returned 0 after 0 usecs
calling  curve25519_init+0x0/0x20 @ 1
initcall curve25519_init+0x0/0x20 returned 0 after 0 usecs
calling  ecdh_init+0x0/0x20 @ 1
initcall ecdh_init+0x0/0x20 returned 0 after 0 usecs
calling  irq_poll_setup+0x0/0x152 @ 1
initcall irq_poll_setup+0x0/0x152 returned 0 after 0 usecs
calling  gpiolib_debugfs_init+0x0/0x24 @ 1
initcall gpiolib_debugfs_init+0x0/0x24 returned 0 after 0 usecs
calling  f7188x_gpio_init+0x0/0x12f @ 1
initcall f7188x_gpio_init+0x0/0x12f returned -19 after 0 usecs
calling  mc33880_init+0x0/0x13 @ 1
initcall mc33880_init+0x0/0x13 returned 0 after 0 usecs
calling  stmpe_gpio_init+0x0/0x13 @ 1
initcall stmpe_gpio_init+0x0/0x13 returned 0 after 0 usecs
calling  pwm_debugfs_init+0x0/0x24 @ 1
initcall pwm_debugfs_init+0x0/0x24 returned 0 after 0 usecs
calling  pwm_sysfs_init+0x0/0x18 @ 1
initcall pwm_sysfs_init+0x0/0x18 returned 0 after 0 usecs
calling  pci_slot_init+0x0/0x40 @ 1
initcall pci_slot_init+0x0/0x40 returned 0 after 9765 usecs
calling  acpi_init+0x0/0x225 @ 1
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
ACPI: 1 ACPI AML tables successfully acquired and loaded
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: Enabled 2 GPEs in block 00 to 0F
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A03:00: _OSC: OS supports [Segments HPX-Type3]
acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
pci_bus 0000:00: root bus resource [mem 0x440000000-0x4bfffffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x80 @ 1
pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x80 took 0 usecs
pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
pci 0000:00:01.3: calling  acpi_pm_check_blacklist+0x0/0x50 @ 1
pci 0000:00:01.3: acpi_pm_check_blacklist+0x0/0x50 took 0 usecs
pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
pci 0000:00:01.3: calling  quirk_piix4_acpi+0x0/0x1a0 @ 1
pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
pci 0000:00:01.3: quirk_piix4_acpi+0x0/0x1a0 took 0 usecs
pci 0000:00:01.3: calling  pci_fixup_piix4_acpi+0x0/0x50 @ 1
pci 0000:00:01.3: pci_fixup_piix4_acpi+0x0/0x50 took 0 usecs
pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
pci 0000:00:03.0: calling  quirk_f0_vpd_link+0x0/0x210 @ 1
pci 0000:00:03.0: quirk_f0_vpd_link+0x0/0x210 took 0 usecs
pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000
pci 0000:00:04.0: reg 0x10: [mem 0xfebf1000-0xfebf100f]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
initcall acpi_init+0x0/0x225 returned 0 after 410156 usecs
calling  pnp_init+0x0/0x11 @ 1
initcall pnp_init+0x0/0x11 returned 0 after 0 usecs
calling  misc_init+0x0/0xe4 @ 1
initcall misc_init+0x0/0xe4 returned 0 after 0 usecs
calling  tpm_init+0x0/0x218 @ 1
initcall tpm_init+0x0/0x218 returned 0 after 0 usecs
calling  tifm_init+0x0/0x81 @ 1
initcall tifm_init+0x0/0x81 returned 0 after 0 usecs
calling  stmpe_init+0x0/0x13 @ 1
initcall stmpe_init+0x0/0x13 returned 0 after 0 usecs
calling  dma_buf_init+0x0/0xcc @ 1
initcall dma_buf_init+0x0/0xcc returned 0 after 0 usecs
calling  dma_resv_lockdep+0x0/0x3a4 @ 1
initcall dma_resv_lockdep+0x0/0x3a4 returned 0 after 0 usecs
calling  pxa2xx_spi_init+0x0/0x13 @ 1
initcall pxa2xx_spi_init+0x0/0x13 returned 0 after 0 usecs
calling  xdbc_init+0x0/0x151 @ 1
initcall xdbc_init+0x0/0x151 returned 0 after 0 usecs
calling  serio_init+0x0/0x2e @ 1
initcall serio_init+0x0/0x2e returned 0 after 0 usecs
calling  gameport_init+0x0/0x2e @ 1
initcall gameport_init+0x0/0x2e returned 0 after 0 usecs
calling  input_init+0x0/0x104 @ 1
initcall input_init+0x0/0x104 returned 0 after 0 usecs
calling  rtc_init+0x0/0x6c @ 1
initcall rtc_init+0x0/0x6c returned 0 after 0 usecs
calling  media_devnode_init+0x0/0x7d @ 1
mc: Linux media interface: v0.10
initcall media_devnode_init+0x0/0x7d returned 0 after 0 usecs
calling  power_supply_class_init+0x0/0x64 @ 1
initcall power_supply_class_init+0x0/0x64 returned 0 after 0 usecs
calling  hwmon_init+0x0/0x153 @ 1
initcall hwmon_init+0x0/0x153 returned 0 after 0 usecs
calling  dmi_init+0x0/0x142 @ 1
initcall dmi_init+0x0/0x142 returned 0 after 0 usecs
calling  remoteproc_init+0x0/0x30 @ 1
initcall remoteproc_init+0x0/0x30 returned 0 after 0 usecs
calling  devfreq_init+0x0/0xf4 @ 1
initcall devfreq_init+0x0/0xf4 returned 0 after 0 usecs
calling  devfreq_event_init+0x0/0x73 @ 1
initcall devfreq_event_init+0x0/0x73 returned 0 after 0 usecs
calling  devfreq_simple_ondemand_init+0x0/0x11 @ 1
initcall devfreq_simple_ondemand_init+0x0/0x11 returned 0 after 0 usecs
calling  devfreq_performance_init+0x0/0x11 @ 1
initcall devfreq_performance_init+0x0/0x11 returned 0 after 0 usecs
calling  devfreq_passive_init+0x0/0x11 @ 1
initcall devfreq_passive_init+0x0/0x11 returned 0 after 0 usecs
calling  ras_init+0x0/0xf @ 1
initcall ras_init+0x0/0xf returned 0 after 0 usecs
calling  nvmem_init+0x0/0x11 @ 1
initcall nvmem_init+0x0/0x11 returned 0 after 0 usecs
calling  mux_init+0x0/0x4c @ 1
initcall mux_init+0x0/0x4c returned 0 after 0 usecs
calling  counter_init+0x0/0x11 @ 1
initcall counter_init+0x0/0x11 returned 0 after 0 usecs
calling  proto_init+0x0/0x11 @ 1
initcall proto_init+0x0/0x11 returned 0 after 0 usecs
calling  net_dev_init+0x0/0x48b @ 1
initcall net_dev_init+0x0/0x48b returned 0 after 0 usecs
calling  neigh_init+0x0/0x85 @ 1
initcall neigh_init+0x0/0x85 returned 0 after 0 usecs
calling  fib_notifier_init+0x0/0x11 @ 1
initcall fib_notifier_init+0x0/0x11 returned 0 after 0 usecs
calling  bpf_lwt_init+0x0/0x16 @ 1
initcall bpf_lwt_init+0x0/0x16 returned 0 after 0 usecs
calling  pktsched_init+0x0/0x113 @ 1
initcall pktsched_init+0x0/0x113 returned 0 after 0 usecs
calling  tc_filter_init+0x0/0x100 @ 1
initcall tc_filter_init+0x0/0x100 returned 0 after 0 usecs
calling  tc_action_init+0x0/0x55 @ 1
initcall tc_action_init+0x0/0x55 returned 0 after 0 usecs
calling  ethnl_init+0x0/0x60 @ 1
initcall ethnl_init+0x0/0x60 returned 0 after 0 usecs
calling  nexthop_init+0x0/0xd9 @ 1
initcall nexthop_init+0x0/0xd9 returned 0 after 0 usecs
calling  rfkill_init+0x0/0x191 @ 1
initcall rfkill_init+0x0/0x191 returned 0 after 0 usecs
calling  pci_subsys_init+0x0/0x124 @ 1
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]
initcall pci_subsys_init+0x0/0x124 returned 0 after 9765 usecs
calling  nmi_warning_debugfs+0x0/0x4d @ 1
initcall nmi_warning_debugfs+0x0/0x4d returned 0 after 0 usecs
calling  hpet_late_init+0x0/0x103 @ 1
initcall hpet_late_init+0x0/0x103 returned 0 after 0 usecs
calling  clocksource_done_booting+0x0/0x44 @ 1
clocksource: Switched to clocksource kvm-clock
initcall clocksource_done_booting+0x0/0x44 returned 0 after 913 usecs
calling  tracer_init_tracefs+0x0/0x386 @ 1
initcall tracer_init_tracefs+0x0/0x386 returned 0 after 436004 usecs
calling  init_trace_printk_function_export+0x0/0x28 @ 1
initcall init_trace_printk_function_export+0x0/0x28 returned 0 after 69 usecs
calling  init_graph_tracefs+0x0/0x28 @ 1
initcall init_graph_tracefs+0x0/0x28 returned 0 after 70 usecs
calling  trace_events_synth_init+0x0/0x47 @ 1
initcall trace_events_synth_init+0x0/0x47 returned 0 after 61 usecs
calling  bpf_event_init+0x0/0xf @ 1
initcall bpf_event_init+0x0/0xf returned 0 after 5 usecs
calling  init_dynamic_event+0x0/0x39 @ 1
initcall init_dynamic_event+0x0/0x39 returned 0 after 106 usecs
calling  init_uprobe_trace+0x0/0x5c @ 1
initcall init_uprobe_trace+0x0/0x5c returned 0 after 103 usecs
calling  bpf_init+0x0/0xb3 @ 1
initcall bpf_init+0x0/0xb3 returned 0 after 68 usecs
calling  init_pipe_fs+0x0/0x4a @ 1
initcall init_pipe_fs+0x0/0x4a returned 0 after 460 usecs
calling  inotify_user_setup+0x0/0xaa @ 1
initcall inotify_user_setup+0x0/0xaa returned 0 after 62 usecs
calling  eventpoll_init+0x0/0x116 @ 1
initcall eventpoll_init+0x0/0x116 returned 0 after 101 usecs
calling  anon_inode_init+0x0/0x8a @ 1
initcall anon_inode_init+0x0/0x8a returned 0 after 496 usecs
calling  proc_locks_init+0x0/0x28 @ 1
initcall proc_locks_init+0x0/0x28 returned 0 after 25 usecs
calling  proc_cmdline_init+0x0/0x22 @ 1
initcall proc_cmdline_init+0x0/0x22 returned 0 after 26 usecs
calling  proc_consoles_init+0x0/0x25 @ 1
initcall proc_consoles_init+0x0/0x25 returned 0 after 28 usecs
calling  proc_cpuinfo_init+0x0/0x1f @ 1
initcall proc_cpuinfo_init+0x0/0x1f returned 0 after 27 usecs
calling  proc_devices_init+0x0/0x25 @ 1
initcall proc_devices_init+0x0/0x25 returned 0 after 27 usecs
calling  proc_interrupts_init+0x0/0x25 @ 1
initcall proc_interrupts_init+0x0/0x25 returned 0 after 26 usecs
calling  proc_loadavg_init+0x0/0x22 @ 1
initcall proc_loadavg_init+0x0/0x22 returned 0 after 26 usecs
calling  proc_meminfo_init+0x0/0x22 @ 1
initcall proc_meminfo_init+0x0/0x22 returned 0 after 26 usecs
calling  proc_stat_init+0x0/0x1f @ 1
initcall proc_stat_init+0x0/0x1f returned 0 after 48 usecs
calling  proc_uptime_init+0x0/0x22 @ 1
initcall proc_uptime_init+0x0/0x22 returned 0 after 25 usecs
calling  proc_version_init+0x0/0x22 @ 1
initcall proc_version_init+0x0/0x22 returned 0 after 24 usecs
calling  proc_softirqs_init+0x0/0x22 @ 1
initcall proc_softirqs_init+0x0/0x22 returned 0 after 25 usecs
calling  proc_kcore_init+0x0/0x148 @ 1
initcall proc_kcore_init+0x0/0x148 returned 0 after 236 usecs
calling  vmcore_init+0x0/0x297 @ 1
initcall vmcore_init+0x0/0x297 returned 0 after 2 usecs
calling  proc_kmsg_init+0x0/0x22 @ 1
initcall proc_kmsg_init+0x0/0x22 returned 0 after 30 usecs
calling  proc_page_init+0x0/0x3c @ 1
initcall proc_page_init+0x0/0x3c returned 0 after 41 usecs
calling  fscache_init+0x0/0x308 @ 1
FS-Cache: Loaded
initcall fscache_init+0x0/0x308 returned 0 after 1212 usecs
calling  init_ramfs_fs+0x0/0x11 @ 1
initcall init_ramfs_fs+0x0/0x11 returned 0 after 7 usecs
calling  init_hugetlbfs_fs+0x0/0x331 @ 1
initcall init_hugetlbfs_fs+0x0/0x331 returned 0 after 560 usecs
calling  dynamic_debug_init_control+0x0/0x7c @ 1
initcall dynamic_debug_init_control+0x0/0x7c returned 0 after 211 usecs
calling  acpi_event_init+0x0/0x61 @ 1
initcall acpi_event_init+0x0/0x61 returned 0 after 162 usecs
calling  pnp_system_init+0x0/0x11 @ 1
initcall pnp_system_init+0x0/0x11 returned 0 after 157 usecs
calling  pnpacpi_init+0x0/0xd2 @ 1
pnp: PnP ACPI init
pnp 00:00: Plug and Play ACPI device, IDs PNP0303 (active)
pnp 00:01: Plug and Play ACPI device, IDs PNP0f13 (active)
pnp 00:02: [dma 2]
pnp 00:02: Plug and Play ACPI device, IDs PNP0700 (active)
pnp 00:03: Plug and Play ACPI device, IDs PNP0400 (active)
pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
pnp: PnP ACPI: found 7 devices
initcall pnpacpi_init+0x0/0xd2 returned 0 after 22218 usecs
calling  chr_dev_init+0x0/0x23c @ 1
initcall chr_dev_init+0x0/0x23c returned 0 after 7136 usecs
calling  firmware_class_init+0x0/0x5a @ 1
initcall firmware_class_init+0x0/0x5a returned 0 after 129 usecs
calling  init_acpi_pm_clocksource+0x0/0xd8 @ 1
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
initcall init_acpi_pm_clocksource+0x0/0xd8 returned 0 after 5837 usecs
calling  ssb_modinit+0x0/0x2aa @ 1
initcall ssb_modinit+0x0/0x2aa returned 0 after 279 usecs
calling  bcma_init_bus_register+0x0/0x2b @ 1
initcall bcma_init_bus_register+0x0/0x2b returned 0 after 204 usecs
calling  powercap_init+0x0/0x22 @ 1
initcall powercap_init+0x0/0x22 returned 0 after 505 usecs
calling  sysctl_core_init+0x0/0x2b @ 1
initcall sysctl_core_init+0x0/0x2b returned 0 after 123 usecs
calling  eth_offload_init+0x0/0x14 @ 1
initcall eth_offload_init+0x0/0x14 returned 0 after 65 usecs
calling  ipv4_offload_init+0x0/0x74 @ 1
initcall ipv4_offload_init+0x0/0x74 returned 0 after 4 usecs
calling  inet_init+0x0/0x276 @ 1
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 8192 (order: 7, 720896 bytes, linear)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
TCP bind hash table entries: 65536 (order: 10, 5242880 bytes, vmalloc)
TCP: Hash tables configured (established 131072 bind 65536)
UDP hash table entries: 8192 (order: 8, 1572864 bytes, linear)
UDP-Lite hash table entries: 8192 (order: 8, 1572864 bytes, linear)
initcall inet_init+0x0/0x276 returned 0 after 41948 usecs
calling  af_unix_init+0x0/0x52 @ 1
NET: Registered protocol family 1
initcall af_unix_init+0x0/0x52 returned 0 after 922 usecs
calling  ipv6_offload_init+0x0/0x7f @ 1
initcall ipv6_offload_init+0x0/0x7f returned 0 after 5 usecs
calling  vlan_offload_init+0x0/0x20 @ 1
initcall vlan_offload_init+0x0/0x20 returned 0 after 5 usecs
calling  pcibios_assign_resources+0x0/0x236 @ 1
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
pci_bus 0000:00: resource 8 [mem 0x440000000-0x4bfffffff window]
initcall pcibios_assign_resources+0x0/0x236 returned 0 after 6283 usecs
calling  pci_apply_final_quirks+0x0/0x309 @ 1
pci 0000:00:00.0: calling  quirk_passive_release+0x0/0xa0 @ 1
pci 0000:00:01.0: PIIX3: Enabling Passive Release
pci 0000:00:00.0: quirk_passive_release+0x0/0xa0 took 922 usecs
pci 0000:00:00.0: calling  quirk_natoma+0x0/0x60 @ 1
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
pci 0000:00:00.0: quirk_natoma+0x0/0x60 took 917 usecs
pci 0000:00:01.0: calling  quirk_isa_dma_hangs+0x0/0x60 @ 1
pci 0000:00:01.0: Activating ISA DMA hang workarounds
pci 0000:00:01.0: quirk_isa_dma_hangs+0x0/0x60 took 900 usecs
pci 0000:00:02.0: calling  pci_fixup_video+0x0/0x270 @ 1
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:02.0: pci_fixup_video+0x0/0x270 took 1322 usecs
pci 0000:00:03.0: calling  quirk_e100_interrupt+0x0/0x260 @ 1
pci 0000:00:03.0: quirk_e100_interrupt+0x0/0x260 took 1 usecs
PCI: CLS 0 bytes, default 64
initcall pci_apply_final_quirks+0x0/0x309 returned 0 after 14807 usecs
calling  acpi_reserve_resources+0x0/0x273 @ 1
initcall acpi_reserve_resources+0x0/0x273 returned 0 after 75 usecs
calling  populate_rootfs+0x0/0x321 @ 1
Unpacking initramfs...
Freeing initrd memory: 373952K
initcall populate_rootfs+0x0/0x321 returned 0 after 27208649 usecs
calling  pci_iommu_init+0x0/0xa1 @ 1
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x00000000a52b0000-0x00000000a92b0000] (64MB)
initcall pci_iommu_init+0x0/0xa1 returned 0 after 1994 usecs
calling  amd_ibs_init+0x0/0xfb @ 1
initcall amd_ibs_init+0x0/0xfb returned -19 after 1 usecs
calling  msr_init+0x0/0x8d @ 1
initcall msr_init+0x0/0x8d returned 0 after 21 usecs
calling  register_kernel_offset_dumper+0x0/0x1b @ 1
initcall register_kernel_offset_dumper+0x0/0x1b returned 0 after 4 usecs
calling  i8259A_init_ops+0x0/0x21 @ 1
initcall i8259A_init_ops+0x0/0x21 returned 0 after 6 usecs
calling  init_tsc_clocksource+0x0/0x188 @ 1
initcall init_tsc_clocksource+0x0/0x188 returned 0 after 5 usecs
calling  add_rtc_cmos+0x0/0x259 @ 1
initcall add_rtc_cmos+0x0/0x259 returned 0 after 24 usecs
calling  umwait_init+0x0/0x130 @ 1
initcall umwait_init+0x0/0x130 returned -19 after 1 usecs
calling  ioapic_init_ops+0x0/0x14 @ 1
initcall ioapic_init_ops+0x0/0x14 returned 0 after 5 usecs
calling  start_periodic_check_for_corruption+0x0/0x30 @ 1
check: Scanning for low memory corruption every 60 seconds
initcall start_periodic_check_for_corruption+0x0/0x30 returned 0 after 988 usecs
calling  add_bus_probe+0x0/0x48 @ 1
initcall add_bus_probe+0x0/0x48 returned 0 after 2 usecs
calling  sysfb_init+0x0/0x104 @ 1
initcall sysfb_init+0x0/0x104 returned 0 after 591 usecs
calling  audit_classes_init+0x0/0x5a @ 1
initcall audit_classes_init+0x0/0x5a returned 0 after 74 usecs
calling  pt_dump_init+0x0/0x129 @ 1
initcall pt_dump_init+0x0/0x129 returned 0 after 1 usecs
calling  pt_dump_debug_init+0x0/0x7c @ 1
initcall pt_dump_debug_init+0x0/0x7c returned 0 after 163 usecs
calling  init+0x0/0x11 @ 1
initcall init+0x0/0x11 returned 0 after 4328 usecs
calling  serpent_init+0x0/0x9e @ 1
initcall serpent_init+0x0/0x9e returned 0 after 3635 usecs
calling  init+0x0/0x137 @ 1
AVX2 instructions are not detected.
initcall init+0x0/0x137 returned -19 after 736 usecs
calling  des3_ede_x86_init+0x0/0xd1 @ 1
initcall des3_ede_x86_init+0x0/0xd1 returned 0 after 1598 usecs
calling  init+0x0/0xd1 @ 1
initcall init+0x0/0xd1 returned 0 after 1614 usecs
calling  cast5_init+0x0/0x9e @ 1
initcall cast5_init+0x0/0x9e returned 0 after 2447 usecs
calling  crypto_aegis128_aesni_module_init+0x0/0x77 @ 1
initcall crypto_aegis128_aesni_module_init+0x0/0x77 returned 0 after 840 usecs
calling  chacha_simd_mod_init+0x0/0x1b2 @ 1
initcall chacha_simd_mod_init+0x0/0x1b2 returned 0 after 1200 usecs
calling  sha512_ssse3_mod_init+0x0/0xba @ 1
initcall sha512_ssse3_mod_init+0x0/0xba returned 0 after 1436 usecs
calling  crc32c_intel_mod_init+0x0/0x8b @ 1
initcall crc32c_intel_mod_init+0x0/0x8b returned 0 after 409 usecs
calling  crc32_pclmul_mod_init+0x0/0x34 @ 1
initcall crc32_pclmul_mod_init+0x0/0x34 returned 0 after 3565 usecs
calling  punit_atom_debug_init+0x0/0x7d @ 1
initcall punit_atom_debug_init+0x0/0x7d returned -19 after 2 usecs
calling  goldfish_init+0x0/0xe0 @ 1
initcall goldfish_init+0x0/0xe0 returned -19 after 1 usecs
calling  iosf_mbi_init+0x0/0x9e @ 1
initcall iosf_mbi_init+0x0/0x9e returned 0 after 484 usecs
calling  proc_execdomains_init+0x0/0x22 @ 1
initcall proc_execdomains_init+0x0/0x22 returned 0 after 40 usecs
calling  register_warn_debugfs+0x0/0x24 @ 1
initcall register_warn_debugfs+0x0/0x24 returned 0 after 91 usecs
calling  cpuhp_sysfs_init+0x0/0x10e @ 1
initcall cpuhp_sysfs_init+0x0/0x10e returned 0 after 527 usecs
calling  ioresources_init+0x0/0x4a @ 1
initcall ioresources_init+0x0/0x4a returned 0 after 38 usecs
calling  init_sched_debug_procfs+0x0/0x2f @ 1
initcall init_sched_debug_procfs+0x0/0x2f returned 0 after 26 usecs
calling  psi_proc_init+0x0/0x7c @ 1
initcall psi_proc_init+0x0/0x7c returned 0 after 1 usecs
calling  lockdep_proc_init+0x0/0x7a @ 1
initcall lockdep_proc_init+0x0/0x7a returned 0 after 64 usecs
calling  irq_gc_init_ops+0x0/0x14 @ 1
initcall irq_gc_init_ops+0x0/0x14 returned 0 after 5 usecs
calling  timekeeping_init_ops+0x0/0x14 @ 1
initcall timekeeping_init_ops+0x0/0x14 returned 0 after 5 usecs
calling  init_clocksource_sysfs+0x0/0x24 @ 1
initcall init_clocksource_sysfs+0x0/0x24 returned 0 after 645 usecs
calling  init_timer_list_procfs+0x0/0x32 @ 1
initcall init_timer_list_procfs+0x0/0x32 returned 0 after 28 usecs
calling  alarmtimer_init+0x0/0x12f @ 1
initcall alarmtimer_init+0x0/0x12f returned 0 after 262 usecs
calling  init_posix_timers+0x0/0x2a @ 1
initcall init_posix_timers+0x0/0x2a returned 0 after 84 usecs
calling  clockevents_init_sysfs+0x0/0x1a7 @ 1
initcall clockevents_init_sysfs+0x0/0x1a7 returned 0 after 1015 usecs
calling  proc_modules_init+0x0/0x1f @ 1
initcall proc_modules_init+0x0/0x1f returned 0 after 51 usecs
calling  kallsyms_init+0x0/0x22 @ 1
initcall kallsyms_init+0x0/0x22 returned 0 after 29 usecs
calling  ikconfig_init+0x0/0x42 @ 1
initcall ikconfig_init+0x0/0x42 returned 0 after 25 usecs
calling  audit_watch_init+0x0/0x3a @ 1
initcall audit_watch_init+0x0/0x3a returned 0 after 20 usecs
calling  audit_fsnotify_init+0x0/0x3a @ 1
initcall audit_fsnotify_init+0x0/0x3a returned 0 after 20 usecs
calling  audit_tree_init+0x0/0xc9 @ 1
initcall audit_tree_init+0x0/0xc9 returned 0 after 81 usecs
calling  gcov_init+0x0/0x11 @ 1
initcall gcov_init+0x0/0x11 returned 0 after 4 usecs
calling  gcov_fs_init+0x0/0xc9 @ 1
initcall gcov_fs_init+0x0/0xc9 returned 0 after 163 usecs
calling  kcov_init+0x0/0xca @ 1
initcall kcov_init+0x0/0xca returned 0 after 10740 usecs
calling  seccomp_sysctl_init+0x0/0x2c @ 1
initcall seccomp_sysctl_init+0x0/0x2c returned 0 after 106 usecs
calling  utsname_sysctl_init+0x0/0x14 @ 1
initcall utsname_sysctl_init+0x0/0x14 returned 0 after 64 usecs
calling  init_tracepoints+0x0/0x2c @ 1
initcall init_tracepoints+0x0/0x2c returned 0 after 5 usecs
calling  init_lstats_procfs+0x0/0x22 @ 1
initcall init_lstats_procfs+0x0/0x22 returned 0 after 30 usecs
calling  perf_event_sysfs_init+0x0/0x107 @ 1
initcall perf_event_sysfs_init+0x0/0x107 returned 0 after 1293 usecs
calling  kswapd_init+0x0/0x60 @ 1
initcall kswapd_init+0x0/0x60 returned 0 after 405 usecs
calling  extfrag_debug_init+0x0/0x57 @ 1
initcall extfrag_debug_init+0x0/0x57 returned 0 after 130 usecs
calling  mm_compute_batch_init+0x0/0x47 @ 1
initcall mm_compute_batch_init+0x0/0x47 returned 0 after 2 usecs
calling  slab_proc_init+0x0/0x22 @ 1
initcall slab_proc_init+0x0/0x22 returned 0 after 29 usecs
calling  workingset_init+0x0/0xc9 @ 1
workingset: timestamp_bits=52 max_order=22 bucket_order=0
initcall workingset_init+0x0/0xc9 returned 0 after 929 usecs
calling  proc_vmalloc_init+0x0/0x64 @ 1
initcall proc_vmalloc_init+0x0/0x64 returned 0 after 26 usecs
calling  slab_sysfs_init+0x0/0xf0 @ 1
initcall slab_sysfs_init+0x0/0xf0 returned 0 after 88746 usecs
calling  fcntl_init+0x0/0x2a @ 1
initcall fcntl_init+0x0/0x2a returned 0 after 973 usecs
calling  proc_filesystems_init+0x0/0x22 @ 1
initcall proc_filesystems_init+0x0/0x22 returned 0 after 29 usecs
calling  start_dirtytime_writeback+0x0/0x14 @ 1
initcall start_dirtytime_writeback+0x0/0x14 returned 0 after 15 usecs
calling  dnotify_init+0x0/0x7e @ 1
initcall dnotify_init+0x0/0x7e returned 0 after 1931 usecs
calling  fanotify_user_setup+0x0/0x77 @ 1
initcall fanotify_user_setup+0x0/0x77 returned 0 after 2746 usecs
calling  aio_setup+0x0/0x7e @ 1
initcall aio_setup+0x0/0x7e returned 0 after 2413 usecs
calling  io_uring_init+0x0/0x2d @ 1
initcall io_uring_init+0x0/0x2d returned 0 after 935 usecs
calling  init_devpts_fs+0x0/0x2c @ 1
initcall init_devpts_fs+0x0/0x2c returned 0 after 99 usecs
calling  init_nls_cp437+0x0/0x13 @ 1
initcall init_nls_cp437+0x0/0x13 returned 0 after 83 usecs
calling  init_nls_cp737+0x0/0x13 @ 1
initcall init_nls_cp737+0x0/0x13 returned 0 after 4 usecs
calling  init_nls_cp775+0x0/0x13 @ 1
initcall init_nls_cp775+0x0/0x13 returned 0 after 3 usecs
calling  init_nls_cp852+0x0/0x13 @ 1
initcall init_nls_cp852+0x0/0x13 returned 0 after 4 usecs
calling  init_nls_cp860+0x0/0x13 @ 1
initcall init_nls_cp860+0x0/0x13 returned 0 after 3 usecs
calling  init_nls_cp866+0x0/0x13 @ 1
initcall init_nls_cp866+0x0/0x13 returned 0 after 3 usecs
calling  init_nls_cp874+0x0/0x13 @ 1
initcall init_nls_cp874+0x0/0x13 returned 0 after 3 usecs
calling  init_nls_cp950+0x0/0x13 @ 1
initcall init_nls_cp950+0x0/0x13 returned 0 after 4 usecs
calling  init_nls_cp1250+0x0/0x13 @ 1
initcall init_nls_cp1250+0x0/0x13 returned 0 after 3 usecs
calling  init_nls_iso8859_1+0x0/0x13 @ 1
initcall init_nls_iso8859_1+0x0/0x13 returned 0 after 4 usecs
calling  init_nls_iso8859_4+0x0/0x13 @ 1
initcall init_nls_iso8859_4+0x0/0x13 returned 0 after 3 usecs
calling  init_nls_cp1255+0x0/0x13 @ 1
initcall init_nls_cp1255+0x0/0x13 returned 0 after 4 usecs
calling  init_nls_iso8859_9+0x0/0x13 @ 1
initcall init_nls_iso8859_9+0x0/0x13 returned 0 after 4 usecs
calling  init_nls_iso8859_15+0x0/0x13 @ 1
initcall init_nls_iso8859_15+0x0/0x13 returned 0 after 4 usecs
calling  init_nls_koi8_r+0x0/0x13 @ 1
initcall init_nls_koi8_r+0x0/0x13 returned 0 after 4 usecs
calling  init_nls_koi8_u+0x0/0x13 @ 1
initcall init_nls_koi8_u+0x0/0x13 returned 0 after 4 usecs
calling  init_nls_koi8_ru+0x0/0x8b @ 1
initcall init_nls_koi8_ru+0x0/0x8b returned 0 after 7 usecs
calling  init_nls_utf8+0x0/0xa0 @ 1
initcall init_nls_utf8+0x0/0xa0 returned 0 after 6 usecs
calling  init_nls_maccenteuro+0x0/0x13 @ 1
initcall init_nls_maccenteuro+0x0/0x13 returned 0 after 4 usecs
calling  init_nls_maccroatian+0x0/0x13 @ 1
initcall init_nls_maccroatian+0x0/0x13 returned 0 after 4 usecs
calling  init_autofs_fs+0x0/0x2a @ 1
initcall init_autofs_fs+0x0/0x2a returned 0 after 547 usecs
calling  ovl_init+0x0/0x6e @ 1
initcall ovl_init+0x0/0x6e returned 0 after 1951 usecs
calling  ipc_init+0x0/0x25 @ 1
initcall ipc_init+0x0/0x25 returned 0 after 141 usecs
calling  ipc_sysctl_init+0x0/0x14 @ 1
initcall ipc_sysctl_init+0x0/0x14 returned 0 after 77 usecs
calling  init_mqueue_fs+0x0/0xb8 @ 1
initcall init_mqueue_fs+0x0/0xb8 returned 0 after 1555 usecs
calling  key_proc_init+0x0/0x6e @ 1
initcall key_proc_init+0x0/0x6e returned 0 after 65 usecs
calling  crypto_algapi_init+0x0/0xd @ 1
initcall crypto_algapi_init+0x0/0xd returned 0 after 23 usecs
calling  crypto_user_init+0x0/0x11 @ 1
initcall crypto_user_init+0x0/0x11 returned 0 after 108 usecs
calling  aes_init+0x0/0x11 @ 1
initcall aes_init+0x0/0x11 returned 0 after 2380 usecs
calling  jent_mod_init+0x0/0x2e @ 1
initcall jent_mod_init+0x0/0x2e returned 0 after 10105 usecs
calling  af_alg_init+0x0/0x41 @ 1
NET: Registered protocol family 38
initcall af_alg_init+0x0/0x41 returned 0 after 653 usecs
calling  algif_aead_init+0x0/0x11 @ 1
initcall algif_aead_init+0x0/0x11 returned 0 after 173 usecs
calling  asymmetric_key_init+0x0/0x11 @ 1
Key type asymmetric registered
initcall asymmetric_key_init+0x0/0x11 returned 0 after 756 usecs
calling  x509_key_init+0x0/0x11 @ 1
Asymmetric key parser 'x509' registered
initcall x509_key_init+0x0/0x11 returned 0 after 853 usecs
calling  debug_objects_init_debugfs+0x0/0x37 @ 1
initcall debug_objects_init_debugfs+0x0/0x37 returned 0 after 108 usecs
calling  sw842_init+0x0/0x18f @ 1
initcall sw842_init+0x0/0x18f returned 0 after 2 usecs
calling  sw842_init+0x0/0x18f @ 1
initcall sw842_init+0x0/0x18f returned 0 after 1 usecs
calling  percpu_counter_startup+0x0/0x55 @ 1
initcall percpu_counter_startup+0x0/0x55 returned 0 after 191 usecs
calling  err_inject_init+0x0/0x1f @ 1
initcall err_inject_init+0x0/0x1f returned 0 after 74 usecs
calling  digsig_init+0x0/0x39 @ 1
initcall digsig_init+0x0/0x39 returned 0 after 39 usecs
calling  phy_core_init+0x0/0x6f @ 1
initcall phy_core_init+0x0/0x6f returned 0 after 158 usecs
calling  mixel_dphy_driver_init+0x0/0x13 @ 1
initcall mixel_dphy_driver_init+0x0/0x13 returned 0 after 167 usecs
calling  intel_cbphy_driver_init+0x0/0x13 @ 1
initcall intel_cbphy_driver_init+0x0/0x13 returned 0 after 183 usecs
calling  intel_emmc_driver_init+0x0/0x13 @ 1
initcall intel_emmc_driver_init+0x0/0x13 returned 0 after 168 usecs
calling  bgpio_driver_init+0x0/0x13 @ 1
initcall bgpio_driver_init+0x0/0x13 returned 0 after 165 usecs
calling  idio_16_driver_init+0x0/0x17 @ 1
initcall idio_16_driver_init+0x0/0x17 returned -19 after 341 usecs
calling  bt8xxgpio_pci_driver_init+0x0/0x1a @ 1
initcall bt8xxgpio_pci_driver_init+0x0/0x1a returned 0 after 427 usecs
calling  cdns_gpio_driver_init+0x0/0x13 @ 1
initcall cdns_gpio_driver_init+0x0/0x13 returned 0 after 161 usecs
calling  dwapb_gpio_driver_init+0x0/0x13 @ 1
initcall dwapb_gpio_driver_init+0x0/0x13 returned 0 after 136 usecs
calling  mb86s70_gpio_driver_init+0x0/0x13 @ 1
initcall mb86s70_gpio_driver_init+0x0/0x13 returned 0 after 140 usecs
calling  ioh_gpio_driver_init+0x0/0x1a @ 1
initcall ioh_gpio_driver_init+0x0/0x1a returned 0 after 212 usecs
calling  gpio_mockup_init+0x0/0x14c @ 1
initcall gpio_mockup_init+0x0/0x14c returned -22 after 2 usecs
calling  idio_24_driver_init+0x0/0x1a @ 1
initcall idio_24_driver_init+0x0/0x1a returned 0 after 235 usecs
calling  sifive_gpio_driver_init+0x0/0x13 @ 1
initcall sifive_gpio_driver_init+0x0/0x13 returned 0 after 171 usecs
calling  sdv_gpio_driver_init+0x0/0x1a @ 1
initcall sdv_gpio_driver_init+0x0/0x1a returned 0 after 178 usecs
calling  syscon_gpio_driver_init+0x0/0x13 @ 1
initcall syscon_gpio_driver_init+0x0/0x13 returned 0 after 159 usecs
calling  winbond_gpio_idriver_init+0x0/0x16 @ 1
gpio_winbond: chip ID at 2e is ffff
gpio_winbond: not an our chip
gpio_winbond: chip ID at 4e is ffff
gpio_winbond: not an our chip
initcall winbond_gpio_idriver_init+0x0/0x16 returned -19 after 3616 usecs
calling  stmpe_pwm_driver_init+0x0/0x1a @ 1
initcall stmpe_pwm_driver_init+0x0/0x1a returned -19 after 312 usecs
calling  pci_proc_init+0x0/0x6c @ 1
initcall pci_proc_init+0x0/0x6c returned 0 after 149 usecs
calling  pci_hotplug_init+0x0/0x51 @ 1
initcall pci_hotplug_init+0x0/0x51 returned 0 after 1 usecs
calling  pci_epc_init+0x0/0x42 @ 1
initcall pci_epc_init+0x0/0x42 returned 0 after 154 usecs
calling  pci_epf_init+0x0/0x2e @ 1
initcall pci_epf_init+0x0/0x2e returned 0 after 229 usecs
calling  cdns_plat_pcie_driver_init+0x0/0x13 @ 1
initcall cdns_plat_pcie_driver_init+0x0/0x13 returned 0 after 170 usecs
calling  j721e_pcie_driver_init+0x0/0x13 @ 1
initcall j721e_pcie_driver_init+0x0/0x13 returned 0 after 110 usecs
calling  idtcps_init+0x0/0x11 @ 1
initcall idtcps_init+0x0/0x11 returned 0 after 169 usecs
calling  gpio_backlight_driver_init+0x0/0x13 @ 1
initcall gpio_backlight_driver_init+0x0/0x13 returned 0 after 121 usecs
calling  ged_driver_init+0x0/0x13 @ 1
initcall ged_driver_init+0x0/0x13 returned 0 after 212 usecs
calling  acpi_ac_init+0x0/0x17b @ 1
initcall acpi_ac_init+0x0/0x17b returned 0 after 464 usecs
calling  acpi_button_driver_init+0x0/0xaf @ 1
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
initcall acpi_button_driver_init+0x0/0xaf returned 0 after 3257 usecs
calling  acpi_fan_driver_init+0x0/0x13 @ 1
initcall acpi_fan_driver_init+0x0/0x13 returned 0 after 139 usecs
calling  acpi_processor_driver_init+0x0/0xc9 @ 1
Warning: Processor Platform Limit event detected, but not handled.
Consider compiling CPUfreq support into your kernel.
initcall acpi_processor_driver_init+0x0/0xc9 returned 0 after 3589 usecs
calling  acpi_thermal_init+0x0/0x82 @ 1
initcall acpi_thermal_init+0x0/0x82 returned 0 after 682 usecs
calling  acpi_battery_init+0x0/0x6d @ 1
initcall acpi_battery_init+0x0/0x6d returned 0 after 79 usecs
calling  of_fixed_factor_clk_driver_init+0x0/0x13 @ 1
initcall of_fixed_factor_clk_driver_init+0x0/0x13 returned 0 after 108 usecs
calling  of_fixed_clk_driver_init+0x0/0x13 @ 1
initcall of_fixed_clk_driver_init+0x0/0x13 returned 0 after 154 usecs
calling  gpio_clk_driver_init+0x0/0x13 @ 1
initcall gpio_clk_driver_init+0x0/0x13 returned 0 after 130 usecs
calling  plt_clk_driver_init+0x0/0x13 @ 1
initcall plt_clk_driver_init+0x0/0x13 returned 0 after 211 usecs
calling  xvcu_driver_init+0x0/0x13 @ 1
initcall xvcu_driver_init+0x0/0x13 returned 0 after 179 usecs
calling  regulator_virtual_consumer_driver_init+0x0/0x13 @ 1
initcall regulator_virtual_consumer_driver_init+0x0/0x13 returned 0 after 131 usecs
calling  cpcap_regulator_driver_init+0x0/0x13 @ 1
initcall cpcap_regulator_driver_init+0x0/0x13 returned 0 after 126 usecs
calling  mt6358_regulator_driver_init+0x0/0x13 @ 1
initcall mt6358_regulator_driver_init+0x0/0x13 returned 0 after 977 usecs
calling  mt6397_regulator_driver_init+0x0/0x13 @ 1
initcall mt6397_regulator_driver_init+0x0/0x13 returned 0 after 187 usecs
calling  pmic_driver_init+0x0/0x13 @ 1
initcall pmic_driver_init+0x0/0x13 returned 0 after 124 usecs
calling  vctrl_driver_init+0x0/0x13 @ 1
initcall vctrl_driver_init+0x0/0x13 returned 0 after 127 usecs
calling  brcm_rescal_reset_driver_init+0x0/0x13 @ 1
initcall brcm_rescal_reset_driver_init+0x0/0x13 returned 0 after 184 usecs
calling  n_null_init+0x0/0x2c @ 1
initcall n_null_init+0x0/0x2c returned 0 after 4 usecs
calling  pty_init+0x0/0x12 @ 1
initcall pty_init+0x0/0x12 returned 0 after 183341 usecs
calling  sysrq_init+0x0/0x41 @ 1
initcall sysrq_init+0x0/0x41 returned 0 after 42 usecs
calling  serial8250_init+0x0/0x206 @ 1
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
initcall serial8250_init+0x0/0x206 returned 0 after 11679 usecs
calling  serial_pci_driver_init+0x0/0x1a @ 1
initcall serial_pci_driver_init+0x0/0x1a returned 0 after 227 usecs
calling  exar_pci_driver_init+0x0/0x1a @ 1
initcall exar_pci_driver_init+0x0/0x1a returned 0 after 193 usecs
calling  lpss8250_pci_driver_init+0x0/0x1a @ 1
initcall lpss8250_pci_driver_init+0x0/0x1a returned 0 after 223 usecs
calling  mid8250_pci_driver_init+0x0/0x1a @ 1
initcall mid8250_pci_driver_init+0x0/0x1a returned 0 after 197 usecs
calling  applicom_init+0x0/0xd06 @ 1
Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:57 dwmw2 Exp $
ac.o: No PCI boards found.
ac.o: For an ISA board you must supply memory and irq parameters.
initcall applicom_init+0x0/0xd06 returned -6 after 2792 usecs
calling  hwrng_modinit+0x0/0xe6 @ 1
initcall hwrng_modinit+0x0/0xe6 returned 0 after 648 usecs
calling  virtio_rng_driver_init+0x0/0x11 @ 1
initcall virtio_rng_driver_init+0x0/0x11 returned 0 after 130 usecs
calling  cctrng_mod_init+0x0/0x13 @ 1
initcall cctrng_mod_init+0x0/0x13 returned 0 after 144 usecs
calling  agp_init+0x0/0x24 @ 1
Linux agpgart interface v0.103
initcall agp_init+0x0/0x24 returned 0 after 605 usecs
calling  init_tis+0x0/0x13b @ 1
initcall init_tis+0x0/0x13b returned 0 after 355 usecs
calling  init_nsc+0x0/0x54e @ 1
initcall init_nsc+0x0/0x54e returned -19 after 38 usecs
calling  crb_acpi_driver_init+0x0/0x11 @ 1
initcall crb_acpi_driver_init+0x0/0x11 returned 0 after 276 usecs
calling  xillybus_init+0x0/0x76 @ 1
initcall xillybus_init+0x0/0x76 returned 0 after 267 usecs
calling  topology_sysfs_init+0x0/0x2c @ 1
initcall topology_sysfs_init+0x0/0x2c returned 0 after 567 usecs
calling  cacheinfo_sysfs_init+0x0/0x2c @ 1
initcall cacheinfo_sysfs_init+0x0/0x2c returned -2 after 66 usecs
calling  dummy_irq_init+0x0/0x79 @ 1
dummy-irq: no IRQ given.  Use irq=N
initcall dummy_irq_init+0x0/0x79 returned -5 after 680 usecs
calling  tifm_7xx1_driver_init+0x0/0x1a @ 1
initcall tifm_7xx1_driver_init+0x0/0x1a returned 0 after 231 usecs
calling  enclosure_init+0x0/0x18 @ 1
initcall enclosure_init+0x0/0x18 returned 0 after 119 usecs
calling  c2port_init+0x0/0x78 @ 1
Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Giometti
initcall c2port_init+0x0/0x78 returned 0 after 1189 usecs
calling  at25_driver_init+0x0/0x13 @ 1
initcall at25_driver_init+0x0/0x13 returned 0 after 122 usecs
calling  eeprom_93xx46_driver_init+0x0/0x13 @ 1
initcall eeprom_93xx46_driver_init+0x0/0x13 returned 0 after 141 usecs
calling  mei_init+0x0/0xae @ 1
initcall mei_init+0x0/0xae returned 0 after 389 usecs
calling  mei_txe_driver_init+0x0/0x1a @ 1
initcall mei_txe_driver_init+0x0/0x1a returned 0 after 195 usecs
calling  pvpanic_mmio_init+0x0/0x5c @ 1
initcall pvpanic_mmio_init+0x0/0x5c returned 0 after 265 usecs
calling  xsdfec_driver_init+0x0/0x13 @ 1
initcall xsdfec_driver_init+0x0/0x13 returned 0 after 862 usecs
calling  cpcap_driver_init+0x0/0x13 @ 1
initcall cpcap_driver_init+0x0/0x13 returned 0 after 157 usecs
calling  intel_quark_mfd_driver_init+0x0/0x1a @ 1
initcall intel_quark_mfd_driver_init+0x0/0x1a returned 0 after 213 usecs
calling  rdc321x_sb_driver_init+0x0/0x1a @ 1
initcall rdc321x_sb_driver_init+0x0/0x1a returned 0 after 264 usecs
calling  vx855_pci_driver_init+0x0/0x1a @ 1
initcall vx855_pci_driver_init+0x0/0x1a returned 0 after 207 usecs
calling  atmel_hlcdc_driver_init+0x0/0x13 @ 1
initcall atmel_hlcdc_driver_init+0x0/0x13 returned 0 after 173 usecs
calling  intel_lpss_init+0x0/0x1d @ 1
initcall intel_lpss_init+0x0/0x1d returned 0 after 59 usecs
calling  intel_lpss_pci_driver_init+0x0/0x1a @ 1
initcall intel_lpss_pci_driver_init+0x0/0x1a returned 0 after 227 usecs
calling  mt6397_driver_init+0x0/0x13 @ 1
initcall mt6397_driver_init+0x0/0x13 returned 0 after 231 usecs
calling  intel_m10bmc_spi_driver_init+0x0/0x13 @ 1
initcall intel_m10bmc_spi_driver_init+0x0/0x13 returned 0 after 216 usecs
calling  udmabuf_dev_init+0x0/0x11 @ 1
initcall udmabuf_dev_init+0x0/0x11 returned 0 after 433 usecs
calling  spi_mux_driver_init+0x0/0x13 @ 1
initcall spi_mux_driver_init+0x0/0x13 returned 0 after 121 usecs
calling  spidev_init+0x0/0xb1 @ 1
initcall spidev_init+0x0/0xb1 returned 0 after 299 usecs
calling  spi_engine_driver_init+0x0/0x13 @ 1
initcall spi_engine_driver_init+0x0/0x13 returned 0 after 126 usecs
calling  dw_spi_mmio_driver_init+0x0/0x13 @ 1
initcall dw_spi_mmio_driver_init+0x0/0x13 returned 0 after 150 usecs
calling  lantiq_ssc_driver_init+0x0/0x13 @ 1
initcall lantiq_ssc_driver_init+0x0/0x13 returned 0 after 142 usecs
calling  pxa2xx_spi_pci_driver_init+0x0/0x1a @ 1
initcall pxa2xx_spi_pci_driver_init+0x0/0x1a returned 0 after 211 usecs
calling  rockchip_spi_driver_init+0x0/0x13 @ 1
initcall rockchip_spi_driver_init+0x0/0x13 returned 0 after 141 usecs
calling  spi_slave_system_control_driver_init+0x0/0x13 @ 1
initcall spi_slave_system_control_driver_init+0x0/0x13 returned 0 after 144 usecs
calling  net_olddevs_init+0x0/0x5b @ 1
initcall net_olddevs_init+0x0/0x5b returned 0 after 6 usecs
calling  blackhole_netdev_init+0x0/0x9a @ 1
initcall blackhole_netdev_init+0x0/0x9a returned 0 after 130 usecs
calling  can_dev_init+0x0/0x2c @ 1
CAN device driver interface
initcall can_dev_init+0x0/0x2c returned 0 after 646 usecs
calling  e1000_init_module+0x0/0x77 @ 1
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
PCI Interrupt Link [LNKC] enabled at IRQ 11
e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
initcall e1000_init_module+0x0/0x77 returned 0 after 3964503 usecs
calling  i8042_init+0x0/0x26f @ 1
i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
initcall i8042_init+0x0/0x26f returned 0 after 6751 usecs
calling  serport_init+0x0/0x31 @ 1
initcall serport_init+0x0/0x31 returned 0 after 4 usecs
calling  emu_driver_init+0x0/0x1a @ 1
initcall emu_driver_init+0x0/0x1a returned 0 after 200 usecs
calling  fm801_gp_driver_init+0x0/0x1a @ 1
initcall fm801_gp_driver_init+0x0/0x1a returned 0 after 210 usecs
calling  atkbd_init+0x0/0x26 @ 1
initcall atkbd_init+0x0/0x26 returned 0 after 337 usecs
calling  psmouse_init+0x0/0x75 @ 1
initcall psmouse_init+0x0/0x75 returned 0 after 1569 usecs
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
calling  ds1302_driver_init+0x0/0x13 @ 1
initcall ds1302_driver_init+0x0/0x13 returned 0 after 145 usecs
calling  ds1347_driver_init+0x0/0x13 @ 1
initcall ds1347_driver_init+0x0/0x13 returned 0 after 174 usecs
calling  ds1390_driver_init+0x0/0x13 @ 1
initcall ds1390_driver_init+0x0/0x13 returned 0 after 155 usecs
calling  ds1511_rtc_driver_init+0x0/0x13 @ 1
initcall ds1511_rtc_driver_init+0x0/0x13 returned 0 after 155 usecs
calling  m41t93_driver_init+0x0/0x13 @ 1
initcall m41t93_driver_init+0x0/0x13 returned 0 after 161 usecs
calling  m48t35_platform_driver_init+0x0/0x13 @ 1
initcall m48t35_platform_driver_init+0x0/0x13 returned 0 after 177 usecs
calling  m48t59_rtc_driver_init+0x0/0x13 @ 1
initcall m48t59_rtc_driver_init+0x0/0x13 returned 0 after 145 usecs
calling  m48t86_rtc_platform_driver_init+0x0/0x13 @ 1
initcall m48t86_rtc_platform_driver_init+0x0/0x13 returned 0 after 125 usecs
calling  rtc7301_rtc_driver_init+0x0/0x1a @ 1
initcall rtc7301_rtc_driver_init+0x0/0x1a returned -19 after 248 usecs
calling  r9701_driver_init+0x0/0x13 @ 1
initcall r9701_driver_init+0x0/0x13 returned 0 after 155 usecs
calling  stk17ta8_rtc_driver_init+0x0/0x13 @ 1
initcall stk17ta8_rtc_driver_init+0x0/0x13 returned 0 after 137 usecs
calling  w1_init+0x0/0x9d @ 1
Driver for 1-wire Dallas network protocol.
initcall w1_init+0x0/0x9d returned 0 after 5327 usecs
calling  ds1wm_init+0x0/0x1f @ 1
DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
initcall ds1wm_init+0x0/0x1f returned 0 after 992 usecs
calling  w1_smem_init+0x0/0x3f @ 1
initcall w1_smem_init+0x0/0x3f returned 0 after 88 usecs
calling  w1_f0d_init+0x0/0x24 @ 1
w1_f0d_init()
initcall w1_f0d_init+0x0/0x24 returned 0 after 472 usecs
calling  w1_ds2780_family_init+0x0/0x11 @ 1
initcall w1_ds2780_family_init+0x0/0x11 returned 0 after 6 usecs
calling  w1_ds2781_family_init+0x0/0x11 @ 1
initcall w1_ds2781_family_init+0x0/0x11 returned 0 after 7 usecs
calling  mt6323_pwrc_driver_init+0x0/0x13 @ 1
initcall mt6323_pwrc_driver_init+0x0/0x13 returned 0 after 190 usecs
calling  ltc2952_poweroff_driver_init+0x0/0x13 @ 1
initcall ltc2952_poweroff_driver_init+0x0/0x13 returned 0 after 182 usecs
calling  restart_poweroff_driver_init+0x0/0x13 @ 1
initcall restart_poweroff_driver_init+0x0/0x13 returned 0 after 176 usecs
calling  syscon_reboot_driver_init+0x0/0x13 @ 1
initcall syscon_reboot_driver_init+0x0/0x13 returned 0 after 135 usecs
calling  syscon_poweroff_register+0x0/0x13 @ 1
initcall syscon_poweroff_register+0x0/0x13 returned 0 after 147 usecs
calling  syscon_reboot_mode_driver_init+0x0/0x13 @ 1
initcall syscon_reboot_mode_driver_init+0x0/0x13 returned 0 after 172 usecs
calling  nvmem_reboot_mode_driver_init+0x0/0x13 @ 1
initcall nvmem_reboot_mode_driver_init+0x0/0x13 returned 0 after 179 usecs
calling  w1_ds2760_family_init+0x0/0x11 @ 1
initcall w1_ds2760_family_init+0x0/0x11 returned 0 after 6 usecs
calling  ds2781_battery_driver_init+0x0/0x13 @ 1
initcall ds2781_battery_driver_init+0x0/0x13 returned 0 after 162 usecs
calling  goldfish_battery_device_init+0x0/0x13 @ 1
initcall goldfish_battery_device_init+0x0/0x13 returned 0 after 153 usecs
calling  max8903_driver_init+0x0/0x13 @ 1
initcall max8903_driver_init+0x0/0x13 returned 0 after 147 usecs
calling  gpio_charger_driver_init+0x0/0x13 @ 1
initcall gpio_charger_driver_init+0x0/0x13 returned 0 after 136 usecs
calling  i8k_init+0x0/0x3f @ 1
initcall i8k_init+0x0/0x3f returned -19 after 4 usecs
calling  thermal_mmio_driver_init+0x0/0x13 @ 1
initcall thermal_mmio_driver_init+0x0/0x13 returned 0 after 139 usecs
calling  intel_pch_thermal_driver_init+0x0/0x1a @ 1
initcall intel_pch_thermal_driver_init+0x0/0x1a returned 0 after 148 usecs
calling  haltpoll_init+0x0/0x110 @ 1
initcall haltpoll_init+0x0/0x110 returned -19 after 5 usecs
calling  bl_led_trigger_init+0x0/0x11 @ 1
initcall bl_led_trigger_init+0x0/0x11 returned 0 after 7 usecs
calling  activity_init+0x0/0x3f @ 1
initcall activity_init+0x0/0x3f returned 0 after 11 usecs
calling  ledtrig_panic_init+0x0/0x5f @ 1
initcall ledtrig_panic_init+0x0/0x5f returned 0 after 30 usecs
calling  dmi_sysfs_init+0x0/0x129 @ 1
initcall dmi_sysfs_init+0x0/0x129 returned 0 after 1175 usecs
calling  adf_register_ctl_device_driver+0x0/0x1a9 @ 1
initcall adf_register_ctl_device_driver+0x0/0x1a9 returned 0 after 2172 usecs
calling  adfdrv_init+0x0/0x41 @ 1
initcall adfdrv_init+0x0/0x41 returned 0 after 2329 usecs
calling  adfdrv_init+0x0/0x41 @ 1
initcall adfdrv_init+0x0/0x41 returned 0 after 1290 usecs
calling  hid_init+0x0/0x48 @ 1
initcall hid_init+0x0/0x48 returned 0 after 227 usecs
calling  hid_generic_init+0x0/0x1a @ 1
initcall hid_generic_init+0x0/0x1a returned 0 after 147 usecs
calling  bcma_modinit+0x0/0x48 @ 1
initcall bcma_modinit+0x0/0x48 returned 0 after 1891 usecs
calling  comedi_init+0x0/0x1f2 @ 1
comedi: version 0.7.76 - http://www.comedi.org
initcall comedi_init+0x0/0x1f2 returned 0 after 877 usecs
calling  comedi_8254_module_init+0x0/0x8 @ 1
initcall comedi_8254_module_init+0x0/0x8 returned 0 after 1 usecs
calling  pcl711_driver_init+0x0/0x11 @ 1
initcall pcl711_driver_init+0x0/0x11 returned 0 after 68 usecs
calling  pcl816_driver_init+0x0/0x11 @ 1
initcall pcl816_driver_init+0x0/0x11 returned 0 after 56 usecs
calling  das16m1_driver_init+0x0/0x11 @ 1
initcall das16m1_driver_init+0x0/0x11 returned 0 after 3 usecs
calling  das08_isa_driver_init+0x0/0x11 @ 1
initcall das08_isa_driver_init+0x0/0x11 returned 0 after 3 usecs
calling  das16_driver_init+0x0/0x11 @ 1
initcall das16_driver_init+0x0/0x11 returned 0 after 2 usecs
calling  driver_das800_init+0x0/0x11 @ 1
initcall driver_das800_init+0x0/0x11 returned 0 after 2 usecs
calling  dt2801_driver_init+0x0/0x11 @ 1
initcall dt2801_driver_init+0x0/0x11 returned 0 after 3 usecs
calling  dt2817_driver_init+0x0/0x11 @ 1
initcall dt2817_driver_init+0x0/0x11 returned 0 after 3 usecs
calling  dmm32at_driver_init+0x0/0x11 @ 1
initcall dmm32at_driver_init+0x0/0x11 returned 0 after 2 usecs
calling  fl512_driver_init+0x0/0x11 @ 1
initcall fl512_driver_init+0x0/0x11 returned 0 after 2 usecs
calling  ii20k_driver_init+0x0/0x11 @ 1
initcall ii20k_driver_init+0x0/0x11 returned 0 after 2 usecs
calling  adq12b_driver_init+0x0/0x11 @ 1
initcall adq12b_driver_init+0x0/0x11 returned 0 after 2 usecs
calling  ni_at_ao_driver_init+0x0/0x11 @ 1
initcall ni_at_ao_driver_init+0x0/0x11 returned 0 after 3 usecs
calling  ni_atmio_driver_init+0x0/0x11 @ 1
initcall ni_atmio_driver_init+0x0/0x11 returned 0 after 4 usecs
calling  atmio16d_driver_init+0x0/0x11 @ 1
initcall atmio16d_driver_init+0x0/0x11 returned 0 after 3 usecs
calling  labpc_driver_init+0x0/0x11 @ 1
initcall labpc_driver_init+0x0/0x11 returned 0 after 2 usecs
calling  pcmad_driver_init+0x0/0x11 @ 1
initcall pcmad_driver_init+0x0/0x11 returned 0 after 3 usecs
calling  s526_driver_init+0x0/0x11 @ 1
initcall s526_driver_init+0x0/0x11 returned 0 after 4 usecs
calling  ni_tio_init_module+0x0/0x8 @ 1
initcall ni_tio_init_module+0x0/0x8 returned 0 after 1 usecs
calling  ni_routes_module_init+0x0/0x4f @ 1
initcall ni_routes_module_init+0x0/0x4f returned 0 after 8551 usecs
calling  labpc_common_init+0x0/0x8 @ 1
initcall labpc_common_init+0x0/0x8 returned 0 after 1 usecs
calling  comedi_8255_module_init+0x0/0x8 @ 1
initcall comedi_8255_module_init+0x0/0x8 returned 0 after 1 usecs
calling  dev_8255_driver_init+0x0/0x11 @ 1
initcall dev_8255_driver_init+0x0/0x11 returned 0 after 5 usecs
calling  das08_init+0x0/0x8 @ 1
initcall das08_init+0x0/0x8 returned 0 after 1 usecs
calling  pi433_init+0x0/0xb8 @ 1
initcall pi433_init+0x0/0xb8 returned 0 after 314 usecs
calling  pmc_atom_init+0x0/0x49 @ 1
initcall pmc_atom_init+0x0/0x49 returned -19 after 28 usecs
calling  ipack_init+0x0/0x45 @ 1
initcall ipack_init+0x0/0x45 returned 0 after 212 usecs
calling  stm_core_init+0x0/0xcb @ 1
initcall stm_core_init+0x0/0xcb returned 0 after 2075 usecs
calling  basic_stm_init+0x0/0x20 @ 1
initcall basic_stm_init+0x0/0x20 returned 0 after 98 usecs
calling  mux_mmio_driver_init+0x0/0x13 @ 1
initcall mux_mmio_driver_init+0x0/0x13 returned 0 after 188 usecs
calling  icc_init+0x0/0x77 @ 1
initcall icc_init+0x0/0x77 returned 0 after 145 usecs
calling  mchp_tc_driver_init+0x0/0x13 @ 1
initcall mchp_tc_driver_init+0x0/0x13 returned 0 after 224 usecs
calling  sock_diag_init+0x0/0x3c @ 1
initcall sock_diag_init+0x0/0x3c returned 0 after 219 usecs
calling  failover_init+0x0/0x14 @ 1
initcall failover_init+0x0/0x14 returned 0 after 89 usecs
calling  llc_init+0x0/0x20 @ 1
initcall llc_init+0x0/0x20 returned 0 after 5 usecs
calling  llc2_init+0x0/0xcd @ 1
NET: Registered protocol family 26
initcall llc2_init+0x0/0xcd returned 0 after 913 usecs
calling  snap_init+0x0/0x3b @ 1
initcall snap_init+0x0/0x3b returned 0 after 109 usecs
calling  blackhole_init+0x0/0x11 @ 1
initcall blackhole_init+0x0/0x11 returned 0 after 5 usecs
calling  pedit_init_module+0x0/0x18 @ 1
initcall pedit_init_module+0x0/0x18 returned 0 after 117 usecs
calling  simp_init_module+0x0/0x33 @ 1
Simple TC action Loaded
initcall simp_init_module+0x0/0x33 returned 0 after 632 usecs
calling  tunnel_key_init_module+0x0/0x18 @ 1
initcall tunnel_key_init_module+0x0/0x18 returned 0 after 45 usecs
calling  hfsc_init+0x0/0x11 @ 1
initcall hfsc_init+0x0/0x11 returned 0 after 4 usecs
calling  gred_module_init+0x0/0x11 @ 1
initcall gred_module_init+0x0/0x11 returned 0 after 4 usecs
calling  ingress_module_init+0x0/0x3f @ 1
initcall ingress_module_init+0x0/0x3f returned 0 after 6 usecs
calling  dsmark_module_init+0x0/0x11 @ 1
initcall dsmark_module_init+0x0/0x11 returned 0 after 4 usecs
calling  multiq_module_init+0x0/0x11 @ 1
initcall multiq_module_init+0x0/0x11 returned 0 after 4 usecs
calling  drr_init+0x0/0x11 @ 1
initcall drr_init+0x0/0x11 returned 0 after 4 usecs
calling  skbprio_module_init+0x0/0x11 @ 1
initcall skbprio_module_init+0x0/0x11 returned 0 after 4 usecs
calling  codel_module_init+0x0/0x11 @ 1
initcall codel_module_init+0x0/0x11 returned 0 after 4 usecs
calling  fq_module_init+0x0/0x56 @ 1
initcall fq_module_init+0x0/0x56 returned 0 after 961 usecs
calling  hhf_module_init+0x0/0x11 @ 1
initcall hhf_module_init+0x0/0x11 returned 0 after 5 usecs
calling  etf_module_init+0x0/0x11 @ 1
initcall etf_module_init+0x0/0x11 returned 0 after 4 usecs
calling  taprio_module_init+0x0/0x22 @ 1
initcall taprio_module_init+0x0/0x22 returned 0 after 13 usecs
calling  init_u32+0x0/0xb2 @ 1
u32 classifier
input device check on
Actions configured
initcall init_u32+0x0/0xb2 returned 0 after 2728 usecs
calling  cls_mall_init+0x0/0x11 @ 1
initcall cls_mall_init+0x0/0x11 returned 0 after 3 usecs
calling  init_em_canid+0x0/0x11 @ 1
initcall init_em_canid+0x0/0x11 returned 0 after 70 usecs
calling  gre_offload_init+0x0/0x4e @ 1
initcall gre_offload_init+0x0/0x4e returned 0 after 2 usecs
calling  sysctl_ipv4_init+0x0/0x4c @ 1
initcall sysctl_ipv4_init+0x0/0x4c returned 0 after 208 usecs
calling  tunnel4_init+0x0/0x59 @ 1
initcall tunnel4_init+0x0/0x59 returned 0 after 2 usecs
calling  inet_diag_init+0x0/0xa9 @ 1
initcall inet_diag_init+0x0/0xa9 returned 0 after 110 usecs
calling  tcp_diag_init+0x0/0x11 @ 1
initcall tcp_diag_init+0x0/0x11 returned 0 after 72 usecs
calling  cubictcp_register+0x0/0xaa @ 1
initcall cubictcp_register+0x0/0xaa returned 0 after 5 usecs
calling  inet6_init+0x0/0x3e8 @ 1
NET: Registered protocol family 10
Segment Routing with IPv6
initcall inet6_init+0x0/0x3e8 returned 0 after 16147 usecs
calling  sit_init+0x0/0xcb @ 1
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
initcall sit_init+0x0/0xcb returned 0 after 3976 usecs
calling  packet_init+0x0/0x7d @ 1
NET: Registered protocol family 17
initcall packet_init+0x0/0x7d returned 0 after 698 usecs
calling  br_init+0x0/0xa5 @ 1
initcall br_init+0x0/0xa5 returned 0 after 1306 usecs
calling  atalk_init+0x0/0x112 @ 1
NET: Registered protocol family 5
initcall atalk_init+0x0/0x112 returned 0 after 1119 usecs
calling  x25_init+0x0/0xb3 @ 1
NET: Registered protocol family 9
X25: Linux Version 0.2
initcall x25_init+0x0/0xb3 returned 0 after 1407 usecs
calling  can_init+0x0/0xba @ 1
can: controller area network core
NET: Registered protocol family 29
initcall can_init+0x0/0xba returned 0 after 2614 usecs
calling  bcm_module_init+0x0/0x49 @ 1
can: broadcast manager protocol
initcall bcm_module_init+0x0/0x49 returned 0 after 995 usecs
calling  cgw_module_init+0x0/0x152 @ 1
can: netlink gateway - max_hops=1
initcall cgw_module_init+0x0/0x152 returned 0 after 1724 usecs
calling  vlan_proto_init+0x0/0xa6 @ 1
8021q: 802.1Q VLAN Support v1.8
initcall vlan_proto_init+0x0/0xa6 returned 0 after 820 usecs
calling  init_p9+0x0/0x2f @ 1
9pnet: Installing 9P2000 support
initcall init_p9+0x0/0x2f returned 0 after 10920 usecs
calling  p9_virtio_init+0x0/0x4e @ 1
initcall p9_virtio_init+0x0/0x4e returned 0 after 199 usecs
calling  caif_device_init+0x0/0x38 @ 1
initcall caif_device_init+0x0/0x38 returned 0 after 194 usecs
calling  chnl_init_module+0x0/0x11 @ 1
initcall chnl_init_module+0x0/0x11 returned 0 after 6 usecs
calling  caif_sktinit_module+0x0/0x11 @ 1
NET: Registered protocol family 37
initcall caif_sktinit_module+0x0/0x11 returned 0 after 727 usecs
calling  dcbnl_init+0x0/0x4e @ 1
initcall dcbnl_init+0x0/0x4e returned 0 after 42 usecs
calling  vsock_init+0x0/0x185 @ 1
NET: Registered protocol family 40
initcall vsock_init+0x0/0x185 returned 0 after 18052 usecs
calling  hsr_init+0x0/0x16 @ 1
initcall hsr_init+0x0/0x16 returned 0 after 232 usecs
calling  qrtr_tun_init+0x0/0x2c @ 1
initcall qrtr_tun_init+0x0/0x2c returned 0 after 484 usecs
calling  hpet_insert_resource+0x0/0x23 @ 1
initcall hpet_insert_resource+0x0/0x23 returned 0 after 5 usecs
calling  update_mp_table+0x0/0x5e2 @ 1
initcall update_mp_table+0x0/0x5e2 returned 0 after 1 usecs
calling  lapic_insert_resource+0x0/0x43 @ 1
initcall lapic_insert_resource+0x0/0x43 returned 0 after 5 usecs
calling  print_ipi_mode+0x0/0x2d @ 1
IPI shorthand broadcast: enabled
initcall print_ipi_mode+0x0/0x2d returned 0 after 681 usecs
calling  print_ICs+0x0/0x308 @ 1
... APIC ID:      00000000 (0)
... APIC VERSION: 00050014
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000

number of MP IRQ sources: 15.
number of IO-APIC #0 registers: 24.
testing the IO APIC.......................
IO APIC #0......
.... register #00: 00000000
.......    : physical APIC id: 00
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 17
.......     : PRQ implemented: 0
.......     : IO APIC version: 11
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
IOAPIC 0:
pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin01, enabled , edge , high, V(22), IRR(0), S(0), logical , D(02), M(0)
pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(01), M(0)
pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin08, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin09, enabled , level, high, V(21), IRR(0), S(0), logical , D(02), M(0)
pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin0c, enabled , edge , high, V(21), IRR(0), S(0), logical , D(01), M(0)
pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(00), M(0)
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
initcall print_ICs+0x0/0x308 returned 0 after 50472 usecs
calling  create_tlb_single_page_flush_ceiling+0x0/0x4f @ 1
initcall create_tlb_single_page_flush_ceiling+0x0/0x4f returned 0 after 10687 usecs
calling  pat_memtype_list_init+0x0/0x58 @ 1
initcall pat_memtype_list_init+0x0/0x58 returned 0 after 63 usecs
calling  init_oops_id+0x0/0x40 @ 1
initcall init_oops_id+0x0/0x40 returned 0 after 7 usecs
calling  sched_clock_init_late+0x0/0x1c @ 1
sched_clock: Marking stable (41171111705, 36924417)->(41348346936, -140310814)
initcall sched_clock_init_late+0x0/0x1c returned 0 after 1155 usecs
calling  sched_init_debug+0x0/0x3e @ 1
initcall sched_init_debug+0x0/0x3e returned 0 after 102 usecs
calling  cpu_latency_qos_init+0x0/0x3a @ 1
initcall cpu_latency_qos_init+0x0/0x3a returned 0 after 5963 usecs
calling  printk_late_init+0x0/0x207 @ 1
initcall printk_late_init+0x0/0x207 returned 0 after 11 usecs
calling  rcu_verify_early_boot_tests+0x0/0x60 @ 1
initcall rcu_verify_early_boot_tests+0x0/0x60 returned 0 after 1 usecs
calling  init_srcu_module_notifier+0x0/0x2c @ 1
initcall init_srcu_module_notifier+0x0/0x2c returned 0 after 5 usecs
calling  swiotlb_create_debugfs+0x0/0x53 @ 1
initcall swiotlb_create_debugfs+0x0/0x53 returned 0 after 179 usecs
calling  tk_debug_sleep_time_init+0x0/0x24 @ 1
initcall tk_debug_sleep_time_init+0x0/0x24 returned 0 after 81 usecs
calling  debugfs_kprobe_init+0x0/0xd2 @ 1
initcall debugfs_kprobe_init+0x0/0xd2 returned 0 after 185 usecs
calling  taskstats_init+0x0/0x3b @ 1
registered taskstats version 1
initcall taskstats_init+0x0/0x3b returned 0 after 759 usecs
calling  init_hwlat_tracer+0x0/0xb1 @ 1
initcall init_hwlat_tracer+0x0/0xb1 returned 0 after 227 usecs
calling  bpf_map_iter_init+0x0/0x62 @ 1
initcall bpf_map_iter_init+0x0/0x62 returned 0 after 47 usecs
calling  task_iter_init+0x0/0xe9 @ 1
initcall task_iter_init+0x0/0xe9 returned 0 after 56 usecs
calling  bpf_prog_iter_init+0x0/0x51 @ 1
initcall bpf_prog_iter_init+0x0/0x51 returned 0 after 16 usecs
calling  fault_around_debugfs+0x0/0x24 @ 1
initcall fault_around_debugfs+0x0/0x24 returned 0 after 62 usecs
calling  fail_page_alloc_debugfs+0x0/0x75 @ 1
initcall fail_page_alloc_debugfs+0x0/0x75 returned 0 after 500 usecs
calling  split_huge_pages_debugfs+0x0/0x24 @ 1
initcall split_huge_pages_debugfs+0x0/0x24 returned 0 after 50 usecs
calling  pageowner_init+0x0/0x4d @ 1
initcall pageowner_init+0x0/0x4d returned 0 after 55 usecs
calling  check_early_ioremap_leak+0x0/0xb5 @ 1
initcall check_early_ioremap_leak+0x0/0xb5 returned 0 after 1 usecs
calling  cma_debugfs_init+0x0/0x2d5 @ 1
initcall cma_debugfs_init+0x0/0x2d5 returned 0 after 61 usecs
calling  set_hardened_usercopy+0x0/0xeb @ 1
initcall set_hardened_usercopy+0x0/0xeb returned 1 after 1 usecs
calling  init_percpu_stats_debugfs+0x0/0x24 @ 1
initcall init_percpu_stats_debugfs+0x0/0x24 returned 0 after 62 usecs
calling  fscrypt_init+0x0/0xc9 @ 1
Key type ._fscrypt registered
Key type .fscrypt registered
Key type fscrypt-provisioning registered
initcall fscrypt_init+0x0/0xc9 returned 0 after 17652 usecs
calling  pstore_init+0x0/0x7d @ 1
initcall pstore_init+0x0/0x7d returned 0 after 39 usecs
calling  init_root_keyring+0x0/0xe @ 1
initcall init_root_keyring+0x0/0xe returned 0 after 749 usecs
calling  init_trusted+0x0/0xf5 @ 1
initcall init_trusted+0x0/0xf5 returned 0 after 68 usecs
calling  init_encrypted+0x0/0x154 @ 1
Key type encrypted registered
initcall init_encrypted+0x0/0x154 returned 0 after 25423 usecs
calling  integrity_fs_init+0x0/0x4e @ 1
initcall integrity_fs_init+0x0/0x4e returned 0 after 121 usecs
calling  init_ima+0x0/0x167 @ 1
ima: No TPM chip found, activating TPM-bypass!
ima: Allocated hash algorithm: sha1
ima: No architecture policies found
initcall init_ima+0x0/0x167 returned 0 after 2905 usecs
calling  prandom_init_late+0x0/0x4d @ 1
initcall prandom_init_late+0x0/0x4d returned 0 after 3 usecs
calling  fail_usercopy_debugfs+0x0/0x21 @ 1
initcall fail_usercopy_debugfs+0x0/0x21 returned 0 after 417 usecs
calling  init_error_injection+0x0/0x6a @ 1
initcall init_error_injection+0x0/0x6a returned 0 after 3278 usecs
calling  pci_resource_alignment_sysfs_init+0x0/0x18 @ 1
initcall pci_resource_alignment_sysfs_init+0x0/0x18 returned 0 after 41 usecs
calling  pci_sysfs_init+0x0/0x50 @ 1
initcall pci_sysfs_init+0x0/0x50 returned 0 after 17280 usecs
calling  clk_debug_init+0x0/0x137 @ 1
initcall clk_debug_init+0x0/0x137 returned 0 after 261 usecs
calling  sync_state_resume_initcall+0x0/0x10 @ 1
initcall sync_state_resume_initcall+0x0/0x10 returned 0 after 5 usecs
calling  deferred_probe_initcall+0x0/0xd0 @ 1
initcall deferred_probe_initcall+0x0/0xd0 returned 0 after 243 usecs
calling  edd_init+0x0/0x333 @ 1
initcall edd_init+0x0/0x333 returned -19 after 1 usecs
calling  firmware_memmap_init+0x0/0x5a @ 1
initcall firmware_memmap_init+0x0/0x5a returned 0 after 599 usecs
calling  bpf_sk_storage_map_iter_init+0x0/0x51 @ 1
initcall bpf_sk_storage_map_iter_init+0x0/0x51 returned 0 after 19 usecs
calling  tcp_congestion_default+0x0/0x18 @ 1
initcall tcp_congestion_default+0x0/0x18 returned 0 after 4 usecs
calling  ip_auto_config+0x0/0x73a @ 1
input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
8021q: adding VLAN 0 to HW filter on device eth0
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
IP-Config: Complete:
device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
host=vm-meta-316, domain=, nis-domain=(none)
bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
nameserver0=10.0.2.3

initcall ip_auto_config+0x0/0x73a returned 0 after 1090902 usecs
calling  pci_mmcfg_late_insert_resources+0x0/0xb5 @ 1
initcall pci_mmcfg_late_insert_resources+0x0/0xb5 returned 0 after 1 usecs
calling  latency_fsnotify_init+0x0/0x38 @ 1
initcall latency_fsnotify_init+0x0/0x38 returned 0 after 241 usecs
calling  clear_boot_tracer+0x0/0x26 @ 1
initcall clear_boot_tracer+0x0/0x26 returned 0 after 1 usecs
calling  tracing_set_default_clock+0x0/0x62 @ 1
initcall tracing_set_default_clock+0x0/0x62 returned 0 after 1 usecs
calling  acpi_gpio_handle_deferred_request_irqs+0x0/0xb5 @ 1
initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xb5 returned 0 after 92 usecs
calling  fb_logo_late_init+0x0/0xf @ 1
initcall fb_logo_late_init+0x0/0xf returned 0 after 2 usecs
calling  clk_disable_unused+0x0/0x1a2 @ 1
initcall clk_disable_unused+0x0/0x1a2 returned 0 after 87 usecs
calling  regulator_init_complete+0x0/0x82 @ 1
initcall regulator_init_complete+0x0/0x82 returned 0 after 11 usecs
calling  of_platform_sync_state_init+0x0/0xd @ 1
initcall of_platform_sync_state_init+0x0/0xd returned 0 after 5 usecs
Freeing unused kernel image (initmem) memory: 4240K
Write protecting the kernel read-only data: 45056k
Freeing unused kernel image (text/rodata gap) memory: 2036K
Freeing unused kernel image (rodata/data gap) memory: 1676K
x86/mm: Checked W+X mappings: passed, no W+X pages found.
x86/mm: Checking user space page tables
x86/mm: Checked W+X mappings: passed, no W+X pages found.
Run /init as init process
with arguments:
/init
with environment:
HOME=/
TERM=linux
RESULT_ROOT=/result/rcutorture/300s-cpuhotplug-srcu/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/3
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/vmlinuz-5.10.0-rc1-00006-g3dc80c278022
branch=rt-devel/linux-5.10.y-rt
job=/lkp/jobs/scheduled/vm-meta-316/rcutorture-300s-cpuhotplug-srcu-debian-11.1-x86_64-20220510.cgz-3dc80c278022ec43b137216ac51e25a9468bf2d7-20221214-4957-1q61hs8-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a014-20221212
commit=3dc80c278022ec43b137216ac51e25a9468bf2d7
vmalloc=256M
initramfs_async=0
max_uptime=1200
LKP_SERVER=internal-lkp-server
selinux=0
softlockup_panic=1
prompt_ramdisk=0
vga=normal
systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.

Welcome to Debian GNU/Linux 11 (bullseye)!

random: systemd: uninitialized urandom read (16 bytes read)
Created slice system-getty.slice.
random: systemd: uninitialized urandom read (16 bytes read)
Created slice system-modprobe.slice.
random: systemd: uninitialized urandom read (16 bytes read)
Created slice User and Session Slice.
Reached target Local Encrypted Volumes.
Reached target Paths.
Reached target Slices.
Reached target Swap.
Listening on RPCbind Server Activation Socket.
Listening on Syslog Socket.
Listening on initctl Compatibility Named Pipe.
Listening on Journal Audit Socket.
Listening on Journal Socket (/dev/log).
Listening on Journal Socket.
Listening on udev Control Socket.
Listening on udev Kernel Socket.
Mounting Huge Pages File System...
Mounting POSIX Message Queue File System...
Mounting RPC Pipe File System...
Mounting Kernel Debug File System...
Mounting Kernel Trace File System...
Starting Load Kernel Module configfs...
Starting Load Kernel Module drm...
Starting Load Kernel Module fuse...
Starting Journal Service...
Starting Load Kernel Modules...
Starting Remount Root and Kernel File Systems...
calling  i2c_init+0x0/0x1000 [i2c_core] @ 168
initcall i2c_init+0x0/0x1000 [i2c_core] returned 0 after 991 usecs
Starting Coldplug All udev Devices...
Mounted Huge Pages File System.
Mounted POSIX Message Queue File System.
calling  fuse_init+0x0/0x149 [fuse] @ 169
fuse: init (API version 7.32)
initcall fuse_init+0x0/0x149 [fuse] returned 0 after 19236 usecs
Failed to mount RPC Pipe File System.
See 'systemctl status run-rpc_pipefs.mount' for details.
Mounted Kernel Debug File System.
Mounted Kernel Trace File System.
Finished Load Kernel Module configfs.
Finished Load Kernel Module fuse.
Reached target NFS client services.
Mounting FUSE Control File System...
Mounting Kernel Configuration File System...
Finished Load Kernel Modules.
Finished Remount Root and Kernel File Systems.
calling  drm_core_init+0x0/0x1000 [drm] @ 168
initcall drm_core_init+0x0/0x1000 [drm] returned 0 after 411 usecs
Starting Load/Save Random Seed...
Starting Apply Kernel Variables...
Starting Create System Users...
Finished Load Kernel Module drm.
Mounted FUSE Control File System.
Mounted Kernel Configuration File System.
Failed to start Apply Kernel Variables.
See 'systemctl status systemd-sysctl.service' for details.
Finished Create System Users.
Starting Create Static Device Nodes in /dev...
random: fast init done
OK  ] Finished Create Static Device Nodes in /dev.
Reached target Local File Systems (Pre).
Reached target Local File Systems.
Starting Preprocess NFS configuration...
Finished Preprocess NFS configuration.
Started Journal Service.
Starting Flush Journal to Persistent Storage...
Started Rule-based Manager for Device Events and Files.
Finished Flush Journal to Persistent Storage.
Starting Create Volatile Files and Directories...
Finished Create Volatile Files and Directories.
Starting RPC bind portmap service...
Starting Update UTMP about System Boot/Shutdown...
Started RPC bind portmap service.
Reached target Remote File Systems (Pre).
Reached target Remote File Systems.
Reached target RPC Port Mapper.
Finished Update UTMP about System Boot/Shutdown.
calling  fw_cfg_sysfs_init+0x0/0x1000 [qemu_fw_cfg] @ 191
initcall fw_cfg_sysfs_init+0x0/0x1000 [qemu_fw_cfg] returned 0 after 61083 usecs
calling  cmos_init+0x0/0xecf [rtc_cmos] @ 190
rtc_cmos 00:06: RTC can wake from S4
rtc rtc0: alarm rollover: day
Finished Coldplug All udev Devices.
Reached target System Initialization.
Started Daily apt download activities.
Started Daily apt upgrade and clean activities.
rtc_cmos 00:06: char device (0:0)
rtc_cmos 00:06: registered as rtc0
rtc_cmos 00:06: setting system clock to 2022-12-14T20:58:39 UTC (1671051519)
rtc_cmos 00:06: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
Started Discard unused blocks once a week.
Started Daily rotation of log files.
Started Daily Cleanup of Temporary Directories.
Reached target Timers.
Listening on D-Bus System Message Bus Socket.
Reached target Sockets.
Reached target Basic System.
initcall cmos_init+0x0/0xecf [rtc_cmos] returned 0 after 190233 usecs
Started Regular background program processing daemon.
Started D-Bus System Message Bus.
calling  piix4_driver_init+0x0/0x1000 [i2c_piix4] @ 210
piix4_smbus 0000:00:01.3: SMBus Host Controller at 0x700, revision 0
Starting Helper to synchronize boot up for ifupdown...
Starting LSB: OpenIPMI Driver init script...
Starting System Logging Service...
Starting User Login Management...
initcall piix4_driver_init+0x0/0x1000 [i2c_piix4] returned 0 after 263128 usecs
See 'systemctl status e2scrub_reap.service' for details.
Finished Helper to synchronize boot up for ifupdown.
calling  fbmem_init+0x0/0x1000 [fb] @ 212
calling  leds_init+0x0/0x1000 [led_class] @ 201
initcall leds_init+0x0/0x1000 [led_class] returned 0 after 265 usecs
Starting LSB: Load kernel image with kexec...
Starting Raise network interfaces...
initcall fbmem_init+0x0/0x1000 [fb] returned 0 after 226371 usecs
calling  input_leds_init+0x0/0x1000 [input_leds] @ 201
Started LSB: Load kernel image with kexec.
Failed to start LSB: OpenIPMI Driver init script.
See 'systemctl status openipmi.service' for details.
Started User Login Management.
Finished Raise network interfaces.
Reached target Network.
Starting LKP bootstrap...
initcall input_leds_init+0x0/0x1000 [input_leds] returned 0 after 227038 usecs
Starting /etc/rc.local Compatibility...
Starting OpenBSD Secure Shell server...
Starting Permit User Sessions...
Started LKP bootstrap.
LKP: ttyS0: 270: skip deploy intel ucode as no ucode is specified
Finished Permit User Sessions.
calling  cec_devnode_init+0x0/0x1000 [cec] @ 212
initcall cec_devnode_init+0x0/0x1000 [cec] returned 0 after 330 usecs
random: crng init done
random: 7 urandom warning(s) missed due to ratelimiting
Finished Load/Save Random Seed.
Started OpenBSD Secure Shell server.
LKP: ttyS0: 270: Kernel tests: Boot OK!
LKP: ttyS0: 270: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 5.10.0-rc1-00006-g3dc80c278022 1
calling  drm_kms_helper_init+0x0/0x14 [drm_kms_helper] @ 212
initcall drm_kms_helper_init+0x0/0x14 [drm_kms_helper] returned 0 after 43714 usecs
calling  ttm_init+0x0/0x1000 [ttm] @ 212
initcall ttm_init+0x0/0x1000 [ttm] returned 0 after 9207 usecs
calling  bochs_init+0x0/0x1000 [bochs_drm] @ 212
[drm] Found bochs VGA, ID 0xb0c5.
[drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebf0000.
[TTM] Zone  kernel: Available graphics memory: 6991352 KiB
[TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] Found EDID data blob.
[drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 0
bochs-drmdrmfb: enable CONFIG_FB_LITTLE_ENDIAN to support this framebuffer
LKP: ttyS0: 270:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-316/rcutorture-300s-cpuhotplug-srcu-debian-11.1-x86_64-20220510.cgz-3dc80c278022ec43b137216ac51e25a9468bf2d7-20221214-4957-1q61hs8-5.yaml
bochs-drm 0000:00:02.0: [drm] *ERROR* fbdev: Failed to setup generic emulation (ret=-38)
initcall bochs_init+0x0/0x1000 [bochs_drm] returned 0 after 624433 usecs
Started System Logging Service.
LKP: stdout: 270: Kernel tests: Boot OK!

calling  rcu_torture_init+0x0/0xe14 [rcutorture] @ 473
srcu-torture:--- Start of test: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=3 onoff_holdoff=30 read_exit_delay=13 read_exit_burst=16
srcu:  Start-test grace-period state: g0 f0x0
srcu-torture: Creating rcu_torture_writer task
srcu-torture: Creating rcu_torture_fakewriter task
srcu-torture: rcu_torture_writer task started
rcu_torture_writer: Testing expedited GPs.
rcu_torture_writer: Testing asynchronous GPs.
rcu_torture_writer: Testing normal GPs.
srcu-torture: rcu_torture_fakewriter task started
srcu-torture: Creating rcu_torture_fakewriter task
srcu-torture: Creating rcu_torture_fakewriter task
srcu-torture: rcu_torture_fakewriter task started
srcu-torture: Creating rcu_torture_fakewriter task
srcu-torture: rcu_torture_fakewriter task started
srcu-torture: Creating rcu_torture_reader task
srcu-torture: rcu_torture_fakewriter task started
srcu-torture: Creating rcu_torture_stats task
srcu-torture: rcu_torture_reader task started
srcu-torture: Creating torture_shuffle task
srcu-torture: rcu_torture_stats task started
srcu-torture: Creating torture_stutter task
srcu-torture: torture_shuffle task started
srcu-torture: Creating torture_onoff task
srcu-torture: torture_stutter task started
srcu-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
srcu-torture: Creating rcu_torture_read_exit task
srcu-torture: torture_onoff task started
srcu-torture: torture_onoff begin holdoff
initcall rcu_torture_init+0x0/0xe14 [rcutorture] returned 0 after 66619 usecs
srcu-torture: rcu_torture_read_exit: Start of test
LKP: stdout: 270: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 5.10.0-rc1-00006-g3dc80c278022 1

srcu-torture: rcu_torture_read_exit: End of episode
LKP: stdout: 270:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-316/rcutorture-300s-cpuhotplug-srcu-debian-11.1-x86_64-20220510.cgz-3dc80c278022ec43b137216ac51e25a9468bf2d7-20221214-4957-1q61hs8-5.yaml

RESULT_ROOT=/result/rcutorture/300s-cpuhotplug-srcu/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/3

job=/lkp/jobs/scheduled/vm-meta-316/rcutorture-300s-cpuhotplug-srcu-debian-11.1-x86_64-20220510.cgz-3dc80c278022ec43b137216ac51e25a9468bf2d7-20221214-4957-1q61hs8-5.yaml

result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/rcutorture/300s-cpuhotplug-srcu/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/3, TMP_RESULT_ROOT: /tmp/lkp/result

run-job /lkp/jobs/scheduled/vm-meta-316/rcutorture-300s-cpuhotplug-srcu-debian-11.1-x86_64-20220510.cgz-3dc80c278022ec43b137216ac51e25a9468bf2d7-20221214-4957-1q61hs8-5.yaml

/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-316/rcutorture-300s-cpuhotplug-srcu-debian-11.1-x86_64-20220510.cgz-3dc80c278022ec43b137216ac51e25a9468bf2d7-20221214-4957-1q61hs8-5.yaml&job_state=running -O /dev/null

target ucode: 

2022-12-14 20:58:48 depmod

2022-12-14 20:59:01 sleep 300

srcu-torture: rcu_torture_read_exit: Start of episode
srcu-torture: rcu_torture_read_exit: End of episode
srcu-torture: torture_onoff end holdoff
numa_remove_cpu cpu 1 node 0: mask now 0
------------[ cut here ]------------
kernel BUG at kernel/sched/core.c:7078!
invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 PID: 15 Comm: migration/1 Not tainted 5.10.0-rc1-00006-g3dc80c278022 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
Stopper: multi_cpu_stop+0x0/0x360 <- 0x0
RIP: 0010:sched_cpu_dying+0x2a7/0x340
Code: 55 82 01 a8 01 0f 85 7a fe ff ff c6 05 fa 9e 8d 03 01 90 48 c7 c7 e0 b5 06 83 e8 89 fe 81 01 90 0f 0b 90 90 e9 5c fe ff ff 90 <0f> 0b 48 c7 c7 60 c2 d2 83 e8 c2 99 86 01 e8 86 15 56 00 e9 29 ff
RSP: 0018:ffffc9000010fcd0 EFLAGS: 00010002
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff8119a15c
RDX: 1ffff110740fe9e9 RSI: 0000000000000008 RDI: ffff8883a07f4f48
RBP: ffffc9000010fd08 R08: 0000000000000000 R09: ffff88810004d1bf
R10: ffffed1020009a37 R11: 0000000000000001 R12: ffff8883a07f4f00
R13: 0000000000000001 R14: ffff8883a07f4f18 R15: 0000000000000046
FS:  0000000000000000(0000) GS:ffff8883a0600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f1b8e6c3c0 CR3: 000000011dc36000 CR4: 00000000000406a0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
? sched_cpu_wait_empty+0x240/0x240
cpuhp_invoke_callback+0x1b1/0x8b0
? mp_irqdomain_ioapic_idx+0x30/0x30
? cpuhp_invoke_callback+0x8b0/0x8b0
take_cpu_down+0x110/0x1b0
multi_cpu_stop+0x14c/0x360
cpu_stopper_thread+0x22c/0x480
? stop_machine_yield+0x10/0x10
? cpu_stop_queue_two_works+0x6f0/0x6f0
? smpboot_thread_fn+0xa8/0x830
smpboot_thread_fn+0x349/0x830
? __smpboot_create_thread+0x460/0x460
? __kthread_parkme+0xcb/0x1b0
? schedule+0xbe/0x180
? __smpboot_create_thread+0x460/0x460
? __smpboot_create_thread+0x460/0x460
kthread+0x366/0x440
? kthread_insert_work_sanity_check+0xd0/0xd0
ret_from_fork+0x22/0x30
Modules linked in: rcutorture torture bochs_drm drm_vram_helper drm_ttm_helper ttm drm_kms_helper cec cfbfillrect cfbimgblt cfbcopyarea fb_sys_fops syscopyarea sysfillrect input_leds sysimgblt led_class fb i2c_piix4 fbdev rtc_cmos qemu_fw_cfg drm drm_panel_orientation_quirks fuse i2c_core

======================================================
WARNING: possible circular locking dependency detected
5.10.0-rc1-00006-g3dc80c278022 #1 Not tainted
------------------------------------------------------
migration/1/15 is trying to acquire lock:
ffffffff83d7ff20 (console_owner){-.-.}-{0:0}, at: console_unlock+0x282/0x5e0

but task is already holding lock:
ffff8883a07f4f18 (&rq->lock){-.-.}-{2:2}, at: sched_cpu_dying+0x8c/0x340

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #4 (&rq->lock){-.-.}-{2:2}:
__lock_acquire+0xb93/0x1930
lock_acquire+0x1f8/0x440
_raw_spin_lock+0x31/0x80
task_fork_fair+0x35/0x570
sched_fork+0x4f4/0xaf0
copy_process+0x1261/0x47b0
kernel_clone+0xa9/0x710
kernel_thread+0x97/0xb0
rest_init+0x23/0x337
start_kernel+0x329/0x32f
secondary_startup_64_no_verify+0xb8/0xbb

-> #3 (&p->pi_lock){-.-.}-{2:2}:
__lock_acquire+0xb93/0x1930
lock_acquire+0x1f8/0x440
_raw_spin_lock_irqsave+0x40/0x90
try_to_wake_up+0x82/0xf20
__wake_up_common+0x151/0x660
__wake_up_common_lock+0xc2/0x110
tty_port_default_wakeup+0x1b/0x30
serial8250_tx_chars+0x467/0x960
serial8250_handle_irq+0x1d0/0x3a0
serial8250_interrupt+0xe5/0x1b0
__handle_irq_event_percpu+0x104/0x830
handle_irq_event_percpu+0x63/0x130
handle_irq_event+0xa1/0x130
handle_edge_irq+0x200/0xaa0
asm_call_irq_on_stack+0x12/0x20
common_interrupt+0xf7/0x1b0
asm_common_interrupt+0x1e/0x40
default_idle+0x58/0x70
default_idle_call+0x74/0xa0
cpuidle_idle_call+0x251/0x300
do_idle+0x11d/0x1a0
cpu_startup_entry+0x19/0x20
start_secondary+0x2a8/0x3a0
secondary_startup_64_no_verify+0xb8/0xbb

-> #2 (&tty->write_wait){-.-.}-{2:2}:
__lock_acquire+0xb93/0x1930
lock_acquire+0x1f8/0x440
_raw_spin_lock_irqsave+0x40/0x90
__wake_up_common_lock+0xa6/0x110
tty_port_default_wakeup+0x1b/0x30
serial8250_tx_chars+0x467/0x960
serial8250_handle_irq+0x1d0/0x3a0
serial8250_interrupt+0xe5/0x1b0
__handle_irq_event_percpu+0x104/0x830
handle_irq_event_percpu+0x63/0x130
handle_irq_event+0xa1/0x130
handle_edge_irq+0x200/0xaa0
asm_call_irq_on_stack+0x12/0x20
common_interrupt+0xf7/0x1b0
asm_common_interrupt+0x1e/0x40
default_idle+0x58/0x70
default_idle_call+0x74/0xa0
cpuidle_idle_call+0x251/0x300
do_idle+0x11d/0x1a0
cpu_startup_entry+0x19/0x20
start_secondary+0x2a8/0x3a0
secondary_startup_64_no_verify+0xb8/0xbb

-> #1 (&port_lock_key){-.-.}-{2:2}:
__lock_acquire+0xb93/0x1930
lock_acquire+0x1f8/0x440
_raw_spin_lock_irqsave+0x40/0x90
serial8250_console_write+0x70e/0x8f0
call_console_drivers+0x237/0x400
console_unlock+0x301/0x5e0
vprintk_emit+0x12e/0x140
printk+0x96/0xb2
register_console+0x433/0x6a0
univ8250_console_init+0x24/0x27
console_init+0x304/0x462
start_kernel+0x22c/0x32f
secondary_startup_64_no_verify+0xb8/0xbb

-> #0 (console_owner){-.-.}-{0:0}:
check_prev_add+0x15e/0x2170
validate_chain+0x94d/0xf50
__lock_acquire+0xb93/0x1930
lock_acquire+0x1f8/0x440
console_unlock+0x2f1/0x5e0
vprintk_emit+0x12e/0x140
printk+0x96/0xb2
report_bug.cold+0x31/0x53
handle_bug+0x42/0x80
exc_invalid_op+0x14/0x40
asm_exc_invalid_op+0x12/0x20
sched_cpu_dying+0x2a7/0x340
cpuhp_invoke_callback+0x1b1/0x8b0
take_cpu_down+0x110/0x1b0
multi_cpu_stop+0x14c/0x360
cpu_stopper_thread+0x22c/0x480
smpboot_thread_fn+0x349/0x830
kthread+0x366/0x440
ret_from_fork+0x22/0x30

other info that might help us debug this:

Chain exists of:
console_owner --> &p->pi_lock --> &rq->lock

Possible unsafe locking scenario:

CPU0                    CPU1
----                    ----
lock(&rq->lock);
lock(&p->pi_lock);
lock(&rq->lock);
lock(console_owner);

*** DEADLOCK ***

2 locks held by migration/1/15:
#0: ffff8883a07f4f18 (&rq->lock){-.-.}-{2:2}, at: sched_cpu_dying+0x8c/0x340
#1: ffffffff84100560 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x119/0x140

stack backtrace:
CPU: 1 PID: 15 Comm: migration/1 Not tainted 5.10.0-rc1-00006-g3dc80c278022 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
Stopper: multi_cpu_stop+0x0/0x360 <- 0x0
Call Trace:
dump_stack+0x9a/0xcc
check_noncircular+0x244/0x2f0
? print_circular_bug+0x1f0/0x1f0
? add_lock_to_list+0x193/0x370
check_prev_add+0x15e/0x2170
validate_chain+0x94d/0xf50
? check_prev_add+0x2170/0x2170
? sched_clock+0x2a/0x50
__lock_acquire+0xb93/0x1930
? sched_clock+0x2a/0x50
? sched_clock_cpu+0x31/0x200
lock_acquire+0x1f8/0x440
? console_unlock+0x282/0x5e0
? rcu_read_unlock+0x50/0x50
? get_record_print_text_size+0xc0/0xc0
? do_raw_spin_trylock+0xa2/0x150
? console_unlock+0x2d1/0x5e0
console_unlock+0x2f1/0x5e0
? console_unlock+0x282/0x5e0
? call_console_drivers+0x400/0x400
? down_trylock+0x4a/0x70
? __down_trylock_console_sem+0x64/0xa0
? vprintk_emit+0x119/0x140
vprintk_emit+0x12e/0x140
? sched_cpu_dying+0x2a7/0x340
printk+0x96/0xb2
? record_print_text.cold+0x11/0x11
report_bug.cold+0x31/0x53
handle_bug+0x42/0x80
exc_invalid_op+0x14/0x40
asm_exc_invalid_op+0x12/0x20
RIP: 0010:sched_cpu_dying+0x2a7/0x340
Code: 55 82 01 a8 01 0f 85 7a fe ff ff c6 05 fa 9e 8d 03 01 90 48 c7 c7 e0 b5 06 83 e8 89 fe 81 01 90 0f 0b 90 90 e9 5c fe ff ff 90 <0f> 0b 48 c7 c7 60 c2 d2 83 e8 c2 99 86 01 e8 86 15 56 00 e9 29 ff
RSP: 0018:ffffc9000010fcd0 EFLAGS: 00010002
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff8119a15c
RDX: 1ffff110740fe9e9 RSI: 0000000000000008 RDI: ffff8883a07f4f48
RBP: ffffc9000010fd08 R08: 0000000000000000 R09: ffff88810004d1bf
R10: ffffed1020009a37 R11: 0000000000000001 R12: ffff8883a07f4f00
R13: 0000000000000001 R14: ffff8883a07f4f18 R15: 0000000000000046
? sched_cpu_dying+0x1ac/0x340
? sched_cpu_wait_empty+0x240/0x240
cpuhp_invoke_callback+0x1b1/0x8b0
? mp_irqdomain_ioapic_idx+0x30/0x30
? cpuhp_invoke_callback+0x8b0/0x8b0
take_cpu_down+0x110/0x1b0
multi_cpu_stop+0x14c/0x360
cpu_stopper_thread+0x22c/0x480
? stop_machine_yield+0x10/0x10
? cpu_stop_queue_two_works+0x6f0/0x6f0
? smpboot_thread_fn+0xa8/0x830
smpboot_thread_fn+0x349/0x830
? __smpboot_create_thread+0x460/0x460
? __kthread_parkme+0xcb/0x1b0
? schedule+0xbe/0x180
? __smpboot_create_thread+0x460/0x460
? __smpboot_create_thread+0x460/0x460
kthread+0x366/0x440
? kthread_insert_work_sanity_check+0xd0/0xd0
ret_from_fork+0x22/0x30
---[ end trace 1cb967c307bc8eee ]---
RIP: 0010:sched_cpu_dying+0x2a7/0x340
Code: 55 82 01 a8 01 0f 85 7a fe ff ff c6 05 fa 9e 8d 03 01 90 48 c7 c7 e0 b5 06 83 e8 89 fe 81 01 90 0f 0b 90 90 e9 5c fe ff ff 90 <0f> 0b 48 c7 c7 60 c2 d2 83 e8 c2 99 86 01 e8 86 15 56 00 e9 29 ff
RSP: 0018:ffffc9000010fcd0 EFLAGS: 00010002
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff8119a15c
RDX: 1ffff110740fe9e9 RSI: 0000000000000008 RDI: ffff8883a07f4f48
RBP: ffffc9000010fd08 R08: 0000000000000000 R09: ffff88810004d1bf
R10: ffffed1020009a37 R11: 0000000000000001 R12: ffff8883a07f4f00
R13: 0000000000000001 R14: ffff8883a07f4f18 R15: 0000000000000046
FS:  0000000000000000(0000) GS:ffff8883a0600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f1b8e6c3c0 CR3: 000000011dc36000 CR4: 00000000000406a0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled

Kboot worker: lkp-worker68
Elapsed time: 120

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu SandyBridge
	-kernel $kernel
	-initrd initrd-vm-meta-316.cgz
	-m 16384
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::32032-:22
	-boot order=nc
	-no-reboot
	-device i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	ip=::::vm-meta-316::dhcp
	root=/dev/ram0
	RESULT_ROOT=/result/rcutorture/300s-cpuhotplug-srcu/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/3
	BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a014-20221212/gcc-11/3dc80c278022ec43b137216ac51e25a9468bf2d7/vmlinuz-5.10.0-rc1-00006-g3dc80c278022
	branch=rt-devel/linux-5.10.y-rt
	job=/job-script
	user=lkp
	ARCH=x86_64
	kconfig=x86_64-randconfig-a014-20221212
	commit=3dc80c278022ec43b137216ac51e25a9468bf2d7
	vmalloc=256M
	initramfs_async=0
	page_owner=on
	initcall_debug
	max_uptime=1200
	result_service=tmpfs
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
	rw
	rcuperf.shutdown=0
	watchdog_thresh=240
)

"${kvm[@]}" -append "${append[*]}"

--shUZK62c1qujNoWl--
