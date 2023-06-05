Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3428E721B38
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 02:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjFEA1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 20:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEA1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 20:27:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3D1CC;
        Sun,  4 Jun 2023 17:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685924824; x=1717460824;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=LFvG+CQBvNOnLIHcGvVhFW6G7IMkPuKL21CXPtD3zh4=;
  b=mmGIwfwnH7Ca5jAwWEGuTrsx8xgOU+DPR8WOBt6rxVOFVC5qcWRpZ7FF
   kgHokUu5F0Ple7AxGgZLcsBPYsteXesE2KY3ez6yTBBftrJ4vdKS5nJf0
   2eQ2j7uor2MDWFJ/aUgr0Ib9hnbXtTL0Cvq0CDhIp2tLF6jVhi9uqfq7q
   SAOwutN4ODFWfPckN0CdIvbiTjJdUev3DR5QXNDGepaZr3ACWC81IwACG
   rdVCW/MkAeDr2utieyHFuO/4hGIYPPRtCHtJrVRtZE14vtiJrlL1QoMr0
   IErSrkn6i2hSL4Qq381hBxHMFeW6WPz+wIH3OxOQVcOaOWfaPdso+KUon
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="384541225"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="xz'341?scan'341,208,341";a="384541225"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 17:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="882721357"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="xz'341?scan'341,208,341";a="882721357"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 04 Jun 2023 17:27:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 17:27:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 4 Jun 2023 17:27:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 4 Jun 2023 17:27:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRj8JOt4MAqwRMSd7NnVfKtxWdQjSyGNN+zEVJYrSQdSQp958DwNcFiQndH62YmRObLFV3z/jxe/M75isSkxIk3umkmPK9zWj1Nbi/JOPAAG/rcbjSs4C6/jNqqpjC10jFYBwDZllFcNy0iXmR6i2/CvUxbitad/z5apJizmz+zdWO4v2XQprnPBfziM8vih6FlPm0vAgp8uJQJroyLJxUyp8uQvDI7og2U4DpB280Io3CAloiz9xvwC5cw4EWF4tH2ts967hXwY5wX9405quYhzH5fHxiIzp6M3FC96RXuNxXLvFii8w0ra3KuXTe71xU3C5A5cQ/10BM//HunErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAEcV2ro7lNFOSrR6dyFIOuOWQE6IsWvMXuNtMG6dQU=;
 b=Y3ea5j40NHPVnsAgZDtAJlX/bhxjxqu9+Nl3iAc6Khdw+DNxO9LSo7OrrwQUrJ7sZvJ3LFuXRuMC88UDZpyxPfi0yVmXeuoyVFbYqWX1w67C6NNG6nundC9/uLT2wZ0u6BKjiqBiAlTtC8W1Sgj0CZ2VPm5thrCq1I/nphNPbjFI3QZnrUI5a5PEQI15CNgrd1s8dUWuXPQkEHfoe8b0bNk2R550wjCGQL1cn2IYI2Gh8u5smD+rYwuSJWQa8zBI6N0sCRidSwkVNkWEUjREhGuc44H1GKtJJTm3vElHWPBYyWfP4rD1z1WIOJ7f+xCH/InjVY511XFbsD5Fi4PHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 00:26:55 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::35cf:8518:48ea:b10a%6]) with mapi id 15.20.6455.028; Mon, 5 Jun 2023
 00:26:55 +0000
Date:   Mon, 5 Jun 2023 08:26:40 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Roy Luo <royluo@google.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <linux-doc@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <raychi@google.com>, <badhri@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <linux-kernel@vger.kernel.org>, Roy Luo <royluo@google.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v2] usb: core: add sysfs entry for usb device state
Message-ID: <202306042228.e532af6e-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="2KkCpu/jcF/0UwXN"
Content-Disposition: inline
In-Reply-To: <20230601235531.2285354-1-royluo@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BN9PR11MB5545:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d959b2-0501-4569-6326-08db655b903c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otEkZFQs0t0ScKm0th/FdHQbTY5MKIm/tqPp2EYbX+hLmD6DV87R52X0Pv+1svDhntGkpTzTMB0WgDH/poJ4gWT351SxOYB8C7b46xFwQMQTp6kwAoPEA0yJBSZI2BcLAiJjlDudbfSOj3pkN+0IBNlOclptg8sP7UoH2TE+0KMexcBdeOMEsouyktzM1uHkdCZ5vyQxb1adebcRAlbqsYkzkbMAFNwu3vf08M6eqmWskfKXVz4CkHbWnR2nuLRVPmS/gDuXWd9OqvYarT+Rc9beGBIn8XsaFOEzH/pQP2EEaXhfBXEwhyu/avxWf6987GrviWr3cuPc8tkVb+LQ8caxw0r/0slOuQyR/QpjntiNYjYMtvl5dT3DAr+RjeHZ8qTObn7B3XYez+LX6GN0LicDRlHr1NdxcW4t1TxtTeqPRUNxdqmpvx3W+UpP6IgmTWsaVCFMA8rcoDyiu9KzYueyy6Fm7NAH8u0WTlFoMo9dJ/k9xeh3WNNiMc7Zx5aHKPKdZy4HSneKIsGJMGXaq5I88cILJJI+Q7GgJOsNTfQZj+xzA/eT5tr9XDW8Nyg+OnXBfdDcjtdJnq5RWVw66AfA9eUK+HNjHUFFSfy9q+nsFTUSX45gGt7rp54gy6tNYG16nqMhTwouTDR8nVuV664oOFnTz5eKNNLsPH9rGUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(36756003)(30864003)(2906002)(86362001)(7416002)(5660300002)(235185007)(83380400001)(6666004)(6486002)(44144004)(966005)(186003)(1076003)(26005)(6506007)(6512007)(82960400001)(478600001)(54906003)(6916009)(316002)(38100700002)(66476007)(4326008)(66946007)(2616005)(41300700001)(66556008)(8936002)(8676002)(95444003)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n27irDUNqdPyd7mZbuADd/6fi3u9ylFDrHvPmRlD4XLZ7wmmn56GNCzkuzLP?=
 =?us-ascii?Q?3qgf797LPEBt0nEKiX5y+8g8nLECdRlJph6cz4dslUTKsT9ZtM+USRAZ+4LB?=
 =?us-ascii?Q?hwpccJgPikggunWBr1gHJp5EgYEaNl2f5u90eZ0sshp5fUZuDMKmmTfw5UHd?=
 =?us-ascii?Q?I6O740NYhcVJ3ufRroHXuITpSdzmK5V31/watgDyaxxry/kaID6UearO42cK?=
 =?us-ascii?Q?g0kztlTOz4T4euKgsjvo4E3gNJzG5KUUBb88s7RH3LdA9i0PBjHEPBGQ6ciJ?=
 =?us-ascii?Q?p0F30NafdenHv0/ga+YKLCz9rPUwE52bu+t8+67KSSMnas8lw/CajV0S2IUv?=
 =?us-ascii?Q?TqDgK3gmV2+77qN2QDcvR6RzErQRZmN14VxSItWy2lVM+qqf4TjI3h7FKjM4?=
 =?us-ascii?Q?ylD7qYv2Uk+SR3Ic1NA+Uok/FdE0B/YnBxLExRWNwQVroGBfofXuvtlaRqqo?=
 =?us-ascii?Q?u6LLIs6zbbl+T19x8jhO1WPgeSdjNLYbDQPL78IoKEkR5gmYDwD6TH58LyKG?=
 =?us-ascii?Q?rlS07bg4rLSP8Tv0efYZgVzkJJGkY9D+IjL7e+VoYRoNy0C9Mng8AgAKMcMs?=
 =?us-ascii?Q?sNJQhEO9yM5KxLzlkcNcLTbA2VRr027oP4BOexL9+nU2pbJ2U4ilEC7z3u1U?=
 =?us-ascii?Q?3IW1yOaceUzQdAowWdUoG/btNmtIoVPIMedZP3hJnUOBXzird+QwhnUPKV7v?=
 =?us-ascii?Q?O8bF3o9PY+QdMK/RUOxAje4dbQxS4vTJ0NhhTZs6me4nQmq+YaJLrtKcvQ5N?=
 =?us-ascii?Q?xEBhpzh1g8b6PNMiDqBWXQp5zqrjYzHTkz8T5sMjZn5wg4u3tit7OtOdkTsg?=
 =?us-ascii?Q?pTMaJvoF0uB5dbPlNgC8t8/M4EB+8zvagfP34HMnobDH+A8rSBGOYWkhySrT?=
 =?us-ascii?Q?MD+uVZynXsx1QPEH0ozFldRF6eEzqFz4NvfPD6/XhX3N29WCVT/1jezlkufr?=
 =?us-ascii?Q?iI2TyiYZwMkcz0UmbLj0S+8IHukXmxCg5hc+mk7MOpG/sy2fa2kBRmsppPra?=
 =?us-ascii?Q?du/PSRwkuB+k35+oPehbBI5GDvK3Qem4zJfQeDcP1jixZs+5+mH9BTf5D+L/?=
 =?us-ascii?Q?4tnf6uF6r4YxG/wqaB3jy9+JeqRWuBV5kZBf/gqw7ow49Gc/N3qNlZ6kIyp4?=
 =?us-ascii?Q?Dts2xus4bzTKAAgydJPnr603CmnBFWTJdXeRcOcvjAXC/zf3utI1NXyCVz6h?=
 =?us-ascii?Q?oGbTpes63gzwOw0dwE7G7hE28vNjZADz47KjVMDCaAIu4uta3m3P6NBZJuxe?=
 =?us-ascii?Q?0P82wO7yPFu/8SSXtZqA1oFPl62fNTj2szX09vB+uKdtvqHZtw16KTvQhzfd?=
 =?us-ascii?Q?vLzru8+yraiY/LjoNdyPXqCNblLEFBxmH76KffoDxkOceFc3FkHheeaU6XDr?=
 =?us-ascii?Q?MGnCjLxr59GNT0ZQn2EmVoPg9mZTLXflrCqMt6neKC8Lde8e16kV4zRHYWHe?=
 =?us-ascii?Q?4Bh6oc7YQo2fwKS+W5KtomRde1DRLRDN045cYUGQWluTw9ianrqhNKbkODBD?=
 =?us-ascii?Q?Xca7rBoxM9v8epo3HtLrjyPsXBjRE+EMiemJCE2Yh3TGMK6X0wMvtlzkCsRz?=
 =?us-ascii?Q?WQjP96OFVtoEjQogJiLNCIj7Eveye9m65iasXfCvCUVQ49YSA7fUSoY/A4Bx?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d959b2-0501-4569-6326-08db655b903c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 00:26:55.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDoUzQ+e/gUlJBOT7M5JWeQ11xXJAtE2ZYpsHnhrBmaOks0IGbjysEqDi3qTWTuheiFo75PeQsa8KVQfXzyfhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5545
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2KkCpu/jcF/0UwXN
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/rwsem.c" on:

commit: 130794a2eeb26bc2fa5774dee181661612d0fabf ("[PATCH v2] usb: core: add sysfs entry for usb device state")
url: https://github.com/intel-lab-lkp/linux/commits/Roy-Luo/usb-core-add-sysfs-entry-for-usb-device-state/20230602-075645
patch link: https://lore.kernel.org/all/20230601235531.2285354-1-royluo@google.com/
patch subject: [PATCH v2] usb: core: add sysfs entry for usb device state

in testcase: boot

compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------------------+------------+------------+
|                                                                             | 933174ae28 | 130794a2ee |
+-----------------------------------------------------------------------------+------------+------------+
| BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/rwsem.c | 0          | 12         |
+-----------------------------------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202306042228.e532af6e-oliver.sang@intel.com


[   20.403699][    T7] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1519
[   20.404735][    T7] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 7, name: kworker/0:0
[   20.405720][    T7] preempt_count: 1, expected: 0
[   20.406268][    T7] RCU nest depth: 0, expected: 0
[   20.406828][    T7] 6 locks held by kworker/0:0/7:
[ 20.407053][ T7] #0: c13e67a4 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work (workqueue.c:?) 
[ 20.407053][ T7] #1: c129df48 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work (workqueue.c:?) 
[ 20.407053][ T7] #2: ed5968f4 (&dev->mutex){....}-{3:3}, at: hub_event (hub.c:?) 
[ 20.407053][ T7] #3: ed5edac8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect (hub.c:?) 
[ 20.407053][ T7] #4: ed0c3dfc (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect (hub.c:?) 
[ 20.407053][ T7] #5: d4c9b550 (device_state_lock){....}-{2:2}, at: usb_set_device_state (??:?) 
[   20.407053][    T7] irq event stamp: 234
[ 20.407053][ T7] hardirqs last enabled at (233): _raw_spin_unlock_irq (??:?) 
[ 20.407053][ T7] hardirqs last disabled at (234): _raw_spin_lock_irqsave (??:?) 
[ 20.407053][ T7] softirqs last enabled at (0): copy_process (??:?) 
[ 20.407053][ T7] softirqs last disabled at (0): 0x0 
[   20.407053][    T7] CPU: 0 PID: 7 Comm: kworker/0:0 Tainted: G S                 6.4.0-rc3-00033-g130794a2eeb2 #29
[   20.407053][    T7] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   20.407053][    T7] Workqueue: usb_hub_wq hub_event
[   20.407053][    T7] Call Trace:
[ 20.407053][ T7] dump_stack_lvl (??:?) 
[ 20.407053][ T7] dump_stack (??:?) 
[ 20.407053][ T7] __might_resched (??:?) 
[ 20.407053][ T7] __might_sleep (??:?) 
[ 20.407053][ T7] ? usb_set_device_state (??:?) 
[ 20.407053][ T7] down_read (??:?) 
[ 20.407053][ T7] ? _raw_spin_unlock_irq (??:?) 
[ 20.407053][ T7] ? pm_runtime_set_autosuspend_delay (??:?) 
[ 20.407053][ T7] kernfs_find_and_get_ns (??:?) 
[ 20.407053][ T7] update_port_device_state (hub.c:?) 
[ 20.407053][ T7] usb_set_device_state (??:?) 
[ 20.407053][ T7] hub_port_connect (hub.c:?) 
[ 20.407053][ T7] ? hub_port_connect_change (hub.c:?) 
[ 20.407053][ T7] ? lock_release (??:?) 
[ 20.407053][ T7] hub_port_connect_change (hub.c:?) 
[ 20.407053][ T7] ? mutex_unlock (??:?) 
[ 20.407053][ T7] ? hub_ext_port_status (hub.c:?) 
[ 20.407053][ T7] port_event (hub.c:?) 
[ 20.407053][ T7] ? lockdep_hardirqs_on_prepare (lockdep.c:?) 
[ 20.407053][ T7] ? pm_runtime_barrier (??:?) 
[ 20.407053][ T7] hub_event (hub.c:?) 
[ 20.407053][ T7] ? process_one_work (workqueue.c:?) 
[ 20.407053][ T7] ? trace_hardirqs_on (??:?) 
[ 20.407053][ T7] process_one_work (workqueue.c:?) 
[ 20.407053][ T7] ? process_one_work (workqueue.c:?) 
[ 20.407053][ T7] ? rcuwait_wake_up (??:?) 
[ 20.407053][ T7] worker_thread (workqueue.c:?) 
[ 20.407053][ T7] kthread (kthread.c:?) 
[ 20.407053][ T7] ? process_one_work (workqueue.c:?) 
[ 20.407053][ T7] ? kthread_complete_and_exit (kthread.c:?) 
[ 20.407053][ T7] ret_from_fork (??:?) 
[   20.407053][    T7]
[   20.407053][    T7] =============================
[   20.407053][    T7] [ BUG: Invalid wait context ]
[   20.407053][    T7] 6.4.0-rc3-00033-g130794a2eeb2 #29 Tainted: G S      W
[   20.407053][    T7] -----------------------------
[   20.407053][    T7] kworker/0:0/7 is trying to lock:
[ 20.407053][ T7] c1272cb4 (&root->kernfs_rwsem){++++}-{3:3}, at: kernfs_find_and_get_ns (??:?) 
[   20.407053][    T7] other info that might help us debug this:
[   20.407053][    T7] context-{4:4}
[   20.407053][    T7] 6 locks held by kworker/0:0/7:
[ 20.407053][ T7] #0: c13e67a4 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work (workqueue.c:?) 
[ 20.407053][ T7] #1: c129df48 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work (workqueue.c:?) 
[ 20.407053][ T7] #2: ed5968f4 (&dev->mutex){....}-{3:3}, at: hub_event (hub.c:?) 
[ 20.407053][ T7] #3: ed5edac8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect (hub.c:?) 
[ 20.407053][ T7] #4: ed0c3dfc (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect (hub.c:?) 
[ 20.407053][ T7] #5: d4c9b550 (device_state_lock){....}-{2:2}, at: usb_set_device_state (??:?) 
[   20.407053][    T7] stack backtrace:
[   20.407053][    T7] CPU: 0 PID: 7 Comm: kworker/0:0 Tainted: G S      W          6.4.0-rc3-00033-g130794a2eeb2 #29
[   20.407053][    T7] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   20.407053][    T7] Workqueue: usb_hub_wq hub_event
[   20.407053][    T7] Call Trace:
[ 20.407053][ T7] dump_stack_lvl (??:?) 
[ 20.407053][ T7] dump_stack (??:?) 
[ 20.407053][ T7] __lock_acquire (lockdep.c:?) 
[ 20.407053][ T7] ? dump_stack_lvl (??:?) 
[ 20.407053][ T7] lock_acquire (??:?) 
[ 20.407053][ T7] ? kernfs_find_and_get_ns (??:?) 
[ 20.407053][ T7] ? __might_sleep (??:?) 
[ 20.407053][ T7] down_read (??:?) 
[ 20.407053][ T7] ? kernfs_find_and_get_ns (??:?) 
[ 20.407053][ T7] ? pm_runtime_set_autosuspend_delay (??:?) 
[ 20.407053][ T7] kernfs_find_and_get_ns (??:?) 
[ 20.407053][ T7] update_port_device_state (hub.c:?) 
[ 20.407053][ T7] usb_set_device_state (??:?) 
[ 20.407053][ T7] hub_port_connect (hub.c:?) 
[ 20.407053][ T7] ? hub_port_connect_change (hub.c:?) 
[ 20.407053][ T7] ? lock_release (??:?) 
[ 20.407053][ T7] hub_port_connect_change (hub.c:?) 
[ 20.407053][ T7] ? mutex_unlock (??:?) 
[ 20.407053][ T7] ? hub_ext_port_status (hub.c:?) 
[ 20.407053][ T7] port_event (hub.c:?) 
[ 20.407053][ T7] ? lockdep_hardirqs_on_prepare (lockdep.c:?) 
[ 20.407053][ T7] ? pm_runtime_barrier (??:?) 
[ 20.407053][ T7] hub_event (hub.c:?) 
[ 20.407053][ T7] ? process_one_work (workqueue.c:?) 
[ 20.407053][ T7] ? trace_hardirqs_on (??:?) 
[ 20.407053][ T7] process_one_work (workqueue.c:?) 
[ 20.407053][ T7] ? process_one_work (workqueue.c:?) 
[ 20.407053][ T7] ? rcuwait_wake_up (??:?) 
[ 20.407053][ T7] worker_thread (workqueue.c:?) 
[ 20.407053][ T7] kthread (kthread.c:?) 
[ 20.407053][ T7] ? process_one_work (workqueue.c:?) 
[ 20.407053][ T7] ? kthread_complete_and_exit (kthread.c:?) 
[ 20.407053][ T7] ret_from_fork (??:?) 
[ 20.485486][ T1] initcall apanel_init+0x0/0x20c returned -19 after 88573 usecs 
[ 20.486325][ T1] calling atmel_captouch_driver_init+0x0/0x14 @ 1 
[ 20.487093][ T1] initcall atmel_captouch_driver_init+0x0/0x14 returned 0 after 68 usecs 
[ 20.488002][ T1] calling cm109_init+0x0/0x12c @ 1 
[   20.488571][    T1] cm109: Keymap for Komunikate KIP1000 phone loaded
[   20.489313][    T1] usbcore: registered new interface driver cm109
[   20.489992][    T1] cm109: CM109 phone driver: 20080805 (C) Alfred E. Heggestad
[ 20.490827][ T1] initcall cm109_init+0x0/0x12c returned 0 after 2256 usecs 
[ 20.491595][ T1] calling da9055_onkey_driver_init+0x0/0x14 @ 1 
[ 20.492327][ T1] initcall da9055_onkey_driver_init+0x0/0x14 returned 0 after 58 usecs 
[ 20.493218][ T1] calling e3x0_button_driver_init+0x0/0x14 @ 1 
[ 20.493906][ T1] initcall e3x0_button_driver_init+0x0/0x14 returned 0 after 23 usecs 
[ 20.494789][ T1] calling drv2667_driver_init+0x0/0x14 @ 1 
[ 20.495453][ T1] initcall drv2667_driver_init+0x0/0x14 returned 0 after 24 usecs 
[ 20.496299][ T1] calling gpio_beeper_platform_driver_init+0x0/0x14 @ 1 
[ 20.497073][ T1] initcall gpio_beeper_platform_driver_init+0x0/0x14 returned 0 after 23 usecs 
[ 20.498029][ T1] calling gpio_decoder_driver_init+0x0/0x14 @ 1 
[ 20.498725][ T1] initcall gpio_decoder_driver_init+0x0/0x14 returned 0 after 23 usecs 
[ 20.499617][ T1] calling gpio_vibrator_driver_init+0x0/0x14 @ 1 
[ 20.500324][ T1] initcall gpio_vibrator_driver_init+0x0/0x14 returned 0 after 22 usecs 
[ 20.501224][ T1] calling iqs269_i2c_driver_init+0x0/0x14 @ 1 
[ 20.501905][ T1] initcall iqs269_i2c_driver_init+0x0/0x14 returned 0 after 22 usecs 
[ 20.502785][ T1] calling iqs626_i2c_driver_init+0x0/0x14 @ 1 
[ 20.503474][ T1] initcall iqs626_i2c_driver_init+0x0/0x14 returned 0 after 27 usecs 
[ 20.504344][ T1] calling keyspan_driver_init+0x0/0x18 @ 1 
[   20.505007][    T1] usbcore: registered new interface driver keyspan_remote
[ 20.505756][ T1] initcall keyspan_driver_init+0x0/0x18 returned 0 after 776 usecs 
[ 20.506609][ T1] calling max77650_onkey_driver_init+0x0/0x14 @ 1 
[ 20.507341][ T1] initcall max77650_onkey_driver_init+0x0/0x14 returned 0 after 29 usecs 
[ 20.508247][ T1] calling max8925_onkey_driver_init+0x0/0x14 @ 1 
[ 20.508956][ T1] initcall max8925_onkey_driver_init+0x0/0x14 returned 0 after 27 usecs 
[ 20.509848][ T1] calling pcf8574_kp_driver_init+0x0/0x14 @ 1 
[ 20.510529][ T1] initcall pcf8574_kp_driver_init+0x0/0x14 returned 0 after 21 usecs 
[ 20.511411][ T1] calling regulator_haptic_driver_init+0x0/0x14 @ 1 
[ 20.512150][ T1] initcall regulator_haptic_driver_init+0x0/0x14 returned 0 after 27 usecs 
[ 20.513072][ T1] calling retu_pwrbutton_driver_init+0x0/0x14 @ 1 
[ 20.513791][ T1] initcall retu_pwrbutton_driver_init+0x0/0x14 returned 0 after 28 usecs 
[ 20.514692][ T1] calling rotary_encoder_driver_init+0x0/0x14 @ 1 
[ 20.515420][ T1] initcall rotary_encoder_driver_init+0x0/0x14 returned 0 after 23 usecs 
[ 20.516326][ T1] calling stpmic1_onkey_driver_init+0x0/0x14 @ 1 
[ 20.517028][ T1] initcall stpmic1_onkey_driver_init+0x0/0x14 returned 0 after 22 usecs 
[ 20.517928][ T1] calling tps6521x_pb_driver_init+0x0/0x20 @ 1 
[ 20.518620][ T1] initcall tps6521x_pb_driver_init+0x0/0x20 returned 0 after 28 usecs 
[ 20.519512][ T1] calling wb_module_init+0x0/0x1c4 @ 1 
[   20.520122][    T1] wistron_btns: System unknown
[ 20.520649][ T1] initcall wb_module_init+0x0/0x1c4 returned -19 after 534 usecs 
[ 20.521482][ T1] calling yealink_driver_init+0x0/0x20 @ 1 
[   20.522143][    T1] usbcore: registered new interface driver yealink
[ 20.522841][ T1] initcall yealink_driver_init+0x0/0x20 returned 0 after 724 usecs 


To reproduce:

        # build kernel
	cd linux
	cp config-6.4.0-rc3-00033-g130794a2eeb2 .config
	make HOSTCC=gcc-12 CC=gcc-12 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-12 CC=gcc-12 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--2KkCpu/jcF/0UwXN
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc3-00033-g130794a2eeb2"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.4.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_UAPI_HEADER_TEST=y
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_ANCIENT_MCE=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_TOSHIBA is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=0
CONFIG_FUNCTION_PADDING_BYTES=4
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_RETPOLINE=y
# CONFIG_RETHUNK is not set
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_ALLOW_INTS=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO1_PM is not set
# CONFIG_OLPC_XO15_SCI is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT=4
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_FC_APPID=y
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLUB_STATS=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_BOUNCE=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ZONE_DMA=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_MAX_SKB_FRAGS=17
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEFAULT is not set
CONFIG_PCIEASPM_POWERSAVE=y
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
CONFIG_PCI_FTPCI100=y
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_MICROCHIP_HOST is not set
# CONFIG_PCIE_XILINX is not set

#
# Cadence-based PCIe controllers
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_EP=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
CONFIG_PCI_J721E=y
CONFIG_PCI_J721E_HOST=y
CONFIG_PCI_J721E_EP=y
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_EP=y
CONFIG_PCI_MESON=y
# CONFIG_PCIE_INTEL_GW is not set
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
CONFIG_PCIE_DW_PLAT_EP=y
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
# CONFIG_PCI_EPF_TEST is not set
CONFIG_PCI_EPF_NTB=y
# CONFIG_PCI_EPF_VNTB is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_CXL_BUS=y
CONFIG_CXL_PCI=y
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_CXL_ACPI=y
CONFIG_CXL_MEM=y
CONFIG_CXL_PORT=y
CONFIG_CXL_SUSPEND=y
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_CPS_GEN2=y
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_CS5535_MFGPT=y
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
CONFIG_CS5535_CLOCK_EVENT_SRC=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_VMWARE_BALLOON is not set
CONFIG_PCH_PHUB=y
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
# CONFIG_HISI_HIKEY_USB is not set
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=y
# CONFIG_ECHO is not set
CONFIG_BCM_VK=y
# CONFIG_BCM_VK_TTY is not set
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=y
CONFIG_MISC_RTSX_USB=y
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_HPSA=y
CONFIG_SCSI_3W_9XXX=y
CONFIG_SCSI_3W_SAS=y
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AHA152X=y
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
CONFIG_SCSI_AIC94XX=y
CONFIG_AIC94XX_DEBUG=y
CONFIG_SCSI_MVSAS=y
CONFIG_SCSI_MVSAS_DEBUG=y
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_ARCMSR=y
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
CONFIG_MEGARAID_MAILBOX=y
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
CONFIG_SCSI_MPI3MR=y
CONFIG_SCSI_SMARTPQI=y
# CONFIG_SCSI_HPTIOP is not set
CONFIG_SCSI_BUSLOGIC=y
# CONFIG_SCSI_FLASHPOINT is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_SCSI_SNIC=y
CONFIG_SCSI_SNIC_DEBUG_FS=y
CONFIG_SCSI_DMX3191D=y
CONFIG_SCSI_FDOMAIN=y
CONFIG_SCSI_FDOMAIN_PCI=y
CONFIG_SCSI_FDOMAIN_ISA=y
CONFIG_SCSI_ISCI=y
CONFIG_SCSI_GENERIC_NCR5380=y
CONFIG_SCSI_IPS=y
CONFIG_SCSI_INITIO=y
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_STEX=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
CONFIG_SCSI_IPR=y
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
CONFIG_SCSI_QLOGIC_1280=y
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
CONFIG_SCSI_AM53C974=y
CONFIG_SCSI_NSP32=y
CONFIG_SCSI_WD719X=y
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=y
CONFIG_SCSI_VIRTIO=y
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_AHCI_DWC is not set
CONFIG_AHCI_CEVA=y
CONFIG_SATA_INIC162X=y
# CONFIG_SATA_ACARD_AHCI is not set
CONFIG_SATA_SIL24=y
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
CONFIG_SBP_TARGET=y
# CONFIG_REMOTE_TARGET is not set
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=y
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=y
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NTB_NETDEV is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0_ISA is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_PS2_OLPC is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_INPORT=y
CONFIG_MOUSE_ATIXL=y
CONFIG_MOUSE_LOGIBM=y
CONFIG_MOUSE_PC110PAD=y
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
CONFIG_MOUSE_SYNAPTICS_USB=y
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_88PM860X is not set
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMA140=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
# CONFIG_TOUCHSCREEN_CYTTSP5 is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
# CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX is not set
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_ILITEK=y
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=y
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MSG2638=y
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS is not set
# CONFIG_TOUCHSCREEN_IMAGIS is not set
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
CONFIG_TOUCHSCREEN_INEXIO=y
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_HTCPEN is not set
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
CONFIG_TOUCHSCREEN_MC13783=y
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
CONFIG_TOUCHSCREEN_RM_TS=y
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
# CONFIG_TOUCHSCREEN_ST1232 is not set
CONFIG_TOUCHSCREEN_STMFTS=y
# CONFIG_TOUCHSCREEN_SUR40 is not set
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_TOUCHSCREEN_ZINITIX=y
# CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_ATMEL_CAPTOUCH=y
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=y
# CONFIG_INPUT_PCSPKR is not set
CONFIG_INPUT_MAX77650_ONKEY=y
CONFIG_INPUT_MAX8925_ONKEY=y
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
CONFIG_INPUT_WISTRON_BTNS=y
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=y
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_TPS65218_PWRBUTTON=y
# CONFIG_INPUT_AXP20X_PEK is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PCF50633_PMU is not set
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
# CONFIG_INPUT_DA7280_HAPTICS is not set
CONFIG_INPUT_DA9055_ONKEY=y
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
# CONFIG_INPUT_IBM_PANEL is not set
# CONFIG_INPUT_IMS_PCU is not set
CONFIG_INPUT_IQS269A=y
CONFIG_INPUT_IQS626A=y
# CONFIG_INPUT_IQS7222 is not set
CONFIG_INPUT_CMA3000=y
# CONFIG_INPUT_CMA3000_I2C is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
CONFIG_INPUT_STPMIC1_ONKEY=y
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_APBPS2 is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_16550A_VARIANTS=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_FOURPORT=y
# CONFIG_SERIAL_8250_ACCENT is not set
CONFIG_SERIAL_8250_BOCA=y
CONFIG_SERIAL_8250_EXAR_ST16C554=y
# CONFIG_SERIAL_8250_HUB6 is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
CONFIG_SERIAL_LANTIQ=y
# CONFIG_SERIAL_LANTIQ_CONSOLE is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
# CONFIG_SERIAL_TIMBERDALE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
# CONFIG_SERIAL_XILINX_PS_UART_CONSOLE is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_SERIAL_FSL_LINFLEXUART=y
# CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
CONFIG_SERIAL_SPRD=y
# CONFIG_SERIAL_SPRD_CONSOLE is not set
CONFIG_SERIAL_LITEUART=y
CONFIG_SERIAL_LITEUART_MAX_PORTS=1
# CONFIG_SERIAL_LITEUART_CONSOLE is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_IPMB is not set
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_SSIF_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
# CONFIG_HW_RANDOM_GEODE is not set
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_CCTRNG=y
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_DTLK=y
CONFIG_APPLICOM=y
CONFIG_SONYPI=y
# CONFIG_MWAVE is not set
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
# CONFIG_XILLYBUS_OF is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
CONFIG_I2C_CP2615=y
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_PCA_ISA is not set
CONFIG_SCx200_ACB=y
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
# CONFIG_DW_I3C_MASTER is not set
# CONFIG_SVC_I3C_MASTER is not set
CONFIG_MIPI_I3C_HCI=y
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y
CONFIG_GPIO_IDIO_16=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LOGICVC=y
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SIOX=y
# CONFIG_GPIO_SYSCON is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_BD71815 is not set
CONFIG_GPIO_BD71828=y
CONFIG_GPIO_CS5535=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_DLN2=y
# CONFIG_GPIO_ELKHARTLAKE is not set
CONFIG_GPIO_JANZ_TTL=y
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TIMBERDALE=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TQMX86 is not set
CONFIG_GPIO_WM8350=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_LATCH is not set
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_IP5XXX_POWER is not set
CONFIG_MAX8925_POWER=y
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_OLPC=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_CHARGER_DA9150 is not set
CONFIG_BATTERY_DA9150=y
CONFIG_CHARGER_AXP20X=y
CONFIG_BATTERY_AXP20X=y
# CONFIG_AXP20X_POWER is not set
CONFIG_AXP288_FUEL_GAUGE=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77650=y
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MT6360=y
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_BQ25980=y
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65217=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_RT9467 is not set
# CONFIG_CHARGER_RT9471 is not set
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD99954=y
# CONFIG_BATTERY_UG3105 is not set
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
# CONFIG_MAX77620_THERMAL is not set
CONFIG_DA9062_THERMAL=y

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
CONFIG_INTEL_TCC_COOLING=y
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_TI_SOC_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_BD957XMUF_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=y
CONFIG_GPIO_WATCHDOG_ARCH_INITCALL=y
# CONFIG_MENF21BMC_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_WM8350_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_RAVE_SP_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
CONFIG_RN5T618_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_MAX77620_WATCHDOG is not set
CONFIG_RETU_WATCHDOG=y
# CONFIG_STPMIC1_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=y
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=y
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=y
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
# CONFIG_GEODE_WDT is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=y
# CONFIG_ITCO_VENDOR_SUPPORT is not set
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
# CONFIG_60XX_WDT is not set
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=y
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
# CONFIG_MIXCOMWD is not set
CONFIG_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
# CONFIG_MFD_SMPRO is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_MAX597X is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
CONFIG_MFD_GATEWORKS_GSC=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_INTEL_SOC_PMIC_MRFLD is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77714 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_NTXEC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=y
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS65219 is not set
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ROHM_BD718XX is not set
CONFIG_MFD_ROHM_BD71828=y
CONFIG_MFD_ROHM_BD957XMUF=y
CONFIG_MFD_STPMIC1=y
# CONFIG_MFD_STMFX is not set
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_MFD_QCOM_PM8008=y
CONFIG_RAVE_SP_CORE=y
# CONFIG_MFD_RSMU_I2C is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=y
# CONFIG_REGULATOR_AS3711 is not set
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_AXP20X=y
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD71815 is not set
CONFIG_REGULATOR_BD71828=y
CONFIG_REGULATOR_BD957XMUF=y
# CONFIG_REGULATOR_DA9055 is not set
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=y
# CONFIG_REGULATOR_HI6421V530 is not set
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LOCHNAGAR=y
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX20086 is not set
# CONFIG_REGULATOR_MAX20411 is not set
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MCP16502 is not set
CONFIG_REGULATOR_MP5416=y
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
CONFIG_REGULATOR_MPQ7920=y
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6331 is not set
# CONFIG_REGULATOR_MT6332 is not set
# CONFIG_REGULATOR_MT6357 is not set
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6359=y
# CONFIG_REGULATOR_MT6360 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PF8X00=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_ROHM=y
# CONFIG_REGULATOR_RT4801 is not set
# CONFIG_REGULATOR_RT4803 is not set
CONFIG_REGULATOR_RT4831=y
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5739 is not set
# CONFIG_REGULATOR_RT5759 is not set
CONFIG_REGULATOR_RT6160=y
# CONFIG_REGULATOR_RT6190 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=y
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_SKY81452=y
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_STPMIC1=y
# CONFIG_REGULATOR_SY8106A is not set
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS6286X is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM8350=y
CONFIG_RC_CORE=y
# CONFIG_LIRC is not set
CONFIG_RC_MAP=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_IMON_DECODER is not set
CONFIG_IR_JVC_DECODER=y
# CONFIG_IR_MCE_KBD_DECODER is not set
CONFIG_IR_NEC_DECODER=y
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_RCMM_DECODER=y
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=y
CONFIG_IR_SONY_DECODER=y
CONFIG_IR_XMP_DECODER=y
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SECO is not set
CONFIG_USB_PULSE8_CEC=y
CONFIG_USB_RAINSHADOW_CEC=y
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
# end of Media controller options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
# CONFIG_USB_GSPCA is not set
CONFIG_USB_PWC=y
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_USB_S2255 is not set
# CONFIG_USB_VIDEO_CLASS is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_RC=y
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_VIDEO_TVEEPROM=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
# end of Media drivers

#
# Media ancillary drivers
#
# CONFIG_VIDEO_IR_I2C is not set

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_CCS_PLL=y
# CONFIG_VIDEO_AR0521 is not set
CONFIG_VIDEO_HI556=y
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
CONFIG_VIDEO_IMX208=y
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
CONFIG_VIDEO_IMX274=y
CONFIG_VIDEO_IMX290=y
# CONFIG_VIDEO_IMX296 is not set
# CONFIG_VIDEO_IMX319 is not set
CONFIG_VIDEO_IMX334=y
# CONFIG_VIDEO_IMX335 is not set
CONFIG_VIDEO_IMX355=y
CONFIG_VIDEO_IMX412=y
# CONFIG_VIDEO_IMX415 is not set
CONFIG_VIDEO_MAX9271_LIB=y
CONFIG_VIDEO_MT9M001=y
CONFIG_VIDEO_MT9M111=y
CONFIG_VIDEO_MT9P031=y
# CONFIG_VIDEO_MT9T112 is not set
CONFIG_VIDEO_MT9V011=y
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_OG01A1B is not set
CONFIG_VIDEO_OV02A10=y
# CONFIG_VIDEO_OV08D10 is not set
# CONFIG_VIDEO_OV08X40 is not set
CONFIG_VIDEO_OV13858=y
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=y
CONFIG_VIDEO_OV2680=y
# CONFIG_VIDEO_OV2685 is not set
CONFIG_VIDEO_OV2740=y
# CONFIG_VIDEO_OV4689 is not set
CONFIG_VIDEO_OV5640=y
# CONFIG_VIDEO_OV5645 is not set
CONFIG_VIDEO_OV5647=y
CONFIG_VIDEO_OV5648=y
# CONFIG_VIDEO_OV5670 is not set
CONFIG_VIDEO_OV5675=y
# CONFIG_VIDEO_OV5693 is not set
CONFIG_VIDEO_OV5695=y
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV7251=y
# CONFIG_VIDEO_OV7640 is not set
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_OV8856=y
# CONFIG_VIDEO_OV8858 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9282 is not set
CONFIG_VIDEO_OV9640=y
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
CONFIG_VIDEO_RDACM21=y
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K5BAF is not set
CONFIG_VIDEO_S5K6A3=y
# CONFIG_VIDEO_ST_VGXY61 is not set
CONFIG_VIDEO_CCS=y
CONFIG_VIDEO_ET8EK8=y
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
CONFIG_VIDEO_AK7375=y
CONFIG_VIDEO_DW9714=y
CONFIG_VIDEO_DW9768=y
CONFIG_VIDEO_DW9807_VCM=y
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
CONFIG_VIDEO_LM3560=y
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_SONY_BTF_MPX=y
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_TVAUDIO=y
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV748X is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_ISL7998X is not set
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_MAX9286=y
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
# CONFIG_VIDEO_TC358743_CEC is not set
# CONFIG_VIDEO_TC358746 is not set
CONFIG_VIDEO_TVP514X=y
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_TW9910=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
# CONFIG_VIDEO_ADV7343 is not set
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_ADV7511=y
CONFIG_VIDEO_ADV7511_CEC=y
CONFIG_VIDEO_AK881X=y
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
CONFIG_VIDEO_THS8200=y
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_M52790 is not set
CONFIG_VIDEO_ST_MIPID02=y
CONFIG_VIDEO_THS7303=y
# end of Miscellaneous helper chips
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
CONFIG_AGP=y
CONFIG_AGP_ALI=y
CONFIG_AGP_ATI=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
CONFIG_AGP_SWORKS=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=y
# CONFIG_FB_CYBER2000_DDC is not set
# CONFIG_FB_ARC is not set
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_NVIDIA_DEBUG is not set
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_RIVA_DEBUG=y
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=y
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_3DFX_I2C=y
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_KTZ8866 is not set
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_CARILLO_RANCH=y
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_RT4831=y
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_BACKLIGHT_RAVE_SP is not set
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
# CONFIG_HID_GFRM is not set
CONFIG_HID_GLORIOUS=y
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=y
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SEMITEK=y
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
# CONFIG_STEAM_FF is not set
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
# CONFIG_HID_TOPRE is not set
# CONFIG_HID_THINGM is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# HID-BPF support
#
# end of HID-BPF support

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set
# end of USB HID support

CONFIG_I2C_HID=y
# CONFIG_I2C_HID_ACPI is not set
CONFIG_I2C_HID_OF=y
# CONFIG_I2C_HID_OF_ELAN is not set
CONFIG_I2C_HID_OF_GOODIX=y
CONFIG_I2C_HID_CORE=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_FEW_INIT_RETRIES=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_PRODUCTLIST=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_PCI is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=y
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
CONFIG_USB_STORAGE_KARMA=y
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
CONFIG_USB_STORAGE_ENE_UB6250=y
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
CONFIG_USB_CDNS_SUPPORT=y
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_CDNSP_PCI is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
# CONFIG_USB_DWC3_HOST is not set
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_DWC3_DUAL_ROLE=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
# CONFIG_USB_DWC3_HAPS is not set
CONFIG_USB_DWC3_OF_SIMPLE=y
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=y
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_UDC=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_CHIPIDEA_MSM=y
CONFIG_USB_CHIPIDEA_IMX=y
CONFIG_USB_CHIPIDEA_GENERIC=y
CONFIG_USB_CHIPIDEA_TEGRA=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
CONFIG_USB_ISP1760_GADGET_ROLE=y
# CONFIG_USB_ISP1760_DUAL_ROLE is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_SIMPLE=y
CONFIG_USB_SERIAL_AIRCABLE=y
# CONFIG_USB_SERIAL_ARK3116 is not set
CONFIG_USB_SERIAL_BELKIN=y
CONFIG_USB_SERIAL_CH341=y
# CONFIG_USB_SERIAL_WHITEHEAT is not set
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
CONFIG_USB_SERIAL_CP210X=y
CONFIG_USB_SERIAL_CYPRESS_M8=y
CONFIG_USB_SERIAL_EMPEG=y
CONFIG_USB_SERIAL_FTDI_SIO=y
CONFIG_USB_SERIAL_VISOR=y
CONFIG_USB_SERIAL_IPAQ=y
# CONFIG_USB_SERIAL_IR is not set
CONFIG_USB_SERIAL_EDGEPORT=y
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
CONFIG_USB_SERIAL_IPW=y
CONFIG_USB_SERIAL_IUU=y
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=y
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=y
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=y
CONFIG_USB_SERIAL_MOS7840=y
CONFIG_USB_SERIAL_MXUPORT=y
CONFIG_USB_SERIAL_NAVMAN=y
CONFIG_USB_SERIAL_PL2303=y
CONFIG_USB_SERIAL_OTI6858=y
CONFIG_USB_SERIAL_QCAUX=y
# CONFIG_USB_SERIAL_QUALCOMM is not set
CONFIG_USB_SERIAL_SPCP8X5=y
# CONFIG_USB_SERIAL_SAFE is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=y
CONFIG_USB_SERIAL_SYMBOL=y
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
CONFIG_USB_SERIAL_WWAN=y
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
CONFIG_USB_SERIAL_OPTICON=y
CONFIG_USB_SERIAL_XSENS_MT=y
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=y
CONFIG_USB_SERIAL_QT2=y
CONFIG_USB_SERIAL_UPD78F0730=y
CONFIG_USB_SERIAL_XR=y
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=y
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=y
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_APPLEDISPLAY=y
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=y
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=y
# CONFIG_USB_ONBOARD_HUB is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_TAHVO_USB=y
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_U_SERIAL_CONSOLE=y

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=y
CONFIG_USB_GR_UDC=y
CONFIG_USB_R8A66597=y
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
# CONFIG_USB_M66592 is not set
CONFIG_USB_BDC_UDC=y
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=y
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_NET2280 is not set
CONFIG_USB_GOKU=y
CONFIG_USB_EG20T=y
CONFIG_USB_GADGET_XILINX=y
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_ACM=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_MASS_STORAGE=y
CONFIG_USB_F_FS=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_F_TCM=y
# CONFIG_USB_CONFIGFS is not set

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=y
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=y
CONFIG_USB_FUNCTIONFS=y
# CONFIG_USB_FUNCTIONFS_ETH is not set
# CONFIG_USB_FUNCTIONFS_RNDIS is not set
CONFIG_USB_FUNCTIONFS_GENERIC=y
# CONFIG_USB_MASS_STORAGE is not set
CONFIG_USB_GADGET_TARGET=y
CONFIG_USB_G_SERIAL=y
CONFIG_USB_G_PRINTER=y
# CONFIG_USB_CDC_COMPOSITE is not set
CONFIG_USB_G_ACM_MS=y
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
CONFIG_USB_G_DBGP=y
# CONFIG_USB_G_DBGP_PRINTK is not set
CONFIG_USB_G_DBGP_SERIAL=y
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
# CONFIG_TYPEC_TCPCI is not set
CONFIG_TYPEC_FUSB302=y
CONFIG_TYPEC_UCSI=y
CONFIG_UCSI_CCG=y
# CONFIG_UCSI_ACPI is not set
# CONFIG_UCSI_STM32G0 is not set
CONFIG_TYPEC_TPS6598X=y
# CONFIG_TYPEC_ANX7411 is not set
# CONFIG_TYPEC_RT1719 is not set
CONFIG_TYPEC_HD3SS3220=y
CONFIG_TYPEC_STUSB160X=y
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# CONFIG_TYPEC_MUX_INTEL_PMC is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=y
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
CONFIG_MMC_SDHCI_OF_AT91=y
CONFIG_MMC_SDHCI_OF_DWCMSHC=y
CONFIG_MMC_SDHCI_CADENCE=y
CONFIG_MMC_SDHCI_F_SDH30=y
# CONFIG_MMC_SDHCI_MILBEAUT is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_ALCOR=y
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_CB710=y
CONFIG_MMC_VIA_SDMMC=y
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
CONFIG_MMC_USDHI6ROL0=y
# CONFIG_MMC_REALTEK_PCI is not set
# CONFIG_MMC_REALTEK_USB is not set
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=y
CONFIG_MMC_TOSHIBA_PCI=y
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=y
CONFIG_MMC_SDHCI_OMAP=y
CONFIG_MMC_SDHCI_AM654=y
# CONFIG_MMC_LITEX is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AW2013 is not set
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2606MVV is not set
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX77650 is not set
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_AS3722=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_MAX77686=y
# CONFIG_RTC_DRV_NCT3018Y is not set
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BD70528=y
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_TPS6586X=y
CONFIG_RTC_DRV_TPS65910=y
CONFIG_RTC_DRV_RC5T583=y
# CONFIG_RTC_DRV_RC5T619 is not set
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV3032=y
CONFIG_RTC_DRV_RV8803=y
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9055=y
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
# CONFIG_RTC_DRV_M48T59 is not set
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_WM8350=y
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_ZYNQMP=y
CONFIG_RTC_DRV_NTXEC=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=y
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_MC13XXX=y
CONFIG_RTC_DRV_MT6397=y
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=y
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
CONFIG_UIO_SERCOS3=y
CONFIG_UIO_PCI_GENERIC=y
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=y
CONFIG_VFIO=y
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=y
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=y
CONFIG_VFIO_PCI_VGA=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
CONFIG_RTS5208=y

#
# IIO staging drivers
#

#
# Accelerometers
#
# end of Accelerometers

#
# Analog to digital converters
#
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Direct Digital Synthesis
#
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y
# end of Network Analyzer, Impedance Converters

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_FB_SM750=y
CONFIG_STAGING_MEDIA=y
CONFIG_VIDEO_IPU3_IMGU=y
# CONFIG_VIDEO_MAX96712 is not set
# CONFIG_STAGING_MEDIA_DEPRECATED is not set
CONFIG_STAGING_BOARD=y
# CONFIG_LTE_GDM724X is not set
# CONFIG_KS7010 is not set
CONFIG_XIL_AXIS_FIFO=y
CONFIG_FIELDBUS_DEV=y
CONFIG_HMS_ANYBUSS_BUS=y
CONFIG_ARCX_ANYBUS_CONTROLLER=y
CONFIG_HMS_PROFINET=y
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_EC=y
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_X86_PLATFORM_DRIVERS_HP=y
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_IBM_RTL=y
# CONFIG_SENSORS_HDAPS is not set
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_PM=y
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_PMT_CLASS=y
CONFIG_INTEL_PMT_TELEMETRY=y
# CONFIG_INTEL_PMT_CRASHLOG is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_VSEC=y
# CONFIG_MSI_EC is not set
# CONFIG_XO15_EBOOK is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_MLX_PLATFORM=y
# CONFIG_TOUCHSCREEN_DMI is not set
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_INTEL_SCU_IPC_UTIL is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_COMMON_CLK_LOCHNAGAR=y
# CONFIG_COMMON_CLK_RS9_PCIE is not set
# CONFIG_COMMON_CLK_SI521XX is not set
CONFIG_COMMON_CLK_VC5=y
# CONFIG_COMMON_CLK_VC7 is not set
CONFIG_COMMON_CLK_BD718XX=y
CONFIG_COMMON_CLK_FIXED_MMIO=y
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_FSA9480=y
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_MAX77843=y
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_TUSB320=y
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL367_I2C is not set
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=y
CONFIG_DA311=y
# CONFIG_DMARD06 is not set
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=y
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
# CONFIG_IIO_KX022A_I2C is not set
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
# CONFIG_MSA311 is not set
CONFIG_MXC4005=y
# CONFIG_MXC6255 is not set
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=y
# CONFIG_AD7291 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD799X is not set
CONFIG_ADI_AXI_ADC=y
CONFIG_AXP20X_ADC=y
CONFIG_AXP288_ADC=y
CONFIG_CC10001_ADC=y
CONFIG_DA9150_GPADC=y
# CONFIG_DLN2_ADC is not set
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_HX711 is not set
CONFIG_INA2XX_ADC=y
CONFIG_LTC2471=y
CONFIG_LTC2485=y
# CONFIG_LTC2497 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=y
CONFIG_MEDIATEK_MT6360_ADC=y
# CONFIG_NAU7802 is not set
# CONFIG_RN5T618_ADC is not set
# CONFIG_RICHTEK_RTQ6056 is not set
CONFIG_SD_ADC_MODULATOR=y
CONFIG_TI_ADC081C=y
CONFIG_TI_ADS1015=y
# CONFIG_TI_ADS7924 is not set
# CONFIG_TI_ADS1100 is not set
CONFIG_TI_AM335X_ADC=y
# CONFIG_VF610_ADC is not set
# CONFIG_VIPERBOARD_ADC is not set
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_ATLAS_EZO_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
CONFIG_PMS7003=y
CONFIG_SCD30_CORE=y
# CONFIG_SCD30_I2C is not set
# CONFIG_SCD30_SERIAL is not set
# CONFIG_SCD4X is not set
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
CONFIG_SPS30_SERIAL=y
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
# CONFIG_AD5380 is not set
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
CONFIG_M62332=y
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
CONFIG_TI_DAC5571=y
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HDC2010=y
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
# CONFIG_BOSCH_BNO055_SERIAL is not set
# CONFIG_BOSCH_BNO055_I2C is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_KMX61 is not set
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
# CONFIG_ADUX1020 is not set
CONFIG_AL3010=y
CONFIG_AL3320A=y
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_AS73211 is not set
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=y
# CONFIG_IQS621_ALS is not set
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=y
# CONFIG_ROHM_BU27034 is not set
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=y
# CONFIG_LTR501 is not set
# CONFIG_LTRF216A is not set
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=y
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6030=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=y
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# CONFIG_TI_TMAG5273 is not set
CONFIG_YAMAHA_YAS530=y
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
CONFIG_AD5272=y
CONFIG_DS1803=y
# CONFIG_MAX5432 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_DLHL60D=y
# CONFIG_DPS310 is not set
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
# CONFIG_T5403 is not set
CONFIG_HP206C=y
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
CONFIG_LIDAR_LITE_V2=y
CONFIG_MB1232=y
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
CONFIG_SRF04=y
# CONFIG_SX9310 is not set
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
CONFIG_SX9500=y
# CONFIG_SRF08 is not set
CONFIG_VCNL3020=y
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
CONFIG_MLX90614=y
CONFIG_MLX90632=y
# CONFIG_TMP006 is not set
CONFIG_TMP007=y
CONFIG_TMP117=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# CONFIG_MAX30208 is not set
# end of Temperature sensors

CONFIG_NTB=y
CONFIG_NTB_MSI=y
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_EPF is not set
CONFIG_NTB_SWITCHTEC=y
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=y
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_MSI_TEST is not set
CONFIG_NTB_TRANSPORT=y
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=y
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_DPHY_RX is not set
CONFIG_PHY_CADENCE_SIERRA=y
# CONFIG_PHY_CADENCE_SALVO is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_HSIC=y
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_TUSB1210=y
CONFIG_PHY_INTEL_LGM_COMBO=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
CONFIG_IDLE_INJECT=y
CONFIG_DTPM=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RAVE_SP_EEPROM is not set
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
CONFIG_FPGA_MGR_ALTERA_CVP=y
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
# CONFIG_FSI is not set
CONFIG_TEE=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
# CONFIG_INTEL_QEP is not set
# CONFIG_INTERRUPT_CNT is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
CONFIG_XFS_SUPPORT_ASCII_CI=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
# CONFIG_F2FS_FS_XATTR is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_CACHEFILES is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
CONFIG_GCC_PLUGIN_STACKLEAK=y
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
CONFIG_STACKLEAK_RUNTIME_DISABLE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_TWOFISH is not set
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_VMAC is not set
CONFIG_CRYPTO_WP512=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_SERPENT_SSE2_586=y
# CONFIG_CRYPTO_TWOFISH_586 is not set
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
# CONFIG_PKCS7_MESSAGE_PARSER is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
CONFIG_UBSAN_UNREACHABLE=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_DEBUG_ON=y
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_KMAP_LOCAL is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_RCU_STRICT_GRACE_PERIOD is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_USER_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--2KkCpu/jcF/0UwXN
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='vm-snb-i386'
	export tbox_group='vm-snb-i386'
	export branch='linux-review/Roy-Luo/usb-core-add-sysfs-entry-for-usb-device-state/20230602-075645'
	export commit='130794a2eeb26bc2fa5774dee181661612d0fabf'
	export kconfig='i386-randconfig-i053-20230531'
	export repeat_to=6
	export nr_vm=300
	export submit_id='647acf6b6af69486ebf80826'
	export job_file='/lkp/jobs/scheduled/vm-meta-40/boot-1-debian-11.1-i386-20220923.cgz-130794a2eeb26bc2fa5774dee181661612d0fabf-20230603-34539-1616p6b-4.yaml'
	export id='88eae357c2d4f5fdd8fe450273a2211a80b2e715'
	export queuer_version='/zday/lkp'
	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='4G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23400
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-i386-20220923.cgz'
	export compiler='gcc-12'
	export enqueue_time='2023-06-03 13:28:11 +0800'
	export _id='647acf826af69486ebf80827'
	export _rt='/result/boot/1/vm-snb-i386/debian-11.1-i386-20220923.cgz/i386-randconfig-i053-20230531/gcc-12/130794a2eeb26bc2fa5774dee181661612d0fabf'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb-i386/debian-11.1-i386-20220923.cgz/i386-randconfig-i053-20230531/gcc-12/130794a2eeb26bc2fa5774dee181661612d0fabf/3'
	export scheduler_version='/lkp/lkp/.src-20230602-160545'
	export arch='i386'
	export max_uptime=600
	export initrd='/osimage/debian/debian-11.1-i386-20220923.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb-i386/debian-11.1-i386-20220923.cgz/i386-randconfig-i053-20230531/gcc-12/130794a2eeb26bc2fa5774dee181661612d0fabf/3
BOOT_IMAGE=/pkg/linux/i386-randconfig-i053-20230531/gcc-12/130794a2eeb26bc2fa5774dee181661612d0fabf/vmlinuz-6.4.0-rc3-00033-g130794a2eeb2
branch=linux-review/Roy-Luo/usb-core-add-sysfs-entry-for-usb-device-state/20230602-075645
job=/lkp/jobs/scheduled/vm-meta-40/boot-1-debian-11.1-i386-20220923.cgz-130794a2eeb26bc2fa5774dee181661612d0fabf-20230603-34539-1616p6b-4.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-i053-20230531
commit=130794a2eeb26bc2fa5774dee181661612d0fabf
initcall_debug
mem=4G
nmi_watchdog=0
vmalloc=256M initramfs_async=0 page_owner=on
max_uptime=600
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/i386-randconfig-i053-20230531/gcc-12/130794a2eeb26bc2fa5774dee181661612d0fabf/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-i386-20220923.cgz/run-ipconfig_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/lkp_20220923.cgz,/osimage/deps/debian-11.1-i386-20220923.cgz/rsync-rootfs_20220923.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export stop_repeat_if_found='dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/rwsem.c'
	export kbuild_queue_analysis=1
	export meta_host='vm-meta-40'
	export kernel='/pkg/linux/i386-randconfig-i053-20230531/gcc-12/130794a2eeb26bc2fa5774dee181661612d0fabf/vmlinuz-6.4.0-rc3-00033-g130794a2eeb2'
	export dequeue_time='2023-06-03 13:28:40 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-40/boot-1-debian-11.1-i386-20220923.cgz-130794a2eeb26bc2fa5774dee181661612d0fabf-20230603-34539-1616p6b-4.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--2KkCpu/jcF/0UwXN
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--2KkCpu/jcF/0UwXN--
