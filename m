Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6646B6305
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 04:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCLDTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 22:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCLDTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 22:19:50 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4CD2A15B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 19:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678591188; x=1710127188;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F9CHm67ZvM6X4mOt77LocLQJhILwieWURLCtUGdGG4Q=;
  b=MBXl/adXfnxph62HK8yFSwEgcpeDOmRbXXpaxQWYw3bTWNiw1MFObClI
   waPNshhby/zfhY+omqzz5xaFPJUtIKd/fn8Sya6MH+q39XyxkcvH1wXFR
   PlRK1B8vU2+PZ/2UpxMHXVCSMRu+AExmVYG1p0UDay2cVmL9mzPGTarjn
   Kn/7bS0hN93JT0cbg/tQObc/qHyYZCY/RGdeiCtmDx6CSnTQKOzTqUTes
   1kN44sN+U177Vr/CViAo3mULtDZ0t5MnvrGK6FOtmRsMEz2Oa6XtN05zS
   G7EqvKcLRpriWdXbnVBjPQRulO1tAsS0mU4YnR1GMdJ1zF9a3+bVWPw2p
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="399554251"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="399554251"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 19:19:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="680619558"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="680619558"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 11 Mar 2023 19:19:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 11 Mar 2023 19:19:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sat, 11 Mar 2023 19:19:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sat, 11 Mar 2023 19:19:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nriDLpisJliB7aqB2T7/a4947dePfRzUzLyE9YElI6wBrBgQP/6dAaBBq6q8gdNN6NPTtVD9UJKnUjg2w5/hp7ybL5lZTNnZLWXyLEw6oBisnPAU+13c4aIqPEt+Q8Z9UlD0KChgTMhzjupgE0kGb765FVqnDvfINgfki/VzzTOMVJHQQAjRBJrQsPvUGbvTRt+JPWtXRgIQOz5Qn8y2q0r4biumrs6idvDTVCzhQfFANoAdRNYJeoBEqBBbXCTvvqSPooWvI1+35YryQ0Cz6Pi7hiDiwN+Eb14I+2aBG/lbo3GrfFhfr1yteJ+4AXsnk8HrA44esfHYp7WGoLsTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2W09xqFGbfmMzlo3ggpQQEUMiPrN8EDUVWkhsiSwQE=;
 b=lHP5M3gVugQb6M9OaxFCmDy8TN2VRR3BPV2WK2LOwkMtjivBnL2l0PqBfpaFd87SCJgbstUD9yR10kxyrH1rr8kcGqnppAAbQbnfISN3SdCU0c7/KuHGEpqmALeBTJaeIYQIqnJoHYVlWWKN/pw2N1bfKcrRek6Ph5FMNZyPb5NfQ7RD5BuBdwWiR579PZxMZQvao4XjpWctYAAti89ETEI5WD7TS0MEoaGzyr30+SRNWYt4tYGUfoKDacUnZbIbDnINLEQJ3nEl3LlfpDe3/EUYb1x1wiUJhJq0lzdFAKN++0pQ7QW/bXeYJxOAlfS9Aqa3ld883+C25113dS0SnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Sun, 12 Mar
 2023 03:19:44 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239%7]) with mapi id 15.20.6178.019; Sun, 12 Mar 2023
 03:19:44 +0000
Date:   Sun, 12 Mar 2023 11:21:04 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <dchinner@redhat.com>
CC:     <djwong@kernel.org>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is BUG: soft lockup in __cleanup_mnt in
 v6.3-rc1 kernel
Message-ID: <ZA1FIM2hG/ePMHYR@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH8PR11MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8ef9bd-a6dd-4fcc-0b11-08db22a89ff7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lyYe0HuU/J06NrmS1G2QcJkAFs6jpBV8WWKA2gFSG019oaOhakPgfye2CuxS01M5XTz+tzSSCz1KIFS3TwHcTVnqQNzmZI85uNlnT0uulTzio/qYKCH5KeTsMTrwnmB5dbf8QglIoo1DGqadtpGLohfZSMFg+uZIkhv+4cay52bRZboDRb/DVuoj1fLyebBdI9IQn7HmL2MW7g5ArCVp6de+YHDpOkwcNWfOfgB8EBZhbyVvaOmyhKEmfIbJNzfmYfFr9gfzfrfsIyV3ulZLd4ldZSBt0OXd5sMOak7Q44Pe2F/Nb0/VG43Bi/FoKgG9l2UaK21pRgUzcVKItfXQk9KjZzMy+pWG8Vzhn7CNWCyBdlE0PQr9fZIIv0jTrKadwRHCyHbIrIh4WK+E7kmY90pSKWJbZLWTadK1HssDdU9AQJ8cuv3BRrW738QQTFOHyT6qI9Oz/n2RDp03XrGqIhww/55+UjQ+/5RcIgf47ZbCMtsB2f4Sh5fvWG36ioPpItSyiTIxSQ2ECD4gMb11Sz6jqlrGVWqiXp8FETYMvR9NIlmXvVcmy0aP3H6vLhin50OM1IHyVS9Nn8SabeGzYDOIAksp8TqSc5rQftShk3ZDXaSjAphz9THVJ1s4olfdnM0th0bO7T7H2whH8lNA+II3dJsbQ5uQy5WqcLTsCr8SqJnWSASlXsaobMr9lOLUn49l4ELGKUnIg2Fl4aOqI/0o/u3NYjxTZg4ktulwC+IjsPtLfOKC9rUYkpAcGoax
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199018)(45080400002)(26005)(5660300002)(6486002)(186003)(316002)(478600001)(66476007)(4326008)(44832011)(8676002)(8936002)(66946007)(6916009)(107886003)(966005)(41300700001)(2906002)(66556008)(30864003)(38100700002)(86362001)(82960400001)(6506007)(83380400001)(6666004)(6512007)(21314003)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V7b2ZuSOzfE1Q40D5Ig6ReK4Xfk0VtMi0g5VW/WmKJCtAfO88kyDEADzgRdm?=
 =?us-ascii?Q?E82+Hwpw0niCKaX3tMZTnqu9I7X3UIzYLe1uo57C/svZL+vHF4am/czPkLGa?=
 =?us-ascii?Q?VScnrCo9BNFxySHHsiyDFa+klPq3zCvzjqDb1qV8oTVxtunuiGajBQ8h2exb?=
 =?us-ascii?Q?4hRn+m79SEDldNXheAniuBG5cYAEDC2N+AgS/Mp8Dgx3/JsL4pmSE6EzeV2e?=
 =?us-ascii?Q?illnh1W8Ycc1a/VbAyc6FzXIkFvQBsQH+vMHDNQ792vpMRVu0MVAjrCbz5/l?=
 =?us-ascii?Q?xeZ+30n5IgMlWjavhDb57DUwsmA4YvmnzqJ/4l1OWSbfpGV+EtxWVPxrEXF6?=
 =?us-ascii?Q?uheNLsOG8I20IZBGurKQKpRP5RzDSv10LY5ru9hEDgM34i1WQnzxbjbzxC1n?=
 =?us-ascii?Q?pWw8FMT6/Yk3SvjH4SHHkUwGs90s9fbbqCafhXqeRQOzhBMCuHW+vkF/Mvzk?=
 =?us-ascii?Q?DNwFyIrVFvdeAWjuNmu54zXSOFRtqRSU41o2XQEg3DOjLOGsLznoc39fEzaL?=
 =?us-ascii?Q?Z2WnfMBd9d1JMy3FeZopkVzU/I6oM41rBJlpg98Ui1mHKqYgQ0JWja/FlW9o?=
 =?us-ascii?Q?G6y3xWAcCeboA2icwdQVCQazPiekBbKzb5Y5Q6t6VPCUtZ5u2o65hpWluWxC?=
 =?us-ascii?Q?tFcX9QGjm+8rKqf+GoFHpdp+iFbcCWd853/Nfg+JVzJNK2OOHMckt7EHw4qZ?=
 =?us-ascii?Q?RJOYHq+TH+qjaAX7FHuqWgLF8fdGaAYgVecFGHMDyj4Uhg77eXnoUUmkd+VB?=
 =?us-ascii?Q?VoxT+0KVIF5QWrIiRPyGzFpr78xjLL0nzbWl5zhc7/dXxA2AFY5Dco2vL0d5?=
 =?us-ascii?Q?aCQcHjdyh1fxJ5+9fuq406i9vBOEXNbkurt8SowfX4coSoxeLX/u7gv7NA9r?=
 =?us-ascii?Q?CPrS8Ku7kadgbeQReS+pNS0jfOn6poGM1W2MJjZToEAbZoCSacOAbDVTQUII?=
 =?us-ascii?Q?lsw2vLsHZK981FQNU66t6ikpoVyqPx5xE/pg2CNDbYUUoGYy718uVPrXbFcy?=
 =?us-ascii?Q?fBcu2exc8ORHI2DXuwfc7ClfvKDB1myGVK1Fvk/lFSiTbWQ7xle5334ohTzv?=
 =?us-ascii?Q?f0utndLodIhS+JqBT+5b+3n7bAt9kNWBMSQ3V/4NiXSMvC/w8nokbQgOCZwF?=
 =?us-ascii?Q?wMF9KBltOXU8+xdopQ2ZpRU18J6grEJ4sIfwZZ0ZHHBLtF2TGiSOAwMCPDkA?=
 =?us-ascii?Q?coBGHZtfaVyK1KcblSdMSS+eLOkPk1dVZGL3gDw83wBt8TF/7Z+EV/v4iRjt?=
 =?us-ascii?Q?A/TvDAhEbWilwTqh/fd5xzPT+btFfmT2m/8zwnrPZwr2TMdO3siEJMlfVI5f?=
 =?us-ascii?Q?byx1xXDmx6jEbhEPlrKKEsRT3WiTmvIDE4kPMjWidIEcozwQUMz/X8GlLV8Q?=
 =?us-ascii?Q?S4yXVRBtkZ4mc5X/C0hHKTxz7pJGbXtl4/o834MOYgHVrV6qd7uI0VCkDVak?=
 =?us-ascii?Q?u3NtfYe8B2zZei/EfORQAYPLVioviBtOphddil/DuwOWbPm55GmgxmjdxsnJ?=
 =?us-ascii?Q?C5dwd2K+jEQE9VVrvrbl3nBUVPxDrgUdX63PTXksRUOFXGyr9VmMt6hrvN7C?=
 =?us-ascii?Q?EwuA1tdJAzQ2KnvSmzCebdUKL6Nqr/qwPmJEsHJ5f13gSTnaPcvFWma0jFi6?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8ef9bd-a6dd-4fcc-0b11-08db22a89ff7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 03:19:43.8393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3NP6GALJGMNU+K9k51tK8k+oxDi+PfMXYhc8qmYsGvCy0Aa4J76FFq3IuFkqNzP5JXIDoaW5kxck4HsN6LBYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave Chinner and kernel expert,

Greeting!

Platform: x86 platforms

There is BUG: soft lockup in __cleanup_mnt in v6.3-rc1 kernel.
All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230311_022102___cleanup_mnt
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/repro.c
v6.3-rc1 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/fe15c26ee26efa11741a7b632e9f23b01aca4cc6_dmesg.log
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/bisect_info.log

"
[   28.803497] XFS (loop0): Corruption of in-memory data (0x8) detected at _xfs_buf_ioapply+0x67d/0x690 (fs/xfs/xfs_buf.c:1553).  Shutting down filesystem.
[   28.804766] XFS (loop0): Please unmount the filesystem and rectify the problem(s)
[   56.372468] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [repro:523]
[   56.372847] Modules linked in:
[   56.372985] irq event stamp: 22822
[   56.373141] hardirqs last  enabled at (22821): [<ffffffff8300086e>] irqentry_exit+0x3e/0xa0
[   56.373512] hardirqs last disabled at (22822): [<ffffffff82ffe853>] sysvec_apic_timer_interrupt+0x13/0xe0
[   56.373923] softirqs last  enabled at (9032): [<ffffffff83023a3c>] __do_softirq+0x31c/0x49c
[   56.374276] softirqs last disabled at (8975): [<ffffffff8112b5a4>] irq_exit_rcu+0xc4/0x100
[   56.374623] CPU: 1 PID: 523 Comm: repro Not tainted 6.3.0-rc1-fe15c26ee26e+ #1
[   56.374924] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   56.375386] RIP: 0010:rcu_read_lock_sched_held+0x4b/0x80
[   56.375621] Code: 8d 7d f7 e8 c7 fe ff ff 84 c0 74 19 0f b6 45 f7 48 8b 4d f8 65 48 33 0c 25 28 00 00 00 75 38 c9 c3 cc cc cc cc be ff ff ff ff <48> c7 c7 20 3e f6 83 e8 89 ec de 01 89 c2 b8 01 00 00 00 85 d2 75
[   56.376376] RSP: 0018:ffffc9000102fbe0 EFLAGS: 00000246
[   56.376597] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   56.376891] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
[   56.377192] RBP: ffffc9000102fbf0 R08: 0000000000000001 R09: 0000000000000000
[   56.377486] R10: ffff88800d01d418 R11: 0000000000000000 R12: ffff88800b0d1158
[   56.377780] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   56.378082] FS:  00007fc887d10740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   56.378414] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.378655] CR2: 00007faaae519018 CR3: 000000000d3e2004 CR4: 0000000000770ee0
[   56.378950] PKRU: 55555554
[   56.379069] Call Trace:
[   56.379178]  <TASK>
[   56.379276]  lock_acquire+0x2ad/0x320
[   56.379444]  ? lock_release+0x141/0x2e0
[   56.379615]  ? write_comp_data+0x2f/0x90
[   56.379799]  _raw_spin_lock+0x36/0x50
[   56.379962]  ? xfs_ail_push_all_sync+0x73/0x110
[   56.380169]  xfs_ail_push_all_sync+0x73/0x110
[   56.380360]  ? __pfx_autoremove_wake_function+0x10/0x10
[   56.380591]  xfs_reclaim_inodes+0xb8/0x140
[   56.380779]  xfs_unmount_flush_inodes+0x63/0x80
[   56.380987]  xfs_unmountfs+0x69/0x1f0
[   56.381152]  xfs_fs_put_super+0x5a/0x120
[   56.381331]  ? __pfx_xfs_fs_put_super+0x10/0x10
[   56.381534]  generic_shutdown_super+0xac/0x240
[   56.381740]  kill_block_super+0x43/0x80
[   56.381917]  deactivate_locked_super+0x52/0xb0
[   56.382112]  deactivate_super+0xb3/0xd0
[   56.382282]  cleanup_mnt+0x15e/0x1e0
[   56.382451]  __cleanup_mnt+0x1f/0x30
[   56.382613]  task_work_run+0xb6/0x120
[   56.382783]  exit_to_user_mode_prepare+0x200/0x210
[   56.383000]  syscall_exit_to_user_mode+0x2d/0x60
[   56.383205]  do_syscall_64+0x4a/0x90
[   56.383368]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   56.383593] RIP: 0033:0x7fc887e3c7db
[   56.383751] Code: 96 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 96 0c 00 f7 d8 64 89 01 48
[   56.384500] RSP: 002b:00007ffc1a5bd1e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
[   56.384815] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fc887e3c7db
[   56.385114] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc1a5bd290
[   56.385407] RBP: 00007ffc1a5be2d0 R08: 0000000001d0a333 R09: 0000000000000009
[   56.385700] R10: 0000000000404071 R11: 0000000000000206 R12: 00000000004012c0
[   56.385994] R13: 00007ffc1a5be410 R14: 0000000000000000 R15: 0000000000000000
[   56.386299]  </TASK>
[   56.386400] Kernel panic - not syncing: softlockup: hung tasks
[   56.386643] CPU: 1 PID: 523 Comm: repro Tainted: G             L     6.3.0-rc1-fe15c26ee26e+ #1
[   56.387000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   56.387461] Call Trace:
[   56.387569]  <IRQ>
[   56.387662]  dump_stack_lvl+0xa9/0x110
[   56.387834]  dump_stack+0x19/0x20
[   56.387980]  panic+0x4fd/0x520
[   56.388119]  ? watchdog_timer_fn+0x31e/0x390
[   56.388315]  watchdog_timer_fn+0x337/0x390
[   56.388497]  ? __pfx_watchdog_timer_fn+0x10/0x10
[   56.388710]  __hrtimer_run_queues+0x2ed/0x820
[   56.388924]  hrtimer_interrupt+0x134/0x2d0
[   56.389111]  __sysvec_apic_timer_interrupt+0x9c/0x290
[   56.389331]  sysvec_apic_timer_interrupt+0xab/0xe0
[   56.389535]  </IRQ>
[   56.389628]  <TASK>
[   56.389722]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[   56.389940] RIP: 0010:rcu_read_lock_sched_held+0x4b/0x80
[   56.390166] Code: 8d 7d f7 e8 c7 fe ff ff 84 c0 74 19 0f b6 45 f7 48 8b 4d f8 65 48 33 0c 25 28 00 00 00 75 38 c9 c3 cc cc cc cc be ff ff ff ff <48> c7 c7 20 3e f6 83 e8 89 ec de 01 89 c2 b8 01 00 00 00 85 d2 75
[   56.390909] RSP: 0018:ffffc9000102fbe0 EFLAGS: 00000246
[   56.391129] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   56.391422] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
[   56.391715] RBP: ffffc9000102fbf0 R08: 0000000000000001 R09: 0000000000000000
[   56.392009] R10: ffff88800d01d418 R11: 0000000000000000 R12: ffff88800b0d1158
[   56.392303] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   56.392607]  lock_acquire+0x2ad/0x320
[   56.392773]  ? lock_release+0x141/0x2e0
[   56.392941]  ? write_comp_data+0x2f/0x90
[   56.393122]  _raw_spin_lock+0x36/0x50
[   56.393285]  ? xfs_ail_push_all_sync+0x73/0x110
[   56.393483]  xfs_ail_push_all_sync+0x73/0x110
[   56.393672]  ? __pfx_autoremove_wake_function+0x10/0x10
[   56.393900]  xfs_reclaim_inodes+0xb8/0x140
[   56.394087]  xfs_unmount_flush_inodes+0x63/0x80
[   56.394285]  xfs_unmountfs+0x69/0x1f0
[   56.394450]  xfs_fs_put_super+0x5a/0x120
[   56.394627]  ? __pfx_xfs_fs_put_super+0x10/0x10
[   56.394829]  generic_shutdown_super+0xac/0x240
[   56.395030]  kill_block_super+0x43/0x80
[   56.395207]  deactivate_locked_super+0x52/0xb0
[   56.395403]  deactivate_super+0xb3/0xd0
[   56.395574]  cleanup_mnt+0x15e/0x1e0
[   56.395739]  __cleanup_mnt+0x1f/0x30
[   56.395902]  task_work_run+0xb6/0x120
[   56.396071]  exit_to_user_mode_prepare+0x200/0x210
[   56.396282]  syscall_exit_to_user_mode+0x2d/0x60
[   56.396487]  do_syscall_64+0x4a/0x90
[   56.396648]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   56.396865] RIP: 0033:0x7fc887e3c7db
[   56.397020] Code: 96 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 96 0c 00 f7 d8 64 89 01 48
[   56.397761] RSP: 002b:00007ffc1a5bd1e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
[   56.398072] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fc887e3c7db
[   56.398365] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc1a5bd290
[   56.398658] RBP: 00007ffc1a5be2d0 R08: 0000000001d0a333 R09: 0000000000000009
[   56.398951] R10: 0000000000404071 R11: 0000000000000206 R12: 00000000004012c0
[   56.399244] R13: 00007ffc1a5be410 R14: 0000000000000000 R15: 0000000000000000
[   56.399546]  </TASK>
[   56.399792] Kernel Offset: disabled
[   56.399972] ---[ end Kernel panic - not syncing: softlockup: hung tasks ]---
"

I used the key word "__cleanup_mnt" to bisect, I knew there was other BUG
info in dmesg with "bisect good" commit log.

Anyway, just provided the bad commit and hope it's helpful:
"
bd4f5d09cc93c8ca51e4efea86ac90a4bb553d6e
xfs: refactor the filestreams allocator pick functions
"
It's just a suspected commit, reverted above commit on top of v6.3-rc1 and
no "__cleanup_mnt" related BUG but generated the other BUG info in dmesg.

There was no this issue report yet in syzbot:
https://syzkaller.appspot.com/upstream

I tried that, installed the xfs fixed patch for below issue on top of v6.3-rc1:
https://lore.kernel.org/lkml/20230226223403.GU360264@dread.disaster.area/
"__cleanup_mnt" BUG issue still existed.
Related dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230311_022102___cleanup_mnt/v6.3-rc1_xfs_patch_another_cleanup_mnt_issue.log
So it should be different than previous xfs related issue.

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
   // You could change the bzImage_xxx as you want
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


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

Thanks!
BR.
