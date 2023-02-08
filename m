Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9615868E9CD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjBHIXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:23:32 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135DCB746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675844612; x=1707380612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=45dH+zBTIE17rIGyrDFbBhw/gbp1QLdtir+cfcZ9RYU=;
  b=KQCNzQopfM4G2kqftGKtm7KlnJzhULdNZl5Uk8bDigwaZnMtJCQnRMGc
   8TTDYpaDbzmOQywJZLBa9ysT8m3t6w6ngujC151c6mxCDJKQrgXydRDXN
   LmYiSLdL9bhlK9uswvQULIXRi0RaUXDSDbQ6BxTaee/egAmy2+XKqxvgw
   k2O5QNNBtOAXe61PN5F7UYAg4Wbkyaxg3tlL5YpcGs4BVi1znq2URuOg/
   IrQ9nL0CDCtZpCkZs30qZYSlgFks9woOh9E86JYhzQmrg/Ht9hMeAl4r7
   nNyo4roac+7pdLIiQ9J2pp7yeIT7tRPJkjPJ+qpzauCL0lWU02y+GcGqn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415963157"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="c'?log'?scan'208";a="415963157"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 00:23:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="730781885"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="c'?log'?scan'208";a="730781885"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 08 Feb 2023 00:23:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 00:23:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 00:23:17 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 00:23:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bkoi6StkZnntuTjPWLL6ik0fezcUAlOUvjRjaKVbw5wSMr9rVOeM612uR5uhmwLUBs6oygmXbd1JkiKOMUQOkRUq3ou59oFhbt8a16ji+Vkbfp298QjKCTT5/mak9qP9WZV+NOD1HmtjwEVbDeq60F5XwcyLPOgAVucBCHA68v6PjN0uFKAKlBiVz7PkR/K8bh6HAIftRtZkhxDmq6gQfvSRTHhI0WoGJNO4TTCW61a1KzOTSW9+8a6kl5YiWJzMRnbX+CjPqa1jSr3vAi5C9UNcg0U66OUK8iQJIwslhibrLlsLDS8z6zJLEkPVGF75lpYxTZEiwPF4GtTIBaaBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeEeDuufnn13Zr9KiB7pZZgLKewwEDJTWKsI4zuitaw=;
 b=VH1Z7ev1SJTkk2/my5fffzimG2oAMPWPsQ+C15Fn5fyoSbc7ao58x7Q/ekixvwkMBMKIOcfLoWfzDq5q6/sRzjwrTjjfwFjSXhIG0rL/L008/RPwgv7f4nxObTtdAp70vIXbQ6kXfLdDc+YyshJNipdyplDBd099HLSqKMh05+mrGgIJuv19QMb8xJ/0yMkVHIyBWbduVTDu3oGd6bmZQnM9T4AJnfU0N96/pJtNWCA02X8AhwzeucVNUkW76ZZ0vJeQKY0bK5FhRjNf6WZLJ1pasqsNaF8AsCtz6FOs8z3M7/UF+e3iavRLjrwydcNxEJV5tygm0J76zLIVd79LNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA0PR11MB4560.namprd11.prod.outlook.com (2603:10b6:806:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 08:23:13 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80%4]) with mapi id 15.20.6064.029; Wed, 8 Feb 2023
 08:23:13 +0000
Date:   Wed, 8 Feb 2023 16:24:15 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <shy828301@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <naoya.horiguchi@nec.com>, <hughd@google.com>,
        <kirill.shutemov@linux.intel.com>, <heng.su@intel.com>,
        <pengfei.xu@intel.com>, <willy@infradead.org>, <osalvador@suse.de>,
        <peterx@redhat.com>, <akpm@linux-foundation.org>
Subject: [Syzkaller & bisect] There is "split_huge_page_to_list" WARNING in
 v6.2-rc7 kernel
Message-ID: <Y+NcL23vX+HaDRR3@xpf.sh.intel.com>
Content-Type: multipart/mixed; boundary="b3rEXDtV+UP6p3C9"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA0PR11MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7cc42f-9126-443d-fe03-08db09adb7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7P9M9wnHHqhvJPV1GFVHueXeLw/ChW1DMtnFL7yxj+dRd8H1LGTPPu+OGS+PyuL/sF16y88zDnU70cFtE2Vq3OLg5rpz3up4C4mXkEun2WxRMZo3aIyANJCcx3mE8IcgB53xP+Ob10t+iM4a/Id58dwGXZItwxnziyK8UprgS+MJMs8rpB54U1yi5UBSf581dGIJXKAeAEBUuAzv3yU8/UUp95jq6C7wB6SccEIo55OOtQRPZ5A4Mq9gNfh7wzRkJy85mCcplLXgraRltzsPzkP4sAW6jDGgV5gvlnoGu56BU3tJavJNCUPHHkkfjbqOO/PoUvzADIlEq4yQUwXqcu4F1mFF+r23boORCc5I4rMeFqs2TBJBIPBzz81vNJFLqB5/YuKm4Kj/8b4Ql13CDeO6RBMnAEIOJbg6w5CoTnsfTOgGflcKgSgMKypbGDiqOJpC6HGTTzDQKkH3JNKy1WrlOMXdRKxdz6/0fix5d6IIKTs6mT7hd8ZZyxBbDkUaVL5Poi3/hetPCqpmF5i4urT9oENTKyK01rCWTlj/byOGAz/O8ADKtqrHmCEYuPq9x3pXNWEhVuZyscvE/1lV5n0dG+j+7t/06Di1VWyqALTq6xQcAWKQ6Gz5S/mC7kWbDP8w1rBCWhbtHwxh2mTzCVSTufwzx4dBLJHq/Xy1nhNlr1Y0KecrAd9uGQEjOIr/gW7/dAsQklKGcP9Qh4MvHa4H3sw69sNjCdqOfeaU/ha+8B7U/iV/jQZdCpzvt5ReKUrfFHW2SGiN+NhO4qriUVqrBeN7d85S/yui+lmQf9m2kajDXPlo531Va/C9yHZ0BlKbrVj6Z233QH028IwbUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199018)(8936002)(2906002)(41300700001)(66476007)(66556008)(4326008)(66946007)(8676002)(44832011)(235185007)(86362001)(316002)(6512007)(82960400001)(5660300002)(38100700002)(478600001)(83380400001)(6486002)(26005)(186003)(33964004)(44144004)(6506007)(21480400003)(45080400002)(966005)(21314003)(99710200001)(14583001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c0XIs9POrDKwHDpbngkrjZyXtX6rvfteqbOEuv32WEiUc53skRs3bkY1sYdP?=
 =?us-ascii?Q?/FB5qyYYTyWqyG9yA23TI5aUB6vFqmkSIRXFpivNi0O/WWF3xHnKipUBAcz3?=
 =?us-ascii?Q?LhYHV9hO650Oip/XpRCLVHW7SKpb3atO9/fu0JNOlmR8TwRUXTiBxcBrVUdF?=
 =?us-ascii?Q?0Wrz4ei1UE2GW0gJP3IRUQ9G/b8SiHBeyfBptTYklIDuPpaFgm5gfNdbTLLd?=
 =?us-ascii?Q?Acf+YKC1CbFSSzvlUsjmSmaAquOvZSyL1Nk3qkB/xtuwYw0VODT5yWVyvhRa?=
 =?us-ascii?Q?g5TJObQQDk9Sw4Y7ixIolVEmuNtmn2i7Oe4/bbB+eEIpu8gQO32vqomxNMSh?=
 =?us-ascii?Q?zcBey39Uku60psidjywRDVV+Rj0AKw8gnsq0CFoiMiQzQbdikqYlsPpN7mFp?=
 =?us-ascii?Q?8pJJsUZvcZ9JXQbJ84GgTyIzNZHPZI46O16JxEvo6pgPxmQUZjukaGrlmHJi?=
 =?us-ascii?Q?mACzAEmdDxlvO77Coy41qyUeDZITpKdXzj45XgYras4LWp5Kp354t1roElr0?=
 =?us-ascii?Q?+hBVPMPUnbckTrcNRNouMXcjCRESNSJjvQw2A8sEyjCDcxHJhObb54I0xfTM?=
 =?us-ascii?Q?UFxks1lDVNaIV1dQ/oqeaAMJ+uxH32BvE9ljhVRS1zdcA/PGv30ugub3jw3a?=
 =?us-ascii?Q?z4/71cDspTf4vk6My7c2WKYpujWzKk646gciFR1KBAvXWdjvtJ8OIGAnhQBg?=
 =?us-ascii?Q?NTlLmcoYs6zS+HzRlBd7ATh10SFp8OV7U0btG/0bKx4QKcOBh22gJhwZRLf9?=
 =?us-ascii?Q?8bBKiw58G1XilcGCQrOCAG/rtLLgUMRE0B/03Eo2sVdzlpT80ldjjVRNN75J?=
 =?us-ascii?Q?9ZRd46VhFnHQDkRBllqUawSe9en0KFiZ6SrMOIx7MxTD/QQy8Ow8HZ3+ybzG?=
 =?us-ascii?Q?b3pDK2pY8qZSutj9mbkhu6y3niGNwftwq8rc5Joc/TilBcxq2lTHr4VfdI4S?=
 =?us-ascii?Q?04gT8mgLiW2SD3+GcfYil+uLzG9reNPK6UERgsVXXVJRvZDvgYjGsmkIcYCU?=
 =?us-ascii?Q?sLLNPacuZuyEvgK28Mmyi5yrJY4uGnOUzcTKBcDwEMY7DQAiADz2Y3s70lOg?=
 =?us-ascii?Q?mBU0IDsy0oLOxMpgcQWdsUvwcqmDGtQMNh4MtbyEnGkLhHThSF5iaFIyw1Ze?=
 =?us-ascii?Q?D+v0ovuwPIKLJm+pLbBoqP4Ch7nj3BTLuPTlgEW2N/5WjwJU34V6/Qhkhncd?=
 =?us-ascii?Q?VT912nrPNyR9N6GHRl5EPApc9ioOJqXUx/fSzgmTnmuK474/pyug70AD51W8?=
 =?us-ascii?Q?LJtlpx7byUA3oeSxDDvc/QlY1VaTdZgTiNC3y0PTpfExivbnY7YEVz3Orc9k?=
 =?us-ascii?Q?/LaeFvOec0vPM73pokpc1NTnJNK99kM+lUk3TmLitqoTKgrf3UjDBmGvI1qZ?=
 =?us-ascii?Q?rMGSh+qyuUBitR809FBSLDlzn1284sXWXf74QGRt04v+doB4a5Cj8Crofe1I?=
 =?us-ascii?Q?1gE5U4Uu+lSg0MUg349ml33Uk66Z8cpqR+0hRIkyB3hjGQJj7e5YbJyzoLaZ?=
 =?us-ascii?Q?FhBSGj7Nx/GclHrULF68bOgpduqrf5j8QSt36xYpNOtpi8Y3VwNtCYh3VMVf?=
 =?us-ascii?Q?azyu2wLEooiwlmOqusQbvqSUM3pO8aUCJuWf7gcLD0GTWl1wN/ojv9nu7bM7?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7cc42f-9126-443d-fe03-08db09adb7b4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 08:23:13.0558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpxJifbJHyX0+WZilllEWivcRDkVsDZtG7hWIt+63ASqvb8Bjvq5uJNJ0leVbvJs/0NTKGf3JtTE3Z2803DmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4560
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--b3rEXDtV+UP6p3C9
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Yang Shi and kernel expert,

Greeting!

There is "split_huge_page_to_list" WARNING in v6.2-rc7 kernel in guest.
[   30.076996] Injecting memory failure for pfn 0x18eef at process virtual address 0x20cef000
[   30.077554] page:000000005a337492 refcount:2 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x18e00
[   30.078118] head:000000005a337492 order:9 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
[   30.078632] flags: 0xfffffc0010001(locked|head|node=0|zone=1|lastcpupid=0x1fffff)
[   30.079065] raw: 000fffffc0010001 0000000000000000 dead000000000122 0000000000000000
[   30.079507] raw: 0000000000000000 0000000000000000 00000002ffffffff 0000000000000000
[   30.079940] page dumped because: VM_WARN_ON_ONCE_FOLIO(is_hzp)
[   30.080449] ------------[ cut here ]------------
[   30.080715] WARNING: CPU: 1 PID: 517 at mm/huge_memory.c:2667 split_huge_page_to_list+0x1629/0x3970
[   30.081257] Modules linked in:
[   30.081452] CPU: 1 PID: 517 Comm: repro Not tainted 6.2.0-rc7-4ec5183ec486 #1
[   30.081891] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   30.082530] RIP: 0010:split_huge_page_to_list+0x1629/0x3970
[   30.082863] Code: 31 ff 44 89 e6 e8 d7 aa a2 ff 45 84 e4 75 1d e8 6d a9 a2 ff 48 c7 c6 e0 6b 79 85 48 89 df e8 fe b8 e5 ff c6 05 03 2d 98 05 01 <0f> 0b 41 bd f
[   30.083879] RSP: 0018:ffff8880135b7af8 EFLAGS: 00010246
[   30.084189] RAX: 0000000000000000 RBX: ffffea0000638000 RCX: ffffffff813dde2e
[   30.084765] RDX: 0000000000000000 RSI: ffff88800f758000 RDI: 0000000000000002
[   30.085359] RBP: ffff8880135b7c78 R08: ffffed100d9a62b2 R09: ffffed100d9a62b2
[   30.085825] R10: ffff88806cd3158b R11: ffffed100d9a62b1 R12: 0000000000000000
[   30.086227] R13: 0000000000000001 R14: 0000000000000000 R15: ffff8880135b7c50
[   30.086628] FS:  00007efdb7675740(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
[   30.087083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.087445] CR2: 00007efdb779a580 CR3: 0000000016be0005 CR4: 0000000000770ee0
[   30.087916] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   30.088334] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   30.088738] PKRU: 55555554
[   30.088902] Call Trace:
[   30.089055]  <TASK>
[   30.089190]  ? rcu_read_lock_sched_held+0xa9/0xd0
[   30.089487]  ? __pfx_rcu_read_lock_sched_held+0x10/0x10
[   30.089812]  ? rcu_read_lock_sched_held+0xa9/0xd0
[   30.090237]  ? __this_cpu_preempt_check+0x20/0x30
[   30.090545]  ? __pfx_split_huge_page_to_list+0x10/0x10
[   30.090848]  ? __this_cpu_preempt_check+0x20/0x30
[   30.091148]  ? lock_is_held_type+0xe6/0x140
[   30.091618]  ? mark_held_locks+0xb7/0x140
[   30.091882]  ? write_comp_data+0x2f/0x90
[   30.092135]  try_to_split_thp_page+0xbc/0x450
[   30.092425]  memory_failure+0xcfc/0x2ac0
[   30.092675]  ? __pfx_memory_failure+0x10/0x10
[   30.092943]  ? _printk+0xc/0xdc
[   30.093156]  ? __pfx__printk+0x10/0x10
[   30.093384]  ? write_comp_data+0x2f/0x90
[   30.093633]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   30.093922]  ? write_comp_data+0x2f/0x90
[   30.094172]  do_madvise.cold.55+0x187/0x1a5
[   30.094435]  ? lockdep_hardirqs_on+0x8a/0x110
[   30.094706]  ? __pfx_do_madvise+0x10/0x10
[   30.094960]  ? write_comp_data+0x2f/0x90
[   30.095207]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   30.095496]  ? __audit_syscall_entry+0x3e4/0x550
[   30.095786]  __x64_sys_madvise+0xb3/0x120
[   30.096032]  ? syscall_enter_from_user_mode+0x51/0x60
[   30.096357]  do_syscall_64+0x3b/0x90
[   30.096585]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   30.096895] RIP: 0033:0x7efdb779a59d
[   30.097174] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
[   30.098195] RSP: 002b:00007ffdbd086878 EFLAGS: 00000217 ORIG_RAX: 000000000000001c
[   30.098623] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efdb779a59d
[   30.099027] RDX: 0000000000000064 RSI: 0000000000003000 RDI: 0000000020cef000
[   30.099429] RBP: 00007ffdbd086880 R08: 00007ffdbd0868b0 R09: 00007ffdbd0868b0
[   30.099831] R10: 0000000000000004 R11: 0000000000000217 R12: 0000000000401180
[   30.100232] R13: 00007ffdbd0869a0 R14: 0000000000000000 R15: 0000000000000000
[   30.100672]  </TASK>
[   30.100814] irq event stamp: 1591
[   30.101014] hardirqs last  enabled at (1599): [<ffffffff813dd0a1>] __up_console_sem+0x91/0xb0
[   30.101507] hardirqs last disabled at (1606): [<ffffffff813dd086>] __up_console_sem+0x76/0xb0
[   30.101994] softirqs last  enabled at (1104): [<ffffffff8536af3f>] __do_softirq+0x53f/0x836
[   30.102472] softirqs last disabled at (1017): [<ffffffff812498b0>] irq_exit_rcu+0x100/0x140
[   30.102956] ---[ end trace 0000000000000000 ]---
[   30.103229] Memory failure: 0x18eef: recovery action for unsplit thp: Ignored

Bisect and found the first bad commit is:
4966455d9100236fd6dd72b0cd00818435fdb25d
mm: hwpoison: handle non-anonymous THP correctly

Made the "revert above commit on top of v6.2-rc7 kernel" failed, so it's
just a clue for above issue.

Checked https://syzkaller.appspot.com/bug?id=904dd6aad6dd746b275792875fc52385eac81f04
didn't give the above commit info due to timeout.

Reproduced code from syzkaller, kconfig, bisect info, v6.2-rc7 reproduced
dmesg are in attached.

v6.2-rc7 bzImage and bisect detailed info is in link:
https://github.com/xupengfe/syzkaller_logs/tree/main/230206_205324_split_huge_page_to_list


How to reproduce this issue:
If you need the reproduced virtual machine environment:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
   // You could change the bzImage_xxx as you want
In vm and login with root,  there is no password for root.

After login vm successfully, you could transfer reproduced binary to the VM
by below way, and reproduce the problem:
scp -P 10023 reproduced_binary root@localhost:/root/


Get the bzImage:
target kernel:
Please use the provided kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel vm.

Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version,
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
make
make install

I hope it's helpful.

Thanks!
BR.

--b3rEXDtV+UP6p3C9
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="repro.c"

// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static void sleep_ms(uint64_t ms)
{
  usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts))
    exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

#define BITMASK(bf_off, bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type, htobe, addr, val, bf_off, bf_len)               \
  *(type*)(addr) =                                                             \
      htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) |           \
            (((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))

static bool write_file(const char* file, const char* what, ...)
{
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] = 0;
  int len = strlen(buf);
  int fd = open(file, O_WRONLY | O_CLOEXEC);
  if (fd == -1)
    return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
    return false;
  }
  close(fd);
  return true;
}

static int inject_fault(int nth)
{
  int fd;
  fd = open("/proc/thread-self/fail-nth", O_RDWR);
  if (fd == -1)
    exit(1);
  char buf[16];
  sprintf(buf, "%d", nth);
  if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
    exit(1);
  return fd;
}

static void kill_and_wait(int pid, int* status)
{
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i = 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) == pid)
      return;
    usleep(1000);
  }
  DIR* dir = opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent = readdir(dir);
      if (!ent)
        break;
      if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd = open(abort, O_WRONLY);
      if (fd == -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) != pid) {
  }
}

static void setup_test()
{
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
}

static void setup_fault()
{
  static struct {
    const char* file;
    const char* val;
    bool fatal;
  } files[] = {
      {"/sys/kernel/debug/failslab/ignore-gfp-wait", "N", true},
      {"/sys/kernel/debug/fail_futex/ignore-private", "N", false},
      {"/sys/kernel/debug/fail_page_alloc/ignore-gfp-highmem", "N", false},
      {"/sys/kernel/debug/fail_page_alloc/ignore-gfp-wait", "N", false},
      {"/sys/kernel/debug/fail_page_alloc/min-order", "0", false},
  };
  unsigned i;
  for (i = 0; i < sizeof(files) / sizeof(files[0]); i++) {
    if (!write_file(files[i].file, files[i].val)) {
      if (files[i].fatal)
        exit(1);
    }
  }
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
  int iter = 0;
  for (;; iter++) {
    int pid = fork();
    if (pid < 0)
      exit(1);
    if (pid == 0) {
      setup_test();
      execute_one();
      exit(0);
    }
    int status = 0;
    uint64_t start = current_time_ms();
    for (;;) {
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
        break;
      sleep_ms(1);
      if (current_time_ms() - start < 5000)
        continue;
      kill_and_wait(pid, &status);
      break;
    }
  }
}

uint64_t r[1] = {0xffffffffffffffff};

void execute_one(void)
{
  intptr_t res = 0;
  *(uint32_t*)0x20000100 = 6;
  *(uint32_t*)0x20000104 = 0x80;
  *(uint8_t*)0x20000108 = 0;
  *(uint8_t*)0x20000109 = 0;
  *(uint8_t*)0x2000010a = 0;
  *(uint8_t*)0x2000010b = 0;
  *(uint32_t*)0x2000010c = 0;
  *(uint64_t*)0x20000110 = 0;
  *(uint64_t*)0x20000118 = 0;
  *(uint64_t*)0x20000120 = 0;
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 0, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 1, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 2, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 3, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 4, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 5, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 6, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 7, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 8, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 9, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 10, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 11, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 12, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 13, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 14, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 15, 2);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 17, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 18, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 19, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 20, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 21, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 22, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 23, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 24, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 25, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 26, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 27, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 28, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 29, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 30, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 31, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 32, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 33, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 34, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 35, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 36, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 37, 1);
  STORE_BY_BITMASK(uint64_t, , 0x20000128, 0, 38, 26);
  *(uint32_t*)0x20000130 = 0;
  *(uint32_t*)0x20000134 = 0;
  *(uint64_t*)0x20000138 = 0;
  *(uint64_t*)0x20000140 = 0xffffffff81003694;
  *(uint64_t*)0x20000148 = 0;
  *(uint64_t*)0x20000150 = 0;
  *(uint32_t*)0x20000158 = 0;
  *(uint32_t*)0x2000015c = 0;
  *(uint64_t*)0x20000160 = 0;
  *(uint32_t*)0x20000168 = 0;
  *(uint16_t*)0x2000016c = 0;
  *(uint16_t*)0x2000016e = 0;
  *(uint32_t*)0x20000170 = 0;
  *(uint32_t*)0x20000174 = 0;
  *(uint64_t*)0x20000178 = 0;
  res = syscall(__NR_perf_event_open, 0x20000100ul, 0, 0ul, -1, 0ul);
  if (res != -1)
    r[0] = res;
  inject_fault(1);
  syscall(__NR_close, r[0]);
}
int main(void)
{
  syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  setup_fault();
  loop();
  return 0;
}

--b3rEXDtV+UP6p3C9
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="bisect_info.log"

git bisect start
# status: waiting for both good and bad commits
# bad: [4ec5183ec48656cec489c49f989c508b68b518e3] Linux 6.2-rc7
git bisect bad 4ec5183ec48656cec489c49f989c508b68b518e3
# status: waiting for good commit(s), bad commit known
# good: [f40ddce88593482919761f74910f42f4b84c004b] Linux 5.11
git bisect good f40ddce88593482919761f74910f42f4b84c004b
# bad: [3bad80dab94a16c9b7991105e3bffd5fe5957e9a] Merge tag 'char-misc-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect bad 3bad80dab94a16c9b7991105e3bffd5fe5957e9a
# good: [c932ed0adb09a7fa6d6649ee04dd78c83ab07ada] Merge tag 'tty-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good c932ed0adb09a7fa6d6649ee04dd78c83ab07ada
# good: [fc02cb2b37fe2cbf1d3334b9f0f0eab9431766c4] Merge tag 'net-next-for-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect good fc02cb2b37fe2cbf1d3334b9f0f0eab9431766c4
# bad: [0109841fc4565bb3cefcdfb2991da0c47cd94b23] Merge tag 'mlx5-updates-2021-12-02' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
git bisect bad 0109841fc4565bb3cefcdfb2991da0c47cd94b23
# good: [5c904c66ed4e86c31ac7c033b64274cebed04e0e] Merge tag 'char-misc-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good 5c904c66ed4e86c31ac7c033b64274cebed04e0e
# bad: [e5bc4d4602b8e0e63c9d00d210120d6bcfaea590] Merge branch 'kvm-selftest' into kvm-master
git bisect bad e5bc4d4602b8e0e63c9d00d210120d6bcfaea590
# bad: [0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4] Merge tag 'pci-v5.16-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect bad 0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4
# good: [5af06603c4090617be216a9185193a7be3ca60af] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
git bisect good 5af06603c4090617be216a9185193a7be3ca60af
# good: [fe91c4725aeed35023ba4f7a1e1adfebb6878c23] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good fe91c4725aeed35023ba4f7a1e1adfebb6878c23
# bad: [f9803a9918468d70d98d31c23cb7613d873e723f] MAINTAINERS: update SeongJae's email address
git bisect bad f9803a9918468d70d98d31c23cb7613d873e723f
# good: [61bb6cd2f765b90cfc5f0f91696889c366a6a13d] mm: move node_reclaim_distance to fix NUMA without SMP
git bisect good 61bb6cd2f765b90cfc5f0f91696889c366a6a13d
# bad: [c486514dd40980b2dbb0e15fabddfe1324ed0197] xen/x86: free_p2m_page: use memblock_free_ptr() to free a virtual pointer
git bisect bad c486514dd40980b2dbb0e15fabddfe1324ed0197
# bad: [38e719ab26735aa2c5d9d422fc4b741cbd36e700] hugetlb: support node specified when using cma for gigantic hugepages
git bisect bad 38e719ab26735aa2c5d9d422fc4b741cbd36e700
# good: [e0f43fa50605f89d45708bce3b94e408ef5c4342] mm: filemap: coding style cleanup for filemap_map_pmd()
git bisect good e0f43fa50605f89d45708bce3b94e408ef5c4342
# bad: [9871e2ded6c1ff61a59988d7a0e975f012105d52] mm/cma: add cma_pages_valid to determine if pages are in CMA
git bisect bad 9871e2ded6c1ff61a59988d7a0e975f012105d52
# bad: [4966455d9100236fd6dd72b0cd00818435fdb25d] mm: hwpoison: handle non-anonymous THP correctly
git bisect bad 4966455d9100236fd6dd72b0cd00818435fdb25d
# good: [b9d02f1bdd98f38e6e5ecacc9786a8f58f3f8b2c] mm: shmem: don't truncate page if memory failure happens
git bisect good b9d02f1bdd98f38e6e5ecacc9786a8f58f3f8b2c
# first bad commit: [4966455d9100236fd6dd72b0cd00818435fdb25d] mm: hwpoison: handle non-anonymous THP correctly
|0207_073843|/root/bzimage_bisect/make_bz.sh -k /root/linux -m 4ec5183ec48656cec489c49f989c508b68b518e3 -b 4966455d9100236fd6dd72b0cd00818435fdb25d -d /home/bzim|
|0207_073921|FAIL|bzImage:/home/bzimage/bzImage_4ec5183ec48656cec489c49f989c508b68b518e3_4966455d9100236fd6dd72b0cd00818435fdb25d_revert does not exist:|

--b3rEXDtV+UP6p3C9
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kconfig"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 6.2.0-rc7 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-17)"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=80500
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23601
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23601
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=122
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
CONFIG_LOCALVERSION="-kvm"
# CONFIG_LOCALVERSION_AUTO is not set
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
CONFIG_DEFAULT_HOSTNAME="CannotLeaveINTEL"
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
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
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
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=18
CONFIG_LOG_CPU_MAX_BUF_SHIFT=14
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
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
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
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
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
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
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
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
CONFIG_X86_NUMACHIP=y
# CONFIG_X86_VSMP is not set
# CONFIG_X86_UV is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_512GB=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_PV_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
CONFIG_XEN_PVH=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PV_MSR_SAFE=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
CONFIG_ACRN_GUEST=y
# CONFIG_INTEL_TDX_GUEST is not set
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
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_PERF_EVENTS_AMD_UNCORE=y
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
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
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="net.ifnames=0"
# CONFIG_CMDLINE_OVERRIDE is not set
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
CONFIG_CPU_UNRET_ENTRY=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBPB_ENTRY=y
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
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_PM_GENERIC_DOMAINS_OF=y
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
CONFIG_DPTF_PCH_FIVR=y
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
CONFIG_ACPI_CONFIGFS=y
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
CONFIG_PMIC_OPREGION=y
# CONFIG_BYTCRC_PMIC_OPREGION is not set
# CONFIG_CHTCRC_PMIC_OPREGION is not set
# CONFIG_XPOWER_PMIC_OPREGION is not set
CONFIG_BXT_WC_PMIC_OPREGION=y
# CONFIG_CHT_DC_TI_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
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

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
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
CONFIG_KVM_WERROR=y
CONFIG_KVM_INTEL=m
CONFIG_X86_SGX_KVM=y
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_KVM_EXTERNAL_WRITE_TRACKING=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_IMA_KEXEC=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
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
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
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
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_FC_APPID is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
# CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

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
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set

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
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
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
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
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
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=m
CONFIG_XFRM_USER=m
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_SMC=m
CONFIG_SMC_DIAG=m
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
# CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
CONFIG_TCP_CONG_CDG=m
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_IPV6_ILA=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
# CONFIG_NF_CONNTRACK_PROCFS is not set
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
CONFIG_NFT_TUNNEL=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
CONFIG_NFT_XFRM=m
CONFIG_NFT_SOCKET=m
CONFIG_NFT_OSF=m
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
CONFIG_NFT_REJECT_NETDEV=m
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
# CONFIG_NF_FLOW_TABLE_PROCFS is not set
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_SRH=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
CONFIG_NFT_BRIDGE_META=m
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
# CONFIG_IP_DCCP_CCID3 is not set
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
CONFIG_RDS=m
CONFIG_RDS_RDMA=m
CONFIG_RDS_TCP=m
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_IB=y
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_NET_DSA=m
CONFIG_NET_DSA_TAG_NONE=m
# CONFIG_NET_DSA_TAG_AR9331 is not set
CONFIG_NET_DSA_TAG_BRCM_COMMON=m
CONFIG_NET_DSA_TAG_BRCM=m
CONFIG_NET_DSA_TAG_BRCM_LEGACY=m
CONFIG_NET_DSA_TAG_BRCM_PREPEND=m
# CONFIG_NET_DSA_TAG_HELLCREEK is not set
# CONFIG_NET_DSA_TAG_GSWIP is not set
CONFIG_NET_DSA_TAG_DSA_COMMON=m
CONFIG_NET_DSA_TAG_DSA=m
CONFIG_NET_DSA_TAG_EDSA=m
CONFIG_NET_DSA_TAG_MTK=m
# CONFIG_NET_DSA_TAG_KSZ is not set
# CONFIG_NET_DSA_TAG_OCELOT is not set
# CONFIG_NET_DSA_TAG_OCELOT_8021Q is not set
CONFIG_NET_DSA_TAG_QCA=m
# CONFIG_NET_DSA_TAG_RTL4_A is not set
# CONFIG_NET_DSA_TAG_RTL8_4 is not set
# CONFIG_NET_DSA_TAG_RZN1_A5PSW is not set
CONFIG_NET_DSA_TAG_LAN9303=m
# CONFIG_NET_DSA_TAG_SJA1105 is not set
CONFIG_NET_DSA_TAG_TRAILER=m
# CONFIG_NET_DSA_TAG_XRS700X is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
CONFIG_LLC2=m
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=m
# CONFIG_IPDDP is not set
CONFIG_X25=m
CONFIG_LAPB=m
CONFIG_PHONET=m
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=m
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=m
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
CONFIG_NET_NCSI=y
# CONFIG_NCSI_OEM_CMD_GET_MAC is not set
# CONFIG_NCSI_OEM_CMD_KEEP_PHY is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
CONFIG_6PACK=m
CONFIG_BPQETHER=m
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_YAM=m
# end of AX.25 network device drivers

CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
CONFIG_BT_LE_L2CAP_ECRED=y
CONFIG_BT_6LOWPAN=m
CONFIG_BT_LEDS=y
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_QCA=m
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
CONFIG_BT_HCIBTUSB_POLL_SYNC=y
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=m
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIUART_3WIRE=y
CONFIG_BT_HCIUART_INTEL=y
CONFIG_BT_HCIUART_BCM=y
# CONFIG_BT_HCIUART_RTL is not set
CONFIG_BT_HCIUART_QCA=y
CONFIG_BT_HCIUART_AG6XX=y
CONFIG_BT_HCIUART_MRVL=y
CONFIG_BT_HCIBCM203X=m
# CONFIG_BT_HCIBCM4377 is not set
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_MTKUART is not set
CONFIG_BT_HCIRSI=m
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=m
CONFIG_AF_RXRPC_IPV6=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
# CONFIG_RXPERF is not set
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_SPY=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
CONFIG_CFG80211_DEBUGFS=y
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_CFG80211_WEXT_EXPORT=y
CONFIG_LIB80211=m
CONFIG_LIB80211_CRYPT_WEP=m
CONFIG_LIB80211_CRYPT_CCMP=m
CONFIG_LIB80211_CRYPT_TKIP=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
CONFIG_MAC80211_MESSAGE_TRACING=y
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_XEN=m
CONFIG_NET_9P_RDMA=m
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=m
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=m
CONFIG_CAIF_USB=m
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_SPI=m
CONFIG_NFC_NCI_UART=m
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_TRF7970A=m
CONFIG_NFC_MEI_PHY=m
CONFIG_NFC_SIM=m
CONFIG_NFC_PORT100=m
# CONFIG_NFC_VIRTUAL_NCI is not set
CONFIG_NFC_FDP=m
CONFIG_NFC_FDP_I2C=m
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_I2C=m
CONFIG_NFC_PN544_MEI=m
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_USB=m
CONFIG_NFC_PN533_I2C=m
# CONFIG_NFC_PN532_UART is not set
CONFIG_NFC_MICROREAD=m
CONFIG_NFC_MICROREAD_I2C=m
CONFIG_NFC_MICROREAD_MEI=m
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_USB=m
CONFIG_NFC_MRVL_UART=m
CONFIG_NFC_MRVL_I2C=m
CONFIG_NFC_MRVL_SPI=m
CONFIG_NFC_ST21NFCA=m
CONFIG_NFC_ST21NFCA_I2C=m
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
CONFIG_NFC_ST_NCI_SPI=m
CONFIG_NFC_NXP_NCI=m
CONFIG_NFC_NXP_NCI_I2C=m
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
# CONFIG_NFC_S3FWRN82_UART is not set
CONFIG_NFC_ST95HF=m
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=y
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
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
CONFIG_PCIE_EDR=y
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
# CONFIG_PCI_PF_STUB is not set
CONFIG_XEN_PCIDEV_FRONTEND=m
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m
# CONFIG_PCIE_MICROCHIP_HOST is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
# CONFIG_PCIE_DW_PLAT_EP is not set
# CONFIG_PCIE_INTEL_GW is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
# CONFIG_PCI_J721E_HOST is not set
# CONFIG_PCI_J721E_EP is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
# CONFIG_PCI_EPF_TEST is not set
# CONFIG_PCI_EPF_NTB is not set
# CONFIG_PCI_EPF_VNTB is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
CONFIG_CXL_PCI=m
CONFIG_CXL_MEM_RAW_COMMANDS=y
CONFIG_CXL_ACPI=m
CONFIG_CXL_PMEM=m
CONFIG_CXL_MEM=m
CONFIG_CXL_PORT=m
CONFIG_CXL_SUSPEND=y
CONFIG_CXL_REGION=y
# CONFIG_CXL_REGION_INVALIDATION_TEST is not set
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=m
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=m
CONFIG_RAPIDIO_CPS_GEN2=m
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
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=m
CONFIG_REGMAP_SOUNDWIRE_MBQ=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MOXTET is not set
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

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
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_TEST=m
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_APPLE_PROPERTIES=y
CONFIG_RESET_ATTACK_MITIGATION=y
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
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
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=m
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_OF_PARTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=m
CONFIG_RFD_FTL=m
CONFIG_SSFDC=m
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=m
CONFIG_MTD_SWAP=m
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
CONFIG_MTD_SBC_GXX=m
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
CONFIG_MTD_ESB2ROM=m
CONFIG_MTD_CK804XROM=m
CONFIG_MTD_SCB2_FLASH=m
CONFIG_MTD_NETtel=m
CONFIG_MTD_L440GX=m
CONFIG_MTD_PCI=m
CONFIG_MTD_PCMCIA=m
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
CONFIG_MTD_INTEL_VR_NOR=m
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_DATAFLASH=m
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
CONFIG_MTD_DATAFLASH_OTP=y
CONFIG_MTD_MCHP23K256=m
# CONFIG_MTD_MCHP48L640 is not set
CONFIG_MTD_SST25L=m
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=m

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
CONFIG_MTD_NAND_CORE=m
CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=m
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_RAW_NAND=m

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_GPIO=m
# CONFIG_MTD_NAND_PLATFORM is not set
# CONFIG_MTD_NAND_CADENCE is not set
# CONFIG_MTD_NAND_ARASAN is not set
# CONFIG_MTD_NAND_INTEL_LGM is not set

#
# Misc
#
# CONFIG_MTD_NAND_NANDSIM is not set
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
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
# CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
# CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=m
CONFIG_MTD_UBI_BLOCK=y
# CONFIG_MTD_HYPERBUS is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_FD_RAWCMD is not set
CONFIG_CDROM=m
CONFIG_PARIDE=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPATC8=y
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_ZSTD is not set
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZO is not set
# CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
# CONFIG_ZRAM_DEF_COMP_842 is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_ZRAM_MULTI_COMP is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_DRBD=m
# CONFIG_DRBD_FAULT_INJECTION is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=y
CONFIG_XEN_BLKDEV_BACKEND=m
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=y
CONFIG_NVME_TCP=y
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_FC=y
CONFIG_NVME_TARGET_FCLOOP=y
CONFIG_NVME_TARGET_TCP=y
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=m
CONFIG_DUMMY_IRQ=m
CONFIG_IBM_ASM=m
CONFIG_PHANTOM=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HI6421V600_IRQ is not set
CONFIG_HP_ILO=m
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=m
CONFIG_VMWARE_BALLOON=m
CONFIG_LATTICE_ECP3_CONFIG=m
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_HISI_HIKEY_USB is not set
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_AT25=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_93XX46=m
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=m
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=m
# CONFIG_INTEL_MEI_GSC is not set
CONFIG_INTEL_MEI_HDCP=m
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
CONFIG_GENWQE=m
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=m
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
CONFIG_MISC_RTSX_USB=m
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
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
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
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
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=m
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
# CONFIG_SCSI_MVSAS_TASKLET is not set
CONFIG_SCSI_MVUMI=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_ARCMSR=m
CONFIG_SCSI_ESAS2R=m
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_MPI3MR is not set
CONFIG_SCSI_SMARTPQI=m
CONFIG_SCSI_HPTIOP=m
CONFIG_SCSI_BUSLOGIC=m
CONFIG_SCSI_FLASHPOINT=y
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
CONFIG_XEN_SCSI_FRONTEND=m
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
CONFIG_SCSI_SNIC=m
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
CONFIG_SCSI_DMX3191D=m
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_STEX=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
CONFIG_QEDI=m
CONFIG_QEDF=m
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
# CONFIG_SCSI_EFCT is not set
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_WD719X=m
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
CONFIG_SCSI_BFA_FC=m
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
# CONFIG_PCMCIA_FDOMAIN is not set
CONFIG_PCMCIA_QLOGIC=m
CONFIG_PCMCIA_SYM53C500=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
CONFIG_SCSI_DH_HP_SW=m
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=m
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=3
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_DWC is not set
# CONFIG_AHCI_CEVA is not set
# CONFIG_AHCI_QORIQ is not set
CONFIG_SATA_INIC162X=m
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
CONFIG_SATA_DWC=m
CONFIG_SATA_DWC_OLD_DMA=y
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
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
CONFIG_PATA_CYPRESS=m
CONFIG_PATA_EFAR=m
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
CONFIG_PATA_NS87415=m
CONFIG_PATA_OLDPIIX=m
CONFIG_PATA_OPTIDMA=m
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
CONFIG_PATA_RADISYS=m
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=y
CONFIG_PATA_TOSHIBA=m
CONFIG_PATA_TRIFLEX=m
CONFIG_PATA_VIA=m
CONFIG_PATA_WINBOND=m

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=m
CONFIG_PATA_MPIIX=m
CONFIG_PATA_NS87410=m
CONFIG_PATA_OPTI=m
CONFIG_PATA_PCMCIA=m
# CONFIG_PATA_OF_PLATFORM is not set
CONFIG_PATA_RZ1000=m

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=y
CONFIG_PATA_LEGACY=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
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
# CONFIG_DM_INIT is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_ZONED=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
CONFIG_SBP_TARGET=m
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
CONFIG_FUSION_FC=m
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LAN=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=m
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
CONFIG_EQUALIZER=m
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
CONFIG_IPVLAN_L3S=y
CONFIG_IPVLAN=m
CONFIG_IPVTAP=m
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_BAREUDP is not set
CONFIG_GTP=m
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_RIONET=m
CONFIG_RIONET_TX_SIZE=128
CONFIG_RIONET_RX_SIZE=128
CONFIG_TUN=y
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_NET_VRF=m
CONFIG_VSOCKMON=m
CONFIG_SUNGEM_PHY=m
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_PCI=m
CONFIG_ARCNET_COM20020_CS=m
CONFIG_ATM_DRIVERS=y
CONFIG_ATM_DUMMY=m
CONFIG_ATM_TCP=m
CONFIG_ATM_LANAI=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_NICSTAR=m
# CONFIG_ATM_NICSTAR_USE_SUNI is not set
# CONFIG_ATM_NICSTAR_USE_IDT77105 is not set
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_IA=m
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E=m
# CONFIG_ATM_FORE200E_USE_TASKLET is not set
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_HE=m
CONFIG_ATM_HE_USE_SUNI=y
CONFIG_ATM_SOLOS=m
# CONFIG_CAIF_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=m
CONFIG_B53_SPI_DRIVER=m
CONFIG_B53_MDIO_DRIVER=m
CONFIG_B53_MMAP_DRIVER=m
CONFIG_B53_SRAB_DRIVER=m
# CONFIG_B53_SERDES is not set
# CONFIG_NET_DSA_BCM_SF2 is not set
# CONFIG_NET_DSA_LOOP is not set
# CONFIG_NET_DSA_LANTIQ_GSWIP is not set
CONFIG_NET_DSA_MT7530=m
CONFIG_NET_DSA_MV88E6060=m
# CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON is not set
CONFIG_NET_DSA_MV88E6XXX=m
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
# CONFIG_NET_DSA_MSCC_SEVILLE is not set
# CONFIG_NET_DSA_AR9331 is not set
CONFIG_NET_DSA_QCA8K=m
# CONFIG_NET_DSA_SJA1105 is not set
# CONFIG_NET_DSA_XRS700X_I2C is not set
# CONFIG_NET_DSA_XRS700X_MDIO is not set
# CONFIG_NET_DSA_REALTEK is not set
CONFIG_NET_DSA_SMSC_LAN9303=m
CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
# CONFIG_NET_DSA_VITESSE_VSC73XX_SPI is not set
# CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM is not set
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_3C589=m
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=m
CONFIG_NET_VENDOR_ALACRITECH=y
CONFIG_SLICOSS=m
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_ALTERA_TSE=m
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_AMD_XGBE=m
CONFIG_AMD_XGBE_DCB=y
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_CX_ECAT=m
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=m
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
CONFIG_MACB_PCI=m
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_THUNDER_NIC_PF=m
CONFIG_THUNDER_NIC_VF=m
CONFIG_THUNDER_NIC_BGX=m
CONFIG_THUNDER_NIC_RGX=m
CONFIG_CAVIUM_PTP=m
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=m
CONFIG_CHELSIO_T1_1G=y
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
CONFIG_CHELSIO_T4_DCB=y
CONFIG_CHELSIO_T4_FCOE=y
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_CHELSIO_IPSEC_INLINE=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=m
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_HINIC=m
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCA=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBE_IPSEC=y
CONFIG_IXGBEVF=m
CONFIG_IXGBEVF_IPSEC=y
CONFIG_I40E=m
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
CONFIG_ICE=m
CONFIG_ICE_SWITCHDEV=y
CONFIG_ICE_HWTS=y
CONFIG_FM10K=m
CONFIG_IGC=m
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
CONFIG_MLX5_CORE=m
CONFIG_MLX5_FPGA=y
CONFIG_MLX5_CORE_EN=y
CONFIG_MLX5_EN_ARFS=y
CONFIG_MLX5_EN_RXNFC=y
CONFIG_MLX5_MPFS=y
CONFIG_MLX5_ESWITCH=y
CONFIG_MLX5_BRIDGE=y
CONFIG_MLX5_CLS_ACT=y
CONFIG_MLX5_TC_SAMPLE=y
CONFIG_MLX5_CORE_EN_DCB=y
CONFIG_MLX5_CORE_IPOIB=y
# CONFIG_MLX5_EN_MACSEC is not set
# CONFIG_MLX5_EN_IPSEC is not set
CONFIG_MLX5_SW_STEERING=y
# CONFIG_MLX5_SF is not set
CONFIG_MLXSW_CORE=m
CONFIG_MLXSW_CORE_HWMON=y
CONFIG_MLXSW_CORE_THERMAL=y
CONFIG_MLXSW_PCI=m
CONFIG_MLXSW_I2C=m
CONFIG_MLXSW_SPECTRUM=m
CONFIG_MLXSW_SPECTRUM_DCB=y
CONFIG_MLXSW_MINIMAL=m
CONFIG_MLXFW=m
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8842=m
CONFIG_KS8851=m
CONFIG_KS8851_MLL=m
CONFIG_KSZ884X_PCI=m
CONFIG_NET_VENDOR_MICROCHIP=y
CONFIG_ENC28J60=m
# CONFIG_ENC28J60_WRITEVERIFY is not set
CONFIG_ENCX24J600=m
CONFIG_LAN743X=m
# CONFIG_LAN966X_SWITCH is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=m
CONFIG_NS83820=m
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=m
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
CONFIG_NFP_NET_IPSEC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_8390=y
CONFIG_PCMCIA_AXNET=m
CONFIG_NE2K_PCI=m
CONFIG_PCMCIA_PCNET=m
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=m
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_LL2=y
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_QED_RDMA=y
CONFIG_QED_ISCSI=y
CONFIG_QED_FCOE=y
CONFIG_QED_OOO=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
CONFIG_QCOM_EMAC=m
CONFIG_RMNET=m
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=m
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_ATP=m
CONFIG_8139CP=m
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=m
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=m
CONFIG_NET_VENDOR_SIS=y
CONFIG_SIS900=m
CONFIG_SIS190=m
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_PCMCIA_SMC91C92=m
CONFIG_EPIC100=m
CONFIG_SMSC911X=m
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=m
# CONFIG_STMMAC_SELFTESTS is not set
CONFIG_STMMAC_PLATFORM=m
# CONFIG_DWMAC_DWC_QOS_ETH is not set
CONFIG_DWMAC_GENERIC=m
# CONFIG_DWMAC_INTEL_PLAT is not set
CONFIG_DWMAC_INTEL=m
# CONFIG_DWMAC_LOONGSON is not set
CONFIG_STMMAC_PCI=m
CONFIG_NET_VENDOR_SUN=y
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
CONFIG_CASSINI=m
CONFIG_NIU=m
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=m
CONFIG_DWC_XLGMAC_PCI=m
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=m
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
CONFIG_VIA_VELOCITY=m
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=m
CONFIG_WIZNET_W5300=m
# CONFIG_WIZNET_BUS_DIRECT is not set
# CONFIG_WIZNET_BUS_INDIRECT is not set
CONFIG_WIZNET_BUS_ANY=y
CONFIG_WIZNET_W5100_SPI=m
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=m
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
CONFIG_AQUANTIA_PHY=m
CONFIG_AX88796B_PHY=m
CONFIG_BROADCOM_PHY=m
# CONFIG_BCM54140_PHY is not set
CONFIG_BCM7XXX_PHY=m
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_CICADA_PHY=m
CONFIG_CORTINA_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_LXT_PHY=m
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=m
CONFIG_MARVELL_10G_PHY=m
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
CONFIG_MEDIATEK_GE_PHY=m
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_PHY=m
# CONFIG_MICROCHIP_T1_PHY is not set
CONFIG_MICROSEMI_PHY=m
# CONFIG_MOTORCOMM_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_AT803X_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=m
CONFIG_ROCKCHIP_PHY=m
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
CONFIG_TERANETICS_PHY=m
CONFIG_DP83822_PHY=m
# CONFIG_DP83TC811_PHY is not set
CONFIG_DP83848_PHY=m
CONFIG_DP83867_PHY=m
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
CONFIG_VITESSE_PHY=m
CONFIG_XILINX_GMII2RGMII=m
CONFIG_MICREL_KS8995MA=m
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_RX_OFFLOAD=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_FLEXCAN is not set
# CONFIG_CAN_GRCAN is not set
CONFIG_CAN_JANZ_ICAN3=m
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_CTUCANFD_PLATFORM is not set
CONFIG_CAN_IFI_CANFD=m
CONFIG_CAN_M_CAN=m
CONFIG_CAN_M_CAN_PCI=m
CONFIG_CAN_M_CAN_PLATFORM=m
# CONFIG_CAN_M_CAN_TCAN4X5X is not set
CONFIG_CAN_PEAK_PCIEFD=m
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_EMS_PCMCIA=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PEAK_PCMCIA=m
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_SJA1000_ISA=m
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m
CONFIG_CAN_SOFTING_CS=m

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=m
CONFIG_CAN_MCP251X=m
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
CONFIG_CAN_GS_USB=m
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_MCBA_USB=m
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_OF_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_CAVIUM=m
CONFIG_MDIO_GPIO=m
# CONFIG_MDIO_HISI_FEMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_OCTEON is not set
# CONFIG_MDIO_IPQ4019 is not set
# CONFIG_MDIO_IPQ8064 is not set
CONFIG_MDIO_THUNDER=m

#
# MDIO Multiplexers
#
# CONFIG_MDIO_BUS_MUX_GPIO is not set
# CONFIG_MDIO_BUS_MUX_MULTIPLEXER is not set
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set

#
# PCS device drivers
#
CONFIG_PCS_XPCS=m
CONFIG_PCS_ALTERA_TSE=m
# end of PCS device drivers

CONFIG_PLIP=m
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=y
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_RTL8152=m
CONFIG_USB_LAN78XX=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_CDC_EEM=m
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=m
CONFIG_USB_NET_SR9700=m
CONFIG_USB_NET_SR9800=m
CONFIG_USB_NET_SMSC75XX=m
CONFIG_USB_NET_SMSC95XX=m
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_PLUSB=m
CONFIG_USB_NET_MCS7830=m
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=m
CONFIG_USB_CDC_PHONET=m
CONFIG_USB_IPHETH=m
CONFIG_USB_SIERRA_NET=m
CONFIG_USB_VL600=m
CONFIG_USB_NET_CH9200=m
# CONFIG_USB_NET_AQC111 is not set
CONFIG_USB_RTL8153_ECM=m
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_ADM8211=m
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
CONFIG_ATH5K=m
# CONFIG_ATH5K_DEBUG is not set
# CONFIG_ATH5K_TRACER is not set
CONFIG_ATH5K_PCI=y
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_COMMON_DEBUG=y
CONFIG_ATH9K_BTCOEX_SUPPORT=y
CONFIG_ATH9K=m
CONFIG_ATH9K_PCI=y
CONFIG_ATH9K_AHB=y
CONFIG_ATH9K_DEBUGFS=y
CONFIG_ATH9K_STATION_STATISTICS=y
# CONFIG_ATH9K_DYNACK is not set
CONFIG_ATH9K_WOW=y
CONFIG_ATH9K_RFKILL=y
CONFIG_ATH9K_CHANNEL_CONTEXT=y
CONFIG_ATH9K_PCOEM=y
# CONFIG_ATH9K_PCI_NO_EEPROM is not set
CONFIG_ATH9K_HTC=m
CONFIG_ATH9K_HTC_DEBUGFS=y
CONFIG_ATH9K_HWRNG=y
CONFIG_ATH9K_COMMON_SPECTRAL=y
CONFIG_CARL9170=m
CONFIG_CARL9170_LEDS=y
# CONFIG_CARL9170_DEBUGFS is not set
CONFIG_CARL9170_WPC=y
CONFIG_CARL9170_HWRNG=y
CONFIG_ATH6KL=m
CONFIG_ATH6KL_SDIO=m
CONFIG_ATH6KL_USB=m
# CONFIG_ATH6KL_DEBUG is not set
# CONFIG_ATH6KL_TRACING is not set
CONFIG_AR5523=m
CONFIG_WIL6210=m
CONFIG_WIL6210_ISR_COR=y
CONFIG_WIL6210_TRACING=y
CONFIG_WIL6210_DEBUGFS=y
CONFIG_ATH10K=m
CONFIG_ATH10K_CE=y
CONFIG_ATH10K_PCI=m
# CONFIG_ATH10K_AHB is not set
CONFIG_ATH10K_SDIO=m
CONFIG_ATH10K_USB=m
# CONFIG_ATH10K_DEBUG is not set
CONFIG_ATH10K_DEBUGFS=y
CONFIG_ATH10K_SPECTRAL=y
CONFIG_ATH10K_TRACING=y
CONFIG_WCN36XX=m
# CONFIG_WCN36XX_DEBUGFS is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m
CONFIG_PCMCIA_ATMEL=m
CONFIG_AT76C50X_USB=m
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_B43=m
CONFIG_B43_BCMA=y
CONFIG_B43_SSB=y
CONFIG_B43_BUSES_BCMA_AND_SSB=y
# CONFIG_B43_BUSES_BCMA is not set
# CONFIG_B43_BUSES_SSB is not set
CONFIG_B43_PCI_AUTOSELECT=y
CONFIG_B43_PCICORE_AUTOSELECT=y
# CONFIG_B43_SDIO is not set
CONFIG_B43_BCMA_PIO=y
CONFIG_B43_PIO=y
CONFIG_B43_PHY_G=y
CONFIG_B43_PHY_N=y
CONFIG_B43_PHY_LP=y
CONFIG_B43_PHY_HT=y
CONFIG_B43_LEDS=y
CONFIG_B43_HWRNG=y
# CONFIG_B43_DEBUG is not set
CONFIG_B43LEGACY=m
CONFIG_B43LEGACY_PCI_AUTOSELECT=y
CONFIG_B43LEGACY_PCICORE_AUTOSELECT=y
CONFIG_B43LEGACY_LEDS=y
CONFIG_B43LEGACY_HWRNG=y
# CONFIG_B43LEGACY_DEBUG is not set
CONFIG_B43LEGACY_DMA=y
CONFIG_B43LEGACY_PIO=y
CONFIG_B43LEGACY_DMA_AND_PIO_MODE=y
# CONFIG_B43LEGACY_DMA_MODE is not set
# CONFIG_B43LEGACY_PIO_MODE is not set
CONFIG_BRCMUTIL=m
CONFIG_BRCMSMAC=m
CONFIG_BRCMSMAC_LEDS=y
CONFIG_BRCMFMAC=m
CONFIG_BRCMFMAC_PROTO_BCDC=y
CONFIG_BRCMFMAC_PROTO_MSGBUF=y
CONFIG_BRCMFMAC_SDIO=y
CONFIG_BRCMFMAC_USB=y
CONFIG_BRCMFMAC_PCIE=y
CONFIG_BRCM_TRACING=y
# CONFIG_BRCMDBG is not set
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_AIRO=m
CONFIG_AIRO_CS=m
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_IPW2100=m
CONFIG_IPW2100_MONITOR=y
# CONFIG_IPW2100_DEBUG is not set
CONFIG_IPW2200=m
CONFIG_IPW2200_MONITOR=y
CONFIG_IPW2200_RADIOTAP=y
CONFIG_IPW2200_PROMISCUOUS=y
CONFIG_IPW2200_QOS=y
# CONFIG_IPW2200_DEBUG is not set
CONFIG_LIBIPW=m
# CONFIG_LIBIPW_DEBUG is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
# CONFIG_IWLEGACY_DEBUG is not set
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y

#
# Debugging Options
#
CONFIG_IWLWIFI_DEBUG=y
CONFIG_IWLWIFI_DEBUGFS=y
CONFIG_IWLWIFI_DEVICE_TRACING=y
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
CONFIG_HOSTAP=m
CONFIG_HOSTAP_FIRMWARE=y
CONFIG_HOSTAP_FIRMWARE_NVRAM=y
CONFIG_HOSTAP_PLX=m
CONFIG_HOSTAP_PCI=m
CONFIG_HOSTAP_CS=m
CONFIG_HERMES=m
# CONFIG_HERMES_PRISM is not set
CONFIG_HERMES_CACHE_FW_ON_INIT=y
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_NORTEL_HERMES=m
CONFIG_PCMCIA_HERMES=m
CONFIG_PCMCIA_SPECTRUM=m
CONFIG_ORINOCO_USB=m
CONFIG_P54_COMMON=m
CONFIG_P54_USB=m
CONFIG_P54_PCI=m
CONFIG_P54_SPI=m
# CONFIG_P54_SPI_DEFAULT_EEPROM is not set
CONFIG_P54_LEDS=y
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_LIBERTAS=m
CONFIG_LIBERTAS_USB=m
CONFIG_LIBERTAS_CS=m
CONFIG_LIBERTAS_SDIO=m
CONFIG_LIBERTAS_SPI=m
# CONFIG_LIBERTAS_DEBUG is not set
CONFIG_LIBERTAS_MESH=y
CONFIG_LIBERTAS_THINFIRM=m
# CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
CONFIG_LIBERTAS_THINFIRM_USB=m
CONFIG_MWIFIEX=m
CONFIG_MWIFIEX_SDIO=m
CONFIG_MWIFIEX_PCIE=m
CONFIG_MWIFIEX_USB=m
CONFIG_MWL8K=m
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_MT7601U=m
CONFIG_MT76_CORE=m
CONFIG_MT76_LEDS=y
CONFIG_MT76x02_LIB=m
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
CONFIG_MT76x2_COMMON=m
CONFIG_MT76x2E=m
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
# CONFIG_MT7921S is not set
# CONFIG_MT7921U is not set
# CONFIG_MT7996E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WILC1000=m
CONFIG_WILC1000_SDIO=m
CONFIG_WILC1000_SPI=m
CONFIG_WILC1000_HW_OOB_INTR=y
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_RT2X00=m
CONFIG_RT2400PCI=m
CONFIG_RT2500PCI=m
CONFIG_RT61PCI=m
CONFIG_RT2800PCI=m
CONFIG_RT2800PCI_RT33XX=y
CONFIG_RT2800PCI_RT35XX=y
CONFIG_RT2800PCI_RT53XX=y
CONFIG_RT2800PCI_RT3290=y
CONFIG_RT2500USB=m
CONFIG_RT73USB=m
CONFIG_RT2800USB=m
CONFIG_RT2800USB_RT33XX=y
CONFIG_RT2800USB_RT35XX=y
CONFIG_RT2800USB_RT3573=y
CONFIG_RT2800USB_RT53XX=y
CONFIG_RT2800USB_RT55XX=y
CONFIG_RT2800USB_UNKNOWN=y
CONFIG_RT2800_LIB=m
CONFIG_RT2800_LIB_MMIO=m
CONFIG_RT2X00_LIB_MMIO=m
CONFIG_RT2X00_LIB_PCI=m
CONFIG_RT2X00_LIB_USB=m
CONFIG_RT2X00_LIB=m
CONFIG_RT2X00_LIB_FIRMWARE=y
CONFIG_RT2X00_LIB_CRYPTO=y
CONFIG_RT2X00_LIB_LEDS=y
# CONFIG_RT2X00_LIB_DEBUGFS is not set
# CONFIG_RT2X00_DEBUG is not set
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_RTL8180=m
CONFIG_RTL8187=m
CONFIG_RTL8187_LEDS=y
CONFIG_RTL_CARDS=m
CONFIG_RTL8192CE=m
CONFIG_RTL8192SE=m
CONFIG_RTL8192DE=m
CONFIG_RTL8723AE=m
CONFIG_RTL8723BE=m
CONFIG_RTL8188EE=m
CONFIG_RTL8192EE=m
CONFIG_RTL8821AE=m
CONFIG_RTL8192CU=m
CONFIG_RTLWIFI=m
CONFIG_RTLWIFI_PCI=m
CONFIG_RTLWIFI_USB=m
# CONFIG_RTLWIFI_DEBUG is not set
CONFIG_RTL8192C_COMMON=m
CONFIG_RTL8723_COMMON=m
CONFIG_RTLBTCOEXIST=m
CONFIG_RTL8XXXU=m
CONFIG_RTL8XXXU_UNTESTED=y
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_RSI_91X=m
# CONFIG_RSI_DEBUGFS is not set
CONFIG_RSI_SDIO=m
CONFIG_RSI_USB=m
CONFIG_RSI_COEX=y
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
CONFIG_CW1200=m
CONFIG_CW1200_WLAN_SDIO=m
CONFIG_CW1200_WLAN_SPI=m
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WL1251=m
CONFIG_WL1251_SPI=m
CONFIG_WL1251_SDIO=m
CONFIG_WL12XX=m
CONFIG_WL18XX=m
CONFIG_WLCORE=m
# CONFIG_WLCORE_SPI is not set
CONFIG_WLCORE_SDIO=m
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_USB_ZD1201=m
CONFIG_ZD1211RW=m
# CONFIG_ZD1211RW_DEBUG is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_PCMCIA_RAYCS=m
CONFIG_PCMCIA_WL3501=m
CONFIG_MAC80211_HWSIM=m
CONFIG_USB_NET_RNDIS_WLAN=m
# CONFIG_VIRT_WIFI is not set
CONFIG_WAN=y
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
CONFIG_HDLC_RAW_ETH=m
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m
CONFIG_HDLC_X25=m
CONFIG_PCI200SYN=m
CONFIG_WANXL=m
CONFIG_PC300TOO=m
CONFIG_FARSYNC=m
CONFIG_LAPBETHER=m
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
CONFIG_IEEE802154_AT86RF230=m
CONFIG_IEEE802154_MRF24J40=m
CONFIG_IEEE802154_CC2520=m
CONFIG_IEEE802154_ATUSB=m
CONFIG_IEEE802154_ADF7242=m
CONFIG_IEEE802154_CA8210=m
CONFIG_IEEE802154_CA8210_DEBUGFS=y
CONFIG_IEEE802154_MCR20A=m
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
CONFIG_WWAN=y
CONFIG_WWAN_DEBUGFS=y
# CONFIG_WWAN_HWSIM is not set
# CONFIG_RPMSG_WWAN_CTRL is not set
# CONFIG_IOSM is not set
CONFIG_MTK_T7XX=m
# end of Wireless WAN

CONFIG_XEN_NETDEV_FRONTEND=y
CONFIG_XEN_NETDEV_BACKEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_USB4_NET=y
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=m
CONFIG_KEYBOARD_ADP5520=m
CONFIG_KEYBOARD_ADP5588=m
CONFIG_KEYBOARD_ADP5589=m
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
CONFIG_KEYBOARD_QT1070=m
CONFIG_KEYBOARD_QT2160=m
CONFIG_KEYBOARD_DLINK_DIR685=m
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_GPIO=m
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=m
CONFIG_KEYBOARD_LM8323=m
CONFIG_KEYBOARD_LM8333=m
CONFIG_KEYBOARD_MAX7359=m
CONFIG_KEYBOARD_MCS=m
CONFIG_KEYBOARD_MPR121=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
# CONFIG_KEYBOARD_PINEPHONE is not set
CONFIG_KEYBOARD_SAMSUNG=m
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
# CONFIG_KEYBOARD_OMAP4 is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_TWL4030=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_CROS_EC=m
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
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
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
CONFIG_MOUSE_PS2_TOUCHKIT=y
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
# CONFIG_JOYSTICK_ADC is not set
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=m
CONFIG_JOYSTICK_IFORCE_232=m
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_JOYSTICK_XPAD=m
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_WALKERA0701=m
CONFIG_JOYSTICK_PSXPAD_SPI=m
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_QWIIC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
# CONFIG_JOYSTICK_SENSEHAT is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_HANWANG=m
CONFIG_TABLET_USB_KBTAB=m
CONFIG_TABLET_USB_PEGASUS=m
CONFIG_TABLET_SERIAL_WACOM4=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_88PM860X=m
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
# CONFIG_TOUCHSCREEN_CYTTSP5 is not set
CONFIG_TOUCHSCREEN_DA9034=m
CONFIG_TOUCHSCREEN_DA9052=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
# CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX is not set
CONFIG_TOUCHSCREEN_ILI210X=m
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_S6SY761=m
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=m
# CONFIG_TOUCHSCREEN_IMAGIS is not set
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
CONFIG_TOUCHSCREEN_UCB1400=m
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_WM831X=m
CONFIG_TOUCHSCREEN_WM97XX=m
CONFIG_TOUCHSCREEN_WM9705=y
CONFIG_TOUCHSCREEN_WM9712=y
CONFIG_TOUCHSCREEN_WM9713=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2005=m
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
CONFIG_TOUCHSCREEN_PCAP=m
CONFIG_TOUCHSCREEN_RM_TS=m
CONFIG_TOUCHSCREEN_SILEAD=m
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_SUR40=m
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
# CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
# CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=m
CONFIG_INPUT_88PM80X_ONKEY=m
CONFIG_INPUT_AD714X=m
CONFIG_INPUT_AD714X_I2C=m
CONFIG_INPUT_AD714X_SPI=m
CONFIG_INPUT_ARIZONA_HAPTICS=m
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_E3X0_BUTTON=m
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_MAX77693_HAPTIC=m
CONFIG_INPUT_MAX8925_ONKEY=m
CONFIG_INPUT_MAX8997_HAPTIC=m
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GPIO_BEEPER=m
CONFIG_INPUT_GPIO_DECODER=m
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
CONFIG_INPUT_KXTJ9=m
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_REGULATOR_HAPTIC=m
CONFIG_INPUT_RETU_PWRBUTTON=m
CONFIG_INPUT_AXP20X_PEK=m
CONFIG_INPUT_TWL4030_PWRBUTTON=m
CONFIG_INPUT_TWL4030_VIBRA=m
CONFIG_INPUT_TWL6040_VIBRA=m
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PALMAS_PWRBUTTON=m
CONFIG_INPUT_PCF50633_PMU=m
CONFIG_INPUT_PCF8574=m
CONFIG_INPUT_PWM_BEEPER=m
CONFIG_INPUT_PWM_VIBRA=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA7280_HAPTICS is not set
CONFIG_INPUT_DA9052_ONKEY=m
CONFIG_INPUT_DA9055_ONKEY=m
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_WM831X_ON=m
CONFIG_INPUT_PCAP=m
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_ADXL34X_SPI=m
CONFIG_INPUT_IMS_PCU=m
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
CONFIG_INPUT_SOC_BUTTON_ARRAY=m
CONFIG_INPUT_DRV260X_HAPTICS=m
CONFIG_INPUT_DRV2665_HAPTICS=m
CONFIG_INPUT_DRV2667_HAPTICS=m
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_APBPS2 is not set
CONFIG_HYPERV_KEYBOARD=m
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m
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
CONFIG_LEGACY_PTY_COUNT=0
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=48
CONFIG_SERIAL_8250_RUNTIME_UARTS=32
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=m
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=m
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_KGDB_NMI=y
CONFIG_SERIAL_MAX3100=m
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_CONSOLE_POLL=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_SC16IS7XX_SPI=y
CONFIG_SERIAL_ALTERA_JTAGUART=m
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=m
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=m
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_MEN_Z135=m
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_HW_RANDOM_CCTRNG is not set
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_APPLICOM=m

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
CONFIG_IPWIRELESS=m
# end of PCMCIA character devices

CONFIG_MWAVE=m
CONFIG_DEVMEM=y
CONFIG_NVRAM=m
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=m
# CONFIG_TCG_TIS_SPI_CR50 is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_XEN=m
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TCG_TIS_ST33ZP24_SPI=m
CONFIG_TELCLOCK=m
CONFIG_XILLYBUS_CLASS=m
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_PCIE=m
# CONFIG_XILLYBUS_OF is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=m
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=m
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=m
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
CONFIG_I2C_CCGX_UCSI=m
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_DLN2=m
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=m
CONFIG_I2C_TAOS_EVM=m
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_CROS_EC_TUNNEL=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
CONFIG_SPI_ALTERA_CORE=m
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BITBANG=m
CONFIG_SPI_BUTTERFLY=m
CONFIG_SPI_CADENCE=m
# CONFIG_SPI_CADENCE_QUADSPI is not set
# CONFIG_SPI_CADENCE_XSPI is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_DMA is not set
CONFIG_SPI_DW_PCI=m
CONFIG_SPI_DW_MMIO=m
CONFIG_SPI_DLN2=m
# CONFIG_SPI_NXP_FLEXSPI is not set
CONFIG_SPI_GPIO=m
CONFIG_SPI_INTEL=m
CONFIG_SPI_INTEL_PCI=m
CONFIG_SPI_INTEL_PLATFORM=m
CONFIG_SPI_LM70_LLP=m
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=m
# CONFIG_SPI_PCI1XXXX is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=m
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_SN_F_OSPI is not set
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_XCOMM=m
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=m
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=m
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=m
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=m
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=m
# CONFIG_SPMI_HISI3670 is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

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
CONFIG_PTP_1588_CLOCK_KVM=m
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
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_AXP209 is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_DA9062 is not set
# CONFIG_PINCTRL_EQUILIBRIUM is not set
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08_SPI=m
CONFIG_PINCTRL_MCP23S08=m
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_PALMAS is not set
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_STMFX is not set
CONFIG_PINCTRL_SX150X=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=m
CONFIG_PINCTRL_LYNXPOINT=m
CONFIG_PINCTRL_INTEL=m
CONFIG_PINCTRL_ALDERLAKE=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_ELKHARTLAKE=m
CONFIG_PINCTRL_EMMITSBURG=m
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_ICELAKE=m
CONFIG_PINCTRL_JASPERLAKE=m
CONFIG_PINCTRL_LAKEFIELD=m
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_METEORLAKE=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_PINCTRL_TIGERLAKE=m
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
CONFIG_GPIO_GENERIC=m
CONFIG_GPIO_MAX730X=m
CONFIG_GPIO_IDIO_16=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=m
CONFIG_GPIO_EXAR=m
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SIOX is not set
# CONFIG_GPIO_SYSCON is not set
CONFIG_GPIO_VX855=m
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=m
CONFIG_GPIO_104_DIO_48E=m
CONFIG_GPIO_104_IDIO_16=m
CONFIG_GPIO_104_IDI_48=m
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_GPIO_MM=m
CONFIG_GPIO_IT87=m
CONFIG_GPIO_SCH=m
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCA953X_IRQ is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=m
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_CRYSTAL_COVE is not set
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_DA9055=m
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_JANZ_TTL=m
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TWL4030=m
CONFIG_GPIO_TWL6040=m
CONFIG_GPIO_UCB1400=m
# CONFIG_GPIO_WHISKEY_COVE is not set
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8350=m
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=m
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCI_IDIO_16=m
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=m
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=m
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=m
CONFIG_GPIO_XRA1403=m
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=m
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2490=m
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_MT6323 is not set
# CONFIG_POWER_RESET_REGULATOR is not set
CONFIG_POWER_RESET_RESTART=y
# CONFIG_POWER_RESET_TPS65086 is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
# CONFIG_SYSCON_REBOOT_MODE is not set
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_IP5XXX_POWER is not set
CONFIG_MAX8925_POWER=m
CONFIG_WM831X_BACKUP=m
CONFIG_WM831X_POWER=m
CONFIG_WM8350_POWER=m
CONFIG_TEST_POWER=m
CONFIG_BATTERY_88PM860X=m
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=m
CONFIG_BATTERY_DA9052=m
CONFIG_CHARGER_DA9150=m
CONFIG_BATTERY_DA9150=m
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
CONFIG_AXP20X_POWER=m
CONFIG_AXP288_CHARGER=m
CONFIG_AXP288_FUEL_GAUGE=m
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
CONFIG_BATTERY_TWL4030_MADC=m
CONFIG_CHARGER_88PM860X=m
CONFIG_CHARGER_PCF50633=m
CONFIG_BATTERY_RX51=m
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_TWL4030=m
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_LP8788=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77693=m
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MAX8997=m
CONFIG_CHARGER_MAX8998=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=m
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65090=m
CONFIG_BATTERY_GAUGE_LTC2941=m
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=m
# CONFIG_CHARGER_CROS_USBPD is not set
CONFIG_CHARGER_CROS_PCHG=m
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7314=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_I8K is not set
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_DA9055=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=m
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=m
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=m
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
CONFIG_SENSORS_IBM_CFFPS=m
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=m
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LM25066_REGULATOR is not set
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=m
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
# CONFIG_SENSORS_TPS546D24 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_WM831X=m
CONFIG_SENSORS_WM8350=m
CONFIG_SENSORS_XGENE=m

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CPU_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
# CONFIG_THERMAL_MMIO is not set
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
CONFIG_INT3406_THERMAL=m
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_BXT_PMIC_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
CONFIG_INTEL_MENLOW=m
CONFIG_INTEL_HFI_THERMAL=y
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=m
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
CONFIG_DA9052_WATCHDOG=m
CONFIG_DA9055_WATCHDOG=m
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=m
# CONFIG_MENZ069_WATCHDOG is not set
CONFIG_WDAT_WDT=m
CONFIG_WM831X_WATCHDOG=m
CONFIG_WM8350_WATCHDOG=m
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_RAVE_SP_WATCHDOG=m
# CONFIG_MLX_WDT is not set
CONFIG_CADENCE_WATCHDOG=m
CONFIG_DW_WATCHDOG=m
CONFIG_TWL4030_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_EBC_C384_WDT=m
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=m
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
CONFIG_KEMPLD_WDT=m
CONFIG_SC1200_WDT=m
CONFIG_PC87413_WDT=m
CONFIG_NV_TCO=m
CONFIG_60XX_WDT=m
CONFIG_CPU5_WDT=m
CONFIG_SMSC_SCH311X_WDT=m
CONFIG_SMSC37B787_WDT=m
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=m
CONFIG_NI903X_WDT=m
CONFIG_NIC7018_WDT=m
CONFIG_MEN_A21_WDT=m
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_BLOCKIO=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_B43_PCI_BRIDGE=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_BLOCKIO=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
# CONFIG_MFD_SMPRO is not set
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC_DEV=m
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=m
CONFIG_MFD_DLN2=m
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_SPI=m
CONFIG_MFD_MC13XXX_I2C=m
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_MFD_HI6421_SPMI is not set
CONFIG_HTC_PASIC3=m
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_BXTWC=m
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
CONFIG_MFD_INTEL_LPSS_PCI=m
CONFIG_MFD_INTEL_PMC_BXT=m
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77714 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
# CONFIG_MFD_OCELOT is not set
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_UCB1400_CORE=m
# CONFIG_MFD_SY7636A is not set
CONFIG_MFD_RDC321X=m
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=m
# CONFIG_MFD_RT5120 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
CONFIG_TPS65010=m
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS65219 is not set
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=m
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
# CONFIG_MFD_WCD934X is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_RAVE_SP_CORE=m
# CONFIG_MFD_INTEL_M10_BMC is not set
# CONFIG_MFD_RSMU_I2C is not set
# CONFIG_MFD_RSMU_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_AAT2870=m
CONFIG_REGULATOR_ARIZONA_LDO1=m
CONFIG_REGULATOR_ARIZONA_MICSUPP=m
CONFIG_REGULATOR_AS3711=m
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD9571MWV=m
# CONFIG_REGULATOR_CROS_EC is not set
CONFIG_REGULATOR_DA903X=m
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9055=m
CONFIG_REGULATOR_DA9062=m
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=m
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LP8788=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=m
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=m
CONFIG_REGULATOR_MAX8998=m
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77693=m
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=m
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=m
# CONFIG_REGULATOR_MT6315 is not set
CONFIG_REGULATOR_MT6323=m
# CONFIG_REGULATOR_MT6331 is not set
# CONFIG_REGULATOR_MT6332 is not set
# CONFIG_REGULATOR_MT6357 is not set
# CONFIG_REGULATOR_MT6358 is not set
# CONFIG_REGULATOR_MT6359 is not set
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PALMAS=m
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCAP=m
CONFIG_REGULATOR_PCF50633=m
# CONFIG_REGULATOR_PF8X00 is not set
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=m
CONFIG_REGULATOR_QCOM_SPMI=m
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RC5T583=m
# CONFIG_REGULATOR_RT4801 is not set
CONFIG_REGULATOR_RT5033=m
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6190 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_SY8824X is not set
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65090=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS6524X=m
CONFIG_REGULATOR_TPS6586X=m
CONFIG_REGULATOR_TPS65910=m
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TWL4030=m
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=m
CONFIG_REGULATOR_WM8350=m
CONFIG_REGULATOR_WM8400=m
CONFIG_REGULATOR_WM8994=m
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
# CONFIG_IR_IMON_DECODER is not set
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_XMP_DECODER=m
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_GPIO_TX is not set
# CONFIG_IR_HIX5HD2 is not set
CONFIG_IR_IGORPLUGUSB=m
CONFIG_IR_IGUANA=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_MCEUSB=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_PWM_TX is not set
CONFIG_IR_REDRAT3=m
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_SPI is not set
CONFIG_IR_STREAMZAP=m
# CONFIG_IR_TOY is not set
CONFIG_IR_TTUSBIR=m
CONFIG_IR_WINBOND_CIR=m
CONFIG_RC_ATI_REMOTE=m
CONFIG_RC_LOOPBACK=m
# CONFIG_RC_XBOX_DVD is not set
CONFIG_CEC_CORE=m

#
# CEC support
#
CONFIG_MEDIA_CEC_RC=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_CROS_EC is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SECO is not set
CONFIG_USB_PULSE8_CEC=m
CONFIG_USB_RAINSHADOW_CEC=m
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
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
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_V4L2_MEM2MEM_DEV=m
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_V4L2_FWNODE=m
CONFIG_V4L2_ASYNC=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_MEDIA_CONTROLLER_REQUEST_API=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
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
CONFIG_USB_GSPCA_CPIA1=m
CONFIG_USB_GSPCA_DTCS033=m
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
CONFIG_USB_GSPCA_KINECT=m
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
CONFIG_USB_GSPCA_STK1135=m
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
CONFIG_USB_GSPCA_TOUPTEK=m
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_GL860=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
CONFIG_USB_S2255=m
CONFIG_VIDEO_USBTV=m
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y

#
# Analog TV USB devices
#
CONFIG_VIDEO_GO7007=m
CONFIG_VIDEO_GO7007_USB=m
CONFIG_VIDEO_GO7007_LOADER=m
CONFIG_VIDEO_GO7007_USB_S2250_BOARD=m
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_STK1160_COMMON=m
CONFIG_VIDEO_STK1160=m

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
CONFIG_VIDEO_AU0828_RC=y
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_AS102=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_DVBSKY=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
CONFIG_DVB_USB_ZD1301=m
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_VP7045=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
CONFIG_VIDEO_EM28XX_V4L2=m
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=m
CONFIG_USB_HACKRF=m
CONFIG_USB_MSI2500=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_SOLO6X10=m
CONFIG_VIDEO_TW5864=m
CONFIG_VIDEO_TW68=m
CONFIG_VIDEO_TW686X=m
# CONFIG_VIDEO_ZORAN is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_DT3155=m
CONFIG_VIDEO_IVTV=m
CONFIG_VIDEO_IVTV_ALSA=m
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_COBALT=m
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
CONFIG_VIDEO_CX25821=m
CONFIG_VIDEO_CX25821_ALSA=m
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7134_GO7007=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
CONFIG_DVB_DM1105=m
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NETUP_UNIDVB=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_PT1=m
CONFIG_DVB_PT3=m
CONFIG_DVB_SMIPCIE=m
CONFIG_VIDEO_IPU3_CIO2=m
# CONFIG_CIO2_BRIDGE is not set
CONFIG_RADIO_ADAPTERS=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_SAA7706H=m
CONFIG_RADIO_SHARK=m
CONFIG_RADIO_SHARK2=m
CONFIG_RADIO_SI4713=m
CONFIG_RADIO_SI476X=m
CONFIG_RADIO_TEA575X=m
CONFIG_RADIO_TEA5764=m
CONFIG_RADIO_TEF6862=m
CONFIG_RADIO_WL1273=m
CONFIG_USB_DSBR=m
CONFIG_USB_KEENE=m
CONFIG_USB_MA901=m
CONFIG_USB_MR800=m
CONFIG_USB_RAREMONO=m
CONFIG_RADIO_SI470X=m
CONFIG_USB_SI470X=m
CONFIG_I2C_SI470X=m
CONFIG_USB_SI4713=m
CONFIG_PLATFORM_SI4713=m
CONFIG_I2C_SI4713=m
CONFIG_RADIO_WL128X=m
CONFIG_MEDIA_PLATFORM_DRIVERS=y
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m
# CONFIG_VIDEO_MUX is not set

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
CONFIG_VIDEO_CAFE_CCIC=m

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
CONFIG_VIDEO_VIA_CAMERA=m

#
# Xilinx media platform drivers
#
# CONFIG_VIDEO_XILINX is not set

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIM2M=m
# CONFIG_VIDEO_VICODEC is not set
# CONFIG_VIDEO_VIMC is not set
CONFIG_VIDEO_VIVID=m
CONFIG_VIDEO_VIVID_CEC=y
CONFIG_VIDEO_VIVID_MAX_DEVS=64
# CONFIG_VIDEO_VISL is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_TTPCI_EEPROM=m
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
CONFIG_SMS_SIANO_DEBUGFS=y
CONFIG_VIDEO_V4L2_TPG=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Camera sensor devices
#
# CONFIG_VIDEO_AR0521 is not set
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
# CONFIG_VIDEO_IMX208 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX334 is not set
# CONFIG_VIDEO_IMX335 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_IMX412 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
CONFIG_VIDEO_MT9V011=m
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_OG01A1B is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV08D10 is not set
# CONFIG_VIDEO_OV08X40 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=m
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV4689 is not set
# CONFIG_VIDEO_OV5640 is not set
# CONFIG_VIDEO_OV5645 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV7251 is not set
CONFIG_VIDEO_OV7640=m
CONFIG_VIDEO_OV7670=m
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9282 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_ST_VGXY61 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_M5MOLS is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_SONY_BTF_MPX=m
# CONFIG_VIDEO_TDA1997X is not set
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_WM8775=m
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV748X is not set
CONFIG_VIDEO_ADV7604=m
# CONFIG_VIDEO_ADV7604_CEC is not set
CONFIG_VIDEO_ADV7842=m
# CONFIG_VIDEO_ADV7842_CEC is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_ISL7998X is not set
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_MAX9286=m
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TC358746 is not set
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=m
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_ADV7511=m
# CONFIG_VIDEO_ADV7511_CEC is not set
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
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
CONFIG_VIDEO_SAA6752HS=m
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
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_ST_MIPID02 is not set
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# CONFIG_VIDEO_GS1662 is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_XC5000=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_TDA18271C2DD=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_MT312=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_TDA10071=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=m
CONFIG_DVB_AS102_FE=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_EC100=m
CONFIG_DVB_GP8PSK_FE=m
CONFIG_DVB_L64781=m
CONFIG_DVB_MT352=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_SI2168=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_ZL10353=m
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_VES1820=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_MXL692=m
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m
CONFIG_DVB_S921=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_MN88443X is not set
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_HELENE=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_IX2505V=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_DRX39XYJ=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=m
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_DMA_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

CONFIG_DRM_RADEON=m
# CONFIG_DRM_RADEON_USERPTR is not set
CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_SI=y
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_AMDGPU_USERPTR=y

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_DCN=y
# CONFIG_DRM_AMD_DC_HDCP is not set
# CONFIG_DRM_AMD_DC_SI is not set
# CONFIG_DEBUG_KERNEL_DC is not set
# CONFIG_DRM_AMD_SECURE_DISPLAY is not set
# end of Display Engine Configuration

# CONFIG_HSA_AMD is not set
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=y
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
# CONFIG_NOUVEAU_DEBUG_PUSH is not set
CONFIG_DRM_NOUVEAU_BACKLIGHT=y
# CONFIG_DRM_NOUVEAU_SVM is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE="*"
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=100
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
# CONFIG_DRM_VMWGFX_MKSSTATS is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_USE_LVDS is not set
# CONFIG_DRM_RCAR_USE_MIPI_DSI is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ABT_Y030XX067A is not set
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
# CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
# CONFIG_DRM_PANEL_DSI_CM is not set
# CONFIG_DRM_PANEL_LVDS is not set
# CONFIG_DRM_PANEL_SIMPLE is not set
# CONFIG_DRM_PANEL_EDP is not set
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
# CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
# CONFIG_DRM_PANEL_JADARD_JD9365DA_H3 is not set
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_JDI_R63452 is not set
# CONFIG_DRM_PANEL_KHADAS_TS050 is not set
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
# CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
# CONFIG_DRM_PANEL_LG_LG4573 is not set
# CONFIG_DRM_PANEL_NEC_NL8048HL11 is not set
# CONFIG_DRM_PANEL_NEWVISION_NV3051D is not set
# CONFIG_DRM_PANEL_NEWVISION_NV3052C is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35560 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
# CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
# CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set
# CONFIG_DRM_PANEL_SAMSUNG_DB7430 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D27A1 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_SOFEF00 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
# CONFIG_DRM_PANEL_SHARP_LS060T1SX01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
# CONFIG_DRM_PANEL_SONY_ACX565AKM is not set
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
# CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
# CONFIG_DRM_PANEL_TPO_TD028TTEC1 is not set
# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_CHIPONE_ICN6211 is not set
# CONFIG_DRM_CHRONTEL_CH7033 is not set
# CONFIG_DRM_CROS_EC_ANX7688 is not set
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_ITE_IT6505 is not set
# CONFIG_DRM_LONTIUM_LT8912B is not set
# CONFIG_DRM_LONTIUM_LT9211 is not set
# CONFIG_DRM_LONTIUM_LT9611 is not set
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
# CONFIG_DRM_ITE_IT66121 is not set
# CONFIG_DRM_LVDS_CODEC is not set
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
# CONFIG_DRM_NWL_MIPI_DSI is not set
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
# CONFIG_DRM_PARADE_PS8640 is not set
# CONFIG_DRM_SIL_SII8620 is not set
# CONFIG_DRM_SII902X is not set
# CONFIG_DRM_SII9234 is not set
# CONFIG_DRM_SIMPLE_BRIDGE is not set
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358762 is not set
# CONFIG_DRM_TOSHIBA_TC358764 is not set
# CONFIG_DRM_TOSHIBA_TC358767 is not set
# CONFIG_DRM_TOSHIBA_TC358768 is not set
# CONFIG_DRM_TOSHIBA_TC358775 is not set
# CONFIG_DRM_TI_DLPC3433 is not set
# CONFIG_DRM_TI_TFP410 is not set
# CONFIG_DRM_TI_SN65DSI83 is not set
# CONFIG_DRM_TI_SN65DSI86 is not set
# CONFIG_DRM_TI_TPD12S015 is not set
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
# CONFIG_DRM_ANALOGIX_ANX7625 is not set
# CONFIG_DRM_I2C_ADV7511 is not set
# CONFIG_DRM_CDNS_MHDP8546 is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_LOGICVC is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_IMX_LCDIF is not set
# CONFIG_DRM_ARCPGU is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
CONFIG_TINYDRM_ILI9225=m
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
CONFIG_TINYDRM_MI0283QT=m
CONFIG_TINYDRM_REPAPER=m
CONFIG_TINYDRM_ST7586=m
CONFIG_TINYDRM_ST7735R=m
# CONFIG_DRM_XEN_FRONTEND is not set
CONFIG_DRM_VBOXVIDEO=m
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=m
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=m
CONFIG_FB_ASILIANT=y
CONFIG_FB_IMSTT=y
CONFIG_FB_VGA16=m
CONFIG_FB_UVESA=m
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=m
CONFIG_FB_LE80578=m
CONFIG_FB_CARILLO_RANCH=m
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=m
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=m
CONFIG_FB_TRIDENT=m
CONFIG_FB_ARK=m
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_SM501=m
CONFIG_FB_SMSCUFX=m
CONFIG_FB_UDL=m
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_XEN_FBDEV_FRONTEND=m
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_HYPERV=m
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SSD1307 is not set
CONFIG_FB_SM712=m
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=m
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_CARILLO_RANCH=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_MAX8925=m
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP5520=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_88PM860X=m
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_AAT2870=m
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_LP8788=m
CONFIG_BACKLIGHT_PANDORA=m
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_AS3711=m
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
# CONFIG_BACKLIGHT_RAVE_SP is not set
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
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
CONFIG_SND_CTL_LED=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_MTS64=m
CONFIG_SND_SERIAL_U16550=m
# CONFIG_SND_SERIAL_GENERIC is not set
CONFIG_SND_MPU401=m
CONFIG_SND_PORTMAN2X4=m
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_SB_COMMON=m
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
CONFIG_SND_ALS300=m
CONFIG_SND_ALS4000=m
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
CONFIG_SND_AW2=m
CONFIG_SND_AZT3328=m
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
CONFIG_SND_CS4281=m
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
CONFIG_SND_FM801=m
CONFIG_SND_FM801_TEA575X_BOOL=y
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
CONFIG_SND_PCXHR=m
CONFIG_SND_RIPTIDE=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
CONFIG_SND_YMFPCI=m

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
# CONFIG_SND_HDA_SCODEC_CS35L41_I2C is not set
# CONFIG_SND_HDA_SCODEC_CS35L41_SPI is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
# CONFIG_SND_HDA_CODEC_CS8409 is not set
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
# CONFIG_SND_INTEL_BYT_PREFER_SOF is not set
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
CONFIG_SND_DICE=m
CONFIG_SND_OXFW=m
CONFIG_SND_ISIGHT=m
CONFIG_SND_FIREWORKS=m
CONFIG_SND_BEBOB=m
CONFIG_SND_FIREWIRE_DIGI00X=m
CONFIG_SND_FIREWIRE_TASCAM=m
CONFIG_SND_FIREWIRE_MOTU=m
CONFIG_SND_FIREFACE=m
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=m
CONFIG_SND_PDAUDIOCF=m
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_ADI is not set
CONFIG_SND_SOC_AMD_ACP=m
# CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH is not set
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
# CONFIG_SND_SOC_AMD_ST_ES8336_MACH is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
# CONFIG_SND_SOC_AMD_PS is not set
CONFIG_SND_ATMEL_SOC=m
# CONFIG_SND_SOC_MIKROE_PROTO is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
CONFIG_SND_DESIGNWARE_I2S=m
CONFIG_SND_DESIGNWARE_PCM=y

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
# CONFIG_SND_SOC_FSL_MQS is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_EASRC is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
CONFIG_SND_SOC_FSL_UTILS=m
# CONFIG_SND_SOC_FSL_RPMSG is not set
CONFIG_SND_SOC_IMX_AUDMUX=m
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
CONFIG_SND_SOC_IMG_I2S_OUT=m
CONFIG_SND_SOC_IMG_PARALLEL_OUT=m
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_SST=m
# CONFIG_SND_SOC_INTEL_CATPT is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
# CONFIG_SND_SOC_INTEL_AVS is not set
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
CONFIG_SND_SOC_INTEL_HDA_DSP_COMMON=m
CONFIG_SND_SOC_INTEL_SOF_MAXIM_COMMON=m
# CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH is not set
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
# CONFIG_SND_SOC_INTEL_BYTCR_WM5102_MACH is not set
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=m
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
# CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH is not set
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
# CONFIG_SND_SOC_INTEL_BXT_RT298_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_WM8804_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m
# CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_PCM512x_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_ES8336_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_NAU8825_MACH is not set
# CONFIG_SND_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_DA7219_MAX98373_MACH is not set
# CONFIG_SND_SOC_INTEL_SOF_SSP_AMP_MACH is not set
CONFIG_SND_SOC_INTEL_EHL_RT5660_MACH=m
CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH=m
# CONFIG_SND_SOC_MTK_BTCVSD is not set
CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI_DEV=m
CONFIG_SND_SOC_SOF_PCI=m
CONFIG_SND_SOC_SOF_ACPI=m
CONFIG_SND_SOC_SOF_ACPI_DEV=m
CONFIG_SND_SOC_SOF_OF=m
CONFIG_SND_SOC_SOF_DEBUG_PROBES=m
CONFIG_SND_SOC_SOF_CLIENT=m
CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT=y
# CONFIG_SND_SOC_SOF_FORCE_PROBE_WORKQUEUE is not set
# CONFIG_SND_SOC_SOF_NOCODEC_SUPPORT is not set
# CONFIG_SND_SOC_SOF_STRICT_ABI_CHECKS is not set
CONFIG_SND_SOC_SOF_DEBUG=y
# CONFIG_SND_SOC_SOF_NOCODEC_DEBUG_SUPPORT is not set
# CONFIG_SND_SOC_SOF_DEBUG_XRUN_STOP is not set
CONFIG_SND_SOC_SOF_DEBUG_VERBOSE_IPC=y
# CONFIG_SND_SOC_SOF_DEBUG_FORCE_IPC_POSITION is not set
CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE=y
CONFIG_SND_SOC_SOF_DEBUG_ENABLE_FIRMWARE_TRACE=y
# CONFIG_SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST is not set
# CONFIG_SND_SOC_SOF_DEBUG_IPC_MSG_INJECTOR is not set
# CONFIG_SND_SOC_SOF_DEBUG_RETAIN_DSP_CONTEXT is not set
CONFIG_SND_SOC_SOF=m
CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=y
CONFIG_SND_SOC_SOF_IPC3=y
CONFIG_SND_SOC_SOF_INTEL_IPC4=y
# CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=m
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=m
CONFIG_SND_SOC_SOF_INTEL_COMMON=m
CONFIG_SND_SOC_SOF_BAYTRAIL=m
CONFIG_SND_SOC_SOF_BROADWELL=m
CONFIG_SND_SOC_SOF_MERRIFIELD=m
CONFIG_SND_SOC_SOF_INTEL_SKL=m
CONFIG_SND_SOC_SOF_SKYLAKE=m
CONFIG_SND_SOC_SOF_KABYLAKE=m
CONFIG_SND_SOC_SOF_INTEL_APL=m
CONFIG_SND_SOC_SOF_APOLLOLAKE=m
CONFIG_SND_SOC_SOF_GEMINILAKE=m
CONFIG_SND_SOC_SOF_INTEL_CNL=m
CONFIG_SND_SOC_SOF_CANNONLAKE=m
CONFIG_SND_SOC_SOF_COFFEELAKE=m
CONFIG_SND_SOC_SOF_COMETLAKE=m
CONFIG_SND_SOC_SOF_INTEL_ICL=m
CONFIG_SND_SOC_SOF_ICELAKE=m
CONFIG_SND_SOC_SOF_JASPERLAKE=m
CONFIG_SND_SOC_SOF_INTEL_TGL=m
CONFIG_SND_SOC_SOF_TIGERLAKE=m
CONFIG_SND_SOC_SOF_ELKHARTLAKE=m
CONFIG_SND_SOC_SOF_ALDERLAKE=m
CONFIG_SND_SOC_SOF_INTEL_MTL=m
CONFIG_SND_SOC_SOF_METEORLAKE=m
CONFIG_SND_SOC_SOF_HDA_COMMON=m
CONFIG_SND_SOC_SOF_HDA_LINK=y
CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=y
CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_HDA=m
CONFIG_SND_SOC_SOF_HDA_PROBES=m
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE=m
CONFIG_SND_SOC_SOF_XTENSA=m

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
# CONFIG_SND_SOC_ADAU1372_I2C is not set
# CONFIG_SND_SOC_ADAU1372_SPI is not set
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
CONFIG_SND_SOC_ADAU1761_SPI=m
CONFIG_SND_SOC_ADAU7002=m
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
CONFIG_SND_SOC_AK4104=m
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4375 is not set
# CONFIG_SND_SOC_AK4458 is not set
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
CONFIG_SND_SOC_AK4642=m
CONFIG_SND_SOC_AK5386=m
# CONFIG_SND_SOC_AK5558 is not set
CONFIG_SND_SOC_ALC5623=m
# CONFIG_SND_SOC_AW8738 is not set
# CONFIG_SND_SOC_BD28623 is not set
CONFIG_SND_SOC_BT_SCO=m
# CONFIG_SND_SOC_CROS_EC_CODEC is not set
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS35L41_SPI is not set
# CONFIG_SND_SOC_CS35L41_I2C is not set
# CONFIG_SND_SOC_CS35L45_SPI is not set
# CONFIG_SND_SOC_CS35L45_I2C is not set
CONFIG_SND_SOC_CS42L42_CORE=m
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
# CONFIG_SND_SOC_CS42L83 is not set
# CONFIG_SND_SOC_CS4234 is not set
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_I2C=m
CONFIG_SND_SOC_CS4271_SPI=m
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
CONFIG_SND_SOC_CS43130=m
# CONFIG_SND_SOC_CS4341 is not set
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=m
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8326 is not set
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_HDAC_HDMI=m
CONFIG_SND_SOC_HDAC_HDA=m
# CONFIG_SND_SOC_HDA is not set
# CONFIG_SND_SOC_ICS43432 is not set
CONFIG_SND_SOC_INNO_RK3036=m
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98504=m
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98520 is not set
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX98373_I2C=m
CONFIG_SND_SOC_MAX98373_SDW=m
CONFIG_SND_SOC_MAX98390=m
# CONFIG_SND_SOC_MAX98396 is not set
CONFIG_SND_SOC_MAX9860=m
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
# CONFIG_SND_SOC_PCM1789_I2C is not set
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM179X_SPI=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
CONFIG_SND_SOC_PCM186X_SPI=m
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
CONFIG_SND_SOC_PCM3168A_SPI=m
# CONFIG_SND_SOC_PCM5102A is not set
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
CONFIG_SND_SOC_PCM512x_SPI=m
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT1308=m
CONFIG_SND_SOC_RT1308_SDW=m
CONFIG_SND_SOC_RT1316_SDW=m
CONFIG_SND_SOC_RT1318_SDW=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
# CONFIG_SND_SOC_RT5659 is not set
CONFIG_SND_SOC_RT5660=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
CONFIG_SND_SOC_RT5682=m
CONFIG_SND_SOC_RT5682_SDW=m
CONFIG_SND_SOC_RT700=m
CONFIG_SND_SOC_RT700_SDW=m
CONFIG_SND_SOC_RT711=m
CONFIG_SND_SOC_RT711_SDW=m
CONFIG_SND_SOC_RT711_SDCA_SDW=m
CONFIG_SND_SOC_RT715=m
CONFIG_SND_SOC_RT715_SDW=m
CONFIG_SND_SOC_RT715_SDCA_SDW=m
# CONFIG_SND_SOC_RT9120 is not set
CONFIG_SND_SOC_SDW_MOCKUP=m
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SI476X=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIMPLE_MUX is not set
CONFIG_SND_SOC_SPDIF=m
# CONFIG_SND_SOC_SRC4XXX_I2C is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2518 is not set
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
CONFIG_SND_SOC_SSM2602_I2C=m
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS2780 is not set
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
# CONFIG_SND_SOC_TAS5805M is not set
CONFIG_SND_SOC_TAS6424=m
# CONFIG_SND_SOC_TDA7419 is not set
CONFIG_SND_SOC_TFA9879=m
# CONFIG_SND_SOC_TFA989X is not set
# CONFIG_SND_SOC_TLV320ADC3XXX is not set
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
CONFIG_SND_SOC_TLV320AIC23_SPI=m
CONFIG_SND_SOC_TLV320AIC31XX=m
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
# CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_TSCS42XX=m
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WCD9335 is not set
# CONFIG_SND_SOC_WCD938X_SDW is not set
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
CONFIG_SND_SOC_WM8711=m
CONFIG_SND_SOC_WM8728=m
# CONFIG_SND_SOC_WM8731_I2C is not set
# CONFIG_SND_SOC_WM8731_SPI is not set
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=m
CONFIG_SND_SOC_WM8770=m
CONFIG_SND_SOC_WM8776=m
# CONFIG_SND_SOC_WM8782 is not set
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
CONFIG_SND_SOC_WM8804_SPI=m
CONFIG_SND_SOC_WM8903=m
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8940 is not set
CONFIG_SND_SOC_WM8960=m
# CONFIG_SND_SOC_WM8961 is not set
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
# CONFIG_SND_SOC_WSA881X is not set
# CONFIG_SND_SOC_WSA883X is not set
# CONFIG_SND_SOC_ZL38060 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8315 is not set
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
# CONFIG_SND_SOC_NAU8821 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
CONFIG_SND_SOC_TPA6130A2=m
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
# CONFIG_SND_AUDIO_GRAPH_CARD2 is not set
# CONFIG_SND_TEST_COMPONENT is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
# CONFIG_SND_VIRTIO is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
CONFIG_HID_APPLEIR=m
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_BETOP_FF=m
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_CORSAIR=m
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CP2112=m
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=m
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=m
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=m
CONFIG_HOLTEK_FF=y
# CONFIG_HID_GOOGLE_HAMMER is not set
# CONFIG_HID_VIVALDI is not set
CONFIG_HID_GT683R=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=m
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=m
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=m
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
CONFIG_HID_RETRODE=m
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
CONFIG_HID_SONY=m
CONFIG_SONY_FF=y
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
CONFIG_GREENASIA_FF=y
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=m
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_ELAN is not set
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
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
CONFIG_USB_ULPI_BUS=m
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
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=m

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_MAX3421_HCD=m
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_U132_HCD=m
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_SL811_CS=m
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_HCD_BCMA=m
CONFIG_USB_HCD_SSB=m
# CONFIG_USB_HCD_TEST_MODE is not set
# CONFIG_USB_XEN_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=y

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
CONFIG_USBIP_VHCI_HCD=m
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
CONFIG_USBIP_HOST=m
CONFIG_USBIP_VUDC=m
# CONFIG_USBIP_DEBUG is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=m
CONFIG_USB_DWC3_ULPI=y
# CONFIG_USB_DWC3_HOST is not set
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_DWC3_DUAL_ROLE=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC3_HAPS=m
CONFIG_USB_DWC3_OF_SIMPLE=m
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PCI=m
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_UDC=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_CHIPIDEA_PCI=m
CONFIG_USB_CHIPIDEA_MSM=m
CONFIG_USB_CHIPIDEA_IMX=m
CONFIG_USB_CHIPIDEA_GENERIC=m
CONFIG_USB_CHIPIDEA_TEGRA=m
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=m
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_F81232=m
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_METRO=m
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
CONFIG_USB_SERIAL_WISHBONE=m
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=m
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=m
CONFIG_USB_CHAOSKEY=m
# CONFIG_USB_ONBOARD_HUB is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
CONFIG_USB_ISP1301=m
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_U_SERIAL_CONSOLE=y

#
# USB Peripheral Controller
#
CONFIG_USB_GR_UDC=m
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
CONFIG_USB_MV_U3D=m
CONFIG_USB_SNP_CORE=m
# CONFIG_USB_SNP_UDC_PLAT is not set
# CONFIG_USB_M66592 is not set
CONFIG_USB_BDC_UDC=m
CONFIG_USB_AMD5536UDC=m
CONFIG_USB_NET2272=m
CONFIG_USB_NET2272_DMA=y
CONFIG_USB_NET2280=m
CONFIG_USB_GOKU=m
CONFIG_USB_EG20T=m
# CONFIG_USB_GADGET_XILINX is not set
# CONFIG_USB_MAX3420_UDC is not set
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_ACM=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_U_SERIAL=m
CONFIG_USB_U_ETHER=m
CONFIG_USB_U_AUDIO=m
CONFIG_USB_F_SERIAL=m
CONFIG_USB_F_OBEX=m
CONFIG_USB_F_NCM=m
CONFIG_USB_F_ECM=m
CONFIG_USB_F_PHONET=m
CONFIG_USB_F_EEM=m
CONFIG_USB_F_SUBSET=m
CONFIG_USB_F_RNDIS=m
CONFIG_USB_F_MASS_STORAGE=m
CONFIG_USB_F_FS=m
CONFIG_USB_F_UAC1=m
CONFIG_USB_F_UAC1_LEGACY=m
CONFIG_USB_F_UAC2=m
CONFIG_USB_F_UVC=m
CONFIG_USB_F_MIDI=m
CONFIG_USB_F_HID=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_F_TCM=m
CONFIG_USB_CONFIGFS=m
CONFIG_USB_CONFIGFS_SERIAL=y
CONFIG_USB_CONFIGFS_ACM=y
CONFIG_USB_CONFIGFS_OBEX=y
CONFIG_USB_CONFIGFS_NCM=y
CONFIG_USB_CONFIGFS_ECM=y
CONFIG_USB_CONFIGFS_ECM_SUBSET=y
CONFIG_USB_CONFIGFS_RNDIS=y
CONFIG_USB_CONFIGFS_EEM=y
CONFIG_USB_CONFIGFS_PHONET=y
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
CONFIG_USB_CONFIGFS_F_FS=y
CONFIG_USB_CONFIGFS_F_UAC1=y
CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=y
CONFIG_USB_CONFIGFS_F_UAC2=y
CONFIG_USB_CONFIGFS_F_MIDI=y
CONFIG_USB_CONFIGFS_F_HID=y
CONFIG_USB_CONFIGFS_F_UVC=y
CONFIG_USB_CONFIGFS_F_PRINTER=y
CONFIG_USB_CONFIGFS_F_TCM=y

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=m
CONFIG_USB_AUDIO=m
CONFIG_GADGET_UAC1=y
# CONFIG_GADGET_UAC1_LEGACY is not set
CONFIG_USB_ETH=m
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_ETH_EEM=y
CONFIG_USB_G_NCM=m
CONFIG_USB_GADGETFS=m
CONFIG_USB_FUNCTIONFS=m
CONFIG_USB_FUNCTIONFS_ETH=y
CONFIG_USB_FUNCTIONFS_RNDIS=y
CONFIG_USB_FUNCTIONFS_GENERIC=y
CONFIG_USB_MASS_STORAGE=m
CONFIG_USB_GADGET_TARGET=m
CONFIG_USB_G_SERIAL=m
CONFIG_USB_MIDI_GADGET=m
CONFIG_USB_G_PRINTER=m
CONFIG_USB_CDC_COMPOSITE=m
CONFIG_USB_G_NOKIA=m
CONFIG_USB_G_ACM_MS=m
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=m
CONFIG_USB_G_DBGP=m
# CONFIG_USB_G_DBGP_PRINTK is not set
CONFIG_USB_G_DBGP_SERIAL=y
CONFIG_USB_G_WEBCAM=m
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=m
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
# CONFIG_TYPEC_RT1711H is not set
# CONFIG_TYPEC_TCPCI_MAXIM is not set
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_WCOVE=m
CONFIG_TYPEC_UCSI=m
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=m
# CONFIG_UCSI_STM32G0 is not set
CONFIG_TYPEC_TPS6598X=m
# CONFIG_TYPEC_ANX7411 is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_HD3SS3220 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
CONFIG_TYPEC_MUX_PI3USB30532=m
CONFIG_TYPEC_MUX_INTEL_PMC=m
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
# CONFIG_TYPEC_NVIDIA_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=m
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
# CONFIG_PWRSEQ_SD8787 is not set
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set
# CONFIG_MMC_CRYPTO is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=y
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
# CONFIG_MMC_SDHCI_OF_AT91 is not set
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
# CONFIG_MMC_SDHCI_CADENCE is not set
CONFIG_MMC_SDHCI_F_SDH30=m
# CONFIG_MMC_SDHCI_MILBEAUT is not set
CONFIG_MMC_WBSD=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_SPI=m
CONFIG_MMC_SDRICOH_CS=m
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_HSQ is not set
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
# CONFIG_MMC_SDHCI_OMAP is not set
# CONFIG_MMC_SDHCI_AM654 is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFS_BSG=y
CONFIG_SCSI_UFS_CRYPTO=y
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_FAULT_INJECTION is not set
# CONFIG_SCSI_UFS_HWMON is not set
CONFIG_SCSI_UFSHCD_PCI=m
CONFIG_SCSI_UFS_DWC_TC_PCI=m
CONFIG_SCSI_UFSHCD_PLATFORM=m
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_MEMSTICK_REALTEK_USB=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=m
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CR0014114 is not set
# CONFIG_LEDS_EL15203000 is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8788=m
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=m
CONFIG_LEDS_WM8350=m
CONFIG_LEDS_DA903X=m
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_DAC124S085=m
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=m
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX8997=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_MENF21BMC=m
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=m
# CONFIG_LEDS_SPI_BYTE is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_KTD2692 is not set
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_MAX77693 is not set
# CONFIG_LEDS_RT4505 is not set
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=m
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
CONFIG_INFINIBAND_BNXT_RE=m
CONFIG_INFINIBAND_CXGB4=m
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_ERDMA is not set
CONFIG_INFINIBAND_HFI1=m
# CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
# CONFIG_SDMA_VERBOSITY is not set
# CONFIG_INFINIBAND_IRDMA is not set
CONFIG_MLX4_INFINIBAND=m
CONFIG_MLX5_INFINIBAND=m
CONFIG_INFINIBAND_MTHCA=m
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
CONFIG_INFINIBAND_OCRDMA=m
CONFIG_INFINIBAND_QEDR=m
CONFIG_INFINIBAND_QIB=m
CONFIG_INFINIBAND_QIB_DCA=y
CONFIG_INFINIBAND_USNIC=m
CONFIG_INFINIBAND_VMWARE_PVRDMA=m
CONFIG_INFINIBAND_RDMAVT=m
CONFIG_RDMA_RXE=m
# CONFIG_RDMA_SIW is not set
CONFIG_INFINIBAND_IPOIB=m
CONFIG_INFINIBAND_IPOIB_CM=y
# CONFIG_INFINIBAND_IPOIB_DEBUG is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
CONFIG_INFINIBAND_ISER=m
CONFIG_INFINIBAND_ISERT=m
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
CONFIG_INFINIBAND_OPA_VNIC=m
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
CONFIG_EDAC_I10NM=m
CONFIG_EDAC_PND2=m
CONFIG_EDAC_IGEN6=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
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
CONFIG_RTC_DRV_88PM860X=m
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=m
# CONFIG_RTC_DRV_ABEOZ9 is not set
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=m
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=m
# CONFIG_RTC_DRV_HYM8563 is not set
CONFIG_RTC_DRV_LP8788=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_MAX8925=m
CONFIG_RTC_DRV_MAX8998=m
CONFIG_RTC_DRV_MAX8997=m
# CONFIG_RTC_DRV_NCT3018Y is not set
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_TWL4030 is not set
CONFIG_RTC_DRV_PALMAS=m
CONFIG_RTC_DRV_TPS6586X=m
CONFIG_RTC_DRV_TPS65910=m
CONFIG_RTC_DRV_RC5T583=m
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=m
CONFIG_RTC_DRV_RX8010=m
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_S5M=m
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
CONFIG_RTC_DRV_M41T94=m
CONFIG_RTC_DRV_DS1302=m
CONFIG_RTC_DRV_DS1305=m
CONFIG_RTC_DRV_DS1343=m
CONFIG_RTC_DRV_DS1347=m
CONFIG_RTC_DRV_DS1390=m
CONFIG_RTC_DRV_MAX6916=m
CONFIG_RTC_DRV_R9701=m
CONFIG_RTC_DRV_RX4581=m
CONFIG_RTC_DRV_RS5C348=m
CONFIG_RTC_DRV_MAX6902=m
CONFIG_RTC_DRV_PCF2123=m
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=m
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y
CONFIG_RTC_DRV_RX6110=m

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=m
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9052=m
CONFIG_RTC_DRV_DA9055=m
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=m
CONFIG_RTC_DRV_M48T86=m
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m
CONFIG_RTC_DRV_WM831X=m
CONFIG_RTC_DRV_WM8350=m
CONFIG_RTC_DRV_PCF50633=m
# CONFIG_RTC_DRV_ZYNQMP is not set
CONFIG_RTC_DRV_CROS_EC=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_CADENCE is not set
CONFIG_RTC_DRV_FTRTC010=m
CONFIG_RTC_DRV_PCAP=m
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_MT6397=m
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_HID_SENSOR_TIME=m
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
# CONFIG_DW_AXI_DMAC is not set
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=y
CONFIG_INTEL_IDXD_BUS=y
CONFIG_INTEL_IDXD=m
CONFIG_INTEL_IDXD_COMPAT=y
CONFIG_INTEL_IDXD_SVM=y
CONFIG_INTEL_IDXD_PERFMON=y
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_AMD_PTDMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=m
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=m
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=m
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

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

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_LINEDISP=m
CONFIG_HD44780_COMMON=m
CONFIG_HD44780=m
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
CONFIG_IMG_ASCII_LCD=m
# CONFIG_HT16K33 is not set
# CONFIG_LCD2S is not set
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_PANEL=m
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
CONFIG_UIO_NETX=m
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO=y
# CONFIG_VFIO_CONTAINER is not set
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
CONFIG_VFIO_PCI_VGA=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_MLX5_VFIO_PCI is not set
CONFIG_VFIO_MDEV=y
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
CONFIG_VBOXGUEST=m
# CONFIG_NITRO_ENCLAVES is not set
# CONFIG_ACRN_HSM is not set
# CONFIG_EFI_SECRET is not set
CONFIG_SEV_GUEST=m
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_SCSI=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
CONFIG_XEN_MEMORY_HOTPLUG_LIMIT=512
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=m
CONFIG_XEN_GRANT_DEV_ALLOC=m
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_PCI_STUB=y
CONFIG_XEN_PCIDEV_BACKEND=m
CONFIG_XEN_PVCALLS_FRONTEND=m
# CONFIG_XEN_PVCALLS_BACKEND is not set
CONFIG_XEN_SCSI_BACKEND=m
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=y
CONFIG_XEN_MCE_LOG=y
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_XEN_UNPOPULATED_ALLOC=y
# CONFIG_XEN_VIRTIO is not set
# end of Xen driver support

CONFIG_GREYBUS=m
CONFIG_GREYBUS_ES2=m
CONFIG_COMEDI=m
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
CONFIG_COMEDI_TEST=m
CONFIG_COMEDI_PARPORT=m
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=m
CONFIG_COMEDI_PCL724=m
CONFIG_COMEDI_PCL726=m
CONFIG_COMEDI_PCL730=m
CONFIG_COMEDI_PCL812=m
CONFIG_COMEDI_PCL816=m
CONFIG_COMEDI_PCL818=m
CONFIG_COMEDI_PCM3724=m
CONFIG_COMEDI_AMPLC_DIO200_ISA=m
CONFIG_COMEDI_AMPLC_PC236_ISA=m
CONFIG_COMEDI_AMPLC_PC263_ISA=m
CONFIG_COMEDI_RTI800=m
CONFIG_COMEDI_RTI802=m
CONFIG_COMEDI_DAC02=m
CONFIG_COMEDI_DAS16M1=m
CONFIG_COMEDI_DAS08_ISA=m
CONFIG_COMEDI_DAS16=m
CONFIG_COMEDI_DAS800=m
CONFIG_COMEDI_DAS1800=m
CONFIG_COMEDI_DAS6402=m
CONFIG_COMEDI_DT2801=m
CONFIG_COMEDI_DT2811=m
CONFIG_COMEDI_DT2814=m
CONFIG_COMEDI_DT2815=m
CONFIG_COMEDI_DT2817=m
CONFIG_COMEDI_DT282X=m
CONFIG_COMEDI_DMM32AT=m
CONFIG_COMEDI_FL512=m
CONFIG_COMEDI_AIO_AIO12_8=m
CONFIG_COMEDI_AIO_IIRO_16=m
CONFIG_COMEDI_II_PCI20KC=m
CONFIG_COMEDI_C6XDIGIO=m
CONFIG_COMEDI_MPC624=m
CONFIG_COMEDI_ADQ12B=m
CONFIG_COMEDI_NI_AT_A2150=m
CONFIG_COMEDI_NI_AT_AO=m
CONFIG_COMEDI_NI_ATMIO=m
CONFIG_COMEDI_NI_ATMIO16D=m
CONFIG_COMEDI_NI_LABPC_ISA=m
CONFIG_COMEDI_PCMAD=m
CONFIG_COMEDI_PCMDA12=m
CONFIG_COMEDI_PCMMIO=m
CONFIG_COMEDI_PCMUIO=m
CONFIG_COMEDI_MULTIQ3=m
CONFIG_COMEDI_S526=m
CONFIG_COMEDI_PCI_DRIVERS=m
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=m
CONFIG_COMEDI_ADDI_APCI_1032=m
CONFIG_COMEDI_ADDI_APCI_1500=m
CONFIG_COMEDI_ADDI_APCI_1516=m
CONFIG_COMEDI_ADDI_APCI_1564=m
CONFIG_COMEDI_ADDI_APCI_16XX=m
CONFIG_COMEDI_ADDI_APCI_2032=m
CONFIG_COMEDI_ADDI_APCI_2200=m
CONFIG_COMEDI_ADDI_APCI_3120=m
CONFIG_COMEDI_ADDI_APCI_3501=m
CONFIG_COMEDI_ADDI_APCI_3XXX=m
CONFIG_COMEDI_ADL_PCI6208=m
CONFIG_COMEDI_ADL_PCI7X3X=m
CONFIG_COMEDI_ADL_PCI8164=m
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
CONFIG_COMEDI_ADV_PCI1724=m
CONFIG_COMEDI_ADV_PCI1760=m
CONFIG_COMEDI_ADV_PCI_DIO=m
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
CONFIG_COMEDI_AMPLC_PC236_PCI=m
CONFIG_COMEDI_AMPLC_PC263_PCI=m
CONFIG_COMEDI_AMPLC_PCI224=m
CONFIG_COMEDI_AMPLC_PCI230=m
CONFIG_COMEDI_CONTEC_PCI_DIO=m
CONFIG_COMEDI_DAS08_PCI=m
CONFIG_COMEDI_DT3000=m
CONFIG_COMEDI_DYNA_PCI10XX=m
CONFIG_COMEDI_GSC_HPDI=m
CONFIG_COMEDI_MF6X4=m
CONFIG_COMEDI_ICP_MULTI=m
CONFIG_COMEDI_DAQBOARD2000=m
CONFIG_COMEDI_JR3_PCI=m
CONFIG_COMEDI_KE_COUNTER=m
CONFIG_COMEDI_CB_PCIDAS64=m
CONFIG_COMEDI_CB_PCIDAS=m
CONFIG_COMEDI_CB_PCIDDA=m
CONFIG_COMEDI_CB_PCIMDAS=m
CONFIG_COMEDI_CB_PCIMDDA=m
CONFIG_COMEDI_ME4000=m
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
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
CONFIG_COMEDI_DAS08_CS=m
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
CONFIG_COMEDI_USBDUXSIGMA=m
CONFIG_COMEDI_VMK80XX=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_ISADMA=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_LABPC_ISADMA=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
CONFIG_PRISM2_USB=m
CONFIG_RTL8192U=m
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
CONFIG_RTL8723BS=m
CONFIG_R8712U=m
CONFIG_R8188EU=m
CONFIG_RTS5208=m
CONFIG_VT6655=m
CONFIG_VT6656=m

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
CONFIG_AD7816=m
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
CONFIG_AD5933=m
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=m
CONFIG_ADE7854_I2C=m
CONFIG_ADE7854_SPI=m
# end of Active energy metering IC

#
# Resolver to digital converters
#
CONFIG_AD2S1210=m
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_FB_SM750=m
CONFIG_STAGING_MEDIA=y
# CONFIG_INTEL_ATOMISP is not set
# CONFIG_VIDEO_IPU3_IMGU is not set
# CONFIG_VIDEO_MAX96712 is not set
# CONFIG_STAGING_MEDIA_DEPRECATED is not set
# CONFIG_STAGING_BOARD is not set
CONFIG_LTE_GDM724X=m
# CONFIG_FB_TFT is not set
# CONFIG_MOST_COMPONENTS is not set
CONFIG_KS7010=m
CONFIG_GREYBUS_AUDIO=m
# CONFIG_GREYBUS_AUDIO_APB_CODEC is not set
CONFIG_GREYBUS_BOOTROM=m
CONFIG_GREYBUS_FIRMWARE=m
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
CONFIG_GREYBUS_POWER=m
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
CONFIG_GREYBUS_PWM=m
CONFIG_GREYBUS_SDIO=m
CONFIG_GREYBUS_SPI=m
CONFIG_GREYBUS_UART=m
CONFIG_GREYBUS_USB=m
CONFIG_PI433=m
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_FIELDBUS_DEV is not set
CONFIG_QLGE=m
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_TSI148=m
CONFIG_VME_FAKE=m

#
# VME Device Drivers
#
CONFIG_VME_USER=m
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=m
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=m
# CONFIG_CROS_EC_I2C is not set
# CONFIG_CROS_EC_RPMSG is not set
# CONFIG_CROS_EC_ISHTP is not set
# CONFIG_CROS_EC_SPI is not set
CONFIG_CROS_EC_LPC=m
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=m
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LIGHTBAR=m
CONFIG_CROS_EC_VBC=m
CONFIG_CROS_EC_DEBUGFS=m
CONFIG_CROS_EC_SENSORHUB=m
CONFIG_CROS_EC_SYSFS=m
CONFIG_CROS_EC_TYPEC=m
# CONFIG_CROS_HPS_I2C is not set
CONFIG_CROS_USBPD_NOTIFY=m
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
CONFIG_CROS_TYPEC_SWITCH=m
# CONFIG_WILCO_EC is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE3_WMI=m
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
CONFIG_SURFACE_PRO3_BUTTON=m
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
CONFIG_MXM_WMI=m
CONFIG_PEAQ_WMI=m
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
CONFIG_ACER_WIRELESS=m
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
CONFIG_ASUS_WIRELESS=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_GPD_POCKET_FAN=m
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_IBM_RTL=m
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_LED is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_IFS=m
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
CONFIG_INTEL_PMC_CORE=y
CONFIG_INTEL_PMT_CLASS=m
CONFIG_INTEL_PMT_TELEMETRY=m
CONFIG_INTEL_PMT_CRASHLOG=m

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_INTERFACE=m
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_TELEMETRY is not set
CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL=m
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_INT0002_VGPIO=m
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_BXTWC_PMIC_TMU is not set
CONFIG_INTEL_CHTDC_TI_PWRBTN=m
# CONFIG_INTEL_CHTWC_INT33FE is not set
# CONFIG_INTEL_ISHTP_ECLITE is not set
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_INTEL_RST=m
CONFIG_INTEL_SDSI=m
CONFIG_INTEL_SMARTCONNECT=m
CONFIG_INTEL_TURBO_MAX_3=y
CONFIG_INTEL_VSEC=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
# CONFIG_SAMSUNG_Q10 is not set
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
CONFIG_TOSHIBA_HAPS=m
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
# CONFIG_TOUCHSCREEN_DMI is not set
# CONFIG_X86_ANDROID_TABLETS is not set
CONFIG_INTEL_IPS=m
CONFIG_INTEL_SCU_IPC=y
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=m
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
CONFIG_COMMON_CLK_CDCE706=m
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=m
CONFIG_COMMON_CLK_S2MPS11=m
CONFIG_CLK_TWL6040=m
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_COMMON_CLK_PALMAS=m
CONFIG_COMMON_CLK_PWM=m
# CONFIG_COMMON_CLK_RS9_PCIE is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_VC7 is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=m
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=m
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
# CONFIG_AMD_IOMMU_DEBUGFS is not set
CONFIG_DMAR_TABLE=y
CONFIG_DMAR_PERF=y
CONFIG_DMAR_DEBUG=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_DEBUGFS=y
CONFIG_INTEL_IOMMU_SVM=y
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IOMMUFD=y
CONFIG_IOMMUFD_VFIO_CONTAINER=y
CONFIG_IOMMUFD_TEST=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
CONFIG_RPMSG_CHAR=m
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_QCOM_GLINK=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_CADENCE=m
CONFIG_SOUNDWIRE_INTEL=m
# CONFIG_SOUNDWIRE_QCOM is not set
CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=m

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
# CONFIG_LITEX_SOC_CONTROLLER is not set
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
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_AXP288=m
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=m
CONFIG_EXTCON_INTEL_INT3496=m
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=m
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX77843=m
CONFIG_EXTCON_MAX8997=m
CONFIG_EXTCON_PALMAS=m
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_CROS_EC=m
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
# CONFIG_IIO_BUFFER_DMA is not set
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
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL355_SPI is not set
# CONFIG_ADXL367_SPI is not set
# CONFIG_ADXL367_I2C is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA220=m
# CONFIG_BMA400 is not set
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
# CONFIG_BMI088_ACCEL is not set
CONFIG_DA280=m
CONFIG_DA311=m
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=m
CONFIG_DMARD10=m
# CONFIG_FXLS8962AF_I2C is not set
# CONFIG_FXLS8962AF_SPI is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
# CONFIG_IIO_KX022A_SPI is not set
# CONFIG_IIO_KX022A_I2C is not set
CONFIG_KXSD9=m
CONFIG_KXSD9_SPI=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7455_SPI=m
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
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
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
CONFIG_AD7192=m
CONFIG_AD7266=m
CONFIG_AD7280=m
CONFIG_AD7291=m
# CONFIG_AD7292 is not set
CONFIG_AD7298=m
CONFIG_AD7476=m
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD7606_IFACE_SPI=m
CONFIG_AD7766=m
# CONFIG_AD7768_1 is not set
CONFIG_AD7780=m
CONFIG_AD7791=m
CONFIG_AD7793=m
CONFIG_AD7887=m
CONFIG_AD7923=m
# CONFIG_AD7949 is not set
CONFIG_AD799X=m
# CONFIG_ADI_AXI_ADC is not set
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
CONFIG_CC10001_ADC=m
CONFIG_DA9150_GPADC=m
CONFIG_DLN2_ADC=m
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_HI8435=m
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=m
# CONFIG_LTC2496 is not set
CONFIG_LTC2497=m
CONFIG_MAX1027=m
CONFIG_MAX11100=m
CONFIG_MAX1118=m
# CONFIG_MAX11205 is not set
# CONFIG_MAX11410 is not set
# CONFIG_MAX1241 is not set
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP320X=m
CONFIG_MCP3422=m
# CONFIG_MCP3911 is not set
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
CONFIG_PALMAS_GPADC=m
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_SPMI_IADC=m
CONFIG_QCOM_SPMI_VADC=m
# CONFIG_QCOM_SPMI_ADC5 is not set
# CONFIG_RICHTEK_RTQ6056 is not set
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_TI_ADC081C=m
CONFIG_TI_ADC0832=m
CONFIG_TI_ADC084S021=m
CONFIG_TI_ADC12138=m
CONFIG_TI_ADC108S102=m
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=m
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS7950=m
# CONFIG_TI_ADS8344 is not set
# CONFIG_TI_ADS8688 is not set
# CONFIG_TI_ADS124S08 is not set
# CONFIG_TI_ADS131E08 is not set
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=m
# CONFIG_TI_TSC2046 is not set
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=m
# CONFIG_VF610_ADC is not set
CONFIG_VIPERBOARD_ADC=m
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_AD74115 is not set
# CONFIG_AD74413R is not set
CONFIG_STX104=m
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
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
CONFIG_IAQCORE=m
# CONFIG_PMS7003 is not set
# CONFIG_SCD30_CORE is not set
# CONFIG_SCD4X is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SENSIRION_SGP40 is not set
# CONFIG_SPS30_I2C is not set
# CONFIG_SPS30_SERIAL is not set
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
CONFIG_VZ89X=m
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m
# CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE is not set

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
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
CONFIG_AD5064=m
CONFIG_AD5360=m
CONFIG_AD5380=m
CONFIG_AD5421=m
CONFIG_AD5446=m
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
CONFIG_AD5593R=m
CONFIG_AD5504=m
CONFIG_AD5624R_SPI=m
# CONFIG_LTC2688 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
CONFIG_AD5755=m
# CONFIG_AD5758 is not set
CONFIG_AD5761=m
CONFIG_AD5764=m
# CONFIG_AD5766 is not set
# CONFIG_AD5770R is not set
CONFIG_AD5791=m
# CONFIG_AD7293 is not set
CONFIG_AD7303=m
CONFIG_AD8801=m
CONFIG_CIO_DAC=m
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
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=m
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
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
CONFIG_AD9523=m
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m
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
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
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
CONFIG_MAX30100=m
CONFIG_MAX30102=m
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
# CONFIG_HDC2010 is not set
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16475 is not set
CONFIG_ADIS16480=m
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BMI160_SPI=m
# CONFIG_BOSCH_BNO055_SERIAL is not set
# CONFIG_BOSCH_BNO055_I2C is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
CONFIG_KMX61=m
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_ICM42600_SPI is not set
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
# CONFIG_IIO_ST_LSM9DS0 is not set
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=m
CONFIG_ADJD_S311=m
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=m
# CONFIG_AS73211 is not set
CONFIG_BH1750=m
CONFIG_BH1780=m
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
# CONFIG_CM3605 is not set
CONFIG_CM36651=m
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=m
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
# CONFIG_LTRF216A is not set
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=m
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=m
CONFIG_PA12203001=m
# CONFIG_SI1133 is not set
CONFIG_SI1145=m
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
# CONFIG_TSL2591 is not set
# CONFIG_TSL2772 is not set
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=m
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
CONFIG_MAG3110=m
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_HMC5843_SPI=m
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
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
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE is not set
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
# CONFIG_AD5272 is not set
CONFIG_DS1803=m
# CONFIG_MAX5432 is not set
CONFIG_MAX5481=m
CONFIG_MAX5487=m
# CONFIG_MCP4018 is not set
CONFIG_MCP4131=m
CONFIG_MCP4531=m
# CONFIG_MCP41010 is not set
CONFIG_TPL0102=m
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
CONFIG_IIO_CROS_EC_BARO=m
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=m
# CONFIG_ICP10100 is not set
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL115_SPI=m
CONFIG_MPL3115=m
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5611_SPI=m
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_IIO_ST_PRESS_SPI=m
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
# CONFIG_CROS_EC_MKBP_PROXIMITY is not set
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=m
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
CONFIG_RFD77402=m
CONFIG_SRF04=m
# CONFIG_SX9310 is not set
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
CONFIG_SX9500=m
CONFIG_SRF08=m
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
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
# CONFIG_LTC2983 is not set
CONFIG_MAXIM_THERMOCOUPLE=m
CONFIG_HID_SENSOR_TEMP=m
CONFIG_MLX90614=m
# CONFIG_MLX90632 is not set
CONFIG_TMP006=m
CONFIG_TMP007=m
# CONFIG_TMP117 is not set
CONFIG_TSYS01=m
CONFIG_TSYS02D=m
# CONFIG_MAX30208 is not set
# CONFIG_MAX31856 is not set
# CONFIG_MAX31865 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
CONFIG_NTB_IDT=m
CONFIG_NTB_INTEL=m
# CONFIG_NTB_EPF is not set
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_CRC is not set
CONFIG_PWM_CROS_EC=m
CONFIG_PWM_DWC=m
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_INTEL_LGM is not set
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
CONFIG_PWM_PCA9685=m
CONFIG_PWM_TWL=m
CONFIG_PWM_TWL_LED=m
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_SIMPLE is not set
CONFIG_RESET_TI_SYSCON=m
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
CONFIG_BCM_KONA_USB2_PHY=m
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_CADENCE_SALVO is not set
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_CPCAP_USB=m
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_QCOM_USB_HS=m
CONFIG_PHY_QCOM_USB_HSIC=m
CONFIG_PHY_SAMSUNG_USB2=m
CONFIG_PHY_TUSB1210=m
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
CONFIG_MCB=m
CONFIG_MCB_PCI=m
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_RAS_CEC_DEBUG is not set
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_OF_PMEM=m
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RAVE_SP_EEPROM is not set
# CONFIG_NVMEM_RMEM is not set
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_NVMEM_U_BOOT_ENV is not set

#
# HW tracing support
#
CONFIG_STM=m
CONFIG_STM_PROTO_BASIC=m
CONFIG_STM_PROTO_SYS_T=m
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_MGR_XILINX_SPI=m
# CONFIG_FPGA_MGR_ICE40_SPI is not set
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
CONFIG_FPGA_BRIDGE=m
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_OF_FPGA_REGION is not set
# CONFIG_FPGA_DFL is not set
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
# CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI is not set
# CONFIG_FSI is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
# CONFIG_104_QUAD_8 is not set
# CONFIG_INTERRUPT_CNT is not set
# CONFIG_FTM_QUADDEC is not set
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
CONFIG_INTEL_QEP=y
CONFIG_MOST=m
# CONFIG_MOST_USB_HDM is not set
# CONFIG_MOST_CDEV is not set
# CONFIG_MOST_SND is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=y
CONFIG_FUSE_DAX=y
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
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
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=m
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
CONFIG_JFFS2_FS_SECURITY=y
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_LZO=y
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_PRIORITY is not set
# CONFIG_JFFS2_CMODE_SIZE is not set
CONFIG_JFFS2_CMODE_FAVOURLZO=y
CONFIG_UBIFS_FS=m
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_CRAMFS_MTD=y
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_OMFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
CONFIG_QNX6FS_FS=m
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_BLOCK=y
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=y
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
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_FTRACE=y
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
# CONFIG_EROFS_FS is not set
# CONFIG_VBOXSF_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_SWAP=y
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=y
CONFIG_PNFS_BLOCK=y
CONFIG_PNFS_FLEXFILE_LAYOUT=y
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
CONFIG_NFS_V4_1_MIGRATION=y
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
CONFIG_NFSD_BLOCKLAYOUT=y
CONFIG_NFSD_SCSILAYOUT=y
CONFIG_NFSD_FLEXFILELAYOUT=y
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_SUNRPC_SWAP=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
CONFIG_CEPH_FSCACHE=y
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
CONFIG_CIFS_FSCACHE=y
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
CONFIG_CODA_FS=m
CONFIG_AFS_FS=m
# CONFIG_AFS_DEBUG is not set
CONFIG_AFS_FSCACHE=y
# CONFIG_AFS_DEBUG_CURSOR is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
CONFIG_9P_FS_SECURITY=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=y
CONFIG_DLM=m
# CONFIG_DLM_DEPRECATED_API is not set
# CONFIG_DLM_DEBUG is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_INFINIBAND=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=0
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
CONFIG_SECURITY_SMACK=y
# CONFIG_SECURITY_SMACK_BRINGUP is not set
CONFIG_SECURITY_SMACK_NETFILTER=y
CONFIG_SECURITY_SMACK_APPEND_SIGNALS=y
CONFIG_SECURITY_TOMOYO=y
CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
# CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
CONFIG_SECURITY_TOMOYO_POLICY_LOADER="/sbin/tomoyo-init"
CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER="/sbin/init"
# CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
# CONFIG_IMA_KEXEC is not set
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
CONFIG_EVM_EXTRA_SMACK_XATTRS=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_SMACK is not set
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="yama,loadpin,integrity"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_ENGINE=m
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
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
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
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
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=m
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
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
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
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
CONFIG_XZ_DEC_TEST=m
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
CONFIG_BCH=m
CONFIG_BCH_CONST_PARAMS=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
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
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=m
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
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
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=m
CONFIG_OBJAGG=m
# end of Library routines

CONFIG_PLDMFW=y
CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
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
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_BTF is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_FRAME_POINTER=y
CONFIG_OBJTOOL=y
CONFIG_STACK_VALIDATION=y
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
CONFIG_KGDB=y
CONFIG_KGDB_HONOUR_BLOCKLIST=y
CONFIG_KGDB_SERIAL_CONSOLE=y
# CONFIG_KGDB_TESTS is not set
CONFIG_KGDB_LOW_LEVEL_TRAP=y
CONFIG_KGDB_KDB=y
CONFIG_KDB_DEFAULT_ENABLE=0x1
CONFIG_KDB_KEYBOARD=y
CONFIG_KDB_CONTINUE_CATASTROPHIC=0
CONFIG_ARCH_HAS_EARLY_DEBUG=y
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
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
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_TEST=m
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
# CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
# CONFIG_KASAN_VMALLOC is not set
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=140
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
CONFIG_DEBUG_PREEMPT=y

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
CONFIG_SCF_TORTURE_TEST=m
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
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
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=100
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_LATENCYTOP is not set
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
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
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
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
CONFIG_MMIOTRACE=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
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
# CONFIG_MMIOTRACE_TEST is not set
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
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=m
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
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
# CONFIG_TEST_PARMAN is not set
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
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_OBJAGG is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
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

--b3rEXDtV+UP6p3C9
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment;
	filename="4ec5183ec48656cec489c49f989c508b68b518e3_dmesg.log"
Content-Transfer-Encoding: quoted-printable

=1Bc=1B[?7l=1B[2J=1B[0mSeaBIOS (version rel-1.14.0-0-g155821a1990b-prebuilt=
.qemu.org)=0D


iPXE (http://ipxe.org) 00:03.0 CA00 PCI2.10 PnP PMM+7FF8F030+7FEEF030 CA00=
=0D
Press Ctrl-B to configure iPXE (PCI 00:03.0)...=0D                         =
                                                      =0D


Booting from ROM..=1Bc=1B[?7l=1B[2J[    0.000000] Linux version 6.2.0-rc7-4=
ec5183ec486 (root@p-mtlp02) (gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-18), G=
NU ld version 2.36.1-2.el8) #1 SMP PREEMPT_DYNAMIC Mon Feb  6 10:18:07 CST =
2023=0D
[    0.000000] Command line: console=3DttyS0 root=3D/dev/sda earlyprintk=3D=
serial net.ifnames=3D0=0D
[    0.000000] KERNEL supported cpus:=0D
[    0.000000]   Intel GenuineIntel=0D
[    0.000000]   AMD AuthenticAMD=0D
[    0.000000]   Hygon HygonGenuine=0D
[    0.000000]   Centaur CentaurHauls=0D
[    0.000000]   zhaoxin   Shanghai  =0D
[    0.000000] x86/split lock detection: #DB: warning on user-space bus_loc=
ks=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'=0D
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256=0D
[    0.000000] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8=0D
[    0.000000] x86/fpu: Enabled xstate features 0x207, context size is 840 =
bytes, using 'compacted' format.=0D
[    0.000000] signal: max sigframe size: 3632=0D
[    0.000000] BIOS-provided physical RAM map:=0D
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usabl=
e=0D
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usabl=
e=0D
[    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved=0D
[    0.000000] printk: bootconsole [earlyser0] enabled=0D
[    0.000000] NX (Execute Disable) protection: active=0D
[    0.000000] SMBIOS 2.8 present.=0D
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0=
-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[    0.000000] Hypervisor detected: KVM=0D
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00=0D
[    0.000006] kvm-clock: using sched offset of 737340638 cycles=0D
[    0.000465] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles:=
 0x1cd42e4dffb, max_idle_ns: 881590591483 ns=0D
[    0.001881] tsc: Detected 1190.400 MHz processor=0D
[    0.010096] last_pfn =3D 0x7ffe0 max_arch_pfn =3D 0x400000000=0D
[    0.010628] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
  =0D
[    0.022781] found SMP MP-table at [mem 0x000f5a90-0x000f5a9f]=0D
[    0.023429] Using GB pages for direct mapping=0D
[    0.025570] ACPI: Early table checksum verification disabled=0D
[    0.026091] ACPI: RSDP 0x00000000000F5870 000014 (v00 BOCHS )=0D
[    0.026639] ACPI: RSDT 0x000000007FFE1959 000034 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.027451] ACPI: FACP 0x000000007FFE1805 000074 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.028257] ACPI: DSDT 0x000000007FFE0040 0017C5 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.029041] ACPI: FACS 0x000000007FFE0000 000040=0D
[    0.029483] ACPI: APIC 0x000000007FFE1879 000080 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.030266] ACPI: HPET 0x000000007FFE18F9 000038 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.031058] ACPI: WAET 0x000000007FFE1931 000028 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.031839] ACPI: Reserving FACP table memory at [mem 0x7ffe1805-0x7ffe1=
878]=0D
[    0.032474] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe1=
804]=0D
[    0.033105] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe0=
03f]=0D
[    0.033738] ACPI: Reserving APIC table memory at [mem 0x7ffe1879-0x7ffe1=
8f8]=0D
[    0.034370] ACPI: Reserving HPET table memory at [mem 0x7ffe18f9-0x7ffe1=
930]=0D
[    0.035007] ACPI: Reserving WAET table memory at [mem 0x7ffe1931-0x7ffe1=
958]=0D
[    0.036688] No NUMA configuration found=0D
[    0.037040] Faking a node at [mem 0x0000000000000000-0x000000007ffdffff]=
=0D
[    0.037731] NODE_DATA(0) allocated [mem 0x7ffb5000-0x7ffdffff]=0D
[    0.082177] Zone ranges:=0D
[    0.082446]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]=0D
[    0.083019]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]=0D
[    0.083583]   Normal   empty=0D
[    0.083886]   Device   empty=0D
[    0.084151] Movable zone start for each node=0D
[    0.084535] Early memory node ranges=0D
[    0.084857]   node   0: [mem 0x0000000000001000-0x000000000009efff]=0D
[    0.085425]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]=0D
[    0.085993] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdf=
fff]=0D
[    0.086642] On node 0, zone DMA: 1 pages in unavailable ranges=0D
[    0.086746] On node 0, zone DMA: 97 pages in unavailable ranges=0D
[    0.099483] On node 0, zone DMA32: 32 pages in unavailable ranges=0D
[    0.372392] kasan: KernelAddressSanitizer initialized=0D
[    0.373733] ACPI: PM-Timer IO Port: 0x608=0D
[    0.374154] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])=0D
[    0.374773] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23=0D
[    0.375413] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)=0D
[    0.375985] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)=
=0D
[    0.376578] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)=
=0D
[    0.377173] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level=
)=0D
[    0.377777] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level=
)=0D
[    0.378407] ACPI: Using ACPI (MADT) for SMP configuration information=0D
[    0.378983] ACPI: HPET id: 0x8086a201 base: 0xfed00000=0D
[    0.379465] TSC deadline timer available=0D
[    0.379820] smpboot: Allowing 2 CPUs, 0 hotplug CPUs=0D
[    0.380363] kvm-guest: KVM setup pv remote TLB flush=0D
[    0.380810] kvm-guest: setup PV sched yield=0D
[    0.381272] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]=0D
[    0.381951] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x0009ffff]=0D
[    0.382623] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000effff]=0D
[    0.383294] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0=
x000fffff]=0D
[    0.383968] [mem 0x80000000-0xfeffbfff] available for PCI devices=0D
[    0.384512] Booting paravirtualized kernel on KVM=0D
[    0.384954] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns=0D
[    0.385908] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr=
_node_ids:1=0D
[    0.389039] percpu: Embedded 80 pages/cpu s290816 r8192 d28672 u1048576=
=0D
[    0.389943] kvm-guest: PV spinlocks enabled=0D
[    0.390338] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, =
linear)=0D
[    0.391092] Fallback order for Node 0: 0 =0D
[    0.391490] Built 1 zonelists, mobility grouping on.  Total pages: 51580=
8=0D
[    0.392101] Policy zone: DMA32=0D
[    0.392382] Kernel command line: net.ifnames=3D0 console=3DttyS0 root=3D=
/dev/sda earlyprintk=3Dserial net.ifnames=3D0=0D
[    0.394161] random: crng init done=0D
[    0.398980] Dentry cache hash table entries: 262144 (order: 9, 2097152 b=
ytes, linear)=0D
[    0.400528] Inode-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, linear)=0D
[    0.401813] mem auto-init: stack:off, heap alloc:off, heap free:off=0D
[    0.409879] stackdepot hash table entries: 1048576 (order: 11, 8388608 b=
ytes, linear)=0D
[    0.454190] Memory: 1631824K/2096632K available (71680K kernel code, 140=
07K rwdata, 16476K rodata, 14104K init, 20784K bss, 464552K reserved, 0K cm=
a-reserved)=0D
[    0.456454] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1=0D
[    0.457029] kmemleak: Kernel memory leak detector disabled=0D
[    0.457703] ftrace: allocating 68501 entries in 268 pages=0D
[    0.503945] ftrace: allocated 268 pages with 3 groups=0D
[    0.510769] Dynamic Preempt: voluntary=0D
[    0.511508] Running RCU self tests=0D
[    0.511823] rcu: Preemptible hierarchical RCU implementation.=0D
[    0.512317] rcu: 	RCU lockdep checking is enabled.=0D
[    0.512727] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D2.=0D
[    0.513312] 	Trampoline variant of Tasks RCU enabled.=0D
[    0.513745] 	Rude variant of Tasks RCU enabled.=0D
[    0.514134] 	Tracing variant of Tasks RCU enabled.=0D
[    0.514547] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.=0D
[    0.515200] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2=0D
[    0.565139] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16=0D
[    0.566181] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.=0D
[    0.574848] Console: colour VGA+ 80x25=0D
[    0.575257] printk: console [ttyS0] enabled=0D
[    0.575257] printk: console [ttyS0] enabled=0D
[    0.576000] printk: bootconsole [earlyser0] disabled=0D
[    0.576000] printk: bootconsole [earlyser0] disabled=0D
[    0.576880] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar=0D
[    0.577561] ... MAX_LOCKDEP_SUBCLASSES:  8=0D
[    0.577927] ... MAX_LOCK_DEPTH:          48=0D
[    0.578305] ... MAX_LOCKDEP_KEYS:        8192=0D
[    0.578695] ... CLASSHASH_SIZE:          4096=0D
[    0.579089] ... MAX_LOCKDEP_ENTRIES:     32768=0D
[    0.579490] ... MAX_LOCKDEP_CHAINS:      65536=0D
[    0.579885] ... CHAINHASH_SIZE:          32768=0D
[    0.580282]  memory used by lock dependency info: 6365 kB=0D
[    0.580762]  memory used for stack traces: 4224 kB=0D
[    0.581188]  per task-struct memory footprint: 1920 bytes=0D
[    0.581755] ACPI: Core revision 20221020=0D
[    0.582583] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 19112604467 ns=0D
[    0.583654] APIC: Switch to symmetric I/O mode setup=0D
[    0.584314] x2apic enabled=0D
[    0.584774] Switched APIC routing to physical x2apic.=0D
[    0.585236] kvm-guest: setup PV IPIs=0D
[    0.586731] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1=0D
[    0.587321] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x1128af0325d, max_idle_ns: 440795261011 ns=0D
[    0.588342] Calibrating delay loop (skipped) preset value.. 2380.80 Bogo=
MIPS (lpj=3D4761600)=0D
[    0.589092] pid_max: default: 32768 minimum: 301=0D
[    0.589734] LSM: initializing lsm=3Dcapability,yama,integrity=0D
[    0.590268] Yama: becoming mindful.=0D
[    0.590958] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes,=
 linear)=0D
[    0.592326] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 b=
ytes, linear)=0D
[    0.594993] CPU0: Thermal monitoring enabled (TM1)=0D
[    0.596356] x86/cpu: User Mode Instruction Prevention (UMIP) activated=
=0D
[    0.597563] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0=0D
[    0.598103] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0=0D
[    0.598701] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization=0D
[    0.599476] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
[    0.600333] Spectre V2 : Mitigation: Enhanced IBRS=0D
[    0.600755] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch=0D
[    0.601465] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT=0D
[    0.602117] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier=0D
[    0.602847] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl=0D
[    0.604319] MMIO Stale Data: Unknown: No mitigations=0D
[    0.775079] Freeing SMP alternatives memory: 56K=0D
[    0.776164] smpboot: CPU0: Genuine Intel(R) 0000 (family: 0x6, model: 0x=
aa, stepping: 0x1)=0D
[    0.776314] cblist_init_generic: Setting adjustable number of callback q=
ueues.=0D
[    0.776314] cblist_init_generic: Setting shift to 1 and lim to 1.=0D
[    0.776417] cblist_init_generic: Setting shift to 1 and lim to 1.=0D
[    0.777036] cblist_init_generic: Setting shift to 1 and lim to 1.=0D
[    0.777666] Running RCU-tasks wait API self tests=0D
[    0.880539] Performance Events: generic architected perfmon, full-width =
counters, Intel PMU driver.=0D
[    0.881449] ... version:                2=0D
[    0.881799] ... bit width:              48=0D
[    0.882153] ... generic registers:      8=0D
[    0.882499] ... value mask:             0000ffffffffffff=0D
[    0.882955] ... max period:             00007fffffffffff=0D
[    0.883411] ... fixed-purpose events:   3=0D
[    0.883758] ... event mask:             00000007000000ff=0D
[    0.884977] rcu: Hierarchical SRCU implementation.=0D
[    0.885392] rcu: 	Max phase no-delay instances is 1000.=0D
[    0.890205] smp: Bringing up secondary CPUs ...=0D
[    0.891418] x86: Booting SMP configuration:=0D
[    0.891799] .... node  #0, CPUs:      #1=0D
[    0.017531] smpboot: CPU 1 Converting physical 0 to logical die 1=0D
[    0.896585] smp: Brought up 1 node, 2 CPUs=0D
[    0.896908] smpboot: Max logical packages: 2=0D
[    0.897276] smpboot: Total of 2 processors activated (4761.60 BogoMIPS)=
=0D
[    0.902420] devtmpfs: initialized=0D
[    0.904371] Callback from call_rcu_tasks_trace() invoked.=0D
[    0.905559] x86/mm: Memory block size: 128MB=0D
[    0.917139] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns=0D
[    0.918021] futex hash table entries: 512 (order: 4, 65536 bytes, linear=
)=0D
[    0.919151] pinctrl core: initialized pinctrl subsystem=0D
[    0.921538] =0D
[    0.921685] ************************************************************=
*=0D
[    0.922259] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    *=
*=0D
[    0.922844] **                                                         *=
*=0D
[    0.923418] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  *=
*=0D
[    0.923993] **                                                         *=
*=0D
[    0.924325] ** This means that this kernel is built to expose internal *=
*=0D
[    0.924903] ** IOMMU data structures, which may compromise security on *=
*=0D
[    0.925476] ** your system.                                            *=
*=0D
[    0.926052] **                                                         *=
*=0D
[    0.926628] ** If you see this message and you are not debugging the   *=
*=0D
[    0.927203] ** kernel, report this immediately to your vendor!         *=
*=0D
[    0.927780] **                                                         *=
*=0D
[    0.928319] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    *=
*=0D
[    0.928892] ************************************************************=
*=0D
[    0.929536] PM: RTC time: 12:53:40, date: 2023-02-06=0D
[    0.935371] NET: Registered PF_NETLINK/PF_ROUTE protocol family=0D
[    0.937085] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocat=
ions=0D
[    0.937743] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic=
 allocations=0D
[    0.938445] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atom=
ic allocations=0D
[    0.939227] audit: initializing netlink subsys (disabled)=0D
[    0.939827] audit: type=3D2000 audit(1675688021.286:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1=0D
[    0.944709] thermal_sys: Registered thermal governor 'fair_share'=0D
[    0.944720] thermal_sys: Registered thermal governor 'bang_bang'=0D
[    0.945254] thermal_sys: Registered thermal governor 'step_wise'=0D
[    0.945772] thermal_sys: Registered thermal governor 'user_space'=0D
[    0.946373] cpuidle: using governor ladder=0D
[    0.947268] cpuidle: using governor menu=0D
[    0.948165] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5=0D
[    0.948991] PCI: Using configuration type 1 for base access=0D
[    0.950912] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.=0D
[    1.212842] Callback from call_rcu_tasks_rude() invoked.=0D
[    1.261123] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 page=
s=0D
[    1.261728] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page=
=0D
[    1.262297] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s=0D
[    1.262873] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page=0D
[    1.269192] ACPI: Added _OSI(Module Device)=0D
[    1.269537] ACPI: Added _OSI(Processor Device)=0D
[    1.269869] ACPI: Added _OSI(3.0 _SCP Extensions)=0D
[    1.270218] ACPI: Added _OSI(Processor Aggregator Device)=0D
[    1.287357] ACPI: 1 ACPI AML tables successfully acquired and loaded=0D
[    1.294687] ACPI: Interpreter enabled=0D
[    1.295209] ACPI: PM: (supports S0 S3 S4 S5)=0D
[    1.295584] ACPI: Using IOAPIC for interrupt routing=0D
[    1.296136] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug=0D
[    1.296321] PCI: Using E820 reservations for host bridge windows=0D
[    1.298236] ACPI: Enabled 2 GPEs in block 00 to 0F=0D
[    1.316440] Callback from call_rcu_tasks() invoked.=0D
[    1.337397] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])=0D
[    1.337990] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I EDR HPX-Type3]=0D
[    1.338698] acpi PNP0A03:00: _OSC: not requesting OS control; OS require=
s [ExtendedConfig ASPM ClockPM MSI]=0D
[    1.339716] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended configuration space under this bridge=0D
[    1.345864] acpiphp: Slot [3] registered=0D
[    1.346340] acpiphp: Slot [4] registered=0D
[    1.346821] acpiphp: Slot [5] registered=0D
[    1.347328] acpiphp: Slot [6] registered=0D
[    1.347814] acpiphp: Slot [7] registered=0D
[    1.348292] acpiphp: Slot [8] registered=0D
[    1.348479] acpiphp: Slot [9] registered=0D
[    1.348984] acpiphp: Slot [10] registered=0D
[    1.349534] acpiphp: Slot [11] registered=0D
[    1.350052] acpiphp: Slot [12] registered=0D
[    1.350540] acpiphp: Slot [13] registered=0D
[    1.351067] acpiphp: Slot [14] registered=0D
[    1.351558] acpiphp: Slot [15] registered=0D
[    1.352058] acpiphp: Slot [16] registered=0D
[    1.352460] acpiphp: Slot [17] registered=0D
[    1.353423] acpiphp: Slot [18] registered=0D
[    1.353927] acpiphp: Slot [19] registered=0D
[    1.354425] acpiphp: Slot [20] registered=0D
[    1.354919] acpiphp: Slot [21] registered=0D
[    1.355431] acpiphp: Slot [22] registered=0D
[    1.355918] acpiphp: Slot [23] registered=0D
[    1.356421] acpiphp: Slot [24] registered=0D
[    1.356913] acpiphp: Slot [25] registered=0D
[    1.357428] acpiphp: Slot [26] registered=0D
[    1.357914] acpiphp: Slot [27] registered=0D
[    1.358402] acpiphp: Slot [28] registered=0D
[    1.358897] acpiphp: Slot [29] registered=0D
[    1.359406] acpiphp: Slot [30] registered=0D
[    1.359895] acpiphp: Slot [31] registered=0D
[    1.360322] PCI host bridge to bus 0000:00=0D
[    1.360687] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]=0D
[    1.361277] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]=0D
[    1.361864] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]=0D
[    1.362529] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebffff=
f window]=0D
[    1.363172] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17ffff=
fff window]=0D
[    1.363830] pci_bus 0000:00: root bus resource [bus 00-ff]=0D
[    1.364525] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=0D
[    1.375008] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100=0D
[    1.376875] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180=0D
[    1.378754] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]=0D
[    1.379864] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]=0D
[    1.380324] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]=
=0D
[    1.380883] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]=0D
[    1.381556] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]=
=0D
[    1.382582] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=0D
[    1.383467] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX=
4 ACPI=0D
[    1.384097] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX=
4 SMB=0D
[    1.384830] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000=0D
[    1.389029] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]=
=0D
[    1.391228] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]=0D
[    1.395245] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]=
=0D
[    1.396165] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]=0D
[    1.406769] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000=0D
[    1.407786] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]=0D
[    1.408720] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]=0D
[    1.411130] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]=
=0D
[    1.434613] ACPI: PCI: Interrupt link LNKA configured for IRQ 10=0D
[    1.436227] ACPI: PCI: Interrupt link LNKB configured for IRQ 10=0D
[    1.437311] ACPI: PCI: Interrupt link LNKC configured for IRQ 11=0D
[    1.438862] ACPI: PCI: Interrupt link LNKD configured for IRQ 11=0D
[    1.439794] ACPI: PCI: Interrupt link LNKS configured for IRQ 9=0D
[    1.443631] iommu: Default domain type: Translated =0D
[    1.444068] iommu: DMA domain TLB invalidation policy: lazy mode =0D
[    1.447788] SCSI subsystem initialized=0D
[    1.448880] ACPI: bus type USB registered=0D
[    1.449399] usbcore: registered new interface driver usbfs=0D
[    1.449951] usbcore: registered new interface driver hub=0D
[    1.450473] usbcore: registered new device driver usb=0D
[    1.451256] pps_core: LinuxPPS API ver. 1 registered=0D
[    1.451675] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>=0D
[    1.452350] PTP clock support registered=0D
[    1.453021] EDAC MC: Ver: 3.0.0=0D
[    1.456899] NetLabel: Initializing=0D
[    1.457198] NetLabel:  domain hash size =3D 128=0D
[    1.457565] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO=0D
[    1.458240] NetLabel:  unlabeled traffic allowed by default=0D
[    1.492852] PCI: Using ACPI for IRQ routing=0D
[    1.493703] pci 0000:00:02.0: vgaarb: setting as boot VGA device=0D
[    1.494228] pci 0000:00:02.0: vgaarb: bridge control possible=0D
[    1.494709] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone=0D
[    1.495419] vgaarb: loaded=0D
[    1.496745] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0=0D
[    1.497195] hpet0: 3 comparators, 64-bit 100.000000 MHz counter=0D
[    4.227273] clocksource: Switched to clocksource kvm-clock=0D
[    4.227908] VFS: Disk quotas dquot_6.6.0=0D
[    4.227908] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)=0D
[    4.228570] pnp: PnP ACPI init=0D
[    4.233150] pnp: PnP ACPI: found 6 devices=0D
[    4.254508] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns=0D
[    4.255958] NET: Registered PF_INET protocol family=0D
[    4.257158] IP idents hash table entries: 32768 (order: 6, 262144 bytes,=
 linear)=0D
[    4.259612] tcp_listen_portaddr_hash hash table entries: 1024 (order: 4,=
 73728 bytes, linear)=0D
[    4.260456] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)=0D
[    4.261193] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes, linear)=0D
[    4.262555] TCP bind hash table entries: 16384 (order: 9, 2359296 bytes,=
 linear)=0D
[    4.265736] TCP: Hash tables configured (established 16384 bind 16384)=
=0D
[    4.266623] UDP hash table entries: 1024 (order: 5, 163840 bytes, linear=
)=0D
[    4.267371] UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes, l=
inear)=0D
[    4.268647] NET: Registered PF_UNIX/PF_LOCAL protocol family=0D
[    4.270130] RPC: Registered named UNIX socket transport module.=0D
[    4.270665] RPC: Registered udp transport module.=0D
[    4.271068] RPC: Registered tcp transport module.=0D
[    4.271473] RPC: Registered tcp NFSv4.1 backchannel transport module.=0D
[    4.272074] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]=0D
[    4.272645] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]=0D
[    4.273189] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]=0D
[    4.273780] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff windo=
w]=0D
[    4.274369] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff win=
dow]=0D
[    4.275418] pci 0000:00:01.0: PIIX3: Enabling Passive Release=0D
[    4.275935] pci 0000:00:00.0: Limiting direct PCI/PCI transfers=0D
[    4.276578] PCI: CLS 0 bytes, default 64=0D
[    4.277044] ACPI: bus type thunderbolt registered=0D
[    4.277944] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x112=
8af0325d, max_idle_ns: 440795261011 ns=0D
[    4.508223] Initialise system trusted keyrings=0D
[    4.508839] Key type blacklist registered=0D
[    4.509817] workingset: timestamp_bits=3D36 max_order=3D19 bucket_order=
=3D0=0D
[    4.510504] zbud: loaded=0D
[    4.512391] squashfs: version 4.0 (2009/01/31) Phillip Lougher=0D
[    4.515026] NFS: Registering the id_resolver key type=0D
[    4.515507] Key type id_resolver registered=0D
[    4.515872] Key type id_legacy registered=0D
[    4.516276] nfs4filelayout_init: NFSv4 File Layout Driver Registering...=
=0D
[    4.516916] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering...=0D
[    4.517832] fuse: init (API version 7.38)=0D
[    4.518505] SGI XFS with ACLs, security attributes, realtime, quota, no =
debug enabled=0D
[    4.521030] 9p: Installing v9fs 9p2000 file system support=0D
[    4.529513] Key type asymmetric registered=0D
[    4.529890] Asymmetric key parser 'x509' registered=0D
[    4.530456] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 243)=0D
[    4.531627] io scheduler mq-deadline registered=0D
[    4.532128] io scheduler bfq registered=0D
[    4.533975] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4=
=0D
[    4.535401] IPMI message handler: version 39.2=0D
[    4.535871] ipmi device interface=0D
[    4.538813] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0=0D
[    4.539894] ACPI: button: Power Button [PWRF]=0D
[    4.542592] ERST DBG: ERST support is disabled.=0D
[    4.545016] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled=0D
[    4.546550] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A=0D
[    4.565047] Linux agpgart interface v0.103=0D
[    4.567407] ACPI: bus type drm_connector registered=0D
[    4.589506] brd: module loaded=0D
[    4.602529] loop: module loaded=0D
[    4.613883] scsi host0: ata_piix=0D
[    4.615497] scsi host1: ata_piix=0D
[    4.616133] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 1=
4=0D
[    4.616740] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 1=
5=0D
[    4.619404] tun: Universal TUN/TAP device driver, 1.6=0D
[    4.620184] e100: Intel(R) PRO/100 Network Driver=0D
[    4.620618] e100: Copyright(c) 1999-2006 Intel Corporation=0D
[    4.621162] e1000: Intel(R) PRO/1000 Network Driver=0D
[    4.621587] e1000: Copyright (c) 1999-2006 Intel Corporation.=0D
[    4.776666] ata1: found unknown device (class 0)=0D
[    4.777768] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100=0D
[    4.778273] ata1.00: 16777216 sectors, multi 16: LBA48 =0D
[    4.779014] ata2: found unknown device (class 0)=0D
[    4.780003] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100=0D
[    4.780476] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    4.783235] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.59 GB=
/8.00 GiB)=0D
[    4.783961] sd 0:0:0:0: [sda] Write Protect is off=0D
[    4.784493] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0D
[    4.784987] sd 0:0:0:0: Attached scsi generic sg0 type 0=0D
[    4.785376] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes=0D
[    4.786632] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.=
5+ PQ: 0 ANSI: 5=0D
[    4.810215] scsi 1:0:0:0: Attached scsi generic sg1 type 5=0D
[    4.813963] sd 0:0:0:0: [sda] Attached SCSI disk=0D
[    5.409100] ACPI: \_SB_.LNKC: Enabled at IRQ 11=0D
[    5.740635] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:5=
6=0D
[    5.741326] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connectio=
n=0D
[    5.742074] e1000e: Intel(R) PRO/1000 Network Driver=0D
[    5.742510] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.=0D
[    5.743121] igb: Intel(R) Gigabit Ethernet Network Driver=0D
[    5.743588] igb: Copyright (c) 2007-2014 Intel Corporation.=0D
[    5.744308] PPP generic driver version 2.4.2=0D
[    5.746564] VFIO - User Level meta-driver version: 0.3=0D
[    5.748246] usbcore: registered new interface driver uas=0D
[    5.748818] usbcore: registered new interface driver usb-storage=0D
[    5.749660] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12=0D
[    5.751299] serio: i8042 KBD port at 0x60,0x64 irq 1=0D
[    5.751793] serio: i8042 AUX port at 0x60,0x64 irq 12=0D
[    5.753336] mousedev: PS/2 mouse device common for all mice=0D
[    5.755137] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1=0D
[    5.757393] rtc_cmos 00:05: RTC can wake from S4=0D
[    5.758754] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042=
/serio1/input/input4=0D
[    5.761196] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042=
/serio1/input/input3=0D
[    5.763359] rtc_cmos 00:05: registered as rtc0=0D
[    5.763899] rtc_cmos 00:05: setting system clock to 2023-02-06T12:53:45 =
UTC (1675688025)=0D
[    5.765200] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, =
hpet irqs=0D
[    5.766014] i2c_dev: i2c /dev entries driver=0D
[    5.766876] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. =
Duplicate IMA measurements will not be recorded in the IMA log.=0D
[    5.768120] device-mapper: uevent: version 1.0.3=0D
[    5.769486] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised:=
 dm-devel@redhat.com=0D
[    5.770355] intel_pstate: CPU model not supported=0D
[    5.771068] sdhci: Secure Digital Host Controller Interface driver=0D
[    5.771682] sdhci: Copyright(c) Pierre Ossman=0D
[    5.772258] sdhci-pltfm: SDHCI platform and OF driver helper=0D
[    5.773151] ledtrig-cpu: registered to indicate activity on CPUs=0D
[    5.774525] drop_monitor: Initializing network drop monitor service=0D
[    5.775477] NET: Registered PF_INET6 protocol family=0D
[    5.783077] Segment Routing with IPv6=0D
[    5.783483] In-situ OAM (IOAM) with IPv6=0D
[    5.783912] NET: Registered PF_PACKET protocol family=0D
[    5.784941] 9pnet: Installing 9P2000 support=0D
[    5.785432] Key type dns_resolver registered=0D
[    5.787404] IPI shorthand broadcast: enabled=0D
[    5.824073] sched_clock: Marking stable (5806791697, 13531965)->(5866226=
262, -45902600)=0D
[    5.826596] registered taskstats version 1=0D
[    5.827596] Loading compiled-in X.509 certificates=0D
[    5.828592] zswap: loaded using pool lzo/zbud=0D
[    5.875072] Key type .fscrypt registered=0D
[    5.875394] Key type fscrypt-provisioning registered=0D
[    5.878789] Key type encrypted registered=0D
[    5.879219] ima: No TPM chip found, activating TPM-bypass!=0D
[    5.879714] ima: Allocated hash algorithm: sha1=0D
[    5.880169] ima: No architecture policies found=0D
[    5.880697] evm: Initialising EVM extended attributes:=0D
[    5.881147] evm: security.selinux=0D
[    5.881438] evm: security.SMACK64=0D
[    5.881730] evm: security.SMACK64EXEC=0D
[    5.882051] evm: security.SMACK64TRANSMUTE=0D
[    5.882406] evm: security.SMACK64MMAP=0D
[    5.882713] evm: security.apparmor=0D
[    5.882970] evm: security.ima=0D
[    5.883233] evm: security.capability=0D
[    5.883544] evm: HMAC attrs: 0x1=0D
[    5.887100] PM:   Magic number: 11:37:885=0D
[    5.888275] RAS: Correctable Errors collector initialized.=0D
[    5.889570] md: Waiting for all devices to be available before autodetec=
t=0D
[    5.889887] md: If you don't use raid, use raid=3Dnoautodetect=0D
[    5.890150] md: Autodetecting RAID arrays.=0D
[    5.890364] md: autorun ...=0D
[    5.890507] md: ... autorun DONE.=0D
[    5.906333] EXT4-fs (sda): mounted filesystem 23a53bb9-f815-47a5-b74c-5e=
08f7731193 with ordered data mode. Quota mode: none.=0D
[    5.907018] VFS: Mounted root (ext4 filesystem) readonly on device 8:0.=
=0D
[    5.911572] devtmpfs: mounted=0D
[    5.930627] Freeing unused decrypted memory: 2036K=0D
[    5.937722] Freeing unused kernel image (initmem) memory: 14104K=0D
[    5.938118] Write protecting the kernel read-only data: 90112k=0D
[    5.942268] Freeing unused kernel image (rodata/data gap) memory: 1956K=
=0D
[    6.048727] x86/mm: Checked W+X mappings: passed, no W+X pages found.=0D
[    6.049154] Run /sbin/init as init process=0D
[    6.310187] systemd[1]: RTC configured in localtime, applying delta of 0=
 minutes to system time.=0D
[    6.379491] systemd[1]: systemd 239 (239-49.el8) running in system mode.=
 (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP=
 +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +=
PCRE2 default-hierarchy=3Dlegacy)=0D
[    6.382101] systemd[1]: Detected virtualization kvm.=0D
[    6.382409] systemd[1]: Detected architecture x86-64.=0D
=0D
Welcome to =1B[0;31mCentOS Stream 8=1B[0m!=0D
=0D
[    6.441755] systemd[1]: Set hostname to <test>.=0D
[    7.051379] systemd[1]: Listening on LVM2 poll daemon socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on LVM2 poll daemon socket.=0D
[    7.075836] systemd[1]: Listening on Process Core Dump Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on Process Core Dump Socket.=0D
[    7.078256] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.=0D
[=1B[0;32m  OK  =1B[0m] Set up automount Arbitrary Executab=E2=80=A6rmats F=
ile System Automount Point.=0D
[    7.081433] systemd[1]: Listening on RPCbind Server Activation Socket.=
=0D
[=1B[0;32m  OK  =1B[0m] Listening on RPCbind Server Activation Socket.=0D
[    7.082994] systemd[1]: Listening on Journal Socket (/dev/log).=0D
[=1B[0;32m  OK  =1B[0m] Listening on Journal Socket (/dev/log).=0D
[    7.085272] systemd[1]: Listening on Journal Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on Journal Socket.=0D
[=1B[0;32m  OK  =1B[0m] Created slice system-serial\x2dgetty.slice.=0D
         Starting Remount Root and Kernel File Systems...=0D
[=1B[0;32m  OK  =1B[0m] Listening on udev Kernel Socket.=0D
[=1B[0;32m  OK  =1B[0m] Created slice User and Session Slice.=0D
[=1B[0;32m  OK  =1B[0m] Reached target Slices.=0D
[=1B[0;32m  OK  =1B[0m] Listening on initctl Compatibility Named Pipe.=0D
[=1B[0;32m  OK  =1B[0m] Listening on multipathd control socket.=0D
[=1B[0;32m  OK  =1B[0m] Started Forward Password Requests to Wall Directory=
 Watch.=0D
[=1B[0;32m  OK  =1B[0m] Created slice system-sshd\x2dkeygen.slice.=0D
[=1B[0;32m  OK  =1B[0m] Listening on Device-mapper event daemon FIFOs.=0D
[=1B[0;32m  OK  =1B[0m] Reached target RPC Port Mapper.=0D
         Starting Journal Service...=0D
         Mounting Huge Pages File System...=0D
[=1B[0;32m  OK  =1B[0m] Created slice system-getty.slice.=0D
         Starting Monitoring of LVM2 mirrors=E2=80=A6ng dmeventd or progres=
s polling...=0D
         Mounting Kernel Debug File System...=0D
         Mounting POSIX Message Queue File System...=0D
[=1B[0;32m  OK  =1B[0m] Reached target Swap.=0D
[=1B[0;32m  OK  =1B[0m] Listening on udev Control Socket.=0D
         Starting udev Coldplug all Devices...=0D
         Starting Load Kernel Modules...=0D
         Starting Setup Virtual Console...=0D
[=1B[0;32m  OK  =1B[0m] Mounted Huge Pages File System.=0D
[=1B[0;32m  OK  =1B[0m] Mounted Kernel Debug File System.=0D
[=1B[0;32m  OK  =1B[0m] Mounted POSIX Message Queue File System.=0D
[=1B[0;1;31mFAILED=1B[0m] Failed to start Load Kernel Modules.=0D
See 'systemctl status systemd-modules-load.service' for details.=0D
         Mounting Kernel Configuration File System...=0D
[    7.676405] EXT4-fs (sda): re-mounted 23a53bb9-f815-47a5-b74c-5e08f77311=
93. Quota mode: none.=0D
         Starting Apply Kernel Variables...=0D
         Mounting FUSE Control File System...=0D
[=1B[0;32m  OK  =1B[0m] Started Journal Service.=0D
[=1B[0;32m  OK  =1B[0m] Started Remount Root and Kernel File Systems.=0D
[=1B[0;32m  OK  =1B[0m] Mounted Kernel Configuration File System.=0D
[=1B[0;32m  OK  =1B[0m] Started Apply Kernel Variables.=0D
[=1B[0;32m  OK  =1B[0m] Mounted FUSE Control File System.=0D
         Starting Load/Save Random Seed...=0D
         Starting Create Static Device Nodes in /dev...=0D
         Starting Flush Journal to Persistent Storage...=0D
[=1B[0;32m  OK  =1B[0m] Started Load/Save Random Seed.=0D
[=1B[0;32m  OK  =1B[0m] Started Create Static Device Nodes in /dev.=0D
[=1B[0;32m  OK  =1B[0m] Started Flush Journal to Persistent Storage.=0D
         Starting udev Kernel Device Manager...=0D
[=1B[0;32m  OK  =1B[0m] Started Setup Virtual Console.=0D
[=1B[0;32m  OK  =1B[0m] Started udev Kernel Device Manager.=0D
[=1B[0;32m  OK  =1B[0m] Started udev Coldplug all Devices.=0D
         Starting udev Wait for Complete Device Initialization...=0D
         Starting Show Plymouth Boot Screen...=0D
[=1B[0;32m  OK  =1B[0m] Started Show Plymouth Boot Screen.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Local Encrypted Volumes.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Paths.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Forward Password Requests to Plymouth Direc=
tory Watch.=0D=0D
[=1B[0;32m  OK  =1B[0m] Found device /dev/ttyS0.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Monitoring of LVM2 mirrors,=E2=80=A6sing dm=
eventd or progress polling.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started udev Wait for Complete Device Initializatio=
n.=0D=0D
[=1B[0;32m  OK  =1B[0m] Listening on Load/Save RF Kill Switch Status /dev/r=
fkill Watch.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Local File Systems (Pre).=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Local File Systems.=0D=0D
         Starting Tell Plymouth To Write Out Runtime Data...=0D=0D
         Starting Restore /run/initramfs on shutdown...=0D=0D
         Starting Create Volatile Files and Directories...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Tell Plymouth To Write Out Runtime Data.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Started Restore /run/initramfs on shutdown.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Create Volatile Files and Directories.=0D=
=0D
         Mounting RPC Pipe File System...=0D=0D
         Starting RPC Bind...=0D=0D
         Starting Security Auditing Service...=0D=0D
[=1B[0;32m  OK  =1B[0m] Mounted RPC Pipe File System.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target rpc_pipefs.target.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started RPC Bind.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Security Auditing Service.=0D=0D
         Starting Update UTMP about System Boot/Shutdown...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Update UTMP about System Boot/Shutdown.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Reached target System Initialization.=0D=0D
[=1B[0;32m  OK  =1B[0m] Listening on SSSD Kerberos Cache Manager responder =
socket.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started daily update of the root trust anchor for D=
NSSEC.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started dnf makecache --timer.=0D=0D
[=1B[0;32m  OK  =1B[0m] Listening on D-Bus System Message Bus Socket.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Sockets.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Basic System.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started D-Bus System Message Bus.=0D=0D
         Starting Login Service...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started irqbalance daemon.=0D=0D
         Starting Self Monitoring and Reporting Technology (SMART) Daemon..=
.=0D=0D
         Starting Authorization Manager...=0D=0D
         Starting Auto-connect to subsystems=E2=80=A6-NVME devices found du=
ring boot...=0D=0D
         Starting NTP client/server...=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target sshd-keygen.target.=0D=0D
         Starting Network Manager...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Machine Check Exception Logging Daemon.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Started Daily Cleanup of Temporary Directories.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Reached target Timers.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Self Monitoring and Reporting Technology (S=
MART) Daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Auto-connect to subsystems =E2=80=A6FC-NVME=
 devices found during boot.=0D=0D
         Starting update of the root trust a=E2=80=A6or DNSSEC validation i=
n unbound...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Login Service.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started NTP client/server.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Network Manager.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Network.=0D=0D
         Starting GSSAPI Proxy Daemon...=0D=0D
         Starting Dynamic System Tuning Daemon...=0D=0D
         Starting OpenSSH server daemon...=0D=0D
         Starting Network Manager Wait Online...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started update of the root trust an=E2=80=A6 for DN=
SSEC validation in unbound.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Authorization Manager.=0D=0D
         Starting Hostname Service...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started GSSAPI Proxy Daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started OpenSSH server daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target NFS client services.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Remote File Systems (Pre).=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Remote File Systems.=0D=0D
         Starting Permit User Sessions...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Permit User Sessions.=0D=0D
         Starting Hold until boot process finishes up...=0D=0D
         Starting Terminate Plymouth Boot Screen...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Hold until boot process finishes up.=0D
[=1B[0;32m  OK  =1B[0m] Started Terminate Plymouth Boot Screen.=0D
[   12.008641] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Contr=
ol: RX=0D
[   12.009882] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready=0D
[   12.457726] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
[   12.459369] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
=0D=0D
CentOS Stream 8=0D
Kernel 6.2.0-rc7-4ec5183ec486 on an x86_64=0D
=0D
test login: [   30.076996] Injecting memory failure for pfn 0x18eef at proc=
ess virtual address 0x20cef000=0D
[   30.077554] page:000000005a337492 refcount:2 mapcount:0 mapping:00000000=
00000000 index:0x0 pfn:0x18e00=0D
[   30.078118] head:000000005a337492 order:9 compound_mapcount:0 subpages_m=
apcount:0 compound_pincount:0=0D
[   30.078632] flags: 0xfffffc0010001(locked|head|node=3D0|zone=3D1|lastcpu=
pid=3D0x1fffff)=0D
[   30.079065] raw: 000fffffc0010001 0000000000000000 dead000000000122 0000=
000000000000=0D
[   30.079507] raw: 0000000000000000 0000000000000000 00000002ffffffff 0000=
000000000000=0D
[   30.079940] page dumped because: VM_WARN_ON_ONCE_FOLIO(is_hzp)=0D
[   30.080449] ------------[ cut here ]------------=0D
[   30.080715] WARNING: CPU: 1 PID: 517 at mm/huge_memory.c:2667 split_huge=
_page_to_list+0x1629/0x3970=0D
[   30.081257] Modules linked in:=0D
[   30.081452] CPU: 1 PID: 517 Comm: repro Not tainted 6.2.0-rc7-4ec5183ec4=
86 #1=0D
[   30.081891] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014=0D
[   30.082530] RIP: 0010:split_huge_page_to_list+0x1629/0x3970=0D
[   30.082863] Code: 31 ff 44 89 e6 e8 d7 aa a2 ff 45 84 e4 75 1d e8 6d a9 =
a2 ff 48 c7 c6 e0 6b 79 85 48 89 df e8 fe b8 e5 ff c6 05 03 2d 98 05 01 <0f=
> 0b 41 bd f0 ff ff ff e9 2e f1 ff ff 48 c7 85 d8 fe ff ff ff ff=0D
[   30.083879] RSP: 0018:ffff8880135b7af8 EFLAGS: 00010246=0D
[   30.084189] RAX: 0000000000000000 RBX: ffffea0000638000 RCX: ffffffff813=
dde2e=0D
[   30.084765] RDX: 0000000000000000 RSI: ffff88800f758000 RDI: 00000000000=
00002=0D
[   30.085359] RBP: ffff8880135b7c78 R08: ffffed100d9a62b2 R09: ffffed100d9=
a62b2=0D
[   30.085825] R10: ffff88806cd3158b R11: ffffed100d9a62b1 R12: 00000000000=
00000=0D
[   30.086227] R13: 0000000000000001 R14: 0000000000000000 R15: ffff8880135=
b7c50=0D
[   30.086628] FS:  00007efdb7675740(0000) GS:ffff88806cd00000(0000) knlGS:=
0000000000000000=0D
[   30.087083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   30.087445] CR2: 00007efdb779a580 CR3: 0000000016be0005 CR4: 00000000007=
70ee0=0D
[   30.087916] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000=0D
[   30.088334] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 00000000000=
00400=0D
[   30.088738] PKRU: 55555554=0D
[   30.088902] Call Trace:=0D
[   30.089055]  <TASK>=0D
[   30.089190]  ? rcu_read_lock_sched_held+0xa9/0xd0=0D
[   30.089487]  ? __pfx_rcu_read_lock_sched_held+0x10/0x10=0D
[   30.089812]  ? rcu_read_lock_sched_held+0xa9/0xd0=0D
[   30.090237]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.090545]  ? __pfx_split_huge_page_to_list+0x10/0x10=0D
[   30.090848]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   30.091148]  ? lock_is_held_type+0xe6/0x140=0D
[   30.091618]  ? mark_held_locks+0xb7/0x140=0D
[   30.091882]  ? write_comp_data+0x2f/0x90=0D
[   30.092135]  try_to_split_thp_page+0xbc/0x450=0D
[   30.092425]  memory_failure+0xcfc/0x2ac0=0D
[   30.092675]  ? __pfx_memory_failure+0x10/0x10=0D
[   30.092943]  ? _printk+0xc/0xdc=0D
[   30.093156]  ? __pfx__printk+0x10/0x10=0D
[   30.093384]  ? write_comp_data+0x2f/0x90=0D
[   30.093633]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   30.093922]  ? write_comp_data+0x2f/0x90=0D
[   30.094172]  do_madvise.cold.55+0x187/0x1a5=0D
[   30.094435]  ? lockdep_hardirqs_on+0x8a/0x110=0D
[   30.094706]  ? __pfx_do_madvise+0x10/0x10=0D
[   30.094960]  ? write_comp_data+0x2f/0x90=0D
[   30.095207]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   30.095496]  ? __audit_syscall_entry+0x3e4/0x550=0D
[   30.095786]  __x64_sys_madvise+0xb3/0x120=0D
[   30.096032]  ? syscall_enter_from_user_mode+0x51/0x60=0D
[   30.096357]  do_syscall_64+0x3b/0x90=0D
[   30.096585]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   30.096895] RIP: 0033:0x7efdb779a59d=0D
[   30.097174] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   30.098195] RSP: 002b:00007ffdbd086878 EFLAGS: 00000217 ORIG_RAX: 000000=
000000001c=0D
[   30.098623] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efdb77=
9a59d=0D
[   30.099027] RDX: 0000000000000064 RSI: 0000000000003000 RDI: 0000000020c=
ef000=0D
[   30.099429] RBP: 00007ffdbd086880 R08: 00007ffdbd0868b0 R09: 00007ffdbd0=
868b0=0D
[   30.099831] R10: 0000000000000004 R11: 0000000000000217 R12: 00000000004=
01180=0D
[   30.100232] R13: 00007ffdbd0869a0 R14: 0000000000000000 R15: 00000000000=
00000=0D
[   30.100672]  </TASK>=0D
[   30.100814] irq event stamp: 1591=0D
[   30.101014] hardirqs last  enabled at (1599): [<ffffffff813dd0a1>] __up_=
console_sem+0x91/0xb0=0D
[   30.101507] hardirqs last disabled at (1606): [<ffffffff813dd086>] __up_=
console_sem+0x76/0xb0=0D
[   30.101994] softirqs last  enabled at (1104): [<ffffffff8536af3f>] __do_=
softirq+0x53f/0x836=0D
[   30.102472] softirqs last disabled at (1017): [<ffffffff812498b0>] irq_e=
xit_rcu+0x100/0x140=0D
[   30.102956] ---[ end trace 0000000000000000 ]---=0D
[   30.103229] Memory failure: 0x18eef: recovery action for unsplit thp: Ig=
nored=0D
[   30.106764] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.107243] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.110864] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.111327] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.114177] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.114647] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.118471] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.118943] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.122637] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.123108] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.125842] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.126303] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.129736] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.130193] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.133810] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.134282] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.137670] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.138138] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.140979] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.141437] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.145329] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.145828] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.149686] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.150155] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.153316] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.153789] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.157647] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.158127] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.161467] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.161954] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.166014] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.166489] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.170475] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.170945] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.174759] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.175229] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.178967] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.179425] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.183380] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.183864] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.187502] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.187965] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.191645] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.192112] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.195710] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.196179] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.199815] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.200278] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.204001] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.204732] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.208175] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.209106] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.212675] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.213166] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.217073] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.217537] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.221197] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.221693] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.225594] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.226064] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.230175] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.230643] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.234310] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.234774] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.238468] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.238936] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.242579] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.243033] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.246696] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.247166] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.250875] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.251339] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.255030] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.255498] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.258360] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.258840] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.262399] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.262866] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.266535] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.267002] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.270683] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.271142] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.274820] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.275285] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.278950] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.279413] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.283522] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.283991] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.287656] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.288128] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.291887] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.292384] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.296085] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.296652] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.300371] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.300875] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.304897] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.305371] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.309093] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.309559] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.313323] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.313776] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.317968] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.318439] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.322245] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.322724] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.325386] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.325890] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.329947] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.330410] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.334130] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.334602] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.338535] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.339074] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.343372] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.343876] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.347090] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.347772] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.351740] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.352688] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.356541] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.357050] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.360891] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.361368] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.365351] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.365822] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.369651] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.370150] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.373072] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.373550] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.377368] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.377842] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.381949] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.382429] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.386228] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.386709] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.390506] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.390974] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.394718] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.395192] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.398866] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.399332] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.403024] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.403488] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.406414] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.406902] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.410440] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.410906] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.414726] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.415196] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.419164] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.419631] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.423303] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.423767] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.427618] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.428088] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.431735] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.432202] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.435971] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.436634] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.440131] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.440954] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.444660] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.445128] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.448948] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.449413] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.452166] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.452678] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.456452] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.456944] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.460971] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.461452] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.465323] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.465822] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.470031] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.470500] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.474339] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.474798] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.478555] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.479038] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.482609] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.483099] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.486790] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.487265] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.490982] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.491460] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.494305] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.494795] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.498356] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.498838] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.502599] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.503073] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.506779] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.507236] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.510995] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.511466] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.514601] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.515072] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.518231] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.518700] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.521391] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.521890] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.525937] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.526413] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.529919] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.530372] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.533125] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.533589] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.537410] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.537912] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.541903] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.542351] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.545145] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.545549] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.549243] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.549704] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.553656] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.554125] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.558556] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.559028] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.563006] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.563482] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.567037] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.567518] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.570387] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.570875] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.574697] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.575174] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.579261] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.579743] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.582835] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.583730] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.588434] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.589614] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.595957] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.596876] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.599960] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.601159] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.606916] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.607809] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.611752] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.612710] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.617078] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.617564] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.620806] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.621298] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.625192] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.625654] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.629283] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.629752] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.633894] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.634365] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.638247] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.638722] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.642429] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.642898] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.646532] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.646996] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.650711] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.651181] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.654931] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.655413] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.659692] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.660160] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.663848] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.664555] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.668043] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.668941] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.672258] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.673156] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.676791] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.677270] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.681174] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.681645] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.685590] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.686066] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.689430] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.689979] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.694000] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.694472] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.698153] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.698623] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.702285] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.702758] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.706434] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.706915] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.710833] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.711302] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.715102] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.715574] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.718399] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.718882] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.722511] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.722985] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.726588] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.727060] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.730745] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.731219] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.734628] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.735105] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.738481] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.738951] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.742628] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.743098] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.746821] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.747293] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.750987] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.751460] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.754335] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.754806] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.758530] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.758988] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.762541] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.763010] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.766759] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.767231] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.770930] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.771396] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.775149] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.775619] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.779433] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.779901] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.783616] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.784080] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.787702] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.788171] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.791826] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.792298] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.795995] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.796654] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.800140] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.801087] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.804760] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.805250] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.808978] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.809454] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.813172] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.813634] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.817343] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.817804] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.820820] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.821286] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.825288] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.825747] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.829282] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.829734] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.832906] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.833361] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.837190] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.837649] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.841311] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.841821] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.845651] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.846102] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.849076] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.849546] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.853456] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.854126] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.857522] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.858272] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.862048] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.862773] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.866507] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.866993] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.870686] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.871156] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.874743] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.875226] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.878884] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.879357] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.882262] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.882727] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.886452] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.886919] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.890566] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.891024] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.894729] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.895188] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.898905] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.899364] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.903123] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.903581] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.907509] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.907970] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.911692] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.912147] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.915687] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.916146] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.919823] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.920273] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.924004] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.924639] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.928224] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.929070] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.932938] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.933402] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.938605] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.939069] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.942925] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.943386] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.947300] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.947763] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.950906] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.951797] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.956305] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.957274] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.962197] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.963079] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.966825] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.967738] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.972468] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.973393] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.977119] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.978192] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.982403] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.983317] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.987901] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.988976] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.993234] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.994154] Memory failure: 0x18eef: already hardware poisoned=0D
[   30.998659] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   30.999576] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.003773] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.004770] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.009562] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.010476] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.014948] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.015857] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.020567] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.021493] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.025170] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.025682] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.029371] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.029895] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.033613] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.034116] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.038240] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.039121] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.043900] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.044876] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.049222] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.049728] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.053403] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.053900] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.057698] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.058208] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.062223] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.063141] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.067778] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.068248] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.071917] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.072441] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.075877] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.076512] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.080019] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.080669] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.084555] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.085061] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.088906] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.089382] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.093280] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.093758] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.097645] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.098122] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.102211] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.102683] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.106467] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.106921] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.111092] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.112182] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.116231] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.117122] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.120738] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.121243] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.124835] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.125371] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.129270] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.129749] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.133602] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.134075] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.136919] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.137381] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.141215] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.141702] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.145308] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.145805] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.149629] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.150093] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.153026] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.153500] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.157790] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.158265] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.162206] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.162686] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.165350] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.165850] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.169737] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.170195] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.173299] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.173766] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.177663] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.178135] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.181564] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.182060] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.186357] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.186833] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.190490] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.190958] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.194745] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.195217] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.198980] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.199453] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.203336] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.203811] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.207437] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.207909] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.211586] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.212059] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.215734] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.216204] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.219894] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.220489] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.224183] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.224691] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.228515] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.229003] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.232927] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.233399] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.237118] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.237593] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.241370] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.241841] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.246187] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.246663] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.250552] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.251017] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.254763] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.255234] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.258892] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.259348] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.262350] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.262838] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.266427] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.266885] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.270588] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.271070] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.274750] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.275222] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.278880] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.279345] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.283009] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.283491] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.286351] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.286838] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.290381] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.290851] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.294464] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.294937] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.298755] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.299224] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.302902] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.303371] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.307113] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.307594] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.310557] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.311033] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.314521] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.314994] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.318709] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.319177] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.322899] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.323371] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.327079] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.327547] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.330425] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.330898] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.334948] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.335422] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.338845] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.339315] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.342960] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.343434] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.346630] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.347117] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.350485] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.350969] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.354542] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.355008] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.358675] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.359145] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.362814] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.363286] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.366993] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.368137] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.372010] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.372812] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.376803] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.377355] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.380423] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.381274] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.384958] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.385439] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.388924] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.389390] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.393019] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.393499] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.397162] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.397616] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.401309] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.401778] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.406069] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.406529] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.410241] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.410715] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.413373] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.413872] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.417702] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.418180] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.421273] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.421739] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.425273] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.425772] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.429518] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.430005] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.434201] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.434668] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.438345] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.438817] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.442472] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.442940] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.446620] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.447096] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.450759] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.451237] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.454939] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.455417] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.458194] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.458679] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.462357] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.462827] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.466404] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.466873] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.470558] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.471029] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.474769] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.475240] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.478912] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.479383] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.482469] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.482956] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.486487] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.486956] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.490601] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.491071] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.494861] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.495332] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.498999] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.499478] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.503349] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.503834] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.507500] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.507970] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.511686] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.512153] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.515891] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.516662] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.520059] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.520948] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.524214] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.525066] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.528700] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.529189] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.532985] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.533457] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.537285] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.537750] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.542331] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.542805] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.546543] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.547011] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.550695] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.551168] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.554799] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.555279] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.558138] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.558618] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.562259] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.562745] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.566230] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.566703] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.570736] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.571633] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.576477] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.577243] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.580393] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.580875] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.583811] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.584288] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.587916] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.588419] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.591932] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.592509] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.595955] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.596468] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.600119] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.600709] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.604363] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.604845] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.607583] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.608055] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.611723] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.612200] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.615873] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.616457] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.619955] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.620465] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.625913] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.626855] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.631830] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.632650] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.636209] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.636699] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.639453] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.639930] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.643570] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.644038] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.649268] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.649820] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.653284] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.653751] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.656229] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.656697] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.660298] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.660876] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.664575] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.665123] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.668994] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.669477] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.673323] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.673806] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.678103] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.678575] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.682547] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.683018] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.686742] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.687206] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.690897] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.691370] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.694195] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.694700] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.698244] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.698722] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.702415] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.702893] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.706566] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.707035] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.710745] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.711224] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.714910] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.715383] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.718355] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.718829] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.722399] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.722857] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.726773] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.727247] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.730927] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.731395] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.734222] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.734700] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.738409] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.738878] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.742760] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.743237] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.746964] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.747441] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.750278] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.750754] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.754580] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.755060] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.758879] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.759361] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.763530] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.764011] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.767857] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.768447] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.772023] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.772559] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.776257] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.776800] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.780668] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.781140] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.784936] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.785418] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.789205] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.789663] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.793649] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.794119] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.798373] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.798853] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.802575] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.803059] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.806790] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.807263] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.810933] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.811400] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.814282] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.814775] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.818317] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.818790] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.822469] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.822939] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.826777] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.827246] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.830972] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.831443] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.835284] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.835747] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.839384] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.839852] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.843593] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.844057] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.847741] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.848197] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.851935] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.852680] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.856088] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.856863] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.860226] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.861124] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.864740] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.865231] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.868883] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.869373] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.873129] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.873614] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.877341] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.877816] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.881943] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.883048] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.887885] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.889022] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.893189] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.893804] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.896751] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.897253] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.901262] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.901739] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.905346] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.905850] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.909996] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.910463] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.914102] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.914571] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.918530] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.918998] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.922669] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.923140] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.926855] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.927327] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.931055] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.931522] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.935408] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.935878] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.939597] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.940065] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.943781] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.944251] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.947890] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.948388] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.952099] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.952664] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.956257] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.956770] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.960568] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.961050] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.964758] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.965249] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.969080] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.969562] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.973362] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.973844] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.978093] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.978560] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.982487] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.982957] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.986573] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.987046] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.990973] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.991856] Memory failure: 0x18eef: already hardware poisoned=0D
[   31.996568] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   31.997494] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.002474] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.003388] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.008094] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.009057] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.013859] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.014773] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.018533] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.019447] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.024141] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.025097] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.029950] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.030865] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.034646] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.035131] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.038955] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.039407] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.043624] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.044093] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.048092] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.048844] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.052592] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.053073] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.057293] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.057786] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.062800] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.063268] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.066946] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.067412] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.070236] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.070721] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.074406] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.074863] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.078583] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.079052] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.082737] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.083209] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.086841] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.087315] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.091007] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.091490] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.094316] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.094804] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.098398] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.098879] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.102411] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.102880] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.106551] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.107032] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.110773] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.111241] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.114933] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.115415] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.118380] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.118855] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.122429] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.122903] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.126537] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.127012] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.130777] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.131244] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.134942] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.135417] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.140025] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.140972] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.146653] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.147936] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.151856] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.152799] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.157097] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.158000] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.162547] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.163035] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.167036] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.167513] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.170593] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.171491] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.175864] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.176847] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.181770] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.182665] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.187849] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.188931] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.193266] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.193708] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.197243] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.197639] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.201114] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.201593] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.205234] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.205697] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.209316] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.209764] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.212218] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.212745] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.216241] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.216684] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.219445] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.219919] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.223575] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.224025] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.228495] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.228981] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.231659] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.232141] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.236169] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.236760] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.240344] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.240827] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.244925] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.245390] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.248999] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.249477] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.253669] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.254136] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.257203] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.257704] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.261952] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.262420] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.266173] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.266647] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.270432] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.270908] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.274594] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.275062] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.278737] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.279209] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.282790] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.283257] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.286962] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.287435] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.290465] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.290943] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.294949] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.295422] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.299380] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.299853] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.303969] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.304571] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.308308] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.308830] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.312309] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.312896] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.317107] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.317591] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.322024] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.322504] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.326036] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.326535] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.330351] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.330827] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.334476] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.334948] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.338678] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.339152] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.342854] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.343326] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.346975] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.347457] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.350276] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.350770] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.354346] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.354820] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.358493] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.358963] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.362775] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.363249] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.366918] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.367394] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.370422] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.370910] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.374501] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.374978] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.378736] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.379204] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.382874] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.383352] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.386202] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.386686] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.390316] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.390788] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.394481] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.394951] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.399300] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.399811] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.404101] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.404771] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.407980] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.408945] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.412472] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.412968] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.416838] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.417319] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.420845] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.421321] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.424895] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.425366] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.429236] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.429704] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.433308] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.433777] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.436657] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.437143] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.439898] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.440411] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.444066] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.444638] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.448254] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.448770] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.452549] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.453035] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.456963] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.457431] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.461366] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.461832] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.466055] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.466526] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.470245] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.470728] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.473419] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.473922] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.477699] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.478172] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.481056] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.481561] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.485365] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.485835] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.489564] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.490059] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.493966] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.494433] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.498175] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.498642] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.502384] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.502853] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.506500] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.506975] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.510712] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.511187] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.514857] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.515321] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.519110] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.519566] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.523416] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.523880] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.527563] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.528041] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.531711] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.532185] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.535941] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.536601] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.540097] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.540979] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.544241] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.545132] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.548800] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.549287] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.552963] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.553436] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.557342] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.557816] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.561874] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.562832] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.566874] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.567354] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.570898] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.571365] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.574917] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.575406] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.579003] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.579482] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.582279] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.582759] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.586564] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.587032] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.590702] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.591182] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.594871] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.595325] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.599000] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.599481] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.603425] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.603905] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.607582] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.608059] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.611728] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.612197] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.615906] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.616659] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.620619] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.621108] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.624234] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.625243] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.628762] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.629236] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.633091] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.633565] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.637450] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.638223] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.645654] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.646396] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.654887] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.656248] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.662703] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.663219] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.667981] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.669068] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.672854] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.673413] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.677290] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.677799] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.681586] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.682097] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.686486] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.686959] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.690625] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.691101] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.694801] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.695289] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.699079] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.699556] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.703190] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.703673] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.707507] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.707990] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.711534] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.712016] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.715726] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.716208] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.719787] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.720261] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.723993] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.724504] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.728102] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.728688] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.732458] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.732972] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.736860] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.737348] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.740982] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.741464] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.745256] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.745685] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.749173] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.749640] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.752141] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.752633] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.756232] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.756702] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.760668] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.761156] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.764819] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.765295] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.768699] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.769153] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.772686] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.773164] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.777111] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.777594] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.781216] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.781693] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.786261] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.786734] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.790519] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.790988] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.794728] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.795198] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.798846] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.799317] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.803012] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.803493] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.806509] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.807427] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.811613] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.812099] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.815559] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.816035] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.819644] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.820121] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.823835] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.824400] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.827992] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.828493] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.832098] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.832657] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.836291] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.836803] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.840617] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.841094] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.844847] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.845339] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.849228] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.849695] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.853390] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.853857] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.856814] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.857309] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.861246] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.861717] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.866249] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.866723] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.870401] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.870880] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.874785] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.875268] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.878929] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.879395] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.882246] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.882743] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.886236] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.886712] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.890400] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.890875] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.894566] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.895038] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.898712] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.899182] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.902914] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.903389] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.906221] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.906711] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.910222] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.910702] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.914423] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.914915] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.919401] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.920664] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.924693] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.925280] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.929405] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.929946] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.934001] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.934490] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.938470] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.938946] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.942648] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.943120] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.946815] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.947281] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.950969] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.951433] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.954239] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.954731] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.958272] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.958742] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.962383] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.962845] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.966530] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.966999] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.970673] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.971149] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.974811] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.975279] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.978975] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.979450] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.982296] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.982771] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.986321] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.986788] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.990479] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.990949] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.994792] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.995263] Memory failure: 0x18eef: already hardware poisoned=0D
[   32.998931] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   32.999399] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.002263] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.002747] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.006259] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.006740] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.010370] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.010837] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.014506] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.014976] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.018710] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.019190] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.022823] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.023292] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.026989] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.027462] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.030339] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.030822] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.034372] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.034854] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.038690] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.039157] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.042803] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.043261] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.046945] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.047416] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.051356] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.051826] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.055804] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.056749] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.059695] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.060175] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.063838] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.064287] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.068006] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.068670] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.072176] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.073036] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.076649] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.077139] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.080823] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.081313] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.085284] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.085754] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.090173] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.090645] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.094622] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.095505] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.099892] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.100837] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.105606] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.106509] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.110960] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.111865] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.116749] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.117238] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.121058] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.121567] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.125297] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.125779] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.129975] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.130446] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.134985] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.135459] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.138390] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.138864] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.141470] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.141967] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.145955] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.146425] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.150214] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.150676] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.154365] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.154834] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.158503] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.158974] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.162694] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.163165] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.166844] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.167314] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.171126] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.171609] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.174767] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.175390] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.178568] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.179167] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.182911] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.183492] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.187496] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.187978] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.191729] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.192196] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.195638] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.196114] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.199808] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.200284] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.203914] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.204634] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.208105] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.208880] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.212259] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.213083] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.216826] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.217283] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.221081] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.221548] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.225286] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.225752] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.229945] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.230416] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.234187] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.234673] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.238502] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.238969] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.242741] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.243218] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.246873] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.247356] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.250158] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.250640] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.254642] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.255117] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.258814] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.259290] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.262957] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.263434] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.267328] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.267807] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.271335] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.271815] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.275477] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.275956] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.279730] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.280212] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.283902] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.284558] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.288148] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.289022] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.292551] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.293041] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.297133] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.297593] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.301188] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.301696] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.305550] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.306061] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.310270] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.310760] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.314351] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.314807] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.318492] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.318931] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.321540] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.322000] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.324770] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.325206] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.327824] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.328298] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.331802] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.332212] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.335993] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.336826] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.340057] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.340555] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.344558] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.345047] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.348927] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.349410] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.353258] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.353730] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.357727] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.358194] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.361034] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.361516] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.365320] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.365793] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.369506] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.370003] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.374004] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.374464] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.377569] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.378041] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.381385] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.381888] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.385687] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.386158] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.389223] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.389691] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.393702] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.394176] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.397313] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.397807] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.402012] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.402477] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.406132] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.406606] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.410285] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.410758] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.414452] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.414925] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.418711] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.419179] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.422942] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.423406] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.427128] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.427604] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.432090] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.432999] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.437353] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.437854] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.440898] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.441409] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.445222] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.445699] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.449311] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.449809] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.453688] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.454157] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.457273] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.457740] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.461625] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.462093] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.465528] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.466027] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.470079] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.470556] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.474283] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.474757] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.478413] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.478885] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.482542] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.483014] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.486686] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.487158] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.490847] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.491324] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.495030] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.495504] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.499507] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.499981] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.503658] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.504142] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.507829] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.508293] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.511949] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.512703] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.516124] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.516917] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.520602] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.521137] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.524851] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.525342] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.529268] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.529734] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.533959] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.534430] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.538180] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.538652] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.542375] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.542844] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.546499] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.546956] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.550679] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.551165] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.554853] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.555320] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.559013] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.559478] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.562380] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.562856] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.566388] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.566853] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.570741] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.571212] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.574879] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.575345] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.579010] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.579483] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.583583] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.584053] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.587728] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.588192] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.591873] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.592414] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.596069] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.596601] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.600192] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.600710] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.604585] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.605079] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.608825] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.609312] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.613209] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.613679] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.617357] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.617826] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.620905] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.621372] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.625122] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.625582] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.629297] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.629791] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.633593] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.634064] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.637305] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.637771] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.641395] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.641864] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.645582] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.646055] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.649265] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.649762] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.653570] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.654043] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.656891] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.657364] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.661105] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.661573] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.665292] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.665781] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.669986] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.670449] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.674155] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.674628] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.677293] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.677784] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.681635] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.682129] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.686158] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.686634] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.691450] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.693179] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.699591] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.700724] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.704981] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.705467] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.709602] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.710061] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.713842] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.714787] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.718737] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.719217] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.722902] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.723374] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.726200] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.726696] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.730281] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.730748] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.734494] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.734962] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.738515] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.738964] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.741598] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.742063] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.744827] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.745353] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.749346] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.749817] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.753937] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.754405] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.758247] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.758719] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.762385] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.762855] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.766493] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.766967] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.770664] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.771136] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.774837] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.775310] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.778968] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.779436] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.782321] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.782793] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.786330] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.786799] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.790489] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.790960] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.794512] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.794983] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.797692] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.798166] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.801153] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.801618] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.805279] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.805778] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.809579] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.810038] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.813037] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.813511] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.817289] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.817762] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.822004] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.822490] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.826219] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.826698] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.830395] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.830864] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.834710] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.835186] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.838885] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.839362] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.843165] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.843645] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.847412] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.847887] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.852022] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.852527] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.856237] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.857232] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.860293] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.861157] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.864864] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.865352] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.868942] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.869444] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.873781] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.874272] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.878392] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.879289] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.883875] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.884937] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.889470] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.889957] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.893705] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.894594] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.898554] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.899474] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.904002] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.904955] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.909917] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.910831] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.914338] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.914785] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.917843] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.918760] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.922819] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.923302] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.926940] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.927424] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.931113] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.931591] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.935171] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.935638] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.939459] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.939931] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.943539] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.944015] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.947712] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.948186] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.954293] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.955071] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.959047] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.959706] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.963193] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.963663] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.967336] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.967811] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.971454] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.971903] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.975789] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.976257] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.979908] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.980410] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.984068] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.984616] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.988225] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.988735] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.992526] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.993003] Memory failure: 0x18eef: already hardware poisoned=0D
[   33.996960] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   33.997446] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.001773] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.002247] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.006205] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.006678] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.010358] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.010829] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.014492] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.014965] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.018667] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.019143] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.022910] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.023385] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.027127] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.027611] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.031382] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.031856] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.035543] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.036015] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.039721] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.040206] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.043839] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.044346] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.048001] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.048606] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.052148] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.052657] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.056554] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.057036] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.060928] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.061411] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.065416] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.065930] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.070427] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.070917] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.074746] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.075223] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.078698] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.079172] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.082889] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.083371] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.087505] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.087980] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.091701] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.092184] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.096102] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.096648] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.100625] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.101113] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.105328] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.105797] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.109280] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.109747] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.113731] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.114202] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.118231] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.118698] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.121380] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.121879] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.125683] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.126164] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.128997] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.129483] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.133174] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.133640] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.137968] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.138432] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.142320] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.142782] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.146510] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.146973] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.150713] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.151180] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.154887] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.155357] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.158222] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.158713] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.162244] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.162714] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.166439] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.166906] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.170699] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.171171] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.174863] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.175330] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.178986] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.179468] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.182347] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.182837] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.186547] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.187014] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.190724] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.191191] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.194883] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.195351] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.199103] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.199585] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.203469] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.203936] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.207617] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.208085] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.211603] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.212877] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.216575] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.217083] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.221264] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.221735] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.225227] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.226781] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.230677] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.231561] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.235517] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.236479] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.240140] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.240739] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.244758] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.245241] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.249047] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.249524] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.253755] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.254235] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.258652] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.259131] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.262995] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.263467] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.266721] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.267200] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.271020] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.271493] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.275370] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.275853] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.279972] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.280502] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.284299] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.284802] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.288483] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.288976] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.292995] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.293476] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.297976] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.298451] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.302931] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.303413] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.307293] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.307772] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.312078] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.312653] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.316415] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.316892] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.320298] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.320846] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.324968] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.325440] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.329732] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.330205] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.334935] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.335407] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.338940] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.339409] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.342212] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.342696] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.346483] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.346956] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.350603] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.351074] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.354722] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.355176] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.358838] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.359305] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.362976] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.363442] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.366313] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.366805] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.370347] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.370821] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.374586] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.375055] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.378737] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.379210] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.382895] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.383364] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.387106] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.387578] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.391142] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.391611] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.395421] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.395893] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.399563] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.400040] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.403773] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.404248] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.407919] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.408644] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.412149] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.413007] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.416678] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.417166] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.420836] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.421321] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.425071] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.425554] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.429378] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.429850] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.434049] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.434526] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.438607] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.439084] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.442791] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.443268] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.446996] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.447474] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.450305] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.450783] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.454277] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.454746] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.457402] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.457881] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.460373] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.461481] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.465024] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.465640] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.469649] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.470381] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.474124] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.475222] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.478888] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.479310] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.482005] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.482478] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.486170] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.486637] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.490157] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.490604] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.493534] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.493936] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.497355] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.497788] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.500264] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.501133] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.504832] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.505315] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.509122] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.509610] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.513422] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.513890] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.518110] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.518578] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.522300] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.522777] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.526443] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.526912] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.530614] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.531084] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.534711] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.535192] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.538843] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.539315] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.542981] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.543453] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.547591] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.548076] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.551730] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.552198] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.555889] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.556391] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.560124] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.560639] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.564481] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.564969] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.568997] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.569483] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.573137] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.573602] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.577640] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.578111] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.580943] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.581425] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.585305] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.585780] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.589733] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.590206] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.594155] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.594631] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.597305] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.597807] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.601625] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.602095] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.605187] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.605666] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.609124] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.609632] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.613570] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.614071] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.618353] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.618840] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.622464] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.622933] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.626721] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.627189] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.630693] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.631156] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.633953] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.634428] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.638257] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.638733] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.642434] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.642905] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.646581] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.647052] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.650709] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.651181] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.654887] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.655361] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.658972] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.659430] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.663449] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.663927] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.667932] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.668444] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.671961] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.672925] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.676177] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.676965] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.680631] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.681124] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.684899] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.685388] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.689175] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.689681] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.693329] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.693800] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.698069] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.698546] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.702431] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.702899] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.706582] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.707058] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.710731] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.711203] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.714862] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.715340] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.719023] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.719494] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.722321] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.722869] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.726491] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.727228] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.730993] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.731505] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.735241] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.735718] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.739130] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.739602] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.743213] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.743675] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.747387] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.747852] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.751624] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.752100] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.755835] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.756305] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.759828] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.760308] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.763979] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.764491] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.768135] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.768697] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.772467] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.772947] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.776966] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.777441] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.781130] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.781580] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.785492] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.785977] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.790193] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.790670] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.794547] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.795024] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.798969] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.799442] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.803308] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.803784] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.807901] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.808514] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.812192] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.812708] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.816579] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.817069] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.821385] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.821863] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.826394] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.826875] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.830778] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.831252] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.835132] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.835609] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.838721] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.839622] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.844187] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.845279] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.849381] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.850287] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.854795] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.855705] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.860541] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.861395] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.864796] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.865287] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.869193] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.869663] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.873737] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.874690] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.878805] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.879289] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.882994] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.883467] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.887201] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.887684] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.891361] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.891824] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.895478] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.895949] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.899653] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.900117] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.903819] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.904291] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.907950] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.908721] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.912104] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.912937] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.916769] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.917256] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.920979] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.921456] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.925144] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.925606] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.929279] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.929780] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.933525] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.933986] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.936893] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.937369] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.941152] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.941608] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.945283] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.945755] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.950125] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.950595] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.954312] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.954783] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.958484] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.958956] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.962634] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.963105] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.966807] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.967281] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.971016] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.971491] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.975417] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.975898] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.981268] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.982312] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.987152] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.988054] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.991940] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.992685] Memory failure: 0x18eef: already hardware poisoned=0D
[   34.996283] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   34.997185] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.000641] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.001125] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.005643] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.006116] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.009256] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.009723] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.013334] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.013840] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.017657] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.018133] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.020904] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.021371] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.025293] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.025713] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.029232] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.029640] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.032554] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.032999] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.035537] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.035944] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.039840] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.040308] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.043794] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.044209] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.048010] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.048508] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.052115] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.052666] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.056239] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.056693] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.060293] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.060803] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.064622] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.065102] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.069282] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.069758] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.074346] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.075241] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.079902] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.080964] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.085465] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.086384] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.090952] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.091865] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.096766] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.097691] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.102556] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.103468] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.108138] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.109181] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.113559] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.114050] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.118052] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.118528] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.122455] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.122936] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.126799] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.127277] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.131151] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.131625] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.134468] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.134941] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.138555] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.139014] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.142513] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.142984] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.147054] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.147524] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.150943] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.151411] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.154216] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.154710] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.158199] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.158670] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.162324] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.162794] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.166801] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.167268] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.170966] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.171432] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.174984] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.175578] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.179603] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.180068] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.183750] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.184229] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.187880] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.188420] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.192057] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.192576] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.196251] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.196840] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.200563] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.201044] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.204872] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.205367] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.209068] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.209551] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.213420] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.213902] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.216918] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.217389] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.221269] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.221739] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.225342] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.225811] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.229392] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.229865] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.232899] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.233395] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.237808] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.238626] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.244663] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.245563] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.248983] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.249466] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.253449] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.253962] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.258057] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.258525] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.262193] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.262666] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.266657] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.267123] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.270596] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.271070] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.274740] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.275207] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.278881] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.279353] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.283055] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.283526] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.286459] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.286945] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.290509] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.290985] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.295028] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.295506] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.299064] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.299547] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.303451] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.303931] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.307620] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.308087] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.311809] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.312280] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.315960] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.316629] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.320113] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.320927] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.324570] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.325056] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.328781] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.329271] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.332979] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.333449] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.337417] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.337875] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.342078] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.342550] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.346491] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.346965] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.350597] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.351069] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.354739] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.355212] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.358903] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.359367] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.362159] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.362634] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.366245] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.366716] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.370398] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.370863] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.374546] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.375022] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.378625] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.379090] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.382740] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.383209] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.386884] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.387350] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.390188] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.390671] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.394345] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.394827] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.398359] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.398828] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.402496] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.402981] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.406649] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.407121] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.410763] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.411233] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.414884] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.415371] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.418233] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.418719] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.422206] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.422676] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.426445] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.426914] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.430559] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.431026] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.434683] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.435152] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.438842] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.439311] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.442945] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.443414] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.447329] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.447795] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.451450] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.451919] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.455597] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.456061] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.459705] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.460171] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.463822] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.464290] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.467949] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.468605] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.472081] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.472959] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.476277] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.477182] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.480796] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.481285] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.485456] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.485931] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.489198] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.489713] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.493565] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.494278] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.498839] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.499531] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.503550] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.504081] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.508234] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.509065] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.512628] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.513112] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.517083] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.517560] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.521293] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.521763] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.525170] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.525675] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.529518] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.529980] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.534105] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.534559] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.537655] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.538092] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.541235] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.541665] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.544295] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.545247] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.549007] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.549488] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.553289] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.553763] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.557105] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.557587] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.561415] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.561879] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.565615] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.566088] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.569172] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.569654] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.573158] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.573631] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.577310] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.577773] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.580583] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.581076] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.583935] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.584448] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.588176] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.588787] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.592496] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.592984] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.596940] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.597417] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.601318] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.601794] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.606215] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.606691] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.610351] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.610827] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.614416] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.614886] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.618601] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.619063] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.622570] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.623022] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.625908] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.626306] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.628849] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.629309] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.632075] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.632649] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.636346] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.636831] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.640872] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.641351] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.645105] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.645573] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.649382] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.649844] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.654097] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.654563] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.658813] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.659282] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.662973] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.663441] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.666270] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.666767] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.670286] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.670756] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.674420] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.674892] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.678552] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.679023] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.682710] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.683177] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.686857] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.687327] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.690994] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.691463] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.695316] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.695798] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.699408] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.699880] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.703581] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.704052] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.707699] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.708165] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.711937] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.712602] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.716128] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.716988] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.720654] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.721141] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.724872] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.725363] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.729238] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.729711] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.733679] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.734148] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.738192] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.738661] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.742462] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.742932] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.746852] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.747327] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.751424] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.752288] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.757899] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.758721] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.762512] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.762993] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.766667] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.767142] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.770693] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.771176] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.774859] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.775334] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.779021] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.779492] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.782305] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.782788] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.786289] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.786770] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.790393] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.790859] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.794523] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.795000] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.798767] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.799236] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.802889] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.803357] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.806274] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.806743] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.810331] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.810802] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.814463] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.814937] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.818556] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.819023] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.823010] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.823467] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.827134] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.827614] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.831516] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.831983] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.835655] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.836129] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.839801] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.840281] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.843997] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.844662] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.848186] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.849113] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.852742] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.853216] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.856924] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.857401] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.861284] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.861750] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.865636] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.866097] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.868979] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.869459] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.873309] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.873776] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.877403] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.877899] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.881693] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.882170] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.885376] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.885854] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.889149] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.889649] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.893453] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.893944] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.897701] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.898172] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.901129] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.901613] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.905395] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.905867] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.909665] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.910132] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.913232] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.913712] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.917526] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.917992] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.921332] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.921826] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.925685] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.926152] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.930147] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.930617] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.934314] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.934782] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.938479] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.938951] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.942677] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.943141] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.946803] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.947270] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.950978] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.951445] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.954346] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.954831] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.958402] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.958869] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.962507] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.962969] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.966681] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.967148] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.970831] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.971304] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.974980] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.975451] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.979448] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.979932] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.983649] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.984126] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.987708] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.988178] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.991846] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.992551] Memory failure: 0x18eef: already hardware poisoned=0D
[   35.996057] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   35.996700] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.000568] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.001052] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.006448] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.007470] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.011436] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.012401] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.016071] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.017279] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.021335] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.021801] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.024985] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.025450] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.029332] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.029801] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.033376] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.033874] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.037657] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.038122] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.041213] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.041686] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.045556] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.046027] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.049447] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.049949] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.054500] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.054974] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.058392] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.058846] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.062581] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.063053] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.066709] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.067179] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.070891] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.071360] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.075113] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.075604] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.079411] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.079885] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.083602] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.084078] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.087812] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.088286] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.091999] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.092745] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.096076] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.096950] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.100659] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.101145] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.104916] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.105394] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.109105] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.109583] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.114075] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.114546] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.118175] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.118651] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.122484] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.122960] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.126712] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.127182] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.130830] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.131302] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.134938] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.135418] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.139282] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.139756] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.143451] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.143916] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.147602] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.148075] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.151746] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.152217] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.155939] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.156444] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.159953] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.160598] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.163993] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.164501] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.168117] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.168718] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.172441] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.172933] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.176888] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.177376] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.181142] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.181625] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.185597] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.186073] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.188879] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.189353] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.193220] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.193699] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.197664] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.198161] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.202139] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.202611] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.205647] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.206119] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.209460] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.210454] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.214301] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.215330] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.219911] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.220827] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.225283] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.225802] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.229904] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.230819] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.235725] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.236691] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.241966] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.242459] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.245397] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.245899] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.250271] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.250743] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.254430] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.254913] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.258617] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.259091] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.262825] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.263657] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.268251] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.269215] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.273022] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.273926] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.277701] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.278174] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.282074] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.282543] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.286270] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.286743] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.290464] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.290935] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.294617] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.295091] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.298875] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.299351] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.303021] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.303506] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.307176] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.307659] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.311713] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.312187] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.315921] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.316587] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.320103] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.320976] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.324438] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.324949] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.328685] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.329176] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.332939] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.333426] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.337329] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.337808] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.342067] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.342542] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.346257] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.346736] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.350441] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.350918] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.355221] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.355698] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.359089] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.359563] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.363408] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.363873] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.367555] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.368030] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.371765] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.372244] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.375998] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.376756] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.380147] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.380939] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.384636] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.385154] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.388981] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.389452] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.393500] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.393970] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.397155] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.397655] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.401448] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.401953] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.405992] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.406459] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.410192] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.410662] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.414359] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.414838] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.418492] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.418962] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.422626] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.423106] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.426768] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.427236] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.430893] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.431363] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.434237] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.434736] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.438261] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.438726] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.442397] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.442880] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.446382] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.446849] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.449604] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.450070] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.452827] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.453306] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.457232] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.457704] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.461682] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.462151] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.466553] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.467028] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.470743] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.471219] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.474922] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.475401] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.479141] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.479613] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.483280] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.483755] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.487497] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.487968] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.491681] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.492148] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.495794] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.496249] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.499890] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.500490] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.504485] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.504966] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.508686] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.509182] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.512287] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.512844] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.516585] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.517079] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.522603] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.523519] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.529449] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.530136] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.533970] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.534444] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.538214] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.538680] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.542280] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.542754] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.546464] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.546924] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.550743] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.551214] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.554913] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.555383] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.559174] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.559646] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.563287] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.563742] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.567462] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.567934] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.571601] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.572061] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.575756] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.576228] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.579990] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.580639] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.584198] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.585007] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.588645] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.589130] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.592941] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.593415] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.597214] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.597682] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.601412] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.601913] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.606014] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.606491] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.610175] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.610652] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.614376] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.614833] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.618517] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.618993] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.622684] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.623158] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.626831] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.627301] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.631309] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.631779] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.635742] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.636208] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.639878] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.640403] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.644040] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.644552] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.648206] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.648723] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.652546] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.653038] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.657083] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.657547] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.661337] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.661804] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.665959] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.666429] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.670176] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.670651] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.674320] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.674795] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.678432] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.678907] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.682596] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.683065] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.687006] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.687475] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.691331] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.691811] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.695462] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.695933] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.699587] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.700052] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.703776] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.704248] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.707940] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.708665] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.712113] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.712886] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.716614] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.717091] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.720534] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.721079] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.724810] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.725298] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.729085] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.729569] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.733354] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.733836] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.738040] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.738499] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.742498] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.742969] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.746653] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.747134] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.750768] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.751256] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.754981] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.755449] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.758267] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.758756] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.762315] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.762788] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.766650] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.767126] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.771068] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.771544] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.775430] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.775900] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.782027] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.782891] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.787909] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.788552] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.792267] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.792778] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.795754] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.796237] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.799793] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.800274] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.803742] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.804218] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.807854] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.808364] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.812309] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.812889] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.816919] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.817398] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.820957] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.821435] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.825073] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.825549] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.829667] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.830629] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.834715] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.835195] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.838927] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.839400] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.843295] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.843775] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.846760] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.847671] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.852146] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.853363] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.857386] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.857900] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.862040] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.862936] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.867604] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.868088] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.871791] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.872258] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.876064] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.876760] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.880222] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.881024] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.884731] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.885222] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.889110] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.889586] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.893310] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.893783] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.897733] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.898215] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.902501] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.902968] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.906631] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.907098] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.910824] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.911289] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.914992] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.915447] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.918458] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.919346] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.924310] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.925320] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.930352] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.931267] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.936145] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.936664] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.940287] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.940893] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.944680] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.945169] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.948902] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.949391] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.953138] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.953603] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.957315] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.957810] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.961580] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.962051] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.964978] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.965456] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.969265] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.969736] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.973787] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.974264] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.978189] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.978655] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.981340] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.981847] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.985627] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.986071] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.989273] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.989736] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.993144] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.993604] Memory failure: 0x18eef: already hardware poisoned=0D
[   36.997648] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   36.998121] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.002118] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.002581] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.006265] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.006726] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.010474] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.010936] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.014739] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.015201] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.018884] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.019347] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.023007] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.023467] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.026403] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.026885] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.030855] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.031325] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.035051] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.035530] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.039366] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.039996] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.043874] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.044637] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.048536] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.049064] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.052974] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.053449] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.057247] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.057713] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.061388] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.061878] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.065674] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.066144] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.068999] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.069463] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.073289] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.073763] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.077710] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.078180] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.081269] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.081722] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.085876] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.086343] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.089530] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.090020] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.094030] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.094497] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.098179] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.098650] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.102349] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.102822] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.106474] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.106951] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.110571] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.111034] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.114694] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.115163] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.118813] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.119296] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.122946] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.123421] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.127388] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.127854] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.131471] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.131946] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.135604] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.136071] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.139789] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.140256] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.143899] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.144553] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.148040] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.148892] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.152203] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.153122] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.156714] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.157202] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.161100] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.161565] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.165192] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.165687] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.169431] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.169919] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.173935] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.174407] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.178164] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.178641] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.182312] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.182787] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.186498] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.186979] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.190657] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.191129] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.194811] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.195280] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.198745] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.199214] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.202698] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.203167] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.206831] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.207300] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.211615] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.212080] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.215852] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.216424] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.219996] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.220511] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.224403] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.224872] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.227654] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.228135] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.232093] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.232675] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.236827] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.237310] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.241325] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.241815] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.245681] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.246635] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.250599] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.251082] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.254761] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.255230] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.258912] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.259380] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.262160] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.262636] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.266201] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.266666] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.270326] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.270794] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.274532] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.275005] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.278732] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.279198] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.282934] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.283394] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.287311] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.287784] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.291427] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.291883] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.295790] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.296577] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.301051] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.301513] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.305154] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.305882] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.308922] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.309393] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.313150] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.313619] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.317293] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.317765] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.320574] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.321063] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.323827] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.324305] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.328012] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.328613] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.332201] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.332780] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.336508] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.337022] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.341011] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.341485] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.345154] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.345630] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.349323] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.349795] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.352877] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.353366] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.357157] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.357621] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.361319] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.361790] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.366175] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.366647] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.370610] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.371077] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.374818] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.375283] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.379038] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.379518] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.382418] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.382898] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.386624] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.387100] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.390905] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.391377] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.394123] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.394582] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.398105] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.398565] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.402295] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.402756] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.406414] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.406879] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.410463] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.411349] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.416035] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.417076] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.421857] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.422346] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.426365] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.426845] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.430557] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.431026] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.434720] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.435201] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.438887] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.439366] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.443534] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.444016] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.447863] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.448405] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.452240] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.452765] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.456595] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.457084] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.461136] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.461619] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.465778] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.466757] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.470947] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.471438] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.475260] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.475743] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.479989] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.480514] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.484277] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.484862] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.488835] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.489319] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.493122] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.493602] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.498346] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.498824] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.502579] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.503473] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.508232] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.509211] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.514231] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.515145] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.519973] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.520927] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.525959] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.526869] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.530550] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.531035] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.534875] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.535353] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.539234] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.539719] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.544053] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.544565] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.548690] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.549176] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.552567] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.553059] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.556940] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.557426] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.560180] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.560729] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.564495] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.565351] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.569052] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.569861] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.573686] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.574185] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.578489] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.579408] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.583696] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.584191] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.588123] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.588846] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.592785] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.593277] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.597175] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.597646] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.601558] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.602025] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.605371] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.605871] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.609767] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.610231] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.613243] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.613709] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.617998] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.618474] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.622258] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.622726] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.626460] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.626930] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.630740] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.631208] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.634887] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.635366] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.638178] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.638664] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.642171] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.642639] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.646331] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.646804] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.650445] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.650903] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.654543] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.655024] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.658694] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.659151] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.662805] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.663278] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.666951] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.667425] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.671140] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.671621] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.675404] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.675887] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.679548] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.680020] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.683688] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.684159] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.687791] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.688262] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.691969] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.692761] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.696162] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.696948] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.700685] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.701175] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.704861] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.705350] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.709146] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.709613] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.713327] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.713794] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.718066] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.718536] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.722247] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.722728] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.725328] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.725844] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.729676] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.730144] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.734063] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.734534] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.738283] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.738761] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.742438] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.742892] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.746797] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.747278] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.751148] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.751625] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.754460] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.754935] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.758489] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.758962] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.762562] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.763030] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.766556] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.767027] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.769743] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.770223] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.773170] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.773642] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.777196] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.777700] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.781505] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.782006] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.785951] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.786405] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.790135] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.790611] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.794346] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.794827] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.798535] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.799019] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.802726] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.803204] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.806864] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.807344] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.811038] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.811517] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.814426] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.815255] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.818992] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.819487] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.823624] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.824476] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.828536] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.829016] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.832275] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.833187] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.836970] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.837419] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.840761] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.841249] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.844898] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.845388] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.848989] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.849473] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.853335] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.853802] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.858102] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.858572] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.862153] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.862613] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.865189] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.865632] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.868126] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.869108] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.872635] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.873133] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.877386] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.878262] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.882694] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.883614] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.888214] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.888754] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.892620] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.893108] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.897120] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.897593] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.901386] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.901843] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.905374] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.905874] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.909691] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.910161] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.913603] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.914065] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.917230] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.917729] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.921637] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.922099] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.925190] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.925660] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.929592] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.930048] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.933424] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.933926] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.937961] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.938426] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.942120] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.942581] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.946178] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.946638] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.950295] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.950767] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.954427] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.954883] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.958723] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.959180] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.962870] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.963332] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.966847] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.967311] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.970213] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.970711] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.974286] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.974763] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.978410] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.978873] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.982586] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.983072] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.986691] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.987154] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.990843] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.991317] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.994818] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.995302] Memory failure: 0x18eef: already hardware poisoned=0D
[   37.999101] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   37.999588] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.002746] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.003651] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.007899] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.008993] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.013906] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.014829] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.019966] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.021007] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.025324] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.025845] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.029758] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.030234] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.034149] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.034606] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.038286] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.038759] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.042412] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.042871] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.046944] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.047408] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.050806] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.051285] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.054917] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.055375] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.058199] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.058673] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.062239] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.062705] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.066472] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.066955] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.070508] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.071346] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.075119] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.075620] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.079590] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.080472] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.083452] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.084285] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.088252] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.089073] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.092881] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.093373] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.097122] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.097605] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.101315] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.101789] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.106066] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.106532] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.110489] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.110961] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.114671] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.115141] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.118858] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.119334] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.123585] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.124051] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.127812] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.128285] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.131919] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.132429] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.136044] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.136587] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.140171] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.140683] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.144450] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.144941] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.148948] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.149431] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.153312] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.153785] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.157733] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.158201] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.162213] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.162699] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.166476] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.166934] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.170586] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.171051] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.174742] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.175199] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.178844] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.179304] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.182977] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.183435] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.186373] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.186845] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.190377] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.190840] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.194523] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.194996] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.198702] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.199173] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.202881] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.203349] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.207311] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.207794] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.211434] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.211907] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.215803] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.216270] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.219854] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.220416] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.224303] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.224814] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.228734] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.229212] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.232998] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.233472] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.237081] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.237550] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.240994] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.241476] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.245391] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.245860] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.250105] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.250581] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.254454] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.254917] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.258585] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.259054] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.262717] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.263187] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.266843] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.267313] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.271051] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.271542] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.274371] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.274849] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.278557] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.279034] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.282411] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.282884] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.286590] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.287071] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.290689] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.291153] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.294849] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.295321] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.298976] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.299455] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.302269] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.302748] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.306326] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.306782] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.310342] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.310794] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.314527] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.314995] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.318730] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.319194] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.322837] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.323300] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.330378] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.331123] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.335635] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.336147] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.339764] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.340235] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.343781] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.344241] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.348119] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.348624] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.352283] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.352878] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.356786] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.357275] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.361196] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.361668] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.365264] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.365747] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.370150] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.370626] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.374426] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.374910] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.378644] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.379115] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.382801] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.383270] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.386964] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.387426] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.390239] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.390711] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.394563] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.395020] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.398390] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.398850] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.402538] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.403001] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.406722] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.407192] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.410863] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.411334] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.414995] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.415468] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.418277] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.418767] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.422266] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.422726] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.426412] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.426883] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.430529] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.430998] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.434619] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.435089] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.438779] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.439253] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.442893] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.443386] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.446151] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.446635] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.450322] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.450784] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.454753] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.455218] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.459078] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.459543] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.462537] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.463420] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.468014] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.469085] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.473908] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.474822] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.478481] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.479374] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.483875] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.484922] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.489728] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.490213] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.494081] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.494552] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.498215] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.498690] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.502033] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.502509] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.506265] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.506742] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.510224] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.510707] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.514256] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.514730] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.517480] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.517985] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.521895] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.522350] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.525310] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.525785] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.529180] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.529605] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.532156] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.533413] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.536568] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.537050] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.541056] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.541523] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.545190] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.545660] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.549361] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.549831] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.554040] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.554510] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.558182] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.558643] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.562277] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.562744] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.566462] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.566923] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.570515] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.570978] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.574655] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.575121] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.578817] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.579280] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.582870] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.583346] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.586958] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.587468] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.591105] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.591592] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.595447] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.595938] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.599622] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.600226] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.603840] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.604359] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.608100] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.608769] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.612265] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.612793] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.616262] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.616883] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.620682] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.621182] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.625141] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.625697] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.629048] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.629533] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.633009] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.633481] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.636989] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.637471] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.641316] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.641917] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.645419] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.645913] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.649820] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.650305] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.653372] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.653861] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.657718] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.658189] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.662531] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.663032] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.666717] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.667209] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.670892] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.671384] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.675357] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.675849] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.679629] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.680113] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.683824] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.684287] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.688048] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.688866] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.692242] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.693152] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.696733] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.697217] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.701268] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.701751] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.705351] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.705813] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.710067] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.710546] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.714615] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.715104] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.718819] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.719297] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.723061] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.723542] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.726452] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.726897] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.730399] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.730837] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.734540] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.735012] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.738699] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.739166] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.742704] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.743165] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.745885] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.746337] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.749055] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.749503] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.752045] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.752604] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.756045] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.756549] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.760275] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.760812] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.764492] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.764969] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.768871] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.769390] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.773101] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.773575] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.776160] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.776733] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.780250] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.780737] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.784724] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.785215] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.788707] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.789193] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.792806] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.793288] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.796143] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.796647] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.800228] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.800786] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.804364] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.804840] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.808649] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.809154] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.813098] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.813572] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.817698] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.818166] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.822436] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.822901] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.826595] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.827052] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.830725] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.831184] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.834860] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.835318] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.838986] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.839444] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.844164] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.844923] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.849433] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.850056] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.854362] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.854847] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.858295] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.858778] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.862404] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.862893] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.866517] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.866988] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.870630] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.871105] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.874704] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.875179] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.878843] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.879321] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.882821] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.883307] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.886821] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.887305] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.891132] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.891627] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.895388] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.895858] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.899343] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.899821] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.903644] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.904123] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.907582] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.908054] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.912061] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.912613] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.916211] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.916737] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.920462] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.920979] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.925060] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.925535] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.929321] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.929793] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.933963] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.934442] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.938234] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.938700] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.942536] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.943014] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.946763] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.947376] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.950704] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.951204] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.954913] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.955536] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.958761] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.959253] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.962637] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.963109] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.966676] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.967151] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.971016] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.971492] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.974287] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.974762] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.978221] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.978697] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.982187] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.982659] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.986348] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.986839] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.990527] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.991006] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.994373] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.994858] Memory failure: 0x18eef: already hardware poisoned=0D
[   38.997619] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   38.998090] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.000864] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.001361] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.005656] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.006160] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.010339] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.010820] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.014519] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.014996] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.018771] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.019256] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.023076] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.023567] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.026448] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.026931] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.030432] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.030890] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.034697] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.035162] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.038873] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.039335] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.043031] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.043504] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.046357] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.046862] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.050429] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.050910] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.054867] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.055346] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.058883] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.059376] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.063135] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.063625] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.067421] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.067913] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.071602] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.072076] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.076106] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.076835] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.080513] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.081009] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.084930] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.085415] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.090039] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.090631] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.095600] Injecting memory failure for pfn 0x18eef at process virtual =
address 0x20cef000=0D
[   39.096256] Memory failure: 0x18eef: already hardware poisoned=0D
[   39.100022] Injecting memory failure for pfn 0x1=

--b3rEXDtV+UP6p3C9--
