Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927C96E04CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 04:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjDMCre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 22:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjDMCrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:47:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B40A5CA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 19:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681353995; x=1712889995;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kUMlpb+BLslNXqjPDVsLvMT8AHvQmEKkLWEPmiteyBE=;
  b=iGc0GypEEnv6evFuDV+WiQVaWCB31vB1vczEuLqNwBKiW+XcnVIPe8t5
   3aLykrkC/tkwHrhKyrP4hH1uPZcuHAFm26GoYrj2pIkBdYJ8IpNQ0K2Yc
   vzSYjttgHUO08OGX3uPc4fsWzgwDVlnfi+DQNjjSW4OvpqA1RFhd/avGl
   QfPODW6PkihotFT/4pRhenav7Hu9cXyTWqPhvcDBCOf8PO/y2+UlnVpKK
   Kw7EaPEhowu8+wT5JFiVLJ9EppArDIDi1oXBHdbLaGiKV1W22Hi/+WEy3
   Qhb7Ul50RDxMCsrIOxwVjcVmA2br6bktEYzGYJoNljCj7q105aE9O6onP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332775692"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332775692"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 19:44:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="721810074"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="721810074"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 12 Apr 2023 19:44:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 19:44:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 19:44:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 19:44:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtursGcgVnGnOTVISLylDflPVLDL6uA0Ee6HnHm9h7tdeTrQ0QrY8A5Ya79T4n/7jhrPWzfMgIIRogUV70vU3V3M2clueVzwVh4QNGemnA/iTTM2g5jRTZ7P1jmH0aJjSzKR4JcId4OCF4j9krHiU11zN4cfsDjXRt/OfMgF5O5giKXhtar1XUXIgAVegIFc9hjJrbHrFpZjF14e/lu+cfpAjL3odVWzTU1/YbYxSlmxWj4j2ZsNFC3GCtFtCjQRTlW+zPgLxy3LRvJ05JtsCOtlseEOCySM6kvEEy/+py8pPsA/kxXfRyYuicy9LrRYTcIoiBZOiXPqeTAcPUSzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm/MuMWbUIQg/oBkyWkdBrMsHvTXZRUwVQSAvxI++9o=;
 b=HLd7NnO+zjU5XbAiOTzGdcQWx3oAyY7Ng89JWw9M3/tlxQVOSCOEd7lSvoITExergsrc66hPnHhUS0Gm22dc7kZWmRPG5Ex6EqDfAUs6+jcR9IGRIsGmyxxZapn/3zxum12Y9kH4xsjeY1FZSwPlw/ZyuAlyq0i0FltTI8I++HOrOQS9CHhywVOGURhLYgaD56Y1owppeLaPEI7VVC75Y510jTmrVdKbdv13nQPhL4mnOFYhXJN4XKGFcEUWDiLHawSNFaRQjOXX2CyH1YUnrcemgFITIJ4BlmuPTyUm0NhhYdH8pShdOKzgfz7rUvftZsC2PAofVexBluchgw2hZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SN7PR11MB7018.namprd11.prod.outlook.com (2603:10b6:806:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Thu, 13 Apr
 2023 02:44:01 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 02:44:01 +0000
Date:   Thu, 13 Apr 2023 10:45:35 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <lihuafei1@huawei.com>
CC:     <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>, <frederic@kernel.org>, <quic_neeraju@quicinc.com>,
        <paulmck@kernel.org>, <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is "task hung in synchronize_rcu
 bisect" in v6.3-rc2 kernel
Message-ID: <ZDdsz+5/QehZ25hg@xpf.sh.intel.com>
References: <ZBG4HOCQIlGFFcIn@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBG4HOCQIlGFFcIn@xpf.sh.intel.com>
X-ClientProxiedBy: SG2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:3:17::30) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SN7PR11MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c673a4-72ba-4ca3-45d0-08db3bc8efe9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2ILfhKwlT9q6hk9Z/H2AfPtH5c5pGTb5e3rkreCFRDwWd02powCzCABe0E2R28olByaOLklVWuGFW8Ctn+9Fimq1QDGrNF8ODSCOJyjBD0tLuEMWAVYFnuM0JsmyR5EjGff2OvnLL520sstoDGRq6CpDE2IeoMMFRAvRO0NmigUKG50LliJETIg9CYVh7HDfIcHpyWzrUfQ2xZYJcdOcgGA3aq8x5y/78YFZaSMvusBADUuhih2xM5RzDiBoRQMkc9RFEqh2tnzCo/r743/6YGoSHgLtr9adi+jv2eR5u8CY5+KGW+KISNTNBLFArjZIpTXQ+FWqhwAGVOTI8wbAQF++PHrc3QdaW5blMBQJ8pTwePgWjr4wwOo5KEqgUTZUmbk+Ky7itJPg1H9tid1OWhWeVbMfI1lP8OB1y9cIDKmORwjo+2lVOHSFfZBsD4+qbwsPrkp5GYhNbhUfGqNF8g4sEIQrrpHI4FgNP4f7/ggMJ7qMXIaQ7OO1PU8Ywg9pi4diRcWRHlLkdoAFPIjh57uRsJ4wi/yaj/9WEhugeXKX54bvOt5e+U8vj2FGb+RBKHXq/tt8uXZrMsmU1JMK6ozqGQeQFk/rabddAirEoZGKbEuesiIyao87ZPiejIz5wdJtewKOQwwK84hGEvZsQbbPnxennqzZuMh665VAIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(966005)(83380400001)(107886003)(6506007)(6666004)(26005)(6512007)(186003)(53546011)(44832011)(2906002)(38100700002)(5660300002)(316002)(82960400001)(66946007)(6916009)(4326008)(66476007)(86362001)(8676002)(8936002)(41300700001)(66556008)(6486002)(478600001)(99710200001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9veS3ZgYpx9Akq4RH45+T0OePghWuTKv9TMGlRSRzB5MvxnreeJwREjb0ZPx?=
 =?us-ascii?Q?N9yjRn7w0aEIhQV19OguPnoJyzhU+xXMR+RfJg0+xvRI2xOusG8CKPxWqw7Y?=
 =?us-ascii?Q?+kY+Z1urCTiQZZg535B5iUdcuZ5SgEAWu6+5NwZghsHKZzUefE61BUel4Q4u?=
 =?us-ascii?Q?HU8uEPG4n7q+jIwisEhp6e96e/UWO5sJmUAAXfBBu/oU48UnZof+WW1ArdZH?=
 =?us-ascii?Q?uc9YXkmL3DqbZyrzc7zTK//lEHIN8cDuhaE6ByHTeDhIUye/M5kCLxuc2FIM?=
 =?us-ascii?Q?QoVGxD/MvWLbNpj2w3RAcgzTeRAaydPhadQub2dPL8aHYU0Yy00KTZ08Xz33?=
 =?us-ascii?Q?pSpErKOzbEITKm+Mt2pRvtAi4g3mrVcIJ3+ppn42E8zHosNxeNyx2Wdghq33?=
 =?us-ascii?Q?fqRpTcn+Kgkri55NXkmBiyGDvxSjjZjauWBylCAq6hhK2yDkIbRP7KlynVt6?=
 =?us-ascii?Q?iS5qNAMuHSRjghpBFLtUqldKQPTPVXXeNLRUyHOSH1QG1MTbJrEWkNi2gaRe?=
 =?us-ascii?Q?PmtKYMel+f5bxFKw4swhVn9HSov9mFzDGae2F3jm/ZtAn4CHxbDVtZnnDKU1?=
 =?us-ascii?Q?ECAdEOKgYwx8QvNyNkKtBMLWLE+1wmzJeERtZimP1Sqvn1e58ATpC5d/Q+R1?=
 =?us-ascii?Q?2Llb1uWZ8PmV6REpz9NM2Zm5VxPup0c6rDM1ovPU1TnfR3Rc5HP+9R1ibzHW?=
 =?us-ascii?Q?uw65UP71EpO5x0phTpIykWsrICw5PvEtbagQQmW+2d8cJLiD6GTTCZYmIIo/?=
 =?us-ascii?Q?3LMIr1rajiQ4+BS1y3P2fJtAwjYkyelgOzx6wjYtGXrxNSXs7YaYdnk0r6WI?=
 =?us-ascii?Q?aPXnCjj8OFyG7wOEPf5hupbVbUteLzUR5mEUOY1rgW9RaDBIVC0PVwWgcFPB?=
 =?us-ascii?Q?Q77VydE4JPG6WCAg+IOh2QncNdYtGEjwbhcYkNGEwKDBXhf/ZmYcauW1nmGQ?=
 =?us-ascii?Q?OSWO0dL6FPZn34M8n5oYCj2TNHhlLqMR0JA3tbcZfMSXtFl02pEi75w41R8a?=
 =?us-ascii?Q?gOiogZlTgvTPdBEjWGLYudL/Gl0of7OMN7jOyRzuo/Pgpr7Vo63GCCRU9u0E?=
 =?us-ascii?Q?wJX6vkLHXSUBrIYnEMoaUSoxyNXes8uH7mdhsxgG1cUilKFeRDeQo7OU1ukx?=
 =?us-ascii?Q?u0jYUtQAODI6sS2NWR5VmFvE6tnyj9ukBFZEwYA+lsW2I6DX+WtZ1Q63S7L9?=
 =?us-ascii?Q?8rNN/s4o8KbGQHyt4CKaM7t3LHA91gKbB+IGDIsHjR4I6Z7aL5d7MDKtaf9u?=
 =?us-ascii?Q?41DAQ1EE0nmkB0rreAoPWtYgdwKnsH3v3zZMpzrQpSU5a6YqQYBi/YAh8cBm?=
 =?us-ascii?Q?fNHKyJb1y/1ZO/CcykluCtlaC3k1sMd5KdrAjzr6MhoFv7NgakqLxl7aeR7I?=
 =?us-ascii?Q?b4jyjRqzFewMErTEy665GiRCpEgJnAuNO/S8LNhqDtnBJTdCYK5fP3GZrPpW?=
 =?us-ascii?Q?l5hqntX3SHOqqcWzT4RmLHf3n2UqtyYLS2AKMMD4MgKmKwb5ZvRDR4kZyktM?=
 =?us-ascii?Q?jLBp2N/kNwp+NeI0rWZw51INsiGsq9cihaBjduQRiAswH7Hg15c5/pBr5Lvk?=
 =?us-ascii?Q?uaBCF0eGsAOyGTFNZipeZ74boSIWYmRZQpH52xhH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c673a4-72ba-4ca3-45d0-08db3bc8efe9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 02:44:00.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvW0ilfgCrEo7WXCzE4mH5jHRVzFA2Ploq2uwLElW9HJPrGSbx0kIDQ82dIab3B84asHiLqzN32t7d6gfV6bHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7018
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huafei and kernel experts,

It's a soft remind.
This issue could be reproduced in v6.3-rc6 kernel.
It could be reproduced on Alder lake, Raptor lake and so on x86 platforms.
After reverted the commit "0e792b89e6800c:ftrace: Fix use-after-free for
dynamic ftrace_ops" on top of v6.3-rc6 kernel, this issue was gone.

New syzkaller reproduced code, repro.report, bisect_info.log and detailed logs
are in link: https://github.com/xupengfe/syzkaller_logs/tree/main/230412_031722_synchronize_rcu

Thanks!
BR.

On 2023-03-15 at 20:20:44 +0800, Pengfei Xu wrote:
> Hi Li Huafei and kernel experts,
> 
> Greeting!
> 
> Platform: x86 platforms
> There is "task hung in synchronize_rcu bisect" in v6.3-rc2 kernel in guest:
> 
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230315_023443_synchronize_rcu
> Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230315_023443_synchronize_rcu/repro.c
> Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230315_023443_synchronize_rcu/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230315_023443_synchronize_rcu/bisect_info.log
> v6.3-rc2 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230315_023443_synchronize_rcu/eeac8ede17557680855031c6f305ece2378af326_dmesg.log
> "
> [   24.844767] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=330 'systemd'
> [   31.392668] hrtimer: interrupt took 10726570 ns
> [   62.552360] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 2942 jiffies old.
> [   92.760386] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 10494 jiffies old.
> [  182.808389] rcu_tasks_wait_gp: rcu_tasks grace period number 9 (since boot) is 33006 jiffies old.
> [  300.120396] INFO: task repro:540 blocked for more than 147 seconds.
> [  300.120937]       Not tainted 6.3.0-rc2-eeac8ede1755+ #1
> [  300.121351] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  300.121888] task:repro           state:D stack:0     pid:540   ppid:538    flags:0x00004006
> [  300.122552] Call Trace:
> [  300.122835]  <TASK>
> [  300.123267]  __schedule+0x40a/0xc90
> [  300.124351]  ? wait_for_completion+0x7b/0x180
> [  300.124772]  schedule+0x5b/0xe0
> [  300.125156]  schedule_timeout+0x50b/0x670
> [  300.125829]  ? schedule_timeout+0x9/0x670
> [  300.126414]  ? wait_for_completion+0x7b/0x180
> [  300.126826]  wait_for_completion+0xa6/0x180
> [  300.127478]  __wait_rcu_gp+0x136/0x160
> [  300.127922]  ? __pfx_arch_ftrace_ops_list_func+0x10/0x10
> [  300.128639]  synchronize_rcu_tasks_generic.part.24+0x3b/0x60
> [  300.129092]  ? __pfx_call_rcu_tasks+0x10/0x10
> [  300.129499]  ? __pfx_wakeme_after_rcu+0x10/0x10
> [  300.130115]  ? verify_cpu+0x10/0x100
> [  300.130574]  synchronize_rcu_tasks_generic+0x24/0x70
> [  300.131020]  synchronize_rcu_tasks+0x19/0x20
> [  300.131438]  ftrace_shutdown+0x1cc/0x410
> [  300.132206]  unregister_ftrace_function+0x35/0x230
> [  300.132722]  ? __sanitizer_cov_trace_switch+0x57/0xa0
> [  300.133311]  perf_ftrace_event_register+0x95/0xf0
> [  300.133750]  ? __pfx_tp_perf_event_destroy+0x10/0x10
> [  300.134190]  perf_trace_destroy+0x3a/0xa0
> [  300.134590]  ? __pfx_tp_perf_event_destroy+0x10/0x10
> [  300.135028]  tp_perf_event_destroy+0x1e/0x30
> [  300.135473]  _free_event+0x101/0x810
> [  300.136191]  put_event+0x3c/0x50
> [  300.136605]  perf_event_release_kernel+0x2de/0x360
> [  300.137011]  ? perf_event_release_kernel+0x9/0x360
> [  300.137577]  ? __pfx_perf_release+0x10/0x10
> [  300.138031]  perf_release+0x22/0x30
> [  300.138434]  __fput+0x11f/0x450
> [  300.139038]  ____fput+0x1e/0x30
> [  300.139425]  task_work_run+0xb6/0x120
> [  300.140164]  do_exit+0x547/0x1360
> [  300.140632]  ? write_comp_data+0x2f/0x90
> [  300.141223]  do_group_exit+0x5e/0xf0
> [  300.141732]  get_signal+0x15d1/0x1600
> [  300.142596]  arch_do_signal_or_restart+0x33/0x280
> [  300.143463]  exit_to_user_mode_prepare+0x13b/0x210
> [  300.143955]  syscall_exit_to_user_mode+0x2d/0x60
> [  300.144623]  do_syscall_64+0x4a/0x90
> [  300.145032]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [  300.145459] RIP: 0033:0x7f2a7abd859d
> [  300.145823] RSP: 002b:00007ffcc732b338 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> [  300.146429] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 00007f2a7abd859d
> [  300.146930] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200004c0
> [  300.147436] RBP: 00007ffcc732b350 R08: 0000000000000000 R09: 00007ffcc732b350
> [  300.147938] R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000004011e0
> [  300.148645] R13: 00007ffcc732b470 R14: 0000000000000000 R15: 0000000000000000
> [  300.149713]  </TASK>
> [  300.149978] 
> [  300.149978] Showing all locks held in the system:
> [  300.150435] 1 lock held by rcu_tasks_kthre/11:
> [  300.150808]  #0: ffffffff83f63490 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
> [  300.151849] 1 lock held by rcu_tasks_rude_/12:
> [  300.152593]  #0: ffffffff83f63210 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
> [  300.153645] 1 lock held by rcu_tasks_trace/13:
> [  300.154013]  #0: ffffffff83f62f50 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x420
> [  300.155078] 1 lock held by khungtaskd/29:
> [  300.155425]  #0: ffffffff83f63ea0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x1b/0x1e0
> [  300.156644] 2 locks held by repro/540:
> [  300.156977]  #0: ffffffff840206a8 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x21/0xa0
> [  300.157971]  #1: ffffffff8401cd68 (ftrace_lock){+.+.}-{3:3}, at: unregister_ftrace_function+0x2b/0x230
> [  300.159005] 
> [  300.159233] =============================================
> [  300.159233] 
> "
> Bisected and found first bad commit:
> "
> 0e792b89e6800cd9cb4757a76a96f7ef3e8b6294
> ftrace: Fix use-after-free for dynamic ftrace_ops
> "
> After reverted the above commit on top of v6.3-rc2 kernel, this issue was gone.
> 
> And this issue could be reproduced in 2100s.
> 
> There was no this issue report in syzbot link:
> https://syzkaller.appspot.com/upstream
> 
> I hope it's helpful.
> 
> Thanks!
> 
> ---
> 
> If you don't need the following environment to reproduce the problem or if you
> already have one, please ignore the following information.
> 
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>    // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>    // You could change the bzImage_xxx as you want
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
> 
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
> 
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
> 
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
> 
> 
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
> make
> make install
> 
> Thanks!
> BR.
