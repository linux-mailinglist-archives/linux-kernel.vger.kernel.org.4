Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76DE6A90CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCCGQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCCGQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:16:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441283D923;
        Thu,  2 Mar 2023 22:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677824185; x=1709360185;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vu0OXj97kGNNe8luzXyObYx/Yq1pj/wRscj/9gk4I+s=;
  b=XB7Ug3B3qlHbNxEnxRDLbDY8JgmjcSqdbTdUJt16+GvQZSvv6N+9euV7
   qMEeQ7mV4qyTfiC5d4FcyTRRsdSn88SK6a1z6B7XRZMMKyXs0+pCCBkSg
   I1P5zsIYYzjFTryR4qSdKiysXaHr+0RzVZfbD5NCyECsXFEFUaCf85WgB
   AIEeLQMBL1zE8rTVKBYagjalrvcnreHtg0cEEI8PfaV0C4n81WAzcEfmH
   YU5yP2+ZRe7xzw5l+GrsohUCjIAfMi8Eth9E2mYAPmfnyCESwe/tOxUjG
   CwPKZzRFZVyx3MwPEbU9M2G8yi3wqwttYwrn24nlPpL8D9LwFHpPKnGRl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="334988192"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="334988192"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 22:16:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="707716716"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="707716716"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 02 Mar 2023 22:16:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 22:16:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 22:16:24 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 22:16:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzbcHo3lMJT09nWSZJUsJ9+LDMvSGg3G6yaOcC/12DeZ0OWG0RkCkHUQ1zO9CSWZ5olQ5dJ7wBNCEh0YluO9/xP+B27Vt+oa1/EPMzVvGa7r38cgOzCpjId9Sz9sSsmefUYmDU1B9ucu3cglXC1UeuhSv7h/atRl2S9RUdTMLF9rBGQ/+rEUpJTsRRuG4oIE+ol4L6w2tGRzqB8eiMCUiz9X4cd4RODa4PnAZue2tsPI2r5j9lq9cpL6fhtiNw4KjA0JAFLd9ZFrE+AZDDJq6EsaV0hbG/LBUn5ahsBUKDgJkT4OQEjPcpiQddLGh2n4lNLY8HuBDvuEiyt0XNjOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlpA7JiHBLGsBbZt3VJ3rfYtstFbGxG7J6GJkitoYO8=;
 b=jc4g9nY0zqU+8bSjhQ7Jf90EyC0YUFgLBL/XR8B7ekgGAowJcJtI3HAWJnJV946o9/81fIeJGPYPa/ok9pEjU1fEqTjbYjsYYDDh/pwv7BpHdLdx1Dhx7O7KEauL11pv39ywCfFr2edO7qwU8UovN6SGHUlTzCiLHKEsJko3pUWvpQh5zbey9PtSlHEhgCHkP/VBsuUk0yo2YSZurFjYudY+074f4XD5o7JkeVFUib1d9nDNKCIbD40hCU+eJTBSEfwF4NovHFjv16F+SV1Edwlh90/v+xumlB8YeJvX78mfoYSDFrPMolFftP533PRtydHPaWM8cY/6zvls20al6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH0PR11MB7659.namprd11.prod.outlook.com (2603:10b6:510:28e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 06:16:20 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::66b:243c:7f3d:db9e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::66b:243c:7f3d:db9e%3]) with mapi id 15.20.6156.020; Fri, 3 Mar 2023
 06:16:20 +0000
Date:   Fri, 3 Mar 2023 14:13:38 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Dave Chinner <dchinner@redhat.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, <linux-xfs@vger.kernel.org>
Subject: Re: [linus:master] [xfs] 304a68b9c6:
 WARNING:at_fs/iomap/buffered-io.c:#iomap_write_delalloc_release
Message-ID: <ZAGQEtkTtJ3JeaPW@yujie-X299>
References: <202302281653.51938721-yujie.liu@intel.com>
 <20230228221107.GD360264@dread.disaster.area>
 <ZABgp1uBzcE49EG9@yujie-X299>
 <20230302222122.GJ360264@dread.disaster.area>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230302222122.GJ360264@dread.disaster.area>
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH0PR11MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 71697421-fae2-4914-70da-08db1baece66
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+SM+k+D0G0xs/mLZKBlAwKdf57VpqrkIfoHu5KQAYB934epUwJu8Km92eSAoxPRJOEeGuZLnV7Nka0gEEX5HN1SSb3QzjKJBf04cGTNStf/7EKiFAYuHRxVkPxPZZjD6UuqXcIO99eXMWGmM2QAS4jBJNPIYz3nqb+9BUjBdzQUHnWWvYatv+X9ctRY6UY/iYDTPmJp3L53+Z/KNDTFayDIYENLjIIdbeodCMaW3k0j6pgSeyjc96DXWjTBtb7J92SvVp90qeEg5qKx7HNM3UUql7TgrhjBRa85MdG8bl1hbHpByWFXgRNRY5fEhpFo1dlkKIryAZxZe9PV0k9K7Ew06vznxxkTg/x9pV4Tc/p8OIfhmqLJsM4gLvpPzhCTHlan86wZi+GYtR4hiOkLRURjYsfnUOshC+eJIi3GHIBLSdlaiDdhXooZ/lbSU5DwYp0RNkzj5xGcG+Aceo/7zgNvrpmKPM4TfR+KtfQ2Vvxr6jcIIbI957uroNwzs7r/WmZD1VcR9pkfhm9S9r7Lt9mW6OQvFgjqNXPa/k2v3a4JpEhIg6BpNsi99FyshOlHaaB8bC4kuIvenj8zbrlxkA0P5Rg4UE2QBEiWKGqfuGvChhV3kkotCdoXeEwCyyzDfRVwJdsb7bw8jgKCifThCIAjv3tGStLrQobqFSjwz2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199018)(8936002)(2906002)(5660300002)(4326008)(66946007)(6916009)(8676002)(66556008)(66476007)(41300700001)(9686003)(82960400001)(38100700002)(44832011)(186003)(26005)(54906003)(83380400001)(316002)(6512007)(6666004)(86362001)(6506007)(478600001)(33716001)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SvIB8Sl8zFiVaQztCuZ5CzJaqC5jvG8bKKuadRc1MA7C/5LGw0DSsKoVvbTw?=
 =?us-ascii?Q?Nx+TQRSCdIYWF46hD0dFioM6JP5lo9WSC6sbQQGXSusYzyCumM7TUf/Z6CML?=
 =?us-ascii?Q?Gj4o091hDuKaZf8Vpc/YW16JjuGQZ+q93rfgMm4NoWt+TCvEWUb8Lj3wB8rH?=
 =?us-ascii?Q?javtY7Avrk/7tA92phSw9AX8bNDIacBSH3WT4NzW46Hw3ySvPBH0Fyf8EUNh?=
 =?us-ascii?Q?YqXzli8Jb8kJP5zUsbCtRWzoDQOntHlQ3ezZ9A7NHl9CSfjDFlAGSuIjFHyi?=
 =?us-ascii?Q?EhkSwEmlR+0AsoLXefCqR+ovH5FQA3lqkuTZOfkb8tYUIVNIsbyFmyCYPrHp?=
 =?us-ascii?Q?BUR/7KbeZrLwbDDOJVuHieSPVDwL+/vpH7bSRv/+OTFV++MqBNJ4DptyFged?=
 =?us-ascii?Q?5X+n41HW7TB8MkufUgEmlznLEBtrgT/Thon7ul4kvMeHg22CK2TwOBjx1tH7?=
 =?us-ascii?Q?usrO0LGqbZGRHic2GFdnqWKVbOTzdKN9rnqr6WEk+75RPjAkPoiN1DQWAgcO?=
 =?us-ascii?Q?ChCZuZvaIbhQIQMNT9cKFbotRDLw0N7a2XMWAkvby84Q+AIY8B3LIe6zzdFi?=
 =?us-ascii?Q?zVdRpn2NILUiWd68pV/p/kx2TzP/StsgMbjkLk6nIUVxwCxazcjiJ0tdEpkK?=
 =?us-ascii?Q?vH3EwY15npPjYpcZfXGkneuCAh0lKaFSkAIQLbGBLD+u9zgFIb5a0x55IAbj?=
 =?us-ascii?Q?lsJJjNFNxQ+a4zbw0TRYQ2GPkVg5H70pE3xl/ZuZB+rkRWNE5vJsJ5bGwj2W?=
 =?us-ascii?Q?t+QuVVBfH+FM7yTZgI7Id5Fw+gbKJvy1bNnmOltvJn0rk0cuJOg4ht268FPO?=
 =?us-ascii?Q?ctfQg/Z4GN5XJlGNA6ceg/VoTF1X2UyleqiK++A/wzVCRTyfdAfVsNmn8FXY?=
 =?us-ascii?Q?af8FMai9Bwvui5y3548eHlqmoJ+QnLNaO6aFmMltEmK4NjtRBC+7ngdIu8UQ?=
 =?us-ascii?Q?GcBFyUp+Y3Q9LsAd/MW37TiGzCXu/jpxVan/EAFebYtSDkArPIcBnWzm1CVB?=
 =?us-ascii?Q?6z+7T4Cmd/Ajuvi4T1ywAeoAWZAWO2iWBkF5gZMnDqJmie/l6Tb2jclSmfbQ?=
 =?us-ascii?Q?1+XvdU7AbbZrc8VVLm+xJs5h0Xqe86HFefaxYAWIbUbqu4haU9kF7PBu9wbA?=
 =?us-ascii?Q?sp9FZnT6I6XwcSGPBgMSrB9fpmaUwY+j3YcCwl5dOcUORPHU3U2+w1Hp2i/I?=
 =?us-ascii?Q?zzlHuBTahDT2UkOeYlX/UZ39l6qHcuLTuYii/6uEaFJDhSqhm9xgbgLqpxkY?=
 =?us-ascii?Q?3ebRlrFoCt+9jxz1b6QtuwshORFXRbUvKoa4zd3AQmFjNRlrOwZtjDF+Ybzn?=
 =?us-ascii?Q?p9Y8GdIg35EWuxGWQbIAdo9lqO03rPEmrPXV7PVf0O9G/zkXZIkKYEA3Mif1?=
 =?us-ascii?Q?FBTAxo0oyI4lBIjaReqVfKS1fliKUVVC6SWWHQ8dfi61F2iR+yrw8OD0fZGJ?=
 =?us-ascii?Q?uYnpuMMMAgScIaIKYocCH/dbdzOKoOBVgWWq0fd2UqL1xTa7N2KFQ+e35cKQ?=
 =?us-ascii?Q?hGObAL8Rcbu08P6wKZAxzjHPzYDGruvuUJYb0yu07PfxzgWFp7vg+jk8p6Hp?=
 =?us-ascii?Q?55kR/u93J8o7TLrnbhuNhjrhhR3tuyLU/bdRWkJy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71697421-fae2-4914-70da-08db1baece66
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 06:16:20.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZGAEaB6JuvMX8KTcMPrhACfci9KbX7zOJEr1JSNC1Ov/aGeTw10fPsSF0UBOKGux8oprfsm8GtNCqzT3Cw/gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7659
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 09:21:22AM +1100, Dave Chinner wrote:
> On Thu, Mar 02, 2023 at 04:39:03PM +0800, Yujie Liu wrote:
> > On Wed, Mar 01, 2023 at 09:11:07AM +1100, Dave Chinner wrote:
> > > On Tue, Feb 28, 2023 at 04:40:01PM +0800, kernel test robot wrote:
> > > > Greeting,
> > > > 
> > > > FYI, we noticed WARNING:at_fs/iomap/buffered-io.c:#iomap_write_delalloc_release due to commit (built with gcc-11):
> > > > 
> > > > commit: 304a68b9c63bbfc1f6e159d68e8892fc54a06067 ("xfs: use iomap_valid method to detect stale cached iomaps")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > 
> > > > [test failed on linux-next/master 058f4df42121baadbb8a980c06011e912784dbd2]
> > > > in testcase: xfstests
> > > > version: xfstests-i386-5a5e419-1_20220926
> > > > with following parameters:
> > > > 
> > > > 	disk: 4HDD
> > > > 	fs: xfs
> > > > 	test: generic-group-32
> > > 
> > > Which fstest was running at the time this warning was thrown?
> > 
> > It is fstests generic/648 running at that time.
> 
> Ok.
> 
> Can you add this patch and see if it fixes the problem?
> 
> https://lore.kernel.org/linux-xfs/20230301221227.GH360264@dread.disaster.area/

We applied this patch on commit 304a68b9c63b and tested it, but cannot
fix the problem.

=========================================================================================
compiler/disk/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/4HDD/xfs/i386-debian-10.3-func/debian-11.1-i386-20220923.cgz/lkp-skl-d01/generic-group-32/xfstests

commit:
  d7b64041164c ("iomap: write iomap validity checks")
  304a68b9c63b ("xfs: use iomap_valid method to detect stale cached iomaps")
  e5a7d5f824ad ("xfs: fix off-by-one-block in xfs_discard_folio()")

d7b64041164ca177 304a68b9c63bbfc1f6e159d68e8 e5a7d5f824ad7409f85e2665d11
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :6           50%           3:3          100%           3:3     dmesg.EIP:iomap_write_delalloc_release
           :6           50%           3:3          100%           3:3     dmesg.WARNING:at_fs/iomap/buffered-io.c:#iomap_write_delalloc_release

> > [ 78.565703][ T59] ------------[ cut here ]------------
> > [ 78.570983][ T59] WARNING: CPU: 4 PID: 59 at fs/iomap/buffered-io.c:984 iomap_write_delalloc_release (fs/iomap/buffered-io.c:984 (discriminator 1))
> 
> Ok, that is:
> 
> 	WARN_ON_ONCE(start_byte < punch_start_byte);
> 
> Which I can't immediately see how that happens. This is a 32-bit
> i386 kernel which we largely don't test or support, so maybe there's
> 32/64 bit variable size change problem somewhere in the code path
> being executed.
> 
> > [ 78.671542][ T59] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
> > [ 78.679578][ T59] Workqueue: loop0 loop_rootcg_workfn [ loop]
> 
> Ok, so this is happening while writing to the loopback image file
> which is racing with cloning and removing the clone of the image
> file.
> 
> Looking at the rest of the trace, IO to the entire loopback file
> hung, but this warning doesn't explain that happening either.
> 
> I'll try to reproduce it, but I don't actually have an i386 test
> environment here (I haven't tested i386 at all the last 5-6
> years!) so it might be a while before I can get to testing this
> specific environment.
> 
> Do you see it reproduce on any other architecture, of just this one?

It can be reproduced on i386, but not on x86_64. Sorry that we don't
have machines of other architectures in the robot infrastructure.

=========================================================================================
commit/compiler/disk/fs/kconfig/rootfs/tbox_group/test/testcase:
  304a68b9c63bbfc1f6e159d68e8892fc54a06067/gcc-11/4HDD/xfs/x86_64-rhel-8.3-func/debian-11.1-x86_64-20220510.cgz/lkp-skl-d01/generic-group-32/xfstests

commit/compiler/disk/fs/kconfig/rootfs/tbox_group/test/testcase:
  304a68b9c63bbfc1f6e159d68e8892fc54a06067/gcc-11/4HDD/xfs/i386-debian-10.3-func/debian-11.1-i386-20220923.cgz/lkp-skl-d01/generic-group-32/xfstests

kconfig:
  x86_64-rhel-8.3-func
  i386-debian-10.3-func

x86_64-rhel-8.3-func   i386-debian-10.3-func
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :3          100%           3:3     dmesg.EIP:iomap_write_delalloc_release
           :3          100%           3:3     dmesg.WARNING:at_fs/iomap/buffered-io.c:#iomap_write_delalloc_release

--
Best Regards,
Yujie
