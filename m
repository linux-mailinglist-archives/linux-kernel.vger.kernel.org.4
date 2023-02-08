Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE168F051
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBHOFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjBHOFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:05:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D29457C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675865102; x=1707401102;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RyUYVGXehQjI71I7LuIhrzPKlC6EX4asxmxULxsyrCk=;
  b=BXNokKgYQB43b7F0NVwTW7BtEV/ntURdhWl4Inqd6FWlg0L+UDpBQQ1k
   E0+u8t4ImEItf40BKZL6ER/0uPbZAksEv6UXux7ipyNHLW8hUsMswQ1hJ
   sgK5vQoja+6ikaRdqdEMprzobYCvQeDOf8njOhg5OqLnT44KsPsGuyF+7
   4bTMzhshMwg61rsXYNO8aQygU6hfyqdRf+ClMYa/+Kbzst7BKCXYrj2JE
   tJMZjjSAA3+EcEP60EhAkb7KXxuzH3kAL2OINsIfp+aucXNZ/iC3U6DLV
   LOGCDiX6CDzrUodJspJBtAjWd0HSk1gATnqMVrGvTtVXvXkpnKVCIw6mw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="317803838"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="317803838"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 06:03:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="841192086"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="841192086"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2023 06:03:17 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 06:03:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 06:03:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 06:03:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS5Lz9FyY1spEXVO/zuLN6rsdPkjWD/U/ABwKfJBTgx9p2Hmha9+5yjSB1k/grb6BYnVZqF9knzNn9Rl52NO6rRhBHMg4gag9RyQQDVg89JBAV7uZSoMyKG7AVQG5pV4Rl45U4GTbmnlODsSBXYDbp5hGuIEEENKGVgxrgvnzPsexho+/yu1uRgzU3hczdQmZC120Mz38bL9QALYGNqayTs+mHsNNwUcK+ZNotpt+jCZGPJa8GyvQwcBBqDLasxjuU6U+JpsQoldIeS038stkvjExz1CBZR9nQc3kf6xqVySwZd/xrCwnGumrCw6zaq2oHkMcphTHi0kUIHbXF5cVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9AfZawxHnEUZvLwHAwHQOM0t7f2XdMSuEC+fKKMD7c=;
 b=QhScnOUab9zSI4orTM7Og9/vqPMjlSKKbSwe5cFlfSjidYXYAN5n4nIXO0G9cmu0yWKHIPByKN1chhaKXYO+yNSRXl6RHSI4i6bODhJv04P+KckeWPOmDuGZQXzMbyLkdAZkpqgrtS5VgEuaAN4XVaLv2itmgmxfhKk915c6F1mO660pzoM3btbUimS5F3ZTTv5wZtG7zquHg2mmi5RVCbp5Bj+eFBEnUYAh2lL7qFxOYp7CdVTVDDun+ZI9unrUswkvuT3IRcEV8Q61c5l8liSRJn0ZyAhbAIIF7Xk/XisNHTIxfHQLSM4Cvx3H8mEi/+SUECRiFufjl0MjvysvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CH0PR11MB5250.namprd11.prod.outlook.com (2603:10b6:610:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 14:03:14 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80%4]) with mapi id 15.20.6064.029; Wed, 8 Feb 2023
 14:03:14 +0000
Date:   Wed, 8 Feb 2023 22:04:18 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is " __disarm_kprobe_ftrace" WARNING
 in v6.2-rc7 kernel
Message-ID: <Y+Or4mQ+DljPtAef@xpf.sh.intel.com>
References: <Y+NleHouvZwDBiKY@xpf.sh.intel.com>
 <Y+Nrmal67Fbg2fUM@kroah.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+Nrmal67Fbg2fUM@kroah.com>
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CH0PR11MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b10b4f5-8018-4bcd-8670-08db09dd3829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87nGpb3Zme9gDVDgxTNDdHxDEbV5fbGncK1MQZKQxo0C0LahvF2AgQV/EtODnN6uuVS6Z/CtMaHYynrmOAXFKLFstG8Ak8+KAaTI+ZoOjxJnnQGNSPr4LDpeRe1TNKlEbOYYM9BsJv7ExVI6hctGuXGMpKC3vkxFIvCH1o/ZsjKkZ0e24IHwww8sqLbo7ljGnyWwlIMsliNWA4aqK1MZUYAkYjvtrHJjLXjeitJAQSrugO085qZwV+db0GV7t/YJF+NReT4s5ncR1kYNMZV0kGI2yE9r4sCu/ZkBqPkMlsizrXajJhYeFvwuO8urH63EVrqMrHkCiEBQeZaqomSDvfkGmIJkacG+VofrRem8jFmsrvxT9rD4AX1DzMj42kaVhwedoWOBrIimwjq4iyzpZjgpvCM6FtYjGi+1xvIpZZwBfKCJ1GS7MZ1/kENfEBhEcmSpoURSs3VyoODwiE2vFVoRMWKV+YtxlwPCI0Fgec7Wdl6uZmyxuMOp4tqHSbxBn0nORVpdgQ7/wzPAtYL4C7/6jDTA6pEzf9YjQByYKcD9EnruX37eOgZhDPRCT+gCijb71ZSL74SxvN5+RlsoisZkrZqX1kEsCBfBN+WyIbYByj1zZGhc+XmudVsfrF7I0RMc682nYs2SrSRypp76Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199018)(83380400001)(5660300002)(2906002)(44832011)(186003)(26005)(6506007)(53546011)(6512007)(8936002)(66556008)(41300700001)(107886003)(478600001)(45080400002)(316002)(6486002)(86362001)(82960400001)(38100700002)(4326008)(66946007)(6916009)(66476007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qs3nqDm53UqEYa6MkW/7Dy6DVwijl/xcqYyex6T0ff6XBQwzRiuP7H7zFvNp?=
 =?us-ascii?Q?og/9Cl5DH4/2jkcporqvHplbUOQT+2ZxhRHbX/tlsqxUPB8bd0Uh6+E5KFso?=
 =?us-ascii?Q?gUFPGiqCsexrV64wBIePKY3219w1CnpG+RDyT/qF4geUiYyx0byrHblhX4BP?=
 =?us-ascii?Q?tKdtygNj6kti5XTLoJ3+CnerXm9R4RLiX9yU2u4PivVvcZuAOxfYpnLwWf8e?=
 =?us-ascii?Q?DsoRr0dJE80Nqdhqunl91xuifcQva6pQNDt3FvxNlO53yrYDQh/2hiWfzbRi?=
 =?us-ascii?Q?VUmtOsOx2E1VAl7L7qJCEASJI2ULo/sJ7+9bEipe0OxouwBQfqPKJXgUeHGo?=
 =?us-ascii?Q?LJE/j0G35cSOJzDyESoC9EELflWXPCt6ndfQqWUl+msSwLjWXjHyngmTBaZD?=
 =?us-ascii?Q?C/W3Q785fw8hRWZjcwQpeqgM7kUjEmNqvGeXD9ChuRZbnTdGA+hoK6pUxvQv?=
 =?us-ascii?Q?mGH+yLgUog7vqUicXlkaGSSzv6ki2t8TY7ogI47W18gwrA9dIcAFGcdGwBUS?=
 =?us-ascii?Q?GvJPDqYz5b7pHboyv48JUPw4xuWXSaIYkBWrGvhQCFXzrzO67TPYWFQn83gG?=
 =?us-ascii?Q?cGKGs8BgZAOmQ9HJ0sO7wU4YRD0aOSYzyGPV2FPqpcgcXyhYPmx/pxy3uxvS?=
 =?us-ascii?Q?RsJT7CkbmZQIsXn0+FbQfoaIfmy1dTmLq8B0g+P4kPZ6K76n3iUdY49CNZT1?=
 =?us-ascii?Q?stz4/LxvthdkKg7wB7bNBkCBkHEkmCC4sgeisBvsr72faNZpbKElbaO7ZyuT?=
 =?us-ascii?Q?r0oMXFKpMJdMSBP5OkKuRHxiuuhAn2J/XSoCtAvOXZqAamvQr9usQxBoZsfn?=
 =?us-ascii?Q?SMfPHjurS/xAPyxg7gNC+HwpB9fK51BIOx2G2o3XNx26ZEDGvqBArLla4NkZ?=
 =?us-ascii?Q?3nxR/wQEdRjCAvjXSzcR7j0UPZkeclKb+60G9qcXgr+YOB+lXvYVPhYpPpCk?=
 =?us-ascii?Q?Oq6A4EXmofjXtvVUiU5pawbWu4/kcE4Fp5++WxcShoNDmY1bzsvSCKI7Hi01?=
 =?us-ascii?Q?AXq2KEciPauKTCVtdB3J3ucsGhbfq5ieQ86iPJ/3nXhQOqTeM/AW+ox0QDiC?=
 =?us-ascii?Q?F0+VxMtGPZa9ZcC7TulBpZtqvGOv3OUOPnEgLeWp2CVndHjThnAFdBJ6GrD6?=
 =?us-ascii?Q?TcvFSC0umgFEcIf8AjPcjkC5x/4WsxywdRynkbT/G3QWOW9NYv3eOn7EQzq4?=
 =?us-ascii?Q?JRqxnOJVH/w/tzno+Hf4jqRb6ulNIhnB+mBrdZ2L6OVTeWpN/V6Dzzwt7BCA?=
 =?us-ascii?Q?9mbmzIIGSG6rctFR4UNIT+QSKYnyyGdhAOlYea+K4Nu8GZTmgk1C4IgV6n5a?=
 =?us-ascii?Q?yPrfsuZXhAeiYMtuAUVUhhvB0J64KcI0RhtOqS8B9DFBzblY/BRJwt6rEi8q?=
 =?us-ascii?Q?GDaF+ijgGzXLZviXP9OXynbVDpTWQta3TF/Nixn8luN/TrUlYQJH5zWGqIF5?=
 =?us-ascii?Q?64PNK89egb47sXQFLEbmRqfSaoCAIJRTVM7PPAD39YZ8fKqhlLIF0JiNAT2A?=
 =?us-ascii?Q?ZCXhD5td11VEkao6rlmhMbROt2mdqyi3IZu138ntP6tQrVVS0ti83gobSQ2E?=
 =?us-ascii?Q?1FbAvhZRQv4DSndBW3tNiZX1mxWrZrMqyH5VY8+dBzoCvtloIMKdIGwRF+PS?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b10b4f5-8018-4bcd-8670-08db09dd3829
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 14:03:14.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANudEK7RidlrsN24NgjDArdSZzTOl7fB28hhcq/i9fzDcOPmm7UzZVQxC3BGHiJ+eMjgZhFURK7UsY9sjXQ5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5250
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

Hi Greg KH,

On 2023-02-08 at 10:30:01 +0100, Greg KH wrote:
> On Wed, Feb 08, 2023 at 05:03:52PM +0800, Pengfei Xu wrote:
> > Hi Greg KH and kernel expert,
> > 
> > Greeting!
> > 
> > There is " __disarm_kprobe_ftrace" WARNING in v6.2-rc7 kernel in fault
> > injection test by syzkaller:
> > [   30.404796] FAULT_INJECTION: forcing a failure.
> 
> So you forced a fault and something crashed.  What were you expecting?

As before, I just tested regular(no fault injection) syzkaller testing, and
there was no problem.
And recently I enabled fault injection and found this WARNING, I should
check the fault injection related issue carefully next time, and confirm it's
really an issue and report.
> 
> > [   30.404796] name failslab, interval 1, probability 0, space 0, times 1
> > [   30.405595] CPU: 1 PID: 510 Comm: repro Not tainted 6.2.0-rc7-4ec5183ec486 #1
> > [   30.406044] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   30.406724] Call Trace:
> > [   30.406890]  <TASK>
> > [   30.407032]  dump_stack_lvl+0xa7/0xdb
> > [   30.407310]  dump_stack+0x19/0x1f
> > [   30.407532]  should_fail_ex.cold.5+0x5/0xa
> > [   30.407820]  __should_failslab+0xca/0x120
> > [   30.408091]  should_failslab+0x12/0x30
> > [   30.408341]  __kmem_cache_alloc_node+0x62/0x280
> > [   30.408636]  ? alloc_ftrace_hash+0x4f/0x170
> > [   30.408916]  kmalloc_trace+0x2e/0x120
> > [   30.409161]  alloc_ftrace_hash+0x4f/0x170
> > [   30.409426]  alloc_and_copy_ftrace_hash.constprop.87+0x23/0x310
> > [   30.409804]  ? write_comp_data+0x2f/0x90
> > [   30.410078]  ftrace_set_hash+0x445/0x590
> > [   30.410350]  ? __sanitizer_cov_trace_pc+0x25/0x60
> > [   30.410671]  ftrace_set_filter_ip+0xcd/0x1a0
> > [   30.410967]  ? __pfx_ftrace_set_filter_ip+0x10/0x10
> > [   30.411295]  ? match_dev_by_uuid+0x4/0x100
> > [   30.411574]  ? unregister_ftrace_function+0x83/0x3c0
> > [   30.411906]  ? __this_cpu_preempt_check+0x20/0x30
> > [   30.412228]  ? write_comp_data+0x2f/0x90
> > [   30.412507]  __disarm_kprobe_ftrace.isra.24+0xe4/0x250
> > [   30.412851]  disarm_kprobe+0x24a/0x2d0
> > [   30.413112]  __disable_kprobe+0x2de/0x4b0
> > [   30.413390]  disable_kprobe+0x31/0x80
> > [   30.413643]  __disable_trace_kprobe+0xfb/0x1c0
> > [   30.413965]  disable_trace_kprobe+0x1f0/0x300
> > [   30.414266]  kprobe_register+0x4e/0xf0
> > [   30.414528]  perf_trace_event_unreg.isra.3+0xb6/0x1f0
> > [   30.414870]  perf_kprobe_destroy+0xcb/0x200
> > [   30.415156]  ? __pfx_perf_kprobe_destroy+0x10/0x10
> > [   30.415482]  _free_event+0x220/0x11c0
> > [   30.415754]  put_event+0x4d/0x60
> > [   30.415993]  perf_event_release_kernel+0x5d9/0x860
> > [   30.416330]  ? __pfx_perf_event_release_kernel+0x10/0x10
> > [   30.416680]  ? write_comp_data+0x2f/0x90
> > [   30.416950]  ? __sanitizer_cov_trace_pc+0x25/0x60
> > [   30.417292]  ? __pfx_perf_release+0x10/0x10
> > [   30.417579]  perf_release+0x40/0x50
> > [   30.417830]  __fput+0x26d/0xa40
> > [   30.418080]  ____fput+0x1e/0x30
> > [   30.418303]  task_work_run+0x1a4/0x2d0
> > [   30.418565]  ? write_comp_data+0x2f/0x90
> > [   30.418836]  ? __pfx_task_work_run+0x10/0x10
> > [   30.419138]  ? __this_cpu_preempt_check+0x20/0x30
> > [   30.419463]  ? lockdep_hardirqs_on+0x8a/0x110
> > [   30.419751]  ? exit_to_user_mode_prepare+0x100/0x210
> > [   30.420080]  exit_to_user_mode_prepare+0x200/0x210
> > [   30.420392]  syscall_exit_to_user_mode+0x2d/0x60
> > [   30.420698]  do_syscall_64+0x4a/0x90
> > [   30.420944]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > [   30.421282] RIP: 0033:0x7f3840f1059d
> > [   30.421537] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
> > [   30.422690] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > [   30.423179] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f1059d
> > [   30.423630] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 0000000000000003
> > [   30.424081] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19fb73c0
> > [   30.424531] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401180
> > [   30.424984] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 0000000000000000
> > [   30.425459]  </TASK>
> > [   30.425891] ------------[ cut here ]------------
> > [   30.426223] Failed to disarm kprobe-ftrace at match_dev_by_uuid+0x4/0x100 (error -12)
> > [   30.426785] WARNING: CPU: 1 PID: 510 at kernel/kprobes.c:1130 __disarm_kprobe_ftrace.isra.24+0x1ed/0x250
> > [   30.427381] Modules linked in:
> > [   30.427595] CPU: 1 PID: 510 Comm: repro Not tainted 6.2.0-rc7-4ec5183ec486 #1
> > [   30.428052] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   30.428759] RIP: 0010:__disarm_kprobe_ftrace.isra.24+0x1ed/0x250
> > [   30.429156] Code: 37 f5 05 01 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 64 49 8b 75 00 89 da 48 c7 c7 80 67 6f 85 e8 12 72 bf 03 <0f> 0b e9 03 a
> > [   30.430300] RSP: 0018:ffff88800c387a90 EFLAGS: 00010282
> > [   30.430642] RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: ffffffff813dde2e
> > [   30.431124] RDX: 0000000000000000 RSI: ffff8880125e0000 RDI: 0000000000000002
> > [   30.431575] RBP: ffff88800c387ab0 R08: ffffed1001870f0b R09: ffffed1001870f0b
> > [   30.432028] R10: ffff88800c387857 R11: ffffed1001870f0a R12: 0000000000000000
> > [   30.432483] R13: ffff88800a4a9040 R14: ffffffff875a0ea0 R15: ffff88800a4a9090
> > [   30.432940] FS:  00007f3840deb740(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
> > [   30.433467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   30.433847] CR2: 00007f3840e4d700 CR3: 0000000011a84001 CR4: 0000000000770ee0
> > [   30.434301] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   30.434782] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> > [   30.435234] PKRU: 55555554
> > [   30.435418] Call Trace:
> > [   30.435588]  <TASK>
> > [   30.435743]  disarm_kprobe+0x24a/0x2d0
> > [   30.436011]  __disable_kprobe+0x2de/0x4b0
> > [   30.436295]  disable_kprobe+0x31/0x80
> > [   30.436552]  __disable_trace_kprobe+0xfb/0x1c0
> > [   30.436862]  disable_trace_kprobe+0x1f0/0x300
> > [   30.437165]  kprobe_register+0x4e/0xf0
> > [   30.437429]  perf_trace_event_unreg.isra.3+0xb6/0x1f0
> > [   30.437778]  perf_kprobe_destroy+0xcb/0x200
> > [   30.438077]  ? __pfx_perf_kprobe_destroy+0x10/0x10
> > [   30.438407]  _free_event+0x220/0x11c0
> > [   30.438707]  put_event+0x4d/0x60
> > [   30.438938]  perf_event_release_kernel+0x5d9/0x860
> > [   30.439275]  ? __pfx_perf_event_release_kernel+0x10/0x10
> > [   30.439633]  ? write_comp_data+0x2f/0x90
> > [   30.439913]  ? __sanitizer_cov_trace_pc+0x25/0x60
> > [   30.440245]  ? __pfx_perf_release+0x10/0x10
> > [   30.440533]  perf_release+0x40/0x50
> > [   30.440780]  __fput+0x26d/0xa40
> > [   30.441020]  ____fput+0x1e/0x30
> > [   30.441246]  task_work_run+0x1a4/0x2d0
> > [   30.441509]  ? write_comp_data+0x2f/0x90
> > [   30.441794]  ? __pfx_task_work_run+0x10/0x10
> > [   30.442090]  ? __this_cpu_preempt_check+0x20/0x30
> > [   30.442389]  ? lockdep_hardirqs_on+0x8a/0x110
> > [   30.442705]  ? exit_to_user_mode_prepare+0x100/0x210
> > [   30.443042]  exit_to_user_mode_prepare+0x200/0x210
> > [   30.443366]  syscall_exit_to_user_mode+0x2d/0x60
> > [   30.443683]  do_syscall_64+0x4a/0x90
> > [   30.443937]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > [   30.444281] RIP: 0033:0x7f3840f1059d
> > [   30.444530] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
> > [   30.445701] RSP: 002b:00007ffd19fb73a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > [   30.446211] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f3840f1059d
> > [   30.446716] RDX: 0000000000000010 RSI: 00007ffd19fb7370 RDI: 0000000000000003
> > [   30.447193] RBP: 00007ffd19fb73c0 R08: 0000000000000001 R09: 00007ffd19fb73c0
> > [   30.447661] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401180
> > [   30.448128] R13: 00007ffd19fb74e0 R14: 0000000000000000 R15: 0000000000000000
> > [   30.448618]  </TASK>
> > [   30.448787] irq event stamp: 2017
> > [   30.449020] hardirqs last  enabled at (2025): [<ffffffff813dd0a1>] __up_console_sem+0x91/0xb0
> > [   30.449594] hardirqs last disabled at (2032): [<ffffffff813dd086>] __up_console_sem+0x76/0xb0
> > [   30.450803] softirqs last  enabled at (1974): [<ffffffff8536af3f>] __do_softirq+0x53f/0x836
> > [   30.452095] softirqs last disabled at (1965): [<ffffffff812498b0>] irq_exit_rcu+0x100/0x140
> > [   30.453375] ---[ end trace 0000000000000000 ]---
> > 
> > Bisected and found the first bad commit is:
> > 71a7507afbc3f27c346898f13ab9bfd918613c34
> > Merge tag 'driver-core-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> 
> A merge point is usually not a problem, unless the merge point actually
> has changed code?  Are you sure your bisection is correct?
> 
> But again, you are injecting faults, and a fault happened, what are you
> trying to actually test here?
Yes, there is no abnormal behavior in regular test in this merge point.
I didn't change the code and it may not be a real problem since it's a test
triggered by fault injection.

Please ignore this email and I will confirm that fault injection related
incidents are real issues and report them next time.

Thanks!
BR.

> 
> thanks,
> 
> greg k-h
