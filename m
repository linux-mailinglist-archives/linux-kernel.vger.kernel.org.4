Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C024769DC36
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjBUIi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbjBUIit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:38:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D33234EC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676968721; x=1708504721;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Uq/rh3bi+yALcTBOPQ7a188AUNRR9Phf57mwHQuPm20=;
  b=CEJ0n5zb+Q+DO5poBiECbzAHUMFL75WICTM40C0jxXLRbcrL5usSIQhV
   czwhEQyLvFYfqp/c8p6q2E95v7eiVn4VZngV0YFRN/egRAMgKc1dMl6zB
   TVLXfsgtxkKM4LvxG55Sz7PC+ER4+0bsIT4DhRFU700NXeADoW7MLo4TT
   sIhmkjSWSDnwXCeQydYl2u81Hd4CY3QjyDFVkGLqRpP2wl+ou2gwE33gB
   Wq85VWdMMuWrRkzqJxBABtDZSxB8wjAfr8BZl316sIBCNiXlHAPB/pc9A
   CWx3s+idGMnbiSeIiNf7kAHpdUTOEFZsMpZ/SA2OIRh/7GaZ1bpgwoD5h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="312947265"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="312947265"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 00:36:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="735375812"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="735375812"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2023 00:36:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 00:36:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 00:36:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 00:36:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU0R323k640WQLF/ZgFjzxGcMaiuy56XtqZjFff2Iy1qmJc2GUJqL8kvPF01MAsmqhvEqMbj7JFXj/cqRFAAIIDwTlVymyMINvg2zaOtCXzTQOX/yr7cZERCiVPSujiFAuC8WeQSZgcU66SUDR81aj0qVrrssCxt96PgwbLZoA7YihqMPBNv5L46cEX6fqbXe6/nEzeBFGnZejARsbfv3t+rlcFBQcS47R9uFfNOJAdEb6f8YyqY8UvP7NHrpG5j54ETMSQcnSapeTNxRDv29nX7bmD9VdalI57bBF2sPjgbVqUtxcKZt2VCpZsvguK/Fby/ACiJdj2W7KoJ1NMe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REi53EEhCAXb7TTYTWzNxXdMiTqZw7LRzdMEC+EnYvw=;
 b=UiKbt4DlfPTf3BVWUuriJC2D+qON5p03iGlfLBVtonH0bO6jgcgzm15ojAYD1o1k1KBKDUqc32KVeJS33SP0AiLd2c33ZMa6eZjZvHLfxhLcxd+7nxjxvFQx6tZzO5HLRr2FDnQIOObNSuyC2/1mcn5Fk7oFrekriLVjUGW+gGoiQ+JtEyN/S8/Vi3NIjPVukSe7ME5asmncoU+CiaUhiFgV0iH2s7g22ApBV5D20sCdwD6U70fZTymQ/5fRGb0Tg/aSNrgRq+pd44DaDaWbhDi7x3XLj2dgnL13ByBmuxXO9cQfaLjEHXBT7VDMVfutub4UumycTPI8MLqQazB5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by CO1PR11MB4834.namprd11.prod.outlook.com (2603:10b6:303:90::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 08:36:10 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::1d7e:20c1:f7b6:dcaa]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::1d7e:20c1:f7b6:dcaa%9]) with mapi id 15.20.6111.020; Tue, 21 Feb 2023
 08:36:10 +0000
Date:   Tue, 21 Feb 2023 16:37:21 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>,
        <pengfei.xu@intel.com>
Subject: [Syzkaller & bisect] There is "_copy_from_iter" WARNING in v6.2
 kernel in guest
Message-ID: <Y/SCwXhIgbuD2mSK@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To SA2PR11MB4844.namprd11.prod.outlook.com
 (2603:10b6:806:f9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4844:EE_|CO1PR11MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3c4dae-031c-46a8-e28b-08db13e6aed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37m0SV7Dr41edcX9IFzHI6sdNSVPgk5LP6vJw4OTb8C+knxJ+i2mEKT0aTJMYYm/+ecXQj8DZD7Wgj0TpkKBACE4H2Zxy1va1yr3UF3/HzSapRg5jRFR8ZaUEW59YgpiaxvklIcd0siO9j7fCEresSAXqab/t6Q85T/AEie5/zjkpNYW4MwgG8d7HTlpxNfANR33ZO2bUjYcoST4RCHkSggEZyvK0aHLHpX714TQ1hdeq8oVqdeuCy+oeYcrJRc4RSWKzoNkwgP6XTUis66mBMpidQ2Hxhi2HivU6sv8N826Sxyc6y1yhkj/MwPveyavH07/1ZmPhIkWDvr5Fe4v0lTHzv8Cxcxi5ywoNWYjnOBBvWyP7CkcKoP1xFiB1d8OAOWjUHwgKPFaQYI1XWANmfYGyGURwlnXc/kstkeqYiDwofV7a0e+wDjd9MSHnl+rJVgcnsVhJV3beXno+h77zj0CZKLT1RUQJPYJyLi1W+gOJZHMwPgBd7go8LgYkS2NXsEDn+BHBojEwfe7M86nfo5VSbqXtrJCgj4ZGeNX9A49oa9dbQVv31evCsJRn+e6jlgADOyFC7DRIvaVCt9MOFVM+WP+YCeDov2EXqURk9XCJBf6UCmrqk1dUTy5/wSk/ZtJnxL0k0iwYtoa3VnQhMs0xJp9j05KsAkmBneG1hQoa7krupnBhUIBdx51po41Cz05j9GjQZRP3daminUxqWWXrZ54mHVSphRL4HTlzuYGUR1nZGFUOhJlZQLnIsH3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199018)(86362001)(44832011)(5660300002)(41300700001)(2906002)(8936002)(82960400001)(38100700002)(83380400001)(478600001)(45080400002)(66476007)(66946007)(66556008)(6916009)(8676002)(6486002)(966005)(316002)(186003)(26005)(6512007)(4326008)(6506007)(107886003)(6666004)(21314003)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p5EkEacQBnXJgNgY3ZiqfokbRDs5KwmhinafAocMeYgQHjOHzZHFjq1opwg3?=
 =?us-ascii?Q?GafQrKyO1wkg+PtArlOkz02EJo0CBcgdRpmBtDQ6edskIcugQZJBU7e8JxXo?=
 =?us-ascii?Q?/eWj4cY9jjV1fb7R4Oyx7KJOO+J7JyAOJnANH9z6BEiBQv7sl/YTqoBWySmh?=
 =?us-ascii?Q?hSmYCl+s954LtZ3XJDIk9SARq9HgabsrOkTb6kdutZzmY08U51P6tXvFY1ps?=
 =?us-ascii?Q?XNU30tBqS+f4shoP/A23o80rTQudDK0Vd4gEnGo1ywhABEri/DfIJ8VKo2yC?=
 =?us-ascii?Q?v5gIEPxHPEKJDQRVallGl75C9E+0lHFC/K5ezvDK2Oe1QTg149AfYwhGd2YV?=
 =?us-ascii?Q?KD70UzeXQz6yMmc5Zm6y7BEVmBFCNTIzuHOf/SuiByXDzbQpfY00H2cAVksX?=
 =?us-ascii?Q?YpmB0LJoOW5UmswculpDZzNQ47+HuGD6lmBqqda0e+wn6sONVJr2ZvPbw7qZ?=
 =?us-ascii?Q?F+OQT3sRnbOAKLpkq4W5T/ofeOds2/CUz8KEv6NLYI80slL8gO3FPnRh0mjN?=
 =?us-ascii?Q?wRGNL2q4/v7RJL1F4mqLUZRvGO8iTiuE8yG5EZ2uW48Dn14MEcYxWr/UZDYK?=
 =?us-ascii?Q?s9lH55M/TH+h2EYySTA8xForeB7yDmej4BdNHtyPbgjLEIc4Oded8cVjdzUJ?=
 =?us-ascii?Q?r9LCiQSnQvKmFu04xtvDcnEY/0EV0gdZouCfM6SoOl/Ff+gFw9oJExYPzkSY?=
 =?us-ascii?Q?2tsjf9nZe4BuHv3hbEK66f0M9Fg2hZ9wnCaDpMD1W2jyr5njFN13B+usEBs1?=
 =?us-ascii?Q?ogurWAVFBAjoSqqWNnn96XVwHc/KsdAWimXCdsAmDy69sRgV6GHfMb21Oklc?=
 =?us-ascii?Q?PocljPQV9QYQQMjqjCySofkZiwZ4M0oD7JF1yoa3NkqA1k97pWdAfyLh/KwL?=
 =?us-ascii?Q?Zc+vTOp0l2HZXRgxtPrqwG+WR9LsXEhzy6ocOP4Q8HInHVar/nOI0Xfk2GWN?=
 =?us-ascii?Q?ndxrnO70ywb8ujtWDPC787szWvpOpYhHUeNjvEkRE77aQHjWwDwMecE9assZ?=
 =?us-ascii?Q?/x42IGc6BLKGXm9Yu0z4K6uvWFaDqROC61T7rbFGdIdf9eTT0jiYeZMx3duL?=
 =?us-ascii?Q?mB+gzdcmA4gwP67bvN/Nb5XDRZpR/xqZgLcqS22axOujGNEq/FGBZJ6623B8?=
 =?us-ascii?Q?PiT1p3qhixJt27x/3qKAAYhV3Z5SjJvYaKYjnNZcOYdnsO6wFSxdaMkR85Ex?=
 =?us-ascii?Q?K3NMzuM6YfQne/5mi+hKE1jthhbFIwaDIAjZkO87+1n8BkN6Bm+KERJWUbl2?=
 =?us-ascii?Q?7AA8P3s7MKFU0kZFNvWHXdH4tEdpqhm+0lQKzbNoWr7VYXx6F8p0p1Xs6A2J?=
 =?us-ascii?Q?MUYc2POCXOs6xbYEcf/PSFw3Y8+9Xuv+yTZKbGxOVdvA3rb6PbagIHfHFV67?=
 =?us-ascii?Q?mSJ2zuZg+SfEapQhcYh+TaZxUoQGbDBstxVmjjir+RyqPk92IyLgcuONTOCM?=
 =?us-ascii?Q?Mr72/pNj4Ktb9+C2Vf/j6gehIyCGUJb2fAn6O2PO5QEPWg1w4L8jCREgKqs2?=
 =?us-ascii?Q?nz/8W7U4cp7LEUB2wCvuZ1M3BFfZhZBEpl17Y6+w0SVkGJM1xmJkNjXVSl3o?=
 =?us-ascii?Q?TB8JyGzWutKh6b80u+vP2MGAjh6dSymJhLh61Sv7bB0hLjZxptn+eKk0vMlg?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3c4dae-031c-46a8-e28b-08db13e6aed7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 08:36:10.1721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kp+BWSd0O05i4Jlqj2G/p+wRww/38Une1DLECiCVS4X2qMuM7LKOCb3f19KOj4BzU2N6mt8rz6vSsKnEGIBPfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4834
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al Viro,

Greeting!

It's a soft remind, there is "_copy_from_iter" WARNING in v6.2 guest as follow.
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230220_162054__copy_from_iter/repro.c
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230220_162054__copy_from_iter/kconfig_origin
v6.2 problem dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230220_162054__copy_from_iter/c9c3395d5e3dcc6daee66c6908354d47bf98cb0c_dmesg.log
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230220_162054__copy_from_iter/bisect_info.log

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230220_162054__copy_from_iter

[   28.628154] ------------[ cut here ]------------
[   28.628394] WARNING: CPU: 0 PID: 550 at lib/iov_iter.c:629 _copy_from_iter+0x130/0xa60
[   28.628778] Modules linked in:
[   28.628940] CPU: 0 PID: 550 Comm: repro Not tainted 6.2.0-c9c3395d5e3d #1
[   28.629300] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   28.629849] RIP: 0010:_copy_from_iter+0x130/0xa60
[   28.630090] Code: 41 5e 41 5f 5d c3 cc cc cc cc e8 2b e6 57 ff be 79 02 00 00 48 c7 c7 4d f3 92 83 e8 ca ec 79 ff e9 3f ff ff ff e8 10 e6 57 ff <0f> 0b 31 db 5
[   28.630968] RSP: 0018:ffffc900010079a8 EFLAGS: 00010246
[   28.631234] RAX: 0000000000000000 RBX: 00000000000000c3 RCX: ffffffff81d43a43
[   28.631584] RDX: 0000000000000000 RSI: ffff88800c4f8000 RDI: 0000000000000002
[   28.631932] RBP: ffffc90001007a38 R08: 0000000000000000 R09: 000000000000ffff
[   28.632278] R10: ffffc90001007c28 R11: 0000000000000000 R12: ffffc90001007af0
[   28.632623] R13: 0000000000000000 R14: ffffea0000314200 R15: 0000000000000000
[   28.632971] FS:  00007f264dd6b740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   28.633377] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.633662] CR2: 0000000020000041 CR3: 000000000a360004 CR4: 0000000000770ef0
[   28.634030] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   28.634377] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   28.634725] PKRU: 55555554
[   28.634868] Call Trace:
[   28.634996]  <TASK>
[   28.635113]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   28.635356]  ? bio_add_hw_page+0x234/0x2e0
[   28.635576]  ? write_comp_data+0x2f/0x90
[   28.635782]  copy_page_from_iter+0x1aa/0x370
[   28.636001]  ? write_comp_data+0x2f/0x90
[   28.636211]  blk_rq_map_user_iov+0x531/0xa70
[   28.636446]  blk_rq_map_user+0x86/0xc0
[   28.636645]  blk_rq_map_user_io+0xbe/0xd0
[   28.636855]  sg_common_write.isra.22+0x5fd/0xb10
[   28.637113]  sg_new_write.isra.23+0x24d/0x460
[   28.637342]  ? __this_cpu_preempt_check+0x20/0x30
[   28.637589]  ? lock_is_held_type+0xe6/0x140
[   28.637815]  ? write_comp_data+0x2f/0x90
[   28.638017]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   28.638258]  ? scsi_block_when_processing_errors+0x152/0x190
[   28.638547]  ? write_comp_data+0x2f/0x90
[   28.638752]  sg_ioctl+0xc2f/0x1340
[   28.638934]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   28.639175]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   28.639414]  ? write_comp_data+0x2f/0x90
[   28.639620]  __x64_sys_ioctl+0x10e/0x160
[   28.639824]  ? __pfx_sg_ioctl+0x10/0x10
[   28.640025]  do_syscall_64+0x3b/0x90
[   28.640321]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   28.640839] RIP: 0033:0x7f264de9059d
[   28.641073] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
[   28.641990] RSP: 002b:00007fff4573c498 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[   28.642432] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f264de9059d
[   28.642843] RDX: 0000000020000240 RSI: 0000000000002285 RDI: 0000000000000003
[   28.643217] RBP: 00007fff4573c4b0 R08: 002367732f766564 R09: 00007fff4573c590
[   28.643607] R10: 000000000000001f R11: 0000000000000202 R12: 00000000004010a0
[   28.644018] R13: 00007fff4573c590 R14: 0000000000000000 R15: 0000000000000000
[   28.644372]  </TASK>
[   28.644489] irq event stamp: 4933
[   28.644660] hardirqs last  enabled at (4941): [<ffffffff811d4a61>] __up_console_sem+0x91/0xb0
[   28.645094] hardirqs last disabled at (4950): [<ffffffff811d4a46>] __up_console_sem+0x76/0xb0
[   28.645514] softirqs last  enabled at (4850): [<ffffffff82f9c233>] __do_softirq+0x323/0x48a
[   28.645924] softirqs last disabled at (4845): [<ffffffff81123152>] irq_exit_rcu+0xd2/0x100
[   28.646327] ---[ end trace 0000000000000000 ]---

Bisected and found the first bad commit is:
a41dad905e5a388f88435a517de102e9b2c8e43d
iov_iter: saner checks for attempt to copy to/from iterator
After reverted above commit on top of v6.2, this issue was gone.

I didn't saw "_copy_from_iter" problem recored in
https://syzkaller.appspot.com/upstream

And I hope it's useful.

---

If you don't need an environment to reproduce the problem or if you already
have one, please ignore the following information.

How to reproduce:
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
Please use the target kconfig and copy it to kernel_src/.config
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

Thanks!
BR.
