Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7F96A1653
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 06:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBXFnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 00:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXFnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 00:43:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218AC18B2B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 21:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677217384; x=1708753384;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CYE+M3rO4SDkPQI3oRZpv9xs+r2iZVfjc/KVfLUuF9U=;
  b=gjK99mpbHJjhEoJu8isDYiWTs0bKzznr01pELNutwPd914Y2wVCnNLBS
   30fJG9panHn7OXSYyQAEr1cDhfKS5acrjjvAhhXNhd3/zq5+/QMEWhTRS
   2zM/v6oWyorloB2m6Z2M9giH2M6Z3FGebb+uY3l4L0FqYggvC+/Lmmzj0
   GWGmDu0G9FQaovfRGv9NvD+UPHLLP8R0r9lBseUKyc+5kQ8P7j+Xl0Fpg
   I1g3Q4gvEkSdBLBaTs55gqcDsavs9bh8MnJBNETFJL6wr+52BCH/m0iIA
   WdzsPd60CbHkotIRoaw5me+80gAaLjyVNiKeLbBq382xfjNAxgIZALp4J
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="360907072"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="360907072"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 21:43:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="736687104"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="736687104"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 23 Feb 2023 21:43:01 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 21:42:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 21:42:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 21:42:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9BpnCwO6ts5cNVJkWMvhMng+EVjlfCQuR8N0hRq5CeSoegloGrSgfQhbuVoLu26fzKKqvkbBGcG7/RlIbVTgcpsICSu6Pjm768DaiJh9gwFH0vKy7xWecyQeIiCVXXGVk5fxeZVTHmY5W3SPK+VBcGDHwrafpGhjzn2VEk6NZ4cYTbU8ToMkHBJCmtZblNBenjsmf3dMKgDOAqh3UfZFUN+wsGb3wHmVIom8CTtahMgSw12Z7ewp7tWSoIKlba0wOsALCkdqS5JuCNGIjpTbM3IGXSa7mqobPXH8NhXS32TPwsCl9ulnzSs7foE+9mZq4P0LOCIj81ki8xSEdoo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD4XYofqwCf0VbyDjmbsfQNERhVfoWgUMXje4OXtt5A=;
 b=U/AgLi1njaGYvU+1EXjZxWdr2j9oS5r49Ge3qieG8E9qwm+eMlG0jr1KCkos5K4r76CPkmGs6Zyt++Abd74X5lnFDn4eXOWgc2Rgr1Vw2+R+FO4B2T8yCxt/RAdzdJOVHznVTkHoSQfWQDFU2gHA35aDj9hbdhZSL+zyMeUuLfJmbtxSiAv9dpZOyAj4rDSxHxY07rnU/gh5ZpLokUpxMueFxwYNvVA8zY6cJ9LAruGH1eD611eUJNyPmIXuOXz00tVvPuCbg4HYvyzdvDI61GngdEt7x56YrOKjpcI413CO+Zo7qed8i7fNz4+g34V/w5S8C76r+2umSipIykcb6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 05:42:53 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154%5]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 05:42:52 +0000
Date:   Fri, 24 Feb 2023 13:43:38 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <jgg@ziepe.ca>
CC:     <baolu.lu@intel.com>, <yi.l.liu@intel.com>, <kevin.tian@intel.com>,
        <heng.su@intel.com>, <linux-kernel@vger.kernel.org>
Subject: [Syzkaller & bisect] There was "iommufd_test" WARNING in v6.2 in
 guest
Message-ID: <Y/hOiilV1wJvu/Hv@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SJ0PR11MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 119214eb-3429-4b4e-bee7-08db1629f89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxgH3hHA5bgpgiTkOw+AhcQ6b3New2toqrsbwwV6+kCd29IpvX1jPHvGOnZ27HwcUZ4NloSRvS7QEPFsp1tZ7Suu1Z2W6H5guUKFo3hdEznGv0uKSjYhPjpipy2k/+IypXsYPAcJz+e5VUoVp9T0pLqfq7sw+eAB2Qo0oVCeUIved9NS4ycnFPOXkD+wY7Mphsa50A0wp+JNq1i/xWbvlwhHBpmOCiLier6fWyHfCU1Ym7Sl4pcdzv4kMN3zviIZVcSEAAZCzRY+bn+R/8W3Q/B+926F2TUR0gcAShnF8o3O07/rlb8aph+EDsa/Ab35MvRFYN1UcoxLWuzO0ZafzmZrXLFRfJrmvfD1SXnwX71uWpXgUuPg/eNMWnAPggHiGbLjeVY3q+gf4gJ89Yqx3svYpIV7Z/dK5W598QbkX7PIJB8+Dhx8Lzc4fbxgDWDruhGUqeQAwZUKVmLrAvbdKfodZLXBLD1C4wVWW/nU/+fzfg9JtWz2QoNezf+oh1K6LK46GxukGyaZ9nYAf+YgrVj7j/2LOT3SH2H8XgFjgYURGzV39DCmjVuQ0n6I8wHmClu4ZUmpWpAN2ps0Wr+j9k9i3QA1TJEiWf6v0V5jhn8CGXVQkWdpcaL+J9qV4shiPuIsyXqr4peCWsV4mTYP8EUPQ0CNcgKfZFNJ5TXk8bi0kI3YMQUT8RvPWny3nGDERwTnScr1No8xuyNc3xuIHrvgKpemVwagrRCSguCQ37E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199018)(6506007)(66946007)(66556008)(83380400001)(316002)(8936002)(66476007)(4326008)(6916009)(41300700001)(8676002)(6666004)(186003)(6512007)(45080400002)(26005)(6486002)(966005)(478600001)(86362001)(2906002)(44832011)(38100700002)(82960400001)(5660300002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bWJNhDw0G7ygv7NQV7tG3HXRrmBVz9OQaLcIUNxh9V+sQRJ7kLfzKg1FVot9?=
 =?us-ascii?Q?eLPOvWyjnv7zPgOQko4LT6Py4NgZ7a+8BfoQITaQ4mfVd5sAf/q7JY2Kl27z?=
 =?us-ascii?Q?mRpnw/4sK0cOlFG1Z+eowkX47yP9EDpmWwttGyXwYiLKvoboRuPFVnZIb0f/?=
 =?us-ascii?Q?JPp1ddzMMB1rxYQGzn4AQwh3oLND40x0sYuJ4lN4apQZKQZyx2kTIP9MAEVz?=
 =?us-ascii?Q?B3lcY3AYiWv4Y956mxNqELIg3+gtT00s9FUgotiGi0Eg89nbPtMvLsjeP7Zw?=
 =?us-ascii?Q?FjpmM4cAcLpztg4zV7K9QNFHsq6TSDJ6V9dMr+LW/HnbNXsK2Gg4P/wrTw93?=
 =?us-ascii?Q?uOj7wY7Q0JRrespOyp56mg0+zXYsNrc94PHhNnYcvtwkdZVmARum87b21EWi?=
 =?us-ascii?Q?a4M+TG6AmKXC4A+LchlcplWqIS4Bqv9LkoqMjTLmivTesrjMvYlYgXZ9F83T?=
 =?us-ascii?Q?/4F1va1RQ2XYaNopk6MDOVvue8KK1VaRNTUxTW8/ANxrL/FcU8f5EFlWOzZC?=
 =?us-ascii?Q?J24kVsiUjNSe023iJ8fHA5kffllmA3eUzmkUe0Cl0HlJkoAQ3PBdYNbOFiIl?=
 =?us-ascii?Q?cRHpyNDS7Ibi6LNJc2S0OTqaee7VuOer6YPhTJCPggIiVEwnkMp+VzBxUwpD?=
 =?us-ascii?Q?ri/puJqgdaJuJFZgZLDXAxUiDPXcQz2jcJ7AMyYAhhZq/zsv8q6TUIv4E0pC?=
 =?us-ascii?Q?5skCMpkq7lFFSNOj5mRFqG08jlTvsrj+s0QPGFVMjj9KmCnlcvOEp3CBAlU4?=
 =?us-ascii?Q?wJuIO3XDZrWANir3XGQVGhtpGQTRHVUp+KusQzyoUboW7uw+TcBrocizR42t?=
 =?us-ascii?Q?G2EdwSeZqzfU7r+0IDL9JUj7+FmJUh8f59ByNgASbUcvlLcQLXEU3dco21Ts?=
 =?us-ascii?Q?wFK4b90VNMS/nCnmU6LtHqSDvUyxgrf4kGKQBGzF48QLzbK+BynWFIZxUTmu?=
 =?us-ascii?Q?pOSYltsQehCdvzkTITThpUMUaeHlNNLq7f+kip+JdH5sHu6C24hXLekQV+Ax?=
 =?us-ascii?Q?M7pHdj9PJXsN2On3q+5DxpT/o2lhhfcBpenH2c4h1JO1r/Cbd5bARFBpG4Xq?=
 =?us-ascii?Q?ARVn61orZPwrrjzeysBmruvL0YjTyEk6OsfwlLETWPhc4nq6LK6UR7eEfMC3?=
 =?us-ascii?Q?5FbQlK4gvq6+u+/c6V/p2nYDsbBpGARAheyYycTn9pFwmXcqZIZ38k5pJvKi?=
 =?us-ascii?Q?MK6tVQHd2jE4wTlSEFr1dHZG1oCHbsMgK40Bj7gniSroO10fr37myDuDzvHS?=
 =?us-ascii?Q?CrHZ1EH6VLLzWOL7VGZ6OqaFJ7c4zEGQ0fwfnm/iuI8rloqX05RlaABMfjXm?=
 =?us-ascii?Q?48fApcBX/Xsyhpb+FRpFz1oY2YeQQYH3kfvy5xabqlqZC8pllBz9IZeTx/qu?=
 =?us-ascii?Q?zv/t74zFILnAlsvdEVVTa2tUXPbwofGPkAwpP+JI4Hg32OT3e66LrT7RZgKE?=
 =?us-ascii?Q?z1WFt8mACN+s1ehz4y/hQmJEzapay7SAN6m2uJygWFSg0mhJNlslNS9j9bgB?=
 =?us-ascii?Q?y9krlXtDB8HU5y2SzvuU3U10FDikpwp905Y0jqJNtizZqL3kB5ukwCvNe2Ro?=
 =?us-ascii?Q?vgpYzHdC0j+clGxoII7Pp31KLIHYzezubvs5fJsc8lwYSb3ZmCYINLGD76cy?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 119214eb-3429-4b4e-bee7-08db1629f89d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 05:42:52.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v61R0+Cf8JQ2bFtiL51E9s6GPOvdtyKMwl+La0FElaHV6N1XtzGAjENTvyfDcsTOpFaSoMC4Sk+CvrOdVDOMvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5150
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Greeting!

Platform: ADL-S and x86 platforms
Host kernel 6.2.0-rc7 which doesn't enable iommufd by host kconfig setting as
below:
"# CONFIG_IOMMUFD is not set"

Guest kconfig with iommufd enabled: https://github.com/xupengfe/syzkaller_logs/blob/main/230224_044002_iommufd_test/kconfig_origin
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230224_044002_iommufd_test/repro.c
v6.2 problem dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230224_044002_iommufd_test/v6.2_c9c3395d5e3dcc6daee66c6908354d47bf98cb0c_dmesg.log
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230224_044002_iommufd_test/bisect_info.log

There was "iommufd_test" WARNING in v6.2 in guest:
[   32.012827] ------------[ cut here ]------------
[   32.013027] WARNING: CPU: 1 PID: 393 at drivers/iommu/iommufd/selftest.c:403 iommufd_test+0xb19/0x16f0
[   32.013410] Modules linked in:
[   32.013540] CPU: 1 PID: 393 Comm: repro Not tainted 6.2.0-c9c3395d5e3d #1
[   32.013809] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   32.014372] RIP: 0010:iommufd_test+0xb19/0x16f0
[   32.014566] Code: 94 c4 31 ff 44 89 e6 e8 a5 54 17 ff 45 84 e4 0f 85 bb 0b 00 00 41 be fb ff ff ff e8 31 53 17 ff e9 a0 f7 ff ff e8 27 53 17 ff <0f> 0b 41 be 8
[   32.015281] RSP: 0018:ffffc90000eabdc0 EFLAGS: 00010246
[   32.015493] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8214c487
[   32.015773] RDX: 0000000000000000 RSI: ffff88800f5c8000 RDI: 0000000000000002
[   32.016053] RBP: ffffc90000eabe48 R08: 0000000000000000 R09: 0000000000000001
[   32.016333] R10: 0000000000000001 R11: 0000000000000000 R12: 00000000cd2b0000
[   32.016613] R13: 00000000cd2af000 R14: 0000000000000000 R15: ffffc90000eabe68
[   32.016894] FS:  00007f94d76d5740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   32.017211] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.017447] CR2: 0000000020000043 CR3: 0000000006880006 CR4: 0000000000770ee0
[   32.017730] PKRU: 55555554
[   32.017843] Call Trace:
[   32.017960]  <TASK>
[   32.018054]  ? write_comp_data+0x2f/0x90
[   32.018226]  iommufd_fops_ioctl+0x1ef/0x310
[   32.018408]  __x64_sys_ioctl+0x10e/0x160
[   32.018575]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[   32.018773]  do_syscall_64+0x3b/0x90
[   32.018929]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   32.019142] RIP: 0033:0x7f94d77fa59d
[   32.019292] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
[   32.020005] RSP: 002b:00007fff58b77f18 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
[   32.020305] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f94d77fa59d
[   32.020585] RDX: 0000000020000000 RSI: 0000000000003ba0 RDI: 0000000000000003
[   32.020865] RBP: 00007fff58b77f30 R08: 00007fff58b78010 R09: 00007fff58b78010
[   32.021146] R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401050
[   32.021429] R13: 00007fff58b78010 R14: 0000000000000000 R15: 0000000000000000
[   32.021718]  </TASK>
[   32.021812] irq event stamp: 4817
[   32.021959] hardirqs last  enabled at (4827): [<ffffffff811d4a61>] __up_console_sem+0x91/0xb0
[   32.022302] hardirqs last disabled at (4834): [<ffffffff811d4a46>] __up_console_sem+0x76/0xb0
[   32.022644] softirqs last  enabled at (4678): [<ffffffff82f9c233>] __do_softirq+0x323/0x48a
[   32.022972] softirqs last disabled at (4673): [<ffffffff81123152>] irq_exit_rcu+0xd2/0x100
[   32.023298] ---[ end trace 0000000000000000 ]---

Bisected and found first bad commit:
f4b20bb34c83dceade5470288f48f94ce3598ada
iommufd: Add kernel support for testing iommufd
Reverted above commit on top of v6.2 kernel and made kernel failed.
So could not double confirm the bisect result by revert commit on top of v6.2
for this issue.

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
Please use target kconfig and copy it to kernel_src/.config
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
