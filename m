Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8D65B9C14
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIONij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIONig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:38:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C52C5A142
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663249115; x=1694785115;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+dwTdqNSZa9qGlY0Iuud1G79/WQal104xFikQaiJlII=;
  b=bIAR063T13RD7HU1hKFYp0oeIzkBFsZUuQGxkbGSbLXQuzr7qiWbYPDk
   JEQQVAbRaFE+4XQQ5PYFkeaKGE0XIJxQdVrj/TVDIIcVFjS9lqo2CzbdC
   XRqKnOh9e2Zu5pIikTfVgF4xxGxvdcXw87a9seTBCL+pVBmeHkI47H1zj
   9x58xHHVkCox1d3ulOaj0fEHA8k7//Wd7ChwMycj/SZcBYBUd1kMrRerv
   2ZH9jdfo1/E/zI/c19VTCfGD3N0yHhNnACdNQhWzlqGDVNTMs0nKBFPd8
   mmKage7gNtEs8xrgYSFjLNu1vNJrX9ClNuWIqHM8V4WTtgPse2wGWODqs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278442079"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="278442079"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 06:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="706354254"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Sep 2022 06:38:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 06:38:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 15 Sep 2022 06:38:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 15 Sep 2022 06:38:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPUHDneYqudZA4+8ElnaY+tfTaXRyjDvhTxwIFO5Rci2I+De+Ro4MB1EVsDGG6eKVL094MjxdhYux/a2iK8jP95q1HMTTyfcEClbWuoEiUyJPucX2A59CCWNGIzMK6v7ps69flk3olG1nEIQvlDR/lAIncJSoRLvJCzeRQrTjOkZgTt08G3j8D6PYWk0IxTE24O8WtzKVnnpfWh05vhKCVbHVdAWPNJgs6914VzmdsNbiX605Ku0Pdjc1+13nkRc4jUeWLiu7L8BHjvSDhKxT15nV4b9IYP2JGocfTKJwsfFta+Kpockry5lczjxyM/Z8zyGcfSNNYWNW34rojzwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRLpNiphiEvfVc3RVzUTU5mFVYF7Qaga49WPG9aOko4=;
 b=h/+6UWhpTkGSrKNxEg5TDP6K/xJIMi/3/D1tAI83U8Usluui9327fakzJxvoJC6Fjpl3UjFfZuELJ5sgvUxpX4cmmH5SDkZA27R9dvIsuruex2MRNrejXVqW3CYklEplQkthG/hf+v4mt/ugNuBJsnveNDqTtua6MHs88NgYDC15fnAwfVhwUOce/I8hXHqG9m4LgGH8wZU1uqq0yu7UzcV4Lmoa+rcKFQVFf+zpzhaIMVImlfUvcQeuRduUwBmjeIlj68vndUIhX3hMf4LX0BhkJwLFJZeMGm0bSMWnsSb8/U31qEC3WLqvL0DCpHE7TfpfdPSDsIhDLnDN4CiFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB7279.namprd11.prod.outlook.com (2603:10b6:8:109::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Thu, 15 Sep
 2022 13:38:32 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::9db5:95f1:a79:960d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::9db5:95f1:a79:960d%7]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 13:38:32 +0000
Date:   Thu, 15 Sep 2022 21:38:04 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/vmscan: don't scan adjust too much if current is not
 kswapd
Message-ID: <YyMqvKOMxnN36Xku@feng-clx>
References: <20220914023318.549118-1-zhanghongchen@loongson.cn>
 <20220914155142.bf388515a39fb45bae987231@linux-foundation.org>
 <6bcb4883-03d0-88eb-4c42-84fff0a9a141@loongson.cn>
 <YyLUGnqtZXn4MjJF@casper.infradead.org>
 <54813a74-cc0e-e470-c632-78437a0d0ad4@loongson.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54813a74-cc0e-e470-c632-78437a0d0ad4@loongson.cn>
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: f7267c2d-4e2e-45eb-24c8-08da971f94aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ur6Q1CIot8k0ZMpnHNwrk94ZSLx5nX3DEz9R6DecW+jVfW30wIi4xgk56sQ+Y0ToxZG1HElwM/JE7GabJhqigpg8FLfAxCtrqlOlK7n7XF3puUtUvmbSUymn3k0JP0TjS6pijYzKqN4RBLi44hNPhuLm7aj2T7KQ8NKKz1ae9n8RFnEDXbt2oxnE8opiSZYcJw+95G4ZYrgPL2mcRJ464yb+SuJppjHu25S21YULd/aKnx8uGa4/AyYRrWWhH3vUDButm/VErpjUdDhxLDVRGrwBVRGp4HoeWzhWlMNUghIeOldeV+YCtO18oDaNjpiSpsmG6oVjp14SoU5JIzpPc0wiQRrKljOI8YO5Hwr3RnMt/d/Kw3Jq9p0J+WtreSxVMnxug+/R8ZFwQeTmdFhnqmLncou5cxlWXBfkvbm9FL+ejUsbE4aPTleXmwTrnHcFKi3bKrOnPwJXiZQZe9oCD/XWciYpMqHjn2uQpdZSiX7rtRKA/s6xjqCo9KybQ/GQGErAb4fca+qzzJNkChMXfmeKiBXTI637OKtqADIfJYuBPUmnU837J/4RKDR5tL8tHJUvm/EZXoOh5MkxnFJ1RG11PybOu/v73JlmLbC5hA4B+TI8RGBzlZpW12wtB/RJvA8myk3YMwrX1mN1LwQVxvlUwtpXBaX4KO69cZcN1yyOR1fcDUvgi8/1l2jtQGxzYTpkFda536qf/9Q5lAs1HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(186003)(83380400001)(86362001)(38100700002)(82960400001)(2906002)(44832011)(5660300002)(8936002)(33716001)(478600001)(66476007)(41300700001)(6486002)(6666004)(6512007)(26005)(9686003)(6506007)(66556008)(66946007)(4326008)(8676002)(316002)(54906003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YeV9ZP7RTOruer0wdFbO8jPN1H4fg4TFXHH+f3zAgtVWPhmmqBZrvqkPwgUK?=
 =?us-ascii?Q?7nPt2F+shhOQBApK4eHt7XT1TWwVPPfWe/aJt8bMLi2Avprfdip/EzNbTntq?=
 =?us-ascii?Q?9bWp1eJNOw7eOclOE5PTVTazTeAdUXymwCw9h0IHsRskK4Fi8+xOvkWQAKoR?=
 =?us-ascii?Q?nRmkusS+oiAiTyJf8ACdPpinHaHft2h28K2ujeGWUsAVrpTtnSeI/dPhJYEW?=
 =?us-ascii?Q?yjNzkJQelFvZNrtXAO8Hofwmg3aM79EEJNaQFK78BRi2kZ2VrHl9Wl9tKA2g?=
 =?us-ascii?Q?fh0x9lyLp/I7ERXEG2NKL+pXC9/m/XtjOyhE0LcacAT14//toSqYZarZXuF1?=
 =?us-ascii?Q?CWkDwugS9O7DormsQ0KHfWmLVxQrrkzwur5IMzntkclxrFsuJ6dN9YXnIgQp?=
 =?us-ascii?Q?0Gs7CbwvF8JqcEPX6dyK8ptFcOTlDswbMRV7emveAiUYoAHbISAAz5pVnRXI?=
 =?us-ascii?Q?GaXMUA5DRJeSxXbGHVV2hA7ZoAVMIW0WyrjkGzi3e5qy/jAfkhsBAleXCy8J?=
 =?us-ascii?Q?+6joJrDrZXhj8IE0KUBlJJlMG2jGHJXwFQAyjbPAy3qzihxOj5ITgbRAYiEM?=
 =?us-ascii?Q?HQDMoSuY/eWrnqJu2mUcu13Ssx0E15j3O8yh21TIU1kZ19vYYT0agVHfcsSz?=
 =?us-ascii?Q?W/pqTD04GwJah6Ukd4A+VcMZdflvJlHh5JS5/FEeMsZYGxLplAgAZjpl8LZZ?=
 =?us-ascii?Q?yywV+alnTojUHr5V8A/nUrvP64h4TgeigTkLFmBu1/vBInLdpu6lBL7jdGXH?=
 =?us-ascii?Q?mEd+g/arnDoDo7+revEYI/uPohzzOkRu0l6zfvnmg8zC+2kyHQJmTYAswj5D?=
 =?us-ascii?Q?7J9nJDyUWpmrBGEhgpMVN2gK+nvYCzYT7TRqG9JVD1yjCCgY+RrjsR3iJDEp?=
 =?us-ascii?Q?4jW7/tH6iVxM7M1Bb3gqxZNzDvFD8vHK6+Ahk7sns8X8ZC8eZZZnjZsarKWZ?=
 =?us-ascii?Q?J5EAbMCVr0mM6xVCWkT2piSKnVvUhWSHa93dzNzZXeXua7Yg7J8Zd6vG0QE+?=
 =?us-ascii?Q?QigGgRPSNwu2GtcOFy37uwth+dDZTqIlDF+M5Wd5tfcsUJx5A4edO2ETCPC+?=
 =?us-ascii?Q?0AbzXy6itSmf44TC9PQx6805bCgkZ+/66GWFsd5Ox3GuWEcFWxBa63BtDv+j?=
 =?us-ascii?Q?HqY8UubW46TFx1EuiLXNF9hibYtCUu0nVG+7kFf9tyLJUGulDcuYkH1lc+CH?=
 =?us-ascii?Q?L8G5PlpT+AdmsOLRv6cEmdP7nELoSdEbvrvM4Qw3kBCgBcPSNiNomonONoUh?=
 =?us-ascii?Q?23SMeQU5SR7KxuMsMTL/NcDgyQCSKWKXnCoMg5NCMuc9vklAEHXsQfgImUJL?=
 =?us-ascii?Q?5qup7U1ITRSVkHE0w+QZ2sD2SbaYH1pLRpFkDNroWmN0UxDOKG8uND2NCu4U?=
 =?us-ascii?Q?9cLzKxXgxaqPUkSA9QyijlAWBDKo+5Ykfy8S8N//5SQjvLAVD1to1wnIwZYw?=
 =?us-ascii?Q?jyXXJgAr/YWiUpvRvHdM4rTGuR2ZJoMFqhSyrI2YINjNUTPg2fvD7S1Wn3Jx?=
 =?us-ascii?Q?LRX65/HgtruAB5s+OdkwpdZJ0JG1QC/VkBNDuGU4dLWoOpsH+sjGB2x6YF9F?=
 =?us-ascii?Q?LGWUtHf8V/Rz3Ydtj3nmPasoff9LoWuaT8/mVsr/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7267c2d-4e2e-45eb-24c8-08da971f94aa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 13:38:32.1555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fbgwu7xLaC1G2bMfyk3h5fx5JQo2istPTQb3/lv0lk36b2tmgE9PVCQJG4KaXvNuFpfMJZbXLexweX6ruPZ9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7279
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongchen,

On Thu, Sep 15, 2022 at 04:02:41PM +0800, Hongchen Zhang wrote:
> Hi Matthew,
> On 2022/9/15 pm 3:28, Matthew Wilcox wrote:
> > On Thu, Sep 15, 2022 at 09:19:48AM +0800, Hongchen Zhang wrote:
> >> [ 3748.453561] INFO: task float_bessel:77920 blocked for more than 120
> >> seconds.
> >> [ 3748.460839]       Not tainted 5.15.0-46-generic #49-Ubuntu
> >> [ 3748.466490] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> >> this message.
> >> [ 3748.474618] task:float_bessel    state:D stack:    0 pid:77920 ppid:
> >> 77327 flags:0x00004002
> >> [ 3748.483358] Call Trace:
> >> [ 3748.485964]  <TASK>
> >> [ 3748.488150]  __schedule+0x23d/0x590
> >> [ 3748.491804]  schedule+0x4e/0xc0
> >> [ 3748.495038]  rwsem_down_read_slowpath+0x336/0x390
> >> [ 3748.499886]  ? copy_user_enhanced_fast_string+0xe/0x40
> >> [ 3748.505181]  down_read+0x43/0xa0
> >> [ 3748.508518]  do_user_addr_fault+0x41c/0x670
> >> [ 3748.512799]  exc_page_fault+0x77/0x170
> >> [ 3748.516673]  asm_exc_page_fault+0x26/0x30
> >> [ 3748.520824] RIP: 0010:copy_user_enhanced_fast_string+0xe/0x40
> >> [ 3748.526764] Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f
> >> 01 ca c3 cc cc cc cc 0f 1f 00 0f 01 cb 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3>
> >> a4 31 c0 0f 01 ca c3 cc cc cc cc 66 08
> >> [ 3748.546120] RSP: 0018:ffffaa9248fffb90 EFLAGS: 00050206
> >> [ 3748.551495] RAX: 00007f99faa1a010 RBX: ffffaa9248fffd88 RCX:
> >> 0000000000000010
> >> [ 3748.558828] RDX: 0000000000001000 RSI: ffff9db397ab8ff0 RDI:
> >> 00007f99faa1a000
> >> [ 3748.566160] RBP: ffffaa9248fffbf0 R08: ffffcc2fc2965d80 R09:
> >> 0000000000000014
> >> [ 3748.573492] R10: 0000000000000000 R11: 0000000000000014 R12:
> >> 0000000000001000
> >> [ 3748.580858] R13: 0000000000001000 R14: 0000000000000000 R15:
> >> ffffaa9248fffd98
> >> [ 3748.588196]  ? copy_page_to_iter+0x10e/0x400
> >> [ 3748.592614]  filemap_read+0x174/0x3e0
> > 
> > Interesting; it wasn't the process itself which triggered the page
> > fault; the process called read() and the kernel took the page fault to
> > satisfy the read() call.
> > 
> >> [ 3748.596354]  ? ima_file_check+0x6a/0xa0
> >> [ 3748.600301]  generic_file_read_iter+0xe5/0x150
> >> [ 3748.604884]  ext4_file_read_iter+0x5b/0x190
> >> [ 3748.609164]  ? aa_file_perm+0x102/0x250
> >> [ 3748.613125]  new_sync_read+0x10d/0x1a0
> >> [ 3748.617009]  vfs_read+0x103/0x1a0
> >> [ 3748.620423]  ksys_read+0x67/0xf0
> >> [ 3748.623743]  __x64_sys_read+0x19/0x20
> >> [ 3748.627511]  do_syscall_64+0x59/0xc0
> >> [ 3748.631203]  ? syscall_exit_to_user_mode+0x27/0x50
> >> [ 3748.636144]  ? do_syscall_64+0x69/0xc0
> >> [ 3748.639992]  ? exit_to_user_mode_prepare+0x96/0xb0
> >> [ 3748.644931]  ? irqentry_exit_to_user_mode+0x9/0x20
> >> [ 3748.649872]  ? irqentry_exit+0x1d/0x30
> >> [ 3748.653737]  ? exc_page_fault+0x89/0x170
> >> [ 3748.657795]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> >> [ 3748.663030] RIP: 0033:0x7f9a852989cc
> >> [ 3748.666713] RSP: 002b:00007f9a8497dc90 EFLAGS: 00000246 ORIG_RAX:
> >> 0000000000000000
> >> [ 3748.674487] RAX: ffffffffffffffda RBX: 00007f9a8497f5c0 RCX:
> >> 00007f9a852989cc
> >> [ 3748.681817] RDX: 0000000000027100 RSI: 00007f99faa18010 RDI:
> >> 0000000000000061
> >> [ 3748.689150] RBP: 00007f9a8497dd60 R08: 0000000000000000 R09:
> >> 00007f99faa18010
> >> [ 3748.696493] R10: 0000000000000000 R11: 0000000000000246 R12:
> >> 00007f99faa18010
> >> [ 3748.703841] R13: 00005605e11c406f R14: 0000000000000001 R15:
> >> 0000000000027100
> > 
> > ORIG_RAX is 0, which matches sys_read.
> > RDI is file descriptor 0x61
> > RSI is plausibly a userspace pointer, 0x7f99faa18010
> > RDX is the length, 0x27100 or 160kB.
> > 
> > That all seems reasonable.
> > 
> > What I really want to know is who is _holding_ the lock.  We stash
> > a pointer to the task_struct in 'owner', so we could clearly find this
> > out in the 'blocked for too long' report, and print their stack trace.
> > 
> As described in the comment for __rwsem_set_reader_owned,it is hard to 
> track read owners.So we could not clearly find out who blocked the 
> process,it was caused by multiple tasks.

In your previous mail, you mentioned panic happened. Maybe you can try
appending "panic_print=0x1" to kernel command line , as it could print
the call stacks of all tasks on panic(the info could be huge).

Initially, we added it also to debug some deadlock (hunging task) bug. 

Thanks,
Feng
