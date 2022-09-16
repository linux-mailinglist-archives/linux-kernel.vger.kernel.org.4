Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45F35BA595
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIPEAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPEAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:00:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA02C6C75D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663300830; x=1694836830;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=MfuOXzmgNjjSnoanOQZeE11t7yWA+4ZhsjamxPb1aDI=;
  b=dj+vIdjZcb9GvFAyom0s23M2QzTR6Tn59w+X9fhCtEIBgwYADjjvLX2y
   lB0zWNilSuED53W+GXzKZ4Oga2xL1f2XrICH+0q5pRszBpjs24cro3lll
   wAr3lBzIaY59Tm8xBjhl0+Tc42Zc4BNq9/row4JS7RKRJdobyGN3lAY6g
   HFZuhKtHEn9k+11rXDWKM3N8nd/CNa+TGNrJl+ZQP8M53/s+FChTu11VF
   UI+dmrloGh4brAv0kqXHa0Hayae3IU8CWW5otTrJt3kZkShXO2ynBRV/F
   9ac/DV4Wfvu8Uq4tydtAH82VQ7CC48n/tLpSpMytP/t34SUaRyJonBbnM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="299729275"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="299729275"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 21:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="619948884"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2022 21:00:29 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 21:00:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 15 Sep 2022 21:00:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 15 Sep 2022 21:00:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5YAsX255LFGibu6leye8uCkRErtD/Ib7u/6cCS2jdXWIrczhhJw2n1gD768QZQ3eg86O9Zri7r7oqdtDkMDKWGwkUlRNnzZwSgkuppdg4WI934gMubiMp/qV/Lj2sCfiqWpj3owq0AWlOXW6YHYUs2IyxZOiM4ime3f6pXabpu6qiZkytv5NjH2phwO1g5ZR9DQ2AVvwbT3U1MarCGBffLKiQu7ETPYiEMeNfHeJAkI0zpoXAiRbbDaImFkEQ759nDwl8RLZR3hy9a+OExqOUqRUmIgpNCj4X7wHexLScgHn9mMUZCFl/dXpoqXCiozYtQWwng5juN9hFIw/ZV2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM4u/Ey+TDrhDGK+Ap62smsOfpjkpOqcLF1Db1S6klU=;
 b=cJTxChXTfb24Mj7QblrbTh3skfuoaiOkXKz9DTTIXsSwOZ0+YpDx3MSTkDGeaAdzb/WxaAwTJs1YOfQcJjV+p1O4bZTWUDxjxIVHwsb/srRjZYArXOQvaCkkWDurPCNYOgVxkiIE5ym3ma5BkC261Cv9RxuiKYl41buPyOBAlp2JC7XbgGCIzijZB1YdzOlOEX3PTxdCalocRrkI9kQnKyIKLT3m0s2lmZaGaIyEzFHgENZNP6svj2FDx+lm4MCpSwemViJ9irQH8B4grERpsJdDxqlOnsLGgmyCKgHwH0wxIqa5OG8clZ3R2/4BHwLThUMvIiNc1+Ui+AQktUiV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DM4PR11MB5422.namprd11.prod.outlook.com (2603:10b6:5:399::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 04:00:27 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::4d24:8150:7fb7:a429]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::4d24:8150:7fb7:a429%6]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 04:00:26 +0000
Date:   Fri, 16 Sep 2022 11:59:14 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        lkp <lkp@intel.com>
Subject: Re: [PATCH] x86/mm: Set NX bit when making pages present
Message-ID: <YyP0ksav5fNH/aIv@yujie-X299>
References: <20220909152721.1685334-1-dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220909152721.1685334-1-dave.hansen@linux.intel.com>
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DM4PR11MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6d2f4f-9f90-4309-c849-08da9797fc92
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9T6Kf7Oo74DiuvmUdATPrCscCSDeNIqHVcRYH/UgmfEDAhqYbd+MBaHAm26a224909+OKgTvHTBuLtA9w7j6t6+OO5ufA9gDu3525l2bjF0TuLCVTRdKgOkIG8G1cNdz+ZqG1leNFc0FHzGKVcaOuu/ZJvmnQm8TePC27hjznHEFLHyNsmum01apqZSIDr3hpFDdCDXCYJpML5KZNFY0Vk4nioLVyOevA1Sm7+Ppr/PTNI08bBfuUbmTLkyxbIXmv8tstb23zU++15bHw8zEQxI1vBvCDTOVibfLC7wpK58iRug7kxuhpJ7IoQnZTK8ccLIf4LG5Z0ks1YuAfiKZS8c3vT6YKnilTxkDeGBr1uYppUe9NQQvein6SJrAwh5Asha3AHyZsEhvIHRrftispzvQ+WnqyekNxCvECoFTNZ4yrqV/0/IU/jNNbG3bx3HKehPoJF848ef/9izGe8do8X+zZQbCKG9c3MgPu+W1pkl3n/Kuu4HTLFigHrl0MTLxCbQ0GpvuNp8k7esm+1thQnaoMbIlE75lxVUAmKn9PJTXoZxYMJp6Fupo5N8YUw9wyCyddHfQEmCWWb9C5kCdv293qzMSnK03BoiuI0drc8ni5Xvt1LaDesqTuyjw7UHpKuwO4C3lPmJSs+Giun3FgaYTrSpXj2A3YnJm74aajIix7c/avPDpwO3eBfzhndX+FsX3PoKgmz3daj/SfBpprnWhbfgG4zoJNQ0SEbhxJUnExqKbfWzHlGMGXlh+puFRoldBP4qnYy0LyWD2ncxmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(83380400001)(186003)(38100700002)(82960400001)(44832011)(30864003)(2906002)(5660300002)(8936002)(41300700001)(33716001)(478600001)(6486002)(6506007)(26005)(6512007)(9686003)(966005)(6666004)(8676002)(4326008)(66476007)(66556008)(66946007)(45080400002)(316002)(6916009)(54906003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kQCDFRCbtoGMN0S6gWzhdrAl1gjh9VjtmsfWcRB6vTnR18K+MTiiSVPUKkMK?=
 =?us-ascii?Q?AUFAT9JYAYJ9/lAksZlUGS9U1WJ8jh7dw4z0yGwkCdRAikQEtHvRWZzAMWj7?=
 =?us-ascii?Q?BcgX050bQ7z0RuZfp5o0GznBoXRJB5mwotAIt8G7nXLHx7WrTp6SpPnvG6jv?=
 =?us-ascii?Q?Pc8jpmt0Ekw+8yfkF/uvqjQFkwwFrJYSydYUk5NaIkEo2Xgs6r0HOzYzg7wL?=
 =?us-ascii?Q?TpYUoL+N45FmAju4begijja7w9uCnTv6J+5CyAnBX43MqBscvlJb/aTOZvHx?=
 =?us-ascii?Q?MpBcv+7X1S+yLVbZY4D63UPgn0aZKU5UTaej1myLkhQwsWFPyLjp7CrWYwpU?=
 =?us-ascii?Q?w61ePt8r4P4czjQb0Y0SSLvG2FRA0H8PX6zHh2Ikjs7jrELNiF9u+UnxnTyQ?=
 =?us-ascii?Q?5FxiArdhw2J7unK4XdVAG9O7whb3g+NPhfATmxR+ILfCMpHlep0j4SS8CIJo?=
 =?us-ascii?Q?hquaUrOIwMboLC5mETyLL6SQTiDJYm/C7oM0AIuGTmIec+UHEzgAq5F7ZUie?=
 =?us-ascii?Q?UJc42oESIrU3dtAi/nagZ6x3W0EO9sHYSWyOMu1XClgvehpxtMtPPp9qYGbB?=
 =?us-ascii?Q?oFuiipWFWDbAB6NWXfNUKxK85x5IM5MXcBmN2enrS9WOuq9v0P3vbge3r7Qn?=
 =?us-ascii?Q?nDTXyI6nwLrz5EVj54z+6+cWiG8oCAb9wSi9RCxCp8dA5TpdVTHp+50KXK9t?=
 =?us-ascii?Q?9+2mryFiYCryCW/lG4Mi3gUE/MnuDLipl0pHECQdRs+zj8B+8zJv1x3weUYX?=
 =?us-ascii?Q?wY88GV5J7Aa53nFNu3TuGS2PS+MULHpT3PHI1VUEifWsSza3BcMJQs5NFRlo?=
 =?us-ascii?Q?I2d27p/Cgq3ELzejpzj/cowyS/uHIZZT1CHAUe2YBbQv+tuNDucdK01Cnv65?=
 =?us-ascii?Q?DWiYRvF4x6Qpv2hpjYauOo7yi4NM0cTjt9c+PIaiuxlXLb/4jDwiia9KqgeS?=
 =?us-ascii?Q?ySmS18AN27rqy3IE5x6XlknqCIwjJbIW/l4wLdjkjFeya1VeQvTAmMOb+e8B?=
 =?us-ascii?Q?kqAc4jT6XLTGd54C1wAWKJASnFqw/Wn5YJsZssNKqPx1e7FsENnADKuYuUfs?=
 =?us-ascii?Q?S7FSOWBfTTYvEcVNp2wbPzFLOKxELj9SOqNmZRgdVGked3zKrWjXrxQxlgGI?=
 =?us-ascii?Q?KC5e721TDXy0zxqfZOimhj7kOZ6I9mm561fNpIYqbN1Bd+yEVfehG7fHNthy?=
 =?us-ascii?Q?A78T54WOJIxOLcfEZKDPmycXeYq/0AdeINO1K9cd9TUyXo29wDVFGxvIEa2s?=
 =?us-ascii?Q?ACjH19m7BPxvo/pZtsZW1dJCfWU+9V7UaZkzJjcWLL9Mvvi4r+88DDTnT7Ic?=
 =?us-ascii?Q?h7wt6o2iqNWsj/YYO42nz4lzlLvO1LN1yK9pthPfN+LGT4Dic0ZLfC7/la2V?=
 =?us-ascii?Q?jtH0608TpaymlU5caMd1H43G1vbxcW8fsL21X2SrEpYCKcXyzzVfLeoOKQIC?=
 =?us-ascii?Q?rap551BZ/tJ2d9/ncD6zVYE6YjLFpjxsJf6Nqu8LeW3gP6VczrvqYrnjrw8b?=
 =?us-ascii?Q?4zj7UGZo4DzxX1iKssjdXw+J+e2FPfuW8VBEYGnL2t8qEeLXhHRBUBdoRYwk?=
 =?us-ascii?Q?tHNC7teb6xzwUCzvQk98WW474Zd3QZ7gHNcZ/qqI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6d2f4f-9f90-4309-c849-08da9797fc92
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 04:00:26.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuZKC5bYFTO7EjA5L/x6RVkmZksz/3iftrAHM7dRTCvN6qnsp+csgKQ1EnlriuyWSIxYN7D9bBn73HsXqqc4rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5422
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

Hi Dave,

On Fri, Sep 09, 2022 at 08:27:21AM -0700, Dave Hansen wrote:
> The x86 mm code now actively refuses to create writable, executable
> mappings and warns when there is an attempt to create one.
>=20
> 0day ran across a case triggered by module unloading, but that looks
> to be a generic problem.  It presumably goes like this:
>=20
> 	1. Load module with direct map, P=3D1,W=3D1,NX=3D1
> 	2. Map module executable, set P=3D1,W=3D0,NX=3D0
> 	3. Free module, land in vfree()->vm_remove_mappings()
> 	4. Set P=3D0 during alias processing, P=3D0,W=3D0,NX=3D0
> 	5. Restore kernel mapping via set_direct_map_default_noflush(),
> 	   set P=3D1,W=3D1, resulting in P=3D1,W=3D1,NX=3D0
>=20
> That's clearly a writable, executable mapping which is a no-no.  The
> new W^X code is clearly doing its job.
>=20
> Fix it by actively setting _PAGE_NX when creating writable mappings.
>=20
> One concern: I haven't been able to actually reproduce this, even by
> loading and unloading the module that 0day hit it with.  I'd like to
> be able to reproduce this before committing a fix.

We followed the steps in original report and confirmed the case could be
reproduced by running in qemu. Here we put a brief log for your
information.

$ lkp-tests/bin/lkp qemu -k bzImage -m modules.cgz job-script
...
exec command: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -fsdev local,=
id=3Dtest_dev,path=3D/root/.lkp//result/rcuscale/300s-srcu/vm-snb/debian-i3=
86-20191205.cgz/i386-randconfig-a013-20211012/gcc-11/652c5bf380ad018e15006a=
7f8349800245ddbbad/0,security_model=3Dnone -device virtio-9p-pci,fsdev=3Dte=
st_dev,mount_tag=3D9p/virtfs_mount -kernel bzImage -append root=3D/dev/ram0=
 RESULT_ROOT=3D/result/rcuscale/300s-srcu/vm-snb/debian-i386-20191205.cgz/i=
386-randconfig-a013-20211012/gcc-11/652c5bf380ad018e15006a7f8349800245ddbba=
d/3 BOOT_IMAGE=3D/pkg/linux/i386-randconfig-a013-20211012/gcc-11/652c5bf380=
ad018e15006a7f8349800245ddbbad/vmlinuz-5.19.0-00430-g652c5bf380ad branch=3D=
tip/x86/mm job=3D/lkp/jobs/scheduled/vm-meta-159/rcuscale-300s-srcu-debian-=
i386-20191205.cgz-652c5bf380ad018e15006a7f8349800245ddbbad-20220904-96286-f=
jjdsq-5.yaml user=3Dlkp ARCH=3Di386 kconfig=3Di386-randconfig-a013-20211012=
 commit=3D652c5bf380ad018e15006a7f8349800245ddbbad vmalloc=3D256M initramfs=
_async=3D0 page_owner=3Don max_uptime=3D2100 LKP_LOCAL_RUN=3D1 selinux=3D0 =
debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D10=
0 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_w=
atchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor=
_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprin=
tk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dnormal rw  ip=3Ddhcp result_=
service=3D9p/virtfs_mount -initrd /root/.lkp/cache/final_initrd -smp 2 -m 1=
6384M -no-reboot -watchdog i6300esb -rtc base=3Dlocaltime -device e1000,net=
dev=3Dnet0 -netdev user,id=3Dnet0 -display none -monitor null -serial stdio=
 -drive file=3D/tmp/vdisk-root/disk-vm-snb-0,media=3Ddisk,if=3Dvirtio -driv=
e file=3D/tmp/vdisk-root/disk-vm-snb-1,media=3Ddisk,if=3Dvirtio -drive file=
=3D/tmp/vdisk-root/disk-vm-snb-2,media=3Ddisk,if=3Dvirtio
early console in setup code
early console in extract_kernel
input_data: 0x02c1a094
input_len: 0x010390d3
output: 0x01000000
output_len: 0x0239fed0
kernel_total_size: 0x02c6b000
needed_size: 0x02c6b000

Decompressing Linux... Parsing ELF... No relocation needed... done.
Booting the kernel.
...
LKP: ttyS0: 287: Kernel tests: Boot OK!
LKP: ttyS0: 287: HOSTNAME vm-snb, MAC 52:54:00:12:34:56, kernel 5.19.0-0043=
0-g652c5bf380ad 1
[  OK  ] Reached target Printer.
LKP: ttyS0: 287:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-159/=
rcuscale-300s-srcu-debian-i386-20191205.cgz-652c5bf380ad018e15006a7f8349800=
245ddbbad-20220904-96286-fjjdsq-5.yaml
[   11.660921][  T203] ------------[ cut here ]------------
[   11.661292][  T203] CPA refuse W^X violation: 0000000000000060 -> 000000=
0000000063 range: 0x00000000bab7e000 - 0x00000000bab7efff PFN 7ab7e
[   11.662112][  T203] WARNING: CPU: 0 PID: 203 at arch/x86/mm/pat/set_memo=
ry.c:600 __change_page_attr+0x245/0x260
[   11.662762][  T203] Modules linked in: torture
[   11.663057][  T203] CPU: 0 PID: 203 Comm: kworker/0:3 Not tainted 5.19.0=
-00430-g652c5bf380ad #1
[   11.663605][  T203] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.14.0-2 04/01/2014
[   11.664175][  T203] Workqueue: events do_free_init
[   11.664545][  T203] EIP: __change_page_attr+0x245/0x260
[   11.664881][  T203] Code: ff ff ff 8d 87 ff 0f 00 00 ff 75 e4 31 d2 50 8=
b 45 e0 57 52 31 d2 51 52 50 68 18 49 8d 42 c6 05 bc 1e 02 43 01 e8 c1 e0 e=
7 00 <0f> 0b 83 c4 20 e9 40 ff ff ff e8 4c 8d f2 00 8d b4 26 00 00 00 00
[   11.666092][  T203] EAX: 00000077 EBX: 7ab7e060 ECX: 42af1540 EDX: 42af1=
53c
[   11.666526][  T203] ESI: beb69ea4 EDI: bab7e000 EBP: beb69e4c ESP: beb69=
e0c
[   11.666970][  T203] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS:=
 00010292
[   11.667441][  T203] CR0: 80050033 CR2: 0805ae40 CR3: 7ab70000 CR4: 00040=
690
[   11.667884][  T203] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000=
000
[   11.668326][  T203] DR6: fffe0ff0 DR7: 00000400
[   11.668618][  T203] Call Trace:
[   11.668832][  T203]  __change_page_attr_set_clr+0x49/0x170
[   11.669178][  T203]  ? _vm_unmap_aliases+0x101/0x120
[   11.669494][  T203]  set_direct_map_default_noflush+0x49/0x60
[   11.669857][  T203]  __vunmap+0x192/0x270
[   11.670114][  T203]  __vfree+0x20/0x50
[   11.670361][  T203]  vfree+0x29/0x60
[   11.670591][  T203]  module_memfree+0x1b/0x30
[   11.670875][  T203]  do_free_init+0x2c/0x50
[   11.671142][  T203]  process_one_work+0x20c/0x480
[   11.671441][  T203]  worker_thread+0x166/0x3c0
[   11.671727][  T203]  kthread+0xbf/0xe0
[   11.671966][  T203]  ? rescuer_thread+0x310/0x310
[   11.672278][  T203]  ? kthread_complete_and_exit+0x20/0x20
[   11.672626][  T203]  ret_from_fork+0x19/0x30
[   11.672907][  T203] irq event stamp: 2183
[   11.673161][  T203] hardirqs last  enabled at (2191): [<410b8b5e>] __up_=
console_sem+0x6e/0x80
[   11.673706][  T203] hardirqs last disabled at (2198): [<410b8b45>] __up_=
console_sem+0x55/0x80
[   11.674238][  T203] softirqs last  enabled at (2164): [<41f8ed1c>] __do_=
softirq+0x2ac/0x3b0
[   11.674761][  T203] softirqs last disabled at (2151): [<41023525>] do_so=
ftirq_own_stack+0x25/0x30
[   11.675312][  T203] ---[ end trace 0000000000000000 ]---
[   11.677154][  T618] srcu-scale:--- Start of test: nreaders=3D1 nwriters=
=3D1 verbose=3D1 shutdown=3D0
[   11.677750][  T618] srcu-torture: Creating rcu_scale_reader task
[   11.684278][  T621] srcu-scale: rcu_scale_reader task started
[   11.688805][  T618] srcu-torture: Creating rcu_scale_writer task
[   11.692377][  T622] srcu-scale: rcu_scale_writer task started
[   11.692962][  T204] BUG: unable to handle page fault for address: bab7f4=
00
[   11.693401][  T204] #PF: supervisor write access in kernel mode
[   11.693791][  T204] #PF: error_code(0x0002) - not-present page
[   11.694157][  T204] *pde =3D 7ab81063 *pte =3D 7ab7f060
[   11.694477][  T204] Oops: 0002 [#1]
...

>=20
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Link: https://lore.kernel.org/all/fcf89147-440b-e478-40c9-228c9fe56691@in=
tel.com/
>=20
> --
>=20
> 0day folks, please do share these as they come up.  We want to keep
> fixing them.

We sent another report at:
https://lore.kernel.org/all/202209141701.e293ea84-yujie.liu@intel.com/

The WARNING and Call Trace are slightly different from those in the
first report. Please kindly check if this is a unique one or a
duplicate. Thanks.

> ---
>  arch/x86/mm/pat/set_memory.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 1a2d6376251c..5fb5874ea2c6 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2247,6 +2247,12 @@ static int __set_pages_p(struct page *page, int nu=
mpages)
>  				.mask_clr =3D __pgprot(0),
>  				.flags =3D 0};
> =20
> +	/*
> +	 * Avoid W^X mappings that occur if the old
> +	 * mapping was !_PAGE_RW and !_PAGE_NX.
> +	 */
> +	pgprot_val(cpa.mask_set) |=3D __supported_pte_mask & _PAGE_NX;
> +
>  	/*
>  	 * No alias checking needed for setting present flag. otherwise,
>  	 * we may need to break large pages for 64-bit kernel text
> --=20
> 2.34.1
>=20

We tested this patch, but found it couldn't fix the problem:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/scale_type/tbox_group/testcase:
  gcc-11/i386-randconfig-a013-20211012/debian-i386-20191205.cgz/300s/srcu/v=
m-snb/rcuscale

commit:
  652c5bf380ad0 ("x86/mm: Refuse W^X violations")
  f7b4797d892f9 ("x86/mm: Set NX bit when making pages present")

652c5bf380ad018e f7b4797d892f968e0980fe820f7
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6            0%           6:6     dmesg.BUG:unable_to_handle_pa=
ge_fault_for_address
          6:6            0%           6:6     dmesg.EIP:__change_page_attr
          6:6            0%           6:6     dmesg.Kernel_panic-not_syncin=
g:Fatal_exception
          6:6            0%           6:6     dmesg.Oops:#[##]
          6:6            0%           6:6     dmesg.WARNING:at_arch/x86/mm/=
pat/set_memory.c:#__change_page_attr
          6:6            0%           6:6     dmesg.boot_failures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
  gcc-11/i386-randconfig-a004-20211104/debian-i386-20191205.cgz/300s/vm-snb=
/cpuhotplug/rcutorture/tasks-tracing

commit:
  652c5bf380ad0 ("x86/mm: Refuse W^X violations")
  f7b4797d892f9 ("x86/mm: Set NX bit when making pages present")

652c5bf380ad018e f7b4797d892f968e0980fe820f7
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6            0%           6:6     dmesg.BUG:unable_to_handle_pa=
ge_fault_for_address
          6:6            0%           6:6     dmesg.EIP:verify_rwx
          6:6            0%           6:6     dmesg.Kernel_panic-not_syncin=
g:Fatal_exception
          6:6            0%           6:6     dmesg.Oops:#[##]
          6:6            0%           6:6     dmesg.WARNING:at_arch/x86/mm/=
pat/set_memory.c:#verify_rwx
          6:6            0%           6:6     dmesg.boot_failures

--
Best Regards,
Yujie
