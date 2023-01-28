Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD58767F67B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjA1Ivu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA1Ivr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:51:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E851DB83
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674895901; x=1706431901;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1aYLpj66hMubReI5RKwYURhdlVvEYGc8GNdXiO3U5ig=;
  b=QHMm/uBPEqufcoLTn7UrL8ZPUFmwjZaHbZS4i6UrbaqmsXg+/oFBmeKz
   RXSRKBQUF6oUKWzdCfdDp9dCvKsQawSBs2RztjlpHPRvVTzCZVLj761x5
   cDy3akGM1ZUyiXbpHOytDk1NnVFSYf55pJrEh13KdSwMij1S/iBvAqiFb
   jKremdvoRZ3jY4Hlf4WiMq/RBnEbH4jK8E2YXY2MbtKNz3h8VYZs9K/p9
   C9HtJqhkP1G5E7X1uJwm2wZ3vcg/Mh+MbqXdA/zacT4rUX5fRMmNfsmj7
   Aev9KVXpT/tl2rP8iIJqnGU7IdYfBPk+zbcJqEVoRBjiyjv7WRS58L3JM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="325948663"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="325948663"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:51:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="695810016"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="695810016"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2023 00:51:39 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 28 Jan 2023 00:51:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 28 Jan 2023 00:51:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 28 Jan 2023 00:51:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRmrPCeaS9n9S2o7JwclS6nPyakFNXAdvNJbe4PPCO8QIfLuCpEAWXgA+M4D+QZvoLc7/9J9lltYvf2HDbOKIr7v2P9o7QUjYq9Ed99UkrbZzN7Cpp9m/5KEerw74rBWqUfZQj6CzUSWKu5eBP9l54Hci4A5zNFTOrIPr0X/zYPJOqEeLH3I8kaMClxzcmHK4CjnmzAVUULa4pn/4v3jwfKzkvBqJGk0Z31ma0qjB6gG4qAL2Kvo0g5DRDusvPUYtXS3yCoxJUEUNX2znq1/RMDJsbuNvhziHb93H7jpsrqbdseEy68hBBipDyHDxtKSv8TPWZKPg5BoOXpWZ4uGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8vg8LePWwthZnvzz+BQ4o5DTA3vRa3fmE51ifd2vyg=;
 b=DQ1p8ZhCJvRsUpAb8DkjkWTmdC/y7YpXUhFBwxEk5eh4IoUht8QpIZJAgra4NY5w1IgpZP27QbEIvKSgNcCsRpa47tjnJTXP8854MjesUerSbn3N8Psp5wmQLJuLX00jEnp0WFASx8tzeSzN6riNGhQb6rYuwapqNCGw4NzMm0cVoTG2YVGpPwzSMWaW3JfQqatfTvCF5ZDCDGdcpVr0dGNsKhTpoolnq0I7MZS55hk7Avwi+KstF7KJgn0EN7odqV/KyFSBtcY41sTluRK9cJqRuvNH+cXdKblkNm7BpWDK0CAj8Wzyg59MF2vFUIUSz4guEGfM+kFqgcXAYRAEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH7PR11MB7431.namprd11.prod.outlook.com (2603:10b6:510:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Sat, 28 Jan
 2023 08:51:26 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fa67:cc38:6224:ec80%5]) with mapi id 15.20.6002.033; Sat, 28 Jan 2023
 08:51:25 +0000
Date:   Sat, 28 Jan 2023 16:52:27 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <asml.silence@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <heng.su@intel.com>, <axboe@kernel.dk>
Subject: Re: [Syzkaller & bisect] There is "io_ring_exit_work" related Call
 Trace in v6.2-rc5 kernel
Message-ID: <Y9TiSxFdLZ+ZRdkD@xpf.sh.intel.com>
References: <Y9TgUupO5C39V/DW@xpf.sh.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y9TgUupO5C39V/DW@xpf.sh.intel.com>
X-ClientProxiedBy: SG2PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:4:7c::16) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH7PR11MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb2c41a-6bed-490f-916c-08db010cd60f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtLkcUsdxgi7kv5rbuNQ7XnJa4yBcgwUWfVaFejWdpBBrT6CtqEwWel2kSV12V773fvuUB739iNSWy6pqL0YhJcSEY5OfRgdKgydH+OPitOTzIl6dxVuAFC3rpvl7wD+j8YPdnLYyUSrjObNH+trqg1CSRNDp2yHU4MaieKHjgnm1oHWO++Qs4uNHmJlRacw7bGBMrn07w0HVZlGR/WTknXq1O44fhFiV8IllwsNmyT8L3xbPRugRtc7Y1oBkLueVZqiXVQsX5++r1WctxufQCxICOmnrGgRLk42caUOL7tEyVRFiSfdKqq/CIU9OIlPU/jKSj/QlQu9hGAr5zeb/Z92bfkAx4npOxb5OnhBcrwtsMXbT1P0C8SLXeFtgccdvFg7UWNcR2mH90RyGKp8HKGAD3sK2S96tIPqPM2qaCgkIiZY1P+dEeCiHGyY0b40OAQWG83tRwBTWxrh1rskqDO0+xI513pAz+9AuP0QdEfio8yqLYGgty/ZuD6Zsx03FZUS6F/3/R3WMXKcZN5HST++pRf+R/MkGt38NJAzvv3EGwbJLJXpO0OYMjFSShQtTjMyW20GViHTjptt6cK5ECBnQe5HUsJzmEUKM1hLgUrWNi+wyLCi818WjJqCeCDdIhctuepR34FCjmTjHaBsRHULyNu3LSaexllD/TDnLT/oVrs1U2pxswgqH44T66U9xlC19G0DoDdWRDaU5YHPc4hhf5ANW3IBZ2tIvhcKL7/abkZDCefUB1wCUnbbQANSElm8Qo0wRK5msEkop5bxhkJCW9SAg/6sQVjf4QP9DUdWy46//yeEONM6jF/VXe4z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(41300700001)(8936002)(44832011)(86362001)(30864003)(5660300002)(83380400001)(66574015)(82960400001)(40140700001)(316002)(45080400002)(66946007)(66476007)(66556008)(18074004)(8676002)(4326008)(6512007)(26005)(186003)(6506007)(53546011)(966005)(478600001)(6486002)(66899018)(38100700002)(2906002)(95444003)(67856001)(579004)(559001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFF5VnBLL3VkS3dISFJHSzVTK3ZUZkFXUTNhNDhQOHJBMzFNdWhoNSs3SlVa?=
 =?utf-8?B?bUNvak5PcXZOQXZaU3FXK2dLMGdMMjkxc0RWKzY5MDZLT2EyR0IvS25Od05l?=
 =?utf-8?B?OUZIOE1UWnB5YUVwQ3NLL0c4SUIwZ0dTb1BycWJIcEY4dHp1anRpZHMvelhN?=
 =?utf-8?B?MzNJZmJqdk9sblBXL0NvMDJmbm8wK2MzZy9VdlQyZm1GSVhZTTV3YmhXTWgr?=
 =?utf-8?B?OFFJMUppeitDVFJ1a1NIUis0UUtmVk05ZHQwUlg5cmFKQWlwd2FCM3VlUml4?=
 =?utf-8?B?alBsMFVmbzg1ajE5TjM5d2hpWjRNbUEwQUd4Q2F2K0FOWlhWaDVTb2xWSEE2?=
 =?utf-8?B?bkR6SlNHdlF2SWVCMXNKelJTSTd1aG5wa1d2QlRhdEg3Y3dFSnlacmw1V3p3?=
 =?utf-8?B?UkprS0dGZGlaeDN5aDlWZW0zSzg0angzbHJlU3VhMWY1SVlWaHV0b0hhZW9Z?=
 =?utf-8?B?ZjRjUWwrMnd2UkVHeUlwbDlKbHR5ZlhLQUlpcTJHZG1WUGtLL3JGUjN6Szll?=
 =?utf-8?B?WVduc1h0VFRlYTRXV3hpY2U0aGI4ajBFejRUYk9yY0o0Ym5jQkE1QmlYODJT?=
 =?utf-8?B?cVN0M1EyVEVXUGFWZkZKbFd5Sm13R1NiVTMxajlvWlFRNkhxbHJ3dnBrT3ln?=
 =?utf-8?B?NXF0UkFXY3huc2tWcVNkWjFVSjVMUHhnYWc5RDFreitzOUh0UTJhUFlDYnla?=
 =?utf-8?B?R0dQM1pOYVo3Z28vcEtOREdaYWdoUDdacTdZRnZIbVlMQlAwVStObWRnZ1hE?=
 =?utf-8?B?MjJDVEJyaTlWZHFpOXlDeTBtN29yMDJ1QVdlVDFQQXBhZGdCSVhnM3NYMGRt?=
 =?utf-8?B?cmx1cXVCY0JZVUJFUlJFUDB5RDViTmlUVC93SjBmOXUxWXlkQXljdnBMYU5C?=
 =?utf-8?B?VVZHQURpbGlOb0JyT2pkSUpsLy91azZudHQzWmlIaCtvSGhMWGFpbWh0QzBH?=
 =?utf-8?B?d3BhWkZVK1Y0cnZkUXNvQlJEVExiUUpadzRGQ005TTlOMTBvSlRSZW1DRW9n?=
 =?utf-8?B?RUw2TVBSZXBybG1FVldTMnIzMkgrYjk4R0pLa25OU21XU3F0Tk54TjR2OHRj?=
 =?utf-8?B?UU03MHFCTW5iaTVmZVp6ZlZHUkFaQVlLV25kZk1PSXloek5LSTJRcU1pdzVi?=
 =?utf-8?B?ZkdlN015Wms4MUZjc2I3TVhyUHMxMDlVU21MUWtHZ1dpVDdqV2trRGE1bzAy?=
 =?utf-8?B?OHVMMTk1dFgwMTVobGpCNVBhVEhJdmxwVHV6RWtMNDBGMmwyZ3REWDRxUW1B?=
 =?utf-8?B?UDFaVFRVbjJxVU1PWVlHQytBVjY5RHZkMzUwSXFNTFV0US9SdjA3SWtBZHJa?=
 =?utf-8?B?dmZVWFhuNnlJamhRNkhxSGxSenhiS0poOXl1WHFzb2pOR2g4WG44ZDFhNVVz?=
 =?utf-8?B?QkcwdnVOaW55WUJaQ1hYRnVHMFBWNVNpR1pXTG9wSFdqdlhpOFFTWThkODZX?=
 =?utf-8?B?clBLbW05MFFlRFZoZzUyNytXMGt4M0UrYlBpMEpINzVveHZJNS9XRWdCN0hY?=
 =?utf-8?B?S0gwbGJOeWNwdUFWYzRUMTIydC8zZGcxV1c1dkEwWGVRRTB1NXFFM0RZWnRJ?=
 =?utf-8?B?ajhVSEY1N09mWjVRYm5GMUlhazA0UUpKRDZXN2ZKRDNiNEk0ekN4clNqdit1?=
 =?utf-8?B?SEZsZjJKbFdVRnZ5N3lidGJoeE1EY1Ztb2ZJemhBeHZYTnVUc04vNUpuY1po?=
 =?utf-8?B?bmdObEtuT1U1YWpoT29LTXJsK3F3MzRGRVlyOVQ4UTFVTXdoRVJqTGxELzZE?=
 =?utf-8?B?ZzR6QjVyYnpicVVZSWswUk90Q2l3Z1NmNk02TFd4cVR6ZlNhVXFTcmZBM2Ew?=
 =?utf-8?B?VW9OYzZqbFJlS2VXUGJsU2o5UnczK3V4VEdHTVlBeUxCUi9SaDM4WHJINFFH?=
 =?utf-8?B?S05QUHl3MXZ1dlR3bkJnblphTDhlUkwyN25Nbmg0THlWY3hvOXBNbEZPUWdP?=
 =?utf-8?B?K0w3ai9FSEpWOUV5R3cvTURPUE5vQWZEN1dnajN3QVhtb29qNG1uN2IydHEr?=
 =?utf-8?B?TjVEZk9GTHpnelQzdEJPWTNpaEg1OCt6ajZLNWxPNHRZbll3cXMxcURFcmhs?=
 =?utf-8?B?K01MMVZEbUZlQ3NoODh1VWZ0ZWFEajg2WFpUclJNSENEYjNlWXR5azNJb2Uz?=
 =?utf-8?B?eFJ2ZUMwbHJuNUxoY2E4MVFiNnJnRE1RQmc3bG5DcFZXV3BhZ0lrYTljanZO?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb2c41a-6bed-490f-916c-08db010cd60f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 08:51:25.4713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgfY5DgZxiM5dEzp7o46G8LVQwcL1kc8YDiEJ4bLGnOgi2Mg34XQUoQpsRmwoLWPqxNlGxdokub0qvr4H3wPIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7431
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, correct the kernel version v5.2-rc5 -> v6.2-rc5 in the subject and
content.

On 2023-01-28 at 16:44:02 +0800, Pengfei Xu wrote:
> Hi Pavel Begunkov and kernel expert,
>=20
> Greeting!
>=20
> There is "io_ring_exit_work" related Call Trace in v6.2-rc5 kernel in gue=
st
> on Sapphire Rapids server.
>=20
> INFO: task kworker/u4:2:32 blocked for more than 147 seconds.
> [  300.212512]       Not tainted 6.2.0-rc5-2241ab53cbb5 #1
> [  300.213087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  300.213921] task:kworker/u4:2    state:D stack:0     pid:32    ppid:2 =
     flags:0x00004000
> [  300.214849] Workqueue: events_unbound io_ring_exit_work
> [  300.215506] Call Trace:
> [  300.215789]  <TASK>
> [  300.216051]  __schedule+0x385/0xb00
> [  300.216467]  ? write_comp_data+0x2f/0x90
> [  300.216949]  ? wait_for_completion+0x7b/0x180
> [  300.217445]  schedule+0x5b/0xe0
> [  300.217836]  schedule_timeout+0x561/0x650
> [  300.218301]  ? _raw_spin_unlock_irq+0x2b/0x60
> [  300.218816]  ? wait_for_completion+0x7b/0x180
> [  300.219341]  ? __this_cpu_preempt_check+0x20/0x30
> [  300.219893]  ? lockdep_hardirqs_on+0x8a/0x110
> [  300.220384]  ? _raw_spin_unlock_irq+0x2b/0x60
> [  300.220881]  ? wait_for_completion+0x9e/0x180
> [  300.221382]  ? trace_hardirqs_on+0x3f/0x100
> [  300.221868]  ? wait_for_completion+0x7b/0x180
> [  300.222379]  wait_for_completion+0xa6/0x180
> [  300.222897]  io_ring_exit_work+0x2f7/0x747
> [  300.223383]  ? __pfx_io_tctx_exit_cb+0x10/0x10
> [  300.223947]  process_one_work+0x3b1/0x960
> [  300.224446]  worker_thread+0x52/0x660
> [  300.224884]  ? __pfx_worker_thread+0x10/0x10
> [  300.225376]  kthread+0x161/0x1a0
> [  300.225782]  ? __pfx_kthread+0x10/0x10
> [  300.226225]  ret_from_fork+0x29/0x50
> [  300.226688]  </TASK>
> [  300.227791]=20
> [  300.227791] Showing all locks held in the system:
> [  300.228501] 1 lock held by rcu_tasks_kthre/11:
> [  300.229003]  #0: ffffffff83d617b0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:=
3}, at: rcu_tasks_one_gp+0x2d/0x3d0
> [  300.230098] 1 lock held by rcu_tasks_rude_/12:
> [  300.230601]  #0: ffffffff83d61530 (rcu_tasks_rude.tasks_gp_mutex){+.+.=
}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
> [  300.231733] 1 lock held by rcu_tasks_trace/13:
> [  300.232244]  #0: ffffffff83d61270 (rcu_tasks_trace.tasks_gp_mutex){+.+=
.}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
> [  300.233377] 1 lock held by khungtaskd/29:
> [  300.233842]  #0: ffffffff83d621c0 (rcu_read_lock){....}-{1:2}, at: deb=
ug_show_all_locks+0x27/0x18c
> [  300.234866] 2 locks held by kworker/u4:2/32:
> [  300.235351]  #0: ff11000006045d38 ((wq_completion)events_unbound){+.+.=
}-{0:0}, at: process_one_work+0x2ff/0x960
> [  300.236502]  #1: ffa0000000117e60 ((work_completion)(&ctx->exit_work))=
{+.+.}-{0:0}, at: process_one_work+0x303/0x960
> [  300.237696]=20
> [  300.237882] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> [  300.237882]=20
>=20
> Bisected and found the first bad commit is:
> eebd2e37e662617a6b8041db75205f0a262ce870
> io_uring: don't take task ring-file notes
>=20
> But after reverted above commit eebd2e37e on top of v6.2-rc5 kernel and m=
ade
> the kernel failed. So it's just the suspected commit for above problem.
>=20
> Syzkaller reproduced code, bisect info, kconfig and v6.2-rc5 dmesg are in
> attached.
>=20
> All detailed info is in link:
> https://github.com/xupengfe/syzkaller_logs/tree/main/230124_055801_io_rin=
g_exit_work
>=20
> I hope it's helpful.
>=20
> Thanks!
> BR.

> // autogenerated by syzkaller (https://github.com/google/syzkaller)
>=20
> #define _GNU_SOURCE
>=20
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <setjmp.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stddef.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <sys/mount.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
>=20
> #include <linux/loop.h>
>=20
> #ifndef __NR_io_uring_setup
> #define __NR_io_uring_setup 425
> #endif
> #ifndef __NR_memfd_create
> #define __NR_memfd_create 319
> #endif
>=20
> static unsigned long long procid;
>=20
> static __thread int clone_ongoing;
> static __thread int skip_segv;
> static __thread jmp_buf segv_env;
>=20
> static void segv_handler(int sig, siginfo_t* info, void* ctx)
> {
>   if (__atomic_load_n(&clone_ongoing, __ATOMIC_RELAXED) !=3D 0) {
>     exit(sig);
>   }
>   uintptr_t addr =3D (uintptr_t)info->si_addr;
>   const uintptr_t prog_start =3D 1 << 20;
>   const uintptr_t prog_end =3D 100 << 20;
>   int skip =3D __atomic_load_n(&skip_segv, __ATOMIC_RELAXED) !=3D 0;
>   int valid =3D addr < prog_start || addr > prog_end;
>   if (skip && valid) {
>     _longjmp(segv_env, 1);
>   }
>   exit(sig);
> }
>=20
> static void install_segv_handler(void)
> {
>   struct sigaction sa;
>   memset(&sa, 0, sizeof(sa));
>   sa.sa_handler =3D SIG_IGN;
>   syscall(SYS_rt_sigaction, 0x20, &sa, NULL, 8);
>   syscall(SYS_rt_sigaction, 0x21, &sa, NULL, 8);
>   memset(&sa, 0, sizeof(sa));
>   sa.sa_sigaction =3D segv_handler;
>   sa.sa_flags =3D SA_NODEFER | SA_SIGINFO;
>   sigaction(SIGSEGV, &sa, NULL);
>   sigaction(SIGBUS, &sa, NULL);
> }
>=20
> #define NONFAILING(...)                                                  =
      \
>   ({                                                                     =
      \
>     int ok =3D 1;                                                        =
        \
>     __atomic_fetch_add(&skip_segv, 1, __ATOMIC_SEQ_CST);                 =
      \
>     if (_setjmp(segv_env) =3D=3D 0) {                                    =
          \
>       __VA_ARGS__;                                                       =
      \
>     } else                                                               =
      \
>       ok =3D 0;                                                          =
        \
>     __atomic_fetch_sub(&skip_segv, 1, __ATOMIC_SEQ_CST);                 =
      \
>     ok;                                                                  =
      \
>   })
>=20
> static void sleep_ms(uint64_t ms)
> {
>   usleep(ms * 1000);
> }
>=20
> static uint64_t current_time_ms(void)
> {
>   struct timespec ts;
>   if (clock_gettime(CLOCK_MONOTONIC, &ts))
>     exit(1);
>   return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
>=20
> static bool write_file(const char* file, const char* what, ...)
> {
>   char buf[1024];
>   va_list args;
>   va_start(args, what);
>   vsnprintf(buf, sizeof(buf), what, args);
>   va_end(args);
>   buf[sizeof(buf) - 1] =3D 0;
>   int len =3D strlen(buf);
>   int fd =3D open(file, O_WRONLY | O_CLOEXEC);
>   if (fd =3D=3D -1)
>     return false;
>   if (write(fd, buf, len) !=3D len) {
>     int err =3D errno;
>     close(fd);
>     errno =3D err;
>     return false;
>   }
>   close(fd);
>   return true;
> }
>=20
> //% This code is derived from puff.{c,h}, found in the zlib development. =
The
> //% original files come with the following copyright notice:
>=20
> //% Copyright (C) 2002-2013 Mark Adler, all rights reserved
> //% version 2.3, 21 Jan 2013
> //% This software is provided 'as-is', without any express or implied
> //% warranty.  In no event will the author be held liable for any damages
> //% arising from the use of this software.
> //% Permission is granted to anyone to use this software for any purpose,
> //% including commercial applications, and to alter it and redistribute i=
t
> //% freely, subject to the following restrictions:
> //% 1. The origin of this software must not be misrepresented; you must n=
ot
> //%    claim that you wrote the original software. If you use this softwa=
re
> //%    in a product, an acknowledgment in the product documentation would=
 be
> //%    appreciated but is not required.
> //% 2. Altered source versions must be plainly marked as such, and must n=
ot be
> //%    misrepresented as being the original software.
> //% 3. This notice may not be removed or altered from any source distribu=
tion.
> //% Mark Adler    madler@alumni.caltech.edu
>=20
> //% BEGIN CODE DERIVED FROM puff.{c,h}
>=20
> #define MAXBITS 15
> #define MAXLCODES 286
> #define MAXDCODES 30
> #define MAXCODES (MAXLCODES + MAXDCODES)
> #define FIXLCODES 288
>=20
> struct puff_state {
>   unsigned char* out;
>   unsigned long outlen;
>   unsigned long outcnt;
>   const unsigned char* in;
>   unsigned long inlen;
>   unsigned long incnt;
>   int bitbuf;
>   int bitcnt;
>   jmp_buf env;
> };
> static int puff_bits(struct puff_state* s, int need)
> {
>   long val =3D s->bitbuf;
>   while (s->bitcnt < need) {
>     if (s->incnt =3D=3D s->inlen)
>       longjmp(s->env, 1);
>     val |=3D (long)(s->in[s->incnt++]) << s->bitcnt;
>     s->bitcnt +=3D 8;
>   }
>   s->bitbuf =3D (int)(val >> need);
>   s->bitcnt -=3D need;
>   return (int)(val & ((1L << need) - 1));
> }
> static int puff_stored(struct puff_state* s)
> {
>   s->bitbuf =3D 0;
>   s->bitcnt =3D 0;
>   if (s->incnt + 4 > s->inlen)
>     return 2;
>   unsigned len =3D s->in[s->incnt++];
>   len |=3D s->in[s->incnt++] << 8;
>   if (s->in[s->incnt++] !=3D (~len & 0xff) ||
>       s->in[s->incnt++] !=3D ((~len >> 8) & 0xff))
>     return -2;
>   if (s->incnt + len > s->inlen)
>     return 2;
>   if (s->outcnt + len > s->outlen)
>     return 1;
>   for (; len--; s->outcnt++, s->incnt++) {
>     if (s->in[s->incnt])
>       s->out[s->outcnt] =3D s->in[s->incnt];
>   }
>   return 0;
> }
> struct puff_huffman {
>   short* count;
>   short* symbol;
> };
> static int puff_decode(struct puff_state* s, const struct puff_huffman* h=
)
> {
>   int first =3D 0;
>   int index =3D 0;
>   int bitbuf =3D s->bitbuf;
>   int left =3D s->bitcnt;
>   int code =3D first =3D index =3D 0;
>   int len =3D 1;
>   short* next =3D h->count + 1;
>   while (1) {
>     while (left--) {
>       code |=3D bitbuf & 1;
>       bitbuf >>=3D 1;
>       int count =3D *next++;
>       if (code - count < first) {
>         s->bitbuf =3D bitbuf;
>         s->bitcnt =3D (s->bitcnt - len) & 7;
>         return h->symbol[index + (code - first)];
>       }
>       index +=3D count;
>       first +=3D count;
>       first <<=3D 1;
>       code <<=3D 1;
>       len++;
>     }
>     left =3D (MAXBITS + 1) - len;
>     if (left =3D=3D 0)
>       break;
>     if (s->incnt =3D=3D s->inlen)
>       longjmp(s->env, 1);
>     bitbuf =3D s->in[s->incnt++];
>     if (left > 8)
>       left =3D 8;
>   }
>   return -10;
> }
> static int puff_construct(struct puff_huffman* h, const short* length, in=
t n)
> {
>   int len;
>   for (len =3D 0; len <=3D MAXBITS; len++)
>     h->count[len] =3D 0;
>   int symbol;
>   for (symbol =3D 0; symbol < n; symbol++)
>     (h->count[length[symbol]])++;
>   if (h->count[0] =3D=3D n)
>     return 0;
>   int left =3D 1;
>   for (len =3D 1; len <=3D MAXBITS; len++) {
>     left <<=3D 1;
>     left -=3D h->count[len];
>     if (left < 0)
>       return left;
>   }
>   short offs[MAXBITS + 1];
>   offs[1] =3D 0;
>   for (len =3D 1; len < MAXBITS; len++)
>     offs[len + 1] =3D offs[len] + h->count[len];
>   for (symbol =3D 0; symbol < n; symbol++)
>     if (length[symbol] !=3D 0)
>       h->symbol[offs[length[symbol]]++] =3D symbol;
>   return left;
> }
> static int puff_codes(struct puff_state* s, const struct puff_huffman* le=
ncode,
>                       const struct puff_huffman* distcode)
> {
>   static const short lens[29] =3D {3,  4,  5,  6,   7,   8,   9,   10,  1=
1, 13,
>                                  15, 17, 19, 23,  27,  31,  35,  43,  51,=
 59,
>                                  67, 83, 99, 115, 131, 163, 195, 227, 258=
};
>   static const short lext[29] =3D {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2,=
 2, 2,
>                                  2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0=
};
>   static const short dists[30] =3D {
>       1,    2,    3,    4,    5,    7,    9,    13,    17,    25,
>       33,   49,   65,   97,   129,  193,  257,  385,   513,   769,
>       1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577};
>   static const short dext[30] =3D {0, 0, 0,  0,  1,  1,  2,  2,  3,  3,
>                                  4, 4, 5,  5,  6,  6,  7,  7,  8,  8,
>                                  9, 9, 10, 10, 11, 11, 12, 12, 13, 13};
>   int symbol;
>   do {
>     symbol =3D puff_decode(s, lencode);
>     if (symbol < 0)
>       return symbol;
>     if (symbol < 256) {
>       if (s->outcnt =3D=3D s->outlen)
>         return 1;
>       if (symbol)
>         s->out[s->outcnt] =3D symbol;
>       s->outcnt++;
>     } else if (symbol > 256) {
>       symbol -=3D 257;
>       if (symbol >=3D 29)
>         return -10;
>       int len =3D lens[symbol] + puff_bits(s, lext[symbol]);
>       symbol =3D puff_decode(s, distcode);
>       if (symbol < 0)
>         return symbol;
>       unsigned dist =3D dists[symbol] + puff_bits(s, dext[symbol]);
>       if (dist > s->outcnt)
>         return -11;
>       if (s->outcnt + len > s->outlen)
>         return 1;
>       while (len--) {
>         if (dist <=3D s->outcnt && s->out[s->outcnt - dist])
>           s->out[s->outcnt] =3D s->out[s->outcnt - dist];
>         s->outcnt++;
>       }
>     }
>   } while (symbol !=3D 256);
>   return 0;
> }
> static int puff_fixed(struct puff_state* s)
> {
>   static int virgin =3D 1;
>   static short lencnt[MAXBITS + 1], lensym[FIXLCODES];
>   static short distcnt[MAXBITS + 1], distsym[MAXDCODES];
>   static struct puff_huffman lencode, distcode;
>   if (virgin) {
>     lencode.count =3D lencnt;
>     lencode.symbol =3D lensym;
>     distcode.count =3D distcnt;
>     distcode.symbol =3D distsym;
>     short lengths[FIXLCODES];
>     int symbol;
>     for (symbol =3D 0; symbol < 144; symbol++)
>       lengths[symbol] =3D 8;
>     for (; symbol < 256; symbol++)
>       lengths[symbol] =3D 9;
>     for (; symbol < 280; symbol++)
>       lengths[symbol] =3D 7;
>     for (; symbol < FIXLCODES; symbol++)
>       lengths[symbol] =3D 8;
>     puff_construct(&lencode, lengths, FIXLCODES);
>     for (symbol =3D 0; symbol < MAXDCODES; symbol++)
>       lengths[symbol] =3D 5;
>     puff_construct(&distcode, lengths, MAXDCODES);
>     virgin =3D 0;
>   }
>   return puff_codes(s, &lencode, &distcode);
> }
> static int puff_dynamic(struct puff_state* s)
> {
>   static const short order[19] =3D {16, 17, 18, 0, 8,  7, 9,  6, 10, 5,
>                                   11, 4,  12, 3, 13, 2, 14, 1, 15};
>   int nlen =3D puff_bits(s, 5) + 257;
>   int ndist =3D puff_bits(s, 5) + 1;
>   int ncode =3D puff_bits(s, 4) + 4;
>   if (nlen > MAXLCODES || ndist > MAXDCODES)
>     return -3;
>   short lengths[MAXCODES];
>   int index;
>   for (index =3D 0; index < ncode; index++)
>     lengths[order[index]] =3D puff_bits(s, 3);
>   for (; index < 19; index++)
>     lengths[order[index]] =3D 0;
>   short lencnt[MAXBITS + 1], lensym[MAXLCODES];
>   struct puff_huffman lencode =3D {lencnt, lensym};
>   int err =3D puff_construct(&lencode, lengths, 19);
>   if (err !=3D 0)
>     return -4;
>   index =3D 0;
>   while (index < nlen + ndist) {
>     int symbol;
>     int len;
>     symbol =3D puff_decode(s, &lencode);
>     if (symbol < 0)
>       return symbol;
>     if (symbol < 16)
>       lengths[index++] =3D symbol;
>     else {
>       len =3D 0;
>       if (symbol =3D=3D 16) {
>         if (index =3D=3D 0)
>           return -5;
>         len =3D lengths[index - 1];
>         symbol =3D 3 + puff_bits(s, 2);
>       } else if (symbol =3D=3D 17)
>         symbol =3D 3 + puff_bits(s, 3);
>       else
>         symbol =3D 11 + puff_bits(s, 7);
>       if (index + symbol > nlen + ndist)
>         return -6;
>       while (symbol--)
>         lengths[index++] =3D len;
>     }
>   }
>   if (lengths[256] =3D=3D 0)
>     return -9;
>   err =3D puff_construct(&lencode, lengths, nlen);
>   if (err && (err < 0 || nlen !=3D lencode.count[0] + lencode.count[1]))
>     return -7;
>   short distcnt[MAXBITS + 1], distsym[MAXDCODES];
>   struct puff_huffman distcode =3D {distcnt, distsym};
>   err =3D puff_construct(&distcode, lengths + nlen, ndist);
>   if (err && (err < 0 || ndist !=3D distcode.count[0] + distcode.count[1]=
))
>     return -8;
>   return puff_codes(s, &lencode, &distcode);
> }
> static int puff(unsigned char* dest, unsigned long* destlen,
>                 const unsigned char* source, unsigned long sourcelen)
> {
>   struct puff_state s =3D {
>       .out =3D dest,
>       .outlen =3D *destlen,
>       .outcnt =3D 0,
>       .in =3D source,
>       .inlen =3D sourcelen,
>       .incnt =3D 0,
>       .bitbuf =3D 0,
>       .bitcnt =3D 0,
>   };
>   int err;
>   if (setjmp(s.env) !=3D 0)
>     err =3D 2;
>   else {
>     int last;
>     do {
>       last =3D puff_bits(&s, 1);
>       int type =3D puff_bits(&s, 2);
>       err =3D type =3D=3D 0 ? puff_stored(&s)
>                       : (type =3D=3D 1 ? puff_fixed(&s)
>                                    : (type =3D=3D 2 ? puff_dynamic(&s) : =
-1));
>       if (err !=3D 0)
>         break;
>     } while (!last);
>   }
>   *destlen =3D s.outcnt;
>   return err;
> }
>=20
> //% END CODE DERIVED FROM puff.{c,h}
>=20
> #define ZLIB_HEADER_WIDTH 2
>=20
> static int puff_zlib_to_file(const unsigned char* source,
>                              unsigned long sourcelen, int dest_fd)
> {
>   if (sourcelen < ZLIB_HEADER_WIDTH)
>     return 0;
>   source +=3D ZLIB_HEADER_WIDTH;
>   sourcelen -=3D ZLIB_HEADER_WIDTH;
>   const unsigned long max_destlen =3D 132 << 20;
>   void* ret =3D mmap(0, max_destlen, PROT_WRITE | PROT_READ,
>                    MAP_PRIVATE | MAP_ANON, -1, 0);
>   if (ret =3D=3D MAP_FAILED)
>     return -1;
>   unsigned char* dest =3D (unsigned char*)ret;
>   unsigned long destlen =3D max_destlen;
>   int err =3D puff(dest, &destlen, source, sourcelen);
>   if (err) {
>     munmap(dest, max_destlen);
>     errno =3D -err;
>     return -1;
>   }
>   if (write(dest_fd, dest, destlen) !=3D (ssize_t)destlen) {
>     munmap(dest, max_destlen);
>     return -1;
>   }
>   return munmap(dest, destlen);
> }
>=20
> static int setup_loop_device(unsigned char* data, unsigned long size,
>                              const char* loopname, int* loopfd_p)
> {
>   int err =3D 0, loopfd =3D -1;
>   int memfd =3D syscall(__NR_memfd_create, "syzkaller", 0);
>   if (memfd =3D=3D -1) {
>     err =3D errno;
>     goto error;
>   }
>   if (puff_zlib_to_file(data, size, memfd)) {
>     err =3D errno;
>     goto error_close_memfd;
>   }
>   loopfd =3D open(loopname, O_RDWR);
>   if (loopfd =3D=3D -1) {
>     err =3D errno;
>     goto error_close_memfd;
>   }
>   if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
>     if (errno !=3D EBUSY) {
>       err =3D errno;
>       goto error_close_loop;
>     }
>     ioctl(loopfd, LOOP_CLR_FD, 0);
>     usleep(1000);
>     if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
>       err =3D errno;
>       goto error_close_loop;
>     }
>   }
>   close(memfd);
>   *loopfd_p =3D loopfd;
>   return 0;
>=20
> error_close_loop:
>   close(loopfd);
> error_close_memfd:
>   close(memfd);
> error:
>   errno =3D err;
>   return -1;
> }
>=20
> static long syz_mount_image(volatile long fsarg, volatile long dir,
>                             volatile long flags, volatile long optsarg,
>                             volatile long change_dir,
>                             volatile unsigned long size, volatile long im=
age)
> {
>   unsigned char* data =3D (unsigned char*)image;
>   int res =3D -1, err =3D 0, loopfd =3D -1, need_loop_device =3D !!size;
>   char* mount_opts =3D (char*)optsarg;
>   char* target =3D (char*)dir;
>   char* fs =3D (char*)fsarg;
>   char* source =3D NULL;
>   char loopname[64];
>   if (need_loop_device) {
>     memset(loopname, 0, sizeof(loopname));
>     snprintf(loopname, sizeof(loopname), "/dev/loop%llu", procid);
>     if (setup_loop_device(data, size, loopname, &loopfd) =3D=3D -1)
>       return -1;
>     source =3D loopname;
>   }
>   mkdir(target, 0777);
>   char opts[256];
>   memset(opts, 0, sizeof(opts));
>   if (strlen(mount_opts) > (sizeof(opts) - 32)) {
>   }
>   strncpy(opts, mount_opts, sizeof(opts) - 32);
>   if (strcmp(fs, "iso9660") =3D=3D 0) {
>     flags |=3D MS_RDONLY;
>   } else if (strncmp(fs, "ext", 3) =3D=3D 0) {
>     bool has_remount_ro =3D false;
>     char* remount_ro_start =3D strstr(opts, "errors=3Dremount-ro");
>     if (remount_ro_start !=3D NULL) {
>       char after =3D *(remount_ro_start + strlen("errors=3Dremount-ro"));
>       char before =3D remount_ro_start =3D=3D opts ? '\0' : *(remount_ro_=
start - 1);
>       has_remount_ro =3D ((before =3D=3D '\0' || before =3D=3D ',') &&
>                         (after =3D=3D '\0' || after =3D=3D ','));
>     }
>     if (strstr(opts, "errors=3Dpanic") || !has_remount_ro)
>       strcat(opts, ",errors=3Dcontinue");
>   } else if (strcmp(fs, "xfs") =3D=3D 0) {
>     strcat(opts, ",nouuid");
>   }
>   res =3D mount(source, target, fs, flags, opts);
>   if (res =3D=3D -1) {
>     err =3D errno;
>     goto error_clear_loop;
>   }
>   res =3D open(target, O_RDONLY | O_DIRECTORY);
>   if (res =3D=3D -1) {
>     err =3D errno;
>     goto error_clear_loop;
>   }
>   if (change_dir) {
>     res =3D chdir(target);
>     if (res =3D=3D -1) {
>       err =3D errno;
>     }
>   }
>=20
> error_clear_loop:
>   if (need_loop_device) {
>     ioctl(loopfd, LOOP_CLR_FD, 0);
>     close(loopfd);
>   }
>   errno =3D err;
>   return res;
> }
>=20
> static void kill_and_wait(int pid, int* status)
> {
>   kill(-pid, SIGKILL);
>   kill(pid, SIGKILL);
>   for (int i =3D 0; i < 100; i++) {
>     if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
>       return;
>     usleep(1000);
>   }
>   DIR* dir =3D opendir("/sys/fs/fuse/connections");
>   if (dir) {
>     for (;;) {
>       struct dirent* ent =3D readdir(dir);
>       if (!ent)
>         break;
>       if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =
=3D=3D 0)
>         continue;
>       char abort[300];
>       snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>                ent->d_name);
>       int fd =3D open(abort, O_WRONLY);
>       if (fd =3D=3D -1) {
>         continue;
>       }
>       if (write(fd, abort, 1) < 0) {
>       }
>       close(fd);
>     }
>     closedir(dir);
>   } else {
>   }
>   while (waitpid(-1, status, __WALL) !=3D pid) {
>   }
> }
>=20
> static void reset_loop()
> {
>   char buf[64];
>   snprintf(buf, sizeof(buf), "/dev/loop%llu", procid);
>   int loopfd =3D open(buf, O_RDWR);
>   if (loopfd !=3D -1) {
>     ioctl(loopfd, LOOP_CLR_FD, 0);
>     close(loopfd);
>   }
> }
>=20
> static void setup_test()
> {
>   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>   setpgrp();
>   write_file("/proc/self/oom_score_adj", "1000");
> }
>=20
> static void execute_one(void);
>=20
> #define WAIT_FLAGS __WALL
>=20
> static void loop(void)
> {
>   int iter =3D 0;
>   for (;; iter++) {
>     reset_loop();
>     int pid =3D fork();
>     if (pid < 0)
>       exit(1);
>     if (pid =3D=3D 0) {
>       setup_test();
>       execute_one();
>       exit(0);
>     }
>     int status =3D 0;
>     uint64_t start =3D current_time_ms();
>     for (;;) {
>       if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
>         break;
>       sleep_ms(1);
>       if (current_time_ms() - start < 5000)
>         continue;
>       kill_and_wait(pid, &status);
>       break;
>     }
>   }
> }
>=20
> uint64_t r[3] =3D {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffff=
ffff};
>=20
> void execute_one(void)
> {
>   intptr_t res =3D 0;
>   res =3D syscall(__NR_pipe2, 0x20000100ul, 0ul);
>   if (res !=3D -1) {
>     NONFAILING(r[0] =3D *(uint32_t*)0x20000100);
>     NONFAILING(r[1] =3D *(uint32_t*)0x20000104);
>   }
>   NONFAILING(memcpy((void*)0x20002080, "./file0\000", 8));
>   NONFAILING(syz_mount_image(0, 0x20002080, 0, 0, 0, 0, 0));
>   NONFAILING(memcpy((void*)0x200000c0,
>                     "\x15\x06\x00\x00\x65\xff\xff\x00\x00\x00\x00\x08\x00=
\x39"
>                     "\x50\x32\x30\x30\x30\x2e\x75",
>                     21));
>   syscall(__NR_write, r[1], 0x200000c0ul, 0x15ul);
>   NONFAILING(*(uint32_t*)0x200001c4 =3D 0);
>   NONFAILING(*(uint32_t*)0x200001c8 =3D 0x10);
>   NONFAILING(*(uint32_t*)0x200001cc =3D 0);
>   NONFAILING(*(uint32_t*)0x200001d0 =3D 0);
>   NONFAILING(*(uint32_t*)0x200001d8 =3D -1);
>   NONFAILING(memset((void*)0x200001dc, 0, 12));
>   res =3D syscall(__NR_io_uring_setup, 0x5ec9, 0x200001c0ul);
>   if (res !=3D -1)
>     r[2] =3D res;
>   syscall(__NR_close, r[2]);
>   NONFAILING(memcpy((void*)0x20000080, "./file0\000", 8));
>   NONFAILING(memcpy((void*)0x20000040, "9p\000", 3));
>   NONFAILING(memcpy((void*)0x20000140, "trans=3Dfd,rfdno=3D", 15));
>   NONFAILING(sprintf((char*)0x2000014f, "0x%016llx", (long long)r[0]));
>   NONFAILING(memcpy((void*)0x20000161, ",wfdno=3D", 7));
>   NONFAILING(sprintf((char*)0x20000168, "0x%016llx", (long long)r[1]));
>   syscall(__NR_mount, 0ul, 0x20000080ul, 0x20000040ul, 0ul, 0x20000140ul)=
;
> }
> int main(void)
> {
>   syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>   syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
>   syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>   install_segv_handler();
>   loop();
>   return 0;
> }

> git bisect start
> # status: waiting for both good and bad commits
> # bad: [2241ab53cbb5cdb08a6b2d4688feb13971058f65] Linux 6.2-rc5
> git bisect bad 2241ab53cbb5cdb08a6b2d4688feb13971058f65
> # status: waiting for good commit(s), bad commit known
> # good: [f40ddce88593482919761f74910f42f4b84c004b] Linux 5.11
> git bisect good f40ddce88593482919761f74910f42f4b84c004b
> # bad: [29ec39fcf11e4583eb8d5174f756ea109c77cc44] Merge tag 'powerpc-5.17=
-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect bad 29ec39fcf11e4583eb8d5174f756ea109c77cc44
> # bad: [a16d8644bad461bb073b92e812080ea6715ddf2b] Merge tag 'staging-5.14=
-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect bad a16d8644bad461bb073b92e812080ea6715ddf2b
> # bad: [625434dafdd97372d15de21972be4b682709e854] Merge tag 'for-5.13/io_=
uring-2021-04-27' of git://git.kernel.dk/linux-block
> git bisect bad 625434dafdd97372d15de21972be4b682709e854
> # good: [cf64c2a905e0dabcc473ca70baf275fb3a61fac4] Merge branch 'work.spa=
rc32' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> git bisect good cf64c2a905e0dabcc473ca70baf275fb3a61fac4
> # bad: [8900d92fd666d936a7bfb4c567ac26736a414fb4] Merge tag 'staging-5.13=
-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect bad 8900d92fd666d936a7bfb4c567ac26736a414fb4
> # bad: [9c15db92a8e56bcde0f58064ac1adc28c0579b51] Merge tag 'iio-for-5.13=
a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into stagin=
g-next
> git bisect bad 9c15db92a8e56bcde0f58064ac1adc28c0579b51
> # good: [e93aa38475d6bc5b077b3007982e5ddc071b747d] staging:rtl8712: use I=
EEE80211_FCTL_* kernel definitions
> git bisect good e93aa38475d6bc5b077b3007982e5ddc071b747d
> # bad: [6417f03132a6952cd17ddd8eaddbac92b61b17e0] module: remove never im=
plemented MODULE_SUPPORTED_DEVICE
> git bisect bad 6417f03132a6952cd17ddd8eaddbac92b61b17e0
> # good: [f0b15b6081291367634a8f3c557f7a68fdaa35e4] MAINTAINERS: exclude u=
api directories in API/ABI section
> git bisect good f0b15b6081291367634a8f3c557f7a68fdaa35e4
> # bad: [420623430a7015ae9adab8a087de82c186bc9989] Merge tag 'erofs-for-5.=
12-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
> git bisect bad 420623430a7015ae9adab8a087de82c186bc9989
> # good: [261410082d01f2f2d4fcd19abee6b8e84f399c51] Merge tag 'devprop-5.1=
2-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good 261410082d01f2f2d4fcd19abee6b8e84f399c51
> # bad: [ce307084c96d0ec92c04fcc38b107241b168df11] Merge tag 'block-5.12-2=
021-03-12-v2' of git://git.kernel.dk/linux-block
> git bisect bad ce307084c96d0ec92c04fcc38b107241b168df11
> # bad: [5c2469e0a22e035d52f3ba768151cc75e3d4a1cd] io_uring: force creatio=
n of separate context for ATTACH_WQ and non-threads
> git bisect bad 5c2469e0a22e035d52f3ba768151cc75e3d4a1cd
> # bad: [f458dd8441e56d122ddf1d8e2af0b6ee62f52af9] io_uring: fix unrelated=
 ctx reqs cancellation
> git bisect bad f458dd8441e56d122ddf1d8e2af0b6ee62f52af9
> # bad: [baf186c4d345f5a105e63df01100936ad622f369] io_uring: index io_urin=
g->xa by ctx not file
> git bisect bad baf186c4d345f5a105e63df01100936ad622f369
> # good: [2941267bd3dad018de1d51fe2cd996b7bc1e5a5d] io_uring: make del_tas=
k_file more forgiving
> git bisect good 2941267bd3dad018de1d51fe2cd996b7bc1e5a5d
> # good: [d56d938b4bef3e1421a42023cdcd6e13c1f50831] io_uring: do ctx initi=
ated file note removal
> git bisect good d56d938b4bef3e1421a42023cdcd6e13c1f50831
> # bad: [eebd2e37e662617a6b8041db75205f0a262ce870] io_uring: don't take ta=
sk ring-file notes
> git bisect bad eebd2e37e662617a6b8041db75205f0a262ce870
> # first bad commit: [eebd2e37e662617a6b8041db75205f0a262ce870] io_uring: =
don't take task ring-file notes
> |0125_025324|/root/bzimage_bisect/make_bz.sh -k /root/linux -m 2241ab53cb=
b5cdb08a6b2d4688feb13971058f65 -b eebd2e37e662617a6b8041db75205f0a262ce870 =
-d /home/bzimage -o /tmp/kernel -f /home/bzimage/bzImage_2241ab53cbb5cdb08a=
6b2d4688feb13971058f65_eebd2e37e662617a6b8041db75205f0a262ce870_revert|
> |0125_025344|FAIL|bzImage:/home/bzimage/bzImage_2241ab53cbb5cdb08a6b2d468=
8feb13971058f65_eebd2e37e662617a6b8041db75205f0a262ce870_revert does not ex=
ist:|

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86 5.18.0-rc4 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT=3D"gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10)"
> CONFIG_CC_IS_GCC=3Dy
> CONFIG_GCC_VERSION=3D80500
> CONFIG_CLANG_VERSION=3D0
> CONFIG_AS_IS_GNU=3Dy
> CONFIG_AS_VERSION=3D23601
> CONFIG_LD_IS_BFD=3Dy
> CONFIG_LD_VERSION=3D23601
> CONFIG_LLD_VERSION=3D0
> CONFIG_CC_CAN_LINK=3Dy
> CONFIG_CC_CAN_LINK_STATIC=3Dy
> CONFIG_CC_HAS_ASM_GOTO=3Dy
> CONFIG_CC_HAS_ASM_INLINE=3Dy
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=3Dy
> CONFIG_PAHOLE_VERSION=3D122
> CONFIG_IRQ_WORK=3Dy
> CONFIG_BUILDTIME_TABLE_SORT=3Dy
> CONFIG_THREAD_INFO_IN_TASK=3Dy
>=20
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=3D"-kvm"
> # CONFIG_LOCALVERSION_AUTO is not set
> CONFIG_BUILD_SALT=3D""
> CONFIG_HAVE_KERNEL_GZIP=3Dy
> CONFIG_HAVE_KERNEL_BZIP2=3Dy
> CONFIG_HAVE_KERNEL_LZMA=3Dy
> CONFIG_HAVE_KERNEL_XZ=3Dy
> CONFIG_HAVE_KERNEL_LZO=3Dy
> CONFIG_HAVE_KERNEL_LZ4=3Dy
> CONFIG_HAVE_KERNEL_ZSTD=3Dy
> CONFIG_KERNEL_GZIP=3Dy
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=3D""
> CONFIG_DEFAULT_HOSTNAME=3D"CannotLeaveINTEL"
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_SYSVIPC_SYSCTL=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> # CONFIG_WATCH_QUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=3Dy
> CONFIG_USELIB=3Dy
> CONFIG_AUDIT=3Dy
> CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
> CONFIG_AUDITSYSCALL=3Dy
>=20
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> CONFIG_GENERIC_IRQ_SHOW=3Dy
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy
> CONFIG_GENERIC_PENDING_IRQ=3Dy
> CONFIG_GENERIC_IRQ_MIGRATION=3Dy
> CONFIG_GENERIC_IRQ_INJECTION=3Dy
> CONFIG_HARDIRQS_SW_RESEND=3Dy
> CONFIG_GENERIC_IRQ_CHIP=3Dy
> CONFIG_IRQ_DOMAIN=3Dy
> CONFIG_IRQ_SIM=3Dy
> CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy
> CONFIG_GENERIC_MSI_IRQ=3Dy
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=3Dy
> CONFIG_IRQ_MSI_IOMMU=3Dy
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=3Dy
> CONFIG_IRQ_FORCED_THREADING=3Dy
> CONFIG_SPARSE_IRQ=3Dy
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
>=20
> CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
> CONFIG_ARCH_CLOCKSOURCE_INIT=3Dy
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=3Dy
> CONFIG_GENERIC_TIME_VSYSCALL=3Dy
> CONFIG_GENERIC_CLOCKEVENTS=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
> CONFIG_GENERIC_CMOS_UPDATE=3Dy
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=3Dy
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy
>=20
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=3Dy
> CONFIG_NO_HZ_COMMON=3Dy
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=3Dy
> # CONFIG_NO_HZ_FULL is not set
> CONFIG_NO_HZ=3Dy
> CONFIG_HIGH_RES_TIMERS=3Dy
> CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=3D100
> # end of Timers subsystem
>=20
> CONFIG_BPF=3Dy
> CONFIG_HAVE_EBPF_JIT=3Dy
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
>=20
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=3Dy
> CONFIG_BPF_JIT=3Dy
> CONFIG_BPF_JIT_ALWAYS_ON=3Dy
> CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
> # CONFIG_BPF_PRELOAD is not set
> # CONFIG_BPF_LSM is not set
> # end of BPF subsystem
>=20
> CONFIG_PREEMPT_BUILD=3Dy
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=3Dy
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=3Dy
> CONFIG_PREEMPTION=3Dy
> CONFIG_PREEMPT_DYNAMIC=3Dy
> # CONFIG_SCHED_CORE is not set
>=20
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=3Dy
> # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> CONFIG_TASKSTATS=3Dy
> CONFIG_TASK_DELAY_ACCT=3Dy
> CONFIG_TASK_XACCT=3Dy
> CONFIG_TASK_IO_ACCOUNTING=3Dy
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
>=20
> CONFIG_CPU_ISOLATION=3Dy
>=20
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=3Dy
> CONFIG_PREEMPT_RCU=3Dy
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=3Dy
> CONFIG_TREE_SRCU=3Dy
> CONFIG_TASKS_RCU_GENERIC=3Dy
> CONFIG_TASKS_RCU=3Dy
> CONFIG_TASKS_RUDE_RCU=3Dy
> CONFIG_TASKS_TRACE_RCU=3Dy
> CONFIG_RCU_STALL_COMMON=3Dy
> CONFIG_RCU_NEED_SEGCBLIST=3Dy
> # end of RCU Subsystem
>=20
> CONFIG_BUILD_BIN2C=3Dy
> # CONFIG_IKCONFIG is not set
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=3D18
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D14
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D13
> # CONFIG_PRINTK_INDEX is not set
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
>=20
> #
> # Scheduler features
> #
> # CONFIG_UCLAMP_TASK is not set
> # end of Scheduler features
>=20
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy
> CONFIG_CC_HAS_INT128=3Dy
> CONFIG_CC_IMPLICIT_FALLTHROUGH=3D"-Wimplicit-fallthrough=3D5"
> CONFIG_ARCH_SUPPORTS_INT128=3Dy
> CONFIG_NUMA_BALANCING=3Dy
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
> CONFIG_CGROUPS=3Dy
> CONFIG_PAGE_COUNTER=3Dy
> CONFIG_MEMCG=3Dy
> CONFIG_MEMCG_SWAP=3Dy
> CONFIG_MEMCG_KMEM=3Dy
> CONFIG_BLK_CGROUP=3Dy
> CONFIG_CGROUP_WRITEBACK=3Dy
> CONFIG_CGROUP_SCHED=3Dy
> CONFIG_FAIR_GROUP_SCHED=3Dy
> CONFIG_CFS_BANDWIDTH=3Dy
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_CGROUP_PIDS=3Dy
> CONFIG_CGROUP_RDMA=3Dy
> CONFIG_CGROUP_FREEZER=3Dy
> CONFIG_CGROUP_HUGETLB=3Dy
> CONFIG_CPUSETS=3Dy
> CONFIG_PROC_PID_CPUSET=3Dy
> CONFIG_CGROUP_DEVICE=3Dy
> CONFIG_CGROUP_CPUACCT=3Dy
> CONFIG_CGROUP_PERF=3Dy
> CONFIG_CGROUP_BPF=3Dy
> # CONFIG_CGROUP_MISC is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_SOCK_CGROUP_DATA=3Dy
> CONFIG_NAMESPACES=3Dy
> CONFIG_UTS_NS=3Dy
> CONFIG_TIME_NS=3Dy
> CONFIG_IPC_NS=3Dy
> CONFIG_USER_NS=3Dy
> CONFIG_PID_NS=3Dy
> CONFIG_NET_NS=3Dy
> CONFIG_CHECKPOINT_RESTORE=3Dy
> CONFIG_SCHED_AUTOGROUP=3Dy
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=3Dy
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D""
> CONFIG_RD_GZIP=3Dy
> CONFIG_RD_BZIP2=3Dy
> CONFIG_RD_LZMA=3Dy
> CONFIG_RD_XZ=3Dy
> CONFIG_RD_LZO=3Dy
> CONFIG_RD_LZ4=3Dy
> CONFIG_RD_ZSTD=3Dy
> # CONFIG_BOOT_CONFIG is not set
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=3Dy
> CONFIG_SYSCTL=3Dy
> CONFIG_HAVE_UID16=3Dy
> CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
> CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
> CONFIG_EXPERT=3Dy
> CONFIG_UID16=3Dy
> CONFIG_MULTIUSER=3Dy
> CONFIG_SGETMASK_SYSCALL=3Dy
> CONFIG_SYSFS_SYSCALL=3Dy
> CONFIG_FHANDLE=3Dy
> CONFIG_POSIX_TIMERS=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_PCSPKR_PLATFORM=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_FUTEX_PI=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SIGNALFD=3Dy
> CONFIG_TIMERFD=3Dy
> CONFIG_EVENTFD=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_AIO=3Dy
> CONFIG_IO_URING=3Dy
> CONFIG_ADVISE_SYSCALLS=3Dy
> CONFIG_HAVE_ARCH_USERFAULTFD_WP=3Dy
> CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=3Dy
> CONFIG_MEMBARRIER=3Dy
> CONFIG_KALLSYMS=3Dy
> CONFIG_KALLSYMS_ALL=3Dy
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=3Dy
> CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
> CONFIG_USERFAULTFD=3Dy
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=3Dy
> CONFIG_KCMP=3Dy
> CONFIG_RSEQ=3Dy
> # CONFIG_DEBUG_RSEQ is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=3Dy
> CONFIG_GUEST_PERF_EVENTS=3Dy
> CONFIG_PC104=3Dy
>=20
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=3Dy
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
>=20
> CONFIG_VM_EVENT_COUNTERS=3Dy
> CONFIG_SLUB_DEBUG=3Dy
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=3Dy
> # CONFIG_SLOB is not set
> CONFIG_SLAB_MERGE_DEFAULT=3Dy
> CONFIG_SLAB_FREELIST_RANDOM=3Dy
> CONFIG_SLAB_FREELIST_HARDENED=3Dy
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=3Dy
> CONFIG_SLUB_CPU_PARTIAL=3Dy
> CONFIG_SYSTEM_DATA_VERIFICATION=3Dy
> CONFIG_PROFILING=3Dy
> CONFIG_TRACEPOINTS=3Dy
> # end of General setup
>=20
> CONFIG_64BIT=3Dy
> CONFIG_X86_64=3Dy
> CONFIG_X86=3Dy
> CONFIG_INSTRUCTION_DECODER=3Dy
> CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
> CONFIG_LOCKDEP_SUPPORT=3Dy
> CONFIG_STACKTRACE_SUPPORT=3Dy
> CONFIG_MMU=3Dy
> CONFIG_ARCH_MMAP_RND_BITS_MIN=3D28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=3D32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16
> CONFIG_GENERIC_ISA_DMA=3Dy
> CONFIG_GENERIC_BUG=3Dy
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
> CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_ARCH_HAS_CPU_RELAX=3Dy
> CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
> CONFIG_ARCH_NR_GPIO=3D1024
> CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> CONFIG_AUDIT_ARCH=3Dy
> CONFIG_HAVE_INTEL_TXT=3Dy
> CONFIG_X86_64_SMP=3Dy
> CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
> CONFIG_FIX_EARLYCON_MEM=3Dy
> CONFIG_DYNAMIC_PHYSICAL_MASK=3Dy
> CONFIG_PGTABLE_LEVELS=3D5
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=3Dy
>=20
> #
> # Processor type and features
> #
> CONFIG_SMP=3Dy
> CONFIG_X86_FEATURE_NAMES=3Dy
> CONFIG_X86_X2APIC=3Dy
> CONFIG_X86_MPPARSE=3Dy
> # CONFIG_GOLDFISH is not set
> CONFIG_RETPOLINE=3Dy
> CONFIG_X86_CPU_RESCTRL=3Dy
> CONFIG_X86_EXTENDED_PLATFORM=3Dy
> CONFIG_X86_NUMACHIP=3Dy
> # CONFIG_X86_VSMP is not set
> # CONFIG_X86_UV is not set
> # CONFIG_X86_GOLDFISH is not set
> # CONFIG_X86_INTEL_MID is not set
> CONFIG_X86_INTEL_LPSS=3Dy
> CONFIG_X86_AMD_PLATFORM_DEVICE=3Dy
> CONFIG_IOSF_MBI=3Dy
> CONFIG_IOSF_MBI_DEBUG=3Dy
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
> CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
> CONFIG_HYPERVISOR_GUEST=3Dy
> CONFIG_PARAVIRT=3Dy
> CONFIG_PARAVIRT_XXL=3Dy
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_PARAVIRT_SPINLOCKS=3Dy
> CONFIG_X86_HV_CALLBACK_VECTOR=3Dy
> CONFIG_XEN=3Dy
> CONFIG_XEN_PV=3Dy
> CONFIG_XEN_512GB=3Dy
> CONFIG_XEN_PV_SMP=3Dy
> CONFIG_XEN_PV_DOM0=3Dy
> CONFIG_XEN_PVHVM=3Dy
> CONFIG_XEN_PVHVM_SMP=3Dy
> CONFIG_XEN_PVHVM_GUEST=3Dy
> CONFIG_XEN_SAVE_RESTORE=3Dy
> # CONFIG_XEN_DEBUG_FS is not set
> CONFIG_XEN_PVH=3Dy
> CONFIG_XEN_DOM0=3Dy
> CONFIG_KVM_GUEST=3Dy
> CONFIG_ARCH_CPUIDLE_HALTPOLL=3Dy
> CONFIG_PVH=3Dy
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=3Dy
> CONFIG_JAILHOUSE_GUEST=3Dy
> CONFIG_ACRN_GUEST=3Dy
> # CONFIG_INTEL_TDX_GUEST is not set
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=3Dy
> CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
> CONFIG_X86_L1_CACHE_SHIFT=3D6
> CONFIG_X86_TSC=3Dy
> CONFIG_X86_CMPXCHG64=3Dy
> CONFIG_X86_CMOV=3Dy
> CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
> CONFIG_X86_DEBUGCTLMSR=3Dy
> CONFIG_IA32_FEAT_CTL=3Dy
> CONFIG_X86_VMX_FEATURE_NAMES=3Dy
> CONFIG_PROCESSOR_SELECT=3Dy
> CONFIG_CPU_SUP_INTEL=3Dy
> CONFIG_CPU_SUP_AMD=3Dy
> CONFIG_CPU_SUP_HYGON=3Dy
> CONFIG_CPU_SUP_CENTAUR=3Dy
> CONFIG_CPU_SUP_ZHAOXIN=3Dy
> CONFIG_HPET_TIMER=3Dy
> CONFIG_HPET_EMULATE_RTC=3Dy
> CONFIG_DMI=3Dy
> CONFIG_GART_IOMMU=3Dy
> CONFIG_MAXSMP=3Dy
> CONFIG_NR_CPUS_RANGE_BEGIN=3D8192
> CONFIG_NR_CPUS_RANGE_END=3D8192
> CONFIG_NR_CPUS_DEFAULT=3D8192
> CONFIG_NR_CPUS=3D8192
> CONFIG_SCHED_CLUSTER=3Dy
> CONFIG_SCHED_SMT=3Dy
> CONFIG_SCHED_MC=3Dy
> CONFIG_SCHED_MC_PRIO=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_X86_IO_APIC=3Dy
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
> CONFIG_X86_MCE=3Dy
> CONFIG_X86_MCELOG_LEGACY=3Dy
> CONFIG_X86_MCE_INTEL=3Dy
> CONFIG_X86_MCE_AMD=3Dy
> CONFIG_X86_MCE_THRESHOLD=3Dy
> CONFIG_X86_MCE_INJECT=3Dm
>=20
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=3Dy
> CONFIG_PERF_EVENTS_INTEL_RAPL=3Dm
> CONFIG_PERF_EVENTS_INTEL_CSTATE=3Dm
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> CONFIG_PERF_EVENTS_AMD_UNCORE=3Dy
> # end of Performance monitoring
>=20
> CONFIG_X86_16BIT=3Dy
> CONFIG_X86_ESPFIX64=3Dy
> CONFIG_X86_VSYSCALL_EMULATION=3Dy
> CONFIG_X86_IOPL_IOPERM=3Dy
> CONFIG_MICROCODE=3Dy
> CONFIG_MICROCODE_INTEL=3Dy
> CONFIG_MICROCODE_AMD=3Dy
> CONFIG_MICROCODE_OLD_INTERFACE=3Dy
> CONFIG_X86_MSR=3Dy
> CONFIG_X86_CPUID=3Dy
> CONFIG_X86_5LEVEL=3Dy
> CONFIG_X86_DIRECT_GBPAGES=3Dy
> # CONFIG_X86_CPA_STATISTICS is not set
> CONFIG_X86_MEM_ENCRYPT=3Dy
> CONFIG_AMD_MEM_ENCRYPT=3Dy
> # CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
> CONFIG_NUMA=3Dy
> CONFIG_AMD_NUMA=3Dy
> CONFIG_X86_64_ACPI_NUMA=3Dy
> CONFIG_NUMA_EMU=3Dy
> CONFIG_NODES_SHIFT=3D10
> CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
> CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
> CONFIG_ARCH_MEMORY_PROBE=3Dy
> CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
> CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
> CONFIG_X86_PMEM_LEGACY_DEVICE=3Dy
> CONFIG_X86_PMEM_LEGACY=3Dy
> CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
> CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=3Dy
> CONFIG_MTRR=3Dy
> CONFIG_MTRR_SANITIZER=3Dy
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D1
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
> CONFIG_X86_PAT=3Dy
> CONFIG_ARCH_USES_PG_UNCACHED=3Dy
> CONFIG_ARCH_RANDOM=3Dy
> CONFIG_X86_SMAP=3Dy
> CONFIG_X86_UMIP=3Dy
> CONFIG_CC_HAS_IBT=3Dy
> CONFIG_X86_KERNEL_IBT=3Dy
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy
> CONFIG_X86_USER_INTERRUPTS=3Dy
> # CONFIG_X86_INTEL_TSX_MODE_OFF is not set
> CONFIG_X86_INTEL_TSX_MODE_ON=3Dy
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> CONFIG_X86_SGX=3Dy
> CONFIG_INTEL_TDX_HOST=3Dy
> # CONFIG_INTEL_TDX_HOST_DEBUG is not set
> CONFIG_EFI=3Dy
> CONFIG_EFI_STUB=3Dy
> CONFIG_EFI_MIXED=3Dy
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=3Dy
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=3D250
> CONFIG_SCHED_HRTICK=3Dy
> CONFIG_KEXEC=3Dy
> CONFIG_KEXEC_FILE=3Dy
> CONFIG_ARCH_HAS_KEXEC_PURGATORY=3Dy
> # CONFIG_KEXEC_SIG is not set
> CONFIG_CRASH_DUMP=3Dy
> CONFIG_KEXEC_JUMP=3Dy
> CONFIG_PHYSICAL_START=3D0x1000000
> CONFIG_RELOCATABLE=3Dy
> # CONFIG_RANDOMIZE_BASE is not set
> CONFIG_PHYSICAL_ALIGN=3D0x200000
> CONFIG_DYNAMIC_MEMORY_LAYOUT=3Dy
> CONFIG_HOTPLUG_CPU=3Dy
> CONFIG_BOOTPARAM_HOTPLUG_CPU0=3Dy
> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> # CONFIG_COMPAT_VDSO is not set
> # CONFIG_LEGACY_VSYSCALL_EMULATE is not set
> CONFIG_LEGACY_VSYSCALL_XONLY=3Dy
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> CONFIG_CMDLINE_BOOL=3Dy
> CONFIG_CMDLINE=3D"net.ifnames=3D0"
> # CONFIG_CMDLINE_OVERRIDE is not set
> CONFIG_MODIFY_LDT_SYSCALL=3Dy
> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> CONFIG_HAVE_LIVEPATCH=3Dy
> CONFIG_LIVEPATCH=3Dy
> # end of Processor type and features
>=20
> CONFIG_ARCH_HAS_ADD_PAGES=3Dy
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=3Dy
>=20
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=3Dy
> CONFIG_SUSPEND=3Dy
> CONFIG_SUSPEND_FREEZER=3Dy
> # CONFIG_SUSPEND_SKIP_SYNC is not set
> CONFIG_HIBERNATE_CALLBACKS=3Dy
> CONFIG_HIBERNATION=3Dy
> CONFIG_HIBERNATION_SNAPSHOT_DEV=3Dy
> CONFIG_PM_STD_PARTITION=3D""
> CONFIG_PM_SLEEP=3Dy
> CONFIG_PM_SLEEP_SMP=3Dy
> # CONFIG_PM_AUTOSLEEP is not set
> CONFIG_PM_WAKELOCKS=3Dy
> CONFIG_PM_WAKELOCKS_LIMIT=3D100
> CONFIG_PM_WAKELOCKS_GC=3Dy
> CONFIG_PM=3Dy
> CONFIG_PM_DEBUG=3Dy
> CONFIG_PM_ADVANCED_DEBUG=3Dy
> # CONFIG_PM_TEST_SUSPEND is not set
> CONFIG_PM_SLEEP_DEBUG=3Dy
> # CONFIG_DPM_WATCHDOG is not set
> CONFIG_PM_TRACE=3Dy
> CONFIG_PM_TRACE_RTC=3Dy
> CONFIG_PM_CLK=3Dy
> CONFIG_PM_GENERIC_DOMAINS=3Dy
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=3Dy
> CONFIG_PM_GENERIC_DOMAINS_SLEEP=3Dy
> CONFIG_PM_GENERIC_DOMAINS_OF=3Dy
> CONFIG_ENERGY_MODEL=3Dy
> CONFIG_ARCH_SUPPORTS_ACPI=3Dy
> CONFIG_ACPI=3Dy
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=3Dy
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=3Dy
> CONFIG_ACPI_TABLE_LIB=3Dy
> CONFIG_ACPI_DEBUGGER=3Dy
> CONFIG_ACPI_DEBUGGER_USER=3Dy
> CONFIG_ACPI_SPCR_TABLE=3Dy
> # CONFIG_ACPI_FPDT is not set
> CONFIG_ACPI_LPIT=3Dy
> CONFIG_ACPI_SLEEP=3Dy
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy
> CONFIG_ACPI_EC_DEBUGFS=3Dm
> CONFIG_ACPI_AC=3Dy
> CONFIG_ACPI_BATTERY=3Dy
> CONFIG_ACPI_BUTTON=3Dy
> CONFIG_ACPI_VIDEO=3Dy
> CONFIG_ACPI_FAN=3Dy
> CONFIG_ACPI_TAD=3Dm
> CONFIG_ACPI_DOCK=3Dy
> CONFIG_ACPI_CPU_FREQ_PSS=3Dy
> CONFIG_ACPI_PROCESSOR_CSTATE=3Dy
> CONFIG_ACPI_PROCESSOR_IDLE=3Dy
> CONFIG_ACPI_CPPC_LIB=3Dy
> CONFIG_ACPI_PROCESSOR=3Dy
> CONFIG_ACPI_IPMI=3Dy
> CONFIG_ACPI_HOTPLUG_CPU=3Dy
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=3Dm
> CONFIG_ACPI_THERMAL=3Dy
> CONFIG_ACPI_PLATFORM_PROFILE=3Dm
> CONFIG_ACPI_CUSTOM_DSDT_FILE=3D""
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy
> CONFIG_ACPI_TABLE_UPGRADE=3Dy
> CONFIG_ACPI_DEBUG=3Dy
> CONFIG_ACPI_PCI_SLOT=3Dy
> CONFIG_ACPI_CONTAINER=3Dy
> CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
> CONFIG_ACPI_HOTPLUG_IOAPIC=3Dy
> CONFIG_ACPI_SBS=3Dm
> CONFIG_ACPI_HED=3Dy
> CONFIG_ACPI_CUSTOM_METHOD=3Dy
> CONFIG_ACPI_BGRT=3Dy
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> CONFIG_ACPI_NFIT=3Dm
> # CONFIG_NFIT_SECURITY_DEBUG is not set
> CONFIG_ACPI_NUMA=3Dy
> CONFIG_ACPI_HMAT=3Dy
> CONFIG_HAVE_ACPI_APEI=3Dy
> CONFIG_HAVE_ACPI_APEI_NMI=3Dy
> CONFIG_ACPI_APEI=3Dy
> CONFIG_ACPI_APEI_GHES=3Dy
> CONFIG_ACPI_APEI_PCIEAER=3Dy
> CONFIG_ACPI_APEI_MEMORY_FAILURE=3Dy
> CONFIG_ACPI_APEI_EINJ=3Dm
> CONFIG_ACPI_APEI_ERST_DEBUG=3Dy
> CONFIG_ACPI_DPTF=3Dy
> CONFIG_DPTF_POWER=3Dy
> CONFIG_DPTF_PCH_FIVR=3Dy
> CONFIG_ACPI_WATCHDOG=3Dy
> CONFIG_ACPI_EXTLOG=3Dm
> CONFIG_ACPI_ADXL=3Dy
> CONFIG_ACPI_CONFIGFS=3Dy
> # CONFIG_ACPI_PFRUT is not set
> CONFIG_ACPI_PCC=3Dy
> CONFIG_PMIC_OPREGION=3Dy
> # CONFIG_BYTCRC_PMIC_OPREGION is not set
> # CONFIG_CHTCRC_PMIC_OPREGION is not set
> # CONFIG_XPOWER_PMIC_OPREGION is not set
> CONFIG_BXT_WC_PMIC_OPREGION=3Dy
> # CONFIG_CHT_DC_TI_PMIC_OPREGION is not set
> CONFIG_X86_PM_TIMER=3Dy
> CONFIG_ACPI_PRMT=3Dy
>=20
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=3Dy
> CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
> CONFIG_CPU_FREQ_GOV_COMMON=3Dy
> CONFIG_CPU_FREQ_STAT=3Dy
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
> CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
> CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
>=20
> #
> # CPU frequency scaling drivers
> #
> # CONFIG_CPUFREQ_DT is not set
> CONFIG_X86_INTEL_PSTATE=3Dy
> CONFIG_X86_PCC_CPUFREQ=3Dy
> # CONFIG_X86_AMD_PSTATE is not set
> CONFIG_X86_ACPI_CPUFREQ=3Dm
> CONFIG_X86_ACPI_CPUFREQ_CPB=3Dy
> CONFIG_X86_POWERNOW_K8=3Dm
> CONFIG_X86_AMD_FREQ_SENSITIVITY=3Dm
> CONFIG_X86_SPEEDSTEP_CENTRINO=3Dy
> CONFIG_X86_P4_CLOCKMOD=3Dm
>=20
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=3Dm
> # end of CPU Frequency scaling
>=20
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=3Dy
> CONFIG_CPU_IDLE_GOV_LADDER=3Dy
> CONFIG_CPU_IDLE_GOV_MENU=3Dy
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> CONFIG_HALTPOLL_CPUIDLE=3Dy
> # end of CPU Idle
>=20
> CONFIG_INTEL_IDLE=3Dy
> # end of Power management and ACPI options
>=20
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_PCI_MMCONFIG=3Dy
> CONFIG_PCI_XEN=3Dy
> CONFIG_MMCONF_FAM10H=3Dy
> # CONFIG_PCI_CNB20LE_QUIRK is not set
> CONFIG_ISA_BUS=3Dy
> CONFIG_ISA_DMA_API=3Dy
> CONFIG_AMD_NB=3Dy
> # end of Bus options (PCI etc.)
>=20
> #
> # Binary Emulations
> #
> CONFIG_IA32_EMULATION=3Dy
> # CONFIG_X86_X32_ABI is not set
> CONFIG_COMPAT_32=3Dy
> CONFIG_COMPAT=3Dy
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
> CONFIG_SYSVIPC_COMPAT=3Dy
> # end of Binary Emulations
>=20
> CONFIG_HAVE_KVM=3Dy
> CONFIG_HAVE_KVM_PFNCACHE=3Dy
> CONFIG_HAVE_KVM_IRQCHIP=3Dy
> CONFIG_HAVE_KVM_IRQFD=3Dy
> CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
> CONFIG_HAVE_KVM_DIRTY_RING=3Dy
> CONFIG_HAVE_KVM_EVENTFD=3Dy
> CONFIG_KVM_MMIO=3Dy
> CONFIG_KVM_ASYNC_PF=3Dy
> CONFIG_HAVE_KVM_MSI=3Dy
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
> CONFIG_KVM_VFIO=3Dy
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
> CONFIG_KVM_COMPAT=3Dy
> CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
> CONFIG_HAVE_KVM_NO_POLL=3Dy
> CONFIG_KVM_XFER_TO_GUEST_WORK=3Dy
> CONFIG_HAVE_KVM_PM_NOTIFIER=3Dy
> CONFIG_VIRTUALIZATION=3Dy
> CONFIG_KVM=3Dm
> CONFIG_KVM_WERROR=3Dy
> CONFIG_KVM_INTEL=3Dm
> CONFIG_X86_SGX_KVM=3Dy
> CONFIG_KVM_AMD=3Dm
> CONFIG_KVM_AMD_SEV=3Dy
> # CONFIG_KVM_XEN is not set
> CONFIG_KVM_EXTERNAL_WRITE_TRACKING=3Dy
> CONFIG_KVM_MMU_PRIVATE=3Dy
> CONFIG_AS_AVX512=3Dy
> CONFIG_AS_SHA1_NI=3Dy
> CONFIG_AS_SHA256_NI=3Dy
> CONFIG_AS_TPAUSE=3Dy
>=20
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=3Dy
> CONFIG_KEXEC_CORE=3Dy
> CONFIG_HOTPLUG_SMT=3Dy
> CONFIG_GENERIC_ENTRY=3Dy
> CONFIG_KPROBES=3Dy
> CONFIG_JUMP_LABEL=3Dy
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_OPTPROBES=3Dy
> CONFIG_KPROBES_ON_FTRACE=3Dy
> CONFIG_UPROBES=3Dy
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy
> CONFIG_KRETPROBES=3Dy
> CONFIG_KRETPROBE_ON_RETHOOK=3Dy
> CONFIG_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_IOREMAP_PROT=3Dy
> CONFIG_HAVE_KPROBES=3Dy
> CONFIG_HAVE_KRETPROBES=3Dy
> CONFIG_HAVE_OPTPROBES=3Dy
> CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=3Dy
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy
> CONFIG_HAVE_NMI=3Dy
> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
> CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
> CONFIG_ARCH_HAS_SET_MEMORY=3Dy
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=3Dy
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy
> CONFIG_ARCH_WANTS_NO_INSTR=3Dy
> CONFIG_HAVE_ASM_MODVERSIONS=3Dy
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> CONFIG_HAVE_RSEQ=3Dy
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=3Dy
> CONFIG_HAVE_HW_BREAKPOINT=3Dy
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
> CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy
> CONFIG_HAVE_PERF_REGS=3Dy
> CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy
> CONFIG_MMU_GATHER_TABLE_FREE=3Dy
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy
> CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
> CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
> CONFIG_HAVE_ARCH_SECCOMP=3Dy
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
> CONFIG_SECCOMP=3Dy
> CONFIG_SECCOMP_FILTER=3Dy
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=3Dy
> CONFIG_HAVE_STACKPROTECTOR=3Dy
> CONFIG_STACKPROTECTOR=3Dy
> CONFIG_STACKPROTECTOR_STRONG=3Dy
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=3Dy
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=3Dy
> CONFIG_LTO_NONE=3Dy
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy
> CONFIG_HAVE_CONTEXT_TRACKING=3Dy
> CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=3Dy
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
> CONFIG_HAVE_MOVE_PUD=3Dy
> CONFIG_HAVE_MOVE_PMD=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy
> CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
> CONFIG_HAVE_ARCH_HUGE_VMALLOC=3Dy
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
> CONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
> CONFIG_MODULES_USE_ELF_RELA=3Dy
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=3Dy
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
> CONFIG_HAVE_EXIT_THREAD=3Dy
> CONFIG_ARCH_MMAP_RND_BITS=3D28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=3Dy
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=3Dy
> CONFIG_HAVE_STACK_VALIDATION=3Dy
> CONFIG_HAVE_RELIABLE_STACKTRACE=3Dy
> CONFIG_ISA_BUS_API=3Dy
> CONFIG_OLD_SIGSUSPEND3=3Dy
> CONFIG_COMPAT_OLD_SIGACTION=3Dy
> CONFIG_COMPAT_32BIT_TIME=3Dy
> CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
> CONFIG_VMAP_STACK=3Dy
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=3Dy
> CONFIG_RANDOMIZE_KSTACK_OFFSET=3Dy
> # CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
> CONFIG_STRICT_KERNEL_RWX=3Dy
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy
> CONFIG_STRICT_MODULE_RWX=3Dy
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=3Dy
> CONFIG_ARCH_USE_MEMREMAP_PROT=3Dy
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy
> CONFIG_ARCH_HAS_CC_PLATFORM=3Dy
> CONFIG_HAVE_STATIC_CALL=3Dy
> CONFIG_HAVE_STATIC_CALL_INLINE=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=3Dy
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=3Dy
> CONFIG_ARCH_HAS_ELFCORE_COMPAT=3Dy
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=3Dy
> CONFIG_DYNAMIC_SIGFRAME=3Dy
> CONFIG_HAVE_ARCH_NODE_DEV_GROUP=3Dy
>=20
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
> # end of GCOV-based kernel profiling
>=20
> CONFIG_HAVE_GCC_PLUGINS=3Dy
> # end of General architecture-dependent options
>=20
> CONFIG_RT_MUTEXES=3Dy
> CONFIG_BASE_SMALL=3D0
> CONFIG_MODULES=3Dy
> # CONFIG_MODULE_FORCE_LOAD is not set
> CONFIG_MODULE_UNLOAD=3Dy
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> CONFIG_MODULE_SRCVERSION_ALL=3Dy
> # CONFIG_MODULE_SIG is not set
> CONFIG_MODULE_COMPRESS_NONE=3Dy
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH=3D"/sbin/modprobe"
> # CONFIG_TRIM_UNUSED_KSYMS is not set
> CONFIG_MODULES_TREE_LOOKUP=3Dy
> CONFIG_BLOCK=3Dy
> CONFIG_BLOCK_LEGACY_AUTOLOAD=3Dy
> CONFIG_BLK_CGROUP_RWSTAT=3Dy
> CONFIG_BLK_DEV_BSG_COMMON=3Dy
> CONFIG_BLK_ICQ=3Dy
> CONFIG_BLK_DEV_BSGLIB=3Dy
> CONFIG_BLK_DEV_INTEGRITY=3Dy
> CONFIG_BLK_DEV_INTEGRITY_T10=3Dy
> CONFIG_BLK_DEV_ZONED=3Dy
> CONFIG_BLK_DEV_THROTTLING=3Dy
> # CONFIG_BLK_DEV_THROTTLING_LOW is not set
> CONFIG_BLK_WBT=3Dy
> CONFIG_BLK_WBT_MQ=3Dy
> # CONFIG_BLK_CGROUP_IOLATENCY is not set
> # CONFIG_BLK_CGROUP_FC_APPID is not set
> # CONFIG_BLK_CGROUP_IOCOST is not set
> # CONFIG_BLK_CGROUP_IOPRIO is not set
> CONFIG_BLK_DEBUG_FS=3Dy
> CONFIG_BLK_DEBUG_FS_ZONED=3Dy
> CONFIG_BLK_SED_OPAL=3Dy
> CONFIG_BLK_INLINE_ENCRYPTION=3Dy
> # CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set
>=20
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=3Dy
> # CONFIG_ACORN_PARTITION is not set
> CONFIG_AIX_PARTITION=3Dy
> CONFIG_OSF_PARTITION=3Dy
> CONFIG_AMIGA_PARTITION=3Dy
> CONFIG_ATARI_PARTITION=3Dy
> CONFIG_MAC_PARTITION=3Dy
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_BSD_DISKLABEL=3Dy
> CONFIG_MINIX_SUBPARTITION=3Dy
> CONFIG_SOLARIS_X86_PARTITION=3Dy
> CONFIG_UNIXWARE_DISKLABEL=3Dy
> CONFIG_LDM_PARTITION=3Dy
> # CONFIG_LDM_DEBUG is not set
> CONFIG_SGI_PARTITION=3Dy
> CONFIG_ULTRIX_PARTITION=3Dy
> CONFIG_SUN_PARTITION=3Dy
> CONFIG_KARMA_PARTITION=3Dy
> CONFIG_EFI_PARTITION=3Dy
> CONFIG_SYSV68_PARTITION=3Dy
> CONFIG_CMDLINE_PARTITION=3Dy
> # end of Partition Types
>=20
> CONFIG_BLOCK_COMPAT=3Dy
> CONFIG_BLK_MQ_PCI=3Dy
> CONFIG_BLK_MQ_VIRTIO=3Dy
> CONFIG_BLK_MQ_RDMA=3Dy
> CONFIG_BLK_PM=3Dy
> CONFIG_BLOCK_HOLDER_DEPRECATED=3Dy
> CONFIG_BLK_MQ_STACKING=3Dy
>=20
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> CONFIG_MQ_IOSCHED_KYBER=3Dm
> CONFIG_IOSCHED_BFQ=3Dy
> CONFIG_BFQ_GROUP_IOSCHED=3Dy
> # CONFIG_BFQ_CGROUP_DEBUG is not set
> # end of IO Schedulers
>=20
> CONFIG_PREEMPT_NOTIFIERS=3Dy
> CONFIG_PADATA=3Dy
> CONFIG_ASN1=3Dy
> CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
> CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
> CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
> CONFIG_LOCK_SPIN_ON_OWNER=3Dy
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy
> CONFIG_QUEUED_SPINLOCKS=3Dy
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy
> CONFIG_QUEUED_RWLOCKS=3Dy
> # CONFIG_SVOS is not set
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=3Dy
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=3Dy
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=3Dy
> CONFIG_FREEZER=3Dy
>=20
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_COMPAT_BINFMT_ELF=3Dy
> CONFIG_ELFCORE=3Dy
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> CONFIG_BINFMT_SCRIPT=3Dy
> CONFIG_BINFMT_MISC=3Dy
> CONFIG_COREDUMP=3Dy
> # end of Executable file formats
>=20
> #
> # Memory Management options
> #
> CONFIG_SPARSEMEM=3Dy
> CONFIG_SPARSEMEM_EXTREME=3Dy
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
> CONFIG_SPARSEMEM_VMEMMAP=3Dy
> CONFIG_HAVE_FAST_GUP=3Dy
> CONFIG_NUMA_KEEP_MEMINFO=3Dy
> CONFIG_MEMORY_ISOLATION=3Dy
> CONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
> CONFIG_MEMORY_HOTPLUG=3Dy
> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
> CONFIG_MEMORY_HOTREMOVE=3Dy
> CONFIG_MHP_MEMMAP_ON_MEMORY=3Dy
> CONFIG_SPLIT_PTLOCK_CPUS=3D4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy
> CONFIG_MEMORY_BALLOON=3Dy
> CONFIG_BALLOON_COMPACTION=3Dy
> CONFIG_COMPACTION=3Dy
> CONFIG_PAGE_REPORTING=3Dy
> CONFIG_MIGRATION=3Dy
> CONFIG_DEVICE_MIGRATION=3Dy
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3Dy
> CONFIG_ARCH_ENABLE_THP_MIGRATION=3Dy
> CONFIG_CONTIG_ALLOC=3Dy
> CONFIG_PHYS_ADDR_T_64BIT=3Dy
> CONFIG_VIRT_TO_BUS=3Dy
> CONFIG_MMU_NOTIFIER=3Dy
> CONFIG_KSM=3Dy
> CONFIG_DEFAULT_MMAP_MIN_ADDR=3D65536
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
> CONFIG_MEMORY_FAILURE=3Dy
> CONFIG_HWPOISON_INJECT=3Dm
> CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=3Dy
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy
> CONFIG_ARCH_WANTS_THP_SWAP=3Dy
> CONFIG_THP_SWAP=3Dy
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
> CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy
> CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
> CONFIG_FRONTSWAP=3Dy
> CONFIG_CMA=3Dy
> # CONFIG_CMA_DEBUG is not set
> # CONFIG_CMA_DEBUGFS is not set
> # CONFIG_CMA_SYSFS is not set
> CONFIG_CMA_AREAS=3D7
> CONFIG_MEM_SOFT_DIRTY=3Dy
> CONFIG_ZSWAP=3Dy
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=3Dy
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT=3D"lzo"
> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=3Dy
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> CONFIG_ZSWAP_ZPOOL_DEFAULT=3D"zbud"
> # CONFIG_ZSWAP_DEFAULT_ON is not set
> CONFIG_ZPOOL=3Dy
> CONFIG_ZBUD=3Dy
> CONFIG_Z3FOLD=3Dm
> CONFIG_ZSMALLOC=3Dy
> # CONFIG_ZSMALLOC_STAT is not set
> CONFIG_GENERIC_EARLY_IOREMAP=3Dy
> # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> CONFIG_PAGE_IDLE_FLAG=3Dy
> CONFIG_IDLE_PAGE_TRACKING=3Dy
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
> CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=3Dy
> CONFIG_ARCH_HAS_FILTER_PGPROT=3Dy
> CONFIG_ARCH_HAS_PTE_DEVMAP=3Dy
> CONFIG_ARCH_HAS_ZONE_DMA_SET=3Dy
> CONFIG_ZONE_DMA=3Dy
> CONFIG_ZONE_DMA32=3Dy
> CONFIG_ZONE_DEVICE=3Dy
> # CONFIG_DEVMAP_ACCESS_PROTECTION is not set
> CONFIG_HMM_MIRROR=3Dy
> CONFIG_DEVICE_PRIVATE=3Dy
> CONFIG_VMAP_PFN=3Dy
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy
> CONFIG_ARCH_HAS_PKEYS=3Dy
> CONFIG_ARCH_HAS_SUPERVISOR_PKEYS=3Dy
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> # CONFIG_READ_ONLY_THP_FOR_FS is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=3Dy
> CONFIG_MAPPING_DIRTY_HELPERS=3Dy
> CONFIG_SECRETMEM=3Dy
> # CONFIG_ANON_VMA_NAME is not set
> CONFIG_MEMFILE_NOTIFIER=3Dy
>=20
> #
> # Data Access Monitoring
> #
> # CONFIG_DAMON is not set
> # end of Data Access Monitoring
> # end of Memory Management options
>=20
> CONFIG_NET=3Dy
> CONFIG_COMPAT_NETLINK_MESSAGES=3Dy
> CONFIG_NET_INGRESS=3Dy
> CONFIG_NET_EGRESS=3Dy
> CONFIG_NET_REDIRECT=3Dy
> CONFIG_SKB_EXTENSIONS=3Dy
>=20
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_DIAG=3Dm
> CONFIG_UNIX=3Dy
> CONFIG_UNIX_SCM=3Dy
> CONFIG_AF_UNIX_OOB=3Dy
> CONFIG_UNIX_DIAG=3Dm
> CONFIG_TLS=3Dm
> # CONFIG_TLS_DEVICE is not set
> # CONFIG_TLS_TOE is not set
> CONFIG_XFRM=3Dy
> CONFIG_XFRM_OFFLOAD=3Dy
> CONFIG_XFRM_ALGO=3Dm
> CONFIG_XFRM_USER=3Dm
> # CONFIG_XFRM_USER_COMPAT is not set
> # CONFIG_XFRM_INTERFACE is not set
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_XFRM_MIGRATE is not set
> CONFIG_XFRM_STATISTICS=3Dy
> CONFIG_XFRM_AH=3Dm
> CONFIG_XFRM_ESP=3Dm
> CONFIG_XFRM_IPCOMP=3Dm
> CONFIG_NET_KEY=3Dm
> # CONFIG_NET_KEY_MIGRATE is not set
> CONFIG_SMC=3Dm
> CONFIG_SMC_DIAG=3Dm
> # CONFIG_XDP_SOCKETS is not set
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_IP_FIB_TRIE_STATS=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> CONFIG_IP_ROUTE_VERBOSE=3Dy
> CONFIG_IP_ROUTE_CLASSID=3Dy
> CONFIG_IP_PNP=3Dy
> CONFIG_IP_PNP_DHCP=3Dy
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> CONFIG_NET_IPIP=3Dm
> CONFIG_NET_IPGRE_DEMUX=3Dm
> CONFIG_NET_IP_TUNNEL=3Dm
> CONFIG_NET_IPGRE=3Dm
> CONFIG_NET_IPGRE_BROADCAST=3Dy
> CONFIG_IP_MROUTE_COMMON=3Dy
> CONFIG_IP_MROUTE=3Dy
> # CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
> CONFIG_IP_PIMSM_V1=3Dy
> CONFIG_IP_PIMSM_V2=3Dy
> CONFIG_SYN_COOKIES=3Dy
> CONFIG_NET_IPVTI=3Dm
> CONFIG_NET_UDP_TUNNEL=3Dm
> CONFIG_NET_FOU=3Dm
> CONFIG_NET_FOU_IP_TUNNELS=3Dy
> CONFIG_INET_AH=3Dm
> CONFIG_INET_ESP=3Dm
> CONFIG_INET_ESP_OFFLOAD=3Dm
> # CONFIG_INET_ESPINTCP is not set
> CONFIG_INET_IPCOMP=3Dm
> CONFIG_INET_XFRM_TUNNEL=3Dm
> CONFIG_INET_TUNNEL=3Dm
> CONFIG_INET_DIAG=3Dm
> CONFIG_INET_TCP_DIAG=3Dm
> CONFIG_INET_UDP_DIAG=3Dm
> CONFIG_INET_RAW_DIAG=3Dm
> CONFIG_INET_DIAG_DESTROY=3Dy
> CONFIG_TCP_CONG_ADVANCED=3Dy
> CONFIG_TCP_CONG_BIC=3Dm
> CONFIG_TCP_CONG_CUBIC=3Dy
> CONFIG_TCP_CONG_WESTWOOD=3Dm
> CONFIG_TCP_CONG_HTCP=3Dm
> CONFIG_TCP_CONG_HSTCP=3Dm
> CONFIG_TCP_CONG_HYBLA=3Dm
> CONFIG_TCP_CONG_VEGAS=3Dm
> CONFIG_TCP_CONG_NV=3Dm
> CONFIG_TCP_CONG_SCALABLE=3Dm
> CONFIG_TCP_CONG_LP=3Dm
> CONFIG_TCP_CONG_VENO=3Dm
> CONFIG_TCP_CONG_YEAH=3Dm
> CONFIG_TCP_CONG_ILLINOIS=3Dm
> CONFIG_TCP_CONG_DCTCP=3Dm
> CONFIG_TCP_CONG_CDG=3Dm
> CONFIG_TCP_CONG_BBR=3Dm
> CONFIG_DEFAULT_CUBIC=3Dy
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> CONFIG_TCP_MD5SIG=3Dy
> CONFIG_IPV6=3Dy
> CONFIG_IPV6_ROUTER_PREF=3Dy
> CONFIG_IPV6_ROUTE_INFO=3Dy
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> CONFIG_INET6_AH=3Dm
> CONFIG_INET6_ESP=3Dm
> CONFIG_INET6_ESP_OFFLOAD=3Dm
> # CONFIG_INET6_ESPINTCP is not set
> CONFIG_INET6_IPCOMP=3Dm
> CONFIG_IPV6_MIP6=3Dm
> CONFIG_IPV6_ILA=3Dm
> CONFIG_INET6_XFRM_TUNNEL=3Dm
> CONFIG_INET6_TUNNEL=3Dm
> CONFIG_IPV6_VTI=3Dm
> CONFIG_IPV6_SIT=3Dm
> CONFIG_IPV6_SIT_6RD=3Dy
> CONFIG_IPV6_NDISC_NODETYPE=3Dy
> CONFIG_IPV6_TUNNEL=3Dm
> CONFIG_IPV6_GRE=3Dm
> CONFIG_IPV6_FOU=3Dm
> CONFIG_IPV6_FOU_TUNNEL=3Dm
> CONFIG_IPV6_MULTIPLE_TABLES=3Dy
> CONFIG_IPV6_SUBTREES=3Dy
> CONFIG_IPV6_MROUTE=3Dy
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
> CONFIG_IPV6_PIMSM_V2=3Dy
> CONFIG_IPV6_SEG6_LWTUNNEL=3Dy
> CONFIG_IPV6_SEG6_HMAC=3Dy
> CONFIG_IPV6_SEG6_BPF=3Dy
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> CONFIG_NETLABEL=3Dy
> # CONFIG_MPTCP is not set
> CONFIG_NETWORK_SECMARK=3Dy
> CONFIG_NET_PTP_CLASSIFY=3Dy
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> CONFIG_NETFILTER=3Dy
> CONFIG_NETFILTER_ADVANCED=3Dy
> CONFIG_BRIDGE_NETFILTER=3Dm
>=20
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=3Dy
> CONFIG_NETFILTER_EGRESS=3Dy
> CONFIG_NETFILTER_SKIP_EGRESS=3Dy
> CONFIG_NETFILTER_NETLINK=3Dm
> CONFIG_NETFILTER_FAMILY_BRIDGE=3Dy
> CONFIG_NETFILTER_FAMILY_ARP=3Dy
> # CONFIG_NETFILTER_NETLINK_HOOK is not set
> CONFIG_NETFILTER_NETLINK_ACCT=3Dm
> CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
> CONFIG_NETFILTER_NETLINK_LOG=3Dm
> CONFIG_NETFILTER_NETLINK_OSF=3Dm
> CONFIG_NF_CONNTRACK=3Dm
> CONFIG_NF_LOG_SYSLOG=3Dm
> CONFIG_NETFILTER_CONNCOUNT=3Dm
> CONFIG_NF_CONNTRACK_MARK=3Dy
> CONFIG_NF_CONNTRACK_SECMARK=3Dy
> CONFIG_NF_CONNTRACK_ZONES=3Dy
> # CONFIG_NF_CONNTRACK_PROCFS is not set
> CONFIG_NF_CONNTRACK_EVENTS=3Dy
> CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
> CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
> CONFIG_NF_CONNTRACK_LABELS=3Dy
> CONFIG_NF_CT_PROTO_DCCP=3Dy
> CONFIG_NF_CT_PROTO_GRE=3Dy
> CONFIG_NF_CT_PROTO_SCTP=3Dy
> CONFIG_NF_CT_PROTO_UDPLITE=3Dy
> CONFIG_NF_CONNTRACK_AMANDA=3Dm
> CONFIG_NF_CONNTRACK_FTP=3Dm
> CONFIG_NF_CONNTRACK_H323=3Dm
> CONFIG_NF_CONNTRACK_IRC=3Dm
> CONFIG_NF_CONNTRACK_BROADCAST=3Dm
> CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
> CONFIG_NF_CONNTRACK_SNMP=3Dm
> CONFIG_NF_CONNTRACK_PPTP=3Dm
> CONFIG_NF_CONNTRACK_SANE=3Dm
> CONFIG_NF_CONNTRACK_SIP=3Dm
> CONFIG_NF_CONNTRACK_TFTP=3Dm
> CONFIG_NF_CT_NETLINK=3Dm
> CONFIG_NF_CT_NETLINK_TIMEOUT=3Dm
> CONFIG_NF_CT_NETLINK_HELPER=3Dm
> CONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy
> CONFIG_NF_NAT=3Dm
> CONFIG_NF_NAT_AMANDA=3Dm
> CONFIG_NF_NAT_FTP=3Dm
> CONFIG_NF_NAT_IRC=3Dm
> CONFIG_NF_NAT_SIP=3Dm
> CONFIG_NF_NAT_TFTP=3Dm
> CONFIG_NF_NAT_REDIRECT=3Dy
> CONFIG_NF_NAT_MASQUERADE=3Dy
> CONFIG_NETFILTER_SYNPROXY=3Dm
> CONFIG_NF_TABLES=3Dm
> CONFIG_NF_TABLES_INET=3Dy
> CONFIG_NF_TABLES_NETDEV=3Dy
> CONFIG_NFT_NUMGEN=3Dm
> CONFIG_NFT_CT=3Dm
> CONFIG_NFT_FLOW_OFFLOAD=3Dm
> CONFIG_NFT_CONNLIMIT=3Dm
> CONFIG_NFT_LOG=3Dm
> CONFIG_NFT_LIMIT=3Dm
> CONFIG_NFT_MASQ=3Dm
> CONFIG_NFT_REDIR=3Dm
> CONFIG_NFT_NAT=3Dm
> CONFIG_NFT_TUNNEL=3Dm
> CONFIG_NFT_OBJREF=3Dm
> CONFIG_NFT_QUEUE=3Dm
> CONFIG_NFT_QUOTA=3Dm
> CONFIG_NFT_REJECT=3Dm
> CONFIG_NFT_REJECT_INET=3Dm
> CONFIG_NFT_COMPAT=3Dm
> CONFIG_NFT_HASH=3Dm
> CONFIG_NFT_FIB=3Dm
> CONFIG_NFT_FIB_INET=3Dm
> CONFIG_NFT_XFRM=3Dm
> CONFIG_NFT_SOCKET=3Dm
> CONFIG_NFT_OSF=3Dm
> CONFIG_NFT_TPROXY=3Dm
> CONFIG_NFT_SYNPROXY=3Dm
> CONFIG_NF_DUP_NETDEV=3Dm
> CONFIG_NFT_DUP_NETDEV=3Dm
> CONFIG_NFT_FWD_NETDEV=3Dm
> CONFIG_NFT_FIB_NETDEV=3Dm
> CONFIG_NFT_REJECT_NETDEV=3Dm
> CONFIG_NF_FLOW_TABLE_INET=3Dm
> CONFIG_NF_FLOW_TABLE=3Dm
> CONFIG_NETFILTER_XTABLES=3Dm
> CONFIG_NETFILTER_XTABLES_COMPAT=3Dy
>=20
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=3Dm
> CONFIG_NETFILTER_XT_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_SET=3Dm
>=20
> #
> # Xtables targets
> #
> CONFIG_NETFILTER_XT_TARGET_AUDIT=3Dm
> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_CT=3Dm
> CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
> CONFIG_NETFILTER_XT_TARGET_HL=3Dm
> CONFIG_NETFILTER_XT_TARGET_HMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
> CONFIG_NETFILTER_XT_TARGET_LED=3Dm
> CONFIG_NETFILTER_XT_TARGET_LOG=3Dm
> CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
> CONFIG_NETFILTER_XT_NAT=3Dm
> CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dm
> CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
> # CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
> CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
> CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dm
> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=3Dm
> CONFIG_NETFILTER_XT_TARGET_TEE=3Dm
> CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
> CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
> CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm
>=20
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
> CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> CONFIG_NETFILTER_XT_MATCH_CGROUP=3Dm
> CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
> CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNLABEL=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
> CONFIG_NETFILTER_XT_MATCH_CPU=3Dm
> CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm
> CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
> CONFIG_NETFILTER_XT_MATCH_ECN=3Dm
> CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
> CONFIG_NETFILTER_XT_MATCH_HL=3Dm
> CONFIG_NETFILTER_XT_MATCH_IPCOMP=3Dm
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
> CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
> CONFIG_NETFILTER_XT_MATCH_L2TP=3Dm
> CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
> CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
> CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
> CONFIG_NETFILTER_XT_MATCH_NFACCT=3Dm
> CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
> CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
> CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
> CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
> CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
> CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
> CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
> CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
> CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
> CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
> CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
> CONFIG_NETFILTER_XT_MATCH_TIME=3Dm
> CONFIG_NETFILTER_XT_MATCH_U32=3Dm
> # end of Core Netfilter Configuration
>=20
> CONFIG_IP_SET=3Dm
> CONFIG_IP_SET_MAX=3D256
> CONFIG_IP_SET_BITMAP_IP=3Dm
> CONFIG_IP_SET_BITMAP_IPMAC=3Dm
> CONFIG_IP_SET_BITMAP_PORT=3Dm
> CONFIG_IP_SET_HASH_IP=3Dm
> CONFIG_IP_SET_HASH_IPMARK=3Dm
> CONFIG_IP_SET_HASH_IPPORT=3Dm
> CONFIG_IP_SET_HASH_IPPORTIP=3Dm
> CONFIG_IP_SET_HASH_IPPORTNET=3Dm
> CONFIG_IP_SET_HASH_IPMAC=3Dm
> CONFIG_IP_SET_HASH_MAC=3Dm
> CONFIG_IP_SET_HASH_NETPORTNET=3Dm
> CONFIG_IP_SET_HASH_NET=3Dm
> CONFIG_IP_SET_HASH_NETNET=3Dm
> CONFIG_IP_SET_HASH_NETPORT=3Dm
> CONFIG_IP_SET_HASH_NETIFACE=3Dm
> CONFIG_IP_SET_LIST_SET=3Dm
> CONFIG_IP_VS=3Dm
> CONFIG_IP_VS_IPV6=3Dy
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=3D12
>=20
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=3Dy
> CONFIG_IP_VS_PROTO_UDP=3Dy
> CONFIG_IP_VS_PROTO_AH_ESP=3Dy
> CONFIG_IP_VS_PROTO_ESP=3Dy
> CONFIG_IP_VS_PROTO_AH=3Dy
> CONFIG_IP_VS_PROTO_SCTP=3Dy
>=20
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=3Dm
> CONFIG_IP_VS_WRR=3Dm
> CONFIG_IP_VS_LC=3Dm
> CONFIG_IP_VS_WLC=3Dm
> CONFIG_IP_VS_FO=3Dm
> CONFIG_IP_VS_OVF=3Dm
> CONFIG_IP_VS_LBLC=3Dm
> CONFIG_IP_VS_LBLCR=3Dm
> CONFIG_IP_VS_DH=3Dm
> CONFIG_IP_VS_SH=3Dm
> # CONFIG_IP_VS_MH is not set
> CONFIG_IP_VS_SED=3Dm
> CONFIG_IP_VS_NQ=3Dm
> # CONFIG_IP_VS_TWOS is not set
>=20
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=3D8
>=20
> #
> # IPVS MH scheduler
> #
> CONFIG_IP_VS_MH_TAB_INDEX=3D12
>=20
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_FTP=3Dm
> CONFIG_IP_VS_NFCT=3Dy
> CONFIG_IP_VS_PE_SIP=3Dm
>=20
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=3Dm
> CONFIG_NF_SOCKET_IPV4=3Dm
> CONFIG_NF_TPROXY_IPV4=3Dm
> CONFIG_NF_TABLES_IPV4=3Dy
> CONFIG_NFT_REJECT_IPV4=3Dm
> CONFIG_NFT_DUP_IPV4=3Dm
> CONFIG_NFT_FIB_IPV4=3Dm
> CONFIG_NF_TABLES_ARP=3Dy
> CONFIG_NF_DUP_IPV4=3Dm
> CONFIG_NF_LOG_ARP=3Dm
> CONFIG_NF_LOG_IPV4=3Dm
> CONFIG_NF_REJECT_IPV4=3Dm
> CONFIG_NF_NAT_SNMP_BASIC=3Dm
> CONFIG_NF_NAT_PPTP=3Dm
> CONFIG_NF_NAT_H323=3Dm
> CONFIG_IP_NF_IPTABLES=3Dm
> CONFIG_IP_NF_MATCH_AH=3Dm
> CONFIG_IP_NF_MATCH_ECN=3Dm
> CONFIG_IP_NF_MATCH_RPFILTER=3Dm
> CONFIG_IP_NF_MATCH_TTL=3Dm
> CONFIG_IP_NF_FILTER=3Dm
> CONFIG_IP_NF_TARGET_REJECT=3Dm
> CONFIG_IP_NF_TARGET_SYNPROXY=3Dm
> CONFIG_IP_NF_NAT=3Dm
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP_NF_TARGET_NETMAP=3Dm
> CONFIG_IP_NF_TARGET_REDIRECT=3Dm
> CONFIG_IP_NF_MANGLE=3Dm
> CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
> CONFIG_IP_NF_TARGET_ECN=3Dm
> CONFIG_IP_NF_TARGET_TTL=3Dm
> CONFIG_IP_NF_RAW=3Dm
> CONFIG_IP_NF_SECURITY=3Dm
> CONFIG_IP_NF_ARPTABLES=3Dm
> CONFIG_IP_NF_ARPFILTER=3Dm
> CONFIG_IP_NF_ARP_MANGLE=3Dm
> # end of IP: Netfilter Configuration
>=20
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_NF_SOCKET_IPV6=3Dm
> CONFIG_NF_TPROXY_IPV6=3Dm
> CONFIG_NF_TABLES_IPV6=3Dy
> CONFIG_NFT_REJECT_IPV6=3Dm
> CONFIG_NFT_DUP_IPV6=3Dm
> CONFIG_NFT_FIB_IPV6=3Dm
> CONFIG_NF_DUP_IPV6=3Dm
> CONFIG_NF_REJECT_IPV6=3Dm
> CONFIG_NF_LOG_IPV6=3Dm
> CONFIG_IP6_NF_IPTABLES=3Dm
> CONFIG_IP6_NF_MATCH_AH=3Dm
> CONFIG_IP6_NF_MATCH_EUI64=3Dm
> CONFIG_IP6_NF_MATCH_FRAG=3Dm
> CONFIG_IP6_NF_MATCH_OPTS=3Dm
> CONFIG_IP6_NF_MATCH_HL=3Dm
> CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
> CONFIG_IP6_NF_MATCH_MH=3Dm
> CONFIG_IP6_NF_MATCH_RPFILTER=3Dm
> CONFIG_IP6_NF_MATCH_RT=3Dm
> CONFIG_IP6_NF_MATCH_SRH=3Dm
> CONFIG_IP6_NF_TARGET_HL=3Dm
> CONFIG_IP6_NF_FILTER=3Dm
> CONFIG_IP6_NF_TARGET_REJECT=3Dm
> CONFIG_IP6_NF_TARGET_SYNPROXY=3Dm
> CONFIG_IP6_NF_MANGLE=3Dm
> CONFIG_IP6_NF_RAW=3Dm
> CONFIG_IP6_NF_SECURITY=3Dm
> CONFIG_IP6_NF_NAT=3Dm
> CONFIG_IP6_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP6_NF_TARGET_NPT=3Dm
> # end of IPv6: Netfilter Configuration
>=20
> CONFIG_NF_DEFRAG_IPV6=3Dm
>=20
> #
> # DECnet: Netfilter Configuration
> #
> CONFIG_DECNET_NF_GRABULATOR=3Dm
> # end of DECnet: Netfilter Configuration
>=20
> CONFIG_NF_TABLES_BRIDGE=3Dm
> CONFIG_NFT_BRIDGE_META=3Dm
> CONFIG_NFT_BRIDGE_REJECT=3Dm
> # CONFIG_NF_CONNTRACK_BRIDGE is not set
> CONFIG_BRIDGE_NF_EBTABLES=3Dm
> CONFIG_BRIDGE_EBT_BROUTE=3Dm
> CONFIG_BRIDGE_EBT_T_FILTER=3Dm
> CONFIG_BRIDGE_EBT_T_NAT=3Dm
> CONFIG_BRIDGE_EBT_802_3=3Dm
> CONFIG_BRIDGE_EBT_AMONG=3Dm
> CONFIG_BRIDGE_EBT_ARP=3Dm
> CONFIG_BRIDGE_EBT_IP=3Dm
> CONFIG_BRIDGE_EBT_IP6=3Dm
> CONFIG_BRIDGE_EBT_LIMIT=3Dm
> CONFIG_BRIDGE_EBT_MARK=3Dm
> CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
> CONFIG_BRIDGE_EBT_STP=3Dm
> CONFIG_BRIDGE_EBT_VLAN=3Dm
> CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
> CONFIG_BRIDGE_EBT_DNAT=3Dm
> CONFIG_BRIDGE_EBT_MARK_T=3Dm
> CONFIG_BRIDGE_EBT_REDIRECT=3Dm
> CONFIG_BRIDGE_EBT_SNAT=3Dm
> CONFIG_BRIDGE_EBT_LOG=3Dm
> CONFIG_BRIDGE_EBT_NFLOG=3Dm
> # CONFIG_BPFILTER is not set
> CONFIG_IP_DCCP=3Dm
> CONFIG_INET_DCCP_DIAG=3Dm
>=20
> #
> # DCCP CCIDs Configuration
> #
> # CONFIG_IP_DCCP_CCID2_DEBUG is not set
> # CONFIG_IP_DCCP_CCID3 is not set
> # end of DCCP CCIDs Configuration
>=20
> #
> # DCCP Kernel Hacking
> #
> # CONFIG_IP_DCCP_DEBUG is not set
> # end of DCCP Kernel Hacking
>=20
> CONFIG_IP_SCTP=3Dm
> # CONFIG_SCTP_DBG_OBJCNT is not set
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=3Dy
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> CONFIG_SCTP_COOKIE_HMAC_MD5=3Dy
> CONFIG_SCTP_COOKIE_HMAC_SHA1=3Dy
> CONFIG_INET_SCTP_DIAG=3Dm
> CONFIG_RDS=3Dm
> CONFIG_RDS_RDMA=3Dm
> CONFIG_RDS_TCP=3Dm
> # CONFIG_RDS_DEBUG is not set
> CONFIG_TIPC=3Dm
> CONFIG_TIPC_MEDIA_IB=3Dy
> CONFIG_TIPC_MEDIA_UDP=3Dy
> CONFIG_TIPC_CRYPTO=3Dy
> CONFIG_TIPC_DIAG=3Dm
> CONFIG_ATM=3Dm
> CONFIG_ATM_CLIP=3Dm
> # CONFIG_ATM_CLIP_NO_ICMP is not set
> CONFIG_ATM_LANE=3Dm
> CONFIG_ATM_MPOA=3Dm
> CONFIG_ATM_BR2684=3Dm
> # CONFIG_ATM_BR2684_IPFILTER is not set
> CONFIG_L2TP=3Dm
> CONFIG_L2TP_DEBUGFS=3Dm
> CONFIG_L2TP_V3=3Dy
> CONFIG_L2TP_IP=3Dm
> CONFIG_L2TP_ETH=3Dm
> CONFIG_STP=3Dm
> CONFIG_GARP=3Dm
> CONFIG_MRP=3Dm
> CONFIG_BRIDGE=3Dm
> CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
> CONFIG_BRIDGE_VLAN_FILTERING=3Dy
> # CONFIG_BRIDGE_MRP is not set
> # CONFIG_BRIDGE_CFM is not set
> CONFIG_NET_DSA=3Dm
> # CONFIG_NET_DSA_TAG_AR9331 is not set
> CONFIG_NET_DSA_TAG_BRCM_COMMON=3Dm
> CONFIG_NET_DSA_TAG_BRCM=3Dm
> CONFIG_NET_DSA_TAG_BRCM_LEGACY=3Dm
> CONFIG_NET_DSA_TAG_BRCM_PREPEND=3Dm
> # CONFIG_NET_DSA_TAG_HELLCREEK is not set
> # CONFIG_NET_DSA_TAG_GSWIP is not set
> CONFIG_NET_DSA_TAG_DSA_COMMON=3Dm
> CONFIG_NET_DSA_TAG_DSA=3Dm
> CONFIG_NET_DSA_TAG_EDSA=3Dm
> CONFIG_NET_DSA_TAG_MTK=3Dm
> # CONFIG_NET_DSA_TAG_KSZ is not set
> # CONFIG_NET_DSA_TAG_OCELOT is not set
> # CONFIG_NET_DSA_TAG_OCELOT_8021Q is not set
> CONFIG_NET_DSA_TAG_QCA=3Dm
> # CONFIG_NET_DSA_TAG_RTL4_A is not set
> # CONFIG_NET_DSA_TAG_RTL8_4 is not set
> CONFIG_NET_DSA_TAG_LAN9303=3Dm
> # CONFIG_NET_DSA_TAG_SJA1105 is not set
> CONFIG_NET_DSA_TAG_TRAILER=3Dm
> # CONFIG_NET_DSA_TAG_XRS700X is not set
> CONFIG_VLAN_8021Q=3Dm
> CONFIG_VLAN_8021Q_GVRP=3Dy
> CONFIG_VLAN_8021Q_MVRP=3Dy
> CONFIG_DECNET=3Dm
> # CONFIG_DECNET_ROUTER is not set
> CONFIG_LLC=3Dm
> CONFIG_LLC2=3Dm
> CONFIG_ATALK=3Dm
> CONFIG_DEV_APPLETALK=3Dm
> # CONFIG_IPDDP is not set
> CONFIG_X25=3Dm
> CONFIG_LAPB=3Dm
> CONFIG_PHONET=3Dm
> CONFIG_6LOWPAN=3Dm
> # CONFIG_6LOWPAN_DEBUGFS is not set
> CONFIG_6LOWPAN_NHC=3Dm
> CONFIG_6LOWPAN_NHC_DEST=3Dm
> CONFIG_6LOWPAN_NHC_FRAGMENT=3Dm
> CONFIG_6LOWPAN_NHC_HOP=3Dm
> CONFIG_6LOWPAN_NHC_IPV6=3Dm
> CONFIG_6LOWPAN_NHC_MOBILITY=3Dm
> CONFIG_6LOWPAN_NHC_ROUTING=3Dm
> CONFIG_6LOWPAN_NHC_UDP=3Dm
> # CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
> # CONFIG_6LOWPAN_GHC_UDP is not set
> # CONFIG_6LOWPAN_GHC_ICMPV6 is not set
> # CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
> # CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
> # CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
> CONFIG_IEEE802154=3Dm
> # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> CONFIG_IEEE802154_SOCKET=3Dm
> CONFIG_IEEE802154_6LOWPAN=3Dm
> CONFIG_MAC802154=3Dm
> CONFIG_NET_SCHED=3Dy
>=20
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=3Dm
> CONFIG_NET_SCH_HTB=3Dm
> CONFIG_NET_SCH_HFSC=3Dm
> CONFIG_NET_SCH_ATM=3Dm
> CONFIG_NET_SCH_PRIO=3Dm
> CONFIG_NET_SCH_MULTIQ=3Dm
> CONFIG_NET_SCH_RED=3Dm
> CONFIG_NET_SCH_SFB=3Dm
> CONFIG_NET_SCH_SFQ=3Dm
> CONFIG_NET_SCH_TEQL=3Dm
> CONFIG_NET_SCH_TBF=3Dm
> CONFIG_NET_SCH_CBS=3Dm
> CONFIG_NET_SCH_ETF=3Dm
> # CONFIG_NET_SCH_TAPRIO is not set
> CONFIG_NET_SCH_GRED=3Dm
> CONFIG_NET_SCH_DSMARK=3Dm
> CONFIG_NET_SCH_NETEM=3Dm
> CONFIG_NET_SCH_DRR=3Dm
> CONFIG_NET_SCH_MQPRIO=3Dm
> # CONFIG_NET_SCH_SKBPRIO is not set
> CONFIG_NET_SCH_CHOKE=3Dm
> CONFIG_NET_SCH_QFQ=3Dm
> CONFIG_NET_SCH_CODEL=3Dm
> CONFIG_NET_SCH_FQ_CODEL=3Dm
> # CONFIG_NET_SCH_CAKE is not set
> CONFIG_NET_SCH_FQ=3Dm
> CONFIG_NET_SCH_HHF=3Dm
> CONFIG_NET_SCH_PIE=3Dm
> # CONFIG_NET_SCH_FQ_PIE is not set
> CONFIG_NET_SCH_INGRESS=3Dm
> CONFIG_NET_SCH_PLUG=3Dm
> # CONFIG_NET_SCH_ETS is not set
> # CONFIG_NET_SCH_DEFAULT is not set
>=20
> #
> # Classification
> #
> CONFIG_NET_CLS=3Dy
> CONFIG_NET_CLS_BASIC=3Dm
> CONFIG_NET_CLS_TCINDEX=3Dm
> CONFIG_NET_CLS_ROUTE4=3Dm
> CONFIG_NET_CLS_FW=3Dm
> CONFIG_NET_CLS_U32=3Dm
> # CONFIG_CLS_U32_PERF is not set
> CONFIG_CLS_U32_MARK=3Dy
> CONFIG_NET_CLS_RSVP=3Dm
> CONFIG_NET_CLS_RSVP6=3Dm
> CONFIG_NET_CLS_FLOW=3Dm
> CONFIG_NET_CLS_CGROUP=3Dm
> CONFIG_NET_CLS_BPF=3Dm
> CONFIG_NET_CLS_FLOWER=3Dm
> CONFIG_NET_CLS_MATCHALL=3Dm
> CONFIG_NET_EMATCH=3Dy
> CONFIG_NET_EMATCH_STACK=3D32
> CONFIG_NET_EMATCH_CMP=3Dm
> CONFIG_NET_EMATCH_NBYTE=3Dm
> CONFIG_NET_EMATCH_U32=3Dm
> CONFIG_NET_EMATCH_META=3Dm
> CONFIG_NET_EMATCH_TEXT=3Dm
> CONFIG_NET_EMATCH_CANID=3Dm
> CONFIG_NET_EMATCH_IPSET=3Dm
> CONFIG_NET_EMATCH_IPT=3Dm
> CONFIG_NET_CLS_ACT=3Dy
> CONFIG_NET_ACT_POLICE=3Dm
> CONFIG_NET_ACT_GACT=3Dm
> CONFIG_GACT_PROB=3Dy
> CONFIG_NET_ACT_MIRRED=3Dm
> CONFIG_NET_ACT_SAMPLE=3Dm
> CONFIG_NET_ACT_IPT=3Dm
> CONFIG_NET_ACT_NAT=3Dm
> CONFIG_NET_ACT_PEDIT=3Dm
> CONFIG_NET_ACT_SIMP=3Dm
> CONFIG_NET_ACT_SKBEDIT=3Dm
> CONFIG_NET_ACT_CSUM=3Dm
> # CONFIG_NET_ACT_MPLS is not set
> CONFIG_NET_ACT_VLAN=3Dm
> CONFIG_NET_ACT_BPF=3Dm
> CONFIG_NET_ACT_CONNMARK=3Dm
> # CONFIG_NET_ACT_CTINFO is not set
> CONFIG_NET_ACT_SKBMOD=3Dm
> # CONFIG_NET_ACT_IFE is not set
> CONFIG_NET_ACT_TUNNEL_KEY=3Dm
> CONFIG_NET_ACT_CT=3Dm
> # CONFIG_NET_ACT_GATE is not set
> # CONFIG_NET_TC_SKB_EXT is not set
> CONFIG_NET_SCH_FIFO=3Dy
> CONFIG_DCB=3Dy
> CONFIG_DNS_RESOLVER=3Dy
> CONFIG_BATMAN_ADV=3Dm
> # CONFIG_BATMAN_ADV_BATMAN_V is not set
> CONFIG_BATMAN_ADV_BLA=3Dy
> CONFIG_BATMAN_ADV_DAT=3Dy
> CONFIG_BATMAN_ADV_NC=3Dy
> CONFIG_BATMAN_ADV_MCAST=3Dy
> # CONFIG_BATMAN_ADV_DEBUG is not set
> # CONFIG_BATMAN_ADV_TRACING is not set
> CONFIG_OPENVSWITCH=3Dm
> CONFIG_OPENVSWITCH_GRE=3Dm
> CONFIG_OPENVSWITCH_VXLAN=3Dm
> CONFIG_OPENVSWITCH_GENEVE=3Dm
> CONFIG_VSOCKETS=3Dm
> CONFIG_VSOCKETS_DIAG=3Dm
> CONFIG_VSOCKETS_LOOPBACK=3Dm
> CONFIG_VMWARE_VMCI_VSOCKETS=3Dm
> CONFIG_VIRTIO_VSOCKETS=3Dm
> CONFIG_VIRTIO_VSOCKETS_COMMON=3Dm
> CONFIG_HYPERV_VSOCKETS=3Dm
> CONFIG_NETLINK_DIAG=3Dm
> CONFIG_MPLS=3Dy
> CONFIG_NET_MPLS_GSO=3Dm
> CONFIG_MPLS_ROUTING=3Dm
> CONFIG_MPLS_IPTUNNEL=3Dm
> CONFIG_NET_NSH=3Dm
> CONFIG_HSR=3Dm
> CONFIG_NET_SWITCHDEV=3Dy
> CONFIG_NET_L3_MASTER_DEV=3Dy
> # CONFIG_QRTR is not set
> CONFIG_NET_NCSI=3Dy
> # CONFIG_NCSI_OEM_CMD_GET_MAC is not set
> # CONFIG_NCSI_OEM_CMD_KEEP_PHY is not set
> CONFIG_PCPU_DEV_REFCNT=3Dy
> CONFIG_RPS=3Dy
> CONFIG_RFS_ACCEL=3Dy
> CONFIG_SOCK_RX_QUEUE_MAPPING=3Dy
> CONFIG_XPS=3Dy
> CONFIG_CGROUP_NET_PRIO=3Dy
> CONFIG_CGROUP_NET_CLASSID=3Dy
> CONFIG_NET_RX_BUSY_POLL=3Dy
> CONFIG_BQL=3Dy
> CONFIG_BPF_STREAM_PARSER=3Dy
> CONFIG_NET_FLOW_LIMIT=3Dy
>=20
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=3Dm
> CONFIG_NET_DROP_MONITOR=3Dy
> # end of Network testing
> # end of Networking options
>=20
> CONFIG_HAMRADIO=3Dy
>=20
> #
> # Packet Radio protocols
> #
> CONFIG_AX25=3Dm
> CONFIG_AX25_DAMA_SLAVE=3Dy
> CONFIG_NETROM=3Dm
> CONFIG_ROSE=3Dm
>=20
> #
> # AX.25 network device drivers
> #
> CONFIG_MKISS=3Dm
> CONFIG_6PACK=3Dm
> CONFIG_BPQETHER=3Dm
> CONFIG_BAYCOM_SER_FDX=3Dm
> CONFIG_BAYCOM_SER_HDX=3Dm
> CONFIG_BAYCOM_PAR=3Dm
> CONFIG_YAM=3Dm
> # end of AX.25 network device drivers
>=20
> CONFIG_CAN=3Dm
> CONFIG_CAN_RAW=3Dm
> CONFIG_CAN_BCM=3Dm
> CONFIG_CAN_GW=3Dm
> # CONFIG_CAN_J1939 is not set
> # CONFIG_CAN_ISOTP is not set
>=20
> #
> # CAN Device Drivers
> #
> CONFIG_CAN_VCAN=3Dm
> CONFIG_CAN_VXCAN=3Dm
> CONFIG_CAN_SLCAN=3Dm
> CONFIG_CAN_DEV=3Dm
> CONFIG_CAN_CALC_BITTIMING=3Dy
> # CONFIG_CAN_FLEXCAN is not set
> # CONFIG_CAN_GRCAN is not set
> CONFIG_CAN_JANZ_ICAN3=3Dm
> # CONFIG_CAN_KVASER_PCIEFD is not set
> CONFIG_CAN_C_CAN=3Dm
> CONFIG_CAN_C_CAN_PLATFORM=3Dm
> CONFIG_CAN_C_CAN_PCI=3Dm
> CONFIG_CAN_CC770=3Dm
> CONFIG_CAN_CC770_ISA=3Dm
> CONFIG_CAN_CC770_PLATFORM=3Dm
> CONFIG_CAN_IFI_CANFD=3Dm
> CONFIG_CAN_M_CAN=3Dm
> CONFIG_CAN_M_CAN_PCI=3Dm
> CONFIG_CAN_M_CAN_PLATFORM=3Dm
> # CONFIG_CAN_M_CAN_TCAN4X5X is not set
> CONFIG_CAN_PEAK_PCIEFD=3Dm
> CONFIG_CAN_SJA1000=3Dm
> CONFIG_CAN_EMS_PCI=3Dm
> CONFIG_CAN_EMS_PCMCIA=3Dm
> # CONFIG_CAN_F81601 is not set
> CONFIG_CAN_KVASER_PCI=3Dm
> CONFIG_CAN_PEAK_PCI=3Dm
> CONFIG_CAN_PEAK_PCIEC=3Dy
> CONFIG_CAN_PEAK_PCMCIA=3Dm
> CONFIG_CAN_PLX_PCI=3Dm
> CONFIG_CAN_SJA1000_ISA=3Dm
> CONFIG_CAN_SJA1000_PLATFORM=3Dm
> CONFIG_CAN_SOFTING=3Dm
> CONFIG_CAN_SOFTING_CS=3Dm
>=20
> #
> # CAN SPI interfaces
> #
> CONFIG_CAN_HI311X=3Dm
> CONFIG_CAN_MCP251X=3Dm
> # CONFIG_CAN_MCP251XFD is not set
> # end of CAN SPI interfaces
>=20
> #
> # CAN USB interfaces
> #
> CONFIG_CAN_8DEV_USB=3Dm
> CONFIG_CAN_EMS_USB=3Dm
> CONFIG_CAN_ESD_USB2=3Dm
> # CONFIG_CAN_ETAS_ES58X is not set
> CONFIG_CAN_GS_USB=3Dm
> CONFIG_CAN_KVASER_USB=3Dm
> CONFIG_CAN_MCBA_USB=3Dm
> CONFIG_CAN_PEAK_USB=3Dm
> # CONFIG_CAN_UCAN is not set
> # end of CAN USB interfaces
>=20
> # CONFIG_CAN_DEBUG_DEVICES is not set
> # end of CAN Device Drivers
>=20
> CONFIG_BT=3Dm
> CONFIG_BT_BREDR=3Dy
> CONFIG_BT_RFCOMM=3Dm
> CONFIG_BT_RFCOMM_TTY=3Dy
> CONFIG_BT_BNEP=3Dm
> CONFIG_BT_BNEP_MC_FILTER=3Dy
> CONFIG_BT_BNEP_PROTO_FILTER=3Dy
> CONFIG_BT_CMTP=3Dm
> CONFIG_BT_HIDP=3Dm
> CONFIG_BT_HS=3Dy
> CONFIG_BT_LE=3Dy
> CONFIG_BT_6LOWPAN=3Dm
> CONFIG_BT_LEDS=3Dy
> # CONFIG_BT_MSFTEXT is not set
> # CONFIG_BT_AOSPEXT is not set
> CONFIG_BT_DEBUGFS=3Dy
> # CONFIG_BT_SELFTEST is not set
>=20
> #
> # Bluetooth device drivers
> #
> CONFIG_BT_INTEL=3Dm
> CONFIG_BT_BCM=3Dm
> CONFIG_BT_RTL=3Dm
> CONFIG_BT_QCA=3Dm
> CONFIG_BT_HCIBTUSB=3Dm
> CONFIG_BT_HCIBTUSB_AUTOSUSPEND=3Dy
> CONFIG_BT_HCIBTUSB_BCM=3Dy
> # CONFIG_BT_HCIBTUSB_MTK is not set
> CONFIG_BT_HCIBTUSB_RTL=3Dy
> CONFIG_BT_HCIBTSDIO=3Dm
> CONFIG_BT_HCIUART=3Dm
> CONFIG_BT_HCIUART_SERDEV=3Dy
> CONFIG_BT_HCIUART_H4=3Dy
> CONFIG_BT_HCIUART_NOKIA=3Dm
> CONFIG_BT_HCIUART_BCSP=3Dy
> CONFIG_BT_HCIUART_ATH3K=3Dy
> CONFIG_BT_HCIUART_LL=3Dy
> CONFIG_BT_HCIUART_3WIRE=3Dy
> CONFIG_BT_HCIUART_INTEL=3Dy
> CONFIG_BT_HCIUART_BCM=3Dy
> # CONFIG_BT_HCIUART_RTL is not set
> CONFIG_BT_HCIUART_QCA=3Dy
> CONFIG_BT_HCIUART_AG6XX=3Dy
> CONFIG_BT_HCIUART_MRVL=3Dy
> CONFIG_BT_HCIBCM203X=3Dm
> CONFIG_BT_HCIBPA10X=3Dm
> CONFIG_BT_HCIBFUSB=3Dm
> CONFIG_BT_HCIDTL1=3Dm
> CONFIG_BT_HCIBT3C=3Dm
> CONFIG_BT_HCIBLUECARD=3Dm
> CONFIG_BT_HCIVHCI=3Dm
> CONFIG_BT_MRVL=3Dm
> CONFIG_BT_MRVL_SDIO=3Dm
> CONFIG_BT_ATH3K=3Dm
> # CONFIG_BT_MTKSDIO is not set
> # CONFIG_BT_MTKUART is not set
> CONFIG_BT_HCIRSI=3Dm
> # CONFIG_BT_VIRTIO is not set
> # end of Bluetooth device drivers
>=20
> CONFIG_AF_RXRPC=3Dm
> CONFIG_AF_RXRPC_IPV6=3Dy
> # CONFIG_AF_RXRPC_INJECT_LOSS is not set
> # CONFIG_AF_RXRPC_DEBUG is not set
> CONFIG_RXKAD=3Dy
> CONFIG_AF_KCM=3Dm
> CONFIG_STREAM_PARSER=3Dy
> # CONFIG_MCTP is not set
> CONFIG_FIB_RULES=3Dy
> CONFIG_WIRELESS=3Dy
> CONFIG_WIRELESS_EXT=3Dy
> CONFIG_WEXT_CORE=3Dy
> CONFIG_WEXT_PROC=3Dy
> CONFIG_WEXT_SPY=3Dy
> CONFIG_WEXT_PRIV=3Dy
> CONFIG_CFG80211=3Dm
> # CONFIG_NL80211_TESTMODE is not set
> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> # CONFIG_CFG80211_CERTIFICATION_ONUS is not set
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy
> CONFIG_CFG80211_DEFAULT_PS=3Dy
> CONFIG_CFG80211_DEBUGFS=3Dy
> CONFIG_CFG80211_CRDA_SUPPORT=3Dy
> CONFIG_CFG80211_WEXT=3Dy
> CONFIG_CFG80211_WEXT_EXPORT=3Dy
> CONFIG_LIB80211=3Dm
> CONFIG_LIB80211_CRYPT_WEP=3Dm
> CONFIG_LIB80211_CRYPT_CCMP=3Dm
> CONFIG_LIB80211_CRYPT_TKIP=3Dm
> # CONFIG_LIB80211_DEBUG is not set
> CONFIG_MAC80211=3Dm
> CONFIG_MAC80211_HAS_RC=3Dy
> CONFIG_MAC80211_RC_MINSTREL=3Dy
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
> CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
> CONFIG_MAC80211_MESH=3Dy
> CONFIG_MAC80211_LEDS=3Dy
> CONFIG_MAC80211_DEBUGFS=3Dy
> CONFIG_MAC80211_MESSAGE_TRACING=3Dy
> # CONFIG_MAC80211_DEBUG_MENU is not set
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
> CONFIG_RFKILL=3Dy
> CONFIG_RFKILL_LEDS=3Dy
> CONFIG_RFKILL_INPUT=3Dy
> CONFIG_RFKILL_GPIO=3Dm
> CONFIG_NET_9P=3Dy
> CONFIG_NET_9P_FD=3Dy
> CONFIG_NET_9P_VIRTIO=3Dy
> CONFIG_NET_9P_XEN=3Dm
> CONFIG_NET_9P_RDMA=3Dm
> # CONFIG_NET_9P_DEBUG is not set
> CONFIG_CAIF=3Dm
> # CONFIG_CAIF_DEBUG is not set
> CONFIG_CAIF_NETDEV=3Dm
> CONFIG_CAIF_USB=3Dm
> CONFIG_CEPH_LIB=3Dm
> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> CONFIG_CEPH_LIB_USE_DNS_RESOLVER=3Dy
> CONFIG_NFC=3Dm
> CONFIG_NFC_DIGITAL=3Dm
> CONFIG_NFC_NCI=3Dm
> CONFIG_NFC_NCI_SPI=3Dm
> CONFIG_NFC_NCI_UART=3Dm
> CONFIG_NFC_HCI=3Dm
> CONFIG_NFC_SHDLC=3Dy
>=20
> #
> # Near Field Communication (NFC) devices
> #
> CONFIG_NFC_TRF7970A=3Dm
> CONFIG_NFC_MEI_PHY=3Dm
> CONFIG_NFC_SIM=3Dm
> CONFIG_NFC_PORT100=3Dm
> # CONFIG_NFC_VIRTUAL_NCI is not set
> CONFIG_NFC_FDP=3Dm
> CONFIG_NFC_FDP_I2C=3Dm
> CONFIG_NFC_PN544=3Dm
> CONFIG_NFC_PN544_I2C=3Dm
> CONFIG_NFC_PN544_MEI=3Dm
> CONFIG_NFC_PN533=3Dm
> CONFIG_NFC_PN533_USB=3Dm
> CONFIG_NFC_PN533_I2C=3Dm
> # CONFIG_NFC_PN532_UART is not set
> CONFIG_NFC_MICROREAD=3Dm
> CONFIG_NFC_MICROREAD_I2C=3Dm
> CONFIG_NFC_MICROREAD_MEI=3Dm
> CONFIG_NFC_MRVL=3Dm
> CONFIG_NFC_MRVL_USB=3Dm
> CONFIG_NFC_MRVL_UART=3Dm
> CONFIG_NFC_MRVL_I2C=3Dm
> CONFIG_NFC_MRVL_SPI=3Dm
> CONFIG_NFC_ST21NFCA=3Dm
> CONFIG_NFC_ST21NFCA_I2C=3Dm
> CONFIG_NFC_ST_NCI=3Dm
> CONFIG_NFC_ST_NCI_I2C=3Dm
> CONFIG_NFC_ST_NCI_SPI=3Dm
> CONFIG_NFC_NXP_NCI=3Dm
> CONFIG_NFC_NXP_NCI_I2C=3Dm
> CONFIG_NFC_S3FWRN5=3Dm
> CONFIG_NFC_S3FWRN5_I2C=3Dm
> # CONFIG_NFC_S3FWRN82_UART is not set
> CONFIG_NFC_ST95HF=3Dm
> # end of Near Field Communication (NFC) devices
>=20
> CONFIG_PSAMPLE=3Dm
> CONFIG_NET_IFE=3Dm
> CONFIG_LWTUNNEL=3Dy
> CONFIG_LWTUNNEL_BPF=3Dy
> CONFIG_DST_CACHE=3Dy
> CONFIG_GRO_CELLS=3Dy
> CONFIG_NET_SELFTESTS=3Dy
> CONFIG_NET_SOCK_MSG=3Dy
> CONFIG_NET_DEVLINK=3Dy
> CONFIG_PAGE_POOL=3Dy
> # CONFIG_PAGE_POOL_STATS is not set
> CONFIG_FAILOVER=3Dy
> CONFIG_ETHTOOL_NETLINK=3Dy
>=20
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=3Dy
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=3Dy
> CONFIG_PCI=3Dy
> CONFIG_PCI_DOMAINS=3Dy
> CONFIG_PCIEPORTBUS=3Dy
> CONFIG_HOTPLUG_PCI_PCIE=3Dy
> CONFIG_PCIEAER=3Dy
> CONFIG_PCIEAER_INJECT=3Dm
> # CONFIG_PCIE_ECRC is not set
> CONFIG_PCIEASPM=3Dy
> CONFIG_PCIEASPM_DEFAULT=3Dy
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=3Dy
> CONFIG_PCIE_DPC=3Dy
> CONFIG_PCIE_PTM=3Dy
> CONFIG_PCIE_EDR=3Dy
> CONFIG_PCI_MSI=3Dy
> CONFIG_PCI_MSI_IRQ_DOMAIN=3Dy
> CONFIG_PCI_QUIRKS=3Dy
> # CONFIG_PCI_DEBUG is not set
> CONFIG_PCI_REALLOC_ENABLE_AUTO=3Dy
> CONFIG_PCI_STUB=3Dm
> # CONFIG_PCI_PF_STUB is not set
> CONFIG_XEN_PCIDEV_FRONTEND=3Dm
> CONFIG_PCI_ATS=3Dy
> CONFIG_PCI_LOCKLESS_CONFIG=3Dy
> CONFIG_PCI_IOV=3Dy
> CONFIG_PCI_PRI=3Dy
> CONFIG_PCI_PASID=3Dy
> # CONFIG_PCI_P2PDMA is not set
> CONFIG_PCI_LABEL=3Dy
> CONFIG_PCI_HYPERV=3Dm
> # CONFIG_PCIE_BUS_TUNE_OFF is not set
> CONFIG_PCIE_BUS_DEFAULT=3Dy
> # CONFIG_PCIE_BUS_SAFE is not set
> # CONFIG_PCIE_BUS_PERFORMANCE is not set
> # CONFIG_PCIE_BUS_PEER2PEER is not set
> CONFIG_VGA_ARB=3Dy
> CONFIG_VGA_ARB_MAX_GPUS=3D16
> CONFIG_HOTPLUG_PCI=3Dy
> CONFIG_HOTPLUG_PCI_ACPI=3Dy
> CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dm
> CONFIG_HOTPLUG_PCI_CPCI=3Dy
> CONFIG_HOTPLUG_PCI_CPCI_ZT5550=3Dm
> CONFIG_HOTPLUG_PCI_CPCI_GENERIC=3Dm
> CONFIG_HOTPLUG_PCI_SHPC=3Dy
>=20
> #
> # PCI controller drivers
> #
> # CONFIG_PCI_FTPCI100 is not set
> # CONFIG_PCI_HOST_GENERIC is not set
> # CONFIG_PCIE_XILINX is not set
> CONFIG_VMD=3Dy
> CONFIG_PCI_HYPERV_INTERFACE=3Dm
> # CONFIG_PCIE_MICROCHIP_HOST is not set
>=20
> #
> # DesignWare PCI Core Support
> #
> CONFIG_PCIE_DW=3Dy
> CONFIG_PCIE_DW_HOST=3Dy
> CONFIG_PCIE_DW_PLAT=3Dy
> CONFIG_PCIE_DW_PLAT_HOST=3Dy
> # CONFIG_PCIE_DW_PLAT_EP is not set
> # CONFIG_PCIE_INTEL_GW is not set
> # CONFIG_PCI_MESON is not set
> # end of DesignWare PCI Core Support
>=20
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
>=20
> #
> # Cadence PCIe controllers support
> #
> # CONFIG_PCIE_CADENCE_PLAT_HOST is not set
> # CONFIG_PCIE_CADENCE_PLAT_EP is not set
> # CONFIG_PCI_J721E_HOST is not set
> # CONFIG_PCI_J721E_EP is not set
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
>=20
> #
> # PCI Endpoint
> #
> CONFIG_PCI_ENDPOINT=3Dy
> CONFIG_PCI_ENDPOINT_CONFIGFS=3Dy
> # CONFIG_PCI_EPF_TEST is not set
> # CONFIG_PCI_EPF_NTB is not set
> # end of PCI Endpoint
>=20
> #
> # PCI switch controller drivers
> #
> CONFIG_PCI_SW_SWITCHTEC=3Dm
> # end of PCI switch controller drivers
>=20
> CONFIG_CXL_BUS=3Dm
> CONFIG_CXL_PCI=3Dm
> CONFIG_CXL_MEM_RAW_COMMANDS=3Dy
> CONFIG_CXL_ACPI=3Dm
> CONFIG_CXL_PMEM=3Dm
> CONFIG_CXL_MEM=3Dm
> CONFIG_CXL_PORT=3Dm
> CONFIG_CXL_REGION=3Dm
> CONFIG_PCCARD=3Dm
> CONFIG_PCMCIA=3Dm
> CONFIG_PCMCIA_LOAD_CIS=3Dy
> CONFIG_CARDBUS=3Dy
>=20
> #
> # PC-card bridges
> #
> CONFIG_YENTA=3Dm
> CONFIG_YENTA_O2=3Dy
> CONFIG_YENTA_RICOH=3Dy
> CONFIG_YENTA_TI=3Dy
> CONFIG_YENTA_ENE_TUNE=3Dy
> CONFIG_YENTA_TOSHIBA=3Dy
> CONFIG_PD6729=3Dm
> CONFIG_I82092=3Dm
> CONFIG_PCCARD_NONSTATIC=3Dy
> CONFIG_RAPIDIO=3Dy
> CONFIG_RAPIDIO_TSI721=3Dm
> CONFIG_RAPIDIO_DISC_TIMEOUT=3D30
> # CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
> CONFIG_RAPIDIO_DMA_ENGINE=3Dy
> # CONFIG_RAPIDIO_DEBUG is not set
> CONFIG_RAPIDIO_ENUM_BASIC=3Dm
> CONFIG_RAPIDIO_CHMAN=3Dm
> CONFIG_RAPIDIO_MPORT_CDEV=3Dm
>=20
> #
> # RapidIO Switch drivers
> #
> CONFIG_RAPIDIO_CPS_XX=3Dm
> CONFIG_RAPIDIO_CPS_GEN2=3Dm
> CONFIG_RAPIDIO_RXS_GEN3=3Dm
> # end of RapidIO Switch drivers
>=20
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=3Dy
> CONFIG_UEVENT_HELPER=3Dy
> CONFIG_UEVENT_HELPER_PATH=3D""
> CONFIG_DEVTMPFS=3Dy
> CONFIG_DEVTMPFS_MOUNT=3Dy
> # CONFIG_DEVTMPFS_SAFE is not set
> # CONFIG_STANDALONE is not set
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
>=20
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=3Dy
> CONFIG_FW_LOADER_PAGED_BUF=3Dy
> CONFIG_EXTRA_FIRMWARE=3D""
> CONFIG_FW_LOADER_USER_HELPER=3Dy
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> # CONFIG_FW_LOADER_COMPRESS is not set
> CONFIG_FW_CACHE=3Dy
> # end of Firmware loader
>=20
> CONFIG_WANT_DEV_COREDUMP=3Dy
> CONFIG_ALLOW_DEV_COREDUMP=3Dy
> CONFIG_DEV_COREDUMP=3Dy
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_HMEM_REPORTING=3Dy
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_SYS_HYPERVISOR=3Dy
> CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
> CONFIG_GENERIC_CPU_VULNERABILITIES=3Dy
> CONFIG_REGMAP=3Dy
> CONFIG_REGMAP_I2C=3Dy
> CONFIG_REGMAP_SPI=3Dy
> CONFIG_REGMAP_SPMI=3Dm
> CONFIG_REGMAP_W1=3Dm
> CONFIG_REGMAP_MMIO=3Dy
> CONFIG_REGMAP_IRQ=3Dy
> CONFIG_REGMAP_SOUNDWIRE=3Dm
> CONFIG_REGMAP_SOUNDWIRE_MBQ=3Dm
> CONFIG_DMA_SHARED_BUFFER=3Dy
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
>=20
> #
> # Bus devices
> #
> # CONFIG_MOXTET is not set
> # CONFIG_MHI_BUS is not set
> # end of Bus devices
>=20
> CONFIG_CONNECTOR=3Dy
> CONFIG_PROC_EVENTS=3Dy
>=20
> #
> # Firmware Drivers
> #
>=20
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
>=20
> CONFIG_EDD=3Dy
> CONFIG_EDD_OFF=3Dy
> CONFIG_FIRMWARE_MEMMAP=3Dy
> CONFIG_DMIID=3Dy
> CONFIG_DMI_SYSFS=3Dm
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy
> CONFIG_ISCSI_IBFT_FIND=3Dy
> CONFIG_ISCSI_IBFT=3Dm
> CONFIG_FW_CFG_SYSFS=3Dm
> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> CONFIG_SYSFB=3Dy
> # CONFIG_SYSFB_SIMPLEFB is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
>=20
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_VARS=3Dy
> CONFIG_EFI_ESRT=3Dy
> CONFIG_EFI_VARS_PSTORE=3Dy
> # CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
> CONFIG_EFI_RUNTIME_MAP=3Dy
> # CONFIG_EFI_FAKE_MEMMAP is not set
> CONFIG_EFI_SOFT_RESERVE=3Dy
> CONFIG_EFI_RUNTIME_WRAPPERS=3Dy
> CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=3Dy
> CONFIG_EFI_BOOTLOADER_CONTROL=3Dy
> CONFIG_EFI_CAPSULE_LOADER=3Dy
> CONFIG_EFI_TEST=3Dm
> CONFIG_APPLE_PROPERTIES=3Dy
> CONFIG_RESET_ATTACK_MITIGATION=3Dy
> # CONFIG_EFI_RCI2_TABLE is not set
> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> # end of EFI (Extensible Firmware Interface) Support
>=20
> CONFIG_UEFI_CPER=3Dy
> CONFIG_UEFI_CPER_X86=3Dy
> CONFIG_EFI_DEV_PATH_PARSER=3Dy
> CONFIG_EFI_EARLYCON=3Dy
> CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=3Dy
>=20
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
>=20
> # CONFIG_GNSS is not set
> CONFIG_MTD=3Dm
> # CONFIG_MTD_TESTS is not set
>=20
> #
> # Partition parsers
> #
> CONFIG_MTD_AR7_PARTS=3Dm
> CONFIG_MTD_CMDLINE_PARTS=3Dm
> CONFIG_MTD_OF_PARTS=3Dm
> CONFIG_MTD_REDBOOT_PARTS=3Dm
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=3D-1
> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> # end of Partition parsers
>=20
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=3Dm
> CONFIG_MTD_BLOCK=3Dm
> CONFIG_MTD_BLOCK_RO=3Dm
>=20
> #
> # Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
> #
> CONFIG_FTL=3Dm
> CONFIG_NFTL=3Dm
> CONFIG_NFTL_RW=3Dy
> CONFIG_INFTL=3Dm
> CONFIG_RFD_FTL=3Dm
> CONFIG_SSFDC=3Dm
> CONFIG_SM_FTL=3Dm
> CONFIG_MTD_OOPS=3Dm
> CONFIG_MTD_SWAP=3Dm
> # CONFIG_MTD_PARTITIONED_MASTER is not set
>=20
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=3Dm
> CONFIG_MTD_JEDECPROBE=3Dm
> CONFIG_MTD_GEN_PROBE=3Dm
> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
> CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
> CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
> CONFIG_MTD_CFI_I1=3Dy
> CONFIG_MTD_CFI_I2=3Dy
> CONFIG_MTD_CFI_INTELEXT=3Dm
> CONFIG_MTD_CFI_AMDSTD=3Dm
> CONFIG_MTD_CFI_STAA=3Dm
> CONFIG_MTD_CFI_UTIL=3Dm
> CONFIG_MTD_RAM=3Dm
> CONFIG_MTD_ROM=3Dm
> CONFIG_MTD_ABSENT=3Dm
> # end of RAM/ROM/Flash chip drivers
>=20
> #
> # Mapping drivers for chip access
> #
> CONFIG_MTD_COMPLEX_MAPPINGS=3Dy
> CONFIG_MTD_PHYSMAP=3Dm
> # CONFIG_MTD_PHYSMAP_COMPAT is not set
> # CONFIG_MTD_PHYSMAP_OF is not set
> # CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
> CONFIG_MTD_SBC_GXX=3Dm
> CONFIG_MTD_AMD76XROM=3Dm
> CONFIG_MTD_ICHXROM=3Dm
> CONFIG_MTD_ESB2ROM=3Dm
> CONFIG_MTD_CK804XROM=3Dm
> CONFIG_MTD_SCB2_FLASH=3Dm
> CONFIG_MTD_NETtel=3Dm
> CONFIG_MTD_L440GX=3Dm
> CONFIG_MTD_PCI=3Dm
> CONFIG_MTD_PCMCIA=3Dm
> # CONFIG_MTD_PCMCIA_ANONYMOUS is not set
> CONFIG_MTD_INTEL_VR_NOR=3Dm
> CONFIG_MTD_PLATRAM=3Dm
> # end of Mapping drivers for chip access
>=20
> #
> # Self-contained MTD device drivers
> #
> CONFIG_MTD_PMC551=3Dm
> # CONFIG_MTD_PMC551_BUGFIX is not set
> # CONFIG_MTD_PMC551_DEBUG is not set
> CONFIG_MTD_DATAFLASH=3Dm
> # CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
> CONFIG_MTD_DATAFLASH_OTP=3Dy
> CONFIG_MTD_MCHP23K256=3Dm
> # CONFIG_MTD_MCHP48L640 is not set
> CONFIG_MTD_SST25L=3Dm
> CONFIG_MTD_SLRAM=3Dm
> CONFIG_MTD_PHRAM=3Dm
> CONFIG_MTD_MTDRAM=3Dm
> CONFIG_MTDRAM_TOTAL_SIZE=3D4096
> CONFIG_MTDRAM_ERASE_SIZE=3D128
> CONFIG_MTD_BLOCK2MTD=3Dm
>=20
> #
> # Disk-On-Chip Device Drivers
> #
> CONFIG_MTD_DOCG3=3Dm
> CONFIG_BCH_CONST_M=3D14
> CONFIG_BCH_CONST_T=3D4
> # end of Self-contained MTD device drivers
>=20
> #
> # NAND
> #
> CONFIG_MTD_NAND_CORE=3Dm
> CONFIG_MTD_ONENAND=3Dm
> CONFIG_MTD_ONENAND_VERIFY_WRITE=3Dy
> CONFIG_MTD_ONENAND_GENERIC=3Dm
> # CONFIG_MTD_ONENAND_OTP is not set
> CONFIG_MTD_ONENAND_2X_PROGRAM=3Dy
> CONFIG_MTD_RAW_NAND=3Dm
>=20
> #
> # Raw/parallel NAND flash controllers
> #
> # CONFIG_MTD_NAND_DENALI_PCI is not set
> # CONFIG_MTD_NAND_DENALI_DT is not set
> # CONFIG_MTD_NAND_CAFE is not set
> # CONFIG_MTD_NAND_MXIC is not set
> CONFIG_MTD_NAND_GPIO=3Dm
> # CONFIG_MTD_NAND_PLATFORM is not set
> # CONFIG_MTD_NAND_CADENCE is not set
> # CONFIG_MTD_NAND_ARASAN is not set
> # CONFIG_MTD_NAND_INTEL_LGM is not set
>=20
> #
> # Misc
> #
> # CONFIG_MTD_NAND_NANDSIM is not set
> # CONFIG_MTD_NAND_RICOH is not set
> # CONFIG_MTD_NAND_DISKONCHIP is not set
> # CONFIG_MTD_SPI_NAND is not set
>=20
> #
> # ECC engine support
> #
> CONFIG_MTD_NAND_ECC=3Dy
> CONFIG_MTD_NAND_ECC_SW_HAMMING=3Dy
> # CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
> # CONFIG_MTD_NAND_ECC_SW_BCH is not set
> # CONFIG_MTD_NAND_ECC_MXIC is not set
> # end of ECC engine support
> # end of NAND
>=20
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=3Dm
> CONFIG_MTD_QINFO_PROBE=3Dm
> # end of LPDDR & LPDDR2 PCM memory drivers
>=20
> CONFIG_MTD_SPI_NOR=3Dm
> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=3Dy
> # CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
> CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=3Dy
> # CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
> CONFIG_MTD_UBI=3Dm
> CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> CONFIG_MTD_UBI_BEB_LIMIT=3D20
> CONFIG_MTD_UBI_FASTMAP=3Dy
> CONFIG_MTD_UBI_GLUEBI=3Dm
> CONFIG_MTD_UBI_BLOCK=3Dy
> # CONFIG_MTD_HYPERBUS is not set
> CONFIG_OF=3Dy
> # CONFIG_OF_UNITTEST is not set
> CONFIG_OF_KOBJ=3Dy
> CONFIG_OF_ADDRESS=3Dy
> CONFIG_OF_IRQ=3Dy
> # CONFIG_OF_OVERLAY is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
> CONFIG_PARPORT=3Dm
> CONFIG_PARPORT_PC=3Dm
> CONFIG_PARPORT_SERIAL=3Dm
> CONFIG_PARPORT_PC_FIFO=3Dy
> # CONFIG_PARPORT_PC_SUPERIO is not set
> CONFIG_PARPORT_PC_PCMCIA=3Dm
> CONFIG_PARPORT_AX88796=3Dm
> CONFIG_PARPORT_1284=3Dy
> CONFIG_PARPORT_NOT_PC=3Dy
> CONFIG_PNP=3Dy
> # CONFIG_PNP_DEBUG_MESSAGES is not set
>=20
> #
> # Protocols
> #
> CONFIG_PNPACPI=3Dy
> CONFIG_BLK_DEV=3Dy
> CONFIG_BLK_DEV_NULL_BLK=3Dm
> CONFIG_BLK_DEV_FD=3Dm
> CONFIG_CDROM=3Dm
> CONFIG_PARIDE=3Dm
>=20
> #
> # Parallel IDE high-level drivers
> #
> CONFIG_PARIDE_PD=3Dm
> CONFIG_PARIDE_PCD=3Dm
> CONFIG_PARIDE_PF=3Dm
> CONFIG_PARIDE_PT=3Dm
> CONFIG_PARIDE_PG=3Dm
>=20
> #
> # Parallel IDE protocol modules
> #
> CONFIG_PARIDE_ATEN=3Dm
> CONFIG_PARIDE_BPCK=3Dm
> CONFIG_PARIDE_COMM=3Dm
> CONFIG_PARIDE_DSTR=3Dm
> CONFIG_PARIDE_FIT2=3Dm
> CONFIG_PARIDE_FIT3=3Dm
> CONFIG_PARIDE_EPAT=3Dm
> CONFIG_PARIDE_EPATC8=3Dy
> CONFIG_PARIDE_EPIA=3Dm
> CONFIG_PARIDE_FRIQ=3Dm
> CONFIG_PARIDE_FRPW=3Dm
> CONFIG_PARIDE_KBIC=3Dm
> CONFIG_PARIDE_KTTI=3Dm
> CONFIG_PARIDE_ON20=3Dm
> CONFIG_PARIDE_ON26=3Dm
> CONFIG_BLK_DEV_PCIESSD_MTIP32XX=3Dm
> CONFIG_ZRAM=3Dm
> CONFIG_ZRAM_DEF_COMP_LZORLE=3Dy
> # CONFIG_ZRAM_DEF_COMP_ZSTD is not set
> # CONFIG_ZRAM_DEF_COMP_LZ4 is not set
> # CONFIG_ZRAM_DEF_COMP_LZO is not set
> # CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
> # CONFIG_ZRAM_DEF_COMP_842 is not set
> CONFIG_ZRAM_DEF_COMP=3D"lzo-rle"
> CONFIG_ZRAM_WRITEBACK=3Dy
> # CONFIG_ZRAM_MEMORY_TRACKING is not set
> CONFIG_BLK_DEV_LOOP=3Dy
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
> CONFIG_BLK_DEV_DRBD=3Dm
> # CONFIG_DRBD_FAULT_INJECTION is not set
> CONFIG_BLK_DEV_NBD=3Dm
> CONFIG_BLK_DEV_SX8=3Dm
> CONFIG_BLK_DEV_RAM=3Dy
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_BLK_DEV_RAM_SIZE=3D65536
> CONFIG_CDROM_PKTCDVD=3Dm
> CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> CONFIG_ATA_OVER_ETH=3Dm
> CONFIG_XEN_BLKDEV_FRONTEND=3Dy
> CONFIG_XEN_BLKDEV_BACKEND=3Dm
> CONFIG_VIRTIO_BLK=3Dy
> CONFIG_BLK_DEV_RBD=3Dm
>=20
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=3Dy
> CONFIG_BLK_DEV_NVME=3Dy
> CONFIG_NVME_MULTIPATH=3Dy
> # CONFIG_NVME_VERBOSE_ERRORS is not set
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=3Dy
> CONFIG_NVME_RDMA=3Dm
> CONFIG_NVME_FC=3Dy
> CONFIG_NVME_TCP=3Dy
> CONFIG_NVME_TARGET=3Dy
> CONFIG_NVME_TARGET_PASSTHRU=3Dy
> CONFIG_NVME_TARGET_LOOP=3Dy
> CONFIG_NVME_TARGET_RDMA=3Dm
> CONFIG_NVME_TARGET_FC=3Dy
> CONFIG_NVME_TARGET_FCLOOP=3Dy
> CONFIG_NVME_TARGET_TCP=3Dy
> # end of NVME Support
>=20
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=3Dm
> CONFIG_AD525X_DPOT=3Dm
> CONFIG_AD525X_DPOT_I2C=3Dm
> CONFIG_AD525X_DPOT_SPI=3Dm
> CONFIG_DUMMY_IRQ=3Dm
> CONFIG_IBM_ASM=3Dm
> CONFIG_PHANTOM=3Dm
> CONFIG_TIFM_CORE=3Dm
> CONFIG_TIFM_7XX1=3Dm
> CONFIG_ICS932S401=3Dm
> CONFIG_ENCLOSURE_SERVICES=3Dm
> # CONFIG_HI6421V600_IRQ is not set
> CONFIG_HP_ILO=3Dm
> CONFIG_APDS9802ALS=3Dm
> CONFIG_ISL29003=3Dm
> CONFIG_ISL29020=3Dm
> CONFIG_SENSORS_TSL2550=3Dm
> CONFIG_SENSORS_BH1770=3Dm
> CONFIG_SENSORS_APDS990X=3Dm
> CONFIG_HMC6352=3Dm
> CONFIG_DS1682=3Dm
> CONFIG_VMWARE_BALLOON=3Dm
> CONFIG_LATTICE_ECP3_CONFIG=3Dm
> CONFIG_SRAM=3Dy
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> CONFIG_MISC_RTSX=3Dm
> # CONFIG_HISI_HIKEY_USB is not set
> CONFIG_C2PORT=3Dm
> CONFIG_C2PORT_DURAMAR_2150=3Dm
>=20
> #
> # EEPROM support
> #
> CONFIG_EEPROM_AT24=3Dm
> CONFIG_EEPROM_AT25=3Dm
> CONFIG_EEPROM_LEGACY=3Dm
> CONFIG_EEPROM_MAX6875=3Dm
> CONFIG_EEPROM_93CX6=3Dm
> CONFIG_EEPROM_93XX46=3Dm
> CONFIG_EEPROM_IDT_89HPESX=3Dm
> # CONFIG_EEPROM_EE1004 is not set
> # end of EEPROM support
>=20
> CONFIG_CB710_CORE=3Dm
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=3Dy
>=20
> #
> # Texas Instruments shared transport line discipline
> #
> CONFIG_TI_ST=3Dm
> # end of Texas Instruments shared transport line discipline
>=20
> CONFIG_SENSORS_LIS3_I2C=3Dm
> CONFIG_ALTERA_STAPL=3Dm
> CONFIG_INTEL_MEI=3Dm
> CONFIG_INTEL_MEI_ME=3Dm
> CONFIG_INTEL_MEI_TXE=3Dm
> # CONFIG_INTEL_MEI_VIRTIO is not set
> # CONFIG_INTEL_MEI_GSC is not set
> # CONFIG_INTEL_MEI_BUS_DMA_TEST is not set
> CONFIG_INTEL_MEI_HDCP=3Dm
> # CONFIG_INTEL_MEI_PXP is not set
> CONFIG_INTEL_MEI_GSC_PROXY=3Dm
> CONFIG_INTEL_MEI_IAF=3Dm
> CONFIG_VMWARE_VMCI=3Dm
> CONFIG_GENWQE=3Dm
> CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=3D0
> CONFIG_ECHO=3Dm
> # CONFIG_BCM_VK is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> CONFIG_MISC_RTSX_PCI=3Dm
> CONFIG_MISC_RTSX_USB=3Dm
> # CONFIG_HABANA_AI is not set
> CONFIG_UACCE=3Dy
> # CONFIG_PVPANIC is not set
> # end of Misc devices
>=20
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=3Dy
> CONFIG_RAID_ATTRS=3Dm
> CONFIG_SCSI_COMMON=3Dy
> CONFIG_SCSI=3Dy
> CONFIG_SCSI_DMA=3Dy
> CONFIG_SCSI_NETLINK=3Dy
> CONFIG_SCSI_PROC_FS=3Dy
>=20
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=3Dy
> CONFIG_CHR_DEV_ST=3Dm
> CONFIG_BLK_DEV_SR=3Dm
> CONFIG_CHR_DEV_SG=3Dy
> CONFIG_BLK_DEV_BSG=3Dy
> CONFIG_CHR_DEV_SCH=3Dm
> CONFIG_SCSI_ENCLOSURE=3Dm
> CONFIG_SCSI_CONSTANTS=3Dy
> CONFIG_SCSI_LOGGING=3Dy
> CONFIG_SCSI_SCAN_ASYNC=3Dy
>=20
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=3Dm
> CONFIG_SCSI_FC_ATTRS=3Dm
> CONFIG_SCSI_ISCSI_ATTRS=3Dm
> CONFIG_SCSI_SAS_ATTRS=3Dm
> CONFIG_SCSI_SAS_LIBSAS=3Dm
> CONFIG_SCSI_SAS_ATA=3Dy
> CONFIG_SCSI_SAS_HOST_SMP=3Dy
> CONFIG_SCSI_SRP_ATTRS=3Dm
> # end of SCSI Transports
>=20
> CONFIG_SCSI_LOWLEVEL=3Dy
> CONFIG_ISCSI_TCP=3Dm
> CONFIG_ISCSI_BOOT_SYSFS=3Dm
> CONFIG_SCSI_CXGB3_ISCSI=3Dm
> CONFIG_SCSI_CXGB4_ISCSI=3Dm
> CONFIG_SCSI_BNX2_ISCSI=3Dm
> CONFIG_SCSI_BNX2X_FCOE=3Dm
> CONFIG_BE2ISCSI=3Dm
> CONFIG_BLK_DEV_3W_XXXX_RAID=3Dm
> CONFIG_SCSI_HPSA=3Dm
> CONFIG_SCSI_3W_9XXX=3Dm
> CONFIG_SCSI_3W_SAS=3Dm
> CONFIG_SCSI_ACARD=3Dm
> CONFIG_SCSI_AACRAID=3Dm
> CONFIG_SCSI_AIC7XXX=3Dm
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D8
> CONFIG_AIC7XXX_RESET_DELAY_MS=3D5000
> # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
> CONFIG_AIC7XXX_DEBUG_MASK=3D0
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
> CONFIG_SCSI_AIC79XX=3Dm
> CONFIG_AIC79XX_CMDS_PER_DEVICE=3D32
> CONFIG_AIC79XX_RESET_DELAY_MS=3D5000
> # CONFIG_AIC79XX_DEBUG_ENABLE is not set
> CONFIG_AIC79XX_DEBUG_MASK=3D0
> CONFIG_AIC79XX_REG_PRETTY_PRINT=3Dy
> CONFIG_SCSI_AIC94XX=3Dm
> # CONFIG_AIC94XX_DEBUG is not set
> CONFIG_SCSI_MVSAS=3Dm
> # CONFIG_SCSI_MVSAS_DEBUG is not set
> # CONFIG_SCSI_MVSAS_TASKLET is not set
> CONFIG_SCSI_MVUMI=3Dm
> CONFIG_SCSI_DPT_I2O=3Dm
> CONFIG_SCSI_ADVANSYS=3Dm
> CONFIG_SCSI_ARCMSR=3Dm
> CONFIG_SCSI_ESAS2R=3Dm
> CONFIG_MEGARAID_NEWGEN=3Dy
> CONFIG_MEGARAID_MM=3Dm
> CONFIG_MEGARAID_MAILBOX=3Dm
> CONFIG_MEGARAID_LEGACY=3Dm
> CONFIG_MEGARAID_SAS=3Dm
> CONFIG_SCSI_MPT3SAS=3Dm
> CONFIG_SCSI_MPT2SAS_MAX_SGE=3D128
> CONFIG_SCSI_MPT3SAS_MAX_SGE=3D128
> CONFIG_SCSI_MPT2SAS=3Dm
> # CONFIG_SCSI_MPI3MR is not set
> CONFIG_SCSI_SMARTPQI=3Dm
> CONFIG_SCSI_UFSHCD=3Dm
> CONFIG_SCSI_UFSHCD_PCI=3Dm
> CONFIG_SCSI_UFS_DWC_TC_PCI=3Dm
> CONFIG_SCSI_UFSHCD_PLATFORM=3Dm
> # CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
> CONFIG_SCSI_UFS_DWC_TC_PLATFORM=3Dm
> CONFIG_SCSI_UFS_BSG=3Dy
> CONFIG_SCSI_UFS_CRYPTO=3Dy
> # CONFIG_SCSI_UFS_HPB is not set
> # CONFIG_SCSI_UFS_HWMON is not set
> CONFIG_SCSI_HPTIOP=3Dm
> CONFIG_SCSI_BUSLOGIC=3Dm
> CONFIG_SCSI_FLASHPOINT=3Dy
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
> CONFIG_VMWARE_PVSCSI=3Dm
> CONFIG_XEN_SCSI_FRONTEND=3Dm
> CONFIG_HYPERV_STORAGE=3Dm
> CONFIG_LIBFC=3Dm
> CONFIG_LIBFCOE=3Dm
> CONFIG_FCOE=3Dm
> CONFIG_FCOE_FNIC=3Dm
> CONFIG_SCSI_SNIC=3Dm
> # CONFIG_SCSI_SNIC_DEBUG_FS is not set
> CONFIG_SCSI_DMX3191D=3Dm
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> CONFIG_SCSI_ISCI=3Dm
> CONFIG_SCSI_IPS=3Dm
> CONFIG_SCSI_INITIO=3Dm
> CONFIG_SCSI_INIA100=3Dm
> CONFIG_SCSI_PPA=3Dm
> CONFIG_SCSI_IMM=3Dm
> # CONFIG_SCSI_IZIP_EPP16 is not set
> # CONFIG_SCSI_IZIP_SLOW_CTR is not set
> CONFIG_SCSI_STEX=3Dm
> CONFIG_SCSI_SYM53C8XX_2=3Dm
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
> CONFIG_SCSI_SYM53C8XX_MMIO=3Dy
> CONFIG_SCSI_IPR=3Dm
> CONFIG_SCSI_IPR_TRACE=3Dy
> CONFIG_SCSI_IPR_DUMP=3Dy
> CONFIG_SCSI_QLOGIC_1280=3Dm
> CONFIG_SCSI_QLA_FC=3Dm
> CONFIG_TCM_QLA2XXX=3Dm
> # CONFIG_TCM_QLA2XXX_DEBUG is not set
> CONFIG_SCSI_QLA_ISCSI=3Dm
> CONFIG_QEDI=3Dm
> CONFIG_QEDF=3Dm
> CONFIG_SCSI_LPFC=3Dm
> # CONFIG_SCSI_LPFC_DEBUG_FS is not set
> # CONFIG_SCSI_EFCT is not set
> CONFIG_SCSI_DC395x=3Dm
> CONFIG_SCSI_AM53C974=3Dm
> CONFIG_SCSI_WD719X=3Dm
> CONFIG_SCSI_DEBUG=3Dm
> CONFIG_SCSI_PMCRAID=3Dm
> CONFIG_SCSI_PM8001=3Dm
> CONFIG_SCSI_BFA_FC=3Dm
> CONFIG_SCSI_VIRTIO=3Dy
> CONFIG_SCSI_CHELSIO_FCOE=3Dm
> CONFIG_SCSI_LOWLEVEL_PCMCIA=3Dy
> CONFIG_PCMCIA_AHA152X=3Dm
> # CONFIG_PCMCIA_FDOMAIN is not set
> CONFIG_PCMCIA_QLOGIC=3Dm
> CONFIG_PCMCIA_SYM53C500=3Dm
> CONFIG_SCSI_DH=3Dy
> CONFIG_SCSI_DH_RDAC=3Dm
> CONFIG_SCSI_DH_HP_SW=3Dm
> CONFIG_SCSI_DH_EMC=3Dm
> CONFIG_SCSI_DH_ALUA=3Dm
> # end of SCSI device support
>=20
> CONFIG_ATA=3Dy
> CONFIG_SATA_HOST=3Dy
> CONFIG_PATA_TIMINGS=3Dy
> CONFIG_ATA_VERBOSE_ERROR=3Dy
> CONFIG_ATA_FORCE=3Dy
> CONFIG_ATA_ACPI=3Dy
> CONFIG_SATA_ZPODD=3Dy
> CONFIG_SATA_PMP=3Dy
>=20
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=3Dy
> CONFIG_SATA_MOBILE_LPM_POLICY=3D3
> CONFIG_SATA_AHCI_PLATFORM=3Dy
> # CONFIG_AHCI_CEVA is not set
> # CONFIG_AHCI_QORIQ is not set
> CONFIG_SATA_INIC162X=3Dm
> CONFIG_SATA_ACARD_AHCI=3Dm
> CONFIG_SATA_SIL24=3Dm
> CONFIG_ATA_SFF=3Dy
>=20
> #
> # SFF controllers with custom DMA interface
> #
> CONFIG_PDC_ADMA=3Dm
> CONFIG_SATA_QSTOR=3Dm
> CONFIG_SATA_SX4=3Dm
> CONFIG_ATA_BMDMA=3Dy
>=20
> #
> # SATA SFF controllers with BMDMA
> #
> CONFIG_ATA_PIIX=3Dy
> CONFIG_SATA_DWC=3Dm
> CONFIG_SATA_DWC_OLD_DMA=3Dy
> CONFIG_SATA_MV=3Dm
> CONFIG_SATA_NV=3Dm
> CONFIG_SATA_PROMISE=3Dm
> CONFIG_SATA_SIL=3Dm
> CONFIG_SATA_SIS=3Dm
> CONFIG_SATA_SVW=3Dm
> CONFIG_SATA_ULI=3Dm
> CONFIG_SATA_VIA=3Dm
> CONFIG_SATA_VITESSE=3Dm
>=20
> #
> # PATA SFF controllers with BMDMA
> #
> CONFIG_PATA_ALI=3Dm
> CONFIG_PATA_AMD=3Dm
> CONFIG_PATA_ARTOP=3Dm
> CONFIG_PATA_ATIIXP=3Dm
> CONFIG_PATA_ATP867X=3Dm
> CONFIG_PATA_CMD64X=3Dm
> CONFIG_PATA_CYPRESS=3Dm
> CONFIG_PATA_EFAR=3Dm
> CONFIG_PATA_HPT366=3Dm
> CONFIG_PATA_HPT37X=3Dm
> CONFIG_PATA_HPT3X2N=3Dm
> CONFIG_PATA_HPT3X3=3Dm
> # CONFIG_PATA_HPT3X3_DMA is not set
> CONFIG_PATA_IT8213=3Dm
> CONFIG_PATA_IT821X=3Dm
> CONFIG_PATA_JMICRON=3Dm
> CONFIG_PATA_MARVELL=3Dm
> CONFIG_PATA_NETCELL=3Dm
> CONFIG_PATA_NINJA32=3Dm
> CONFIG_PATA_NS87415=3Dm
> CONFIG_PATA_OLDPIIX=3Dm
> CONFIG_PATA_OPTIDMA=3Dm
> CONFIG_PATA_PDC2027X=3Dm
> CONFIG_PATA_PDC_OLD=3Dm
> CONFIG_PATA_RADISYS=3Dm
> CONFIG_PATA_RDC=3Dm
> CONFIG_PATA_SCH=3Dm
> CONFIG_PATA_SERVERWORKS=3Dm
> CONFIG_PATA_SIL680=3Dm
> CONFIG_PATA_SIS=3Dy
> CONFIG_PATA_TOSHIBA=3Dm
> CONFIG_PATA_TRIFLEX=3Dm
> CONFIG_PATA_VIA=3Dm
> CONFIG_PATA_WINBOND=3Dm
>=20
> #
> # PIO-only SFF controllers
> #
> CONFIG_PATA_CMD640_PCI=3Dm
> CONFIG_PATA_MPIIX=3Dm
> CONFIG_PATA_NS87410=3Dm
> CONFIG_PATA_OPTI=3Dm
> CONFIG_PATA_PCMCIA=3Dm
> CONFIG_PATA_PLATFORM=3Dm
> # CONFIG_PATA_OF_PLATFORM is not set
> CONFIG_PATA_RZ1000=3Dm
>=20
> #
> # Generic fallback / legacy drivers
> #
> CONFIG_PATA_ACPI=3Dm
> CONFIG_ATA_GENERIC=3Dy
> CONFIG_PATA_LEGACY=3Dm
> CONFIG_MD=3Dy
> CONFIG_BLK_DEV_MD=3Dy
> CONFIG_MD_AUTODETECT=3Dy
> CONFIG_MD_LINEAR=3Dm
> CONFIG_MD_RAID0=3Dm
> CONFIG_MD_RAID1=3Dm
> CONFIG_MD_RAID10=3Dm
> CONFIG_MD_RAID456=3Dm
> CONFIG_MD_MULTIPATH=3Dm
> CONFIG_MD_FAULTY=3Dm
> CONFIG_MD_CLUSTER=3Dm
> CONFIG_BCACHE=3Dm
> # CONFIG_BCACHE_DEBUG is not set
> # CONFIG_BCACHE_CLOSURES_DEBUG is not set
> # CONFIG_BCACHE_ASYNC_REGISTRATION is not set
> CONFIG_BLK_DEV_DM_BUILTIN=3Dy
> CONFIG_BLK_DEV_DM=3Dy
> # CONFIG_DM_DEBUG is not set
> CONFIG_DM_BUFIO=3Dm
> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> CONFIG_DM_BIO_PRISON=3Dm
> CONFIG_DM_PERSISTENT_DATA=3Dm
> CONFIG_DM_UNSTRIPED=3Dm
> CONFIG_DM_CRYPT=3Dm
> CONFIG_DM_SNAPSHOT=3Dm
> CONFIG_DM_THIN_PROVISIONING=3Dm
> CONFIG_DM_CACHE=3Dm
> CONFIG_DM_CACHE_SMQ=3Dm
> # CONFIG_DM_WRITECACHE is not set
> # CONFIG_DM_EBS is not set
> CONFIG_DM_ERA=3Dm
> # CONFIG_DM_CLONE is not set
> CONFIG_DM_MIRROR=3Dm
> CONFIG_DM_LOG_USERSPACE=3Dm
> CONFIG_DM_RAID=3Dm
> CONFIG_DM_ZERO=3Dm
> CONFIG_DM_MULTIPATH=3Dm
> CONFIG_DM_MULTIPATH_QL=3Dm
> CONFIG_DM_MULTIPATH_ST=3Dm
> # CONFIG_DM_MULTIPATH_HST is not set
> # CONFIG_DM_MULTIPATH_IOA is not set
> CONFIG_DM_DELAY=3Dm
> # CONFIG_DM_DUST is not set
> # CONFIG_DM_INIT is not set
> CONFIG_DM_UEVENT=3Dy
> CONFIG_DM_FLAKEY=3Dm
> CONFIG_DM_VERITY=3Dm
> # CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
> # CONFIG_DM_VERITY_FEC is not set
> CONFIG_DM_SWITCH=3Dm
> CONFIG_DM_LOG_WRITES=3Dm
> CONFIG_DM_INTEGRITY=3Dm
> CONFIG_DM_ZONED=3Dm
> CONFIG_DM_AUDIT=3Dy
> CONFIG_TARGET_CORE=3Dm
> CONFIG_TCM_IBLOCK=3Dm
> CONFIG_TCM_FILEIO=3Dm
> CONFIG_TCM_PSCSI=3Dm
> CONFIG_TCM_USER2=3Dm
> CONFIG_LOOPBACK_TARGET=3Dm
> CONFIG_TCM_FC=3Dm
> CONFIG_ISCSI_TARGET=3Dm
> CONFIG_ISCSI_TARGET_CXGB4=3Dm
> CONFIG_SBP_TARGET=3Dm
> CONFIG_FUSION=3Dy
> CONFIG_FUSION_SPI=3Dm
> CONFIG_FUSION_FC=3Dm
> CONFIG_FUSION_SAS=3Dm
> CONFIG_FUSION_MAX_SGE=3D128
> CONFIG_FUSION_CTL=3Dm
> CONFIG_FUSION_LAN=3Dm
> CONFIG_FUSION_LOGGING=3Dy
>=20
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=3Dm
> CONFIG_FIREWIRE_OHCI=3Dm
> CONFIG_FIREWIRE_SBP2=3Dm
> CONFIG_FIREWIRE_NET=3Dm
> CONFIG_FIREWIRE_NOSY=3Dm
> # end of IEEE 1394 (FireWire) support
>=20
> CONFIG_MACINTOSH_DRIVERS=3Dy
> CONFIG_MAC_EMUMOUSEBTN=3Dm
> CONFIG_NETDEVICES=3Dy
> CONFIG_MII=3Dy
> CONFIG_NET_CORE=3Dy
> CONFIG_BONDING=3Dm
> CONFIG_DUMMY=3Dm
> # CONFIG_WIREGUARD is not set
> CONFIG_EQUALIZER=3Dm
> CONFIG_NET_FC=3Dy
> CONFIG_IFB=3Dm
> CONFIG_NET_TEAM=3Dm
> CONFIG_NET_TEAM_MODE_BROADCAST=3Dm
> CONFIG_NET_TEAM_MODE_ROUNDROBIN=3Dm
> CONFIG_NET_TEAM_MODE_RANDOM=3Dm
> CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=3Dm
> CONFIG_NET_TEAM_MODE_LOADBALANCE=3Dm
> CONFIG_MACVLAN=3Dm
> CONFIG_MACVTAP=3Dm
> CONFIG_IPVLAN_L3S=3Dy
> CONFIG_IPVLAN=3Dm
> CONFIG_IPVTAP=3Dm
> CONFIG_VXLAN=3Dm
> CONFIG_GENEVE=3Dm
> # CONFIG_BAREUDP is not set
> CONFIG_GTP=3Dm
> # CONFIG_AMT is not set
> CONFIG_MACSEC=3Dm
> CONFIG_NETCONSOLE=3Dm
> CONFIG_NETCONSOLE_DYNAMIC=3Dy
> CONFIG_NETPOLL=3Dy
> CONFIG_NET_POLL_CONTROLLER=3Dy
> CONFIG_NTB_NETDEV=3Dm
> CONFIG_RIONET=3Dm
> CONFIG_RIONET_TX_SIZE=3D128
> CONFIG_RIONET_RX_SIZE=3D128
> CONFIG_TUN=3Dy
> CONFIG_TAP=3Dm
> # CONFIG_TUN_VNET_CROSS_LE is not set
> CONFIG_VETH=3Dm
> CONFIG_VIRTIO_NET=3Dy
> CONFIG_NLMON=3Dm
> CONFIG_NET_VRF=3Dm
> CONFIG_VSOCKMON=3Dm
> CONFIG_SUNGEM_PHY=3Dm
> CONFIG_ARCNET=3Dm
> CONFIG_ARCNET_1201=3Dm
> CONFIG_ARCNET_1051=3Dm
> CONFIG_ARCNET_RAW=3Dm
> CONFIG_ARCNET_CAP=3Dm
> CONFIG_ARCNET_COM90xx=3Dm
> CONFIG_ARCNET_COM90xxIO=3Dm
> CONFIG_ARCNET_RIM_I=3Dm
> CONFIG_ARCNET_COM20020=3Dm
> CONFIG_ARCNET_COM20020_PCI=3Dm
> CONFIG_ARCNET_COM20020_CS=3Dm
> CONFIG_ATM_DRIVERS=3Dy
> CONFIG_ATM_DUMMY=3Dm
> CONFIG_ATM_TCP=3Dm
> CONFIG_ATM_LANAI=3Dm
> CONFIG_ATM_ENI=3Dm
> # CONFIG_ATM_ENI_DEBUG is not set
> # CONFIG_ATM_ENI_TUNE_BURST is not set
> CONFIG_ATM_FIRESTREAM=3Dm
> CONFIG_ATM_ZATM=3Dm
> # CONFIG_ATM_ZATM_DEBUG is not set
> CONFIG_ATM_NICSTAR=3Dm
> # CONFIG_ATM_NICSTAR_USE_SUNI is not set
> # CONFIG_ATM_NICSTAR_USE_IDT77105 is not set
> CONFIG_ATM_IDT77252=3Dm
> # CONFIG_ATM_IDT77252_DEBUG is not set
> # CONFIG_ATM_IDT77252_RCV_ALL is not set
> CONFIG_ATM_IDT77252_USE_SUNI=3Dy
> CONFIG_ATM_AMBASSADOR=3Dm
> # CONFIG_ATM_AMBASSADOR_DEBUG is not set
> CONFIG_ATM_HORIZON=3Dm
> # CONFIG_ATM_HORIZON_DEBUG is not set
> CONFIG_ATM_IA=3Dm
> # CONFIG_ATM_IA_DEBUG is not set
> CONFIG_ATM_FORE200E=3Dm
> # CONFIG_ATM_FORE200E_USE_TASKLET is not set
> CONFIG_ATM_FORE200E_TX_RETRY=3D16
> CONFIG_ATM_FORE200E_DEBUG=3D0
> CONFIG_ATM_HE=3Dm
> CONFIG_ATM_HE_USE_SUNI=3Dy
> CONFIG_ATM_SOLOS=3Dm
> # CONFIG_CAIF_DRIVERS is not set
>=20
> #
> # Distributed Switch Architecture drivers
> #
> CONFIG_B53=3Dm
> CONFIG_B53_SPI_DRIVER=3Dm
> CONFIG_B53_MDIO_DRIVER=3Dm
> CONFIG_B53_MMAP_DRIVER=3Dm
> CONFIG_B53_SRAB_DRIVER=3Dm
> # CONFIG_B53_SERDES is not set
> # CONFIG_NET_DSA_BCM_SF2 is not set
> # CONFIG_NET_DSA_LOOP is not set
> # CONFIG_NET_DSA_LANTIQ_GSWIP is not set
> CONFIG_NET_DSA_MT7530=3Dm
> CONFIG_NET_DSA_MV88E6060=3Dm
> # CONFIG_NET_DSA_MICROCHIP_KSZ9477 is not set
> # CONFIG_NET_DSA_MICROCHIP_KSZ8795 is not set
> CONFIG_NET_DSA_MV88E6XXX=3Dm
> # CONFIG_NET_DSA_MV88E6XXX_PTP is not set
> # CONFIG_NET_DSA_MSCC_SEVILLE is not set
> # CONFIG_NET_DSA_AR9331 is not set
> # CONFIG_NET_DSA_SJA1105 is not set
> # CONFIG_NET_DSA_XRS700X_I2C is not set
> # CONFIG_NET_DSA_XRS700X_MDIO is not set
> CONFIG_NET_DSA_QCA8K=3Dm
> # CONFIG_NET_DSA_REALTEK is not set
> CONFIG_NET_DSA_SMSC_LAN9303=3Dm
> CONFIG_NET_DSA_SMSC_LAN9303_I2C=3Dm
> CONFIG_NET_DSA_SMSC_LAN9303_MDIO=3Dm
> # CONFIG_NET_DSA_VITESSE_VSC73XX_SPI is not set
> # CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM is not set
> # end of Distributed Switch Architecture drivers
>=20
> CONFIG_ETHERNET=3Dy
> CONFIG_MDIO=3Dm
> CONFIG_NET_VENDOR_3COM=3Dy
> CONFIG_PCMCIA_3C574=3Dm
> CONFIG_PCMCIA_3C589=3Dm
> CONFIG_VORTEX=3Dm
> CONFIG_TYPHOON=3Dm
> CONFIG_NET_VENDOR_ADAPTEC=3Dy
> CONFIG_ADAPTEC_STARFIRE=3Dm
> CONFIG_NET_VENDOR_AGERE=3Dy
> CONFIG_ET131X=3Dm
> CONFIG_NET_VENDOR_ALACRITECH=3Dy
> CONFIG_SLICOSS=3Dm
> CONFIG_NET_VENDOR_ALTEON=3Dy
> CONFIG_ACENIC=3Dm
> # CONFIG_ACENIC_OMIT_TIGON_I is not set
> CONFIG_ALTERA_TSE=3Dm
> CONFIG_NET_VENDOR_AMAZON=3Dy
> CONFIG_ENA_ETHERNET=3Dm
> CONFIG_NET_VENDOR_AMD=3Dy
> CONFIG_AMD8111_ETH=3Dm
> CONFIG_PCNET32=3Dm
> CONFIG_PCMCIA_NMCLAN=3Dm
> CONFIG_AMD_XGBE=3Dm
> CONFIG_AMD_XGBE_DCB=3Dy
> CONFIG_AMD_XGBE_HAVE_ECC=3Dy
> CONFIG_NET_VENDOR_AQUANTIA=3Dy
> CONFIG_AQTION=3Dm
> CONFIG_NET_VENDOR_ARC=3Dy
> CONFIG_NET_VENDOR_ASIX=3Dy
> # CONFIG_SPI_AX88796C is not set
> CONFIG_NET_VENDOR_ATHEROS=3Dy
> CONFIG_ATL2=3Dm
> CONFIG_ATL1=3Dm
> CONFIG_ATL1E=3Dm
> CONFIG_ATL1C=3Dm
> CONFIG_ALX=3Dm
> CONFIG_CX_ECAT=3Dm
> CONFIG_NET_VENDOR_BROADCOM=3Dy
> CONFIG_B44=3Dm
> CONFIG_B44_PCI_AUTOSELECT=3Dy
> CONFIG_B44_PCICORE_AUTOSELECT=3Dy
> CONFIG_B44_PCI=3Dy
> # CONFIG_BCMGENET is not set
> CONFIG_BNX2=3Dm
> CONFIG_CNIC=3Dm
> CONFIG_TIGON3=3Dm
> CONFIG_TIGON3_HWMON=3Dy
> CONFIG_BNX2X=3Dm
> CONFIG_BNX2X_SRIOV=3Dy
> # CONFIG_SYSTEMPORT is not set
> CONFIG_BNXT=3Dm
> CONFIG_BNXT_SRIOV=3Dy
> CONFIG_BNXT_FLOWER_OFFLOAD=3Dy
> CONFIG_BNXT_DCB=3Dy
> CONFIG_BNXT_HWMON=3Dy
> CONFIG_NET_VENDOR_CADENCE=3Dy
> CONFIG_MACB=3Dm
> CONFIG_MACB_USE_HWSTAMP=3Dy
> CONFIG_MACB_PCI=3Dm
> CONFIG_NET_VENDOR_CAVIUM=3Dy
> CONFIG_THUNDER_NIC_PF=3Dm
> CONFIG_THUNDER_NIC_VF=3Dm
> CONFIG_THUNDER_NIC_BGX=3Dm
> CONFIG_THUNDER_NIC_RGX=3Dm
> CONFIG_CAVIUM_PTP=3Dm
> CONFIG_LIQUIDIO=3Dm
> CONFIG_LIQUIDIO_VF=3Dm
> CONFIG_NET_VENDOR_CHELSIO=3Dy
> CONFIG_CHELSIO_T1=3Dm
> CONFIG_CHELSIO_T1_1G=3Dy
> CONFIG_CHELSIO_T3=3Dm
> CONFIG_CHELSIO_T4=3Dm
> CONFIG_CHELSIO_T4_DCB=3Dy
> CONFIG_CHELSIO_T4_FCOE=3Dy
> CONFIG_CHELSIO_T4VF=3Dm
> CONFIG_CHELSIO_LIB=3Dm
> CONFIG_CHELSIO_INLINE_CRYPTO=3Dy
> CONFIG_CHELSIO_IPSEC_INLINE=3Dm
> CONFIG_NET_VENDOR_CISCO=3Dy
> CONFIG_ENIC=3Dm
> CONFIG_NET_VENDOR_CORTINA=3Dy
> # CONFIG_GEMINI_ETHERNET is not set
> CONFIG_NET_VENDOR_DAVICOM=3Dy
> # CONFIG_DM9051 is not set
> CONFIG_DNET=3Dm
> CONFIG_NET_VENDOR_DEC=3Dy
> CONFIG_NET_TULIP=3Dy
> CONFIG_DE2104X=3Dm
> CONFIG_DE2104X_DSL=3D0
> CONFIG_TULIP=3Dm
> # CONFIG_TULIP_MWI is not set
> # CONFIG_TULIP_MMIO is not set
> # CONFIG_TULIP_NAPI is not set
> CONFIG_DE4X5=3Dm
> CONFIG_WINBOND_840=3Dm
> CONFIG_DM9102=3Dm
> CONFIG_ULI526X=3Dm
> CONFIG_PCMCIA_XIRCOM=3Dm
> CONFIG_NET_VENDOR_DLINK=3Dy
> CONFIG_DL2K=3Dm
> CONFIG_SUNDANCE=3Dm
> # CONFIG_SUNDANCE_MMIO is not set
> CONFIG_NET_VENDOR_EMULEX=3Dy
> CONFIG_BE2NET=3Dm
> CONFIG_BE2NET_HWMON=3Dy
> CONFIG_BE2NET_BE2=3Dy
> CONFIG_BE2NET_BE3=3Dy
> CONFIG_BE2NET_LANCER=3Dy
> CONFIG_BE2NET_SKYHAWK=3Dy
> CONFIG_NET_VENDOR_ENGLEDER=3Dy
> # CONFIG_TSNEP is not set
> CONFIG_NET_VENDOR_EZCHIP=3Dy
> # CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_FUJITSU=3Dy
> CONFIG_PCMCIA_FMVJ18X=3Dm
> CONFIG_NET_VENDOR_FUNGIBLE=3Dy
> # CONFIG_FUN_ETH is not set
> CONFIG_NET_VENDOR_GOOGLE=3Dy
> # CONFIG_GVE is not set
> CONFIG_NET_VENDOR_HUAWEI=3Dy
> CONFIG_HINIC=3Dm
> CONFIG_NET_VENDOR_I825XX=3Dy
> CONFIG_NET_VENDOR_INTEL=3Dy
> CONFIG_E100=3Dy
> CONFIG_E1000=3Dy
> CONFIG_E1000E=3Dy
> CONFIG_E1000E_HWTS=3Dy
> CONFIG_IGB=3Dy
> CONFIG_IGB_HWMON=3Dy
> CONFIG_IGBVF=3Dm
> CONFIG_IXGB=3Dm
> CONFIG_IXGBE=3Dm
> CONFIG_IXGBE_HWMON=3Dy
> CONFIG_IXGBE_DCA=3Dy
> CONFIG_IXGBE_DCB=3Dy
> CONFIG_IXGBE_IPSEC=3Dy
> CONFIG_IXGBEVF=3Dm
> CONFIG_IXGBEVF_IPSEC=3Dy
> CONFIG_I40E=3Dm
> CONFIG_I40E_DCB=3Dy
> CONFIG_IAVF=3Dm
> CONFIG_I40EVF=3Dm
> CONFIG_ICE=3Dm
> CONFIG_ICE_SWITCHDEV=3Dy
> CONFIG_ICE_HWTS=3Dy
> CONFIG_FM10K=3Dm
> CONFIG_IGC=3Dm
> CONFIG_JME=3Dm
> CONFIG_NET_VENDOR_LITEX=3Dy
> # CONFIG_LITEX_LITEETH is not set
> CONFIG_NET_VENDOR_MARVELL=3Dy
> CONFIG_MVMDIO=3Dm
> CONFIG_SKGE=3Dm
> # CONFIG_SKGE_DEBUG is not set
> CONFIG_SKGE_GENESIS=3Dy
> CONFIG_SKY2=3Dm
> # CONFIG_SKY2_DEBUG is not set
> # CONFIG_PRESTERA is not set
> CONFIG_NET_VENDOR_MELLANOX=3Dy
> CONFIG_MLX4_EN=3Dm
> CONFIG_MLX4_EN_DCB=3Dy
> CONFIG_MLX4_CORE=3Dm
> CONFIG_MLX4_DEBUG=3Dy
> CONFIG_MLX4_CORE_GEN2=3Dy
> CONFIG_MLX5_CORE=3Dm
> CONFIG_MLX5_ACCEL=3Dy
> CONFIG_MLX5_FPGA=3Dy
> CONFIG_MLX5_CORE_EN=3Dy
> CONFIG_MLX5_EN_ARFS=3Dy
> CONFIG_MLX5_EN_RXNFC=3Dy
> CONFIG_MLX5_MPFS=3Dy
> CONFIG_MLX5_ESWITCH=3Dy
> CONFIG_MLX5_BRIDGE=3Dy
> CONFIG_MLX5_CLS_ACT=3Dy
> CONFIG_MLX5_TC_SAMPLE=3Dy
> CONFIG_MLX5_CORE_EN_DCB=3Dy
> CONFIG_MLX5_CORE_IPOIB=3Dy
> # CONFIG_MLX5_FPGA_IPSEC is not set
> # CONFIG_MLX5_IPSEC is not set
> CONFIG_MLX5_SW_STEERING=3Dy
> # CONFIG_MLX5_SF is not set
> CONFIG_MLXSW_CORE=3Dm
> CONFIG_MLXSW_CORE_HWMON=3Dy
> CONFIG_MLXSW_CORE_THERMAL=3Dy
> CONFIG_MLXSW_PCI=3Dm
> CONFIG_MLXSW_I2C=3Dm
> CONFIG_MLXSW_SPECTRUM=3Dm
> CONFIG_MLXSW_SPECTRUM_DCB=3Dy
> CONFIG_MLXSW_MINIMAL=3Dm
> CONFIG_MLXFW=3Dm
> CONFIG_NET_VENDOR_MICREL=3Dy
> CONFIG_KS8842=3Dm
> CONFIG_KS8851=3Dm
> CONFIG_KS8851_MLL=3Dm
> CONFIG_KSZ884X_PCI=3Dm
> CONFIG_NET_VENDOR_MICROCHIP=3Dy
> CONFIG_ENC28J60=3Dm
> # CONFIG_ENC28J60_WRITEVERIFY is not set
> CONFIG_ENCX24J600=3Dm
> CONFIG_LAN743X=3Dm
> # CONFIG_LAN966X_SWITCH is not set
> CONFIG_NET_VENDOR_MICROSEMI=3Dy
> # CONFIG_MSCC_OCELOT_SWITCH is not set
> CONFIG_NET_VENDOR_MICROSOFT=3Dy
> # CONFIG_MICROSOFT_MANA is not set
> CONFIG_NET_VENDOR_MYRI=3Dy
> CONFIG_MYRI10GE=3Dm
> CONFIG_MYRI10GE_DCA=3Dy
> CONFIG_FEALNX=3Dm
> CONFIG_NET_VENDOR_NI=3Dy
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_NATSEMI=3Dy
> CONFIG_NATSEMI=3Dm
> CONFIG_NS83820=3Dm
> CONFIG_NET_VENDOR_NETERION=3Dy
> CONFIG_S2IO=3Dm
> CONFIG_VXGE=3Dm
> # CONFIG_VXGE_DEBUG_TRACE_ALL is not set
> CONFIG_NET_VENDOR_NETRONOME=3Dy
> CONFIG_NFP=3Dm
> CONFIG_NFP_APP_FLOWER=3Dy
> CONFIG_NFP_APP_ABM_NIC=3Dy
> # CONFIG_NFP_DEBUG is not set
> CONFIG_NET_VENDOR_8390=3Dy
> CONFIG_PCMCIA_AXNET=3Dm
> CONFIG_NE2K_PCI=3Dm
> CONFIG_PCMCIA_PCNET=3Dm
> CONFIG_NET_VENDOR_NVIDIA=3Dy
> CONFIG_FORCEDETH=3Dm
> CONFIG_NET_VENDOR_OKI=3Dy
> CONFIG_ETHOC=3Dm
> CONFIG_NET_VENDOR_PACKET_ENGINES=3Dy
> CONFIG_HAMACHI=3Dm
> CONFIG_YELLOWFIN=3Dm
> CONFIG_NET_VENDOR_PENSANDO=3Dy
> # CONFIG_IONIC is not set
> CONFIG_NET_VENDOR_QLOGIC=3Dy
> CONFIG_QLA3XXX=3Dm
> CONFIG_QLCNIC=3Dm
> CONFIG_QLCNIC_SRIOV=3Dy
> CONFIG_QLCNIC_DCB=3Dy
> CONFIG_QLCNIC_HWMON=3Dy
> CONFIG_NETXEN_NIC=3Dm
> CONFIG_QED=3Dm
> CONFIG_QED_LL2=3Dy
> CONFIG_QED_SRIOV=3Dy
> CONFIG_QEDE=3Dm
> CONFIG_QED_RDMA=3Dy
> CONFIG_QED_ISCSI=3Dy
> CONFIG_QED_FCOE=3Dy
> CONFIG_QED_OOO=3Dy
> CONFIG_NET_VENDOR_BROCADE=3Dy
> CONFIG_BNA=3Dm
> CONFIG_NET_VENDOR_QUALCOMM=3Dy
> # CONFIG_QCA7000_SPI is not set
> # CONFIG_QCA7000_UART is not set
> CONFIG_QCOM_EMAC=3Dm
> CONFIG_RMNET=3Dm
> CONFIG_NET_VENDOR_RDC=3Dy
> CONFIG_R6040=3Dm
> CONFIG_NET_VENDOR_REALTEK=3Dy
> CONFIG_ATP=3Dm
> CONFIG_8139CP=3Dm
> CONFIG_8139TOO=3Dy
> CONFIG_8139TOO_PIO=3Dy
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> CONFIG_8139TOO_8129=3Dy
> # CONFIG_8139_OLD_RX_RESET is not set
> CONFIG_R8169=3Dy
> CONFIG_NET_VENDOR_RENESAS=3Dy
> CONFIG_NET_VENDOR_ROCKER=3Dy
> CONFIG_ROCKER=3Dm
> CONFIG_NET_VENDOR_SAMSUNG=3Dy
> CONFIG_SXGBE_ETH=3Dm
> CONFIG_NET_VENDOR_SEEQ=3Dy
> CONFIG_NET_VENDOR_SILAN=3Dy
> CONFIG_SC92031=3Dm
> CONFIG_NET_VENDOR_SIS=3Dy
> CONFIG_SIS900=3Dm
> CONFIG_SIS190=3Dm
> CONFIG_NET_VENDOR_SOLARFLARE=3Dy
> CONFIG_SFC=3Dm
> CONFIG_SFC_MTD=3Dy
> CONFIG_SFC_MCDI_MON=3Dy
> CONFIG_SFC_SRIOV=3Dy
> CONFIG_SFC_MCDI_LOGGING=3Dy
> CONFIG_SFC_FALCON=3Dm
> CONFIG_SFC_FALCON_MTD=3Dy
> CONFIG_NET_VENDOR_SMSC=3Dy
> CONFIG_PCMCIA_SMC91C92=3Dm
> CONFIG_EPIC100=3Dm
> CONFIG_SMSC911X=3Dm
> CONFIG_SMSC9420=3Dm
> CONFIG_NET_VENDOR_SOCIONEXT=3Dy
> CONFIG_NET_VENDOR_STMICRO=3Dy
> CONFIG_STMMAC_ETH=3Dm
> # CONFIG_STMMAC_SELFTESTS is not set
> CONFIG_STMMAC_PLATFORM=3Dm
> # CONFIG_DWMAC_DWC_QOS_ETH is not set
> CONFIG_DWMAC_GENERIC=3Dm
> # CONFIG_DWMAC_INTEL_PLAT is not set
> CONFIG_DWMAC_INTEL=3Dm
> # CONFIG_DWMAC_LOONGSON is not set
> CONFIG_STMMAC_PCI=3Dm
> CONFIG_NET_VENDOR_SUN=3Dy
> CONFIG_HAPPYMEAL=3Dm
> CONFIG_SUNGEM=3Dm
> CONFIG_CASSINI=3Dm
> CONFIG_NIU=3Dm
> CONFIG_NET_VENDOR_SYNOPSYS=3Dy
> CONFIG_DWC_XLGMAC=3Dm
> CONFIG_DWC_XLGMAC_PCI=3Dm
> CONFIG_NET_VENDOR_TEHUTI=3Dy
> CONFIG_TEHUTI=3Dm
> CONFIG_NET_VENDOR_TI=3Dy
> # CONFIG_TI_CPSW_PHY_SEL is not set
> CONFIG_TLAN=3Dm
> CONFIG_NET_VENDOR_VERTEXCOM=3Dy
> # CONFIG_MSE102X is not set
> CONFIG_NET_VENDOR_VIA=3Dy
> CONFIG_VIA_RHINE=3Dm
> CONFIG_VIA_RHINE_MMIO=3Dy
> CONFIG_VIA_VELOCITY=3Dm
> CONFIG_NET_VENDOR_WIZNET=3Dy
> CONFIG_WIZNET_W5100=3Dm
> CONFIG_WIZNET_W5300=3Dm
> # CONFIG_WIZNET_BUS_DIRECT is not set
> # CONFIG_WIZNET_BUS_INDIRECT is not set
> CONFIG_WIZNET_BUS_ANY=3Dy
> CONFIG_WIZNET_W5100_SPI=3Dm
> CONFIG_NET_VENDOR_XILINX=3Dy
> # CONFIG_XILINX_EMACLITE is not set
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> CONFIG_NET_VENDOR_XIRCOM=3Dy
> CONFIG_PCMCIA_XIRC2PS=3Dm
> CONFIG_FDDI=3Dy
> CONFIG_DEFXX=3Dm
> CONFIG_SKFP=3Dm
> # CONFIG_HIPPI is not set
> CONFIG_NET_SB1000=3Dm
> CONFIG_PHYLINK=3Dm
> CONFIG_PHYLIB=3Dy
> CONFIG_SWPHY=3Dy
> CONFIG_LED_TRIGGER_PHY=3Dy
> CONFIG_FIXED_PHY=3Dy
> # CONFIG_SFP is not set
>=20
> #
> # MII PHY device drivers
> #
> CONFIG_AMD_PHY=3Dm
> # CONFIG_ADIN_PHY is not set
> CONFIG_AQUANTIA_PHY=3Dm
> CONFIG_AX88796B_PHY=3Dm
> CONFIG_BROADCOM_PHY=3Dm
> # CONFIG_BCM54140_PHY is not set
> CONFIG_BCM7XXX_PHY=3Dm
> # CONFIG_BCM84881_PHY is not set
> CONFIG_BCM87XX_PHY=3Dm
> CONFIG_BCM_NET_PHYLIB=3Dm
> CONFIG_CICADA_PHY=3Dm
> CONFIG_CORTINA_PHY=3Dm
> CONFIG_DAVICOM_PHY=3Dm
> CONFIG_ICPLUS_PHY=3Dm
> CONFIG_LXT_PHY=3Dm
> CONFIG_INTEL_XWAY_PHY=3Dm
> CONFIG_LSI_ET1011C_PHY=3Dm
> CONFIG_MARVELL_PHY=3Dm
> CONFIG_MARVELL_10G_PHY=3Dm
> # CONFIG_MARVELL_88X2222_PHY is not set
> # CONFIG_MAXLINEAR_GPHY is not set
> CONFIG_MEDIATEK_GE_PHY=3Dm
> CONFIG_MICREL_PHY=3Dm
> CONFIG_MICROCHIP_PHY=3Dm
> # CONFIG_MICROCHIP_T1_PHY is not set
> CONFIG_MICROSEMI_PHY=3Dm
> # CONFIG_MOTORCOMM_PHY is not set
> CONFIG_NATIONAL_PHY=3Dm
> # CONFIG_NXP_C45_TJA11XX_PHY is not set
> # CONFIG_NXP_TJA11XX_PHY is not set
> CONFIG_AT803X_PHY=3Dm
> CONFIG_QSEMI_PHY=3Dm
> CONFIG_REALTEK_PHY=3Dy
> CONFIG_RENESAS_PHY=3Dm
> CONFIG_ROCKCHIP_PHY=3Dm
> CONFIG_SMSC_PHY=3Dm
> CONFIG_STE10XP=3Dm
> CONFIG_TERANETICS_PHY=3Dm
> CONFIG_DP83822_PHY=3Dm
> # CONFIG_DP83TC811_PHY is not set
> CONFIG_DP83848_PHY=3Dm
> CONFIG_DP83867_PHY=3Dm
> # CONFIG_DP83869_PHY is not set
> CONFIG_VITESSE_PHY=3Dm
> CONFIG_XILINX_GMII2RGMII=3Dm
> CONFIG_MICREL_KS8995MA=3Dm
> CONFIG_MDIO_DEVICE=3Dy
> CONFIG_MDIO_BUS=3Dy
> CONFIG_FWNODE_MDIO=3Dy
> CONFIG_OF_MDIO=3Dy
> CONFIG_ACPI_MDIO=3Dy
> CONFIG_MDIO_DEVRES=3Dy
> CONFIG_MDIO_BITBANG=3Dm
> # CONFIG_MDIO_BCM_UNIMAC is not set
> CONFIG_MDIO_CAVIUM=3Dm
> CONFIG_MDIO_GPIO=3Dm
> # CONFIG_MDIO_HISI_FEMAC is not set
> # CONFIG_MDIO_MVUSB is not set
> # CONFIG_MDIO_MSCC_MIIM is not set
> # CONFIG_MDIO_OCTEON is not set
> # CONFIG_MDIO_IPQ4019 is not set
> # CONFIG_MDIO_IPQ8064 is not set
> CONFIG_MDIO_THUNDER=3Dm
>=20
> #
> # MDIO Multiplexers
> #
> # CONFIG_MDIO_BUS_MUX_GPIO is not set
> # CONFIG_MDIO_BUS_MUX_MULTIPLEXER is not set
> # CONFIG_MDIO_BUS_MUX_MMIOREG is not set
>=20
> #
> # PCS device drivers
> #
> CONFIG_PCS_XPCS=3Dm
> # end of PCS device drivers
>=20
> CONFIG_PLIP=3Dm
> CONFIG_PPP=3Dy
> CONFIG_PPP_BSDCOMP=3Dm
> CONFIG_PPP_DEFLATE=3Dm
> CONFIG_PPP_FILTER=3Dy
> CONFIG_PPP_MPPE=3Dm
> CONFIG_PPP_MULTILINK=3Dy
> CONFIG_PPPOATM=3Dm
> CONFIG_PPPOE=3Dm
> CONFIG_PPTP=3Dm
> CONFIG_PPPOL2TP=3Dm
> CONFIG_PPP_ASYNC=3Dm
> CONFIG_PPP_SYNC_TTY=3Dm
> CONFIG_SLIP=3Dm
> CONFIG_SLHC=3Dy
> CONFIG_SLIP_COMPRESSED=3Dy
> CONFIG_SLIP_SMART=3Dy
> CONFIG_SLIP_MODE_SLIP6=3Dy
> CONFIG_USB_NET_DRIVERS=3Dy
> CONFIG_USB_CATC=3Dm
> CONFIG_USB_KAWETH=3Dm
> CONFIG_USB_PEGASUS=3Dm
> CONFIG_USB_RTL8150=3Dm
> CONFIG_USB_RTL8152=3Dm
> CONFIG_USB_LAN78XX=3Dm
> CONFIG_USB_USBNET=3Dm
> CONFIG_USB_NET_AX8817X=3Dm
> CONFIG_USB_NET_AX88179_178A=3Dm
> CONFIG_USB_NET_CDCETHER=3Dm
> CONFIG_USB_NET_CDC_EEM=3Dm
> CONFIG_USB_NET_CDC_NCM=3Dm
> CONFIG_USB_NET_HUAWEI_CDC_NCM=3Dm
> CONFIG_USB_NET_CDC_MBIM=3Dm
> CONFIG_USB_NET_DM9601=3Dm
> CONFIG_USB_NET_SR9700=3Dm
> CONFIG_USB_NET_SR9800=3Dm
> CONFIG_USB_NET_SMSC75XX=3Dm
> CONFIG_USB_NET_SMSC95XX=3Dm
> CONFIG_USB_NET_GL620A=3Dm
> CONFIG_USB_NET_NET1080=3Dm
> CONFIG_USB_NET_PLUSB=3Dm
> CONFIG_USB_NET_MCS7830=3Dm
> CONFIG_USB_NET_RNDIS_HOST=3Dm
> CONFIG_USB_NET_CDC_SUBSET_ENABLE=3Dm
> CONFIG_USB_NET_CDC_SUBSET=3Dm
> CONFIG_USB_ALI_M5632=3Dy
> CONFIG_USB_AN2720=3Dy
> CONFIG_USB_BELKIN=3Dy
> CONFIG_USB_ARMLINUX=3Dy
> CONFIG_USB_EPSON2888=3Dy
> CONFIG_USB_KC2190=3Dy
> CONFIG_USB_NET_ZAURUS=3Dm
> CONFIG_USB_NET_CX82310_ETH=3Dm
> CONFIG_USB_NET_KALMIA=3Dm
> CONFIG_USB_NET_QMI_WWAN=3Dm
> CONFIG_USB_HSO=3Dm
> CONFIG_USB_NET_INT51X1=3Dm
> CONFIG_USB_CDC_PHONET=3Dm
> CONFIG_USB_IPHETH=3Dm
> CONFIG_USB_SIERRA_NET=3Dm
> CONFIG_USB_VL600=3Dm
> CONFIG_USB_NET_CH9200=3Dm
> # CONFIG_USB_NET_AQC111 is not set
> # CONFIG_USB_RTL8153_ECM is not set
> CONFIG_WLAN=3Dy
> CONFIG_WLAN_VENDOR_ADMTEK=3Dy
> CONFIG_ADM8211=3Dm
> CONFIG_ATH_COMMON=3Dm
> CONFIG_WLAN_VENDOR_ATH=3Dy
> # CONFIG_ATH_DEBUG is not set
> CONFIG_ATH5K=3Dm
> # CONFIG_ATH5K_DEBUG is not set
> # CONFIG_ATH5K_TRACER is not set
> CONFIG_ATH5K_PCI=3Dy
> CONFIG_ATH9K_HW=3Dm
> CONFIG_ATH9K_COMMON=3Dm
> CONFIG_ATH9K_COMMON_DEBUG=3Dy
> CONFIG_ATH9K_BTCOEX_SUPPORT=3Dy
> CONFIG_ATH9K=3Dm
> CONFIG_ATH9K_PCI=3Dy
> CONFIG_ATH9K_AHB=3Dy
> CONFIG_ATH9K_DEBUGFS=3Dy
> CONFIG_ATH9K_STATION_STATISTICS=3Dy
> # CONFIG_ATH9K_DYNACK is not set
> CONFIG_ATH9K_WOW=3Dy
> CONFIG_ATH9K_RFKILL=3Dy
> CONFIG_ATH9K_CHANNEL_CONTEXT=3Dy
> CONFIG_ATH9K_PCOEM=3Dy
> # CONFIG_ATH9K_PCI_NO_EEPROM is not set
> CONFIG_ATH9K_HTC=3Dm
> CONFIG_ATH9K_HTC_DEBUGFS=3Dy
> CONFIG_ATH9K_HWRNG=3Dy
> CONFIG_ATH9K_COMMON_SPECTRAL=3Dy
> CONFIG_CARL9170=3Dm
> CONFIG_CARL9170_LEDS=3Dy
> # CONFIG_CARL9170_DEBUGFS is not set
> CONFIG_CARL9170_WPC=3Dy
> CONFIG_CARL9170_HWRNG=3Dy
> CONFIG_ATH6KL=3Dm
> CONFIG_ATH6KL_SDIO=3Dm
> CONFIG_ATH6KL_USB=3Dm
> # CONFIG_ATH6KL_DEBUG is not set
> # CONFIG_ATH6KL_TRACING is not set
> CONFIG_AR5523=3Dm
> CONFIG_WIL6210=3Dm
> CONFIG_WIL6210_ISR_COR=3Dy
> CONFIG_WIL6210_TRACING=3Dy
> CONFIG_WIL6210_DEBUGFS=3Dy
> CONFIG_ATH10K=3Dm
> CONFIG_ATH10K_CE=3Dy
> CONFIG_ATH10K_PCI=3Dm
> # CONFIG_ATH10K_AHB is not set
> CONFIG_ATH10K_SDIO=3Dm
> CONFIG_ATH10K_USB=3Dm
> # CONFIG_ATH10K_DEBUG is not set
> CONFIG_ATH10K_DEBUGFS=3Dy
> CONFIG_ATH10K_SPECTRAL=3Dy
> CONFIG_ATH10K_TRACING=3Dy
> CONFIG_WCN36XX=3Dm
> # CONFIG_WCN36XX_DEBUGFS is not set
> # CONFIG_ATH11K is not set
> CONFIG_WLAN_VENDOR_ATMEL=3Dy
> CONFIG_ATMEL=3Dm
> CONFIG_PCI_ATMEL=3Dm
> CONFIG_PCMCIA_ATMEL=3Dm
> CONFIG_AT76C50X_USB=3Dm
> CONFIG_WLAN_VENDOR_BROADCOM=3Dy
> CONFIG_B43=3Dm
> CONFIG_B43_BCMA=3Dy
> CONFIG_B43_SSB=3Dy
> CONFIG_B43_BUSES_BCMA_AND_SSB=3Dy
> # CONFIG_B43_BUSES_BCMA is not set
> # CONFIG_B43_BUSES_SSB is not set
> CONFIG_B43_PCI_AUTOSELECT=3Dy
> CONFIG_B43_PCICORE_AUTOSELECT=3Dy
> # CONFIG_B43_SDIO is not set
> CONFIG_B43_BCMA_PIO=3Dy
> CONFIG_B43_PIO=3Dy
> CONFIG_B43_PHY_G=3Dy
> CONFIG_B43_PHY_N=3Dy
> CONFIG_B43_PHY_LP=3Dy
> CONFIG_B43_PHY_HT=3Dy
> CONFIG_B43_LEDS=3Dy
> CONFIG_B43_HWRNG=3Dy
> # CONFIG_B43_DEBUG is not set
> CONFIG_B43LEGACY=3Dm
> CONFIG_B43LEGACY_PCI_AUTOSELECT=3Dy
> CONFIG_B43LEGACY_PCICORE_AUTOSELECT=3Dy
> CONFIG_B43LEGACY_LEDS=3Dy
> CONFIG_B43LEGACY_HWRNG=3Dy
> # CONFIG_B43LEGACY_DEBUG is not set
> CONFIG_B43LEGACY_DMA=3Dy
> CONFIG_B43LEGACY_PIO=3Dy
> CONFIG_B43LEGACY_DMA_AND_PIO_MODE=3Dy
> # CONFIG_B43LEGACY_DMA_MODE is not set
> # CONFIG_B43LEGACY_PIO_MODE is not set
> CONFIG_BRCMUTIL=3Dm
> CONFIG_BRCMSMAC=3Dm
> CONFIG_BRCMSMAC_LEDS=3Dy
> CONFIG_BRCMFMAC=3Dm
> CONFIG_BRCMFMAC_PROTO_BCDC=3Dy
> CONFIG_BRCMFMAC_PROTO_MSGBUF=3Dy
> CONFIG_BRCMFMAC_SDIO=3Dy
> CONFIG_BRCMFMAC_USB=3Dy
> CONFIG_BRCMFMAC_PCIE=3Dy
> CONFIG_BRCM_TRACING=3Dy
> # CONFIG_BRCMDBG is not set
> CONFIG_WLAN_VENDOR_CISCO=3Dy
> CONFIG_AIRO=3Dm
> CONFIG_AIRO_CS=3Dm
> CONFIG_WLAN_VENDOR_INTEL=3Dy
> CONFIG_IPW2100=3Dm
> CONFIG_IPW2100_MONITOR=3Dy
> # CONFIG_IPW2100_DEBUG is not set
> CONFIG_IPW2200=3Dm
> CONFIG_IPW2200_MONITOR=3Dy
> CONFIG_IPW2200_RADIOTAP=3Dy
> CONFIG_IPW2200_PROMISCUOUS=3Dy
> CONFIG_IPW2200_QOS=3Dy
> # CONFIG_IPW2200_DEBUG is not set
> CONFIG_LIBIPW=3Dm
> # CONFIG_LIBIPW_DEBUG is not set
> CONFIG_IWLEGACY=3Dm
> CONFIG_IWL4965=3Dm
> CONFIG_IWL3945=3Dm
>=20
> #
> # iwl3945 / iwl4965 Debugging Options
> #
> # CONFIG_IWLEGACY_DEBUG is not set
> CONFIG_IWLEGACY_DEBUGFS=3Dy
> # end of iwl3945 / iwl4965 Debugging Options
>=20
> CONFIG_IWLWIFI=3Dm
> CONFIG_IWLWIFI_LEDS=3Dy
> CONFIG_IWLDVM=3Dm
> CONFIG_IWLMVM=3Dm
> CONFIG_IWLWIFI_OPMODE_MODULAR=3Dy
>=20
> #
> # Debugging Options
> #
> CONFIG_IWLWIFI_DEBUG=3Dy
> CONFIG_IWLWIFI_DEBUGFS=3Dy
> CONFIG_IWLWIFI_DEVICE_TRACING=3Dy
> # end of Debugging Options
>=20
> # CONFIG_IWLMEI is not set
> CONFIG_WLAN_VENDOR_INTERSIL=3Dy
> CONFIG_HOSTAP=3Dm
> CONFIG_HOSTAP_FIRMWARE=3Dy
> CONFIG_HOSTAP_FIRMWARE_NVRAM=3Dy
> CONFIG_HOSTAP_PLX=3Dm
> CONFIG_HOSTAP_PCI=3Dm
> CONFIG_HOSTAP_CS=3Dm
> CONFIG_HERMES=3Dm
> # CONFIG_HERMES_PRISM is not set
> CONFIG_HERMES_CACHE_FW_ON_INIT=3Dy
> CONFIG_PLX_HERMES=3Dm
> CONFIG_TMD_HERMES=3Dm
> CONFIG_NORTEL_HERMES=3Dm
> CONFIG_PCMCIA_HERMES=3Dm
> CONFIG_PCMCIA_SPECTRUM=3Dm
> CONFIG_ORINOCO_USB=3Dm
> CONFIG_P54_COMMON=3Dm
> CONFIG_P54_USB=3Dm
> CONFIG_P54_PCI=3Dm
> CONFIG_P54_SPI=3Dm
> # CONFIG_P54_SPI_DEFAULT_EEPROM is not set
> CONFIG_P54_LEDS=3Dy
> CONFIG_WLAN_VENDOR_MARVELL=3Dy
> CONFIG_LIBERTAS=3Dm
> CONFIG_LIBERTAS_USB=3Dm
> CONFIG_LIBERTAS_CS=3Dm
> CONFIG_LIBERTAS_SDIO=3Dm
> CONFIG_LIBERTAS_SPI=3Dm
> # CONFIG_LIBERTAS_DEBUG is not set
> CONFIG_LIBERTAS_MESH=3Dy
> CONFIG_LIBERTAS_THINFIRM=3Dm
> # CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
> CONFIG_LIBERTAS_THINFIRM_USB=3Dm
> CONFIG_MWIFIEX=3Dm
> CONFIG_MWIFIEX_SDIO=3Dm
> CONFIG_MWIFIEX_PCIE=3Dm
> CONFIG_MWIFIEX_USB=3Dm
> CONFIG_MWL8K=3Dm
> CONFIG_WLAN_VENDOR_MEDIATEK=3Dy
> CONFIG_MT7601U=3Dm
> CONFIG_MT76_CORE=3Dm
> CONFIG_MT76_LEDS=3Dy
> CONFIG_MT76x02_LIB=3Dm
> # CONFIG_MT76x0U is not set
> # CONFIG_MT76x0E is not set
> CONFIG_MT76x2_COMMON=3Dm
> CONFIG_MT76x2E=3Dm
> # CONFIG_MT76x2U is not set
> # CONFIG_MT7603E is not set
> # CONFIG_MT7615E is not set
> # CONFIG_MT7663U is not set
> # CONFIG_MT7663S is not set
> # CONFIG_MT7915E is not set
> # CONFIG_MT7921E is not set
> # CONFIG_MT7921S is not set
> # CONFIG_MT7921U is not set
> CONFIG_WLAN_VENDOR_MICROCHIP=3Dy
> CONFIG_WILC1000=3Dm
> CONFIG_WILC1000_SDIO=3Dm
> CONFIG_WILC1000_SPI=3Dm
> CONFIG_WILC1000_HW_OOB_INTR=3Dy
> CONFIG_WLAN_VENDOR_RALINK=3Dy
> CONFIG_RT2X00=3Dm
> CONFIG_RT2400PCI=3Dm
> CONFIG_RT2500PCI=3Dm
> CONFIG_RT61PCI=3Dm
> CONFIG_RT2800PCI=3Dm
> CONFIG_RT2800PCI_RT33XX=3Dy
> CONFIG_RT2800PCI_RT35XX=3Dy
> CONFIG_RT2800PCI_RT53XX=3Dy
> CONFIG_RT2800PCI_RT3290=3Dy
> CONFIG_RT2500USB=3Dm
> CONFIG_RT73USB=3Dm
> CONFIG_RT2800USB=3Dm
> CONFIG_RT2800USB_RT33XX=3Dy
> CONFIG_RT2800USB_RT35XX=3Dy
> CONFIG_RT2800USB_RT3573=3Dy
> CONFIG_RT2800USB_RT53XX=3Dy
> CONFIG_RT2800USB_RT55XX=3Dy
> CONFIG_RT2800USB_UNKNOWN=3Dy
> CONFIG_RT2800_LIB=3Dm
> CONFIG_RT2800_LIB_MMIO=3Dm
> CONFIG_RT2X00_LIB_MMIO=3Dm
> CONFIG_RT2X00_LIB_PCI=3Dm
> CONFIG_RT2X00_LIB_USB=3Dm
> CONFIG_RT2X00_LIB=3Dm
> CONFIG_RT2X00_LIB_FIRMWARE=3Dy
> CONFIG_RT2X00_LIB_CRYPTO=3Dy
> CONFIG_RT2X00_LIB_LEDS=3Dy
> # CONFIG_RT2X00_LIB_DEBUGFS is not set
> # CONFIG_RT2X00_DEBUG is not set
> CONFIG_WLAN_VENDOR_REALTEK=3Dy
> CONFIG_RTL8180=3Dm
> CONFIG_RTL8187=3Dm
> CONFIG_RTL8187_LEDS=3Dy
> CONFIG_RTL_CARDS=3Dm
> CONFIG_RTL8192CE=3Dm
> CONFIG_RTL8192SE=3Dm
> CONFIG_RTL8192DE=3Dm
> CONFIG_RTL8723AE=3Dm
> CONFIG_RTL8723BE=3Dm
> CONFIG_RTL8188EE=3Dm
> CONFIG_RTL8192EE=3Dm
> CONFIG_RTL8821AE=3Dm
> CONFIG_RTL8192CU=3Dm
> CONFIG_RTLWIFI=3Dm
> CONFIG_RTLWIFI_PCI=3Dm
> CONFIG_RTLWIFI_USB=3Dm
> # CONFIG_RTLWIFI_DEBUG is not set
> CONFIG_RTL8192C_COMMON=3Dm
> CONFIG_RTL8723_COMMON=3Dm
> CONFIG_RTLBTCOEXIST=3Dm
> CONFIG_RTL8XXXU=3Dm
> CONFIG_RTL8XXXU_UNTESTED=3Dy
> # CONFIG_RTW88 is not set
> # CONFIG_RTW89 is not set
> CONFIG_WLAN_VENDOR_RSI=3Dy
> CONFIG_RSI_91X=3Dm
> # CONFIG_RSI_DEBUGFS is not set
> CONFIG_RSI_SDIO=3Dm
> CONFIG_RSI_USB=3Dm
> CONFIG_RSI_COEX=3Dy
> CONFIG_WLAN_VENDOR_ST=3Dy
> CONFIG_CW1200=3Dm
> CONFIG_CW1200_WLAN_SDIO=3Dm
> CONFIG_CW1200_WLAN_SPI=3Dm
> CONFIG_WLAN_VENDOR_TI=3Dy
> CONFIG_WL1251=3Dm
> CONFIG_WL1251_SPI=3Dm
> CONFIG_WL1251_SDIO=3Dm
> CONFIG_WL12XX=3Dm
> CONFIG_WL18XX=3Dm
> CONFIG_WLCORE=3Dm
> # CONFIG_WLCORE_SPI is not set
> CONFIG_WLCORE_SDIO=3Dm
> CONFIG_WILINK_PLATFORM_DATA=3Dy
> CONFIG_WLAN_VENDOR_ZYDAS=3Dy
> CONFIG_USB_ZD1201=3Dm
> CONFIG_ZD1211RW=3Dm
> # CONFIG_ZD1211RW_DEBUG is not set
> CONFIG_WLAN_VENDOR_QUANTENNA=3Dy
> # CONFIG_QTNFMAC_PCIE is not set
> CONFIG_PCMCIA_RAYCS=3Dm
> CONFIG_PCMCIA_WL3501=3Dm
> CONFIG_MAC80211_HWSIM=3Dm
> CONFIG_USB_NET_RNDIS_WLAN=3Dm
> # CONFIG_VIRT_WIFI is not set
> CONFIG_WAN=3Dy
> CONFIG_LANMEDIA=3Dm
> CONFIG_HDLC=3Dm
> CONFIG_HDLC_RAW=3Dm
> CONFIG_HDLC_RAW_ETH=3Dm
> CONFIG_HDLC_CISCO=3Dm
> CONFIG_HDLC_FR=3Dm
> CONFIG_HDLC_PPP=3Dm
> CONFIG_HDLC_X25=3Dm
> CONFIG_PCI200SYN=3Dm
> CONFIG_WANXL=3Dm
> CONFIG_PC300TOO=3Dm
> CONFIG_FARSYNC=3Dm
> CONFIG_LAPBETHER=3Dm
> CONFIG_IEEE802154_DRIVERS=3Dm
> CONFIG_IEEE802154_FAKELB=3Dm
> CONFIG_IEEE802154_AT86RF230=3Dm
> CONFIG_IEEE802154_AT86RF230_DEBUGFS=3Dy
> CONFIG_IEEE802154_MRF24J40=3Dm
> CONFIG_IEEE802154_CC2520=3Dm
> CONFIG_IEEE802154_ATUSB=3Dm
> CONFIG_IEEE802154_ADF7242=3Dm
> CONFIG_IEEE802154_CA8210=3Dm
> CONFIG_IEEE802154_CA8210_DEBUGFS=3Dy
> CONFIG_IEEE802154_MCR20A=3Dm
> # CONFIG_IEEE802154_HWSIM is not set
>=20
> #
> # Wireless WAN
> #
> CONFIG_WWAN=3Dy
> CONFIG_WWAN_DEBUGFS=3Dy
> # CONFIG_WWAN_HWSIM is not set
> # CONFIG_RPMSG_WWAN_CTRL is not set
> # CONFIG_IOSM is not set
> CONFIG_MTK_T7XX=3Dm
> # end of Wireless WAN
>=20
> CONFIG_XEN_NETDEV_FRONTEND=3Dy
> CONFIG_XEN_NETDEV_BACKEND=3Dm
> CONFIG_VMXNET3=3Dm
> CONFIG_FUJITSU_ES=3Dm
> CONFIG_USB4_NET=3Dm
> CONFIG_HYPERV_NET=3Dm
> CONFIG_NETDEVSIM=3Dm
> CONFIG_NET_FAILOVER=3Dy
> CONFIG_ISDN=3Dy
> CONFIG_ISDN_CAPI=3Dy
> CONFIG_CAPI_TRACE=3Dy
> CONFIG_ISDN_CAPI_MIDDLEWARE=3Dy
> CONFIG_MISDN=3Dm
> CONFIG_MISDN_DSP=3Dm
> CONFIG_MISDN_L1OIP=3Dm
>=20
> #
> # mISDN hardware drivers
> #
> CONFIG_MISDN_HFCPCI=3Dm
> CONFIG_MISDN_HFCMULTI=3Dm
> CONFIG_MISDN_HFCUSB=3Dm
> CONFIG_MISDN_AVMFRITZ=3Dm
> CONFIG_MISDN_SPEEDFAX=3Dm
> CONFIG_MISDN_INFINEON=3Dm
> CONFIG_MISDN_W6692=3Dm
> CONFIG_MISDN_NETJET=3Dm
> CONFIG_MISDN_HDLC=3Dm
> CONFIG_MISDN_IPAC=3Dm
> CONFIG_MISDN_ISAR=3Dm
>=20
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
> CONFIG_INPUT_LEDS=3Dm
> CONFIG_INPUT_FF_MEMLESS=3Dm
> CONFIG_INPUT_SPARSEKMAP=3Dm
> CONFIG_INPUT_MATRIXKMAP=3Dm
> CONFIG_INPUT_VIVALDIFMAP=3Dy
>=20
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dy
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> CONFIG_INPUT_JOYDEV=3Dm
> CONFIG_INPUT_EVDEV=3Dy
> # CONFIG_INPUT_EVBUG is not set
>=20
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> CONFIG_KEYBOARD_ADC=3Dm
> CONFIG_KEYBOARD_ADP5520=3Dm
> CONFIG_KEYBOARD_ADP5588=3Dm
> CONFIG_KEYBOARD_ADP5589=3Dm
> # CONFIG_KEYBOARD_APPLESPI is not set
> CONFIG_KEYBOARD_ATKBD=3Dy
> # CONFIG_KEYBOARD_QT1050 is not set
> CONFIG_KEYBOARD_QT1070=3Dm
> CONFIG_KEYBOARD_QT2160=3Dm
> CONFIG_KEYBOARD_DLINK_DIR685=3Dm
> CONFIG_KEYBOARD_LKKBD=3Dm
> CONFIG_KEYBOARD_GPIO=3Dm
> CONFIG_KEYBOARD_GPIO_POLLED=3Dm
> CONFIG_KEYBOARD_TCA6416=3Dm
> CONFIG_KEYBOARD_TCA8418=3Dm
> CONFIG_KEYBOARD_MATRIX=3Dm
> CONFIG_KEYBOARD_LM8323=3Dm
> CONFIG_KEYBOARD_LM8333=3Dm
> CONFIG_KEYBOARD_MAX7359=3Dm
> CONFIG_KEYBOARD_MCS=3Dm
> CONFIG_KEYBOARD_MPR121=3Dm
> CONFIG_KEYBOARD_NEWTON=3Dm
> CONFIG_KEYBOARD_OPENCORES=3Dm
> CONFIG_KEYBOARD_SAMSUNG=3Dm
> CONFIG_KEYBOARD_STOWAWAY=3Dm
> CONFIG_KEYBOARD_SUNKBD=3Dm
> # CONFIG_KEYBOARD_OMAP4 is not set
> CONFIG_KEYBOARD_TM2_TOUCHKEY=3Dm
> CONFIG_KEYBOARD_TWL4030=3Dm
> CONFIG_KEYBOARD_XTKBD=3Dm
> CONFIG_KEYBOARD_CROS_EC=3Dm
> # CONFIG_KEYBOARD_CAP11XX is not set
> # CONFIG_KEYBOARD_BCM is not set
> # CONFIG_KEYBOARD_MTK_PMIC is not set
> # CONFIG_KEYBOARD_CYPRESS_SF is not set
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> CONFIG_MOUSE_PS2_ALPS=3Dy
> CONFIG_MOUSE_PS2_BYD=3Dy
> CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
> CONFIG_MOUSE_PS2_CYPRESS=3Dy
> CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
> CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
> CONFIG_MOUSE_PS2_ELANTECH=3Dy
> CONFIG_MOUSE_PS2_ELANTECH_SMBUS=3Dy
> CONFIG_MOUSE_PS2_SENTELIC=3Dy
> CONFIG_MOUSE_PS2_TOUCHKIT=3Dy
> CONFIG_MOUSE_PS2_FOCALTECH=3Dy
> CONFIG_MOUSE_PS2_VMMOUSE=3Dy
> CONFIG_MOUSE_PS2_SMBUS=3Dy
> CONFIG_MOUSE_SERIAL=3Dm
> CONFIG_MOUSE_APPLETOUCH=3Dm
> CONFIG_MOUSE_BCM5974=3Dm
> CONFIG_MOUSE_CYAPA=3Dm
> CONFIG_MOUSE_ELAN_I2C=3Dm
> CONFIG_MOUSE_ELAN_I2C_I2C=3Dy
> CONFIG_MOUSE_ELAN_I2C_SMBUS=3Dy
> CONFIG_MOUSE_VSXXXAA=3Dm
> CONFIG_MOUSE_GPIO=3Dm
> CONFIG_MOUSE_SYNAPTICS_I2C=3Dm
> CONFIG_MOUSE_SYNAPTICS_USB=3Dm
> CONFIG_INPUT_JOYSTICK=3Dy
> CONFIG_JOYSTICK_ANALOG=3Dm
> CONFIG_JOYSTICK_A3D=3Dm
> # CONFIG_JOYSTICK_ADC is not set
> CONFIG_JOYSTICK_ADI=3Dm
> CONFIG_JOYSTICK_COBRA=3Dm
> CONFIG_JOYSTICK_GF2K=3Dm
> CONFIG_JOYSTICK_GRIP=3Dm
> CONFIG_JOYSTICK_GRIP_MP=3Dm
> CONFIG_JOYSTICK_GUILLEMOT=3Dm
> CONFIG_JOYSTICK_INTERACT=3Dm
> CONFIG_JOYSTICK_SIDEWINDER=3Dm
> CONFIG_JOYSTICK_TMDC=3Dm
> CONFIG_JOYSTICK_IFORCE=3Dm
> CONFIG_JOYSTICK_IFORCE_USB=3Dm
> CONFIG_JOYSTICK_IFORCE_232=3Dm
> CONFIG_JOYSTICK_WARRIOR=3Dm
> CONFIG_JOYSTICK_MAGELLAN=3Dm
> CONFIG_JOYSTICK_SPACEORB=3Dm
> CONFIG_JOYSTICK_SPACEBALL=3Dm
> CONFIG_JOYSTICK_STINGER=3Dm
> CONFIG_JOYSTICK_TWIDJOY=3Dm
> CONFIG_JOYSTICK_ZHENHUA=3Dm
> CONFIG_JOYSTICK_DB9=3Dm
> CONFIG_JOYSTICK_GAMECON=3Dm
> CONFIG_JOYSTICK_TURBOGRAFX=3Dm
> CONFIG_JOYSTICK_AS5011=3Dm
> CONFIG_JOYSTICK_JOYDUMP=3Dm
> CONFIG_JOYSTICK_XPAD=3Dm
> CONFIG_JOYSTICK_XPAD_FF=3Dy
> CONFIG_JOYSTICK_XPAD_LEDS=3Dy
> CONFIG_JOYSTICK_WALKERA0701=3Dm
> CONFIG_JOYSTICK_PSXPAD_SPI=3Dm
> CONFIG_JOYSTICK_PSXPAD_SPI_FF=3Dy
> # CONFIG_JOYSTICK_PXRC is not set
> # CONFIG_JOYSTICK_QWIIC is not set
> # CONFIG_JOYSTICK_FSIA6B is not set
> CONFIG_INPUT_TABLET=3Dy
> CONFIG_TABLET_USB_ACECAD=3Dm
> CONFIG_TABLET_USB_AIPTEK=3Dm
> CONFIG_TABLET_USB_HANWANG=3Dm
> CONFIG_TABLET_USB_KBTAB=3Dm
> CONFIG_TABLET_USB_PEGASUS=3Dm
> CONFIG_TABLET_SERIAL_WACOM4=3Dm
> CONFIG_INPUT_TOUCHSCREEN=3Dy
> CONFIG_TOUCHSCREEN_88PM860X=3Dm
> CONFIG_TOUCHSCREEN_ADS7846=3Dm
> CONFIG_TOUCHSCREEN_AD7877=3Dm
> CONFIG_TOUCHSCREEN_AD7879=3Dm
> CONFIG_TOUCHSCREEN_AD7879_I2C=3Dm
> CONFIG_TOUCHSCREEN_AD7879_SPI=3Dm
> # CONFIG_TOUCHSCREEN_ADC is not set
> # CONFIG_TOUCHSCREEN_AR1021_I2C is not set
> CONFIG_TOUCHSCREEN_ATMEL_MXT=3Dm
> CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=3Dy
> CONFIG_TOUCHSCREEN_AUO_PIXCIR=3Dm
> CONFIG_TOUCHSCREEN_BU21013=3Dm
> # CONFIG_TOUCHSCREEN_BU21029 is not set
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
> CONFIG_TOUCHSCREEN_CY8CTMG110=3Dm
> CONFIG_TOUCHSCREEN_CYTTSP_CORE=3Dm
> CONFIG_TOUCHSCREEN_CYTTSP_I2C=3Dm
> CONFIG_TOUCHSCREEN_CYTTSP_SPI=3Dm
> CONFIG_TOUCHSCREEN_CYTTSP4_CORE=3Dm
> CONFIG_TOUCHSCREEN_CYTTSP4_I2C=3Dm
> CONFIG_TOUCHSCREEN_CYTTSP4_SPI=3Dm
> CONFIG_TOUCHSCREEN_DA9034=3Dm
> CONFIG_TOUCHSCREEN_DA9052=3Dm
> CONFIG_TOUCHSCREEN_DYNAPRO=3Dm
> CONFIG_TOUCHSCREEN_HAMPSHIRE=3Dm
> CONFIG_TOUCHSCREEN_EETI=3Dm
> # CONFIG_TOUCHSCREEN_EGALAX is not set
> CONFIG_TOUCHSCREEN_EGALAX_SERIAL=3Dm
> CONFIG_TOUCHSCREEN_EXC3000=3Dm
> CONFIG_TOUCHSCREEN_FUJITSU=3Dm
> CONFIG_TOUCHSCREEN_GOODIX=3Dm
> CONFIG_TOUCHSCREEN_HIDEEP=3Dm
> # CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
> CONFIG_TOUCHSCREEN_ILI210X=3Dm
> # CONFIG_TOUCHSCREEN_ILITEK is not set
> CONFIG_TOUCHSCREEN_S6SY761=3Dm
> CONFIG_TOUCHSCREEN_GUNZE=3Dm
> CONFIG_TOUCHSCREEN_EKTF2127=3Dm
> CONFIG_TOUCHSCREEN_ELAN=3Dy
> CONFIG_TOUCHSCREEN_ELO=3Dm
> CONFIG_TOUCHSCREEN_WACOM_W8001=3Dm
> CONFIG_TOUCHSCREEN_WACOM_I2C=3Dm
> CONFIG_TOUCHSCREEN_MAX11801=3Dm
> CONFIG_TOUCHSCREEN_MCS5000=3Dm
> CONFIG_TOUCHSCREEN_MMS114=3Dm
> CONFIG_TOUCHSCREEN_MELFAS_MIP4=3Dm
> # CONFIG_TOUCHSCREEN_MSG2638 is not set
> CONFIG_TOUCHSCREEN_MTOUCH=3Dm
> # CONFIG_TOUCHSCREEN_IMAGIS is not set
> # CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
> CONFIG_TOUCHSCREEN_INEXIO=3Dm
> CONFIG_TOUCHSCREEN_MK712=3Dm
> CONFIG_TOUCHSCREEN_PENMOUNT=3Dm
> CONFIG_TOUCHSCREEN_EDT_FT5X06=3Dm
> CONFIG_TOUCHSCREEN_TOUCHRIGHT=3Dm
> CONFIG_TOUCHSCREEN_TOUCHWIN=3Dm
> CONFIG_TOUCHSCREEN_TI_AM335X_TSC=3Dm
> CONFIG_TOUCHSCREEN_UCB1400=3Dm
> CONFIG_TOUCHSCREEN_PIXCIR=3Dm
> CONFIG_TOUCHSCREEN_WDT87XX_I2C=3Dm
> CONFIG_TOUCHSCREEN_WM831X=3Dm
> CONFIG_TOUCHSCREEN_WM97XX=3Dm
> CONFIG_TOUCHSCREEN_WM9705=3Dy
> CONFIG_TOUCHSCREEN_WM9712=3Dy
> CONFIG_TOUCHSCREEN_WM9713=3Dy
> CONFIG_TOUCHSCREEN_USB_COMPOSITE=3Dm
> CONFIG_TOUCHSCREEN_MC13783=3Dm
> CONFIG_TOUCHSCREEN_USB_EGALAX=3Dy
> CONFIG_TOUCHSCREEN_USB_PANJIT=3Dy
> CONFIG_TOUCHSCREEN_USB_3M=3Dy
> CONFIG_TOUCHSCREEN_USB_ITM=3Dy
> CONFIG_TOUCHSCREEN_USB_ETURBO=3Dy
> CONFIG_TOUCHSCREEN_USB_GUNZE=3Dy
> CONFIG_TOUCHSCREEN_USB_DMC_TSC10=3Dy
> CONFIG_TOUCHSCREEN_USB_IRTOUCH=3Dy
> CONFIG_TOUCHSCREEN_USB_IDEALTEK=3Dy
> CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=3Dy
> CONFIG_TOUCHSCREEN_USB_GOTOP=3Dy
> CONFIG_TOUCHSCREEN_USB_JASTEC=3Dy
> CONFIG_TOUCHSCREEN_USB_ELO=3Dy
> CONFIG_TOUCHSCREEN_USB_E2I=3Dy
> CONFIG_TOUCHSCREEN_USB_ZYTRONIC=3Dy
> CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=3Dy
> CONFIG_TOUCHSCREEN_USB_NEXIO=3Dy
> CONFIG_TOUCHSCREEN_USB_EASYTOUCH=3Dy
> CONFIG_TOUCHSCREEN_TOUCHIT213=3Dm
> CONFIG_TOUCHSCREEN_TSC_SERIO=3Dm
> CONFIG_TOUCHSCREEN_TSC200X_CORE=3Dm
> CONFIG_TOUCHSCREEN_TSC2004=3Dm
> CONFIG_TOUCHSCREEN_TSC2005=3Dm
> CONFIG_TOUCHSCREEN_TSC2007=3Dm
> CONFIG_TOUCHSCREEN_TSC2007_IIO=3Dy
> CONFIG_TOUCHSCREEN_PCAP=3Dm
> CONFIG_TOUCHSCREEN_RM_TS=3Dm
> CONFIG_TOUCHSCREEN_SILEAD=3Dm
> CONFIG_TOUCHSCREEN_SIS_I2C=3Dm
> CONFIG_TOUCHSCREEN_ST1232=3Dm
> CONFIG_TOUCHSCREEN_STMFTS=3Dm
> CONFIG_TOUCHSCREEN_SUR40=3Dm
> CONFIG_TOUCHSCREEN_SURFACE3_SPI=3Dm
> CONFIG_TOUCHSCREEN_SX8654=3Dm
> CONFIG_TOUCHSCREEN_TPS6507X=3Dm
> CONFIG_TOUCHSCREEN_ZET6223=3Dm
> CONFIG_TOUCHSCREEN_ZFORCE=3Dm
> CONFIG_TOUCHSCREEN_ROHM_BU21023=3Dm
> # CONFIG_TOUCHSCREEN_IQS5XX is not set
> # CONFIG_TOUCHSCREEN_ZINITIX is not set
> CONFIG_INPUT_MISC=3Dy
> CONFIG_INPUT_88PM860X_ONKEY=3Dm
> CONFIG_INPUT_88PM80X_ONKEY=3Dm
> CONFIG_INPUT_AD714X=3Dm
> CONFIG_INPUT_AD714X_I2C=3Dm
> CONFIG_INPUT_AD714X_SPI=3Dm
> CONFIG_INPUT_ARIZONA_HAPTICS=3Dm
> # CONFIG_INPUT_ATMEL_CAPTOUCH is not set
> CONFIG_INPUT_BMA150=3Dm
> CONFIG_INPUT_E3X0_BUTTON=3Dm
> CONFIG_INPUT_PCSPKR=3Dm
> CONFIG_INPUT_MAX77693_HAPTIC=3Dm
> CONFIG_INPUT_MAX8925_ONKEY=3Dm
> CONFIG_INPUT_MAX8997_HAPTIC=3Dm
> CONFIG_INPUT_MC13783_PWRBUTTON=3Dm
> CONFIG_INPUT_MMA8450=3Dm
> CONFIG_INPUT_APANEL=3Dm
> CONFIG_INPUT_GPIO_BEEPER=3Dm
> CONFIG_INPUT_GPIO_DECODER=3Dm
> # CONFIG_INPUT_GPIO_VIBRA is not set
> CONFIG_INPUT_ATLAS_BTNS=3Dm
> CONFIG_INPUT_ATI_REMOTE2=3Dm
> CONFIG_INPUT_KEYSPAN_REMOTE=3Dm
> CONFIG_INPUT_KXTJ9=3Dm
> CONFIG_INPUT_POWERMATE=3Dm
> CONFIG_INPUT_YEALINK=3Dm
> CONFIG_INPUT_CM109=3Dm
> CONFIG_INPUT_REGULATOR_HAPTIC=3Dm
> CONFIG_INPUT_RETU_PWRBUTTON=3Dm
> CONFIG_INPUT_AXP20X_PEK=3Dm
> CONFIG_INPUT_TWL4030_PWRBUTTON=3Dm
> CONFIG_INPUT_TWL4030_VIBRA=3Dm
> CONFIG_INPUT_TWL6040_VIBRA=3Dm
> CONFIG_INPUT_UINPUT=3Dy
> CONFIG_INPUT_PALMAS_PWRBUTTON=3Dm
> CONFIG_INPUT_PCF50633_PMU=3Dm
> CONFIG_INPUT_PCF8574=3Dm
> CONFIG_INPUT_PWM_BEEPER=3Dm
> CONFIG_INPUT_PWM_VIBRA=3Dm
> CONFIG_INPUT_GPIO_ROTARY_ENCODER=3Dm
> # CONFIG_INPUT_DA7280_HAPTICS is not set
> CONFIG_INPUT_DA9052_ONKEY=3Dm
> CONFIG_INPUT_DA9055_ONKEY=3Dm
> CONFIG_INPUT_DA9063_ONKEY=3Dm
> CONFIG_INPUT_WM831X_ON=3Dm
> CONFIG_INPUT_PCAP=3Dm
> CONFIG_INPUT_ADXL34X=3Dm
> CONFIG_INPUT_ADXL34X_I2C=3Dm
> CONFIG_INPUT_ADXL34X_SPI=3Dm
> CONFIG_INPUT_IMS_PCU=3Dm
> # CONFIG_INPUT_IQS269A is not set
> # CONFIG_INPUT_IQS626A is not set
> CONFIG_INPUT_CMA3000=3Dm
> CONFIG_INPUT_CMA3000_I2C=3Dm
> CONFIG_INPUT_XEN_KBDDEV_FRONTEND=3Dm
> CONFIG_INPUT_IDEAPAD_SLIDEBAR=3Dm
> CONFIG_INPUT_SOC_BUTTON_ARRAY=3Dm
> CONFIG_INPUT_DRV260X_HAPTICS=3Dm
> CONFIG_INPUT_DRV2665_HAPTICS=3Dm
> CONFIG_INPUT_DRV2667_HAPTICS=3Dm
> # CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
> CONFIG_RMI4_CORE=3Dm
> CONFIG_RMI4_I2C=3Dm
> CONFIG_RMI4_SPI=3Dm
> CONFIG_RMI4_SMB=3Dm
> CONFIG_RMI4_F03=3Dy
> CONFIG_RMI4_F03_SERIO=3Dm
> CONFIG_RMI4_2D_SENSOR=3Dy
> CONFIG_RMI4_F11=3Dy
> CONFIG_RMI4_F12=3Dy
> CONFIG_RMI4_F30=3Dy
> CONFIG_RMI4_F34=3Dy
> # CONFIG_RMI4_F3A is not set
> CONFIG_RMI4_F54=3Dy
> CONFIG_RMI4_F55=3Dy
>=20
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=3Dy
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> CONFIG_SERIO_SERPORT=3Dm
> CONFIG_SERIO_CT82C710=3Dm
> CONFIG_SERIO_PARKBD=3Dm
> CONFIG_SERIO_PCIPS2=3Dm
> CONFIG_SERIO_LIBPS2=3Dy
> CONFIG_SERIO_RAW=3Dm
> CONFIG_SERIO_ALTERA_PS2=3Dm
> CONFIG_SERIO_PS2MULT=3Dm
> CONFIG_SERIO_ARC_PS2=3Dm
> # CONFIG_SERIO_APBPS2 is not set
> CONFIG_HYPERV_KEYBOARD=3Dm
> CONFIG_SERIO_GPIO_PS2=3Dm
> CONFIG_USERIO=3Dm
> CONFIG_GAMEPORT=3Dm
> CONFIG_GAMEPORT_NS558=3Dm
> CONFIG_GAMEPORT_L4=3Dm
> CONFIG_GAMEPORT_EMU10K1=3Dm
> CONFIG_GAMEPORT_FM801=3Dm
> # end of Hardware I/O ports
> # end of Input device support
>=20
> #
> # Character devices
> #
> CONFIG_TTY=3Dy
> CONFIG_VT=3Dy
> CONFIG_CONSOLE_TRANSLATIONS=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_VT_CONSOLE_SLEEP=3Dy
> CONFIG_HW_CONSOLE=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> CONFIG_UNIX98_PTYS=3Dy
> CONFIG_LEGACY_PTYS=3Dy
> CONFIG_LEGACY_PTY_COUNT=3D0
> CONFIG_LDISC_AUTOLOAD=3Dy
>=20
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=3Dy
> CONFIG_SERIAL_8250=3Dy
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PNP=3Dy
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> CONFIG_SERIAL_8250_FINTEK=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_DMA=3Dy
> CONFIG_SERIAL_8250_PCI=3Dy
> CONFIG_SERIAL_8250_EXAR=3Dm
> CONFIG_SERIAL_8250_CS=3Dm
> CONFIG_SERIAL_8250_MEN_MCB=3Dm
> CONFIG_SERIAL_8250_NR_UARTS=3D48
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D32
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> # CONFIG_SERIAL_8250_ASPEED_VUART is not set
> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_RSA=3Dy
> CONFIG_SERIAL_8250_DWLIB=3Dy
> CONFIG_SERIAL_8250_DW=3Dm
> CONFIG_SERIAL_8250_RT288X=3Dy
> CONFIG_SERIAL_8250_LPSS=3Dm
> CONFIG_SERIAL_8250_MID=3Dm
> CONFIG_SERIAL_8250_PERICOM=3Dy
> # CONFIG_SERIAL_OF_PLATFORM is not set
>=20
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_KGDB_NMI=3Dy
> CONFIG_SERIAL_MAX3100=3Dm
> CONFIG_SERIAL_MAX310X=3Dy
> CONFIG_SERIAL_UARTLITE=3Dm
> CONFIG_SERIAL_UARTLITE_NR_UARTS=3D1
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> CONFIG_CONSOLE_POLL=3Dy
> CONFIG_SERIAL_JSM=3Dm
> # CONFIG_SERIAL_SIFIVE is not set
> # CONFIG_SERIAL_LANTIQ is not set
> CONFIG_SERIAL_SCCNXP=3Dy
> CONFIG_SERIAL_SCCNXP_CONSOLE=3Dy
> CONFIG_SERIAL_SC16IS7XX_CORE=3Dm
> CONFIG_SERIAL_SC16IS7XX=3Dm
> CONFIG_SERIAL_SC16IS7XX_I2C=3Dy
> CONFIG_SERIAL_SC16IS7XX_SPI=3Dy
> CONFIG_SERIAL_ALTERA_JTAGUART=3Dm
> CONFIG_SERIAL_ALTERA_UART=3Dm
> CONFIG_SERIAL_ALTERA_UART_MAXPORTS=3D4
> CONFIG_SERIAL_ALTERA_UART_BAUDRATE=3D115200
> # CONFIG_SERIAL_XILINX_PS_UART is not set
> CONFIG_SERIAL_ARC=3Dm
> CONFIG_SERIAL_ARC_NR_PORTS=3D1
> CONFIG_SERIAL_RP2=3Dm
> CONFIG_SERIAL_RP2_NR_UARTS=3D32
> CONFIG_SERIAL_FSL_LPUART=3Dm
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
> CONFIG_SERIAL_MEN_Z135=3Dm
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
>=20
> CONFIG_SERIAL_MCTRL_GPIO=3Dy
> CONFIG_SERIAL_NONSTANDARD=3Dy
> CONFIG_MOXA_INTELLIO=3Dm
> CONFIG_MOXA_SMARTIO=3Dm
> CONFIG_SYNCLINK_GT=3Dm
> CONFIG_N_HDLC=3Dm
> CONFIG_N_GSM=3Dm
> CONFIG_NOZOMI=3Dm
> # CONFIG_NULL_TTY is not set
> CONFIG_HVC_DRIVER=3Dy
> CONFIG_HVC_IRQ=3Dy
> CONFIG_HVC_XEN=3Dy
> CONFIG_HVC_XEN_FRONTEND=3Dy
> # CONFIG_RPMSG_TTY is not set
> CONFIG_SERIAL_DEV_BUS=3Dy
> CONFIG_SERIAL_DEV_CTRL_TTYPORT=3Dy
> CONFIG_TTY_PRINTK=3Dy
> CONFIG_TTY_PRINTK_LEVEL=3D6
> CONFIG_PRINTER=3Dm
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=3Dm
> CONFIG_VIRTIO_CONSOLE=3Dy
> CONFIG_IPMI_HANDLER=3Dy
> CONFIG_IPMI_DMI_DECODE=3Dy
> CONFIG_IPMI_PLAT_DATA=3Dy
> CONFIG_IPMI_PANIC_EVENT=3Dy
> CONFIG_IPMI_PANIC_STRING=3Dy
> CONFIG_IPMI_DEVICE_INTERFACE=3Dy
> CONFIG_IPMI_SI=3Dm
> CONFIG_IPMI_SSIF=3Dm
> CONFIG_IPMI_WATCHDOG=3Dm
> CONFIG_IPMI_POWEROFF=3Dm
> CONFIG_HW_RANDOM=3Dy
> CONFIG_HW_RANDOM_TIMERIOMEM=3Dm
> CONFIG_HW_RANDOM_INTEL=3Dm
> CONFIG_HW_RANDOM_AMD=3Dm
> # CONFIG_HW_RANDOM_BA431 is not set
> CONFIG_HW_RANDOM_VIA=3Dm
> CONFIG_HW_RANDOM_VIRTIO=3Dm
> # CONFIG_HW_RANDOM_CCTRNG is not set
> # CONFIG_HW_RANDOM_XIPHERA is not set
> CONFIG_APPLICOM=3Dm
>=20
> #
> # PCMCIA character devices
> #
> CONFIG_SYNCLINK_CS=3Dm
> CONFIG_CARDMAN_4000=3Dm
> CONFIG_CARDMAN_4040=3Dm
> CONFIG_SCR24X=3Dm
> CONFIG_IPWIRELESS=3Dm
> # end of PCMCIA character devices
>=20
> CONFIG_MWAVE=3Dm
> CONFIG_DEVMEM=3Dy
> CONFIG_NVRAM=3Dm
> CONFIG_DEVPORT=3Dy
> CONFIG_HPET=3Dy
> CONFIG_HPET_MMAP=3Dy
> CONFIG_HPET_MMAP_DEFAULT=3Dy
> CONFIG_HANGCHECK_TIMER=3Dm
> CONFIG_TCG_TPM=3Dy
> CONFIG_HW_RANDOM_TPM=3Dy
> CONFIG_TCG_TIS_CORE=3Dy
> CONFIG_TCG_TIS=3Dy
> CONFIG_TCG_TIS_SPI=3Dm
> # CONFIG_TCG_TIS_SPI_CR50 is not set
> # CONFIG_TCG_TIS_I2C_CR50 is not set
> CONFIG_TCG_TIS_I2C_ATMEL=3Dm
> CONFIG_TCG_TIS_I2C_INFINEON=3Dm
> CONFIG_TCG_TIS_I2C_NUVOTON=3Dm
> CONFIG_TCG_NSC=3Dm
> CONFIG_TCG_ATMEL=3Dm
> CONFIG_TCG_INFINEON=3Dm
> CONFIG_TCG_XEN=3Dm
> CONFIG_TCG_CRB=3Dy
> CONFIG_TCG_VTPM_PROXY=3Dy
> CONFIG_TCG_TIS_ST33ZP24=3Dm
> CONFIG_TCG_TIS_ST33ZP24_I2C=3Dm
> CONFIG_TCG_TIS_ST33ZP24_SPI=3Dm
> CONFIG_TELCLOCK=3Dm
> CONFIG_XILLYBUS_CLASS=3Dm
> CONFIG_XILLYBUS=3Dm
> CONFIG_XILLYBUS_PCIE=3Dm
> # CONFIG_XILLYBUS_OF is not set
> # CONFIG_XILLYUSB is not set
> # CONFIG_RANDOM_TRUST_CPU is not set
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> # end of Character devices
>=20
> #
> # I2C support
> #
> CONFIG_I2C=3Dy
> CONFIG_ACPI_I2C_OPREGION=3Dy
> CONFIG_I2C_BOARDINFO=3Dy
> CONFIG_I2C_COMPAT=3Dy
> CONFIG_I2C_CHARDEV=3Dy
> CONFIG_I2C_MUX=3Dm
>=20
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
> CONFIG_I2C_MUX_GPIO=3Dm
> # CONFIG_I2C_MUX_GPMUX is not set
> CONFIG_I2C_MUX_LTC4306=3Dm
> CONFIG_I2C_MUX_PCA9541=3Dm
> CONFIG_I2C_MUX_PCA954x=3Dm
> # CONFIG_I2C_MUX_PINCTRL is not set
> CONFIG_I2C_MUX_REG=3Dm
> # CONFIG_I2C_DEMUX_PINCTRL is not set
> CONFIG_I2C_MUX_MLXCPLD=3Dm
> # end of Multiplexer I2C Chip support
>=20
> CONFIG_I2C_HELPER_AUTO=3Dy
> CONFIG_I2C_SMBUS=3Dm
> CONFIG_I2C_ALGOBIT=3Dy
> CONFIG_I2C_ALGOPCA=3Dm
>=20
> #
> # I2C Hardware Bus support
> #
>=20
> #
> # PC SMBus host controller drivers
> #
> CONFIG_I2C_CCGX_UCSI=3Dm
> CONFIG_I2C_ALI1535=3Dm
> CONFIG_I2C_ALI1563=3Dm
> CONFIG_I2C_ALI15X3=3Dm
> CONFIG_I2C_AMD756=3Dm
> CONFIG_I2C_AMD756_S4882=3Dm
> CONFIG_I2C_AMD8111=3Dm
> # CONFIG_I2C_AMD_MP2 is not set
> CONFIG_I2C_I801=3Dm
> CONFIG_I2C_ISCH=3Dm
> CONFIG_I2C_ISMT=3Dm
> CONFIG_I2C_PIIX4=3Dm
> CONFIG_I2C_NFORCE2=3Dm
> CONFIG_I2C_NFORCE2_S4985=3Dm
> # CONFIG_I2C_NVIDIA_GPU is not set
> CONFIG_I2C_SIS5595=3Dm
> CONFIG_I2C_SIS630=3Dm
> CONFIG_I2C_SIS96X=3Dm
> CONFIG_I2C_VIA=3Dm
> CONFIG_I2C_VIAPRO=3Dm
>=20
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=3Dm
>=20
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> CONFIG_I2C_CBUS_GPIO=3Dm
> CONFIG_I2C_DESIGNWARE_CORE=3Dy
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PLATFORM=3Dy
> # CONFIG_I2C_DESIGNWARE_AMDPSP is not set
> CONFIG_I2C_DESIGNWARE_BAYTRAIL=3Dy
> CONFIG_I2C_DESIGNWARE_PCI=3Dm
> # CONFIG_I2C_EMEV2 is not set
> CONFIG_I2C_GPIO=3Dm
> # CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
> CONFIG_I2C_KEMPLD=3Dm
> CONFIG_I2C_OCORES=3Dm
> CONFIG_I2C_PCA_PLATFORM=3Dm
> # CONFIG_I2C_RK3X is not set
> CONFIG_I2C_SIMTEC=3Dm
> CONFIG_I2C_XILINX=3Dm
>=20
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_DIOLAN_U2C=3Dm
> CONFIG_I2C_DLN2=3Dm
> # CONFIG_I2C_CP2615 is not set
> CONFIG_I2C_PARPORT=3Dm
> CONFIG_I2C_ROBOTFUZZ_OSIF=3Dm
> CONFIG_I2C_TAOS_EVM=3Dm
> CONFIG_I2C_TINY_USB=3Dm
> CONFIG_I2C_VIPERBOARD=3Dm
>=20
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_MLXCPLD=3Dm
> CONFIG_I2C_CROS_EC_TUNNEL=3Dm
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
>=20
> CONFIG_I2C_STUB=3Dm
> # CONFIG_I2C_SLAVE is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
>=20
> # CONFIG_I3C is not set
> CONFIG_SPI=3Dy
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=3Dy
> CONFIG_SPI_MEM=3Dy
>=20
> #
> # SPI Master Controller Drivers
> #
> CONFIG_SPI_ALTERA=3Dm
> CONFIG_SPI_ALTERA_CORE=3Dm
> CONFIG_SPI_AXI_SPI_ENGINE=3Dm
> CONFIG_SPI_BITBANG=3Dm
> CONFIG_SPI_BUTTERFLY=3Dm
> CONFIG_SPI_CADENCE=3Dm
> # CONFIG_SPI_CADENCE_QUADSPI is not set
> # CONFIG_SPI_CADENCE_XSPI is not set
> CONFIG_SPI_DESIGNWARE=3Dm
> # CONFIG_SPI_DW_DMA is not set
> CONFIG_SPI_DW_PCI=3Dm
> CONFIG_SPI_DW_MMIO=3Dm
> CONFIG_SPI_DLN2=3Dm
> # CONFIG_SPI_NXP_FLEXSPI is not set
> CONFIG_SPI_GPIO=3Dm
> CONFIG_SPI_INTEL=3Dm
> CONFIG_SPI_INTEL_PCI=3Dm
> CONFIG_SPI_INTEL_PLATFORM=3Dm
> CONFIG_SPI_LM70_LLP=3Dm
> # CONFIG_SPI_FSL_SPI is not set
> # CONFIG_SPI_LANTIQ_SSC is not set
> CONFIG_SPI_OC_TINY=3Dm
> CONFIG_SPI_PXA2XX=3Dm
> CONFIG_SPI_PXA2XX_PCI=3Dm
> # CONFIG_SPI_ROCKCHIP is not set
> CONFIG_SPI_SC18IS602=3Dm
> # CONFIG_SPI_SIFIVE is not set
> # CONFIG_SPI_MXIC is not set
> CONFIG_SPI_XCOMM=3Dm
> # CONFIG_SPI_XILINX is not set
> CONFIG_SPI_ZYNQMP_GQSPI=3Dm
> # CONFIG_SPI_AMD is not set
>=20
> #
> # SPI Multiplexer support
> #
> # CONFIG_SPI_MUX is not set
>=20
> #
> # SPI Protocol Masters
> #
> CONFIG_SPI_SPIDEV=3Dm
> CONFIG_SPI_LOOPBACK_TEST=3Dm
> CONFIG_SPI_TLE62X0=3Dm
> CONFIG_SPI_SLAVE=3Dy
> CONFIG_SPI_SLAVE_TIME=3Dm
> CONFIG_SPI_SLAVE_SYSTEM_CONTROL=3Dm
> CONFIG_SPI_DYNAMIC=3Dy
> CONFIG_SPMI=3Dm
> # CONFIG_SPMI_HISI3670 is not set
> CONFIG_HSI=3Dm
> CONFIG_HSI_BOARDINFO=3Dy
>=20
> #
> # HSI controllers
> #
>=20
> #
> # HSI clients
> #
> CONFIG_HSI_CHAR=3Dm
> CONFIG_PPS=3Dy
> # CONFIG_PPS_DEBUG is not set
>=20
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> CONFIG_PPS_CLIENT_LDISC=3Dm
> CONFIG_PPS_CLIENT_PARPORT=3Dm
> CONFIG_PPS_CLIENT_GPIO=3Dm
>=20
> #
> # PPS generators support
> #
>=20
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=3Dy
> CONFIG_PTP_1588_CLOCK_OPTIONAL=3Dy
>=20
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks=
.
> #
> CONFIG_PTP_1588_CLOCK_KVM=3Dm
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # CONFIG_PTP_1588_CLOCK_OCP is not set
> # end of PTP clock support
>=20
> CONFIG_PINCTRL=3Dy
> CONFIG_PINMUX=3Dy
> CONFIG_PINCONF=3Dy
> CONFIG_GENERIC_PINCONF=3Dy
> CONFIG_DEBUG_PINCTRL=3Dy
> CONFIG_PINCTRL_AMD=3Dy
> # CONFIG_PINCTRL_AXP209 is not set
> # CONFIG_PINCTRL_DA9062 is not set
> # CONFIG_PINCTRL_EQUILIBRIUM is not set
> CONFIG_PINCTRL_MCP23S08_I2C=3Dm
> CONFIG_PINCTRL_MCP23S08_SPI=3Dm
> CONFIG_PINCTRL_MCP23S08=3Dm
> # CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
> # CONFIG_PINCTRL_OCELOT is not set
> # CONFIG_PINCTRL_PALMAS is not set
> # CONFIG_PINCTRL_SINGLE is not set
> # CONFIG_PINCTRL_STMFX is not set
> CONFIG_PINCTRL_SX150X=3Dy
>=20
> #
> # Intel pinctrl drivers
> #
> # CONFIG_PINCTRL_BAYTRAIL is not set
> CONFIG_PINCTRL_CHERRYVIEW=3Dm
> CONFIG_PINCTRL_LYNXPOINT=3Dm
> CONFIG_PINCTRL_INTEL=3Dm
> # CONFIG_PINCTRL_INTEL_PLATFORM is not set
> CONFIG_PINCTRL_ALDERLAKE=3Dm
> CONFIG_PINCTRL_BROXTON=3Dm
> CONFIG_PINCTRL_CANNONLAKE=3Dm
> CONFIG_PINCTRL_CEDARFORK=3Dm
> CONFIG_PINCTRL_DENVERTON=3Dm
> CONFIG_PINCTRL_ELKHARTLAKE=3Dm
> CONFIG_PINCTRL_EMMITSBURG=3Dm
> CONFIG_PINCTRL_GEMINILAKE=3Dm
> CONFIG_PINCTRL_ICELAKE=3Dm
> CONFIG_PINCTRL_JASPERLAKE=3Dm
> CONFIG_PINCTRL_LAKEFIELD=3Dm
> CONFIG_PINCTRL_LEWISBURG=3Dm
> CONFIG_PINCTRL_METEORLAKE=3Dm
> CONFIG_PINCTRL_METEORPOINT=3Dm
> CONFIG_PINCTRL_SUNRISEPOINT=3Dm
> CONFIG_PINCTRL_TIGERLAKE=3Dm
> # end of Intel pinctrl drivers
>=20
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
>=20
> CONFIG_GPIOLIB=3Dy
> CONFIG_GPIOLIB_FASTPATH_LIMIT=3D512
> CONFIG_OF_GPIO=3Dy
> CONFIG_GPIO_ACPI=3Dy
> CONFIG_GPIOLIB_IRQCHIP=3Dy
> CONFIG_DEBUG_GPIO=3Dy
> CONFIG_GPIO_SYSFS=3Dy
> CONFIG_GPIO_CDEV=3Dy
> CONFIG_GPIO_CDEV_V1=3Dy
> CONFIG_GPIO_GENERIC=3Dm
> CONFIG_GPIO_MAX730X=3Dm
>=20
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_74XX_MMIO is not set
> # CONFIG_GPIO_ALTERA is not set
> CONFIG_GPIO_AMDPT=3Dm
> # CONFIG_GPIO_CADENCE is not set
> CONFIG_GPIO_DWAPB=3Dm
> CONFIG_GPIO_EXAR=3Dm
> # CONFIG_GPIO_FTGPIO010 is not set
> CONFIG_GPIO_GENERIC_PLATFORM=3Dm
> # CONFIG_GPIO_GRGPIO is not set
> # CONFIG_GPIO_HLWD is not set
> CONFIG_GPIO_ICH=3Dm
> # CONFIG_GPIO_LOGICVC is not set
> CONFIG_GPIO_MB86S7X=3Dm
> CONFIG_GPIO_MENZ127=3Dm
> # CONFIG_GPIO_SAMA5D2_PIOBU is not set
> # CONFIG_GPIO_SIFIVE is not set
> # CONFIG_GPIO_SIOX is not set
> # CONFIG_GPIO_SYSCON is not set
> CONFIG_GPIO_VX855=3Dm
> # CONFIG_GPIO_XILINX is not set
> # CONFIG_GPIO_AMD_FCH is not set
> # end of Memory mapped GPIO drivers
>=20
> #
> # Port-mapped I/O GPIO drivers
> #
> CONFIG_GPIO_104_DIO_48E=3Dm
> CONFIG_GPIO_104_IDIO_16=3Dm
> CONFIG_GPIO_104_IDI_48=3Dm
> CONFIG_GPIO_F7188X=3Dm
> CONFIG_GPIO_GPIO_MM=3Dm
> CONFIG_GPIO_IT87=3Dm
> CONFIG_GPIO_SCH=3Dm
> CONFIG_GPIO_SCH311X=3Dm
> CONFIG_GPIO_WINBOND=3Dm
> CONFIG_GPIO_WS16C48=3Dm
> # end of Port-mapped I/O GPIO drivers
>=20
> #
> # I2C GPIO expanders
> #
> CONFIG_GPIO_ADP5588=3Dm
> # CONFIG_GPIO_ADNP is not set
> # CONFIG_GPIO_GW_PLD is not set
> CONFIG_GPIO_MAX7300=3Dm
> CONFIG_GPIO_MAX732X=3Dm
> CONFIG_GPIO_PCA953X=3Dm
> # CONFIG_GPIO_PCA953X_IRQ is not set
> # CONFIG_GPIO_PCA9570 is not set
> CONFIG_GPIO_PCF857X=3Dm
> CONFIG_GPIO_TPIC2810=3Dm
> # end of I2C GPIO expanders
>=20
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_ADP5520=3Dm
> CONFIG_GPIO_ARIZONA=3Dm
> CONFIG_GPIO_BD9571MWV=3Dm
> # CONFIG_GPIO_CRYSTAL_COVE is not set
> CONFIG_GPIO_DA9052=3Dm
> CONFIG_GPIO_DA9055=3Dm
> CONFIG_GPIO_DLN2=3Dm
> CONFIG_GPIO_JANZ_TTL=3Dm
> CONFIG_GPIO_KEMPLD=3Dm
> CONFIG_GPIO_LP3943=3Dm
> CONFIG_GPIO_LP873X=3Dm
> CONFIG_GPIO_PALMAS=3Dy
> CONFIG_GPIO_RC5T583=3Dy
> CONFIG_GPIO_TPS65086=3Dm
> CONFIG_GPIO_TPS6586X=3Dy
> CONFIG_GPIO_TPS65910=3Dy
> CONFIG_GPIO_TPS65912=3Dm
> CONFIG_GPIO_TWL4030=3Dm
> CONFIG_GPIO_TWL6040=3Dm
> CONFIG_GPIO_UCB1400=3Dm
> # CONFIG_GPIO_WHISKEY_COVE is not set
> CONFIG_GPIO_WM831X=3Dm
> CONFIG_GPIO_WM8350=3Dm
> CONFIG_GPIO_WM8994=3Dm
> # end of MFD GPIO expanders
>=20
> #
> # PCI GPIO expanders
> #
> CONFIG_GPIO_AMD8111=3Dm
> CONFIG_GPIO_ML_IOH=3Dm
> CONFIG_GPIO_PCI_IDIO_16=3Dm
> CONFIG_GPIO_PCIE_IDIO_24=3Dm
> CONFIG_GPIO_RDC321X=3Dm
> # CONFIG_GPIO_SODAVILLE is not set
> # end of PCI GPIO expanders
>=20
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_74X164 is not set
> CONFIG_GPIO_MAX3191X=3Dm
> CONFIG_GPIO_MAX7301=3Dm
> CONFIG_GPIO_MC33880=3Dm
> CONFIG_GPIO_PISOSR=3Dm
> CONFIG_GPIO_XRA1403=3Dm
> # end of SPI GPIO expanders
>=20
> #
> # USB GPIO expanders
> #
> CONFIG_GPIO_VIPERBOARD=3Dm
> # end of USB GPIO expanders
>=20
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> CONFIG_GPIO_MOCKUP=3Dm
> # CONFIG_GPIO_VIRTIO is not set
> # CONFIG_GPIO_SIM is not set
> # end of Virtual GPIO drivers
>=20
> CONFIG_W1=3Dm
> CONFIG_W1_CON=3Dy
>=20
> #
> # 1-wire Bus Masters
> #
> CONFIG_W1_MASTER_MATROX=3Dm
> CONFIG_W1_MASTER_DS2490=3Dm
> CONFIG_W1_MASTER_DS2482=3Dm
> CONFIG_W1_MASTER_DS1WM=3Dm
> CONFIG_W1_MASTER_GPIO=3Dm
> # CONFIG_W1_MASTER_SGI is not set
> # end of 1-wire Bus Masters
>=20
> #
> # 1-wire Slaves
> #
> CONFIG_W1_SLAVE_THERM=3Dm
> CONFIG_W1_SLAVE_SMEM=3Dm
> CONFIG_W1_SLAVE_DS2405=3Dm
> CONFIG_W1_SLAVE_DS2408=3Dm
> CONFIG_W1_SLAVE_DS2408_READBACK=3Dy
> CONFIG_W1_SLAVE_DS2413=3Dm
> CONFIG_W1_SLAVE_DS2406=3Dm
> CONFIG_W1_SLAVE_DS2423=3Dm
> CONFIG_W1_SLAVE_DS2805=3Dm
> # CONFIG_W1_SLAVE_DS2430 is not set
> CONFIG_W1_SLAVE_DS2431=3Dm
> CONFIG_W1_SLAVE_DS2433=3Dm
> # CONFIG_W1_SLAVE_DS2433_CRC is not set
> CONFIG_W1_SLAVE_DS2438=3Dm
> # CONFIG_W1_SLAVE_DS250X is not set
> CONFIG_W1_SLAVE_DS2780=3Dm
> CONFIG_W1_SLAVE_DS2781=3Dm
> CONFIG_W1_SLAVE_DS28E04=3Dm
> CONFIG_W1_SLAVE_DS28E17=3Dm
> # end of 1-wire Slaves
>=20
> CONFIG_POWER_RESET=3Dy
> # CONFIG_POWER_RESET_GPIO is not set
> # CONFIG_POWER_RESET_GPIO_RESTART is not set
> # CONFIG_POWER_RESET_LTC2952 is not set
> # CONFIG_POWER_RESET_MT6323 is not set
> # CONFIG_POWER_RESET_REGULATOR is not set
> CONFIG_POWER_RESET_RESTART=3Dy
> # CONFIG_POWER_RESET_TPS65086 is not set
> # CONFIG_POWER_RESET_SYSCON is not set
> # CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
> # CONFIG_SYSCON_REBOOT_MODE is not set
> # CONFIG_NVMEM_REBOOT_MODE is not set
> CONFIG_POWER_SUPPLY=3Dy
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=3Dy
> CONFIG_PDA_POWER=3Dm
> CONFIG_GENERIC_ADC_BATTERY=3Dm
> # CONFIG_IP5XXX_POWER is not set
> CONFIG_MAX8925_POWER=3Dm
> CONFIG_WM831X_BACKUP=3Dm
> CONFIG_WM831X_POWER=3Dm
> CONFIG_WM8350_POWER=3Dm
> CONFIG_TEST_POWER=3Dm
> CONFIG_BATTERY_88PM860X=3Dm
> # CONFIG_CHARGER_ADP5061 is not set
> # CONFIG_BATTERY_CW2015 is not set
> CONFIG_BATTERY_DS2760=3Dm
> CONFIG_BATTERY_DS2780=3Dm
> CONFIG_BATTERY_DS2781=3Dm
> CONFIG_BATTERY_DS2782=3Dm
> # CONFIG_BATTERY_SAMSUNG_SDI is not set
> CONFIG_BATTERY_SBS=3Dm
> CONFIG_CHARGER_SBS=3Dm
> CONFIG_MANAGER_SBS=3Dm
> CONFIG_BATTERY_BQ27XXX=3Dm
> CONFIG_BATTERY_BQ27XXX_I2C=3Dm
> CONFIG_BATTERY_BQ27XXX_HDQ=3Dm
> # CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
> CONFIG_BATTERY_DA9030=3Dm
> CONFIG_BATTERY_DA9052=3Dm
> CONFIG_CHARGER_DA9150=3Dm
> CONFIG_BATTERY_DA9150=3Dm
> CONFIG_CHARGER_AXP20X=3Dm
> CONFIG_BATTERY_AXP20X=3Dm
> CONFIG_AXP20X_POWER=3Dm
> CONFIG_AXP288_CHARGER=3Dm
> CONFIG_AXP288_FUEL_GAUGE=3Dm
> CONFIG_BATTERY_MAX17040=3Dm
> CONFIG_BATTERY_MAX17042=3Dm
> CONFIG_BATTERY_MAX1721X=3Dm
> CONFIG_BATTERY_TWL4030_MADC=3Dm
> CONFIG_CHARGER_88PM860X=3Dm
> CONFIG_CHARGER_PCF50633=3Dm
> CONFIG_BATTERY_RX51=3Dm
> CONFIG_CHARGER_ISP1704=3Dm
> CONFIG_CHARGER_MAX8903=3Dm
> CONFIG_CHARGER_TWL4030=3Dm
> CONFIG_CHARGER_LP8727=3Dm
> CONFIG_CHARGER_LP8788=3Dm
> CONFIG_CHARGER_GPIO=3Dm
> CONFIG_CHARGER_MANAGER=3Dy
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_LTC4162L is not set
> CONFIG_CHARGER_MAX14577=3Dm
> # CONFIG_CHARGER_DETECTOR_MAX14656 is not set
> CONFIG_CHARGER_MAX77693=3Dm
> # CONFIG_CHARGER_MAX77976 is not set
> CONFIG_CHARGER_MAX8997=3Dm
> CONFIG_CHARGER_MAX8998=3Dm
> CONFIG_CHARGER_BQ2415X=3Dm
> CONFIG_CHARGER_BQ24190=3Dm
> CONFIG_CHARGER_BQ24257=3Dm
> CONFIG_CHARGER_BQ24735=3Dm
> # CONFIG_CHARGER_BQ2515X is not set
> CONFIG_CHARGER_BQ25890=3Dm
> # CONFIG_CHARGER_BQ25980 is not set
> # CONFIG_CHARGER_BQ256XX is not set
> CONFIG_CHARGER_SMB347=3Dm
> CONFIG_CHARGER_TPS65090=3Dm
> CONFIG_BATTERY_GAUGE_LTC2941=3Dm
> # CONFIG_BATTERY_GOLDFISH is not set
> CONFIG_BATTERY_RT5033=3Dm
> CONFIG_CHARGER_RT9455=3Dm
> # CONFIG_CHARGER_CROS_USBPD is not set
> CONFIG_CHARGER_CROS_PCHG=3Dm
> # CONFIG_CHARGER_UCS1002 is not set
> # CONFIG_CHARGER_BD99954 is not set
> # CONFIG_BATTERY_UG3105 is not set
> CONFIG_HWMON=3Dy
> CONFIG_HWMON_VID=3Dm
> # CONFIG_HWMON_DEBUG_CHIP is not set
>=20
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=3Dm
> CONFIG_SENSORS_ABITUGURU3=3Dm
> CONFIG_SENSORS_AD7314=3Dm
> CONFIG_SENSORS_AD7414=3Dm
> CONFIG_SENSORS_AD7418=3Dm
> CONFIG_SENSORS_ADM1021=3Dm
> CONFIG_SENSORS_ADM1025=3Dm
> CONFIG_SENSORS_ADM1026=3Dm
> CONFIG_SENSORS_ADM1029=3Dm
> CONFIG_SENSORS_ADM1031=3Dm
> # CONFIG_SENSORS_ADM1177 is not set
> CONFIG_SENSORS_ADM9240=3Dm
> CONFIG_SENSORS_ADT7X10=3Dm
> CONFIG_SENSORS_ADT7310=3Dm
> CONFIG_SENSORS_ADT7410=3Dm
> CONFIG_SENSORS_ADT7411=3Dm
> CONFIG_SENSORS_ADT7462=3Dm
> CONFIG_SENSORS_ADT7470=3Dm
> CONFIG_SENSORS_ADT7475=3Dm
> # CONFIG_SENSORS_AHT10 is not set
> # CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
> # CONFIG_SENSORS_AS370 is not set
> CONFIG_SENSORS_ASC7621=3Dm
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> CONFIG_SENSORS_K8TEMP=3Dm
> CONFIG_SENSORS_K10TEMP=3Dm
> CONFIG_SENSORS_FAM15H_POWER=3Dm
> CONFIG_SENSORS_APPLESMC=3Dm
> CONFIG_SENSORS_ASB100=3Dm
> CONFIG_SENSORS_ASPEED=3Dm
> CONFIG_SENSORS_ATXP1=3Dm
> # CONFIG_SENSORS_CORSAIR_CPRO is not set
> # CONFIG_SENSORS_CORSAIR_PSU is not set
> # CONFIG_SENSORS_DRIVETEMP is not set
> CONFIG_SENSORS_DS620=3Dm
> CONFIG_SENSORS_DS1621=3Dm
> CONFIG_SENSORS_DELL_SMM=3Dm
> # CONFIG_I8K is not set
> CONFIG_SENSORS_DA9052_ADC=3Dm
> CONFIG_SENSORS_DA9055=3Dm
> CONFIG_SENSORS_I5K_AMB=3Dm
> CONFIG_SENSORS_F71805F=3Dm
> CONFIG_SENSORS_F71882FG=3Dm
> CONFIG_SENSORS_F75375S=3Dm
> CONFIG_SENSORS_MC13783_ADC=3Dm
> CONFIG_SENSORS_FSCHMD=3Dm
> CONFIG_SENSORS_FTSTEUTATES=3Dm
> CONFIG_SENSORS_GL518SM=3Dm
> CONFIG_SENSORS_GL520SM=3Dm
> CONFIG_SENSORS_G760A=3Dm
> CONFIG_SENSORS_G762=3Dm
> # CONFIG_SENSORS_GPIO_FAN is not set
> CONFIG_SENSORS_HIH6130=3Dm
> CONFIG_SENSORS_IBMAEM=3Dm
> CONFIG_SENSORS_IBMPEX=3Dm
> CONFIG_SENSORS_IIO_HWMON=3Dm
> CONFIG_SENSORS_I5500=3Dm
> CONFIG_SENSORS_CORETEMP=3Dm
> CONFIG_SENSORS_IT87=3Dm
> CONFIG_SENSORS_JC42=3Dm
> CONFIG_SENSORS_POWR1220=3Dm
> CONFIG_SENSORS_LINEAGE=3Dm
> CONFIG_SENSORS_LTC2945=3Dm
> # CONFIG_SENSORS_LTC2947_I2C is not set
> # CONFIG_SENSORS_LTC2947_SPI is not set
> CONFIG_SENSORS_LTC2990=3Dm
> # CONFIG_SENSORS_LTC2992 is not set
> CONFIG_SENSORS_LTC4151=3Dm
> CONFIG_SENSORS_LTC4215=3Dm
> CONFIG_SENSORS_LTC4222=3Dm
> CONFIG_SENSORS_LTC4245=3Dm
> CONFIG_SENSORS_LTC4260=3Dm
> CONFIG_SENSORS_LTC4261=3Dm
> CONFIG_SENSORS_MAX1111=3Dm
> # CONFIG_SENSORS_MAX127 is not set
> CONFIG_SENSORS_MAX16065=3Dm
> CONFIG_SENSORS_MAX1619=3Dm
> CONFIG_SENSORS_MAX1668=3Dm
> CONFIG_SENSORS_MAX197=3Dm
> CONFIG_SENSORS_MAX31722=3Dm
> # CONFIG_SENSORS_MAX31730 is not set
> # CONFIG_SENSORS_MAX6620 is not set
> CONFIG_SENSORS_MAX6621=3Dm
> CONFIG_SENSORS_MAX6639=3Dm
> CONFIG_SENSORS_MAX6642=3Dm
> CONFIG_SENSORS_MAX6650=3Dm
> CONFIG_SENSORS_MAX6697=3Dm
> CONFIG_SENSORS_MAX31790=3Dm
> CONFIG_SENSORS_MCP3021=3Dm
> # CONFIG_SENSORS_MLXREG_FAN is not set
> CONFIG_SENSORS_TC654=3Dm
> # CONFIG_SENSORS_TPS23861 is not set
> CONFIG_SENSORS_MENF21BMC_HWMON=3Dm
> # CONFIG_SENSORS_MR75203 is not set
> CONFIG_SENSORS_ADCXX=3Dm
> CONFIG_SENSORS_LM63=3Dm
> CONFIG_SENSORS_LM70=3Dm
> CONFIG_SENSORS_LM73=3Dm
> CONFIG_SENSORS_LM75=3Dm
> CONFIG_SENSORS_LM77=3Dm
> CONFIG_SENSORS_LM78=3Dm
> CONFIG_SENSORS_LM80=3Dm
> CONFIG_SENSORS_LM83=3Dm
> CONFIG_SENSORS_LM85=3Dm
> CONFIG_SENSORS_LM87=3Dm
> CONFIG_SENSORS_LM90=3Dm
> CONFIG_SENSORS_LM92=3Dm
> CONFIG_SENSORS_LM93=3Dm
> CONFIG_SENSORS_LM95234=3Dm
> CONFIG_SENSORS_LM95241=3Dm
> CONFIG_SENSORS_LM95245=3Dm
> CONFIG_SENSORS_PC87360=3Dm
> CONFIG_SENSORS_PC87427=3Dm
> CONFIG_SENSORS_NTC_THERMISTOR=3Dm
> CONFIG_SENSORS_NCT6683=3Dm
> CONFIG_SENSORS_NCT6775=3Dm
> CONFIG_SENSORS_NCT7802=3Dm
> CONFIG_SENSORS_NCT7904=3Dm
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_NZXT_KRAKEN2 is not set
> # CONFIG_SENSORS_NZXT_SMART2 is not set
> CONFIG_SENSORS_PCF8591=3Dm
> CONFIG_PMBUS=3Dm
> CONFIG_SENSORS_PMBUS=3Dm
> # CONFIG_SENSORS_ADM1266 is not set
> CONFIG_SENSORS_ADM1275=3Dm
> # CONFIG_SENSORS_BEL_PFE is not set
> # CONFIG_SENSORS_BPA_RS600 is not set
> # CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
> # CONFIG_SENSORS_FSP_3Y is not set
> CONFIG_SENSORS_IBM_CFFPS=3Dm
> # CONFIG_SENSORS_DPS920AB is not set
> # CONFIG_SENSORS_INSPUR_IPSPS is not set
> CONFIG_SENSORS_IR35221=3Dm
> # CONFIG_SENSORS_IR36021 is not set
> # CONFIG_SENSORS_IR38064 is not set
> # CONFIG_SENSORS_IRPS5401 is not set
> # CONFIG_SENSORS_ISL68137 is not set
> CONFIG_SENSORS_LM25066=3Dm
> # CONFIG_SENSORS_LM25066_REGULATOR is not set
> CONFIG_SENSORS_LTC2978=3Dm
> CONFIG_SENSORS_LTC2978_REGULATOR=3Dy
> CONFIG_SENSORS_LTC3815=3Dm
> # CONFIG_SENSORS_MAX15301 is not set
> CONFIG_SENSORS_MAX16064=3Dm
> # CONFIG_SENSORS_MAX16601 is not set
> # CONFIG_SENSORS_MAX20730 is not set
> CONFIG_SENSORS_MAX20751=3Dm
> CONFIG_SENSORS_MAX31785=3Dm
> CONFIG_SENSORS_MAX34440=3Dm
> CONFIG_SENSORS_MAX8688=3Dm
> # CONFIG_SENSORS_MP2888 is not set
> # CONFIG_SENSORS_MP2975 is not set
> # CONFIG_SENSORS_MP5023 is not set
> # CONFIG_SENSORS_PIM4328 is not set
> # CONFIG_SENSORS_PLI1209BC is not set
> # CONFIG_SENSORS_PM6764TR is not set
> # CONFIG_SENSORS_PXE1610 is not set
> # CONFIG_SENSORS_Q54SJ108A2 is not set
> # CONFIG_SENSORS_STPDDC60 is not set
> CONFIG_SENSORS_TPS40422=3Dm
> CONFIG_SENSORS_TPS53679=3Dm
> CONFIG_SENSORS_UCD9000=3Dm
> CONFIG_SENSORS_UCD9200=3Dm
> # CONFIG_SENSORS_XDPE122 is not set
> CONFIG_SENSORS_ZL6100=3Dm
> # CONFIG_SENSORS_PWM_FAN is not set
> # CONFIG_SENSORS_SBTSI is not set
> # CONFIG_SENSORS_SBRMI is not set
> CONFIG_SENSORS_SHT15=3Dm
> CONFIG_SENSORS_SHT21=3Dm
> CONFIG_SENSORS_SHT3x=3Dm
> # CONFIG_SENSORS_SHT4x is not set
> CONFIG_SENSORS_SHTC1=3Dm
> CONFIG_SENSORS_SIS5595=3Dm
> # CONFIG_SENSORS_SY7636A is not set
> CONFIG_SENSORS_DME1737=3Dm
> CONFIG_SENSORS_EMC1403=3Dm
> CONFIG_SENSORS_EMC2103=3Dm
> CONFIG_SENSORS_EMC6W201=3Dm
> CONFIG_SENSORS_SMSC47M1=3Dm
> CONFIG_SENSORS_SMSC47M192=3Dm
> CONFIG_SENSORS_SMSC47B397=3Dm
> CONFIG_SENSORS_SCH56XX_COMMON=3Dm
> CONFIG_SENSORS_SCH5627=3Dm
> CONFIG_SENSORS_SCH5636=3Dm
> CONFIG_SENSORS_STTS751=3Dm
> CONFIG_SENSORS_SMM665=3Dm
> CONFIG_SENSORS_ADC128D818=3Dm
> CONFIG_SENSORS_ADS7828=3Dm
> CONFIG_SENSORS_ADS7871=3Dm
> CONFIG_SENSORS_AMC6821=3Dm
> CONFIG_SENSORS_INA209=3Dm
> CONFIG_SENSORS_INA2XX=3Dm
> # CONFIG_SENSORS_INA238 is not set
> CONFIG_SENSORS_INA3221=3Dm
> CONFIG_SENSORS_TC74=3Dm
> CONFIG_SENSORS_THMC50=3Dm
> CONFIG_SENSORS_TMP102=3Dm
> CONFIG_SENSORS_TMP103=3Dm
> CONFIG_SENSORS_TMP108=3Dm
> CONFIG_SENSORS_TMP401=3Dm
> CONFIG_SENSORS_TMP421=3Dm
> # CONFIG_SENSORS_TMP464 is not set
> # CONFIG_SENSORS_TMP513 is not set
> CONFIG_SENSORS_VIA_CPUTEMP=3Dm
> CONFIG_SENSORS_VIA686A=3Dm
> CONFIG_SENSORS_VT1211=3Dm
> CONFIG_SENSORS_VT8231=3Dm
> CONFIG_SENSORS_W83773G=3Dm
> CONFIG_SENSORS_W83781D=3Dm
> CONFIG_SENSORS_W83791D=3Dm
> CONFIG_SENSORS_W83792D=3Dm
> CONFIG_SENSORS_W83793=3Dm
> CONFIG_SENSORS_W83795=3Dm
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=3Dm
> CONFIG_SENSORS_W83L786NG=3Dm
> CONFIG_SENSORS_W83627HF=3Dm
> CONFIG_SENSORS_W83627EHF=3Dm
> CONFIG_SENSORS_WM831X=3Dm
> CONFIG_SENSORS_WM8350=3Dm
> CONFIG_SENSORS_XGENE=3Dm
>=20
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=3Dm
> CONFIG_SENSORS_ATK0110=3Dm
> # CONFIG_SENSORS_ASUS_WMI is not set
> # CONFIG_SENSORS_ASUS_WMI_EC is not set
> # CONFIG_SENSORS_ASUS_EC is not set
> CONFIG_THERMAL=3Dy
> CONFIG_THERMAL_NETLINK=3Dy
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0
> CONFIG_THERMAL_HWMON=3Dy
> CONFIG_THERMAL_OF=3Dy
> CONFIG_THERMAL_WRITABLE_TRIPS=3Dy
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=3Dy
> CONFIG_THERMAL_GOV_STEP_WISE=3Dy
> CONFIG_THERMAL_GOV_BANG_BANG=3Dy
> CONFIG_THERMAL_GOV_USER_SPACE=3Dy
> # CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
> # CONFIG_CPU_THERMAL is not set
> CONFIG_DEVFREQ_THERMAL=3Dy
> CONFIG_THERMAL_EMULATION=3Dy
> # CONFIG_THERMAL_MMIO is not set
> # CONFIG_DA9062_THERMAL is not set
>=20
> #
> # Intel thermal drivers
> #
> CONFIG_INTEL_POWERCLAMP=3Dm
> CONFIG_X86_THERMAL_VECTOR=3Dy
> CONFIG_INTEL_TCC_LIB=3Dm
> CONFIG_X86_PKG_TEMP_THERMAL=3Dm
> CONFIG_INTEL_SOC_DTS_IOSF_CORE=3Dm
> CONFIG_INTEL_SOC_DTS_THERMAL=3Dm
>=20
> #
> # ACPI INT340X thermal drivers
> #
> CONFIG_INT340X_THERMAL=3Dm
> CONFIG_ACPI_THERMAL_REL=3Dm
> CONFIG_INT3406_THERMAL=3Dm
> CONFIG_PROC_THERMAL_MMIO_RAPL=3Dm
> # end of ACPI INT340X thermal drivers
>=20
> # CONFIG_INTEL_BXT_PMIC_THERMAL is not set
> CONFIG_INTEL_PCH_THERMAL=3Dm
> # CONFIG_INTEL_TCC_COOLING is not set
> CONFIG_INTEL_MENLOW=3Dm
> CONFIG_INTEL_HFI_THERMAL=3Dy
> # end of Intel thermal drivers
>=20
> CONFIG_GENERIC_ADC_THERMAL=3Dm
> CONFIG_WATCHDOG=3Dy
> CONFIG_WATCHDOG_CORE=3Dy
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy
> CONFIG_WATCHDOG_OPEN_TIMEOUT=3D0
> CONFIG_WATCHDOG_SYSFS=3Dy
> # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
>=20
> #
> # Watchdog Pretimeout Governors
> #
> CONFIG_WATCHDOG_PRETIMEOUT_GOV=3Dy
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=3Dm
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=3Dy
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=3Dm
> CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=3Dy
> # CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
>=20
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=3Dm
> CONFIG_SOFT_WATCHDOG_PRETIMEOUT=3Dy
> CONFIG_DA9052_WATCHDOG=3Dm
> CONFIG_DA9055_WATCHDOG=3Dm
> CONFIG_DA9063_WATCHDOG=3Dm
> CONFIG_DA9062_WATCHDOG=3Dm
> # CONFIG_GPIO_WATCHDOG is not set
> CONFIG_MENF21BMC_WATCHDOG=3Dm
> # CONFIG_MENZ069_WATCHDOG is not set
> CONFIG_WDAT_WDT=3Dm
> CONFIG_WM831X_WATCHDOG=3Dm
> CONFIG_WM8350_WATCHDOG=3Dm
> CONFIG_XILINX_WATCHDOG=3Dm
> CONFIG_ZIIRAVE_WATCHDOG=3Dm
> CONFIG_RAVE_SP_WATCHDOG=3Dm
> # CONFIG_MLX_WDT is not set
> CONFIG_CADENCE_WATCHDOG=3Dm
> CONFIG_DW_WATCHDOG=3Dm
> CONFIG_TWL4030_WATCHDOG=3Dm
> CONFIG_MAX63XX_WATCHDOG=3Dm
> CONFIG_RETU_WATCHDOG=3Dm
> CONFIG_ACQUIRE_WDT=3Dm
> CONFIG_ADVANTECH_WDT=3Dm
> CONFIG_ALIM1535_WDT=3Dm
> CONFIG_ALIM7101_WDT=3Dm
> CONFIG_EBC_C384_WDT=3Dm
> CONFIG_F71808E_WDT=3Dm
> CONFIG_SP5100_TCO=3Dm
> CONFIG_SBC_FITPC2_WATCHDOG=3Dm
> CONFIG_EUROTECH_WDT=3Dm
> CONFIG_IB700_WDT=3Dm
> CONFIG_IBMASR=3Dm
> CONFIG_WAFER_WDT=3Dm
> # CONFIG_I6300ESB_WDT is not set
> CONFIG_IE6XX_WDT=3Dm
> # CONFIG_ITCO_WDT is not set
> CONFIG_IT8712F_WDT=3Dm
> CONFIG_IT87_WDT=3Dm
> CONFIG_HP_WATCHDOG=3Dm
> CONFIG_HPWDT_NMI_DECODING=3Dy
> CONFIG_KEMPLD_WDT=3Dm
> CONFIG_SC1200_WDT=3Dm
> CONFIG_PC87413_WDT=3Dm
> CONFIG_NV_TCO=3Dm
> CONFIG_60XX_WDT=3Dm
> CONFIG_CPU5_WDT=3Dm
> CONFIG_SMSC_SCH311X_WDT=3Dm
> CONFIG_SMSC37B787_WDT=3Dm
> # CONFIG_TQMX86_WDT is not set
> CONFIG_VIA_WDT=3Dm
> CONFIG_W83627HF_WDT=3Dm
> CONFIG_W83877F_WDT=3Dm
> CONFIG_W83977F_WDT=3Dm
> CONFIG_MACHZ_WDT=3Dm
> CONFIG_SBC_EPX_C3_WATCHDOG=3Dm
> CONFIG_INTEL_MEI_WDT=3Dm
> CONFIG_NI903X_WDT=3Dm
> CONFIG_NIC7018_WDT=3Dm
> CONFIG_MEN_A21_WDT=3Dm
> CONFIG_XEN_WDT=3Dm
>=20
> #
> # PCI-based Watchdog Cards
> #
> CONFIG_PCIPCWATCHDOG=3Dm
> CONFIG_WDTPCI=3Dm
>=20
> #
> # USB-based Watchdog Cards
> #
> CONFIG_USBPCWATCHDOG=3Dm
> CONFIG_SSB_POSSIBLE=3Dy
> CONFIG_SSB=3Dm
> CONFIG_SSB_SPROM=3Dy
> CONFIG_SSB_BLOCKIO=3Dy
> CONFIG_SSB_PCIHOST_POSSIBLE=3Dy
> CONFIG_SSB_PCIHOST=3Dy
> CONFIG_SSB_B43_PCI_BRIDGE=3Dy
> CONFIG_SSB_PCMCIAHOST_POSSIBLE=3Dy
> # CONFIG_SSB_PCMCIAHOST is not set
> CONFIG_SSB_SDIOHOST_POSSIBLE=3Dy
> CONFIG_SSB_SDIOHOST=3Dy
> CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=3Dy
> CONFIG_SSB_DRIVER_PCICORE=3Dy
> CONFIG_SSB_DRIVER_GPIO=3Dy
> CONFIG_BCMA_POSSIBLE=3Dy
> CONFIG_BCMA=3Dm
> CONFIG_BCMA_BLOCKIO=3Dy
> CONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy
> CONFIG_BCMA_HOST_PCI=3Dy
> CONFIG_BCMA_HOST_SOC=3Dy
> CONFIG_BCMA_DRIVER_PCI=3Dy
> CONFIG_BCMA_SFLASH=3Dy
> CONFIG_BCMA_DRIVER_GMAC_CMN=3Dy
> CONFIG_BCMA_DRIVER_GPIO=3Dy
> # CONFIG_BCMA_DEBUG is not set
>=20
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=3Dy
> # CONFIG_MFD_ACT8945A is not set
> CONFIG_MFD_AS3711=3Dy
> # CONFIG_MFD_AS3722 is not set
> CONFIG_PMIC_ADP5520=3Dy
> CONFIG_MFD_AAT2870_CORE=3Dy
> # CONFIG_MFD_ATMEL_FLEXCOM is not set
> # CONFIG_MFD_ATMEL_HLCDC is not set
> CONFIG_MFD_BCM590XX=3Dm
> CONFIG_MFD_BD9571MWV=3Dm
> CONFIG_MFD_AXP20X=3Dm
> CONFIG_MFD_AXP20X_I2C=3Dm
> CONFIG_MFD_CROS_EC_DEV=3Dm
> # CONFIG_MFD_MADERA is not set
> CONFIG_PMIC_DA903X=3Dy
> CONFIG_PMIC_DA9052=3Dy
> CONFIG_MFD_DA9052_SPI=3Dy
> CONFIG_MFD_DA9052_I2C=3Dy
> CONFIG_MFD_DA9055=3Dy
> CONFIG_MFD_DA9062=3Dm
> CONFIG_MFD_DA9063=3Dy
> CONFIG_MFD_DA9150=3Dm
> CONFIG_MFD_DLN2=3Dm
> # CONFIG_MFD_GATEWORKS_GSC is not set
> CONFIG_MFD_MC13XXX=3Dm
> CONFIG_MFD_MC13XXX_SPI=3Dm
> CONFIG_MFD_MC13XXX_I2C=3Dm
> # CONFIG_MFD_MP2629 is not set
> # CONFIG_MFD_HI6421_PMIC is not set
> # CONFIG_MFD_HI6421_SPMI is not set
> CONFIG_HTC_PASIC3=3Dm
> CONFIG_HTC_I2CPLD=3Dy
> CONFIG_MFD_INTEL_QUARK_I2C_GPIO=3Dm
> CONFIG_LPC_ICH=3Dy
> CONFIG_LPC_SCH=3Dm
> CONFIG_INTEL_SOC_PMIC=3Dy
> CONFIG_INTEL_SOC_PMIC_BXTWC=3Dm
> # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> CONFIG_INTEL_SOC_PMIC_CHTDC_TI=3Dm
> CONFIG_MFD_INTEL_LPSS=3Dm
> CONFIG_MFD_INTEL_LPSS_ACPI=3Dm
> CONFIG_MFD_INTEL_LPSS_PCI=3Dm
> CONFIG_MFD_INTEL_PMC_BXT=3Dm
> # CONFIG_MFD_IQS62X is not set
> CONFIG_MFD_JANZ_CMODIO=3Dm
> CONFIG_MFD_KEMPLD=3Dm
> CONFIG_MFD_88PM800=3Dm
> CONFIG_MFD_88PM805=3Dm
> CONFIG_MFD_88PM860X=3Dy
> CONFIG_MFD_MAX14577=3Dy
> # CONFIG_MFD_MAX77620 is not set
> # CONFIG_MFD_MAX77650 is not set
> # CONFIG_MFD_MAX77686 is not set
> CONFIG_MFD_MAX77693=3Dy
> # CONFIG_MFD_MAX77714 is not set
> CONFIG_MFD_MAX77843=3Dy
> CONFIG_MFD_MAX8907=3Dm
> CONFIG_MFD_MAX8925=3Dy
> CONFIG_MFD_MAX8997=3Dy
> CONFIG_MFD_MAX8998=3Dy
> # CONFIG_MFD_MT6360 is not set
> CONFIG_MFD_MT6397=3Dm
> CONFIG_MFD_MENF21BMC=3Dm
> CONFIG_EZX_PCAP=3Dy
> # CONFIG_MFD_CPCAP is not set
> CONFIG_MFD_VIPERBOARD=3Dm
> # CONFIG_MFD_NTXEC is not set
> CONFIG_MFD_RETU=3Dm
> CONFIG_MFD_PCF50633=3Dm
> CONFIG_PCF50633_ADC=3Dm
> CONFIG_PCF50633_GPIO=3Dm
> CONFIG_UCB1400_CORE=3Dm
> CONFIG_MFD_RDC321X=3Dm
> # CONFIG_MFD_RT4831 is not set
> CONFIG_MFD_RT5033=3Dm
> CONFIG_MFD_RC5T583=3Dy
> # CONFIG_MFD_RK808 is not set
> # CONFIG_MFD_RN5T618 is not set
> CONFIG_MFD_SEC_CORE=3Dy
> CONFIG_MFD_SI476X_CORE=3Dm
> # CONFIG_MFD_SIMPLE_MFD_I2C is not set
> CONFIG_MFD_SM501=3Dm
> CONFIG_MFD_SM501_GPIO=3Dy
> CONFIG_MFD_SKY81452=3Dm
> # CONFIG_MFD_STMPE is not set
> CONFIG_MFD_SYSCON=3Dy
> CONFIG_MFD_TI_AM335X_TSCADC=3Dm
> CONFIG_MFD_LP3943=3Dm
> CONFIG_MFD_LP8788=3Dy
> CONFIG_MFD_TI_LMU=3Dm
> CONFIG_MFD_PALMAS=3Dy
> CONFIG_TPS6105X=3Dm
> CONFIG_TPS65010=3Dm
> CONFIG_TPS6507X=3Dm
> CONFIG_MFD_TPS65086=3Dm
> CONFIG_MFD_TPS65090=3Dy
> # CONFIG_MFD_TPS65217 is not set
> CONFIG_MFD_TI_LP873X=3Dm
> # CONFIG_MFD_TI_LP87565 is not set
> # CONFIG_MFD_TPS65218 is not set
> CONFIG_MFD_TPS6586X=3Dy
> CONFIG_MFD_TPS65910=3Dy
> CONFIG_MFD_TPS65912=3Dy
> CONFIG_MFD_TPS65912_I2C=3Dy
> CONFIG_MFD_TPS65912_SPI=3Dy
> CONFIG_TWL4030_CORE=3Dy
> CONFIG_MFD_TWL4030_AUDIO=3Dy
> CONFIG_TWL6040_CORE=3Dy
> CONFIG_MFD_WL1273_CORE=3Dm
> CONFIG_MFD_LM3533=3Dm
> # CONFIG_MFD_TC3589X is not set
> # CONFIG_MFD_TQMX86 is not set
> CONFIG_MFD_VX855=3Dm
> # CONFIG_MFD_LOCHNAGAR is not set
> CONFIG_MFD_ARIZONA=3Dm
> CONFIG_MFD_ARIZONA_I2C=3Dm
> CONFIG_MFD_ARIZONA_SPI=3Dm
> CONFIG_MFD_CS47L24=3Dy
> CONFIG_MFD_WM5102=3Dy
> CONFIG_MFD_WM5110=3Dy
> CONFIG_MFD_WM8997=3Dy
> CONFIG_MFD_WM8998=3Dy
> CONFIG_MFD_WM8400=3Dy
> CONFIG_MFD_WM831X=3Dy
> CONFIG_MFD_WM831X_I2C=3Dy
> CONFIG_MFD_WM831X_SPI=3Dy
> CONFIG_MFD_WM8350=3Dy
> CONFIG_MFD_WM8350_I2C=3Dy
> CONFIG_MFD_WM8994=3Dm
> # CONFIG_MFD_ROHM_BD718XX is not set
> # CONFIG_MFD_ROHM_BD71828 is not set
> # CONFIG_MFD_ROHM_BD957XMUF is not set
> # CONFIG_MFD_STPMIC1 is not set
> # CONFIG_MFD_STMFX is not set
> # CONFIG_MFD_WCD934X is not set
> # CONFIG_MFD_ATC260X_I2C is not set
> # CONFIG_MFD_QCOM_PM8008 is not set
> CONFIG_RAVE_SP_CORE=3Dm
> # CONFIG_MFD_INTEL_M10_BMC is not set
> # CONFIG_MFD_RSMU_I2C is not set
> # CONFIG_MFD_RSMU_SPI is not set
> # end of Multifunction device drivers
>=20
> CONFIG_REGULATOR=3Dy
> # CONFIG_REGULATOR_DEBUG is not set
> CONFIG_REGULATOR_FIXED_VOLTAGE=3Dm
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=3Dm
> CONFIG_REGULATOR_USERSPACE_CONSUMER=3Dm
> # CONFIG_REGULATOR_88PG86X is not set
> CONFIG_REGULATOR_88PM800=3Dm
> CONFIG_REGULATOR_88PM8607=3Dm
> CONFIG_REGULATOR_ACT8865=3Dm
> CONFIG_REGULATOR_AD5398=3Dm
> CONFIG_REGULATOR_AAT2870=3Dm
> CONFIG_REGULATOR_ARIZONA_LDO1=3Dm
> CONFIG_REGULATOR_ARIZONA_MICSUPP=3Dm
> CONFIG_REGULATOR_AS3711=3Dm
> CONFIG_REGULATOR_AXP20X=3Dm
> CONFIG_REGULATOR_BCM590XX=3Dm
> CONFIG_REGULATOR_BD9571MWV=3Dm
> # CONFIG_REGULATOR_CROS_EC is not set
> CONFIG_REGULATOR_DA903X=3Dm
> CONFIG_REGULATOR_DA9052=3Dm
> CONFIG_REGULATOR_DA9055=3Dm
> CONFIG_REGULATOR_DA9062=3Dm
> # CONFIG_REGULATOR_DA9063 is not set
> # CONFIG_REGULATOR_DA9121 is not set
> CONFIG_REGULATOR_DA9210=3Dm
> CONFIG_REGULATOR_DA9211=3Dm
> CONFIG_REGULATOR_FAN53555=3Dm
> # CONFIG_REGULATOR_FAN53880 is not set
> CONFIG_REGULATOR_GPIO=3Dm
> CONFIG_REGULATOR_ISL9305=3Dm
> CONFIG_REGULATOR_ISL6271A=3Dm
> CONFIG_REGULATOR_LM363X=3Dm
> CONFIG_REGULATOR_LP3971=3Dm
> CONFIG_REGULATOR_LP3972=3Dm
> CONFIG_REGULATOR_LP872X=3Dm
> # CONFIG_REGULATOR_LP873X is not set
> CONFIG_REGULATOR_LP8755=3Dm
> CONFIG_REGULATOR_LP8788=3Dm
> CONFIG_REGULATOR_LTC3589=3Dm
> CONFIG_REGULATOR_LTC3676=3Dm
> CONFIG_REGULATOR_MAX14577=3Dm
> CONFIG_REGULATOR_MAX1586=3Dm
> CONFIG_REGULATOR_MAX8649=3Dm
> CONFIG_REGULATOR_MAX8660=3Dm
> # CONFIG_REGULATOR_MAX8893 is not set
> CONFIG_REGULATOR_MAX8907=3Dm
> CONFIG_REGULATOR_MAX8925=3Dm
> CONFIG_REGULATOR_MAX8952=3Dm
> # CONFIG_REGULATOR_MAX8973 is not set
> CONFIG_REGULATOR_MAX8997=3Dm
> CONFIG_REGULATOR_MAX8998=3Dm
> # CONFIG_REGULATOR_MAX20086 is not set
> CONFIG_REGULATOR_MAX77693=3Dm
> # CONFIG_REGULATOR_MAX77826 is not set
> CONFIG_REGULATOR_MC13XXX_CORE=3Dm
> CONFIG_REGULATOR_MC13783=3Dm
> CONFIG_REGULATOR_MC13892=3Dm
> # CONFIG_REGULATOR_MCP16502 is not set
> # CONFIG_REGULATOR_MP5416 is not set
> # CONFIG_REGULATOR_MP8859 is not set
> # CONFIG_REGULATOR_MP886X is not set
> # CONFIG_REGULATOR_MPQ7920 is not set
> CONFIG_REGULATOR_MT6311=3Dm
> # CONFIG_REGULATOR_MT6315 is not set
> CONFIG_REGULATOR_MT6323=3Dm
> # CONFIG_REGULATOR_MT6358 is not set
> # CONFIG_REGULATOR_MT6359 is not set
> CONFIG_REGULATOR_MT6397=3Dm
> CONFIG_REGULATOR_PALMAS=3Dm
> # CONFIG_REGULATOR_PCA9450 is not set
> CONFIG_REGULATOR_PCAP=3Dm
> CONFIG_REGULATOR_PCF50633=3Dm
> # CONFIG_REGULATOR_PF8X00 is not set
> CONFIG_REGULATOR_PFUZE100=3Dm
> CONFIG_REGULATOR_PV88060=3Dm
> CONFIG_REGULATOR_PV88080=3Dm
> CONFIG_REGULATOR_PV88090=3Dm
> CONFIG_REGULATOR_PWM=3Dm
> CONFIG_REGULATOR_QCOM_SPMI=3Dm
> # CONFIG_REGULATOR_QCOM_USB_VBUS is not set
> # CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
> CONFIG_REGULATOR_RC5T583=3Dm
> # CONFIG_REGULATOR_RT4801 is not set
> CONFIG_REGULATOR_RT5033=3Dm
> # CONFIG_REGULATOR_RT5190A is not set
> # CONFIG_REGULATOR_RT6160 is not set
> # CONFIG_REGULATOR_RT6245 is not set
> # CONFIG_REGULATOR_RTQ2134 is not set
> # CONFIG_REGULATOR_RTMV20 is not set
> # CONFIG_REGULATOR_RTQ6752 is not set
> CONFIG_REGULATOR_S2MPA01=3Dm
> CONFIG_REGULATOR_S2MPS11=3Dm
> CONFIG_REGULATOR_S5M8767=3Dm
> CONFIG_REGULATOR_SKY81452=3Dm
> # CONFIG_REGULATOR_SLG51000 is not set
> # CONFIG_REGULATOR_SY7636A is not set
> # CONFIG_REGULATOR_SY8106A is not set
> # CONFIG_REGULATOR_SY8824X is not set
> # CONFIG_REGULATOR_SY8827N is not set
> CONFIG_REGULATOR_TPS51632=3Dm
> CONFIG_REGULATOR_TPS6105X=3Dm
> CONFIG_REGULATOR_TPS62360=3Dm
> # CONFIG_REGULATOR_TPS6286X is not set
> CONFIG_REGULATOR_TPS65023=3Dm
> CONFIG_REGULATOR_TPS6507X=3Dm
> CONFIG_REGULATOR_TPS65086=3Dm
> CONFIG_REGULATOR_TPS65090=3Dm
> CONFIG_REGULATOR_TPS65132=3Dm
> CONFIG_REGULATOR_TPS6524X=3Dm
> CONFIG_REGULATOR_TPS6586X=3Dm
> CONFIG_REGULATOR_TPS65910=3Dm
> CONFIG_REGULATOR_TPS65912=3Dm
> CONFIG_REGULATOR_TWL4030=3Dm
> # CONFIG_REGULATOR_VCTRL is not set
> CONFIG_REGULATOR_WM831X=3Dm
> CONFIG_REGULATOR_WM8350=3Dm
> CONFIG_REGULATOR_WM8400=3Dm
> CONFIG_REGULATOR_WM8994=3Dm
> # CONFIG_REGULATOR_QCOM_LABIBB is not set
> CONFIG_RC_CORE=3Dm
> CONFIG_LIRC=3Dy
> CONFIG_RC_MAP=3Dm
> CONFIG_RC_DECODERS=3Dy
> # CONFIG_IR_IMON_DECODER is not set
> CONFIG_IR_JVC_DECODER=3Dm
> CONFIG_IR_MCE_KBD_DECODER=3Dm
> CONFIG_IR_NEC_DECODER=3Dm
> CONFIG_IR_RC5_DECODER=3Dm
> CONFIG_IR_RC6_DECODER=3Dm
> # CONFIG_IR_RCMM_DECODER is not set
> CONFIG_IR_SANYO_DECODER=3Dm
> CONFIG_IR_SHARP_DECODER=3Dm
> CONFIG_IR_SONY_DECODER=3Dm
> CONFIG_IR_XMP_DECODER=3Dm
> CONFIG_RC_DEVICES=3Dy
> CONFIG_IR_ENE=3Dm
> CONFIG_IR_FINTEK=3Dm
> # CONFIG_IR_GPIO_CIR is not set
> # CONFIG_IR_GPIO_TX is not set
> # CONFIG_IR_HIX5HD2 is not set
> CONFIG_IR_IGORPLUGUSB=3Dm
> CONFIG_IR_IGUANA=3Dm
> CONFIG_IR_IMON=3Dm
> # CONFIG_IR_IMON_RAW is not set
> CONFIG_IR_ITE_CIR=3Dm
> CONFIG_IR_MCEUSB=3Dm
> CONFIG_IR_NUVOTON=3Dm
> # CONFIG_IR_PWM_TX is not set
> CONFIG_IR_REDRAT3=3Dm
> CONFIG_IR_SERIAL=3Dm
> CONFIG_IR_SERIAL_TRANSMITTER=3Dy
> # CONFIG_IR_SPI is not set
> CONFIG_IR_STREAMZAP=3Dm
> # CONFIG_IR_TOY is not set
> CONFIG_IR_TTUSBIR=3Dm
> CONFIG_IR_WINBOND_CIR=3Dm
> CONFIG_RC_ATI_REMOTE=3Dm
> CONFIG_RC_LOOPBACK=3Dm
> # CONFIG_RC_XBOX_DVD is not set
> CONFIG_CEC_CORE=3Dm
>=20
> #
> # CEC support
> #
> CONFIG_MEDIA_CEC_RC=3Dy
> CONFIG_MEDIA_CEC_SUPPORT=3Dy
> # CONFIG_CEC_CH7322 is not set
> # CONFIG_CEC_CROS_EC is not set
> # CONFIG_CEC_GPIO is not set
> # CONFIG_CEC_SECO is not set
> CONFIG_USB_PULSE8_CEC=3Dm
> CONFIG_USB_RAINSHADOW_CEC=3Dm
> # end of CEC support
>=20
> CONFIG_MEDIA_SUPPORT=3Dm
> # CONFIG_MEDIA_SUPPORT_FILTER is not set
> CONFIG_MEDIA_SUBDRV_AUTOSELECT=3Dy
>=20
> #
> # Media device types
> #
> CONFIG_MEDIA_CAMERA_SUPPORT=3Dy
> CONFIG_MEDIA_ANALOG_TV_SUPPORT=3Dy
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=3Dy
> CONFIG_MEDIA_RADIO_SUPPORT=3Dy
> CONFIG_MEDIA_SDR_SUPPORT=3Dy
> CONFIG_MEDIA_PLATFORM_SUPPORT=3Dy
> CONFIG_MEDIA_TEST_SUPPORT=3Dy
> # end of Media device types
>=20
> #
> # Media core support
> #
> CONFIG_VIDEO_DEV=3Dm
> CONFIG_MEDIA_CONTROLLER=3Dy
> CONFIG_DVB_CORE=3Dm
> # end of Media core support
>=20
> #
> # Video4Linux options
> #
> CONFIG_VIDEO_V4L2_I2C=3Dy
> CONFIG_VIDEO_V4L2_SUBDEV_API=3Dy
> # CONFIG_VIDEO_ADV_DEBUG is not set
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> CONFIG_VIDEO_TUNER=3Dm
> CONFIG_V4L2_MEM2MEM_DEV=3Dm
> CONFIG_V4L2_FLASH_LED_CLASS=3Dm
> CONFIG_V4L2_FWNODE=3Dm
> CONFIG_V4L2_ASYNC=3Dm
> CONFIG_VIDEOBUF_GEN=3Dm
> CONFIG_VIDEOBUF_DMA_SG=3Dm
> CONFIG_VIDEOBUF_VMALLOC=3Dm
> # end of Video4Linux options
>=20
> #
> # Media controller options
> #
> CONFIG_MEDIA_CONTROLLER_DVB=3Dy
> CONFIG_MEDIA_CONTROLLER_REQUEST_API=3Dy
> # end of Media controller options
>=20
> #
> # Digital TV options
> #
> # CONFIG_DVB_MMAP is not set
> CONFIG_DVB_NET=3Dy
> CONFIG_DVB_MAX_ADAPTERS=3D8
> CONFIG_DVB_DYNAMIC_MINORS=3Dy
> # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> # CONFIG_DVB_ULE_DEBUG is not set
> # end of Digital TV options
>=20
> #
> # Media drivers
> #
>=20
> #
> # Media drivers
> #
> CONFIG_MEDIA_USB_SUPPORT=3Dy
>=20
> #
> # Webcam devices
> #
> CONFIG_VIDEO_CPIA2=3Dm
> CONFIG_USB_GSPCA=3Dm
> CONFIG_USB_GSPCA_BENQ=3Dm
> CONFIG_USB_GSPCA_CONEX=3Dm
> CONFIG_USB_GSPCA_CPIA1=3Dm
> CONFIG_USB_GSPCA_DTCS033=3Dm
> CONFIG_USB_GSPCA_ETOMS=3Dm
> CONFIG_USB_GSPCA_FINEPIX=3Dm
> CONFIG_USB_GSPCA_JEILINJ=3Dm
> CONFIG_USB_GSPCA_JL2005BCD=3Dm
> CONFIG_USB_GSPCA_KINECT=3Dm
> CONFIG_USB_GSPCA_KONICA=3Dm
> CONFIG_USB_GSPCA_MARS=3Dm
> CONFIG_USB_GSPCA_MR97310A=3Dm
> CONFIG_USB_GSPCA_NW80X=3Dm
> CONFIG_USB_GSPCA_OV519=3Dm
> CONFIG_USB_GSPCA_OV534=3Dm
> CONFIG_USB_GSPCA_OV534_9=3Dm
> CONFIG_USB_GSPCA_PAC207=3Dm
> CONFIG_USB_GSPCA_PAC7302=3Dm
> CONFIG_USB_GSPCA_PAC7311=3Dm
> CONFIG_USB_GSPCA_SE401=3Dm
> CONFIG_USB_GSPCA_SN9C2028=3Dm
> CONFIG_USB_GSPCA_SN9C20X=3Dm
> CONFIG_USB_GSPCA_SONIXB=3Dm
> CONFIG_USB_GSPCA_SONIXJ=3Dm
> CONFIG_USB_GSPCA_SPCA1528=3Dm
> CONFIG_USB_GSPCA_SPCA500=3Dm
> CONFIG_USB_GSPCA_SPCA501=3Dm
> CONFIG_USB_GSPCA_SPCA505=3Dm
> CONFIG_USB_GSPCA_SPCA506=3Dm
> CONFIG_USB_GSPCA_SPCA508=3Dm
> CONFIG_USB_GSPCA_SPCA561=3Dm
> CONFIG_USB_GSPCA_SQ905=3Dm
> CONFIG_USB_GSPCA_SQ905C=3Dm
> CONFIG_USB_GSPCA_SQ930X=3Dm
> CONFIG_USB_GSPCA_STK014=3Dm
> CONFIG_USB_GSPCA_STK1135=3Dm
> CONFIG_USB_GSPCA_STV0680=3Dm
> CONFIG_USB_GSPCA_SUNPLUS=3Dm
> CONFIG_USB_GSPCA_T613=3Dm
> CONFIG_USB_GSPCA_TOPRO=3Dm
> CONFIG_USB_GSPCA_TOUPTEK=3Dm
> CONFIG_USB_GSPCA_TV8532=3Dm
> CONFIG_USB_GSPCA_VC032X=3Dm
> CONFIG_USB_GSPCA_VICAM=3Dm
> CONFIG_USB_GSPCA_XIRLINK_CIT=3Dm
> CONFIG_USB_GSPCA_ZC3XX=3Dm
> CONFIG_USB_GL860=3Dm
> CONFIG_USB_M5602=3Dm
> CONFIG_USB_STV06XX=3Dm
> CONFIG_USB_PWC=3Dm
> # CONFIG_USB_PWC_DEBUG is not set
> CONFIG_USB_PWC_INPUT_EVDEV=3Dy
> CONFIG_USB_S2255=3Dm
> CONFIG_USB_STKWEBCAM=3Dm
> CONFIG_VIDEO_USBTV=3Dm
> CONFIG_USB_VIDEO_CLASS=3Dm
> CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=3Dy
> CONFIG_USB_ZR364XX=3Dm
>=20
> #
> # Analog TV USB devices
> #
> CONFIG_VIDEO_GO7007=3Dm
> CONFIG_VIDEO_GO7007_USB=3Dm
> CONFIG_VIDEO_GO7007_LOADER=3Dm
> CONFIG_VIDEO_GO7007_USB_S2250_BOARD=3Dm
> CONFIG_VIDEO_HDPVR=3Dm
> CONFIG_VIDEO_PVRUSB2=3Dm
> CONFIG_VIDEO_PVRUSB2_SYSFS=3Dy
> CONFIG_VIDEO_PVRUSB2_DVB=3Dy
> # CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
> CONFIG_VIDEO_STK1160_COMMON=3Dm
> CONFIG_VIDEO_STK1160=3Dm
>=20
> #
> # Analog/digital TV USB devices
> #
> CONFIG_VIDEO_AU0828=3Dm
> CONFIG_VIDEO_AU0828_V4L2=3Dy
> CONFIG_VIDEO_AU0828_RC=3Dy
> CONFIG_VIDEO_CX231XX=3Dm
> CONFIG_VIDEO_CX231XX_RC=3Dy
> CONFIG_VIDEO_CX231XX_ALSA=3Dm
> CONFIG_VIDEO_CX231XX_DVB=3Dm
> CONFIG_VIDEO_TM6000=3Dm
> CONFIG_VIDEO_TM6000_ALSA=3Dm
> CONFIG_VIDEO_TM6000_DVB=3Dm
>=20
> #
> # Digital TV USB devices
> #
> CONFIG_DVB_AS102=3Dm
> CONFIG_DVB_B2C2_FLEXCOP_USB=3Dm
> # CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
> CONFIG_DVB_USB_V2=3Dm
> CONFIG_DVB_USB_AF9015=3Dm
> CONFIG_DVB_USB_AF9035=3Dm
> CONFIG_DVB_USB_ANYSEE=3Dm
> CONFIG_DVB_USB_AU6610=3Dm
> CONFIG_DVB_USB_AZ6007=3Dm
> CONFIG_DVB_USB_CE6230=3Dm
> CONFIG_DVB_USB_DVBSKY=3Dm
> CONFIG_DVB_USB_EC168=3Dm
> CONFIG_DVB_USB_GL861=3Dm
> CONFIG_DVB_USB_LME2510=3Dm
> CONFIG_DVB_USB_MXL111SF=3Dm
> CONFIG_DVB_USB_RTL28XXU=3Dm
> CONFIG_DVB_USB_ZD1301=3Dm
> CONFIG_DVB_USB=3Dm
> # CONFIG_DVB_USB_DEBUG is not set
> CONFIG_DVB_USB_A800=3Dm
> CONFIG_DVB_USB_AF9005=3Dm
> CONFIG_DVB_USB_AF9005_REMOTE=3Dm
> CONFIG_DVB_USB_AZ6027=3Dm
> CONFIG_DVB_USB_CINERGY_T2=3Dm
> CONFIG_DVB_USB_CXUSB=3Dm
> # CONFIG_DVB_USB_CXUSB_ANALOG is not set
> CONFIG_DVB_USB_DIB0700=3Dm
> CONFIG_DVB_USB_DIB3000MC=3Dm
> CONFIG_DVB_USB_DIBUSB_MB=3Dm
> # CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
> CONFIG_DVB_USB_DIBUSB_MC=3Dm
> CONFIG_DVB_USB_DIGITV=3Dm
> CONFIG_DVB_USB_DTT200U=3Dm
> CONFIG_DVB_USB_DTV5100=3Dm
> CONFIG_DVB_USB_DW2102=3Dm
> CONFIG_DVB_USB_GP8PSK=3Dm
> CONFIG_DVB_USB_M920X=3Dm
> CONFIG_DVB_USB_NOVA_T_USB2=3Dm
> CONFIG_DVB_USB_OPERA1=3Dm
> CONFIG_DVB_USB_PCTV452E=3Dm
> CONFIG_DVB_USB_TECHNISAT_USB2=3Dm
> CONFIG_DVB_USB_TTUSB2=3Dm
> CONFIG_DVB_USB_UMT_010=3Dm
> CONFIG_DVB_USB_VP702X=3Dm
> CONFIG_DVB_USB_VP7045=3Dm
> CONFIG_SMS_USB_DRV=3Dm
> CONFIG_DVB_TTUSB_BUDGET=3Dm
> CONFIG_DVB_TTUSB_DEC=3Dm
>=20
> #
> # Webcam, TV (analog/digital) USB devices
> #
> CONFIG_VIDEO_EM28XX=3Dm
> CONFIG_VIDEO_EM28XX_V4L2=3Dm
> CONFIG_VIDEO_EM28XX_ALSA=3Dm
> CONFIG_VIDEO_EM28XX_DVB=3Dm
> CONFIG_VIDEO_EM28XX_RC=3Dm
>=20
> #
> # Software defined radio USB devices
> #
> CONFIG_USB_AIRSPY=3Dm
> CONFIG_USB_HACKRF=3Dm
> CONFIG_USB_MSI2500=3Dm
> CONFIG_MEDIA_PCI_SUPPORT=3Dy
>=20
> #
> # Media capture support
> #
> CONFIG_VIDEO_MEYE=3Dm
> CONFIG_VIDEO_SOLO6X10=3Dm
> CONFIG_VIDEO_TW5864=3Dm
> CONFIG_VIDEO_TW68=3Dm
> CONFIG_VIDEO_TW686X=3Dm
>=20
> #
> # Media capture/analog TV support
> #
> CONFIG_VIDEO_DT3155=3Dm
> CONFIG_VIDEO_IVTV=3Dm
> CONFIG_VIDEO_IVTV_ALSA=3Dm
> CONFIG_VIDEO_FB_IVTV=3Dm
> # CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
> CONFIG_VIDEO_HEXIUM_GEMINI=3Dm
> CONFIG_VIDEO_HEXIUM_ORION=3Dm
> CONFIG_VIDEO_MXB=3Dm
>=20
> #
> # Media capture/analog/hybrid TV support
> #
> CONFIG_VIDEO_BT848=3Dm
> CONFIG_DVB_BT8XX=3Dm
> CONFIG_VIDEO_COBALT=3Dm
> CONFIG_VIDEO_CX18=3Dm
> CONFIG_VIDEO_CX18_ALSA=3Dm
> CONFIG_VIDEO_CX23885=3Dm
> CONFIG_MEDIA_ALTERA_CI=3Dm
> CONFIG_VIDEO_CX25821=3Dm
> CONFIG_VIDEO_CX25821_ALSA=3Dm
> CONFIG_VIDEO_CX88=3Dm
> CONFIG_VIDEO_CX88_ALSA=3Dm
> CONFIG_VIDEO_CX88_BLACKBIRD=3Dm
> CONFIG_VIDEO_CX88_DVB=3Dm
> CONFIG_VIDEO_CX88_ENABLE_VP3054=3Dy
> CONFIG_VIDEO_CX88_VP3054=3Dm
> CONFIG_VIDEO_CX88_MPEG=3Dm
> CONFIG_VIDEO_SAA7134=3Dm
> CONFIG_VIDEO_SAA7134_ALSA=3Dm
> CONFIG_VIDEO_SAA7134_RC=3Dy
> CONFIG_VIDEO_SAA7134_DVB=3Dm
> CONFIG_VIDEO_SAA7134_GO7007=3Dm
> CONFIG_VIDEO_SAA7164=3Dm
>=20
> #
> # Media digital TV PCI Adapters
> #
> CONFIG_DVB_B2C2_FLEXCOP_PCI=3Dm
> # CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
> CONFIG_DVB_DDBRIDGE=3Dm
> # CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
> CONFIG_DVB_DM1105=3Dm
> CONFIG_MANTIS_CORE=3Dm
> CONFIG_DVB_MANTIS=3Dm
> CONFIG_DVB_HOPPER=3Dm
> CONFIG_DVB_NETUP_UNIDVB=3Dm
> CONFIG_DVB_NGENE=3Dm
> CONFIG_DVB_PLUTO2=3Dm
> CONFIG_DVB_PT1=3Dm
> CONFIG_DVB_PT3=3Dm
> CONFIG_DVB_SMIPCIE=3Dm
> CONFIG_DVB_BUDGET_CORE=3Dm
> CONFIG_DVB_BUDGET=3Dm
> CONFIG_DVB_BUDGET_CI=3Dm
> CONFIG_DVB_BUDGET_AV=3Dm
> CONFIG_VIDEO_IPU3_CIO2=3Dm
> # CONFIG_CIO2_BRIDGE is not set
> CONFIG_RADIO_ADAPTERS=3Dy
> CONFIG_RADIO_MAXIRADIO=3Dm
> CONFIG_RADIO_SAA7706H=3Dm
> CONFIG_RADIO_SHARK=3Dm
> CONFIG_RADIO_SHARK2=3Dm
> CONFIG_RADIO_SI4713=3Dm
> CONFIG_RADIO_SI476X=3Dm
> CONFIG_RADIO_TEA575X=3Dm
> CONFIG_RADIO_TEA5764=3Dm
> CONFIG_RADIO_TEF6862=3Dm
> CONFIG_RADIO_WL1273=3Dm
> CONFIG_USB_DSBR=3Dm
> CONFIG_USB_KEENE=3Dm
> CONFIG_USB_MA901=3Dm
> CONFIG_USB_MR800=3Dm
> CONFIG_USB_RAREMONO=3Dm
> CONFIG_RADIO_SI470X=3Dm
> CONFIG_USB_SI470X=3Dm
> CONFIG_I2C_SI470X=3Dm
> CONFIG_USB_SI4713=3Dm
> CONFIG_PLATFORM_SI4713=3Dm
> CONFIG_I2C_SI4713=3Dm
> CONFIG_RADIO_WL128X=3Dm
> CONFIG_MEDIA_PLATFORM_DRIVERS=3Dy
> CONFIG_V4L_PLATFORM_DRIVERS=3Dy
> CONFIG_SDR_PLATFORM_DRIVERS=3Dy
> CONFIG_DVB_PLATFORM_DRIVERS=3Dy
> CONFIG_V4L_MEM2MEM_DRIVERS=3Dy
> CONFIG_VIDEO_MEM2MEM_DEINTERLACE=3Dm
> # CONFIG_VIDEO_MUX is not set
>=20
> #
> # Allegro DVT media platform drivers
> #
>=20
> #
> # Amlogic media platform drivers
> #
>=20
> #
> # Amphion drivers
> #
>=20
> #
> # Aspeed media platform drivers
> #
> CONFIG_VIDEO_ASPEED=3Dm
>=20
> #
> # Atmel media platform drivers
> #
>=20
> #
> # Cadence media platform drivers
> #
> # CONFIG_VIDEO_CADENCE_CSI2RX is not set
> # CONFIG_VIDEO_CADENCE_CSI2TX is not set
>=20
> #
> # Chips&Media media platform drivers
> #
>=20
> #
> # Intel media platform drivers
> #
>=20
> #
> # Marvell media platform drivers
> #
> CONFIG_VIDEO_CAFE_CCIC=3Dm
>=20
> #
> # Mediatek media platform drivers
> #
>=20
> #
> # NVidia media platform drivers
> #
>=20
> #
> # NXP media platform drivers
> #
>=20
> #
> # Qualcomm media platform drivers
> #
>=20
> #
> # Renesas media platform drivers
> #
>=20
> #
> # Rockchip media platform drivers
> #
>=20
> #
> # Samsung media platform drivers
> #
>=20
> #
> # STMicroelectronics media platform drivers
> #
>=20
> #
> # Sunxi media platform drivers
> #
>=20
> #
> # Texas Instruments drivers
> #
>=20
> #
> # VIA media platform drivers
> #
> CONFIG_VIDEO_VIA_CAMERA=3Dm
>=20
> #
> # Xilinx media platform drivers
> #
> # CONFIG_VIDEO_XILINX is not set
>=20
> #
> # MMC/SDIO DVB adapters
> #
> CONFIG_SMS_SDIO_DRV=3Dm
> CONFIG_V4L_TEST_DRIVERS=3Dy
> CONFIG_VIDEO_VIM2M=3Dm
> # CONFIG_VIDEO_VICODEC is not set
> # CONFIG_VIDEO_VIMC is not set
> CONFIG_VIDEO_VIVID=3Dm
> CONFIG_VIDEO_VIVID_CEC=3Dy
> CONFIG_VIDEO_VIVID_MAX_DEVS=3D64
> # CONFIG_DVB_TEST_DRIVERS is not set
>=20
> #
> # FireWire (IEEE 1394) Adapters
> #
> CONFIG_DVB_FIREDTV=3Dm
> CONFIG_DVB_FIREDTV_INPUT=3Dy
> CONFIG_MEDIA_COMMON_OPTIONS=3Dy
>=20
> #
> # common driver options
> #
> CONFIG_CYPRESS_FIRMWARE=3Dm
> CONFIG_TTPCI_EEPROM=3Dm
> CONFIG_VIDEO_CX2341X=3Dm
> CONFIG_VIDEO_TVEEPROM=3Dm
> CONFIG_DVB_B2C2_FLEXCOP=3Dm
> CONFIG_VIDEO_SAA7146=3Dm
> CONFIG_VIDEO_SAA7146_VV=3Dm
> CONFIG_SMS_SIANO_MDTV=3Dm
> CONFIG_SMS_SIANO_RC=3Dy
> CONFIG_SMS_SIANO_DEBUGFS=3Dy
> CONFIG_VIDEO_V4L2_TPG=3Dm
> CONFIG_VIDEOBUF2_CORE=3Dm
> CONFIG_VIDEOBUF2_V4L2=3Dm
> CONFIG_VIDEOBUF2_MEMOPS=3Dm
> CONFIG_VIDEOBUF2_DMA_CONTIG=3Dm
> CONFIG_VIDEOBUF2_VMALLOC=3Dm
> CONFIG_VIDEOBUF2_DMA_SG=3Dm
> CONFIG_VIDEOBUF2_DVB=3Dm
> # end of Media drivers
>=20
> #
> # Media ancillary drivers
> #
> CONFIG_MEDIA_ATTACH=3Dy
>=20
> #
> # IR I2C driver auto-selected by 'Autoselect ancillary drivers'
> #
> CONFIG_VIDEO_IR_I2C=3Dm
>=20
> #
> # Camera sensor devices
> #
> # CONFIG_VIDEO_HI556 is not set
> # CONFIG_VIDEO_HI846 is not set
> # CONFIG_VIDEO_HI847 is not set
> # CONFIG_VIDEO_IMX208 is not set
> # CONFIG_VIDEO_IMX214 is not set
> # CONFIG_VIDEO_IMX219 is not set
> # CONFIG_VIDEO_IMX258 is not set
> # CONFIG_VIDEO_IMX274 is not set
> # CONFIG_VIDEO_IMX290 is not set
> # CONFIG_VIDEO_IMX319 is not set
> # CONFIG_VIDEO_IMX334 is not set
> # CONFIG_VIDEO_IMX335 is not set
> # CONFIG_VIDEO_IMX355 is not set
> # CONFIG_VIDEO_IMX412 is not set
> # CONFIG_VIDEO_MT9M001 is not set
> # CONFIG_VIDEO_MT9M032 is not set
> # CONFIG_VIDEO_MT9M111 is not set
> # CONFIG_VIDEO_MT9P031 is not set
> # CONFIG_VIDEO_MT9T001 is not set
> # CONFIG_VIDEO_MT9T112 is not set
> CONFIG_VIDEO_MT9V011=3Dm
> # CONFIG_VIDEO_MT9V032 is not set
> # CONFIG_VIDEO_MT9V111 is not set
> # CONFIG_VIDEO_NOON010PC30 is not set
> # CONFIG_VIDEO_OG01A1B is not set
> # CONFIG_VIDEO_OV02A10 is not set
> # CONFIG_VIDEO_OV08D10 is not set
> # CONFIG_VIDEO_OV13858 is not set
> # CONFIG_VIDEO_OV13B10 is not set
> CONFIG_VIDEO_OV2640=3Dm
> # CONFIG_VIDEO_OV2659 is not set
> # CONFIG_VIDEO_OV2680 is not set
> # CONFIG_VIDEO_OV2685 is not set
> # CONFIG_VIDEO_OV2740 is not set
> # CONFIG_VIDEO_OV5640 is not set
> # CONFIG_VIDEO_OV5645 is not set
> # CONFIG_VIDEO_OV5647 is not set
> # CONFIG_VIDEO_OV5648 is not set
> # CONFIG_VIDEO_OV5670 is not set
> # CONFIG_VIDEO_OV5675 is not set
> # CONFIG_VIDEO_OV5693 is not set
> # CONFIG_VIDEO_OV5695 is not set
> # CONFIG_VIDEO_OV6650 is not set
> # CONFIG_VIDEO_OV7251 is not set
> CONFIG_VIDEO_OV7640=3Dm
> CONFIG_VIDEO_OV7670=3Dm
> # CONFIG_VIDEO_OV772X is not set
> # CONFIG_VIDEO_OV7740 is not set
> # CONFIG_VIDEO_OV8856 is not set
> # CONFIG_VIDEO_OV8865 is not set
> # CONFIG_VIDEO_OV9282 is not set
> # CONFIG_VIDEO_OV9640 is not set
> # CONFIG_VIDEO_OV9650 is not set
> # CONFIG_VIDEO_OV9734 is not set
> # CONFIG_VIDEO_RDACM20 is not set
> # CONFIG_VIDEO_RDACM21 is not set
> # CONFIG_VIDEO_RJ54N1 is not set
> # CONFIG_VIDEO_S5C73M3 is not set
> # CONFIG_VIDEO_S5K4ECGX is not set
> # CONFIG_VIDEO_S5K5BAF is not set
> # CONFIG_VIDEO_S5K6A3 is not set
> # CONFIG_VIDEO_S5K6AA is not set
> # CONFIG_VIDEO_SR030PC30 is not set
> # CONFIG_VIDEO_VS6624 is not set
> # CONFIG_VIDEO_CCS is not set
> # CONFIG_VIDEO_ET8EK8 is not set
> # CONFIG_VIDEO_M5MOLS is not set
> # end of Camera sensor devices
>=20
> #
> # Lens drivers
> #
> # CONFIG_VIDEO_AD5820 is not set
> # CONFIG_VIDEO_AK7375 is not set
> # CONFIG_VIDEO_DW9714 is not set
> # CONFIG_VIDEO_DW9768 is not set
> # CONFIG_VIDEO_DW9807_VCM is not set
> # end of Lens drivers
>=20
> #
> # Flash devices
> #
> # CONFIG_VIDEO_ADP1653 is not set
> # CONFIG_VIDEO_LM3560 is not set
> # CONFIG_VIDEO_LM3646 is not set
> # end of Flash devices
>=20
> #
> # Audio decoders, processors and mixers
> #
> CONFIG_VIDEO_CS3308=3Dm
> CONFIG_VIDEO_CS5345=3Dm
> CONFIG_VIDEO_CS53L32A=3Dm
> CONFIG_VIDEO_MSP3400=3Dm
> CONFIG_VIDEO_SONY_BTF_MPX=3Dm
> # CONFIG_VIDEO_TDA1997X is not set
> CONFIG_VIDEO_TDA7432=3Dm
> CONFIG_VIDEO_TDA9840=3Dm
> CONFIG_VIDEO_TEA6415C=3Dm
> CONFIG_VIDEO_TEA6420=3Dm
> # CONFIG_VIDEO_TLV320AIC23B is not set
> CONFIG_VIDEO_TVAUDIO=3Dm
> CONFIG_VIDEO_UDA1342=3Dm
> CONFIG_VIDEO_VP27SMPX=3Dm
> CONFIG_VIDEO_WM8739=3Dm
> CONFIG_VIDEO_WM8775=3Dm
> # end of Audio decoders, processors and mixers
>=20
> #
> # RDS decoders
> #
> CONFIG_VIDEO_SAA6588=3Dm
> # end of RDS decoders
>=20
> #
> # Video decoders
> #
> # CONFIG_VIDEO_ADV7180 is not set
> # CONFIG_VIDEO_ADV7183 is not set
> # CONFIG_VIDEO_ADV748X is not set
> CONFIG_VIDEO_ADV7604=3Dm
> # CONFIG_VIDEO_ADV7604_CEC is not set
> CONFIG_VIDEO_ADV7842=3Dm
> # CONFIG_VIDEO_ADV7842_CEC is not set
> # CONFIG_VIDEO_BT819 is not set
> # CONFIG_VIDEO_BT856 is not set
> # CONFIG_VIDEO_BT866 is not set
> # CONFIG_VIDEO_ISL7998X is not set
> # CONFIG_VIDEO_KS0127 is not set
> CONFIG_VIDEO_MAX9286=3Dm
> # CONFIG_VIDEO_ML86V7667 is not set
> # CONFIG_VIDEO_SAA7110 is not set
> CONFIG_VIDEO_SAA711X=3Dm
> # CONFIG_VIDEO_TC358743 is not set
> # CONFIG_VIDEO_TVP514X is not set
> CONFIG_VIDEO_TVP5150=3Dm
> # CONFIG_VIDEO_TVP7002 is not set
> CONFIG_VIDEO_TW2804=3Dm
> CONFIG_VIDEO_TW9903=3Dm
> CONFIG_VIDEO_TW9906=3Dm
> # CONFIG_VIDEO_TW9910 is not set
> # CONFIG_VIDEO_VPX3220 is not set
>=20
> #
> # Video and audio decoders
> #
> CONFIG_VIDEO_SAA717X=3Dm
> CONFIG_VIDEO_CX25840=3Dm
> # end of Video decoders
>=20
> #
> # Video encoders
> #
> # CONFIG_VIDEO_AD9389B is not set
> # CONFIG_VIDEO_ADV7170 is not set
> # CONFIG_VIDEO_ADV7175 is not set
> # CONFIG_VIDEO_ADV7343 is not set
> # CONFIG_VIDEO_ADV7393 is not set
> CONFIG_VIDEO_ADV7511=3Dm
> # CONFIG_VIDEO_ADV7511_CEC is not set
> # CONFIG_VIDEO_AK881X is not set
> CONFIG_VIDEO_SAA7127=3Dm
> # CONFIG_VIDEO_SAA7185 is not set
> # CONFIG_VIDEO_THS8200 is not set
> # end of Video encoders
>=20
> #
> # Video improvement chips
> #
> CONFIG_VIDEO_UPD64031A=3Dm
> CONFIG_VIDEO_UPD64083=3Dm
> # end of Video improvement chips
>=20
> #
> # Audio/Video compression chips
> #
> CONFIG_VIDEO_SAA6752HS=3Dm
> # end of Audio/Video compression chips
>=20
> #
> # SDR tuner chips
> #
> # CONFIG_SDR_MAX2175 is not set
> # end of SDR tuner chips
>=20
> #
> # Miscellaneous helper chips
> #
> # CONFIG_VIDEO_I2C is not set
> CONFIG_VIDEO_M52790=3Dm
> # CONFIG_VIDEO_ST_MIPID02 is not set
> # CONFIG_VIDEO_THS7303 is not set
> # end of Miscellaneous helper chips
>=20
> #
> # Media SPI Adapters
> #
> # CONFIG_CXD2880_SPI_DRV is not set
> # CONFIG_VIDEO_GS1662 is not set
> # end of Media SPI Adapters
>=20
> CONFIG_MEDIA_TUNER=3Dm
>=20
> #
> # Customize TV tuners
> #
> CONFIG_MEDIA_TUNER_E4000=3Dm
> CONFIG_MEDIA_TUNER_FC0011=3Dm
> CONFIG_MEDIA_TUNER_FC0012=3Dm
> CONFIG_MEDIA_TUNER_FC0013=3Dm
> CONFIG_MEDIA_TUNER_FC2580=3Dm
> CONFIG_MEDIA_TUNER_IT913X=3Dm
> CONFIG_MEDIA_TUNER_M88RS6000T=3Dm
> CONFIG_MEDIA_TUNER_MAX2165=3Dm
> CONFIG_MEDIA_TUNER_MC44S803=3Dm
> CONFIG_MEDIA_TUNER_MSI001=3Dm
> CONFIG_MEDIA_TUNER_MT2060=3Dm
> CONFIG_MEDIA_TUNER_MT2063=3Dm
> CONFIG_MEDIA_TUNER_MT20XX=3Dm
> CONFIG_MEDIA_TUNER_MT2131=3Dm
> CONFIG_MEDIA_TUNER_MT2266=3Dm
> CONFIG_MEDIA_TUNER_MXL301RF=3Dm
> CONFIG_MEDIA_TUNER_MXL5005S=3Dm
> CONFIG_MEDIA_TUNER_MXL5007T=3Dm
> CONFIG_MEDIA_TUNER_QM1D1B0004=3Dm
> CONFIG_MEDIA_TUNER_QM1D1C0042=3Dm
> CONFIG_MEDIA_TUNER_QT1010=3Dm
> CONFIG_MEDIA_TUNER_R820T=3Dm
> CONFIG_MEDIA_TUNER_SI2157=3Dm
> CONFIG_MEDIA_TUNER_SIMPLE=3Dm
> CONFIG_MEDIA_TUNER_TDA18212=3Dm
> CONFIG_MEDIA_TUNER_TDA18218=3Dm
> CONFIG_MEDIA_TUNER_TDA18250=3Dm
> CONFIG_MEDIA_TUNER_TDA18271=3Dm
> CONFIG_MEDIA_TUNER_TDA827X=3Dm
> CONFIG_MEDIA_TUNER_TDA8290=3Dm
> CONFIG_MEDIA_TUNER_TDA9887=3Dm
> CONFIG_MEDIA_TUNER_TEA5761=3Dm
> CONFIG_MEDIA_TUNER_TEA5767=3Dm
> CONFIG_MEDIA_TUNER_TUA9001=3Dm
> CONFIG_MEDIA_TUNER_XC2028=3Dm
> CONFIG_MEDIA_TUNER_XC4000=3Dm
> CONFIG_MEDIA_TUNER_XC5000=3Dm
> # end of Customize TV tuners
>=20
> #
> # Customise DVB Frontends
> #
>=20
> #
> # Multistandard (satellite) frontends
> #
> CONFIG_DVB_M88DS3103=3Dm
> CONFIG_DVB_MXL5XX=3Dm
> CONFIG_DVB_STB0899=3Dm
> CONFIG_DVB_STB6100=3Dm
> CONFIG_DVB_STV090x=3Dm
> CONFIG_DVB_STV0910=3Dm
> CONFIG_DVB_STV6110x=3Dm
> CONFIG_DVB_STV6111=3Dm
>=20
> #
> # Multistandard (cable + terrestrial) frontends
> #
> CONFIG_DVB_DRXK=3Dm
> CONFIG_DVB_MN88472=3Dm
> CONFIG_DVB_MN88473=3Dm
> CONFIG_DVB_SI2165=3Dm
> CONFIG_DVB_TDA18271C2DD=3Dm
>=20
> #
> # DVB-S (satellite) frontends
> #
> CONFIG_DVB_CX24110=3Dm
> CONFIG_DVB_CX24116=3Dm
> CONFIG_DVB_CX24117=3Dm
> CONFIG_DVB_CX24120=3Dm
> CONFIG_DVB_CX24123=3Dm
> CONFIG_DVB_DS3000=3Dm
> CONFIG_DVB_MB86A16=3Dm
> CONFIG_DVB_MT312=3Dm
> CONFIG_DVB_S5H1420=3Dm
> CONFIG_DVB_SI21XX=3Dm
> CONFIG_DVB_STB6000=3Dm
> CONFIG_DVB_STV0288=3Dm
> CONFIG_DVB_STV0299=3Dm
> CONFIG_DVB_STV0900=3Dm
> CONFIG_DVB_STV6110=3Dm
> CONFIG_DVB_TDA10071=3Dm
> CONFIG_DVB_TDA10086=3Dm
> CONFIG_DVB_TDA8083=3Dm
> CONFIG_DVB_TDA8261=3Dm
> CONFIG_DVB_TDA826X=3Dm
> CONFIG_DVB_TS2020=3Dm
> CONFIG_DVB_TUA6100=3Dm
> CONFIG_DVB_TUNER_CX24113=3Dm
> CONFIG_DVB_TUNER_ITD1000=3Dm
> CONFIG_DVB_VES1X93=3Dm
> CONFIG_DVB_ZL10036=3Dm
> CONFIG_DVB_ZL10039=3Dm
>=20
> #
> # DVB-T (terrestrial) frontends
> #
> CONFIG_DVB_AF9013=3Dm
> CONFIG_DVB_AS102_FE=3Dm
> CONFIG_DVB_CX22700=3Dm
> CONFIG_DVB_CX22702=3Dm
> CONFIG_DVB_CXD2820R=3Dm
> CONFIG_DVB_CXD2841ER=3Dm
> CONFIG_DVB_DIB3000MB=3Dm
> CONFIG_DVB_DIB3000MC=3Dm
> CONFIG_DVB_DIB7000M=3Dm
> CONFIG_DVB_DIB7000P=3Dm
> # CONFIG_DVB_DIB9000 is not set
> CONFIG_DVB_DRXD=3Dm
> CONFIG_DVB_EC100=3Dm
> CONFIG_DVB_GP8PSK_FE=3Dm
> CONFIG_DVB_L64781=3Dm
> CONFIG_DVB_MT352=3Dm
> CONFIG_DVB_NXT6000=3Dm
> CONFIG_DVB_RTL2830=3Dm
> CONFIG_DVB_RTL2832=3Dm
> CONFIG_DVB_RTL2832_SDR=3Dm
> # CONFIG_DVB_S5H1432 is not set
> CONFIG_DVB_SI2168=3Dm
> CONFIG_DVB_SP887X=3Dm
> CONFIG_DVB_STV0367=3Dm
> CONFIG_DVB_TDA10048=3Dm
> CONFIG_DVB_TDA1004X=3Dm
> CONFIG_DVB_ZD1301_DEMOD=3Dm
> CONFIG_DVB_ZL10353=3Dm
> # CONFIG_DVB_CXD2880 is not set
>=20
> #
> # DVB-C (cable) frontends
> #
> CONFIG_DVB_STV0297=3Dm
> CONFIG_DVB_TDA10021=3Dm
> CONFIG_DVB_TDA10023=3Dm
> CONFIG_DVB_VES1820=3Dm
>=20
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> CONFIG_DVB_AU8522=3Dm
> CONFIG_DVB_AU8522_DTV=3Dm
> CONFIG_DVB_AU8522_V4L=3Dm
> CONFIG_DVB_BCM3510=3Dm
> CONFIG_DVB_LG2160=3Dm
> CONFIG_DVB_LGDT3305=3Dm
> CONFIG_DVB_LGDT3306A=3Dm
> CONFIG_DVB_LGDT330X=3Dm
> CONFIG_DVB_MXL692=3Dm
> CONFIG_DVB_NXT200X=3Dm
> CONFIG_DVB_OR51132=3Dm
> CONFIG_DVB_OR51211=3Dm
> CONFIG_DVB_S5H1409=3Dm
> CONFIG_DVB_S5H1411=3Dm
>=20
> #
> # ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_DIB8000=3Dm
> CONFIG_DVB_MB86A20S=3Dm
> CONFIG_DVB_S921=3Dm
>=20
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> # CONFIG_DVB_MN88443X is not set
> CONFIG_DVB_TC90522=3Dm
>=20
> #
> # Digital terrestrial only tuners/PLL
> #
> CONFIG_DVB_PLL=3Dm
> CONFIG_DVB_TUNER_DIB0070=3Dm
> CONFIG_DVB_TUNER_DIB0090=3Dm
>=20
> #
> # SEC control devices for DVB-S
> #
> CONFIG_DVB_A8293=3Dm
> CONFIG_DVB_AF9033=3Dm
> CONFIG_DVB_ASCOT2E=3Dm
> CONFIG_DVB_ATBM8830=3Dm
> CONFIG_DVB_HELENE=3Dm
> CONFIG_DVB_HORUS3A=3Dm
> CONFIG_DVB_ISL6405=3Dm
> CONFIG_DVB_ISL6421=3Dm
> CONFIG_DVB_ISL6423=3Dm
> CONFIG_DVB_IX2505V=3Dm
> # CONFIG_DVB_LGS8GL5 is not set
> CONFIG_DVB_LGS8GXX=3Dm
> CONFIG_DVB_LNBH25=3Dm
> # CONFIG_DVB_LNBH29 is not set
> CONFIG_DVB_LNBP21=3Dm
> CONFIG_DVB_LNBP22=3Dm
> CONFIG_DVB_M88RS2000=3Dm
> CONFIG_DVB_TDA665x=3Dm
> CONFIG_DVB_DRX39XYJ=3Dm
>=20
> #
> # Common Interface (EN50221) controller drivers
> #
> CONFIG_DVB_CXD2099=3Dm
> CONFIG_DVB_SP2=3Dm
> # end of Customise DVB Frontends
>=20
> #
> # Tools to develop new frontends
> #
> CONFIG_DVB_DUMMY_FE=3Dm
> # end of Media ancillary drivers
>=20
> #
> # Graphics support
> #
> CONFIG_AGP=3Dy
> CONFIG_AGP_AMD64=3Dy
> CONFIG_AGP_INTEL=3Dy
> CONFIG_AGP_SIS=3Dm
> CONFIG_AGP_VIA=3Dy
> CONFIG_INTEL_GTT=3Dy
> # CONFIG_VGA_SWITCHEROO is not set
> CONFIG_DRM=3Dy
> CONFIG_DRM_MIPI_DBI=3Dm
> CONFIG_DRM_MIPI_DSI=3Dy
> CONFIG_DRM_DP_AUX_CHARDEV=3Dy
> # CONFIG_DRM_DEBUG_MM is not set
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_DP_HELPER=3Dy
> CONFIG_DRM_KMS_HELPER=3Dy
> # CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
> # CONFIG_DRM_DEBUG_MODESET_LOCK is not set
> CONFIG_DRM_FBDEV_EMULATION=3Dy
> CONFIG_DRM_FBDEV_OVERALLOC=3D100
> # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
> CONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy
> # CONFIG_DRM_DP_CEC is not set
> CONFIG_DRM_TTM=3Dy
> CONFIG_DRM_BUDDY=3Dy
> CONFIG_DRM_VRAM_HELPER=3Dm
> CONFIG_DRM_TTM_HELPER=3Dm
> CONFIG_DRM_GEM_CMA_HELPER=3Dm
> CONFIG_DRM_GEM_SHMEM_HELPER=3Dy
> CONFIG_DRM_SCHED=3Dm
>=20
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=3Dm
> CONFIG_DRM_I2C_SIL164=3Dm
> CONFIG_DRM_I2C_NXP_TDA998X=3Dm
> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> # end of I2C encoder or helper chips
>=20
> #
> # ARM devices
> #
> # CONFIG_DRM_KOMEDA is not set
> # end of ARM devices
>=20
> CONFIG_DRM_RADEON=3Dm
> # CONFIG_DRM_RADEON_USERPTR is not set
> CONFIG_DRM_AMDGPU=3Dm
> CONFIG_DRM_AMDGPU_SI=3Dy
> CONFIG_DRM_AMDGPU_CIK=3Dy
> CONFIG_DRM_AMDGPU_USERPTR=3Dy
>=20
> #
> # ACP (Audio CoProcessor) Configuration
> #
> CONFIG_DRM_AMD_ACP=3Dy
> # end of ACP (Audio CoProcessor) Configuration
>=20
> #
> # Display Engine Configuration
> #
> CONFIG_DRM_AMD_DC=3Dy
> # CONFIG_DRM_AMD_DC_HDCP is not set
> # CONFIG_DRM_AMD_DC_SI is not set
> # CONFIG_DEBUG_KERNEL_DC is not set
> # end of Display Engine Configuration
>=20
> # CONFIG_HSA_AMD is not set
> CONFIG_DRM_NOUVEAU=3Dm
> CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=3Dy
> CONFIG_NOUVEAU_DEBUG=3D5
> CONFIG_NOUVEAU_DEBUG_DEFAULT=3D3
> # CONFIG_NOUVEAU_DEBUG_MMU is not set
> # CONFIG_NOUVEAU_DEBUG_PUSH is not set
> CONFIG_DRM_NOUVEAU_BACKLIGHT=3Dy
> # CONFIG_DRM_NOUVEAU_SVM is not set
> CONFIG_DRM_I915=3Dy
> CONFIG_DRM_I915_FORCE_PROBE=3D"*"
> CONFIG_DRM_I915_CAPTURE_ERROR=3Dy
> CONFIG_DRM_I915_COMPRESS_ERROR=3Dy
> CONFIG_DRM_I915_USERPTR=3Dy
> CONFIG_DRM_I915_GVT=3Dy
> CONFIG_DRM_I915_GVT_KVMGT=3Dm
>=20
> #
> # drm/i915 Debugging
> #
> # CONFIG_DRM_I915_WERROR is not set
> # CONFIG_DRM_I915_DEBUG is not set
> # CONFIG_DRM_I915_DEBUG_MMIO is not set
> # CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
> # CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
> # CONFIG_DRM_I915_DEBUG_GUC is not set
> # CONFIG_DRM_I915_SELFTEST is not set
> # CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
> # CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
> # CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
> # end of drm/i915 Debugging
>=20
> #
> # drm/i915 Profile Guided Optimisation
> #
> CONFIG_DRM_I915_REQUEST_TIMEOUT=3D20000
> CONFIG_DRM_I915_FENCE_TIMEOUT=3D10000
> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=3D250
> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=3D2500
> CONFIG_DRM_I915_PREEMPT_TIMEOUT=3D100
> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=3D8000
> CONFIG_DRM_I915_STOP_TIMEOUT=3D100
> CONFIG_DRM_I915_TIMESLICE_DURATION=3D1
> # end of drm/i915 Profile Guided Optimisation
>=20
> CONFIG_DRM_VGEM=3Dm
> # CONFIG_DRM_VKMS is not set
> CONFIG_DRM_VMWGFX=3Dm
> CONFIG_DRM_VMWGFX_FBCON=3Dy
> # CONFIG_DRM_VMWGFX_MKSSTATS is not set
> CONFIG_DRM_GMA500=3Dm
> CONFIG_DRM_UDL=3Dm
> CONFIG_DRM_AST=3Dm
> CONFIG_DRM_MGAG200=3Dm
> # CONFIG_DRM_RCAR_DW_HDMI is not set
> # CONFIG_DRM_RCAR_USE_LVDS is not set
> # CONFIG_DRM_RCAR_MIPI_DSI is not set
> CONFIG_DRM_QXL=3Dm
> CONFIG_DRM_VIRTIO_GPU=3Dy
> CONFIG_DRM_PANEL=3Dy
>=20
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_ABT_Y030XX067A is not set
> # CONFIG_DRM_PANEL_ARM_VERSATILE is not set
> # CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
> # CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
> # CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
> # CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
> # CONFIG_DRM_PANEL_DSI_CM is not set
> # CONFIG_DRM_PANEL_LVDS is not set
> # CONFIG_DRM_PANEL_SIMPLE is not set
> # CONFIG_DRM_PANEL_EDP is not set
> # CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
> # CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
> # CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
> # CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
> # CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
> # CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
> # CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set
> # CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
> # CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
> # CONFIG_DRM_PANEL_JDI_R63452 is not set
> # CONFIG_DRM_PANEL_KHADAS_TS050 is not set
> # CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
> # CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
> # CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
> # CONFIG_DRM_PANEL_LG_LB035Q02 is not set
> # CONFIG_DRM_PANEL_LG_LG4573 is not set
> # CONFIG_DRM_PANEL_NEC_NL8048HL11 is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT35560 is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
> # CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
> # CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
> # CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
> # CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
> # CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
> CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=3Dm
> # CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
> # CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
> # CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_DB7430 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6D27A1 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_SOFEF00 is not set
> # CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
> # CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
> # CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
> # CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
> # CONFIG_DRM_PANEL_SHARP_LS060T1SX01 is not set
> # CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
> # CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
> # CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
> # CONFIG_DRM_PANEL_SONY_ACX565AKM is not set
> # CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
> # CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
> # CONFIG_DRM_PANEL_TPO_TD028TTEC1 is not set
> # CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
> # CONFIG_DRM_PANEL_TPO_TPG110 is not set
> # CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
> # CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
> # CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
> # CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
> # end of Display Panels
>=20
> CONFIG_DRM_BRIDGE=3Dy
> CONFIG_DRM_PANEL_BRIDGE=3Dy
>=20
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_CDNS_DSI is not set
> # CONFIG_DRM_CHIPONE_ICN6211 is not set
> # CONFIG_DRM_CHRONTEL_CH7033 is not set
> # CONFIG_DRM_CROS_EC_ANX7688 is not set
> # CONFIG_DRM_DISPLAY_CONNECTOR is not set
> # CONFIG_DRM_ITE_IT6505 is not set
> # CONFIG_DRM_LONTIUM_LT8912B is not set
> # CONFIG_DRM_LONTIUM_LT9611 is not set
> # CONFIG_DRM_LONTIUM_LT9611UXC is not set
> # CONFIG_DRM_ITE_IT66121 is not set
> # CONFIG_DRM_LVDS_CODEC is not set
> # CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
> # CONFIG_DRM_NWL_MIPI_DSI is not set
> # CONFIG_DRM_NXP_PTN3460 is not set
> # CONFIG_DRM_PARADE_PS8622 is not set
> # CONFIG_DRM_PARADE_PS8640 is not set
> # CONFIG_DRM_SIL_SII8620 is not set
> # CONFIG_DRM_SII902X is not set
> # CONFIG_DRM_SII9234 is not set
> # CONFIG_DRM_SIMPLE_BRIDGE is not set
> # CONFIG_DRM_THINE_THC63LVD1024 is not set
> # CONFIG_DRM_TOSHIBA_TC358762 is not set
> # CONFIG_DRM_TOSHIBA_TC358764 is not set
> # CONFIG_DRM_TOSHIBA_TC358767 is not set
> # CONFIG_DRM_TOSHIBA_TC358768 is not set
> # CONFIG_DRM_TOSHIBA_TC358775 is not set
> # CONFIG_DRM_TI_TFP410 is not set
> # CONFIG_DRM_TI_SN65DSI83 is not set
> # CONFIG_DRM_TI_SN65DSI86 is not set
> # CONFIG_DRM_TI_TPD12S015 is not set
> # CONFIG_DRM_ANALOGIX_ANX6345 is not set
> CONFIG_DRM_ANALOGIX_ANX78XX=3Dm
> CONFIG_DRM_ANALOGIX_DP=3Dm
> # CONFIG_DRM_ANALOGIX_ANX7625 is not set
> # CONFIG_DRM_I2C_ADV7511 is not set
> # CONFIG_DRM_CDNS_MHDP8546 is not set
> # end of Display Interface Bridges
>=20
> # CONFIG_DRM_ETNAVIV is not set
> # CONFIG_DRM_MXSFB is not set
> # CONFIG_DRM_ARCPGU is not set
> CONFIG_DRM_BOCHS=3Dm
> CONFIG_DRM_CIRRUS_QEMU=3Dm
> # CONFIG_DRM_GM12U320 is not set
> # CONFIG_DRM_PANEL_MIPI_DBI is not set
> # CONFIG_DRM_SIMPLEDRM is not set
> # CONFIG_TINYDRM_HX8357D is not set
> # CONFIG_TINYDRM_ILI9163 is not set
> CONFIG_TINYDRM_ILI9225=3Dm
> # CONFIG_TINYDRM_ILI9341 is not set
> # CONFIG_TINYDRM_ILI9486 is not set
> CONFIG_TINYDRM_MI0283QT=3Dm
> CONFIG_TINYDRM_REPAPER=3Dm
> CONFIG_TINYDRM_ST7586=3Dm
> CONFIG_TINYDRM_ST7735R=3Dm
> # CONFIG_DRM_XEN_FRONTEND is not set
> CONFIG_DRM_VBOXVIDEO=3Dm
> # CONFIG_DRM_GUD is not set
> # CONFIG_DRM_SSD130X is not set
> # CONFIG_DRM_HYPERV is not set
> CONFIG_DRM_LEGACY=3Dy
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_R128 is not set
> # CONFIG_DRM_MGA is not set
> # CONFIG_DRM_SIS is not set
> # CONFIG_DRM_VIA is not set
> # CONFIG_DRM_SAVAGE is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dy
> CONFIG_DRM_NOMODESET=3Dy
> CONFIG_DRM_PRIVACY_SCREEN=3Dy
>=20
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=3Dy
> CONFIG_FB_NOTIFY=3Dy
> CONFIG_FB=3Dy
> CONFIG_FIRMWARE_EDID=3Dy
> CONFIG_FB_DDC=3Dm
> CONFIG_FB_BOOT_VESA_SUPPORT=3Dy
> CONFIG_FB_CFB_FILLRECT=3Dy
> CONFIG_FB_CFB_COPYAREA=3Dy
> CONFIG_FB_CFB_IMAGEBLIT=3Dy
> CONFIG_FB_SYS_FILLRECT=3Dy
> CONFIG_FB_SYS_COPYAREA=3Dy
> CONFIG_FB_SYS_IMAGEBLIT=3Dy
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=3Dy
> CONFIG_FB_DEFERRED_IO=3Dy
> CONFIG_FB_HECUBA=3Dm
> CONFIG_FB_SVGALIB=3Dm
> CONFIG_FB_BACKLIGHT=3Dm
> CONFIG_FB_MODE_HELPERS=3Dy
> CONFIG_FB_TILEBLITTING=3Dy
>=20
> #
> # Frame buffer hardware drivers
> #
> CONFIG_FB_CIRRUS=3Dm
> CONFIG_FB_PM2=3Dm
> CONFIG_FB_PM2_FIFO_DISCONNECT=3Dy
> CONFIG_FB_CYBER2000=3Dm
> CONFIG_FB_CYBER2000_DDC=3Dy
> CONFIG_FB_ARC=3Dm
> CONFIG_FB_ASILIANT=3Dy
> CONFIG_FB_IMSTT=3Dy
> CONFIG_FB_VGA16=3Dm
> CONFIG_FB_UVESA=3Dm
> CONFIG_FB_VESA=3Dy
> CONFIG_FB_EFI=3Dy
> CONFIG_FB_N411=3Dm
> CONFIG_FB_HGA=3Dm
> CONFIG_FB_OPENCORES=3Dm
> CONFIG_FB_S1D13XXX=3Dm
> CONFIG_FB_NVIDIA=3Dm
> CONFIG_FB_NVIDIA_I2C=3Dy
> # CONFIG_FB_NVIDIA_DEBUG is not set
> CONFIG_FB_NVIDIA_BACKLIGHT=3Dy
> CONFIG_FB_RIVA=3Dm
> CONFIG_FB_RIVA_I2C=3Dy
> # CONFIG_FB_RIVA_DEBUG is not set
> CONFIG_FB_RIVA_BACKLIGHT=3Dy
> CONFIG_FB_I740=3Dm
> CONFIG_FB_LE80578=3Dm
> CONFIG_FB_CARILLO_RANCH=3Dm
> CONFIG_FB_MATROX=3Dm
> CONFIG_FB_MATROX_MILLENIUM=3Dy
> CONFIG_FB_MATROX_MYSTIQUE=3Dy
> CONFIG_FB_MATROX_G=3Dy
> CONFIG_FB_MATROX_I2C=3Dm
> CONFIG_FB_MATROX_MAVEN=3Dm
> CONFIG_FB_RADEON=3Dm
> CONFIG_FB_RADEON_I2C=3Dy
> CONFIG_FB_RADEON_BACKLIGHT=3Dy
> # CONFIG_FB_RADEON_DEBUG is not set
> CONFIG_FB_ATY128=3Dm
> CONFIG_FB_ATY128_BACKLIGHT=3Dy
> CONFIG_FB_ATY=3Dm
> CONFIG_FB_ATY_CT=3Dy
> # CONFIG_FB_ATY_GENERIC_LCD is not set
> CONFIG_FB_ATY_GX=3Dy
> CONFIG_FB_ATY_BACKLIGHT=3Dy
> CONFIG_FB_S3=3Dm
> CONFIG_FB_S3_DDC=3Dy
> CONFIG_FB_SAVAGE=3Dm
> CONFIG_FB_SAVAGE_I2C=3Dy
> # CONFIG_FB_SAVAGE_ACCEL is not set
> CONFIG_FB_SIS=3Dm
> CONFIG_FB_SIS_300=3Dy
> CONFIG_FB_SIS_315=3Dy
> CONFIG_FB_VIA=3Dm
> # CONFIG_FB_VIA_DIRECT_PROCFS is not set
> CONFIG_FB_VIA_X_COMPATIBILITY=3Dy
> CONFIG_FB_NEOMAGIC=3Dm
> CONFIG_FB_KYRO=3Dm
> CONFIG_FB_3DFX=3Dm
> # CONFIG_FB_3DFX_ACCEL is not set
> # CONFIG_FB_3DFX_I2C is not set
> CONFIG_FB_VOODOO1=3Dm
> CONFIG_FB_VT8623=3Dm
> CONFIG_FB_TRIDENT=3Dm
> CONFIG_FB_ARK=3Dm
> CONFIG_FB_PM3=3Dm
> CONFIG_FB_CARMINE=3Dm
> CONFIG_FB_CARMINE_DRAM_EVAL=3Dy
> # CONFIG_CARMINE_DRAM_CUSTOM is not set
> CONFIG_FB_SM501=3Dm
> CONFIG_FB_SMSCUFX=3Dm
> CONFIG_FB_UDL=3Dm
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_VIRTUAL is not set
> CONFIG_XEN_FBDEV_FRONTEND=3Dm
> CONFIG_FB_METRONOME=3Dm
> CONFIG_FB_MB862XX=3Dm
> CONFIG_FB_MB862XX_PCI_GDC=3Dy
> CONFIG_FB_MB862XX_I2C=3Dy
> CONFIG_FB_HYPERV=3Dm
> CONFIG_FB_SIMPLE=3Dy
> # CONFIG_FB_SSD1307 is not set
> CONFIG_FB_SM712=3Dm
> # end of Frame buffer Devices
>=20
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=3Dm
> CONFIG_LCD_L4F00242T03=3Dm
> CONFIG_LCD_LMS283GF05=3Dm
> CONFIG_LCD_LTV350QV=3Dm
> CONFIG_LCD_ILI922X=3Dm
> CONFIG_LCD_ILI9320=3Dm
> CONFIG_LCD_TDO24M=3Dm
> CONFIG_LCD_VGG2432A4=3Dm
> CONFIG_LCD_PLATFORM=3Dm
> CONFIG_LCD_AMS369FG06=3Dm
> CONFIG_LCD_LMS501KF03=3Dm
> CONFIG_LCD_HX8357=3Dm
> # CONFIG_LCD_OTM3225A is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> # CONFIG_BACKLIGHT_KTD253 is not set
> CONFIG_BACKLIGHT_LM3533=3Dm
> CONFIG_BACKLIGHT_CARILLO_RANCH=3Dm
> CONFIG_BACKLIGHT_PWM=3Dm
> CONFIG_BACKLIGHT_DA903X=3Dm
> CONFIG_BACKLIGHT_DA9052=3Dm
> CONFIG_BACKLIGHT_MAX8925=3Dm
> CONFIG_BACKLIGHT_APPLE=3Dm
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> CONFIG_BACKLIGHT_SAHARA=3Dm
> CONFIG_BACKLIGHT_WM831X=3Dm
> CONFIG_BACKLIGHT_ADP5520=3Dm
> CONFIG_BACKLIGHT_ADP8860=3Dm
> CONFIG_BACKLIGHT_ADP8870=3Dm
> CONFIG_BACKLIGHT_88PM860X=3Dm
> CONFIG_BACKLIGHT_PCF50633=3Dm
> CONFIG_BACKLIGHT_AAT2870=3Dm
> CONFIG_BACKLIGHT_LM3630A=3Dm
> CONFIG_BACKLIGHT_LM3639=3Dm
> CONFIG_BACKLIGHT_LP855X=3Dm
> CONFIG_BACKLIGHT_LP8788=3Dm
> CONFIG_BACKLIGHT_PANDORA=3Dm
> CONFIG_BACKLIGHT_SKY81452=3Dm
> CONFIG_BACKLIGHT_AS3711=3Dm
> CONFIG_BACKLIGHT_GPIO=3Dm
> CONFIG_BACKLIGHT_LV5207LP=3Dm
> CONFIG_BACKLIGHT_BD6107=3Dm
> CONFIG_BACKLIGHT_ARCXCNN=3Dm
> # CONFIG_BACKLIGHT_RAVE_SP is not set
> # CONFIG_BACKLIGHT_LED is not set
> # end of Backlight & LCD device support
>=20
> CONFIG_VGASTATE=3Dm
> CONFIG_HDMI=3Dy
>=20
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
> CONFIG_DUMMY_CONSOLE_ROWS=3D25
> CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> # end of Console display driver support
>=20
> CONFIG_LOGO=3Dy
> CONFIG_LOGO_LINUX_MONO=3Dy
> CONFIG_LOGO_LINUX_VGA16=3Dy
> CONFIG_LOGO_LINUX_CLUT224=3Dy
> CONFIG_LOGO_LINUX_NEXT_CLUT224=3Dy
> # end of Graphics support
>=20
> CONFIG_SOUND=3Dm
> CONFIG_SOUND_OSS_CORE=3Dy
> # CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
> CONFIG_SND=3Dm
> CONFIG_SND_TIMER=3Dm
> CONFIG_SND_PCM=3Dm
> CONFIG_SND_PCM_ELD=3Dy
> CONFIG_SND_PCM_IEC958=3Dy
> CONFIG_SND_DMAENGINE_PCM=3Dm
> CONFIG_SND_HWDEP=3Dm
> CONFIG_SND_SEQ_DEVICE=3Dm
> CONFIG_SND_RAWMIDI=3Dm
> CONFIG_SND_COMPRESS_OFFLOAD=3Dm
> CONFIG_SND_JACK=3Dy
> CONFIG_SND_JACK_INPUT_DEV=3Dy
> CONFIG_SND_OSSEMUL=3Dy
> CONFIG_SND_MIXER_OSS=3Dm
> # CONFIG_SND_PCM_OSS is not set
> CONFIG_SND_PCM_TIMER=3Dy
> CONFIG_SND_HRTIMER=3Dm
> CONFIG_SND_DYNAMIC_MINORS=3Dy
> CONFIG_SND_MAX_CARDS=3D32
> CONFIG_SND_SUPPORT_OLD_API=3Dy
> CONFIG_SND_PROC_FS=3Dy
> CONFIG_SND_VERBOSE_PROCFS=3Dy
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
> CONFIG_SND_VMASTER=3Dy
> CONFIG_SND_DMA_SGBUF=3Dy
> CONFIG_SND_CTL_LED=3Dm
> CONFIG_SND_SEQUENCER=3Dm
> CONFIG_SND_SEQ_DUMMY=3Dm
> # CONFIG_SND_SEQUENCER_OSS is not set
> CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
> CONFIG_SND_SEQ_MIDI_EVENT=3Dm
> CONFIG_SND_SEQ_MIDI=3Dm
> CONFIG_SND_SEQ_MIDI_EMUL=3Dm
> CONFIG_SND_SEQ_VIRMIDI=3Dm
> CONFIG_SND_MPU401_UART=3Dm
> CONFIG_SND_OPL3_LIB=3Dm
> CONFIG_SND_OPL3_LIB_SEQ=3Dm
> CONFIG_SND_VX_LIB=3Dm
> CONFIG_SND_AC97_CODEC=3Dm
> CONFIG_SND_DRIVERS=3Dy
> CONFIG_SND_PCSP=3Dm
> CONFIG_SND_DUMMY=3Dm
> CONFIG_SND_ALOOP=3Dm
> CONFIG_SND_VIRMIDI=3Dm
> CONFIG_SND_MTPAV=3Dm
> CONFIG_SND_MTS64=3Dm
> CONFIG_SND_SERIAL_U16550=3Dm
> CONFIG_SND_MPU401=3Dm
> CONFIG_SND_PORTMAN2X4=3Dm
> CONFIG_SND_AC97_POWER_SAVE=3Dy
> CONFIG_SND_AC97_POWER_SAVE_DEFAULT=3D0
> CONFIG_SND_SB_COMMON=3Dm
> CONFIG_SND_PCI=3Dy
> CONFIG_SND_AD1889=3Dm
> CONFIG_SND_ALS300=3Dm
> CONFIG_SND_ALS4000=3Dm
> CONFIG_SND_ALI5451=3Dm
> CONFIG_SND_ASIHPI=3Dm
> CONFIG_SND_ATIIXP=3Dm
> CONFIG_SND_ATIIXP_MODEM=3Dm
> CONFIG_SND_AU8810=3Dm
> CONFIG_SND_AU8820=3Dm
> CONFIG_SND_AU8830=3Dm
> CONFIG_SND_AW2=3Dm
> CONFIG_SND_AZT3328=3Dm
> CONFIG_SND_BT87X=3Dm
> # CONFIG_SND_BT87X_OVERCLOCK is not set
> CONFIG_SND_CA0106=3Dm
> CONFIG_SND_CMIPCI=3Dm
> CONFIG_SND_OXYGEN_LIB=3Dm
> CONFIG_SND_OXYGEN=3Dm
> CONFIG_SND_CS4281=3Dm
> CONFIG_SND_CS46XX=3Dm
> CONFIG_SND_CS46XX_NEW_DSP=3Dy
> CONFIG_SND_CTXFI=3Dm
> CONFIG_SND_DARLA20=3Dm
> CONFIG_SND_GINA20=3Dm
> CONFIG_SND_LAYLA20=3Dm
> CONFIG_SND_DARLA24=3Dm
> CONFIG_SND_GINA24=3Dm
> CONFIG_SND_LAYLA24=3Dm
> CONFIG_SND_MONA=3Dm
> CONFIG_SND_MIA=3Dm
> CONFIG_SND_ECHO3G=3Dm
> CONFIG_SND_INDIGO=3Dm
> CONFIG_SND_INDIGOIO=3Dm
> CONFIG_SND_INDIGODJ=3Dm
> CONFIG_SND_INDIGOIOX=3Dm
> CONFIG_SND_INDIGODJX=3Dm
> CONFIG_SND_EMU10K1=3Dm
> CONFIG_SND_EMU10K1_SEQ=3Dm
> CONFIG_SND_EMU10K1X=3Dm
> CONFIG_SND_ENS1370=3Dm
> CONFIG_SND_ENS1371=3Dm
> CONFIG_SND_ES1938=3Dm
> CONFIG_SND_ES1968=3Dm
> CONFIG_SND_ES1968_INPUT=3Dy
> CONFIG_SND_ES1968_RADIO=3Dy
> CONFIG_SND_FM801=3Dm
> CONFIG_SND_FM801_TEA575X_BOOL=3Dy
> CONFIG_SND_HDSP=3Dm
> CONFIG_SND_HDSPM=3Dm
> CONFIG_SND_ICE1712=3Dm
> CONFIG_SND_ICE1724=3Dm
> CONFIG_SND_INTEL8X0=3Dm
> CONFIG_SND_INTEL8X0M=3Dm
> CONFIG_SND_KORG1212=3Dm
> CONFIG_SND_LOLA=3Dm
> CONFIG_SND_LX6464ES=3Dm
> CONFIG_SND_MAESTRO3=3Dm
> CONFIG_SND_MAESTRO3_INPUT=3Dy
> CONFIG_SND_MIXART=3Dm
> CONFIG_SND_NM256=3Dm
> CONFIG_SND_PCXHR=3Dm
> CONFIG_SND_RIPTIDE=3Dm
> CONFIG_SND_RME32=3Dm
> CONFIG_SND_RME96=3Dm
> CONFIG_SND_RME9652=3Dm
> CONFIG_SND_SONICVIBES=3Dm
> CONFIG_SND_TRIDENT=3Dm
> CONFIG_SND_VIA82XX=3Dm
> CONFIG_SND_VIA82XX_MODEM=3Dm
> CONFIG_SND_VIRTUOSO=3Dm
> CONFIG_SND_VX222=3Dm
> CONFIG_SND_YMFPCI=3Dm
>=20
> #
> # HD-Audio
> #
> CONFIG_SND_HDA=3Dm
> CONFIG_SND_HDA_GENERIC_LEDS=3Dy
> CONFIG_SND_HDA_INTEL=3Dm
> CONFIG_SND_HDA_HWDEP=3Dy
> CONFIG_SND_HDA_RECONFIG=3Dy
> CONFIG_SND_HDA_INPUT_BEEP=3Dy
> CONFIG_SND_HDA_INPUT_BEEP_MODE=3D0
> CONFIG_SND_HDA_PATCH_LOADER=3Dy
> # CONFIG_SND_HDA_SCODEC_CS35L41_I2C is not set
> # CONFIG_SND_HDA_SCODEC_CS35L41_SPI is not set
> CONFIG_SND_HDA_CODEC_REALTEK=3Dm
> CONFIG_SND_HDA_CODEC_ANALOG=3Dm
> CONFIG_SND_HDA_CODEC_SIGMATEL=3Dm
> CONFIG_SND_HDA_CODEC_VIA=3Dm
> CONFIG_SND_HDA_CODEC_HDMI=3Dm
> CONFIG_SND_HDA_CODEC_CIRRUS=3Dm
> # CONFIG_SND_HDA_CODEC_CS8409 is not set
> CONFIG_SND_HDA_CODEC_CONEXANT=3Dm
> CONFIG_SND_HDA_CODEC_CA0110=3Dm
> CONFIG_SND_HDA_CODEC_CA0132=3Dm
> CONFIG_SND_HDA_CODEC_CA0132_DSP=3Dy
> CONFIG_SND_HDA_CODEC_CMEDIA=3Dm
> CONFIG_SND_HDA_CODEC_SI3054=3Dm
> CONFIG_SND_HDA_GENERIC=3Dm
> CONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D0
> # CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
> # end of HD-Audio
>=20
> CONFIG_SND_HDA_CORE=3Dm
> CONFIG_SND_HDA_DSP_LOADER=3Dy
> CONFIG_SND_HDA_COMPONENT=3Dy
> CONFIG_SND_HDA_I915=3Dy
> CONFIG_SND_HDA_EXT_CORE=3Dm
> CONFIG_SND_HDA_PREALLOC_SIZE=3D0
> CONFIG_SND_INTEL_NHLT=3Dy
> CONFIG_SND_INTEL_DSP_CONFIG=3Dm
> CONFIG_SND_INTEL_SOUNDWIRE_ACPI=3Dm
> # CONFIG_SND_INTEL_BYT_PREFER_SOF is not set
> CONFIG_SND_SPI=3Dy
> CONFIG_SND_USB=3Dy
> CONFIG_SND_USB_AUDIO=3Dm
> CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=3Dy
> CONFIG_SND_USB_UA101=3Dm
> CONFIG_SND_USB_USX2Y=3Dm
> CONFIG_SND_USB_CAIAQ=3Dm
> CONFIG_SND_USB_CAIAQ_INPUT=3Dy
> CONFIG_SND_USB_US122L=3Dm
> CONFIG_SND_USB_6FIRE=3Dm
> CONFIG_SND_USB_HIFACE=3Dm
> CONFIG_SND_BCD2000=3Dm
> CONFIG_SND_USB_LINE6=3Dm
> CONFIG_SND_USB_POD=3Dm
> CONFIG_SND_USB_PODHD=3Dm
> CONFIG_SND_USB_TONEPORT=3Dm
> CONFIG_SND_USB_VARIAX=3Dm
> CONFIG_SND_FIREWIRE=3Dy
> CONFIG_SND_FIREWIRE_LIB=3Dm
> CONFIG_SND_DICE=3Dm
> CONFIG_SND_OXFW=3Dm
> CONFIG_SND_ISIGHT=3Dm
> CONFIG_SND_FIREWORKS=3Dm
> CONFIG_SND_BEBOB=3Dm
> CONFIG_SND_FIREWIRE_DIGI00X=3Dm
> CONFIG_SND_FIREWIRE_TASCAM=3Dm
> CONFIG_SND_FIREWIRE_MOTU=3Dm
> CONFIG_SND_FIREFACE=3Dm
> CONFIG_SND_PCMCIA=3Dy
> CONFIG_SND_VXPOCKET=3Dm
> CONFIG_SND_PDAUDIOCF=3Dm
> CONFIG_SND_SOC=3Dm
> CONFIG_SND_SOC_AC97_BUS=3Dy
> CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=3Dy
> CONFIG_SND_SOC_COMPRESS=3Dy
> CONFIG_SND_SOC_TOPOLOGY=3Dy
> CONFIG_SND_SOC_ACPI=3Dm
> # CONFIG_SND_SOC_ADI is not set
> CONFIG_SND_SOC_AMD_ACP=3Dm
> # CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH is not set
> CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=3Dm
> # CONFIG_SND_SOC_AMD_ACP3x is not set
> # CONFIG_SND_SOC_AMD_RENOIR is not set
> # CONFIG_SND_SOC_AMD_ACP5x is not set
> # CONFIG_SND_SOC_AMD_ACP6x is not set
> # CONFIG_SND_AMD_ACP_CONFIG is not set
> # CONFIG_SND_SOC_AMD_ACP_COMMON is not set
> CONFIG_SND_ATMEL_SOC=3Dm
> # CONFIG_SND_SOC_MIKROE_PROTO is not set
> # CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
> CONFIG_SND_DESIGNWARE_I2S=3Dm
> CONFIG_SND_DESIGNWARE_PCM=3Dy
>=20
> #
> # SoC Audio for Freescale CPUs
> #
>=20
> #
> # Common SoC Audio options for Freescale CPUs:
> #
> CONFIG_SND_SOC_FSL_ASRC=3Dm
> CONFIG_SND_SOC_FSL_SAI=3Dm
> # CONFIG_SND_SOC_FSL_MQS is not set
> # CONFIG_SND_SOC_FSL_AUDMIX is not set
> CONFIG_SND_SOC_FSL_SSI=3Dm
> CONFIG_SND_SOC_FSL_SPDIF=3Dm
> CONFIG_SND_SOC_FSL_ESAI=3Dm
> # CONFIG_SND_SOC_FSL_MICFIL is not set
> # CONFIG_SND_SOC_FSL_EASRC is not set
> # CONFIG_SND_SOC_FSL_XCVR is not set
> # CONFIG_SND_SOC_FSL_RPMSG is not set
> CONFIG_SND_SOC_IMX_AUDMUX=3Dm
> # end of SoC Audio for Freescale CPUs
>=20
> CONFIG_SND_I2S_HI6210_I2S=3Dm
> CONFIG_SND_SOC_IMG=3Dy
> CONFIG_SND_SOC_IMG_I2S_IN=3Dm
> CONFIG_SND_SOC_IMG_I2S_OUT=3Dm
> CONFIG_SND_SOC_IMG_PARALLEL_OUT=3Dm
> CONFIG_SND_SOC_IMG_SPDIF_IN=3Dm
> CONFIG_SND_SOC_IMG_SPDIF_OUT=3Dm
> CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=3Dm
> CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=3Dy
> CONFIG_SND_SOC_INTEL_SST=3Dm
> # CONFIG_SND_SOC_INTEL_CATPT is not set
> CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=3Dm
> # CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
> CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=3Dm
> CONFIG_SND_SOC_INTEL_SKYLAKE=3Dm
> CONFIG_SND_SOC_INTEL_SKL=3Dm
> CONFIG_SND_SOC_INTEL_APL=3Dm
> CONFIG_SND_SOC_INTEL_KBL=3Dm
> CONFIG_SND_SOC_INTEL_GLK=3Dm
> CONFIG_SND_SOC_INTEL_CNL=3Dm
> CONFIG_SND_SOC_INTEL_CFL=3Dm
> # CONFIG_SND_SOC_INTEL_CML_H is not set
> # CONFIG_SND_SOC_INTEL_CML_LP is not set
> CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=3Dm
> # CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
> CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=3Dm
> CONFIG_SND_SOC_ACPI_INTEL_MATCH=3Dm
> # CONFIG_SND_SOC_INTEL_AVS is not set
> CONFIG_SND_SOC_INTEL_MACH=3Dy
> CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=3Dy
> CONFIG_SND_SOC_INTEL_HDA_DSP_COMMON=3Dm
> CONFIG_SND_SOC_INTEL_SOF_MAXIM_COMMON=3Dm
> # CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH is not set
> CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BROADWELL_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=3Dm
> # CONFIG_SND_SOC_INTEL_BYTCR_WM5102_MACH is not set
> CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=3Dm
> CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=3Dm
> CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=3Dm
> CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=3Dm
> # CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
> CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=3Dm
> # CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH is not set
> CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=3Dm
> CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=3Dm
> CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=3Dm
> CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=3Dm
> # CONFIG_SND_SOC_INTEL_BXT_RT298_MACH is not set
> # CONFIG_SND_SOC_INTEL_SOF_WM8804_MACH is not set
> # CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH is not set
> # CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH is not set
> # CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
> # CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
> # CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
> # CONFIG_SND_SOC_INTEL_GLK_DA7219_MAX98357A_MACH is not set
> # CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
> CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=3Dm
> # CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH is not set
> # CONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH is not set
> # CONFIG_SND_SOC_INTEL_SOF_PCM512x_MACH is not set
> # CONFIG_SND_SOC_INTEL_SOF_ES8336_MACH is not set
> # CONFIG_SND_SOC_INTEL_SOF_NAU8825_MACH is not set
> # CONFIG_SND_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH is not set
> # CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH is not set
> # CONFIG_SND_SOC_INTEL_SOF_DA7219_MAX98373_MACH is not set
> # CONFIG_SND_SOC_INTEL_SOF_SSP_AMP_MACH is not set
> CONFIG_SND_SOC_INTEL_EHL_RT5660_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH=3Dm
> # CONFIG_SND_SOC_MTK_BTCVSD is not set
> CONFIG_SND_SOC_SOF_TOPLEVEL=3Dy
> CONFIG_SND_SOC_SOF_PCI_DEV=3Dm
> CONFIG_SND_SOC_SOF_PCI=3Dm
> CONFIG_SND_SOC_SOF_ACPI=3Dm
> CONFIG_SND_SOC_SOF_ACPI_DEV=3Dm
> CONFIG_SND_SOC_SOF_OF=3Dm
> CONFIG_SND_SOC_SOF_DEBUG_PROBES=3Dm
> CONFIG_SND_SOC_SOF_CLIENT=3Dm
> CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT=3Dy
> # CONFIG_SND_SOC_SOF_FORCE_PROBE_WORKQUEUE is not set
> # CONFIG_SND_SOC_SOF_NOCODEC_SUPPORT is not set
> # CONFIG_SND_SOC_SOF_STRICT_ABI_CHECKS is not set
> CONFIG_SND_SOC_SOF_DEBUG=3Dy
> # CONFIG_SND_SOC_SOF_DEBUG_XRUN_STOP is not set
> CONFIG_SND_SOC_SOF_DEBUG_VERBOSE_IPC=3Dy
> # CONFIG_SND_SOC_SOF_DEBUG_FORCE_IPC_POSITION is not set
> CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE=3Dy
> CONFIG_SND_SOC_SOF_DEBUG_ENABLE_FIRMWARE_TRACE=3Dy
> # CONFIG_SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST is not set
> # CONFIG_SND_SOC_SOF_DEBUG_IPC_MSG_INJECTOR is not set
> # CONFIG_SND_SOC_SOF_DEBUG_RETAIN_DSP_CONTEXT is not set
> CONFIG_SND_SOC_SOF=3Dm
> CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=3Dy
> # CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
> CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=3Dy
> CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=3Dm
> CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=3Dm
> CONFIG_SND_SOC_SOF_INTEL_COMMON=3Dm
> CONFIG_SND_SOC_SOF_BAYTRAIL=3Dm
> CONFIG_SND_SOC_SOF_BROADWELL=3Dm
> CONFIG_SND_SOC_SOF_MERRIFIELD=3Dm
> CONFIG_SND_SOC_SOF_INTEL_APL=3Dm
> CONFIG_SND_SOC_SOF_APOLLOLAKE=3Dm
> CONFIG_SND_SOC_SOF_GEMINILAKE=3Dm
> CONFIG_SND_SOC_SOF_INTEL_CNL=3Dm
> CONFIG_SND_SOC_SOF_CANNONLAKE=3Dm
> CONFIG_SND_SOC_SOF_COFFEELAKE=3Dm
> CONFIG_SND_SOC_SOF_COMETLAKE=3Dm
> CONFIG_SND_SOC_SOF_INTEL_ICL=3Dm
> CONFIG_SND_SOC_SOF_ICELAKE=3Dm
> CONFIG_SND_SOC_SOF_JASPERLAKE=3Dm
> CONFIG_SND_SOC_SOF_INTEL_TGL=3Dm
> CONFIG_SND_SOC_SOF_TIGERLAKE=3Dm
> CONFIG_SND_SOC_SOF_ELKHARTLAKE=3Dm
> CONFIG_SND_SOC_SOF_ALDERLAKE=3Dm
> CONFIG_SND_SOC_SOF_HDA_COMMON=3Dm
> CONFIG_SND_SOC_SOF_HDA_LINK=3Dy
> CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=3Dy
> CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=3Dm
> CONFIG_SND_SOC_SOF_HDA=3Dm
> CONFIG_SND_SOC_SOF_HDA_PROBES=3Dy
> CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=3Dm
> CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE=3Dm
> CONFIG_SND_SOC_SOF_XTENSA=3Dm
>=20
> #
> # STMicroelectronics STM32 SOC audio support
> #
> # end of STMicroelectronics STM32 SOC audio support
>=20
> # CONFIG_SND_SOC_XILINX_I2S is not set
> # CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
> # CONFIG_SND_SOC_XILINX_SPDIF is not set
> CONFIG_SND_SOC_XTFPGA_I2S=3Dm
> CONFIG_SND_SOC_I2C_AND_SPI=3Dm
>=20
> #
> # CODEC drivers
> #
> CONFIG_SND_SOC_AC97_CODEC=3Dm
> CONFIG_SND_SOC_ADAU_UTILS=3Dm
> # CONFIG_SND_SOC_ADAU1372_I2C is not set
> # CONFIG_SND_SOC_ADAU1372_SPI is not set
> CONFIG_SND_SOC_ADAU1701=3Dm
> CONFIG_SND_SOC_ADAU17X1=3Dm
> CONFIG_SND_SOC_ADAU1761=3Dm
> CONFIG_SND_SOC_ADAU1761_I2C=3Dm
> CONFIG_SND_SOC_ADAU1761_SPI=3Dm
> CONFIG_SND_SOC_ADAU7002=3Dm
> # CONFIG_SND_SOC_ADAU7118_HW is not set
> # CONFIG_SND_SOC_ADAU7118_I2C is not set
> CONFIG_SND_SOC_AK4104=3Dm
> # CONFIG_SND_SOC_AK4118 is not set
> # CONFIG_SND_SOC_AK4375 is not set
> # CONFIG_SND_SOC_AK4458 is not set
> CONFIG_SND_SOC_AK4554=3Dm
> CONFIG_SND_SOC_AK4613=3Dm
> CONFIG_SND_SOC_AK4642=3Dm
> CONFIG_SND_SOC_AK5386=3Dm
> # CONFIG_SND_SOC_AK5558 is not set
> CONFIG_SND_SOC_ALC5623=3Dm
> # CONFIG_SND_SOC_AW8738 is not set
> # CONFIG_SND_SOC_BD28623 is not set
> CONFIG_SND_SOC_BT_SCO=3Dm
> # CONFIG_SND_SOC_CROS_EC_CODEC is not set
> CONFIG_SND_SOC_CS35L32=3Dm
> CONFIG_SND_SOC_CS35L33=3Dm
> CONFIG_SND_SOC_CS35L34=3Dm
> CONFIG_SND_SOC_CS35L35=3Dm
> # CONFIG_SND_SOC_CS35L36 is not set
> # CONFIG_SND_SOC_CS35L41_SPI is not set
> # CONFIG_SND_SOC_CS35L41_I2C is not set
> CONFIG_SND_SOC_CS42L42=3Dm
> CONFIG_SND_SOC_CS42L51=3Dm
> CONFIG_SND_SOC_CS42L51_I2C=3Dm
> CONFIG_SND_SOC_CS42L52=3Dm
> CONFIG_SND_SOC_CS42L56=3Dm
> CONFIG_SND_SOC_CS42L73=3Dm
> # CONFIG_SND_SOC_CS4234 is not set
> CONFIG_SND_SOC_CS4265=3Dm
> CONFIG_SND_SOC_CS4270=3Dm
> CONFIG_SND_SOC_CS4271=3Dm
> CONFIG_SND_SOC_CS4271_I2C=3Dm
> CONFIG_SND_SOC_CS4271_SPI=3Dm
> CONFIG_SND_SOC_CS42XX8=3Dm
> CONFIG_SND_SOC_CS42XX8_I2C=3Dm
> CONFIG_SND_SOC_CS43130=3Dm
> # CONFIG_SND_SOC_CS4341 is not set
> CONFIG_SND_SOC_CS4349=3Dm
> CONFIG_SND_SOC_CS53L30=3Dm
> # CONFIG_SND_SOC_CX2072X is not set
> CONFIG_SND_SOC_DA7213=3Dm
> CONFIG_SND_SOC_DA7219=3Dm
> CONFIG_SND_SOC_DMIC=3Dm
> CONFIG_SND_SOC_HDMI_CODEC=3Dm
> CONFIG_SND_SOC_ES7134=3Dm
> # CONFIG_SND_SOC_ES7241 is not set
> CONFIG_SND_SOC_ES8316=3Dm
> CONFIG_SND_SOC_ES8328=3Dm
> CONFIG_SND_SOC_ES8328_I2C=3Dm
> CONFIG_SND_SOC_ES8328_SPI=3Dm
> CONFIG_SND_SOC_GTM601=3Dm
> CONFIG_SND_SOC_HDAC_HDMI=3Dm
> CONFIG_SND_SOC_HDAC_HDA=3Dm
> # CONFIG_SND_SOC_ICS43432 is not set
> CONFIG_SND_SOC_INNO_RK3036=3Dm
> # CONFIG_SND_SOC_MAX98088 is not set
> CONFIG_SND_SOC_MAX98090=3Dm
> CONFIG_SND_SOC_MAX98357A=3Dm
> CONFIG_SND_SOC_MAX98504=3Dm
> # CONFIG_SND_SOC_MAX9867 is not set
> CONFIG_SND_SOC_MAX98927=3Dm
> # CONFIG_SND_SOC_MAX98520 is not set
> CONFIG_SND_SOC_MAX98373=3Dm
> CONFIG_SND_SOC_MAX98373_I2C=3Dm
> CONFIG_SND_SOC_MAX98373_SDW=3Dm
> CONFIG_SND_SOC_MAX98390=3Dm
> CONFIG_SND_SOC_MAX9860=3Dm
> CONFIG_SND_SOC_MSM8916_WCD_ANALOG=3Dm
> CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=3Dm
> CONFIG_SND_SOC_PCM1681=3Dm
> # CONFIG_SND_SOC_PCM1789_I2C is not set
> CONFIG_SND_SOC_PCM179X=3Dm
> CONFIG_SND_SOC_PCM179X_I2C=3Dm
> CONFIG_SND_SOC_PCM179X_SPI=3Dm
> CONFIG_SND_SOC_PCM186X=3Dm
> CONFIG_SND_SOC_PCM186X_I2C=3Dm
> CONFIG_SND_SOC_PCM186X_SPI=3Dm
> # CONFIG_SND_SOC_PCM3060_I2C is not set
> # CONFIG_SND_SOC_PCM3060_SPI is not set
> CONFIG_SND_SOC_PCM3168A=3Dm
> CONFIG_SND_SOC_PCM3168A_I2C=3Dm
> CONFIG_SND_SOC_PCM3168A_SPI=3Dm
> # CONFIG_SND_SOC_PCM5102A is not set
> CONFIG_SND_SOC_PCM512x=3Dm
> CONFIG_SND_SOC_PCM512x_I2C=3Dm
> CONFIG_SND_SOC_PCM512x_SPI=3Dm
> # CONFIG_SND_SOC_RK3328 is not set
> CONFIG_SND_SOC_RL6231=3Dm
> CONFIG_SND_SOC_RL6347A=3Dm
> CONFIG_SND_SOC_RT286=3Dm
> CONFIG_SND_SOC_RT1308=3Dm
> CONFIG_SND_SOC_RT1308_SDW=3Dm
> CONFIG_SND_SOC_RT1316_SDW=3Dm
> CONFIG_SND_SOC_RT5616=3Dm
> CONFIG_SND_SOC_RT5631=3Dm
> CONFIG_SND_SOC_RT5640=3Dm
> CONFIG_SND_SOC_RT5645=3Dm
> CONFIG_SND_SOC_RT5651=3Dm
> # CONFIG_SND_SOC_RT5659 is not set
> CONFIG_SND_SOC_RT5660=3Dm
> CONFIG_SND_SOC_RT5670=3Dm
> CONFIG_SND_SOC_RT5677=3Dm
> CONFIG_SND_SOC_RT5677_SPI=3Dm
> CONFIG_SND_SOC_RT5682=3Dm
> CONFIG_SND_SOC_RT5682_SDW=3Dm
> CONFIG_SND_SOC_RT700=3Dm
> CONFIG_SND_SOC_RT700_SDW=3Dm
> CONFIG_SND_SOC_RT711=3Dm
> CONFIG_SND_SOC_RT711_SDW=3Dm
> CONFIG_SND_SOC_RT711_SDCA_SDW=3Dm
> CONFIG_SND_SOC_RT715=3Dm
> CONFIG_SND_SOC_RT715_SDW=3Dm
> CONFIG_SND_SOC_RT715_SDCA_SDW=3Dm
> # CONFIG_SND_SOC_RT9120 is not set
> CONFIG_SND_SOC_SDW_MOCKUP=3Dm
> CONFIG_SND_SOC_SGTL5000=3Dm
> CONFIG_SND_SOC_SI476X=3Dm
> CONFIG_SND_SOC_SIGMADSP=3Dm
> CONFIG_SND_SOC_SIGMADSP_I2C=3Dm
> CONFIG_SND_SOC_SIGMADSP_REGMAP=3Dm
> # CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
> # CONFIG_SND_SOC_SIMPLE_MUX is not set
> CONFIG_SND_SOC_SPDIF=3Dm
> # CONFIG_SND_SOC_SSM2305 is not set
> # CONFIG_SND_SOC_SSM2518 is not set
> CONFIG_SND_SOC_SSM2602=3Dm
> CONFIG_SND_SOC_SSM2602_SPI=3Dm
> CONFIG_SND_SOC_SSM2602_I2C=3Dm
> CONFIG_SND_SOC_SSM4567=3Dm
> CONFIG_SND_SOC_STA32X=3Dm
> CONFIG_SND_SOC_STA350=3Dm
> CONFIG_SND_SOC_STI_SAS=3Dm
> CONFIG_SND_SOC_TAS2552=3Dm
> # CONFIG_SND_SOC_TAS2562 is not set
> # CONFIG_SND_SOC_TAS2764 is not set
> # CONFIG_SND_SOC_TAS2770 is not set
> CONFIG_SND_SOC_TAS5086=3Dm
> CONFIG_SND_SOC_TAS571X=3Dm
> CONFIG_SND_SOC_TAS5720=3Dm
> # CONFIG_SND_SOC_TAS5805M is not set
> CONFIG_SND_SOC_TAS6424=3Dm
> # CONFIG_SND_SOC_TDA7419 is not set
> CONFIG_SND_SOC_TFA9879=3Dm
> # CONFIG_SND_SOC_TFA989X is not set
> # CONFIG_SND_SOC_TLV320ADC3XXX is not set
> CONFIG_SND_SOC_TLV320AIC23=3Dm
> CONFIG_SND_SOC_TLV320AIC23_I2C=3Dm
> CONFIG_SND_SOC_TLV320AIC23_SPI=3Dm
> CONFIG_SND_SOC_TLV320AIC31XX=3Dm
> CONFIG_SND_SOC_TLV320AIC32X4=3Dm
> CONFIG_SND_SOC_TLV320AIC32X4_I2C=3Dm
> CONFIG_SND_SOC_TLV320AIC32X4_SPI=3Dm
> # CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
> # CONFIG_SND_SOC_TLV320ADCX140 is not set
> CONFIG_SND_SOC_TS3A227E=3Dm
> CONFIG_SND_SOC_TSCS42XX=3Dm
> # CONFIG_SND_SOC_TSCS454 is not set
> # CONFIG_SND_SOC_UDA1334 is not set
> # CONFIG_SND_SOC_WCD9335 is not set
> # CONFIG_SND_SOC_WCD938X_SDW is not set
> CONFIG_SND_SOC_WM8510=3Dm
> CONFIG_SND_SOC_WM8523=3Dm
> CONFIG_SND_SOC_WM8524=3Dm
> CONFIG_SND_SOC_WM8580=3Dm
> CONFIG_SND_SOC_WM8711=3Dm
> CONFIG_SND_SOC_WM8728=3Dm
> CONFIG_SND_SOC_WM8731=3Dm
> CONFIG_SND_SOC_WM8737=3Dm
> CONFIG_SND_SOC_WM8741=3Dm
> CONFIG_SND_SOC_WM8750=3Dm
> CONFIG_SND_SOC_WM8753=3Dm
> CONFIG_SND_SOC_WM8770=3Dm
> CONFIG_SND_SOC_WM8776=3Dm
> # CONFIG_SND_SOC_WM8782 is not set
> CONFIG_SND_SOC_WM8804=3Dm
> CONFIG_SND_SOC_WM8804_I2C=3Dm
> CONFIG_SND_SOC_WM8804_SPI=3Dm
> CONFIG_SND_SOC_WM8903=3Dm
> # CONFIG_SND_SOC_WM8904 is not set
> CONFIG_SND_SOC_WM8960=3Dm
> CONFIG_SND_SOC_WM8962=3Dm
> CONFIG_SND_SOC_WM8974=3Dm
> CONFIG_SND_SOC_WM8978=3Dm
> CONFIG_SND_SOC_WM8985=3Dm
> # CONFIG_SND_SOC_WSA881X is not set
> # CONFIG_SND_SOC_ZL38060 is not set
> # CONFIG_SND_SOC_MAX9759 is not set
> # CONFIG_SND_SOC_MT6351 is not set
> # CONFIG_SND_SOC_MT6358 is not set
> # CONFIG_SND_SOC_MT6660 is not set
> # CONFIG_SND_SOC_NAU8315 is not set
> CONFIG_SND_SOC_NAU8540=3Dm
> CONFIG_SND_SOC_NAU8810=3Dm
> # CONFIG_SND_SOC_NAU8821 is not set
> # CONFIG_SND_SOC_NAU8822 is not set
> CONFIG_SND_SOC_NAU8824=3Dm
> CONFIG_SND_SOC_NAU8825=3Dm
> CONFIG_SND_SOC_TPA6130A2=3Dm
> # CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
> # CONFIG_SND_SOC_LPASS_VA_MACRO is not set
> # CONFIG_SND_SOC_LPASS_RX_MACRO is not set
> # CONFIG_SND_SOC_LPASS_TX_MACRO is not set
> # end of CODEC drivers
>=20
> CONFIG_SND_SIMPLE_CARD_UTILS=3Dm
> CONFIG_SND_SIMPLE_CARD=3Dm
> # CONFIG_SND_AUDIO_GRAPH_CARD is not set
> # CONFIG_SND_AUDIO_GRAPH_CARD2 is not set
> # CONFIG_SND_TEST_COMPONENT is not set
> CONFIG_SND_X86=3Dy
> CONFIG_HDMI_LPE_AUDIO=3Dm
> CONFIG_SND_SYNTH_EMUX=3Dm
> # CONFIG_SND_XEN_FRONTEND is not set
> # CONFIG_SND_VIRTIO is not set
> CONFIG_AC97_BUS=3Dm
>=20
> #
> # HID support
> #
> CONFIG_HID=3Dm
> CONFIG_HID_BATTERY_STRENGTH=3Dy
> CONFIG_HIDRAW=3Dy
> CONFIG_UHID=3Dm
> CONFIG_HID_GENERIC=3Dm
>=20
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=3Dm
> CONFIG_HID_ACCUTOUCH=3Dm
> CONFIG_HID_ACRUX=3Dm
> CONFIG_HID_ACRUX_FF=3Dy
> CONFIG_HID_APPLE=3Dm
> CONFIG_HID_APPLEIR=3Dm
> CONFIG_HID_ASUS=3Dm
> CONFIG_HID_AUREAL=3Dm
> CONFIG_HID_BELKIN=3Dm
> CONFIG_HID_BETOP_FF=3Dm
> # CONFIG_HID_BIGBEN_FF is not set
> CONFIG_HID_CHERRY=3Dm
> CONFIG_HID_CHICONY=3Dm
> CONFIG_HID_CORSAIR=3Dm
> # CONFIG_HID_COUGAR is not set
> # CONFIG_HID_MACALLY is not set
> CONFIG_HID_PRODIKEYS=3Dm
> CONFIG_HID_CMEDIA=3Dm
> CONFIG_HID_CP2112=3Dm
> # CONFIG_HID_CREATIVE_SB0540 is not set
> CONFIG_HID_CYPRESS=3Dm
> CONFIG_HID_DRAGONRISE=3Dm
> CONFIG_DRAGONRISE_FF=3Dy
> CONFIG_HID_EMS_FF=3Dm
> # CONFIG_HID_ELAN is not set
> CONFIG_HID_ELECOM=3Dm
> CONFIG_HID_ELO=3Dm
> CONFIG_HID_EZKEY=3Dm
> # CONFIG_HID_FT260 is not set
> CONFIG_HID_GEMBIRD=3Dm
> CONFIG_HID_GFRM=3Dm
> # CONFIG_HID_GLORIOUS is not set
> CONFIG_HID_HOLTEK=3Dm
> CONFIG_HOLTEK_FF=3Dy
> # CONFIG_HID_GOOGLE_HAMMER is not set
> # CONFIG_HID_VIVALDI is not set
> CONFIG_HID_GT683R=3Dm
> CONFIG_HID_KEYTOUCH=3Dm
> CONFIG_HID_KYE=3Dm
> CONFIG_HID_UCLOGIC=3Dm
> CONFIG_HID_WALTOP=3Dm
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_XIAOMI is not set
> CONFIG_HID_GYRATION=3Dm
> CONFIG_HID_ICADE=3Dm
> CONFIG_HID_ITE=3Dm
> CONFIG_HID_JABRA=3Dm
> CONFIG_HID_TWINHAN=3Dm
> CONFIG_HID_KENSINGTON=3Dm
> CONFIG_HID_LCPOWER=3Dm
> CONFIG_HID_LED=3Dm
> CONFIG_HID_LENOVO=3Dm
> # CONFIG_HID_LETSKETCH is not set
> CONFIG_HID_LOGITECH=3Dm
> CONFIG_HID_LOGITECH_DJ=3Dm
> CONFIG_HID_LOGITECH_HIDPP=3Dm
> CONFIG_LOGITECH_FF=3Dy
> CONFIG_LOGIRUMBLEPAD2_FF=3Dy
> CONFIG_LOGIG940_FF=3Dy
> CONFIG_LOGIWHEELS_FF=3Dy
> CONFIG_HID_MAGICMOUSE=3Dm
> # CONFIG_HID_MALTRON is not set
> CONFIG_HID_MAYFLASH=3Dm
> # CONFIG_HID_REDRAGON is not set
> CONFIG_HID_MICROSOFT=3Dm
> CONFIG_HID_MONTEREY=3Dm
> CONFIG_HID_MULTITOUCH=3Dm
> # CONFIG_HID_NINTENDO is not set
> CONFIG_HID_NTI=3Dm
> CONFIG_HID_NTRIG=3Dm
> CONFIG_HID_ORTEK=3Dm
> CONFIG_HID_PANTHERLORD=3Dm
> CONFIG_PANTHERLORD_FF=3Dy
> CONFIG_HID_PENMOUNT=3Dm
> CONFIG_HID_PETALYNX=3Dm
> CONFIG_HID_PICOLCD=3Dm
> CONFIG_HID_PICOLCD_FB=3Dy
> CONFIG_HID_PICOLCD_BACKLIGHT=3Dy
> CONFIG_HID_PICOLCD_LCD=3Dy
> CONFIG_HID_PICOLCD_LEDS=3Dy
> CONFIG_HID_PICOLCD_CIR=3Dy
> CONFIG_HID_PLANTRONICS=3Dm
> # CONFIG_HID_RAZER is not set
> CONFIG_HID_PRIMAX=3Dm
> CONFIG_HID_RETRODE=3Dm
> CONFIG_HID_ROCCAT=3Dm
> CONFIG_HID_SAITEK=3Dm
> CONFIG_HID_SAMSUNG=3Dm
> # CONFIG_HID_SEMITEK is not set
> # CONFIG_HID_SIGMAMICRO is not set
> CONFIG_HID_SONY=3Dm
> CONFIG_SONY_FF=3Dy
> CONFIG_HID_SPEEDLINK=3Dm
> # CONFIG_HID_STEAM is not set
> CONFIG_HID_STEELSERIES=3Dm
> CONFIG_HID_SUNPLUS=3Dm
> CONFIG_HID_RMI=3Dm
> CONFIG_HID_GREENASIA=3Dm
> CONFIG_GREENASIA_FF=3Dy
> CONFIG_HID_HYPERV_MOUSE=3Dm
> CONFIG_HID_SMARTJOYPLUS=3Dm
> CONFIG_SMARTJOYPLUS_FF=3Dy
> CONFIG_HID_TIVO=3Dm
> CONFIG_HID_TOPSEED=3Dm
> CONFIG_HID_THINGM=3Dm
> CONFIG_HID_THRUSTMASTER=3Dm
> CONFIG_THRUSTMASTER_FF=3Dy
> CONFIG_HID_UDRAW_PS3=3Dm
> # CONFIG_HID_U2FZERO is not set
> CONFIG_HID_WACOM=3Dm
> CONFIG_HID_WIIMOTE=3Dm
> CONFIG_HID_XINMO=3Dm
> CONFIG_HID_ZEROPLUS=3Dm
> CONFIG_ZEROPLUS_FF=3Dy
> CONFIG_HID_ZYDACRON=3Dm
> CONFIG_HID_SENSOR_HUB=3Dm
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=3Dm
> CONFIG_HID_ALPS=3Dm
> # CONFIG_HID_MCP2221 is not set
> # end of Special HID drivers
>=20
> #
> # USB HID support
> #
> CONFIG_USB_HID=3Dm
> CONFIG_HID_PID=3Dy
> CONFIG_USB_HIDDEV=3Dy
>=20
> #
> # USB HID Boot Protocol drivers
> #
> CONFIG_USB_KBD=3Dm
> CONFIG_USB_MOUSE=3Dm
> # end of USB HID Boot Protocol drivers
> # end of USB HID support
>=20
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID_ACPI is not set
> # CONFIG_I2C_HID_OF is not set
> # CONFIG_I2C_HID_OF_GOODIX is not set
> # end of I2C HID support
>=20
> #
> # Intel ISH HID support
> #
> CONFIG_INTEL_ISH_HID=3Dm
> # CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
> # end of Intel ISH HID support
>=20
> #
> # AMD SFH HID Support
> #
> # CONFIG_AMD_SFH_HID is not set
> # end of AMD SFH HID Support
> # end of HID support
>=20
> CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> CONFIG_USB_SUPPORT=3Dy
> CONFIG_USB_COMMON=3Dy
> CONFIG_USB_LED_TRIG=3Dy
> CONFIG_USB_ULPI_BUS=3Dm
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=3Dy
> CONFIG_USB=3Dy
> CONFIG_USB_PCI=3Dy
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
>=20
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=3Dy
> # CONFIG_USB_FEW_INIT_RETRIES is not set
> CONFIG_USB_DYNAMIC_MINORS=3Dy
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_PRODUCTLIST is not set
> # CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
> CONFIG_USB_LEDS_TRIGGER_USBPORT=3Dm
> CONFIG_USB_AUTOSUSPEND_DELAY=3D2
> CONFIG_USB_MON=3Dm
>=20
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_C67X00_HCD=3Dm
> CONFIG_USB_XHCI_HCD=3Dy
> CONFIG_USB_XHCI_DBGCAP=3Dy
> CONFIG_USB_XHCI_PCI=3Dy
> # CONFIG_USB_XHCI_PCI_RENESAS is not set
> CONFIG_USB_XHCI_PLATFORM=3Dm
> CONFIG_USB_EHCI_HCD=3Dy
> CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
> CONFIG_USB_EHCI_PCI=3Dy
> # CONFIG_USB_EHCI_FSL is not set
> CONFIG_USB_EHCI_HCD_PLATFORM=3Dy
> CONFIG_USB_OXU210HP_HCD=3Dm
> CONFIG_USB_ISP116X_HCD=3Dm
> CONFIG_USB_FOTG210_HCD=3Dm
> CONFIG_USB_MAX3421_HCD=3Dm
> CONFIG_USB_OHCI_HCD=3Dy
> CONFIG_USB_OHCI_HCD_PCI=3Dy
> CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
> CONFIG_USB_UHCI_HCD=3Dy
> CONFIG_USB_U132_HCD=3Dm
> CONFIG_USB_SL811_HCD=3Dm
> CONFIG_USB_SL811_HCD_ISO=3Dy
> CONFIG_USB_SL811_CS=3Dm
> CONFIG_USB_R8A66597_HCD=3Dm
> CONFIG_USB_HCD_BCMA=3Dm
> CONFIG_USB_HCD_SSB=3Dm
> # CONFIG_USB_HCD_TEST_MODE is not set
> # CONFIG_USB_XEN_HCD is not set
>=20
> #
> # USB Device Class drivers
> #
> CONFIG_USB_ACM=3Dm
> CONFIG_USB_PRINTER=3Dm
> CONFIG_USB_WDM=3Dm
> CONFIG_USB_TMC=3Dm
>=20
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
>=20
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> CONFIG_USB_STORAGE=3Dy
> # CONFIG_USB_STORAGE_DEBUG is not set
> CONFIG_USB_STORAGE_REALTEK=3Dm
> CONFIG_REALTEK_AUTOPM=3Dy
> CONFIG_USB_STORAGE_DATAFAB=3Dm
> CONFIG_USB_STORAGE_FREECOM=3Dm
> CONFIG_USB_STORAGE_ISD200=3Dm
> CONFIG_USB_STORAGE_USBAT=3Dm
> CONFIG_USB_STORAGE_SDDR09=3Dm
> CONFIG_USB_STORAGE_SDDR55=3Dm
> CONFIG_USB_STORAGE_JUMPSHOT=3Dm
> CONFIG_USB_STORAGE_ALAUDA=3Dm
> CONFIG_USB_STORAGE_ONETOUCH=3Dm
> CONFIG_USB_STORAGE_KARMA=3Dm
> CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dm
> CONFIG_USB_STORAGE_ENE_UB6250=3Dm
> CONFIG_USB_UAS=3Dy
>=20
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=3Dm
> CONFIG_USB_MICROTEK=3Dm
> CONFIG_USBIP_CORE=3Dm
> CONFIG_USBIP_VHCI_HCD=3Dm
> CONFIG_USBIP_VHCI_HC_PORTS=3D8
> CONFIG_USBIP_VHCI_NR_HCS=3D1
> CONFIG_USBIP_HOST=3Dm
> CONFIG_USBIP_VUDC=3Dm
> # CONFIG_USBIP_DEBUG is not set
> # CONFIG_USB_CDNS_SUPPORT is not set
> CONFIG_USB_MUSB_HDRC=3Dm
> # CONFIG_USB_MUSB_HOST is not set
> # CONFIG_USB_MUSB_GADGET is not set
> CONFIG_USB_MUSB_DUAL_ROLE=3Dy
>=20
> #
> # Platform Glue Layer
> #
>=20
> #
> # MUSB DMA mode
> #
> CONFIG_MUSB_PIO_ONLY=3Dy
> CONFIG_USB_DWC3=3Dm
> CONFIG_USB_DWC3_ULPI=3Dy
> # CONFIG_USB_DWC3_HOST is not set
> # CONFIG_USB_DWC3_GADGET is not set
> CONFIG_USB_DWC3_DUAL_ROLE=3Dy
>=20
> #
> # Platform Glue Driver Support
> #
> CONFIG_USB_DWC3_PCI=3Dm
> CONFIG_USB_DWC3_HAPS=3Dm
> CONFIG_USB_DWC3_OF_SIMPLE=3Dm
> CONFIG_USB_DWC2=3Dy
> CONFIG_USB_DWC2_HOST=3Dy
>=20
> #
> # Gadget/Dual-role mode requires USB Gadget support to be enabled
> #
> CONFIG_USB_DWC2_PCI=3Dm
> # CONFIG_USB_DWC2_DEBUG is not set
> # CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
> CONFIG_USB_CHIPIDEA=3Dm
> CONFIG_USB_CHIPIDEA_UDC=3Dy
> CONFIG_USB_CHIPIDEA_HOST=3Dy
> CONFIG_USB_CHIPIDEA_PCI=3Dm
> CONFIG_USB_CHIPIDEA_MSM=3Dm
> CONFIG_USB_CHIPIDEA_IMX=3Dm
> CONFIG_USB_CHIPIDEA_GENERIC=3Dm
> CONFIG_USB_CHIPIDEA_TEGRA=3Dm
> CONFIG_USB_ISP1760=3Dm
> CONFIG_USB_ISP1760_HCD=3Dy
> CONFIG_USB_ISP1761_UDC=3Dy
> # CONFIG_USB_ISP1760_HOST_ROLE is not set
> # CONFIG_USB_ISP1760_GADGET_ROLE is not set
> CONFIG_USB_ISP1760_DUAL_ROLE=3Dy
>=20
> #
> # USB port drivers
> #
> CONFIG_USB_USS720=3Dm
> CONFIG_USB_SERIAL=3Dm
> CONFIG_USB_SERIAL_GENERIC=3Dy
> CONFIG_USB_SERIAL_SIMPLE=3Dm
> CONFIG_USB_SERIAL_AIRCABLE=3Dm
> CONFIG_USB_SERIAL_ARK3116=3Dm
> CONFIG_USB_SERIAL_BELKIN=3Dm
> CONFIG_USB_SERIAL_CH341=3Dm
> CONFIG_USB_SERIAL_WHITEHEAT=3Dm
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
> CONFIG_USB_SERIAL_CP210X=3Dm
> CONFIG_USB_SERIAL_CYPRESS_M8=3Dm
> CONFIG_USB_SERIAL_EMPEG=3Dm
> CONFIG_USB_SERIAL_FTDI_SIO=3Dm
> CONFIG_USB_SERIAL_VISOR=3Dm
> CONFIG_USB_SERIAL_IPAQ=3Dm
> CONFIG_USB_SERIAL_IR=3Dm
> CONFIG_USB_SERIAL_EDGEPORT=3Dm
> CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
> CONFIG_USB_SERIAL_F81232=3Dm
> CONFIG_USB_SERIAL_F8153X=3Dm
> CONFIG_USB_SERIAL_GARMIN=3Dm
> CONFIG_USB_SERIAL_IPW=3Dm
> CONFIG_USB_SERIAL_IUU=3Dm
> CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
> CONFIG_USB_SERIAL_KEYSPAN=3Dm
> CONFIG_USB_SERIAL_KLSI=3Dm
> CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
> CONFIG_USB_SERIAL_MCT_U232=3Dm
> CONFIG_USB_SERIAL_METRO=3Dm
> CONFIG_USB_SERIAL_MOS7720=3Dm
> CONFIG_USB_SERIAL_MOS7715_PARPORT=3Dy
> CONFIG_USB_SERIAL_MOS7840=3Dm
> CONFIG_USB_SERIAL_MXUPORT=3Dm
> CONFIG_USB_SERIAL_NAVMAN=3Dm
> CONFIG_USB_SERIAL_PL2303=3Dm
> CONFIG_USB_SERIAL_OTI6858=3Dm
> CONFIG_USB_SERIAL_QCAUX=3Dm
> CONFIG_USB_SERIAL_QUALCOMM=3Dm
> CONFIG_USB_SERIAL_SPCP8X5=3Dm
> CONFIG_USB_SERIAL_SAFE=3Dm
> # CONFIG_USB_SERIAL_SAFE_PADDED is not set
> CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dm
> CONFIG_USB_SERIAL_SYMBOL=3Dm
> CONFIG_USB_SERIAL_TI=3Dm
> CONFIG_USB_SERIAL_CYBERJACK=3Dm
> CONFIG_USB_SERIAL_WWAN=3Dm
> CONFIG_USB_SERIAL_OPTION=3Dm
> CONFIG_USB_SERIAL_OMNINET=3Dm
> CONFIG_USB_SERIAL_OPTICON=3Dm
> CONFIG_USB_SERIAL_XSENS_MT=3Dm
> CONFIG_USB_SERIAL_WISHBONE=3Dm
> CONFIG_USB_SERIAL_SSU100=3Dm
> CONFIG_USB_SERIAL_QT2=3Dm
> CONFIG_USB_SERIAL_UPD78F0730=3Dm
> # CONFIG_USB_SERIAL_XR is not set
> CONFIG_USB_SERIAL_DEBUG=3Dm
>=20
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_EMI62=3Dm
> CONFIG_USB_EMI26=3Dm
> CONFIG_USB_ADUTUX=3Dm
> CONFIG_USB_SEVSEG=3Dm
> CONFIG_USB_LEGOTOWER=3Dm
> CONFIG_USB_LCD=3Dm
> CONFIG_USB_CYPRESS_CY7C63=3Dm
> CONFIG_USB_CYTHERM=3Dm
> CONFIG_USB_IDMOUSE=3Dm
> CONFIG_USB_FTDI_ELAN=3Dm
> CONFIG_USB_APPLEDISPLAY=3Dm
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> CONFIG_USB_SISUSBVGA=3Dm
> CONFIG_USB_LD=3Dm
> CONFIG_USB_TRANCEVIBRATOR=3Dm
> CONFIG_USB_IOWARRIOR=3Dm
> CONFIG_USB_TEST=3Dm
> CONFIG_USB_EHSET_TEST_FIXTURE=3Dm
> CONFIG_USB_ISIGHTFW=3Dm
> CONFIG_USB_YUREX=3Dm
> CONFIG_USB_EZUSB_FX2=3Dm
> CONFIG_USB_HUB_USB251XB=3Dm
> CONFIG_USB_HSIC_USB3503=3Dm
> CONFIG_USB_HSIC_USB4604=3Dm
> CONFIG_USB_LINK_LAYER_TEST=3Dm
> CONFIG_USB_CHAOSKEY=3Dm
> CONFIG_USB_ATM=3Dm
> CONFIG_USB_SPEEDTOUCH=3Dm
> CONFIG_USB_CXACRU=3Dm
> CONFIG_USB_UEAGLEATM=3Dm
> CONFIG_USB_XUSBATM=3Dm
>=20
> #
> # USB Physical Layer drivers
> #
> CONFIG_USB_PHY=3Dy
> CONFIG_NOP_USB_XCEIV=3Dm
> CONFIG_USB_GPIO_VBUS=3Dm
> CONFIG_TAHVO_USB=3Dm
> CONFIG_TAHVO_USB_HOST_BY_DEFAULT=3Dy
> CONFIG_USB_ISP1301=3Dm
> # end of USB Physical Layer drivers
>=20
> CONFIG_USB_GADGET=3Dm
> # CONFIG_USB_GADGET_DEBUG is not set
> # CONFIG_USB_GADGET_DEBUG_FILES is not set
> # CONFIG_USB_GADGET_DEBUG_FS is not set
> CONFIG_USB_GADGET_VBUS_DRAW=3D2
> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=3D2
> CONFIG_U_SERIAL_CONSOLE=3Dy
>=20
> #
> # USB Peripheral Controller
> #
> CONFIG_USB_FOTG210_UDC=3Dm
> CONFIG_USB_GR_UDC=3Dm
> CONFIG_USB_R8A66597=3Dm
> CONFIG_USB_PXA27X=3Dm
> CONFIG_USB_MV_UDC=3Dm
> CONFIG_USB_MV_U3D=3Dm
> CONFIG_USB_SNP_CORE=3Dm
> # CONFIG_USB_SNP_UDC_PLAT is not set
> # CONFIG_USB_M66592 is not set
> CONFIG_USB_BDC_UDC=3Dm
> CONFIG_USB_AMD5536UDC=3Dm
> CONFIG_USB_NET2272=3Dm
> CONFIG_USB_NET2272_DMA=3Dy
> CONFIG_USB_NET2280=3Dm
> CONFIG_USB_GOKU=3Dm
> CONFIG_USB_EG20T=3Dm
> # CONFIG_USB_GADGET_XILINX is not set
> # CONFIG_USB_MAX3420_UDC is not set
> # CONFIG_USB_DUMMY_HCD is not set
> # end of USB Peripheral Controller
>=20
> CONFIG_USB_LIBCOMPOSITE=3Dm
> CONFIG_USB_F_ACM=3Dm
> CONFIG_USB_F_SS_LB=3Dm
> CONFIG_USB_U_SERIAL=3Dm
> CONFIG_USB_U_ETHER=3Dm
> CONFIG_USB_U_AUDIO=3Dm
> CONFIG_USB_F_SERIAL=3Dm
> CONFIG_USB_F_OBEX=3Dm
> CONFIG_USB_F_NCM=3Dm
> CONFIG_USB_F_ECM=3Dm
> CONFIG_USB_F_PHONET=3Dm
> CONFIG_USB_F_EEM=3Dm
> CONFIG_USB_F_SUBSET=3Dm
> CONFIG_USB_F_RNDIS=3Dm
> CONFIG_USB_F_MASS_STORAGE=3Dm
> CONFIG_USB_F_FS=3Dm
> CONFIG_USB_F_UAC1=3Dm
> CONFIG_USB_F_UAC1_LEGACY=3Dm
> CONFIG_USB_F_UAC2=3Dm
> CONFIG_USB_F_UVC=3Dm
> CONFIG_USB_F_MIDI=3Dm
> CONFIG_USB_F_HID=3Dm
> CONFIG_USB_F_PRINTER=3Dm
> CONFIG_USB_F_TCM=3Dm
> CONFIG_USB_CONFIGFS=3Dm
> CONFIG_USB_CONFIGFS_SERIAL=3Dy
> CONFIG_USB_CONFIGFS_ACM=3Dy
> CONFIG_USB_CONFIGFS_OBEX=3Dy
> CONFIG_USB_CONFIGFS_NCM=3Dy
> CONFIG_USB_CONFIGFS_ECM=3Dy
> CONFIG_USB_CONFIGFS_ECM_SUBSET=3Dy
> CONFIG_USB_CONFIGFS_RNDIS=3Dy
> CONFIG_USB_CONFIGFS_EEM=3Dy
> CONFIG_USB_CONFIGFS_PHONET=3Dy
> CONFIG_USB_CONFIGFS_MASS_STORAGE=3Dy
> CONFIG_USB_CONFIGFS_F_LB_SS=3Dy
> CONFIG_USB_CONFIGFS_F_FS=3Dy
> CONFIG_USB_CONFIGFS_F_UAC1=3Dy
> CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=3Dy
> CONFIG_USB_CONFIGFS_F_UAC2=3Dy
> CONFIG_USB_CONFIGFS_F_MIDI=3Dy
> CONFIG_USB_CONFIGFS_F_HID=3Dy
> CONFIG_USB_CONFIGFS_F_UVC=3Dy
> CONFIG_USB_CONFIGFS_F_PRINTER=3Dy
> CONFIG_USB_CONFIGFS_F_TCM=3Dy
>=20
> #
> # USB Gadget precomposed configurations
> #
> CONFIG_USB_ZERO=3Dm
> CONFIG_USB_AUDIO=3Dm
> CONFIG_GADGET_UAC1=3Dy
> # CONFIG_GADGET_UAC1_LEGACY is not set
> CONFIG_USB_ETH=3Dm
> CONFIG_USB_ETH_RNDIS=3Dy
> CONFIG_USB_ETH_EEM=3Dy
> CONFIG_USB_G_NCM=3Dm
> CONFIG_USB_GADGETFS=3Dm
> CONFIG_USB_FUNCTIONFS=3Dm
> CONFIG_USB_FUNCTIONFS_ETH=3Dy
> CONFIG_USB_FUNCTIONFS_RNDIS=3Dy
> CONFIG_USB_FUNCTIONFS_GENERIC=3Dy
> CONFIG_USB_MASS_STORAGE=3Dm
> CONFIG_USB_GADGET_TARGET=3Dm
> CONFIG_USB_G_SERIAL=3Dm
> CONFIG_USB_MIDI_GADGET=3Dm
> CONFIG_USB_G_PRINTER=3Dm
> CONFIG_USB_CDC_COMPOSITE=3Dm
> CONFIG_USB_G_NOKIA=3Dm
> CONFIG_USB_G_ACM_MS=3Dm
> # CONFIG_USB_G_MULTI is not set
> CONFIG_USB_G_HID=3Dm
> CONFIG_USB_G_DBGP=3Dm
> # CONFIG_USB_G_DBGP_PRINTK is not set
> CONFIG_USB_G_DBGP_SERIAL=3Dy
> CONFIG_USB_G_WEBCAM=3Dm
> # CONFIG_USB_RAW_GADGET is not set
> # end of USB Gadget precomposed configurations
>=20
> CONFIG_TYPEC=3Dm
> CONFIG_TYPEC_CCG_HPI=3Dm
> CONFIG_TYPEC_TCPM=3Dm
> CONFIG_TYPEC_TCPCI=3Dm
> # CONFIG_TYPEC_RT1711H is not set
> # CONFIG_TYPEC_TCPCI_MAXIM is not set
> CONFIG_TYPEC_FUSB302=3Dm
> CONFIG_TYPEC_WCOVE=3Dm
> CONFIG_TYPEC_UCSI=3Dm
> # CONFIG_UCSI_CCG is not set
> CONFIG_UCSI_ACPI=3Dm
> CONFIG_TYPEC_TPS6598X=3Dm
> # CONFIG_TYPEC_RT1719 is not set
> # CONFIG_TYPEC_HD3SS3220 is not set
> # CONFIG_TYPEC_STUSB160X is not set
> # CONFIG_TYPEC_WUSB3801 is not set
>=20
> #
> # USB Type-C Multiplexer/DeMultiplexer Switch support
> #
> CONFIG_TYPEC_MUX_PI3USB30532=3Dm
> CONFIG_TYPEC_MUX_INTEL_PMC=3Dm
> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
>=20
> #
> # USB Type-C Alternate Mode drivers
> #
> CONFIG_TYPEC_DP_ALTMODE=3Dm
> # CONFIG_TYPEC_NVIDIA_ALTMODE is not set
> # end of USB Type-C Alternate Mode drivers
>=20
> CONFIG_USB_ROLE_SWITCH=3Dy
> CONFIG_USB_ROLES_INTEL_XHCI=3Dm
> CONFIG_MMC=3Dy
> CONFIG_PWRSEQ_EMMC=3Dy
> # CONFIG_PWRSEQ_SD8787 is not set
> CONFIG_PWRSEQ_SIMPLE=3Dy
> CONFIG_MMC_BLOCK=3Dy
> CONFIG_MMC_BLOCK_MINORS=3D8
> CONFIG_SDIO_UART=3Dm
> # CONFIG_MMC_TEST is not set
> # CONFIG_MMC_CRYPTO is not set
>=20
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_SDHCI=3Dy
> CONFIG_MMC_SDHCI_IO_ACCESSORS=3Dy
> CONFIG_MMC_SDHCI_PCI=3Dy
> CONFIG_MMC_RICOH_MMC=3Dy
> CONFIG_MMC_SDHCI_ACPI=3Dy
> CONFIG_MMC_SDHCI_PLTFM=3Dy
> # CONFIG_MMC_SDHCI_OF_ARASAN is not set
> # CONFIG_MMC_SDHCI_OF_ASPEED is not set
> # CONFIG_MMC_SDHCI_OF_AT91 is not set
> # CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
> # CONFIG_MMC_SDHCI_CADENCE is not set
> CONFIG_MMC_SDHCI_F_SDH30=3Dm
> # CONFIG_MMC_SDHCI_MILBEAUT is not set
> CONFIG_MMC_WBSD=3Dm
> CONFIG_MMC_TIFM_SD=3Dm
> CONFIG_MMC_SPI=3Dm
> CONFIG_MMC_SDRICOH_CS=3Dm
> CONFIG_MMC_CB710=3Dm
> CONFIG_MMC_VIA_SDMMC=3Dm
> CONFIG_MMC_VUB300=3Dm
> CONFIG_MMC_USHC=3Dm
> CONFIG_MMC_USDHI6ROL0=3Dm
> CONFIG_MMC_REALTEK_PCI=3Dm
> CONFIG_MMC_REALTEK_USB=3Dm
> CONFIG_MMC_CQHCI=3Dy
> # CONFIG_MMC_HSQ is not set
> CONFIG_MMC_TOSHIBA_PCI=3Dm
> CONFIG_MMC_MTK=3Dm
> CONFIG_MMC_SDHCI_XENON=3Dm
> # CONFIG_MMC_SDHCI_OMAP is not set
> # CONFIG_MMC_SDHCI_AM654 is not set
> CONFIG_MEMSTICK=3Dm
> # CONFIG_MEMSTICK_DEBUG is not set
>=20
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> CONFIG_MSPRO_BLOCK=3Dm
> CONFIG_MS_BLOCK=3Dm
>=20
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_MEMSTICK_TIFM_MS=3Dm
> CONFIG_MEMSTICK_JMICRON_38X=3Dm
> CONFIG_MEMSTICK_R592=3Dm
> CONFIG_MEMSTICK_REALTEK_PCI=3Dm
> CONFIG_MEMSTICK_REALTEK_USB=3Dm
> CONFIG_NEW_LEDS=3Dy
> CONFIG_LEDS_CLASS=3Dy
> CONFIG_LEDS_CLASS_FLASH=3Dm
> # CONFIG_LEDS_CLASS_MULTICOLOR is not set
> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=3Dy
>=20
> #
> # LED drivers
> #
> CONFIG_LEDS_88PM860X=3Dm
> # CONFIG_LEDS_AN30259A is not set
> CONFIG_LEDS_APU=3Dm
> # CONFIG_LEDS_AW2013 is not set
> # CONFIG_LEDS_BCM6328 is not set
> # CONFIG_LEDS_BCM6358 is not set
> # CONFIG_LEDS_CR0014114 is not set
> # CONFIG_LEDS_EL15203000 is not set
> CONFIG_LEDS_LM3530=3Dm
> # CONFIG_LEDS_LM3532 is not set
> CONFIG_LEDS_LM3533=3Dm
> CONFIG_LEDS_LM3642=3Dm
> # CONFIG_LEDS_LM3692X is not set
> CONFIG_LEDS_MT6323=3Dm
> CONFIG_LEDS_PCA9532=3Dm
> CONFIG_LEDS_PCA9532_GPIO=3Dy
> CONFIG_LEDS_GPIO=3Dm
> CONFIG_LEDS_LP3944=3Dm
> CONFIG_LEDS_LP3952=3Dm
> # CONFIG_LEDS_LP50XX is not set
> CONFIG_LEDS_LP55XX_COMMON=3Dm
> CONFIG_LEDS_LP5521=3Dm
> CONFIG_LEDS_LP5523=3Dm
> CONFIG_LEDS_LP5562=3Dm
> CONFIG_LEDS_LP8501=3Dm
> CONFIG_LEDS_LP8788=3Dm
> # CONFIG_LEDS_LP8860 is not set
> CONFIG_LEDS_CLEVO_MAIL=3Dm
> CONFIG_LEDS_PCA955X=3Dm
> CONFIG_LEDS_PCA955X_GPIO=3Dy
> CONFIG_LEDS_PCA963X=3Dm
> CONFIG_LEDS_WM831X_STATUS=3Dm
> CONFIG_LEDS_WM8350=3Dm
> CONFIG_LEDS_DA903X=3Dm
> CONFIG_LEDS_DA9052=3Dm
> CONFIG_LEDS_DAC124S085=3Dm
> CONFIG_LEDS_PWM=3Dm
> CONFIG_LEDS_REGULATOR=3Dm
> CONFIG_LEDS_BD2802=3Dm
> CONFIG_LEDS_INTEL_SS4200=3Dm
> # CONFIG_LEDS_LT3593 is not set
> CONFIG_LEDS_ADP5520=3Dm
> CONFIG_LEDS_MC13783=3Dm
> CONFIG_LEDS_TCA6507=3Dm
> CONFIG_LEDS_TLC591XX=3Dm
> CONFIG_LEDS_MAX8997=3Dm
> CONFIG_LEDS_LM355x=3Dm
> CONFIG_LEDS_MENF21BMC=3Dm
> # CONFIG_LEDS_IS31FL319X is not set
> # CONFIG_LEDS_IS31FL32XX is not set
>=20
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_T=
HINGM)
> #
> CONFIG_LEDS_BLINKM=3Dm
> # CONFIG_LEDS_SYSCON is not set
> CONFIG_LEDS_MLXCPLD=3Dm
> # CONFIG_LEDS_MLXREG is not set
> CONFIG_LEDS_USER=3Dm
> CONFIG_LEDS_NIC78BX=3Dm
> # CONFIG_LEDS_SPI_BYTE is not set
> # CONFIG_LEDS_TI_LMU_COMMON is not set
> CONFIG_LEDS_TPS6105X=3Dm
> # CONFIG_LEDS_LGM is not set
>=20
> #
> # Flash and Torch LED drivers
> #
> # CONFIG_LEDS_AAT1290 is not set
> CONFIG_LEDS_AS3645A=3Dm
> # CONFIG_LEDS_KTD2692 is not set
> # CONFIG_LEDS_LM3601X is not set
> # CONFIG_LEDS_MAX77693 is not set
> # CONFIG_LEDS_RT4505 is not set
> # CONFIG_LEDS_RT8515 is not set
> # CONFIG_LEDS_SGM3140 is not set
>=20
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=3Dy
> CONFIG_LEDS_TRIGGER_TIMER=3Dm
> CONFIG_LEDS_TRIGGER_ONESHOT=3Dm
> CONFIG_LEDS_TRIGGER_DISK=3Dy
> CONFIG_LEDS_TRIGGER_MTD=3Dy
> CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
> CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dm
> CONFIG_LEDS_TRIGGER_CPU=3Dy
> CONFIG_LEDS_TRIGGER_ACTIVITY=3Dm
> CONFIG_LEDS_TRIGGER_GPIO=3Dm
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm
>=20
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=3Dm
> CONFIG_LEDS_TRIGGER_CAMERA=3Dm
> CONFIG_LEDS_TRIGGER_PANIC=3Dy
> CONFIG_LEDS_TRIGGER_NETDEV=3Dm
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> CONFIG_LEDS_TRIGGER_AUDIO=3Dm
> # CONFIG_LEDS_TRIGGER_TTY is not set
>=20
> #
> # Simple LED drivers
> #
> # CONFIG_ACCESSIBILITY is not set
> CONFIG_INFINIBAND=3Dm
> CONFIG_INFINIBAND_USER_MAD=3Dm
> CONFIG_INFINIBAND_USER_ACCESS=3Dm
> CONFIG_INFINIBAND_USER_MEM=3Dy
> CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy
> CONFIG_INFINIBAND_ADDR_TRANS=3Dy
> CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=3Dy
> CONFIG_INFINIBAND_VIRT_DMA=3Dy
> CONFIG_INFINIBAND_MTHCA=3Dm
> # CONFIG_INFINIBAND_MTHCA_DEBUG is not set
> CONFIG_INFINIBAND_QIB=3Dm
> CONFIG_INFINIBAND_QIB_DCA=3Dy
> CONFIG_INFINIBAND_CXGB4=3Dm
> # CONFIG_INFINIBAND_EFA is not set
> # CONFIG_INFINIBAND_IRDMA is not set
> CONFIG_MLX4_INFINIBAND=3Dm
> CONFIG_MLX5_INFINIBAND=3Dm
> CONFIG_INFINIBAND_OCRDMA=3Dm
> CONFIG_INFINIBAND_VMWARE_PVRDMA=3Dm
> CONFIG_INFINIBAND_USNIC=3Dm
> CONFIG_INFINIBAND_BNXT_RE=3Dm
> CONFIG_INFINIBAND_HFI1=3Dm
> # CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
> # CONFIG_SDMA_VERBOSITY is not set
> CONFIG_INFINIBAND_QEDR=3Dm
> CONFIG_INFINIBAND_RDMAVT=3Dm
> CONFIG_RDMA_RXE=3Dm
> # CONFIG_RDMA_SIW is not set
> CONFIG_INFINIBAND_IPOIB=3Dm
> CONFIG_INFINIBAND_IPOIB_CM=3Dy
> # CONFIG_INFINIBAND_IPOIB_DEBUG is not set
> CONFIG_INFINIBAND_SRP=3Dm
> CONFIG_INFINIBAND_SRPT=3Dm
> CONFIG_INFINIBAND_ISER=3Dm
> CONFIG_INFINIBAND_ISERT=3Dm
> # CONFIG_INFINIBAND_RTRS_CLIENT is not set
> # CONFIG_INFINIBAND_RTRS_SERVER is not set
> CONFIG_INFINIBAND_OPA_VNIC=3Dm
> CONFIG_EDAC_ATOMIC_SCRUB=3Dy
> CONFIG_EDAC_SUPPORT=3Dy
> CONFIG_EDAC=3Dy
> # CONFIG_EDAC_LEGACY_SYSFS is not set
> CONFIG_EDAC_DEBUG=3Dy
> CONFIG_EDAC_DECODE_MCE=3Dm
> CONFIG_EDAC_GHES=3Dy
> CONFIG_EDAC_AMD64=3Dm
> CONFIG_EDAC_E752X=3Dm
> CONFIG_EDAC_I82975X=3Dm
> CONFIG_EDAC_I3000=3Dm
> CONFIG_EDAC_I3200=3Dm
> CONFIG_EDAC_IE31200=3Dm
> CONFIG_EDAC_X38=3Dm
> CONFIG_EDAC_I5400=3Dm
> CONFIG_EDAC_I7CORE=3Dm
> CONFIG_EDAC_I5000=3Dm
> CONFIG_EDAC_I5100=3Dm
> CONFIG_EDAC_I7300=3Dm
> CONFIG_EDAC_SBRIDGE=3Dm
> CONFIG_EDAC_SKX=3Dm
> CONFIG_EDAC_I10NM=3Dm
> CONFIG_EDAC_PND2=3Dm
> CONFIG_EDAC_IGEN6=3Dm
> CONFIG_EDAC_IEH=3Dm
> CONFIG_RTC_LIB=3Dy
> CONFIG_RTC_MC146818_LIB=3Dy
> CONFIG_RTC_CLASS=3Dy
> CONFIG_RTC_HCTOSYS=3Dy
> CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
> CONFIG_RTC_SYSTOHC=3Dy
> CONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=3Dy
>=20
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=3Dy
> CONFIG_RTC_INTF_PROC=3Dy
> CONFIG_RTC_INTF_DEV=3Dy
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
>=20
> #
> # I2C RTC drivers
> #
> CONFIG_RTC_DRV_88PM860X=3Dm
> CONFIG_RTC_DRV_88PM80X=3Dm
> CONFIG_RTC_DRV_ABB5ZES3=3Dm
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> CONFIG_RTC_DRV_ABX80X=3Dm
> CONFIG_RTC_DRV_DS1307=3Dm
> CONFIG_RTC_DRV_DS1307_CENTURY=3Dy
> CONFIG_RTC_DRV_DS1374=3Dm
> CONFIG_RTC_DRV_DS1374_WDT=3Dy
> CONFIG_RTC_DRV_DS1672=3Dm
> # CONFIG_RTC_DRV_HYM8563 is not set
> CONFIG_RTC_DRV_LP8788=3Dm
> CONFIG_RTC_DRV_MAX6900=3Dm
> CONFIG_RTC_DRV_MAX8907=3Dm
> CONFIG_RTC_DRV_MAX8925=3Dm
> CONFIG_RTC_DRV_MAX8998=3Dm
> CONFIG_RTC_DRV_MAX8997=3Dm
> CONFIG_RTC_DRV_RS5C372=3Dm
> CONFIG_RTC_DRV_ISL1208=3Dm
> CONFIG_RTC_DRV_ISL12022=3Dm
> # CONFIG_RTC_DRV_ISL12026 is not set
> CONFIG_RTC_DRV_X1205=3Dm
> CONFIG_RTC_DRV_PCF8523=3Dm
> CONFIG_RTC_DRV_PCF85063=3Dm
> CONFIG_RTC_DRV_PCF85363=3Dm
> CONFIG_RTC_DRV_PCF8563=3Dm
> CONFIG_RTC_DRV_PCF8583=3Dm
> CONFIG_RTC_DRV_M41T80=3Dm
> CONFIG_RTC_DRV_M41T80_WDT=3Dy
> CONFIG_RTC_DRV_BQ32K=3Dm
> # CONFIG_RTC_DRV_TWL4030 is not set
> CONFIG_RTC_DRV_PALMAS=3Dm
> CONFIG_RTC_DRV_TPS6586X=3Dm
> CONFIG_RTC_DRV_TPS65910=3Dm
> CONFIG_RTC_DRV_RC5T583=3Dm
> CONFIG_RTC_DRV_S35390A=3Dm
> CONFIG_RTC_DRV_FM3130=3Dm
> CONFIG_RTC_DRV_RX8010=3Dm
> CONFIG_RTC_DRV_RX8581=3Dm
> CONFIG_RTC_DRV_RX8025=3Dm
> CONFIG_RTC_DRV_EM3027=3Dm
> # CONFIG_RTC_DRV_RV3028 is not set
> # CONFIG_RTC_DRV_RV3032 is not set
> CONFIG_RTC_DRV_RV8803=3Dm
> CONFIG_RTC_DRV_S5M=3Dm
> # CONFIG_RTC_DRV_SD3078 is not set
>=20
> #
> # SPI RTC drivers
> #
> CONFIG_RTC_DRV_M41T93=3Dm
> CONFIG_RTC_DRV_M41T94=3Dm
> CONFIG_RTC_DRV_DS1302=3Dm
> CONFIG_RTC_DRV_DS1305=3Dm
> CONFIG_RTC_DRV_DS1343=3Dm
> CONFIG_RTC_DRV_DS1347=3Dm
> CONFIG_RTC_DRV_DS1390=3Dm
> CONFIG_RTC_DRV_MAX6916=3Dm
> CONFIG_RTC_DRV_R9701=3Dm
> CONFIG_RTC_DRV_RX4581=3Dm
> CONFIG_RTC_DRV_RS5C348=3Dm
> CONFIG_RTC_DRV_MAX6902=3Dm
> CONFIG_RTC_DRV_PCF2123=3Dm
> CONFIG_RTC_DRV_MCP795=3Dm
> CONFIG_RTC_I2C_AND_SPI=3Dy
>=20
> #
> # SPI and I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS3232=3Dm
> CONFIG_RTC_DRV_DS3232_HWMON=3Dy
> CONFIG_RTC_DRV_PCF2127=3Dm
> CONFIG_RTC_DRV_RV3029C2=3Dm
> CONFIG_RTC_DRV_RV3029_HWMON=3Dy
> CONFIG_RTC_DRV_RX6110=3Dm
>=20
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=3Dy
> CONFIG_RTC_DRV_DS1286=3Dm
> CONFIG_RTC_DRV_DS1511=3Dm
> CONFIG_RTC_DRV_DS1553=3Dm
> CONFIG_RTC_DRV_DS1685_FAMILY=3Dm
> CONFIG_RTC_DRV_DS1685=3Dy
> # CONFIG_RTC_DRV_DS1689 is not set
> # CONFIG_RTC_DRV_DS17285 is not set
> # CONFIG_RTC_DRV_DS17485 is not set
> # CONFIG_RTC_DRV_DS17885 is not set
> CONFIG_RTC_DRV_DS1742=3Dm
> CONFIG_RTC_DRV_DS2404=3Dm
> CONFIG_RTC_DRV_DA9052=3Dm
> CONFIG_RTC_DRV_DA9055=3Dm
> CONFIG_RTC_DRV_DA9063=3Dm
> CONFIG_RTC_DRV_STK17TA8=3Dm
> CONFIG_RTC_DRV_M48T86=3Dm
> CONFIG_RTC_DRV_M48T35=3Dm
> CONFIG_RTC_DRV_M48T59=3Dm
> CONFIG_RTC_DRV_MSM6242=3Dm
> CONFIG_RTC_DRV_BQ4802=3Dm
> CONFIG_RTC_DRV_RP5C01=3Dm
> CONFIG_RTC_DRV_V3020=3Dm
> CONFIG_RTC_DRV_WM831X=3Dm
> CONFIG_RTC_DRV_WM8350=3Dm
> CONFIG_RTC_DRV_PCF50633=3Dm
> # CONFIG_RTC_DRV_ZYNQMP is not set
> CONFIG_RTC_DRV_CROS_EC=3Dm
>=20
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_CADENCE is not set
> CONFIG_RTC_DRV_FTRTC010=3Dm
> CONFIG_RTC_DRV_PCAP=3Dm
> CONFIG_RTC_DRV_MC13XXX=3Dm
> CONFIG_RTC_DRV_MT6397=3Dm
> # CONFIG_RTC_DRV_R7301 is not set
>=20
> #
> # HID Sensor RTC drivers
> #
> CONFIG_RTC_DRV_HID_SENSOR_TIME=3Dm
> # CONFIG_RTC_DRV_GOLDFISH is not set
> CONFIG_DMADEVICES=3Dy
> # CONFIG_DMADEVICES_DEBUG is not set
>=20
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=3Dy
> CONFIG_DMA_VIRTUAL_CHANNELS=3Dy
> CONFIG_DMA_ACPI=3Dy
> CONFIG_DMA_OF=3Dy
> CONFIG_ALTERA_MSGDMA=3Dm
> # CONFIG_DW_AXI_DMAC is not set
> # CONFIG_FSL_EDMA is not set
> CONFIG_INTEL_IDMA64=3Dy
> CONFIG_INTEL_IDXD_BUS=3Dy
> CONFIG_INTEL_IDXD=3Dm
> CONFIG_INTEL_IDXD_COMPAT=3Dy
> CONFIG_INTEL_IDXD_SVM=3Dy
> CONFIG_INTEL_IDXD_PERFMON=3Dy
> CONFIG_INTEL_IOATDMA=3Dm
> # CONFIG_PLX_DMA is not set
> # CONFIG_XILINX_ZYNQMP_DPDMA is not set
> # CONFIG_AMD_PTDMA is not set
> CONFIG_QCOM_HIDMA_MGMT=3Dm
> CONFIG_QCOM_HIDMA=3Dm
> CONFIG_DW_DMAC_CORE=3Dm
> CONFIG_DW_DMAC=3Dm
> CONFIG_DW_DMAC_PCI=3Dm
> # CONFIG_DW_EDMA is not set
> # CONFIG_DW_EDMA_PCIE is not set
> CONFIG_HSU_DMA=3Dm
> # CONFIG_SF_PDMA is not set
> # CONFIG_INTEL_LDMA is not set
>=20
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=3Dy
> CONFIG_DMATEST=3Dm
> CONFIG_DMA_ENGINE_RAID=3Dy
>=20
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=3Dy
> CONFIG_SW_SYNC=3Dy
> # CONFIG_UDMABUF is not set
> # CONFIG_DMABUF_MOVE_NOTIFY is not set
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_DMABUF_SELFTESTS is not set
> # CONFIG_DMABUF_HEAPS is not set
> # CONFIG_DMABUF_SYSFS_STATS is not set
> # end of DMABUF options
>=20
> CONFIG_DCA=3Dm
> CONFIG_AUXDISPLAY=3Dy
> CONFIG_CHARLCD=3Dm
> CONFIG_LINEDISP=3Dm
> CONFIG_HD44780_COMMON=3Dm
> CONFIG_HD44780=3Dm
> CONFIG_KS0108=3Dm
> CONFIG_KS0108_PORT=3D0x378
> CONFIG_KS0108_DELAY=3D2
> CONFIG_CFAG12864B=3Dm
> CONFIG_CFAG12864B_RATE=3D20
> CONFIG_IMG_ASCII_LCD=3Dm
> # CONFIG_HT16K33 is not set
> # CONFIG_LCD2S is not set
> CONFIG_PARPORT_PANEL=3Dm
> CONFIG_PANEL_PARPORT=3D0
> CONFIG_PANEL_PROFILE=3D5
> # CONFIG_PANEL_CHANGE_MESSAGE is not set
> # CONFIG_CHARLCD_BL_OFF is not set
> # CONFIG_CHARLCD_BL_ON is not set
> CONFIG_CHARLCD_BL_FLASH=3Dy
> CONFIG_PANEL=3Dm
> CONFIG_UIO=3Dm
> CONFIG_UIO_CIF=3Dm
> CONFIG_UIO_PDRV_GENIRQ=3Dm
> CONFIG_UIO_DMEM_GENIRQ=3Dm
> CONFIG_UIO_AEC=3Dm
> CONFIG_UIO_SERCOS3=3Dm
> CONFIG_UIO_PCI_GENERIC=3Dm
> CONFIG_UIO_NETX=3Dm
> CONFIG_UIO_PRUSS=3Dm
> CONFIG_UIO_MF624=3Dm
> CONFIG_UIO_HV_GENERIC=3Dm
> CONFIG_VFIO=3Dy
> CONFIG_VFIO_IOMMU_TYPE1=3Dy
> CONFIG_VFIO_VIRQFD=3Dm
> CONFIG_VFIO_NOIOMMU=3Dy
> CONFIG_VFIO_PCI_CORE=3Dm
> CONFIG_VFIO_PCI_MMAP=3Dy
> CONFIG_VFIO_PCI_INTX=3Dy
> CONFIG_VFIO_PCI=3Dm
> CONFIG_VFIO_PCI_VGA=3Dy
> CONFIG_VFIO_PCI_IGD=3Dy
> # CONFIG_MLX5_VFIO_PCI is not set
> CONFIG_VFIO_MDEV=3Dy
> CONFIG_IRQ_BYPASS_MANAGER=3Dm
> CONFIG_VIRT_DRIVERS=3Dy
> CONFIG_VMGENID=3Dy
> CONFIG_VBOXGUEST=3Dm
> # CONFIG_NITRO_ENCLAVES is not set
> # CONFIG_ACRN_HSM is not set
> CONFIG_VIRTIO=3Dy
> CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=3Dy
> CONFIG_VIRTIO_PCI_LIB=3Dy
> CONFIG_VIRTIO_PCI_LIB_LEGACY=3Dy
> CONFIG_VIRTIO_MENU=3Dy
> CONFIG_VIRTIO_PCI=3Dy
> CONFIG_VIRTIO_PCI_LEGACY=3Dy
> # CONFIG_VIRTIO_PMEM is not set
> CONFIG_VIRTIO_BALLOON=3Dy
> CONFIG_VIRTIO_INPUT=3Dy
> CONFIG_VIRTIO_MMIO=3Dy
> CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=3Dy
> CONFIG_VIRTIO_DMA_SHARED_BUFFER=3Dy
> # CONFIG_VDPA is not set
> CONFIG_VHOST_IOTLB=3Dm
> CONFIG_VHOST=3Dm
> CONFIG_VHOST_MENU=3Dy
> CONFIG_VHOST_NET=3Dm
> CONFIG_VHOST_SCSI=3Dm
> CONFIG_VHOST_VSOCK=3Dm
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
>=20
> #
> # Microsoft Hyper-V guest support
> #
> CONFIG_HYPERV=3Dm
> CONFIG_HYPERV_TIMER=3Dy
> CONFIG_HYPERV_UTILS=3Dm
> CONFIG_HYPERV_BALLOON=3Dm
> # end of Microsoft Hyper-V guest support
>=20
> #
> # Xen driver support
> #
> CONFIG_XEN_BALLOON=3Dy
> CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=3Dy
> CONFIG_XEN_MEMORY_HOTPLUG_LIMIT=3D512
> CONFIG_XEN_SCRUB_PAGES_DEFAULT=3Dy
> CONFIG_XEN_DEV_EVTCHN=3Dm
> CONFIG_XEN_BACKEND=3Dy
> CONFIG_XENFS=3Dm
> CONFIG_XEN_COMPAT_XENFS=3Dy
> CONFIG_XEN_SYS_HYPERVISOR=3Dy
> CONFIG_XEN_XENBUS_FRONTEND=3Dy
> CONFIG_XEN_GNTDEV=3Dm
> CONFIG_XEN_GRANT_DEV_ALLOC=3Dm
> # CONFIG_XEN_GRANT_DMA_ALLOC is not set
> CONFIG_SWIOTLB_XEN=3Dy
> CONFIG_XEN_PCI_STUB=3Dy
> CONFIG_XEN_PCIDEV_BACKEND=3Dm
> CONFIG_XEN_PVCALLS_FRONTEND=3Dm
> # CONFIG_XEN_PVCALLS_BACKEND is not set
> CONFIG_XEN_SCSI_BACKEND=3Dm
> CONFIG_XEN_PRIVCMD=3Dm
> CONFIG_XEN_ACPI_PROCESSOR=3Dy
> CONFIG_XEN_MCE_LOG=3Dy
> CONFIG_XEN_HAVE_PVMMU=3Dy
> CONFIG_XEN_EFI=3Dy
> CONFIG_XEN_AUTO_XLATE=3Dy
> CONFIG_XEN_ACPI=3Dy
> CONFIG_XEN_SYMS=3Dy
> CONFIG_XEN_HAVE_VPMU=3Dy
> CONFIG_XEN_UNPOPULATED_ALLOC=3Dy
> # end of Xen driver support
>=20
> CONFIG_GREYBUS=3Dm
> CONFIG_GREYBUS_ES2=3Dm
> CONFIG_COMEDI=3Dm
> # CONFIG_COMEDI_DEBUG is not set
> CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=3D2048
> CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=3D20480
> CONFIG_COMEDI_MISC_DRIVERS=3Dy
> CONFIG_COMEDI_BOND=3Dm
> CONFIG_COMEDI_TEST=3Dm
> CONFIG_COMEDI_PARPORT=3Dm
> CONFIG_COMEDI_ISA_DRIVERS=3Dy
> CONFIG_COMEDI_PCL711=3Dm
> CONFIG_COMEDI_PCL724=3Dm
> CONFIG_COMEDI_PCL726=3Dm
> CONFIG_COMEDI_PCL730=3Dm
> CONFIG_COMEDI_PCL812=3Dm
> CONFIG_COMEDI_PCL816=3Dm
> CONFIG_COMEDI_PCL818=3Dm
> CONFIG_COMEDI_PCM3724=3Dm
> CONFIG_COMEDI_AMPLC_DIO200_ISA=3Dm
> CONFIG_COMEDI_AMPLC_PC236_ISA=3Dm
> CONFIG_COMEDI_AMPLC_PC263_ISA=3Dm
> CONFIG_COMEDI_RTI800=3Dm
> CONFIG_COMEDI_RTI802=3Dm
> CONFIG_COMEDI_DAC02=3Dm
> CONFIG_COMEDI_DAS16M1=3Dm
> CONFIG_COMEDI_DAS08_ISA=3Dm
> CONFIG_COMEDI_DAS16=3Dm
> CONFIG_COMEDI_DAS800=3Dm
> CONFIG_COMEDI_DAS1800=3Dm
> CONFIG_COMEDI_DAS6402=3Dm
> CONFIG_COMEDI_DT2801=3Dm
> CONFIG_COMEDI_DT2811=3Dm
> CONFIG_COMEDI_DT2814=3Dm
> CONFIG_COMEDI_DT2815=3Dm
> CONFIG_COMEDI_DT2817=3Dm
> CONFIG_COMEDI_DT282X=3Dm
> CONFIG_COMEDI_DMM32AT=3Dm
> CONFIG_COMEDI_FL512=3Dm
> CONFIG_COMEDI_AIO_AIO12_8=3Dm
> CONFIG_COMEDI_AIO_IIRO_16=3Dm
> CONFIG_COMEDI_II_PCI20KC=3Dm
> CONFIG_COMEDI_C6XDIGIO=3Dm
> CONFIG_COMEDI_MPC624=3Dm
> CONFIG_COMEDI_ADQ12B=3Dm
> CONFIG_COMEDI_NI_AT_A2150=3Dm
> CONFIG_COMEDI_NI_AT_AO=3Dm
> CONFIG_COMEDI_NI_ATMIO=3Dm
> CONFIG_COMEDI_NI_ATMIO16D=3Dm
> CONFIG_COMEDI_NI_LABPC_ISA=3Dm
> CONFIG_COMEDI_PCMAD=3Dm
> CONFIG_COMEDI_PCMDA12=3Dm
> CONFIG_COMEDI_PCMMIO=3Dm
> CONFIG_COMEDI_PCMUIO=3Dm
> CONFIG_COMEDI_MULTIQ3=3Dm
> CONFIG_COMEDI_S526=3Dm
> CONFIG_COMEDI_PCI_DRIVERS=3Dm
> CONFIG_COMEDI_8255_PCI=3Dm
> CONFIG_COMEDI_ADDI_WATCHDOG=3Dm
> CONFIG_COMEDI_ADDI_APCI_1032=3Dm
> CONFIG_COMEDI_ADDI_APCI_1500=3Dm
> CONFIG_COMEDI_ADDI_APCI_1516=3Dm
> CONFIG_COMEDI_ADDI_APCI_1564=3Dm
> CONFIG_COMEDI_ADDI_APCI_16XX=3Dm
> CONFIG_COMEDI_ADDI_APCI_2032=3Dm
> CONFIG_COMEDI_ADDI_APCI_2200=3Dm
> CONFIG_COMEDI_ADDI_APCI_3120=3Dm
> CONFIG_COMEDI_ADDI_APCI_3501=3Dm
> CONFIG_COMEDI_ADDI_APCI_3XXX=3Dm
> CONFIG_COMEDI_ADL_PCI6208=3Dm
> CONFIG_COMEDI_ADL_PCI7X3X=3Dm
> CONFIG_COMEDI_ADL_PCI8164=3Dm
> CONFIG_COMEDI_ADL_PCI9111=3Dm
> CONFIG_COMEDI_ADL_PCI9118=3Dm
> CONFIG_COMEDI_ADV_PCI1710=3Dm
> CONFIG_COMEDI_ADV_PCI1720=3Dm
> CONFIG_COMEDI_ADV_PCI1723=3Dm
> CONFIG_COMEDI_ADV_PCI1724=3Dm
> CONFIG_COMEDI_ADV_PCI1760=3Dm
> CONFIG_COMEDI_ADV_PCI_DIO=3Dm
> CONFIG_COMEDI_AMPLC_DIO200_PCI=3Dm
> CONFIG_COMEDI_AMPLC_PC236_PCI=3Dm
> CONFIG_COMEDI_AMPLC_PC263_PCI=3Dm
> CONFIG_COMEDI_AMPLC_PCI224=3Dm
> CONFIG_COMEDI_AMPLC_PCI230=3Dm
> CONFIG_COMEDI_CONTEC_PCI_DIO=3Dm
> CONFIG_COMEDI_DAS08_PCI=3Dm
> CONFIG_COMEDI_DT3000=3Dm
> CONFIG_COMEDI_DYNA_PCI10XX=3Dm
> CONFIG_COMEDI_GSC_HPDI=3Dm
> CONFIG_COMEDI_MF6X4=3Dm
> CONFIG_COMEDI_ICP_MULTI=3Dm
> CONFIG_COMEDI_DAQBOARD2000=3Dm
> CONFIG_COMEDI_JR3_PCI=3Dm
> CONFIG_COMEDI_KE_COUNTER=3Dm
> CONFIG_COMEDI_CB_PCIDAS64=3Dm
> CONFIG_COMEDI_CB_PCIDAS=3Dm
> CONFIG_COMEDI_CB_PCIDDA=3Dm
> CONFIG_COMEDI_CB_PCIMDAS=3Dm
> CONFIG_COMEDI_CB_PCIMDDA=3Dm
> CONFIG_COMEDI_ME4000=3Dm
> CONFIG_COMEDI_ME_DAQ=3Dm
> CONFIG_COMEDI_NI_6527=3Dm
> CONFIG_COMEDI_NI_65XX=3Dm
> CONFIG_COMEDI_NI_660X=3Dm
> CONFIG_COMEDI_NI_670X=3Dm
> CONFIG_COMEDI_NI_LABPC_PCI=3Dm
> CONFIG_COMEDI_NI_PCIDIO=3Dm
> CONFIG_COMEDI_NI_PCIMIO=3Dm
> CONFIG_COMEDI_RTD520=3Dm
> CONFIG_COMEDI_S626=3Dm
> CONFIG_COMEDI_MITE=3Dm
> CONFIG_COMEDI_NI_TIOCMD=3Dm
> CONFIG_COMEDI_PCMCIA_DRIVERS=3Dm
> CONFIG_COMEDI_CB_DAS16_CS=3Dm
> CONFIG_COMEDI_DAS08_CS=3Dm
> CONFIG_COMEDI_NI_DAQ_700_CS=3Dm
> CONFIG_COMEDI_NI_DAQ_DIO24_CS=3Dm
> CONFIG_COMEDI_NI_LABPC_CS=3Dm
> CONFIG_COMEDI_NI_MIO_CS=3Dm
> CONFIG_COMEDI_QUATECH_DAQP_CS=3Dm
> CONFIG_COMEDI_USB_DRIVERS=3Dm
> CONFIG_COMEDI_DT9812=3Dm
> CONFIG_COMEDI_NI_USB6501=3Dm
> CONFIG_COMEDI_USBDUX=3Dm
> CONFIG_COMEDI_USBDUXFAST=3Dm
> CONFIG_COMEDI_USBDUXSIGMA=3Dm
> CONFIG_COMEDI_VMK80XX=3Dm
> CONFIG_COMEDI_8254=3Dm
> CONFIG_COMEDI_8255=3Dm
> CONFIG_COMEDI_8255_SA=3Dm
> CONFIG_COMEDI_KCOMEDILIB=3Dm
> CONFIG_COMEDI_AMPLC_DIO200=3Dm
> CONFIG_COMEDI_AMPLC_PC236=3Dm
> CONFIG_COMEDI_DAS08=3Dm
> CONFIG_COMEDI_ISADMA=3Dm
> CONFIG_COMEDI_NI_LABPC=3Dm
> CONFIG_COMEDI_NI_LABPC_ISADMA=3Dm
> CONFIG_COMEDI_NI_TIO=3Dm
> CONFIG_COMEDI_NI_ROUTING=3Dm
> # CONFIG_COMEDI_TESTS is not set
> CONFIG_STAGING=3Dy
> CONFIG_PRISM2_USB=3Dm
> CONFIG_RTL8192U=3Dm
> CONFIG_RTLLIB=3Dm
> CONFIG_RTLLIB_CRYPTO_CCMP=3Dm
> CONFIG_RTLLIB_CRYPTO_TKIP=3Dm
> CONFIG_RTLLIB_CRYPTO_WEP=3Dm
> CONFIG_RTL8192E=3Dm
> CONFIG_RTL8723BS=3Dm
> CONFIG_R8712U=3Dm
> CONFIG_R8188EU=3Dm
> CONFIG_RTS5208=3Dm
> CONFIG_VT6655=3Dm
> CONFIG_VT6656=3Dm
>=20
> #
> # IIO staging drivers
> #
>=20
> #
> # Accelerometers
> #
> CONFIG_ADIS16203=3Dm
> CONFIG_ADIS16240=3Dm
> # end of Accelerometers
>=20
> #
> # Analog to digital converters
> #
> CONFIG_AD7816=3Dm
> # end of Analog to digital converters
>=20
> #
> # Analog digital bi-direction converters
> #
> CONFIG_ADT7316=3Dm
> CONFIG_ADT7316_SPI=3Dm
> CONFIG_ADT7316_I2C=3Dm
> # end of Analog digital bi-direction converters
>=20
> #
> # Capacitance to digital converters
> #
> CONFIG_AD7746=3Dm
> # end of Capacitance to digital converters
>=20
> #
> # Direct Digital Synthesis
> #
> CONFIG_AD9832=3Dm
> CONFIG_AD9834=3Dm
> # end of Direct Digital Synthesis
>=20
> #
> # Network Analyzer, Impedance Converters
> #
> CONFIG_AD5933=3Dm
> # end of Network Analyzer, Impedance Converters
>=20
> #
> # Active energy metering IC
> #
> CONFIG_ADE7854=3Dm
> CONFIG_ADE7854_I2C=3Dm
> CONFIG_ADE7854_SPI=3Dm
> # end of Active energy metering IC
>=20
> #
> # Resolver to digital converters
> #
> CONFIG_AD2S1210=3Dm
> # end of Resolver to digital converters
> # end of IIO staging drivers
>=20
> CONFIG_FB_SM750=3Dm
> CONFIG_STAGING_MEDIA=3Dy
> # CONFIG_INTEL_ATOMISP is not set
> # CONFIG_VIDEO_MAX96712 is not set
> # CONFIG_VIDEO_ZORAN is not set
> # CONFIG_VIDEO_IPU3_IMGU is not set
> CONFIG_DVB_AV7110_IR=3Dy
> CONFIG_DVB_AV7110=3Dm
> CONFIG_DVB_AV7110_OSD=3Dy
> CONFIG_DVB_BUDGET_PATCH=3Dm
> CONFIG_DVB_SP8870=3Dm
> # CONFIG_STAGING_BOARD is not set
> CONFIG_LTE_GDM724X=3Dm
> CONFIG_FIREWIRE_SERIAL=3Dm
> CONFIG_FWTTY_MAX_TOTAL_PORTS=3D64
> CONFIG_FWTTY_MAX_CARD_PORTS=3D32
> CONFIG_UNISYSSPAR=3Dy
> CONFIG_UNISYS_VISORNIC=3Dm
> CONFIG_UNISYS_VISORINPUT=3Dm
> CONFIG_UNISYS_VISORHBA=3Dm
> # CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
> # CONFIG_FB_TFT is not set
> # CONFIG_MOST_COMPONENTS is not set
> CONFIG_KS7010=3Dm
> CONFIG_GREYBUS_AUDIO=3Dm
> # CONFIG_GREYBUS_AUDIO_APB_CODEC is not set
> CONFIG_GREYBUS_BOOTROM=3Dm
> CONFIG_GREYBUS_FIRMWARE=3Dm
> CONFIG_GREYBUS_HID=3Dm
> CONFIG_GREYBUS_LIGHT=3Dm
> CONFIG_GREYBUS_LOG=3Dm
> CONFIG_GREYBUS_LOOPBACK=3Dm
> CONFIG_GREYBUS_POWER=3Dm
> CONFIG_GREYBUS_RAW=3Dm
> CONFIG_GREYBUS_VIBRATOR=3Dm
> CONFIG_GREYBUS_BRIDGED_PHY=3Dm
> CONFIG_GREYBUS_GPIO=3Dm
> CONFIG_GREYBUS_I2C=3Dm
> CONFIG_GREYBUS_PWM=3Dm
> CONFIG_GREYBUS_SDIO=3Dm
> CONFIG_GREYBUS_SPI=3Dm
> CONFIG_GREYBUS_UART=3Dm
> CONFIG_GREYBUS_USB=3Dm
> CONFIG_PI433=3Dm
> # CONFIG_XIL_AXIS_FIFO is not set
> # CONFIG_FIELDBUS_DEV is not set
> CONFIG_QLGE=3Dm
> # CONFIG_WFX is not set
> CONFIG_X86_PLATFORM_DEVICES=3Dy
> CONFIG_ACPI_WMI=3Dm
> CONFIG_WMI_BMOF=3Dm
> # CONFIG_HUAWEI_WMI is not set
> CONFIG_MXM_WMI=3Dm
> CONFIG_PEAQ_WMI=3Dm
> # CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
> # CONFIG_XIAOMI_WMI is not set
> # CONFIG_GIGABYTE_WMI is not set
> # CONFIG_YOGABOOK_WMI is not set
> CONFIG_ACERHDF=3Dm
> CONFIG_ACER_WIRELESS=3Dm
> CONFIG_ACER_WMI=3Dm
> # CONFIG_AMD_PMC is not set
> # CONFIG_AMD_HSMP is not set
> # CONFIG_ADV_SWBUTTON is not set
> CONFIG_APPLE_GMUX=3Dm
> CONFIG_ASUS_LAPTOP=3Dm
> CONFIG_ASUS_WIRELESS=3Dm
> CONFIG_ASUS_WMI=3Dm
> CONFIG_ASUS_NB_WMI=3Dm
> # CONFIG_ASUS_TF103C_DOCK is not set
> # CONFIG_MERAKI_MX100 is not set
> CONFIG_EEEPC_LAPTOP=3Dm
> CONFIG_EEEPC_WMI=3Dm
> # CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
> CONFIG_AMILO_RFKILL=3Dm
> CONFIG_FUJITSU_LAPTOP=3Dm
> CONFIG_FUJITSU_TABLET=3Dm
> CONFIG_GPD_POCKET_FAN=3Dm
> CONFIG_HP_ACCEL=3Dm
> # CONFIG_WIRELESS_HOTKEY is not set
> CONFIG_HP_WMI=3Dm
> CONFIG_IBM_RTL=3Dm
> CONFIG_IDEAPAD_LAPTOP=3Dm
> CONFIG_SENSORS_HDAPS=3Dm
> CONFIG_THINKPAD_ACPI=3Dm
> CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=3Dy
> CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=3Dy
> # CONFIG_THINKPAD_ACPI_DEBUG is not set
> # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
> CONFIG_THINKPAD_ACPI_VIDEO=3Dy
> CONFIG_THINKPAD_ACPI_HOTKEY_POLL=3Dy
> # CONFIG_THINKPAD_LMI is not set
> # CONFIG_INTEL_ATOMISP2_LED is not set
> # CONFIG_INTEL_ATOMISP2_PM is not set
> CONFIG_INTEL_IFS=3Dm
> # CONFIG_INTEL_SAR_INT1092 is not set
> # CONFIG_INTEL_SKL_INT3472 is not set
> CONFIG_INTEL_PMC_CORE=3Dy
> CONFIG_INTEL_PMT_CLASS=3Dm
> CONFIG_INTEL_PMT_TELEMETRY=3Dm
> CONFIG_INTEL_PMT_CRASHLOG=3Dm
> CONFIG_INTEL_PMT_WATCHER=3Dm
>=20
> #
> # Intel PnP excursion monitor
> #
> CONFIG_INTEL_TPMI_PEM=3Dm
> # end of Intel PnP excursion monitor
>=20
> #
> # Intel Speed Select Technology interface support
> #
> CONFIG_INTEL_SPEED_SELECT_TPMI=3Dm
> CONFIG_INTEL_SPEED_SELECT_INTERFACE=3Dm
> # end of Intel Speed Select Technology interface support
>=20
> # CONFIG_INTEL_TELEMETRY is not set
> CONFIG_INTEL_WMI=3Dy
> # CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
> CONFIG_INTEL_WMI_THUNDERBOLT=3Dm
>=20
> #
> # Intel Uncore Frequency Control
> #
> CONFIG_INTEL_UNCORE_FREQ_CONTROL_TPMI=3Dm
> CONFIG_INTEL_UNCORE_FREQ_CONTROL=3Dm
> # end of Intel Uncore Frequency Control
>=20
> CONFIG_INTEL_HID_EVENT=3Dm
> CONFIG_INTEL_VBTN=3Dm
> CONFIG_INTEL_INT0002_VGPIO=3Dm
> CONFIG_INTEL_OAKTRAIL=3Dm
> # CONFIG_INTEL_BXTWC_PMIC_TMU is not set
> CONFIG_INTEL_CHTDC_TI_PWRBTN=3Dm
> # CONFIG_INTEL_CHTWC_INT33FE is not set
> # CONFIG_INTEL_ISHTP_ECLITE is not set
> CONFIG_INTEL_PUNIT_IPC=3Dm
> CONFIG_INTEL_RST=3Dm
> CONFIG_INTEL_SDSI=3Dm
> CONFIG_INTEL_SMARTCONNECT=3Dm
> CONFIG_INTEL_HPM_DIE_MAP=3Dm
> CONFIG_INTEL_TPMI=3Dm
> CONFIG_INTEL_TURBO_MAX_3=3Dy
> CONFIG_INTEL_VSEC=3Dm
> CONFIG_MSI_LAPTOP=3Dm
> CONFIG_MSI_WMI=3Dm
> # CONFIG_PCENGINES_APU2 is not set
> # CONFIG_BARCO_P50_GPIO is not set
> CONFIG_SAMSUNG_LAPTOP=3Dm
> # CONFIG_SAMSUNG_Q10 is not set
> CONFIG_ACPI_TOSHIBA=3Dm
> CONFIG_TOSHIBA_BT_RFKILL=3Dm
> CONFIG_TOSHIBA_HAPS=3Dm
> # CONFIG_TOSHIBA_WMI is not set
> # CONFIG_ACPI_CMPC is not set
> CONFIG_COMPAL_LAPTOP=3Dm
> # CONFIG_LG_LAPTOP is not set
> CONFIG_PANASONIC_LAPTOP=3Dm
> CONFIG_SONY_LAPTOP=3Dm
> CONFIG_SONYPI_COMPAT=3Dy
> # CONFIG_SYSTEM76_ACPI is not set
> CONFIG_TOPSTAR_LAPTOP=3Dm
> # CONFIG_SERIAL_MULTI_INSTANTIATE is not set
> CONFIG_MLX_PLATFORM=3Dm
> # CONFIG_TOUCHSCREEN_DMI is not set
> # CONFIG_X86_ANDROID_TABLETS is not set
> CONFIG_INTEL_IPS=3Dm
> CONFIG_INTEL_SCU_IPC=3Dy
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> # CONFIG_SIEMENS_SIMATIC_IPC is not set
> CONFIG_PMC_ATOM=3Dy
> CONFIG_CHROME_PLATFORMS=3Dy
> CONFIG_CHROMEOS_LAPTOP=3Dm
> CONFIG_CHROMEOS_PSTORE=3Dm
> # CONFIG_CHROMEOS_TBMC is not set
> CONFIG_CROS_EC=3Dm
> # CONFIG_CROS_EC_I2C is not set
> # CONFIG_CROS_EC_RPMSG is not set
> # CONFIG_CROS_EC_ISHTP is not set
> # CONFIG_CROS_EC_SPI is not set
> CONFIG_CROS_EC_LPC=3Dm
> CONFIG_CROS_EC_PROTO=3Dy
> CONFIG_CROS_KBD_LED_BACKLIGHT=3Dm
> CONFIG_CROS_EC_CHARDEV=3Dm
> CONFIG_CROS_EC_LIGHTBAR=3Dm
> CONFIG_CROS_EC_VBC=3Dm
> CONFIG_CROS_EC_DEBUGFS=3Dm
> CONFIG_CROS_EC_SENSORHUB=3Dm
> CONFIG_CROS_EC_SYSFS=3Dm
> CONFIG_CROS_EC_TYPEC=3Dm
> CONFIG_CROS_USBPD_NOTIFY=3Dm
> # CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
> # CONFIG_WILCO_EC is not set
> CONFIG_MELLANOX_PLATFORM=3Dy
> CONFIG_MLXREG_HOTPLUG=3Dm
> # CONFIG_MLXREG_IO is not set
> # CONFIG_MLXREG_LC is not set
> CONFIG_SURFACE_PLATFORMS=3Dy
> CONFIG_SURFACE3_WMI=3Dm
> # CONFIG_SURFACE_3_POWER_OPREGION is not set
> # CONFIG_SURFACE_GPE is not set
> # CONFIG_SURFACE_HOTPLUG is not set
> CONFIG_SURFACE_PRO3_BUTTON=3Dm
> # CONFIG_SURFACE_AGGREGATOR is not set
> CONFIG_HAVE_CLK=3Dy
> CONFIG_HAVE_CLK_PREPARE=3Dy
> CONFIG_COMMON_CLK=3Dy
> CONFIG_COMMON_CLK_WM831X=3Dm
> # CONFIG_LMK04832 is not set
> # CONFIG_COMMON_CLK_MAX9485 is not set
> # CONFIG_COMMON_CLK_SI5341 is not set
> CONFIG_COMMON_CLK_SI5351=3Dm
> # CONFIG_COMMON_CLK_SI514 is not set
> # CONFIG_COMMON_CLK_SI544 is not set
> # CONFIG_COMMON_CLK_SI570 is not set
> CONFIG_COMMON_CLK_CDCE706=3Dm
> # CONFIG_COMMON_CLK_CDCE925 is not set
> CONFIG_COMMON_CLK_CS2000_CP=3Dm
> CONFIG_COMMON_CLK_S2MPS11=3Dm
> CONFIG_CLK_TWL6040=3Dm
> # CONFIG_COMMON_CLK_AXI_CLKGEN is not set
> CONFIG_COMMON_CLK_PALMAS=3Dm
> CONFIG_COMMON_CLK_PWM=3Dm
> # CONFIG_COMMON_CLK_RS9_PCIE is not set
> # CONFIG_COMMON_CLK_VC5 is not set
> # CONFIG_COMMON_CLK_FIXED_MMIO is not set
> # CONFIG_CLK_LGM_CGU is not set
> CONFIG_XILINX_VCU=3Dm
> CONFIG_HWSPINLOCK=3Dy
>=20
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=3Dy
> CONFIG_I8253_LOCK=3Dy
> CONFIG_CLKBLD_I8253=3Dy
> # CONFIG_MICROCHIP_PIT64B is not set
> # end of Clock Source drivers
>=20
> CONFIG_MAILBOX=3Dy
> # CONFIG_PLATFORM_MHU is not set
> CONFIG_PCC=3Dy
> CONFIG_ALTERA_MBOX=3Dm
> # CONFIG_MAILBOX_TEST is not set
> CONFIG_IOMMU_IOVA=3Dy
> CONFIG_IOASID=3Dy
> CONFIG_IOMMU_API=3Dy
> CONFIG_IOMMU_SUPPORT=3Dy
>=20
> #
> # Generic IOMMU Pagetable Support
> #
> CONFIG_IOMMU_IO_PGTABLE=3Dy
> # end of Generic IOMMU Pagetable Support
>=20
> CONFIG_IOMMU_DEBUGFS=3Dy
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> CONFIG_IOMMU_DEFAULT_DMA_LAZY=3Dy
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_OF_IOMMU=3Dy
> CONFIG_IOMMU_DMA=3Dy
> CONFIG_IOMMU_SVA=3Dy
> CONFIG_AMD_IOMMU=3Dy
> CONFIG_AMD_IOMMU_V2=3Dm
> # CONFIG_AMD_IOMMU_DEBUGFS is not set
> CONFIG_DMAR_TABLE=3Dy
> CONFIG_DMAR_PERF=3Dy
> CONFIG_DMAR_DEBUG=3Dy
> CONFIG_INTEL_IOMMU=3Dy
> CONFIG_INTEL_IOMMU_DEBUGFS=3Dy
> CONFIG_INTEL_IOMMU_SVM=3Dy
> CONFIG_INTEL_IOMMU_DEFAULT_ON=3Dy
> CONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy
> CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=3Dy
> CONFIG_INTEL_IOMMU_PERF_EVENTS=3Dy
> CONFIG_IRQ_REMAP=3Dy
> CONFIG_HYPERV_IOMMU=3Dy
> # CONFIG_VIRTIO_IOMMU is not set
>=20
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
>=20
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=3Dm
> CONFIG_RPMSG_CHAR=3Dm
> # CONFIG_RPMSG_CTRL is not set
> CONFIG_RPMSG_NS=3Dm
> CONFIG_RPMSG_QCOM_GLINK=3Dm
> CONFIG_RPMSG_QCOM_GLINK_RPM=3Dm
> CONFIG_RPMSG_VIRTIO=3Dm
> # end of Rpmsg drivers
>=20
> CONFIG_SOUNDWIRE=3Dm
>=20
> #
> # SoundWire Devices
> #
> CONFIG_SOUNDWIRE_CADENCE=3Dm
> CONFIG_SOUNDWIRE_INTEL=3Dm
> # CONFIG_SOUNDWIRE_QCOM is not set
> CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=3Dm
>=20
> #
> # SOC (System On Chip) specific Drivers
> #
>=20
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
>=20
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
>=20
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
>=20
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
>=20
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # CONFIG_LITEX_SOC_CONTROLLER is not set
> # end of Enable LiteX SoC Builder specific drivers
>=20
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
>=20
> CONFIG_SOC_TI=3Dy
>=20
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
>=20
> CONFIG_PM_DEVFREQ=3Dy
>=20
> #
> # DEVFREQ Governors
> #
> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=3Dy
> CONFIG_DEVFREQ_GOV_PERFORMANCE=3Dy
> CONFIG_DEVFREQ_GOV_POWERSAVE=3Dy
> CONFIG_DEVFREQ_GOV_USERSPACE=3Dy
> CONFIG_DEVFREQ_GOV_PASSIVE=3Dy
>=20
> #
> # DEVFREQ Drivers
> #
> CONFIG_PM_DEVFREQ_EVENT=3Dy
> CONFIG_EXTCON=3Dy
>=20
> #
> # Extcon Device Drivers
> #
> CONFIG_EXTCON_ADC_JACK=3Dm
> CONFIG_EXTCON_AXP288=3Dm
> # CONFIG_EXTCON_FSA9480 is not set
> CONFIG_EXTCON_GPIO=3Dm
> CONFIG_EXTCON_INTEL_INT3496=3Dm
> CONFIG_EXTCON_MAX14577=3Dm
> CONFIG_EXTCON_MAX3355=3Dm
> CONFIG_EXTCON_MAX77693=3Dm
> CONFIG_EXTCON_MAX77843=3Dm
> CONFIG_EXTCON_MAX8997=3Dm
> CONFIG_EXTCON_PALMAS=3Dm
> # CONFIG_EXTCON_PTN5150 is not set
> CONFIG_EXTCON_RT8973A=3Dm
> CONFIG_EXTCON_SM5502=3Dm
> CONFIG_EXTCON_USB_GPIO=3Dm
> CONFIG_EXTCON_USBC_CROS_EC=3Dm
> # CONFIG_EXTCON_USBC_TUSB320 is not set
> CONFIG_MEMORY=3Dy
> CONFIG_IIO=3Dm
> CONFIG_IIO_BUFFER=3Dy
> CONFIG_IIO_BUFFER_CB=3Dm
> # CONFIG_IIO_BUFFER_DMA is not set
> # CONFIG_IIO_BUFFER_DMAENGINE is not set
> CONFIG_IIO_BUFFER_HW_CONSUMER=3Dm
> CONFIG_IIO_KFIFO_BUF=3Dm
> CONFIG_IIO_TRIGGERED_BUFFER=3Dm
> CONFIG_IIO_CONFIGFS=3Dm
> CONFIG_IIO_TRIGGER=3Dy
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=3D2
> CONFIG_IIO_SW_DEVICE=3Dm
> CONFIG_IIO_SW_TRIGGER=3Dm
> CONFIG_IIO_TRIGGERED_EVENT=3Dm
>=20
> #
> # Accelerometers
> #
> CONFIG_ADIS16201=3Dm
> CONFIG_ADIS16209=3Dm
> # CONFIG_ADXL313_I2C is not set
> # CONFIG_ADXL313_SPI is not set
> # CONFIG_ADXL355_I2C is not set
> # CONFIG_ADXL355_SPI is not set
> # CONFIG_ADXL367_SPI is not set
> # CONFIG_ADXL367_I2C is not set
> # CONFIG_ADXL372_SPI is not set
> # CONFIG_ADXL372_I2C is not set
> CONFIG_BMA220=3Dm
> # CONFIG_BMA400 is not set
> CONFIG_BMC150_ACCEL=3Dm
> CONFIG_BMC150_ACCEL_I2C=3Dm
> CONFIG_BMC150_ACCEL_SPI=3Dm
> # CONFIG_BMI088_ACCEL is not set
> CONFIG_DA280=3Dm
> CONFIG_DA311=3Dm
> # CONFIG_DMARD06 is not set
> CONFIG_DMARD09=3Dm
> CONFIG_DMARD10=3Dm
> # CONFIG_FXLS8962AF_I2C is not set
> # CONFIG_FXLS8962AF_SPI is not set
> CONFIG_HID_SENSOR_ACCEL_3D=3Dm
> CONFIG_IIO_CROS_EC_ACCEL_LEGACY=3Dm
> CONFIG_IIO_ST_ACCEL_3AXIS=3Dm
> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=3Dm
> CONFIG_IIO_ST_ACCEL_SPI_3AXIS=3Dm
> CONFIG_KXSD9=3Dm
> CONFIG_KXSD9_SPI=3Dm
> CONFIG_KXSD9_I2C=3Dm
> CONFIG_KXCJK1013=3Dm
> CONFIG_MC3230=3Dm
> CONFIG_MMA7455=3Dm
> CONFIG_MMA7455_I2C=3Dm
> CONFIG_MMA7455_SPI=3Dm
> CONFIG_MMA7660=3Dm
> CONFIG_MMA8452=3Dm
> CONFIG_MMA9551_CORE=3Dm
> CONFIG_MMA9551=3Dm
> CONFIG_MMA9553=3Dm
> CONFIG_MXC4005=3Dm
> CONFIG_MXC6255=3Dm
> CONFIG_SCA3000=3Dm
> # CONFIG_SCA3300 is not set
> CONFIG_STK8312=3Dm
> CONFIG_STK8BA50=3Dm
> # end of Accelerometers
>=20
> #
> # Analog to digital converters
> #
> CONFIG_AD_SIGMA_DELTA=3Dm
> # CONFIG_AD7091R5 is not set
> # CONFIG_AD7124 is not set
> CONFIG_AD7192=3Dm
> CONFIG_AD7266=3Dm
> CONFIG_AD7280=3Dm
> CONFIG_AD7291=3Dm
> # CONFIG_AD7292 is not set
> CONFIG_AD7298=3Dm
> CONFIG_AD7476=3Dm
> CONFIG_AD7606=3Dm
> CONFIG_AD7606_IFACE_PARALLEL=3Dm
> CONFIG_AD7606_IFACE_SPI=3Dm
> CONFIG_AD7766=3Dm
> # CONFIG_AD7768_1 is not set
> CONFIG_AD7780=3Dm
> CONFIG_AD7791=3Dm
> CONFIG_AD7793=3Dm
> CONFIG_AD7887=3Dm
> CONFIG_AD7923=3Dm
> # CONFIG_AD7949 is not set
> CONFIG_AD799X=3Dm
> # CONFIG_ADI_AXI_ADC is not set
> CONFIG_AXP20X_ADC=3Dm
> CONFIG_AXP288_ADC=3Dm
> CONFIG_CC10001_ADC=3Dm
> CONFIG_DA9150_GPADC=3Dm
> CONFIG_DLN2_ADC=3Dm
> # CONFIG_ENVELOPE_DETECTOR is not set
> CONFIG_HI8435=3Dm
> CONFIG_HX711=3Dm
> CONFIG_INA2XX_ADC=3Dm
> CONFIG_LP8788_ADC=3Dm
> CONFIG_LTC2471=3Dm
> CONFIG_LTC2485=3Dm
> # CONFIG_LTC2496 is not set
> CONFIG_LTC2497=3Dm
> CONFIG_MAX1027=3Dm
> CONFIG_MAX11100=3Dm
> CONFIG_MAX1118=3Dm
> # CONFIG_MAX1241 is not set
> CONFIG_MAX1363=3Dm
> CONFIG_MAX9611=3Dm
> CONFIG_MCP320X=3Dm
> CONFIG_MCP3422=3Dm
> # CONFIG_MCP3911 is not set
> CONFIG_MEN_Z188_ADC=3Dm
> CONFIG_NAU7802=3Dm
> CONFIG_PALMAS_GPADC=3Dm
> CONFIG_QCOM_VADC_COMMON=3Dm
> CONFIG_QCOM_SPMI_IADC=3Dm
> CONFIG_QCOM_SPMI_VADC=3Dm
> # CONFIG_QCOM_SPMI_ADC5 is not set
> # CONFIG_SD_ADC_MODULATOR is not set
> CONFIG_STX104=3Dm
> CONFIG_TI_ADC081C=3Dm
> CONFIG_TI_ADC0832=3Dm
> CONFIG_TI_ADC084S021=3Dm
> CONFIG_TI_ADC12138=3Dm
> CONFIG_TI_ADC108S102=3Dm
> CONFIG_TI_ADC128S052=3Dm
> CONFIG_TI_ADC161S626=3Dm
> CONFIG_TI_ADS1015=3Dm
> CONFIG_TI_ADS7950=3Dm
> # CONFIG_TI_ADS8344 is not set
> # CONFIG_TI_ADS8688 is not set
> # CONFIG_TI_ADS124S08 is not set
> # CONFIG_TI_ADS131E08 is not set
> CONFIG_TI_AM335X_ADC=3Dm
> CONFIG_TI_TLC4541=3Dm
> # CONFIG_TI_TSC2046 is not set
> CONFIG_TWL4030_MADC=3Dm
> CONFIG_TWL6030_GPADC=3Dm
> # CONFIG_VF610_ADC is not set
> CONFIG_VIPERBOARD_ADC=3Dm
> # CONFIG_XILINX_XADC is not set
> # end of Analog to digital converters
>=20
> #
> # Analog to digital and digital to analog converters
> #
> # CONFIG_AD74413R is not set
> # end of Analog to digital and digital to analog converters
>=20
> #
> # Analog Front Ends
> #
> # CONFIG_IIO_RESCALE is not set
> # end of Analog Front Ends
>=20
> #
> # Amplifiers
> #
> CONFIG_AD8366=3Dm
> # CONFIG_ADA4250 is not set
> # CONFIG_HMC425 is not set
> # end of Amplifiers
>=20
> #
> # Capacitance to digital converters
> #
> CONFIG_AD7150=3Dm
> # end of Capacitance to digital converters
>=20
> #
> # Chemical Sensors
> #
> CONFIG_ATLAS_PH_SENSOR=3Dm
> # CONFIG_ATLAS_EZO_SENSOR is not set
> # CONFIG_BME680 is not set
> CONFIG_CCS811=3Dm
> CONFIG_IAQCORE=3Dm
> # CONFIG_PMS7003 is not set
> # CONFIG_SCD30_CORE is not set
> # CONFIG_SCD4X is not set
> # CONFIG_SENSIRION_SGP30 is not set
> # CONFIG_SENSIRION_SGP40 is not set
> # CONFIG_SPS30_I2C is not set
> # CONFIG_SPS30_SERIAL is not set
> # CONFIG_SENSEAIR_SUNRISE_CO2 is not set
> CONFIG_VZ89X=3Dm
> # end of Chemical Sensors
>=20
> CONFIG_IIO_CROS_EC_SENSORS_CORE=3Dm
> CONFIG_IIO_CROS_EC_SENSORS=3Dm
> # CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE is not set
>=20
> #
> # Hid Sensor IIO Common
> #
> CONFIG_HID_SENSOR_IIO_COMMON=3Dm
> CONFIG_HID_SENSOR_IIO_TRIGGER=3Dm
> # end of Hid Sensor IIO Common
>=20
> CONFIG_IIO_MS_SENSORS_I2C=3Dm
>=20
> #
> # IIO SCMI Sensors
> #
> # end of IIO SCMI Sensors
>=20
> #
> # SSP Sensor Common
> #
> CONFIG_IIO_SSP_SENSORS_COMMONS=3Dm
> CONFIG_IIO_SSP_SENSORHUB=3Dm
> # end of SSP Sensor Common
>=20
> CONFIG_IIO_ST_SENSORS_I2C=3Dm
> CONFIG_IIO_ST_SENSORS_SPI=3Dm
> CONFIG_IIO_ST_SENSORS_CORE=3Dm
>=20
> #
> # Digital to analog converters
> #
> # CONFIG_AD3552R is not set
> CONFIG_AD5064=3Dm
> CONFIG_AD5360=3Dm
> CONFIG_AD5380=3Dm
> CONFIG_AD5421=3Dm
> CONFIG_AD5446=3Dm
> CONFIG_AD5449=3Dm
> CONFIG_AD5592R_BASE=3Dm
> CONFIG_AD5592R=3Dm
> CONFIG_AD5593R=3Dm
> CONFIG_AD5504=3Dm
> CONFIG_AD5624R_SPI=3Dm
> # CONFIG_LTC2688 is not set
> # CONFIG_AD5686_SPI is not set
> # CONFIG_AD5696_I2C is not set
> CONFIG_AD5755=3Dm
> # CONFIG_AD5758 is not set
> CONFIG_AD5761=3Dm
> CONFIG_AD5764=3Dm
> # CONFIG_AD5766 is not set
> # CONFIG_AD5770R is not set
> CONFIG_AD5791=3Dm
> # CONFIG_AD7293 is not set
> CONFIG_AD7303=3Dm
> CONFIG_AD8801=3Dm
> CONFIG_CIO_DAC=3Dm
> # CONFIG_DPOT_DAC is not set
> CONFIG_DS4424=3Dm
> # CONFIG_LTC1660 is not set
> CONFIG_LTC2632=3Dm
> CONFIG_M62332=3Dm
> CONFIG_MAX517=3Dm
> # CONFIG_MAX5821 is not set
> CONFIG_MCP4725=3Dm
> CONFIG_MCP4922=3Dm
> CONFIG_TI_DAC082S085=3Dm
> # CONFIG_TI_DAC5571 is not set
> # CONFIG_TI_DAC7311 is not set
> # CONFIG_TI_DAC7612 is not set
> # CONFIG_VF610_DAC is not set
> # end of Digital to analog converters
>=20
> #
> # IIO dummy driver
> #
> CONFIG_IIO_SIMPLE_DUMMY=3Dm
> # CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
> # CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
> # end of IIO dummy driver
>=20
> #
> # Filters
> #
> # CONFIG_ADMV8818 is not set
> # end of Filters
>=20
> #
> # Frequency Synthesizers DDS/PLL
> #
>=20
> #
> # Clock Generator/Distribution
> #
> CONFIG_AD9523=3Dm
> # end of Clock Generator/Distribution
>=20
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> CONFIG_ADF4350=3Dm
> # CONFIG_ADF4371 is not set
> # CONFIG_ADMV1013 is not set
> # CONFIG_ADMV1014 is not set
> # CONFIG_ADMV4420 is not set
> # CONFIG_ADRF6780 is not set
> # end of Phase-Locked Loop (PLL) frequency synthesizers
> # end of Frequency Synthesizers DDS/PLL
>=20
> #
> # Digital gyroscope sensors
> #
> CONFIG_ADIS16080=3Dm
> CONFIG_ADIS16130=3Dm
> CONFIG_ADIS16136=3Dm
> CONFIG_ADIS16260=3Dm
> # CONFIG_ADXRS290 is not set
> CONFIG_ADXRS450=3Dm
> CONFIG_BMG160=3Dm
> CONFIG_BMG160_I2C=3Dm
> CONFIG_BMG160_SPI=3Dm
> # CONFIG_FXAS21002C is not set
> CONFIG_HID_SENSOR_GYRO_3D=3Dm
> CONFIG_MPU3050=3Dm
> CONFIG_MPU3050_I2C=3Dm
> CONFIG_IIO_ST_GYRO_3AXIS=3Dm
> CONFIG_IIO_ST_GYRO_I2C_3AXIS=3Dm
> CONFIG_IIO_ST_GYRO_SPI_3AXIS=3Dm
> CONFIG_ITG3200=3Dm
> # end of Digital gyroscope sensors
>=20
> #
> # Health Sensors
> #
>=20
> #
> # Heart Rate Monitors
> #
> CONFIG_AFE4403=3Dm
> CONFIG_AFE4404=3Dm
> CONFIG_MAX30100=3Dm
> CONFIG_MAX30102=3Dm
> # end of Heart Rate Monitors
> # end of Health Sensors
>=20
> #
> # Humidity sensors
> #
> CONFIG_AM2315=3Dm
> CONFIG_DHT11=3Dm
> CONFIG_HDC100X=3Dm
> # CONFIG_HDC2010 is not set
> CONFIG_HID_SENSOR_HUMIDITY=3Dm
> CONFIG_HTS221=3Dm
> CONFIG_HTS221_I2C=3Dm
> CONFIG_HTS221_SPI=3Dm
> CONFIG_HTU21=3Dm
> CONFIG_SI7005=3Dm
> CONFIG_SI7020=3Dm
> # end of Humidity sensors
>=20
> #
> # Inertial measurement units
> #
> CONFIG_ADIS16400=3Dm
> # CONFIG_ADIS16460 is not set
> # CONFIG_ADIS16475 is not set
> CONFIG_ADIS16480=3Dm
> CONFIG_BMI160=3Dm
> CONFIG_BMI160_I2C=3Dm
> CONFIG_BMI160_SPI=3Dm
> # CONFIG_FXOS8700_I2C is not set
> # CONFIG_FXOS8700_SPI is not set
> CONFIG_KMX61=3Dm
> # CONFIG_INV_ICM42600_I2C is not set
> # CONFIG_INV_ICM42600_SPI is not set
> CONFIG_INV_MPU6050_IIO=3Dm
> CONFIG_INV_MPU6050_I2C=3Dm
> CONFIG_INV_MPU6050_SPI=3Dm
> CONFIG_IIO_ST_LSM6DSX=3Dm
> CONFIG_IIO_ST_LSM6DSX_I2C=3Dm
> CONFIG_IIO_ST_LSM6DSX_SPI=3Dm
> # CONFIG_IIO_ST_LSM9DS0 is not set
> # end of Inertial measurement units
>=20
> CONFIG_IIO_ADIS_LIB=3Dm
> CONFIG_IIO_ADIS_LIB_BUFFER=3Dy
>=20
> #
> # Light sensors
> #
> CONFIG_ACPI_ALS=3Dm
> CONFIG_ADJD_S311=3Dm
> # CONFIG_ADUX1020 is not set
> # CONFIG_AL3010 is not set
> CONFIG_AL3320A=3Dm
> CONFIG_APDS9300=3Dm
> CONFIG_APDS9960=3Dm
> # CONFIG_AS73211 is not set
> CONFIG_BH1750=3Dm
> CONFIG_BH1780=3Dm
> CONFIG_CM32181=3Dm
> CONFIG_CM3232=3Dm
> CONFIG_CM3323=3Dm
> # CONFIG_CM3605 is not set
> CONFIG_CM36651=3Dm
> CONFIG_IIO_CROS_EC_LIGHT_PROX=3Dm
> # CONFIG_GP2AP002 is not set
> CONFIG_GP2AP020A00F=3Dm
> CONFIG_SENSORS_ISL29018=3Dm
> CONFIG_SENSORS_ISL29028=3Dm
> CONFIG_ISL29125=3Dm
> CONFIG_HID_SENSOR_ALS=3Dm
> CONFIG_HID_SENSOR_PROX=3Dm
> CONFIG_JSA1212=3Dm
> CONFIG_RPR0521=3Dm
> CONFIG_SENSORS_LM3533=3Dm
> CONFIG_LTR501=3Dm
> # CONFIG_LV0104CS is not set
> CONFIG_MAX44000=3Dm
> # CONFIG_MAX44009 is not set
> # CONFIG_NOA1305 is not set
> CONFIG_OPT3001=3Dm
> CONFIG_PA12203001=3Dm
> # CONFIG_SI1133 is not set
> CONFIG_SI1145=3Dm
> CONFIG_STK3310=3Dm
> CONFIG_ST_UVIS25=3Dm
> CONFIG_ST_UVIS25_I2C=3Dm
> CONFIG_ST_UVIS25_SPI=3Dm
> CONFIG_TCS3414=3Dm
> CONFIG_TCS3472=3Dm
> CONFIG_SENSORS_TSL2563=3Dm
> CONFIG_TSL2583=3Dm
> # CONFIG_TSL2591 is not set
> # CONFIG_TSL2772 is not set
> CONFIG_TSL4531=3Dm
> CONFIG_US5182D=3Dm
> CONFIG_VCNL4000=3Dm
> # CONFIG_VCNL4035 is not set
> # CONFIG_VEML6030 is not set
> CONFIG_VEML6070=3Dm
> CONFIG_VL6180=3Dm
> CONFIG_ZOPT2201=3Dm
> # end of Light sensors
>=20
> #
> # Magnetometer sensors
> #
> # CONFIG_AK8974 is not set
> CONFIG_AK8975=3Dm
> CONFIG_AK09911=3Dm
> CONFIG_BMC150_MAGN=3Dm
> CONFIG_BMC150_MAGN_I2C=3Dm
> CONFIG_BMC150_MAGN_SPI=3Dm
> CONFIG_MAG3110=3Dm
> CONFIG_HID_SENSOR_MAGNETOMETER_3D=3Dm
> CONFIG_MMC35240=3Dm
> CONFIG_IIO_ST_MAGN_3AXIS=3Dm
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=3Dm
> CONFIG_IIO_ST_MAGN_SPI_3AXIS=3Dm
> CONFIG_SENSORS_HMC5843=3Dm
> CONFIG_SENSORS_HMC5843_I2C=3Dm
> CONFIG_SENSORS_HMC5843_SPI=3Dm
> # CONFIG_SENSORS_RM3100_I2C is not set
> # CONFIG_SENSORS_RM3100_SPI is not set
> # CONFIG_YAMAHA_YAS530 is not set
> # end of Magnetometer sensors
>=20
> #
> # Multiplexers
> #
> # CONFIG_IIO_MUX is not set
> # end of Multiplexers
>=20
> #
> # Inclinometer sensors
> #
> CONFIG_HID_SENSOR_INCLINOMETER_3D=3Dm
> CONFIG_HID_SENSOR_DEVICE_ROTATION=3Dm
> # end of Inclinometer sensors
>=20
> #
> # Triggers - standalone
> #
> CONFIG_IIO_HRTIMER_TRIGGER=3Dm
> CONFIG_IIO_INTERRUPT_TRIGGER=3Dm
> CONFIG_IIO_TIGHTLOOP_TRIGGER=3Dm
> CONFIG_IIO_SYSFS_TRIGGER=3Dm
> # end of Triggers - standalone
>=20
> #
> # Linear and angular position sensors
> #
> # CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE is not set
> # end of Linear and angular position sensors
>=20
> #
> # Digital potentiometers
> #
> # CONFIG_AD5110 is not set
> # CONFIG_AD5272 is not set
> CONFIG_DS1803=3Dm
> # CONFIG_MAX5432 is not set
> CONFIG_MAX5481=3Dm
> CONFIG_MAX5487=3Dm
> # CONFIG_MCP4018 is not set
> CONFIG_MCP4131=3Dm
> CONFIG_MCP4531=3Dm
> # CONFIG_MCP41010 is not set
> CONFIG_TPL0102=3Dm
> # end of Digital potentiometers
>=20
> #
> # Digital potentiostats
> #
> CONFIG_LMP91000=3Dm
> # end of Digital potentiostats
>=20
> #
> # Pressure sensors
> #
> CONFIG_ABP060MG=3Dm
> CONFIG_BMP280=3Dm
> CONFIG_BMP280_I2C=3Dm
> CONFIG_BMP280_SPI=3Dm
> CONFIG_IIO_CROS_EC_BARO=3Dm
> # CONFIG_DLHL60D is not set
> # CONFIG_DPS310 is not set
> CONFIG_HID_SENSOR_PRESS=3Dm
> CONFIG_HP03=3Dm
> # CONFIG_ICP10100 is not set
> CONFIG_MPL115=3Dm
> CONFIG_MPL115_I2C=3Dm
> CONFIG_MPL115_SPI=3Dm
> CONFIG_MPL3115=3Dm
> CONFIG_MS5611=3Dm
> CONFIG_MS5611_I2C=3Dm
> CONFIG_MS5611_SPI=3Dm
> CONFIG_MS5637=3Dm
> CONFIG_IIO_ST_PRESS=3Dm
> CONFIG_IIO_ST_PRESS_I2C=3Dm
> CONFIG_IIO_ST_PRESS_SPI=3Dm
> CONFIG_T5403=3Dm
> CONFIG_HP206C=3Dm
> CONFIG_ZPA2326=3Dm
> CONFIG_ZPA2326_I2C=3Dm
> CONFIG_ZPA2326_SPI=3Dm
> # end of Pressure sensors
>=20
> #
> # Lightning sensors
> #
> CONFIG_AS3935=3Dm
> # end of Lightning sensors
>=20
> #
> # Proximity and distance sensors
> #
> # CONFIG_CROS_EC_MKBP_PROXIMITY is not set
> # CONFIG_ISL29501 is not set
> CONFIG_LIDAR_LITE_V2=3Dm
> # CONFIG_MB1232 is not set
> # CONFIG_PING is not set
> CONFIG_RFD77402=3Dm
> CONFIG_SRF04=3Dm
> # CONFIG_SX9310 is not set
> # CONFIG_SX9324 is not set
> # CONFIG_SX9360 is not set
> CONFIG_SX9500=3Dm
> CONFIG_SRF08=3Dm
> # CONFIG_VCNL3020 is not set
> # CONFIG_VL53L0X_I2C is not set
> # end of Proximity and distance sensors
>=20
> #
> # Resolver to digital converters
> #
> CONFIG_AD2S90=3Dm
> CONFIG_AD2S1200=3Dm
> # end of Resolver to digital converters
>=20
> #
> # Temperature sensors
> #
> # CONFIG_LTC2983 is not set
> CONFIG_MAXIM_THERMOCOUPLE=3Dm
> CONFIG_HID_SENSOR_TEMP=3Dm
> CONFIG_MLX90614=3Dm
> # CONFIG_MLX90632 is not set
> CONFIG_TMP006=3Dm
> CONFIG_TMP007=3Dm
> # CONFIG_TMP117 is not set
> CONFIG_TSYS01=3Dm
> CONFIG_TSYS02D=3Dm
> # CONFIG_MAX31856 is not set
> # CONFIG_MAX31865 is not set
> # end of Temperature sensors
>=20
> CONFIG_NTB=3Dm
> # CONFIG_NTB_MSI is not set
> # CONFIG_NTB_AMD is not set
> CONFIG_NTB_IDT=3Dm
> CONFIG_NTB_INTEL=3Dm
> # CONFIG_NTB_EPF is not set
> CONFIG_NTB_SWITCHTEC=3Dm
> CONFIG_NTB_PINGPONG=3Dm
> CONFIG_NTB_TOOL=3Dm
> CONFIG_NTB_PERF=3Dm
> CONFIG_NTB_TRANSPORT=3Dm
> CONFIG_VME_BUS=3Dy
>=20
> #
> # VME Bridge Drivers
> #
> CONFIG_VME_CA91CX42=3Dm
> CONFIG_VME_TSI148=3Dm
> CONFIG_VME_FAKE=3Dm
>=20
> #
> # VME Board Drivers
> #
> CONFIG_VMIVME_7805=3Dm
>=20
> #
> # VME Device Drivers
> #
> CONFIG_VME_USER=3Dm
> CONFIG_PWM=3Dy
> CONFIG_PWM_SYSFS=3Dy
> # CONFIG_PWM_DEBUG is not set
> # CONFIG_PWM_ATMEL_TCB is not set
> # CONFIG_PWM_CRC is not set
> CONFIG_PWM_CROS_EC=3Dm
> CONFIG_PWM_DWC=3Dm
> # CONFIG_PWM_FSL_FTM is not set
> # CONFIG_PWM_INTEL_LGM is not set
> CONFIG_PWM_LP3943=3Dm
> CONFIG_PWM_LPSS=3Dm
> CONFIG_PWM_LPSS_PCI=3Dm
> CONFIG_PWM_LPSS_PLATFORM=3Dm
> CONFIG_PWM_PCA9685=3Dm
> CONFIG_PWM_TWL=3Dm
> CONFIG_PWM_TWL_LED=3Dm
>=20
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=3Dy
> # CONFIG_AL_FIC is not set
> # end of IRQ chip support
>=20
> CONFIG_IPACK_BUS=3Dm
> CONFIG_BOARD_TPCI200=3Dm
> CONFIG_SERIAL_IPOCTAL=3Dm
> CONFIG_RESET_CONTROLLER=3Dy
> # CONFIG_RESET_INTEL_GW is not set
> CONFIG_RESET_TI_SYSCON=3Dm
>=20
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=3Dy
> # CONFIG_USB_LGM_PHY is not set
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
>=20
> #
> # PHY drivers for Broadcom platforms
> #
> CONFIG_BCM_KONA_USB2_PHY=3Dm
> # end of PHY drivers for Broadcom platforms
>=20
> # CONFIG_PHY_CADENCE_TORRENT is not set
> # CONFIG_PHY_CADENCE_DPHY is not set
> # CONFIG_PHY_CADENCE_DPHY_RX is not set
> # CONFIG_PHY_CADENCE_SIERRA is not set
> # CONFIG_PHY_CADENCE_SALVO is not set
> CONFIG_PHY_PXA_28NM_HSIC=3Dm
> CONFIG_PHY_PXA_28NM_USB2=3Dm
> # CONFIG_PHY_LAN966X_SERDES is not set
> CONFIG_PHY_CPCAP_USB=3Dm
> # CONFIG_PHY_MAPPHONE_MDM6600 is not set
> # CONFIG_PHY_OCELOT_SERDES is not set
> CONFIG_PHY_QCOM_USB_HS=3Dm
> CONFIG_PHY_QCOM_USB_HSIC=3Dm
> CONFIG_PHY_SAMSUNG_USB2=3Dm
> CONFIG_PHY_TUSB1210=3Dm
> # CONFIG_PHY_INTEL_LGM_COMBO is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # end of PHY Subsystem
>=20
> CONFIG_POWERCAP=3Dy
> CONFIG_INTEL_RAPL_CORE=3Dm
> CONFIG_INTEL_RAPL=3Dm
> # CONFIG_INTEL_RAPL_TPMI is not set
> CONFIG_IDLE_INJECT=3Dy
> # CONFIG_DTPM is not set
> CONFIG_MCB=3Dm
> CONFIG_MCB_PCI=3Dm
> CONFIG_MCB_LPC=3Dm
>=20
> #
> # Performance monitor support
> #
> # end of Performance monitor support
>=20
> CONFIG_RAS=3Dy
> CONFIG_RAS_CEC=3Dy
> # CONFIG_RAS_CEC_DEBUG is not set
> CONFIG_USB4=3Dm
> # CONFIG_USB4_DEBUGFS_WRITE is not set
> # CONFIG_USB4_DMA_TEST is not set
>=20
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> # end of Android
>=20
> CONFIG_LIBNVDIMM=3Dy
> CONFIG_BLK_DEV_PMEM=3Dm
> CONFIG_ND_CLAIM=3Dy
> CONFIG_ND_BTT=3Dm
> CONFIG_BTT=3Dy
> CONFIG_ND_PFN=3Dm
> CONFIG_NVDIMM_PFN=3Dy
> CONFIG_NVDIMM_DAX=3Dy
> CONFIG_OF_PMEM=3Dm
> CONFIG_NVDIMM_KEYS=3Dy
> CONFIG_DAX=3Dy
> CONFIG_DEV_DAX=3Dm
> CONFIG_DEV_DAX_PMEM=3Dm
> CONFIG_DEV_DAX_HMEM=3Dm
> CONFIG_DEV_DAX_HMEM_DEVICES=3Dy
> CONFIG_DEV_DAX_KMEM=3Dm
> CONFIG_NVMEM=3Dy
> CONFIG_NVMEM_SYSFS=3Dy
> # CONFIG_NVMEM_SPMI_SDAM is not set
> # CONFIG_RAVE_SP_EEPROM is not set
> # CONFIG_NVMEM_RMEM is not set
>=20
> #
> # HW tracing support
> #
> CONFIG_STM=3Dm
> CONFIG_STM_PROTO_BASIC=3Dm
> CONFIG_STM_PROTO_SYS_T=3Dm
> CONFIG_STM_DUMMY=3Dm
> CONFIG_STM_SOURCE_CONSOLE=3Dm
> CONFIG_STM_SOURCE_HEARTBEAT=3Dm
> CONFIG_STM_SOURCE_FTRACE=3Dm
> CONFIG_INTEL_TH=3Dm
> CONFIG_INTEL_TH_PCI=3Dm
> CONFIG_INTEL_TH_ACPI=3Dm
> CONFIG_INTEL_TH_GTH=3Dm
> CONFIG_INTEL_TH_STH=3Dm
> CONFIG_INTEL_TH_MSU=3Dm
> CONFIG_INTEL_TH_PTI=3Dm
> # CONFIG_INTEL_TH_DEBUG is not set
> # end of HW tracing support
>=20
> CONFIG_FPGA=3Dm
> CONFIG_ALTERA_PR_IP_CORE=3Dm
> # CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
> CONFIG_FPGA_MGR_ALTERA_PS_SPI=3Dm
> CONFIG_FPGA_MGR_ALTERA_CVP=3Dm
> CONFIG_FPGA_MGR_XILINX_SPI=3Dm
> # CONFIG_FPGA_MGR_ICE40_SPI is not set
> # CONFIG_FPGA_MGR_MACHXO2_SPI is not set
> CONFIG_FPGA_BRIDGE=3Dm
> # CONFIG_ALTERA_FREEZE_BRIDGE is not set
> CONFIG_XILINX_PR_DECOUPLER=3Dm
> CONFIG_FPGA_REGION=3Dm
> # CONFIG_OF_FPGA_REGION is not set
> # CONFIG_FPGA_DFL is not set
> # CONFIG_FSI is not set
> # CONFIG_TEE is not set
> CONFIG_PM_OPP=3Dy
> CONFIG_UNISYS_VISORBUS=3Dm
> CONFIG_SIOX=3Dm
> CONFIG_SIOX_BUS_GPIO=3Dm
> CONFIG_SLIMBUS=3Dm
> CONFIG_SLIM_QCOM_CTRL=3Dm
> # CONFIG_INTERCONNECT is not set
> CONFIG_COUNTER=3Dy
> # CONFIG_104_QUAD_8 is not set
> # CONFIG_INTERRUPT_CNT is not set
> # CONFIG_FTM_QUADDEC is not set
> # CONFIG_MICROCHIP_TCB_CAPTURE is not set
> CONFIG_INTEL_QEP=3Dy
> CONFIG_MOST=3Dm
> # CONFIG_MOST_USB_HDM is not set
> # CONFIG_MOST_CDEV is not set
> # CONFIG_MOST_SND is not set
> # CONFIG_PECI is not set
> # end of Device Drivers
>=20
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=3Dy
> CONFIG_VALIDATE_FS_PARSER=3Dy
> CONFIG_FS_IOMAP=3Dy
> # CONFIG_EXT2_FS is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=3Dy
> CONFIG_EXT4_USE_FOR_EXT2=3Dy
> CONFIG_EXT4_FS_POSIX_ACL=3Dy
> CONFIG_EXT4_FS_SECURITY=3Dy
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=3Dy
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=3Dy
> CONFIG_REISERFS_FS=3Dm
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> CONFIG_REISERFS_FS_XATTR=3Dy
> CONFIG_REISERFS_FS_POSIX_ACL=3Dy
> CONFIG_REISERFS_FS_SECURITY=3Dy
> CONFIG_JFS_FS=3Dm
> CONFIG_JFS_POSIX_ACL=3Dy
> CONFIG_JFS_SECURITY=3Dy
> # CONFIG_JFS_DEBUG is not set
> CONFIG_JFS_STATISTICS=3Dy
> CONFIG_XFS_FS=3Dy
> CONFIG_XFS_SUPPORT_V4=3Dy
> CONFIG_XFS_QUOTA=3Dy
> CONFIG_XFS_POSIX_ACL=3Dy
> CONFIG_XFS_RT=3Dy
> # CONFIG_XFS_ONLINE_SCRUB is not set
> # CONFIG_XFS_WARN is not set
> # CONFIG_XFS_DEBUG is not set
> CONFIG_GFS2_FS=3Dm
> CONFIG_GFS2_FS_LOCKING_DLM=3Dy
> CONFIG_OCFS2_FS=3Dm
> CONFIG_OCFS2_FS_O2CB=3Dm
> CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dm
> CONFIG_OCFS2_FS_STATS=3Dy
> CONFIG_OCFS2_DEBUG_MASKLOG=3Dy
> # CONFIG_OCFS2_DEBUG_FS is not set
> CONFIG_BTRFS_FS=3Dm
> CONFIG_BTRFS_FS_POSIX_ACL=3Dy
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> CONFIG_NILFS2_FS=3Dm
> CONFIG_F2FS_FS=3Dm
> CONFIG_F2FS_STAT_FS=3Dy
> CONFIG_F2FS_FS_XATTR=3Dy
> CONFIG_F2FS_FS_POSIX_ACL=3Dy
> CONFIG_F2FS_FS_SECURITY=3Dy
> # CONFIG_F2FS_CHECK_FS is not set
> # CONFIG_F2FS_FAULT_INJECTION is not set
> # CONFIG_F2FS_FS_COMPRESSION is not set
> CONFIG_F2FS_IOSTAT=3Dy
> # CONFIG_F2FS_UNFAIR_RWSEM is not set
> # CONFIG_ZONEFS_FS is not set
> CONFIG_FS_DAX=3Dy
> CONFIG_FS_DAX_PMD=3Dy
> CONFIG_FS_POSIX_ACL=3Dy
> CONFIG_EXPORTFS=3Dy
> CONFIG_EXPORTFS_BLOCK_OPS=3Dy
> CONFIG_FILE_LOCKING=3Dy
> CONFIG_FS_ENCRYPTION=3Dy
> CONFIG_FS_ENCRYPTION_ALGS=3Dy
> CONFIG_FS_ENCRYPTION_INLINE_CRYPT=3Dy
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=3Dy
> CONFIG_DNOTIFY=3Dy
> CONFIG_INOTIFY_USER=3Dy
> CONFIG_FANOTIFY=3Dy
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
> CONFIG_QUOTA=3Dy
> CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
> # CONFIG_PRINT_QUOTA_WARNING is not set
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=3Dy
> CONFIG_QFMT_V1=3Dm
> CONFIG_QFMT_V2=3Dy
> CONFIG_QUOTACTL=3Dy
> CONFIG_AUTOFS4_FS=3Dy
> CONFIG_AUTOFS_FS=3Dy
> CONFIG_FUSE_FS=3Dy
> CONFIG_CUSE=3Dm
> CONFIG_VIRTIO_FS=3Dy
> CONFIG_FUSE_DAX=3Dy
> CONFIG_OVERLAY_FS=3Dm
> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=3Dy
> # CONFIG_OVERLAY_FS_INDEX is not set
> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> # CONFIG_OVERLAY_FS_METACOPY is not set
>=20
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=3Dy
> CONFIG_NETFS_STATS=3Dy
> CONFIG_FSCACHE=3Dm
> CONFIG_FSCACHE_STATS=3Dy
> # CONFIG_FSCACHE_DEBUG is not set
> CONFIG_CACHEFILES=3Dm
> # CONFIG_CACHEFILES_DEBUG is not set
> # CONFIG_CACHEFILES_ERROR_INJECTION is not set
> # end of Caches
>=20
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=3Dm
> CONFIG_JOLIET=3Dy
> CONFIG_ZISOFS=3Dy
> CONFIG_UDF_FS=3Dm
> # end of CD-ROM/DVD Filesystems
>=20
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=3Dy
> CONFIG_MSDOS_FS=3Dm
> CONFIG_VFAT_FS=3Dy
> CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> # CONFIG_EXFAT_FS is not set
> CONFIG_NTFS_FS=3Dm
> # CONFIG_NTFS_DEBUG is not set
> # CONFIG_NTFS_RW is not set
> # CONFIG_NTFS3_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
>=20
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_KCORE=3Dy
> CONFIG_PROC_VMCORE=3Dy
> CONFIG_PROC_VMCORE_DEVICE_DUMP=3Dy
> CONFIG_PROC_SYSCTL=3Dy
> CONFIG_PROC_PAGE_MONITOR=3Dy
> CONFIG_PROC_CHILDREN=3Dy
> CONFIG_PROC_PID_ARCH_STATUS=3Dy
> CONFIG_PROC_CPU_RESCTRL=3Dy
> CONFIG_KERNFS=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> CONFIG_TMPFS_POSIX_ACL=3Dy
> CONFIG_TMPFS_XATTR=3Dy
> # CONFIG_TMPFS_INODE64 is not set
> CONFIG_HUGETLBFS=3Dy
> CONFIG_HUGETLB_PAGE=3Dy
> CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=3Dy
> # CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
> CONFIG_MEMFD_CREATE=3Dy
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy
> CONFIG_CONFIGFS_FS=3Dy
> CONFIG_EFIVAR_FS=3Dy
> # end of Pseudo filesystems
>=20
> CONFIG_MISC_FILESYSTEMS=3Dy
> CONFIG_ORANGEFS_FS=3Dm
> CONFIG_ADFS_FS=3Dm
> # CONFIG_ADFS_FS_RW is not set
> CONFIG_AFFS_FS=3Dm
> CONFIG_ECRYPT_FS=3Dy
> CONFIG_ECRYPT_FS_MESSAGING=3Dy
> CONFIG_HFS_FS=3Dm
> CONFIG_HFSPLUS_FS=3Dm
> CONFIG_BEFS_FS=3Dm
> # CONFIG_BEFS_DEBUG is not set
> CONFIG_BFS_FS=3Dm
> CONFIG_EFS_FS=3Dm
> CONFIG_JFFS2_FS=3Dm
> CONFIG_JFFS2_FS_DEBUG=3D0
> CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
> # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
> # CONFIG_JFFS2_SUMMARY is not set
> CONFIG_JFFS2_FS_XATTR=3Dy
> CONFIG_JFFS2_FS_POSIX_ACL=3Dy
> CONFIG_JFFS2_FS_SECURITY=3Dy
> CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy
> CONFIG_JFFS2_ZLIB=3Dy
> CONFIG_JFFS2_LZO=3Dy
> CONFIG_JFFS2_RTIME=3Dy
> # CONFIG_JFFS2_RUBIN is not set
> # CONFIG_JFFS2_CMODE_NONE is not set
> # CONFIG_JFFS2_CMODE_PRIORITY is not set
> # CONFIG_JFFS2_CMODE_SIZE is not set
> CONFIG_JFFS2_CMODE_FAVOURLZO=3Dy
> CONFIG_UBIFS_FS=3Dm
> # CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
> CONFIG_UBIFS_FS_LZO=3Dy
> CONFIG_UBIFS_FS_ZLIB=3Dy
> CONFIG_UBIFS_FS_ZSTD=3Dy
> # CONFIG_UBIFS_ATIME_SUPPORT is not set
> CONFIG_UBIFS_FS_XATTR=3Dy
> CONFIG_UBIFS_FS_SECURITY=3Dy
> # CONFIG_UBIFS_FS_AUTHENTICATION is not set
> CONFIG_CRAMFS=3Dm
> CONFIG_CRAMFS_BLOCKDEV=3Dy
> CONFIG_CRAMFS_MTD=3Dy
> CONFIG_SQUASHFS=3Dy
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=3Dy
> CONFIG_SQUASHFS_DECOMP_SINGLE=3Dy
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=3Dy
> CONFIG_SQUASHFS_ZLIB=3Dy
> CONFIG_SQUASHFS_LZ4=3Dy
> CONFIG_SQUASHFS_LZO=3Dy
> CONFIG_SQUASHFS_XZ=3Dy
> CONFIG_SQUASHFS_ZSTD=3Dy
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
> CONFIG_VXFS_FS=3Dm
> CONFIG_MINIX_FS=3Dm
> CONFIG_OMFS_FS=3Dm
> CONFIG_HPFS_FS=3Dm
> CONFIG_QNX4FS_FS=3Dm
> CONFIG_QNX6FS_FS=3Dm
> # CONFIG_QNX6FS_DEBUG is not set
> CONFIG_ROMFS_FS=3Dm
> CONFIG_ROMFS_BACKED_BY_BLOCK=3Dy
> # CONFIG_ROMFS_BACKED_BY_MTD is not set
> # CONFIG_ROMFS_BACKED_BY_BOTH is not set
> CONFIG_ROMFS_ON_BLOCK=3Dy
> CONFIG_PSTORE=3Dy
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=3D10240
> CONFIG_PSTORE_DEFLATE_COMPRESS=3Dy
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> # CONFIG_PSTORE_842_COMPRESS is not set
> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> CONFIG_PSTORE_COMPRESS=3Dy
> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=3Dy
> CONFIG_PSTORE_COMPRESS_DEFAULT=3D"deflate"
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> CONFIG_PSTORE_FTRACE=3Dy
> CONFIG_PSTORE_RAM=3Dm
> # CONFIG_PSTORE_BLK is not set
> CONFIG_SYSV_FS=3Dm
> CONFIG_UFS_FS=3Dm
> # CONFIG_UFS_FS_WRITE is not set
> # CONFIG_UFS_DEBUG is not set
> # CONFIG_EROFS_FS is not set
> # CONFIG_VBOXSF_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=3Dy
> CONFIG_NFS_FS=3Dy
> CONFIG_NFS_V2=3Dy
> CONFIG_NFS_V3=3Dy
> CONFIG_NFS_V3_ACL=3Dy
> CONFIG_NFS_V4=3Dy
> CONFIG_NFS_SWAP=3Dy
> CONFIG_NFS_V4_1=3Dy
> CONFIG_NFS_V4_2=3Dy
> CONFIG_PNFS_FILE_LAYOUT=3Dy
> CONFIG_PNFS_BLOCK=3Dy
> CONFIG_PNFS_FLEXFILE_LAYOUT=3Dy
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
> CONFIG_NFS_V4_1_MIGRATION=3Dy
> CONFIG_NFS_V4_SECURITY_LABEL=3Dy
> CONFIG_ROOT_NFS=3Dy
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=3Dy
> CONFIG_NFS_DEBUG=3Dy
> CONFIG_NFS_DISABLE_UDP_SUPPORT=3Dy
> # CONFIG_NFS_V4_2_READ_PLUS is not set
> CONFIG_NFSD=3Dm
> CONFIG_NFSD_V2_ACL=3Dy
> CONFIG_NFSD_V3_ACL=3Dy
> CONFIG_NFSD_V4=3Dy
> CONFIG_NFSD_PNFS=3Dy
> CONFIG_NFSD_BLOCKLAYOUT=3Dy
> CONFIG_NFSD_SCSILAYOUT=3Dy
> CONFIG_NFSD_FLEXFILELAYOUT=3Dy
> # CONFIG_NFSD_V4_2_INTER_SSC is not set
> CONFIG_NFSD_V4_SECURITY_LABEL=3Dy
> CONFIG_GRACE_PERIOD=3Dy
> CONFIG_LOCKD=3Dy
> CONFIG_LOCKD_V4=3Dy
> CONFIG_NFS_ACL_SUPPORT=3Dy
> CONFIG_NFS_COMMON=3Dy
> CONFIG_NFS_V4_2_SSC_HELPER=3Dy
> CONFIG_SUNRPC=3Dy
> CONFIG_SUNRPC_GSS=3Dy
> CONFIG_SUNRPC_BACKCHANNEL=3Dy
> CONFIG_SUNRPC_SWAP=3Dy
> CONFIG_RPCSEC_GSS_KRB5=3Dm
> # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
> CONFIG_SUNRPC_DEBUG=3Dy
> CONFIG_SUNRPC_XPRT_RDMA=3Dm
> CONFIG_CEPH_FS=3Dm
> CONFIG_CEPH_FSCACHE=3Dy
> CONFIG_CEPH_FS_POSIX_ACL=3Dy
> # CONFIG_CEPH_FS_SECURITY_LABEL is not set
> CONFIG_CIFS=3Dm
> # CONFIG_CIFS_STATS2 is not set
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=3Dy
> CONFIG_CIFS_UPCALL=3Dy
> CONFIG_CIFS_XATTR=3Dy
> CONFIG_CIFS_POSIX=3Dy
> CONFIG_CIFS_DEBUG=3Dy
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> CONFIG_CIFS_DFS_UPCALL=3Dy
> # CONFIG_CIFS_SWN_UPCALL is not set
> # CONFIG_CIFS_SMB_DIRECT is not set
> CONFIG_CIFS_FSCACHE=3Dy
> # CONFIG_SMB_SERVER is not set
> CONFIG_SMBFS_COMMON=3Dm
> CONFIG_CODA_FS=3Dm
> CONFIG_AFS_FS=3Dm
> # CONFIG_AFS_DEBUG is not set
> CONFIG_AFS_FSCACHE=3Dy
> # CONFIG_AFS_DEBUG_CURSOR is not set
> CONFIG_9P_FS=3Dy
> CONFIG_9P_FS_POSIX_ACL=3Dy
> CONFIG_9P_FS_SECURITY=3Dy
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"utf8"
> CONFIG_NLS_CODEPAGE_437=3Dy
> CONFIG_NLS_CODEPAGE_737=3Dm
> CONFIG_NLS_CODEPAGE_775=3Dm
> CONFIG_NLS_CODEPAGE_850=3Dm
> CONFIG_NLS_CODEPAGE_852=3Dm
> CONFIG_NLS_CODEPAGE_855=3Dm
> CONFIG_NLS_CODEPAGE_857=3Dm
> CONFIG_NLS_CODEPAGE_860=3Dm
> CONFIG_NLS_CODEPAGE_861=3Dm
> CONFIG_NLS_CODEPAGE_862=3Dm
> CONFIG_NLS_CODEPAGE_863=3Dm
> CONFIG_NLS_CODEPAGE_864=3Dm
> CONFIG_NLS_CODEPAGE_865=3Dm
> CONFIG_NLS_CODEPAGE_866=3Dm
> CONFIG_NLS_CODEPAGE_869=3Dm
> CONFIG_NLS_CODEPAGE_936=3Dm
> CONFIG_NLS_CODEPAGE_950=3Dm
> CONFIG_NLS_CODEPAGE_932=3Dm
> CONFIG_NLS_CODEPAGE_949=3Dm
> CONFIG_NLS_CODEPAGE_874=3Dm
> CONFIG_NLS_ISO8859_8=3Dm
> CONFIG_NLS_CODEPAGE_1250=3Dm
> CONFIG_NLS_CODEPAGE_1251=3Dm
> CONFIG_NLS_ASCII=3Dm
> CONFIG_NLS_ISO8859_1=3Dy
> CONFIG_NLS_ISO8859_2=3Dm
> CONFIG_NLS_ISO8859_3=3Dm
> CONFIG_NLS_ISO8859_4=3Dm
> CONFIG_NLS_ISO8859_5=3Dm
> CONFIG_NLS_ISO8859_6=3Dm
> CONFIG_NLS_ISO8859_7=3Dm
> CONFIG_NLS_ISO8859_9=3Dm
> CONFIG_NLS_ISO8859_13=3Dm
> CONFIG_NLS_ISO8859_14=3Dm
> CONFIG_NLS_ISO8859_15=3Dm
> CONFIG_NLS_KOI8_R=3Dm
> CONFIG_NLS_KOI8_U=3Dm
> CONFIG_NLS_MAC_ROMAN=3Dm
> CONFIG_NLS_MAC_CELTIC=3Dm
> CONFIG_NLS_MAC_CENTEURO=3Dm
> CONFIG_NLS_MAC_CROATIAN=3Dm
> CONFIG_NLS_MAC_CYRILLIC=3Dm
> CONFIG_NLS_MAC_GAELIC=3Dm
> CONFIG_NLS_MAC_GREEK=3Dm
> CONFIG_NLS_MAC_ICELAND=3Dm
> CONFIG_NLS_MAC_INUIT=3Dm
> CONFIG_NLS_MAC_ROMANIAN=3Dm
> CONFIG_NLS_MAC_TURKISH=3Dm
> CONFIG_NLS_UTF8=3Dy
> CONFIG_DLM=3Dm
> # CONFIG_DLM_DEBUG is not set
> # CONFIG_UNICODE is not set
> CONFIG_IO_WQ=3Dy
> # end of File systems
>=20
> #
> # Security options
> #
> CONFIG_KEYS=3Dy
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=3Dy
> CONFIG_TRUSTED_KEYS=3Dy
> CONFIG_ENCRYPTED_KEYS=3Dy
> # CONFIG_USER_DECRYPTED_DATA is not set
> CONFIG_KEY_DH_OPERATIONS=3Dy
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=3Dy
> CONFIG_SECURITYFS=3Dy
> CONFIG_SECURITY_NETWORK=3Dy
> CONFIG_PAGE_TABLE_ISOLATION=3Dy
> CONFIG_SECURITY_INFINIBAND=3Dy
> CONFIG_SECURITY_NETWORK_XFRM=3Dy
> CONFIG_SECURITY_PATH=3Dy
> CONFIG_INTEL_TXT=3Dy
> CONFIG_LSM_MMAP_MIN_ADDR=3D0
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
> CONFIG_HARDENED_USERCOPY=3Dy
> # CONFIG_FORTIFY_SOURCE is not set
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_SECURITY_SELINUX=3Dy
> CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
> # CONFIG_SECURITY_SELINUX_DISABLE is not set
> CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
> CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
> CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=3D9
> CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=3D256
> CONFIG_SECURITY_SMACK=3Dy
> # CONFIG_SECURITY_SMACK_BRINGUP is not set
> CONFIG_SECURITY_SMACK_NETFILTER=3Dy
> CONFIG_SECURITY_SMACK_APPEND_SIGNALS=3Dy
> CONFIG_SECURITY_TOMOYO=3Dy
> CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=3D2048
> CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=3D1024
> # CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
> CONFIG_SECURITY_TOMOYO_POLICY_LOADER=3D"/sbin/tomoyo-init"
> CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER=3D"/sbin/init"
> # CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
> CONFIG_SECURITY_APPARMOR=3Dy
> CONFIG_SECURITY_APPARMOR_HASH=3Dy
> CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=3Dy
> # CONFIG_SECURITY_APPARMOR_DEBUG is not set
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=3Dy
> # CONFIG_SECURITY_SAFESETID is not set
> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> # CONFIG_SECURITY_LANDLOCK is not set
> CONFIG_INTEGRITY=3Dy
> CONFIG_INTEGRITY_SIGNATURE=3Dy
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy
> CONFIG_INTEGRITY_TRUSTED_KEYRING=3Dy
> # CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
> CONFIG_INTEGRITY_AUDIT=3Dy
> CONFIG_IMA=3Dy
> CONFIG_IMA_MEASURE_PCR_IDX=3D10
> CONFIG_IMA_LSM_RULES=3Dy
> # CONFIG_IMA_TEMPLATE is not set
> CONFIG_IMA_NG_TEMPLATE=3Dy
> # CONFIG_IMA_SIG_TEMPLATE is not set
> CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
> CONFIG_IMA_DEFAULT_HASH_SHA1=3Dy
> # CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> CONFIG_IMA_DEFAULT_HASH=3D"sha1"
> # CONFIG_IMA_WRITE_POLICY is not set
> # CONFIG_IMA_READ_POLICY is not set
> CONFIG_IMA_APPRAISE=3Dy
> # CONFIG_IMA_ARCH_POLICY is not set
> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
> # CONFIG_IMA_APPRAISE_MODSIG is not set
> CONFIG_IMA_TRUSTED_KEYRING=3Dy
> # CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
> # CONFIG_IMA_BLACKLIST_KEYRING is not set
> # CONFIG_IMA_LOAD_X509 is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
> # CONFIG_IMA_DISABLE_HTABLE is not set
> CONFIG_EVM=3Dy
> CONFIG_EVM_ATTR_FSUUID=3Dy
> CONFIG_EVM_EXTRA_SMACK_XATTRS=3Dy
> # CONFIG_EVM_ADD_XATTRS is not set
> # CONFIG_EVM_LOAD_X509 is not set
> CONFIG_DEFAULT_SECURITY_SELINUX=3Dy
> # CONFIG_DEFAULT_SECURITY_SMACK is not set
> # CONFIG_DEFAULT_SECURITY_TOMOYO is not set
> # CONFIG_DEFAULT_SECURITY_APPARMOR is not set
> # CONFIG_DEFAULT_SECURITY_DAC is not set
> CONFIG_LSM=3D"yama,loadpin,integrity"
>=20
> #
> # Kernel hardening options
> #
>=20
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=3Dy
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
>=20
> CONFIG_XOR_BLOCKS=3Dm
> CONFIG_ASYNC_CORE=3Dm
> CONFIG_ASYNC_MEMCPY=3Dm
> CONFIG_ASYNC_XOR=3Dm
> CONFIG_ASYNC_PQ=3Dm
> CONFIG_ASYNC_RAID6_RECOV=3Dm
> CONFIG_CRYPTO=3Dy
>=20
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=3Dy
> CONFIG_CRYPTO_ALGAPI2=3Dy
> CONFIG_CRYPTO_AEAD=3Dy
> CONFIG_CRYPTO_AEAD2=3Dy
> CONFIG_CRYPTO_SKCIPHER=3Dy
> CONFIG_CRYPTO_SKCIPHER2=3Dy
> CONFIG_CRYPTO_HASH=3Dy
> CONFIG_CRYPTO_HASH2=3Dy
> CONFIG_CRYPTO_RNG=3Dy
> CONFIG_CRYPTO_RNG2=3Dy
> CONFIG_CRYPTO_RNG_DEFAULT=3Dy
> CONFIG_CRYPTO_AKCIPHER2=3Dy
> CONFIG_CRYPTO_AKCIPHER=3Dy
> CONFIG_CRYPTO_KPP2=3Dy
> CONFIG_CRYPTO_KPP=3Dy
> CONFIG_CRYPTO_ACOMP2=3Dy
> CONFIG_CRYPTO_MANAGER=3Dy
> CONFIG_CRYPTO_MANAGER2=3Dy
> CONFIG_CRYPTO_USER=3Dm
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
> CONFIG_CRYPTO_GF128MUL=3Dy
> CONFIG_CRYPTO_NULL=3Dy
> CONFIG_CRYPTO_NULL2=3Dy
> CONFIG_CRYPTO_PCRYPT=3Dm
> CONFIG_CRYPTO_CRYPTD=3Dm
> CONFIG_CRYPTO_AUTHENC=3Dm
> CONFIG_CRYPTO_TEST=3Dm
> CONFIG_CRYPTO_SIMD=3Dm
> CONFIG_CRYPTO_ENGINE=3Dm
>=20
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=3Dy
> CONFIG_CRYPTO_DH=3Dy
> # CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
> CONFIG_CRYPTO_ECC=3Dm
> CONFIG_CRYPTO_ECDH=3Dm
> # CONFIG_CRYPTO_ECDSA is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> # CONFIG_CRYPTO_CURVE25519_X86 is not set
>=20
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=3Dm
> CONFIG_CRYPTO_GCM=3Dy
> CONFIG_CRYPTO_CHACHA20POLY1305=3Dm
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> CONFIG_CRYPTO_SEQIV=3Dy
> CONFIG_CRYPTO_ECHAINIV=3Dm
>=20
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=3Dy
> # CONFIG_CRYPTO_CFB is not set
> CONFIG_CRYPTO_CTR=3Dy
> CONFIG_CRYPTO_CTS=3Dm
> CONFIG_CRYPTO_ECB=3Dy
> CONFIG_CRYPTO_LRW=3Dm
> # CONFIG_CRYPTO_OFB is not set
> CONFIG_CRYPTO_PCBC=3Dm
> CONFIG_CRYPTO_XTS=3Dm
> CONFIG_CRYPTO_KEYWRAP=3Dm
> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> # CONFIG_CRYPTO_ADIANTUM is not set
> CONFIG_CRYPTO_ESSIV=3Dm
>=20
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=3Dm
> CONFIG_CRYPTO_HMAC=3Dy
> CONFIG_CRYPTO_XCBC=3Dm
> CONFIG_CRYPTO_VMAC=3Dm
>=20
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=3Dy
> CONFIG_CRYPTO_CRC32C_INTEL=3Dy
> CONFIG_CRYPTO_CRC32=3Dm
> CONFIG_CRYPTO_CRC32_PCLMUL=3Dm
> CONFIG_CRYPTO_XXHASH=3Dm
> CONFIG_CRYPTO_BLAKE2B=3Dm
> # CONFIG_CRYPTO_BLAKE2S is not set
> # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> CONFIG_CRYPTO_CRCT10DIF=3Dy
> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dm
> CONFIG_CRYPTO_CRC64_ROCKSOFT=3Dy
> CONFIG_CRYPTO_GHASH=3Dy
> CONFIG_CRYPTO_POLY1305=3Dm
> CONFIG_CRYPTO_POLY1305_X86_64=3Dm
> CONFIG_CRYPTO_MD4=3Dm
> CONFIG_CRYPTO_MD5=3Dy
> CONFIG_CRYPTO_MICHAEL_MIC=3Dm
> CONFIG_CRYPTO_RMD160=3Dm
> CONFIG_CRYPTO_SHA1=3Dy
> CONFIG_CRYPTO_SHA1_SSSE3=3Dm
> CONFIG_CRYPTO_SHA256_SSSE3=3Dm
> CONFIG_CRYPTO_SHA512_SSSE3=3Dm
> CONFIG_CRYPTO_SHA256=3Dy
> CONFIG_CRYPTO_SHA512=3Dy
> CONFIG_CRYPTO_SHA3=3Dm
> CONFIG_CRYPTO_SM3=3Dm
> # CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
> # CONFIG_CRYPTO_STREEBOG is not set
> CONFIG_CRYPTO_WP512=3Dm
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dm
>=20
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=3Dy
> CONFIG_CRYPTO_AES_TI=3Dm
> CONFIG_CRYPTO_AES_NI_INTEL=3Dm
> CONFIG_CRYPTO_ANUBIS=3Dm
> CONFIG_CRYPTO_ARC4=3Dm
> CONFIG_CRYPTO_BLOWFISH=3Dm
> CONFIG_CRYPTO_BLOWFISH_COMMON=3Dm
> CONFIG_CRYPTO_BLOWFISH_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA=3Dm
> CONFIG_CRYPTO_CAMELLIA_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=3Dm
> CONFIG_CRYPTO_CAST_COMMON=3Dm
> CONFIG_CRYPTO_CAST5=3Dm
> CONFIG_CRYPTO_CAST5_AVX_X86_64=3Dm
> CONFIG_CRYPTO_CAST6=3Dm
> CONFIG_CRYPTO_CAST6_AVX_X86_64=3Dm
> CONFIG_CRYPTO_DES=3Dm
> CONFIG_CRYPTO_DES3_EDE_X86_64=3Dm
> CONFIG_CRYPTO_FCRYPT=3Dm
> CONFIG_CRYPTO_KHAZAD=3Dm
> CONFIG_CRYPTO_CHACHA20=3Dm
> CONFIG_CRYPTO_CHACHA20_X86_64=3Dm
> CONFIG_CRYPTO_SEED=3Dm
> CONFIG_CRYPTO_SERPENT=3Dm
> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=3Dm
> CONFIG_CRYPTO_SERPENT_AVX_X86_64=3Dm
> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=3Dm
> # CONFIG_CRYPTO_SM4 is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
> CONFIG_CRYPTO_TEA=3Dm
> CONFIG_CRYPTO_TWOFISH=3Dm
> CONFIG_CRYPTO_TWOFISH_COMMON=3Dm
> CONFIG_CRYPTO_TWOFISH_X86_64=3Dm
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=3Dm
> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=3Dm
>=20
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=3Dy
> CONFIG_CRYPTO_LZO=3Dy
> CONFIG_CRYPTO_842=3Dm
> CONFIG_CRYPTO_LZ4=3Dm
> CONFIG_CRYPTO_LZ4HC=3Dm
> CONFIG_CRYPTO_ZSTD=3Dm
>=20
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=3Dm
> CONFIG_CRYPTO_DRBG_MENU=3Dy
> CONFIG_CRYPTO_DRBG_HMAC=3Dy
> CONFIG_CRYPTO_DRBG_HASH=3Dy
> CONFIG_CRYPTO_DRBG_CTR=3Dy
> CONFIG_CRYPTO_DRBG=3Dy
> CONFIG_CRYPTO_JITTERENTROPY=3Dy
> CONFIG_CRYPTO_KDF800108_CTR=3Dy
> CONFIG_CRYPTO_USER_API=3Dm
> CONFIG_CRYPTO_USER_API_HASH=3Dm
> CONFIG_CRYPTO_USER_API_SKCIPHER=3Dm
> CONFIG_CRYPTO_USER_API_RNG=3Dm
> # CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
> CONFIG_CRYPTO_USER_API_AEAD=3Dm
> CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=3Dy
> # CONFIG_CRYPTO_STATS is not set
> CONFIG_CRYPTO_HASH_INFO=3Dy
> CONFIG_CRYPTO_HW=3Dy
> CONFIG_CRYPTO_DEV_PADLOCK=3Dy
> CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dm
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=3Dm
> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> CONFIG_CRYPTO_DEV_CCP=3Dy
> CONFIG_CRYPTO_DEV_CCP_DD=3Dm
> CONFIG_CRYPTO_DEV_SP_CCP=3Dy
> CONFIG_CRYPTO_DEV_CCP_CRYPTO=3Dm
> CONFIG_CRYPTO_DEV_SP_PSP=3Dy
> # CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
> CONFIG_CRYPTO_DEV_QAT=3Dm
> CONFIG_CRYPTO_DEV_QAT_DH895xCC=3Dm
> CONFIG_CRYPTO_DEV_QAT_C3XXX=3Dm
> CONFIG_CRYPTO_DEV_QAT_C62X=3Dm
> # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=3Dm
> CONFIG_CRYPTO_DEV_QAT_C3XXXVF=3Dm
> CONFIG_CRYPTO_DEV_QAT_C62XVF=3Dm
> CONFIG_CRYPTO_DEV_NITROX=3Dm
> CONFIG_CRYPTO_DEV_NITROX_CNN55XX=3Dm
> CONFIG_CRYPTO_DEV_CHELSIO=3Dm
> CONFIG_CRYPTO_DEV_VIRTIO=3Dm
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> # CONFIG_CRYPTO_DEV_CCREE is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
> CONFIG_X509_CERTIFICATE_PARSER=3Dy
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=3Dy
> CONFIG_PKCS7_TEST_KEY=3Dm
> CONFIG_SIGNED_PE_FILE_VERIFICATION=3Dy
>=20
> #
> # Certificates for signature checking
> #
> CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
> CONFIG_SYSTEM_TRUSTED_KEYS=3D""
> CONFIG_SYSTEM_EXTRA_CERTIFICATE=3Dy
> CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=3D4096
> CONFIG_SECONDARY_TRUSTED_KEYRING=3Dy
> CONFIG_SYSTEM_BLACKLIST_KEYRING=3Dy
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=3D""
> # CONFIG_SYSTEM_REVOCATION_LIST is not set
> # CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
> # end of Certificates for signature checking
>=20
> CONFIG_BINARY_PRINTF=3Dy
>=20
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=3Dm
> CONFIG_RAID6_PQ_BENCHMARK=3Dy
> CONFIG_LINEAR_RANGES=3Dy
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=3Dy
> CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
> CONFIG_GENERIC_STRNLEN_USER=3Dy
> CONFIG_GENERIC_NET_UTILS=3Dy
> CONFIG_CORDIC=3Dm
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=3Dy
> CONFIG_GENERIC_PCI_IOMAP=3Dy
> CONFIG_GENERIC_IOMAP=3Dy
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=3Dy
>=20
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=3Dy
> CONFIG_CRYPTO_LIB_ARC4=3Dm
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=3Dy
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=3Dm
> # CONFIG_CRYPTO_LIB_CHACHA is not set
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_DES=3Dm
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D11
> CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=3Dm
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=3Dm
> # CONFIG_CRYPTO_LIB_POLY1305 is not set
> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_LIB_SHA256=3Dy
> CONFIG_CRYPTO_LIB_SM3=3Dm
> # end of Crypto library routines
>=20
> CONFIG_CRC_CCITT=3Dy
> CONFIG_CRC16=3Dy
> CONFIG_CRC_T10DIF=3Dy
> CONFIG_CRC64_ROCKSOFT=3Dy
> CONFIG_CRC_ITU_T=3Dm
> CONFIG_CRC32=3Dy
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=3Dy
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC64=3Dy
> CONFIG_CRC4=3Dm
> CONFIG_CRC7=3Dm
> CONFIG_LIBCRC32C=3Dy
> CONFIG_CRC8=3Dm
> CONFIG_XXHASH=3Dy
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_842_COMPRESS=3Dm
> CONFIG_842_DECOMPRESS=3Dm
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dy
> CONFIG_LZO_COMPRESS=3Dy
> CONFIG_LZO_DECOMPRESS=3Dy
> CONFIG_LZ4_COMPRESS=3Dm
> CONFIG_LZ4HC_COMPRESS=3Dm
> CONFIG_LZ4_DECOMPRESS=3Dy
> CONFIG_ZSTD_COMPRESS=3Dm
> CONFIG_ZSTD_DECOMPRESS=3Dy
> CONFIG_XZ_DEC=3Dy
> CONFIG_XZ_DEC_X86=3Dy
> CONFIG_XZ_DEC_POWERPC=3Dy
> CONFIG_XZ_DEC_IA64=3Dy
> CONFIG_XZ_DEC_ARM=3Dy
> CONFIG_XZ_DEC_ARMTHUMB=3Dy
> CONFIG_XZ_DEC_SPARC=3Dy
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=3Dy
> CONFIG_XZ_DEC_TEST=3Dm
> CONFIG_DECOMPRESS_GZIP=3Dy
> CONFIG_DECOMPRESS_BZIP2=3Dy
> CONFIG_DECOMPRESS_LZMA=3Dy
> CONFIG_DECOMPRESS_XZ=3Dy
> CONFIG_DECOMPRESS_LZO=3Dy
> CONFIG_DECOMPRESS_LZ4=3Dy
> CONFIG_DECOMPRESS_ZSTD=3Dy
> CONFIG_GENERIC_ALLOCATOR=3Dy
> CONFIG_REED_SOLOMON=3Dm
> CONFIG_REED_SOLOMON_ENC8=3Dy
> CONFIG_REED_SOLOMON_DEC8=3Dy
> CONFIG_BCH=3Dm
> CONFIG_BCH_CONST_PARAMS=3Dy
> CONFIG_TEXTSEARCH=3Dy
> CONFIG_TEXTSEARCH_KMP=3Dm
> CONFIG_TEXTSEARCH_BM=3Dm
> CONFIG_TEXTSEARCH_FSM=3Dm
> CONFIG_BTREE=3Dy
> CONFIG_INTERVAL_TREE=3Dy
> CONFIG_XARRAY_MULTI=3Dy
> CONFIG_ASSOCIATIVE_ARRAY=3Dy
> CONFIG_HAS_IOMEM=3Dy
> CONFIG_HAS_IOPORT_MAP=3Dy
> CONFIG_HAS_DMA=3Dy
> CONFIG_DMA_OPS=3Dy
> CONFIG_NEED_SG_DMA_LENGTH=3Dy
> CONFIG_NEED_DMA_MAP_STATE=3Dy
> CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
> CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=3Dy
> CONFIG_SWIOTLB=3Dy
> CONFIG_DMA_COHERENT_POOL=3Dy
> CONFIG_DMA_CMA=3Dy
> # CONFIG_DMA_PERNUMA_CMA is not set
>=20
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=3D0
> CONFIG_CMA_SIZE_SEL_MBYTES=3Dy
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> # CONFIG_CMA_SIZE_SEL_MAX is not set
> CONFIG_CMA_ALIGNMENT=3D8
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=3Dy
> CONFIG_IOMMU_HELPER=3Dy
> CONFIG_CHECK_SIGNATURE=3Dy
> CONFIG_CPUMASK_OFFSTACK=3Dy
> CONFIG_CPU_RMAP=3Dy
> CONFIG_DQL=3Dy
> CONFIG_GLOB=3Dy
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=3Dy
> CONFIG_LRU_CACHE=3Dm
> CONFIG_CLZ_TAB=3Dy
> CONFIG_IRQ_POLL=3Dy
> CONFIG_MPILIB=3Dy
> CONFIG_SIGNATURE=3Dy
> CONFIG_DIMLIB=3Dy
> CONFIG_OID_REGISTRY=3Dy
> CONFIG_UCS2_STRING=3Dy
> CONFIG_HAVE_GENERIC_VDSO=3Dy
> CONFIG_GENERIC_GETTIMEOFDAY=3Dy
> CONFIG_GENERIC_VDSO_TIME_NS=3Dy
> CONFIG_FONT_SUPPORT=3Dy
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=3Dy
> CONFIG_FONT_8x16=3Dy
> CONFIG_SG_POOL=3Dy
> CONFIG_ARCH_HAS_PMEM_API=3Dy
> CONFIG_MEMREGION=3Dy
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy
> CONFIG_ARCH_HAS_COPY_MC=3Dy
> CONFIG_ARCH_STACKWALK=3Dy
> CONFIG_SBITMAP=3Dy
> CONFIG_PARMAN=3Dm
> CONFIG_OBJAGG=3Dm
> # end of Library routines
>=20
> CONFIG_PLDMFW=3Dy
> CONFIG_ASN1_ENCODER=3Dy
>=20
> #
> # Kernel hacking
> #
>=20
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=3Dy
> # CONFIG_PRINTK_CALLER is not set
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=3D4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
> CONFIG_BOOT_PRINTK_DELAY=3Dy
> CONFIG_DYNAMIC_DEBUG=3Dy
> CONFIG_DYNAMIC_DEBUG_CORE=3Dy
> CONFIG_SYMBOLIC_ERRNAME=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> # end of printk and dmesg options
>=20
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_MISC=3Dy
>=20
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=3Dy
> # CONFIG_DEBUG_INFO_NONE is not set
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> CONFIG_DEBUG_INFO_DWARF4=3Dy
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> # CONFIG_DEBUG_INFO_REDUCED is not set
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> # CONFIG_DEBUG_INFO_BTF is not set
> CONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=3D2048
> # CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> # CONFIG_DEBUG_SECTION_MISMATCH is not set
> CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
> # CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
> CONFIG_FRAME_POINTER=3Dy
> CONFIG_STACK_VALIDATION=3Dy
> # CONFIG_VMLINUX_MAP is not set
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
>=20
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=3D""
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=3Dy
> CONFIG_KGDB=3Dy
> CONFIG_KGDB_HONOUR_BLOCKLIST=3Dy
> CONFIG_KGDB_SERIAL_CONSOLE=3Dy
> # CONFIG_KGDB_TESTS is not set
> CONFIG_KGDB_LOW_LEVEL_TRAP=3Dy
> CONFIG_KGDB_KDB=3Dy
> CONFIG_KDB_DEFAULT_ENABLE=3D0x1
> CONFIG_KDB_KEYBOARD=3Dy
> CONFIG_KDB_CONTINUE_CATASTROPHIC=3D0
> CONFIG_ARCH_HAS_EARLY_DEBUG=3Dy
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy
> # CONFIG_UBSAN is not set
> CONFIG_HAVE_ARCH_KCSAN=3Dy
> # end of Generic Kernel Debugging Instruments
>=20
> #
> # Networking Debugging
> #
> # CONFIG_NET_DEV_REFCNT_TRACKER is not set
> # CONFIG_NET_NS_REFCNT_TRACKER is not set
> # end of Networking Debugging
>=20
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=3Dy
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_TABLE_CHECK is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> CONFIG_DEBUG_WX=3Dy
> CONFIG_GENERIC_PTDUMP=3Dy
> CONFIG_PTDUMP_CORE=3Dy
> # CONFIG_PTDUMP_DEBUGFS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> CONFIG_DEBUG_KMEMLEAK=3Dy
> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=3D16000
> CONFIG_DEBUG_KMEMLEAK_TEST=3Dm
> CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=3Dy
> # CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> CONFIG_SCHED_STACK_END_CHECK=3Dy
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> # CONFIG_DEBUG_VIRTUAL is not set
> # CONFIG_DEBUG_MEMORY_INIT is not set
> CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=3Dm
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_ARCH_KASAN=3Dy
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
> CONFIG_CC_HAS_KASAN_GENERIC=3Dy
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy
> # CONFIG_KASAN is not set
> CONFIG_HAVE_ARCH_KFENCE=3Dy
> # CONFIG_KFENCE is not set
> # end of Memory Debugging
>=20
> # CONFIG_DEBUG_SHIRQ is not set
>=20
> #
> # Debug Oops, Lockups and Hangs
> #
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=3D0
> CONFIG_PANIC_TIMEOUT=3D0
> CONFIG_LOCKUP_DETECTOR=3Dy
> CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=3Dy
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D1
> CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy
> CONFIG_HARDLOCKUP_DETECTOR=3Dy
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D1
> CONFIG_DETECT_HUNG_TASK=3Dy
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D140
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
> # CONFIG_WQ_WATCHDOG is not set
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
>=20
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=3Dy
> CONFIG_SCHED_INFO=3Dy
> CONFIG_SCHEDSTATS=3Dy
> # end of Scheduler Debugging
>=20
> # CONFIG_DEBUG_TIMEKEEPING is not set
> CONFIG_DEBUG_PREEMPT=3Dy
>=20
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> CONFIG_LOCK_TORTURE_TEST=3Dm
> # CONFIG_WW_MUTEX_SELFTEST is not set
> CONFIG_SCF_TORTURE_TEST=3Dm
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
>=20
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=3Dy
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
>=20
> #
> # Debug kernel data structures
> #
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # end of Debug kernel data structures
>=20
> # CONFIG_DEBUG_CREDENTIALS is not set
>=20
> #
> # RCU Debugging
> #
> CONFIG_TORTURE_TEST=3Dm
> # CONFIG_RCU_SCALE_TEST is not set
> CONFIG_RCU_TORTURE_TEST=3Dm
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D100
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
>=20
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_USER_STACKTRACE_SUPPORT=3Dy
> CONFIG_NOP_TRACER=3Dy
> CONFIG_HAVE_RETHOOK=3Dy
> CONFIG_RETHOOK=3Dy
> CONFIG_HAVE_FUNCTION_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=3Dy
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> CONFIG_HAVE_FENTRY=3Dy
> CONFIG_HAVE_OBJTOOL_MCOUNT=3Dy
> CONFIG_HAVE_C_RECORDMCOUNT=3Dy
> CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=3Dy
> CONFIG_BUILDTIME_MCOUNT_SORT=3Dy
> CONFIG_TRACER_MAX_TRACE=3Dy
> CONFIG_TRACE_CLOCK=3Dy
> CONFIG_RING_BUFFER=3Dy
> CONFIG_EVENT_TRACING=3Dy
> CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> CONFIG_TRACING=3Dy
> CONFIG_GENERIC_TRACER=3Dy
> CONFIG_TRACING_SUPPORT=3Dy
> CONFIG_FTRACE=3Dy
> # CONFIG_BOOTTIME_TRACING is not set
> CONFIG_FUNCTION_TRACER=3Dy
> CONFIG_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_DYNAMIC_FTRACE=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS=3Dy
> # CONFIG_FPROBE is not set
> CONFIG_FUNCTION_PROFILER=3Dy
> CONFIG_STACK_TRACER=3Dy
> # CONFIG_IRQSOFF_TRACER is not set
> # CONFIG_PREEMPT_TRACER is not set
> CONFIG_SCHED_TRACER=3Dy
> CONFIG_HWLAT_TRACER=3Dy
> # CONFIG_OSNOISE_TRACER is not set
> # CONFIG_TIMERLAT_TRACER is not set
> CONFIG_MMIOTRACE=3Dy
> CONFIG_FTRACE_SYSCALLS=3Dy
> CONFIG_TRACER_SNAPSHOT=3Dy
> # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> CONFIG_BRANCH_PROFILE_NONE=3Dy
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> # CONFIG_PROFILE_ALL_BRANCHES is not set
> CONFIG_BLK_DEV_IO_TRACE=3Dy
> CONFIG_KPROBE_EVENTS=3Dy
> # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> CONFIG_UPROBE_EVENTS=3Dy
> CONFIG_BPF_EVENTS=3Dy
> CONFIG_DYNAMIC_EVENTS=3Dy
> CONFIG_PROBE_EVENTS=3Dy
> CONFIG_BPF_KPROBE_OVERRIDE=3Dy
> CONFIG_FTRACE_MCOUNT_RECORD=3Dy
> CONFIG_FTRACE_MCOUNT_USE_CC=3Dy
> CONFIG_TRACING_MAP=3Dy
> CONFIG_SYNTH_EVENTS=3Dy
> CONFIG_HIST_TRIGGERS=3Dy
> # CONFIG_TRACE_EVENT_INJECT is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> # CONFIG_RING_BUFFER_BENCHMARK is not set
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> # CONFIG_FTRACE_RECORD_RECURSION is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_FTRACE_SORT_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
> # CONFIG_MMIOTRACE_TEST is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> # CONFIG_SYNTH_EVENT_GEN_TEST is not set
> # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> # CONFIG_HIST_TRIGGERS_DEBUG is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=3Dy
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=3Dy
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
> # CONFIG_STRICT_DEVMEM is not set
>=20
> #
> # x86 Debugging
> #
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=3Dy
> CONFIG_EARLY_PRINTK_USB=3Dy
> # CONFIG_X86_VERBOSE_BOOTUP is not set
> CONFIG_EARLY_PRINTK=3Dy
> CONFIG_EARLY_PRINTK_DBGP=3Dy
> # CONFIG_EARLY_PRINTK_USB_XDBC is not set
> # CONFIG_EFI_PGT_DUMP is not set
> # CONFIG_DEBUG_TLBFLUSH is not set
> # CONFIG_IOMMU_DEBUG is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
> # CONFIG_X86_DECODER_SELFTEST is not set
> # CONFIG_IO_DELAY_0X80 is not set
> CONFIG_IO_DELAY_0XED=3Dy
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> # CONFIG_DEBUG_BOOT_PARAMS is not set
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> CONFIG_X86_DEBUG_FPU=3Dy
> CONFIG_PUNIT_ATOM_DEBUG=3Dm
> # CONFIG_UNWINDER_ORC is not set
> CONFIG_UNWINDER_FRAME_POINTER=3Dy
> # CONFIG_UNWINDER_GUESS is not set
> # end of x86 Debugging
>=20
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> CONFIG_NOTIFIER_ERROR_INJECTION=3Dy
> CONFIG_PM_NOTIFIER_ERROR_INJECT=3Dm
> # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> CONFIG_FUNCTION_ERROR_INJECTION=3Dy
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_ARCH_HAS_KCOV=3Dy
> CONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy
> CONFIG_KCOV=3Dy
> CONFIG_KCOV_ENABLE_COMPARISONS=3Dy
> CONFIG_KCOV_INSTRUMENT_ALL=3Dy
> CONFIG_KCOV_IRQ_AREA_SIZE=3D0x40000
> # CONFIG_RUNTIME_TESTING_MENU is not set
> CONFIG_ARCH_USE_MEMTEST=3Dy
> CONFIG_MEMTEST=3Dy
> # CONFIG_HYPERV_TESTING is not set
> # CONFIG_PKS_TEST is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

> =1Bc=1B[?7l=1B[2J=1B[0mSeaBIOS (version rel-1.16.0-0-gd239552ce722-prebui=
lt.qemu.org)
>=20
>=20
> iPXE (http://ipxe.org) 00:03.0 CA00 PCI2.10 PnP PMM+7FF91000+7FEF1000 CA0=
0
> Press Ctrl-B to configure iPXE (PCI 00:03.0)...=0D                       =
                                                       =20
>=20
>=20
> Booting from ROM..=1Bc=1B[?7l=1B[2J=1B[0m.=0D[    0.000000] Linux version=
 6.2.0-rc5-2241ab53cbb5 (root@984fee00a1f6.jf.intel.com) (gcc (GCC) 8.5.0 2=
0210514 (Red Hat 8.5.0-18), GNU ld version 2.36.1-3.el8) #1 SMP PREEMPT_DYN=
AMIC Mon Jan 23 17:54:51 PST 2023
> [    0.000000] Command line: console=3DttyS0 root=3D/dev/sda earlyprintk=
=3Dserial net.ifnames=3D0
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Hygon HygonGenuine
> [    0.000000]   Centaur CentaurHauls
> [    0.000000]   zhaoxin   Shanghai =20
> [    0.000000] x86/split lock detection: #DB: warning on user-space bus_l=
ocks
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating poi=
nt registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi25=
6'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys =
User registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x20000: 'AMX Tile confi=
g'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x40000: 'AMX Tile data'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
> [    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
> [    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
> [    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
> [    0.000000] x86/fpu: xstate_offset[17]: 2496, xstate_sizes[17]:   64
> [    0.000000] x86/fpu: xstate_offset[18]: 2560, xstate_sizes[18]: 8192
> [    0.000000] x86/fpu: Enabled xstate features 0x602e7, context size is =
10752 bytes, using 'compacted' format.
> [    0.000000] signal: max sigframe size: 11952
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] res=
erved
> [    0.000000] printk: bootconsole [earlyser0] enabled
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16=
.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    0.000000] Hypervisor detected: KVM
> [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> [    0.000004] kvm-clock: using sched offset of 595988305 cycles
> [    0.000847] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycle=
s: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [    0.003491] tsc: Detected 1700.000 MHz processor
> [    0.012362] last_pfn =3D 0x7ffe0 max_arch_pfn =3D 0x10000000000
> [    0.013249] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- =
WT =20
> [    0.020423] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
> [    0.021346] Using GB pages for direct mapping
> [    0.023346] ACPI: Early table checksum verification disabled
> [    0.024280] ACPI: RSDP 0x00000000000F59C0 000014 (v00 BOCHS )
> [    0.025228] ACPI: RSDT 0x000000007FFE1951 000034 (v01 BOCHS  BXPC     =
00000001 BXPC 00000001)
> [    0.026624] ACPI: FACP 0x000000007FFE17FD 000074 (v01 BOCHS  BXPC     =
00000001 BXPC 00000001)
> [    0.028029] ACPI: DSDT 0x000000007FFE0040 0017BD (v01 BOCHS  BXPC     =
00000001 BXPC 00000001)
> [    0.029407] ACPI: FACS 0x000000007FFE0000 000040
> [    0.030172] ACPI: APIC 0x000000007FFE1871 000080 (v01 BOCHS  BXPC     =
00000001 BXPC 00000001)
> [    0.031569] ACPI: HPET 0x000000007FFE18F1 000038 (v01 BOCHS  BXPC     =
00000001 BXPC 00000001)
> [    0.032956] ACPI: WAET 0x000000007FFE1929 000028 (v01 BOCHS  BXPC     =
00000001 BXPC 00000001)
> [    0.034350] ACPI: Reserving FACP table memory at [mem 0x7ffe17fd-0x7ff=
e1870]
> [    0.035492] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ff=
e17fc]
> [    0.036632] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ff=
e003f]
> [    0.037773] ACPI: Reserving APIC table memory at [mem 0x7ffe1871-0x7ff=
e18f0]
> [    0.038913] ACPI: Reserving HPET table memory at [mem 0x7ffe18f1-0x7ff=
e1928]
> [    0.040054] ACPI: Reserving WAET table memory at [mem 0x7ffe1929-0x7ff=
e1950]
> [    0.042342] No NUMA configuration found
> [    0.042959] Faking a node at [mem 0x0000000000000000-0x000000007ffdfff=
f]
> [    0.044117] NODE_DATA(0) allocated [mem 0x7ffb5000-0x7ffdffff]
> [    0.049175] Zone ranges:
> [    0.049593]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.050598]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]
> [    0.051608]   Normal   empty
> [    0.052079]   Device   empty
> [    0.052550] Movable zone start for each node
> [    0.053241] Early memory node ranges
> [    0.053815]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.054830]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]
> [    0.055853] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ff=
dffff]
> [    0.057372] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.057393] On node 0, zone DMA: 97 pages in unavailable ranges
> [    0.065628] On node 0, zone DMA32: 32 pages in unavailable ranges
> [    0.066813] ACPI: PM-Timer IO Port: 0x608
> [    0.068477] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> [    0.069453] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI =
0-23
> [    0.070575] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.071609] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level=
)
> [    0.072676] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level=
)
> [    0.073747] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high lev=
el)
> [    0.074848] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high lev=
el)
> [    0.075974] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.077008] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.077852] TSC deadline timer available
> [    0.078482] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
> [    0.079322] kvm-guest: KVM setup pv remote TLB flush
> [    0.080092] kvm-guest: setup PV sched yield
> [    0.080816] PM: hibernation: Registered nosave memory: [mem 0x00000000=
-0x00000fff]
> [    0.082042] PM: hibernation: Registered nosave memory: [mem 0x0009f000=
-0x0009ffff]
> [    0.083253] PM: hibernation: Registered nosave memory: [mem 0x000a0000=
-0x000effff]
> [    0.084484] PM: hibernation: Registered nosave memory: [mem 0x000f0000=
-0x000fffff]
> [    0.085709] [mem 0x80000000-0xfeffbfff] available for PCI devices
> [    0.086696] Booting paravirtualized kernel on KVM
> [    0.087468] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:=
 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.089168] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 =
nr_node_ids:1
> [    0.090848] percpu: Embedded 64 pages/cpu s225280 r8192 d28672 u104857=
6
> [    0.092158] kvm-guest: PV spinlocks enabled
> [    0.092852] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes=
, linear)
> [    0.094056] Fallback order for Node 0: 0=20
> [    0.094721] Built 1 zonelists, mobility grouping on.  Total pages: 515=
808
> [    0.095827] Policy zone: DMA32
> [    0.096326] Kernel command line: net.ifnames=3D0 console=3DttyS0 root=
=3D/dev/sda earlyprintk=3Dserial net.ifnames=3D0
> [    0.098285] random: crng init done
> [    0.099239] Dentry cache hash table entries: 262144 (order: 9, 2097152=
 bytes, linear)
> [    0.100657] Inode-cache hash table entries: 131072 (order: 8, 1048576 =
bytes, linear)
> [    0.102053] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.107749] Memory: 1977268K/2096632K available (34816K kernel code, 4=
628K rwdata, 10000K rodata, 10172K init, 19780K bss, 119164K reserved, 0K c=
ma-reserved)
> [    0.110383] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D2,=
 Nodes=3D1
> [    0.111438] kmemleak: Kernel memory leak detector disabled
> [    0.112388] ftrace: allocating 68241 entries in 267 pages
> [    0.138257] ftrace: allocated 267 pages with 4 groups
> [    0.142517] Dynamic Preempt: voluntary
> [    0.143251] Running RCU self tests
> [    0.143806] rcu: Preemptible hierarchical RCU implementation.
> [    0.144718] rcu: 	RCU lockdep checking is enabled.
> [    0.145480] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_i=
ds=3D2.
> [    0.146560] 	Trampoline variant of Tasks RCU enabled.
> [    0.147369] 	Rude variant of Tasks RCU enabled.
> [    0.148094] 	Tracing variant of Tasks RCU enabled.
> [    0.148860] rcu: RCU calculated value of scheduler-enlistment delay is=
 25 jiffies.
> [    0.150066] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D2
> [    0.183405] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16
> [    0.184642] rcu: srcu_init: Setting srcu_struct sizes based on content=
ion.
> [    0.193874] Console: colour VGA+ 80x25
> [    0.194472] printk: console [ttyS0] enabled
> [    0.194472] printk: console [ttyS0] enabled
> [    0.195777] printk: bootconsole [earlyser0] disabled
> [    0.195777] printk: bootconsole [earlyser0] disabled
> [    0.197391] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc=
., Ingo Molnar
> [    0.198648] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.199315] ... MAX_LOCK_DEPTH:          48
> [    0.200000] ... MAX_LOCKDEP_KEYS:        8192
> [    0.200726] ... CLASSHASH_SIZE:          4096
> [    0.201453] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.202162] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.202906] ... CHAINHASH_SIZE:          32768
> [    0.203571]  memory used by lock dependency info: 6365 kB
> [    0.204448]  memory used for stack traces: 4224 kB
> [    0.205230]  per task-struct memory footprint: 1920 bytes
> [    0.206151] ACPI: Core revision 20221020
> [    0.207044] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 19112604467 ns
> [    0.208681] APIC: Switch to symmetric I/O mode setup
> [    0.209690] x2apic enabled
> [    0.210338] Switched APIC routing to physical x2apic.
> [    0.211165] kvm-guest: setup PV IPIs
> [    0.212747] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
> [    0.213755] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycle=
s: 0x1881273ac8e, max_idle_ns: 440795257284 ns
> [    0.215481] Calibrating delay loop (skipped) preset value.. 3400.00 Bo=
goMIPS (lpj=3D6800000)
> [    0.219486] pid_max: default: 32768 minimum: 301
> [    0.220325] LSM: initializing lsm=3Dcapability,yama,integrity
> [    0.221250] Yama: becoming mindful.
> [    0.221990] Mount-cache hash table entries: 4096 (order: 3, 32768 byte=
s, linear)
> [    0.223206] Mountpoint-cache hash table entries: 4096 (order: 3, 32768=
 bytes, linear)
> [    0.224615] x86/cpu: User Mode Instruction Prevention (UMIP) activated
> [    0.225864] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [    0.227472] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [    0.228459] Spectre V1 : Mitigation: usercopy/swapgs barriers and __us=
er pointer sanitization
> [    0.229849] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eI=
BRS on, data leaks possible via Spectre v2 BHB attacks!
> [    0.231471] Spectre V2 : Mitigation: Enhanced IBRS
> [    0.232249] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling R=
SB on context switch
> [    0.233602] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CAL=
L on VMEXIT
> [    0.235472] Spectre V2 : mitigation: Enabling conditional Indirect Bra=
nch Prediction Barrier
> [    0.236839] Speculative Store Bypass: Mitigation: Speculative Store By=
pass disabled via prctl
> [    0.238226] MMIO Stale Data: Unknown: No mitigations
> [    0.354792] Freeing SMP alternatives memory: 56K
> [    0.355764] smpboot: CPU0: Intel(R) Xeon(R) Gold 6414TDX (family: 0x6,=
 model: 0x8f, stepping: 0x6)
> [    0.357598] cblist_init_generic: Setting adjustable number of callback=
 queues.
> [    0.358664] cblist_init_generic: Setting shift to 1 and lim to 1.
> [    0.359465] cblist_init_generic: Setting shift to 1 and lim to 1.
> [    0.359526] cblist_init_generic: Setting shift to 1 and lim to 1.
> [    0.360539] Running RCU-tasks wait API self tests
> [    0.463628] Performance Events: Sapphire Rapids events, full-width cou=
nters, Intel PMU driver.
> [    0.465311] ... version:                2
> [    0.466020] ... bit width:              48
> [    0.466742] ... generic registers:      8
> [    0.467447] ... value mask:             0000ffffffffffff
> [    0.467474] ... max period:             00007fffffffffff
> [    0.468418] ... fixed-purpose events:   3
> [    0.469123] ... event mask:             00000007000000ff
> [    0.470648] rcu: Hierarchical SRCU implementation.
> [    0.471473] rcu: 	Max phase no-delay instances is 1000.
> [    0.474503] smp: Bringing up secondary CPUs ...
> [    0.475976] x86: Booting SMP configuration:
> [    0.476741] .... node  #0, CPUs:      #1
> [    0.477391] smp: Brought up 1 node, 2 CPUs
> [    0.477391] smpboot: Max logical packages: 1
> [    0.479481] smpboot: Total of 2 processors activated (6800.00 BogoMIPS=
)
> [    0.481707] devtmpfs: initialized
> [    0.481707] x86/mm: Memory block size: 128MB
> [    0.483500] Callback from call_rcu_tasks_trace() invoked.
> [    0.487740] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 7645041785100000 ns
> [    0.489159] futex hash table entries: 512 (order: 4, 65536 bytes, line=
ar)
> [    0.490221] pinctrl core: initialized pinctrl subsystem
> [    0.491638]=20
> [    0.491828] **********************************************************=
***
> [    0.492616] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   =
 **
> [    0.493388] **                                                        =
 **
> [    0.494161] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL =
 **
> [    0.494933] **                                                        =
 **
> [    0.495472] ** This means that this kernel is built to expose internal=
 **
> [    0.496248] ** IOMMU data structures, which may compromise security on=
 **
> [    0.497037] ** your system.                                           =
 **
> [    0.497808] **                                                        =
 **
> [    0.498579] ** If you see this message and you are not debugging the  =
 **
> [    0.499367] ** kernel, report this immediately to your vendor!        =
 **
> [    0.499471] **                                                        =
 **
> [    0.500257] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   =
 **
> [    0.501027] **********************************************************=
***
> [    0.501840] PM: RTC time: 13:58:27, date: 2023-01-24
> [    0.505411] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.506953] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic alloc=
ations
> [    0.507489] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atom=
ic allocations
> [    0.508222] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for at=
omic allocations
> [    0.508996] audit: initializing netlink subsys (disabled)
> [    0.509559] audit: type=3D2000 audit(1674568707.998:1): state=3Dinitia=
lized audit_enabled=3D0 res=3D1
> [    0.509559] thermal_sys: Registered thermal governor 'fair_share'
> [    0.509559] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.509559] thermal_sys: Registered thermal governor 'step_wise'
> [    0.511473] thermal_sys: Registered thermal governor 'user_space'
> [    0.512063] cpuidle: using governor ladder
> [    0.513100] cpuidle: using governor menu
> [    0.513931] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.514942] PCI: Using configuration type 1 for base access
> [    0.516796] kprobes: kprobe jump-optimization is enabled. All kprobes =
are optimized if possible.
> [    0.764744] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pa=
ges
> [    0.765537] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB pag=
e
> [    0.766083] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pa=
ges
> [    0.766639] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.769641] ACPI: Added _OSI(Module Device)
> [    0.770021] ACPI: Added _OSI(Processor Device)
> [    0.770393] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.770785] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.777000] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [    0.780984] ACPI: Interpreter enabled
> [    0.781403] ACPI: PM: (supports S0 S3 S4 S5)
> [    0.781764] ACPI: Using IOAPIC for interrupt routing
> [    0.782220] PCI: Using host bridge windows from ACPI; if necessary, us=
e "pci=3Dnocrs" and report a bug
> [    0.782965] PCI: Using E820 reservations for host bridge windows
> [    0.784187] ACPI: Enabled 2 GPEs in block 00 to 0F
> [    0.802373] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.802968] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments =
MSI EDR HPX-Type3]
> [    0.803477] acpi PNP0A03:00: _OSC: not requesting OS control; OS requi=
res [ExtendedConfig ASPM ClockPM MSI]
> [    0.804416] acpi PNP0A03:00: fail to add MMCONFIG information, can't a=
ccess extended configuration space under this bridge
> [    0.808164] acpiphp: Slot [3] registered
> [    0.808611] acpiphp: Slot [4] registered
> [    0.809023] acpiphp: Slot [5] registered
> [    0.809426] acpiphp: Slot [6] registered
> [    0.809820] acpiphp: Slot [7] registered
> [    0.810214] acpiphp: Slot [8] registered
> [    0.810609] acpiphp: Slot [9] registered
> [    0.811005] acpiphp: Slot [10] registered
> [    0.811407] acpiphp: Slot [11] registered
> [    0.811540] acpiphp: Slot [12] registered
> [    0.811941] acpiphp: Slot [13] registered
> [    0.812342] acpiphp: Slot [14] registered
> [    0.812744] acpiphp: Slot [15] registered
> [    0.813145] acpiphp: Slot [16] registered
> [    0.813546] acpiphp: Slot [17] registered
> [    0.813949] acpiphp: Slot [18] registered
> [    0.814350] acpiphp: Slot [19] registered
> [    0.814755] acpiphp: Slot [20] registered
> [    0.815159] acpiphp: Slot [21] registered
> [    0.815536] acpiphp: Slot [22] registered
> [    0.815937] acpiphp: Slot [23] registered
> [    0.816341] acpiphp: Slot [24] registered
> [    0.816742] acpiphp: Slot [25] registered
> [    0.817142] acpiphp: Slot [26] registered
> [    0.817544] acpiphp: Slot [27] registered
> [    0.817950] acpiphp: Slot [28] registered
> [    0.818351] acpiphp: Slot [29] registered
> [    0.818758] acpiphp: Slot [30] registered
> [    0.819165] acpiphp: Slot [31] registered
> [    0.819491] PCI host bridge to bus 0000:00
> [    0.819836] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 wind=
ow]
> [    0.820401] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff wind=
ow]
> [    0.820962] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bf=
fff window]
> [    0.821579] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebff=
fff window]
> [    0.822199] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17ff=
fffff window]
> [    0.822838] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.823399] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
> [    0.826599] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
> [    0.827838] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
> [    0.829880] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
> [    0.831017] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-=
0x01f7]
> [    0.831480] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> [    0.832025] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-=
0x0177]
> [    0.832614] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> [    0.833457] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
> [    0.834284] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PI=
IX4 ACPI
> [    0.834889] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PI=
IX4 SMB
> [    0.835761] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
> [    0.837416] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pre=
f]
> [    0.839479] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
> [    0.842136] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pre=
f]
> [    0.842829] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0=
x000c0000-0x000dffff]
> [    0.846431] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
> [    0.847475] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
> [    0.848709] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
> [    0.851475] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pre=
f]
> [    0.863622] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
> [    0.864567] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> [    0.865438] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
> [    0.866300] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> [    0.866969] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
> [    0.868728] iommu: Default domain type: Translated=20
> [    0.869134] iommu: DMA domain TLB invalidation policy: lazy mode=20
> [    0.871571] SCSI subsystem initialized
> [    0.872206] ACPI: bus type USB registered
> [    0.872584] usbcore: registered new interface driver usbfs
> [    0.873058] usbcore: registered new interface driver hub
> [    0.873537] usbcore: registered new device driver usb
> [    0.874079] pps_core: LinuxPPS API ver. 1 registered
> [    0.874483] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolf=
o Giometti <giometti@linux.it>
> [    0.875222] PTP clock support registered
> [    0.875631] EDAC MC: Ver: 3.0.0
> [    0.878087] NetLabel: Initializing
> [    0.878397] NetLabel:  domain hash size =3D 128
> [    0.878751] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
> [    0.879277] NetLabel:  unlabeled traffic allowed by default
> [    0.879900] PCI: Using ACPI for IRQ routing
> [    0.880485] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.880996] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.881459] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+m=
em,owns=3Dio+mem,locks=3Dnone
> [    0.882141] vgaarb: loaded
> [    0.883312] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    0.883474] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
> [    3.472079] clocksource: Switched to clocksource kvm-clock
> [    3.522497] Callback from call_rcu_tasks_rude() invoked.
> [    3.579612] Callback from call_rcu_tasks() invoked.
> [    3.637828] VFS: Disk quotas dquot_6.6.0
> [    3.638759] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 by=
tes)
> [    3.640788] pnp: PnP ACPI init
> [    3.643123] pnp: PnP ACPI: found 6 devices
> [    3.655759] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,=
 max_idle_ns: 2085701024 ns
> [    3.656836] NET: Registered PF_INET protocol family
> [    3.657355] IP idents hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
> [    3.658829] tcp_listen_portaddr_hash hash table entries: 1024 (order: =
4, 73728 bytes, linear)
> [    3.659569] Table-perturb hash table entries: 65536 (order: 6, 262144 =
bytes, linear)
> [    3.660253] TCP established hash table entries: 16384 (order: 5, 13107=
2 bytes, linear)
> [    3.661151] TCP bind hash table entries: 16384 (order: 9, 2359296 byte=
s, linear)
> [    3.662924] TCP: Hash tables configured (established 16384 bind 16384)
> [    3.663582] UDP hash table entries: 1024 (order: 5, 163840 bytes, line=
ar)
> [    3.664186] UDP-Lite hash table entries: 1024 (order: 5, 163840 bytes,=
 linear)
> [    3.664936] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    3.665829] RPC: Registered named UNIX socket transport module.
> [    3.666331] RPC: Registered udp transport module.
> [    3.666723] RPC: Registered tcp transport module.
> [    3.667113] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    3.667680] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    3.668195] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    3.668717] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff win=
dow]
> [    3.669286] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff win=
dow]
> [    3.669856] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff w=
indow]
> [    3.670687] pci 0000:00:01.0: PIIX3: Enabling Passive Release
> [    3.671177] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> [    3.671801] PCI: CLS 0 bytes, default 64
> [    3.672166] ACPI: bus type thunderbolt registered
> [    3.672862] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1=
881273ac8e, max_idle_ns: 440795257284 ns
> [    3.673770] sgx: There are zero EPC sections.
> [    3.677660] Initialise system trusted keyrings
> [    3.678131] Key type blacklist registered
> [    3.678624] workingset: timestamp_bits=3D36 max_order=3D19 bucket_orde=
r=3D0
> [    3.679238] zbud: loaded
> [    3.680209] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    3.681390] NFS: Registering the id_resolver key type
> [    3.681826] Key type id_resolver registered
> [    3.682169] Key type id_legacy registered
> [    3.682520] nfs4filelayout_init: NFSv4 File Layout Driver Registering.=
..
> [    3.683088] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regi=
stering...
> [    3.683823] fuse: init (API version 7.38)
> [    3.684304] SGI XFS with ACLs, security attributes, realtime, quota, n=
o debug enabled
> [    3.685454] 9p: Installing v9fs 9p2000 file system support
> [    3.693413] Key type asymmetric registered
> [    3.693761] Asymmetric key parser 'x509' registered
> [    3.694207] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 243)
> [    3.694943] io scheduler mq-deadline registered
> [    3.695367] io scheduler bfq registered
> [    3.696136] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
.4
> [    3.697120] IPMI message handler: version 39.2
> [    3.697550] ipmi device interface
> [    3.699594] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/in=
put/input0
> [    3.700489] ACPI: button: Power Button [PWRF]
> [    3.701854] ERST DBG: ERST support is disabled.
> [    3.702823] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    3.703842] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
) is a 16550A
> [    3.713080] Linux agpgart interface v0.103
> [    3.714194] ACPI: bus type drm_connector registered
> [    3.727560] brd: module loaded
> [    3.734613] loop: module loaded
> [    3.739114] scsi host0: ata_piix
> [    3.739922] scsi host1: ata_piix
> [    3.740361] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq=
 14
> [    3.740925] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq=
 15
> [    3.742749] tun: Universal TUN/TAP device driver, 1.6
> [    3.743318] e100: Intel(R) PRO/100 Network Driver
> [    3.743730] e100: Copyright(c) 1999-2006 Intel Corporation
> [    3.744212] e1000: Intel(R) PRO/1000 Network Driver
> [    3.744614] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    3.899576] ata1: found unknown device (class 0)
> [    3.900466] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
> [    3.900943] ata1.00: 16777216 sectors, multi 16: LBA48=20
> [    3.902597] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    =
2.5+ PQ: 0 ANSI: 5
> [    3.904202] scsi 0:0:0:0: Attached scsi generic sg0 type 0
> [    3.905299] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.59 =
GB/8.00 GiB)
> [    3.905952] sd 0:0:0:0: [sda] Write Protect is off
> [    3.906388] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
> [    3.907213] ata2: found unknown device (class 0)
> [    3.907837] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
> [    3.908780] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> [    3.911124] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     =
2.5+ PQ: 0 ANSI: 5
> [    3.930497] ACPI: \_SB_.LNKC: Enabled at IRQ 11
> [    3.932292] scsi 1:0:0:0: Attached scsi generic sg1 type 5
> [    3.933232] sd 0:0:0:0: [sda] Attached SCSI disk
> [    4.254732] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34=
:56
> [    4.255331] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connect=
ion
> [    4.255996] e1000e: Intel(R) PRO/1000 Network Driver
> [    4.256405] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    4.256951] igb: Intel(R) Gigabit Ethernet Network Driver
> [    4.257395] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    4.257944] PPP generic driver version 2.4.2
> [    4.258869] VFIO - User Level meta-driver version: 0.3
> [    4.259699] usbcore: registered new interface driver uas
> [    4.260192] usbcore: registered new interface driver usb-storage
> [    4.260858] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0=
x60,0x64 irq 1,12
> [    4.262237] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    4.262691] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    4.263798] mousedev: PS/2 mouse device common for all mice
> [    4.265019] input: AT Translated Set 2 keyboard as /devices/platform/i=
8042/serio0/input/input1
> [    4.266849] input: VirtualPS/2 VMware VMMouse as /devices/platform/i80=
42/serio1/input/input4
> [    4.267610] rtc_cmos 00:05: RTC can wake from S4
> [    4.268319] input: VirtualPS/2 VMware VMMouse as /devices/platform/i80=
42/serio1/input/input3
> [    4.269188] rtc_cmos 00:05: registered as rtc0
> [    4.269654] rtc_cmos 00:05: setting system clock to 2023-01-24T13:58:3=
0 UTC (1674568710)
> [    4.270504] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram=
, hpet irqs
> [    4.271135] i2c_dev: i2c /dev entries driver
> [    4.271554] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled=
. Duplicate IMA measurements will not be recorded in the IMA log.
> [    4.272528] device-mapper: uevent: version 1.0.3
> [    4.273077] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialise=
d: dm-devel@redhat.com
> [    4.273757] intel_pstate: CPU model not supported
> [    4.274224] sdhci: Secure Digital Host Controller Interface driver
> [    4.274717] sdhci: Copyright(c) Pierre Ossman
> [    4.275135] sdhci-pltfm: SDHCI platform and OF driver helper
> [    4.275667] ledtrig-cpu: registered to indicate activity on CPUs
> [    4.276493] drop_monitor: Initializing network drop monitor service
> [    4.277189] NET: Registered PF_INET6 protocol family
> [    4.280112] Segment Routing with IPv6
> [    4.280462] In-situ OAM (IOAM) with IPv6
> [    4.280848] NET: Registered PF_PACKET protocol family
> [    4.281425] 9pnet: Installing 9P2000 support
> [    4.281842] Key type dns_resolver registered
> [    4.282968] IPI shorthand broadcast: enabled
> [    4.298578] sched_clock: Marking stable (4269752033, 25716914)->(43102=
25125, -14756178)
> [    4.299817] registered taskstats version 1
> [    4.300354] Loading compiled-in X.509 certificates
> [    4.300887] zswap: loaded using pool lzo/zbud
> [    4.317209] Key type .fscrypt registered
> [    4.317561] Key type fscrypt-provisioning registered
> [    4.318838] Key type encrypted registered
> [    4.319232] ima: No TPM chip found, activating TPM-bypass!
> [    4.319716] ima: Allocated hash algorithm: sha1
> [    4.320136] ima: No architecture policies found
> [    4.320578] evm: Initialising EVM extended attributes:
> [    4.321008] evm: security.selinux
> [    4.321290] evm: security.SMACK64
> [    4.321572] evm: security.SMACK64EXEC
> [    4.321877] evm: security.SMACK64TRANSMUTE
> [    4.322219] evm: security.SMACK64MMAP
> [    4.322527] evm: security.apparmor
> [    4.322813] evm: security.ima
> [    4.323065] evm: security.capability
> [    4.323365] evm: HMAC attrs: 0x1
> [    4.324935] PM:   Magic number: 7:593:989
> [    4.325718] RAS: Correctable Errors collector initialized.
> [    4.327419] md: Waiting for all devices to be available before autodet=
ect
> [    4.327844] md: If you don't use raid, use raid=3Dnoautodetect
> [    4.328191] md: Autodetecting RAID arrays.
> [    4.328436] md: autorun ...
> [    4.328600] md: ... autorun DONE.
> [    4.332168] EXT4-fs (sda): INFO: recovery required on readonly filesys=
tem
> [    4.332579] EXT4-fs (sda): write access will be enabled during recover=
y
> [    4.409761] EXT4-fs (sda): recovery complete
> [    4.411039] EXT4-fs (sda): mounted filesystem 23a53bb9-f815-47a5-b74c-=
5e08f7731193 with ordered data mode. Quota mode: none.
> [    4.411735] VFS: Mounted root (ext4 filesystem) readonly on device 8:0=
.
> [    4.412508] devtmpfs: mounted
> [    4.422200] Freeing unused decrypted memory: 2036K
> [    4.427147] Freeing unused kernel image (initmem) memory: 10172K
> [    4.427556] Write protecting the kernel read-only data: 45056k
> [    4.429148] Freeing unused kernel image (rodata/data gap) memory: 240K
> [    4.524814] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    4.525202] Run /sbin/init as init process
> [    4.605053] systemd[1]: RTC configured in localtime, applying delta of=
 0 minutes to system time.
> [    4.630002] systemd[1]: systemd 239 (239-49.el8) running in system mod=
e. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSET=
UP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN=
 +PCRE2 default-hierarchy=3Dlegacy)
> [    4.631428] systemd[1]: Detected virtualization kvm.
> [    4.631740] systemd[1]: Detected architecture x86-64.
>=20
> Welcome to =1B[0;31mCentOS Stream 8=1B[0m!
>=20
> [    4.681783] systemd[1]: Set hostname to <test>.
> [    4.938881] systemd[1]: Created slice system-sshd\x2dkeygen.slice.
> [=1B[0;32m  OK  =1B[0m] Created slice system-sshd\x2dkeygen.slice.
> [    4.940771] systemd[1]: Created slice system-getty.slice.
> [=1B[0;32m  OK  =1B[0m] Created slice system-getty.slice.
> [    4.941726] systemd[1]: Listening on multipathd control socket.
> [=1B[0;32m  OK  =1B[0m] Listening on multipathd control socket.
> [    4.942836] systemd[1]: Listening on udev Control Socket.
> [=1B[0;32m  OK  =1B[0m] Listening on udev Control Socket.
> [    4.943798] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> [=1B[0;32m  OK  =1B[0m] Listening on Device-mapper event daemon FIFOs.
> [    4.944899] systemd[1]: Listening on LVM2 poll daemon socket.
> [=1B[0;32m  OK  =1B[0m] Listening on LVM2 poll daemon socket.
> [=1B[0;32m  OK  =1B[0m] Listening on Process Core Dump Socket.
> [=1B[0;32m  OK  =1B[0m] Started Forward Password Requests to Wall Directo=
ry Watch.
> [=1B[0;32m  OK  =1B[0m] Listening on udev Kernel Socket.
> [=1B[0;32m  OK  =1B[0m] Set up automount Arbitrary Executab=E2=80=A6rmats=
 File System Automount Point.
> [=1B[0;32m  OK  =1B[0m] Reached target Swap.
> [=1B[0;32m  OK  =1B[0m] Listening on Journal Socket.
>          Mounting Huge Pages File System...
>          Starting Setup Virtual Console...
>          Mounting POSIX Message Queue File System...
>          Mounting Kernel Debug File System...
>          Starting Remount Root and Kernel File Systems...
>          Starting Monitoring of LVM2 mirrors=E2=80=A6ng dmeventd or progr=
ess polling...
> [=1B[0;32m  OK  =1B[0m] Created slice User and Session Slice.
> [=1B[0;32m  OK  =1B[0m] Reached target Slices.
> [=1B[0;32m  OK  =1B[0m] Created slice system-serial\x2dgetty.slice.
> [=1B[0;32m  OK  =1B[0m] Listening on Journal Socket (/dev/log).
>          Starting Journal Service...
>          Starting Load Kernel Modules...
>          Starting udev Coldplug all Devices...
> [=1B[0;32m  OK  =1B[0m] Listening on RPCbind Server Activation Socket.
> [=1B[0;32m  OK  =1B[0m] Reached target RPC Port Mapper.
> [=1B[0;32m  OK  =1B[0m] Listening on initctl Compatibility Named Pipe.
> [=1B[0;32m  OK  =1B[0m] Mounted Huge Pages File System.
> [=1B[0;32m  OK  =1B[0m] Mounted POSIX Message Queue File System.
> [=1B[0;32m  OK  =1B[0m] Mounted Kernel Debug File System.
> [=1B[0;1;31mFAILED=1B[0m] Failed to start Load Kernel Modules.
> See 'systemctl status systemd-modules-load.service' for details.
>          Starting Apply Kernel Variables...
>          Mounting Kernel Configuration File System...
>          Mounting FUSE Control File System...
> [=1B[0;32m  OK  =1B[0m] Mounted Kernel Configuration File System.
> [=1B[0;32m  OK  =1B[0m] Mounted FUSE Control File System.
> [=1B[0;32m  OK  =1B[0m] Started Apply Kernel Variables.
> [    5.335899] EXT4-fs (sda): re-mounted 23a53bb9-f815-47a5-b74c-5e08f773=
1193. Quota mode: none.
> [=1B[0;32m  OK  =1B[0m] Started Journal Service.
> [=1B[0;32m  OK  =1B[0m] Started Remount Root and Kernel File Systems.
>          Starting Load/Save Random Seed...
>          Starting Create Static Device Nodes in /dev...
>          Starting Flush Journal to Persistent Storage...
> [=1B[0;32m  OK  =1B[0m] Started Setup Virtual Console.
> [=1B[0;32m  OK  =1B[0m] Started Load/Save Random Seed.
> [=1B[0;32m  OK  =1B[0m] Started Flush Journal to Persistent Storage.
> [=1B[0;32m  OK  =1B[0m] Started udev Coldplug all Devices.
>          Starting udev Wait for Complete Device Initialization...
> [=1B[0;32m  OK  =1B[0m] Started Create Static Device Nodes in /dev.
>          Starting udev Kernel Device Manager...
> [=1B[0;32m  OK  =1B[0m] Started udev Kernel Device Manager.
>          Starting Show Plymouth Boot Screen...
> [=1B[0;32m  OK  =1B[0m] Started Show Plymouth Boot Screen.
> [=1B[0;32m  OK  =1B[0m] Started Forward Password Requests to Plymouth Dir=
ectory Watch.
> [=1B[0;32m  OK  =1B[0m] Reached target Local Encrypted Volumes.
> [=1B[0;32m  OK  =1B[0m] Reached target Paths.
> [=1B[0;32m  OK  =1B[0m] Found device /dev/ttyS0.
> [=1B[0;32m  OK  =1B[0m] Started Monitoring of LVM2 mirrors,=E2=80=A6sing =
dmeventd or progress polling.
> [=1B[0;32m  OK  =1B[0m] Listening on Load/Save RF Kill Switch Status /dev=
/rfkill Watch.
> [=1B[0;32m  OK  =1B[0m] Started udev Wait for Complete Device Initializat=
ion.
> [=1B[0;32m  OK  =1B[0m] Reached target Local File Systems (Pre).
> [=1B[0;32m  OK  =1B[0m] Reached target Local File Systems.
>          Starting Create Volatile Files and Directories...
>          Starting Restore /run/initramfs on shutdown...
>          Starting Tell Plymouth To Write Out Runtime Data...
> [=1B[0;32m  OK  =1B[0m] Started Create Volatile Files and Directories.
> [=1B[0;32m  OK  =1B[0m] Started Restore /run/initramfs on shutdown.
> [=1B[0;32m  OK  =1B[0m] Started Tell Plymouth To Write Out Runtime Data.
>          Starting RPC Bind...
>          Starting Security Auditing Service...
>          Mounting RPC Pipe File System...
> [=1B[0;32m  OK  =1B[0m] Mounted RPC Pipe File System.
> [=1B[0;32m  OK  =1B[0m] Reached target rpc_pipefs.target.
> [=1B[0;32m  OK  =1B[0m] Started RPC Bind.
> [=1B[0;32m  OK  =1B[0m] Started Security Auditing Service.
>          Starting Update UTMP about System Boot/Shutdown...
> [=1B[0;32m  OK  =1B[0m] Started Update UTMP about System Boot/Shutdown.
> [=1B[0;32m  OK  =1B[0m] Reached target System Initialization.
> [=1B[0;32m  OK  =1B[0m] Started Daily Cleanup of Temporary Directories.
> [=1B[0;32m  OK  =1B[0m] Started dnf makecache --timer.
> [=1B[0;32m  OK  =1B[0m] Listening on SSSD Kerberos Cache Manager responde=
r socket.
> [=1B[0;32m  OK  =1B[0m] Started daily update of the root trust anchor for=
 DNSSEC.
> [=1B[0;32m  OK  =1B[0m] Reached target Timers.
> [=1B[0;32m  OK  =1B[0m] Listening on D-Bus System Message Bus Socket.
> [=1B[0;32m  OK  =1B[0m] Reached target Sockets.
> [=1B[0;32m  OK  =1B[0m] Reached target Basic System.
>          Starting NTP client/server...
> [=1B[0;32m  OK  =1B[0m] Started Machine Check Exception Logging Daemon.
> [=1B[0;32m  OK  =1B[0m] Started irqbalance daemon.
>          Starting Authorization Manager...
>          Starting Auto-connect to subsystems=E2=80=A6-NVME devices found =
during boot...
>          Starting Self Monitoring and Reporting Technology (SMART) Daemon=
...
> [=1B[0;32m  OK  =1B[0m] Reached target sshd-keygen.target.
> [=1B[0;32m  OK  =1B[0m] Started D-Bus System Message Bus.
>          Starting Network Manager...
>          Starting Login Service...
> [=1B[0;32m  OK  =1B[0m] Started Auto-connect to subsystems =E2=80=A6FC-NV=
ME devices found during boot.
>          Starting update of the root trust a=E2=80=A6or DNSSEC validation=
 in unbound...
> [=1B[0;32m  OK  =1B[0m] Started Self Monitoring and Reporting Technology =
(SMART) Daemon.
> [=1B[0;32m  OK  =1B[0m] Started NTP client/server.
> [=1B[0;32m  OK  =1B[0m] Started Login Service.
> [=1B[0;32m  OK  =1B[0m] Started Network Manager.
>          Starting Network Manager Wait Online...
> [=1B[0;32m  OK  =1B[0m] Reached target Network.
>          Starting GSSAPI Proxy Daemon...
>          Starting OpenSSH server daemon...
>          Starting Dynamic System Tuning Daemon...
> [=1B[0;32m  OK  =1B[0m] Started update of the root trust an=E2=80=A6 for =
DNSSEC validation in unbound.
>          Starting Hostname Service...
> [=1B[0;32m  OK  =1B[0m] Started GSSAPI Proxy Daemon.
> [=1B[0;32m  OK  =1B[0m] Reached target NFS client services.
> [=1B[0;32m  OK  =1B[0m] Reached target Remote File Systems (Pre).
> [=1B[0;32m  OK  =1B[0m] Reached target Remote File Systems.
>          Starting Permit User Sessions...
> [=1B[0;32m  OK  =1B[0m] Started OpenSSH server daemon.
> [=1B[0;32m  OK  =1B[0m] Started Permit User Sessions.
> [=1B[0;32m  OK  =1B[0m] Started Command Scheduler.
>          Starting Hold until boot process finishes up...
>          Starting Terminate Plymouth Boot Screen...
> [=1B[0;32m  OK  =1B[0m] Started Authorization Manager.
> [    7.395789] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Con=
trol: RX
> [    7.396849] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [    7.613459] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eI=
BRS on, data leaks possible via Spectre v2 BHB attacks!
> [    7.614188] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eI=
BRS on, data leaks possible via Spectre v2 BHB attacks!
>=20
> CentOS Stream 8
> Kernel 6.2.0-rc5-2241ab53cbb5 on an x86_64
>=20
> test login: [  300.211554] INFO: task kworker/u4:2:32 blocked for more th=
an 147 seconds.
> [  300.212512]       Not tainted 6.2.0-rc5-2241ab53cbb5 #1
> [  300.213087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  300.213921] task:kworker/u4:2    state:D stack:0     pid:32    ppid:2 =
     flags:0x00004000
> [  300.214849] Workqueue: events_unbound io_ring_exit_work
> [  300.215506] Call Trace:
> [  300.215789]  <TASK>
> [  300.216051]  __schedule+0x385/0xb00
> [  300.216467]  ? write_comp_data+0x2f/0x90
> [  300.216949]  ? wait_for_completion+0x7b/0x180
> [  300.217445]  schedule+0x5b/0xe0
> [  300.217836]  schedule_timeout+0x561/0x650
> [  300.218301]  ? _raw_spin_unlock_irq+0x2b/0x60
> [  300.218816]  ? wait_for_completion+0x7b/0x180
> [  300.219341]  ? __this_cpu_preempt_check+0x20/0x30
> [  300.219893]  ? lockdep_hardirqs_on+0x8a/0x110
> [  300.220384]  ? _raw_spin_unlock_irq+0x2b/0x60
> [  300.220881]  ? wait_for_completion+0x9e/0x180
> [  300.221382]  ? trace_hardirqs_on+0x3f/0x100
> [  300.221868]  ? wait_for_completion+0x7b/0x180
> [  300.222379]  wait_for_completion+0xa6/0x180
> [  300.222897]  io_ring_exit_work+0x2f7/0x747
> [  300.223383]  ? __pfx_io_tctx_exit_cb+0x10/0x10
> [  300.223947]  process_one_work+0x3b1/0x960
> [  300.224446]  worker_thread+0x52/0x660
> [  300.224884]  ? __pfx_worker_thread+0x10/0x10
> [  300.225376]  kthread+0x161/0x1a0
> [  300.225782]  ? __pfx_kthread+0x10/0x10
> [  300.226225]  ret_from_fork+0x29/0x50
> [  300.226688]  </TASK>
> [  300.227791]=20
> [  300.227791] Showing all locks held in the system:
> [  300.228501] 1 lock held by rcu_tasks_kthre/11:
> [  300.229003]  #0: ffffffff83d617b0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:=
3}, at: rcu_tasks_one_gp+0x2d/0x3d0
> [  300.230098] 1 lock held by rcu_tasks_rude_/12:
> [  300.230601]  #0: ffffffff83d61530 (rcu_tasks_rude.tasks_gp_mutex){+.+.=
}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
> [  300.231733] 1 lock held by rcu_tasks_trace/13:
> [  300.232244]  #0: ffffffff83d61270 (rcu_tasks_trace.tasks_gp_mutex){+.+=
.}-{3:3}, at: rcu_tasks_one_gp+0x2d/0x3d0
> [  300.233377] 1 lock held by khungtaskd/29:
> [  300.233842]  #0: ffffffff83d621c0 (rcu_read_lock){....}-{1:2}, at: deb=
ug_show_all_locks+0x27/0x18c
> [  300.234866] 2 locks held by kworker/u4:2/32:
> [  300.235351]  #0: ff11000006045d38 ((wq_completion)events_unbound){+.+.=
}-{0:0}, at: process_one_work+0x2ff/0x960
> [  300.236502]  #1: ffa0000000117e60 ((work_completion)(&ctx->exit_work))=
{+.+.}-{0:0}, at: process_one_work+0x303/0x960
> [  300.237696]=20
> [  300.237882] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> [  300.237882]=20

