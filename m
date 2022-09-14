Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E05B8B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiINPBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiINPBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:01:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9D265248
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663167691; x=1694703691;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UzLVKT4K730gxLd6wB06MPHWGP84cSqkXRUGj7SuhZ0=;
  b=MypLb01G/2Hvx6mb2wLX3vM7Uj7mjRdD4l3hixm+WpGpy+vOScERvN9l
   KTRCMQVmmaiFdojzfemTatF4CbtOQuYDN1LyoNUY8zD4IOnRDi8XlMh/7
   r4xdvAMyiwp3puW6zWd9uh3BJa0thDlWtWbOTJsczf1fcbtBeHFylog4B
   5BQcLPBjVPKf5zze8JS/R7OVSDLTqf/4uG4oL2uPU16j4ZuTcEnBa9bwU
   6Sg1WTSxKDFGLUKVAfRuAanVc6GCbYagY3LSjUu0CbiD7pi2vt2pYaXVL
   8dDlJLBD/JPfO6AcbxMRVNz3A3h3IRB9emSdaCIWHuAcHrFWo3FLenLVe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="297180893"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="297180893"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 08:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="679082641"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 14 Sep 2022 08:01:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 08:01:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 14 Sep 2022 08:01:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 14 Sep 2022 08:01:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnHfxOCbnHwhd5mLJQUScS5eQrLdnAGlGN7mXKhGY96tuockRcAdfzDz4PKseRq6M4ca1JmlJ0hc2KD9U+ImEaWAnemSJhy7jF8Cg8db+HQhalVcaKFfCZBnmwqmSdEAi6sY8u/TAg/wbmkEmKgHl1+e0xAjRqBib8e/WI3dTDWxyprZLIzdcIUCLDE1KDVSWbTxqkyz8Ddq1fCMTJFOp77UTC9q9/UZ/9hXfQ3ep4iL02OIcQ0zgyJ9wQVk25SciHnc0kOXpkEFyxv6/ehIJRDaSQpz4VcuiVOCNa+X4VBetHMJHBceyl/PmFXiOD+ZzKXkmoJYgQXa58eWmrcRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aujoQFMxxtDRPqr800sAIoexyM6Kf9dMyQMpDnjzHs=;
 b=esNN1TL1qgezml+Lk/pHSOIQXjPCWGobqoYI7LFLLNvkSq+aGEjiTf51vk5vs9HpePkxv9xGddRJ2a0qeWee1BzzoJCMk4F97GblUQsf/UhRo0uLk8KvIodxYFiLt9AHYb3O2W3wPJ1RsIB7qABaMoR2KetD9yX4cH1S5Rb0cYXY1kHesP3WpBsCiKKGjuFLAgmJzMgBLibf5ogncWv/Kuuso13z5L/axiRrmh11C1XWaCoHZdvbHlOMYfnY7OuNPN08YXK9JzdcoV2a2K41H2AWPAUZ0FT73tNPgWVa3zn4Xmd+byj8M3wAul8ki9fAWaFeoD9An6FWenQ9af5ksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by BL3PR11MB6412.namprd11.prod.outlook.com (2603:10b6:208:3bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 15:01:24 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b80a:cf49:9118:24e7]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b80a:cf49:9118:24e7%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 15:01:24 +0000
Date:   Wed, 14 Sep 2022 08:01:21 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Karolina Drobnik <karolina.drobnik@intel.com>
CC:     <intel-gfx@lists.freedesktop.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Yunfei Wang <yf.wang@mediatek.com>,
        Ning Li <ning.li@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Joerg Roedel <jroedel@suse.de>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [topic/core-for-CI] Revert "iommu/dma: Fix race condition during
 iova_domain initialization"
Message-ID: <20220914150121.y6ucj4mav65mt7we@ldmartin-desk2.lan>
X-Patchwork-Hint: comment
References: <20220914124045.903883-1-karolina.drobnik@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20220914124045.903883-1-karolina.drobnik@intel.com>
X-ClientProxiedBy: SJ0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::34) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|BL3PR11MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 8657d369-5a07-47da-e348-08da9661fdd3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYNWbBb3gahoXe4deSUHhBzXchCSqNwYwsP6icJwBQpeR6AR2FCt+SQrB5ewuOhC73iSQYfXqtOV5i3zw2ZWv9Ca1HlhmIleonMyKUM51erNrXCGfUxe1WptjrhhizcX9hjAbn9oEHxMb3OHOXKO9DOrkArHWkfdXbnxKW/BTL4UeMysVRkbeWbll48236UIAwwN6cz1o/CTzl/dk1uo4l0+p41w69xgcFI8pVNgpIXEvTRDGOJQ97H1lqy2KRFfO6P01JamKxNBJ/FId0mYgBFkn10tDKqQHBoJ4Vn1J5UwLl31SXo9r7tjL83VKaiDuC8zlH3AzDHNDfY/W/dx/6jvOamWWXA8zlq2RMiyE7zSD1MhBPFDvNV6i9V3sfuHEOQWnN8Xkcb5jIfQzh7xIRSWFHt3BWEQe/1znkAyglgc0AxIwS6gupzRcx/0815Fn8YvVhe/ysh1uTE5kRwGiO4WpXIhqIKwueQiAB7eD44LaQ1Vc1qigRWLTt7HD78hWrjaJAXIRvMKqt+XN834ApQt+QCwOuMtVstMd9+bFNXTYiEL6t0h0Jt7iBtSUWBad9Gr+c+BonrvSSJrlqzJdBklZ58xjif4RJgMeIIIpS5z7OkFjxZMZLNNoAKL56BTB24vA+7G+hpQxXIy3hqGYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(82960400001)(9686003)(8936002)(6512007)(38100700002)(83380400001)(8676002)(966005)(26005)(6862004)(6636002)(478600001)(1076003)(66946007)(6506007)(4326008)(86362001)(66476007)(186003)(66556008)(6486002)(5660300002)(6666004)(54906003)(36756003)(2906002)(316002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vderUa+DgWwwWA3a7MvUeBfRcpBU0gOuik9yUCDNJI4VXVw8DZ6fPRXFA8a+?=
 =?us-ascii?Q?UOPo8Sjx4+q1CJfXDkWR8BlBibI7Ntll/QONS2GMEoU52hl5smFrApRySwBY?=
 =?us-ascii?Q?R1AhJFw7H8yw3VvVPYExR7BtxBw/PrXYSi6VwXBqiECaD95nKXBNZ6Agh1U2?=
 =?us-ascii?Q?45HjdUMoJlzkcXSxk4dPgGNjskxfLWJS3SCnfrY+CjwgS+OkEbCM/Ry0CxPw?=
 =?us-ascii?Q?kLzNToB5Ngv/3deJEqOCv7UPctHMNqFQqLmSTY0qim7bMvkARtI5VAGKhPFU?=
 =?us-ascii?Q?9s5/VqUHwi+1NeIsCSokq/ch/Xf908crGevwpHe0wAt+CiU8HMGSOmg8DHIa?=
 =?us-ascii?Q?C5csjWMwc5F+p76tWOptu+uulPlPG1tRegcCqgyrGMJxp4cr1IKM3lraz+je?=
 =?us-ascii?Q?9L0Hl9/cx7Dfqbz1lSwanJVF1iXbBxahjg/NYk9uWwpBZS6B89eAygTwsYnh?=
 =?us-ascii?Q?g7s+55KCC9/mP7E0DAGwGmD94IQvqQN4LyCdQ0/nPY/AMivcDJPGkbOYw8//?=
 =?us-ascii?Q?yvmHzzH8/9I5MtJrlIF9MyAM1OErHq0AQYF8Jgk8Lj4pJfCsJQgTLLyPYAD4?=
 =?us-ascii?Q?xCzZNc/vTHPmLvy8UkurQGRuEmq4SBwPnFzILNAWph1TfLqXCPpMEeM85uxW?=
 =?us-ascii?Q?dhPIU4eEavJkcqFIbR40THjrYR16uoeATn2ezJ+wVqPuPdlEZPDwXAAPH8wM?=
 =?us-ascii?Q?KdgXX6jLvJgsdXxAA3a3S/b5IRDlz/VpnrItDMdmaK3JznycC76+IPVWmyzA?=
 =?us-ascii?Q?7B6KpQcoaDdyV1FkBlgRBjoSXhLo65A3GcRrO12yI9whjzN08Lxz0yKkcLNZ?=
 =?us-ascii?Q?HPHp1NYb3HFdzNgDEZvJ0es5HogxqIpo/NKznXj5V2r7x7XcP7IVd9eL4Py5?=
 =?us-ascii?Q?A73OUZF5XlWHoP7RlwiAprG7Xefdr9bRX+NG4ALriQRqrgjfMRC9IOhhvIr8?=
 =?us-ascii?Q?BK/WetERNq5NhoJg0VUzBvqt4d++vJHMUlKhazmb7lpoZEstd20DVT4FtjMB?=
 =?us-ascii?Q?wUGKotLNixXEFUnSllHVG2JleGzz+7a0aUsDe11423qL7cxfOAWDi+zE0C1Y?=
 =?us-ascii?Q?4OpYtTJ0pG3QQrJwvI8nB8Du5rJCXu2ZvM5BdzlcwU2b4fkoulU3qPa3w/0S?=
 =?us-ascii?Q?bnH4aobCpaXOdoUIo1+M6YUWzWG1U8djDaIShxLPWdee6ANOnucMSyv/BwZ9?=
 =?us-ascii?Q?UCXtSRr1cL9CIwq+pqwhUynKSngeXbtP4gwPxW9ZJsgwwRu4g7G4T6B+vpLT?=
 =?us-ascii?Q?fAkh1Cl4yCxkA/GWAPwccl+hDHPV4KWhZWjrn1lSb3smFL44De1vKkg/Dzxw?=
 =?us-ascii?Q?1k4jNngn/oTwgbhPcW3iDUWGd6jb6RY6zPwybzg+EOC3p69VHmf1Qd4AvdCF?=
 =?us-ascii?Q?92AkfPuOCsUQvfirhpC2IBYbSJAZSGdJsEC3KcI4yuCSEeqCuMDrtQ82P6qa?=
 =?us-ascii?Q?rMSjCqJAunuTz7vFmTysxiUDEvDxoigg7JkB9Xx9jHsRnDiuqGYi1/sZOhNR?=
 =?us-ascii?Q?0MHVWhbZtIpa8A5KrGBlozzOuLmvqS/LO4AQpXb7N35MGsBB0EfDCKCgpiJ5?=
 =?us-ascii?Q?e3VpJKyprny69RKFdLVmZr5ohobHRaLgLyS5v08CcHq4PGR5+z4fywxwdp0o?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8657d369-5a07-47da-e348-08da9661fdd3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 15:01:24.2268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaCiW+XZfYJQ5DH+0uqXS+c302vAvDBQSN49Ob3Mjnnys/Q1P7bKIP0t74VODI62P89jjtOz0BeP4JLpdMtDxc1qrZL2xic5YK4JoYvsyeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6412
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 02:40:45PM +0200, Karolina Drobnik wrote:
>This reverts commit ac9a5d522bb80be50ea84965699e1c8257d745ce.
>
>This change introduces a regression on Alder Lake that completely
>blocks testing. To enable CI and avoid possible circular locking
>warning, revert the patch.

We are already on rc5. Are iommu authors involved aware of this issue?
We could do this in our "for CI only" branch, but it's equally important
that this is fixed for 6.0

Cc'ing them.

thanks
Lucas De Marchi

>
>kernel log:
>
>======================================================
>WARNING: possible circular locking dependency detected
>6.0.0-rc5-CI_DRM_12132-g6c93e979e542+ #1 Not tainted
>------------------------------------------------------
>cpuhp/0/15 is trying to acquire lock:
>ffff8881013df278 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: blocking_notifier_call_chain+0x20/0x50
>              but task is already holding lock:
>ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x48/0x1f0
>              which lock already depends on the new loc
>              the existing dependency chain (in reverse order) is:
>              -> #3 (cpuhp_state-up){+.+.}-{0:0}:
>       lock_acquire+0xd3/0x310
>       cpuhp_thread_fun+0xa6/0x1f0
>       smpboot_thread_fn+0x1b5/0x260
>       kthread+0xed/0x120
>       ret_from_fork+0x1f/0x30
>              -> #2 (cpu_hotplug_lock){++++}-{0:0}:
>       lock_acquire+0xd3/0x310
>       __cpuhp_state_add_instance+0x43/0x1c0
>       iova_domain_init_rcaches+0x199/0x1c0
>       iommu_setup_dma_ops+0x130/0x440
>       bus_iommu_probe+0x26a/0x2d0
>       bus_set_iommu+0x82/0xd0
>       intel_iommu_init+0xe33/0x1039
>       pci_iommu_init+0x9/0x31
>       do_one_initcall+0x53/0x2f0
>       kernel_init_freeable+0x18f/0x1e1
>       kernel_init+0x11/0x120
>       ret_from_fork+0x1f/0x30
>              -> #1 (&domain->iova_cookie->mutex){+.+.}-{3:3}:
>       lock_acquire+0xd3/0x310
>       __mutex_lock+0x97/0xf10
>       iommu_setup_dma_ops+0xd7/0x440
>       iommu_probe_device+0xa4/0x180
>       iommu_bus_notifier+0x2d/0x40
>       notifier_call_chain+0x31/0x90
>       blocking_notifier_call_chain+0x3a/0x50
>       device_add+0x3c1/0x900
>       pci_device_add+0x255/0x580
>       pci_scan_single_device+0xa6/0xd0
>       pci_scan_slot+0x7a/0x1b0
>       pci_scan_child_bus_extend+0x35/0x2a0
>       vmd_probe+0x5cd/0x970
>       pci_device_probe+0x95/0x110
>       really_probe+0xd6/0x350
>       __driver_probe_device+0x73/0x170
>       driver_probe_device+0x1a/0x90
>       __driver_attach+0xbc/0x190
>       bus_for_each_dev+0x72/0xc0
>       bus_add_driver+0x1bb/0x210
>       driver_register+0x66/0xc0
>       do_one_initcall+0x53/0x2f0
>       kernel_init_freeable+0x18f/0x1e1
>       kernel_init+0x11/0x120
>       ret_from_fork+0x1f/0x30
>              -> #0 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}:
>       validate_chain+0xb3f/0x2000
>       __lock_acquire+0x5a4/0xb70
>       lock_acquire+0xd3/0x310
>       down_read+0x39/0x140
>       blocking_notifier_call_chain+0x20/0x50
>       device_add+0x3c1/0x900
>       platform_device_add+0x108/0x240
>       coretemp_cpu_online+0xe1/0x15e [coretemp]
>       cpuhp_invoke_callback+0x181/0x8a0
>       cpuhp_thread_fun+0x188/0x1f0
>       smpboot_thread_fn+0x1b5/0x260
>       kthread+0xed/0x120
>       ret_from_fork+0x1f/0x30
>              other info that might help us debug thi
>Chain exists of                 &(&priv->bus_notifier)->rwsem --> cpu_hotplug_lock --> cpuhp_state-
> Possible unsafe locking scenari
>       CPU0                    CPU1
>       ----                    ----
>  lock(cpuhp_state-up);
>                               lock(cpu_hotplug_lock);
>                               lock(cpuhp_state-up);
>  lock(&(&priv->bus_notifier)->rwsem);
>               *** DEADLOCK *
>2 locks held by cpuhp/0/15:
> #0: ffffffff82648f10 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x48/0x1f0
> #1: ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x48/0x1f0
>              stack backtrace:
>CPU: 0 PID: 15 Comm: cpuhp/0 Not tainted 6.0.0-rc5-CI_DRM_12132-g6c93e979e542+ #1
>Hardware name: Intel Corporation Alder Lake Client Platform/AlderLake-P DDR4 RVP, BIOS ADLPFWI1.R00.3135.A00.2203251419 03/25/2022
>Call Trace:
> <TASK>
> dump_stack_lvl+0x56/0x7f
> check_noncircular+0x132/0x150
> validate_chain+0xb3f/0x2000
> __lock_acquire+0x5a4/0xb70
> lock_acquire+0xd3/0x310
> ? blocking_notifier_call_chain+0x20/0x50
> down_read+0x39/0x140
> ? blocking_notifier_call_chain+0x20/0x50
> blocking_notifier_call_chain+0x20/0x50
> device_add+0x3c1/0x900
> ? dev_set_name+0x4e/0x70
> platform_device_add+0x108/0x240
> coretemp_cpu_online+0xe1/0x15e [coretemp]
> ? create_core_data+0x550/0x550 [coretemp]
> cpuhp_invoke_callback+0x181/0x8a0
> cpuhp_thread_fun+0x188/0x1f0
> ? smpboot_thread_fn+0x1e/0x260
> smpboot_thread_fn+0x1b5/0x260
> ? sort_range+0x20/0x20
> kthread+0xed/0x120
> ? kthread_complete_and_exit+0x20/0x20
> ret_from_fork+0x1f/0x30
> </TASK>
>
>Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/6641
>
>Signed-off-by: Karolina Drobnik <karolina.drobnik@intel.com>
>Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>---
> drivers/iommu/dma-iommu.c | 17 ++++-------------
> 1 file changed, 4 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>index 17dd683b2fce..9616b473e4c7 100644
>--- a/drivers/iommu/dma-iommu.c
>+++ b/drivers/iommu/dma-iommu.c
>@@ -65,7 +65,6 @@ struct iommu_dma_cookie {
>
> 	/* Domain for flush queue callback; NULL if flush queue not in use */
> 	struct iommu_domain		*fq_domain;
>-	struct mutex			mutex;
> };
>
> static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
>@@ -312,7 +311,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
> 	if (!domain->iova_cookie)
> 		return -ENOMEM;
>
>-	mutex_init(&domain->iova_cookie->mutex);
> 	return 0;
> }
>
>@@ -563,33 +561,26 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> 	}
>
> 	/* start_pfn is always nonzero for an already-initialised domain */
>-	mutex_lock(&cookie->mutex);
> 	if (iovad->start_pfn) {
> 		if (1UL << order != iovad->granule ||
> 		    base_pfn != iovad->start_pfn) {
> 			pr_warn("Incompatible range for DMA domain\n");
>-			ret = -EFAULT;
>-			goto done_unlock;
>+			return -EFAULT;
> 		}
>
>-		ret = 0;
>-		goto done_unlock;
>+		return 0;
> 	}
>
> 	init_iova_domain(iovad, 1UL << order, base_pfn);
> 	ret = iova_domain_init_rcaches(iovad);
> 	if (ret)
>-		goto done_unlock;
>+		return ret;
>
> 	/* If the FQ fails we can simply fall back to strict mode */
> 	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
> 		domain->type = IOMMU_DOMAIN_DMA;
>
>-	ret = iova_reserve_iommu_regions(dev, domain);
>-
>-done_unlock:
>-	mutex_unlock(&cookie->mutex);
>-	return ret;
>+	return iova_reserve_iommu_regions(dev, domain);
> }
>
> /**
>-- 
>2.25.1
>
