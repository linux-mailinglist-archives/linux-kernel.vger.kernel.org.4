Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E37625765
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiKKJ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiKKJ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:56:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE4271F13;
        Fri, 11 Nov 2022 01:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668160588; x=1699696588;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=h6e2xgUHJEgFHAL4XlMO26nosgxADBeqocuzoLdnKzc=;
  b=Pb7jUR1w2dllvBejJtJSHKUpv2JSA+LC3XOoy55b0uNMIM3SLRnahwbQ
   z6916FNW9NNTN0eJN/vxo0PrvPVXfssfqMfvODApdC0LILdoeEw7bi/wt
   3LbzZMFqxgoQQpwyAMLCcjOcL6zgv6z8eHNRiULTjjwAk01ICwXhe8yPJ
   s6JbTCoidNtOyaNQZCU1bCdq4zJpryiph/zW7/kejFL3xJm5+0roQ1Jm8
   pTsOh4BLUqdbODnSP16DgwsQD8G7b+vnpqVWx51YMtsVQmbTxW4030AA+
   Vn6Vu4ych3r/lwF0DDmkq2HCxmrOv5/UsYOasAP5u8oqW16Bjtc4fu7DO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="299080668"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="xz'?scan'208";a="299080668"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 01:56:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="706496620"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="xz'?scan'208";a="706496620"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2022 01:56:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 01:56:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 11 Nov 2022 01:56:25 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 11 Nov 2022 01:56:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS7CwYK3Tq/c1ak2Xlgq12LR1S0t7K7gJHMmEMMNYLyIJs7d6bnjkMnRJVgDFRZP+wU3H4JbG0nmAVhA7iYEqZd3rRbe26cUXTdM+iNINNP/H9xKsr5zIdBOsgevT/Ar8JxTvmEaSeg7+qy/QnsH15fowjWUYRLJj09VJYexM3KyefY3FdxbqM1YkXwemx4Q1IMrk9+Fygw4myTU6b825xQqiA8VVEwAgw7KWI5SEuEBWdM5KV6jmGwwym2E9HOHPAmybuc5Ghp4mJ9eb4rlA6+CKzsqlG2PVM6r4/y5CjpK1CJc3lm+uw86WtCY9l37H718pHKnuDNSFmGK0wvIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IX8TcUEdG0B7bGS+9bmP6HB21+wtaChrgatMVzBC32g=;
 b=UM+uBs34Ln77jx5YqTYXnQ/5U4KyPWSBX1rS2bO4e3PcblYRv7j+SH5dH8HeseM7UsyagfSHmPzhPc4sLNmubvvShtzpL6FJWO01EGQpV/nxJbqWSMkWOMrq3qIrf9Za2zdo+nwFKMDBIPkQy0QpziY4BLnS4A8ztmIAcJZuwdgk6zUvm0WfwbbTRhbWkkhoLhXla/X7Izw19PIuk531ODAuHn++WSmlK6GT7BE1p5eYmfDoshkDkenrVBZKTR43YiFfoO6klvqP0oWMhy+OnfV0JtHRQPL31IQSZvfCzXCrHcvBRdUqd3WVaPMcPdJHHfk8TX2aTnkA8mm3pDW95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS0PR11MB7336.namprd11.prod.outlook.com (2603:10b6:8:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Fri, 11 Nov
 2022 09:56:19 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d%9]) with mapi id 15.20.5791.024; Fri, 11 Nov 2022
 09:56:19 +0000
Date:   Fri, 11 Nov 2022 17:54:30 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH] rcu: Dump memory object info if callback is invalid
Message-ID: <202211111621.650c17d1-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="cKHKltVZF/Cv5AaO"
Content-Disposition: inline
In-Reply-To: <20221105023519.147-1-thunder.leizhen@huawei.com>
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS0PR11MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d3f9a6-3bc8-4eb8-d815-08dac3cafac7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xht+lZcvnMYqYWD/CWAnYF8Or57vsROST5qSMCUbymhz9g1OaiTPJAZQu7NjKZ7qIQg/eUzzsgVTs3p0a49pYjYgJVFbCkvq3Nbz2lT31ZV+9KPfRk55oB+CZK9sany7+6yR77zYoMnmq3zFoWVsIPRS8cwFfX2gV43soo8j2Ld8ucFVKxkQRVDewyUJn/W/Bek50sQ7i4uRWj617HabUZ1qkG/dVBIeKu83SMNYrkDUeUU7KgVeF9Xe2QIqC5Q6pJGIy2b0hnvy2ihVi2PhZZGStN0mbTZfFvR+Fbrc4vYe+n873eWK+qXmb/nxzqcGeYkofsimF96YN4Si4D3cTSXT7lqugXQs31XRIj46YzF/gdArXen6WqfMiMiAuo+puTgY+MWfncc20AX9Uoto/jrv+9PA12DtXBQ4XySlHDwl19Mlfn7woW5CFWFQG5BFTVwq05AopEEf0CmcGK+XqUhpKM7dm0ESUVXZ8rmmJYSNQoLW9evBJy5FMbXRdi+Dr5lEdMB4HgqjrrZMsXK5/VPcXwc0veyrEai6sUcg//BzefSFhweOO2JNzgXfIUQjSDu/a3/dgPcfThN241qckQqOdZOgliRyeE46752sEkvDmJXdD27Exunj8Iv/dZbyDb/cTLcDdbwbei3YsyWZPKBrvIopv/nHuj10bjP5mB2WXHZcuIhmjhFDam3cQnx2QBZ9lWx4nL8pCHYV++8tB/ixtkhgewQCae7088cuyVNrKJqv9SHKZ9nhZbIrPImibNaGNsG+n4YUUA2X89pS4o70ZjQzcj+Fy9u3S6MMnU63nUerWD9BCUGHKwwWPG++PijUypOyH8RE8KiG3AESQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(5660300002)(36756003)(316002)(6916009)(54906003)(86362001)(66476007)(66946007)(2906002)(4326008)(83380400001)(26005)(6512007)(66556008)(186003)(1076003)(2616005)(6486002)(6666004)(6506007)(478600001)(966005)(44144004)(235185007)(7416002)(82960400001)(8936002)(38100700002)(8676002)(41300700001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+k1HCzSb4IHecqHxRGEMOHcjXNp+VvElhMD3uGa+ChiCgQVJnf90POr8HMwx?=
 =?us-ascii?Q?h+zwxVCEP2PdusA9t+xNLbYt3wPMveQTdktRfR0o6O+VrOaxCZ14gOnp3ntJ?=
 =?us-ascii?Q?AJ2meeEzmjq40I2GQeRJVDGK34A5hXnnMBxT2M18gf+MFH3kIq1LnN9EQA1W?=
 =?us-ascii?Q?MsfIzJpKs1Vhe9j6mcEVz39rpUaWixmvipy1mUr/vp4hhFwDquNTfEqq4LzJ?=
 =?us-ascii?Q?ENHZH3GimEvTHy1+D6VI6U10rHbgx9m/pVm5UD2T0Nq4ArYN0dX0RjXGhRsZ?=
 =?us-ascii?Q?Y82UbmCzd66p1n9lJJOGKlYAy/Y7ldYGEJaf2IAbH3Js3lsI6XOTrl1uf4qM?=
 =?us-ascii?Q?uzeqZnoIqwFgEQynkgttpEsgqI0Ug/A80z/OzhxpOqBd+hk0TI4my+PVpwHh?=
 =?us-ascii?Q?LlyD1SjLQV87IspDBazYrWuiJutIYg4TCBRlPjgNOwk6DuUf19TEmk1QY2Ho?=
 =?us-ascii?Q?sM8SIWzzfcXgfiE/tvdS8ZGaJe6vbafb+k5fe40pV5a1P7t1Sy1CRUGslPNN?=
 =?us-ascii?Q?XSdzb3nvx/ELejeEytyaX+RMxcpLMrkIq6lkeg2QJuUOqojgO6Xm4ZU+z0db?=
 =?us-ascii?Q?kuWKyRBm9efwmTgf9HLAxkyQ6tddmrNXi0Gt3jQ76knzwDEM1OgrBlJP2tco?=
 =?us-ascii?Q?5cdievrPJT/54Igfk21F5V0788dr8nk2AGfRj/tlFoomIiTni1ZYcN5RtP9f?=
 =?us-ascii?Q?LFGeBlFUXrd4maWHEa6NAbVg6j0FwIB310TruKSWM9AQ7q6w0OurlmY4v8qT?=
 =?us-ascii?Q?+0t/07eaUuiy05h8VUXCOmoTqUFtm1YacbyVrNCHcqK+Io1veXxPYjpXvZCv?=
 =?us-ascii?Q?ZbhTIaoitd+Uk5rs4Le1ekKvL0S/15eIAZapeYhwgBnC88U+eRUoBzcXDhhP?=
 =?us-ascii?Q?YmrnJKLs97xmp1jmgI1BZwlqFhtjHKt6NA+Oxnu8ggixiZRDEleru2v4DrDG?=
 =?us-ascii?Q?rfMyRQ4TTV/XcMCy/6o5ZdbeZfE61EZWklWtOIjdjU043NQjpv6Bzn9OAkku?=
 =?us-ascii?Q?+SZPqJqUIYG8WTTI88qN0FVKhwlXLUghF+bLFtF6IOzp3MgHweYMCJGzSY7q?=
 =?us-ascii?Q?Fgemddf/Ki8jRZfsgxc0+Pt3AiEKFY0tdIZs55NHP1LFymKhy+O+DhZnYK/A?=
 =?us-ascii?Q?8bMjV9dEOL8z7ZmRr4aSjXwpiD/W98WiGWjot4ZCjMqd9iAJR8Lijsnm7xfA?=
 =?us-ascii?Q?YNq+ikup6VcPbhoU9WFSTYrw1eijFntSJCVQjsTZRHgXXwUMz+r5gNTHo9bj?=
 =?us-ascii?Q?28+RfyOfnTfSFgFCZBZGd7rp3M28Vu4rxvJemRkw0Hd89HTOWv1w/thHQvuG?=
 =?us-ascii?Q?VuGH4pNFgHKblSmSTzz/txpXjhnAQ+idVDVKcy3AaDWhDRYOA9btRxJEZK6s?=
 =?us-ascii?Q?38AMTCtwRH8eb9RlcMACK1T3eVxUTWmBHkzyom/XThFAuyhaTDNepFlDX33l?=
 =?us-ascii?Q?b3iqSzOGwsrGMiNxPXF4KrcasRK2BVuvve6fEUFoT5QDGqLbfE+Ne05LZmzb?=
 =?us-ascii?Q?dV5p/UIODpyjIFKTqMjCVEWEWKZddPIKOw3757YOAViOOJ0bPLsySaZRBNm+?=
 =?us-ascii?Q?GKFDuebA5B9P/UWy78DhCfDua9QMjWQCZ08OFRk0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d3f9a6-3bc8-4eb8-d815-08dac3cafac7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 09:56:19.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNAEaZYSWoN36idYQyFes0QlsNalK2yYtyx18DtiPxo/WGBS57MsjHpSzdoOaj+VB0BXnssuXM9iV8XBbd/GHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7336
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--cKHKltVZF/Cv5AaO
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greeting,

FYI, we noticed WARNING:inconsistent_lock_state due to commit (built with gcc-11):

commit: 98ccdf3d86014216f3168d7f91ce37cfc31d8d8f ("[PATCH] rcu: Dump memory object info if callback is invalid")
url: https://github.com/intel-lab-lkp/linux/commits/Zhen-Lei/rcu-Dump-memory-object-info-if-callback-is-invalid/20221105-103913
base: https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev
patch subject: [PATCH] rcu: Dump memory object info if callback is invalid

in testcase: boot

on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


[  267.167919][    C0] WARNING: inconsistent lock state
[ 267.167583][ T1] calling cpu_hotplug_pm_sync_init+0x0/0x11 @ 1 
[  267.169690][    C0] 6.1.0-rc1-00115-g98ccdf3d8601 #1 Not tainted
[ 267.167583][ T1] initcall cpu_hotplug_pm_sync_init+0x0/0x11 returned 0 after 0 usecs 
[  267.171238][    C0] --------------------------------
[ 267.169196][ T1] calling wq_sysfs_init+0x0/0x24 @ 1 
[  267.173152][    C0] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[ 267.171114][ T1] initcall wq_sysfs_init+0x0/0x24 returned 0 after 0 usecs 
[  267.174609][    C0] swapper/0/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
[ 267.172669][ T1] calling ksysfs_init+0x0/0x78 @ 1 
[ 267.176493][ C0] c2957230 (vmap_area_lock){+.?.}-{2:2}, at: find_vmap_area (??:?) 
[  267.177532][    C0] {SOFTIRQ-ON-W} state was registered at:
[ 267.177532][ C0] mark_usage (lockdep.c:?) 
[ 267.174448][ T1] initcall ksysfs_init+0x0/0x78 returned 0 after 0 usecs 
[ 267.177532][ C0] __lock_acquire (lockdep.c:?) 
[ 267.174448][ T1] calling schedutil_gov_init+0x0/0xf @ 1 
[ 267.177532][ C0] lock_acquire (??:?) 
[ 267.174448][ T1] initcall schedutil_gov_init+0x0/0xf returned 0 after 0 usecs 
[ 267.177532][ C0] _raw_spin_lock (??:?) 
[ 267.174448][ T1] calling pm_init+0x0/0x4a @ 1 
[ 267.174448][ T1] initcall pm_init+0x0/0x4a returned 0 after 0 usecs 
[ 267.174448][ T1] calling rcu_set_runtime_mode+0x0/0x20 @ 1 
[ 267.177532][ C0] alloc_vmap_area (vmalloc.c:?) 
[ 267.177532][ C0] __get_vm_area_node+0xaf/0xfd 
[ 267.177532][ C0] get_vm_area_caller (??:?) 
[ 267.177532][ C0] __ioremap_caller+0x1a7/0x234 
[ 267.177532][ C0] ioremap_cache (??:?) 
[ 267.177532][ C0] acpi_os_map_iomem (??:?) 
[ 267.177532][ C0] acpi_os_map_memory (??:?) 
[ 267.177532][ C0] acpi_tb_acquire_table (??:?) 
[ 267.177532][ C0] acpi_tb_validate_table (??:?) 
[ 267.177532][ C0] acpi_tb_validate_temp_table (??:?) 
[ 267.177532][ C0] acpi_tb_verify_temp_table (??:?) 
[ 267.177532][ C0] acpi_reallocate_root_table (??:?) 
[ 267.177532][ C0] acpi_early_init (??:?) 
[ 267.177532][ C0] start_kernel (??:?) 
[ 267.177532][ C0] i386_start_kernel (??:?) 
[ 267.177532][ C0] startup_32_smp (??:?) 
[  267.177532][    C0] irq event stamp: 3448
[ 267.177532][ C0] hardirqs last enabled at (3448): rcu_nocb_unlock_irqrestore+0xe/0x12 
[ 267.177532][ C0] hardirqs last disabled at (3447): rcu_do_batch (tree.c:?) 
[ 267.177532][ C0] softirqs last enabled at (3408): __do_softirq (??:?) 
[ 267.177532][ C0] softirqs last disabled at (3433): do_softirq_own_stack (??:?) 
[  267.177532][    C0]
[  267.177532][    C0] other info that might help us debug this:
[  267.177532][    C0]  Possible unsafe locking scenario:
[  267.177532][    C0]
[  267.177532][    C0]        CPU0
[  267.177532][    C0]        ----
[  267.177532][    C0]   lock(vmap_area_lock);
[  267.177532][    C0]   <Interrupt>
[  267.177532][    C0]     lock(vmap_area_lock);
[  267.177532][    C0]
[  267.177532][    C0]  *** DEADLOCK ***
[  267.177532][    C0]
[  267.177532][    C0] 1 lock held by swapper/0/0:
[ 267.177532][ C0] #0: c292b648 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire (notifier.c:?) 
[  267.177532][    C0]
[  267.177532][    C0] stack backtrace:
[  267.177532][    C0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc1-00115-g98ccdf3d8601 #1
[  267.177532][    C0] Call Trace:
[  267.177532][    C0]  <SOFTIRQ>
[ 267.177532][ C0] dump_stack_lvl (??:?) 
[ 267.177532][ C0] dump_stack (??:?) 
[ 267.177532][ C0] print_usage_bug (lockdep.c:?) 
[ 267.177532][ C0] valid_state (lockdep.c:?) 
[ 267.177532][ C0] mark_lock_irq (lockdep.c:?) 
[ 267.177532][ C0] ? save_trace (lockdep.c:?) 
[ 267.177532][ C0] mark_lock+0xb5/0x107 
[ 267.177532][ C0] mark_usage (lockdep.c:?) 
[ 267.177532][ C0] __lock_acquire (lockdep.c:?) 
[ 267.177532][ C0] ? find_vmap_area (??:?) 
[ 267.177532][ C0] lock_acquire (??:?) 
[ 267.177532][ C0] ? find_vmap_area (??:?) 
[ 267.177532][ C0] ? rcu_gp_torture_wait (tree.c:?) 
[ 267.177532][ C0] ? lock_acquire (??:?) 
[ 267.177532][ C0] ? rcu_gp_torture_wait (tree.c:?) 
[ 267.177532][ C0] _raw_spin_lock (??:?) 
[ 267.177532][ C0] ? find_vmap_area (??:?) 
[ 267.177532][ C0] find_vmap_area (??:?) 
[ 267.177532][ C0] find_vm_area (??:?) 
[ 267.177532][ C0] vmalloc_dump_obj (??:?) 
[ 267.177532][ C0] mem_dump_obj (??:?) 
[ 267.177532][ C0] rcu_do_batch (tree.c:?) 
[ 267.177532][ C0] ? show_rcu_tasks_gp_kthreads (sync.c:?) 
[ 267.177532][ C0] rcu_core (tree.c:?) 
[ 267.177532][ C0] rcu_core_si (tree.c:?) 
[ 267.177532][ C0] __do_softirq (??:?) 
[ 267.177532][ C0] ? __entry_text_end (??:?) 
[ 267.177532][ C0] do_softirq_own_stack (??:?) 
[  267.177532][    C0]  </SOFTIRQ>
[ 267.177532][ C0] ? sysvec_call_function_single (??:?) 
[ 267.177532][ C0] __irq_exit_rcu (softirq.c:?) 
[ 267.177532][ C0] irq_exit_rcu (??:?) 
[ 267.177532][ C0] sysvec_apic_timer_interrupt (??:?) 
[ 267.177532][ C0] handle_exception (entry_32.o:?) 
[ 267.177532][ C0] EIP: native_safe_halt (process.c:?) 
[ 267.177532][ C0] Code: e8 bb 57 62 ff e8 96 be ff ff 8b 4d f8 89 d8 31 d2 e8 a9 0f b1 ff 5b 5b 5d c3 cc cc cc cc cc cc 55 89 e5 e8 27 b4 5d ff fb f4 <5d> c3 55 89 e5 e8 ec ff ff ff 5d c3 55 64 8b 0d 00 78 bb c2 89 e5
All code
========
   0:	e8 bb 57 62 ff       	callq  0xffffffffff6257c0
   5:	e8 96 be ff ff       	callq  0xffffffffffffbea0
   a:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   d:	89 d8                	mov    %ebx,%eax
   f:	31 d2                	xor    %edx,%edx
  11:	e8 a9 0f b1 ff       	callq  0xffffffffffb10fbf
  16:	5b                   	pop    %rbx
  17:	5b                   	pop    %rbx
  18:	5d                   	pop    %rbp
  19:	c3                   	retq   
  1a:	cc                   	int3   
  1b:	cc                   	int3   
  1c:	cc                   	int3   
  1d:	cc                   	int3   
  1e:	cc                   	int3   
  1f:	cc                   	int3   
  20:	55                   	push   %rbp
  21:	89 e5                	mov    %esp,%ebp
  23:	e8 27 b4 5d ff       	callq  0xffffffffff5db44f
  28:	fb                   	sti    
  29:	f4                   	hlt    
  2a:*	5d                   	pop    %rbp		<-- trapping instruction
  2b:	c3                   	retq   
  2c:	55                   	push   %rbp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	e8 ec ff ff ff       	callq  0x20
  34:	5d                   	pop    %rbp
  35:	c3                   	retq   
  36:	55                   	push   %rbp
  37:	64 8b 0d 00 78 bb c2 	mov    %fs:-0x3d448800(%rip),%ecx        # 0xffffffffc2bb783e
  3e:	89 e5                	mov    %esp,%ebp

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	c3                   	retq   
   2:	55                   	push   %rbp
   3:	89 e5                	mov    %esp,%ebp
   5:	e8 ec ff ff ff       	callq  0xfffffffffffffff6
   a:	5d                   	pop    %rbp
   b:	c3                   	retq   
   c:	55                   	push   %rbp
   d:	64 8b 0d 00 78 bb c2 	mov    %fs:-0x3d448800(%rip),%ecx        # 0xffffffffc2bb7814
  14:	89 e5                	mov    %esp,%ebp


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202211111621.650c17d1-yujie.liu@intel.com


To reproduce:

        # build kernel
	cd linux
	cp config-6.1.0-rc1-00115-g98ccdf3d8601 .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.


-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--cKHKltVZF/Cv5AaO
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc1-00115-g98ccdf3d8601"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.1.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
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
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
CONFIG_KERNEL_LZMA=y
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
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
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
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

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
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
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
CONFIG_UCLAMP_TASK=y
CONFIG_UCLAMP_BUCKETS_COUNT=5
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_UCLAMP_TASK_GROUP=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_MISC=y
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
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
# CONFIG_IO_URING is not set
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
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
CONFIG_ARCH_NR_GPIO=512
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_BIGSMP=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
# CONFIG_PARAVIRT_SPINLOCKS is not set
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
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_CYRIX_32 is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
# CONFIG_SCHED_CLUSTER is not set
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_X86_16BIT is not set
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=y
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
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
# CONFIG_MTRR is not set
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_STRICT_SIGALTSTACK_SIZE=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
# CONFIG_RETPOLINE is not set
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
# CONFIG_ACPI_THERMAL is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
CONFIG_ACPI_APEI_EINJ=y
CONFIG_ACPI_APEI_ERST_DEBUG=y
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
# CONFIG_DPTF_PCH_FIVR is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_CONFIGFS=y
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_VIOT=y
CONFIG_X86_PM_TIMER=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_ALLOW_INTS=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=y
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
CONFIG_X86_LONGHAUL=y
CONFIG_X86_E_POWERSAVER=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
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
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
# CONFIG_NET5501 is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
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
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
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
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
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
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_CGROUP_IOPRIO=y
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set
CONFIG_BLK_INLINE_ENCRYPTION=y
# CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
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
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_SLUB_CPU_PARTIAL is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_BOUNCE=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_VMAP_PFN=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
# CONFIG_DAMON_VADDR is not set
CONFIG_DAMON_PADDR=y
# CONFIG_DAMON_SYSFS is not set
CONFIG_DAMON_RECLAIM=y
# CONFIG_DAMON_LRU_SORT is not set
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
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

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
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
# CONFIG_MHI_BUS_DEBUG is not set
# CONFIG_MHI_BUS_PCI_GENERIC is not set
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
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
# CONFIG_GNSS_USB is not set
# CONFIG_MTD is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
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
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_AD525X_DPOT_SPI is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=y
# CONFIG_PVPANIC_PCI is not set
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
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_HOST_SMP=y
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
CONFIG_TCM_FILEIO=y
# CONFIG_TCM_PSCSI is not set
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
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
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
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
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
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
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
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
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
CONFIG_NET_VENDOR_LITEX=y
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
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
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
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
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
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
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
CONFIG_NET_VENDOR_SMSC=y
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
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
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
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
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
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
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
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADC is not set
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=y
# CONFIG_JOYSTICK_GRIP_MP is not set
CONFIG_JOYSTICK_GUILLEMOT=y
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_USB=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=y
# CONFIG_JOYSTICK_ZHENHUA is not set
CONFIG_JOYSTICK_DB9=y
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=y
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_PSXPAD_SPI=y
# CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
CONFIG_JOYSTICK_PXRC=y
CONFIG_JOYSTICK_QWIIC=y
CONFIG_JOYSTICK_FSIA6B=y
# CONFIG_JOYSTICK_SENSEHAT is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
CONFIG_TABLET_USB_AIPTEK=y
CONFIG_TABLET_USB_HANWANG=y
CONFIG_TABLET_USB_KBTAB=y
CONFIG_TABLET_USB_PEGASUS=y
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM860X_ONKEY is not set
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
CONFIG_INPUT_AD714X_SPI=y
# CONFIG_INPUT_ATC260X_ONKEY is not set
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_MAX8925_ONKEY is not set
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
# CONFIG_INPUT_WISTRON_BTNS is not set
CONFIG_INPUT_ATLAS_BTNS=y
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=y
# CONFIG_INPUT_YEALINK is not set
CONFIG_INPUT_CM109=y
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_AXP20X_PEK=y
# CONFIG_INPUT_TWL6040_VIBRA is not set
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PALMAS_PWRBUTTON=y
CONFIG_INPUT_PCF8574=y
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
CONFIG_INPUT_DA9052_ONKEY=y
CONFIG_INPUT_DA9055_ONKEY=y
# CONFIG_INPUT_WM831X_ON is not set
# CONFIG_INPUT_ADXL34X is not set
CONFIG_INPUT_IMS_PCU=y
CONFIG_INPUT_IQS269A=y
CONFIG_INPUT_IQS626A=y
# CONFIG_INPUT_IQS7222 is not set
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_HYPERV_KEYBOARD=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_XIPHERA=y
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=y
CONFIG_TCG_TIS_SPI_CR50=y
# CONFIG_TCG_TIS_I2C is not set
CONFIG_TCG_TIS_I2C_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=y
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
# CONFIG_XILLYBUS is not set
CONFIG_XILLYUSB=y
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
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
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
CONFIG_I2C_CP2615=y
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_PCI1XXXX is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
# CONFIG_CDNS_I3C_MASTER is not set
CONFIG_DW_I3C_MASTER=y
CONFIG_SVC_I3C_MASTER=y
# CONFIG_MIPI_I3C_HCI is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_ALTERA_DFL is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=y
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_DLN2=y
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
# CONFIG_SPI_INTEL_PCI is not set
# CONFIG_SPI_INTEL_PLATFORM is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
CONFIG_SPI_SIFIVE=y
CONFIG_SPI_MXIC=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
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
# CONFIG_PPS is not set

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_MADERA=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_ELKHARTLAKE=y
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=y
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LAKEFIELD=y
CONFIG_PINCTRL_LEWISBURG=y
# CONFIG_PINCTRL_METEORLAKE is not set
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_SIOX=y
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_I8255=y
# CONFIG_GPIO_104_DIO_48E is not set
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_DLN2=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_MADERA=y
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=y
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_ATC260X is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_TPS65086 is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_IP5XXX_POWER is not set
CONFIG_MAX8925_POWER=y
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_CW2015=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9052=y
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
CONFIG_CHARGER_AXP20X=y
# CONFIG_BATTERY_AXP20X is not set
# CONFIG_AXP20X_POWER is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_88PM860X is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_LP8788=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77693 is not set
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MAX8997=y
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65090=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_BD99954=y
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AHT10=y
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_CORSAIR_CPRO=y
CONFIG_SENSORS_CORSAIR_PSU=y
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
CONFIG_I8K=y
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX127=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31722 is not set
CONFIG_SENSORS_MAX31730=y
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_NZXT_KRAKEN2=y
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SBTSI=y
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_TMP464 is not set
CONFIG_SENSORS_TMP513=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
# CONFIG_X86_PKG_TEMP_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_INTEL_TCC_COOLING=y
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
CONFIG_MENZ069_WATCHDOG=y
CONFIG_WDAT_WDT=y
CONFIG_WM831X_WATCHDOG=y
CONFIG_WM8350_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
CONFIG_SBC8360_WDT=y
# CONFIG_SBC7240_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
CONFIG_SMSC37B787_WDT=y
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_NI903X_WDT=y
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
# CONFIG_MFD_MADERA_SPI is not set
# CONFIG_MFD_CS47L15 is not set
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
# CONFIG_MFD_CS47L92 is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_WCD934X=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_AAT2870 is not set
# CONFIG_REGULATOR_ATC260X is not set
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP8788=y
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8907=y
# CONFIG_REGULATOR_MAX8925 is not set
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX20086 is not set
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77826=y
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_PALMAS is not set
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4831=y
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5759 is not set
CONFIG_REGULATOR_RT6160=y
# CONFIG_REGULATOR_RT6245 is not set
CONFIG_REGULATOR_RTQ2134=y
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_WM831X=y
# CONFIG_REGULATOR_WM8350 is not set
# CONFIG_REGULATOR_WM8400 is not set
# CONFIG_RC_CORE is not set

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
CONFIG_LCD_PLATFORM=y
# CONFIG_LCD_LMS501KF03 is not set
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
# end of Backlight & LCD device support
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACCUTOUCH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
# CONFIG_HID_APPLE is not set
CONFIG_HID_APPLEIR=y
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
CONFIG_HID_BETOP_FF=y
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CREATIVE_SB0540=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_ELO=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=y
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_LETSKETCH is not set
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_MEGAWORLD_FF is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NINTENDO=y
# CONFIG_NINTENDO_FF is not set
CONFIG_HID_NTI=y
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PENMOUNT=y
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=y
CONFIG_PLAYSTATION_FF=y
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=y
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SEMITEK=y
# CONFIG_HID_SIGMAMICRO is not set
CONFIG_HID_SONY=y
CONFIG_SONY_FF=y
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_HYPERV_MOUSE is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_U2FZERO=y
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
CONFIG_HID_MCP2221=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_PRODUCTLIST=y
CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
# CONFIG_USB_OXU210HP_HCD is not set
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=y
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_CDNSP_PCI is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PCI is not set
# CONFIG_USB_DWC2_DEBUG is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_CHIPIDEA=y
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_CHIPIDEA_MSM=y
CONFIG_USB_CHIPIDEA_GENERIC=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=y
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=y
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=y
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
# CONFIG_TYPEC_TCPCI is not set
CONFIG_TYPEC_FUSB302=y
# CONFIG_TYPEC_UCSI is not set
CONFIG_TYPEC_TPS6598X=y
# CONFIG_TYPEC_ANX7411 is not set
# CONFIG_TYPEC_RT1719 is not set
CONFIG_TYPEC_HD3SS3220=y
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
CONFIG_TYPEC_MUX_PI3USB30532=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=y
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set
# CONFIG_MMC_CRYPTO is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
# CONFIG_MMC_SDHCI_PLTFM is not set
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_SPI=y
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_USB=y
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=y
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_NET48XX is not set
CONFIG_LEDS_WRAP=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX8997=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_RT8515=y
CONFIG_LEDS_SGM3140=y

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=y
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1374_WDT is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_LP8788=y
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8907 is not set
# CONFIG_RTC_DRV_MAX8925 is not set
CONFIG_RTC_DRV_MAX8997=y
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS65910=y
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV3032=y
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
CONFIG_RTC_DRV_DS1305=y
# CONFIG_RTC_DRV_DS1343 is not set
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
CONFIG_RTC_DRV_MAX6916=y
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_DS3232_HWMON is not set
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RV3029_HWMON is not set
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=y
# CONFIG_RTC_DRV_DA9055 is not set
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_WM8350=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_LCD2S=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_UIO_DFL=y
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_BALLOON=y
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
# CONFIG_GREYBUS_ES2 is not set
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_SSV_DNP=y
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_USB_DRIVERS=y
# CONFIG_COMEDI_DT9812 is not set
CONFIG_COMEDI_NI_USB6501=y
# CONFIG_COMEDI_USBDUX is not set
# CONFIG_COMEDI_USBDUXFAST is not set
# CONFIG_COMEDI_USBDUXSIGMA is not set
CONFIG_COMEDI_VMK80XX=y
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
CONFIG_SURFACE_HOTPLUG=y
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
# CONFIG_P2SB is not set
# CONFIG_COMMON_CLK is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_IOMMU_DMA=y
# CONFIG_HYPERV_IOMMU is not set
CONFIG_VIRTIO_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

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
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

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
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PALMAS=y
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_TUSB320=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
# CONFIG_IIO_BUFFER_DMAENGINE is not set
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=y
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
CONFIG_ADIS16201=y
# CONFIG_ADIS16209 is not set
CONFIG_ADXL313=y
CONFIG_ADXL313_I2C=y
CONFIG_ADXL313_SPI=y
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL345_SPI=y
CONFIG_ADXL355=y
CONFIG_ADXL355_I2C=y
# CONFIG_ADXL355_SPI is not set
# CONFIG_ADXL367_SPI is not set
# CONFIG_ADXL367_I2C is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA220=y
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMA400_SPI=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_BMI088_ACCEL=y
CONFIG_BMI088_ACCEL_SPI=y
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=y
CONFIG_DMARD10=y
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
# CONFIG_FXLS8962AF_SPI is not set
CONFIG_HID_SENSOR_ACCEL_3D=y
CONFIG_KXSD9=y
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
# CONFIG_MSA311 is not set
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_SCA3000=y
CONFIG_SCA3300=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=y
CONFIG_AD7124=y
CONFIG_AD7192=y
CONFIG_AD7266=y
# CONFIG_AD7280 is not set
CONFIG_AD7291=y
CONFIG_AD7292=y
CONFIG_AD7298=y
CONFIG_AD7476=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
CONFIG_AD7766=y
CONFIG_AD7768_1=y
CONFIG_AD7780=y
CONFIG_AD7791=y
CONFIG_AD7793=y
CONFIG_AD7887=y
CONFIG_AD7923=y
CONFIG_AD7949=y
CONFIG_AD799X=y
CONFIG_AXP20X_ADC=y
# CONFIG_AXP288_ADC is not set
CONFIG_DA9150_GPADC=y
CONFIG_DLN2_ADC=y
# CONFIG_ENVELOPE_DETECTOR is not set
# CONFIG_HI8435 is not set
CONFIG_HX711=y
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
CONFIG_MAX11100=y
# CONFIG_MAX1118 is not set
# CONFIG_MAX11205 is not set
# CONFIG_MAX1241 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=y
CONFIG_MCP3422=y
# CONFIG_MCP3911 is not set
CONFIG_MEN_Z188_ADC=y
# CONFIG_MP2629_ADC is not set
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
# CONFIG_RICHTEK_RTQ6056 is not set
# CONFIG_SD_ADC_MODULATOR is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=y
CONFIG_TI_ADC108S102=y
CONFIG_TI_ADC128S052=y
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS1015=y
CONFIG_TI_ADS7950=y
# CONFIG_TI_ADS8344 is not set
# CONFIG_TI_ADS8688 is not set
# CONFIG_TI_ADS124S08 is not set
CONFIG_TI_ADS131E08=y
# CONFIG_TI_TLC4541 is not set
CONFIG_TI_TSC2046=y
# CONFIG_VF610_ADC is not set
# CONFIG_VIPERBOARD_ADC is not set
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_AD74413R is not set
# CONFIG_STX104 is not set
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
# CONFIG_ADA4250 is not set
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_ATLAS_EZO_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=y
CONFIG_SCD30_CORE=y
CONFIG_SCD30_I2C=y
# CONFIG_SCD4X is not set
# CONFIG_SENSIRION_SGP30 is not set
CONFIG_SENSIRION_SGP40=y
# CONFIG_SPS30_I2C is not set
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=y
CONFIG_IIO_SSP_SENSORHUB=y
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD3552R is not set
# CONFIG_AD5064 is not set
CONFIG_AD5360=y
CONFIG_AD5380=y
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
# CONFIG_AD5592R is not set
CONFIG_AD5593R=y
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
# CONFIG_LTC2688 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
CONFIG_AD5758=y
CONFIG_AD5761=y
CONFIG_AD5764=y
# CONFIG_AD5766 is not set
CONFIG_AD5770R=y
# CONFIG_AD5791 is not set
# CONFIG_AD7293 is not set
CONFIG_AD7303=y
CONFIG_AD8801=y
CONFIG_CIO_DAC=y
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=y
CONFIG_LTC1660=y
# CONFIG_LTC2632 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
# CONFIG_MCP4922 is not set
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=y
# CONFIG_TI_DAC7311 is not set
CONFIG_TI_DAC7612=y
# CONFIG_VF610_DAC is not set
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
CONFIG_AD9523=y
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y
CONFIG_ADF4371=y
# CONFIG_ADMV4420 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
CONFIG_ADIS16130=y
CONFIG_ADIS16136=y
CONFIG_ADIS16260=y
CONFIG_ADXRS290=y
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
# CONFIG_FXAS21002C is not set
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
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
CONFIG_HID_SENSOR_HUMIDITY=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
CONFIG_HTU21=y
# CONFIG_SI7005 is not set
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16460=y
CONFIG_ADIS16475=y
CONFIG_ADIS16480=y
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_BOSCH_BNO055_I2C is not set
CONFIG_FXOS8700=y
# CONFIG_FXOS8700_I2C is not set
CONFIG_FXOS8700_SPI=y
CONFIG_KMX61=y
CONFIG_INV_ICM42600=y
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_ICM42600_SPI=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_INV_MPU6050_SPI=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=y
CONFIG_AL3010=y
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
CONFIG_APDS9960=y
CONFIG_AS73211=y
CONFIG_BH1750=y
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
CONFIG_GP2AP002=y
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
CONFIG_HID_SENSOR_PROX=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=y
# CONFIG_LTRF216A is not set
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
CONFIG_NOA1305=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
# CONFIG_VCNL4035 is not set
CONFIG_VEML6030=y
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_BMC150_MAGN_SPI=y
CONFIG_MAG3110=y
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_HMC5843_SPI=y
CONFIG_SENSORS_RM3100=y
# CONFIG_SENSORS_RM3100_I2C is not set
CONFIG_SENSORS_RM3100_SPI=y
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
CONFIG_HID_SENSOR_DEVICE_ROTATION=y
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5432=y
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=y
# CONFIG_MCP4018 is not set
CONFIG_MCP4131=y
# CONFIG_MCP4531 is not set
CONFIG_MCP41010=y
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
# CONFIG_BMP280 is not set
CONFIG_DLHL60D=y
CONFIG_DPS310=y
# CONFIG_HID_SENSOR_PRESS is not set
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
CONFIG_MS5611_SPI=y
CONFIG_MS5637=y
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=y
CONFIG_MB1232=y
CONFIG_PING=y
CONFIG_RFD77402=y
# CONFIG_SRF04 is not set
CONFIG_SX_COMMON=y
CONFIG_SX9310=y
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
CONFIG_SX9500=y
CONFIG_SRF08=y
# CONFIG_VCNL3020 is not set
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_LTC2983=y
CONFIG_MAXIM_THERMOCOUPLE=y
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
CONFIG_TMP117=y
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=y
# CONFIG_MAX31856 is not set
CONFIG_MAX31865=y
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_SIMPLE is not set
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_USB_LGM_PHY=y
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=y
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_TUSB1210=y
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_RMEM=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=y
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_MGR_MACHXO2_SPI=y
CONFIG_FPGA_BRIDGE=y
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=y
CONFIG_FPGA_DFL=y
# CONFIG_FPGA_DFL_FME is not set
CONFIG_FPGA_DFL_AFU=y
CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=y
# CONFIG_FPGA_DFL_PCI is not set
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
# CONFIG_MUX_ADGS1408 is not set
# CONFIG_MUX_GPIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
# CONFIG_INTERRUPT_CNT is not set
# CONFIG_INTEL_QEP is not set
CONFIG_MOST=y
CONFIG_MOST_USB_HDM=y
CONFIG_MOST_CDEV=y
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_ENCRYPTION_INLINE_CRYPT is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
# CONFIG_OMFS_FS is not set
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
CONFIG_PSTORE_LZO_COMPRESS=y
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
CONFIG_PSTORE_842_COMPRESS=y
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lzo"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=y
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
CONFIG_UFS_DEBUG=y
# CONFIG_EROFS_FS is not set
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
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
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
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_KEY_NOTIFICATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
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
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

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
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
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
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=y
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
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
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_POLY1305 is not set
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
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_XXHASH is not set
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRC64_ROCKSOFT is not set
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
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
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
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
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
# CONFIG_CRC64_ROCKSOFT is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
# CONFIG_DMA_CMA is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

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
# CONFIG_SYMBOLIC_ERRNAME is not set
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_DWARF5=y
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
CONFIG_GDB_SCRIPTS=y
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
CONFIG_VMLINUX_MAP=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
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
# CONFIG_SLUB_DEBUG is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
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
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
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

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
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
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

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
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_LATENCYTOP=y
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
# CONFIG_STRICT_DEVMEM is not set

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
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
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
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--cKHKltVZF/Cv5AaO
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
commit'
	export queue='bisect'
	export testbox='vm-snb-i386'
	export tbox_group='vm-snb-i386'
	export branch='linux-devel/devel-hourly-20221106-042607'
	export commit='98ccdf3d86014216f3168d7f91ce37cfc31d8d8f'
	export kconfig='i386-randconfig-a016-20211202'
	export nr_vm=300
	export submit_id='6368ea96a5feb6a0eb385ba6'
	export job_file='/lkp/jobs/scheduled/vm-meta-297/boot-1-openwrt-i386-generic-20190428.cgz-98ccdf3d86014216f3168d7f91ce37cfc31d8d8f-20221107-41195-lmdl6f-2.yaml'
	export id='30bd89c05d03ee33975fb34d8bc3b62b25eaadb8'
	export queuer_version='/zday/lkp'
	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='4G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23400
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='openwrt-i386-generic-20190428.cgz'
	export compiler='gcc-11'
	export enqueue_time='2022-11-07 19:23:03 +0800'
	export _id='6368f1fba5feb6a0eb385ba8'
	export _rt='/result/boot/1/vm-snb-i386/openwrt-i386-generic-20190428.cgz/i386-randconfig-a016-20211202/gcc-11/98ccdf3d86014216f3168d7f91ce37cfc31d8d8f'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb-i386/openwrt-i386-generic-20190428.cgz/i386-randconfig-a016-20211202/gcc-11/98ccdf3d86014216f3168d7f91ce37cfc31d8d8f/2'
	export scheduler_version='/lkp/lkp/.src-20221106-224831'
	export arch='i386'
	export max_uptime=600
	export initrd='/osimage/openwrt/openwrt-i386-generic-20190428.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb-i386/openwrt-i386-generic-20190428.cgz/i386-randconfig-a016-20211202/gcc-11/98ccdf3d86014216f3168d7f91ce37cfc31d8d8f/2
BOOT_IMAGE=/pkg/linux/i386-randconfig-a016-20211202/gcc-11/98ccdf3d86014216f3168d7f91ce37cfc31d8d8f/vmlinuz-6.1.0-rc1-00115-g98ccdf3d8601
branch=linux-devel/devel-hourly-20221106-042607
job=/lkp/jobs/scheduled/vm-meta-297/boot-1-openwrt-i386-generic-20190428.cgz-98ccdf3d86014216f3168d7f91ce37cfc31d8d8f-20221107-41195-lmdl6f-2.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-a016-20211202
commit=98ccdf3d86014216f3168d7f91ce37cfc31d8d8f
vmalloc=256M initramfs_async=0 page_owner=on
initcall_debug
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
	export modules_initrd='/pkg/linux/i386-randconfig-a016-20211202/gcc-11/98ccdf3d86014216f3168d7f91ce37cfc31d8d8f/modules.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export meta_host='vm-meta-297'
	export kernel='/pkg/linux/i386-randconfig-a016-20211202/gcc-11/98ccdf3d86014216f3168d7f91ce37cfc31d8d8f/vmlinuz-6.1.0-rc1-00115-g98ccdf3d8601'
	export dequeue_time='2022-11-07 19:55:22 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-297/boot-1-openwrt-i386-generic-20190428.cgz-98ccdf3d86014216f3168d7f91ce37cfc31d8d8f-20221107-41195-lmdl6f-2.cgz'

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

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--cKHKltVZF/Cv5AaO
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--cKHKltVZF/Cv5AaO--
