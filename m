Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7E065E2A6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjAEBr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjAEBrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:47:33 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66833056C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672883249; x=1704419249;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=egV0oFUq8gZV8rNPKrMZHNWIQJfAqoJryOZ3tnXA9q8=;
  b=Pvi+R59a6J+/7DA2ApSPmIiE8BdMh647czm0BfGQqM5pzdZksR8JoYZF
   ouV4jVFPXa59BzTu2pFj1nIztaCwsiStflgkAqYLGv/VvOAKAeKIL9SSn
   RHtaf7QoBLCPZKw6EXKcbCMzOiIxRImkFd2YSFh1xcs3u10n9Woou7Vqu
   I/uBw0GprUvd350cOu10R7/nGcwh7zDNIysMUq7oZ7oU2S/9TVvjerZ7I
   XRAlkFKFwbyggrKIkwxbmaG48dq2hIOKXpeplb4h+nzzOdfjbUaEgfKCf
   QlZI2h19LjvP6AFOennEYhKnL5wYpSy2bPvtyR2rBB8/c9Bw7csJbKVWD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="302462976"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="302462976"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 17:47:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="718645401"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="718645401"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2023 17:47:29 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 17:47:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 17:47:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 17:47:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJC1+nG/SaDAphQq+DWpHivEFPrv6UjSE5AvWjZE69x/vfrgQ9SQONbaFa06o4Or1OuuiPw37I3u5xIuCUP0J6RMsBUKNCLCF/YpFqaZIKduhyFobP6NkI/BD5zjJJED+KCX7/eBwtvwgnLns7xXjvN2Pz3CS2mlVosbi4ZSv5cU55VT4VATm47hwxaIP11pjhd2RqsRHon2M9DvP3voAXhttiGU2l+guNIemcYNU0tKMrpcBvnBIK7p8wCwIAZ4KO7bAXBlYPDr12XBg5VHoj5fdOow1dl8bwARCXn3F/7421yeZNcSraSwLgMi7cLyhcdr7dHG4sfArGKTbK0bUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8bHUmu91bxxtWyXNuvvb7dG3bW3+8gAamZrs5B8PMM=;
 b=GxMY/p3/5nBv0v3JO6RGVROy1eZiWTQYMJ4IltsYLMX6lxgi8RpXSVe7yqiLnpXV+f6x719RHhlRtsrTzCWp3CgP8b2b5vRbcVA3wSuBrBmZ4EV4QziWJOqeOXCVAFCeBYTe3Ae+45HXI/q3omqz9fSi3NDBAwoZOIsC9thdBrNe/WDfwkW7IQvUaI94elwcg50QBX4PCL5M835uIBA1nbWH+3uBOt0YC4cgbwJb4H0gDle/YSzx5Dy8swzUxDhSGPVpbV2yj+kFYxfjdsJZJKlogT6LrO+Zcect/XsrBHkfmr49M6VnGfvyO1QNmgc4ZcDW58FlXH/4h88ZY94gdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM4PR11MB5261.namprd11.prod.outlook.com (2603:10b6:5:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 01:47:24 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::a95:5288:9215:a267]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::a95:5288:9215:a267%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 01:47:24 +0000
Date:   Thu, 5 Jan 2023 09:48:10 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <heng.su@intel.com>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <jmaloy@redhat.com>, <kuba@kernel.org>
Subject: Re: Update bisect info and new repro code for "[syzbot] WARNING in
 _copy_from_iter"
Message-ID: <Y7YsWvQaDPm2+pS3@xpf.sh.intel.com>
References: <Y65N3pgLMsxZ99lo@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y65N3pgLMsxZ99lo@xpf.sh.intel.com>
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM4PR11MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfff17c-076d-4b7a-5f19-08daeebecad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfPAVaFz3/9Sl1up3Bs3f5Epmo5Ad6mVWdkvJwOpSEzB/bWNvcrPNMEzso1mqKHJWu+daRTCzNencmI0l/platbTXFkm0Se6CztqK27E8rUNbU+z0qnXUXIG2qYgu48HOY74SI0coeGLkcZCqJI2b5zcjs99ivibDNe8qZiZL9QR0MRjnjedqCdxMHQSSW8xX+fKag3Dfo7uzgj/ARp8EB9DcagpgZUJHt29ZEv7jx0/T1crEgdsppAeqJG8TQ1rEOvgwUvHwhIDlTFqY5dpoaDiAz6AdD2SaaIScgFA8FQok5anTxi0O5i6SD0KHn/UzSJGpLeQp5humv2KqNjdzlFjahVrdPmoXVCMz7klVt9l0NWxDtz8zCwF3Ga9I5Hp5Jjfy3z6TJ72s8RE1V3kTLy7IRR31BVCcLBCgpIPb1pPgC72p6aqt+jmZNQGyAKqEGsgOBitVK5vswOhTrxNZ9v5zpH1J39WUJwWOf4dbfNzkNYCrPVvF87d/ze56LKqnuU8i9p2YN2EjbqJUApqNXpTCqk9+UWgapUn6H7UshU+r3/NYCq/qkA7y1nqg1L5lAi6sE7t/dnLvBLRnf/rqnBLo3YH3uodQysNCGoAGlY6zG7IgLE2i3VNzGDHNvM3gUxJWofZn6Rv2dzJl2D6u5q8EAiBoajF6ZR6H+uBI15J05oUc1AJjEZV5kWD6g2/kYivUfrvUgImSNzXJSXAeEyzvZGn0NKEA3URaP0xUvV55arZncRK51jTjF+yzEg0tGmeucrkKrCXCmAYo1LO+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199015)(6666004)(6506007)(478600001)(53546011)(82960400001)(38100700002)(6512007)(26005)(186003)(6486002)(966005)(45080400002)(15650500001)(2906002)(4001150100001)(316002)(6916009)(66946007)(44832011)(8676002)(66476007)(66556008)(83380400001)(8936002)(5660300002)(4326008)(41300700001)(86362001)(99710200001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uCCYgD7oyq+GdjohiJ0VnFZk7etDewYpISAjP2XrXtmF5YKBi1mkVqB9L4nQ?=
 =?us-ascii?Q?XPeYA8FOHes5rmscbx8DRWdX+hdlesM50iF/sU+HGp4i01ZEPvPnawg2+hxX?=
 =?us-ascii?Q?WItvCNZg3jjI4qHfp+OFGyrY2P8sGkiXXg1y0fGIzXzevNz2JMJiTS95MdhM?=
 =?us-ascii?Q?bhs+9VLp6SEFA1HMepp/BGi+rDuVnqJ+H429iSzYZFBwurMxVe/tVLqfofwH?=
 =?us-ascii?Q?QvzN6xWbycbvCrtKGsWLHE9ZUxqfBn28z5R6WoZtP3lH7ZpGgP0ZkfBdKnI1?=
 =?us-ascii?Q?UpxwlXh/IX8RGoH3iFbgVXtkaSD0qwdIvZHFOjnHPBAm2+vguqS9q4RIMnBO?=
 =?us-ascii?Q?uswJi5fyU7opLvHS8A5LQZ4AW0gdwtK9l3mXYkv9Vr/j/jaebbAdRUgWorFY?=
 =?us-ascii?Q?plMynVGqV7l5BJrzt0EAPXSplXP/d/xdcQ+yrHdFAU9jHxuFLEYSCzZJr4l4?=
 =?us-ascii?Q?G/TZsGgnb9esJfiXvL6DEKjkAkrc8jHGI7vI7e0XEeOWNpnfvPxAhXc2aNSO?=
 =?us-ascii?Q?X4XlwL+aNJIJknpyPvZyPde1Bm9vp6d2+xvO7R7W32fonC6oQA0UgVt45yuA?=
 =?us-ascii?Q?aI0+BKifauiwLa3Q5YRfKsunb6MTlF8fIK84oKj3Jqmkw1wpx+o5Fo85e3DH?=
 =?us-ascii?Q?DM+0wWzwON3IdBcoyYP4MwILEjk18vsU2CZ3RbMpvmL0tvjMakf/o1rnohzM?=
 =?us-ascii?Q?gc46bRiJVmbU32GtftGNL2lF9VxZbRUnMpkAOHzGqqmEnlE4+cvuJvmUhE/I?=
 =?us-ascii?Q?7enL3/eJDEXTxuUNngmyC3dZsax7vhdlN7yqZjcmvj/PolCsqAzMiMhlptY1?=
 =?us-ascii?Q?qpb6oo9P8448kgvWNNrSC4nnxjqgaZ9cYlvV7Np3G8dMdulK4ywGHk0nhsEH?=
 =?us-ascii?Q?3dfzHrZGz4VB+yAeDhO22tv3wZmcMq2i6qpLGtPc5OiR+yImGOq3ga6nfKBJ?=
 =?us-ascii?Q?fl7WBW/m7MRQd0tXWMOo9Lp6f5d49SDqIoGbQLJDeIB3xALBzJMUFD/jEwZO?=
 =?us-ascii?Q?GjuRwK1cjvfHgrKfENzS6Lgmdi2Hn8JJNLONzTKU5ilQaHpgWcm/ycDbM3cK?=
 =?us-ascii?Q?5wHLsiT14+n+LpT2XxO8YwbFafoZbUsdfpeP4fDCxhTBJrVHMVR3BT1KxvRy?=
 =?us-ascii?Q?G0s0btqVGaDrhmwRmTWpARajCAzb9LZJ+c46m1QQIkKeWhJevP9wo+KFyAfS?=
 =?us-ascii?Q?lIKWo9xAY51a2mo7BMA6y7WYFiijV35+OVTutFrjKjeMBx5Ft4rVnkowWEP0?=
 =?us-ascii?Q?S9Fu8Af5e45aEkTMRHQj9IliQnIj36jv0+3SGZ8aKyVr2owNLRZf5btzaG6u?=
 =?us-ascii?Q?mx9Unf+HYOsmsbrghWPZBBO/oR1a1Ai+2p32LN9BYW07ZyPLdT1AxFhZSvLz?=
 =?us-ascii?Q?3IBwvwDc5YDSLGo9bu9hIiYdIHQJ2pLSaT7N2444vXcGs+t8z3TigH91v1gk?=
 =?us-ascii?Q?4hvtubsZ0M0UiqFfr/GoI529+bgRhbfqvNnNmtAyRymeO8uQy+4h3DCY01Ic?=
 =?us-ascii?Q?P/nWG027AHBmISyTx+mKv/tHTbi34CkW0Efbi2BBCzGknIS82eZUWkJIiwvz?=
 =?us-ascii?Q?gIxBEZooJMZ00jqkSemISoQj6sWZ5G7woatVno0X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfff17c-076d-4b7a-5f19-08daeebecad6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 01:47:24.4026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcCeEi0sfSgGkCsOvwjLV//tV0nuzaJeRYXIttC0efOtLp1jFB68v1XzeBsjAN/rOGcJlZ8PbeVGAumGTKfJJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5261
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viro,

It's a soft remind: "_copy_from_iter" WARNING issue was still reproduced
in v6.2-rc2 mainline kernel in guest.
"
[   29.804009] sg_write: data in/out 131036/42 bytes for SCSI command 0xff-- guessing data in;
[   29.804009]    program repro not setting count and/or reply_len properly
[   29.806580] ------------[ cut here ]------------
[   29.807212] WARNING: CPU: 0 PID: 514 at lib/iov_iter.c:629 _copy_from_iter+0x130/0xa60
[   29.808295] Modules linked in:
[   29.808742] CPU: 0 PID: 514 Comm: repro Not tainted 6.2.0-rc2-88603b6dc419 #2
[   29.809931] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   29.811422] RIP: 0010:_copy_from_iter+0x130/0xa60
[   29.812072] Code: 41 5e 41 5f 5d c3 cc cc cc cc e8 5b 16 58 ff be 79 02 00 00 48 c7 c7 3c 55 94 83 e8 5a 18 7a ff e9 3f ff ff ff e8 40 16 58 ff <0f> 0b 31 db 5
[   29.814474] RSP: 0018:ffffc90000fdf988 EFLAGS: 00010246
[   29.815182] RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffffff81d40343
[   29.816120] RDX: 0000000000000000 RSI: ffff88800dfe4680 RDI: 0000000000000002
[   29.817224] RBP: ffffc90000fdfa18 R08: ffffc90000fdfa3f R09: 000000000000ffff
[   29.818177] R10: ffffea000049bc00 R11: 0000000000000000 R12: ffffc90000fdfad0
[   29.819119] R13: 0000000000000000 R14: ffffea000049b000 R15: 0000000000000000
[   29.820057] FS:  00007f9207ab6740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   29.821161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.821945] CR2: 0000000020000041 CR3: 000000000dd8a005 CR4: 0000000000770ef0
[   29.822890] PKRU: 55555554
[   29.823270] Call Trace:
[   29.823615]  <TASK>
[   29.823924]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   29.824597]  ? bio_add_hw_page+0x234/0x2e0
[   29.825228]  ? write_comp_data+0x2f/0x90
[   29.825782]  copy_page_from_iter+0x1aa/0x370
[   29.826377]  ? write_comp_data+0x2f/0x90
[   29.826928]  blk_rq_map_user_iov+0x531/0xa70
[   29.827550]  blk_rq_map_user+0x86/0xc0
[   29.828093]  blk_rq_map_user_io+0xbe/0xd0
[   29.828665]  sg_common_write.isra.22+0x5fd/0xb10
[   29.829390]  sg_write+0x43a/0x750
[   29.829894]  ? __lock_acquire+0xa26/0x1d30
[   29.830493]  ? write_comp_data+0x2f/0x90
[   29.831038]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   29.831685]  ? security_file_permission+0x177/0x340
[   29.832365]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   29.833348]  ? write_comp_data+0x2f/0x90
[   29.834039]  vfs_write+0x1b6/0x780
[   29.834533]  ? __pfx_sg_write+0x10/0x10
[   29.835074]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   29.835716]  ? write_comp_data+0x2f/0x90
[   29.836256]  ? write_comp_data+0x2f/0x90
[   29.836816]  ksys_write+0x9f/0x170
[   29.837346]  __x64_sys_write+0x27/0x30
[   29.838001]  do_syscall_64+0x3b/0x90
[   29.838530]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   29.839266] RIP: 0033:0x7f9207bdb59d
[   29.839766] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
[   29.842219] RSP: 002b:00007ffe7ecdd768 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
[   29.843335] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9207bdb59d
[   29.844277] RDX: 0000000000000058 RSI: 0000000020000080 RDI: 0000000000000003
[   29.845273] RBP: 00007ffe7ecdd780 R08: 002367732f766564 R09: 00007ffe7ecdd860
[   29.846288] R10: 000000000000000f R11: 0000000000000213 R12: 00000000004010a0
[   29.847228] R13: 00007ffe7ecdd860 R14: 0000000000000000 R15: 0000000000000000
[   29.848182]  </TASK>
[   29.848516] irq event stamp: 4703
[   29.848970] hardirqs last  enabled at (4711): [<ffffffff811d48a1>] __up_console_sem+0x91/0xb0
[   29.850278] hardirqs last disabled at (4720): [<ffffffff811d4886>] __up_console_sem+0x76/0xb0
[   29.851409] softirqs last  enabled at (4336): [<ffffffff82f9c213>] __do_softirq+0x323/0x48a
[   29.852533] softirqs last disabled at (4213): [<ffffffff81123152>] irq_exit_rcu+0xd2/0x100
[   29.853659] ---[ end trace 0000000000000000 ]---
"
Bisected and found that the bad commit is as below:
a41dad905e5a388f88435a517de102e9b2c8e43d
iov_iter: saner checks for attempt to copy to/from iterator

After revert above commit on top of v6.2-rc2 kernel, this issue was gone.

Reproduced code, bisect logs and kconfig info are in link:
https://github.com/xupengfe/syzkaller_logs/tree/main/221228_010310__copy_from_iter/230103_copy_from_iter_v6.2-rc2

I hope it's helpful.

Thanks!
BR.


On 2022-12-30 at 10:33:02 +0800, Pengfei Xu wrote:
> Hi Viro,
> 
> Related email link:
> https://lore.kernel.org/lkml/Y5WlLoCBcHbfKBD5@ZenIV/
> 
> syzbot link:
> https://syzkaller.appspot.com/bug?id=4694bd1c1c0019f067af5b6e14e8ef02431b6b34
> 
> 
> I reproduced on TGL-H with v6.2-rc1 kernel.
> 
> All reproduced code bisect info are in link:
> https://github.com/xupengfe/syzkaller_logs/tree/main/221228_010310__copy_from_iter
> 
> I hope it's helpful.
> 
> Thanks!
> BR.
