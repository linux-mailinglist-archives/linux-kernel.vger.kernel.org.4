Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F423B7290EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjFIH1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238621AbjFIH1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:27:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6652D7B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686295644; x=1717831644;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kRqKSjBb77iPQAt9qVL4MLupL3KQlbNIYx9OcISb3pU=;
  b=GgYyEhGR2llIQcSiMcLlhK67KXYdw0ceA3ukNsNbTtKJ6sa00X37VoQ6
   E1gRoRsh2OtS1oGWldNxC9mJfa9rljuevP+vlgPkEnW1M1FJRdqawreHE
   du03M41hmRnwdwQHAgszzBCw4N8+4/xIMadavY0x1j5JH82gRmufSkeby
   UbSyjNRXBJjT12TKvqGmnWTIqCVd2M6DKZU8fvJawYP5m48+lwjPtSjPq
   XH4PC6sKbC+h0L19uW92+QEFamZYJIWnsYFBaOMjbzsMipG3Ik6mS8Tm/
   mSZ6fuYPBNgqHM/9KOWfMfQfU/qqDZc10nCK6wC5/juwHbjjkz8HEu0w3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342212863"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="xz'341?scan'341,208,341";a="342212863"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 00:27:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="743391345"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="xz'341?scan'341,208,341";a="743391345"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 09 Jun 2023 00:27:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 00:27:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 00:27:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 00:27:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0CBh3KxnrSCJYacvzYTz3Vlo+/XEsz1I43I1npAOkXP4yUqY8kaHKVsiu3VboECehk66TliId1vtWP5t7x3NrNOIYHyUigNrSDiF9q3Uxn0Wu1YheexXZiTjcgJaYzLrABzHda5wUJ2Ay6tlLic+LeUcbFVgA/nwyYoiC0x617nAK7Poo4ofDV1RWm3v8nkReSXDDTDj1ZU5gIMx2aNHZzpQeh0/NaG619PO91UytA8Q719x3ZSA7bbq1VlLhczBNwpej7b28E2+RCBdnQvaUWcLS5J9G4p1vB2ovzEGEDhMVQKZVB5CEui4xNiUVOczsmGuvCBPadChmIqyEeU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onBdjBdm5crkEDr3zQzS1v1kpmUbXroFncJjtekEVDk=;
 b=MFyw2NRszk2hxZSIpoa9VLYvl/5LLXnGtCzsAl2lIoq7jDvb4gciIF9OXLs9ZsPdsHa0S0iaI5WprNgzOwoIhpN8xDxzNJiUJZJpxRZkuFuOvvXJlmkgn2vklmfb3yk9tbHAEQNF2JVHbFjZ2vmqYMepe3W9dkiYA/rlPGKnTPsILHuIC/NQIoZTijtHZo3YskkQ88epzY2q/8zZK1IKnxHWwilx2oZ3bwdVwaQLfv4PXQrw6ArkkL0vtgiOL0tgvdImQfp5GwWnAmJLL+EHL0NX8eVYi7RxkY5NeWe9kh78HgOUlLgj8hTcx4kgn3P5KHkTBU6hc11K9RtBDWRZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA0PR11MB7693.namprd11.prod.outlook.com (2603:10b6:208:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Fri, 9 Jun
 2023 07:27:14 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a%6]) with mapi id 15.20.6455.028; Fri, 9 Jun 2023
 07:27:14 +0000
Date:   Fri, 9 Jun 2023 15:27:02 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Alexander Potapenko <glider@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dipanjan Das <mail.dipanjan.das@gmail.com>,
        Marco Elver <elver@google.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <oliver.sang@intel.com>
Subject: [mm]  47ebd0310e: kernel_BUG_at_arch/x86/kernel/irqinit.c
Message-ID: <ZILURoD7J3eVtXsV@xsang-OptiPlex-9020>
Content-Type: multipart/mixed; boundary="nyckAaS2Scl5ZOTi"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA0PR11MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 04dbd7d2-e1c5-4331-b8c3-08db68baf1c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZ46MDfhQdE3E2fjhpiPtGsd2Yiz0yabeYHopySQC/XxA70Og41DAk1zu6CycTBC2ta9wJjrBySeg1p/9K4vV/gOYxtGxD1S+WB9vDFVRszBoOpteNbAnQPNkcyg7OZtX/umhX4HWBPjQbgxDx/xY+zgX865KKB/UO6bD2s+8OKvKWyxLheRkWFog9HOX5uKKijhNrdo/37/RmZzMLIw2W2hci0c/PyK2XONeHv8gN06HJS9fATcKmqjgdxTzEc1PAMQ/EO+WDd4s/3HLbJP4nzjUqsrgrf4vEqkWITJldUXY5ejzohoyqOaWwDFHuIAJeCqGqqSbyDLwjrtGX7LKyv+K+EsWKGLhqWEd1W1jtU+WviRuwN/of/FE0+fUMgkWBYNvncNzyAsLLPdPEYwzmATzZVEbgQM3ONci2RyJj0RIBUDO9c+vy2BJiKdv4MZPOoVrnxHQ2qLaZCiSseNqLIW0AIGFlAA17pQymZqGYgOHb2SIwTO396Ed+TmESC0YqBUsn+zB+yWEJZzRSzT0t9GyFnpn83EbfbhYKzc+y4/37nWGur+zX0ylil/Fw3Ip/+nzLrm+T3aVWzGlaX0vHR90NeKY0vc9Kqmpx53lra98h2AjsmWZxiACV748XWn9U1VA9UEgRsZEVfqbf0plEEerEGiWWPTLE1qHLwlQbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(86362001)(66476007)(478600001)(4326008)(54906003)(6916009)(966005)(66946007)(316002)(45080400002)(107886003)(66556008)(44144004)(6486002)(33716001)(235185007)(8676002)(8936002)(41300700001)(2906002)(5660300002)(38100700002)(82960400001)(9686003)(6512007)(26005)(6506007)(186003)(83380400001)(6666004)(2700100001)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fMD3Ac9ePOXVP0bAy1JawdmKsNSZYiH4OhvqR4Ud4MCa4g/6u0jAhslPJoFo?=
 =?us-ascii?Q?0gLOUUpnM2HOlZcgy2iyID9W05lauN7SCn/Njm7bVEbQc02c8BDmozIOsbtM?=
 =?us-ascii?Q?BGmrrXOprICgL5tGxDD6TF7bgqg2hwrox8eHzxeWnHST9mboytrz5m2HMqoC?=
 =?us-ascii?Q?+NEYu99QFq6oWvWqSMy6YY4sOTfhVJae0m+4NBJKeZeLFdSCaWht23qOA5zM?=
 =?us-ascii?Q?TyBnQ4bkfnSeu2zyyHYB3V+gR6pY8cfTv3eRwMWHADwKr0alPcVC1CzAAYDs?=
 =?us-ascii?Q?JqyW13k8IQnLH+jp+iRRkj+FOXH3f1CoKJL4s+avAUGlf0Cn6aLKcyzVlNqm?=
 =?us-ascii?Q?MlMjdE78cFIZNVyq2eSvxWSfs4FUfRdYM8hCx54ktBIsgD5wvheANuZvICxE?=
 =?us-ascii?Q?OKtHBaMcD9thOlRbs+Xf4QJ0PkPjF5k/AjLVOZIKHzMGa+V/JBSz/zvYcjpq?=
 =?us-ascii?Q?YWNG5GHwDMOhbCDmJQOQXiyhaJKRFq0Z+S8w0mSlCofVgrIuU2wkQKhEpmHg?=
 =?us-ascii?Q?mXhfih1e8XIzCUXtAxn66livcM4ln+kTXUhCEs1bsd0U+SgIaboma6zwL5I4?=
 =?us-ascii?Q?/7AB3Cx4TFMvqwnlYBbM7FQ6YEMQTXgFuoiCbXZDzPJL68tgmdMPcOSMASdo?=
 =?us-ascii?Q?4lxVXmFevFcCCk+Kz9h+ExORo3oYPiWqw3LAEd9tScei/55A2Md9MpprRT1N?=
 =?us-ascii?Q?5AV+yTTGLrh5K8xOoPBRDjKQ/sf7Iys0WJPDMs3/LXRtPe+8kNLkgezmRk2D?=
 =?us-ascii?Q?YUOiP6bpi1Mfkvo8HV51iXieczcZsNwRXYbElqw9nsCl1k3V7Z/WXNgB11AV?=
 =?us-ascii?Q?bXTzE0ciLqeFpt/ISsN5cOwiO291UYZ6lW48JJ6lhD61AEKr2zIXOmZfylpG?=
 =?us-ascii?Q?QHqDD+9iq9zp5Dxltzmw3Zn2iC0/ZVEBAWxdPk/ooEFFxBGLfq7OprcH6oA4?=
 =?us-ascii?Q?WAQwVKip+alehdtE0ycn0+p8TyNKMR8DPeQjENT80GPDTC1mJuv/pDuvQWAe?=
 =?us-ascii?Q?gRAi1076fCqRX56R5FYqBsbvtdOgbiJrWmPbi15w+IOkukchCySv3rd+iIvZ?=
 =?us-ascii?Q?oqPj28hYWPqR9XeNWm/9xyfGwkkwwLug1Tpw0my+VdzWAl8IB1OgidyJRxEX?=
 =?us-ascii?Q?Opm9wqpu5ZoltYgV9IE5rCOKJj6CpNSzJe/c8k1717qGMc/8T/UK12FZnbjq?=
 =?us-ascii?Q?0NH8EaOgL1qaDv98MDp0RD3Vv3pNjc4p15u72mNWo9CMTLoPa7RxdvVEu31i?=
 =?us-ascii?Q?aOcfUXPrUCOrwvKGwvF+LulAN0LkM82493npV8dUtx5b3NpqT2QT5FbUKDo+?=
 =?us-ascii?Q?xth+daaCzn68VMKV20sk40mAnZePHK9vEreWhb+rYacqqOsqpvaJq+62kLcF?=
 =?us-ascii?Q?YOjojXcYU7zcCE7VSUgKx+sHXFZGXgsNp7BtHZft7HTP0KI2KNPH4U1iXPGl?=
 =?us-ascii?Q?fzg1O6NLHyQipPvCG3QC8SOUHFK7jtaQfmtlgOr25Zy4tHWPfD+CrYPakPyL?=
 =?us-ascii?Q?gW58wz72VA87ykKZPH/2P2f0WFFeh60/jXqR5drTHZcz1kMbAkHbwmrdRjyP?=
 =?us-ascii?Q?6twrI+t4VITynG2/l8UnLvADqmQiBCfMuYqLLQJJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dbd7d2-e1c5-4331-b8c3-08db68baf1c3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 07:27:14.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nizqxNiPPlHjXyG4lPUAWEWd7qiIoyYAgBN/D/kH6l0Sk+4h/e5nYj13NjP0sAOQWuRQSoAgTvrodr5hLQxCBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7693
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nyckAaS2Scl5ZOTi
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


hi, Alexander Potapenko,

in our below tests, both 47ebd0310e and its parent show various issues, but
we found some differences:

both 47ebd0310e and its parent will first show issue
  "WARNING:at_mm/vmalloc.c:#__vmap_pages_range_noflush"
such like:

[    0.010000][    T0] WARNING: CPU: 0 PID: 0 at mm/vmalloc.c:477 __vmap_pages_range_noflush+0x1182/0x1550

after it, for 47ebd0310e, it will show issue
  "kernel_BUG_at_arch/x86/kernel/irqinit.c" such like:

[    0.010000][    T0] kernel BUG at arch/x86/kernel/irqinit.c:89!

then crash soon:

[    0.010000][    T0] Kernel panic - not syncing: Fatal exception

however, for parent, we observed there is no
  "kernel_BUG_at_arch/x86/kernel/irqinit.c"
it could run further with other issues as listed in table within below full
report, until:

[   13.341722][    T1] general protection fault, maybe for address 0x0: 0000 [#1] PREEMPT SMP

then:

[   13.365591][    T1] Kernel panic - not syncing: Fatal exception

both dmesg for 47ebd0310e and its parent are attached.

for the difference, we have not enough idea whether they are meaningful
enough since after the first same issue:
  "WARNING:at_mm/vmalloc.c:#__vmap_pages_range_noflush"
(if meaningless, maybe this report could be ignored)
and what's the real relation with the code change in 47ebd0310e.

we just report what we found in our tests for your information and hope it
could supply some hints.

if you need more tests, please let us know. Thanks!

below is the detail report.


Greeting,

FYI, we noticed the following commit (built with clang-15):

commit: 47ebd0310e89c087f56e58c103c44b72a2f6b216 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+--------------------------------------------------------------+------------+------------+
|                                                              | a101482421 | 47ebd0310e |
+--------------------------------------------------------------+------------+------------+
| boot_successes                                               | 0          | 0          |
| boot_failures                                                | 9          | 6          |
| WARNING:at_mm/vmalloc.c:#__vmap_pages_range_noflush          | 9          | 6          |
| RIP:__vmap_pages_range_noflush                               | 9          | 6          |
| WARNING:at_mm/kmsan/shadow.c:#kmsan_vmap_pages_range_noflush | 9          |            |
| RIP:kmsan_vmap_pages_range_noflush                           | 9          |            |
| maybe_for_address#:#[##]                                     | 9          |            |
| RIP:memset                                                   | 9          |            |
| Kernel_panic-not_syncing:Fatal_exception                     | 9          | 6          |
| kernel_BUG_at_arch/x86/kernel/irqinit.c                      | 0          | 6          |
| invalid_opcode:#[##]                                         | 0          | 6          |
| RIP:init_IRQ                                                 | 0          | 6          |
+--------------------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[    0.010000][    T0] kernel BUG at arch/x86/kernel/irqinit.c:89!
[    0.010000][    T0] invalid opcode: 0000 [#1] PREEMPT SMP
[    0.010000][    T0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.3.0-rc4-00044-g47ebd0310e89 #1
[ 0.010000][ T0] RIP: 0010:init_IRQ (arch/x86/kernel/irqinit.c:89) 
[ 0.010000][ T0] Code: 3f cd fb e9 08 fe ff ff 8b 3a e8 56 3f cd fb e9 10 fe ff ff e8 4c 3f cd fb eb 9d 41 8b bc 24 a8 0f 00 00 e8 3d 3f cd fb eb aa <0f> 0b 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 57
All code
========
   0:	3f                   	(bad)
   1:	cd fb                	int    $0xfb
   3:	e9 08 fe ff ff       	jmp    0xfffffffffffffe10
   8:	8b 3a                	mov    (%rdx),%edi
   a:	e8 56 3f cd fb       	call   0xfffffffffbcd3f65
   f:	e9 10 fe ff ff       	jmp    0xfffffffffffffe24
  14:	e8 4c 3f cd fb       	call   0xfffffffffbcd3f65
  19:	eb 9d                	jmp    0xffffffffffffffb8
  1b:	41 8b bc 24 a8 0f 00 	mov    0xfa8(%r12),%edi
  22:	00 
  23:	e8 3d 3f cd fb       	call   0xfffffffffbcd3f65
  28:	eb aa                	jmp    0xffffffffffffffd4
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  33:	00 00 
  35:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  3a:	55                   	push   %rbp
  3b:	48 89 e5             	mov    %rsp,%rbp
  3e:	41 57                	push   %r15

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   9:	00 00 
   b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10:	55                   	push   %rbp
  11:	48 89 e5             	mov    %rsp,%rbp
  14:	41 57                	push   %r15
[    0.010000][    T0] RSP: 0000:ffffffff85403e68 EFLAGS: 00010082
[    0.010000][    T0] RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: 0000000000000000
[    0.010000][    T0] RDX: ffff88841f48d3d0 RSI: 0000000000000004 RDI: 0000000000262088
[    0.010000][    T0] RBP: ffffffff85403eb8 R08: ffffea000000000f R09: ffff88843ffbf000
[    0.010000][    T0] R10: ffff8883ef369a98 R11: 0000000000000000 R12: ffffffff85416b48
[    0.010000][    T0] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000010
[    0.010000][    T0] FS:  0000000000000000(0000) GS:ffff88843f600000(0000) knlGS:0000000000000000
[    0.010000][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.010000][    T0] CR2: ffff88843ffff000 CR3: 000000000545a000 CR4: 00000000000406b0
[    0.010000][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.010000][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.010000][    T0] Call Trace:
[    0.010000][    T0]  <TASK>
[ 0.010000][ T0] start_kernel (init/main.c:1050) 
[ 0.010000][ T0] ? __msan_metadata_ptr_for_load_8 (arch/x86/include/asm/smap.h:56 mm/kmsan/instrumentation.c:37 mm/kmsan/instrumentation.c:92) 
[ 0.010000][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:557) 
[ 0.010000][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:538) 
[ 0.010000][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358) 
[    0.010000][    T0]  </TASK>
[    0.010000][    T0] Modules linked in:
[    0.010000][    T0] ---[ end trace 0000000000000000 ]---
[ 0.010000][ T0] RIP: 0010:init_IRQ (arch/x86/kernel/irqinit.c:89) 
[ 0.010000][ T0] Code: 3f cd fb e9 08 fe ff ff 8b 3a e8 56 3f cd fb e9 10 fe ff ff e8 4c 3f cd fb eb 9d 41 8b bc 24 a8 0f 00 00 e8 3d 3f cd fb eb aa <0f> 0b 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 57
All code
========
   0:	3f                   	(bad)
   1:	cd fb                	int    $0xfb
   3:	e9 08 fe ff ff       	jmp    0xfffffffffffffe10
   8:	8b 3a                	mov    (%rdx),%edi
   a:	e8 56 3f cd fb       	call   0xfffffffffbcd3f65
   f:	e9 10 fe ff ff       	jmp    0xfffffffffffffe24
  14:	e8 4c 3f cd fb       	call   0xfffffffffbcd3f65
  19:	eb 9d                	jmp    0xffffffffffffffb8
  1b:	41 8b bc 24 a8 0f 00 	mov    0xfa8(%r12),%edi
  22:	00 
  23:	e8 3d 3f cd fb       	call   0xfffffffffbcd3f65
  28:	eb aa                	jmp    0xffffffffffffffd4
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  33:	00 00 
  35:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  3a:	55                   	push   %rbp
  3b:	48 89 e5             	mov    %rsp,%rbp
  3e:	41 57                	push   %r15

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   9:	00 00 
   b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  10:	55                   	push   %rbp
  11:	48 89 e5             	mov    %rsp,%rbp
  14:	41 57                	push   %r15


To reproduce:

        # build kernel
	cd linux
	cp config-6.3.0-rc4-00044-g47ebd0310e89 .config
	make HOSTCC=clang-15 CC=clang-15 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=clang-15 CC=clang-15 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
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



--nyckAaS2Scl5ZOTi
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.3.0-rc4-00044-g47ebd0310e89"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.3.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=150007
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=150007
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=150007
CONFIG_RUST_IS_AVAILABLE=y
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
# CONFIG_KERNEL_XZ is not set
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
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
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
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
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
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
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
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
CONFIG_SRCU=y
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
# CONFIG_RCU_BOOST is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_FORCE is not set
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
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_IO_URING is not set
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_KCMP is not set
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
# CONFIG_RUST is not set
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
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
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
# CONFIG_DMI is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
# CONFIG_SCHED_CLUSTER is not set
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
CONFIG_X86_SGX=y
# CONFIG_EFI is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
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
# CONFIG_LIVEPATCH is not set
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
# CONFIG_RETPOLINE is not set
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
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
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
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
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
# CONFIG_ACPI_EXTLOG is not set
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
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
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
# CONFIG_ISA_DMA_API is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
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
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
# CONFIG_KVM_INTEL is not set
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
CONFIG_KVM_XEN=y
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
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
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
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_HAS_LTO_CLANG=y
CONFIG_LTO_NONE=y
# CONFIG_LTO_CLANG_FULL is not set
# CONFIG_LTO_CLANG_THIN is not set
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
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
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
CONFIG_PREEMPT_NOTIFIERS=y
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
# CONFIG_SLOB_DEPRECATED is not set
CONFIG_SLUB_TINY=y
CONFIG_SLAB_MERGE_DEFAULT=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
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
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
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
CONFIG_ZONE_DEVICE=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y
# CONFIG_LRU_GEN_STATS is not set

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
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
# CONFIG_EISA_VIRTUAL_ROOT is not set
# CONFIG_EISA_NAMES is not set
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
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_LOAD_CIS is not set
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
CONFIG_DEVTMPFS_SAFE=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
CONFIG_FW_LOADER_COMPRESS_ZSTD=y
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
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
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
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
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE is not set

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

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_SMPRO_ERRMON=y
CONFIG_SMPRO_MISC=y
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
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
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_UACCE=y
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
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
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
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
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
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
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

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
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADC=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_PXRC=y
CONFIG_JOYSTICK_QWIIC=y
CONFIG_JOYSTICK_FSIA6B=y
# CONFIG_JOYSTICK_SENSEHAT is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=y
CONFIG_TABLET_USB_AIPTEK=y
CONFIG_TABLET_USB_HANWANG=y
CONFIG_TABLET_USB_KBTAB=y
CONFIG_TABLET_USB_PEGASUS=y
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_ADC=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
# CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP5=y
CONFIG_TOUCHSCREEN_DA9034=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX=y
CONFIG_TOUCHSCREEN_ILI210X=y
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_S6SY761=y
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=y
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_IMAGIS=y
CONFIG_TOUCHSCREEN_INEXIO=y
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_PENMOUNT=y
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_PIXCIR=y
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
CONFIG_TOUCHSCREEN_RM_TS=y
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
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
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

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
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_HYPERV_KEYBOARD=y
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
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
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_LANTIQ=y
CONFIG_SERIAL_LANTIQ_CONSOLE=y
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_SPRD=y
CONFIG_SERIAL_SPRD_CONSOLE=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_RPMSG_TTY=y
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
CONFIG_SSIF_IPMI_BMC=y
CONFIG_IPMB_DEVICE_INTERFACE=y
# CONFIG_HW_RANDOM is not set
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C=y
CONFIG_TCG_TIS_I2C_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS_CLASS=y
# CONFIG_XILLYBUS is not set
CONFIG_XILLYUSB=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
# CONFIG_I2C_ALGOPCA is not set
# end of I2C Algorithms

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
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_CP2615=y
# CONFIG_I2C_PCI1XXXX is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
CONFIG_DW_I3C_MASTER=y
# CONFIG_SVC_I3C_MASTER is not set
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
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_CY8C95X0=y
# CONFIG_PINCTRL_DA9062 is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L90=y

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
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y
CONFIG_GPIO_IDIO_16=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_SIOX=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=y
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_CRYSTAL_COVE=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_MADERA is not set
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_WM8350=y
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
# CONFIG_GPIO_VIPERBOARD is not set
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_LATCH=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_MT6323 is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_CHARGER_DA9150 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_AXP20X_POWER=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_MT6360=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_RT9467 is not set
CONFIG_CHARGER_RT9471=y
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_SMPRO=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=y
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_CORSAIR_CPRO is not set
CONFIG_SENSORS_CORSAIR_PSU=y
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_I8K is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC2992=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX127 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX31760=y
CONFIG_SENSORS_MAX6620=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MC34VR500=y
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_SENSORS_PECI_CPUTEMP=y
# CONFIG_SENSORS_PECI_DIMMTEMP is not set
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1266=y
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_BEL_PFE=y
# CONFIG_SENSORS_BPA_RS600 is not set
CONFIG_SENSORS_DELTA_AHE50DC_FAN=y
CONFIG_SENSORS_FSP_3Y=y
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
CONFIG_SENSORS_INSPUR_IPSPS=y
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_IR36021=y
CONFIG_SENSORS_IR38064=y
# CONFIG_SENSORS_IR38064_REGULATOR is not set
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=y
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=y
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX16601=y
CONFIG_SENSORS_MAX20730=y
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_MP2888=y
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_MPQ7932_REGULATOR is not set
CONFIG_SENSORS_MPQ7932=y
CONFIG_SENSORS_PIM4328=y
CONFIG_SENSORS_PLI1209BC=y
CONFIG_SENSORS_PLI1209BC_REGULATOR=y
CONFIG_SENSORS_PM6764TR=y
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_Q54SJ108A2=y
CONFIG_SENSORS_STPDDC60=y
# CONFIG_SENSORS_TDA38640 is not set
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_TPS546D24=y
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_XDPE152=y
CONFIG_SENSORS_XDPE122=y
CONFIG_SENSORS_XDPE122_REGULATOR=y
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
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
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA238=y
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_TMP464 is not set
CONFIG_SENSORS_TMP513=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM8350=y

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
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_SMPRO=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_INTEL_SOC_PMIC=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=y
CONFIG_MFD_RT5120=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_RAVE_SP_CORE=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=y
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX20086=y
# CONFIG_REGULATOR_MAX20411 is not set
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MP8859=y
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6331=y
# CONFIG_REGULATOR_MT6332 is not set
# CONFIG_REGULATOR_MT6357 is not set
CONFIG_REGULATOR_MT6358=y
# CONFIG_REGULATOR_MT6359 is not set
# CONFIG_REGULATOR_MT6360 is not set
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4831=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_RT5120=y
CONFIG_REGULATOR_RT5190A=y
# CONFIG_REGULATOR_RT5759 is not set
CONFIG_REGULATOR_RT6160=y
CONFIG_REGULATOR_RT6190=y
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=y
CONFIG_REGULATOR_SKY81452=y
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_WM8350=y
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
# CONFIG_CEC_GPIO is not set
CONFIG_USB_PULSE8_CEC=y
CONFIG_USB_RAINSHADOW_CEC=y
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

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
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_DVB_CORE is not set
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# CONFIG_V4L2_FLASH_LED_CLASS is not set
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
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y
CONFIG_DVB_PLATFORM_DRIVERS=y
# CONFIG_V4L_MEM2MEM_DRIVERS is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
CONFIG_VIDEO_CADENCE_CSI2RX=y
CONFIG_VIDEO_CADENCE_CSI2TX=y

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#
# CONFIG_VIDEO_CAFE_CCIC is not set

#
# Mediatek media platform drivers
#

#
# Microchip Technology, Inc. media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# Verisilicon media platform drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_UVC_COMMON=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# Camera sensor devices
#
CONFIG_VIDEO_AR0521=y
CONFIG_VIDEO_HI556=y
CONFIG_VIDEO_HI846=y
CONFIG_VIDEO_HI847=y
CONFIG_VIDEO_IMX208=y
# CONFIG_VIDEO_IMX214 is not set
CONFIG_VIDEO_IMX219=y
# CONFIG_VIDEO_IMX258 is not set
CONFIG_VIDEO_IMX274=y
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX296 is not set
CONFIG_VIDEO_IMX319=y
CONFIG_VIDEO_IMX355=y
CONFIG_VIDEO_MAX9271_LIB=y
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
CONFIG_VIDEO_MT9M111=y
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
CONFIG_VIDEO_MT9T112=y
# CONFIG_VIDEO_MT9V011 is not set
CONFIG_VIDEO_MT9V032=y
CONFIG_VIDEO_MT9V111=y
# CONFIG_VIDEO_NOON010PC30 is not set
CONFIG_VIDEO_OG01A1B=y
CONFIG_VIDEO_OV02A10=y
CONFIG_VIDEO_OV08D10=y
CONFIG_VIDEO_OV08X40=y
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=y
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
CONFIG_VIDEO_OV2685=y
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV4689 is not set
CONFIG_VIDEO_OV5647=y
CONFIG_VIDEO_OV5648=y
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV7251=y
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_OV8856=y
CONFIG_VIDEO_OV8858=y
# CONFIG_VIDEO_OV8865 is not set
CONFIG_VIDEO_OV9640=y
CONFIG_VIDEO_OV9650=y
# CONFIG_VIDEO_OV9734 is not set
CONFIG_VIDEO_RDACM20=y
CONFIG_VIDEO_RDACM21=y
CONFIG_VIDEO_RJ54N1=y
CONFIG_VIDEO_S5K5BAF=y
CONFIG_VIDEO_S5K6A3=y
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_CCS is not set
CONFIG_VIDEO_ET8EK8=y
# CONFIG_VIDEO_M5MOLS is not set
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
# CONFIG_VIDEO_AK7375 is not set
CONFIG_VIDEO_DW9714=y
# CONFIG_VIDEO_DW9768 is not set
CONFIG_VIDEO_DW9807_VCM=y
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=y
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_SONY_BTF_MPX is not set
CONFIG_VIDEO_TDA7432=y
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
CONFIG_VIDEO_TEA6420=y
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_UDA1342=y
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
CONFIG_VIDEO_ADV7183=y
CONFIG_VIDEO_ADV7604=y
CONFIG_VIDEO_ADV7604_CEC=y
CONFIG_VIDEO_ADV7842=y
CONFIG_VIDEO_ADV7842_CEC=y
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=y
# CONFIG_VIDEO_BT866 is not set
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
# CONFIG_VIDEO_TC358743_CEC is not set
# CONFIG_VIDEO_TC358746 is not set
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
# CONFIG_VIDEO_TW2804 is not set
CONFIG_VIDEO_TW9903=y
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_TW9910=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_AD9389B is not set
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
# CONFIG_VIDEO_ADV7343 is not set
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_ADV7511=y
CONFIG_VIDEO_ADV7511_CEC=y
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_THS8200=y
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
# CONFIG_VIDEO_I2C is not set
CONFIG_VIDEO_M52790=y
# CONFIG_VIDEO_ST_MIPID02 is not set
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_FC2580=y
# CONFIG_MEDIA_TUNER_IT913X is not set
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2131=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MXL301RF=y
# CONFIG_MEDIA_TUNER_MXL5005S is not set
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_QM1D1B0004=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_R820T=y
# CONFIG_MEDIA_TUNER_SI2157 is not set
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
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
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_KTZ8866 is not set
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA903X=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_RT4831 is not set
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_BACKLIGHT_RAVE_SP is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
# CONFIG_HID_VIVALDI is not set
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_VRC2=y
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NINTENDO=y
# CONFIG_NINTENDO_FF is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PXRC=y
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SEMITEK=y
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_HYPERV_MOUSE is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=y
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# HID-BPF support
#
# end of HID-BPF support

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
CONFIG_USB_MOUSE=y
# end of USB HID Boot Protocol drivers
# end of USB HID support

# CONFIG_I2C_HID is not set

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
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
CONFIG_USB_CDNS_SUPPORT=y
# CONFIG_USB_CDNS3 is not set
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
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_CONSOLE is not set
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=y
CONFIG_USB_SERIAL_AIRCABLE=y
# CONFIG_USB_SERIAL_ARK3116 is not set
CONFIG_USB_SERIAL_BELKIN=y
CONFIG_USB_SERIAL_CH341=y
CONFIG_USB_SERIAL_WHITEHEAT=y
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
CONFIG_USB_SERIAL_CP210X=y
CONFIG_USB_SERIAL_CYPRESS_M8=y
CONFIG_USB_SERIAL_EMPEG=y
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=y
CONFIG_USB_SERIAL_IPAQ=y
# CONFIG_USB_SERIAL_IR is not set
CONFIG_USB_SERIAL_EDGEPORT=y
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
CONFIG_USB_SERIAL_F8153X=y
CONFIG_USB_SERIAL_GARMIN=y
CONFIG_USB_SERIAL_IPW=y
CONFIG_USB_SERIAL_IUU=y
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=y
CONFIG_USB_SERIAL_KOBIL_SCT=y
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=y
CONFIG_USB_SERIAL_MOS7840=y
CONFIG_USB_SERIAL_MXUPORT=y
CONFIG_USB_SERIAL_NAVMAN=y
# CONFIG_USB_SERIAL_PL2303 is not set
CONFIG_USB_SERIAL_OTI6858=y
CONFIG_USB_SERIAL_QCAUX=y
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
CONFIG_USB_SERIAL_SAFE=y
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=y
CONFIG_USB_SERIAL_SYMBOL=y
CONFIG_USB_SERIAL_TI=y
CONFIG_USB_SERIAL_CYBERJACK=y
CONFIG_USB_SERIAL_WWAN=y
CONFIG_USB_SERIAL_OPTION=y
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=y
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=y
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=y
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=y
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
# CONFIG_USB_GADGET_VERBOSE is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_U_SERIAL_CONSOLE=y

#
# USB Peripheral Controller
#
# CONFIG_USB_GR_UDC is not set
CONFIG_USB_R8A66597=y
# CONFIG_USB_PXA27X is not set
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=y
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_ACM=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_FS=y
CONFIG_USB_F_UVC=y
CONFIG_USB_F_HID=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_CONFIGFS=y
# CONFIG_USB_CONFIGFS_SERIAL is not set
CONFIG_USB_CONFIGFS_ACM=y
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
CONFIG_USB_CONFIGFS_F_FS=y
CONFIG_USB_CONFIGFS_F_HID=y
# CONFIG_USB_CONFIGFS_F_UVC is not set
CONFIG_USB_CONFIGFS_F_PRINTER=y

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=y
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
CONFIG_USB_FUNCTIONFS=y
# CONFIG_USB_FUNCTIONFS_ETH is not set
# CONFIG_USB_FUNCTIONFS_RNDIS is not set
CONFIG_USB_FUNCTIONFS_GENERIC=y
CONFIG_USB_G_SERIAL=y
CONFIG_USB_G_PRINTER=y
# CONFIG_USB_CDC_COMPOSITE is not set
CONFIG_USB_G_HID=y
CONFIG_USB_G_DBGP=y
CONFIG_USB_G_DBGP_PRINTK=y
# CONFIG_USB_G_DBGP_SERIAL is not set
CONFIG_USB_G_WEBCAM=y
CONFIG_USB_RAW_GADGET=y
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
CONFIG_TYPEC_TCPCI=y
CONFIG_TYPEC_RT1711H=y
CONFIG_TYPEC_MT6360=y
CONFIG_TYPEC_TCPCI_MAXIM=y
CONFIG_TYPEC_FUSB302=y
# CONFIG_TYPEC_UCSI is not set
CONFIG_TYPEC_TPS6598X=y
# CONFIG_TYPEC_ANX7411 is not set
# CONFIG_TYPEC_RT1719 is not set
CONFIG_TYPEC_HD3SS3220=y
CONFIG_TYPEC_STUSB160X=y
CONFIG_TYPEC_WUSB3801=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=y
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
CONFIG_TYPEC_MUX_PI3USB30532=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=y
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=y
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y
# CONFIG_LEDS_TPS6105X is not set

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_RT8515 is not set
CONFIG_LEDS_SGM3140=y

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
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
CONFIG_LEDS_TRIGGER_TTY=y

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_SBRIDGE is not set
# CONFIG_EDAC_SKX is not set
# CONFIG_EDAC_I10NM is not set
# CONFIG_EDAC_PND2 is not set
# CONFIG_EDAC_IGEN6 is not set
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
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=y
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_PLX_DMA is not set
CONFIG_XILINX_XDMA=y
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=y
CONFIG_INTEL_LDMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=y
CONFIG_LCD2S=y
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_VFIO=y
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=y
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_BALLOON=y
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
# CONFIG_GREYBUS_ES2 is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set

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
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_STAGING_MEDIA=y
# CONFIG_VIDEO_IPU3_IMGU is not set
# CONFIG_STAGING_MEDIA_DEPRECATED is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_KS7010 is not set
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_HID=y
# CONFIG_GREYBUS_LIGHT is not set
CONFIG_GREYBUS_LOG=y
# CONFIG_GREYBUS_LOOPBACK is not set
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=y
CONFIG_GREYBUS_VIBRATOR=y
CONFIG_GREYBUS_BRIDGED_PHY=y
CONFIG_GREYBUS_GPIO=y
CONFIG_GREYBUS_I2C=y
CONFIG_GREYBUS_PWM=y
CONFIG_GREYBUS_SDIO=y
CONFIG_GREYBUS_UART=y
# CONFIG_GREYBUS_USB is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_MLXREG_IO=y
# CONFIG_MLXREG_LC is not set
CONFIG_NVSW_SN2201=y
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_AMD_PMF is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_ATOMISP2_LED is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL=y
# end of Intel Uncore Frequency Control

# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_VSEC is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_BARCO_P50_GPIO=y
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_WINMATE_FM07_KEYS=y
# CONFIG_P2SB is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_SI5341=y
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_PWM=y
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
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
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

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
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
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
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_TUSB320=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
# CONFIG_IIO_BUFFER_DMAENGINE is not set
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
# CONFIG_ADXL313_I2C is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL355=y
CONFIG_ADXL355_I2C=y
CONFIG_ADXL367=y
CONFIG_ADXL367_I2C=y
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
# CONFIG_BMA180 is not set
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=y
CONFIG_DA311=y
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=y
CONFIG_DMARD10=y
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
# CONFIG_IIO_KX022A_I2C is not set
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7660=y
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
# CONFIG_MSA311 is not set
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD799X=y
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=y
CONFIG_CC10001_ADC=y
CONFIG_DA9150_GPADC=y
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HX711=y
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=y
CONFIG_MAX9611=y
# CONFIG_MCP3422 is not set
CONFIG_MEDIATEK_MT6360_ADC=y
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=y
CONFIG_RICHTEK_RTQ6056=y
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_ADS7924=y
CONFIG_VF610_ADC=y
CONFIG_VIPERBOARD_ADC=y
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_STX104 is not set
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
# CONFIG_AD7150 is not set
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_ATLAS_EZO_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
CONFIG_PMS7003=y
CONFIG_SCD30_CORE=y
CONFIG_SCD30_I2C=y
CONFIG_SCD30_SERIAL=y
# CONFIG_SCD4X is not set
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
# CONFIG_SPS30_I2C is not set
# CONFIG_SPS30_SERIAL is not set
CONFIG_SENSEAIR_SUNRISE_CO2=y
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

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
# CONFIG_AD5380 is not set
# CONFIG_AD5446 is not set
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
# CONFIG_AD5696_I2C is not set
# CONFIG_CIO_DAC is not set
CONFIG_DPOT_DAC=y
CONFIG_DS4424=y
# CONFIG_M62332 is not set
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
CONFIG_TI_DAC5571=y
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
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=y
# CONFIG_HDC100X is not set
# CONFIG_HDC2010 is not set
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BOSCH_BNO055=y
CONFIG_BOSCH_BNO055_SERIAL=y
# CONFIG_BOSCH_BNO055_I2C is not set
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
# CONFIG_KMX61 is not set
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# CONFIG_IIO_ST_LSM9DS0 is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
# CONFIG_ADUX1020 is not set
CONFIG_AL3010=y
CONFIG_AL3320A=y
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_AS73211 is not set
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
CONFIG_CM3605=y
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=y
CONFIG_IQS621_ALS=y
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
CONFIG_LTRF216A=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
CONFIG_NOA1305=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
CONFIG_TSL2591=y
CONFIG_TSL2772=y
CONFIG_TSL4531=y
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
# CONFIG_VCNL4035 is not set
CONFIG_VEML6030=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
CONFIG_AK09911=y
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_TI_TMAG5273=y
CONFIG_YAMAHA_YAS530=y
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
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5432=y
CONFIG_MCP4018=y
CONFIG_MCP4531=y
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_DLHL60D=y
# CONFIG_DPS310 is not set
# CONFIG_HP03 is not set
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
# CONFIG_IIO_ST_PRESS_I2C is not set
CONFIG_T5403=y
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=y
# CONFIG_MB1232 is not set
CONFIG_PING=y
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX_COMMON=y
# CONFIG_SX9310 is not set
CONFIG_SX9324=y
CONFIG_SX9360=y
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
# CONFIG_TMP117 is not set
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
CONFIG_MAX30208=y
# end of Temperature sensors

# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_CRC is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_IQS620A=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_USB_LGM_PHY=y
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_TUSB1210=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

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
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_DEV_DAX_KMEM=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RAVE_SP_EEPROM is not set
CONFIG_NVMEM_RMEM=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=y
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
CONFIG_PECI=y
CONFIG_PECI_CPU=y
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_FUSE_FS is not set
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
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

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
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
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
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
# CONFIG_TRUSTED_KEYS_TPM is not set

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_KEY_NOTIFICATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
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
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
CONFIG_INIT_STACK_NONE=y
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
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set
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
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_ARIA=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
# CONFIG_CRYPTO_TWOFISH is not set
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_KEYWRAP=y
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
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set
# CONFIG_CRYPTO_ESSIV is not set
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
# CONFIG_CRYPTO_BLAKE2B is not set
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
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
# CONFIG_CRYPTO_VMAC is not set
CONFIG_CRYPTO_WP512=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_XXHASH is not set
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
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y
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
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
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
CONFIG_CORDIC=y
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
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
# CONFIG_CRC64_ROCKSOFT is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
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
CONFIG_ARCH_HAS_PMEM_API=y
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
CONFIG_DYNAMIC_DEBUG_CORE=y
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
CONFIG_PAHOLE_HAS_BTF_TAG=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_FRAME_POINTER=y
CONFIG_OBJTOOL=y
CONFIG_STACK_VALIDATION=y
# CONFIG_VMLINUX_MAP is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
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
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
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
CONFIG_PAGE_TABLE_CHECK=y
# CONFIG_PAGE_TABLE_CHECK_ENFORCED is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_TEST is not set
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SHRINKER_DEBUG=y
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
CONFIG_HAVE_KMSAN_COMPILER=y
CONFIG_KMSAN=y
CONFIG_HAVE_KMSAN_PARAM_RETVAL=y
CONFIG_KMSAN_CHECK_PARAM_RETVAL=y
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
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
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
CONFIG_DEBUG_PREEMPT=y

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
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
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
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
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
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_OBJTOOL=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
CONFIG_TRACEPOINT_BENCHMARK=y
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_FTRACE_RECORD_RECURSION=y
CONFIG_FTRACE_RECORD_RECURSION_SIZE=128
CONFIG_RING_BUFFER_RECORD_RECURSION=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
CONFIG_RV=y
# CONFIG_RV_MON_WIP is not set
# CONFIG_RV_MON_WWNR is not set
# CONFIG_RV_REACTORS is not set
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
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
# CONFIG_KCOV_ENABLE_COMPARISONS is not set
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
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
# CONFIG_MEMTEST is not set
CONFIG_HYPERV_TESTING=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--nyckAaS2Scl5ZOTi
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys=
	export queue='vip'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linus/master'
	export commit='47ebd0310e89c087f56e58c103c44b72a2f6b216'
	export kconfig='x86_64-randconfig-a016-20230606'
	export nr_vm=300
	export submit_id='6481883f0b9a933882db41f7'
	export job_file='/lkp/jobs/scheduled/vm-meta-266/boot-1-yocto-x86_64-minimal-20190520.cgz-47ebd0310e89c087f56e58c103c44b72a2f6b216-20230608-80002-1q3p7ns-2.yaml'
	export id='5522bc0ab3638d0fbf06851f5e244865e56a7a40'
	export queuer_version='/lkp/xsang/.src-20230608-090058'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='yocto-x86_64-minimal-20190520.cgz'
	export compiler='clang-15'
	export enqueue_time='2023-06-08 15:50:23 +0800'
	export _id='648188410b9a933882db41f9'
	export _rt='/result/boot/1/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-a016-20230606/clang-15/47ebd0310e89c087f56e58c103c44b72a2f6b216'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-a016-20230606/clang-15/47ebd0310e89c087f56e58c103c44b72a2f6b216/0'
	export scheduler_version='/lkp/lkp/.src-20230606-135444'
	export arch='x86_64'
	export max_uptime=600
	export initrd='/osimage/yocto/yocto-x86_64-minimal-20190520.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-a016-20230606/clang-15/47ebd0310e89c087f56e58c103c44b72a2f6b216/0
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a016-20230606/clang-15/47ebd0310e89c087f56e58c103c44b72a2f6b216/vmlinuz-6.3.0-rc4-00044-g47ebd0310e89
branch=linus/master
job=/lkp/jobs/scheduled/vm-meta-266/boot-1-yocto-x86_64-minimal-20190520.cgz-47ebd0310e89c087f56e58c103c44b72a2f6b216-20230608-80002-1q3p7ns-2.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a016-20230606
commit=47ebd0310e89c087f56e58c103c44b72a2f6b216
initcall_debug
nmi_watchdog=0
vmalloc=256M initramfs_async=0 page_owner=on
max_uptime=600
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
	export modules_initrd='/pkg/linux/x86_64-randconfig-a016-20230606/clang-15/47ebd0310e89c087f56e58c103c44b72a2f6b216/modules.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export meta_host='vm-meta-266'
	export kernel='/pkg/linux/x86_64-randconfig-a016-20230606/clang-15/47ebd0310e89c087f56e58c103c44b72a2f6b216/vmlinuz-6.3.0-rc4-00044-g47ebd0310e89'
	export dequeue_time='2023-06-08 17:14:16 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-266/boot-1-yocto-x86_64-minimal-20190520.cgz-47ebd0310e89c087f56e58c103c44b72a2f6b216-20230608-80002-1q3p7ns-2.cgz'

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

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--nyckAaS2Scl5ZOTi
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
4jb6vAABjie3qQEA7HMZ27HEZ/sCAAAAAARZWg==

--nyckAaS2Scl5ZOTi
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg-parent-a101482421.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4J93HrhdADKYSqt8kKSEWvAZo7Ydv/tz/AJuxJZ5vBF3
0b/zsUFOhv9TudZULcPnnyAaraV0UdmWBL/0Qq2x8RyxDtkd8eDlFp664TyRWk15adeeFsGoNV0C
FcUhdzRTXPevHYdBXHtkvLU4uQuqw4Lkgtnw0HF7R+seY9BbSfh27GQeJVuRoY0odyQDKfQeCYk7
JQ1qfSYnKyyjQbuGAb6vln2HedjmlPlQ+lteVpoBZrzWhb7mBx2W3d2Ub4KcUlbPnDhzY382z47E
0f7l7WbBv0QpXDAxAJzgjztKPusmbdxrJP+8HNsJzQN9xIMi/dpLkK5/2gPXR3bxK2AGoaQfzLLC
6Ff6PTJ74EO2mSQTYshn2PPMT+VR+ZpxtDg00mq3WidFcfZslc7l873A+QqO+mAlwv6FHKA3YIkQ
qgaDvSZGo8dU4JVXJWtApKdDXHc+j3tpu/2V90qws9K0rJAd2YkrxZtNV/KTovqam3ZBOdDhT3c+
lA/rosrkf+W+1Hr3COKdqP4NbrMAbeJTKFXT77FSxUhFHoZSsCyYtKIxdhlMXgN2CSpjmfe6GkkG
XPB2w3kJ+Ou8EyaQu6kNObKp56snqPi28u1dsp46Jo6Z1XYxnrs2TeS/2XuOZ6Ca8i4SwecW2hBW
hkSM/Cd85UzC+SsYjymeap4NaqeY1q8ICM67ancmEVCbG0Hti+oh6Z2OKNuFuGa++U0Xthayezwn
1a0OF9QK/88LEQwP7GgRSN1odRaoymT3pNXzacYidbE+IlTzWyfaKoTTAcyqdxf12wmLh3HTN7QP
JSWeH15Q4iKLqQJC/iPbkAqjwzi3jI3pQ1B9cSmhvWujoloilyarXGD4Jwk3zq/Iqx5StQ+KaL7N
XB0pRWptFlPTD542tb2Cszo+Df+x8QqPf9OuQfafWBdGpzMnP0hS2JEr6dl36VuSFvTnTQ5H5QpK
yiIse5Kn0mcif1OEZmQz1O5BuGzQHi2ANu99B7Pee9Ubod4hMqcs7ICghvPUP8sho61plJ8iwRQJ
T6jYfi7WhYMFlUYPWKTRO43qAbgJLm/9cYcbRuYYR7U0Azbify0/i6U1J2lrmdnmHHrLbcFeK7Nu
0DAn0r8fcQdyyc1vJoPxX5Z/LRG+Ze/zRq1oa+hptiPYxyeplDY7pnFUUBpb9xyuQbqXc67Jtd/z
496eKod7BxrHFjL5cXrnzRLwxTYOPBU2msrGcZaIDfpo6Jmd3ttXH/sE8iMoUpNd74w7GuCpk412
JkAV+oMldOxa080xyc51ZcIzG0aiiK1iXjGIQ3wn9+mfCsRJKk3uLGhEudQAQbRRFcoZF0K557x5
JUV0Z+6YOUpklImYWnXafJNlLK5MuO7g1vqFYayxq0ozWfGlfF5DTuhbhYexLlIqACK4snfPF6Cs
PwFJ0V5E3yV65cjgFhrYT8idCUYXyMTy4pCmY1E7s6BrW5WxcCNpkmEeG9yOonj3v+7OmvQ2RWly
k2mRv8YzEs7rGKEiJ0v6JEeowz0FzW9eLwil7scKEsoXBpEzD1u2IC3Vb90D9oX75C6Mp2p14M+3
maK0ysjXbQM0zFtKV1J3KMu++GMsPnxWsOwMI9NIvC1h+7up5F3MzAFPFQnRRUt3A4YyIYtQe7MY
D9ktL52coWzvT4jeeWp8hywib+9JFnwAVR3MVU47nFABykVyzDILan2c9tk9jDCgfSh+cVNaDnqv
Tmh6UCZw9TOK0kYtbHD+ruL7EtQmNaHcfES8sSJaMbMeBjrnAsFuDzigHvUFk5xlN7/prHLVigCH
KzPovwQXcBrMlJ4zGPCNn+JiVgeiuobafFr0h3+7ORyU6dnUIpbXhzEAfMUQNtyqRPAT9OS6GqfS
F6QDP8ujClnQqiTh+Yn6xbFn2my+Fg4pkCOz6NmzuNwip4YmzbGtXBXqIMzXgPV9X/vI9Nip0VnZ
TWPEqv5IsM87gzns733c6l+C+cY+ijD6sH9f8UUYRspC8loUSMUyET74JKIfho4794NVDr5OnCsQ
zRU8kG9IQRzAtuxeEek23eWYuqasR0Emz2lVbt5vJHdnUUB7oT50V3SOsxI12T1gUskSyFf0LwXs
SoWi1YP2amS14zTvr8kcVJRgvis8kr5NfaUWZMF4Gvqlbk3eFnLmlEtYLrty45FOJVfXM1jhFC1W
g1u1+QelKmD9vluqJCr8QWlPhPHgqXh9xNr7bwWy+vsW3y3bSGTvM6zXmTBVt67exBsBCZ7Us9L6
g62V68DuKGl7OQNWcGCeCQKBZfnZy0quK4a1by4ySkR3WuySr+1v7ULneOTL065jfdjPahHgUTRp
EYh7ClKvA1gMXFJuUjCsiemXrB1inZL2dLGOrKPkzkLZ/x7zebxMO4JkIqjITNCI62ei38X4AxZt
ilGzQy3sLjDX39iABEfhHGt8U/X6gAB0EpBIfR/wZLSG1kUFdwX+9sl2+YBFX/yETnjz5JJld7Z8
wZtObhE7NK8Fg/reTSnXhrccMtj2OAPdIrlwZ81Qbs7VC8WwoApZX4vQSZm700j8/l4JTMqqgutF
Pu/mD80GlUi4LXMhU7c3tRcCen8T1x651MK9rZghVkZtCJ3wXJT8wQI1KMC/Q+EmBY7jL+cCKIgV
qhlK1cHEJalrD4R69lmgidEznMeULICkIWm/PrGX4OFlvFXbDCdUo+Ivc02jKZIqKLyKEnJdKU0N
khGxiR+Stc91KhR7OPiBgFDz26rbUlEVLpT4hDhVlQv5g8F6+6JEGhXsZ0Ag09WpvpL7AYkRdfNp
TD9/U6Fr2fNMgriy5Imu12cTlsZD7B3HMEzdJrhlUbag9ssK52PP9NAnvbEPkoHIoP2S4M60wXms
plH6nmckfSeYXS2xBRSwpCxc8zPW7AaPd60SjXhdDiS0op4c3H5PkvCyBmFr3ZGl+EKBDMfVBtsu
yA0Q1vSodzkI305w4V4pUnq4AbJQ3nCQMcfU+2M+ol7qV7dCt0TS6i6AhBRGrE3mFHvObQ8Cmba4
0nh1fHG9+0UncbXgDQUlO7rn11hfSmXob49e5SthPdbLan3uBBhjTYsV8BczotfwH2D95Cp+K0N4
rN//CG7uWSs4yiQKcFbDo5A5xcQsOwNh2KqpF1AxgGUES374tvO4ZA3ujtzpWj7KdKufC8O4frwe
Zj18GTfLASc935XLKzPZIf6m8rNg6pyzfnssWy8L5V2Jdo+P/wnNVeOLYalv7Wq7xCZEfjb8iB0m
6mx2OdZ6gHBS3bFWMvEuZLkFfMo2n+W33liDu8Kvqa3o67v+KhWvdsijJxtlTsvfIRu/8NpDs7dk
eq3mBAxh4fd1U6UlBJuMsj8s2wS9o2wij1TCMWhTLGz5W2Uh3g4tk7H84gjwa7uT8vMDOnccUvmC
NtQM8R8NYoe6gbs0IwACimOaXP5sUwKBVuji2+72NpL+Mxxbx3ss46nE4mnoS2F3VA9iuGTrSOuN
+qW255IRCE9AqCDuR7e9MOX4waBSkTWEOg/mI9ZKFxeLHZHhcIgloiGs9xWSfi39EwIOsI6CkzQu
186/Af6l40iePzEg7S7aVakyrUg6jEg35GYJkbf6xlBrabL0+QBsrlCYnKRF7wGdrOvyADoJjPYS
9MDvoYkzNZ6aWQvFmyilI1sNh+zPVIKLBOuHq3kesjhBriWZdlAcGO8W1O40B5kD+ssTbcq0Voh3
wzSrTdyhzpKCqSYeAR0ELE3riFSnk349W0Y/to4QBYftrXSvUvFa+USBZGsL4MDo6ityBKw2CUF7
o/ckbZv7f0MwjVrc6OKxzDRD5R8Tj32cRexo+LNOnjqSflpQoCWu2Hp6AhyUAtxjHrC2MBNokrZ7
UwJOKPWe3dIR7RHp07eQvqDvVOrykoVxjE4/tiUL6ilbzlAnoXZUrq8MXdKn3Zitw+Y5wXtNjVMY
PzMMYYDJyu1poW59LcBalY7PGwLVCzrIeu6Xr5cNmskEmn7tgBG92hEdJSTYI+SLdxYXgywXdliZ
umMgVUkta9yqz3izmMF0B++wyeKzzTleklTUjzcyTX6I/I1x4Mag1RbjVWbxXOqgOv2yXpFnP0GB
JY6gkX+3G7HTl2hDJ+sU0OfdNiPfkSkEmd0c+a3WCWcfowzNIc+vJQd0A8EWS6E/g00tbo1iGhFQ
CsE2cyTLHACQpluXcXb2nM6w6o7BAvKXK2VZXhRzFqS7hT+opgQAK5QpCM50HYhf++8430OPpfWV
9mMB2F+vZdh3PfL0KlKWl+RMG4ZglJudg9ZKgL/9tkL7X6Qn4PAF4fxW+654TxiGvhTMrf++2BIC
HNlHe1/Efy4woHI3j/ZBcwUl8LpNInHJMjN1cH4mA/B6cvqVxSDOdvDDomIhvgwBO46Ai99CedYu
A0kxkWNZSV8V1cNHkZb83fRqEC/aNw5wY/asBz2IPoz7mh7QmFdLq2NYjPAYznR+iKcPsqKtfbc7
k2oU/dlaVJghtflSdEnScUNiCGyoWk2i2fwtZa9vxMfxkLr2qDEjPrQBBJc2cDfCGgdhGXmAyTpK
Et0O+jX1Z4B/zysmH2WhINORkRkQwqhHDE/EI6QP+OacnyhhD4fBJnj1bY2s4frJULuNgr1RCDm7
9DikfFFoWZPbgEbdJ5zthvKRHHPpbdczeW62bnYFcGkgWenu+Ss2UY5Q3OHP9ibkF2gEZtZdSXbs
P9GTzISxm1O/Mum13eltuRxy3aSRL1tjGMeVrFklc9q2kikLyebDzOtlUfhWn7+84teVP/petm+R
C2ZNPs2KefwjYo4hRSpUVYBIZf2oBRHUNFltdwMHUdaqQbLy6Md07dLVn/bFQ3MNy4vNUmLwN5Sc
fm+I7YTmcTiZxzIRAfTJiGC3GY4k9YCMye8Pbmwi73ASLuxnfFjo5wR3O1arVDGy77MnlFIMuJnE
1/WrmMdC8pZZKSuu0X9EJqv6ctT0FvAoSwyPuLObfWCVSGckDXkVVB67sFBhH3kDiyFJYzkaE+U7
0mBwh9sNs8KYtMY5wKEwTnUTgFPXS3srhWZQhDGZs9a8rvjXfOREVUHJRmKUga8xZvNmhVRszxKX
/kuq9hFCzDPREmLr4Xa31HBbVE30gNzhnh0jhGDw9fpmYLUccBtPzpfEcw+XHIDaHYfJD1U7frf2
WP6Nh5pWLTl8y3Uk2/8i6RO+0tZkw1Sd1mj2ECKGdXxj7cjekbbrF3hSNIqxdZUFnDgR6sd+508y
yU2Qg7Dr9JM+g/fSrKYDO183emCcXSUB0MRzGmr6Mf0ot1ltMzzbAaoxBOogCS8hQWj8HKvju5Ix
KYzbD57yZ8vL2klrZFJCmR6+NuiTckKZQZUowFet8KkAYI6F12i/49sRj79BBkuAHPzSx4W68PRf
d5DEnNbiit68vKkxmBMN4R9PItXACouk0g6MyV/WpnirAGSJO2TZCfCz9ASp91xMp15RO4V+6x5v
WARND8mt03Smg73GY1PF5ALELHQCpl4Y51owu4VMx/ZjIWJ2tYovrO9R3+KHDl3SRHugLAwszMre
a4AoE90qZ2qdXx34EnlDILupozyCgZNpOFSpcZh3Iv8nCeB/F20wyi9rzYd9CDBeYWy0CKAKhn/k
X6hqWqGMkM+EN0DYKA2pnDGM14pAH/b7uEqIGsDhZmCmZyYQyb35FuHZVW5zDX9+ee/WDi7nCcFU
XrPyqAdpBOZAXj6H6o++7OrN8UESJLtBcoHHU/eZJhAdj04g0MYP15yEUb3WiUZDhKMiZEDbgbzs
RMX5L+mJU8OLrzNimb2VHAqsrWGqsCN63eeNdjeNwMOt4pBYfUmGyiB0zHVFe5oJSGrANVUcSLIU
HWrwTynNUntzRuiuJHqgwrn3WndR9Y5wpPC+1YPkANymC8QGYPfnPye8EDL4Aes3YGV5fyJOC2q+
NsRyK3KY4E76X35rHWAyB/JsqoHusHRFFcyGO0EA27o7VKTtYv3Ht4toiPXaQCNRja0BzxCsTBrd
BM4jgVnGi+GWV4mE/EcesOFm5iboQcFIRY7BULvKEmPdpv9jDepb9sQXU7fS7+YXhk/htgvke5QZ
SOD1L4eV7j2WPLenVa+ShqDKSGyYMRyNwU6nnHen26d77QLPoU6OmZ/Rtvi0KIy8kfaOZeGsOHHq
qhtH/81F4QZ55WC3EsQafukCKFq2HiUQnQVGvIkhHYAuG8lWVx3ngw9PCI3kGTKDfP8Zsm7ZuWOh
/Av8HbrYlWsVvH3fLs2XsUTYSuINUnYJ6TLcG0rVNA4UAgZ3U6vgdD7zqON53OxlNEpZSlsVGM6T
pgnNVqUFj0E46hog+A5IR53dc2MfWbWmfP8F1U/N6XlJtx4JfLsH/cYkMd58CHXicTP/6/KE8LGc
kdjHWK3v8mL4o0JaEmKWLcsw5u36yXS16gObSGlzCdj3ANn2WjalPEvZ1mNDu9c6Ecmmr6hPplBl
coycB2uRxq/yOydldsgEmCaek9+1UVbYzK1ag8u659tATWV3ShwPSyMkae7jsPBoRD1BmIw2xPdx
bflc34W1CFat7ZPBV31mT0KDPHbvxSWW/FjkimzoJU24hXnMH38SpVYTLNwHLrR+LkqcOVK9V/WX
LUJ9nXOZLS3K6PLYLasrXxxNh3YtUxVijwN4ADDxd1vXmVlrUpEIyJ1smYcsZI8LzqvMF/IUKuzi
CbpWjiAjU0FJVhich0XhgHerlwOEh+bIFcVXltG8951iqBRra8HjdQfHH3dFrGvU869BUGWuWblT
ZkGB/LfYTxN95sXkehfXjpFJFqzXRGgEdKV4j2uX5KyHWCVI02ZpgV/Kd0uSYZDOo8gBLkuISsH6
3firHSR7RB/UeZPt1HEwMaAv7136xdwVMfvdGX4tJ9+zMji6KmnDQ9iTbtgzGeexlOnoQUZzRpsI
9aqkUVY1xjgy12EoxGsrImKX7hwWhx0x7X1rk2nWirL/6oPWBDOMo4yO3i6njjt807ClDIYpTPzD
zggacqR88P7fcr2SFDaQchiFAutUo/hQOBpMCaB7hIs2h4MZhvG4ozMD0pnPu5hKWObjlwjm+Ozt
pzwR1Z/qVi9wt0g6D4LSEn/BRBz4gIJ+CVqgFgRJrjQ3JOSfag4/JPGw8wCtLqbrEfUumubN1Tvy
zvTGMc2dpUamMGOv6XmOjbiXGuhoXKiMH/hvhzP7uIM9oGwKGiZWo8PTc31Drez4ivHV3u7CyB6u
w9F7Ni+lA/WtR5NdPyvjObZRFQutfnM38Wx/fZUNLB7SMAZaBICvct7Tym7efPaEWt0HX1vJvtiI
oLBJRaqFN/v06s/rM79i88YHScrjLegcZtlBnNCbjgeLQtk8a1vjKg/6nq0E8BqEi34UTEbj2XJ/
FqiAFh3f6Xh91o40zf0TdEGrUFUUbb2IncOn8I3lgDScUm+5p+1JaF3ebIV2Ts1PKBBXFUoPYlCM
HPjClxU8kg4lG8X7+0KpbLdxG92+llZE9OWXAfIEJ7EMjB2ajGzyNgJ1xao5oMCp+7ohNhdRAjoi
Y+6k6OBPcoGf267LwXxA9YIiqocQr7i463HIKekmvcoWsKoiyF9dXLBG1jDEwni0DkcTnHv9b9t0
hjLRN0Nsd8mzNrPdvkvQf8Eu1CIcX5b4ThlB6AbWAmaKK0Y/oLkcqpE5E+E4ao5SHeSQ4CciL9b5
+E/EFYUNnn31GFiEDrScuqyUWevJkXssUzO/yfsRAIbZCdwyqTWnIKsX0OSg7W+/tOh4yH71SkWk
rKcVNIEEi6Ku+bZXOQCubPwvpBB//un12CoM4XPD30OR61dkNa2/+Bz5bVWntBeJvKhSvb6Ytb+g
WZ/ldY041AE1AzV5qFqv7TaP8R1SBXR0abDb4CfJfeydXA7OmG98sLPkJgbFAHFZFGzurL9bEjZa
ck2acz5gTU1AzQRmEl47ysd9vtWDv91TqvOS+AcuM6zbtgKKBwNW0zfbTGIH4Ih+GAtLO/jl7I2P
zvOyGmFl/iwgk1ladKL3mJovyJfptVLNmKqcz9ewA5GfkWdRzmwsezZxwqD+gQoblE4oo/YdbPBB
JmsIQSWNv9G99bkrZ4YOzrlH2oljeZsxJvN5J9tBA613pRZxFptpcFs1kQeyaHNrcuyJ0HzvaRGu
bIoIrXp8NiXaTZRUsDHrOmpuBKaGeVRBmzjAq1hDN7Ff2D64mlutcQonhbBtsjLsbtt2aPzkquJU
LvQ+nEPoKCePKIGiMB363gx2/IPIe8Lg7F1uaGerN1YGlgCFIr6m5gp4P1i+K98cOvvLX5IF9I5z
USwP9MTs00wWpqo0MKLy6lINhr3NQVsc1onQJmBrEhjBh4YnqXOidqETo67pwRqlNit7FxdkbWRG
xuLEFyQeO79ur5ilzW/myBd3cYumwp3CwsusNLxsPhptjVGhBWXxCHcW0tLeRjqosnyZSCeaIKXI
MRTElprO3AGKL6ooYThVCcX8JHVIcC0wDqD9VfRHZiBVT0yLW6hk/DUw1/+0Pj474BP+PxylY9G2
8lCJcPCKcBfNWSwJOiKG+8q8Q3BhreKOKRMsWWjIaCPqodxmwuP95yZrjdbbSSvvXA1rUQlHkKai
KeutcDI40jWsjRj0iFQHRSUK/sxIztGfIhFAckRvWmEih/Q6K03KKZvszL/Tng9G+TTzvtJfXqa3
DVX7HRRTATVO8yBLv7vPtgnUZ5UJzbnPZQBeEAPnKJbCKYTo0uIBJnGuho+TB6RRXGzCB7Yt8oB1
42ZCMBh//N31mCF2xieQRlcFm5R0MlXD7Gx2bRjsTzPHTGPAvsniNpwxc27A9gWsJwmFSJgAWrTG
+677Ann0l5N+RvYKNgGMw6dIWeOLsOjvAlBPD9Zrrf7pdiCI5LvoREaquLxUOlOA4vNheUkd1zuk
2QiptoP2ihUAyV5jtlc/p/uZ2IUtVp7vBlSTjEDBS1q1qqFO4DsAHJE7Y/xFPfRlh7fvi3SyWvfF
uOPO0YEkLEUdpogMOLmfim97/Ohmy/u60tJ4YDM1dbI04vkPLxq8ImQ+FhY+Gh4dDsLQAktkWS8y
Vx9bTjMWYrL5Z1czYGS711AXoABTCXiPTLLkl4Cc5u3O36Lkmd2fEVSweSRluqDxlKpl4fcV5MEa
f/9YvpQYChhYkJQLqOteyQ8aKFWL5JElj0xSxf5O0SuEKCgPZUDBlIbbZLG2CaIO26PaU9MoK/yV
UXT8qyHa+XJM6ZpWuBHEO4jobBdkL7wBNefPY452mWpD5+5QzXv0Pf2bGBaO5JCd0sv6KVmUAUZY
TEPcSPkM//iKupsf9cFHHZCcf2tmVQ4MdR362cAAzEcMUnoAusCTaKOYTBi1LCqZq7ga9axAcIy7
BjblQasVdFcTrTuLZcY93c3mYoGnAuW7IBxWzsegWQ9VZwnUYYmgYr6qTNRZxoT6dF4+Ji8C0L9y
/vcx66QNmaI86oICLEnOwSf0iJc0E6eZ+sPZCWR1JZG588HaLUYuFRYV3c7KoQHI1BzM0Ik8U5YQ
syZVYohO1+8QzpHRefSvm6VCNf18ZcnfUuteira9CESuhDPH7VfGR9KDW7dxME/BJXMp/lL6M0RO
IwN6Luhkcckm6VSH35o36aWXVVfP4QafTy0ztRHiNx//okbs1M2v5JrYgPw9ED8vLPfVW0M0KML7
6ZOHs15YO3RqECGAnJpbhpCwiTgAb68PDiLWfw19wErtOUbD2l6ewwn12D/e0BdnKhAM6rUIJaaO
c9SFPgYPRZ39rTTfmqSi3RniDzUiFea0P6zYUox3JdYcXsA/KlpYnjPLxgxwyKXq8o8K6OyvLC+9
OURJYzIECcaZDGXQt8tNzIox9i0R1s8PRGaATEqvHlyWbRRFgtGsoQEOpC/59mfQCuxu468giYib
TTwMkFsoO2ogyn3QxxnDuJwhHPqdM8FFuITYpkQV1xQoawcPhkgKYfNz1idcZXuphZbggWMxCdmI
4O64b2JCNRh4SA5myNlXOIIkSS/ginjbs27udjx87NOz2LKeHrEMgKHMMuXPCueAHHZeMUEuKXr3
UH1suC9idORO9o6LbFtmVoSJiPZ/cHzYmztH8jIvdxfmrp8wBCi40nFnVRdqT5MxEUeaSGVxxtCv
pD3omIpAv72N46zc0si9aC1xjDEJj5JBSliqIOOCtG+XFlcm+RpPCjg7FRc7wIIkqqrz0reZeiau
UXbIT+4HxEa2TQdV69baBIjC+ioa1jrINSjxdYtAeJdh1pKFNvG3nDm+ghVg7jDMWcyJV1wYS1sn
S8YkBULiHcdbkWGn7qVK7nrtJ2j+J+RucqyVmwMuYfsld2Am+it9mPwPyMscFccyUiXbKg4Zdyqt
RILDkQv5Gt9KiZus7vp/8q8aZWHJ9RNF1Rzz+iS+lLwxjEtzhfNCEZKNJoqR5jYNMaLZSFXnoxjO
L/oH12VfVQUE7HiZt/NkPqtQg0bnhaP9suBintfvXnG15e8M8LG5rA2yHHHqhtxzvUG9zQ8P1VKS
dq84wLm9344Nq6rAWkhRCuU2rmloK7ARllgN34AASSGH++2fd+kAAdQ9+L4CAAN5b62xxGf7AgAA
AAAEWVo=

--nyckAaS2Scl5ZOTi--
