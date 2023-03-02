Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768086A7CFC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCBImA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBIl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:41:58 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C738B4E;
        Thu,  2 Mar 2023 00:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677746509; x=1709282509;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yW9S+bAxbIFcxzNLv4Bx6L+pBTqVIgu5LBzBK+rFcVs=;
  b=m997wHLR1S3U50yWUJ1sP1ruxqPCGo/S0iGuQmaxSXkaVaTO9GHCbr6V
   vtxDG3VJbx7UjqWXDZyff+SpZ0s/lkdQr/1+9SdTzn6BssHHjBJYn8GAd
   ROYz2eUBfxjVmMZQIxCmAKMCGVlz6XBAJ6puXKsnKpQiHyaKQROXsWahm
   5zaKcksudmE1CDKRVsPPUEAO/sxIj4G9toVvFsN+Httw2jm+Wz4bTIXzw
   x4YEDOIF1aWPjdIcqMljmPedhcPmKnQFgKh4p0YvyWXh82DC6yQ2Cu0ig
   7lzo5m10DucdO8Ol8lcxuOEqxBONXTqx3CHdff7ITGyXKWq4SoM/BwkiJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="333387362"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="333387362"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:41:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="743769694"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="743769694"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2023 00:41:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:41:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:41:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 00:41:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNawm9OkrC+vQ+skM80zPJw539X5eq018kLtybgPKt1XXL0qGpjxR4rWwX+UrcbqSKwLLpqf6nEPQqqMZVDAcvbVPXVx0s/CdGOPgamYX/RRHzWQjbn1qcAZQ1Gi+UJabvwFo1AcLDz3NOGKCJPH/6khWLaH7zD+kqJupkNewciWxYvS4MFaaey/LJFgt4HGgWEVQDWsDEDZXj9Ptid7skQOpGtCbyz+HM4ko8/ImBgxehIr7panH+Kt96jrjkhX1c3TDXBTL98DKR+kAAfLTTOCYQ3uWfoarhQc0yBQXMTjY1FwxPYFmhp+IF+Cqqyfk2e+V0C9+U5ilifSOB/ubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjaVjm/qNB9xWW9+phC4b5pSa7mbyiASdL0W29+I/BE=;
 b=H4VW8BfOELRNBCdFxNsoZgzAakqEqE5o64t39bUII2hYCmZf5rmcHxG/7q2xgbuoQVL40gch8V/F8J3LhN309CbDzdYEgNwo2WhwvhEwyIsqq9DanEJ0vBPBGJ6RUjAuL0WpAOVxw98Co+uX/L6UJmeJQji4Wjf1JPVkCGADnQ6zYLWfPG77WBys0XwHWRJzvoNqs2COjVCX/Xflodd/KHlKAzHnxNkP8hPP6Bwp4F7uxoDxpEV7PuTPnBx91/UdSbHcDAcnJsQRiYh09t56uix0CPRstnH1NO4pHxfdjwpCe3xd7LZkLnYW0Z/yIdbcLLSZyfjY/XUdLdYQWU53SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA1PR11MB7344.namprd11.prod.outlook.com (2603:10b6:208:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Thu, 2 Mar
 2023 08:41:44 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::66b:243c:7f3d:db9e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::66b:243c:7f3d:db9e%8]) with mapi id 15.20.6134.030; Thu, 2 Mar 2023
 08:41:44 +0000
Date:   Thu, 2 Mar 2023 16:39:03 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Dave Chinner <dchinner@redhat.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, <linux-xfs@vger.kernel.org>
Subject: Re: [linus:master] [xfs] 304a68b9c6:
 WARNING:at_fs/iomap/buffered-io.c:#iomap_write_delalloc_release
Message-ID: <ZABgp1uBzcE49EG9@yujie-X299>
References: <202302281653.51938721-yujie.liu@intel.com>
 <20230228221107.GD360264@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230228221107.GD360264@dread.disaster.area>
X-ClientProxiedBy: SG2PR06CA0251.apcprd06.prod.outlook.com
 (2603:1096:4:ac::35) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA1PR11MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: a2721a6a-1b88-4867-d650-08db1af9f3f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9nOYQOVD4moOZ2LFI/92CqYysmpEwvmCvBdnZqG7/Zd0gPBOhOTcjEHAoJWjted5WEkDSIV1oa9oqqelhJim7+dKiz6KPPzYSKrDagq9mgf5oPLF0FH/fJTu591XcBy9gSPUAfwmFl6CF6CQ14N/c70LvraNSoG5GST1xgjGaVox3CTbd8yafK7fAQyrtw3v6QSYvhXdYYZQeM+cgsf7zC+zDMeDWJX85vEs12IeEvMtfJcY2nDCXtuofqeXA8SDdEtffxQXU0hfgmbsVUvKNQ/vy+b8rLjCnp27o94UI0OPlMywlEoT3frRMdKiyPBc20OGu7/711CFa50mcw4VkZRl+BuW/czqHKdsJnLPwI0culgK3sISAMCi9g7u5agMguYJiLmdK+shYvnG6OLHnDRF/kJW64Nsybi6fIRjYfn9h+HYznsqAiLGBwdOKYV0Y2Z3UoT7oRJT4lm11sNoC6df07f3j/i/kCB4ROqwUVFDKaGwywWWuSXNXXQBNVRIh0apiFk9PZqA25avEIZIDDLtGOWSMnH+rVOo97M6wKYlQ+S9nT9oZjJTfRA+Nlh/EgqtrnjGT9yPXqt8rOPoizG2QjK7+14yJWkZ4xcK99d4NuvsRUHJPOQDDRI1Xz+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199018)(316002)(86362001)(44832011)(54906003)(33716001)(966005)(6486002)(186003)(45080400002)(9686003)(26005)(6506007)(8676002)(6512007)(30864003)(5660300002)(6916009)(2906002)(478600001)(6666004)(66946007)(41300700001)(66476007)(4326008)(82960400001)(38100700002)(8936002)(66556008)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?31SkLIBSnFDKStjA84bxpFmTKRzII8VnZK7VXgz7jn8+P9dslic/IomFDZBf?=
 =?us-ascii?Q?VD4nS1+qCC5Aqzbqw/RTV0bXNL2RTdcS8EkD0TSvEdqwH4592hQ3z2Bbz8in?=
 =?us-ascii?Q?7gtxaUPtBIC4Aw6Cc9HTQ2fbGJ2KnvyUmrYfdEq+kemovnP0HUV6pPXbsIm6?=
 =?us-ascii?Q?XkVWw7/nkTBLxtfCTsh+oNooAHNXsFmlHTJFFy3813HVctxj1Y3RbMXpbCUF?=
 =?us-ascii?Q?luGnDVt++IJcqrpqXb0Onua+NUl3vP5PRw3qAGoflDKm11gjWwW//KTLHO25?=
 =?us-ascii?Q?UWbg9iwFi6vj2HB25WV37OeC6tiPILXIkcoeM3kNOqWwFcmTmB0taJm7kgWy?=
 =?us-ascii?Q?BnsnNh1O4/Zl7FEk9EhBSI8A1VjDdxCGt3WgQLWzJFJptmboo4z1ZVdU40R/?=
 =?us-ascii?Q?xW+ubYDJv+IaUSeaI4Ocd2dDoAVGC14JI2RYBjwSDLuiyPw/xnJX7NSBGpfT?=
 =?us-ascii?Q?nUolOb7TUtWENyY9ovIAKq3aiF96ssYIdZNFEvIhslzQ5p8Qx/60CVn9xIv5?=
 =?us-ascii?Q?ADnmnCBkV3Sc0L99MjzpBShS90XXMcZagKRCgv1sGs5OOfZYx+x5MIaaAKIo?=
 =?us-ascii?Q?Dxw2W6GNa15Kt7L1H6dikVbGkvbWE9x5B50Fjidk+zSX0qQr9PR4rjurB/d1?=
 =?us-ascii?Q?OvxBZ7b8EfSCWuW/kk4wRMsuN5yS2aO52WLKQ9SHkPExZSJlJ/DxQF+a3dHM?=
 =?us-ascii?Q?bfzwFL/S+wDXF3mOHrYh7p0IUHIJK+mu66Eviy3Rjpaq0xzdajqMCh6qkr9P?=
 =?us-ascii?Q?px4a8C1dtSxaJXcIfYcyuSkUy3ZY/VYLb5xdSjI/Kye4+TThD/nYmOsW4MU3?=
 =?us-ascii?Q?xwadQaUd1MVkahQ061XkK+xSzqzgbjqEtr3ywz02X4qCJ1lEcJ3S3hvuNDJS?=
 =?us-ascii?Q?rEk6zOmA948wK8AFGYOjtLH2cmdSGuVSTlm241dNnHpZPMGrWN6M7iWX/wOw?=
 =?us-ascii?Q?VzE4T3YhQQRV2ByeUAIeUXLsbnXGrpWj0uM+EAJOkxGLwGADEbWAsrIPaoCX?=
 =?us-ascii?Q?XuTrdb/B22PKPdPaZNvshoyf/l0RPMfmcAXL5AvlQsWizaZciX5XGwoavw8A?=
 =?us-ascii?Q?zHWUo12lE2dym40SpykST8RJudKISO9SI2GjpaJ6xJd4vj30DspJSAwmEP3k?=
 =?us-ascii?Q?GuxyN46LqjN7I2qnSq5eCozDPWkfP4tUYNjt7fQIsl/YQHD2s7mmIr9IOQHj?=
 =?us-ascii?Q?lWrvsGsECbY5vDOcplN+SMbU9cZTK+bE5VotZ3grEfGJjlPHK7jitU4ey9DK?=
 =?us-ascii?Q?tydfso0lS+kYUy/hGklLvRV4xxHBTjPIIPQnr30Xyl5WhSWEFePd290GiFqg?=
 =?us-ascii?Q?eNXKAlB8i+9zdBfM5Cu1xGfKv5j2lMCE4+jBI4aAgOcSpgH6MP7hvMh5kAXq?=
 =?us-ascii?Q?fmTHPeVfrdRhj8c+NDW4eNs01e6DbIbeSyNLc0QOjmkjnGMb5J+NGHulMx92?=
 =?us-ascii?Q?GY8Kw0b8DvGiB7dFiUi8PFk41cbTc2dODiqP4W/C2u/WFrNxaKnMrcIfqrgD?=
 =?us-ascii?Q?Mk8gtsYprb6FCNjcFgljEAEj52dRkugPRBdczmJZ8KZ6PxoBjiHG0TF5AWTH?=
 =?us-ascii?Q?x57yctL/zte/aA0NWseSHIkooV0Hx2LUW/LupfQ8Afep9xQ3DzOpe2mh0Lw3?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2721a6a-1b88-4867-d650-08db1af9f3f4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 08:41:44.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+9SU1swMLT5z99SR4pjan4JAlrkqTDw/x19IA0tPhZPMCZ8bBOpMIV/sbckqvNilgHAwjUEPGf1rlOWd/UNlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7344
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 09:11:07AM +1100, Dave Chinner wrote:
> On Tue, Feb 28, 2023 at 04:40:01PM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed WARNING:at_fs/iomap/buffered-io.c:#iomap_write_delalloc_release due to commit (built with gcc-11):
> > 
> > commit: 304a68b9c63bbfc1f6e159d68e8892fc54a06067 ("xfs: use iomap_valid method to detect stale cached iomaps")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linux-next/master 058f4df42121baadbb8a980c06011e912784dbd2]
> > in testcase: xfstests
> > version: xfstests-i386-5a5e419-1_20220926
> > with following parameters:
> > 
> > 	disk: 4HDD
> > 	fs: xfs
> > 	test: generic-group-32
> 
> Which fstest was running at the time this warning was thrown?

It is fstests generic/648 running at that time.

> > 
> > test-description: xfstests is a regression test suite for xfs and other files ystems.
> > test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 28G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > [   78.565703][   T59] ------------[ cut here ]------------
> > [ 78.570983][ T59] WARNING: CPU: 4 PID: 59 at fs/iomap/buffered-io.c:984 iomap_write_delalloc_release (buffered-io.c:?) 
> 
> Well, that's useless without the function offset or line number to
> tell us what warning in that function triggered.
> 
> > [   78.581265][   T59] Modules linked in: loop(E) dm_flakey(E) xfs(E) dm_mod(E) intel_rapl_msr(E) intel_rapl_common(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) zstd_compress(E) x86_pkg_temp_thermal(E) libcrc32c(E) intel_powerclamp(E) crc32c_generic(E) coretemp(E) sd_mod(E) t10_pi(E) ipmi_devintf(E) kvm_intel(E) ipmi_msghandler(E) i915(E) crc64_rocksoft_generic(E) kvm(E) irqbypass(E) crc64_rocksoft(E) crc64(E) drm_buddy(E) crc32_pclmul(E) crc32c_intel(E) aesni_intel(E) crypto_simd(E) drm_display_helper(E) cryptd(E) cec(E) mei_wdt(E) wmi_bmof(E) rapl(E) ahci(E) evdev(E) ttm(E) xhci_pci(E) intel_cstate(E) xhci_hcd(E) libahci(E) i2c_i801(E) mei_me(E) drm_kms_helper(E) syscopyarea(E) intel_uncore(E) usbcore(E) i2c_smbus(E) sysfillrect(E) libata(E) mei(E) sysimgblt(E) intel_pch_thermal(E) fb_sys_fops(E) usb_common(E) video(E) fan(E) thermal(E) wmi(E) acpi_pad(E) button(E) fuse(E) drm(E) configfs(E) autofs4(E)
> > [   78.661092][   T59] CPU: 4 PID: 59 Comm: kworker/u16:2 Tainted: G            E      6.1.0-rc4-00008-g304a68b9c63b #1
> 
> This looks like a broken kernel install. Why are all the modules
> tainted?

Sorry, this seems to be a bug when we built the modules. We are still
investigating it and will fix it once we find the root cause.

> > [   78.671542][   T59] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
> > [   78.679578][   T59] Workqueue: loop0 loop_rootcg_workfn [loop]
> > [ 78.685393][ T59] EIP: iomap_write_delalloc_release (buffered-io.c:?) 
> > [ 78.691449][ T59] Code: e8 cf 94 ed ff f0 ff 4b 1c 74 45 8b 45 e0 8b 40 20 83 c0 10 e8 ab 93 d8 ff 8d 65 f4 89 f0 5b 5e 5f 5d c3 0f 0b e9 f9 fd ff ff <0f> 0b e9 e0 fd ff ff 0f 0b 8b 45 cc 8b 4d f0 8b 55 d0 39 c8 89 d0
> > All code
> > ========
> >    0:	e8 cf 94 ed ff       	callq  0xffffffffffed94d4
> >    5:	f0 ff 4b 1c          	lock decl 0x1c(%rbx)
> >    9:	74 45                	je     0x50
> >    b:	8b 45 e0             	mov    -0x20(%rbp),%eax
> >    e:	8b 40 20             	mov    0x20(%rax),%eax
> >   11:	83 c0 10             	add    $0x10,%eax
> >   14:	e8 ab 93 d8 ff       	callq  0xffffffffffd893c4
> >   19:	8d 65 f4             	lea    -0xc(%rbp),%esp
> >   1c:	89 f0                	mov    %esi,%eax
> >   1e:	5b                   	pop    %rbx
> >   1f:	5e                   	pop    %rsi
> >   20:	5f                   	pop    %rdi
> >   21:	5d                   	pop    %rbp
> >   22:	c3                   	retq   
> >   23:	0f 0b                	ud2    
> >   25:	e9 f9 fd ff ff       	jmpq   0xfffffffffffffe23
> >   2a:*	0f 0b                	ud2    		<-- trapping instruction
> >   2c:	e9 e0 fd ff ff       	jmpq   0xfffffffffffffe11
> >   31:	0f 0b                	ud2    
> >   33:	8b 45 cc             	mov    -0x34(%rbp),%eax
> >   36:	8b 4d f0             	mov    -0x10(%rbp),%ecx
> >   39:	8b 55 d0             	mov    -0x30(%rbp),%edx
> >   3c:	39 c8                	cmp    %ecx,%eax
> >   3e:	89 d0                	mov    %edx,%eax
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	0f 0b                	ud2    
> >    2:	e9 e0 fd ff ff       	jmpq   0xfffffffffffffde7
> >    7:	0f 0b                	ud2    
> >    9:	8b 45 cc             	mov    -0x34(%rbp),%eax
> >    c:	8b 4d f0             	mov    -0x10(%rbp),%ecx
> >    f:	8b 55 d0             	mov    -0x30(%rbp),%edx
> >   12:	39 c8                	cmp    %ecx,%eax
> >   14:	89 d0                	mov    %edx,%eax
> > [   78.710792][   T59] EAX: 2335a000 EBX: 00000004 ECX: fffffffc EDX: 00000004
> > [   78.717707][   T59] ESI: 2335b000 EDI: 00000000 EBP: c3187c24 ESP: c3187bf0
> > [   78.724624][   T59] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010297
> > [   78.732056][   T59] CR0: 80050033 CR2: b7da00b0 CR3: 02350000 CR4: 003506f0
> > [   78.738971][   T59] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [   78.745887][   T59] DR6: fffe0ff0 DR7: 00000400
> > [   78.750389][   T59] Call Trace:
> > [ 78.753508][ T59] iomap_file_buffered_write_punch_delalloc (??:?) 
> > [ 78.760183][ T59] ? xfs_buffered_write_iomap_end (xfs_iomap.c:?) xfs
> > [ 78.766541][ T59] xfs_buffered_write_iomap_end (xfs_iomap.c:?) xfs
> 
> What's with all the broken/missing function offsets and
> file/line numbers in the stack trace?
> 
> Please fix your tooling - this report isn't useful with all the
> offset/line number information being broken like this

Sorry for missing the offsets and numbers. The binutils version was
outdated in our environment and failed to parse symbols correctly in
latest kernels. We've upgraded binutils and here is the new decoded
stacktrace:

[ 70.647665][ T1431] run fstests generic/648 at 2023-02-28 01:01:42
[ 71.823863][ T6673] XFS (sda4): Mounting V5 Filesystem
[ 71.883835][ T6673] XFS (sda4): Ending clean mount
[ 71.889345][ T6673] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
[ 71.942655][ T6686] XFS (sda4): Unmounting Filesystem
[ 72.055909][ T6718] loop: module verification failed: signature and/or required key missing - tainting kernel
[ 72.066111][ T6718] calling loop_init+0x0/0x1000 [ loop] @ 6718
[ 72.073700][ T6718] loop: module loaded
[ 72.077534][ T6718] initcall loop_init+0x0/0x1000 [ loop] returned 0 after 5536 usecs
[ 73.097330][ T6767] XFS (dm-0): Mounting V5 Filesystem
[ 73.261204][ T6767] XFS (dm-0): Ending clean mount
[ 73.267558][ T6767] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
[ 73.335169][ T6801] loop0: detected capacity change from 0 to 138745493
[ 73.374666][ T6801] XFS (loop0): Mounting V5 Filesystem
[ 73.382659][ T6801] XFS (loop0): Ending clean mount
[ 73.387588][ T6801] xfs filesystem being mounted at /tmp/6480.mount supports timestamps until 2038 (0x7fffffff)
[ 74.446227][ T3540] Buffer I/O error on dev dm-1, logical block 52428784, async page read
[ 74.457497][ T66] dm-0: writeback error on inode 131, offset 131072, sector 78144
[ 74.457500][ T66] dm-0: writeback error on inode 131, offset 262144, sector 74928
[ 74.459752][ T3540] Buffer I/O error on dev dm-0, logical block 52428784, async page read
[ 74.465109][ T66] dm-0: writeback error on inode 131, offset 2228224, sector 78400
[ 74.480852][ T66] dm-0: writeback error on inode 131, offset 3969024, sector 78504
[ 74.488596][ T66] dm-0: writeback error on inode 131, offset 4005888, sector 78576
[ 74.496292][ T66] dm-0: writeback error on inode 131, offset 4063232, sector 192
[ 74.496418][ C3] I/O error, dev loop0, sector 69373014 op 0x1:(WRITE) flags 0x9800 phys_seg 1 prio class 2
[ 74.521346][ T144] XFS (loop0): log I/O error -5
[ 74.526022][ T144] XFS (loop0): Filesystem has been shut down due to log error (0x2).
[ 74.533882][ T144] XFS (loop0): Please unmount the filesystem and rectify the problem(s).
[ 74.542294][ T67] dm-0: writeback error on inode 131, offset 53279154176, sector 78688
[ 74.542299][ C3] I/O error, dev loop0, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 2
[ 75.364416][ T6868] XFS (loop0): Unmounting Filesystem
[ 75.370061][ T164] XFS (dm-0): log I/O error -5
[ 75.374652][ T164] XFS (dm-0): Filesystem has been shut down due to log error (0x2).
[ 75.382433][ T164] XFS (dm-0): Please unmount the filesystem and rectify the problem(s).
[ 75.390581][ C6] I/O error, dev loop0, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 2
[ 76.403161][ T6876] XFS (dm-0): Unmounting Filesystem
[ 76.554265][ T6888] XFS (dm-0): Mounting V5 Filesystem
[ 76.602707][ T6888] XFS (dm-0): Starting recovery (logdev: internal)
[ 76.678261][ T6888] XFS (dm-0): Ending recovery (logdev: internal)
[ 76.705011][ T6888] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
[ 76.720823][ T6905] loop0: detected capacity change from 0 to 138745493
[ 76.765868][ T6905] XFS (loop0): Mounting V5 Filesystem
[ 76.811151][ T6905] XFS (loop0): Starting recovery (logdev: internal)
[ 76.820611][ T6905] XFS (loop0): Ending recovery (logdev: internal)
[ 76.826950][ T6905] xfs filesystem being mounted at /tmp/6480.mount supports timestamps until 2038 (0x7fffffff)
[ 78.565703][ T59] ------------[ cut here ]------------
[ 78.570983][ T59] WARNING: CPU: 4 PID: 59 at fs/iomap/buffered-io.c:984 iomap_write_delalloc_release (fs/iomap/buffered-io.c:984 (discriminator 1))
[ 78.581265][ T59] Modules linked in: loop(E) dm_flakey(E) xfs(E) dm_mod(E) intel_rapl_msr(E) intel_rapl_common(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) zstd_compress(E) x86_pkg_temp_thermal(E) libcrc32c(E) intel_powerclamp(E) crc32c_generic(E) coretemp(E) sd_mod(E) t10_pi(E) ipmi_devintf(E) kvm_intel(E) ipmi_msghandler(E) i915(E) crc64_rocksoft_generic(E) kvm(E) irqbypass(E) crc64_rocksoft(E) crc64(E) drm_buddy(E) crc32_pclmul(E) crc32c_intel(E) aesni_intel(E) crypto_simd(E) drm_display_helper(E) cryptd(E) cec(E) mei_wdt(E) wmi_bmof(E) rapl(E) ahci(E) evdev(E) ttm(E) xhci_pci(E) intel_cstate(E) xhci_hcd(E) libahci(E) i2c_i801(E) mei_me(E) drm_kms_helper(E) syscopyarea(E) intel_uncore(E) usbcore(E) i2c_smbus(E) sysfillrect(E) libata(E) mei(E) sysimgblt(E) intel_pch_thermal(E) fb_sys_fops(E) usb_common(E) video(E) fan(E) thermal(E) wmi(E) acpi_pad(E) button(E) fuse(E) drm(E) configfs(E) autofs4(E)
[ 78.661092][ T59] CPU: 4 PID: 59 Comm: kworker/u16:2 Tainted: G            E      6.1.0-rc4-00008-g304a68b9c63b #1
[ 78.671542][ T59] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
[ 78.679578][ T59] Workqueue: loop0 loop_rootcg_workfn [ loop]
[ 78.685393][ T59] EIP: iomap_write_delalloc_release (fs/iomap/buffered-io.c:984 (discriminator 1))
[ 78.691449][ T59] Code: e8 cf 94 ed ff f0 ff 4b 1c 74 45 8b 45 e0 8b 40 20 83 c0 10 e8 ab 93 d8 ff 8d 65 f4 89 f0 5b 5e 5f 5d c3 0f 0b e9 f9 fd ff ff <0f> 0b e9 e0 fd ff ff 0f 0b 8b 45 cc 8b 4d f0 8b 55 d0 39 c8 89 d0
All code
========
   0:   e8 cf 94 ed ff          call   0xffffffffffed94d4
   5:   f0 ff 4b 1c             lock decl 0x1c(%rbx)
   9:   74 45                   je     0x50
   b:   8b 45 e0                mov    -0x20(%rbp),%eax
   e:   8b 40 20                mov    0x20(%rax),%eax
  11:   83 c0 10                add    $0x10,%eax
  14:   e8 ab 93 d8 ff          call   0xffffffffffd893c4
  19:   8d 65 f4                lea    -0xc(%rbp),%esp
  1c:   89 f0                   mov    %esi,%eax
  1e:   5b                      pop    %rbx
  1f:   5e                      pop    %rsi
  20:   5f                      pop    %rdi
  21:   5d                      pop    %rbp
  22:   c3                      ret
  23:   0f 0b                   ud2
  25:   e9 f9 fd ff ff          jmp    0xfffffffffffffe23
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   e9 e0 fd ff ff          jmp    0xfffffffffffffe11
  31:   0f 0b                   ud2
  33:   8b 45 cc                mov    -0x34(%rbp),%eax
  36:   8b 4d f0                mov    -0x10(%rbp),%ecx
  39:   8b 55 d0                mov    -0x30(%rbp),%edx
  3c:   39 c8                   cmp    %ecx,%eax
  3e:   89 d0                   mov    %edx,%eax

Code starting with the faulting instruction
===========================================
   0:   0f 0b                   ud2
   2:   e9 e0 fd ff ff          jmp    0xfffffffffffffde7
   7:   0f 0b                   ud2
   9:   8b 45 cc                mov    -0x34(%rbp),%eax
   c:   8b 4d f0                mov    -0x10(%rbp),%ecx
   f:   8b 55 d0                mov    -0x30(%rbp),%edx
  12:   39 c8                   cmp    %ecx,%eax
  14:   89 d0                   mov    %edx,%eax
[ 78.710792][ T59] EAX: 2335a000 EBX: 00000004 ECX: fffffffc EDX: 00000004
[ 78.717707][ T59] ESI: 2335b000 EDI: 00000000 EBP: c3187c24 ESP: c3187bf0
[ 78.724624][ T59] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010297
[ 78.732056][ T59] CR0: 80050033 CR2: b7da00b0 CR3: 02350000 CR4: 003506f0
[ 78.738971][ T59] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[ 78.745887][ T59] DR6: fffe0ff0 DR7: 00000400
[ 78.750389][ T59] Call Trace:
[ 78.753508][ T59] iomap_file_buffered_write_punch_delalloc (fs/iomap/buffered-io.c:1078)
[ 78.760183][ T59] ? xfs_buffered_write_iomap_end (fs/xfs/xfs_iomap.c:1175) xfs
[ 78.766541][ T59] xfs_buffered_write_iomap_end (fs/xfs/xfs_iomap.c:1204) xfs
[ 78.772720][ T59] ? xfs_buffered_write_iomap_end (fs/xfs/xfs_iomap.c:1175) xfs
[ 78.779078][ T59] ? xfs_alert_fsblock_zero (fs/xfs/xfs_iomap.c:1188) xfs
[ 78.784893][ T59] iomap_iter (fs/iomap/iter.c:82)
[ 78.788960][ T59] iomap_file_buffered_write (fs/iomap/buffered-io.c:850)
[ 78.794323][ T59] xfs_file_buffered_write (fs/xfs/xfs_file.c:726) xfs
[ 78.800191][ T59] ? __update_load_avg_se (kernel/sched/pelt.c:77 kernel/sched/pelt.c:135 kernel/sched/pelt.c:226 kernel/sched/pelt.c:308)
[ 78.805382][ T59] xfs_file_write_iter (fs/xfs/xfs_file.c:803) xfs
[ 78.810864][ T59] ? apparmor_file_permission (security/apparmor/include/cred.h:122 security/apparmor/lsm.c:496 security/apparmor/lsm.c:509)
[ 78.816314][ T59] do_iter_readv_writev (include/linux/fs.h:2191 fs/read_write.c:735)
[ 78.821246][ T59] do_iter_write (fs/read_write.c:861)
[ 78.825572][ T59] ? xfs_file_buffered_write (fs/xfs/xfs_file.c:773) xfs
[ 78.831676][ T59] vfs_iter_write (fs/read_write.c:902)
[ 78.836017][ T59] lo_write_simple+0x5f/0x290 loop
[ 78.841733][ T59] loop_process_work (drivers/block/loop.c:495 drivers/block/loop.c:1864 drivers/block/loop.c:1899) loop
[ 78.847111][ T59] ? wb_workfn (include/linux/jump_label.h:207 (discriminator 1) include/linux/jump_label.h:207 (discriminator 1) include/trace/events/writeback.h:395 (discriminator 1) fs/fs-writeback.c:2228 (discriminator 1))
[ 78.851287][ T59] ? try_to_wake_up (kernel/sched/core.c:4196)
[ 78.855887][ T59] ? __switch_to_asm (arch/x86/entry/entry_32.S:708)
[ 78.860483][ T59] loop_rootcg_workfn (drivers/block/loop.c:1931) loop
[ 78.865772][ T59] process_one_work (kernel/workqueue.c:2294)
[ 78.870450][ T59] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437)
[ 78.874866][ T59] kthread (kernel/kthread.c:376)
[ 78.878591][ T59] ? process_one_work (kernel/workqueue.c:2379)
[ 78.883438][ T59] ? kthread_complete_and_exit (kernel/kthread.c:331)
[ 78.888887][ T59] ret_from_fork (arch/x86/entry/entry_32.S:770)
[ 78.893130][ T59] ---[ end trace 0000000000000000 ]---


--
Best Regards,
Yujie
