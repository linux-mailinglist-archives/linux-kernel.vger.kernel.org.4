Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74566A3BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjB0H2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0H2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:28:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B1E6E8A;
        Sun, 26 Feb 2023 23:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677482881; x=1709018881;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dJWZ//FcO4lkim/WrqXFfkwjqNpt/VhC6bXM2OSlJL8=;
  b=e1+7dRBbcPf2NUnMTCQzo00n5mmRi/xxcwMR3jHhLEYK1g20MrEEQzQY
   nzHes+XtjqzGWQJw9Wp1NW9dx/9F8v3P00yDsj2j0D3a3yBDWX6QgxW3N
   Yvwp5D7baj++X9Gi+YGEJOsdo5jjdyI/ZdvjWhz9fce22mcXkI/J1uvUW
   HSWBD95bLpnWzLI7GnNz1maFp492IAmK3kT3usQEGtJMPOhFGQQaofUFI
   BkB3AHeTSIiMFouhyxOFGfhycHqml70LuVXa+WOTi8t6fKJucmnxRTuTc
   l7igfsTaQe4BRmo0cL95MVyWcZzYSi4FPOpi0HOFuiIAGnfbqHsccdRsU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="335279934"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="335279934"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 23:28:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="742409895"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="742409895"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 26 Feb 2023 23:28:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 26 Feb 2023 23:28:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 26 Feb 2023 23:28:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 26 Feb 2023 23:28:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihy0CS6F8BuUBm8DnVUEbCWyqKV4dVlcVJK4nZA/PaARGLOyUmZskwEmU6vCXM+yUBEIu3NFF2NK0wNO7N4g3HOtN8v4qUuyHJhVfBaFgfv8m1tReWCsK/d3RS3BCHph36CBhhyJMQx1iRFUoNC6Yi7ll2fK+5YazyZjQ+RWMeSanuDF0Nw4Fubuk+5UwqgFIq5pDh9qDQl6amxOspo/meO4IqDvOsBkXZhZ2HBlmfedvao8VvCThqkimgZzeZuPuU1MFOwtgMhip9poHav6Q/CtVXafrKGGLQjIm9KPjJiQYDR9d7ggqzzpCqQDEPofDUE4sX8EF+TAZVmLRM39GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilpfzDCmQXuPpT4Sb4iWasSCCUhHSnzzn0vKI5A06Fw=;
 b=aNruXQLAFXg2YD3Wx/Z1+PzQKMNJVHUMHG8iaDkBvtSVA9VS5lZVErV9MWIsTVp0/32WkGhQvcPa9nFtx28572DLemlLW796zpYo9SoOCbly9eEBFFg54BPwxdpwDIaTRFb8TDwXt0YsY/7Ve1Ou0fW2+sPtUqaX4PzuMxo6+Es8IokZ9Yy3DgeCrDLzlrM5tKGM6i1w19SyJ0G0yJdrZYBk8FuPy3esKMFZKfjJQgsV2r55W65cL5ZGSAVnVmLt5l9/TSETzMmEk0KmjELKba2vJnfCsLlzQsjy/1QIoSBlrIZ9uYoBKch5YOl0OQMFinlAjXQOrhV7soh6NzY0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SN7PR11MB6653.namprd11.prod.outlook.com (2603:10b6:806:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 07:27:58 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 07:27:58 +0000
Date:   Mon, 27 Feb 2023 15:29:12 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Helge Deller <deller@gmx.de>,
        linux-xfs <linux-xfs@vger.kernel.org>, <asml.silence@gmail.com>,
        <geert@linux-m68k.org>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is "xfs_dquot_alloc" related BUG in
 v6.2 in guest
Message-ID: <Y/xbyABFGZEeKduv@xpf.sh.intel.com>
References: <Y/g/femUL7jZ9gF3@xpf.sh.intel.com>
 <a39d97c1-2ced-d159-f742-e5c6008f79ee@gmx.de>
 <20230226223403.GU360264@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230226223403.GU360264@dread.disaster.area>
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SN7PR11MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 764fcebb-cbf8-4fa3-bbc8-08db1894262a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFjHiY+c4OzIcOANiozMF+TBuMT2Nma97lfvO7brdfiQYAyAaWx+w518XNdg8vOyZ2c/ivE1dBfW6ni1xp+BHL6dN7tbZMqfXCAUtLFuyylaSTIeJWXD3n0X0T+F6+nJ0lGBTq9fnOYFKOIQKhkGgHwnOEesx1qUTyDa2Ipey0C63cAOcDVSt0xziwdsKU6f4MsJ7x2eHkTtu9APnLumvmqrB2q8zeK8rMuvNQCkzLZkJHJm18SIqi6bUzZS9bkrBMTfYGYAWxnB8aKYTCM+2pHxcAx2/txudEli1nRwE5T4Zd9GVBoD+qst3C5GDOsj/ASSLJOKC5d+GPmo4T3/AIOatks+lw/hguiY/pk9Y+QHxcY19KdcqvRStL1S9yqasb3FZ/w6UhCW0Rqud5x/N7ciXpCe2v1TXcQReB8oq/5rQuWURsE3CZdrD4AdMkyXsp/FuN6EFgKr3rxDniWPIcOpU4SDSqNS9BtehgBDUs6KVD5OaCkO2JDVzUQUNfP+OYFxKzRt0inKQqkn0NtNYq2yKboJX4tPypBP238cqZi+g9yvUdZ3uboGzHGppxiTFeAad8OX8umtcFz9mch+AwfqmyjuJKhIvChnhRVSf8OVKvpEbYxYXXSgi2NvYbholkpTNOcsPddZ1M5ZlzVxBmcgAouKuOidQwjF3HqIaRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199018)(54906003)(316002)(86362001)(38100700002)(82960400001)(6666004)(107886003)(6506007)(53546011)(83380400001)(186003)(26005)(6512007)(5660300002)(45080400002)(8936002)(2906002)(966005)(6486002)(478600001)(6916009)(4326008)(41300700001)(8676002)(44832011)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+JXVZ29dqhUWsF7AKd/i1qllhEz4Ub2fDSEJbk33SvWgE07bLsLAJvZAHMY5?=
 =?us-ascii?Q?eWbkG4WjP/f6bSfphiSg7bpZLAqqhXO66UQBwrhl2Jodl+5r758buEmqMIm2?=
 =?us-ascii?Q?wUi3/2WPnaN16Ch8fm/oW19Z080/JNRdpRxXXSszPe/9K6L2q8blXpgNSDg8?=
 =?us-ascii?Q?Xvp92lhBeiPuDRVIZGJbMYRNBbzjG4/WPwB0Nz0tdsWq8c4iEfnCgCvfj5Ck?=
 =?us-ascii?Q?gXGIL+Ps3pe1mIpmGHekBnDp1FmznLjSSozCskCwsTFCiXjvtM2PGfZyRh7C?=
 =?us-ascii?Q?Pdsq8vRXR8Bce2hJTyUnP2TMDPfYYTVs8WWUthWucKpHKuVMJRL2IFR4llCW?=
 =?us-ascii?Q?oO/lBVL2m0VD5WGl0EzvWBKqUF87tqKKk8c9mr1n6QoIt2+CnWgJECU6GyuH?=
 =?us-ascii?Q?zjGG1O04SYRPn9SlAXEvi/c2EKSjio7gRFEIkbFELPfxaw+vPExuzo907JGN?=
 =?us-ascii?Q?f18znjoTn8uvt0x4vWUCGnlbMXfgQprPeCGtRWYFbXCeTqyxPK/EQc8bAm7Y?=
 =?us-ascii?Q?JdhDTKGKFXnrNvsUaqBWsoflrE+b819d78BjtSMpS/UWNGJr0YHPJMnFO+VP?=
 =?us-ascii?Q?gwrWWG++phL61QPAlXdT5+w/VKcvAnbOQcF45YYc9zA8mDVlwQFWStxp5CoR?=
 =?us-ascii?Q?vqpOSMAaVyckNpVD86TL/Pi7t9TrghRzUvV1bGEaZqR8ZUt1vV7T3p2gyjpT?=
 =?us-ascii?Q?PyhyXrasC7B2x//ENqvkDEZriGK1KdoJBhfmMtCF/V9YNEOazUz/Bw71JlqG?=
 =?us-ascii?Q?IA5H7L05gR3WpkQ7CbqWfbo7GReNBgW2CbCJH5Kc32rzKQ1OSqcd71xnwS/H?=
 =?us-ascii?Q?zk1R68FcX568V5eHsxtHKfU8FvD6VjmimQrQPSz9jI4Pviqyvqn7kL2jQlxO?=
 =?us-ascii?Q?VdBm3zIDNrdKlpf3ZxE04ChCKhM/W7rxAS04WpNf3fT6Iwtg289pnR8OO9vU?=
 =?us-ascii?Q?AwJKo0KguElIGMNyRFUkkRCGsyqMAUQNUrnv4WCfkBTZRfsz9W9NwaXeiM2C?=
 =?us-ascii?Q?koevjcXvSsEwYyR3FybkQ6vVnXghNWPP4v+6jD/9ALuGKEvYw3OtOfT8qDxc?=
 =?us-ascii?Q?lzMsmtR/maha9S4eyPZxouzjaQ+rdAi2O1/LCNUo07y1PLkmx3OoFFGOBjqm?=
 =?us-ascii?Q?mHovmb5ZB1rRpS/ZCzbB+AsCjMc9DOKg5dg7/oGr/R+1x33tsKb33VluUSEz?=
 =?us-ascii?Q?4UuoPpaWxSaZ3kQHkOzFymyr7rYQYQJed0UexxXVCzdS71L89vmn3Vyg9CfY?=
 =?us-ascii?Q?8XOytuigWnfiuQ+XjXHo+OnsIC6GAKsKw9pWyOIjcCCH6pBF4M/4xZ7gyU5Z?=
 =?us-ascii?Q?DzjEqyfiPP0oe4CvrWIKiH0Gg245WNh77tcbHSf38GiV2WzlgS4cRYrAKEgA?=
 =?us-ascii?Q?6nmdwJmddqIrgnMGVA7YeeqTbUB2Y89rb51RpGFINGGi6+TGx5heQcgoxUBY?=
 =?us-ascii?Q?IaIHxMRRojd/nI1jc7NZPtFa0fuvmQzuT1v4xJ8thvde4lnWiXWKZvnGM0cb?=
 =?us-ascii?Q?zaQOKs98Lu6+mmASQxjPl3hAWQXmefCUjwGYixcxlVJkV6pUNnP6/CBS3wEV?=
 =?us-ascii?Q?WkZKvWHi5Y3JodjNl7CYVSnOA5+ph2no0tOAL+/QynfYEYviKxJ5Phcw+x5f?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 764fcebb-cbf8-4fa3-bbc8-08db1894262a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 07:27:58.1680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ga2AlrUozMpr8jKUOagRlOjIQN84Kdnv8J+nLHPsQZLY0yiF6BvpnK28evTymEMrpkk9Jd2zqapcu/ZxWvBGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6653
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

Hi Dave and Helge Deller,

Thanks Helge Deller to add the xfs mailing list!

On 2023-02-27 at 09:34:03 +1100, Dave Chinner wrote:
> On Sat, Feb 25, 2023 at 08:58:25PM +0100, Helge Deller wrote:
> > Looping in xfs mailing list as this seems to be a XFS problem...
> > On 2/24/23 05:39, Pengfei Xu wrote:
> > > [   71.225966] XFS (loop1): Quotacheck: Unsuccessful (Error -5): Disabling quotas.
> > > [   71.226310] xfs filesystem being mounted at /root/syzkaller.qCVHXV/0/file0 supports timestamps until 2038 (0x7fffffff)
> > > [   71.227591] BUG: kernel NULL pointer dereference, address: 00000000000002a8
> > > [   71.227873] #PF: supervisor read access in kernel mode
> > > [   71.228077] #PF: error_code(0x0000) - not-present page
> > > [   71.228280] PGD c313067 P4D c313067 PUD c1fe067 PMD 0
> > > [   71.228494] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > [   71.228673] CPU: 0 PID: 161 Comm: kworker/0:4 Not tainted 6.2.0-c9c3395d5e3d #1
> > > [   71.228961] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > [   71.229400] Workqueue: xfs-inodegc/loop1 xfs_inodegc_worker
> > > [   71.229626] RIP: 0010:xfs_dquot_alloc+0x95/0x1e0
> > > [   71.229820] Code: 80 15 ad 85 48 c7 c6 7c 6b 92 83 e8 75 0f 6b ff 49 8b 8d 60 01 00 00 44 89 e0 31 d2 48 c7 c6 18 ae 8f 83 48 8d bb 18 02 00 00 <f7> b1 a8 02 2
> > > [   71.230528] RSP: 0018:ffffc90000babc20 EFLAGS: 00010246
> > > [   71.230737] RAX: 0000000000000009 RBX: ffff8880093c98c0 RCX: 0000000000000000
> > > [   71.231014] RDX: 0000000000000000 RSI: ffffffff838fae18 RDI: ffff8880093c9ad8
> > > [   71.231292] RBP: ffffc90000babc48 R08: 0000000000000002 R09: 0000000000000000
> > > [   71.231570] R10: ffffc90000baba80 R11: ffff88800af08d98 R12: 0000000000000009
> > > [   71.231850] R13: ffff88800c4bc000 R14: ffff88800c4bc000 R15: 0000000000000004
> > > [   71.232129] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> > > [   71.232441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   71.232668] CR2: 00000000000002a8 CR3: 000000000a1d2002 CR4: 0000000000770ef0
> > > [   71.232949] PKRU: 55555554
> > > [   71.233061] Call Trace:
> > > [   71.233162]  <TASK>
> > > [   71.233254]  xfs_qm_dqread+0x46/0x440
> > > [   71.233410]  ? xfs_qm_dqget_inode+0x13e/0x500
> > > [   71.233596]  xfs_qm_dqget_inode+0x154/0x500
> > > [   71.233774]  xfs_qm_dqattach_one+0x142/0x3c0
> > > [   71.233961]  xfs_qm_dqattach_locked+0x14a/0x170
> > > [   71.234149]  xfs_qm_dqattach+0x52/0x80
> > > [   71.234307]  xfs_inactive+0x186/0x340
> > > [   71.234461]  xfs_inodegc_worker+0xd3/0x430
> > > [   71.234630]  process_one_work+0x3b1/0x960
> > > [   71.234802]  worker_thread+0x52/0x660
> > > [   71.234957]  ? __pfx_worker_thread+0x10/0x10
> > > [   71.235136]  kthread+0x161/0x1a0
> > > [   71.235279]  ? __pfx_kthread+0x10/0x10
> > > [   71.235442]  ret_from_fork+0x29/0x50
> > > [   71.235602]  </TASK>
> > > [   71.235696] Modules linked in:
> > > [   71.235826] CR2: 00000000000002a8
> > > [   71.235964] ---[ end trace 0000000000000000 ]---
> 
> Looks like a quota disable race with background inode inactivation
> reading in dquots.
> 
> Can you test the patch below?
> 
Thanks for your fixed patch in short time!
I installed below patch on top of v6.2 kernel.
And there was no any BUG dmesg anyway, so the fixed patch worked.

And left some "Internal error xfs_iunlink_remove_inode" related Call Trace.
I'm new to xfs, could you help to check if it is some other issue or we
could ignore it.

I put the dmesg in bugzilla attachment as follow:
https://bugzilla.kernel.org/show_bug.cgi?id=217078 ->
https://bugzilla.kernel.org/attachment.cgi?id=303793

Thanks!
BR.
-Pengfei.

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> 
> xfs: quotacheck failure can race with background inode inactivation
> 
> From: Dave Chinner <dchinner@redhat.com>
> 
> The background inode inactivation can attached dquots to inodes, but
> this can race with a foreground quotacheck failure that leads to
> disabling quotas and freeing the mp->m_quotainfo structure. The
> background inode inactivation then tries to allocate a quota, tries
> to dereference mp->m_quotainfo, and crashes like so:
> 
> XFS (loop1): Quotacheck: Unsuccessful (Error -5): Disabling quotas.
> xfs filesystem being mounted at /root/syzkaller.qCVHXV/0/file0 supports timestamps until 2038 (0x7fffffff)
> BUG: kernel NULL pointer dereference, address: 00000000000002a8
> ....
> CPU: 0 PID: 161 Comm: kworker/0:4 Not tainted 6.2.0-c9c3395d5e3d #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Workqueue: xfs-inodegc/loop1 xfs_inodegc_worker   
> RIP: 0010:xfs_dquot_alloc+0x95/0x1e0
> ....
> Call Trace:
>  <TASK>
>  xfs_qm_dqread+0x46/0x440
>  xfs_qm_dqget_inode+0x154/0x500
>  xfs_qm_dqattach_one+0x142/0x3c0
>  xfs_qm_dqattach_locked+0x14a/0x170
>  xfs_qm_dqattach+0x52/0x80
>  xfs_inactive+0x186/0x340
>  xfs_inodegc_worker+0xd3/0x430
>  process_one_work+0x3b1/0x960
>  worker_thread+0x52/0x660
>  kthread+0x161/0x1a0
>  ret_from_fork+0x29/0x50
>  </TASK>
> ....
> 
> Prevent this race by flushing all the queued background inode
> inactivations pending before purging all the cached dquots when
> quotacheck fails.
> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_qm.c | 40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
> index e2c542f6dcd4..78ca52e55f03 100644
> --- a/fs/xfs/xfs_qm.c
> +++ b/fs/xfs/xfs_qm.c
> @@ -1321,15 +1321,14 @@ xfs_qm_quotacheck(
>  
>  	error = xfs_iwalk_threaded(mp, 0, 0, xfs_qm_dqusage_adjust, 0, true,
>  			NULL);
> -	if (error) {
> -		/*
> -		 * The inode walk may have partially populated the dquot
> -		 * caches.  We must purge them before disabling quota and
> -		 * tearing down the quotainfo, or else the dquots will leak.
> -		 */
> -		xfs_qm_dqpurge_all(mp);
> -		goto error_return;
> -	}
> +
> +	/*
> +	 * On error, the inode walk may have partially populated the dquot
> +	 * caches.  We must purge them before disabling quota and tearing down
> +	 * the quotainfo, or else the dquots will leak.
> +	 */
> +	if (error)
> +		goto error_purge;
>  
>  	/*
>  	 * We've made all the changes that we need to make incore.  Flush them
> @@ -1363,10 +1362,8 @@ xfs_qm_quotacheck(
>  	 * and turn quotaoff. The dquots won't be attached to any of the inodes
>  	 * at this point (because we intentionally didn't in dqget_noattach).
>  	 */
> -	if (error) {
> -		xfs_qm_dqpurge_all(mp);
> -		goto error_return;
> -	}
> +	if (error)
> +		goto error_purge;
>  
>  	/*
>  	 * If one type of quotas is off, then it will lose its
> @@ -1376,7 +1373,7 @@ xfs_qm_quotacheck(
>  	mp->m_qflags &= ~XFS_ALL_QUOTA_CHKD;
>  	mp->m_qflags |= flags;
>  
> - error_return:
> +error_return:
>  	xfs_buf_delwri_cancel(&buffer_list);
>  
>  	if (error) {
> @@ -1395,6 +1392,21 @@ xfs_qm_quotacheck(
>  	} else
>  		xfs_notice(mp, "Quotacheck: Done.");
>  	return error;
> +
> +error_purge:
> +	/*
> +	 * On error, we may have inodes queued for inactivation. This may try
> +	 * to attach dquots to the inode before running cleanup operations on
> +	 * the inode and this can race with the xfs_qm_destroy_quotainfo() call
> +	 * below that frees mp->m_quotainfo. To avoid this race, flush all the
> +	 * pending inodegc operations before we purge the dquots from memory,
> +	 * ensuring that background inactivation is idle whilst we turn off
> +	 * quotas.
> +	 */
> +	xfs_inodegc_flush(mp);
> +	xfs_qm_dqpurge_all(mp);
> +	goto error_return;
> +
>  }
>  
>  /*
