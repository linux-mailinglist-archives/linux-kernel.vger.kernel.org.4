Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B6464D51A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiLOBuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLOBut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:50:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA0520188
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671069047; x=1702605047;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9gd0N3tha9JNgGG+1KMWUxumhwkhAnd2aK/cOZ05PCE=;
  b=IovM5gHAvupNyxPR3IkkcAr9xqDgoV+92Ue0iG0IRexnv0qT5iC1FWfv
   9ltHeOjNkceyOzdu48RyoAWgdAdl2MWfiq5FHJ9VtM9tVZ5192K7lmga4
   KchWmvAMQFQgQMuBmVT3mKzXvHNezeWtIhziidO9rDSSKnRlZ42BN35S0
   saAtNGT+0N/ZO63DNgBwTCsbNuJpFyJEA+orEkBfH1fD7+Mh2GBVajYCM
   fPhtbpBuZeFJ2BIuq2q4MbvZygDEZYbX7VByre5v9lknHX3pLRd/jGr5u
   ue2mUL/BCgifkSXCPHceUjMMA/ssoNrSpK/0Bp9uEShhb7qwNnfkgon1W
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="345645237"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="345645237"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:50:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="773536821"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="773536821"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 14 Dec 2022 17:50:44 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 17:50:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 14 Dec 2022 17:50:43 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 14 Dec 2022 17:50:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNscAS7ZIxctf09kxVwKlxFe4X7sqeludZKAnyDmA/oOn3RiBwWRoj/1uDyJTduDyvOnZbo6doMpfiL+HDwZxE19LnTvkxfX0ROWsyN0AlXbz+jwexdcK2oHCUl3XbhP2fBoVkrj3+92Ay2hY5eoK0N7qX9t2dWrHY18MzfNmVVPS6+V9gQsJB2yfeSkcAWScVcAWRHCLtZwV8eDKKIazmbh1aaWCuMs5+CJy3DCpXhlN09KYrE4fleMK4asVWwQpxayxaXGGZI11fG0oTSGlaTeGtAhLhYdbbqPNKVrWYrjQPh7Wzv7RdyqMOlx4E9+iK5mtnL+YHWujIuXOU63Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kKD30n7KnKw6idehQ0Zqu2hbs/vYw9miwtzgF5ifJc=;
 b=FsqiodZ5oitjMyA2I23DOry+/VjyHwg5zRWWqjP5wKO9uG4bxqSfBL+OHVTBeuJT0r5hBFDGUbf+D9Hg+GWz2DD2iDCkTcPrw8HZbdI6KZrcq0oXiximk1NN/695e4sigcVsXdvA9Bp4yoBCAv8iQPfRpLihJ456OLadrtqX1Ok/7Y90xk/MqpSSjzCBfi03/168UD6ft9o+08JcNCx0RgfuhdvVjDvHj8U49pAytKJ+joTsAPFKVobxRX83vVT6VGgBfVVKJfaAf66C0PoMtZwCd3sm0/J0MPCnpybGQGFNandMkD7S9luihEviJD7WZ4vmxnuDvF+JC3QKUFCK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW4PR11MB7104.namprd11.prod.outlook.com (2603:10b6:303:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 01:50:41 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::226c:31ef:73cb:3a28]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::226c:31ef:73cb:3a28%4]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 01:50:41 +0000
Date:   Thu, 15 Dec 2022 09:51:21 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>,
        <linux-mm@kvack.org>
Subject: Re: [Syzkaller & bisect] There is "copy_page_range WARNING" in
 v6.1-rc8 and v6.1
Message-ID: <Y5p9mfUz9OMJpPFS@xpf.sh.intel.com>
References: <Y5l871w6bwDnJ9HD@xpf.sh.intel.com>
 <Y5npmXzUx4FD12Rp@x1n>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y5npmXzUx4FD12Rp@x1n>
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW4PR11MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 412d5dfb-c434-4bbe-b263-08dade3ec598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V51FEeKn13yZTYC6Cb/6ZgsHYD6tvZgcNa6ZP5BC44jt6LpSOdj2wsX4EURPxKDoiSwOMDrzobMfVMgb3yACf9DeSimIs7uDJwSGPCYWAi9O5JpeI69pKeND/89ipB6/vNwPf1zOoXI9luPdiqpwzf3NB+b0z10Aq47/5ptmvjqQ2vQvJgb/79rE07ZorODKzSjtpR3a3t/bu2gdugU+mOjW3BSW3NVI9jGr28RnmOuZKdjm+4GKDFYdv/a5MNfDqPd55zm3f5uDJ+Srs9f629tCOnm/3FcrADARdusr25PbHRmzmWnAlBzePfcaJ9btlJ1c6knLJ015ChpYc8hcwcQnDSlMtMZx2lqq8cbCbC9H9D+gggFA8t+Rimm8Dl8uylzDaLQBnV5PFvlwNdEKlYn+C3QZ8xjPFD0yhF/y3/DQDLCAT67gCfqy18HerrGyZhHc4No7YoZ/fM3p9x54s8qKKQm80ixYBB+4qTTIDVlk0qTwjKY8nv2wqvU+QD0IfLYT6w0Iy+fuEWvEN1GvxyG6VF4D3T/o1l1Pzm1sDecnFHNdtocKTCUxSvW0u9Ka0PtX0WYqYPvQkfV1bk1hoWqQ3cwxQYAjvupU4keOE6S0prazaQmFiAec9x4UbCzrhWlh5JnVxY1Ifhdc6rylnwhkDaLsirrssqGVzocjRUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(86362001)(83380400001)(6506007)(966005)(6916009)(316002)(6486002)(6512007)(186003)(53546011)(45080400002)(26005)(478600001)(2906002)(41300700001)(8936002)(44832011)(4001150100001)(5660300002)(4326008)(66476007)(82960400001)(8676002)(66556008)(66946007)(6666004)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?78qQ67PhmWhU4Y9agLDVIulAqsxzJr0XLU9ni0Nu/vuOTdOs4TrrRhkovcpv?=
 =?us-ascii?Q?bI0s4ImxbpdvjRRl9uXwbrtZ4otSOA9kNlnmNSoHqZXixvS5Kf/1DLpjMPpM?=
 =?us-ascii?Q?QmrUArg/OEBv3fWe/GQc/nq9eCCRa3PKbGFClZHiZWPlVCqy24LTLIoG99Oz?=
 =?us-ascii?Q?LDbhAqHVM5n2wLl5NHa3PJ1ZBFd8Ha3hxDVu3fzWffZ0LAEKeyXABcnsFEbm?=
 =?us-ascii?Q?TPpUK8pocp5yWt2WQyuZjQxEOMPtRy2doIv+p76mLbW+o0jH208pTloV10Yw?=
 =?us-ascii?Q?Ix6RIIAN6VwbDvWzg5cSJ+vytQU7FUR5rRUSL3gPSk8+NIj/CJq4jL0hqDTc?=
 =?us-ascii?Q?MLD4N0XGIjJylfhIigq2k5aerjJ2hgjzkwj14BOlWpYuUsDuX2OwWxl51WOu?=
 =?us-ascii?Q?UVfeXGusStBLB5tPIfAGOuLJ/WkNBtq1jWH7r4KjeU3hcUA1VLft4G4jzlEh?=
 =?us-ascii?Q?V0qSHmHAig+iBp766yMlsd1XXuEuILbllO084YejKETC0BlQzbXJh7b0Yvav?=
 =?us-ascii?Q?mWJo1e8aW1wZ9KQtHxgJkyhdvlGvFhbXksp7E1dqY4NUfY66kboORyU7/WOT?=
 =?us-ascii?Q?4XiGdIkWZA9dRM9PVkuFoBEjlsocSkPHuQt+t/dY9MXk+Uja9LxyvF6Vv6QV?=
 =?us-ascii?Q?IZlaiIitT6KvsGWCeLnhXbLnLOP1QpE2w0OzRcMsW7UMk2G7pR8Jm9iE6RNN?=
 =?us-ascii?Q?oI8y2gZ4jCFjb1ScWLvo7Ay65IaSx/qRYHK1ww5FQ8XU4LBKA2IdapykuY42?=
 =?us-ascii?Q?aqqgE9uPiqqA+WJe35fUce9wdlsZ7bBHUTd79GI05JSix8/C9K3aalHU9B74?=
 =?us-ascii?Q?LwS3uQwgJqCupdE+75vJJYtfNacBCJFPYOFI8ZbqPmy3nEDQiWbibWDXnNrH?=
 =?us-ascii?Q?2ws4F3hbPLEF0P5kx/gQkJpG53my12vzrL8Ykag3P49YvrsoyqwiZ9SsN9df?=
 =?us-ascii?Q?3yefek6tD1EFiO5LGSrW5KPNWU4rTPA7UYBWn7vtfqjG4PYVU703TxZU4Uu6?=
 =?us-ascii?Q?MF9SD33ovb2Fl7O3ikJhFOseOu4VnX68bGaxcuZ9hHSJRImVF5x8ULoxN1Ng?=
 =?us-ascii?Q?jWzaEtir2Bdtlwzkw8SKp6jRis8rlptZcxzw3gXRJAozvPea5/Lgmsq7e2yU?=
 =?us-ascii?Q?pGELtP2YIFbufnXpY6V5LtVZopUK6xPGBDvhEA21SvsjamgiRkqxK7DCkjVP?=
 =?us-ascii?Q?ZFFpCIZTHmshyz20UFKXoE81O6TTAzSnhxw4UnO5BpdlbjhqXDXk7UrBznGL?=
 =?us-ascii?Q?kqZi/cdAiVBdsDJNZ9X2AClRuQrhtBU19zn0kOxCWNFIO+MhBHoyKOcz2mg0?=
 =?us-ascii?Q?nd2xlsPGnbal2C+owFgerXM2AJbPDXwFkb+lYImQsovdT/6g3iHMFr5NebXv?=
 =?us-ascii?Q?S6SYZR6be87nPKOcvmz8mYrWXWrKXBiH69dMWoLeLKCWb18ZAo/CjXY0Boxj?=
 =?us-ascii?Q?MJo7lV7V1CzeDdQnLa+HF/BvBrM0YYeRP3j5e/q6U1HH7V9s/CJqClpfza/r?=
 =?us-ascii?Q?FGl6fw11eB9VzIgAeI+3RdaOyhsmGU2pQiHSf0jEDpNtXzzyOk3746G2MCAn?=
 =?us-ascii?Q?uCu2EUFoyYAy5bOSZVwbCuIX3+KumHMStIIYn00Ag5eE9IWflWtgOquK+cAP?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 412d5dfb-c434-4bbe-b263-08dade3ec598
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 01:50:41.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36XRKOYYO6JHPrwQp+TJuou1rn7JQGiSuR1OxauOTg7kjXICgd3ipVC5Fa0S1F5XBqj8Z44cX1kIXXrtpnyM5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7104
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2022-12-14 at 10:19:53 -0500, Peter Xu wrote:
> On Wed, Dec 14, 2022 at 03:36:15PM +0800, Pengfei Xu wrote:
> > Hi Peter and memory expert,
> 
> Pengfei,
> 
> > 
> > It's a soft remind.
> > There is "copy_page_range WARNING" in v6.1-rc8 and v6.1.
> > [   28.138268] ------------[ cut here ]------------
> > [   28.138277] WARNING: CPU: 1 PID: 568 at mm/memory.c:874 copy_page_range+0x1858/0x2960
> > [   28.139002] Modules linked in:
> > [   28.139219] CPU: 1 PID: 568 Comm: repro Not tainted 5.19.0-rc1-6ff40f00e5a4+ #1
> > [   28.139706] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   28.140306] RIP: 0010:copy_page_range+0x1858/0x2960
> > [   28.140584] Code: 5b e2 ff 41 83 fc 1e 0f 85 b1 fe ff ff e8 00 5a e2 ff 31 ff 4c 89 ee e8 26 5b e2 ff 4d 85 ed 0f 85 b6 fe ff ff e8 e8 59 e2 ff <0f> 0b e9 aa 5
> > [   28.141550] RSP: 0018:ffffc90000c9baf0 EFLAGS: 00010246
> > [   28.141838] RAX: 0000000000000000 RBX: f7fffffffffffc00 RCX: ffffffff81415aba
> > [   28.142229] RDX: 0000000000000000 RSI: ffff888007e28000 RDI: 0000000000000002
> > [   28.142612] RBP: ffffc90000c9bc98 R08: 0000000000000040 R09: 0000000000000000
> > [   28.142996] R10: 0000000000000001 R11: ffffea00002ab580 R12: 000000000000001e
> > [   28.143405] R13: 0000000000000000 R14: 0000000000000004 R15: 0000000000000000
> > [   28.143905] FS:  00007f5b23733740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
> > [   28.144335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   28.144648] CR2: 00000000200000c0 CR3: 0000000007d5c005 CR4: 0000000000770ee0
> > [   28.145032] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   28.145413] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> > [   28.145791] PKRU: 55555554
> > [   28.145946] Call Trace:
> > [   28.146097]  <TASK>
> > [   28.146242]  dup_mm+0x689/0x900
> > [   28.146436]  copy_process+0x1ade/0x23e0
> > [   28.146656]  ? __sanitizer_cov_trace_pc+0x25/0x50
> > [   28.146928]  kernel_clone+0x90/0x670
> > [   28.147152]  ? userfaultfd_ioctl+0xd2/0x23c0
> > [   28.147491]  __do_sys_clone+0xa2/0xd0
> > [   28.147779]  __x64_sys_clone+0x2f/0x40
> > [   28.148023]  do_syscall_64+0x3b/0x90
> > [   28.148243]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > [   28.148538] RIP: 0033:0x7f5b2385859d
> > [   28.148749] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
> > [   28.149722] RSP: 002b:00007ffc5a2e6b58 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
> > [   28.150133] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5b2385859d
> > [   28.150555] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000001000
> > [   28.150938] RBP: 00007ffc5a2e6ba0 R08: 0000000000000000 R09: 0000000000000000
> > [   28.151340] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401060
> > [   28.151846] R13: 00007ffc5a2e6ca0 R14: 0000000000000000 R15: 0000000000000000
> > [   28.152230]  </TASK>
> > [   28.152363] ---[ end trace 0000000000000000 ]---
> > 
> > This issue could be reproduced in v6.1 kernel in guest also.
> > 
> > Bisected and found that bad commit was:
> > "
> > 81e0f15f2ef6dad7ccb9c03d8e61ef7ded836b38
> > mm: enable PTE markers by default
> > "
> > 
> > After reverted above commit on top of v6.1-rc8 kernel, this issue was gone.
> > 
> > All detailed bisect info, reproduced code and kconfig are in link:
> > https://github.com/xupengfe/syzkaller_logs/tree/main/221208_115556_copy_page_range
> > 
> > 
> > If the info was helpful and it's fixed, please added the Reported tag from me.
> 
> I think the warning was improper indeed as when without UFFD_EVENT_FORK
> registered dst_vma will not inherit VM_UFFD_WP.
> 
> This also reminded me that this can also trigger after the swapin error
> replacement using pte markers when there's the swapin error markers and if
> we fork() we may hit the same thing.
> 
> I'll post a fix soon.  Thanks for the report.

Thanks for your quick response and solution! I'm glad it's helpful.

Thanks!
BR.

> 
> -- 
> Peter Xu
> 
