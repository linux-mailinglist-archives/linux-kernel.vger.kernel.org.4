Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E98D6A5B11
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjB1OtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1OtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:49:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF1ACC3D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677595749; x=1709131749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e+g6GTuATFMg1GxyeF33PIy3v1j90/JsCrbAJpR6xcI=;
  b=ddYqBYPI0DndFniSCegtpdPjO2FC/B1uV4c5Q3j5mN6iq6BpFAwFFlNS
   hzmPoXpQoh9NMW26rtOSFqApliJ/zPI8tF+c9mGyl4aoVuxoNr49bjrtx
   OUjq0sVx/KeZzvhDqg+NmQIzymp6nlckVVP+L5xCm3D1cyRWvJ8kn4AOU
   kLq/YU4gRjAfD8LMXuG86mm0M1COr2y1Lwn7ejpnFOIvLXJELgVkdVlPe
   sS4ufFSQPc7opXFCdLKufOk7dXZsXZ+jM1M61W1nJwOFzv12GvKsI4p6B
   pWpfAxR/p0nXSdeirTaK6Ur+ginV07FFaqcRZ1mIOSknZSiHsHyC8Adap
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="398930280"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="xz'341?scan'341,208,341";a="398930280"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 06:49:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="674170337"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="xz'341?scan'341,208,341";a="674170337"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 28 Feb 2023 06:49:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 06:49:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 06:49:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 06:49:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipC6BmkKCaScxGclW4StUmzLjz7J0yjjhjHHWxRoyy9/ZaEkv8s8ZaCCNkWZStBTsYvg8+xB1GZ4L9BtU9IeHFWRSmJFNBVuEsG6THG2c74q7F7jOj94mDNiN7+AqY+d6JIBLbLneC0S5fiQShmA0mah9qDer+CoZJgcBXQmoqYXh1OMUEbXcKev8NDCUojltITd2aXNHN2gPE+MRT4tOBF/JUu8jme7K1gCFn8dUfaB3bfCaU8ZgwKWcDJQcdrUkam7Ja9aAfhR+QT7fDdJ+ue4BMSuSTh3GI9mt4p34MmnocCBYLR7LCU/Nnz0+DhhivXaEQt+YaayuWhIckV6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1cCy3loqkXr4SwiQKIfanRNLAe8hXg7QEDF91BMX98=;
 b=nSYbamovwxJx4Ge7hUWXIGED597NeBXSmzcjruAvoxpenk8JBacPf/ZfSZZkPXtw4crR1zPuAFc9Ob+5qDbwzSeaby/3ofmFv6NnLT2PMFcWWylOdwlhqC4UdhEdAMIEUm+CRTGKmTA/gMdI5nnRJRG75Xm2PzW3xOCo8JkCr5kMKD96otKMvrzOASno5c2ws5/xDYlAVamBGLudwxzeeX60fWz/k7oy7Xz4U/DEJB6MefaJxCgBYuoV+HMPlsjKLwnJi5DqxTQSJgThRBZBLeHJ3VwayeE817gjFiHoEeyr2b6t7lEP+CPcgwtHMd7BmL9XbfK++jekaXm4wvlJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB7712.namprd11.prod.outlook.com (2603:10b6:510:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 14:48:56 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e783:1ee2:e6e2:e1e4%7]) with mapi id 15.20.6134.028; Tue, 28 Feb 2023
 14:48:56 +0000
Date:   Tue, 28 Feb 2023 22:48:44 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        <kasan-dev@googlegroups.com>
Subject: [linus:master] [entry, kasan, x86]  69d4c0d321:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <202302282133.fb3644d4-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="CxYnWoSba6GjFw2I"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::28) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e98d13-1ea8-495b-4425-08db199aeaa4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBDs+3xR1/CJWOWEc3oY1pEKCIIKgXO40zhjY0FQ2HMXLaVIfsf3Gxi0P3V0qarf789Xrt+msss1MiDeyLYkHGCXsTEIOHTUgb39QivkwAEUk1rH7eeng08MTn4GSVIpbuNnN6bwaRqe0womnL5+JIGc8UB7Pam64Q4d0DVhYoJ59YOMnvrEpe3lUxGR7DaRfTNIzXjzsHdhR0TmRSPg/gSodAeLOitfdmb1RKSDTDdUqDSO5TgH6NbylmSPs6F9lFhEDUdrTNUnTJLlFLt8pzz2uYDr0qCdtOty3lSD3outca8/uuzHfQxHi0VF5ODMUJQXiXLL1jKBQb+/opwYwktn0psy6dhPOtcwibn5GsqqurjJ3/Awo8Ey4l8ywTek+q2TJh3DFcndVk5DVll/BFMRDRIMqa/iajCh3k66za2ILheEterL8Cfw0sO5vI+WjiUS497rNoyGKULCIfnbYdZ/vsdgPvZwioQBmDpXdzWnXO+1uS8kHKwEgd7D9f4GnIcM4a6RdN1d88PehMH4RL4o7w8Q7Zigdu+Mj/wMzVuz1+qyd5dSmaofeVAvJn6bey0LtqsaNflqQBvUumxYVZuaQkGeZM/bmrsX0RDNOK7K5shXPF5k6ym5MXFaKVkgXuUuUKEQV8ei0DvjGglGctfQ9S9K36cAurhjYssc88yPWLMbzSvkyhzuBI82Ymqhdl4gNuh395MdnJiKD0qi1Q1FP0hYuRlnI7Z5vDEbyS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199018)(82960400001)(38100700002)(4326008)(36756003)(86362001)(2906002)(66946007)(66556008)(66476007)(41300700001)(6916009)(8676002)(5660300002)(235185007)(8936002)(2616005)(44144004)(6506007)(1076003)(6512007)(26005)(186003)(83380400001)(45080400002)(54906003)(478600001)(316002)(6666004)(6486002)(966005)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZEx10cjb+SLgtF5JNk1EXO0VOyIAEtC3UJnKmQ969NpTLGfLPI5BEy4bVwxz?=
 =?us-ascii?Q?IVP7mRnKoCVGLJTvBGMylsporkoloPN4eU5iY/vxkxJ4TqMpXzC2Rd+xLTO9?=
 =?us-ascii?Q?lAXu6/fnIb/FkEpCO6EPuYm6gT+Sckl+NVB9Zwqp72RA/hanAaYxJ59cIgLB?=
 =?us-ascii?Q?Py4NqXuxVATXS2j7I5OnXu1Dgc0CemssiCzsLyx7CXTRVzeUAN0vLmcKy6WD?=
 =?us-ascii?Q?0IYZ2eqltYE/K2iEp2sHM1T7sbpsC2kNLfusgwsM3IJ+OpCac5/b+9Jx0q/k?=
 =?us-ascii?Q?9RgwTw2IUPt/0Qo+54BhPEmxlqc7iyGKvIRHjn7WACEUltGmfZxhJmWQqS5i?=
 =?us-ascii?Q?eUhMjz24/JIS7Spra6A+kXBRA5NMUmA1uz46Ex3F+l8pc3vyDwrFq8iRxWAz?=
 =?us-ascii?Q?AybjO4uJlOY76htUxN/2wkf11qR3OrPc1OU1TvuU87xdS8cPAzZm2yGSewbS?=
 =?us-ascii?Q?ANES+eyiFWVVnK8JfllPp0sgrRcHhQif/uAF0c0mxFK2lioN4u+vcuuCfo5V?=
 =?us-ascii?Q?Xyykba+2htR6ExGHSojwP/y+bfDWwzlYv0f+B+uSZQq/1lOhq0HNlveGoa7O?=
 =?us-ascii?Q?qS1JAmkz0w5gImuVJ41476Z+e2CpEr3q1ZrB0UZG6j/Pdko8K2esE8WafqGl?=
 =?us-ascii?Q?Iz3KNsnzZhrpVILYBrBI6He9MXrrvFk04djUx+FtKXQMs+IRf2sR2Vs0+lqH?=
 =?us-ascii?Q?h6ae/lDWIJ4bsq4A0fnZNyV1EQB2FMHsP/EQCWVbqmZb9HWzKtBEqY5JhkqE?=
 =?us-ascii?Q?NiAMCJ0YMK+SOG+T7ZGck0YzulZKO8/wro6DGO+bNYokUj/BbJHz6PMEq4Xj?=
 =?us-ascii?Q?52s+Ce5TsgDlFhjWqLOyZKbtnTdSJwN0NBI1o17qEjosRLF0NNnvFt5G2qsU?=
 =?us-ascii?Q?KQC/PVd57LJ157PP3pSrjlVYH+KOc83/GEmXCqclP/Dwl/f53xsy7kpHw7St?=
 =?us-ascii?Q?PDiMTd93aYHHBa8o3n++8mNulO696jlop7lR6Uce5ijCK7X/WzWeeU5edUZS?=
 =?us-ascii?Q?7FI4ZdRURY6sFnr2hrb8k7hFnbT3MQJp/R6O/y7dX38GU8XVPiWWCVcwToWw?=
 =?us-ascii?Q?61Nb9tR/InWN37qnwzHoRUhjpi9NK6qVoiAsH+onFHDFKpmjyMlmXl11/Aci?=
 =?us-ascii?Q?LEdueuLlRuvwPJlSQmkfQZkpNNlgjc9dv5tpG9Cgn/6iAMxTFBKXgF7PvEs0?=
 =?us-ascii?Q?AvWk1oHUjriXkDvrVV+j6eUqSKKG/K9CucC1S8RMb/X88Ic4NGGgLdIiTjc3?=
 =?us-ascii?Q?+AOr1c+86Kh3KOo9Nj6vZh70yAhtkzlUWxLIQhxitVGZPPpehyrO+ivZy92B?=
 =?us-ascii?Q?e+Kw5HZWCJYmCXkt29QrfD8aPDx+U2Oo6Am19Vm3TzWroXXsCNZ3MOMXa+mf?=
 =?us-ascii?Q?STdMwJ7vHH4uKo3vmFMf0aepoAMZ4IYzoMguEwlKlM/biQEA2N0vI3lpE74y?=
 =?us-ascii?Q?RzbgdkgCUoNM0D4JlRlSsDSwNwwotkiXaCVLVoyDchpmGMtYSthe4IhH//m4?=
 =?us-ascii?Q?1cmfUDufX2IlVmlcRIlyXamHf8fuZs6yp8rSItmbw4gazUBvhrUVzx2vvQ0s?=
 =?us-ascii?Q?KPL/mFUDsD0mWcv2myf901Z3k/6B2/x6Kof1yFzf9vqDVw7ZFtOd04ZB1/BL?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e98d13-1ea8-495b-4425-08db199aeaa4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 14:48:56.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eu49Wkjxyf+iKFVyuW9UzlY/b5F22GB3fugKktuY9QCBjuL+0DrH6zpAmFxwmUXSfKItW/L+ECvveXGkkAGteQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7712
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--CxYnWoSba6GjFw2I
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed BUG:unable_to_handle_page_fault_for_address due to commit (built with gcc-11):

commit: 69d4c0d3218692ffa56b0e1b9c76c50c699d7044 ("entry, kasan, x86: Disallow overriding mem*() functions")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master f3a2439f20d918930cc4ae8f76fe1c1afd26958f]
[test failed on linux-next/master 7f7a8831520f12a3cf894b0627641fad33971221]
[test failed on fix 443ed4c302fff6a26af980300463343a7adc9ee8]

in testcase: kunit
version: 
with following parameters:

	group: group-00



on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202302282133.fb3644d4-oliver.sang@intel.com


[   59.712237][  T861] BUG: unable to handle page fault for address: ffff88816c600000
[   59.712481][  T279] sed[279]: segfault at 5a40fe44 ip 0000000056616232 sp 00000000ffae20e0 error 5
[   59.712686][  T861] #PF: supervisor write access in kernel mode
[   59.713265][  T279]  in sed[5660b000+13000]
[   59.713876][  T861] #PF: error_code(0x0003) - permissions violation
[   59.713880][  T861] PGD 8e01067 P4D 8e01067 PUD 8e06067 PMD 16c5a0063 PTE 6c60106380000001
[   59.713893][  T861] Oops: 0003 [#1] SMP KASAN PTI
[   59.714336][  T279]  likely on CPU 0 (core 0, socket 0)
[   59.714650][  T861] CPU: 1 PID: 861 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
[   59.715108][  T279]
[   59.715694][  T861] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[ 59.715700][ T861] RIP: 0010:memmove (??:?) 
[ 59.716046][ T279] Code: 81 83 78 04 00 74 34 90 8b 00 8b 0c 24 8b 54 d8 04 8b 04 d8 83 c3 01 e8 6c ee ff ff 8b 95 d8 02 00 00 8b 8d e4 02 00 00 01 fa <8b> 42 04 8b 04 30 8d 04 40 8d 04 81 39 58 04 77 cd 83 44 24 04 01
All code
========
   0:	81 83 78 04 00 74 34 	addl   $0x8b9034,0x74000478(%rbx)
   7:	90 8b 00 
   a:	8b 0c 24             	mov    (%rsp),%ecx
   d:	8b 54 d8 04          	mov    0x4(%rax,%rbx,8),%edx
  11:	8b 04 d8             	mov    (%rax,%rbx,8),%eax
  14:	83 c3 01             	add    $0x1,%ebx
  17:	e8 6c ee ff ff       	callq  0xffffffffffffee88
  1c:	8b 95 d8 02 00 00    	mov    0x2d8(%rbp),%edx
  22:	8b 8d e4 02 00 00    	mov    0x2e4(%rbp),%ecx
  28:	01 fa                	add    %edi,%edx
  2a:*	8b 42 04             	mov    0x4(%rdx),%eax		<-- trapping instruction
  2d:	8b 04 30             	mov    (%rax,%rsi,1),%eax
  30:	8d 04 40             	lea    (%rax,%rax,2),%eax
  33:	8d 04 81             	lea    (%rcx,%rax,4),%eax
  36:	39 58 04             	cmp    %ebx,0x4(%rax)
  39:	77 cd                	ja     0x8
  3b:	83 44 24 04 01       	addl   $0x1,0x4(%rsp)

Code starting with the faulting instruction
===========================================
   0:	8b 42 04             	mov    0x4(%rdx),%eax
   3:	8b 04 30             	mov    (%rax,%rsi,1),%eax
   6:	8d 04 40             	lea    (%rax,%rax,2),%eax
   9:	8d 04 81             	lea    (%rcx,%rax,4),%eax
   c:	39 58 04             	cmp    %ebx,0x4(%rax)
   f:	77 cd                	ja     0xffffffffffffffde
  11:	83 44 24 04 01       	addl   $0x1,0x4(%rsp)
[ 59.716416][ T861] Code: 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 48 48 83 ea 20 48 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 4c 8b 46 18 48 8d 76 20 <4c> 89 1f 4c 89 57 08 4c 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48
All code
========
   0:	00 48 81             	add    %cl,-0x7f(%rax)
   3:	fa                   	cli    
   4:	a8 02                	test   $0x2,%al
   6:	00 00                	add    %al,(%rax)
   8:	72 05                	jb     0xf
   a:	40 38 fe             	cmp    %dil,%sil
   d:	74 48                	je     0x57
   f:	48 83 ea 20          	sub    $0x20,%rdx
  13:	48 83 ea 20          	sub    $0x20,%rdx
  17:	4c 8b 1e             	mov    (%rsi),%r11
  1a:	4c 8b 56 08          	mov    0x8(%rsi),%r10
  1e:	4c 8b 4e 10          	mov    0x10(%rsi),%r9
  22:	4c 8b 46 18          	mov    0x18(%rsi),%r8
  26:	48 8d 76 20          	lea    0x20(%rsi),%rsi
  2a:*	4c 89 1f             	mov    %r11,(%rdi)		<-- trapping instruction
  2d:	4c 89 57 08          	mov    %r10,0x8(%rdi)
  31:	4c 89 4f 10          	mov    %r9,0x10(%rdi)
  35:	4c 89 47 18          	mov    %r8,0x18(%rdi)
  39:	48 8d 7f 20          	lea    0x20(%rdi),%rdi
  3d:	73 d4                	jae    0x13
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	4c 89 1f             	mov    %r11,(%rdi)
   3:	4c 89 57 08          	mov    %r10,0x8(%rdi)
   7:	4c 89 4f 10          	mov    %r9,0x10(%rdi)
   b:	4c 89 47 18          	mov    %r8,0x18(%rdi)
   f:	48 8d 7f 20          	lea    0x20(%rdi),%rdi
  13:	73 d4                	jae    0xffffffffffffffe9
  15:	48                   	rex.W
[   59.721773][  T861] RSP: 0018:ffff888172517e40 EFLAGS: 00210286
[   59.722266][  T861] RAX: ffff88816b5e3600 RBX: 0000000000000001 RCX: 0000000000000001
[   59.723109][  T861] RDX: fffffffffefe35be RSI: ffff88816c600024 RDI: ffff88816c600000
[   59.723913][  T861] RBP: ffff88816b5e3600 R08: 0000000000000000 R09: 0000000000000000
[   59.724604][  T861] R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1102e4a2fc9
[   59.725236][  T861] R13: ffff88811d3078e8 R14: fffffffffffffffe R15: ffff88811d307900
[   59.725868][  T861] FS:  0000000000000000(0000) GS:ffff8883aec00000(0000) knlGS:0000000000000000
[   59.726595][  T861] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.727123][  T861] CR2: ffff88816c600000 CR3: 00000001bb902000 CR4: 00000000000406e0
[   59.727755][  T861] DR0: ffffffff88998660 DR1: ffffffff88998661 DR2: ffffffff88998663
[   59.728383][  T861] DR3: ffffffff88998665 DR6: 00000000fffe0ff0 DR7: 0000000000000600
[   59.729012][  T861] Call Trace:
[   59.729282][  T861]  <TASK>
[ 59.729524][ T861] kmalloc_memmove_negative_size (kasan_test.c:?) kasan_test
[ 59.730378][ T861] ? __pfx_kmalloc_memmove_negative_size (kasan_test.c:?) kasan_test
[ 59.731298][ T861] ? rcu_read_lock_sched_held (??:?) 
[ 59.731760][ T861] ? trace_irq_enable+0x144/0x1d0 
[ 59.732269][ T861] ? __pfx_kunit_generic_run_threadfn_adapter (try-catch.c:?) 
[ 59.732836][ T861] kunit_try_run_case (test.c:?) 
[ 59.733257][ T861] ? __pfx_kunit_try_run_case (test.c:?) 
[ 59.733718][ T861] ? __pfx_kunit_generic_run_threadfn_adapter (try-catch.c:?) 
[ 59.734280][ T861] kunit_generic_run_threadfn_adapter (try-catch.c:?) 
[ 59.734829][ T861] kthread (kthread.c:?) 
[ 59.735170][ T861] ? __pfx_kthread (kthread.c:?) 
[ 59.735555][ T861] ret_from_fork (??:?) 
[   59.735927][  T861]  </TASK>
[   59.736182][  T861] Modules linked in: kasan_test fat_test test_sort test_list_sort time_test sysctl_test lib_test resource_kunit dev_addr_lists_test memcpy_kunit list_test test_linear_ranges linear_ranges test_hash ext4_inode_test cmdline_kunit test_bits bitfield_kunit drm drm_panel_orientation_quirks
[   59.738340][  T861] CR2: ffff88816c600000
[   59.738698][  T861] ---[ end trace 0000000000000000 ]---
[ 59.739151][ T861] RIP: 0010:memmove (??:?) 
[ 59.739538][ T861] Code: 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 48 48 83 ea 20 48 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 4c 8b 46 18 48 8d 76 20 <4c> 89 1f 4c 89 57 08 4c 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48
All code
========
   0:	00 48 81             	add    %cl,-0x7f(%rax)
   3:	fa                   	cli    
   4:	a8 02                	test   $0x2,%al
   6:	00 00                	add    %al,(%rax)
   8:	72 05                	jb     0xf
   a:	40 38 fe             	cmp    %dil,%sil
   d:	74 48                	je     0x57
   f:	48 83 ea 20          	sub    $0x20,%rdx
  13:	48 83 ea 20          	sub    $0x20,%rdx
  17:	4c 8b 1e             	mov    (%rsi),%r11
  1a:	4c 8b 56 08          	mov    0x8(%rsi),%r10
  1e:	4c 8b 4e 10          	mov    0x10(%rsi),%r9
  22:	4c 8b 46 18          	mov    0x18(%rsi),%r8
  26:	48 8d 76 20          	lea    0x20(%rsi),%rsi
  2a:*	4c 89 1f             	mov    %r11,(%rdi)		<-- trapping instruction
  2d:	4c 89 57 08          	mov    %r10,0x8(%rdi)
  31:	4c 89 4f 10          	mov    %r9,0x10(%rdi)
  35:	4c 89 47 18          	mov    %r8,0x18(%rdi)
  39:	48 8d 7f 20          	lea    0x20(%rdi),%rdi
  3d:	73 d4                	jae    0x13
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	4c 89 1f             	mov    %r11,(%rdi)
   3:	4c 89 57 08          	mov    %r10,0x8(%rdi)
   7:	4c 89 4f 10          	mov    %r9,0x10(%rdi)
   b:	4c 89 47 18          	mov    %r8,0x18(%rdi)
   f:	48 8d 7f 20          	lea    0x20(%rdi),%rdi
  13:	73 d4                	jae    0xffffffffffffffe9
  15:	48                   	rex.W


To reproduce:

        # build kernel
	cd linux
	cp config-6.2.0-rc1-00083-g69d4c0d32186 .config
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



--CxYnWoSba6GjFw2I
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.2.0-rc1-00083-g69d4c0d32186"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.2.0-rc1 Kernel Configuration
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
# CONFIG_WATCH_QUEUE is not set
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
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_TIME_KUNIT_TEST=m
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
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
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
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
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
# CONFIG_FORCE_TASKS_RCU is not set
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
# CONFIG_FORCE_TASKS_TRACE_RCU is not set
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=2
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
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
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
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
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

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
CONFIG_GOLDFISH=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=m
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
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

# CONFIG_X86_16BIT is not set
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
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
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
# CONFIG_MTRR is not set
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
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
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
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
# CONFIG_ACPI_NFIT is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
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
# CONFIG_VMAP_STACK is not set
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
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
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
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
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
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

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_ELF_KUNIT_TEST=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
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
# CONFIG_SLOB_DEPRECATED is not set
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLUB_STATS=y
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
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
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
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
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_PERCPU_STATS=y
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
CONFIG_SKB_EXTENSIONS=y

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
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=y
CONFIG_MPTCP_IPV6=y
CONFIG_MPTCP_KUNIT_TEST=m
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
CONFIG_NET_SELFTESTS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_NETDEV_ADDR_LIST_TEST=m

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
# CONFIG_PCIEAER is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
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
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

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
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=m
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
# CONFIG_MHI_BUS_EP is not set
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
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=y
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=y
CONFIG_NFTL=y
CONFIG_NFTL_RW=y
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_INTELEXT is not set
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
CONFIG_MTD_DATAFLASH_OTP=y
CONFIG_MTD_MCHP23K256=y
# CONFIG_MTD_MCHP48L640 is not set
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_PLATFORM is not set
CONFIG_MTD_NAND_ARASAN=y

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
CONFIG_MTD_SPI_NAND=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
CONFIG_MTD_NAND_ECC_SW_BCH=y
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
# CONFIG_MTD_UBI_GLUEBI is not set
CONFIG_MTD_UBI_BLOCK=y
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
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
# CONFIG_NVME_VERBOSE_ERRORS is not set
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# CONFIG_PVPANIC is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
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
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
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
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
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
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

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
# CONFIG_INPUT_FF_MEMLESS is not set
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
CONFIG_KEYBOARD_ADC=m
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
CONFIG_KEYBOARD_QT1070=y
# CONFIG_KEYBOARD_QT2160 is not set
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=y
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_TWL4030=y
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_KEYBOARD_MTK_PMIC=y
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADC=m
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=y
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_WALKERA0701=y
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_QWIIC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
# CONFIG_JOYSTICK_SENSEHAT is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ADS7846=y
CONFIG_TOUCHSCREEN_AD7877=y
# CONFIG_TOUCHSCREEN_AD7879 is not set
CONFIG_TOUCHSCREEN_ADC=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMA140=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP_SPI=y
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP5 is not set
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=y
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
# CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_S6SY761=y
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_IMAGIS is not set
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_WM831X is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_RM_TS=y
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
CONFIG_TOUCHSCREEN_STMFTS=y
CONFIG_TOUCHSCREEN_SURFACE3_SPI=y
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=y
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_TOUCHSCREEN_ZINITIX=y
# CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
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
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LEGACY_TIOCSTI=y
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_16550A_VARIANTS=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_LANTIQ=y
# CONFIG_SERIAL_LANTIQ_CONSOLE is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_SC16IS7XX_SPI=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_FSL_LINFLEXUART=y
# CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE is not set
CONFIG_SERIAL_MEN_Z135=y
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_N_HDLC is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_IPMB is not set
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
# CONFIG_SSIF_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_XIPHERA=y
# CONFIG_APPLICOM is not set
CONFIG_MWAVE=y
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
# CONFIG_XILLYBUS is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y
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
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PCI1XXXX is not set
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
# CONFIG_I2C_CROS_EC_TUNNEL is not set
# CONFIG_I2C_VIRTIO is not set
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
# CONFIG_DW_I3C_MASTER is not set
# CONFIG_SVC_I3C_MASTER is not set
# CONFIG_MIPI_I3C_HCI is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_ALTERA_DFL is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_DMA is not set
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=y
# CONFIG_SPI_NXP_FLEXSPI is not set
CONFIG_SPI_GPIO=y
# CONFIG_SPI_INTEL_PCI is not set
# CONFIG_SPI_INTEL_PLATFORM is not set
CONFIG_SPI_LM70_LLP=y
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_SC18IS602 is not set
CONFIG_SPI_SIFIVE=y
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
CONFIG_SPMI_HISI3670=y
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
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
CONFIG_PINCTRL_DA9062=y
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L90=y
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
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_SIOX=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TQMX86 is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=y
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
# SPI GPIO expanders
#
CONFIG_GPIO_MAX3191X=y
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=y
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_LATCH is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_IP5XXX_POWER is not set
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_BATTERY_TWL4030_MADC=m
# CONFIG_BATTERY_RX51 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=m
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_CROS_USBPD is not set
CONFIG_CHARGER_CROS_PCHG=m
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_I8K is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX1111=y
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX31730=y
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1266=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_DPS920AB is not set
CONFIG_SENSORS_INSPUR_IPSPS=y
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LT7182S is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX16601=y
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
CONFIG_SENSORS_PXE1610=y
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_TPS546D24 is not set
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=y
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
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_TMP464 is not set
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y
# CONFIG_SENSORS_WM8350 is not set
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=y

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
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
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
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
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
CONFIG_MFD_AS3711=y
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC_DEV=m
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
# CONFIG_MFD_MADERA_SPI is not set
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
CONFIG_MFD_CS47L92=y
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_MFD_WCD934X=y
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_RAVE_SP_CORE=y
CONFIG_MFD_INTEL_M10_BMC=y
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=y
# CONFIG_LIRC is not set
CONFIG_RC_MAP=y
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
CONFIG_MEDIA_CEC_RC=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_CROS_EC is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
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
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_MEM2MEM_DEV=y
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
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_MAXIRADIO is not set
CONFIG_RADIO_SAA7706H=y
# CONFIG_RADIO_SI4713 is not set
CONFIG_RADIO_TEA5764=y
# CONFIG_RADIO_TEA5764_XTAL is not set
CONFIG_RADIO_TEF6862=y
CONFIG_RADIO_WL1273=y
CONFIG_RADIO_SI470X=y
# CONFIG_I2C_SI470X is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=y

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
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
# CONFIG_VIDEO_CADENCE_CSI2TX is not set

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
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
# CONFIG_VIDEO_IR_I2C is not set

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# CONFIG_VIDEO_TDA1997X is not set
CONFIG_VIDEO_TDA7432=y
# CONFIG_VIDEO_TDA9840 is not set
CONFIG_VIDEO_TEA6415C=y
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_TLV320AIC23B=y
CONFIG_VIDEO_TVAUDIO=y
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
CONFIG_VIDEO_ADV7183=y
CONFIG_VIDEO_ADV7604=y
CONFIG_VIDEO_ADV7604_CEC=y
CONFIG_VIDEO_ADV7842=y
# CONFIG_VIDEO_ADV7842_CEC is not set
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
# CONFIG_VIDEO_TC358743_CEC is not set
# CONFIG_VIDEO_TC358746 is not set
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=y
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_AD9389B=y
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
# CONFIG_VIDEO_ADV7343 is not set
CONFIG_VIDEO_ADV7393=y
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_SAA7127=y
# CONFIG_VIDEO_SAA7185 is not set
CONFIG_VIDEO_THS8200=y
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
CONFIG_VIDEO_UPD64083=y
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_M52790 is not set
CONFIG_VIDEO_ST_MIPID02=y
CONFIG_VIDEO_THS7303=y
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
CONFIG_VIDEO_GS1662=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT2060=y
# CONFIG_MEDIA_TUNER_MT2063 is not set
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2131=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
# CONFIG_MEDIA_TUNER_TDA18212 is not set
CONFIG_MEDIA_TUNER_TDA18218=y
# CONFIG_MEDIA_TUNER_TDA18250 is not set
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
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KUNIT_TEST=m
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_BUDDY=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_QXL is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
CONFIG_LCD_PLATFORM=y
# CONFIG_LCD_LMS501KF03 is not set
CONFIG_LCD_HX8357=y
# CONFIG_LCD_OTM3225A is not set
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_PORTMAN2X4 is not set
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
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
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
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDA_HWDEP is not set
# CONFIG_SND_HDA_RECONFIG is not set
# CONFIG_SND_HDA_INPUT_BEEP is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
# CONFIG_SND_HDA_SCODEC_CS35L41_I2C is not set
# CONFIG_SND_HDA_SCODEC_CS35L41_SPI is not set
# CONFIG_SND_HDA_CODEC_REALTEK is not set
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
# CONFIG_SND_HDA_CODEC_HDMI is not set
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
# CONFIG_SND_HDA_CODEC_CS8409 is not set
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
# CONFIG_SND_HDA_CODEC_CA0110 is not set
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
# CONFIG_SND_HDA_CODEC_SI3054 is not set
# CONFIG_SND_HDA_GENERIC is not set
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
CONFIG_SND_SPI=y
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
# CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST is not set
CONFIG_SND_SOC_UTILS_KUNIT_TEST=m
CONFIG_SND_SOC_ACPI=m
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
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
# CONFIG_SND_SOC_INTEL_SKL is not set
# CONFIG_SND_SOC_INTEL_APL is not set
# CONFIG_SND_SOC_INTEL_KBL is not set
# CONFIG_SND_SOC_INTEL_GLK is not set
# CONFIG_SND_SOC_INTEL_CNL is not set
# CONFIG_SND_SOC_INTEL_CFL is not set
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_AVS=m

#
# Intel AVS Machine drivers
#

#
# Available DSP configurations
#
# CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_PROBE is not set
# end of Intel AVS Machine drivers

CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1372_I2C is not set
# CONFIG_SND_SOC_ADAU1372_SPI is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4375 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_AW8738 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CROS_EC_CODEC is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS35L41_SPI is not set
# CONFIG_SND_SOC_CS35L41_I2C is not set
# CONFIG_SND_SOC_CS35L45_SPI is not set
# CONFIG_SND_SOC_CS35L45_I2C is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS42L83 is not set
# CONFIG_SND_SOC_CS4234 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
# CONFIG_SND_SOC_DA7213 is not set
# CONFIG_SND_SOC_DMIC is not set
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
# CONFIG_SND_SOC_ES8316 is not set
# CONFIG_SND_SOC_ES8326 is not set
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDA=m
# CONFIG_SND_SOC_ICS43432 is not set
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
# CONFIG_SND_SOC_MAX98357A is not set
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
# CONFIG_SND_SOC_MAX98927 is not set
# CONFIG_SND_SOC_MAX98520 is not set
# CONFIG_SND_SOC_MAX98373_I2C is not set
# CONFIG_SND_SOC_MAX98390 is not set
# CONFIG_SND_SOC_MAX98396 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM5102A is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
# CONFIG_SND_SOC_RT5640 is not set
# CONFIG_SND_SOC_RT5659 is not set
# CONFIG_SND_SOC_RT9120 is not set
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIMPLE_MUX is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SRC4XXX_I2C is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2518 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
# CONFIG_SND_SOC_SSM4567 is not set
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS2780 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS5805M is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TFA989X is not set
# CONFIG_SND_SOC_TLV320ADC3XXX is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
# CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
# CONFIG_SND_SOC_TS3A227E is not set
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WCD9335 is not set
# CONFIG_SND_SOC_WCD934X is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731_I2C is not set
# CONFIG_SND_SOC_WM8731_SPI is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8940 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8961 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZL38060 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8315 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8821 is not set
# CONFIG_SND_SOC_NAU8822 is not set
# CONFIG_SND_SOC_NAU8824 is not set
# CONFIG_SND_SOC_TPA6130A2 is not set
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
# CONFIG_SND_VIRTIO is not set

#
# HID support
#
# CONFIG_HID is not set

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
# end of HID support

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
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_APU=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_MAX8997 is not set
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set

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
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_LIB_KUNIT_TEST=m
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABEOZ9 is not set
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_MAX8997=y
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_S35390A=y
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV3028=y
# CONFIG_RTC_DRV_RV3032 is not set
CONFIG_RTC_DRV_RV8803=y
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
CONFIG_RTC_DRV_M41T94=y
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
CONFIG_RTC_DRV_DS1343=y
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
# CONFIG_RTC_DRV_MAX6916 is not set
CONFIG_RTC_DRV_R9701=y
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
CONFIG_RTC_DRV_PCF2123=y
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_DS3232_HWMON is not set
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_RV3029_HWMON=y
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_WM831X is not set
CONFIG_RTC_DRV_WM8350=y
# CONFIG_RTC_DRV_CROS_EC is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_MC13XXX is not set
# CONFIG_RTC_DRV_MT6397 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_IMG_ASCII_LCD=y
# CONFIG_LCD2S is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=y
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
# CONFIG_VFIO_MDEV is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
CONFIG_VDPA=y
# CONFIG_VDPA_SIM is not set
# CONFIG_VDPA_USER is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_ISA_DRIVERS=y
# CONFIG_COMEDI_PCL711 is not set
# CONFIG_COMEDI_PCL724 is not set
# CONFIG_COMEDI_PCL726 is not set
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
CONFIG_COMEDI_PCL816=y
CONFIG_COMEDI_PCL818=y
# CONFIG_COMEDI_PCM3724 is not set
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
CONFIG_COMEDI_AMPLC_PC263_ISA=y
CONFIG_COMEDI_RTI800=y
# CONFIG_COMEDI_RTI802 is not set
# CONFIG_COMEDI_DAC02 is not set
CONFIG_COMEDI_DAS16M1=y
# CONFIG_COMEDI_DAS08_ISA is not set
# CONFIG_COMEDI_DAS16 is not set
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=y
# CONFIG_COMEDI_DAS6402 is not set
# CONFIG_COMEDI_DT2801 is not set
CONFIG_COMEDI_DT2811=y
CONFIG_COMEDI_DT2814=y
# CONFIG_COMEDI_DT2815 is not set
# CONFIG_COMEDI_DT2817 is not set
CONFIG_COMEDI_DT282X=y
CONFIG_COMEDI_DMM32AT=y
# CONFIG_COMEDI_FL512 is not set
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=y
CONFIG_COMEDI_II_PCI20KC=y
# CONFIG_COMEDI_C6XDIGIO is not set
# CONFIG_COMEDI_MPC624 is not set
CONFIG_COMEDI_ADQ12B=y
CONFIG_COMEDI_NI_AT_A2150=y
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=y
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
# CONFIG_COMEDI_PCMDA12 is not set
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=y
# CONFIG_COMEDI_MULTIQ3 is not set
# CONFIG_COMEDI_S526 is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
# CONFIG_RTLLIB is not set
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
CONFIG_ADIS16240=m
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
CONFIG_ADT7316_SPI=m
CONFIG_ADT7316_I2C=m
# end of Analog digital bi-direction converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=m
CONFIG_AD9834=m
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
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_STAGING_MEDIA is not set
CONFIG_MOST_COMPONENTS=y
# CONFIG_MOST_NET is not set
CONFIG_MOST_VIDEO=y
CONFIG_MOST_I2C=y
CONFIG_PI433=y
CONFIG_FIELDBUS_DEV=y
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
# CONFIG_CHROMEOS_LAPTOP is not set
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=m
# CONFIG_CROS_EC_I2C is not set
# CONFIG_CROS_EC_SPI is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LIGHTBAR=m
CONFIG_CROS_EC_DEBUGFS=m
CONFIG_CROS_EC_SENSORHUB=m
CONFIG_CROS_EC_SYSFS=m
CONFIG_CROS_USBPD_NOTIFY=m
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
CONFIG_CROS_KUNIT=m
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_AGGREGATOR is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
# CONFIG_P2SB is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_XILINX_VCU is not set
CONFIG_CLK_KUNIT_TEST=m
CONFIG_CLK_GATE_KUNIT_TEST=m
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
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
# CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set
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
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_FSA9480=y
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_CROS_EC is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_DMA=m
# CONFIG_IIO_BUFFER_DMAENGINE is not set
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
CONFIG_ADIS16201=m
CONFIG_ADIS16209=m
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL313_SPI is not set
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
CONFIG_ADXL345_SPI=m
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL355_SPI is not set
# CONFIG_ADXL367_SPI is not set
# CONFIG_ADXL367_I2C is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=m
CONFIG_BMA220=m
CONFIG_BMA400=m
CONFIG_BMA400_I2C=m
CONFIG_BMA400_SPI=m
# CONFIG_BMC150_ACCEL is not set
# CONFIG_BMI088_ACCEL is not set
CONFIG_DA280=m
CONFIG_DA311=m
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=m
CONFIG_DMARD10=m
# CONFIG_FXLS8962AF_I2C is not set
# CONFIG_FXLS8962AF_SPI is not set
# CONFIG_IIO_KX022A_SPI is not set
# CONFIG_IIO_KX022A_I2C is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7455_SPI=m
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=m
# CONFIG_MSA311 is not set
CONFIG_MXC4005=m
CONFIG_MXC6255=m
CONFIG_SCA3000=m
# CONFIG_SCA3300 is not set
CONFIG_STK8312=m
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
# CONFIG_AD4130 is not set
CONFIG_AD7091R5=m
# CONFIG_AD7124 is not set
# CONFIG_AD7192 is not set
CONFIG_AD7266=m
CONFIG_AD7280=m
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
CONFIG_AD7298=m
# CONFIG_AD7476 is not set
CONFIG_AD7606=m
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD7606_IFACE_SPI=m
CONFIG_AD7766=m
CONFIG_AD7768_1=m
# CONFIG_AD7780 is not set
CONFIG_AD7791=m
CONFIG_AD7793=m
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
CONFIG_AD7949=m
# CONFIG_AD799X is not set
# CONFIG_ENVELOPE_DETECTOR is not set
# CONFIG_HI8435 is not set
CONFIG_HX711=m
CONFIG_LTC2471=m
# CONFIG_LTC2485 is not set
CONFIG_LTC2496=m
CONFIG_LTC2497=m
CONFIG_MAX1027=m
CONFIG_MAX11100=m
CONFIG_MAX1118=m
# CONFIG_MAX11205 is not set
# CONFIG_MAX11410 is not set
CONFIG_MAX1241=m
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=m
CONFIG_MCP320X=m
CONFIG_MCP3422=m
CONFIG_MCP3911=m
# CONFIG_MEDIATEK_MT6360_ADC is not set
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=m
# CONFIG_PALMAS_GPADC is not set
# CONFIG_QCOM_SPMI_IADC is not set
# CONFIG_QCOM_SPMI_VADC is not set
# CONFIG_QCOM_SPMI_ADC5 is not set
# CONFIG_RICHTEK_RTQ6056 is not set
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_TI_ADC081C=m
CONFIG_TI_ADC0832=m
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=m
CONFIG_TI_ADC108S102=m
# CONFIG_TI_ADC128S052 is not set
CONFIG_TI_ADC161S626=m
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS7950=m
# CONFIG_TI_ADS8344 is not set
# CONFIG_TI_ADS8688 is not set
# CONFIG_TI_ADS124S08 is not set
# CONFIG_TI_ADS131E08 is not set
# CONFIG_TI_AM335X_ADC is not set
CONFIG_TI_TLC4541=m
# CONFIG_TI_TSC2046 is not set
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=m
# CONFIG_VF610_ADC is not set
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
CONFIG_IIO_RESCALE=m
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=m
# CONFIG_ADA4250 is not set
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
CONFIG_AD7746=m
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
CONFIG_CCS811=m
# CONFIG_IAQCORE is not set
CONFIG_PMS7003=m
# CONFIG_SCD30_CORE is not set
# CONFIG_SCD4X is not set
CONFIG_SENSIRION_SGP30=m
# CONFIG_SENSIRION_SGP40 is not set
# CONFIG_SPS30_I2C is not set
# CONFIG_SPS30_SERIAL is not set
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
CONFIG_VZ89X=m
# end of Chemical Sensors

# CONFIG_IIO_CROS_EC_SENSORS_CORE is not set

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=m
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
# CONFIG_AD5360 is not set
CONFIG_AD5380=m
CONFIG_AD5421=m
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
CONFIG_AD5624R_SPI=m
# CONFIG_LTC2688 is not set
CONFIG_AD5686=m
CONFIG_AD5686_SPI=m
# CONFIG_AD5696_I2C is not set
CONFIG_AD5755=m
CONFIG_AD5758=m
# CONFIG_AD5761 is not set
CONFIG_AD5764=m
# CONFIG_AD5766 is not set
# CONFIG_AD5770R is not set
CONFIG_AD5791=m
# CONFIG_AD7293 is not set
CONFIG_AD7303=m
# CONFIG_AD8801 is not set
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
# CONFIG_LTC1660 is not set
CONFIG_LTC2632=m
CONFIG_M62332=m
CONFIG_MAX517=m
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=m
CONFIG_MCP4922=m
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
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
# CONFIG_ADF4371 is not set
# CONFIG_ADF4377 is not set
# CONFIG_ADMV1013 is not set
# CONFIG_ADMV1014 is not set
# CONFIG_ADMV4420 is not set
# CONFIG_ADRF6780 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
CONFIG_ADIS16130=m
CONFIG_ADIS16136=m
CONFIG_ADIS16260=m
# CONFIG_ADXRS290 is not set
CONFIG_ADXRS450=m
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
# CONFIG_AM2315 is not set
CONFIG_DHT11=m
# CONFIG_HDC100X is not set
CONFIG_HDC2010=m
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
CONFIG_ADIS16460=m
CONFIG_ADIS16475=m
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BMI160_SPI=m
# CONFIG_BOSCH_BNO055_SERIAL is not set
# CONFIG_BOSCH_BNO055_I2C is not set
CONFIG_FXOS8700=m
CONFIG_FXOS8700_I2C=m
# CONFIG_FXOS8700_SPI is not set
CONFIG_KMX61=m
CONFIG_INV_ICM42600=m
CONFIG_INV_ICM42600_I2C=m
CONFIG_INV_ICM42600_SPI=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ST_LSM6DSX_I3C=m
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_ADUX1020=m
CONFIG_AL3010=m
CONFIG_AL3320A=m
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
CONFIG_AS73211=m
CONFIG_BH1750=m
CONFIG_BH1780=m
CONFIG_CM32181=m
CONFIG_CM3232=m
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
CONFIG_CM36651=m
CONFIG_GP2AP002=m
# CONFIG_GP2AP020A00F is not set
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
# CONFIG_ISL29125 is not set
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=m
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=m
# CONFIG_LTRF216A is not set
CONFIG_LV0104CS=m
CONFIG_MAX44000=m
CONFIG_MAX44009=m
CONFIG_NOA1305=m
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
CONFIG_SI1133=m
CONFIG_SI1145=m
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=m
# CONFIG_TSL4531 is not set
CONFIG_US5182D=m
CONFIG_VCNL4000=m
CONFIG_VCNL4035=m
CONFIG_VEML6030=m
CONFIG_VEML6070=m
CONFIG_VL6180=m
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_BMC150_MAGN_SPI=m
# CONFIG_MAG3110 is not set
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_HMC5843_SPI=m
CONFIG_SENSORS_RM3100=m
# CONFIG_SENSORS_RM3100_I2C is not set
CONFIG_SENSORS_RM3100_SPI=m
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

CONFIG_IIO_RESCALE_KUNIT_TEST=m
CONFIG_IIO_FORMAT_KUNIT_TEST=m

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
CONFIG_MAX5481=m
# CONFIG_MAX5487 is not set
CONFIG_MCP4018=m
CONFIG_MCP4131=m
CONFIG_MCP4531=m
CONFIG_MCP41010=m
CONFIG_TPL0102=m
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
# CONFIG_DLHL60D is not set
CONFIG_DPS310=m
CONFIG_HP03=m
# CONFIG_ICP10100 is not set
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=m
# CONFIG_MS5611 is not set
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_IIO_ST_PRESS_SPI=m
CONFIG_T5403=m
CONFIG_HP206C=m
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=m
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_CROS_EC_MKBP_PROXIMITY is not set
CONFIG_ISL29501=m
CONFIG_LIDAR_LITE_V2=m
CONFIG_MB1232=m
CONFIG_PING=m
CONFIG_RFD77402=m
# CONFIG_SRF04 is not set
# CONFIG_SX9310 is not set
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
# CONFIG_SX9500 is not set
CONFIG_SRF08=m
# CONFIG_VCNL3020 is not set
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=m
CONFIG_AD2S1200=m
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_LTC2983=m
CONFIG_MAXIM_THERMOCOUPLE=m
CONFIG_MLX90614=m
CONFIG_MLX90632=m
# CONFIG_TMP006 is not set
CONFIG_TMP007=m
# CONFIG_TMP117 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX30208 is not set
# CONFIG_MAX31856 is not set
# CONFIG_MAX31865 is not set
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_SIMPLE is not set
CONFIG_RESET_TI_SYSCON=y
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
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
CONFIG_USB4_KUNIT_TEST=y
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_NVDIMM_SECURITY_TEST=y
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_DEV_DAX_PMEM=m
# CONFIG_DEV_DAX_KMEM is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RAVE_SP_EEPROM is not set
# CONFIG_NVMEM_RMEM is not set
# CONFIG_NVMEM_SPMI_SDAM is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_MACHXO2_SPI=y
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
CONFIG_FPGA_DFL_FME_MGR=y
# CONFIG_FPGA_DFL_FME_BRIDGE is not set
CONFIG_FPGA_DFL_FME_REGION=y
CONFIG_FPGA_DFL_AFU=y
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
# CONFIG_FPGA_DFL_PCI is not set
# CONFIG_FPGA_M10_BMC_SEC_UPDATE is not set
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
# CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_ADGS1408 is not set
CONFIG_MUX_GPIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
# CONFIG_MOST_SND is not set
# CONFIG_PECI is not set
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
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
# CONFIG_F2FS_FS_XATTR is not set
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_F2FS_FS_COMPRESSION=y
# CONFIG_F2FS_FS_LZO is not set
# CONFIG_F2FS_FS_LZ4 is not set
# CONFIG_F2FS_FS_ZSTD is not set
CONFIG_F2FS_IOSTAT=y
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
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
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set
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
CONFIG_FAT_KUNIT_TEST=m
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
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
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
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
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
CONFIG_SECURITY_APPARMOR_KUNIT_TEST=m
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
# CONFIG_INTEGRITY is not set
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"

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
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
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
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y
# end of Crypto core or helper

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_TWOFISH is not set
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_SEQIV is not set
CONFIG_CRYPTO_ECHAINIV=y
# CONFIG_CRYPTO_ESSIV is not set
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_VMAC is not set
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
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
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
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=y
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=m
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
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
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
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
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
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
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=y
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
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
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
CONFIG_GDB_SCRIPTS=y
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
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
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
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
CONFIG_KASAN_KUNIT_TEST=m
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=100
CONFIG_KFENCE_NUM_OBJECTS=255
# CONFIG_KFENCE_DEFERRABLE is not set
# CONFIG_KFENCE_STATIC_KEYS is not set
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
CONFIG_KFENCE_KUNIT_TEST=m
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
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
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
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
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
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
CONFIG_DEBUG_MAPLE_TREE=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
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
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FPROBE=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
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
CONFIG_FTRACE_SORT_STARTUP_TEST=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
CONFIG_HIST_TRIGGERS_DEBUG=y
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
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
# CONFIG_KUNIT_TEST is not set
# CONFIG_KUNIT_EXAMPLE_TEST is not set
CONFIG_KUNIT_ALL_TESTS=m
CONFIG_KUNIT_DEFAULT_ENABLED=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
CONFIG_CPUMASK_KUNIT_TEST=m
CONFIG_TEST_LIST_SORT=m
CONFIG_TEST_MIN_HEAP=m
CONFIG_TEST_SORT=m
CONFIG_TEST_DIV64=m
# CONFIG_KPROBES_SANITY_TEST is not set
CONFIG_FPROBE_SANITY_TEST=y
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=m
# CONFIG_TEST_HEXDUMP is not set
CONFIG_STRING_SELFTEST=m
CONFIG_TEST_STRING_HELPERS=m
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
CONFIG_TEST_UUID=m
CONFIG_TEST_XARRAY=m
CONFIG_TEST_MAPLE_TREE=m
CONFIG_TEST_RHASHTABLE=m
CONFIG_TEST_IDA=m
# CONFIG_TEST_LKM is not set
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_BITFIELD_KUNIT=m
CONFIG_HASH_KUNIT_TEST=m
CONFIG_RESOURCE_KUNIT_TEST=m
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
CONFIG_LINEAR_RANGES_TEST=m
CONFIG_CMDLINE_KUNIT_TEST=m
CONFIG_BITS_TEST=m
CONFIG_SLUB_KUNIT_TEST=m
CONFIG_RATIONAL_KUNIT_TEST=m
CONFIG_MEMCPY_KUNIT_TEST=m
CONFIG_IS_SIGNED_TYPE_KUNIT_TEST=m
CONFIG_OVERFLOW_KUNIT_TEST=m
CONFIG_STACKINIT_KUNIT_TEST=m
CONFIG_FORTIFY_KUNIT_TEST=m
CONFIG_HW_BREAKPOINT_KUNIT_TEST=y
CONFIG_STRSCPY_KUNIT_TEST=m
CONFIG_SIPHASH_KUNIT_TEST=m
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_DYNAMIC_DEBUG=m
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
CONFIG_TEST_MEMCAT_P=m
CONFIG_TEST_LIVEPATCH=m
CONFIG_TEST_MEMINIT=m
CONFIG_TEST_HMM=m
CONFIG_TEST_FREE_PAGES=m
CONFIG_TEST_FPU=m
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--CxYnWoSba6GjFw2I
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kunit'
	export testcase='kunit'
	export category='functional'
	export job_origin='kunit.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linus/master'
	export commit='69d4c0d3218692ffa56b0e1b9c76c50c699d7044'
	export kconfig='x86_64-randconfig-a012-20211016'
	export repeat_to=40
	export nr_vm=300
	export submit_id='63fc8fbded3a6bc718f0c64c'
	export job_file='/lkp/jobs/scheduled/vm-meta-125/kunit-group-00-debian-11.1-i386-20220923.cgz-69d4c0d3218692ffa56b0e1b9c76c50c699d7044-20230227-50968-7mqj6b-39.yaml'
	export id='815fc9403da45d03ca071398cb3d9661028d7783'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig='{"KVM_GUEST"=>"y"}
{"RUNTIME_TESTING_MENU"=>"y"}
{"KUNIT"=>"y"}
{"KUNIT_DEBUGFS"=>"y"}
{"KUNIT_ALL_TESTS"=>"m"}
{"BITFIELD_KUNIT"=>"m"}
{"BITS_TEST"=>"m"}
{"CMDLINE_KUNIT_TEST"=>"m"}
{"EXT4_KUNIT_TESTS"=>"m"}
{"HASH_KUNIT_TEST"=>"m"}
{"KUNIT_EXAMPLE_TEST"=>"n"}
{"KUNIT_TEST"=>"n"}
{"LINEAR_RANGES_TEST"=>"m"}
{"LIST_KUNIT_TEST"=>"m"}
{"MEMCPY_KUNIT_TEST"=>"m"}
{"NETDEV_ADDR_LIST_TEST"=>"m"}
{"RESOURCE_KUNIT_TEST"=>"m"}
{"RTC_LIB_KUNIT_TEST"=>"m"}
{"SYSCTL_KUNIT_TEST"=>"m"}
{"TIME_KUNIT_TEST"=>"m"}
{"TEST_LIST_SORT"=>"m"}
{"TEST_SORT"=>"m"}
FAT_FS
{"FAT_KUNIT_TEST"=>"m"}
{"KASAN"=>"y"}
{"KASAN_KUNIT_TEST"=>"m"}
{"TRACEPOINTS"=>"y"}
{"KFENCE"=>"y"}
{"KFENCE_KUNIT_TEST"=>"m"}
{"MPTCP"=>"y"}
{"MPTCP_KUNIT_TEST"=>"m"}
{"RATIONAL"=>"y"}
{"RATIONAL_KUNIT_TEST"=>"m"}
{"SLOB_DEPRECATED"=>"n"}
{"SLUB"=>"y"}
{"SLUB_DEBUG"=>"y"}
{"SLUB_TINY"=>"n"}
{"SLUB_KUNIT_TEST"=>"m"}
{"DRIVER_PE_KUNIT_TEST"=>"y"}
{"PM_QOS_KUNIT_TEST"=>"y"}
{"USB4"=>"y"}
{"USB4_KUNIT_TEST"=>"y"}
{"SECURITY_APPARMOR"=>"y"}
{"SECURITY_APPARMOR_KUNIT_TEST"=>"m"}'
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-i386-20220923.cgz'
	export compiler='gcc-11'
	export enqueue_time='2023-02-27 19:10:53 +0800'
	export _id='63fc8fd5ed3a6bc718f0c667'
	export _rt='/result/kunit/group-00/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/kunit/group-00/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/21'
	export scheduler_version='/lkp/lkp/src'
	export arch='i386'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kunit/group-00/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/21
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/vmlinuz-6.2.0-rc1-00083-g69d4c0d32186
branch=linus/master
job=/lkp/jobs/scheduled/vm-meta-125/kunit-group-00-debian-11.1-i386-20220923.cgz-69d4c0d3218692ffa56b0e1b9c76c50c699d7044-20230227-50968-7mqj6b-39.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a012-20211016
commit=69d4c0d3218692ffa56b0e1b9c76c50c699d7044
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
	export modules_initrd='/pkg/linux/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export stop_repeat_if_found='dmesg.Kernel_panic-not_syncing:Fatal_exception_in_interrupt'
	export kbuild_queue_analysis=1
	export schedule_notify_address=
	export meta_host='vm-meta-125'
	export kernel='/pkg/linux/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/vmlinuz-6.2.0-rc1-00083-g69d4c0d32186'
	export dequeue_time='2023-02-27 19:13:34 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-125/kunit-group-00-debian-11.1-i386-20220923.cgz-69d4c0d3218692ffa56b0e1b9c76c50c699d7044-20230227-50968-7mqj6b-39.cgz'

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

	run_test group='group-00' $LKP_SRC/tests/wrapper kunit
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='group-00' $LKP_SRC/stats/wrapper kunit
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kunit.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--CxYnWoSba6GjFw2I
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
0jTm9LHEZ/sCAAAAAARZWg==

--CxYnWoSba6GjFw2I
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kunit"

early console in setup code
early console in extract_kernel
input_data: 0x00000000067e42bf
input_len: 0x0000000002620e92
output: 0x0000000001000000
output_len: 0x0000000007170ae8
kernel_total_size: 0x0000000007e28000
needed_size: 0x0000000008000000
trampoline_32bit: 0x000000000009d000

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
Linux version 6.2.0-rc1-00083-g69d4c0d32186 (kbuild@1a766cfab1a4) (gcc-11 (Debian 11.3.0-8) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39.90.20221231) #1 SMP Mon Feb 27 18:43:51 CST 2023
Command line: ip=::::vm-meta-125::dhcp root=/dev/ram0 RESULT_ROOT=/result/kunit/group-00/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/21 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/vmlinuz-6.2.0-rc1-00083-g69d4c0d32186 branch=linus/master job=/lkp/jobs/scheduled/vm-meta-125/kunit-group-00-debian-11.1-i386-20220923.cgz-69d4c0d3218692ffa56b0e1b9c76c50c699d7044-20230227-50968-7mqj6b-39.yaml user=lkp ARCH=x86_64 kconfig=x86_64-randconfig-a012-20211016 commit=69d4c0d3218692ffa56b0e1b9c76c50c699d7044 initcall_debug nmi_watchdog=0 vmalloc=256M initramfs_async=0 page_owner=on max_uptime=1200 LKP_SERVER=internal-lkp-server selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count
KERNEL supported cpus:
Intel GenuineIntel
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
signal: max sigframe size: 1776
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
DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Hypervisor detected: KVM
kvm-clock: Using msrs 4b564d01 and 4b564d00
kvm-clock: using sched offset of 541157265 cycles
clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
tsc: Detected 3092.732 MHz processor
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x440000 max_arch_pfn = 0x400000000
x86/PAT: PAT support disabled because CONFIG_X86_PAT is disabled in the kernel.
x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
last_pfn = 0xbffe0 max_arch_pfn = 0x400000000
Scan for SMP in [mem 0x00000000-0x000003ff]
Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Scan for SMP in [mem 0x000f0000-0x000fffff]
found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
mpc: f5bb0-f5c80
RAMDISK: [mem 0x7949d000-0x7fffffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F59B0 000014 (v00 BOCHS )
ACPI: RSDT 0x00000000BFFE198D 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: FACP 0x00000000BFFE1839 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: DSDT 0x00000000BFFE0040 0017F9 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: FACS 0x00000000BFFE0000 000040
ACPI: APIC 0x00000000BFFE18AD 000080 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: HPET 0x00000000BFFE192D 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: WAET 0x00000000BFFE1965 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: Reserving FACP table memory at [mem 0xbffe1839-0xbffe18ac]
ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe1838]
ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
ACPI: Reserving APIC table memory at [mem 0xbffe18ad-0xbffe192c]
ACPI: Reserving HPET table memory at [mem 0xbffe192d-0xbffe1964]
ACPI: Reserving WAET table memory at [mem 0xbffe1965-0xbffe198c]
mapped APIC to ffffffffff5fd000 (        fee00000)
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x000000043fffffff]
NODE_DATA(0) allocated [mem 0x43fff0000-0x43fff4fff]
Zone ranges:
DMA      [mem 0x0000000000001000-0x0000000000ffffff]
DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Normal   [mem 0x0000000100000000-0x000000043fffffff]
Device   empty
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x000000000009efff]
node   0: [mem 0x0000000000100000-0x00000000bffdffff]
node   0: [mem 0x0000000100000000-0x000000043fffffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000043fffffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 97 pages in unavailable ranges
On node 0, zone Normal: 32 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
ACPI: PM-Timer IO Port: 0x608
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
Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
TSC deadline timer available
smpboot: Allowing 2 CPUs, 0 hotplug CPUs
mapped IOAPIC to ffffffffff5fc000 (fec00000)
[mem 0xc0000000-0xfeffbfff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:64 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
percpu: Embedded 516 pages/cpu s2073128 r8192 d32216 u4194304
pcpu-alloc: s2073128 r8192 d32216 u4194304 alloc=2*2097152
pcpu-alloc: [0] 0 [0] 1 
Fallback order for Node 0: 0 
Built 1 zonelists, mobility grouping on.  Total pages: 4128480
Policy zone: Normal
Kernel command line: ip=::::vm-meta-125::dhcp root=/dev/ram0 RESULT_ROOT=/result/kunit/group-00/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/21 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/vmlinuz-6.2.0-rc1-00083-g69d4c0d32186 branch=linus/master job=/lkp/jobs/scheduled/vm-meta-125/kunit-group-00-debian-11.1-i386-20220923.cgz-69d4c0d3218692ffa56b0e1b9c76c50c699d7044-20230227-50968-7mqj6b-39.yaml user=lkp ARCH=x86_64 kconfig=x86_64-randconfig-a012-20211016 commit=69d4c0d3218692ffa56b0e1b9c76c50c699d7044 initcall_debug nmi_watchdog=0 vmalloc=256M initramfs_async=0 page_owner=on max_uptime=1200 LKP_SERVER=internal-lkp-server selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.mino
sysrq: sysrq always enabled.
ignoring the deprecated load_ramdisk= option
Unknown kernel command line parameters "RESULT_ROOT=/result/kunit/group-00/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/21 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/vmlinuz-6.2.0-rc1-00083-g69d4c0d32186 branch=linus/master job=/lkp/jobs/scheduled/vm-meta-125/kunit-group-00-debian-11.1-i386-20220923.cgz-69d4c0d3218692ffa56b0e1b9c76c50c699d7044-20230227-50968-7mqj6b-39.yaml user=lkp ARCH=x86_64 kconfig=x86_64-randconfig-a012-20211016 commit=69d4c0d3218692ffa56b0e1b9c76c50c699d7044 vmalloc=256M max_uptime=1200 LKP_SERVER=internal-lkp-server selinux=0 softlockup_panic=1 prompt_ramdisk=0 vga=normal", will be passed to user space.
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
software IO TLB: area num 2.
Memory: 2970832K/16776696K available (53248K kernel code, 20939K rwdata, 19236K rodata, 8444K init, 16960K bss, 2720660K reserved, 0K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Kernel/User page tables isolation: enabled
ftrace: allocating 53435 entries in 209 pages
ftrace section at ffffffff8788a250 sorted properly
ftrace: allocated 209 pages with 4 groups
Running RCU self tests
rcu: Hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	Build-time adjustment of leaf fanout to 2.
rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
rcu: 	RCU debug extended QS entry/exit.
	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
	Rude variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=2, nr_cpu_ids=2
NR_IRQS: 4352, nr_irqs: 56, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.
kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
calling  hvc_console_init+0x0/0x1c @ 0
initcall hvc_console_init+0x0/0x1c returned 0 after 0 usecs
calling  univ8250_console_init+0x0/0x2f @ 0
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
initcall univ8250_console_init+0x0/0x2f returned 0 after 0 usecs
calling  altera_uart_console_init+0x0/0x1c @ 0
initcall altera_uart_console_init+0x0/0x1c returned 0 after 0 usecs
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
ACPI: Core revision 20221020
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
APIC: Switch to symmetric I/O mode setup
masked ExtINT on CPU#0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
apic 0 pin 0 not connected
IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 0 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-4 -> IRQ 4 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-5 -> IRQ 5 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-6 -> IRQ 6 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-7 -> IRQ 7 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-8 -> IRQ 8 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-9 -> IRQ 9 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-10 -> IRQ 10 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-11 -> IRQ 11 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-12 -> IRQ 12 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-13 -> IRQ 13 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-14 -> IRQ 14 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-15 -> IRQ 15 Level:0 ActiveLow:0)
apic 0 pin 16 not connected
apic 0 pin 17 not connected
apic 0 pin 18 not connected
apic 0 pin 19 not connected
apic 0 pin 20 not connected
apic 0 pin 21 not connected
apic 0 pin 22 not connected
apic 0 pin 23 not connected
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2c9475bb8da, max_idle_ns: 440795307408 ns
Calibrating delay loop (skipped) preset value.. 6185.46 BogoMIPS (lpj=3092732)
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=capability,yama
Yama: becoming mindful.
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
numa_add_cpu cpu 0 node 0: mask now 0
Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Mitigation: Retpolines
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
Speculative Store Bypass: Vulnerable
MDS: Vulnerable: Clear CPU buffers attempted, no microcode
MMIO Stale Data: Unknown: No mitigations
Freeing SMP alternatives memory: 40K
smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 1 and lim to 1.
Running RCU-tasks wait API self tests
calling  init_hw_perf_events+0x0/0x59c @ 1
Performance Events: unsupported p6 CPU model 42 no PMU driver, software events only.
initcall init_hw_perf_events+0x0/0x59c returned 0 after 1000 usecs
calling  do_init_real_mode+0x0/0x19 @ 1
Callback from call_rcu_tasks_rude() invoked.
initcall do_init_real_mode+0x0/0x19 returned 0 after 1000 usecs
calling  trace_init_perf_perm_irq_work_exit+0x0/0x1b @ 1
initcall trace_init_perf_perm_irq_work_exit+0x0/0x1b returned 0 after 0 usecs
calling  bp_init_aperfmperf+0x0/0xa4 @ 1
initcall bp_init_aperfmperf+0x0/0xa4 returned 0 after 0 usecs
calling  register_nmi_cpu_backtrace_handler+0x0/0x1e @ 1
initcall register_nmi_cpu_backtrace_handler+0x0/0x1e returned 0 after 0 usecs
calling  kvm_setup_vsyscall_timeinfo+0x0/0xe5 @ 1
initcall kvm_setup_vsyscall_timeinfo+0x0/0xe5 returned 0 after 0 usecs
calling  spawn_ksoftirqd+0x0/0x5d @ 1
initcall spawn_ksoftirqd+0x0/0x5d returned 0 after 1000 usecs
calling  migration_init+0x0/0xd6 @ 1
initcall migration_init+0x0/0xd6 returned 0 after 0 usecs
calling  srcu_bootup_announce+0x0/0x80 @ 1
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 400.
initcall srcu_bootup_announce+0x0/0x80 returned 0 after 1000 usecs
calling  rcu_spawn_gp_kthread+0x0/0x4ac @ 1
initcall rcu_spawn_gp_kthread+0x0/0x4ac returned 0 after 1000 usecs
calling  check_cpu_stall_init+0x0/0x23 @ 1
initcall check_cpu_stall_init+0x0/0x23 returned 0 after 0 usecs
calling  rcu_sysrq_init+0x0/0x2a @ 1
initcall rcu_sysrq_init+0x0/0x2a returned 0 after 0 usecs
calling  trace_init_flags_sys_enter+0x0/0x17 @ 1
initcall trace_init_flags_sys_enter+0x0/0x17 returned 0 after 0 usecs
calling  trace_init_flags_sys_exit+0x0/0x17 @ 1
initcall trace_init_flags_sys_exit+0x0/0x17 returned 0 after 0 usecs
calling  cpu_stop_init+0x0/0x181 @ 1
initcall cpu_stop_init+0x0/0x181 returned 0 after 1000 usecs
calling  init_kprobes+0x0/0x261 @ 1
initcall init_kprobes+0x0/0x261 returned 0 after 3000 usecs
calling  init_events+0x0/0xca @ 1
initcall init_events+0x0/0xca returned 0 after 0 usecs
calling  init_trace_printk+0x0/0x10 @ 1
initcall init_trace_printk+0x0/0x10 returned 0 after 0 usecs
calling  event_trace_enable_again+0x0/0x27 @ 1
initcall event_trace_enable_again+0x0/0x27 returned 0 after 0 usecs
calling  irq_work_init_threads+0x0/0xb @ 1
initcall irq_work_init_threads+0x0/0xb returned 0 after 0 usecs
calling  static_call_init+0x0/0x9f @ 1
initcall static_call_init+0x0/0x9f returned 0 after 0 usecs
calling  jump_label_init_module+0x0/0x15 @ 1
initcall jump_label_init_module+0x0/0x15 returned 0 after 0 usecs
calling  init_zero_pfn+0x0/0x5a @ 1
initcall init_zero_pfn+0x0/0x5a returned 0 after 0 usecs
calling  init_fs_inode_sysctls+0x0/0x2a @ 1
initcall init_fs_inode_sysctls+0x0/0x2a returned 0 after 0 usecs
calling  init_fs_locks_sysctls+0x0/0x2a @ 1
initcall init_fs_locks_sysctls+0x0/0x2a returned 0 after 0 usecs
calling  dynamic_debug_init+0x0/0x392 @ 1
initcall dynamic_debug_init+0x0/0x392 returned 0 after 3000 usecs
NMI watchdog: Perf NMI watchdog permanently disabled
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
masked ExtINT on CPU#1
numa_add_cpu cpu 1 node 0: mask now 0-1
smp: Brought up 1 node, 2 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 2 processors activated (12370.92 BogoMIPS)
node 0 deferred pages initialised in 320ms
pgdatinit0 (23) used greatest stack depth: 29248 bytes left
allocated 268435456 bytes of page_ext
Node 0, zone      DMA: page owner found early allocated 0 pages
Node 0, zone    DMA32: page owner found early allocated 10 pages
Node 0, zone   Normal: page owner found early allocated 66803 pages
devtmpfs: initialized
x86/mm: Memory block size: 128MB
calling  ipc_ns_init+0x0/0x122 @ 1
initcall ipc_ns_init+0x0/0x122 returned 0 after 0 usecs
calling  init_mmap_min_addr+0x0/0x1e @ 1
initcall init_mmap_min_addr+0x0/0x1e returned 0 after 0 usecs
calling  pci_realloc_setup_params+0x0/0x61 @ 1
initcall pci_realloc_setup_params+0x0/0x61 returned 0 after 0 usecs
calling  inet_frag_wq_init+0x0/0x4a @ 1
initcall inet_frag_wq_init+0x0/0x4a returned 0 after 1000 usecs
calling  e820__register_nvs_regions+0x0/0x154 @ 1
initcall e820__register_nvs_regions+0x0/0x154 returned 0 after 0 usecs
calling  cache_ap_register+0x0/0x30 @ 1
initcall cache_ap_register+0x0/0x30 returned 0 after 0 usecs
calling  reboot_init+0x0/0x59 @ 1
initcall reboot_init+0x0/0x59 returned 0 after 0 usecs
calling  init_lapic_sysfs+0x0/0x4f @ 1
initcall init_lapic_sysfs+0x0/0x4f returned 0 after 0 usecs
calling  wq_sysfs_init+0x0/0x33 @ 1
initcall wq_sysfs_init+0x0/0x33 returned 0 after 1000 usecs
calling  ksysfs_init+0x0/0xa1 @ 1
initcall ksysfs_init+0x0/0xa1 returned 0 after 0 usecs
calling  pm_init+0x0/0x5b @ 1
initcall pm_init+0x0/0x5b returned 0 after 0 usecs
calling  rcu_set_runtime_mode+0x0/0x67 @ 1
initcall rcu_set_runtime_mode+0x0/0x67 returned 0 after 0 usecs
calling  init_jiffies_clocksource+0x0/0x1c @ 1
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
initcall init_jiffies_clocksource+0x0/0x1c returned 0 after 1000 usecs
calling  futex_init+0x0/0x1d8 @ 1
futex hash table entries: 512 (order: 4, 65536 bytes, linear)
initcall futex_init+0x0/0x1d8 returned 0 after 1000 usecs
calling  cgroup_wq_init+0x0/0x4f @ 1
initcall cgroup_wq_init+0x0/0x4f returned 0 after 0 usecs
calling  cgroup1_wq_init+0x0/0x4f @ 1
initcall cgroup1_wq_init+0x0/0x4f returned 0 after 0 usecs
calling  ftrace_mod_cmd_init+0x0/0x10 @ 1
initcall ftrace_mod_cmd_init+0x0/0x10 returned 0 after 0 usecs
calling  init_wakeup_tracer+0x0/0x35 @ 1
initcall init_wakeup_tracer+0x0/0x35 returned 0 after 0 usecs
calling  init_branch_tracer+0x0/0x36 @ 1
initcall init_branch_tracer+0x0/0x36 returned 0 after 0 usecs
calling  trace_events_eprobe_init_early+0x0/0x2f @ 1
initcall trace_events_eprobe_init_early+0x0/0x2f returned 0 after 0 usecs
calling  trace_events_synth_init_early+0x0/0x2f @ 1
initcall trace_events_synth_init_early+0x0/0x2f returned 0 after 0 usecs
calling  init_kprobe_trace_early+0x0/0x2e @ 1
initcall init_kprobe_trace_early+0x0/0x2e returned 0 after 0 usecs
calling  kasan_memhotplug_init+0x0/0x17 @ 1
initcall kasan_memhotplug_init+0x0/0x17 returned 0 after 0 usecs
calling  fsnotify_init+0x0/0x8f @ 1
initcall fsnotify_init+0x0/0x8f returned 0 after 0 usecs
calling  filelock_init+0x0/0x175 @ 1
initcall filelock_init+0x0/0x175 returned 0 after 0 usecs
calling  init_script_binfmt+0x0/0x1e @ 1
initcall init_script_binfmt+0x0/0x1e returned 0 after 0 usecs
calling  init_elf_binfmt+0x0/0x1e @ 1
initcall init_elf_binfmt+0x0/0x1e returned 0 after 0 usecs
calling  init_compat_elf_binfmt+0x0/0x1e @ 1
initcall init_compat_elf_binfmt+0x0/0x1e returned 0 after 0 usecs
calling  configfs_init+0x0/0xf2 @ 1
initcall configfs_init+0x0/0xf2 returned 0 after 0 usecs
calling  debugfs_init+0x0/0xbb @ 1
initcall debugfs_init+0x0/0xbb returned 0 after 0 usecs
calling  tracefs_init+0x0/0x6b @ 1
initcall tracefs_init+0x0/0x6b returned 0 after 0 usecs
calling  securityfs_init+0x0/0xc2 @ 1
initcall securityfs_init+0x0/0xc2 returned 0 after 1000 usecs
calling  register_xor_blocks+0x0/0xa3 @ 1
initcall register_xor_blocks+0x0/0xa3 returned 0 after 0 usecs
calling  pinctrl_init+0x0/0xbe @ 1
pinctrl core: initialized pinctrl subsystem
initcall pinctrl_init+0x0/0xbe returned 0 after 1000 usecs
calling  gpiolib_dev_init+0x0/0x128 @ 1
initcall gpiolib_dev_init+0x0/0x128 returned 0 after 0 usecs
calling  virtio_init+0x0/0x30 @ 1
initcall virtio_init+0x0/0x30 returned 0 after 0 usecs
calling  vdpa_init+0x0/0x50 @ 1
initcall vdpa_init+0x0/0x50 returned 0 after 0 usecs
calling  iommu_init+0x0/0x77 @ 1
initcall iommu_init+0x0/0x77 returned 0 after 0 usecs
calling  component_debug_init+0x0/0x25 @ 1
initcall component_debug_init+0x0/0x25 returned 0 after 0 usecs
calling  opp_debug_init+0x0/0x25 @ 1
initcall opp_debug_init+0x0/0x25 returned 0 after 0 usecs
calling  cpuidle_init+0x0/0x4e @ 1
initcall cpuidle_init+0x0/0x4e returned 0 after 0 usecs
calling  sock_init+0x0/0xbf @ 1
initcall sock_init+0x0/0xbf returned 0 after 1000 usecs
calling  net_inuse_init+0x0/0x31 @ 1
initcall net_inuse_init+0x0/0x31 returned 0 after 0 usecs
calling  net_defaults_init+0x0/0x31 @ 1
initcall net_defaults_init+0x0/0x31 returned 0 after 0 usecs
calling  init_default_flow_dissectors+0x0/0x58 @ 1
initcall init_default_flow_dissectors+0x0/0x58 returned 0 after 0 usecs
calling  netlink_proto_init+0x0/0x28e @ 1
NET: Registered PF_NETLINK/PF_ROUTE protocol family
initcall netlink_proto_init+0x0/0x28e returned 0 after 2000 usecs
calling  genl_init+0x0/0x4b @ 1
initcall genl_init+0x0/0x4b returned 0 after 0 usecs
calling  trace_boot_init+0x0/0x18f @ 1
initcall trace_boot_init+0x0/0x18f returned 0 after 0 usecs
calling  irq_sysfs_init+0x0/0xc2 @ 1
initcall irq_sysfs_init+0x0/0xc2 returned 0 after 1000 usecs
calling  audit_init+0x0/0x1b3 @ 1
audit: initializing netlink subsys (disabled)
initcall audit_init+0x0/0x1b3 returned 0 after 2000 usecs
audit: type=2000 audit(1677496465.852:1): state=initialized audit_enabled=0 res=1
calling  release_early_probes+0x0/0x61 @ 1
initcall release_early_probes+0x0/0x61 returned 0 after 0 usecs
calling  bdi_class_init+0x0/0x81 @ 1
initcall bdi_class_init+0x0/0x81 returned 0 after 0 usecs
calling  mm_sysfs_init+0x0/0x57 @ 1
initcall mm_sysfs_init+0x0/0x57 returned 0 after 0 usecs
calling  init_per_zone_wmark_min+0x0/0x2e @ 1
initcall init_per_zone_wmark_min+0x0/0x2e returned 0 after 0 usecs
calling  mpi_init+0x0/0xee @ 1
initcall mpi_init+0x0/0xee returned 0 after 0 usecs
calling  mhi_init+0x0/0x1a @ 1
initcall mhi_init+0x0/0x1a returned 0 after 0 usecs
calling  gpiolib_sysfs_init+0x0/0x121 @ 1
initcall gpiolib_sysfs_init+0x0/0x121 returned 0 after 0 usecs
calling  acpi_gpio_setup_params+0x0/0x11e @ 1
initcall acpi_gpio_setup_params+0x0/0x11e returned 0 after 0 usecs
calling  pcibus_class_init+0x0/0x1c @ 1
initcall pcibus_class_init+0x0/0x1c returned 0 after 1000 usecs
calling  pci_driver_init+0x0/0x2a @ 1
initcall pci_driver_init+0x0/0x2a returned 0 after 0 usecs
calling  lcd_class_init+0x0/0x83 @ 1
initcall lcd_class_init+0x0/0x83 returned 0 after 0 usecs
calling  tty_class_init+0x0/0x6c @ 1
initcall tty_class_init+0x0/0x6c returned 0 after 0 usecs
calling  serdev_init+0x0/0x25 @ 1
initcall serdev_init+0x0/0x25 returned 0 after 0 usecs
calling  iommu_dev_init+0x0/0x1c @ 1
initcall iommu_dev_init+0x0/0x1c returned 0 after 0 usecs
calling  devlink_class_init+0x0/0x4e @ 1
initcall devlink_class_init+0x0/0x4e returned 0 after 0 usecs
calling  software_node_init+0x0/0x59 @ 1
initcall software_node_init+0x0/0x59 returned 0 after 0 usecs
calling  isa_bus_init+0x0/0x47 @ 1
initcall isa_bus_init+0x0/0x47 returned 0 after 1000 usecs
calling  regmap_initcall+0x0/0x15 @ 1
initcall regmap_initcall+0x0/0x15 returned 0 after 0 usecs
calling  sram_init+0x0/0x17 @ 1
initcall sram_init+0x0/0x17 returned 0 after 0 usecs
calling  syscon_init+0x0/0x17 @ 1
initcall syscon_init+0x0/0x17 returned 0 after 0 usecs
calling  spi_init+0x0/0x147 @ 1
initcall spi_init+0x0/0x147 returned 0 after 0 usecs
calling  spmi_init+0x0/0x25 @ 1
initcall spmi_init+0x0/0x25 returned 0 after 0 usecs
calling  spmi_controller_init+0x0/0x17 @ 1
initcall spmi_controller_init+0x0/0x17 returned 0 after 1000 usecs
calling  hsi_init+0x0/0x15 @ 1
initcall hsi_init+0x0/0x15 returned 0 after 0 usecs
calling  slimbus_init+0x0/0x15 @ 1
initcall slimbus_init+0x0/0x15 returned 0 after 0 usecs
calling  i2c_init+0x0/0x12c @ 1
initcall i2c_init+0x0/0x12c returned 0 after 0 usecs
calling  thermal_init+0x0/0x190 @ 1
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
initcall thermal_init+0x0/0x190 returned 0 after 0 usecs
calling  init_ladder+0x0/0x59 @ 1
cpuidle: using governor ladder
initcall init_ladder+0x0/0x59 returned 0 after 37000 usecs
calling  teo_governor_init+0x0/0x15 @ 1
cpuidle: using governor teo
initcall teo_governor_init+0x0/0x15 returned 0 after 0 usecs
calling  kobject_uevent_init+0x0/0x10 @ 1
initcall kobject_uevent_init+0x0/0x10 returned 0 after 0 usecs
calling  bts_init+0x0/0x138 @ 1
initcall bts_init+0x0/0x138 returned -19 after 0 usecs
calling  pt_init+0x0/0x2a2 @ 1
initcall pt_init+0x0/0x2a2 returned -19 after 0 usecs
calling  boot_params_ksysfs_init+0x0/0x9a @ 1
initcall boot_params_ksysfs_init+0x0/0x9a returned 0 after 0 usecs
calling  sbf_init+0x0/0xdb @ 1
initcall sbf_init+0x0/0xdb returned 0 after 0 usecs
calling  arch_kdebugfs_init+0x0/0x25 @ 1
initcall arch_kdebugfs_init+0x0/0x25 returned 0 after 0 usecs
calling  xfd_update_static_branch+0x0/0x4c @ 1
initcall xfd_update_static_branch+0x0/0x4c returned 0 after 0 usecs
calling  intel_pconfig_init+0x0/0xad @ 1
initcall intel_pconfig_init+0x0/0xad returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x3a @ 1
initcall activate_jump_labels+0x0/0x3a returned 0 after 0 usecs
calling  ffh_cstate_init+0x0/0x6a @ 1
initcall ffh_cstate_init+0x0/0x6a returned 0 after 0 usecs
calling  kvm_alloc_cpumask+0x0/0x187 @ 1
initcall kvm_alloc_cpumask+0x0/0x187 returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x3a @ 1
initcall activate_jump_labels+0x0/0x3a returned 0 after 0 usecs
calling  gigantic_pages_init+0x0/0x4e @ 1
initcall gigantic_pages_init+0x0/0x4e returned 0 after 0 usecs
calling  kcmp_cookies_init+0x0/0xaa @ 1
initcall kcmp_cookies_init+0x0/0xaa returned 0 after 0 usecs
calling  cryptomgr_init+0x0/0x15 @ 1
initcall cryptomgr_init+0x0/0x15 returned 0 after 0 usecs
calling  acpi_pci_init+0x0/0x105 @ 1
initcall acpi_pci_init+0x0/0x105 returned 0 after 0 usecs
calling  pci_arch_init+0x0/0x114 @ 1
PCI: Using configuration type 1 for base access
initcall pci_arch_init+0x0/0x114 returned 0 after 1000 usecs
calling  init_vdso+0x0/0x1c @ 1
initcall init_vdso+0x0/0x1c returned 0 after 0 usecs
calling  sysenter_setup+0x0/0x1c @ 1
initcall sysenter_setup+0x0/0x1c returned 0 after 0 usecs
calling  fixup_ht_bug+0x0/0x258 @ 1
initcall fixup_ht_bug+0x0/0x258 returned 0 after 0 usecs
calling  topology_init+0x0/0xa2 @ 1
initcall topology_init+0x0/0xa2 returned 0 after 1000 usecs
calling  intel_epb_init+0x0/0xdc @ 1
initcall intel_epb_init+0x0/0xdc returned -19 after 0 usecs
calling  uid_cache_init+0x0/0x106 @ 1
initcall uid_cache_init+0x0/0x106 returned 0 after 0 usecs
calling  param_sysfs_init+0x0/0x53 @ 1
initcall param_sysfs_init+0x0/0x53 returned 0 after 0 usecs
calling  user_namespace_sysctl_init+0x0/0x156 @ 1
initcall user_namespace_sysctl_init+0x0/0x156 returned 0 after 0 usecs
calling  proc_schedstat_init+0x0/0x2d @ 1
initcall proc_schedstat_init+0x0/0x2d returned 0 after 0 usecs
calling  pm_sysrq_init+0x0/0x21 @ 1
initcall pm_sysrq_init+0x0/0x21 returned 0 after 0 usecs
calling  create_proc_profile+0x0/0xf0 @ 1
initcall create_proc_profile+0x0/0xf0 returned 0 after 0 usecs
calling  crash_save_vmcoreinfo_init+0x0/0x736 @ 1
initcall crash_save_vmcoreinfo_init+0x0/0x736 returned 0 after 0 usecs
calling  crash_notes_memory_init+0x0/0x41 @ 1
initcall crash_notes_memory_init+0x0/0x41 returned 0 after 30000 usecs
calling  cgroup_sysfs_init+0x0/0x42 @ 1
initcall cgroup_sysfs_init+0x0/0x42 returned 0 after 0 usecs
calling  cgroup_namespaces_init+0x0/0x10 @ 1
initcall cgroup_namespaces_init+0x0/0x10 returned 0 after 0 usecs
calling  user_namespaces_init+0x0/0x35 @ 1
initcall user_namespaces_init+0x0/0x35 returned 0 after 0 usecs
calling  init_optprobes+0x0/0x35 @ 1
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
initcall init_optprobes+0x0/0x35 returned 0 after 1000 usecs
calling  hung_task_init+0x0/0x8e @ 1
initcall hung_task_init+0x0/0x8e returned 0 after 1000 usecs
calling  ftrace_check_for_weak_functions+0x0/0x8f @ 1
initcall ftrace_check_for_weak_functions+0x0/0x8f returned 0 after 1000 usecs
calling  trace_eval_init+0x0/0xb6 @ 1
initcall trace_eval_init+0x0/0xb6 returned 0 after 0 usecs
calling  oom_init+0x0/0x5b @ 1
initcall oom_init+0x0/0x5b returned 0 after 62000 usecs
calling  default_bdi_init+0x0/0x31 @ 1
initcall default_bdi_init+0x0/0x31 returned 0 after 8000 usecs
calling  percpu_enable_async+0x0/0x17 @ 1
initcall percpu_enable_async+0x0/0x17 returned 0 after 0 usecs
calling  kcompactd_init+0x0/0x9d @ 1
initcall kcompactd_init+0x0/0x9d returned 0 after 1000 usecs
calling  init_user_reserve+0x0/0xa0 @ 1
initcall init_user_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_admin_reserve+0x0/0xa0 @ 1
initcall init_admin_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_reserve_notifier+0x0/0x27 @ 1
initcall init_reserve_notifier+0x0/0x27 returned 0 after 0 usecs
calling  hugetlb_init+0x0/0x3fa @ 1
HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
initcall hugetlb_init+0x0/0x3fa returned 0 after 2000 usecs
calling  memory_tier_init+0x0/0x19c @ 1
initcall memory_tier_init+0x0/0x19c returned 0 after 1000 usecs
calling  numa_init_sysfs+0x0/0x96 @ 1
initcall numa_init_sysfs+0x0/0x96 returned 0 after 0 usecs
calling  hugepage_init+0x0/0x168 @ 1
initcall hugepage_init+0x0/0x168 returned 0 after 3000 usecs
calling  mem_cgroup_init+0x0/0x3d3 @ 1
initcall mem_cgroup_init+0x0/0x3d3 returned 0 after 0 usecs
calling  echainiv_module_init+0x0/0x15 @ 1
initcall echainiv_module_init+0x0/0x15 returned 0 after 0 usecs
calling  dh_init+0x0/0x49 @ 1
initcall dh_init+0x0/0x49 returned 0 after 0 usecs
calling  sm2_init+0x0/0x15 @ 1
initcall sm2_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_cmac_module_init+0x0/0x15 @ 1
initcall crypto_cmac_module_init+0x0/0x15 returned 0 after 0 usecs
calling  hmac_module_init+0x0/0x15 @ 1
initcall hmac_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_xcbc_module_init+0x0/0x15 @ 1
initcall crypto_xcbc_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_null_mod_init+0x0/0x75 @ 1
initcall crypto_null_mod_init+0x0/0x75 returned 0 after 0 usecs
calling  md5_mod_init+0x0/0x15 @ 1
initcall md5_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  sha1_generic_mod_init+0x0/0x15 @ 1
initcall sha1_generic_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  sha256_generic_mod_init+0x0/0x1a @ 1
initcall sha256_generic_mod_init+0x0/0x1a returned 0 after 0 usecs
calling  sha512_generic_mod_init+0x0/0x1a @ 1
initcall sha512_generic_mod_init+0x0/0x1a returned 0 after 0 usecs
calling  streebog_mod_init+0x0/0x1a @ 1
initcall streebog_mod_init+0x0/0x1a returned 0 after 0 usecs
calling  wp512_mod_init+0x0/0x1a @ 1
initcall wp512_mod_init+0x0/0x1a returned 0 after 0 usecs
calling  blake2b_mod_init+0x0/0x1a @ 1
initcall blake2b_mod_init+0x0/0x1a returned 0 after 0 usecs
calling  crypto_ecb_module_init+0x0/0x15 @ 1
initcall crypto_ecb_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_cbc_module_init+0x0/0x15 @ 1
initcall crypto_cbc_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_pcbc_module_init+0x0/0x15 @ 1
initcall crypto_pcbc_module_init+0x0/0x15 returned 0 after 0 usecs
calling  xts_module_init+0x0/0x15 @ 1
initcall xts_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_ctr_module_init+0x0/0x1a @ 1
initcall crypto_ctr_module_init+0x0/0x1a returned 0 after 0 usecs
calling  adiantum_module_init+0x0/0x15 @ 1
initcall adiantum_module_init+0x0/0x15 returned 0 after 0 usecs
calling  nhpoly1305_mod_init+0x0/0x15 @ 1
initcall nhpoly1305_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_gcm_module_init+0x0/0x6b @ 1
initcall crypto_gcm_module_init+0x0/0x6b returned 0 after 1000 usecs
calling  crypto_ccm_module_init+0x0/0x1a @ 1
initcall crypto_ccm_module_init+0x0/0x1a returned 0 after 0 usecs
calling  crypto_aegis128_module_init+0x0/0x15 @ 1
initcall crypto_aegis128_module_init+0x0/0x15 returned 0 after 0 usecs
calling  pcrypt_init+0x0/0xc0 @ 1
initcall pcrypt_init+0x0/0xc0 returned 0 after 7000 usecs
calling  cryptd_init+0x0/0x21e @ 1
cryptd: max_cpu_qlen set to 1000
initcall cryptd_init+0x0/0x21e returned 0 after 1000 usecs
calling  fcrypt_mod_init+0x0/0x15 @ 1
initcall fcrypt_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  blowfish_mod_init+0x0/0x15 @ 1
initcall blowfish_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  serpent_mod_init+0x0/0x15 @ 1
initcall serpent_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  aes_init+0x0/0x15 @ 1
initcall aes_init+0x0/0x15 returned 0 after 0 usecs
calling  camellia_init+0x0/0x15 @ 1
initcall camellia_init+0x0/0x15 returned 0 after 0 usecs
calling  cast5_mod_init+0x0/0x15 @ 1
initcall cast5_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  cast6_mod_init+0x0/0x15 @ 1
initcall cast6_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  chacha_generic_mod_init+0x0/0x1a @ 1
initcall chacha_generic_mod_init+0x0/0x1a returned 0 after 0 usecs
calling  deflate_mod_init+0x0/0x4c @ 1
initcall deflate_mod_init+0x0/0x4c returned 0 after 0 usecs
calling  michael_mic_init+0x0/0x15 @ 1
initcall michael_mic_init+0x0/0x15 returned 0 after 0 usecs
calling  crc32c_mod_init+0x0/0x15 @ 1
initcall crc32c_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  crc32_mod_init+0x0/0x15 @ 1
initcall crc32_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  crct10dif_mod_init+0x0/0x15 @ 1
initcall crct10dif_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_authenc_module_init+0x0/0x15 @ 1
initcall crypto_authenc_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_authenc_esn_module_init+0x0/0x15 @ 1
initcall crypto_authenc_esn_module_init+0x0/0x15 returned 0 after 0 usecs
calling  lz4hc_mod_init+0x0/0x47 @ 1
initcall lz4hc_mod_init+0x0/0x47 returned 0 after 0 usecs
calling  xxhash_mod_init+0x0/0x15 @ 1
initcall xxhash_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  prng_mod_init+0x0/0x1a @ 1
initcall prng_mod_init+0x0/0x1a returned 0 after 0 usecs
calling  drbg_init+0x0/0xe8 @ 1
initcall drbg_init+0x0/0xe8 returned 0 after 0 usecs
calling  ghash_mod_init+0x0/0x15 @ 1
initcall ghash_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  zstd_mod_init+0x0/0x47 @ 1
initcall zstd_mod_init+0x0/0x47 returned 0 after 0 usecs
calling  crypto_ofb_module_init+0x0/0x15 @ 1
initcall crypto_ofb_module_init+0x0/0x15 returned 0 after 0 usecs
calling  ecdh_init+0x0/0x71 @ 1
initcall ecdh_init+0x0/0x71 returned 0 after 0 usecs
calling  init_bio+0x0/0x119 @ 1
initcall init_bio+0x0/0x119 returned 0 after 1000 usecs
calling  blk_ioc_init+0x0/0x32 @ 1
initcall blk_ioc_init+0x0/0x32 returned 0 after 0 usecs
calling  blk_mq_init+0x0/0x17c @ 1
initcall blk_mq_init+0x0/0x17c returned 0 after 0 usecs
calling  genhd_device_init+0x0/0xa9 @ 1
initcall genhd_device_init+0x0/0xa9 returned 0 after 2000 usecs
calling  raid6_select_algo+0x0/0x2da @ 1
raid6: sse2x4   gen() 10010 MB/s
raid6: sse2x2   gen()  6958 MB/s
raid6: sse2x1   gen()  4476 MB/s
raid6: using algorithm sse2x4 gen() 10010 MB/s
raid6: .... xor() 4635 MB/s, rmw enabled
raid6: using ssse3x2 recovery algorithm
initcall raid6_select_algo+0x0/0x2da returned 0 after 70000 usecs
calling  sg_pool_init+0x0/0x1ad @ 1
initcall sg_pool_init+0x0/0x1ad returned 0 after 1000 usecs
calling  mcp23s08_i2c_init+0x0/0x17 @ 1
initcall mcp23s08_i2c_init+0x0/0x17 returned 0 after 0 usecs
calling  mcp23s08_spi_init+0x0/0x17 @ 1
initcall mcp23s08_spi_init+0x0/0x17 returned 0 after 0 usecs
calling  sx150x_init+0x0/0x17 @ 1
initcall sx150x_init+0x0/0x17 returned 0 after 0 usecs
calling  gpiolib_debugfs_init+0x0/0x2c @ 1
initcall gpiolib_debugfs_init+0x0/0x2c returned 0 after 0 usecs
calling  f7188x_gpio_init+0x0/0x137 @ 1
gpio-f7188x: Unsupported Fintek device 0xffff
gpio-f7188x: Unsupported Fintek device 0xffff
initcall f7188x_gpio_init+0x0/0x137 returned -19 after 1000 usecs
calling  max7300_init+0x0/0x17 @ 1
initcall max7300_init+0x0/0x17 returned 0 after 0 usecs
calling  max732x_init+0x0/0x17 @ 1
initcall max732x_init+0x0/0x17 returned 0 after 0 usecs
calling  mc33880_init+0x0/0x17 @ 1
initcall mc33880_init+0x0/0x17 returned 0 after 0 usecs
calling  palmas_gpio_init+0x0/0x17 @ 1
initcall palmas_gpio_init+0x0/0x17 returned 0 after 0 usecs
calling  pca953x_init+0x0/0x17 @ 1
initcall pca953x_init+0x0/0x17 returned 0 after 0 usecs
calling  wm831x_gpio_init+0x0/0x17 @ 1
initcall wm831x_gpio_init+0x0/0x17 returned 0 after 0 usecs
calling  wm8350_gpio_init+0x0/0x17 @ 1
initcall wm8350_gpio_init+0x0/0x17 returned 0 after 0 usecs
calling  wm8994_gpio_init+0x0/0x17 @ 1
initcall wm8994_gpio_init+0x0/0x17 returned 0 after 0 usecs
calling  pci_slot_init+0x0/0x40 @ 1
initcall pci_slot_init+0x0/0x40 returned 0 after 0 usecs
calling  scan_for_dmi_ipmi+0x0/0x5a @ 1
initcall scan_for_dmi_ipmi+0x0/0x5a returned 0 after 0 usecs
calling  acpi_init+0x0/0x239 @ 1
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 1 ACPI AML tables successfully acquired and loaded
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
PCI: Using E820 reservations for host bridge windows
ACPI: Enabled 2 GPEs in block 00 to 0F
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments HPX-Type3]
acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
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
pci 0000:00:01.3: calling  acpi_pm_check_blacklist+0x0/0x60 @ 1
pci 0000:00:01.3: acpi_pm_check_blacklist+0x0/0x60 took 0 usecs
pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
pci 0000:00:01.3: calling  quirk_piix4_acpi+0x0/0x1a0 @ 1
pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
pci 0000:00:01.3: quirk_piix4_acpi+0x0/0x1a0 took 1953 usecs
pci 0000:00:01.3: calling  pci_fixup_piix4_acpi+0x0/0x60 @ 1
pci 0000:00:01.3: pci_fixup_piix4_acpi+0x0/0x60 took 0 usecs
pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
pci 0000:00:02.0: calling  pci_fixup_video+0x0/0x1e0 @ 1
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:02.0: pci_fixup_video+0x0/0x1e0 took 976 usecs
pci 0000:00:03.0: calling  quirk_f0_vpd_link+0x0/0x220 @ 1
pci 0000:00:03.0: quirk_f0_vpd_link+0x0/0x220 took 0 usecs
pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000
pci 0000:00:04.0: reg 0x10: [mem 0xfebf1000-0xfebf100f]
ACPI: PCI: Interrupt link LNKA configured for IRQ 10
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKC configured for IRQ 11
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKS configured for IRQ 9
initcall acpi_init+0x0/0x239 returned 0 after 317000 usecs
calling  pnp_init+0x0/0x15 @ 1
initcall pnp_init+0x0/0x15 returned 0 after 0 usecs
calling  misc_init+0x0/0xf0 @ 1
initcall misc_init+0x0/0xf0 returned 0 after 0 usecs
calling  iommu_subsys_init+0x0/0x1ef @ 1
iommu: Default domain type: Translated 
iommu: DMA domain TLB invalidation policy: lazy mode 
initcall iommu_subsys_init+0x0/0x1ef returned 0 after 1000 usecs
calling  parport_default_proc_register+0x0/0x4b @ 1
initcall parport_default_proc_register+0x0/0x4b returned 0 after 1000 usecs
calling  pm805_i2c_init+0x0/0x17 @ 1
initcall pm805_i2c_init+0x0/0x17 returned 0 after 0 usecs
calling  wm831x_i2c_init+0x0/0x38 @ 1
initcall wm831x_i2c_init+0x0/0x38 returned 0 after 0 usecs
calling  wm831x_spi_init+0x0/0x30 @ 1
initcall wm831x_spi_init+0x0/0x30 returned 0 after 0 usecs
calling  wm8350_i2c_init+0x0/0x17 @ 1
initcall wm8350_i2c_init+0x0/0x17 returned 0 after 0 usecs
calling  tps6507x_i2c_init+0x0/0x17 @ 1
initcall tps6507x_i2c_init+0x0/0x17 returned 0 after 0 usecs
calling  mc13xxx_init+0x0/0x17 @ 1
initcall mc13xxx_init+0x0/0x17 returned 0 after 0 usecs
calling  mc13xxx_i2c_init+0x0/0x17 @ 1
initcall mc13xxx_i2c_init+0x0/0x17 returned 0 after 0 usecs
calling  max8907_i2c_init+0x0/0x38 @ 1
initcall max8907_i2c_init+0x0/0x38 returned 0 after 0 usecs
calling  max8997_i2c_init+0x0/0x17 @ 1
initcall max8997_i2c_init+0x0/0x17 returned 0 after 0 usecs
calling  aat2870_init+0x0/0x17 @ 1
initcall aat2870_init+0x0/0x17 returned 0 after 0 usecs
calling  palmas_i2c_init+0x0/0x17 @ 1
initcall palmas_i2c_init+0x0/0x17 returned 0 after 0 usecs
calling  lm3533_i2c_init+0x0/0x17 @ 1
initcall lm3533_i2c_init+0x0/0x17 returned 0 after 0 usecs
calling  as3711_i2c_init+0x0/0x17 @ 1
initcall as3711_i2c_init+0x0/0x17 returned 0 after 0 usecs
calling  dax_core_init+0x0/0x10f @ 1
initcall dax_core_init+0x0/0x10f returned 0 after 1000 usecs
calling  dma_buf_init+0x0/0xe9 @ 1
initcall dma_buf_init+0x0/0xe9 returned 0 after 1000 usecs
calling  dma_resv_lockdep+0x0/0x4ed @ 1
initcall dma_resv_lockdep+0x0/0x4ed returned 0 after 0 usecs
calling  dma_heap_init+0x0/0xe0 @ 1
initcall dma_heap_init+0x0/0xe0 returned 0 after 0 usecs
calling  init_scsi+0x0/0x8b @ 1
SCSI subsystem initialized
initcall init_scsi+0x0/0x8b returned 0 after 2000 usecs
calling  phy_init+0x0/0x6d @ 1
initcall phy_init+0x0/0x6d returned 0 after 0 usecs
calling  xdbc_init+0x0/0x179 @ 1
initcall xdbc_init+0x0/0x179 returned 0 after 0 usecs
calling  serio_init+0x0/0x36 @ 1
initcall serio_init+0x0/0x36 returned 0 after 0 usecs
calling  gameport_init+0x0/0x36 @ 1
initcall gameport_init+0x0/0x36 returned 0 after 0 usecs
calling  input_init+0x0/0x10c @ 1
initcall input_init+0x0/0x10c returned 0 after 0 usecs
calling  tca6416_keypad_init+0x0/0x17 @ 1
initcall tca6416_keypad_init+0x0/0x17 returned 0 after 0 usecs
calling  tca8418_keypad_init+0x0/0x17 @ 1
initcall tca8418_keypad_init+0x0/0x17 returned 0 after 0 usecs
calling  rtc_init+0x0/0x98 @ 1
initcall rtc_init+0x0/0x98 returned 0 after 0 usecs
calling  dw_i2c_init_driver+0x0/0x17 @ 1
initcall dw_i2c_init_driver+0x0/0x17 returned 0 after 0 usecs
calling  i2c_gpio_init+0x0/0x38 @ 1
initcall i2c_gpio_init+0x0/0x38 returned 0 after 0 usecs
calling  i3c_init+0x0/0x55 @ 1
initcall i3c_init+0x0/0x55 returned 0 after 0 usecs
calling  media_devnode_init+0x0/0x85 @ 1
mc: Linux media interface: v0.10
initcall media_devnode_init+0x0/0x85 returned 0 after 1000 usecs
calling  v4l2_async_init+0x0/0x42 @ 1
initcall v4l2_async_init+0x0/0x42 returned 0 after 0 usecs
calling  videodev_init+0x0/0x8c @ 1
videodev: Linux video capture interface: v2.00
initcall videodev_init+0x0/0x8c returned 0 after 1000 usecs
calling  rc_core_init+0x0/0x55 @ 1
initcall rc_core_init+0x0/0x55 returned 0 after 0 usecs
calling  cec_devnode_init+0x0/0xb1 @ 1
initcall cec_devnode_init+0x0/0xb1 returned 0 after 0 usecs
calling  pps_init+0x0/0xe7 @ 1
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
initcall pps_init+0x0/0xe7 returned 0 after 2000 usecs
calling  ptp_init+0x0/0xcc @ 1
PTP clock support registered
initcall ptp_init+0x0/0xcc returned 0 after 0 usecs
calling  power_supply_class_init+0x0/0x78 @ 1
initcall power_supply_class_init+0x0/0x78 returned 0 after 0 usecs
calling  hwmon_init+0x0/0x15b @ 1
initcall hwmon_init+0x0/0x15b returned 0 after 0 usecs
calling  leds_init+0x0/0x93 @ 1
initcall leds_init+0x0/0x93 returned 0 after 0 usecs
calling  dmi_init+0x0/0x14a @ 1
initcall dmi_init+0x0/0x14a returned 0 after 0 usecs
calling  fieldbus_init+0x0/0x7b @ 1
initcall fieldbus_init+0x0/0x7b returned 0 after 0 usecs
calling  remoteproc_init+0x0/0x79 @ 1
initcall remoteproc_init+0x0/0x79 returned 0 after 0 usecs
calling  devfreq_init+0x0/0x100 @ 1
initcall devfreq_init+0x0/0x100 returned 0 after 1000 usecs
calling  devfreq_event_init+0x0/0x83 @ 1
initcall devfreq_event_init+0x0/0x83 returned 0 after 0 usecs
calling  devfreq_performance_init+0x0/0x15 @ 1
initcall devfreq_performance_init+0x0/0x15 returned 0 after 0 usecs
calling  devfreq_userspace_init+0x0/0x15 @ 1
initcall devfreq_userspace_init+0x0/0x15 returned 0 after 0 usecs
calling  devfreq_passive_init+0x0/0x15 @ 1
initcall devfreq_passive_init+0x0/0x15 returned 0 after 0 usecs
calling  fsa9480_module_init+0x0/0x17 @ 1
initcall fsa9480_module_init+0x0/0x17 returned 0 after 0 usecs
calling  nvmem_init+0x0/0x15 @ 1
initcall nvmem_init+0x0/0x15 returned 0 after 0 usecs
calling  fpga_mgr_class_init+0x0/0x9f @ 1
FPGA manager framework
initcall fpga_mgr_class_init+0x0/0x9f returned 0 after 1000 usecs
calling  fpga_bridge_dev_init+0x0/0x93 @ 1
initcall fpga_bridge_dev_init+0x0/0x93 returned 0 after 0 usecs
calling  fpga_region_init+0x0/0x93 @ 1
initcall fpga_region_init+0x0/0x93 returned 0 after 0 usecs
calling  mux_init+0x0/0x50 @ 1
initcall mux_init+0x0/0x50 returned 0 after 0 usecs
calling  siox_init+0x0/0x3f @ 1
initcall siox_init+0x0/0x3f returned 0 after 0 usecs
calling  most_init+0x0/0xb2 @ 1
initcall most_init+0x0/0xb2 returned 0 after 0 usecs
calling  proto_init+0x0/0x15 @ 1
initcall proto_init+0x0/0x15 returned 0 after 0 usecs
calling  net_dev_init+0x0/0x656 @ 1
initcall net_dev_init+0x0/0x656 returned 0 after 2000 usecs
calling  neigh_init+0x0/0x8d @ 1
initcall neigh_init+0x0/0x8d returned 0 after 0 usecs
calling  fib_notifier_init+0x0/0x15 @ 1
initcall fib_notifier_init+0x0/0x15 returned 0 after 0 usecs
calling  ethnl_init+0x0/0xb9 @ 1
initcall ethnl_init+0x0/0xb9 returned 0 after 0 usecs
calling  nexthop_init+0x0/0xfe @ 1
initcall nexthop_init+0x0/0xfe returned 0 after 0 usecs
calling  pci_subsys_init+0x0/0x12c @ 1
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]
initcall pci_subsys_init+0x0/0x12c returned 0 after 3000 usecs
calling  vsprintf_init_hashval+0x0/0x17 @ 1
initcall vsprintf_init_hashval+0x0/0x17 returned 0 after 0 usecs
calling  vga_arb_device_init+0x0/0x7f @ 1
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: bridge control possible
pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
initcall vga_arb_device_init+0x0/0x7f returned 0 after 3000 usecs
calling  nmi_warning_debugfs+0x0/0x55 @ 1
initcall nmi_warning_debugfs+0x0/0x55 returned 0 after 0 usecs
calling  save_microcode_in_initrd+0x0/0x91 @ 1
initcall save_microcode_in_initrd+0x0/0x91 returned -22 after 0 usecs
calling  hpet_late_init+0x0/0xf1 @ 1
initcall hpet_late_init+0x0/0xf1 returned 0 after 0 usecs
calling  iomem_init_inode+0x0/0xd0 @ 1
initcall iomem_init_inode+0x0/0xd0 returned 0 after 1000 usecs
calling  clocksource_done_booting+0x0/0x4c @ 1
clocksource: Switched to clocksource kvm-clock
initcall clocksource_done_booting+0x0/0x4c returned 0 after 1911 usecs
calling  tracer_init_tracefs+0x0/0x184 @ 1
initcall tracer_init_tracefs+0x0/0x184 returned 0 after 107 usecs
calling  init_trace_printk_function_export+0x0/0x30 @ 1
initcall init_trace_printk_function_export+0x0/0x30 returned 0 after 145 usecs
calling  init_annotated_branch_stats+0x0/0x30 @ 1
Warning: could not register annotated branches stats
initcall init_annotated_branch_stats+0x0/0x30 returned 1 after 1161 usecs
calling  trace_events_synth_init+0x0/0x4f @ 1
initcall trace_events_synth_init+0x0/0x4f returned 0 after 93 usecs
calling  init_kprobe_trace+0x0/0x316 @ 1
initcall init_kprobe_trace+0x0/0x316 returned 0 after 297689 usecs
calling  init_dynamic_event+0x0/0x30 @ 1
initcall init_dynamic_event+0x0/0x30 returned 0 after 291 usecs
calling  secretmem_init+0x0/0x74 @ 1
initcall secretmem_init+0x0/0x74 returned 0 after 1 usecs
calling  init_fs_stat_sysctls+0x0/0x2a @ 1
initcall init_fs_stat_sysctls+0x0/0x2a returned 0 after 24 usecs
calling  init_fs_exec_sysctls+0x0/0x2a @ 1
initcall init_fs_exec_sysctls+0x0/0x2a returned 0 after 22 usecs
calling  init_pipe_fs+0x0/0x74 @ 1
initcall init_pipe_fs+0x0/0x74 returned 0 after 439 usecs
calling  init_fs_namei_sysctls+0x0/0x2a @ 1
initcall init_fs_namei_sysctls+0x0/0x2a returned 0 after 24 usecs
calling  init_fs_dcache_sysctls+0x0/0x2a @ 1
initcall init_fs_dcache_sysctls+0x0/0x2a returned 0 after 26 usecs
calling  init_fs_namespace_sysctls+0x0/0x2a @ 1
initcall init_fs_namespace_sysctls+0x0/0x2a returned 0 after 22 usecs
calling  inotify_user_setup+0x0/0x167 @ 1
initcall inotify_user_setup+0x0/0x167 returned 0 after 110 usecs
calling  eventpoll_init+0x0/0x133 @ 1
initcall eventpoll_init+0x0/0x133 returned 0 after 181 usecs
calling  anon_inode_init+0x0/0xa2 @ 1
initcall anon_inode_init+0x0/0xa2 returned 0 after 365 usecs
calling  init_dax_wait_table+0x0/0x3c @ 1
initcall init_dax_wait_table+0x0/0x3c returned 0 after 280 usecs
calling  proc_locks_init+0x0/0x30 @ 1
initcall proc_locks_init+0x0/0x30 returned 0 after 19 usecs
calling  iomap_init+0x0/0x24 @ 1
initcall iomap_init+0x0/0x24 returned 0 after 969 usecs
calling  dquot_init+0x0/0x16b @ 1
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
initcall dquot_init+0x0/0x16b returned 0 after 1929 usecs
calling  proc_cmdline_init+0x0/0x97 @ 1
initcall proc_cmdline_init+0x0/0x97 returned 0 after 18 usecs
calling  proc_consoles_init+0x0/0x2d @ 1
initcall proc_consoles_init+0x0/0x2d returned 0 after 19 usecs
calling  proc_cpuinfo_init+0x0/0x27 @ 1
initcall proc_cpuinfo_init+0x0/0x27 returned 0 after 16 usecs
calling  proc_devices_init+0x0/0x66 @ 1
initcall proc_devices_init+0x0/0x66 returned 0 after 58 usecs
calling  proc_interrupts_init+0x0/0x2d @ 1
initcall proc_interrupts_init+0x0/0x2d returned 0 after 21 usecs
calling  proc_loadavg_init+0x0/0x63 @ 1
initcall proc_loadavg_init+0x0/0x63 returned 0 after 19 usecs
calling  proc_meminfo_init+0x0/0x63 @ 1
initcall proc_meminfo_init+0x0/0x63 returned 0 after 20 usecs
calling  proc_stat_init+0x0/0x27 @ 1
initcall proc_stat_init+0x0/0x27 returned 0 after 15 usecs
calling  proc_uptime_init+0x0/0x63 @ 1
initcall proc_uptime_init+0x0/0x63 returned 0 after 22 usecs
calling  proc_version_init+0x0/0x63 @ 1
initcall proc_version_init+0x0/0x63 returned 0 after 20 usecs
calling  proc_softirqs_init+0x0/0x63 @ 1
initcall proc_softirqs_init+0x0/0x63 returned 0 after 20 usecs
calling  proc_kcore_init+0x0/0x14a @ 1
initcall proc_kcore_init+0x0/0x14a returned 0 after 160 usecs
calling  vmcore_init+0x0/0x2d1 @ 1
initcall vmcore_init+0x0/0x2d1 returned 0 after 2 usecs
calling  proc_kmsg_init+0x0/0x2a @ 1
initcall proc_kmsg_init+0x0/0x2a returned 0 after 28 usecs
calling  proc_page_init+0x0/0x5e @ 1
initcall proc_page_init+0x0/0x5e returned 0 after 85 usecs
calling  proc_boot_config_init+0x0/0x8b @ 1
initcall proc_boot_config_init+0x0/0x8b returned 0 after 38 usecs
calling  init_ramfs_fs+0x0/0x15 @ 1
initcall init_ramfs_fs+0x0/0x15 returned 0 after 7 usecs
calling  init_hugetlbfs_fs+0x0/0x2b0 @ 1
initcall init_hugetlbfs_fs+0x0/0x2b0 returned 0 after 602 usecs
calling  aa_create_aafs+0x0/0x7e8 @ 1
initcall aa_create_aafs+0x0/0x7e8 returned 0 after 2 usecs
calling  dynamic_debug_init_control+0x0/0x84 @ 1
initcall dynamic_debug_init_control+0x0/0x84 returned 0 after 131 usecs
calling  acpi_event_init+0x0/0x69 @ 1
initcall acpi_event_init+0x0/0x69 returned 0 after 189 usecs
calling  pnp_system_init+0x0/0x15 @ 1
initcall pnp_system_init+0x0/0x15 returned 0 after 122 usecs
calling  pnpacpi_init+0x0/0xda @ 1
pnp: PnP ACPI init
pnp 00:02: [dma 2]
pnp: PnP ACPI: found 7 devices
initcall pnpacpi_init+0x0/0xda returned 0 after 11277 usecs
calling  chr_dev_init+0x0/0x15f @ 1
initcall chr_dev_init+0x0/0x15f returned 0 after 7353 usecs
calling  hwrng_modinit+0x0/0x124 @ 1
initcall hwrng_modinit+0x0/0x124 returned 0 after 674 usecs
calling  firmware_class_init+0x0/0x54 @ 1
initcall firmware_class_init+0x0/0x54 returned 0 after 6 usecs
calling  init_acpi_pm_clocksource+0x0/0xe4 @ 1
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
initcall init_acpi_pm_clocksource+0x0/0xe4 returned 0 after 5945 usecs
calling  ssb_modinit+0x0/0x5b @ 1
initcall ssb_modinit+0x0/0x5b returned 0 after 331 usecs
calling  bcma_init_bus_register+0x0/0x33 @ 1
initcall bcma_init_bus_register+0x0/0x33 returned 0 after 141 usecs
calling  powercap_init+0x0/0x2a @ 1
initcall powercap_init+0x0/0x2a returned 0 after 433 usecs
calling  mcb_init+0x0/0x20 @ 1
initcall mcb_init+0x0/0x20 returned 0 after 179 usecs
calling  sysctl_core_init+0x0/0x2f @ 1
initcall sysctl_core_init+0x0/0x2f returned 0 after 179 usecs
calling  eth_offload_init+0x0/0x1c @ 1
initcall eth_offload_init+0x0/0x1c returned 0 after 58 usecs
calling  ipv4_offload_init+0x0/0x7c @ 1
initcall ipv4_offload_init+0x0/0x7c returned 0 after 5 usecs
calling  inet_init+0x0/0x2ef @ 1
NET: Registered PF_INET protocol family
IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 8192 (order: 7, 655360 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
TCP bind hash table entries: 65536 (order: 11, 10485760 bytes, vmalloc hugepage)
TCP: Hash tables configured (established 131072 bind 65536)
MPTCP token hash table entries: 16384 (order: 8, 1572864 bytes, linear)
UDP hash table entries: 8192 (order: 8, 1572864 bytes, linear)
UDP-Lite hash table entries: 8192 (order: 8, 1572864 bytes, linear)
initcall inet_init+0x0/0x2ef returned 0 after 44828 usecs
calling  af_unix_init+0x0/0x136 @ 1
NET: Registered PF_UNIX/PF_LOCAL protocol family
initcall af_unix_init+0x0/0x136 returned 0 after 1366 usecs
calling  ipv6_offload_init+0x0/0x87 @ 1
initcall ipv6_offload_init+0x0/0x87 returned 0 after 6 usecs
calling  init_sunrpc+0x0/0x86 @ 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
initcall init_sunrpc+0x0/0x86 returned 0 after 7773 usecs
calling  pcibios_assign_resources+0x0/0x23e @ 1
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
pci_bus 0000:00: resource 8 [mem 0x440000000-0x4bfffffff window]
initcall pcibios_assign_resources+0x0/0x23e returned 0 after 5717 usecs
calling  pci_apply_final_quirks+0x0/0x311 @ 1
pci 0000:00:00.0: calling  quirk_passive_release+0x0/0xb0 @ 1
pci 0000:00:01.0: PIIX3: Enabling Passive Release
pci 0000:00:00.0: quirk_passive_release+0x0/0xb0 took 868 usecs
pci 0000:00:00.0: calling  quirk_natoma+0x0/0x60 @ 1
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
pci 0000:00:00.0: quirk_natoma+0x0/0x60 took 832 usecs
pci 0000:00:03.0: calling  quirk_e100_interrupt+0x0/0x270 @ 1
pci 0000:00:03.0: quirk_e100_interrupt+0x0/0x270 took 1 usecs
PCI: CLS 0 bytes, default 64
initcall pci_apply_final_quirks+0x0/0x311 returned 0 after 12478 usecs
calling  acpi_reserve_resources+0x0/0x27b @ 1
initcall acpi_reserve_resources+0x0/0x27b returned 0 after 134 usecs
calling  populate_rootfs+0x0/0x44 @ 1
Unpacking initramfs...
Freeing initrd memory: 109964K
initcall populate_rootfs+0x0/0x44 returned 0 after 9296060 usecs
calling  pci_iommu_init+0x0/0x60 @ 1
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x00000000bbfe0000-0x00000000bffe0000] (64MB)
initcall pci_iommu_init+0x0/0x60 returned 0 after 2272 usecs
calling  nhi_init+0x0/0x42 @ 1
ACPI: bus type thunderbolt registered
initcall nhi_init+0x0/0x42 returned 0 after 1331 usecs
calling  ia32_binfmt_init+0x0/0x1c @ 1
initcall ia32_binfmt_init+0x0/0x1c returned 0 after 47 usecs
calling  rapl_pmu_init+0x0/0x12e @ 1
RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
initcall rapl_pmu_init+0x0/0x12e returned 0 after 1584 usecs
calling  amd_ibs_init+0x0/0xfe @ 1
initcall amd_ibs_init+0x0/0xfe returned -19 after 1 usecs
calling  msr_init+0x0/0x84 @ 1
initcall msr_init+0x0/0x84 returned 0 after 48 usecs
calling  intel_uncore_init+0x0/0x34d @ 1
initcall intel_uncore_init+0x0/0x34d returned -19 after 1 usecs
calling  cstate_pmu_init+0x0/0x25a @ 1
initcall cstate_pmu_init+0x0/0x25a returned -19 after 2 usecs
calling  register_kernel_offset_dumper+0x0/0x23 @ 1
initcall register_kernel_offset_dumper+0x0/0x23 returned 0 after 4 usecs
calling  i8259A_init_ops+0x0/0x29 @ 1
initcall i8259A_init_ops+0x0/0x29 returned 0 after 7 usecs
calling  init_tsc_clocksource+0x0/0xea @ 1
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2c9475bb8da, max_idle_ns: 440795307408 ns
initcall init_tsc_clocksource+0x0/0xea returned 0 after 1269 usecs
calling  add_rtc_cmos+0x0/0x1f8 @ 1
initcall add_rtc_cmos+0x0/0x1f8 returned 0 after 7 usecs
calling  i8237A_init_ops+0x0/0x43 @ 1
initcall i8237A_init_ops+0x0/0x43 returned 0 after 22 usecs
calling  umwait_init+0x0/0xe5 @ 1
initcall umwait_init+0x0/0xe5 returned -19 after 2 usecs
calling  inject_init+0x0/0x168 @ 1
mce: Machine check injector initialized
initcall inject_init+0x0/0x168 returned 0 after 1221 usecs
calling  msr_init+0x0/0x129 @ 1
initcall msr_init+0x0/0x129 returned 0 after 5159 usecs
calling  cpuid_init+0x0/0x129 @ 1
initcall cpuid_init+0x0/0x129 returned 0 after 1736 usecs
calling  ioapic_init_ops+0x0/0x1c @ 1
initcall ioapic_init_ops+0x0/0x1c returned 0 after 6 usecs
calling  add_pcspkr+0x0/0xd5 @ 1
initcall add_pcspkr+0x0/0xd5 returned 0 after 523 usecs
calling  audit_classes_init+0x0/0xb7 @ 1
initcall audit_classes_init+0x0/0xb7 returned 0 after 98 usecs
calling  pt_dump_init+0x0/0x191 @ 1
initcall pt_dump_init+0x0/0x191 returned 0 after 2 usecs
calling  serpent_init+0x0/0xa6 @ 1
initcall serpent_init+0x0/0xa6 returned 0 after 106 usecs
calling  des3_ede_x86_init+0x0/0xd9 @ 1
initcall des3_ede_x86_init+0x0/0xd9 returned 0 after 25 usecs
calling  camellia_init+0x0/0xd9 @ 1
initcall camellia_init+0x0/0xd9 returned 0 after 24 usecs
calling  camellia_aesni_init+0x0/0xfe @ 1
initcall camellia_aesni_init+0x0/0xfe returned 0 after 93 usecs
calling  camellia_aesni_init+0x0/0x135 @ 1
AVX2 or AES-NI instructions are not detected.
initcall camellia_aesni_init+0x0/0x135 returned -19 after 803 usecs
calling  blowfish_init+0x0/0xd9 @ 1
initcall blowfish_init+0x0/0xd9 returned 0 after 28 usecs
calling  cast5_init+0x0/0xa6 @ 1
initcall cast5_init+0x0/0xa6 returned 0 after 89 usecs
calling  cast6_init+0x0/0xa6 @ 1
initcall cast6_init+0x0/0xa6 returned 0 after 82 usecs
calling  chacha_simd_mod_init+0x0/0x137 @ 1
initcall chacha_simd_mod_init+0x0/0x137 returned 0 after 266 usecs
calling  sha1_ssse3_mod_init+0x0/0xf3 @ 1
initcall sha1_ssse3_mod_init+0x0/0xf3 returned 0 after 23 usecs
calling  sha256_ssse3_mod_init+0x0/0x107 @ 1
initcall sha256_ssse3_mod_init+0x0/0x107 returned 0 after 39 usecs
calling  ghash_pclmulqdqni_mod_init+0x0/0x5e @ 1
initcall ghash_pclmulqdqni_mod_init+0x0/0x5e returned 0 after 20 usecs
calling  crc32c_intel_mod_init+0x0/0x82 @ 1
initcall crc32c_intel_mod_init+0x0/0x82 returned 0 after 14 usecs
calling  crct10dif_intel_mod_init+0x0/0x30 @ 1
initcall crct10dif_intel_mod_init+0x0/0x30 returned 0 after 14 usecs
calling  nhpoly1305_mod_init+0x0/0x15 @ 1
initcall nhpoly1305_mod_init+0x0/0x15 returned 0 after 15 usecs
calling  proc_execdomains_init+0x0/0x2a @ 1
initcall proc_execdomains_init+0x0/0x2a returned 0 after 42 usecs
calling  register_warn_debugfs+0x0/0x2c @ 1
initcall register_warn_debugfs+0x0/0x2c returned 0 after 72 usecs
calling  cpuhp_sysfs_init+0x0/0x148 @ 1
initcall cpuhp_sysfs_init+0x0/0x148 returned 0 after 211 usecs
calling  ioresources_init+0x0/0x52 @ 1
initcall ioresources_init+0x0/0x52 returned 0 after 41 usecs
calling  psi_proc_init+0x0/0x75 @ 1
initcall psi_proc_init+0x0/0x75 returned 0 after 2 usecs
calling  lockdep_proc_init+0x0/0x82 @ 1
initcall lockdep_proc_init+0x0/0x82 returned 0 after 3495 usecs
calling  irq_debugfs_init+0x0/0xb8 @ 1
initcall irq_debugfs_init+0x0/0xb8 returned 0 after 982 usecs
calling  klp_init+0x0/0x57 @ 1
initcall klp_init+0x0/0x57 returned 0 after 58 usecs
calling  proc_modules_init+0x0/0x27 @ 1
initcall proc_modules_init+0x0/0x27 returned 0 after 71 usecs
calling  timer_sysctl_init+0x0/0x23 @ 1
initcall timer_sysctl_init+0x0/0x23 returned 0 after 29 usecs
calling  timekeeping_init_ops+0x0/0x1c @ 1
initcall timekeeping_init_ops+0x0/0x1c returned 0 after 62 usecs
calling  init_clocksource_sysfs+0x0/0x2c @ 1
initcall init_clocksource_sysfs+0x0/0x2c returned 0 after 781 usecs
calling  init_timer_list_procfs+0x0/0x3a @ 1
initcall init_timer_list_procfs+0x0/0x3a returned 0 after 59 usecs
calling  alarmtimer_init+0x0/0x137 @ 1
initcall alarmtimer_init+0x0/0x137 returned 0 after 270 usecs
calling  init_posix_timers+0x0/0x32 @ 1
initcall init_posix_timers+0x0/0x32 returned 0 after 96 usecs
calling  clockevents_init_sysfs+0x0/0x25 @ 1
initcall clockevents_init_sysfs+0x0/0x25 returned 0 after 1167 usecs
calling  proc_dma_init+0x0/0x2a @ 1
initcall proc_dma_init+0x0/0x2a returned 0 after 25 usecs
calling  kallsyms_init+0x0/0x2a @ 1
initcall kallsyms_init+0x0/0x2a returned 0 after 24 usecs
calling  ikconfig_init+0x0/0x4a @ 1
initcall ikconfig_init+0x0/0x4a returned 0 after 21 usecs
calling  ikheaders_init+0x0/0x56 @ 1
initcall ikheaders_init+0x0/0x56 returned 0 after 72 usecs
calling  audit_watch_init+0x0/0x48 @ 1
initcall audit_watch_init+0x0/0x48 returned 0 after 16 usecs
calling  audit_fsnotify_init+0x0/0x4b @ 1
initcall audit_fsnotify_init+0x0/0x4b returned 0 after 14 usecs
calling  audit_tree_init+0x0/0xd7 @ 1
initcall audit_tree_init+0x0/0xd7 returned 0 after 184 usecs
calling  kcov_init+0x0/0x8b @ 1
initcall kcov_init+0x0/0x8b returned 0 after 13149 usecs
calling  utsname_sysctl_init+0x0/0x1c @ 1
initcall utsname_sysctl_init+0x0/0x1c returned 0 after 52 usecs
calling  init_tracepoints+0x0/0x34 @ 1
initcall init_tracepoints+0x0/0x34 returned 0 after 7 usecs
calling  init_lstats_procfs+0x0/0x44 @ 1
initcall init_lstats_procfs+0x0/0x44 returned 0 after 51 usecs
calling  stack_trace_init+0x0/0xac @ 1
initcall stack_trace_init+0x0/0xac returned 0 after 131 usecs
calling  perf_event_sysfs_init+0x0/0x148 @ 1
initcall perf_event_sysfs_init+0x0/0x148 returned 0 after 2127 usecs
calling  kswapd_init+0x0/0x65 @ 1
initcall kswapd_init+0x0/0x65 returned 0 after 975 usecs
calling  extfrag_debug_init+0x0/0x5f @ 1
initcall extfrag_debug_init+0x0/0x5f returned 0 after 133 usecs
calling  mm_compute_batch_init+0x0/0x5b @ 1
initcall mm_compute_batch_init+0x0/0x5b returned 0 after 8 usecs
calling  slab_proc_init+0x0/0x2a @ 1
initcall slab_proc_init+0x0/0x2a returned 0 after 32 usecs
calling  workingset_init+0x0/0xd8 @ 1
workingset: timestamp_bits=40 max_order=22 bucket_order=0
initcall workingset_init+0x0/0xd8 returned 0 after 1070 usecs
calling  proc_vmalloc_init+0x0/0x6c @ 1
initcall proc_vmalloc_init+0x0/0x6c returned 0 after 28 usecs
calling  slab_debugfs_init+0x0/0x56 @ 1
initcall slab_debugfs_init+0x0/0x56 returned 0 after 79 usecs
calling  fcntl_init+0x0/0x32 @ 1
initcall fcntl_init+0x0/0x32 returned 0 after 96 usecs
calling  proc_filesystems_init+0x0/0x2a @ 1
initcall proc_filesystems_init+0x0/0x2a returned 0 after 29 usecs
calling  start_dirtytime_writeback+0x0/0x1f @ 1
initcall start_dirtytime_writeback+0x0/0x1f returned 0 after 12 usecs
calling  dio_init+0x0/0x35 @ 1
initcall dio_init+0x0/0x35 returned 0 after 105 usecs
calling  dnotify_init+0x0/0xc7 @ 1
initcall dnotify_init+0x0/0xc7 returned 0 after 262 usecs
calling  mbcache_init+0x0/0x39 @ 1
initcall mbcache_init+0x0/0x39 returned 0 after 67 usecs
calling  init_grace+0x0/0x15 @ 1
initcall init_grace+0x0/0x15 returned 0 after 24 usecs
calling  init_v2_quota_format+0x0/0x2a @ 1
initcall init_v2_quota_format+0x0/0x2a returned 0 after 67 usecs
calling  init_devpts_fs+0x0/0x34 @ 1
initcall init_devpts_fs+0x0/0x34 returned 0 after 74 usecs
calling  ext4_init_fs+0x0/0x1a7 @ 1
initcall ext4_init_fs+0x0/0x1a7 returned 0 after 1792 usecs
calling  init_ext2_fs+0x0/0x72 @ 1
initcall init_ext2_fs+0x0/0x72 returned 0 after 62 usecs
calling  journal_init+0x0/0x3d @ 1
initcall journal_init+0x0/0x3d returned 0 after 339 usecs
calling  init_fat_fs+0x0/0x57 @ 1
initcall init_fat_fs+0x0/0x57 returned 0 after 90 usecs
calling  init_vfat_fs+0x0/0x15 @ 1
initcall init_vfat_fs+0x0/0x15 returned 0 after 8 usecs
calling  init_msdos_fs+0x0/0x15 @ 1
initcall init_msdos_fs+0x0/0x15 returned 0 after 6 usecs
calling  init_nfs_fs+0x0/0x150 @ 1
initcall init_nfs_fs+0x0/0x150 returned 0 after 17600 usecs
calling  init_nfs_v2+0x0/0x1c @ 1
initcall init_nfs_v2+0x0/0x1c returned 0 after 54 usecs
calling  init_nfs_v3+0x0/0x1c @ 1
initcall init_nfs_v3+0x0/0x1c returned 0 after 4 usecs
calling  init_nlm+0x0/0x6a @ 1
initcall init_nlm+0x0/0x6a returned 0 after 96 usecs
calling  init_nls_cp437+0x0/0x17 @ 1
initcall init_nls_cp437+0x0/0x17 returned 0 after 52 usecs
calling  init_nls_cp850+0x0/0x17 @ 1
initcall init_nls_cp850+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_cp855+0x0/0x17 @ 1
initcall init_nls_cp855+0x0/0x17 returned 0 after 3 usecs
calling  init_nls_cp857+0x0/0x17 @ 1
initcall init_nls_cp857+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_cp860+0x0/0x17 @ 1
initcall init_nls_cp860+0x0/0x17 returned 0 after 3 usecs
calling  init_nls_cp861+0x0/0x17 @ 1
initcall init_nls_cp861+0x0/0x17 returned 0 after 3 usecs
calling  init_nls_cp862+0x0/0x17 @ 1
initcall init_nls_cp862+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_cp864+0x0/0x17 @ 1
initcall init_nls_cp864+0x0/0x17 returned 0 after 3 usecs
calling  init_nls_cp865+0x0/0x17 @ 1
initcall init_nls_cp865+0x0/0x17 returned 0 after 3 usecs
calling  init_nls_cp866+0x0/0x17 @ 1
initcall init_nls_cp866+0x0/0x17 returned 0 after 3 usecs
calling  init_nls_cp869+0x0/0x17 @ 1
initcall init_nls_cp869+0x0/0x17 returned 0 after 3 usecs
calling  init_nls_cp932+0x0/0x17 @ 1
initcall init_nls_cp932+0x0/0x17 returned 0 after 3 usecs
calling  init_nls_euc_jp+0x0/0x93 @ 1
initcall init_nls_euc_jp+0x0/0x93 returned 0 after 5 usecs
calling  init_nls_cp936+0x0/0x17 @ 1
initcall init_nls_cp936+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_cp1250+0x0/0x17 @ 1
initcall init_nls_cp1250+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_ascii+0x0/0x17 @ 1
initcall init_nls_ascii+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_iso8859_2+0x0/0x17 @ 1
initcall init_nls_iso8859_2+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_iso8859_4+0x0/0x17 @ 1
initcall init_nls_iso8859_4+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_iso8859_5+0x0/0x17 @ 1
initcall init_nls_iso8859_5+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_iso8859_6+0x0/0x17 @ 1
initcall init_nls_iso8859_6+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_iso8859_7+0x0/0x17 @ 1
initcall init_nls_iso8859_7+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_cp1255+0x0/0x17 @ 1
initcall init_nls_cp1255+0x0/0x17 returned 0 after 5 usecs
calling  init_nls_iso8859_15+0x0/0x17 @ 1
initcall init_nls_iso8859_15+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_koi8_r+0x0/0x17 @ 1
initcall init_nls_koi8_r+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_koi8_u+0x0/0x17 @ 1
initcall init_nls_koi8_u+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_koi8_ru+0x0/0x93 @ 1
initcall init_nls_koi8_ru+0x0/0x93 returned 0 after 5 usecs
calling  init_nls_utf8+0x0/0x7c @ 1
initcall init_nls_utf8+0x0/0x7c returned 0 after 78 usecs
calling  init_nls_macceltic+0x0/0x17 @ 1
initcall init_nls_macceltic+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_maccenteuro+0x0/0x17 @ 1
initcall init_nls_maccenteuro+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_maccyrillic+0x0/0x17 @ 1
initcall init_nls_maccyrillic+0x0/0x17 returned 0 after 4 usecs
calling  init_nls_macinuit+0x0/0x17 @ 1
initcall init_nls_macinuit+0x0/0x17 returned 0 after 5 usecs
calling  init_ntfs_fs+0x0/0x241 @ 1
ntfs: driver 2.1.32 [Flags: R/O DEBUG].
initcall init_ntfs_fs+0x0/0x241 returned 0 after 1157 usecs
calling  init_autofs_fs+0x0/0x32 @ 1
initcall init_autofs_fs+0x0/0x32 returned 0 after 806 usecs
calling  ovl_init+0x0/0x76 @ 1
initcall ovl_init+0x0/0x76 returned 0 after 142 usecs
calling  init_jfs_fs+0x0/0x30b @ 1
JFS: nTxBlock = 8192, nTxLock = 65536
initcall init_jfs_fs+0x0/0x30b returned 0 after 28378 usecs
calling  init_f2fs_fs+0x0/0x194 @ 1
initcall init_f2fs_fs+0x0/0x194 returned 0 after 7370 usecs
calling  ipc_init+0x0/0x2d @ 1
initcall ipc_init+0x0/0x2d returned 0 after 137 usecs
calling  ipc_sysctl_init+0x0/0x35 @ 1
initcall ipc_sysctl_init+0x0/0x35 returned 0 after 112 usecs
calling  key_proc_init+0x0/0x76 @ 1
initcall key_proc_init+0x0/0x76 returned 0 after 2763 usecs
calling  aes_init+0x0/0x15 @ 1
initcall aes_init+0x0/0x15 returned 0 after 25 usecs
calling  crc64_rocksoft_init+0x0/0x15 @ 1
initcall crc64_rocksoft_init+0x0/0x15 returned 0 after 21 usecs
calling  jent_mod_init+0x0/0x36 @ 1
initcall jent_mod_init+0x0/0x36 returned 0 after 9026 usecs
calling  ecrdsa_mod_init+0x0/0x15 @ 1
initcall ecrdsa_mod_init+0x0/0x15 returned 0 after 23 usecs
calling  calibrate_xor_blocks+0x0/0x201 @ 1
xor: automatically using best checksumming function   avx       
initcall calibrate_xor_blocks+0x0/0x201 returned 0 after 1037 usecs
calling  blkdev_init+0x0/0x24 @ 1
initcall blkdev_init+0x0/0x24 returned 0 after 136 usecs
calling  proc_genhd_init+0x0/0x4a @ 1
initcall proc_genhd_init+0x0/0x4a returned 0 after 44 usecs
calling  bsg_init+0x0/0x11e @ 1
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
initcall bsg_init+0x0/0x11e returned 0 after 2737 usecs
calling  kyber_init+0x0/0x15 @ 1
io scheduler kyber registered
initcall kyber_init+0x0/0x15 returned 0 after 715 usecs
calling  primes_init+0x0/0xe7 @ 1
initcall primes_init+0x0/0xe7 returned 0 after 2 usecs
calling  blake2s_mod_init+0x0/0x10 @ 1
initcall blake2s_mod_init+0x0/0x10 returned 0 after 1 usecs
calling  chacha20poly1305_init+0x0/0x10 @ 1
initcall chacha20poly1305_init+0x0/0x10 returned 0 after 2 usecs
calling  curve25519_init+0x0/0x10 @ 1
initcall curve25519_init+0x0/0x10 returned 0 after 2 usecs
calling  debug_objects_init_debugfs+0x0/0x3f @ 1
initcall debug_objects_init_debugfs+0x0/0x3f returned 0 after 149 usecs
calling  crc_t10dif_mod_init+0x0/0x79 @ 1
initcall crc_t10dif_mod_init+0x0/0x79 returned 0 after 309 usecs
calling  libcrc32c_mod_init+0x0/0x4d @ 1
initcall libcrc32c_mod_init+0x0/0x4d returned 0 after 41 usecs
calling  crc64_rocksoft_mod_init+0x0/0x79 @ 1
initcall crc64_rocksoft_mod_init+0x0/0x79 returned 0 after 336 usecs
calling  percpu_counter_startup+0x0/0xb3 @ 1
initcall percpu_counter_startup+0x0/0xb3 returned 0 after 401 usecs
calling  err_inject_init+0x0/0x27 @ 1
initcall err_inject_init+0x0/0x27 returned 0 after 69 usecs
calling  err_inject_init+0x0/0xa0 @ 1
initcall err_inject_init+0x0/0xa0 returned 0 after 316 usecs
calling  err_inject_init+0x0/0xd0 @ 1
initcall err_inject_init+0x0/0xd0 returned 0 after 570 usecs
calling  madera_irq_driver_init+0x0/0x17 @ 1
initcall madera_irq_driver_init+0x0/0x17 returned 0 after 158 usecs
calling  phy_core_init+0x0/0x83 @ 1
initcall phy_core_init+0x0/0x83 returned 0 after 101 usecs
calling  bcm_kona_usb2_driver_init+0x0/0x17 @ 1
initcall bcm_kona_usb2_driver_init+0x0/0x17 returned 0 after 160 usecs
calling  mv_hsic_phy_driver_init+0x0/0x17 @ 1
initcall mv_hsic_phy_driver_init+0x0/0x17 returned 0 after 121 usecs
calling  mv_usb2_phy_driver_init+0x0/0x17 @ 1
initcall mv_usb2_phy_driver_init+0x0/0x17 returned 0 after 157 usecs
calling  da9062_pctl_driver_init+0x0/0x17 @ 1
initcall da9062_pctl_driver_init+0x0/0x17 returned 0 after 128 usecs
calling  madera_pin_driver_init+0x0/0x17 @ 1
initcall madera_pin_driver_init+0x0/0x17 returned 0 after 149 usecs
calling  bgpio_driver_init+0x0/0x17 @ 1
initcall bgpio_driver_init+0x0/0x17 returned 0 after 197 usecs
calling  gpio_aggregator_init+0x0/0x17 @ 1
initcall gpio_aggregator_init+0x0/0x17 returned 0 after 265 usecs
calling  arizona_gpio_driver_init+0x0/0x17 @ 1
initcall arizona_gpio_driver_init+0x0/0x17 returned 0 after 140 usecs
calling  dwapb_gpio_driver_init+0x0/0x17 @ 1
initcall dwapb_gpio_driver_init+0x0/0x17 returned 0 after 204 usecs
calling  it87_gpio_init+0x0/0x35b @ 1
gpio_it87: no device
initcall it87_gpio_init+0x0/0x35b returned -19 after 657 usecs
calling  kempld_gpio_driver_init+0x0/0x17 @ 1
initcall kempld_gpio_driver_init+0x0/0x17 returned 0 after 115 usecs
calling  madera_gpio_driver_init+0x0/0x17 @ 1
initcall madera_gpio_driver_init+0x0/0x17 returned 0 after 157 usecs
calling  max3191x_driver_init+0x0/0x28 @ 1
initcall max3191x_driver_init+0x0/0x28 returned 0 after 120 usecs
calling  mb86s70_gpio_driver_init+0x0/0x17 @ 1
initcall mb86s70_gpio_driver_init+0x0/0x17 returned 0 after 170 usecs
calling  gpio_mockup_init+0x0/0x11f @ 1
initcall gpio_mockup_init+0x0/0x11f returned 0 after 215 usecs
calling  gpio_siox_driver_init+0x0/0x17 @ 1
initcall gpio_siox_driver_init+0x0/0x17 returned 0 after 111 usecs
calling  tpic2810_driver_init+0x0/0x17 @ 1
initcall tpic2810_driver_init+0x0/0x17 returned 0 after 165 usecs
calling  tps65912_gpio_driver_init+0x0/0x17 @ 1
initcall tps65912_gpio_driver_init+0x0/0x17 returned 0 after 136 usecs
calling  winbond_gpio_idriver_init+0x0/0x1a @ 1
gpio_winbond: chip ID at 2e is ffff
gpio_winbond: not an our chip
gpio_winbond: chip ID at 4e is ffff
gpio_winbond: not an our chip
initcall winbond_gpio_idriver_init+0x0/0x1a returned -19 after 3835 usecs
calling  pcie_portdrv_init+0x0/0x47 @ 1
initcall pcie_portdrv_init+0x0/0x47 returned 0 after 354 usecs
calling  pci_proc_init+0x0/0x74 @ 1
initcall pci_proc_init+0x0/0x74 returned 0 after 164 usecs
calling  pci_hotplug_init+0x0/0x10 @ 1
initcall pci_hotplug_init+0x0/0x10 returned 0 after 2 usecs
calling  hx8357_driver_init+0x0/0x17 @ 1
SPI driver hx8357 has no spi_device_id for himax,hx8369
initcall hx8357_driver_init+0x0/0x17 returned 0 after 1076 usecs
calling  l4f00242t03_driver_init+0x0/0x17 @ 1
initcall l4f00242t03_driver_init+0x0/0x17 returned 0 after 146 usecs
calling  lms283gf05_driver_init+0x0/0x17 @ 1
initcall lms283gf05_driver_init+0x0/0x17 returned 0 after 100 usecs
calling  ltv350qv_driver_init+0x0/0x17 @ 1
initcall ltv350qv_driver_init+0x0/0x17 returned 0 after 163 usecs
calling  platform_lcd_driver_init+0x0/0x17 @ 1
initcall platform_lcd_driver_init+0x0/0x17 returned 0 after 141 usecs
calling  tdo24m_driver_init+0x0/0x17 @ 1
initcall tdo24m_driver_init+0x0/0x17 returned 0 after 100 usecs
calling  vgg2432a4_driver_init+0x0/0x17 @ 1
initcall vgg2432a4_driver_init+0x0/0x17 returned 0 after 96 usecs
calling  intel_idle_init+0x0/0x508 @ 1
initcall intel_idle_init+0x0/0x508 returned -19 after 3 usecs
calling  ipmi_init_msghandler_mod+0x0/0x4f @ 1
IPMI message handler: version 39.2
initcall ipmi_init_msghandler_mod+0x0/0x4f returned 0 after 1157 usecs
calling  init_ipmi_devintf+0x0/0x12a @ 1
ipmi device interface
initcall init_ipmi_devintf+0x0/0x12a returned 0 after 1602 usecs
calling  init_ipmi_si+0x0/0x29e @ 1
ipmi_si: IPMI System Interface driver
ipmi_si: Unable to find any System Interface(s)
initcall init_ipmi_si+0x0/0x29e returned -19 after 2125 usecs
calling  init_ipmi_ssif+0x0/0x249 @ 1
ipmi_ssif: IPMI SSIF Interface driver
initcall init_ipmi_ssif+0x0/0x249 returned 0 after 997 usecs
calling  ipmi_poweroff_init+0x0/0x90 @ 1
IPMI poweroff: Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot
initcall ipmi_poweroff_init+0x0/0x90 returned 0 after 1318 usecs
calling  ipmb_driver_init+0x0/0x17 @ 1
initcall ipmb_driver_init+0x0/0x17 returned 0 after 152 usecs
calling  ged_driver_init+0x0/0x17 @ 1
initcall ged_driver_init+0x0/0x17 returned 0 after 118 usecs
calling  acpi_ac_init+0x0/0x80 @ 1
initcall acpi_ac_init+0x0/0x80 returned 0 after 382 usecs
calling  acpi_button_driver_init+0x0/0xb7 @ 1
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
initcall acpi_button_driver_init+0x0/0xb7 returned 0 after 3434 usecs
calling  acpi_fan_driver_init+0x0/0x17 @ 1
initcall acpi_fan_driver_init+0x0/0x17 returned 0 after 147 usecs
calling  acpi_processor_driver_init+0x0/0xd1 @ 1
Warning: Processor Platform Limit event detected, but not handled.
Consider compiling CPUfreq support into your kernel.
initcall acpi_processor_driver_init+0x0/0xd1 returned 0 after 3688 usecs
calling  acpi_thermal_init+0x0/0x8a @ 1
initcall acpi_thermal_init+0x0/0x8a returned 0 after 739 usecs
calling  acpi_battery_init+0x0/0x75 @ 1
initcall acpi_battery_init+0x0/0x75 returned 0 after 37 usecs
calling  gpio_clk_driver_init+0x0/0x17 @ 1
initcall gpio_clk_driver_init+0x0/0x17 returned 0 after 106 usecs
calling  ti_syscon_reset_driver_init+0x0/0x17 @ 1
initcall ti_syscon_reset_driver_init+0x0/0x17 returned 0 after 166 usecs
calling  n_null_init+0x0/0x3e @ 1
initcall n_null_init+0x0/0x3e returned 0 after 3 usecs
calling  pty_init+0x0/0x1a @ 1
initcall pty_init+0x0/0x1a returned 0 after 271819 usecs
calling  sysrq_init+0x0/0x52 @ 1
initcall sysrq_init+0x0/0x52 returned 0 after 39 usecs
calling  serial8250_init+0x0/0x324 @ 1
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
initcall serial8250_init+0x0/0x324 returned 0 after 63616 usecs
calling  serial_pci_driver_init+0x0/0x1e @ 1
initcall serial_pci_driver_init+0x0/0x1e returned 0 after 1052 usecs
calling  exar_pci_driver_init+0x0/0x1e @ 1
initcall exar_pci_driver_init+0x0/0x1e returned 0 after 199 usecs
calling  mcb_driver_init+0x0/0x1e @ 1
initcall mcb_driver_init+0x0/0x1e returned 0 after 114 usecs
calling  dw8250_platform_driver_init+0x0/0x17 @ 1
initcall dw8250_platform_driver_init+0x0/0x17 returned 0 after 126 usecs
calling  lpss8250_pci_driver_init+0x0/0x1e @ 1
initcall lpss8250_pci_driver_init+0x0/0x1e returned 0 after 220 usecs
calling  mid8250_pci_driver_init+0x0/0x1e @ 1
initcall mid8250_pci_driver_init+0x0/0x1e returned 0 after 146 usecs
calling  pericom8250_pci_driver_init+0x0/0x1e @ 1
initcall pericom8250_pci_driver_init+0x0/0x1e returned 0 after 143 usecs
calling  max3100_driver_init+0x0/0x17 @ 1
initcall max3100_driver_init+0x0/0x17 returned 0 after 131 usecs
calling  max310x_uart_init+0x0/0x75 @ 1
initcall max310x_uart_init+0x0/0x75 returned 0 after 409 usecs
calling  sccnxp_uart_driver_init+0x0/0x17 @ 1
initcall sccnxp_uart_driver_init+0x0/0x17 returned 0 after 103 usecs
calling  sc16is7xx_init+0x0/0x96 @ 1
initcall sc16is7xx_init+0x0/0x96 returned 0 after 333 usecs
calling  ulite_init+0x0/0x2e @ 1
initcall ulite_init+0x0/0x2e returned 0 after 108 usecs
calling  altera_uart_init+0x0/0x49 @ 1
initcall altera_uart_init+0x0/0x49 returned -16 after 217 usecs
calling  altera_jtaguart_init+0x0/0x49 @ 1
initcall altera_jtaguart_init+0x0/0x49 returned 0 after 188 usecs
calling  init_lqasc+0x0/0x49 @ 1
initcall init_lqasc+0x0/0x49 returned 0 after 269 usecs
calling  arc_serial_init+0x0/0x49 @ 1
initcall arc_serial_init+0x0/0x49 returned 0 after 220 usecs
calling  linflex_serial_init+0x0/0x49 @ 1
initcall linflex_serial_init+0x0/0x49 returned 0 after 216 usecs
calling  men_z135_init+0x0/0x6e @ 1
initcall men_z135_init+0x0/0x6e returned 0 after 228 usecs
calling  random_sysctls_init+0x0/0x2a @ 1
initcall random_sysctls_init+0x0/0x2a returned 0 after 39 usecs
calling  virtio_console_init+0x0/0x106 @ 1
initcall virtio_console_init+0x0/0x106 returned 0 after 373 usecs
calling  lp_init_module+0x0/0x26d @ 1
kworker/u4:2 (51) used greatest stack depth: 28352 bytes left
lp: driver loaded but no devices found
initcall lp_init_module+0x0/0x26d returned 0 after 7234 usecs
calling  nvram_module_init+0x0/0x91 @ 1
Non-volatile memory driver v1.3
initcall nvram_module_init+0x0/0x91 returned 0 after 1567 usecs
calling  intel_rng_mod_init+0x0/0x489 @ 1
initcall intel_rng_mod_init+0x0/0x489 returned -19 after 294 usecs
calling  ba431_trng_driver_init+0x0/0x17 @ 1
initcall ba431_trng_driver_init+0x0/0x17 returned 0 after 140 usecs
calling  virtio_rng_driver_init+0x0/0x15 @ 1
initcall virtio_rng_driver_init+0x0/0x15 returned 0 after 111 usecs
calling  xiphera_trng_driver_init+0x0/0x17 @ 1
initcall xiphera_trng_driver_init+0x0/0x17 returned 0 after 244 usecs
calling  tlclk_init+0x0/0x2e8 @ 1
telclk_interrupt = 0xf non-mcpbl0010 hw.
initcall tlclk_init+0x0/0x2e8 returned -6 after 935 usecs
calling  mwave_init+0x0/0x2c1 @ 1
smapi::smapi_init, ERROR invalid usSmapiID
mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAPI is not available on this machine
mwave: mwavedd::mwave_init: Error: Failed to initialize board data
mwave: mwavedd::mwave_init: Error: Failed to initialize
initcall mwave_init+0x0/0x2c1 returned -5 after 4017 usecs
calling  hangcheck_init+0x0/0xa6 @ 1
Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
initcall hangcheck_init+0x0/0xa6 returned 0 after 1246 usecs
calling  parport_pc_init+0x0/0x250 @ 1
parport_pc 00:03: reported by Plug and Play ACPI
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
initcall parport_pc_init+0x0/0x250 returned 0 after 108215 usecs
calling  axdrv_init+0x0/0x17 @ 1
initcall axdrv_init+0x0/0x17 returned 0 after 117 usecs
calling  topology_sysfs_init+0x0/0x30 @ 1
initcall topology_sysfs_init+0x0/0x30 returned 0 after 576 usecs
calling  cacheinfo_sysfs_init+0x0/0x30 @ 1
initcall cacheinfo_sysfs_init+0x0/0x30 returned 0 after 2280 usecs
calling  dummy_irq_init+0x0/0x81 @ 1
dummy-irq: no IRQ given.  Use irq=N
initcall dummy_irq_init+0x0/0x81 returned -5 after 739 usecs
calling  apds990x_driver_init+0x0/0x17 @ 1
initcall apds990x_driver_init+0x0/0x17 returned 0 after 218 usecs
calling  apds9802als_driver_init+0x0/0x17 @ 1
initcall apds9802als_driver_init+0x0/0x17 returned 0 after 169 usecs
calling  isl29003_driver_init+0x0/0x17 @ 1
initcall isl29003_driver_init+0x0/0x17 returned 0 after 121 usecs
calling  isl29020_driver_init+0x0/0x17 @ 1
initcall isl29020_driver_init+0x0/0x17 returned 0 after 106 usecs
calling  tsl2550_driver_init+0x0/0x17 @ 1
initcall tsl2550_driver_init+0x0/0x17 returned 0 after 285 usecs
calling  c2port_init+0x0/0x88 @ 1
Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Giometti
initcall c2port_init+0x0/0x88 returned 0 after 1454 usecs
calling  duramar2150_c2port_init+0x0/0xa6 @ 1
c2port c2port0: C2 port uc added
c2port c2port0: uc flash has 30 blocks x 512 bytes (15360 bytes total)
initcall duramar2150_c2port_init+0x0/0xa6 returned 0 after 2393 usecs
calling  hmc6352_driver_init+0x0/0x17 @ 1
initcall hmc6352_driver_init+0x0/0x17 returned 0 after 142 usecs
calling  at25_driver_init+0x0/0x17 @ 1
initcall at25_driver_init+0x0/0x17 returned 0 after 753 usecs
calling  max6875_driver_init+0x0/0x17 @ 1
initcall max6875_driver_init+0x0/0x17 returned 0 after 147 usecs
calling  eeprom_93xx46_driver_init+0x0/0x17 @ 1
initcall eeprom_93xx46_driver_init+0x0/0x17 returned 0 after 101 usecs
calling  idt_init+0x0/0x35 @ 1
initcall idt_init+0x0/0x35 returned 0 after 170 usecs
calling  ee1004_driver_init+0x0/0x17 @ 1
initcall ee1004_driver_init+0x0/0x17 returned 0 after 168 usecs
calling  lis3lv02d_i2c_driver_init+0x0/0x17 @ 1
initcall lis3lv02d_i2c_driver_init+0x0/0x17 returned 0 after 91 usecs
calling  xsdfec_driver_init+0x0/0x17 @ 1
initcall xsdfec_driver_init+0x0/0x17 returned 0 after 114 usecs
calling  sm501_base_init+0x0/0x35 @ 1
initcall sm501_base_init+0x0/0x35 returned 0 after 312 usecs
calling  bcm590xx_i2c_driver_init+0x0/0x17 @ 1
initcall bcm590xx_i2c_driver_init+0x0/0x17 returned 0 after 95 usecs
calling  ti_tscadc_driver_init+0x0/0x17 @ 1
initcall ti_tscadc_driver_init+0x0/0x17 returned 0 after 136 usecs
calling  tqmx86_init+0x0/0x31 @ 1
initcall tqmx86_init+0x0/0x31 returned -19 after 4 usecs
calling  arizona_i2c_driver_init+0x0/0x17 @ 1
initcall arizona_i2c_driver_init+0x0/0x17 returned 0 after 192 usecs
calling  wcd934x_slim_driver_init+0x0/0x17 @ 1
initcall wcd934x_slim_driver_init+0x0/0x17 returned 0 after 166 usecs
calling  wm8994_i2c_driver_init+0x0/0x17 @ 1
initcall wm8994_i2c_driver_init+0x0/0x17 returned 0 after 133 usecs
calling  tps65086_driver_init+0x0/0x17 @ 1
initcall tps65086_driver_init+0x0/0x17 returned 0 after 122 usecs
calling  tps65912_i2c_driver_init+0x0/0x17 @ 1
initcall tps65912_i2c_driver_init+0x0/0x17 returned 0 after 108 usecs
calling  twl_driver_init+0x0/0x17 @ 1
initcall twl_driver_init+0x0/0x17 returned 0 after 165 usecs
calling  twl4030_audio_driver_init+0x0/0x17 @ 1
initcall twl4030_audio_driver_init+0x0/0x17 returned 0 after 157 usecs
calling  lp3943_driver_init+0x0/0x17 @ 1
initcall lp3943_driver_init+0x0/0x17 returned 0 after 102 usecs
calling  ti_lmu_driver_init+0x0/0x17 @ 1
initcall ti_lmu_driver_init+0x0/0x17 returned 0 after 102 usecs
calling  da9062_i2c_driver_init+0x0/0x17 @ 1
initcall da9062_i2c_driver_init+0x0/0x17 returned 0 after 143 usecs
calling  da9063_i2c_driver_init+0x0/0x17 @ 1
initcall da9063_i2c_driver_init+0x0/0x17 returned 0 after 150 usecs
calling  mt6360_driver_init+0x0/0x17 @ 1
initcall mt6360_driver_init+0x0/0x17 returned 0 after 98 usecs
calling  mt6397_driver_init+0x0/0x17 @ 1
initcall mt6397_driver_init+0x0/0x17 returned 0 after 94 usecs
calling  kempld_init+0x0/0xf3 @ 1
initcall kempld_init+0x0/0xf3 returned 0 after 159 usecs
calling  retu_driver_init+0x0/0x17 @ 1
initcall retu_driver_init+0x0/0x17 returned 0 after 128 usecs
calling  menf21bmc_driver_init+0x0/0x17 @ 1
initcall menf21bmc_driver_init+0x0/0x17 returned 0 after 99 usecs
calling  rt5033_driver_init+0x0/0x17 @ 1
initcall rt5033_driver_init+0x0/0x17 returned 0 after 226 usecs
calling  sky81452_driver_init+0x0/0x17 @ 1
initcall sky81452_driver_init+0x0/0x17 returned 0 after 196 usecs
calling  rave_sp_drv_init+0x0/0x17 @ 1
initcall rave_sp_drv_init+0x0/0x17 returned 0 after 154 usecs
calling  intel_m10bmc_spi_driver_init+0x0/0x17 @ 1
initcall intel_m10bmc_spi_driver_init+0x0/0x17 returned 0 after 108 usecs
calling  dax_init+0x0/0x1e @ 1
initcall dax_init+0x0/0x1e returned 0 after 204 usecs
calling  udmabuf_dev_init+0x0/0xaf @ 1
initcall udmabuf_dev_init+0x0/0xaf returned 0 after 777 usecs
calling  spi_transport_init+0x0/0x17a @ 1
initcall spi_transport_init+0x0/0x17a returned 0 after 254 usecs
calling  sas_transport_init+0x0/0xc7 @ 1
initcall sas_transport_init+0x0/0xc7 returned 0 after 370 usecs
calling  sas_class_init+0x0/0x80 @ 1
initcall sas_class_init+0x0/0x80 returned 0 after 209 usecs
calling  srp_transport_init+0x0/0x47 @ 1
initcall srp_transport_init+0x0/0x47 returned 0 after 133 usecs
calling  init_st+0x0/0xe0 @ 1
st: Version 20160209, fixed bufsize 32768, s/g segs 256
initcall init_st+0x0/0xe0 returned 0 after 1076 usecs
calling  init_sd+0x0/0x19f @ 1
initcall init_sd+0x0/0x19f returned 0 after 348 usecs
calling  init_sg+0x0/0x1fc @ 1
initcall init_sg+0x0/0x1fc returned 0 after 319 usecs
calling  init_ch_module+0x0/0xc5 @ 1
SCSI Media Changer driver v0.25 
initcall init_ch_module+0x0/0xc5 returned 0 after 795 usecs
calling  nvme_core_init+0x0/0x1f3 @ 1
initcall nvme_core_init+0x0/0x1f3 returned 0 after 4489 usecs
calling  nvmf_init+0x0/0x269 @ 1
initcall nvmf_init+0x0/0x269 returned 0 after 1022 usecs
calling  nvme_fc_init_module+0x0/0xe0 @ 1
initcall nvme_fc_init_module+0x0/0xe0 returned 0 after 1107 usecs
calling  init_mtd+0x0/0x18e @ 1
initcall init_mtd+0x0/0x18e returned 0 after 860 usecs
calling  ar7_parser_init+0x0/0x17 @ 1
initcall ar7_parser_init+0x0/0x17 returned 0 after 41 usecs
calling  mtdblock_tr_init+0x0/0x15 @ 1
initcall mtdblock_tr_init+0x0/0x15 returned 0 after 170 usecs
calling  ftl_tr_init+0x0/0x15 @ 1
initcall ftl_tr_init+0x0/0x15 returned 0 after 20 usecs
calling  nftl_tr_init+0x0/0x15 @ 1
initcall nftl_tr_init+0x0/0x15 returned 0 after 19 usecs
calling  inftl_tr_init+0x0/0x15 @ 1
initcall inftl_tr_init+0x0/0x15 returned 0 after 20 usecs
calling  rfd_ftl_tr_init+0x0/0x15 @ 1
initcall rfd_ftl_tr_init+0x0/0x15 returned 0 after 17 usecs
calling  init_ssfdcr+0x0/0x21 @ 1
SSFDC read-only Flash Translation layer
initcall init_ssfdcr+0x0/0x21 returned 0 after 765 usecs
calling  sm_module_init+0x0/0x63 @ 1
initcall sm_module_init+0x0/0x63 returned 0 after 617 usecs
calling  mtdoops_init+0x0/0x24b @ 1
mtdoops: mtd device (mtddev=name/number) must be supplied
initcall mtdoops_init+0x0/0x24b returned -22 after 940 usecs
calling  cfi_probe_init+0x0/0x1c @ 1
initcall cfi_probe_init+0x0/0x1c returned 0 after 85 usecs
calling  jedec_probe_init+0x0/0x1c @ 1
initcall jedec_probe_init+0x0/0x1c returned 0 after 4 usecs
calling  map_ram_init+0x0/0x1c @ 1
initcall map_ram_init+0x0/0x1c returned 0 after 3 usecs
calling  map_absent_init+0x0/0x1c @ 1
initcall map_absent_init+0x0/0x1c returned 0 after 3 usecs
calling  lpddr_probe_init+0x0/0x1c @ 1
initcall lpddr_probe_init+0x0/0x1c returned 0 after 3 usecs
calling  init_l440gx+0x0/0x41d @ 1
L440GX flash mapping: failed to find PIIX4 ISA bridge, cannot continue
initcall init_l440gx+0x0/0x41d returned -19 after 1123 usecs
calling  init_ichxrom+0x0/0x95 @ 1
initcall init_ichxrom+0x0/0x95 returned -6 after 52 usecs
calling  physmap_init+0x0/0x49 @ 1
platform physmap-flash.0: failed to claim resource 0: [mem 0x08000000-0x07ffffff]
initcall physmap_init+0x0/0x49 returned -16 after 1665 usecs
calling  platram_driver_init+0x0/0x17 @ 1
initcall platram_driver_init+0x0/0x17 returned 0 after 135 usecs
calling  init_slram+0x0/0x331 @ 1
slram: not enough parameters.
initcall init_slram+0x0/0x331 returned -22 after 697 usecs
calling  init_phram+0x0/0x68 @ 1
initcall init_phram+0x0/0x68 returned 0 after 240 usecs
calling  dataflash_driver_init+0x0/0x17 @ 1
initcall dataflash_driver_init+0x0/0x17 returned 0 after 118 usecs
calling  mchp23k256_driver_init+0x0/0x17 @ 1
initcall mchp23k256_driver_init+0x0/0x17 returned 0 after 172 usecs
calling  sst25l_driver_init+0x0/0x17 @ 1
initcall sst25l_driver_init+0x0/0x17 returned 0 after 102 usecs
calling  generic_onenand_driver_init+0x0/0x17 @ 1
initcall generic_onenand_driver_init+0x0/0x17 returned 0 after 237 usecs
calling  ns_init_module+0x0/0x1181 @ 1
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is STATE_READY return 0x0
nand: device found, Manufacturer ID: 0x98, Chip ID: 0x39
nand: Toshiba NAND 128MiB 1,8V 8-bit
nand: 128 MiB, SLC, erase size: 16 KiB, page size: 512, OOB size: 16
flash size: 128 MiB
page size: 512 bytes
OOB area size: 16 bytes
sector size: 16 KiB
pages number: 262144
pages per sector: 32
bus width: 8
bits in sector size: 14
bits in page size: 9
bits in OOB size: 4
flash size with OOB: 135168 KiB
page address bytes: 4
sector address bytes: 3
options: 0x42
Scanning device for bad blocks
kworker/u4:2 (58) used greatest stack depth: 27952 bytes left
Creating 1 MTD partitions on "NAND 128MiB 1,8V 8-bit":
0x000000000000-0x000008000000 : "NAND simulator partition 0"
ftl_cs: FTL header not found.
[nandsim] warning: CONFIG_MTD_PARTITIONED_MASTER must be enabled to expose debugfs stuff
initcall ns_init_module+0x0/0x1181 returned 0 after 134415 usecs
calling  gpio_nand_driver_init+0x0/0x17 @ 1
initcall gpio_nand_driver_init+0x0/0x17 returned 0 after 199 usecs
calling  anfc_driver_init+0x0/0x17 @ 1
initcall anfc_driver_init+0x0/0x17 returned 0 after 135 usecs
calling  spinand_drv_init+0x0/0x17 @ 1
initcall spinand_drv_init+0x0/0x17 returned 0 after 166 usecs
calling  spi_mux_driver_init+0x0/0x17 @ 1
initcall spi_mux_driver_init+0x0/0x17 returned 0 after 106 usecs
calling  spidev_init+0x0/0xc1 @ 1
initcall spidev_init+0x0/0xc1 returned 0 after 319 usecs
calling  spi_engine_driver_init+0x0/0x17 @ 1
initcall spi_engine_driver_init+0x0/0x17 returned 0 after 145 usecs
calling  butterfly_driver_init+0x0/0x1e @ 1
parport0: powerup/reset Butterfly
parport_pc 00:03: registered master spi42
spi spi42.1: spi_bitbang_setup, 66 nsec/bit
spi spi42.1: setup mode 0, 8 bits/w, 15000000 Hz max --> 0
parport_pc 00:03: registered child spi42.1
parport0: dataflash at spi42.1
parport0: AVR Butterfly
initcall butterfly_driver_init+0x0/0x1e returned 0 after 126089 usecs
calling  cdns_spi_driver_init+0x0/0x17 @ 1
initcall cdns_spi_driver_init+0x0/0x17 returned 0 after 179 usecs
calling  dw_spi_mmio_driver_init+0x0/0x17 @ 1
initcall dw_spi_mmio_driver_init+0x0/0x17 returned 0 after 248 usecs
calling  spi_gpio_driver_init+0x0/0x17 @ 1
initcall spi_gpio_driver_init+0x0/0x17 returned 0 after 155 usecs
calling  spi_lm70llp_drv_init+0x0/0x1e @ 1
parport0: cannot grant exclusive access for device spi-lm70llp
spi_lm70llp: spi_lm70llp probe fail, status -12
initcall spi_lm70llp_drv_init+0x0/0x1e returned 0 after 2239 usecs
calling  tiny_spi_driver_init+0x0/0x17 @ 1
initcall tiny_spi_driver_init+0x0/0x17 returned 0 after 973 usecs
calling  rockchip_spi_driver_init+0x0/0x17 @ 1
initcall rockchip_spi_driver_init+0x0/0x17 returned 0 after 935 usecs
calling  sifive_spi_driver_init+0x0/0x17 @ 1
initcall sifive_spi_driver_init+0x0/0x17 returned 0 after 134 usecs
calling  tle62x0_driver_init+0x0/0x17 @ 1
initcall tle62x0_driver_init+0x0/0x17 returned 0 after 132 usecs
calling  spi_xcomm_driver_init+0x0/0x17 @ 1
initcall spi_xcomm_driver_init+0x0/0x17 returned 0 after 150 usecs
calling  xilinx_spi_driver_init+0x0/0x17 @ 1
initcall xilinx_spi_driver_init+0x0/0x17 returned 0 after 82 usecs
calling  zynqmp_qspi_driver_init+0x0/0x17 @ 1
initcall zynqmp_qspi_driver_init+0x0/0x17 returned 0 after 82 usecs
calling  spi_slave_time_driver_init+0x0/0x17 @ 1
initcall spi_slave_time_driver_init+0x0/0x17 returned 0 after 128 usecs
calling  hsc_init+0x0/0x70 @ 1
HSI/SSI char device loaded
initcall hsc_init+0x0/0x70 returned 0 after 740 usecs
calling  qcom_slim_driver_init+0x0/0x17 @ 1
initcall qcom_slim_driver_init+0x0/0x17 returned 0 after 78 usecs
calling  blackhole_netdev_init+0x0/0xd3 @ 1
initcall blackhole_netdev_init+0x0/0xd3 returned 0 after 147 usecs
calling  fixed_mdio_bus_init+0x0/0x225 @ 1
initcall fixed_mdio_bus_init+0x0/0x225 returned 0 after 2001 usecs
calling  e1000_init_module+0x0/0x7f @ 1
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
ACPI: \_SB_.LNKC: Enabled at IRQ 11
e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
initcall e1000_init_module+0x0/0x7f returned 0 after 2632777 usecs
calling  vfio_init+0x0/0x97 @ 1
VFIO - User Level meta-driver version: 0.3
initcall vfio_init+0x0/0x97 returned 0 after 1134 usecs
calling  vfio_iommu_type1_init+0x0/0x15 @ 1
initcall vfio_iommu_type1_init+0x0/0x15 returned 0 after 31 usecs
calling  ks0108_parport_driver_init+0x0/0x1e @ 1
parport0: cannot grant exclusive access for device ks0108
ks0108: ERROR: parport didn't register new device
initcall ks0108_parport_driver_init+0x0/0x1e returned 0 after 1380 usecs
calling  img_ascii_lcd_driver_init+0x0/0x17 @ 1
initcall img_ascii_lcd_driver_init+0x0/0x17 returned 0 after 68 usecs
calling  hd44780_driver_init+0x0/0x17 @ 1
initcall hd44780_driver_init+0x0/0x17 returned 0 after 54 usecs
calling  i8042_init+0x0/0x12b @ 1
i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
initcall i8042_init+0x0/0x12b returned 0 after 4012 usecs
calling  serport_init+0x0/0x34 @ 1
initcall serport_init+0x0/0x34 returned 0 after 2 usecs
calling  ct82c710_init+0x0/0x162 @ 1
initcall ct82c710_init+0x0/0x162 returned -19 after 28 usecs
calling  ps2mult_drv_init+0x0/0x1e @ 1
initcall ps2mult_drv_init+0x0/0x1e returned 0 after 139 usecs
calling  serio_raw_drv_init+0x0/0x1e @ 1
initcall serio_raw_drv_init+0x0/0x1e returned 0 after 75 usecs
calling  altera_ps2_driver_init+0x0/0x17 @ 1
initcall altera_ps2_driver_init+0x0/0x17 returned 0 after 81 usecs
calling  arc_ps2_driver_init+0x0/0x17 @ 1
initcall arc_ps2_driver_init+0x0/0x17 returned 0 after 55 usecs
calling  ps2_gpio_driver_init+0x0/0x17 @ 1
initcall ps2_gpio_driver_init+0x0/0x17 returned 0 after 43 usecs
calling  userio_misc_init+0x0/0x15 @ 1
initcall userio_misc_init+0x0/0x15 returned 0 after 252 usecs
calling  l4_init+0x0/0x276 @ 1
initcall l4_init+0x0/0x276 returned -19 after 31 usecs
calling  ns558_init+0x0/0xda @ 1
initcall ns558_init+0x0/0xda returned 0 after 48472 usecs
calling  evbug_init+0x0/0x15 @ 1
evbug: Connected device: input0 (Power Button at LNXPWRBN/button/input0)
initcall evbug_init+0x0/0x15 returned 0 after 849 usecs
calling  adp5588_driver_init+0x0/0x17 @ 1
initcall adp5588_driver_init+0x0/0x17 returned 0 after 126 usecs
calling  adp5589_driver_init+0x0/0x17 @ 1
initcall adp5589_driver_init+0x0/0x17 returned 0 after 64 usecs
calling  atkbd_init+0x0/0x2a @ 1
initcall atkbd_init+0x0/0x2a returned 0 after 78 usecs
calling  dir685_tk_i2c_driver_init+0x0/0x17 @ 1
initcall dir685_tk_i2c_driver_init+0x0/0x17 returned 0 after 382 usecs
calling  events_driver_init+0x0/0x17 @ 1
initcall events_driver_init+0x0/0x17 returned 0 after 281 usecs
calling  gpio_keys_polled_driver_init+0x0/0x17 @ 1
initcall gpio_keys_polled_driver_init+0x0/0x17 returned 0 after 140 usecs
calling  lkkbd_drv_init+0x0/0x1e @ 1
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
evbug: Connected device: input1 (AT Translated Set 2 keyboard at isa0060/serio0/input0)
initcall lkkbd_drv_init+0x0/0x1e returned 0 after 1509 usecs
calling  lm8323_i2c_driver_init+0x0/0x17 @ 1
initcall lm8323_i2c_driver_init+0x0/0x17 returned 0 after 64 usecs
calling  mpr_touchkey_driver_init+0x0/0x17 @ 1
initcall mpr_touchkey_driver_init+0x0/0x17 returned 0 after 83 usecs
calling  pmic_keys_pdrv_init+0x0/0x17 @ 1
initcall pmic_keys_pdrv_init+0x0/0x17 returned 0 after 64 usecs
calling  nkbd_drv_init+0x0/0x1e @ 1
initcall nkbd_drv_init+0x0/0x1e returned 0 after 108 usecs
calling  opencores_kbd_device_driver_init+0x0/0x17 @ 1
initcall opencores_kbd_device_driver_init+0x0/0x17 returned 0 after 98 usecs
calling  qt1050_driver_init+0x0/0x17 @ 1
initcall qt1050_driver_init+0x0/0x17 returned 0 after 79 usecs
calling  qt1070_driver_init+0x0/0x17 @ 1
initcall qt1070_driver_init+0x0/0x17 returned 0 after 46 usecs
calling  skbd_drv_init+0x0/0x1e @ 1
initcall skbd_drv_init+0x0/0x1e returned 0 after 95 usecs
calling  sunkbd_drv_init+0x0/0x1e @ 1
initcall sunkbd_drv_init+0x0/0x1e returned 0 after 126 usecs
calling  twl4030_kp_driver_init+0x0/0x17 @ 1
initcall twl4030_kp_driver_init+0x0/0x17 returned 0 after 76 usecs
calling  adi_drv_init+0x0/0x1e @ 1
initcall adi_drv_init+0x0/0x1e returned 0 after 150 usecs
calling  analog_init+0x0/0x23 @ 1
initcall analog_init+0x0/0x23 returned 0 after 175 usecs
calling  cobra_drv_init+0x0/0x1e @ 1
initcall cobra_drv_init+0x0/0x1e returned 0 after 153 usecs
calling  db9_init+0x0/0x12a @ 1
initcall db9_init+0x0/0x12a returned -19 after 1 usecs
calling  gf2k_drv_init+0x0/0x1e @ 1
initcall gf2k_drv_init+0x0/0x1e returned 0 after 75 usecs
calling  grip_drv_init+0x0/0x1e @ 1
initcall grip_drv_init+0x0/0x1e returned 0 after 66 usecs
calling  grip_drv_init+0x0/0x1e @ 1
initcall grip_drv_init+0x0/0x1e returned 0 after 107 usecs
calling  guillemot_drv_init+0x0/0x1e @ 1
initcall guillemot_drv_init+0x0/0x1e returned 0 after 67 usecs
calling  interact_drv_init+0x0/0x1e @ 1
initcall interact_drv_init+0x0/0x1e returned 0 after 67 usecs
calling  joydump_drv_init+0x0/0x1e @ 1
initcall joydump_drv_init+0x0/0x1e returned 0 after 141 usecs
calling  magellan_drv_init+0x0/0x1e @ 1
initcall magellan_drv_init+0x0/0x1e returned 0 after 92 usecs
calling  spaceball_drv_init+0x0/0x1e @ 1
initcall spaceball_drv_init+0x0/0x1e returned 0 after 88 usecs
calling  spaceorb_drv_init+0x0/0x1e @ 1
initcall spaceorb_drv_init+0x0/0x1e returned 0 after 113 usecs
calling  tmdc_drv_init+0x0/0x1e @ 1
initcall tmdc_drv_init+0x0/0x1e returned 0 after 108 usecs
calling  tgfx_init+0x0/0x12a @ 1
initcall tgfx_init+0x0/0x12a returned -19 after 1 usecs
calling  warrior_drv_init+0x0/0x1e @ 1
initcall warrior_drv_init+0x0/0x1e returned 0 after 113 usecs
calling  walkera0701_init+0x0/0x1e @ 1
parport0: cannot grant exclusive access for device walkera0701
walkera0701: failed to register parport device
initcall walkera0701_init+0x0/0x1e returned 0 after 1462 usecs
calling  zhenhua_drv_init+0x0/0x1e @ 1
initcall zhenhua_drv_init+0x0/0x1e returned 0 after 106 usecs
calling  ad7877_driver_init+0x0/0x17 @ 1
initcall ad7877_driver_init+0x0/0x17 returned 0 after 80 usecs
calling  ads7846_driver_init+0x0/0x17 @ 1
initcall ads7846_driver_init+0x0/0x17 returned 0 after 54 usecs
calling  mxt_driver_init+0x0/0x17 @ 1
initcall mxt_driver_init+0x0/0x17 returned 0 after 92 usecs
calling  auo_pixcir_driver_init+0x0/0x17 @ 1
initcall auo_pixcir_driver_init+0x0/0x17 returned 0 after 60 usecs
calling  bu21013_driver_init+0x0/0x17 @ 1
initcall bu21013_driver_init+0x0/0x17 returned 0 after 109 usecs
calling  cy8ctma140_driver_init+0x0/0x17 @ 1
initcall cy8ctma140_driver_init+0x0/0x17 returned 0 after 100 usecs
calling  cy8ctmg110_driver_init+0x0/0x17 @ 1
initcall cy8ctmg110_driver_init+0x0/0x17 returned 0 after 137 usecs
calling  cyttsp_spi_driver_init+0x0/0x17 @ 1
SPI driver cyttsp-spi has no spi_device_id for cypress,cy8ctma340
SPI driver cyttsp-spi has no spi_device_id for cypress,cy8ctst341
initcall cyttsp_spi_driver_init+0x0/0x17 returned 0 after 5798 usecs
calling  dynapro_drv_init+0x0/0x1e @ 1
initcall dynapro_drv_init+0x0/0x1e returned 0 after 78 usecs
calling  edt_ft5x06_ts_driver_init+0x0/0x17 @ 1
initcall edt_ft5x06_ts_driver_init+0x0/0x17 returned 0 after 87 usecs
calling  hampshire_drv_init+0x0/0x1e @ 1
initcall hampshire_drv_init+0x0/0x1e returned 0 after 76 usecs
calling  elants_i2c_driver_init+0x0/0x17 @ 1
initcall elants_i2c_driver_init+0x0/0x17 returned 0 after 95 usecs
calling  elo_drv_init+0x0/0x1e @ 1
initcall elo_drv_init+0x0/0x1e returned 0 after 57 usecs
calling  egalax_drv_init+0x0/0x1e @ 1
initcall egalax_drv_init+0x0/0x1e returned 0 after 85 usecs
calling  exc3000_driver_init+0x0/0x17 @ 1
initcall exc3000_driver_init+0x0/0x17 returned 0 after 61 usecs
calling  fujitsu_drv_init+0x0/0x1e @ 1
initcall fujitsu_drv_init+0x0/0x1e returned 0 after 69 usecs
calling  goodix_ts_driver_init+0x0/0x17 @ 1
initcall goodix_ts_driver_init+0x0/0x17 returned 0 after 75 usecs
calling  hideep_driver_init+0x0/0x17 @ 1
initcall hideep_driver_init+0x0/0x17 returned 0 after 65 usecs
calling  inexio_drv_init+0x0/0x1e @ 1
initcall inexio_drv_init+0x0/0x1e returned 0 after 70 usecs
calling  mc13783_ts_driver_init+0x0/0x1e @ 1
initcall mc13783_ts_driver_init+0x0/0x1e returned -19 after 140 usecs
calling  mcs5000_ts_driver_init+0x0/0x17 @ 1
initcall mcs5000_ts_driver_init+0x0/0x17 returned 0 after 60 usecs
calling  mms114_driver_init+0x0/0x17 @ 1
initcall mms114_driver_init+0x0/0x17 returned 0 after 53 usecs
calling  mtouch_drv_init+0x0/0x1e @ 1
initcall mtouch_drv_init+0x0/0x1e returned 0 after 81 usecs
calling  mk712_init+0x0/0x336 @ 1
mk712: device not present
initcall mk712_init+0x0/0x336 returned -19 after 415 usecs
calling  pixcir_i2c_ts_driver_init+0x0/0x17 @ 1
initcall pixcir_i2c_ts_driver_init+0x0/0x17 returned 0 after 42 usecs
calling  raydium_i2c_driver_init+0x0/0x17 @ 1
initcall raydium_i2c_driver_init+0x0/0x17 returned 0 after 40 usecs
calling  s6sy761_driver_init+0x0/0x17 @ 1
initcall s6sy761_driver_init+0x0/0x17 returned 0 after 57 usecs
calling  silead_ts_driver_init+0x0/0x17 @ 1
initcall silead_ts_driver_init+0x0/0x17 returned 0 after 52 usecs
calling  sis_ts_driver_init+0x0/0x17 @ 1
initcall sis_ts_driver_init+0x0/0x17 returned 0 after 40 usecs
calling  st1232_ts_driver_init+0x0/0x17 @ 1
initcall st1232_ts_driver_init+0x0/0x17 returned 0 after 40 usecs
calling  stmfts_driver_init+0x0/0x17 @ 1
initcall stmfts_driver_init+0x0/0x17 returned 0 after 52 usecs
calling  surface3_spi_driver_init+0x0/0x17 @ 1
initcall surface3_spi_driver_init+0x0/0x17 returned 0 after 56 usecs
calling  ti_tsc_driver_init+0x0/0x17 @ 1
initcall ti_tsc_driver_init+0x0/0x17 returned 0 after 53 usecs
calling  touchit213_drv_init+0x0/0x1e @ 1
initcall touchit213_drv_init+0x0/0x1e returned 0 after 61 usecs
calling  tr_drv_init+0x0/0x1e @ 1
initcall tr_drv_init+0x0/0x1e returned 0 after 172 usecs
calling  tw_drv_init+0x0/0x1e @ 1
initcall tw_drv_init+0x0/0x1e returned 0 after 94 usecs
calling  tsc_drv_init+0x0/0x1e @ 1
initcall tsc_drv_init+0x0/0x1e returned 0 after 139 usecs
calling  tsc2007_driver_init+0x0/0x17 @ 1
initcall tsc2007_driver_init+0x0/0x17 returned 0 after 82 usecs
calling  w8001_drv_init+0x0/0x1e @ 1
initcall w8001_drv_init+0x0/0x1e returned 0 after 76 usecs
calling  wacom_i2c_driver_init+0x0/0x17 @ 1
initcall wacom_i2c_driver_init+0x0/0x17 returned 0 after 78 usecs
calling  wdt87xx_driver_init+0x0/0x17 @ 1
initcall wdt87xx_driver_init+0x0/0x17 returned 0 after 110 usecs
calling  tps6507x_ts_driver_init+0x0/0x17 @ 1
initcall tps6507x_ts_driver_init+0x0/0x17 returned 0 after 58 usecs
calling  rohm_bu21023_i2c_driver_init+0x0/0x17 @ 1
initcall rohm_bu21023_i2c_driver_init+0x0/0x17 returned 0 after 47 usecs
calling  zinitix_ts_driver_init+0x0/0x17 @ 1
initcall zinitix_ts_driver_init+0x0/0x17 returned 0 after 60 usecs
calling  abb5zes3_driver_init+0x0/0x17 @ 1
initcall abb5zes3_driver_init+0x0/0x17 returned 0 after 67 usecs
calling  abx80x_driver_init+0x0/0x17 @ 1
initcall abx80x_driver_init+0x0/0x17 returned 0 after 42 usecs
calling  cmos_init+0x0/0x78 @ 1
rtc_cmos 00:06: RTC can wake from S4
rtc_cmos 00:06: registered as rtc0
rtc_cmos 00:06: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
initcall cmos_init+0x0/0x78 returned 0 after 3177 usecs
calling  ds1307_driver_init+0x0/0x17 @ 1
initcall ds1307_driver_init+0x0/0x17 returned 0 after 54 usecs
calling  ds1343_driver_init+0x0/0x17 @ 1
initcall ds1343_driver_init+0x0/0x17 returned 0 after 60 usecs
calling  ds1347_driver_init+0x0/0x17 @ 1
initcall ds1347_driver_init+0x0/0x17 returned 0 after 51 usecs
calling  ds1390_driver_init+0x0/0x17 @ 1
initcall ds1390_driver_init+0x0/0x17 returned 0 after 39 usecs
calling  ds1553_rtc_driver_init+0x0/0x17 @ 1
initcall ds1553_rtc_driver_init+0x0/0x17 returned 0 after 56 usecs
calling  ds1672_driver_init+0x0/0x17 @ 1
initcall ds1672_driver_init+0x0/0x17 returned 0 after 446 usecs
calling  ds1742_rtc_driver_init+0x0/0x17 @ 1
initcall ds1742_rtc_driver_init+0x0/0x17 returned 0 after 73 usecs
calling  rtc_device_driver_init+0x0/0x17 @ 1
initcall rtc_device_driver_init+0x0/0x17 returned 0 after 42 usecs
calling  ds323x_init+0x0/0x69 @ 1
initcall ds323x_init+0x0/0x69 returned 0 after 118 usecs
calling  ftrtc010_rtc_driver_init+0x0/0x1e @ 1
initcall ftrtc010_rtc_driver_init+0x0/0x1e returned -19 after 70 usecs
calling  isl12022_driver_init+0x0/0x17 @ 1
initcall isl12022_driver_init+0x0/0x17 returned 0 after 56 usecs
calling  isl1208_driver_init+0x0/0x17 @ 1
initcall isl1208_driver_init+0x0/0x17 returned 0 after 81 usecs
calling  m41t93_driver_init+0x0/0x17 @ 1
initcall m41t93_driver_init+0x0/0x17 returned 0 after 40 usecs
calling  m41t94_driver_init+0x0/0x17 @ 1
initcall m41t94_driver_init+0x0/0x17 returned 0 after 38 usecs
calling  m48t35_platform_driver_init+0x0/0x17 @ 1
initcall m48t35_platform_driver_init+0x0/0x17 returned 0 after 56 usecs
calling  m48t59_rtc_driver_init+0x0/0x17 @ 1
initcall m48t59_rtc_driver_init+0x0/0x17 returned 0 after 59 usecs
calling  m48t86_rtc_platform_driver_init+0x0/0x17 @ 1
initcall m48t86_rtc_platform_driver_init+0x0/0x17 returned 0 after 48 usecs
calling  max8997_rtc_driver_init+0x0/0x17 @ 1
initcall max8997_rtc_driver_init+0x0/0x17 returned 0 after 44 usecs
calling  palmas_rtc_driver_init+0x0/0x17 @ 1
initcall palmas_rtc_driver_init+0x0/0x17 returned 0 after 55 usecs
calling  pcf2123_driver_init+0x0/0x17 @ 1
initcall pcf2123_driver_init+0x0/0x17 returned 0 after 52 usecs
calling  pcf85063_driver_init+0x0/0x17 @ 1
initcall pcf85063_driver_init+0x0/0x17 returned 0 after 43 usecs
calling  pcf8523_driver_init+0x0/0x17 @ 1
initcall pcf8523_driver_init+0x0/0x17 returned 0 after 41 usecs
calling  pcf8563_driver_init+0x0/0x17 @ 1
initcall pcf8563_driver_init+0x0/0x17 returned 0 after 54 usecs
calling  r9701_driver_init+0x0/0x17 @ 1
initcall r9701_driver_init+0x0/0x17 returned 0 after 63 usecs
calling  rv3028_driver_init+0x0/0x17 @ 1
initcall rv3028_driver_init+0x0/0x17 returned 0 after 42 usecs
calling  rv30x9_init+0x0/0x4b @ 1
initcall rv30x9_init+0x0/0x4b returned 0 after 132 usecs
calling  rv8803_driver_init+0x0/0x17 @ 1
initcall rv8803_driver_init+0x0/0x17 returned 0 after 64 usecs
calling  rx8010_driver_init+0x0/0x17 @ 1
initcall rx8010_driver_init+0x0/0x17 returned 0 after 53 usecs
calling  rx8025_driver_init+0x0/0x17 @ 1
initcall rx8025_driver_init+0x0/0x17 returned 0 after 97 usecs
calling  rx8581_driver_init+0x0/0x17 @ 1
initcall rx8581_driver_init+0x0/0x17 returned 0 after 102 usecs
calling  s35390a_driver_init+0x0/0x17 @ 1
initcall s35390a_driver_init+0x0/0x17 returned 0 after 182 usecs
calling  stk17ta8_rtc_driver_init+0x0/0x17 @ 1
initcall stk17ta8_rtc_driver_init+0x0/0x17 returned 0 after 129 usecs
calling  wm8350_rtc_driver_init+0x0/0x17 @ 1
initcall wm8350_rtc_driver_init+0x0/0x17 returned 0 after 78 usecs
calling  smbalert_driver_init+0x0/0x17 @ 1
initcall smbalert_driver_init+0x0/0x17 returned 0 after 58 usecs
calling  i2c_dev_init+0x0/0xef @ 1
i2c_dev: i2c /dev entries driver
initcall i2c_dev_init+0x0/0xef returned 0 after 501 usecs
calling  kempld_i2c_driver_init+0x0/0x17 @ 1
initcall kempld_i2c_driver_init+0x0/0x17 returned 0 after 132 usecs
calling  ocores_i2c_driver_init+0x0/0x17 @ 1
initcall ocores_i2c_driver_init+0x0/0x17 returned 0 after 47 usecs
calling  i2c_pca_pf_driver_init+0x0/0x17 @ 1
initcall i2c_pca_pf_driver_init+0x0/0x17 returned 0 after 45 usecs
calling  simtec_i2c_driver_init+0x0/0x17 @ 1
initcall simtec_i2c_driver_init+0x0/0x17 returned 0 after 61 usecs
calling  taos_drv_init+0x0/0x1e @ 1
initcall taos_drv_init+0x0/0x1e returned 0 after 94 usecs
calling  mlxcpld_i2c_driver_init+0x0/0x17 @ 1
initcall mlxcpld_i2c_driver_init+0x0/0x17 returned 0 after 163 usecs
calling  pca954x_driver_init+0x0/0x17 @ 1
initcall pca954x_driver_init+0x0/0x17 returned 0 after 92 usecs
calling  i2c_mux_reg_driver_init+0x0/0x17 @ 1
initcall i2c_mux_reg_driver_init+0x0/0x17 returned 0 after 58 usecs
calling  i2c_slave_eeprom_driver_init+0x0/0x17 @ 1
initcall i2c_slave_eeprom_driver_init+0x0/0x17 returned 0 after 50 usecs
calling  cdns_i3c_master_init+0x0/0x17 @ 1
initcall cdns_i3c_master_init+0x0/0x17 returned 0 after 75 usecs
calling  ad9389b_driver_init+0x0/0x17 @ 1
initcall ad9389b_driver_init+0x0/0x17 returned 0 after 62 usecs
calling  adv7170_driver_init+0x0/0x17 @ 1
initcall adv7170_driver_init+0x0/0x17 returned 0 after 47 usecs
calling  adv7175_driver_init+0x0/0x17 @ 1
initcall adv7175_driver_init+0x0/0x17 returned 0 after 51 usecs
calling  adv7180_driver_init+0x0/0x17 @ 1
initcall adv7180_driver_init+0x0/0x17 returned 0 after 63 usecs
calling  adv7183_driver_init+0x0/0x17 @ 1
initcall adv7183_driver_init+0x0/0x17 returned 0 after 59 usecs
calling  adv7393_driver_init+0x0/0x17 @ 1
initcall adv7393_driver_init+0x0/0x17 returned 0 after 46 usecs
calling  adv76xx_driver_init+0x0/0x17 @ 1
initcall adv76xx_driver_init+0x0/0x17 returned 0 after 46 usecs
calling  adv7842_driver_init+0x0/0x17 @ 1
initcall adv7842_driver_init+0x0/0x17 returned 0 after 57 usecs
calling  bt856_driver_init+0x0/0x17 @ 1
initcall bt856_driver_init+0x0/0x17 returned 0 after 58 usecs
calling  bt866_driver_init+0x0/0x17 @ 1
initcall bt866_driver_init+0x0/0x17 returned 0 after 83 usecs
calling  cs5345_driver_init+0x0/0x17 @ 1
initcall cs5345_driver_init+0x0/0x17 returned 0 after 41 usecs
calling  cs53l32a_driver_init+0x0/0x17 @ 1
initcall cs53l32a_driver_init+0x0/0x17 returned 0 after 41 usecs
calling  cx25840_driver_init+0x0/0x17 @ 1
initcall cx25840_driver_init+0x0/0x17 returned 0 after 167 usecs
calling  ml86v7667_i2c_driver_init+0x0/0x17 @ 1
initcall ml86v7667_i2c_driver_init+0x0/0x17 returned 0 after 42 usecs
calling  msp_driver_init+0x0/0x17 @ 1
initcall msp_driver_init+0x0/0x17 returned 0 after 41 usecs
calling  saa6752hs_driver_init+0x0/0x17 @ 1
initcall saa6752hs_driver_init+0x0/0x17 returned 0 after 41 usecs
calling  saa7110_driver_init+0x0/0x17 @ 1
initcall saa7110_driver_init+0x0/0x17 returned 0 after 79 usecs
calling  saa711x_driver_init+0x0/0x17 @ 1
initcall saa711x_driver_init+0x0/0x17 returned 0 after 40 usecs
calling  saa7127_driver_init+0x0/0x17 @ 1
initcall saa7127_driver_init+0x0/0x17 returned 0 after 45 usecs
calling  saa717x_driver_init+0x0/0x17 @ 1
initcall saa717x_driver_init+0x0/0x17 returned 0 after 41 usecs
calling  mipid02_i2c_driver_init+0x0/0x17 @ 1
initcall mipid02_i2c_driver_init+0x0/0x17 returned 0 after 61 usecs
calling  tc358743_driver_init+0x0/0x17 @ 1
initcall tc358743_driver_init+0x0/0x17 returned 0 after 43 usecs
calling  tda7432_driver_init+0x0/0x17 @ 1
initcall tda7432_driver_init+0x0/0x17 returned 0 after 41 usecs
calling  tea6415c_driver_init+0x0/0x17 @ 1
initcall tea6415c_driver_init+0x0/0x17 returned 0 after 40 usecs
calling  ths7303_driver_init+0x0/0x17 @ 1
initcall ths7303_driver_init+0x0/0x17 returned 0 after 62 usecs
calling  ths8200_driver_init+0x0/0x17 @ 1
initcall ths8200_driver_init+0x0/0x17 returned 0 after 42 usecs
calling  tlv320aic23b_driver_init+0x0/0x17 @ 1
initcall tlv320aic23b_driver_init+0x0/0x17 returned 0 after 41 usecs
calling  tvaudio_driver_init+0x0/0x17 @ 1
initcall tvaudio_driver_init+0x0/0x17 returned 0 after 40 usecs
calling  tvp5150_driver_init+0x0/0x17 @ 1
initcall tvp5150_driver_init+0x0/0x17 returned 0 after 63 usecs
calling  tw9903_driver_init+0x0/0x17 @ 1
initcall tw9903_driver_init+0x0/0x17 returned 0 after 51 usecs
calling  tw9906_driver_init+0x0/0x17 @ 1
initcall tw9906_driver_init+0x0/0x17 returned 0 after 40 usecs
calling  upd64083_driver_init+0x0/0x17 @ 1
initcall upd64083_driver_init+0x0/0x17 returned 0 after 40 usecs
calling  vp27smpx_driver_init+0x0/0x17 @ 1
initcall vp27smpx_driver_init+0x0/0x17 returned 0 after 52 usecs
calling  vpx3220_driver_init+0x0/0x17 @ 1
initcall vpx3220_driver_init+0x0/0x17 returned 0 after 50 usecs
calling  wm8739_driver_init+0x0/0x17 @ 1
initcall wm8739_driver_init+0x0/0x17 returned 0 after 44 usecs
calling  wm8775_driver_init+0x0/0x17 @ 1
initcall wm8775_driver_init+0x0/0x17 returned 0 after 40 usecs
calling  e4000_driver_init+0x0/0x17 @ 1
initcall e4000_driver_init+0x0/0x17 returned 0 after 42 usecs
calling  it913x_driver_init+0x0/0x17 @ 1
initcall it913x_driver_init+0x0/0x17 returned 0 after 64 usecs
calling  m88rs6000t_driver_init+0x0/0x17 @ 1
initcall m88rs6000t_driver_init+0x0/0x17 returned 0 after 52 usecs
calling  msi001_driver_init+0x0/0x17 @ 1
initcall msi001_driver_init+0x0/0x17 returned 0 after 37 usecs
calling  mt2060_driver_init+0x0/0x17 @ 1
initcall mt2060_driver_init+0x0/0x17 returned 0 after 49 usecs
calling  mxl301rf_driver_init+0x0/0x17 @ 1
initcall mxl301rf_driver_init+0x0/0x17 returned 0 after 40 usecs
calling  si2157_driver_init+0x0/0x17 @ 1
initcall si2157_driver_init+0x0/0x17 returned 0 after 30 usecs
calling  tua9001_driver_init+0x0/0x17 @ 1
initcall tua9001_driver_init+0x0/0x17 returned 0 after 30 usecs
calling  init_rc_map_adstech_dvb_t_pci+0x0/0x15 @ 1
initcall init_rc_map_adstech_dvb_t_pci+0x0/0x15 returned 0 after 8 usecs
calling  init_rc_map_alink_dtu_m+0x0/0x15 @ 1
initcall init_rc_map_alink_dtu_m+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_anysee+0x0/0x15 @ 1
initcall init_rc_map_anysee+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_apac_viewcomp+0x0/0x15 @ 1
initcall init_rc_map_apac_viewcomp+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_t2hybrid+0x0/0x15 @ 1
initcall init_rc_map_t2hybrid+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_asus_pc39+0x0/0x15 @ 1
initcall init_rc_map_asus_pc39+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_asus_ps3_100+0x0/0x15 @ 1
initcall init_rc_map_asus_ps3_100+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_ati_tv_wonder_hd_600+0x0/0x15 @ 1
initcall init_rc_map_ati_tv_wonder_hd_600+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_ati_x10+0x0/0x15 @ 1
initcall init_rc_map_ati_x10+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_avermedia_a16d+0x0/0x15 @ 1
initcall init_rc_map_avermedia_a16d+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_avermedia_cardbus+0x0/0x15 @ 1
initcall init_rc_map_avermedia_cardbus+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_avermedia_dvbt+0x0/0x15 @ 1
initcall init_rc_map_avermedia_dvbt+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_avermedia_m135a+0x0/0x15 @ 1
initcall init_rc_map_avermedia_m135a+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_avermedia_m733a_rm_k6+0x0/0x15 @ 1
initcall init_rc_map_avermedia_m733a_rm_k6+0x0/0x15 returned 0 after 1 usecs
calling  init_rc_map_avermedia+0x0/0x15 @ 1
initcall init_rc_map_avermedia+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_avermedia_rm_ks+0x0/0x15 @ 1
initcall init_rc_map_avermedia_rm_ks+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_avertv_303+0x0/0x15 @ 1
initcall init_rc_map_avertv_303+0x0/0x15 returned 0 after 4 usecs
calling  init_rc_map_azurewave_ad_tu700+0x0/0x15 @ 1
initcall init_rc_map_azurewave_ad_tu700+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_beelink_gs1+0x0/0x15 @ 1
initcall init_rc_map_beelink_gs1+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_behold_columbus+0x0/0x15 @ 1
initcall init_rc_map_behold_columbus+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_behold+0x0/0x15 @ 1
initcall init_rc_map_behold+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_budget_ci_old+0x0/0x15 @ 1
initcall init_rc_map_budget_ci_old+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_cinergy_1400+0x0/0x15 @ 1
initcall init_rc_map_cinergy_1400+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_cinergy+0x0/0x15 @ 1
initcall init_rc_map_cinergy+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_ct_90405+0x0/0x15 @ 1
initcall init_rc_map_ct_90405+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_d680_dmb+0x0/0x15 @ 1
initcall init_rc_map_d680_dmb+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_delock_61959+0x0/0x15 @ 1
initcall init_rc_map_delock_61959+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map+0x0/0x15 @ 1
initcall init_rc_map+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map+0x0/0x15 @ 1
initcall init_rc_map+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_digitalnow_tinytwin+0x0/0x15 @ 1
initcall init_rc_map_digitalnow_tinytwin+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_digittrade+0x0/0x15 @ 1
initcall init_rc_map_digittrade+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_dm1105_nec+0x0/0x15 @ 1
initcall init_rc_map_dm1105_nec+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_dntv_live_dvb_t+0x0/0x15 @ 1
initcall init_rc_map_dntv_live_dvb_t+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_dntv_live_dvbt_pro+0x0/0x15 @ 1
initcall init_rc_map_dntv_live_dvbt_pro+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_dtt200u+0x0/0x15 @ 1
initcall init_rc_map_dtt200u+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_rc5_dvbsky+0x0/0x15 @ 1
initcall init_rc_map_rc5_dvbsky+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_dvico_mce+0x0/0x15 @ 1
initcall init_rc_map_dvico_mce+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_dvico_portable+0x0/0x15 @ 1
initcall init_rc_map_dvico_portable+0x0/0x15 returned 0 after 4 usecs
calling  init_rc_map_em_terratec+0x0/0x15 @ 1
initcall init_rc_map_em_terratec+0x0/0x15 returned 0 after 5 usecs
calling  init_rc_map_encore_enltv2+0x0/0x15 @ 1
initcall init_rc_map_encore_enltv2+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_encore_enltv_fm53+0x0/0x15 @ 1
initcall init_rc_map_encore_enltv_fm53+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_encore_enltv+0x0/0x15 @ 1
initcall init_rc_map_encore_enltv+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_evga_indtube+0x0/0x15 @ 1
initcall init_rc_map_evga_indtube+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_eztv+0x0/0x15 @ 1
initcall init_rc_map_eztv+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_flydvb+0x0/0x15 @ 1
initcall init_rc_map_flydvb+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_flyvideo+0x0/0x15 @ 1
initcall init_rc_map_flyvideo+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_fusionhdtv_mce+0x0/0x15 @ 1
initcall init_rc_map_fusionhdtv_mce+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_gadmei_rm008z+0x0/0x15 @ 1
initcall init_rc_map_gadmei_rm008z+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_geekbox+0x0/0x15 @ 1
initcall init_rc_map_geekbox+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_genius_tvgo_a11mce+0x0/0x15 @ 1
initcall init_rc_map_genius_tvgo_a11mce+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_gotview7135+0x0/0x15 @ 1
initcall init_rc_map_gotview7135+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_rc5_hauppauge_new+0x0/0x15 @ 1
initcall init_rc_map_rc5_hauppauge_new+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_hisi_poplar+0x0/0x15 @ 1
initcall init_rc_map_hisi_poplar+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_hisi_tv_demo+0x0/0x15 @ 1
initcall init_rc_map_hisi_tv_demo+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_imon_mce+0x0/0x15 @ 1
initcall init_rc_map_imon_mce+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_imon_pad+0x0/0x15 @ 1
initcall init_rc_map_imon_pad+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_imon_rsc+0x0/0x15 @ 1
initcall init_rc_map_imon_rsc+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_iodata_bctv7e+0x0/0x15 @ 1
initcall init_rc_map_iodata_bctv7e+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_it913x_v1_map+0x0/0x15 @ 1
initcall init_rc_it913x_v1_map+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_it913x_v2_map+0x0/0x15 @ 1
initcall init_rc_it913x_v2_map+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_kaiomy+0x0/0x15 @ 1
initcall init_rc_map_kaiomy+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_khadas+0x0/0x15 @ 1
initcall init_rc_map_khadas+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_khamsin+0x0/0x15 @ 1
initcall init_rc_map_khamsin+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_kworld_315u+0x0/0x15 @ 1
initcall init_rc_map_kworld_315u+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_kworld_pc150u+0x0/0x15 @ 1
initcall init_rc_map_kworld_pc150u+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_kworld_plus_tv_analog+0x0/0x15 @ 1
initcall init_rc_map_kworld_plus_tv_analog+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_leadtek_y04g0051+0x0/0x15 @ 1
initcall init_rc_map_leadtek_y04g0051+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_lme2510_map+0x0/0x15 @ 1
initcall init_rc_lme2510_map+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_manli+0x0/0x15 @ 1
initcall init_rc_map_manli+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_mecool_kiii_pro+0x0/0x15 @ 1
initcall init_rc_map_mecool_kiii_pro+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_mecool_kii_pro+0x0/0x15 @ 1
initcall init_rc_map_mecool_kii_pro+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_medion_x10_digitainer+0x0/0x15 @ 1
initcall init_rc_map_medion_x10_digitainer+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_medion_x10+0x0/0x15 @ 1
initcall init_rc_map_medion_x10+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_medion_x10_or2x+0x0/0x15 @ 1
initcall init_rc_map_medion_x10_or2x+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_minix_neo+0x0/0x15 @ 1
initcall init_rc_map_minix_neo+0x0/0x15 returned 0 after 4 usecs
calling  init_rc_map_msi_digivox_iii+0x0/0x15 @ 1
initcall init_rc_map_msi_digivox_iii+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_msi_digivox_ii+0x0/0x15 @ 1
initcall init_rc_map_msi_digivox_ii+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_msi_tvanywhere+0x0/0x15 @ 1
initcall init_rc_map_msi_tvanywhere+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_msi_tvanywhere_plus+0x0/0x15 @ 1
initcall init_rc_map_msi_tvanywhere_plus+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_nebula+0x0/0x15 @ 1
initcall init_rc_map_nebula+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_nec_terratec_cinergy_xs+0x0/0x15 @ 1
initcall init_rc_map_nec_terratec_cinergy_xs+0x0/0x15 returned 0 after 24 usecs
calling  init_rc_map_norwood+0x0/0x15 @ 1
initcall init_rc_map_norwood+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_npgtech+0x0/0x15 @ 1
initcall init_rc_map_npgtech+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_odroid+0x0/0x15 @ 1
initcall init_rc_map_odroid+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_pctv_sedna+0x0/0x15 @ 1
initcall init_rc_map_pctv_sedna+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_pine64+0x0/0x15 @ 1
initcall init_rc_map_pine64+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_pinnacle_color+0x0/0x15 @ 1
initcall init_rc_map_pinnacle_color+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_pinnacle_grey+0x0/0x15 @ 1
initcall init_rc_map_pinnacle_grey+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_pinnacle_pctv_hd+0x0/0x15 @ 1
initcall init_rc_map_pinnacle_pctv_hd+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_pixelview+0x0/0x15 @ 1
initcall init_rc_map_pixelview+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_pixelview+0x0/0x15 @ 1
initcall init_rc_map_pixelview+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_pixelview_new+0x0/0x15 @ 1
initcall init_rc_map_pixelview_new+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_pixelview+0x0/0x15 @ 1
initcall init_rc_map_pixelview+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_powercolor_real_angel+0x0/0x15 @ 1
initcall init_rc_map_powercolor_real_angel+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_proteus_2309+0x0/0x15 @ 1
initcall init_rc_map_proteus_2309+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_purpletv+0x0/0x15 @ 1
initcall init_rc_map_purpletv+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_pv951+0x0/0x15 @ 1
initcall init_rc_map_pv951+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_rc6_mce+0x0/0x15 @ 1
initcall init_rc_map_rc6_mce+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_real_audio_220_32_keys+0x0/0x15 @ 1
initcall init_rc_map_real_audio_220_32_keys+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_reddo+0x0/0x15 @ 1
initcall init_rc_map_reddo+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_snapstream_firefly+0x0/0x15 @ 1
initcall init_rc_map_snapstream_firefly+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_streamzap+0x0/0x15 @ 1
initcall init_rc_map_streamzap+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_su3000+0x0/0x15 @ 1
initcall init_rc_map_su3000+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_tanix_tx3mini+0x0/0x15 @ 1
initcall init_rc_map_tanix_tx3mini+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_tanix_tx5max+0x0/0x15 @ 1
initcall init_rc_map_tanix_tx5max+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_tbs_nec+0x0/0x15 @ 1
initcall init_rc_map_tbs_nec+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map+0x0/0x15 @ 1
initcall init_rc_map+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map+0x0/0x15 @ 1
initcall init_rc_map+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_terratec_cinergy_c_pci+0x0/0x15 @ 1
initcall init_rc_map_terratec_cinergy_c_pci+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_terratec_cinergy_s2_hd+0x0/0x15 @ 1
initcall init_rc_map_terratec_cinergy_s2_hd+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_terratec_cinergy_xs+0x0/0x15 @ 1
initcall init_rc_map_terratec_cinergy_xs+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_terratec_slim_2+0x0/0x15 @ 1
initcall init_rc_map_terratec_slim_2+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_terratec_slim+0x0/0x15 @ 1
initcall init_rc_map_terratec_slim+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_tevii_nec+0x0/0x15 @ 1
initcall init_rc_map_tevii_nec+0x0/0x15 returned 0 after 2 usecs
calling  init_rc_map_tivo+0x0/0x15 @ 1
initcall init_rc_map_tivo+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_total_media_in_hand_02+0x0/0x15 @ 1
initcall init_rc_map_total_media_in_hand_02+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_total_media_in_hand+0x0/0x15 @ 1
initcall init_rc_map_total_media_in_hand+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_trekstor+0x0/0x15 @ 1
initcall init_rc_map_trekstor+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_tt_1500+0x0/0x15 @ 1
initcall init_rc_map_tt_1500+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_twinhan_vp1027+0x0/0x15 @ 1
initcall init_rc_map_twinhan_vp1027+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_twinhan_dtv_cab_ci+0x0/0x15 @ 1
initcall init_rc_map_twinhan_dtv_cab_ci+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_vega_s9x+0x0/0x15 @ 1
initcall init_rc_map_vega_s9x+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_videomate_k100+0x0/0x15 @ 1
initcall init_rc_map_videomate_k100+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_videomate_s350+0x0/0x15 @ 1
initcall init_rc_map_videomate_s350+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_videomate_tv_pvr+0x0/0x15 @ 1
initcall init_rc_map_videomate_tv_pvr+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_kii_pro+0x0/0x15 @ 1
initcall init_rc_map_kii_pro+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_wetek_hub+0x0/0x15 @ 1
initcall init_rc_map_wetek_hub+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_wetek_play2+0x0/0x15 @ 1
initcall init_rc_map_wetek_play2+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_winfast+0x0/0x15 @ 1
initcall init_rc_map_winfast+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_winfast_usbii_deluxe+0x0/0x15 @ 1
initcall init_rc_map_winfast_usbii_deluxe+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_x96max+0x0/0x15 @ 1
initcall init_rc_map_x96max+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map+0x0/0x15 @ 1
initcall init_rc_map+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map+0x0/0x15 @ 1
initcall init_rc_map+0x0/0x15 returned 0 after 3 usecs
calling  init_rc_map_zx_irdec+0x0/0x15 @ 1
initcall init_rc_map_zx_irdec+0x0/0x15 returned 0 after 3 usecs
calling  deinterlace_pdrv_init+0x0/0x17 @ 1
initcall deinterlace_pdrv_init+0x0/0x17 returned 0 after 947 usecs
calling  gs_driver_init+0x0/0x17 @ 1
initcall gs_driver_init+0x0/0x17 returned 0 after 183 usecs
calling  saa7706h_driver_init+0x0/0x17 @ 1
initcall saa7706h_driver_init+0x0/0x17 returned 0 after 137 usecs
calling  tea5764_i2c_driver_init+0x0/0x17 @ 1
initcall tea5764_i2c_driver_init+0x0/0x17 returned 0 after 121 usecs
calling  tef6862_driver_init+0x0/0x17 @ 1
initcall tef6862_driver_init+0x0/0x17 returned 0 after 156 usecs
calling  wl1273_fm_radio_driver_init+0x0/0x17 @ 1
initcall wl1273_fm_radio_driver_init+0x0/0x17 returned 0 after 156 usecs
calling  ptp_kvm_init+0x0/0xff @ 1
initcall ptp_kvm_init+0x0/0xff returned 0 after 2381 usecs
calling  w1_init+0x0/0xa5 @ 1
Driver for 1-wire Dallas network protocol.
initcall w1_init+0x0/0xa5 returned 0 after 1226 usecs
calling  w1_gpio_driver_init+0x0/0x17 @ 1
initcall w1_gpio_driver_init+0x0/0x17 returned 0 after 121 usecs
calling  w1_therm_init+0x0/0xa7 @ 1
initcall w1_therm_init+0x0/0xa7 returned 0 after 84 usecs
calling  w1_smem_init+0x0/0x47 @ 1
initcall w1_smem_init+0x0/0x47 returned 0 after 8 usecs
calling  w1_family_3a_init+0x0/0x15 @ 1
initcall w1_family_3a_init+0x0/0x15 returned 0 after 7 usecs
calling  w1_family_1d_init+0x0/0x15 @ 1
initcall w1_family_1d_init+0x0/0x15 returned 0 after 6 usecs
calling  w1_family_2d_init+0x0/0x15 @ 1
initcall w1_family_2d_init+0x0/0x15 returned 0 after 7 usecs
calling  w1_ds2780_family_init+0x0/0x15 @ 1
initcall w1_ds2780_family_init+0x0/0x15 returned 0 after 7 usecs
calling  w1_ds2781_family_init+0x0/0x15 @ 1
initcall w1_ds2781_family_init+0x0/0x15 returned 0 after 7 usecs
calling  w1_family_1C_init+0x0/0x15 @ 1
initcall w1_family_1C_init+0x0/0x15 returned 0 after 7 usecs
calling  pda_power_pdrv_init+0x0/0x17 @ 1
initcall pda_power_pdrv_init+0x0/0x17 returned 0 after 159 usecs
calling  wm831x_power_driver_init+0x0/0x17 @ 1
initcall wm831x_power_driver_init+0x0/0x17 returned 0 after 215 usecs
calling  wm8350_power_driver_init+0x0/0x17 @ 1
initcall wm8350_power_driver_init+0x0/0x17 returned 0 after 186 usecs
calling  w1_ds2760_family_init+0x0/0x15 @ 1
initcall w1_ds2760_family_init+0x0/0x15 returned 0 after 9 usecs
calling  ds2780_battery_driver_init+0x0/0x17 @ 1
initcall ds2780_battery_driver_init+0x0/0x17 returned 0 after 146 usecs
calling  ds2781_battery_driver_init+0x0/0x17 @ 1
initcall ds2781_battery_driver_init+0x0/0x17 returned 0 after 206 usecs
calling  ltc294x_driver_init+0x0/0x17 @ 1
initcall ltc294x_driver_init+0x0/0x17 returned 0 after 187 usecs
calling  goldfish_battery_device_init+0x0/0x17 @ 1
initcall goldfish_battery_device_init+0x0/0x17 returned 0 after 130 usecs
calling  sbs_battery_driver_init+0x0/0x17 @ 1
initcall sbs_battery_driver_init+0x0/0x17 returned 0 after 126 usecs
calling  sbs_driver_init+0x0/0x17 @ 1
initcall sbs_driver_init+0x0/0x17 returned 0 after 204 usecs
calling  sbsm_driver_init+0x0/0x17 @ 1
initcall sbsm_driver_init+0x0/0x17 returned 0 after 176 usecs
calling  max17040_i2c_driver_init+0x0/0x17 @ 1
initcall max17040_i2c_driver_init+0x0/0x17 returned 0 after 108 usecs
calling  max17042_i2c_driver_init+0x0/0x17 @ 1
initcall max17042_i2c_driver_init+0x0/0x17 returned 0 after 104 usecs
calling  w1_max1721x_family_init+0x0/0x15 @ 1
initcall w1_max1721x_family_init+0x0/0x15 returned 0 after 9 usecs
calling  rt5033_battery_driver_init+0x0/0x17 @ 1
initcall rt5033_battery_driver_init+0x0/0x17 returned 0 after 127 usecs
calling  max8903_driver_init+0x0/0x17 @ 1
initcall max8903_driver_init+0x0/0x17 returned 0 after 194 usecs
calling  lp8727_driver_init+0x0/0x17 @ 1
initcall lp8727_driver_init+0x0/0x17 returned 0 after 144 usecs
calling  lt3651_charger_driver_init+0x0/0x17 @ 1
initcall lt3651_charger_driver_init+0x0/0x17 returned 0 after 153 usecs
calling  bq2415x_driver_init+0x0/0x17 @ 1
initcall bq2415x_driver_init+0x0/0x17 returned 0 after 106 usecs
calling  bq24190_driver_init+0x0/0x17 @ 1
initcall bq24190_driver_init+0x0/0x17 returned 0 after 126 usecs
calling  bq24257_driver_init+0x0/0x17 @ 1
initcall bq24257_driver_init+0x0/0x17 returned 0 after 136 usecs
calling  bq24735_charger_driver_init+0x0/0x17 @ 1
initcall bq24735_charger_driver_init+0x0/0x17 returned 0 after 90 usecs
calling  bq2515x_driver_init+0x0/0x17 @ 1
initcall bq2515x_driver_init+0x0/0x17 returned 0 after 97 usecs
calling  bq25890_driver_init+0x0/0x17 @ 1
initcall bq25890_driver_init+0x0/0x17 returned 0 after 142 usecs
calling  asb100_driver_init+0x0/0x17 @ 1
initcall asb100_driver_init+0x0/0x17 returned 0 after 123 usecs
calling  sensors_w83627hf_init+0x0/0x1f8 @ 1
initcall sensors_w83627hf_init+0x0/0x1f8 returned -19 after 110 usecs
calling  w83773_driver_init+0x0/0x17 @ 1
initcall w83773_driver_init+0x0/0x17 returned 0 after 72 usecs
calling  w83792d_driver_init+0x0/0x17 @ 1
initcall w83792d_driver_init+0x0/0x17 returned 0 after 145 usecs
calling  w83793_driver_init+0x0/0x17 @ 1
initcall w83793_driver_init+0x0/0x17 returned 0 after 127 usecs
calling  w83795_driver_init+0x0/0x17 @ 1
initcall w83795_driver_init+0x0/0x17 returned 0 after 127 usecs
calling  sensors_w83781d_init+0x0/0x17 @ 1
initcall sensors_w83781d_init+0x0/0x17 returned 0 after 87 usecs
calling  w83791d_driver_init+0x0/0x17 @ 1
initcall w83791d_driver_init+0x0/0x17 returned 0 after 157 usecs
calling  abituguru3_init+0x0/0x1ec @ 1
initcall abituguru3_init+0x0/0x1ec returned -19 after 2 usecs
calling  ad7314_driver_init+0x0/0x17 @ 1
initcall ad7314_driver_init+0x0/0x17 returned 0 after 162 usecs
calling  ad7414_driver_init+0x0/0x17 @ 1
initcall ad7414_driver_init+0x0/0x17 returned 0 after 183 usecs
calling  ad7418_driver_init+0x0/0x17 @ 1
initcall ad7418_driver_init+0x0/0x17 returned 0 after 127 usecs
calling  adc128_driver_init+0x0/0x17 @ 1
initcall adc128_driver_init+0x0/0x17 returned 0 after 102 usecs
calling  adcxx_driver_init+0x0/0x17 @ 1
initcall adcxx_driver_init+0x0/0x17 returned 0 after 134 usecs
calling  adm1031_driver_init+0x0/0x17 @ 1
initcall adm1031_driver_init+0x0/0x17 returned 0 after 138 usecs
calling  adm1177_driver_init+0x0/0x17 @ 1
initcall adm1177_driver_init+0x0/0x17 returned 0 after 136 usecs
calling  adm9240_driver_init+0x0/0x17 @ 1
initcall adm9240_driver_init+0x0/0x17 returned 0 after 102 usecs
calling  ads7828_driver_init+0x0/0x17 @ 1
initcall ads7828_driver_init+0x0/0x17 returned 0 after 152 usecs
calling  ads7871_driver_init+0x0/0x17 @ 1
initcall ads7871_driver_init+0x0/0x17 returned 0 after 88 usecs
calling  adt7410_driver_init+0x0/0x17 @ 1
initcall adt7410_driver_init+0x0/0x17 returned 0 after 167 usecs
calling  adt7462_driver_init+0x0/0x17 @ 1
initcall adt7462_driver_init+0x0/0x17 returned 0 after 96 usecs
calling  adt7470_driver_init+0x0/0x17 @ 1
initcall adt7470_driver_init+0x0/0x17 returned 0 after 145 usecs
calling  adt7475_driver_init+0x0/0x17 @ 1
initcall adt7475_driver_init+0x0/0x17 returned 0 after 80 usecs
calling  axi_fan_control_driver_init+0x0/0x17 @ 1
initcall axi_fan_control_driver_init+0x0/0x17 returned 0 after 144 usecs
calling  i8k_init+0x0/0xf6 @ 1
initcall i8k_init+0x0/0xf6 returned -19 after 4 usecs
calling  dme1737_init+0x0/0x20b @ 1
initcall dme1737_init+0x0/0x20b returned 0 after 150 usecs
calling  emc2103_driver_init+0x0/0x17 @ 1
initcall emc2103_driver_init+0x0/0x17 returned 0 after 121 usecs
calling  emc6w201_driver_init+0x0/0x17 @ 1
initcall emc6w201_driver_init+0x0/0x17 returned 0 after 76 usecs
calling  f71882fg_init+0x0/0x1f7 @ 1
initcall f71882fg_init+0x0/0x1f7 returned -19 after 77 usecs
calling  f75375_driver_init+0x0/0x17 @ 1
initcall f75375_driver_init+0x0/0x17 returned 0 after 137 usecs
calling  g762_driver_init+0x0/0x17 @ 1
initcall g762_driver_init+0x0/0x17 returned 0 after 78 usecs
calling  gl518_driver_init+0x0/0x17 @ 1
initcall gl518_driver_init+0x0/0x17 returned 0 after 102 usecs
calling  hih6130_driver_init+0x0/0x17 @ 1
initcall hih6130_driver_init+0x0/0x17 returned 0 after 69 usecs
calling  aem_init+0x0/0x55 @ 1
initcall aem_init+0x0/0x55 returned 0 after 106 usecs
calling  ibmpex_init+0x0/0x15 @ 1
initcall ibmpex_init+0x0/0x15 returned 0 after 4 usecs
calling  ina2xx_driver_init+0x0/0x17 @ 1
initcall ina2xx_driver_init+0x0/0x17 returned 0 after 147 usecs
calling  intel_m10bmc_hwmon_driver_init+0x0/0x17 @ 1
initcall intel_m10bmc_hwmon_driver_init+0x0/0x17 returned 0 after 121 usecs
calling  sm_it87_init+0x0/0x36e @ 1
initcall sm_it87_init+0x0/0x36e returned -19 after 257 usecs
calling  lm63_driver_init+0x0/0x17 @ 1
initcall lm63_driver_init+0x0/0x17 returned 0 after 84 usecs
calling  lm70_driver_init+0x0/0x17 @ 1
initcall lm70_driver_init+0x0/0x17 returned 0 after 125 usecs
calling  lm73_driver_init+0x0/0x17 @ 1
initcall lm73_driver_init+0x0/0x17 returned 0 after 113 usecs
calling  lm77_driver_init+0x0/0x17 @ 1
initcall lm77_driver_init+0x0/0x17 returned 0 after 74 usecs
calling  lm80_driver_init+0x0/0x17 @ 1
initcall lm80_driver_init+0x0/0x17 returned 0 after 74 usecs
calling  lm83_driver_init+0x0/0x17 @ 1
initcall lm83_driver_init+0x0/0x17 returned 0 after 118 usecs
calling  lm87_driver_init+0x0/0x17 @ 1
initcall lm87_driver_init+0x0/0x17 returned 0 after 69 usecs
calling  lm90_driver_init+0x0/0x17 @ 1
initcall lm90_driver_init+0x0/0x17 returned 0 after 730 usecs
calling  lm92_driver_init+0x0/0x17 @ 1
initcall lm92_driver_init+0x0/0x17 returned 0 after 47 usecs
calling  lm93_driver_init+0x0/0x17 @ 1
initcall lm93_driver_init+0x0/0x17 returned 0 after 130 usecs
calling  lm95234_driver_init+0x0/0x17 @ 1
initcall lm95234_driver_init+0x0/0x17 returned 0 after 64 usecs
calling  lm95241_driver_init+0x0/0x17 @ 1
initcall lm95241_driver_init+0x0/0x17 returned 0 after 89 usecs
calling  ltc2945_driver_init+0x0/0x17 @ 1
initcall ltc2945_driver_init+0x0/0x17 returned 0 after 60 usecs
calling  ltc2990_i2c_driver_init+0x0/0x17 @ 1
initcall ltc2990_i2c_driver_init+0x0/0x17 returned 0 after 125 usecs
calling  ltc4222_driver_init+0x0/0x17 @ 1
initcall ltc4222_driver_init+0x0/0x17 returned 0 after 122 usecs
calling  ltc4245_driver_init+0x0/0x17 @ 1
initcall ltc4245_driver_init+0x0/0x17 returned 0 after 76 usecs
calling  ltc4260_driver_init+0x0/0x17 @ 1
initcall ltc4260_driver_init+0x0/0x17 returned 0 after 81 usecs
calling  ltc4261_driver_init+0x0/0x17 @ 1
initcall ltc4261_driver_init+0x0/0x17 returned 0 after 97 usecs
calling  max1111_driver_init+0x0/0x17 @ 1
initcall max1111_driver_init+0x0/0x17 returned 0 after 95 usecs
calling  max16065_driver_init+0x0/0x17 @ 1
initcall max16065_driver_init+0x0/0x17 returned 0 after 84 usecs
calling  max1619_driver_init+0x0/0x17 @ 1
initcall max1619_driver_init+0x0/0x17 returned 0 after 90 usecs
calling  max197_driver_init+0x0/0x17 @ 1
initcall max197_driver_init+0x0/0x17 returned 0 after 157 usecs
calling  max31722_driver_init+0x0/0x17 @ 1
initcall max31722_driver_init+0x0/0x17 returned 0 after 77 usecs
calling  max31730_driver_init+0x0/0x17 @ 1
initcall max31730_driver_init+0x0/0x17 returned 0 after 54 usecs
calling  max6621_driver_init+0x0/0x17 @ 1
initcall max6621_driver_init+0x0/0x17 returned 0 after 88 usecs
calling  max6639_driver_init+0x0/0x17 @ 1
initcall max6639_driver_init+0x0/0x17 returned 0 after 108 usecs
calling  max6650_driver_init+0x0/0x17 @ 1
initcall max6650_driver_init+0x0/0x17 returned 0 after 140 usecs
calling  max6697_driver_init+0x0/0x17 @ 1
initcall max6697_driver_init+0x0/0x17 returned 0 after 88 usecs
calling  mc13783_adc_driver_init+0x0/0x1e @ 1
initcall mc13783_adc_driver_init+0x0/0x1e returned -19 after 194 usecs
calling  menf21bmc_hwmon_init+0x0/0x17 @ 1
initcall menf21bmc_hwmon_init+0x0/0x17 returned 0 after 104 usecs
calling  sensors_nct6683_init+0x0/0x30d @ 1
initcall sensors_nct6683_init+0x0/0x30d returned -19 after 277 usecs
calling  npcm7xx_pwm_fan_driver_init+0x0/0x17 @ 1
initcall npcm7xx_pwm_fan_driver_init+0x0/0x17 returned 0 after 148 usecs
calling  pc87360_init+0x0/0xd3 @ 1
pc87360: PC8736x not detected, module not inserted
initcall pc87360_init+0x0/0xd3 returned -19 after 818 usecs
calling  pc87427_init+0x0/0xcc @ 1
initcall pc87427_init+0x0/0xcc returned -19 after 121 usecs
calling  pcf8591_init+0x0/0x38 @ 1
initcall pcf8591_init+0x0/0x38 returned 0 after 117 usecs
calling  powr1220_driver_init+0x0/0x17 @ 1
initcall powr1220_driver_init+0x0/0x17 returned 0 after 100 usecs
calling  sht15_driver_init+0x0/0x17 @ 1
initcall sht15_driver_init+0x0/0x17 returned 0 after 139 usecs
calling  sht21_driver_init+0x0/0x17 @ 1
initcall sht21_driver_init+0x0/0x17 returned 0 after 166 usecs
calling  shtc1_i2c_driver_init+0x0/0x17 @ 1
initcall shtc1_i2c_driver_init+0x0/0x17 returned 0 after 102 usecs
calling  sm_smsc47m1_init+0x0/0x283 @ 1
initcall sm_smsc47m1_init+0x0/0x283 returned -19 after 43 usecs
calling  smsc47m192_driver_init+0x0/0x17 @ 1
initcall smsc47m192_driver_init+0x0/0x17 returned 0 after 106 usecs
calling  stts751_driver_init+0x0/0x17 @ 1
initcall stts751_driver_init+0x0/0x17 returned 0 after 95 usecs
calling  tc74_driver_init+0x0/0x17 @ 1
initcall tc74_driver_init+0x0/0x17 returned 0 after 134 usecs
calling  thmc50_driver_init+0x0/0x17 @ 1
initcall thmc50_driver_init+0x0/0x17 returned 0 after 105 usecs
calling  tmp102_driver_init+0x0/0x17 @ 1
initcall tmp102_driver_init+0x0/0x17 returned 0 after 73 usecs
calling  tmp108_driver_init+0x0/0x17 @ 1
initcall tmp108_driver_init+0x0/0x17 returned 0 after 70 usecs
calling  tmp401_driver_init+0x0/0x17 @ 1
initcall tmp401_driver_init+0x0/0x17 returned 0 after 101 usecs
calling  tmp421_driver_init+0x0/0x17 @ 1
initcall tmp421_driver_init+0x0/0x17 returned 0 after 119 usecs
calling  tmp51x_driver_init+0x0/0x17 @ 1
initcall tmp51x_driver_init+0x0/0x17 returned 0 after 78 usecs
calling  via_cputemp_init+0x0/0x87 @ 1
initcall via_cputemp_init+0x0/0x87 returned -19 after 2 usecs
calling  vt1211_init+0x0/0x21a @ 1
initcall vt1211_init+0x0/0x21a returned -19 after 75 usecs
calling  sensors_w83627ehf_init+0x0/0x15b @ 1
initcall sensors_w83627ehf_init+0x0/0x15b returned -19 after 107 usecs
calling  w83l785ts_driver_init+0x0/0x17 @ 1
initcall w83l785ts_driver_init+0x0/0x17 returned 0 after 125 usecs
calling  w83l786ng_driver_init+0x0/0x17 @ 1
initcall w83l786ng_driver_init+0x0/0x17 returned 0 after 139 usecs
calling  wm831x_hwmon_driver_init+0x0/0x17 @ 1
initcall wm831x_hwmon_driver_init+0x0/0x17 returned 0 after 120 usecs
calling  pmbus_core_init+0x0/0x3c @ 1
initcall pmbus_core_init+0x0/0x3c returned 0 after 77 usecs
calling  adm1266_driver_init+0x0/0x17 @ 1
initcall adm1266_driver_init+0x0/0x17 returned 0 after 107 usecs
calling  adm1275_driver_init+0x0/0x17 @ 1
initcall adm1275_driver_init+0x0/0x17 returned 0 after 150 usecs
calling  pfe_pmbus_driver_init+0x0/0x17 @ 1
initcall pfe_pmbus_driver_init+0x0/0x17 returned 0 after 162 usecs
calling  ibm_cffps_driver_init+0x0/0x17 @ 1
initcall ibm_cffps_driver_init+0x0/0x17 returned 0 after 128 usecs
calling  ipsps_driver_init+0x0/0x17 @ 1
initcall ipsps_driver_init+0x0/0x17 returned 0 after 78 usecs
calling  ir35221_driver_init+0x0/0x17 @ 1
initcall ir35221_driver_init+0x0/0x17 returned 0 after 87 usecs
calling  isl68137_driver_init+0x0/0x17 @ 1
initcall isl68137_driver_init+0x0/0x17 returned 0 after 118 usecs
calling  lm25066_driver_init+0x0/0x17 @ 1
initcall lm25066_driver_init+0x0/0x17 returned 0 after 85 usecs
calling  ltc3815_driver_init+0x0/0x17 @ 1
initcall ltc3815_driver_init+0x0/0x17 returned 0 after 115 usecs
calling  max16064_driver_init+0x0/0x17 @ 1
initcall max16064_driver_init+0x0/0x17 returned 0 after 97 usecs
calling  max16601_driver_init+0x0/0x17 @ 1
initcall max16601_driver_init+0x0/0x17 returned 0 after 599 usecs
calling  max20730_driver_init+0x0/0x17 @ 1
initcall max20730_driver_init+0x0/0x17 returned 0 after 98 usecs
calling  max20751_driver_init+0x0/0x17 @ 1
initcall max20751_driver_init+0x0/0x17 returned 0 after 129 usecs
calling  max31785_driver_init+0x0/0x17 @ 1
initcall max31785_driver_init+0x0/0x17 returned 0 after 98 usecs
calling  max34440_driver_init+0x0/0x17 @ 1
initcall max34440_driver_init+0x0/0x17 returned 0 after 146 usecs
calling  max8688_driver_init+0x0/0x17 @ 1
initcall max8688_driver_init+0x0/0x17 returned 0 after 106 usecs
calling  pxe1610_driver_init+0x0/0x17 @ 1
initcall pxe1610_driver_init+0x0/0x17 returned 0 after 129 usecs
calling  ucd9000_driver_init+0x0/0x17 @ 1
initcall ucd9000_driver_init+0x0/0x17 returned 0 after 130 usecs
calling  ucd9200_driver_init+0x0/0x17 @ 1
initcall ucd9200_driver_init+0x0/0x17 returned 0 after 123 usecs
calling  zl6100_driver_init+0x0/0x17 @ 1
initcall zl6100_driver_init+0x0/0x17 returned 0 after 131 usecs
calling  thermal_throttle_init_device+0x0/0x57 @ 1
initcall thermal_throttle_init_device+0x0/0x57 returned 0 after 2 usecs
calling  haltpoll_init+0x0/0xf7 @ 1
initcall haltpoll_init+0x0/0xf7 returned -19 after 5 usecs
calling  memstick_init+0x0/0x89 @ 1
initcall memstick_init+0x0/0x89 returned 0 after 4178 usecs
calling  msb_init+0x0/0x36 @ 1
initcall msb_init+0x0/0x36 returned 0 after 158 usecs
calling  mspro_block_init+0x0/0x7a @ 1
initcall mspro_block_init+0x0/0x7a returned 0 after 133 usecs
calling  apu_led_init+0x0/0x173 @ 1
leds_apu: No PC Engines APUv1 board detected. For APUv2,3 support, enable CONFIG_PCENGINES_APU2
initcall apu_led_init+0x0/0x173 returned -19 after 1313 usecs
calling  bd2802_i2c_driver_init+0x0/0x17 @ 1
initcall bd2802_i2c_driver_init+0x0/0x17 returned 0 after 169 usecs
calling  blinkm_driver_init+0x0/0x17 @ 1
initcall blinkm_driver_init+0x0/0x17 returned 0 after 185 usecs
calling  gpio_led_driver_init+0x0/0x17 @ 1
initcall gpio_led_driver_init+0x0/0x17 returned 0 after 180 usecs
calling  lm355x_i2c_driver_init+0x0/0x17 @ 1
initcall lm355x_i2c_driver_init+0x0/0x17 returned 0 after 123 usecs
calling  lm36274_driver_init+0x0/0x17 @ 1
initcall lm36274_driver_init+0x0/0x17 returned 0 after 117 usecs
calling  lm3642_i2c_driver_init+0x0/0x17 @ 1
initcall lm3642_i2c_driver_init+0x0/0x17 returned 0 after 156 usecs
calling  lp3944_driver_init+0x0/0x17 @ 1
initcall lp3944_driver_init+0x0/0x17 returned 0 after 167 usecs
calling  lp3952_i2c_driver_init+0x0/0x17 @ 1
initcall lp3952_i2c_driver_init+0x0/0x17 returned 0 after 111 usecs
calling  lp50xx_driver_init+0x0/0x17 @ 1
initcall lp50xx_driver_init+0x0/0x17 returned 0 after 103 usecs
calling  menf21bmc_led_init+0x0/0x17 @ 1
initcall menf21bmc_led_init+0x0/0x17 returned 0 after 177 usecs
calling  mlxcpld_led_init+0x0/0x13c @ 1
initcall mlxcpld_led_init+0x0/0x13c returned -19 after 2 usecs
calling  mlxreg_led_driver_init+0x0/0x17 @ 1
initcall mlxreg_led_driver_init+0x0/0x17 returned 0 after 168 usecs
calling  mt6323_led_driver_init+0x0/0x17 @ 1
initcall mt6323_led_driver_init+0x0/0x17 returned 0 after 120 usecs
calling  pca9532_driver_init+0x0/0x17 @ 1
initcall pca9532_driver_init+0x0/0x17 returned 0 after 164 usecs
calling  pca955x_driver_init+0x0/0x17 @ 1
initcall pca955x_driver_init+0x0/0x17 returned 0 after 114 usecs
calling  tca6507_driver_init+0x0/0x17 @ 1
initcall tca6507_driver_init+0x0/0x17 returned 0 after 173 usecs
calling  tlc591xx_driver_init+0x0/0x17 @ 1
initcall tlc591xx_driver_init+0x0/0x17 returned 0 after 85 usecs
calling  wm831x_status_driver_init+0x0/0x17 @ 1
initcall wm831x_status_driver_init+0x0/0x17 returned 0 after 112 usecs
calling  dac124s085_driver_init+0x0/0x17 @ 1
initcall dac124s085_driver_init+0x0/0x17 returned 0 after 95 usecs
calling  dmi_sysfs_init+0x0/0x12d @ 1
initcall dmi_sysfs_init+0x0/0x12d returned 0 after 1218 usecs
calling  fw_cfg_sysfs_init+0x0/0x8e @ 1
initcall fw_cfg_sysfs_init+0x0/0x8e returned 0 after 3697 usecs
calling  atmel_i2c_init+0x0/0x2e @ 1
initcall atmel_i2c_init+0x0/0x2e returned 0 after 61 usecs
calling  atmel_ecc_init+0x0/0x4c @ 1
initcall atmel_ecc_init+0x0/0x4c returned 0 after 133 usecs
calling  atmel_sha204a_init+0x0/0x17 @ 1
initcall atmel_sha204a_init+0x0/0x17 returned 0 after 214 usecs
calling  meson_crypto_driver_init+0x0/0x17 @ 1
initcall meson_crypto_driver_init+0x0/0x17 returned 0 after 117 usecs
calling  bcma_modinit+0x0/0x36 @ 1
initcall bcma_modinit+0x0/0x36 returned 0 after 151 usecs
calling  comedi_init+0x0/0x23d @ 1
comedi: version 0.7.76 - http://www.comedi.org
initcall comedi_init+0x0/0x23d returned 0 after 1577 usecs
calling  kcomedilib_module_init+0x0/0x10 @ 1
initcall kcomedilib_module_init+0x0/0x10 returned 0 after 1 usecs
calling  comedi_8254_module_init+0x0/0x10 @ 1
initcall comedi_8254_module_init+0x0/0x10 returned 0 after 1 usecs
calling  comedi_isadma_init+0x0/0x10 @ 1
initcall comedi_isadma_init+0x0/0x10 returned 0 after 1 usecs
calling  bonding_driver_init+0x0/0x15 @ 1
initcall bonding_driver_init+0x0/0x15 returned 0 after 102 usecs
calling  parport_driver_init+0x0/0x15 @ 1
initcall parport_driver_init+0x0/0x15 returned 0 after 6 usecs
calling  amplc_dio200_driver_init+0x0/0x15 @ 1
initcall amplc_dio200_driver_init+0x0/0x15 returned 0 after 5 usecs
calling  amplc_pc263_driver_init+0x0/0x15 @ 1
initcall amplc_pc263_driver_init+0x0/0x15 returned 0 after 5 usecs
calling  pcl730_driver_init+0x0/0x15 @ 1
initcall pcl730_driver_init+0x0/0x15 returned 0 after 5 usecs
calling  pcl812_driver_init+0x0/0x15 @ 1
initcall pcl812_driver_init+0x0/0x15 returned 0 after 5 usecs
calling  pcl816_driver_init+0x0/0x15 @ 1
initcall pcl816_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  pcl818_driver_init+0x0/0x15 @ 1
initcall pcl818_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  rti800_driver_init+0x0/0x15 @ 1
initcall rti800_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  das16m1_driver_init+0x0/0x15 @ 1
initcall das16m1_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  driver_das800_init+0x0/0x15 @ 1
initcall driver_das800_init+0x0/0x15 returned 0 after 4 usecs
calling  das1800_driver_init+0x0/0x15 @ 1
initcall das1800_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  dt2811_driver_init+0x0/0x15 @ 1
initcall dt2811_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  dt2814_driver_init+0x0/0x15 @ 1
initcall dt2814_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  dt282x_driver_init+0x0/0x15 @ 1
initcall dt282x_driver_init+0x0/0x15 returned 0 after 3 usecs
calling  dmm32at_driver_init+0x0/0x15 @ 1
initcall dmm32at_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  aio_iiro_16_driver_init+0x0/0x15 @ 1
initcall aio_iiro_16_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  ii20k_driver_init+0x0/0x15 @ 1
initcall ii20k_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  adq12b_driver_init+0x0/0x15 @ 1
initcall adq12b_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  ni_at_a2150_driver_init+0x0/0x15 @ 1
initcall ni_at_a2150_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  ni_at_ao_driver_init+0x0/0x15 @ 1
initcall ni_at_ao_driver_init+0x0/0x15 returned 0 after 3 usecs
calling  ni_atmio_driver_init+0x0/0x15 @ 1
initcall ni_atmio_driver_init+0x0/0x15 returned 0 after 3 usecs
calling  atmio16d_driver_init+0x0/0x15 @ 1
initcall atmio16d_driver_init+0x0/0x15 returned 0 after 2 usecs
calling  labpc_driver_init+0x0/0x15 @ 1
initcall labpc_driver_init+0x0/0x15 returned 0 after 3 usecs
calling  pcmad_driver_init+0x0/0x15 @ 1
initcall pcmad_driver_init+0x0/0x15 returned 0 after 3 usecs
calling  pcmmio_driver_init+0x0/0x15 @ 1
initcall pcmmio_driver_init+0x0/0x15 returned 0 after 3 usecs
calling  pcmuio_driver_init+0x0/0x15 @ 1
initcall pcmuio_driver_init+0x0/0x15 returned 0 after 4 usecs
calling  ni_tio_init_module+0x0/0x10 @ 1
initcall ni_tio_init_module+0x0/0x10 returned 0 after 1 usecs
calling  ni_routes_module_init+0x0/0x57 @ 1
initcall ni_routes_module_init+0x0/0x57 returned 0 after 2912 usecs
calling  labpc_common_init+0x0/0x10 @ 1
initcall labpc_common_init+0x0/0x10 returned 0 after 2 usecs
calling  ni_labpc_isadma_init_module+0x0/0x10 @ 1
initcall ni_labpc_isadma_init_module+0x0/0x10 returned 0 after 1 usecs
calling  comedi_8255_module_init+0x0/0x10 @ 1
initcall comedi_8255_module_init+0x0/0x10 returned 0 after 2 usecs
calling  dev_8255_driver_init+0x0/0x15 @ 1
initcall dev_8255_driver_init+0x0/0x15 returned 0 after 8 usecs
calling  amplc_dio200_common_init+0x0/0x10 @ 1
initcall amplc_dio200_common_init+0x0/0x10 returned 0 after 1 usecs
calling  comp_init+0x0/0x47 @ 1
initcall comp_init+0x0/0x47 returned 0 after 763 usecs
calling  i2c_driver_init+0x0/0x17 @ 1
initcall i2c_driver_init+0x0/0x17 returned 0 after 209 usecs
calling  pi433_init+0x0/0xd2 @ 1
initcall pi433_init+0x0/0xd2 returned 0 after 403 usecs
calling  goldfish_pipe_driver_init+0x0/0x17 @ 1
initcall goldfish_pipe_driver_init+0x0/0x17 returned 0 after 159 usecs
calling  rproc_virtio_driver_init+0x0/0x17 @ 1
initcall rproc_virtio_driver_init+0x0/0x17 returned 0 after 117 usecs
calling  extcon_class_init+0x0/0x1f @ 1
initcall extcon_class_init+0x0/0x1f returned 0 after 72 usecs
calling  max3355_driver_init+0x0/0x17 @ 1
initcall max3355_driver_init+0x0/0x17 returned 0 after 119 usecs
calling  max8997_muic_driver_init+0x0/0x17 @ 1
initcall max8997_muic_driver_init+0x0/0x17 returned 0 after 188 usecs
calling  palmas_usb_driver_init+0x0/0x17 @ 1
initcall palmas_usb_driver_init+0x0/0x17 returned 0 after 118 usecs
calling  ptn5150_i2c_driver_init+0x0/0x17 @ 1
initcall ptn5150_i2c_driver_init+0x0/0x17 returned 0 after 127 usecs
calling  usb_extcon_driver_init+0x0/0x17 @ 1
initcall usb_extcon_driver_init+0x0/0x17 returned 0 after 116 usecs
calling  ipack_init+0x0/0x49 @ 1
initcall ipack_init+0x0/0x49 returned 0 after 209 usecs
calling  mcb_lpc_init+0x0/0x31 @ 1
initcall mcb_lpc_init+0x0/0x31 returned -19 after 3 usecs
calling  stm_core_init+0x0/0xd3 @ 1
initcall stm_core_init+0x0/0xd3 returned 0 after 2739 usecs
calling  basic_stm_init+0x0/0x20 @ 1
initcall basic_stm_init+0x0/0x20 returned 0 after 117 usecs
calling  sys_t_stm_init+0x0/0x20 @ 1
initcall sys_t_stm_init+0x0/0x20 returned 0 after 123 usecs
calling  stm_console_init+0x0/0x20 @ 1
initcall stm_console_init+0x0/0x20 returned 0 after 435 usecs
calling  stm_heartbeat_init+0x0/0x410 @ 1
initcall stm_heartbeat_init+0x0/0x410 returned 0 after 1013 usecs
calling  stm_ftrace_init+0x0/0x73 @ 1
initcall stm_ftrace_init+0x0/0x73 returned 0 after 306 usecs
calling  binder_init+0x0/0x50d @ 1
initcall binder_init+0x0/0x50d returned 0 after 2037 usecs
calling  machxo2_spi_driver_init+0x0/0x17 @ 1
initcall machxo2_spi_driver_init+0x0/0x17 returned 0 after 148 usecs
calling  altera_freeze_br_driver_init+0x0/0x17 @ 1
initcall altera_freeze_br_driver_init+0x0/0x17 returned 0 after 184 usecs
calling  xlnx_pr_decoupler_driver_init+0x0/0x17 @ 1
initcall xlnx_pr_decoupler_driver_init+0x0/0x17 returned 0 after 122 usecs
calling  dfl_fpga_init+0x0/0x102 @ 1
initcall dfl_fpga_init+0x0/0x102 returned 0 after 167 usecs
calling  fme_driver_init+0x0/0x17 @ 1
initcall fme_driver_init+0x0/0x17 returned 0 after 165 usecs
calling  fme_mgr_driver_init+0x0/0x17 @ 1
initcall fme_mgr_driver_init+0x0/0x17 returned 0 after 149 usecs
calling  fme_region_driver_init+0x0/0x17 @ 1
initcall fme_region_driver_init+0x0/0x17 returned 0 after 145 usecs
calling  afu_init+0x0/0x42 @ 1
initcall afu_init+0x0/0x42 returned 0 after 185 usecs
calling  adg792a_driver_init+0x0/0x17 @ 1
initcall adg792a_driver_init+0x0/0x17 returned 0 after 163 usecs
calling  mux_gpio_driver_init+0x0/0x17 @ 1
initcall mux_gpio_driver_init+0x0/0x17 returned 0 after 153 usecs
calling  siox_gpio_driver_init+0x0/0x17 @ 1
initcall siox_gpio_driver_init+0x0/0x17 returned 0 after 113 usecs
calling  gnss_module_init+0x0/0x11f @ 1
gnss: GNSS driver registered with major 510
initcall gnss_module_init+0x0/0x11f returned 0 after 879 usecs
calling  mtk_driver_init+0x0/0x17 @ 1
initcall mtk_driver_init+0x0/0x17 returned 0 after 139 usecs
calling  ubx_driver_init+0x0/0x17 @ 1
initcall ubx_driver_init+0x0/0x17 returned 0 after 92 usecs
calling  icc_init+0x0/0x6d @ 1
initcall icc_init+0x0/0x6d returned 0 after 123 usecs
calling  most_cdev_init+0x0/0x106 @ 1
initcall most_cdev_init+0x0/0x106 returned 0 after 162 usecs
calling  sock_diag_init+0x0/0x51 @ 1
initcall sock_diag_init+0x0/0x51 returned 0 after 124 usecs
calling  gre_offload_init+0x0/0x56 @ 1
initcall gre_offload_init+0x0/0x56 returned 0 after 2 usecs
calling  sysctl_ipv4_init+0x0/0x54 @ 1
initcall sysctl_ipv4_init+0x0/0x54 returned 0 after 280 usecs
calling  tunnel4_init+0x0/0x61 @ 1
initcall tunnel4_init+0x0/0x61 returned 0 after 2 usecs
calling  inet_diag_init+0x0/0xcc @ 1
initcall inet_diag_init+0x0/0xcc returned 0 after 88 usecs
calling  tcp_diag_init+0x0/0x15 @ 1
initcall tcp_diag_init+0x0/0x15 returned 0 after 65 usecs
calling  cubictcp_register+0x0/0x5c @ 1
initcall cubictcp_register+0x0/0x5c returned 0 after 5 usecs
calling  inet6_init+0x0/0x46d @ 1
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
initcall inet6_init+0x0/0x46d returned 0 after 7015 usecs
calling  sit_init+0x0/0xd3 @ 1
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
initcall sit_init+0x0/0xd3 returned 0 after 3458 usecs
calling  packet_init+0x0/0x87 @ 1
NET: Registered PF_PACKET protocol family
initcall packet_init+0x0/0x87 returned 0 after 775 usecs
calling  init_p9+0x0/0x32 @ 1
9pnet: Installing 9P2000 support
initcall init_p9+0x0/0x32 returned 0 after 766 usecs
calling  p9_trans_fd_init+0x0/0x34 @ 1
initcall p9_trans_fd_init+0x0/0x34 returned 0 after 71 usecs
calling  p9_virtio_init+0x0/0x56 @ 1
initcall p9_virtio_init+0x0/0x56 returned 0 after 237 usecs
calling  mptcp_diag_init+0x0/0x15 @ 1
initcall mptcp_diag_init+0x0/0x15 returned 0 after 5 usecs
calling  mcheck_init_device+0x0/0x222 @ 1
initcall mcheck_init_device+0x0/0x222 returned 0 after 1947 usecs
calling  dev_mcelog_init_device+0x0/0x1eb @ 1
initcall dev_mcelog_init_device+0x0/0x1eb returned 0 after 752 usecs
calling  kernel_do_mounts_initrd_sysctls_init+0x0/0x2a @ 1
initcall kernel_do_mounts_initrd_sysctls_init+0x0/0x2a returned 0 after 30 usecs
calling  sld_mitigate_sysctl_init+0x0/0x2a @ 1
initcall sld_mitigate_sysctl_init+0x0/0x2a returned 0 after 23 usecs
calling  mcheck_late_init+0x0/0x45 @ 1
initcall mcheck_late_init+0x0/0x45 returned 0 after 195 usecs
calling  severities_debugfs_init+0x0/0x32 @ 1
initcall severities_debugfs_init+0x0/0x32 returned 0 after 56 usecs
calling  microcode_init+0x0/0x236 @ 1
initcall microcode_init+0x0/0x236 returned -22 after 2 usecs
calling  hpet_insert_resource+0x0/0x2b @ 1
initcall hpet_insert_resource+0x0/0x2b returned 0 after 6 usecs
calling  start_sync_check_timer+0x0/0xbb @ 1
initcall start_sync_check_timer+0x0/0xbb returned 0 after 1 usecs
calling  update_mp_table+0x0/0x5c8 @ 1
initcall update_mp_table+0x0/0x5c8 returned 0 after 2 usecs
calling  lapic_insert_resource+0x0/0x4b @ 1
initcall lapic_insert_resource+0x0/0x4b returned 0 after 6 usecs
calling  print_ipi_mode+0x0/0x35 @ 1
IPI shorthand broadcast: enabled
initcall print_ipi_mode+0x0/0x35 returned 0 after 654 usecs
calling  print_ICs+0x0/0x1db @ 1
... APIC ID:      00000000 (0)
... APIC VERSION: 00050014
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000001000

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
pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin01, enabled , edge , high, V(22), IRR(0), S(0), logical , D(0001), M(0)
pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(0001), M(0)
pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin07, enabled , edge , high, V(21), IRR(0), S(0), logical , D(0001), M(0)
pin08, enabled , edge , high, V(23), IRR(0), S(0), logical , D(0002), M(0)
pin09, enabled , level, high, V(21), IRR(0), S(0), logical , D(0002), M(0)
pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0c, enabled , edge , high, V(22), IRR(0), S(0), logical , D(0002), M(0)
pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
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
initcall print_ICs+0x0/0x1db returned 0 after 49135 usecs
calling  setup_efi_kvm_sev_migration+0x0/0x10 @ 1
initcall setup_efi_kvm_sev_migration+0x0/0x10 returned 0 after 2 usecs
calling  create_tlb_single_page_flush_ceiling+0x0/0x57 @ 1
initcall create_tlb_single_page_flush_ceiling+0x0/0x57 returned 0 after 76 usecs
calling  cpa_stats_init+0x0/0x57 @ 1
initcall cpa_stats_init+0x0/0x57 returned 0 after 124 usecs
calling  aesni_init+0x0/0x227 @ 1
AVX version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
initcall aesni_init+0x0/0x227 returned 0 after 2139 usecs
calling  kernel_panic_sysctls_init+0x0/0x2a @ 1
initcall kernel_panic_sysctls_init+0x0/0x2a returned 0 after 109 usecs
calling  kernel_panic_sysfs_init+0x0/0x4b @ 1
initcall kernel_panic_sysfs_init+0x0/0x4b returned 0 after 37 usecs
calling  kernel_exit_sysctls_init+0x0/0x2a @ 1
initcall kernel_exit_sysctls_init+0x0/0x2a returned 0 after 51 usecs
calling  kernel_exit_sysfs_init+0x0/0x4b @ 1
initcall kernel_exit_sysfs_init+0x0/0x4b returned 0 after 38 usecs
calling  param_sysfs_builtin_init+0x0/0xe4 @ 1
initcall param_sysfs_builtin_init+0x0/0xe4 returned 0 after 74059 usecs
calling  reboot_ksysfs_init+0x0/0x98 @ 1
initcall reboot_ksysfs_init+0x0/0x98 returned 0 after 199 usecs
calling  sched_core_sysctl_init+0x0/0x2f @ 1
initcall sched_core_sysctl_init+0x0/0x2f returned 0 after 28 usecs
calling  sched_fair_sysctl_init+0x0/0x2a @ 1
initcall sched_fair_sysctl_init+0x0/0x2a returned 0 after 105 usecs
calling  sched_rt_sysctl_init+0x0/0x2a @ 1
initcall sched_rt_sysctl_init+0x0/0x2a returned 0 after 26 usecs
calling  sched_dl_sysctl_init+0x0/0x2a @ 1
initcall sched_dl_sysctl_init+0x0/0x2a returned 0 after 83 usecs
calling  sched_clock_init_late+0x0/0x129 @ 1
sched_clock: Marking stable (18865691433, 52133794)->(19289760611, -371935384)
initcall sched_clock_init_late+0x0/0x129 returned 0 after 1429 usecs
calling  sched_init_debug+0x0/0x1ba @ 1
initcall sched_init_debug+0x0/0x1ba returned 0 after 1650 usecs
calling  kernel_lockdep_sysctls_init+0x0/0x25 @ 1
initcall kernel_lockdep_sysctls_init+0x0/0x25 returned 0 after 68 usecs
calling  cpu_latency_qos_init+0x0/0x42 @ 1
initcall cpu_latency_qos_init+0x0/0x42 returned 0 after 1473 usecs
calling  printk_late_init+0x0/0x290 @ 1
initcall printk_late_init+0x0/0x290 returned 0 after 52 usecs
calling  rcu_verify_early_boot_tests+0x0/0xd0 @ 1
initcall rcu_verify_early_boot_tests+0x0/0xd0 returned 0 after 2 usecs
calling  rcu_tasks_verify_schedule_work+0x0/0xa0 @ 1
initcall rcu_tasks_verify_schedule_work+0x0/0xa0 returned 0 after 8 usecs
calling  init_srcu_module_notifier+0x0/0x34 @ 1
initcall init_srcu_module_notifier+0x0/0x34 returned 0 after 8 usecs
calling  swiotlb_create_default_debugfs+0x0/0x70 @ 1
initcall swiotlb_create_default_debugfs+0x0/0x70 returned 0 after 243 usecs
calling  tk_debug_sleep_time_init+0x0/0x2c @ 1
initcall tk_debug_sleep_time_init+0x0/0x2c returned 0 after 98 usecs
calling  kexec_core_sysctl_init+0x0/0x2a @ 1
initcall kexec_core_sysctl_init+0x0/0x2a returned 0 after 36 usecs
calling  bpf_rstat_kfunc_init+0x0/0x10 @ 1
initcall bpf_rstat_kfunc_init+0x0/0x10 returned 0 after 1 usecs
calling  debugfs_kprobe_init+0x0/0x7c @ 1
initcall debugfs_kprobe_init+0x0/0x7c returned 0 after 156 usecs
calling  ftrace_sysctl_init+0x0/0x25 @ 1
initcall ftrace_sysctl_init+0x0/0x25 returned 0 after 35 usecs
calling  fault_around_debugfs+0x0/0x2c @ 1
initcall fault_around_debugfs+0x0/0x2c returned 0 after 74 usecs
calling  hugetlb_vmemmap_init+0x0/0x134 @ 1
initcall hugetlb_vmemmap_init+0x0/0x134 returned 0 after 30 usecs
calling  slab_sysfs_init+0x0/0xf8 @ 1
initcall slab_sysfs_init+0x0/0xf8 returned 0 after 139364 usecs
calling  kasan_cpu_quarantine_init+0x0/0x4c @ 1
initcall kasan_cpu_quarantine_init+0x0/0x4c returned 214 after 226 usecs
calling  kfence_debugfs_init+0x0/0x5f @ 1
initcall kfence_debugfs_init+0x0/0x5f returned 0 after 136 usecs
calling  split_huge_pages_debugfs+0x0/0x2c @ 1
initcall split_huge_pages_debugfs+0x0/0x2c returned 0 after 64 usecs
calling  debug_vm_pgtable+0x0/0x100e @ 1
debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
initcall debug_vm_pgtable+0x0/0x100e returned 0 after 1409722 usecs
calling  pageowner_init+0x0/0x3c @ 1
initcall pageowner_init+0x0/0x3c returned 0 after 318 usecs
calling  check_early_ioremap_leak+0x0/0xb5 @ 1
initcall check_early_ioremap_leak+0x0/0xb5 returned 0 after 2 usecs
calling  set_hardened_usercopy+0x0/0x28 @ 1
initcall set_hardened_usercopy+0x0/0x28 returned 1 after 2 usecs
calling  init_percpu_stats_debugfs+0x0/0x2c @ 1
initcall init_percpu_stats_debugfs+0x0/0x2c returned 0 after 110 usecs
calling  fsverity_init+0x0/0x4e @ 1
fs-verity: Initialized fs-verity
initcall fsverity_init+0x0/0x4e returned 0 after 3187 usecs
calling  init_btrfs_fs+0x0/0x25f @ 1
Btrfs loaded, crc32c=crc32c-intel, assert=on, ref-verify=on, zoned=no, fsverity=yes
initcall init_btrfs_fs+0x0/0x25f returned 0 after 19555 usecs
calling  init_root_keyring+0x0/0x12 @ 1
initcall init_root_keyring+0x0/0x12 returned 0 after 555 usecs
calling  init_profile_hash+0x0/0x123 @ 1
initcall init_profile_hash+0x0/0x123 returned 0 after 2 usecs
calling  crypto_algapi_init+0x0/0x15 @ 1
initcall crypto_algapi_init+0x0/0x15 returned 0 after 21 usecs
calling  fail_make_request_debugfs+0x0/0x2b @ 1
initcall fail_make_request_debugfs+0x0/0x2b returned -19 after 1 usecs
calling  blk_timeout_init+0x0/0x1b @ 1
initcall blk_timeout_init+0x0/0x1b returned 0 after 1 usecs
calling  kunit_init+0x0/0x1a @ 1
initcall kunit_init+0x0/0x1a returned 0 after 93 usecs
calling  init_error_injection+0x0/0x72 @ 1
initcall init_error_injection+0x0/0x72 returned 0 after 4237 usecs
calling  pci_resource_alignment_sysfs_init+0x0/0x1c @ 1
initcall pci_resource_alignment_sysfs_init+0x0/0x1c returned 0 after 32 usecs
calling  pci_sysfs_init+0x0/0x76 @ 1
initcall pci_sysfs_init+0x0/0x76 returned 0 after 300 usecs
calling  clk_debug_init+0x0/0x13f @ 1
initcall clk_debug_init+0x0/0x13f returned 0 after 318 usecs
calling  sync_state_resume_initcall+0x0/0x20 @ 1
initcall sync_state_resume_initcall+0x0/0x20 returned 0 after 7 usecs
calling  deferred_probe_initcall+0x0/0xe0 @ 1
initcall deferred_probe_initcall+0x0/0xe0 returned 0 after 356 usecs
calling  wl1273_core_init+0x0/0x36 @ 1
initcall wl1273_core_init+0x0/0x36 returned 0 after 223 usecs
calling  block2mtd_init+0x0/0x69 @ 1
initcall block2mtd_init+0x0/0x69 returned 0 after 2 usecs
calling  ubi_init+0x0/0x381 @ 1
initcall ubi_init+0x0/0x381 returned 0 after 1630 usecs
calling  gpio_keys_init+0x0/0x17 @ 1
initcall gpio_keys_init+0x0/0x17 returned 0 after 186 usecs
calling  firmware_memmap_init+0x0/0x62 @ 1
initcall firmware_memmap_init+0x0/0x62 returned 0 after 504 usecs
calling  tcp_congestion_default+0x0/0x1c @ 1
initcall tcp_congestion_default+0x0/0x1c returned 0 after 15 usecs
calling  ip_auto_config+0x0/0x77b @ 1
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
IP-Config: Complete:
device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
host=vm-meta-125, domain=, nis-domain=(none)
bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
nameserver0=10.0.2.3
initcall ip_auto_config+0x0/0x77b returned 0 after 1038873 usecs
calling  pci_mmcfg_late_insert_resources+0x0/0xbd @ 1
initcall pci_mmcfg_late_insert_resources+0x0/0xbd returned 0 after 2 usecs
calling  debug_hotplug_cpu+0x0/0x19 @ 1
initcall debug_hotplug_cpu+0x0/0x19 returned 0 after 3 usecs
calling  ftrace_check_sync+0x0/0x1c @ 1
initcall ftrace_check_sync+0x0/0x1c returned 0 after 197 usecs
calling  latency_fsnotify_init+0x0/0x40 @ 1
initcall latency_fsnotify_init+0x0/0x40 returned 0 after 692 usecs
calling  trace_eval_sync+0x0/0x1c @ 1
initcall trace_eval_sync+0x0/0x1c returned 0 after 72 usecs
calling  late_trace_init+0x0/0xa4 @ 1
initcall late_trace_init+0x0/0xa4 returned 0 after 2 usecs
calling  acpi_gpio_handle_deferred_request_irqs+0x0/0xbd @ 1
initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xbd returned 0 after 728 usecs
calling  clk_disable_unused+0x0/0x194 @ 1
initcall clk_disable_unused+0x0/0x194 returned 0 after 54 usecs
KTAP version 1
1..7
KTAP version 1
# Subtest: hw_breakpoint
1..9
ok 1 test_one_cpu
ok 2 test_many_cpus
ok 3 test_one_task_on_all_cpus
ok 4 test_two_tasks_on_all_cpus
ok 5 test_one_task_on_one_cpu
ok 6 test_one_task_mixed
ok 7 test_two_tasks_on_one_cpu
ok 8 test_two_tasks_on_one_all_cpus
ok 9 test_task_on_all_and_one_cpu
# hw_breakpoint: pass:9 fail:0 skip:0 total:9
# Totals: pass:9 fail:0 skip:0 total:9
ok 1 hw_breakpoint
KTAP version 1
# Subtest: binfmt_elf
1..1
ok 1 total_mapping_size_test
ok 2 binfmt_elf
KTAP version 1
# Subtest: compat_binfmt_elf
1..1
ok 1 total_mapping_size_test
ok 3 compat_binfmt_elf
KTAP version 1
# Subtest: fprobe_test
1..3
ok 1 test_fprobe_entry
kunit_try_catch (82) used greatest stack depth: 27736 bytes left
ok 2 test_fprobe
ok 3 test_fprobe_syms
# fprobe_test: pass:3 fail:0 skip:0 total:3
# Totals: pass:3 fail:0 skip:0 total:3
ok 4 fprobe_test
KTAP version 1
# Subtest: qos-kunit-test
1..3
ok 1 freq_qos_test_min
ok 2 freq_qos_test_maxdef
ok 3 freq_qos_test_readd
# qos-kunit-test: pass:3 fail:0 skip:0 total:3
# Totals: pass:3 fail:0 skip:0 total:3
ok 5 qos-kunit-test
KTAP version 1
# Subtest: property-entry
1..7
ok 1 pe_test_uints
ok 2 pe_test_uint_arrays
ok 3 pe_test_strings
ok 4 pe_test_bool
ok 5 pe_test_move_inline_u8
ok 6 pe_test_move_inline_str
ok 7 pe_test_reference
# property-entry: pass:7 fail:0 skip:0 total:7
# Totals: pass:7 fail:0 skip:0 total:7
ok 6 property-entry
KTAP version 1
# Subtest: thunderbolt
1..38
ok 1 tb_test_path_basic
ok 2 tb_test_path_not_connected_walk
ok 3 tb_test_path_single_hop_walk
ok 4 tb_test_path_daisy_chain_walk
ok 5 tb_test_path_simple_tree_walk
ok 6 tb_test_path_complex_tree_walk
ok 7 tb_test_path_max_length_walk
ok 8 tb_test_path_not_connected
ok 9 tb_test_path_not_bonded_lane0
ok 10 tb_test_path_not_bonded_lane1
ok 11 tb_test_path_not_bonded_lane1_chain
ok 12 tb_test_path_not_bonded_lane1_chain_reverse
ok 13 tb_test_path_mixed_chain
ok 14 tb_test_path_mixed_chain_reverse
ok 15 tb_test_tunnel_pcie
ok 16 tb_test_tunnel_dp
ok 17 tb_test_tunnel_dp_chain
ok 18 tb_test_tunnel_dp_tree
ok 19 tb_test_tunnel_dp_max_length
ok 20 tb_test_tunnel_port_on_path
ok 21 tb_test_tunnel_usb3
ok 22 tb_test_tunnel_dma
ok 23 tb_test_tunnel_dma_rx
ok 24 tb_test_tunnel_dma_tx
ok 25 tb_test_tunnel_dma_chain
ok 26 tb_test_tunnel_dma_match
ok 27 tb_test_credit_alloc_legacy_not_bonded
ok 28 tb_test_credit_alloc_legacy_bonded
ok 29 tb_test_credit_alloc_pcie
ok 30 tb_test_credit_alloc_without_dp
ok 31 tb_test_credit_alloc_dp
ok 32 tb_test_credit_alloc_usb3
ok 33 tb_test_credit_alloc_dma
ok 34 tb_test_credit_alloc_dma_multiple
ok 35 tb_test_credit_alloc_all
ok 36 tb_test_property_parse
ok 37 tb_test_property_format
ok 38 tb_test_property_copy
# thunderbolt: pass:38 fail:0 skip:0 total:38
# Totals: pass:38 fail:0 skip:0 total:38
ok 7 thunderbolt
Freeing unused kernel image (initmem) memory: 8444K
Write protecting the kernel read-only data: 73728k
Freeing unused kernel image (rodata/data gap) memory: 1244K
x86/mm: Checked W+X mappings: passed, no W+X pages found.
x86/mm: Checking user space page tables
x86/mm: Checked W+X mappings: passed, no W+X pages found.
Run /init as init process
with arguments:
/init
with environment:
HOME=/
TERM=linux
RESULT_ROOT=/result/kunit/group-00/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/21
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/vmlinuz-6.2.0-rc1-00083-g69d4c0d32186
branch=linus/master
job=/lkp/jobs/scheduled/vm-meta-125/kunit-group-00-debian-11.1-i386-20220923.cgz-69d4c0d3218692ffa56b0e1b9c76c50c699d7044-20230227-50968-7mqj6b-39.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a012-20211016
commit=69d4c0d3218692ffa56b0e1b9c76c50c699d7044
vmalloc=256M
max_uptime=1200
LKP_SERVER=internal-lkp-server
selinux=0
softlockup_panic=1
prompt_ramdisk=0
vga=normal
systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.

Welcome to Debian GNU/Linux 11 (bullseye)!

systemd-bless-b (134) used greatest stack depth: 27472 bytes left
random: crng init done
Created slice system-getty.slice.
Created slice system-modprobe.slice.
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
Mounting RPC Pipe File System...
Mounting Kernel Debug File System...
Mounting Kernel Trace File System...
mount (146) used greatest stack depth: 26984 bytes left
Starting Load Kernel Module configfs...
Starting Load Kernel Module drm...
Starting Load Kernel Module fuse...
Starting Journal Service...
Starting Load Kernel Modules...
Starting Remount Root and Kernel File Systems...
Starting Coldplug All udev Devices...
Mounted Huge Pages File System.
Mounted RPC Pipe File System.
Mounted Kernel Debug File System.
Mounted Kernel Trace File System.
Finished Load Kernel Module configfs.
Finished Load Kernel Module fuse.
Finished Load Kernel Modules.
calling  drm_core_init+0x0/0xff0 [drm] @ 153
ACPI: bus type drm_connector registered
initcall drm_core_init+0x0/0xff0 [drm] returned 0 after 1024 usecs
Mounting Kernel Configuration File System...
Starting Apply Kernel Variables...
Finished Load Kernel Module drm.
Finished Remount Root and Kernel File Systems.
Starting Load/Save Random Seed...
Starting Create System Users...
Mounted Kernel Configuration File System.
Finished Apply Kernel Variables.
Finished Load/Save Random Seed.
Finished Create System Users.
Starting Create Static Device Nodes in /dev...
Finished Create Static Device Nodes in /dev.
Reached target Local File Systems (Pre).
Reached target Local File Systems.
Starting Preprocess NFS configuration...
Finished Preprocess NFS configuration.
Reached target NFS client services.
Started Rule-based Manager for Device Events and Files.
Started Journal Service.
Starting Flush Journal to Persistent Storage...
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
Reached target Printer.
mtdblock: MTD device 'NAND simulator partition 0' is NAND, please consider using UBI block devices instead.
Finished Coldplug All udev Devices.
Reached target System Initialization.
Started Daily apt download activities.
Started Daily apt upgrade and clean activities.
Started Discard unused blocks once a week.
Started Daily rotation of log files.
Started Daily Cleanup of Temporary Directories.
Reached target Timers.
Listening on D-Bus System Message Bus Socket.
Reached target Sockets.
Reached target Basic System.
Started Regular background program processing daemon.
Started D-Bus System Message Bus.
Starting Helper to synchronize boot up for ifupdown...
Starting LSB: OpenIPMI Driver init script...
Starting System Logging Service...
Starting User Login Management...
Finished Helper to synchronize boot up for ifupdown.
Starting Raise network interfaces...
Starting LSB: Load kernel image with kexec...
Started User Login Management.
Started LSB: Load kernel image with kexec.
Finished Raise network interfaces.
Reached target Network.
Starting LKP bootstrap...
Starting /etc/rc.local Compatibility...
Starting OpenBSD Secure Shell server...
Starting Permit User Sessions...
Failed to start LSB: OpenIPMI Driver init script.
See 'systemctl status openipmi.service' for details.
Started LKP bootstrap.
Finished Permit User Sessions.
LKP: ttyS0: 265: skip deploy intel ucode as no ucode is specified
Started OpenBSD Secure Shell server.
LKP: ttyS0: 265: Kernel tests: Boot OK!
LKP: ttyS0: 265: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 6.2.0-rc1-00083-g69d4c0d32186 1
LKP: ttyS0: 265:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-125/kunit-group-00-debian-11.1-i386-20220923.cgz-69d4c0d3218692ffa56b0e1b9c76c50c699d7044-20230227-50968-7mqj6b-39.yaml
e2scrub_all (212) used greatest stack depth: 25584 bytes left
KTAP version 1
# Subtest: bitfields
1..2
ok 1 test_bitfields_constants
ok 2 test_bitfields_variables
# bitfields: pass:2 fail:0 skip:0 total:2
# Totals: pass:2 fail:0 skip:0 total:2
ok 8 bitfields
KTAP version 1
# Subtest: bits-test
1..3
ok 1 genmask_test
ok 2 genmask_ull_test
ok 3 genmask_input_check_test
# bits-test: pass:3 fail:0 skip:0 total:3
# Totals: pass:3 fail:0 skip:0 total:3
ok 9 bits-test
KTAP version 1
# Subtest: cmdline
1..4
ok 1 cmdline_test_noint
Started System Logg[   40.438055][  T461]     ok 2 cmdline_test_lead_int
ing Service.
ok 3 cmdline_test_tail_int
ok 4 cmdline_test_range
# cmdline: pass:4 fail:0 skip:0 total:4
# Totals: pass:4 fail:0 skip:0 total:4
ok 10 cmdline
KTAP version 1
# Subtest: ext4_inode_test
1..1
KTAP version 1
# Subtest: inode_test_xtimestamp_decoding
ok 1 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
ok 2 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits
ok 3 1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits
ok 4 2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits
ok 5 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on
ok 6 2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on
ok 7 2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on
ok 8 2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on
ok 9 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on
ok 10 2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on
ok 11 2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on
ok 12 2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on
ok 13 2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns
ok 14 2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns
ok 15 2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on
ok 16 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on
# inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
ok 1 inode_test_xtimestamp_decoding
# Totals: pass:16 fail:0 skip:0 total:16
ok 11 ext4_inode_test
KTAP version 1
# Subtest: hash
1..2
ok 1 test_string_or
ok 2 test_hash_or
# hash: pass:2 fail:0 skip:0 total:2
# Totals: pass:2 fail:0 skip:0 total:2
ok 12 hash
KTAP version 1
# Subtest: linear-ranges-test
1..4
ok 1 range_test_get_value_amount
ok 2 range_test_get_selector_high
ok 3 range_test_get_selector_low
ok 4 range_test_get_value
# linear-ranges-test: pass:4 fail:0 skip:0 total:4
# Totals: pass:4 fail:0 skip:0 total:4
ok 13 linear-ranges-test
KTAP version 1
# Subtest: list-kunit-test
1..39
ok 1 list_test_list_init
ok 2 list_test_list_add
ok 3 list_test_list_add_tail
ok 4 list_test_list_del
ok 5 list_test_list_replace
ok 6 list_test_list_replace_init
ok 7 list_test_list_swap
ok 8 list_test_list_del_init
ok 9 list_test_list_del_init_careful
ok 10 list_test_list_move
ok 11 list_test_list_move_tail
ok 12 list_test_list_bulk_move_tail
ok 13 list_test_list_is_head
ok 14 list_test_list_is_first
ok 15 list_test_list_is_last
ok 16 list_test_list_empty
ok 17 list_test_list_empty_careful
ok 18 list_test_list_rotate_left
ok 19 list_test_list_rotate_to_front
ok 20 list_test_list_is_singular
ok 21 list_test_list_cut_position
ok 22 list_test_list_cut_before
ok 23 list_test_list_splice
ok 24 list_test_list_splice_tail
ok 25 list_test_list_splice_init
ok 26 list_test_list_splice_tail_init
ok 27 list_test_list_entry
ok 28 list_test_list_entry_is_head
ok 29 list_test_list_first_entry
ok 30 list_test_list_last_entry
ok 31 list_test_list_first_entry_or_null
ok 32 list_test_list_next_entry
ok 33 list_test_list_prev_entry
ok 34 list_test_list_for_each
ok 35 list_test_list_for_each_prev
ok 36 list_test_list_for_each_safe
ok 37 list_test_list_for_each_prev_safe
ok 38 list_test_list_for_each_entry
ok 39 list_test_list_for_each_entry_reverse
# list-kunit-test: pass:39 fail:0 skip:0 total:39
# Totals: pass:39 fail:0 skip:0 total:39
ok 14 list-kunit-test
KTAP version 1
# Subtest: hlist
1..18
ok 1 hlist_test_init
ok 2 hlist_test_unhashed
ok 3 hlist_test_unhashed_lockless
ok 4 hlist_test_del
ok 5 hlist_test_del_init
ok 6 hlist_test_add
ok 7 hlist_test_fake
ok 8 hlist_test_is_singular_node
ok 9 hlist_test_empty
ok 10 hlist_test_move_list
ok 11 hlist_test_entry
ok 12 hlist_test_entry_safe
ok 13 hlist_test_for_each
ok 14 hlist_test_for_each_safe
ok 15 hlist_test_for_each_entry
ok 16 hlist_test_for_each_entry_continue
ok 17 hlist_test_for_each_entry_from
ok 18 hlist_test_for_each_entry_safe
# hlist: pass:18 fail:0 skip:0 total:18
# Totals: pass:18 fail:0 skip:0 total:18
ok 15 hlist
KTAP version 1
# Subtest: memcpy
1..7
# memset_test: ok: memset() direct assignment
# memset_test: ok: memset() complete overwrite
# memset_test: ok: memset() middle overwrite
# memset_test: ok: memset() argument side-effects
# memset_test: ok: memset() memset_after()
# memset_test: ok: memset() memset_startat()
ok 1 memset_test
# memcpy_test: ok: memcpy() static initializers
# memcpy_test: ok: memcpy() direct assignment
# memcpy_test: ok: memcpy() complete overwrite
# memcpy_test: ok: memcpy() middle overwrite
# memcpy_test: ok: memcpy() argument side-effects
ok 2 memcpy_test
ok 3 memcpy_large_test
# memmove_test: ok: memmove() static initializers
# memmove_test: ok: memmove() direct assignment
# memmove_test: ok: memmove() complete overwrite
# memmove_test: ok: memmove() middle overwrite
# memmove_test: ok: memmove() argument side-effects
# memmove_test: ok: memmove() overlapping write
ok 4 memmove_test
is_virt=true

rmmod: ERROR: Module unloading is not supported

rmmod: ERROR: Module unloading is not supported

rmmod: ERROR: Module unloading is not supported

rmmod: ERROR: Module unloading is not supported

rmmod: ERROR: Module unloading is not supported

rmmod: ERROR: Module unloading is not supported

rmmod: ERROR: Module unloading is not supported

lkp: kernel tainted state: 262144

ok 5 memmove_large_test
LKP: stdout: 265: Kernel tests: Boot OK!

ok 6 memmove_overlap_test
ok 7 strtomem_test
# memcpy: pass:7 fail:0 skip:0 total:7
# Totals: pass:7 fail:0 skip:0 total:7
ok 16 memcpy
rmmod: ERROR: Module unloading is not supported

KTAP version 1
# Subtest: dev-addr-list-test
1..6
ok 1 dev_addr_test_basic
ok 2 dev_addr_test_sync_one
ok 3 dev_addr_test_add_del
LKP: stdout: 265: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 6.2.0-rc1-00083-g69d4c0d32186 1

ok 4 dev_addr_test_del_main
ok 5 dev_addr_test_add_set
ok 6 dev_addr_test_add_excl
# dev-addr-list-test: pass:6 fail:0 skip:0 total:6
# Totals: pass:6 fail:0 skip:0 total:6
ok 17 dev-addr-list-test
install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/gawk_1%3a5.1.0-1_i386.deb

Selecting previously unselected package gawk.

(Reading database ... 16439 files and directories currently installed.)

Preparing to unpack .../deb/gawk_1%3a5.1.0-1_i386.deb ...

Unpacking gawk (1:5.1.0-1) ...

rmmod: ERROR: Module unloading is not supported

Setting up gawk (1:5.1.0-1) ...

NO_NETWORK=

KTAP version 1
# Subtest: resource
1..2
ok 1 resource_test_union
ok 2 resource_test_intersection
# resource: pass:2 fail:0 skip:0 total:2
# Totals: pass:2 fail:0 skip:0 total:2
ok 18 resource
rmmod: ERROR: Module unloading is not supported

KTAP version 1
# Subtest: rtc_lib_test_cases
1..1
ok 1 rtc_time64_to_tm_test_date_range
ok 19 rtc_lib_test_cases
rmmod: ERROR: Module unloading is not supported

KTAP version 1
# Subtest: sysctl_test
1..10
ok 1 sysctl_test_api_dointvec_null_tbl_data
ok 2 sysctl_test_api_dointvec_table_maxlen_unset
ok 3 sysctl_test_api_dointvec_table_len_is_zero
ok 4 sysctl_test_api_dointvec_table_read_but_position_set
ok 5 sysctl_test_dointvec_read_happy_single_positive
ok 6 sysctl_test_dointvec_read_happy_single_negative
ok 7 sysctl_test_dointvec_write_happy_single_positive
ok 8 sysctl_test_dointvec_write_happy_single_negative
ok 9 sysctl_test_api_dointvec_write_single_less_int_min
ok 10 sysctl_test_api_dointvec_write_single_greater_int_max
# sysctl_test: pass:10 fail:0 skip:0 total:10
# Totals: pass:10 fail:0 skip:0 total:10
ok 20 sysctl_test
rmmod: ERROR: Module unloading is not supported

KTAP version 1
# Subtest: time_test_cases
1..1
LKP: stdout: 265:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-125/kunit-group-00-debian-11.1-i386-20220923.cgz-69d4c0d3218692ffa56b0e1b9c76c50c699d7044-20230227-50968-7mqj6b-39.yaml

RESULT_ROOT=/result/kunit/group-00/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/21

job=/lkp/jobs/scheduled/vm-meta-125/kunit-group-00-debian-11.1-i386-20220923.cgz-69d4c0d3218692ffa56b0e1b9c76c50c699d7044-20230227-50968-7mqj6b-39.yaml

ok 1 time64_to_tm_test_date_range
ok 21 time_test_cases
rmmod: ERROR: Module unloading is not supported

KTAP version 1
# Subtest: list_sort
1..1
ok 1 list_sort_test
ok 22 list_sort
rmmod: ERROR: Module unloading is not supported

KTAP version 1
# Subtest: lib_sort
1..1
ok 1 test_sort
ok 23 lib_sort
rmmod: ERROR: Module unloading is not supported

KTAP version 1
# Subtest: fat_test
1..3
ok 1 fat_checksum_test
KTAP version 1
# Subtest: fat_time_fat2unix_test
ok 1 Earliest possible UTC (1980-01-01 00:00:00)
ok 2 Latest possible UTC (2107-12-31 23:59:58)
ok 3 Earliest possible (UTC-11) (== 1979-12-31 13:00:00 UTC)
ok 4 Latest possible (UTC+11) (== 2108-01-01 10:59:58 UTC)
ok 5 Leap Day / Year (1996-02-29 00:00:00)
ok 6 Year 2000 is leap year (2000-02-29 00:00:00)
ok 7 Year 2100 not leap year (2100-03-01 00:00:00)
ok 8 Leap year + timezone UTC+1 (== 2004-02-29 00:30:00 UTC)
ok 9 Leap year + timezone UTC-1 (== 2004-02-29 23:30:00 UTC)
ok 10 VFAT odd-second resolution (1999-12-31 23:59:59)
ok 11 VFAT 10ms resolution (1980-01-01 00:00:00:0010)
# fat_time_fat2unix_test: pass:11 fail:0 skip:0 total:11
ok 2 fat_time_fat2unix_test
KTAP version 1
# Subtest: fat_time_unix2fat_test
ok 1 Earliest possible UTC (1980-01-01 00:00:00)
ok 2 Latest possible UTC (2107-12-31 23:59:58)
ok 3 Earliest possible (UTC-11) (== 1979-12-31 13:00:00 UTC)
ok 4 Latest possible (UTC+11) (== 2108-01-01 10:59:58 UTC)
ok 5 Leap Day / Year (1996-02-29 00:00:00)
ok 6 Year 2000 is leap year (2000-02-29 00:00:00)
ok 7 Year 2100 not leap year (2100-03-01 00:00:00)
ok 8 Leap year + timezone UTC+1 (== 2004-02-29 00:30:00 UTC)
ok 9 Leap year + timezone UTC-1 (== 2004-02-29 23:30:00 UTC)
ok 10 VFAT odd-second resolution (1999-12-31 23:59:59)
ok 11 VFAT 10ms resolution (1980-01-01 00:00:00:0010)
# fat_time_unix2fat_test: pass:11 fail:0 skip:0 total:11
ok 3 fat_time_unix2fat_test
# fat_test: pass:3 fail:0 skip:0 total:3
# Totals: pass:23 fail:0 skip:0 total:23
ok 24 fat_test
rmmod: ERROR: Module unloading is not supported

KTAP version 1
# Subtest: kasan
1..58
==================================================================
BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0x445/0x460 [kasan_test]
Write of size 1 at addr ffff88811cedc673 by task kunit_try_catch/752

CPU: 0 PID: 752 Comm: kunit_try_catch Tainted: G                 N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? kmalloc_oob_right+0x445/0x460 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? kmalloc_oob_right+0x445/0x460 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kmalloc_oob_right+0x445/0x460 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kmalloc_oob_right+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __kthread_parkme+0x64/0x220
? lockdep_hardirqs_on_prepare+0x19e/0x350
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 752:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_kmalloc+0xad/0xb0
kmalloc_oob_right+0x9f/0x460 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88811cedc600
which belongs to the cache kmalloc-128 of size 128
The buggy address is located 115 bytes inside of
128-byte region [ffff88811cedc600, ffff88811cedc680)

The buggy address belongs to the physical page:
page:00000000721e9585 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11cedc
flags: 0x100000000000200(slab|node=0|zone=2)
raw: 0100000000000200 ffff8881000418c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 439, tgid 439 (kunit), ts 57706426435, free_ts 57704326321
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0xb6/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
__kmalloc_node+0x92/0x120
memcg_alloc_slab_cgroups+0xb3/0x150
allocate_slab+0x341/0x470
___slab_alloc+0xbf8/0x1380
kmem_cache_alloc+0x3fc/0x440
copy_fs_struct+0x49/0x340
copy_process+0x1cd8/0x4970
kernel_clone+0xa6/0x870
__do_compat_sys_ia32_clone+0x8d/0xb0
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page_list+0x1a7/0xdc0
release_pages+0x37b/0xf20
tlb_batch_pages_flush+0x82/0x160
tlb_finish_mmu+0x119/0x6f0
exit_mmap+0x1b0/0x680
__mmput+0xc4/0x3a0
exit_mm+0x177/0x200
do_exit+0x299/0xa90
do_group_exit+0xb9/0x260
__ia32_sys_exit_group+0x3e/0x50
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
entry_SYSENTER_compat_after_hwframe+0x7f/0x91

Memory state around the buggy address:
ffff88811cedc500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff88811cedc580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88811cedc600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 fc
^
ffff88811cedc680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811cedc700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
Disabling lock debugging due to kernel taint
==================================================================
BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0x43b/0x460 [kasan_test]
Write of size 1 at addr ffff88811cedc678 by task kunit_try_catch/752

CPU: 0 PID: 752 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? kmalloc_oob_right+0x43b/0x460 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? kmalloc_oob_right+0x43b/0x460 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kmalloc_oob_right+0x43b/0x460 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kmalloc_oob_right+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __kthread_parkme+0x64/0x220
? lockdep_hardirqs_on_prepare+0x19e/0x350
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 752:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_kmalloc+0xad/0xb0
kmalloc_oob_right+0x9f/0x460 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88811cedc600
which belongs to the cache kmalloc-128 of size 128
The buggy address is located 120 bytes inside of
128-byte region [ffff88811cedc600, ffff88811cedc680)

The buggy address belongs to the physical page:
page:00000000721e9585 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11cedc
flags: 0x100000000000200(slab|node=0|zone=2)
raw: 0100000000000200 ffff8881000418c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 439, tgid 439 (kunit), ts 57706426435, free_ts 57704326321
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0xb6/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
__kmalloc_node+0x92/0x120
memcg_alloc_slab_cgroups+0xb3/0x150
allocate_slab+0x341/0x470
___slab_alloc+0xbf8/0x1380
kmem_cache_alloc+0x3fc/0x440
copy_fs_struct+0x49/0x340
copy_process+0x1cd8/0x4970
kernel_clone+0xa6/0x870
__do_compat_sys_ia32_clone+0x8d/0xb0
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page_list+0x1a7/0xdc0
release_pages+0x37b/0xf20
tlb_batch_pages_flush+0x82/0x160
tlb_finish_mmu+0x119/0x6f0
exit_mmap+0x1b0/0x680
__mmput+0xc4/0x3a0
exit_mm+0x177/0x200
do_exit+0x299/0xa90
do_group_exit+0xb9/0x260
__ia32_sys_exit_group+0x3e/0x50
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
entry_SYSENTER_compat_after_hwframe+0x7f/0x91

Memory state around the buggy address:
ffff88811cedc500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff88811cedc580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88811cedc600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 fc
^
ffff88811cedc680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811cedc700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0x431/0x460 [kasan_test]
Read of size 1 at addr ffff88811cedc680 by task kunit_try_catch/752

CPU: 0 PID: 752 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? kmalloc_oob_right+0x431/0x460 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? kmalloc_oob_right+0x431/0x460 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kmalloc_oob_right+0x431/0x460 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kmalloc_oob_right+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __kthread_parkme+0x64/0x220
? lockdep_hardirqs_on_prepare+0x19e/0x350
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 752:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_kmalloc+0xad/0xb0
kmalloc_oob_right+0x9f/0x460 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88811cedc600
which belongs to the cache kmalloc-128 of size 128
The buggy address is located 0 bytes to the right of
128-byte region [ffff88811cedc600, ffff88811cedc680)

The buggy address belongs to the physical page:
page:00000000721e9585 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11cedc
flags: 0x100000000000200(slab|node=0|zone=2)
raw: 0100000000000200 ffff8881000418c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 439, tgid 439 (kunit), ts 57706426435, free_ts 57704326321
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0xb6/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
__kmalloc_node+0x92/0x120
memcg_alloc_slab_cgroups+0xb3/0x150
allocate_slab+0x341/0x470
___slab_alloc+0xbf8/0x1380
kmem_cache_alloc+0x3fc/0x440
copy_fs_struct+0x49/0x340
copy_process+0x1cd8/0x4970
kernel_clone+0xa6/0x870
__do_compat_sys_ia32_clone+0x8d/0xb0
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page_list+0x1a7/0xdc0
release_pages+0x37b/0xf20
tlb_batch_pages_flush+0x82/0x160
tlb_finish_mmu+0x119/0x6f0
exit_mmap+0x1b0/0x680
__mmput+0xc4/0x3a0
exit_mm+0x177/0x200
do_exit+0x299/0xa90
do_group_exit+0xb9/0x260
__ia32_sys_exit_group+0x3e/0x50
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
entry_SYSENTER_compat_after_hwframe+0x7f/0x91

Memory state around the buggy address:
ffff88811cedc580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811cedc600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 fc
>ffff88811cedc680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
^
ffff88811cedc700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811cedc780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
ok 1 kmalloc_oob_right
==================================================================
BUG: KASAN: slab-out-of-bounds in kmalloc_oob_left+0x26b/0x290 [kasan_test]
Read of size 1 at addr ffff88810d66963f by task kunit_try_catch/755

CPU: 1 PID: 755 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? kmalloc_oob_left+0x26b/0x290 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? kmalloc_oob_left+0x26b/0x290 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kmalloc_oob_left+0x26b/0x290 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kmalloc_oob_left+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 631:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_kmalloc+0xad/0xb0
__kmalloc_node_track_caller+0xa0/0x110
kstrdup+0x3b/0xb0
__kernfs_new_node+0x86/0x780
kernfs_new_node+0x82/0x120
__kernfs_create_file+0x30/0x300
sysfs_add_bin_file_mode_ns+0x107/0x320
create_files+0x34b/0x5a0
internal_create_group+0x347/0x590
add_sect_attrs+0x496/0x820
mod_sysfs_setup+0x2f5/0x390
load_module+0x1a40/0x2090
__do_sys_finit_module+0x102/0x180
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
entry_SYSENTER_compat_after_hwframe+0x7f/0x91

The buggy address belongs to the object at ffff88810d669620
which belongs to the cache kmalloc-16 of size 16
The buggy address is located 15 bytes to the right of
16-byte region [ffff88810d669620, ffff88810d669630)

The buggy address belongs to the physical page:
page:000000000d2c5892 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10d669
anon flags: 0x100000000000200(slab|node=0|zone=2)
raw: 0100000000000200 ffff8881000413c0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 3419872706, free_ts 0
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
alloc_page_interleave+0x14/0x180
allocate_slab+0x2e0/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
__kmalloc+0x8f/0x120
acpi_ns_get_normalized_pathname+0x35/0x7a
acpi_ns_evaluate+0x27c/0x892
acpi_evaluate_object+0x321/0x664
acpi_evaluate_integer+0x96/0x160
acpi_bus_get_status+0x12e/0x280
acpi_add_single_object+0x341/0x8d0
acpi_bus_check_add+0x182/0x470
acpi_ns_walk_namespace+0x183/0x2b8
acpi_walk_namespace+0x9d/0xd3
page_owner free stack trace missing

Memory state around the buggy address:
ffff88810d669500: fa fb fc fc 00 04 fc fc fa fb fc fc 00 05 fc fc
ffff88810d669580: 00 04 fc fc 00 06 fc fc fa fb fc fc 00 03 fc fc
>ffff88810d669600: 00 05 fc fc 00 05 fc fc 00 07 fc fc 00 04 fc fc
^
ffff88810d669680: fb fb fc fc 00 06 fc fc fa fb fc fc 00 06 fc fc
ffff88810d669700: 00 03 fc fc 00 03 fc fc 00 02 fc fc 00 03 fc fc
==================================================================
ok 2 kmalloc_oob_left
==================================================================
BUG: KASAN: slab-out-of-bounds in kmalloc_node_oob_right+0x273/0x290 [kasan_test]
Read of size 1 at addr ffff88811d3ff000 by task kunit_try_catch/757

CPU: 0 PID: 757 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? kmalloc_node_oob_right+0x273/0x290 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? kmalloc_node_oob_right+0x273/0x290 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kmalloc_node_oob_right+0x273/0x290 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kmalloc_node_oob_right+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 757:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_kmalloc+0xad/0xb0
kmalloc_node_oob_right+0xa1/0x290 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88811d3fe000
which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes to the right of
4096-byte region [ffff88811d3fe000, ffff88811d3ff000)

The buggy address belongs to the physical page:
page:00000000fe135ed8 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88811d3fa000 pfn:0x11d3f8
head:00000000fe135ed8 order:3 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
anon flags: 0x100000000010200(slab|head|node=0|zone=2)
raw: 0100000000010200 ffff888100042140 ffffea0005c70400 0000000000000003
raw: ffff88811d3fa000 0000000080040001 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 192, tgid 192 (udevadm), ts 27772301601, free_ts 27757946318
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0x2e0/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
kmalloc_trace+0x2b/0x70
uevent_show+0x14d/0x350
dev_attr_show+0x46/0x80
sysfs_kf_seq_show+0x270/0x4b0
seq_read_iter+0x4b5/0x1220
vfs_read+0x5d9/0x920
ksys_read+0xed/0x1b0
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
entry_SYSENTER_compat_after_hwframe+0x7f/0x91
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
__unfreeze_partials+0x228/0x250
put_cpu_partial+0x105/0x260
__slab_free+0x3f1/0x5c0
qlist_free_all+0x68/0x160
kasan_quarantine_reduce+0x18c/0x1d0
__kasan_slab_alloc+0x6a/0x90
kmem_cache_alloc+0x26c/0x440
getname_flags+0x4f/0x550
do_sys_openat2+0xab/0x420
__ia32_compat_sys_openat+0x108/0x1a0
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
entry_SYSENTER_compat_after_hwframe+0x7f/0x91

Memory state around the buggy address:
ffff88811d3fef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff88811d3fef80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88811d3ff000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
^
ffff88811d3ff080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811d3ff100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
ok 3 kmalloc_node_oob_right
==================================================================
BUG: KASAN: slab-out-of-bounds in kmalloc_pagealloc_oob_right+0x201/0x210 [kasan_test]
Write of size 1 at addr ffff88816f2f200a by task kunit_try_catch/767

CPU: 1 PID: 767 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? __phys_addr+0xcb/0x170
? kasan_addr_to_slab+0x25/0x80
? kmalloc_pagealloc_oob_right+0x201/0x210 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? kmalloc_pagealloc_oob_right+0x201/0x210 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kmalloc_pagealloc_oob_right+0x201/0x210 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kmalloc_pagealloc_oob_right+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

The buggy address belongs to the physical page:
page:0000000002f02d49 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16f2f0
head:0000000002f02d49 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010000(head|node=0|zone=2)
raw: 0100000000010000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x40cc0(GFP_KERNEL|__GFP_COMP), pid 767, tgid 767 (kunit_try_catch), ts 58149539716, free_ts 53947972633
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
__kmalloc_large_node+0xba/0x160
kmalloc_large+0x21/0x80
kmalloc_pagealloc_oob_right+0x67/0x210 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
qlist_free_all+0x68/0x160
kasan_quarantine_reduce+0x18c/0x1d0
__kasan_slab_alloc+0x6a/0x90
kmem_cache_alloc+0x26c/0x440
getname_flags+0x4f/0x550
vfs_fstatat+0x3e/0x80
__do_compat_sys_ia32_stat64+0x6c/0xc0
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
entry_SYSENTER_compat_after_hwframe+0x7f/0x91

Memory state around the buggy address:
ffff88816f2f1f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff88816f2f1f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88816f2f2000: 00 02 fe fe fe fe fe fe fe fe fe fe fe fe fe fe
^
ffff88816f2f2080: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
ffff88816f2f2100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
ok 4 kmalloc_pagealloc_oob_right
==================================================================
BUG: KASAN: use-after-free in kmalloc_pagealloc_uaf+0x1f1/0x200 [kasan_test]
Read of size 1 at addr ffff88811cef0000 by task kunit_try_catch/770

CPU: 0 PID: 770 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? __phys_addr+0xcb/0x170
? kasan_addr_to_slab+0x25/0x80
? kmalloc_pagealloc_uaf+0x1f1/0x200 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? kmalloc_pagealloc_uaf+0x1f1/0x200 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kmalloc_pagealloc_uaf+0x1f1/0x200 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kmalloc_pagealloc_uaf+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

The buggy address belongs to the physical page:
page:00000000f7592687 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11cef0
flags: 0x100000000000000(node=0|zone=2)
raw: 0100000000000000 ffffea000473bd08 ffff8883aea00a38 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x40cc0(GFP_KERNEL|__GFP_COMP), pid 770, tgid 770 (kunit_try_catch), ts 58226633117, free_ts 58226641024
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
__kmalloc_large_node+0xba/0x160
kmalloc_large+0x21/0x80
kmalloc_pagealloc_uaf+0x67/0x200 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
kmalloc_pagealloc_uaf+0xbe/0x200 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

Memory state around the buggy address:
ffff88811ceeff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ffff88811ceeff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88811cef0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
^
ffff88811cef0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ffff88811cef0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
ok 5 kmalloc_pagealloc_uaf
==================================================================
BUG: KASAN: invalid-free in kmalloc_pagealloc_invalid_free+0xe7/0x1d0 [kasan_test]
Free of addr ffff8881195a8001 by task kunit_try_catch/776

CPU: 1 PID: 776 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? __phys_addr+0xcb/0x170
? kasan_addr_to_slab+0x25/0x80
? kmalloc_pagealloc_invalid_free+0xe7/0x1d0 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report_invalid_free+0x6a/0x170
? kmalloc_pagealloc_invalid_free+0xe7/0x1d0 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
free_large_kmalloc+0x72/0x160
kmalloc_pagealloc_invalid_free+0xe7/0x1d0 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kmalloc_pagealloc_invalid_free+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

The buggy address belongs to the physical page:
page:00000000eba5826b refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1195a8
head:00000000eba5826b order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010000(head|node=0|zone=2)
raw: 0100000000010000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x40cc0(GFP_KERNEL|__GFP_COMP), pid 776, tgid 776 (kunit_try_catch), ts 58271031188, free_ts 53943161937
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
__kmalloc_large_node+0xba/0x160
kmalloc_large+0x21/0x80
kmalloc_pagealloc_invalid_free+0x67/0x1d0 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
rcu_do_batch+0x445/0xf30
rcu_core+0x3c2/0x630
__do_softirq+0x30e/0xb00

Memory state around the buggy address:
ffff8881195a7f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff8881195a7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8881195a8000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
^
ffff8881195a8080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff8881195a8100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
ok 6 kmalloc_pagealloc_invalid_free
ok 7 pagealloc_oob_right # SKIP Test requires CONFIG_KASAN_GENERIC=n
==================================================================
BUG: KASAN: use-after-free in pagealloc_uaf+0x248/0x270 [kasan_test]
Read of size 1 at addr ffff88810f520000 by task kunit_try_catch/780

CPU: 0 PID: 780 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? __phys_addr+0xcb/0x170
? kasan_addr_to_slab+0x25/0x80
? pagealloc_uaf+0x248/0x270 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? pagealloc_uaf+0x248/0x270 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
pagealloc_uaf+0x248/0x270 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_pagealloc_uaf+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

The buggy address belongs to the physical page:
page:0000000016f68419 refcount:0 mapcount:-128 mapping:0000000000000000 index:0x0 pfn:0x10f520
flags: 0x100000000000000(node=0|zone=2)
raw: 0100000000000000 ffffea00043c6408 ffff88843fff0fe0 0000000000000000
raw: 0000000000000000 0000000000000004 00000000ffffff7f 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 4, migratetype Unmovable, gfp_mask 0xcc0(GFP_KERNEL), pid 780, tgid 780 (kunit_try_catch), ts 58357572950, free_ts 58357580508
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
pagealloc_uaf+0x69/0x270 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50
page last free stack trace:
__free_pages_ok+0x82e/0xe70
pagealloc_uaf+0x10d/0x270 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

Memory state around the buggy address:
ffff88810f51ff00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
ffff88810f51ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88810f520000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
^
ffff88810f520080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ffff88810f520100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
ok 8 pagealloc_uaf
==================================================================
BUG: KASAN: slab-out-of-bounds in kmalloc_large_oob_right+0x23a/0x250 [kasan_test]
Write of size 1 at addr ffff88816d1d9f00 by task kunit_try_catch/786

CPU: 1 PID: 786 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? kmalloc_large_oob_right+0x23a/0x250 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? kmalloc_large_oob_right+0x23a/0x250 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kmalloc_large_oob_right+0x23a/0x250 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kmalloc_large_oob_right+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 786:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_kmalloc+0xad/0xb0
kmalloc_large_oob_right+0xa0/0x250 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88816d1d8000
which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 7936 bytes inside of
8192-byte region [ffff88816d1d8000, ffff88816d1da000)

The buggy address belongs to the physical page:
page:0000000051d5d8a5 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16d1d8
head:0000000051d5d8a5 order:3 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=2)
raw: 0100000000010200 ffff888100042280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd28c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 647, tgid 647 (ifquery), ts 50899022771, free_ts 50891749257
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0x2e0/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
__kmalloc_node_track_caller+0x90/0x110
kmalloc_reserve+0x2a/0xb0
__alloc_skb+0xfe/0x290
netlink_dump+0x269/0xa40
netlink_recvmsg+0x662/0x810
____sys_recvmsg+0x1ce/0x740
___sys_recvmsg+0xbc/0x110
__sys_recvmsg+0xbd/0x150
__do_compat_sys_socketcall+0x448/0x640
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
rcu_do_batch+0x445/0xf30
rcu_core+0x3c2/0x630
__do_softirq+0x30e/0xb00

Memory state around the buggy address:
ffff88816d1d9e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff88816d1d9e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88816d1d9f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
^
ffff88816d1d9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88816d1da000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
ok 9 kmalloc_large_oob_right
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_more_oob_helper+0x4d6/0x520 [kasan_test]
Write of size 1 at addr ffff8881aff622eb by task kunit_try_catch/788

CPU: 0 PID: 788 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? krealloc_more_oob_helper+0x4d6/0x520 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_more_oob_helper+0x4d6/0x520 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_more_oob_helper+0x4d6/0x520 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_more_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 788:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_krealloc+0x12b/0x160
krealloc+0x93/0x130
krealloc_more_oob_helper+0x111/0x520 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff8881aff62200
which belongs to the cache kmalloc-256 of size 256
The buggy address is located 235 bytes inside of
256-byte region [ffff8881aff62200, ffff8881aff62300)

The buggy address belongs to the physical page:
page:000000001b9a64f3 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1aff62
head:000000001b9a64f3 order:1 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=2)
raw: 0100000000010200 ffff888100041b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 57557663757, free_ts 57543358938
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0x2e0/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
kmalloc_trace+0x2b/0x70
set_kthread_struct+0x12b/0x2b0
copy_process+0x1a5a/0x4970
kernel_clone+0xa6/0x870
kernel_thread+0x9b/0xc0
kthreadd+0x321/0x4c0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
qlist_free_all+0x68/0x160
kasan_quarantine_reduce+0x18c/0x1d0
__kasan_slab_alloc+0x6a/0x90
__kmem_cache_alloc_node+0x28b/0x440
kmalloc_trace+0x2b/0x70
syslog_print+0xce/0x460
do_syslog+0x513/0x550
kmsg_read+0x6b/0x90
vfs_read+0x27b/0x920
ksys_read+0xed/0x1b0
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
entry_SYSENTER_compat_after_hwframe+0x7f/0x91

Memory state around the buggy address:
ffff8881aff62180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff8881aff62200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8881aff62280: 00 00 00 00 00 00 00 00 00 00 00 00 00 03 fc fc
^
ffff8881aff62300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff8881aff62380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_more_oob_helper+0x4c9/0x520 [kasan_test]
Write of size 1 at addr ffff8881aff622f0 by task kunit_try_catch/788

CPU: 0 PID: 788 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? krealloc_more_oob_helper+0x4c9/0x520 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_more_oob_helper+0x4c9/0x520 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_more_oob_helper+0x4c9/0x520 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_more_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 788:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_krealloc+0x12b/0x160
krealloc+0x93/0x130
krealloc_more_oob_helper+0x111/0x520 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff8881aff62200
which belongs to the cache kmalloc-256 of size 256
The buggy address is located 240 bytes inside of
256-byte region [ffff8881aff62200, ffff8881aff62300)

The buggy address belongs to the physical page:
page:000000001b9a64f3 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1aff62
head:000000001b9a64f3 order:1 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=2)
raw: 0100000000010200 ffff888100041b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 57557663757, free_ts 57543358938
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0x2e0/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
kmalloc_trace+0x2b/0x70
set_kthread_struct+0x12b/0x2b0
copy_process+0x1a5a/0x4970
kernel_clone+0xa6/0x870
kernel_thread+0x9b/0xc0
kthreadd+0x321/0x4c0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
qlist_free_all+0x68/0x160
kasan_quarantine_reduce+0x18c/0x1d0
__kasan_slab_alloc+0x6a/0x90
__kmem_cache_alloc_node+0x28b/0x440
kmalloc_trace+0x2b/0x70
syslog_print+0xce/0x460
do_syslog+0x513/0x550
kmsg_read+0x6b/0x90
vfs_read+0x27b/0x920
ksys_read+0xed/0x1b0
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
entry_SYSENTER_compat_after_hwframe+0x7f/0x91

Memory state around the buggy address:
ffff8881aff62180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff8881aff62200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8881aff62280: 00 00 00 00 00 00 00 00 00 00 00 00 00 03 fc fc
^
ffff8881aff62300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff8881aff62380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
ok 10 krealloc_more_oob
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_less_oob_helper+0x7ff/0x820 [kasan_test]
Write of size 1 at addr ffff88811a17a8c9 by task kunit_try_catch/791

CPU: 1 PID: 791 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? krealloc_less_oob_helper+0x7ff/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_less_oob_helper+0x7ff/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_less_oob_helper+0x7ff/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_less_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 791:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_krealloc+0x12b/0x160
krealloc+0x93/0x130
krealloc_less_oob_helper+0x118/0x820 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88811a17a800
which belongs to the cache kmalloc-256 of size 256
The buggy address is located 201 bytes inside of
256-byte region [ffff88811a17a800, ffff88811a17a900)

The buggy address belongs to the physical page:
page:0000000031979011 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11a17a
head:0000000031979011 order:1 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=2)
raw: 0100000000010200 ffff888100041b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 58222257276, free_ts 53982998819
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0x2e0/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
kmalloc_trace+0x2b/0x70
set_kthread_struct+0x12b/0x2b0
copy_process+0x1a5a/0x4970
kernel_clone+0xa6/0x870
kernel_thread+0x9b/0xc0
kthreadd+0x321/0x4c0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
__unfreeze_partials+0x228/0x250
put_cpu_partial+0x105/0x260
__slab_free+0x3f1/0x5c0
qlist_free_all+0x68/0x160
kasan_quarantine_reduce+0x18c/0x1d0
__kasan_slab_alloc+0x6a/0x90
kmem_cache_alloc+0x26c/0x440
getname_flags+0x4f/0x550
do_sys_openat2+0xab/0x420
__ia32_compat_sys_openat+0x108/0x1a0
do_int80_syscall_32+0x72/0xd0
entry_INT80_compat+0xb1/0xc0

Memory state around the buggy address:
ffff88811a17a780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811a17a800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88811a17a880: 00 00 00 00 00 00 00 00 00 01 fc fc fc fc fc fc
^
ffff88811a17a900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811a17a980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_less_oob_helper+0x7f2/0x820 [kasan_test]
Write of size 1 at addr ffff88811a17a8d0 by task kunit_try_catch/791

CPU: 1 PID: 791 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? krealloc_less_oob_helper+0x7f2/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_less_oob_helper+0x7f2/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_less_oob_helper+0x7f2/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_less_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 791:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_krealloc+0x12b/0x160
krealloc+0x93/0x130
krealloc_less_oob_helper+0x118/0x820 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88811a17a800
which belongs to the cache kmalloc-256 of size 256
The buggy address is located 208 bytes inside of
256-byte region [ffff88811a17a800, ffff88811a17a900)

The buggy address belongs to the physical page:
page:0000000031979011 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11a17a
head:0000000031979011 order:1 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=2)
raw: 0100000000010200 ffff888100041b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 58222257276, free_ts 53982998819
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0x2e0/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
kmalloc_trace+0x2b/0x70
set_kthread_struct+0x12b/0x2b0
copy_process+0x1a5a/0x4970
kernel_clone+0xa6/0x870
kernel_thread+0x9b/0xc0
kthreadd+0x321/0x4c0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
__unfreeze_partials+0x228/0x250
put_cpu_partial+0x105/0x260
__slab_free+0x3f1/0x5c0
qlist_free_all+0x68/0x160
kasan_quarantine_reduce+0x18c/0x1d0
__kasan_slab_alloc+0x6a/0x90
kmem_cache_alloc+0x26c/0x440
getname_flags+0x4f/0x550
do_sys_openat2+0xab/0x420
__ia32_compat_sys_openat+0x108/0x1a0
do_int80_syscall_32+0x72/0xd0
entry_INT80_compat+0xb1/0xc0

Memory state around the buggy address:
ffff88811a17a780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811a17a800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88811a17a880: 00 00 00 00 00 00 00 00 00 01 fc fc fc fc fc fc
^
ffff88811a17a900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811a17a980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_less_oob_helper+0x7e5/0x820 [kasan_test]
Write of size 1 at addr ffff88811a17a8da by task kunit_try_catch/791

CPU: 1 PID: 791 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? krealloc_less_oob_helper+0x7e5/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_less_oob_helper+0x7e5/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_less_oob_helper+0x7e5/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_less_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 791:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_krealloc+0x12b/0x160
krealloc+0x93/0x130
krealloc_less_oob_helper+0x118/0x820 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88811a17a800
which belongs to the cache kmalloc-256 of size 256
The buggy address is located 218 bytes inside of
256-byte region [ffff88811a17a800, ffff88811a17a900)

The buggy address belongs to the physical page:
page:0000000031979011 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11a17a
head:0000000031979011 order:1 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=2)
raw: 0100000000010200 ffff888100041b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 58222257276, free_ts 53982998819
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0x2e0/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
kmalloc_trace+0x2b/0x70
set_kthread_struct+0x12b/0x2b0
copy_process+0x1a5a/0x4970
kernel_clone+0xa6/0x870
kernel_thread+0x9b/0xc0
kthreadd+0x321/0x4c0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
__unfreeze_partials+0x228/0x250
put_cpu_partial+0x105/0x260
__slab_free+0x3f1/0x5c0
qlist_free_all+0x68/0x160
kasan_quarantine_reduce+0x18c/0x1d0
__kasan_slab_alloc+0x6a/0x90
kmem_cache_alloc+0x26c/0x440
getname_flags+0x4f/0x550
do_sys_openat2+0xab/0x420
__ia32_compat_sys_openat+0x108/0x1a0
do_int80_syscall_32+0x72/0xd0
entry_INT80_compat+0xb1/0xc0

Memory state around the buggy address:
ffff88811a17a780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811a17a800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88811a17a880: 00 00 00 00 00 00 00 00 00 01 fc fc fc fc fc fc
^
ffff88811a17a900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811a17a980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_less_oob_helper+0x7d8/0x820 [kasan_test]
Write of size 1 at addr ffff88811a17a8ea by task kunit_try_catch/791

CPU: 1 PID: 791 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? krealloc_less_oob_helper+0x7d8/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_less_oob_helper+0x7d8/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_less_oob_helper+0x7d8/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_less_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 791:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_krealloc+0x12b/0x160
krealloc+0x93/0x130
krealloc_less_oob_helper+0x118/0x820 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88811a17a800
which belongs to the cache kmalloc-256 of size 256
The buggy address is located 234 bytes inside of
256-byte region [ffff88811a17a800, ffff88811a17a900)

The buggy address belongs to the physical page:
page:0000000031979011 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11a17a
head:0000000031979011 order:1 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=2)
raw: 0100000000010200 ffff888100041b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 58222257276, free_ts 53982998819
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0x2e0/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
kmalloc_trace+0x2b/0x70
set_kthread_struct+0x12b/0x2b0
copy_process+0x1a5a/0x4970
kernel_clone+0xa6/0x870
kernel_thread+0x9b/0xc0
kthreadd+0x321/0x4c0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
__unfreeze_partials+0x228/0x250
put_cpu_partial+0x105/0x260
__slab_free+0x3f1/0x5c0
qlist_free_all+0x68/0x160
kasan_quarantine_reduce+0x18c/0x1d0
__kasan_slab_alloc+0x6a/0x90
kmem_cache_alloc+0x26c/0x440
getname_flags+0x4f/0x550
do_sys_openat2+0xab/0x420
__ia32_compat_sys_openat+0x108/0x1a0
do_int80_syscall_32+0x72/0xd0
entry_INT80_compat+0xb1/0xc0

Memory state around the buggy address:
ffff88811a17a780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811a17a800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88811a17a880: 00 00 00 00 00 00 00 00 00 01 fc fc fc fc fc fc
^
ffff88811a17a900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811a17a980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_less_oob_helper+0x7cb/0x820 [kasan_test]
Write of size 1 at addr ffff88811a17a8eb by task kunit_try_catch/791

CPU: 1 PID: 791 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? krealloc_less_oob_helper+0x7cb/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_less_oob_helper+0x7cb/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_less_oob_helper+0x7cb/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_less_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 791:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_krealloc+0x12b/0x160
krealloc+0x93/0x130
krealloc_less_oob_helper+0x118/0x820 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88811a17a800
which belongs to the cache kmalloc-256 of size 256
The buggy address is located 235 bytes inside of
256-byte region [ffff88811a17a800, ffff88811a17a900)

The buggy address belongs to the physical page:
page:0000000031979011 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11a17a
head:0000000031979011 order:1 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=2)
raw: 0100000000010200 ffff888100041b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 58222257276, free_ts 53982998819
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0x2e0/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
kmalloc_trace+0x2b/0x70
set_kthread_struct+0x12b/0x2b0
copy_process+0x1a5a/0x4970
kernel_clone+0xa6/0x870
kernel_thread+0x9b/0xc0
kthreadd+0x321/0x4c0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
__unfreeze_partials+0x228/0x250
put_cpu_partial+0x105/0x260
__slab_free+0x3f1/0x5c0
qlist_free_all+0x68/0x160
kasan_quarantine_reduce+0x18c/0x1d0
__kasan_slab_alloc+0x6a/0x90
kmem_cache_alloc+0x26c/0x440
getname_flags+0x4f/0x550
do_sys_openat2+0xab/0x420
__ia32_compat_sys_openat+0x108/0x1a0
do_int80_syscall_32+0x72/0xd0
entry_INT80_compat+0xb1/0xc0

Memory state around the buggy address:
ffff88811a17a780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811a17a800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88811a17a880: 00 00 00 00 00 00 00 00 00 01 fc fc fc fc fc fc
^
ffff88811a17a900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811a17a980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
ok 11 krealloc_less_oob
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_more_oob_helper+0x4d6/0x520 [kasan_test]
Write of size 1 at addr ffff8881180560eb by task kunit_try_catch/795

CPU: 1 PID: 795 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? __phys_addr+0xcb/0x170
? kasan_addr_to_slab+0x25/0x80
? krealloc_more_oob_helper+0x4d6/0x520 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_more_oob_helper+0x4d6/0x520 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_more_oob_helper+0x4d6/0x520 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_more_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

The buggy address belongs to the physical page:
page:0000000030759c44 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x118054
head:0000000030759c44 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010000(head|node=0|zone=2)
raw: 0100000000010000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x40cc0(GFP_KERNEL|__GFP_COMP), pid 795, tgid 795 (kunit_try_catch), ts 58966590440, free_ts 53931576190
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
__kmalloc_large_node+0xba/0x160
__kmalloc+0xdf/0x120
krealloc_more_oob_helper+0xa9/0x520 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
rcu_do_batch+0x445/0xf30
rcu_core+0x3c2/0x630
__do_softirq+0x30e/0xb00

Memory state around the buggy address:
ffff888118055f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff888118056000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888118056080: 00 00 00 00 00 00 00 00 00 00 00 00 00 03 fe fe
^
ffff888118056100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
ffff888118056180: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_more_oob_helper+0x4c9/0x520 [kasan_test]
Write of size 1 at addr ffff8881180560f0 by task kunit_try_catch/795

CPU: 1 PID: 795 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? __phys_addr+0xcb/0x170
? kasan_addr_to_slab+0x25/0x80
? krealloc_more_oob_helper+0x4c9/0x520 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_more_oob_helper+0x4c9/0x520 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_more_oob_helper+0x4c9/0x520 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_more_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

The buggy address belongs to the physical page:
page:0000000030759c44 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x118054
head:0000000030759c44 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010000(head|node=0|zone=2)
raw: 0100000000010000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x40cc0(GFP_KERNEL|__GFP_COMP), pid 795, tgid 795 (kunit_try_catch), ts 58966590440, free_ts 53931576190
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
__kmalloc_large_node+0xba/0x160
__kmalloc+0xdf/0x120
krealloc_more_oob_helper+0xa9/0x520 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
rcu_do_batch+0x445/0xf30
rcu_core+0x3c2/0x630
__do_softirq+0x30e/0xb00

Memory state around the buggy address:
ffff888118055f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff888118056000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888118056080: 00 00 00 00 00 00 00 00 00 00 00 00 00 03 fe fe
^
ffff888118056100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
ffff888118056180: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
ok 12 krealloc_pagealloc_more_oob
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_less_oob_helper+0x7ff/0x820 [kasan_test]
Write of size 1 at addr ffff8881180660c9 by task kunit_try_catch/799

CPU: 1 PID: 799 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? __phys_addr+0xcb/0x170
? kasan_addr_to_slab+0x25/0x80
? krealloc_less_oob_helper+0x7ff/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_less_oob_helper+0x7ff/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_less_oob_helper+0x7ff/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_less_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

The buggy address belongs to the physical page:
page:000000007e8b2b23 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x118064
head:000000007e8b2b23 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010000(head|node=0|zone=2)
raw: 0100000000010000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x40cc0(GFP_KERNEL|__GFP_COMP), pid 799, tgid 799 (kunit_try_catch), ts 59069707515, free_ts 53931303439
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
__kmalloc_large_node+0xba/0x160
__kmalloc+0xdf/0x120
krealloc_less_oob_helper+0xb0/0x820 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
rcu_do_batch+0x445/0xf30
rcu_core+0x3c2/0x630
__do_softirq+0x30e/0xb00

Memory state around the buggy address:
ffff888118065f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff888118066000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888118066080: 00 00 00 00 00 00 00 00 00 01 fe fe fe fe fe fe
^
ffff888118066100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
ffff888118066180: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_less_oob_helper+0x7f2/0x820 [kasan_test]
Write of size 1 at addr ffff8881180660d0 by task kunit_try_catch/799

CPU: 1 PID: 799 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? __phys_addr+0xcb/0x170
? kasan_addr_to_slab+0x25/0x80
? krealloc_less_oob_helper+0x7f2/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_less_oob_helper+0x7f2/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_less_oob_helper+0x7f2/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_less_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

The buggy address belongs to the physical page:
page:000000007e8b2b23 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x118064
head:000000007e8b2b23 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010000(head|node=0|zone=2)
raw: 0100000000010000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x40cc0(GFP_KERNEL|__GFP_COMP), pid 799, tgid 799 (kunit_try_catch), ts 59069707515, free_ts 53931303439
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
__kmalloc_large_node+0xba/0x160
__kmalloc+0xdf/0x120
krealloc_less_oob_helper+0xb0/0x820 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
rcu_do_batch+0x445/0xf30
rcu_core+0x3c2/0x630
__do_softirq+0x30e/0xb00

Memory state around the buggy address:
ffff888118065f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff888118066000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888118066080: 00 00 00 00 00 00 00 00 00 01 fe fe fe fe fe fe
^
ffff888118066100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
ffff888118066180: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_less_oob_helper+0x7e5/0x820 [kasan_test]
Write of size 1 at addr ffff8881180660da by task kunit_try_catch/799

CPU: 1 PID: 799 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? __phys_addr+0xcb/0x170
? kasan_addr_to_slab+0x25/0x80
? krealloc_less_oob_helper+0x7e5/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_less_oob_helper+0x7e5/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_less_oob_helper+0x7e5/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_less_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

The buggy address belongs to the physical page:
page:000000007e8b2b23 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x118064
head:000000007e8b2b23 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010000(head|node=0|zone=2)
raw: 0100000000010000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x40cc0(GFP_KERNEL|__GFP_COMP), pid 799, tgid 799 (kunit_try_catch), ts 59069707515, free_ts 53931303439
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
__kmalloc_large_node+0xba/0x160
__kmalloc+0xdf/0x120
krealloc_less_oob_helper+0xb0/0x820 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
rcu_do_batch+0x445/0xf30
rcu_core+0x3c2/0x630
__do_softirq+0x30e/0xb00

Memory state around the buggy address:
ffff888118065f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff888118066000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888118066080: 00 00 00 00 00 00 00 00 00 01 fe fe fe fe fe fe
^
ffff888118066100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
ffff888118066180: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_less_oob_helper+0x7d8/0x820 [kasan_test]
Write of size 1 at addr ffff8881180660ea by task kunit_try_catch/799

CPU: 1 PID: 799 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? __phys_addr+0xcb/0x170
? kasan_addr_to_slab+0x25/0x80
? krealloc_less_oob_helper+0x7d8/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_less_oob_helper+0x7d8/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_less_oob_helper+0x7d8/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_less_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

The buggy address belongs to the physical page:
page:000000007e8b2b23 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x118064
head:000000007e8b2b23 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010000(head|node=0|zone=2)
raw: 0100000000010000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x40cc0(GFP_KERNEL|__GFP_COMP), pid 799, tgid 799 (kunit_try_catch), ts 59069707515, free_ts 53931303439
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
__kmalloc_large_node+0xba/0x160
__kmalloc+0xdf/0x120
krealloc_less_oob_helper+0xb0/0x820 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
rcu_do_batch+0x445/0xf30
rcu_core+0x3c2/0x630
__do_softirq+0x30e/0xb00

Memory state around the buggy address:
ffff888118065f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff888118066000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888118066080: 00 00 00 00 00 00 00 00 00 01 fe fe fe fe fe fe
^
ffff888118066100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
ffff888118066180: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in krealloc_less_oob_helper+0x7cb/0x820 [kasan_test]
Write of size 1 at addr ffff8881180660eb by task kunit_try_catch/799

CPU: 1 PID: 799 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? __phys_addr+0xcb/0x170
? kasan_addr_to_slab+0x25/0x80
? krealloc_less_oob_helper+0x7cb/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_less_oob_helper+0x7cb/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
krealloc_less_oob_helper+0x7cb/0x820 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_less_oob_helper+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

The buggy address belongs to the physical page:
page:000000007e8b2b23 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x118064
head:000000007e8b2b23 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010000(head|node=0|zone=2)
raw: 0100000000010000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x40cc0(GFP_KERNEL|__GFP_COMP), pid 799, tgid 799 (kunit_try_catch), ts 59069707515, free_ts 53931303439
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
__kmalloc_large_node+0xba/0x160
__kmalloc+0xdf/0x120
krealloc_less_oob_helper+0xb0/0x820 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
rcu_do_batch+0x445/0xf30
rcu_core+0x3c2/0x630
__do_softirq+0x30e/0xb00

Memory state around the buggy address:
ffff888118065f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff888118066000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888118066080: 00 00 00 00 00 00 00 00 00 01 fe fe fe fe fe fe
^
ffff888118066100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
ffff888118066180: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================
ok 13 krealloc_pagealloc_less_oob
==================================================================
BUG: KASAN: use-after-free in krealloc_uaf+0x147/0x390 [kasan_test]
Read of size 1 at addr ffff88811d47b000 by task kunit_try_catch/805

CPU: 1 PID: 805 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? krealloc_uaf+0x147/0x390 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_uaf+0x147/0x390 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? krealloc_uaf+0x147/0x390 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
__kasan_check_byte+0x3a/0x50
krealloc+0x6d/0x130
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
krealloc_uaf+0x147/0x390 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_uaf+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 805:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_kmalloc+0xad/0xb0
krealloc_uaf+0xb2/0x390 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

Freed by task 805:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
kasan_save_free_info+0x2e/0x50
____kasan_slab_free+0x14c/0x1b0
slab_free_freelist_hook+0xbc/0x210
__kmem_cache_free+0xdb/0x430
krealloc_uaf+0x109/0x390 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88811d47b000
which belongs to the cache kmalloc-256 of size 256
The buggy address is located 0 bytes inside of
256-byte region [ffff88811d47b000, ffff88811d47b100)

The buggy address belongs to the physical page:
page:00000000581073f5 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11d47a
head:00000000581073f5 order:1 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=2)
raw: 0100000000010200 ffff888100041b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 155, tgid 155 (systemd-journal), ts 59355561502, free_ts 59070094377
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0xb6/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
__kmalloc_node+0x92/0x120
memcg_alloc_slab_cgroups+0xb3/0x150
memcg_slab_post_alloc_hook+0x109/0x510
__kmem_cache_alloc_node+0x2b9/0x440
__kmalloc+0x8f/0x120
__d_alloc+0xe3/0x960
d_alloc+0x48/0x210
d_alloc_parallel+0xcd/0x1050
__lookup_slow+0x191/0x4a0
walk_component+0x447/0x520
link_path_walk+0x5c7/0xb80
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
__unfreeze_partials+0x228/0x250
put_cpu_partial+0x105/0x260
__slab_free+0x3f1/0x5c0
qlist_free_all+0x68/0x160
kasan_quarantine_reduce+0x18c/0x1d0
__kasan_kmalloc_large+0x8c/0xc0
__kmalloc+0xdf/0x120
krealloc_less_oob_helper+0xb0/0x820 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

Memory state around the buggy address:
ffff88811d47af00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811d47af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88811d47b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88811d47b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88811d47b100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: use-after-free in krealloc_uaf+0x36f/0x390 [kasan_test]
Read of size 1 at addr ffff88811d47b000 by task kunit_try_catch/805

CPU: 1 PID: 805 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? krealloc_uaf+0x36f/0x390 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? krealloc_uaf+0x36f/0x390 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
krealloc_uaf+0x36f/0x390 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_krealloc_uaf+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? do_raw_spin_trylock+0x130/0x220
? __pfx_do_raw_spin_trylock+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 805:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_kmalloc+0xad/0xb0
krealloc_uaf+0xb2/0x390 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

Freed by task 805:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
kasan_save_free_info+0x2e/0x50
____kasan_slab_free+0x14c/0x1b0
slab_free_freelist_hook+0xbc/0x210
__kmem_cache_free+0xdb/0x430
krealloc_uaf+0x109/0x390 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88811d47b000
which belongs to the cache kmalloc-256 of size 256
The buggy address is located 0 bytes inside of
256-byte region [ffff88811d47b000, ffff88811d47b100)

The buggy address belongs to the physical page:
page:00000000581073f5 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11d47a
head:00000000581073f5 order:1 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=2)
raw: 0100000000010200 ffff888100041b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 155, tgid 155 (systemd-journal), ts 59355561502, free_ts 59070094377
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0xb6/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
__kmalloc_node+0x92/0x120
memcg_alloc_slab_cgroups+0xb3/0x150
memcg_slab_post_alloc_hook+0x109/0x510
__kmem_cache_alloc_node+0x2b9/0x440
__kmalloc+0x8f/0x120
__d_alloc+0xe3/0x960
d_alloc+0x48/0x210
d_alloc_parallel+0xcd/0x1050
__lookup_slow+0x191/0x4a0
walk_component+0x447/0x520
link_path_walk+0x5c7/0xb80
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
__unfreeze_partials+0x228/0x250
put_cpu_partial+0x105/0x260
__slab_free+0x3f1/0x5c0
qlist_free_all+0x68/0x160
kasan_quarantine_reduce+0x18c/0x1d0
__kasan_kmalloc_large+0x8c/0xc0
__kmalloc+0xdf/0x120
krealloc_less_oob_helper+0xb0/0x820 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

Memory state around the buggy address:
ffff88811d47af00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88811d47af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88811d47b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88811d47b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88811d47b100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
ok 14 krealloc_uaf
==================================================================
BUG: KASAN: slab-out-of-bounds in kmalloc_oob_16+0x355/0x370 [kasan_test]
Write of size 16 at addr ffff88816c5a1b00 by task kunit_try_catch/812

CPU: 0 PID: 812 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? kmalloc_oob_16+0x355/0x370 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? kmalloc_oob_16+0x355/0x370 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kmalloc_oob_16+0x355/0x370 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kmalloc_oob_16+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 812:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_kmalloc+0xad/0xb0
kmalloc_oob_16+0xaa/0x370 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88816c5a1b00
which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes inside of
16-byte region [ffff88816c5a1b00, ffff88816c5a1b10)

The buggy address belongs to the physical page:
page:00000000194237b0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16c5a1
flags: 0x100000000000200(slab|node=0|zone=2)
raw: 0100000000000200 ffff8881000413c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 715, tgid 715 (modprobe), ts 57349780466, free_ts 50371267357
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0x2e0/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
__kmalloc_node_track_caller+0x90/0x110
kstrdup+0x3b/0xb0
add_sect_attrs+0x35f/0x820
mod_sysfs_setup+0x2f5/0x390
load_module+0x1a40/0x2090
__do_sys_finit_module+0x102/0x180
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
entry_SYSENTER_compat_after_hwframe+0x7f/0x91
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
__unfreeze_partials+0x228/0x250
put_cpu_partial+0x105/0x260
__slab_free+0x3f1/0x5c0
qlist_free_all+0x68/0x160
kasan_quarantine_reduce+0x18c/0x1d0
__kasan_slab_alloc+0x6a/0x90
kmem_cache_alloc+0x26c/0x440
vm_area_dup+0x2b/0xa30
dup_mmap+0x581/0xd60
dup_mm+0xc7/0x380
copy_process+0x1f88/0x4970
kernel_clone+0xa6/0x870
__do_compat_sys_ia32_clone+0x8d/0xb0
__do_fast_syscall_32+0x97/0x120

Memory state around the buggy address:
ffff88816c5a1a00: 00 06 fc fc 00 04 fc fc 00 04 fc fc fc fc fc fc
ffff88816c5a1a80: 00 06 fc fc fc fc fc fc 00 05 fc fc 00 05 fc fc
>ffff88816c5a1b00: 00 05 fc fc fa fb fc fc 00 07 fc fc fc fc fc fc
^
ffff88816c5a1b80: fa fb fc fc 00 04 fc fc 00 04 fc fc 00 00 fc fc
ffff88816c5a1c00: 00 07 fc fc fa fb fc fc 00 04 fc fc 00 04 fc fc
==================================================================
ok 15 kmalloc_oob_16
==================================================================
BUG: KASAN: use-after-free in kmalloc_uaf_16+0x333/0x370 [kasan_test]
Read of size 16 at addr ffff88816d973560 by task kunit_try_catch/840

CPU: 1 PID: 840 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x61
print_address_description+0x6d/0x28b
print_report+0x106/0x1f0
? fixup_red_left+0x3c/0x60
? kmalloc_uaf_16+0x333/0x370 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kasan_report+0x90/0xc0
? kmalloc_uaf_16+0x333/0x370 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
kmalloc_uaf_16+0x333/0x370 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kmalloc_uaf_16+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>

Allocated by task 840:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
__kasan_kmalloc+0xad/0xb0
kmalloc_uaf_16+0x143/0x370 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

Freed by task 840:
kasan_save_stack+0x22/0x50
kasan_set_track+0x25/0x30
kasan_save_free_info+0x2e/0x50
____kasan_slab_free+0x14c/0x1b0
slab_free_freelist_hook+0xbc/0x210
__kmem_cache_free+0xdb/0x430
kmalloc_uaf_16+0x19a/0x370 [kasan_test]
kunit_try_run_case+0x10f/0x1a0
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
ret_from_fork+0x2c/0x50

The buggy address belongs to the object at ffff88816d973560
which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes inside of
16-byte region [ffff88816d973560, ffff88816d973570)

The buggy address belongs to the physical page:
page:000000000a6e8efa refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16d973
flags: 0x100000000000200(slab|node=0|zone=2)
raw: 0100000000000200 ffff8881000413c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY), pid 155, tgid 155 (systemd-journal), ts 59591126566, free_ts 59590622535
get_page_from_freelist+0x6b2/0xc20
__alloc_pages+0x42b/0x910
allocate_slab+0x2e0/0x470
___slab_alloc+0xbf8/0x1380
__kmem_cache_alloc_node+0x3cd/0x440
kmalloc_trace+0x2b/0x70
proc_self_get_link+0x1e2/0x290
pick_link+0x9d8/0x11c0
step_into+0x6ce/0x9b0
link_path_walk+0x5c7/0xb80
path_lookupat+0x192/0x730
filename_lookup+0x1a4/0x550
user_path_at_empty+0x7d/0x90
path_getxattr+0x7b/0x120
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
page last free stack trace:
free_pcp_prepare+0x57c/0xbc0
free_unref_page+0x4e/0x460
tlb_finish_mmu+0x16c/0x6f0
unmap_region+0x1d0/0x290
do_mas_align_munmap+0x7fb/0xf00
do_mas_munmap+0x15f/0x210
__vm_munmap+0x11b/0x1f0
__ia32_sys_munmap+0x57/0x80
__do_fast_syscall_32+0x97/0x120
do_fast_syscall_32+0x33/0x80
entry_SYSENTER_compat_after_hwframe+0x7f/0x91

Memory state around the buggy address:
ffff88816d973400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88816d973480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88816d973500: fc fc fc fc fc fc fc fc fc fc fc fc fa fb fc fc
^
ffff88816d973580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88816d973600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
ok 16 kmalloc_uaf_16
# kmalloc_oob_in_memset: EXPECTATION FAILED at mm/kasan/kasan_test.c:558
KASAN failure expected in "memset(ptr, 0, size + KASAN_GRANULE_SIZE)", but none occurred
not ok 17 kmalloc_oob_in_memset
# kmalloc_oob_memset_2: EXPECTATION FAILED at mm/kasan/kasan_test.c:505
KASAN failure expected in "memset(ptr + size - 1, 0, 2)", but none occurred
not ok 18 kmalloc_oob_memset_2
# kmalloc_oob_memset_4: EXPECTATION FAILED at mm/kasan/kasan_test.c:518
KASAN failure expected in "memset(ptr + size - 3, 0, 4)", but none occurred
not ok 19 kmalloc_oob_memset_4
# kmalloc_oob_memset_8: EXPECTATION FAILED at mm/kasan/kasan_test.c:531
KASAN failure expected in "memset(ptr + size - 7, 0, 8)", but none occurred
not ok 20 kmalloc_oob_memset_8
# kmalloc_oob_memset_16: EXPECTATION FAILED at mm/kasan/kasan_test.c:544
KASAN failure expected in "memset(ptr + size - 15, 0, 16)", but none occurred
not ok 21 kmalloc_oob_memset_16
BUG: unable to handle page fault for address: ffff88816c600000
sed[279]: segfault at 5a40fe44 ip 0000000056616232 sp 00000000ffae20e0 error 5
#PF: supervisor write access in kernel mode
in sed[5660b000+13000]
#PF: error_code(0x0003) - permissions violation
PGD 8e01067 P4D 8e01067 PUD 8e06067 PMD 16c5a0063 PTE 6c60106380000001
Oops: 0003 [#1] SMP KASAN PTI
likely on CPU 0 (core 0, socket 0)
CPU: 1 PID: 861 Comm: kunit_try_catch Tainted: G    B            N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268

Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
RIP: 0010:memmove+0x53/0x1c0
Code: 81 83 78 04 00 74 34 90 8b 00 8b 0c 24 8b 54 d8 04 8b 04 d8 83 c3 01 e8 6c ee ff ff 8b 95 d8 02 00 00 8b 8d e4 02 00 00 01 fa <8b> 42 04 8b 04 30 8d 04 40 8d 04 81 39 58 04 77 cd 83 44 24 04 01
Code: 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 48 48 83 ea 20 48 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 4c 8b 46 18 48 8d 76 20 <4c> 89 1f 4c 89 57 08 4c 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48
RSP: 0018:ffff888172517e40 EFLAGS: 00210286
RAX: ffff88816b5e3600 RBX: 0000000000000001 RCX: 0000000000000001
RDX: fffffffffefe35be RSI: ffff88816c600024 RDI: ffff88816c600000
RBP: ffff88816b5e3600 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1102e4a2fc9
R13: ffff88811d3078e8 R14: fffffffffffffffe R15: ffff88811d307900
FS:  0000000000000000(0000) GS:ffff8883aec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88816c600000 CR3: 00000001bb902000 CR4: 00000000000406e0
DR0: ffffffff88998660 DR1: ffffffff88998661 DR2: ffffffff88998663
DR3: ffffffff88998665 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
<TASK>
kmalloc_memmove_negative_size+0x17c/0x280 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? __pfx_kmalloc_memmove_negative_size+0x10/0x10 [kasan_test c0971dfb7d77347ae6233b2dc450adb43ceabd6b]
? rcu_read_lock_sched_held+0x16/0x80
? trace_irq_enable+0x144/0x1d0
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_try_run_case+0x10f/0x1a0
? __pfx_kunit_try_run_case+0x10/0x10
? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
kunit_generic_run_threadfn_adapter+0x51/0xa0
kthread+0x25c/0x2e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>
Modules linked in: kasan_test fat_test test_sort test_list_sort time_test sysctl_test lib_test resource_kunit dev_addr_lists_test memcpy_kunit list_test test_linear_ranges linear_ranges test_hash ext4_inode_test cmdline_kunit test_bits bitfield_kunit drm drm_panel_orientation_quirks
CR2: ffff88816c600000
---[ end trace 0000000000000000 ]---
RIP: 0010:memmove+0x53/0x1c0
Code: 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 48 48 83 ea 20 48 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 4c 8b 46 18 48 8d 76 20 <4c> 89 1f 4c 89 57 08 4c 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48
BUG: unable to handle page fault for address: ffff88810f124000
RSP: 0018:ffff888172517e40 EFLAGS: 00210286
#PF: supervisor read access in kernel mode
#PF: error_code(0x0009) - reserved bit violation
RAX: ffff88816b5e3600 RBX: 0000000000000001 RCX: 0000000000000001
PGD 8e01067 
RDX: fffffffffefe35be RSI: ffff88816c600024 RDI: ffff88816c600000
P4D 8e01067 
RBP: ffff88816b5e3600 R08: 0000000000000000 R09: 0000000000000000
PUD 8e05067 
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1102e4a2fc9
PMD 16c5af063 
R13: ffff88811d3078e8 R14: fffffffffffffffe R15: ffff88811d307900
PTE f12506380000001
FS:  0000000000000000(0000) GS:ffff8883aec00000(0000) knlGS:0000000000000000

Oops: 0009 [#2] SMP KASAN PTI
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CPU: 0 PID: 279 Comm: sed Tainted: G    B D          N 6.2.0-rc1-00083-g69d4c0d32186 #1 ed3fbe37f7c05ecb3d379e1396de0254ba429268
CR2: ffff88816c600000 CR3: 00000001bb902000 CR4: 00000000000406e0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
DR0: ffffffff88998660 DR1: ffffffff88998661 DR2: ffffffff88998663
RIP: 0010:zap_pte_range+0x59f/0x1d70
DR3: ffffffff88998665 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Code: 10 00 00 4c 39 6c 24 08 0f 84 52 0a 00 00 49 89 c5 4c 89 f0 49 8d ad 00 f0 ff ff 48 c1 e8 03 42 80 3c 38 00 0f 85 b5 12 00 00 <4d> 8b 26 49 f7 c4 9f ff ff ff 74 c2 48 8b 44 24 30 80 38 00 0f 85
Kernel panic - not syncing: Fatal exception
RSP: 0018:ffff8881b70ef7d0 EFLAGS: 00010246
RAX: 1ffff11021e24800 RBX: 000000010f124000 RCX: ffffffff8175d706
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8881b700080c
RBP: 000000005a000000 R08: 0000000000000000 R09: ffff8881b700080f
R10: ffffed1036e00101 R11: 0000000000000001 R12: 000000010f124067
R13: 000000005a001000 R14: ffff88810f124000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8883ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffff88810f124000 CR3: 0000000005816000 CR4: 00000000000406f0
DR0: ffffffff88998664 DR1: ffffffff88998665 DR2: ffffffff88998662
DR3: ffffffff88998663 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
<TASK>
? __pfx_zap_pte_range+0x10/0x10
zap_pmd_range+0x229/0x420
unmap_page_range+0x528/0x9a0
unmap_vmas+0x233/0x370
? __pfx_unmap_vmas+0x10/0x10
? lock_acquire+0x494/0x5a0
exit_mmap+0x14c/0x680
? __pfx_exit_mmap+0x10/0x10
? rcu_read_lock_sched_held+0x16/0x80
? __down_write_trylock+0x1d3/0x4b0
? __up_write+0x3a2/0x700
? __mmput+0x2f1/0x3a0
? lock_release+0x257/0x310
__mmput+0xc4/0x3a0
exit_mm+0x177/0x200
do_exit+0x299/0xa90
? trace_irq_enable+0x144/0x1d0
do_group_exit+0xb9/0x260
get_signal+0x18f3/0x1ae0
? __pfx_get_signal+0x10/0x10
? __schedule+0x85e/0x1440
arch_do_signal_or_restart+0x6a/0x380
? __pfx_arch_do_signal_or_restart+0x10/0x10
? schedule+0x19f/0x2d0
exit_to_user_mode_prepare+0x205/0x270
irqentry_exit_to_user_mode+0x9/0x40
asm_exc_page_fault+0x26/0x30
RIP: 0023:0x56616232
Code: Unable to access opcode bytes at 0x56616208.
RSP: 002b:00000000ffae20e0 EFLAGS: 00010202
RAX: 00000000000001ff RBX: 000000000000066d RCX: 00000000f7a00010
RDX: 000000005a40fe40 RSI: 0000000000000468 RDI: 00000000000050a0
RBP: 0000000057778f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
</TASK>
Modules linked in: kasan_test fat_test test_sort test_list_sort time_test sysctl_test lib_test resource_kunit dev_addr_lists_test memcpy_kunit list_test test_linear_ranges linear_ranges test_hash ext4_inode_test cmdline_kunit test_bits bitfield_kunit drm drm_panel_orientation_quirks
CR2: ffff88810f124000
---[ end trace 0000000000000000 ]---
RIP: 0010:memmove+0x53/0x1c0
Code: 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 48 48 83 ea 20 48 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 4c 8b 46 18 48 8d 76 20 <4c> 89 1f 4c 89 57 08 4c 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48
RSP: 0018:ffff888172517e40 EFLAGS: 00210286
RAX: ffff88816b5e3600 RBX: 0000000000000001 RCX: 0000000000000001
RDX: fffffffffefe35be RSI: ffff88816c600024 RDI: ffff88816c600000
RBP: ffff88816b5e3600 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1102e4a2fc9
R13: ffff88811d3078e8 R14: fffffffffffffffe R15: ffff88811d307900
FS:  0000000000000000(0000) GS:ffff8883ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffff88810f124000 CR3: 0000000005816000 CR4: 00000000000406f0
DR0: ffffffff88998664 DR1: ffffffff88998665 DR2: ffffffff88998662
DR3: ffffffff88998663 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Shutting down cpus with NMI
Kernel Offset: disabled

Kboot worker: lkp-worker42
Elapsed time: 60

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu SandyBridge
	-kernel $kernel
	-initrd initrd-vm-meta-125.cgz
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
	ip=::::vm-meta-125::dhcp
	root=/dev/ram0
	RESULT_ROOT=/result/kunit/group-00/vm-snb/debian-11.1-i386-20220923.cgz/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/21
	BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20211016/gcc-11/69d4c0d3218692ffa56b0e1b9c76c50c699d7044/vmlinuz-6.2.0-rc1-00083-g69d4c0d32186
	branch=linus/master
	job=/job-script
	user=lkp
	ARCH=x86_64
	kconfig=x86_64-randconfig-a012-20211016
	commit=69d4c0d3218692ffa56b0e1b9c76c50c699d7044
	initcall_debug
	nmi_watchdog=0
	vmalloc=256M
	initramfs_async=0
	page_owner=on
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

--CxYnWoSba6GjFw2I--
