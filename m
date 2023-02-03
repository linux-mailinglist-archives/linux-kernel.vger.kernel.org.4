Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD21688CDF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 03:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjBCCH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 21:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjBCCH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:07:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518E565F21
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 18:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675390045; x=1706926045;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K6mEsPm4V3plRTRJT0UpYr2u6RTRYUPzL+tB3rQ3o0s=;
  b=Cgl1tVeFAirxlw0QFCkwd3VUfvu8x8Kg0m0AEQ1acS88ShERR8WuJk2C
   QO+eDuOJGXLXFqdFLafnN6e0Hao7P/uvThI344wSCQlSYQv6aS83GD0dD
   6I4Xu4vXiP4FDaNi8y5SwuQrP+8YCPjrKrj9Ek4XFprQwbdVY6QqaFYIL
   Ii2bkXr3Xk1uJrYgnBPu5N1Kxp61lWKe34Nz8QSe9ECrOZSFLXmAE6j7n
   cDEE2nkpR9kumNYY1coCOgq/nmYRnYTsciiULzB7Xt84LaNyO5/u6xLMv
   FAQpDUeoneIXY0oOgLBa6a63roqRru11i7ZjX4uQ2slKetQFV7tTrUdDR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="328650831"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="328650831"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 18:07:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="734152459"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="734152459"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2023 18:07:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 18:07:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 18:07:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 18:07:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htj8iTeCsuq3UPdrG3J2g3FZIiXIf7wpsnSIjR0OI7Cku1iOkP4VXW8QynyAuI7S5iI3GB+hF/VFqTCvxNUeNs/VaWAgoUcAB+zjgAvfpRe7aT2wSu1iCIKMdc+P38BbfLDI8/f+o62ySb+waThn/Wch8neZhAOroohMtngdFudWyAZWWzE7UER0tVKQHgOsrjlidM0L8YIoL0zOEtfWZ9qVwmG7YlwmgyN2FQ70aw8HwGfHmyo6izSFGfDBNIGXFeZyCz4uy76G5tKSz/ycKfa2qfJSqpcOhIeKrsMR9M1nH5sV3HdytukDRJyXHu1QF/0TDZ636YPcgTE8Pp8DWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07X3Z+SmGDaMoE4Fofi7p/BDvsIPz1Kgg0AlG7TKBsA=;
 b=F0D8/m5CUziRl/IbttiWj83y3izG0Jeu9EovSwf7FLn9v3YQZubcg1m8+gnv4WbIIt9L6xGZRetgZa+rRosRCifKX26lcgVl3lpbnNkNf+SFrO5nTOaA/+XRq9R6NpOIP8XzpHRbEfuzdkTRNmJVqkNEKT0D3muB/W45esUDY9YJtJim//vAALMKpLLZwM13sOnAiuPz0EU3f+P33CTNoJ3f0GQMu4K46ka2dkwGAdD0aGdypCH3UiSC0/TorHd4owsy0nddWJk4XbQwRKl5IqhTiRomciCl3Y4LVAPxTIUul0YlUhRph3jJjVMV8UlFtDGFPHik8DGoQZNkG/A0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Fri, 3 Feb
 2023 02:07:14 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80%4]) with mapi id 15.20.6064.029; Fri, 3 Feb 2023
 02:07:14 +0000
Date:   Fri, 3 Feb 2023 10:08:16 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Pavel Begunkov <asml.silence@gmail.com>,
        <linux-kernel@vger.kernel.org>, <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is "io_ring_exit_work" related Call
 Trace in v5.2-rc5 kernel
Message-ID: <Y9xskCrKaTGZptRw@xpf.sh.intel.com>
References: <Y9TgUupO5C39V/DW@xpf.sh.intel.com>
 <812a7e2d-14d6-78cd-5c6c-ce508fc7fc0d@gmail.com>
 <15161e5f-fe26-23e9-1d0a-ebd579d64d9f@gmail.com>
 <Y9t6tflIcFPy84S5@xpf.sh.intel.com>
 <fb27661f-59dd-98cd-203a-8fa86dc209d4@kernel.dk>
 <affab34f-2b83-9158-5976-b224a4afce0d@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <affab34f-2b83-9158-5976-b224a4afce0d@kernel.dk>
X-ClientProxiedBy: SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH7PR11MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 78918015-5fb4-4ed7-c34d-08db058b5e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jn3OA3kyKEYAAUER8vWThlcEVDrILhwLUjHI8e5GjlMOXThc4y0dCUaGPx+dK99qAJEgHIkcdxkFgNr0u2uvX2wKlbr4VR/Cg00CXQGxjq8CzW/JttLrd0Yz9gXkp5ZkGGdhFrdFvgZf5VUwYuvMQ5OR9MZleAw43hn8p6vsnPV/4qyBn1W9/vP6kD7dFZuo9msgJkoRgRqmG/WkvyOEvPmmUnlSNcjxkQfnDsmzHnzR+aYVCYx14lt/WnLosTFOPsoXDDRJzO3KkgBicPU5+IsxtJEFL1WEb8NTrqta7FsGUviU3nHkxYQR7oa2MPzCvK/4OaUeAfxYGIcuGLXqR4loy8PpucCKGuj3MG66UkmLJiDcjlnbNqzjQpRSR8PywRiknACU9XPtS16GFgVVrdsY2/RlgkCe2mxQdCSryZigRuN3enIZNII9TOPB8JXBkt12dMoB0eBOhaItMxWp0OEo2BZygI2JZMka4RUW0xBJPlGPnE6hUvhSp1SZast3VRoPeIaF2VAQHDlhZ+YtvjpsCbjR3hbIP2nTtXYFEx96L7Jm2a1iAR4xfjvrQW3mP74cpB0lr9n26LYymgZJZVd7mM4hnbLK7ekcQr5xwJk0C/tdPX82xfleH1Iaumi+ovr22eNmRFXPaBwf3DpFVCnui0tXxgUkRFbbG2j4ixigtAT9gdu0RYBDYGXll5IzgZLLQHAdD187PDoYxojMlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199018)(83380400001)(38100700002)(6512007)(82960400001)(966005)(26005)(6506007)(316002)(66946007)(5660300002)(478600001)(66476007)(53546011)(8676002)(186003)(107886003)(6486002)(41300700001)(2906002)(8936002)(44832011)(66556008)(4326008)(6916009)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BVqT0JkQSBBl5yN0tvCeMoSznlivZyQX19eeX/hkY3DFjMjJVhJrOf/UuCsW?=
 =?us-ascii?Q?7jF9xrX7eWU8ejA7g6Dum7n2DSTJ5Atwd1CBWr68uWQrm61wNVrMR6eToi34?=
 =?us-ascii?Q?PyAcLpMdUkTSB8tdLVSolq3R0djKhLIPilNI6U1yZlGAfssdCBw+1tUo/Hqi?=
 =?us-ascii?Q?M3C+45xphsr84kC1QmW2EAJc7gJUw2xKw2qfB9L/7qHAMuci7APwiZDoZeHH?=
 =?us-ascii?Q?5b3cUu9nTRdOAzjKVgi541jfx9NFlMjEQsJ5P4OmO43kIpgn+2iCk9szZuTZ?=
 =?us-ascii?Q?gADeoLhE6OUWl1BoA/qgc5L6q2eRI3sz6Kszj8seWO4TPuZPdqqpNYejjWCc?=
 =?us-ascii?Q?8BWUMLR+n7l55Yezpk9JV3SZ1zV2d/7btgqKyynLBzM/G9AvQux8uoI8rQzR?=
 =?us-ascii?Q?a9fvwq4SbDEw1ovmXubZF0jeQL5jEWQl+vrrEFwEHRh/4Iga8yX706JOg8vI?=
 =?us-ascii?Q?/pQeKe7enz8h5fa6JRNpVx2VznP7us6MybIqpFl259CqyzadRIWAnK3X9R2R?=
 =?us-ascii?Q?+GREiz8vWtdf3outNE43sSWy4VEe4v9EyrC/c/W3ubP5b0KxbUbCjEXijXXB?=
 =?us-ascii?Q?Kze/d5QLADh/6U0KVHRbsL1qQT6QwPN2BxDlkfq2KBX4dgbROI/TsnYoF56c?=
 =?us-ascii?Q?DZluASmPEJDxf7ccSQJeU6DD7Via5Uq++RM6fScetC3K8VcBXHtPdsti4r3e?=
 =?us-ascii?Q?A2repMs3Wkqd1ZgfFkl/tqIqH6gD7IxxNCbDItJJDAgjx2mH9oPmBzCVQkNo?=
 =?us-ascii?Q?LtynRm3gWrnFwRJsVq6Q16fvrR0EF9aEdQXS4s99FNOndbhGwK3u4HXC9RqR?=
 =?us-ascii?Q?XsZLJSt9zIACJorXePpFRnWDOk8ZiAKAoWoJPJ1p5LP+xWYW/Wnk3FQcYHM1?=
 =?us-ascii?Q?BczBpojZRRmro2CL6zzXJ5fGbL2BQazyhPzuZpTTWK0VxU7YMrMykkrKhTeA?=
 =?us-ascii?Q?tGvA7DIGWnnxQV7TEpoW/vTXfA6jSe8l8+UtroViSKwY/lxdcjhPXlcsk3OF?=
 =?us-ascii?Q?88cq7A4Y1/1DbgMca+t71Y9fCFjF2ZHZim5umP4UhdbIthEDXSo5xfTxJhn0?=
 =?us-ascii?Q?D6XyhvzvVECJmjjObHFu6boCC9FainI68GqbsKK8mLBJ8N5NGkjN8y2Rn0vs?=
 =?us-ascii?Q?185QUaOSxWDAy5W7FuKY/0MXyXmj9FpffBhKvki+L3GVzxs1Ck1wbox8sxUC?=
 =?us-ascii?Q?OQE4PEkSx3HD92rvw9btkDCkBHCG174izFEB7XnZgnhZYUsUJRBk1esv7DeG?=
 =?us-ascii?Q?So8SCbKODdjPO+G/qsNdD0Wea6Rp/jlPNruQo36BCyx8auE7bpFoe29jOQ2f?=
 =?us-ascii?Q?J/hCq4ZR6cu+JzKoCDslYvKjlYWfP1Fw9eKFiHdvaRd76e2JyPdkIMT8vVU0?=
 =?us-ascii?Q?KJxo5IXl7hwmrJgEHuI5JKqVU81KP7qV2V4uiDT5umIBHDy95WcOY0O4wyid?=
 =?us-ascii?Q?z1v8t6ULoLXz1sjFWRPd5rUmcxghGIiRCFlr6nbkIf1U2yFVjtDMeJDQbuNv?=
 =?us-ascii?Q?f09WkgUL1hdr3kKymZxMMROv6K21JHDGd5xNWDW3TaeqNAD0SXIWGOwHfX2R?=
 =?us-ascii?Q?MVvuP4R01/2NXHA6x7Skm/I0aJmTvn3bS1XIqgiKgN6zXZwfNsG+aqc0uxwD?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78918015-5fb4-4ed7-c34d-08db058b5e14
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 02:07:14.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1gVPSHGwNt8kQ0u3YxZdyfPU2/54XNSvIjAQT/VQnELry8M9k3PSiWeHvUxJGNtYcbNn9cfUYZa6mpPK27eHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7605
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens Axboe,

On 2023-02-02 at 13:37:43 -0700, Jens Axboe wrote:
> On 2/2/23 12:44?PM, Jens Axboe wrote:
> > On 2/2/23 1:56?AM, Pengfei Xu wrote:
> >> Hi Pavel Begunkov,
> >>
> >> On 2023-02-01 at 15:52:47 +0000, Pavel Begunkov wrote:
> >>> On 1/28/23 14:49, Pavel Begunkov wrote:
> >>>> On 1/28/23 08:44, Pengfei Xu wrote:
> >>>>> Hi Pavel Begunkov and kernel expert,
> >>>>>
> >>>>> Greeting!
> >>>>>
> >>>>> There is "io_ring_exit_work" related Call Trace in v5.2-rc5 kernel in guest
> >>>>> on Sapphire Rapids server.
> >>>>
> >>>> Thanks for the report, we'll take a look
> >>>
> >>> Not reproducible for me. Apparently, the repro creates a normal ring
> >>> and immediately closes it, then io_ring_exit_work() hangs waiting to
> >>> the task to execute task_work.
> >>   Ah, I put the reproduced virtual machine in gitlab.
> >>   git clone https://gitlab.com/xupengfe/repro_vm_env.git
> >>   cd repro_vm_env
> >>   tar -xvf repro_vm_env.tar.gz
> >>   cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
> >>      //start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
> >>   In vm and login with root,  there is no password for root.
> >>   After login vm successfully, ./repro   to reproduce this issue.
> >>   It could be reproduced in about 6min.
> >>
> >>   If you already have qemu-system-x86_64, please ignore below info.
> >>   If you want to install qemu v7.1.0 version,
> >>   git clone https://github.com/qemu/qemu.git
> >>   cd qemu
> >>   git checkout -f v7.1.0
> >>   mkdir build
> >>   cd build
> >>   yum install -y ninja-build.x86_64
> >>   ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
> >>   make
> >>   make install
> >>   Done.
> > 
> > Are you sure you attached the right kconfig in the initial report? It
> > is from 5.18.x.
  Yes, the kconfig from initial report is first used by 5.18.x kernel,
  and I added some new kconfig item based on the kconfig like kernel ibt:
  CONFIG_X86_KERNEL_IBT=y and so on.

  And use the kconfig then "make olddefconfig" to generate the kconfig
  for latest kernel.

  I will add above vm environment and kconfig making info for reproduced
  steps if I find new kernel issues.
  Thanks for remind!

> 
> Looks like a bug in 9p, can you try this?
  Thanks for your patch!
  The following patch was installed on top of v6.2-rc5 kernel, and tested this
  issue in vm on SPR and RPL-S platforms(reproduced platforms as before).
  This issue could not be reproduced in 40 min.
  Test result shows that this patch solves the problem.

  Thanks!
  BR.
> 
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 622ec6a586ee..5756d812d3d4 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -18,6 +18,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> +#include <linux/task_work.h>
>  #include <net/9p/9p.h>
>  #include <linux/parser.h>
>  #include <linux/seq_file.h>
> @@ -652,6 +653,24 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
>  	return ERR_PTR(err);
>  }
>  
> +static int p9_sigpending(void)
> +{
> +	int sigpending = 0;
> +
> +	if (signal_pending(current)) {
> +		if (test_thread_flag(TIF_NOTIFY_SIGNAL))
> +			clear_notify_signal();
> +		if (task_work_pending(current))
> +			task_work_run();
> +		if (signal_pending(current)) {
> +			sigpending = 1;
> +			clear_thread_flag(TIF_SIGPENDING);
> +		}
> +	}
> +
> +	return sigpending;
> +}
> +
>  /**
>   * p9_client_rpc - issue a request and wait for a response
>   * @c: client session
> @@ -687,12 +706,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>  	req->tc.zc = false;
>  	req->rc.zc = false;
>  
> -	if (signal_pending(current)) {
> -		sigpending = 1;
> -		clear_thread_flag(TIF_SIGPENDING);
> -	} else {
> -		sigpending = 0;
> -	}
> +	sigpending = p9_sigpending();
>  
>  	err = c->trans_mod->request(c, req);
>  	if (err < 0) {
> @@ -789,12 +803,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
>  	req->tc.zc = true;
>  	req->rc.zc = true;
>  
> -	if (signal_pending(current)) {
> -		sigpending = 1;
> -		clear_thread_flag(TIF_SIGPENDING);
> -	} else {
> -		sigpending = 0;
> -	}
> +	sigpending = p9_sigpending();
>  
>  	err = c->trans_mod->zc_request(c, req, uidata, uodata,
>  				       inlen, olen, in_hdrlen);
> 
> -- 
> Jens Axboe
> 
