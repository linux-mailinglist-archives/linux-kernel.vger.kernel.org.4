Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED28E6AE2E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjCGOlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjCGOlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:41:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30648B04B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678199814; x=1709735814;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=QB6EGRuakkMcC1Jj15VLDHM4oyOidNKxOJOypb/8T4M=;
  b=X7McWWstxaBfn6gc4UGnclrCztyVe9HTWWGZnFLZruxMcs+31P6doWz8
   rOkNxPiTIqoorxSf2kMDiaT17lnUjOa5vY0iJcyuMiDgIqH92Ep81X6IU
   H2gdgXMbSzVRRU414wEnTBCWe9OR+Qx6jLdaViEJSGUcL1B4w+MoYYJcc
   gkADmeYdROWpq9NjhBib8w9BkgYjw3s9YIjNwGsUCvietUbKbeTED7wur
   JOaG9Krv5mwcirm9yqZZ83h6ayza6FVV2ONTeVjz6/MxuCHl/ogem7BFF
   trQA67iKueoy2yVecwr1+wFMNVThpswaQTqp2nCO/Y0a05jwwjHWOP1xt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="316262620"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="316262620"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 06:35:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="745489533"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="745489533"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2023 06:35:43 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 06:35:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 06:35:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 06:35:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIQssMVulkOXnCLuzr/itkhqOfVRqcx/rcsb9kgi1lJa8UWSnIKrNI3lHE7lhedLziZ6sDHRTGi0YRtiOIUF/hc0Kb4/5Z5qlQUR2Th530qLPR/IDMfvokP+N4oUQVFZe3iC44I0fAURLw2POI0mV35hObggY5VldQJ3QaEMtFIua+vo2bvaJFrsSVVGFIXqB++pJycGvFtQ+v08XqmArUtWCdj/WNWbN/T2GO/9nWxuoDhY4ZZy0ybCGtKBhMn5Z8kHAW9Glb5VyqaZJeMROToc3V1myvzeWdRUeJY/xIlq4V+Wu9oDadR18eaYhLTZqCAQIz+/yF21btVbahbzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCpTMlHzjEm3unqzkopP1zGUWtcrhBLVePF5g75szPQ=;
 b=ChxDvukYTU7zmIa3vJCdtktEuTseq9JeCNZJ7bbIFHfsdJprOTb+6DJpsb3APlG/EBxPrglTB/0S3qee6v8OfubNLxQswtUIHdpKlyX2p34lxhn/i2WaQchszZLaAEde1EXT5zenC1P3DZxoBAq6jQpaGYsoXAtRhdh+OJlT5RzkYsW/20ZegyM8mKDmDFmjshP87kSECRsK4sGo1kVn0ykQM5DMxm2/zaFWv4O6bK72rQBAKKWOBH1q7rk1oTWKU4L2HBSJQBW2MOScWQ/R8zp+GOhS+CbO5IHV8pzJcs2GQ47T7+ZERH2XyV5fZFOsEVDkjMk/Q+SEax7/F2Errw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 14:35:37 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154%5]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 14:35:37 +0000
Date:   Tue, 7 Mar 2023 22:36:55 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <edumazet@google.com>
CC:     <linux-kernel@vger.kernel.org>, <ast@kernel.org>,
        <john.fastabend@gmail.com>, <heng.su@intel.com>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is WARNING: refcount bug in sock_map_free
 in v6.3-rc1
Message-ID: <ZAdMB+eGT3TQEo7y@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW4PR11MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f683e8e-286c-4a22-71d3-08db1f193799
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0y/QEpkNc06nu1mQsSMyOBOwa93RuxiZbDxPv5s3XgwN8D0pJTUXq3g3EBKii9bzKBMmMzxNjxLOHlWfAKIB8jxrJPI0MvKQxVqgUOvY8XiMQcNwmwF221NfIrwEbkosA+EgArbh4YS4gsR7ucfPmqa7DrZcm5/iPaGKJZNzjCX7b5vRBZX94x8D5r2XFzns6nVxCT+JHgJg7TBC4wDPd/qsUmY/1x+6qttdHZsvteEYQgXrsGvb0x7AIw+yp+TedIJ7rCJyIjAuwcz8/I27BqON7UAY/Svz/qLby23/58outGMDpcvGtGoxFKcVIIAOsjVZawEhDjRG72AzGrK9LUX0VVP5zShWi6ZyMovT2T+g4D6/iiopitfJqXGo3cVnpEEb4V/a74l3gR64mUzdW9OwUdzwBbEoDActeSkXkAr/IqbDXxfFbAXuzNp1NfX7htsuK+oiZHMhW7CqexS9XwsFciwagGz6T6z5r+tfW4ZdWLnbpi6To6NNQ5SEk2p7CFUE8/CW9bJI1tGLvtbiDIi7FyKWGPPWHN2xX+278Lvqv1btVH9mLmQ7TcQxrATa+2oTbsk2JuUx+TbhiCWQGz0+w5ckAHoVpiYH8RJ48bFp49siY1ALOVYG/p+aRM5SOSoqSKyLLL7aBT493G5HW3Plc3TpYHaeDL6QlbI0TrZ1IQ/LZLPzYlq8QNQsiina2GfoLNZ2YVgVghOOX1vd0S1sw3BNIXRQAuoQ9ULB3lyFFFYgNXlfA5N+qe3Dc/s9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199018)(82960400001)(86362001)(38100700002)(66476007)(2906002)(44832011)(66946007)(30864003)(5660300002)(41300700001)(6916009)(4326008)(8676002)(66556008)(8936002)(186003)(83380400001)(6506007)(6512007)(478600001)(45080400002)(6666004)(107886003)(26005)(966005)(316002)(6486002)(21314003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?05fhYv0O1vGvlE18YUkfr4UPdXvML3dAsuEGoUBJoBwqMZoj7gxRINlxCpUp?=
 =?us-ascii?Q?mEOJT/XblKEli0FqQ6XWe5VsE1BKpQcM3+PiIS12VPa2Lnqgjd3x8aNQop7E?=
 =?us-ascii?Q?oXFPfAZoSmYVXn97LOvl+LSZtzBuDxmEgvmAWpFtbmbmNoktzqM2GzIpt82v?=
 =?us-ascii?Q?9vqTDOp8Xs+lvGAiZds5+04Q89mc1XNxD+mQkaLV3rDpQAOcBUnpgAG29XKz?=
 =?us-ascii?Q?wXQ55vywRLDC9H1fdCbLkjbALhHpVXatMo9DiQ4DThKOcJFII5xnw0QwA0Fv?=
 =?us-ascii?Q?ZcCI1H8G/Connu5OgMdeOkegf9bMvltGWC0MaRBL633c46xL7hkAZM0PCIJJ?=
 =?us-ascii?Q?2UW20SyBFTwb+tAy11eCiavv/8vPqOrneDsy/jvgnyabv9OmqyKFM2sfWt5s?=
 =?us-ascii?Q?V7RBsU2xA7m4n//4XsKWE3fTvQ3fPbAYPbTUNUWyK2kruB1eoAFJg6FtcvI7?=
 =?us-ascii?Q?1cG8JpO2/DyQ1t8PFlDICubT1K6/HmVLhWIkGBNbQqg9LJmyrsEbjo3XkSTY?=
 =?us-ascii?Q?mQuNp8P/6qxtYc59MC3vlzqT35Aj0TpJOCPE/TukXBpOA/6hw+zkPmS2pccf?=
 =?us-ascii?Q?3haE5+6E7lw9FvFQSeDHnnJynsDOKJnmhH/qikN7hiW2f9cXBIRb19f2Xvv0?=
 =?us-ascii?Q?ZpapG4jcRGm0Pqk/fRWms6fvYRVGU3tvP3CZKzAXGKW8jC0F26jGUkbHtDlU?=
 =?us-ascii?Q?plLEG9IZtPmKTUgYyKEphw8LL1dnpI7Zi5WPxZPRlP1lqkBmy5WrERyYx23k?=
 =?us-ascii?Q?7WHgGPbXiVh4hwIM4ZFYHXBFtrM3+7f+PjUMengqgzNNuvM/p8I7grH5fFNv?=
 =?us-ascii?Q?Y383SccYDWH/Td3NmEhw43oyV3YximT+RoNFqELVvreWCdSwdTQDdpfRQig3?=
 =?us-ascii?Q?yTdllaiso1Nx/Bm/G5nLfdGjzDyvSHPzcMg9qxr/PhP8qJgGxc6mP3IL/Jwa?=
 =?us-ascii?Q?3q4fNJJtPW6Mz0zjoeikVGxD6BcRzi+tyFZDkPvP0jkcX41EpAjlL8TkbvT1?=
 =?us-ascii?Q?G0SxjUpNoKvlo2PqNaD5b3YdY3U7zcEzSU6I9a2IbjYXHE9P4TGUr6eJHMzY?=
 =?us-ascii?Q?xXgs9pMGFMsT7N+f0VW5GIcAHiWT+RTKHV7EP3S2YjYey+HWp9qqVwC8D+91?=
 =?us-ascii?Q?/Stv+BVFnl2Y/7cBF3+J1/6mErdV8BTZij6u+VqwsefGhFbu5bwobpsOdmlh?=
 =?us-ascii?Q?WzX9uUB+tVjO/F0lwkp9BRBf7PMtUm3oQTrmvCRQx3zTVowBWClNFjUJqbB5?=
 =?us-ascii?Q?6d65KILOvzE/bkZh9bGTq2rpQOfYUDVUkPrMjVGkMerE1Ul8hKJ+4i8y8dgo?=
 =?us-ascii?Q?Zo21HWJlglAlWAxqHjuMhfQ9kftBa6P90kq94XEUoS656peNHrBRF2U8UfRi?=
 =?us-ascii?Q?TZ9H50obnIMm3mGFC2OXIv+ttzqpiMFwAQvxFkZ4xf8APc/jfsi2OWXpnSQp?=
 =?us-ascii?Q?zMVeV7jGIOx0gzfQ7BPhBTchf7RBB0LQHAujx9Deo4qDxojcgQDEaNzt361Y?=
 =?us-ascii?Q?migFPYOsUFIoXsDQ6WHgHbkYiBadd4ZU9AiuxMApzYUp6sE8uju4hHvdNanw?=
 =?us-ascii?Q?QVhJxj6CRjb1bxLzcGqv5bi8p3Qj9aXI0wRNeLBVWv2QZkC4zVoo03uU5NpT?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f683e8e-286c-4a22-71d3-08db1f193799
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 14:35:37.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICffxKlFSYv1wgU7KT4ZIJ0zRLXJl3MDzXjYKhKx/BjtQiSo7qW+qkqC07F2QjoerVBdtvb97BmG3UvqcLqINA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric Dumazet,

Greeting!

Platform: x86 platform
All detailed log link: https://github.com/xupengfe/syzkaller_logs/tree/main=
/230306_123510_sock_map_free
v6.3-rc1 problem dmesg: https://github.com/xupengfe/syzkaller_logs/blob/mai=
n/230306_123510_sock_map_free/v6.3-rc1_problem_dmesg.log
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230306_12=
3510_sock_map_free/bisect_info.log
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230306_123510=
_sock_map_free/bisect_info.log

There is WARNING: refcount bug in sock_map_free in v6.3-rc1 kernel.


[   58.955232] ------------[ cut here ]------------
[   58.955976] refcount_t: addition on 0; use-after-free.
[   58.956752] WARNING: CPU: 0 PID: 9 at lib/refcount.c:25 refcount_warn_sa=
turate+0xe6/0x1c0
[   58.957846] Modules linked in:
[   58.958278] CPU: 0 PID: 9 Comm: kworker/u4:0 Not tainted 6.3.0-rc1-fe15c=
26ee26e+ #1
[   58.959340] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   58.960854] Workqueue: events_unbound bpf_map_free_deferred
[   58.961630] RIP: 0010:refcount_warn_saturate+0xe6/0x1c0
[   58.962344] Code: 1d b8 c2 43 02 31 ff 89 de e8 c6 ab 52 ff 84 db 75 97 =
e8 5d aa 52 ff 48 c7 c7 d8 b6 be 83 c6 05 98 c2 43 02 01 e8 1a 55 36 ff <0f=
> 0b e9 78 9
[   58.964836] RSP: 0018:ffffc90000053da0 EFLAGS: 00010286
[   58.965582] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff811=
1b6fb
[   58.966570] RDX: 0000000000000000 RSI: ffff888007372340 RDI: 00000000000=
00002
[   58.967569] RBP: ffffc90000053db0 R08: 0000000000000000 R09: 00000000000=
00001
[   58.968547] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88800ec=
16200
[   58.969532] R13: 0000000000000000 R14: ffff888015808000 R15: ffff88800ed=
6fc00
[   58.970500] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:=
0000000000000000
[   58.971647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.972447] CR2: 0000000020000000 CR3: 0000000003e3a006 CR4: 00000000007=
70ef0
[   58.973461] PKRU: 55555554
[   58.973851] Call Trace:
[   58.974206]  <TASK>
[   58.974520]  sock_map_free+0x387/0x390
[   58.975077]  bpf_map_free_deferred+0x124/0x2d0
[   58.975753]  process_one_work+0x3b1/0x9e0
[   58.976350]  worker_thread+0x52/0x660
[   58.976895]  ? __pfx_worker_thread+0x10/0x10
[   58.977514]  kthread+0x161/0x1a0
[   58.977994]  ? __pfx_kthread+0x10/0x10
[   58.978529]  ret_from_fork+0x29/0x50
[   58.979073]  </TASK>
[   58.979448] irq event stamp: 25237
[   58.979940] hardirqs last  enabled at (25245): [<ffffffff811eac21>] __up=
_console_sem+0x91/0xb0
[   58.981151] hardirqs last disabled at (25252): [<ffffffff811eac06>] __up=
_console_sem+0x76/0xb0
[   58.982466] softirqs last  enabled at (25234): [<ffffffff83023a3c>] __do=
_softirq+0x31c/0x49c
[   58.983769] softirqs last disabled at (25229): [<ffffffff8112b5a4>] irq_=
exit_rcu+0xc4/0x100
[   58.985055] ---[ end trace 0000000000000000 ]---
[   58.985813] ------------[ cut here ]------------
[   58.986530] refcount_t: underflow; use-after-free.
[   58.987460] WARNING: CPU: 0 PID: 9 at lib/refcount.c:28 refcount_warn_sa=
turate+0x15e/0x1c0
[   58.988714] Modules linked in:
[   58.989207] CPU: 0 PID: 9 Comm: kworker/u4:0 Tainted: G        W        =
  6.3.0-rc1-fe15c26ee26e+ #1
[   58.990565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   58.992351] Workqueue: events_unbound bpf_map_free_deferred
[   58.993213] RIP: 0010:refcount_warn_saturate+0x15e/0x1c0
[   58.994119] Code: 02 31 ff 89 de e8 52 ab 52 ff 84 db 0f 85 1f ff ff ff =
e8 e5 a9 52 ff 48 c7 c7 08 b7 be 83 c6 05 1f c2 43 02 01 e8 a2 54 36 ff <0f=
> 0b e9 00 9
[   58.997238] RSP: 0018:ffffc90000053da0 EFLAGS: 00010286
[   58.998124] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff811=
1b6fb
[   58.999358] RDX: 0000000000000000 RSI: ffff888007372340 RDI: 00000000000=
00002
[   59.000558] RBP: ffffc90000053db0 R08: 0000000000000000 R09: 00000000000=
00001
[   59.001737] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88800ec=
16200
[   59.002928] R13: 0000000000000000 R14: ffff888015808000 R15: ffff88800ed=
6fc00
[   59.004172] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:=
0000000000000000
[   59.005541] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.006521] CR2: 0000000020000000 CR3: 0000000003e3a006 CR4: 00000000007=
70ef0
[   59.007770] PKRU: 55555554
[   59.008260] Call Trace:
[   59.008709]  <TASK>
[   59.009094]  sock_map_free+0x36c/0x390
[   59.009745]  bpf_map_free_deferred+0x124/0x2d0
[   59.010543]  process_one_work+0x3b1/0x9e0
[   59.011288]  worker_thread+0x52/0x660
[   59.011947]  ? __pfx_worker_thread+0x10/0x10
[   59.012694]  kthread+0x161/0x1a0
[   59.013270]  ? __pfx_kthread+0x10/0x10
[   59.013925]  ret_from_fork+0x29/0x50
[   59.014570]  </TASK>
[   59.014959] irq event stamp: 25629
[   59.015589] hardirqs last  enabled at (25639): [<ffffffff811eac21>] __up=
_console_sem+0x91/0xb0
[   59.017047] hardirqs last disabled at (25646): [<ffffffff811eac06>] __up=
_console_sem+0x76/0xb0
[   59.018450] softirqs last  enabled at (25412): [<ffffffff83023a3c>] __do=
_softirq+0x31c/0x49c
[   59.019851] softirqs last disabled at (25367): [<ffffffff8112b5a4>] irq_=
exit_rcu+0xc4/0x100
[   59.021282] ---[ end trace 0000000000000000 ]---

Found this issue existed in v6.2 kernel also.
And bisected from v6.2 to v5.11 and found the bad commit:
"
0a182f8d6074
bpf. sockmap: fix race in sock_map_free()
"
Reverted the bad commit on top of v6.2, above issue was gone.


There was "use after free" in dmesg info.
And I found that GPIO kselftest triggered the similar Call Trace also.
"
cd linux/tools/testing/selftests

 1.  ./kselftest_install.sh


 2.  cd  linux/tools/testing/selftests/kselftest_install/gpio

 # ./gpio-mockup.sh
 1.  Module load tests
 1.1.  dynamic allocation of gpio
 2.  Module load error tests
 2.1 gpio overflow
 test failed: unexpected chip - gpiochip1
 GPIO gpio-mockup test FAIL
"
Related dmesg:
"
[ 9729.144086] ------------[ cut here ]------------
[ 9729.149680] refcount_t: underflow; use-after-free.
[ 9729.155478] WARNING: CPU: 75 PID: 809778 at lib/refcount.c:28 refcount_w=
arn_saturate+0xd3/0x120
[ 9729.165489] Modules linked in: gpio_mockup(-) xt_state rds quota_v2 quot=
a_tree brd overlay ntfs btrfs blake2b_generic xor raid6_pq ip6t_REJECT nf_r=
eject_ipv6 ip6t_rpfilter xt_tcpudp ipt_REJECT nf_reject_ipv4 xt_conntrack n=
ft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bridge stp l=
lc vsock_loopback vhost_vsock vmw_vsock_virtio_transport_common vhost vhost=
_iotlb ip6_tables vsock ip_tables nft_compat x_tables ip_set nf_tables nfne=
tlink intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_=
frequency_common i10nm_edac nfit x86_pkg_temp_thermal snd_hda_codec_realtek=
 intel_powerclamp snd_hda_codec_generic ledtrig_audio coretemp snd_hda_inte=
l snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_hwdep =
snd_seq kmem ofpart snd_seq_device kvm_intel snd_pcm pmt_telemetry pmt_cras=
hlog cmdlinepart snd_timer kvm ipmi_ssif spi_nor device_dax intel_sdsi pmt_=
class irqbypass mei_me mtd rapl snd i2c_i801 isst_if_mmio pcspkr dax_hmem i=
sst_if_mbox_pci intel_cstate
[ 9729.165539]  spi_intel_pci soundcore isst_if_common mei intel_vsec idxd =
i2c_ismt spi_intel i2c_smbus ipmi_si acpi_power_meter acpi_pad mac_hid sch_=
fq_codel crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 aes=
ni_intel crypto_simd cryptd ast igc pinctrl_emmitsburg pinctrl_intel pwm_lp=
ss [last unloaded: init_module(O)]
[ 9729.297472] CPU: 75 PID: 809778 Comm: modprobe Tainted: G S        IO   =
    6.2.0-lkml #18
[ 9729.306942] Hardware name: Intel Corporation ArcherCity/ArcherCity, BIOS=
 EGSDCRB1.SYS.0090.D03.2210040200 10/04/2022
[ 9729.318926] RIP: 0010:refcount_warn_saturate+0xd3/0x120
[ 9729.325020] Code: 9f 00 0f 0b 5d c3 cc cc cc cc 80 3d c5 72 b7 01 00 0f =
85 74 ff ff ff 48 c7 c7 10 b9 2b bc c6 05 b1 72 b7 01 01 e8 7d 39 9f 00 <0f=
> 0b 5d c3 cc cc cc cc 80 3d 9b 72 b7 01 00 0f 85 4c ff ff ff 48
[ 9729.346438] RSP: 0018:ff38111b0f3b3e48 EFLAGS: 00010286
[ 9729.352524] RAX: 0000000000000000 RBX: ff1e4ed2436ee100 RCX: 00000000000=
00001
[ 9729.360745] RDX: 0000000000000001 RSI: ffffffffbc1ea3d1 RDI: 00000000fff=
fffff
[ 9729.368960] RBP: ff38111b0f3b3e48 R08: 0000000000000000 R09: c0000000ff7=
fffff
[ 9729.377188] R10: 0000000000000001 R11: ff38111b0f3b3cb8 R12: ff1e4ed24b9=
0fc00
[ 9729.385415] R13: ff1e4ed2436ee140 R14: 0000000000000000 R15: 00000000000=
00000
[ 9729.393639] FS:  00007f76415d5740(0000) GS:ff1e4ef0972c0000(0000) knlGS:=
0000000000000000
[ 9729.402941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9729.409618] CR2: 00007f764154fd96 CR3: 000000108c20c006 CR4: 0000000000f=
71ee0
[ 9729.417860] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 9729.426087] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[ 9729.434328] PKRU: 55555554
[ 9729.437633] Call Trace:
[ 9729.440650]  <TASK>
[ 9729.443266]  kobject_put+0x10f/0x1b0
[ 9729.447520]  fwnode_remove_software_node+0x35/0x50
[ 9729.453158]  gpio_mockup_unregister_pdevs+0x3a/0x4e [gpio_mockup]
[ 9729.460233]  gpio_mockup_exit+0xd/0x3b3 [gpio_mockup]
[ 9729.466169]  __x64_sys_delete_module+0x140/0x240
[ 9729.471619]  do_syscall_64+0x3b/0x90
[ 9729.475909]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 9729.481830] RIP: 0033:0x7f7641954f7b
[ 9729.486100] Code: 73 01 c3 48 8b 0d 15 8f 0c 00 f7 d8 64 89 01 48 83 c8 =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 8e 0c 00 f7 d8 64 89 01 48
[ 9729.507517] RSP: 002b:00007ffef02671e8 EFLAGS: 00000206 ORIG_RAX: 000000=
00000000b0
[ 9729.516270] RAX: ffffffffffffffda RBX: 0000562e93269ee0 RCX: 00007f76419=
54f7b
[ 9729.524519] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000562e932=
69f48
[ 9729.532752] RBP: 0000562e93269f48 R08: 00007ffef0266191 R09: 00000000000=
00000
[ 9729.541004] R10: 00007f76419d3ae0 R11: 0000000000000206 R12: 00000000000=
00000
[ 9729.549266] R13: 0000000000000000 R14: 0000562e93269f48 R15: 00000000000=
00000
[ 9729.557518]  </TASK>
[ 9729.560246] ---[ end trace 0000000000000000 ]---
"

I hope it's helpful.


---

If you don't need the following environment to reproduce the problem or if =
you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.=
1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 =
v6.2-rc5 kernel
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
make -jx bzImage           //x should equal or less than cpu num your pc ha=
s

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
../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --ena=
ble-gtk --enable-sdl
make
make install
---

Thanks!
BR.
