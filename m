Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74B262D0B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiKQBhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiKQBhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:37:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FD95D6A9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668649019; x=1700185019;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ullX75sUGWgokw+9bz/emGoqkTs28vVLMnDdDeBLhd8=;
  b=ee8RzytyN/U0WMGzNBNq+xxehDdYwLyWKqZNiJ/zH/0o3x3mBgSdhfZQ
   TQI9KCP/EzwMypc0Pis2bcpNvYJnaZ2JcNIp4cf+ZhDxI7slYzcVzSv2S
   p3ubtNU09Ka3DQm5wgtGsM/FHbhZlbixgBMIuOKXFfVNl1WgY3Wn0Cf9B
   XHhHuFSglIL7ov68j/oj4qhd4XBO8wJj5h9Ws75fPaRb/ZoLaWZwBH1Gt
   X2R0b3alzXpgrpHUptO+IccLA6LZYBAt6l6sVR9LRwqSUZ5ouiU2XxK1f
   ko+W97S4ffXgFQUvytYMyWIAvxW2CwHSMw5QVVtH9kCqcunm2+QN8Ccs0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="314537505"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="log'?scan'208,223";a="314537505"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590420001"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="log'?scan'208,223";a="590420001"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 16 Nov 2022 17:36:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:36:58 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 17:36:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 17:36:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pp+Pw/4VTmnLU/Bwlub8BIBW8YZFZ83pKOTbbgCFHYm9TH6ru6SCcwYr3Sx8OFiemjNaoZ50ZkK4aOqKR1+5G9yoX7azccI4D9q6A9/I05eWiVzoufjnhY2Ij4U+2UNz1ymyYT+zDQn9PEkhrH1G/pv/iZ8PtYp7K9il2iOhrUWPsXS6xk6y+D3iPtWF2HA/ekIKdDXf3osDVYgZFrt186zyxEE10h0DBRt30j7udro9PtDVcYeae3XZE+GWg00kmMs1kcFD0348Z9yme5PBKyF6KlvzBRNY5VULT405G+tM4tH4SoWkaNCSeeOKWtF7t/Qsq082YoTinKncvFCzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpVlxQ8Nl/hG4agrb+NZ/FcsjSPgBrLu306FFiNjI3Q=;
 b=U4TBPgRaPLupUPOwbpSW7/oGsEyGN6KIU1WnSyNrTeBXjT3IXQGzKp+7R3tDb7hd+pt96cFoc1bKV5kI2aL1yyKKH1A81LAiuvhlpyN5N/UBkzLAQ1XcZmgXNduoCZGu3wnSKEykcPsgED+KjneJvWHgFLbcljf5sO6h0FLb87J+8TWT1MPD64BmdChP84Zqw4Tg6mCua3xaLNtS/dRcKfcDw7fuTjgEfekI8vDFrnqfhfJqhM1LQ42dDt0XWn95fbX/ywP3NZO8ZtDcB9pZk+PFUDBKbOGD0y1xzOpfAofro8kR7kCeOArWvI02ejpgfCdfG7wyELDrjtpF+ObjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 01:36:50 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5%6]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 01:36:50 +0000
Date:   Thu, 17 Nov 2022 09:37:03 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <peter.zijlstra@intel.com>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is "__perf_event_overflow" WARNING in
 v6.1-rc5 kernel in guest
Message-ID: <Y3WQPxKsL8D6TPtt@xpf.sh.intel.com>
References: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com>
 <Y3T2WAzyJTZnDl8m@hirez.programming.kicks-ass.net>
Content-Type: multipart/mixed; boundary="TJ9SZJM9gozULrP/"
Content-Disposition: inline
In-Reply-To: <Y3T2WAzyJTZnDl8m@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SN7PR11MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a313ac6-d1b9-4aab-dc1b-08dac83c312f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvh6hRMwIlzXkcviAxW0vdTLfzdPwBXixjgidXyV5W9ALw/ktHEOMDfz1Lc1zZVaonLW5l2mG8FkrGgwFENQCIygrlKHYwpJYOUPJeO/1b1wQyGGGAibTjkfS+JDBMguxab2A302kiYbnDzLZhjqdknTQuccZxh4J7IBWK9m29+iyx9xnfxCtmviCszZb46+M60QaPmx/M3oIPmlk1jiwl+OXmE5rlRM7agPwkpdbafSzMbwP+UlNwV/cZ+4FM2twA2LeyW2Jsd20MyeOH5ov2Mj3FSTU25y50J3loxSPALupFilIhwJUtWqHALkqYcmU8vsIl/keYH3OK5MP0yZN6BbPdVuW5xCjnPhDtuU/M7EC15uta6G+39y66emx6NylY8WUCQ03Ix6hWg2yHnpTc2yoleb55djr4T0ZhVBWL5SMjhnc4boOOvDtXWWsZLX4YlwQ3ll1vFp2jMKbjzUKXZDTuJUjI631TUqRO+Bg3YRwgIBeJrOznxsiZOt9jsD6Le8QkeWe4EySylJ/Q5Z+cI1gLX7lbtnQjF1RiedPKMGQfDUnZkqoybbBkhto8u/5S2A9CeLwkxRz8RTF6qVQImazlb0xARFAtCopXtzMPcKtrt4UlUtlAtZWwwnvycZQzgq9pBmS7h503JzzMME4qIgUG7aB8WaqKV8MeMaDMMG3xdcSTKMv+xqOJtaeFFaaSrc0pAiJdmc26kgXN+sWhdf6EN2UTyf6/Np9tDsnVVip7PMFeoPwK/Z0NGkkdCKJ8yiUFHtbiGIsfmOp5gYrbLQldwEqrxVyAmTrEeHesLVaAGDsDrqIqFWGjRTvapzz1Ga6O9x6ggMPtPG96sbNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(478600001)(45080400002)(6666004)(44144004)(107886003)(6486002)(966005)(2906002)(53546011)(66476007)(21480400003)(26005)(8676002)(6512007)(4326008)(41300700001)(66946007)(66556008)(235185007)(5660300002)(8936002)(44832011)(186003)(83380400001)(4001150100001)(38100700002)(82960400001)(6916009)(6506007)(316002)(86362001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3MdyCKlq/jIJFnJNMS32Gw11KIxhlMQxZVnMwwpDJeAn4EV1hs1/ZoNoo9d/?=
 =?us-ascii?Q?hJcHpJs1CbJKmjDK7UPZ3oSWmy5X4e4tqtl+ebKkDm86EyXL8UvH0YnqvMZP?=
 =?us-ascii?Q?K0+R3aoY5EgL/cEFJahPEP74h4Zsg2gw4TgPLXT9pJTqV8vqjJcuQCSVoANk?=
 =?us-ascii?Q?yxo8SrdWxViK9plTa0AfvrkmV5NlUVhzQ+NZ0WB4Y6thZod6LZRMrQCrMONw?=
 =?us-ascii?Q?5HQq2wJXOzyXlljtS4l8J01okhE5oEJbytgM4pfPPaespLYlhE3kXQrIHdvn?=
 =?us-ascii?Q?rVUQd6AwenSaU3HrapL/eCBRqbws/0kSaj84dNFGCVbudTem7ROyQ3kgqdeh?=
 =?us-ascii?Q?XgljUX9+643DlwrnKrD0Bvm4bcxt8yhElkIZ0FvGfzN1I24NT76wOhCtkPZA?=
 =?us-ascii?Q?4Z6V63m5MQyARvAz+ta4S/t25xXsQAlHZKnXb9lXn7rHIDunK2/tnfyDk5Tu?=
 =?us-ascii?Q?Fwj0g7XyC0K9FuBDEcC6Vmcr/0NWQ4Ve6tSBKY1Y9XLay7wWgr+SVJbsR0Gn?=
 =?us-ascii?Q?Vt56CuRZ8c0bZop7CI+e0K0eQXMWdetjYNEUqCq1TfoQyX/PvZdm9Wt7RrJS?=
 =?us-ascii?Q?pZQtmaKV6yjsrtS+NbHXCVKVv2T//CuPMvEpWsRqlChyJTWQMBPpW3G6ZHEc?=
 =?us-ascii?Q?lhzy5np3G0nGXBWwhlta+FoHGzORoMKUtpiYyBvvBzZdY/T+i3z86Ndua6+8?=
 =?us-ascii?Q?Sopzo+F3Yg6Cjov5OF0YNbLPiIp7XPu25AfSfMtbmKvJwEavCO/6g3San9Vq?=
 =?us-ascii?Q?Ib/7+A/GVWD0eOBYckh+7MfoP6AxM+Kb1kzNmtYxGQRKyl6I2ylG8c7SDmgT?=
 =?us-ascii?Q?NCoDogJ/Kvb3sVwA19SLu0ECJN5wEPws4oh9zEv97crxhwshPOluaGElX1Db?=
 =?us-ascii?Q?eHQgYvcdkkZvr9ku6MSc1LkMREzIl+DodtnpX0o7nffIDcAnDTHGf6mvgMFc?=
 =?us-ascii?Q?voRB4yv2vdt+uEhgruFUArXoieFxGjtAPPk+sxud9346KXblobzTK0xm4vZO?=
 =?us-ascii?Q?9adkDVpjwIXoWYf3uvciLhfeC/MmEd9Ohaps/7Cx2+LHYEG9cFwJr+EY9/dh?=
 =?us-ascii?Q?AXq9LG88S9+png4XuLjDaL7VQJcxj6v53OM4/KUUynzJ5RRDVDWSBu95QTzp?=
 =?us-ascii?Q?kw3DSxrkunx5SjdhROMj4n0aWlVzj2BNpkj+Gg6a3MXjFE2Qa2sW0qYeTDEu?=
 =?us-ascii?Q?86lXlWdFmjGw7Ywgex5RaSD3u3sUV+Is8gGwz6qVquXyTHymAG7iAZc7TU3I?=
 =?us-ascii?Q?ShTQswSIHC8EFP5ZsEzdGwgSU0d/GNTOMjtE3izGTEDEd7pm67UGlsRRn1h+?=
 =?us-ascii?Q?QgSxjPp3cAzVa3dT7OVnfdpR9Mv3auHXlF3PuNc/wfI3zacFRQne2OYqpnct?=
 =?us-ascii?Q?y9eVDc3ZVJNk4Y1DDmc817JHGwdo8u6S6O1Tp1WKp3+CC0vGJ4dvFcwT5mOb?=
 =?us-ascii?Q?Hr/iK57sdkiylQRfJB/IswgvCTl+kf2sqM+MwOHovHDVIF15Trrv0DcQ4B21?=
 =?us-ascii?Q?ttoYcph0oGNrRxMY+FQi91iKLE8RhZ0VZiJKGr70NtSSOMqszW2jMMjVPD2V?=
 =?us-ascii?Q?EScwKnGjMtH0jNnEQar0ydWW3D4RAKKl+sSTskkT6pidN+SnyD8YZ+gmGXVU?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a313ac6-d1b9-4aab-dc1b-08dac83c312f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:36:50.5636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vP3JLPD3rCu0j2ebBRalriv4205kO24J70S2yTagFlscJTgUz6du2Z+OiiBEOS4YI0Phbtt4WEKSvUtmi7xUng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--TJ9SZJM9gozULrP/
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Peter,

On 2022-11-16 at 15:40:24 +0100, Peter Zijlstra wrote:
> On Wed, Nov 16, 2022 at 11:39:53AM +0800, Pengfei Xu wrote:
> > Hi Peter and perf expert,
> > 
> > Greeting!
> > 
> > Platform: TGL-H
> > 
> > There is "__perf_event_overflow" WARNING issue in v6.1-rc5 kernel in
> > guest in double check test.
> > 
> > Found first bad commit is ca6c21327c6af02b7eec31ce4b9a740a18c6c13f
> > "perf: Fix missing SIGTRAPs"
> > 
> > And revert this commit on top of v6.1-rc5, this issue could not be reproduced.
> > 
> > Guest kconfig, reproduce code from syzkaller, and bisect info are in attached.
> > 
> > And more detailed info is in link:
> > https://github.com/xupengfe/syzkaller_logs/tree/main/221114_134736___perf_event_overflow
> > 
> > If it's helpful and in time, please add the Reported-by tag from me.
> 
> Does this help?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=perf/urgent&id=bb88f9695460bec25aa30ba9072595025cf6c8af
Thanks for your link!
I installed the patch from above link on top of v6.1-rc5 kernel, the patch
is in attached.

And I still could reproduce this issue.
I use below loop to execute the binary, it's reproduced in the 485 times
execution.
"
for((i=0; ;i++)); do
  echo "$i times ./repro"
  ./repro
done
"
485 times ./repro
[   87.978410] ------------[ cut here ]------------
[   87.978430] WARNING: CPU: 0 PID: 970 at kernel/events/core.c:9329 __perf_event_overflow+0x22b/0x270
[   87.978464] Modules linked in:
[   87.978470] CPU: 0 PID: 970 Comm: repro Not tainted 6.1.0-rc5-kvmperfoverflow+ #10
[   87.978487] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   87.978498] RIP: 0010:__perf_event_overflow+0x22b/0x270
[   87.978516] Code: b6 45 d3 84 c0 0f 84 26 ff ff ff e8 4f 31 ec ff 8b 75 d4 44 89 ff e8 04 32 ec ff 44 3b 7d d4 0f 84 0c ff ff ff e8 35 31 ec ff <0f> 0b e9 00 6
[   87.978531] RSP: 0000:fffffe000000db58 EFLAGS: 00010046
[   87.978543] RAX: 0000000000000000 RBX: ffff888004ed5ce0 RCX: ffffffff8138b67c
[   87.978554] RDX: 0000000000000000 RSI: ffff88800b8e9fc0 RDI: 0000000000000002
[   87.978565] RBP: fffffe000000db88 R08: 0000001ffad06476 R09: 0000000000000000
[   87.978583] R10: 0000000000000000 R11: 0000000000000000 R12: fffffe000000def8
[   87.978594] R13: fffffe000000dc00 R14: 0000000000000000 R15: 0000000088db7a04
[   87.978607] FS:  00007f9988c8b740(0000) GS:ffff88807dc00000(0000) knlGS:ffff88807dc00000
[   87.978625] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.978639] CR2: 0000000020000200 CR3: 000000000a77c003 CR4: 0000000000770ef0
[   87.978655] PKRU: 55555554
[   87.978662] Call Trace:
[   87.978667]  <NMI>
[   87.978675]  perf_event_overflow+0x33/0x40
[   87.978705]  handle_pmi_common+0x2d8/0x560
[   87.978736]  ? write_comp_data+0x2f/0x90
[   87.978760]  ? write_comp_data+0x2f/0x90
[   87.978783]  intel_pmu_handle_irq+0x183/0x680
[   87.978805]  perf_event_nmi_handler+0x42/0x70
[   87.978842]  nmi_handle+0x63/0x160
[   87.978872]  default_do_nmi+0x77/0x190
[   87.978903]  exc_nmi+0x157/0x190
[   87.978932]  end_repeat_nmi+0x16/0x67
[   87.978963] RIP: 0010:asm_sysvec_irq_work+0x0/0x30
[   87.978993] Code: ca fc 6a ff e8 a1 05 00 00 48 89 c4 48 8d 6c 24 01 48 89 e7 e8 e1 56 ea ff e9 bc 06 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 <f3> 0f 1e fa 4
[   87.979010] RSP: 0000:fffffe0000002fd8 EFLAGS: 00000002
[   87.979024] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f9988db059d
[   87.979037] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000200
[   87.979049] RBP: 00007ffe528b2a70 R08: 0000000000000003 R09: 0000000000401a60
[   87.979062] R10: 00000000ffffffff R11: 0000000000000202 R12: 00000000004010e0
[   87.979075] R13: 00007ffe528b2b50 R14: 0000000000000000 R15: 0000000000000000
[   87.979093]  ? asm_sysvec_thermal+0x30/0x30
[   87.979123]  ? asm_sysvec_thermal+0x30/0x30
[   87.979153]  </NMI>
[   87.979158]  <ENTRY_TRAMPOLINE>
[   87.979165]  </ENTRY_TRAMPOLINE>
[   87.979171] ---[ end trace 0000000000000000 ]---

Before the loop execution, I tried several times manually, and sometimes, I
saw "Trace/breakpoint trap (core dumped)" after executed repro, but there is
no any dmesg info generated.

Anyway all the dmesg and patch is in attached. Hope it's helpful.

Thanks!
BR.

--TJ9SZJM9gozULrP/
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="0001-The-patch-from-https-git.kernel.org-pub-scm-linux-ke.patch"

From e042cf64c1740cc81de2701a0ffe47d43c4fb267 Mon Sep 17 00:00:00 2001
From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 17 Nov 2022 09:15:38 +0800
Subject: [PATCH] The patch from
 https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=perf/urgent&id=bb88f9695460bec25aa30ba9072595025cf6c8af

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 kernel/events/core.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ec3717003d5..884871427a94 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9306,14 +9306,27 @@ static int __perf_event_overflow(struct perf_event *event,
 	}
 
 	if (event->attr.sigtrap) {
-		/*
-		 * Should not be able to return to user space without processing
-		 * pending_sigtrap (kernel events can overflow multiple times).
-		 */
-		WARN_ON_ONCE(event->pending_sigtrap && event->attr.exclude_kernel);
+		unsigned int pending_id = 1;
+
+		if (regs)
+			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
 		if (!event->pending_sigtrap) {
-			event->pending_sigtrap = 1;
+			event->pending_sigtrap = pending_id;
 			local_inc(&event->ctx->nr_pending);
+		} else if (event->attr.exclude_kernel) {
+			/*
+			 * Should not be able to return to user space without
+			 * consuming pending_sigtrap; with exceptions:
+			 *
+			 *  1. Where !exclude_kernel, events can overflow again
+			 *     in the kernel without returning to user space.
+			 *
+			 *  2. Events that can overflow again before the IRQ-
+			 *     work without user space progress (e.g. hrtimer).
+			 *     To approximate progress (with false negatives),
+			 *     check 32-bit hash of the current IP.
+			 */
+			WARN_ON_ONCE(event->pending_sigtrap != pending_id);
 		}
 		event->pending_addr = data->addr;
 		irq_work_queue(&event->pending_irq);
-- 
2.31.1


--TJ9SZJM9gozULrP/
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="v6.1-rc5_patch_guest_perfoverflow_warning_dmesg.log"

[    0.000000] Linux version 6.1.0-rc5-kvmperfoverflow+ (root@xpf.sh.intel.com) (gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10), GNU ld version 2.36.1-2.el8) #10 SM2
[    0.000000] Command line: console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3632
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000003] kvm-clock: using sched offset of 359320737 cycles
[    0.000558] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.002592] tsc: Detected 3110.400 MHz processor
[    0.012983] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.013006] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.013028] last_pfn = 0x7ffe0 max_arch_pfn = 0x400000000
[    0.013657] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.024182] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
[    0.024862] Using GB pages for direct mapping
[    0.026600] ACPI: Early table checksum verification disabled
[    0.027187] ACPI: RSDP 0x00000000000F59C0 000014 (v00 BOCHS )
[    0.027830] ACPI: RSDT 0x000000007FFE1951 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.028937] ACPI: FACP 0x000000007FFE17FD 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.029996] ACPI: DSDT 0x000000007FFE0040 0017BD (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.031054] ACPI: FACS 0x000000007FFE0000 000040
[    0.031545] ACPI: APIC 0x000000007FFE1871 000080 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.032450] ACPI: HPET 0x000000007FFE18F1 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.033359] ACPI: WAET 0x000000007FFE1929 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.034252] ACPI: Reserving FACP table memory at [mem 0x7ffe17fd-0x7ffe1870]
[    0.034983] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe17fc]
[    0.035709] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe003f]
[    0.036442] ACPI: Reserving APIC table memory at [mem 0x7ffe1871-0x7ffe18f0]
[    0.037179] ACPI: Reserving HPET table memory at [mem 0x7ffe18f1-0x7ffe1928]
[    0.037918] ACPI: Reserving WAET table memory at [mem 0x7ffe1929-0x7ffe1950]
[    0.039907] No NUMA configuration found
[    0.040324] Faking a node at [mem 0x0000000000000000-0x000000007ffdffff]
[    0.041131] NODE_DATA(0) allocated [mem 0x7ffb5000-0x7ffdffff]
[    0.045966] Zone ranges:
[    0.046245]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.046914]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]
[    0.047565]   Normal   empty
[    0.047881]   Device   empty
[    0.048198] Movable zone start for each node
[    0.048662] Early memory node ranges
[    0.049058]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.049725]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]
[    0.050389] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdffff]
[    0.051418] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.051442] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.056715] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.057672] ACPI: PM-Timer IO Port: 0x608
[    0.058795] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.059486] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.060246] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.060936] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.061649] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.062364] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.063089] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.063829] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.064571] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.065233] TSC deadline timer available
[    0.065657] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.066305] kvm-guest: KVM setup pv remote TLB flush
[    0.066931] kvm-guest: setup PV sched yield
[    0.067523] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.068496] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.069498] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.070482] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.071483] [mem 0x80000000-0xfeffbfff] available for PCI devices
[    0.072264] Booting paravirtualized kernel on KVM
[    0.072796] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.074105] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.075282] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u1048576
[    0.076179] pcpu-alloc: s217088 r8192 d28672 u1048576 alloc=1*2097152
[    0.076200] pcpu-alloc: [0] 0 1 
[    0.076387] kvm-guest: PV spinlocks enabled
[    0.076982] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.077991] Fallback order for Node 0: 0 
[    0.078555] Built 1 zonelists, mobility grouping on.  Total pages: 515808
[    0.079326] Policy zone: DMA32
[    0.079661] Kernel command line: net.ifnames=0 console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg
[    0.081914] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.083071] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.084221] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.088982] Memory: 1999736K/2096632K available (30736K kernel code, 4081K rwdata, 7528K rodata, 3624K init, 10528K bss, 96640K reserved, 0K cma-reserved)
[    0.091766] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.092537] kmemleak: Kernel memory leak detector disabled
[    0.093175] ftrace: allocating 66320 entries in 260 pages
[    0.118532] ftrace: allocated 260 pages with 2 groups
[    0.120878] Dynamic Preempt: voluntary
[    0.121473] rcu: Preemptible hierarchical RCU implementation.
[    0.122213] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
[    0.123105]  Trampoline variant of Tasks RCU enabled.
[    0.123740]  Rude variant of Tasks RCU enabled.
[    0.124308]  Tracing variant of Tasks RCU enabled.
[    0.124918] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.125850] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.158946] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16
[    0.159929] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.169905] Console: colour VGA+ 80x25
[    0.170370] printk: console [ttyS0] enabled
[    0.171273] printk: bootconsole [earlyser0] disabled
[    0.172382] ACPI: Core revision 20220331
[    0.173105] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.174235] APIC: Switch to symmetric I/O mode setup
[    0.175004] x2apic enabled
[    0.175536] Switched APIC routing to physical x2apic.
[    0.176112] kvm-guest: setup PV IPIs
[    0.177605] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.178322] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2cd5a8bb032, max_idle_ns: 440795365915 ns
[    0.179452] Calibrating delay loop (skipped) preset value.. 6220.80 BogoMIPS (lpj=12441600)
[    0.180359] pid_max: default: 32768 minimum: 301
[    0.181056] LSM: Security Framework initializing
[    0.181569] Yama: becoming mindful.
[    0.182154] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.183454] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.185501] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.187523] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.188372] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.189272] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.190180] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.191452] Spectre V2 : Mitigation: Enhanced IBRS
[    0.192144] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.193150] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.193912] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.194764] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.326769] Freeing SMP alternatives memory: 56K
[    0.327536] smpboot: CPU0: Genuine Intel(R) CPU 0000 @ 2.20GHz (family: 0x6, model: 0x8d, stepping: 0x0)
[    0.328820] cblist_init_generic: Setting adjustable number of callback queues.
[    0.329616] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.330393] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.331183] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.331493] Performance Events: Icelake events, full-width counters, Intel PMU driver.
[    0.332539] ... version:                2
[    0.332979] ... bit width:              48
[    0.333449] ... generic registers:      8
[    0.333945] ... value mask:             0000ffffffffffff
[    0.334580] ... max period:             00007fffffffffff
[    0.335223] ... fixed-purpose events:   3
[    0.335448] ... event mask:             00000007000000ff
[    0.336349] rcu: Hierarchical SRCU implementation.
[    0.336859] rcu:     Max phase no-delay instances is 1000.
[    0.340053] smp: Bringing up secondary CPUs ...
[    0.340847] x86: Booting SMP configuration:
[    0.341338] .... node  #0, CPUs:      #1
[    0.341885] smp: Brought up 1 node, 2 CPUs
[    0.341885] smpboot: Max logical packages: 1
[    0.343452] smpboot: Total of 2 processors activated (12441.60 BogoMIPS)
[    0.344827] devtmpfs: initialized
[    0.344827] x86/mm: Memory block size: 128MB
[    0.347806] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.348985] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.349916] pinctrl core: initialized pinctrl subsystem

[    0.351004] *************************************************************
[    0.351454] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.352162] **                                                         **
[    0.352841] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    0.353558] **                                                         **
[    0.354278] ** This means that this kernel is built to expose internal **
[    0.354970] ** IOMMU data structures, which may compromise security on **
[    0.355446] ** your system.                                            **
[    0.356139] **                                                         **
[    0.356836] ** If you see this message and you are not debugging the   **
[    0.357533] ** kernel, report this immediately to your vendor!         **
[    0.358229] **                                                         **
[    0.358915] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.359447] *************************************************************
[    0.360200] PM: RTC time: 01:18:15, date: 2022-11-17
[    0.363679] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.365008] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.365757] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.366623] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.367489] audit: initializing netlink subsys (disabled)
[    0.368161] audit: type=2000 audit(1668647896.511:1): state=initialized audit_enabled=0 res=1
[    0.368161] thermal_sys: Registered thermal governor 'fair_share'
[    0.368832] thermal_sys: Registered thermal governor 'bang_bang'
[    0.369480] thermal_sys: Registered thermal governor 'step_wise'
[    0.370088] thermal_sys: Registered thermal governor 'user_space'
[    0.371473] cpuidle: using governor ladder
[    0.372559] cpuidle: using governor menu
[    0.373316] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.374275] PCI: Using configuration type 1 for base access
[    0.385990] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.669861] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.670713] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.671409] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.671462] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.673192] ACPI: Added _OSI(Module Device)
[    0.673646] ACPI: Added _OSI(Processor Device)
[    0.674097] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.674587] ACPI: Added _OSI(Processor Aggregator Device)
[    0.680399] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.683974] ACPI: Interpreter enabled
[    0.684458] ACPI: PM: (supports S0 S3 S4 S5)
[    0.684935] ACPI: Using IOAPIC for interrupt routing
[    0.685487] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.686447] PCI: Using E820 reservations for host bridge windows
[    0.687725] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.702366] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.703048] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.703455] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.704526] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.707542] acpiphp: Slot [3] registered
[    0.708038] acpiphp: Slot [4] registered
[    0.708546] acpiphp: Slot [5] registered
[    0.709017] acpiphp: Slot [6] registered
[    0.709492] acpiphp: Slot [7] registered
[    0.709988] acpiphp: Slot [8] registered
[    0.710472] acpiphp: Slot [9] registered
[    0.710970] acpiphp: Slot [10] registered
[    0.711467] acpiphp: Slot [11] registered
[    0.711957] acpiphp: Slot [12] registered
[    0.712460] acpiphp: Slot [13] registered
[    0.712932] acpiphp: Slot [14] registered
[    0.713417] acpiphp: Slot [15] registered
[    0.713919] acpiphp: Slot [16] registered
[    0.714414] acpiphp: Slot [17] registered
[    0.714895] acpiphp: Slot [18] registered
[    0.715377] acpiphp: Slot [19] registered
[    0.715510] acpiphp: Slot [20] registered
[    0.716028] acpiphp: Slot [21] registered
[    0.716506] acpiphp: Slot [22] registered
[    0.716999] acpiphp: Slot [23] registered
[    0.717504] acpiphp: Slot [24] registered
[    0.718070] acpiphp: Slot [25] registered
[    0.718660] acpiphp: Slot [26] registered
[    0.719165] acpiphp: Slot [27] registered
[    0.719514] acpiphp: Slot [28] registered
[    0.720009] acpiphp: Slot [29] registered
[    0.720508] acpiphp: Slot [30] registered
[    0.721011] acpiphp: Slot [31] registered
[    0.721469] PCI host bridge to bus 0000:00
[    0.721913] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.722619] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.723452] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.724272] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebfffff window]
[    0.725060] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    0.725880] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.726643] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.730162] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.731656] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.734157] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    0.735690] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.736596] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.737406] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.738274] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.739420] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.739832] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.740823] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.742332] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.743768] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.746088] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.750290] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.751124] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.754202] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.755466] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.756890] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.761002] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.774165] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.775235] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.775818] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.776933] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.777960] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.779468] iommu: Default domain type: Translated 
[    0.780036] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.781247] SCSI subsystem initialized
[    0.781739] libata version 3.00 loaded.
[    0.781828] ACPI: bus type USB registered
[    0.782318] usbcore: registered new interface driver usbfs
[    0.783094] usbcore: registered new interface driver hub
[    0.783470] usbcore: registered new device driver usb
[    0.784219] pps_core: LinuxPPS API ver. 1 registered
[    0.784742] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.785690] PTP clock support registered
[    0.786228] EDAC MC: Ver: 3.0.0
[    0.786713] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    0.787396] NetLabel: Initializing
[    0.787449] NetLabel:  domain hash size = 128
[    0.787895] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.788521] NetLabel:  unlabeled traffic allowed by default
[    0.789247] PCI: Using ACPI for IRQ routing
[    0.789765] PCI: pci_cache_line_size set to 64 bytes
[    0.789861] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.789871] e820: reserve RAM buffer [mem 0x7ffe0000-0x7fffffff]
[    0.789973] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.790616] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.791261] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.791450] vgaarb: loaded
[    0.792157] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.792757] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    4.216342] clocksource: Switched to clocksource kvm-clock
[    4.217257] VFS: Disk quotas dquot_6.6.0
[    4.217705] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    4.218591] pnp: PnP ACPI init
[    4.219233] pnp 00:02: [dma 2]
[    4.219853] pnp: PnP ACPI: found 6 devices
[    4.229602] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    4.230926] NET: Registered PF_INET protocol family
[    4.231788] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    4.234226] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    4.235152] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    4.235994] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    4.236949] TCP bind hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    4.237861] TCP: Hash tables configured (established 16384 bind 16384)
[    4.238608] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    4.239331] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    4.240177] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    4.247587] RPC: Registered named UNIX socket transport module.
[    4.248230] RPC: Registered udp transport module.
[    4.248699] RPC: Registered tcp transport module.
[    4.249167] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    4.249865] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    4.250544] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    4.251166] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    4.251910] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff window]
[    4.252611] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    4.253565] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    4.254197] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    4.254898] PCI: CLS 0 bytes, default 64
[    4.255626] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2cd5a8bb032, max_idle_ns: 440795365915 ns
[    4.332651] Initialise system trusted keyrings
[    4.333305] Key type blacklist registered
[    4.333903] workingset: timestamp_bits=36 max_order=19 bucket_order=0
[    4.340665] zbud: loaded
[    4.342021] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    4.343503] NFS: Registering the id_resolver key type
[    4.344066] Key type id_resolver registered
[    4.344477] Key type id_legacy registered
[    4.344963] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    4.345713] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    4.346638] fuse: init (API version 7.37)
[    4.347287] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
[    4.349222] 9p: Installing v9fs 9p2000 file system support
[    4.359380] Key type asymmetric registered
[    4.359835] Asymmetric key parser 'x509' registered
[    4.360994] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    4.361730] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    4.362580] io scheduler mq-deadline registered
[    4.363134] io scheduler bfq registered
[    4.364226] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    4.365201] IPMI message handler: version 39.2
[    4.365733] ipmi device interface
[    4.367314] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    4.368362] ACPI: button: Power Button [PWRF]
[    4.369646] ERST DBG: ERST support is disabled.
[    4.370694] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    4.371593] serial 00:04: GPIO lookup for consumer rs485-term
[    4.371611] serial 00:04: using ACPI for GPIO lookup
[    4.371627] acpi PNP0501:00: GPIO: looking up rs485-term-gpios
[    4.371640] acpi PNP0501:00: GPIO: looking up rs485-term-gpio
[    4.371650] serial 00:04: using lookup tables for GPIO lookup
[    4.371659] serial 00:04: No GPIO consumer rs485-term found
[    4.371905] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    4.378504] Linux agpgart interface v0.103
[    4.379364] ACPI: bus type drm_connector registered
[    4.388630] brd: module loaded
[    4.394755] loop: module loaded
[    4.396591] ata_piix 0000:00:01.1: version 2.13
[    4.397859] scsi host0: ata_piix
[    4.398559] scsi host1: ata_piix
[    4.399037] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
[    4.399839] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
[    4.401030] mdio_bus fixed-0: GPIO lookup for consumer reset
[    4.401042] mdio_bus fixed-0: using lookup tables for GPIO lookup
[    4.401051] mdio_bus fixed-0: No GPIO consumer reset found
[    4.401310] tun: Universal TUN/TAP device driver, 1.6
[    4.401934] e100: Intel(R) PRO/100 Network Driver
[    4.402441] e100: Copyright(c) 1999-2006 Intel Corporation
[    4.403066] e1000: Intel(R) PRO/1000 Network Driver
[    4.403679] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    4.509317] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    4.559622] ata1: found unknown device (class 0)
[    4.560897] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    4.561671] ata1.00: 16777216 sectors, multi 16: LBA48 
[    4.562736] ata2: found unknown device (class 0)
[    4.564077] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    4.565377] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    4.567764] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.59 GB/8.00 GiB)
[    4.568790] sd 0:0:0:0: [sda] Write Protect is off
[    4.569433] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.569484] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.570012] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.570762] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    4.572588] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    4.588516] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.604098] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[    4.839639] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    4.840338] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    4.841028] e1000e: Intel(R) PRO/1000 Network Driver
[    4.841501] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.842101] igb: Intel(R) Gigabit Ethernet Network Driver
[    4.842606] igb: Copyright (c) 2007-2014 Intel Corporation.
[    4.843206] PPP generic driver version 2.4.2
[    4.844049] VFIO - User Level meta-driver version: 0.3
[    4.844837] usbcore: registered new interface driver uas
[    4.845451] usbcore: registered new interface driver usb-storage
[    4.846130] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    4.847522] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.847976] serio: i8042 AUX port at 0x60,0x64 irq 12
[    4.848857] mousedev: PS/2 mouse device common for all mice
[    4.849863] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    4.851344] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
[    4.851528] rtc_cmos 00:05: RTC can wake from S4
[    4.852541] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[    4.853791] rtc_cmos 00:05: registered as rtc0
[    4.854523] rtc_cmos 00:05: setting system clock to 2022-11-17T01:18:20 UTC (1668647900)
[    4.855636] rtc_cmos 00:05: GPIO lookup for consumer wp
[    4.855650] rtc_cmos 00:05: using ACPI for GPIO lookup
[    4.855664] acpi PNP0B00:00: GPIO: looking up wp-gpios
[    4.855679] acpi PNP0B00:00: GPIO: looking up wp-gpio
[    4.855691] rtc_cmos 00:05: using lookup tables for GPIO lookup
[    4.855703] rtc_cmos 00:05: No GPIO consumer wp found
[    4.855774] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    4.856853] i2c_dev: i2c /dev entries driver
[    4.857466] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    4.859146] device-mapper: uevent: version 1.0.3
[    4.860009] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[    4.861089] intel_pstate: CPU model not supported
[    4.861785] sdhci: Secure Digital Host Controller Interface driver
[    4.862568] sdhci: Copyright(c) Pierre Ossman
[    4.863215] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.864022] ledtrig-cpu: registered to indicate activity on CPUs
[    4.865092] drop_monitor: Initializing network drop monitor service
[    4.866526] NET: Registered PF_INET6 protocol family
[    4.868394] Segment Routing with IPv6
[    4.868933] In-situ OAM (IOAM) with IPv6
[    4.869466] NET: Registered PF_PACKET protocol family
[    4.870309] 9pnet: Installing 9P2000 support
[    4.870915] Key type dns_resolver registered
[    4.872216] IPI shorthand broadcast: enabled
[    4.872817] sched_clock: Marking stable (4856915564, 14779948)->(4883871393, -12175881)
[    4.874202] registered taskstats version 1
[    4.874824] Loading compiled-in X.509 certificates
[    4.875754] zswap: loaded using pool lzo/zbud
[    4.876603] Key type .fscrypt registered
[    4.877100] Key type fscrypt-provisioning registered
[    4.878456] Key type encrypted registered
[    4.878992] ima: No TPM chip found, activating TPM-bypass!
[    4.879721] ima: Allocated hash algorithm: sha1
[    4.880302] ima: No architecture policies found
[    4.880911] evm: Initialising EVM extended attributes:
[    4.881579] evm: security.selinux
[    4.882004] evm: security.SMACK64
[    4.882425] evm: security.SMACK64EXEC
[    4.882879] evm: security.SMACK64TRANSMUTE
[    4.883393] evm: security.SMACK64MMAP
[    4.883876] evm: security.apparmor
[    4.884319] evm: security.ima
[    4.884697] evm: security.capability
[    4.885149] evm: HMAC attrs: 0x1
[    4.888984] PM:   Magic number: 14:681:306
[    4.889619] tty tty35: hash matches
[    4.890463] RAS: Correctable Errors collector initialized.
[    4.891167] md: Waiting for all devices to be available before autodetect
[    4.891603] md: If you don't use raid, use raid=noautodetect
[    4.891928] md: Autodetecting RAID arrays.
[    4.892173] md: autorun ...
[    4.892339] md: ... autorun DONE.
[    4.894910] EXT4-fs (sda): INFO: recovery required on readonly filesystem
[    4.895490] EXT4-fs (sda): write access will be enabled during recovery
[    4.933779] EXT4-fs (sda): recovery complete
[    4.935938] EXT4-fs (sda): mounted filesystem with ordered data mode. Quota mode: none.
[    4.936769] VFS: Mounted root (ext4 filesystem) readonly on device 8:0.
[    4.937746] devtmpfs: mounted
[    4.952326] Freeing unused decrypted memory: 2036K
[    4.955187] Freeing unused kernel image (initmem) memory: 3624K
[    4.955795] Write protecting the kernel read-only data: 40960k
[    4.959540] Freeing unused kernel image (text/rodata gap) memory: 2028K
[    4.960655] Freeing unused kernel image (rodata/data gap) memory: 664K
[    5.083696] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    5.084123] Run /sbin/init as init process
[    5.084472]   with arguments:
[    5.084477]     /sbin/init
[    5.084483]   with environment:
[    5.084487]     HOME=/
[    5.084493]     TERM=linux
[    5.162148] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
[    5.182129] systemd[1]: systemd 239 (239-49.el8) running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +G)
[    5.184305] systemd[1]: Detected virtualization kvm.
[    5.184774] systemd[1]: Detected architecture x86-64.
[    5.243288] systemd[1]: Set hostname to <test>.
[    6.267466] random: crng init done
[    6.345362] systemd[1]: Listening on udev Control Socket.
[    6.350882] systemd[1]: Listening on Process Core Dump Socket.
[    6.352394] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    6.354143] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    6.355453] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    6.356780] systemd[1]: Listening on udev Kernel Socket.
[    6.667537] EXT4-fs (sda): re-mounted. Quota mode: none.
[    8.287836] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[    8.288739] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    8.487305] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    8.488738] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[   87.978410] ------------[ cut here ]------------
[   87.978430] WARNING: CPU: 0 PID: 970 at kernel/events/core.c:9329 __perf_event_overflow+0x22b/0x270
[   87.978464] Modules linked in:
[   87.978470] CPU: 0 PID: 970 Comm: repro Not tainted 6.1.0-rc5-kvmperfoverflow+ #10
[   87.978487] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   87.978498] RIP: 0010:__perf_event_overflow+0x22b/0x270
[   87.978516] Code: b6 45 d3 84 c0 0f 84 26 ff ff ff e8 4f 31 ec ff 8b 75 d4 44 89 ff e8 04 32 ec ff 44 3b 7d d4 0f 84 0c ff ff ff e8 35 31 ec ff <0f> 0b e9 00 6
[   87.978531] RSP: 0000:fffffe000000db58 EFLAGS: 00010046
[   87.978543] RAX: 0000000000000000 RBX: ffff888004ed5ce0 RCX: ffffffff8138b67c
[   87.978554] RDX: 0000000000000000 RSI: ffff88800b8e9fc0 RDI: 0000000000000002
[   87.978565] RBP: fffffe000000db88 R08: 0000001ffad06476 R09: 0000000000000000
[   87.978583] R10: 0000000000000000 R11: 0000000000000000 R12: fffffe000000def8
[   87.978594] R13: fffffe000000dc00 R14: 0000000000000000 R15: 0000000088db7a04
[   87.978607] FS:  00007f9988c8b740(0000) GS:ffff88807dc00000(0000) knlGS:ffff88807dc00000
[   87.978625] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.978639] CR2: 0000000020000200 CR3: 000000000a77c003 CR4: 0000000000770ef0
[   87.978655] PKRU: 55555554
[   87.978662] Call Trace:
[   87.978667]  <NMI>
[   87.978675]  perf_event_overflow+0x33/0x40
[   87.978705]  handle_pmi_common+0x2d8/0x560
[   87.978736]  ? write_comp_data+0x2f/0x90
[   87.978760]  ? write_comp_data+0x2f/0x90
[   87.978783]  intel_pmu_handle_irq+0x183/0x680
[   87.978805]  perf_event_nmi_handler+0x42/0x70
[   87.978842]  nmi_handle+0x63/0x160
[   87.978872]  default_do_nmi+0x77/0x190
[   87.978903]  exc_nmi+0x157/0x190
[   87.978932]  end_repeat_nmi+0x16/0x67
[   87.978963] RIP: 0010:asm_sysvec_irq_work+0x0/0x30
[   87.978993] Code: ca fc 6a ff e8 a1 05 00 00 48 89 c4 48 8d 6c 24 01 48 89 e7 e8 e1 56 ea ff e9 bc 06 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 <f3> 0f 1e fa 4
[   87.979010] RSP: 0000:fffffe0000002fd8 EFLAGS: 00000002
[   87.979024] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f9988db059d
[   87.979037] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000200
[   87.979049] RBP: 00007ffe528b2a70 R08: 0000000000000003 R09: 0000000000401a60
[   87.979062] R10: 00000000ffffffff R11: 0000000000000202 R12: 00000000004010e0
[   87.979075] R13: 00007ffe528b2b50 R14: 0000000000000000 R15: 0000000000000000
[   87.979093]  ? asm_sysvec_thermal+0x30/0x30
[   87.979123]  ? asm_sysvec_thermal+0x30/0x30
[   87.979153]  </NMI>
[   87.979158]  <ENTRY_TRAMPOLINE>
[   87.979165]  </ENTRY_TRAMPOLINE>
[   87.979171] ---[ end trace 0000000000000000 ]---
[   87.979192] perf: interrupt took too long (7554 > 2500), lowering kernel.perf_event_max_sample_rate to 26250
[   88.920577] perf: interrupt took too long (9602 > 9442), lowering kernel.perf_event_max_sample_rate to 20750
[   89.861029] perf: interrupt took too long (12377 > 12002), lowering kernel.perf_event_max_sample_rate to 16000

--TJ9SZJM9gozULrP/--
