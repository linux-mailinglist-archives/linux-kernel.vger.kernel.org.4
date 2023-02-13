Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B67694396
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjBMK4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjBMKzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:55:52 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899F917161;
        Mon, 13 Feb 2023 02:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676285751; x=1707821751;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4mvaXXikKrZiZuRMwJW3oDMlt13WW+z8JcS1GXzHPLw=;
  b=NB+Cpzz1Q4DyttFojYpdQpbawKQd9UdrZ5z8PDDdWvyOZh+rgCs5qLdb
   QL4NcPfTg3ZrecLHJZpn788yuetCbOvPyCLdXbH6cB08wUtFSCSiPFctp
   VFW0ofbS8qeiCxJxL4LpoTfXCOU9vos6cYqK3S+mR6qLEJ1ln6oXPUKtG
   eiuEEiBGLWYQhVf5M29+hm8og068UyUwGHFNQxaDuZP68hRDmtGdzH0o8
   R7HnaT/KowO6w1y7w17dTxTHg2XSZi8Btdtjj+iat7W95p+e7obVgESVW
   yJ/SGxfahX0fWPhsIPGBBt14tC5O4rPuSJK082QbEgpW1s/L3MJtBGNNC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="310498690"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="c'?log'?scan'208";a="310498690"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 02:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="670781149"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="c'?log'?scan'208";a="670781149"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 13 Feb 2023 02:55:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 02:55:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 02:55:45 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 02:55:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvJkBKybTl3oI/qnBePNpGZye3JAggwA+6X58dLRy1vvtLedIYYTx9d01akBbV4myLhZRiDwMxYIyHGiUgwMg01Fzzw02wAyzTqDHlu7/zAkSnlYhlk8YyzJ/s4DvswyD7h4gMZrJJv0UuA046NzA2gyUZBOmD8JWK8e9tBUnu5+W6JbhaMDBhtcDMDLL3fiswiXHA4rxUqdD2RcvFE+2EdP2W73u1qFE+xFfZhKQkFDSaA1+lpk3YMa58LzCb9Qtty3EcL0augxgGgnzHEzSK6uK9TM7FlaEi/ZowUc55wqkdF3QQUUAmD+5473mitJC1CnsjKUBVQ/2cSYkkwVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPQ1JFF2HVmpQP2eDgoyY6qvAEHn9rqN8mbWtzEm3UE=;
 b=DuFyERvK/C8GGepqu9h47M6LxdbGNS7OA2l+FLiBeZSE2pRrtF11ZtVdw/QWerf11gdffiIFLAYW9Q+GBdUBzQEJokZGaCwZUIuSgE4kM/arSklIVcdWC04r7ueuzOLbYP5fJoXFBhkzT6MDDKnIvaZq9HeJ9+s4+lfW/MNrnqn14Owcs/JUl6C6V5fyYgC8d0a779DQ5FoWj4FlG1cATnnCXBVY27jYPL/Ct0xQvpyX1diGIRnZ5jAlPEfftTzMT8DGtP/TLMnQy0fuW9O8VmAtQAU8QG7/EnKsnCUHLmTFwC24MbI1AbE7naYbH/4mOvGd0J4Vwyco8yTaNUBGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 13 Feb
 2023 10:55:40 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80%4]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 10:55:40 +0000
Date:   Mon, 13 Feb 2023 18:56:45 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <dchinner@redhat.com>
CC:     <djwong@kernel.org>, <chandan.babu@oracle.com>,
        <linux-xfs@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <heng.su@intel.com>,
        <pengfei.xu@intel.com>
Subject: [Syzkaller & bisect] There is "xfs_bmapi_convert_delalloc" WARNING
 in v6.2-rc7 kernel
Message-ID: <Y+oXbRJ320Kwb3Lh@xpf.sh.intel.com>
Content-Type: multipart/mixed; boundary="5DqPYnvrX9NSYHIs"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH7PR11MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 3587dbfb-d861-472d-1897-08db0db0d81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oD1ym/pDqiA2Y4Rd7AP0x1K+gGM6CKaUuuJcz2n8VDzg3FBw3EDTeMv/jSqOrE7wJUnuOCIK0IgZxl/GLlfslyAZHG/x8J4XkhlhEG/q9X+ySNyQJWc2MN1pT+jiMaI9kenfpPCk87moIEmOMuhBVmSDnPJwktAxTW6XSHftVFXRlPOBYCc1HQ3jcXZENSo2QbKYLUQAAeAfazbtc2cDEmxCwR+M41wqNxFbJX0gxtLuk7y3YtawC0bhiIXnHdSXtkZhKtVPvQcc4hNwu1uCS0Jv2sn4JC5ZR2RCoapbAwAbmMw1S/40zgn5919tt/u1cSP9NogtRAsF7gKbtfnhjsULYnpKNPjGTqJPIogapkmFMtz2npOP3wOoP70MTzwFbbIkBLPlzQexWl5GZHKTCocshR4zKCYNPtrISRebuCme+XdUpg8W/geYlXyCp08mK/iUqOjhbdMtId89UEZjgbkbG/RI77ZM4SVLJEAsHXXWFXEXkpFqd01vHy6oHbd9zOKZIZZxuvxa0wGagFDVUe5tZUpSvEwwB0ir9CH1DOO5jG4c6abcTGgGMqL5uNR3z6yua2Ts3gXzGBn8S0zH6popC7DR5OabcJU+cyEkbSi/BOsqt+zIFh25cI/0LZp1zb9UWnolnxDa8Z34YEMIVIACRgGQNAMZoZdrdUEqRJwmDz3iyXcEinQTr3d3JCcnzHNjNNRDS7D2agecx71D2uYggJgQHaJpttUAlp+/zNafit1XU57jLG2uX66d6UGTmKntruJJoPjTW0IxaQDxOSMjXDntKnY9uvKv4vvRI2ndyGx881jBjiHNfyzS2p4F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199018)(316002)(45080400002)(2906002)(86362001)(38100700002)(44832011)(82960400001)(41300700001)(235185007)(6916009)(8936002)(8676002)(83380400001)(4326008)(66946007)(107886003)(5660300002)(6506007)(21480400003)(33964004)(6486002)(478600001)(44144004)(966005)(66476007)(26005)(6512007)(186003)(66556008)(21314003)(67856001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WvGl5FtdZnm9O/2yEnJMtWok9y4QUnx6lwaCIOZyZz2F9WoEVl6U9yDR8DyV?=
 =?us-ascii?Q?ofdCkqjCxW0rnXXQrlJ70ov8BwKv8rntORsnWDjocwzkivwSCk6L5kBQZhFY?=
 =?us-ascii?Q?sQYRq6FdHxtz0mCKxojSydqi8+exnSTBceht5zQEC9hk3RCiDnzTf6nfOfPO?=
 =?us-ascii?Q?HfXYeMhPLaLUUHbbVmupDrEU9E6SSSzTY8VkC/hrzmTLDY+NYpawn8HSHIDF?=
 =?us-ascii?Q?Hia+WaTstTcgUTNTSWz0okApng6/RY4ffzTGLvpGGhkFWs6eOtBV/Yfsurjk?=
 =?us-ascii?Q?xhlOKRKft21JF9vkdsoPpXG6A/oP32pHlA5WMxNdK36JA5sXOo0K5kwdhluk?=
 =?us-ascii?Q?JOPk4zy+dytM4s50hseW563JSp6E208Y3yGxOOqoXwF9L87VOfdYoV0txm1w?=
 =?us-ascii?Q?lLl7MTbWBbuKldofBMQvix5eJXpDSq1/03EMt9yRWclQFALYZn6007N/xgfC?=
 =?us-ascii?Q?0xU3/4oS16rMj20T5ixhgRk06mBVCCLmHt/ntDOJQ60fDreiHlk4N2pJ0xKn?=
 =?us-ascii?Q?btvX8Ul+JKAvagmoY4vh8xm4VIkf2K1PMl0WR0QFwU1p4p2haOUfRqGhc4ah?=
 =?us-ascii?Q?+zF+unibvBXCeQA4IbPweB4HDtLzWxgzGARx67W85A0QaH1aJqgcWeTyqAnf?=
 =?us-ascii?Q?OmPsuM87KvHxI2A6kVYqvl0sE+YFaRbrQNlml50vA/6B/kPbe+iCAegcBc7E?=
 =?us-ascii?Q?jTXUYQw7K2NwMmB0bSLUZKgXpi4I0SKs+ubHlJDVA6eZRDPeuZ8Upc6xMuhv?=
 =?us-ascii?Q?JGrheOYsFzM501++KP17lJYOex9o9rVdBR7vFKsgpccb/9VNKiK8m485fWGl?=
 =?us-ascii?Q?08KNIM9+UZjIuub32yF2+YdfRciqaeYaw5lk5a3cAVXfNFnBIcXvXypr8smX?=
 =?us-ascii?Q?2Bh7fQodlFoiO/vto/7xrOvBXmP9358fhpGiZX5qPdkqJb0GgRtFY2j0pCgC?=
 =?us-ascii?Q?Zn1rj4MutNNaIkQ6FCOlbqQff+N5EmjDZt+drPDiJ9ZMieU95LcjFfsJnEJv?=
 =?us-ascii?Q?MMhvhSq5/Vcp5odSOF+ctXl50JfXu2rdJUrn30VsOjuMSmpysOP4h8YZGHtU?=
 =?us-ascii?Q?aY/gNb6306JU8Z7M5SFzMlDWuDvhUXkACO7hPc11hc3X47giAESiDvPAcf0Q?=
 =?us-ascii?Q?Mz3Bi+pqgYk4QC06rHwzv5znnxn72JIBt2djtxPcL5/B4gG3i3Y+wmkoEiLS?=
 =?us-ascii?Q?9S9MipBrFGy7Sb3c7Fge2qJvRwGb0p1/TRYOp8y3JbxddECQOr1/1/CVF4bl?=
 =?us-ascii?Q?gtKBPA/kG1EyGP0y7l4+/o+D27XskUsLthQA840pWztQt99jQPKzxS8jTDvt?=
 =?us-ascii?Q?4NDf7ms1yIQa5+0vC6b3sjdsduQM4pNGVqGk2PSn/Su422yT4XDJD480cWbG?=
 =?us-ascii?Q?WItky8yhpfyEIHBMhKuSKkXEw74+Pt6xEVmolyNKDFe6MO41Z7RoiiwYE2Rh?=
 =?us-ascii?Q?DbaRXnCeKWIhzqr8V9BcYNyZYaIC1SqItJ5mPQdlAxBrnoATm6PzWwxNtzSK?=
 =?us-ascii?Q?tiFlYw19Iek4PO6KVtHjs+lZ/kfnarqLwywTqCyju5C9kw/msgo2vcqdpWKN?=
 =?us-ascii?Q?pde+4blI1X4jhjG+hxq1/aohGTHbUXDtlu/A/aFEcuwisTwUl47Ax74TaQ2H?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3587dbfb-d861-472d-1897-08db0db0d81d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 10:55:40.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGIcBMy1NHLN01Izgb2Qr0LAGHMCfgKFUePiv2mALmgpxGq5b7Pk7U1sRyMwK3fXZ/7n61QwZyUbgbWfpvgqVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--5DqPYnvrX9NSYHIs
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Dave Chinner and xfs expert,

Greeting!

userspace arch: x86

There is "xfs_bmapi_convert_delalloc" WARNING in v6.2-rc7 kernel in guest:
[   31.180821] ------------[ cut here ]------------
[   31.181101] WARNING: CPU: 0 PID: 550 at fs/xfs/libxfs/xfs_bmap.c:4544 xfs_bmapi_convert_delalloc+0x793/0xf20
[   31.181692] Modules linked in:
[   31.181886] CPU: 0 PID: 550 Comm: repro Not tainted 6.2.0-rc7-4ec5183ec486 #1
[   31.182310] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   31.182989] RIP: 0010:xfs_bmapi_convert_delalloc+0x793/0xf20
[   31.183342] Code: f9 ff ff e8 0f fd 08 ff 44 89 e6 bf 02 00 00 00 41 bf f5 ff ff ff e8 dc fe 08 ff 41 83 fc 02 0f 84 eb fe ff ff e8 ed fc 08 ff <0f> 0b e9 df 0
[   31.184391] RSP: 0018:ff1100000d03ef20 EFLAGS: 00010246
[   31.184703] RAX: 0000000000000000 RBX: ff1100001eb47800 RCX: ffffffff82521274
[   31.185118] RDX: 0000000000000000 RSI: ff1100000efc8000 RDI: 0000000000000002
[   31.185531] RBP: ff1100000d03f120 R08: ff1100000d03f048 R09: fffffbfff0eb4055
[   31.185946] R10: ffffffff875a02a7 R11: fffffbfff0eb4054 R12: 0000000000000000
[   31.186363] R13: ff1100000d03f0f8 R14: ff1100000e544000 R15: 00000000fffffff5
[   31.186774] FS:  00007fd840a14700(0000) GS:ff1100006ca00000(0000) knlGS:0000000000000000
[   31.187306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.187648] CR2: 00007f6e90b65000 CR3: 0000000013fa2004 CR4: 0000000000771ef0
[   31.188069] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   31.188482] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   31.188897] PKRU: 55555554
[   31.189069] Call Trace:
[   31.189222]  <TASK>
[   31.189370]  ? __pfx_xfs_bmapi_convert_delalloc+0x10/0x10
[   31.189707]  ? __pfx_rwsem_wake+0x10/0x10
[   31.189996]  ? write_comp_data+0x2f/0x90
[   31.190260]  xfs_map_blocks+0x562/0xe40
[   31.190527]  ? __pfx_xfs_map_blocks+0x10/0x10
[   31.190800]  ? __this_cpu_preempt_check+0x20/0x30
[   31.191113]  ? lock_is_held_type+0xe6/0x140
[   31.191371]  ? rcu_lockdep_current_cpu_online+0x4b/0x160
[   31.191710]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   31.192012]  ? write_comp_data+0x2f/0x90
[   31.192270]  iomap_do_writepage+0xc6f/0x2ba0
[   31.192537]  ? write_comp_data+0x2f/0x90
[   31.192805]  ? __pfx_iomap_do_writepage+0x10/0x10
[   31.193093]  ? rcu_read_lock_sched_held+0xa9/0xd0
[   31.193389]  ? __pfx_rcu_read_lock_sched_held+0x10/0x10
[   31.193714]  ? write_comp_data+0x2f/0x90
[   31.193970]  write_cache_pages+0x573/0x12c0
[   31.194247]  ? __pfx_iomap_do_writepage+0x10/0x10
[   31.194543]  ? __pfx_write_cache_pages+0x10/0x10
[   31.194831]  ? __pfx_rcu_read_lock_sched_held+0x10/0x10
[   31.195173]  ? ncsi_channel_monitor.cold.17+0x204/0x3f7
[   31.195488]  ? lock_release+0x3f8/0x7d0
[   31.195729]  ? __this_cpu_preempt_check+0x20/0x30
[   31.196026]  ? xfs_vm_writepages+0x123/0x1c0
[   31.196298]  ? __pfx_lock_release+0x10/0x10
[   31.196561]  ? do_raw_spin_lock+0x132/0x2a0
[   31.196824]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   31.197117]  ? __kasan_check_read+0x15/0x20
[   31.197381]  iomap_writepages+0x5b/0xc0
[   31.197626]  xfs_vm_writepages+0x13c/0x1c0
[   31.197885]  ? __pfx_xfs_vm_writepages+0x10/0x10
[   31.198189]  ? lock_release+0x3f8/0x7d0
[   31.198429]  ? __pfx_rcu_read_lock_sched_held+0x10/0x10
[   31.198752]  ? write_comp_data+0x2f/0x90
[   31.199021]  ? __pfx_xfs_vm_writepages+0x10/0x10
[   31.199310]  do_writepages+0x1c5/0x690
[   31.199550]  ? __pfx_do_writepages+0x10/0x10
[   31.199816]  ? do_raw_spin_unlock+0x154/0x230
[   31.200096]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   31.200393]  ? wbc_attach_and_unlock_inode+0x585/0x8f0
[   31.200714]  filemap_fdatawrite_wbc+0x163/0x1d0
[   31.201005]  __filemap_fdatawrite_range+0xc9/0x100
[   31.201305]  ? __pfx___filemap_fdatawrite_range+0x10/0x10
[   31.201651]  ? write_comp_data+0x2f/0x90
[   31.201908]  filemap_write_and_wait_range.part.72+0x93/0x100
[   31.202264]  filemap_write_and_wait_range+0x48/0x60
[   31.202575]  __iomap_dio_rw+0x65e/0x1c80
[   31.202819]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   31.203131]  ? timestamp_truncate+0x1ee/0x2f0
[   31.203424]  ? __pfx___iomap_dio_rw+0x10/0x10
[   31.203697]  ? write_comp_data+0x2f/0x90
[   31.203952]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   31.204251]  ? write_comp_data+0x2f/0x90
[   31.204537]  iomap_dio_rw+0x4d/0xb0
[   31.204765]  xfs_file_dio_write_aligned+0x1e9/0x450
[   31.205077]  ? __pfx_xfs_file_dio_write_aligned+0x10/0x10
[   31.205412]  ? lock_is_held_type+0xe6/0x140
[   31.205676]  ? write_comp_data+0x2f/0x90
[   31.205932]  xfs_file_write_iter+0x530/0x750
[   31.206208]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   31.206513]  vfs_write+0xa65/0xe60
[   31.206736]  ? __pfx_vfs_write+0x10/0x10
[   31.206999]  ? __fget_files+0x270/0x400
[   31.207259]  ? write_comp_data+0x2f/0x90
[   31.207515]  ksys_write+0x143/0x280
[   31.207742]  ? __pfx_ksys_write+0x10/0x10
[   31.208013]  __x64_sys_write+0x7c/0xc0
[   31.208248]  ? syscall_enter_from_user_mode+0x51/0x60
[   31.208561]  do_syscall_64+0x3b/0x90
[   31.208791]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   31.209103] RIP: 0033:0x7fd846f5b59d
[   31.209324] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
[   31.210373] RSP: 002b:00007fd840a13e98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   31.210814] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd846f5b59d
[   31.211248] RDX: 0000000000001400 RSI: 0000000020000000 RDI: 0000000000000005
[   31.211663] RBP: 00007fd840a13ec0 R08: 0000000000000005 R09: 0000000000000000
[   31.212077] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc9b897cce
[   31.212491] R13: 00007ffc9b897ccf R14: 00007ffc9b897d60 R15: 00007fd840a14700
[   31.212929]  </TASK>
[   31.213072] irq event stamp: 995
[   31.213269] hardirqs last  enabled at (1003): [<ffffffff813dd0a1>] __up_console_sem+0x91/0xb0
[   31.213769] hardirqs last disabled at (1010): [<ffffffff813dd086>] __up_console_sem+0x76/0xb0
[   31.214272] softirqs last  enabled at (286): [<ffffffff8536af3f>] __do_softirq+0x53f/0x836
[   31.214754] softirqs last disabled at (211): [<ffffffff812498b0>] irq_exit_rcu+0x100/0x140
[   31.215258] ---[ end trace 0000000000000000 ]---

Bisected and found the first bad commit is:
7348b322332d8602a4133f0b861334ea021b134a
xfs: xfs_bmap_punch_delalloc_range() should take a byte range

After reverted above commit on top of v6.2-rc7 kernel, this issue was gone.

Reproduced code from syzkaller, kconfig, v6.2-rc7 kernel reproduced dmesg
are in attached.

More detailed bisect info is in link:
https://github.com/xupengfe/syzkaller_logs/tree/main/230207_175127_xfs_bmapi_convert_delalloc

And previous syzbot seems repored the similar issue in email name:
"[syzbot] [xfs?] WARNING in xfs_bmapi_convert_delalloc"
And I just updated the above bisected info for this issue.

I hope it's helpful.

---
If you need the reproduced virtual machine environment:

git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
   // You could change the bzImage_xxx as you want
In vm and login with root,  there is no password for root.

After login vm successfully, you could transfer reproduced binary to the VM by below way, and reproduce the problem:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use attached kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
make
make install

---

Thanks!
BR.

--5DqPYnvrX9NSYHIs
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="repro.c"

// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <setjmp.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>
#include <linux/loop.h>

#ifndef __NR_memfd_create
#define __NR_memfd_create 319
#endif

static unsigned long long procid;

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

static void use_temporary_dir(void)
{
  char tmpdir_template[] = "./syzkaller.XXXXXX";
  char* tmpdir = mkdtemp(tmpdir_template);
  if (!tmpdir)
    exit(1);
  if (chmod(tmpdir, 0777))
    exit(1);
  if (chdir(tmpdir))
    exit(1);
}

static void thread_start(void* (*fn)(void*), void* arg)
{
  pthread_t th;
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  pthread_attr_setstacksize(&attr, 128 << 10);
  int i = 0;
  for (; i < 100; i++) {
    if (pthread_create(&th, &attr, fn, arg) == 0) {
      pthread_attr_destroy(&attr);
      return;
    }
    if (errno == EAGAIN) {
      usleep(50);
      continue;
    }
    break;
  }
  exit(1);
}

typedef struct {
  int state;
} event_t;

static void event_init(event_t* ev)
{
  ev->state = 0;
}

static void event_reset(event_t* ev)
{
  ev->state = 0;
}

static void event_set(event_t* ev)
{
  if (ev->state)
    exit(1);
  __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
  syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev)
{
  while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev)
{
  return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout)
{
  uint64_t start = current_time_ms();
  uint64_t now = start;
  for (;;) {
    uint64_t remain = timeout - (now - start);
    struct timespec ts;
    ts.tv_sec = remain / 1000;
    ts.tv_nsec = (remain % 1000) * 1000 * 1000;
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
    if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
      return 1;
    now = current_time_ms();
    if (now - start > timeout)
      return 0;
  }
}

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

//% This code is derived from puff.{c,h}, found in the zlib development. The
//% original files come with the following copyright notice:

//% Copyright (C) 2002-2013 Mark Adler, all rights reserved
//% version 2.3, 21 Jan 2013
//% This software is provided 'as-is', without any express or implied
//% warranty.  In no event will the author be held liable for any damages
//% arising from the use of this software.
//% Permission is granted to anyone to use this software for any purpose,
//% including commercial applications, and to alter it and redistribute it
//% freely, subject to the following restrictions:
//% 1. The origin of this software must not be misrepresented; you must not
//%    claim that you wrote the original software. If you use this software
//%    in a product, an acknowledgment in the product documentation would be
//%    appreciated but is not required.
//% 2. Altered source versions must be plainly marked as such, and must not be
//%    misrepresented as being the original software.
//% 3. This notice may not be removed or altered from any source distribution.
//% Mark Adler    madler@alumni.caltech.edu

//% BEGIN CODE DERIVED FROM puff.{c,h}

#define MAXBITS 15
#define MAXLCODES 286
#define MAXDCODES 30
#define MAXCODES (MAXLCODES + MAXDCODES)
#define FIXLCODES 288

struct puff_state {
  unsigned char* out;
  unsigned long outlen;
  unsigned long outcnt;
  const unsigned char* in;
  unsigned long inlen;
  unsigned long incnt;
  int bitbuf;
  int bitcnt;
  jmp_buf env;
};
static int puff_bits(struct puff_state* s, int need)
{
  long val = s->bitbuf;
  while (s->bitcnt < need) {
    if (s->incnt == s->inlen)
      longjmp(s->env, 1);
    val |= (long)(s->in[s->incnt++]) << s->bitcnt;
    s->bitcnt += 8;
  }
  s->bitbuf = (int)(val >> need);
  s->bitcnt -= need;
  return (int)(val & ((1L << need) - 1));
}
static int puff_stored(struct puff_state* s)
{
  s->bitbuf = 0;
  s->bitcnt = 0;
  if (s->incnt + 4 > s->inlen)
    return 2;
  unsigned len = s->in[s->incnt++];
  len |= s->in[s->incnt++] << 8;
  if (s->in[s->incnt++] != (~len & 0xff) ||
      s->in[s->incnt++] != ((~len >> 8) & 0xff))
    return -2;
  if (s->incnt + len > s->inlen)
    return 2;
  if (s->outcnt + len > s->outlen)
    return 1;
  for (; len--; s->outcnt++, s->incnt++) {
    if (s->in[s->incnt])
      s->out[s->outcnt] = s->in[s->incnt];
  }
  return 0;
}
struct puff_huffman {
  short* count;
  short* symbol;
};
static int puff_decode(struct puff_state* s, const struct puff_huffman* h)
{
  int first = 0;
  int index = 0;
  int bitbuf = s->bitbuf;
  int left = s->bitcnt;
  int code = first = index = 0;
  int len = 1;
  short* next = h->count + 1;
  while (1) {
    while (left--) {
      code |= bitbuf & 1;
      bitbuf >>= 1;
      int count = *next++;
      if (code - count < first) {
        s->bitbuf = bitbuf;
        s->bitcnt = (s->bitcnt - len) & 7;
        return h->symbol[index + (code - first)];
      }
      index += count;
      first += count;
      first <<= 1;
      code <<= 1;
      len++;
    }
    left = (MAXBITS + 1) - len;
    if (left == 0)
      break;
    if (s->incnt == s->inlen)
      longjmp(s->env, 1);
    bitbuf = s->in[s->incnt++];
    if (left > 8)
      left = 8;
  }
  return -10;
}
static int puff_construct(struct puff_huffman* h, const short* length, int n)
{
  int len;
  for (len = 0; len <= MAXBITS; len++)
    h->count[len] = 0;
  int symbol;
  for (symbol = 0; symbol < n; symbol++)
    (h->count[length[symbol]])++;
  if (h->count[0] == n)
    return 0;
  int left = 1;
  for (len = 1; len <= MAXBITS; len++) {
    left <<= 1;
    left -= h->count[len];
    if (left < 0)
      return left;
  }
  short offs[MAXBITS + 1];
  offs[1] = 0;
  for (len = 1; len < MAXBITS; len++)
    offs[len + 1] = offs[len] + h->count[len];
  for (symbol = 0; symbol < n; symbol++)
    if (length[symbol] != 0)
      h->symbol[offs[length[symbol]]++] = symbol;
  return left;
}
static int puff_codes(struct puff_state* s, const struct puff_huffman* lencode,
                      const struct puff_huffman* distcode)
{
  static const short lens[29] = {3,  4,  5,  6,   7,   8,   9,   10,  11, 13,
                                 15, 17, 19, 23,  27,  31,  35,  43,  51, 59,
                                 67, 83, 99, 115, 131, 163, 195, 227, 258};
  static const short lext[29] = {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2,
                                 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0};
  static const short dists[30] = {
      1,    2,    3,    4,    5,    7,    9,    13,    17,    25,
      33,   49,   65,   97,   129,  193,  257,  385,   513,   769,
      1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577};
  static const short dext[30] = {0, 0, 0,  0,  1,  1,  2,  2,  3,  3,
                                 4, 4, 5,  5,  6,  6,  7,  7,  8,  8,
                                 9, 9, 10, 10, 11, 11, 12, 12, 13, 13};
  int symbol;
  do {
    symbol = puff_decode(s, lencode);
    if (symbol < 0)
      return symbol;
    if (symbol < 256) {
      if (s->outcnt == s->outlen)
        return 1;
      if (symbol)
        s->out[s->outcnt] = symbol;
      s->outcnt++;
    } else if (symbol > 256) {
      symbol -= 257;
      if (symbol >= 29)
        return -10;
      int len = lens[symbol] + puff_bits(s, lext[symbol]);
      symbol = puff_decode(s, distcode);
      if (symbol < 0)
        return symbol;
      unsigned dist = dists[symbol] + puff_bits(s, dext[symbol]);
      if (dist > s->outcnt)
        return -11;
      if (s->outcnt + len > s->outlen)
        return 1;
      while (len--) {
        if (dist <= s->outcnt && s->out[s->outcnt - dist])
          s->out[s->outcnt] = s->out[s->outcnt - dist];
        s->outcnt++;
      }
    }
  } while (symbol != 256);
  return 0;
}
static int puff_fixed(struct puff_state* s)
{
  static int virgin = 1;
  static short lencnt[MAXBITS + 1], lensym[FIXLCODES];
  static short distcnt[MAXBITS + 1], distsym[MAXDCODES];
  static struct puff_huffman lencode, distcode;
  if (virgin) {
    lencode.count = lencnt;
    lencode.symbol = lensym;
    distcode.count = distcnt;
    distcode.symbol = distsym;
    short lengths[FIXLCODES];
    int symbol;
    for (symbol = 0; symbol < 144; symbol++)
      lengths[symbol] = 8;
    for (; symbol < 256; symbol++)
      lengths[symbol] = 9;
    for (; symbol < 280; symbol++)
      lengths[symbol] = 7;
    for (; symbol < FIXLCODES; symbol++)
      lengths[symbol] = 8;
    puff_construct(&lencode, lengths, FIXLCODES);
    for (symbol = 0; symbol < MAXDCODES; symbol++)
      lengths[symbol] = 5;
    puff_construct(&distcode, lengths, MAXDCODES);
    virgin = 0;
  }
  return puff_codes(s, &lencode, &distcode);
}
static int puff_dynamic(struct puff_state* s)
{
  static const short order[19] = {16, 17, 18, 0, 8,  7, 9,  6, 10, 5,
                                  11, 4,  12, 3, 13, 2, 14, 1, 15};
  int nlen = puff_bits(s, 5) + 257;
  int ndist = puff_bits(s, 5) + 1;
  int ncode = puff_bits(s, 4) + 4;
  if (nlen > MAXLCODES || ndist > MAXDCODES)
    return -3;
  short lengths[MAXCODES];
  int index;
  for (index = 0; index < ncode; index++)
    lengths[order[index]] = puff_bits(s, 3);
  for (; index < 19; index++)
    lengths[order[index]] = 0;
  short lencnt[MAXBITS + 1], lensym[MAXLCODES];
  struct puff_huffman lencode = {lencnt, lensym};
  int err = puff_construct(&lencode, lengths, 19);
  if (err != 0)
    return -4;
  index = 0;
  while (index < nlen + ndist) {
    int symbol;
    int len;
    symbol = puff_decode(s, &lencode);
    if (symbol < 0)
      return symbol;
    if (symbol < 16)
      lengths[index++] = symbol;
    else {
      len = 0;
      if (symbol == 16) {
        if (index == 0)
          return -5;
        len = lengths[index - 1];
        symbol = 3 + puff_bits(s, 2);
      } else if (symbol == 17)
        symbol = 3 + puff_bits(s, 3);
      else
        symbol = 11 + puff_bits(s, 7);
      if (index + symbol > nlen + ndist)
        return -6;
      while (symbol--)
        lengths[index++] = len;
    }
  }
  if (lengths[256] == 0)
    return -9;
  err = puff_construct(&lencode, lengths, nlen);
  if (err && (err < 0 || nlen != lencode.count[0] + lencode.count[1]))
    return -7;
  short distcnt[MAXBITS + 1], distsym[MAXDCODES];
  struct puff_huffman distcode = {distcnt, distsym};
  err = puff_construct(&distcode, lengths + nlen, ndist);
  if (err && (err < 0 || ndist != distcode.count[0] + distcode.count[1]))
    return -8;
  return puff_codes(s, &lencode, &distcode);
}
static int puff(unsigned char* dest, unsigned long* destlen,
                const unsigned char* source, unsigned long sourcelen)
{
  struct puff_state s = {
      .out = dest,
      .outlen = *destlen,
      .outcnt = 0,
      .in = source,
      .inlen = sourcelen,
      .incnt = 0,
      .bitbuf = 0,
      .bitcnt = 0,
  };
  int err;
  if (setjmp(s.env) != 0)
    err = 2;
  else {
    int last;
    do {
      last = puff_bits(&s, 1);
      int type = puff_bits(&s, 2);
      err = type == 0 ? puff_stored(&s)
                      : (type == 1 ? puff_fixed(&s)
                                   : (type == 2 ? puff_dynamic(&s) : -1));
      if (err != 0)
        break;
    } while (!last);
  }
  *destlen = s.outcnt;
  return err;
}

//% END CODE DERIVED FROM puff.{c,h}

#define ZLIB_HEADER_WIDTH 2

static int puff_zlib_to_file(const unsigned char* source,
                             unsigned long sourcelen, int dest_fd)
{
  if (sourcelen < ZLIB_HEADER_WIDTH)
    return 0;
  source += ZLIB_HEADER_WIDTH;
  sourcelen -= ZLIB_HEADER_WIDTH;
  const unsigned long max_destlen = 132 << 20;
  void* ret = mmap(0, max_destlen, PROT_WRITE | PROT_READ,
                   MAP_PRIVATE | MAP_ANON, -1, 0);
  if (ret == MAP_FAILED)
    return -1;
  unsigned char* dest = (unsigned char*)ret;
  unsigned long destlen = max_destlen;
  int err = puff(dest, &destlen, source, sourcelen);
  if (err) {
    munmap(dest, max_destlen);
    errno = -err;
    return -1;
  }
  if (write(dest_fd, dest, destlen) != (ssize_t)destlen) {
    munmap(dest, max_destlen);
    return -1;
  }
  return munmap(dest, destlen);
}

static int setup_loop_device(unsigned char* data, unsigned long size,
                             const char* loopname, int* loopfd_p)
{
  int err = 0, loopfd = -1;
  int memfd = syscall(__NR_memfd_create, "syzkaller", 0);
  if (memfd == -1) {
    err = errno;
    goto error;
  }
  if (puff_zlib_to_file(data, size, memfd)) {
    err = errno;
    goto error_close_memfd;
  }
  loopfd = open(loopname, O_RDWR);
  if (loopfd == -1) {
    err = errno;
    goto error_close_memfd;
  }
  if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
    if (errno != EBUSY) {
      err = errno;
      goto error_close_loop;
    }
    ioctl(loopfd, LOOP_CLR_FD, 0);
    usleep(1000);
    if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
      err = errno;
      goto error_close_loop;
    }
  }
  close(memfd);
  *loopfd_p = loopfd;
  return 0;

error_close_loop:
  close(loopfd);
error_close_memfd:
  close(memfd);
error:
  errno = err;
  return -1;
}

static long syz_mount_image(volatile long fsarg, volatile long dir,
                            volatile long flags, volatile long optsarg,
                            volatile long change_dir,
                            volatile unsigned long size, volatile long image)
{
  unsigned char* data = (unsigned char*)image;
  int res = -1, err = 0, loopfd = -1, need_loop_device = !!size;
  char* mount_opts = (char*)optsarg;
  char* target = (char*)dir;
  char* fs = (char*)fsarg;
  char* source = NULL;
  char loopname[64];
  if (need_loop_device) {
    memset(loopname, 0, sizeof(loopname));
    snprintf(loopname, sizeof(loopname), "/dev/loop%llu", procid);
    if (setup_loop_device(data, size, loopname, &loopfd) == -1)
      return -1;
    source = loopname;
  }
  mkdir(target, 0777);
  char opts[256];
  memset(opts, 0, sizeof(opts));
  if (strlen(mount_opts) > (sizeof(opts) - 32)) {
  }
  strncpy(opts, mount_opts, sizeof(opts) - 32);
  if (strcmp(fs, "iso9660") == 0) {
    flags |= MS_RDONLY;
  } else if (strncmp(fs, "ext", 3) == 0) {
    bool has_remount_ro = false;
    char* remount_ro_start = strstr(opts, "errors=remount-ro");
    if (remount_ro_start != NULL) {
      char after = *(remount_ro_start + strlen("errors=remount-ro"));
      char before = remount_ro_start == opts ? '\0' : *(remount_ro_start - 1);
      has_remount_ro = ((before == '\0' || before == ',') &&
                        (after == '\0' || after == ','));
    }
    if (strstr(opts, "errors=panic") || !has_remount_ro)
      strcat(opts, ",errors=continue");
  } else if (strcmp(fs, "xfs") == 0) {
    strcat(opts, ",nouuid");
  }
  res = mount(source, target, fs, flags, opts);
  if (res == -1) {
    err = errno;
    goto error_clear_loop;
  }
  res = open(target, O_RDONLY | O_DIRECTORY);
  if (res == -1) {
    err = errno;
    goto error_clear_loop;
  }
  if (change_dir) {
    res = chdir(target);
    if (res == -1) {
      err = errno;
    }
  }

error_clear_loop:
  if (need_loop_device) {
    ioctl(loopfd, LOOP_CLR_FD, 0);
    close(loopfd);
  }
  errno = err;
  return res;
}

#define FS_IOC_SETFLAGS _IOW('f', 2, long)
static void remove_dir(const char* dir)
{
  int iter = 0;
  DIR* dp = 0;
retry:
  while (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW) == 0) {
  }
  dp = opendir(dir);
  if (dp == NULL) {
    if (errno == EMFILE) {
      exit(1);
    }
    exit(1);
  }
  struct dirent* ep = 0;
  while ((ep = readdir(dp))) {
    if (strcmp(ep->d_name, ".") == 0 || strcmp(ep->d_name, "..") == 0)
      continue;
    char filename[FILENAME_MAX];
    snprintf(filename, sizeof(filename), "%s/%s", dir, ep->d_name);
    while (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW) == 0) {
    }
    struct stat st;
    if (lstat(filename, &st))
      exit(1);
    if (S_ISDIR(st.st_mode)) {
      remove_dir(filename);
      continue;
    }
    int i;
    for (i = 0;; i++) {
      if (unlink(filename) == 0)
        break;
      if (errno == EPERM) {
        int fd = open(filename, O_RDONLY);
        if (fd != -1) {
          long flags = 0;
          if (ioctl(fd, FS_IOC_SETFLAGS, &flags) == 0) {
          }
          close(fd);
          continue;
        }
      }
      if (errno == EROFS) {
        break;
      }
      if (errno != EBUSY || i > 100)
        exit(1);
      if (umount2(filename, MNT_DETACH | UMOUNT_NOFOLLOW))
        exit(1);
    }
  }
  closedir(dp);
  for (int i = 0;; i++) {
    if (rmdir(dir) == 0)
      break;
    if (i < 100) {
      if (errno == EPERM) {
        int fd = open(dir, O_RDONLY);
        if (fd != -1) {
          long flags = 0;
          if (ioctl(fd, FS_IOC_SETFLAGS, &flags) == 0) {
          }
          close(fd);
          continue;
        }
      }
      if (errno == EROFS) {
        break;
      }
      if (errno == EBUSY) {
        if (umount2(dir, MNT_DETACH | UMOUNT_NOFOLLOW))
          exit(1);
        continue;
      }
      if (errno == ENOTEMPTY) {
        if (iter < 100) {
          iter++;
          goto retry;
        }
      }
    }
    exit(1);
  }
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

static void reset_loop()
{
  char buf[64];
  snprintf(buf, sizeof(buf), "/dev/loop%llu", procid);
  int loopfd = open(buf, O_RDWR);
  if (loopfd != -1) {
    ioctl(loopfd, LOOP_CLR_FD, 0);
    close(loopfd);
  }
}

static void setup_test()
{
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
  if (symlink("/dev/binderfs", "./binderfs")) {
  }
}

struct thread_t {
  int created, call;
  event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
  struct thread_t* th = (struct thread_t*)arg;
  for (;;) {
    event_wait(&th->ready);
    event_reset(&th->ready);
    execute_call(th->call);
    __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
    event_set(&th->done);
  }
  return 0;
}

static void execute_one(void)
{
  int i, call, thread;
  for (call = 0; call < 5; call++) {
    for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
         thread++) {
      struct thread_t* th = &threads[thread];
      if (!th->created) {
        th->created = 1;
        event_init(&th->ready);
        event_init(&th->done);
        event_set(&th->done);
        thread_start(thr, th);
      }
      if (!event_isset(&th->done))
        continue;
      event_reset(&th->done);
      th->call = call;
      __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
      event_set(&th->ready);
      event_timedwait(&th->done, 50 + (call == 0 ? 4000 : 0));
      break;
    }
  }
  for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
    sleep_ms(1);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
  int iter = 0;
  for (;; iter++) {
    char cwdbuf[32];
    sprintf(cwdbuf, "./%d", iter);
    if (mkdir(cwdbuf, 0777))
      exit(1);
    reset_loop();
    int pid = fork();
    if (pid < 0)
      exit(1);
    if (pid == 0) {
      if (chdir(cwdbuf))
        exit(1);
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
    remove_dir(cwdbuf);
  }
}

uint64_t r[2] = {0xffffffffffffffff, 0xffffffffffffffff};

void execute_call(int call)
{
  intptr_t res = 0;
  switch (call) {
  case 0:
    memcpy((void*)0x20000080, "xfs\000", 4);
    memcpy((void*)0x20000000, "./file0\000", 8);
    memcpy(
        (void*)0x20017140,
        "\x78\x9c\xec\xdd\x0b\x6c\x9d\x65\x1d\xc0\xe1\xaf\x5d\x5b\x3a\x25\x64"
        "\x24\x0b\xa2\xdc\xa6\x48\x44\x11\xd9\x56\xe2\x98\x68\x68\xcb\xe8\x56"
        "\x2e\x05\x01\xb1\x72\x91\x8d\xad\xdd\xc6\x06\xe3\xb2\xc1\x18\xc2\xca"
        "\x44\xc2\x9d\x09\x68\x06\x02\x6e\xc8\x70\x08\x93\x89\xdb\x50\x61\x38"
        "\x62\x63\x14\x07\x21\x66\x31\x6a\xf0\x42\xc4\x44\x12\x51\xa2\x44\x5d"
        "\x60\xd4\x7c\x3d\x17\xda\xb3\xae\x59\xdf\xee\x7d\xab\xec\x79\x92\xf5"
        "\x9c\xef\x3b\xfd\xbf\x6b\xcf\xef\xbc\xdf\x09\x84\x70\xda\x5b\xce\x68"
        "\xce\xb2\x9a\xac\xa0\x2b\xab\xf4\x4a\xc7\x89\x9d\x17\xfc\xb9\x75\xe6"
        "\x9a\x83\xab\x8e\xbc\x7f\xda\xa5\x8f\x17\xce\x36\xd6\x17\x1f\x6e\x2c"
        "\xde\x36\x15\x6f\x9b\xb3\xde\xc5\x7a\x4f\x57\x17\x4e\xd5\xac\x58\xbf"
        "\xa1\x3a\x3f\xa8\xee\xbb\xee\x7b\x46\x8f\xae\xda\x27\xcb\x66\x56\xac"
        "\x33\xa9\x70\x73\xf5\x84\xd2\xf7\xf5\x54\x28\x9e\x1e\x57\x7a\xbc\xba"
        "\x7c\x58\x75\x73\xe1\x4f\xd9\x7b\xf3\x2f\x2f\x74\x2f\xbb\x36\xcb\xb2"
        "\x31\x7d\xe6\xab\xb2\x2c\x1b\xbf\xc3\x2f\xba\x87\x6a\x6f\x9a\xda\x52"
        "\x7c\x4e\xb2\x3e\xdd\x46\x15\x1f\xae\x7a\xe7\xb1\xde\xdb\x9a\xc2\x9f"
        "\xe3\x9e\xcb\xb2\xe3\x36\x67\x3b\x7d\x7d\x8c\xa8\xfc\xe7\x1c\x73\xca"
        "\xf6\x35\x27\x8e\xf4\x0f\xf2\xff\xa0\xbd\x69\x6a\x6b\x45\xff\xc6\x62"
        "\xe7\xaa\xe2\x7e\x6c\xac\xdc\x83\x7b\xa2\xca\xd7\xf9\xb3\x4f\xbd\xef"
        "\xd1\xe2\x53\xd8\xfb\x7a\x1b\xc1\x84\xc3\xd2\xde\xd4\x72\x72\x36\xc8"
        "\x3e\x3e\x62\xcd\xdb\xe7\xf6\x14\xae\x9b\xb5\x59\x96\xd5\x65\x59\xb6"
        "\x57\x96\x65\xf5\x23\xdd\x83\xdd\xa3\xa9\xb9\x21\x7f\xcf\xae\x2e\x1d"
        "\x17\xb3\x97\xf6\xff\x98\x81\x5e\x17\xf3\xce\x9f\xb0\x24\xcb\xb2\xfd"
        "\xf2\xb7\xf1\xc2\xf5\xa2\xf0\x5e\xb0\x0b\x0e\x89\xf1\x1a\x06\xc2\x34"
        "\x35\x37\x1c\x3f\xc0\xfe\xaf\x1b\x6c\xff\x2f\xfa\x5b\xe7\x85\x81\xfb"
        "\x1f\xf8\x1f\xd2\xda\xd4\xdc\x90\xef\xf5\x8a\xfd\x5f\x3f\xd8\xfe\x3f"
        "\xec\xcc\x5b\xce\x2a\xec\xfb\xc6\x49\x85\xa9\xb7\x47\xf6\x97\x00\x00"
        "\x00\x00\x00\x06\x74\xf9\x55\x4b\xe6\xcd\x98\x3f\xbf\xe3\x32\x77\xdc"
        "\x71\xc7\x9d\xf2\x9d\x91\xbe\x32\x01\xb1\xbd\xb3\xe9\x47\xfa\x27\x01"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x76\x55\x8a\xff\x9c\x78\xa4\x7f"
        "\x47\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x78\xb7\x68\x6d\x6b\x7a"
        "\x6d\x54\x55\xbf\x53\xa3\xfa\x1e\x1c\xf4\x7c\x47\xef\xed\xd1\xff\x6e"
        "\x9f\xb3\x7a\xf5\xc6\x7d\x4b\xb7\xc5\x87\x4f\x1a\x60\xc9\x7e\x9f\xf3"
        "\xdf\xd3\xd3\xd3\xf3\x8b\xcd\x9f\xdc\x50\x3c\xdc\xab\xe2\xf3\xb2\xeb"
        "\x2b\x87\xf3\xf5\x97\x6e\x5b\xdd\x5e\x3c\x6c\xac\xfc\xfc\xc1\xda\xde"
        "\xb3\xb5\xd9\xf4\xce\xb9\xf3\x3b\xc6\xe7\x7f\xd5\xf1\xb5\xd9\xe2\xfc"
        "\x60\x42\xbe\x6e\x4b\x6d\xb6\x3c\x3f\x98\x98\x1f\x4c\xad\xcd\xd6\xe4"
        "\x07\x0d\xbd\x07\xa3\xb3\xcd\xf9\xc1\x27\x66\x2e\x98\x3f\x2b\x3f\x31"
        "\x2d\xf0\x19\x7b\x77\x69\x6d\xeb\xca\x46\xf5\x2b\x96\xf5\x7b\x35\xf4"
        "\xed\xbf\x74\x5b\xf7\x8a\xd2\xed\x20\x4b\x96\x56\xab\xc9\x8a\xfd\x9f"
        "\xfc\xc9\xfa\x55\x15\x8f\x95\xec\xa4\x7f\x79\xfd\xa6\x9d\x7d\x2e\x39"
        "\xbb\xc7\xd0\xfa\x6f\x99\x53\xba\x1d\x64\xc9\x1d\xf6\xff\x73\xf7\xfc"
        "\xbc\x7d\xa0\xc7\x76\xde\xbf\xbc\x7e\xb3\xfe\x71\x0d\x70\xfd\xef\xd7"
        "\xa8\xf2\xba\x5f\x71\xfd\x1f\x37\xc0\x92\xe5\xf9\xce\x6d\xcf\x2f\xce"
        "\xfb\xcf\xb8\xe4\xd5\xee\xe2\xa9\x9a\x5d\xb9\xfe\xf7\x59\xff\xf8\xca"
        "\xfe\xbd\x8b\x97\xaf\xff\xf9\x52\x53\x4a\xd7\xff\xfc\xbd\xe5\x84\x61"
        "\x3d\x19\x7b\xa0\xd6\xb6\xeb\x5e\x1b\x6c\xff\x0f\xde\xbf\xe6\x03\xc5"
        "\x6f\xab\xee\x33\x5b\x5e\xed\xa1\x67\x37\xde\x96\xf7\xff\xed\x79\xe7"
        "\x94\x5e\x27\xb5\x43\xec\x3f\x65\xb0\xfd\x5f\x35\x6e\x87\xeb\x09\x43"
        "\xd4\xda\xb6\xaa\xa7\x62\xff\x0f\xa1\x7f\xf6\x91\x01\x96\x2c\x37\x39"
        "\x74\xe1\xad\x2b\xf2\xfe\x2f\x5f\x71\xc0\xa2\x3e\x8f\x0d\xa5\xff\x09"
        "\x95\xfd\x8f\x5a\x78\xd1\x25\x47\x5d\x7e\xd5\x92\x23\xe7\x5e\x34\x63"
        "\x76\xc7\xec\x8e\x8b\x1b\x26\x4d\x9c\x3c\xb9\x61\xf2\x31\x93\x1a\x8e"
        "\xea\xbd\x24\x14\xbe\x0e\xef\x49\xd9\x83\x0c\x6f\xff\xf7\x7e\xfe\x7f"
        "\xdf\x99\xaa\x2c\x3b\xac\x3c\xbf\xae\xfb\x81\xbf\xe7\xfd\x3f\x36\x67"
        "\xee\xd8\xe2\xa9\xfa\x21\xf6\x6f\x19\x74\xff\x4f\xef\xff\xb3\xd2\xc7"
        "\x87\xaa\xb3\xba\xba\x6c\xf1\x8c\x85\x0b\x2f\x9b\x50\xf8\x5a\x3a\x9c"
        "\x58\xf8\x5a\xf8\xb6\x01\xfa\x0f\xe1\xfd\xff\xd0\xc3\x8b\xdf\x36\xba"
        "\x78\x5b\x95\x65\xfb\x97\xe7\xaf\xb8\x7d\xd3\x5b\x79\xff\x4f\xdd\xb5"
        "\x7d\x7a\xf1\x54\xdd\x10\xfb\x4f\x1d\xb4\x7f\x57\xf9\xef\x25\xd0\x30"
        "\xf7\xff\xac\x8a\x99\x7e\xfd\xeb\xf6\xdf\x77\x7b\xde\xff\xd4\x13\x9e"
        "\x79\xa2\x78\x6a\xa8\xef\xff\xd3\x06\xeb\x5f\xbd\xd2\xfe\x1f\xae\xd6"
        "\xb6\x8a\x7f\xe1\xb3\x9b\xe5\xfd\x2f\x58\xb9\x72\x4b\xe0\x78\xab\x7f"
        "\xfe\x8b\x2b\x45\xff\xc9\xeb\x1e\x5b\x1d\x38\x7e\xa2\xfe\x71\xa5\xe8"
        "\xff\xfa\x8f\xd7\x2c\x0b\x1c\x3f\x49\xff\xb8\x52\xf4\xbf\x63\xf9\xfa"
        "\x2b\x03\xc7\x4f\xd6\x3f\xae\x14\xfd\x5b\xbe\xb9\xee\xb4\xc0\xf1\x53"
        "\xf4\x8f\x2b\x45\xff\x83\xee\x78\x7a\x72\xe0\x78\x9b\xfe\x71\xa5\xe8"
        "\xbf\xb5\xeb\x07\x07\x07\x8e\x9f\xaa\x7f\x5c\x29\xfa\x4f\xdf\xf8\xfa"
        "\xda\xc0\xf1\xd3\xf4\x8f\x2b\x45\xff\x47\x7e\xf8\xc6\xcd\x81\xe3\x9f"
        "\xd5\x3f\xae\x14\xfd\xff\xf1\xc8\x7f\xfe\x14\x38\x7e\xba\xfe\x71\xa5"
        "\xe8\x7f\xec\xc3\x6f\x75\x07\x8e\x9f\xa1\x7f\x5c\x29\xfa\x4f\xb9\xe9"
        "\x8f\x13\x02\xc7\xcf\xd4\x3f\xae\x14\xfd\x6f\xbb\xe1\x95\xfd\x02\xc7"
        "\x3f\xa7\x7f\x5c\x29\xfa\xff\xea\xeb\x7f\x59\x1a\x38\x7e\x96\xfe\x71"
        "\xa5\xe8\x7f\xc8\x3d\x7f\x6d\x0f\x1c\xff\xbc\xfe\x71\xa5\xe8\xff\x9b"
        "\x67\x3e\xbd\x3c\x70\xbc\x5d\xff\xb8\x52\xf4\x1f\xf3\xbd\x63\x9e\x0c"
        "\x1c\xff\x82\xfe\x71\xa5\xe8\x7f\xd2\xaa\xa3\x7f\x1f\x38\x7e\xb6\xfe"
        "\x71\xa5\xe8\xbf\xec\xbb\xe3\xb7\x05\x8e\x9f\xa3\x7f\x5c\x29\xfa\x6f"
        "\xbf\xee\xe3\x7b\x07\x8e\x9f\xab\x7f\x5c\x29\xfa\x1f\x7d\xfb\xe1\x47"
        "\x04\x8e\x9f\xa7\x7f\x5c\x29\xfa\x2f\x78\xe0\xc3\xcd\x81\xe3\x5f\xd4"
        "\x3f\xae\x14\xfd\x1f\xfe\xea\xb8\x8e\xc0\xf1\xf3\xf5\x8f\x2b\x45\xff"
        "\x7f\x7d\xa5\xfd\x83\x81\xe3\xd3\xf5\x8f\x2b\x45\xff\xe3\x6e\x3e\xb7"
        "\x2e\x70\x7c\x86\xfe\x71\xa5\xe8\x3f\xeb\xde\xd3\x16\x04\x8e\x5f\xa0"
        "\x7f\x5c\x29\xfa\xaf\xfd\xda\x99\xa1\xff\xb3\x95\x99\xfa\xc7\x95\xa2"
        "\xff\x2f\x7f\x34\x6d\x53\xe0\xf8\x2c\xfd\xe3\x4a\xd1\xff\x80\x0d\x27"
        "\xdf\x1b\x38\xde\xa1\x7f\x5c\x29\xfa\x37\xae\x6e\xfc\x67\xe0\x78\xa7"
        "\xfe\x71\xa5\xe8\x7f\xd3\x77\xa6\x6c\x0d\x1c\x9f\xad\x7f\x5c\x29\xfa"
        "\x9f\x7a\xdb\xdd\x07\x06\x8e\xcf\xd1\x3f\xae\x14\xfd\x6f\x58\xb6\xfc"
        "\xd8\xc0\xf1\xb9\xfa\xc7\x95\xa2\xff\xef\xee\xbc\xef\xf4\xc0\xf1\x0b"
        "\xf5\x8f\x2b\x45\xff\xb1\xf7\xaf\x58\x14\x38\x3e\x4f\xff\xb8\x52\xf4"
        "\x9f\xf7\xc4\xf5\x5d\x81\xe3\xf3\xf5\x8f\x2b\x45\xff\x07\x37\x75\x7d"
        "\x3b\x70\xfc\x22\xfd\xe3\x4a\xd1\x7f\xdb\xda\x5b\x5f\x08\x1c\xbf\x58"
        "\xff\xb8\x52\xf4\x1f\xff\xe0\x8d\xaf\x06\x8e\x2f\xd0\x3f\xae\x14\xfd"
        "\xaf\xbf\x7b\xf3\xd9\x81\xe3\x97\xe8\x1f\x57\x8a\xfe\xa7\x7c\xa3\xfb"
        "\x9a\xc0\xf1\x4b\xf5\x8f\x2b\x45\xff\xfd\x6e\xf9\xd9\xd8\xc0\xf1\xcb"
        "\xf4\x8f\x2b\x45\xff\x3f\x5c\xbf\xa5\x21\x70\xfc\x72\xfd\xe3\x4a\xd1"
        "\x7f\xe5\xa3\x2f\xfe\x34\x70\x7c\xa1\xfe\x71\xa5\xe8\x3f\xf7\xa1\xad"
        "\x2f\x07\x8e\x2f\xd2\x3f\xae\x14\xfd\x27\xae\xff\xf5\x8d\x81\xe3\x57"
        "\xe8\x1f\x57\x8a\xfe\x6f\x3e\xf5\x52\x68\xb7\x2b\xf5\x8f\x2b\x45\xff"
        "\xcf\xdc\xb7\xf7\xec\xc0\xf1\xc5\xfa\xc7\x95\xa2\xff\x1b\x77\xd5\x37"
        "\x06\x8e\x5f\xa5\x7f\x5c\x29\xfa\x3f\xfe\xe5\x9a\x8f\x06\x8e\x2f\xd1"
        "\x3f\xae\x14\xfd\x3b\x6f\xcd\xf6\x09\x1c\xbf\x5a\xff\xb8\x52\xf4\x7f"
        "\xff\xb7\x0e\x7c\x33\x70\xfc\x4b\xfa\xc7\x95\xa2\xff\x8b\x8f\xed\xff"
        "\x52\xe0\xf8\x35\xfa\xc7\x95\xa2\xff\x2d\x4f\x8f\xdd\x10\x38\x7e\xad"
        "\xfe\x71\xa5\xe8\xdf\xfc\xfd\x31\x77\x06\x8e\x2f\xd5\x1f\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\xfe\xcb\x0e\x1c\x08\x00\x00\x00\x00\x00\xf9\xbf\x36\x42\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x15\x76\xe0\x40\x00"
        "\x00\x00\x00\x00\xc8\xff\xb5\x11\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xb0\x03\x07\x02\x00\x00\x00\x00\x40\xfe"
        "\xaf\x8d\x50\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x85\xbd\xbb\x80\xb6\xac\x2c\xfc\x3e\x7e\x67\x98\x19\x52\x52\x11"
        "\x41\x90\x14\x54\x1a\x15\x10\x94\x2e\xc5\xa0\x14\x15\xe9\x94\x4e\x09"
        "\x25\x2c\x04\x01\x41\x51\x51\x42\x52\x11\x45\x10\x01\x15\x05\x01\x41"
        "\xe9\xee\xee\xee\x6e\xde\x35\x4c\x88\xe3\x6f\x10\x5d\xbc\x7f\xd4\xdf"
        "\xe7\xb3\xd6\xdc\x7b\x6a\x36\xcf\x79\xbe\x7b\xef\x7b\xe6\xee\x73\x36"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6f\xbc\x55\x97\x5e\x69\xf1\x81"
        "\x81\x21\x23\xaf\xed\xfa\x0f\xf7\xdf\xb1\xde\x47\xd7\x5f\xfb\xce\xe5"
        "\xd6\x39\x7a\xba\x41\x73\x1c\xbc\xec\x96\xc7\x8d\xb8\x75\xd1\xf1\x46"
        "\xde\xbd\xe8\xcb\x63\x18\x78\x65\x61\x8b\x0e\xbf\x6f\xf0\x88\x87\x0c"
        "\x39\xe0\xc4\xa3\x06\x0f\xbf\x32\xf8\xd5\xcb\x9d\x60\xfc\xf1\x07\x4d"
        "\x3c\x30\x68\x9d\x3c\xaa\x9d\x56\xff\x27\xc3\x9e\x7e\xd4\x85\xc1\xa3"
        "\xaf\x0e\xda\x73\xc4\x9f\xd1\x26\x1c\xfe\x65\xd8\xfe\xa7\x0d\x1f\xf3"
        "\xa4\xff\x64\x79\xb5\x56\x5d\x6c\x99\xa5\x87\x4f\xde\x88\x3f\xa3\xbb"
        "\x8d\x33\xf2\xee\x91\xb7\x8f\xbe\x3c\x64\xc4\x9f\x85\xd6\x18\x18\x58"
        "\x68\xb5\x81\xb1\xae\x1f\x6f\xbe\xa7\x8e\x3a\x73\xd0\x9b\x3d\x86\xff"
        "\x06\xab\x2e\xb6\xcc\x72\x63\xf4\x1f\x18\xd9\xf9\x95\xf9\x1b\x73\xfb"
        "\x6e\x35\xe6\x7a\x3e\xc3\x81\xeb\xcd\xf5\xa6\x86\x7b\x83\xac\xba\xd8"
        "\xd2\xcb\x0f\x6f\x3d\xb6\xed\x78\xfd\x99\x66\xdf\xe1\xe5\x57\xf6\xeb"
        "\x43\x0e\x1d\x18\x18\x72\xd8\xc0\xc0\x90\xc3\x07\x06\x86\x1c\xf1\x66"
        "\xf7\xe0\x8d\xb1\xd8\xe2\xf3\x2d\x3e\x7c\x9f\x3f\xea\xfa\x88\xea\xbb"
        "\x8e\x7a\x41\x90\xf6\xef\x83\x4e\x9e\x7e\xfd\xb3\x07\x06\x06\x86\x8e"
        "\xf8\x39\x31\xe4\xc8\x51\x3f\x0b\x80\xff\x2e\x8b\x2d\x3e\xdf\x12\x61"
        "\xfb\x1f\x36\xea\xfe\xb4\xfd\x1f\xbd\xdf\x3c\x57\xda\xfe\xe1\xbf\xdf"
        "\x72\x8b\x2d\x3e\xdf\xc0\xab\x5e\xe7\x8f\xb8\x75\xd7\x51\xff\xbe\x8f"
        "\xdb\xff\x56\x5b\x6c\xf6\xcf\xfe\x7d\x0e\x00\x00\x00\xfc\x07\x79\xe9"
        "\xc1\x53\x4e\x1b\x79\xac\x6f\xf0\xc0\xc0\x74\x03\x63\x1c\xef\x7d\xc5"
        "\xc8\xdf\x0b\x0c\x3a\xfe\xf4\x4b\x2e\x79\xd3\x06\xfa\x9f\x21\x1c\x27"
        "\xfb\xc7\xf7\x4c\xfc\x97\x19\xde\x79\xbc\x63\xa6\x1f\x18\xd8\x6c\x95"
        "\x37\x7b\x28\xbc\x09\xbc\x4f\xa2\x9b\xfe\xdd\xf4\xef\xa6\x7f\x37\xfd"
        "\xbb\xe9\xdf\x4d\xff\x6e\xfa\x77\xd3\xbf\x9b\xfe\xdd\xf4\xef\xa6\x7f"
        "\x37\xfd\xbb\xe9\x5f\x6c\x2c\xc7\xff\x27\x1d\xf5\xfd\xa5\x39\xf7\x99"
        "\x73\xe4\x43\x67\x39\xfe\x94\xed\xcf\x1d\xf3\xef\x0f\xbf\x6d\xbc\xff"
        "\xf3\x51\xbf\x69\xfe\x57\x8f\xff\x0f\x6c\x34\x68\x44\xcb\xe1\xcd\x37"
        "\x1a\x18\x18\xf8\xc4\x62\x2b\xae\x3c\xdb\xc0\xc0\xc0\xb9\xdb\x9f\x72"
        "\xfc\x8c\x03\xa3\xef\x5b\x60\xf8\x7d\x0b\x4d\x3e\xce\xc8\x13\x04\xcc"
        "\xf6\xca\xd7\xa5\xc6\xb2\xe0\x51\x9f\x26\x7f\xe5\x64\x0d\x13\x8c\x5e"
        "\xc6\xf1\xaf\x2c\x7f\xb9\x97\x0f\x1b\x67\xd0\x18\x83\x78\x95\xc9\x4e"
        "\x3e\xea\xa8\x0d\x57\x7d\xfa\xfd\x63\x7e\x9f\x75\xec\xcf\x63\xf4\xf9"
        "\x25\x0e\xd8\x6b\x9b\x99\x46\x7d\x96\x65\xf0\x18\x0f\x1a\xdb\xba\x3a"
        "\x6a\xf9\xa3\x9e\xcb\x98\x9d\x47\x8e\x7d\xb6\xe1\x63\x9f\x6b\x9b\x4d"
        "\xb7\x98\x6b\xeb\x1d\x76\x9c\x63\xa3\x4d\xd7\xda\x60\xbd\x0d\xd6\xdb"
        "\x6c\xbe\xf9\xe7\x5d\x70\xc1\xf9\x16\x5c\x60\xfe\xf9\xe6\x5a\x7f\xa3"
        "\x4d\xd6\x9b\x7b\xc4\xd7\xb1\xcc\xd9\x88\x53\x57\x2c\xf1\x7a\xe6\x6c"
        "\xd8\x98\x73\xf6\xe0\x62\xaf\x9e\xb3\x31\x9f\xdb\xd8\xe6\x6c\xfa\xd7"
        "\x9e\xb3\x57\x96\xb8\xfd\x85\xcf\xae\x3f\x6a\xce\x86\xfc\x8b\x73\xb6"
        "\xc4\x6b\xcf\xd9\xf4\x1b\x8d\x1a\xeb\xa2\x43\x07\xd6\x7c\x65\x6a\x86"
        "\xff\x27\x97\x1c\x3a\xb0\xfd\xf0\x2b\xf3\x8c\x3b\x7c\x15\x1a\xf9\xd8"
        "\xa9\x86\x3f\x76\xe1\xc9\x07\x0f\x0c\xec\xfb\xb7\x27\x3a\xfc\xd2\xb8"
        "\xa3\xd7\xc1\x41\xbb\x6e\xf4\x06\x9c\xb7\x64\xe4\xf7\xc5\x46\x7e\x5f"
        "\x3c\x9e\xb7\xe4\xa4\xb1\x9d\xb7\x64\x60\x9d\x31\x96\xb3\xe0\x88\x6f"
        "\xdb\x9c\x3a\xea\x71\x63\x7e\xce\x7a\xe4\xcd\xaf\xfb\xbc\x25\x0b\x9f"
        "\xb9\xda\x02\xc3\xb7\xc5\x31\xfe\xfe\xff\x0f\xff\xd6\xcf\xff\x7f\xe8"
        "\xb5\xc0\xa0\xd1\x13\x35\xea\xa4\x21\x23\x1f\x33\xa2\xd7\xdf\xce\x33"
        "\x31\x6a\xda\x16\x7d\xd5\x79\x26\xe6\x4f\xe7\x92\x79\x23\xfd\xc3\x78"
        "\xa7\x1f\x3c\x7a\xbd\x4e\xe3\x1d\xf9\xb9\xb8\x41\x63\xcc\xff\x6b\x7d"
        "\x2e\x6e\x60\xdd\x3d\x4e\x98\x6d\xc4\xf3\x5a\x74\xfe\x11\x7f\xeb\xa5"
        "\x7f\x3b\x4a\xde\x77\x2c\xff\xb7\xd9\x0b\xfe\x6e\xdf\x31\xf0\xda\xfb"
        "\x8e\x71\xfe\x76\xf1\x6f\xb7\xae\x77\xe1\xb4\x63\xee\x3b\x3e\x36\xf6"
        "\x21\xfe\xdd\x76\x31\x6a\x8e\xc6\x1d\xe3\x41\x63\xdb\x77\xac\x7a\xd4"
        "\xb3\xbb\x0c\x5f\xfe\xa8\x31\x8f\x65\xdf\xb1\xfc\x46\x23\x3f\x68\xfc"
        "\xb7\x7d\xc7\xf0\xff\xec\x12\xa3\xf6\x1d\xc3\xc7\xbe\xf4\xd0\x81\x7d"
        "\x87\x5f\x99\x77\xf8\x95\x65\x86\x0e\x1c\x3d\xfc\xca\x7c\xaf\x5c\x19"
        "\x7f\xe0\xf4\xe1\x57\xe6\x5c\x67\xf3\x4d\xd6\x1d\x7e\xc3\xb2\xff\xb8"
        "\xde\xce\x36\xe8\xef\xde\xf0\x18\xd6\xdb\xa5\xc7\x58\x6f\x5f\xc7\xf9"
        "\x71\x16\x39\x6f\x60\x60\x91\xd3\xd3\xf3\x1a\xfb\x74\x66\x69\xbd\x1d"
        "\xf6\x1a\xe3\xcd\x9f\xe7\x1e\x78\xcd\xcf\x73\x6f\x7c\xc7\x9c\x97\x0c"
        "\x0c\x0c\x4c\x39\xe2\xa7\xf4\xf0\x27\x39\x62\xec\xff\x8e\x34\xde\x21"
        "\xaf\x3d\xde\x70\xfe\x89\x81\xd7\x3a\xff\xc4\xc0\xb6\xab\xec\x70\xfa"
        "\x1b\x3c\xde\xd1\xdb\xd9\x2b\xeb\xda\xc8\xd3\x45\x2d\x3b\x96\xbf\xf3"
        "\x77\xdb\xd9\xa4\xff\xb0\x9d\xed\x36\xce\xab\xb6\x8c\xd7\xfb\xba\x66"
        "\xdd\xf0\xf8\x11\x97\xa7\x1a\xbd\xb4\x17\x27\x9b\x6a\xd8\xa8\x39\x1a"
        "\x3a\xc6\x72\xff\xd9\xcf\xe8\x51\xcf\x25\xf5\x1f\xf5\x9a\xef\xd5\x06"
        "\x1f\x3a\x30\xe8\xb5\xe6\x66\x99\xd7\x33\x37\x13\xbf\xf6\xdc\xbc\xde"
        "\xd7\x2f\xb3\xcd\x34\xe2\xfe\xf1\x5f\x63\x6e\x5e\x38\x75\x9f\xed\x46"
        "\xcd\xcd\xb0\x7f\x71\x6e\x96\x19\xcb\xdc\xbc\xfa\xf5\xf0\xab\x0d\xda"
        "\x75\x60\xfc\xbf\x9f\x9b\x21\xaf\xbc\x06\x9e\x79\xe4\xdc\x2c\xfd\x7a"
        "\xe6\x66\xa2\x37\x66\xbd\x99\x20\x3c\x7e\xc4\xe5\x59\x46\xdf\xf4\xf0"
        "\x21\x67\x1d\x3f\x6a\x6e\xc2\x5c\xc4\x9f\xff\xa3\x96\xbf\xf4\xbf\x3a"
        "\x37\x6b\x8e\x5e\x6f\x66\x7e\xe5\xbe\x19\x07\x0f\x0c\x1b\x36\xb0\xfd"
        "\x5a\xdb\x6c\xb3\xd5\x3c\x23\xbe\x8e\xba\x3a\xef\x88\xaf\xaf\xbd\x0d"
        "\x2e\xf9\x7a\xe6\x72\xbc\x37\x66\x2e\xa7\x1e\xb9\xd7\x19\xfc\x8f\x93"
        "\x33\xfa\xa6\xbd\x4f\x3e\xe3\xc8\x7f\x77\x1b\x5c\xf2\x5f\x9d\xcb\xe9"
        "\x07\x06\x8f\xfa\x37\xf7\x46\x63\x6e\x2c\x6f\x1c\xbf\xff\xe9\xa6\x7f"
        "\x37\xfd\xbb\xe9\xdf\x4d\xff\x6e\xfa\x77\xd3\xbf\x9b\xfe\xc5\xc6\x72"
        "\xfc\x7f\xfa\x51\xbf\x17\x3c\x60\xde\xcd\x3e\x30\xf2\x97\x31\x43\xa7"
        "\xd9\x79\xaa\x2d\xde\xec\xf1\xbe\xc9\xfe\xa7\x8f\xff\x8f\xec\xfb\x77"
        "\xc7\xff\xb7\x98\x6a\xe7\x69\x06\x0f\x8c\xbe\xef\x35\x8f\xcf\x8e\x78"
        "\xcc\x7f\xe4\xf1\xd9\xf9\x47\x7c\xdb\x69\x9e\x51\x8f\x1b\xf3\xf8\xe0"
        "\xc8\x9b\x5f\xf7\xf1\xd9\xd3\x26\xdc\x60\x89\xff\xa3\xe3\xb3\xff\x96"
        "\x51\xdb\xea\xeb\xf8\xbd\xa1\xfd\x7f\x37\xfd\xbb\xe9\xdf\x4d\xff\x6e"
        "\xfa\x77\xd3\xbf\x9b\xfe\xdd\xf4\xef\xa6\x7f\x37\xfd\xbb\xe9\xdf\x4d"
        "\xff\x6e\xfa\x77\xd3\xbf\xd8\x58\x8e\xff\xcf\x3d\xea\x7d\x00\x53\x5c"
        "\xbc\xfc\x56\x23\x0f\x84\x0e\x5d\x6a\x8b\x3d\x76\x7f\xb3\xc7\xfb\x26"
        "\xfb\x9f\x3e\xfe\x3f\xb2\xef\xdf\x1d\xff\xdf\x7d\x8f\x2d\x96\x1a\x3c"
        "\x30\xfa\xbe\xd7\x3c\xfe\x3f\xe2\x31\x1d\xc7\xff\xb7\x58\x63\xc1\x83"
        "\xfe\x93\x8f\xff\x8f\xda\x56\x1d\xff\xe7\x9f\xd0\xbf\x9b\xfe\xdd\xf4"
        "\xef\xa6\x7f\x37\xfd\xbb\xfd\x4b\xfd\xff\xff\x9d\x86\x80\x37\x89\xed"
        "\xbf\x9b\xfe\xdd\xf4\xef\xa6\x7f\x37\xfd\xbb\xe9\xdf\x4d\xff\x62\x63"
        "\x39\xfe\xbf\xe8\xa8\xf7\x01\xac\x74\xec\x9e\x0b\x8c\x7e\x3f\xc0\x6e"
        "\x47\x3c\xf5\x66\x8f\xf7\x4d\xf6\xbf\x7a\xfc\xdf\xff\xff\xbf\x97\xfd"
        "\x7f\x37\xfd\xbb\xe9\xdf\x4d\xff\x6e\xfa\x77\xd3\xbf\x9b\xfe\xdd\xf4"
        "\xef\xa6\x7f\x37\xfd\xbb\xe9\xdf\x4d\xff\x6e\xfa\x77\xd3\xbf\xd8\xc8"
        "\xe3\xff\x03\x63\xbc\xb5\xff\x53\xd6\x8b\x28\x1c\xff\xff\xef\x36\x96"
        "\xfe\x2b\xe8\x1f\xb5\xf4\x5f\x51\xff\xa8\xa5\xff\x4a\xfa\x47\x2d\xfd"
        "\x57\xd6\x3f\x6a\xe9\xbf\x8a\xfe\x51\x4b\xff\x4f\xeb\x1f\xb5\xf4\xff"
        "\x8c\xfe\x51\x4b\xff\x55\xf5\x8f\x5a\xfa\x7f\x56\xff\xa8\xa5\xff\xe7"
        "\xf4\x8f\x5a\xfa\x7f\x5e\xff\xa8\xa5\xff\x6a\xfa\x47\x2d\xfd\xbf\xa0"
        "\x7f\xd4\xd2\x7f\x75\xfd\xa3\x96\xfe\x6b\xe8\x1f\xb5\xf4\x5f\x53\xff"
        "\xa8\xa5\xff\x5a\xfa\x47\x2d\xfd\xd7\xd6\x3f\x6a\xe9\xbf\x8e\xfe\x51"
        "\x4b\xff\x75\xf5\x8f\x5a\xfa\xaf\xa7\x7f\xd4\xd2\x7f\x7d\xfd\xa3\x96"
        "\xfe\x1b\xe8\x1f\xb5\xf4\xdf\x50\xff\xa8\xa5\xff\x46\xfa\x47\x2d\xfd"
        "\xbf\xa8\x7f\xd4\xd2\x7f\x63\xfd\xa3\x96\xfe\x9b\xe8\x1f\xb5\xf4\xdf"
        "\x54\xff\xa8\xa5\xff\x66\xfa\x47\x2d\xfd\x37\xd7\x3f\x6a\xe9\xbf\x85"
        "\xfe\x51\x4b\xff\x2d\xf5\x8f\x5a\xfa\x6f\xa5\x7f\xd4\xd2\x7f\x6b\xfd"
        "\xa3\x96\xfe\xdb\xe8\x1f\xb5\xf4\xdf\x56\xff\xa8\xa5\xff\x76\xfa\x47"
        "\x2d\xfd\xbf\xa4\x7f\xd4\xd2\x7f\x7b\xfd\xa3\x96\xfe\x3b\xe8\x1f\xb5"
        "\xf4\xdf\x51\xff\xa8\xa5\xff\x4e\xfa\x47\x2d\xfd\xbf\xac\x7f\xd4\xd2"
        "\xff\x2b\xfa\x47\x2d\xfd\x77\xd6\x3f\x6a\xe9\xbf\x8b\xfe\x51\x4b\xff"
        "\x5d\xf5\x8f\x5a\xfa\xef\xa6\x7f\xd4\xd2\xff\xab\xfa\x47\x2d\xfd\xbf"
        "\xa6\x7f\xd4\xd2\xff\xeb\xfa\x47\x2d\xfd\xbf\xa1\x7f\xd4\xd2\xff\x9b"
        "\xfa\x47\x2d\xfd\x77\xd7\x3f\x6a\xe9\xff\x2d\xfd\xa3\x96\xfe\x7b\xe8"
        "\x1f\xb5\xf4\xdf\x53\xff\xa8\xa5\xff\xb7\xf5\x8f\x5a\xfa\xef\xa5\x7f"
        "\xd4\xd2\x7f\x6f\xfd\xa3\x96\xfe\xfb\xe8\x1f\xb5\xf4\xff\x8e\xfe\x51"
        "\x4b\xff\x7d\xf5\x8f\x5a\xfa\xef\xa7\x7f\xd4\xd2\xff\xbb\xfa\x47\x2d"
        "\xfd\xbf\xa7\x7f\xd4\xd2\x7f\x7f\xfd\xa3\x96\xfe\xdf\xd7\x3f\x6a\xe9"
        "\xff\x03\xfd\xa3\x96\xfe\x3f\xd4\x3f\x6a\xe9\x7f\x80\xfe\x51\x4b\xff"
        "\x1f\xe9\x1f\xb5\xf4\xff\xb1\xfe\x51\x4b\xff\x03\xf5\x8f\x5a\xfa\x1f"
        "\xa4\x7f\xd4\xd2\xff\x60\xfd\xa3\x96\xfe\x87\xe8\x1f\xb5\xf4\xff\x89"
        "\xfe\x51\x4b\xff\x43\xf5\x8f\x5a\xfa\x1f\xa6\x7f\xd4\xd2\xff\x70\xfd"
        "\xa3\x96\xfe\x47\xe8\x1f\xb5\xf4\x3f\x52\xff\xa8\xa5\xff\x51\xfa\x47"
        "\x2d\xfd\x7f\xaa\x7f\xd4\xd2\xff\x67\xfa\x47\x2d\xfd\x8f\xd6\x3f\x6a"
        "\xe9\xff\x73\xfd\xa3\x96\xfe\xc7\xe8\x1f\xb5\xf4\xff\x85\xfe\x51\x4b"
        "\xff\x5f\xea\x1f\xb5\xf4\x3f\x56\xff\xa8\xa5\xff\xaf\xf4\x8f\x5a\xfa"
        "\x1f\xa7\x7f\xd4\xd2\xff\x78\xfd\xa3\x96\xfe\xbf\xd6\x3f\x6a\xe9\x7f"
        "\x82\xfe\x51\x4b\xff\xdf\xe8\x1f\xb5\xf4\x3f\x51\xff\xa8\xa5\xff\x49"
        "\xfa\x47\x2d\xfd\x4f\xd6\x3f\x6a\xe9\xff\x5b\xfd\xa3\x96\xfe\xbf\xd3"
        "\x3f\x6a\xe9\xff\x7b\xfd\xa3\x96\xfe\xa7\xe8\x1f\xb5\xf4\xff\x83\xfe"
        "\x51\x4b\xff\x3f\xea\x1f\xb5\xf4\x3f\x55\xff\xa8\xa5\xff\x69\xfa\x47"
        "\x2d\xfd\xff\xa4\x7f\xd4\xd2\xff\x74\xfd\xa3\x96\xfe\x67\xe8\x1f\xb5"
        "\xf4\x3f\x53\xff\xa8\xa5\xff\x9f\xf5\x8f\x5a\xfa\x9f\xa5\x7f\xd4\xd2"
        "\xff\x6c\xfd\xa3\x96\xfe\x7f\xd1\x3f\x6a\xe9\xff\x57\xfd\xa3\x96\xfe"
        "\xe7\xe8\x1f\xb5\xf4\x3f\x57\xff\xa8\xa5\xff\x79\xfa\x47\x2d\xfd\xcf"
        "\xd7\x3f\x6a\xe9\x7f\x81\xfe\x51\x4b\xff\x0b\xf5\x8f\x5a\xfa\x5f\xa4"
        "\x7f\xd4\xd2\xff\x62\xfd\xa3\x96\xfe\x97\xe8\x1f\xb5\xf4\xbf\x54\xff"
        "\xa8\xa5\xff\x65\xfa\x47\x2d\xfd\x2f\xd7\x3f\x6a\xe9\x7f\x85\xfe\x51"
        "\x4b\xff\x2b\xf5\x8f\x5a\xfa\x5f\xa5\x7f\xd4\xd2\xff\x6a\xfd\xa3\x96"
        "\xfe\xd7\xe8\x1f\xb5\xf4\xbf\x56\xff\xa8\xa5\xff\x75\xfa\x47\x2d\xfd"
        "\xaf\xd7\x3f\x6a\xe9\x7f\x83\xfe\x51\x4b\xff\x1b\xf5\x8f\x5a\xfa\xdf"
        "\xa4\x7f\xd4\xd2\xff\x66\xfd\xa3\x96\xfe\xb7\xe8\x1f\xb5\xf4\xbf\x55"
        "\xff\xa8\xa5\xff\x6d\xfa\x47\x2d\xfd\x6f\xd7\x3f\x6a\xe9\x7f\x87\xfe"
        "\x51\x4b\xff\x3b\xf5\x8f\x5a\xfa\xdf\xa5\x7f\xd4\xd2\xff\x6e\xfd\xa3"
        "\x96\xfe\xf7\xe8\x1f\xb5\xf4\xbf\x57\xff\xa8\xa5\xff\x7d\xfa\x47\x2d"
        "\xfd\xef\xd7\x3f\x6a\xe9\xff\x80\xfe\x51\x4b\xff\x07\xf5\x8f\x5a\xfa"
        "\x3f\xa4\x7f\xd4\xd2\xff\x61\xfd\xa3\x96\xfe\x8f\xe8\x1f\xb5\xf4\x7f"
        "\x54\xff\xa8\xa5\xff\x63\xfa\x47\x2d\xfd\x1f\xd7\x3f\x6a\xe9\xff\x84"
        "\xfe\x51\x4b\xff\x27\xf5\x8f\x5a\xfa\x3f\xa5\x7f\xd4\xd2\xff\x69\xfd"
        "\xa3\x96\xfe\xcf\xe8\x1f\xb5\xf4\x7f\x56\xff\xa8\xa5\xff\x73\xfa\x47"
        "\x2d\xfd\x9f\xd7\x3f\x6a\xe9\xff\x82\xfe\x51\x4b\xff\x17\xf5\x8f\x5a"
        "\xfa\xbf\xa4\x7f\xd4\xd2\xff\x65\xfd\xa3\x92\xfe\x83\x06\xf4\x8f\x5a"
        "\xfa\x0f\xd2\x3f\x6a\xe9\x3f\x58\xff\xa8\xa5\xff\x38\xfa\x47\x2d\xfd"
        "\x87\xe8\x1f\xb5\xf4\x1f\xaa\x7f\xd4\xd2\x7f\x98\xfe\x51\x4b\xff\x71"
        "\xf5\x8f\x5a\xfa\x8f\xa7\x7f\xd4\xd2\x7f\x7c\xfd\xa3\x96\xfe\x13\xe8"
        "\x1f\xb5\xf4\x9f\x50\xff\xa8\xa5\xff\x44\xfa\x47\x2d\xfd\xdf\xa2\x7f"
        "\xd4\xd2\x7f\x62\xfd\xa3\x96\xfe\x93\xe8\x1f\xb5\xf4\x9f\x54\xff\xa8"
        "\xa5\xff\x64\xfa\x47\x2d\xfd\x27\xd7\x3f\x6a\xe9\x3f\x85\xfe\x51\x4b"
        "\xff\xb7\xea\x1f\xb5\xf4\x7f\x9b\xfe\x51\x4b\xff\x29\xf5\x8f\x5a\xfa"
        "\xbf\x5d\xff\xa8\xa5\xff\x54\xfa\x47\x2d\xfd\xdf\xa1\x7f\xd4\xd2\x7f"
        "\x6a\xfd\xa3\x96\xfe\xd3\xe8\x1f\xb5\xf4\x7f\xa7\xfe\x51\x4b\xff\x69"
        "\xf5\x8f\x5a\xfa\x4f\xa7\x7f\xd4\xd2\xff\x5d\xfa\x47\x2d\xfd\xa7\xd7"
        "\x3f\x6a\xe9\x3f\x83\xfe\x51\x4b\xff\x19\xf5\x8f\x5a\xfa\xcf\xa4\x7f"
        "\xd4\xd2\x7f\x66\xfd\xa3\x96\xfe\xb3\xe8\x1f\xb5\xf4\x7f\xb7\xfe\x51"
        "\x4b\xff\x59\xf5\x8f\x5a\xfa\xcf\xa6\x7f\xd4\xd2\xff\x3d\xfa\x47\x2d"
        "\xfd\xdf\xab\x7f\xd4\xd2\xff\x7d\xfa\x47\x2d\xfd\x67\xd7\x3f\x6a\xe9"
        "\x3f\x87\xfe\x51\x4b\xff\x39\xf5\x8f\x5a\xfa\xcf\xa5\x7f\xd4\xd2\x7f"
        "\x6e\xfd\xa3\x96\xfe\xf3\xe8\x1f\xb5\xf4\x9f\x57\xff\xa8\xa5\xff\x7c"
        "\xfa\x47\x2d\xfd\xdf\xaf\x7f\xd4\xd2\xff\x03\xfa\x47\x2d\xfd\x3f\xa8"
        "\x7f\xd4\xd2\x7f\x7e\xfd\xa3\x96\xfe\x0b\xe8\x1f\xb5\xf4\x5f\x50\xff"
        "\xa8\xa5\xff\x87\xf4\x8f\x5a\xfa\x2f\xa4\x7f\xd4\xd2\x7f\x61\xfd\xa3"
        "\x96\xfe\x1f\xd6\x3f\x6a\xe9\xff\x11\xfd\xa3\x96\xfe\x8b\xe8\x1f\xb5"
        "\xf4\x5f\x54\xff\xa8\xa5\xff\x62\xfa\x47\x2d\xfd\x17\xd7\x3f\x6a\xe9"
        "\xbf\x84\xfe\x51\x4b\xff\x25\xf5\x8f\x5a\xfa\x2f\xa5\x7f\xd4\xd2\x7f"
        "\x69\xfd\xa3\x96\xfe\xcb\xe8\x1f\xb5\xf4\x5f\x56\xff\xa8\xa5\xff\x72"
        "\xfa\x47\x2d\xfd\x3f\xaa\x7f\xd4\xd2\xff\x63\xfa\x47\x2d\xfd\x97\xd7"
        "\x3f\x6a\xe9\xff\x71\xfd\xa3\x96\xfe\x9f\xd0\x3f\x6a\xe9\xff\x49\xfd"
        "\xa3\x96\xfe\x9f\xd2\x3f\x6a\xe9\xbf\x82\xfe\x51\x4b\xff\x15\xf5\x8f"
        "\x5a\xfa\xaf\xa4\x7f\xd4\xd2\x7f\x65\xfd\xa3\x96\xfe\xab\xe8\x1f\xb5"
        "\xf4\xff\xb4\xfe\x51\x4b\xff\xcf\xe8\x1f\xb5\xf4\x5f\x55\xff\xa8\xa5"
        "\xff\x67\xf5\x8f\x5a\xfa\x7f\x4e\xff\xa8\xa5\xff\xe7\xf5\x8f\x5a\xfa"
        "\xaf\xa6\x7f\xd4\xd2\xff\x0b\xfa\x47\x2d\xfd\x57\xd7\x3f\x6a\xe9\xbf"
        "\x86\xfe\x51\x4b\xff\x35\xf5\x8f\x5a\xfa\xaf\xa5\x7f\xd4\xd2\x7f\x6d"
        "\xfd\xa3\x96\xfe\xeb\xe8\x3f\x30\x30\xf0\xf2\x24\x63\xde\xd2\xd2\x7f"
        "\x5d\xfd\xa3\x96\xfe\xeb\xe9\x1f\xb5\xf4\x5f\x5f\xff\xa8\xa5\xff\x06"
        "\xfa\x47\x2d\xfd\x37\xd4\x3f\x6a\xe9\xbf\x91\xfe\x51\x4b\xff\x2f\xea"
        "\x1f\xb5\xf4\xdf\x58\xff\xa8\xa5\xff\x26\xfa\x47\x2d\xfd\x37\xd5\x3f"
        "\x6a\xe9\xbf\x99\xfe\x51\x4b\xff\xcd\xf5\x8f\x5a\xfa\x6f\xa1\x7f\xd4"
        "\xd2\x7f\x4b\xfd\xa3\x96\xfe\x5b\xe9\x1f\xb5\xf4\xdf\x5a\xff\xa8\xa5"
        "\xff\x36\xfa\x47\x2d\xfd\xb7\xd5\x3f\x6a\xe9\xbf\x9d\xfe\x51\x4b\xff"
        "\x2f\xe9\x1f\xb5\xf4\xdf\x5e\xff\xa8\xa5\xff\x0e\xfa\x47\x2d\xfd\x77"
        "\xd4\x3f\x6a\xe9\xbf\x93\xfe\x51\x4b\xff\x2f\xeb\x1f\xb5\xf4\xff\x8a"
        "\xfe\x51\x4b\xff\x9d\xf5\x8f\x5a\xfa\xef\xa2\x7f\xd4\xd2\x7f\x57\xfd"
        "\xa3\x96\xfe\xbb\xe9\x1f\xb5\xf4\xff\xaa\xfe\x51\x4b\xff\xaf\xe9\x1f"
        "\xb5\xf4\xff\xba\xfe\x51\x4b\xff\x6f\xe8\x1f\xb5\xf4\xff\xa6\xfe\x51"
        "\x4b\xff\xdd\xf5\x8f\x5a\xfa\x7f\x4b\xff\xa8\xa5\xff\x1e\xfa\x47\x2d"
        "\xfd\xf7\xd4\x3f\x6a\xe9\xff\x6d\xfd\xa3\x96\xfe\x7b\xe9\x1f\xb5\xf4"
        "\xdf\x5b\xff\xa8\xa5\xff\x3e\xfa\x47\x2d\xfd\xbf\xa3\x7f\xd4\xd2\x7f"
        "\x5f\xfd\xa3\x96\xfe\xfb\xe9\x1f\xb5\xf4\xff\xae\xfe\x51\x4b\xff\xef"
        "\xe9\x1f\xb5\xf4\xdf\x5f\xff\xa8\xa5\xff\xf7\xf5\x8f\x5a\xfa\xff\x40"
        "\xff\xa8\xa5\xff\x0f\xf5\x8f\x5a\xfa\x1f\xa0\x7f\xd4\xd2\xff\x47\xfa"
        "\x47\x2d\xfd\x7f\xac\x7f\xd4\xd2\xff\x40\xfd\xa3\x96\xfe\x07\xe9\x1f"
        "\xb5\xf4\x3f\x58\xff\xa8\xa5\xff\x21\xfa\x47\x2d\xfd\x7f\xa2\x7f\xd4"
        "\xd2\xff\x50\xfd\xa3\x96\xfe\x87\xe9\x1f\xb5\xf4\x3f\x5c\xff\xa8\xa5"
        "\xff\x11\xfa\x47\x2d\xfd\x8f\xd4\x3f\x6a\xe9\x7f\x94\xfe\x51\x4b\xff"
        "\x9f\xea\x1f\xb5\xf4\xff\x99\xfe\x51\x4b\xff\xa3\xf5\x8f\x5a\xfa\xff"
        "\x5c\xff\xa8\xa5\xff\x31\xfa\x47\x2d\xfd\x7f\xa1\x7f\xd4\xd2\xff\x97"
        "\xfa\x47\x2d\xfd\x8f\xd5\x3f\x6a\xe9\xff\x2b\xfd\xa3\x96\xfe\xc7\xe9"
        "\x1f\xb5\xf4\x3f\x5e\xff\xa8\xa5\xff\xaf\xf5\x8f\x5a\xfa\x9f\xa0\x7f"
        "\xd4\xd2\xff\x37\xfa\x47\x2d\xfd\x4f\xd4\x3f\x6a\xe9\x7f\x92\xfe\x51"
        "\x4b\xff\x93\xf5\x8f\x5a\xfa\xff\x56\xff\xa8\xa5\xff\xef\xf4\x8f\x5a"
        "\xfa\xff\x5e\xff\xa8\xa5\xff\x29\xfa\x47\x2d\xfd\xff\xa0\x7f\xd4\xd2"
        "\xff\x8f\xfa\x47\x2d\xfd\x4f\xd5\x3f\x6a\xe9\x7f\x9a\xfe\x51\x4b\xff"
        "\x3f\xe9\x1f\xb5\xf4\x3f\x5d\xff\xa8\xa5\xff\x19\xfa\x47\x2d\xfd\xcf"
        "\xd4\x3f\x6a\xe9\xff\x67\xfd\xa3\x96\xfe\x67\xe9\x1f\xb5\xf4\x3f\x5b"
        "\xff\xa8\xa5\xff\x5f\xf4\x8f\x5a\xfa\xff\x55\xff\xa8\xa5\xff\x39\xfa"
        "\x47\x2d\xfd\xcf\xd5\x3f\x6a\xe9\x7f\x9e\xfe\x51\x4b\xff\xf3\xf5\x8f"
        "\x5a\xfa\x5f\xa0\x7f\xd4\xd2\xff\x42\xfd\xa3\x96\xfe\x17\xe9\x1f\xb5"
        "\xf4\xbf\x58\xff\xa8\xa5\xff\x25\xfa\x47\x2d\xfd\x2f\xd5\x3f\x6a\xe9"
        "\x7f\x99\xfe\x51\x4b\xff\xcb\xf5\x8f\x5a\xfa\x5f\xa1\x7f\xd4\xd2\xff"
        "\x4a\xfd\xa3\x96\xfe\x57\xe9\x1f\xb5\xf4\xbf\x5a\xff\xa8\xa5\xff\x35"
        "\xfa\x47\x2d\xfd\xaf\xd5\x3f\x6a\xe9\x7f\x9d\xfe\x51\x4b\xff\xeb\xf5"
        "\x8f\x5a\xfa\xdf\xa0\x7f\xd4\xd2\xff\x46\xfd\xa3\x96\xfe\x37\xe9\x1f"
        "\xb5\xf4\xbf\x59\xff\xa8\xa5\xff\x2d\xfa\x47\x2d\xfd\x6f\xd5\x3f\x6a"
        "\xe9\x7f\x9b\xfe\x51\x4b\xff\xdb\xf5\x8f\x5a\xfa\xdf\xa1\x7f\xd4\xd2"
        "\xff\x4e\xfd\xa3\x96\xfe\x77\xe9\x1f\xb5\xf4\xbf\x5b\xff\xa8\xa5\xff"
        "\x3d\xfa\x47\x2d\xfd\xef\xd5\x3f\x6a\xe9\x7f\x9f\xfe\x51\x4b\xff\xfb"
        "\xf5\x8f\x5a\xfa\x3f\xa0\x7f\xd4\xd2\xff\x41\xfd\xa3\x96\xfe\x0f\xe9"
        "\x1f\xb5\xf4\x7f\x58\xff\xa8\xa5\xff\x23\xfa\x47\x2d\xfd\x1f\xd5\x3f"
        "\x6a\xe9\xff\x98\xfe\x51\x4b\xff\xc7\xf5\x8f\x5a\xfa\x3f\xa1\x7f\xd4"
        "\xd2\xff\x49\xfd\xa3\x96\xfe\x4f\xe9\x1f\xb5\xf4\x7f\x5a\xff\xa8\xa5"
        "\xff\x33\xfa\x47\x2d\xfd\x9f\xd5\x3f\x6a\xe9\xff\x9c\xfe\x51\x4b\xff"
        "\xe7\xf5\x8f\x5a\xfa\xbf\xa0\x7f\xd4\xd2\xff\x45\xfd\xa3\x96\xfe\x2f"
        "\xe9\x1f\xb5\xf4\x7f\x59\xff\xa8\xa4\xff\x2b\x17\xf5\xff\x47\x2d\xfd"
        "\x07\xe9\x1f\xb5\xf4\x1f\xac\x7f\xd4\xd2\x7f\x1c\xfd\xa3\x96\xfe\x43"
        "\xf4\x8f\x5a\xfa\x0f\xd5\x3f\x6a\xe9\x3f\x4c\xff\xa8\xa5\xff\xb8\xfa"
        "\x47\x2d\xfd\xc7\xd3\x3f\x6a\xe9\x3f\xbe\xfe\x51\x4b\xff\x09\xf4\x8f"
        "\x5a\xfa\x4f\xa8\x7f\xd4\xd2\x7f\x22\xfd\xa3\x96\xfe\x6f\xd1\x3f\x6a"
        "\xe9\x3f\xb1\xfe\x51\x4b\xff\x49\xf4\x8f\x5a\xfa\x4f\xaa\x7f\xd4\xd2"
        "\x7f\x32\xfd\xa3\x96\xfe\x93\xeb\x1f\xb5\xf4\x9f\x42\xff\xa8\xa5\xff"
        "\x5b\xf5\x8f\x5a\xfa\xbf\x4d\xff\xa8\xa5\xff\x94\xfa\x47\x2d\xfd\xdf"
        "\xae\x7f\xd4\xd2\x7f\x2a\xfd\xa3\x96\xfe\xef\xd0\x3f\x6a\xe9\x3f\xb5"
        "\xfe\x51\x4b\xff\x69\xf4\x8f\x5a\xfa\xbf\x53\xff\xa8\xa5\xff\xb4\xfa"
        "\x47\x2d\xfd\xa7\xd3\x3f\x6a\xe9\xff\x2e\xfd\xa3\x96\xfe\xd3\xeb\x1f"
        "\xb5\xf4\x9f\x41\xff\xa8\xa5\xff\x8c\xfa\x47\x2d\xfd\x67\xd2\x3f\x6a"
        "\xe9\x3f\xb3\xfe\x51\x4b\xff\x59\xf4\x8f\x5a\xfa\xbf\x5b\xff\xa8\xa5"
        "\xff\xac\xfa\x47\x2d\xfd\x67\xd3\x3f\x6a\xe9\xff\x1e\xfd\xa3\x96\xfe"
        "\xef\xd5\x3f\x6a\xe9\xff\x3e\xfd\xa3\x96\xfe\xb3\xeb\x1f\xb5\xf4\x9f"
        "\x43\xff\xa8\xa5\xff\x9c\xfa\x47\x2d\xfd\xe7\xd2\x3f\x6a\xe9\x3f\xb7"
        "\xfe\x51\x4b\xff\x79\xf4\x8f\x5a\xfa\xcf\xab\x7f\xd4\xd2\x7f\x3e\xfd"
        "\xa3\x96\xfe\xef\xd7\x3f\x6a\xe9\xff\x01\xfd\xa3\x96\xfe\x1f\xd4\x3f"
        "\x6a\xe9\x3f\xbf\xfe\x51\x4b\xff\x05\xf4\x8f\x5a\xfa\x2f\xa8\x7f\xd4"
        "\xd2\xff\x43\xfa\x47\x2d\xfd\x17\xd2\x3f\x6a\xe9\xbf\xb0\xfe\x51\x4b"
        "\xff\x0f\xeb\x1f\xb5\xf4\xff\x88\xfe\x51\x4b\xff\x45\xf4\x8f\x5a\xfa"
        "\x2f\xaa\x7f\xd4\xd2\x7f\x31\xfd\xa3\x96\xfe\x8b\xeb\x1f\xb5\xf4\x5f"
        "\x42\xff\xa8\xa5\xff\x92\xfa\x47\x2d\xfd\x97\xd2\x3f\x6a\xe9\xbf\xb4"
        "\xfe\x51\x4b\xff\x65\xf4\x8f\x5a\xfa\x2f\xab\x7f\xd4\xd2\x7f\x39\xfd"
        "\xa3\x96\xfe\x1f\xd5\x3f\x6a\xe9\xff\x31\xfd\xa3\x96\xfe\xcb\xeb\x1f"
        "\xb5\xf4\xff\xb8\xfe\x51\x4b\xff\x4f\xe8\x1f\xb5\xf4\xff\xa4\xfe\x51"
        "\x4b\xff\x4f\xe9\x1f\xb5\xf4\x5f\x41\xff\xa8\xa5\xff\x8a\xfa\x47\x2d"
        "\xfd\x57\xd2\x3f\x6a\xe9\xbf\xb2\xfe\x51\x4b\xff\x55\xf4\x8f\x5a\xfa"
        "\x7f\x5a\xff\xa8\xa5\xff\x67\xf4\x8f\x5a\xfa\xaf\xaa\x7f\xd4\xd2\xff"
        "\xb3\xfa\x47\x2d\xfd\x3f\xa7\x7f\xd4\xd2\xff\xf3\xfa\x47\x2d\xfd\x57"
        "\xd3\x3f\x6a\xe9\xff\x05\xfd\xa3\x96\xfe\xab\xeb\x1f\xb5\xf4\x5f\x43"
        "\xff\xa8\xa5\xff\x9a\xfa\x47\x2d\xfd\xd7\xd2\x3f\x6a\xe9\xbf\xb6\xfe"
        "\x51\x4b\xff\x75\xf4\x8f\x5a\xfa\xaf\xab\x7f\xd4\xd2\x7f\x3d\xfd\xa3"
        "\x96\xfe\xeb\xeb\x1f\xb5\xf4\xdf\x40\xff\xa8\xa5\xff\x86\xfa\x47\x2d"
        "\xfd\x37\xd2\x3f\x6a\xe9\xff\x45\xfd\xa3\x96\xfe\x1b\xeb\x1f\xb5\xf4"
        "\xdf\x44\xff\xa8\xa5\xff\xa6\xfa\x47\x2d\xfd\x37\xd3\x3f\x6a\xe9\xbf"
        "\xb9\xfe\x51\x4b\xff\x2d\xf4\x8f\x5a\xfa\x6f\xa9\x7f\xd4\xd2\x7f\x2b"
        "\xfd\xa3\x96\xfe\x5b\xeb\x1f\xb5\xf4\xdf\x46\xff\xa8\xa5\xff\xb6\xfa"
        "\x47\x2d\xfd\xb7\xd3\x3f\x6a\xe9\xff\x25\xfd\xa3\x96\xfe\xdb\xeb\x1f"
        "\xb5\xf4\xdf\x41\xff\xa8\xa5\xff\x8e\xfa\x47\x2d\xfd\x77\xd2\x3f\x6a"
        "\xe9\xff\x65\xfd\xa3\x96\xfe\x5f\xd1\x3f\x6a\xe9\xbf\xb3\xfe\x51\x4b"
        "\xff\x5d\xf4\x8f\x5a\xfa\xef\xaa\x7f\xd4\xd2\x7f\x37\xfd\xa3\x96\xfe"
        "\x5f\xd5\x3f\x6a\xe9\xff\x35\xfd\xa3\x96\xfe\x5f\xd7\x3f\x6a\xe9\xff"
        "\x0d\xfd\xa3\x96\xfe\xdf\xd4\x3f\x6a\xe9\xbf\xbb\xfe\x51\x4b\xff\x6f"
        "\xe9\x1f\xb5\xf4\xdf\x43\xff\xa8\xa5\xff\x9e\xfa\x47\x2d\xfd\xbf\xad"
        "\x7f\xd4\xd2\x7f\x2f\xfd\xa3\x96\xfe\x7b\xeb\x1f\xb5\xf4\xdf\x47\xff"
        "\xa8\xa5\xff\x77\xf4\x8f\x5a\xfa\xef\xab\x7f\xd4\xd2\x7f\x3f\xfd\xa3"
        "\x96\xfe\xdf\xd5\x3f\x6a\xe9\xff\x3d\xfd\xa3\x96\xfe\xfb\xeb\x1f\xb5"
        "\xf4\xff\xbe\xfe\x51\x4b\xff\x1f\xe8\x1f\xb5\xf4\xff\xa1\xfe\x51\x4b"
        "\xff\x03\xf4\x8f\x5a\xfa\xff\x48\xff\xa8\xa5\xff\x8f\xf5\x8f\x5a\xfa"
        "\x1f\xa8\x7f\xd4\xd2\xff\x20\xfd\xa3\x96\xfe\x07\xeb\x1f\xb5\xf4\x3f"
        "\x44\xff\xa8\xa5\xff\x4f\xf4\x8f\x5a\xfa\x1f\xaa\x7f\xd4\xd2\xff\x30"
        "\xfd\xa3\x96\xfe\x87\xeb\x1f\xb5\xf4\x3f\x42\xff\xa8\xa5\xff\x91\xfa"
        "\x47\x2d\xfd\x8f\xd2\x3f\x6a\xe9\xff\x53\xfd\xa3\x96\xfe\x3f\xd3\x3f"
        "\x6a\xe9\x7f\xb4\xfe\x51\x4b\xff\x9f\xeb\x1f\xb5\xf4\x3f\x46\xff\xa8"
        "\xa5\xff\x2f\xf4\x8f\x5a\xfa\xff\x52\xff\xa8\xa5\xff\xb1\xfa\x47\x2d"
        "\xfd\x7f\xa5\x7f\xd4\xd2\xff\x38\xfd\xa3\x96\xfe\xc7\xeb\x1f\xb5\xf4"
        "\xff\xb5\xfe\x51\x4b\xff\x13\xf4\x8f\x5a\xfa\xff\x46\xff\xa8\xa5\xff"
        "\x89\xfa\x47\x2d\xfd\x4f\xd2\x3f\x6a\xe9\x7f\xb2\xfe\x51\x4b\xff\xdf"
        "\xea\x1f\xb5\xf4\xff\x9d\xfe\x51\x4b\xff\xdf\xeb\x1f\xb5\xf4\x3f\x45"
        "\xff\xa8\xa5\xff\x1f\xf4\x8f\x5a\xfa\xff\x51\xff\xa8\xa5\xff\xa9\xfa"
        "\x47\x2d\xfd\x4f\xd3\x3f\x6a\xe9\xff\x27\xfd\xa3\x96\xfe\xa7\xeb\x1f"
        "\xb5\xf4\x3f\x43\xff\xa8\xa5\xff\x99\xfa\x47\x2d\xfd\xff\xac\x7f\xd4"
        "\xd2\xff\x2c\xfd\xa3\x96\xfe\x67\xeb\x1f\xb5\xf4\xff\x8b\xfe\x51\x4b"
        "\xff\xbf\xea\x1f\xb5\xf4\x3f\x47\xff\xa8\xa5\xff\xb9\xfa\x47\x2d\xfd"
        "\xcf\xd3\x3f\x6a\xe9\x7f\xbe\xfe\x51\x4b\xff\x0b\xf4\x8f\x5a\xfa\x5f"
        "\xa8\x7f\xd4\xd2\xff\x22\xfd\xa3\x96\xfe\x17\xeb\x1f\xb5\xf4\xbf\x44"
        "\xff\xa8\xa5\xff\xa5\xfa\x47\x2d\xfd\x2f\xd3\x3f\x6a\xe9\x7f\xb9\xfe"
        "\x51\x4b\xff\x2b\xf4\x8f\x5a\xfa\x5f\xa9\x7f\xd4\xd2\xff\x2a\xfd\xa3"
        "\x96\xfe\x57\xeb\x1f\xb5\xf4\xbf\x46\xff\xa8\xa5\xff\xb5\xfa\x47\x2d"
        "\xfd\xaf\xd3\x3f\x6a\xe9\x7f\xbd\xfe\x51\x4b\xff\x1b\xf4\x8f\x5a\xfa"
        "\xdf\xa8\x7f\xd4\xd2\xff\x26\xfd\xa3\x96\xfe\x37\xeb\x1f\xb5\xf4\xbf"
        "\x45\xff\xa8\xa5\xff\xad\xfa\x47\x2d\xfd\x6f\xd3\x3f\x6a\xe9\x7f\xbb"
        "\xfe\x51\x4b\xff\x3b\xf4\x8f\x5a\xfa\xdf\xa9\x7f\xd4\xd2\xff\x2e\xfd"
        "\xa3\x96\xfe\x77\xeb\x1f\xb5\xf4\xbf\x47\xff\xa8\xa5\xff\xbd\xfa\x47"
        "\x2d\xfd\xef\xd3\x3f\x6a\xe9\x7f\xbf\xfe\x51\x4b\xff\x07\xf4\x8f\x5a"
        "\xfa\x3f\xa8\x7f\xd4\xd2\xff\x21\xfd\xa3\x96\xfe\x0f\xeb\x1f\xb5\xf4"
        "\x7f\x44\xff\xa8\xa5\xff\xa3\xfa\x47\x2d\xfd\x1f\xd3\x3f\x6a\xe9\xff"
        "\xb8\xfe\x51\x4b\xff\x27\xf4\x8f\x5a\xfa\x3f\xa9\x7f\xd4\xd2\xff\x29"
        "\xfd\xa3\x96\xfe\x4f\xeb\x1f\xb5\xf4\x7f\x46\xff\xa8\xa5\xff\xb3\xfa"
        "\x47\x2d\xfd\x9f\xd3\x3f\x6a\xe9\xff\xbc\xfe\x51\x4b\xff\x17\xf4\x8f"
        "\x5a\xfa\xbf\xa8\x7f\xd4\xd2\xff\x25\xfd\xa3\x96\xfe\x2f\xeb\x1f\x95"
        "\xf4\x1f\x67\x40\xff\xa8\xa5\xff\x20\xfd\xa3\x96\xfe\x83\xf5\x8f\x5a"
        "\xfa\x8f\xa3\x7f\xd4\xd2\x7f\x88\xfe\x51\x4b\xff\xa1\xfa\x47\x2d\xfd"
        "\x87\xe9\x1f\xb5\xf4\x1f\x57\xff\xa8\xa5\xff\x78\xfa\x47\x2d\xfd\xc7"
        "\xd7\x3f\x6a\xe9\x3f\x81\xfe\x51\x4b\xff\x09\xf5\x8f\x5a\xfa\x4f\xa4"
        "\x7f\xd4\xd2\xff\x2d\xfa\x47\x2d\xfd\x27\xd6\x3f\x6a\xe9\x3f\x89\xfe"
        "\x51\x4b\xff\x49\xf5\x8f\x5a\xfa\x4f\xa6\x7f\xd4\xd2\x7f\x72\xfd\xa3"
        "\x96\xfe\x53\xe8\x1f\xb5\xf4\x7f\xab\xfe\x51\x4b\xff\xb7\xe9\x1f\xb5"
        "\xf4\x9f\x52\xff\xa8\xa5\xff\xdb\xf5\x8f\x5a\xfa\x4f\xa5\x7f\xd4\xd2"
        "\xff\x1d\xfa\x47\x2d\xfd\xa7\xd6\x3f\x6a\xe9\x3f\x8d\xfe\x51\x4b\xff"
        "\x77\xea\x1f\xb5\xf4\x9f\x56\xff\xa8\xa5\xff\x74\xfa\x47\x2d\xfd\xdf"
        "\xa5\x7f\xd4\xd2\x7f\x7a\xfd\xa3\x96\xfe\x33\xe8\x1f\xb5\xf4\x9f\x51"
        "\xff\xa8\xa5\xff\x4c\xfa\x47\x2d\xfd\x67\xd6\x3f\x6a\xe9\x3f\x8b\xfe"
        "\x51\x4b\xff\x77\xeb\x1f\xb5\xf4\x9f\x55\xff\xa8\xa5\xff\x6c\xfa\x47"
        "\x2d\xfd\xdf\xa3\x7f\xd4\xd2\xff\xbd\xfa\x47\x2d\xfd\xdf\xa7\x7f\xd4"
        "\xd2\x7f\x76\xfd\xa3\x96\xfe\x73\xe8\x1f\xb5\xf4\x9f\x53\xff\xa8\xa5"
        "\xff\x5c\xfa\x47\x2d\xfd\xe7\xd6\x3f\x6a\xe9\x3f\x8f\xfe\x51\x4b\xff"
        "\x79\xf5\x8f\x5a\xfa\xcf\xa7\x7f\xd4\xd2\xff\xfd\xfa\x47\x2d\xfd\x3f"
        "\xa0\x7f\xd4\xd2\xff\x83\xfa\x47\x2d\xfd\xe7\xd7\x3f\x6a\xe9\xbf\x80"
        "\xfe\x51\x4b\xff\x05\xf5\x8f\x5a\xfa\x7f\x48\xff\xa8\xa5\xff\x42\xfa"
        "\x47\x2d\xfd\x17\xd6\x3f\x6a\xe9\xff\x61\xfd\xa3\x96\xfe\x1f\xd1\x3f"
        "\x6a\xe9\xbf\x88\xfe\x51\x4b\xff\x45\xf5\x8f\x5a\xfa\x2f\xa6\x7f\xd4"
        "\xd2\x7f\x71\xfd\xa3\x96\xfe\x4b\xe8\x1f\xb5\xf4\x5f\x52\xff\xa8\xa5"
        "\xff\x52\xfa\x47\x2d\xfd\x97\xd6\x3f\x6a\xe9\xbf\x8c\xfe\x51\x4b\xff"
        "\x65\xf5\x8f\x5a\xfa\x2f\xa7\x7f\xd4\xd2\xff\xa3\xfa\x47\x2d\xfd\x3f"
        "\xa6\x7f\xd4\xd2\x7f\x79\xfd\xa3\x96\xfe\x1f\xd7\x3f\x6a\xe9\xff\x09"
        "\xfd\xa3\x96\xfe\x9f\xd4\x3f\x6a\xe9\xff\x29\xfd\xa3\x96\xfe\x2b\xe8"
        "\x1f\xb5\xf4\x5f\x51\xff\xa8\xa5\xff\x4a\xfa\x47\x2d\xfd\x57\xd6\x3f"
        "\x6a\xe9\xbf\x8a\xfe\x51\x4b\xff\x4f\xeb\x1f\xb5\xf4\xff\x8c\xfe\x51"
        "\x4b\xff\x55\xf5\x8f\x5a\xfa\x7f\x56\xff\xa8\xa5\xff\xe7\xf4\x8f\x5a"
        "\xfa\x7f\x5e\xff\xa8\xa5\xff\x6a\xfa\x47\x2d\xfd\xbf\xa0\x7f\xd4\xd2"
        "\x7f\x75\xfd\xa3\x96\xfe\x6b\xe8\x1f\xb5\xf4\x5f\x53\xff\xa8\xa5\xff"
        "\x5a\xfa\x47\x2d\xfd\xd7\xd6\x3f\x6a\xe9\xbf\x8e\xfe\x51\x4b\xff\x75"
        "\xf5\x8f\x5a\xfa\xaf\xa7\x7f\xd4\xd2\x7f\x7d\xfd\xa3\x96\xfe\x1b\xe8"
        "\x1f\xb5\xf4\xdf\x50\xff\xa8\xa5\xff\x46\xfa\x47\x2d\xfd\xbf\xa8\x7f"
        "\xd4\xd2\x7f\x63\xfd\xa3\x96\xfe\x9b\xe8\x1f\xb5\xf4\xdf\x54\xff\xa8"
        "\xa5\xff\x66\xfa\x47\x2d\xfd\x37\xd7\x3f\x6a\xe9\xbf\x85\xfe\x51\x4b"
        "\xff\x2d\xf5\x8f\x5a\xfa\x6f\xa5\x7f\xd4\xd2\x7f\x6b\xfd\xa3\x96\xfe"
        "\xdb\xe8\x1f\xb5\xf4\xdf\x56\xff\xa8\xa5\xff\x76\xfa\x47\x2d\xfd\xbf"
        "\xa4\x7f\xd4\xd2\x7f\x7b\xfd\xa3\x96\xfe\x3b\xe8\x1f\xb5\xf4\xdf\x51"
        "\xff\xa8\xa5\xff\x4e\xfa\x47\x2d\xfd\xbf\xac\x7f\xd4\xd2\xff\x2b\xfa"
        "\x47\x2d\xfd\x77\xd6\x3f\x6a\xe9\xbf\x8b\xfe\x51\x4b\xff\x5d\xf5\x8f"
        "\x5a\xfa\xef\xa6\x7f\xd4\xd2\xff\xab\xfa\x47\x2d\xfd\xbf\xa6\x7f\xd4"
        "\xd2\xff\xeb\xfa\x47\x2d\xfd\xbf\xa1\x7f\xd4\xd2\xff\x9b\xfa\x47\x2d"
        "\xfd\x77\xd7\x3f\x6a\xe9\xff\x2d\xfd\xa3\x96\xfe\x7b\xe8\x1f\xb5\xf4"
        "\xdf\x53\xff\xa8\xa5\xff\xb7\xf5\x8f\x5a\xfa\xef\xa5\x7f\xd4\xd2\x7f"
        "\x6f\xfd\xa3\x96\xfe\xfb\xe8\x1f\xb5\xf4\xff\x8e\xfe\x51\x4b\xff\x7d"
        "\xf5\x8f\x5a\xfa\xef\xa7\x7f\xd4\xd2\xff\xbb\xfa\x47\x2d\xfd\xbf\xa7"
        "\x7f\xd4\xd2\x7f\x7f\xfd\xa3\x96\xfe\xdf\xd7\x3f\x6a\xe9\xff\x03\xfd"
        "\xa3\x96\xfe\x3f\xd4\x3f\x6a\xe9\x7f\x80\xfe\x51\x4b\xff\x1f\xe9\x1f"
        "\xb5\xf4\xff\xb1\xfe\x51\x4b\xff\x03\xf5\x8f\x5a\xfa\x1f\xa4\x7f\xd4"
        "\xd2\xff\x60\xfd\xa3\x96\xfe\x87\xe8\x1f\xb5\xf4\xff\x89\xfe\x51\x4b"
        "\xff\x43\xf5\x8f\x5a\xfa\x1f\xa6\x7f\xd4\xd2\xff\x70\xfd\xa3\x96\xfe"
        "\x47\xe8\x1f\xb5\xf4\x3f\x52\xff\xa8\xa5\xff\x51\xfa\x47\x2d\xfd\x7f"
        "\xaa\x7f\xd4\xd2\xff\x67\xfa\x47\x2d\xfd\x8f\xd6\x3f\x6a\xe9\xff\x73"
        "\xfd\xa3\x96\xfe\xc7\xe8\x1f\xb5\xf4\xff\x85\xfe\x51\x4b\xff\x5f\xea"
        "\x1f\xb5\xf4\x3f\x56\xff\xa8\xa5\xff\xaf\xf4\x8f\x5a\xfa\x1f\xa7\x7f"
        "\xd4\xd2\xff\x78\xfd\xa3\x96\xfe\xbf\xd6\x3f\x6a\xe9\x7f\x82\xfe\x51"
        "\x4b\xff\xdf\xe8\x1f\xb5\xf4\x3f\x51\xff\xa8\xa5\xff\x49\xfa\x47\x2d"
        "\xfd\x4f\xd6\x3f\x6a\xe9\xff\x5b\xfd\xa3\x96\xfe\xbf\xd3\x3f\x6a\xe9"
        "\xff\x7b\xfd\xa3\x96\xfe\xa7\xe8\x1f\xb5\xf4\xff\x83\xfe\x51\x4b\xff"
        "\x3f\xea\x1f\xb5\xf4\x3f\x55\xff\xa8\xa5\xff\x69\xfa\x47\x2d\xfd\xff"
        "\xa4\x7f\xd4\xd2\xff\x74\xfd\xa3\x96\xfe\x67\xe8\x1f\xb5\xf4\x3f\x53"
        "\xff\xa8\xa5\xff\x9f\xf5\x8f\x5a\xfa\x9f\xa5\x7f\xd4\xd2\xff\x6c\xfd"
        "\xa3\x96\xfe\x7f\xd1\x3f\x6a\xe9\xff\x57\xfd\xa3\x96\xfe\xe7\xe8\x1f"
        "\xb5\xf4\x3f\x57\xff\xa8\xa5\xff\x79\xfa\x47\x2d\xfd\xcf\xd7\x3f\x6a"
        "\xe9\x7f\x81\xfe\x51\x4b\xff\x0b\xf5\x8f\x5a\xfa\x5f\xa4\x7f\xd4\xd2"
        "\xff\x62\xfd\xa3\x96\xfe\x97\xe8\x1f\xb5\xf4\xbf\x54\xff\xa8\xa5\xff"
        "\x65\xfa\x47\x2d\xfd\x2f\xd7\x3f\x6a\xe9\x7f\x85\xfe\x51\x4b\xff\x2b"
        "\xf5\x8f\x5a\xfa\x5f\xa5\x7f\xd4\xd2\xff\x6a\xfd\xa3\x96\xfe\xd7\xe8"
        "\x1f\xb5\xf4\xbf\x56\xff\xa8\xa5\xff\x75\xfa\x47\x2d\xfd\xaf\xd7\x3f"
        "\x6a\xe9\x7f\x83\xfe\x51\x4b\xff\x1b\xf5\x8f\x5a\xfa\xdf\xa4\x7f\xd4"
        "\xd2\xff\x66\xfd\xa3\x96\xfe\xb7\xe8\x1f\xb5\xf4\xbf\x55\xff\xa8\xa5"
        "\xff\x6d\xfa\x47\x2d\xfd\x6f\xd7\x3f\x6a\xe9\x7f\x87\xfe\x51\x4b\xff"
        "\x3b\xf5\x8f\x5a\xfa\xdf\xa5\x7f\xd4\xd2\xff\x6e\xfd\xa3\x96\xfe\xf7"
        "\xe8\x1f\xb5\xf4\xbf\x57\xff\xa8\xa5\xff\x7d\xfa\x47\x2d\xfd\xef\xd7"
        "\x3f\x6a\xe9\xff\x80\xfe\x51\x4b\xff\x07\xf5\x8f\x5a\xfa\x3f\xa4\x7f"
        "\xd4\xd2\xff\x61\xfd\xa3\x96\xfe\x8f\xe8\x1f\xb5\xf4\x7f\x54\xff\xa8"
        "\xa5\xff\x63\xfa\x47\x2d\xfd\x1f\xd7\x3f\x6a\xe9\xff\x84\xfe\x51\x4b"
        "\xff\x27\xf5\x8f\x5a\xfa\x3f\xa5\x7f\xd4\xd2\xff\x69\xfd\xa3\x96\xfe"
        "\xcf\xe8\x1f\xb5\xf4\x7f\x56\xff\xa8\xa5\xff\x73\xfa\x47\x2d\xfd\x9f"
        "\xd7\x3f\x6a\xe9\xff\x82\xfe\x51\x4b\xff\x17\xf5\x8f\x5a\xfa\xbf\xa4"
        "\x7f\xd4\xd2\xff\x65\xfd\xa3\x92\xfe\x43\x06\xf4\x8f\x5a\xfa\x0f\xd2"
        "\x3f\x6a\xe9\x3f\x58\xff\xa8\xa5\xff\x38\xfa\x47\x2d\xfd\x87\xe8\x1f"
        "\xb5\xf4\x1f\xaa\x7f\xd4\xd2\x7f\x98\xfe\x51\x4b\xff\x71\xf5\x8f\x5a"
        "\xfa\x8f\xa7\x7f\xd4\xd2\x7f\x7c\xfd\xa3\x96\xfe\x13\xe8\x1f\xb5\xf4"
        "\x9f\x50\xff\xa8\xa5\xff\x44\xfa\x47\x2d\xfd\xdf\xa2\x7f\xd4\xd2\x7f"
        "\x62\xfd\xa3\x96\xfe\x93\xe8\x1f\xb5\xf4\x9f\x54\xff\xa8\xa5\xff\x64"
        "\xfa\x47\x2d\xfd\x27\xd7\x3f\x6a\xe9\x3f\x85\xfe\x51\x4b\xff\xb7\xea"
        "\x1f\xb5\xf4\x7f\x9b\xfe\x51\x4b\xff\x29\xf5\x8f\x5a\xfa\xbf\x5d\xff"
        "\xa8\xa5\xff\x54\xfa\x47\x2d\xfd\xdf\xa1\x7f\xd4\xd2\x7f\x6a\xfd\xa3"
        "\x96\xfe\xd3\xe8\x1f\xb5\xf4\x7f\xa7\xfe\x51\x4b\xff\x69\xf5\x8f\x5a"
        "\xfa\x4f\xa7\x7f\xd4\xd2\xff\x5d\xfa\x47\x2d\xfd\xa7\xd7\x3f\x6a\xe9"
        "\x3f\x83\xfe\x51\x4b\xff\x19\xf5\x8f\x5a\xfa\xcf\xa4\x7f\xd4\xd2\x7f"
        "\x66\xfd\xa3\x96\xfe\xb3\xe8\x1f\xb5\xf4\x7f\xb7\xfe\x51\x4b\xff\x59"
        "\xf5\x8f\x5a\xfa\xcf\xa6\x7f\xd4\xd2\xff\x3d\xfa\x47\x2d\xfd\xdf\xab"
        "\x7f\xd4\xd2\xff\x7d\xfa\x47\x2d\xfd\x67\xd7\x3f\x6a\xe9\x3f\x87\xfe"
        "\x51\x4b\xff\x39\xf5\x8f\x5a\xfa\xcf\xa5\x7f\xd4\xd2\x7f\x6e\xfd\xa3"
        "\x96\xfe\xf3\xe8\x1f\xb5\xf4\x9f\x57\xff\xa8\xa5\xff\x7c\xfa\x47\x2d"
        "\xfd\xdf\xaf\x7f\xd4\xd2\xff\x03\xfa\x47\x2d\xfd\x3f\xa8\x7f\xd4\xd2"
        "\x7f\x7e\xfd\xa3\x96\xfe\x0b\xe8\x1f\xb5\xf4\x5f\x50\xff\xa8\xa5\xff"
        "\x87\xf4\x8f\x5a\xfa\x2f\xa4\x7f\xd4\xd2\x7f\x61\xfd\xa3\x96\xfe\x1f"
        "\xd6\x3f\x6a\xe9\xff\x11\xfd\xa3\x96\xfe\x8b\xe8\x1f\xb5\xf4\x5f\x54"
        "\xff\xa8\xa5\xff\x62\xfa\x47\x2d\xfd\x17\xd7\x3f\x6a\xe9\xbf\x84\xfe"
        "\x51\x4b\xff\x25\x7b\xfb\x0f\x7d\xad\x3b\x5b\xfa\x2f\xd5\xdb\xff\x35"
        "\xb5\xf4\x5f\x5a\xff\xa8\xa5\xff\x32\xfa\x47\x2d\xfd\x97\xd5\x3f\x6a"
        "\xe9\xbf\x9c\xfe\x51\x4b\xff\x8f\xea\x1f\xb5\xf4\xff\x98\xfe\x51\x4b"
        "\xff\xe5\xf5\x8f\x5a\xfa\x7f\x5c\xff\xa8\xa5\xff\x27\xf4\x8f\x5a\xfa"
        "\x7f\x52\xff\xa8\xa5\xff\xa7\xf4\x8f\x5a\xfa\xaf\xa0\x7f\xd4\xd2\x7f"
        "\x45\xfd\xa3\x96\xfe\x2b\xe9\x1f\xb5\xf4\x5f\x59\xff\xa8\xa5\xff\x2a"
        "\xfa\x47\x2d\xfd\x3f\xad\x7f\xd4\xd2\xff\x33\xfa\x47\x2d\xfd\x57\xd5"
        "\x3f\x6a\xe9\xff\x59\xfd\xa3\x96\xfe\x9f\xd3\x3f\x6a\xe9\xff\x79\xfd"
        "\xa3\x96\xfe\xab\xe9\x1f\xb5\xf4\xff\x82\xfe\x51\x4b\xff\xd5\xf5\x8f"
        "\x5a\xfa\xaf\xa1\x7f\xd4\xd2\x7f\x4d\xfd\xa3\x96\xfe\x6b\xe9\x1f\xb5"
        "\xf4\x5f\x5b\xff\xa8\xa5\xff\x3a\xfa\x47\x2d\xfd\xd7\xd5\x3f\x6a\xe9"
        "\xbf\x9e\xfe\x51\x4b\xff\xf5\xf5\x8f\x5a\xfa\x6f\xa0\x7f\xd4\xd2\x7f"
        "\x43\xfd\xa3\x96\xfe\x1b\xe9\x1f\xb5\xf4\xff\xa2\xfe\x51\x4b\xff\x8d"
        "\xf5\x8f\x5a\xfa\x6f\xa2\x7f\xd4\xd2\x7f\x53\xfd\xa3\x96\xfe\x9b\xe9"
        "\x1f\xb5\xf4\xdf\x5c\xff\xa8\xa5\xff\x16\xfa\x47\x2d\xfd\xb7\xd4\x3f"
        "\x6a\xe9\xbf\x95\xfe\x51\x4b\xff\xad\xf5\x8f\x5a\xfa\x6f\xa3\x7f\xd4"
        "\xd2\x7f\x5b\xfd\xa3\x96\xfe\xdb\xe9\x1f\xb5\xf4\xff\x92\xfe\x51\x4b"
        "\xff\xed\xf5\x8f\x5a\xfa\xef\xa0\x7f\xd4\xd2\x7f\x47\xfd\xa3\x96\xfe"
        "\x3b\xe9\x1f\xb5\xf4\xff\xb2\xfe\x51\x4b\xff\xaf\xe8\x1f\xb5\xf4\xdf"
        "\x59\xff\xa8\xa5\xff\x2e\xfa\x47\x2d\xfd\x77\xd5\x3f\x6a\xe9\xbf\x9b"
        "\xfe\x51\x4b\xff\xaf\xea\x1f\xb5\xf4\xff\x9a\xfe\x51\x4b\xff\xaf\xeb"
        "\x1f\xb5\xf4\xff\x86\xfe\x51\x4b\xff\x6f\xea\x1f\xb5\xf4\xdf\x5d\xff"
        "\xa8\xa5\xff\xb7\xf4\x8f\x5a\xfa\xef\xa1\x7f\xd4\xd2\x7f\x4f\xfd\xa3"
        "\x96\xfe\xdf\xd6\x3f\x6a\xe9\xbf\x97\xfe\x51\x4b\xff\xbd\xf5\x8f\x5a"
        "\xfa\xef\xa3\x7f\xd4\xd2\xff\x3b\xfa\x47\x2d\xfd\xf7\xd5\x3f\x6a\xe9"
        "\xbf\x9f\xfe\x51\x4b\xff\xef\xea\x1f\xb5\xf4\xff\x9e\xfe\x51\x4b\xff"
        "\xfd\xf5\x8f\x5a\xfa\x7f\x5f\xff\xa8\xa5\xff\x0f\xf4\x8f\x5a\xfa\xff"
        "\x50\xff\xa8\xa5\xff\x01\xfa\x47\x2d\xfd\x7f\xa4\x7f\xd4\xd2\xff\xc7"
        "\xfa\x47\x2d\xfd\x0f\xd4\x3f\x6a\xe9\x7f\x90\xfe\x51\x4b\xff\x83\xf5"
        "\x8f\x5a\xfa\x1f\xa2\x7f\xd4\xd2\xff\x27\xfa\x47\x2d\xfd\x0f\xd5\x3f"
        "\x6a\xe9\x7f\x98\xfe\x51\x4b\xff\xc3\xf5\x8f\x5a\xfa\x1f\xa1\x7f\xd4"
        "\xd2\xff\x48\xfd\xa3\x96\xfe\x47\xe9\x1f\xb5\xf4\xff\xa9\xfe\x51\x4b"
        "\xff\x9f\xe9\x1f\xb5\xf4\x3f\x5a\xff\xa8\xa5\xff\xcf\xf5\x8f\x5a\xfa"
        "\x1f\xa3\x7f\xd4\xd2\xff\x17\xfa\x47\x2d\xfd\x7f\xa9\x7f\xd4\xd2\xff"
        "\x58\xfd\xa3\x96\xfe\xbf\xd2\x3f\x6a\xe9\x7f\x9c\xfe\x51\x4b\xff\xe3"
        "\xf5\x8f\x5a\xfa\xff\x5a\xff\xa8\xa5\xff\x09\xfa\x47\x2d\xfd\x7f\xa3"
        "\x7f\xd4\xd2\xff\x44\xfd\xa3\x96\xfe\x27\xe9\x1f\xb5\xf4\x3f\x59\xff"
        "\xa8\xa5\xff\x6f\xf5\x8f\x5a\xfa\xff\x4e\xff\xa8\xa5\xff\xef\xf5\x8f"
        "\x5a\xfa\x9f\xa2\x7f\xd4\xd2\xff\x0f\xfa\x47\x2d\xfd\xff\xa8\x7f\xd4"
        "\xd2\xff\x54\xfd\xa3\x96\xfe\xa7\xe9\x1f\xb5\xf4\xff\x93\xfe\x51\x4b"
        "\xff\xd3\xf5\x8f\x5a\xfa\x9f\xa1\x7f\xd4\xd2\xff\x4c\xfd\xa3\x96\xfe"
        "\x7f\xd6\x3f\x6a\xe9\x7f\x96\xfe\x51\x4b\xff\xb3\xf5\x8f\x5a\xfa\xff"
        "\x45\xff\xa8\xa5\xff\x5f\xf5\x8f\x5a\xfa\x9f\xa3\x7f\xd4\xd2\xff\x5c"
        "\xfd\xa3\x96\xfe\xe7\xe9\x1f\xb5\xf4\x3f\x5f\xff\xa8\xa5\xff\x05\xfa"
        "\x47\x2d\xfd\x2f\xd4\x3f\x6a\xe9\x7f\x91\xfe\x51\x4b\xff\x8b\xf5\x8f"
        "\x5a\xfa\x5f\xa2\x7f\xd4\xd2\xff\x52\xfd\xa3\x96\xfe\x97\xe9\x1f\xb5"
        "\xf4\xbf\x5c\xff\xa8\xa5\xff\x15\xfa\x47\x2d\xfd\xaf\xd4\x3f\x6a\xe9"
        "\x7f\x95\xfe\x51\x4b\xff\xab\xf5\x8f\x5a\xfa\x5f\xa3\x7f\xd4\xd2\xff"
        "\x5a\xfd\xa3\x96\xfe\xd7\xe9\x1f\xb5\xf4\xbf\x5e\xff\xa8\xa5\xff\x0d"
        "\xfa\x47\x2d\xfd\x6f\xd4\x3f\x6a\xe9\x7f\x93\xfe\x51\x4b\xff\x9b\xf5"
        "\x8f\x5a\xfa\xdf\xa2\x7f\xd4\xd2\xff\x56\xfd\xa3\x96\xfe\xb7\xe9\x1f"
        "\xb5\xf4\xbf\x5d\xff\xa8\xa5\xff\x1d\xfa\x47\x2d\xfd\xef\xd4\x3f\x6a"
        "\xe9\x7f\x97\xfe\x51\x4b\xff\xbb\xf5\x8f\x5a\xfa\xdf\xa3\x7f\xd4\xd2"
        "\xff\x5e\xfd\xa3\x96\xfe\xf7\xe9\x1f\xb5\xf4\xbf\x5f\xff\xa8\xa5\xff"
        "\x03\xfa\x47\x2d\xfd\x1f\xd4\x3f\x6a\xe9\xff\x90\xfe\x51\x4b\xff\x87"
        "\xf5\x8f\x5a\xfa\x3f\xa2\x7f\xd4\xd2\xff\x51\xfd\xa3\x96\xfe\x8f\xe9"
        "\x1f\xb5\xf4\x7f\x5c\xff\xa8\xa5\xff\x13\xfa\x47\x2d\xfd\x9f\xd4\x3f"
        "\x6a\xe9\xff\x94\xfe\x51\x4b\xff\xa7\xf5\x8f\x5a\xfa\x3f\xa3\x7f\xd4"
        "\xd2\xff\x59\xfd\xa3\x96\xfe\xcf\xe9\x1f\xb5\xf4\x7f\x5e\xff\xa8\xa5"
        "\xff\x0b\xfa\x47\x2d\xfd\x5f\xd4\x3f\x6a\xe9\xff\x92\xfe\x51\x4b\xff"
        "\x97\xf5\x8f\x4a\xfa\x0f\x1d\xd0\x3f\x6a\xe9\x3f\x48\xff\xa8\xa5\xff"
        "\x60\xfd\xa3\x96\xfe\xe3\xe8\x1f\xb5\xf4\x1f\xd2\xda\x7f\xe8\x6b\xdf"
        "\xdd\xd2\x7f\x68\x6b\xff\x7f\xa2\xa5\xff\x30\xfd\xa3\x96\xfe\xe3\xea"
        "\x1f\xb5\xf4\x1f\x4f\xff\xa8\xa5\xff\xf8\xfa\x47\x2d\xfd\x27\xd0\x3f"
        "\x6a\xe9\x3f\xa1\xfe\x51\x4b\xff\x89\xf4\x8f\x5a\xfa\xbf\x45\xff\xa8"
        "\xa5\xff\xc4\xfa\x47\x2d\xfd\x27\xd1\x3f\x6a\xe9\x3f\xa9\xfe\x51\x4b"
        "\xff\xc9\xf4\x8f\x5a\xfa\x4f\xae\x7f\xd4\xd2\x7f\x0a\xfd\xa3\x96\xfe"
        "\x6f\xd5\x3f\x6a\xe9\xff\x36\xfd\xa3\x96\xfe\x53\xea\x1f\xb5\xf4\x7f"
        "\xbb\xfe\x51\x4b\xff\xa9\xf4\x8f\x5a\xfa\xbf\x43\xff\xa8\xa5\xff\xd4"
        "\xfa\x47\x2d\xfd\xa7\xd1\x3f\x6a\xe9\xff\x4e\xfd\xa3\x96\xfe\xd3\xea"
        "\x1f\xb5\xf4\x9f\x4e\xff\xa8\xa5\xff\xbb\xf4\x8f\x5a\xfa\x4f\xaf\x7f"
        "\xd4\xd2\x7f\x06\xfd\xa3\x96\xfe\x33\xea\x1f\xb5\xf4\x9f\x49\xff\xa8"
        "\xa5\xff\xcc\xfa\x47\x2d\xfd\x67\xd1\x3f\x6a\xe9\xff\x6e\xfd\xa3\x96"
        "\xfe\xb3\xea\x1f\xb5\xf4\x9f\x4d\xff\xa8\xa5\xff\x7b\xf4\x8f\x5a\xfa"
        "\xbf\x57\xff\xa8\xa5\xff\xfb\xf4\x8f\x5a\xfa\xcf\xae\x7f\xd4\xd2\x7f"
        "\x0e\xfd\xa3\x96\xfe\x73\xea\x1f\xb5\xf4\x9f\x4b\xff\xa8\xa5\xff\xdc"
        "\xfa\x47\x2d\xfd\xe7\xd1\x3f\x6a\xe9\x3f\xaf\xfe\x51\x4b\xff\xf9\xf4"
        "\x8f\x5a\xfa\xbf\x5f\xff\xa8\xa5\xff\x07\xf4\x8f\x5a\xfa\x7f\x50\xff"
        "\xa8\xa5\xff\xfc\xfa\x47\x2d\xfd\x17\xd0\x3f\x6a\xe9\xbf\xa0\xfe\x51"
        "\x4b\xff\x0f\xe9\x1f\xb5\xf4\x5f\x48\xff\xa8\xa5\xff\xc2\xfa\x47\x2d"
        "\xfd\x3f\xac\x7f\xd4\xd2\xff\x23\xfa\x47\x2d\xfd\x17\xd1\x3f\x6a\xe9"
        "\xbf\xa8\xfe\x51\x4b\xff\xc5\xf4\x8f\x5a\xfa\x2f\xae\x7f\xd4\xd2\x7f"
        "\x09\xfd\xa3\x96\xfe\x4b\xea\x1f\xb5\xf4\x5f\x4a\xff\xa8\xa5\xff\xd2"
        "\xfa\x47\x2d\xfd\x97\xd1\x3f\x6a\xe9\xbf\xac\xfe\x51\x4b\xff\xe5\xf4"
        "\x8f\x5a\xfa\x7f\x54\xff\xa8\xa5\xff\xc7\xf4\x8f\x5a\xfa\x2f\xaf\x7f"
        "\xd4\xd2\xff\xe3\xfa\x47\x2d\xfd\x3f\xa1\x7f\xd4\xd2\xff\x93\xfa\x47"
        "\x2d\xfd\x3f\xa5\x7f\xd4\xd2\x7f\x05\xfd\xa3\x96\xfe\x2b\xea\x1f\xb5"
        "\xf4\x5f\x49\xff\xa8\xa5\xff\xca\xfa\x47\x2d\xfd\x57\xd1\x3f\x6a\xe9"
        "\xff\x69\xfd\xa3\x96\xfe\x9f\xd1\x3f\x6a\xe9\xbf\xaa\xfe\x51\x4b\xff"
        "\xcf\xea\x3f\x86\x71\x5f\xf9\xda\xd2\xff\x73\xfa\x47\x2d\xfd\x3f\xaf"
        "\x7f\xd4\xd2\x7f\x35\xfd\xa3\x96\xfe\x5f\xd0\x3f\x6a\xe9\xbf\xba\xfe"
        "\x51\x4b\xff\x35\xf4\x8f\x5a\xfa\xaf\xa9\x7f\xd4\xd2\x7f\x2d\xfd\xa3"
        "\x96\xfe\x6b\xeb\x1f\xb5\xf4\x5f\x47\xff\xa8\xa5\xff\xba\xfa\x47\x2d"
        "\xfd\xd7\xd3\x3f\x6a\xe9\xbf\xbe\xfe\x51\x4b\xff\x0d\xf4\x8f\x5a\xfa"
        "\x6f\xa8\x7f\xd4\xd2\x7f\x23\xfd\xa3\x96\xfe\x5f\xd4\x3f\x6a\xe9\xbf"
        "\xb1\xfe\x51\x4b\xff\x4d\xf4\x8f\x5a\xfa\x6f\xaa\x7f\xd4\xd2\x7f\x33"
        "\xfd\xa3\x96\xfe\x9b\xeb\x1f\xb5\xf4\xdf\x42\xff\xa8\xa5\xff\x96\xfa"
        "\x47\x2d\xfd\xb7\xd2\x3f\x6a\xe9\xbf\xb5\xfe\x51\x4b\xff\x6d\xf4\x8f"
        "\x5a\xfa\x6f\xab\x7f\xd4\xd2\x7f\x3b\xfd\xa3\x96\xfe\x5f\xd2\x3f\x6a"
        "\xe9\xbf\xbd\xfe\x51\x4b\xff\x1d\xf4\x8f\x5a\xfa\xef\xa8\x7f\xd4\xd2"
        "\x7f\x27\xfd\xa3\x96\xfe\x5f\xd6\x3f\x6a\xe9\xff\x15\xfd\xa3\x96\xfe"
        "\x3b\xeb\x1f\xb5\xf4\xdf\x45\xff\xa8\xa5\xff\xae\xfa\x47\x2d\xfd\x77"
        "\xd3\x3f\x6a\xe9\xff\x55\xfd\xa3\x96\xfe\x5f\xd3\x3f\x6a\xe9\xff\x75"
        "\xfd\xa3\x96\xfe\xdf\xd0\x3f\x6a\xe9\xff\x4d\xfd\xa3\x96\xfe\xbb\xeb"
        "\x1f\xb5\xf4\xff\x96\xfe\x51\x4b\xff\x3d\xf4\x8f\x5a\xfa\xef\xa9\x7f"
        "\xd4\xd2\xff\xdb\xfa\x47\x2d\xfd\xf7\xd2\x3f\x6a\xe9\xbf\xb7\xfe\x51"
        "\x4b\xff\x7d\xf4\x8f\x5a\xfa\x7f\x47\xff\xa8\xa5\xff\xbe\xfa\x47\x2d"
        "\xfd\xf7\xd3\x3f\x6a\xe9\xff\x5d\xfd\xa3\x96\xfe\xdf\xd3\x3f\x6a\xe9"
        "\xbf\xbf\xfe\x51\x4b\xff\xef\xeb\x1f\xb5\xf4\xff\x81\xfe\x51\x4b\xff"
        "\x1f\xea\x1f\xb5\xf4\x3f\x40\xff\xa8\xa5\xff\x8f\xf4\x8f\x5a\xfa\xff"
        "\x58\xff\xa8\xa5\xff\x81\xfa\x47\x2d\xfd\x0f\xd2\x3f\x6a\xe9\x7f\xb0"
        "\xfe\x51\x4b\xff\x43\xf4\x8f\x5a\xfa\xff\x44\xff\xa8\xa5\xff\xa1\xfa"
        "\x47\x2d\xfd\x0f\xd3\x3f\x6a\xe9\x7f\xb8\xfe\x51\x4b\xff\x23\xf4\x8f"
        "\x5a\xfa\x1f\xa9\x7f\xd4\xd2\xff\x28\xfd\xa3\x96\xfe\x3f\xd5\x3f\x6a"
        "\xe9\xff\x33\xfd\xa3\x96\xfe\x47\xeb\x1f\xb5\xf4\xff\xb9\xfe\x51\x4b"
        "\xff\x63\xf4\x8f\x5a\xfa\xff\x42\xff\xa8\xa5\xff\x2f\xf5\x8f\x5a\xfa"
        "\x1f\xab\x7f\xd4\xd2\xff\x57\xfa\x47\x2d\xfd\x8f\xd3\x3f\x6a\xe9\x7f"
        "\xbc\xfe\x51\x4b\xff\x5f\xeb\x1f\xb5\xf4\x3f\x41\xff\xa8\xa5\xff\x6f"
        "\xf4\x8f\x5a\xfa\x9f\xa8\x7f\xd4\xd2\xff\x24\xfd\xa3\x96\xfe\x27\xeb"
        "\x1f\xb5\xf4\xff\xad\xfe\x51\x4b\xff\xdf\xe9\x1f\xb5\xf4\xff\xbd\xfe"
        "\x51\x4b\xff\x53\xf4\x8f\x5a\xfa\xff\x41\xff\xa8\xa5\xff\x1f\xf5\x8f"
        "\x5a\xfa\x9f\xaa\x7f\xd4\xd2\xff\x34\xfd\xa3\x96\xfe\x7f\xd2\x3f\x6a"
        "\xe9\x7f\xba\xfe\x51\x4b\xff\x33\xf4\x8f\x5a\xfa\x9f\xa9\x7f\xd4\xd2"
        "\xff\xcf\xfa\x47\x2d\xfd\xcf\xd2\x3f\x6a\xe9\x7f\xb6\xfe\x51\x4b\xff"
        "\xbf\xe8\x1f\xb5\xf4\xff\xab\xfe\x51\x4b\xff\x73\xf4\x8f\x5a\xfa\x9f"
        "\xab\x7f\xd4\xd2\xff\x3c\xfd\xa3\x96\xfe\xe7\xeb\x1f\xb5\xf4\xbf\x40"
        "\xff\xa8\xa5\xff\x85\xfa\x47\x2d\xfd\x2f\xd2\x3f\x6a\xe9\x7f\xb1\xfe"
        "\x51\x4b\xff\x4b\xf4\x8f\x5a\xfa\x5f\xaa\x7f\xd4\xd2\xff\x32\xfd\xa3"
        "\x96\xfe\x97\xeb\x1f\xb5\xf4\xbf\x42\xff\xa8\xa5\xff\x95\xfa\x47\x2d"
        "\xfd\xaf\xd2\x3f\x6a\xe9\x7f\xb5\xfe\x51\x4b\xff\x6b\xf4\x8f\x5a\xfa"
        "\x5f\xab\x7f\xd4\xd2\xff\x3a\xfd\xa3\x96\xfe\xd7\xeb\x1f\xb5\xf4\xbf"
        "\x41\xff\xa8\xa5\xff\x8d\xfa\x47\x2d\xfd\x6f\xd2\x3f\x6a\xe9\x7f\xb3"
        "\xfe\x51\x4b\xff\x5b\xf4\x8f\x5a\xfa\xdf\xaa\x7f\xd4\xd2\xff\x36\xfd"
        "\xa3\x96\xfe\xb7\xeb\x1f\xb5\xf4\xbf\x43\xff\xa8\xa5\xff\x9d\xfa\x47"
        "\x2d\xfd\xef\xd2\x3f\x6a\xe9\x7f\xb7\xfe\x51\x4b\xff\x7b\xf4\x8f\x5a"
        "\xfa\xdf\xab\x7f\xd4\xd2\xff\x3e\xfd\xa3\x96\xfe\xf7\xeb\x1f\xb5\xf4"
        "\x7f\x40\xff\xa8\xa5\xff\x83\xfa\x47\x2d\xfd\x1f\xd2\x3f\x6a\xe9\xff"
        "\xb0\xfe\x51\x4b\xff\x47\xf4\x8f\x5a\xfa\x3f\xaa\x7f\xd4\xd2\xff\x31"
        "\xfd\xa3\x96\xfe\x8f\xeb\x1f\xb5\xf4\x7f\x42\xff\xa8\xa5\xff\x93\xfa"
        "\x47\x2d\xfd\x9f\xd2\x3f\x6a\xe9\xff\xb4\xfe\x51\x4b\xff\x67\xf4\x8f"
        "\x5a\xfa\x3f\xab\x7f\xd4\xd2\xff\x39\xfd\xa3\x96\xfe\xcf\xeb\x1f\xb5"
        "\xf4\x7f\x41\xff\xa8\xa5\xff\x8b\xfa\x47\x2d\xfd\x5f\xd2\x3f\x6a\xe9"
        "\xff\xb2\xfe\x51\x49\xff\x61\x03\xfa\x47\x2d\xfd\x07\xe9\x1f\xb5\xf4"
        "\x1f\xac\x7f\xd4\xd2\x7f\x1c\xfd\xa3\x96\xfe\x43\xf4\x8f\x5a\xfa\x0f"
        "\xd5\x3f\x6a\xe9\x3f\x4c\xff\xa8\xa5\xff\xb8\xfa\x47\x2d\xfd\xc7\xd3"
        "\x3f\x6a\xe9\x3f\xbe\xfe\x51\x4b\xff\x09\xf4\x8f\x5a\xfa\x4f\xa8\x7f"
        "\xd4\xd2\x7f\x22\xfd\xa3\x96\xfe\x6f\xd1\x3f\x6a\xe9\x3f\xb1\xfe\x51"
        "\x4b\xff\x49\xf4\x8f\x5a\xfa\x4f\xaa\x7f\xd4\xd2\x7f\x32\xfd\xa3\x96"
        "\xfe\x93\xeb\x1f\xb5\xf4\x9f\x42\xff\xa8\xa5\xff\x5b\xf5\x8f\x5a\xfa"
        "\xbf\x4d\xff\xa8\xa5\xff\x94\xfa\x47\x2d\xfd\xdf\xae\x7f\xd4\xd2\x7f"
        "\x2a\xfd\xa3\x96\xfe\xef\xd0\x3f\x6a\xe9\x3f\xb5\xfe\x51\x4b\xff\x69"
        "\xf4\x8f\x5a\xfa\xbf\x53\xff\xa8\xa5\xff\xb4\xfa\x47\x2d\xfd\xa7\xd3"
        "\x3f\x6a\xe9\xff\x2e\xfd\xa3\x96\xfe\xd3\xeb\x1f\xb5\xf4\x9f\x41\xff"
        "\xa8\xa5\xff\x8c\xfa\x47\x2d\xfd\x67\xd2\x3f\x6a\xe9\x3f\xb3\xfe\x51"
        "\x4b\xff\x59\xf4\x8f\x5a\xfa\xbf\x5b\xff\xa8\xa5\xff\xac\xfa\x47\x2d"
        "\xfd\x67\xd3\x3f\x6a\xe9\xff\x1e\xfd\xa3\x96\xfe\xef\xd5\x3f\x6a\xe9"
        "\xff\x3e\xfd\xa3\x96\xfe\xb3\xeb\x1f\xb5\xf4\x9f\x43\xff\xa8\xa5\xff"
        "\x9c\xfa\x47\x2d\xfd\xe7\xd2\x3f\x6a\xe9\x3f\xb7\xfe\x51\x4b\xff\x79"
        "\xf4\x8f\x5a\xfa\xcf\xab\x7f\xd4\xd2\x7f\x3e\xfd\xa3\x96\xfe\xef\xd7"
        "\x3f\x6a\xe9\xff\x01\xfd\xa3\x96\xfe\x1f\xd4\x3f\x6a\xe9\x3f\xbf\xfe"
        "\x51\x4b\xff\x05\xf4\x8f\x5a\xfa\x2f\xa8\x7f\xd4\xd2\xff\x43\xfa\x47"
        "\x2d\xfd\x17\xd2\x3f\x6a\xe9\xbf\xb0\xfe\x51\x4b\xff\x0f\xeb\x1f\xb5"
        "\xf4\xff\x88\xfe\x51\x4b\xff\x45\xf4\x8f\x5a\xfa\x2f\xaa\x7f\xd4\xd2"
        "\x7f\x31\xfd\xa3\x96\xfe\x8b\xeb\x1f\xb5\xf4\x5f\x42\xff\xa8\xa5\xff"
        "\x92\xfa\x47\x2d\xfd\x97\xd2\x3f\x6a\xe9\xbf\xb4\xfe\x51\x4b\xff\x65"
        "\xf4\x8f\x5a\xfa\x2f\xab\x7f\xd4\xd2\x7f\x39\xfd\xa3\x96\xfe\x1f\xd5"
        "\x3f\x6a\xe9\xff\x31\xfd\xa3\x96\xfe\xcb\xeb\x1f\xb5\xf4\xff\xb8\xfe"
        "\x51\x4b\xff\x4f\xe8\x1f\xb5\xf4\xff\xa4\xfe\x51\x4b\xff\x4f\xe9\x1f"
        "\xb5\xf4\x5f\x41\xff\xa8\xa5\xff\x8a\xfa\x47\x2d\xfd\x57\xd2\x3f\x6a"
        "\xe9\xbf\xb2\xfe\x51\x4b\xff\x55\xf4\x8f\x5a\xfa\x7f\x5a\xff\xa8\xa5"
        "\xff\x67\xf4\x8f\x5a\xfa\xaf\xaa\x7f\xd4\xd2\xff\xb3\xfa\x47\x2d\xfd"
        "\x3f\xa7\x7f\xd4\xd2\xff\xf3\xfa\x47\x2d\xfd\x57\xd3\x3f\x6a\xe9\xff"
        "\x05\xfd\xa3\x96\xfe\xab\xeb\x1f\xb5\xf4\x5f\x43\xff\xa8\xa5\xff\x9a"
        "\xfa\x47\x2d\xfd\xd7\xd2\x3f\x6a\xe9\xbf\xb6\xfe\x51\x4b\xff\x75\xf4"
        "\x8f\x5a\xfa\xaf\xab\x7f\xd4\xd2\x7f\x3d\xfd\xa3\x96\xfe\xeb\xeb\x1f"
        "\xb5\xf4\xdf\x40\xff\xa8\xa5\xff\x86\xfa\x47\x2d\xfd\x37\xd2\x3f\x58"
        "\xe1\xf1\x96\xfe\x5f\xd4\x3f\x6a\xe9\xbf\xb1\xfe\x51\x4b\xff\x4d\xf4"
        "\x8f\x5a\xfa\x6f\xaa\x7f\xd4\xd2\x7f\x33\xfd\xa3\x96\xfe\x9b\xeb\x1f"
        "\xb5\xf4\xdf\x42\xff\xa8\xa5\xff\x96\xfa\x47\x2d\xfd\xb7\xd2\x3f\x6a"
        "\xe9\xbf\xb5\xfe\x51\x4b\xff\x6d\xf4\x8f\x5a\xfa\x6f\xab\x7f\xd4\xd2"
        "\x7f\x3b\xfd\xa3\x96\xfe\x5f\xd2\x3f\x6a\xe9\xbf\xbd\xfe\x51\x4b\xff"
        "\x1d\xf4\x8f\x5a\xfa\xef\xa8\x7f\xd4\xd2\x7f\x27\xfd\xa3\x96\xfe\x5f"
        "\xd6\x3f\x6a\xe9\xff\x15\xfd\xa3\x96\xfe\x3b\xeb\x1f\xb5\xf4\xdf\x45"
        "\xff\xa8\xa5\xff\xae\xfa\x47\x2d\xfd\x77\xd3\x3f\x6a\xe9\xff\x55\xfd"
        "\xa3\x96\xfe\x5f\xd3\x3f\x6a\xe9\xff\x75\xfd\xa3\x96\xfe\xdf\xd0\x3f"
        "\x6a\xe9\xff\x4d\xfd\xa3\x96\xfe\xbb\xeb\x1f\xb5\xf4\xff\x96\xfe\x51"
        "\x4b\xff\x3d\xf4\x8f\x5a\xfa\xef\xa9\x7f\xd4\xd2\xff\xdb\xfa\x47\x2d"
        "\xfd\xf7\xd2\x3f\x6a\xe9\xbf\xb7\xfe\x51\x4b\xff\x7d\xf4\x8f\x5a\xfa"
        "\x7f\x47\xff\xa8\xa5\xff\xbe\xfa\x47\x2d\xfd\xf7\xd3\x3f\x6a\xe9\xff"
        "\x5d\xfd\xa3\x96\xfe\xdf\xd3\x3f\x6a\xe9\xbf\xbf\xfe\x51\x4b\xff\xef"
        "\xeb\x1f\xb5\xf4\xff\x81\xfe\x51\x4b\xff\x1f\xea\x1f\xb5\xf4\x3f\x40"
        "\xff\xa8\xa5\xff\x8f\xf4\x8f\x5a\xfa\xff\x58\xff\xa8\xa5\xff\x81\xfa"
        "\x47\x2d\xfd\x0f\xd2\x3f\x6a\xe9\x7f\xb0\xfe\x51\x4b\xff\x43\xf4\x8f"
        "\x5a\xfa\xff\x44\xff\xa8\xa5\xff\xa1\xfa\x47\x2d\xfd\x0f\xd3\x3f\x6a"
        "\xe9\x7f\xb8\xfe\x51\x4b\xff\x23\xf4\x8f\x5a\xfa\x1f\xa9\x7f\xd4\xd2"
        "\xff\x28\xfd\xa3\x96\xfe\x3f\xd5\x3f\x6a\xe9\xff\x33\xfd\xa3\x96\xfe"
        "\x47\xeb\x1f\xb5\xf4\xff\xb9\xfe\x51\x4b\xff\x63\xf4\x8f\x5a\xfa\xff"
        "\x42\xff\xa8\xa5\xff\x2f\xf5\x8f\x5a\xfa\x1f\xab\x7f\xd4\xd2\xff\x57"
        "\xfa\x47\x2d\xfd\x8f\xd3\x3f\x6a\xe9\x7f\xbc\xfe\x51\x4b\xff\x5f\xeb"
        "\x1f\xb5\xf4\x3f\x41\xff\xa8\xa5\xff\x6f\xf4\x8f\x5a\xfa\x9f\xa8\x7f"
        "\xd4\xd2\xff\x24\xfd\xa3\x96\xfe\x27\xeb\x1f\xb5\xf4\xff\xad\xfe\x51"
        "\x4b\xff\xdf\xe9\x1f\xb5\xf4\xff\xbd\xfe\x51\x4b\xff\x53\xf4\x8f\x5a"
        "\xfa\xff\x41\xff\xa8\xa5\xff\x1f\xf5\x8f\x5a\xfa\x9f\xaa\x7f\xd4\xd2"
        "\xff\x34\xfd\xa3\x96\xfe\x7f\xd2\x3f\x6a\xe9\x7f\xba\xfe\x51\x4b\xff"
        "\x33\xf4\x8f\x5a\xfa\x9f\xa9\x7f\xd4\xd2\xff\xcf\xfa\x47\x2d\xfd\xcf"
        "\xd2\x3f\x6a\xe9\x7f\xb6\xfe\x51\x4b\xff\xbf\xe8\x1f\xb5\xf4\xff\xab"
        "\xfe\x51\x4b\xff\x73\xf4\x8f\x5a\xfa\x9f\xab\x7f\xd4\xd2\xff\x3c\xfd"
        "\xa3\x96\xfe\xe7\xeb\x1f\xb5\xf4\xbf\x40\xff\xa8\xa5\xff\x85\xfa\x47"
        "\x2d\xfd\x2f\xd2\x3f\x6a\xe9\x7f\xb1\xfe\x51\x4b\xff\x4b\xf4\x8f\x5a"
        "\xfa\x5f\xaa\x7f\xd4\xd2\xff\x32\xfd\xa3\x96\xfe\x97\xeb\x1f\xb5\xf4"
        "\xbf\x42\xff\xa8\xa5\xff\x95\xfa\x47\x2d\xfd\xaf\xd2\x3f\x6a\xe9\x7f"
        "\xb5\xfe\x51\x4b\xff\x6b\xf4\x8f\x5a\xfa\x5f\xab\x7f\xd4\xd2\xff\x3a"
        "\xfd\xa3\x96\xfe\xd7\xeb\x1f\xb5\xf4\xbf\x41\xff\xa8\xa5\xff\x8d\xfa"
        "\x47\x2d\xfd\x6f\xd2\x3f\x6a\xe9\x7f\xb3\xfe\x51\x4b\xff\x5b\xf4\x8f"
        "\x5a\xfa\xdf\xaa\x7f\xd4\xd2\xff\x36\xfd\xa3\x96\xfe\xb7\xeb\x1f\xb5"
        "\xf4\xbf\x43\xff\xa8\xa5\xff\x9d\xfa\x47\x2d\xfd\xef\xd2\x3f\x6a\xe9"
        "\x7f\xb7\xfe\x51\x4b\xff\x7b\xf4\x8f\x5a\xfa\xdf\xab\x7f\xd4\xd2\xff"
        "\x3e\xfd\xa3\x96\xfe\xf7\xeb\x1f\xb5\xf4\x7f\x40\xff\xa8\xa5\xff\x83"
        "\xfa\x47\x2d\xfd\x1f\xd2\x3f\x6a\xe9\xff\xb0\xfe\x51\x4b\xff\x47\xf4"
        "\x8f\x5a\xfa\x3f\xaa\x7f\xd4\xd2\xff\x31\xfd\xa3\x96\xfe\x8f\xeb\x1f"
        "\xb5\xf4\x7f\x42\xff\xa8\xa5\xff\x93\xfa\x47\x2d\xfd\x9f\xd2\x3f\x6a"
        "\xe9\xff\xb4\xfe\x51\x4b\xff\x67\xf4\x8f\x5a\xfa\x3f\xab\x7f\xd4\xd2"
        "\xff\x39\xfd\xa3\x96\xfe\xcf\xeb\x1f\xb5\xf4\x7f\x41\xff\xa8\xa5\xff"
        "\x8b\xfa\x47\x2d\xfd\x5f\xd2\x3f\x6a\xe9\xff\xb2\xfe\x51\x49\xff\x71"
        "\x07\xf4\x8f\x5a\xfa\x0f\xd2\x3f\x6a\xe9\x3f\x58\xff\xa8\xa5\xff\x38"
        "\xfa\x47\x2d\xfd\x87\xe8\x1f\xb5\xf4\x1f\xaa\x7f\xd4\xd2\x7f\x98\xfe"
        "\x51\x4b\xff\x71\xf5\x8f\x5a\xfa\x8f\xa7\x7f\xd4\xd2\x7f\x7c\xfd\xa3"
        "\x96\xfe\x13\xe8\x1f\xb5\xf4\x9f\x50\xff\xa8\xa5\xff\x44\xfa\x47\x2d"
        "\xfd\xdf\xa2\x7f\xd4\xd2\x7f\x62\xfd\xa3\x96\xfe\x93\xe8\x1f\xb5\xf4"
        "\x9f\x54\xff\xa8\xa5\xff\x64\xfa\x47\x2d\xfd\x27\xd7\x3f\x6a\xe9\x3f"
        "\x85\xfe\x51\x4b\xff\xb7\xea\x1f\xb5\xf4\x7f\x9b\xfe\x51\x4b\xff\x29"
        "\xf5\x8f\x5a\xfa\xbf\x5d\xff\xa8\xa5\xff\x54\xfa\x47\x2d\xfd\xdf\xa1"
        "\x7f\xd4\xd2\x7f\x6a\xfd\xa3\x96\xfe\xd3\xe8\x1f\xb5\xf4\x7f\xa7\xfe"
        "\x51\x4b\xff\x69\xf5\x8f\x5a\xfa\x4f\xa7\x7f\xd4\xd2\xff\x5d\xfa\x47"
        "\x2d\xfd\xa7\xd7\x3f\x6a\xe9\x3f\x83\xfe\x51\x4b\xff\x19\xf5\x8f\x5a"
        "\xfa\xcf\xa4\x7f\xd4\xd2\x7f\x66\xfd\xa3\x96\xfe\xb3\xe8\x1f\xb5\xf4"
        "\x7f\xb7\xfe\x51\x4b\xff\x59\xf5\x8f\x5a\xfa\xcf\xa6\x7f\xd4\xd2\xff"
        "\x3d\xfa\x47\x2d\xfd\xdf\xab\x7f\xd4\xd2\xff\x7d\xfa\x47\x2d\xfd\x67"
        "\xd7\x3f\x6a\xe9\x3f\x87\xfe\x51\x4b\xff\x39\xf5\x8f\x5a\xfa\xcf\xa5"
        "\x7f\xd4\xd2\x7f\x6e\xfd\xa3\x96\xfe\xf3\xe8\x1f\xb5\xf4\x9f\x57\xff"
        "\xa8\xa5\xff\x7c\xfa\x47\x2d\xfd\xdf\xaf\x7f\xd4\xd2\xff\x03\xfa\x47"
        "\x2d\xfd\x3f\xa8\x7f\xd4\xd2\x7f\x7e\xfd\xa3\x96\xfe\x0b\xe8\x1f\xb5"
        "\xf4\x5f\x50\xff\xa8\xa5\xff\x87\xf4\x8f\x5a\xfa\x2f\xa4\x7f\xd4\xd2"
        "\x7f\x61\xfd\xa3\x96\xfe\x1f\xd6\x3f\x6a\xe9\xff\x11\xfd\xa3\x96\xfe"
        "\x8b\xe8\x1f\xb5\xf4\x5f\x54\xff\xa8\xa5\xff\x62\xfa\x47\x2d\xfd\x17"
        "\xd7\x3f\x6a\xe9\xbf\x84\xfe\x51\x4b\xff\x25\xf5\x8f\x5a\xfa\x2f\xa5"
        "\x7f\xd4\xd2\x7f\x69\xfd\xa3\x96\xfe\xcb\xe8\x1f\xb5\xf4\x5f\x56\xff"
        "\xa8\xa5\xff\x72\xfa\x47\x2d\xfd\x3f\xaa\x7f\xd4\xd2\xff\x63\xfa\x47"
        "\x2d\xfd\x97\xd7\x3f\x6a\xe9\xff\x71\xfd\xa3\x96\xfe\x9f\xd0\x3f\x6a"
        "\xe9\xff\x49\xfd\xa3\x96\xfe\x9f\xd2\x3f\x6a\xe9\xbf\x82\xfe\x51\x4b"
        "\xff\x15\xf5\x8f\x5a\xfa\xaf\xa4\x7f\xd4\xd2\x7f\x65\xfd\xa3\x96\xfe"
        "\xab\xe8\x1f\xb5\xf4\xff\xb4\xfe\x51\x4b\xff\xcf\xe8\x1f\xb5\xf4\x5f"
        "\x55\xff\xa8\xa5\xff\x67\xf5\x8f\x5a\xfa\x7f\x4e\xff\xa8\xa5\xff\xe7"
        "\xf5\x8f\x5a\xfa\xaf\xa6\x7f\xd4\xd2\xff\x0b\xfa\x47\x2d\xfd\x57\xd7"
        "\x3f\x6a\xe9\xbf\x86\xfe\x51\x4b\xff\x35\xf5\x8f\x5a\xfa\xaf\xa5\x7f"
        "\xd4\xd2\x7f\x6d\xfd\xa3\x96\xfe\xeb\xe8\x1f\xb5\xf4\x5f\x57\xff\xa8"
        "\xa5\xff\x7a\xfa\x47\x2d\xfd\xd7\xd7\x3f\x6a\xe9\xbf\x81\xfe\x51\x4b"
        "\xff\x0d\xf5\x8f\x5a\xfa\x6f\xa4\x7f\xd4\xd2\xff\x8b\xfa\x47\x2d\xfd"
        "\x37\xd6\x3f\x6a\xe9\xbf\x89\xfe\x51\x4b\xff\x4d\xf5\x8f\x5a\xfa\x6f"
        "\xa6\x7f\xd4\xd2\x7f\x73\xfd\xa3\x96\xfe\x5b\xe8\x1f\xb5\xf4\xdf\x52"
        "\xff\xa8\xa5\xff\x56\xfa\x47\x2d\xfd\xb7\xd6\x3f\x6a\xe9\xbf\x8d\xfe"
        "\x51\x4b\xff\x6d\xf5\x8f\x5a\xfa\x6f\xa7\x7f\xd4\xd2\xff\x4b\xfa\x47"
        "\x2d\xfd\xb7\xd7\x3f\x6a\xe9\xbf\x83\xfe\x51\x4b\xff\x1d\xf5\x8f\x5a"
        "\xfa\xef\xa4\x7f\xd4\xd2\xff\xcb\xfa\x47\x2d\xfd\xbf\xa2\x7f\xd4\xd2"
        "\x7f\x67\xfd\xa3\x96\xfe\xbb\xe8\x1f\xb5\xf4\xdf\x55\xff\xa8\xa5\xff"
        "\x6e\xfa\x47\x2d\xfd\xbf\xaa\x7f\xd4\xd2\xff\x6b\xfa\x47\x2d\xfd\xbf"
        "\xae\x7f\xd4\xd2\xff\x1b\xfa\x47\x2d\xfd\xbf\xa9\x7f\xd4\xd2\x7f\x77"
        "\xfd\xa3\x96\xfe\xdf\xd2\x3f\x6a\xe9\xbf\x87\xfe\x51\x4b\xff\x3d\xf5"
        "\x8f\x5a\xfa\x7f\x5b\xff\xa8\xa5\xff\x5e\xfa\x47\x2d\xfd\xf7\xd6\x3f"
        "\x6a\xe9\xbf\x8f\xfe\x51\x4b\xff\xef\xe8\x1f\xb5\xf4\xdf\x57\xff\xa8"
        "\xa5\xff\x7e\xfa\x47\x2d\xfd\xbf\xab\x7f\xd4\xd2\xff\x7b\xfa\x47\x2d"
        "\xfd\xf7\xd7\x3f\x6a\xe9\xff\x7d\xfd\xa3\x96\xfe\x3f\xd0\x3f\x6a\xe9"
        "\xff\x43\xfd\xa3\x96\xfe\x07\xe8\x1f\xb5\xf4\xff\x91\xfe\x51\x4b\xff"
        "\x1f\xeb\x1f\xb5\xf4\x3f\x50\xff\xa8\xa5\xff\x41\xfa\x47\x2d\xfd\x0f"
        "\xd6\x3f\x6a\xe9\x7f\x88\xfe\x51\x4b\xff\x9f\xe8\x1f\xb5\xf4\x3f\x54"
        "\xff\xa8\xa5\xff\x61\xfa\x47\x2d\xfd\x0f\xd7\x3f\x6a\xe9\x7f\x84\xfe"
        "\x51\x4b\xff\x23\xf5\x8f\x5a\xfa\x1f\xa5\x7f\xd4\xd2\xff\xa7\xfa\x47"
        "\x2d\xfd\x7f\xa6\x7f\xd4\xd2\xff\x68\xfd\xa3\x96\xfe\x3f\xd7\x3f\x6a"
        "\xe9\x7f\x8c\xfe\x51\x4b\xff\x5f\xe8\x1f\xb5\xf4\xff\xa5\xfe\x51\x4b"
        "\xff\x63\xf5\x8f\x5a\xfa\xff\x4a\xff\xa8\xa5\xff\x71\xfa\x47\x2d\xfd"
        "\x8f\xd7\x3f\x6a\xe9\xff\x6b\xfd\xa3\x96\xfe\x27\xe8\x1f\xb5\xf4\xff"
        "\x8d\xfe\x51\x4b\xff\x13\xf5\x8f\x5a\xfa\x9f\xa4\x7f\xd4\xd2\xff\x64"
        "\xfd\xa3\x96\xfe\xbf\xd5\x3f\x6a\xe9\xff\x3b\xfd\xa3\x96\xfe\xbf\xd7"
        "\x3f\x6a\xe9\x7f\x8a\xfe\x51\x4b\xff\x3f\xe8\x1f\xb5\xf4\xff\xa3\xfe"
        "\x51\x4b\xff\x53\xf5\x8f\x5a\xfa\x9f\xa6\x7f\xd4\xd2\xff\x4f\xfa\x47"
        "\x2d\xfd\x4f\xd7\x3f\x6a\xe9\x7f\x86\xfe\x51\x4b\xff\x33\xf5\x8f\x5a"
        "\xfa\xff\x59\xff\xa8\xa5\xff\x59\xfa\x47\x2d\xfd\xcf\xd6\x3f\x6a\xe9"
        "\xff\x17\xfd\xa3\x96\xfe\x7f\xd5\x3f\x6a\xe9\x7f\x8e\xfe\x51\x4b\xff"
        "\x73\xf5\x8f\x5a\xfa\x9f\xa7\x7f\xd4\xd2\xff\x7c\xfd\xa3\x96\xfe\x17"
        "\xe8\x1f\xb5\xf4\xbf\x50\xff\xa8\xa5\xff\x45\xfa\x47\x2d\xfd\x2f\xd6"
        "\x3f\x6a\xe9\x7f\x89\xfe\x51\x4b\xff\x4b\xf5\x8f\x5a\xfa\x5f\xa6\x7f"
        "\xd4\xd2\xff\x72\xfd\xa3\x96\xfe\x57\xe8\x1f\xb5\xf4\xbf\x52\xff\xa8"
        "\xa5\xff\x55\xfa\x47\x2d\xfd\xaf\xd6\x3f\x6a\xe9\x7f\x8d\xfe\x51\x4b"
        "\xff\x6b\xf5\x8f\x5a\xfa\x5f\xa7\x7f\xd4\xd2\xff\x7a\xfd\xa3\x96\xfe"
        "\x37\xe8\x1f\xb5\xf4\xbf\x51\xff\xa8\xa5\xff\x4d\xfa\x47\x2d\xfd\x6f"
        "\xd6\x3f\x6a\xe9\x7f\x8b\xfe\x51\x4b\xff\x5b\xf5\x8f\x5a\xfa\xdf\xa6"
        "\x7f\xd4\xd2\xff\x76\xfd\xa3\x96\xfe\x77\xe8\x1f\xb5\xf4\xbf\x53\xff"
        "\xa8\xa5\xff\x5d\xfa\x47\x2d\xfd\xef\xd6\x3f\x6a\xe9\x7f\x8f\xfe\x51"
        "\x4b\xff\x7b\xf5\x8f\x5a\xfa\xdf\xa7\x7f\xd4\xd2\xff\x7e\xfd\xa3\x96"
        "\xfe\x0f\xe8\x1f\xb5\xf4\x7f\x50\xff\xa8\xa5\xff\x43\xfa\x47\x2d\xfd"
        "\x1f\xd6\x3f\x6a\xe9\xff\x88\xfe\x51\x4b\xff\x47\xf5\x8f\x5a\xfa\x3f"
        "\xa6\x7f\xd4\xd2\xff\x71\xfd\xa3\x96\xfe\x4f\xe8\x1f\xb5\xf4\x7f\x52"
        "\xff\xa8\xa5\xff\x53\xfa\x47\x2d\xfd\x9f\xd6\x3f\x6a\xe9\xff\x8c\xfe"
        "\x51\x4b\xff\x67\xf5\x8f\x5a\xfa\x3f\xa7\x7f\xd4\xd2\xff\x79\xfd\xa3"
        "\x96\xfe\x2f\xe8\x1f\xb5\xf4\x7f\x51\xff\xa8\xa5\xff\x4b\xfa\x47\x2d"
        "\xfd\x5f\xd6\x3f\x2a\xe9\x3f\xde\x80\xfe\x51\x4b\xff\x41\xfa\x47\x2d"
        "\xfd\x07\xeb\x1f\xb5\xf4\x1f\x47\xff\xa8\xa5\xff\x10\xfd\xa3\x96\xfe"
        "\x43\xf5\x8f\x5a\xfa\x0f\xd3\x3f\x6a\xe9\x3f\xae\xfe\x51\x4b\xff\xf1"
        "\xf4\x8f\x5a\xfa\x8f\xaf\x7f\xd4\xd2\x7f\x02\xfd\xa3\x96\xfe\x13\xea"
        "\x1f\xb5\xf4\x9f\x48\xff\xa8\xa5\xff\x5b\xf4\x8f\x5a\xfa\x4f\xac\x7f"
        "\xd4\xd2\x7f\x12\xfd\xa3\x96\xfe\x93\xea\x1f\xb5\xf4\x9f\x4c\xff\xa8"
        "\xa5\xff\xe4\xfa\x47\x2d\xfd\xa7\xd0\x3f\x6a\xe9\xff\x56\xfd\xa3\x96"
        "\xfe\x6f\xd3\x3f\x6a\xe9\x3f\xa5\xfe\x51\x4b\xff\xb7\xeb\x1f\xb5\xf4"
        "\x9f\x4a\xff\xa8\xa5\xff\x3b\xf4\x8f\x5a\xfa\x4f\xad\x7f\xd4\xd2\x7f"
        "\x1a\xfd\xa3\x96\xfe\xef\xd4\x3f\x6a\xe9\x3f\xad\xfe\x51\x4b\xff\xe9"
        "\xf4\x8f\x5a\xfa\xbf\x4b\xff\xa8\xa5\xff\xf4\xfa\x47\x2d\xfd\x67\xd0"
        "\x3f\x6a\xe9\x3f\xa3\xfe\x51\x4b\xff\x99\xf4\x8f\x5a\xfa\xcf\xac\x7f"
        "\xd4\xd2\x7f\x16\xfd\xa3\x96\xfe\xef\xd6\x3f\x6a\xe9\x3f\xab\xfe\x51"
        "\x4b\xff\xd9\xf4\x8f\x5a\xfa\xbf\x47\xff\xa8\xa5\xff\x7b\xf5\x8f\x5a"
        "\xfa\xbf\x4f\xff\xa8\xa5\xff\xec\xfa\x47\x2d\xfd\xe7\xd0\x3f\x6a\xe9"
        "\x3f\xa7\xfe\x51\x4b\xff\xb9\xf4\x8f\x5a\xfa\xcf\xad\x7f\xd4\xd2\x7f"
        "\x1e\xfd\xa3\x96\xfe\xf3\xea\x1f\xb5\xf4\x9f\x4f\xff\xa8\xa5\xff\xfb"
        "\xf5\x8f\x5a\xfa\x7f\x40\xff\xa8\xa5\xff\x07\xf5\x8f\x5a\xfa\xcf\xaf"
        "\x7f\xd4\xd2\x7f\x01\xfd\xa3\x96\xfe\x0b\xea\x1f\xb5\xf4\xff\x90\xfe"
        "\x51\x4b\xff\x85\xf4\x8f\x5a\xfa\x2f\xac\x7f\xd4\xd2\xff\xc3\xfa\x47"
        "\x2d\xfd\x3f\xa2\x7f\xd4\xd2\x7f\x11\xfd\xa3\x96\xfe\x8b\xea\x1f\xb5"
        "\xf4\x5f\x4c\xff\xa8\xa5\xff\xe2\xfa\x47\x2d\xfd\x97\xd0\x3f\x6a\xe9"
        "\xbf\xa4\xfe\x51\x4b\xff\xa5\xf4\x8f\x5a\xfa\x2f\xad\x7f\xd4\xd2\x7f"
        "\x19\xfd\xa3\x96\xfe\xcb\xea\x1f\xb5\xf4\x5f\x4e\xff\xa8\xa5\xff\x47"
        "\xf5\x8f\x5a\xfa\x7f\x4c\xff\xa8\xa5\xff\xf2\xfa\x47\x2d\xfd\x3f\xae"
        "\x7f\xd4\xd2\xff\x13\xfa\x47\x2d\xfd\x3f\xa9\x7f\xd4\xd2\xff\x53\xfa"
        "\x47\x2d\xfd\x57\xd0\x3f\x6a\xe9\xbf\xa2\xfe\x51\x4b\xff\x95\xf4\x8f"
        "\x5a\xfa\xaf\xac\x7f\xd4\xd2\x7f\x15\xfd\xa3\x96\xfe\x9f\xd6\x3f\x6a"
        "\xe9\xff\x19\xfd\xa3\x96\xfe\xab\xea\x1f\xb5\xf4\xff\xac\xfe\x51\x4b"
        "\xff\xcf\xe9\x1f\xb5\xf4\xff\xbc\xfe\x51\x4b\xff\xd5\xf4\x8f\x5a\xfa"
        "\x7f\x41\xff\xa8\xa5\xff\xea\xfa\x47\x2d\xfd\xd7\xd0\x3f\x6a\xe9\xbf"
        "\xa6\xfe\x51\x4b\xff\xb5\xf4\x8f\x5a\xfa\xaf\xad\x7f\xd4\xd2\x7f\x1d"
        "\xfd\xa3\x96\xfe\xeb\xea\x1f\xb5\xf4\x5f\x4f\xff\xa8\xa5\xff\xfa\xfa"
        "\x47\x2d\xfd\x37\xd0\x3f\x6a\xe9\xbf\xa1\xfe\x51\x4b\xff\x8d\xf4\x8f"
        "\x5a\xfa\x7f\x51\xff\xa8\xa5\xff\xc6\xfa\x47\x2d\xfd\x37\xd1\x3f\x6a"
        "\xe9\xbf\xa9\xfe\x51\x4b\xff\xcd\xf4\x8f\x5a\xfa\x6f\xae\x7f\xd4\xd2"
        "\x7f\x0b\xfd\xa3\x96\xfe\x5b\xea\x1f\xb5\xf4\xdf\x4a\xff\xa8\xa5\xff"
        "\xd6\xfa\x47\x2d\xfd\xb7\xd1\x3f\x6a\xe9\xbf\xad\xfe\x51\x4b\xff\xed"
        "\xf4\x8f\x5a\xfa\x7f\x49\xff\xa8\xa5\xff\xf6\xfa\x47\x2d\xfd\x77\xd0"
        "\x3f\x6a\xe9\xbf\xa3\xfe\x51\x4b\xff\x9d\xf4\x8f\x5a\xfa\x7f\x59\xff"
        "\xa8\xa5\xff\x57\xf4\x8f\x5a\xfa\xef\xac\x7f\xd4\xd2\x7f\x17\xfd\xa3"
        "\x96\xfe\xbb\xea\x1f\xb5\xf4\xdf\x4d\xff\xa8\xa5\xff\x57\xf5\x8f\x5a"
        "\xfa\x7f\x4d\xff\xa8\xa5\xff\xd7\xf5\x8f\x5a\xfa\x7f\x43\xff\xa8\xa5"
        "\xff\x37\xf5\x8f\x5a\xfa\xef\xae\x7f\xd4\xd2\xff\x5b\xfa\x47\x2d\xfd"
        "\xf7\xd0\x3f\x6a\xe9\xbf\xa7\xfe\x51\x4b\xff\x6f\xeb\x1f\xb5\xf4\xdf"
        "\x4b\xff\xa8\xa5\xff\xde\xfa\x47\x2d\xfd\xf7\xd1\x3f\x6a\xe9\xff\x1d"
        "\xfd\xa3\x96\xfe\xfb\xea\x1f\xb5\xf4\xdf\x4f\xff\xa8\xa5\xff\x77\xf5"
        "\x8f\x5a\xfa\x7f\x4f\xff\xa8\xa5\xff\xfe\xfa\x47\x2d\xfd\xbf\xaf\x7f"
        "\xd4\xd2\xff\x07\xfa\x47\x2d\xfd\x7f\xa8\x7f\xd4\xd2\xff\x00\xfd\xa3"
        "\x96\xfe\x3f\xd2\x3f\x6a\xe9\xff\x63\xfd\xa3\x96\xfe\x07\xea\x1f\xb5"
        "\xf4\x3f\x48\xff\xa8\xa5\xff\xc1\xfa\x47\x2d\xfd\x0f\xd1\x3f\x6a\xe9"
        "\xff\x13\xfd\xa3\x96\xfe\x87\x0e\x7b\xb3\x06\xf4\x9f\xad\xa5\xff\x61"
        "\xb6\xff\xa8\xa5\xff\xe1\xfa\x47\x2d\xfd\x8f\xd0\x3f\x6a\xe9\x7f\xa4"
        "\xfe\x51\x4b\xff\xa3\xf4\x8f\x5a\xfa\xff\x54\xff\xa8\xa5\xff\xcf\xf4"
        "\x8f\x5a\xfa\x1f\xad\x7f\xd4\xd2\xff\xe7\xfa\x47\x2d\xfd\x8f\xd1\x3f"
        "\x6a\xe9\xff\x0b\xfd\xa3\x96\xfe\xbf\xd4\x3f\x6a\xe9\x7f\xac\xfe\x51"
        "\x4b\xff\x5f\xe9\x1f\xb5\xf4\x3f\x4e\xff\xa8\xa5\xff\xf1\xfa\x47\x2d"
        "\xfd\x7f\xad\x7f\xd4\xd2\xff\x04\xfd\xa3\x96\xfe\xbf\xd1\x3f\x6a\xe9"
        "\x7f\xa2\xfe\x51\x4b\xff\x93\xf4\x8f\x5a\xfa\x9f\xac\x7f\xd4\xd2\xff"
        "\xb7\xfa\x47\x2d\xfd\x7f\xa7\x7f\xd4\xd2\xff\xf7\xfa\x47\x2d\xfd\x4f"
        "\xd1\x3f\x6a\xe9\xff\x07\xfd\xa3\x96\xfe\x7f\xd4\x3f\x6a\xe9\x7f\xaa"
        "\xfe\x51\x4b\xff\xd3\xf4\x8f\x5a\xfa\xff\x49\xff\xa8\xa5\xff\xe9\xfa"
        "\x47\x2d\xfd\xcf\xd0\x3f\x6a\xe9\x7f\xa6\xfe\x51\x4b\xff\x3f\xeb\x1f"
        "\xb5\xf4\x3f\x4b\xff\xa8\xa5\xff\xd9\xfa\x47\x2d\xfd\xff\xa2\x7f\xd4"
        "\xd2\xff\xaf\xfa\x47\x2d\xfd\xcf\xd1\x3f\x6a\xe9\x7f\xae\xfe\x51\x4b"
        "\xff\xf3\xf4\x8f\x5a\xfa\x9f\xaf\x7f\xd4\xd2\xff\x02\xfd\xa3\x96\xfe"
        "\x17\xea\x1f\xb5\xf4\xbf\x48\xff\xa8\xa5\xff\xc5\xfa\x47\x2d\xfd\x2f"
        "\xd1\x3f\x6a\xe9\x7f\xa9\xfe\x51\x4b\xff\xcb\xf4\x8f\x5a\xfa\x5f\xae"
        "\x7f\xd4\xd2\xff\x0a\xfd\xa3\x96\xfe\x57\xea\x1f\xb5\xf4\xbf\x4a\xff"
        "\xa8\xa5\xff\xd5\xfa\x47\x2d\xfd\xaf\xd1\x3f\x6a\xe9\x7f\xad\xfe\x51"
        "\x4b\xff\xeb\xf4\x8f\xfe\xf7\xfa\x0f\x19\x48\xfd\xaf\xd7\x3f\xfa\xdf"
        "\xeb\x9f\xb7\xff\x1b\xf4\x8f\x5a\xfa\xdf\xa8\x7f\xd4\xd2\xff\x26\xfd"
        "\xa3\x96\xfe\x37\xeb\x1f\xb5\xf4\xbf\x45\xff\xa8\xa5\xff\xad\xfa\x47"
        "\x2d\xfd\x6f\xd3\x3f\x6a\xe9\x7f\xbb\xfe\x51\x4b\xff\x3b\xf4\x8f\x5a"
        "\xfa\xdf\xa9\x7f\xd4\xd2\xff\x2e\xfd\xa3\x96\xfe\x77\xeb\x1f\xb5\xf4"
        "\xbf\x47\xff\xa8\xa5\xff\xbd\xfa\x47\x2d\xfd\xef\xd3\x3f\x6a\xe9\x7f"
        "\xbf\xfe\x51\x4b\xff\x07\xf4\x8f\x5a\xfa\x3f\xa8\x7f\xd4\xd2\xff\x21"
        "\xfd\xa3\x96\xfe\x0f\xeb\x1f\xb5\xf4\x7f\x44\xff\xa8\xa5\xff\xa3\xfa"
        "\x47\x2d\xfd\x1f\xd3\x3f\x6a\xe9\xff\xb8\xfe\x51\x4b\xff\x27\xf4\x8f"
        "\x5a\xfa\x3f\xa9\x7f\xd4\xd2\xff\x29\xfd\xa3\x96\xfe\x4f\xeb\x1f\xb5"
        "\xf4\x7f\x46\xff\xa8\xa5\xff\xb3\xfa\x47\x2d\xfd\x9f\xd3\x3f\x6a\xe9"
        "\xff\xbc\xfe\x51\x4b\xff\x17\xf4\x8f\x5a\xfa\xbf\xa8\x7f\xd4\xd2\xff"
        "\x25\xfd\xa3\x96\xfe\x2f\xeb\x1f\x95\xf4\x1f\x7f\x40\xff\xa8\xa5\xff"
        "\x20\xfd\xa3\x96\xfe\x83\xf5\x8f\x5a\xfa\x8f\xa3\x7f\xd4\xd2\x7f\x88"
        "\xfe\x51\x4b\xff\xa1\xfa\x47\x2d\xfd\x87\xe9\x1f\xb5\xf4\x1f\x57\xff"
        "\xa8\xa5\xff\x78\xfa\x47\x2d\xfd\xc7\xd7\x3f\x6a\xe9\x3f\x81\xfe\x51"
        "\x4b\xff\x09\xf5\x8f\x5a\xfa\x4f\xa4\x7f\xd4\xd2\xff\x2d\xfa\x47\x2d"
        "\xfd\x27\xd6\x3f\x6a\xe9\x3f\x89\xfe\x51\x4b\xff\x49\xf5\x8f\x5a\xfa"
        "\x4f\xa6\x7f\xd4\xd2\x7f\x72\xfd\xa3\x96\xfe\x53\xe8\x1f\xb5\xf4\x7f"
        "\xab\xfe\x51\x4b\xff\xb7\xe9\x1f\xb5\xf4\x9f\x52\xff\xa8\xa5\xff\xdb"
        "\xf5\x8f\x5a\xfa\x4f\xa5\x7f\xd4\xd2\xff\x1d\xfa\x47\x2d\xfd\xa7\xd6"
        "\x3f\x6a\xe9\x3f\x8d\xfe\x51\x4b\xff\x77\x8e\xbd\xff\x2e\xff\x27\xe3"
        "\xfa\x0f\xd5\xd2\x7f\x5a\xdb\x7f\xd4\xd2\x7f\x3a\xfd\xa3\x96\xfe\xef"
        "\xd2\x3f\x6a\xe9\x3f\xbd\xfe\x51\x4b\xff\x19\xf4\x8f\x5a\xfa\xcf\xa8"
        "\x7f\xd4\xd2\x7f\x26\xfd\xa3\x96\xfe\x33\xeb\x1f\xb5\xf4\x9f\x45\xff"
        "\xa8\xa5\xff\xbb\xf5\x8f\x5a\xfa\xcf\xaa\x7f\xd4\xd2\x7f\x36\xfd\xa3"
        "\x96\xfe\xef\xd1\x3f\x6a\xe9\xff\x5e\xfd\xa3\x96\xfe\xef\xd3\x3f\x6a"
        "\xe9\x3f\xbb\xfe\x51\x4b\xff\x39\xf4\x8f\x5a\xfa\xcf\xa9\x7f\xd4\xd2"
        "\x7f\x2e\xfd\xa3\xff\xb9\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xff\x8f\x1d\x38\x10\x00\x00"
        "\x00\x00\x00\xf2\x7f\x6d\x84\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\x2a\xec\xc0\x81\x00\x00\x00\x00\x00\x90\xff\x6b"
        "\x23\x54\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55\x55"
        "\x61\x07\x0e\x04\x00\x00\x00\x00\x80\xfc\x5f\x1b\xa1\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
        "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa\x0a\x3b\x70\x40\x02\x00"
        "\x00\x00\x20\xe8\xff\xeb\x76\x04\x0a\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x70\x53\x00\x00\x00\xff"
        "\xff\x43\x44\x0a\xd9",
        47197);
    syz_mount_image(0x20000080, 0x20000000, 0x20801a, 0x20000140, -1, 0xb85d,
                    0x20017140);
    break;
  case 1:
    memcpy((void*)0x20000040, ".log\000", 5);
    res = syscall(__NR_openat, 0xffffff9c, 0x20000040ul, 0xa0842ul, 0ul);
    if (res != -1)
      r[0] = res;
    break;
  case 2:
    memcpy((void*)0x20000000, "cdg\000", 4);
    syscall(__NR_write, r[0], 0x20000000ul, 0x1400ul);
    {
      int i;
      for (i = 0; i < 32; i++) {
        syscall(__NR_write, r[0], 0x20000000ul, 0x1400ul);
      }
    }
    break;
  case 3:
    memcpy((void*)0x20000040, ".log\000", 5);
    res = syscall(__NR_openat, 0xffffff9c, 0x20000040ul, 0x147442ul, 0x100ul);
    if (res != -1)
      r[1] = res;
    break;
  case 4:
    memcpy((void*)0x20000000, "cdg\000", 4);
    syscall(__NR_write, r[1], 0x20000000ul, 0x1400ul);
    break;
  }
}
int main(void)
{
  syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  use_temporary_dir();
  loop();
  return 0;
}

--5DqPYnvrX9NSYHIs
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kconfig"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 5.18.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10)"
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
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=122
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
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
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
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
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

CONFIG_BUILD_BIN2C=y
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
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
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
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
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
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
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

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
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
CONFIG_ARCH_NR_GPIO=1024
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
CONFIG_RETPOLINE=y
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
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
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
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_USER_INTERRUPTS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_X86_USER_SHADOW_STACK=y
CONFIG_INTEL_TDX_HOST=y
# CONFIG_INTEL_TDX_HOST_DEBUG is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
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
# CONFIG_LEGACY_VSYSCALL_EMULATE is not set
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
CONFIG_PMIC_OPREGION=y
# CONFIG_BYTCRC_PMIC_OPREGION is not set
# CONFIG_CHTCRC_PMIC_OPREGION is not set
# CONFIG_XPOWER_PMIC_OPREGION is not set
CONFIG_BXT_WC_PMIC_OPREGION=y
# CONFIG_CHT_DC_TI_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

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
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
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
# CONFIG_KVM_XEN is not set
CONFIG_KVM_EXTERNAL_WRITE_TRACKING=y
CONFIG_KVM_MMU_PRIVATE=y
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
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
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
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
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

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
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
# CONFIG_SVOS is not set
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
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
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
CONFIG_ZSWAP=y
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
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
# CONFIG_DEVMAP_ACCESS_PROTECTION is not set
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_ARCH_HAS_SUPERVISOR_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_MEMFILE_NOTIFIER=y

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
CONFIG_NFT_OBJREF=m
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

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=m
# end of DECnet: Netfilter Configuration

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
CONFIG_NET_DSA_TAG_LAN9303=m
# CONFIG_NET_DSA_TAG_SJA1105 is not set
CONFIG_NET_DSA_TAG_TRAILER=m
# CONFIG_NET_DSA_TAG_XRS700X is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=m
# CONFIG_DECNET_ROUTER is not set
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

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_FLEXCAN is not set
# CONFIG_CAN_GRCAN is not set
CONFIG_CAN_JANZ_ICAN3=m
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
CONFIG_CAN_CC770_PLATFORM=m
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
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_ETAS_ES58X is not set
CONFIG_CAN_GS_USB=m
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_MCBA_USB=m
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

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
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
# CONFIG_PCI_PF_STUB is not set
CONFIG_XEN_PCIDEV_FRONTEND=m
CONFIG_PCI_ATS=y
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
CONFIG_CXL_REGION=m
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
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
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
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_TEST=m
CONFIG_APPLE_PROPERTIES=y
CONFIG_RESET_ATTACK_MITIGATION=y
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

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
CONFIG_BLK_DEV_FD=m
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
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_DRBD=m
# CONFIG_DRBD_FAULT_INJECTION is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_SX8=m
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
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_FC=y
CONFIG_NVME_TARGET_FCLOOP=y
CONFIG_NVME_TARGET_TCP=y
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
# CONFIG_INTEL_MEI_VIRTIO is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_BUS_DMA_TEST is not set
CONFIG_INTEL_MEI_HDCP=m
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_INTEL_MEI_GSC_PROXY=m
CONFIG_INTEL_MEI_IAF=m
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
CONFIG_SCSI_DPT_I2O=m
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
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
CONFIG_SCSI_UFS_DWC_TC_PCI=m
CONFIG_SCSI_UFSHCD_PLATFORM=m
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
CONFIG_SCSI_UFS_BSG=y
CONFIG_SCSI_UFS_CRYPTO=y
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_HWMON is not set
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
CONFIG_PATA_PLATFORM=m
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
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_NICSTAR=m
# CONFIG_ATM_NICSTAR_USE_SUNI is not set
# CONFIG_ATM_NICSTAR_USE_IDT77105 is not set
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
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
# CONFIG_NET_DSA_MICROCHIP_KSZ9477 is not set
# CONFIG_NET_DSA_MICROCHIP_KSZ8795 is not set
CONFIG_NET_DSA_MV88E6XXX=m
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
# CONFIG_NET_DSA_MSCC_SEVILLE is not set
# CONFIG_NET_DSA_AR9331 is not set
# CONFIG_NET_DSA_SJA1105 is not set
# CONFIG_NET_DSA_XRS700X_I2C is not set
# CONFIG_NET_DSA_XRS700X_MDIO is not set
CONFIG_NET_DSA_QCA8K=m
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
CONFIG_DE4X5=m
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
CONFIG_JME=m
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
CONFIG_MLX5_CORE=m
CONFIG_MLX5_ACCEL=y
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
# CONFIG_MLX5_FPGA_IPSEC is not set
# CONFIG_MLX5_IPSEC is not set
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
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
CONFIG_FEALNX=m
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=m
CONFIG_NS83820=m
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=m
CONFIG_VXGE=m
# CONFIG_VXGE_DEBUG_TRACE_ALL is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
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
CONFIG_VITESSE_PHY=m
CONFIG_XILINX_GMII2RGMII=m
CONFIG_MICREL_KS8995MA=m
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
# CONFIG_USB_RTL8153_ECM is not set
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

# CONFIG_IWLMEI is not set
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
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WILC1000=m
CONFIG_WILC1000_SDIO=m
CONFIG_WILC1000_SPI=m
CONFIG_WILC1000_HW_OOB_INTR=y
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
CONFIG_WILINK_PLATFORM_DATA=y
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
CONFIG_LANMEDIA=m
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
CONFIG_IEEE802154_AT86RF230_DEBUGFS=y
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
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
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
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
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
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
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
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=m
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=m
# CONFIG_SPI_SIFIVE is not set
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
# CONFIG_PINCTRL_INTEL_PLATFORM is not set
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
CONFIG_PINCTRL_METEORPOINT=m
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
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
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
CONFIG_GPIO_ADP5588=m
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
CONFIG_SENSORS_ADM1021=m
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
CONFIG_SENSORS_ASPEED=m
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
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
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
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
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
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
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
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
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
# CONFIG_SENSORS_ASUS_WMI_EC is not set
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
CONFIG_INTEL_TCC_LIB=m
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
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_EBC_C384_WDT=m
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
CONFIG_HTC_I2CPLD=y
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
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_UCB1400_CORE=m
CONFIG_MFD_RDC321X=m
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=m
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=m
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
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
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_SY7636A is not set
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
CONFIG_VIDEO_CPIA2=m
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
CONFIG_USB_STKWEBCAM=m
CONFIG_VIDEO_USBTV=m
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_ZR364XX=m

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
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

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
CONFIG_VIDEO_MEYE=m
CONFIG_VIDEO_SOLO6X10=m
CONFIG_VIDEO_TW5864=m
CONFIG_VIDEO_TW68=m
CONFIG_VIDEO_TW686X=m

#
# Media capture/analog TV support
#
CONFIG_VIDEO_DT3155=m
CONFIG_VIDEO_IVTV=m
CONFIG_VIDEO_IVTV_ALSA=m
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
CONFIG_VIDEO_HEXIUM_GEMINI=m
CONFIG_VIDEO_HEXIUM_ORION=m
CONFIG_VIDEO_MXB=m

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
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_VIDEO_IPU3_CIO2=m
# CONFIG_CIO2_BRIDGE is not set
CONFIG_RADIO_ADAPTERS=y
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
CONFIG_VIDEO_ASPEED=m

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
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
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
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=m
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
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
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_SR030PC30 is not set
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
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_DP_HELPER=y
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_CMA_HELPER=m
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
# CONFIG_DRM_AMD_DC_HDCP is not set
# CONFIG_DRM_AMD_DC_SI is not set
# CONFIG_DEBUG_KERNEL_DC is not set
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
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
# CONFIG_DRM_VMWGFX_MKSSTATS is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_USE_LVDS is not set
# CONFIG_DRM_RCAR_MIPI_DSI is not set
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
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
# CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
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
# CONFIG_DRM_MXSFB is not set
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
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
CONFIG_FB_BOOT_VESA_SUPPORT=y
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
CONFIG_LOGO_LINUX_NEXT_CLUT224=y
# end of Graphics support

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
# CONFIG_SND_DEBUG is not set
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
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
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
# CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=m
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=m
CONFIG_SND_SOC_SOF_INTEL_COMMON=m
CONFIG_SND_SOC_SOF_BAYTRAIL=m
CONFIG_SND_SOC_SOF_BROADWELL=m
CONFIG_SND_SOC_SOF_MERRIFIELD=m
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
CONFIG_SND_SOC_SOF_HDA_COMMON=m
CONFIG_SND_SOC_SOF_HDA_LINK=y
CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=y
CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_HDA=m
CONFIG_SND_SOC_SOF_HDA_PROBES=y
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
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
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
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_HDAC_HDMI=m
CONFIG_SND_SOC_HDAC_HDA=m
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
CONFIG_SND_SOC_WM8731=m
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
CONFIG_SND_SOC_WM8960=m
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
# CONFIG_SND_SOC_WSA881X is not set
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
CONFIG_USB_FOTG210_HCD=m
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
CONFIG_USB_FOTG210_UDC=m
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
CONFIG_TYPEC_CCG_HPI=m
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
# CONFIG_TYPEC_RT1711H is not set
# CONFIG_TYPEC_TCPCI_MAXIM is not set
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_WCOVE=m
CONFIG_TYPEC_UCSI=m
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=m
CONFIG_TYPEC_TPS6598X=m
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_HD3SS3220 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
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
# CONFIG_MMC_SDHCI_OF_ASPEED is not set
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
CONFIG_LEDS_CLEVO_MAIL=m
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
CONFIG_INFINIBAND_MTHCA=m
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
CONFIG_INFINIBAND_QIB=m
CONFIG_INFINIBAND_QIB_DCA=y
CONFIG_INFINIBAND_CXGB4=m
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_IRDMA is not set
CONFIG_MLX4_INFINIBAND=m
CONFIG_MLX5_INFINIBAND=m
CONFIG_INFINIBAND_OCRDMA=m
CONFIG_INFINIBAND_VMWARE_PVRDMA=m
CONFIG_INFINIBAND_USNIC=m
CONFIG_INFINIBAND_BNXT_RE=m
CONFIG_INFINIBAND_HFI1=m
# CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
# CONFIG_SDMA_VERBOSITY is not set
CONFIG_INFINIBAND_QEDR=m
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
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
CONFIG_EDAC_I10NM=m
CONFIG_EDAC_PND2=m
CONFIG_EDAC_IGEN6=m
CONFIG_EDAC_IEH=m
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
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
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
CONFIG_VIRTIO=y
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
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
# Capacitance to digital converters
#
CONFIG_AD7746=m
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
# CONFIG_VIDEO_MAX96712 is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_IPU3_IMGU is not set
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_SP8870=m
# CONFIG_STAGING_BOARD is not set
CONFIG_LTE_GDM724X=m
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
CONFIG_UNISYSSPAR=y
CONFIG_UNISYS_VISORNIC=m
CONFIG_UNISYS_VISORINPUT=m
CONFIG_UNISYS_VISORHBA=m
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
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
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
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
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
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
CONFIG_INTEL_PMT_WATCHER=m

#
# Intel PnP excursion monitor
#
CONFIG_INTEL_TPMI_PEM=m
# end of Intel PnP excursion monitor

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_TPMI=m
CONFIG_INTEL_SPEED_SELECT_INTERFACE=m
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_TELEMETRY is not set
CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL_TPMI=m
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
CONFIG_INTEL_HPM_DIE_MAP=m
CONFIG_INTEL_TPMI=m
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
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
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
CONFIG_CROS_USBPD_NOTIFY=m
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
# CONFIG_WILCO_EC is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE3_WMI=m
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
CONFIG_SURFACE_PRO3_BUTTON=m
# CONFIG_SURFACE_AGGREGATOR is not set
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
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=m
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
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
CONFIG_VFIO_CONTAINER=n
CONFIG_IOMMUFD=y
CONFIG_IOMMUFD_TEST=y
CONFIG_IOMMUFD_VFIO_CONTAINER=y
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
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_STX104=m
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
# CONFIG_AD74413R is not set
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
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=m
CONFIG_VME_TSI148=m
CONFIG_VME_FAKE=m

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=m

#
# VME Device Drivers
#
CONFIG_VME_USER=m
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL_TCB is not set
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

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_TI_SYSCON=m

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
# CONFIG_INTEL_RAPL_TPMI is not set
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
# CONFIG_ANDROID is not set
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
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_RAVE_SP_EEPROM is not set
# CONFIG_NVMEM_RMEM is not set

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
# CONFIG_FSI is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
CONFIG_UNISYS_VISORBUS=m
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
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
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
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
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
CONFIG_NFSD_V2_ACL=y
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
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_INFINIBAND=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=0
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_FORTIFY_SOURCE is not set
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
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
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
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
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
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_ENGINE=m

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
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=m
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
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
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
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
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM3=m
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
CONFIG_ZSTD_COMPRESS=m
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
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
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
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
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
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
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
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_TEST=m
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
# CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
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
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
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
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=140
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_WQ_WATCHDOG is not set
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
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_SCF_TORTURE_TEST=m
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
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=100
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_LATENCYTOP is not set
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
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
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
# CONFIG_PROFILE_ALL_BRANCHES is not set
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
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
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
# CONFIG_UNWINDER_GUESS is not set
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
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# CONFIG_HYPERV_TESTING is not set
# CONFIG_PKS_TEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--5DqPYnvrX9NSYHIs
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment;
	filename="4ec5183ec48656cec489c49f989c508b68b518e3_dmesg.log"
Content-Transfer-Encoding: quoted-printable

=1Bc=1B[?7l=1B[2J=1B[0mSeaBIOS (version rel-1.16.0-0-gd239552ce722-prebuilt=
.qemu.org)=0D


iPXE (http://ipxe.org) 00:03.0 CA00 PCI2.10 PnP PMM+7FF91000+7FEF1000 CA00=
=0D
Press Ctrl-B to configure iPXE (PCI 00:03.0)...=0D                         =
                                                      =0D


Booting from ROM..=1Bc=1B[?7l=1B[2J[    0.000000] Linux version 6.2.0-rc7-4=
ec5183ec486 (root@984fee00a1f6.jf.intel.com) (gcc (GCC) 8.5.0 20210514 (Red=
 Hat 8.5.0-18), GNU ld version 2.36.1-3.el8) #1 SMP PREEMPT_DYNAMIC Sun Feb=
  5 18:22:49 PST 2023=0D
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
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'=
=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x20000: 'AMX Tile config'=
=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x40000: 'AMX Tile data'=
=0D
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256=0D
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64=0D
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512=0D
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024=0D
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8=0D
[    0.000000] x86/fpu: xstate_offset[17]: 2496, xstate_sizes[17]:   64=0D
[    0.000000] x86/fpu: xstate_offset[18]: 2560, xstate_sizes[18]: 8192=0D
[    0.000000] x86/fpu: Enabled xstate features 0x602e7, context size is 10=
752 bytes, using 'compacted' format.=0D
[    0.000000] signal: max sigframe size: 11952=0D
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
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0=
-0-gd239552ce722-prebuilt.qemu.org 04/01/2014=0D
[    0.000000] Hypervisor detected: KVM=0D
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00=0D
[    0.000005] kvm-clock: using sched offset of 628079799 cycles=0D
[    0.000470] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles:=
 0x1cd42e4dffb, max_idle_ns: 881590591483 ns=0D
[    0.001892] tsc: Detected 1700.000 MHz processor=0D
[    0.011553] last_pfn =3D 0x7ffe0 max_arch_pfn =3D 0x10000000000=0D
[    0.012086] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
  =0D
[    0.019124] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]=0D
[    0.019695] Using GB pages for direct mapping=0D
[    0.021655] ACPI: Early table checksum verification disabled=0D
[    0.022159] ACPI: RSDP 0x00000000000F59C0 000014 (v00 BOCHS )=0D
[    0.022689] ACPI: RSDT 0x000000007FFE1951 000034 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.023466] ACPI: FACP 0x000000007FFE17FD 000074 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.024239] ACPI: DSDT 0x000000007FFE0040 0017BD (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.025003] ACPI: FACS 0x000000007FFE0000 000040=0D
[    0.025434] ACPI: APIC 0x000000007FFE1871 000080 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.026201] ACPI: HPET 0x000000007FFE18F1 000038 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.026970] ACPI: WAET 0x000000007FFE1929 000028 (v01 BOCHS  BXPC     00=
000001 BXPC 00000001)=0D
[    0.027735] ACPI: Reserving FACP table memory at [mem 0x7ffe17fd-0x7ffe1=
870]=0D
[    0.028356] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe1=
7fc]=0D
[    0.028978] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe0=
03f]=0D
[    0.029600] ACPI: Reserving APIC table memory at [mem 0x7ffe1871-0x7ffe1=
8f0]=0D
[    0.030218] ACPI: Reserving HPET table memory at [mem 0x7ffe18f1-0x7ffe1=
928]=0D
[    0.030836] ACPI: Reserving WAET table memory at [mem 0x7ffe1929-0x7ffe1=
950]=0D
[    0.032629] No NUMA configuration found=0D
[    0.032966] Faking a node at [mem 0x0000000000000000-0x000000007ffdffff]=
=0D
[    0.033643] NODE_DATA(0) allocated [mem 0x7ffb5000-0x7ffdffff]=0D
[    0.045864] Zone ranges:=0D
[    0.046115]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]=0D
[    0.046668]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]=0D
[    0.047215]   Normal   empty=0D
[    0.047479]   Device   empty=0D
[    0.047739] Movable zone start for each node=0D
[    0.048115] Early memory node ranges=0D
[    0.048437]   node   0: [mem 0x0000000000001000-0x000000000009efff]=0D
[    0.048988]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]=0D
[    0.049549] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdf=
fff]=0D
[    0.050182] On node 0, zone DMA: 1 pages in unavailable ranges=0D
[    0.050306] On node 0, zone DMA: 97 pages in unavailable ranges=0D
[    0.063631] On node 0, zone DMA32: 32 pages in unavailable ranges=0D
[    0.127796] kasan: KernelAddressSanitizer initialized=0D
[    0.129045] ACPI: PM-Timer IO Port: 0x608=0D
[    0.129433] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])=0D
[    0.130006] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23=0D
[    0.130631] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)=0D
[    0.131194] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)=
=0D
[    0.131777] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)=
=0D
[    0.132365] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level=
)=0D
[    0.132960] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level=
)=0D
[    0.133579] ACPI: Using ACPI (MADT) for SMP configuration information=0D
[    0.134141] ACPI: HPET id: 0x8086a201 base: 0xfed00000=0D
[    0.134607] TSC deadline timer available=0D
[    0.134953] smpboot: Allowing 2 CPUs, 0 hotplug CPUs=0D
[    0.135442] kvm-guest: KVM setup pv remote TLB flush=0D
[    0.135886] kvm-guest: setup PV sched yield=0D
[    0.136316] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]=0D
[    0.136986] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x0009ffff]=0D
[    0.137653] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000effff]=0D
[    0.138313] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0=
x000fffff]=0D
[    0.138981] [mem 0x80000000-0xfeffbfff] available for PCI devices=0D
[    0.139520] Booting paravirtualized kernel on KVM=0D
[    0.139936] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns=0D
[    0.140868] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr=
_node_ids:1=0D
[    0.142185] percpu: Embedded 80 pages/cpu s290816 r8192 d28672 u1048576=
=0D
[    0.143051] kvm-guest: PV spinlocks enabled=0D
[    0.143443] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, =
linear)=0D
[    0.144114] Fallback order for Node 0: 0 =0D
[    0.144500] Built 1 zonelists, mobility grouping on.  Total pages: 51580=
8=0D
[    0.145103] Policy zone: DMA32=0D
[    0.145382] Kernel command line: net.ifnames=3D0 console=3DttyS0 root=3D=
/dev/sda earlyprintk=3Dserial net.ifnames=3D0=0D
[    0.146753] random: crng init done=0D
[    0.147580] Dentry cache hash table entries: 262144 (order: 9, 2097152 b=
ytes, linear)=0D
[    0.148742] Inode-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, linear)=0D
[    0.149951] mem auto-init: stack:off, heap alloc:off, heap free:off=0D
[    0.152540] stackdepot hash table entries: 1048576 (order: 11, 8388608 b=
ytes, linear)=0D
[    0.195574] Memory: 1629844K/2096632K available (71680K kernel code, 140=
07K rwdata, 16476K rodata, 14104K init, 20784K bss, 466588K reserved, 0K cm=
a-reserved)=0D
[    0.197641] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1=0D
[    0.198201] kmemleak: Kernel memory leak detector disabled=0D
[    0.198792] ftrace: allocating 68501 entries in 268 pages=0D
[    0.232852] ftrace: allocated 268 pages with 3 groups=0D
[    0.238679] Dynamic Preempt: voluntary=0D
[    0.239334] Running RCU self tests=0D
[    0.239639] rcu: Preemptible hierarchical RCU implementation.=0D
[    0.240124] rcu: 	RCU lockdep checking is enabled.=0D
[    0.240532] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D2.=0D
[    0.241108] 	Trampoline variant of Tasks RCU enabled.=0D
[    0.241538] 	Rude variant of Tasks RCU enabled.=0D
[    0.241921] 	Tracing variant of Tasks RCU enabled.=0D
[    0.242326] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.=0D
[    0.242967] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2=0D
[    0.292027] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16=0D
[    0.293018] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.=0D
[    0.301628] Console: colour VGA+ 80x25=0D
[    0.302022] printk: console [ttyS0] enabled=0D
[    0.302022] printk: console [ttyS0] enabled=0D
[    0.302760] printk: bootconsole [earlyser0] disabled=0D
[    0.302760] printk: bootconsole [earlyser0] disabled=0D
[    0.303635] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar=0D
[    0.304313] ... MAX_LOCKDEP_SUBCLASSES:  8=0D
[    0.304683] ... MAX_LOCK_DEPTH:          48=0D
[    0.305058] ... MAX_LOCKDEP_KEYS:        8192=0D
[    0.305454] ... CLASSHASH_SIZE:          4096=0D
[    0.305843] ... MAX_LOCKDEP_ENTRIES:     32768=0D
[    0.306242] ... MAX_LOCKDEP_CHAINS:      65536=0D
[    0.306643] ... CHAINHASH_SIZE:          32768=0D
[    0.307041]  memory used by lock dependency info: 6365 kB=0D
[    0.307522]  memory used for stack traces: 4224 kB=0D
[    0.307951]  per task-struct memory footprint: 1920 bytes=0D
[    0.308521] ACPI: Core revision 20221020=0D
[    0.309328] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 19112604467 ns=0D
[    0.310305] APIC: Switch to symmetric I/O mode setup=0D
[    0.310956] x2apic enabled=0D
[    0.311407] Switched APIC routing to physical x2apic.=0D
[    0.311857] kvm-guest: setup PV IPIs=0D
[    0.313328] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1=0D
[    0.313892] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x1881273ac8e, max_idle_ns: 440795257284 ns=0D
[    0.314895] Calibrating delay loop (skipped) preset value.. 3400.00 Bogo=
MIPS (lpj=3D6800000)=0D
[    0.315627] pid_max: default: 32768 minimum: 301=0D
[    0.316224] LSM: initializing lsm=3Dcapability,yama,integrity=0D
[    0.316747] Yama: becoming mindful.=0D
[    0.317384] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes,=
 linear)=0D
[    0.318045] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 b=
ytes, linear)=0D
[    0.320714] CPU0: Thermal monitoring enabled (TM1)=0D
[    0.321225] x86/cpu: User Mode Instruction Prevention (UMIP) activated=
=0D
[    0.322040] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0=0D
[    0.322886] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0=0D
[    0.323436] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization=0D
[    0.324186] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
[    0.325165] Spectre V2 : Mitigation: Enhanced IBRS=0D
[    0.325565] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch=0D
[    0.326243] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT=0D
[    0.326886] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier=0D
[    0.327579] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl=0D
[    0.328281] MMIO Stale Data: Unknown: No mitigations=0D
[    0.472680] Freeing SMP alternatives memory: 56K=0D
[    0.473509] smpboot: CPU0: Intel(R) Xeon(R) Gold 6414TDX (family: 0x6, m=
odel: 0x8f, stepping: 0x6)=0D
[    0.474876] cblist_init_generic: Setting adjustable number of callback q=
ueues.=0D
[    0.474876] cblist_init_generic: Setting shift to 1 and lim to 1.=0D
[    0.474876] cblist_init_generic: Setting shift to 1 and lim to 1.=0D
[    0.474876] cblist_init_generic: Setting shift to 1 and lim to 1.=0D
[    0.474959] Running RCU-tasks wait API self tests=0D
[    0.579013] Performance Events: Sapphire Rapids events, full-width count=
ers, Intel PMU driver.=0D
[    0.579869] ... version:                2=0D
[    0.580212] ... bit width:              48=0D
[    0.580552] ... generic registers:      8=0D
[    0.580886] ... value mask:             0000ffffffffffff=0D
[    0.581326] ... max period:             00007fffffffffff=0D
[    0.581763] ... fixed-purpose events:   3=0D
[    0.582100] ... event mask:             00000007000000ff=0D
[    0.583082] rcu: Hierarchical SRCU implementation.=0D
[    0.583485] rcu: 	Max phase no-delay instances is 1000.=0D
[    0.586841] smp: Bringing up secondary CPUs ...=0D
[    0.587543] x86: Booting SMP configuration:=0D
[    0.587913] .... node  #0, CPUs:      #1=0D
[    0.588401] smp: Brought up 1 node, 2 CPUs=0D
[    0.588401] smpboot: Max logical packages: 1=0D
[    0.588401] smpboot: Total of 2 processors activated (6800.00 BogoMIPS)=
=0D
[    0.591912] devtmpfs: initialized=0D
[    0.591912] x86/mm: Memory block size: 128MB=0D
[    0.599970] Callback from call_rcu_tasks_trace() invoked.=0D
[    0.600811] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns=0D
[    0.600811] futex hash table entries: 512 (order: 4, 65536 bytes, linear=
)=0D
[    0.603268] pinctrl core: initialized pinctrl subsystem=0D
[    0.604775] =0D
[    0.604912] ************************************************************=
*=0D
[    0.605472] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    *=
*=0D
[    0.606032] **                                                         *=
*=0D
[    0.606590] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  *=
*=0D
[    0.606891] **                                                         *=
*=0D
[    0.607448] ** This means that this kernel is built to expose internal *=
*=0D
[    0.608002] ** IOMMU data structures, which may compromise security on *=
*=0D
[    0.608560] ** your system.                                            *=
*=0D
[    0.609114] **                                                         *=
*=0D
[    0.609673] ** If you see this message and you are not debugging the   *=
*=0D
[    0.610230] ** kernel, report this immediately to your vendor!         *=
*=0D
[    0.610789] **                                                         *=
*=0D
[    0.610882] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    *=
*=0D
[    0.611437] ************************************************************=
*=0D
[    0.612051] PM: RTC time: 01:51:51, date: 2023-02-08=0D
[    0.615837] NET: Registered PF_NETLINK/PF_ROUTE protocol family=0D
[    0.617470] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocat=
ions=0D
[    0.618076] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic=
 allocations=0D
[    0.618730] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atom=
ic allocations=0D
[    0.618974] audit: initializing netlink subsys (disabled)=0D
[    0.619518] audit: type=3D2000 audit(1675821111.660:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1=0D
[    0.620598] thermal_sys: Registered thermal governor 'fair_share'=0D
[    0.620609] thermal_sys: Registered thermal governor 'bang_bang'=0D
[    0.621131] thermal_sys: Registered thermal governor 'step_wise'=0D
[    0.621627] thermal_sys: Registered thermal governor 'user_space'=0D
[    0.622195] cpuidle: using governor ladder=0D
[    0.623245] cpuidle: using governor menu=0D
[    0.624045] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5=0D
[    0.625125] PCI: Using configuration type 1 for base access=0D
[    0.626923] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.=0D
[    0.893468] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 page=
s=0D
[    0.894038] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page=
=0D
[    0.894590] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s=0D
[    0.894886] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page=0D
[    0.899416] ACPI: Added _OSI(Module Device)=0D
[    0.899790] ACPI: Added _OSI(Processor Device)=0D
[    0.900169] ACPI: Added _OSI(3.0 _SCP Extensions)=0D
[    0.900565] ACPI: Added _OSI(Processor Aggregator Device)=0D
[    0.917044] ACPI: 1 ACPI AML tables successfully acquired and loaded=0D
[    0.924297] ACPI: Interpreter enabled=0D
[    0.924797] ACPI: PM: (supports S0 S3 S4 S5)=0D
[    0.925160] ACPI: Using IOAPIC for interrupt routing=0D
[    0.925668] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug=0D
[    0.926414] PCI: Using E820 reservations for host bridge windows=0D
[    0.928270] ACPI: Enabled 2 GPEs in block 00 to 0F=0D
[    0.966399] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])=0D
[    0.966914] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I EDR HPX-Type3]=0D
[    0.967591] acpi PNP0A03:00: _OSC: not requesting OS control; OS require=
s [ExtendedConfig ASPM ClockPM MSI]=0D
[    0.968645] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended configuration space under this bridge=0D
[    0.974824] acpiphp: Slot [3] registered=0D
[    0.975028] acpiphp: Slot [4] registered=0D
[    0.975499] acpiphp: Slot [5] registered=0D
[    0.975983] acpiphp: Slot [6] registered=0D
[    0.976454] acpiphp: Slot [7] registered=0D
[    0.976926] acpiphp: Slot [8] registered=0D
[    0.977395] acpiphp: Slot [9] registered=0D
[    0.977887] acpiphp: Slot [10] registered=0D
[    0.978363] acpiphp: Slot [11] registered=0D
[    0.978842] acpiphp: Slot [12] registered=0D
[    0.979022] acpiphp: Slot [13] registered=0D
[    0.979524] acpiphp: Slot [14] registered=0D
[    0.980000] acpiphp: Slot [15] registered=0D
[    0.980499] acpiphp: Slot [16] registered=0D
[    0.980974] acpiphp: Slot [17] registered=0D
[    0.981477] acpiphp: Slot [18] registered=0D
[    0.981953] acpiphp: Slot [19] registered=0D
[    0.982432] acpiphp: Slot [20] registered=0D
[    0.982919] acpiphp: Slot [21] registered=0D
[    0.983768] acpiphp: Slot [22] registered=0D
[    0.984286] acpiphp: Slot [23] registered=0D
[    0.984787] acpiphp: Slot [24] registered=0D
[    0.985264] acpiphp: Slot [25] registered=0D
[    0.985757] acpiphp: Slot [26] registered=0D
[    0.986238] acpiphp: Slot [27] registered=0D
[    0.986724] acpiphp: Slot [28] registered=0D
[    0.987024] acpiphp: Slot [29] registered=0D
[    0.987505] acpiphp: Slot [30] registered=0D
[    0.987990] acpiphp: Slot [31] registered=0D
[    0.988390] PCI host bridge to bus 0000:00=0D
[    0.988737] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]=0D
[    0.989310] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]=0D
[    0.989877] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]=0D
[    0.990497] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebffff=
f window]=0D
[    0.990885] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17ffff=
fff window]=0D
[    0.991522] pci_bus 0000:00: root bus resource [bus 00-ff]=0D
[    0.992167] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=0D
[    1.002014] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100=0D
[    1.003798] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180=0D
[    1.005864] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]=0D
[    1.006902] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]=0D
[    1.007493] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]=
=0D
[    1.008037] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]=0D
[    1.008625] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]=
=0D
[    1.009647] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=0D
[    1.010500] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX=
4 ACPI=0D
[    1.010891] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX=
4 SMB=0D
[    1.011924] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000=0D
[    1.013589] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]=
=0D
[    1.015655] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]=0D
[    1.018387] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]=
=0D
[    1.018984] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]=0D
[    1.028421] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000=0D
[    1.029490] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]=0D
[    1.030533] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]=0D
[    1.033322] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]=
=0D
[    1.052758] ACPI: PCI: Interrupt link LNKA configured for IRQ 10=0D
[    1.054281] ACPI: PCI: Interrupt link LNKB configured for IRQ 10=0D
[    1.055749] ACPI: PCI: Interrupt link LNKC configured for IRQ 11=0D
[    1.057244] ACPI: PCI: Interrupt link LNKD configured for IRQ 11=0D
[    1.058158] ACPI: PCI: Interrupt link LNKS configured for IRQ 9=0D
[    1.061023] iommu: Default domain type: Translated =0D
[    1.061452] iommu: DMA domain TLB invalidation policy: lazy mode =0D
[    1.064286] SCSI subsystem initialized=0D
[    1.065097] ACPI: bus type USB registered=0D
[    1.065549] usbcore: registered new interface driver usbfs=0D
[    1.066065] usbcore: registered new interface driver hub=0D
[    1.066570] usbcore: registered new device driver usb=0D
[    1.067094] pps_core: LinuxPPS API ver. 1 registered=0D
[    1.067508] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>=0D
[    1.068296] PTP clock support registered=0D
[    1.068854] EDAC MC: Ver: 3.0.0=0D
[    1.071739] NetLabel: Initializing=0D
[    1.072044] NetLabel:  domain hash size =3D 128=0D
[    1.072407] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO=0D
[    1.073013] NetLabel:  unlabeled traffic allowed by default=0D
[    1.073960] PCI: Using ACPI for IRQ routing=0D
[    1.074646] pci 0000:00:02.0: vgaarb: setting as boot VGA device=0D
[    1.074876] pci 0000:00:02.0: vgaarb: bridge control possible=0D
[    1.074876] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone=0D
[    1.074886] vgaarb: loaded=0D
[    1.075627] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0=0D
[    1.076057] hpet0: 3 comparators, 64-bit 100.000000 MHz counter=0D
[    3.803886] Callback from call_rcu_tasks_rude() invoked.=0D
[    3.804375] clocksource: Switched to clocksource kvm-clock=0D
[    3.911009] Callback from call_rcu_tasks() invoked.=0D
[    4.074780] VFS: Disk quotas dquot_6.6.0=0D
[    4.075224] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)=0D
[    4.076285] pnp: PnP ACPI init=0D
[    4.080907] pnp: PnP ACPI: found 6 devices=0D
[    4.099757] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns=0D
[    4.101007] NET: Registered PF_INET protocol family=0D
[    4.101558] IP idents hash table entries: 32768 (order: 6, 262144 bytes,=
 linear)=0D
[    4.103783] tcp_listen_portaddr_hash hash table entries: 1024 (order: 4,=
 73728 bytes, linear)=0D
[    4.104546] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)=0D
[    4.105228] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes, linear)=0D
[    4.106333] TCP bind hash table entries: 16384 (order: 9, 2359296 bytes,=
 linear)=0D
[    4.108362] TCP: Hash tables configured (established 16384 bind 16384)=
=0D
[    4.109072] UDP hash table entries: 1024 (order: 5, 163840 bytes, linear=
)=0D
[    4.109721] UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes, l=
inear)=0D
[    4.110666] NET: Registered PF_UNIX/PF_LOCAL protocol family=0D
[    4.112163] RPC: Registered named UNIX socket transport module.=0D
[    4.112727] RPC: Registered udp transport module.=0D
[    4.113126] RPC: Registered tcp transport module.=0D
[    4.113532] RPC: Registered tcp NFSv4.1 backchannel transport module.=0D
[    4.114089] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]=0D
[    4.114614] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]=0D
[    4.115155] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]=0D
[    4.115735] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff windo=
w]=0D
[    4.116304] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff win=
dow]=0D
[    4.117297] pci 0000:00:01.0: PIIX3: Enabling Passive Release=0D
[    4.117794] pci 0000:00:00.0: Limiting direct PCI/PCI transfers=0D
[    4.118397] PCI: CLS 0 bytes, default 64=0D
[    4.118798] ACPI: bus type thunderbolt registered=0D
[    4.119597] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x188=
1273ac8e, max_idle_ns: 440795257284 ns=0D
[    4.120559] sgx: There are zero EPC sections.=0D
[    4.126846] Initialise system trusted keyrings=0D
[    4.127377] Key type blacklist registered=0D
[    4.127941] workingset: timestamp_bits=3D36 max_order=3D19 bucket_order=
=3D0=0D
[    4.128577] zbud: loaded=0D
[    4.130294] squashfs: version 4.0 (2009/01/31) Phillip Lougher=0D
[    4.131970] NFS: Registering the id_resolver key type=0D
[    4.132421] Key type id_resolver registered=0D
[    4.132778] Key type id_legacy registered=0D
[    4.133168] nfs4filelayout_init: NFSv4 File Layout Driver Registering...=
=0D
[    4.133760] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering...=0D
[    4.134583] fuse: init (API version 7.38)=0D
[    4.135204] SGI XFS with ACLs, security attributes, realtime, quota, no =
debug enabled=0D
[    4.136918] 9p: Installing v9fs 9p2000 file system support=0D
[    4.144810] Key type asymmetric registered=0D
[    4.145170] Asymmetric key parser 'x509' registered=0D
[    4.145679] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 243)=0D
[    4.146459] io scheduler mq-deadline registered=0D
[    4.146925] io scheduler bfq registered=0D
[    4.147945] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4=
=0D
[    4.149242] IPMI message handler: version 39.2=0D
[    4.149696] ipmi device interface=0D
[    4.152373] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0=0D
[    4.153430] ACPI: button: Power Button [PWRF]=0D
[    4.155748] ERST DBG: ERST support is disabled.=0D
[    4.157186] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled=0D
[    4.158343] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A=0D
[    4.176282] Linux agpgart interface v0.103=0D
[    4.178060] ACPI: bus type drm_connector registered=0D
[    4.199156] brd: module loaded=0D
[    4.211637] loop: module loaded=0D
[    4.219198] scsi host0: ata_piix=0D
[    4.220343] scsi host1: ata_piix=0D
[    4.220964] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 1=
4=0D
[    4.221540] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 1=
5=0D
[    4.224372] tun: Universal TUN/TAP device driver, 1.6=0D
[    4.225070] e100: Intel(R) PRO/100 Network Driver=0D
[    4.225470] e100: Copyright(c) 1999-2006 Intel Corporation=0D
[    4.226000] e1000: Intel(R) PRO/1000 Network Driver=0D
[    4.226416] e1000: Copyright (c) 1999-2006 Intel Corporation.=0D
[    4.379042] ata2: found unknown device (class 0)=0D
[    4.379832] ata1: found unknown device (class 0)=0D
[    4.380658] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100=0D
[    4.381537] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100=0D
[    4.382016] ata1.00: 16777216 sectors, multi 16: LBA48 =0D
[    4.383903] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.=
5+ PQ: 0 ANSI: 5=0D
[    4.386250] scsi 0:0:0:0: Attached scsi generic sg0 type 0=0D
[    4.387532] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.=
5+ PQ: 0 ANSI: 5=0D
[    4.387902] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.59 GB=
/8.00 GiB)=0D
[    4.389063] sd 0:0:0:0: [sda] Write Protect is off=0D
[    4.389638] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0D
[    4.390458] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes=0D
[    4.400088] scsi 1:0:0:0: Attached scsi generic sg1 type 5=0D
[    4.408522] sd 0:0:0:0: [sda] Attached SCSI disk=0D
[    4.994568] ACPI: \_SB_.LNKC: Enabled at IRQ 11=0D
[    5.322756] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:5=
6=0D
[    5.323411] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connectio=
n=0D
[    5.324118] e1000e: Intel(R) PRO/1000 Network Driver=0D
[    5.324543] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.=0D
[    5.325148] igb: Intel(R) Gigabit Ethernet Network Driver=0D
[    5.325611] igb: Copyright (c) 2007-2014 Intel Corporation.=0D
[    5.326271] PPP generic driver version 2.4.2=0D
[    5.327374] VFIO - User Level meta-driver version: 0.3=0D
[    5.328627] usbcore: registered new interface driver uas=0D
[    5.329140] usbcore: registered new interface driver usb-storage=0D
[    5.329896] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12=0D
[    5.331429] serio: i8042 KBD port at 0x60,0x64 irq 1=0D
[    5.331902] serio: i8042 AUX port at 0x60,0x64 irq 12=0D
[    5.333496] mousedev: PS/2 mouse device common for all mice=0D
[    5.335402] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1=0D
[    5.337596] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042=
/serio1/input/input4=0D
[    5.338903] rtc_cmos 00:05: RTC can wake from S4=0D
[    5.340231] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042=
/serio1/input/input3=0D
[    5.341640] rtc_cmos 00:05: registered as rtc0=0D
[    5.342128] rtc_cmos 00:05: setting system clock to 2023-02-08T01:51:55 =
UTC (1675821115)=0D
[    5.343158] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, =
hpet irqs=0D
[    5.343848] i2c_dev: i2c /dev entries driver=0D
[    5.344427] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. =
Duplicate IMA measurements will not be recorded in the IMA log.=0D
[    5.345485] device-mapper: uevent: version 1.0.3=0D
[    5.346242] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised:=
 dm-devel@redhat.com=0D
[    5.346994] intel_pstate: CPU model not supported=0D
[    5.347595] sdhci: Secure Digital Host Controller Interface driver=0D
[    5.348105] sdhci: Copyright(c) Pierre Ossman=0D
[    5.348602] sdhci-pltfm: SDHCI platform and OF driver helper=0D
[    5.349151] ledtrig-cpu: registered to indicate activity on CPUs=0D
[    5.350253] drop_monitor: Initializing network drop monitor service=0D
[    5.351172] NET: Registered PF_INET6 protocol family=0D
[    5.355422] Segment Routing with IPv6=0D
[    5.355804] In-situ OAM (IOAM) with IPv6=0D
[    5.356228] NET: Registered PF_PACKET protocol family=0D
[    5.356921] 9pnet: Installing 9P2000 support=0D
[    5.357379] Key type dns_resolver registered=0D
[    5.359038] IPI shorthand broadcast: enabled=0D
[    5.391273] sched_clock: Marking stable (5377621651, 13264093)->(5405014=
705, -14128961)=0D
[    5.393129] registered taskstats version 1=0D
[    5.393813] Loading compiled-in X.509 certificates=0D
[    5.394750] zswap: loaded using pool lzo/zbud=0D
[    5.437523] Key type .fscrypt registered=0D
[    5.437873] Key type fscrypt-provisioning registered=0D
[    5.439965] Key type encrypted registered=0D
[    5.440424] ima: No TPM chip found, activating TPM-bypass!=0D
[    5.440912] ima: Allocated hash algorithm: sha1=0D
[    5.441375] ima: No architecture policies found=0D
[    5.441858] evm: Initialising EVM extended attributes:=0D
[    5.442289] evm: security.selinux=0D
[    5.442579] evm: security.SMACK64=0D
[    5.442866] evm: security.SMACK64EXEC=0D
[    5.443205] evm: security.SMACK64TRANSMUTE=0D
[    5.443558] evm: security.SMACK64MMAP=0D
[    5.443873] evm: security.apparmor=0D
[    5.444169] evm: security.ima=0D
[    5.444426] evm: security.capability=0D
[    5.444726] evm: HMAC attrs: 0x1=0D
[    5.447799] PM:   Magic number: 11:18:862=0D
[    5.448830] RAS: Correctable Errors collector initialized.=0D
[    5.450955] md: Waiting for all devices to be available before autodetec=
t=0D
[    5.451350] md: If you don't use raid, use raid=3Dnoautodetect=0D
[    5.451686] md: Autodetecting RAID arrays.=0D
[    5.451934] md: autorun ...=0D
[    5.452102] md: ... autorun DONE.=0D
[    5.456668] EXT4-fs (sda): INFO: recovery required on readonly filesyste=
m=0D
[    5.457096] EXT4-fs (sda): write access will be enabled during recovery=
=0D
[    5.702920] EXT4-fs (sda): recovery complete=0D
[    5.704391] EXT4-fs (sda): mounted filesystem 23a53bb9-f815-47a5-b74c-5e=
08f7731193 with ordered data mode. Quota mode: none.=0D
[    5.705115] VFS: Mounted root (ext4 filesystem) readonly on device 8:0.=
=0D
[    5.706085] devtmpfs: mounted=0D
[    5.725549] Freeing unused decrypted memory: 2036K=0D
[    5.730515] Freeing unused kernel image (initmem) memory: 14104K=0D
[    5.730944] Write protecting the kernel read-only data: 90112k=0D
[    5.734149] Freeing unused kernel image (rodata/data gap) memory: 1956K=
=0D
[    7.429076] x86/mm: Checked W+X mappings: passed, no W+X pages found.=0D
[    7.429510] Run /sbin/init as init process=0D
[    7.542860] systemd[1]: RTC configured in localtime, applying delta of 0=
 minutes to system time.=0D
[    7.585724] systemd[1]: systemd 239 (239-49.el8) running in system mode.=
 (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP=
 +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +=
PCRE2 default-hierarchy=3Dlegacy)=0D
[    7.587413] systemd[1]: Detected virtualization kvm.=0D
[    7.587722] systemd[1]: Detected architecture x86-64.=0D
=0D
Welcome to =1B[0;31mCentOS Stream 8=1B[0m!=0D
=0D
[    7.649292] systemd[1]: Set hostname to <test>.=0D
[    8.086022] systemd[1]: Created slice system-serial\x2dgetty.slice.=0D
[=1B[0;32m  OK  =1B[0m] Created slice system-serial\x2dgetty.slice.=0D
[    8.087616] systemd[1]: Listening on initctl Compatibility Named Pipe.=
=0D
[=1B[0;32m  OK  =1B[0m] Listening on initctl Compatibility Named Pipe.=0D
[    8.091539] systemd[1]: Created slice system-getty.slice.=0D
[=1B[0;32m  OK  =1B[0m] Created slice system-getty.slice.=0D
[    8.093550] systemd[1]: Listening on RPCbind Server Activation Socket.=
=0D
[=1B[0;32m  OK  =1B[0m] Listening on RPCbind Server Activation Socket.=0D
[    8.115474] systemd[1]: Listening on Process Core Dump Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on Process Core Dump Socket.=0D
[    8.116732] systemd[1]: Listening on multipathd control socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on multipathd control socket.=0D
[=1B[0;32m  OK  =1B[0m] Created slice system-sshd\x2dkeygen.slice.=0D
[=1B[0;32m  OK  =1B[0m] Listening on Journal Socket.=0D
         Mounting POSIX Message Queue File System...=0D
         Mounting Huge Pages File System...=0D
[=1B[0;32m  OK  =1B[0m] Listening on udev Control Socket.=0D
[=1B[0;32m  OK  =1B[0m] Listening on LVM2 poll daemon socket.=0D
         Starting Setup Virtual Console...=0D
[=1B[0;32m  OK  =1B[0m] Set up automount Arbitrary Executab=E2=80=A6rmats F=
ile System Automount Point.=0D
         Starting Load Kernel Modules...=0D
[=1B[0;32m  OK  =1B[0m] Started Forward Password Requests to Wall Directory=
 Watch.=0D
[=1B[0;32m  OK  =1B[0m] Listening on Device-mapper event daemon FIFOs.=0D
         Starting Monitoring of LVM2 mirrors=E2=80=A6ng dmeventd or progres=
s polling...=0D
[=1B[0;32m  OK  =1B[0m] Listening on Journal Socket (/dev/log).=0D
         Starting Journal Service...=0D
[=1B[0;32m  OK  =1B[0m] Reached target Swap.=0D
         Mounting Kernel Debug File System...=0D
[=1B[0;32m  OK  =1B[0m] Listening on udev Kernel Socket.=0D
         Starting udev Coldplug all Devices...=0D
[=1B[0;32m  OK  =1B[0m] Reached target RPC Port Mapper.=0D
         Starting Remount Root and Kernel File Systems...=0D
[=1B[0;32m  OK  =1B[0m] Created slice User and Session Slice.=0D
[=1B[0;32m  OK  =1B[0m] Reached target Slices.=0D
[=1B[0;32m  OK  =1B[0m] Mounted POSIX Message Queue File System.=0D
[=1B[0;32m  OK  =1B[0m] Mounted Huge Pages File System.=0D
[=1B[0;1;31mFAILED=1B[0m] Failed to start Load Kernel Modules.=0D
See 'systemctl status systemd-modules-load.service' for details.=0D
[=1B[0;32m  OK  =1B[0m] Mounted Kernel Debug File System.=0D
         Mounting FUSE Control File System...=0D
         Starting Apply Kernel Variables...=0D
         Mounting Kernel Configuration File System...=0D
[=1B[0;32m  OK  =1B[0m] Started Journal Service.=0D
[=1B[0;32m  OK  =1B[0m] Mounted FUSE Control File System.=0D
[=1B[0;32m  OK  =1B[0m] Started Apply Kernel Variables.=0D
[=1B[0;32m  OK  =1B[0m] Mounted Kernel Configuration File System.=0D
[    8.890948] EXT4-fs (sda): re-mounted 23a53bb9-f815-47a5-b74c-5e08f77311=
93. Quota mode: none.=0D
[=1B[0;32m  OK  =1B[0m] Started Remount Root and Kernel File Systems.=0D
         Starting Load/Save Random Seed...=0D
         Starting Flush Journal to Persistent Storage...=0D
         Starting Create Static Device Nodes in /dev...=0D
[=1B[0;32m  OK  =1B[0m] Started Setup Virtual Console.=0D
[=1B[0;32m  OK  =1B[0m] Started Load/Save Random Seed.=0D
[=1B[0;32m  OK  =1B[0m] Started Flush Journal to Persistent Storage.=0D
[=1B[0;32m  OK  =1B[0m] Started Create Static Device Nodes in /dev.=0D
         Starting udev Kernel Device Manager...=0D
[=1B[0;32m  OK  =1B[0m] Started udev Kernel Device Manager.=0D
[=1B[0;32m  OK  =1B[0m] Started udev Coldplug all Devices.=0D
         Starting udev Wait for Complete Device Initialization...=0D
         Starting Show Plymouth Boot Screen...=0D
[=1B[0;32m  OK  =1B[0m] Started Show Plymouth Boot Screen.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Forward Password Requests to Plymouth Direc=
tory Watch.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Paths.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Local Encrypted Volumes.=0D=0D
[=1B[0;32m  OK  =1B[0m] Found device /dev/ttyS0.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Monitoring of LVM2 mirrors,=E2=80=A6sing dm=
eventd or progress polling.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started udev Wait for Complete Device Initializatio=
n.=0D=0D
[=1B[0;32m  OK  =1B[0m] Listening on Load/Save RF Kill Switch Status /dev/r=
fkill Watch.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Local File Systems (Pre).=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Local File Systems.=0D=0D
         Starting Create Volatile Files and Directories...=0D=0D
         Starting Tell Plymouth To Write Out Runtime Data...=0D=0D
         Starting Restore /run/initramfs on shutdown...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Create Volatile Files and Directories.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Started Tell Plymouth To Write Out Runtime Data.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Started Restore /run/initramfs on shutdown.=0D=0D
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
[=1B[0;32m  OK  =1B[0m] Started Daily Cleanup of Temporary Directories.=0D=
=0D
[=1B[0;32m  OK  =1B[0m] Started daily update of the root trust anchor for D=
NSSEC.=0D=0D
[=1B[0;32m  OK  =1B[0m] Listening on D-Bus System Message Bus Socket.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Sockets.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started dnf makecache --timer.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Timers.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Basic System.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started irqbalance daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started D-Bus System Message Bus.=0D=0D
         Starting Network Manager...=0D=0D
         Starting Self Monitoring and Reporting Technology (SMART) Daemon..=
.=0D=0D
         Starting Authorization Manager...=0D=0D
         Starting Login Service...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Machine Check Exception Logging Daemon.=0D=
=0D
         Starting NTP client/server...=0D=0D
         Starting Auto-connect to subsystems=E2=80=A6-NVME devices found du=
ring boot...=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target sshd-keygen.target.=0D=0D
         Starting update of the root trust a=E2=80=A6or DNSSEC validation i=
n unbound...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Auto-connect to subsystems =E2=80=A6FC-NVME=
 devices found during boot.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Self Monitoring and Reporting Technology (S=
MART) Daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Login Service.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Network Manager.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Network.=0D=0D
         Starting Dynamic System Tuning Daemon...=0D=0D
         Starting OpenSSH server daemon...=0D=0D
         Starting GSSAPI Proxy Daemon...=0D=0D
         Starting Network Manager Wait Online...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started update of the root trust an=E2=80=A6 for DN=
SSEC validation in unbound.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started OpenSSH server daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started NTP client/server.=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Authorization Manager.=0D=0D
         Starting Hostname Service...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started GSSAPI Proxy Daemon.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target NFS client services.=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Remote File Systems (Pre).=0D=0D
[=1B[0;32m  OK  =1B[0m] Reached target Remote File Systems.=0D=0D
         Starting Permit User Sessions...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Permit User Sessions.=0D=0D
         Starting Hold until boot process finishes up...=0D=0D
         Starting Terminate Plymouth Boot Screen...=0D=0D
[=1B[0;32m  OK  =1B[0m] Started Command Scheduler.=0D=0D
[   12.771112] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Contr=
ol: RX=0D
[   12.772100] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready=0D
[   12.973518] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
[   12.974286] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
=0D=0D
CentOS Stream 8=0D
Kernel 6.2.0-rc7-4ec5183ec486 on an x86_64=0D
=0D
test login: [   29.944700] loop0: detected capacity change from 0 to 65536=
=0D
[   29.948367] XFS (loop0): Mounting V5 Filesystem e4654a66-62e5-4963-a81e-=
012d9d4871af=0D
[   29.956723] XFS (loop0): Ending clean mount=0D
[   29.990519] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   29.991232] XFS (loop0): Unmount and run xfs_repair=0D
[   29.991523] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   29.991905] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   29.992372] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   29.992833] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   29.993294] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   29.993754] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   29.994215] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   29.994673] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   29.995160] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   29.996988] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   29.997818] XFS (loop0): page discard on page 000000009ab256c7, inode 0x=
49, pos 0.=0D
[   29.999155] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   29.999789] XFS (loop0): Unmount and run xfs_repair=0D
[   30.000084] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.000463] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.000922] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.001385] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.001844] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.002306] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.002760] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.003553] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.004013] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.005905] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.006650] XFS (loop0): page discard on page 000000009ab256c7, inode 0x=
49, pos 0.=0D
[   30.008764] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.009382] XFS (loop0): Unmount and run xfs_repair=0D
[   30.009680] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.010064] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.010523] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.011056] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.011517] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.011977] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.012436] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.012898] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.013358] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.016837] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.017561] XFS (loop0): page discard on page 000000009ab256c7, inode 0x=
49, pos 0.=0D
[   30.020392] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.021013] XFS (loop0): Unmount and run xfs_repair=0D
[   30.021305] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.021696] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.022163] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.022626] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.023114] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.023575] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.024034] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.024492] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.024950] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.026711] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.027442] XFS (loop0): page discard on page 000000009ab256c7, inode 0x=
49, pos 0.=0D
[   30.028370] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.028988] XFS (loop0): Unmount and run xfs_repair=0D
[   30.029278] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.029660] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.030126] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.030588] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.031076] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.031534] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.031998] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.032460] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.032921] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.034664] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.035659] XFS (loop0): page discard on page 000000009ab256c7, inode 0x=
49, pos 0.=0D
[   30.036633] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.037253] XFS (loop0): Unmount and run xfs_repair=0D
[   30.037541] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.037923] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.038391] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.038850] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.039368] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.039830] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.040293] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.040752] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.041212] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.043496] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.044208] XFS (loop0): page discard on page 000000009ab256c7, inode 0x=
49, pos 0.=0D
[   30.044882] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.045487] XFS (loop0): Unmount and run xfs_repair=0D
[   30.045777] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.046172] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.046634] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.047148] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.047608] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.048072] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.048533] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.048992] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.049450] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.049957] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.050834] XFS (loop0): page discard on page 000000009ab256c7, inode 0x=
49, pos 0.=0D
[   30.052094] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.052703] XFS (loop0): Unmount and run xfs_repair=0D
[   30.052995] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.053376] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.053834] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.054299] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.054758] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.055255] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.055719] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.056182] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.056644] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.057119] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.058164] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.058766] XFS (loop0): Unmount and run xfs_repair=0D
[   30.059086] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.059469] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.059932] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.060397] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.060854] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.061317] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.061778] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.062241] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.062697] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.063188] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.063893] XFS (loop0): page discard on page 000000009ab256c7, inode 0x=
49, pos 0.=0D
[   30.064547] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.065149] XFS (loop0): Unmount and run xfs_repair=0D
[   30.065437] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.065816] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.066279] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.066738] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.067224] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.067683] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.068146] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.068607] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.069068] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.069535] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.070235] XFS (loop0): page discard on page 000000009ab256c7, inode 0x=
49, pos 0.=0D
[   30.070871] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.071510] XFS (loop0): Unmount and run xfs_repair=0D
[   30.071798] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.072177] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.072633] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.073093] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.073550] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.074013] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.074471] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.074948] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.075413] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.075916] XFS (loop0): page discard on page 000000009ab256c7, inode 0x=
49, pos 0.=0D
[   30.076815] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.077420] XFS (loop0): Unmount and run xfs_repair=0D
[   30.077708] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.078089] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.078549] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.079038] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.079501] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.079961] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.080426] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.080886] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.081352] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.082045] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.082643] XFS (loop0): Unmount and run xfs_repair=0D
[   30.082951] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.083334] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.083792] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.084257] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.084717] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.085190] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.085650] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.086113] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.086570] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.087352] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.087953] XFS (loop0): Unmount and run xfs_repair=0D
[   30.088243] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.088621] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.089084] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.089542] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.090005] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.090460] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.090939] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.091402] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.091862] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.092553] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.093159] XFS (loop0): Unmount and run xfs_repair=0D
[   30.093447] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.093826] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.094291] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.094751] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.095236] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.095699] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.096169] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.096618] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.097073] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.097745] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.098341] XFS (loop0): Unmount and run xfs_repair=0D
[   30.098626] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.099023] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.099474] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.099925] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.100383] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.100834] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.101287] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.101736] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.102188] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.102853] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.103472] XFS (loop0): Unmount and run xfs_repair=0D
[   30.103755] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.104132] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.104586] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.105039] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.105489] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.105940] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.106394] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.106849] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.107321] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.108031] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.108623] XFS (loop0): Unmount and run xfs_repair=0D
[   30.108905] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.109282] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.109732] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.110189] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.110641] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.111118] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.111568] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.112022] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.112473] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.113153] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.113743] XFS (loop0): Unmount and run xfs_repair=0D
[   30.114027] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.114398] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.114844] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.115320] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.115769] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.116218] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.116669] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.117121] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.117571] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.118264] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.118853] XFS (loop0): Unmount and run xfs_repair=0D
[   30.119165] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.119539] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.119992] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.120441] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.120890] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.121345] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.121794] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.122247] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.122697] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.123381] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.123971] XFS (loop0): Unmount and run xfs_repair=0D
[   30.124257] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.124631] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.125088] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.125538] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.125994] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.126441] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.126932] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.127384] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.127831] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.128518] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.129111] XFS (loop0): Unmount and run xfs_repair=0D
[   30.129394] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.129765] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.130218] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.130665] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.131148] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.131600] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.132055] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.132507] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.132957] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.133631] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.134225] XFS (loop0): Unmount and run xfs_repair=0D
[   30.134508] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.134901] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.135355] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.135807] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.136263] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.136717] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.137170] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.137622] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.138079] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.138745] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.139358] XFS (loop0): Unmount and run xfs_repair=0D
[   30.139643] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.140020] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.140468] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.140918] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.141369] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.141821] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.142271] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.142722] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.143195] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.143858] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.144451] XFS (loop0): Unmount and run xfs_repair=0D
[   30.144732] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.145109] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.145558] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.146010] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.146458] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.146929] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.147385] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.147839] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.148293] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.148958] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.149553] XFS (loop0): Unmount and run xfs_repair=0D
[   30.149833] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.150210] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.150659] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.151133] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.151583] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.152038] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.152487] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.152934] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.153386] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.154059] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.154645] XFS (loop0): Unmount and run xfs_repair=0D
[   30.154949] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.155329] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.155783] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.156235] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.156688] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.157141] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.157591] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.158046] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.158494] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.159205] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.159792] XFS (loop0): Unmount and run xfs_repair=0D
[   30.160080] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.160451] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.160900] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.161354] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.161805] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.162260] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.162707] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.163179] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.163628] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.164300] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.164890] XFS (loop0): Unmount and run xfs_repair=0D
[   30.165179] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.165551] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.166004] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.166462] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.166932] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.167386] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.167837] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.168286] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.168738] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.174769] XFS (loop0): Unmounting Filesystem e4654a66-62e5-4963-a81e-0=
12d9d4871af=0D
[   30.507706] loop0: detected capacity change from 0 to 65536=0D
[   30.509642] XFS (loop0): Mounting V5 Filesystem e4654a66-62e5-4963-a81e-=
012d9d4871af=0D
[   30.516858] XFS (loop0): Ending clean mount=0D
[   30.532645] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.533296] XFS (loop0): Unmount and run xfs_repair=0D
[   30.533593] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.533972] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.534435] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.535006] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.535468] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.535927] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.536391] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.536852] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.537328] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.539150] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.540163] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.540805] XFS (loop0): Unmount and run xfs_repair=0D
[   30.541101] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.541477] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.541935] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.542398] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.542858] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.543377] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.543834] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.544296] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.544754] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.545231] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.546194] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.546803] XFS (loop0): Unmount and run xfs_repair=0D
[   30.547218] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.547602] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.548065] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.548524] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.548982] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.549446] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.549905] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.550365] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.550828] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.553082] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.554054] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.554656] XFS (loop0): Unmount and run xfs_repair=0D
[   30.554975] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.555362] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.555821] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.556286] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.556745] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.557208] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.557669] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.558135] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.558592] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.560884] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.561856] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.562495] XFS (loop0): Unmount and run xfs_repair=0D
[   30.562793] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.563233] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.563693] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.564151] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.564606] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.565065] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.565521] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.565977] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.566437] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.567612] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.572849] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.573477] XFS (loop0): Unmount and run xfs_repair=0D
[   30.573769] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.574158] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.574616] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.575098] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.575556] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.576018] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.576476] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.576930] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.577387] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.579700] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.589594] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.590225] XFS (loop0): Unmount and run xfs_repair=0D
[   30.590513] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.590920] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.591383] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.591842] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.592299] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.592758] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.593216] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.593671] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.594130] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.596250] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.597432] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.598040] XFS (loop0): Unmount and run xfs_repair=0D
[   30.598337] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.598717] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.599236] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.599695] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.600157] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.600615] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.601076] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.601533] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.601995] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.602571] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.604085] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.604700] XFS (loop0): Unmount and run xfs_repair=0D
[   30.605005] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.605386] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.605844] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.606310] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.606770] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.607262] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.607720] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.608182] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.608640] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.609111] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.610032] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.610632] XFS (loop0): Unmount and run xfs_repair=0D
[   30.610962] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.611345] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.611802] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.612265] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.612723] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.613183] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.613644] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.614104] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.614564] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.615046] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   30.615935] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.616537] XFS (loop0): Unmount and run xfs_repair=0D
[   30.616825] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.617206] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.617665] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.618130] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.618585] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.619067] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.619525] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.619979] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.620442] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.621122] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.621720] XFS (loop0): Unmount and run xfs_repair=0D
[   30.622012] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.622392] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.622852] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.623335] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.623793] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.624254] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.624710] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.625173] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.625634] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.626318] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.626939] XFS (loop0): Unmount and run xfs_repair=0D
[   30.627233] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.627614] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.628075] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.628534] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.628997] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.629454] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.629911] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.630372] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.630830] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.631549] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.632155] XFS (loop0): Unmount and run xfs_repair=0D
[   30.632444] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.632824] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.633283] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.633741] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.634203] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.634663] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.635146] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.635606] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.636069] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.636744] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.637347] XFS (loop0): Unmount and run xfs_repair=0D
[   30.637633] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.638014] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.638472] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.638950] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.639412] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.639872] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.640336] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.640793] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.641255] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.641926] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.642529] XFS (loop0): Unmount and run xfs_repair=0D
[   30.642816] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.643224] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.643682] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.644143] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.644603] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.645066] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.645523] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.645983] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.646446] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.647138] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.647739] XFS (loop0): Unmount and run xfs_repair=0D
[   30.648031] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.648411] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.648869] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.649331] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.649788] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.650248] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.650704] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.651184] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.651642] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.652321] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.652920] XFS (loop0): Unmount and run xfs_repair=0D
[   30.653215] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.653593] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.654054] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.654510] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.654992] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.655451] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.655909] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.656371] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.656830] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.657500] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.658101] XFS (loop0): Unmount and run xfs_repair=0D
[   30.658390] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.658766] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.659247] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.659706] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.660165] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.660625] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.661085] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.661542] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.662003] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.662678] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.663300] XFS (loop0): Unmount and run xfs_repair=0D
[   30.663588] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.663969] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.664429] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.664889] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.665347] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.665803] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.666264] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.666721] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.667193] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.667864] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.668473] XFS (loop0): Unmount and run xfs_repair=0D
[   30.668759] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.669138] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.669599] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.670058] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.670517] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.671006] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.671464] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.671921] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.672384] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.673057] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.673654] XFS (loop0): Unmount and run xfs_repair=0D
[   30.673940] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.674325] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.674785] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.675266] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.675725] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.676186] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.676646] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.677109] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.677568] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.678237] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.678835] XFS (loop0): Unmount and run xfs_repair=0D
[   30.679146] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.679523] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.679980] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.680442] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.680899] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.681360] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.681820] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.682284] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.682740] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.683456] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.684059] XFS (loop0): Unmount and run xfs_repair=0D
[   30.684347] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.684724] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.685187] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.685643] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.686100] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.686559] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.687042] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.687501] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.687961] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.688639] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.689242] XFS (loop0): Unmount and run xfs_repair=0D
[   30.689529] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.689908] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.690382] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.690839] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.691320] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.691781] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.692240] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.692697] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.693158] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.693822] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.694424] XFS (loop0): Unmount and run xfs_repair=0D
[   30.694712] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.695117] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.695577] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.696041] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.696499] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.696958] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.697418] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.697873] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.698336] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.699031] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.699628] XFS (loop0): Unmount and run xfs_repair=0D
[   30.699914] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.700297] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.700755] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.701213] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.701668] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.702127] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.702583] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.703062] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.703518] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.704192] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.704789] XFS (loop0): Unmount and run xfs_repair=0D
[   30.705079] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.705459] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.705914] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.706378] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.706838] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.707321] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.707778] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.708239] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.708695] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.709372] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   30.709972] XFS (loop0): Unmount and run xfs_repair=0D
[   30.710263] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   30.710640] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   30.711122] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   30.711584] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   30.712049] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   30.712506] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   30.712962] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.713425] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   30.713881] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   30.720083] XFS (loop0): Unmounting Filesystem e4654a66-62e5-4963-a81e-0=
12d9d4871af=0D
[   31.096187] loop0: detected capacity change from 0 to 65536=0D
[   31.098326] XFS (loop0): Mounting V5 Filesystem e4654a66-62e5-4963-a81e-=
012d9d4871af=0D
[   31.105148] XFS (loop0): Ending clean mount=0D
[   31.120514] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.121168] XFS (loop0): Unmount and run xfs_repair=0D
[   31.121457] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.121846] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.122310] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.122766] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.123255] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.123717] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.124174] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.124629] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.125085] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.126841] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.128025] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.128635] XFS (loop0): Unmount and run xfs_repair=0D
[   31.128925] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.129322] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.129785] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.130246] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.130708] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.131207] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.131665] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.132127] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.132587] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.134177] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.136601] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.137227] XFS (loop0): Unmount and run xfs_repair=0D
[   31.137518] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.137900] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.138363] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.138824] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.139342] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.139803] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.140268] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.140729] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.141193] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.143290] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.144238] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.144869] XFS (loop0): Unmount and run xfs_repair=0D
[   31.145159] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.145537] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.145993] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.146455] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.147236] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.147694] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.148154] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.148614] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.149074] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.149548] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.150563] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.151292] XFS (loop0): Unmount and run xfs_repair=0D
[   31.151590] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.151973] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.152439] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.152899] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.153359] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.153820] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.154303] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.154765] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.155252] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.156656] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.157602] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.158211] XFS (loop0): Unmount and run xfs_repair=0D
[   31.158500] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.158909] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.159371] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.159831] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.160294] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.160755] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.161219] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.161682] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.162145] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.164231] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.165172] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.165778] XFS (loop0): Unmount and run xfs_repair=0D
[   31.166072] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.166463] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.166954] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.167413] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.167872] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.168333] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.168792] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.169257] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.169717] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.171944] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.172997] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.173605] XFS (loop0): Unmount and run xfs_repair=0D
[   31.173894] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.174286] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.174748] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.175237] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.175697] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.176158] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.176619] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.177081] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.177539] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.179762] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.180821] ------------[ cut here ]------------=0D
[   31.181101] WARNING: CPU: 0 PID: 550 at fs/xfs/libxfs/xfs_bmap.c:4544 xf=
s_bmapi_convert_delalloc+0x793/0xf20=0D
[   31.181692] Modules linked in:=0D
[   31.181886] CPU: 0 PID: 550 Comm: repro Not tainted 6.2.0-rc7-4ec5183ec4=
86 #1=0D
[   31.182310] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014=0D
[   31.182989] RIP: 0010:xfs_bmapi_convert_delalloc+0x793/0xf20=0D
[   31.183342] Code: f9 ff ff e8 0f fd 08 ff 44 89 e6 bf 02 00 00 00 41 bf =
f5 ff ff ff e8 dc fe 08 ff 41 83 fc 02 0f 84 eb fe ff ff e8 ed fc 08 ff <0f=
> 0b e9 df fe ff ff e8 e1 fc 08 ff 49 8b bd a0 fe ff ff ba 01 00=0D
[   31.184391] RSP: 0018:ff1100000d03ef20 EFLAGS: 00010246=0D
[   31.184703] RAX: 0000000000000000 RBX: ff1100001eb47800 RCX: ffffffff825=
21274=0D
[   31.185118] RDX: 0000000000000000 RSI: ff1100000efc8000 RDI: 00000000000=
00002=0D
[   31.185531] RBP: ff1100000d03f120 R08: ff1100000d03f048 R09: fffffbfff0e=
b4055=0D
[   31.185946] R10: ffffffff875a02a7 R11: fffffbfff0eb4054 R12: 00000000000=
00000=0D
[   31.186363] R13: ff1100000d03f0f8 R14: ff1100000e544000 R15: 00000000fff=
ffff5=0D
[   31.186774] FS:  00007fd840a14700(0000) GS:ff1100006ca00000(0000) knlGS:=
0000000000000000=0D
[   31.187306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   31.187648] CR2: 00007f6e90b65000 CR3: 0000000013fa2004 CR4: 00000000007=
71ef0=0D
[   31.188069] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000=0D
[   31.188482] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400=0D
[   31.188897] PKRU: 55555554=0D
[   31.189069] Call Trace:=0D
[   31.189222]  <TASK>=0D
[   31.189370]  ? __pfx_xfs_bmapi_convert_delalloc+0x10/0x10=0D
[   31.189707]  ? __pfx_rwsem_wake+0x10/0x10=0D
[   31.189996]  ? write_comp_data+0x2f/0x90=0D
[   31.190260]  xfs_map_blocks+0x562/0xe40=0D
[   31.190527]  ? __pfx_xfs_map_blocks+0x10/0x10=0D
[   31.190800]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.191113]  ? lock_is_held_type+0xe6/0x140=0D
[   31.191371]  ? rcu_lockdep_current_cpu_online+0x4b/0x160=0D
[   31.191710]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.192012]  ? write_comp_data+0x2f/0x90=0D
[   31.192270]  iomap_do_writepage+0xc6f/0x2ba0=0D
[   31.192537]  ? write_comp_data+0x2f/0x90=0D
[   31.192805]  ? __pfx_iomap_do_writepage+0x10/0x10=0D
[   31.193093]  ? rcu_read_lock_sched_held+0xa9/0xd0=0D
[   31.193389]  ? __pfx_rcu_read_lock_sched_held+0x10/0x10=0D
[   31.193714]  ? write_comp_data+0x2f/0x90=0D
[   31.193970]  write_cache_pages+0x573/0x12c0=0D
[   31.194247]  ? __pfx_iomap_do_writepage+0x10/0x10=0D
[   31.194543]  ? __pfx_write_cache_pages+0x10/0x10=0D
[   31.194831]  ? __pfx_rcu_read_lock_sched_held+0x10/0x10=0D
[   31.195173]  ? ncsi_channel_monitor.cold.17+0x204/0x3f7=0D
[   31.195488]  ? lock_release+0x3f8/0x7d0=0D
[   31.195729]  ? __this_cpu_preempt_check+0x20/0x30=0D
[   31.196026]  ? xfs_vm_writepages+0x123/0x1c0=0D
[   31.196298]  ? __pfx_lock_release+0x10/0x10=0D
[   31.196561]  ? do_raw_spin_lock+0x132/0x2a0=0D
[   31.196824]  ? __pfx_do_raw_spin_lock+0x10/0x10=0D
[   31.197117]  ? __kasan_check_read+0x15/0x20=0D
[   31.197381]  iomap_writepages+0x5b/0xc0=0D
[   31.197626]  xfs_vm_writepages+0x13c/0x1c0=0D
[   31.197885]  ? __pfx_xfs_vm_writepages+0x10/0x10=0D
[   31.198189]  ? lock_release+0x3f8/0x7d0=0D
[   31.198429]  ? __pfx_rcu_read_lock_sched_held+0x10/0x10=0D
[   31.198752]  ? write_comp_data+0x2f/0x90=0D
[   31.199021]  ? __pfx_xfs_vm_writepages+0x10/0x10=0D
[   31.199310]  do_writepages+0x1c5/0x690=0D
[   31.199550]  ? __pfx_do_writepages+0x10/0x10=0D
[   31.199816]  ? do_raw_spin_unlock+0x154/0x230=0D
[   31.200096]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.200393]  ? wbc_attach_and_unlock_inode+0x585/0x8f0=0D
[   31.200714]  filemap_fdatawrite_wbc+0x163/0x1d0=0D
[   31.201005]  __filemap_fdatawrite_range+0xc9/0x100=0D
[   31.201305]  ? __pfx___filemap_fdatawrite_range+0x10/0x10=0D
[   31.201651]  ? write_comp_data+0x2f/0x90=0D
[   31.201908]  filemap_write_and_wait_range.part.72+0x93/0x100=0D
[   31.202264]  filemap_write_and_wait_range+0x48/0x60=0D
[   31.202575]  __iomap_dio_rw+0x65e/0x1c80=0D
[   31.202819]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.203131]  ? timestamp_truncate+0x1ee/0x2f0=0D
[   31.203424]  ? __pfx___iomap_dio_rw+0x10/0x10=0D
[   31.203697]  ? write_comp_data+0x2f/0x90=0D
[   31.203952]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.204251]  ? write_comp_data+0x2f/0x90=0D
[   31.204537]  iomap_dio_rw+0x4d/0xb0=0D
[   31.204765]  xfs_file_dio_write_aligned+0x1e9/0x450=0D
[   31.205077]  ? __pfx_xfs_file_dio_write_aligned+0x10/0x10=0D
[   31.205412]  ? lock_is_held_type+0xe6/0x140=0D
[   31.205676]  ? write_comp_data+0x2f/0x90=0D
[   31.205932]  xfs_file_write_iter+0x530/0x750=0D
[   31.206208]  ? __sanitizer_cov_trace_pc+0x25/0x60=0D
[   31.206513]  vfs_write+0xa65/0xe60=0D
[   31.206736]  ? __pfx_vfs_write+0x10/0x10=0D
[   31.206999]  ? __fget_files+0x270/0x400=0D
[   31.207259]  ? write_comp_data+0x2f/0x90=0D
[   31.207515]  ksys_write+0x143/0x280=0D
[   31.207742]  ? __pfx_ksys_write+0x10/0x10=0D
[   31.208013]  __x64_sys_write+0x7c/0xc0=0D
[   31.208248]  ? syscall_enter_from_user_mode+0x51/0x60=0D
[   31.208561]  do_syscall_64+0x3b/0x90=0D
[   31.208791]  entry_SYSCALL_64_after_hwframe+0x72/0xdc=0D
[   31.209103] RIP: 0033:0x7fd846f5b59d=0D
[   31.209324] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48=0D
[   31.210373] RSP: 002b:00007fd840a13e98 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001=0D
[   31.210814] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd846f=
5b59d=0D
[   31.211248] RDX: 0000000000001400 RSI: 0000000020000000 RDI: 00000000000=
00005=0D
[   31.211663] RBP: 00007fd840a13ec0 R08: 0000000000000005 R09: 00000000000=
00000=0D
[   31.212077] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc9b8=
97cce=0D
[   31.212491] R13: 00007ffc9b897ccf R14: 00007ffc9b897d60 R15: 00007fd840a=
14700=0D
[   31.212929]  </TASK>=0D
[   31.213072] irq event stamp: 995=0D
[   31.213269] hardirqs last  enabled at (1003): [<ffffffff813dd0a1>] __up_=
console_sem+0x91/0xb0=0D
[   31.213769] hardirqs last disabled at (1010): [<ffffffff813dd086>] __up_=
console_sem+0x76/0xb0=0D
[   31.214272] softirqs last  enabled at (286): [<ffffffff8536af3f>] __do_s=
oftirq+0x53f/0x836=0D
[   31.214754] softirqs last disabled at (211): [<ffffffff812498b0>] irq_ex=
it_rcu+0x100/0x140=0D
[   31.215258] ---[ end trace 0000000000000000 ]---=0D
[   31.215986] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.216597] XFS (loop0): Unmount and run xfs_repair=0D
[   31.216885] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.217268] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.217728] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.218192] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.218649] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.219141] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.219605] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.220070] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.220527] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.221554] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.222550] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.223191] XFS (loop0): Unmount and run xfs_repair=0D
[   31.223481] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.223861] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.224328] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.224788] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.225250] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.225706] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.226172] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.226630] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.227111] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.227668] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.228625] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.229231] XFS (loop0): Unmount and run xfs_repair=0D
[   31.229520] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.229900] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.230362] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.230821] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.231313] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.231774] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.232239] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.232701] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.233163] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.233854] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.234460] XFS (loop0): Unmount and run xfs_repair=0D
[   31.234747] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.235216] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.235678] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.236144] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.236608] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.237069] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.237530] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.237988] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.238448] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.239158] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.239761] XFS (loop0): Unmount and run xfs_repair=0D
[   31.240055] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.240435] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.240897] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.241363] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.241822] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.242285] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.242742] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.243228] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.243684] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.244365] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.244963] XFS (loop0): Unmount and run xfs_repair=0D
[   31.245259] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.245636] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.246104] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.246561] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.247044] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.247506] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.247962] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.248428] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.248886] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.249565] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.250169] XFS (loop0): Unmount and run xfs_repair=0D
[   31.250458] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.250837] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.251323] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.251785] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.252246] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.252704] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.253162] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.253622] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.254080] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.254754] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.255382] XFS (loop0): Unmount and run xfs_repair=0D
[   31.255673] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.256060] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.256518] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.256980] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.257446] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.257907] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.258370] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.258830] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.259312] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.259991] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.260598] XFS (loop0): Unmount and run xfs_repair=0D
[   31.260885] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.261268] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.261726] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.262187] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.262643] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.263133] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.263590] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.264048] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.264508] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.265180] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.265780] XFS (loop0): Unmount and run xfs_repair=0D
[   31.266071] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.266450] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.266931] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.267395] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.267854] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.268317] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.268778] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.269241] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.269704] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.270381] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.271015] XFS (loop0): Unmount and run xfs_repair=0D
[   31.271303] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.271684] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.272144] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.272599] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.273060] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.273519] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.273976] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.274440] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.274926] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.275604] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.276207] XFS (loop0): Unmount and run xfs_repair=0D
[   31.276496] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.276877] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.277339] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.277796] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.278260] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.278716] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.279204] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.279663] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.280124] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.280802] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.281405] XFS (loop0): Unmount and run xfs_repair=0D
[   31.281692] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.282078] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.282535] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.283020] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.283481] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.283942] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.284404] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.284866] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.285333] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.286014] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.286612] XFS (loop0): Unmount and run xfs_repair=0D
[   31.286921] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.287307] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.287768] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.288231] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.288691] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.289165] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.289622] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.290086] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.290543] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.291233] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.291834] XFS (loop0): Unmount and run xfs_repair=0D
[   31.292125] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.292505] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.292964] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.293425] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.293885] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.294347] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.294805] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.295292] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.295753] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.296427] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.297028] XFS (loop0): Unmount and run xfs_repair=0D
[   31.297315] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.297692] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.298156] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.298618] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.299106] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.299570] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.300035] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.300493] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.300950] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.301648] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.302249] XFS (loop0): Unmount and run xfs_repair=0D
[   31.302537] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.302942] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.303408] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.303871] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.304333] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.304794] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.305258] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.305717] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.306178] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.306849] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.307481] XFS (loop0): Unmount and run xfs_repair=0D
[   31.307772] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.308159] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.308620] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.309084] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.309546] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.310008] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.310469] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.310953] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.311415] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.312099] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.312702] XFS (loop0): Unmount and run xfs_repair=0D
[   31.312992] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.313377] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.313840] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.314306] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.314765] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.315254] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.315714] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.316179] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.316642] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.317343] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.317942] XFS (loop0): Unmount and run xfs_repair=0D
[   31.318234] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.318615] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.319107] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.319569] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.320034] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.320493] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.320951] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.321416] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.321877] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.322553] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.323181] XFS (loop0): Unmount and run xfs_repair=0D
[   31.323471] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.323849] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.324309] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.324767] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.325230] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.325688] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.326147] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.326606] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.327091] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.331926] XFS (loop0): Unmounting Filesystem e4654a66-62e5-4963-a81e-0=
12d9d4871af=0D
[   31.681043] loop0: detected capacity change from 0 to 65536=0D
[   31.683844] XFS (loop0): Mounting V5 Filesystem e4654a66-62e5-4963-a81e-=
012d9d4871af=0D
[   31.692652] XFS (loop0): Ending clean mount=0D
[   31.708173] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.708807] XFS (loop0): Unmount and run xfs_repair=0D
[   31.709096] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.709465] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.709913] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.710361] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.710807] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.711287] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.711736] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.712185] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.712633] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.713101] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.714089] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.714677] XFS (loop0): Unmount and run xfs_repair=0D
[   31.715272] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.715645] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.716095] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.716542] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.716988] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.717439] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.717888] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.718343] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.718791] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.719274] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.723025] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.723624] XFS (loop0): Unmount and run xfs_repair=0D
[   31.723906] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.724286] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.724734] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.725184] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.725631] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.726083] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.726531] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.727001] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.727453] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.727922] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.729456] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.730053] XFS (loop0): Unmount and run xfs_repair=0D
[   31.730335] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.730704] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.731207] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.731655] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.732105] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.732554] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.733002] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.733457] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.733904] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.734371] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.736018] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.736607] XFS (loop0): Unmount and run xfs_repair=0D
[   31.736888] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.737263] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.737714] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.738165] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.738613] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.739081] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.739527] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.739975] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.740423] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.740886] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.741864] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.742459] XFS (loop0): Unmount and run xfs_repair=0D
[   31.742741] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.743140] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.743590] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.744040] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.744487] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.744933] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.745384] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.745836] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.746288] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.746748] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.749551] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.750147] XFS (loop0): Unmount and run xfs_repair=0D
[   31.750426] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.750799] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.751302] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.751751] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.752202] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.752651] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.753104] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.753550] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.753998] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.754459] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.755737] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.756331] XFS (loop0): Unmount and run xfs_repair=0D
[   31.756612] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.756985] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.757437] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.757886] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.758337] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.758785] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.759283] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.759732] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.760185] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.760869] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.763062] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.763651] XFS (loop0): Unmount and run xfs_repair=0D
[   31.763932] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.764303] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.764751] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.765201] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.765648] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.766100] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.766547] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.767052] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.767500] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.767959] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.769085] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.769692] XFS (loop0): Unmount and run xfs_repair=0D
[   31.769989] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.770374] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.770833] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.771319] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.771778] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.772241] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.772701] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.773163] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.773622] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.774105] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   31.775092] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.775704] XFS (loop0): Unmount and run xfs_repair=0D
[   31.775992] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.776386] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.776847] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.777311] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.777768] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.778231] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.778688] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.779212] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.779676] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.785509] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.786127] XFS (loop0): Unmount and run xfs_repair=0D
[   31.786417] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.786806] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.787290] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.787752] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.788214] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.788675] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.789139] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.789600] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.790063] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.790807] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.791445] XFS (loop0): Unmount and run xfs_repair=0D
[   31.791742] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.792127] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.792587] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.793051] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.793512] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.793970] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.794433] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.794910] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.795382] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.796080] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.796683] XFS (loop0): Unmount and run xfs_repair=0D
[   31.796972] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.797358] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.797821] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.798287] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.798750] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.799243] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.799704] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.800169] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.800627] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.801316] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.801918] XFS (loop0): Unmount and run xfs_repair=0D
[   31.802211] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.802592] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.803121] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.803580] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.804042] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.804499] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.804955] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.805418] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.805878] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.806714] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.807686] XFS (loop0): Unmount and run xfs_repair=0D
[   31.807974] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.808358] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.808817] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.809277] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.809733] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.810193] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.810646] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.811128] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.811586] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.812424] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.813024] XFS (loop0): Unmount and run xfs_repair=0D
[   31.813310] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.813687] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.814149] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.814603] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.815084] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.815542] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.815999] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.816463] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.816919] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.817603] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.818205] XFS (loop0): Unmount and run xfs_repair=0D
[   31.818491] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.818868] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.819379] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.819835] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.820296] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.820755] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.821218] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.821674] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.822137] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.822818] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.823448] XFS (loop0): Unmount and run xfs_repair=0D
[   31.823739] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.824136] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.824613] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.825077] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.825528] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.825977] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.826432] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.826896] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.827351] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.828032] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.828620] XFS (loop0): Unmount and run xfs_repair=0D
[   31.828901] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.829277] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.829727] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.830180] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.830628] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.831109] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.831561] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.832010] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.832464] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.833133] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.833720] XFS (loop0): Unmount and run xfs_repair=0D
[   31.834001] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.834376] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.834823] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.835297] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.835744] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.836195] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.836645] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.837100] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.837550] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.838215] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.838804] XFS (loop0): Unmount and run xfs_repair=0D
[   31.839112] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.839481] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.839932] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.840384] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.840836] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.841287] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.841739] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.842191] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.842638] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.843333] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.843924] XFS (loop0): Unmount and run xfs_repair=0D
[   31.844209] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.844579] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.845030] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.845480] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.845928] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.846378] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.846827] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.847301] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.847751] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.848418] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.849008] XFS (loop0): Unmount and run xfs_repair=0D
[   31.849293] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.849667] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.850121] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.850571] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.851046] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.851497] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.851948] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.852404] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.852854] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.853517] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.854107] XFS (loop0): Unmount and run xfs_repair=0D
[   31.854389] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.854760] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.855233] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.855685] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.856134] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.856583] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.857033] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.857483] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.857932] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.858593] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.859203] XFS (loop0): Unmount and run xfs_repair=0D
[   31.859490] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.859863] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.860316] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.860763] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.861217] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.861667] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.862121] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.862570] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.863035] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.863702] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.864294] XFS (loop0): Unmount and run xfs_repair=0D
[   31.864575] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.864945] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.865398] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.865845] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.866300] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.866749] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.867222] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.867671] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.868125] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.868784] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.869377] XFS (loop0): Unmount and run xfs_repair=0D
[   31.869658] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.870032] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.870482] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.870951] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.871408] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.871858] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.872311] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.872759] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.873210] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.873871] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.874461] XFS (loop0): Unmount and run xfs_repair=0D
[   31.874743] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.875142] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.875590] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.876045] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.876498] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.876946] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.877397] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.877849] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.878302] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.878993] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.879586] XFS (loop0): Unmount and run xfs_repair=0D
[   31.879868] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.880244] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.880693] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.881145] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.881596] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.882049] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.882501] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.882977] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.883429] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.884103] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.884693] XFS (loop0): Unmount and run xfs_repair=0D
[   31.884973] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.885347] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.885796] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.886248] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.886697] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.887172] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.887619] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.888070] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.888519] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.889181] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.889770] XFS (loop0): Unmount and run xfs_repair=0D
[   31.890055] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.890425] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.890873] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.891361] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.891808] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.892262] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.892710] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.893164] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.893612] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.894278] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   31.894867] XFS (loop0): Unmount and run xfs_repair=0D
[   31.895173] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   31.895549] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   31.895995] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   31.896452] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   31.896902] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   31.897357] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   31.897808] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.898261] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   31.898712] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   31.903648] XFS (loop0): Unmounting Filesystem e4654a66-62e5-4963-a81e-0=
12d9d4871af=0D
[   32.246269] loop0: detected capacity change from 0 to 65536=0D
[   32.248114] XFS (loop0): Mounting V5 Filesystem e4654a66-62e5-4963-a81e-=
012d9d4871af=0D
[   32.253613] XFS (loop0): Ending clean mount=0D
[   32.275988] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.276634] XFS (loop0): Unmount and run xfs_repair=0D
[   32.276916] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.277288] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.277743] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.278201] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.278650] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.279177] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.279626] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.280079] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.280529] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.282499] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   32.283492] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.284127] XFS (loop0): Unmount and run xfs_repair=0D
[   32.284426] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.284805] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.285264] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.285723] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.286186] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.286642] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.287165] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.287624] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.288085] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.288556] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   32.289538] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.290136] XFS (loop0): Unmount and run xfs_repair=0D
[   32.290419] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.290803] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.291317] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.291770] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.292224] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.292675] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.293130] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.293581] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.294033] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.296193] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   32.297307] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.297904] XFS (loop0): Unmount and run xfs_repair=0D
[   32.298193] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.298575] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.299059] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.299513] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.299963] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.300418] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.300872] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.301322] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.301773] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.303902] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   32.304992] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.305598] XFS (loop0): Unmount and run xfs_repair=0D
[   32.305885] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.306274] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.306730] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.307243] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.307695] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.308151] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.308602] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.309055] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.309517] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.311485] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   32.312426] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.313017] XFS (loop0): Unmount and run xfs_repair=0D
[   32.313306] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.313691] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.314146] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.314598] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.315124] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.315577] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.316030] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.316482] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.316933] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.322979] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   32.331497] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.332107] XFS (loop0): Unmount and run xfs_repair=0D
[   32.332392] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.332764] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.333216] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.333665] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.334118] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.334567] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.335083] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.335538] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.335989] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.336565] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   32.337674] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.338274] XFS (loop0): Unmount and run xfs_repair=0D
[   32.338557] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.338949] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.339403] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.339856] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.340308] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.340755] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.341207] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.341654] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.342107] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.342577] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   32.343631] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.344243] XFS (loop0): Unmount and run xfs_repair=0D
[   32.344542] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.344920] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.345380] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.345835] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.346296] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.346756] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.347247] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.347705] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.348164] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.348627] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   32.349560] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.350203] XFS (loop0): Unmount and run xfs_repair=0D
[   32.350493] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.350908] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.351374] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.351834] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.352292] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.352752] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.353216] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.353671] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.354133] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.354610] XFS (loop0): metadata I/O error in "xfs_btree_read_buf_block=
.constprop.29+0x216/0x3a0" at daddr 0x4 len 2 error 74=0D
[   32.355611] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.356225] XFS (loop0): Unmount and run xfs_repair=0D
[   32.356516] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.356907] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.357367] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.357827] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.358284] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.358740] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.359263] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.359724] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.360188] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.360957] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.361561] XFS (loop0): Unmount and run xfs_repair=0D
[   32.361847] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.362232] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.362688] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.363169] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.363628] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.364088] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.364548] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.365006] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.365471] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.366198] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.366795] XFS (loop0): Unmount and run xfs_repair=0D
[   32.367109] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.367489] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.367947] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.368407] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.368867] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.369328] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.369788] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.370251] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.370707] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.371437] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.372038] XFS (loop0): Unmount and run xfs_repair=0D
[   32.372326] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.372706] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.373167] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.373626] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.374085] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.374541] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.375024] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.375487] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.375945] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.376659] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.377261] XFS (loop0): Unmount and run xfs_repair=0D
[   32.377548] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.377929] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.378390] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.378847] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.379330] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.379789] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.380248] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.380709] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.381173] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.381892] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.382490] XFS (loop0): Unmount and run xfs_repair=0D
[   32.382776] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.383180] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.383639] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.384103] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.384563] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.385023] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.385484] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.385943] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.386401] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.387325] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.387963] XFS (loop0): Unmount and run xfs_repair=0D
[   32.388258] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.388638] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.389102] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.389558] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.390013] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.390472] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.390959] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.391423] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.391884] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.392605] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.393235] XFS (loop0): Unmount and run xfs_repair=0D
[   32.393525] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.393902] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.394363] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.394819] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.395307] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.395769] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.396231] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.396689] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.397151] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.397876] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.398475] XFS (loop0): Unmount and run xfs_repair=0D
[   32.398763] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.399263] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.399724] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.400188] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.400645] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D
[   32.401106] 00000040: 00 00 00 40 00 00 3f c0 00 00 00 00 00 00 00 00  .=
..@..?.........=0D
[   32.401563] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.402024] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1f  .=
...............=0D
[   32.402487] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .=
...............=0D
[   32.403233] XFS (loop0): Metadata CRC error detected at xfs_allocbt_read=
_verify+0x33/0x320, xfs_bnobt block 0x4 =0D
[   32.403854] XFS (loop0): Unmount and run xfs_repair=0D
[   32.404164] XFS (loop0): First 128 bytes of corrupted metadata buffer:=
=0D
[   32.404542] 00000000: 41 42 33 42 00 00 00 02 ff ff ff ff ff ff ff ff  A=
B3B............=0D
[   32.404999] 00000010: 00 00 00 00 00 00 00 04 00 00 00 01 00 00 00 10  .=
...............=0D
[   32.405461] 00000020: e4 65 4a 66 62 e5 49 63 a8 1e 01 2d 9d 48 71 af  .=
eJfb.Ic...-.Hq.=0D
[   32.405918] 00000030: 00 00 00 00 6b 5f 31 7a 00 00 00 16 00 00 00 0a  .=
...k_1z........=0D

--5DqPYnvrX9NSYHIs
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="bisect_info.log"

git bisect start
# status: waiting for both good and bad commits
# bad: [4ec5183ec48656cec489c49f989c508b68b518e3] Linux 6.2-rc7
git bisect bad 4ec5183ec48656cec489c49f989c508b68b518e3
# status: waiting for good commit(s), bad commit known
# good: [f40ddce88593482919761f74910f42f4b84c004b] Linux 5.11
git bisect good f40ddce88593482919761f74910f42f4b84c004b
# good: [3bad80dab94a16c9b7991105e3bffd5fe5957e9a] Merge tag 'char-misc-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good 3bad80dab94a16c9b7991105e3bffd5fe5957e9a
# good: [c2e75634cbe368065f140dd30bf8b1a0355158fd] net: atm: bring back zatm uAPI
git bisect good c2e75634cbe368065f140dd30bf8b1a0355158fd
# good: [70442fc54e6889a2a77f0e9554e8188a1557f00e] Merge tag 'x86_mm_for_v6.1_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 70442fc54e6889a2a77f0e9554e8188a1557f00e
# good: [a594533df0f6ca391da003f43d53b336a2d23ffa] Merge tag 'drm-next-2022-12-13' of git://anongit.freedesktop.org/drm/drm
git bisect good a594533df0f6ca391da003f43d53b336a2d23ffa
# bad: [0948a9ef1d59d1bc7fae29f32058e463bbff4a6c] Merge branches 'acpi-resource' and 'acpi-video'
git bisect bad 0948a9ef1d59d1bc7fae29f32058e463bbff4a6c
# good: [7c4a6309e27f411743817fe74a832ec2d2798a4b] ipvs: fix type warning in do_div() on 32 bit
git bisect good 7c4a6309e27f411743817fe74a832ec2d2798a4b
# good: [7e68dd7d07a28faa2e6574dd6b9dbd90cdeaae91] Merge tag 'net-next-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect good 7e68dd7d07a28faa2e6574dd6b9dbd90cdeaae91
# good: [c7020e1b346d5840e93b58cc4f2c67fc645d8df9] Merge tag 'pci-v6.2-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect good c7020e1b346d5840e93b58cc4f2c67fc645d8df9
# bad: [93761c93e9da28d8a020777cee2a84133082b477] Merge tag 'apparmor-pr-2022-12-14' of git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
git bisect bad 93761c93e9da28d8a020777cee2a84133082b477
# good: [6c013679eb5c7e0b09cbcb64276f6dd97b473d12] dt-bindings: crypto: Let STM32 define Ux500 CRYP
git bisect good 6c013679eb5c7e0b09cbcb64276f6dd97b473d12
# bad: [ad76bf1ff18e059d64b70047940d298641d4cc2f] Merge tag 'memblock-v6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
git bisect bad ad76bf1ff18e059d64b70047940d298641d4cc2f
# bad: [7dd73802f97d2a1602b1cf5c1d6623fb08cb15c5] Merge tag 'xfs-iomap-stale-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-6.2-mergeB
git bisect bad 7dd73802f97d2a1602b1cf5c1d6623fb08cb15c5
# good: [bd5ab5f9874109586cbae5bc98e1f9ff574627e2] xfs: don't warn about files that are exactly s_maxbytes long
git bisect good bd5ab5f9874109586cbae5bc98e1f9ff574627e2
# good: [64c80dfd04d1dd2ecf550542c8f3f41b54b20207] xfs: Print XFS UUID on mount and umount events.
git bisect good 64c80dfd04d1dd2ecf550542c8f3f41b54b20207
# good: [f43dc4dc3eff028b5ddddd99f3a66c5a6bdd4e78] iomap: buffered write failure should not truncate the page cache
git bisect good f43dc4dc3eff028b5ddddd99f3a66c5a6bdd4e78
# bad: [304a68b9c63bbfc1f6e159d68e8892fc54a06067] xfs: use iomap_valid method to detect stale cached iomaps
git bisect bad 304a68b9c63bbfc1f6e159d68e8892fc54a06067
# bad: [d7b64041164ca177170191d2ad775da074ab2926] iomap: write iomap validity checks
git bisect bad d7b64041164ca177170191d2ad775da074ab2926
# bad: [7348b322332d8602a4133f0b861334ea021b134a] xfs: xfs_bmap_punch_delalloc_range() should take a byte range
git bisect bad 7348b322332d8602a4133f0b861334ea021b134a
# first bad commit: [7348b322332d8602a4133f0b861334ea021b134a] xfs: xfs_bmap_punch_delalloc_range() should take a byte range
|0207_211056|/root/bzimage_bisect/make_bz.sh -k /root/linux -m 4ec5183ec48656cec489c49f989c508b68b518e3 -b 7348b322332d8602a4133f0b861334ea021b134a -d /home/bzimage -o /tmp/kernel -f /home/bzimage/bzImage_4ec5183ec48656cec489c49f989c508b68b518e3_7348b322332d8602a4133f0b861334ea021b134a_revert|
|0207_215613|/root/image/centos8_3.img -> /root/image/centos8_2.img|
|0207_215646|Run /home/bzimage/bzImage_4ec5183ec48656cec489c49f989c508b68b518e3_7348b322332d8602a4133f0b861334ea021b134a_revert with image:/root/image/centos8_2.img in local port:10022|
|0207_215711|CMD=ssh -o ConnectTimeout=1 -o 'StrictHostKeyChecking no' -p 10022 localhost 'rm -rf file*'|
|0207_215711|CMD=scp -o 'StrictHostKeyChecking no' -P 10022 /root/bzimage_bisect/repro.sh root@localhost:/root/repro.sh|
|0207_215713|CMD=scp -o 'StrictHostKeyChecking no' -P 10022 /root/syzkaller/workdir/crashes/38cabe64007a1d91d47fcd0aeacd3da4531a50ed/repro.cprog root@localhost:/root/repro.c|
|0207_215715|CMD=ssh -o ConnectTimeout=1 -o 'StrictHostKeyChecking no' -p 10022 localhost 'ls /root/repro.sh'|
|0207_215946|/home/bzimage/bzImage_4ec5183ec48656cec489c49f989c508b68b518e3_7348b322332d8602a4133f0b861334ea021b134a_revert didn't contain xfs_bmapi_convert_delalloc: in dmesg, pass|
|0207_215946|Bisect successfully! 4ec5183ec48656cec489c49f989c508b68b518e3_7348b322332d8602a4133f0b861334ea021b134a_revert bzimage passed!|

--5DqPYnvrX9NSYHIs--
